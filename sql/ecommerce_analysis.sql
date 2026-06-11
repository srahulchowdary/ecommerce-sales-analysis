CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;
SHOW tables;
SELECT
COUNT(order_id) AS Total_Orders
FROM orders;
SELECT
ROUND(AVG(review_score),2) AS Avg_Rating
FROM order_reviews;
SELECT
ROUND(SUM(price),2) AS Total_Revenue
FROM order_items;
SELECT
ROUND(
SUM(
CASE
WHEN order_delivered_customer_date >
     order_estimated_delivery_date
THEN 1
ELSE 0
END
)*100.0/COUNT(*)
,2) AS Late_Percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;
SELECT
MONTHNAME(o.order_purchase_timestamp) AS Month_Name,
MONTH(o.order_purchase_timestamp) AS Month_No,
ROUND(SUM(oi.price),2) AS Revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY
Month_Name,
Month_No
ORDER BY Month_No;
SELECT
COUNT(*) AS Late_Orders
FROM orders
WHERE order_delivered_customer_date >
      order_estimated_delivery_date;
      SELECT
CASE
WHEN order_delivered_customer_date >
     order_estimated_delivery_date
THEN 'Late'
ELSE 'On-Time'
END AS Delivery_Status,

COUNT(*) AS Orders_Count

FROM orders

WHERE order_delivered_customer_date IS NOT NULL

GROUP BY Delivery_Status;
SELECT

CASE
WHEN o.order_delivered_customer_date >
     o.order_estimated_delivery_date
THEN 'Late'
ELSE 'On-Time'
END AS Delivery_Status,

ROUND(AVG(r.review_score),2) AS Avg_Rating

FROM orders o

JOIN order_reviews r
ON o.order_id = r.order_id

GROUP BY Delivery_Status;
DESCRIBE product_category_name_translation;
ALTER TABLE product_category_name_translation
CHANGE COLUMN `ï»¿product_category_name`
product_category_name TEXT;
DESCRIBE product_category_name_translation;
SELECT
pct.product_category_name_english,
COUNT(*) AS Delayed_Orders

FROM orders o

JOIN order_items oi
ON o.order_id = oi.order_id

JOIN products p
ON oi.product_id = p.product_id

JOIN product_category_name_translation pct
ON p.product_category_name =
   pct.product_category_name

WHERE o.order_delivered_customer_date >
      o.order_estimated_delivery_date

GROUP BY pct.product_category_name_english

ORDER BY Delayed_Orders DESC

LIMIT 10;
SELECT
    c.customer_state,
    ROUND(SUM(oi.price),2) AS Total_Revenue

FROM customers c

JOIN orders o
    ON c.customer_id = o.customer_id

JOIN order_items oi
    ON o.order_id = oi.order_id

GROUP BY c.customer_state

ORDER BY Total_Revenue DESC

LIMIT 5;
SELECT
    c.customer_state,
    COUNT(o.order_id) AS Total_Orders

FROM customers c

JOIN orders o
    ON c.customer_id = o.customer_id

GROUP BY c.customer_state

ORDER BY Total_Orders DESC;
SELECT
    pct.product_category_name_english,
    ROUND(SUM(oi.price),2) AS Revenue

FROM order_items oi

JOIN products p
    ON oi.product_id = p.product_id

JOIN product_category_name_translation pct
    ON p.product_category_name = pct.product_category_name

GROUP BY pct.product_category_name_english

ORDER BY Revenue DESC

LIMIT 5;
SELECT

CASE
    WHEN o.order_delivered_customer_date >
         o.order_estimated_delivery_date
    THEN 'Late'
    ELSE 'On-Time'
END AS Delivery_Status,

ROUND(SUM(oi.price),2) AS Revenue

FROM orders o

JOIN order_items oi
    ON o.order_id = oi.order_id

GROUP BY Delivery_Status;
SELECT

MONTHNAME(order_purchase_timestamp) AS Month_Name,
MONTH(order_purchase_timestamp) AS Month_No,

COUNT(order_id) AS Total_Orders

FROM orders

GROUP BY Month_Name, Month_No

ORDER BY Month_No;
SELECT

MONTHNAME(order_purchase_timestamp) AS Month_Name,
MONTH(order_purchase_timestamp) AS Month_No,

ROUND(
    SUM(
        CASE
            WHEN order_delivered_customer_date >
                 order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(*),
2) AS Late_Percentage

FROM orders

WHERE order_delivered_customer_date IS NOT NULL

GROUP BY Month_Name, Month_No

ORDER BY Month_No;
SELECT

MONTHNAME(o.order_purchase_timestamp) AS Month_Name,
MONTH(o.order_purchase_timestamp) AS Month_No,

ROUND(
    SUM(oi.price) /
    COUNT(DISTINCT o.order_id),
2) AS Avg_Order_Value

FROM orders o

JOIN order_items oi
    ON o.order_id = oi.order_id

GROUP BY Month_Name, Month_No

ORDER BY Month_No;
SELECT

c.customer_state,

MONTHNAME(o.order_purchase_timestamp) AS Month_Name,

COUNT(o.order_id) AS Total_Orders

FROM customers c

JOIN orders o
    ON c.customer_id = o.customer_id

WHERE MONTH(o.order_purchase_timestamp) IN (8,9)

GROUP BY
    c.customer_state,
    Month_Name

ORDER BY c.customer_state;
SELECT

pct.product_category_name_english,

MONTHNAME(o.order_purchase_timestamp) AS Month_Name,

COUNT(o.order_id) AS Total_Orders

FROM orders o

JOIN order_items oi
    ON o.order_id = oi.order_id

JOIN products p
    ON oi.product_id = p.product_id

JOIN product_category_name_translation pct
    ON p.product_category_name = pct.product_category_name

WHERE MONTH(o.order_purchase_timestamp) IN (8,9)

GROUP BY
    pct.product_category_name_english,
    Month_Name

ORDER BY Total_Orders DESC;
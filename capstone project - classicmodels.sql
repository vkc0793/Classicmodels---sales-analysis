
/* ============================================= Capstone Project - Classicmodels ================================================================== */

-- 1) write a query to find sales representatives who having maximum no of customers.

select count(c.customerNumber)as no_of_customers, c.salesRepEmployeeNumber,
concat(e.firstName,' ',e.lastName) as Sales_Rep_Names
from customers c
inner join employees e
on c.salesRepEmployeeNumber = e.employeeNumber
group by salesRepEmployeeNumber 
order by count(c.salesRepEmployeeNumber) desc;

select * from customers where salesRepEmployeeNumber is null;

-- ==================================+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++==

-- 2) Write a query to display countries having most no.of customers?

select count(customerName) as cnt, country
from customers 
group by country 
order by cnt desc;

-- =====================================================================================================================================================

-- 3) write a query to display top 10 highest creditlimit?

select customerName, creditLimit, country from customers order by creditLimit desc limit 10;


-- =================================================================================================================================================
-- 4) write a query to find employee who reports to their heads?
select concat(e1.firstName,' ',e1.lastName) as fullname, concat(e2.firstName,' ',e2.lastName) as reportby,
e1.jobtitle,e2.jobtitle from employees e1, employees e2
where e1.employeeNumber=e2.reportsto;

select * from employees where jobtitle = "president";

-- ===================================================================================================================================================
-- 5)Which are top 5 countries with the highest average monthly revenue production?
select * from customers;
select * from orderdetails;
select * from orders;

select sum(od.quantityOrdered*od.priceEach) as total_revenue, c.country
from customers c
inner join orders o
on c.customerNumber=o.customerNumber
inner join orderdetails od
on o.orderNumber=od.orderNumber
group by c.country
order by total_revenue desc; 
-- ===================================================================================================================================================
-- 6) list all orders that shipped after the required date?
select * from orders where shippedDate > requiredDate; 
-- ====================================================================================================================================================
-- 7) List all productlines and vendors that supply the product's in that productlines?
select * from productlines;
select * from products where productVendor = 'Second Gear Diecast';

select pl.productLine, p.productVendor
from productlines pl
inner join products p
on pl.productLine=p.productLine;

-- =====================================================================================================================================================
-- 8) List the product that didn't sell?
select * from products;
select * from orderdetails;

select * from products where productCode not in ( select productCode from orderdetails);

-- ========================================================================================================================================================
-- 9) List all total of all payments made by each customers?
select * from payments;
select * from customers;

select sum(p.amount) as total_payment, c.customerName
from payments p 
inner join customers c 
on c.customerNumber=p.customerNumber
group by c.customerName
order by total_payment desc;
-- =====================================================================================================================================================
-- 10) What are total no.of products per productlines?
select count(productName)as cnt_product,
productLine from products group by productLine order by cnt_product desc;
-- ======================================================================================================================================================
-- 11) List of all the offices and the no.of employees working in each of offices?

select * from offices;
select * from employees;
select count(e.employeeNumber)as no_of_employees, o.city
from employees e 
inner join offices o 
on e.officeCode=o.officeCode
group by o.city;
-- ====================================================================================================================================================
-- 12) list of product and profit that we have made?

select * from products;
select * from orderdetails;

select ((o.priceEach-p.buyPrice)*(o.quantityOrdered)) as profit, p.productName
from products p 
inner join orderdetails o 
on p.productCode=o.productCode
order by profit desc;

-- =======================================================================================================================================================
-- 13) list the customerName and the total orders across all orders that the customer have placed?

select * from customers;
select * from orderdetails;
select * from orders;

select c.customerName, sum(od.quantityOrdered*od.priceEach)as total_orders
from customers c 
inner join orders o 
on c.customerNumber=o.customerNumber
inner join orderdetails od 
on od.orderNumber=o.orderNumber
group by c.customerName
order by total_orders desc;

-- ====================================================================================================================================================

-- 14) What is the customers and sales person of the highest priced order?
select * from customers where salesRepEmployeeNumber = 1370 and customerNumber = 141;
select * from employees where employeeNumber = 1370;
select * from orderdetails;
select * from orders;


select c.customerName,c.salesRepEmployeeNumber,concat(e1.firstName,' ',e1.lastName) as sales_rep,sum(od.quantityOrdered*od.priceEach) as total_price
from customers c 
inner join orders o
on c.customerNumber=o.customerNumber
inner join orderdetails od 
on o.orderNumber=od.orderNumber
inner join employees e1 
on c.salesRepEmployeeNumber=e1.employeeNumber
group by c.customerName,c.salesRepEmployeeNumber,sales_rep
order by total_price desc;

-- =========================================================================================================================================================

-- 15) write q query to find the managers who as most no.of employees?

select concat(e1.firstName,' ',e1.lastName) as fullname, count(concat(e2.firstName,' ',e2.lastName)) as no_ofemployees
from employees e1, employees e2
where e1.employeeNumber=e2.reportsto
group by fullname
order by no_ofemployees desc;

-- =========================================================================================================================================================
-- 16) Lets first look at classicmodel's biggest customers. Across all orders, which clients have spent the most amount of money?

select c.customerName, sum(p.amount) as total_spent
from customers c 
left join payments p 
on c.customerNumber=p.customerNumber
group by 1
order by 2 desc
limit 10;

-- ======================================================================================================================================================


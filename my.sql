-- Create EmployeeDetails table
CREATE TABLE EmployeeDetails (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    ManagerId INT,
    DateOfJoining DATE NOT NULL,
    City VARCHAR(50)
);

-- Insert sample data into EmployeeDetails
INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES (1, 'Tom Cruise', Null, '2023-01-01', 'Lake Hollywood Park'),
(2, 'Leonardo Dicaprio', 1, '2020-02-02', 'Los Feliz'),
(3, 'Denzel Washington', 1, '2020-03-03', 'Beverly Hills'),
(4, 'Morgan Freeman', 2, '2023-04-04', 'Midi-Pyrenees'),
(5, 'Tom Hanks', 2, '2020-05-05', 'Lie-De-France'),
(6, 'Chris Hemsworth', 4, '2020-06-06', 'Paris')

-- Create EmployeeSalary table
CREATE TABLE EmployeeSalary (
    EmpId INT PRIMARY KEY,
    Project VARCHAR(100),
    Salary DECIMAL(10,2),
    Variable DECIMAL(10,2)
);

-- Insert sample data into EmployeeSalary
INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES (1, 'Project A', 40000.00, 2000.00),
       (2, 'Project B', 30000.00, 1500.00),
       (3, 'Project C', 50000.00, 3000.00),
       (4, 'Project B', 60000.00, 3500.00),
       (5, NULL, NULL, NULL);





-- Q1 - Ans SQL Query to fetch records that are present in one table but not in another table.
SELECT *
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary);



-- Q2 --Ans SQL query to fetch all the employees who are not working on any project.
SELECT EmployeeDetails.*
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId
WHERE EmployeeSalary.Project IS NULL;



-- Q3 --Ans SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.
SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;



-- Q4 --Ans Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.
SELECT EmployeeDetails.*
FROM EmployeeDetails
INNER JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId;



-- Q5 -- Ans Write an SQL query to fetch a project-wise count of employees.
SELECT Project, COUNT(EmpId) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project;





--Q6 --Ans Fetch employee names and salaries even if the salary value is not present for the employee.
SELECT EmployeeDetails.FullName, EmployeeSalary.Salary
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId;




--Q7 --Ans Write an SQL query to fetch all the Employees who are also managers.
SELECT E1.*
FROM EmployeeDetails E1
JOIN EmployeeDetails E2 ON E1.EmpId = E2.ManagerId
ORDER BY E1.EmpId;




--Q8 --Ans Write an SQL query to fetch duplicate records from EmployeeDetails.
SELECT EmpId, FullName, ManagerId, DateOfJoining, City, COUNT(*) AS Count
-- SELECT FullName, COUNT(*)
FROM EmployeeDetails
GROUP BY EmpId, FullName, ManagerId, DateOfJoining, City
HAVING COUNT(*) > 1





--Q9 --Ans Write an SQL query to fetch only odd rows from the table.
SELECT *
FROM (
    SELECT ROW_NUMBER() OVER (ORDER BY EmpId) AS RowNum, EmpId, FullName, ManagerId, DateOfJoining, City
    FROM EmployeeDetails
) AS T
WHERE T.RowNum % 2 = 1






--Q10 --Ans Write a query to find the 3rd highest salary from a table without top or limit keyword.
SELECT Salary
FROM (
    SELECT Salary, ROW_NUMBER() OVER (ORDER BY Salary DESC) AS row_num
    FROM EmployeeSalary
) AS ranked
WHERE row_num = 3;

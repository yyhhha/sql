--lecture note
--1
select *
from emp
where sal in( select sal
             from (select distinct sal
                    from emp
                    order by sal desc) e
                    where rownum <=3);
            
--2
select d.deptno,d.dname,d.loc
        ,decode(count(e.deptno),0,'no','yes') as emp
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno,d.dname,d.loc;

--
select d.*,nvl((select 'yes'
            from emp
            where deptno =d.deptno
            and rownum =1),'no') as emp           
from dept d;

--º¯Çü

select d.*,nvl((select 'yes'
            from dual
            where exists (select 1
                            from emp
                            where deptno=30)),'no') as emp           
from dept d;
--3

select employee_id,first_name,department_id,salary
from employees
where (department_id,salary) in(    select department_id, max(salary)
                                    from employees
                                    group by department_id);
--quiz

select '1981/'||lpad(level,2,0)
from dual
connect by level <=12;


select b.hire ,nvl(a.cnt,0) cnt
from (select to_char(hiredate,'yyyy/mm') as hire, count(*) as cnt
        from emp
        where hiredate between to_date('1981/01/01','yyyy/mm/dd')
                                and to_date('1982/01/01','yyyy/mm/dd')-(1/86400)
        group by to_char(hiredate,'yyyy/mm')
        ) a
        ,(select '1981/'||lpad(level,2,0) as hire
        from dual
        connect by level <=12) b
where a.hire(+) = b.hire
order by 1;

--




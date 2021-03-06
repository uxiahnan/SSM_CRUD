<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("APP_PATH", request.getContextPath());%></>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee</title>
    <style>
        * {
            maring: 0;
            padding: 0;
        }

        .container {
            width: auto;
            height: auto;
            margin: 100px auto;
        }

        .row {
            margin-top: 10px;
        }

        #emps_table th, #emps_table td {
            text-align: center;
        }
    </style>
    <script src="${APP_PATH}/js/jquery-3.3.1.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- Modal更新模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Edit Employee</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="emp_name_input" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="emp_name_p"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_email_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="emp_email_input_update"
                                   placeholder="zhangsan@funnyboy.xyz">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="男" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId"> </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">Update</button>
            </div>
        </div>
    </div>
</div>
<%--添加模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Add New Employee</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="emp_name_input" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="emp_name_input"
                                   placeholder="张三">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_email_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="emp_email_input"
                                   placeholder="zhangsan@funnyboy.xyz">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="male_radio" value="男" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="female_radio" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId"> </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_btn">Add</button>
            <button class="btn btn-danger" id="emp_del_btn">Del</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th><input type="checkbox" class="check_all"></th>
                    <th>#</th>
                    <th>last name</th>
                    <th>email</th>
                    <th>gender</th>
                    <th>dept name</th>
                    <th>Operate</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="page_info_area"></div>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<script>
    var totalRecord;
    var currentPage;
    var success = "success";
    var error = "error";

    // jquery入口函数
    $(function () {
        to_page(1); //初次进入默认查询第一页
    });

    // 使用ajax技术发送和接收GET请求，分页查询员工信息
    function to_page(pg) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pg=" + pg,
            type: "GET",
            success: function (result) {
                $(".check_all").prop("checked", false);
                // 构建员工表信息
                build_emps_table(result);
                // 构建分页信息：包括当前页、总页数等
                build_page_info(result);
                // 构建分页导航栏
                build_page_nav(result);
            }
        });
    }
    // 构建员工表信息
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            // 多选按钮
            var $checkBtn = $("<td><input type=\"checkbox\" class=\"check_item\"/></td>");
            // 员工ID
            var $empIdTd = $("<td></td>").append(item.empId);
            // 员工姓名
            var $empNameTd = $("<td></td>").append(item.empName);
            // 邮箱
            var $emailTd = $("<td></td>").append(item.email);
            // 性别
            var $genderTd = $("<td></td>").append(item.gender);
            // 部门名称
            var $deptNameTd = $("<td></td>").append(item.department.deptName);
            // 编辑按钮
            var $editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("Edit");
            $editBtn.attr("empId", item.empId);
            // 删除按钮
            var $delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("Delete");
            $delBtn.attr("empId", item.empId);
            // 按钮单元
            var $btnTd = $("<td></td>").append($editBtn).append(" ").append($delBtn);
            $("<tr></tr>").append($checkBtn)
                .append($empIdTd)
                .append($empNameTd)
                .append($emailTd)
                .append($genderTd)
                .append($deptNameTd)
                .append($btnTd)
                .appendTo("#emps_table tbody");
        });
    }
    // 构建分页信息：包括当前页、总页数等
    function build_page_info(result) {
        $("#page_info_area").empty();
        var pageInfo = result.extend.pageInfo;
        $("<p></p>").append("Current page:" + pageInfo.pageNum + ", All pages: " + pageInfo.pages + ", All records: " + pageInfo.total)
            .appendTo("#page_info_area");
        totalRecord = pageInfo.total;
        currentPage = pageInfo.pageNum;
    }
    // 构建分页导航栏
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var pageInfo = result.extend.pageInfo;
        var $nav = $("<nav></nav>").attr("aria-label", "Page navigation");
        var $ul = $("<ul></ul>").addClass("pagination");
        $nav.append($ul);
        var $firstLi = $("<li></li>").append($("<a></a>").append("First"));
        var $previousLi = $("<li></li>").append($("<a></a>").attr("aria-label", "Previous")
            .append($("<span></span>").attr("aria-hidden", "true").append("&laquo;")));
        var $nextLi = $("<li></li>").append($("<a></a>").attr("aria-label", "Next")
            .append($("<span></span>").attr("aria-hidden", "true").append("&raquo;")));
        var $lastLi = $("<li></li>").append($("<a></a>").append("Last"));
        if (pageInfo.hasPreviousPage == false) {
            $firstLi.addClass("disabled");
            $previousLi.addClass("disabled");
        } else {
            $firstLi.click(function () {
                to_page(1);
            });
            $previousLi.click(function () {
                to_page(pageInfo.prePage);
            });
        }
        if (pageInfo.hasNextPage == false) {
            $nextLi.addClass("disabled");
            $lastLi.addClass("disabled");
        } else {
            $nextLi.click(function () {
                to_page(pageInfo.nextPage);
            });
            $lastLi.click(function () {
                to_page(pageInfo.pages);
            });
        }
        $ul.append($firstLi);
        $ul.append($previousLi);
        $.each(pageInfo.navigatepageNums, function (index, item) {
            var $numLi = $("<li></li>").append($("<a></a>").append(item));
            if (item == pageInfo.pageNum) {
                $numLi.addClass("active");
            } else {
                $numLi.click(function () {
                    to_page(item);
                });
            }
            $ul.append($numLi);
        });
        $ul.append($nextLi);
        $ul.append($lastLi);
        $nav.appendTo("#page_nav_area");
    }
    // 添加员工时弹出添加模态框
    $("#emp_add_btn").click(function () {
        // 每次调用模态框时重置表单信息
        $("#empAddModal form")[0].reset();
        $(".help-block").empty();
        $("#emp_save_btn").removeAttr("status1").removeAttr("status2");
        // 获取部门信息
        getDepts("#empAddModal select");
        // 弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });
    // 获取部门信息
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                $.each(result.extend.depts, function () {
                    var $option = $("<option></option>").attr("value", this.deptId).append(this.deptName);
                    $(ele).append($option);
                });
            }
        });
    }
    // 姓名合法性校验
    $("#emp_name_input").change(function () {
        var $emp_name_input = $("#emp_name_input");
        var empName = $emp_name_input.val();
        var regName = /^[a-z0-9_-]{6,16}$|^[\u2E80-\u9FFF]{2,5}$/;
        if (empName == "") {
            show_validate($emp_name_input, error, "员工名不能为空");
            $("#emp_save_btn").attr("status1", "error");
        } else if (!regName.test(empName)) {
            show_validate($emp_name_input, error, "用户名不合法");
            $("#emp_save_btn").attr("status1", "error");
        } else {
            $.ajax({
                url: "${APP_PATH}/validateuser",
                type: "POST",
                data: "empName=" + empName,
                success: function (result) {
                    if (result.code == 200) {
                        show_validate($emp_name_input, error, result.extend.msg);
                        $("#emp_save_btn").attr("status1", "error");
                    } else if (result.code == 100) {
                        show_validate($emp_name_input, success, "");
                        $("#emp_save_btn").removeAttr("status1");
                    }
                }
            });
        }
    });
    // 邮箱合法性校验
    $("#emp_email_input").change(function () {
        var $emp_email_input = $("#emp_email_input");
        var email = $emp_email_input.val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (email == "") {
            show_validate($emp_email_input, error, "邮箱不能为空");
            $("#emp_save_btn").attr("status2", "error");
        } else if (!regEmail.test(email)) {
            show_validate($emp_email_input, error, "邮箱不合法");
            $("#emp_save_btn").attr("status2", "error");
        } else {
            show_validate($emp_email_input, success, "");
            $("#emp_save_btn").removeAttr("status2");
        }
    });
    // 提交时再进行合法性校验
    $("#emp_save_btn").click(function () {
        if (!validate_add_form()) {
            return false;
        }
        if ($(this).attr("status1") == "error" || $(this).attr("status2") == "error") {
            return false;
        }
        var $emp_name_input = $("#emp_name_input");
        var empName = $emp_name_input.val();
        $.ajax({
            url: "${APP_PATH}/validateuser",
            type: "POST",
            data: "empName=" + empName,
            success: function (result) {
                if (result.code == 200) {
                    show_validate($emp_name_input, error, result.extend.msg);
                    $(this).attr("status1", "error");
                    return false;
                } else if (result.code == 100) {
                    show_validate($emp_name_input, success, "");
                    $(this).removeAttr("status1").removeAttr("status2");
                    saveEmp();
                }
            }
        });
    });
    // 非空校验
    function validate_add_form() {
        var $emp_name_input = $("#emp_name_input");
        var empName = $emp_name_input.val();
        var $emp_email_input = $("#emp_email_input");
        var email = $emp_email_input.val();
        if (empName == "") {
            show_validate($emp_name_input, error, "员工名不能为空");
            return false;
        } else if (email == "") {
            show_validate($emp_email_input, error, "邮箱不能为空");
            return false;
        }
        return true;
    }
    // 显示校验信息
    function show_validate(ele, status, msg) {
        emptyInfo(ele);
        if (error == status) {
            ele.parent().addClass("has-error");
            ele.next("span").append(msg);
        } else if (success == status) {
            ele.parent().addClass("has-success");
            ele.next("span").append(msg);
        }
    }
    // 2. 校验成功后添加员工信息
    function saveEmp() {
        $.ajax({
            url: "${APP_PATH}/emps",
            type: "POST",
            data: $("#empAddModal .form-horizontal").serialize(),
            success: function (result) {
                if (result.code == 200) {
                    if ("undefined" == result.extend.result.empName) {
                        show_validate("#emp_name_input", error, result.extend.result.empName);
                    }
                    if ("undefined" == result.extend.result.email) {
                        show_validate("#emp_email_input", error, result.extend.result.email);
                    }
                } else if (result.code == 100) {
                    $("#empAddModal").modal("hide");
                    to_page(totalRecord);
                }
            }
        });
    }

    function emptyInfo(ele) {
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").empty();
    }

    // 弹出编辑模态框
    $(document).on("click", ".edit_btn", function () {
        $("#empUpdateModal form")[0].reset();
        $(".help-block").empty();
        // 获取部门信息
        getDepts("#empUpdateModal select");
        // 获取当前员工信息
        getEmp($(this).attr("empId"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });
    // 查询单个员工数据
    function getEmp(empId) {
        $("#emp_name_p").empty();
        $.ajax({
            url: "${APP_PATH}/emp/" + empId,
            type: "GET",
            success: function (result) {
                var emp = result.extend.emp;
                $("#emp_name_p").text(emp.empName);
                $("#emp_email_input_update").val(emp.email);
                $("#empUpdateModal input[name=gender]").val([emp.gender]);
                $("#empUpdateModal select[name=deptId]").val([emp.deptId]);
                $("#emp_update_btn").attr("empId", emp.empId);
            }
        });
    }
    // 邮箱校验
    $("#emp_email_input_update").change(function () {
        validate_email(this);
    });
    function validate_email(ele) {
        var email = $(ele).val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate($(ele), error, "邮箱不合法");
            $("#emp_update_btn").attr("status", "error");
            return false;
        } else {
            show_validate($(ele), success, "");
            $("#emp_update_btn").removeAttr("status");
            return true;
        }
    }
    // 确认更新后进行再校验并更新员工数据
    $("#emp_update_btn").click(function () {
        if ($("#emp_email_input_update").val() == "") {
            return false;
        }
        if ($(this).attr("status") == "error") {
            return false;
        }
        var empId = $(this).attr("empId");
        updateEmp(empId);
    });
    <%--// 1. 更新单个员工数据--%>
    <%--function updateEmp(empId) {--%>
        <%--$.ajax({--%>
            <%--url: "${APP_PATH}/emp/" + empId,--%>
            <%--type: "POST",--%>
            <%--data: $("#empUpdateModal form").serialize() + "&_method=PUT",--%>
            <%--success: function (result) {--%>
                <%--console.log(result.extend.success);--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>
    // 2. 更新单个员工数据
    function updateEmp(empId) {
        $.ajax({
            url: "${APP_PATH}/emp/" + empId,
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                $("#empUpdateModal").modal("hide");
                to_page(currentPage);
            }
        });
    }
    // 删除员工信息
    $(document).on("click", ".del_btn", function () {
        var empId = $(this).attr("empId");
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if (confirm("You want to delete [" + empName + "] ?")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    if (result.code == 200) {
                        alert("Delete failed");
                    } else if (result.code == 100) {
                        alert("Delete success");
                        to_page(currentPage);
                    }
                }
            });
        }
    });
    // 多选删除
    $(".check_all").click(function () {
        $(".check_item").prop("checked", $(this).prop("checked"));
    });
    $(document).on("click", ".check_item", function () {
        var flags = $(".check_item:checked").length == $(".check_item").length;
        $(".check_all").prop("checked", flags);
    });
    $("#emp_del_btn").click(function () {
        var empNames = "";
        var empIds = "";
        $.each($(".check_item:checked"), function () {
            var empId = $(this).parents("tr").find("td:eq(1)").text();
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            empNames += empName + ",";
            empIds += empId + "-";
        });
        empNames = empNames.substring(0, empNames.length - 1);
        if (confirm("You want to delete[" + empNames + "]")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + empIds,
                type: "DELETE",
                success: function (result) {0
                    if(result.code==200) {
                        alert("Delete failed");
                    }else if(result.code ==100) {
                        alert("Delete success");
                        to_page(currentPage);
                    }
                }
            });
        }
    });
</script>
</body>
</html>

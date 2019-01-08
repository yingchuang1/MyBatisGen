<#include "common.ftl">

/**
* Author:${author}
*/
package ${mapperInterfacePackage};

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import ${modelPackage}.${tableNamePojoNameMap[tableName]};

@Mapper
@Repository
public interface ${tableNamePojoNameMap[tableName]}Mapper {
    <#-- 如果表有2个列做为联合主键，如user_id, role_id，则生成selectByPk和deleteByPk的方法签名会生成为：(Integer userId, Integer roleId) -->
    <#assign methodSignature = "" />
    <#if pksMap[tableName]?? && pksMap[tableName]?size != 0>
        <#list pksMap[tableName] as columnName>
            <#assign columnJavaType = columnJavaTypeMap[tableName + "|" + columnName] />
            <#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />

            <#if columnName_has_next>
                <#assign methodSignature = methodSignature + columnJavaType + " " + columnJavaName + ", "/>
            <#else>
                <#assign methodSignature = methodSignature + columnJavaType + " " + columnJavaName />
            </#if>
        </#list>
    </#if>

    public List<${tableNamePojoNameMap[tableName]}> select(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public List<${tableNamePojoNameMap[tableName]}> selectPage(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public Integer selectCount(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public ${tableNamePojoNameMap[tableName]} selectByPk(${methodSignature});
    public void insert(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void update(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void updateWithNull(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void deleteByPk(${methodSignature});
    public void deleteByPojo(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
}
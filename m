Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6C848B662
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350453AbiAKTAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:00:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33614 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350391AbiAKTA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:00:29 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BI29A4021898;
        Tue, 11 Jan 2022 19:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ihfib3/XvJXH6M4ZeOUkVYVjoroTp4Pp2GUuR+aIArQ=;
 b=mxI07t8kFh0hu35faN9O7x0LsEr65D6VtUt9uDs4kF8Fa/fnBRJQJMP1bImDRhzn9Mmk
 iAFA+5jAmQh/Oq67BIMC5lRntYGy4fjYfmc53Hhu6HZZEcfEcxlmZIqw3Uy4j4dAOLSL
 FNlZ/GfXkjigpuomwMLUAaPO4Og4sFztve+bQtFmGUYZTF5jYMJOzewcHhI96B3bOFYH
 jRUoFHNXncKqyrNx7hscN+7s5Z9CsH+mjtMQ21ucOeLPS/tDz5vWOgH8QvjayOGhFNfr
 Q+v+mqLdPLknxDLPgfCR2oQTwQBZdzHWZm12QdW+li57+WDBALBrmP83Q6jIFdr0pOLF iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbvbp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 19:00:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BJ0AW8034629;
        Tue, 11 Jan 2022 19:00:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3030.oracle.com with ESMTP id 3deyqxmg1b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 19:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kehzmpxHE7c9bQZyOmAT+g1ydMtiJfJprGSAL+jISfqcCSbJ7JA+2W+Xl3eugoWuQ5WTKvHRO22cp+4XTGtbmALUdETSvEqIhvOn0R5jEXmcbHMxyUMVc/TjsErVwFbSNYI3oZg84wr+cGYrcp4f1tVJP16LdX9GdRnUyd1u67h9c++/j2DH9wqx7/W09mZrKM26Hp1si7lJGZGmJwfGXzEezW8Ths90TaHgRR3qEST7OC6RnwiubsGoorpn3uC7wHbULlYzGi4p2CX5bkJa2UwiNoF84k/yc/JwnsTxVqwOtZb3lxq/s24Q+8wiKPTR2kdY6FVtIkWmuvI9fgR7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihfib3/XvJXH6M4ZeOUkVYVjoroTp4Pp2GUuR+aIArQ=;
 b=nr82+vs5w/e927rR8DPJCjxa0xk+kIbcuTVr6rodQJavG0fIAwIwQIOT9iRiQLZjMDN0PzD7ICLFdU7g4duLbFcUD20vXyi9/2clhxRP7UkhVS8Mmzu/YihAu+x99TLWEin5/lyBDATnW2WBpid96nP2AuEuM+4D9ABClemENactEwNTVO1mHQQ1oXWjCUu5eLQybHeavyr0r7Sn9qIuOUABf9mKjneztjAFeEEYp3TXgq/nCXHzWc1e9yXFj2utwocep6z8XYeAjD/Chzk6gpdkKiFmbXGUalBedjAEXbz7T3tGHkSL24dLjyRBQKt0ia4wx93yfLDx95DLzf4peA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihfib3/XvJXH6M4ZeOUkVYVjoroTp4Pp2GUuR+aIArQ=;
 b=DWYjJV5WtO+m7M4RBry8pkPbFN16u1HZms8hpQcssutpIVVVpjB91i+SW1yYCJHLZqcAWcVJZQ7M9ZamIYlA8Z8OF8Orz1KffXbCnsy7aqqR06/GB+XLmRCqIh9jHexd7oCsN5JUNS4zMMoGcEbMCvCsn3ZC5ZmdeUMFZwFw4Qw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 19:00:06 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 19:00:06 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v3 7/7] pmem: fix pmem_do_write() avoid writing to 'np' page
Date:   Tue, 11 Jan 2022 11:59:30 -0700
Message-Id: <20220111185930.2601421-8-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220111185930.2601421-1-jane.chu@oracle.com>
References: <20220111185930.2601421-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78961368-bcfc-4161-d875-08d9d5349491
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4495:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4495CCF217247BBCE652B69AF3519@SJ0PR10MB4495.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bO3exSQ2EZPaBRWzZILT4c+eLHGPyxAwv9CERdyznfNcamZd4Ln5Khyu1ngxRoxf26u+q24QQ6sgom9hjYkIBCdgtejBH2Gvq5s95ybhdgAV1HMdUqUvONNTFrrIaQedQe30IWzSnYC0MfOKk0bHyWqVuXVjK37/v1kUyaQBZ9ece0IHkw3CvZm20k/2FsbXkKBzcbDkVI5mcbZBY3Mg3n4nU4Wcc9UFRUtN3zSv9s27hqBJvER4+yjXav8svYOXRUKSrROnqyWZB6X8hrAVd9dujH8Z/zhUTuLKKoSRxsDY9cZmkJgF3BIuFJ23m5JgVvilsezJsDbSuq87R2C1lWSlVhMwDoA3N9UdZgH2Opl/0hxTiMdWsA8ZiWFkwgBsPBhnEsUxTmsXPXEd6RDi09rFxcpKg2YfYdvJohDLnph7aIEIEPCQm/6DQNAQuEC+aLZLA2WDMUqMnsKCUn98kna7gO5pQZUJVOd+x6I4jtWq0mTHEP/OZLocxIxlQG4hUIPwsEB6u7hgEoYHZwDXAHkPx9w7QXjuY7IT9MsDdioEa3aMcfFV0pJ+jn7s7WJPjlO/Ck3GfmMrDPCL4F3x/NjJDF6jfHLX798hV4SLcBLd/Qqd8pqfb2jZ9eRK0ovycljDQwdmMC5FCfSnqcsqX61eA8plgb/vacZZAhZwZ0TR1ysHYVYA0CzH/D3es9/u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(6666004)(5660300002)(4744005)(83380400001)(6486002)(36756003)(38100700002)(2906002)(66556008)(921005)(66476007)(66946007)(7416002)(52116002)(186003)(8676002)(508600001)(8936002)(6506007)(6512007)(316002)(44832011)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cn4W4Wffqelx+Nok6anZbGQxSgu+3g6z5f347IClPt+K/p1J8kldXyo8x105?=
 =?us-ascii?Q?1QqsEy+UZnsKQ12x6wtgIdQPxBJRZcfcb4EqmzeK5zgj7ngnzIy3O8/7wvrc?=
 =?us-ascii?Q?JuoH/U/Emq1P/z9EfbQc8SRnHpVMlXIIzkH/kWL3I4PLwSINSJgYCuJcgEqL?=
 =?us-ascii?Q?vhBNWSPXZ49p5nRy6XvIJNHNurDSFblYmD/+Mlmwjx8nWZ5Y54p5bYQ8rNwA?=
 =?us-ascii?Q?rLwWKMC2M17BJIrmAswYChZUTFM4nh5pGxTDufyplqGWD53LsfB0coDXUfYe?=
 =?us-ascii?Q?jHy+eVypExVYwAOuCGwE8F3poGiMyEe8b7ThJhqTFwWUdzcdTELO05En9t/u?=
 =?us-ascii?Q?b1tt9B9nVK5thogB9ZPkhXmWAdTXDkW6eD+MqJ6R5MrpvZUo4b+BTXbcPJnz?=
 =?us-ascii?Q?VNK0LylSAVHqWAxgVKA1BUo/VOqRIUQ3gYo/Do+A0ZsF1L2AVDsXyaYn6IKW?=
 =?us-ascii?Q?sAaIL27awsjEpl/Koa7c/clB+kMGsWDvfrtUdpHNVuPBLia8TDhZ6iXID/0h?=
 =?us-ascii?Q?hmIFOwSiw1ujWwgkJs+ZSEC4hlN1i+6/3O4/SD/cRZULs0ukLz2JzcHvOd/c?=
 =?us-ascii?Q?MwrY5SGFt3iaSXcICzJx7dLvICFzrAwjaWViusg5TE4xBzyhtFjE6DwSgTS4?=
 =?us-ascii?Q?qoJwdqDxW92EuJGcZiBDjgRpD8tRLPGa1cSYkneO4vfDwUEUaIhE2OVvLJCO?=
 =?us-ascii?Q?c8DvyBfqCxYzZD9u+JLPPdLcNQZl3K0JQQniiDXqhxW1AnF0Egn6v4p3/WEI?=
 =?us-ascii?Q?Z4epU+BCBHtzeFu9IkC5YBVACvmmSISJP8Mj2fkPqro9wmeEPvdo8LLls92K?=
 =?us-ascii?Q?byln/CsiZQse+Hlk8XGd08RI+o2Z+NM34SeTjqtTKT73V13vpgi0FkMw++ew?=
 =?us-ascii?Q?fOBlxqbjxLKREZZBoBfDiVGaiY+1aeZewdl2adAyb8o1hbJsZtzIvcmCDyMB?=
 =?us-ascii?Q?HNSBx0v3YEMIRYUVN5E3YOmt0wsDvjbufYJGwezwj3IUzbCrgEJ1k+rS9ttl?=
 =?us-ascii?Q?a+1xJWsiHIYBA8kUN+817zvNY6RlY7gpE4iJg/g5cc1pZYJdPSBHdIGztsUy?=
 =?us-ascii?Q?D9gRxH7D+Xw3QtifTUT1hH9qCKuUIlne89KbTTF9838wuWAqeHAqCtuj7Nww?=
 =?us-ascii?Q?PzQZP+qv/haQmg2Imh7t2sTyxQR+d3BafBLfVOS5yrFyBLXiXrkMhazSsANl?=
 =?us-ascii?Q?cx1MjnVqb5xEj4tXoGn/8pAjHV619+0sPdVpYU+U8uf5O2o+dgTi5JTP4WDB?=
 =?us-ascii?Q?BM8vFkvDecl1LF2Z4eP00Hbnu0CrqxLaUc+rulBBtzD8QPVC1CS088n3xuVh?=
 =?us-ascii?Q?i25594KqoaH3lFEMFGPvkNTU1EWyJTQqL4p+dRoedf9aflhHqlbyLqKd0aow?=
 =?us-ascii?Q?cBcqYNBu/0ojGhERk8vXOHy7sfxujyJpmjC4edhsRwiySOwBRyWjiARl31Lf?=
 =?us-ascii?Q?QPZ/SQXvWHtLJn6uVx+A6uiEq2hIgVx2bKyWKsKYgAXBUqk99KMz0j/kWQ/e?=
 =?us-ascii?Q?HTD0K35/hKpqg3Ifbh2cKI1dRhUniIkLpsxeP+PgaqwAa5bdZ0HeVEQ+qorG?=
 =?us-ascii?Q?j1oYD7/LgXZUQ9lsLDYyg4mr2BOOx6ueItBhGzGVJrBlYyIEeEHF4G4F3jbp?=
 =?us-ascii?Q?3H4wTpJr7DQDigMtm3kheKi2hf75DBWJN+kRU2kbLZIV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78961368-bcfc-4161-d875-08d9d5349491
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 19:00:06.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZFzvJ8WeYL9it8S4yw+o0N14TEIKesiBPcFPBfDWmMnWPa3v4jLoLwiBFEWNeS6WcpCwpgXmFLJHcmsYvmQMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110102
X-Proofpoint-GUID: raBzGuXltzm9pvEsjZuwETW8Z3S3bzIb
X-Proofpoint-ORIG-GUID: raBzGuXltzm9pvEsjZuwETW8Z3S3bzIb
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since poisoned page is marked as not-present, the first of the
two back-to-back write_pmem() calls can only be made when there
is no poison in the range, otherwise kernel Oops.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index dd2db4905c85..6e395014da5e 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -187,10 +187,15 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 	 * after clear poison.
 	 */
 	flush_dcache_page(page);
-	write_pmem(pmem_addr, page, page_off, len);
-	if (unlikely(bad_pmem)) {
-		rc = pmem_clear_poison(pmem, pmem_off, len);
+	if (!bad_pmem) {
 		write_pmem(pmem_addr, page, page_off, len);
+	} else {
+		rc = pmem_clear_poison(pmem, pmem_off, len);
+		if (rc == BLK_STS_OK)
+			write_pmem(pmem_addr, page, page_off, len);
+		else
+			pr_warn("%s: failed to clear poison\n",
+				__func__);
 	}
 
 	return rc;
-- 
2.18.4


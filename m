Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB449D44A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 22:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiAZVMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 16:12:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55656 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232369AbiAZVML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:12:11 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKZ2bT013145;
        Wed, 26 Jan 2022 21:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Ks1lDdZOoeu+ebY6MNA+Kn7IVzJQAEX4+SArnEKkR/M=;
 b=1IGzok+6iDZRETzaYLGB/q6KL0hp7DZRhB7+QULb9ieSXsKiyhm3KM0JFaXXj2osVXIL
 55aC+MBwO0ecE82f/BzUd9tKII6fGK3GR4FuA6+yCJ6L33JN5pyL0cmrf6sUdMknxcU+
 5uuT19iBRYZ+a33JNh+BQIBuzvHYui0YVTnZ8nACxs4BIASltoloZzEOlW6FbfoKS5/8
 AxxREpfSxaqQKsuOGUklnSnFpVqflsxBJxC9qkUlIYoDh7HaUUzBDG81lzJZBmt0E77h
 8TFpCJM4gt7Gl0lmwDDvQQCS85vo4amUSo01HwZnW3DAHEJHHkmUnOMFYDG6QfThNeL1 ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjfuyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:12:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QL5Mxw082682;
        Wed, 26 Jan 2022 21:12:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 3dr7yjfe7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIkWxT3UZ6UlILBSM31DnVWbWO4JI+lEfHClG4aWqr7rTAFjepAjX8sadd907K++TFhdL8geA3Y3YRy5hHh/VUZdhnfSt3OGGq2tA0RiAvxXFCi82lTWFPguMAqp+nMrX8lUN2QtAJTkO2vqOV6UPT3r7nWf5gFGLfPVvAIvUBkxoKLXurh/BNuysqa5EaW9JJ3Hy4rwG7zp/ghF3HgUu20PizAIYAk7oroF5PMZDqyGeOAiZrYaFSTbqFG1wM2FuoJomkBbaGr1fP6KT4nmMFwkAhXNcTaC41ajjR9+QvUCgHMiVW+V0UKp732p8e1AMnbqz+BtY/kLTQh2If2THg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks1lDdZOoeu+ebY6MNA+Kn7IVzJQAEX4+SArnEKkR/M=;
 b=F72KBFEXnAoBsLiM6ZJhqzcg7Fxjj6m9nHpEnrvUsY7xUWV277bGTJKj2A4kI/gKj/7zs3IDcRp8wsFG+KmO1ignZEpNcKve/on8Ocq/aZZugJ6W4ayOPp/M35BFtic4mGh/XYRM2UNAVcgHOoQzfglD48SwZZJhmK6UFkw4sZrEumxeGtfAB2Cintz+zfz5S5riVqlje+laKmsqragRZlr2zzCAaGLFAu0lXNPANPI6+3oOS9mmWcSu/AW6G5x8S4w4NRf5ymtOg6hHiBjnGnLDTTeyFcBgxMctvm18sl9CFIgLpWInsh45xlZpT7GhTTglgHSuUkJwfJ0MQzpocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ks1lDdZOoeu+ebY6MNA+Kn7IVzJQAEX4+SArnEKkR/M=;
 b=gMHo8GB4gsjtbO7C7/2kqND49BbYlXkwdRAJ0lcWkIwf2hrhfFKXkskYKduORQbJjd2RigEPmQhu3+QCXXemEKIsstHTvorFTke/xFWAM9vxIJ6RWFRPHA7MXqyf+iti2EBP7ir5SuKzB2aWr3eH0uWc5oySmfjDnL4zXeQRi2I=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3368.namprd10.prod.outlook.com (2603:10b6:a03:150::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 21:11:58 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 21:11:58 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v4 7/7] pmem: fix pmem_do_write() avoid writing to 'np' page
Date:   Wed, 26 Jan 2022 14:11:16 -0700
Message-Id: <20220126211116.860012-8-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126211116.860012-1-jane.chu@oracle.com>
References: <20220126211116.860012-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:806:24::27) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0614ab3e-3043-4797-844a-08d9e1107cee
X-MS-TrafficTypeDiagnostic: BYAPR10MB3368:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB336806D94FE5FF7C1EA07ED2F3209@BYAPR10MB3368.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKXbLBbM4GvlADn5ig1hchTxvfvvhDKEwQExu6dX21v9Al6ti/0N2EcRO9lcjI2uDZ8bD9MHbELZbylTAcC47XVX8bC2ce0V01OKFy/QwfazSEfwC+Gug9x1RRJUzaE3zRn7NjbZZkyZpJpOgvi/A9cZhs+9UCvu8z6o1D6ZN97uM5kz6mhS86cuwpyVdltwat73Eqr3ovO19tvfVcG9yS1iBDlS3fuf+xgwjLuTeXGzKCbp7LtnZdv0rBSSe9Dl9RIRDVlBM0BMiIETnhVyAFAwHi27nl21R/0Uxfhu4VjYWIDkHL2HLhiWStPwbdMXJNlVaohNMfkEsEf6tQ21MMTfIlI443N3pMfG2Uk6lHU7/hhxCJ/xvKnvxzwXomNMC1I89d2cURqrF1ysTaNy3hCpZpUTM/nIsTY2hm6QZjIyH3VduReJ2cK3yJXrGPYIs2yZh5+8vZLMcKtPNTtQiFLaX/DN0dfl4S2/s2H+bnSLD3jvzzLxauzUN88lIljJaFnTrCfPQB8PTncAT86WSurz4jirpf5yBBO7TQcjGVAJpx4+EBqn+2OLQNug3IHRnuQXKri8JYffbEgzCuTwxINYL0Ho4QbORW/sUsZDTNIqcgoHK8VVM81HSZkbpUec0X6k2FWXpMKmhssp5xzCgsU/hZ/blO0MN4fJfahVUhJUHQVGhFzoxud3t0+QPxaK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(316002)(7416002)(52116002)(6506007)(38100700002)(2616005)(8676002)(5660300002)(6666004)(86362001)(44832011)(8936002)(66556008)(2906002)(186003)(4744005)(6486002)(921005)(1076003)(508600001)(83380400001)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EacyS6jr+wnJ1/UTCSK2YIg9Y0Dm0/yjVXKKRXP0YXOc6vdqzs4ut3ENUm+z?=
 =?us-ascii?Q?f5hXlxO6u6ktJo7J9dZu0XBWvhPW65uL+9slRozPUVe/5juQ0GxyMR2duKei?=
 =?us-ascii?Q?aeA/4UYjchQEgb5L9Ww1WTRV8W+LpJXUyMH5NswDmVsYb83BHpsIpTbQZ50C?=
 =?us-ascii?Q?NkIBUF8GZ0DmXsOW0EFKYRqwv4lXdjqfS8GZmm1MTHGQ61/eJa9R7wdJESOp?=
 =?us-ascii?Q?zMty8NVG2Nkop35gioDy6Emv1hiqxvbMySGvv6aw0MnF7nZzLQ+uYPi70ktI?=
 =?us-ascii?Q?ni7a4MFHvoN12dGvPlYF+O7epvmPBGzq2xf609Cz3nRf9YUNoyNuFT5TVli5?=
 =?us-ascii?Q?DVAC9iq69V7qhag2Y9oTJ2yTAKG2pnWP7Sk4hhy7Z3xCVB4wrreTkfrlq3V3?=
 =?us-ascii?Q?C9Uj9EmEXoBzajgqAQguTrH9pyZqut91Gg9kLqBRKQkTYnP4fwnS3Jd77z/Z?=
 =?us-ascii?Q?c5RFyQWMYT75mVlQCIm5MsAfxJXQd/lfNawlkG/+1NV/DyVzD1mRiyqxU5gr?=
 =?us-ascii?Q?qmdFhOyxLqvlwCwUsNwFJnhseE0E1W3FvG2wD9YR5X3Lw68mC00e0fY5QSx5?=
 =?us-ascii?Q?Z3Q3q4pWijCzXbYJuzRVIy7XGweOPCq4CfBK/M52tI4noz0+7rz9dN99+IJk?=
 =?us-ascii?Q?O1FZiHcUyqvEd+sRtrOOKSb/zP4Y6EQb01jm0iv7y+TqkgaDj1o7N59BKinj?=
 =?us-ascii?Q?oPq8kVr82DqJcIw5UMf1iFmcqOdtzLt7Jm95P2keRMNGlvqT/loX5n8ZSUjp?=
 =?us-ascii?Q?gvUtHQ0eUGs/1Wic0Z7RPqiFzVFXMI5EDQJWmm+bJHG0aqFBQnCu3F40fYm/?=
 =?us-ascii?Q?OOG/5LCXMfWab7I6vecCfdORfZvoD5boPZ1pM3g7EausZ+suzr2UUXKZQ1Wp?=
 =?us-ascii?Q?slgZalbJqidRGK9AJ3OZN6+LkM1thRZguarTccEc9OdmHHlsRYbbrqTaM8A9?=
 =?us-ascii?Q?xfavtHL1XaTH258nhG8omltYh46JCtSUNxHRKg3Q92ENWRr6UyRUvQXETQw6?=
 =?us-ascii?Q?Z6UznM1BlNmwwuskL889V7bgrp8Aa4oeCZolRUBr0MQjxN8ongsbDIL9h/mY?=
 =?us-ascii?Q?oWBCiem9tjKScKPfC1gGF1sLymhe9Sk6AMx3/DKAWrSUJdLA8dZOKvo3okzn?=
 =?us-ascii?Q?i7bQbJwMFScnoN1HYUK61P9jvt5iFjv5t/Y1U40JxKcb7wnJtfF2v3nlr4B0?=
 =?us-ascii?Q?eLbQst2iqueMDlVNBAXpvDD8d3i9OnFy0CYme+f+LPZNuxtaeSHCwt0n5nGS?=
 =?us-ascii?Q?b0SWQRBpLwLsYV3VnOuspb0XiFmMvYxAFbpgPiDuiTaS4BR97CCrXxiIU+lt?=
 =?us-ascii?Q?DlXGnbwDKnv+2KBnXx/AGmKSHVffD7kmnaILRQ8oWj/0GXJmVfDJLMCkuVW0?=
 =?us-ascii?Q?zdA53cKZr8IuDBDWmUxowulVS9Z8q6Ck6/ASCPoxWVC50PR43tG/T+hxvaYo?=
 =?us-ascii?Q?ONMdceKw0navVtdlrgROLyWXF4rblDnMQpFPV6qVdXyH7a8yRn9L8nAOcRKs?=
 =?us-ascii?Q?fL4oNFnmXbGXgR6YTv/OhvgL2kWn6Q1pWxI0XQ4riHNCWczpOKZNymomqI2F?=
 =?us-ascii?Q?mq2m0VjJkuj9p09aUqtai4mYKhuIOM2opFU7F35J3YecDqHV3eg+wpgni2hU?=
 =?us-ascii?Q?9TJ+NbVGjixFJnSPuQ6lZGN70azMri6CK7Fs4Juecc6k?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0614ab3e-3043-4797-844a-08d9e1107cee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 21:11:58.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekIDsCVRvlxi7bqyxca7niqec3kmwOXWCvjCaJjVukVAwtJVKQ/EqOecitHABb3AlTOoHU/nhk5IP10CmrVgIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3368
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260122
X-Proofpoint-GUID: EV1vOI7aqriyYxpcPMbwyuxDRqxWeZVL
X-Proofpoint-ORIG-GUID: EV1vOI7aqriyYxpcPMbwyuxDRqxWeZVL
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
index f2d6b34d48de..283890084d58 100644
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


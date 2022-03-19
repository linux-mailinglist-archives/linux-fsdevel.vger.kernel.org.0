Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6603A4DE676
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 07:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbiCSGbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 02:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbiCSGbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 02:31:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA241AA8DC;
        Fri, 18 Mar 2022 23:29:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J2rVeV012459;
        Sat, 19 Mar 2022 06:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Ut4oHXjVSH/7RAcqVXqEp+FP3kXraCZgOnBL9mk/Y7o=;
 b=R9UsWQuf2O0+ijNf48EE5fREi8uQlkS4jTk1zpQsU6TPaQx5AwGs0nj2M8PUf0b+XnEA
 utZ8XOPiKGCsNBW3EMefGheColr/RPSkgoKPJyBCfDonDy2eWgYMsu8FOqIaJQ1Jv0/w
 C221lPn9lmf38yY+/zarIjfpk6OZ4BDjLQVO61xcAovGnPqjNdrFNR+45XeVbH41QXpO
 NsiAIr4OFYWQV9RwJYi/iMa+UIDKAJZNQNKOg95F2ww6n1h+qmj4IUgEAtUWZb8dCc8T
 keWX383rleirHuoKuc6X+b+SHRrjI63Lb42sp5Rui4nFJio545HiIZequ8VGM88n9Pq8 +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6ss04bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 06:29:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22J6M4PG010196;
        Sat, 19 Mar 2022 06:29:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3030.oracle.com with ESMTP id 3ew49r0ar4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 06:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr7OJvUM2exvLhiJ1Hg1Trh4iRISUb6PijzOXC6FmEWx+7fLyjIGTyb9+yXpZwefbQrog9vlXXGdcVa4FqbFLLGoVj/PkVyVp6GKfG+AyBq/6YPQgWzu40XkTM+tUt/VAwSJrZwd5aake8jYxLrUd6O9WJtcvmFfvseL7cPaY9VCPNPIFmipKUYUwgkK+fmGU1opTiN9xJIPlacTm03jh3XyyMRErsYe4Ia16UYAcNCtF3aQAnYoZgHVQ11klh8Husu03CUqpKxdX6mEGFyq55VWaE/gekjvXpPoSBG1yqTO5r3FjkByRH/NyYd4bpotLXoAPuWIVDRGyLskzKz0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut4oHXjVSH/7RAcqVXqEp+FP3kXraCZgOnBL9mk/Y7o=;
 b=cLoPIH8VNPMwCD5X2MFvKZMFvhzhty9VK3V0vgLWrTKt3BbooucFVdAT4x1QDtjmtePhjFnOqC+OYEt4tEezIXbDUZUi/g6sFj9PlOBUQBiEF7TBPlT9sZMGNEu1X5YkpG0ww2JCFWXhGo8vvaP9/0/3PaMs2Ig0na7JmEe7CZ28CNBlQsb8o5r0s3ZaORfV6y5tM0IpfTTaH0oqwNi3KVwUx5PhCxPQkd8OVwK7aTI32LZHY/cu6uS4dgt1GsFTmsHg7Qwxvm44aCd3p6tdtXheJfGUmNDDOcfoXUlfsDMKj+MgJNePeuJZLduZzx/OLLzuCnXhQKgV0pQtJodJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut4oHXjVSH/7RAcqVXqEp+FP3kXraCZgOnBL9mk/Y7o=;
 b=CkKGg30PhherkvWzj0kWTSfEbxJktsDi0cmDtKTOb1KbejI+C8vnFaEx/DcXKCPkgbUDG+gs2nRmgn4HGB4UMMM0FzWppIVgMHVy2YbvniqqaWp1yexeR/m4Qk8+8RWiKwVYkTHjJFlXH3u6PNhqZEQYzrVRV6QwQjbRJBcqA34=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY4PR10MB1798.namprd10.prod.outlook.com (2603:10b6:903:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sat, 19 Mar
 2022 06:29:21 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%8]) with mapi id 15.20.5081.019; Sat, 19 Mar 2022
 06:29:21 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v6 4/6] dax: add DAX_RECOVERY flag and .recovery_write dev_pgmap_ops
Date:   Sat, 19 Mar 2022 00:28:31 -0600
Message-Id: <20220319062833.3136528-5-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220319062833.3136528-1-jane.chu@oracle.com>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26f8cb4b-a26b-4fdc-58a4-08da0971cde3
X-MS-TrafficTypeDiagnostic: CY4PR10MB1798:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB17988EF91A2A3222A4C8D5ACF3149@CY4PR10MB1798.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQViXqR7pe1C2jMdnGa2/sA2M97P+TP/F8KeDrhWLDAqfUn2/0zyXbluwnHXTU8eaVsb+TeGWBXVLw07agi6E7Ii0vItMzu/mE4md3kIXgUarj9hTw3wVaVtVOPStqXmy0MidzN4bQdRuDFMLfdp1B29r+y5cQ1K4RfeRz0rETcS37g6ycpFFYOkRVJ3NtIzvzCHWWuL9z1sAfTSiDDgIoB3vV6f2CDNR0YXPD8Ka8uk4Q/P6COd5KtND+PiDXnXfu07j8kap/5cJGU5NNhxN1iWvQJALpBfC38M/v434RM3UXqODsFgRY9vFrQTRfjd7MjQibKg9bxgf21FJdJ3AGVCysM5rzBcFHjpXJWokNHK4hG/BZBX2aQexqCeYm3vbImjIkmrBLk+uJmt5LYm9i350KDSeTQGlPTwwEKyCkrIErJnf3QXB957TkuLcf5pgX9i+QBGBSVXuKfijFR2GaF5t8eIXig8TaYx1yiVtYOBxYXkwgrmuIbrB9fc4WPtkw/w31x9lZ73MhoWhFjezmITbywU53RKpS/lHCD3yMszlD7/3HbC7e5o6IIXTWF/NjQ7Kgz7rHmBvXAqNXAkJv6IeA2KR++J9sIfwHNv5rFX/dlGU8NnoQJVDZmiOlnNA+Pn9k6GcT2QGO4yZn8vcGhegV+zFxYRhGBl3Lq5xTMWFgp+WU7kQy/CnP3d9K1QkO/MCYDmTakXKXt9HkuH0ttb/XH4dWG+wKyH8B2mCa/fV2aeXJ+sowpUpkp4bwgI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(6512007)(66476007)(8676002)(83380400001)(66556008)(316002)(6506007)(2906002)(38100700002)(66946007)(508600001)(44832011)(5660300002)(8936002)(7416002)(30864003)(36756003)(1076003)(6486002)(86362001)(186003)(2616005)(921005)(6666004)(142923001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wYxJVdqnb1n6Ef5Ah/0j70SQZ8ZIvRvf7lCXzp4ncruLHqwSOQc01nb4n3GZ?=
 =?us-ascii?Q?bzgrDqI7UlbPF32K7D/GR24Enfa33U+bLgl8ntDEx7wrVoZj8MwqOhztK38i?=
 =?us-ascii?Q?iNNXOO4YY6x1RpMdjLlU5bJs1qkr8I5aSF8UxH0Vo8snoBHHuvEOl7lggqnm?=
 =?us-ascii?Q?55hUV+sAmMTlpyvmLqSbOSODNq/eszi9i7ix2y/TI6/Eru6iAZgQDtqdvhZ9?=
 =?us-ascii?Q?N1uSC4ZqSggf4T4F82jeH83HZTtQbWeZ/GRhyIe5Xy8jpWYPXqHcXzWzP2FH?=
 =?us-ascii?Q?VLWVc7jQBuw7+d7+J5ChPkqSc1NBDMlTy9WqYQSYFXbBhvBmXBd6tmHU81tT?=
 =?us-ascii?Q?Lg57Rd2V07VVi46p/j5MlIbit/Whu03mA6TU92DcXJP9k5TdQs5bM/CSf+BH?=
 =?us-ascii?Q?cUGudVW2FjEzErnpxCDgsg/kvpq9Ociws8CdlGkzv/URuJkT60MVAfqr9P0n?=
 =?us-ascii?Q?Pqhu/yjpmA9gv2/t+xefUZVHbi5WlRXUaXlm9GcyLx8Pgke50A/eeHNq0aBD?=
 =?us-ascii?Q?sBjsUdbXxgGKYNtUBXgIm2Gz4b2udRcXG6VryDOUMHPXdhX+9joJ7qZmgKPi?=
 =?us-ascii?Q?VEpVUC66CFcTjobLD84pWWPgkMvv7OVvE+mntUHlhvtpp82l5RkESLmnfrMh?=
 =?us-ascii?Q?Nva2V3Ru9vbFZLk3CKhMu9P78hMRNpHC3p9lyQi6JM+lYtaFgh4LKCGzUnxa?=
 =?us-ascii?Q?5wMGfl1LU2ryxX2zBOoC0KF/WAXJXOJh3oDtOf8bCy216wb2I5HcKYj1SrHQ?=
 =?us-ascii?Q?gDJNNEWB8EjhHpCHFtZQLwvm9lqQeeXr51jvGJACtmPDCs2+vv0AYSdludp5?=
 =?us-ascii?Q?wmbgADSDeXblHSup9dM2l7LMWk+BUV0+5PhePJUTj/5zRe+a3N/cfIXYinIv?=
 =?us-ascii?Q?+5Bf33w8Mk11r3rTqSgtYPr3N/HJaMz/kcb82JelLeerK4tuBiiyLM7zkJ1R?=
 =?us-ascii?Q?sOQ45mhy0kFXnnhG1HxHFrjDXcknzszP6VYlzjygGyRjm0oVLylhfmJ95FtB?=
 =?us-ascii?Q?/gahJp5+3hfYZwBK8i6PZ/tybs9DUjLWhTyVzfWkypRhOzAipwF8Rj+BKLJi?=
 =?us-ascii?Q?INRquJFNaKK36ZUpiFJkBOen1cNrINtmdvcpjYNsdBBmiGTtpXKfDmgJiuh8?=
 =?us-ascii?Q?9N0douNcDRYz9sylDbTA4hxVtKZz9+0tzwPy0uUg4GsV45jsf+MKEB5L/fJe?=
 =?us-ascii?Q?LLkO8DlXdWRi/c8N3/jFMqFk+rFS1K9QSUZ367UqQiU5gWK4+Zy4w2kBJYU6?=
 =?us-ascii?Q?m68tyqUosU/U78L0v7vYwZj3Yq/TZ+9gfiRzmgfWTlE47PryLZqmrA6B4yr2?=
 =?us-ascii?Q?B7ddxIMBqGAvYEKADTDuNB42sDi4C8YW8qjWXUc9BErnrdqOjvox++/NkXb8?=
 =?us-ascii?Q?Hqp56UdKRR9bxoisLQvaNgrmosexF/QEaUwqn509NjrRdNzA62L4iTtdmZ6e?=
 =?us-ascii?Q?1xt7l2cF5ismythQlR+ZUS4ix+YOA4t8wI3NU7xDznFxybW0xtBuS6r4pdk4?=
 =?us-ascii?Q?7TekvRbgCrTe9H0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f8cb4b-a26b-4fdc-58a4-08da0971cde3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2022 06:29:21.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yl1k8zS5yHq14U2bcjZpWcAqxJMd28ZFSBh1uEG5XdzUUZtxQEazjfQEJY+4nRxVibcq+FmpT2+fS2wAbZDHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1798
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10290 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203190038
X-Proofpoint-ORIG-GUID: JHkyksVwKGWf9gs4k1HWGeWjN8DeM5ky
X-Proofpoint-GUID: JHkyksVwKGWf9gs4k1HWGeWjN8DeM5ky
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce DAX_RECOVERY flag to dax_direct_access(). The flag is
not set by default in dax_direct_access() such that the helper
does not translate a pmem range to kernel virtual address if the
range contains uncorrectable errors.  When the flag is set,
the helper ignores the UEs and return kernel virtual adderss so
that the caller may get on with data recovery via write.

Also introduce a new dev_pagemap_ops .recovery_write function.
The function is applicable to FSDAX device only. The device
page backend driver provides .recovery_write function if the
device has underlying mechanism to clear the uncorrectable
errors on the fly.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c             | 23 +++++++++++++++++++++--
 drivers/md/dm-linear.c          |  4 ++--
 drivers/md/dm-log-writes.c      |  5 +++--
 drivers/md/dm-stripe.c          |  4 ++--
 drivers/md/dm-target.c          |  2 +-
 drivers/md/dm-writecache.c      |  5 +++--
 drivers/md/dm.c                 |  5 +++--
 drivers/nvdimm/pmem.c           | 27 +++++++++++++++++++++++----
 drivers/nvdimm/pmem.h           |  2 +-
 drivers/s390/block/dcssblk.c    |  4 ++--
 fs/dax.c                        | 32 ++++++++++++++++++++++++++------
 fs/fuse/dax.c                   |  4 ++--
 include/linux/dax.h             | 12 +++++++++---
 include/linux/device-mapper.h   |  2 +-
 include/linux/memremap.h        |  7 +++++++
 tools/testing/nvdimm/pmem-dax.c |  2 +-
 16 files changed, 107 insertions(+), 33 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e3029389d809..c0f0c8f980b1 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -28,6 +28,7 @@ struct dax_device {
 	void *private;
 	unsigned long flags;
 	const struct dax_operations *ops;
+	struct dev_pagemap *pgmap;
 };
 
 static dev_t dax_devt;
@@ -116,6 +117,7 @@ enum dax_device_flags {
  * @dax_dev: a dax_device instance representing the logical memory range
  * @pgoff: offset in pages from the start of the device to translate
  * @nr_pages: number of consecutive pages caller can handle relative to @pfn
+ * @flags: by default 0, set to DAX_RECOVERY to kick start dax recovery
  * @kaddr: output parameter that returns a virtual address mapping of pfn
  * @pfn: output parameter that returns an absolute pfn translation of @pgoff
  *
@@ -123,7 +125,7 @@ enum dax_device_flags {
  * pages accessible at the device relative @pgoff.
  */
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		void **kaddr, pfn_t *pfn)
+		int flags, void **kaddr, pfn_t *pfn)
 {
 	long avail;
 
@@ -136,7 +138,7 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 	if (nr_pages < 0)
 		return -EINVAL;
 
-	avail = dax_dev->ops->direct_access(dax_dev, pgoff, nr_pages,
+	avail = dax_dev->ops->direct_access(dax_dev, pgoff, nr_pages, flags,
 			kaddr, pfn);
 	if (!avail)
 		return -ERANGE;
@@ -193,6 +195,18 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *iter)
+{
+	struct dev_pagemap *pgmap = dax_dev->pgmap;
+
+	if (!pgmap || !pgmap->ops->recovery_write)
+		return -EIO;
+	return pgmap->ops->recovery_write(pgmap, pgoff, addr, bytes,
+				(void *)iter);
+}
+EXPORT_SYMBOL_GPL(dax_recovery_write);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
@@ -247,6 +261,11 @@ void set_dax_nomc(struct dax_device *dax_dev)
 	set_bit(DAXDEV_NOMC, &dax_dev->flags);
 }
 EXPORT_SYMBOL_GPL(set_dax_nomc);
+void set_dax_pgmap(struct dax_device *dax_dev, struct dev_pagemap *pgmap)
+{
+	dax_dev->pgmap = pgmap;
+}
+EXPORT_SYMBOL_GPL(set_dax_pgmap);
 
 bool dax_alive(struct dax_device *dax_dev)
 {
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 1b97a11d7151..bfd8895317c0 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -173,11 +173,11 @@ static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 }
 
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
 
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, flags, kaddr, pfn);
 }
 
 static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 139b09b06eda..8ee8a9f5b161 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -912,11 +912,12 @@ static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
 }
 
 static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-					 long nr_pages, void **kaddr, pfn_t *pfn)
+					 long nr_pages, int flags,
+					 void **kaddr, pfn_t *pfn)
 {
 	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, flags, kaddr, pfn);
 }
 
 static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index e566115ec0bb..af043d93ef53 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -317,11 +317,11 @@ static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 }
 
 static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, flags, kaddr, pfn);
 }
 
 static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 64dd0b34fcf4..24b1e5628f3a 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -142,7 +142,7 @@ static void io_err_release_clone_rq(struct request *clone,
 }
 
 static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	return -EIO;
 }
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 4f31591d2d25..58af379107ec 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -286,7 +286,8 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 
 	id = dax_read_lock();
 
-	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, &wc->memory_map, &pfn);
+	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, 0,
+			&wc->memory_map, &pfn);
 	if (da < 0) {
 		wc->memory_map = NULL;
 		r = da;
@@ -309,7 +310,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 		do {
 			long daa;
 			daa = dax_direct_access(wc->ssd_dev->dax_dev, offset + i, p - i,
-						NULL, &pfn);
+						0, NULL, &pfn);
 			if (daa <= 0) {
 				r = daa ? daa : -EINVAL;
 				goto err3;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 997ace47bbd5..6b6509bfaa1a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1001,7 +1001,8 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
 }
 
 static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-				 long nr_pages, void **kaddr, pfn_t *pfn)
+				 long nr_pages, int flags, void **kaddr,
+				 pfn_t *pfn)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
@@ -1019,7 +1020,7 @@ static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (len < 1)
 		goto out;
 	nr_pages = min(len, nr_pages);
-	ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn);
+	ret = ti->type->direct_access(ti, pgoff, nr_pages, flags, kaddr, pfn);
 
  out:
 	dm_put_live_table(md, srcu_idx);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 30c71a68175b..7cdaa279beca 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -238,11 +238,11 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
-	if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
+	if (!flags && unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
 					PFN_PHYS(nr_pages))))
 		return -EIO;
 
@@ -277,11 +277,12 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
-		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
+		pgoff_t pgoff, long nr_pages, int flags, void **kaddr,
+		pfn_t *pfn)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
-	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
+	return __pmem_direct_access(pmem, pgoff, nr_pages, flags, kaddr, pfn);
 }
 
 static const struct dax_operations pmem_dax_ops = {
@@ -289,6 +290,17 @@ static const struct dax_operations pmem_dax_ops = {
 	.zero_page_range = pmem_dax_zero_page_range,
 };
 
+static size_t pmem_recovery_write(struct dev_pagemap *pgmap, pgoff_t pgoff,
+		void *addr, size_t bytes, void *iter)
+{
+	struct pmem_device *pmem = pgmap->owner;
+
+	dev_warn(pmem->bb.dev, "%s: not yet implemented\n", __func__);
+
+	/* XXX more later */
+	return 0;
+}
+
 static ssize_t write_cache_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -349,6 +361,10 @@ static void pmem_release_disk(void *__pmem)
 	blk_cleanup_disk(pmem->disk);
 }
 
+static const struct dev_pagemap_ops pmem_pgmap_ops = {
+	.recovery_write = pmem_recovery_write,
+};
+
 static int pmem_attach_disk(struct device *dev,
 		struct nd_namespace_common *ndns)
 {
@@ -380,6 +396,8 @@ static int pmem_attach_disk(struct device *dev,
 		rc = nvdimm_setup_pfn(nd_pfn, &pmem->pgmap);
 		if (rc)
 			return rc;
+		if (nd_pfn->mode == PFN_MODE_PMEM)
+			pmem->pgmap.ops = &pmem_pgmap_ops;
 	}
 
 	/* we're attaching a block device, disable raw namespace access */
@@ -464,6 +482,7 @@ static int pmem_attach_disk(struct device *dev,
 	}
 	set_dax_nocache(dax_dev);
 	set_dax_nomc(dax_dev);
+	set_dax_pgmap(dax_dev, &pmem->pgmap);
 	if (is_nvdimm_sync(nd_region))
 		set_dax_synchronous(dax_dev);
 	rc = dax_add_host(dax_dev, disk);
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 59cfe13ea8a8..823eeffa7298 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -27,7 +27,7 @@ struct pmem_device {
 };
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, int flag, void **kaddr, pfn_t *pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
 static inline bool test_and_clear_pmem_poison(struct page *page)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index d614843caf6c..c3fbf500868f 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -32,7 +32,7 @@ static int dcssblk_open(struct block_device *bdev, fmode_t mode);
 static void dcssblk_release(struct gendisk *disk, fmode_t mode);
 static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn);
 
 static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
 
@@ -927,7 +927,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 
 static long
 dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
 
diff --git a/fs/dax.c b/fs/dax.c
index cd03485867a7..9f7efd0a1dd9 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -722,7 +722,7 @@ static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter
 	int id;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
+	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, 0, &kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
@@ -1013,7 +1013,7 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 	long length;
 
 	id = dax_read_lock();
-	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
+	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size), 0,
 				   NULL, pfnp);
 	if (length < 0) {
 		rc = length;
@@ -1123,7 +1123,7 @@ static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
 	void *kaddr;
 	long ret;
 
-	ret = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	ret = dax_direct_access(dax_dev, pgoff, 1, 0, &kaddr, NULL);
 	if (ret > 0) {
 		memset(kaddr + offset, 0, size);
 		dax_flush(dax_dev, kaddr + offset, size);
@@ -1240,15 +1240,27 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		const size_t size = ALIGN(length + offset, PAGE_SIZE);
 		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 		ssize_t map_len;
+		int flags, recov;
 		void *kaddr;
+		long nrpg;
 
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
 			break;
 		}
 
-		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
-				&kaddr, NULL);
+		recov = 0;
+		flags = 0;
+		nrpg = PHYS_PFN(size);
+		map_len = dax_direct_access(dax_dev, pgoff, nrpg, flags,
+					&kaddr, NULL);
+		if ((map_len == -EIO) && (iov_iter_rw(iter) == WRITE)) {
+			flags |= DAX_RECOVERY;
+			map_len = dax_direct_access(dax_dev, pgoff, nrpg,
+						flags, &kaddr, NULL);
+			if (map_len > 0)
+				recov++;
+		}
 		if (map_len < 0) {
 			ret = map_len;
 			break;
@@ -1260,7 +1272,10 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (map_len > end - pos)
 			map_len = end - pos;
 
-		if (iov_iter_rw(iter) == WRITE)
+		if (recov)
+			xfer = dax_recovery_write(dax_dev, pgoff, kaddr,
+					map_len, iter);
+		else if (iov_iter_rw(iter) == WRITE)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
@@ -1271,6 +1286,11 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		length -= xfer;
 		done += xfer;
 
+		if (recov && (xfer == (ssize_t) -EIO)) {
+			pr_warn("dax_recovery_write failed\n");
+			ret = -EIO;
+			break;
+		}
 		if (xfer == 0)
 			ret = -EFAULT;
 		if (xfer < map_len)
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 182b24a14804..e22c3ca9fdce 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1241,8 +1241,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 	INIT_DELAYED_WORK(&fcd->free_work, fuse_dax_free_mem_worker);
 
 	id = dax_read_lock();
-	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), NULL,
-				     NULL);
+	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), 0,
+				NULL, NULL);
 	dax_read_unlock(id);
 	if (nr_pages < 0) {
 		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9fc5f99a0ae2..50bf4b0fb9b6 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -14,14 +14,17 @@ struct iomap_ops;
 struct iomap_iter;
 struct iomap;
 
+/* Flag to communicate for DAX recovery operation */
+#define	DAX_RECOVERY	0x1
+
 struct dax_operations {
 	/*
 	 * direct_access: translate a device-relative
 	 * logical-page-offset into an absolute physical pfn. Return the
 	 * number of pages available for DAX at that pfn.
 	 */
-	long (*direct_access)(struct dax_device *, pgoff_t, long,
-			void **, pfn_t *);
+	long (*direct_access)(struct dax_device *dax_dev, pgoff_t pgoff,
+			long nr_pages, int flags, void **kaddr, pfn_t *pfn);
 	/*
 	 * Validate whether this device is usable as an fsdax backing
 	 * device.
@@ -40,6 +43,8 @@ void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
 void set_dax_synchronous(struct dax_device *dax_dev);
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
+		size_t bytes, struct iov_iter *i);
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
@@ -91,6 +96,7 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 
 void set_dax_nocache(struct dax_device *dax_dev);
 void set_dax_nomc(struct dax_device *dax_dev);
+void set_dax_pgmap(struct dax_device *dax_dev, struct dev_pagemap *pgmap);
 
 struct writeback_control;
 #if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
@@ -178,7 +184,7 @@ static inline void dax_read_unlock(int id)
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		void **kaddr, pfn_t *pfn);
+		int flags, void **kaddr, pfn_t *pfn);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index b26fecf6c8e8..8cdfd7566a38 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -146,7 +146,7 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
  * >= 0 : the number of bytes accessible at the address
  */
 typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 1fafcc38acba..a495e3c4c5fc 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -77,6 +77,13 @@ struct dev_pagemap_ops {
 	 * the page back to a CPU accessible page.
 	 */
 	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
+
+	/*
+	 * Used for FS DAX device only. For synchronous recovery from DAX media
+	 * encountering Uncorrectable Error.
+	 */
+	size_t (*recovery_write)(struct dev_pagemap *pgmap, pgoff_t pgoff,
+			void *addr, size_t bytes, void *iter);
 };
 
 #define PGMAP_ALTMAP_VALID	(1 << 0)
diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index af19c85558e7..287db5e3e293 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -8,7 +8,7 @@
 #include <nd.h>
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
-- 
2.18.4


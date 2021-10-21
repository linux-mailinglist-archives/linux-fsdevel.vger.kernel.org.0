Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3204356B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 02:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhJUAOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 20:14:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25878 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231311AbhJUAOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:14:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KN63tX025798;
        Thu, 21 Oct 2021 00:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ifSBF1RQnUVXGKyvH12egtVGx++r6u9YJdKhok8OWeU=;
 b=SX8d46bT/dYb1mRTPJFQ0qVXifkiEdw+zmuP/LNkW7mS75YbdHM2PtW1Dyan248J5T2q
 km9u0NTpsBIAJejvUWfWb+levQwWqg5AA6uqxKXyV6hBxc78hmTD+N1zWkrfC3cyMbgN
 y/dnR8Pt1d1dfK4ipx9a7cc5n94asHPRUkRAJ9hG9jcyhMGXB7PC+JeG+1PYhmcJVIp4
 U4LhIivnEPdSvS/bnOsBMEegHX/15Nq7MijqvVJfJjfz3AvlXycUdJ9TcLPWojRnWnI5
 X+/9dtTzJmmuym8DnbY9cDvroPu6EPmCQTSrOkLo6bm5L+JiU9iCAYHo5dIebH1wYsx+ 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btrfm1jng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:11:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L0AsIi065365;
        Thu, 21 Oct 2021 00:11:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3bqmsh8r0g-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgsZ25HSZmQm122fPMnqVbHw1SeFX7rPKuZ4F6wOtRqM1aP6UXFYw9XYP/kN0mltgF5YV/fiMRxSgtAjM5G9A384xzL6iTSQoNxUrhQzhttnCYWsxWKtqDdfmtQUFHOxHfZ7kuZd7jagkpz+WxPifDAb8r3+MqkD2XqxEgShLKcaVKAtnKCYxAZuSfkLmBHso2fHLQgwR7YcTYJ3kx42RJcyQWoxtjQHgMwp6qPoZFAfCzpaigAKi+C0/R+7LDNGTFJQu75tOY7zw8K5/ulnp2nr58zmsi896v+JAPz4ses7CuH9vHv2NPlUhZ1FxcOx/WD7QEVV80X/zK3ThVeQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifSBF1RQnUVXGKyvH12egtVGx++r6u9YJdKhok8OWeU=;
 b=AWnZ8LhKUrT0jrRWHEHVJub5czvIk8Pzckh0UCDpWJZKupCN/NHHNtgeQ3GFZv8Dp85/eAqZ39WaE+ANQVQWVfClX2g4g21UX4oumvKVcH8nOXnqQMGIk9FRWazpEVmE6D7GVMzSqMz1Q+a5ZZNtAbxhetsDoFM5Ye/LKW0XPtFUHF6uj93XcOpe23j9sXS9rmQi1F2TQiSOEY5ocWbcaPClTsKZkXPNHsvOsE5aFMRHV7iplg7/MoMsAf186wz8tFL8Fh+TIytWjMjG58L7fcEY1+xy5vdIEsvkpKmUDXVJkuzgKBJAjMRtrhskLZxXjDMppMsDPVnMC/eetwgi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifSBF1RQnUVXGKyvH12egtVGx++r6u9YJdKhok8OWeU=;
 b=zSdaFUz8sQ2vWfz9HiR6QYmMtarccHMcDpE2DmwCd/i/l7v5CC/NOe8h8u1rQX/lDX02LngCh+AzbJlP28k9EdH7smqTiOGwJQPHAree4lZQ9BPrx+Rsq6ruTEtlCvPmEbxnzO7tx+L3X8gWFyc9dY0KP3ktYZFRwelhGAQogKc=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2759.namprd10.prod.outlook.com (2603:10b6:a02:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 00:11:44 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 00:11:44 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 2/6] dax: prepare dax_direct_access() API with DAXDEV_F_RECOVERY flag
Date:   Wed, 20 Oct 2021 18:10:55 -0600
Message-Id: <20211021001059.438843-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211021001059.438843-1-jane.chu@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1d) by SN4PR0801CA0003.namprd08.prod.outlook.com (2603:10b6:803:29::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 00:11:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fde00a49-f921-43cf-a301-08d994275da7
X-MS-TrafficTypeDiagnostic: BYAPR10MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2759D77B54626082E4F5A2C4F3BF9@BYAPR10MB2759.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZbJa3gxOHifzVqDHqT/5E0T5fxzG5Sp5/YmambrOUPicQdXoJ+PCnMWcmclnmKLBQWBc1a/A2cyXjQfdq4hpxe7kTBq5mKIF2tRl5p0d1DtIrD2HoExDU9JhmJJNOJUAWNqDLdAZkYAWiQzNGzBJe3sv4SHmMn2mlg+hg+tRfBv9U6N+JGZjbORngNdtfU8uPcg5x0qlv5UX8RApiRmU9s68mQ/Wh/tT4dMw67hb0+zPBwp6N7LFVPaZN6sG2BxPcZd8xWvLMfiKOq22G1cgz6WjXhoxvHyegg/6i1Wli9LWiF/kejhD7paKFLZ+BUhmD2V+A/otj9vd7YbhbIsgpL/zMvF+aPNMmDShzQdZ/CMTts8gGouxk4HWq/4P042Hj7r33RRiNaldJjT0qreR5/71NfqoP1pdhIfk0a1Ezm3WTNLeS1DKHvrAm1k0ghe6Sk8YOFWfR5OK0YkVx+YynVuAMbvFWgHSQ4xsf+U4XcEnbCcqdVgs2UWGrCIcmIAcczBzEsxZnJggr4EbfRK4iVCV2/ibu00js7DnfoUTYulO2LjLzmvvcP06mZ1jbU2tulYTM86g+Y2izCvhZ0KI6DPCNaH4Ekx7dvt2zZGgJWWkKp+72N8lKz+ONnN3A3qvmQ+yK3EAMD22h4HOgFhW0OedU1qMVwGvyjblAHHsSftEPeDtQZAIji6On7+BSlXm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(5660300002)(1076003)(66946007)(66476007)(7416002)(6666004)(38100700002)(83380400001)(36756003)(66556008)(921005)(508600001)(6486002)(8676002)(86362001)(186003)(30864003)(7696005)(52116002)(8936002)(44832011)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JdNiGkgPN9IIWvbLtjl7RZB5b9rj1LCzPVtgGq8zEnCEl5hSKUbT3zZvGqZ/?=
 =?us-ascii?Q?Fgh59/LlUzdjURtZwEN+2tBYvMjDAcml/WLVQW9Un52txNcEQSHUbHUm+Lxf?=
 =?us-ascii?Q?0N6mNPrrOCMjwi3Btr+QHLgqrHRnkZBnQdpwTIGaJzRE9CtRFc84wbgNtn4r?=
 =?us-ascii?Q?dNcpkepfjXT7SGVyw6E2utpJi+LzmW5+qOk3iBjn9HXdUjH610z7SoYxJhZy?=
 =?us-ascii?Q?7TL2jQIOnt5Ykzqz7dHhX8LMsHU2zOeSY2sa5FalawdFCIFf2v8syHV3NJeH?=
 =?us-ascii?Q?DoYZRDLsq5cDiUDjelDcOfAfgpYPRSmG2nm6MmYSPtyiW1zpCivOtqVrrhzf?=
 =?us-ascii?Q?lk/Yt0L7C1WVwJ7/84xopEbHWqS64IVvcLZgZ7RM9LozGIBQf/Q74DRpTcSC?=
 =?us-ascii?Q?fNHftreEczVVumoyrZgQFGJjARu0sPWqiR5USbieu/zN0Ic8dT4f5PDUyrg+?=
 =?us-ascii?Q?hVfJUDISxp5w4MiJQS1WAq67sUb8VgoR4qEEZ0BoSrjri0cL9N+sfd5iyvdU?=
 =?us-ascii?Q?bEH4XDpzDgQGVeIwxPqz6atrl29Q11wGkdpZtrNWy5KIVwO7MOOIEThpEqHJ?=
 =?us-ascii?Q?IaKgcfLGSWm68TrJ6YsY9vtXhaZZk66tv4dzii5y7cHm2LthX3/qoIM+2aJA?=
 =?us-ascii?Q?Vx3mwJUa50RvGirsYb+bSmrO+0TsQ3vZbb1UdQl/8SJTOBoPxWQnwxk+WxMq?=
 =?us-ascii?Q?9nXUblMjzsNWciJsxmPWfrSFfVqqdILVZkc6N1TgHmDtMzMWQJUiZQ4obQhd?=
 =?us-ascii?Q?1vbmVSXCB27VftN3VXfMIPoGrbXWPnjV4gikjsEvVBQarz1+9Bh27PiWJFyZ?=
 =?us-ascii?Q?GYR4qbqyZrlrkDNcrm/U4gfWF8cVyNydsmzA4WXaOJVDz5tT3HWlls5/McG+?=
 =?us-ascii?Q?XuXxwZiGzEKBcKBicJ28fsH5+5TP33untLatDxTkfPK1H5LWuSSc8qgCez59?=
 =?us-ascii?Q?jFdWgGescA6x3cdZwc4u1RKT3uCe0MF8+fzYeqIK9eAYpYj3Jv64nWpTu71k?=
 =?us-ascii?Q?To97GYgGCWjsoQwTBMK8mhxVucVE3TV6ss2W9E1osnxdH0WYJESDasHe1KK6?=
 =?us-ascii?Q?9HGvZ3IhouvT/RjpmJv3wzi/TrR7ZYbYrUgVAl5QI158M5Xf08H3CYSc4ux7?=
 =?us-ascii?Q?Py0BjzQHlcx97DIngvr7n+nKemMpixMXhnjsugTK6FHwVNJX6GfKcVI//oul?=
 =?us-ascii?Q?XImohvCkg7aJQm1xuy3avZ0Li7VcOEYcORXOBvKKmEF5aI66avZWiP+rmha2?=
 =?us-ascii?Q?cI1G48OYiGyPZNw8kWXyf1aMVSQDSXrRfVmPx7Pi3dEbEs89jEcGS2Pv89pv?=
 =?us-ascii?Q?SC9QP28fPVW8n4oPZgQb+sboGfs2LFYNRwhY4XqDFX6nTg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde00a49-f921-43cf-a301-08d994275da7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 00:11:44.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2759
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210000
X-Proofpoint-GUID: dlctoru7oZnGTJA3wIxJpDafsvNLMJiK
X-Proofpoint-ORIG-GUID: dlctoru7oZnGTJA3wIxJpDafsvNLMJiK
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prepare dax_direct_access() API with DAXDEV_F_RECOVERY flag
such that the API may perform device address translation
in spite of the presence of poison(s) in a given range.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c             |  9 +++++----
 drivers/md/dm-linear.c          |  4 ++--
 drivers/md/dm-log-writes.c      |  5 +++--
 drivers/md/dm-stripe.c          |  4 ++--
 drivers/md/dm-target.c          |  2 +-
 drivers/md/dm-writecache.c      |  4 ++--
 drivers/md/dm.c                 |  4 ++--
 drivers/nvdimm/pmem.c           |  7 ++++---
 drivers/nvdimm/pmem.h           |  2 +-
 drivers/s390/block/dcssblk.c    |  7 ++++---
 fs/dax.c                        | 12 ++++++++----
 fs/fuse/dax.c                   |  2 +-
 fs/fuse/virtio_fs.c             |  4 ++--
 include/linux/dax.h             |  7 +++++--
 include/linux/device-mapper.h   |  2 +-
 tools/testing/nvdimm/pmem-dax.c |  2 +-
 16 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index fc89e91beea7..67093f1c3341 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -156,8 +156,8 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
 	}
 
 	id = dax_read_lock();
-	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
-	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
+	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn, 0);
+	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn, 0);
 
 	if (len < 1 || len2 < 1) {
 		pr_info("%pg: error: dax access failed (%ld)\n",
@@ -302,12 +302,13 @@ EXPORT_SYMBOL_GPL(dax_attribute_group);
  * @nr_pages: number of consecutive pages caller can handle relative to @pfn
  * @kaddr: output parameter that returns a virtual address mapping of pfn
  * @pfn: output parameter that returns an absolute pfn translation of @pgoff
+ * @flags: indication whether on dax data recovery code path or not
  *
  * Return: negative errno if an error occurs, otherwise the number of
  * pages accessible at the device relative @pgoff.
  */
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		void **kaddr, pfn_t *pfn)
+		void **kaddr, pfn_t *pfn, unsigned long flags)
 {
 	long avail;
 
@@ -321,7 +322,7 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 		return -EINVAL;
 
 	avail = dax_dev->ops->direct_access(dax_dev, pgoff, nr_pages,
-			kaddr, pfn);
+			kaddr, pfn, flags);
 	if (!avail)
 		return -ERANGE;
 	return min(avail, nr_pages);
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 679b4c0a2eea..cb7c8518f02d 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -165,7 +165,7 @@ static int linear_iterate_devices(struct dm_target *ti,
 
 #if IS_ENABLED(CONFIG_DAX_DRIVER)
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags)
 {
 	long ret;
 	struct linear_c *lc = ti->private;
@@ -177,7 +177,7 @@ static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 	ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
 	if (ret)
 		return ret;
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn, flags);
 }
 
 static size_t linear_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index d93a4db23512..6d8b88dcce6c 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -950,7 +950,7 @@ static int log_dax(struct log_writes_c *lc, sector_t sector, size_t bytes,
 }
 
 static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-					 long nr_pages, void **kaddr, pfn_t *pfn)
+	long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags)
 {
 	struct log_writes_c *lc = ti->private;
 	sector_t sector = pgoff * PAGE_SECTORS;
@@ -959,7 +959,8 @@ static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 	ret = bdev_dax_pgoff(lc->dev->bdev, sector, nr_pages * PAGE_SIZE, &pgoff);
 	if (ret)
 		return ret;
-	return dax_direct_access(lc->dev->dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(lc->dev->dax_dev, pgoff, nr_pages, kaddr, pfn,
+				 flags);
 }
 
 static size_t log_writes_dax_copy_from_iter(struct dm_target *ti,
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 6660b6b53d5b..0a97d0472a0b 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -302,7 +302,7 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
 
 #if IS_ENABLED(CONFIG_DAX_DRIVER)
 static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+	long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags)
 {
 	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
 	struct stripe_c *sc = ti->private;
@@ -319,7 +319,7 @@ static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 	ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
 	if (ret)
 		return ret;
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn, flags);
 }
 
 static size_t stripe_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 64dd0b34fcf4..431764b77528 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -142,7 +142,7 @@ static void io_err_release_clone_rq(struct request *clone,
 }
 
 static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+	long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags)
 {
 	return -EIO;
 }
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 18320444fb0a..c523cb911eca 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -286,7 +286,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 
 	id = dax_read_lock();
 
-	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, &wc->memory_map, &pfn);
+	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, &wc->memory_map, &pfn, 0);
 	if (da < 0) {
 		wc->memory_map = NULL;
 		r = da;
@@ -309,7 +309,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 		do {
 			long daa;
 			daa = dax_direct_access(wc->ssd_dev->dax_dev, offset + i, p - i,
-						NULL, &pfn);
+						NULL, &pfn, 0);
 			if (daa <= 0) {
 				r = daa ? daa : -EINVAL;
 				goto err3;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a011d09cb0fa..e5a14abd45f9 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -998,7 +998,7 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
 }
 
 static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-				 long nr_pages, void **kaddr, pfn_t *pfn)
+	long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
@@ -1016,7 +1016,7 @@ static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (len < 1)
 		goto out;
 	nr_pages = min(len, nr_pages);
-	ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn);
+	ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn, flags);
 
  out:
 	dm_put_live_table(md, srcu_idx);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 72de88ff0d30..b0b7fd40560e 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -256,7 +256,7 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+	long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
@@ -295,11 +295,12 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
-		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
+		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn,
+		unsigned long flags)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
-	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
+	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn, flags);
 }
 
 /*
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 59cfe13ea8a8..fb769b22777a 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -27,7 +27,7 @@ struct pmem_device {
 };
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+	long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags);
 
 #ifdef CONFIG_MEMORY_FAILURE
 static inline bool test_and_clear_pmem_poison(struct page *page)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 5be3d1c39a78..6ab2f9badc8d 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -32,7 +32,7 @@ static int dcssblk_open(struct block_device *bdev, fmode_t mode);
 static void dcssblk_release(struct gendisk *disk, fmode_t mode);
 static blk_qc_t dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags);
 
 static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
 
@@ -62,7 +62,7 @@ static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,
 	long rc;
 	void *kaddr;
 
-	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
+	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL, 0);
 	if (rc < 0)
 		return rc;
 	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
@@ -932,7 +932,8 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 
 static long
 dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, void **kaddr, pfn_t *pfn,
+		unsigned long flags)
 {
 	struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
 
diff --git a/fs/dax.c b/fs/dax.c
index 01118de00011..f603a9ce7f20 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -722,7 +722,7 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
 		return rc;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL, 0);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
@@ -1023,7 +1023,7 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 		return rc;
 	id = dax_read_lock();
 	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
-				   NULL, pfnp);
+				   NULL, pfnp, 0);
 	if (length < 0) {
 		rc = length;
 		goto out;
@@ -1149,7 +1149,7 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 	if (page_aligned)
 		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
 	else
-		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
+		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL, 0);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
@@ -1172,6 +1172,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	struct block_device *bdev = iomap->bdev;
 	struct dax_device *dax_dev = iomap->dax_dev;
 	loff_t end = pos + length, done = 0;
+	unsigned long dax_flag = 0;
 	ssize_t ret = 0;
 	size_t xfer;
 	int id;
@@ -1199,6 +1200,9 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 					      (end - 1) >> PAGE_SHIFT);
 	}
 
+	if (iomi->flags & IOMAP_RECOVERY)
+		dax_flag |= DAXDEV_F_RECOVERY;
+
 	id = dax_read_lock();
 	while (pos < end) {
 		unsigned offset = pos & (PAGE_SIZE - 1);
@@ -1218,7 +1222,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			break;
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
-				&kaddr, NULL);
+				&kaddr, NULL, dax_flag);
 		if (map_len < 0) {
 			ret = map_len;
 			break;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 281d79f8b3d3..2c45b94647f1 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1245,7 +1245,7 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 
 	id = dax_read_lock();
 	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), NULL,
-				     NULL);
+				     NULL, 0);
 	dax_read_unlock(id);
 	if (nr_pages < 0) {
 		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 0ad89c6629d7..d201b6e8a190 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -739,7 +739,7 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev,
  * offset.
  */
 static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-				    long nr_pages, void **kaddr, pfn_t *pfn)
+	    long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags)
 {
 	struct virtio_fs *fs = dax_get_private(dax_dev);
 	phys_addr_t offset = PFN_PHYS(pgoff);
@@ -773,7 +773,7 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
 	long rc;
 	void *kaddr;
 
-	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
+	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL, 0);
 	if (rc < 0)
 		return rc;
 	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 2619d94c308d..0044a5d87e5d 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -9,6 +9,9 @@
 /* Flag for synchronous flush */
 #define DAXDEV_F_SYNC (1UL << 0)
 
+/* Flag for DAX data recovery */
+#define DAXDEV_F_RECOVERY	(1UL << 1)
+
 typedef unsigned long dax_entry_t;
 
 struct iomap_ops;
@@ -21,7 +24,7 @@ struct dax_operations {
 	 * number of pages available for DAX at that pfn.
 	 */
 	long (*direct_access)(struct dax_device *, pgoff_t, long,
-			void **, pfn_t *);
+			void **, pfn_t *, unsigned long);
 	/*
 	 * Validate whether this device is usable as an fsdax backing
 	 * device.
@@ -192,7 +195,7 @@ static inline void dax_read_unlock(int id)
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		void **kaddr, pfn_t *pfn);
+		void **kaddr, pfn_t *pfn, unsigned long);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 114553b487ef..307c29789332 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -146,7 +146,7 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
  * >= 0 : the number of bytes accessible at the address
  */
 typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags);
 typedef size_t (*dm_dax_copy_iter_fn)(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index af19c85558e7..45dcfffe5575 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -8,7 +8,7 @@
 #include <nd.h>
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+	long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
-- 
2.18.4


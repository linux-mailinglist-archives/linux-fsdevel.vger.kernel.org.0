Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D634356B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 02:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhJUAOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 20:14:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25086 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231286AbhJUAOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:14:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KM5SgP000812;
        Thu, 21 Oct 2021 00:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1BbWCXWzj9c4p/AtzW6dlJYAODCGWsVna4JLDz5OPJ0=;
 b=FrXhSLWcW3i7r7P08f4694AWr+uORK5tBAr0sUdn3I1dPX1Wo4taniTUpMFw2h9pmQpf
 hhMCGUQjrmVLEH/BjmULiovTQNgRYrK1sRpvQMOZ8/dfIcH8YUDhZlwZtqLaW3ouQwVS
 jQ+ppNY7XSQl5LrEdqChk7lrzWZx+WQMI0TKz2HqH7njgFmrtD+5Xd4oMunjtSsUIkSQ
 nEpkq7szvEkEEUaHlGPNoJmBFnSuMQD4NPqenAkpK7mBGY5VVKgs3kJx2wCWsDcs/G0w
 SVhl63CfhupXI1MLdAIsqL871gL27M76Y1wm0HUR1hIfyWvatN0VNeuHrexS/mv1z+1z Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkw4ua8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:11:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L0BacI133105;
        Thu, 21 Oct 2021 00:11:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 3br8gv1krg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:11:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLTSSnc8gGWQfyZ5gln495V4Nj1scBvrLjOedM+NTvVpkHuHeAcHoIiG2qShaZGDJ54bYQLxLrVZOjpTplCG8p/EES+UxhQIw/EM9OX4+bKdsugru94sYr2UtFdGIwPAGgA+y4pmbyqg5+FXt+Ad0jKimIc7l7Htv4A5iC/gXaPOJn7Uo+y0yjff0sAnUhrhBV5ZhEkljasNrHV8KEzFGrZFWqV+aT5dy4bum7c1SWd/Tn7CxVaoSTOT82Hfh/Fq9QxSkpt6vd/ZHsOXuyXiUqZ6bk6VZqlVXZs4JLz20IH2ti8jrXyGIGALmADdxVe1HiNVyVcFgQFTe27VUrJWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BbWCXWzj9c4p/AtzW6dlJYAODCGWsVna4JLDz5OPJ0=;
 b=ayY+IrQQlzdnBQHxY1wB7NMptlDj04Nc8ZN5S46vX9ZhbNhBmaurG1sCo+0iZjP0/Gc0hgLIme/huIb4kRfMBWJeVh6MsIlmucgiO+DiqnLo1OOJYnm4Hs8fyMwhaCSiUT684mcUpc7pfjvvRagjVGdEhGtdOh9cZJ8xEWzArn53yniQ5IxTGFyXveOsMI2xMbBpLj68Lznlg9NRmXmMkanZFk7/XHi9awqCakRTvlB8tZuvYdswS0nsAERUB8Y/naLv6oAUlaq1Heup4u4MPrRHyKK638MZ1bI8Q0skCH7o2frgLRTkZ2qbfIu8JvdQVhOpqfM3AaCe6bQph0llCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BbWCXWzj9c4p/AtzW6dlJYAODCGWsVna4JLDz5OPJ0=;
 b=NqYyeftX8BxVE7NgbOg+MnqW/LNJ0nJnaQXNc8A6MzqnKSp7g9I4jvoBThtnn6jx/VmEE7I5K/yBFgRgs/9ibGZBq+vlHlV/wQjgyjaZWRdsrxabkmf8tWZO1/R72QtCJ+kh8ZoY8TfAO5/ZYxoYFrlb489PP9AFbgwcxPU0Ncg=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2759.namprd10.prod.outlook.com (2603:10b6:a02:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 00:11:40 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 00:11:40 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 1/6] dax: introduce RWF_RECOVERY_DATA flag to preadv2() and pwritev2()
Date:   Wed, 20 Oct 2021 18:10:54 -0600
Message-Id: <20211021001059.438843-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211021001059.438843-1-jane.chu@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1d) by SN4PR0801CA0003.namprd08.prod.outlook.com (2603:10b6:803:29::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 00:11:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef4796e8-e358-4a54-5b9f-08d994275b28
X-MS-TrafficTypeDiagnostic: BYAPR10MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR10MB27596F25E8654669D8A79EB1F3BF9@BYAPR10MB2759.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AI6XekBnjXoFm//pkIzwPSmpsDAqi18CLAMorG2nVz7LYIxHc7qanPDM5Jfr75kYPrUfXiFWNNaec/8jL49tZamPEXhqx/5co8+KtE975Qy3czsUx2REw8eC5IuHoI4d0Vc7lqgsjA1gJxvbewCB8hQqZmqcwIkMVjC362W9ORu76Ci3VpNwLV0vdiv8uNKAspE0qzaO7rd+7ShNq+HB6pTRT/+OOJzuS/EhXUjHKYyw67TFRmFw7eoPBCkFYLq10GMd9Mj4WOf3jyjMQ8AFrucgGhimc144JJTxG3/HC7FstSoXKi1H++j7OKCTuzPIVJ1xWQbrchwDZO6LJyZrydYns8hmevht52g+wvwm0RohhR9Tm876jXSR31kZe36VXlSzspjEUag1eXzXWstcBm7yckjeFMjL2c9DC2+AjQxnVi9d216CfdwfbHJ8JL1W83jU4Rs3gawAhtMzN75ZM5KJcdkxrLTyalVSUr8yAxL+XUwppMkfNNlsw16CzsXzYaj/RgYMUcy6D+ENFA/OLRz30KQC9vswh6VgGuVtAR8f1YZTnQPwLimjJrvftoRkyKN/paiKI/IRGjSm6gqVoDLpY5T38yasaV6NfIpN50yyf+DpBl0ls74o3KAM7vDh2lag3CoJNVirxJM3gd6Oy/EVaTy+xcNGDQ6yZjSW/fUSUOoqnqY80CARj2ov+Vw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(5660300002)(1076003)(66946007)(66476007)(7416002)(6666004)(38100700002)(83380400001)(36756003)(66556008)(921005)(508600001)(6486002)(8676002)(86362001)(186003)(7696005)(52116002)(8936002)(44832011)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ZFBALpXqz0ghYUUqn6hN5NFhWVBIcAscVYelrsRmo4Ylq4lg5B0W3e3J5Ls?=
 =?us-ascii?Q?Q29MTh0i/4WsXp/gmQtEWjbcFpIvAjZS6OjGGYNHOmuINrmgMzQm5O1HARcL?=
 =?us-ascii?Q?nriyqv68YfkXAh3wZwIQ3ek8CQhXY2zGsUPVC4tUuubn0WE45PgeRu6HmK0+?=
 =?us-ascii?Q?MMsx/6rueKJubN28eYkHXOlXDfh87sqbrPhsMN7+KUWYxd3TQP4LA9ZWAqsR?=
 =?us-ascii?Q?IktToFuzuBLJS/klzAZr+yzUXWQwUsqXQ4lgJDfPik4dcs2pjL/ARDDPSaPf?=
 =?us-ascii?Q?seWPg8sZCIC7MvF61PIWQLi35f5XzCMEWd9ZudmMQRf8YOH16zbkQSDhSquJ?=
 =?us-ascii?Q?DaXIS553SDLqfvBplY1EKva43x087DKJiKPoxwJGnpqRaOaBAXGSPIoOQHL+?=
 =?us-ascii?Q?yBBYJMgZnLGOz55C0oA8EvhSZGHoTh5rt9XpQGW3HeZLViJQ31X7y8B7w51g?=
 =?us-ascii?Q?ZBBnix9njr/MxEWEeQqCvQbd5du/LaFX0bUnTf4N6qlpUUJIweAkzXUed7RO?=
 =?us-ascii?Q?L9OAlciDRDbWtuM01uYYaFLyJkUM/vPAOmjN3V5obKCvM91Uwc/psfTRJJV5?=
 =?us-ascii?Q?Eyplh4PgNWjccNMTKjqT+BAuWZOf0alGExaYhYx9ljQvzW6hkafsug695kD9?=
 =?us-ascii?Q?5Hunbr2hxuZ0AsgQeXZ61cswkbQsFHKnXBMGvyTkOAAVp0AKWFj2SaMXzYZW?=
 =?us-ascii?Q?bRmMiRTxKfzzlBXNZUlGDIp8GbBoEvEh269Z9U5ATk07nENs4sMedr3WYqeZ?=
 =?us-ascii?Q?bvOx2ixHDdfZAqZLAeoRztFagrgXyn7jQw1xvFjKeshJAskQTtdXO0+amjYG?=
 =?us-ascii?Q?Wzcqp3dEKld8DXRWn51fTvlXbVUVkkJ+TZhyziiEuMfZ3kUBtS/9S9dDzoOZ?=
 =?us-ascii?Q?vZtwhIgsvc85t3HtCeEYQWO0b6lwR7SiX6W0TbQkzsamhAthmcTDPsX5/eTy?=
 =?us-ascii?Q?3ATb/v7c4l11vDVsG/1gkIs8tgJh3U6BhM+kZKzLWCQoSl2/DBga8wz4XR2t?=
 =?us-ascii?Q?Iuqf2l/vlOKwATQabKEbB5IgCXnawR7SWaCJvAXwPrgGA1ODUUSu+KW2CIBH?=
 =?us-ascii?Q?EOgFFEQ2DLLEoKmQ+DrUGaWRFw/tjt7BqyOBt6uuD4NVOAe9BHKqCDkbjs/G?=
 =?us-ascii?Q?luEisv6vESsrnIOvsdAuBRW3iqZTZ0oNWJWZNva2pwuQfQLRQXvHJoB4Yawd?=
 =?us-ascii?Q?m5toGo4txqUebXyLOyEyOl3ydRRC6WE7e1P0rB/RASfaYTdZML/uQNwLv1fk?=
 =?us-ascii?Q?Die1tD6gFmgriowA7aTFvhiplsoSHJAMlOpKMEMcBv0ZUALHpv5QL1RF/2W4?=
 =?us-ascii?Q?YYXnXdQsuIoZZ/qY8bix19QPXC2SiVKJQx3J41a5JpLpVg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4796e8-e358-4a54-5b9f-08d994275b28
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 00:11:40.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2759
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210000
X-Proofpoint-GUID: Fi4W2rYrk5bNBurtKJbC6_nV14Ouq-fp
X-Proofpoint-ORIG-GUID: Fi4W2rYrk5bNBurtKJbC6_nV14Ouq-fp
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce RWF_RECOVERY_DATA flag to preadv2() and pwritev2()
for the purpose of recovering data loss due to dax media error.
Hence the functionality ties to the underlying media and driver
with capability to clear media error(s) on the fly.

When this flag is provided with preadv2(), preadv2() will attempt
to read as much data as possible until the poisoned page is
encountered.

When the flag is provided with pwritev2(), pwritev2() will attempt
to clear media error within the user specified range and then write
the user provided data to the range. Both the range and length
parameters must be page aligned in order get the recovery process
to work.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 fs/dax.c                | 3 +++
 include/linux/fs.h      | 1 +
 include/linux/iomap.h   | 1 +
 include/uapi/linux/fs.h | 5 ++++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 4e3e5a283a91..01118de00011 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1288,6 +1288,9 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (iocb->ki_flags & IOCB_RECOVERY)
+		iomi.flags |= IOMAP_RECOVERY;
+
 	while ((ret = iomap_iter(&iomi, ops)) > 0)
 		iomi.processed = dax_iomap_iter(&iomi, iter);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..ae138649cbe3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -311,6 +311,7 @@ enum rw_hint {
 #define IOCB_SYNC		(__force int) RWF_SYNC
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
+#define IOCB_RECOVERY		(__force int) RWF_RECOVERY_DATA
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 24f8489583ca..c13d23328140 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -141,6 +141,7 @@ struct iomap_page_ops {
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
 #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
 #define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
+#define IOMAP_RECOVERY		(1 << 8) /* data recovery */
 
 struct iomap_ops {
 	/*
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bdf7b404b3e7..febec55ea4b8 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -301,8 +301,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* per-IO for data recovery */
+#define RWF_RECOVERY_DATA	((__force __kernel_rwf_t)0x00000020)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_RECOVERY_DATA)
 
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.18.4


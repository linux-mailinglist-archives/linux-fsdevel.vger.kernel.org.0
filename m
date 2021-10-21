Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15CE4356C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 02:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhJUAOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 20:14:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34898 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231444AbhJUAOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:14:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KNdHEJ008053;
        Thu, 21 Oct 2021 00:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Eij/sg5hmzvGS+w44cdS5GtrMSK/p3O8vShBfYZ3yew=;
 b=S9vZSN1TC1LivRw2PkLVnnLanjFJbv8f0hSvAp6rcPTrO03X7jEdySfFiYWZ2A7I4+Ld
 ncSw4WPvS1qwHfHXl7dZK+AQfECwMR+lh9xHwPmcFZi922AMFBhInmp7w3akrr7qEZM1
 8dbU3Xu2Z9GeHrMiHoBcDRYnfFcg8h9JcigxZ2oywRvs1XRK2Bj6fo91Ptw5WIwqS0bW
 LyilOw46vCq9R5kQSo7OHXud3rp/tC5nG3dMLEomm6ZceYnkzL4c7yWLVsnOCOGSfw+k
 DHNbwq7PQFOyXZY52/DC6MGO+//2u86/UuTHEP37or9tio+fuHpOZVFX7v4538AxWmEx vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btqp2hv8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:11:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L0BDPA010121;
        Thu, 21 Oct 2021 00:11:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by aserp3020.oracle.com with ESMTP id 3bqpj7vunv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0D6SbS8iV59ixujJjSewGSeUCQIpt95kZdOiHVkjDZOuICfbWdRZrQa6Euk5KsbA/2Ufj25UyzEC7M9ljjIevVi9Ywiml2/jKfdCztdkxwe04vLl7XGXVph00SSy5E2whxq3q2MvJAFmMXpBenvbbS0FCjqnxbV+30oipjgR0xTf68FDftqQO91S3fXbgPJlFZ6TmzGDkHVwMGA3CYssoOOI3P28U8lUlJLg1Cp8rcS3G2aASMd1XfvOYFoPd9RBRYiKWszbjK0kp0wfkjup4VUffhlbrVpTVzpyyYxQyQiuSA28jrLUnoE8rVwcZtJ6sJxvant8NUGfJ0kcF504Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eij/sg5hmzvGS+w44cdS5GtrMSK/p3O8vShBfYZ3yew=;
 b=d61FbmZb1kB2QUaYOaOXx+saOA+PsfFxVq/WsndGkzM11+LaTubJQ6UzP+IzV99OT/zwHebgPmzf320JPkWV9+Tz1ZDiGPBwf0DCJjTCyShX8JtAtbUDQ4eYSAc4SzDjszYvUsy/fbdYL55pZ0U/T/xzod74bAiP7mLahEWpimuN0TRo1RjQVUUS2y2jyCFBBs04OEUh/52hQsEYE7mwA81GI1YFzPG0ULYS9aaWS2OFst79rkPDyrfPKOmAUtMbpNYQFR+exxylmXCbaxG5drdWjBZnjST8S2ciLD7NkQSFOxTX8CRGvRwDTvr09sNQFXTAf/eNJUhplzoMXBBSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eij/sg5hmzvGS+w44cdS5GtrMSK/p3O8vShBfYZ3yew=;
 b=cnizekoiZxVnWJbCHHW3uXmYeau7ek6pFlys/w7AppnNkN7n6Y3f8JFCXi5EQ2JP70oh8M0leWejIDfaKA4lHClL4IZiP0kXm78GWqjwp4t3BcruIiVP5mkc/5CRAjPVAqdCsGI1pbJWCWHZiSIpcea6BxPJeb/BSUrJ3nUcGRA=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2759.namprd10.prod.outlook.com (2603:10b6:a02:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 00:11:51 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 00:11:51 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 4/6] dm,dax,pmem: prepare dax_copy_to/from_iter() APIs with DAXDEV_F_RECOVERY
Date:   Wed, 20 Oct 2021 18:10:57 -0600
Message-Id: <20211021001059.438843-5-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211021001059.438843-1-jane.chu@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1d) by SN4PR0801CA0003.namprd08.prod.outlook.com (2603:10b6:803:29::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 00:11:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e57e0c6-4f9d-41af-597b-08d9942761ad
X-MS-TrafficTypeDiagnostic: BYAPR10MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2759FAE6B7116DE0BC6DD2BCF3BF9@BYAPR10MB2759.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8M4Fl2ifT5VEoVngRkyzC51dG6chdJuXj95oJ5djbz5xRwlpEfOVZVSOyM+Q623i7At9Lookl5+0CiR9NBVHtx7R16e46Eo2Id4wHNkDv80vSEhWYdJsCFKbo2vzWMd46M+JYM81xgX0WGxjm/Lhwn1IuvwQz/Z3jfEWOinCBeJFt5+TX3X8ueKwH9703t3Sg7YlXNhRDm5vlo8F/e4BPvEiJoOm67MdF2Stk9nbTJl3VypAH0w2YgXYxbu94zXJ0dfvzNP8TSmXVcC5+JAgPb+scsaKdaenCILf8TqkpGQWHdvcQMaxxZg+he83W8nIdjBDsW9aPXCZ78LbYG4UbFFlUqANau+RXCm9NC5qU0hzYOufkVLTrPq6v8bxMaPVdZxHvIbyGHogh06stsyQaP8C1kbRtMUuzZi8+FT5zVm5rw+aR3fCmANbm+Oarl1grAZMOBGHYUX5R5s5iT8ypQORAH/a/w0Cyws2yY9zCID2mTVxCG8i2ilzPbGjRpkf9LYaX+l7PiStV8klVlhw2hROlVRIgeGYIRKxK0rtluB0y/5SSfKWDobhCXKG9o1lVeDH1jC+jVnE6jsNY5OgX3nm067zQfilptnUNLJNqZr1hZvbgcI+396ew/i496A/W90xdkkHYMgUfLJrh4ioG5nMgZchgSnVShhHafXHYltertQrFDpohWOlPkxbLZl+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(5660300002)(1076003)(66946007)(66476007)(7416002)(6666004)(38100700002)(83380400001)(36756003)(66556008)(921005)(508600001)(6486002)(8676002)(86362001)(186003)(30864003)(7696005)(52116002)(8936002)(44832011)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9ph07vDWIma8zo6X5PhjDqw9dggPkLXy/TX6CRGlBxQnqtjmgl7ulvp0vLd?=
 =?us-ascii?Q?BBuHWIHaYPkcuPYSjDCWTNcAns3wKNUyb9c1untZ8RvJLrbyGQy5AxofSXE7?=
 =?us-ascii?Q?QJoVGH7mKVrq56eyTiv2069FKYyOLMULS22AhZhIl0tHpXv0ldH9l7xv0VTe?=
 =?us-ascii?Q?qncaD8duDorlrkCLkxpAcQHi0b0qTQQ3ik0DI8g6g7WD2Xy+Jx83d3MW01qB?=
 =?us-ascii?Q?WYlcPyWuTdE3kbEXdWmUnm2L/Z18e2iKub3eaVIil+B0YMvp+7h/Qtgnzcub?=
 =?us-ascii?Q?V7UJdwDiFhbZ7eGwEaWj2AOFpzgMb9wrXIvF6EAhtOF8swZouvTDpUfLnHYB?=
 =?us-ascii?Q?JFfuuAzHOF+rtn6f59VeqLI5QeVlTs64X/IZ41RbXHDZ7PCAs6q4X/1BUyyR?=
 =?us-ascii?Q?3zQ26ST1oSA/zOxtIpTixz+b0Z4UZPKCJQfFcqoS1PJXMmnj4pdtcncDFWkJ?=
 =?us-ascii?Q?VH3yN5GfFqmFl3XxYGAZ/HZY8NnVhkQwVQIo9PB/r2G/6WGb1T88p57tpXb4?=
 =?us-ascii?Q?IlNlRKUgFCnB/tVs0+3yZL2G4j1LT1x+xLTncJd536dBhgNMMueaZfnmUYpS?=
 =?us-ascii?Q?IU7MErXVpua+QJ2SP9N48bnWyzaN1gu976j8Dn1N5osRBTkaqMqVv6YzOk24?=
 =?us-ascii?Q?cykTGfO1hWaXfqiiDJZ2UYJzi2hOhBC+4TIl3MJo7Yo8kHuYQbE00AjgmTJm?=
 =?us-ascii?Q?+uM/NkBpE5qJMJbGo3fnnpAS8I3+Zr78d7f7nxPQW81lsTgWKdQDZ2tLVNmq?=
 =?us-ascii?Q?PfeJiHcpE071fN9Sb4pZxSFgsbEKDsOaZMFxTL9L0QyMXZmYg9MTO4aui+cs?=
 =?us-ascii?Q?GdQV3rItKiKqJyARdHHDwhiOX/TwGl16mnX9pNhpvan92dvEpFDtlLRSCm/U?=
 =?us-ascii?Q?J4NeyEhAMa4LIdExwcRcpY4UedO1OdKTT6qkQJ0iK05y+oGqPRz3oULeEquv?=
 =?us-ascii?Q?ew23+NS22FnZUfgq+fkcnS1q7w2IPlOFKti9gG6BFFwv4WCydpzyDYV/mFK3?=
 =?us-ascii?Q?eRj537r1zTwAksspyy+nDFxmz5GmjeJCF+ew6+0tAPVHnHG2k61XSXAbkiBD?=
 =?us-ascii?Q?RjCPARmFyUDcsX+fcomwqX4zDvIlJ/GdSAc7G6WHSuWNaV+6BNop5C2vTyB4?=
 =?us-ascii?Q?KaAz4pVCMo77mtHSpDmYJOC/z1hoXtCqx7E65NKv4SR3TF9Z9jgvn04FKN1J?=
 =?us-ascii?Q?B8N1HcL62UQ8vyAC65D7oEdb/xRRissy2ZxsvVABxuMgokGWR106FOFfFNCa?=
 =?us-ascii?Q?nfmIW5D9T5Fx6xl6Y5LDfbCUOMa+g8Fj+gbB8XbgenTHKa8DcXJwhhA50PcH?=
 =?us-ascii?Q?9gdWWPWYuj8R8yot2Bg62cYN0v+vkCCJmjpHnGhX3X56AQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e57e0c6-4f9d-41af-597b-08d9942761ad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 00:11:51.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2759
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210000
X-Proofpoint-ORIG-GUID: Jvdl1PV3WsPqNp66Z_mOywvxjJEM4RUC
X-Proofpoint-GUID: Jvdl1PV3WsPqNp66Z_mOywvxjJEM4RUC
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prepare dax_copy_to/from_iter() APIs with DAXDEV_F_RECOVERY flag
such that when the flag is set, the underlying driver implementation
of the APIs may deal with potential poison in a given address
range and read partial data or write after clearing poison.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c           | 10 ++++++----
 drivers/md/dm-linear.c        |  8 ++++----
 drivers/md/dm-log-writes.c    | 12 ++++++------
 drivers/md/dm-stripe.c        |  8 ++++----
 drivers/md/dm.c               |  8 ++++----
 drivers/nvdimm/pmem.c         |  4 ++--
 drivers/s390/block/dcssblk.c  |  6 ++++--
 fs/dax.c                      |  4 ++--
 fs/fuse/virtio_fs.c           |  8 ++++----
 include/linux/dax.h           |  8 ++++----
 include/linux/device-mapper.h |  2 +-
 11 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 67093f1c3341..97854da1ecf7 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -330,22 +330,24 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 EXPORT_SYMBOL_GPL(dax_direct_access);
 
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
-		size_t bytes, struct iov_iter *i)
+		size_t bytes, struct iov_iter *i, unsigned long flags)
 {
 	if (!dax_alive(dax_dev))
 		return 0;
 
-	return dax_dev->ops->copy_from_iter(dax_dev, pgoff, addr, bytes, i);
+	return dax_dev->ops->copy_from_iter(dax_dev, pgoff, addr, bytes, i,
+					    flags);
 }
 EXPORT_SYMBOL_GPL(dax_copy_from_iter);
 
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
-		size_t bytes, struct iov_iter *i)
+		size_t bytes, struct iov_iter *i, unsigned long flags)
 {
 	if (!dax_alive(dax_dev))
 		return 0;
 
-	return dax_dev->ops->copy_to_iter(dax_dev, pgoff, addr, bytes, i);
+	return dax_dev->ops->copy_to_iter(dax_dev, pgoff, addr, bytes, i,
+					  flags);
 }
 EXPORT_SYMBOL_GPL(dax_copy_to_iter);
 
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index cb7c8518f02d..cc57bd639871 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -181,7 +181,7 @@ static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 }
 
 static size_t linear_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
+	void *addr, size_t bytes, struct iov_iter *i, unsigned long flags)
 {
 	struct linear_c *lc = ti->private;
 	struct block_device *bdev = lc->dev->bdev;
@@ -191,11 +191,11 @@ static size_t linear_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
 	dev_sector = linear_map_sector(ti, sector);
 	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
 		return 0;
-	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
+	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i, flags);
 }
 
 static size_t linear_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
+	void *addr, size_t bytes, struct iov_iter *i, unsigned long flags)
 {
 	struct linear_c *lc = ti->private;
 	struct block_device *bdev = lc->dev->bdev;
@@ -205,7 +205,7 @@ static size_t linear_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
 	dev_sector = linear_map_sector(ti, sector);
 	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
 		return 0;
-	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
+	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i, flags);
 }
 
 static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 6d8b88dcce6c..b8e9bddc47b8 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -964,8 +964,8 @@ static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 }
 
 static size_t log_writes_dax_copy_from_iter(struct dm_target *ti,
-					    pgoff_t pgoff, void *addr, size_t bytes,
-					    struct iov_iter *i)
+	pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i,
+	unsigned long flags)
 {
 	struct log_writes_c *lc = ti->private;
 	sector_t sector = pgoff * PAGE_SECTORS;
@@ -984,19 +984,19 @@ static size_t log_writes_dax_copy_from_iter(struct dm_target *ti,
 		return 0;
 	}
 dax_copy:
-	return dax_copy_from_iter(lc->dev->dax_dev, pgoff, addr, bytes, i);
+	return dax_copy_from_iter(lc->dev->dax_dev, pgoff, addr, bytes, i, flags);
 }
 
 static size_t log_writes_dax_copy_to_iter(struct dm_target *ti,
-					  pgoff_t pgoff, void *addr, size_t bytes,
-					  struct iov_iter *i)
+	pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i,
+	unsigned long flags)
 {
 	struct log_writes_c *lc = ti->private;
 	sector_t sector = pgoff * PAGE_SECTORS;
 
 	if (bdev_dax_pgoff(lc->dev->bdev, sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
 		return 0;
-	return dax_copy_to_iter(lc->dev->dax_dev, pgoff, addr, bytes, i);
+	return dax_copy_to_iter(lc->dev->dax_dev, pgoff, addr, bytes, i, flags);
 }
 
 static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 0a97d0472a0b..eefaa23a36fa 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -323,7 +323,7 @@ static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 }
 
 static size_t stripe_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
+	void *addr, size_t bytes, struct iov_iter *i, unsigned long flags)
 {
 	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
 	struct stripe_c *sc = ti->private;
@@ -338,11 +338,11 @@ static size_t stripe_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
 
 	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
 		return 0;
-	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
+	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i, flags);
 }
 
 static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
+	void *addr, size_t bytes, struct iov_iter *i, unsigned long flags)
 {
 	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
 	struct stripe_c *sc = ti->private;
@@ -357,7 +357,7 @@ static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
 
 	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
 		return 0;
-	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
+	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i, flags);
 }
 
 static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e5a14abd45f9..764183ddebc1 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1045,7 +1045,7 @@ static bool dm_dax_supported(struct dax_device *dax_dev, struct block_device *bd
 }
 
 static size_t dm_dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
-				    void *addr, size_t bytes, struct iov_iter *i)
+	void *addr, size_t bytes, struct iov_iter *i, unsigned long flags)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
@@ -1061,7 +1061,7 @@ static size_t dm_dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 		ret = copy_from_iter(addr, bytes, i);
 		goto out;
 	}
-	ret = ti->type->dax_copy_from_iter(ti, pgoff, addr, bytes, i);
+	ret = ti->type->dax_copy_from_iter(ti, pgoff, addr, bytes, i, flags);
  out:
 	dm_put_live_table(md, srcu_idx);
 
@@ -1069,7 +1069,7 @@ static size_t dm_dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 
 static size_t dm_dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
+	void *addr, size_t bytes, struct iov_iter *i, unsigned long flags)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
@@ -1085,7 +1085,7 @@ static size_t dm_dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 		ret = copy_to_iter(addr, bytes, i);
 		goto out;
 	}
-	ret = ti->type->dax_copy_to_iter(ti, pgoff, addr, bytes, i);
+	ret = ti->type->dax_copy_to_iter(ti, pgoff, addr, bytes, i, flags);
  out:
 	dm_put_live_table(md, srcu_idx);
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index ed699416655b..e2a1c35108cd 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -311,13 +311,13 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
  * dax_iomap_actor()
  */
 static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
+	void *addr, size_t bytes, struct iov_iter *i, unsigned long flags)
 {
 	return _copy_from_iter_flushcache(addr, bytes, i);
 }
 
 static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
+	void *addr, size_t bytes, struct iov_iter *i, unsigned long flags)
 {
 	return _copy_mc_to_iter(addr, bytes, i);
 }
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 6ab2f9badc8d..6eb2b9a7682b 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -45,13 +45,15 @@ static const struct block_device_operations dcssblk_devops = {
 };
 
 static size_t dcssblk_dax_copy_from_iter(struct dax_device *dax_dev,
-		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
+	pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i,
+	unsigned long flags)
 {
 	return copy_from_iter(addr, bytes, i);
 }
 
 static size_t dcssblk_dax_copy_to_iter(struct dax_device *dax_dev,
-		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
+	pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i,
+	unsigned long flags)
 {
 	return copy_to_iter(addr, bytes, i);
 }
diff --git a/fs/dax.c b/fs/dax.c
index f603a9ce7f20..69433c6cd6c4 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1241,10 +1241,10 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		 */
 		if (iov_iter_rw(iter) == WRITE)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
-					map_len, iter);
+					map_len, iter, dax_flag);
 		else
 			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
-					map_len, iter);
+					map_len, iter, dax_flag);
 
 		pos += xfer;
 		length -= xfer;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index d201b6e8a190..b0d80459b1cb 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -754,15 +754,15 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 
 static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
-				       pgoff_t pgoff, void *addr,
-				       size_t bytes, struct iov_iter *i)
+	pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i,
+	unsigned long flags)
 {
 	return copy_from_iter(addr, bytes, i);
 }
 
 static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
-				       pgoff_t pgoff, void *addr,
-				       size_t bytes, struct iov_iter *i)
+	pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i,
+	unsigned long flags)
 {
 	return copy_to_iter(addr, bytes, i);
 }
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 0044a5d87e5d..97f421f831e2 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -33,10 +33,10 @@ struct dax_operations {
 			sector_t, sector_t);
 	/* copy_from_iter: required operation for fs-dax direct-i/o */
 	size_t (*copy_from_iter)(struct dax_device *, pgoff_t, void *, size_t,
-			struct iov_iter *);
+			struct iov_iter *, unsigned long);
 	/* copy_to_iter: required operation for fs-dax direct-i/o */
 	size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
-			struct iov_iter *);
+			struct iov_iter *, unsigned long);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 };
@@ -197,9 +197,9 @@ void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 		void **kaddr, pfn_t *pfn, unsigned long);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
-		size_t bytes, struct iov_iter *i);
+		size_t bytes, struct iov_iter *i, unsigned long flags);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
-		size_t bytes, struct iov_iter *i);
+		size_t bytes, struct iov_iter *i, unsigned long flags);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 307c29789332..81c67c3d96ed 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -148,7 +148,7 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
 typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn, unsigned long flags);
 typedef size_t (*dm_dax_copy_iter_fn)(struct dm_target *ti, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i);
+		void *addr, size_t bytes, struct iov_iter *i, unsigned long flags);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
-- 
2.18.4


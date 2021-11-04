Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE1444F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 07:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhKDGwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 02:52:09 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:34177
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230152AbhKDGwI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:52:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEwhjSx/p3QJF4YF4EZBMOQrNkkPCuMixuz4VaTD+Y5qUT5Qt4OT49zbAbZC0kxfuHDFPeLR3I3AtPzzFFAUuX9etV8L1PKeYuiTyNIQpSbhkjTiyD5M+ieBPTLLWTLPQ63C7FEkWOXzCYMewvFKAi8zsw+uYfvDZeIZC3AsdEmBWLhWIsFvX6YsoTBRGjzxsFYK2ELvzizw9eccW7qfOMLJYn7+KlKs0zWXvm5OWsBoXHZaCertVYPb0e0LRwtGtCqB/TwsyMs97aE3wPZ/ks/KFbGnxQ3r2tzawUjNSZQtQkQY5MQcsIfo4FunspOCy6+w+OAcggMffSTrheKqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ane43rtMhrYoZXTGaIipvrwNkaplJZzdbnTQZQVIfp4=;
 b=n5cKvGYJZ+oM3eXLvkoiZxei6u7v1dD83aAChMBbQigrUpW+cvmkhGDaSq/14M7ONMSVKY+ug9DkQamq8jNE8RW4pyTIhIRCVAnigwhd5G6sBJUH6QDqc7z9sO8L2FtuUqsaW8SwI7oWSeOGfz3fJB6NeyHjEZOiKEzTCn492gMIq70gqtH1B7/RKqWcfJQ6JgoHoQ4KKCXcQQSyHXUfziZzXQJW5UynT0b001hXTLU79A8dZp8F4/7QFFE4DFeT0Q94WLAqiiwVcf+VvUBTAk6YbbOx9hzTUFF3IeCR3a2HaM3RACo34x9i2LlvKC1gKwns8pnH1fCeuQ+oxg4o2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ane43rtMhrYoZXTGaIipvrwNkaplJZzdbnTQZQVIfp4=;
 b=QVutPaZ8r01lwuarP4Ok8Rp/xHRzOpNzcvLV9QdYIOqQWxEZARFb6bKxmzer23UV4uAXI5gQnuG19T/tlnIgeS6SC590sQiA0SXNgnnt3CZfyiEd9k7ZKRcjX+W3yZu9Ax72AsKn4OHoTL3Vj/7HiwmCgoE+vb0c5hK/kWKlRIZOKZEcLgXzoxc5/sCa4Cl7IVBbe6pf6MpzdxX4cuW+Hbeh1WOXlm3tRfZ5CS0GgpGuc+YYWXXrPq8XH7ZfDYVNHMRD8EuA3WToqE+3ueWEQE/LdkSWYnIwFUlsUO+aDlxbuuWLgHl4CI1L/u6T94x0Dl5dxStfp3y5E9Q2RpXHOA==
Received: from MWHPR15CA0041.namprd15.prod.outlook.com (2603:10b6:300:ad::27)
 by BL0PR12MB4929.namprd12.prod.outlook.com (2603:10b6:208:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 06:49:28 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::18) by MWHPR15CA0041.outlook.office365.com
 (2603:10b6:300:ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 06:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 06:49:27 +0000
Received: from dev.nvidia.com (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 4 Nov
 2021 06:49:25 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <axboe@kernel.dk>, <agk@redhat.com>, <snitzer@redhat.com>,
        <song@kernel.org>, <djwong@kernel.org>, <kbusch@kernel.org>,
        <hch@lst.de>, <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <viro@zeniv.linux.org.uk>,
        <javier@javigon.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <dongli.zhang@oracle.com>,
        <ming.lei@redhat.com>, <osandov@fb.com>, <willy@infradead.org>,
        <jefflexu@linux.alibaba.com>, <josef@toxicpanda.com>, <clm@fb.com>,
        <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jlayton@kernel.org>,
        <idryomov@gmail.com>, <danil.kipnis@cloud.ionos.com>,
        <ebiggers@google.com>, <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC PATCH 7/8] null_blk: add REQ_OP_VERIFY support
Date:   Wed, 3 Nov 2021 23:46:33 -0700
Message-ID: <20211104064634.4481-8-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211104064634.4481-1-chaitanyak@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c88335d-44df-4ab6-fdb0-08d99f5f3ed1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4929:
X-Microsoft-Antispam-PRVS: <BL0PR12MB49292A540009AE62BFCBC1D6A38D9@BL0PR12MB4929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNcSmwHUNvU0MLrJY51f1jFTCFVJ/bInnujjBlLYf7Af8VWppB8y+0OxE3uGiPlteGRiS7INsnRvgmV3gr9EWJvNS1+5QUiZgHJqiP9YRUvg06GBcORfdopDWCIJwBoxEMff4Y1B6f10QE/2c5uo7sA5mmD59sDu1mB52sQlGoE49jbyrtfjFIx7ZC+wFQUrb0ElSbnd3swuqJysWxnbxQDEa0uvW0CO9CFrDABZ3mY+Ps6/+RA8ZFBNb+W/0tikWtCh+QOz9vxugVq0htgjcsybd8GfTcYn8GKt1A0aEz+r0u67l4kjeXN4aa/vUaeduBJQGWpH8nRaINa9LINagFgKLEdUqyZwJrMEn1AmcCvYfqYPOt6nkwp28Zqw4dj07/wT33nPSLmmWS53vrRm2wrjcANJ/Xf5G7q5xRASI0SLtW+Ovwm7BFvRwW3/p/qLAliRnyS6F29FI/vcMwGbdrTzncE/snlVLgHyDE3tmixpESGnpu5/9tyTMsCdodsRsIrKjDXZqL+mhgj14fynEjULEb8Ls8RgOUU7ggDwvMKsruE+vaPqYGfd+Yp9sSj5ErL/bm6iIgcr+uvi3fxvlmasnKNfPDR/QjMYn3eHcgoJoZKJXHL1pvtQg8ZpE1OpuqSSCLWERbybURW1rm+6XaqhJmUukqzw1s/W1fvQP5nhSX133syiHTEmTNvWOtDJx3+sKZLdjbNxRWPaiwiVjmeIvZJ17hmTngZwCVHj7a8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(336012)(8676002)(86362001)(426003)(26005)(16526019)(186003)(36860700001)(47076005)(7406005)(7416002)(2616005)(54906003)(8936002)(316002)(110136005)(7696005)(36756003)(508600001)(356005)(107886003)(70586007)(7636003)(6666004)(83380400001)(5660300002)(4326008)(70206006)(2906002)(1076003)(82310400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 06:49:27.3205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c88335d-44df-4ab6-fdb0-08d99f5f3ed1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4929
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Add a new module parameter, configfs attribute to configure handling of
the REQ_OP_VERIFY. This is needed for testing newly added REQ_OP_VERIFY
block layer operation.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c     | 25 ++++++++++++++++++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..36a5f5343cee 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -216,6 +216,10 @@ static unsigned int g_zone_nr_conv;
 module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block device is zoned. Default: 0");
 
+static bool g_verify;
+module_param_named(verify, g_verify, bool, 0444);
+MODULE_PARM_DESC(verify, "Allow REQ_OP_VERIFY processing. Default: false");
+
 static unsigned int g_zone_max_open;
 module_param_named(zone_max_open, g_zone_max_open, uint, 0444);
 MODULE_PARM_DESC(zone_max_open, "Maximum number of open zones when block device is zoned. Default: 0 (no limit)");
@@ -358,6 +362,7 @@ NULLB_DEVICE_ATTR(blocking, bool, NULL);
 NULLB_DEVICE_ATTR(use_per_node_hctx, bool, NULL);
 NULLB_DEVICE_ATTR(memory_backed, bool, NULL);
 NULLB_DEVICE_ATTR(discard, bool, NULL);
+NULLB_DEVICE_ATTR(verify, bool, NULL);
 NULLB_DEVICE_ATTR(mbps, uint, NULL);
 NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
 NULLB_DEVICE_ATTR(zoned, bool, NULL);
@@ -477,6 +482,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_power,
 	&nullb_device_attr_memory_backed,
 	&nullb_device_attr_discard,
+	&nullb_device_attr_verify,
 	&nullb_device_attr_mbps,
 	&nullb_device_attr_cache_size,
 	&nullb_device_attr_badblocks,
@@ -539,7 +545,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors\n");
+			"memory_backed,discard,verify,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -601,6 +607,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->use_per_node_hctx = g_use_per_node_hctx;
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
+	dev->verify = g_verify;
 	dev->zone_capacity = g_zone_capacity;
 	dev->zone_nr_conv = g_zone_nr_conv;
 	dev->zone_max_open = g_zone_max_open;
@@ -1165,6 +1172,9 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 	struct req_iterator iter;
 	struct bio_vec bvec;
 
+	if (req_op(rq) == REQ_OP_VERIFY)
+		return 0;
+
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len = bvec.bv_len;
@@ -1192,6 +1202,9 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
+	if (bio_op(bio) == REQ_OP_VERIFY)
+		return 0;
+
 	spin_lock_irq(&nullb->lock);
 	bio_for_each_segment(bvec, bio, iter) {
 		len = bvec.bv_len;
@@ -1609,6 +1622,15 @@ static void null_config_discard(struct nullb *nullb)
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
 }
 
+static void null_config_verify(struct nullb *nullb)
+{
+	if (nullb->dev->verify == false)
+		return;
+
+	blk_queue_max_verify_sectors(nullb->q, UINT_MAX >> 9);
+	blk_queue_flag_set(QUEUE_FLAG_VERIFY, nullb->q);
+}
+
 static const struct block_device_operations null_bio_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= null_submit_bio,
@@ -1881,6 +1903,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
 
 	null_config_discard(nullb);
+	null_config_verify(nullb);
 
 	sprintf(nullb->disk_name, "nullb%d", nullb->index);
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 83504f3cc9d6..e6913c099e71 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -95,6 +95,7 @@ struct nullb_device {
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
+	bool verify; /* if support verify */
 	bool zoned; /* if device is zoned */
 };
 
-- 
2.22.1


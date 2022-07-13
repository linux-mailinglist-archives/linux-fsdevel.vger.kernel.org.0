Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E4572F14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 09:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiGMHWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 03:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiGMHWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:22:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CDC1FD8;
        Wed, 13 Jul 2022 00:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBJtgDEh0vIzyj5PBG8isN0efk4+e24Ve8SpHcVFu5JHlQF4ick4tt4RGRTOkCiIOjHMV9oxK7nRZBL+WU81DEbujjXrwzmu06tRVeDzKAJ367nncHOmjVShX9bAD+6GtmjG1LITgBWvmKDxqHd7rrcYzGPZ9S/no6Yr0wBELsAdsbcHaTxDSbBRP4QH5utENgI87CpT+bfmAXUch0xvSYdqrngOkuj3o07AEfpAZx8k2P3Yp4Eyq+cgC0Mu2PUB5+0dFLbN6P4J9DjKIEOWbrdhHxwalFOp1E0EeXk3gT7e+yl3twAEzX/KgWr3TvzBHAa+F49keCBsFvnMvrhpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL4ms3Oh7uy6X4sXiQwTR1+i7JzA2MjgsL6Shj7BWXw=;
 b=ICTQ/KHBxyGlRmePMVc3VBKm4KRGOCSdf4AVvsTNr4mEk6yhtcJ49s2C2PGmgIS2YOkCC6xH8ihV+JXEgEFN2+nbP6OShQje+hKzRII2G2YvbLAP18G+yj5grWFkYb4QZk8vOxK76FfBudkbA4Zo+5UGqMtIM+VNjWqY0E9A6EpSzHwSy9iPSjEXOueS/rJnZUAeUjbZ8ZmDo+cc6um+5Uwx6/3RrquNHSSgPxu2XEiO+LccVaoxounRMzt0XytCRr7BqV7abIpxkqle8dqmw+u/ebIGzyjuwOM4fXXHW96vi+DpD3VVo/J0k5NwmdNxZTX5m60czlL+VfUgUS/2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZL4ms3Oh7uy6X4sXiQwTR1+i7JzA2MjgsL6Shj7BWXw=;
 b=o0hUw8qAlJrgm9nrFGhQ74Ti4jm2ArnRKXqT33bQr5LsVPhioJ8zXLIshX+T6j/Ynaj/1DvprB888P4P2ov/nhwPG4PaEDrWpqi3oUVnH5wj9imWakks2iChsheYdkbDiqQqtaAFBjGMgXAEgR2mdiuCkLZ/RjZLWl8m/LzP2XeBhBFhjgI94Jcgz0f2jmizWiMX2d2g+h9/PPqalid1/8cM/cqdT+EdagWWfb+ZVkiIAIzsoeJHSkT+Ho1I2NeU0hnQiwAKldsiE982arspOUE/j6QSFGZS2jRsaXnstuDQnboITskxHAWyXtQlSpHeor1Yu0Wl4utfKD6IA1qOng==
Received: from MW4PR04CA0082.namprd04.prod.outlook.com (2603:10b6:303:6b::27)
 by DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 07:22:15 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::53) by MW4PR04CA0082.outlook.office365.com
 (2603:10b6:303:6b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23 via Frontend
 Transport; Wed, 13 Jul 2022 07:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 07:22:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 07:22:14 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 00:22:12 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <agk@redhat.com>, <song@kernel.org>,
        <djwong@kernel.org>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <viro@zeniv.linux.org.uk>,
        <javier@javigon.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <dongli.zhang@oracle.com>,
        <ming.lei@redhat.com>, <willy@infradead.org>,
        <jefflexu@linux.alibaba.com>, <josef@toxicpanda.com>, <clm@fb.com>,
        <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jlayton@kernel.org>,
        <idryomov@gmail.com>, <danil.kipnis@cloud.ionos.com>,
        <ebiggers@google.com>, <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 5/6] null_blk: add REQ_OP_VERIFY support
Date:   Wed, 13 Jul 2022 00:20:18 -0700
Message-ID: <20220713072019.5885-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220713072019.5885-1-kch@nvidia.com>
References: <20220713072019.5885-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 616d9819-8203-4a14-e120-08da64a06978
X-MS-TrafficTypeDiagnostic: DM6PR12MB2825:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHHupalmu/uibIdfjj8jdoVsruiCnpAwq5XB6MTTM3rkKTNUg7fklAdrvoOV/LiBKizBv34SF/Qx178cHetPm/wMiCwJCdCUv/aAealueCvhI8o6VV4n5MisIM2XPquDFwtHpA4P7d6I6OFL+1q4lItLrVH3mp/W4nrAprZkbDhC4X7S2IKeB4gjbrR3X3V/O3IuOBGZiXpNQgrwMFfFsbsIh1XDTSZxV9zSbg0f/Q+N+RK1A3f15MjmdX1H9FEj1EezemZF9vPGBj49CyLZ55hYc439kWnJh58WPmxW16YNrZ/VyPo115/+fVZDpC8C7c+xFwgx9hBgKZLc602kQYvW2ZofbHCmEDcYWo9mA0ZLwXbeeFukxHLMPJgLQAAVyz0/MZ2MZvs0OoGnFwsnPFNDDzMQK0/oKzWlsLo1+quZ0JxA7a9w7hRTaEdF2zBoFLnZMihH+6Ld1DaTAjKrjrchITE/u9yPr0FprMEAwe81v+ulIxgnRzWWX9/CichYv9EVOlMjZnjaF4k4QNJhKTYn9RGb7gB95h++WMIO4OJLo8ReUMQeOEMwqu+JYi3T/2bQ2bpilpuy76L+PN0l5a7s77D8VsFHxYY+VVHuuW4423+6op+LMCwiowE37gF6ngOe4tr8n/qX+4M+STvyw9l3gogHAm0Qo+dSc1QZmfLv4qCyY7qXONBInNxJBK4PfgFuzZG5SaebPhBuLHGB7uxTbVwd7EVprPRm3UMvDOaxgcqGIxfn5WoCbxdGSZMwDnBQbv8RsjSjFakGKSMJkh/MxzM9aJWxk9yAWKYSr9vWIyvn4L+mmZ2gu1b0Zx7UsfW33w+dxbOnag9OJuFUZycl1864Cjd8n4sw5jHojdC5aX7uWs3vgYCeH89DbTyF
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(40470700004)(186003)(36756003)(36860700001)(2906002)(70586007)(478600001)(82740400003)(83380400001)(336012)(82310400005)(40480700001)(426003)(356005)(40460700003)(16526019)(47076005)(316002)(1076003)(2616005)(7416002)(4326008)(107886003)(5660300002)(110136005)(7406005)(8936002)(70206006)(54906003)(41300700001)(26005)(7696005)(81166007)(8676002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:22:15.2171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 616d9819-8203-4a14-e120-08da64a06978
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new module parameter, configfs attribute to configure handling of
the REQ_OP_VERIFY. This is needed for testing newly added REQ_OP_VERIFY
block layer operation.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c     | 20 +++++++++++++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d44629538cc4..c31cad169595 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -77,6 +77,10 @@ enum {
 	NULL_IRQ_TIMER		= 2,
 };
 
+static bool g_verify = true;
+module_param_named(verify, g_verify, bool, 0444);
+MODULE_PARM_DESC(verify, "Allow REQ_OP_VERIFY processing. Default: true");
+
 static bool g_virt_boundary = false;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
@@ -400,6 +404,7 @@ NULLB_DEVICE_ATTR(blocking, bool, NULL);
 NULLB_DEVICE_ATTR(use_per_node_hctx, bool, NULL);
 NULLB_DEVICE_ATTR(memory_backed, bool, NULL);
 NULLB_DEVICE_ATTR(discard, bool, NULL);
+NULLB_DEVICE_ATTR(verify, bool, NULL);
 NULLB_DEVICE_ATTR(mbps, uint, NULL);
 NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
 NULLB_DEVICE_ATTR(zoned, bool, NULL);
@@ -522,6 +527,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_power,
 	&nullb_device_attr_memory_backed,
 	&nullb_device_attr_discard,
+	&nullb_device_attr_verify,
 	&nullb_device_attr_mbps,
 	&nullb_device_attr_cache_size,
 	&nullb_device_attr_badblocks,
@@ -588,7 +594,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors,virt_boundary\n");
+			"memory_backed,discard,verify,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors,virt_boundary\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -651,6 +657,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
 	dev->use_per_node_hctx = g_use_per_node_hctx;
+	dev->verify = g_verify;
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
 	dev->zone_capacity = g_zone_capacity;
@@ -1394,6 +1401,10 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd,
 			return ret;
 	}
 
+	/* currently implemented as noop */
+	if (op == REQ_OP_VERIFY)
+		return 0;
+
 	if (dev->memory_backed)
 		return null_handle_memory_backed(cmd, op, sector, nr_sectors);
 
@@ -1769,6 +1780,12 @@ static void null_config_discard(struct nullb *nullb)
 	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
 }
 
+static void null_config_verify(struct nullb *nullb)
+{
+	blk_queue_max_verify_sectors(nullb->q,
+				     nullb->dev->verify ? UINT_MAX >> 9 : 0);
+}
+
 static const struct block_device_operations null_bio_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= null_submit_bio,
@@ -2058,6 +2075,7 @@ static int null_add_dev(struct nullb_device *dev)
 		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
 
 	null_config_discard(nullb);
+	null_config_verify(nullb);
 
 	if (config_item_name(&dev->item)) {
 		/* Use configfs dir name as the device name */
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 8359b43842f2..2a1df1bc8165 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -111,6 +111,7 @@ struct nullb_device {
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
+	bool verify; /* if support verify */
 	bool zoned; /* if device is zoned */
 	bool virt_boundary; /* virtual boundary on/off for the device */
 };
-- 
2.29.0


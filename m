Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B36561605
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 11:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiF3JRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiF3JQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:16:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893641993;
        Thu, 30 Jun 2022 02:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCc5agTqi5Pp1GfCjdoVAe9ecr3aIQwx/CwRhfsprn9PS35OLytOkU7al+uqPNpL8tMF/Cst2cLkpMoXb3Adw3jEwkbHvNtJe8JtcjN3i7pdZ0xlF3NBrZy8ytrbl2LAYHH39WuyiocCPr1Ct61bcd8w0x2W5811hFvJ96RRlaaaAC2TkkwAC1PPcjym/stgj/7BS1JUp4ikq4zXl2QvwImXdmUqCVd/edLoc1vNRFAYL6aR8bknRA55ilrnh0B/iR5diWD9EhJD+oVwyT6qWs+WiP5POHMA5bdzShnzFdTGcgdtlqHMmZ8fpkMoBepVCeAFWkyrtEt9pTlJ5l2mRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtmGy0oSsa9Y6+crbY6Qb4TjZJwrK7ZMYRrwhuxNU9Y=;
 b=FOFeCdUZX0Qjtx1XmiB3WwxZTVhR8vafthLJQ0tYzcLuEfK1xp7KONH3JWIjVxVePz6kE4xfd3do13EqYXub8Z4/8PF1zCwvdbyPQBhP6s+hJqWemnuRxnLgyvEtKWDYYSPcUIlsT2c7vExKGLg5+eZR5n2GJkDtAczV4EPUpKHyCtud4WueXs8m55eO5z3toMqckX7ZNDa9a7F7AqTEZpM4CNrMrS1UmzFBE6E4TspOGrP1uknaUoBvnUXTMm4YdDbNRdB4KdpqP3g5jQSHMW17bzrYq3JmxsQURDAq21tdPb4AxhzdG3FNdxR7eVU95WtNVWAGtN7iVXoZwV5BOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtmGy0oSsa9Y6+crbY6Qb4TjZJwrK7ZMYRrwhuxNU9Y=;
 b=oHCT9HFJv9sYS1TU3Z4zDCuq5RgEPcrShKpGnfGynF53rh/qY47vcxDzBWUcKNH2efzTFVbsccnxJ6Y/9Cyfj8BNMxYFAo0IA4yxuRlkYju832ArWts21aGCV1U4HE0DKZg5j+jCH0UZEuQhUWm0Df9fdCBLoFRP58F+8FsGEmLjV+QWo22Las76yYjhFHPvT+z/7f759jLm+/eSvqjhZYVhCIwIA2yguTVQjeHycqPeaxwqnZvxUREHRYd1lJhueDx9NZMoSpW79J4g0BzTDVXtyRZ1Z1flCrUCEBDGp243MSoQpfGfQgj6y4yo2RxufRELp4aPF/yT8X7uUhImlw==
Received: from DS7PR05CA0057.namprd05.prod.outlook.com (2603:10b6:8:2f::21) by
 BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 09:15:33 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::c7) by DS7PR05CA0057.outlook.office365.com
 (2603:10b6:8:2f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8 via Frontend
 Transport; Thu, 30 Jun 2022 09:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 09:15:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 30 Jun
 2022 09:15:31 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 30 Jun
 2022 02:15:30 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
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
Subject: [PATCH 6/6] null_blk: add REQ_OP_VERIFY support
Date:   Thu, 30 Jun 2022 02:14:06 -0700
Message-ID: <20220630091406.19624-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220630091406.19624-1-kch@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8df16dd-770f-4efe-d556-08da5a7915b0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3778:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIjj0yYXLPv0LNDnJBexy35RsIb79pKW8orDLbtf5dZQv/XahkVP/ylZ3syazHZGDi1mOEEZhYlHgli1VTKEiqkXbAA6D1GvHfFVyeztAGJSkthrDGM4r5Pq80KgbzMofyR4ZIem0CjwO6883Jx9wZPSXtEjcaIqU12i+AQ1VC2deiXWBj1gvbYmOoDhtUn+QdgcD2Emp+6w3ohxPnLmloD/nDHnzbkK1BBQJAwF6fCebS1Qq8UuGVotrxWKr8yZiVHZYjJ2pXRGUHp4wITtGwiQNReQrtwfVPuTtp1rXZUYU16K1Yjkkmh/CuvcCnA4xnBpUoHWhjTKotak96cSb8/huKNdAZVkqgLpvJti95fobURPIhAhSVxTf8SQIVFaclNzmYTNGqRIHdzxvGYMVAde8il93cn2vimHvS7usxg3zpCLkOQht7L9bIRDDMlkUw4o2ZBK8D0mxZ/uh+5CatQXFMcLwJBLZmDw9ao4JQAM6wrWWYfNLnQdwtYrXqHYwKJ9BNBdK4RzIo4Y+b9KgId5llOP9t4W6VT0J9peOVvawPim/uivvBVByrZjdXLEm8HtQT2B2or+LL8aNIvDl5kG/JXnoZKOS4GpRbgGSBmpKwH45O89RUle+WtGUaDAwyjIHp0bsqTWw80h8kwLdghC0r3hDqFw2PZQvv0GAkeOFEVacu+bQsgewJbP7aUNCtNiXbQjKg/SmA3cNogbfMHK/JToWMV0FcjiVLhQOpHsza0G9bQYtzADR+1G9Qfkp2SgKysi9vg9PwRR3quEGwZgJ1vUOqBDvWUJO9hE81PkzsB0YdNYQC1q/B0mlM2XtJe5jnz6IiOgSGb3lMJt1ciiXu1EDU5S8BscFVwe3JTPUE0q5iUD/u+PZhVXsQG9
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(40470700004)(8936002)(41300700001)(356005)(81166007)(82740400003)(26005)(426003)(16526019)(186003)(107886003)(6666004)(1076003)(2906002)(36860700001)(2616005)(82310400005)(7696005)(40480700001)(36756003)(110136005)(478600001)(4326008)(70206006)(70586007)(7416002)(47076005)(7406005)(5660300002)(8676002)(316002)(83380400001)(40460700003)(54906003)(336012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:15:32.6549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8df16dd-770f-4efe-d556-08da5a7915b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3778
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 6b67088f4ea7..559daac83b94 100644
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
@@ -2059,6 +2076,7 @@ static int null_add_dev(struct nullb_device *dev)
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


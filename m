Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9B15615E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 11:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiF3JPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 05:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiF3JPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:15:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A140720F51;
        Thu, 30 Jun 2022 02:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibjjRPG4MjnFONxx6gmSgTcgM/JBmXkb/Yto3iZ4RUXwcyMaEYjm0j1wLBbnSM1i2OockqU4gfEvbL+ycJJisejTFOty5Xv8EaBfywb6B+dcUB7sqHDWGug4t3bLh2+YtWnzzInxySIm3Go5Vc76hbY7UGLHO12fAZ+3mf8tuzdU24tLt3556s3FZ6igtDZHHCbm1V+F/G3iF4TeVcH4ayDWq2rS0XFV+5nsN6oKOXckyEDsWn/l0YOQLWh8Qxtg/RtAZdWhvkvt918EVsQ1UjI+q9tRiiqOvsuTLZKvOyAQLCsqfDmPU4tNTHCDjrwN0IV3XS50B/eAYO6ocTprEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yvnp8DqW+ZzH+Skld2NU1KhkiVq0+0mJLr2QZ76qMF0=;
 b=OlcuISbdsEsddvrroz+Zum3KHpWbwYe2DLxKAw6wbr+7G7tEYn7LWB9FsOdCQq+16XhlmztX1104QCvz3uP/w9H2sTvzxeYBzoM161l/RlhQ+xgfV1LUq0JIhDGTX2Jj7sTtJR63p9LqAHd4SkM6dBsvMSX4IXwtsl0g2XOvEQHD0Oe8vPW4GJGiA6cUnPdLHk7/rgz2uedVgdfPX8Zw6CXhCFctSkhpbHsCdWLjgFhm9oz1SD4IptEzC0cWKC09/cxidFKUxoWFKe2BNUolEcEqelG9KCDyOom7iAYPUmUaMWu7o5ybTcJSSVzHK/loyHIqcfoPLMf8Hz0Ojc9s7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvnp8DqW+ZzH+Skld2NU1KhkiVq0+0mJLr2QZ76qMF0=;
 b=FG2CBvIZciCee2WZ8PHey8ZeBThF2SgRzjdAP9WnmOfPEPmJ+X5WGknK9Ym6mVUp6BrhM4wwNgkocMghAabHS4a/Y/+VbMsdCyMIC2Fe/U55tJPVHc6lKhasSa195zzBWCjvwlBFD5ruLnqejVu42dQpPx7eEpGmhD9r7nwUS84uYrZ0MviVyrn+mNDcVh+8xcK4oMv0vT6G9jSNhQJOhIN5wcZs9ziHmCranjmIsPRyA2PtillC69YKC5inTuA0ziIYpMKgtoxxIzn5SNshlgSIcCHGyrYXG358FaFwWX0uCaA2sjfDEe7s2ZHR9cXwhl1AXsqT2oXG/xQueHaJKg==
Received: from DM6PR07CA0131.namprd07.prod.outlook.com (2603:10b6:5:330::19)
 by CY4PR12MB1142.namprd12.prod.outlook.com (2603:10b6:903:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 09:14:48 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::4b) by DM6PR07CA0131.outlook.office365.com
 (2603:10b6:5:330::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Thu, 30 Jun 2022 09:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Thu, 30 Jun 2022 09:14:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 30 Jun
 2022 09:14:41 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 30 Jun
 2022 02:14:39 -0700
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
Subject: [PATCH 2/6] nvme: add support for the Verify command
Date:   Thu, 30 Jun 2022 02:14:02 -0700
Message-ID: <20220630091406.19624-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220630091406.19624-1-kch@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e29aac5-1274-4437-514b-08da5a78fb67
X-MS-TrafficTypeDiagnostic: CY4PR12MB1142:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FM/+q9Ny4SdkGp3DqGO3EzZnfRBnSKlxEOC2XfI2AEv+i1whqgFLzLMGH3KYdRRnggu65zGlMClZE1U6P7kicw1yW5nUz9Pfb5ipp5k64zBvY0ZTswpjKJSb/Une7OYolYx62CFAcB3YmYGgJtT3P80Q6ZceG/3oQf3dnXXDTiyrhlDzNVF3uInYkEhmL1WspxmdnPRFwUvlXictX1AMoqqblSe4imnFkpYGk0o2fEIuyeHYd4DLVV1G1LGQm2vJB/Lxxf/I42XCFZb7ehfsHDe9GfBCj0F6ZmOb5WpKuQyqQplaw6HP8aU/FBVe4gPQ19QESB7nKRA2nFd1bJh5wbYiZnZtpJTnsW+kgZQZiee5qOKe6ouV1sK4we+wklX59MwyTk2cQdiOSZP6uWimxgrPI4OOyHdxZsSAbc5oAl547B18DwvgDx+bjE7BXYtlG2ZrxVuYLf0NpZ3r/RGOiWKSAd9mNBXeY3vbK/PBf/hEUj6DBrs5sE3/9KNdpT4F6frKF2MbZELp2DIa/jV1EfxenM/7ElPIZCVB7ghXzv8rTCVHZZy9ap9wC/VcJOyxcVv0QbtlxUQF3L5m2+8mZtxGP18n0TgXftViL/xPpgSHnPWZ/u/5/3yeRhtfrLlNz3BXlfoa3GubqnQdgXnSb8JtwH8hbRsuwo0kz0LDP6OvkVYDsl4W3sMRIzteFdbrLiBE8N8+Q8LGufn5azVMQUO5wyITevKrdPwmP4pPJAZMPHcCwaf0OXrQoJ5zZWm5wjQbhp/EXwnbYpPvxq+nB1wDcibVqh1nNnJ5ijtZH4qqKhur2qJPvaylNRILJdhBN6JNAVjtcXSsw32zDciBfXuAgSvniv2Q2UHljH8fZlSzHRJ6CKV2RailbOlo2e2
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(40470700004)(46966006)(8676002)(40460700003)(7696005)(2616005)(6666004)(15650500001)(7416002)(5660300002)(81166007)(1076003)(356005)(41300700001)(70206006)(426003)(36756003)(82310400005)(316002)(7406005)(83380400001)(336012)(47076005)(40480700001)(16526019)(54906003)(4326008)(26005)(110136005)(186003)(36860700001)(107886003)(478600001)(70586007)(82740400003)(8936002)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:14:48.5524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e29aac5-1274-4437-514b-08da5a78fb67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1142
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow verify operations (REQ_OP_VERIFY) on the block device, if the
device supports optional command bit set for verify. Add support
to setup verify command. Set maximum possible verify sectors in one
verify command according to maximum hardware sectors supported by the
controller.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/nvme.h     | 19 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..ef27580886b1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -838,6 +838,19 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	return BLK_STS_OK;
 }
 
+static inline blk_status_t nvme_setup_verify(struct nvme_ns *ns,
+		struct request *req, struct nvme_command *cmnd)
+{
+	cmnd->verify.opcode = nvme_cmd_verify;
+	cmnd->verify.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->verify.slba =
+		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
+	cmnd->verify.length =
+		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	cmnd->verify.control = 0;
+	return BLK_STS_OK;
+}
+
 static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd,
 		enum nvme_opcode op)
@@ -943,6 +956,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	case REQ_OP_WRITE_ZEROES:
 		ret = nvme_setup_write_zeroes(ns, req, cmd);
 		break;
+	case REQ_OP_VERIFY:
+		ret = nvme_setup_verify(ns, req, cmd);
+		break;
 	case REQ_OP_DISCARD:
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
@@ -1672,6 +1688,22 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
+static void nvme_config_verify(struct gendisk *disk, struct nvme_ns *ns)
+{
+	u64 max_blocks;
+
+	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_VERIFY))
+		return;
+
+	if (ns->ctrl->max_hw_sectors == UINT_MAX)
+		max_blocks = (u64)USHRT_MAX + 1;
+	else
+		max_blocks = ns->ctrl->max_hw_sectors + 1;
+
+	blk_queue_max_verify_sectors(disk->queue,
+				     nvme_lba_to_sect(ns, max_blocks));
+}
+
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
@@ -1871,6 +1903,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_verify(disk, ns);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 29ec3e3481ff..578bb4931665 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -363,6 +363,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_VERIFY			= 1 << 7,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
@@ -1001,6 +1002,23 @@ struct nvme_write_zeroes_cmd {
 	__le16			appmask;
 };
 
+struct nvme_verify_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2;
+	__le64			metadata;
+	union nvme_data_ptr	dptr;
+	__le64			slba;
+	__le16			length;
+	__le16			control;
+	__le32			rsvd3;
+	__le32			reftag;
+	__le16			eapptag;
+	__le16			eappmask;
+};
+
 enum nvme_zone_mgmt_action {
 	NVME_ZONE_CLOSE		= 0x1,
 	NVME_ZONE_FINISH	= 0x2,
@@ -1539,6 +1557,7 @@ struct nvme_command {
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
 		struct nvme_write_zeroes_cmd write_zeroes;
+		struct nvme_verify_cmd verify;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
 		struct nvme_abort_cmd abort;
-- 
2.29.0


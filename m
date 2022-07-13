Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C6572F07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 09:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiGMHV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 03:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiGMHVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:21:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC4E1929;
        Wed, 13 Jul 2022 00:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEsNmzoN4sKM5W5T4UPWOozhMyx2HzrJx00hVIsjCfVGkd2FzBObnHg52cSnBjxzJiogWpZ4vHu/fBxCkCBnq2EXq7gjzuBEP25c3BRdUChhP/7a6YxtXLq4QB+2XNrQAoVzXErWFh4O2R9vNqqKlAcu30kcpEgU35theQfTzRuboNT4yjCwWdAWVkum3m/YSF9826g1AqumHTTBxd6FTnz+w89TqjVKapk8kBCokqtPVFKtmYXudduph6rFGlAeHe/a1BieX7zPfQ6Nuggnu+HeZyx/Pq6suJ0jRxOkxhBC3QPWrzvXrFdWEkkaBBElhfwZdOdEVWA9CFHGDhCViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2p2FMduZ/ueJzBUHzqONpkNWaY5p33gFfLGiUVmO18=;
 b=VSqITacEYyGFMUU8lCyjnHtfDvZP9RRjNVX0uqZCqxQSjBWHeL3/KmrQ4igxHvr4d5AZPpWAQ3OMBAESUjnhoEVUsLuedfEP3hAxBcBSLj3igzeyIBVGc4rGoyhGtuoQ+hgNz51w6IWFWM0jFRDQITcTGa1RzKL5bztxJUrTRahEXwcJdBg1BHVRZAZ2+9YZehQejPGl1S3+rvSFIwu/OWCBzXcSoVRJjeNsA/ALQXg634gAOhQ4+ZyeEJjqUQJorS6DOyxeHsTD5pJfW39F4/R8etTkiVs+vAMTALUnFnAlRw1lV4z7OM7S+43nMSw5xrwacbttp77Ij+bvEDKgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2p2FMduZ/ueJzBUHzqONpkNWaY5p33gFfLGiUVmO18=;
 b=nd8ksX7za0HN/kuEcWQzRj50wTZb5Pz/GnVrpMmy7/z8VXVkqPhuq9rqkJX2M3alRizucq+6LAXkeq0RUJDJ7CXhUqIgtQg5kI1FM5CJIUSPUZjnXHv2XAHEa5nz7zcV+6RMJQ+z/rwHJkXnXznWJcm7v2k6v87uihG2rWSLCGJbLANIFTspSkCOZwGrly9b7Q4k0VChkpKsggOvLd7Xt19qVBJEh5T0E0zFTnWX4aUGeZlajm4z90XQVWoXRXNQoqPWm/PUy1iLAARoNscJ5wxweoNLa1/sLrHm6woaYZEZgnEQpaI42HWeYRaLlT/FMdXclS9bxcHfjHW6Adw0Bg==
Received: from DM6PR07CA0041.namprd07.prod.outlook.com (2603:10b6:5:74::18) by
 PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 07:21:38 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::e3) by DM6PR07CA0041.outlook.office365.com
 (2603:10b6:5:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Wed, 13 Jul 2022 07:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 07:21:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 07:21:37 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 00:21:35 -0700
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
Subject: [PATCH V2 2/6] nvme: add support for the Verify command
Date:   Wed, 13 Jul 2022 00:20:15 -0700
Message-ID: <20220713072019.5885-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220713072019.5885-1-kch@nvidia.com>
References: <20220713072019.5885-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 120dc9d2-3079-4086-1380-08da64a0535d
X-MS-TrafficTypeDiagnostic: PH7PR12MB6467:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZTDSZiOpTjaQpZHwAfQUJ0QZCsHFHo+HrIe9LMqvy+F0M0e5Aw9MdwMWrrUYyZr/0H+//rubD/GQA6D3bLy7+qMAarWxgH/1UdttafHwvzeOBViw57wkYnJR5SrZp7c1KIjKTLKY7lsR1BnSjUYfcixFQpbq9tvhdFdqxxyNdCb2lU5czbRcTD5X/bGeKOP+1cIDsu7/+4FwO5NcIjFoV1ZLBVRVi+/oGvDmVh+6rAXhOIZjvRhF3F6rwqCAQMTxd9e/LJ2YkN5alySarZfVzfyCko/5x2QRMGhCMeLVPvzA/ydyRbB/G2VF6ZobfxnhKVtvbras5fMk9cNpduwoILcPzCCfsZQs57UD2pexo9T7bdtK01EWUF8nWXJqlj89ca8OU80oIUsU161lKBz5vkZfh07bbYqWp7iopJ5h5lvcjF3q6PIGvHpWG5sUBq5wA3ca+zrzL33fet+YVkVfxNqLNzbEulf1knEAsY46Y7kw569RsHmbl5Tng2DItYwIUEfYdMCLDqDZmtjiS2aYA+Dbc/BfG6xON85zCmaCC531mHzalHPuuq7gAY043QMQ6pGpbWdUTLLBQOLSMtgvay8uTqWtwale6Y0y7DiKhqisbCKSj9CL9sdl+wPgTFMp7izW/JtnolBcZvGbQstgxYOO0BVvwHRR9mv9d01K42ykk0NUYeWKyzj4L0ZzZ5sWA+L/N6YaNsJnr6Tjmbju4w7xhGvCgurFGzOKXwT639XLftj9z5zJzNcmv9JkQlO3F3KtImaah+D3MS/6mxpkXKSePazKidKhVikSuKzfy3aYuMUC9Cdjp+y3FskIVPduQ0zWBRpelIa3usbIa5MhHeG8PNvs+m6GALB7rZeNzlc90EYGOKPbSgtRO8JMhJE
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(36840700001)(40470700004)(7406005)(1076003)(41300700001)(40460700003)(82740400003)(15650500001)(478600001)(2906002)(6666004)(7416002)(8936002)(40480700001)(36756003)(356005)(36860700001)(107886003)(16526019)(4326008)(8676002)(316002)(70206006)(83380400001)(5660300002)(54906003)(70586007)(82310400005)(2616005)(110136005)(26005)(186003)(7696005)(47076005)(426003)(336012)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:21:38.1250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 120dc9d2-3079-4086-1380-08da64a0535d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     | 19 +++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 252ab0a4bf8d..8b09ccc16184 100644
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
@@ -1672,6 +1688,17 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
+static void nvme_config_verify(struct gendisk *disk, struct nvme_ns *ns)
+{
+	unsigned int sects = ns->ctrl->max_verify_sectors;
+
+	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_VERIFY))
+		return;
+
+	/* in case controller supports verify but vsl is 0 just use UINT_MAX */
+	blk_queue_max_verify_sectors(disk->queue, sects ? sects : UINT_MAX);
+}
+
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
@@ -1871,6 +1898,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_verify(disk, ns);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -2971,6 +2999,9 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	if (id->wzsl)
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
+	if (id->vsl)
+		ctrl->max_verify_sectors = nvme_mps_to_sectors(ctrl, id->vsl);
+
 free_data:
 	kfree(id);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7323a2f61126..3bb58282585d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -279,6 +279,7 @@ struct nvme_ctrl {
 	u32 max_discard_sectors;
 	u32 max_discard_segments;
 	u32 max_zeroes_sectors;
+	u32 max_verify_sectors;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u32 max_zone_append;
 #endif
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 07cfc922f8e4..967ec7257102 100644
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
@@ -1003,6 +1004,23 @@ struct nvme_write_zeroes_cmd {
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
@@ -1541,6 +1559,7 @@ struct nvme_command {
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
 		struct nvme_write_zeroes_cmd write_zeroes;
+		struct nvme_verify_cmd verify;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
 		struct nvme_abort_cmd abort;
-- 
2.29.0


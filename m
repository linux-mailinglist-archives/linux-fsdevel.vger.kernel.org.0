Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1F5444F2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 07:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhKDGvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 02:51:01 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:32578
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230084AbhKDGuh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiYvzHNXaMfxvhoj8qrPBAw6om7Bi/1CoBQeSR/xC+MtGT/z4VTHeWkEPpxizo6ohlyWQamuHI3pAzFrk2CqwbxwDPEDzjWNQ8lzlHFnqWzYAFehjR+qjKIBAPCr4SFsve22ZAGzGoQ0TpOkx246fRg/jKQnspt+v8WSksOPfEXAodgkYmngppmCn8o4PoWJHmK6fzqkh7zpv9FmZ8JS7/1klvUSx8Ed6H7mdFIhj+21qAfvdfzz9w6q3ryBPYFdZyA7ccbyZAcI7Tlg4RP84lzr0m3iex+nMwtC2BrInDEXPs+iMfyAMnmRdf+/RB8uzmGBWsoGVZ8ybyW4/kFlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIhZSCrtMmdw6EPb7yBCwN5SlSi9MaUn9GBujbEjtUc=;
 b=SzYP9R+83Tr1/unU14dNHpTmE43J1M28kJUxCdDQ2gLonHFUtmhrZ6t2SoQbFCImoDsa70dL2/LmX2nw0xgY/EwFJ0EbrX3uLfWuKGthQdPYCLyVb4zhPqGyfs8qPhWpmNMFNRKHU1J97TAnkPsa9m+LNs4uLV8DdAFzL31yaiHnwjWnDDkTuRYb05AYOQU0lbvCgH8oMBsyk5kMDgL5y1Zamxtt+j6muh72xipmzxbWe/dWLbuuxk/aGEkQ4Wko0BqkDfP3rNxvNjyuFCX+DHwvkdnmUoyFd+8exBDjJkSIrvaIYeKhLNWWosrkWHHW8LuPfpf9mpqcHft73nCjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIhZSCrtMmdw6EPb7yBCwN5SlSi9MaUn9GBujbEjtUc=;
 b=JiKLf2bjvNlvd2wv25rhOhdbUkMUqLvDc0f6u9bT78HyMgUGAfn4eZzgyzF41nDo9PYsKzAjGA2fvPw1y7qfs002B1js/ZDjpQrPL31vrvbVmRsTtbf4WXyTpeNnCVijN70yXQ3vRl8E/Eqc59uqgT81MgYVifkR3HioJ3atqQnXF3lBzSKSEesMHPjGI33YSBuMc6KNJSGmtG++uwwZAaffi7wwQnaMMIInLiDZKZQ6+VEb8tyPj1WGsLJF1tlL6nWjAHdXPy+bXb3p0Ab671IOcotdNTxpiTUnyiLIWtSPac2qeV9+Ad0IH/DLLvg2261ubEVSDVvDjRceEj0LMA==
Received: from MWHPR15CA0043.namprd15.prod.outlook.com (2603:10b6:300:ad::29)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Thu, 4 Nov
 2021 06:47:56 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::e4) by MWHPR15CA0043.outlook.office365.com
 (2603:10b6:300:ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 06:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 06:47:56 +0000
Received: from dev.nvidia.com (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 4 Nov
 2021 06:47:55 +0000
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
Subject: [RFC PATCH 3/8] nvme: add support for the Verify command
Date:   Wed, 3 Nov 2021 23:46:29 -0700
Message-ID: <20211104064634.4481-4-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211104064634.4481-1-chaitanyak@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18df7c6d-8220-41b9-b5ed-08d99f5f089b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4064:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40647BD0F774AFD8567ED79DA38D9@MN2PR12MB4064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9XznhoJ3x00fkMXDPRfHAw9zkQ9lx+xLczVn+ZNWr+lNcO1+Le0SJCuY4dNNJjrzrzorj4pbUejn2D3DmU+7mJ9RiVQzQGO/V1dSArmOt4OnlDngaNILcKgCVqmK/JQmKDZ5PXSHAxsyaZdzKSrbR7Pkr77pwPKJxf84utKmsGAoPR8/Mk2+dd0s2rFJweTUgYcpO2ywQzUCS9tKOCV35c33k7tGzWHfCb3k7tDlG9r7R5F4toRfVqgkJ0yF+toksFJu8f+9WjhDVCCfTNbQCejMC/WlH5JlJw3A8HoKZGAWjGPI2hRm8JABHbv1FMcX7xMK0DlpRaXJ/FDKropT4k3MCWPnsv5hCiegU9+kEHVUeF7lOu0lYj1ekTSj9YF73DnjHJoZeQQks646XSLKRInzvqsyhxuCH8RDwUC98VxlFqL1KtRZb5wzHd85rYNc6PhIqtRYWkdRztIXcbn5xYZu6bwBXidfM86HrMjvGvZWPr8Pt6mVAthd5SFb/QwXIjFZp1sz541WKYQP1di2St97ShPYDRvowLK8d8Ap4Z0V/fX07Mk/92aG94uFr6z8tw/+oxGo1sYYuEq6r+Wy20w0thFQrPIF+obTqKL/2GVIObIuMmyZvf1uNrNKj9GKjcu/d8hFx7EJlb0PcGmSh/IE1IWJS80ym4GaV+A9AC9BFY2xmwHGI1wryRysXP0Rn/gQJg8oBsPYkl4R82RNztj42SglmXFoD99SHBCGjI=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7406005)(110136005)(426003)(508600001)(7416002)(36906005)(70586007)(316002)(16526019)(54906003)(82310400003)(70206006)(2906002)(7696005)(6666004)(1076003)(107886003)(186003)(26005)(8936002)(36860700001)(336012)(47076005)(8676002)(356005)(86362001)(36756003)(83380400001)(5660300002)(7636003)(15650500001)(4326008)(2616005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 06:47:56.3628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18df7c6d-8220-41b9-b5ed-08d99f5f089b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Allow verify operations (REQ_OP_VERIFY) on the block device, if the
device supports optional command bit set for verify. Add support
to setup verify command. Set maximum possible verify sectors in one
verify command according to maximum hardware sectors supported by the
controller.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h     | 19 +++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 546a10407385..250647c3bb7b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -801,6 +801,19 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
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
@@ -904,6 +917,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	case REQ_OP_WRITE_ZEROES:
 		ret = nvme_setup_write_zeroes(ns, req, cmd);
 		break;
+	case REQ_OP_VERIFY:
+		ret = nvme_setup_verify(ns, req, cmd);
+		break;
 	case REQ_OP_DISCARD:
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
@@ -1974,6 +1990,28 @@ static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 					   nvme_lba_to_sect(ns, max_blocks));
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
+	/* keep same as discard */
+	if (blk_queue_flag_test_and_set(QUEUE_FLAG_VERIFY, disk->queue))
+		return;
+
+	blk_queue_max_verify_sectors(disk->queue,
+				     nvme_lba_to_sect(ns, max_blocks));
+
+}
+
+
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
 {
 	return !uuid_is_null(&ids->uuid) ||
@@ -2144,6 +2182,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
+	nvme_config_verify(disk, ns);
 
 	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
 		test_bit(NVME_NS_FORCE_RO, &ns->flags));
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b08787cd0881..14925602726a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -318,6 +318,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
 	NVME_CTRL_ONCS_DSM			= 1 << 2,
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
+	NVME_CTRL_ONCS_VERIFY			= 1 << 7,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
@@ -890,6 +891,23 @@ struct nvme_write_zeroes_cmd {
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
@@ -1411,6 +1429,7 @@ struct nvme_command {
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
 		struct nvme_write_zeroes_cmd write_zeroes;
+		struct nvme_verify_cmd verify;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
 		struct nvme_abort_cmd abort;
-- 
2.22.1


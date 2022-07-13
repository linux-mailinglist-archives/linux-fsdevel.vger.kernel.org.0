Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4E572F0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiGMHWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 03:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiGMHWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:22:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D0FDF629;
        Wed, 13 Jul 2022 00:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4kkEVFHpWjAZCzG3q0b21FzYDAiKQUfkVcPedaFVdGauqI5Nk+n8Q/7OrwwIlqQjDzyxnbP7F86V+IQgcRt1RrOUcQvDwaokWXJliCKMAXrbRy3Uoo3hosHtUUiSlfdTJ3/rBwnUOS6KH60k06aD0PgsUEbwdVQlDwgAfFdlhaYWLj6PSzm6srLlgiwm/bDcCo3ajxHBzsLd6GpoeabMp4vIpymdt0bSH0I8Zxbhm8/jUxzoTSoVzrZC1KMlnz1+yrqsuBp3YKREcuiCUVwCZa83f2hIP+Um7YtTy8cYtEoa+bgSOGLHPSXO178y4WRsPyrJaPy5XotunglHsbDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPAH0iKcSq0C0K71QGumQc2JkeHS2CZJTBrVdORMWMQ=;
 b=b+MVMlBk/hrKCm4NQTw1al0fC8HeEAPHRzuAA/3KkXqmImP25s7LmVrpnFrs03AYihpI9Lx9uVJjGb2Woz1cu4RCjXXMHzkpmKRR6Olrr+nWQ9YK/tygdkiYRlAes+btgaOteYExS/pJxzyT/npYosvS164zU/iRJjzRpfXT6Ai80+5z+12CouoSpEhs6E9ivV1jfBWj+iy6/qxnsT2wbQmzfL6oE5DLObD9P6JSrgBUeoKzYNA9nS/tAAuE2xGalcgRgFt7umn6yRFmfwqbZbH+PTXSXpoWhldUMcdPTEq9kD3PNgWgV0Hnp3Lmp/V+RDJyxW4CcXd5WElxDiaYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPAH0iKcSq0C0K71QGumQc2JkeHS2CZJTBrVdORMWMQ=;
 b=hJV7RyUuW9ZCtTHYZ+E3ik239x8554oZfrLg03omdY9yS+Ukn/2gDKwJTr5xsRceDV9Z/DkcPzR+SA1E+V/yJRGaQ2LK9c132UVThuoT/vOtBKEyJY5+LV66v5tQYHyEUYVvlxrwHh9w2tGEYYsaf8KjWof+1SnWBc7tnIbSucgcP7CumgRvtKaQ5qch1UlOoJOkhyLxwjo5OJD99ZDepvtLonjjJIpsuso33YTujshnJu2v3iEHs+GfmcuxaOt9wq0E5XZYbdu+WfB6u4vyeFFexNYCiwsxBkuQs+ra1ZdC0AaZgaqF9jvcWgahiyEvU0zWyjwiFSu9zRbJEZAA0g==
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by BN6PR12MB1154.namprd12.prod.outlook.com (2603:10b6:404:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 07:21:57 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::5a) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Wed, 13 Jul 2022 07:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 07:21:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 07:21:49 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 00:21:47 -0700
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
Subject: [PATCH V2 3/6] nvmet: add Verify command support for bdev-ns
Date:   Wed, 13 Jul 2022 00:20:16 -0700
Message-ID: <20220713072019.5885-4-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2a633287-4f65-4c54-594e-08da64a05e1c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1154:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw226/i5mEY8bKlawik27Ze3RolJyXTicDsMlm8lu7JPL6MdHQvVSrt/nQCLWDdWxlJEFNoP+Sfq1yNXDPpMe6Z4XrB/k1WuZ/psWmGR4kDnP8FppWBwITZTLy8lE9txjMkccmj28mWfnzafhQlnv/cAYVnezi9o3LguZouDBaoVg5b/ShJmvSwisi2M3r/GlvsFoY4UnMoUURZpgpPcAdYpuEEqvyK3UwMY03V6P1VxrNLw05uDWJ9K7POQy9nilvt09nk2JbzAbkwQnHZUblrzxJeBzuQ+FtTv4S/kAm3VsEdtuFEFErvw/Jz8wFaZrpqbig6H24DnbHl1bM9zJ0mM/Peu5x+dkGjc9Le+C9h3KX0X1M8X4lrYkU5ndbFQcv0I7N9rmLi9b+SFiOr9jXHirJYBu/0vqvjQckbZ5s5gy3k8Lwnfdcda29HG3+ZEl1d8NXwWm0lpq56l8LSMoz1sWq3r8fHyLTap/x81twXcdHu8F1lXtR+U1kxgsvoP9CawtZ1IWtIrlv6FiJj732kgBucDl0JNrATYkmvXYf/Ed6//4nYDln8dzoxpYOyGBlG/it4hKAA+635VvhOOqfbcCrnLmni9hu60GrWOsR5Hx/bJKXmYSnsTqgDjPJ2vJgk0ovJOMAS1/+4HQBAQZX3gAWVa8Yfh/sthClZgmLt/W8TvlmGiH86sKnoDtYpvn4VZmkU5QvGtDHTHdoKkw7ETUPPIw1LZOkyOWOOnlR3dclSnL8FtHHTmiXMFCmiQw167qgaUMqBmDPO9FUnzxfLn2cyBqd4jt4qWIRxCjsWsdRoz3V6wYRR7SQ0Wcvajyp7E3UD3zbHkpEm4xglnz1e8zKoBY7NzDuDTihTC+xgo4JJtXqL68H41Pd19tAItDN7NvdzyNunLEdjLcis/jA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(40470700004)(46966006)(36840700001)(8936002)(7406005)(7416002)(336012)(47076005)(40480700001)(40460700003)(82310400005)(5660300002)(2906002)(15650500001)(26005)(356005)(36860700001)(83380400001)(82740400003)(41300700001)(36756003)(186003)(54906003)(110136005)(478600001)(81166007)(8676002)(7696005)(1076003)(70586007)(316002)(70206006)(4326008)(426003)(6666004)(107886003)(2616005)(16526019)(21314003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:21:56.1713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a633287-4f65-4c54-594e-08da64a05e1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1154
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for handling verify command on target. Call into
__blkdev_issue_verify, which the block layer expands into the
REQ_OP_VERIFY LBAs.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c   |  3 ++-
 drivers/nvme/target/io-cmd-bdev.c | 38 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 397daaf51f1b..495c3a31473a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -431,7 +431,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
-			NVME_CTRL_ONCS_WRITE_ZEROES);
+			NVME_CTRL_ONCS_WRITE_ZEROES |
+			NVME_CTRL_ONCS_VERIFY);
 
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 27a72504d31c..82c341f90f06 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -146,6 +146,7 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		switch (req->cmd->common.opcode) {
 		case nvme_cmd_dsm:
 		case nvme_cmd_write_zeroes:
+		case nvme_cmd_verify:
 			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
 			break;
 		default:
@@ -171,6 +172,9 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		req->error_slba =
 			le64_to_cpu(req->cmd->write_zeroes.slba);
 		break;
+	case nvme_cmd_verify:
+		req->error_slba = le64_to_cpu(req->cmd->verify.slba);
+		break;
 	default:
 		req->error_slba = 0;
 	}
@@ -442,6 +446,37 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_bdev_execute_verify(struct nvmet_req *req)
+{
+	struct nvme_verify_cmd *verify = &req->cmd->verify;
+	struct bio *bio = NULL;
+	sector_t nr_sector;
+	sector_t sector;
+	int ret;
+
+	if (!nvmet_check_transfer_len(req, 0))
+		return;
+
+	if (!bdev_verify_sectors(req->ns->bdev)) {
+		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+		return;
+	}
+
+	sector = le64_to_cpu(verify->slba) << (req->ns->blksize_shift - 9);
+	nr_sector = (((sector_t)le16_to_cpu(verify->length) + 1) <<
+			(req->ns->blksize_shift - 9));
+
+	ret = __blkdev_issue_verify(req->ns->bdev, sector, nr_sector,
+			GFP_KERNEL, &bio);
+	if (bio) {
+		bio->bi_private = req;
+		bio->bi_end_io = nvmet_bio_done;
+		submit_bio(bio);
+	} else {
+		nvmet_req_complete(req, errno_to_nvme_status(req, ret));
+	}
+}
+
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 {
 	switch (req->cmd->common.opcode) {
@@ -460,6 +495,9 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_verify:
+		req->execute = nvmet_bdev_execute_verify;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
-- 
2.29.0


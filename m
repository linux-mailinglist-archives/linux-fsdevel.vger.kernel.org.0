Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047BC444F3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 07:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhKDGvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 02:51:18 -0400
Received: from mail-bn8nam08on2052.outbound.protection.outlook.com ([40.107.100.52]:11361
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230472AbhKDGvF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:51:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Phdwf2cmpA7znVg8zzEzRKBYk3w1Ui9e+T/S1ctvZhD4JhH16rB6gqdFyET2BxIGZTxg0d7ouVYemOMJBYZGFoJcacp5Nn6bOvgnmLnaJdVPfirxq4nE1xM7UVHTBgqWzXW9Hj6lLPUuvgTzd4Iv64nNSgugc+DNLi4MCVFAl+wuluMhlLvpFikBRgjbETfgwrk8lZwYWu/SiBSGT4i4sRHTzv/PMk+pbVFt5ubG1gsrKL+ch+0qqsUAqfC6EVgmV5oRvK8gMAHKtIf4zYWRE8k2EvcfEvATIcKzJV3DA5cuh8Mr7+VSS3n4LNxTM0WQKpKZEdrkPjIRGRsHTa3/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ansAADAdB2dyXV5mYpIXS0FVuE+fozbNP94aSGQI4o=;
 b=RSUjd89S7QjXSYydP4NT6iDl3vOol/07aJp4ETERhaA39wPlaQ0htHq6/Bt3VnS8xlrbkFuxMYQh/t0qw/RFY13PLaQOFaoUmPbj4iwBkuja8s5KboLDGjs29WlFOaFVS9ZHiYDvFVRlJ7wbOEmpOgORygy4jQj2j/m+a5OFmaDlPXXRLLwck/lkfvTgJ6NwsoudKYXOkk1/CCLjMREyfQQhWb6sKoFVlJ5609OhLEkfZjl0pWjkkQS82TwUj1alsUWuSp/rChU5Xxhr1JsUtoL0jRTxt/gVm8qIufJ+HWZoTQaoOJ97O0/UlDkPb0se1MGneQO3m+GyV7nr1baClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ansAADAdB2dyXV5mYpIXS0FVuE+fozbNP94aSGQI4o=;
 b=WOmzo9b/ggfyHPHgnUqThzLRnFdO5iap12HhvdPBQXdWV5EPd5PQrwI4dacqINXadKIYtAxwrhaaACEKUPia/2rgH3HQJjzW8jMWg+rDHvvmV4W903QKKqc2+QQTdt3tFTot3nXBHT2Af1VgEWm4RS3xW5NrDBjml57NGa7n8hCJcCadj9PcwIj04JVV0osDTeqbx4DbSnZrxE1Up1/fCjEk5aqtmc1xDG6FY2zuF6NIHREMzKafU2fVNZNvZndqoyOXRnLAw2d4PJjggCZIl5OZYGxl+vBvxzylhuAntpO3mHO+uriPWYQUx+PJE6pA2f0QqpTJdTcopzICU6Rlhg==
Received: from MWHPR1401CA0007.namprd14.prod.outlook.com
 (2603:10b6:301:4b::17) by BY5PR12MB4872.namprd12.prod.outlook.com
 (2603:10b6:a03:1c4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 06:48:24 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::91) by MWHPR1401CA0007.outlook.office365.com
 (2603:10b6:301:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 06:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 06:48:23 +0000
Received: from dev.nvidia.com (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 4 Nov
 2021 06:48:11 +0000
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
Subject: [PATCH 4/8] nvmet: add Verify command support for bdev-ns
Date:   Wed, 3 Nov 2021 23:46:30 -0700
Message-ID: <20211104064634.4481-5-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: e9fe58b2-e2d4-4979-886e-08d99f5f189f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4872:
X-Microsoft-Antispam-PRVS: <BY5PR12MB48723BB1E490C132E0F3B9FDA38D9@BY5PR12MB4872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EO8BTKCM6VtmG7mGQ+x4yQAEAJGfB8VQywv+7G9X9ZkOISMPLIreHV9sxZj/J7qC9VXdn5eG87MwXPRDFOp1phZFz+uaQEkRasnrqHO4IQnKVIz/zOJ0iQIe0sZYikdfOn54n7lR462qRv6lSb2ZMDNc5z1jBUVws60lMjHMjE/pLtSjCKcy7sMO4sqesU8e+eWSKz6st+0Cby0Kqmdbmzf3kX7thvfaLMOwY/F+E2gc2bHjHyr7MCfHs9sdeB+smbImQBSVdP3+NZyNt+1O4KHnh1ou5i86bD1pMUd8mJ1pUujouPDitowElGPiB8fqXB+FoXCDk7ZraC6Ifk8fgpXQ0orVtw913cGa0LkusGlDNi8IvrYsH45PRCWibyMUUKoXi9AhMWrbUTGOvoSa62CfRB/g5SfhgDoOaG/TvxetavE1QYdOQGn8qoYjk1qrJl47+HxT9HJTh6ke5biV/NZZ021CRNjxBQz9PTGw4H6Zzmt+BL9QIhziaqth9+Z/4udmXPFT+yI0kBYgn80jQYp98QXHL2XwOj0b7jfeEVJw6gl1jcmcgEqRWfCz1XodmvQqRR40Y0xBQol53+bIbhfXQn7Zv6taH9NDNSkcu9PBornhTjFTTrUidIPMhxiPK0DxFx7MfgxZQjKuVMM0GgUOKsS1w2WBKq0fNfW43ltip3G17OjfSxC6uU7xcKE2ZuylJTkL2jJ71n2by33c+q0ag/yFJOSqhtfBKzbQoZoAb0O930gU3hbNDRIFpslF
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(83380400001)(110136005)(86362001)(82310400003)(186003)(16526019)(54906003)(2616005)(4326008)(6666004)(70206006)(47076005)(70586007)(426003)(336012)(8676002)(36756003)(36860700001)(15650500001)(1076003)(356005)(316002)(36906005)(508600001)(8936002)(7406005)(7416002)(5660300002)(7636003)(7696005)(26005)(107886003)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 06:48:23.2284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fe58b2-e2d4-4979-886e-08d99f5f189f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Add support for handling verify command on target. Call into
__blkdev_issue_verify, which the block layer expands into the
REQ_OP_VERIFY LBAs.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c   |  3 ++-
 drivers/nvme/target/io-cmd-bdev.c | 39 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 613a4d8feac1..87cad64895e6 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -408,7 +408,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
-			NVME_CTRL_ONCS_WRITE_ZEROES);
+			NVME_CTRL_ONCS_WRITE_ZEROES |
+			NVME_CTRL_ONCS_VERIFY);
 
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index ec45e597084b..5a888cdadfea 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -128,6 +128,7 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		switch (req->cmd->common.opcode) {
 		case nvme_cmd_dsm:
 		case nvme_cmd_write_zeroes:
+		case nvme_cmd_verify:
 			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
 			break;
 		default:
@@ -153,6 +154,10 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		req->error_slba =
 			le64_to_cpu(req->cmd->write_zeroes.slba);
 		break;
+	case nvme_cmd_verify:
+		req->error_slba =
+			le64_to_cpu(req->cmd->verify.slba);
+		break;
 	default:
 		req->error_slba = 0;
 	}
@@ -428,6 +433,37 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
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
 	struct nvme_command *cmd = req->cmd;
@@ -448,6 +484,9 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_verify:
+		req->execute = nvmet_bdev_execute_verify;
+		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 		       req->sq->qid);
-- 
2.22.1


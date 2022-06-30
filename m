Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6E5615DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiF3JPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 05:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiF3JPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:15:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69525597;
        Thu, 30 Jun 2022 02:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8ZXLH2MN41cPtry20AumczyA8LH3H0JDXcC7FivIANh9H1ISdMEADAMmTbU5OOn+lsSztDuKiHdJ4iUqCPNqkeZCWQrtomfFHmVowWFRvA22UwMjnvmlKmSNROt5F1xtirG04CuxXa9ZfZWilVk+6YY64++0bfyqhFatXXV2ojKWyKZfcmzbex57oc+SpYAgtiVhKYzeSN39bajhgLeL/UN5upu6xUwDzpxHyfrJVPOdFKun/Ak9zuH8a8HdOGiaTEv7Qoi5snB9rI689obgKbYHRFf2jlJ7FuX7atrN1tu+9TGbpKExce9klfEzlQLOdE245rHxr5wWbWnUzW4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmkcKKQaioOe6LEHQ2WUk1MeVaA7iTn9pKJgcZIFof0=;
 b=hhWCVoKxWkCnwx3RaPeeqXGEyLgCePn0g6BB5UFJq/qpEOe1jEsXLWi2/OYayoBNU6QVJDubiTRBIya/KsK4blaQAhRYMyIpVE9sTwnHYLP4l6dzW/g/PKk8LqcxjYIdPwE+USzzI4txO9ZFzjljM6nnc5jEinM/eSKLhcPdwZAm9VzikRFLPlvZecgMt6fcBTU/n3liWHD1JZb8QkcI9HKdT+QpzyuL7+SbqoChUtmuuDm0MpoJBHK4+dTYQxeHsutsrwfgN9g1tj5nVGGgA+NOuWeGXpixdglKRvUgP24d3/G6MLgAe8fDl3ojSTsDEdsPxhdTE5+hKPTGWGjAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmkcKKQaioOe6LEHQ2WUk1MeVaA7iTn9pKJgcZIFof0=;
 b=cqWcy4+rm0f7ufNz3+arKRTmQdRRpv5qH4Ft8ORqCBUyfbauavqLjFFm3BWpLkppTKGt4FgrzWtd5xTU6ttaKCUYtnJuZ6gwkSu5kwLpJyjQxb8IoIDifZ0UBgHGdBcwrG91edSf5V0TlZUk601WzFcJYMOQDpJYmXiSYVbfzT6NUYu6GF2l4Qv72bj2zvujm2c1ccGJXXxQQNVcyu5BgxVM7rl92A7+txJUh6668Mx32s4x/42xg7CV8SxXFjCCh+rIaIg0c+4ELM6Mhyp2ObuDdcENvyCoeUwQacbtSwSspDLJObMgW4mqkHNRfr97G4Djp9aDAJwPmClX5e+l/Q==
Received: from DS7PR03CA0349.namprd03.prod.outlook.com (2603:10b6:8:55::24) by
 DM6PR12MB4764.namprd12.prod.outlook.com (2603:10b6:5:31::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Thu, 30 Jun 2022 09:14:54 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::d4) by DS7PR03CA0349.outlook.office365.com
 (2603:10b6:8:55::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 09:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Thu, 30 Jun 2022 09:14:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 30 Jun
 2022 09:14:53 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 30 Jun
 2022 02:14:51 -0700
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
Subject: [PATCH 3/6] nvmet: add Verify command support for bdev-ns
Date:   Thu, 30 Jun 2022 02:14:03 -0700
Message-ID: <20220630091406.19624-4-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4e0a3c0-5004-4384-c48e-08da5a78fe9f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4764:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4PfOHs54EqOehrUn3BEoA9IgtuzxeSd7ySDD/AabsLjp4lwHBuM7gIhh0zWtScf68RWNJxI69SBTu2LFrj9WDBQQvYXRYbatGEIMRJMM3Z1FuZNGgiV8U3SJSQY0KlvHHfsMwY8zoodOv+ZE14r259Pvp6VBCoL8wsj+5MmbAqZxvA7JaQv+lQF3Z7ut5HhYvwLt+b0/bENgO/2YZvUdIQKJkKHgE1oi28/+up51txJ8rX6BaMsL83Aq7rjp3dDc1yI0FnHmYxrU693BCU3etCiBkcYGSy1CeVPX0jFbfVb5iwBcty0vkEC9O3tCTiTNiMWrq4IZHotuFzEZRkyeJyOQbYK6eAlRvJ0UFl9IoGNx+Ja2oF+6eUnmcqkeBBNkJxR5GO0+tMxZLr/WPL7sLlMNUJL85AHyUqJpMdiRPDjkotMBL8kl0+rNyWgAN2hrqbK0PFeC/Y+lLj7ahSAtAJq+SJfosk3D8QTbzWWM6TLhnnY3NdrojgulyfKV0HTz9mvpoLUOO0cjm/UFjGFHQ2BgcDo+/Tac9ieR5rgG9PpXp/MJ5IOolqf0FXR6bDmvEidjy87CqsfZqSLZKu0b3PIvjlNIiaHAvC97kncPDkBO0u7VFiQPM1Yg/Ytgb5zLywDTkovV18WBRJzE2O+GmKMgLS2JrHjGPdZZkDkn2L/aBIH2jro7PEltY4qogjCeWtxsfjSdzK1PPDp/17fNKysC74gyonCohcqMGkCj9W146sVHnmwo3mIVW1Mqvnzhzf5qkkkiaNgWnO+OBN89IEIM1RdLI7G6SO6xjwktzJxKsAcS1TAs6OqOQmVKO4nKkKKYmPJRMiXW7/+KblA5SFkBoSDX2Uk0h7lzCscjpsxEyd5XscZt3Gmx3mOAcwD6zEnpPV1Tb8QQMvVlutRcQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(40470700004)(36840700001)(46966006)(26005)(47076005)(15650500001)(8676002)(81166007)(426003)(82310400005)(40480700001)(70586007)(7696005)(356005)(70206006)(83380400001)(4326008)(36860700001)(186003)(16526019)(478600001)(8936002)(336012)(1076003)(54906003)(82740400003)(2906002)(7416002)(36756003)(316002)(6666004)(7406005)(107886003)(110136005)(5660300002)(41300700001)(40460700003)(2616005)(21314003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:14:53.9711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e0a3c0-5004-4384-c48e-08da5a78fe9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4764
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/nvme/target/io-cmd-bdev.c | 39 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

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
index 27a72504d31c..6687e2665e26 100644
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
@@ -171,6 +172,10 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
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
@@ -442,6 +447,37 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
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
@@ -460,6 +496,9 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
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


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1BF5615D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiF3JQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 05:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiF3JPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:15:44 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7013BA52;
        Thu, 30 Jun 2022 02:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Geu7LM8LXQkcAZCAKjikVgSmlkTkLknUoT5l8z73GYN1z43xlk/BfmI1i/8Y4k/JDHhnrGOKsA3NMSbOqm48M9ElluWwhfPPVrnz/DB0OHJOjH5sgxh3xkKsdbmu3KoQXEhRYAhuAYe2/CebgCUcaJuYLHYnKzQg+SX0Q/qA7WMk7kjLGq8MbYim9G/I5yQhx3sG6KBUauYl22dkz8Ogy+VnX2i15dP6fqqzRI/HU4FTgHrwVviimpQhMhQLDIhasZCmTWIn6xEgjkDkjRRJ7wHY0hlwVoQ9z8fTf9RtY73kASa80FIk4/Tkyk9431nPtZpBNMH0xisxmt/IuUZrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa/Y++nwNvmoWytoaUWfLxpPWzLCWXE0amicnkf5P2I=;
 b=GCQbEjthYAoNlSUAkb4EO6qX4ZcbqcUxEVyrtFpgy19/dcGx8QtH/7TTwjlGF5xnAxutnoSmOtT58TXS4ksyts02Wm3OQ2TQX1sLjYN2HyDCEabJq1azm7vBLWi431e5/qJn5vss02Swih+aRg59omT8YoHh3ZdQ35ss5xwMa77xedBTLBR1q7JlN4fucFriEQqcYOPEEACAwDdKD6dzQMUjJaLZ8tyQwK6JATLA8zoSeRWWAQp6H62uAhjCiWYdU3q2q0Uys2K6PVLbQ17eLEa4mZiZFg8TTXBb9F6doLrIOMwDBK0NBKeshoJx8SG4XMjsP7pj9Z1BNwHUPLD6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa/Y++nwNvmoWytoaUWfLxpPWzLCWXE0amicnkf5P2I=;
 b=ogn46T0HXkdotiRSl+NzmPtuW/32AzJi4Uu1bDiGAaOOyUp66B48kM5dEmxKyoIAg1Am968J53hEsGsjMItOSkpnolFyZ5gaM/outpsUsJrFM0rZbufcS/YyDiEAbFJfkqVhaANS749OR1Gr9FyeNFnlCD+Az904DQDZjQ1pdhvzjvr2a6GSEknoquW3P4qEfeEVmo86iG2RYGuiEZVJS02Ae7RwevrKxpEpAXGk4u3pBxnv69X8prP3EUmf49z1F2wRJx/Q0TLVSM+hfoJ5AI4G1y7rAXaxNY0m/bZ+Lpi9KEmlWGhiBYgKbWgeLRB783MM/sL5oHzOaAoOaug0hg==
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 09:15:08 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::48) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 09:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 09:15:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 30 Jun
 2022 09:15:07 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 30 Jun
 2022 02:15:05 -0700
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
Subject: [PATCH 4/6] nvmet: add Verify emulation support for bdev-ns
Date:   Thu, 30 Jun 2022 02:14:04 -0700
Message-ID: <20220630091406.19624-5-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9fcfbe26-892e-4b83-e0a6-08da5a79071a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wi5apg6Hf0mhSQUI8ImrZEbKM8DEJdk+0G7AGhcz+5ILEambabeQjASUwGnJF7wMbndLzMSz6HNeHv/GSq/9g1taFMs9AjUvSlxZt9DgsfMti4vWbZNZ7boJptJA9KFk2ckl32bYPCbdaJunG8nqBKXIGxDev6qoFCWC+pSMeDccOywtpjW77PDmwM7t/ByDSYZ/FC70pXP+CteBEkyyIS5fA+RIsZH7du77jrn8atWJjqLtT4ulKxa0j4+oRejhpFcoMm7cj2e9IvN3oLKBCszjTUUAXd/1OhqH9y+y889luVT3MvSNUQ0CoNc56XW/ax2zLaDukQHoPG83C0IYVGBlQ9N47p/jblheT8E/3xNJvax3POtRZGjfQL9D2VgUekhvqfEmrrseCK+tDlQ6XapwpsMCTe72HO3jt1Mcj65gZ4LYDObGUiCnJB4xve/412+lP8LXbIqNKBceXlkJrRhrhVrwR0CZNtcu2gs140t2fC6jb3/uD71zZ37sLsC1uAeycKBRB59zAQhr+8hGvh+0r2/AvyngBreJm9qY4EKmS7UkHy1wI23I6DBfAMfFH/wiNUv4itw9OxySqmEabFAg+rxYaFz7cAiHq9D5ouKAlz61eqnr0l/2E413OWYJEzBxY0/2jV0pP0K2OgS90fCzlQY+Uxv4kAKCqsryz/Xvk9x0lkI+ha7s1TyYqNpLbdYYGdIgWHib0WUOHZW5PofYEtITUkUeQ5r7ZxrCW/P2gV0xsIe0tk2+mcpxuLiHGE0SVea5ehjnkrf8f7dsCpZFZm0aKT9r4ofAJ+mh2uYDuZe2hTm1j9EluGBfqMk0kqHJK9GjrkX2CJ5SFkDKau4WoLiK19CNJA6lQlx1uUYh0kfRWC/JN8XyCdmp1vYQ
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(40460700003)(54906003)(110136005)(40480700001)(8936002)(15650500001)(82310400005)(36756003)(2906002)(7416002)(7406005)(5660300002)(356005)(16526019)(81166007)(70206006)(316002)(70586007)(4326008)(8676002)(7696005)(41300700001)(26005)(82740400003)(478600001)(186003)(1076003)(2616005)(107886003)(336012)(47076005)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:15:08.1997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcfbe26-892e-4b83-e0a6-08da5a79071a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Not all devices can support verify requests which can be mapped to
the controller specific command. This patch adds a way to emulate
REQ_OP_VERIFY for NVMeOF block device namespace. We add a new
workqueue to offload the emulation.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/core.c        | 14 ++++++--
 drivers/nvme/target/io-cmd-bdev.c | 56 +++++++++++++++++++++++++------
 drivers/nvme/target/nvmet.h       |  4 ++-
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 90e75324dae0..b701eeaf156a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -16,6 +16,7 @@
 #include "nvmet.h"
 
 struct workqueue_struct *buffered_io_wq;
+struct workqueue_struct *verify_wq;
 struct workqueue_struct *zbd_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
@@ -1611,10 +1612,16 @@ static int __init nvmet_init(void)
 
 	nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] = 1;
 
-	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
-	if (!zbd_wq)
+	verify_wq = alloc_workqueue("nvmet-verify-wq", WQ_MEM_RECLAIM, 0);
+	if (!verify_wq)
 		return -ENOMEM;
 
+	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
+	if (!zbd_wq) {
+		error = -ENOMEM;
+		goto out_free_verify_work_queue;
+	}
+
 	buffered_io_wq = alloc_workqueue("nvmet-buffered-io-wq",
 			WQ_MEM_RECLAIM, 0);
 	if (!buffered_io_wq) {
@@ -1645,6 +1652,8 @@ static int __init nvmet_init(void)
 	destroy_workqueue(buffered_io_wq);
 out_free_zbd_work_queue:
 	destroy_workqueue(zbd_wq);
+out_free_verify_work_queue:
+	destroy_workqueue(verify_wq);
 	return error;
 }
 
@@ -1656,6 +1665,7 @@ static void __exit nvmet_exit(void)
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
 	destroy_workqueue(zbd_wq);
+	destroy_workqueue(verify_wq);
 
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 6687e2665e26..721c8571a2da 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -447,35 +447,71 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
-static void nvmet_bdev_execute_verify(struct nvmet_req *req)
+static void __nvmet_req_to_verify_sectors(struct nvmet_req *req,
+		sector_t *sects, sector_t *nr_sects)
 {
 	struct nvme_verify_cmd *verify = &req->cmd->verify;
+
+	*sects = le64_to_cpu(verify->slba) << (req->ns->blksize_shift - 9);
+	*nr_sects = (((sector_t)le16_to_cpu(verify->length) + 1) <<
+			(req->ns->blksize_shift - 9));
+}
+
+static void nvmet_bdev_emulate_verify_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, b.work);
+	sector_t nr_sector;
+	sector_t sector;
+	int ret = 0;
+
+	__nvmet_req_to_verify_sectors(req, &sector, &nr_sector);
+	if (!nr_sector)
+		goto out;
+
+	/* blkdev_issue_verify() will automatically emulate */
+	ret = blkdev_issue_verify(req->ns->bdev, sector, nr_sector,
+			GFP_KERNEL);
+out:
+	nvmet_req_complete(req,
+		blk_to_nvme_status(req, errno_to_blk_status(ret)));
+}
+
+static void nvmet_bdev_submit_emulate_verify(struct nvmet_req *req)
+{
+	INIT_WORK(&req->b.work, nvmet_bdev_emulate_verify_work);
+	queue_work(verify_wq, &req->b.work);
+}
+
+static void nvmet_bdev_execute_verify(struct nvmet_req *req)
+{
 	struct bio *bio = NULL;
 	sector_t nr_sector;
 	sector_t sector;
-	int ret;
+	int ret = 0;
 
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
+	__nvmet_req_to_verify_sectors(req, &sector, &nr_sector);
+	if (!nr_sector)
+		goto out;
+
+	/* offload emulation */
 	if (!bdev_verify_sectors(req->ns->bdev)) {
-		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+		nvmet_bdev_submit_emulate_verify(req);
 		return;
 	}
 
-	sector = le64_to_cpu(verify->slba) << (req->ns->blksize_shift - 9);
-	nr_sector = (((sector_t)le16_to_cpu(verify->length) + 1) <<
-			(req->ns->blksize_shift - 9));
-
 	ret = __blkdev_issue_verify(req->ns->bdev, sector, nr_sector,
 			GFP_KERNEL, &bio);
-	if (bio) {
+	if (ret == 0 && bio) {
 		bio->bi_private = req;
 		bio->bi_end_io = nvmet_bio_done;
 		submit_bio(bio);
-	} else {
-		nvmet_req_complete(req, errno_to_nvme_status(req, ret));
+		return;
 	}
+out:
+	nvmet_req_complete(req, errno_to_nvme_status(req, ret));
 }
 
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69818752a33a..96e3f6eb4fef 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -326,7 +326,8 @@ struct nvmet_req {
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
 	union {
 		struct {
-			struct bio      inline_bio;
+			struct bio		inline_bio;
+			struct work_struct	work;
 		} b;
 		struct {
 			bool			mpool_alloc;
@@ -365,6 +366,7 @@ struct nvmet_req {
 };
 
 extern struct workqueue_struct *buffered_io_wq;
+extern struct workqueue_struct *verify_wq;
 extern struct workqueue_struct *zbd_wq;
 extern struct workqueue_struct *nvmet_wq;
 
-- 
2.29.0


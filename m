Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B00572F12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiGMHWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 03:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiGMHWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:22:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1175E2A1D;
        Wed, 13 Jul 2022 00:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTKFMF2paG6yufYTAjQFKPrKZC+TyJNFwFaCUpvcu9IqkNqZcTUZwiUDATlbfSsJfAd2WIY8LiYqDajdXA1+HbWhpmi09T3kZW8/vorzbtIagiLk3+DGCBBT3l0dCIDyQZyhsBnmE2FyIt+LgvLpofVkRJDWMTtEfS1bl1W73Lh8smjnJz4CSlvroAmK8KdEQEZM0U1b9kYwBjUPJNIsl3lZIIkt6Mj3+X3QhNTEduNkNWQS3jzrwdP63vyvACeBSw6Zh3381jkv0DlHQYAoWJeGHbuYxvZm9mQJNx5r4fFdEIC2wqj9YgFxwTJgYYLc1AMkZphYKd35H1GBKLQzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEql+7Qc/6ZjUNhYo95lXJF79oRQEGSSmWcCMAsILWc=;
 b=kBwFN5nz1BpgyptWql432cPxDMsvJqxzjAnWrQMwEph8a/W1dxbtN0MHNnBbQTN7ndaNHBc+Jt0zBIX6QJBNUtqZhBCkoqhxaJddxY8f0W4mkL1U+rnAz1UUIc/WW4YtEGRP2V8X0IV7+PZnkpgshXZoSt13+iNd48aHi3UpLrwuPr1ojV7Lx3au7SssEzIvuIB9/OK6W+fvwhRiDZJ8QhpWxYcjk5tT+1VaD/CypjQqzBQY4sdFROt9BuAANwnnA8HCxns6OfIMkYIBWopkEWmuKKtYP6SKmMxUAWeiwSYOdry/nVR4fNobGLuTY8/QS8iAxUZv+CG8LZ6V/ZPHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEql+7Qc/6ZjUNhYo95lXJF79oRQEGSSmWcCMAsILWc=;
 b=YyhXhAdjA5wuQDL5GVdgqOge6Jct9/qwjIqBi7KzPek9pdskboRMJkR28yqlqfxE9DceCFzy7PpmvlWOaD7VqyYWuGRc1hwAfmZ5q7V1CrZ29wrW7tLrULvf/xLU9o6I5T/QeuOGzlJZL/7DKmMmdFCADINXlQRNWxWlLXa4XjPUIBH+9DleLhloQTrNtUW14aPvjafOWHG0xH96m9Q/8LVYCWpgmL5hbIStufVNhVH5vfKcSfwTcCY6uvP/ixu4G7snxmVEIEF7wF8hO1QzRktRqTP9vSkI7nawufnDfXgrXI5dInIf2LG8vplC0q0YA1hhAUEX/lk5S/Yb96QomQ==
Received: from MW2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:907:1::33)
 by BY5PR12MB4641.namprd12.prod.outlook.com (2603:10b6:a03:1f7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 07:22:03 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::b4) by MW2PR16CA0056.outlook.office365.com
 (2603:10b6:907:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Wed, 13 Jul 2022 07:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 07:22:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 07:22:02 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 00:22:00 -0700
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
Subject: [PATCH V2 4/6] nvmet: add Verify emulation support for bdev-ns
Date:   Wed, 13 Jul 2022 00:20:17 -0700
Message-ID: <20220713072019.5885-5-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b768905-06b9-41ab-7e05-08da64a06255
X-MS-TrafficTypeDiagnostic: BY5PR12MB4641:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PW1Weqx/lFJ/zCsmMvW7lboCJnFZTpqs/yAWpuEipo+fkW1ve6dmburMRj69tScSgSyzNIrNvIFZUIUXkXxUNq8alnzs4rRKUhj4tLuTCRjYthZPhIQv9WIims+9edY0RhsbVn9rD61jt8CQTK8ad6DrRnyyIzsYySBbAoTLiOdw9w+qMwCEjdsZnxBD/5kgqRHXa82KI1ZfTsHA9cjHBZSW0X9/1Y5+2csxBawHSmBaT7FnHO0+aC7H7QCq1k1Zhxoe7ehui4/nrqFvIIAwvJwn0x6H+vzrsNOPyIKBRThbA0tCM4lRu4Hn5WRWnI+AjMuDdZmp/1erNQnc+DYYxhoJrLKRRGvf6tJYybYuewzPvUi7gScjxKa3cdZph9E2AaqxeishOD3TiDpOR1l9iKwxRCPnjZcmQv6epMMt6Q8xPUjW/hMbYSs03b/9zId/vhaEfGTz3jzwjU14/byhXtIyheJO9KPgUwP6pwgADvTRE5f9J0Aqeo8L/f18QWVdXcEkTHV5Oa9rwtsg3Y4wxdeMQcf1iGGkD8wLHCZRybrimJe/lDMkYyNI8sy2oWfFkSCkUs49IelnnUhta7BYS9HlVCEKPDnFpP6MXrwjKx8k9UXX2ARbxh28v37zR051BL5PSpDwSxATMHMmssqofHVWvu/JjMtDg3X4GGDMImCs4O/ZM+YOubROMV5ONKXX2rw0N9etEsTIqmdLWz0d7EzN7sdCA/7y+9z0WY0nWCSP8YeVtsY1ATgmOnMJRamuZmtcKJpkas8o1rq5VXlrVb507/CJ7tSQ9fmffRPrajjNKbMIixvrg8sL9IzfJU5CnlNM0qw49ifHV8pL2TbtjE6NuvtbyRb4Y8co9iQQfYuxDg60VAHVCRu6yNA2rWu3
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(40470700004)(46966006)(1076003)(70586007)(186003)(8676002)(2616005)(16526019)(7416002)(316002)(107886003)(426003)(336012)(70206006)(4326008)(81166007)(6666004)(82310400005)(7696005)(47076005)(40480700001)(36756003)(41300700001)(478600001)(82740400003)(40460700003)(110136005)(54906003)(8936002)(356005)(2906002)(7406005)(36860700001)(83380400001)(15650500001)(26005)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:22:03.2567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b768905-06b9-41ab-7e05-08da64a06255
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4641
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
REQ_OP_VERIFY for NVMeOF block device namespace.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 48 ++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 82c341f90f06..aec287d3b7d7 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -446,35 +446,63 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
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
+static void nvmet_bdev_submit_emulate_verify(struct nvmet_req *req)
+{
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
-- 
2.29.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C02F572F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 09:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiGMHWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiGMHWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:22:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B42E2A19;
        Wed, 13 Jul 2022 00:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8QHpme/PzxGqTqwsDTW/Y7Bvik8kphIV7peU2jC4015A2lr6fbs5RgsVW+yQ6ZuzloqMjKXgmJFhsA8gslAf3o1d+tmIR1xjKo90dOVEr8Ons5lz2QLvZolF2NMxLIJiLIjaKoBiVNPO39vZ2VL8q4wWXfaGpjk6Pyhdq+AOP2wbdzeQFyw7rJhLCfQ07wmOT/JMNt/qE5m/WAj8eBJ5ABN4DtdLsxz+m5g0Nt3ieMqSs6tRZuowzFS336jVBYm2vQErVqmPlo9XqM9AoRGSPpbU4NqyNxu4ScknNJCietTZSn2VxqA1N/nvgwmTgnTYfqep7ySN05mTPYxunvESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdM5KiJTOKaOqKlARvS1nTvEPZ1AO+iGJBYnQlmew5o=;
 b=ZwjHFOPT4tRcrnMszQwNiX8uakHYFO/9Riiu1v1+dhtFCdX9gQMPWlBWFdfMkzVvMwR9H/aL8XTKnbCY7Zt4OsJ8o9KmGIBfSIMzdj3xF9lbQ5FkzGJQU/3hTHKfXlZQ6Q+BvCYrsYK75VwCGTvqIYcTReahDXx0pYGcLOHguFGtXGLETPyIlBigvfWn+UfIgatjJ/fdhBb31vaPJBYMge6j+noRtl/6UlUarwSIuFdB2KbVjokLJ4zTIyGsaWRejaLF6F+tAUYuJEZaf5gMF8u+NP6932VXUQeYt2jhBBRMq5r9luqMrmKSPaEpQ4MQ3C0fKKtmQsAfSHpAdXQ2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdM5KiJTOKaOqKlARvS1nTvEPZ1AO+iGJBYnQlmew5o=;
 b=eM5DvZjrIenCoHVJ+euS5MBIx6O4PSQ9lzt01p3lx7CMwlCUBlbQh9Rh+X9oxPjS6K020ntBqG8S4dTBr9lLYEYUg1OK8DoUsztdjkbps+Y4u8KqzvQIH+3QAIhyVdqxBt3CIdsVfzamFoOQ4PdQnttkc2w2pPfdYF/YoFudWf1nNPIQSNr03tQW4pv3kZWW6ZlxRqAk4r1DYb4TKLkG+gI9Fl+Cu1DWLV44l6wiRDhSZ1tBmf4/OeZVyws0TGeUttPntNhQdraC5rZYwGk6zviT10JlcKnUmBUwZI/2czmj4TyCvTpEq7k0c6GG6hDmp6khvhPv8OcDXxkYi/xjow==
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by DM5PR12MB1627.namprd12.prod.outlook.com (2603:10b6:4:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 07:22:29 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f2) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Wed, 13 Jul 2022 07:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 07:22:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 07:22:27 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 00:22:25 -0700
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
Subject: [PATCH V2 6/6] scsi: sd: add support for REQ_OP_VERIFY
Date:   Wed, 13 Jul 2022 00:20:19 -0700
Message-ID: <20220713072019.5885-7-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7aac256d-1c1c-46f6-92c7-08da64a0716d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1627:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ec26Jg94V2AJOlwQEfKM80zlZ2+tD/Qp9BeD0p4m4/E6E7OpP7bmq6GWhIX3WwFRohvKg/30D4Uh7HftZ+O6mbC/6z2Ztjb/m8l0HmZ/mig7GRoSBBouPnMj6KQBTpi8Zlnhg0ueMs2wCUu0AhXNqw847C9YkdWCKZ+3U0SPGXockGBjsdVo8eqT6SKmphJdsX9KazbOgZFKGYRnADCoFhkzIcrm5/ZyElizH/GKKB5nZLjuZKIkegCJhAj/vGq/XltEnlCpY5v+dvyHUDfSpl4cvJktD2ytBnUDo7gUsvPGICqXq1zQJxGCnMxIeaYArsrPxyjOdPboRJdRA6HlAAeywrpcpcGiKnOOQF/yznajYCbC7qmxnNfLTs+3D6E6WJ/rDEGnGk/VOdKzilEyyngmZ9uSgQJ7cEHtBaGa/vM1b5960BqDLApmhbHc629c4WFOczWJNLoFt/L3vyZCalB9qENgcEyICH7p+hGCNQFOXj8F9ajm++JvrG5DxH82JLPawy1P40XBUpvRMRuNG7Sw35A1pKgZEc55sJQOS2+dvZhxxceTKftDqP7QqMBCvOyNIsu0DbflqqJP/wXwE+ndONqYEJiRfnQJn275b+iCThLXw1GFMXDeqW0pbOgOrWLbv2+DWtZvLQypU3ghNe3OYKn5a9djt6cMWSRgHZRH5invKZW3sz60+gTKOJcHtDAmXrsztWlu+p+KJbp5rMDQZBMsHRdC5Ttto5ZhInkGEe2bka3Cyu7KCzj92dP4FJR8A1PdbuxYg87aPrLFxv30GOZnDuDmzk1Jg0uTjJbkw8s6oIZdauuRrI23trWEhTcLKnVaNlQCwzsXfX9IOtZwVyAxbKswX7YFbIOxvPI+9L8FZMgxLroLdi2b0wD
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(40470700004)(36840700001)(110136005)(4326008)(36860700001)(186003)(70586007)(478600001)(316002)(5660300002)(41300700001)(8676002)(70206006)(107886003)(8936002)(6666004)(1076003)(26005)(7416002)(81166007)(16526019)(54906003)(356005)(2616005)(82740400003)(7406005)(47076005)(426003)(336012)(2906002)(83380400001)(36756003)(40480700001)(40460700003)(82310400005)(7696005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:22:28.5804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aac256d-1c1c-46f6-92c7-08da64a0716d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1627
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support to handle REQ_OP_VERIFY req_op and map it on VERIFY (16)
or VERIFY (10) in the sd driver. In case SCSI command VERIFY (16) is not
supported use SCSI command VERIFY (10). Tested with scsi_debug.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/scsi/sd.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sd.h |   5 ++
 2 files changed, 129 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index eb02d939dd44..8ba8bdd78ebd 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -101,6 +101,7 @@ MODULE_ALIAS_SCSI_DEVICE(TYPE_ZBC);
 
 static void sd_config_discard(struct scsi_disk *, unsigned int);
 static void sd_config_write_same(struct scsi_disk *);
+static void sd_config_verify(struct scsi_disk *sdkp);
 static int  sd_revalidate_disk(struct gendisk *);
 static void sd_unlock_native_capacity(struct gendisk *disk);
 static int  sd_probe(struct device *);
@@ -519,6 +520,43 @@ max_write_same_blocks_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(max_write_same_blocks);
 
+static ssize_t
+max_verify_blocks_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct scsi_disk *sdkp = to_scsi_disk(dev);
+
+	return sprintf(buf, "%u\n", sdkp->max_verify_blocks);
+}
+
+static ssize_t
+max_verify_blocks_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct scsi_disk *sdkp = to_scsi_disk(dev);
+	struct scsi_device *sdp = sdkp->device;
+	unsigned long max;
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (sdp->type != TYPE_DISK && sdp->type != TYPE_ZBC)
+		return -EINVAL;
+
+	err = kstrtoul(buf, 10, &max);
+
+	if (err)
+		return err;
+
+	sdkp->max_verify_blocks = max;
+
+	sd_config_verify(sdkp);
+
+	return count;
+}
+static DEVICE_ATTR_RW(max_verify_blocks);
+
 static ssize_t
 zoned_cap_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -579,6 +617,7 @@ static struct attribute *sd_disk_attrs[] = {
 	&dev_attr_provisioning_mode.attr,
 	&dev_attr_zeroing_mode.attr,
 	&dev_attr_max_write_same_blocks.attr,
+	&dev_attr_max_verify_blocks.attr,
 	&dev_attr_max_medium_access_timeouts.attr,
 	&dev_attr_zoned_cap.attr,
 	&dev_attr_max_retries.attr,
@@ -1018,6 +1057,68 @@ static void sd_config_write_same(struct scsi_disk *sdkp)
 					 (logical_block_size >> 9));
 }
 
+static blk_status_t sd_setup_verify16_cmnd(struct scsi_cmnd *cmd, u64 lba,
+					   u32 nr_blocks)
+{
+	cmd->cmd_len = 16;
+	cmd->cmnd[0] = VERIFY_16;
+	put_unaligned_be64(lba, &cmd->cmnd[2]);
+	put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
+	cmd->cmnd[14] = 0;
+	cmd->cmnd[15] = 0;
+
+	return BLK_STS_OK;
+}
+
+static blk_status_t sd_setup_verify10_cmnd(struct scsi_cmnd *cmd, u64 lba,
+					   u32 nr_blocks)
+{
+	if (lba > 0xffffffff && nr_blocks > 0xffff)
+		return BLK_STS_NOTSUPP;
+
+	cmd->cmd_len = 10;
+	cmd->cmnd[0] = VERIFY;
+	put_unaligned_be32((u32)lba, &cmd->cmnd[2]);
+	put_unaligned_be16((u16)nr_blocks, &cmd->cmnd[6]);
+	cmd->cmnd[9] = 0;
+
+	return BLK_STS_OK;
+}
+
+static blk_status_t sd_setup_verify_cmnd(struct scsi_cmnd *cmd)
+{
+	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
+	struct scsi_device *sdp = cmd->device;
+	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
+	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
+
+	if (!sdkp->verify16 && !sdkp->verify10)
+		goto out;
+
+	cmd->allowed = SD_MAX_RETRIES;
+	cmd->sc_data_direction = DMA_NONE;
+	cmd->transfersize = 0;
+	/* skip veprotect / dpo / bytchk */
+	cmd->cmnd[1] = 0;
+
+	if (sdkp->verify16)
+		return sd_setup_verify16_cmnd(cmd, lba, nr_blocks);
+	if (sdkp->verify10)
+		return sd_setup_verify10_cmnd(cmd, lba, nr_blocks);
+out:
+	return BLK_STS_TARGET;
+}
+
+static void sd_config_verify(struct scsi_disk *sdkp)
+{
+	unsigned int max_verify_sectors = sdkp->max_verify_blocks;
+	unsigned int logical_bs = sdkp->device->sector_size;
+	struct request_queue *q = sdkp->disk->queue;
+
+	blk_queue_max_verify_sectors(q, max_verify_sectors * (logical_bs >> 9));
+}
+
 static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
@@ -1244,6 +1345,8 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 		}
 	case REQ_OP_WRITE_ZEROES:
 		return sd_setup_write_zeroes_cmnd(cmd);
+	case REQ_OP_VERIFY:
+		return sd_setup_verify_cmnd(cmd);
 	case REQ_OP_FLUSH:
 		return sd_setup_flush_cmnd(cmd);
 	case REQ_OP_READ:
@@ -1935,6 +2038,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 	switch (req_op(req)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_VERIFY:
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_ZONE_OPEN:
@@ -3021,6 +3125,24 @@ static void sd_read_write_same(struct scsi_disk *sdkp, unsigned char *buffer)
 		sdkp->ws10 = 1;
 }
 
+static void sd_read_verify(struct scsi_disk *sdkp, unsigned char *buffer)
+{
+	struct scsi_device *sdev = sdkp->device;
+
+	if (scsi_report_opcode(sdev, buffer, SD_BUF_SIZE, VERIFY_16)) {
+		sd_printk(KERN_DEBUG, sdkp, "VERIFY16 supported\n");
+		sdkp->verify16 = 1;
+		sdkp->max_verify_blocks = SD_MAX_VERIFY16_BLOCKS;
+		return;
+	}
+
+	if (scsi_report_opcode(sdev, buffer, SD_BUF_SIZE, VERIFY)) {
+		sd_printk(KERN_DEBUG, sdkp, "VERIFY10 supported\n");
+		sdkp->verify10 = 1;
+		sdkp->max_verify_blocks = SD_MAX_VERIFY10_BLOCKS;
+	}
+}
+
 static void sd_read_security(struct scsi_disk *sdkp, unsigned char *buffer)
 {
 	struct scsi_device *sdev = sdkp->device;
@@ -3264,6 +3386,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		sd_read_cache_type(sdkp, buffer);
 		sd_read_app_tag_own(sdkp, buffer);
 		sd_read_write_same(sdkp, buffer);
+		sd_read_verify(sdkp, buffer);
 		sd_read_security(sdkp, buffer);
 		sd_config_protection(sdkp);
 	}
@@ -3312,6 +3435,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	set_capacity_and_notify(disk, logical_to_sectors(sdp, sdkp->capacity));
 	sd_config_write_same(sdkp);
+	sd_config_verify(sdkp);
 	kfree(buffer);
 
 	/*
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5eea762f84d1..249100e2ea1f 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -49,6 +49,8 @@ enum {
 	SD_MAX_XFER_BLOCKS = 0xffffffff,
 	SD_MAX_WS10_BLOCKS = 0xffff,
 	SD_MAX_WS16_BLOCKS = 0x7fffff,
+	SD_MAX_VERIFY10_BLOCKS = 0xffff,
+	SD_MAX_VERIFY16_BLOCKS = 0xffffff,
 };
 
 enum {
@@ -118,6 +120,7 @@ struct scsi_disk {
 	u32		max_xfer_blocks;
 	u32		opt_xfer_blocks;
 	u32		max_ws_blocks;
+	u32		max_verify_blocks;
 	u32		max_unmap_blocks;
 	u32		unmap_granularity;
 	u32		unmap_alignment;
@@ -145,6 +148,8 @@ struct scsi_disk {
 	unsigned	lbpvpd : 1;
 	unsigned	ws10 : 1;
 	unsigned	ws16 : 1;
+	unsigned        verify10 : 1;
+	unsigned        verify16 : 1;
 	unsigned	rc_basis: 2;
 	unsigned	zoned: 2;
 	unsigned	urswrz : 1;
-- 
2.29.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06437BAA6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjJETmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjJETmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:42:15 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182EEE;
        Thu,  5 Oct 2023 12:42:12 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c88b46710bso4274205ad.1;
        Thu, 05 Oct 2023 12:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696534932; x=1697139732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oJTd69CoKLWl87We97dOlSKbFphrBtZKJQ8rsLUNkU=;
        b=xA8Hly4nus4+MZmZbBA/9jHukiDTAsV7MYllj2X0XbZK4V7GEbcMu++Sha9/M08Fub
         Ax8vdGgzbLV5xjmipQddqdadJhLNT+4IJP9qlDg7XYGDO9+tAPtCPkVrkI2VRpP4zhaO
         DTgHod9SZUt5YLNAf+Gh00h/6HKDV5HNvT1ImmEelLHuke2KpQA1jtgbv06z8K8DfgZS
         UA4sNnwwMlVgMWzFqyby9zIQgqE8XfbJyd57E8gR4355A9axsiMZ3M73B40ZNT4rTb6p
         5czQRPjFO/q+RjXcL7pdOTo32YUFoJLtm8cvjHINI4DZMUbljpcLhxONwuac2q402Dnk
         sfGg==
X-Gm-Message-State: AOJu0Yx5JHLlV+tFbH9RXGyWGl7loS6plytF/Bk9WtlXe1Jm063WOEpA
        7SI7myHudG+9UmL8tZW4DE4=
X-Google-Smtp-Source: AGHT+IGIzRoe4LQ0aMD9as71YQpkNg2eTYx0OWPUWG7k/q574boJXHHOA9PcwumdLeg2zOKnJV6Mlg==
X-Received: by 2002:a17:902:d511:b0:1bf:3c10:1d72 with SMTP id b17-20020a170902d51100b001bf3c101d72mr7609759plg.66.1696534932235;
        Thu, 05 Oct 2023 12:42:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001a9b29b6759sm2129596plf.183.2023.10.05.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:42:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 08/15] sd: Translate data lifetime information
Date:   Thu,  5 Oct 2023 12:40:54 -0700
Message-ID: <20231005194129.1882245-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231005194129.1882245-1-bvanassche@acm.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recently T10 standardized SBC constrained streams. This mechanism allows
to pass data lifetime information to SCSI devices in the group number
field. Add support for translating write hint information into a
permanent stream number in the sd driver. Use WRITE(10) instead of
WRITE(6) if data lifetime information is present because the WRITE(6)
command does not have a GROUP NUMBER field.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sd.c | 99 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/sd.h |  2 +
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 879edbc1a065..5d4b6c8cfd50 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -47,6 +47,7 @@
 #include <linux/blkpg.h>
 #include <linux/blk-pm.h>
 #include <linux/delay.h>
+#include <linux/fs-lifetime.h>
 #include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/string_helpers.h>
@@ -1001,12 +1002,38 @@ static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
 	return BLK_STS_OK;
 }
 
+/**
+ * sd_group_number() - Compute the GROUP NUMBER field
+ * @cmd: SCSI command for which to compute the value of the six-bit GROUP NUMBER
+ *	field.
+ *
+ * From "SBC-5 Constrained Streams with Data Lifetimes"
+ * (https://www.t10.org/cgi-bin/ac.pl?t=d&f=23-024r3.pdf):
+ * 0: no relative lifetime.
+ * 1: shortest relative lifetime.
+ * 2: second shortest relative lifetime.
+ * 3 - 0x3d: intermediate relative lifetimes.
+ * 0x3e: second longest relative lifetime.
+ * 0x3f: longest relative lifetime.
+ */
+static u8 sd_group_number(struct scsi_cmnd *cmd)
+{
+	const struct request *rq = scsi_cmd_to_rq(cmd);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
+	const u32 max_gn = min_t(u32, sdkp->permanent_stream_count, 0x3f);
+
+	if (!sdkp->rscs)
+		return 0;
+	return min(IOPRIO_PRIO_LIFETIME(rq->ioprio), max_gn);
+}
+
 static blk_status_t sd_setup_rw32_cmnd(struct scsi_cmnd *cmd, bool write,
 				       sector_t lba, unsigned int nr_blocks,
 				       unsigned char flags, unsigned int dld)
 {
 	cmd->cmd_len = SD_EXT_CDB_SIZE;
 	cmd->cmnd[0]  = VARIABLE_LENGTH_CMD;
+	cmd->cmnd[6]  = sd_group_number(cmd);
 	cmd->cmnd[7]  = 0x18; /* Additional CDB len */
 	cmd->cmnd[9]  = write ? WRITE_32 : READ_32;
 	cmd->cmnd[10] = flags;
@@ -1025,7 +1052,7 @@ static blk_status_t sd_setup_rw16_cmnd(struct scsi_cmnd *cmd, bool write,
 	cmd->cmd_len  = 16;
 	cmd->cmnd[0]  = write ? WRITE_16 : READ_16;
 	cmd->cmnd[1]  = flags | ((dld >> 2) & 0x01);
-	cmd->cmnd[14] = (dld & 0x03) << 6;
+	cmd->cmnd[14] = ((dld & 0x03) << 6) | sd_group_number(cmd);
 	cmd->cmnd[15] = 0;
 	put_unaligned_be64(lba, &cmd->cmnd[2]);
 	put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
@@ -1040,7 +1067,7 @@ static blk_status_t sd_setup_rw10_cmnd(struct scsi_cmnd *cmd, bool write,
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = write ? WRITE_10 : READ_10;
 	cmd->cmnd[1] = flags;
-	cmd->cmnd[6] = 0;
+	cmd->cmnd[6] = sd_group_number(cmd);
 	cmd->cmnd[9] = 0;
 	put_unaligned_be32(lba, &cmd->cmnd[2]);
 	put_unaligned_be16(nr_blocks, &cmd->cmnd[7]);
@@ -1177,7 +1204,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
 	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
-		   sdp->use_10_for_rw || protect) {
+		   sdp->use_10_for_rw || protect ||
+		   IOPRIO_PRIO_LIFETIME(rq->ioprio)) {
 		ret = sd_setup_rw10_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
 	} else {
@@ -2912,6 +2940,70 @@ sd_read_cache_type(struct scsi_disk *sdkp, unsigned char *buffer)
 	sdkp->DPOFUA = 0;
 }
 
+static bool sd_is_perm_stream(struct scsi_disk *sdkp, unsigned stream_id)
+{
+	u8 cdb[16] = { SERVICE_ACTION_IN_16, SAI_GET_STREAM_STATUS };
+	struct {
+		struct scsi_stream_status_header h;
+		struct scsi_stream_status s;
+	} buf;
+	struct scsi_device *sdev = sdkp->device;
+	struct scsi_sense_hdr sshdr;
+	const struct scsi_exec_args exec_args = {
+		.sshdr = &sshdr,
+	};
+	int res;
+
+	put_unaligned_be16(stream_id, &cdb[4]);
+	put_unaligned_be32(sizeof(buf), &cdb[10]);
+
+	res = scsi_execute_cmd(sdev, cdb, REQ_OP_DRV_IN, &buf, sizeof(buf),
+			       SD_TIMEOUT, sdkp->max_retries, &exec_args);
+	if (res < 0)
+		return false;
+	if (scsi_status_is_check_condition(res) && scsi_sense_valid(&sshdr))
+		sd_print_sense_hdr(sdkp, &sshdr);
+	if (res)
+		return false;
+	if (get_unaligned_be32(&buf.h.len) < sizeof(struct scsi_stream_status))
+		return false;
+	return buf.h.stream_status[0].perm;
+}
+
+static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
+{
+	struct scsi_device *sdp = sdkp->device;
+	const struct scsi_io_group_descriptor *desc, *start, *end;
+	struct scsi_sense_hdr sshdr;
+	struct scsi_mode_data data;
+	int res;
+
+	res = scsi_mode_sense(sdp, /*dbd=*/0x8, /*modepage=*/0x0a,
+			      /*subpage=*/0x05, buffer, SD_BUF_SIZE,
+			      SD_TIMEOUT, sdkp->max_retries, &data, &sshdr);
+	if (res < 0)
+		return;
+	start = (void *)buffer + data.header_length + 16;
+	end = (void *)buffer + ALIGN_DOWN(data.header_length + data.length,
+					  sizeof(*end));
+	/*
+	 * From "SBC-5 Constrained Streams with Data Lifetimes": Device severs
+	 * should assign the lowest numbered stream identifiers to permanent
+	 * streams.
+	 */
+	for (desc = start; desc < end; desc++)
+		if (!desc->st_enble || !sd_is_perm_stream(sdkp, desc - start))
+			break;
+	sdkp->permanent_stream_count = desc - start;
+	if (sdkp->rscs && sdkp->permanent_stream_count < 2)
+		sd_printk(KERN_INFO, sdkp,
+			  "Unexpected: RSCS has been set and the permanent stream count is %u\n",
+			  sdkp->permanent_stream_count);
+	else if (sdkp->permanent_stream_count)
+		sd_printk(KERN_INFO, sdkp, "permanent stream count = %d\n",
+			  sdkp->permanent_stream_count);
+}
+
 /*
  * The ATO bit indicates whether the DIF application tag is available
  * for use by the operating system.
@@ -3395,6 +3487,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 		sd_read_write_protect_flag(sdkp, buffer);
 		sd_read_cache_type(sdkp, buffer);
+		sd_read_io_hints(sdkp, buffer);
 		sd_read_app_tag_own(sdkp, buffer);
 		sd_read_write_same(sdkp, buffer);
 		sd_read_security(sdkp, buffer);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 84685168b6e0..570d5a72749a 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -125,6 +125,8 @@ struct scsi_disk {
 	unsigned int	physical_block_size;
 	unsigned int	max_medium_access_timeouts;
 	unsigned int	medium_access_timed_out;
+			/* number of permanent streams */
+	u16		permanent_stream_count;
 	u8		media_present;
 	u8		write_prot;
 	u8		protection_type;/* Data Integrity Field */

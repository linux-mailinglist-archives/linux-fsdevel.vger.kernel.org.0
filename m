Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233547A8C95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjITTQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 15:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjITTP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:15:29 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5178D1A3;
        Wed, 20 Sep 2023 12:15:02 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-68fe2470d81so120546b3a.1;
        Wed, 20 Sep 2023 12:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237301; x=1695842101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/is31waIhLaBGz1oOIGTG3mks603Pg7X+IuJuOt0qk=;
        b=dXbcJflm9aybydbn9wsUjmU7mCRAaYRQwxI/6Lw8990GQCvsLsejAGVIdB8Jeh9Ouj
         RuFF+GEyf8Ln3PKJUHv7sTeVE4NszhKbqDSok6Q3pOSK4SJdQNrL62cqxXUoM4v1ttbP
         0DED5XrE5liEPrqK5Rvx31wYZONCXQbrxb/m3XCABrAJhqiqdi611Su8r3Fh5WVzbOC4
         +xJ0li/KYrOsfvwbaWrsDmczWpB/q1iXg5x8QnZ9YWN9968l1Yivtu9mN+UbKBvAdHMN
         B6pkpdOAnUbjeHFctIstAWR78NiyFpBxyoRzcET5rM3vPPGueHywc0qCwRYwZZviF/8E
         hbkw==
X-Gm-Message-State: AOJu0YyRuoXRw1Z6kCdl8IGEoyx3noI4RVeAi7rvqA8Mh/3RVfC63OFJ
        p89LXon7YrV8/LbzMIMlcSbA8Z2m0HU=
X-Google-Smtp-Source: AGHT+IEdqtp4V79ZNmd2wuOXg/SD2hXeDpaPOQzvt5T3nGHdbKyqFHdYtH2u6X7PMnoNgSI1ooVn2A==
X-Received: by 2002:a17:90a:bf16:b0:267:a859:dfef with SMTP id c22-20020a17090abf1600b00267a859dfefmr3363008pjs.27.1695237301335;
        Wed, 20 Sep 2023 12:15:01 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090a8c0d00b002633fa95ac2sm1656318pjo.13.2023.09.20.12.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:15:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 07/13] sd: Translate data lifetime information
Date:   Wed, 20 Sep 2023 12:14:32 -0700
Message-ID: <20230920191442.3701673-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920191442.3701673-1-bvanassche@acm.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recently T10 standardized SBC constrained streams. This mechanism enables
passing data lifetime information to SCSI devices in the group number
field. Add support for translating write hint information into a
permanent stream number in the sd driver.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sd.c | 65 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/scsi/sd.h |  1 +
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 879edbc1a065..7bbc58cd99d1 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1001,12 +1001,38 @@ static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
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
+	const int max_gn = min_t(u16, sdkp->permanent_stream_count, 0x3f);
+
+	if (!sdkp->rscs || rq->write_hint == WRITE_LIFE_NOT_SET)
+		return 0;
+	return min(rq->write_hint - WRITE_LIFE_NONE, max_gn);
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
@@ -1025,7 +1051,7 @@ static blk_status_t sd_setup_rw16_cmnd(struct scsi_cmnd *cmd, bool write,
 	cmd->cmd_len  = 16;
 	cmd->cmnd[0]  = write ? WRITE_16 : READ_16;
 	cmd->cmnd[1]  = flags | ((dld >> 2) & 0x01);
-	cmd->cmnd[14] = (dld & 0x03) << 6;
+	cmd->cmnd[14] = ((dld & 0x03) << 6) | sd_group_number(cmd);
 	cmd->cmnd[15] = 0;
 	put_unaligned_be64(lba, &cmd->cmnd[2]);
 	put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
@@ -1040,7 +1066,7 @@ static blk_status_t sd_setup_rw10_cmnd(struct scsi_cmnd *cmd, bool write,
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = write ? WRITE_10 : READ_10;
 	cmd->cmnd[1] = flags;
-	cmd->cmnd[6] = 0;
+	cmd->cmnd[6] = sd_group_number(cmd);
 	cmd->cmnd[9] = 0;
 	put_unaligned_be32(lba, &cmd->cmnd[2]);
 	put_unaligned_be16(nr_blocks, &cmd->cmnd[7]);
@@ -1177,7 +1203,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
 	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
-		   sdp->use_10_for_rw || protect) {
+		   sdp->use_10_for_rw || protect ||
+		   rq->write_hint != WRITE_LIFE_NOT_SET) {
 		ret = sd_setup_rw10_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
 	} else {
@@ -2912,6 +2939,37 @@ sd_read_cache_type(struct scsi_disk *sdkp, unsigned char *buffer)
 	sdkp->DPOFUA = 0;
 }
 
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
+	end = (void *)buffer + ((data.header_length + data.length)
+				& ~(sizeof(*end) - 1));
+	/*
+	 * From "SBC-5 Constrained Streams with Data Lifetimes": Device severs
+	 * should assign the lowest numbered stream identifiers to permanent
+	 * streams.
+	 */
+	for (desc = start; desc < end; desc++)
+		if (!desc->st_enble)
+			break;
+	sdkp->permanent_stream_count = desc - start;
+	if (sdkp->rscs && sdkp->permanent_stream_count < 2)
+		sdev_printk(KERN_INFO, sdp,
+			    "Unexpected: RSCS has been set and the permanent stream count is %u\n",
+			    sdkp->permanent_stream_count);
+}
+
 /*
  * The ATO bit indicates whether the DIF application tag is available
  * for use by the operating system.
@@ -3395,6 +3453,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 		sd_read_write_protect_flag(sdkp, buffer);
 		sd_read_cache_type(sdkp, buffer);
+		sd_read_io_hints(sdkp, buffer);
 		sd_read_app_tag_own(sdkp, buffer);
 		sd_read_write_same(sdkp, buffer);
 		sd_read_security(sdkp, buffer);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 84685168b6e0..1863de5ebae4 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -125,6 +125,7 @@ struct scsi_disk {
 	unsigned int	physical_block_size;
 	unsigned int	max_medium_access_timeouts;
 	unsigned int	medium_access_timed_out;
+	u16		permanent_stream_count;	/* maximum number of streams */
 	u8		media_present;
 	u8		write_prot;
 	u8		protection_type;/* Data Integrity Field */

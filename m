Return-Path: <linux-fsdevel+bounces-6448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1EC817E8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5640328675E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728AC79F5;
	Tue, 19 Dec 2023 00:08:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A064160;
	Tue, 19 Dec 2023 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c701bd98f3so1399234a12.1;
        Mon, 18 Dec 2023 16:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944535; x=1703549335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QtuSQC8y8CtahqMJ6ez7Tdj3INrdO7cJer6sFWBy4Y=;
        b=Y17cRX7HzOBG/RAsDjSd7LNdtcNuGlwU0+0yz5qwONFo8xxFBYpgMVy8ZWI7WzGKGI
         6t2w3c1Hsa3UMjiryckCgtMp+xwT+ndz15ZhJh3xujD/pblcMyvT6KM8hXMBJN8tnw0P
         tACfluq2BUriy02isWr6rHvwxLfEMIeF82lWaAMfG7p890YXfn2K0Nlk7vkDnmeGAJH7
         XDeMr82VwY4lXNE5PtJolS09lSl7gUv/onw3d4K2ODVs5KT1wcNLIg3W76WSV0q8xrPk
         unD0bQe5+3Kab4MvdRibBh9efUICnNBWwmZGcTakwlAQOwV0JGKf/H2Feojj7TjyZUSF
         WpQg==
X-Gm-Message-State: AOJu0YwKxyyQPct+rmOcMzHRZpN5LWplKxpL4aFoi8qxD/fWolcipP3f
	RCfqqBrcBQ8waHNOUkxNcDw=
X-Google-Smtp-Source: AGHT+IG5lPc+tMxlLP8q2PQKaiiaVztEXFhO2ATwnP+POgN/+brBIBiMQRS4uNzBpUbdBCiO0YUeyQ==
X-Received: by 2002:a17:90a:a905:b0:28b:35b9:d389 with SMTP id i5-20020a17090aa90500b0028b35b9d389mr2352450pjq.65.1702944534859;
        Mon, 18 Dec 2023 16:08:54 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:08:54 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v8 11/19] scsi: sd: Translate data lifetime information
Date: Mon, 18 Dec 2023 16:07:44 -0800
Message-ID: <20231219000815.2739120-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231219000815.2739120-1-bvanassche@acm.org>
References: <20231219000815.2739120-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/scsi/sd.c | 98 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/sd.h |  4 +-
 2 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 56c4310a741b..3037f35a1b79 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -47,6 +47,7 @@
 #include <linux/blkpg.h>
 #include <linux/blk-pm.h>
 #include <linux/delay.h>
+#include <linux/rw_hint.h>
 #include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/string_helpers.h>
@@ -1080,12 +1081,38 @@ static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
 	return BLK_STS_OK;
 }
 
+/**
+ * sd_group_number() - Compute the GROUP NUMBER field
+ * @cmd: SCSI command for which to compute the value of the six-bit GROUP NUMBER
+ *	field.
+ *
+ * From SBC-5 r05 (https://www.t10.org/cgi-bin/ac.pl?t=f&f=sbc5r05.pdf):
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
+
+	if (!sdkp->rscs)
+		return 0;
+
+	return min3((u32)rq->write_hint, (u32)sdkp->permanent_stream_count,
+		    0x3fu);
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
@@ -1104,7 +1131,7 @@ static blk_status_t sd_setup_rw16_cmnd(struct scsi_cmnd *cmd, bool write,
 	cmd->cmd_len  = 16;
 	cmd->cmnd[0]  = write ? WRITE_16 : READ_16;
 	cmd->cmnd[1]  = flags | ((dld >> 2) & 0x01);
-	cmd->cmnd[14] = (dld & 0x03) << 6;
+	cmd->cmnd[14] = ((dld & 0x03) << 6) | sd_group_number(cmd);
 	cmd->cmnd[15] = 0;
 	put_unaligned_be64(lba, &cmd->cmnd[2]);
 	put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
@@ -1119,7 +1146,7 @@ static blk_status_t sd_setup_rw10_cmnd(struct scsi_cmnd *cmd, bool write,
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = write ? WRITE_10 : READ_10;
 	cmd->cmnd[1] = flags;
-	cmd->cmnd[6] = 0;
+	cmd->cmnd[6] = sd_group_number(cmd);
 	cmd->cmnd[9] = 0;
 	put_unaligned_be32(lba, &cmd->cmnd[2]);
 	put_unaligned_be16(nr_blocks, &cmd->cmnd[7]);
@@ -1256,7 +1283,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
 	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
-		   sdp->use_10_for_rw || protect) {
+		   sdp->use_10_for_rw || protect || rq->write_hint) {
 		ret = sd_setup_rw10_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
 	} else {
@@ -2996,6 +3023,70 @@ sd_read_cache_type(struct scsi_disk *sdkp, unsigned char *buffer)
 	sdkp->DPOFUA = 0;
 }
 
+static bool sd_is_perm_stream(struct scsi_disk *sdkp, unsigned int stream_id)
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
+			      /*subpage=*/0x05, buffer, SD_BUF_SIZE, SD_TIMEOUT,
+			      sdkp->max_retries, &data, &sshdr);
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
@@ -3479,6 +3570,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 		sd_read_write_protect_flag(sdkp, buffer);
 		sd_read_cache_type(sdkp, buffer);
+		sd_read_io_hints(sdkp, buffer);
 		sd_read_app_tag_own(sdkp, buffer);
 		sd_read_write_same(sdkp, buffer);
 		sd_read_security(sdkp, buffer);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index e4539122f2a2..5c4285a582b2 100644
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
@@ -151,7 +153,7 @@ struct scsi_disk {
 	unsigned	urswrz : 1;
 	unsigned	security : 1;
 	unsigned	ignore_medium_access_errors : 1;
-	bool		rscs : 1; /* reduced stream control support */
+	unsigned	rscs : 1; /* reduced stream control support */
 };
 #define to_scsi_disk(obj) container_of(obj, struct scsi_disk, disk_dev)
 


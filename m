Return-Path: <linux-fsdevel+bounces-4312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF907FE712
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EDE1F20CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA37134B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA7F198;
	Wed, 29 Nov 2023 17:33:54 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6cdcef8b400so467387b3a.1;
        Wed, 29 Nov 2023 17:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308033; x=1701912833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VO2APHX5Y1ZuvGQDWFcsGuWp91fbUyR5eRl/Zk7oIZw=;
        b=mqCt2g57QA/94IuTFHpYanalw0acrLL9nld/0SkG8bkKZD4Sdvcq8d/n7CT6Z/PakG
         Zia5aU01Hw/YA3Ij+6wQhds6srecBxAIU+yG42SfOl0wQN+GvSgCxjrTxI5ggRl3blxP
         Vq9rUJnmMBmL6a2toeyGtAIJ88HTQIeIcUvLI/Fovk9O5B5X3FmtyifDCAW2XjOw0Fn7
         7L5iaYpPohSlUeV2pwNhVmrPUBbqa7+E25SqrgoEEUOPyZJ92g00r7IVLS51D66JcttB
         O7Kc+PRmdDd1xLmNK5iu/UWlvBSS7KqkQeG1/MLrbI2Nco+8IFZMTF+zUbMm6FDtvzhY
         oiKw==
X-Gm-Message-State: AOJu0YzX1SZ0BhD01ec1VMfG5+9GBQSQvcht2uY98RW0LzNJkmtpUFNz
	ZCibdmHyi7xqO+ZylT7uQWI=
X-Google-Smtp-Source: AGHT+IGCtwO9slEOkiMAkvbM+PGSw6qcjIDpIZyO8DaMqgEtygnTku0yl6OsOSk1QG9N6OdiowXPOw==
X-Received: by 2002:a05:6a20:7d8f:b0:18c:8ff1:f0b with SMTP id v15-20020a056a207d8f00b0018c8ff10f0bmr13599599pzj.56.1701308033506;
        Wed, 29 Nov 2023 17:33:53 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:53 -0800 (PST)
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
	Douglas Gilbert <dgilbert@interlog.com>
Subject: [PATCH v5 17/17] scsi_debug: Maintain write statistics per group number
Date: Wed, 29 Nov 2023 17:33:22 -0800
Message-ID: <20231130013322.175290-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130013322.175290-1-bvanassche@acm.org>
References: <20231130013322.175290-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track per GROUP NUMBER how many write commands have been processed. Make
this information available in sysfs. Reset these statistics if any data
is written into the sysfs attribute.

Note: SCSI devices should only interpret the information in the GROUP
NUMBER field as a stream identifier if the ST_ENBLE bit has been set to
one. This patch follows a simpler approach: count the number of writes
per GROUP NUMBER whether or not the group number represents a stream
identifier.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 49 +++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 16091e2913d5..e8cbfc118a24 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -898,6 +898,8 @@ static int sdeb_zbc_nr_conv = DEF_ZBC_NR_CONV_ZONES;
 static int submit_queues = DEF_SUBMIT_QUEUES;  /* > 1 for multi-queue (mq) */
 static int poll_queues; /* iouring iopoll interface.*/
 
+static atomic_long_t writes_by_group_number[64];
+
 static char sdebug_proc_name[] = MY_NAME;
 static const char *my_name = MY_NAME;
 
@@ -3346,7 +3348,8 @@ static inline struct sdeb_store_info *devip2sip(struct sdebug_dev_info *devip,
 
 /* Returns number of bytes copied or -1 if error. */
 static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
-			    u32 sg_skip, u64 lba, u32 num, bool do_write)
+			    u32 sg_skip, u64 lba, u32 num, bool do_write,
+			    u8 group_number)
 {
 	int ret;
 	u64 block, rest = 0;
@@ -3365,6 +3368,10 @@ static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
 		return 0;
 	if (scp->sc_data_direction != dir)
 		return -1;
+
+	if (do_write && group_number < ARRAY_SIZE(writes_by_group_number))
+		atomic_long_inc(&writes_by_group_number[group_number]);
+
 	fsp = sip->storep;
 
 	block = do_div(lba, sdebug_store_sectors);
@@ -3738,7 +3745,7 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		}
 	}
 
-	ret = do_device_access(sip, scp, 0, lba, num, false);
+	ret = do_device_access(sip, scp, 0, lba, num, false, 0);
 	sdeb_read_unlock(sip);
 	if (unlikely(ret == -1))
 		return DID_ERROR << 16;
@@ -3923,6 +3930,7 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 {
 	bool check_prot;
 	u32 num;
+	u8 group = 0;
 	u32 ei_lba;
 	int ret;
 	u64 lba;
@@ -3934,11 +3942,13 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		ei_lba = 0;
 		lba = get_unaligned_be64(cmd + 2);
 		num = get_unaligned_be32(cmd + 10);
+		group = cmd[14] & 0x3f;
 		check_prot = true;
 		break;
 	case WRITE_10:
 		ei_lba = 0;
 		lba = get_unaligned_be32(cmd + 2);
+		group = cmd[6] & 0x3f;
 		num = get_unaligned_be16(cmd + 7);
 		check_prot = true;
 		break;
@@ -3953,15 +3963,18 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		ei_lba = 0;
 		lba = get_unaligned_be32(cmd + 2);
 		num = get_unaligned_be32(cmd + 6);
+		group = cmd[6] & 0x3f;
 		check_prot = true;
 		break;
 	case 0x53:	/* XDWRITEREAD(10) */
 		ei_lba = 0;
 		lba = get_unaligned_be32(cmd + 2);
+		group = cmd[6] & 0x1f;
 		num = get_unaligned_be16(cmd + 7);
 		check_prot = false;
 		break;
 	default:	/* assume WRITE(32) */
+		group = cmd[6] & 0x3f;
 		lba = get_unaligned_be64(cmd + 12);
 		ei_lba = get_unaligned_be32(cmd + 20);
 		num = get_unaligned_be32(cmd + 28);
@@ -4016,7 +4029,7 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		}
 	}
 
-	ret = do_device_access(sip, scp, 0, lba, num, true);
+	ret = do_device_access(sip, scp, 0, lba, num, true, group);
 	if (unlikely(scsi_debug_lbp()))
 		map_region(sip, lba, num);
 	/* If ZBC zone then bump its write pointer */
@@ -4068,12 +4081,14 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 	u32 lb_size = sdebug_sector_size;
 	u32 ei_lba;
 	u64 lba;
+	u8 group;
 	int ret, res;
 	bool is_16;
 	static const u32 lrd_size = 32; /* + parameter list header size */
 
 	if (cmd[0] == VARIABLE_LENGTH_CMD) {
 		is_16 = false;
+		group = cmd[6] & 0x3f;
 		wrprotect = (cmd[10] >> 5) & 0x7;
 		lbdof = get_unaligned_be16(cmd + 12);
 		num_lrd = get_unaligned_be16(cmd + 16);
@@ -4084,6 +4099,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 		lbdof = get_unaligned_be16(cmd + 4);
 		num_lrd = get_unaligned_be16(cmd + 8);
 		bt_len = get_unaligned_be32(cmd + 10);
+		group = cmd[14] & 0x3f;
 		if (unlikely(have_dif_prot)) {
 			if (sdebug_dif == T10_PI_TYPE2_PROTECTION &&
 			    wrprotect) {
@@ -4172,7 +4188,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 			}
 		}
 
-		ret = do_device_access(sip, scp, sg_off, lba, num, true);
+		ret = do_device_access(sip, scp, sg_off, lba, num, true, group);
 		/* If ZBC zone then bump its write pointer */
 		if (sdebug_dev_is_zoned(devip))
 			zbc_inc_wp(devip, lba, num);
@@ -7259,6 +7275,30 @@ static ssize_t tur_ms_to_ready_show(struct device_driver *ddp, char *buf)
 }
 static DRIVER_ATTR_RO(tur_ms_to_ready);
 
+static ssize_t group_number_stats_show(struct device_driver *ddp, char *buf)
+{
+	char *p = buf, *end = buf + PAGE_SIZE;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(writes_by_group_number); i++)
+		p += scnprintf(p, end - p, "%d %ld\n", i,
+			       atomic_long_read(&writes_by_group_number[i]));
+
+	return p - buf;
+}
+
+static ssize_t group_number_stats_store(struct device_driver *ddp,
+					const char *buf, size_t count)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(writes_by_group_number); i++)
+		atomic_long_set(&writes_by_group_number[i], 0);
+
+	return count;
+}
+static DRIVER_ATTR_RW(group_number_stats);
+
 /* Note: The following array creates attribute files in the
    /sys/bus/pseudo/drivers/scsi_debug directory. The advantage of these
    files (over those found in the /sys/module/scsi_debug/parameters
@@ -7305,6 +7345,7 @@ static struct attribute *sdebug_drv_attrs[] = {
 	&driver_attr_cdb_len.attr,
 	&driver_attr_tur_ms_to_ready.attr,
 	&driver_attr_zbc.attr,
+	&driver_attr_group_number_stats.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(sdebug_drv);


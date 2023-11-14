Return-Path: <linux-fsdevel+bounces-2872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 725EB7EB8E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 22:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A121F25E44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BED2E831;
	Tue, 14 Nov 2023 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CB33061;
	Tue, 14 Nov 2023 21:42:29 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B52109;
	Tue, 14 Nov 2023 13:42:27 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1cc3bb4c307so48187445ad.0;
        Tue, 14 Nov 2023 13:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998147; x=1700602947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiiTqERusltuBxYIi/ClOpwEZbVLD7eJX5Gmub51sRg=;
        b=dCSSsrtJ6Lz/sBeVGCQy/piym9/WVbaG0LShUnqylasRacwGwZ/OSAuX1djme68hzF
         eB83dlDHqkz+kcVh+Uueqe5OVkcQryYE/3i7YGfg/FNO6mbN3yDDJ3ClLyGQIKzmqCP1
         LjtmSYzkkbj7070LCh5mW68xH8bI8+t5Zxr/XlTBKvjWcdzd/WiVtdPqZ6UJQ/kdDASx
         5cWHx3uwYwmYUG2kYhJMlEfVZAb6Yh0gIf6n8OhTU6Q2tpdyzDWQIGjrEQ2iZHu4Fqzn
         CKsbCJOS6bFI6L7RfhYQ76/LWQiFn8Vanb+zVN3hrbqc1F9gSAK3oHelX5JygzaDLSWD
         nqJw==
X-Gm-Message-State: AOJu0YxwokJXdIo4/Gi3ybEOmh0nXDaLz8DEiL4l+k8GQW7MXychXmfg
	tuZGraV5IBt10kcA5NcQa8jEfVo6KPU=
X-Google-Smtp-Source: AGHT+IGao25r2c6G5yJf0HAD5Co267EBzny25Wd6pDSGOK3iOtqoL1pplU4/X+7kPuI3WBXzCsXx/g==
X-Received: by 2002:a17:902:d548:b0:1cc:c857:14a0 with SMTP id z8-20020a170902d54800b001ccc85714a0mr3971053plf.3.1699998147318;
        Tue, 14 Nov 2023 13:42:27 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001c3267ae317sm6133926plg.165.2023.11.14.13.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:42:26 -0800 (PST)
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
	Douglas Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v4 15/15] scsi_debug: Maintain write statistics per group number
Date: Tue, 14 Nov 2023 13:41:10 -0800
Message-ID: <20231114214132.1486867-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231114214132.1486867-1-bvanassche@acm.org>
References: <20231114214132.1486867-1-bvanassche@acm.org>
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
 drivers/scsi/scsi_debug.c | 51 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index daf64844d6cb..47cc3da39076 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -898,6 +898,8 @@ static int sdeb_zbc_nr_conv = DEF_ZBC_NR_CONV_ZONES;
 static int submit_queues = DEF_SUBMIT_QUEUES;  /* > 1 for multi-queue (mq) */
 static int poll_queues; /* iouring iopoll interface.*/
 
+static atomic_long_t writes_by_group_number[64];
+
 static char sdebug_proc_name[] = MY_NAME;
 static const char *my_name = MY_NAME;
 
@@ -3351,7 +3353,8 @@ static inline struct sdeb_store_info *devip2sip(struct sdebug_dev_info *devip,
 
 /* Returns number of bytes copied or -1 if error. */
 static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
-			    u32 sg_skip, u64 lba, u32 num, bool do_write)
+			    u32 sg_skip, u64 lba, u32 num, bool do_write,
+			    u8 group_number)
 {
 	int ret;
 	u64 block, rest = 0;
@@ -3370,6 +3373,10 @@ static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
 		return 0;
 	if (scp->sc_data_direction != dir)
 		return -1;
+
+	if (do_write && group_number < ARRAY_SIZE(writes_by_group_number))
+		atomic_long_inc(&writes_by_group_number[group_number]);
+
 	fsp = sip->storep;
 
 	block = do_div(lba, sdebug_store_sectors);
@@ -3743,7 +3750,7 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		}
 	}
 
-	ret = do_device_access(sip, scp, 0, lba, num, false);
+	ret = do_device_access(sip, scp, 0, lba, num, false, 0);
 	sdeb_read_unlock(sip);
 	if (unlikely(ret == -1))
 		return DID_ERROR << 16;
@@ -3928,6 +3935,7 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 {
 	bool check_prot;
 	u32 num;
+	u8 group = 0;
 	u32 ei_lba;
 	int ret;
 	u64 lba;
@@ -3939,11 +3947,13 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
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
@@ -3958,15 +3968,18 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
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
@@ -4021,7 +4034,7 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		}
 	}
 
-	ret = do_device_access(sip, scp, 0, lba, num, true);
+	ret = do_device_access(sip, scp, 0, lba, num, true, group);
 	if (unlikely(scsi_debug_lbp()))
 		map_region(sip, lba, num);
 	/* If ZBC zone then bump its write pointer */
@@ -4073,12 +4086,14 @@ static int resp_write_scat(struct scsi_cmnd *scp,
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
@@ -4089,6 +4104,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 		lbdof = get_unaligned_be16(cmd + 4);
 		num_lrd = get_unaligned_be16(cmd + 8);
 		bt_len = get_unaligned_be32(cmd + 10);
+		group = cmd[14] & 0x3f;
 		if (unlikely(have_dif_prot)) {
 			if (sdebug_dif == T10_PI_TYPE2_PROTECTION &&
 			    wrprotect) {
@@ -4177,7 +4193,8 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 			}
 		}
 
-		ret = do_device_access(sip, scp, sg_off, lba, num, true);
+		ret = do_device_access(sip, scp, sg_off, lba, num, true,
+				       group);
 		/* If ZBC zone then bump its write pointer */
 		if (sdebug_dev_is_zoned(devip))
 			zbc_inc_wp(devip, lba, num);
@@ -7264,6 +7281,31 @@ static ssize_t tur_ms_to_ready_show(struct device_driver *ddp, char *buf)
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
+					const char *buf,
+				  size_t count)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(writes_by_group_number); i++)
+		atomic_long_set(&writes_by_group_number[i], 0);
+
+	return 0;
+}
+static DRIVER_ATTR_RW(group_number_stats);
+
 /* Note: The following array creates attribute files in the
    /sys/bus/pseudo/drivers/scsi_debug directory. The advantage of these
    files (over those found in the /sys/module/scsi_debug/parameters
@@ -7310,6 +7352,7 @@ static struct attribute *sdebug_drv_attrs[] = {
 	&driver_attr_cdb_len.attr,
 	&driver_attr_tur_ms_to_ready.attr,
 	&driver_attr_zbc.attr,
+	&driver_attr_group_number_stats.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(sdebug_drv);


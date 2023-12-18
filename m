Return-Path: <linux-fsdevel+bounces-6413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B123817A6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 20:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADB52857BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1564476091;
	Mon, 18 Dec 2023 18:58:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F974E31;
	Mon, 18 Dec 2023 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5906e03a7a4so2450899eaf.1;
        Mon, 18 Dec 2023 10:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925885; x=1703530685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLsLuA802ICDkiiKqvmIVU+HnLeNABPNuQNL8fYHwzQ=;
        b=eVO2KrA+6e8qLpgJIvOl7Xs7r4GApp0zDaX0ty6XgccqNd6xmmrs1xHnzuE0ZvRp8C
         3ajN4CSla2hOiBY35A2lo6QvlnkpFv8BiqxXvfruGaFm097A8RazOfFV5+FT1yozxf+v
         33FzMvhmdcARxbc57guAj/pqUtDFJjK7XjxyXzOHxhPXxZP/t7hFqjrQ2BhWf4WOdw6S
         +Aw0B0Zw8P02WlIpvAfSr3r33rgE4hT+A/oqEUEnsmpwJBO2EBZuL6OmyuDi8QKRKdUc
         EJE/UO8FKC1f0whcEJtF6iNJvn79Jx/1yqb3BOAbwFQT4d7vWZVbxnnwk3dT2p8S2634
         2Tuw==
X-Gm-Message-State: AOJu0YzrgZ09/Bvz9GTMk+G8hQ4GCsbKJnqYOpNmfsCpL1yeLdF5BSo+
	LX/DUJId9Z1qpXD9jVQE04Y=
X-Google-Smtp-Source: AGHT+IGexHgcSlOZeYDB9A4cJA4ydRG5BnN0lgFZj96roUauoWXjjq/6PSj7aCrdrSTG6svpJY5pRA==
X-Received: by 2002:a05:6358:7e48:b0:170:f17f:7070 with SMTP id p8-20020a0563587e4800b00170f17f7070mr8336123rwm.33.1702925885118;
        Mon, 18 Dec 2023 10:58:05 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id n20-20020a056a0007d400b006d45707d8edsm3918397pfu.7.2023.12.18.10.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:58:04 -0800 (PST)
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
Subject: [PATCH v7 19/19] scsi: scsi_debug: Maintain write statistics per group number
Date: Mon, 18 Dec 2023 10:56:42 -0800
Message-ID: <20231218185705.2002516-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218185705.2002516-1-bvanassche@acm.org>
References: <20231218185705.2002516-1-bvanassche@acm.org>
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
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 49 +++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b2146f24f396..8eeed19adcce 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -899,6 +899,8 @@ static int sdeb_zbc_nr_conv = DEF_ZBC_NR_CONV_ZONES;
 static int submit_queues = DEF_SUBMIT_QUEUES;  /* > 1 for multi-queue (mq) */
 static int poll_queues; /* iouring iopoll interface.*/
 
+static atomic_long_t writes_by_group_number[64];
+
 static char sdebug_proc_name[] = MY_NAME;
 static const char *my_name = MY_NAME;
 
@@ -3385,7 +3387,8 @@ static inline struct sdeb_store_info *devip2sip(struct sdebug_dev_info *devip,
 
 /* Returns number of bytes copied or -1 if error. */
 static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
-			    u32 sg_skip, u64 lba, u32 num, bool do_write)
+			    u32 sg_skip, u64 lba, u32 num, bool do_write,
+			    u8 group_number)
 {
 	int ret;
 	u64 block, rest = 0;
@@ -3404,6 +3407,10 @@ static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
 		return 0;
 	if (scp->sc_data_direction != dir)
 		return -1;
+
+	if (do_write && group_number < ARRAY_SIZE(writes_by_group_number))
+		atomic_long_inc(&writes_by_group_number[group_number]);
+
 	fsp = sip->storep;
 
 	block = do_div(lba, sdebug_store_sectors);
@@ -3777,7 +3784,7 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		}
 	}
 
-	ret = do_device_access(sip, scp, 0, lba, num, false);
+	ret = do_device_access(sip, scp, 0, lba, num, false, 0);
 	sdeb_read_unlock(sip);
 	if (unlikely(ret == -1))
 		return DID_ERROR << 16;
@@ -3962,6 +3969,7 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 {
 	bool check_prot;
 	u32 num;
+	u8 group = 0;
 	u32 ei_lba;
 	int ret;
 	u64 lba;
@@ -3973,11 +3981,13 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
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
@@ -3992,15 +4002,18 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
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
@@ -4055,7 +4068,7 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		}
 	}
 
-	ret = do_device_access(sip, scp, 0, lba, num, true);
+	ret = do_device_access(sip, scp, 0, lba, num, true, group);
 	if (unlikely(scsi_debug_lbp()))
 		map_region(sip, lba, num);
 	/* If ZBC zone then bump its write pointer */
@@ -4107,12 +4120,14 @@ static int resp_write_scat(struct scsi_cmnd *scp,
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
@@ -4123,6 +4138,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 		lbdof = get_unaligned_be16(cmd + 4);
 		num_lrd = get_unaligned_be16(cmd + 8);
 		bt_len = get_unaligned_be32(cmd + 10);
+		group = cmd[14] & 0x3f;
 		if (unlikely(have_dif_prot)) {
 			if (sdebug_dif == T10_PI_TYPE2_PROTECTION &&
 			    wrprotect) {
@@ -4211,7 +4227,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 			}
 		}
 
-		ret = do_device_access(sip, scp, sg_off, lba, num, true);
+		ret = do_device_access(sip, scp, sg_off, lba, num, true, group);
 		/* If ZBC zone then bump its write pointer */
 		if (sdebug_dev_is_zoned(devip))
 			zbc_inc_wp(devip, lba, num);
@@ -7306,6 +7322,30 @@ static ssize_t tur_ms_to_ready_show(struct device_driver *ddp, char *buf)
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
@@ -7352,6 +7392,7 @@ static struct attribute *sdebug_drv_attrs[] = {
 	&driver_attr_cdb_len.attr,
 	&driver_attr_tur_ms_to_ready.attr,
 	&driver_attr_zbc.attr,
+	&driver_attr_group_number_stats.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(sdebug_drv);


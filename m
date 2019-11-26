Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEEA110A4CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKZTyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 14:54:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:40302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbfKZTyt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:54:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8582EB087;
        Tue, 26 Nov 2019 19:54:42 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 rebase 05/10] cdrom: unify log messages.
Date:   Tue, 26 Nov 2019 20:54:24 +0100
Message-Id: <a76b4aa452008d06e515523d81ab922a234f074b.1574797504.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574797504.git.msuchanek@suse.de>
References: <cover.1574797504.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove obsolete compile time debug print settings, cd_dbg uses pr_debug
which can be dynamically enabled anyway.

Always print device name in cd_dbg.

Add cd_err and cd_info macros to always print device name in messages.

Remove redundant device name in message format string.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/cdrom/cdrom.c | 286 +++++++++++++++++++-----------------------
 1 file changed, 128 insertions(+), 158 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 38e6db879de0..93c9cea53f51 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -247,24 +247,6 @@
 #define REVISION "Revision: 3.20"
 #define VERSION "Id: cdrom.c 3.20 2003/12/17"
 
-/* I use an error-log mask to give fine grain control over the type of
-   messages dumped to the system logs.  The available masks include: */
-#define CD_NOTHING      0x0
-#define CD_WARNING	0x1
-#define CD_REG_UNREG	0x2
-#define CD_DO_IOCTL	0x4
-#define CD_OPEN		0x8
-#define CD_CLOSE	0x10
-#define CD_COUNT_TRACKS 0x20
-#define CD_CHANGER	0x40
-#define CD_DVD		0x80
-
-/* Define this to remove _all_ the debugging messages */
-/* #define ERRLOGMASK CD_NOTHING */
-#define ERRLOGMASK CD_WARNING
-/* #define ERRLOGMASK (CD_WARNING|CD_OPEN|CD_COUNT_TRACKS|CD_CLOSE) */
-/* #define ERRLOGMASK (CD_WARNING|CD_REG_UNREG|CD_DO_IOCTL|CD_OPEN|CD_CLOSE|CD_COUNT_TRACKS) */
-
 #include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/fs.h>
@@ -328,19 +310,14 @@ static const char *mrw_format_status[] = {
 
 static const char *mrw_address_space[] = { "DMA", "GAA" };
 
-#if (ERRLOGMASK != CD_NOTHING)
-#define cd_dbg(type, fmt, ...)				\
-do {							\
-	if ((ERRLOGMASK & type) || debug == 1)		\
-		pr_debug(fmt, ##__VA_ARGS__);		\
-} while (0)
-#else
-#define cd_dbg(type, fmt, ...)				\
-do {							\
-	if (0 && (ERRLOGMASK & type) || debug == 1)	\
-		pr_debug(fmt, ##__VA_ARGS__);		\
-} while (0)
-#endif
+#define cd_dbg(cdi, fmt, ...)						 \
+	pr_debug("%s: " fmt, (cdi) ? (cdi)->name : NULL, ##__VA_ARGS__)	 \
+
+#define cd_info(cdi, fmt, ...)						 \
+	pr_info("%s: " fmt, (cdi) ? (cdi)->name : NULL, ##__VA_ARGS__)	 \
+
+#define cd_err(cdi, fmt, ...)						 \
+	pr_err("%s: " fmt, (cdi) ? (cdi)->name : NULL, ##__VA_ARGS__)	 \
 
 /* The (cdo->capability & ~cdi->mask & CDC_XXX) construct was used in
    a lot of places. This macro makes the code more clear. */
@@ -494,7 +471,7 @@ static int cdrom_mrw_bgformat(struct cdrom_device_info *cdi, int cont)
 	unsigned char buffer[12];
 	int ret;
 
-	pr_info("%sstarting format\n", cont ? "Re" : "");
+	cd_info(cdi, "%sstarting format\n", cont ? "Re" : "");
 
 	/*
 	 * FmtData bit set (bit 4), format type is 1
@@ -524,7 +501,7 @@ static int cdrom_mrw_bgformat(struct cdrom_device_info *cdi, int cont)
 
 	ret = cdi->ops->generic_packet(cdi, &cgc);
 	if (ret)
-		pr_info("bgformat failed\n");
+		cd_info(cdi, "bgformat failed\n");
 
 	return ret;
 }
@@ -558,7 +535,7 @@ static int cdrom_mrw_exit(struct cdrom_device_info *cdi)
 
 	ret = 0;
 	if (di.mrw_status == CDM_MRW_BGFORMAT_ACTIVE) {
-		pr_info("issuing MRW background format suspend\n");
+		cd_info(cdi, "issuing MRW background format suspend\n");
 		ret = cdrom_mrw_bgformat_susp(cdi, 0);
 	}
 
@@ -595,8 +572,8 @@ static int cdrom_mrw_set_lba_space(struct cdrom_device_info *cdi, int space)
 	if (ret)
 		return ret;
 
-	pr_info("%s: mrw address space %s selected\n",
-		cdi->name, mrw_address_space[space]);
+	cd_info(cdi, "mrw address space %s selected\n",
+		mrw_address_space[space]);
 	return 0;
 }
 
@@ -605,7 +582,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
 	static char banner_printed;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 
-	cd_dbg(CD_OPEN, "entering register_cdrom\n");
+	cd_dbg(cdi, "entering register_cdrom\n");
 
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -EINVAL;
@@ -647,7 +624,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
 
 	WARN_ON(!cdo->generic_packet);
 
-	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
+	cd_dbg(cdi, "drive registered\n");
 	mutex_lock(&cdrom_mutex);
 	list_add(&cdi->list, &cdrom_list);
 	mutex_unlock(&cdrom_mutex);
@@ -657,7 +634,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
 
 void unregister_cdrom(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_OPEN, "entering unregister_cdrom\n");
+	cd_dbg(cdi, "entering unregister_cdrom\n");
 
 	mutex_lock(&cdrom_mutex);
 	list_del(&cdi->list);
@@ -666,7 +643,7 @@ void unregister_cdrom(struct cdrom_device_info *cdi)
 	if (cdi->exit)
 		cdi->exit(cdi);
 
-	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
+	cd_dbg(cdi, "drive unregistered\n");
 }
 
 int cdrom_get_media_event(struct cdrom_device_info *cdi,
@@ -796,7 +773,7 @@ static int cdrom_mrw_open_write(struct cdrom_device_info *cdi)
 	 * always reset to DMA lba space on open
 	 */
 	if (cdrom_mrw_set_lba_space(cdi, MRW_LBA_DMA)) {
-		pr_err("failed setting lba address space\n");
+		cd_err(cdi, "failed setting lba address space\n");
 		return 1;
 	}
 
@@ -815,7 +792,8 @@ static int cdrom_mrw_open_write(struct cdrom_device_info *cdi)
 	 * 3	-	MRW formatting complete
 	 */
 	ret = 0;
-	pr_info("open: mrw_status '%s'\n", mrw_format_status[di.mrw_status]);
+	cd_info(cdi, "open: mrw_status '%s'\n",
+		mrw_format_status[di.mrw_status]);
 	if (!di.mrw_status)
 		ret = 1;
 	else if (di.mrw_status == CDM_MRW_BGFORMAT_INACTIVE &&
@@ -867,7 +845,7 @@ static int cdrom_ram_open_write(struct cdrom_device_info *cdi)
 	else if (CDF_RWRT == be16_to_cpu(rfd.feature_code))
 		ret = !rfd.curr;
 
-	cd_dbg(CD_OPEN, "can open for random write\n");
+	cd_dbg(cdi, "can open for random write\n");
 	return ret;
 }
 
@@ -957,16 +935,16 @@ static void cdrom_dvd_rw_close_write(struct cdrom_device_info *cdi)
 	struct packet_command cgc;
 
 	if (cdi->mmc3_profile != 0x1a) {
-		cd_dbg(CD_CLOSE, "%s: No DVD+RW\n", cdi->name);
+		cd_dbg(cdi, "No DVD+RW\n");
 		return;
 	}
 
 	if (!cdi->media_written) {
-		cd_dbg(CD_CLOSE, "%s: DVD+RW media clean\n", cdi->name);
+		cd_dbg(cdi, "DVD+RW media clean\n");
 		return;
 	}
 
-	pr_info("%s: dirty DVD+RW media, \"finalizing\"\n", cdi->name);
+	cd_info(cdi, "dirty DVD+RW media, \"finalizing\"\n");
 
 	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
 	cgc.cmd[0] = GPCMD_FLUSH_CACHE;
@@ -1009,7 +987,7 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	tracks->cdi = 0;
 	tracks->xa = 0;
 	tracks->error = 0;
-	cd_dbg(CD_COUNT_TRACKS, "entering cdrom_count_tracks\n");
+	cd_dbg(cdi, "entering cdrom_count_tracks\n");
 	/* Grab the TOC header so we can see how many tracks there are */
 	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCHDR, &header);
 	if (ret) {
@@ -1037,10 +1015,10 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 		} else {
 			tracks->audio++;
 		}
-		cd_dbg(CD_COUNT_TRACKS, "track %d: format=%d, ctrl=%d\n",
+		cd_dbg(cdi, "track %d: format=%d, ctrl=%d\n",
 		       i, entry.cdte_format, entry.cdte_ctrl);
 	}
-	cd_dbg(CD_COUNT_TRACKS, "disc has %d tracks: %d=audio %d=data %d=Cd-I %d=XA\n",
+	cd_dbg(cdi, "disc has %d tracks: %d=audio %d=data %d=Cd-I %d=XA\n",
 	       header.cdth_trk1, tracks->audio, tracks->data,
 	       tracks->cdi, tracks->xa);
 }
@@ -1072,31 +1050,31 @@ int cdrom_autoclose(struct cdrom_device_info *cdi)
 	int ret;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 
-	cd_dbg(CD_OPEN, "entering cdrom_autoclose\n");
+	cd_dbg(cdi, "entering cdrom_autoclose\n");
 	if (!cdo->drive_status)
 		return -EOPNOTSUPP;
 
 	ret = cdo->drive_status(cdi, CDSL_CURRENT);
-	cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
+	cd_dbg(cdi, "drive_status=%d\n", ret);
 
 	if (ret == CDS_TRAY_OPEN) {
-		cd_dbg(CD_OPEN, "the tray is open...\n");
+		cd_dbg(cdi, "the tray is open...\n");
 		if (CDROM_CAN(CDC_CLOSE_TRAY)) {
 			if (!(cdi->options & CDO_AUTO_CLOSE))
 				return -ENOMEDIUM;
-			cd_dbg(CD_OPEN, "trying to close the tray\n");
+			cd_dbg(cdi, "trying to close the tray\n");
 			ret = cdrom_tray_close(cdi);
 			if (ret == -ERESTARTSYS)
 				return ret;
 			if (ret) {
-				cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
+				cd_dbg(cdi, "bummer. tried to close the tray but failed.\n");
 				return -ENOMEDIUM;
 			}
 			ret = cdo->drive_status(cdi, CDSL_CURRENT);
 			if (ret == CDS_NO_DISC)
-				cd_dbg(CD_OPEN, "tray might not contain a medium\n");
+				cd_dbg(cdi, "tray might not contain a medium\n");
 		} else {
-			cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
+			cd_dbg(cdi, "bummer. this drive can't close the tray.\n");
 			return -ENOMEDIUM;
 		}
 	}
@@ -1104,7 +1082,7 @@ int cdrom_autoclose(struct cdrom_device_info *cdi)
 	if (ret == CDS_DRIVE_NOT_READY) {
 		int poll_res;
 
-		cd_dbg(CD_OPEN, "waiting for drive to become ready...\n");
+		cd_dbg(cdi, "waiting for drive to become ready...\n");
 		poll_res = cdrom_wait_for_status_change(cdi, &ret);
 		if (poll_res == -ERESTARTSYS)
 			return poll_res;
@@ -1122,32 +1100,32 @@ static int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
 	int ret;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 
-	cd_dbg(CD_OPEN, "entering open_for_common\n");
+	cd_dbg(cdi, "entering open_for_common\n");
 	/* Check if the driver can report drive status.  If it can, we
 	   can do clever things.  If it can't, well, we at least tried! */
 	if (cdo->drive_status != NULL) {
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
-		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
+		cd_dbg(cdi, "drive_status=%d\n", ret);
 		if (ret == CDS_TRAY_OPEN) {
-			cd_dbg(CD_OPEN, "the tray is open...\n");
+			cd_dbg(cdi, "the tray is open...\n");
 			return -ENOMEDIUM;
 		}
 		if (ret == CDS_DRIVE_NOT_READY) {
-			cd_dbg(CD_OPEN, "the drive is not ready...\n");
+			cd_dbg(cdi, "the drive is not ready...\n");
 			return -ENOMEDIUM;
 		}
 		if (ret == CDS_NO_DISC) {
-			cd_dbg(CD_OPEN, "tray might not contain a medium...\n");
+			cd_dbg(cdi, "tray might not contain a medium...\n");
 			return -ENOMEDIUM;
 		}
 		if (ret != CDS_DISC_OK) {
-			cd_dbg(CD_OPEN, "drive returned status %i...\n", ret);
+			cd_dbg(cdi, "drive returned status %i...\n", ret);
 			return -ENOMEDIUM;
 		}
 	}
 	cdrom_count_tracks(cdi, tracks);
 	if (tracks->error == CDS_NO_DISC) {
-		cd_dbg(CD_OPEN, "bummer. no disc.\n");
+		cd_dbg(cdi, "bummer. no disc.\n");
 		return -ENOMEDIUM;
 	}
 
@@ -1160,7 +1138,7 @@ static int open_for_data(struct cdrom_device_info *cdi)
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	tracktype tracks;
 
-	cd_dbg(CD_OPEN, "entering open_for_data\n");
+	cd_dbg(cdi, "entering open_for_data\n");
 	ret = open_for_common(cdi, &tracks);
 	if (ret)
 		goto clean_up_and_return;
@@ -1171,34 +1149,33 @@ static int open_for_data(struct cdrom_device_info *cdi)
 		if (cdi->options & CDO_CHECK_TYPE) {
 		    /* give people a warning shot, now that CDO_CHECK_TYPE
 		       is the default case! */
-		    cd_dbg(CD_OPEN, "bummer. wrong media type.\n");
-		    cd_dbg(CD_WARNING, "pid %d must open device O_NONBLOCK!\n",
+		    cd_dbg(cdi, "bummer. wrong media type.\n");
+		    cd_dbg(cdi, "pid %d must open device O_NONBLOCK!\n",
 			   (unsigned int)task_pid_nr(current));
 		    ret=-EMEDIUMTYPE;
 		    goto clean_up_and_return;
-		}
-		else {
-		    cd_dbg(CD_OPEN, "wrong media type, but CDO_CHECK_TYPE not set\n");
+		} else {
+			cd_dbg(cdi, "wrong media type, but CDO_CHECK_TYPE not set\n");
 		}
 	}
 
-	cd_dbg(CD_OPEN, "all seems well, opening the devicen");
+	cd_dbg(cdi, "all seems well, opening the devicen");
 
 	/* all seems well, we can open the device */
 	ret = cdo->open(cdi, 0); /* open for data */
-	cd_dbg(CD_OPEN, "opening the device gave me %d\n", ret);
+	cd_dbg(cdi, "opening the device gave me %d\n", ret);
 	/* After all this careful checking, we shouldn't have problems
 	   opening the device, but we don't want the device locked if 
 	   this somehow fails... */
 	if (ret) {
-		cd_dbg(CD_OPEN, "open device failed\n");
+		cd_dbg(cdi, "open device failed\n");
 		goto clean_up_and_return;
 	}
 	if (CDROM_CAN(CDC_LOCK) && (cdi->options & CDO_LOCK)) {
 			cdo->lock_door(cdi, 1);
-			cd_dbg(CD_OPEN, "door locked\n");
+			cd_dbg(cdi, "door locked\n");
 	}
-	cd_dbg(CD_OPEN, "device opened successfully\n");
+	cd_dbg(cdi, "device opened successfully\n");
 	return ret;
 
 	/* Something failed.  Try to unlock the drive, because some drivers
@@ -1207,10 +1184,10 @@ static int open_for_data(struct cdrom_device_info *cdi)
 	This ensures that the drive gets unlocked after a mount fails.  This 
 	is a goto to avoid bloating the driver with redundant code. */ 
 clean_up_and_return:
-	cd_dbg(CD_OPEN, "open failed\n");
+	cd_dbg(cdi, "open failed\n");
 	if (CDROM_CAN(CDC_LOCK) && cdi->options & CDO_LOCK) {
 			cdo->lock_door(cdi, 0);
-			cd_dbg(CD_OPEN, "door unlocked\n");
+			cd_dbg(cdi, "door unlocked\n");
 	}
 	return ret;
 }
@@ -1228,7 +1205,7 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 {
 	int ret;
 
-	cd_dbg(CD_OPEN, "entering cdrom_open\n");
+	cd_dbg(cdi, "entering cdrom_open\n");
 
 	/* if this was a O_NONBLOCK open and we should honor the flags,
 	 * do a quick open without drive/disc integrity checks. */
@@ -1254,13 +1231,12 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 	if (ret)
 		goto err;
 
-	cd_dbg(CD_OPEN, "Use count for \"/dev/%s\" now %d\n",
-	       cdi->name, cdi->use_count);
+	cd_dbg(cdi, "Use count now %d\n", cdi->use_count);
 	return 0;
 err_release:
 	if (CDROM_CAN(CDC_LOCK) && cdi->options & CDO_LOCK) {
 		cdi->ops->lock_door(cdi, 0);
-		cd_dbg(CD_OPEN, "door unlocked\n");
+		cd_dbg(cdi, "door unlocked\n");
 	}
 	cdi->ops->release(cdi);
 err:
@@ -1275,7 +1251,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi)
 {
         int ret;
 	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
+	cd_dbg(cdi, "entering check_for_audio_disc\n");
 	if (!(cdi->options & CDO_CHECK_TYPE))
 		return 0;
 
@@ -1294,18 +1270,17 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	int opened_for_data;
 
-	cd_dbg(CD_CLOSE, "entering cdrom_release\n");
+	cd_dbg(cdi, "entering cdrom_release\n");
 
 	if (cdi->use_count > 0)
 		cdi->use_count--;
 
 	if (cdi->use_count == 0) {
-		cd_dbg(CD_CLOSE, "Use count for \"/dev/%s\" now zero\n",
-		       cdi->name);
+		cd_dbg(cdi, "Use count now zero\n");
 		cdrom_dvd_rw_close_write(cdi);
 
 		if ((cdo->capability & CDC_LOCK) && !cdi->keeplocked) {
-			cd_dbg(CD_CLOSE, "Unlocking door!\n");
+			cd_dbg(cdi, "Unlocking door!\n");
 			cdo->lock_door(cdi, 0);
 		}
 	}
@@ -1364,7 +1339,7 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
 	struct cdrom_changer_info *info;
 	int ret;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_slot_status()\n");
+	cd_dbg(cdi, "entering cdrom_slot_status()\n");
 	if (cdi->sanyo_slot)
 		return CDS_NO_INFO;
 	
@@ -1394,7 +1369,7 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 	int nslots = 1;
 	struct cdrom_changer_info *info;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_number_of_slots()\n");
+	cd_dbg(cdi, "entering cdrom_number_of_slots()\n");
 	/* cdrom_read_mech_status requires a valid value for capacity: */
 	cdi->capacity = 0; 
 
@@ -1415,7 +1390,7 @@ static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot)
 {
 	struct packet_command cgc;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_load_unload()\n");
+	cd_dbg(cdi, "entering cdrom_load_unload()\n");
 	if (cdi->sanyo_slot && slot < 0)
 		return 0;
 
@@ -1444,7 +1419,7 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 	int curslot;
 	int ret;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_select_disc()\n");
+	cd_dbg(cdi, "entering cdrom_select_disc()\n");
 	if (!CDROM_CAN(CDC_SELECT_DISC))
 		return -EDRIVE_CANT_DO_THIS;
 
@@ -1689,7 +1664,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 	switch (ai->type) {
 	/* LU data send */
 	case DVD_LU_SEND_AGID:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_AGID\n");
+		cd_dbg(cdi, "entering DVD_LU_SEND_AGID\n");
 		cgc.quiet = 1;
 		setup_report_key(&cgc, ai->lsa.agid, 0);
 
@@ -1701,7 +1676,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_LU_SEND_KEY1:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_KEY1\n");
+		cd_dbg(cdi, "entering DVD_LU_SEND_KEY1\n");
 		setup_report_key(&cgc, ai->lsk.agid, 2);
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
@@ -1712,7 +1687,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_LU_SEND_CHALLENGE:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_CHALLENGE\n");
+		cd_dbg(cdi, "entering DVD_LU_SEND_CHALLENGE\n");
 		setup_report_key(&cgc, ai->lsc.agid, 1);
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
@@ -1724,7 +1699,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* Post-auth key */
 	case DVD_LU_SEND_TITLE_KEY:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_TITLE_KEY\n");
+		cd_dbg(cdi, "entering DVD_LU_SEND_TITLE_KEY\n");
 		cgc.quiet = 1;
 		setup_report_key(&cgc, ai->lstk.agid, 4);
 		cgc.cmd[5] = ai->lstk.lba;
@@ -1743,7 +1718,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_LU_SEND_ASF:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_ASF\n");
+		cd_dbg(cdi, "entering DVD_LU_SEND_ASF\n");
 		setup_report_key(&cgc, ai->lsasf.agid, 5);
 		
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
@@ -1754,7 +1729,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* LU data receive (LU changes state) */
 	case DVD_HOST_SEND_CHALLENGE:
-		cd_dbg(CD_DVD, "entering DVD_HOST_SEND_CHALLENGE\n");
+		cd_dbg(cdi, "entering DVD_HOST_SEND_CHALLENGE\n");
 		setup_send_key(&cgc, ai->hsc.agid, 1);
 		buf[1] = 0xe;
 		copy_chal(&buf[4], ai->hsc.chal);
@@ -1766,7 +1741,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_HOST_SEND_KEY2:
-		cd_dbg(CD_DVD, "entering DVD_HOST_SEND_KEY2\n");
+		cd_dbg(cdi, "entering DVD_HOST_SEND_KEY2\n");
 		setup_send_key(&cgc, ai->hsk.agid, 3);
 		buf[1] = 0xa;
 		copy_key(&buf[4], ai->hsk.key);
@@ -1781,7 +1756,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 	/* Misc */
 	case DVD_INVALIDATE_AGID:
 		cgc.quiet = 1;
-		cd_dbg(CD_DVD, "entering DVD_INVALIDATE_AGID\n");
+		cd_dbg(cdi, "entering DVD_INVALIDATE_AGID\n");
 		setup_report_key(&cgc, ai->lsa.agid, 0x3f);
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
 			return ret;
@@ -1789,7 +1764,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* Get region settings */
 	case DVD_LU_SEND_RPC_STATE:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_RPC_STATE\n");
+		cd_dbg(cdi, "entering DVD_LU_SEND_RPC_STATE\n");
 		setup_report_key(&cgc, 0, 8);
 		memset(&rpc_state, 0, sizeof(rpc_state_t));
 		cgc.buffer = (char *) &rpc_state;
@@ -1806,7 +1781,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* Set region settings */
 	case DVD_HOST_SEND_RPC_STATE:
-		cd_dbg(CD_DVD, "entering DVD_HOST_SEND_RPC_STATE\n");
+		cd_dbg(cdi, "entering DVD_HOST_SEND_RPC_STATE\n");
 		setup_send_key(&cgc, 0, 6);
 		buf[1] = 6;
 		buf[4] = ai->hrpcs.pdrc;
@@ -1816,7 +1791,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	default:
-		cd_dbg(CD_WARNING, "Invalid DVD key ioctl (%d)\n", ai->type);
+		cd_dbg(cdi, "Invalid DVD key ioctl (%d)\n", ai->type);
 		return -ENOTTY;
 	}
 
@@ -1948,8 +1923,7 @@ static int dvd_read_bca(struct cdrom_device_info *cdi, dvd_struct *s,
 
 	s->bca.len = buf[0] << 8 | buf[1];
 	if (s->bca.len < 12 || s->bca.len > 188) {
-		cd_dbg(CD_WARNING, "Received invalid BCA length (%d)\n",
-		       s->bca.len);
+		cd_dbg(cdi, "Received invalid BCA length (%d)\n", s->bca.len);
 		ret = -EIO;
 		goto out;
 	}
@@ -1985,13 +1959,13 @@ static int dvd_read_manufact(struct cdrom_device_info *cdi, dvd_struct *s,
 
 	s->manufact.len = buf[0] << 8 | buf[1];
 	if (s->manufact.len < 0) {
-		cd_dbg(CD_WARNING, "Received invalid manufacture info length (%d)\n",
-		       s->manufact.len);
+		cd_dbg(cdi, "Received invalid manufacture info length (%d)\n",
+			s->manufact.len);
 		ret = -EIO;
 	} else {
 		if (s->manufact.len > 2048) {
-			cd_dbg(CD_WARNING, "Received invalid manufacture info length (%d): truncating to 2048\n",
-			       s->manufact.len);
+			cd_dbg(cdi, "Received invalid manufacture info length (%d): truncating to 2048\n",
+				s->manufact.len);
 			s->manufact.len = 2048;
 		}
 		memcpy(s->manufact.value, &buf[4], s->manufact.len);
@@ -2022,8 +1996,8 @@ static int dvd_read_struct(struct cdrom_device_info *cdi, dvd_struct *s,
 		return dvd_read_manufact(cdi, s, cgc);
 		
 	default:
-		cd_dbg(CD_WARNING, ": Invalid DVD structure read requested (%d)\n",
-		       s->type);
+		cd_dbg(cdi, "Invalid DVD structure read requested (%d)\n",
+			s->type);
 		return -EINVAL;
 	}
 }
@@ -2308,7 +2282,7 @@ static int cdrom_read_cdda(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 	 * frame dma, so drop to single frame dma if we need to
 	 */
 	if (cdi->cdda_method == CDDA_BPC_FULL && nframes > 1) {
-		pr_info("dropping to single frame dma\n");
+		cd_info(cdi, "dropping to single frame dma\n");
 		cdi->cdda_method = CDDA_BPC_SINGLE;
 		goto retry;
 	}
@@ -2321,7 +2295,8 @@ static int cdrom_read_cdda(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 	if (cdi->last_sense != 0x04 && cdi->last_sense != 0x0b)
 		return ret;
 
-	pr_info("dropping to old style cdda (sense=%x)\n", cdi->last_sense);
+	cd_info(cdi, "dropping to old style cdda (sense=%x)\n",
+		cdi->last_sense);
 	cdi->cdda_method = CDDA_OLD;
 	return cdrom_read_cdda_old(cdi, ubuf, lba, nframes);	
 }
@@ -2333,7 +2308,7 @@ static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,
 	u8 requested_format;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMMULTISESSION\n");
+	cd_dbg(cdi, "entering CDROMMULTISESSION\n");
 
 	if (!(cdi->ops->capability & CDC_MULTI_SESSION))
 		return -ENOSYS;
@@ -2355,13 +2330,13 @@ static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,
 	if (copy_to_user(argp, &ms_info, sizeof(ms_info)))
 		return -EFAULT;
 
-	cd_dbg(CD_DO_IOCTL, "CDROMMULTISESSION successful\n");
+	cd_dbg(cdi, "CDROMMULTISESSION successful\n");
 	return 0;
 }
 
 static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROMEJECT\n");
+	cd_dbg(cdi, "entering CDROMEJECT\n");
 
 	if (!CDROM_CAN(CDC_OPEN_TRAY))
 		return -ENOSYS;
@@ -2378,7 +2353,7 @@ static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)
 
 static int cdrom_ioctl_closetray(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROMCLOSETRAY\n");
+	cd_dbg(cdi, "entering CDROMCLOSETRAY\n");
 
 	if (!CDROM_CAN(CDC_CLOSE_TRAY))
 		return -ENOSYS;
@@ -2388,7 +2363,7 @@ static int cdrom_ioctl_closetray(struct cdrom_device_info *cdi)
 static int cdrom_ioctl_eject_sw(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROMEJECT_SW\n");
+	cd_dbg(cdi, "entering CDROMEJECT_SW\n");
 
 	if (!CDROM_CAN(CDC_OPEN_TRAY))
 		return -ENOSYS;
@@ -2407,7 +2382,7 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 	struct cdrom_changer_info *info;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_MEDIA_CHANGED\n");
+	cd_dbg(cdi, "entering CDROM_MEDIA_CHANGED\n");
 
 	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
 		return -ENOSYS;
@@ -2433,7 +2408,7 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_set_options(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_SET_OPTIONS\n");
+	cd_dbg(cdi, "entering CDROM_SET_OPTIONS\n");
 
 	/*
 	 * Options need to be in sync with capability.
@@ -2461,7 +2436,7 @@ static int cdrom_ioctl_set_options(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_clear_options(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_CLEAR_OPTIONS\n");
+	cd_dbg(cdi, "entering CDROM_CLEAR_OPTIONS\n");
 
 	cdi->options &= ~(int) arg;
 	return cdi->options;
@@ -2470,7 +2445,7 @@ static int cdrom_ioctl_clear_options(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_select_speed(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_SELECT_SPEED\n");
+	cd_dbg(cdi, "entering CDROM_SELECT_SPEED\n");
 
 	if (!CDROM_CAN(CDC_SELECT_SPEED))
 		return -ENOSYS;
@@ -2480,7 +2455,7 @@ static int cdrom_ioctl_select_speed(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_SELECT_DISC\n");
+	cd_dbg(cdi, "entering CDROM_SELECT_DISC\n");
 
 	if (!CDROM_CAN(CDC_SELECT_DISC))
 		return -ENOSYS;
@@ -2498,14 +2473,14 @@ static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
 	if (cdi->ops->select_disc)
 		return cdi->ops->select_disc(cdi, arg);
 
-	cd_dbg(CD_CHANGER, "Using generic cdrom_select_disc()\n");
+	cd_dbg(cdi, "Using generic cdrom_select_disc()\n");
 	return cdrom_select_disc(cdi, arg);
 }
 
 static int cdrom_ioctl_reset(struct cdrom_device_info *cdi,
 		struct block_device *bdev)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_RESET\n");
+	cd_dbg(cdi, "entering CDROM_RESET\n");
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -2518,7 +2493,7 @@ static int cdrom_ioctl_reset(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_lock_door(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "%socking door\n", arg ? "L" : "Unl");
+	cd_dbg(cdi, "%socking door\n", arg ? "L" : "Unl");
 
 	if (!CDROM_CAN(CDC_LOCK))
 		return -EDRIVE_CANT_DO_THIS;
@@ -2537,7 +2512,7 @@ static int cdrom_ioctl_lock_door(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_debug(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "%sabling debug\n", arg ? "En" : "Dis");
+	cd_dbg(cdi, "%sabling debug\n", arg ? "En" : "Dis");
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -2547,7 +2522,7 @@ static int cdrom_ioctl_debug(struct cdrom_device_info *cdi,
 
 static int cdrom_ioctl_get_capability(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_GET_CAPABILITY\n");
+	cd_dbg(cdi, "entering CDROM_GET_CAPABILITY\n");
 	return (cdi->ops->capability & ~cdi->mask);
 }
 
@@ -2563,7 +2538,7 @@ static int cdrom_ioctl_get_mcn(struct cdrom_device_info *cdi,
 	struct cdrom_mcn mcn;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_GET_MCN\n");
+	cd_dbg(cdi, "entering CDROM_GET_MCN\n");
 
 	if (!(cdi->ops->capability & CDC_MCN))
 		return -ENOSYS;
@@ -2573,14 +2548,14 @@ static int cdrom_ioctl_get_mcn(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &mcn, sizeof(mcn)))
 		return -EFAULT;
-	cd_dbg(CD_DO_IOCTL, "CDROM_GET_MCN successful\n");
+	cd_dbg(cdi, "CDROM_GET_MCN successful\n");
 	return 0;
 }
 
 static int cdrom_ioctl_drive_status(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_DRIVE_STATUS\n");
+	cd_dbg(cdi, "entering CDROM_DRIVE_STATUS\n");
 
 	if (!(cdi->ops->capability & CDC_DRIVE_STATUS))
 		return -ENOSYS;
@@ -2613,7 +2588,7 @@ static int cdrom_ioctl_disc_status(struct cdrom_device_info *cdi)
 {
 	tracktype tracks;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_DISC_STATUS\n");
+	cd_dbg(cdi, "entering CDROM_DISC_STATUS\n");
 
 	cdrom_count_tracks(cdi, &tracks);
 	if (tracks.error)
@@ -2635,13 +2610,13 @@ static int cdrom_ioctl_disc_status(struct cdrom_device_info *cdi)
 		return CDS_DATA_1;
 	/* Policy mode off */
 
-	cd_dbg(CD_WARNING, "This disc doesn't have any tracks I recognize!\n");
+	cd_dbg(cdi, "This disc doesn't have any tracks I recognize!\n");
 	return CDS_NO_INFO;
 }
 
 static int cdrom_ioctl_changer_nslots(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_CHANGER_NSLOTS\n");
+	cd_dbg(cdi, "entering CDROM_CHANGER_NSLOTS\n");
 	return cdi->capacity;
 }
 
@@ -2652,7 +2627,7 @@ static int cdrom_ioctl_get_subchnl(struct cdrom_device_info *cdi,
 	u8 requested, back;
 	int ret;
 
-	/* cd_dbg(CD_DO_IOCTL,"entering CDROMSUBCHNL\n");*/
+	cd_dbg(cdi, "entering CDROMSUBCHNL\n");
 
 	if (copy_from_user(&q, argp, sizeof(q)))
 		return -EFAULT;
@@ -2672,7 +2647,7 @@ static int cdrom_ioctl_get_subchnl(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &q, sizeof(q)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMSUBCHNL successful\n"); */
+	cd_dbg(cdi, "CDROMSUBCHNL successful\n");
 	return 0;
 }
 
@@ -2682,7 +2657,7 @@ static int cdrom_ioctl_read_tochdr(struct cdrom_device_info *cdi,
 	struct cdrom_tochdr header;
 	int ret;
 
-	/* cd_dbg(CD_DO_IOCTL, "entering CDROMREADTOCHDR\n"); */
+	cd_dbg(cdi, "entering CDROMREADTOCHDR\n");
 
 	if (copy_from_user(&header, argp, sizeof(header)))
 		return -EFAULT;
@@ -2693,7 +2668,7 @@ static int cdrom_ioctl_read_tochdr(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &header, sizeof(header)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMREADTOCHDR successful\n"); */
+	cd_dbg(cdi, "CDROMREADTOCHDR successful\n");
 	return 0;
 }
 
@@ -2704,7 +2679,7 @@ static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
 	u8 requested_format;
 	int ret;
 
-	/* cd_dbg(CD_DO_IOCTL, "entering CDROMREADTOCENTRY\n"); */
+	cd_dbg(cdi, "entering CDROMREADTOCENTRY\n");
 
 	if (copy_from_user(&entry, argp, sizeof(entry)))
 		return -EFAULT;
@@ -2721,7 +2696,7 @@ static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &entry, sizeof(entry)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMREADTOCENTRY successful\n"); */
+	cd_dbg(cdi, "CDROMREADTOCENTRY successful\n");
 	return 0;
 }
 
@@ -2730,7 +2705,7 @@ static int cdrom_ioctl_play_msf(struct cdrom_device_info *cdi,
 {
 	struct cdrom_msf msf;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
+	cd_dbg(cdi, "entering CDROMPLAYMSF\n");
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -2745,7 +2720,7 @@ static int cdrom_ioctl_play_trkind(struct cdrom_device_info *cdi,
 	struct cdrom_ti ti;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYTRKIND\n");
+	cd_dbg(cdi, "entering CDROMPLAYTRKIND\n");
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -2762,7 +2737,7 @@ static int cdrom_ioctl_volctrl(struct cdrom_device_info *cdi,
 {
 	struct cdrom_volctrl volume;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMVOLCTRL\n");
+	cd_dbg(cdi, "entering CDROMVOLCTRL\n");
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -2777,7 +2752,7 @@ static int cdrom_ioctl_volread(struct cdrom_device_info *cdi,
 	struct cdrom_volctrl volume;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMVOLREAD\n");
+	cd_dbg(cdi, "entering CDROMVOLREAD\n");
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -2796,7 +2771,7 @@ static int cdrom_ioctl_audioctl(struct cdrom_device_info *cdi,
 {
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "doing audio ioctl (start/stop/pause/resume)\n");
+	cd_dbg(cdi, "doing audio ioctl (start/stop/pause/resume)\n");
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -3089,7 +3064,7 @@ static noinline int mmc_ioctl_cdrom_subchannel(struct cdrom_device_info *cdi,
 	sanitize_format(&q.cdsc_reladdr, &q.cdsc_format, requested);
 	if (copy_to_user((struct cdrom_subchnl __user *)arg, &q, sizeof(q)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMSUBCHNL successful\n"); */
+	cd_dbg(cdi, "CDROMSUBCHNL successful\n");
 	return 0;
 }
 
@@ -3099,7 +3074,7 @@ static noinline int mmc_ioctl_cdrom_play_msf(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_msf msf;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
+	cd_dbg(cdi, "entering CDROMPLAYMSF\n");
 	if (copy_from_user(&msf, (struct cdrom_msf __user *)arg, sizeof(msf)))
 		return -EFAULT;
 	cgc->cmd[0] = GPCMD_PLAY_AUDIO_MSF;
@@ -3119,7 +3094,7 @@ static noinline int mmc_ioctl_cdrom_play_blk(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_blk blk;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYBLK\n");
+	cd_dbg(cdi, "entering CDROMPLAYBLK\n");
 	if (copy_from_user(&blk, (struct cdrom_blk __user *)arg, sizeof(blk)))
 		return -EFAULT;
 	cgc->cmd[0] = GPCMD_PLAY_AUDIO_10;
@@ -3144,7 +3119,7 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 	unsigned short offset;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMVOLUME\n");
+	cd_dbg(cdi, "entering CDROMVOLUME\n");
 
 	if (copy_from_user(&volctrl, (struct cdrom_volctrl __user *)arg,
 			   sizeof(volctrl)))
@@ -3213,7 +3188,7 @@ static noinline int mmc_ioctl_cdrom_start_stop(struct cdrom_device_info *cdi,
 					       int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMSTART/CDROMSTOP\n");
+	cd_dbg(cdi, "entering CDROMSTART/CDROMSTOP\n");
 	cgc->cmd[0] = GPCMD_START_STOP_UNIT;
 	cgc->cmd[1] = 1;
 	cgc->cmd[4] = (cmd == CDROMSTART) ? 1 : 0;
@@ -3226,7 +3201,7 @@ static noinline int mmc_ioctl_cdrom_pause_resume(struct cdrom_device_info *cdi,
 						 int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPAUSE/CDROMRESUME\n");
+	cd_dbg(cdi, "entering CDROMPAUSE/CDROMRESUME\n");
 	cgc->cmd[0] = GPCMD_PAUSE_RESUME;
 	cgc->cmd[8] = (cmd == CDROMRESUME) ? 1 : 0;
 	cgc->data_direction = CGC_DATA_NONE;
@@ -3248,7 +3223,7 @@ static noinline int mmc_ioctl_dvd_read_struct(struct cdrom_device_info *cdi,
 	if (IS_ERR(s))
 		return PTR_ERR(s);
 
-	cd_dbg(CD_DO_IOCTL, "entering DVD_READ_STRUCT\n");
+	cd_dbg(cdi, "entering DVD_READ_STRUCT\n");
 
 	ret = dvd_read_struct(cdi, s, cgc);
 	if (ret)
@@ -3268,7 +3243,7 @@ static noinline int mmc_ioctl_dvd_auth(struct cdrom_device_info *cdi,
 	dvd_authinfo ai;
 	if (!CDROM_CAN(CDC_DVD))
 		return -ENOSYS;
-	cd_dbg(CD_DO_IOCTL, "entering DVD_AUTH\n");
+	cd_dbg(cdi, "entering DVD_AUTH\n");
 	if (copy_from_user(&ai, (dvd_authinfo __user *)arg, sizeof(ai)))
 		return -EFAULT;
 	ret = dvd_do_auth(cdi, &ai);
@@ -3284,7 +3259,7 @@ static noinline int mmc_ioctl_cdrom_next_writable(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long next = 0;
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_NEXT_WRITABLE\n");
+	cd_dbg(cdi, "entering CDROM_NEXT_WRITABLE\n");
 	ret = cdrom_get_next_writable(cdi, &next);
 	if (ret)
 		return ret;
@@ -3298,7 +3273,7 @@ static noinline int mmc_ioctl_cdrom_last_written(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long last = 0;
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_LAST_WRITTEN\n");
+	cd_dbg(cdi, "entering CDROM_LAST_WRITTEN\n");
 	ret = cdrom_get_last_written(cdi, &last);
 	if (ret)
 		return ret;
@@ -3419,11 +3394,6 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 			return ret;
 	}
 
-	/*
-	 * Note: most of the cd_dbg() calls are commented out here,
-	 * because they fill up the sys log when CD players poll
-	 * the drive.
-	 */
 	switch (cmd) {
 	case CDROMSUBCHNL:
 		return cdrom_ioctl_get_subchnl(cdi, argp);
-- 
2.23.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839DDE1B67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391949AbfJWMxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 08:53:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390962AbfJWMxO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:53:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3F2AB67B;
        Wed, 23 Oct 2019 12:53:11 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/8] cdrom: separate autoclose into an IOCTL
Date:   Wed, 23 Oct 2019 14:52:43 +0200
Message-Id: <eb3804ca76748a8113fbb2322dc23cb06b9109bf.1571834862.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571834862.git.msuchanek@suse.de>
References: <cover.1571834862.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows the sr driver to call it separately without blocking other
processes accessing the device. This solves a issue with process waiting
in open() on broken drive to close the tray blocking out all access to
the device, including nonblocking access to determine drive status.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/cdrom/cdrom.c      | 83 +++++++++++++++++++++-----------------
 include/uapi/linux/cdrom.h |  1 +
 2 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index c0fc9a02b70c..bd8813b5afdb 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1071,46 +1071,16 @@ int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
 		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
 		if (ret == CDS_TRAY_OPEN) {
 			cd_dbg(CD_OPEN, "the tray is open...\n");
-			/* can/may i close it? */
-			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
-			    cdi->options & CDO_AUTO_CLOSE) {
-				cd_dbg(CD_OPEN, "trying to close the tray\n");
-				ret = cdrom_tray_close(cdi);
-				if (ret == -ERESTARTSYS)
-					return ret;
-				if (ret) {
-					cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
-					/* Ignore the error from the low
-					level driver.  We don't care why it
-					couldn't close the tray.  We only care 
-					that there is no disc in the drive, 
-					since that is the _REAL_ problem here.*/
-					return -ENOMEDIUM;
-				}
-			} else {
-				cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
-				return -ENOMEDIUM;
-			}
-			/* Ok, the door should be closed now.. Check again */
-			ret = cdo->drive_status(cdi, CDSL_CURRENT);
-			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
-				cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
-				cd_dbg(CD_OPEN, "tray might not contain a medium\n");
-				return -ENOMEDIUM;
-			}
-			cd_dbg(CD_OPEN, "the tray is now closed\n");
+			return -ENOMEDIUM;
 		}
-		/* the door should be closed now, check for the disc */
 		if (ret == CDS_DRIVE_NOT_READY) {
-			int poll_res = poll_event_interruptible(
-				CDS_DRIVE_NOT_READY !=
-				(ret = cdo->drive_status(cdi, CDSL_CURRENT)),
-				500);
-			if (poll_res == -ERESTARTSYS)
-				return poll_res;
+			cd_dbg(CD_OPEN, "the drive is not ready...\n");
+			return -ENOMEDIUM;
 		}
-		if (ret != CDS_DISC_OK)
+		if (ret != CDS_DISC_OK) {
+			cd_dbg(CD_OPEN, "drive returned status %i...\n", ret);
 			return -ENOMEDIUM;
+		}
 	}
 	cdrom_count_tracks(cdi, tracks);
 	if (tracks->error == CDS_NO_DISC) {
@@ -2353,6 +2323,45 @@ static int cdrom_ioctl_closetray(struct cdrom_device_info *cdi)
 	return cdi->ops->tray_move(cdi, 0);
 }
 
+static int cdrom_ioctl_autoclose(struct cdrom_device_info *cdi)
+{
+	const struct cdrom_device_ops *cdo = cdi->ops;
+	int ret;
+
+	if (!cdo->drive_status)
+		return -ENXIO;
+
+	ret = cdo->drive_status(cdi, CDSL_CURRENT);
+
+	if ((ret == CDS_TRAY_OPEN) && CDROM_CAN(CDC_CLOSE_TRAY) &&
+	    (cdi->options & CDO_AUTO_CLOSE)) {
+		cd_dbg(CD_DO_IOCTL, "trying to close the tray...\n");
+		ret = cdrom_tray_close(cdi);
+		if (ret == -ERESTARTSYS)
+			return ret;
+		if (ret) {
+			cd_dbg(CD_DO_IOCTL, "bummer. tried to close the tray but failed.\n");
+			return -ENOMEDIUM;
+			ret = cdo->drive_status(cdi, CDSL_CURRENT);
+		}
+		ret = cdo->drive_status(cdi, CDSL_CURRENT);
+	}
+
+	if (ret == CDS_DRIVE_NOT_READY) {
+		int poll_res;
+
+		cd_dbg(CD_DO_IOCTL, "waiting for drive to become ready...\n");
+		poll_res = poll_event_interruptible(CDS_DRIVE_NOT_READY !=
+			(ret = cdo->drive_status(cdi, CDSL_CURRENT)), 50);
+		if (poll_res == -ERESTARTSYS)
+			return poll_res;
+	}
+	if (ret != CDS_DISC_OK)
+		return -ENOMEDIUM;
+
+	return 0;
+}
+
 static int cdrom_ioctl_eject_sw(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
@@ -3365,6 +3374,8 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 		return cdrom_ioctl_debug(cdi, arg);
 	case CDROM_GET_CAPABILITY:
 		return cdrom_ioctl_get_capability(cdi);
+	case CDROM_AUTOCLOSE:
+		return cdrom_ioctl_autoclose(cdi);
 	case CDROM_GET_MCN:
 		return cdrom_ioctl_get_mcn(cdi, argp);
 	case CDROM_DRIVE_STATUS:
diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
index 2817230148fd..6493d8c593ee 100644
--- a/include/uapi/linux/cdrom.h
+++ b/include/uapi/linux/cdrom.h
@@ -129,6 +129,7 @@
 #define CDROM_LOCKDOOR		0x5329  /* lock or unlock door */
 #define CDROM_DEBUG		0x5330	/* Turn debug messages on/off */
 #define CDROM_GET_CAPABILITY	0x5331	/* get capabilities */
+#define CDROM_AUTOCLOSE		0x5332	/* If autoclose enabled close tray */
 
 /* Note that scsi/scsi_ioctl.h also uses 0x5382 - 0x5386.
  * Future CDROM ioctls should be kept below 0x537F
-- 
2.23.0


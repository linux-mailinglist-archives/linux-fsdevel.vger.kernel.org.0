Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE31DE1B6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 14:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391860AbfJWMxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 08:53:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391046AbfJWMxN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:53:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 161F5B670;
        Wed, 23 Oct 2019 12:53:10 +0000 (UTC)
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
Subject: [PATCH v2 2/8] cdrom: factor out common open_for_* code
Date:   Wed, 23 Oct 2019 14:52:41 +0200
Message-Id: <da032629db4a770a5f98ff400b91b44873cbdf46.1571834862.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571834862.git.msuchanek@suse.de>
References: <cover.1571834862.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The open_for_audio and open_for_data copies are bitrotten in different
ways already and will need to update the autoclose logic in both.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/cdrom/cdrom.c | 96 +++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 62 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 2ad6b73482fe..f504ca70f93f 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1046,12 +1046,12 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 }
 
 static
-int open_for_data(struct cdrom_device_info *cdi)
+int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
 {
 	int ret;
 	const struct cdrom_device_ops *cdo = cdi->ops;
-	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering open_for_data\n");
+
+	cd_dbg(CD_OPEN, "entering open_for_common\n");
 	/* Check if the driver can report drive status.  If it can, we
 	   can do clever things.  If it can't, well, we at least tried! */
 	if (cdo->drive_status != NULL) {
@@ -1071,37 +1071,45 @@ int open_for_data(struct cdrom_device_info *cdi)
 					couldn't close the tray.  We only care 
 					that there is no disc in the drive, 
 					since that is the _REAL_ problem here.*/
-					ret=-ENOMEDIUM;
-					goto clean_up_and_return;
+					return -ENOMEDIUM;
 				}
 			} else {
 				cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
-				ret=-ENOMEDIUM;
-				goto clean_up_and_return;
+				return -ENOMEDIUM;
 			}
 			/* Ok, the door should be closed now.. Check again */
 			ret = cdo->drive_status(cdi, CDSL_CURRENT);
 			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
 				cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
 				cd_dbg(CD_OPEN, "tray might not contain a medium\n");
-				ret=-ENOMEDIUM;
-				goto clean_up_and_return;
+				return -ENOMEDIUM;
 			}
 			cd_dbg(CD_OPEN, "the tray is now closed\n");
 		}
-		/* the door should be closed now, check for the disc */
-		ret = cdo->drive_status(cdi, CDSL_CURRENT);
-		if (ret!=CDS_DISC_OK) {
-			ret = -ENOMEDIUM;
-			goto clean_up_and_return;
-		}
+		if (ret != CDS_DISC_OK)
+			return -ENOMEDIUM;
 	}
-	cdrom_count_tracks(cdi, &tracks);
-	if (tracks.error == CDS_NO_DISC) {
+	cdrom_count_tracks(cdi, tracks);
+	if (tracks->error == CDS_NO_DISC) {
 		cd_dbg(CD_OPEN, "bummer. no disc.\n");
-		ret=-ENOMEDIUM;
-		goto clean_up_and_return;
+		return -ENOMEDIUM;
 	}
+
+	return 0;
+}
+
+static
+int open_for_data(struct cdrom_device_info *cdi)
+{
+	int ret;
+	const struct cdrom_device_ops *cdo = cdi->ops;
+	tracktype tracks;
+
+	cd_dbg(CD_OPEN, "entering open_for_data\n");
+	ret = open_for_common(cdi, &tracks);
+	if (ret)
+		goto clean_up_and_return;
+
 	/* CD-Players which don't use O_NONBLOCK, workman
 	 * for example, need bit CDO_CHECK_TYPE cleared! */
 	if (tracks.data==0) {
@@ -1208,53 +1216,17 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 /* This code is similar to that in open_for_data. The routine is called
    whenever an audio play operation is requested.
 */
-static int check_for_audio_disc(struct cdrom_device_info *cdi,
-				const struct cdrom_device_ops *cdo)
+static int check_for_audio_disc(struct cdrom_device_info *cdi)
 {
         int ret;
 	tracktype tracks;
 	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
 	if (!(cdi->options & CDO_CHECK_TYPE))
 		return 0;
-	if (cdo->drive_status != NULL) {
-		ret = cdo->drive_status(cdi, CDSL_CURRENT);
-		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
-		if (ret == CDS_TRAY_OPEN) {
-			cd_dbg(CD_OPEN, "the tray is open...\n");
-			/* can/may i close it? */
-			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
-			    cdi->options & CDO_AUTO_CLOSE) {
-				cd_dbg(CD_OPEN, "trying to close the tray\n");
-				ret=cdo->tray_move(cdi,0);
-				if (ret) {
-					cd_dbg(CD_OPEN, "bummer. tried to close tray but failed.\n");
-					/* Ignore the error from the low
-					level driver.  We don't care why it
-					couldn't close the tray.  We only care 
-					that there is no disc in the drive, 
-					since that is the _REAL_ problem here.*/
-					return -ENOMEDIUM;
-				}
-			} else {
-				cd_dbg(CD_OPEN, "bummer. this driver can't close the tray.\n");
-				return -ENOMEDIUM;
-			}
-			/* Ok, the door should be closed now.. Check again */
-			ret = cdo->drive_status(cdi, CDSL_CURRENT);
-			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
-				cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
-				return -ENOMEDIUM;
-			}	
-			if (ret!=CDS_DISC_OK) {
-				cd_dbg(CD_OPEN, "bummer. disc isn't ready.\n");
-				return -EIO;
-			}	
-			cd_dbg(CD_OPEN, "the tray is now closed\n");
-		}	
-	}
-	cdrom_count_tracks(cdi, &tracks);
-	if (tracks.error) 
-		return(tracks.error);
+
+	ret = open_for_common(cdi, &tracks);
+	if (ret)
+		return ret;
 
 	if (tracks.audio==0)
 		return -EMEDIUMTYPE;
@@ -2725,7 +2697,7 @@ static int cdrom_ioctl_play_trkind(struct cdrom_device_info *cdi,
 	if (copy_from_user(&ti, argp, sizeof(ti)))
 		return -EFAULT;
 
-	ret = check_for_audio_disc(cdi, cdi->ops);
+	ret = check_for_audio_disc(cdi);
 	if (ret)
 		return ret;
 	return cdi->ops->audio_ioctl(cdi, CDROMPLAYTRKIND, &ti);
@@ -2773,7 +2745,7 @@ static int cdrom_ioctl_audioctl(struct cdrom_device_info *cdi,
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
-	ret = check_for_audio_disc(cdi, cdi->ops);
+	ret = check_for_audio_disc(cdi);
 	if (ret)
 		return ret;
 	return cdi->ops->audio_ioctl(cdi, cmd, NULL);
-- 
2.23.0


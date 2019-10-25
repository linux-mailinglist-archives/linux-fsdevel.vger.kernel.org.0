Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F74E49C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 13:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410253AbfJYLVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 07:21:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:56914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2410162AbfJYLVx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:21:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4E01B294;
        Fri, 25 Oct 2019 11:21:51 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/7] cdrom: export autoclose logic as a separate function
Date:   Fri, 25 Oct 2019 13:21:41 +0200
Message-Id: <f978b2dfe998e0ace660b1b871db42b3f53708d5.1572002144.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572002144.git.msuchanek@suse.de>
References: <cover.1572002144.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows the sr driver to call it without blocking other processes
accessing the device. This solves a issue with process waiting in open()
on broken drive to close the tray blocking out all access to the device,
including nonblocking access to determine drive status.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: new patch
v3:
 - change IOCTL to export
 - fix the logic about reporting cdroms inability to close tray
---
 drivers/cdrom/cdrom.c | 87 +++++++++++++++++++++++++------------------
 include/linux/cdrom.h |  1 +
 2 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 27f4fce22781..a494f44fcf1f 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1070,46 +1070,16 @@ static int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
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
@@ -2351,6 +2321,51 @@ static int cdrom_ioctl_closetray(struct cdrom_device_info *cdi)
 	return cdi->ops->tray_move(cdi, 0);
 }
 
+int cdrom_autoclose(struct cdrom_device_info *cdi)
+{
+	const struct cdrom_device_ops *cdo = cdi->ops;
+	int ret;
+
+	cd_dbg(CD_OPEN, "entering cdrom_autoclose\n");
+	if (!cdo->drive_status)
+		return -ENXIO;
+
+	ret = cdo->drive_status(cdi, CDSL_CURRENT);
+	cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
+
+	if (ret == CDS_TRAY_OPEN)
+		if(CDROM_CAN(CDC_CLOSE_TRAY)) {
+			if (!(cdi->options & CDO_AUTO_CLOSE))
+				return -ENOMEDIUM;
+			cd_dbg(CD_OPEN, "trying to close the tray...\n");
+			ret = cdrom_tray_close(cdi);
+			if (ret == -ERESTARTSYS)
+				return ret;
+			if (ret) {
+				cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
+				return -ENOMEDIUM;
+			}
+			ret = cdo->drive_status(cdi, CDSL_CURRENT);
+		} else {
+			cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
+			return -ENOMEDIUM;
+		}
+	if (ret == CDS_DRIVE_NOT_READY) {
+		int poll_res;
+
+		cd_dbg(CD_OPEN, "waiting for drive to become ready...\n");
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
+EXPORT_SYMBOL_GPL(cdrom_autoclose);
+
 static int cdrom_ioctl_eject_sw(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 528271c60018..ea0415ba9f9d 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -126,6 +126,7 @@ extern void init_cdrom_command(struct packet_command *cgc,
 			       void *buffer, int len, int type);
 extern int cdrom_dummy_generic_packet(struct cdrom_device_info *cdi,
 				      struct packet_command *cgc);
+int cdrom_autoclose(struct cdrom_device_info *cdi);
 
 /* The SCSI spec says there could be 256 slots. */
 #define CDROM_MAX_SLOTS	256
-- 
2.23.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B166E1B55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 14:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391893AbfJWMxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 08:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391871AbfJWMxQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:53:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D14C3B676;
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
Subject: [PATCH v2 3/8] cdrom: wait for the tray to close
Date:   Wed, 23 Oct 2019 14:52:42 +0200
Message-Id: <1696675e9998df6eee537908903628abf666e3fd.1571834862.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571834862.git.msuchanek@suse.de>
References: <cover.1571834862.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The scsi command to close the tray only starts the motor and does not
wait for the tray to close. Wait until the state chages from TRAY_OPEN
so users do not race with the tray closing.

This looks like inifinte wait but unless the drive is broken it either
closes the tray shortly or reports an error when it detects the tray is
blocked. At worst the wait can be interrupted by the user.

Also wait for the drive to become ready once the tray closes.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2:
 - check drive_status exists before using it
 - rename tray_close -> cdrom_tray_close
 - also wait for drive to become ready after tray closes
 - do not wait in cdrom_ioctl_closetray
---
 drivers/cdrom/cdrom.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index f504ca70f93f..c0fc9a02b70c 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1045,6 +1045,18 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	       tracks->cdi, tracks->xa);
 }
 
+static int cdrom_tray_close(struct cdrom_device_info *cdi)
+{
+	int ret;
+
+	ret = cdi->ops->tray_move(cdi, 0);
+	if (ret || !cdi->ops->drive_status)
+		return ret;
+
+	return poll_event_interruptible(CDS_TRAY_OPEN !=
+			cdi->ops->drive_status(cdi, CDSL_CURRENT), 500);
+}
+
 static
 int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
 {
@@ -1063,7 +1075,9 @@ int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
 			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
 			    cdi->options & CDO_AUTO_CLOSE) {
 				cd_dbg(CD_OPEN, "trying to close the tray\n");
-				ret=cdo->tray_move(cdi,0);
+				ret = cdrom_tray_close(cdi);
+				if (ret == -ERESTARTSYS)
+					return ret;
 				if (ret) {
 					cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
 					/* Ignore the error from the low
@@ -1086,6 +1100,15 @@ int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
 			}
 			cd_dbg(CD_OPEN, "the tray is now closed\n");
 		}
+		/* the door should be closed now, check for the disc */
+		if (ret == CDS_DRIVE_NOT_READY) {
+			int poll_res = poll_event_interruptible(
+				CDS_DRIVE_NOT_READY !=
+				(ret = cdo->drive_status(cdi, CDSL_CURRENT)),
+				500);
+			if (poll_res == -ERESTARTSYS)
+				return poll_res;
+		}
 		if (ret != CDS_DISC_OK)
 			return -ENOMEDIUM;
 	}
-- 
2.23.0


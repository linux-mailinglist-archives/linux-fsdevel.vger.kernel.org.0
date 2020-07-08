Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D24D2187AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgGHMfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 08:35:08 -0400
Received: from casper.infradead.org ([90.155.50.34]:33804 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgGHMfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JOdrvVBNvN427RftYiUMCKmaeWd1nQ0Dut+NXex+TSk=; b=O+ZGOc9RoTX2V/qcTsSPAokNRh
        d2pWbJc2ihWp7bGGU05Nr+Xvu3yG+tye8lm/g56o9IMBubnqURZyfdE1L3Ea1FNJjIEPLVdLYW9Iu
        tg6EZ8uN8RhremEP2JAqLUtt/CIg2EvVpFwGGtSeFvrRwl/H9zKhYo240mC+5jfIf5zDqCwYqvRcw
        M568Lm71gNygDTnqrTXHndVlI9TR5tfs3pgifNl0Ozoc/IjItelwK9iTlHPwNkyO8Tskux2MsTng2
        d2dPoJQjzI/+P1DMdj140U6havH7n52zmK1onESgZre2EkP6t69hytcEzoL9Z/fdRKyQjjcAGB5Wq
        zxialUiA==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jt9FP-00021j-HP; Wed, 08 Jul 2020 12:32:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/6] cdrom: remove the unused cdrom_media_changed function
Date:   Wed,  8 Jul 2020 14:25:42 +0200
Message-Id: <20200708122546.214579-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708122546.214579-1-hch@lst.de>
References: <20200708122546.214579-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As well as the ->media_changed method.  All these are left over from
before the drivers were switched over to the check_events scheme.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/cdrom/cdrom-standard.rst | 18 +----------------
 drivers/cdrom/cdrom.c                  | 28 +++++---------------------
 include/linux/cdrom.h                  |  2 --
 3 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
index dde4f7f7fdbf1c..2de90581059033 100644
--- a/Documentation/cdrom/cdrom-standard.rst
+++ b/Documentation/cdrom/cdrom-standard.rst
@@ -157,7 +157,6 @@ with the kernel as a block device by registering the following general
 		cdrom_release,		/∗ release ∗/
 		NULL,			/∗ fsync ∗/
 		NULL,			/∗ fasync ∗/
-		cdrom_media_changed,	/∗ media change ∗/
 		NULL			/∗ revalidate ∗/
 	};
 
@@ -366,19 +365,6 @@ which may or may not be in the drive). If the drive is not a changer,
 	CDS_DRIVE_NOT_READY	/* something is wrong, tray is moving? */
 	CDS_DISC_OK		/* a disc is loaded and everything is fine */
 
-::
-
-	int media_changed(struct cdrom_device_info *cdi, int disc_nr)
-
-This function is very similar to the original function in $struct
-file_operations*. It returns 1 if the medium of the device *cdi->dev*
-has changed since the last call, and 0 otherwise. The parameter
-*disc_nr* identifies a specific slot in a juke-box, it should be
-ignored for single-disc drives. Note that by `re-routing` this
-function through *cdrom_media_changed()*, we can implement separate
-queues for the VFS and a new *ioctl()* function that can report device
-changes to software (e. g., an auto-mounting daemon).
-
 ::
 
 	int tray_move(struct cdrom_device_info *cdi, int position)
@@ -917,9 +903,7 @@ commands can be identified by the underscores in their names.
 	maximum number of discs in the juke-box found in the *cdrom_dops*.
 `CDROM_MEDIA_CHANGED`
 	Returns 1 if a disc has been changed since the last call.
-	Note that calls to *cdrom_media_changed* by the VFS are treated
-	by an independent queue, so both mechanisms will detect a
-	media change once. For juke-boxes, an extra argument *arg*
+	For juke-boxes, an extra argument *arg*
 	specifies the slot for which the information is given. The special
 	value *CDSL_CURRENT* requests that information about the currently
 	selected slot be returned.
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index d82b3b7658bddc..0c271b9e3c5b79 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -605,7 +605,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 	disk->cdi = cdi;
 
 	ENSURE(cdo, drive_status, CDC_DRIVE_STATUS);
-	if (cdo->check_events == NULL && cdo->media_changed == NULL)
+	if (cdo->check_events == NULL)
 		WARN_ON_ONCE(cdo->capability & (CDC_MEDIA_CHANGED | CDC_SELECT_DISC));
 	ENSURE(cdo, tray_move, CDC_CLOSE_TRAY | CDC_OPEN_TRAY);
 	ENSURE(cdo, lock_door, CDC_LOCK);
@@ -1419,8 +1419,6 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 
 	if (cdi->ops->check_events)
 		cdi->ops->check_events(cdi, 0, slot);
-	else
-		cdi->ops->media_changed(cdi, slot);
 
 	if (slot == CDSL_NONE) {
 		/* set media changed bits, on both queues */
@@ -1517,13 +1515,10 @@ int media_changed(struct cdrom_device_info *cdi, int queue)
 		return ret;
 
 	/* changed since last call? */
-	if (cdi->ops->check_events) {
-		BUG_ON(!queue);	/* shouldn't be called from VFS path */
-		cdrom_update_events(cdi, DISK_EVENT_MEDIA_CHANGE);
-		changed = cdi->ioctl_events & DISK_EVENT_MEDIA_CHANGE;
-		cdi->ioctl_events = 0;
-	} else
-		changed = cdi->ops->media_changed(cdi, CDSL_CURRENT);
+	BUG_ON(!queue);	/* shouldn't be called from VFS path */
+	cdrom_update_events(cdi, DISK_EVENT_MEDIA_CHANGE);
+	changed = cdi->ioctl_events & DISK_EVENT_MEDIA_CHANGE;
+	cdi->ioctl_events = 0;
 
 	if (changed) {
 		cdi->mc_flags = 0x3;    /* set bit on both queues */
@@ -1535,18 +1530,6 @@ int media_changed(struct cdrom_device_info *cdi, int queue)
 	return ret;
 }
 
-int cdrom_media_changed(struct cdrom_device_info *cdi)
-{
-	/* This talks to the VFS, which doesn't like errors - just 1 or 0.  
-	 * Returning "0" is always safe (media hasn't been changed). Do that 
-	 * if the low-level cdrom driver dosn't support media changed. */ 
-	if (cdi == NULL || cdi->ops->media_changed == NULL)
-		return 0;
-	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
-		return 0;
-	return media_changed(cdi, 0);
-}
-
 /* Requests to the low-level drivers will /always/ be done in the
    following format convention:
 
@@ -3464,7 +3447,6 @@ EXPORT_SYMBOL(unregister_cdrom);
 EXPORT_SYMBOL(cdrom_open);
 EXPORT_SYMBOL(cdrom_release);
 EXPORT_SYMBOL(cdrom_ioctl);
-EXPORT_SYMBOL(cdrom_media_changed);
 EXPORT_SYMBOL(cdrom_number_of_slots);
 EXPORT_SYMBOL(cdrom_mode_select);
 EXPORT_SYMBOL(cdrom_mode_sense);
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 8543fa59da7207..f48d0a31deaece 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -73,7 +73,6 @@ struct cdrom_device_ops {
 	int (*drive_status) (struct cdrom_device_info *, int);
 	unsigned int (*check_events) (struct cdrom_device_info *cdi,
 				      unsigned int clearing, int slot);
-	int (*media_changed) (struct cdrom_device_info *, int);
 	int (*tray_move) (struct cdrom_device_info *, int);
 	int (*lock_door) (struct cdrom_device_info *, int);
 	int (*select_speed) (struct cdrom_device_info *, int);
@@ -107,7 +106,6 @@ extern int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 		       fmode_t mode, unsigned int cmd, unsigned long arg);
 extern unsigned int cdrom_check_events(struct cdrom_device_info *cdi,
 				       unsigned int clearing);
-extern int cdrom_media_changed(struct cdrom_device_info *);
 
 extern int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi);
 extern void unregister_cdrom(struct cdrom_device_info *cdi);
-- 
2.26.2


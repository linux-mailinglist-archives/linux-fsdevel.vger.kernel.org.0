Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDD3261E3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 21:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgIHTsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 15:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730721AbgIHPuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:50:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35DC0A3BF5;
        Tue,  8 Sep 2020 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=s3JUZA1FtjTiqtgMGHDLmiQxYMnM63DlyIQ2tpQALUI=; b=dSTJ7ZeHKYCZdlMa4V/IwzP4dn
        X8z76QDKBLta4UmWt5M4OeL+2m+BbHwrKxd21IDIh12TMJGL6jZIzLBDf9Lytt1OhDh5OhxQuNkXF
        oNRoFmDWs/a/KluV43OxBc5b7bs5kDvYXMKkxDdPzj7VYfw2uTBTJ4TaBmrQBIINP+wPS3+AyGBi7
        GspQ5jXcIrwaaJWhmKYpuRPb6OL9IEG8VmIxNeevSsJ3yhc5Wh8Njaxm44ACbmNO07BNawIbARkya
        jOqti4qtagJZUvIj1d1tQ3Rcv9qjfQebc6eeP3Ptblxy8iJOI3kN6qYMqg+dy05jY+EiOCBmdQ1U6
        k1BmIj0A==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf19-0002z9-C5; Tue, 08 Sep 2020 14:54:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/19] ide-gd: stop using the disk events mechanism
Date:   Tue,  8 Sep 2020 16:53:42 +0200
Message-Id: <20200908145347.2992670-15-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908145347.2992670-1-hch@lst.de>
References: <20200908145347.2992670-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ide-gd is only using the disk events mechanism to be able to force an
invalidation and partition scan on opening removable media.  Just open
code the logic without invoving the block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-disk.c   |  5 +----
 drivers/ide/ide-floppy.c |  2 --
 drivers/ide/ide-gd.c     | 48 +++++-----------------------------------
 include/linux/ide.h      |  2 --
 4 files changed, 7 insertions(+), 50 deletions(-)

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 1d3407d7e095fa..34b9441084f84f 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -739,12 +739,9 @@ static void ide_disk_setup(ide_drive_t *drive)
 	set_wcache(drive, 1);
 
 	if ((drive->dev_flags & IDE_DFLAG_LBA) == 0 &&
-	    (drive->head == 0 || drive->head > 16)) {
+	    (drive->head == 0 || drive->head > 16))
 		printk(KERN_ERR "%s: invalid geometry: %d physical heads?\n",
 			drive->name, drive->head);
-		drive->dev_flags &= ~IDE_DFLAG_ATTACH;
-	} else
-		drive->dev_flags |= IDE_DFLAG_ATTACH;
 }
 
 static void ide_disk_flush(ide_drive_t *drive)
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index af7503b47dbe32..f5a2870aaf54bb 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -516,8 +516,6 @@ static void ide_floppy_setup(ide_drive_t *drive)
 	(void) ide_floppy_get_capacity(drive);
 
 	ide_proc_register_driver(drive, floppy->driver);
-
-	drive->dev_flags |= IDE_DFLAG_ATTACH;
 }
 
 static void ide_floppy_flush(ide_drive_t *drive)
diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index 05c26986637ba3..661e2aa9c96784 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -225,8 +225,12 @@ static int ide_gd_open(struct block_device *bdev, fmode_t mode)
 		 * and the door_lock is irrelevant at this point.
 		 */
 		drive->disk_ops->set_doorlock(drive, disk, 1);
-		drive->dev_flags |= IDE_DFLAG_MEDIA_CHANGED;
-		check_disk_change(bdev);
+		if (__invalidate_device(bdev, true))
+			pr_warn("VFS: busy inodes on changed media %s\n",
+				bdev->bd_disk->disk_name);
+		drive->disk_ops->get_capacity(drive);
+		set_capacity(disk, ide_gd_capacity(drive));
+		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
 	} else if (drive->dev_flags & IDE_DFLAG_FORMAT_IN_PROGRESS) {
 		ret = -EBUSY;
 		goto out_put_idkp;
@@ -284,32 +288,6 @@ static int ide_gd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
-static unsigned int ide_gd_check_events(struct gendisk *disk,
-					unsigned int clearing)
-{
-	struct ide_disk_obj *idkp = ide_drv_g(disk, ide_disk_obj);
-	ide_drive_t *drive = idkp->drive;
-	bool ret;
-
-	/* do not scan partitions twice if this is a removable device */
-	if (drive->dev_flags & IDE_DFLAG_ATTACH) {
-		drive->dev_flags &= ~IDE_DFLAG_ATTACH;
-		return 0;
-	}
-
-	/*
-	 * The following is used to force revalidation on the first open on
-	 * removeable devices, and never gets reported to userland as
-	 * DISK_EVENT_FLAG_UEVENT isn't set in genhd->event_flags.
-	 * This is intended as removable ide disk can't really detect
-	 * MEDIA_CHANGE events.
-	 */
-	ret = drive->dev_flags & IDE_DFLAG_MEDIA_CHANGED;
-	drive->dev_flags &= ~IDE_DFLAG_MEDIA_CHANGED;
-
-	return ret ? DISK_EVENT_MEDIA_CHANGE : 0;
-}
-
 static void ide_gd_unlock_native_capacity(struct gendisk *disk)
 {
 	struct ide_disk_obj *idkp = ide_drv_g(disk, ide_disk_obj);
@@ -320,18 +298,6 @@ static void ide_gd_unlock_native_capacity(struct gendisk *disk)
 		disk_ops->unlock_native_capacity(drive);
 }
 
-static int ide_gd_revalidate_disk(struct gendisk *disk)
-{
-	struct ide_disk_obj *idkp = ide_drv_g(disk, ide_disk_obj);
-	ide_drive_t *drive = idkp->drive;
-
-	if (ide_gd_check_events(disk, 0))
-		drive->disk_ops->get_capacity(drive);
-
-	set_capacity(disk, ide_gd_capacity(drive));
-	return 0;
-}
-
 static int ide_gd_ioctl(struct block_device *bdev, fmode_t mode,
 			     unsigned int cmd, unsigned long arg)
 {
@@ -364,9 +330,7 @@ static const struct block_device_operations ide_gd_ops = {
 	.compat_ioctl		= ide_gd_compat_ioctl,
 #endif
 	.getgeo			= ide_gd_getgeo,
-	.check_events		= ide_gd_check_events,
 	.unlock_native_capacity	= ide_gd_unlock_native_capacity,
-	.revalidate_disk	= ide_gd_revalidate_disk
 };
 
 static int ide_gd_probe(ide_drive_t *drive)
diff --git a/include/linux/ide.h b/include/linux/ide.h
index a254841bd3156d..62653769509f89 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -490,8 +490,6 @@ enum {
 	IDE_DFLAG_NOPROBE		= BIT(9),
 	/* need to do check_media_change() */
 	IDE_DFLAG_REMOVABLE		= BIT(10),
-	/* needed for removable devices */
-	IDE_DFLAG_ATTACH		= BIT(11),
 	IDE_DFLAG_FORCED_GEOM		= BIT(12),
 	/* disallow setting unmask bit */
 	IDE_DFLAG_NO_UNMASK		= BIT(13),
-- 
2.28.0


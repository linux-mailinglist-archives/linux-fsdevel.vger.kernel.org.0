Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96F41B5561
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgDWHPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgDWHPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44E4C08E859;
        Thu, 23 Apr 2020 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0AKKttm0agQJE8kqRO8A5rf8FwoXUaUQhwkZP6D5RVg=; b=rmzRgN9igrhiWV3VdQP8KK7SH7
        3ypK0KZoDPD45N4IKP/3zaPfjvk96UjDdsKHDWIm22dab5Qt93My7Nk4SuK39kyySyhYnxP9FBHnZ
        Eti5rdjgl3lhinoHw0vqLeYWB/wprL+E+JtAOQt6cfzsNcoC740M0w7CMf2vwdmC2n/BZzBYq3bzS
        WHXmNhF4ehcWjzba9lCkpPftEUtCKKPNKktBvag9I+A1TvJ3t7ITMvWoAP97BPb1dY/H5dF7t2lG5
        RIhoWkLLCl5UOHWxtdk/ytMcJWTrWqyf04ec4WRfVUMbgk5IKyK64OwgJcQphItYBkGCS/NuUNLug
        +MOqDGEA==;
Received: from [2001:4bb8:188:40ac:46e:e5e4:1e64:2584] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRW4G-0008SB-Ok; Thu, 23 Apr 2020 07:14:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] block: add a cdrom_device_info pointer to struct gendisk
Date:   Thu, 23 Apr 2020 09:12:18 +0200
Message-Id: <20200423071224.500849-2-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200423071224.500849-1-hch@lst.de>
References: <20200423071224.500849-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a pointer to the CDROM information structure to struct gendisk.
This will allow various removable media file systems to call directly
into the CDROM layer instead of abusing ioctls with kernel pointers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/paride/pcd.c | 2 +-
 drivers/cdrom/cdrom.c      | 5 ++++-
 drivers/cdrom/gdrom.c      | 2 +-
 drivers/ide/ide-cd.c       | 3 +--
 drivers/scsi/sr.c          | 3 +--
 include/linux/cdrom.h      | 2 +-
 include/linux/genhd.h      | 9 +++++++++
 7 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index cda5cf917e9a..5124eca90e83 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -1032,7 +1032,7 @@ static int __init pcd_init(void)
 
 	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
 		if (cd->present) {
-			register_cdrom(&cd->info);
+			register_cdrom(cd->disk, &cd->info);
 			cd->disk->private_data = cd;
 			add_disk(cd->disk);
 		}
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index faca0f346fff..a1d2112fd283 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -586,7 +586,7 @@ static int cdrom_mrw_set_lba_space(struct cdrom_device_info *cdi, int space)
 	return 0;
 }
 
-int register_cdrom(struct cdrom_device_info *cdi)
+int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 {
 	static char banner_printed;
 	const struct cdrom_device_ops *cdo = cdi->ops;
@@ -601,6 +601,9 @@ int register_cdrom(struct cdrom_device_info *cdi)
 		cdrom_sysctl_register();
 	}
 
+	cdi->disk = disk;
+	disk->cdi = cdi;
+
 	ENSURE(cdo, drive_status, CDC_DRIVE_STATUS);
 	if (cdo->check_events == NULL && cdo->media_changed == NULL)
 		WARN_ON_ONCE(cdo->capability & (CDC_MEDIA_CHANGED | CDC_SELECT_DISC));
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index c51292c2a131..09b0cd292720 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -770,7 +770,7 @@ static int probe_gdrom(struct platform_device *devptr)
 		goto probe_fail_no_disk;
 	}
 	probe_gdrom_setupdisk();
-	if (register_cdrom(gd.cd_info)) {
+	if (register_cdrom(gd.disk, gd.cd_info)) {
 		err = -ENODEV;
 		goto probe_fail_cdrom_register;
 	}
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index dcf8b51b47fd..40e124eb918a 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1305,8 +1305,7 @@ static int ide_cdrom_register(ide_drive_t *drive, int nslots)
 	if (drive->atapi_flags & IDE_AFLAG_NO_SPEED_SELECT)
 		devinfo->mask |= CDC_SELECT_SPEED;
 
-	devinfo->disk = info->disk;
-	return register_cdrom(devinfo);
+	return register_cdrom(info->disk, devinfo);
 }
 
 static int ide_cdrom_probe_capabilities(ide_drive_t *drive)
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index d2fe3fa470f9..f9b589d60a46 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -794,9 +794,8 @@ static int sr_probe(struct device *dev)
 	set_capacity(disk, cd->capacity);
 	disk->private_data = &cd->driver;
 	disk->queue = sdev->request_queue;
-	cd->cdi.disk = disk;
 
-	if (register_cdrom(&cd->cdi))
+	if (register_cdrom(disk, &cd->cdi))
 		goto fail_put;
 
 	/*
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 528271c60018..4f74ce050253 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -104,7 +104,7 @@ extern unsigned int cdrom_check_events(struct cdrom_device_info *cdi,
 				       unsigned int clearing);
 extern int cdrom_media_changed(struct cdrom_device_info *);
 
-extern int register_cdrom(struct cdrom_device_info *cdi);
+extern int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi);
 extern void unregister_cdrom(struct cdrom_device_info *cdi);
 
 typedef struct {
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 058d895544c7..f9c226f9546a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -217,11 +217,20 @@ struct gendisk {
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
 	struct kobject integrity_kobj;
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
+#if IS_ENABLED(CONFIG_CDROM)
+	struct cdrom_device_info *cdi;
+#endif
 	int node_id;
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
 };
 
+#if IS_REACHABLE(CONFIG_CDROM)
+#define disk_to_cdi(disk)	((disk)->cdi)
+#else
+#define disk_to_cdi(disk)	NULL
+#endif
+
 static inline struct gendisk *part_to_disk(struct hd_struct *part)
 {
 	if (likely(part)) {
-- 
2.26.1


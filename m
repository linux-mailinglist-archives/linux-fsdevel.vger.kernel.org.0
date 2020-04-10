Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF81A429B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 08:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDJGkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 02:40:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDJGkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JTteOHeO37w5w74f1hQ3Qe+Gf4H45aAyNwdEb6TBNX4=; b=XgkP9tAvT9lHhXNWcPRU6nwVu+
        2jQ5xL0Ei779iTklXGs2juvWCl71e5Pjjsy5VLDc/jnzOW45kUdAKSJ3Xh6b/6aNExKka4pbSkd9E
        UVnyailvX2RBg654O0h2Zvpl5dS8DUt37iBqGLTKJoDs4GPN2I8DeDduq1CgunMyYVtvqwOzpaZlM
        ycCVP323zmSswrpIMxl2vhbrrgRpgCn08ewujhp9PYpIMGexjBa5MCfMru/KehT3j7pF9M/i0bMWZ
        jKiFRAp5MnUS9DspK0O8s6oP0y+3yNMiHwcFHTwB7oTgooOrCTAZZPAZRsTv4tRsINxZS3Wth0VaQ
        +BMnWa+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMnLB-0003hn-C6; Fri, 10 Apr 2020 06:40:37 +0000
Date:   Thu, 9 Apr 2020 23:40:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 04/10] block: Modify revalidate zones
Message-ID: <20200410064037.GD4791@infradead.org>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-5-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409165352.2126-5-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 10, 2020 at 01:53:46AM +0900, Johannes Thumshirn wrote:
> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> Modify the interface of blk_revalidate_disk_zones() to add an optional
> revalidation callback function that a driver can use to extend checks and
> processing done during zone revalidation. The callback, if defined, is
> executed time after all zones are inspected and with the queue frozen.
> blk_revalidate_disk_zones() is renamed as __blk_revalidate_disk_zones()
> and blk_revalidate_disk_zones() implemented as an inline function calling
> __blk_revalidate_disk_zones() without no revalidation callback specified,
> resulting in an unchanged behavior for all callers of
> blk_revalidate_disk_zones().

The data argument to __blk_revalidate_disk_zones and the cllback is now
unused.  I also think we now merge __blk_revalidate_disk_zones and
blk_revalidate_disk_zones instead of having two versions for a grand
total of two callers.  Something like this on top of your whole branch:

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6c37fec6859b..0e7763a590e5 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -437,23 +437,21 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 }
 
 /**
- * __blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
+ * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
  * @disk:		Target disk
- * @revalidate_cb:	LLD callback
- * @revalidate_data:	LLD callback argument
+ * @update_driver_data:	Callback to update driver data on the frozen disk
  *
  * Helper function for low-level device drivers to (re) allocate and initialize
  * a disk request queue zone bitmaps. This functions should normally be called
  * within the disk ->revalidate method for blk-mq based drivers.  For BIO based
  * drivers only q->nr_zones needs to be updated so that the sysfs exposed value
  * is correct.
- * If the @revalidate_cb callback function is not NULL, the callback will be
- * executed with the device request queue frozen after all zones have been
+ * If the @update_driver_data callback function is not NULL, the callback will
+ * be executed with the device request queue frozen after all zones have been
  * checked.
  */
-int __blk_revalidate_disk_zones(struct gendisk *disk,
-				revalidate_zones_cb revalidate_cb,
-				void *revalidate_data)
+int blk_revalidate_disk_zones(struct gendisk *disk,
+		void (*update_driver_data)(struct gendisk *disk))
 {
 	struct request_queue *q = disk->queue;
 	struct blk_revalidate_zone_args args = {
@@ -487,8 +485,8 @@ int __blk_revalidate_disk_zones(struct gendisk *disk,
 		q->nr_zones = args.nr_zones;
 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
 		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
-		if (revalidate_cb)
-			revalidate_cb(disk, revalidate_data);
+		if (update_driver_data)
+			update_driver_data(disk);
 		ret = 0;
 	} else {
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
@@ -500,4 +498,4 @@ int __blk_revalidate_disk_zones(struct gendisk *disk,
 	kfree(args.conv_zones_bitmap);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__blk_revalidate_disk_zones);
+EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index b664be0bbb5e..f7beb72a321a 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -71,7 +71,7 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	if (queue_is_mq(q)) {
-		int ret = blk_revalidate_disk_zones(nullb->disk);
+		int ret = blk_revalidate_disk_zones(nullb->disk, NULL);
 
 		if (ret)
 			return ret;
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 53cfe998a3f6..893d2e0da255 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -656,7 +656,7 @@ static int sd_zbc_check_capacity(struct scsi_disk *sdkp, unsigned char *buf,
 	return 0;
 }
 
-static void sd_zbc_revalidate_zones_cb(struct gendisk *disk, void *data)
+static void sd_zbc_update_zone_data(struct gendisk *disk)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
 
@@ -680,8 +680,7 @@ static int sd_zbc_revalidate_zones(struct scsi_disk *sdkp,
 		goto unlock;
 	}
 
-	ret = __blk_revalidate_disk_zones(sdkp->disk,
-					sd_zbc_revalidate_zones_cb, NULL);
+	ret = blk_revalidate_disk_zones(sdkp->disk, sd_zbc_update_zone_data);
 	kvfree(sdkp->rev_wp_ofst);
 	sdkp->rev_wp_ofst = NULL;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a730cacda0f7..d970c36cb8d3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -353,8 +353,6 @@ struct queue_limits {
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 			       void *data);
 
-typedef void (*revalidate_zones_cb)(struct gendisk *disk, void *data);
-
 #ifdef CONFIG_BLK_DEV_ZONED
 
 #define BLK_ALL_ZONES  ((unsigned int)-1)
@@ -364,14 +362,8 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);
 extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 			    sector_t sectors, sector_t nr_sectors,
 			    gfp_t gfp_mask);
-int __blk_revalidate_disk_zones(struct gendisk *disk,
-				revalidate_zones_cb revalidate_cb,
-				void *revalidate_data);
-static inline int blk_revalidate_disk_zones(struct gendisk *disk)
-{
-	return __blk_revalidate_disk_zones(disk, NULL, NULL);
-}
-
+int blk_revalidate_disk_zones(struct gendisk *disk,
+		void (*update_driver_data)(struct gendisk *disk));
 extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 				     unsigned int cmd, unsigned long arg);
 extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,

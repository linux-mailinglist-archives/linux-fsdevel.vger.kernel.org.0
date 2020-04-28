Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48F1BBB7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 12:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgD1KqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 06:46:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15241 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgD1KqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588070783; x=1619606783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1g713dyf8i0yKWf8h2xRQEJPUn7hgVgy2RMp8/Rrho=;
  b=mOo8mHsgGr4tbq3zH+bVoecWbiULOqNaNFGdcrQhcEGeLOShAHkV8ki5
   MRigqL2RX3TbVmTSEiUD9PhB+X/9BfJuIzDYk853yG49lB/P77Soo8ClL
   Fw0uVMly4QFZ/Lx6ZXSdkAwc2g3QHpYG3GkzvUuSun1GlfvbhEtykDOub
   6rfJDT409g1Gtap58D3OIHucnNF+ndARlA21iWYJzkQ93aE5SBB/UqljZ
   Bk/WvcnZzkDXjqu0i96apqVBAcBsXFJ95827cjAWtguz14BR0/buT/X5O
   EkOLs936hEE512zWpwPgBvxNbDkq0mnuGecnIVd9kN+O00j8pD6FJkimF
   g==;
IronPort-SDR: hREHj9RCRPFTU1xlAIvefSw1lFFb9rOOozhoLieEd3D95tFlLDjefqkeKkS0yPa2p3g9sB5KBN
 csSeUpAS8E0MkWkHdSh7YQMfJzLoSlxQMlg6mEI8RzC5cdDYKDuakFF194mycPcfW8t/5QCGlv
 PoE2kAgUc7633bfxWdA9Zm5X8HRgt6gKUDao5K9dQdCIrxRnUaweXntooXmF1q6B3//lYW073V
 aGzHsP1gAR9QQufD2qTF4wKMIIOuZxWNP+yx9rWzviN/jsGgSLwbYQEV8pD5nWVW9O95kleEip
 ozc=
X-IronPort-AV: E=Sophos;i="5.73,327,1583164800"; 
   d="scan'208";a="238886581"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 18:46:23 +0800
IronPort-SDR: wh7DE7l2QWKAaq8P1EzZGG0gdP0WdZPkb/eKWws2v9ASpFCjCOdywqIbKiR76NtOSP6MBEyBob
 TBcJZcspcX9mtfiQEd2U8g2QG5sbrbvX0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 03:36:28 -0700
IronPort-SDR: iJCZ5sfhcJ6Z3WS6y1gskMQ7HGjiOKk1/2CFgZO5Ig67MF3+GVWOAUw1yKPYdjsc9VKySCR4FM
 exMj7uVhHvMA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 03:46:19 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v9 06/11] block: Modify revalidate zones
Date:   Tue, 28 Apr 2020 19:46:00 +0900
Message-Id: <20200428104605.8143-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

Modify the interface of blk_revalidate_disk_zones() to add an optional
driver callback function that a driver can use to extend processing
done during zone revalidation. The callback, if defined, is executed
with the device request queue frozen, after all zones have been
inspected.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-zoned.c              | 9 ++++++++-
 drivers/block/null_blk_zoned.c | 2 +-
 include/linux/blkdev.h         | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c822cfa7a102..23831fa8701d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -471,14 +471,19 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 /**
  * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
  * @disk:	Target disk
+ * @update_driver_data:	Callback to update driver data on the frozen disk
  *
  * Helper function for low-level device drivers to (re) allocate and initialize
  * a disk request queue zone bitmaps. This functions should normally be called
  * within the disk ->revalidate method for blk-mq based drivers.  For BIO based
  * drivers only q->nr_zones needs to be updated so that the sysfs exposed value
  * is correct.
+ * If the @update_driver_data callback function is not NULL, the callback is
+ * executed with the device request queue frozen after all zones have been
+ * checked.
  */
-int blk_revalidate_disk_zones(struct gendisk *disk)
+int blk_revalidate_disk_zones(struct gendisk *disk,
+			      void (*update_driver_data)(struct gendisk *disk))
 {
 	struct request_queue *q = disk->queue;
 	struct blk_revalidate_zone_args args = {
@@ -512,6 +517,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		q->nr_zones = args.nr_zones;
 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
 		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
+		if (update_driver_data)
+			update_driver_data(disk);
 		ret = 0;
 	} else {
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 9e4bcdad1a80..46641df2e58e 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -73,7 +73,7 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	if (queue_is_mq(q))
-		return blk_revalidate_disk_zones(nullb->disk);
+		return blk_revalidate_disk_zones(nullb->disk, NULL);
 
 	blk_queue_chunk_sectors(q, nullb->dev->zone_size_sects);
 	q->nr_zones = blkdev_nr_zones(nullb->disk);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6e6ce3dc656..fd405dac8eb0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -357,7 +357,8 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);
 extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 			    sector_t sectors, sector_t nr_sectors,
 			    gfp_t gfp_mask);
-extern int blk_revalidate_disk_zones(struct gendisk *disk);
+int blk_revalidate_disk_zones(struct gendisk *disk,
+			      void (*update_driver_data)(struct gendisk *disk));
 
 extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 				     unsigned int cmd, unsigned long arg);
-- 
2.24.1


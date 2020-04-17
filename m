Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8EC1ADD21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgDQMQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 08:16:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50643 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgDQMP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587125759; x=1618661759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wi1qv7z0Mg6tQsAx0kXU9eGu+szpv/+bHam7HZYDstw=;
  b=FcY4zKbsuFmVRfZUfDLIPCPFVesIfbC0ihMrF8djVE2E3U+aWEzH1ptG
   ySNISdDnba1/dlj60K2iGvRbH4KGufDTc1riIEN3cKBH9nT5693jeEa0E
   Ut73cSXnkQPlmzwVQg6Cb8Sepr0T9+qdC3fd1cQYSHWF5DGLqcU08T9Y0
   c6mST9hgXzNy6/zRKiPc3NJSvdyKGgwydokbHxkjEFyVObodTUCl6UJVG
   n9r8DWwHS/3rJaI01L4Fy72kdnsK4KmEU15fHKVUK9N0SNiaMVEkQLdZt
   ZvgaZV0cv2d3QzkNrfQpSybk5hYqbRKCRX1KlsCLnnGlnmPPrS0mNUjgy
   A==;
IronPort-SDR: OEYkZ3Mixop9Kl/UfunnbmjW0T5N6IsFoKBpE1y8bBLeSYjpepqSfzWsodU8loTlQqs51SlL1v
 RepzYLEUKj9jLxrinGvMM3o+vlRc511hxAnlccojPZey/1nfmKs0JaxQZ0Rq2Y9zfh2dtCq0PA
 v10uBBeZU6x91h3iNHg0IAYjS7pR/wrEnD7JfAJS011FTHx9L249aK8rW/efJ/jJXRkbfCGF2d
 dMW3zJsilXoZWI3QyfaR2vz2G61b50pe+tuhRP1WydoCWZW3WgK0OuEKJntdU01uCUDWyTrM7x
 9XE=
X-IronPort-AV: E=Sophos;i="5.72,394,1580745600"; 
   d="scan'208";a="237989215"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 20:15:59 +0800
IronPort-SDR: 5ocKAeeR/mSqEjHT5L6HdGrdEBubaDX77siPr6WRqeOgiCow9t2ik0v5oWAG+ZIVydGNwHajay
 4BRLIWAOLECswwasn2pxO0nGpKnNbOalA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:06:55 -0700
IronPort-SDR: 9iiCa8u2QcickQQvQ4MFcxhGYorKDNNEVOgdFs2maaFi1LJFWgpo/baiZo16U9jPE/WyAJHnx0
 eAZhJuKGJg8A==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2020 05:15:56 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 06/11] block: Modify revalidate zones
Date:   Fri, 17 Apr 2020 21:15:31 +0900
Message-Id: <20200417121536.5393-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
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
index 0797d1e81802..132de24180ad 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -362,7 +362,8 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);
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


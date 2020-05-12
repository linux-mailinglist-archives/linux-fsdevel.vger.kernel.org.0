Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A951CEFB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgELI4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:56:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16024 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgELI4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589273773; x=1620809773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmrsIuvT4emv5cGWG0aWsrxpc1/G5U077NvrBZdYN1I=;
  b=G9IgS8uLpAZj5wV7kw46chHmDWt18QX7CnU2kHcRL++itbpgai1NiNCv
   uaTEWY1++6pp1+CileGxZnIFvougdakLH3TUToSOGGfVP5Q6YF58L7r8M
   vIZNalJpgwXKsT2YGd+w7b+huFIaP5XzZFxJdT+UqGljb6cZA902+RgFW
   B6G0j0OKKnYcP0PTqKAvgDxM6GbPYyX07iD6/YsJgzTGAAYGzwjtG4hMp
   cOS4T+AsM3fSI48TE9hCF5NcSSNolBPx411NlXmTvx1mMr7rKGrbM+pG1
   +gwd+DCASxepyl2sfaF25MlCOgx2RxfuD+lyXLBww5UdhXcxz3iRfpUI9
   A==;
IronPort-SDR: GXdosVKINLXF5lUTOy9bsZH6uuZQEvAMFXgk38xcQqlJHxhi3LA8HCzHa48g/75Hr/j5DqW9n9
 NVf02BBa3o/kB7JalwfKEUA4O9BRT2MYmRjbHsMTDgYw7S6ERyXbmE79365wyo4CKBkb0b7MbC
 SQwHyhzlIIXDg1cifMIFbOhujFLwkOQcuKhTiGDIzCzyh+eLk7IGSKL+6FlgeIcZHTDO4oZdU6
 diCQuq3+0berFX9xTKYlTgpvziIYZuJVAXOb80qnwPBBdoYi1JHMFvj6mUc2jMneZYD6AHhURs
 eZA=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="141823557"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:56:13 +0800
IronPort-SDR: yWAz9dZIb7jAP4mgsHRrqJmU3B5rXC+CGWiUY0UgvtK8BSq1IBYQjpzHQZR9LSN9++hE5eKRmX
 3LQggDJiUjqHnZp4hMHq8QWRae+f5NoY0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 01:45:55 -0700
IronPort-SDR: Z/Rdoo79UGAQoTBGKb4rIZZpQsoi1no8O4YTRoZCBnGr0ac/e+xi7LMs9tpzhWi0akhqxdsH+3
 m1h5sER3mR0g==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 May 2020 01:56:10 -0700
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
Subject: [PATCH v11 05/10] block: Modify revalidate zones
Date:   Tue, 12 May 2020 17:55:49 +0900
Message-Id: <20200512085554.26366-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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


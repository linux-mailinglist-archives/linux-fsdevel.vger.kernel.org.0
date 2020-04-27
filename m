Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4095D1BA265
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgD0LcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:32:17 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54642 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgD0LcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587987134; x=1619523134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5tosLrw0MSpJm+5/ONeuyk4LD8nSSgd9GaJF4+kln5U=;
  b=XU7qgqO35c7uRjpPCXlN4YOlPSoU71URBb+1SayeHfILyUqrm93nfDd9
   zZss+ebDBLpxWmNl9aT25VBQv4djfJlVTQv/aYt/V1ge7w/QttQl2k9sQ
   mrK0+72dCVfoCrl2QxPvT7GO1WJfpG47E8o9W8EJ9k38EDwtHZor3UqDt
   JlOWYniKstUCDetOfpLlh7Zhp/eKr1gk3gbvsRta/R4/juNFU1IYEKIhA
   2BCtNbpGfxj3/k2vxB3prECICSegDi4g3Hk08U/kXVsCRwvpo5pqLWKUE
   dzIX+dkyT96kTGF9rVFhp9Io2D5tR3aB7kSZC4wGM5pohsmwFa5EqXmHv
   A==;
IronPort-SDR: d2l6eBCtKHsyiUchkcVqGZmDojeZ1rg4++jJyDoIyxlsqihXOu7jNYQWQSsyGK2NwOhFmEXQSd
 xpIqGyiemwRn+7hUyTiGLi4mEvxlMLj3ZEAhMFxnioMw3W2WbHijTW/hO1brNv9/TG6Ghfjefk
 eEhzSLgD9MW4CuqMZHA8K2HoHm1211BQf/bOA3ck7gK1hYGa1tUZeG+3y2JEIw7bGPYSgewStg
 LPFghxhuARbhkgTNcrw/Pd0zMybTXVp0dFkWVrbABjq+RW6wQ+IGbqNbV+DdC/Grb/cMsxrqCV
 0w0=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="136552007"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 19:32:14 +0800
IronPort-SDR: H4eKKO7RnRFu4e3RMgn+TeuHzzkg0waHlo5+SxOa8k6+Au3e1ld8bSu//D6yzj6d4+R+sPj2et
 0bGybU2qqYhhuFy9caezHljo8MDmUS9XI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 04:22:55 -0700
IronPort-SDR: XgYAPRhZLDOe9EC/uTztE1YalZ1oCZtDyYO0o1xoWdArsNxbq4LXH+BHOEl1u4ahsl376escvU
 cvcRcY8vIXRg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 04:32:12 -0700
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 06/11] block: Modify revalidate zones
Date:   Mon, 27 Apr 2020 20:31:48 +0900
Message-Id: <20200427113153.31246-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
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


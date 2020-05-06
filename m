Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC31C7600
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 18:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgEFQME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 12:12:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61300 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbgEFQL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 12:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588781519; x=1620317519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmrsIuvT4emv5cGWG0aWsrxpc1/G5U077NvrBZdYN1I=;
  b=c6vpEXzwQ7fTPgUhDebQQ5eWd0nEkANaMYb00PBm76UmioVJqwXF0m6G
   Fqbse6khoHiBwtEVs13P03kKAxAkGG2OaZ5rjX30qSS1qckBpAFKxGiS2
   8S/HNM7KZHCIS8mx0K+rC6nBgcvs04A9Kle8Fjn0hR9tN8NfecC7Y/gY9
   uc+rPpHxmhr9ooCZAuR7Vklu77Vm2N+TWMYYW7wpKgL6wgDyeTxLx8gmq
   Z7Lw28ff91bPqN8UtA6bi+hTx0mRyBKbAWUZTLTIKjpaW8IUWEYRc69zp
   Z8jEbj9a4w2BNiLZgqsTTj61cKs9r7ahQb3C2Uns+2m9d8plYM3d2lbKb
   w==;
IronPort-SDR: m48QWCelDg+tSwE/6li91q249sZPjj0upRLnhE3vsyv66dTE22eGnHXsAwLRZNs5FnJgDqGUDL
 4LPEszD74/NQOFi8iFLjjzhwdPSZBsFJOitkq2V+7dWmtKekE9BF0VV6RHqPbiJfReSlSgieVv
 n4oSDxNLlUhNR5WiAda+YMAhMTkeRHbi/tK6hgjmgzpkhvaQ2/Eynk/vxe+mDbPWP0NT8LR8lc
 112uhuk6t5rIdkGHVaZuBSjOhQUQVg5Ciifx/xDVPestF/YxxwVSyo9xE06HGTuzrMAov/SBED
 D0Q=
X-IronPort-AV: E=Sophos;i="5.73,359,1583164800"; 
   d="scan'208";a="245917897"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 00:11:59 +0800
IronPort-SDR: VxyV49J1D0wPQwyTCz55iDlMASIkqxgnfR4WZr66yW/Di2Qdfzsb6VqbikIrtw0ybEoZXRlOzh
 nHtVUSL51o6HLPZpn9W1fwXBt0hhyKAxs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 09:02:25 -0700
IronPort-SDR: bIYGJp8759BxC0b2Nr9+oDVs9lNiufRvzvdH5W2Lr9pYwgcXMSEjuMLYDY+1PxhpRyR4Zn1Eoj
 Q4okWJwfT9dQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 May 2020 09:11:57 -0700
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
Subject: [PATCH v10 4/9] block: Modify revalidate zones
Date:   Thu,  7 May 2020 01:11:40 +0900
Message-Id: <20200506161145.9841-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200506161145.9841-1-johannes.thumshirn@wdc.com>
References: <20200506161145.9841-1-johannes.thumshirn@wdc.com>
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


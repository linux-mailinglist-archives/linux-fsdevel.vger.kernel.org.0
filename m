Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE41D284D6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgJFOPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 10:15:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46503 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFOPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601993777; x=1633529777;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=brWbdb8ZT/F+65IASdWSJDq+OevjxjDwCP3i3gjiR7s=;
  b=qfNpCKmk0MVk1NS1R0qRrhOCym7JjkhnBnqOjBeYHl5gofJ0/YGjTVGy
   kjApeahpuiJWmQBgh0A9jEmurMSad219WftTzYa1hVbp/ngPKXYhIvEgG
   dOV2HsmFU0pkIBlrH1FZ8fF7gIYxLbiOcIlp5G9ogilA/8O8JD+LqT7mP
   rqr0O3lPcd3KO4phkIc45kAXQaS3AYyHLPviJWIHxCuiL8AbglBIQLVew
   4YCpBooczhe64HVv74Sa1i6UhQkErH1hv8/2T4gb+RYGCQMzXRjHXAV3V
   wVa1gOGDfwNZ2P0+Gd/vYct3tcNwBSx/6bgHO78scUzeQMLIjsXIOPV0D
   g==;
IronPort-SDR: COJF/m5p3AaWRjooEWwAOtCof3dqZNOWa/41Bx7IsxvsyP4y5dsKIIhLUmdvscfBN7jv2oIU9z
 vkKydYkx53er87bUf3ZvD3/I/mBHN2i75nYDuZDIusWFgMnoVa5TPTS5aqAYYZNaLxHKMdSY02
 U0PjvE6KI4qgpSx6dJYcdbQj2/kdEYnRlsv4D7xipEl3HDI5UzUW60X2HkmfH31+lK8WevKN/+
 O0p9rG4QMuKWSqXLkkLuZ8FuNzqpkXnqrJCS7phTQFmugzSHwV7kXf8bi1KhUwkKRbMXh6gbh0
 r+0=
X-IronPort-AV: E=Sophos;i="5.77,343,1596470400"; 
   d="scan'208";a="252599919"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2020 22:16:16 +0800
IronPort-SDR: H2gwr2N0XTdrJvFvSqvrFif6gX/gFyYAzZYdDbfX0vGovxQvjxLWxppnQwR0+0TU7PQe6JFy9H
 m5SlaJH22LAQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 07:01:49 -0700
IronPort-SDR: XeuPyC1xVCVaO6oTOZ5G1B+GZfqxhjQDm4Ss4C5H6VnivqMlzSvI0ln2aVA3fN6pSv07ZOgJ07
 jGyjcFE5QP0A==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Oct 2020 07:15:02 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] block: make maximum zone append size configurable
Date:   Tue,  6 Oct 2020 23:14:47 +0900
Message-Id: <8fe2e364c4dac89e3ecd1234fab24a690d389038.1601993564.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Martin rightfully noted that for normal filesystem IO we have soft limits
in place, to prevent them from getting too big and not lead to
unpredictable latencies. For zone append we only have the hardware limit
in place.

Add a soft limit to the maximal zone append size which is gated by the
hardware's capabilities, so the user can control the IO size of zone
append commands.

Reported-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-settings.c           | 10 ++++++----
 block/blk-sysfs.c              | 33 ++++++++++++++++++++++++++++++++-
 drivers/block/null_blk_zoned.c |  2 +-
 drivers/nvme/host/core.c       |  2 +-
 drivers/scsi/sd_zbc.c          |  2 +-
 include/linux/blkdev.h         |  3 ++-
 6 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 4f6eb4bb1723..e4ff7546dd82 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -222,11 +222,11 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
 
 /**
- * blk_queue_max_zone_append_sectors - set max sectors for a single zone append
+ * blk_queue_max_hw_zone_append_sectors - set max sectors for a single zone append
  * @q:  the request queue for the device
  * @max_zone_append_sectors: maximum number of sectors to write per command
  **/
-void blk_queue_max_zone_append_sectors(struct request_queue *q,
+void blk_queue_max_hw_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors)
 {
 	unsigned int max_sectors;
@@ -244,9 +244,11 @@ void blk_queue_max_zone_append_sectors(struct request_queue *q,
 	 */
 	WARN_ON(!max_sectors);
 
-	q->limits.max_zone_append_sectors = max_sectors;
+	q->limits.max_hw_zone_append_sectors = max_sectors;
+	q->limits.max_zone_append_sectors = min_not_zero(max_sectors,
+							 q->limits.max_zone_append_sectors);
 }
-EXPORT_SYMBOL_GPL(blk_queue_max_zone_append_sectors);
+EXPORT_SYMBOL_GPL(blk_queue_max_hw_zone_append_sectors);
 
 /**
  * blk_queue_max_segments - set max hw segments for a request for this queue
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 76b54c7750b0..087b7e66e638 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -226,6 +226,35 @@ static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
 	return sprintf(page, "%llu\n", max_sectors << SECTOR_SHIFT);
 }
 
+static ssize_t
+queue_zone_append_max_store(struct request_queue *q, const char *page,
+				    size_t count)
+{
+	unsigned long max_hw_sectors = q->limits.max_hw_zone_append_sectors;
+	unsigned long max_sectors;
+	ssize_t ret;
+
+	ret = queue_var_store(&max_sectors, page, count);
+	if (ret < 0)
+		return ret;
+
+	max_sectors >>= SECTOR_SHIFT;
+	max_sectors = min_not_zero(max_sectors, max_hw_sectors);
+
+	spin_lock_irq(&q->queue_lock);
+	q->limits.max_zone_append_sectors = max_sectors;
+	spin_unlock_irq(&q->queue_lock);
+
+	return ret;
+}
+
+static ssize_t queue_zone_append_max_hw_show(struct request_queue *q, char *page)
+{
+	unsigned long long max_sectors = q->limits.max_hw_zone_append_sectors;
+
+	return sprintf(page, "%llu\n", max_sectors << SECTOR_SHIFT);
+}
+
 static ssize_t
 queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 {
@@ -584,7 +613,8 @@ QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
-QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
+QUEUE_RW_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
+QUEUE_RO_ENTRY(queue_zone_append_max_hw, "zone_append_max_hw_bytes");
 
 QUEUE_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
@@ -639,6 +669,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
+	&queue_zone_append_max_hw_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 3d25c9ad2383..b1b08f2a09bd 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -98,7 +98,7 @@ int null_register_zoned_dev(struct nullb *nullb)
 		q->nr_zones = blkdev_nr_zones(nullb->disk);
 	}
 
-	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
+	blk_queue_max_hw_zone_append_sectors(q, dev->zone_size_sects);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c190c56bf702..b2da0ab9d68a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2217,7 +2217,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 
 		ret = blk_revalidate_disk_zones(disk, NULL);
 		if (!ret)
-			blk_queue_max_zone_append_sectors(disk->queue,
+			blk_queue_max_hw_zone_append_sectors(disk->queue,
 							  ctrl->max_zone_append);
 	}
 #endif
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 0e94ff056bff..9412445d4efb 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -705,7 +705,7 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 			   q->limits.max_segments << (PAGE_SHIFT - 9));
 	max_append = min_t(u32, max_append, queue_max_hw_sectors(q));
 
-	blk_queue_max_zone_append_sectors(q, max_append);
+	blk_queue_max_hw_zone_append_sectors(q, max_append);
 
 	sd_zbc_print_zones(sdkp);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cf80e61b4c5e..e53ea384c15d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -336,6 +336,7 @@ struct queue_limits {
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_write_same_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_hw_zone_append_sectors;
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
@@ -1141,7 +1142,7 @@ extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
-extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
+extern void blk_queue_max_hw_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_alignment_offset(struct request_queue *q,
-- 
2.26.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BBE2C749F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbgK1Vtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733110AbgK1TFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:05:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA30C02549B;
        Sat, 28 Nov 2020 08:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kkcMqf6QgKmfF7sy7te2yYBRFOpAGBtPlQPbcimyrvI=; b=v2FM1GuZ9EjJBHBo9RSaqFZioe
        6oGhIB+FG+pupTfIYOX9HbvGrZR+Z7w6UC/9nIEKWz6TeVEgtAf5KvqJ8yxTmj95xDsxFYclMR+CD
        j5RsLRmTxESFkj7aiI68vkGYw3XnacNYyaOanE/IquQqT420ruVqO88nkuVU/R1zgZsH7PvVRRjMe
        YVHWhCvVcPkJt5yrQQzxCINqjn2msj1MGj4gLSxbbU1AhVVhaEfr+6gIvkoYS1GA7J3vLJjBrQDHE
        Z1iF1IAxl3jSAx+rwccf0cdeq88YsV8CqSyeJs0aCdfBxZt9kB/PP+2J2SKM5Kt4YJdDN1OdEbmho
        pKGbYmeA==;
Received: from 089144198196.atnat0007.highway.a1.net ([89.144.198.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kj38I-0001U0-Eo; Sat, 28 Nov 2020 16:31:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 40/45] block: pass a block_device to blk_alloc_devt
Date:   Sat, 28 Nov 2020 17:15:05 +0100
Message-Id: <20201128161510.347752-41-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128161510.347752-1-hch@lst.de>
References: <20201128161510.347752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the block_device actually needed instead of the hd_struct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/blk.h             |  2 +-
 block/genhd.c           | 14 +++++++-------
 block/partitions/core.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index d5bf8f3a078186..9657c6da7c770c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -350,7 +350,7 @@ static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
 
 struct block_device *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
 
-int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
+int blk_alloc_devt(struct block_device *part, dev_t *devt);
 void blk_free_devt(dev_t devt);
 char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
diff --git a/block/genhd.c b/block/genhd.c
index f4e5a892fc8208..835393b7101ace 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -562,8 +562,8 @@ static int blk_mangle_minor(int minor)
 }
 
 /**
- * blk_alloc_devt - allocate a dev_t for a partition
- * @part: partition to allocate dev_t for
+ * blk_alloc_devt - allocate a dev_t for a block device
+ * @bdev: block device to allocate dev_t for
  * @devt: out parameter for resulting dev_t
  *
  * Allocate a dev_t for block device.
@@ -575,14 +575,14 @@ static int blk_mangle_minor(int minor)
  * CONTEXT:
  * Might sleep.
  */
-int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
+int blk_alloc_devt(struct block_device *bdev, dev_t *devt)
 {
-	struct gendisk *disk = part_to_disk(part);
+	struct gendisk *disk = bdev->bd_disk;
 	int idx;
 
 	/* in consecutive minor range? */
-	if (part->bdev->bd_partno < disk->minors) {
-		*devt = MKDEV(disk->major, disk->first_minor + part->bdev->bd_partno);
+	if (bdev->bd_partno < disk->minors) {
+		*devt = MKDEV(disk->major, disk->first_minor + bdev->bd_partno);
 		return 0;
 	}
 
@@ -738,7 +738,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk->flags |= GENHD_FL_UP;
 
-	retval = blk_alloc_devt(disk->part0->bd_part, &devt);
+	retval = blk_alloc_devt(disk->part0, &devt);
 	if (retval) {
 		WARN_ON(1);
 		return;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 6db9ca8b722d66..3d8243334c7cb4 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -392,7 +392,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	pdev->type = &part_type;
 	pdev->parent = ddev;
 
-	err = blk_alloc_devt(p, &devt);
+	err = blk_alloc_devt(bdev, &devt);
 	if (err)
 		goto out_bdput;
 	pdev->devt = devt;
-- 
2.29.2


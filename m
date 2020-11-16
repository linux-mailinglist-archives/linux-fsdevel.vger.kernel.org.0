Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A622B47D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgKPPAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbgKPO77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756B6C0613CF;
        Mon, 16 Nov 2020 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U1T3F6kddQ5RAbJP0Kd5aSQRXwgJOO9lO/0pb1NuZu4=; b=Mp/bnXWKW1eCWc4cnpGQF+LzFz
        +yKGUtIwAwJyLYcIyqIwUzX5kFor/+9XSitRKLGwelhsMyM+jo5MdzNpCHHBJ0Iz9zR3J1N5RDw/L
        elxhWeRTq9mn68jo7mo+5Q4N7FoDnOiB2Ko1LxyfvZVKKrY7T6HB8yCxAUe+NVO99WAAyihpabqln
        mDNQgQ32Fsx3DUoMB7bJ5t1bCEfvo9jNviF/wnSQFLIPLYsctwCrVbyO1039CykidDZsBnCUd8INa
        McCEnHBIAwZ8N3tE8HKmkENLQlH4gRIfZNloYiLCS6I7+1U/hYZQbSbazKQRNqqSS2T9kesdq+8Pe
        qXSnpaVg==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefyu-0004Fd-HL; Mon, 16 Nov 2020 14:59:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 68/78] block: remove ->bd_contains
Date:   Mon, 16 Nov 2020 15:57:59 +0100
Message-Id: <20201116145809.410558-69-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that each gendisk has a reference to the block_device referencing
it, we can just use that everywhere and get rid of ->bd_contain.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsicam.c    |  2 +-
 fs/block_dev.c            | 50 +++++++++++++--------------------------
 include/linux/blk_types.h |  4 +++-
 3 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index 682cf08ab04153..f1553a453616fd 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -32,7 +32,7 @@
  */
 unsigned char *scsi_bios_ptable(struct block_device *dev)
 {
-	struct address_space *mapping = dev->bd_contains->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_whole(dev)->bd_inode->i_mapping;
 	unsigned char *res = NULL;
 	struct page *page;
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index fd4df132a97590..2348f218d45deb 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -886,7 +886,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	spin_lock_init(&bdev->bd_size_lock);
 	bdev->bd_disk = disk;
 	bdev->bd_partno = partno;
-	bdev->bd_contains = NULL;
 	bdev->bd_super = NULL;
 	bdev->bd_inode = inode;
 	bdev->bd_part_count = 0;
@@ -1062,7 +1061,7 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
  */
 int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 {
-	struct block_device *whole = bdev->bd_contains;
+	struct block_device *whole = bdev_whole(bdev);
 
 retry:
 	spin_lock(&bdev_lock);
@@ -1110,7 +1109,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
  */
 static void bd_finish_claiming(struct block_device *bdev, void *holder)
 {
-	struct block_device *whole = bdev->bd_contains;
+	struct block_device *whole = bdev_whole(bdev);
 
 	spin_lock(&bdev_lock);
 	BUG_ON(!bd_may_claim(bdev, whole, holder));
@@ -1139,7 +1138,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
 void bd_abort_claiming(struct block_device *bdev, void *holder)
 {
 	spin_lock(&bdev_lock);
-	bd_clear_claiming(bdev->bd_contains, holder);
+	bd_clear_claiming(bdev_whole(bdev), holder);
 	spin_unlock(&bdev_lock);
 }
 EXPORT_SYMBOL(bd_abort_claiming);
@@ -1434,7 +1433,6 @@ static int bdev_get_gendisk(struct gendisk *disk)
 static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		int for_part)
 {
-	struct block_device *whole = NULL;
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 	bool first_open = false, unblock_events = true, need_restart;
@@ -1445,26 +1443,17 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 	if (ret)
 		goto out;
 
-	if (bdev->bd_partno) {
-		whole = bdget_disk(disk, 0);
-		if (!whole) {
-			ret = -ENOMEM;
-			goto out_put_disk;
-		}
-	}
-
 	if (!for_part && (mode & FMODE_EXCL)) {
 		WARN_ON_ONCE(!holder);
 		ret = bd_prepare_to_claim(bdev, holder);
 		if (ret)
-			goto out_put_whole;
+			goto out_put_disk;
 	}
 
 	disk_block_events(disk);
 	mutex_lock_nested(&bdev->bd_mutex, for_part);
 	if (!bdev->bd_openers) {
 		first_open = true;
-		bdev->bd_contains = bdev;
 
 		if (!bdev->bd_partno) {
 			ret = -ENXIO;
@@ -1502,10 +1491,10 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 				goto out_clear;
 		} else {
 			BUG_ON(for_part);
-			ret = __blkdev_get(whole, mode, NULL, 1);
+			bdgrab(bdev_whole(bdev));
+			ret = __blkdev_get(bdev_whole(bdev), mode, NULL, 1);
 			if (ret)
 				goto out_clear;
-			bdev->bd_contains = bdgrab(whole);
 			bdev->bd_part = disk_get_part(disk, bdev->bd_partno);
 			if (!(disk->flags & GENHD_FL_UP) ||
 			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
@@ -1519,7 +1508,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		if (bdev->bd_bdi == &noop_backing_dev_info)
 			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
 	} else {
-		if (bdev->bd_contains == bdev) {
+		if (!bdev->bd_partno) {
 			ret = 0;
 			if (bdev->bd_disk->fops->open)
 				ret = bdev->bd_disk->fops->open(bdev, mode);
@@ -1558,24 +1547,18 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 	/* only one opener holds the module reference */
 	if (!first_open)
 		module_put(disk->fops->owner);
-	if (whole)
-		bdput(whole);
 	return 0;
 
  out_clear:
 	disk_put_part(bdev->bd_part);
 	bdev->bd_part = NULL;
-	if (bdev != bdev->bd_contains)
-		__blkdev_put(bdev->bd_contains, mode, 1);
-	bdev->bd_contains = NULL;
+	if (bdev_is_partition(bdev))
+		__blkdev_put(bdev_whole(bdev), mode, 1);
  out_unlock_bdev:
 	if (!for_part && (mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
- out_put_whole:
- 	if (whole)
-		bdput(whole);
  out_put_disk:
 	module_put(disk->fops->owner);
 	if (need_restart)
@@ -1765,16 +1748,15 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 
 		bdev_write_inode(bdev);
 	}
-	if (bdev->bd_contains == bdev) {
+	if (!bdev_is_partition(bdev)) {
 		if (disk->fops->release)
 			disk->fops->release(disk, mode);
 	}
 	if (!bdev->bd_openers) {
 		disk_put_part(bdev->bd_part);
 		bdev->bd_part = NULL;
-		if (bdev != bdev->bd_contains)
-			victim = bdev->bd_contains;
-		bdev->bd_contains = NULL;
+		if (bdev_is_partition(bdev))
+			victim = bdev_whole(bdev);
 
 		module_put(disk->fops->owner);
 	}
@@ -1789,6 +1771,7 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	mutex_lock(&bdev->bd_mutex);
 
 	if (mode & FMODE_EXCL) {
+		struct block_device *whole = bdev_whole(bdev);
 		bool bdev_free;
 
 		/*
@@ -1799,13 +1782,12 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 		spin_lock(&bdev_lock);
 
 		WARN_ON_ONCE(--bdev->bd_holders < 0);
-		WARN_ON_ONCE(--bdev->bd_contains->bd_holders < 0);
+		WARN_ON_ONCE(--whole->bd_holders < 0);
 
-		/* bd_contains might point to self, check in a separate step */
 		if ((bdev_free = !bdev->bd_holders))
 			bdev->bd_holder = NULL;
-		if (!bdev->bd_contains->bd_holders)
-			bdev->bd_contains->bd_holder = NULL;
+		if (!whole->bd_holders)
+			whole->bd_holder = NULL;
 
 		spin_unlock(&bdev_lock);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d9b69bbde5cc54..041caca25fc787 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -32,7 +32,6 @@ struct block_device {
 #ifdef CONFIG_SYSFS
 	struct list_head	bd_holder_disks;
 #endif
-	struct block_device *	bd_contains;
 	u8			bd_partno;
 	struct hd_struct *	bd_part;
 	/* number of times partitions within this device have been opened. */
@@ -48,6 +47,9 @@ struct block_device {
 	struct mutex		bd_fsfreeze_mutex;
 } __randomize_layout;
 
+#define bdev_whole(_bdev) \
+	((_bdev)->bd_disk->part0.bdev)
+
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
  * Alpha cannot write a byte atomically, so we need to use 32-bit value.
-- 
2.29.2


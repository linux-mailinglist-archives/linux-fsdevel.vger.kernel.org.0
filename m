Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBB2B792D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKRIse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgKRIsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06664C0613D4;
        Wed, 18 Nov 2020 00:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Jn3i40Vc573JfqwwUze67l0f1T02hvayuSlJ2ghsy0k=; b=FTL5yZhtosIFlvGZaUcV3BSZLO
        2TqrrRJoqdDVaWLXhmhx6KTTrdYGYfDRTknpg1OIhc5h+bhaE/jRW42OfB50rTNA9k/yOREjMyc1q
        h1r0D7VZAPNZoHVenErI6dEmWW0bMHPKydKZwcVrSXAtkonnEliwxlKGe0UTBmuxKqeN/Kv7CdhDr
        wSgB/IOGDweRQP5CfnoBHqzOmz/o+GbMPLsREHvH7aVHGynd6iKm2i5wBRhf06XMiFWWVW/NVbBWN
        QEnO32F/mnmpb2MJ7448A+o5rFMOH5KqJcAc12v3q1pWpqxRmnC8C8RDkX6/37Dm9ET28xdA3djUt
        VRLfV1Rw==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8Z-0007ml-KP; Wed, 18 Nov 2020 08:48:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 13/20] block: remove ->bd_contains
Date:   Wed, 18 Nov 2020 09:47:53 +0100
Message-Id: <20201118084800.2339180-14-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that each hd_struct has a reference to the corresponding
block_device, there is no need for the bd_contains pointer.  Add
a bdev_whole() helper to look up the whole device block_device
struture instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsicam.c    |  2 +-
 fs/block_dev.c            | 46 ++++++++++++---------------------------
 include/linux/blk_types.h |  4 +++-
 3 files changed, 18 insertions(+), 34 deletions(-)

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
index dd52dbd266cde7..258a1ced924483 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -879,7 +879,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	spin_lock_init(&bdev->bd_size_lock);
 	bdev->bd_disk = disk;
 	bdev->bd_partno = partno;
-	bdev->bd_contains = NULL;
 	bdev->bd_super = NULL;
 	bdev->bd_inode = inode;
 	bdev->bd_part_count = 0;
@@ -1054,7 +1053,7 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
  */
 int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 {
-	struct block_device *whole = bdev->bd_contains;
+	struct block_device *whole = bdev_whole(bdev);
 
 retry:
 	spin_lock(&bdev_lock);
@@ -1102,7 +1101,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
  */
 static void bd_finish_claiming(struct block_device *bdev, void *holder)
 {
-	struct block_device *whole = bdev->bd_contains;
+	struct block_device *whole = bdev_whole(bdev);
 
 	spin_lock(&bdev_lock);
 	BUG_ON(!bd_may_claim(bdev, whole, holder));
@@ -1131,7 +1130,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
 void bd_abort_claiming(struct block_device *bdev, void *holder)
 {
 	spin_lock(&bdev_lock);
-	bd_clear_claiming(bdev->bd_contains, holder);
+	bd_clear_claiming(bdev_whole(bdev), holder);
 	spin_unlock(&bdev_lock);
 }
 EXPORT_SYMBOL(bd_abort_claiming);
@@ -1429,7 +1428,6 @@ static void put_disk_and_module(struct gendisk *disk)
 static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		int for_part)
 {
-	struct block_device *whole = NULL;
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 	bool first_open = false, unblock_events = true, need_restart;
@@ -1447,26 +1445,17 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 	}
 	up_read(&disk->lookup_sem);
 
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
@@ -1504,10 +1493,10 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 				goto out_clear;
 		} else {
 			BUG_ON(for_part);
-			ret = __blkdev_get(whole, mode, NULL, 1);
+			ret = __blkdev_get(bdev_whole(bdev), mode, NULL, 1);
 			if (ret)
 				goto out_clear;
-			bdev->bd_contains = bdgrab(whole);
+			bdgrab(bdev_whole(bdev));
 			bdev->bd_part = disk_get_part(disk, bdev->bd_partno);
 			if (!(disk->flags & GENHD_FL_UP) ||
 			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
@@ -1521,7 +1510,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		if (bdev->bd_bdi == &noop_backing_dev_info)
 			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
 	} else {
-		if (bdev->bd_contains == bdev) {
+		if (!bdev->bd_partno) {
 			ret = 0;
 			if (bdev->bd_disk->fops->open)
 				ret = bdev->bd_disk->fops->open(bdev, mode);
@@ -1560,24 +1549,18 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 	/* only one opener holds refs to the module and disk */
 	if (!first_open)
 		put_disk_and_module(disk);
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
 	put_disk_and_module(disk);
 	if (need_restart)
@@ -1768,8 +1751,7 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 		disk_put_part(bdev->bd_part);
 		bdev->bd_part = NULL;
 		if (bdev_is_partition(bdev))
-			victim = bdev->bd_contains;
-		bdev->bd_contains = NULL;
+			victim = bdev_whole(bdev);
 
 		put_disk_and_module(disk);
 	} else {
@@ -1787,6 +1769,7 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	mutex_lock(&bdev->bd_mutex);
 
 	if (mode & FMODE_EXCL) {
+		struct block_device *whole = bdev_whole(bdev);
 		bool bdev_free;
 
 		/*
@@ -1797,13 +1780,12 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
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
index 0069bee992063e..453b940b87d8e9 100644
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
 #define bdev_kobj(_bdev) \
 	(&part_to_dev((_bdev)->bd_part)->kobj)
 
-- 
2.29.2


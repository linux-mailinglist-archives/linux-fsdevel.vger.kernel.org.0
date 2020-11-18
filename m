Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA722B7945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgKRIsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgKRIsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480F0C0613D4;
        Wed, 18 Nov 2020 00:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FT4Z5N98GPcubFAGww0jhwPW9F0Di1Byp+gvVq3gb/s=; b=L51yZ/O95Y/bHdFQrdlh9XRfK6
        86E/t3LLdpxXx/N8cYklXxJNmv11jQH9rjzRQTPaU0UGJE3IuyS2UYG5fylg/OJZaXCYSXhoboOs/
        n4h+G4acgA/01wHmgy3n3xnphU5prBfDszk1GSDowgN/R1N6LAFg1Zpny3KhoVer1f8X6IMhBwO2a
        Xj26Fuo2bK70pxLUE7na7K9TRIoh5K+M07lptcyCErjEayu9RJo9mCLv2iZBZL7ydP0Qqv0yrgX41
        WVrQ9DsoftXmRZb7G/HL9+rZAb46BUO1NdTcS1MHouuCE9aksnM6hKJBd3C1zTMplL50RTKz5JvTh
        Sc3RbL7w==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8Y-0007mT-3L; Wed, 18 Nov 2020 08:48:22 +0000
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
Subject: [PATCH 12/20] block: simplify the block device claiming interface
Date:   Wed, 18 Nov 2020 09:47:52 +0100
Message-Id: <20201118084800.2339180-13-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stop passing the whole device as a separate argument given that it
can be trivially deducted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c   | 12 +++-----
 fs/block_dev.c         | 69 +++++++++++++++++++-----------------------
 include/linux/blkdev.h |  6 ++--
 3 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b42c728620c9e4..599e94a7e69259 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1071,7 +1071,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	struct file	*file;
 	struct inode	*inode;
 	struct address_space *mapping;
-	struct block_device *claimed_bdev = NULL;
 	int		error;
 	loff_t		size;
 	bool		partscan;
@@ -1090,8 +1089,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bdev->bd_contains;
-		error = bd_prepare_to_claim(bdev, claimed_bdev, loop_configure);
+		error = bd_prepare_to_claim(bdev, loop_configure);
 		if (error)
 			goto out_putf;
 	}
@@ -1178,15 +1176,15 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
-	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
+	if (!(mode & FMODE_EXCL))
+		bd_abort_claiming(bdev, loop_configure);
 	return 0;
 
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 out_bdev:
-	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
+	if (!(mode & FMODE_EXCL))
+		bd_abort_claiming(bdev, loop_configure);
 out_putf:
 	fput(file);
 out:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index e94633dc6ad93b..dd52dbd266cde7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -110,24 +110,20 @@ EXPORT_SYMBOL(invalidate_bdev);
 int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
 			loff_t lstart, loff_t lend)
 {
-	struct block_device *claimed_bdev = NULL;
-	int err;
-
 	/*
 	 * If we don't hold exclusive handle for the device, upgrade to it
 	 * while we discard the buffer cache to avoid discarding buffers
 	 * under live filesystem.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bdev->bd_contains;
-		err = bd_prepare_to_claim(bdev, claimed_bdev,
-					  truncate_bdev_range);
+		int err = bd_prepare_to_claim(bdev, truncate_bdev_range);
 		if (err)
 			return err;
 	}
+
 	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
-	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, truncate_bdev_range);
+	if (!(mode & FMODE_EXCL))
+		bd_abort_claiming(bdev, truncate_bdev_range);
 	return 0;
 }
 EXPORT_SYMBOL(truncate_bdev_range);
@@ -1047,7 +1043,6 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
 /**
  * bd_prepare_to_claim - claim a block device
  * @bdev: block device of interest
- * @whole: the whole device containing @bdev, may equal @bdev
  * @holder: holder trying to claim @bdev
  *
  * Claim @bdev.  This function fails if @bdev is already claimed by another
@@ -1057,9 +1052,10 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
  * RETURNS:
  * 0 if @bdev can be claimed, -EBUSY otherwise.
  */
-int bd_prepare_to_claim(struct block_device *bdev, struct block_device *whole,
-		void *holder)
+int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 {
+	struct block_device *whole = bdev->bd_contains;
+
 retry:
 	spin_lock(&bdev_lock);
 	/* if someone else claimed, fail */
@@ -1099,15 +1095,15 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
 /**
  * bd_finish_claiming - finish claiming of a block device
  * @bdev: block device of interest
- * @whole: whole block device
  * @holder: holder that has claimed @bdev
  *
  * Finish exclusive open of a block device. Mark the device as exlusively
  * open by the holder and wake up all waiters for exclusive open to finish.
  */
-static void bd_finish_claiming(struct block_device *bdev,
-		struct block_device *whole, void *holder)
+static void bd_finish_claiming(struct block_device *bdev, void *holder)
 {
+	struct block_device *whole = bdev->bd_contains;
+
 	spin_lock(&bdev_lock);
 	BUG_ON(!bd_may_claim(bdev, whole, holder));
 	/*
@@ -1132,11 +1128,10 @@ static void bd_finish_claiming(struct block_device *bdev,
  * also used when exclusive open is not actually desired and we just needed
  * to block other exclusive openers for a while.
  */
-void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
-		       void *holder)
+void bd_abort_claiming(struct block_device *bdev, void *holder)
 {
 	spin_lock(&bdev_lock);
-	bd_clear_claiming(whole, holder);
+	bd_clear_claiming(bdev->bd_contains, holder);
 	spin_unlock(&bdev_lock);
 }
 EXPORT_SYMBOL(bd_abort_claiming);
@@ -1434,7 +1429,7 @@ static void put_disk_and_module(struct gendisk *disk)
 static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		int for_part)
 {
-	struct block_device *whole = NULL, *claiming = NULL;
+	struct block_device *whole = NULL;
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 	bool first_open = false, unblock_events = true, need_restart;
@@ -1462,11 +1457,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 
 	if (!for_part && (mode & FMODE_EXCL)) {
 		WARN_ON_ONCE(!holder);
-		if (whole)
-			claiming = whole;
-		else
-			claiming = bdev;
-		ret = bd_prepare_to_claim(bdev, claiming, holder);
+		ret = bd_prepare_to_claim(bdev, holder);
 		if (ret)
 			goto out_put_whole;
 	}
@@ -1543,21 +1534,23 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		}
 	}
 	bdev->bd_openers++;
-	if (for_part)
+	if (for_part) {
 		bdev->bd_part_count++;
-	if (claiming)
-		bd_finish_claiming(bdev, claiming, holder);
+	} else if (mode & FMODE_EXCL) {
+		bd_finish_claiming(bdev, holder);
 
-	/*
-	 * Block event polling for write claims if requested.  Any write holder
-	 * makes the write_holder state stick until all are released.  This is
-	 * good enough and tracking individual writeable reference is too
-	 * fragile given the way @mode is used in blkdev_get/put().
-	 */
-	if (claiming && (mode & FMODE_WRITE) && !bdev->bd_write_holder &&
-	    (disk->flags & GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE)) {
-		bdev->bd_write_holder = true;
-		unblock_events = false;
+		/*
+		 * Block event polling for write claims if requested.  Any write
+		 * holder makes the write_holder state stick until all are
+		 * released.  This is good enough and tracking individual
+		 * writeable reference is too fragile given the way @mode is
+		 * used in blkdev_get/put().
+		 */
+		if ((mode & FMODE_WRITE) && !bdev->bd_write_holder &&
+		    (disk->flags & GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE)) {
+			bdev->bd_write_holder = true;
+			unblock_events = false;
+		}
 	}
 	mutex_unlock(&bdev->bd_mutex);
 
@@ -1578,8 +1571,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		__blkdev_put(bdev->bd_contains, mode, 1);
 	bdev->bd_contains = NULL;
  out_unlock_bdev:
-	if (claiming)
-		bd_abort_claiming(bdev, claiming, holder);
+	if (!for_part && (mode & FMODE_EXCL))
+		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
  out_put_whole:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 044d9dd159d882..696b2f9c5529d8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1988,10 +1988,8 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
 struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 		void *holder);
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder);
-int bd_prepare_to_claim(struct block_device *bdev, struct block_device *whole,
-		void *holder);
-void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
-		void *holder);
+int bd_prepare_to_claim(struct block_device *bdev, void *holder);
+void bd_abort_claiming(struct block_device *bdev, void *holder);
 void blkdev_put(struct block_device *bdev, fmode_t mode);
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
-- 
2.29.2


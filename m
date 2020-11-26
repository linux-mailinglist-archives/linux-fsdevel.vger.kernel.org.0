Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ED02C54C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389966AbgKZNHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389943AbgKZNHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:07:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1BDC0613D4;
        Thu, 26 Nov 2020 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yfOmHITfcmrnqqH2mTFIs2gex5rvDz6ddqSrV3AiET0=; b=NMV1mshqul/Oud+p60vEs+VE0p
        o7Qst0ZFTy6wPe6H5OvWgcxVgVScZ1iZUi8ckr3mSDgDpONWHd7vNCqRrGh2ZmvUjtu9YrFRWnEfb
        DIACGJCnZB5f1zWW0B9/+snJ2nNXMdIcPeAJf0p8I8ibdF1HSWAlDT1na8+hKIrd2Uvz1zVzHCTN9
        Fqs4h9iuwKNPX+dDYVDVDw/3MxdbwiObHwTqY0DM1Q2ZEb/eQnGQP3+qD4Cj3AjWYXZuRKAA4sttg
        fUwulEoxgHx5kI4IgGfc7V18741CIxeX137t1b3lnD+FP8dT5dQ1JsNc4lHyQ4lPtAXXcLCQ8Q2hK
        yTj8uIkw==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGzN-00043l-V4; Thu, 26 Nov 2020 13:07:10 +0000
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
Subject: [PATCH 26/44] block: simplify the block device claiming interface
Date:   Thu, 26 Nov 2020 14:04:04 +0100
Message-Id: <20201126130422.92945-27-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stop passing the whole device as a separate argument given that it
can be trivially deducted and cleanup the !holder debug check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Tejun Heo <tj@kernel.org>
---
 drivers/block/loop.c   | 12 +++++-----
 fs/block_dev.c         | 51 +++++++++++++++---------------------------
 include/linux/blkdev.h |  6 ++---
 3 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c0df88b3300c41..d643c67be6acea 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1069,7 +1069,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	struct file	*file;
 	struct inode	*inode;
 	struct address_space *mapping;
-	struct block_device *claimed_bdev = NULL;
 	int		error;
 	loff_t		size;
 	bool		partscan;
@@ -1088,8 +1087,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bdev_whole(bdev);
-		error = bd_prepare_to_claim(bdev, claimed_bdev, loop_configure);
+		error = bd_prepare_to_claim(bdev, loop_configure);
 		if (error)
 			goto out_putf;
 	}
@@ -1176,15 +1174,15 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
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
index 73f45ae1d3d50c..f180ac0e87844f 100644
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
-		claimed_bdev = bdev_whole(bdev);
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
@@ -974,7 +970,6 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
 /**
  * bd_prepare_to_claim - claim a block device
  * @bdev: block device of interest
- * @whole: the whole device containing @bdev, may equal @bdev
  * @holder: holder trying to claim @bdev
  *
  * Claim @bdev.  This function fails if @bdev is already claimed by another
@@ -984,9 +979,12 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
  * RETURNS:
  * 0 if @bdev can be claimed, -EBUSY otherwise.
  */
-int bd_prepare_to_claim(struct block_device *bdev, struct block_device *whole,
-		void *holder)
+int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 {
+	struct block_device *whole = bdev_whole(bdev);
+
+	if (WARN_ON_ONCE(!holder))
+		return -EINVAL;
 retry:
 	spin_lock(&bdev_lock);
 	/* if someone else claimed, fail */
@@ -1026,15 +1024,15 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
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
+	struct block_device *whole = bdev_whole(bdev);
+
 	spin_lock(&bdev_lock);
 	BUG_ON(!bd_may_claim(bdev, whole, holder));
 	/*
@@ -1059,11 +1057,10 @@ static void bd_finish_claiming(struct block_device *bdev,
  * also used when exclusive open is not actually desired and we just needed
  * to block other exclusive openers for a while.
  */
-void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
-		       void *holder)
+void bd_abort_claiming(struct block_device *bdev, void *holder)
 {
 	spin_lock(&bdev_lock);
-	bd_clear_claiming(whole, holder);
+	bd_clear_claiming(bdev_whole(bdev), holder);
 	spin_unlock(&bdev_lock);
 }
 EXPORT_SYMBOL(bd_abort_claiming);
@@ -1480,7 +1477,6 @@ void blkdev_put_no_open(struct block_device *bdev)
  */
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 {
-	struct block_device *claiming;
 	bool unblock_events = true;
 	struct block_device *bdev;
 	struct gendisk *disk;
@@ -1503,15 +1499,9 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	disk = bdev->bd_disk;
 
 	if (mode & FMODE_EXCL) {
-		WARN_ON_ONCE(!holder);
-	
-		ret = -ENOMEM;
-		claiming = bdget_disk(disk, 0);
-		if (!claiming)
-			goto put_blkdev;
-		ret = bd_prepare_to_claim(bdev, claiming, holder);
+		ret = bd_prepare_to_claim(bdev, holder);
 		if (ret)
-			goto put_claiming;
+			goto put_blkdev;
 	}
 
 	disk_block_events(disk);
@@ -1521,7 +1511,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	if (ret)
 		goto abort_claiming;
 	if (mode & FMODE_EXCL) {
-		bd_finish_claiming(bdev, claiming, holder);
+		bd_finish_claiming(bdev, holder);
 
 		/*
 		 * Block event polling for write claims if requested.  Any write
@@ -1540,18 +1530,13 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 
 	if (unblock_events)
 		disk_unblock_events(disk);
-	if (mode & FMODE_EXCL)
-		bdput(claiming);
 	return bdev;
 
 abort_claiming:
 	if (mode & FMODE_EXCL)
-		bd_abort_claiming(bdev, claiming, holder);
+		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
-put_claiming:
-	if (mode & FMODE_EXCL)
-		bdput(claiming);
 put_blkdev:
 	blkdev_put_no_open(bdev);
 	if (ret == -ERESTARTSYS)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5d48b92f5e4348..43a25d855e049a 100644
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
 
 /* just for blk-cgroup, don't use elsewhere */
-- 
2.29.2


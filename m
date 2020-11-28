Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4C02C75A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbgK1VtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbgK1Sm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:42:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99CC025486;
        Sat, 28 Nov 2020 08:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vHZKilZd0flA+9QmXJqftcP+lHbmEPxCO75tRZ/zDDk=; b=pm1qv/3prdcgaI0NAiS7TVFLDy
        h4ZjV5Alw4Znz3wUC9Xcc64kHzDCE6RBYJS6xAJR+M/FpkdveCqN+ewUrDY0idpjv1UCxnmx82WLn
        w5kMwGSM8X6afZs8Ftqsy3T8VZ2uNrmdCFT1nBZoBjjXINCzfl0IYk9z9fd0HBzqcm5kXB1bAz6rz
        T74/H7ssrDgC2+P/8RTyT1zeehuVHYsWm78gIO690EwDeCRe+MB0oR0tY5H9IHv9sUcIaurQjxxpo
        vftvcXdcMRV1WX+pN5LzsmHFvuBRXernx1sCyinIi/zkHX6FOUsuyyI3R8sUoZ/D2BPFFTlu0YdME
        DIZ0mLdA==;
Received: from [2001:4bb8:18c:1dd6:48f3:741a:602e:7fdd] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kj2t0-0000IS-Is; Sat, 28 Nov 2020 16:15:47 +0000
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
Subject: [PATCH 21/45] block: refactor blkdev_get
Date:   Sat, 28 Nov 2020 17:14:46 +0100
Message-Id: <20201128161510.347752-22-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128161510.347752-1-hch@lst.de>
References: <20201128161510.347752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move more code that is only run on the outer open but not the open of
the underlying whole device when opening a partition into blkdev_get,
which leads to a much easier to follow structure.

This allows to simplify the disk and module refcounting so that one
reference is held for each open, similar to what we do with normal
file operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 185 +++++++++++++++++++++++--------------------------
 1 file changed, 86 insertions(+), 99 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6016777b648336..0c533ac92e2492 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1407,46 +1407,12 @@ EXPORT_SYMBOL_GPL(bdev_disk_changed);
  *  mutex_lock(part->bd_mutex)
  *    mutex_lock_nested(whole->bd_mutex, 1)
  */
-
-static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
-		int for_part)
+static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
+		int partno, fmode_t mode)
 {
-	struct block_device *whole = NULL, *claiming = NULL;
-	struct gendisk *disk;
 	int ret;
-	int partno;
-	bool first_open = false, unblock_events = true, need_restart;
-
- restart:
-	need_restart = false;
-	ret = -ENXIO;
-	disk = bdev_get_gendisk(bdev, &partno);
-	if (!disk)
-		goto out;
-
-	if (partno) {
-		whole = bdget_disk(disk, 0);
-		if (!whole) {
-			ret = -ENOMEM;
-			goto out_put_disk;
-		}
-	}
 
-	if (!for_part && (mode & FMODE_EXCL)) {
-		WARN_ON_ONCE(!holder);
-		if (whole)
-			claiming = whole;
-		else
-			claiming = bdev;
-		ret = bd_prepare_to_claim(bdev, claiming, holder);
-		if (ret)
-			goto out_put_whole;
-	}
-
-	disk_block_events(disk);
-	mutex_lock_nested(&bdev->bd_mutex, for_part);
 	if (!bdev->bd_openers) {
-		first_open = true;
 		bdev->bd_disk = disk;
 		bdev->bd_contains = bdev;
 		bdev->bd_partno = partno;
@@ -1458,15 +1424,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 				goto out_clear;
 
 			ret = 0;
-			if (disk->fops->open) {
+			if (disk->fops->open)
 				ret = disk->fops->open(bdev, mode);
-				/*
-				 * If we lost a race with 'disk' being deleted,
-				 * try again.  See md.c
-				 */
-				if (ret == -ERESTARTSYS)
-					need_restart = true;
-			}
 
 			if (!ret) {
 				bd_set_nr_sectors(bdev, get_capacity(disk));
@@ -1486,14 +1445,23 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 			if (ret)
 				goto out_clear;
 		} else {
-			BUG_ON(for_part);
-			ret = __blkdev_get(whole, mode, NULL, 1);
-			if (ret)
+			struct block_device *whole = bdget_disk(disk, 0);
+
+			mutex_lock_nested(&whole->bd_mutex, 1);
+			ret = __blkdev_get(whole, disk, 0, mode);
+			if (ret) {
+				mutex_unlock(&whole->bd_mutex);
+				bdput(whole);
 				goto out_clear;
-			bdev->bd_contains = bdgrab(whole);
+			}
+			whole->bd_part_count++;
+			mutex_unlock(&whole->bd_mutex);
+
+			bdev->bd_contains = whole;
 			bdev->bd_part = disk_get_part(disk, partno);
 			if (!(disk->flags & GENHD_FL_UP) ||
 			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
+				__blkdev_put(whole, mode, 1);
 				ret = -ENXIO;
 				goto out_clear;
 			}
@@ -1513,58 +1481,17 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 			    (!ret || ret == -ENOMEDIUM))
 				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 			if (ret)
-				goto out_unlock_bdev;
+				return ret;
 		}
 	}
 	bdev->bd_openers++;
-	if (for_part)
-		bdev->bd_part_count++;
-	if (claiming)
-		bd_finish_claiming(bdev, claiming, holder);
-
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
-	}
-	mutex_unlock(&bdev->bd_mutex);
-
-	if (unblock_events)
-		disk_unblock_events(disk);
-
-	/* only one opener holds refs to the module and disk */
-	if (!first_open)
-		put_disk_and_module(disk);
-	if (whole)
-		bdput(whole);
 	return 0;
 
  out_clear:
 	disk_put_part(bdev->bd_part);
 	bdev->bd_disk = NULL;
 	bdev->bd_part = NULL;
-	if (bdev != bdev->bd_contains)
-		__blkdev_put(bdev->bd_contains, mode, 1);
 	bdev->bd_contains = NULL;
- out_unlock_bdev:
-	if (claiming)
-		bd_abort_claiming(bdev, claiming, holder);
-	mutex_unlock(&bdev->bd_mutex);
-	disk_unblock_events(disk);
- out_put_whole:
- 	if (whole)
-		bdput(whole);
- out_put_disk:
-	put_disk_and_module(disk);
-	if (need_restart)
-		goto restart;
- out:
 	return ret;
 }
 
@@ -1589,7 +1516,12 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
  */
 static int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 {
-	int ret, perm = 0;
+	struct block_device *claiming;
+	bool unblock_events = true;
+	struct gendisk *disk;
+	int perm = 0;
+	int partno;
+	int ret;
 
 	if (mode & FMODE_READ)
 		perm |= MAY_READ;
@@ -1599,13 +1531,67 @@ static int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 	if (ret)
 		goto bdput;
 
-	ret =__blkdev_get(bdev, mode, holder, 0);
-	if (ret)
+	/*
+	 * If we lost a race with 'disk' being deleted, try again.  See md.c.
+	 */
+retry:
+	ret = -ENXIO;
+	disk = bdev_get_gendisk(bdev, &partno);
+	if (!disk)
 		goto bdput;
-	return 0;
 
+	if (mode & FMODE_EXCL) {
+		WARN_ON_ONCE(!holder);
+	
+		ret = -ENOMEM;
+		claiming = bdget_disk(disk, 0);
+		if (!claiming)
+			goto put_disk;
+		ret = bd_prepare_to_claim(bdev, claiming, holder);
+		if (ret)
+			goto put_claiming;
+	}
+
+	disk_block_events(disk);
+
+	mutex_lock(&bdev->bd_mutex);
+	ret =__blkdev_get(bdev, disk, partno, mode);
+	if (!(mode & FMODE_EXCL)) {
+		; /* nothing to do here */
+	} else if (ret) {
+		bd_abort_claiming(bdev, claiming, holder);
+	} else {
+		bd_finish_claiming(bdev, claiming, holder);
+
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
+	}
+	mutex_unlock(&bdev->bd_mutex);
+
+	if (unblock_events)
+		disk_unblock_events(disk);
+
+put_claiming:
+	if (mode & FMODE_EXCL)
+		bdput(claiming);
+put_disk:
+	if (ret)
+		put_disk_and_module(disk);
+	if (ret == -ERESTARTSYS)
+		goto retry;
 bdput:
-	bdput(bdev);
+	if (ret)
+		bdput(bdev);
 	return ret;
 }
 
@@ -1753,8 +1739,6 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 		if (bdev_is_partition(bdev))
 			victim = bdev->bd_contains;
 		bdev->bd_contains = NULL;
-
-		put_disk_and_module(disk);
 	} else {
 		if (!bdev_is_partition(bdev) && disk->fops->release)
 			disk->fops->release(disk, mode);
@@ -1767,6 +1751,8 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 
 void blkdev_put(struct block_device *bdev, fmode_t mode)
 {
+	struct gendisk *disk = bdev->bd_disk;
+
 	mutex_lock(&bdev->bd_mutex);
 
 	if (mode & FMODE_EXCL) {
@@ -1795,7 +1781,7 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 		 * unblock evpoll if it was a write holder.
 		 */
 		if (bdev_free && bdev->bd_write_holder) {
-			disk_unblock_events(bdev->bd_disk);
+			disk_unblock_events(disk);
 			bdev->bd_write_holder = false;
 		}
 	}
@@ -1805,11 +1791,12 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	 * event.  This is to ensure detection of media removal commanded
 	 * from userland - e.g. eject(1).
 	 */
-	disk_flush_events(bdev->bd_disk, DISK_EVENT_MEDIA_CHANGE);
+	disk_flush_events(disk, DISK_EVENT_MEDIA_CHANGE);
 
 	mutex_unlock(&bdev->bd_mutex);
 
 	__blkdev_put(bdev, mode, 0);
+	put_disk_and_module(disk);
 }
 EXPORT_SYMBOL(blkdev_put);
 
-- 
2.29.2


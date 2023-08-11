Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB70778B28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjHKKKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjHKKK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:10:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7724358B;
        Fri, 11 Aug 2023 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+8xr8Uhs6dKUcdwdPIFHHTcFEebNaXGmRTj5PR71d4Y=; b=X5IwFNopQ+BITsDb7BAJK37Ih+
        Jjl45uX9ftcnsd2BKUz7laOS2LsrzQ9eMC66blIe172pZE0faykKkz4x5679T8o7GvCkdu7i/0ZGP
        oM6Evvv2Eywjm0Gxn5veNmDx+2JQ380ATpG6CeZ28s2UBbcKophCJdH9kkQRlbSdPO7jHiKsORDWk
        FQtyAAevuv7vwh+DYeO/IefDMMSSk/xX//PP1IpHTGKczbi/4sMG3ic1CbkfkHPvxjUzoj4WJEnrJ
        EO5NTy4eNtS1xWxnRgibKR5Vsnxi08yezeHccikg3zdOJrur4qaWlzD4SJ+Ux3C+lmdc51b+g0s3F
        Nkdvl/mA==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4w-00A5q3-26;
        Fri, 11 Aug 2023 10:09:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/17] block: consolidate __invalidate_device and fsync_bdev
Date:   Fri, 11 Aug 2023 12:08:24 +0200
Message-Id: <20230811100828.1897174-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We currently have two interfaces that take a block_devices and the find
a mounted file systems to flush or invaldidate data on it.  Both are a
bit problematic because they only work for the "main" block devices
that is used as s_dev for the super_block, and because they don't call
into the file system at all.

Merge the two into a new bdev_mark_dead helper that does both the
syncing and invalidation and which is properly documented.  This is
in preparation of merging the functionality into the ->mark_dead
holder operation so that it will work on additional block devices
used by a file systems and give us a single entry point for invalidation
of dead devices or media.

Note that a single standalone fsync_bdev call for an obscure ioctl
remains for now, but that one will also be deal with in a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c              | 33 ++++++++++++++++++++++++++++-----
 block/disk-events.c       |  4 ++--
 block/genhd.c             |  3 +--
 block/partitions/core.c   |  5 +----
 drivers/s390/block/dasd.c |  6 ++----
 fs/super.c                |  4 ++--
 include/linux/blkdev.h    |  2 +-
 7 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 979e28a46b988e..b9ca947bd5e405 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -221,7 +221,6 @@ int fsync_bdev(struct block_device *bdev)
 	}
 	return sync_blockdev(bdev);
 }
-EXPORT_SYMBOL(fsync_bdev);
 
 /**
  * freeze_bdev - lock a filesystem and force it into a consistent state
@@ -960,12 +959,27 @@ int lookup_bdev(const char *pathname, dev_t *dev)
 }
 EXPORT_SYMBOL(lookup_bdev);
 
-int __invalidate_device(struct block_device *bdev, bool kill_dirty)
+/**
+ * bdev_mark_dead - mark a block device as dead
+ * @bdev: block device to operate on
+ * @surprise: indicate a surprise removal
+ *
+ * Tell the file system that this devices or media is dead.  If @surprise is set
+ * to %true the device or media is already gone, if not we are preparing for an
+ * orderly removal.
+ *
+ * This syncs out all dirty data and writes back inodes and then invalidates any
+ * cached data in the inodes on the file system, the inodes themselves and the
+ * block device mapping.
+ */
+void bdev_mark_dead(struct block_device *bdev, bool surprise)
 {
 	struct super_block *sb = get_super(bdev);
 	int res = 0;
 
 	if (sb) {
+		if (!surprise)
+			sync_filesystem(sb);
 		/*
 		 * no need to lock the super, get_super holds the
 		 * read mutex so the filesystem cannot go away
@@ -973,13 +987,22 @@ int __invalidate_device(struct block_device *bdev, bool kill_dirty)
 		 * hold).
 		 */
 		shrink_dcache_sb(sb);
-		res = invalidate_inodes(sb, kill_dirty);
+		res = invalidate_inodes(sb, true);
 		drop_super(sb);
+	} else {
+		if (!surprise)
+			sync_blockdev(bdev);
 	}
 	invalidate_bdev(bdev);
-	return res;
 }
-EXPORT_SYMBOL(__invalidate_device);
+#ifdef CONFIG_DASD
+/*
+ * Drivers should not use this directly, but the DASD driver has historically
+ * had a shutdown to offline mode that doesn't actually remove the gendisk
+ * that otherwise looks a lot like a safe device removal.
+ */
+EXPORT_SYMBOL_GPL(bdev_mark_dead);
+#endif
 
 void sync_bdevs(bool wait)
 {
diff --git a/block/disk-events.c b/block/disk-events.c
index 6b858d3504772c..422db8292d0997 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -281,7 +281,7 @@ bool disk_check_media_change(struct gendisk *disk)
 	if (!(events & DISK_EVENT_MEDIA_CHANGE))
 		return false;
 
-	__invalidate_device(disk->part0, true);
+	bdev_mark_dead(disk->part0, true);
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
 	return true;
 }
@@ -300,7 +300,7 @@ void disk_force_media_change(struct gendisk *disk)
 {
 	disk_event_uevent(disk, DISK_EVENT_MEDIA_CHANGE);
 	inc_diskseq(disk);
-	__invalidate_device(disk->part0, true);
+	bdev_mark_dead(disk->part0, true);
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
 }
 EXPORT_SYMBOL_GPL(disk_force_media_change);
diff --git a/block/genhd.c b/block/genhd.c
index 3d287b32d50dfd..afc2cb09eb94b9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -647,8 +647,7 @@ void del_gendisk(struct gendisk *disk)
 	mutex_lock(&disk->open_mutex);
 	xa_for_each(&disk->part_tbl, idx, part) {
 		remove_inode_hash(part->bd_inode);
-		fsync_bdev(part);
-		__invalidate_device(part, true);
+		bdev_mark_dead(part, false);
 	}
 	mutex_unlock(&disk->open_mutex);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 13a7341299a913..e137a87f4db0d3 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -281,10 +281,7 @@ static void delete_partition(struct block_device *part)
 	 * looked up any more even when openers still hold references.
 	 */
 	remove_inode_hash(part->bd_inode);
-
-	fsync_bdev(part);
-	__invalidate_device(part, true);
-
+	bdev_mark_dead(part, false);
 	drop_partition(part);
 }
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 675b38ad00dc9e..1f642be840c3ef 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3626,10 +3626,8 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 		 * so sync bdev first and then wait for our queues to become
 		 * empty
 		 */
-		if (device->block) {
-			fsync_bdev(device->block->bdev);
-			__invalidate_device(device->block->bdev, true);
-		}
+		if (device->block)
+			bdev_mark_dead(device->block->bdev, false);
 		dasd_schedule_device_bh(device);
 		rc = wait_event_interruptible(shutdown_waitq,
 					      _wait_for_empty_queues(device));
diff --git a/fs/super.c b/fs/super.c
index 71fe297a7e90a9..bbce0fdebf7e52 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1359,7 +1359,7 @@ int get_tree_bdev(struct fs_context *fc,
 		/*
 		 * We drop s_umount here because we need to open the bdev and
 		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
-		 * __invalidate_device()). It is safe because we have active sb
+		 * bdev_mark_dead()). It is safe because we have active sb
 		 * reference and SB_BORN is not set yet.
 		 */
 		up_write(&s->s_umount);
@@ -1411,7 +1411,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 		/*
 		 * We drop s_umount here because we need to open the bdev and
 		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
-		 * __invalidate_device()). It is safe because we have active sb
+		 * bdev_mark_dead()). It is safe because we have active sb
 		 * reference and SB_BORN is not set yet.
 		 */
 		up_write(&s->s_umount);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c8eab6effc2267..6721595b9f9741 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -751,6 +751,7 @@ static inline int bdev_read_only(struct block_device *bdev)
 
 bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
 void disk_force_media_change(struct gendisk *disk);
+void bdev_mark_dead(struct block_device *bdev, bool surprise);
 
 void add_disk_randomness(struct gendisk *disk) __latent_entropy;
 void rand_initialize_disk(struct gendisk *disk);
@@ -809,7 +810,6 @@ int __register_blkdev(unsigned int major, const char *name,
 void unregister_blkdev(unsigned int major, const char *name);
 
 bool disk_check_media_change(struct gendisk *disk);
-int __invalidate_device(struct block_device *bdev, bool kill_dirty);
 void set_capacity(struct gendisk *disk, sector_t size);
 
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
-- 
2.39.2


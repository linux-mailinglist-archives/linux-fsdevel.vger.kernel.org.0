Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80412C2733
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbgKXN2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387690AbgKXN2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41744C0617A6;
        Tue, 24 Nov 2020 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/wu2CSHeB3Gl/t7r+Aw3SS2grYZ13bhBv8r8IW86TqI=; b=Y1N/2HD33Uav08FYSVkGnaVSHI
        WPlSFEuXLyQhBcuSLeIqr73yqS6AW4O7CCXgYlwLqk7PRnfEAxOgc5ebT2zGe/Q4jDKj1TZml5KW6
        zxuduAnEcRYNXRLJfNfoVEqB7dvLowMzijO8QeIjl6QFuGAlKHuyv25WN4tJ8QUrAbMO9TBEVtuQZ
        BjmoIXu0ikoriwKuMSaI9W6uv3yCs3/9OxRgQnCKwZGoy0qYl1OR9rpx0/icb21Cc4JuTljr3xVK/
        lAjKL1pMZ8mwxFgvHH2tqEwyW4bK8qHE278Pz0q8BuTy3VF1zNvkF7La7YPUW8Bcc35jmJRRWkLo3
        3nOUSf4A==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYMS-0006UY-Of; Tue, 24 Nov 2020 13:28:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 04/45] fs: simplify freeze_bdev/thaw_bdev
Date:   Tue, 24 Nov 2020 14:27:10 +0100
Message-Id: <20201124132751.3747337-5-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Store the frozen superblock in struct block_device to avoid the awkward
interface that can return a sb only used a cookie, an ERR_PTR or NULL.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-core.h      |  5 -----
 drivers/md/dm.c           | 20 ++++++--------------
 fs/block_dev.c            | 39 ++++++++++++++++-----------------------
 fs/buffer.c               |  2 +-
 fs/ext4/ioctl.c           |  2 +-
 fs/f2fs/file.c            | 14 +++++---------
 fs/xfs/xfs_fsops.c        |  7 ++-----
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    |  4 ++--
 9 files changed, 34 insertions(+), 60 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index d522093cb39dda..aace147effcacb 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -96,11 +96,6 @@ struct mapped_device {
 	 */
 	struct workqueue_struct *wq;
 
-	/*
-	 * freeze/thaw support require holding onto a super block
-	 */
-	struct super_block *frozen_sb;
-
 	/* forced geometry settings */
 	struct hd_geometry geometry;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 54739f1b579bc8..50541d336c719b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2392,27 +2392,19 @@ static int lock_fs(struct mapped_device *md)
 {
 	int r;
 
-	WARN_ON(md->frozen_sb);
+	WARN_ON(test_bit(DMF_FROZEN, &md->flags));
 
-	md->frozen_sb = freeze_bdev(md->bdev);
-	if (IS_ERR(md->frozen_sb)) {
-		r = PTR_ERR(md->frozen_sb);
-		md->frozen_sb = NULL;
-		return r;
-	}
-
-	set_bit(DMF_FROZEN, &md->flags);
-
-	return 0;
+	r = freeze_bdev(md->bdev);
+	if (!r)
+		set_bit(DMF_FROZEN, &md->flags);
+	return r;
 }
 
 static void unlock_fs(struct mapped_device *md)
 {
 	if (!test_bit(DMF_FROZEN, &md->flags))
 		return;
-
-	thaw_bdev(md->bdev, md->frozen_sb);
-	md->frozen_sb = NULL;
+	thaw_bdev(md->bdev);
 	clear_bit(DMF_FROZEN, &md->flags);
 }
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index d8664f5c1ff669..60492620d51866 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -548,55 +548,47 @@ EXPORT_SYMBOL(fsync_bdev);
  * count down in thaw_bdev(). When it becomes 0, thaw_bdev() will unfreeze
  * actually.
  */
-struct super_block *freeze_bdev(struct block_device *bdev)
+int freeze_bdev(struct block_device *bdev)
 {
 	struct super_block *sb;
 	int error = 0;
 
 	mutex_lock(&bdev->bd_fsfreeze_mutex);
-	if (++bdev->bd_fsfreeze_count > 1) {
-		/*
-		 * We don't even need to grab a reference - the first call
-		 * to freeze_bdev grab an active reference and only the last
-		 * thaw_bdev drops it.
-		 */
-		sb = get_super(bdev);
-		if (sb)
-			drop_super(sb);
-		mutex_unlock(&bdev->bd_fsfreeze_mutex);
-		return sb;
-	}
+	if (++bdev->bd_fsfreeze_count > 1)
+		goto done;
 
 	sb = get_active_super(bdev);
 	if (!sb)
-		goto out;
+		goto sync;
 	if (sb->s_op->freeze_super)
 		error = sb->s_op->freeze_super(sb);
 	else
 		error = freeze_super(sb);
+	deactivate_super(sb);
+
 	if (error) {
-		deactivate_super(sb);
 		bdev->bd_fsfreeze_count--;
-		mutex_unlock(&bdev->bd_fsfreeze_mutex);
-		return ERR_PTR(error);
+		goto done;
 	}
-	deactivate_super(sb);
- out:
+	bdev->bd_fsfreeze_sb = sb;
+
+sync:
 	sync_blockdev(bdev);
+done:
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
-	return sb;	/* thaw_bdev releases s->s_umount */
+	return error;	/* thaw_bdev releases s->s_umount */
 }
 EXPORT_SYMBOL(freeze_bdev);
 
 /**
  * thaw_bdev  -- unlock filesystem
  * @bdev:	blockdevice to unlock
- * @sb:		associated superblock
  *
  * Unlocks the filesystem and marks it writeable again after freeze_bdev().
  */
-int thaw_bdev(struct block_device *bdev, struct super_block *sb)
+int thaw_bdev(struct block_device *bdev)
 {
+	struct super_block *sb;
 	int error = -EINVAL;
 
 	mutex_lock(&bdev->bd_fsfreeze_mutex);
@@ -607,6 +599,7 @@ int thaw_bdev(struct block_device *bdev, struct super_block *sb)
 	if (--bdev->bd_fsfreeze_count > 0)
 		goto out;
 
+	sb = bdev->bd_fsfreeze_sb;
 	if (!sb)
 		goto out;
 
@@ -618,7 +611,7 @@ int thaw_bdev(struct block_device *bdev, struct super_block *sb)
 		bdev->bd_fsfreeze_count++;
 out:
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
-	return error;
+	return 0;
 }
 EXPORT_SYMBOL(thaw_bdev);
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 23f645657488ba..a7595ada9400ff 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -523,7 +523,7 @@ static int osync_buffers_list(spinlock_t *lock, struct list_head *list)
 
 void emergency_thaw_bdev(struct super_block *sb)
 {
-	while (sb->s_bdev && !thaw_bdev(sb->s_bdev, sb))
+	while (sb->s_bdev && !thaw_bdev(sb->s_bdev))
 		printk(KERN_WARNING "Emergency Thaw on %pg\n", sb->s_bdev);
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f0381876a7e5b0..524e134324475e 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -624,7 +624,7 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 	case EXT4_GOING_FLAGS_DEFAULT:
 		freeze_bdev(sb->s_bdev);
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
-		thaw_bdev(sb->s_bdev, sb);
+		thaw_bdev(sb->s_bdev);
 		break;
 	case EXT4_GOING_FLAGS_LOGFLUSH:
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ee861c6d9ff026..a9fc482a0e60a5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2230,16 +2230,12 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	switch (in) {
 	case F2FS_GOING_DOWN_FULLSYNC:
-		sb = freeze_bdev(sb->s_bdev);
-		if (IS_ERR(sb)) {
-			ret = PTR_ERR(sb);
+		ret = freeze_bdev(sb->s_bdev);
+		if (ret)
 			goto out;
-		}
-		if (sb) {
-			f2fs_stop_checkpoint(sbi, false);
-			set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
-			thaw_bdev(sb->s_bdev, sb);
-		}
+		f2fs_stop_checkpoint(sbi, false);
+		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
+		thaw_bdev(sb->s_bdev);
 		break;
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index ef1d5bb88b93ab..b7c5783a031c69 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -433,13 +433,10 @@ xfs_fs_goingdown(
 {
 	switch (inflags) {
 	case XFS_FSOP_GOING_FLAGS_DEFAULT: {
-		struct super_block *sb = freeze_bdev(mp->m_super->s_bdev);
-
-		if (sb && !IS_ERR(sb)) {
+		if (!freeze_bdev(mp->m_super->s_bdev)) {
 			xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
-			thaw_bdev(sb->s_bdev, sb);
+			thaw_bdev(mp->m_super->s_bdev);
 		}
-
 		break;
 	}
 	case XFS_FSOP_GOING_FLAGS_LOGFLUSH:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d9b69bbde5cc54..ebfb4e7c1fd125 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -46,6 +46,7 @@ struct block_device {
 	int			bd_fsfreeze_count;
 	/* Mutex for freeze */
 	struct mutex		bd_fsfreeze_mutex;
+	struct super_block	*bd_fsfreeze_sb;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05b346a68c2eee..12810a19edebc4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2020,7 +2020,7 @@ static inline int sync_blockdev(struct block_device *bdev)
 #endif
 int fsync_bdev(struct block_device *bdev);
 
-struct super_block *freeze_bdev(struct block_device *bdev);
-int thaw_bdev(struct block_device *bdev, struct super_block *sb);
+int freeze_bdev(struct block_device *bdev);
+int thaw_bdev(struct block_device *bdev);
 
 #endif /* _LINUX_BLKDEV_H */
-- 
2.29.2


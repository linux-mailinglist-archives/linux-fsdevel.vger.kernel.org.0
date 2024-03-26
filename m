Return-Path: <linux-fsdevel+bounces-15321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351DA88C291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66301F3E9FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A56EB4E;
	Tue, 26 Mar 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYEVzhZ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664975C8EE;
	Tue, 26 Mar 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457411; cv=none; b=i2WMSt6RXMSgKhHgfS+lTp+JINsoF9Ej7TFvDVS6xS3FlIciEvOl1fsZM4unjKzUFEW0dW8KFzaujBvbLYZcHbvHH6sgLIf5fvj3AyjKHsUm0C0iWWOQ5KLpPBpIcjAtTwzqmW5JP1eCYhNl362WEn2g9JGlKmPGv2LHaPjjn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457411; c=relaxed/simple;
	bh=frHFooI/Li/Rd2bWfenvxO8uaYNOMlR/rBbZ8mTpVZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ne4u54GSnznCTSfjnDthSy2kCWRYpjFOPmUMNcdU8ss6T6Aq62x+I9mK0HwzkL049ReHt1NSTcE5Ncc9lNEhhEr3vIIybhV/gM7qMFD1vjxR0LRAd3wrm/by7FBkupo/3zt09OuBNkyxT5JXpuNUH+pZQVxlOygkl+e28LNxAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYEVzhZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61395C433C7;
	Tue, 26 Mar 2024 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711457410;
	bh=frHFooI/Li/Rd2bWfenvxO8uaYNOMlR/rBbZ8mTpVZo=;
	h=From:Date:Subject:To:Cc:From;
	b=YYEVzhZ052cZJ35C9yCJ+EEIdRGpDGf30DJRF44FDLVTzpm+lgGbVmA7zMUe7i1uO
	 ktOVu3RBT+pSQ0PokZGWMqmVaAwNMHfw+/r9Ekk5jP0ljNDhIBZMX+fJbDS5HVzSgE
	 qUpolANnd+rccwjbzt7sObHdA4HZt9IMokb3uflv++xxMlUywpWdNTK34k+zIRRPQw
	 TbOGKYbhf7Sq1IKA/GSYk1euWmlrY29qttURylqMtKYCV4Q2TlXJ97nYVsZ6f/QTBW
	 GfhMGGNTxfjgqLfXWnERKB7R+rKyT4Z1QXHjJypruLrPt1xtHl3PqBeJCZ3K+p0Zp1
	 uXtQ6bvFVyRrg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 26 Mar 2024 13:47:22 +0100
Subject: [PATCH] fs,block: yield devices early
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-vfs-bdev-end_holder-v1-1-20af85202918@kernel.org>
X-B4-Tracking: v=1; b=H4sIANnDAmYC/x3MTQqDMBBA4avIrDsSU4nYqxQp+RmbATuWCYSCe
 PemXX6L9w4opEwFbt0BSpUL79IwXDqI2cuTkFMzWGNHc7UO61owJKpIkh553xIpTsal2U2ztWO
 EVr6VVv78r/elOfhCGNRLzL/Xy7NsLNRX18+ocYDz/AKr4zc6iQAAAA==
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=11708; i=brauner@kernel.org;
 h=from:subject:message-id; bh=frHFooI/Li/Rd2bWfenvxO8uaYNOMlR/rBbZ8mTpVZo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQxHWlwuvnMZ1ll5dnFny0XHI6MkGvQ7Aqscm5cUyqc/
 J2bcfXjjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm07mL4Kz9zXvijWeJv5dbl
 aqrfPPK45l8Jh1TVu7U1DnpCHq33rjAy9D++JXPnl51A4ekV8nvW5e5kC/xpcFFxVZaeVs8KpgQ
 HZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently a device is only really released once the umount returns to
userspace due to how file closing works. That ultimately could cause
an old umount assumption to be violated that concurrent umount and mount
don't fail. So an exclusively held device with a temporary holder should
be yielded before the filesystem is gone. Add a helper that allows
callers to do that. This also allows us to remove the two holder ops
that Linus wasn't excited about.

Fixes: f3a608827d1f ("bdev: open block device as files") # mainline only
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 62 ++++++++++++++++++++++++++++++++++++++++++--------
 fs/bcachefs/super-io.c |  2 +-
 fs/cramfs/inode.c      |  2 +-
 fs/ext4/super.c        |  8 +++----
 fs/f2fs/super.c        |  2 +-
 fs/jfs/jfs_logmgr.c    |  4 ++--
 fs/reiserfs/journal.c  |  2 +-
 fs/romfs/super.c       |  2 +-
 fs/super.c             | 24 +++----------------
 fs/xfs/xfs_buf.c       |  2 +-
 fs/xfs/xfs_super.c     |  6 ++---
 include/linux/blkdev.h | 11 +--------
 12 files changed, 71 insertions(+), 56 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e..070890667563 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -583,9 +583,6 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder,
 	mutex_unlock(&bdev->bd_holder_lock);
 	bd_clear_claiming(whole, holder);
 	mutex_unlock(&bdev_lock);
-
-	if (hops && hops->get_holder)
-		hops->get_holder(holder);
 }
 
 /**
@@ -608,7 +605,6 @@ EXPORT_SYMBOL(bd_abort_claiming);
 static void bd_end_claim(struct block_device *bdev, void *holder)
 {
 	struct block_device *whole = bdev_whole(bdev);
-	const struct blk_holder_ops *hops = bdev->bd_holder_ops;
 	bool unblock = false;
 
 	/*
@@ -631,9 +627,6 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		whole->bd_holder = NULL;
 	mutex_unlock(&bdev_lock);
 
-	if (hops && hops->put_holder)
-		hops->put_holder(holder);
-
 	/*
 	 * If this was the last claim, remove holder link and unblock evpoll if
 	 * it was a write holder.
@@ -1012,6 +1005,29 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(bdev_file_open_by_path);
 
+static inline void bd_yield_claim(struct file *bdev_file)
+{
+	struct block_device *bdev = file_bdev(bdev_file);
+	struct bdev_inode *bd_inode = BDEV_I(bdev_file->f_mapping->host);
+	void *holder = bdev_file->private_data;
+
+	lockdep_assert_held(&bdev->bd_disk->open_mutex);
+
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(holder)))
+		return;
+
+	if (holder != bd_inode) {
+		bdev_yield_write_access(bdev_file);
+		bd_end_claim(bdev, holder);
+		/*
+		 * Tell release we already gave up our hold on the
+		 * device and if write restrictions are available that
+		 * we already gave up write access to the device.
+		 */
+		bdev_file->private_data = bd_inode;
+	}
+}
+
 void bdev_release(struct file *bdev_file)
 {
 	struct block_device *bdev = file_bdev(bdev_file);
@@ -1033,10 +1049,10 @@ void bdev_release(struct file *bdev_file)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
-	bdev_yield_write_access(bdev_file);
-
 	if (holder)
-		bd_end_claim(bdev, holder);
+		bd_yield_claim(bdev_file);
+	else
+		bdev_yield_write_access(bdev_file);
 
 	/*
 	 * Trigger event checking and tell drivers to flush MEDIA_CHANGE
@@ -1056,6 +1072,32 @@ void bdev_release(struct file *bdev_file)
 	blkdev_put_no_open(bdev);
 }
 
+/**
+ * bdev_fput - yield claim to the block device and put the file
+ * @bdev_file: open block device
+ *
+ * Yield claim on the block device and put the file. Ensure that the
+ * block device can be reclaimed before the file is closed which is a
+ * deferred operation.
+ */
+void bdev_fput(struct file *bdev_file)
+{
+	if (WARN_ON_ONCE(bdev_file->f_op != &def_blk_fops))
+		return;
+
+	if (bdev_file->private_data) {
+		struct block_device *bdev = file_bdev(bdev_file);
+		struct gendisk *disk = bdev->bd_disk;
+
+		mutex_lock(&disk->open_mutex);
+		bd_yield_claim(bdev_file);
+		mutex_unlock(&disk->open_mutex);
+	}
+
+	fput(bdev_file);
+}
+EXPORT_SYMBOL(bdev_fput);
+
 /**
  * lookup_bdev() - Look up a struct block_device by name.
  * @pathname: Name of the block device in the filesystem.
diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index ad28e370b640..cb7b4de11a49 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -143,7 +143,7 @@ void bch2_free_super(struct bch_sb_handle *sb)
 {
 	kfree(sb->bio);
 	if (!IS_ERR_OR_NULL(sb->s_bdev_file))
-		fput(sb->s_bdev_file);
+		bdev_fput(sb->s_bdev_file);
 	kfree(sb->holder);
 	kfree(sb->sb_name);
 
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 39e75131fd5a..9901057a15ba 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -495,7 +495,7 @@ static void cramfs_kill_sb(struct super_block *sb)
 		sb->s_mtd = NULL;
 	} else if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV) && sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		fput(sb->s_bdev_file);
+		bdev_fput(sb->s_bdev_file);
 	}
 	kfree(sbi);
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cfb8449c731f..044135796f2b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5668,7 +5668,7 @@ failed_mount9: __maybe_unused
 	brelse(sbi->s_sbh);
 	if (sbi->s_journal_bdev_file) {
 		invalidate_bdev(file_bdev(sbi->s_journal_bdev_file));
-		fput(sbi->s_journal_bdev_file);
+		bdev_fput(sbi->s_journal_bdev_file);
 	}
 out_fail:
 	invalidate_bdev(sb->s_bdev);
@@ -5913,7 +5913,7 @@ static struct file *ext4_get_journal_blkdev(struct super_block *sb,
 out_bh:
 	brelse(bh);
 out_bdev:
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 	return ERR_PTR(errno);
 }
 
@@ -5952,7 +5952,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 out_journal:
 	jbd2_journal_destroy(journal);
 out_bdev:
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 	return ERR_PTR(errno);
 }
 
@@ -7327,7 +7327,7 @@ static void ext4_kill_sb(struct super_block *sb)
 	kill_block_super(sb);
 
 	if (bdev_file)
-		fput(bdev_file);
+		bdev_fput(bdev_file);
 }
 
 static struct file_system_type ext4_fs_type = {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a6867f26f141..a4bc26dfdb1a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1558,7 +1558,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
 		if (i > 0)
-			fput(FDEV(i).bdev_file);
+			bdev_fput(FDEV(i).bdev_file);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 73389c68e251..9609349e92e5 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1141,7 +1141,7 @@ int lmLogOpen(struct super_block *sb)
 	lbmLogShutdown(log);
 
       close:		/* close external log device */
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 
       free:		/* free log descriptor */
 	mutex_unlock(&jfs_log_mutex);
@@ -1485,7 +1485,7 @@ int lmLogClose(struct super_block *sb)
 	bdev_file = log->bdev_file;
 	rc = lmLogShutdown(log);
 
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 
 	kfree(log);
 
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 6474529c4253..e539ccd39e1e 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2589,7 +2589,7 @@ static void journal_list_init(struct super_block *sb)
 static void release_journal_dev(struct reiserfs_journal *journal)
 {
 	if (journal->j_bdev_file) {
-		fput(journal->j_bdev_file);
+		bdev_fput(journal->j_bdev_file);
 		journal->j_bdev_file = NULL;
 	}
 }
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 2be227532f39..2cbb92462074 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -594,7 +594,7 @@ static void romfs_kill_sb(struct super_block *sb)
 #ifdef CONFIG_ROMFS_ON_BLOCK
 	if (sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		fput(sb->s_bdev_file);
+		bdev_fput(sb->s_bdev_file);
 	}
 #endif
 }
diff --git a/fs/super.c b/fs/super.c
index 71d9779c42b1..69ce6c600968 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1515,29 +1515,11 @@ static int fs_bdev_thaw(struct block_device *bdev)
 	return error;
 }
 
-static void fs_bdev_super_get(void *data)
-{
-	struct super_block *sb = data;
-
-	spin_lock(&sb_lock);
-	sb->s_count++;
-	spin_unlock(&sb_lock);
-}
-
-static void fs_bdev_super_put(void *data)
-{
-	struct super_block *sb = data;
-
-	put_super(sb);
-}
-
 const struct blk_holder_ops fs_holder_ops = {
 	.mark_dead		= fs_bdev_mark_dead,
 	.sync			= fs_bdev_sync,
 	.freeze			= fs_bdev_freeze,
 	.thaw			= fs_bdev_thaw,
-	.get_holder		= fs_bdev_super_get,
-	.put_holder		= fs_bdev_super_put,
 };
 EXPORT_SYMBOL_GPL(fs_holder_ops);
 
@@ -1562,7 +1544,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	 * writable from userspace even for a read-only block device.
 	 */
 	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
-		fput(bdev_file);
+		bdev_fput(bdev_file);
 		return -EACCES;
 	}
 
@@ -1573,7 +1555,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	if (atomic_read(&bdev->bd_fsfreeze_count) > 0) {
 		if (fc)
 			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		fput(bdev_file);
+		bdev_fput(bdev_file);
 		return -EBUSY;
 	}
 	spin_lock(&sb_lock);
@@ -1693,7 +1675,7 @@ void kill_block_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
-		fput(sb->s_bdev_file);
+		bdev_fput(sb->s_bdev_file);
 	}
 }
 
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 1a18c381127e..f0fa02264eda 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2030,7 +2030,7 @@ xfs_free_buftarg(
 	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
 	/* the main block device is closed by kill_block_super */
 	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
-		fput(btp->bt_bdev_file);
+		bdev_fput(btp->bt_bdev_file);
 	kfree(btp);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index c21f10ab0f5d..bce020374c5e 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -485,7 +485,7 @@ xfs_open_devices(
 		mp->m_logdev_targp = mp->m_ddev_targp;
 		/* Handle won't be used, drop it */
 		if (logdev_file)
-			fput(logdev_file);
+			bdev_fput(logdev_file);
 	}
 
 	return 0;
@@ -497,10 +497,10 @@ xfs_open_devices(
 	xfs_free_buftarg(mp->m_ddev_targp);
  out_close_rtdev:
 	 if (rtdev_file)
-		fput(rtdev_file);
+		bdev_fput(rtdev_file);
  out_close_logdev:
 	if (logdev_file)
-		fput(logdev_file);
+		bdev_fput(logdev_file);
 	return error;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be..172c91879999 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1505,16 +1505,6 @@ struct blk_holder_ops {
 	 * Thaw the file system mounted on the block device.
 	 */
 	int (*thaw)(struct block_device *bdev);
-
-	/*
-	 * If needed, get a reference to the holder.
-	 */
-	void (*get_holder)(void *holder);
-
-	/*
-	 * Release the holder.
-	 */
-	void (*put_holder)(void *holder);
 };
 
 /*
@@ -1585,6 +1575,7 @@ static inline int early_lookup_bdev(const char *pathname, dev_t *dev)
 
 int bdev_freeze(struct block_device *bdev);
 int bdev_thaw(struct block_device *bdev);
+void bdev_fput(struct file *bdev_file);
 
 struct io_comp_batch {
 	struct request *req_list;

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240326-vfs-bdev-end_holder-706d9679224c



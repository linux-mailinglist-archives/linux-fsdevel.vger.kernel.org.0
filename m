Return-Path: <linux-fsdevel+bounces-1029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053847D50F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81743B20F62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E65D29414;
	Tue, 24 Oct 2023 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJEVdqSq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE22940B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E009C433CA;
	Tue, 24 Oct 2023 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698152774;
	bh=EwFj3PRIGaPqamDxqJaccMckl8OKeAeT8WVjpWKp7zU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CJEVdqSq2Cg/5JBWv7i2SoGmMeNkh9tlXAXiM4We2r7t+GZB8ysnQGZL4kIvBWGF3
	 r0osNGMQuSvQ9NF9m8mw7xe71bKX5yXleV79a8g4iVl9+8gXcowVQaLs+uhbu1PtR3
	 rmqB8m6q6nf5H9C/MTupsu0PL5b5aMqH2n1JlG3m3ikJ9hxnXtNEwr4SH+6x7ez7QE
	 BlL2uXfYCeVkU3D3W5E2tXQBoypzKdCLG6z9irhQUiHbdqDcy11ihk33sbjRYtUjO6
	 /WoTIiBefTuiCMTwQIJh8PVTufnVkgB5QDSRhobSFow/kYRbfMkHIRaraDXdnTq5ZP
	 KMrFIgefMHZww==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 15:01:08 +0200
Subject: [PATCH v2 02/10] bdev: rename freeze and thaw helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-freeze-v2-2-599c19f4faac@kernel.org>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6803; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EwFj3PRIGaPqamDxqJaccMckl8OKeAeT8WVjpWKp7zU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSaH3TImze/93KOj28iS+70qNVzfye7rbI3qV/CK3/zyUaW
 2QZfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiVczIcKozIuSEbUrjQ+uuXz2fmf
 U6ZS8z8084qfjEu6/31XtdIYb/Sfa5QpM+HStneceRHrn0bHIkE8PHjswpgdOdcqZ4rPzMAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We have bdev_mark_dead() etc and we're going to move block device
freezing to holder ops in the next patch. Make the naming consistent:

* freeze_bdev() -> bdev_freeze()
* thaw_bdev()   -> bdev_thaw()

Also document the return code.

Link: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-1-ecc36d9ab4d9@kernel.org
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 22 +++++++++++++---------
 drivers/md/dm.c        |  4 ++--
 fs/ext4/ioctl.c        |  4 ++--
 fs/f2fs/file.c         |  4 ++--
 fs/super.c             |  4 ++--
 fs/xfs/xfs_fsops.c     |  4 ++--
 include/linux/blkdev.h |  4 ++--
 7 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 2018d250e131..d674ad381c52 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -207,18 +207,20 @@ int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend)
 EXPORT_SYMBOL(sync_blockdev_range);
 
 /**
- * freeze_bdev - lock a filesystem and force it into a consistent state
+ * bdev_freeze - lock a filesystem and force it into a consistent state
  * @bdev:	blockdevice to lock
  *
  * If a superblock is found on this device, we take the s_umount semaphore
  * on it to make sure nobody unmounts until the snapshot creation is done.
  * The reference counter (bd_fsfreeze_count) guarantees that only the last
  * unfreeze process can unfreeze the frozen filesystem actually when multiple
- * freeze requests arrive simultaneously. It counts up in freeze_bdev() and
- * count down in thaw_bdev(). When it becomes 0, thaw_bdev() will unfreeze
+ * freeze requests arrive simultaneously. It counts up in bdev_freeze() and
+ * count down in bdev_thaw(). When it becomes 0, thaw_bdev() will unfreeze
  * actually.
+ *
+ * Return: On success zero is returned, negative error code on failure.
  */
-int freeze_bdev(struct block_device *bdev)
+int bdev_freeze(struct block_device *bdev)
 {
 	struct super_block *sb;
 	int error = 0;
@@ -248,15 +250,17 @@ int freeze_bdev(struct block_device *bdev)
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	return error;
 }
-EXPORT_SYMBOL(freeze_bdev);
+EXPORT_SYMBOL(bdev_freeze);
 
 /**
- * thaw_bdev - unlock filesystem
+ * bdev_thaw - unlock filesystem
  * @bdev:	blockdevice to unlock
  *
- * Unlocks the filesystem and marks it writeable again after freeze_bdev().
+ * Unlocks the filesystem and marks it writeable again after bdev_freeze().
+ *
+ * Return: On success zero is returned, negative error code on failure.
  */
-int thaw_bdev(struct block_device *bdev)
+int bdev_thaw(struct block_device *bdev)
 {
 	struct super_block *sb;
 	int error = -EINVAL;
@@ -285,7 +289,7 @@ int thaw_bdev(struct block_device *bdev)
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	return error;
 }
-EXPORT_SYMBOL(thaw_bdev);
+EXPORT_SYMBOL(bdev_thaw);
 
 /*
  * pseudo-fs
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f7212e8fc27f..c14dc6db0810 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2650,7 +2650,7 @@ static int lock_fs(struct mapped_device *md)
 
 	WARN_ON(test_bit(DMF_FROZEN, &md->flags));
 
-	r = freeze_bdev(md->disk->part0);
+	r = bdev_freeze(md->disk->part0);
 	if (!r)
 		set_bit(DMF_FROZEN, &md->flags);
 	return r;
@@ -2660,7 +2660,7 @@ static void unlock_fs(struct mapped_device *md)
 {
 	if (!test_bit(DMF_FROZEN, &md->flags))
 		return;
-	thaw_bdev(md->disk->part0);
+	bdev_thaw(md->disk->part0);
 	clear_bit(DMF_FROZEN, &md->flags);
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0bfe2ce589e2..c1390219c945 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -810,11 +810,11 @@ int ext4_force_shutdown(struct super_block *sb, u32 flags)
 
 	switch (flags) {
 	case EXT4_GOING_FLAGS_DEFAULT:
-		ret = freeze_bdev(sb->s_bdev);
+		ret = bdev_freeze(sb->s_bdev);
 		if (ret)
 			return ret;
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
-		thaw_bdev(sb->s_bdev);
+		bdev_thaw(sb->s_bdev);
 		break;
 	case EXT4_GOING_FLAGS_LOGFLUSH:
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca5904129b16..c22aeb9ffb61 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2239,11 +2239,11 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	switch (in) {
 	case F2FS_GOING_DOWN_FULLSYNC:
-		ret = freeze_bdev(sb->s_bdev);
+		ret = bdev_freeze(sb->s_bdev);
 		if (ret)
 			goto out;
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
-		thaw_bdev(sb->s_bdev);
+		bdev_thaw(sb->s_bdev);
 		break;
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
diff --git a/fs/super.c b/fs/super.c
index 9cf3ee50cecd..b224182f2440 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1221,7 +1221,7 @@ static void do_thaw_all_callback(struct super_block *sb)
 
 	if (locked && sb->s_root) {
 		if (IS_ENABLED(CONFIG_BLOCK))
-			while (sb->s_bdev && !thaw_bdev(sb->s_bdev))
+			while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
 				pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
 		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
 		return;
@@ -1529,7 +1529,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	/*
 	 * Until SB_BORN flag is set, there can be no active superblock
 	 * references and thus no filesystem freezing. get_active_super() will
-	 * just loop waiting for SB_BORN so even freeze_bdev() cannot proceed.
+	 * just loop waiting for SB_BORN so even bdev_freeze() cannot proceed.
 	 *
 	 * It is enough to check bdev was not frozen before we set s_bdev.
 	 */
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 7cb75cb6b8e9..57076a25f17d 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -482,9 +482,9 @@ xfs_fs_goingdown(
 {
 	switch (inflags) {
 	case XFS_FSOP_GOING_FLAGS_DEFAULT: {
-		if (!freeze_bdev(mp->m_super->s_bdev)) {
+		if (!bdev_freeze(mp->m_super->s_bdev)) {
 			xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
-			thaw_bdev(mp->m_super->s_bdev);
+			bdev_thaw(mp->m_super->s_bdev);
 		}
 		break;
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83..7a3da7f44afb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1541,8 +1541,8 @@ static inline int early_lookup_bdev(const char *pathname, dev_t *dev)
 }
 #endif /* CONFIG_BLOCK */
 
-int freeze_bdev(struct block_device *bdev);
-int thaw_bdev(struct block_device *bdev);
+int bdev_freeze(struct block_device *bdev);
+int bdev_thaw(struct block_device *bdev);
 
 struct io_comp_batch {
 	struct request *req_list;

-- 
2.34.1



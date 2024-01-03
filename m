Return-Path: <linux-fsdevel+bounces-7182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3DB822D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CDF1F21700
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9DC1947A;
	Wed,  3 Jan 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlB+lqRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BE1946B;
	Wed,  3 Jan 2024 12:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA75BC433C9;
	Wed,  3 Jan 2024 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286530;
	bh=PUDxaO+PBRRStY0joJC5Nk+ZL+hdUQrEKGcabVfxCDs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hlB+lqRU4zZv5TFnrUWjrSqeS120nm/AIQTjOLLnN/iqJySyeW+/eedRL3fDLl1nW
	 W72ah8UWmDd+dbWWR4SophdzCztnutcEzJRX202SqMcpcjhcf0xWf3Z/lGKUSy+A+q
	 bEbzFQm2HdQbPihl+8+H404qbEtG+2kCqNMOdWTMlmLYcXJ1z/8kiff/EImJsWeBti
	 pCNkjjO21jm2BOtvwAaDfoJK+aRPO7+KjDo3vaTXglQ2z/MvrZb1GJJnA6xG0/EscP
	 YRG9gfRlbLMuK8VmyyugabyS/cvBYT4mdVLCcm9iEevQN8xXbKMkKsqJ4qEBXMgVE4
	 GqoXdWS/AA85w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:54:59 +0100
Subject: [PATCH RFC 01/34] bdev: open block device as files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-1-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=11083; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PUDxaO+PBRRStY0joJC5Nk+ZL+hdUQrEKGcabVfxCDs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbS+E/WnjW0X31XvJbt0FpqocqybPj3rrwrz9UTZ9
 GtC29JlOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS8JThv6vRIwUxi0cKc1i8
 FZh6p0YfTbH40i54YV8TE3/rj7j/NxgZ7t24kc7+Jdhz8R9dDtUL0y/dCH6h3/WyvfPDKjvX42J
 rGAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 104 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/cramfs/inode.c      |   2 +-
 fs/f2fs/super.c        |   2 +-
 fs/jfs/jfs_logmgr.c    |   2 +-
 fs/romfs/super.c       |   2 +-
 fs/super.c             |  18 ++++-----
 fs/xfs/xfs_super.c     |   2 +-
 include/linux/blkdev.h |   6 +++
 include/linux/fs.h     |  10 ++++-
 9 files changed, 128 insertions(+), 20 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index e9f1b12bd75c..853731fb41ed 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -49,6 +49,15 @@ struct block_device *I_BDEV(struct inode *inode)
 }
 EXPORT_SYMBOL(I_BDEV);
 
+/* @bdev_handle will become private to block/blk.h soon. */
+struct block_device *F_BDEV(struct file *f_bdev)
+{
+	struct bdev_handle *handle = f_bdev->private_data;
+	WARN_ON(f_bdev->f_op != &def_blk_fops);
+	return handle->bdev;
+}
+EXPORT_SYMBOL(F_BDEV);
+
 static void bdev_write_inode(struct block_device *bdev)
 {
 	struct inode *inode = bdev->bd_inode;
@@ -368,12 +377,12 @@ static struct file_system_type bd_type = {
 };
 
 struct super_block *blockdev_superblock __ro_after_init;
+struct vfsmount *blockdev_mnt __ro_after_init;
 EXPORT_SYMBOL_GPL(blockdev_superblock);
 
 void __init bdev_cache_init(void)
 {
 	int err;
-	static struct vfsmount *bd_mnt __ro_after_init;
 
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
 			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
@@ -382,10 +391,10 @@ void __init bdev_cache_init(void)
 	err = register_filesystem(&bd_type);
 	if (err)
 		panic("Cannot register bdev pseudo-fs");
-	bd_mnt = kern_mount(&bd_type);
-	if (IS_ERR(bd_mnt))
+	blockdev_mnt = kern_mount(&bd_type);
+	if (IS_ERR(blockdev_mnt))
 		panic("Cannot create bdev pseudo-fs");
-	blockdev_superblock = bd_mnt->mnt_sb;   /* For writeback */
+	blockdev_superblock = blockdev_mnt->mnt_sb;   /* For writeback */
 }
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
@@ -911,6 +920,93 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 }
 EXPORT_SYMBOL(bdev_open_by_dev);
 
+static unsigned blk_to_file_flags(blk_mode_t mode)
+{
+	unsigned int flags = 0;
+
+	if ((mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) ==
+	    (BLK_OPEN_READ | BLK_OPEN_WRITE))
+		flags |= O_RDWR;
+	else if (mode & BLK_OPEN_WRITE)
+		flags |= O_WRONLY;
+	else
+		flags |= O_RDONLY;
+
+	/*
+	 * O_EXCL is one of those flags that the VFS clears once it's done with
+	 * the operation. So don't raise it here either.
+	 */
+	if (mode & BLK_OPEN_NDELAY)
+		flags |= O_NDELAY;
+
+	/*
+	 * If BLK_OPEN_WRITE_IOCTL is set then this is a historical quirk
+	 * associated with the floppy driver where it has allowed ioctls if the
+	 * file was opened for writing, but does not allow reads or writes.
+	 * Make sure that this quirk is reflected in @f_flags.
+	 */
+	if (mode & BLK_OPEN_WRITE_IOCTL)
+		flags |= O_RDWR | O_WRONLY;
+
+	return flags;
+}
+
+struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+				   const struct blk_holder_ops *hops)
+{
+	struct file *file;
+	struct bdev_handle *handle;
+	unsigned int flags;
+
+	handle = bdev_open_by_dev(dev, mode, holder, hops);
+	if (IS_ERR(handle))
+		return ERR_CAST(handle);
+
+	flags = blk_to_file_flags(mode);
+	file = alloc_file_pseudo(handle->bdev->bd_inode, blockdev_mnt, "",
+				 flags | O_LARGEFILE, &def_blk_fops);
+	if (IS_ERR(file)) {
+		bdev_release(handle);
+		return file;
+	}
+	ihold(handle->bdev->bd_inode);
+
+	file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT | FMODE_NOACCOUNT;
+	if (bdev_nowait(handle->bdev))
+		file->f_mode |= FMODE_NOWAIT;
+
+	file->f_mapping = handle->bdev->bd_inode->i_mapping;
+	file->f_wb_err = filemap_sample_wb_err(file->f_mapping);
+	file->private_data = handle;
+	return file;
+}
+EXPORT_SYMBOL(bdev_file_open_by_dev);
+
+struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
+				    void *holder,
+				    const struct blk_holder_ops *hops)
+{
+	struct file *file;
+	dev_t dev;
+	int error;
+
+	error = lookup_bdev(path, &dev);
+	if (error)
+		return ERR_PTR(error);
+
+	file = bdev_file_open_by_dev(dev, mode, holder, hops);
+	if (!IS_ERR(file) && (mode & BLK_OPEN_WRITE)) {
+		struct bdev_handle *handle = file->private_data;
+		if (bdev_read_only(handle->bdev)) {
+			fput(file);
+			file = ERR_PTR(-EACCES);
+		}
+	}
+
+	return file;
+}
+EXPORT_SYMBOL(bdev_file_open_by_path);
+
 /**
  * bdev_open_by_path - open a block device by name
  * @path: path to the block device to open
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 60dbfa0f8805..14d1758daa52 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -495,7 +495,7 @@ static void cramfs_kill_sb(struct super_block *sb)
 		sb->s_mtd = NULL;
 	} else if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV) && sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		bdev_release(sb->s_bdev_handle);
+		fput(sb->s_f_bdev);
 	}
 	kfree(sbi);
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..93b8a844b207 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4247,7 +4247,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < max_devices; i++) {
 		if (i == 0)
-			FDEV(0).bdev_handle = sbi->sb->s_bdev_handle;
+			FDEV(0).bdev_handle = sb_bdev_handle(sbi->sb);
 		else if (!RDEV(i).path[0])
 			break;
 
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index cb6d1fda66a7..8691463956d1 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1162,7 +1162,7 @@ static int open_inline_log(struct super_block *sb)
 	init_waitqueue_head(&log->syncwait);
 
 	set_bit(log_INLINELOG, &log->flag);
-	log->bdev_handle = sb->s_bdev_handle;
+	log->bdev_handle = sb_bdev_handle(sb);
 	log->base = addressPXD(&JFS_SBI(sb)->logpxd);
 	log->size = lengthPXD(&JFS_SBI(sb)->logpxd) >>
 	    (L2LOGPSIZE - sb->s_blocksize_bits);
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 545ad44f96b8..b392ae877ac7 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -594,7 +594,7 @@ static void romfs_kill_sb(struct super_block *sb)
 #ifdef CONFIG_ROMFS_ON_BLOCK
 	if (sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		bdev_release(sb->s_bdev_handle);
+		fput(sb->s_f_bdev);
 	}
 #endif
 }
diff --git a/fs/super.c b/fs/super.c
index e35936000408..77cc67b8bf44 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1532,16 +1532,16 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
 {
 	blk_mode_t mode = sb_open_mode(sb_flags);
-	struct bdev_handle *bdev_handle;
+	struct file *file;
 	struct block_device *bdev;
 
-	bdev_handle = bdev_open_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
-	if (IS_ERR(bdev_handle)) {
+	file = bdev_file_open_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
+	if (IS_ERR(file)) {
 		if (fc)
 			errorf(fc, "%s: Can't open blockdev", fc->source);
-		return PTR_ERR(bdev_handle);
+		return PTR_ERR(file);
 	}
-	bdev = bdev_handle->bdev;
+	bdev = F_BDEV(file);
 
 	/*
 	 * This really should be in blkdev_get_by_dev, but right now can't due
@@ -1549,7 +1549,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	 * writable from userspace even for a read-only block device.
 	 */
 	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
-		bdev_release(bdev_handle);
+		fput(file);
 		return -EACCES;
 	}
 
@@ -1560,11 +1560,11 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	if (atomic_read(&bdev->bd_fsfreeze_count) > 0) {
 		if (fc)
 			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		bdev_release(bdev_handle);
+		fput(file);
 		return -EBUSY;
 	}
 	spin_lock(&sb_lock);
-	sb->s_bdev_handle = bdev_handle;
+	sb->s_f_bdev = file;
 	sb->s_bdev = bdev;
 	sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
 	if (bdev_stable_writes(bdev))
@@ -1680,7 +1680,7 @@ void kill_block_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
-		bdev_release(sb->s_bdev_handle);
+		fput(sb->s_f_bdev);
 	}
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 07857d967ee8..0e64220bffdc 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -467,7 +467,7 @@ xfs_open_devices(
 	 * Setup xfs_mount buffer target pointers
 	 */
 	error = -ENOMEM;
-	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb->s_bdev_handle);
+	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb_bdev_handle(sb));
 	if (!mp->m_ddev_targp)
 		goto out_close_rtdev;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9f6c3373f9fc..e8d11083acbc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -24,6 +24,7 @@
 #include <linux/sbitmap.h>
 #include <linux/uuid.h>
 #include <linux/xarray.h>
+#include <linux/file.h>
 
 struct module;
 struct request_queue;
@@ -1507,6 +1508,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops);
+struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+		const struct blk_holder_ops *hops);
+struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops);
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
@@ -1517,6 +1522,7 @@ struct block_device *blkdev_get_no_open(dev_t dev);
 void blkdev_put_no_open(struct block_device *bdev);
 
 struct block_device *I_BDEV(struct inode *inode);
+struct block_device *F_BDEV(struct file *file);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8e0d77f9464e..b0a5e94e8c3a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1227,8 +1227,8 @@ struct super_block {
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
-	struct block_device	*s_bdev;
-	struct bdev_handle	*s_bdev_handle;
+	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_f_bdev */
+	struct file		*s_f_bdev;
 	struct backing_dev_info *s_bdi;
 	struct mtd_info		*s_mtd;
 	struct hlist_node	s_instances;
@@ -1326,6 +1326,12 @@ struct super_block {
 	struct list_head	s_inodes_wb;	/* writeback inodes */
 } __randomize_layout;
 
+/* Temporary helper that will go away. */
+static inline struct bdev_handle *sb_bdev_handle(struct super_block *sb)
+{
+	return sb->s_f_bdev->private_data;
+}
+
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
 {
 	return inode->i_sb->s_user_ns;

-- 
2.42.0



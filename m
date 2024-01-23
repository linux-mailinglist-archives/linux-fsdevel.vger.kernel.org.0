Return-Path: <linux-fsdevel+bounces-8546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C42D838FE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD09C1F243DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663A25FDD6;
	Tue, 23 Jan 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz/5Ubad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357C5FDC8;
	Tue, 23 Jan 2024 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016422; cv=none; b=XsmEjL+Edm2Evp3Bb9qLlE18QnFImXhtBRykivZJ7bv1F1tR29heB1YbXnvt3vWPCYcUu5BD/qTgkKje8JkR5pdn4Z/ua4VDxvyWBH0iazNXCu1Fic3Ul0qmTN0MLYsxmOLnwKli81j+TFshMlzQCy9jn6F8ukm/9QmgbYj5MK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016422; c=relaxed/simple;
	bh=madvfmHSfKSMAc9Je3CE7SK2Bt2AKWSE1xdX3KiaN8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LFuINyaXHA8Lcm4RKv2groZwL3I8sPQPrH2b4Nchfud7ORPDGezjugua5ob5BYkXtDYsSt+DW04LPTp/VkL/Ss11/ZM+bIvJlxaq2yM0NVzu0B8GETKXFxNi1fxXEM4QvGkjBtKQJORGbtRmtdECtYz9sGCf6Eq97RMOI2z+dVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz/5Ubad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F400C433A6;
	Tue, 23 Jan 2024 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016422;
	bh=madvfmHSfKSMAc9Je3CE7SK2Bt2AKWSE1xdX3KiaN8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sz/5UbadnZ8Ys35ySdc/77dVkMVMNIL0J1GU0+gCEFrXeR4Umo+CO2GqjRqjxmN/4
	 t/0rpScNsRKn94daN/PedEgzMOCbTCyMrhyjIph/Be9QWg+LA5nKLOXuBtkpZDOEOu
	 HbKNRfuCYvpaT3p19Bwh52bjiofKecBXoCZeTwQlfBAxfSWAdZyZzQOX0Ajo2mAFU2
	 a3YLhxn8OWZIHUc4HFQG1I0QdUc2sQ8x6ayx1jRm3dQDdEYHfay9LGdHSgiyj/bnai
	 OfHOI3LCYP6IM+nlJM/yogaCNFUNqctQfxXPjOWHBr0Vonh0oveuIXUR4Rf+pF5ax0
	 Ha60WFJEDEvQQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:18 +0100
Subject: [PATCH v2 01/34] bdev: open block device as files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=16385; i=brauner@kernel.org;
 h=from:subject:message-id; bh=madvfmHSfKSMAc9Je3CE7SK2Bt2AKWSE1xdX3KiaN8E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zdP3SRssuqWcxyn/3dk+wRu7VtaMf3qx8bVjD9ao
 nZtaTz2vaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiuo2MDCvqLJVseVl9N0yT
 srb/L65rzvbpCKOKhpveFslomec7ljAy3JnKlmbS4vVeJXRt4OQFEYptkjpLeuKjFB6Fzeef0b+
 MFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add two new helpers to allow opening block devices as files.
This is not the final infrastructure. This still opens the block device
before opening a struct a file. Until we have removed all references to
struct bdev_handle we can't switch the order:

* Introduce blk_to_file_flags() to translate from block specific to
  flags usable to pen a new file.
* Introduce bdev_file_open_by_{dev,path}().
* Introduce temporary sb_bdev_handle() helper to retrieve a struct
  bdev_handle from a block device file and update places that directly
  reference struct bdev_handle to rely on it.
* Don't count block device openes against the number of open files. A
  bdev_file_open_by_{dev,path}() file is never installed into any
  file descriptor table.

One idea that came to mind was to use kernel_tmpfile_open() which
would require us to pass a path and it would then call do_dentry_open()
going through the regular fops->open::blkdev_open() path. But that has
drawbacks that I consider fatal. We're back to the problem of
routing block specific flags such as BLK_OPEN_RESTRICT_WRITES through
the open path and would have to waste FMODE_* flags every time we add a
new one. Second, it would prohibit us from later using custom fops to
indicate that this is a restricted write operation as well. Overall, we
can avoid using an fmode flag and we have way more leeway in how we open
block devices from bdev_open_by_{dev,path}().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 104 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/cramfs/inode.c      |   2 +-
 fs/f2fs/super.c        |   2 +-
 fs/file_table.c        |  36 +++++++++++++----
 fs/jfs/jfs_logmgr.c    |   2 +-
 fs/romfs/super.c       |   2 +-
 fs/super.c             |  18 ++++-----
 fs/xfs/xfs_super.c     |   2 +-
 include/linux/blkdev.h |   7 ++++
 include/linux/file.h   |   2 +
 include/linux/fs.h     |  10 ++++-
 11 files changed, 160 insertions(+), 27 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index e9f1b12bd75c..4246a57a7c5a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -49,6 +49,13 @@ struct block_device *I_BDEV(struct inode *inode)
 }
 EXPORT_SYMBOL(I_BDEV);
 
+struct block_device *file_bdev(struct file *bdev_file)
+{
+	struct bdev_handle *handle = bdev_file->private_data;
+	return handle->bdev;
+}
+EXPORT_SYMBOL(file_bdev);
+
 static void bdev_write_inode(struct block_device *bdev)
 {
 	struct inode *inode = bdev->bd_inode;
@@ -368,12 +375,12 @@ static struct file_system_type bd_type = {
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
@@ -382,10 +389,10 @@ void __init bdev_cache_init(void)
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
@@ -911,6 +918,95 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
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
+	else if (mode & BLK_OPEN_READ)
+		flags |= O_RDONLY;
+	else /* Neither read nor write for a block device requested? */
+		WARN_ON_ONCE(true);
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
+	struct file *bdev_file;
+	struct bdev_handle *handle;
+	unsigned int flags;
+
+	handle = bdev_open_by_dev(dev, mode, holder, hops);
+	if (IS_ERR(handle))
+		return ERR_CAST(handle);
+
+	flags = blk_to_file_flags(mode);
+	bdev_file = alloc_file_pseudo_noaccount(handle->bdev->bd_inode,
+			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
+	if (IS_ERR(bdev_file)) {
+		bdev_release(handle);
+		return bdev_file;
+	}
+	ihold(handle->bdev->bd_inode);
+
+	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
+	if (bdev_nowait(handle->bdev))
+		bdev_file->f_mode |= FMODE_NOWAIT;
+
+	bdev_file->f_mapping = handle->bdev->bd_inode->i_mapping;
+	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
+	bdev_file->private_data = handle;
+	return bdev_file;
+}
+EXPORT_SYMBOL(bdev_file_open_by_dev);
+
+struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
+				    void *holder,
+				    const struct blk_holder_ops *hops)
+{
+	struct file *bdev_file;
+	dev_t dev;
+	int error;
+
+	error = lookup_bdev(path, &dev);
+	if (error)
+		return ERR_PTR(error);
+
+	bdev_file = bdev_file_open_by_dev(dev, mode, holder, hops);
+	if (!IS_ERR(bdev_file) && (mode & BLK_OPEN_WRITE)) {
+		struct bdev_handle *handle = bdev_file->private_data;
+		if (bdev_read_only(handle->bdev)) {
+			fput(bdev_file);
+			bdev_file = ERR_PTR(-EACCES);
+		}
+	}
+
+	return bdev_file;
+}
+EXPORT_SYMBOL(bdev_file_open_by_path);
+
 /**
  * bdev_open_by_path - open a block device by name
  * @path: path to the block device to open
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 60dbfa0f8805..39e75131fd5a 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -495,7 +495,7 @@ static void cramfs_kill_sb(struct super_block *sb)
 		sb->s_mtd = NULL;
 	} else if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV) && sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		bdev_release(sb->s_bdev_handle);
+		fput(sb->s_bdev_file);
 	}
 	kfree(sbi);
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d45ab0992ae5..ea94c148fee5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4247,7 +4247,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < max_devices; i++) {
 		if (i == 0)
-			FDEV(0).bdev_handle = sbi->sb->s_bdev_handle;
+			FDEV(0).bdev_handle = sb_bdev_handle(sbi->sb);
 		else if (!RDEV(i).path[0])
 			break;
 
diff --git a/fs/file_table.c b/fs/file_table.c
index b991f90571b4..f61e212b99f4 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -281,13 +281,17 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
  * @path: the (dentry, vfsmount) pair for the new file
  * @flags: O_... flags with which the new file will be opened
  * @fop: the 'struct file_operations' for the new file
+ * @noaccount: whether this is an internal open that shouldn't be counted
  */
 static struct file *alloc_file(const struct path *path, int flags,
-		const struct file_operations *fop)
+		const struct file_operations *fop, bool noaccount)
 {
 	struct file *file;
 
-	file = alloc_empty_file(flags, current_cred());
+	if (noaccount)
+		file = alloc_empty_file_noaccount(flags, current_cred());
+	else
+		file = alloc_empty_file(flags, current_cred());
 	if (IS_ERR(file))
 		return file;
 
@@ -312,9 +316,11 @@ static struct file *alloc_file(const struct path *path, int flags,
 	return file;
 }
 
-struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
-				const char *name, int flags,
-				const struct file_operations *fops)
+static struct file *__alloc_file_pseudo(struct inode *inode,
+					struct vfsmount *mnt, const char *name,
+					int flags,
+					const struct file_operations *fops,
+					bool noaccount)
 {
 	struct qstr this = QSTR_INIT(name, strlen(name));
 	struct path path;
@@ -325,19 +331,35 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
 		return ERR_PTR(-ENOMEM);
 	path.mnt = mntget(mnt);
 	d_instantiate(path.dentry, inode);
-	file = alloc_file(&path, flags, fops);
+	file = alloc_file(&path, flags, fops, noaccount);
 	if (IS_ERR(file)) {
 		ihold(inode);
 		path_put(&path);
 	}
 	return file;
 }
+
+struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
+				const char *name, int flags,
+				const struct file_operations *fops)
+{
+	return __alloc_file_pseudo(inode, mnt, name, flags, fops, false);
+}
 EXPORT_SYMBOL(alloc_file_pseudo);
 
+struct file *alloc_file_pseudo_noaccount(struct inode *inode,
+					 struct vfsmount *mnt, const char *name,
+					 int flags,
+					 const struct file_operations *fops)
+{
+	return __alloc_file_pseudo(inode, mnt, name, flags, fops, true);
+}
+EXPORT_SYMBOL_GPL(alloc_file_pseudo_noaccount);
+
 struct file *alloc_file_clone(struct file *base, int flags,
 				const struct file_operations *fops)
 {
-	struct file *f = alloc_file(&base->f_path, flags, fops);
+	struct file *f = alloc_file(&base->f_path, flags, fops, false);
 	if (!IS_ERR(f)) {
 		path_get(&f->f_path);
 		f->f_mapping = base->f_mapping;
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
index 545ad44f96b8..1ed468c03557 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -594,7 +594,7 @@ static void romfs_kill_sb(struct super_block *sb)
 #ifdef CONFIG_ROMFS_ON_BLOCK
 	if (sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		bdev_release(sb->s_bdev_handle);
+		fput(sb->s_bdev_file);
 	}
 #endif
 }
diff --git a/fs/super.c b/fs/super.c
index d35e85295489..08dcc3371aa0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1532,16 +1532,16 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
 {
 	blk_mode_t mode = sb_open_mode(sb_flags);
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct block_device *bdev;
 
-	bdev_handle = bdev_open_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
-	if (IS_ERR(bdev_handle)) {
+	bdev_file = bdev_file_open_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
+	if (IS_ERR(bdev_file)) {
 		if (fc)
 			errorf(fc, "%s: Can't open blockdev", fc->source);
-		return PTR_ERR(bdev_handle);
+		return PTR_ERR(bdev_file);
 	}
-	bdev = bdev_handle->bdev;
+	bdev = file_bdev(bdev_file);
 
 	/*
 	 * This really should be in blkdev_get_by_dev, but right now can't due
@@ -1549,7 +1549,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	 * writable from userspace even for a read-only block device.
 	 */
 	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
-		bdev_release(bdev_handle);
+		fput(bdev_file);
 		return -EACCES;
 	}
 
@@ -1560,11 +1560,11 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	if (atomic_read(&bdev->bd_fsfreeze_count) > 0) {
 		if (fc)
 			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		bdev_release(bdev_handle);
+		fput(bdev_file);
 		return -EBUSY;
 	}
 	spin_lock(&sb_lock);
-	sb->s_bdev_handle = bdev_handle;
+	sb->s_bdev_file = bdev_file;
 	sb->s_bdev = bdev;
 	sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
 	if (bdev_stable_writes(bdev))
@@ -1680,7 +1680,7 @@ void kill_block_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
-		bdev_release(sb->s_bdev_handle);
+		fput(sb->s_bdev_file);
 	}
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index aff20ddd4a9f..e5ac0e59ede9 100644
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
index 99e4f5e72213..76706aa47316 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -24,6 +24,7 @@
 #include <linux/sbitmap.h>
 #include <linux/uuid.h>
 #include <linux/xarray.h>
+#include <linux/file.h>
 
 struct module;
 struct request_queue;
@@ -1474,6 +1475,7 @@ extern const struct blk_holder_ops fs_holder_ops;
 	(BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES | \
 	 (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
+/* @bdev_handle will be removed soon. */
 struct bdev_handle {
 	struct block_device *bdev;
 	void *holder;
@@ -1484,6 +1486,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
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
@@ -1494,6 +1500,7 @@ struct block_device *blkdev_get_no_open(dev_t dev);
 void blkdev_put_no_open(struct block_device *bdev);
 
 struct block_device *I_BDEV(struct inode *inode);
+struct block_device *file_bdev(struct file *bdev_file);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
diff --git a/include/linux/file.h b/include/linux/file.h
index 6834a29338c4..169692cb1906 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -24,6 +24,8 @@ struct inode;
 struct path;
 extern struct file *alloc_file_pseudo(struct inode *, struct vfsmount *,
 	const char *, int flags, const struct file_operations *);
+extern struct file *alloc_file_pseudo_noaccount(struct inode *, struct vfsmount *,
+	const char *, int flags, const struct file_operations *);
 extern struct file *alloc_file_clone(struct file *, int flags,
 	const struct file_operations *);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..e9291e27cc47 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1228,8 +1228,8 @@ struct super_block {
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
-	struct block_device	*s_bdev;
-	struct bdev_handle	*s_bdev_handle;
+	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_bdev_file */
+	struct file		*s_bdev_file;
 	struct backing_dev_info *s_bdi;
 	struct mtd_info		*s_mtd;
 	struct hlist_node	s_instances;
@@ -1327,6 +1327,12 @@ struct super_block {
 	struct list_head	s_inodes_wb;	/* writeback inodes */
 } __randomize_layout;
 
+/* Temporary helper that will go away. */
+static inline struct bdev_handle *sb_bdev_handle(struct super_block *sb)
+{
+	return sb->s_bdev_file->private_data;
+}
+
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
 {
 	return inode->i_sb->s_user_ns;

-- 
2.43.0



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2853770607
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 18:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfGVQyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 12:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731163AbfGVQx7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:53:59 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB802238E;
        Mon, 22 Jul 2019 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563814438;
        bh=Pdycqdlwwo9JLUmiFVAka59shHexBquDBk8VA+tL9/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vu8ygMaja5h8CV+DIlhyQeNVsPTPS8TftIWXV2KgccSbmHPhM37cDH1fNt8FbOSmu
         72vSwCBeZsWpEA2mMJiYtNJMf5sHapM+61fPRcbhyr4TJgGGJFJCJAWoVCdvZxHEYF
         d5x6B+npD66fOg5eqKdTBLF9uglD8Z4B+ALkJjdk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v7 17/17] f2fs: add fs-verity support
Date:   Mon, 22 Jul 2019 09:51:01 -0700
Message-Id: <20190722165101.12840-18-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722165101.12840-1-ebiggers@kernel.org>
References: <20190722165101.12840-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add fs-verity support to f2fs.  fs-verity is a filesystem feature that
enables transparent integrity protection and authentication of read-only
files.  It uses a dm-verity like mechanism at the file level: a Merkle
tree is used to verify any block in the file in log(filesize) time.  It
is implemented mainly by helper functions in fs/verity/.  See
Documentation/filesystems/fsverity.rst for the full documentation.

The f2fs support for fs-verity consists of:

- Adding a filesystem feature flag and an inode flag for fs-verity.

- Implementing the fsverity_operations to support enabling verity on an
  inode and reading/writing the verity metadata.

- Updating ->readpages() to verify data as it's read from verity files
  and to support reading verity metadata pages.

- Updating ->write_begin(), ->write_end(), and ->writepages() to support
  writing verity metadata pages.

- Calling the fs-verity hooks for ->open(), ->setattr(), and ->ioctl().

Like ext4, f2fs stores the verity metadata (Merkle tree and
fsverity_descriptor) past the end of the file, starting at the first 64K
boundary beyond i_size.  This approach works because (a) verity files
are readonly, and (b) pages fully beyond i_size aren't visible to
userspace but can be read/written internally by f2fs with only some
relatively small changes to f2fs.  Extended attributes cannot be used
because (a) f2fs limits the total size of an inode's xattr entries to
4096 bytes, which wouldn't be enough for even a single Merkle tree
block, and (b) f2fs encryption doesn't encrypt xattrs, yet the verity
metadata *must* be encrypted when the file is because it contains hashes
of the plaintext data.

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/Makefile |   1 +
 fs/f2fs/data.c   |  72 ++++++++++++--
 fs/f2fs/f2fs.h   |  20 +++-
 fs/f2fs/file.c   |  43 ++++++++-
 fs/f2fs/inode.c  |   5 +-
 fs/f2fs/super.c  |   3 +
 fs/f2fs/sysfs.c  |  11 +++
 fs/f2fs/verity.c | 247 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/xattr.h  |   2 +
 9 files changed, 390 insertions(+), 14 deletions(-)
 create mode 100644 fs/f2fs/verity.c

diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 776c4b9365049..2aaecc63834fc 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -8,3 +8,4 @@ f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
 f2fs-$(CONFIG_F2FS_IO_TRACE) += trace.o
+f2fs-$(CONFIG_FS_VERITY) += verity.o
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index abbf14e9bd725..3f525f8a3a5fa 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -74,6 +74,7 @@ static enum count_type __read_io_type(struct page *page)
 enum bio_post_read_step {
 	STEP_INITIAL = 0,
 	STEP_DECRYPT,
+	STEP_VERITY,
 };
 
 struct bio_post_read_ctx {
@@ -120,8 +121,23 @@ static void decrypt_work(struct work_struct *work)
 	bio_post_read_processing(ctx);
 }
 
+static void verity_work(struct work_struct *work)
+{
+	struct bio_post_read_ctx *ctx =
+		container_of(work, struct bio_post_read_ctx, work);
+
+	fsverity_verify_bio(ctx->bio);
+
+	bio_post_read_processing(ctx);
+}
+
 static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 {
+	/*
+	 * We use different work queues for decryption and for verity because
+	 * verity may require reading metadata pages that need decryption, and
+	 * we shouldn't recurse to the same workqueue.
+	 */
 	switch (++ctx->cur_step) {
 	case STEP_DECRYPT:
 		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
@@ -131,6 +147,14 @@ static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 		}
 		ctx->cur_step++;
 		/* fall-through */
+	case STEP_VERITY:
+		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
+			INIT_WORK(&ctx->work, verity_work);
+			fsverity_enqueue_verify_work(&ctx->work);
+			return;
+		}
+		ctx->cur_step++;
+		/* fall-through */
 	default:
 		__read_end_io(ctx->bio);
 	}
@@ -608,8 +632,15 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	up_write(&io->io_rwsem);
 }
 
+static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
+{
+	return fsverity_active(inode) &&
+	       idx < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
+}
+
 static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
-					unsigned nr_pages, unsigned op_flag)
+				      unsigned nr_pages, unsigned op_flag,
+				      pgoff_t first_idx)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
@@ -625,6 +656,10 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 
 	if (f2fs_encrypted_file(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
+
+	if (f2fs_need_verity(inode, first_idx))
+		post_read_steps |= 1 << STEP_VERITY;
+
 	if (post_read_steps) {
 		ctx = mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
 		if (!ctx) {
@@ -646,7 +681,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
 
-	bio = f2fs_grab_read_bio(inode, blkaddr, 1, 0);
+	bio = f2fs_grab_read_bio(inode, blkaddr, 1, 0, page->index);
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
@@ -1569,6 +1604,15 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return ret;
 }
 
+static inline loff_t f2fs_readpage_limit(struct inode *inode)
+{
+	if (IS_ENABLED(CONFIG_FS_VERITY) &&
+	    (IS_VERITY(inode) || f2fs_verity_in_progress(inode)))
+		return inode->i_sb->s_maxbytes;
+
+	return i_size_read(inode);
+}
+
 static int f2fs_read_single_page(struct inode *inode, struct page *page,
 					unsigned nr_pages,
 					struct f2fs_map_blocks *map,
@@ -1587,7 +1631,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 
 	block_in_file = (sector_t)page_index(page);
 	last_block = block_in_file + nr_pages;
-	last_block_in_file = (i_size_read(inode) + blocksize - 1) >>
+	last_block_in_file = (f2fs_readpage_limit(inode) + blocksize - 1) >>
 							blkbits;
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
@@ -1632,6 +1676,11 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	} else {
 zero_out:
 		zero_user_segment(page, 0, PAGE_SIZE);
+		if (f2fs_need_verity(inode, page->index) &&
+		    !fsverity_verify_page(page)) {
+			ret = -EIO;
+			goto out;
+		}
 		if (!PageUptodate(page))
 			SetPageUptodate(page);
 		unlock_page(page);
@@ -1650,7 +1699,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	}
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
-				is_readahead ? REQ_RAHEAD : 0);
+				is_readahead ? REQ_RAHEAD : 0, page->index);
 		if (IS_ERR(bio)) {
 			ret = PTR_ERR(bio);
 			bio = NULL;
@@ -2052,7 +2101,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 
-	if (page->index < end_index)
+	if (page->index < end_index || f2fs_verity_in_progress(inode))
 		goto write;
 
 	/*
@@ -2458,7 +2507,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	 * the block addresses when there is no need to fill the page.
 	 */
 	if (!f2fs_has_inline_data(inode) && len == PAGE_SIZE &&
-			!is_inode_flag_set(inode, FI_NO_PREALLOC))
+	    !is_inode_flag_set(inode, FI_NO_PREALLOC) &&
+	    !f2fs_verity_in_progress(inode))
 		return 0;
 
 	/* f2fs_lock_op avoids race between write CP and convert_inline_page */
@@ -2597,7 +2647,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	if (len == PAGE_SIZE || PageUptodate(page))
 		return 0;
 
-	if (!(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode)) {
+	if (!(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode) &&
+	    !f2fs_verity_in_progress(inode)) {
 		zero_user_segment(page, len, PAGE_SIZE);
 		return 0;
 	}
@@ -2660,7 +2711,8 @@ static int f2fs_write_end(struct file *file,
 
 	set_page_dirty(page);
 
-	if (pos + copied > i_size_read(inode))
+	if (pos + copied > i_size_read(inode) &&
+	    !f2fs_verity_in_progress(inode))
 		f2fs_i_size_write(inode, pos + copied);
 unlock_out:
 	f2fs_put_page(page, 1);
@@ -3104,7 +3156,9 @@ void f2fs_clear_page_cache_dirty_tag(struct page *page)
 
 int __init f2fs_init_post_read_processing(void)
 {
-	bio_post_read_ctx_cache = KMEM_CACHE(bio_post_read_ctx, 0);
+	bio_post_read_ctx_cache =
+		kmem_cache_create("f2fs_bio_post_read_ctx",
+				  sizeof(struct bio_post_read_ctx), 0, 0, NULL);
 	if (!bio_post_read_ctx_cache)
 		goto fail;
 	bio_post_read_ctx_pool =
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 17382da7f0bd9..7c5f121edac53 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -25,6 +25,7 @@
 #include <crypto/hash.h>
 
 #include <linux/fscrypt.h>
+#include <linux/fsverity.h>
 
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
@@ -151,7 +152,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_QUOTA_INO		0x0080
 #define F2FS_FEATURE_INODE_CRTIME	0x0100
 #define F2FS_FEATURE_LOST_FOUND		0x0200
-#define F2FS_FEATURE_VERITY		0x0400	/* reserved */
+#define F2FS_FEATURE_VERITY		0x0400
 #define F2FS_FEATURE_SB_CHKSUM		0x0800
 
 #define __F2FS_HAS_FEATURE(raw_super, mask)				\
@@ -630,7 +631,7 @@ enum {
 #define FADVISE_ENC_NAME_BIT	0x08
 #define FADVISE_KEEP_SIZE_BIT	0x10
 #define FADVISE_HOT_BIT		0x20
-#define FADVISE_VERITY_BIT	0x40	/* reserved */
+#define FADVISE_VERITY_BIT	0x40
 
 #define FADVISE_MODIFIABLE_BITS	(FADVISE_COLD_BIT | FADVISE_HOT_BIT)
 
@@ -650,6 +651,8 @@ enum {
 #define file_is_hot(inode)	is_file(inode, FADVISE_HOT_BIT)
 #define file_set_hot(inode)	set_file(inode, FADVISE_HOT_BIT)
 #define file_clear_hot(inode)	clear_file(inode, FADVISE_HOT_BIT)
+#define file_is_verity(inode)	is_file(inode, FADVISE_VERITY_BIT)
+#define file_set_verity(inode)	set_file(inode, FADVISE_VERITY_BIT)
 
 #define DEF_DIR_LEVEL		0
 
@@ -2412,6 +2415,7 @@ enum {
 	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
 	FI_PIN_FILE,		/* indicate file should not be gced */
 	FI_ATOMIC_REVOKE_REQUEST, /* request to drop atomic data */
+	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 };
 
 static inline void __mark_inode_dirty_flag(struct inode *inode,
@@ -2451,6 +2455,12 @@ static inline void clear_inode_flag(struct inode *inode, int flag)
 	__mark_inode_dirty_flag(inode, flag, false);
 }
 
+static inline bool f2fs_verity_in_progress(struct inode *inode)
+{
+	return IS_ENABLED(CONFIG_FS_VERITY) &&
+	       is_inode_flag_set(inode, FI_VERITY_IN_PROGRESS);
+}
+
 static inline void set_acl_inode(struct inode *inode, umode_t mode)
 {
 	F2FS_I(inode)->i_acl_mode = mode;
@@ -3521,6 +3531,9 @@ void f2fs_exit_sysfs(void);
 int f2fs_register_sysfs(struct f2fs_sb_info *sbi);
 void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi);
 
+/* verity.c */
+extern const struct fsverity_operations f2fs_verityops;
+
 /*
  * crypto support
  */
@@ -3543,7 +3556,7 @@ static inline void f2fs_set_encrypted_inode(struct inode *inode)
  */
 static inline bool f2fs_post_read_required(struct inode *inode)
 {
-	return f2fs_encrypted_file(inode);
+	return f2fs_encrypted_file(inode) || fsverity_active(inode);
 }
 
 #define F2FS_FEATURE_FUNCS(name, flagname) \
@@ -3561,6 +3574,7 @@ F2FS_FEATURE_FUNCS(flexible_inline_xattr, FLEXIBLE_INLINE_XATTR);
 F2FS_FEATURE_FUNCS(quota_ino, QUOTA_INO);
 F2FS_FEATURE_FUNCS(inode_crtime, INODE_CRTIME);
 F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
+F2FS_FEATURE_FUNCS(verity, VERITY);
 F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
 
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f8d46df8fa9ee..838bfeecbd863 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -493,6 +493,10 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
 	int err = fscrypt_file_open(inode, filp);
 
+	if (err)
+		return err;
+
+	err = fsverity_file_open(inode, filp);
 	if (err)
 		return err;
 
@@ -778,6 +782,10 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (err)
 		return err;
 
+	err = fsverity_prepare_setattr(dentry, attr);
+	if (err)
+		return err;
+
 	if (is_quota_modification(inode, attr)) {
 		err = dquot_initialize(inode);
 		if (err)
@@ -1712,7 +1720,8 @@ static const struct {
 		FS_PROJINHERIT_FL |	\
 		FS_ENCRYPT_FL |		\
 		FS_INLINE_DATA_FL |	\
-		FS_NOCOW_FL)
+		FS_NOCOW_FL |		\
+		FS_VERITY_FL)
 
 #define F2FS_SETTABLE_FS_FL (		\
 		FS_SYNC_FL |		\
@@ -1757,6 +1766,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 
 	if (IS_ENCRYPTED(inode))
 		fsflags |= FS_ENCRYPT_FL;
+	if (IS_VERITY(inode))
+		fsflags |= FS_VERITY_FL;
 	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
 		fsflags |= FS_INLINE_DATA_FL;
 	if (is_inode_flag_set(inode, FI_PIN_FILE))
@@ -3077,6 +3088,30 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+
+	if (!f2fs_sb_has_verity(F2FS_I_SB(inode))) {
+		f2fs_warn(F2FS_I_SB(inode),
+			  "Can't enable fs-verity on inode %lu: the verity feature is not enabled on this filesystem.\n",
+			  inode->i_ino);
+		return -EOPNOTSUPP;
+	}
+
+	return fsverity_ioctl_enable(filp, (const void __user *)arg);
+}
+
+static int f2fs_ioc_measure_verity(struct file *filp, unsigned long arg)
+{
+	if (!f2fs_sb_has_verity(F2FS_I_SB(file_inode(filp))))
+		return -EOPNOTSUPP;
+
+	return fsverity_ioctl_measure(filp, (void __user *)arg);
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -3135,6 +3170,10 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_precache_extents(filp, arg);
 	case F2FS_IOC_RESIZE_FS:
 		return f2fs_ioc_resize_fs(filp, arg);
+	case FS_IOC_ENABLE_VERITY:
+		return f2fs_ioc_enable_verity(filp, arg);
+	case FS_IOC_MEASURE_VERITY:
+		return f2fs_ioc_measure_verity(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -3249,6 +3288,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_SET_PIN_FILE:
 	case F2FS_IOC_PRECACHE_EXTENTS:
 	case F2FS_IOC_RESIZE_FS:
+	case FS_IOC_ENABLE_VERITY:
+	case FS_IOC_MEASURE_VERITY:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index a33d7a849b2df..06da75d418e0e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -46,9 +46,11 @@ void f2fs_set_inode_flags(struct inode *inode)
 		new_fl |= S_DIRSYNC;
 	if (file_is_encrypt(inode))
 		new_fl |= S_ENCRYPTED;
+	if (file_is_verity(inode))
+		new_fl |= S_VERITY;
 	inode_set_flags(inode, new_fl,
 			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|
-			S_ENCRYPTED);
+			S_ENCRYPTED|S_VERITY);
 }
 
 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
@@ -733,6 +735,7 @@ void f2fs_evict_inode(struct inode *inode)
 	}
 out_clear:
 	fscrypt_put_encryption_info(inode);
+	fsverity_cleanup_inode(inode);
 	clear_inode(inode);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6de6cda440315..f085ce15acd18 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3143,6 +3143,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &f2fs_sops;
 #ifdef CONFIG_FS_ENCRYPTION
 	sb->s_cop = &f2fs_cryptops;
+#endif
+#ifdef CONFIG_FS_VERITY
+	sb->s_vop = &f2fs_verityops;
 #endif
 	sb->s_xattr = f2fs_xattr_handlers;
 	sb->s_export_op = &f2fs_export_ops;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 3aeacd0aacfd2..0cd64f9940685 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -131,6 +131,9 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (f2fs_sb_has_lost_found(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "lost_found");
+	if (f2fs_sb_has_verity(sbi))
+		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
+				len ? ", " : "", "verity");
 	if (f2fs_sb_has_sb_chksum(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "sb_checksum");
@@ -364,6 +367,7 @@ enum feat_id {
 	FEAT_QUOTA_INO,
 	FEAT_INODE_CRTIME,
 	FEAT_LOST_FOUND,
+	FEAT_VERITY,
 	FEAT_SB_CHECKSUM,
 };
 
@@ -381,6 +385,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_QUOTA_INO:
 	case FEAT_INODE_CRTIME:
 	case FEAT_LOST_FOUND:
+	case FEAT_VERITY:
 	case FEAT_SB_CHECKSUM:
 		return snprintf(buf, PAGE_SIZE, "supported\n");
 	}
@@ -470,6 +475,9 @@ F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
 F2FS_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
 F2FS_FEATURE_RO_ATTR(inode_crtime, FEAT_INODE_CRTIME);
 F2FS_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
+#ifdef CONFIG_FS_VERITY
+F2FS_FEATURE_RO_ATTR(verity, FEAT_VERITY);
+#endif
 F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
@@ -534,6 +542,9 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(quota_ino),
 	ATTR_LIST(inode_crtime),
 	ATTR_LIST(lost_found),
+#ifdef CONFIG_FS_VERITY
+	ATTR_LIST(verity),
+#endif
 	ATTR_LIST(sb_checksum),
 	NULL,
 };
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
new file mode 100644
index 0000000000000..6bc3470d99d00
--- /dev/null
+++ b/fs/f2fs/verity.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fs/f2fs/verity.c: fs-verity support for f2fs
+ *
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * Implementation of fsverity_operations for f2fs.
+ *
+ * Like ext4, f2fs stores the verity metadata (Merkle tree and
+ * fsverity_descriptor) past the end of the file, starting at the first 64K
+ * boundary beyond i_size.  This approach works because (a) verity files are
+ * readonly, and (b) pages fully beyond i_size aren't visible to userspace but
+ * can be read/written internally by f2fs with only some relatively small
+ * changes to f2fs.  Extended attributes cannot be used because (a) f2fs limits
+ * the total size of an inode's xattr entries to 4096 bytes, which wouldn't be
+ * enough for even a single Merkle tree block, and (b) f2fs encryption doesn't
+ * encrypt xattrs, yet the verity metadata *must* be encrypted when the file is
+ * because it contains hashes of the plaintext data.
+ *
+ * Using a 64K boundary rather than a 4K one keeps things ready for
+ * architectures with 64K pages, and it doesn't necessarily waste space on-disk
+ * since there can be a hole between i_size and the start of the Merkle tree.
+ */
+
+#include <linux/f2fs_fs.h>
+
+#include "f2fs.h"
+#include "xattr.h"
+
+static inline loff_t f2fs_verity_metadata_pos(const struct inode *inode)
+{
+	return round_up(inode->i_size, 65536);
+}
+
+/*
+ * Read some verity metadata from the inode.  __vfs_read() can't be used because
+ * we need to read beyond i_size.
+ */
+static int pagecache_read(struct inode *inode, void *buf, size_t count,
+			  loff_t pos)
+{
+	while (count) {
+		size_t n = min_t(size_t, count,
+				 PAGE_SIZE - offset_in_page(pos));
+		struct page *page;
+		void *addr;
+
+		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
+					 NULL);
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		addr = kmap_atomic(page);
+		memcpy(buf, addr + offset_in_page(pos), n);
+		kunmap_atomic(addr);
+
+		put_page(page);
+
+		buf += n;
+		pos += n;
+		count -= n;
+	}
+	return 0;
+}
+
+/*
+ * Write some verity metadata to the inode for FS_IOC_ENABLE_VERITY.
+ * kernel_write() can't be used because the file descriptor is readonly.
+ */
+static int pagecache_write(struct inode *inode, const void *buf, size_t count,
+			   loff_t pos)
+{
+	if (pos + count > inode->i_sb->s_maxbytes)
+		return -EFBIG;
+
+	while (count) {
+		size_t n = min_t(size_t, count,
+				 PAGE_SIZE - offset_in_page(pos));
+		struct page *page;
+		void *fsdata;
+		void *addr;
+		int res;
+
+		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
+					    &page, &fsdata);
+		if (res)
+			return res;
+
+		addr = kmap_atomic(page);
+		memcpy(addr + offset_in_page(pos), buf, n);
+		kunmap_atomic(addr);
+
+		res = pagecache_write_end(NULL, inode->i_mapping, pos, n, n,
+					  page, fsdata);
+		if (res < 0)
+			return res;
+		if (res != n)
+			return -EIO;
+
+		buf += n;
+		pos += n;
+		count -= n;
+	}
+	return 0;
+}
+
+/*
+ * Format of f2fs verity xattr.  This points to the location of the verity
+ * descriptor within the file data rather than containing it directly because
+ * the verity descriptor *must* be encrypted when f2fs encryption is used.  But,
+ * f2fs encryption does not encrypt xattrs.
+ */
+struct fsverity_descriptor_location {
+	__le32 version;
+	__le32 size;
+	__le64 pos;
+};
+
+static int f2fs_begin_enable_verity(struct file *filp)
+{
+	struct inode *inode = file_inode(filp);
+	int err;
+
+	if (f2fs_verity_in_progress(inode))
+		return -EBUSY;
+
+	if (f2fs_is_atomic_file(inode) || f2fs_is_volatile_file(inode))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Since the file was opened readonly, we have to initialize the quotas
+	 * here and not rely on ->open() doing it.  This must be done before
+	 * evicting the inline data.
+	 */
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
+
+	err = f2fs_convert_inline_inode(inode);
+	if (err)
+		return err;
+
+	set_inode_flag(inode, FI_VERITY_IN_PROGRESS);
+	return 0;
+}
+
+static int f2fs_end_enable_verity(struct file *filp, const void *desc,
+				  size_t desc_size, u64 merkle_tree_size)
+{
+	struct inode *inode = file_inode(filp);
+	u64 desc_pos = f2fs_verity_metadata_pos(inode) + merkle_tree_size;
+	struct fsverity_descriptor_location dloc = {
+		.version = cpu_to_le32(1),
+		.size = cpu_to_le32(desc_size),
+		.pos = cpu_to_le64(desc_pos),
+	};
+	int err = 0;
+
+	if (desc != NULL) {
+		/* Succeeded; write the verity descriptor. */
+		err = pagecache_write(inode, desc, desc_size, desc_pos);
+
+		/* Write all pages before clearing FI_VERITY_IN_PROGRESS. */
+		if (!err)
+			err = filemap_write_and_wait(inode->i_mapping);
+	}
+
+	/* If we failed, truncate anything we wrote past i_size. */
+	if (desc == NULL || err)
+		f2fs_truncate(inode);
+
+	clear_inode_flag(inode, FI_VERITY_IN_PROGRESS);
+
+	if (desc != NULL && !err) {
+		err = f2fs_setxattr(inode, F2FS_XATTR_INDEX_VERITY,
+				    F2FS_XATTR_NAME_VERITY, &dloc, sizeof(dloc),
+				    NULL, XATTR_CREATE);
+		if (!err) {
+			file_set_verity(inode);
+			f2fs_set_inode_flags(inode);
+			f2fs_mark_inode_dirty_sync(inode, true);
+		}
+	}
+	return err;
+}
+
+static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
+				      size_t buf_size)
+{
+	struct fsverity_descriptor_location dloc;
+	int res;
+	u32 size;
+	u64 pos;
+
+	/* Get the descriptor location */
+	res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_VERITY,
+			    F2FS_XATTR_NAME_VERITY, &dloc, sizeof(dloc), NULL);
+	if (res < 0 && res != -ERANGE)
+		return res;
+	if (res != sizeof(dloc) || dloc.version != cpu_to_le32(1)) {
+		f2fs_warn(F2FS_I_SB(inode), "unknown verity xattr format");
+		return -EINVAL;
+	}
+	size = le32_to_cpu(dloc.size);
+	pos = le64_to_cpu(dloc.pos);
+
+	/* Get the descriptor */
+	if (pos + size < pos || pos + size > inode->i_sb->s_maxbytes ||
+	    pos < f2fs_verity_metadata_pos(inode) || size > INT_MAX) {
+		f2fs_warn(F2FS_I_SB(inode), "invalid verity xattr");
+		return -EUCLEAN; /* EFSCORRUPTED */
+	}
+	if (buf_size) {
+		if (size > buf_size)
+			return -ERANGE;
+		res = pagecache_read(inode, buf, size, pos);
+		if (res)
+			return res;
+	}
+	return size;
+}
+
+static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
+					       pgoff_t index)
+{
+	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
+
+	return read_mapping_page(inode->i_mapping, index, NULL);
+}
+
+static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
+					u64 index, int log_blocksize)
+{
+	loff_t pos = f2fs_verity_metadata_pos(inode) + (index << log_blocksize);
+
+	return pagecache_write(inode, buf, 1 << log_blocksize, pos);
+}
+
+const struct fsverity_operations f2fs_verityops = {
+	.begin_enable_verity	= f2fs_begin_enable_verity,
+	.end_enable_verity	= f2fs_end_enable_verity,
+	.get_verity_descriptor	= f2fs_get_verity_descriptor,
+	.read_merkle_tree_page	= f2fs_read_merkle_tree_page,
+	.write_merkle_tree_block = f2fs_write_merkle_tree_block,
+};
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index a90920e2f9498..de0c600b9cab0 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -34,8 +34,10 @@
 #define F2FS_XATTR_INDEX_ADVISE			7
 /* Should be same as EXT4_XATTR_INDEX_ENCRYPTION */
 #define F2FS_XATTR_INDEX_ENCRYPTION		9
+#define F2FS_XATTR_INDEX_VERITY			11
 
 #define F2FS_XATTR_NAME_ENCRYPTION_CONTEXT	"c"
+#define F2FS_XATTR_NAME_VERITY			"v"
 
 struct f2fs_xattr_header {
 	__le32  h_magic;        /* magic number for identification */
-- 
2.22.0


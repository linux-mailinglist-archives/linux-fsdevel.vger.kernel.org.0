Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201063D35FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 10:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhGWHVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 03:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233619AbhGWHVT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:21:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0364A60E91;
        Fri, 23 Jul 2021 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627027313;
        bh=Jfpb1991Ehh/ksIMKDcUPEyNGAhOuRhPXnGxtetI1uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQyWqFlaTcB1MNK00PceAHV7lnL88Rv1zOzmoLQGFH9PUQwvttI14WF9FjgYtfwj4
         UKdinP1mjFLyjFVkXW5CilRYHPVynTKP8spA983mAGfGnt73rxeMRH0jdzFi3MR5E0
         UdFl70Qs4GNFFi9E3sUesx1/l3Cuyk5k7EFqs0FgegZmjxCyBXjlVRyhRtAQ3f+Yz0
         jLbT/FqwlkkuCEIpLLDiYTxURK2X/wC0MLXwIoROcvgdyM47tmTBShYK2RkBZNvnzp
         nspZF+r8/nqefTk6kaywd2eyVXmq6ucz+xxOaGbU6g4um/nZJ3+IdUB39f7CT2OcIv
         GoGknnTEG2jSw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH v2 2/2] f2fs: use iomap for direct I/O
Date:   Fri, 23 Jul 2021 00:59:21 -0700
Message-Id: <20210723075921.166705-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723075921.166705-1-ebiggers@kernel.org>
References: <20210723075921.166705-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make f2fs_file_read_iter() and f2fs_file_write_iter() use the iomap
direct I/O implementation instead of the fs/direct-io.c one.

The iomap implementation is more efficient, and it also avoids the need
to add new features and optimizations to the old implementation.

This new implementation also eliminates the need for f2fs to hook bio
submission and completion and to allocate memory per-bio.  This is
because it's possible to correctly update f2fs's in-flight DIO counters
using __iomap_dio_rw() in combination with an implementation of
iomap_dio_ops::end_io() (as suggested by Christoph Hellwig).

When possible, this new implementation preserves existing f2fs behavior
such as the conditions for falling back to buffered I/O.

This patch has been tested with xfstests by running 'gce-xfstests -c
f2fs -g auto -X generic/017' with and without this patch; no regressions
were seen.  (Some tests fail both before and after.  generic/017 hangs
both before and after, so it had to be excluded.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/data.c | 202 +----------------------------
 fs/f2fs/f2fs.h |  21 +--
 fs/f2fs/file.c | 346 ++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 310 insertions(+), 259 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8cc58ae6494f..30538c200fdb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1363,11 +1363,6 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 		f2fs_invalidate_compress_page(sbi, old_blkaddr);
 	}
 	f2fs_update_data_blkaddr(dn, dn->data_blkaddr);
-
-	/*
-	 * i_size will be updated by direct_IO. Otherwise, we'll get stale
-	 * data from unwritten block via dio_read.
-	 */
 	return 0;
 }
 
@@ -1655,47 +1650,6 @@ static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
 	return (blks << inode->i_blkbits);
 }
 
-static int __get_data_block(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh, int create, int flag,
-			pgoff_t *next_pgofs, int seg_type, bool may_write)
-{
-	struct f2fs_map_blocks map;
-	int err;
-
-	map.m_lblk = iblock;
-	map.m_len = bytes_to_blks(inode, bh->b_size);
-	map.m_next_pgofs = next_pgofs;
-	map.m_next_extent = NULL;
-	map.m_seg_type = seg_type;
-	map.m_may_create = may_write;
-
-	err = f2fs_map_blocks(inode, &map, create, flag);
-	if (!err) {
-		map_bh(bh, inode->i_sb, map.m_pblk);
-		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
-		bh->b_size = blks_to_bytes(inode, map.m_len);
-	}
-	return err;
-}
-
-static int get_data_block_dio_write(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh_result, int create)
-{
-	return __get_data_block(inode, iblock, bh_result, create,
-				F2FS_GET_BLOCK_DIO, NULL,
-				f2fs_rw_hint_to_seg_type(inode->i_write_hint),
-				true);
-}
-
-static int get_data_block_dio(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh_result, int create)
-{
-	return __get_data_block(inode, iblock, bh_result, create,
-				F2FS_GET_BLOCK_DIO, NULL,
-				f2fs_rw_hint_to_seg_type(inode->i_write_hint),
-				false);
-}
-
 static int f2fs_xattr_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo)
 {
@@ -3132,7 +3086,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 			FS_CP_DATA_IO : FS_DATA_IO);
 }
 
-static void f2fs_write_failed(struct inode *inode, loff_t to)
+void f2fs_write_failed(struct inode *inode, loff_t to)
 {
 	loff_t i_size = i_size_read(inode);
 
@@ -3417,158 +3371,6 @@ static int f2fs_write_end(struct file *file,
 	return copied;
 }
 
-static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
-			   loff_t offset)
-{
-	unsigned i_blkbits = READ_ONCE(inode->i_blkbits);
-	unsigned blkbits = i_blkbits;
-	unsigned blocksize_mask = (1 << blkbits) - 1;
-	unsigned long align = offset | iov_iter_alignment(iter);
-	struct block_device *bdev = inode->i_sb->s_bdev;
-
-	if (iov_iter_rw(iter) == READ && offset >= i_size_read(inode))
-		return 1;
-
-	if (align & blocksize_mask) {
-		if (bdev)
-			blkbits = blksize_bits(bdev_logical_block_size(bdev));
-		blocksize_mask = (1 << blkbits) - 1;
-		if (align & blocksize_mask)
-			return -EINVAL;
-		return 1;
-	}
-	return 0;
-}
-
-static void f2fs_dio_end_io(struct bio *bio)
-{
-	struct f2fs_private_dio *dio = bio->bi_private;
-
-	dec_page_count(F2FS_I_SB(dio->inode),
-			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
-
-	bio->bi_private = dio->orig_private;
-	bio->bi_end_io = dio->orig_end_io;
-
-	kfree(dio);
-
-	bio_endio(bio);
-}
-
-static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
-							loff_t file_offset)
-{
-	struct f2fs_private_dio *dio;
-	bool write = (bio_op(bio) == REQ_OP_WRITE);
-
-	dio = f2fs_kzalloc(F2FS_I_SB(inode),
-			sizeof(struct f2fs_private_dio), GFP_NOFS);
-	if (!dio)
-		goto out;
-
-	dio->inode = inode;
-	dio->orig_end_io = bio->bi_end_io;
-	dio->orig_private = bio->bi_private;
-	dio->write = write;
-
-	bio->bi_end_io = f2fs_dio_end_io;
-	bio->bi_private = dio;
-
-	inc_page_count(F2FS_I_SB(inode),
-			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
-
-	submit_bio(bio);
-	return;
-out:
-	bio->bi_status = BLK_STS_IOERR;
-	bio_endio(bio);
-}
-
-static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	struct inode *inode = mapping->host;
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	size_t count = iov_iter_count(iter);
-	loff_t offset = iocb->ki_pos;
-	int rw = iov_iter_rw(iter);
-	int err;
-	enum rw_hint hint = iocb->ki_hint;
-	int whint_mode = F2FS_OPTION(sbi).whint_mode;
-	bool do_opu;
-
-	err = check_direct_IO(inode, iter, offset);
-	if (err)
-		return err < 0 ? err : 0;
-
-	if (f2fs_force_buffered_io(inode, iocb, iter))
-		return 0;
-
-	do_opu = rw == WRITE && f2fs_lfs_mode(sbi);
-
-	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
-
-	if (rw == WRITE && whint_mode == WHINT_MODE_OFF)
-		iocb->ki_hint = WRITE_LIFE_NOT_SET;
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!down_read_trylock(&fi->i_gc_rwsem[rw])) {
-			iocb->ki_hint = hint;
-			err = -EAGAIN;
-			goto out;
-		}
-		if (do_opu && !down_read_trylock(&fi->i_gc_rwsem[READ])) {
-			up_read(&fi->i_gc_rwsem[rw]);
-			iocb->ki_hint = hint;
-			err = -EAGAIN;
-			goto out;
-		}
-	} else {
-		down_read(&fi->i_gc_rwsem[rw]);
-		if (do_opu)
-			down_read(&fi->i_gc_rwsem[READ]);
-	}
-
-	err = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
-			iter, rw == WRITE ? get_data_block_dio_write :
-			get_data_block_dio, NULL, f2fs_dio_submit_bio,
-			rw == WRITE ? DIO_LOCKING | DIO_SKIP_HOLES :
-			DIO_SKIP_HOLES);
-
-	if (do_opu)
-		up_read(&fi->i_gc_rwsem[READ]);
-
-	up_read(&fi->i_gc_rwsem[rw]);
-
-	if (rw == WRITE) {
-		if (whint_mode == WHINT_MODE_OFF)
-			iocb->ki_hint = hint;
-		if (err > 0) {
-			f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_IO,
-									err);
-			if (!do_opu)
-				set_inode_flag(inode, FI_UPDATE_WRITE);
-		} else if (err == -EIOCBQUEUED) {
-			f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_IO,
-						count - iov_iter_count(iter));
-		} else if (err < 0) {
-			f2fs_write_failed(inode, offset + count);
-		}
-	} else {
-		if (err > 0)
-			f2fs_update_iostat(sbi, APP_DIRECT_READ_IO, err);
-		else if (err == -EIOCBQUEUED)
-			f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_READ_IO,
-						count - iov_iter_count(iter));
-	}
-
-out:
-	trace_f2fs_direct_IO_exit(inode, offset, count, rw, err);
-
-	return err;
-}
-
 void f2fs_invalidate_page(struct page *page, unsigned int offset,
 							unsigned int length)
 {
@@ -4024,7 +3826,7 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.set_page_dirty	= f2fs_set_data_page_dirty,
 	.invalidatepage	= f2fs_invalidate_page,
 	.releasepage	= f2fs_release_page,
-	.direct_IO	= f2fs_direct_IO,
+	.direct_IO	= noop_direct_IO,
 	.bmap		= f2fs_bmap,
 	.swap_activate  = f2fs_swap_activate,
 	.swap_deactivate = f2fs_swap_deactivate,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 231e3bf2a63e..64ba70e7b738 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1755,13 +1755,6 @@ struct f2fs_sb_info {
 #endif
 };
 
-struct f2fs_private_dio {
-	struct inode *inode;
-	void *orig_private;
-	bio_end_io_t *orig_end_io;
-	bool write;
-};
-
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 #define f2fs_show_injection_info(sbi, type)					\
 	printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n",	\
@@ -3243,15 +3236,12 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 	spin_lock(&sbi->iostat_lock);
 	sbi->rw_iostat[type] += io_bytes;
 
-	if (type == APP_WRITE_IO || type == APP_DIRECT_IO)
-		sbi->rw_iostat[APP_BUFFERED_IO] =
-			sbi->rw_iostat[APP_WRITE_IO] -
-			sbi->rw_iostat[APP_DIRECT_IO];
+	if (type == APP_BUFFERED_IO || type == APP_DIRECT_IO)
+		sbi->rw_iostat[APP_WRITE_IO] += io_bytes;
+
+	if (type == APP_BUFFERED_READ_IO || type == APP_DIRECT_READ_IO)
+		sbi->rw_iostat[APP_READ_IO] += io_bytes;
 
-	if (type == APP_READ_IO || type == APP_DIRECT_READ_IO)
-		sbi->rw_iostat[APP_BUFFERED_READ_IO] =
-			sbi->rw_iostat[APP_READ_IO] -
-			sbi->rw_iostat[APP_DIRECT_READ_IO];
 	spin_unlock(&sbi->iostat_lock);
 
 	f2fs_record_iostat(sbi);
@@ -3631,6 +3621,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 				struct writeback_control *wbc,
 				enum iostat_type io_type,
 				int compr_blocks, bool allow_balance);
+void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_page(struct page *page, unsigned int offset,
 			unsigned int length);
 int f2fs_release_page(struct page *page, gfp_t wait);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 279252c7f7bc..33f6520e1056 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -23,6 +23,7 @@
 #include <linux/nls.h>
 #include <linux/sched/signal.h>
 #include <linux/fileattr.h>
+#include <linux/iomap.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -4201,23 +4202,145 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return __f2fs_ioctl(filp, cmd, arg);
 }
 
-static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+/*
+ * Return %true if the given read or write request should use direct I/O, or
+ * %false if it should use buffered I/O.
+ */
+static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
+				struct iov_iter *iter)
+{
+	unsigned int align;
+
+	if (!(iocb->ki_flags & IOCB_DIRECT))
+		return false;
+
+	if (f2fs_force_buffered_io(inode, iocb, iter))
+		return false;
+
+	/*
+	 * Direct I/O not aligned to the disk's logical_block_size will be
+	 * attempted, but will fail with -EINVAL.
+	 *
+	 * f2fs additionally requires that direct I/O be aligned to the
+	 * filesystem block size, which is often a stricter requirement.
+	 * However, f2fs traditionally falls back to buffered I/O on requests
+	 * that are logical_block_size-aligned but not fs-block aligned.
+	 *
+	 * The below logic implements this behavior.
+	 */
+	align = iocb->ki_pos | iov_iter_alignment(iter);
+	if (!IS_ALIGNED(align, i_blocksize(inode)) &&
+	    IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev)))
+		return false;
+
+	return true;
+}
+
+static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
+				unsigned int flags)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(iocb->ki_filp));
+
+	dec_page_count(sbi, F2FS_DIO_READ);
+	if (error)
+		return error;
+	f2fs_update_iostat(sbi, APP_DIRECT_READ_IO, size);
+	return 0;
+}
+
+static const struct iomap_dio_ops f2fs_iomap_dio_read_ops = {
+	.end_io = f2fs_dio_read_end_io,
+};
+
+static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	int ret;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	const loff_t pos = iocb->ki_pos;
+	const size_t count = iov_iter_count(to);
+	struct iomap_dio *dio;
+	ssize_t ret;
+
+	if (count == 0)
+		return 0; /* skip atime update */
+
+	trace_f2fs_direct_IO_enter(inode, pos, count, READ);
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!down_read_trylock(&fi->i_gc_rwsem[READ])) {
+			ret = -EAGAIN;
+			goto out;
+		}
+	} else {
+		down_read(&fi->i_gc_rwsem[READ]);
+	}
+
+	/*
+	 * We have to use __iomap_dio_rw() and iomap_dio_complete() instead of
+	 * the higher-level function iomap_dio_rw() in order to ensure that the
+	 * F2FS_DIO_READ counter will be decremented correctly in all cases.
+	 */
+	inc_page_count(sbi, F2FS_DIO_READ);
+	dio = __iomap_dio_rw(iocb, to, &f2fs_iomap_ops,
+			     &f2fs_iomap_dio_read_ops, 0);
+	if (IS_ERR_OR_NULL(dio)) {
+		ret = PTR_ERR_OR_ZERO(dio);
+		if (ret != -EIOCBQUEUED)
+			dec_page_count(sbi, F2FS_DIO_READ);
+	} else {
+		ret = iomap_dio_complete(dio);
+	}
+
+	up_read(&fi->i_gc_rwsem[READ]);
+
+	file_accessed(file);
+out:
+	trace_f2fs_direct_IO_exit(inode, pos, count, READ, ret);
+	return ret;
+}
+
+static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
 
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	ret = generic_file_read_iter(iocb, iter);
+	if (f2fs_should_use_dio(inode, iocb, to))
+		return f2fs_dio_read_iter(iocb, to);
 
+	ret = filemap_read(iocb, to, 0);
 	if (ret > 0)
-		f2fs_update_iostat(F2FS_I_SB(inode), APP_READ_IO, ret);
-
+		f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_READ_IO, ret);
 	return ret;
 }
 
+static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	ssize_t count;
+	int err;
+
+	if (IS_IMMUTABLE(inode))
+		return -EPERM;
+
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
+		return -EPERM;
+
+	count = generic_write_checks(iocb, from);
+	if (count <= 0)
+		return count;
+
+	err = file_modified(file);
+	if (err)
+		return err;
+	return count;
+}
+
 /*
  * Preallocate blocks for a write request, if it is possible and helpful to do
  * so.  Returns a positive number if blocks may have been preallocated, 0 if no
@@ -4225,15 +4348,14 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
  * seriously wrong.  Also sets FI_PREALLOCATED_ALL on the inode if *all* the
  * requested blocks (not just some of them) have been allocated.
  */
-static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter)
+static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
+				   bool dio)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	const loff_t pos = iocb->ki_pos;
 	const size_t count = iov_iter_count(iter);
 	struct f2fs_map_blocks map = {};
-	bool dio = (iocb->ki_flags & IOCB_DIRECT) &&
-		   !f2fs_force_buffered_io(inode, iocb, iter);
 	int flag;
 	int ret;
 
@@ -4278,13 +4400,174 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter)
 	return map.m_len;
 }
 
-static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	ssize_t ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EOPNOTSUPP;
+
+	current->backing_dev_info = inode_to_bdi(inode);
+	ret = generic_perform_write(file, from, iocb->ki_pos);
+	current->backing_dev_info = NULL;
+
+	if (ret > 0) {
+		iocb->ki_pos += ret;
+		f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_IO, ret);
+	}
+	return ret;
+}
+
+static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
+				 unsigned int flags)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(iocb->ki_filp));
+
+	dec_page_count(sbi, F2FS_DIO_WRITE);
+	if (error)
+		return error;
+	f2fs_update_iostat(sbi, APP_DIRECT_IO, size);
+	return 0;
+}
+
+static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
+	.end_io = f2fs_dio_write_end_io,
+};
+
+static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
+				   bool *may_need_sync)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	const bool do_opu = f2fs_lfs_mode(sbi);
+	const int whint_mode = F2FS_OPTION(sbi).whint_mode;
+	const loff_t pos = iocb->ki_pos;
+	const ssize_t count = iov_iter_count(from);
+	const enum rw_hint hint = iocb->ki_hint;
+	unsigned int dio_flags;
+	struct iomap_dio *dio;
+	ssize_t ret;
+
+	trace_f2fs_direct_IO_enter(inode, pos, count, WRITE);
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		/* f2fs_convert_inline_inode() and block allocation can block */
+		if (f2fs_has_inline_data(inode) ||
+		    !f2fs_overwrite_io(inode, pos, count)) {
+			ret = -EAGAIN;
+			goto out;
+		}
+
+		if (!down_read_trylock(&fi->i_gc_rwsem[WRITE])) {
+			ret = -EAGAIN;
+			goto out;
+		}
+		if (do_opu && !down_read_trylock(&fi->i_gc_rwsem[READ])) {
+			up_read(&fi->i_gc_rwsem[WRITE]);
+			ret = -EAGAIN;
+			goto out;
+		}
+	} else {
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			goto out;
+
+		down_read(&fi->i_gc_rwsem[WRITE]);
+		if (do_opu)
+			down_read(&fi->i_gc_rwsem[READ]);
+	}
+	if (whint_mode == WHINT_MODE_OFF)
+		iocb->ki_hint = WRITE_LIFE_NOT_SET;
+
+	/*
+	 * We have to use __iomap_dio_rw() and iomap_dio_complete() instead of
+	 * the higher-level function iomap_dio_rw() in order to ensure that the
+	 * F2FS_DIO_WRITE counter will be decremented correctly in all cases.
+	 */
+	inc_page_count(sbi, F2FS_DIO_WRITE);
+	dio_flags = 0;
+	if (pos + count > inode->i_size)
+		dio_flags |= IOMAP_DIO_FORCE_WAIT;
+	dio = __iomap_dio_rw(iocb, from, &f2fs_iomap_ops,
+			     &f2fs_iomap_dio_write_ops, dio_flags);
+	if (IS_ERR_OR_NULL(dio)) {
+		ret = PTR_ERR_OR_ZERO(dio);
+		if (ret == -ENOTBLK)
+			ret = 0;
+		if (ret != -EIOCBQUEUED)
+			dec_page_count(sbi, F2FS_DIO_WRITE);
+	} else {
+		ret = iomap_dio_complete(dio);
+	}
+
+	if (whint_mode == WHINT_MODE_OFF)
+		iocb->ki_hint = hint;
+	if (do_opu)
+		up_read(&fi->i_gc_rwsem[READ]);
+	up_read(&fi->i_gc_rwsem[WRITE]);
+
+	if (ret < 0)
+		goto out;
+	if (pos + ret > inode->i_size)
+		f2fs_i_size_write(inode, pos + ret);
+	if (!do_opu)
+		set_inode_flag(inode, FI_UPDATE_WRITE);
+
+	if (iov_iter_count(from)) {
+		ssize_t ret2;
+		loff_t bufio_start_pos = iocb->ki_pos;
+
+		/*
+		 * The direct write was partial, so we need to fall back to a
+		 * buffered write for the remainder.
+		 */
+
+		ret2 = f2fs_buffered_write_iter(iocb, from);
+		if (iov_iter_count(from))
+			f2fs_write_failed(inode, iocb->ki_pos);
+		if (ret2 < 0)
+			goto out;
+
+		/*
+		 * Ensure that the pagecache pages are written to disk and
+		 * invalidated to preserve the expected O_DIRECT semantics.
+		 */
+		if (ret2 > 0) {
+			loff_t bufio_end_pos = bufio_start_pos + ret2 - 1;
+
+			ret += ret2;
+
+			ret2 = filemap_write_and_wait_range(file->f_mapping,
+							    bufio_start_pos,
+							    bufio_end_pos);
+			if (ret2 < 0)
+				goto out;
+			invalidate_mapping_pages(file->f_mapping,
+						 bufio_start_pos >> PAGE_SHIFT,
+						 bufio_end_pos >> PAGE_SHIFT);
+		}
+	} else {
+		/* iomap_dio_rw() already handled the generic_write_sync(). */
+		*may_need_sync = false;
+	}
+out:
+	trace_f2fs_direct_IO_exit(inode, pos, count, WRITE, ret);
+	return ret;
+}
+
+static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
 	const loff_t orig_pos = iocb->ki_pos;
 	const size_t orig_count = iov_iter_count(from);
 	loff_t target_size;
+	bool dio;
+	bool may_need_sync = true;
 	int preallocated;
 	ssize_t ret;
 
@@ -4307,48 +4590,26 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		inode_lock(inode);
 	}
 
-	if (unlikely(IS_IMMUTABLE(inode))) {
-		ret = -EPERM;
-		goto out_unlock;
-	}
-
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
-		ret = -EPERM;
-		goto out_unlock;
-	}
-
-	ret = generic_write_checks(iocb, from);
+	ret = f2fs_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out_unlock;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!f2fs_overwrite_io(inode, iocb->ki_pos,
-				       iov_iter_count(from)) ||
-		    f2fs_has_inline_data(inode) ||
-		    f2fs_force_buffered_io(inode, iocb, from)) {
-			ret = -EAGAIN;
-			goto out_unlock;
-		}
-	}
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		/*
-		 * Convert inline data for Direct I/O before entering
-		 * f2fs_direct_IO().
-		 */
-		ret = f2fs_convert_inline_inode(inode);
-		if (ret)
-			goto out_unlock;
-	}
+	/* Determine whether we will do a direct write or a buffered write. */
+	dio = f2fs_should_use_dio(inode, iocb, from);
 
 	/* Possibly preallocate the blocks for the write. */
 	target_size = iocb->ki_pos + iov_iter_count(from);
-	preallocated = f2fs_preallocate_blocks(iocb, from);
+	preallocated = f2fs_preallocate_blocks(iocb, from, dio);
 	if (preallocated < 0) {
 		ret = preallocated;
 		goto out_unlock;
 	}
 
-	ret = __generic_file_write_iter(iocb, from);
+	/* Do the actual write. */
+	if (dio)
+		ret = f2fs_dio_write_iter(iocb, from, &may_need_sync);
+	else
+		ret = f2fs_buffered_write_iter(iocb, from);
 
 	/* Don't leave any preallocated blocks around past i_size. */
 	if (preallocated > 0 && inode->i_size < target_size) {
@@ -4359,14 +4620,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	}
 	clear_inode_flag(inode, FI_PREALLOCATED_ALL);
-
-	if (ret > 0)
-		f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
 out_unlock:
 	inode_unlock(inode);
 out:
 	trace_f2fs_file_write_iter(inode, orig_pos, orig_count, ret);
-	if (ret > 0)
+	if (ret > 0 && may_need_sync)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
 }
-- 
2.32.0


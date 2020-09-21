Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6D2728A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgIUOoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:55760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgIUOoW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4FE8BAD76;
        Mon, 21 Sep 2020 14:44:55 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 05/15] btrfs: split btrfs_direct_IO to read and write
Date:   Mon, 21 Sep 2020 09:43:43 -0500
Message-Id: <20200921144353.31319-6-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921144353.31319-1-rgoldwyn@suse.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

The read and write DIO don't have anything in common except for the
call to iomap_dio_rw. Extract the write call into a new function to get
rid of conditional statements for direct write.

Originally proposed by Christoph Hellwig <hch@lst.de>

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  5 ++-
 fs/btrfs/file.c  | 98 +++++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/inode.c | 91 ++------------------------------------------
 3 files changed, 95 insertions(+), 99 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cd644c755142..b47a8dcff028 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -28,6 +28,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/refcount.h>
 #include <linux/crc32c.h>
+#include <linux/iomap.h>
 #include "extent-io-tree.h"
 #include "extent_io.h"
 #include "extent_map.h"
@@ -3048,7 +3049,9 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
-ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
+extern const struct iomap_ops btrfs_dio_iomap_ops;
+extern const struct iomap_dio_ops btrfs_dio_ops;
+extern const struct iomap_dio_ops btrfs_sync_dops;
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 038e0afaf3d0..910e2fd234a9 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1855,21 +1855,68 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	return num_written ? num_written : ret;
 }
 
-static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
+		const struct iov_iter *iter, loff_t offset)
+{
+	const unsigned int blocksize_mask = fs_info->sectorsize - 1;
+
+	if (offset & blocksize_mask)
+		return -EINVAL;
+
+	if (iov_iter_alignment(iter) & blocksize_mask)
+		return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	loff_t pos;
-	ssize_t written;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	loff_t pos = iocb->ki_pos;
+	ssize_t written = 0;
+	bool relock = false;
 	ssize_t written_buffered;
 	loff_t endbyte;
 	int err;
 
-	written = btrfs_direct_IO(iocb, from);
+	if (check_direct_IO(fs_info, from, pos))
+		goto buffered;
+
+	/*
+	 * If the write DIO is beyond the EOF, we need update
+	 * the isize, but it is protected by i_mutex. So we can
+	 * not unlock the i_mutex at this case.
+	 */
+	if (pos + iov_iter_count(from) <= inode->i_size) {
+		inode_unlock(inode);
+		relock = true;
+	}
+	down_read(&BTRFS_I(inode)->dio_sem);
+
+	/*
+	 * We have are actually a sync iocb, so we need our fancy endio to know
+	 * if we need to sync.
+	 */
+	if (current->journal_info)
+		written = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,
+				&btrfs_sync_dops, is_sync_kiocb(iocb));
+	else
+		written = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,
+				&btrfs_dio_ops, is_sync_kiocb(iocb));
+
+	if (written == -ENOTBLK)
+		written = 0;
+
+	up_read(&BTRFS_I(inode)->dio_sem);
+	if (relock)
+		inode_lock(inode);
 
 	if (written < 0 || !iov_iter_count(from))
 		return written;
 
+buffered:
 	pos = iocb->ki_pos;
 	written_buffered = btrfs_buffered_write(iocb, from);
 	if (written_buffered < 0) {
@@ -2043,7 +2090,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 			iocb->ki_flags &= ~IOCB_DSYNC;
 			current->journal_info = BTRFS_DIO_SYNC_STUB;
 		}
-		num_written = __btrfs_direct_write(iocb, from);
+		num_written = btrfs_direct_write(iocb, from);
 
 		/*
 		 * As stated above, we cleared journal_info, so we need to do
@@ -3618,16 +3665,47 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+static int check_direct_read(struct btrfs_fs_info *fs_info,
+		const struct iov_iter *iter, loff_t offset)
+{
+	int ret;
+	int i, seg;
+
+	ret = check_direct_IO(fs_info, iter, offset);
+	if (ret < 0)
+		return ret;
+
+	if (!iter_is_iovec(iter))
+		return 0;
+
+	for (seg = 0; seg < iter->nr_segs; seg++)
+		for (i = seg + 1; i < iter->nr_segs; i++)
+			if (iter->iov[seg].iov_base == iter->iov[i].iov_base)
+				return -EINVAL;
+	return 0;
+}
+
+static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))
+		return 0;
+
+	inode_lock_shared(inode);
+	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
+			is_sync_kiocb(iocb));
+	inode_unlock_shared(inode);
+	return ret;
+}
+
 static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret = 0;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		struct inode *inode = file_inode(iocb->ki_filp);
-
-		inode_lock_shared(inode);
-		ret = btrfs_direct_IO(iocb, to);
-		inode_unlock_shared(inode);
+		ret = btrfs_direct_read(iocb, to);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3db4697ff1ba..0730131b6590 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7898,39 +7898,6 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 	return BLK_QC_T_NONE;
 }
 
-static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
-			       const struct iov_iter *iter, loff_t offset)
-{
-	int seg;
-	int i;
-	unsigned int blocksize_mask = fs_info->sectorsize - 1;
-	ssize_t retval = -EINVAL;
-
-	if (offset & blocksize_mask)
-		goto out;
-
-	if (iov_iter_alignment(iter) & blocksize_mask)
-		goto out;
-
-	/* If this is a write we don't need to check anymore */
-	if (iov_iter_rw(iter) != READ || !iter_is_iovec(iter))
-		return 0;
-	/*
-	 * Check to make sure we don't have duplicate iov_base's in this
-	 * iovec, if so return EINVAL, otherwise we'll get csum errors
-	 * when reading back.
-	 */
-	for (seg = 0; seg < iter->nr_segs; seg++) {
-		for (i = seg + 1; i < iter->nr_segs; i++) {
-			if (iter->iov[seg].iov_base == iter->iov[i].iov_base)
-				goto out;
-		}
-	}
-	retval = 0;
-out:
-	return retval;
-}
-
 static inline int btrfs_maybe_fsync_end_io(struct kiocb *iocb, ssize_t size,
 					   int error, unsigned flags)
 {
@@ -7955,72 +7922,20 @@ static inline int btrfs_maybe_fsync_end_io(struct kiocb *iocb, ssize_t size,
 	return 0;
 }
 
-static const struct iomap_ops btrfs_dio_iomap_ops = {
+const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_begin            = btrfs_dio_iomap_begin,
 	.iomap_end              = btrfs_dio_iomap_end,
 };
 
-static const struct iomap_dio_ops btrfs_dio_ops = {
+const struct iomap_dio_ops btrfs_dio_ops = {
 	.submit_io		= btrfs_submit_direct,
 };
 
-static const struct iomap_dio_ops btrfs_sync_dops = {
+const struct iomap_dio_ops btrfs_sync_dops = {
 	.submit_io		= btrfs_submit_direct,
 	.end_io			= btrfs_maybe_fsync_end_io,
 };
 
-ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_changeset *data_reserved = NULL;
-	loff_t offset = iocb->ki_pos;
-	size_t count = 0;
-	bool relock = false;
-	ssize_t ret;
-
-	if (check_direct_IO(fs_info, iter, offset))
-		return 0;
-
-	count = iov_iter_count(iter);
-	if (iov_iter_rw(iter) == WRITE) {
-		/*
-		 * If the write DIO is beyond the EOF, we need update
-		 * the isize, but it is protected by i_mutex. So we can
-		 * not unlock the i_mutex at this case.
-		 */
-		if (offset + count <= inode->i_size) {
-			inode_unlock(inode);
-			relock = true;
-		}
-		down_read(&BTRFS_I(inode)->dio_sem);
-	}
-
-	/*
-	 * We have are actually a sync iocb, so we need our fancy endio to know
-	 * if we need to sync.
-	 */
-	if (current->journal_info)
-		ret = iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops,
-				   &btrfs_sync_dops, is_sync_kiocb(iocb));
-	else
-		ret = iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops,
-				   &btrfs_dio_ops, is_sync_kiocb(iocb));
-
-	if (ret == -ENOTBLK)
-		ret = 0;
-
-	if (iov_iter_rw(iter) == WRITE)
-		up_read(&BTRFS_I(inode)->dio_sem);
-
-	if (relock)
-		inode_lock(inode);
-
-	extent_changeset_free(data_reserved);
-	return ret;
-}
-
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len)
 {
-- 
2.26.2


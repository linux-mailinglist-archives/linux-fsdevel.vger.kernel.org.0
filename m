Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC4820D6D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgF2TY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:24:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:60858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731742AbgF2TY1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:24:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1C65AC2E;
        Mon, 29 Jun 2020 19:24:24 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com, dsterba@suse.cz,
        david@fromorbit.com, darrick.wong@oracle.com, hch@lst.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 6/6] btrfs: split btrfs_direct_IO to read and write part
Date:   Mon, 29 Jun 2020 14:23:53 -0500
Message-Id: <20200629192353.20841-7-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629192353.20841-1-rgoldwyn@suse.de>
References: <20200629192353.20841-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

The read and write versions don't have anything in common except for the
call to iomap_dio_rw.  So split this function, and merge each half into
its only caller.

Originally proposed by Christoph Hellwig <hch@lst.de>

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  4 +-
 fs/btrfs/file.c  | 95 +++++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/inode.c | 82 +----------------------------------------
 3 files changed, 90 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 677f170434e3..1037969cda63 100644
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
@@ -2935,7 +2936,8 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
-ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
+extern const struct iomap_ops btrfs_dio_iomap_ops;
+extern const struct iomap_dio_ops btrfs_dops;
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9d486350f1bf..8c738f8101c4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1825,21 +1825,65 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	return num_written ? num_written : ret;
 }
 
-static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
+			       const struct iov_iter *iter, loff_t offset)
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
 	ssize_t written_buffered;
 	loff_t endbyte;
 	int err;
+	size_t count = 0;
+	bool relock = false;
+	int flags = IOMAP_DIO_RWF_NO_STALE_PAGECACHE;
 
-	written = btrfs_direct_IO(iocb, from);
+	if (check_direct_IO(fs_info, from, pos))
+		goto buffered;
+
+	count = iov_iter_count(from);
+	/*
+	 * If the write DIO is beyond the EOF, we need update the isize, but it
+	 * is protected by i_mutex. So we can not unlock the i_mutex at this
+	 * case.
+	 */
+	if (pos + count <= inode->i_size) {
+		inode_unlock(inode);
+		relock = true;
+	} else if (iocb->ki_flags & IOCB_NOWAIT) {
+		return -EAGAIN;
+	}
+
+	if (is_sync_kiocb(iocb))
+		flags |= IOMAP_DIO_RWF_SYNCIO;
+
+	down_read(&BTRFS_I(inode)->dio_sem);
+	written = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dops,
+			       flags);
+	up_read(&BTRFS_I(inode)->dio_sem);
+
+	if (relock)
+		inode_lock(inode);
 
 	if (written < 0 || !iov_iter_count(from))
 		return written;
 
+buffered:
 	pos = iocb->ki_pos;
 	written_buffered = btrfs_buffered_write(iocb, from);
 	if (written_buffered < 0) {
@@ -1990,7 +2034,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		num_written = __btrfs_direct_write(iocb, from);
+		num_written = btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
 		if (num_written > 0)
@@ -3504,16 +3548,47 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+static int check_direct_read(struct btrfs_fs_info *fs_info,
+			     const struct iov_iter *iter, loff_t offset)
+{
+	int ret;
+	int i, seg;
+
+	ret = check_direct_IO(fs_info, iter, offset);
+	if (ret < 0)
+		return ret;
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
+	int flags = IOMAP_DIO_RWF_NO_STALE_PAGECACHE;
+
+	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))
+		return 0;
+
+	if (is_sync_kiocb(iocb))
+		flags |= IOMAP_DIO_RWF_SYNCIO;
+
+	inode_lock_shared(inode);
+	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dops, flags);
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
index 264b676ebf29..864415a17b1f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -29,7 +29,6 @@
 #include <linux/swap.h>
 #include <linux/migrate.h>
 #include <linux/sched/mm.h>
-#include <linux/iomap.h>
 #include <asm/unaligned.h>
 #include "misc.h"
 #include "ctree.h"
@@ -7844,92 +7843,15 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
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
-static const struct iomap_ops btrfs_dio_iomap_ops = {
+const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_begin            = btrfs_dio_iomap_begin,
 	.iomap_end              = btrfs_dio_iomap_end,
 };
 
-static const struct iomap_dio_ops btrfs_dops = {
+const struct iomap_dio_ops btrfs_dops = {
 	.submit_io		= btrfs_submit_direct,
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
-	int flags = IOMAP_DIO_RWF_NO_STALE_PAGECACHE;
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
-	if (is_sync_kiocb(iocb))
-		flags |= IOMAP_DIO_RWF_SYNCIO;
-
-	ret = iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dops,
-			flags);
-
-	if (iov_iter_rw(iter) == WRITE) {
-		up_read(&BTRFS_I(inode)->dio_sem);
-	}
-	if (relock)
-		inode_lock(inode);
-	extent_changeset_free(data_reserved);
-	return ret;
-}
-
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len)
 {
-- 
2.26.2


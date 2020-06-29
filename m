Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3833920D6D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbgF2TYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:24:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732348AbgF2TYT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:24:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06735ABCE;
        Mon, 29 Jun 2020 19:24:16 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com, dsterba@suse.cz,
        david@fromorbit.com, darrick.wong@oracle.com, hch@lst.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/6] btrfs: switch to iomap_dio_rw() for dio
Date:   Mon, 29 Jun 2020 14:23:50 -0500
Message-Id: <20200629192353.20841-4-rgoldwyn@suse.de>
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

Switch from __blockdev_direct_IO() to iomap_dio_rw().
Rename btrfs_get_blocks_direct() to btrfs_dio_iomap_begin() and use it
as iomap_begin() for iomap direct I/O functions. This function
allocates and locks all the blocks required for the I/O.
btrfs_submit_direct() is used as the submit_io() hook for direct I/O
ops.

Since we need direct I/O reads to go through iomap_dio_rw(), we change
file_operations.read_iter() to a btrfs_file_read_iter() which calls
btrfs_direct_IO() for direct reads and falls back to
generic_file_buffered_read() for incomplete reads and buffered reads.

We don't need address_space.direct_IO() anymore so set it to noop.
Similarly, we don't need flags used in __blockdev_direct_IO(). iomap is
capable of direct I/O reads from a hole, so we don't need to return
-ENOENT.

BTRFS direct I/O is now done under i_rwsem, shared in case of reads and
exclusive in case of writes. This guards against simultaneous truncates.

Use iomap->iomap_end() to check for failed or incomplete direct I/O:
 - for writes, call __endio_write_update_ordered()
 - for reads, unlock extents

btrfs_dio_data is now hooked in iomap->private and not
current->journal_info. It carries the reservation variable and the
amount of data submitted, so we can calculate the amount of data to call
__endio_write_update_ordered in case of an error.

This patch removes last use of struct buffer_head from btrfs.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/Kconfig |   1 +
 fs/btrfs/ctree.h |   1 +
 fs/btrfs/file.c  |  21 +++-
 fs/btrfs/inode.c | 317 ++++++++++++++++++++++-------------------------
 4 files changed, 170 insertions(+), 170 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 575636f6491e..68b95ad82126 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -14,6 +14,7 @@ config BTRFS_FS
 	select LZO_DECOMPRESS
 	select ZSTD_COMPRESS
 	select ZSTD_DECOMPRESS
+	select FS_IOMAP
 	select RAID6_PQ
 	select XOR_BLOCKS
 	select SRCU
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d404cce8ae40..677f170434e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2935,6 +2935,7 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
+ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2520605afc25..9d486350f1bf 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1835,7 +1835,7 @@ static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	loff_t endbyte;
 	int err;
 
-	written = generic_file_direct_write(iocb, from);
+	written = btrfs_direct_IO(iocb, from);
 
 	if (written < 0 || !iov_iter_count(from))
 		return written;
@@ -3504,9 +3504,26 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	ssize_t ret = 0;
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		struct inode *inode = file_inode(iocb->ki_filp);
+
+		inode_lock_shared(inode);
+		ret = btrfs_direct_IO(iocb, to);
+		inode_unlock_shared(inode);
+		if (ret < 0)
+			return ret;
+	}
+
+	return generic_file_buffered_read(iocb, to, ret);
+}
+
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
-	.read_iter      = generic_file_read_iter,
+	.read_iter      = btrfs_file_read_iter,
 	.splice_read	= generic_file_splice_read,
 	.write_iter	= btrfs_file_write_iter,
 	.mmap		= btrfs_file_mmap,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 18d384f4af54..0fa75af35a1f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5,7 +5,6 @@
 
 #include <linux/kernel.h>
 #include <linux/bio.h>
-#include <linux/buffer_head.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
@@ -30,6 +29,7 @@
 #include <linux/swap.h>
 #include <linux/migrate.h>
 #include <linux/sched/mm.h>
+#include <linux/iomap.h>
 #include <asm/unaligned.h>
 #include "misc.h"
 #include "ctree.h"
@@ -58,9 +58,9 @@ struct btrfs_iget_args {
 
 struct btrfs_dio_data {
 	u64 reserve;
-	u64 unsubmitted_oe_range_start;
-	u64 unsubmitted_oe_range_end;
-	int overwrite;
+	loff_t length;
+	ssize_t submitted;
+	struct extent_changeset *data_reserved;
 };
 
 static const struct inode_operations btrfs_dir_inode_operations;
@@ -7069,7 +7069,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 }
 
 static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
-			      struct extent_state **cached_state, int writing)
+			      struct extent_state **cached_state, bool writing)
 {
 	struct btrfs_ordered_extent *ordered;
 	int ret = 0;
@@ -7207,30 +7207,7 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 }
 
 
-static int btrfs_get_blocks_direct_read(struct extent_map *em,
-					struct buffer_head *bh_result,
-					struct inode *inode,
-					u64 start, u64 len)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-
-	if (em->block_start == EXTENT_MAP_HOLE ||
-			test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-		return -ENOENT;
-
-	len = min(len, em->len - (start - em->start));
-
-	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
-		inode->i_blkbits;
-	bh_result->b_size = len;
-	bh_result->b_bdev = fs_info->fs_devices->latest_bdev;
-	set_buffer_mapped(bh_result);
-
-	return 0;
-}
-
 static int btrfs_get_blocks_direct_write(struct extent_map **map,
-					 struct buffer_head *bh_result,
 					 struct inode *inode,
 					 struct btrfs_dio_data *dio_data,
 					 u64 start, u64 len)
@@ -7292,7 +7269,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	}
 
 	/* this will cow the extent */
-	len = bh_result->b_size;
 	free_extent_map(em);
 	*map = em = btrfs_new_extent_direct(inode, start, len);
 	if (IS_ERR(em)) {
@@ -7303,64 +7279,73 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	len = min(len, em->len - (start - em->start));
 
 skip_cow:
-	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
-		inode->i_blkbits;
-	bh_result->b_size = len;
-	bh_result->b_bdev = fs_info->fs_devices->latest_bdev;
-	set_buffer_mapped(bh_result);
-
-	if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-		set_buffer_new(bh_result);
-
 	/*
 	 * Need to update the i_size under the extent lock so buffered
 	 * readers will get the updated i_size when we unlock.
 	 */
-	if (!dio_data->overwrite && start + len > i_size_read(inode))
+	if (start + len > i_size_read(inode))
 		i_size_write(inode, start + len);
 
-	WARN_ON(dio_data->reserve < len);
 	dio_data->reserve -= len;
-	dio_data->unsubmitted_oe_range_end = start + len;
-	current->journal_info = dio_data;
 out:
 	return ret;
 }
 
-static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
-				   struct buffer_head *bh_result, int create)
+static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
+		loff_t length, unsigned int flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_dio_data *dio_data = NULL;
-	u64 start = iblock << inode->i_blkbits;
 	u64 lockstart, lockend;
-	u64 len = bh_result->b_size;
+	const bool write = !!(flags & IOMAP_WRITE);
 	int ret = 0;
+	u64 len = length;
+	bool unlock_extents = false;
 
-	if (!create)
+	if (!write)
 		len = min_t(u64, len, fs_info->sectorsize);
 
 	lockstart = start;
 	lockend = start + len - 1;
 
-	if (current->journal_info) {
-		/*
-		 * Need to pull our outstanding extents and set journal_info to NULL so
-		 * that anything that needs to check if there's a transaction doesn't get
-		 * confused.
-		 */
-		dio_data = current->journal_info;
-		current->journal_info = NULL;
+	/*
+	 * The generic stuff only does filemap_write_and_wait_range, which
+	 * isn't enough if we've written compressed pages to this area, so we
+	 * need to flush the dirty pages again to make absolutely sure that any
+	 * outstanding dirty pages are on disk.
+	 */
+	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
+		     &BTRFS_I(inode)->runtime_flags))
+		ret = filemap_fdatawrite_range(inode->i_mapping, start,
+					       start + length - 1);
+
+	dio_data = kzalloc(sizeof(*dio_data), GFP_NOFS);
+	if (!dio_data)
+		return -ENOMEM;
+
+	dio_data->length = length;
+	if (write) {
+		dio_data->reserve = round_up(length, fs_info->sectorsize);
+		ret = btrfs_delalloc_reserve_space(inode,
+				&dio_data->data_reserved,
+				start, dio_data->reserve);
+		if (ret) {
+			extent_changeset_free(dio_data->data_reserved);
+			kfree(dio_data);
+			return ret;
+		}
 	}
+	iomap->private = dio_data;
+
 
 	/*
 	 * If this errors out it's because we couldn't invalidate pagecache for
 	 * this range and we need to fallback to buffered.
 	 */
-	if (lock_extent_direct(inode, lockstart, lockend, &cached_state,
-			       create)) {
+	if (lock_extent_direct(inode, lockstart, lockend, &cached_state, write)) {
 		ret = -ENOTBLK;
 		goto err;
 	}
@@ -7392,36 +7377,48 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 		goto unlock_err;
 	}
 
-	if (create) {
-		ret = btrfs_get_blocks_direct_write(&em, bh_result, inode,
-						    dio_data, start, len);
+	len = min(len, em->len - (start - em->start));
+	if (write) {
+		ret = btrfs_get_blocks_direct_write(&em, inode, dio_data,
+						    start, len);
 		if (ret < 0)
 			goto unlock_err;
-
-		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
-				     lockend, &cached_state);
+		unlock_extents = true;
+		/* Recalc len in case the new em is smaller than requested */
+		len = min(len, em->len - (start - em->start));
 	} else {
-		ret = btrfs_get_blocks_direct_read(em, bh_result, inode,
-						   start, len);
-		/* Can be negative only if we read from a hole */
-		if (ret < 0) {
-			ret = 0;
-			free_extent_map(em);
-			goto unlock_err;
-		}
 		/*
 		 * We need to unlock only the end area that we aren't using.
 		 * The rest is going to be unlocked by the endio routine.
 		 */
-		lockstart = start + bh_result->b_size;
-		if (lockstart < lockend) {
-			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-					     lockstart, lockend, &cached_state);
-		} else {
-			free_extent_state(cached_state);
-		}
+		lockstart = start + len;
+		if (lockstart < lockend)
+			unlock_extents = true;
 	}
 
+	if (unlock_extents)
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree,
+				     lockstart, lockend, &cached_state);
+	else
+		free_extent_state(cached_state);
+
+	/*
+	 * Translate extent map information to iomap.
+	 * We trim the extents (and move the addr) even though iomap code does
+	 * that, since we have locked only the parts we are performing I/O in.
+	 */
+	if ((em->block_start == EXTENT_MAP_HOLE) ||
+	    (test_bit(EXTENT_FLAG_PREALLOC, &em->flags) && !write)) {
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->type = IOMAP_HOLE;
+	} else {
+		iomap->addr = em->block_start + (start - em->start);
+		iomap->type = IOMAP_MAPPED;
+	}
+	iomap->offset = start;
+	iomap->bdev = fs_info->fs_devices->latest_bdev;
+	iomap->length = len;
+
 	free_extent_map(em);
 
 	return 0;
@@ -7430,8 +7427,53 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			     &cached_state);
 err:
-	if (dio_data)
-		current->journal_info = dio_data;
+	if (dio_data) {
+		btrfs_delalloc_release_space(inode, dio_data->data_reserved,
+				start, dio_data->reserve, true);
+		btrfs_delalloc_release_extents(BTRFS_I(inode), dio_data->reserve);
+		extent_changeset_free(dio_data->data_reserved);
+		kfree(dio_data);
+	}
+	return ret;
+}
+
+static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+		ssize_t written, unsigned int flags, struct iomap *iomap)
+{
+	int ret = 0;
+	struct btrfs_dio_data *dio_data = iomap->private;
+	size_t submitted = dio_data->submitted;
+	const bool write = !!(flags & IOMAP_WRITE);
+
+	if (!write && (iomap->type == IOMAP_HOLE)) {
+		/* If reading from a hole, unlock and return */
+		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1);
+		goto out;
+	}
+
+	if (submitted < length) {
+		pos += submitted;
+		length -= submitted;
+		if (write)
+			__endio_write_update_ordered(inode, pos, length, false);
+		else
+			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
+				      pos + length - 1);
+		ret = -ENOTBLK;
+	}
+
+	if (write) {
+		if (dio_data->reserve)
+			btrfs_delalloc_release_space(inode,
+					dio_data->data_reserved, pos,
+					dio_data->reserve, true);
+		btrfs_delalloc_release_extents(BTRFS_I(inode), dio_data->length);
+		extent_changeset_free(dio_data->data_reserved);
+	}
+out:
+	kfree(dio_data);
+	iomap->private = NULL;
+
 	return ret;
 }
 
@@ -7454,7 +7496,7 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 			      dip->logical_offset + dip->bytes - 1);
 	}
 
-	dio_end_io(dip->dio_bio);
+	bio_endio(dip->dio_bio);
 	kfree(dip);
 }
 
@@ -7690,24 +7732,11 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
 	dip->dio_bio = dio_bio;
 	refcount_set(&dip->refs, 1);
-
-	if (write) {
-		struct btrfs_dio_data *dio_data = current->journal_info;
-
-		/*
-		 * Setting range start and end to the same value means that
-		 * no cleanup will happen in btrfs_direct_IO
-		 */
-		dio_data->unsubmitted_oe_range_end = dip->logical_offset +
-			dip->bytes;
-		dio_data->unsubmitted_oe_range_start =
-			dio_data->unsubmitted_oe_range_end;
-	}
 	return dip;
 }
 
-static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
-				loff_t file_offset)
+static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
+		struct bio *dio_bio, loff_t file_offset)
 {
 	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
@@ -7724,6 +7753,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	int ret;
 	blk_status_t status;
 	struct btrfs_io_geometry geom;
+	struct btrfs_dio_data *dio_data = iomap->private;
 
 	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
 	if (!dip) {
@@ -7732,8 +7762,8 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 				file_offset + dio_bio->bi_iter.bi_size - 1);
 		}
 		dio_bio->bi_status = BLK_STS_RESOURCE;
-		dio_end_io(dio_bio);
-		return;
+		bio_endio(dio_bio);
+		return BLK_QC_T_NONE;
 	}
 
 	if (!write && csum) {
@@ -7804,15 +7834,17 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 			goto out_err;
 		}
 
+		dio_data->submitted += clone_len;
 		clone_offset += clone_len;
 		start_sector += clone_len >> 9;
 		file_offset += clone_len;
 	} while (submit_len > 0);
-	return;
+	return BLK_QC_T_NONE;
 
 out_err:
 	dip->dio_bio->bi_status = status;
 	btrfs_dio_private_put(dip);
+	return BLK_QC_T_NONE;
 }
 
 static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
@@ -7848,37 +7880,31 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 	return retval;
 }
 
-static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+static const struct iomap_ops btrfs_dio_iomap_ops = {
+	.iomap_begin            = btrfs_dio_iomap_begin,
+	.iomap_end              = btrfs_dio_iomap_end,
+};
+
+static const struct iomap_dio_ops btrfs_dops = {
+	.submit_io		= btrfs_submit_direct,
+};
+
+ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_dio_data dio_data = { 0 };
 	struct extent_changeset *data_reserved = NULL;
 	loff_t offset = iocb->ki_pos;
 	size_t count = 0;
-	int flags = 0;
-	bool wakeup = true;
 	bool relock = false;
 	ssize_t ret;
+	int flags = IOMAP_DIO_RWF_NO_STALE_PAGECACHE;
 
 	if (check_direct_IO(fs_info, iter, offset))
 		return 0;
 
-	inode_dio_begin(inode);
-
-	/*
-	 * The generic stuff only does filemap_write_and_wait_range, which
-	 * isn't enough if we've written compressed pages to this area, so
-	 * we need to flush the dirty pages again to make absolutely sure
-	 * that any outstanding dirty pages are on disk.
-	 */
 	count = iov_iter_count(iter);
-	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-		     &BTRFS_I(inode)->runtime_flags))
-		filemap_fdatawrite_range(inode->i_mapping, offset,
-					 offset + count - 1);
-
 	if (iov_iter_rw(iter) == WRITE) {
 		/*
 		 * If the write DIO is beyond the EOF, we need update
@@ -7886,68 +7912,23 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		 * not unlock the i_mutex at this case.
 		 */
 		if (offset + count <= inode->i_size) {
-			dio_data.overwrite = 1;
 			inode_unlock(inode);
 			relock = true;
 		}
-		ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
-						   offset, count);
-		if (ret)
-			goto out;
-
-		/*
-		 * We need to know how many extents we reserved so that we can
-		 * do the accounting properly if we go over the number we
-		 * originally calculated.  Abuse current->journal_info for this.
-		 */
-		dio_data.reserve = round_up(count,
-					    fs_info->sectorsize);
-		dio_data.unsubmitted_oe_range_start = (u64)offset;
-		dio_data.unsubmitted_oe_range_end = (u64)offset;
-		current->journal_info = &dio_data;
 		down_read(&BTRFS_I(inode)->dio_sem);
-	} else if (test_bit(BTRFS_INODE_READDIO_NEED_LOCK,
-				     &BTRFS_I(inode)->runtime_flags)) {
-		inode_dio_end(inode);
-		flags = DIO_LOCKING | DIO_SKIP_HOLES;
-		wakeup = false;
 	}
 
-	ret = __blockdev_direct_IO(iocb, inode,
-				   fs_info->fs_devices->latest_bdev,
-				   iter, btrfs_get_blocks_direct, NULL,
-				   btrfs_submit_direct, flags);
+	if (is_sync_kiocb(iocb))
+		flags |= IOMAP_DIO_RWF_SYNCIO;
+
+	ret = iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dops,
+			flags);
+
 	if (iov_iter_rw(iter) == WRITE) {
 		up_read(&BTRFS_I(inode)->dio_sem);
-		current->journal_info = NULL;
-		if (ret < 0 && ret != -EIOCBQUEUED) {
-			if (dio_data.reserve)
-				btrfs_delalloc_release_space(inode, data_reserved,
-					offset, dio_data.reserve, true);
-			/*
-			 * On error we might have left some ordered extents
-			 * without submitting corresponding bios for them, so
-			 * cleanup them up to avoid other tasks getting them
-			 * and waiting for them to complete forever.
-			 */
-			if (dio_data.unsubmitted_oe_range_start <
-			    dio_data.unsubmitted_oe_range_end)
-				__endio_write_update_ordered(inode,
-					dio_data.unsubmitted_oe_range_start,
-					dio_data.unsubmitted_oe_range_end -
-					dio_data.unsubmitted_oe_range_start,
-					false);
-		} else if (ret >= 0 && (size_t)ret < count)
-			btrfs_delalloc_release_space(inode, data_reserved,
-					offset, count - (size_t)ret, true);
-		btrfs_delalloc_release_extents(BTRFS_I(inode), count);
 	}
-out:
-	if (wakeup)
-		inode_dio_end(inode);
 	if (relock)
 		inode_lock(inode);
-
 	extent_changeset_free(data_reserved);
 	return ret;
 }
@@ -10246,7 +10227,7 @@ static const struct address_space_operations btrfs_aops = {
 	.writepage	= btrfs_writepage,
 	.writepages	= btrfs_writepages,
 	.readahead	= btrfs_readahead,
-	.direct_IO	= btrfs_direct_IO,
+	.direct_IO	= noop_direct_IO,
 	.invalidatepage = btrfs_invalidatepage,
 	.releasepage	= btrfs_releasepage,
 #ifdef CONFIG_MIGRATION
-- 
2.26.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8ED511442E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 16:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfLEP4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 10:56:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:35542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729790AbfLEP4r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:56:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C777CAE57;
        Thu,  5 Dec 2019 15:56:43 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, jthumshirn@suse.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Date:   Thu,  5 Dec 2019 09:56:26 -0600
Message-Id: <20191205155630.28817-5-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191205155630.28817-1-rgoldwyn@suse.de>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
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

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |   1 +
 fs/btrfs/file.c  |  21 ++++++-
 fs/btrfs/inode.c | 182 ++++++++++++++++++++++++++-----------------------------
 3 files changed, 107 insertions(+), 97 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fe2b8765d9e6..cde8423673fc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2903,6 +2903,7 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
+ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 435a502a3226..c9c83a1711ee 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1834,7 +1834,7 @@ static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	loff_t endbyte;
 	int err;
 
-	written = generic_file_direct_write(iocb, from);
+	written = btrfs_direct_IO(iocb, from);
 
 	if (written < 0 || !iov_iter_count(from))
 		return written;
@@ -3452,9 +3452,26 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
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
index 015910079e73..b4a297407672 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -29,6 +29,7 @@
 #include <linux/iversion.h>
 #include <linux/swap.h>
 #include <linux/sched/mm.h>
+#include <linux/iomap.h>
 #include <asm/unaligned.h>
 #include "misc.h"
 #include "ctree.h"
@@ -7479,7 +7480,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 }
 
 static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
-			      struct extent_state **cached_state, int writing)
+			      struct extent_state **cached_state, bool writing)
 {
 	struct btrfs_ordered_extent *ordered;
 	int ret = 0;
@@ -7619,28 +7620,7 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 }
 
 
-static int btrfs_get_blocks_direct_read(struct extent_map *em,
-					struct buffer_head *bh_result,
-					struct inode *inode,
-					u64 start, u64 len)
-{
-	if (em->block_start == EXTENT_MAP_HOLE ||
-			test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-		return -ENOENT;
-
-	len = min(len, em->len - (start - em->start));
-
-	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
-		inode->i_blkbits;
-	bh_result->b_size = len;
-	bh_result->b_bdev = em->bdev;
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
@@ -7702,7 +7682,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	}
 
 	/* this will cow the extent */
-	len = bh_result->b_size;
 	free_extent_map(em);
 	*map = em = btrfs_new_extent_direct(inode, start, len);
 	if (IS_ERR(em)) {
@@ -7713,15 +7692,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	len = min(len, em->len - (start - em->start));
 
 skip_cow:
-	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
-		inode->i_blkbits;
-	bh_result->b_size = len;
-	bh_result->b_bdev = em->bdev;
-	set_buffer_mapped(bh_result);
-
-	if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-		set_buffer_new(bh_result);
-
 	/*
 	 * Need to update the i_size under the extent lock so buffered
 	 * readers will get the updated i_size when we unlock.
@@ -7737,24 +7707,37 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	return ret;
 }
 
-static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
-				   struct buffer_head *bh_result, int create)
+static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
+		loff_t length, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_dio_data *dio_data = NULL;
-	u64 start = iblock << inode->i_blkbits;
 	u64 lockstart, lockend;
-	u64 len = bh_result->b_size;
+	bool write = !!(flags & IOMAP_WRITE);
 	int ret = 0;
+	u64 len = length;
+	bool unlock_extents = false;
 
-	if (!create)
+	if (!write)
 		len = min_t(u64, len, fs_info->sectorsize);
 
 	lockstart = start;
 	lockend = start + len - 1;
 
+	/*
+	 * The generic stuff only does filemap_write_and_wait_range, which
+	 * isn't enough if we've written compressed pages to this area, so
+	 * we need to flush the dirty pages again to make absolutely sure
+	 * that any outstanding dirty pages are on disk.
+	 */
+	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
+		     &BTRFS_I(inode)->runtime_flags))
+		ret = filemap_fdatawrite_range(inode->i_mapping, start,
+					 start + length - 1);
+
 	if (current->journal_info) {
 		/*
 		 * Need to pull our outstanding extents and set journal_info to NULL so
@@ -7770,7 +7753,7 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 	 * this range and we need to fallback to buffered.
 	 */
 	if (lock_extent_direct(inode, lockstart, lockend, &cached_state,
-			       create)) {
+			       write)) {
 		ret = -ENOTBLK;
 		goto err;
 	}
@@ -7802,36 +7785,53 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 		goto unlock_err;
 	}
 
-	if (create) {
-		ret = btrfs_get_blocks_direct_write(&em, bh_result, inode,
+	len = min(len, em->len - (start - em->start));
+	if (write) {
+		ret = btrfs_get_blocks_direct_write(&em, inode,
 						    dio_data, start, len);
 		if (ret < 0)
 			goto unlock_err;
-
-		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
-				     lockend, &cached_state);
+		unlock_extents = true;
+		/* Recalc len in case the new em is smaller than requested */
+		len = min(len, em->len - (start - em->start));
+	} else if (em->block_start == EXTENT_MAP_HOLE ||
+			test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
+		/* Unlock in case of direct reading from a hole */
+		unlock_extents = true;
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
+				lockstart, lockend, &cached_state);
+	else
+		free_extent_state(cached_state);
+
+	/*
+	 * Translate extent map information to iomap
+	 * We trim the extents (and move the addr) even though
+	 * iomap code does that, since we have locked only the parts
+	 * we are performing I/O in.
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
+	iomap->bdev = em->bdev;
+	iomap->length = len;
+
 	free_extent_map(em);
 
 	return 0;
@@ -8199,9 +8199,8 @@ static void btrfs_endio_direct_read(struct bio *bio)
 	kfree(dip);
 
 	dio_bio->bi_status = err;
-	dio_end_io(dio_bio);
+	bio_endio(dio_bio);
 	btrfs_io_bio_free_csum(io_bio);
-	bio_put(bio);
 }
 
 static void __endio_write_update_ordered(struct inode *inode,
@@ -8263,8 +8262,7 @@ static void btrfs_endio_direct_write(struct bio *bio)
 	kfree(dip);
 
 	dio_bio->bi_status = bio->bi_status;
-	dio_end_io(dio_bio);
-	bio_put(bio);
+	bio_endio(dio_bio);
 }
 
 static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
@@ -8496,9 +8494,10 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	return 0;
 }
 
-static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
+static blk_qc_t btrfs_submit_direct(struct bio *dio_bio, struct file *file,
 				loff_t file_offset)
 {
+	struct inode *inode = file_inode(file);
 	struct btrfs_dio_private *dip = NULL;
 	struct bio *bio = NULL;
 	struct btrfs_io_bio *io_bio;
@@ -8549,7 +8548,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 
 	ret = btrfs_submit_direct_hook(dip);
 	if (!ret)
-		return;
+		return BLK_QC_T_NONE;
 
 	btrfs_io_bio_free_csum(io_bio);
 
@@ -8568,7 +8567,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		/*
 		 * The end io callbacks free our dip, do the final put on bio
 		 * and all the cleanup and final put for dio_bio (through
-		 * dio_end_io()).
+		 * end_io()).
 		 */
 		dip = NULL;
 		bio = NULL;
@@ -8587,11 +8586,12 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		 * Releases and cleans up our dio_bio, no need to bio_put()
 		 * nor bio_endio()/bio_io_error() against dio_bio.
 		 */
-		dio_end_io(dio_bio);
+		bio_endio(dio_bio);
 	}
 	if (bio)
 		bio_put(bio);
 	kfree(dip);
+	return BLK_QC_T_NONE;
 }
 
 static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
@@ -8627,7 +8627,23 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 	return retval;
 }
 
-static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+static const struct iomap_ops btrfs_dio_iomap_ops = {
+	.iomap_begin            = btrfs_dio_iomap_begin,
+};
+
+static const struct iomap_dio_ops btrfs_dops = {
+	.submit_io		= btrfs_submit_direct,
+};
+
+
+/*
+ * btrfs_direct_IO - perform direct I/O
+ * inode->i_rwsem must be locked before calling this function, shared or exclusive.
+ * @iocb - kernel iocb
+ * @iter - iter to/from data is copied
+ */
+
+ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
@@ -8636,28 +8652,13 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct extent_changeset *data_reserved = NULL;
 	loff_t offset = iocb->ki_pos;
 	size_t count = 0;
-	int flags = 0;
-	bool wakeup = true;
 	bool relock = false;
 	ssize_t ret;
 
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
@@ -8688,17 +8689,11 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		dio_data.unsubmitted_oe_range_end = (u64)offset;
 		current->journal_info = &dio_data;
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
+	ret = iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dops,
+			is_sync_kiocb(iocb));
+
 	if (iov_iter_rw(iter) == WRITE) {
 		up_read(&BTRFS_I(inode)->dio_sem);
 		current->journal_info = NULL;
@@ -8725,11 +8720,8 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		btrfs_delalloc_release_extents(BTRFS_I(inode), count);
 	}
 out:
-	if (wakeup)
-		inode_dio_end(inode);
 	if (relock)
 		inode_lock(inode);
-
 	extent_changeset_free(data_reserved);
 	return ret;
 }
@@ -11019,7 +11011,7 @@ static const struct address_space_operations btrfs_aops = {
 	.writepage	= btrfs_writepage,
 	.writepages	= btrfs_writepages,
 	.readpages	= btrfs_readpages,
-	.direct_IO	= btrfs_direct_IO,
+	.direct_IO	= noop_direct_IO,
 	.invalidatepage = btrfs_invalidatepage,
 	.releasepage	= btrfs_releasepage,
 	.set_page_dirty	= btrfs_set_page_dirty,
-- 
2.16.4


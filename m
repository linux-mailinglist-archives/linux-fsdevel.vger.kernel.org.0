Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493E6A4BA8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfIAUJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 16:09:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:50714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727517AbfIAUJT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 16:09:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45DF0B661;
        Sun,  1 Sep 2019 20:09:16 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 14/15] btrfs: Remove btrfs_dio_data and __btrfs_direct_write
Date:   Sun,  1 Sep 2019 15:08:35 -0500
Message-Id: <20190901200836.14959-15-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190901200836.14959-1-rgoldwyn@suse.de>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_dio_data is unnecessary since we are now storing all
informaiton in btrfs_iomap.

Advantage: We don't abuse current->journal_info anymore :)
---
 fs/btrfs/file.c  | 40 ----------------------------
 fs/btrfs/inode.c | 81 ++------------------------------------------------------
 2 files changed, 2 insertions(+), 119 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5d4347e12cdc..e6c1ffd74660 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1350,46 +1350,6 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	return ret;
 }
 
-static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file_inode(file);
-	loff_t pos;
-	ssize_t written;
-	ssize_t written_buffered;
-	loff_t endbyte;
-	int err;
-
-	written = generic_file_direct_write(iocb, from);
-
-	if (written < 0 || !iov_iter_count(from))
-		return written;
-
-	pos = iocb->ki_pos;
-	written_buffered = btrfs_buffered_iomap_write(iocb, from);
-	if (written_buffered < 0) {
-		err = written_buffered;
-		goto out;
-	}
-	/*
-	 * Ensure all data is persisted. We want the next direct IO read to be
-	 * able to read what was just written.
-	 */
-	endbyte = pos + written_buffered - 1;
-	err = btrfs_fdatawrite_range(inode, pos, endbyte);
-	if (err)
-		goto out;
-	err = filemap_fdatawait_range(inode->i_mapping, pos, endbyte);
-	if (err)
-		goto out;
-	written += written_buffered;
-	iocb->ki_pos = pos + written_buffered;
-	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
-				 endbyte >> PAGE_SHIFT);
-out:
-	return written ? written : err;
-}
-
 static void update_time_for_write(struct inode *inode)
 {
 	struct timespec64 now;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 323d72858c9c..87fbe73ca2e4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -54,13 +54,6 @@ struct btrfs_iget_args {
 	struct btrfs_root *root;
 };
 
-struct btrfs_dio_data {
-	u64 reserve;
-	u64 unsubmitted_oe_range_start;
-	u64 unsubmitted_oe_range_end;
-	int overwrite;
-};
-
 static const struct inode_operations btrfs_dir_inode_operations;
 static const struct inode_operations btrfs_symlink_inode_operations;
 static const struct inode_operations btrfs_dir_ro_inode_operations;
@@ -7664,7 +7657,6 @@ int btrfs_get_extent_map_write(struct extent_map **map,
 static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					 struct buffer_head *bh_result,
 					 struct inode *inode,
-					 struct btrfs_dio_data *dio_data,
 					 u64 start, u64 len)
 {
 	int ret;
@@ -7686,17 +7678,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 		set_buffer_new(bh_result);
 
-	/*
-	 * Need to update the i_size under the extent lock so buffered
-	 * readers will get the updated i_size when we unlock.
-	 */
-	if (!dio_data->overwrite && start + len > i_size_read(inode))
-		i_size_write(inode, start + len);
-
-	WARN_ON(dio_data->reserve < len);
-	dio_data->reserve -= len;
-	dio_data->unsubmitted_oe_range_end = start + len;
-	current->journal_info = dio_data;
 	return ret;
 }
 
@@ -7706,7 +7687,6 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
-	struct btrfs_dio_data *dio_data = NULL;
 	u64 start = iblock << inode->i_blkbits;
 	u64 lockstart, lockend;
 	u64 len = bh_result->b_size;
@@ -7721,16 +7701,6 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
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
-	}
-
 	/*
 	 * If this errors out it's because we couldn't invalidate pagecache for
 	 * this range and we need to fallback to buffered.
@@ -7770,7 +7740,7 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 
 	if (create) {
 		ret = btrfs_get_blocks_direct_write(&em, bh_result, inode,
-						    dio_data, start, len);
+						    start, len);
 		if (ret < 0)
 			goto unlock_err;
 
@@ -7808,8 +7778,6 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			 unlock_bits, 1, 0, &cached_state);
 err:
-	if (dio_data)
-		current->journal_info = dio_data;
 	return ret;
 }
 
@@ -8498,21 +8466,6 @@ void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		dip->subio_endio = btrfs_subio_endio_read;
 	}
 
-	/*
-	 * Reset the range for unsubmitted ordered extents (to a 0 length range)
-	 * even if we fail to submit a bio, because in such case we do the
-	 * corresponding error handling below and it must not be done a second
-	 * time by btrfs_direct_IO().
-	 */
-	if (write) {
-		struct btrfs_dio_data *dio_data = current->journal_info;
-
-		dio_data->unsubmitted_oe_range_end = dip->logical_offset +
-			dip->bytes;
-		dio_data->unsubmitted_oe_range_start =
-			dio_data->unsubmitted_oe_range_end;
-	}
-
 	ret = btrfs_submit_direct_hook(dip);
 	if (!ret)
 		return;
@@ -8598,7 +8551,6 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_dio_data dio_data = { 0 };
 	struct extent_changeset *data_reserved = NULL;
 	loff_t offset = iocb->ki_pos;
 	size_t count = 0;
@@ -8631,7 +8583,6 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		 * not unlock the i_mutex at this case.
 		 */
 		if (offset + count <= inode->i_size) {
-			dio_data.overwrite = 1;
 			inode_unlock(inode);
 			relock = true;
 		} else if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -8643,16 +8594,6 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		if (ret)
 			goto out;
 
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
 	} else if (test_bit(BTRFS_INODE_READDIO_NEED_LOCK,
 				     &BTRFS_I(inode)->runtime_flags)) {
@@ -8667,25 +8608,7 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 				   btrfs_submit_direct, flags);
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
-				btrfs_update_ordered_extent(inode,
-					dio_data.unsubmitted_oe_range_start,
-					dio_data.unsubmitted_oe_range_end -
-					dio_data.unsubmitted_oe_range_start,
-					false);
-		} else if (ret >= 0 && (size_t)ret < count)
+		if (ret >= 0 && (size_t)ret < count)
 			btrfs_delalloc_release_space(inode, data_reserved,
 					offset, count - (size_t)ret, true);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), count, false);
-- 
2.16.4


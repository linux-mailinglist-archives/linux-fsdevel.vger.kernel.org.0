Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1711EB65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 20:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfLMT6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 14:58:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:59038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728891AbfLMT6N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:58:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AB53B2BD;
        Fri, 13 Dec 2019 19:58:10 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        nborisov@suse.com, dsterba@suse.cz, jthumshirn@suse.de,
        linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 7/8] btrfs: Use ->iomap_end() instead of btrfs_dio_data
Date:   Fri, 13 Dec 2019 13:57:49 -0600
Message-Id: <20191213195750.32184-8-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191213195750.32184-1-rgoldwyn@suse.de>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Use iomap->iomap_end() to check for failed or incomplete writes and call
__endio_write_update_ordered(). We don't need btrfs_dio_data anymore so
remove that. The bonus is we don't abuse current->journal_info anymore.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 89 ++++++++++----------------------------------------------
 1 file changed, 16 insertions(+), 73 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 276f3f2f26f3..07220194ffb8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -56,13 +56,6 @@ struct btrfs_iget_args {
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
@@ -7651,7 +7644,6 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 
 static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					 struct inode *inode,
-					 struct btrfs_dio_data *dio_data,
 					 u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -7725,13 +7717,9 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	 * Need to update the i_size under the extent lock so buffered
 	 * readers will get the updated i_size when we unlock.
 	 */
-	if (!dio_data->overwrite && start + len > i_size_read(inode))
+	if (start + len > i_size_read(inode))
 		i_size_write(inode, start + len);
 
-	WARN_ON(dio_data->reserve < len);
-	dio_data->reserve -= len;
-	dio_data->unsubmitted_oe_range_end = start + len;
-	current->journal_info = dio_data;
 out:
 	return ret;
 }
@@ -7743,7 +7731,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
-	struct btrfs_dio_data *dio_data = NULL;
 	u64 lockstart, lockend;
 	bool write = !!(flags & IOMAP_WRITE);
 	int ret = 0;
@@ -7767,16 +7754,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		ret = filemap_fdatawrite_range(inode->i_mapping, start,
 					 start + length - 1);
 
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
@@ -7817,7 +7794,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	len = min(len, em->len - (start - em->start));
 	if (write) {
 		ret = btrfs_get_blocks_direct_write(&em, inode,
-						    dio_data, start, len);
+						    start, len);
 		if (ret < 0)
 			goto unlock_err;
 		unlock_extents = true;
@@ -7869,11 +7846,21 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			     &cached_state);
 err:
-	if (dio_data)
-		current->journal_info = dio_data;
 	return ret;
 }
 
+static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+		ssize_t written, unsigned flags, struct iomap *iomap)
+{
+	if (!(flags & IOMAP_WRITE))
+		return 0;
+
+	if (written < length)
+		__endio_write_update_ordered(inode, pos + written,
+				length - written, false);
+	return 0;
+}
+
 static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
 						 struct bio *bio,
 						 int mirror_num)
@@ -8555,21 +8542,6 @@ static blk_qc_t btrfs_submit_direct(struct bio *dio_bio, struct file *file,
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
 		return BLK_QC_T_NONE;
@@ -8649,6 +8621,7 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_begin            = btrfs_dio_iomap_begin,
+	.iomap_end		= btrfs_dio_iomap_end,
 };
 
 static const struct iomap_dio_ops btrfs_dops = {
@@ -8668,7 +8641,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_dio_data dio_data = { 0 };
 	struct extent_changeset *data_reserved = NULL;
 	loff_t offset = iocb->ki_pos;
 	size_t count = 0;
@@ -8688,7 +8660,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		 * not unlock the i_mutex at this case.
 		 */
 		if (offset + count <= inode->i_size) {
-			dio_data.overwrite = 1;
 			inode_unlock(inode);
 			relock = true;
 		} else if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -8700,16 +8671,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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
 	}
 
@@ -8718,25 +8679,7 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
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
+		if (ret >= 0 && (size_t)ret < count)
 			btrfs_delalloc_release_space(inode, data_reserved,
 					offset, count - (size_t)ret, true);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), count);
-- 
2.16.4


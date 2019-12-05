Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0782E114434
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 16:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfLEP4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 10:56:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:35620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729896AbfLEP4w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:56:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CE10AD98;
        Thu,  5 Dec 2019 15:56:50 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, jthumshirn@suse.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 7/8] btrfs: Remove btrfs_dio_data
Date:   Thu,  5 Dec 2019 09:56:29 -0600
Message-Id: <20191205155630.28817-8-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191205155630.28817-1-rgoldwyn@suse.de>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since, we are using iomap, we don't get multiple calls for get_blocks(),
and there is no incomplete ordered extents. So, remove btrfs_dio_data
and all its manipulations. The bonus is we don't abuse
current->journal_info anymore.

This reverts f28a49287817 ("Btrfs: fix leaking of ordered extents after
direct IO write error")

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 76 +++-----------------------------------------------------
 1 file changed, 3 insertions(+), 73 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f619b5f6a095..fedbbcf108cf 100644
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
@@ -7622,7 +7615,6 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 
 static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					 struct inode *inode,
-					 struct btrfs_dio_data *dio_data,
 					 u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -7696,13 +7688,9 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
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
@@ -7714,7 +7702,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
-	struct btrfs_dio_data *dio_data = NULL;
 	u64 lockstart, lockend;
 	bool write = !!(flags & IOMAP_WRITE);
 	int ret = 0;
@@ -7738,16 +7725,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
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
@@ -7788,7 +7765,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	len = min(len, em->len - (start - em->start));
 	if (write) {
 		ret = btrfs_get_blocks_direct_write(&em, inode,
-						    dio_data, start, len);
+						    start, len);
 		if (ret < 0)
 			goto unlock_err;
 		unlock_extents = true;
@@ -7840,8 +7817,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			     &cached_state);
 err:
-	if (dio_data)
-		current->journal_info = dio_data;
 	return ret;
 }
 
@@ -8531,21 +8506,6 @@ static blk_qc_t btrfs_submit_direct(struct bio *dio_bio, struct file *file,
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
@@ -8648,7 +8608,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_dio_data dio_data = { 0 };
 	struct extent_changeset *data_reserved = NULL;
 	loff_t offset = iocb->ki_pos;
 	size_t count = 0;
@@ -8666,7 +8625,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		 * not unlock the i_mutex at this case.
 		 */
 		if (offset + count <= inode->i_size) {
-			dio_data.overwrite = 1;
 			inode_unlock(inode);
 			relock = true;
 		} else if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -8678,16 +8636,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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
 
@@ -8696,25 +8644,7 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
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


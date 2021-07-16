Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863DF3CB8E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 16:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbhGPOnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 10:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240194AbhGPOnp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:43:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C1F161406;
        Fri, 16 Jul 2021 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626446450;
        bh=aw4O7H66/f2LfOr5ltGk8A3nBKyRFz2VLyMrawYdLsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krh0VESz4Kjd88k9e6OiXT2L80R84tOL3XuT6WS+uiDOnZRizAcCLjS8C8Wd052qe
         vZcMHvxcKAUI/e9WJBZ9xFCVLzHJvaG8Nh6MfPuLCyeb4CtPr1ZoEaE3uyRmSIkIfy
         fWv5WgcUq25ytImHiC+13Qf+6ahzQNKgAVsXbSJm0IYj5ybpHE3o4/b40CBqs3bHdh
         7fLD914XW50bVv0eJLxTzTvUzVrPrvkD7qhExBDwBJzVO2/VDEuGhFUH7YI7JXs9YO
         vi62IeE2r2YXUd0r7AibZF/r5a7s/9VoWbpW+XxdfvhN40l/+c9OVdhAiByYhmDvqO
         Pmzy6+cBRFdEA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH 9/9] f2fs: remove f2fs_direct_IO()
Date:   Fri, 16 Jul 2021 09:39:19 -0500
Message-Id: <20210716143919.44373-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716143919.44373-1-ebiggers@kernel.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Remove f2fs_direct_IO(), since it is no longer used because f2fs now
uses iomap_dio_rw() instead.

Set ->direct_IO to noop_direct_IO rather than NULL.  This is needed to
continue to mark the inodes as supporting direct I/O, as mentioned in
the comment for noop_direct_IO().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/data.c | 180 +------------------------------------------------
 1 file changed, 1 insertion(+), 179 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0d2bb651483d..4fbf28f5aaab 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1650,47 +1650,6 @@ static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
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
@@ -3410,29 +3369,6 @@ static int f2fs_write_end(struct file *file,
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
 static void f2fs_dio_end_io(struct bio *bio)
 {
 	struct f2fs_private_dio *dio = bio->bi_private;
@@ -3448,35 +3384,6 @@ static void f2fs_dio_end_io(struct bio *bio)
 	bio_endio(bio);
 }
 
-static void f2fs_dio_submit_bio_old(struct bio *bio, struct inode *inode,
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
 static blk_qc_t f2fs_dio_submit_bio(struct inode *inode, struct iomap *iomap,
 				    struct bio *bio, loff_t file_offset)
 {
@@ -3506,91 +3413,6 @@ static blk_qc_t f2fs_dio_submit_bio(struct inode *inode, struct iomap *iomap,
 	return BLK_QC_T_NONE;
 }
 
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
-	do_opu = (rw == WRITE && f2fs_lfs_mode(sbi));
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
-			get_data_block_dio, NULL, f2fs_dio_submit_bio_old,
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
@@ -4046,7 +3868,7 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.set_page_dirty	= f2fs_set_data_page_dirty,
 	.invalidatepage	= f2fs_invalidate_page,
 	.releasepage	= f2fs_release_page,
-	.direct_IO	= f2fs_direct_IO,
+	.direct_IO	= noop_direct_IO,
 	.bmap		= f2fs_bmap,
 	.swap_activate  = f2fs_swap_activate,
 	.swap_deactivate = f2fs_swap_deactivate,
-- 
2.32.0


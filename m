Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFCE104367
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 19:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfKTSZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 13:25:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41516 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbfKTSZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:25:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id t8so77586plr.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 10:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=komBlf2A1Mk9wvmTi33yupnzrPAC6Z36n5e71K3zkls=;
        b=UJ7wqgQrIRpTrGVOQbVdnW90YXRToGOxytNj//0AoO6m4b6sFGqDbYB7kmzeqObI9A
         NOwGHCCcx6qqORdPk6RaCVkQ+4OAKV8geDKdYECKo747pHVVqWjx26LXtiDLLpDi4CkF
         uLb1Luo+5A7aVJf2ymYfNrSeW1yx6lFE90cDf62LGJ2aZARvi6f4xPRTck1J9gBvKWoB
         ynEmEXrryLZrwSfYsG4fo+R2zR2UgwiTEt9rTvXchT8FLLSR1NlYXvBA+IU+vcOFGq/V
         EZpy58VkuLxlLCoMgbPKnGE7BMyoz6ByGO8R8o9JIg1FwXxnJit8Vqioy/RcU2RjRFIk
         h+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=komBlf2A1Mk9wvmTi33yupnzrPAC6Z36n5e71K3zkls=;
        b=AcEspA8nMt65QIaS3X5XXm9FARjA1uwT4BqkZwUzc4OyZZ0DdyNjfkx+BkP1wMODQI
         e4MRFiBa0NyLfcGR35TSvePRifDy0oEoDsZT09Ge4rNLxHCiAHskczS+FATpB3FVWbA7
         7q9zGyb/A1GaGrntDdEeYPiR20jd+VO40oHi+38C1ARLdUWPnoLZK/6bq3sjpzHwN7y1
         oGM88R81SPb+9isgRgFtD0Z1dmoLWTYjpnGVF2mL6rqC2TmA32DJjtbgc0YB3ycJJSGH
         uTVc7AFmDvMW0e7mI/638sgPFdzBY8g6b2EXxnwxlt8Mq8FVb9+VP33SGTStM0CqDxG4
         UM7Q==
X-Gm-Message-State: APjAAAW/7b8c2LA2hbtEeQRNXaOk4Djb5hntYUSmXLusYctcBtdx5Mjq
        /6bzXZdsD7IPm7T1Gaz46q2eTz1wRfI=
X-Google-Smtp-Source: APXvYqwC2W4Nh0GjIjxkoVWJ/Wf6ywNxiy7xTM53FRW5lgjfiXDoJ0ZI12WNpe7+RlzshLMVeWiGnA==
X-Received: by 2002:a17:902:7586:: with SMTP id j6mr4343930pll.43.1574274306754;
        Wed, 20 Nov 2019 10:25:06 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:25:06 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 12/12] btrfs: implement RWF_ENCODED writes
Date:   Wed, 20 Nov 2019 10:24:32 -0800
Message-Id: <3252074cdd88bfaea491d3f22a75099970b314b5.1574273658.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574273658.git.osandov@fb.com>
References: <cover.1574273658.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The implementation resembles direct I/O: we have to flush any ordered
extents, invalidate the page cache, and do the io tree/delalloc/extent
map/ordered extent dance. From there, we can reuse the compression code
with a minor modification to distinguish the write from writeback. This
also creates inline extents when possible.

Now that read and write are implemented, this also sets the
FMODE_ENCODED_IO flag in btrfs_file_open().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c  |   6 +-
 fs/btrfs/compression.h  |   5 +-
 fs/btrfs/ctree.h        |   2 +
 fs/btrfs/file.c         |  40 +++++--
 fs/btrfs/inode.c        | 243 +++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ordered-data.c |  12 +-
 fs/btrfs/ordered-data.h |   2 +
 7 files changed, 293 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 05b6e404a291..ae24e8c5ea34 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -276,7 +276,8 @@ static void end_compressed_bio_write(struct bio *bio)
 			bio->bi_status == BLK_STS_OK);
 	cb->compressed_pages[0]->mapping = NULL;
 
-	end_compressed_writeback(inode, cb);
+	if (cb->writeback)
+		end_compressed_writeback(inode, cb);
 	/* note, our inode could be gone now */
 
 	/*
@@ -311,7 +312,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				 unsigned long compressed_len,
 				 struct page **compressed_pages,
 				 unsigned long nr_pages,
-				 unsigned int write_flags)
+				 unsigned int write_flags, bool writeback)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio *bio = NULL;
@@ -336,6 +337,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	cb->mirror_num = 0;
 	cb->compressed_pages = compressed_pages;
 	cb->compressed_len = compressed_len;
+	cb->writeback = writeback;
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 4cb8be9ff88b..d4176384ec15 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -47,6 +47,9 @@ struct compressed_bio {
 	/* the compression algorithm for this bio */
 	int compress_type;
 
+	/* Whether this is a write for writeback. */
+	bool writeback;
+
 	/* number of compressed pages in the array */
 	unsigned long nr_pages;
 
@@ -93,7 +96,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				  unsigned long compressed_len,
 				  struct page **compressed_pages,
 				  unsigned long nr_pages,
-				  unsigned int write_flags);
+				  unsigned int write_flags, bool writeback);
 blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3be72a6e022e..3c020dbe894a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2902,6 +2902,8 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			    struct encoded_iov *encoded);
 
 extern const struct dentry_operations btrfs_dentry_operations;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5425200092c2..16d8df66378f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1893,8 +1893,7 @@ static void update_time_for_write(struct inode *inode)
 		inode_inc_iversion(inode);
 }
 
-static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
-				    struct iov_iter *from)
+static ssize_t btrfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
@@ -1904,30 +1903,51 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	u64 end_pos;
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
+	struct encoded_iov encoded;
 	ssize_t err;
 	loff_t pos;
 	size_t count;
 	loff_t oldsize;
 	int clean_page = 0;
 
-	if (!(iocb->ki_flags & IOCB_DIRECT) &&
-	    (iocb->ki_flags & IOCB_NOWAIT))
+	if ((iocb->ki_flags & IOCB_NOWAIT) &&
+	    (!(iocb->ki_flags & IOCB_DIRECT) ||
+	     (iocb->ki_flags & IOCB_ENCODED)))
 		return -EOPNOTSUPP;
 
+	if (iocb->ki_flags & IOCB_ENCODED) {
+		err = copy_encoded_iov_from_iter(&encoded, from);
+		if (err)
+			return err;
+	}
+
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return -EAGAIN;
 		inode_lock(inode);
 	}
 
-	err = generic_write_checks(iocb, from);
-	if (err <= 0) {
+	if (iocb->ki_flags & IOCB_ENCODED) {
+		err = generic_encoded_write_checks(iocb, &encoded);
+		if (err) {
+			inode_unlock(inode);
+			return err;
+		}
+		count = encoded.len;
+	} else {
+		err = generic_write_checks(iocb, from);
+		if (err < 0) {
+			inode_unlock(inode);
+			return err;
+		}
+		count = iov_iter_count(from);
+	}
+	if (count == 0) {
 		inode_unlock(inode);
 		return err;
 	}
 
 	pos = iocb->ki_pos;
-	count = iov_iter_count(from);
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		/*
 		 * We will allocate space in case nodatacow is not set,
@@ -1986,7 +2006,9 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	if (sync)
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
+	if (iocb->ki_flags & IOCB_ENCODED) {
+		num_written = btrfs_encoded_write(iocb, from, &encoded);
+	} else if (iocb->ki_flags & IOCB_DIRECT) {
 		num_written = __btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
@@ -3459,7 +3481,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_ENCODED_IO;
 	return generic_file_open(inode, filp);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 698e24aa8b21..b9b410af6d0d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -868,7 +868,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				    ins.objectid,
 				    ins.offset, async_extent->pages,
 				    async_extent->nr_pages,
-				    async_chunk->write_flags)) {
+				    async_chunk->write_flags, true)) {
 			struct page *p = async_extent->pages[0];
 			const u64 start = async_extent->start;
 			const u64 end = start + async_extent->ram_size - 1;
@@ -2392,7 +2392,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 	    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags) &&
-	    !test_bit(BTRFS_ORDERED_DIRECT, &ordered_extent->flags))
+	    !test_bit(BTRFS_ORDERED_DIRECT, &ordered_extent->flags) &&
+	    !test_bit(BTRFS_ORDERED_ENCODED, &ordered_extent->flags))
 		clear_new_delalloc_bytes = true;
 
 	nolock = btrfs_is_free_space_inode(BTRFS_I(inode));
@@ -10397,6 +10398,244 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			    struct encoded_iov *encoded)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct extent_changeset *data_reserved = NULL;
+	struct extent_state *cached_state = NULL;
+	int compression;
+	size_t orig_count;
+	u64 start, end;
+	u64 num_bytes, ram_bytes, disk_num_bytes;
+	unsigned long nr_pages, i;
+	struct page **pages;
+	struct btrfs_key ins;
+	bool extent_reserved = false;
+	struct extent_map *em;
+	ssize_t ret;
+
+	switch (encoded->compression) {
+	case ENCODED_IOV_COMPRESSION_ZLIB:
+		compression = BTRFS_COMPRESS_ZLIB;
+		break;
+	case ENCODED_IOV_COMPRESSION_LZO:
+		compression = BTRFS_COMPRESS_LZO;
+		break;
+	case ENCODED_IOV_COMPRESSION_ZSTD:
+		compression = BTRFS_COMPRESS_ZSTD;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (encoded->encryption != ENCODED_IOV_ENCRYPTION_NONE)
+		return -EINVAL;
+
+	orig_count = iov_iter_count(from);
+
+	/* The extent size must be sane. */
+	if (encoded->unencoded_len > BTRFS_MAX_UNCOMPRESSED ||
+	    orig_count > BTRFS_MAX_COMPRESSED || orig_count == 0)
+		return -EINVAL;
+
+	/*
+	 * The compressed data must be smaller than the decompressed data.
+	 *
+	 * It's of course possible for data to compress to larger or the same
+	 * size, but the buffered I/O path falls back to no compression for such
+	 * data, and we don't want to break any assumptions by creating these
+	 * extents.
+	 *
+	 * Note that this is less strict than the current check we have that the
+	 * compressed data must be at least one sector smaller than the
+	 * decompressed data. We only want to enforce the weaker requirement
+	 * from old kernels that it is at least one byte smaller.
+	 */
+	if (orig_count >= encoded->unencoded_len)
+		return -EINVAL;
+
+	/* The extent must start on a sector boundary. */
+	start = iocb->ki_pos;
+	if (!IS_ALIGNED(start, fs_info->sectorsize))
+		return -EINVAL;
+
+	/*
+	 * The extent must end on a sector boundary. However, we allow a write
+	 * which ends at or extends i_size to have an unaligned length; we round
+	 * up the extent size and set i_size to the unaligned end.
+	 */
+	if (start + encoded->len < inode->i_size &&
+	    !IS_ALIGNED(start + encoded->len, fs_info->sectorsize))
+		return -EINVAL;
+
+	/* Finally, the offset in the unencoded data must be sector-aligned. */
+	if (!IS_ALIGNED(encoded->unencoded_offset, fs_info->sectorsize))
+		return -EINVAL;
+
+	num_bytes = ALIGN(encoded->len, fs_info->sectorsize);
+	ram_bytes = ALIGN(encoded->unencoded_len, fs_info->sectorsize);
+	end = start + num_bytes - 1;
+
+	/*
+	 * If the extent cannot be inline, the compressed data on disk must be
+	 * sector-aligned. For convenience, we extend it with zeroes if it
+	 * isn't.
+	 */
+	disk_num_bytes = ALIGN(orig_count, fs_info->sectorsize);
+	nr_pages = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
+	pages = kvcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
+	if (!pages)
+		return -ENOMEM;
+	for (i = 0; i < nr_pages; i++) {
+		size_t bytes = min_t(size_t, PAGE_SIZE, iov_iter_count(from));
+		char *kaddr;
+
+		pages[i] = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_HIGHMEM);
+		if (!pages[i]) {
+			ret = -ENOMEM;
+			goto out_pages;
+		}
+		kaddr = kmap(pages[i]);
+		if (copy_from_iter(kaddr, bytes, from) != bytes) {
+			kunmap(pages[i]);
+			ret = -EFAULT;
+			goto out_pages;
+		}
+		if (bytes < PAGE_SIZE)
+			memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
+		kunmap(pages[i]);
+	}
+
+	for (;;) {
+		struct btrfs_ordered_extent *ordered;
+
+		ret = btrfs_wait_ordered_range(inode, start, num_bytes);
+		if (ret)
+			goto out_pages;
+		ret = invalidate_inode_pages2_range(inode->i_mapping,
+						    start >> PAGE_SHIFT,
+						    end >> PAGE_SHIFT);
+		if (ret)
+			goto out_pages;
+		lock_extent_bits(io_tree, start, end, &cached_state);
+		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
+						     num_bytes);
+		if (!ordered &&
+		    !filemap_range_has_page(inode->i_mapping, start, end))
+			break;
+		if (ordered)
+			btrfs_put_ordered_extent(ordered);
+		unlock_extent_cached(io_tree, start, end, &cached_state);
+		cond_resched();
+	}
+
+	ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode), disk_num_bytes);
+	if (ret)
+		goto out_unlock;
+	ret = btrfs_qgroup_reserve_data(inode, &data_reserved, start,
+					num_bytes);
+	if (ret)
+		goto out_free_data_space;
+	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), num_bytes,
+					      disk_num_bytes);
+	if (ret)
+		goto out_qgroup_free_data;
+
+	/* Try an inline extent first. */
+	if (start == 0 && encoded->unencoded_len == encoded->len &&
+	    encoded->unencoded_offset == 0) {
+		ret = cow_file_range_inline(inode, encoded->len, orig_count,
+					    compression, pages, true);
+		if (ret <= 0) {
+			if (ret == 0)
+				ret = orig_count;
+			goto out_delalloc_release;
+		}
+	}
+
+	ret = btrfs_reserve_extent(root, disk_num_bytes, disk_num_bytes,
+				   disk_num_bytes, 0, 0, &ins, 1, 1);
+	if (ret)
+		goto out_delalloc_release;
+	extent_reserved = true;
+
+	em = create_io_em(inode, start, num_bytes,
+			  start - encoded->unencoded_offset, ins.objectid,
+			  ins.offset, ins.offset, ram_bytes, compression,
+			  BTRFS_ORDERED_COMPRESSED);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto out_free_reserved;
+	}
+	free_extent_map(em);
+
+	ret = btrfs_add_ordered_extent(inode, start, num_bytes, ram_bytes,
+				       ins.objectid, ins.offset,
+				       encoded->unencoded_offset,
+				       (1 << BTRFS_ORDERED_ENCODED) |
+				       (1 << BTRFS_ORDERED_COMPRESSED),
+				       compression);
+	if (ret) {
+		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
+		goto out_free_reserved;
+	}
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+
+	if (start + encoded->len > inode->i_size)
+		i_size_write(inode, start + encoded->len);
+
+	unlock_extent_cached(io_tree, start, end, &cached_state);
+
+	btrfs_delalloc_release_extents(BTRFS_I(inode), num_bytes);
+
+	if (btrfs_submit_compressed_write(inode, start, num_bytes, ins.objectid,
+					  ins.offset, pages, nr_pages, 0,
+					  false)) {
+		struct page *page = pages[0];
+
+		page->mapping = inode->i_mapping;
+		btrfs_writepage_endio_finish_ordered(page, start, end, 0);
+		page->mapping = NULL;
+		ret = -EIO;
+		goto out_pages;
+	}
+	ret = orig_count;
+	goto out;
+
+out_free_reserved:
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
+out_delalloc_release:
+	btrfs_delalloc_release_extents(BTRFS_I(inode), num_bytes);
+	btrfs_delalloc_release_metadata(BTRFS_I(inode), disk_num_bytes,
+					ret < 0);
+out_qgroup_free_data:
+	if (ret < 0)
+		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes);
+out_free_data_space:
+	/*
+	 * If btrfs_reserve_extent() succeeded, then we already decremented
+	 * bytes_may_use.
+	 */
+	if (!extent_reserved)
+		btrfs_free_reserved_data_space_noquota(fs_info, disk_num_bytes);
+out_unlock:
+	unlock_extent_cached(io_tree, start, end, &cached_state);
+out_pages:
+	for (i = 0; i < nr_pages; i++) {
+		if (pages[i])
+			put_page(pages[i]);
+	}
+	kvfree(pages);
+out:
+	if (ret >= 0)
+		iocb->ki_pos += encoded->len;
+	return ret;
+}
+
 #ifdef CONFIG_SWAP
 /*
  * Add an entry indicating a block group or device which is pinned by a
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 3c6edc307657..1e52105c4c1a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -451,9 +451,15 @@ void btrfs_remove_ordered_extent(struct inode *inode,
 	spin_lock(&btrfs_inode->lock);
 	btrfs_mod_outstanding_extents(btrfs_inode, -1);
 	spin_unlock(&btrfs_inode->lock);
-	if (root != fs_info->tree_root)
-		btrfs_delalloc_release_metadata(btrfs_inode, entry->num_bytes,
-						false);
+	if (root != fs_info->tree_root) {
+		u64 release;
+
+		if (test_bit(BTRFS_ORDERED_ENCODED, &entry->flags))
+			release = entry->disk_num_bytes;
+		else
+			release = entry->num_bytes;
+		btrfs_delalloc_release_metadata(btrfs_inode, release, false);
+	}
 
 	if (test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
 		percpu_counter_add_batch(&fs_info->dio_bytes, -entry->num_bytes,
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index a038bda16fdf..0079ce49bc5e 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -61,6 +61,8 @@ enum {
 	BTRFS_ORDERED_TRUNCATED,
 	/* Regular IO for COW */
 	BTRFS_ORDERED_REGULAR,
+	/* RWF_ENCODED I/O */
+	BTRFS_ORDERED_ENCODED,
 };
 
 struct btrfs_ordered_extent {
-- 
2.24.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D772D7F49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389253AbfJOSnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:43:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37993 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389248AbfJOSnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:43:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so13034213pfe.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZLb2b0RCY7vgqstSQB8MBGrqVqeAFbGAfT3ja1UqaE=;
        b=UOyI7e/ypYxPrLB8Zk/fVQLxcKYbWvSCZojN6gcbranfCajXKZ10J10Ivx9vo4mKud
         DHdWAfMSC5+L+vqfMf0O5Lwu2VTgM7qpc2Oqhgpx0GFa4c71cFduoV36W4lgBjKZoh/Z
         rnPZvVeCaoDVOWOVwCTvvcWkbjwYT2aCQJmFyqJgY4Wlejha/N9fbXJdxuuygEaGnysn
         Bo5lpX9c8J/7jAof4zYWDAsDwfGzQXsN2gAOdkng6fI/1gdJwvI1CVK8R5wiLuE+gZiy
         D9Hj6qHSv6rZOvu7QfUPOhQxH0QY0SyWIzkF3XnO55q3N7xHeI9zY14Ct/e5KsuXpaX2
         1XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZLb2b0RCY7vgqstSQB8MBGrqVqeAFbGAfT3ja1UqaE=;
        b=rKSYHKHmeNaRMy/hcdksip23enZT4n8UAGLP2XYzK2pjJ9itqT8Cq1BomHChatgTGb
         9zw9VMaB+IX/tB35ENIzeYonhJh/9lGySTpyOYcSuXLuqoeMtKSa/BD0UybnfB3Is6Wa
         RbxpSPeMS8t8P5Yxg02Y3GzD9s3282uJJKuzgxXTW2Zcx5Udv/9F7erXtWEabVevLrBf
         3lSdSC1JDnAN8uxoCzGBd7awAMNPNF+QUJwEvsJPXk/wH9r9IbLo+TEDVO18AzL1bk1z
         mUignJ1pjjeorXtTKijUCkyUiyrc2pkq5eFW5e2lITJ4gSRUR5Z3Sx2j1zSAAIBIhf3z
         0Uww==
X-Gm-Message-State: APjAAAWiPdv9+CjwV51uulQiFcXyqrXrPkujkBU+dBusdNKiXhhF/z8B
        ziw4kVljmP7TWzndPRlpZU0Y+x4Qbyo=
X-Google-Smtp-Source: APXvYqwCDgtP8XXNWpoB+tpyk6j82dFhTvvvAL9XwAdITjx7TvKLrOWF3LU0LO6N/bKnTqfd2dDlUg==
X-Received: by 2002:aa7:9157:: with SMTP id 23mr40795567pfi.61.1571164988222;
        Tue, 15 Oct 2019 11:43:08 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:3e5e])
        by smtp.gmail.com with ESMTPSA id z3sm40396pjd.25.2019.10.15.11.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:43:07 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH v2 4/5] btrfs: implement RWF_ENCODED reads
Date:   Tue, 15 Oct 2019 11:42:42 -0700
Message-Id: <338d3b28dd31249053620b83e6ff190ad965fadc.1571164762.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571164762.git.osandov@fb.com>
References: <cover.1571164762.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

There are 4 main cases:

1. Inline extents: we copy the data straight out of the extent buffer.
2. Hole/preallocated extents: we indicate the size of the extent
   starting from the read position; we don't need to copy zeroes.
3. Regular, uncompressed extents: we read the sectors we need directly
   from disk.
4. Regular, compressed extents: we read the entire compressed extent
   from disk and indicate what subset of the decompressed extent is in
   the file.

This initial implementation simplifies a few things that can be improved
in the future:

- We hold the inode lock during the operation.
- Cases 1, 3, and 4 allocate temporary memory to read into before
  copying out to userspace.
- Cases 3 and 4 do not implement repair yet.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h |   2 +
 fs/btrfs/file.c  |  12 +-
 fs/btrfs/inode.c | 462 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 475 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 71552b2ca340..3b2aa1c7218c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2906,6 +2906,8 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
+ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter);
+
 extern const struct dentry_operations btrfs_dentry_operations;
 
 /* ioctl.c */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 27e5b269e729..51740cee39fc 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -390,6 +390,16 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	if (iocb->ki_flags & IOCB_ENCODED) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EOPNOTSUPP;
+		return btrfs_encoded_read(iocb, iter);
+	}
+	return generic_file_read_iter(iocb, iter);
+}
+
 /* simple helper to fault in pages and copy.  This should go away
  * and be replaced with calls into generic code.
  */
@@ -3457,7 +3467,7 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
-	.read_iter      = generic_file_read_iter,
+	.read_iter      = btrfs_file_read_iter,
 	.splice_read	= generic_file_splice_read,
 	.write_iter	= btrfs_file_write_iter,
 	.mmap		= btrfs_file_mmap,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8bce46122ef7..174d0738d2c9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10593,6 +10593,468 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
 	}
 }
 
+static int encoded_iov_compression_from_btrfs(struct encoded_iov *encoded,
+					      unsigned int compress_type)
+{
+	switch (compress_type) {
+	case BTRFS_COMPRESS_NONE:
+		encoded->compression = ENCODED_IOV_COMPRESSION_NONE;
+		break;
+	case BTRFS_COMPRESS_ZLIB:
+		encoded->compression = ENCODED_IOV_COMPRESSION_ZLIB;
+		break;
+	case BTRFS_COMPRESS_LZO:
+		encoded->compression = ENCODED_IOV_COMPRESSION_LZO;
+		break;
+	case BTRFS_COMPRESS_ZSTD:
+		encoded->compression = ENCODED_IOV_COMPRESSION_ZSTD;
+		break;
+	default:
+		return -EIO;
+	}
+	return 0;
+}
+
+static ssize_t btrfs_encoded_read_inline(struct kiocb *iocb,
+					 struct iov_iter *iter, u64 start,
+					 u64 lockend,
+					 struct extent_state **cached_state,
+					 u64 extent_start, size_t count,
+					 struct encoded_iov *encoded,
+					 bool *unlocked)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	struct btrfs_file_extent_item *item;
+	u64 ram_bytes;
+	unsigned long ptr;
+	void *tmp;
+	ssize_t ret;
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = btrfs_lookup_file_extent(NULL, BTRFS_I(inode)->root, path,
+				       btrfs_ino(BTRFS_I(inode)), extent_start,
+				       0);
+	if (ret) {
+		if (ret > 0) {
+			/* The extent item disappeared? */
+			ret = -EIO;
+		}
+		goto out;
+	}
+	leaf = path->nodes[0];
+	item = btrfs_item_ptr(leaf, path->slots[0],
+			      struct btrfs_file_extent_item);
+
+	ram_bytes = btrfs_file_extent_ram_bytes(leaf, item);
+	ptr = btrfs_file_extent_inline_start(item);
+
+	encoded->len = (min_t(u64, extent_start + ram_bytes, inode->i_size) -
+			iocb->ki_pos);
+	ret = encoded_iov_compression_from_btrfs(encoded,
+				 btrfs_file_extent_compression(leaf, item));
+	if (ret)
+		goto out;
+	if (encoded->compression) {
+		size_t inline_size;
+
+		inline_size = btrfs_file_extent_inline_item_len(leaf,
+						btrfs_item_nr(path->slots[0]));
+		if (inline_size > count) {
+			ret = -EFBIG;
+			goto out;
+		}
+		count = inline_size;
+		encoded->unencoded_len = ram_bytes;
+		encoded->unencoded_offset = iocb->ki_pos - extent_start;
+	} else {
+		encoded->len = encoded->unencoded_len = count =
+			min_t(u64, count, encoded->len);
+		ptr += iocb->ki_pos - extent_start;
+	}
+
+	tmp = kmalloc(count, GFP_NOFS);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	read_extent_buffer(leaf, tmp, ptr, count);
+	btrfs_free_path(path);
+	path = NULL;
+	unlock_extent_cached(io_tree, start, lockend, cached_state);
+	inode_unlock(inode);
+	*unlocked = true;
+	if (copy_to_iter(encoded, sizeof(*encoded), iter) == sizeof(*encoded) &&
+	    copy_to_iter(tmp, count, iter) == count)
+		ret = count;
+	else
+		ret = -EFAULT;
+	kfree(tmp);
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+struct btrfs_encoded_read_private {
+	struct inode *inode;
+	wait_queue_head_t wait;
+	atomic_t pending;
+	bool uptodate;
+	bool skip_csum;
+};
+
+static bool btrfs_encoded_read_check_csums(struct btrfs_io_bio *io_bio)
+{
+	struct btrfs_encoded_read_private *priv = io_bio->bio.bi_private;
+	struct inode *inode = priv->inode;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	u32 sectorsize = fs_info->sectorsize;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+	u64 offset = 0;
+
+	if (priv->skip_csum)
+		return true;
+	bio_for_each_segment_all(bvec, &io_bio->bio, iter_all) {
+		unsigned int i, nr_sectors, pgoff;
+
+		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
+		pgoff = bvec->bv_offset;
+		for (i = 0; i < nr_sectors; i++) {
+			int csum_pos;
+
+			csum_pos = BTRFS_BYTES_TO_BLKS(fs_info, offset);
+			if (__readpage_endio_check(inode, io_bio, csum_pos,
+						   bvec->bv_page, pgoff,
+						   io_bio->logical + offset,
+						   sectorsize))
+				return false;
+			offset += sectorsize;
+			pgoff += sectorsize;
+		}
+	}
+	return true;
+}
+
+static void btrfs_encoded_read_endio(struct bio *bio)
+{
+	struct btrfs_encoded_read_private *priv = bio->bi_private;
+	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
+
+	if (bio->bi_status || !btrfs_encoded_read_check_csums(io_bio))
+		priv->uptodate = false;
+	if (!atomic_dec_return(&priv->pending))
+		wake_up(&priv->wait);
+	btrfs_io_bio_free_csum(io_bio);
+	bio_put(bio);
+}
+
+static bool btrfs_submit_encoded_read(struct bio *bio)
+{
+	struct btrfs_encoded_read_private *priv = bio->bi_private;
+	struct inode *inode = priv->inode;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	blk_status_t status;
+
+	atomic_inc(&priv->pending);
+
+	if (!priv->skip_csum) {
+		status = btrfs_lookup_bio_sums_at_offset(inode, bio,
+							 btrfs_io_bio(bio)->logical,
+							 NULL);
+		if (status)
+			goto out;
+	}
+
+	status = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
+	if (status)
+		goto out;
+
+	status = btrfs_map_bio(fs_info, bio, 0, 0);
+out:
+	if (status) {
+		bio->bi_status = status;
+		bio_endio(bio);
+		return false;
+	}
+	return true;
+}
+
+static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
+					  struct iov_iter *iter,
+					  u64 start, u64 lockend,
+					  struct extent_state **cached_state,
+					  struct block_device *bdev,
+					  u64 offset, u64 disk_io_size,
+					  size_t count,
+					  const struct encoded_iov *encoded,
+					  bool *unlocked)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_encoded_read_private priv = {
+		.inode = inode,
+		.wait = __WAIT_QUEUE_HEAD_INITIALIZER(priv.wait),
+		.pending = ATOMIC_INIT(1),
+		.uptodate = true,
+		.skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM,
+	};
+	struct page **pages;
+	unsigned long nr_pages, i;
+	struct bio *bio = NULL;
+	u64 cur;
+	size_t page_offset;
+	ssize_t ret;
+
+	nr_pages = (disk_io_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
+	if (!pages)
+		return -ENOMEM;
+	for (i = 0; i < nr_pages; i++) {
+		pages[i] = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+		if (!pages[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	i = 0;
+	cur = 0;
+	while (cur < disk_io_size) {
+		size_t bytes = min_t(u64, disk_io_size - cur,
+				     PAGE_SIZE);
+
+		if (!bio) {
+			bio = btrfs_bio_alloc(offset + cur);
+			bio_set_dev(bio, bdev);
+			bio->bi_end_io = btrfs_encoded_read_endio;
+			bio->bi_private = &priv;
+			bio->bi_opf = REQ_OP_READ;
+			btrfs_io_bio(bio)->logical = start + cur;
+		}
+
+		if (bio_add_page(bio, pages[i], bytes, 0) < bytes) {
+			bool success;
+
+			success = btrfs_submit_encoded_read(bio);
+			bio = NULL;
+			if (!success)
+				break;
+			continue;
+		}
+		i++;
+		cur += bytes;
+	}
+
+	if (bio)
+		btrfs_submit_encoded_read(bio);
+	if (atomic_dec_return(&priv.pending))
+		wait_event(priv.wait, !atomic_read(&priv.pending));
+	if (!priv.uptodate) {
+		ret = -EIO;
+		goto out;
+	}
+
+	unlock_extent_cached(io_tree, start, lockend, cached_state);
+	inode_unlock(inode);
+	*unlocked = true;
+
+	if (copy_to_iter(encoded, sizeof(*encoded), iter) != sizeof(*encoded)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	if (encoded->compression) {
+		i = 0;
+		page_offset = 0;
+	} else {
+		i = (iocb->ki_pos - start) >> PAGE_SHIFT;
+		page_offset = (iocb->ki_pos - start) & (PAGE_SIZE - 1);
+	}
+	cur = 0;
+	while (cur < count) {
+		size_t bytes = min_t(size_t, count - cur,
+				     PAGE_SIZE - page_offset);
+
+		if (copy_page_to_iter(pages[i], page_offset, bytes,
+				      iter) != bytes) {
+			ret = -EFAULT;
+			goto out;
+		}
+		i++;
+		cur += bytes;
+		page_offset = 0;
+	}
+	ret = count;
+out:
+	for (i = 0; i < nr_pages; i++) {
+		if (pages[i])
+			put_page(pages[i]);
+	}
+	kfree(pages);
+	return ret;
+}
+
+ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	ssize_t ret;
+	size_t count;
+	struct block_device *em_bdev;
+	u64 start, lockend, offset, disk_io_size;
+	struct extent_state *cached_state = NULL;
+	struct extent_map *em;
+	struct encoded_iov encoded = {};
+	bool unlocked = false;
+
+	ret = check_encoded_read(iocb, iter);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+empty:
+		if (copy_to_iter(&encoded, sizeof(encoded), iter) ==
+		    sizeof(encoded))
+			return 0;
+		else
+			return -EFAULT;
+	}
+	count = ret;
+
+	file_accessed(iocb->ki_filp);
+
+	inode_lock(inode);
+
+	if (iocb->ki_pos >= inode->i_size) {
+		inode_unlock(inode);
+		goto empty;
+	}
+	start = ALIGN_DOWN(iocb->ki_pos, fs_info->sectorsize);
+	/*
+	 * We don't know how long the extent containing iocb->ki_pos is, but if
+	 * it's compressed we know that it won't be longer than this.
+	 */
+	lockend = start + BTRFS_MAX_UNCOMPRESSED - 1;
+
+	for (;;) {
+		struct btrfs_ordered_extent *ordered;
+
+		ret = btrfs_wait_ordered_range(inode, start,
+					       lockend - start + 1);
+		if (ret)
+			goto out_unlock_inode;
+		lock_extent_bits(io_tree, start, lockend, &cached_state);
+		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
+						     lockend - start + 1);
+		if (!ordered)
+			break;
+		btrfs_put_ordered_extent(ordered);
+		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+		cond_resched();
+	}
+
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start,
+			      lockend - start + 1, 0);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto out_unlock_extent;
+	}
+	em_bdev = em->bdev;
+
+	if (em->block_start == EXTENT_MAP_INLINE) {
+		u64 extent_start = em->start;
+
+		/*
+		 * For inline extents we get everything we need out of the
+		 * extent item.
+		 */
+		free_extent_map(em);
+		em = NULL;
+		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
+						&cached_state, extent_start,
+						count, &encoded, &unlocked);
+		goto out;
+	}
+
+	/*
+	 * We only want to return up to EOF even if the extent extends beyond
+	 * that.
+	 */
+	encoded.len = (min_t(u64, extent_map_end(em), inode->i_size) -
+		       iocb->ki_pos);
+	if (em->block_start == EXTENT_MAP_HOLE ||
+	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
+		offset = EXTENT_MAP_HOLE;
+	} else if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
+		offset = em->block_start;
+		/*
+		 * Bail if the buffer isn't large enough to return the whole
+		 * compressed extent.
+		 */
+		if (em->block_len > count) {
+			ret = -EFBIG;
+			goto out_em;
+		}
+		disk_io_size = count = em->block_len;
+		encoded.unencoded_len = em->ram_bytes;
+		encoded.unencoded_offset = iocb->ki_pos - em->orig_start;
+		ret = encoded_iov_compression_from_btrfs(&encoded,
+							 em->compress_type);
+		if (ret)
+			goto out_em;
+	} else {
+		offset = em->block_start + (start - em->start);
+		if (encoded.len > count)
+			encoded.len = count;
+		/*
+		 * Don't read beyond what we locked. This also limits the page
+		 * allocations that we'll do.
+		 */
+		disk_io_size = min(lockend + 1, iocb->ki_pos + encoded.len) - start;
+		encoded.len = encoded.unencoded_len = count =
+			start + disk_io_size - iocb->ki_pos;
+		disk_io_size = ALIGN(disk_io_size, fs_info->sectorsize);
+	}
+	free_extent_map(em);
+	em = NULL;
+
+	if (offset == EXTENT_MAP_HOLE) {
+		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+		inode_unlock(inode);
+		unlocked = true;
+		if (copy_to_iter(&encoded, sizeof(encoded), iter) ==
+		    sizeof(encoded))
+			ret = 0;
+		else
+			ret = -EFAULT;
+	} else {
+		ret = btrfs_encoded_read_regular(iocb, iter, start, lockend,
+						 &cached_state, em_bdev, offset,
+						 disk_io_size, count, &encoded,
+						 &unlocked);
+	}
+
+out:
+	if (ret >= 0)
+		iocb->ki_pos += encoded.len;
+out_em:
+	free_extent_map(em);
+out_unlock_extent:
+	if (!unlocked)
+		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+out_unlock_inode:
+	if (!unlocked)
+		inode_unlock(inode);
+	return ret;
+}
+
 #ifdef CONFIG_SWAP
 /*
  * Add an entry indicating a block group or device which is pinned by a
-- 
2.23.0


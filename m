Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5AD3FE0A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbhIARCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345549AbhIARCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF810C061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:01:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so212627pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqH8MVmzbOcnIXkuJHy815qNGm6EKCokgjSrL6IgzyE=;
        b=TT8jbAYWWbQ/hVzpnFYN7hOySsQZGRz3hoxQ34gZXf+Aj++UG0Dnd8LjNS20Vw1CTg
         LdTrfPoYY/syfZKWliTfusAP6y8gqJZpuMo4w1VCybW1laO3nMgJkk6sIJSS0YvtNfQO
         38E6EYg7bshfSjL32Rkau31u/zHJLwRfIpmQLt5iabblcsqiJuDZsZTdQ0rmO8mV0hYP
         iFuGp9Sj6XRywl/BJWWbSQasfxy6rGO+22UYYLl9DCzx+D8nG1w0z0yhs5db9KQm4p8l
         2NsBgPawAkCsqgv34Z/GI+rG4wUW5ibQV8UyfPuShQlCtWWq6MDiMykrFZX1w58CdN5o
         154Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqH8MVmzbOcnIXkuJHy815qNGm6EKCokgjSrL6IgzyE=;
        b=G5blZxULpa7WiYCqMPyiI3pYcuZTZoDDT/VMVyXvfor6h66pX7UJdXVC0fnADr64qG
         BqGUjbNVFAe54maisad4KXmoCgl9uWzWPybYBhsrTed8zIGlx6pMGE+JAahY+k+nWowB
         xo9g3nNUSxw1kf5hvbqbNr7ckmK+tCXrHgTohuuWM/ljFd9OV5Kj1/txu5ZQ53/nI2di
         VemSngduP1tyyn3HBXxajAc4x6e45yNzLmfpuY+D5Cwu6E30ChXk2WK04iNyNjbq6By9
         E2+yrHMqh8pUHCNVvpgjBB2m+DG93z6tyHTcWiiG9uPUocecYLetK9IldGGf3RNB7ZN/
         g2Gg==
X-Gm-Message-State: AOAM530dQxotxkWzQAjt/+CxoohEqXvHP9MOLVnLqT5fWrwte7E3ydbK
        d18KsP7/A67mPl7cDn+OAqEn7Q==
X-Google-Smtp-Source: ABdhPJxwIdMRwxId7VeDJA2WEBuMrMnUhysOJaYAcfF/cslXhRlwz8rvAy8Fk8n+1Ro1FbAJgrjeaQ==
X-Received: by 2002:a17:90a:420c:: with SMTP id o12mr282411pjg.101.1630515698187;
        Wed, 01 Sep 2021 10:01:38 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:37 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 08/14] btrfs: add BTRFS_IOC_ENCODED_READ
Date:   Wed,  1 Sep 2021 10:01:03 -0700
Message-Id: <c8c9bc3a546359bda7420d92d3d61d1023c1cb96.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

There are 4 main cases:

1. Inline extents: we copy the data straight out of the extent buffer.
2. Hole/preallocated extents: we fill in zeroes.
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
- We don't do read repair, because it turns out that read repair is
  currently broken for compressed data.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h |   4 +
 fs/btrfs/inode.c | 489 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ioctl.c | 111 +++++++++++
 3 files changed, 604 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b95ec5fb68d5..cbd7e07c1c34 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3223,6 +3223,10 @@ int btrfs_writepage_cow_fixup(struct page *page);
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, bool uptodate);
+struct btrfs_ioctl_encoded_io_args;
+ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
+			   struct btrfs_ioctl_encoded_io_args *encoded);
+
 extern const struct dentry_operations btrfs_dentry_operations;
 extern const struct iomap_ops btrfs_dio_iomap_ops;
 extern const struct iomap_dio_ops btrfs_dio_ops;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a87a34f56234..1940f22179ba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10500,6 +10500,495 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
 	}
 }
 
+static int btrfs_encoded_io_compression_from_extent(int compress_type)
+{
+	switch (compress_type) {
+	case BTRFS_COMPRESS_NONE:
+		return BTRFS_ENCODED_IO_COMPRESSION_NONE;
+	case BTRFS_COMPRESS_ZLIB:
+		return BTRFS_ENCODED_IO_COMPRESSION_ZLIB;
+	case BTRFS_COMPRESS_LZO:
+		/*
+		 * The LZO format depends on the page size. 64k is the maximum
+		 * sectorsize (and thus page size) that we support.
+		 */
+		if (PAGE_SIZE < SZ_4K || PAGE_SIZE > SZ_64K)
+			return -EINVAL;
+		return BTRFS_ENCODED_IO_COMPRESSION_LZO_4K + (PAGE_SHIFT - 12);
+	case BTRFS_COMPRESS_ZSTD:
+		return BTRFS_ENCODED_IO_COMPRESSION_ZSTD;
+	default:
+		return -EUCLEAN;
+	}
+}
+
+static ssize_t btrfs_encoded_read_inline(
+				struct kiocb *iocb,
+				struct iov_iter *iter, u64 start,
+				u64 lockend,
+				struct extent_state **cached_state,
+				u64 extent_start, size_t count,
+				struct btrfs_ioctl_encoded_io_args *encoded,
+				bool *unlocked)
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
+	ret = btrfs_encoded_io_compression_from_extent(
+				 btrfs_file_extent_compression(leaf, item));
+	if (ret < 0)
+		goto out;
+	encoded->compression = ret;
+	if (encoded->compression) {
+		size_t inline_size;
+
+		inline_size = btrfs_file_extent_inline_item_len(leaf,
+						btrfs_item_nr(path->slots[0]));
+		if (inline_size > count) {
+			ret = -ENOBUFS;
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
+	btrfs_release_path(path);
+	unlock_extent_cached(io_tree, start, lockend, cached_state);
+	inode_unlock_shared(inode);
+	*unlocked = true;
+
+	ret = copy_to_iter(tmp, count, iter);
+	if (ret != count)
+		ret = -EFAULT;
+	kfree(tmp);
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+struct btrfs_encoded_read_private {
+	struct inode *inode;
+	wait_queue_head_t wait;
+	atomic_t pending;
+	blk_status_t status;
+	bool skip_csum;
+};
+
+static blk_status_t submit_encoded_read_bio(struct inode *inode,
+					    struct bio *bio, int mirror_num,
+					    unsigned long bio_flags)
+{
+	struct btrfs_encoded_read_private *priv = bio->bi_private;
+	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	blk_status_t ret;
+
+	if (!priv->skip_csum) {
+		ret = btrfs_lookup_bio_sums(inode, bio, NULL);
+		if (ret)
+			return ret;
+	}
+
+	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
+	if (ret) {
+		btrfs_io_bio_free_csum(io_bio);
+		return ret;
+	}
+
+	atomic_inc(&priv->pending);
+	ret = btrfs_map_bio(fs_info, bio, mirror_num);
+	if (ret) {
+		atomic_dec(&priv->pending);
+		btrfs_io_bio_free_csum(io_bio);
+	}
+	return ret;
+}
+
+static blk_status_t btrfs_encoded_read_check_bio(struct btrfs_io_bio *io_bio)
+{
+	const bool uptodate = io_bio->bio.bi_status == BLK_STS_OK;
+	struct btrfs_encoded_read_private *priv = io_bio->bio.bi_private;
+	struct inode *inode = priv->inode;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	u32 sectorsize = fs_info->sectorsize;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+	u64 start = io_bio->logical;
+	u32 bio_offset = 0;
+
+	if (priv->skip_csum || !uptodate)
+		return io_bio->bio.bi_status;
+
+	bio_for_each_segment_all(bvec, &io_bio->bio, iter_all) {
+		unsigned int i, nr_sectors, pgoff;
+
+		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
+		pgoff = bvec->bv_offset;
+		for (i = 0; i < nr_sectors; i++) {
+			ASSERT(pgoff < PAGE_SIZE);
+			if (check_data_csum(inode, io_bio, bio_offset,
+					    bvec->bv_page, pgoff, start))
+				return BLK_STS_IOERR;
+			start += sectorsize;
+			bio_offset += sectorsize;
+			pgoff += sectorsize;
+		}
+	}
+	return BLK_STS_OK;
+}
+
+static void btrfs_encoded_read_endio(struct bio *bio)
+{
+	struct btrfs_encoded_read_private *priv = bio->bi_private;
+	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
+	blk_status_t status;
+
+	status = btrfs_encoded_read_check_bio(io_bio);
+	if (status) {
+		/*
+		 * The memory barrier implied by the atomic_dec_return() here
+		 * pairs with the memory barrier implied by the
+		 * atomic_dec_return() or io_wait_event() in
+		 * btrfs_encoded_read_regular_fill_pages() to ensure that this
+		 * write is observed before the load of status in
+		 * btrfs_encoded_read_regular_fill_pages().
+		 */
+		WRITE_ONCE(priv->status, status);
+	}
+	if (!atomic_dec_return(&priv->pending))
+		wake_up(&priv->wait);
+	btrfs_io_bio_free_csum(io_bio);
+	bio_put(bio);
+}
+
+static int btrfs_encoded_read_regular_fill_pages(struct inode *inode, u64 offset,
+						 u64 disk_io_size, struct page **pages)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_encoded_read_private priv = {
+		.inode = inode,
+		.pending = ATOMIC_INIT(1),
+		.skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM,
+	};
+	unsigned long i = 0;
+	u64 cur = 0;
+	int ret;
+
+	init_waitqueue_head(&priv.wait);
+	/*
+	 * Submit bios for the extent, splitting due to bio or stripe limits as
+	 * necessary.
+	 */
+	while (cur < disk_io_size) {
+		struct extent_map *em;
+		struct btrfs_io_geometry geom;
+		struct bio *bio = NULL;
+		u64 remaining;
+
+		em = btrfs_get_chunk_map(fs_info, offset + cur,
+					 disk_io_size - cur);
+		if (IS_ERR(em)) {
+			ret = PTR_ERR(em);
+		} else {
+			ret = btrfs_get_io_geometry(fs_info, em, BTRFS_MAP_READ,
+						    offset + cur, &geom);
+			free_extent_map(em);
+		}
+		if (ret) {
+			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
+			break;
+		}
+		remaining = min(geom.len, disk_io_size - cur);
+		while (bio || remaining) {
+			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
+
+			if (!bio) {
+				bio = btrfs_bio_alloc(offset + cur);
+				bio->bi_end_io = btrfs_encoded_read_endio;
+				bio->bi_private = &priv;
+				bio->bi_opf = REQ_OP_READ;
+			}
+
+			if (!bytes ||
+			    bio_add_page(bio, pages[i], bytes, 0) < bytes) {
+				blk_status_t status;
+
+				status = submit_encoded_read_bio(inode, bio, 0,
+								 0);
+				if (status) {
+					WRITE_ONCE(priv.status, status);
+					bio_put(bio);
+					goto out;
+				}
+				bio = NULL;
+				continue;
+			}
+
+			i++;
+			cur += bytes;
+			remaining -= bytes;
+		}
+	}
+
+out:
+	if (atomic_dec_return(&priv.pending))
+		io_wait_event(priv.wait, !atomic_read(&priv.pending));
+	/* See btrfs_encoded_read_endio() for ordering. */
+	return blk_status_to_errno(READ_ONCE(priv.status));
+}
+
+static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
+					  struct iov_iter *iter,
+					  u64 start, u64 lockend,
+					  struct extent_state **cached_state,
+					  u64 offset, u64 disk_io_size,
+					  size_t count, bool compressed,
+					  bool *unlocked)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct page **pages;
+	unsigned long nr_pages, i;
+	u64 cur;
+	size_t page_offset;
+	ssize_t ret;
+
+	nr_pages = DIV_ROUND_UP(disk_io_size, PAGE_SIZE);
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
+	ret = btrfs_encoded_read_regular_fill_pages(inode, offset, disk_io_size,
+						    pages);
+	if (ret)
+		goto out;
+
+	unlock_extent_cached(io_tree, start, lockend, cached_state);
+	inode_unlock_shared(inode);
+	*unlocked = true;
+
+	if (compressed) {
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
+			__free_page(pages[i]);
+	}
+	kfree(pages);
+	return ret;
+}
+
+ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
+			   struct btrfs_ioctl_encoded_io_args *encoded)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	ssize_t ret;
+	size_t count = iov_iter_count(iter);
+	u64 start, lockend, offset, disk_io_size;
+	struct extent_state *cached_state = NULL;
+	struct extent_map *em;
+	bool unlocked = false;
+
+	file_accessed(iocb->ki_filp);
+
+	inode_lock_shared(inode);
+
+	if (iocb->ki_pos >= inode->i_size) {
+		inode_unlock_shared(inode);
+		return 0;
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
+			      lockend - start + 1);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto out_unlock_extent;
+	}
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
+						count, encoded, &unlocked);
+		goto out;
+	}
+
+	/*
+	 * We only want to return up to EOF even if the extent extends beyond
+	 * that.
+	 */
+	encoded->len = (min_t(u64, extent_map_end(em), inode->i_size) -
+			iocb->ki_pos);
+	if (em->block_start == EXTENT_MAP_HOLE ||
+	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
+		offset = EXTENT_MAP_HOLE;
+		encoded->len = encoded->unencoded_len = count =
+			min_t(u64, count, encoded->len);
+	} else if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
+		offset = em->block_start;
+		/*
+		 * Bail if the buffer isn't large enough to return the whole
+		 * compressed extent.
+		 */
+		if (em->block_len > count) {
+			ret = -ENOBUFS;
+			goto out_em;
+		}
+		disk_io_size = count = em->block_len;
+		encoded->unencoded_len = em->ram_bytes;
+		encoded->unencoded_offset = iocb->ki_pos - em->orig_start;
+		ret = btrfs_encoded_io_compression_from_extent(
+							     em->compress_type);
+		if (ret < 0)
+			goto out_em;
+		encoded->compression = ret;
+	} else {
+		offset = em->block_start + (start - em->start);
+		if (encoded->len > count)
+			encoded->len = count;
+		/*
+		 * Don't read beyond what we locked. This also limits the page
+		 * allocations that we'll do.
+		 */
+		disk_io_size = min(lockend + 1,
+				   iocb->ki_pos + encoded->len) - start;
+		encoded->len = encoded->unencoded_len = count =
+			start + disk_io_size - iocb->ki_pos;
+		disk_io_size = ALIGN(disk_io_size, fs_info->sectorsize);
+	}
+	free_extent_map(em);
+	em = NULL;
+
+	if (offset == EXTENT_MAP_HOLE) {
+		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+		inode_unlock_shared(inode);
+		unlocked = true;
+		ret = iov_iter_zero(count, iter);
+		if (ret != count)
+			ret = -EFAULT;
+	} else {
+		ret = btrfs_encoded_read_regular(iocb, iter, start, lockend,
+						 &cached_state, offset,
+						 disk_io_size, count,
+						 encoded->compression,
+						 &unlocked);
+	}
+
+out:
+	if (ret >= 0)
+		iocb->ki_pos += encoded->len;
+out_em:
+	free_extent_map(em);
+out_unlock_extent:
+	if (!unlocked)
+		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+out_unlock_inode:
+	if (!unlocked)
+		inode_unlock_shared(inode);
+	return ret;
+}
+
 #ifdef CONFIG_SWAP
 /*
  * Add an entry indicating a block group or device which is pinned by a
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fecb8bac11dd..4e619a10f236 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -28,6 +28,7 @@
 #include <linux/iversion.h>
 #include <linux/fileattr.h>
 #include <linux/fsverity.h>
+#include <linux/sched/xacct.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "export.h"
@@ -87,6 +88,22 @@ struct btrfs_ioctl_send_args_32 {
 
 #define BTRFS_IOC_SEND_32 _IOW(BTRFS_IOCTL_MAGIC, 38, \
 			       struct btrfs_ioctl_send_args_32)
+
+struct btrfs_ioctl_encoded_io_args_32 {
+	compat_uptr_t iov;
+	compat_ulong_t iovcnt;
+	__s64 offset;
+	__u64 flags;
+	__u64 len;
+	__u64 unencoded_len;
+	__u64 unencoded_offset;
+	__u32 compression;
+	__u32 encryption;
+	__u32 reserved[8];
+};
+
+#define BTRFS_IOC_ENCODED_READ_32 _IOR(BTRFS_IOCTL_MAGIC, 64, \
+				       struct btrfs_ioctl_encoded_io_args_32)
 #endif
 
 /* Mask out flags that are inappropriate for the given type of inode. */
@@ -4824,6 +4841,94 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
 	return ret;
 }
 
+static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
+				    bool compat)
+{
+	struct btrfs_ioctl_encoded_io_args args;
+	size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args,
+					     flags);
+	size_t copy_end;
+	struct iovec iovstack[UIO_FASTIOV];
+	struct iovec *iov = iovstack;
+	struct iov_iter iter;
+	loff_t pos;
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		ret = -EPERM;
+		goto out_acct;
+	}
+
+	if (compat) {
+#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
+		struct btrfs_ioctl_encoded_io_args_32 args32;
+
+		copy_end = offsetofend(struct btrfs_ioctl_encoded_io_args_32,
+				       flags);
+		if (copy_from_user(&args32, argp, copy_end)) {
+			ret = -EFAULT;
+			goto out_acct;
+		}
+		args.iov = compat_ptr(args32.iov);
+		args.iovcnt = args32.iovcnt;
+		args.offset = args32.offset;
+		args.flags = args32.flags;
+#else
+		return -ENOTTY;
+#endif
+	} else {
+		copy_end = copy_end_kernel;
+		if (copy_from_user(&args, argp, copy_end)) {
+			ret = -EFAULT;
+			goto out_acct;
+		}
+	}
+	if (args.flags != 0) {
+		ret = -EINVAL;
+		goto out_acct;
+	}
+	memset((char *)&args + copy_end_kernel, 0,
+	       sizeof(args) - copy_end_kernel);
+
+	ret = import_iovec(READ, args.iov, args.iovcnt, ARRAY_SIZE(iovstack),
+			   &iov, &iter);
+	if (ret < 0)
+		goto out_acct;
+
+	if (iov_iter_count(&iter) == 0) {
+		ret = 0;
+		goto out_iov;
+	}
+	pos = args.offset;
+	ret = rw_verify_area(READ, file, &pos, args.len);
+	if (ret < 0)
+		goto out_iov;
+
+	init_sync_kiocb(&kiocb, file);
+	ret = kiocb_set_rw_flags(&kiocb, 0);
+	if (ret)
+		goto out_iov;
+	kiocb.ki_pos = pos;
+
+	ret = btrfs_encoded_read(&kiocb, &iter, &args);
+	if (ret >= 0) {
+		fsnotify_access(file);
+		if (copy_to_user(argp + copy_end,
+				 (char *)&args + copy_end_kernel,
+				 sizeof(args) - copy_end_kernel))
+			ret = -EFAULT;
+	}
+
+out_iov:
+	kfree(iov);
+out_acct:
+	if (ret > 0)
+		add_rchar(current, ret);
+	inc_syscr(current);
+	return ret;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -4968,6 +5073,12 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return fsverity_ioctl_enable(file, (const void __user *)argp);
 	case FS_IOC_MEASURE_VERITY:
 		return fsverity_ioctl_measure(file, argp);
+	case BTRFS_IOC_ENCODED_READ:
+		return btrfs_ioctl_encoded_read(file, argp, false);
+#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
+	case BTRFS_IOC_ENCODED_READ_32:
+		return btrfs_ioctl_encoded_read(file, argp, true);
+#endif
 	}
 
 	return -ENOTTY;
-- 
2.33.0


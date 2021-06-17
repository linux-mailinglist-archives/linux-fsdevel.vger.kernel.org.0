Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF93ABFE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 01:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhFQXyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 19:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhFQXyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 19:54:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC011C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 16:52:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y15so457599pfl.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 16:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MDw2iwrqH52Q0htoQReMm8n3gQu7y06pdyw2hAZq2RQ=;
        b=rym4Qor1yCIZQ034mmJQAcMh3J1p1u8hxAEs3zh4PJO7atCJvINLIek+mMZcjpcB/K
         h6mhrgyMq4cQPDp8VkyMmF2g82LzfbaRAZqdvh+DbsSzXyH5/Ag8obKbbW0QxsZ1/mO9
         r18QXV24q8qImcccOCbHYXe3i09duhez3ieoPWE9j7MdhNGBPWfUas5dCirUAPnP6OC+
         PGOsq9iwJy9S49+Rop/96SPPhIm7kSPT6DxZJqsB62BIp36i4UTWaguUskhOo9vxwrtV
         pYclMeGBzcSVnn9SWicRM6+PhJS+gszYGHBjYmidUDbHdgnPGN/SrU5AQgx6SOFy80Wf
         QOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MDw2iwrqH52Q0htoQReMm8n3gQu7y06pdyw2hAZq2RQ=;
        b=YiU71RVn4qc9NJWO+652sMn9fX3NWQFZ0qAD0S9PRtoxw79m70x6QDxF6Kw6deF3aG
         oK+vGeb7/uy5ij42rkNZt82sq9BGEGTr5nmfR6q8aFrcb1Z/+9MTM6b1ElsABBakhAwu
         RFd3oGDt2pJdLOb8uXo9aE3wajYaBnc+Nq/T+ZGM/1UuSsOT4GO4X/JKTdNKgpqhoBnn
         +FmLc9sLQsOws9xYV5xH7z6rJ8/+bx9BBEjBaFUQ67TJ2ereJSKET0rzq08w9pBryXuh
         Y96gGKUz4c8FjSeMp/0huTeDj2vyGOkeNzxFo+/HqlpQQS3VaVBpoGKGwHQ5djP1OR9X
         VrEA==
X-Gm-Message-State: AOAM532zXLNhVuNktMnVcxLV1owit3Tsi6heUXPlxd7LTUgJHzsD+wUy
        VyEb38f46X6j/uGsG/VobVQ7v/yMz4Hu8g==
X-Google-Smtp-Source: ABdhPJyIJxyxId67Me35SUAfd2TWWcQ3abaLCzk2Re6bgT9PvB6wVj77ONmn1rfNeVMEEbHuJ5vP9Q==
X-Received: by 2002:aa7:8244:0:b029:2ec:968d:c1b4 with SMTP id e4-20020aa782440000b02902ec968dc1b4mr2220107pfn.32.1623973920836;
        Thu, 17 Jun 2021 16:52:00 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:2f0e])
        by smtp.gmail.com with ESMTPSA id a187sm6087517pfb.66.2021.06.17.16.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 16:52:00 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH RESEND x3 v9 9/9] btrfs: implement RWF_ENCODED writes
Date:   Thu, 17 Jun 2021 16:51:32 -0700
Message-Id: <aa6d96647502062f91f785d9c0a2e11ee28f1f6a.1623972519.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623972518.git.osandov@fb.com>
References: <cover.1623972518.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c  |   7 +-
 fs/btrfs/compression.h  |   6 +-
 fs/btrfs/ctree.h        |   2 +
 fs/btrfs/file.c         |  38 +++++-
 fs/btrfs/inode.c        | 256 +++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ordered-data.c |  12 +-
 fs/btrfs/ordered-data.h |   5 +-
 7 files changed, 313 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 59733573ed08..e8146012d84b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -354,7 +354,8 @@ static void end_compressed_bio_write(struct bio *bio)
 			cb->start, cb->start + cb->len - 1,
 			bio->bi_status == BLK_STS_OK);
 
-	end_compressed_writeback(inode, cb);
+	if (cb->writeback)
+		end_compressed_writeback(inode, cb);
 	/* note, our inode could be gone now */
 
 	/*
@@ -390,7 +391,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				 struct page **compressed_pages,
 				 unsigned int nr_pages,
 				 unsigned int write_flags,
-				 struct cgroup_subsys_state *blkcg_css)
+				 struct cgroup_subsys_state *blkcg_css,
+				 bool writeback)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio = NULL;
@@ -416,6 +418,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->mirror_num = 0;
 	cb->compressed_pages = compressed_pages;
 	cb->compressed_len = compressed_len;
+	cb->writeback = writeback;
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index c359f20920d0..86b70e320813 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -52,6 +52,9 @@ struct compressed_bio {
 	/* The compression algorithm for this bio */
 	u8 compress_type;
 
+	/* Whether this is a write for writeback. */
+	bool writeback;
+
 	/* IO errors */
 	u8 errors;
 	int mirror_num;
@@ -96,7 +99,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  struct page **compressed_pages,
 				  unsigned int nr_pages,
 				  unsigned int write_flags,
-				  struct cgroup_subsys_state *blkcg_css);
+				  struct cgroup_subsys_state *blkcg_css,
+				  bool writeback);
 blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cd31dbc2e4a4..2a435c9adaec 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3202,6 +3202,8 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, int uptodate);
 ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			       struct encoded_iov *encoded);
 
 extern const struct dentry_operations btrfs_dentry_operations;
 extern const struct iomap_ops btrfs_dio_iomap_ops;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 89b3dd3fa9e4..deaa14a08711 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include <linux/encoded_io.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/time.h>
@@ -1990,6 +1991,32 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	return written ? written : err;
 }
 
+static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct encoded_iov encoded;
+	ssize_t ret;
+
+	ret = copy_encoded_iov_from_iter(&encoded, from);
+	if (ret)
+		return ret;
+
+	btrfs_inode_lock(inode, 0);
+	ret = generic_encoded_write_checks(iocb, &encoded);
+	if (ret || encoded.len == 0)
+		goto out;
+
+	ret = btrfs_write_check(iocb, from, encoded.len);
+	if (ret < 0)
+		goto out;
+
+	ret = btrfs_do_encoded_write(iocb, from, &encoded);
+out:
+	btrfs_inode_unlock(inode, 0);
+	return ret;
+}
+
 static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 				    struct iov_iter *from)
 {
@@ -2006,14 +2033,17 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	if (test_bit(BTRFS_FS_STATE_ERROR, &inode->root->fs_info->fs_state))
 		return -EROFS;
 
-	if (!(iocb->ki_flags & IOCB_DIRECT) &&
-	    (iocb->ki_flags & IOCB_NOWAIT))
+	if ((iocb->ki_flags & IOCB_NOWAIT) &&
+	    (!(iocb->ki_flags & IOCB_DIRECT) ||
+	     (iocb->ki_flags & IOCB_ENCODED)))
 		return -EOPNOTSUPP;
 
 	if (sync)
 		atomic_inc(&inode->sync_writers);
 
-	if (iocb->ki_flags & IOCB_DIRECT)
+	if (iocb->ki_flags & IOCB_ENCODED)
+		num_written = btrfs_encoded_write(iocb, from);
+	else if (iocb->ki_flags & IOCB_DIRECT)
 		num_written = btrfs_direct_write(iocb, from);
 	else
 		num_written = btrfs_buffered_write(iocb, from);
@@ -3606,7 +3636,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_ENCODED_IO;
 	return generic_file_open(inode, filp);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e09af2c8083a..81e5edee4e99 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -960,7 +960,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				    ins.offset, async_extent->pages,
 				    async_extent->nr_pages,
 				    async_chunk->write_flags,
-				    async_chunk->blkcg_css)) {
+				    async_chunk->blkcg_css, true)) {
 			struct page *p = async_extent->pages[0];
 			const u64 start = async_extent->start;
 			const u64 end = start + async_extent->ram_size - 1;
@@ -2861,6 +2861,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	 * except if the ordered extent was truncated.
 	 */
 	update_inode_bytes = test_bit(BTRFS_ORDERED_DIRECT, &oe->flags) ||
+			     test_bit(BTRFS_ORDERED_ENCODED, &oe->flags) ||
 			     test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags);
 
 	return insert_reserved_file_extent(trans, BTRFS_I(oe->inode),
@@ -2895,7 +2896,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 	    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags) &&
-	    !test_bit(BTRFS_ORDERED_DIRECT, &ordered_extent->flags))
+	    !test_bit(BTRFS_ORDERED_DIRECT, &ordered_extent->flags) &&
+	    !test_bit(BTRFS_ORDERED_ENCODED, &ordered_extent->flags))
 		clear_bits |= EXTENT_DELALLOC_NEW;
 
 	freespace_inode = btrfs_is_free_space_inode(inode);
@@ -10773,6 +10775,256 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			       struct encoded_iov *encoded)
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
+	case ENCODED_IOV_COMPRESSION_BTRFS_ZLIB:
+		compression = BTRFS_COMPRESS_ZLIB;
+		break;
+	case ENCODED_IOV_COMPRESSION_BTRFS_ZSTD:
+		compression = BTRFS_COMPRESS_ZSTD;
+		break;
+	case ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K:
+	case ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K:
+	case ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K:
+	case ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K:
+	case ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K:
+		/* The page size must match for LZO. */
+		if (encoded->compression -
+		    ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K + 12 != PAGE_SHIFT)
+			return -EINVAL;
+		compression = BTRFS_COMPRESS_LZO;
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
+	/*
+	 * We don't use the higher-level delalloc space functions because our
+	 * num_bytes and disk_num_bytes are different.
+	 */
+	ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode), disk_num_bytes);
+	if (ret)
+		goto out_unlock;
+	ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved, start,
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
+		ret = cow_file_range_inline(BTRFS_I(inode), encoded->len,
+					    orig_count, compression, pages,
+					    true);
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
+	em = create_io_em(BTRFS_I(inode), start, num_bytes,
+			  start - encoded->unencoded_offset, ins.objectid,
+			  ins.offset, ins.offset, ram_bytes, compression,
+			  BTRFS_ORDERED_COMPRESSED);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto out_free_reserved;
+	}
+	free_extent_map(em);
+
+	ret = btrfs_add_ordered_extent(BTRFS_I(inode), start, num_bytes,
+				       ram_bytes, ins.objectid, ins.offset,
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
+	if (btrfs_submit_compressed_write(BTRFS_I(inode), start, num_bytes,
+					  ins.objectid, ins.offset, pages,
+					  nr_pages, 0, NULL, false)) {
+		btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), pages[0],
+						     start, end, 0);
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
+	if (ret < 0) {
+		btrfs_qgroup_free_data(BTRFS_I(inode), data_reserved, start,
+				       num_bytes);
+	}
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
+			__free_page(pages[i]);
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
index 96357d2c845e..07be2775b895 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -526,9 +526,15 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
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
 
 	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,
 				 fs_info->delalloc_batch);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 81648a78f933..888b03689a9e 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -74,6 +74,8 @@ enum {
 	BTRFS_ORDERED_LOGGED_CSUM,
 	/* We wait for this extent to complete in the current transaction */
 	BTRFS_ORDERED_PENDING,
+	/* RWF_ENCODED I/O */
+	BTRFS_ORDERED_ENCODED,
 };
 
 /* BTRFS_ORDERED_* flags that specify the type of the extent. */
@@ -81,7 +83,8 @@ enum {
 				  (1UL << BTRFS_ORDERED_NOCOW) |	\
 				  (1UL << BTRFS_ORDERED_PREALLOC) |	\
 				  (1UL << BTRFS_ORDERED_COMPRESSED) |	\
-				  (1UL << BTRFS_ORDERED_DIRECT))
+				  (1UL << BTRFS_ORDERED_DIRECT) |	\
+				  (1UL << BTRFS_ORDERED_ENCODED))
 
 struct btrfs_ordered_extent {
 	/* logical offset in the file */
-- 
2.32.0


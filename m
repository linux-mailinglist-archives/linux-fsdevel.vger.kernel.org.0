Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A363EF478
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhHQVIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhHQVIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:08:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719AEC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nt11so1228645pjb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPKs6eA63UruqGGmIVM17e38R55IuNjIGADvBo6ekDI=;
        b=ASAOP3jWda+GFhnjoF0j8gENwDS++y1SrZIU1vIOymsdc3iDO1vnTxTKyUdIfrm561
         n9j0iTnpJRZ/Nbwb/KfNPiZuvbD8RgKNUc8uZdJ4f5aobWmrsx16xwJvxwEK5ACEsQp4
         9AnpZPhlpl6e32YlywoKtU19D37HkhLvSJBX54XGsCg5uzE38cxfkwi+6YLqusQlMn+X
         8L75sRLRdsYEZKR/OD2wQK+c2oAsWh264ASOYwacvNP+cNl6RnwLF8ix0ucTS2bIHOkl
         ZeJzj8OlLA+1olE2GJMlhgki07QrThjwARJMKNVMZWhosd+OoFaBQFP6AW2JLsJX0chS
         TDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPKs6eA63UruqGGmIVM17e38R55IuNjIGADvBo6ekDI=;
        b=JI4LOxcKyhdQqqgDuXssYfTEWml8bs2nyhcHlHccX+dSMzC7PKVSs4or5fu0/1SjrU
         DpSiCq0GMIYqlzG++q/r3eWJ7JD+JsZWQzIYWspS14CFw+QYhyaTNTtDQQ0FlLEoAZpv
         IDJhg8fWKnsO/jxxMbJy0j+VjjtWALkVBH8QefOkQRAPl9wVf1xFrl4OszjDdPnf+JG8
         PCB9It05aLyH7Ip4mmlvg1DvBKwH3x1X23NRgsgDAVSzjaXL/HmFJZFJ1tXd30+BfKpr
         QIw0lC9MLg8sm6dvY2rGknn7EaPJmv+Mop6rddXfrWIgS7bv+bJ7d5YCMBwW0ssPQAxF
         BH1w==
X-Gm-Message-State: AOAM5327k0mQgWTDze9WZ9oF0hU6CLk8y5g5lvITqRxE3p34olzP+tI1
        A98mMHN/VDfWpyR4UuD2gq3tww==
X-Google-Smtp-Source: ABdhPJyboTAK3suw0E+TSELNqJBj7nouWeWfoK2KSMaC/gMtMfRK5lbmUBPJDmKwiaE5Ab3rGgWzAA==
X-Received: by 2002:a62:154b:0:b0:3e2:c15d:f173 with SMTP id 72-20020a62154b000000b003e2c15df173mr1606708pfv.9.1629234446802;
        Tue, 17 Aug 2021 14:07:26 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:26 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 09/14] btrfs: add BTRFS_IOC_ENCODED_WRITE
Date:   Tue, 17 Aug 2021 14:06:41 -0700
Message-Id: <497af8b97838225920491f9146d9f65b6539e2d2.1629234193.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
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

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c  |   7 +-
 fs/btrfs/compression.h  |   6 +-
 fs/btrfs/ctree.h        |   4 +
 fs/btrfs/file.c         |  65 ++++++++--
 fs/btrfs/inode.c        | 256 +++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ioctl.c        | 102 ++++++++++++++++
 fs/btrfs/ordered-data.c |  12 +-
 fs/btrfs/ordered-data.h |   5 +-
 8 files changed, 437 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e645b3c2f09a..a9845aab3b18 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -353,7 +353,8 @@ static void end_compressed_bio_write(struct bio *bio)
 			cb->start, cb->start + cb->len - 1,
 			!cb->errors);
 
-	end_compressed_writeback(inode, cb);
+	if (cb->writeback)
+		end_compressed_writeback(inode, cb);
 	/* note, our inode could be gone now */
 
 	/*
@@ -389,7 +390,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				 struct page **compressed_pages,
 				 unsigned int nr_pages,
 				 unsigned int write_flags,
-				 struct cgroup_subsys_state *blkcg_css)
+				 struct cgroup_subsys_state *blkcg_css,
+				 bool writeback)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio = NULL;
@@ -415,6 +417,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->mirror_num = 0;
 	cb->compressed_pages = compressed_pages;
 	cb->compressed_len = compressed_len;
+	cb->writeback = writeback;
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 399be0b435bf..2ba9402f308d 100644
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
@@ -95,7 +98,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  struct page **compressed_pages,
 				  unsigned int nr_pages,
 				  unsigned int write_flags,
-				  struct cgroup_subsys_state *blkcg_css);
+				  struct cgroup_subsys_state *blkcg_css,
+				  bool writeback);
 blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b68d8ea42f6e..960902caed97 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3222,6 +3222,8 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 struct btrfs_ioctl_encoded_io_args;
 ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			   struct btrfs_ioctl_encoded_io_args *encoded);
+ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			     const struct btrfs_ioctl_encoded_io_args *encoded);
 
 extern const struct dentry_operations btrfs_dentry_operations;
 extern const struct iomap_ops btrfs_dio_iomap_ops;
@@ -3282,6 +3284,8 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 			   struct btrfs_trans_handle **trans_out);
 int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 			      struct btrfs_inode *inode, u64 start, u64 end);
+ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
+			    const struct btrfs_ioctl_encoded_io_args *encoded);
 int btrfs_release_file(struct inode *inode, struct file *file);
 int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6f9cb8baffd2..2b49cdcebd57 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2001,12 +2001,43 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	return written ? written : err;
 }
 
-static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
-				    struct iov_iter *from)
+static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			const struct btrfs_ioctl_encoded_io_args *encoded)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	loff_t count;
+	ssize_t ret;
+
+	btrfs_inode_lock(inode, 0);
+	count = encoded->len;
+	ret = __generic_write_checks(iocb, &count);
+	if (ret == 0 && count != encoded->len) {
+		/*
+		 * The write got truncated by __generic_write_checks(). We can't
+		 * do a partial encoded write.
+		 */
+		ret = -EFBIG;
+	}
+	if (ret || encoded->len == 0)
+		goto out;
+
+	ret = btrfs_write_check(iocb, from, encoded->len);
+	if (ret < 0)
+		goto out;
+
+	ret = btrfs_do_encoded_write(iocb, from, encoded);
+out:
+	btrfs_inode_unlock(inode, 0);
+	return ret;
+}
+
+ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
+			    const struct btrfs_ioctl_encoded_io_args *encoded)
 {
 	struct file *file = iocb->ki_filp;
 	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
-	ssize_t num_written = 0;
+	ssize_t num_written, num_sync;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
 
 	/*
@@ -2017,22 +2048,28 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	if (test_bit(BTRFS_FS_STATE_ERROR, &inode->root->fs_info->fs_state))
 		return -EROFS;
 
-	if (!(iocb->ki_flags & IOCB_DIRECT) &&
-	    (iocb->ki_flags & IOCB_NOWAIT))
+	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
 		return -EOPNOTSUPP;
 
 	if (sync)
 		atomic_inc(&inode->sync_writers);
 
-	if (iocb->ki_flags & IOCB_DIRECT)
-		num_written = btrfs_direct_write(iocb, from);
-	else
-		num_written = btrfs_buffered_write(iocb, from);
+	if (encoded) {
+		num_written = btrfs_encoded_write(iocb, from, encoded);
+		num_sync = encoded->len;
+	} else if (iocb->ki_flags & IOCB_DIRECT) {
+		num_written = num_sync = btrfs_direct_write(iocb, from);
+	} else {
+		num_written = num_sync = btrfs_buffered_write(iocb, from);
+	}
 
 	btrfs_set_inode_last_sub_trans(inode);
 
-	if (num_written > 0)
-		num_written = generic_write_sync(iocb, num_written);
+	if (num_sync > 0) {
+		num_sync = generic_write_sync(iocb, num_sync);
+		if (num_sync < 0)
+			num_written = num_sync;
+	}
 
 	if (sync)
 		atomic_dec(&inode->sync_writers);
@@ -2041,6 +2078,12 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	return num_written;
 }
 
+static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
+				    struct iov_iter *from)
+{
+	return btrfs_do_write_iter(iocb, from, NULL);
+}
+
 int btrfs_release_file(struct inode *inode, struct file *filp)
 {
 	struct btrfs_file_private *private = filp->private_data;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d7fae859fb5..c93ea5b3a2d0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -966,7 +966,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				    ins.offset, async_extent->pages,
 				    async_extent->nr_pages,
 				    async_chunk->write_flags,
-				    async_chunk->blkcg_css)) {
+				    async_chunk->blkcg_css, true)) {
 			struct page *p = async_extent->pages[0];
 			const u64 start = async_extent->start;
 			const u64 end = start + async_extent->ram_size - 1;
@@ -2967,6 +2967,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	 * except if the ordered extent was truncated.
 	 */
 	update_inode_bytes = test_bit(BTRFS_ORDERED_DIRECT, &oe->flags) ||
+			     test_bit(BTRFS_ORDERED_ENCODED, &oe->flags) ||
 			     test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags);
 
 	return insert_reserved_file_extent(trans, BTRFS_I(oe->inode),
@@ -3001,7 +3002,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 	    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags) &&
-	    !test_bit(BTRFS_ORDERED_DIRECT, &ordered_extent->flags))
+	    !test_bit(BTRFS_ORDERED_DIRECT, &ordered_extent->flags) &&
+	    !test_bit(BTRFS_ORDERED_ENCODED, &ordered_extent->flags))
 		clear_bits |= EXTENT_DELALLOC_NEW;
 
 	freespace_inode = btrfs_is_free_space_inode(inode);
@@ -10985,6 +10987,256 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	return ret;
 }
 
+ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			      const struct btrfs_ioctl_encoded_io_args *encoded)
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
+	case BTRFS_ENCODED_IO_COMPRESSION_ZLIB:
+		compression = BTRFS_COMPRESS_ZLIB;
+		break;
+	case BTRFS_ENCODED_IO_COMPRESSION_ZSTD:
+		compression = BTRFS_COMPRESS_ZSTD;
+		break;
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_4K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_8K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_16K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_32K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_64K:
+		/* The page size must match for LZO. */
+		if (encoded->compression -
+		    BTRFS_ENCODED_IO_COMPRESSION_LZO_4K + 12 != PAGE_SHIFT)
+			return -EINVAL;
+		compression = BTRFS_COMPRESS_LZO;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (encoded->encryption != BTRFS_ENCODED_IO_ENCRYPTION_NONE)
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
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7a0a9c752624..13a0a65c6a43 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -103,6 +103,8 @@ struct btrfs_ioctl_encoded_io_args_32 {
 
 #define BTRFS_IOC_ENCODED_READ_32 _IOR(BTRFS_IOCTL_MAGIC, 64, \
 				       struct btrfs_ioctl_encoded_io_args_32)
+#define BTRFS_IOC_ENCODED_WRITE_32 _IOW(BTRFS_IOCTL_MAGIC, 64, \
+					struct btrfs_ioctl_encoded_io_args_32)
 #endif
 
 /* Mask out flags that are inappropriate for the given type of inode. */
@@ -4992,6 +4994,102 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 	return ret;
 }
 
+static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp,
+				     bool compat)
+{
+	struct btrfs_ioctl_encoded_io_args args;
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
+	if (!(file->f_mode & FMODE_WRITE)) {
+		ret = -EBADF;
+		goto out_acct;
+	}
+
+	if (compat) {
+#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
+		struct btrfs_ioctl_encoded_io_args_32 args32;
+
+		if (copy_from_user(&args32, argp, sizeof(args32))) {
+			ret = -EFAULT;
+			goto out_acct;
+		}
+		args.iov = compat_ptr(args32.iov);
+		args.iovcnt = args.iovcnt;
+		memcpy(&args.offset, &args32.offset,
+		       sizeof(args) -
+		       offsetof(struct btrfs_ioctl_encoded_io_args, offset));
+#else
+		return -ENOTTY;
+#endif
+	} else {
+		if (copy_from_user(&args, argp, sizeof(args))) {
+			ret = -EFAULT;
+			goto out_acct;
+		}
+	}
+
+	ret = -EINVAL;
+	if (args.flags != 0)
+		goto out_acct;
+	if (memchr_inv(args.reserved, 0, sizeof(args.reserved)))
+		goto out_acct;
+	if (args.compression == BTRFS_ENCODED_IO_COMPRESSION_NONE &&
+	    args.encryption == BTRFS_ENCODED_IO_ENCRYPTION_NONE)
+		goto out_acct;
+	if (args.compression >= BTRFS_ENCODED_IO_COMPRESSION_TYPES ||
+	    args.encryption >= BTRFS_ENCODED_IO_ENCRYPTION_TYPES)
+		goto out_acct;
+	if (args.unencoded_offset > args.unencoded_len)
+		goto out_acct;
+	if (args.len > args.unencoded_len - args.unencoded_offset)
+		goto out_acct;
+
+	ret = import_iovec(WRITE, args.iov, args.iovcnt, ARRAY_SIZE(iovstack),
+			   &iov, &iter);
+	if (ret < 0)
+		goto out_acct;
+
+	file_start_write(file);
+
+	if (iov_iter_count(&iter) == 0) {
+		ret = 0;
+		goto out_end_write;
+	}
+	pos = args.offset;
+	ret = rw_verify_area(WRITE, file, &pos, args.len);
+	if (ret < 0)
+		goto out_end_write;
+
+	init_sync_kiocb(&kiocb, file);
+	ret = kiocb_set_rw_flags(&kiocb, 0);
+	if (ret)
+		goto out_end_write;
+	kiocb.ki_pos = pos;
+
+	ret = btrfs_do_write_iter(&kiocb, &iter, &args);
+	if (ret > 0)
+		fsnotify_modify(file);
+
+out_end_write:
+	file_end_write(file);
+	kfree(iov);
+out_acct:
+	if (ret > 0)
+		add_wchar(current, ret);
+	inc_syscw(current);
+	return ret;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -5138,9 +5236,13 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return fsverity_ioctl_measure(file, argp);
 	case BTRFS_IOC_ENCODED_READ:
 		return btrfs_ioctl_encoded_read(file, argp, false);
+	case BTRFS_IOC_ENCODED_WRITE:
+		return btrfs_ioctl_encoded_write(file, argp, false);
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 	case BTRFS_IOC_ENCODED_READ_32:
 		return btrfs_ioctl_encoded_read(file, argp, true);
+	case BTRFS_IOC_ENCODED_WRITE_32:
+		return btrfs_ioctl_encoded_write(file, argp, true);
 #endif
 	}
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 550c34fa0e6d..180f302dee93 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -521,9 +521,15 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
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
index 0feb0c29839e..04588ccad34c 100644
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


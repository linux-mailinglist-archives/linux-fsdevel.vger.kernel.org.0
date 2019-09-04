Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E1BA9239
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfIDTNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 15:13:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39399 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732132AbfIDTNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:13:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id s12so6864749pfe.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2019 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFx+cKaqONfKo7l9o0OrW6Tn3r1kfl4Nlyn83MqHv9I=;
        b=Rd8moC2NdLdL/QevCzhNYg9CKFTRg2xoV6b+ZCy11iaRc1NTLIw/O7VQ9oiMvNLMm3
         RLgGQ/Y32tX/Pv3R/aF0sB6+KzNLc7Iv2guQIMHgD4roWrPlL3I9inWlgPIgIP6ahBdW
         EByfarRcWmaXDNTKFwAxZ5dRXe/c89ky2PdbIHq7qpkviaG9f7Xc9XwuSYLoFRABD7aB
         rlrC8iwnRMyxA3mfyLwPpx6JWir3TRWJy1CkmVvK0Sf8MDCns9Jj77koQwXoGZ5CW7C4
         ycBJ+lA2ipVBIM0ESQdRWlRpgSO1OpxBtXPDJbfRs0fmLOyHJFDa+esjpequySNXNMIT
         baoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFx+cKaqONfKo7l9o0OrW6Tn3r1kfl4Nlyn83MqHv9I=;
        b=PYGBwr3On60wdLFhZEj8Oe9+hDeQMNm052i9T7rR9Y3zBgCYmzeseAuel0qTjJG+n/
         MiowimtXbvyfW2iHNgLbVBD6aElr2/6CNgLqRQOFRPT86rDvmusHZUDHbXbXuV9clcHF
         vkPzC1qvlSL1kuS7d/JhsCSpHQ+yYoMlrS7TQSRooahSlIdyCGs19xdae3IORERzTJJ7
         RoQo94geo69WHKSsk11aEiVQnayI71dCBYelZ64XRnnPU3zvi0vVLz0IONAtKoeKu3R2
         iOev0huOwG+JArkN51QlJekEEYqdJUm8Njcc3ZlfrYXJegVVfUU054MAcDmGbbRTDwoA
         Tg3A==
X-Gm-Message-State: APjAAAVDrE/3xWZLJuMegznYHfwmVt7y6YxCBcrVYr+yuriKlq7HqCeL
        X55Za8gENIyF0c9XBbYYvv7Qqw==
X-Google-Smtp-Source: APXvYqyGJwv45ytQkElALWHjS6dIf4tjape45WkRcE05Ar78vyUYplvqbTsQyRCgv98govifuHwbjw==
X-Received: by 2002:a17:90a:c38d:: with SMTP id h13mr6809273pjt.115.1567624416549;
        Wed, 04 Sep 2019 12:13:36 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::3502])
        by smtp.gmail.com with ESMTPSA id w6sm5495661pfw.84.2019.09.04.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:13:36 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] btrfs: add ioctl for directly writing compressed data
Date:   Wed,  4 Sep 2019 12:13:26 -0700
Message-Id: <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567623877.git.osandov@fb.com>
References: <cover.1567623877.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This adds an API for writing compressed data directly to the filesystem.
The use case that I have in mind is send/receive: currently, when
sending data from one compressed filesystem to another, the sending side
decompresses the data and the receiving side recompresses it before
writing it out. This is wasteful and can be avoided if we can just send
and write compressed extents. The send part will be implemented in a
separate series, as this ioctl can stand alone.

The interface is essentially pwrite(2) with some extra information:

- The input buffer contains the compressed data.
- Both the compressed and decompressed sizes of the data are given.
- The compression type (zlib, lzo, or zstd) is given.

The interface is general enough that it can be extended to encrypted or
otherwise encoded extents in the future. A more detailed description,
including restrictions and edge cases, is included in
include/uapi/linux/btrfs.h.

The implementation is similar to direct I/O: we have to flush any
ordered extents, invalidate the page cache, and do the io
tree/delalloc/extent map/ordered extent dance. From there, we can reuse
the compression code with a minor modification to distinguish the new
ioctl from writeback.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c     |   6 +-
 fs/btrfs/compression.h     |  14 +--
 fs/btrfs/ctree.h           |   6 ++
 fs/btrfs/file.c            |  13 ++-
 fs/btrfs/inode.c           | 192 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ioctl.c           |  95 ++++++++++++++++++
 include/uapi/linux/btrfs.h |  69 +++++++++++++
 7 files changed, 380 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b05b361e2062..6632dd8d2e4d 100644
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
index 4cb8be9ff88b..5b48eb730362 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -6,6 +6,7 @@
 #ifndef BTRFS_COMPRESSION_H
 #define BTRFS_COMPRESSION_H
 
+#include <linux/btrfs.h>
 #include <linux/sizes.h>
 
 /*
@@ -47,6 +48,9 @@ struct compressed_bio {
 	/* the compression algorithm for this bio */
 	int compress_type;
 
+	/* Whether this is a write for writeback. */
+	bool writeback;
+
 	/* number of compressed pages in the array */
 	unsigned long nr_pages;
 
@@ -93,20 +97,12 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				  unsigned long compressed_len,
 				  struct page **compressed_pages,
 				  unsigned long nr_pages,
-				  unsigned int write_flags);
+				  unsigned int write_flags, bool writeback);
 blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
-enum btrfs_compression_type {
-	BTRFS_COMPRESS_NONE  = 0,
-	BTRFS_COMPRESS_ZLIB  = 1,
-	BTRFS_COMPRESS_LZO   = 2,
-	BTRFS_COMPRESS_ZSTD  = 3,
-	BTRFS_COMPRESS_TYPES = 3,
-};
-
 struct workspace_manager {
 	const struct btrfs_compress_op *ops;
 	struct list_head idle_ws;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 19d669d12ca1..9fae9b3f1f62 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2905,6 +2905,10 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
+
+ssize_t btrfs_raw_write(struct kiocb *iocb, struct iov_iter *from,
+			struct btrfs_ioctl_raw_pwrite_args *raw);
+
 extern const struct dentry_operations btrfs_dentry_operations;
 
 /* ioctl.c */
@@ -2928,6 +2932,8 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 			   struct btrfs_inode *inode);
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
+ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
+			    struct btrfs_ioctl_raw_pwrite_args *args);
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
 void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 			     int skip_pinned);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8fe4eb7e5045..ed23aa65b2d5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1872,8 +1872,8 @@ static void update_time_for_write(struct inode *inode)
 		inode_inc_iversion(inode);
 }
 
-static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
-				    struct iov_iter *from)
+ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
+			    struct btrfs_ioctl_raw_pwrite_args *raw)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
@@ -1965,7 +1965,9 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	if (sync)
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
+	if (raw) {
+		num_written = btrfs_raw_write(iocb, from, raw);
+	} else if (iocb->ki_flags & IOCB_DIRECT) {
 		num_written = __btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
@@ -1996,6 +1998,11 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	return num_written ? num_written : err;
 }
 
+static ssize_t btrfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return btrfs_do_write_iter(iocb, from, NULL);
+}
+
 int btrfs_release_file(struct inode *inode, struct file *filp)
 {
 	struct btrfs_file_private *private = filp->private_data;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a0546401bc0a..c8eaa1e5bf06 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -865,7 +865,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				    ins.objectid,
 				    ins.offset, async_extent->pages,
 				    async_extent->nr_pages,
-				    async_chunk->write_flags)) {
+				    async_chunk->write_flags, true)) {
 			struct page *p = async_extent->pages[0];
 			const u64 start = async_extent->start;
 			const u64 end = start + async_extent->ram_size - 1;
@@ -10590,6 +10590,196 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
 	}
 }
 
+/* Currently, this only supports raw writes of compressed data. */
+ssize_t btrfs_raw_write(struct kiocb *iocb, struct iov_iter *from,
+			struct btrfs_ioctl_raw_pwrite_args *raw)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct extent_changeset *data_reserved = NULL;
+	struct extent_state *cached_state = NULL;
+	unsigned long nr_pages, i;
+	struct page **pages;
+	u64 disk_num_bytes, num_bytes;
+	u64 start, end;
+	struct btrfs_key ins;
+	struct extent_map *em;
+	ssize_t ret;
+
+	if (iov_iter_count(from) != raw->num_bytes) {
+		/*
+		 * The write got truncated by generic_write_checks(). We can't
+		 * do a partial raw write.
+		 */
+		return -EFBIG;
+	}
+
+	/* This should be handled higher up. */
+	ASSERT(raw->num_bytes != 0);
+
+	/* The extent size must be sane. */
+	if (raw->num_bytes > BTRFS_MAX_UNCOMPRESSED ||
+	    raw->disk_num_bytes > BTRFS_MAX_COMPRESSED ||
+	    raw->disk_num_bytes == 0)
+		return -EINVAL;
+
+	/*
+	 * The compressed data on disk must be sector-aligned. For convenience,
+	 * we extend the compressed data with zeroes if it isn't.
+	 */
+	disk_num_bytes = ALIGN(raw->disk_num_bytes, fs_info->sectorsize);
+	/*
+	 * The extent in the file must also be sector-aligned. However, we allow
+	 * a write which ends at or extends i_size to have an unaligned length;
+	 * we round up the extent size and set i_size to the given length.
+	 */
+	start = iocb->ki_pos;
+	if ((start & (fs_info->sectorsize - 1)))
+		return -EINVAL;
+	if (start + raw->num_bytes >= inode->i_size) {
+		num_bytes = ALIGN(raw->num_bytes, fs_info->sectorsize);
+	} else {
+		num_bytes = raw->num_bytes;
+		if ((num_bytes & (fs_info->sectorsize - 1)))
+			return -EINVAL;
+	}
+	end = start + num_bytes - 1;
+
+	/*
+	 * It's valid for compressed data to be larger than or the same size as
+	 * the decompressed data. However, for buffered I/O, we never write out
+	 * a compressed extent unless it's smaller than the decompressed data,
+	 * so for now, let's not allow creating such extents with the ioctl,
+	 * either.
+	 */
+	if (disk_num_bytes >= num_bytes)
+		return -EINVAL;
+
+	nr_pages = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
+	pages = kcalloc(nr_pages, sizeof(struct page *),
+			GFP_USER | __GFP_NOWARN);
+	if (!pages)
+		return -ENOMEM;
+	for (i = 0; i < nr_pages; i++) {
+		unsigned long offset = i << PAGE_SHIFT, n;
+		char *kaddr;
+
+		pages[i] = alloc_page(GFP_USER | __GFP_NOWARN);
+		if (!pages[i]) {
+			ret = -ENOMEM;
+			goto out_pages;
+		}
+		kaddr = kmap(pages[i]);
+		if (offset < raw->disk_num_bytes) {
+			n = min_t(unsigned long, PAGE_SIZE,
+				  raw->disk_num_bytes - offset);
+			if (copy_from_user(kaddr, raw->buf + offset, n)) {
+				kunmap(pages[i]);
+				ret = -EFAULT;
+				goto out_pages;
+			}
+		} else {
+			n = 0;
+		}
+		if (n < PAGE_SIZE)
+			memset(kaddr + n, 0, PAGE_SIZE - n);
+		kunmap(pages[i]);
+	}
+
+	for (;;) {
+		struct btrfs_ordered_extent *ordered;
+
+		lock_extent_bits(io_tree, start, end, &cached_state);
+		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
+						     end - start + 1);
+		if (!ordered &&
+		    !filemap_range_has_page(inode->i_mapping, start, end))
+			break;
+		if (ordered)
+			btrfs_put_ordered_extent(ordered);
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, end,
+				     &cached_state);
+		cond_resched();
+		ret = btrfs_wait_ordered_range(inode, start, end);
+		if (ret)
+			goto out_pages;
+		ret = invalidate_inode_pages2_range(inode->i_mapping,
+						    start >> PAGE_SHIFT,
+						    end >> PAGE_SHIFT);
+		if (ret)
+			goto out_pages;
+	}
+
+	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start,
+					   num_bytes);
+	if (ret)
+		goto out_unlock;
+
+	ret = btrfs_reserve_extent(root, num_bytes, disk_num_bytes,
+				   disk_num_bytes, 0, 0, &ins, 1, 1);
+	if (ret)
+		goto out_delalloc_release;
+
+	em = create_io_em(inode, start, num_bytes, start, ins.objectid,
+			  ins.offset, ins.offset, num_bytes, raw->compression,
+			  BTRFS_ORDERED_COMPRESSED);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto out_free_reserve;
+	}
+	free_extent_map(em);
+
+	ret = btrfs_add_ordered_extent_compress(inode, start, ins.objectid,
+						num_bytes, ins.offset,
+						BTRFS_ORDERED_COMPRESSED,
+						raw->compression);
+	if (ret) {
+		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
+		goto out_free_reserve;
+	}
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+
+	if (start + raw->num_bytes > inode->i_size)
+		i_size_write(inode, start + raw->num_bytes);
+
+	unlock_extent_cached(io_tree, start, end, &cached_state);
+
+	btrfs_delalloc_release_extents(BTRFS_I(inode), num_bytes, false);
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
+	iocb->ki_pos += raw->num_bytes;
+	return raw->num_bytes;
+
+out_free_reserve:
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
+out_delalloc_release:
+	btrfs_delalloc_release_space(inode, data_reserved, start, num_bytes,
+				     true);
+out_unlock:
+	unlock_extent_cached(io_tree, start, end, &cached_state);
+out_pages:
+	for (i = 0; i < nr_pages; i++) {
+		if (pages[i])
+			put_page(pages[i]);
+	}
+	kfree(pages);
+	return ret;
+}
+
 #ifdef CONFIG_SWAP
 /*
  * Add an entry indicating a block group or device which is pinned by a
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index de730e56d3f5..c803732c9722 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -26,6 +26,7 @@
 #include <linux/btrfs.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
+#include <linux/sched/xacct.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -84,6 +85,20 @@ struct btrfs_ioctl_send_args_32 {
 
 #define BTRFS_IOC_SEND_32 _IOW(BTRFS_IOCTL_MAGIC, 38, \
 			       struct btrfs_ioctl_send_args_32)
+
+struct btrfs_ioctl_raw_pwrite_args_32 {
+	__u64 offset;		/* in */
+	__u64 num_bytes;	/* in */
+	__u64 disk_num_bytes;	/* in */
+	__u8 compression;	/* in */
+	__u8 encryption;	/* in */
+	__u16 other_encoding;	/* in */
+	__u32 reserved[7];
+	compat_uptr_t buf;	/* in */
+} __attribute__ ((__packed__));
+
+#define BTRFS_IOC_RAW_PWRITE_32 _IOW(BTRFS_IOCTL_MAGIC, 63, \
+				     struct btrfs_ioctl_raw_pwrite_args_32)
 #endif
 
 static int btrfs_clone(struct inode *src, struct inode *inode,
@@ -5437,6 +5452,80 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
 	return ret;
 }
 
+static int btrfs_ioctl_raw_pwrite(struct file *file, void __user *argp,
+				  bool compat)
+{
+	struct btrfs_ioctl_raw_pwrite_args args;
+	struct iov_iter iter;
+	loff_t pos;
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (compat) {
+#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
+		struct btrfs_ioctl_raw_pwrite_args_32 args32;
+
+		if (copy_from_user(&args32, argp, sizeof(args32)))
+			return -EFAULT;
+		args.offset = args32.offset;
+		args.num_bytes = args32.num_bytes;
+		args.disk_num_bytes = args32.disk_num_bytes;
+		args.compression = args32.compression;
+		args.encryption = args32.encryption;
+		args.other_encoding = args32.other_encoding;
+		memcpy(args.reserved, args32.reserved, sizeof(args.reserved));
+		args.buf = compat_ptr(args32.buf);
+#else
+		return -ENOTTY;
+#endif
+	} else {
+		if (copy_from_user(&args, argp, sizeof(args)))
+			return -EFAULT;
+	}
+
+	/* The compression type must be valid. */
+	if (args.compression == BTRFS_COMPRESS_NONE ||
+	    args.compression > BTRFS_COMPRESS_TYPES)
+		return -EINVAL;
+	/* Reserved fields must be zero. */
+	if (args.encryption || args.other_encoding ||
+	    memchr_inv(args.reserved, 0, sizeof(args.reserved)))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(args.buf, args.disk_num_bytes)))
+		return -EFAULT;
+
+	pos = args.offset;
+	ret = rw_verify_area(WRITE, file, &pos, args.num_bytes);
+	if (ret)
+		return ret;
+
+	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = pos;
+	/*
+	 * This iov_iter is a lie; we only construct it so that we can use
+	 * write_iter.
+	 */
+	iov_iter_init(&iter, WRITE, NULL, 0, args.num_bytes);
+
+	file_start_write(file);
+	ret = btrfs_do_write_iter(&kiocb, &iter, &args);
+	if (ret > 0) {
+		ASSERT(ret == args.num_bytes);
+		fsnotify_modify(file);
+		add_wchar(current, ret);
+	}
+	inc_syscw(current);
+	file_end_write(file);
+	return ret < 0 ? ret : 0;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -5583,6 +5672,12 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_subvol_rootref(file, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
+	case BTRFS_IOC_RAW_PWRITE:
+		return btrfs_ioctl_raw_pwrite(file, argp, false);
+#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
+	case BTRFS_IOC_RAW_PWRITE_32:
+		return btrfs_ioctl_raw_pwrite(file, argp, true);
+#endif
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 3ee0678c0a83..b4dce062265a 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -822,6 +822,73 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 		__u8 align[7];
 };
 
+enum btrfs_compression_type {
+	BTRFS_COMPRESS_NONE  = 0,
+	BTRFS_COMPRESS_ZLIB  = 1,
+	BTRFS_COMPRESS_LZO   = 2,
+	BTRFS_COMPRESS_ZSTD  = 3,
+	BTRFS_COMPRESS_TYPES = 3,
+};
+
+/*
+ * Write an extent directly to the filesystem. CAP_SYS_ADMIN is required and the
+ * file descriptor must be open for writing.
+ *
+ * Currently, this is only for writing compressed data. However, it may be
+ * extended in the future.
+ */
+struct btrfs_ioctl_raw_pwrite_args {
+	/*
+	 * Offset in file where to write. This must be aligned to the sector
+	 * size of the filesystem.
+	 */
+	__u64 offset;		/* in */
+	/*
+	 * Length of the extent in the file, in bytes. This must be aligned to
+	 * the sector size of the filesystem unless the data ends at or beyond
+	 * the current end of file; this special case is to support creating
+	 * files whose length is not aligned to the sector size.
+	 *
+	 * For a compressed extent, this is the length of the decompressed data.
+	 * It must be less than 128k (BTRFS_MAX_UNCOMPRESSED), although that
+	 * limit may increase in the future.
+	 */
+	__u64 num_bytes;	/* in */
+	/*
+	 * Length of the extent on disk, in bytes (see buf below).
+	 *
+	 * For a compressed extent, this does not need to be aligned to a
+	 * sector. It must be less than 128k (BTRFS_MAX_COMPRESSED), although
+	 * that limit may increase in the future.
+	 */
+	__u64 disk_num_bytes;	/* in */
+	/*
+	 * Compression type (enum btrfs_compression_type). Currently, this must
+	 * not be BTRFS_COMPRESS_NONE.
+	 */
+	__u8 compression;	/* in */
+	/* Encryption type. Currently, this must be zero. */
+	__u8 encryption;	/* in */
+	/* Other type of encoding. Currently, this must be zero. */
+	__u16 other_encoding;	/* in */
+	/* Reserved for future extensions. Must be zero. */
+	__u32 reserved[7];
+	/*
+	 * The raw data on disk.
+	 *
+	 * For a compressed extent, the format is as follows:
+	 *
+	 * - zlib: The extent is a single zlib stream.
+	 * - lzo: The extent is compressed page by page with LZO1X and wrapped
+	 *   according to the format documented in fs/btrfs/lzo.c.
+	 * - zstd: The extent is a single zstd stream. The windowLog compression
+	 *   parameter must be no more than 17 (ZSTD_BTRFS_MAX_WINDOWLOG).
+	 *
+	 * If the compressed data is invalid, reading will return an error.
+	 */
+	void __user *buf;	/* in */
+} __attribute__ ((__packed__));
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
@@ -946,5 +1013,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_RAW_PWRITE _IOW(BTRFS_IOCTL_MAGIC, 63, \
+				  struct btrfs_ioctl_raw_pwrite_args)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.23.0


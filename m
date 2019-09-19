Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CFEB7389
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 08:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfISGyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 02:54:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36761 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbfISGyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:54:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id f19so1153250plr.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 23:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDCHZomv4g4lpTHlYPFO3tywHDdATr8alzdqaJYaWNY=;
        b=cCt4oDbq6PuI+fVUq0QVDExYwTKfkTSLnCpVk5iZ4mhjZqSkD0yqJIso+i4VunvBnT
         xBQIcWxHgTOZe6AZCysRYiLBGRYqda6g2cR1g1JkOzXYfqSW5M+aCU9dFQ9sxfTP9p0l
         YXW+bU0wRDQokVNOqfBdxkgrkm44z/XV9zsqcmL3S1BcBSc6siFvjp6bPbtAZaCfniIJ
         w+RcY9V1EgsXpbL9cHzc5n5S15X1KUYT0Ot86GiepCaLlVc6SqC7HFLw/qOcKNg0+xc1
         M0I0fC0YhndC2FuydV0aRUE7CMuGDOo5/m3PDokFQGlXMxJ4x529JqCGqwo5wpmOFauW
         KQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDCHZomv4g4lpTHlYPFO3tywHDdATr8alzdqaJYaWNY=;
        b=Spzq5YrhxTcD4eYZ4nD1h4EewzHrVX9bMDoq3SpC00iTku4L9eRhiqcgZZTDxt7MhX
         Kl86FRDwMpLlq8UZQ18eRGq0MZtixF4XFbex6MoegYaxGYhgqKPi3peoL2ZzqduV5Xae
         U/oQgMjPVx1XX9NRpElfGh3kjGhF7JFtgdJSYfHpPfZYbPRUS8NeRLwwwmwKGwNItnXp
         Sw2NzDr5kXKK2JtINX5buZxOET4KT3oWxdd9yKaXCtwOacxypeOY4E2EfMYmRuJH5Cg2
         qXI9qNbbqKA69y19fPPvO3F6aowHyhMgEw+xsZzJDcCXmq1i69KR9xxGOSF6JmZ87Q97
         ZnCg==
X-Gm-Message-State: APjAAAVGPBtZfvbSLA5KqkIJc6cuc5QHXpeXZGBnQnmZ71Nmz3B5SoMD
        +oDiR13AmziiwZ7hzUmhxAndwHAUVbU=
X-Google-Smtp-Source: APXvYqwa+YGyPmC6c48S1pn3GXaAwATNzRmMm7plE7XA59xzKeNx+caxtUJygezndazeysE0goVn4w==
X-Received: by 2002:a17:902:8645:: with SMTP id y5mr8303800plt.191.1568876040867;
        Wed, 18 Sep 2019 23:54:00 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::332b])
        by smtp.gmail.com with ESMTPSA id m24sm6623615pgj.71.2019.09.18.23.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 23:54:00 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH 3/3] btrfs: implement encoded (compressed) writes
Date:   Wed, 18 Sep 2019 23:53:47 -0700
Message-Id: <17fd5172adea93180afc8066cc8dfc37d827637f.1568875700.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568875700.git.osandov@fb.com>
References: <cover.1568875700.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This adds support to Btrfs for the RWF_ENCODED flag to pwritev2(). The
implementation is similar to direct I/O: we have to flush any ordered
extents, invalidate the page cache, and do the io tree/delalloc/extent
map/ordered extent dance. From there, we can reuse the compression code
with a minor modification to distinguish the write from writeback.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c |   6 +-
 fs/btrfs/compression.h |   5 +-
 fs/btrfs/ctree.h       |   4 +
 fs/btrfs/file.c        |  40 +++++++--
 fs/btrfs/inode.c       | 190 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 232 insertions(+), 13 deletions(-)

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
index 19d669d12ca1..76962d319316 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2905,6 +2905,10 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
+
+ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			    struct encoded_iov *encoded);
+
 extern const struct dentry_operations btrfs_dentry_operations;
 
 /* ioctl.c */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8fe4eb7e5045..068b7f2cc243 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1872,8 +1872,7 @@ static void update_time_for_write(struct inode *inode)
 		inode_inc_iversion(inode);
 }
 
-static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
-				    struct iov_iter *from)
+static ssize_t btrfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
@@ -1883,14 +1882,22 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
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
+	if (iocb->ki_flags & IOCB_ENCODED) {
+		err = import_encoded_write(iocb, &encoded, from);
+		if (err)
+			return err;
+	}
+
+	if ((iocb->ki_flags & IOCB_NOWAIT) &&
+	    (!(iocb->ki_flags & IOCB_DIRECT) ||
+	     (iocb->ki_flags & IOCB_ENCODED)))
 		return -EOPNOTSUPP;
 
 	if (!inode_trylock(inode)) {
@@ -1899,14 +1906,27 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
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
+		count = encoded.unencoded_len;
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
@@ -1965,7 +1985,9 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	if (sync)
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
+	if (iocb->ki_flags & IOCB_ENCODED) {
+		num_written = btrfs_encoded_write(iocb, from, &encoded);
+	} else if (iocb->ki_flags & IOCB_DIRECT) {
 		num_written = __btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
@@ -3440,7 +3462,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_ENCODED_IO;
 	return generic_file_open(inode, filp);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a0546401bc0a..90ca8537df8e 100644
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
@@ -10590,6 +10590,194 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
 	}
 }
 
+ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			    struct encoded_iov *encoded)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct extent_changeset *data_reserved = NULL;
+	struct extent_state *cached_state = NULL;
+	int compression;
+	u64 disk_num_bytes, num_bytes;
+	u64 start, end;
+	unsigned long nr_pages, i;
+	struct page **pages;
+	struct btrfs_key ins;
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
+
+	disk_num_bytes = iov_iter_count(from);
+
+	/* The extent size must be sane. */
+	if (encoded->unencoded_len > BTRFS_MAX_UNCOMPRESSED ||
+	    disk_num_bytes > BTRFS_MAX_COMPRESSED ||
+	    disk_num_bytes == 0)
+		return -EINVAL;
+
+	/*
+	 * The compressed data on disk must be sector-aligned. For convenience,
+	 * we extend the compressed data with zeroes if it isn't.
+	 */
+	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->sectorsize);
+	/*
+	 * The extent in the file must also be sector-aligned. However, we allow
+	 * a write which ends at or extends i_size to have an unaligned length;
+	 * we round up the extent size and set i_size to the given length.
+	 */
+	start = iocb->ki_pos;
+	if (!IS_ALIGNED(start, fs_info->sectorsize))
+		return -EINVAL;
+	if (start + encoded->unencoded_len >= inode->i_size) {
+		num_bytes = ALIGN(encoded->unencoded_len, fs_info->sectorsize);
+	} else {
+		num_bytes = encoded->unencoded_len;
+		if (!IS_ALIGNED(num_bytes, fs_info->sectorsize))
+			return -EINVAL;
+	}
+	end = start + num_bytes - 1;
+
+	/*
+	 * It's valid for compressed data to be larger than or the same size as
+	 * the decompressed data. However, for buffered I/O, we never write out
+	 * a compressed extent unless it's smaller than the decompressed data,
+	 * so for now, let's not allow creating such extents explicity, either.
+	 */
+	if (disk_num_bytes >= num_bytes)
+		return -EINVAL;
+
+	nr_pages = (disk_num_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pages = kvcalloc(nr_pages, sizeof(struct page *), GFP_USER);
+	if (!pages)
+		return -ENOMEM;
+	for (i = 0; i < nr_pages; i++) {
+		size_t bytes;
+		char *kaddr;
+
+		pages[i] = alloc_page(GFP_USER);
+		if (!pages[i]) {
+			ret = -ENOMEM;
+			goto out_pages;
+		}
+		kaddr = kmap(pages[i]);
+		bytes = min_t(size_t, PAGE_SIZE, iov_iter_count(from));
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
+			  ins.offset, ins.offset, num_bytes, compression,
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
+						compression);
+	if (ret) {
+		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
+		goto out_free_reserve;
+	}
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+
+	if (start + encoded->unencoded_len > inode->i_size)
+		i_size_write(inode, start + encoded->unencoded_len);
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
+	iocb->ki_pos += encoded->unencoded_len;
+	return encoded->unencoded_len;
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
+	kvfree(pages);
+	return ret;
+}
+
 #ifdef CONFIG_SWAP
 /*
  * Add an entry indicating a block group or device which is pinned by a
-- 
2.23.0


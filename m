Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B34DD7F4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbfJOSnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:43:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44741 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfJOSnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:43:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so9987153pll.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2P4yK7ExLp5umtVjGj04165cdN5E9l7hwsUvPQgbWHc=;
        b=zN2+N8js0beCW4Vj2hQN8LEC23pgf7H2OmdYrYNfaabjotPpQS0uSkT3EhzOfimCxg
         pcerRmoRUadz2yhmCHU8mL6OKfD+Wm3mLLbskaIRQeoBGaj4r95kLd2t0FucJDuGgjan
         Yxw2JuW5lU8yjnpEZ+3L5oURi6FIIxfqU8TAgtm8rVcL7TK3LR6G6gXztnWwoEUqPaF0
         Zuz7/Ejld1cEvDWeFvWyI5wjlDSwJ+u7K/8qaWEN+zvSp5wXQrDjPK2Y5S0zjBsNvLZ/
         0niSZ45eP4uIlEh996/ohtaj/zWNf7D74bMVU7LOAD/yI/acV8Wub5UPI/3vB2cP/+OG
         Yh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2P4yK7ExLp5umtVjGj04165cdN5E9l7hwsUvPQgbWHc=;
        b=FxeSrljTKKSJOGs01ociLM58Iys5cZj6xinLA2L/z9XvkG9Z67TQFk8CeI9cWaFdD8
         rCUIB8+wcws/4lFXY1yQlYnC0hDiGsmwDc7sKOruz7lLQuNfxXNwXC56eHOxDN0k4Ysm
         Rg8TxBG7/5WdE3qZ25WYy2FMpyvUzG9xEQbNQD/oDN1gscXMk4m1CTffq5b6uJokIfB7
         VMjWAocRUnHe5wlL/yoxZUIdbfBt463uQB9BEF+mZFIZjsHeMeuu4Etnosmar5glJ4k9
         +t/mb4Do2tEI9JPifeyPyVQ5BPfos/HNGVEaDi6JGnYNDSIDYYRfXqRWtaJCVK0PLwyS
         sHvg==
X-Gm-Message-State: APjAAAWyVnCfkdKF6CL7QPHONkDFZgMySJTzacTlMmv6kmc1hrIoi6Ur
        vfX0Ah9qF5eRaDI7JUZPVj0TqfipYPc=
X-Google-Smtp-Source: APXvYqxkHh8h3sSzm9pE95/SiBuhGn2lle0uaAmCiDVzwHIt/vUphw6mmRvl8dfu25K9gYBKhOb38Q==
X-Received: by 2002:a17:902:8216:: with SMTP id x22mr37862515pln.232.1571164989392;
        Tue, 15 Oct 2019 11:43:09 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:3e5e])
        by smtp.gmail.com with ESMTPSA id z3sm40396pjd.25.2019.10.15.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:43:08 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH v2 5/5] btrfs: implement RWF_ENCODED writes
Date:   Tue, 15 Oct 2019 11:42:43 -0700
Message-Id: <904de93d9bbe630aff7f725fd587810c6eb48344.1571164762.git.osandov@fb.com>
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

The implementation resembles direct I/O: we have to flush any ordered
extents, invalidate the page cache, and do the io tree/delalloc/extent
map/ordered extent dance. From there, we can reuse the compression code
with a minor modification to distinguish the write from writeback.

Now that read and write are implemented, this also sets the
FMODE_ENCODED_IO flag in btrfs_file_open().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c |   6 +-
 fs/btrfs/compression.h |   5 +-
 fs/btrfs/ctree.h       |   2 +
 fs/btrfs/file.c        |  40 +++++++--
 fs/btrfs/inode.c       | 197 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 237 insertions(+), 13 deletions(-)

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
index 3b2aa1c7218c..9e1719e82cc8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2907,6 +2907,8 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			    struct encoded_iov *encoded);
 
 extern const struct dentry_operations btrfs_dentry_operations;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 51740cee39fc..8de6ac9b4b9c 100644
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
@@ -1904,14 +1903,22 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
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
@@ -1920,14 +1927,27 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
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
@@ -3461,7 +3483,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_ENCODED_IO;
 	return generic_file_open(inode, filp);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 174d0738d2c9..bcc5a2bed22b 100644
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
@@ -11055,6 +11055,201 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
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
+	disk_num_bytes = orig_count = iov_iter_count(from);
+
+	/* For now, it's too hard to support bookend extents. */
+	if (encoded->unencoded_len != encoded->len ||
+	    encoded->unencoded_offset != 0)
+		return -EINVAL;
+
+	/* The extent size must be sane. */
+	if (encoded->unencoded_len > BTRFS_MAX_UNCOMPRESSED ||
+	    disk_num_bytes > BTRFS_MAX_COMPRESSED || disk_num_bytes == 0)
+		return -EINVAL;
+
+	/*
+	 * The compressed data on disk must be sector-aligned. For convenience,
+	 * we extend it with zeroes if it isn't.
+	 */
+	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->sectorsize);
+
+	/*
+	 * The extent in the file must also be sector-aligned. However, we allow
+	 * a write which ends at or extends i_size to have an unaligned length;
+	 * we round up the extent size and set i_size to the given length.
+	 */
+	start = iocb->ki_pos;
+	if (!IS_ALIGNED(start, fs_info->sectorsize))
+		return -EINVAL;
+	if (start + encoded->len >= inode->i_size) {
+		num_bytes = ALIGN(encoded->len, fs_info->sectorsize);
+	} else {
+		num_bytes = encoded->len;
+		if (!IS_ALIGNED(num_bytes, fs_info->sectorsize))
+			return -EINVAL;
+	}
+
+	/*
+	 * It's valid to have compressed data which is larger than or the same
+	 * size as the decompressed data. However, for buffered I/O, we fall
+	 * back to writing the decompressed data if compression didn't shrink
+	 * it. So, for now, let's not allow creating such extents.
+	 *
+	 * Note that for now this also implicitly prevents writing data that
+	 * would fit in an inline extent.
+	 */
+	if (disk_num_bytes >= num_bytes)
+		return -EINVAL;
+
+	end = start + num_bytes - 1;
+
+	nr_pages = (disk_num_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pages = kvcalloc(nr_pages, sizeof(struct page *), GFP_USER);
+	if (!pages)
+		return -ENOMEM;
+	for (i = 0; i < nr_pages; i++) {
+		size_t bytes = min_t(size_t, PAGE_SIZE, iov_iter_count(from));
+		char *kaddr;
+
+		pages[i] = alloc_page(GFP_HIGHUSER);
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
+		ret = btrfs_wait_ordered_range(inode, start, end - start + 1);
+		if (ret)
+			goto out_pages;
+		ret = invalidate_inode_pages2_range(inode->i_mapping,
+						    start >> PAGE_SHIFT,
+						    end >> PAGE_SHIFT);
+		if (ret)
+			goto out_pages;
+		lock_extent_bits(io_tree, start, end, &cached_state);
+		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
+						     end - start + 1);
+		if (!ordered &&
+		    !filemap_range_has_page(inode->i_mapping, start, end))
+			break;
+		if (ordered)
+			btrfs_put_ordered_extent(ordered);
+		unlock_extent_cached(io_tree, start, end, &cached_state);
+		cond_resched();
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
+	if (start + encoded->len > inode->i_size)
+		i_size_write(inode, start + encoded->len);
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
+	iocb->ki_pos += encoded->len;
+	return orig_count;
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


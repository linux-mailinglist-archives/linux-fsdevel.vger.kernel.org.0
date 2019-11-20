Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48FB104368
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 19:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfKTSZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 13:25:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:43987 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbfKTSZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:25:05 -0500
Received: by mail-pj1-f65.google.com with SMTP id a10so182291pju.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hx2ggmYufWUwQe/y6dbiVyuZiKCwDqeZoan1ILrR/wY=;
        b=gISvoFhLkoU0nX05caTC+mX+VZCPU3QZZZro+1IxyzqJIvjmJRXLsGiuT+rvGhCuvF
         f85L5ICjWdLMz3A+KUn77BHYpBDXqqUX1QWgTFYkqkYG62Lu0rIU6Jndv4qE64jdNqsh
         CVOOur+R/aCmGz1PIQ7gR+qoxOMkiQV51I4GcU5gNm1oAh67td9GNDhJIuYdJhFmBefu
         r9F0fjgftA7X4ObVxPROHNvcyziFhu3JnBQMr6A8YXXgZJO1IROMgK0QEIjiRI5DIk4+
         J6/4SlwSkfbiooQ0rIEIxdnbcMDosqtrtL2EMkbzOJHm7v8QMesJ6FSFdLfdg8y0UPkz
         jpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hx2ggmYufWUwQe/y6dbiVyuZiKCwDqeZoan1ILrR/wY=;
        b=BUhHyFcIjEYSfFKx4eH48yodnNyZi8Rsgkx6eB2sBmhXr5T7ylvGZ0/DzJRL8XSxCu
         RnW/bpQc7H1vFD3ceqeKbPyjw8BCc4fghji2RBTLZTNn/GXrZuvgZU1RgtZgsrx8mxwr
         gmBqTX975MV4GkvdzvkFGyluHm2VSDKMZXY7FZAC0uH/dBh46Xw1hpHDGZOrLT1lqCV6
         ONpm1WvVjTnnkHpCJRb0h+JBOR7dRn0ldwa1Vs169UfrGCCPMyoFtwVO48XaJhF1IyQs
         1e3ziZQt57SBMz6KhRORX3OBPfqTB/QYbd08is6iO0CM4MbA5LB2EtyPh/G2bH6jQc1s
         /+HA==
X-Gm-Message-State: APjAAAXuJJuklqP1peC3uGfduMyt1tvtYaxyKr2mh+gUEljth0pTWPgr
        0MHm7+OQ2JWoDNQp5hgsugaIOLsuw30=
X-Google-Smtp-Source: APXvYqyIilZels0XXWzmRRKfaMT2W7apxfsdhtcgHJLUylvWJXzogWkYHPqpYHgC7d5j2tYFieZRIw==
X-Received: by 2002:a17:902:6903:: with SMTP id j3mr4088245plk.231.1574274304139;
        Wed, 20 Nov 2019 10:25:04 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:25:03 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 10/12] btrfs: optionally extend i_size in cow_file_range_inline()
Date:   Wed, 20 Nov 2019 10:24:30 -0800
Message-Id: <4b1b60021a955e9cf9c120d9b03bd6e58e8ab7d9.1574273658.git.osandov@fb.com>
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

Currently, an inline extent is always created after i_size is extended
from btrfs_dirty_pages(). However, for encoded writes, we only want to
update i_size after we successfully created the inline extent. Add an
update_i_size parameter to cow_file_range_inline() and
insert_inline_extent() and pass in the size of the extent rather than
determining it from i_size. Since the start parameter is always passed
as 0, get rid of it and simplify the logic in these two functions. While
we're here, let's document the requirements for creating an inline
extent.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 94 +++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8bc193c99ca..c1c37549155e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -165,9 +165,10 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
 static int insert_inline_extent(struct btrfs_trans_handle *trans,
 				struct btrfs_path *path, int extent_inserted,
 				struct btrfs_root *root, struct inode *inode,
-				u64 start, size_t size, size_t compressed_size,
+				size_t size, size_t compressed_size,
 				int compress_type,
-				struct page **compressed_pages)
+				struct page **compressed_pages,
+				bool update_i_size)
 {
 	struct extent_buffer *leaf;
 	struct page *page = NULL;
@@ -176,7 +177,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *ei;
 	int ret;
 	size_t cur_size = size;
-	unsigned long offset;
+	u64 i_size;
 
 	ASSERT((compressed_size > 0 && compressed_pages) ||
 	       (compressed_size == 0 && !compressed_pages));
@@ -191,7 +192,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		size_t datasize;
 
 		key.objectid = btrfs_ino(BTRFS_I(inode));
-		key.offset = start;
+		key.offset = 0;
 		key.type = BTRFS_EXTENT_DATA_KEY;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
@@ -230,12 +231,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_compression(leaf, ei,
 						  compress_type);
 	} else {
-		page = find_get_page(inode->i_mapping,
-				     start >> PAGE_SHIFT);
+		page = find_get_page(inode->i_mapping, 0);
 		btrfs_set_file_extent_compression(leaf, ei, 0);
 		kaddr = kmap_atomic(page);
-		offset = offset_in_page(start);
-		write_extent_buffer(leaf, kaddr + offset, ptr, size);
+		write_extent_buffer(leaf, kaddr, ptr, size);
 		kunmap_atomic(kaddr);
 		put_page(page);
 	}
@@ -251,7 +250,12 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * before we unlock the pages.  Otherwise we
 	 * could end up racing with unlink.
 	 */
-	BTRFS_I(inode)->disk_i_size = inode->i_size;
+	i_size = i_size_read(inode);
+	if (update_i_size && size > i_size) {
+		i_size_write(inode, size);
+		i_size = size;
+	}
+	BTRFS_I(inode)->disk_i_size = i_size;
 	ret = btrfs_update_inode(trans, root, inode);
 
 fail:
@@ -264,36 +268,31 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
  * does the checks required to make sure the data is small enough
  * to fit as an inline extent.
  */
-static noinline int cow_file_range_inline(struct inode *inode, u64 start,
-					  u64 end, size_t compressed_size,
+static noinline int cow_file_range_inline(struct inode *inode, u64 size,
+					  size_t compressed_size,
 					  int compress_type,
-					  struct page **compressed_pages)
+					  struct page **compressed_pages,
+					  bool update_i_size)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
-	u64 isize = i_size_read(inode);
-	u64 actual_end = min(end + 1, isize);
-	u64 inline_len = actual_end - start;
-	u64 aligned_end = ALIGN(end, fs_info->sectorsize);
-	u64 data_len = inline_len;
+	u64 data_len = compressed_size ? compressed_size : size;
 	int ret;
 	struct btrfs_path *path;
 	int extent_inserted = 0;
 	u32 extent_item_size;
 
-	if (compressed_size)
-		data_len = compressed_size;
-
-	if (start > 0 ||
-	    actual_end > fs_info->sectorsize ||
+	/*
+	 * We can create an inline extent if it ends at or beyond the current
+	 * i_size, is no larger than a sector (decompressed), and the (possibly
+	 * compressed) data fits in a leaf and the configured maximum inline
+	 * size.
+	 */
+	if (size < i_size_read(inode) || size > fs_info->sectorsize ||
 	    data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
-	    (!compressed_size &&
-	    (actual_end & (fs_info->sectorsize - 1)) == 0) ||
-	    end + 1 < isize ||
-	    data_len > fs_info->max_inline) {
+	    data_len > fs_info->max_inline)
 		return 1;
-	}
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -306,27 +305,18 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
 	}
 	trans->block_rsv = &BTRFS_I(inode)->block_rsv;
 
-	if (compressed_size && compressed_pages)
-		extent_item_size = btrfs_file_extent_calc_inline_size(
-		   compressed_size);
-	else
-		extent_item_size = btrfs_file_extent_calc_inline_size(
-		    inline_len);
-
-	ret = __btrfs_drop_extents(trans, root, inode, path,
-				   start, aligned_end, NULL,
-				   1, 1, extent_item_size, &extent_inserted);
+	extent_item_size = btrfs_file_extent_calc_inline_size(data_len);
+	ret = __btrfs_drop_extents(trans, root, inode, path, 0,
+				   fs_info->sectorsize, NULL, 1, 1,
+				   extent_item_size, &extent_inserted);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
-	if (isize > actual_end)
-		inline_len = min_t(u64, isize, actual_end);
-	ret = insert_inline_extent(trans, path, extent_inserted,
-				   root, inode, start,
-				   inline_len, compressed_size,
-				   compress_type, compressed_pages);
+	ret = insert_inline_extent(trans, path, extent_inserted, root, inode,
+				   size, compressed_size, compress_type,
+				   compressed_pages, update_i_size);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -336,7 +326,7 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
 	}
 
 	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(inode)->runtime_flags);
-	btrfs_drop_extent_cache(BTRFS_I(inode), start, aligned_end - 1, 0);
+	btrfs_drop_extent_cache(BTRFS_I(inode), 0, fs_info->sectorsize - 1, 0);
 out:
 	/*
 	 * Don't forget to free the reserved space, as for inlined extent
@@ -605,13 +595,15 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			/* we didn't compress the entire range, try
 			 * to make an uncompressed inline extent.
 			 */
-			ret = cow_file_range_inline(inode, start, end, 0,
-						    BTRFS_COMPRESS_NONE, NULL);
+			ret = cow_file_range_inline(inode, actual_end, 0,
+						    BTRFS_COMPRESS_NONE, NULL,
+						    false);
 		} else {
 			/* try making a compressed inline extent */
-			ret = cow_file_range_inline(inode, start, end,
+			ret = cow_file_range_inline(inode, actual_end,
 						    total_compressed,
-						    compress_type, pages);
+						    compress_type, pages,
+						    false);
 		}
 		if (ret <= 0) {
 			unsigned long clear_flags = EXTENT_DELALLOC |
@@ -991,9 +983,11 @@ static noinline int cow_file_range(struct inode *inode,
 	inode_should_defrag(BTRFS_I(inode), start, end, num_bytes, SZ_64K);
 
 	if (start == 0) {
+		u64 actual_end = min_t(u64, i_size_read(inode), end + 1);
+
 		/* lets try to make an inline extent */
-		ret = cow_file_range_inline(inode, start, end, 0,
-					    BTRFS_COMPRESS_NONE, NULL);
+		ret = cow_file_range_inline(inode, actual_end, 0,
+					    BTRFS_COMPRESS_NONE, NULL, false);
 		if (ret == 0) {
 			/*
 			 * We use DO_ACCOUNTING here because we need the
-- 
2.24.0


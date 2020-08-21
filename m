Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B4824CF83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgHUHjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgHUHjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:39:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC1C06134E
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:39:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so522111pls.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DEPTebMLFi3phph32zoPPG9Vd9jXS9s6MAMgtz9sb88=;
        b=DOExMHWPnfov9fV0XMlPz7rRFae6wAx0++AUV1jGo2SH7tqij7ZV+6ttZ4DQ0p+pPn
         khQjUrDTUNnDLBB42xAQk3FQMj/sAsMCa/Kx17HUyhY4nyKv4XMilnf62tXrippO0ZTt
         ES9jqR7p6BLeyGYSt1419tD/WKJjiuHutQNWyJP0HPM6QwK04kOCDwvrj4LBkMuMtMsq
         K5gYGUkyDrCYjNoG8ze2i4k+979smeaYDyx4Rqoh4dZOfDRnXEHi2gtCdfIVUhMrZm0M
         wv+hqkOxJSivKiJTNi1rTUcZ2C1m2eC9tsf11tbubeXkYrIxN7i1RODl/sckY8s48YYf
         1qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEPTebMLFi3phph32zoPPG9Vd9jXS9s6MAMgtz9sb88=;
        b=INqtZrGn1B2h+1qJ8pW00594HEpL5bZ8MhprBD8AAt7qFSX+CqYj0P5ets/6FisVNJ
         ZOAcrW6NlagALfhoXwircQoD/YKgPrIm2gmPJCe9vESKkV7bQQjxMyy13kUlFMdUNsdc
         X6QQ1I2BAofOiO15llRMh01qcawYJAugBHpgUeKB1pcMKfQTpoYE4AyrNf+/m6s/JfMJ
         LIdY+baiVW+y52IMBEYoJQ0zF+kKwHfFnXK4i0eVSd4/KnsJ2EklsIDwwhDJaP6BRCLs
         NE2uq7pRfOL4nnkYVuTrLq+3NMd61BCQ9xRc8mMRY+B29OO3S12y5S5giltLcI4+n5+3
         hcAQ==
X-Gm-Message-State: AOAM531QqF8P0JIpJuuLQCAUNT6bpIPUw++IkSO1NeAvS75fyPIjtQvh
        nXPEBaJ7ZsZmK4jqOXX11curM9Rm9KBVZA==
X-Google-Smtp-Source: ABdhPJwR3mDTBV40C/TjTCYGviUnSiOaY3sRIo5xHOfeVERH6SDl+xyuf3jkiqTqW3xvCZbgXauYzA==
X-Received: by 2002:a17:90a:8d0b:: with SMTP id c11mr1453781pjo.196.1597995547364;
        Fri, 21 Aug 2020 00:39:07 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id t10sm1220867pgp.15.2020.08.21.00.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:39:06 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 7/9] btrfs: optionally extend i_size in cow_file_range_inline()
Date:   Fri, 21 Aug 2020 00:38:38 -0700
Message-Id: <602ed7659d19b2693cd1277fcea8dbe21928157f.1597993855.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597993855.git.osandov@osandov.com>
References: <cover.1597993855.git.osandov@osandov.com>
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
 fs/btrfs/inode.c | 100 +++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e607c6a14faf..9b644a641b32 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -167,9 +167,10 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
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
@@ -178,7 +179,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *ei;
 	int ret;
 	size_t cur_size = size;
-	unsigned long offset;
+	u64 i_size;
 
 	ASSERT((compressed_size > 0 && compressed_pages) ||
 	       (compressed_size == 0 && !compressed_pages));
@@ -193,7 +194,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		size_t datasize;
 
 		key.objectid = btrfs_ino(BTRFS_I(inode));
-		key.offset = start;
+		key.offset = 0;
 		key.type = BTRFS_EXTENT_DATA_KEY;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
@@ -232,12 +233,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -248,8 +247,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * We align size to sectorsize for inline extents just for simplicity
 	 * sake.
 	 */
-	size = ALIGN(size, root->fs_info->sectorsize);
-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size);
+	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
+					ALIGN(size, root->fs_info->sectorsize));
 	if (ret)
 		goto fail;
 
@@ -262,7 +261,12 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -275,36 +279,32 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
  * does the checks required to make sure the data is small enough
  * to fit as an inline extent.
  */
-static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
-					  u64 end, size_t compressed_size,
+static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
+					  size_t compressed_size,
 					  int compress_type,
-					  struct page **compressed_pages)
+					  struct page **compressed_pages,
+					  bool update_i_size)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
-	u64 isize = i_size_read(&inode->vfs_inode);
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
+	if (size < i_size_read(&inode->vfs_inode) ||
+	    size > fs_info->sectorsize ||
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
@@ -317,27 +317,19 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 	}
 	trans->block_rsv = &inode->block_rsv;
 
-	if (compressed_size && compressed_pages)
-		extent_item_size = btrfs_file_extent_calc_inline_size(
-		   compressed_size);
-	else
-		extent_item_size = btrfs_file_extent_calc_inline_size(
-		    inline_len);
-
-	ret = __btrfs_drop_extents(trans, root, inode, path, start, aligned_end,
-				   NULL, 1, 1, extent_item_size,
-				   &extent_inserted);
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
-				   root, &inode->vfs_inode, start,
-				   inline_len, compressed_size,
-				   compress_type, compressed_pages);
+	ret = insert_inline_extent(trans, path, extent_inserted, root,
+				   &inode->vfs_inode, size, compressed_size,
+				   compress_type, compressed_pages,
+				   update_i_size);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -347,7 +339,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 	}
 
 	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
-	btrfs_drop_extent_cache(inode, start, aligned_end - 1, 0);
+	btrfs_drop_extent_cache(inode, 0, fs_info->sectorsize - 1, 0);
 out:
 	/*
 	 * Don't forget to free the reserved space, as for inlined extent
@@ -618,14 +610,15 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			/* we didn't compress the entire range, try
 			 * to make an uncompressed inline extent.
 			 */
-			ret = cow_file_range_inline(BTRFS_I(inode), start, end,
+			ret = cow_file_range_inline(BTRFS_I(inode), actual_end,
 						    0, BTRFS_COMPRESS_NONE,
-						    NULL);
+						    NULL, false);
 		} else {
 			/* try making a compressed inline extent */
-			ret = cow_file_range_inline(BTRFS_I(inode), start, end,
+			ret = cow_file_range_inline(BTRFS_I(inode), actual_end,
 						    total_compressed,
-						    compress_type, pages);
+						    compress_type, pages,
+						    false);
 		}
 		if (ret <= 0) {
 			unsigned long clear_flags = EXTENT_DELALLOC |
@@ -1013,9 +1006,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
 
 	if (start == 0) {
+		u64 actual_end = min_t(u64, i_size_read(&inode->vfs_inode),
+				       end + 1);
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
2.28.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4F0383C73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 20:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbhEQShS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbhEQShR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 14:37:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D025EC061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 11:36:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 6so5244303pgk.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PO8XOaX4zXCwvpyXZ0fHL1sw/mqAVbmWN23SOMkLe2Y=;
        b=kI++/2Z3AuDpZHYbhfRzPOMJTicXnsiBFXYnKN52LupSMiVZCxbYsuawNR9aaAcKLB
         oQlxYLwmho73QxvsbUmpVrJ0mrG1agS3Ujzct1c2DfuesYac2HwIbJLz5WUvCvvQ98Ry
         D0djHzHuqljF07FTjDcxbZZT2btMnY/hw/0fSo/SxPyts6j/jAIu9YOPmgo1co7q3MCk
         vfY3tkZPz1YxHbRTmTHoUZ2Lxdhejp3rNAt2ALaHMPN6wYAwji/fAjhYYbI3yv65yo1l
         9Q2aUbUJLp803xLiaQQBvAyTGCaKp2FZcleyHr2KwtT2ijzKl5GpMitv2bN0y1RyzkA9
         9m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PO8XOaX4zXCwvpyXZ0fHL1sw/mqAVbmWN23SOMkLe2Y=;
        b=gXW5tKc0td7ebBucoEt4Arnw8d4i5vSuczlYYNTCxqLD9Husp7orv6MDFjaAwC2MIq
         BNFFznW7XnyYivW4XG3JZWjhZn1qOJapBl200+6yJuCXM/GnvdGApMAH3YB2l5CSKnz1
         Tqtux4O29uqTLgiE+3mBmL6FUPQcfY2XmopMD+3m1hE7NYrXEfnor5uMeU7NXwNyVKIN
         cbSj2uZsKECx5+hqX9OkmPppnhuFpMHBR7+EfLKQpnhWNetpBnjvieiXlGnxKBwt9zho
         0N+yzmS76bDvWM30jWTPwjkcK4D7s8hJz/EGHfjY7dQAkzCErYAoTjfPrj+AIh98NIMu
         ul/w==
X-Gm-Message-State: AOAM532vkXTVTVEFcPeFVSFG9YJFTAL6qStQq5GjsteLY3ck4zh6J6yP
        /b+DGjkEcGvu1qMzFVT6GiSbrxsA899nOw==
X-Google-Smtp-Source: ABdhPJwT0bCe8hO9VAEpPHdtOZh3JeYcfulD4CNYBM1kee7u3zq0FMM4wKll/hFI9cqE/pQT6gFTYQ==
X-Received: by 2002:a63:58f:: with SMTP id 137mr859057pgf.241.1621276559658;
        Mon, 17 May 2021 11:35:59 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:19a9])
        by smtp.gmail.com with ESMTPSA id v15sm5498763pfm.187.2021.05.17.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:35:58 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RERESEND v9 7/9] btrfs: optionally extend i_size in cow_file_range_inline()
Date:   Mon, 17 May 2021 11:35:25 -0700
Message-Id: <c90c239802f021374bc4da638a0a68ef45212eea.1621276134.git.osandov@fb.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621276134.git.osandov@fb.com>
References: <cover.1621276134.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 100 +++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d7bdbdc13826..40fe9602f622 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -209,9 +209,10 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
 static int insert_inline_extent(struct btrfs_trans_handle *trans,
 				struct btrfs_path *path, bool extent_inserted,
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
@@ -220,7 +221,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *ei;
 	int ret;
 	size_t cur_size = size;
-	unsigned long offset;
+	u64 i_size;
 
 	ASSERT((compressed_size > 0 && compressed_pages) ||
 	       (compressed_size == 0 && !compressed_pages));
@@ -233,7 +234,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		size_t datasize;
 
 		key.objectid = btrfs_ino(BTRFS_I(inode));
-		key.offset = start;
+		key.offset = 0;
 		key.type = BTRFS_EXTENT_DATA_KEY;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
@@ -271,12 +272,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -287,8 +286,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * We align size to sectorsize for inline extents just for simplicity
 	 * sake.
 	 */
-	size = ALIGN(size, root->fs_info->sectorsize);
-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size);
+	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
+					ALIGN(size, root->fs_info->sectorsize));
 	if (ret)
 		goto fail;
 
@@ -301,7 +300,13 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
+
 fail:
 	return ret;
 }
@@ -312,35 +317,31 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
 	struct btrfs_drop_extents_args drop_args = { 0 };
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
@@ -354,30 +355,21 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 	trans->block_rsv = &inode->block_rsv;
 
 	drop_args.path = path;
-	drop_args.start = start;
-	drop_args.end = aligned_end;
+	drop_args.start = 0;
+	drop_args.end = fs_info->sectorsize;
 	drop_args.drop_cache = true;
 	drop_args.replace_extent = true;
-
-	if (compressed_size && compressed_pages)
-		drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(
-		   compressed_size);
-	else
-		drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(
-		    inline_len);
-
+	drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(data_len);
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
-	if (isize > actual_end)
-		inline_len = min_t(u64, isize, actual_end);
-	ret = insert_inline_extent(trans, path, drop_args.extent_inserted,
-				   root, &inode->vfs_inode, start,
-				   inline_len, compressed_size,
-				   compress_type, compressed_pages);
+	ret = insert_inline_extent(trans, path, drop_args.extent_inserted, root,
+				   &inode->vfs_inode, size, compressed_size,
+				   compress_type, compressed_pages,
+				   update_i_size);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -386,7 +378,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 		goto out;
 	}
 
-	btrfs_update_inode_bytes(inode, inline_len, drop_args.bytes_found);
+	btrfs_update_inode_bytes(inode, size, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
@@ -662,14 +654,15 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
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
@@ -1054,9 +1047,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
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
2.31.1


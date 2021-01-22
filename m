Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A516300E30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 21:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbhAVUwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbhAVUvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:51:23 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC405C0611BD
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:39 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 15so4605327pgx.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKZzF4yC72/mGdDfVW+0y5Y0vRVlRm12hctIRk+n9zk=;
        b=CnlU8cDk7vOZvo3jtxN1dw2hD8lI7Ua6iLh6t0aSwS43O3v7C/Y/j2boamRNwsC8az
         wQ0INuOVo666YQ6MuTsOb3wP/KWe4GQT0CAt++l7kQar/lQpw2STvIV/zVvQOJE/+1nB
         506mpMpRLcfieZQ5tKj9Lyk591+bRnaKSccUzwnw7AWbALUlnkBe5BB5MGNjBG8tn6O2
         1n9SCUtYpbwIF2DK5SOS4TcmEbTi6BXK8wrXwBz8OUAqx6m2nvIXB3eTWcNtJYxk1iO6
         XYouyPozrQgy3eEJD7iP7pIIRNPo6IUYM31TC6L/BcEtwkVgdemjVWj5N+pYItuu4+o7
         GCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKZzF4yC72/mGdDfVW+0y5Y0vRVlRm12hctIRk+n9zk=;
        b=oGwu3pNc9PLm84xE5KuZAjlOSPAZYuIcq50OJgzksAuh5mfIF0ESafQAfKZ3TugdRt
         aUW2nNcQky4JLYD8ZXtv0RMQT24ZZHbp+5BHMXZsQDjqtTXygACMdCBUU6C+0/Yt4Gho
         +ctrdJNpJhZdu4s5kPVdhbELvidUvcyJsPPGJKWBpPetfMuFPTPE+h/rzlsc+S469Ph3
         AR5iSPBfgyaWkt2f0ei/P6vk+JxisuY3S/k9G2z73lm/WVl5jnTfnqG7adZMajXUi5F8
         gUOUfKOtBC3ytVnDR9YcIO5u/iGERWEBuyn5AoR48h9tvscnjL6iENjID+NXf0arUM9a
         4xDA==
X-Gm-Message-State: AOAM533rdg1Wf2Ak7f/wyF9zKNnPpRtuUxv9AnoTtQVUE+fLj6Szebfr
        TA9MyzysCGUgU8rzZ82zX2ApDxiG3PR9/Q==
X-Google-Smtp-Source: ABdhPJxMUyhebHxm+DW5OavGApjzSj618wIFbO3LWFjQBbFUHW1AgYfEZe5aZ/7W4bmcf7UMFqj3XQ==
X-Received: by 2002:a62:5547:0:b029:1a4:cb2a:2833 with SMTP id j68-20020a6255470000b02901a4cb2a2833mr6536895pfb.35.1611348458605;
        Fri, 22 Jan 2021 12:47:38 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id j18sm4092900pfc.99.2021.01.22.12.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:47:37 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 08/10] btrfs: optionally extend i_size in cow_file_range_inline()
Date:   Fri, 22 Jan 2021 12:46:55 -0800
Message-Id: <99661081363ab004c73361aaca4a418a11fc10fc.1611346706.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611346706.git.osandov@fb.com>
References: <cover.1611346706.git.osandov@fb.com>
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
index 3c1f1297c9d9..b362e73af840 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -203,9 +203,10 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
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
@@ -214,7 +215,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *ei;
 	int ret;
 	size_t cur_size = size;
-	unsigned long offset;
+	u64 i_size;
 
 	ASSERT((compressed_size > 0 && compressed_pages) ||
 	       (compressed_size == 0 && !compressed_pages));
@@ -227,7 +228,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		size_t datasize;
 
 		key.objectid = btrfs_ino(BTRFS_I(inode));
-		key.offset = start;
+		key.offset = 0;
 		key.type = BTRFS_EXTENT_DATA_KEY;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
@@ -265,12 +266,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -281,8 +280,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * We align size to sectorsize for inline extents just for simplicity
 	 * sake.
 	 */
-	size = ALIGN(size, root->fs_info->sectorsize);
-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size);
+	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
+					ALIGN(size, root->fs_info->sectorsize));
 	if (ret)
 		goto fail;
 
@@ -295,7 +294,13 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -306,35 +311,31 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -348,30 +349,21 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
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
@@ -380,7 +372,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 		goto out;
 	}
 
-	btrfs_update_inode_bytes(inode, inline_len, drop_args.bytes_found);
+	btrfs_update_inode_bytes(inode, size, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
@@ -661,14 +653,15 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
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
@@ -1056,9 +1049,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
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
2.30.0


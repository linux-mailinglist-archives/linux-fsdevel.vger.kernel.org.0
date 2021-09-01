Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDBE3FE0A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345576AbhIARCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345558AbhIARCd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:33 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4F9C0617AD
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:01:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u6so351901pfi.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dvAtTZaVe5JzFuKGRePEmkQonW9iDa3fPMODWTnFSQs=;
        b=XtncSU+673+euGzuhnIp+IzYyM9YEp8R5qgQydyUtWi14FgZNcZet0lY4XPKVpLE/L
         k/MDOMMVohp/wMt8J8tPgem8N8vrYyiodU5641bGZ7k6L7TvmyKxdMpWLbjy10VOVblp
         tlKIiKP6o2+7FayNuGByhRNARRxFat+5q81R7nZrdoareu1zZdY+qqf40MPVRpvH5+0Y
         GsEYl/QbVhEAkCrIQtVEW6crKRQIFgV0YVefQZ9W/raa3WF2CJxWoFDMtj9HyPyE0Rdy
         ofJHBuZO8LPB4ojDwurU9Xpe0OMCW7fqwkb+4VgDGgZHl9pDlJbdUnZaJZNC4sEV93/f
         xXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvAtTZaVe5JzFuKGRePEmkQonW9iDa3fPMODWTnFSQs=;
        b=i1IW+rUrwS5P25QHN0XpsScmM3Kq79r4he+8+jM9ZLohusVf3JSx1EZ/RzrDpa62u2
         KhrEgqKzw6V5AekOOEZaEuMLYMp22iXvrM940Ae3PjAHaHcq/hubrrw1j1/oH7QQjNOY
         1gk9WW9ixeMksyI+stKrP9v4dz/Dv4WrTf8L66wyUnWR6MXY0PSrbBRfXHAsehlU9NDr
         h9RKufkM3AB5mMi5w1IuiNXFwzKKVTFoz5vh1hfuv+ZTgeeVmzD8a5uaG5JI045NhpI6
         RBbAYMSUSk/vzi/M4B8lIherW9oDQGljo9gva5BDyZjlDVkWXoLiocCw6HvuTFXj/Ul1
         Om0Q==
X-Gm-Message-State: AOAM530SEs88bAM7ymZiiT8r51JB92ijoftGiRuIsxMa4kKr69R1gBf5
        vYzJUC1V8eA7/NJX5CpDIjT0bQ==
X-Google-Smtp-Source: ABdhPJw8a+6vuLcYkv3YLIY6wtdKcpHj40sSYAuhQM/tdjGvwWx1ZD2ySnGV5/SjM8THiVEo24lULg==
X-Received: by 2002:a63:5c51:: with SMTP id n17mr89588pgm.376.1630515695346;
        Wed, 01 Sep 2021 10:01:35 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:34 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 06/14] btrfs: optionally extend i_size in cow_file_range_inline()
Date:   Wed,  1 Sep 2021 10:01:01 -0700
Message-Id: <54ad4e1fe7d6c4dce4a87fd4f22de3a7b197d13b.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
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
index 6aad4b641d5c..a87a34f56234 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -236,9 +236,10 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
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
@@ -247,7 +248,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *ei;
 	int ret;
 	size_t cur_size = size;
-	unsigned long offset;
+	u64 i_size;
 
 	ASSERT((compressed_size > 0 && compressed_pages) ||
 	       (compressed_size == 0 && !compressed_pages));
@@ -260,7 +261,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		size_t datasize;
 
 		key.objectid = btrfs_ino(BTRFS_I(inode));
-		key.offset = start;
+		key.offset = 0;
 		key.type = BTRFS_EXTENT_DATA_KEY;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
@@ -297,12 +298,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -313,8 +312,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * We align size to sectorsize for inline extents just for simplicity
 	 * sake.
 	 */
-	size = ALIGN(size, root->fs_info->sectorsize);
-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size);
+	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
+					ALIGN(size, root->fs_info->sectorsize));
 	if (ret)
 		goto fail;
 
@@ -327,7 +326,13 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -338,35 +343,31 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -380,30 +381,21 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
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
@@ -412,7 +404,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 		goto out;
 	}
 
-	btrfs_update_inode_bytes(inode, inline_len, drop_args.bytes_found);
+	btrfs_update_inode_bytes(inode, size, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
@@ -695,14 +687,15 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
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
@@ -1098,9 +1091,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * So here we skip inline extent creation completely.
 	 */
 	if (start == 0 && fs_info->sectorsize == PAGE_SIZE) {
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
2.33.0


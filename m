Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0781742CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 00:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgB1XOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 18:14:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43786 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgB1XOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:14:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so1802407plq.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 15:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Pkz/Lyte3lGarOljqv6FqlaYYvBaLnzUkjMhl0TuL8=;
        b=SS4jlNsFHiWWeyD4bGqXzulo8u8Y9LJQhnnqk0Ro8rBZRGA7ONSN4F5Zhiws/pEBp1
         RXjzc7DlZN1LhYqA6EolmKmx0sPnErIG02JGekuNOReW1pDc8yFLaGzSDMzve/khJfRi
         3HzMC2TVyeQTcMqoOOTY+buNhn3urtTyWjlwO4RWa4tv5EOGtkcaeMiN5Fd/Up6FoI1u
         uRz8kcl74xCrZELgSoGHBnxITm0hpdMQYCM0tR9lWPOXnhOvF3TRI+HhqzIzWB4tZzEP
         LqzhLpNVttU3iJlxkrZDxdezO68P45V/5KzjBiYeSvjAWRWymugg3tE5iPTXHNyR61sS
         23Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Pkz/Lyte3lGarOljqv6FqlaYYvBaLnzUkjMhl0TuL8=;
        b=otR0ZZYJ6CS5Fyo1wa0JZNdTqPMEELUDwFw7eF21yS7O9gLEHEj/ekA6l9gRr+pIj5
         EgnXWUhWX5qRjW6CMoBXs0bfsOKOK9LhBULed/kByIpKGtcX/aqx+K1FCRtD9Y9lmNf4
         o2EHN6Kiez33e7yAFUYofbopO2hmIg1admTNuH3fNBPfBxk8xXgDK1NSYDhR76fRVyi+
         dDtux2mXGuLJn/zYFuBpC+Dvt1vEeV2cYPI6eGbu4D10YD1cQ4JuSnc+J/esbiRMeRZ1
         hwFsCQccasbRkOiHQb1phpTu1omk510HMqWUq0+3OVSatbBMLpvx2eWpvqZh7aOmo5O7
         dIgw==
X-Gm-Message-State: APjAAAXoozurSv3jPsk1w0T0x7kOi8eGBD76GnIDqihWIpQ/vbmRxgwz
        ++wo6uALhB5ZMWsjF91sY4zDczEQvj0=
X-Google-Smtp-Source: APXvYqziekPId8+dYEXDFYBgLmum8qflIhPDavjy6kuUw6H2tS7+44HYifiFG3VPFJu1LriBGzKXiQ==
X-Received: by 2002:a17:902:7797:: with SMTP id o23mr5845159pll.298.1582931662735;
        Fri, 28 Feb 2020 15:14:22 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:500::6:1714])
        by smtp.gmail.com with ESMTPSA id q7sm11421878pgk.62.2020.02.28.15.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:14:22 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 7/9] btrfs: optionally extend i_size in cow_file_range_inline()
Date:   Fri, 28 Feb 2020 15:13:59 -0800
Message-Id: <9378cbf7853936e4b5939722785cfa5a2ddf79f6.1582930832.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1582930832.git.osandov@fb.com>
References: <cover.1582930832.git.osandov@fb.com>
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
index bcde9903d13b..a45336214fbb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -164,9 +164,10 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
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
@@ -175,7 +176,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *ei;
 	int ret;
 	size_t cur_size = size;
-	unsigned long offset;
+	u64 i_size;
 
 	ASSERT((compressed_size > 0 && compressed_pages) ||
 	       (compressed_size == 0 && !compressed_pages));
@@ -190,7 +191,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		size_t datasize;
 
 		key.objectid = btrfs_ino(BTRFS_I(inode));
-		key.offset = start;
+		key.offset = 0;
 		key.type = BTRFS_EXTENT_DATA_KEY;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
@@ -229,12 +230,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -250,7 +249,12 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -263,36 +267,31 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -305,27 +304,18 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
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
@@ -335,7 +325,7 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
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
@@ -994,9 +986,11 @@ static noinline int cow_file_range(struct inode *inode,
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
2.25.1


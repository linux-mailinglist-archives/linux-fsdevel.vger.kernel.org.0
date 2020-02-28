Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F471742D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 00:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgB1XOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 18:14:35 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38120 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgB1XOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:14:22 -0500
Received: by mail-pj1-f67.google.com with SMTP id a16so1560503pju.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 15:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yP/TUH9sl08DBpmzinD/KIXr4o/TtnN9Wu54bDiA4zs=;
        b=EBOX8oG8lIhE4E9CmthICXo3TWePP9ppeIvDwQOmOVR/ryqxOwXOxTcxpeCNJHGe+3
         aJnrd5ErVYdgg+JJdTr3ZkhaJQ2nPYvihC2sGNKqGTUAbgaju792SKsXJnZM6FEPlEdi
         SnE+QUSxFaWE0J6st3WtsB+BcONiTbf2YLqTSqZYy9915OxS8cBOXPNVLFcL9YXIUB5c
         zc3NU5y/EfkuMo2H8eLQPBN4FkAAbLa8B6XL3i0y+twgCnspDYQaq+hwjBf/S5KQNEDa
         xb7O7jTq1z41VD0j9woTHxgOLdO+wEH9U0zJ2e0EQssB5QIgXVrYiBfYam2rjMkGLsTW
         gQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yP/TUH9sl08DBpmzinD/KIXr4o/TtnN9Wu54bDiA4zs=;
        b=DLmPuwLF9lvOrLj3x586CvKh2zx0nbkICz9l0dxbm1mHFC1rdKib3nU94MHZGJsOX6
         Wv/srHteo+rS0jddfOwoGgcsYlxGS2l+0YI7GwI+rqPyVI/AYO5yX2jQuNNQWfHjUUmi
         58CWOLcIt50p2cGXLQQ7u95Ttku9Pw8KjZ/B4INU1gqfFFB743Wo0zPugKYcTJZ+jXqg
         8bN0pC3DwwdAKUNmWs/AT4RVVU9N/RZ/6SK9gW2DVw5FeDlDHDdOjoe8vKrTgA31ioNm
         h8Nfjw2BxD6nKhxF9x3K4FHxc7mHS8BpkBDJa14RcfdI+Css8alhyThEZftqA7zIq3Ih
         Qm2Q==
X-Gm-Message-State: APjAAAVSTwGuWY107PtP4kYMb3+9ceUe0kvXvtohozT0FRbcZz+Lw/cQ
        RYM/QKDJVVz/w2Sl6+RE9FgtH8tLBU0=
X-Google-Smtp-Source: APXvYqwF7VG87REgYT9abvm9YI6vwK0lWVSu8tU8sVJKZ/5OfV2R+B+NVgonQN6Am5u696+WeVCsYA==
X-Received: by 2002:a17:902:401:: with SMTP id 1mr6093109ple.177.1582931659700;
        Fri, 28 Feb 2020 15:14:19 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:500::6:1714])
        by smtp.gmail.com with ESMTPSA id q7sm11421878pgk.62.2020.02.28.15.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:14:19 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 5/9] btrfs: add ram_bytes and offset to btrfs_ordered_extent
Date:   Fri, 28 Feb 2020 15:13:57 -0800
Message-Id: <33fc0a7557be97ff43285f93078653a95e4e0531.1582930832.git.osandov@fb.com>
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

Currently, we only create ordered extents when ram_bytes == num_bytes
and offset == 0. However, RWF_ENCODED writes may create extents which
only refer to a subset of the full unencoded extent, so we need to plumb
these fields through the ordered extent infrastructure and pass them
down to insert_reserved_file_extent().

Since we're changing the btrfs_add_ordered_extent* signature, let's get
rid of the trivial wrappers and add a kernel-doc.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c        | 65 +++++++++++++++++++++++------------------
 fs/btrfs/ordered-data.c | 65 +++++++++++++++--------------------------
 fs/btrfs/ordered-data.h | 16 ++++------
 3 files changed, 67 insertions(+), 79 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 303613e6ec38..0d5b4e14f815 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -848,13 +848,12 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			goto out_free_reserve;
 		free_extent_map(em);
 
-		ret = btrfs_add_ordered_extent_compress(inode,
-						async_extent->start,
-						ins.objectid,
-						async_extent->ram_size,
-						ins.offset,
-						BTRFS_ORDERED_COMPRESSED,
-						async_extent->compress_type);
+		ret = btrfs_add_ordered_extent(inode, async_extent->start,
+					       async_extent->ram_size,
+					       async_extent->ram_size,
+					       ins.objectid, ins.offset, 0,
+					       1 << BTRFS_ORDERED_COMPRESSED,
+					       async_extent->compress_type);
 		if (ret) {
 			btrfs_drop_extent_cache(BTRFS_I(inode),
 						async_extent->start,
@@ -1049,8 +1048,9 @@ static noinline int cow_file_range(struct inode *inode,
 		}
 		free_extent_map(em);
 
-		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
-					       ram_size, cur_alloc_size, 0);
+		ret = btrfs_add_ordered_extent(inode, start, ram_size, ram_size,
+					       ins.objectid, cur_alloc_size, 0,
+					       0, BTRFS_COMPRESS_NONE);
 		if (ret)
 			goto out_drop_extent_cache;
 
@@ -1623,10 +1623,11 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 				goto error;
 			}
 			free_extent_map(em);
-			ret = btrfs_add_ordered_extent(inode, cur_offset,
-						       disk_bytenr, num_bytes,
-						       num_bytes,
-						       BTRFS_ORDERED_PREALLOC);
+			ret = btrfs_add_ordered_extent(inode,
+					cur_offset, num_bytes, num_bytes,
+					disk_bytenr, num_bytes, 0,
+					1 << BTRFS_ORDERED_PREALLOC,
+					BTRFS_COMPRESS_NONE);
 			if (ret) {
 				btrfs_drop_extent_cache(BTRFS_I(inode),
 							cur_offset,
@@ -1636,9 +1637,11 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			}
 		} else {
 			ret = btrfs_add_ordered_extent(inode, cur_offset,
+						       num_bytes, num_bytes,
 						       disk_bytenr, num_bytes,
-						       num_bytes,
-						       BTRFS_ORDERED_NOCOW);
+						       0,
+						       1 << BTRFS_ORDERED_NOCOW,
+						       BTRFS_COMPRESS_NONE);
 			if (ret)
 				goto error;
 		}
@@ -2380,7 +2383,7 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 				       struct inode *inode, u64 file_pos,
 				       u64 disk_bytenr, u64 disk_num_bytes,
-				       u64 num_bytes, u64 ram_bytes,
+				       u64 offset, u64 num_bytes, u64 ram_bytes,
 				       u8 compression, u8 encryption,
 				       u16 other_encoding, int extent_type)
 {
@@ -2430,7 +2433,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_file_extent_type(leaf, fi, extent_type);
 	btrfs_set_file_extent_disk_bytenr(leaf, fi, disk_bytenr);
 	btrfs_set_file_extent_disk_num_bytes(leaf, fi, disk_num_bytes);
-	btrfs_set_file_extent_offset(leaf, fi, 0);
+	btrfs_set_file_extent_offset(leaf, fi, offset);
 	btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
 	btrfs_set_file_extent_ram_bytes(leaf, fi, ram_bytes);
 	btrfs_set_file_extent_compression(leaf, fi, compression);
@@ -2456,7 +2459,8 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	qg_released = ret;
 	ret = btrfs_alloc_reserved_file_extent(trans, root,
 					       btrfs_ino(BTRFS_I(inode)),
-					       file_pos, qg_released, &ins);
+					       file_pos - offset, qg_released,
+					       &ins);
 out:
 	btrfs_free_path(path);
 
@@ -2493,7 +2497,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	u64 start, end;
 	int compress_type = 0;
 	int ret = 0;
-	u64 logical_len = ordered_extent->num_bytes;
+	u64 num_bytes = ordered_extent->num_bytes;
+	u64 ram_bytes = ordered_extent->ram_bytes;
 	bool freespace_inode;
 	bool truncated = false;
 	bool range_locked = false;
@@ -2520,9 +2525,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
-		logical_len = ordered_extent->truncated_len;
+		num_bytes = ram_bytes = ordered_extent->truncated_len;
 		/* Truncated the entire extent, don't bother adding */
-		if (!logical_len)
+		if (!num_bytes)
 			goto out;
 	}
 
@@ -2577,13 +2582,14 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		ret = btrfs_mark_extent_written(trans, BTRFS_I(inode),
 						ordered_extent->file_offset,
 						ordered_extent->file_offset +
-						logical_len);
+						num_bytes);
 	} else {
 		BUG_ON(root == fs_info->tree_root);
 		ret = insert_reserved_file_extent(trans, inode, start,
 						ordered_extent->disk_bytenr,
 						ordered_extent->disk_num_bytes,
-						logical_len, logical_len,
+						ordered_extent->offset,
+						num_bytes, ram_bytes,
 						compress_type, 0, 0,
 						BTRFS_FILE_EXTENT_REG);
 		if (!ret) {
@@ -2631,7 +2637,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		u64 unwritten_start = start;
 
 		if (truncated)
-			unwritten_start += logical_len;
+			unwritten_start += num_bytes;
 		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
 
 		/* Drop the cache for the part of the extent we didn't write. */
@@ -2647,7 +2653,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		 * errored out then we don't need to do this as the accounting
 		 * has already been done.
 		 */
-		if ((ret || !logical_len) &&
+		if ((ret || !num_bytes) &&
 		    clear_reserved_extent &&
 		    !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 		    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
@@ -6752,8 +6758,11 @@ static struct extent_map *btrfs_create_dio_extent(struct inode *inode,
 		if (IS_ERR(em))
 			goto out;
 	}
-	ret = btrfs_add_ordered_extent_dio(inode, start, block_start,
-					   len, block_len, type);
+	ret = btrfs_add_ordered_extent(inode, start, len, len, block_start,
+				       block_len, 0,
+				       (1 << type) |
+				       (1 << BTRFS_ORDERED_DIRECT),
+				       BTRFS_COMPRESS_NONE);
 	if (ret) {
 		if (em) {
 			free_extent_map(em);
@@ -9873,7 +9882,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		last_alloc = ins.offset;
 		ret = insert_reserved_file_extent(trans, inode,
 						  cur_offset, ins.objectid,
-						  ins.offset, ins.offset,
+						  ins.offset, 0, ins.offset,
 						  ins.offset, 0, 0, 0,
 						  BTRFS_FILE_EXTENT_PREALLOC);
 		if (ret) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a65f189a5b94..9a5f35d35fa9 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -152,15 +152,27 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
 	return ret;
 }
 
-/* allocate and add a new ordered_extent into the per-inode tree.
+/**
+ * btrfs_add_ordered_extent - Add an ordered extent to the per-inode tree.
+ * @inode: inode that this extent is for.
+ * @file_offset: Logical offset in file where the extent starts.
+ * @num_bytes: Logical length of extent in file.
+ * @ram_bytes: Full length of unencoded data.
+ * @disk_bytenr: Offset of extent on disk.
+ * @disk_num_bytes: Size of extent on disk.
+ * @offset: Offset into unencoded data where file data starts.
+ * @flags: Flags specifying type of extent (1 << BTRFS_ORDERED_*).
+ * @compress_type: Compression algorithm used for data.
  *
- * The tree is given a single reference on the ordered extent that was
- * inserted.
+ * Most of these parameters correspond to &struct btrfs_file_extent_item. The
+ * tree is given a single reference on the ordered extent that was inserted.
+ *
+ * Return: 0 or -ENOMEM.
  */
-static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
-				      u64 disk_bytenr, u64 num_bytes,
-				      u64 disk_num_bytes, int type, int dio,
-				      int compress_type)
+int btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
+			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			     u64 disk_num_bytes, u64 offset, int flags,
+			     int compress_type)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -174,20 +186,19 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 		return -ENOMEM;
 
 	entry->file_offset = file_offset;
-	entry->disk_bytenr = disk_bytenr;
 	entry->num_bytes = num_bytes;
+	entry->ram_bytes = ram_bytes;
+	entry->disk_bytenr = disk_bytenr;
 	entry->disk_num_bytes = disk_num_bytes;
+	entry->offset = offset;
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(inode);
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
-	if (type != BTRFS_ORDERED_IO_DONE && type != BTRFS_ORDERED_COMPLETE)
-		set_bit(type, &entry->flags);
-
-	if (dio) {
+	entry->flags = flags;
+	if (flags & (1 << BTRFS_ORDERED_DIRECT)) {
 		percpu_counter_add_batch(&fs_info->dio_bytes, num_bytes,
 					 fs_info->delalloc_batch);
-		set_bit(BTRFS_ORDERED_DIRECT, &entry->flags);
 	}
 
 	/* one ref for the tree */
@@ -235,34 +246,6 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 	return 0;
 }
 
-int btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
-			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
-			     int type)
-{
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
-					  num_bytes, disk_num_bytes, type, 0,
-					  BTRFS_COMPRESS_NONE);
-}
-
-int btrfs_add_ordered_extent_dio(struct inode *inode, u64 file_offset,
-				 u64 disk_bytenr, u64 num_bytes,
-				 u64 disk_num_bytes, int type)
-{
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
-					  num_bytes, disk_num_bytes, type, 1,
-					  BTRFS_COMPRESS_NONE);
-}
-
-int btrfs_add_ordered_extent_compress(struct inode *inode, u64 file_offset,
-				      u64 disk_bytenr, u64 num_bytes,
-				      u64 disk_num_bytes, int type,
-				      int compress_type)
-{
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
-					  num_bytes, disk_num_bytes, type, 0,
-					  compress_type);
-}
-
 /*
  * Add a struct btrfs_ordered_sum into the list of checksums to be inserted
  * when an ordered extent is finished.  If the list covers more than one
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 3beb4da4ab41..ef528fef5841 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -71,9 +71,11 @@ struct btrfs_ordered_extent {
 	 * These fields directly correspond to the same fields in
 	 * btrfs_file_extent_item.
 	 */
-	u64 disk_bytenr;
 	u64 num_bytes;
+	u64 ram_bytes;
+	u64 disk_bytenr;
 	u64 disk_num_bytes;
+	u64 offset;
 
 	/* number of bytes that still need writing */
 	u64 bytes_left;
@@ -160,15 +162,9 @@ int btrfs_dec_test_first_ordered_pending(struct inode *inode,
 				   u64 *file_offset, u64 io_size,
 				   int uptodate);
 int btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
-			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
-			     int type);
-int btrfs_add_ordered_extent_dio(struct inode *inode, u64 file_offset,
-				 u64 disk_bytenr, u64 num_bytes,
-				 u64 disk_num_bytes, int type);
-int btrfs_add_ordered_extent_compress(struct inode *inode, u64 file_offset,
-				      u64 disk_bytenr, u64 num_bytes,
-				      u64 disk_num_bytes, int type,
-				      int compress_type);
+			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			     u64 disk_num_bytes, u64 offset, int flags,
+			     int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct inode *inode,
-- 
2.25.1


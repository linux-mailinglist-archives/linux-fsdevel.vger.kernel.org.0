Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F95104369
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfKTSZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 13:25:14 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:46255 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfKTSZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:25:04 -0500
Received: by mail-pj1-f66.google.com with SMTP id a16so177071pjs.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 10:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8x/o2LWQt4iJLuED+x+O4dWDi2aR7BaTDIRFGy3mvM=;
        b=oB+yGGy2zS8ViWxIY9kpkDVYR1BTlOqop40AV24/aGvmNCZvx5OPriTpffRnEdI9GA
         TuStgpqIZJz8x3Ir97Ed7S9YUiksCa9sxLauRaqUOChY5krVHuL4tGYKHxz8KMx8KPsp
         MAsXUu0Lzacz0rV8cxn5jcsWGlRp3n0sR8jbi9n9oczbN6wbZGtSoxwr7SiBoXRJqZKo
         uNbTD8jAsZ99HKqp9d6FbM7hZ2MOFHwAMYXMa/cgMTzWtFAleDeQqG82ntOt38YQ6Yw+
         sUcF5s+1w3tpx1puEY5ZN5dr9dTVNwr6Z/XHbtkMCFhJzVDyWvqhiUnGG/fh+QhHAN23
         ILqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8x/o2LWQt4iJLuED+x+O4dWDi2aR7BaTDIRFGy3mvM=;
        b=MdIABkrpbonUTlHZHZs85nEOOLSN2gJe1e2Ycl2Sy50qHMansLnwIvJ3EPLuwPREq3
         1td0act1vhVVtqBT4+1D8B0PiILgjIiXl0Tb+OiLOVL1sSTxC0/fAHBr2/w2K0XQVNyb
         7vPSebK1alvJ7EPWRIxS0ktKpar+hOcAXM6hh7zUYHpvdNJAWV/Pn43UTGBS5xxUufE/
         gYALCDklEK2YEC2QQPX9OD+P1bePnBWMeMnts4BT+ZBrtsJBc5t5DvD1VLzHv8e0sfEU
         eowxNuYU1JOz44bupJMxZIfi1J1ZY6xY4Wq8vQWgeW5t6Sx5HJIYv7K1e7DNRPGZOPhU
         xDEw==
X-Gm-Message-State: APjAAAWZB7iMhtwI87xUGLuAx0qiw8tiqob84V5Y4qcoRmTr0RtRETl/
        jJLEiMK18/vD65zA+3ARtiyvC5xgsSA=
X-Google-Smtp-Source: APXvYqzWFwY+eb+z+hdL/dI2K+EGKA2r57grmCm/iS7yMbmUklvBD77mgchggB2vWiEqx8zvIMYykg==
X-Received: by 2002:a17:902:7402:: with SMTP id g2mr4401755pll.6.1574274301549;
        Wed, 20 Nov 2019 10:25:01 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:25:00 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 08/12] btrfs: add ram_bytes and offset to btrfs_ordered_extent
Date:   Wed, 20 Nov 2019 10:24:28 -0800
Message-Id: <acc02c48287b503195a513e4210d6ddd9e89418a.1574273658.git.osandov@fb.com>
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

Currently, we only create ordered extents when ram_bytes == num_bytes
and offset == 0. However, RWF_ENCODED writes may create extents which
only refer to a subset of the full unencoded extent, so we need to plumb
these fields through the ordered extent infrastructure and pass them
down to insert_reserved_file_extent().

Since we're changing the btrfs_add_ordered_extent* signature, let's get
rid of the trivial wrappers and add a kernel-doc.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c        | 65 +++++++++++++++++++++++------------------
 fs/btrfs/ordered-data.c | 65 +++++++++++++++--------------------------
 fs/btrfs/ordered-data.h | 16 ++++------
 3 files changed, 67 insertions(+), 79 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 62d6aaccc202..d53580ad2c46 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -846,13 +846,12 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
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
@@ -1046,8 +1045,9 @@ static noinline int cow_file_range(struct inode *inode,
 		}
 		free_extent_map(em);
 
-		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
-					       ram_size, cur_alloc_size, 0);
+		ret = btrfs_add_ordered_extent(inode, start, ram_size, ram_size,
+					       ins.objectid, cur_alloc_size, 0,
+					       0, BTRFS_COMPRESS_NONE);
 		if (ret)
 			goto out_drop_extent_cache;
 
@@ -1584,10 +1584,11 @@ static noinline int run_delalloc_nocow(struct inode *inode,
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
@@ -1597,9 +1598,11 @@ static noinline int run_delalloc_nocow(struct inode *inode,
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
@@ -2269,7 +2272,7 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 				       struct inode *inode, u64 file_pos,
 				       u64 disk_bytenr, u64 disk_num_bytes,
-				       u64 num_bytes, u64 ram_bytes,
+				       u64 offset, u64 num_bytes, u64 ram_bytes,
 				       u8 compression, u8 encryption,
 				       u16 other_encoding, int extent_type)
 {
@@ -2319,7 +2322,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_file_extent_type(leaf, fi, extent_type);
 	btrfs_set_file_extent_disk_bytenr(leaf, fi, disk_bytenr);
 	btrfs_set_file_extent_disk_num_bytes(leaf, fi, disk_num_bytes);
-	btrfs_set_file_extent_offset(leaf, fi, 0);
+	btrfs_set_file_extent_offset(leaf, fi, offset);
 	btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
 	btrfs_set_file_extent_ram_bytes(leaf, fi, ram_bytes);
 	btrfs_set_file_extent_compression(leaf, fi, compression);
@@ -2345,7 +2348,8 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	qg_released = ret;
 	ret = btrfs_alloc_reserved_file_extent(trans, root,
 					       btrfs_ino(BTRFS_I(inode)),
-					       file_pos, qg_released, &ins);
+					       file_pos - offset, qg_released,
+					       &ins);
 out:
 	btrfs_free_path(path);
 
@@ -2382,7 +2386,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	u64 start, end;
 	int compress_type = 0;
 	int ret = 0;
-	u64 logical_len = ordered_extent->num_bytes;
+	u64 num_bytes = ordered_extent->num_bytes;
+	u64 ram_bytes = ordered_extent->ram_bytes;
 	bool nolock;
 	bool truncated = false;
 	bool range_locked = false;
@@ -2409,9 +2414,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
-		logical_len = ordered_extent->truncated_len;
+		num_bytes = ram_bytes = ordered_extent->truncated_len;
 		/* Truncated the entire extent, don't bother adding */
-		if (!logical_len)
+		if (!num_bytes)
 			goto out;
 	}
 
@@ -2466,13 +2471,14 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
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
@@ -2520,7 +2526,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		u64 unwritten_start = start;
 
 		if (truncated)
-			unwritten_start += logical_len;
+			unwritten_start += num_bytes;
 		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
 
 		/* Drop the cache for the part of the extent we didn't write. */
@@ -2537,7 +2543,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		 * errored out then we don't need to do this as the accounting
 		 * has already been done.
 		 */
-		if ((ret || !logical_len) &&
+		if ((ret || !num_bytes) &&
 		    clear_reserved_extent &&
 		    !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 		    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags))
@@ -6609,8 +6615,11 @@ static struct extent_map *btrfs_create_dio_extent(struct inode *inode,
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
@@ -9743,7 +9752,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		last_alloc = ins.offset;
 		ret = insert_reserved_file_extent(trans, inode,
 						  cur_offset, ins.objectid,
-						  ins.offset, ins.offset,
+						  ins.offset, 0, ins.offset,
 						  ins.offset, 0, 0, 0,
 						  BTRFS_FILE_EXTENT_PREALLOC);
 		if (ret) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 94e2485006ab..3c6edc307657 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -160,15 +160,27 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
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
@@ -182,20 +194,19 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
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
@@ -241,34 +252,6 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
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
index 4a3dd80e776c..a038bda16fdf 100644
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
2.24.0


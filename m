Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCA300E35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 21:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbhAVUwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbhAVUvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:51:16 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E26CC061226
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:34 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u67so4621216pfb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sf/VGTkBOVp1k0vMJxptrl+aS+095yzOgG7VoqiuH4Y=;
        b=WWXEeqHPa1xzbG17c1b/owMUIb4QMiwRaq2nbKjxEH9kkcTUk4YEMcg9ZDJgiy3Uoe
         nXUg9OZ6hikIs/BI3dL/WSGECltRSH/qpLlPKEFwg8WpTy6ARxsayhVyhim1modGCyP2
         dxnHGJB4c4+zk2f0pKULtlTpW7/JskrCdY4peTaY3h3QDsIjSGWkmpWVifvgVkQL/Mo0
         vLFevXV7CO0wkGzHuAf4xaxw+y6qd5J5DQbqLiBTTssXAMu+vRlNXgGvUd6qyPNgfmsJ
         IoWkMlE5TRDxU6Q4WbzLrGBoKHwF1MEA7gI0BlkxyFf5PfdTRqgpFcmvg+UWlsgcv2N3
         YEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sf/VGTkBOVp1k0vMJxptrl+aS+095yzOgG7VoqiuH4Y=;
        b=LlKawdTOZI9IBPt9GCh8G5NyHBf9vRNwZkKA1URwHBLXfzrvKVpwUCvKVd/lG4nHzF
         uejnzViTX0O/U82unp/2eYpwsvOQlaFsefP/J4nOD85+hYAFw4dX8OrbOEv4+7qg5uo8
         5e+TiBsrGLrAexeePHZQrABEtAvJ1jT6Xom7G3XX0LHIX/tDWP32Npcw1b/KeLdx1pap
         Xde8kJFSpdzGFQ6W5n2tMK8ufMTw9bbAJ6PhAveLLw30p3I15IReUkFgf0WpjUrbitUl
         VFfxZDDHUAbPSb0v7OybB6mj3XaSeruPbNNkMUT0r0pR2wCRiiP/koHpu7DOhFijS1gX
         CUlg==
X-Gm-Message-State: AOAM531Ji5M8HeockV7cMCcHMyeO31ZKt0m6GWC36S2AvTaCJEbds/tu
        gVi4gY9NtEoTuCoRHsljy2OpDAmwHw1+aA==
X-Google-Smtp-Source: ABdhPJxKfikyhz2z3V+/3bzXSwYRlDsAuMWnkSgGkQarXU4Vdt2cgxRUmP6O5yxGUXkuK3mmCgLNFA==
X-Received: by 2002:aa7:978e:0:b029:1bd:f965:66dd with SMTP id o14-20020aa7978e0000b02901bdf96566ddmr3196881pfp.46.1611348453371;
        Fri, 22 Jan 2021 12:47:33 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id j18sm4092900pfc.99.2021.01.22.12.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:47:32 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 06/10] btrfs: add ram_bytes and offset to btrfs_ordered_extent
Date:   Fri, 22 Jan 2021 12:46:53 -0800
Message-Id: <5c1bfbc1277255b334edb8f8b319fc7bd1856460.1611346706.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611346706.git.osandov@fb.com>
References: <cover.1611346706.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c        | 56 ++++++++++++++++++---------------
 fs/btrfs/ordered-data.c | 68 ++++++++++++++++-------------------------
 fs/btrfs/ordered-data.h | 16 ++++------
 3 files changed, 64 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b92c4a1d6d2f..139d690f171e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -912,13 +912,12 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
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
 			btrfs_drop_extent_cache(inode, async_extent->start,
 						async_extent->start +
@@ -1126,8 +1125,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 		free_extent_map(em);
 
-		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
-					       ram_size, cur_alloc_size, 0);
+		ret = btrfs_add_ordered_extent(inode, start, ram_size, ram_size,
+					       ins.objectid, cur_alloc_size, 0,
+					       0, BTRFS_COMPRESS_NONE);
 		if (ret)
 			goto out_drop_extent_cache;
 
@@ -1768,10 +1768,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
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
 				btrfs_drop_extent_cache(inode, cur_offset,
 							cur_offset + num_bytes - 1,
@@ -1780,9 +1781,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
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
@@ -2586,6 +2589,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_key ins;
 	u64 disk_num_bytes = btrfs_stack_file_extent_disk_num_bytes(stack_fi);
 	u64 disk_bytenr = btrfs_stack_file_extent_disk_bytenr(stack_fi);
+	u64 offset = btrfs_stack_file_extent_offset(stack_fi);
 	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
 	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
 	struct btrfs_drop_extents_args drop_args = { 0 };
@@ -2660,7 +2664,8 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 		goto out;
 
 	ret = btrfs_alloc_reserved_file_extent(trans, root, btrfs_ino(inode),
-					       file_pos, qgroup_reserved, &ins);
+					       file_pos - offset,
+					       qgroup_reserved, &ins);
 out:
 	btrfs_free_path(path);
 
@@ -2686,20 +2691,20 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 					     struct btrfs_ordered_extent *oe)
 {
 	struct btrfs_file_extent_item stack_fi;
-	u64 logical_len;
 	bool update_inode_bytes;
+	u64 num_bytes = oe->num_bytes;
+	u64 ram_bytes = oe->ram_bytes;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
 	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
 	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, oe->disk_bytenr);
 	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi,
 						   oe->disk_num_bytes);
+	btrfs_set_stack_file_extent_offset(&stack_fi, oe->offset);
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags))
-		logical_len = oe->truncated_len;
-	else
-		logical_len = oe->num_bytes;
-	btrfs_set_stack_file_extent_num_bytes(&stack_fi, logical_len);
-	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, logical_len);
+		num_bytes = ram_bytes = oe->truncated_len;
+	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
+	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
 	/* Encryption and other encoding is reserved and all 0 */
 
@@ -7053,8 +7058,11 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		if (IS_ERR(em))
 			goto out;
 	}
-	ret = btrfs_add_ordered_extent_dio(inode, start, block_start, len,
-					   block_len, type);
+	ret = btrfs_add_ordered_extent(inode, start, len, len, block_start,
+				       block_len, 0,
+				       (1 << type) |
+				       (1 << BTRFS_ORDERED_DIRECT),
+				       BTRFS_COMPRESS_NONE);
 	if (ret) {
 		if (em) {
 			free_extent_map(em);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index d5d326c674b1..e11a517fab10 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -153,16 +153,27 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
 	return ret;
 }
 
-/*
- * Allocate and add a new ordered_extent into the per-inode tree.
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
-static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-				      u64 disk_bytenr, u64 num_bytes,
-				      u64 disk_num_bytes, int type, int dio,
-				      int compress_type)
+int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
+			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			     u64 disk_num_bytes, u64 offset, int flags,
+			     int compress_type)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -171,7 +182,8 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	struct btrfs_ordered_extent *entry;
 	int ret;
 
-	if (type == BTRFS_ORDERED_NOCOW || type == BTRFS_ORDERED_PREALLOC) {
+	if (flags &
+	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
 		if (ret < 0)
@@ -191,21 +203,21 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 		return -ENOMEM;
 
 	entry->file_offset = file_offset;
-	entry->disk_bytenr = disk_bytenr;
 	entry->num_bytes = num_bytes;
+	entry->ram_bytes = ram_bytes;
+	entry->disk_bytenr = disk_bytenr;
 	entry->disk_num_bytes = disk_num_bytes;
+	entry->offset = offset;
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
-	if (type != BTRFS_ORDERED_IO_DONE && type != BTRFS_ORDERED_COMPLETE)
-		set_bit(type, &entry->flags);
 
-	if (dio) {
+	entry->flags = flags;
+	if (flags & (1 << BTRFS_ORDERED_DIRECT)) {
 		percpu_counter_add_batch(&fs_info->dio_bytes, num_bytes,
 					 fs_info->delalloc_batch);
-		set_bit(BTRFS_ORDERED_DIRECT, &entry->flags);
 	}
 
 	/* one ref for the tree */
@@ -252,34 +264,6 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	return 0;
 }
 
-int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
-			     int type)
-{
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
-					  num_bytes, disk_num_bytes, type, 0,
-					  BTRFS_COMPRESS_NONE);
-}
-
-int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
-				 u64 disk_bytenr, u64 num_bytes,
-				 u64 disk_num_bytes, int type)
-{
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
-					  num_bytes, disk_num_bytes, type, 1,
-					  BTRFS_COMPRESS_NONE);
-}
-
-int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 file_offset,
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
index 46194c2c05d4..8c8d6ed7a350 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -72,9 +72,11 @@ struct btrfs_ordered_extent {
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
@@ -160,15 +162,9 @@ bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 				   u64 *file_offset, u64 io_size,
 				   int uptodate);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
-			     int type);
-int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
-				 u64 disk_bytenr, u64 num_bytes,
-				 u64 disk_num_bytes, int type);
-int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 file_offset,
-				      u64 disk_bytenr, u64 num_bytes,
-				      u64 disk_num_bytes, int type,
-				      int compress_type);
+			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			     u64 disk_num_bytes, u64 offset, int flags,
+			     int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
-- 
2.30.0


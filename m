Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4510436D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 19:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfKTSZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 13:25:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39867 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfKTSZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:25:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so139947pfo.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5rYlwXOvdRDpCyhL7WakxYaGWlsok8OWIBInqYDbio=;
        b=drNnk6lyNl9cA91COkH8BndGBLkWcVKxuz8wuZZnKcS6HiYQY6iY53olFxiWKTWTE/
         JV3W0RLH3gAhxPuPcHmj2NCy1eQyoT7UwgXJ77HNV6joT3JE1sstJTb/m7qam+EyxGnV
         9K+GG+Xajrbc3fWQluZvKB8FWes1O+Es+SSbKO6cVP802FrpBqtwjF7DyslkqnPd3uf9
         R6Guh7bEl6qewjbFmWpMOUhkRsl3G1fpDZ3rcwNl2kHETKkzsCWzuNUGGL5+W9RRfskc
         7jQ+g/c59m91LMfMQcYtnsnD/qHkApzTGY7enTaFdd0jDMrnCVp2++WhSNN4q5he8dIl
         toYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5rYlwXOvdRDpCyhL7WakxYaGWlsok8OWIBInqYDbio=;
        b=UXqHZthUM/fcKs0ffAGS3Go+sz/qxSKp+Uig403/OPzMO5+es8v8GEUGA45TkjGQTy
         TvJ5/8/MzdpnVxxy3VXC8FI/uHTSXH3st02vFL0U7nh5u2L77Z7Owl4IOm0i/sdxrQeZ
         g1Bkxo9OkYCmDVp0XJ5qyJZCSkItfwmfY+boPpX9JFAaG16cOZwiOHSXQnkWf1GgdkBV
         HrQNIsDqD7dDzlr4Ap/BhaTJSBZP67Of1C1LpuMH28jf+/UKPhCoJTXyM6vQC2u7RA4X
         YWhzyRFc90BO0/NvjT3F55FF+d/GghMh34wAEDooyyZZ33R3KDbsMOyekxZ09WmIFkgi
         JF3A==
X-Gm-Message-State: APjAAAUqhG06r54MpD/pLDfGzWMFV7B1YNKs3gzOYDMzZMOwtHcMPm2g
        ukeC/1luBV7D/N+mupLCn6E8Dc+vVcs=
X-Google-Smtp-Source: APXvYqyLip47IVJP/87RPDqShcX5UQGvPup0I+W/1BNyOY1zRI/N3sj0t5396mbcPyVJYqUJeCEoPQ==
X-Received: by 2002:a63:4705:: with SMTP id u5mr4720438pga.7.1574274300183;
        Wed, 20 Nov 2019 10:25:00 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:24:59 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 07/12] btrfs: make btrfs_ordered_extent naming consistent with btrfs_file_extent_item
Date:   Wed, 20 Nov 2019 10:24:27 -0800
Message-Id: <693ec6051dcda761616283cc3adb5260be0de85f.1574273658.git.osandov@fb.com>
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

ordered->start, ordered->len, and ordered->disk_len correspond to
fi->disk_bytenr, fi->num_bytes, and fi->disk_num_bytes, respectively.
It's confusing to translate between the two naming schemes. Since a
btrfs_ordered_extent is basically a pending btrfs_file_extent_item,
let's make the former use the naming from the latter.

Note that I didn't touch the names in tracepoints just in case there are
scripts depending on the current naming.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/file-item.c         |  2 +-
 fs/btrfs/file.c              |  6 ++--
 fs/btrfs/inode.c             | 67 ++++++++++++++++------------------
 fs/btrfs/ordered-data.c      | 69 ++++++++++++++++++------------------
 fs/btrfs/ordered-data.h      | 26 +++++++-------
 fs/btrfs/relocation.c        |  5 +--
 include/trace/events/btrfs.h |  6 ++--
 7 files changed, 89 insertions(+), 92 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c95772949b00..aae674b37bed 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -484,7 +484,7 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 
 		for (i = 0; i < nr_sectors; i++) {
 			if (!one_ordered &&
-			    (offset >= ordered->file_offset + ordered->len ||
+			    (offset >= ordered->file_offset + ordered->num_bytes ||
 			     offset < ordered->file_offset)) {
 				unsigned long bytes_left;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 435a502a3226..34c1a2284e03 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1503,7 +1503,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 		ordered = btrfs_lookup_ordered_range(inode, start_pos,
 						     last_pos - start_pos + 1);
 		if (ordered &&
-		    ordered->file_offset + ordered->len > start_pos &&
+		    ordered->file_offset + ordered->num_bytes > start_pos &&
 		    ordered->file_offset <= last_pos) {
 			unlock_extent_cached(&inode->io_tree, start_pos,
 					last_pos, cached_state);
@@ -2428,7 +2428,7 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 		 * we need to try again.
 		 */
 		if ((!ordered ||
-		    (ordered->file_offset + ordered->len <= lockstart ||
+		    (ordered->file_offset + ordered->num_bytes <= lockstart ||
 		     ordered->file_offset > lockend)) &&
 		     !filemap_range_has_page(inode->i_mapping,
 					     lockstart, lockend)) {
@@ -3250,7 +3250,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 		ordered = btrfs_lookup_first_ordered_extent(inode, locked_end);
 
 		if (ordered &&
-		    ordered->file_offset + ordered->len > alloc_start &&
+		    ordered->file_offset + ordered->num_bytes > alloc_start &&
 		    ordered->file_offset < alloc_end) {
 			btrfs_put_ordered_extent(ordered);
 			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 707b4d86409f..62d6aaccc202 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2379,9 +2379,10 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	struct btrfs_trans_handle *trans = NULL;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_state *cached_state = NULL;
+	u64 start, end;
 	int compress_type = 0;
 	int ret = 0;
-	u64 logical_len = ordered_extent->len;
+	u64 logical_len = ordered_extent->num_bytes;
 	bool nolock;
 	bool truncated = false;
 	bool range_locked = false;
@@ -2389,6 +2390,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	bool clear_reserved_extent = true;
 	unsigned int clear_bits;
 
+	start = ordered_extent->file_offset;
+	end = start + ordered_extent->num_bytes - 1;
+
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 	    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags) &&
 	    !test_bit(BTRFS_ORDERED_DIRECT, &ordered_extent->flags))
@@ -2401,10 +2405,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	btrfs_free_io_failure_record(BTRFS_I(inode),
-			ordered_extent->file_offset,
-			ordered_extent->file_offset +
-			ordered_extent->len - 1);
+	btrfs_free_io_failure_record(BTRFS_I(inode), start, end);
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
@@ -2422,8 +2423,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		 * space for NOCOW range.
 		 * As NOCOW won't cause a new delayed ref, just free the space
 		 */
-		btrfs_qgroup_free_data(inode, NULL, ordered_extent->file_offset,
-				       ordered_extent->len);
+		btrfs_qgroup_free_data(inode, NULL, start,
+				       ordered_extent->num_bytes);
 		btrfs_ordered_update_i_size(inode, 0, ordered_extent);
 		if (nolock)
 			trans = btrfs_join_transaction_nolock(root);
@@ -2442,9 +2443,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	}
 
 	range_locked = true;
-	lock_extent_bits(io_tree, ordered_extent->file_offset,
-			 ordered_extent->file_offset + ordered_extent->len - 1,
-			 &cached_state);
+	lock_extent_bits(io_tree, start, end, &cached_state);
 
 	if (nolock)
 		trans = btrfs_join_transaction_nolock(root);
@@ -2462,31 +2461,30 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		compress_type = ordered_extent->compress_type;
 	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
 		BUG_ON(compress_type);
-		btrfs_qgroup_free_data(inode, NULL, ordered_extent->file_offset,
-				       ordered_extent->len);
+		btrfs_qgroup_free_data(inode, NULL, start,
+				       ordered_extent->num_bytes);
 		ret = btrfs_mark_extent_written(trans, BTRFS_I(inode),
 						ordered_extent->file_offset,
 						ordered_extent->file_offset +
 						logical_len);
 	} else {
 		BUG_ON(root == fs_info->tree_root);
-		ret = insert_reserved_file_extent(trans, inode,
-						ordered_extent->file_offset,
-						ordered_extent->start,
-						ordered_extent->disk_len,
+		ret = insert_reserved_file_extent(trans, inode, start,
+						ordered_extent->disk_bytenr,
+						ordered_extent->disk_num_bytes,
 						logical_len, logical_len,
 						compress_type, 0, 0,
 						BTRFS_FILE_EXTENT_REG);
 		if (!ret) {
 			clear_reserved_extent = false;
 			btrfs_release_delalloc_bytes(fs_info,
-						     ordered_extent->start,
-						     ordered_extent->disk_len);
+						ordered_extent->disk_bytenr,
+						ordered_extent->disk_num_bytes);
 		}
 	}
 	unpin_extent_cache(&BTRFS_I(inode)->extent_tree,
-			   ordered_extent->file_offset, ordered_extent->len,
-			   trans->transid);
+			   ordered_extent->file_offset,
+			   ordered_extent->num_bytes, trans->transid);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -2511,27 +2509,23 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		clear_bits |= EXTENT_LOCKED;
 	if (clear_new_delalloc_bytes)
 		clear_bits |= EXTENT_DELALLOC_NEW;
-	clear_extent_bit(&BTRFS_I(inode)->io_tree,
-			 ordered_extent->file_offset,
-			 ordered_extent->file_offset + ordered_extent->len - 1,
-			 clear_bits, (clear_bits & EXTENT_LOCKED) ? 1 : 0, 0,
+	clear_extent_bit(&BTRFS_I(inode)->io_tree, start, end, clear_bits,
+			 (clear_bits & EXTENT_LOCKED) ? 1 : 0, 0,
 			 &cached_state);
 
 	if (trans)
 		btrfs_end_transaction(trans);
 
 	if (ret || truncated) {
-		u64 start, end;
+		u64 unwritten_start = start;
 
 		if (truncated)
-			start = ordered_extent->file_offset + logical_len;
-		else
-			start = ordered_extent->file_offset;
-		end = ordered_extent->file_offset + ordered_extent->len - 1;
-		clear_extent_uptodate(io_tree, start, end, NULL);
+			unwritten_start += logical_len;
+		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
 
 		/* Drop the cache for the part of the extent we didn't write. */
-		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
+		btrfs_drop_extent_cache(BTRFS_I(inode), unwritten_start, end,
+					0);
 
 		/*
 		 * If the ordered extent had an IOERR or something else went
@@ -2548,11 +2542,11 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		    !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 		    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags))
 			btrfs_free_reserved_extent(fs_info,
-						   ordered_extent->start,
-						   ordered_extent->disk_len, 1);
+						ordered_extent->disk_bytenr,
+						ordered_extent->disk_num_bytes,
+						1);
 	}
 
-
 	/*
 	 * This needs to be done to make sure anybody waiting knows we are done
 	 * updating everything for this ordered extent.
@@ -8173,7 +8167,8 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
 					page_end - start + 1);
 	if (ordered) {
-		end = min(page_end, ordered->file_offset + ordered->len - 1);
+		end = min(page_end,
+			  ordered->file_offset + ordered->num_bytes - 1);
 		/*
 		 * IO on this page will never be started, so we need
 		 * to account for any ordered extents now
@@ -8702,7 +8697,7 @@ void btrfs_destroy_inode(struct inode *inode)
 		else {
 			btrfs_err(fs_info,
 				  "found ordered extent %llu %llu on inode cleanup",
-				  ordered->file_offset, ordered->len);
+				  ordered->file_offset, ordered->num_bytes);
 			btrfs_remove_ordered_extent(inode, ordered);
 			btrfs_put_ordered_extent(ordered);
 			btrfs_put_ordered_extent(ordered);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 24b6c72b9a59..94e2485006ab 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -20,9 +20,9 @@ static struct kmem_cache *btrfs_ordered_extent_cache;
 
 static u64 entry_end(struct btrfs_ordered_extent *entry)
 {
-	if (entry->file_offset + entry->len < entry->file_offset)
+	if (entry->file_offset + entry->num_bytes < entry->file_offset)
 		return (u64)-1;
-	return entry->file_offset + entry->len;
+	return entry->file_offset + entry->num_bytes;
 }
 
 /* returns NULL if the insertion worked, or it returns the node it did find
@@ -120,7 +120,7 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 file_offset,
 static int offset_in_entry(struct btrfs_ordered_extent *entry, u64 file_offset)
 {
 	if (file_offset < entry->file_offset ||
-	    entry->file_offset + entry->len <= file_offset)
+	    entry->file_offset + entry->num_bytes <= file_offset)
 		return 0;
 	return 1;
 }
@@ -129,7 +129,7 @@ static int range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
 			  u64 len)
 {
 	if (file_offset + len <= entry->file_offset ||
-	    entry->file_offset + entry->len <= file_offset)
+	    entry->file_offset + entry->num_bytes <= file_offset)
 		return 0;
 	return 1;
 }
@@ -161,19 +161,14 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
 }
 
 /* allocate and add a new ordered_extent into the per-inode tree.
- * file_offset is the logical offset in the file
- *
- * start is the disk block number of an extent already reserved in the
- * extent allocation tree
- *
- * len is the length of the extent
  *
  * The tree is given a single reference on the ordered extent that was
  * inserted.
  */
 static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
-				      u64 start, u64 len, u64 disk_len,
-				      int type, int dio, int compress_type)
+				      u64 disk_bytenr, u64 num_bytes,
+				      u64 disk_num_bytes, int type, int dio,
+				      int compress_type)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -187,10 +182,10 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 		return -ENOMEM;
 
 	entry->file_offset = file_offset;
-	entry->start = start;
-	entry->len = len;
-	entry->disk_len = disk_len;
-	entry->bytes_left = len;
+	entry->disk_bytenr = disk_bytenr;
+	entry->num_bytes = num_bytes;
+	entry->disk_num_bytes = disk_num_bytes;
+	entry->bytes_left = num_bytes;
 	entry->inode = igrab(inode);
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
@@ -198,7 +193,7 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 		set_bit(type, &entry->flags);
 
 	if (dio) {
-		percpu_counter_add_batch(&fs_info->dio_bytes, len,
+		percpu_counter_add_batch(&fs_info->dio_bytes, num_bytes,
 					 fs_info->delalloc_batch);
 		set_bit(BTRFS_ORDERED_DIRECT, &entry->flags);
 	}
@@ -247,27 +242,30 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 }
 
 int btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
-			     u64 start, u64 len, u64 disk_len, int type)
+			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
+			     int type)
 {
-	return __btrfs_add_ordered_extent(inode, file_offset, start, len,
-					  disk_len, type, 0,
+	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
+					  num_bytes, disk_num_bytes, type, 0,
 					  BTRFS_COMPRESS_NONE);
 }
 
 int btrfs_add_ordered_extent_dio(struct inode *inode, u64 file_offset,
-				 u64 start, u64 len, u64 disk_len, int type)
+				 u64 disk_bytenr, u64 num_bytes,
+				 u64 disk_num_bytes, int type)
 {
-	return __btrfs_add_ordered_extent(inode, file_offset, start, len,
-					  disk_len, type, 1,
+	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
+					  num_bytes, disk_num_bytes, type, 1,
 					  BTRFS_COMPRESS_NONE);
 }
 
 int btrfs_add_ordered_extent_compress(struct inode *inode, u64 file_offset,
-				      u64 start, u64 len, u64 disk_len,
-				      int type, int compress_type)
+				      u64 disk_bytenr, u64 num_bytes,
+				      u64 disk_num_bytes, int type,
+				      int compress_type)
 {
-	return __btrfs_add_ordered_extent(inode, file_offset, start, len,
-					  disk_len, type, 0,
+	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
+					  num_bytes, disk_num_bytes, type, 0,
 					  compress_type);
 }
 
@@ -328,8 +326,8 @@ int btrfs_dec_test_first_ordered_pending(struct inode *inode,
 	}
 
 	dec_start = max(*file_offset, entry->file_offset);
-	dec_end = min(*file_offset + io_size, entry->file_offset +
-		      entry->len);
+	dec_end = min(*file_offset + io_size,
+		      entry->file_offset + entry->num_bytes);
 	*file_offset = dec_end;
 	if (dec_start > dec_end) {
 		btrfs_crit(fs_info, "bad ordering dec_start %llu end %llu",
@@ -471,10 +469,11 @@ void btrfs_remove_ordered_extent(struct inode *inode,
 	btrfs_mod_outstanding_extents(btrfs_inode, -1);
 	spin_unlock(&btrfs_inode->lock);
 	if (root != fs_info->tree_root)
-		btrfs_delalloc_release_metadata(btrfs_inode, entry->len, false);
+		btrfs_delalloc_release_metadata(btrfs_inode, entry->num_bytes,
+						false);
 
 	if (test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
-		percpu_counter_add_batch(&fs_info->dio_bytes, -entry->len,
+		percpu_counter_add_batch(&fs_info->dio_bytes, -entry->num_bytes,
 					 fs_info->delalloc_batch);
 
 	tree = &btrfs_inode->ordered_tree;
@@ -534,8 +533,8 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 		ordered = list_first_entry(&splice, struct btrfs_ordered_extent,
 					   root_extent_list);
 
-		if (range_end <= ordered->start ||
-		    ordered->start + ordered->disk_len <= range_start) {
+		if (range_end <= ordered->disk_bytenr ||
+		    ordered->disk_bytenr + ordered->disk_num_bytes <= range_start) {
 			list_move_tail(&ordered->root_extent_list, &skipped);
 			cond_resched_lock(&root->ordered_extent_lock);
 			continue;
@@ -624,7 +623,7 @@ void btrfs_start_ordered_extent(struct inode *inode,
 				       int wait)
 {
 	u64 start = entry->file_offset;
-	u64 end = start + entry->len - 1;
+	u64 end = start + entry->num_bytes - 1;
 
 	trace_btrfs_ordered_extent_start(inode, entry);
 
@@ -685,7 +684,7 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
 			btrfs_put_ordered_extent(ordered);
 			break;
 		}
-		if (ordered->file_offset + ordered->len <= start) {
+		if (ordered->file_offset + ordered->num_bytes <= start) {
 			btrfs_put_ordered_extent(ordered);
 			break;
 		}
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 5204171ea962..4a3dd80e776c 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -67,14 +67,13 @@ struct btrfs_ordered_extent {
 	/* logical offset in the file */
 	u64 file_offset;
 
-	/* disk byte number */
-	u64 start;
-
-	/* ram length of the extent in bytes */
-	u64 len;
-
-	/* extent length on disk */
-	u64 disk_len;
+	/*
+	 * These fields directly correspond to the same fields in
+	 * btrfs_file_extent_item.
+	 */
+	u64 disk_bytenr;
+	u64 num_bytes;
+	u64 disk_num_bytes;
 
 	/* number of bytes that still need writing */
 	u64 bytes_left;
@@ -161,12 +160,15 @@ int btrfs_dec_test_first_ordered_pending(struct inode *inode,
 				   u64 *file_offset, u64 io_size,
 				   int uptodate);
 int btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
-			     u64 start, u64 len, u64 disk_len, int type);
+			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
+			     int type);
 int btrfs_add_ordered_extent_dio(struct inode *inode, u64 file_offset,
-				 u64 start, u64 len, u64 disk_len, int type);
+				 u64 disk_bytenr, u64 num_bytes,
+				 u64 disk_num_bytes, int type);
 int btrfs_add_ordered_extent_compress(struct inode *inode, u64 file_offset,
-				      u64 start, u64 len, u64 disk_len,
-				      int type, int compress_type);
+				      u64 disk_bytenr, u64 num_bytes,
+				      u64 disk_num_bytes, int type,
+				      int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct inode *inode,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5cd42b66818c..e3cec29813ee 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4617,7 +4617,7 @@ int btrfs_reloc_clone_csums(struct inode *inode, u64 file_pos, u64 len)
 	LIST_HEAD(list);
 
 	ordered = btrfs_lookup_ordered_extent(inode, file_pos);
-	BUG_ON(ordered->file_offset != file_pos || ordered->len != len);
+	BUG_ON(ordered->file_offset != file_pos || ordered->num_bytes != len);
 
 	disk_bytenr = file_pos + BTRFS_I(inode)->index_cnt;
 	ret = btrfs_lookup_csums_range(fs_info->csum_root, disk_bytenr,
@@ -4641,7 +4641,8 @@ int btrfs_reloc_clone_csums(struct inode *inode, u64 file_pos, u64 len)
 		 * disk_len vs real len like with real inodes since it's all
 		 * disk length.
 		 */
-		new_bytenr = ordered->start + (sums->bytenr - disk_bytenr);
+		new_bytenr = (ordered->disk_bytenr +
+			      (sums->bytenr - disk_bytenr));
 		sums->bytenr = new_bytenr;
 
 		btrfs_add_ordered_sum(ordered, sums);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 75ae1899452b..3a0f172cfc8f 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -496,9 +496,9 @@ DECLARE_EVENT_CLASS(btrfs__ordered_extent,
 	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
 		__entry->ino 		= btrfs_ino(BTRFS_I(inode));
 		__entry->file_offset	= ordered->file_offset;
-		__entry->start		= ordered->start;
-		__entry->len		= ordered->len;
-		__entry->disk_len	= ordered->disk_len;
+		__entry->start		= ordered->disk_bytenr;
+		__entry->len		= ordered->num_bytes;
+		__entry->disk_len	= ordered->disk_num_bytes;
 		__entry->bytes_left	= ordered->bytes_left;
 		__entry->flags		= ordered->flags;
 		__entry->compress_type	= ordered->compress_type;
-- 
2.24.0


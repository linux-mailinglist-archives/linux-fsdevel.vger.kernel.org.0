Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0199C104356
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 19:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfKTSZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 13:25:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42614 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfKTSZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:25:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so122369pgt.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 10:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8S0n7UBjrH5Tk6ePskIrfFRcf0GpPS7vFCDTAfm/wkg=;
        b=VOfTPAcrnHu37GUZRw0cAG2EjoYkYIaUi3XOlZr9DPHhOXXPsRJdEb1GC/p6grcx60
         huYC+DyoMHHdQfcnGDcXvihrSrodx5sEpU88XDUiqYq+qFbenzPHpy43ybuyBrfYpNtO
         oPO10UJUzDY0jxxLw+MaaB2EX1cHBfF9Okn1f1SYxN9zmVkj0MEYPrq4zZhtHr0nA7Lo
         176KAxuU46ilGq9IA5aYlHReJYcQucwj6FhUhy+476CRg2xI8PMHwJ0QR3KZlEvw1mE2
         tmWQlPleCDWy4EAXF4hmHkrW+g458dze2DQ+C3RFjpe+53UJWK4L9/uAGqDIYwj7RCUQ
         onYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8S0n7UBjrH5Tk6ePskIrfFRcf0GpPS7vFCDTAfm/wkg=;
        b=fi+j/0KWvEUUbF/an19Qa3AdoU9vKN4fvRHXed3JcORLfpOnUVsvGyJgvRpVnzOjcV
         yKAg6DJw3ty2BJRz+fQJXjTa2JAmES8RsL/gQNH0kgGIM/29qV7GSrt4E8870vK+2m/i
         ziLMXpFhn3cbioRovbfDdwMLDbS9sZdnuMVxkF5h6X8/iu38zmyzQLsxWImciZtDVlCR
         /whYsbxdH3ZVmLRCt6ScZn5h/UNAOfA4AF1pBv4p0CxRWdPHUnF1sBcUP/25sDUHIyCS
         11Y//UUAS25QM6a0OE64jBinM6sd4iaWddatzQme7IC/X+0dcOGbgr77l7i5iMKw5Mdi
         +9pw==
X-Gm-Message-State: APjAAAULvSUKQYjBp2j9CXthJr3wXDmXzivr/EXHdROMMJfYUIsBy+3v
        281HXop0MrXNbZ+5MGDrdhCU5pyfqdE=
X-Google-Smtp-Source: APXvYqy7Sd4gtfhVpNB0Sgu1D5piLM3zyO5yjulpkHP92sh5O8PC9BvLddlZ4hqAceObMCEgr+v+nQ==
X-Received: by 2002:a63:d544:: with SMTP id v4mr4693179pgi.288.1574274298654;
        Wed, 20 Nov 2019 10:24:58 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:24:58 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 06/12] btrfs: remove dead snapshot-aware defrag code
Date:   Wed, 20 Nov 2019 10:24:26 -0800
Message-Id: <a33a0fddb55101eec47b815672aa42b6f85b3830.1574273658.git.osandov@fb.com>
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

Snapshot-aware defrag has been disabled since commit 8101c8dbf624
("Btrfs: disable snapshot aware defrag for now") almost 6 years ago.
Let's remove the dead code. If someone is up to the task of bringing it
back, they can dig it up from git.

This is logically a revert of commit 38c227d87c49 ("Btrfs:
snapshot-aware defrag") except that now we have to clear the
EXTENT_DEFRAG bit to avoid need_force_cow() returning true forever.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 695 +----------------------------------------------
 1 file changed, 11 insertions(+), 684 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4c1ed6dddfd8..707b4d86409f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -44,7 +44,6 @@
 #include "locking.h"
 #include "free-space-cache.h"
 #include "inode-map.h"
-#include "backref.h"
 #include "props.h"
 #include "qgroup.h"
 #include "delalloc-space.h"
@@ -2353,649 +2352,6 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/* snapshot-aware defrag */
-struct sa_defrag_extent_backref {
-	struct rb_node node;
-	struct old_sa_defrag_extent *old;
-	u64 root_id;
-	u64 inum;
-	u64 file_pos;
-	u64 extent_offset;
-	u64 num_bytes;
-	u64 generation;
-};
-
-struct old_sa_defrag_extent {
-	struct list_head list;
-	struct new_sa_defrag_extent *new;
-
-	u64 extent_offset;
-	u64 bytenr;
-	u64 offset;
-	u64 len;
-	int count;
-};
-
-struct new_sa_defrag_extent {
-	struct rb_root root;
-	struct list_head head;
-	struct btrfs_path *path;
-	struct inode *inode;
-	u64 file_pos;
-	u64 len;
-	u64 bytenr;
-	u64 disk_len;
-	u8 compress_type;
-};
-
-static int backref_comp(struct sa_defrag_extent_backref *b1,
-			struct sa_defrag_extent_backref *b2)
-{
-	if (b1->root_id < b2->root_id)
-		return -1;
-	else if (b1->root_id > b2->root_id)
-		return 1;
-
-	if (b1->inum < b2->inum)
-		return -1;
-	else if (b1->inum > b2->inum)
-		return 1;
-
-	if (b1->file_pos < b2->file_pos)
-		return -1;
-	else if (b1->file_pos > b2->file_pos)
-		return 1;
-
-	/*
-	 * [------------------------------] ===> (a range of space)
-	 *     |<--->|   |<---->| =============> (fs/file tree A)
-	 * |<---------------------------->| ===> (fs/file tree B)
-	 *
-	 * A range of space can refer to two file extents in one tree while
-	 * refer to only one file extent in another tree.
-	 *
-	 * So we may process a disk offset more than one time(two extents in A)
-	 * and locate at the same extent(one extent in B), then insert two same
-	 * backrefs(both refer to the extent in B).
-	 */
-	return 0;
-}
-
-static void backref_insert(struct rb_root *root,
-			   struct sa_defrag_extent_backref *backref)
-{
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent = NULL;
-	struct sa_defrag_extent_backref *entry;
-	int ret;
-
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct sa_defrag_extent_backref, node);
-
-		ret = backref_comp(backref, entry);
-		if (ret < 0)
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
-
-	rb_link_node(&backref->node, parent, p);
-	rb_insert_color(&backref->node, root);
-}
-
-/*
- * Note the backref might has changed, and in this case we just return 0.
- */
-static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
-				       void *ctx)
-{
-	struct btrfs_file_extent_item *extent;
-	struct old_sa_defrag_extent *old = ctx;
-	struct new_sa_defrag_extent *new = old->new;
-	struct btrfs_path *path = new->path;
-	struct btrfs_key key;
-	struct btrfs_root *root;
-	struct sa_defrag_extent_backref *backref;
-	struct extent_buffer *leaf;
-	struct inode *inode = new->inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	int slot;
-	int ret;
-	u64 extent_offset;
-	u64 num_bytes;
-
-	if (BTRFS_I(inode)->root->root_key.objectid == root_id &&
-	    inum == btrfs_ino(BTRFS_I(inode)))
-		return 0;
-
-	key.objectid = root_id;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-
-	root = btrfs_read_fs_root_no_name(fs_info, &key);
-	if (IS_ERR(root)) {
-		if (PTR_ERR(root) == -ENOENT)
-			return 0;
-		WARN_ON(1);
-		btrfs_debug(fs_info, "inum=%llu, offset=%llu, root_id=%llu",
-			 inum, offset, root_id);
-		return PTR_ERR(root);
-	}
-
-	key.objectid = inum;
-	key.type = BTRFS_EXTENT_DATA_KEY;
-	if (offset > (u64)-1 << 32)
-		key.offset = 0;
-	else
-		key.offset = offset;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (WARN_ON(ret < 0))
-		return ret;
-	ret = 0;
-
-	while (1) {
-		cond_resched();
-
-		leaf = path->nodes[0];
-		slot = path->slots[0];
-
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0) {
-				goto out;
-			} else if (ret > 0) {
-				ret = 0;
-				goto out;
-			}
-			continue;
-		}
-
-		path->slots[0]++;
-
-		btrfs_item_key_to_cpu(leaf, &key, slot);
-
-		if (key.objectid > inum)
-			goto out;
-
-		if (key.objectid < inum || key.type != BTRFS_EXTENT_DATA_KEY)
-			continue;
-
-		extent = btrfs_item_ptr(leaf, slot,
-					struct btrfs_file_extent_item);
-
-		if (btrfs_file_extent_disk_bytenr(leaf, extent) != old->bytenr)
-			continue;
-
-		/*
-		 * 'offset' refers to the exact key.offset,
-		 * NOT the 'offset' field in btrfs_extent_data_ref, ie.
-		 * (key.offset - extent_offset).
-		 */
-		if (key.offset != offset)
-			continue;
-
-		extent_offset = btrfs_file_extent_offset(leaf, extent);
-		num_bytes = btrfs_file_extent_num_bytes(leaf, extent);
-
-		if (extent_offset >= old->extent_offset + old->offset +
-		    old->len || extent_offset + num_bytes <=
-		    old->extent_offset + old->offset)
-			continue;
-		break;
-	}
-
-	backref = kmalloc(sizeof(*backref), GFP_NOFS);
-	if (!backref) {
-		ret = -ENOENT;
-		goto out;
-	}
-
-	backref->root_id = root_id;
-	backref->inum = inum;
-	backref->file_pos = offset;
-	backref->num_bytes = num_bytes;
-	backref->extent_offset = extent_offset;
-	backref->generation = btrfs_file_extent_generation(leaf, extent);
-	backref->old = old;
-	backref_insert(&new->root, backref);
-	old->count++;
-out:
-	btrfs_release_path(path);
-	WARN_ON(ret);
-	return ret;
-}
-
-static noinline bool record_extent_backrefs(struct btrfs_path *path,
-				   struct new_sa_defrag_extent *new)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(new->inode->i_sb);
-	struct old_sa_defrag_extent *old, *tmp;
-	int ret;
-
-	new->path = path;
-
-	list_for_each_entry_safe(old, tmp, &new->head, list) {
-		ret = iterate_inodes_from_logical(old->bytenr +
-						  old->extent_offset, fs_info,
-						  path, record_one_backref,
-						  old, false);
-		if (ret < 0 && ret != -ENOENT)
-			return false;
-
-		/* no backref to be processed for this extent */
-		if (!old->count) {
-			list_del(&old->list);
-			kfree(old);
-		}
-	}
-
-	if (list_empty(&new->head))
-		return false;
-
-	return true;
-}
-
-static int relink_is_mergable(struct extent_buffer *leaf,
-			      struct btrfs_file_extent_item *fi,
-			      struct new_sa_defrag_extent *new)
-{
-	if (btrfs_file_extent_disk_bytenr(leaf, fi) != new->bytenr)
-		return 0;
-
-	if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG)
-		return 0;
-
-	if (btrfs_file_extent_compression(leaf, fi) != new->compress_type)
-		return 0;
-
-	if (btrfs_file_extent_encryption(leaf, fi) ||
-	    btrfs_file_extent_other_encoding(leaf, fi))
-		return 0;
-
-	return 1;
-}
-
-/*
- * Note the backref might has changed, and in this case we just return 0.
- */
-static noinline int relink_extent_backref(struct btrfs_path *path,
-				 struct sa_defrag_extent_backref *prev,
-				 struct sa_defrag_extent_backref *backref)
-{
-	struct btrfs_file_extent_item *extent;
-	struct btrfs_file_extent_item *item;
-	struct btrfs_ordered_extent *ordered;
-	struct btrfs_trans_handle *trans;
-	struct btrfs_ref ref = { 0 };
-	struct btrfs_root *root;
-	struct btrfs_key key;
-	struct extent_buffer *leaf;
-	struct old_sa_defrag_extent *old = backref->old;
-	struct new_sa_defrag_extent *new = old->new;
-	struct btrfs_fs_info *fs_info = btrfs_sb(new->inode->i_sb);
-	struct inode *inode;
-	struct extent_state *cached = NULL;
-	int ret = 0;
-	u64 start;
-	u64 len;
-	u64 lock_start;
-	u64 lock_end;
-	bool merge = false;
-	int index;
-
-	if (prev && prev->root_id == backref->root_id &&
-	    prev->inum == backref->inum &&
-	    prev->file_pos + prev->num_bytes == backref->file_pos)
-		merge = true;
-
-	/* step 1: get root */
-	key.objectid = backref->root_id;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-
-	index = srcu_read_lock(&fs_info->subvol_srcu);
-
-	root = btrfs_read_fs_root_no_name(fs_info, &key);
-	if (IS_ERR(root)) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
-		if (PTR_ERR(root) == -ENOENT)
-			return 0;
-		return PTR_ERR(root);
-	}
-
-	if (btrfs_root_readonly(root)) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
-		return 0;
-	}
-
-	/* step 2: get inode */
-	key.objectid = backref->inum;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-
-	inode = btrfs_iget(fs_info->sb, &key, root, NULL);
-	if (IS_ERR(inode)) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
-		return 0;
-	}
-
-	srcu_read_unlock(&fs_info->subvol_srcu, index);
-
-	/* step 3: relink backref */
-	lock_start = backref->file_pos;
-	lock_end = backref->file_pos + backref->num_bytes - 1;
-	lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start, lock_end,
-			 &cached);
-
-	ordered = btrfs_lookup_first_ordered_extent(inode, lock_end);
-	if (ordered) {
-		btrfs_put_ordered_extent(ordered);
-		goto out_unlock;
-	}
-
-	trans = btrfs_join_transaction(root);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		goto out_unlock;
-	}
-
-	key.objectid = backref->inum;
-	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = backref->file_pos;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0) {
-		goto out_free_path;
-	} else if (ret > 0) {
-		ret = 0;
-		goto out_free_path;
-	}
-
-	extent = btrfs_item_ptr(path->nodes[0], path->slots[0],
-				struct btrfs_file_extent_item);
-
-	if (btrfs_file_extent_generation(path->nodes[0], extent) !=
-	    backref->generation)
-		goto out_free_path;
-
-	btrfs_release_path(path);
-
-	start = backref->file_pos;
-	if (backref->extent_offset < old->extent_offset + old->offset)
-		start += old->extent_offset + old->offset -
-			 backref->extent_offset;
-
-	len = min(backref->extent_offset + backref->num_bytes,
-		  old->extent_offset + old->offset + old->len);
-	len -= max(backref->extent_offset, old->extent_offset + old->offset);
-
-	ret = btrfs_drop_extents(trans, root, inode, start,
-				 start + len, 1);
-	if (ret)
-		goto out_free_path;
-again:
-	key.objectid = btrfs_ino(BTRFS_I(inode));
-	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = start;
-
-	path->leave_spinning = 1;
-	if (merge) {
-		struct btrfs_file_extent_item *fi;
-		u64 extent_len;
-		struct btrfs_key found_key;
-
-		ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
-		if (ret < 0)
-			goto out_free_path;
-
-		path->slots[0]--;
-		leaf = path->nodes[0];
-		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-
-		fi = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		extent_len = btrfs_file_extent_num_bytes(leaf, fi);
-
-		if (extent_len + found_key.offset == start &&
-		    relink_is_mergable(leaf, fi, new)) {
-			btrfs_set_file_extent_num_bytes(leaf, fi,
-							extent_len + len);
-			btrfs_mark_buffer_dirty(leaf);
-			inode_add_bytes(inode, len);
-
-			ret = 1;
-			goto out_free_path;
-		} else {
-			merge = false;
-			btrfs_release_path(path);
-			goto again;
-		}
-	}
-
-	ret = btrfs_insert_empty_item(trans, root, path, &key,
-					sizeof(*extent));
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out_free_path;
-	}
-
-	leaf = path->nodes[0];
-	item = btrfs_item_ptr(leaf, path->slots[0],
-				struct btrfs_file_extent_item);
-	btrfs_set_file_extent_disk_bytenr(leaf, item, new->bytenr);
-	btrfs_set_file_extent_disk_num_bytes(leaf, item, new->disk_len);
-	btrfs_set_file_extent_offset(leaf, item, start - new->file_pos);
-	btrfs_set_file_extent_num_bytes(leaf, item, len);
-	btrfs_set_file_extent_ram_bytes(leaf, item, new->len);
-	btrfs_set_file_extent_generation(leaf, item, trans->transid);
-	btrfs_set_file_extent_type(leaf, item, BTRFS_FILE_EXTENT_REG);
-	btrfs_set_file_extent_compression(leaf, item, new->compress_type);
-	btrfs_set_file_extent_encryption(leaf, item, 0);
-	btrfs_set_file_extent_other_encoding(leaf, item, 0);
-
-	btrfs_mark_buffer_dirty(leaf);
-	inode_add_bytes(inode, len);
-	btrfs_release_path(path);
-
-	btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new->bytenr,
-			       new->disk_len, 0);
-	btrfs_init_data_ref(&ref, backref->root_id, backref->inum,
-			    new->file_pos);  /* start - extent_offset */
-	ret = btrfs_inc_extent_ref(trans, &ref);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out_free_path;
-	}
-
-	ret = 1;
-out_free_path:
-	btrfs_release_path(path);
-	path->leave_spinning = 0;
-	btrfs_end_transaction(trans);
-out_unlock:
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lock_start, lock_end,
-			     &cached);
-	iput(inode);
-	return ret;
-}
-
-static void free_sa_defrag_extent(struct new_sa_defrag_extent *new)
-{
-	struct old_sa_defrag_extent *old, *tmp;
-
-	if (!new)
-		return;
-
-	list_for_each_entry_safe(old, tmp, &new->head, list) {
-		kfree(old);
-	}
-	kfree(new);
-}
-
-static void relink_file_extents(struct new_sa_defrag_extent *new)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(new->inode->i_sb);
-	struct btrfs_path *path;
-	struct sa_defrag_extent_backref *backref;
-	struct sa_defrag_extent_backref *prev = NULL;
-	struct rb_node *node;
-	int ret;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return;
-
-	if (!record_extent_backrefs(path, new)) {
-		btrfs_free_path(path);
-		goto out;
-	}
-	btrfs_release_path(path);
-
-	while (1) {
-		node = rb_first(&new->root);
-		if (!node)
-			break;
-		rb_erase(node, &new->root);
-
-		backref = rb_entry(node, struct sa_defrag_extent_backref, node);
-
-		ret = relink_extent_backref(path, prev, backref);
-		WARN_ON(ret < 0);
-
-		kfree(prev);
-
-		if (ret == 1)
-			prev = backref;
-		else
-			prev = NULL;
-		cond_resched();
-	}
-	kfree(prev);
-
-	btrfs_free_path(path);
-out:
-	free_sa_defrag_extent(new);
-
-	atomic_dec(&fs_info->defrag_running);
-	wake_up(&fs_info->transaction_wait);
-}
-
-static struct new_sa_defrag_extent *
-record_old_file_extents(struct inode *inode,
-			struct btrfs_ordered_extent *ordered)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_path *path;
-	struct btrfs_key key;
-	struct old_sa_defrag_extent *old;
-	struct new_sa_defrag_extent *new;
-	int ret;
-
-	new = kmalloc(sizeof(*new), GFP_NOFS);
-	if (!new)
-		return NULL;
-
-	new->inode = inode;
-	new->file_pos = ordered->file_offset;
-	new->len = ordered->len;
-	new->bytenr = ordered->start;
-	new->disk_len = ordered->disk_len;
-	new->compress_type = ordered->compress_type;
-	new->root = RB_ROOT;
-	INIT_LIST_HEAD(&new->head);
-
-	path = btrfs_alloc_path();
-	if (!path)
-		goto out_kfree;
-
-	key.objectid = btrfs_ino(BTRFS_I(inode));
-	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = new->file_pos;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out_free_path;
-	if (ret > 0 && path->slots[0] > 0)
-		path->slots[0]--;
-
-	/* find out all the old extents for the file range */
-	while (1) {
-		struct btrfs_file_extent_item *extent;
-		struct extent_buffer *l;
-		int slot;
-		u64 num_bytes;
-		u64 offset;
-		u64 end;
-		u64 disk_bytenr;
-		u64 extent_offset;
-
-		l = path->nodes[0];
-		slot = path->slots[0];
-
-		if (slot >= btrfs_header_nritems(l)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out_free_path;
-			else if (ret > 0)
-				break;
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(l, &key, slot);
-
-		if (key.objectid != btrfs_ino(BTRFS_I(inode)))
-			break;
-		if (key.type != BTRFS_EXTENT_DATA_KEY)
-			break;
-		if (key.offset >= new->file_pos + new->len)
-			break;
-
-		extent = btrfs_item_ptr(l, slot, struct btrfs_file_extent_item);
-
-		num_bytes = btrfs_file_extent_num_bytes(l, extent);
-		if (key.offset + num_bytes < new->file_pos)
-			goto next;
-
-		disk_bytenr = btrfs_file_extent_disk_bytenr(l, extent);
-		if (!disk_bytenr)
-			goto next;
-
-		extent_offset = btrfs_file_extent_offset(l, extent);
-
-		old = kmalloc(sizeof(*old), GFP_NOFS);
-		if (!old)
-			goto out_free_path;
-
-		offset = max(new->file_pos, key.offset);
-		end = min(new->file_pos + new->len, key.offset + num_bytes);
-
-		old->bytenr = disk_bytenr;
-		old->extent_offset = extent_offset;
-		old->offset = offset - key.offset;
-		old->len = end - offset;
-		old->new = new;
-		old->count = 0;
-		list_add_tail(&old->list, &new->head);
-next:
-		path->slots[0]++;
-		cond_resched();
-	}
-
-	btrfs_free_path(path);
-	atomic_inc(&fs_info->defrag_running);
-
-	return new;
-
-out_free_path:
-	btrfs_free_path(path);
-out_kfree:
-	free_sa_defrag_extent(new);
-	return NULL;
-}
-
 static void btrfs_release_delalloc_bytes(struct btrfs_fs_info *fs_info,
 					 u64 start, u64 len)
 {
@@ -3023,7 +2379,6 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	struct btrfs_trans_handle *trans = NULL;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_state *cached_state = NULL;
-	struct new_sa_defrag_extent *new = NULL;
 	int compress_type = 0;
 	int ret = 0;
 	u64 logical_len = ordered_extent->len;
@@ -3032,6 +2387,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	bool range_locked = false;
 	bool clear_new_delalloc_bytes = false;
 	bool clear_reserved_extent = true;
+	unsigned int clear_bits;
 
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 	    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags) &&
@@ -3090,20 +2446,6 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 			 ordered_extent->file_offset + ordered_extent->len - 1,
 			 &cached_state);
 
-	ret = test_range_bit(io_tree, ordered_extent->file_offset,
-			ordered_extent->file_offset + ordered_extent->len - 1,
-			EXTENT_DEFRAG, 0, cached_state);
-	if (ret) {
-		u64 last_snapshot = btrfs_root_last_snapshot(&root->root_item);
-		if (0 && last_snapshot >= BTRFS_I(inode)->generation)
-			/* the inode is shared */
-			new = record_old_file_extents(inode, ordered_extent);
-
-		clear_extent_bit(io_tree, ordered_extent->file_offset,
-			ordered_extent->file_offset + ordered_extent->len - 1,
-			EXTENT_DEFRAG, 0, 0, &cached_state);
-	}
-
 	if (nolock)
 		trans = btrfs_join_transaction_nolock(root);
 	else
@@ -3164,21 +2506,16 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	}
 	ret = 0;
 out:
-	if (range_locked || clear_new_delalloc_bytes) {
-		unsigned int clear_bits = 0;
-
-		if (range_locked)
-			clear_bits |= EXTENT_LOCKED;
-		if (clear_new_delalloc_bytes)
-			clear_bits |= EXTENT_DELALLOC_NEW;
-		clear_extent_bit(&BTRFS_I(inode)->io_tree,
-				 ordered_extent->file_offset,
-				 ordered_extent->file_offset +
-				 ordered_extent->len - 1,
-				 clear_bits,
-				 (clear_bits & EXTENT_LOCKED) ? 1 : 0,
-				 0, &cached_state);
-	}
+	clear_bits = EXTENT_DEFRAG;
+	if (range_locked)
+		clear_bits |= EXTENT_LOCKED;
+	if (clear_new_delalloc_bytes)
+		clear_bits |= EXTENT_DELALLOC_NEW;
+	clear_extent_bit(&BTRFS_I(inode)->io_tree,
+			 ordered_extent->file_offset,
+			 ordered_extent->file_offset + ordered_extent->len - 1,
+			 clear_bits, (clear_bits & EXTENT_LOCKED) ? 1 : 0, 0,
+			 &cached_state);
 
 	if (trans)
 		btrfs_end_transaction(trans);
@@ -3222,16 +2559,6 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	 */
 	btrfs_remove_ordered_extent(inode, ordered_extent);
 
-	/* for snapshot-aware defrag */
-	if (new) {
-		if (ret) {
-			free_sa_defrag_extent(new);
-			atomic_dec(&fs_info->defrag_running);
-		} else {
-			relink_file_extents(new);
-		}
-	}
-
 	/* once for us */
 	btrfs_put_ordered_extent(ordered_extent);
 	/* once for the tree */
-- 
2.24.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC66A266C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBYBUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBYBTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:11 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF90AD316
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:57 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id be35so816377oib.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXFenPEZv/xsp4VR91nUmDjMApQXD/3LAd9p3F01Vj8=;
        b=qW7A7ggiY2Nn+PoPpY7SljWqqVqJRmfyPf+SobpmZlv1vSBdeNbY9CvJJmEIUkD9qg
         KmUIqwBjTWijIhFfTTlQ7q2AKYsZ6wM9W0sUBDg5/1AjzVxCC4rRhBiJ35qIFFqz4g37
         0jF1uLGIsk4/y12tbc30rORddiOpcUred3mt1JQKQnRRVCF62A/6CHzo7NZipX0+vAR+
         IOt5tWc1MKTM1JvCusO2xAwgTDp0oHD+VV1LvgIzvP880AyMNBa6/Qz4tF0iEXSRfqj+
         e+ppVvVwl/BAR2EPrLlwJ6xUN0qrtSuvev2+oiWkM9ZCe91DVT7QAKklGOpC2JSZ7FCN
         PdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXFenPEZv/xsp4VR91nUmDjMApQXD/3LAd9p3F01Vj8=;
        b=gr4Svi63PpnupI+9ivvvCGmW8O7DAAsbKsVu7YclBgAspZ3meW2Xx2LHIRTaH0Oan5
         wbpKMViEqBN6EuzmGh5tU+WU3V5mGbauZBqFH867/6GqT8kRiCbTrnbgEw1GW8T2WIy1
         4JyblAGHUKQBY04DML9NXLs+xaSMRN1/JVT1My2R/+U48bRsCwJeRK10MOqDq9VZCovI
         eFcGvBRlLWZUaEYGFjBR9+ok6ToLuT8fVrAQN6qeOFxSzX1QK1o6ZuWQm1oHJXnVcpM5
         BpRrULVv6zoeM6mDs/B0xeLOjqRpSw8OZZkeGl/ADNFZnTdYHWTqE3j+M2OEqD0EGmiY
         RjjQ==
X-Gm-Message-State: AO0yUKUqF4HsY97gQTAzt92ROqm2r9wPXYg3T4PpiIs7rYfecAKZjUCx
        x017mHCOh1JukM774Dfy+GbM7p5l5sNCv4B/
X-Google-Smtp-Source: AK7set+x7WMaLlZoZoMKPOLpyPSVB/lpYx7vl0Zq8pjIJMhPOGPF60adMlU6G3Nu3v2mikWDXy9bCA==
X-Received: by 2002:a05:6808:de2:b0:383:f065:8122 with SMTP id g34-20020a0568080de200b00383f0658122mr2331887oic.33.1677287876781;
        Fri, 24 Feb 2023 17:17:56 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:55 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 67/76] ssdfs: extents b-tree specialized operations
Date:   Fri, 24 Feb 2023 17:09:18 -0800
Message-Id: <20230225010927.813929-68-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extents b-tree implements API:
(1) create - create extents b-tree
(2) destroy - destroy extents b-tree
(3) flush - flush dirty extents b-tree
(4) prepare_volume_extent - convert requested offset into extent
(5) recommend_migration_extent - find extent recommended for migration
(6) add_extent - add extent into the extents b-tree
(7) move_extent - move extent from one segment into another one
(8) truncate - truncate extent b-tree

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/extents_tree.c | 3519 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 3519 insertions(+)

diff --git a/fs/ssdfs/extents_tree.c b/fs/ssdfs/extents_tree.c
index a13e7d773e7d..f978ef0cca12 100644
--- a/fs/ssdfs/extents_tree.c
+++ b/fs/ssdfs/extents_tree.c
@@ -3368,3 +3368,3522 @@ int ssdfs_prepare_empty_fork(u64 blk,
 
 	return 0;
 }
+
+/*
+ * ssdfs_extents_tree_add_inline_fork() - add the inline fork into the tree
+ * @tree: extents tree
+ * @search: search object
+ *
+ * This method tries to add the inline fork into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - inline tree hasn't room for the new fork.
+ * %-EEXIST     - fork exists in the tree.
+ */
+static
+int ssdfs_extents_tree_add_inline_fork(struct ssdfs_extents_btree_info *tree,
+				       struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_fork *cur;
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
+	s64 forks_count, forks_capacity;
+	int private_flags;
+	u64 start_hash;
+	u16 start_index;
+	u64 hash1, hash2;
+	u64 len;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->inline_forks) {
+		SSDFS_ERR("empty inline tree %p\n",
+			  tree->inline_forks);
+		return -ERANGE;
+	}
+
+	forks_count = atomic64_read(&tree->forks_count);
+
+	if (!tree->owner) {
+		SSDFS_ERR("empty owner inode\n");
+		return -ERANGE;
+	}
+
+	private_flags = atomic_read(&tree->owner->private_flags);
+
+	forks_capacity = SSDFS_INLINE_FORKS_COUNT;
+	if (private_flags & SSDFS_INODE_HAS_XATTR_BTREE)
+		forks_capacity--;
+	if (private_flags & SSDFS_INODE_HAS_EXTENTS_BTREE) {
+		SSDFS_ERR("the extents tree is generic\n");
+		return -ERANGE;
+	}
+
+	if (forks_count > forks_capacity) {
+		SSDFS_WARN("extents tree is corrupted: "
+			   "forks_count %llu, forks_capacity %llu\n",
+			   (u64)forks_count, (u64)forks_capacity);
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_CORRUPTED);
+		return -ERANGE;
+	} else if (forks_count == forks_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("inline tree hasn't room for the new fork: "
+			  "forks_count %llu, forks_capacity %llu\n",
+			  (u64)forks_count, (u64)forks_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	if (start_hash != le64_to_cpu(search->raw.fork.start_offset)) {
+		SSDFS_ERR("corrupted fork: "
+			  "start_hash %llx, "
+			  "fork (start %llu, blks_count %llu)\n",
+			  start_hash,
+			  le64_to_cpu(search->raw.fork.start_offset),
+			  le64_to_cpu(search->raw.fork.blks_count));
+		return -ERANGE;
+	}
+
+	start_index = search->result.start_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_index %u, forks_count %lld, "
+		  "forks_capacity %lld\n",
+		  start_index, forks_count, forks_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (forks_count == 0) {
+		if (start_index != 0) {
+			SSDFS_ERR("invalid start_index %u\n",
+				  start_index);
+			return -ERANGE;
+		}
+
+		cur = &tree->inline_forks[start_index];
+
+		ssdfs_memcpy(cur, 0, fork_size,
+			     &search->raw.fork, 0, fork_size,
+			     fork_size);
+	} else {
+		if (start_index >= forks_capacity) {
+			SSDFS_ERR("start_index %u >= forks_capacity %llu\n",
+				  start_index, (u64)forks_capacity);
+			return -ERANGE;
+		}
+
+		cur = &tree->inline_forks[start_index];
+
+		if ((start_index + 1) <= forks_count) {
+			err = ssdfs_memmove(tree->inline_forks,
+					    (start_index + 1) * fork_size,
+					    forks_capacity * fork_size,
+					    tree->inline_forks,
+					    start_index * fork_size,
+					    forks_capacity * fork_size,
+					    (forks_count - start_index) *
+						fork_size);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				return err;
+			}
+
+			ssdfs_memcpy(cur, 0, fork_size,
+				     &search->raw.fork, 0, fork_size,
+				     fork_size);
+
+			hash1 = le64_to_cpu(search->raw.fork.start_offset);
+			len = le64_to_cpu(search->raw.fork.blks_count);
+
+			cur = &tree->inline_forks[start_index + 1];
+			hash2 = le64_to_cpu(cur->start_offset);
+
+			if (!((hash1 + len) <= hash2)) {
+				SSDFS_WARN("fork is corrupted: "
+					   "hash1 %llu, len %llu, "
+					   "hash2 %llu\n",
+					   hash1, len, hash2);
+				atomic_set(&tree->state,
+					SSDFS_EXTENTS_BTREE_CORRUPTED);
+				return -ERANGE;
+			}
+		} else {
+			ssdfs_memcpy(cur, 0, fork_size,
+				     &search->raw.fork, 0, fork_size,
+				     fork_size);
+
+			if (start_index > 0) {
+				cur = &tree->inline_forks[start_index - 1];
+
+				hash1 = le64_to_cpu(cur->start_offset);
+				len = le64_to_cpu(cur->blks_count);
+				hash2 =
+				    le64_to_cpu(search->raw.fork.start_offset);
+
+				if (!((hash1 + len) <= hash2)) {
+					SSDFS_WARN("fork is corrupted: "
+						   "hash1 %llu, len %llu, "
+						   "hash2 %llu\n",
+						   hash1, len, hash2);
+					atomic_set(&tree->state,
+						SSDFS_EXTENTS_BTREE_CORRUPTED);
+					return -ERANGE;
+				}
+			}
+		}
+	}
+
+	forks_count = atomic64_inc_return(&tree->forks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("forks_count %lld\n", forks_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (forks_count > forks_capacity) {
+		SSDFS_WARN("forks_count is too much: "
+			   "count %lld, capacity %lld\n",
+			   forks_count, forks_capacity);
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_CORRUPTED);
+		return -ERANGE;
+	}
+
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_DIRTY);
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_add_fork() - add the fork into the tree
+ * @tree: extents tree
+ * @search: search object
+ *
+ * This method tries to add the generic fork into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - fork exists in the tree.
+ */
+static
+int ssdfs_extents_tree_add_fork(struct ssdfs_extents_btree_info *tree,
+				struct ssdfs_btree_search *search)
+{
+	s64 forks_count;
+	u64 start_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->generic_tree) {
+		SSDFS_ERR("empty generic tree %p\n",
+			  tree->generic_tree);
+		return -ERANGE;
+	}
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+	case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+	case SSDFS_BTREE_SEARCH_OBSOLETE_RESULT:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	if (start_hash != le64_to_cpu(search->raw.fork.start_offset)) {
+		SSDFS_ERR("corrupted fork: "
+			  "start_hash %llx, "
+			  "fork (start %llu, blks_count %llu)\n",
+			  start_hash,
+			  le64_to_cpu(search->raw.fork.start_offset),
+			  le64_to_cpu(search->raw.fork.blks_count));
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_add_item(tree->generic_tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add the fork into the tree: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	forks_count = atomic64_read(&tree->forks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("forks_count %lld\n", forks_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (forks_count >= S64_MAX) {
+		SSDFS_WARN("forks_count is too much\n");
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_CORRUPTED);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_synchronize_root_node(tree->generic_tree,
+						tree->root);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to synchronize the root node: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_DIRTY);
+	return 0;
+}
+
+/*
+ * ssdfs_invalidate_inline_tail_forks() - invalidate inline tail forks
+ * @tree: extents tree
+ * @search: search object
+ *
+ * This method tries to invalidate inline tail forks.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_invalidate_inline_tail_forks(struct ssdfs_extents_btree_info *tree,
+					struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_shared_extents_tree *shextree;
+	struct ssdfs_raw_fork *cur;
+	ino_t ino;
+	s64 forks_count;
+	int lower_bound, upper_bound;
+	int i, j;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+	shextree = fsi->shextree;
+
+	if (!shextree) {
+		SSDFS_ERR("shared extents tree is absent\n");
+		return -ERANGE;
+	}
+
+	if (search->request.type != SSDFS_BTREE_SEARCH_INVALIDATE_TAIL) {
+		SSDFS_DBG("nothing should be done\n");
+		return 0;
+	}
+
+	ino = tree->owner->vfs_inode.i_ino;
+	forks_count = atomic64_read(&tree->forks_count);
+
+	lower_bound = search->result.start_index + 1;
+	upper_bound = forks_count - 1;
+
+	for (i = upper_bound; i >= lower_bound; i--) {
+		u64 calculated = 0;
+		u64 blks_count;
+
+		cur = &tree->inline_forks[i];
+
+		if (atomic64_read(&tree->forks_count) == 0) {
+			SSDFS_ERR("invalid forks_count\n");
+			return -ERANGE;
+		} else
+			atomic64_dec(&tree->forks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("forks_count %lld\n",
+			  atomic64_read(&tree->forks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		blks_count = le64_to_cpu(cur->blks_count);
+		if (blks_count == 0 || blks_count >= U64_MAX) {
+			memset(cur, 0xFF, sizeof(struct ssdfs_raw_fork));
+			continue;
+		}
+
+		for (j = SSDFS_INLINE_EXTENTS_COUNT - 1; j >= 0; j--) {
+			struct ssdfs_raw_extent *extent;
+			u32 len;
+
+			extent = &cur->extents[j];
+			len = le32_to_cpu(extent->len);
+
+			if (len == 0 || len >= U32_MAX) {
+				memset(extent, 0xFF,
+					sizeof(struct ssdfs_raw_extent));
+				continue;
+			}
+
+			if ((calculated + len) > blks_count) {
+				atomic_set(&tree->state,
+					   SSDFS_EXTENTS_BTREE_CORRUPTED);
+				SSDFS_ERR("corrupted extent: "
+					  "calculated %llu, len %u, "
+					  "blks %llu\n",
+					  calculated, len, blks_count);
+				return -ERANGE;
+			}
+
+			err = ssdfs_shextree_add_pre_invalid_extent(shextree,
+								    ino,
+								    extent);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add pre-invalid "
+					  "(seg_id %llu, blk %u, "
+					  "len %u), err %d\n",
+				    le64_to_cpu(extent->seg_id),
+				    le32_to_cpu(extent->logical_blk),
+				    len, err);
+				return err;
+			}
+
+			calculated += len;
+
+			memset(extent, 0xFF, sizeof(struct ssdfs_raw_extent));
+		}
+
+		if (calculated != blks_count) {
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_ERR("calculated %llu != blks %llu\n",
+				  calculated, blks_count);
+			return -ERANGE;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_change_inline_fork() - change inline fork
+ * @tree: extents tree
+ * @search: search object
+ *
+ * This method tries to change the existing inline fork.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - fork doesn't exist in the tree.
+ */
+static
+int ssdfs_extents_tree_change_inline_fork(struct ssdfs_extents_btree_info *tree,
+					  struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_shared_extents_tree *shextree;
+	struct ssdfs_raw_fork *cur;
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
+	ino_t ino;
+	u64 start_hash;
+	int private_flags;
+	s64 forks_count, forks_capacity;
+	u16 start_index;
+	u64 start_offset;
+	u64 blks_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+	shextree = fsi->shextree;
+
+	if (!shextree) {
+		SSDFS_ERR("shared extents tree is absent\n");
+		return -ERANGE;
+	}
+
+	ino = tree->owner->vfs_inode.i_ino;
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->inline_forks) {
+		SSDFS_ERR("empty inline tree %p\n",
+			  tree->inline_forks);
+		return -ERANGE;
+	}
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid search object state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	start_offset = le64_to_cpu(search->raw.fork.start_offset);
+	blks_count = le64_to_cpu(search->raw.fork.blks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, fork (start %llu, blks_count %llu)\n",
+		  start_hash, start_offset, blks_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		if ((start_offset + blks_count) != start_hash) {
+			SSDFS_ERR("invalid request: "
+				  "start_hash %llx, "
+				  "fork (start %llu, blks_count %llu)\n",
+				  start_hash, start_offset, blks_count);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		if (start_hash < start_offset ||
+		    start_hash >= (start_offset + blks_count)) {
+			SSDFS_ERR("corrupted fork: "
+				  "start_hash %llx, "
+				  "fork (start %llu, blks_count %llu)\n",
+				  start_hash, start_offset, blks_count);
+			return -ERANGE;
+		}
+		break;
+	}
+
+	forks_count = atomic64_read(&tree->forks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("BEFORE: forks_count %lld\n",
+		  atomic64_read(&tree->forks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!tree->owner) {
+		SSDFS_ERR("empty owner inode\n");
+		return -ERANGE;
+	}
+
+	private_flags = atomic_read(&tree->owner->private_flags);
+
+	forks_capacity = SSDFS_INLINE_FORKS_COUNT;
+	if (private_flags & SSDFS_INODE_HAS_XATTR_BTREE)
+		forks_capacity--;
+	if (private_flags & SSDFS_INODE_HAS_EXTENTS_BTREE) {
+		SSDFS_ERR("the extents tree is generic\n");
+		return -ERANGE;
+	}
+
+	if (forks_count > forks_capacity) {
+		SSDFS_WARN("extents tree is corrupted: "
+			   "forks_count %lld, forks_capacity %lld\n",
+			   forks_count, forks_capacity);
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_CORRUPTED);
+		return -ERANGE;
+	} else if (forks_count == 0) {
+		SSDFS_ERR("empty tree\n");
+		return -ENODATA;
+	}
+
+	start_index = search->result.start_index;
+
+	if (start_index >= forks_count) {
+		SSDFS_ERR("start_index %u >= forks_count %lld\n",
+			  start_index, forks_count);
+		return -ENODATA;
+	}
+
+	cur = &tree->inline_forks[start_index];
+	ssdfs_memcpy(cur, 0, fork_size,
+		     &search->raw.fork, 0, fork_size,
+		     fork_size);
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_DIRTY);
+
+	err = ssdfs_invalidate_inline_tail_forks(tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to invalidate inline tail forks: "
+			  "err %d\n", err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("AFTER: forks_count %lld\n",
+		  atomic64_read(&tree->forks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_change_fork() - change the fork
+ * @tree: extents tree
+ * @search: search object
+ *
+ * This method tries to change the existing generic fork.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - fork doesn't exist in the tree.
+ */
+static
+int ssdfs_extents_tree_change_fork(struct ssdfs_extents_btree_info *tree,
+				   struct ssdfs_btree_search *search)
+{
+	u64 start_hash;
+	u64 start_offset;
+	u64 blks_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->generic_tree) {
+		SSDFS_ERR("empty generic tree %p\n",
+			  tree->generic_tree);
+		return -ERANGE;
+	}
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		/* continue logic */
+		break;
+
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		/* extent has been merged into the existing fork */
+		search->result.state = SSDFS_BTREE_SEARCH_VALID_ITEM;
+		search->result.err = 0;
+		break;
+
+	default:
+		SSDFS_ERR("invalid search object state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	start_offset = le64_to_cpu(search->raw.fork.start_offset);
+	blks_count = le64_to_cpu(search->raw.fork.blks_count);
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+		if (start_hash < start_offset ||
+		    start_hash >= (start_offset + blks_count)) {
+			SSDFS_ERR("corrupted fork: "
+				  "start_hash %llx, "
+				  "fork (start %llu, blks_count %llu)\n",
+				  start_hash, start_offset, blks_count);
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		if (start_hash != (start_offset + blks_count)) {
+			SSDFS_ERR("corrupted fork: "
+				  "start_hash %llx, "
+				  "fork (start %llu, blks_count %llu)\n",
+				  start_hash, start_offset, blks_count);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  search->request.type);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_change_item(tree->generic_tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change the fork into the tree: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_DIRTY);
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_add_extent_nolock() - add extent into the tree
+ * @tree: extents tree
+ * @blk: logical block number
+ * @extent: new extent
+ * @search: search object
+ *
+ * This method tries to add @extent into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - extent exists in the tree.
+ */
+static
+int ssdfs_extents_tree_add_extent_nolock(struct ssdfs_extents_btree_info *tree,
+					 u64 blk,
+					 struct ssdfs_raw_extent *extent,
+					 struct ssdfs_btree_search *search)
+{
+	s64 forks_count;
+	u32 init_flags = SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			 SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+	u32 len;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !extent || !search);
+	BUG_ON(!tree->owner);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p, blk %llu\n",
+		  tree, search, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	forks_count = atomic64_read(&tree->forks_count);
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		err = ssdfs_extents_tree_find_inline_fork(tree, blk, search);
+		if (err == -ENOENT) {
+			/*
+			 * Fork doesn't exist for requested extent.
+			 * It needs to create a new fork.
+			 */
+		} else if (err == -ENODATA) {
+			/*
+			 * Fork doesn't contain the requested extent.
+			 * It needs to add a new extent.
+			 */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the inline fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_add_extent;
+		} else {
+			err = -EEXIST;
+			SSDFS_ERR("block exists already: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_add_extent;
+		}
+
+		if (err == -ENOENT) {
+add_new_inline_fork:
+			ssdfs_debug_btree_search_object(search);
+
+			if (forks_count > 0)
+				search->result.start_index += 1;
+
+			err = ssdfs_prepare_empty_fork(blk, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare empty fork: "
+					  "err %d\n",
+					  err);
+				goto finish_add_extent;
+			}
+
+			ssdfs_debug_btree_search_object(search);
+
+			err = ssdfs_add_extent_into_fork(blk, extent, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add extent into fork: "
+					  "err %d\n",
+					  err);
+				goto finish_add_extent;
+			}
+
+			ssdfs_debug_btree_search_object(search);
+
+			search->request.type = SSDFS_BTREE_SEARCH_ADD_ITEM;
+			err = ssdfs_extents_tree_add_inline_fork(tree, search);
+			if (err == -ENOSPC) {
+				err = ssdfs_migrate_inline2generic_tree(tree);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to migrate the tree: "
+						  "err %d\n",
+						  err);
+					goto finish_add_extent;
+				} else {
+					ssdfs_btree_search_init(search);
+					search->request.type =
+						SSDFS_BTREE_SEARCH_FIND_ITEM;
+					search->request.flags = init_flags;
+					search->request.start.hash = blk;
+					search->request.end.hash = blk + len - 1;
+					search->request.count = 1;
+					goto try_to_add_into_generic_tree;
+				}
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to add fork: err %d\n", err);
+				goto finish_add_extent;
+			}
+		} else {
+			err = ssdfs_add_extent_into_fork(blk, extent, search);
+			if (err == -ENOSPC) {
+				/* try to add a new fork */
+				goto add_new_inline_fork;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to add extent into fork: "
+					  "err %d\n",
+					  err);
+				goto finish_add_extent;
+			}
+
+			search->request.type = SSDFS_BTREE_SEARCH_CHANGE_ITEM;
+			err = ssdfs_extents_tree_change_inline_fork(tree,
+								   search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change fork: err %d\n", err);
+				goto finish_add_extent;
+			}
+		}
+		break;
+
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+try_to_add_into_generic_tree:
+		err = ssdfs_btree_find_item(tree->generic_tree, search);
+		if (err == -ENOENT) {
+			/*
+			 * Fork doesn't exist for requested extent.
+			 * It needs to create a new fork.
+			 */
+		} else if (err == -ENODATA) {
+			/*
+			 * Fork doesn't contain the requested extent.
+			 * It needs to add a new extent.
+			 */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_add_extent;
+		} else {
+			err = -EEXIST;
+			SSDFS_ERR("block exists already: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_add_extent;
+		}
+
+		if (err == -ENOENT) {
+add_new_generic_fork:
+			ssdfs_debug_btree_search_object(search);
+
+			if (forks_count > 0)
+				search->result.start_index += 1;
+
+			err = ssdfs_prepare_empty_fork(blk, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare empty fork: "
+					  "err %d\n",
+					  err);
+				goto finish_add_extent;
+			}
+
+			err = ssdfs_add_extent_into_fork(blk, extent, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add extent into fork: "
+					  "err %d\n",
+					  err);
+				goto finish_add_extent;
+			}
+
+			search->request.type = SSDFS_BTREE_SEARCH_ADD_ITEM;
+			err = ssdfs_extents_tree_add_fork(tree, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add fork: err %d\n", err);
+				goto finish_add_extent;
+			}
+		} else {
+			err = ssdfs_add_extent_into_fork(blk, extent, search);
+			if (err == -ENOSPC || err == -ENODATA) {
+				/* try to add a new fork */
+				goto add_new_generic_fork;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to add extent into fork: "
+					  "err %d\n",
+					  err);
+				goto finish_add_extent;
+			}
+
+			search->request.type = SSDFS_BTREE_SEARCH_CHANGE_ITEM;
+			err = ssdfs_extents_tree_change_fork(tree, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change fork: err %d\n", err);
+				goto finish_add_extent;
+			}
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid extents tree type %#x\n",
+			  atomic_read(&tree->type));
+		goto finish_add_extent;
+	}
+
+finish_add_extent:
+	return err;
+}
+
+/*
+ * __ssdfs_extents_tree_add_extent() - add extent into the tree
+ * @tree: extents tree
+ * @blk: logical block number
+ * @extent: new extent
+ * @search: search object
+ *
+ * This method tries to add @extent into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - extent exists in the tree.
+ */
+int __ssdfs_extents_tree_add_extent(struct ssdfs_extents_btree_info *tree,
+				    u64 blk,
+				    struct ssdfs_raw_extent *extent,
+				    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_inode_info *ii;
+	u32 init_flags = SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			 SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+	u32 len;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !extent || !search);
+	BUG_ON(!tree->owner);
+
+	SSDFS_DBG("tree %p, search %p, blk %llu\n",
+		  tree, search, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ii = tree->owner;
+
+	down_write(&ii->lock);
+	down_write(&tree->lock);
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+	len = le32_to_cpu(extent->len);
+
+	if (len == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("empty extent\n");
+		goto finish_add_extent;
+	}
+
+	if (need_initialize_extent_btree_search(blk, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags = init_flags;
+		search->request.start.hash = blk;
+		search->request.end.hash = blk + len - 1;
+		/* no information about forks count */
+		search->request.count = 0;
+	}
+
+	ssdfs_debug_btree_search_object(search);
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		goto finish_add_extent;
+	};
+
+	err = ssdfs_extents_tree_add_extent_nolock(tree, blk, extent, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add extent: "
+			  "blk %llu, err %d\n",
+			  blk, err);
+		goto finish_add_extent;
+	}
+
+finish_add_extent:
+	up_write(&tree->lock);
+	up_write(&ii->lock);
+
+	ssdfs_btree_search_forget_parent_node(search);
+	ssdfs_btree_search_forget_child_node(search);
+
+	ssdfs_debug_extents_btree_object(tree);
+
+	return err;
+}
+
+/*
+ * ssdfs_change_extent_in_fork() - change extent in the fork
+ * @blk: logical block number
+ * @extent: extent object
+ * @search: search object
+ *
+ * This method tries to change @extent in the fork.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - extent doesn't exist in the fork.
+ */
+static
+int ssdfs_change_extent_in_fork(u64 blk,
+				struct ssdfs_raw_extent *extent,
+				struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_fork *fork;
+	struct ssdfs_raw_extent *cur_extent = NULL;
+	struct ssdfs_raw_extent buf;
+	u64 start_offset;
+	u64 blks_count;
+	u32 len1, len2, len_diff;
+	u64 cur_blk;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!extent || !search);
+
+	SSDFS_DBG("blk %llu, extent %p, search %p\n",
+		  blk, extent, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_EMPTY_RESULT:
+		SSDFS_DBG("no fork in search object\n");
+		return -ENODATA;
+
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid search object state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid search buffer state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_size != sizeof(struct ssdfs_raw_fork) ||
+	    search->result.items_in_buffer != 1) {
+		SSDFS_ERR("invalid search buffer state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	fork = &search->raw.fork;
+	start_offset = le64_to_cpu(fork->start_offset);
+	blks_count = le64_to_cpu(fork->blks_count);
+	len1 = le32_to_cpu(extent->len);
+
+	if (start_offset >= U64_MAX || blks_count >= U64_MAX) {
+		SSDFS_ERR("invalid fork state: "
+			  "start_offset %llu, blks_count %llu\n",
+			  start_offset, blks_count);
+		return -ERANGE;
+	}
+
+	if (blk >= U64_MAX || len1 >= U32_MAX) {
+		SSDFS_ERR("invalid extent: "
+			  "blk %llu, len %u\n",
+			  blk, len1);
+		return -ERANGE;
+	}
+
+	if (start_offset <= blk && blk < (start_offset + blks_count)) {
+		/*
+		 * Expected state
+		 */
+	} else {
+		SSDFS_ERR("extent is out of fork: \n"
+			  "fork (start %llu, blks_count %llu), "
+			  "extent (blk %llu, len %u)\n",
+			  start_offset, blks_count,
+			  blk, len1);
+		return -ENODATA;
+	}
+
+	cur_blk = le64_to_cpu(fork->start_offset);
+	for (i = 0; i < SSDFS_INLINE_EXTENTS_COUNT; i++) {
+		len2 = le32_to_cpu(fork->extents[i].len);
+
+		if (cur_blk == blk) {
+			/* extent is found */
+			cur_extent = &fork->extents[i];
+			break;
+		} else if (blk < cur_blk) {
+			SSDFS_ERR("invalid extent: "
+				  "blk %llu, cur_blk %llu\n",
+				  blk, cur_blk);
+			return -ERANGE;
+		} else if (len2 >= U32_MAX || len2 == 0) {
+			/* empty extent */
+			break;
+		} else {
+			/* it needs to check the next extent */
+			cur_blk += len2;
+		}
+	}
+
+	if (!cur_extent) {
+		SSDFS_ERR("fail to find the extent: blk %llu\n",
+			  blk);
+		return -ENODATA;
+	}
+
+	if (le32_to_cpu(extent->len) == 0) {
+		SSDFS_ERR("empty extent: "
+			  "seg_id %llu, logical_blk %u, len %u\n",
+			  le64_to_cpu(extent->seg_id),
+			  le32_to_cpu(extent->logical_blk),
+			  le32_to_cpu(extent->len));
+		return -ERANGE;
+	}
+
+	ssdfs_memcpy(&buf, 0, sizeof(struct ssdfs_raw_extent),
+		     cur_extent, 0, sizeof(struct ssdfs_raw_extent),
+		     sizeof(struct ssdfs_raw_extent));
+	ssdfs_memcpy(cur_extent, 0, sizeof(struct ssdfs_raw_extent),
+		     extent, 0, sizeof(struct ssdfs_raw_extent),
+		     sizeof(struct ssdfs_raw_extent));
+
+	len2 = le32_to_cpu(buf.len);
+
+	if (len2 < len1) {
+		/* old extent is shorter */
+		len_diff = len1 - len2;
+		blks_count += len_diff;
+		fork->blks_count = cpu_to_le64(blks_count);
+	} else if (len2 > len1) {
+		/* old extent is larger */
+		len_diff = len2 - len1;
+
+		if (blks_count <= len_diff) {
+			SSDFS_ERR("blks_count %llu <= len_diff %u\n",
+				  blks_count, len_diff);
+			return -ERANGE;
+		}
+
+		blks_count -= len_diff;
+		fork->blks_count = cpu_to_le64(blks_count);
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_change_extent() - change extent in the tree
+ * @tree: extents tree
+ * @blk: logical block number
+ * @extent: extent object
+ * @search: search object
+ *
+ * This method tries to change @extent in the @tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - extent doesn't exist in the tree.
+ */
+int ssdfs_extents_tree_change_extent(struct ssdfs_extents_btree_info *tree,
+				     u64 blk,
+				     struct ssdfs_raw_extent *extent,
+				     struct ssdfs_btree_search *search)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !extent || !search);
+
+	SSDFS_DBG("tree %p, search %p, blk %llu\n",
+		  tree, search, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	if (need_initialize_extent_btree_search(blk, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = blk;
+		search->request.end.hash = blk;
+		search->request.count = 1;
+	}
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		down_write(&tree->lock);
+
+		err = ssdfs_extents_tree_find_inline_fork(tree, blk, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the inline fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_change_inline_fork;
+		}
+
+		err = ssdfs_change_extent_in_fork(blk, extent, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change extent in fork: err %d\n",
+				  err);
+			goto finish_change_inline_fork;
+		}
+
+		search->request.type = SSDFS_BTREE_SEARCH_CHANGE_ITEM;
+
+		err = ssdfs_extents_tree_change_inline_fork(tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change inline fork: err %d\n", err);
+			goto finish_change_inline_fork;
+		}
+
+finish_change_inline_fork:
+		up_write(&tree->lock);
+		break;
+
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		down_read(&tree->lock);
+
+		err = ssdfs_btree_find_item(tree->generic_tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_change_generic_fork;
+		}
+
+		err = ssdfs_change_extent_in_fork(blk, extent, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change extent in fork: err %d\n",
+				  err);
+			goto finish_change_generic_fork;
+		}
+
+		search->request.type = SSDFS_BTREE_SEARCH_CHANGE_ITEM;
+
+		err = ssdfs_extents_tree_change_fork(tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change fork: err %d\n", err);
+			goto finish_change_generic_fork;
+		}
+
+finish_change_generic_fork:
+		up_read(&tree->lock);
+
+		ssdfs_btree_search_forget_parent_node(search);
+		ssdfs_btree_search_forget_child_node(search);
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid extents tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_shrink_found_extent() - shrink found extent
+ * @old_extent: old state of extent
+ * @found_extent: shrinking extent [in|out]
+ */
+static inline
+int ssdfs_shrink_found_extent(struct ssdfs_raw_extent *old_extent,
+			      struct ssdfs_raw_extent *found_extent)
+{
+	u64 seg_id1, seg_id2;
+	u32 logical_blk1, logical_blk2;
+	u32 len1, len2;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!old_extent || !found_extent);
+
+	SSDFS_DBG("old_extent %p, found_extent %p\n",
+		  old_extent, found_extent);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	seg_id1 = le64_to_cpu(old_extent->seg_id);
+	logical_blk1 = le32_to_cpu(old_extent->logical_blk);
+	len1 = le32_to_cpu(old_extent->len);
+
+	seg_id2 = le64_to_cpu(found_extent->seg_id);
+	logical_blk2 = le32_to_cpu(found_extent->logical_blk);
+	len2 = le32_to_cpu(found_extent->len);
+
+	if (seg_id1 != seg_id2) {
+		SSDFS_ERR("invalid segment ID: "
+			  "old_extent (seg_id %llu, "
+			  "logical_blk %u, len %u), "
+			  "found_extent (seg_id %llu, "
+			  "logical_blk %u, len %u)\n",
+			  seg_id1, logical_blk1, len1,
+			  seg_id2, logical_blk2, len2);
+		return -ERANGE;
+	}
+
+	if (logical_blk1 != logical_blk2) {
+		SSDFS_ERR("invalid old extent: "
+			  "old_extent (seg_id %llu, "
+			  "logical_blk %u, len %u), "
+			  "found_extent (seg_id %llu, "
+			  "logical_blk %u, len %u)\n",
+			  seg_id1, logical_blk1, len1,
+			  seg_id2, logical_blk2, len2);
+		return -ERANGE;
+	} else {
+		if (len1 > len2) {
+			SSDFS_ERR("invalid length of old extent: "
+				  "old_extent (seg_id %llu, "
+				  "logical_blk %u, len %u), "
+				  "found_extent (seg_id %llu, "
+				  "logical_blk %u, len %u)\n",
+				  seg_id1, logical_blk1, len1,
+				  seg_id2, logical_blk2, len2);
+			return -ERANGE;
+		} else if (len1 < len2) {
+			/* shrink extent */
+			found_extent->len = cpu_to_le32(len2 - len1);
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("extent is empty: "
+				  "old_extent (seg_id %llu, "
+				  "logical_blk %u, len %u), "
+				  "found_extent (seg_id %llu, "
+				  "logical_blk %u, len %u)\n",
+				  seg_id1, logical_blk1, len1,
+				  seg_id2, logical_blk2, len2);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENODATA;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_delete_extent_in_fork() - delete extent from the fork
+ * @blk: logical block number
+ * @search: search object
+ *
+ * This method tries to delete extent from the fork.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - extent doesn't exist in the tree.
+ * %-EFAULT     - fail to create the hole in the fork.
+ */
+static
+int ssdfs_delete_extent_in_fork(u64 blk,
+				struct ssdfs_btree_search *search,
+				struct ssdfs_raw_extent *extent)
+{
+	struct ssdfs_raw_fork *fork;
+	struct ssdfs_raw_extent *cur_extent = NULL;
+	size_t extent_size = sizeof(struct ssdfs_raw_extent);
+	u64 start_offset;
+	u64 blks_count;
+	u64 cur_blk;
+	u32 len;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !extent);
+
+	SSDFS_DBG("blk %llu, search %p\n",
+		  blk, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_EMPTY_RESULT:
+		SSDFS_DBG("no fork in search object\n");
+		return -ENODATA;
+
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid search object state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid search buffer state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_size != sizeof(struct ssdfs_raw_fork) ||
+	    search->result.items_in_buffer != 1) {
+		SSDFS_ERR("invalid search buffer state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	fork = &search->raw.fork;
+	start_offset = le64_to_cpu(fork->start_offset);
+	blks_count = le64_to_cpu(fork->blks_count);
+
+	if (start_offset >= U64_MAX || blks_count >= U64_MAX) {
+		SSDFS_ERR("invalid fork state: "
+			  "start_offset %llu, blks_count %llu\n",
+			  start_offset, blks_count);
+		return -ENODATA;
+	}
+
+	if (blk >= U64_MAX) {
+		SSDFS_ERR("invalid request: blk %llu\n",
+			  blk);
+		return -ERANGE;
+	}
+
+	if (start_offset <= blk && blk < (start_offset + blks_count)) {
+		/*
+		 * Expected state
+		 */
+	} else {
+		SSDFS_ERR("blk %llu is out of fork\n",
+			  blk);
+		return -ERANGE;
+	}
+
+	cur_blk = le64_to_cpu(fork->start_offset);
+	for (i = 0; i < SSDFS_INLINE_EXTENTS_COUNT; i++) {
+		len = le32_to_cpu(fork->extents[i].len);
+
+		if (cur_blk == blk) {
+			/* extent is found */
+			cur_extent = &fork->extents[i];
+			break;
+		} else if (blk < cur_blk) {
+			SSDFS_ERR("invalid extent: "
+				  "blk %llu, cur_blk %llu\n",
+				  blk, cur_blk);
+			return -ERANGE;
+		} else if (len >= U32_MAX || len == 0) {
+			/* empty extent */
+			break;
+		} else {
+			/* it needs to check the next extent */
+			cur_blk += len;
+		}
+	}
+
+	if (!cur_extent) {
+		SSDFS_ERR("fail to find the extent: blk %llu\n",
+			  blk);
+		return -ERANGE;
+	}
+
+	ssdfs_memcpy(extent, 0, extent_size,
+		     cur_extent, 0, extent_size,
+		     extent_size);
+
+	len = le32_to_cpu(fork->extents[i].len);
+
+	if (i < (SSDFS_INLINE_EXTENTS_COUNT - 1)) {
+		err = ssdfs_memmove(fork->extents,
+				    i * extent_size,
+				    SSDFS_INLINE_EXTENTS_COUNT * extent_size,
+				    fork->extents,
+				    (i + 1) * extent_size,
+				    SSDFS_INLINE_EXTENTS_COUNT * extent_size,
+				    (SSDFS_INLINE_EXTENTS_COUNT - i) *
+					extent_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move: err %d\n", err);
+			return err;
+		}
+	} else {
+		memset(&fork->extents[i], 0xFF, extent_size);
+	}
+
+	if (len >= U32_MAX || len == 0) {
+		/*
+		 * Do nothing. Empty extent.
+		 */
+	} else if (blks_count < len) {
+		SSDFS_ERR("blks_count %llu < len %u\n",
+			  blks_count, len);
+		return -ERANGE;
+	}
+
+	blks_count -= len;
+	fork->blks_count = cpu_to_le64(blks_count);
+
+	if (blks_count == 0) {
+		fork->start_offset = cpu_to_le64(U64_MAX);
+		SSDFS_DBG("empty fork\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_move_extent() - move extent (ZNS SSD)
+ * @tree: extents tree
+ * @blk: logical block number
+ * @old_extent: old extent object
+ * @new_extent: new extent object
+ * @search: search object
+ *
+ * This method tries to change @old_extent on @new_extent in the @tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - extent doesn't exist in the tree.
+ */
+int ssdfs_extents_tree_move_extent(struct ssdfs_extents_btree_info *tree,
+				   u64 blk,
+				   struct ssdfs_raw_extent *old_extent,
+				   struct ssdfs_raw_extent *new_extent,
+				   struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_extent extent;
+	u64 new_blk;
+	u32 len;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !old_extent || !new_extent || !search);
+
+	SSDFS_DBG("tree %p, search %p, blk %llu\n",
+		  tree, search, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	if (need_initialize_extent_btree_search(blk, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = blk;
+		search->request.end.hash = blk;
+		search->request.count = 1;
+	}
+
+	down_write(&tree->lock);
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		err = ssdfs_extents_tree_find_inline_fork(tree, blk, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the inline fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_change_fork;
+		}
+
+		err = ssdfs_delete_extent_in_fork(blk, search,
+						  &extent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete extent in fork: err %d\n",
+				  err);
+			goto finish_change_fork;
+		}
+
+		err = ssdfs_shrink_found_extent(old_extent, &extent);
+		if (err == -ENODATA) {
+			/*
+			 * Extent is empty. Do nothing.
+			 */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to shrink extent: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_change_fork;
+		} else {
+			len = le32_to_cpu(old_extent->len);
+			new_blk = blk + len;
+
+			err = ssdfs_add_extent_into_fork(new_blk,
+							 &extent,
+							 search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add extent into fork: "
+					  "err %d\n",
+					  err);
+				goto finish_change_fork;
+			}
+
+			ssdfs_debug_btree_search_object(search);
+
+			search->request.type = SSDFS_BTREE_SEARCH_ADD_ITEM;
+			err = ssdfs_extents_tree_add_inline_fork(tree, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add fork: err %d\n", err);
+				goto finish_change_fork;
+			}
+		}
+
+		err = ssdfs_extents_tree_add_extent_nolock(tree, blk,
+							   new_extent,
+							   search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add extent: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_change_fork;
+		}
+		break;
+
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		err = ssdfs_btree_find_item(tree->generic_tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_change_fork;
+		}
+
+		err = ssdfs_delete_extent_in_fork(blk, search,
+						  &extent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete extent in fork: err %d\n",
+				  err);
+			goto finish_change_fork;
+		}
+
+		err = ssdfs_shrink_found_extent(old_extent, &extent);
+		if (err == -ENODATA) {
+			/*
+			 * Extent is empty. Do nothing.
+			 */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to shrink extent: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_change_fork;
+		} else {
+			len = le32_to_cpu(old_extent->len);
+			new_blk = blk + len;
+
+			err = ssdfs_add_extent_into_fork(new_blk,
+							 &extent,
+							 search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add extent into fork: "
+					  "err %d\n",
+					  err);
+				goto finish_change_fork;
+			}
+
+			ssdfs_debug_btree_search_object(search);
+
+			err = ssdfs_extents_tree_add_extent_nolock(tree,
+								   new_blk,
+								   &extent,
+								   search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add extent: "
+					  "blk %llu, err %d\n",
+					  new_blk, err);
+				goto finish_change_fork;
+			}
+		}
+
+		err = ssdfs_extents_tree_add_extent_nolock(tree, blk,
+							   new_extent,
+							   search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add extent: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_change_fork;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid extents tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+finish_change_fork:
+	up_write(&tree->lock);
+
+	ssdfs_btree_search_forget_parent_node(search);
+	ssdfs_btree_search_forget_child_node(search);
+
+	ssdfs_debug_extents_btree_object(tree);
+
+	return err;
+}
+
+/*
+ * ssdfs_truncate_extent_in_fork() - truncate the extent in the fork
+ * @blk: logical block number
+ * @new_len: new length of the extent
+ * @search: search object
+ * @fork: truncated fork [out]
+ *
+ * This method tries to truncate the extent in the fork.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - no extents in the fork.
+ * %-ENOSPC     - invalid @new_len of the extent.
+ * %-EFAULT     - extent doesn't exist in the fork.
+ */
+static
+int ssdfs_truncate_extent_in_fork(u64 blk, u32 new_len,
+				  struct ssdfs_btree_search *search,
+				  struct ssdfs_raw_fork *fork)
+{
+	struct ssdfs_raw_fork *cur_fork;
+	struct ssdfs_raw_extent *cur_extent = NULL;
+	u64 start_offset;
+	u64 blks_count;
+	u32 len, len_diff;
+	u64 cur_blk;
+	u64 rest_len;
+	u32 logical_blk;
+	int i, j;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON( !search || !fork);
+
+	SSDFS_DBG("blk %llu, new_len %u, search %p\n",
+		  blk, new_len, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_EMPTY_RESULT:
+		SSDFS_DBG("no fork in search object\n");
+		return -EFAULT;
+
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid search object state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid search buffer state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_size != sizeof(struct ssdfs_raw_fork) ||
+	    search->result.items_in_buffer != 1) {
+		SSDFS_ERR("invalid search buffer state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	memset(fork, 0xFF, sizeof(struct ssdfs_raw_fork));
+
+	cur_fork = &search->raw.fork;
+	start_offset = le64_to_cpu(cur_fork->start_offset);
+	blks_count = le64_to_cpu(cur_fork->blks_count);
+
+	if (start_offset >= U64_MAX || blks_count >= U64_MAX) {
+		SSDFS_ERR("invalid fork state: "
+			  "start_offset %llu, blks_count %llu\n",
+			  start_offset, blks_count);
+		return -ERANGE;
+	}
+
+	if (blks_count == 0) {
+		SSDFS_ERR("empty fork: blks_count %llu\n",
+			  blks_count);
+		return -ENODATA;
+	}
+
+	if (blk >= U64_MAX) {
+		SSDFS_ERR("invalid extent: blk %llu\n",
+			  blk);
+		return -ERANGE;
+	}
+
+	if (start_offset <= blk && blk < (start_offset + blks_count)) {
+		/*
+		 * Expected state
+		 */
+	} else {
+		SSDFS_ERR("extent is out of fork: \n"
+			  "fork (start %llu, blks_count %llu), "
+			  "extent (blk %llu, len %u)\n",
+			  start_offset, blks_count,
+			  blk, new_len);
+		return -EFAULT;
+	}
+
+	cur_blk = le64_to_cpu(cur_fork->start_offset);
+	for (i = 0; i < SSDFS_INLINE_EXTENTS_COUNT; i++) {
+		len = le32_to_cpu(cur_fork->extents[i].len);
+
+		if (len >= U32_MAX || len == 0) {
+			/* empty extent */
+			break;
+		} else if (cur_blk <= blk && blk < (cur_blk + len)) {
+			/* extent is found */
+			cur_extent = &cur_fork->extents[i];
+			break;
+		} else if (blk < cur_blk) {
+			SSDFS_ERR("invalid extent: "
+				  "blk %llu, cur_blk %llu\n",
+				  blk, cur_blk);
+			return -EFAULT;
+		} else {
+			/* it needs to check the next extent */
+			cur_blk += len;
+		}
+	}
+
+	if (!cur_extent) {
+		SSDFS_ERR("fail to find the extent: blk %llu\n",
+			  blk);
+		return -EFAULT;
+	}
+
+	rest_len = blks_count - (blk - start_offset);
+
+	if (new_len > rest_len) {
+		SSDFS_ERR("fail to grow extent's size: "
+			  "rest_len %llu, new_len %u\n",
+			  rest_len, new_len);
+		return -ENOSPC;
+	} else if (new_len == rest_len) {
+		SSDFS_WARN("nothing should be done: "
+			   "rest_len %llu, new_len %u\n",
+			   rest_len, new_len);
+		return 0;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(i >= SSDFS_INLINE_EXTENTS_COUNT);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fork->start_offset = cpu_to_le64(blk);
+	fork->blks_count = cpu_to_le64(0);
+
+	for (j = 0; i < SSDFS_INLINE_EXTENTS_COUNT; i++) {
+		cur_extent = &cur_fork->extents[i];
+		len = le32_to_cpu(cur_extent->len);
+
+		if ((cur_blk + len) < blk) {
+			/* pass on this extent */
+			continue;
+		} else if ((blk + new_len) <= cur_blk) {
+			ssdfs_memcpy(&fork->extents[j],
+				     0, sizeof(struct ssdfs_raw_extent),
+				     cur_extent,
+				     0, sizeof(struct ssdfs_raw_extent),
+				     sizeof(struct ssdfs_raw_extent));
+			le64_add_cpu(&fork->blks_count, len);
+			j++;
+
+			/* clear extent */
+			memset(cur_extent, 0xFF,
+				sizeof(struct ssdfs_raw_extent));
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON((blk - cur_blk) >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			len_diff = len - (u32)(blk - cur_blk);
+
+			if (len_diff <= new_len) {
+				/*
+				 * leave the extent unchanged
+				 */
+			} else {
+				len_diff = (cur_blk + len) - (blk + new_len);
+
+				fork->extents[j].seg_id = cur_extent->seg_id;
+				logical_blk =
+					le32_to_cpu(cur_extent->logical_blk);
+				logical_blk += len - len_diff;
+				fork->extents[j].logical_blk =
+						cpu_to_le32(logical_blk);
+				fork->extents[j].len = cpu_to_le32(len_diff);
+				le64_add_cpu(&fork->blks_count, len_diff);
+				j++;
+
+				/* shrink extent */
+				cur_extent->len = cpu_to_le32(len - len_diff);
+			}
+		}
+
+		cur_blk += len;
+
+		if (cur_blk >= (start_offset + blks_count))
+			break;
+	}
+
+	blks_count -= rest_len - new_len;
+
+	if (blks_count == 0) {
+		cur_fork->blks_count = cpu_to_le64(0);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("empty fork: blks_count %llu\n",
+			  blks_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return -ENODATA;
+	} else
+		cur_fork->blks_count = cpu_to_le64(blks_count);
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_delete_inline_fork() - delete inline fork
+ * @tree: extents tree
+ * @search: search object
+ *
+ * This method tries to delete the inline fork from the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - fork doesn't exist in the tree.
+ * %-ENOENT     - no more forks in the tree.
+ */
+static
+int ssdfs_extents_tree_delete_inline_fork(struct ssdfs_extents_btree_info *tree,
+					  struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_shared_extents_tree *shextree;
+	struct ssdfs_raw_fork *fork;
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
+	size_t inline_forks_size = fork_size * SSDFS_INLINE_FORKS_COUNT;
+	ino_t ino;
+	u64 start_hash;
+	s64 forks_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+	shextree = fsi->shextree;
+
+	if (!shextree) {
+		SSDFS_ERR("shared extents tree is absent\n");
+		return -ERANGE;
+	}
+
+	ino = tree->owner->vfs_inode.i_ino;
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->inline_forks) {
+		SSDFS_ERR("empty inline tree %p\n",
+			  tree->inline_forks);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	if (!search->result.buf) {
+		SSDFS_ERR("empty buffer pointer\n");
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		if (start_hash != le64_to_cpu(search->raw.fork.start_offset)) {
+			SSDFS_ERR("corrupted fork: "
+				  "start_hash %llx, "
+				  "fork (start %llu, blks_count %llu)\n",
+				  start_hash,
+				  le64_to_cpu(search->raw.fork.start_offset),
+				  le64_to_cpu(search->raw.fork.blks_count));
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+		if (start_hash >= le64_to_cpu(search->raw.fork.start_offset)) {
+			SSDFS_ERR("corrupted fork: "
+				  "start_hash %llx, "
+				  "fork (start %llu, blks_count %llu)\n",
+				  start_hash,
+				  le64_to_cpu(search->raw.fork.start_offset),
+				  le64_to_cpu(search->raw.fork.blks_count));
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_WARN("unexpected result state %#x\n",
+			   search->result.state);
+		return -ERANGE;
+	}
+
+	forks_count = atomic64_read(&tree->forks_count);
+	if (forks_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		return -ENOENT;
+	} else if (forks_count > SSDFS_INLINE_FORKS_COUNT) {
+		SSDFS_ERR("invalid forks count %lld\n",
+			  forks_count);
+		return -ERANGE;
+	} else
+		atomic64_dec(&tree->forks_count);
+
+	if (search->result.start_index >= forks_count) {
+		SSDFS_ERR("invalid search result: "
+			  "start_index %u, forks_count %lld\n",
+			  search->result.start_index,
+			  forks_count);
+		return -ENODATA;
+	}
+
+	err = ssdfs_invalidate_inline_tail_forks(tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to invalidate inline tail forks: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (search->result.start_index < (forks_count - 1)) {
+		u16 index = search->result.start_index;
+
+		err = ssdfs_memmove(tree->inline_forks,
+				    (size_t)index * fork_size,
+				    inline_forks_size,
+				    tree->inline_forks,
+				    (size_t)(index + 1) * fork_size,
+				    inline_forks_size,
+				    (forks_count - index) * fork_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move: err %d\n", err);
+			return err;
+		}
+
+		index = forks_count - 1;
+		fork = &tree->inline_forks[index];
+		memset(fork, 0xFF, sizeof(struct ssdfs_raw_fork));
+	}
+
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_DIRTY);
+
+	forks_count = atomic64_read(&tree->forks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("forks_count %lld\n", forks_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (forks_count == 0) {
+		SSDFS_DBG("tree is empty now\n");
+	} else if (forks_count < 0) {
+		SSDFS_WARN("invalid forks_count %lld\n",
+			   forks_count);
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_CORRUPTED);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_delete_fork() - delete generic fork
+ * @tree: extents tree
+ * @search: search object
+ *
+ * This method tries to delete the generic fork from the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - fork doesn't exist in the tree.
+ * %-ENOENT     - no more forks in the tree.
+ */
+static
+int ssdfs_extents_tree_delete_fork(struct ssdfs_extents_btree_info *tree,
+				   struct ssdfs_btree_search *search)
+{
+	u64 start_hash;
+	s64 forks_count;
+	u64 blks_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->generic_tree) {
+		SSDFS_ERR("empty generic tree %p\n",
+			  tree->generic_tree);
+		return -ERANGE;
+	}
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_VALID_ITEM) {
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	if (start_hash != le64_to_cpu(search->raw.fork.start_offset)) {
+		SSDFS_ERR("corrupted fork: "
+			  "start_hash %llx, "
+			  "fork (start %llu, blks_count %llu)\n",
+			  start_hash,
+			  le64_to_cpu(search->raw.fork.start_offset),
+			  le64_to_cpu(search->raw.fork.blks_count));
+		return -ERANGE;
+	}
+
+	forks_count = atomic64_read(&tree->forks_count);
+	if (forks_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		return -ENOENT;
+	}
+
+	if (search->result.start_index >= forks_count) {
+		SSDFS_ERR("invalid search result: "
+			  "start_index %u, forks_count %lld\n",
+			  search->result.start_index,
+			  forks_count);
+		return -ENODATA;
+	}
+
+	blks_count = le64_to_cpu(search->raw.fork.blks_count);
+	if (!(blks_count == 0 || blks_count >= U64_MAX)) {
+		SSDFS_ERR("fork is empty: "
+			  "blks_count %llu\n",
+			  blks_count);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_delete_item(tree->generic_tree,
+				      search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete the fork from the tree: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	forks_count = atomic64_read(&tree->forks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("forks_count %lld\n", forks_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (forks_count == 0) {
+		SSDFS_DBG("tree is empty now\n");
+		return -ENOENT;
+	} else if (forks_count < 0) {
+		SSDFS_WARN("invalid forks_count %lld\n",
+			   forks_count);
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_CORRUPTED);
+		return -ERANGE;
+	}
+
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_DIRTY);
+	return 0;
+}
+
+/*
+ * ssdfs_migrate_generic2inline_tree() - convert generic tree into inline
+ * @tree: extents tree
+ *
+ * This method tries to convert the generic tree into inline one.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - the tree cannot be converted into inline again.
+ */
+static
+int ssdfs_migrate_generic2inline_tree(struct ssdfs_extents_btree_info *tree)
+{
+	struct ssdfs_raw_fork inline_forks[SSDFS_INLINE_FORKS_COUNT];
+	struct ssdfs_btree_search *search;
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
+	s64 forks_count, forks_capacity;
+	u64 start_hash = 0, end_hash = 0;
+	u64 blks_count = 0;
+	int private_flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	forks_count = atomic64_read(&tree->forks_count);
+
+	if (!tree->owner) {
+		SSDFS_ERR("empty owner inode\n");
+		return -ERANGE;
+	}
+
+	private_flags = atomic_read(&tree->owner->private_flags);
+
+	forks_capacity = SSDFS_INLINE_FORKS_COUNT;
+	if (private_flags & SSDFS_INODE_HAS_XATTR_BTREE)
+		forks_capacity--;
+
+	if (private_flags & SSDFS_INODE_HAS_INLINE_EXTENTS) {
+		SSDFS_ERR("the extents tree is not generic\n");
+		return -ERANGE;
+	}
+
+	if (forks_count > forks_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("forks_count %lld > forks_capacity %lld\n",
+			  forks_count, forks_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(tree->inline_forks || !tree->generic_tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree->generic_tree = NULL;
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+	ssdfs_btree_search_init(search);
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_RANGE;
+	search->request.flags = 0;
+	search->request.start.hash = U64_MAX;
+	search->request.end.hash = U64_MAX;
+	search->request.count = 0;
+
+	err = ssdfs_btree_get_head_range(&tree->buffer.tree,
+					 forks_count, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract forks: "
+			  "forks_count %lld, err %d\n",
+			  forks_count, err);
+		goto finish_process_range;
+	} else if (forks_count != search->result.items_in_buffer) {
+		err = -ERANGE;
+		SSDFS_ERR("forks_count %lld != items_in_buffer %u\n",
+			  forks_count,
+			  search->result.items_in_buffer);
+		goto finish_process_range;
+	}
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_VALID_ITEM) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		goto finish_process_range;
+	}
+
+	memset(inline_forks, 0xFF, fork_size * SSDFS_INLINE_FORKS_COUNT);
+
+	if (search->result.buf_size != (fork_size * forks_count) ||
+	    search->result.items_in_buffer != forks_count) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid search result: "
+			  "buf_size %zu, items_in_buffer %u, "
+			  "forks_count %lld\n",
+			  search->result.buf_size,
+			  search->result.items_in_buffer,
+			  forks_count);
+		goto finish_process_range;
+	}
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+		ssdfs_memcpy(inline_forks,
+			     0, fork_size * SSDFS_INLINE_FORKS_COUNT,
+			     &search->raw.fork,
+			     0, fork_size,
+			     fork_size);
+		break;
+
+	case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+		if (!search->result.buf) {
+			err = -ERANGE;
+			SSDFS_ERR("empty buffer\n");
+			goto finish_process_range;
+		}
+
+		err = ssdfs_memcpy(inline_forks,
+				   0, fork_size * SSDFS_INLINE_FORKS_COUNT,
+				   search->result.buf,
+				   0, search->result.buf_size,
+				   fork_size * forks_count);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			goto finish_process_range;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid buffer's state %#x\n",
+			  search->result.buf_state);
+		goto finish_process_range;
+	}
+
+	start_hash = le64_to_cpu(inline_forks[0].start_offset);
+	if (forks_count > 1) {
+		end_hash =
+		    le64_to_cpu(inline_forks[forks_count - 1].start_offset);
+		blks_count =
+		    le64_to_cpu(inline_forks[forks_count - 1].blks_count);
+	} else {
+		end_hash = start_hash;
+		blks_count = le64_to_cpu(inline_forks[0].blks_count);
+	}
+
+	if (blks_count == 0 || blks_count >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid blks_count %llu\n",
+			  blks_count);
+		goto finish_process_range;
+	}
+
+	end_hash += blks_count - 1;
+
+	search->request.type = SSDFS_BTREE_SEARCH_DELETE_RANGE;
+	search->request.flags = SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+				SSDFS_BTREE_SEARCH_HAS_VALID_COUNT |
+				SSDFS_BTREE_SEARCH_NOT_INVALIDATE;
+	search->request.start.hash = start_hash;
+	search->request.end.hash = end_hash;
+	search->request.count = forks_count;
+
+	err = ssdfs_btree_delete_range(&tree->buffer.tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete range: "
+			  "start_hash %llx, end_hash %llx, count %u, "
+			  "err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  search->request.count,
+			  err);
+		goto finish_process_range;
+	}
+
+	if (!is_ssdfs_btree_empty(&tree->buffer.tree)) {
+		err = -ERANGE;
+		SSDFS_WARN("extents tree is not empty\n");
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_CORRUPTED);
+		goto finish_process_range;
+	}
+
+	err = ssdfs_btree_destroy_node_range(&tree->buffer.tree,
+					     0);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to destroy nodes' range: err %d\n",
+			  err);
+		goto finish_process_range;
+	}
+
+finish_process_range:
+	ssdfs_btree_search_free(search);
+
+	if (unlikely(err))
+		return err;
+
+	ssdfs_btree_destroy(&tree->buffer.tree);
+
+	err = ssdfs_memcpy(tree->buffer.forks,
+			   0, fork_size * SSDFS_INLINE_FORKS_COUNT,
+			   inline_forks,
+			   0, fork_size * SSDFS_INLINE_FORKS_COUNT,
+			   fork_size * forks_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		return err;
+	}
+
+	atomic_set(&tree->type, SSDFS_INLINE_FORKS_ARRAY);
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_DIRTY);
+	tree->inline_forks = tree->buffer.forks;
+
+	atomic64_set(&tree->forks_count, forks_count);
+
+	atomic_and(~SSDFS_INODE_HAS_EXTENTS_BTREE,
+		   &tree->owner->private_flags);
+	atomic_or(SSDFS_INODE_HAS_INLINE_EXTENTS,
+		  &tree->owner->private_flags);
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_truncate_extent() - truncate the extent in the tree
+ * @tree: extent tree
+ * @blk: logical block number
+ * @new_len: new length of the extent
+ * @search: search object
+ *
+ * This method tries to truncate the extent in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - extent doesn't exist in the tree.
+ * %-ENOSPC     - invalid @new_len of the extent.
+ * %-EFAULT     - fail to create the hole in the fork.
+ */
+int ssdfs_extents_tree_truncate_extent(struct ssdfs_extents_btree_info *tree,
+					u64 blk, u32 new_len,
+					struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_shared_extents_tree *shextree;
+	struct ssdfs_raw_fork fork;
+	u64 blks_count;
+	ino_t ino;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+
+	SSDFS_DBG("tree %p, search %p, blk %llu, new_len %u\n",
+		  tree, search, blk, new_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+	shextree = fsi->shextree;
+
+	if (!shextree) {
+		SSDFS_ERR("shared extents tree is absent\n");
+		return -ERANGE;
+	}
+
+	ino = tree->owner->vfs_inode.i_ino;
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	if (need_initialize_extent_btree_search(blk, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = blk;
+		search->request.end.hash = blk;
+		search->request.count = 1;
+	}
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		down_write(&tree->lock);
+
+		err = ssdfs_extents_tree_find_inline_fork(tree, blk, search);
+		if (err == -ENODATA) {
+			switch (search->result.state) {
+			case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+				/* hole case -> continue truncation */
+				break;
+
+			case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+				/* inflation case -> nothing has to be done */
+				err = 0;
+				goto finish_truncate_inline_fork;
+
+			default:
+				SSDFS_ERR("fail to find the inline fork: "
+					  "blk %llu, err %d\n",
+					  blk, err);
+				goto finish_truncate_inline_fork;
+			}
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the inline fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_truncate_inline_fork;
+		}
+
+		switch (search->result.state) {
+		case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+			search->request.type =
+				SSDFS_BTREE_SEARCH_INVALIDATE_TAIL;
+			err = ssdfs_extents_tree_delete_inline_fork(tree,
+								   search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to delete fork: err %d\n", err);
+				goto finish_truncate_inline_fork;
+			}
+			break;
+
+		case SSDFS_BTREE_SEARCH_VALID_ITEM:
+			err = ssdfs_truncate_extent_in_fork(blk, new_len,
+							    search, &fork);
+			if (err == -ENODATA) {
+				/*
+				 * The truncating  fork is empty.
+				 */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to change extent in fork: "
+					  "err %d\n",
+					  err);
+				goto finish_truncate_inline_fork;
+			}
+
+			if (err == -ENODATA) {
+				search->request.type =
+					SSDFS_BTREE_SEARCH_INVALIDATE_TAIL;
+				err =
+				    ssdfs_extents_tree_delete_inline_fork(tree,
+									search);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to delete fork: "
+						  "err %d\n", err);
+					goto finish_truncate_inline_fork;
+				}
+			} else {
+				search->request.type =
+					SSDFS_BTREE_SEARCH_INVALIDATE_TAIL;
+				err =
+				    ssdfs_extents_tree_change_inline_fork(tree,
+									search);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to change fork: "
+						  "err %d\n", err);
+					goto finish_truncate_inline_fork;
+				}
+			}
+
+			blks_count = le64_to_cpu(fork.blks_count);
+
+			if (blks_count == 0 || blks_count >= U64_MAX) {
+				/*
+				 * empty fork -> do nothing
+				 */
+			} else {
+				err =
+				    ssdfs_shextree_add_pre_invalid_fork(shextree,
+									ino,
+									&fork);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to pre-invalidate: "
+						  "(start_offset %llu, "
+						  "blks_count %llu), err %d\n",
+						le64_to_cpu(fork.start_offset),
+						le64_to_cpu(fork.blks_count),
+						err);
+					goto finish_truncate_inline_fork;
+				}
+			}
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid result state %#x\n",
+				  search->result.state);
+			goto finish_truncate_inline_fork;
+		}
+
+finish_truncate_inline_fork:
+		up_write(&tree->lock);
+		break;
+
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		down_read(&tree->lock);
+
+		err = ssdfs_btree_find_item(tree->generic_tree, search);
+		if (err == -ENODATA) {
+			switch (search->result.state) {
+			case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+				/* hole case -> continue truncation */
+				break;
+
+			case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+			case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+				if (is_last_leaf_node_found(search)) {
+					/*
+					 * inflation case
+					 * nothing has to be done
+					 */
+					err = 0;
+					goto finish_truncate_generic_fork;
+				} else {
+					/*
+					 * hole case
+					 * continue truncation
+					 */
+				}
+				break;
+
+			default:
+				SSDFS_ERR("fail to find the fork: "
+					  "blk %llu, err %d\n",
+					  blk, err);
+				goto finish_truncate_generic_fork;
+			}
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_truncate_generic_fork;
+		}
+
+		switch (search->result.state) {
+		case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+			search->request.type =
+				SSDFS_BTREE_SEARCH_INVALIDATE_TAIL;
+			err = ssdfs_extents_tree_delete_fork(tree, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to delete fork: err %d\n", err);
+				goto finish_truncate_generic_fork;
+			}
+			break;
+
+		case SSDFS_BTREE_SEARCH_VALID_ITEM:
+			err = ssdfs_truncate_extent_in_fork(blk, new_len,
+							    search, &fork);
+			if (err == -ENODATA) {
+				/*
+				 * The truncating fork is empty.
+				 */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to change extent in fork: "
+					  "err %d\n", err);
+				goto finish_truncate_generic_fork;
+			}
+
+			if (err == -ENODATA) {
+				search->request.type =
+					SSDFS_BTREE_SEARCH_INVALIDATE_TAIL;
+				err = ssdfs_extents_tree_delete_fork(tree,
+								     search);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to delete fork: "
+						  "err %d\n", err);
+					goto finish_truncate_generic_fork;
+				}
+			} else {
+				search->request.type =
+					SSDFS_BTREE_SEARCH_INVALIDATE_TAIL;
+				err = ssdfs_extents_tree_change_fork(tree,
+								     search);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to change fork: "
+						  "err %d\n", err);
+					goto finish_truncate_generic_fork;
+				}
+			}
+
+			blks_count = le64_to_cpu(fork.blks_count);
+
+			if (blks_count == 0 || blks_count >= U64_MAX) {
+				/*
+				 * empty fork -> do nothing
+				 */
+			} else {
+				err =
+				 ssdfs_shextree_add_pre_invalid_fork(shextree,
+								     ino,
+								     &fork);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to pre-invalidate: "
+						  "(start_offset %llu, "
+						  "blks_count %llu), err %d\n",
+						le64_to_cpu(fork.start_offset),
+						le64_to_cpu(fork.blks_count),
+						err);
+					goto finish_truncate_generic_fork;
+				}
+			}
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid result state %#x\n",
+				  search->result.state);
+			goto finish_truncate_generic_fork;
+		}
+
+finish_truncate_generic_fork:
+		up_read(&tree->lock);
+
+		ssdfs_btree_search_forget_parent_node(search);
+		ssdfs_btree_search_forget_child_node(search);
+
+		if (unlikely(err))
+			return err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("forks_count %lld\n",
+			  atomic64_read(&tree->forks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (!err &&
+		    need_migrate_generic2inline_btree(tree->generic_tree, 1)) {
+			down_write(&tree->lock);
+			err = ssdfs_migrate_generic2inline_tree(tree);
+			up_write(&tree->lock);
+
+			if (err == -ENOSPC) {
+				/* continue to use the generic tree */
+				err = 0;
+				SSDFS_DBG("unable to re-create inline tree\n");
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to re-create inline tree: "
+					  "err %d\n",
+					  err);
+			}
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid extents tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+	return err;
+}
+
+static int
+ssdfs_extents_tree_delete_inline_extent(struct ssdfs_extents_btree_info *tree,
+					u64 blk,
+					struct ssdfs_raw_extent *extent,
+					struct ssdfs_btree_search *search)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !extent || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p, blk %llu\n",
+		  tree, search, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	err = ssdfs_extents_tree_find_inline_fork(tree, blk, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find the inline fork: "
+			  "blk %llu, err %d\n",
+			  blk, err);
+		return err;
+	}
+
+	err = ssdfs_delete_extent_in_fork(blk, search, extent);
+	if (err == -ENODATA) {
+		/*
+		 * The fork doesn't contain any extents.
+		 */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to delete extent in fork: err %d\n",
+			  err);
+		return err;
+	}
+
+	if (err == -ENODATA) {
+		search->request.type = SSDFS_BTREE_SEARCH_DELETE_ITEM;
+		err = ssdfs_extents_tree_delete_inline_fork(tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete fork: err %d\n", err);
+			return err;
+		}
+	} else {
+		search->request.type = SSDFS_BTREE_SEARCH_CHANGE_ITEM;
+		err = ssdfs_extents_tree_change_inline_fork(tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change fork: err %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_delete_extent() - delete extent from the tree
+ * @tree: extents tree
+ * @blk: logical block number
+ * @search: search object
+ *
+ * This method tries to delete extent from the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - extent doesn't exist in the tree.
+ * %-EFAULT     - fail to create the hole in the fork.
+ */
+int ssdfs_extents_tree_delete_extent(struct ssdfs_extents_btree_info *tree,
+				     u64 blk,
+				     struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_shared_extents_tree *shextree;
+	struct ssdfs_raw_extent extent;
+	ino_t ino;
+	u32 len;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+
+	SSDFS_DBG("tree %p, search %p, blk %llu\n",
+		  tree, search, blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+	shextree = fsi->shextree;
+
+	if (!shextree) {
+		SSDFS_ERR("shared extents tree is absent\n");
+		return -ERANGE;
+	}
+
+	ino = tree->owner->vfs_inode.i_ino;
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	if (need_initialize_extent_btree_search(blk, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = blk;
+		search->request.end.hash = blk;
+		search->request.count = 1;
+	}
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		down_write(&tree->lock);
+
+		err = ssdfs_extents_tree_delete_inline_extent(tree,
+							      blk,
+							      &extent,
+							      search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete inline extent: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_delete_inline_extent;
+		}
+
+		len = le32_to_cpu(extent.len);
+
+		if (len == 0 || len >= U32_MAX) {
+			/*
+			 * empty extent -> do nothing
+			 */
+		} else {
+			err = ssdfs_shextree_add_pre_invalid_extent(shextree,
+								    ino,
+								    &extent);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add pre-invalid extent "
+					  "(seg_id %llu, blk %u, len %u), "
+					  "err %d\n",
+					  le64_to_cpu(extent.seg_id),
+					  le32_to_cpu(extent.logical_blk),
+					  len, err);
+				goto finish_delete_inline_extent;
+			}
+		}
+
+finish_delete_inline_extent:
+		up_write(&tree->lock);
+		break;
+
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		down_read(&tree->lock);
+
+		err = ssdfs_btree_find_item(tree->generic_tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+			goto finish_delete_generic_extent;
+		}
+
+		err = ssdfs_delete_extent_in_fork(blk, search,
+						  &extent);
+		if (err == -ENODATA) {
+			/*
+			 * The fork doesn't contain any extents.
+			 */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to delete extent in fork: err %d\n",
+				  err);
+			goto finish_delete_generic_extent;
+		}
+
+		if (err == -ENODATA) {
+			search->request.type = SSDFS_BTREE_SEARCH_DELETE_ITEM;
+			err = ssdfs_extents_tree_delete_fork(tree, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to delete fork: err %d\n", err);
+				goto finish_delete_generic_extent;
+			}
+		} else {
+			search->request.type = SSDFS_BTREE_SEARCH_CHANGE_ITEM;
+			err = ssdfs_extents_tree_change_fork(tree, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change fork: err %d\n", err);
+				goto finish_delete_generic_extent;
+			}
+		}
+
+finish_delete_generic_extent:
+		up_read(&tree->lock);
+
+		ssdfs_btree_search_forget_parent_node(search);
+		ssdfs_btree_search_forget_child_node(search);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("forks_count %lld\n",
+			  atomic64_read(&tree->forks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (!err &&
+		    need_migrate_generic2inline_btree(tree->generic_tree, 1)) {
+			down_write(&tree->lock);
+			err = ssdfs_migrate_generic2inline_tree(tree);
+			up_write(&tree->lock);
+
+			if (err == -ENOSPC) {
+				/* continue to use the generic tree */
+				err = 0;
+				SSDFS_DBG("unable to re-create inline tree\n");
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to re-create inline tree: "
+					  "err %d\n",
+					  err);
+			}
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid extents tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_delete_all_inline_forks() - delete all inline forks
+ * @tree: extents tree
+ *
+ * This method tries to delete all inline forks in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - empty tree.
+ */
+static
+int ssdfs_delete_all_inline_forks(struct ssdfs_extents_btree_info *tree)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_shared_extents_tree *shextree;
+	struct ssdfs_raw_fork *fork;
+	struct ssdfs_raw_extent *extent;
+	u64 forks_count;
+	ino_t ino;
+	int i, j;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+	shextree = fsi->shextree;
+
+	if (!shextree) {
+		SSDFS_ERR("shared extents tree is absent\n");
+		return -ERANGE;
+	}
+
+	ino = tree->owner->vfs_inode.i_ino;
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->inline_forks) {
+		SSDFS_ERR("empty inline forks %p\n",
+			  tree->inline_forks);
+		return -ERANGE;
+	}
+
+	forks_count = atomic64_read(&tree->forks_count);
+	if (forks_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		return -ENOENT;
+	} else if (forks_count > SSDFS_INLINE_FORKS_COUNT) {
+		atomic_set(&tree->state,
+			   SSDFS_EXTENTS_BTREE_CORRUPTED);
+		SSDFS_ERR("extents tree is corupted: "
+			  "forks_count %llu",
+			  forks_count);
+		return -ERANGE;
+	}
+
+	for (i = 0; i < forks_count; i++) {
+		u64 blks_count;
+		u64 calculated = 0;
+
+		fork = &tree->inline_forks[i];
+		blks_count = le64_to_cpu(fork->blks_count);
+
+		if (blks_count == 0 || blks_count >= U64_MAX) {
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_ERR("corrupted fork: blks_count %llu\n",
+				  blks_count);
+			return -ERANGE;
+		}
+
+		for (j = SSDFS_INLINE_EXTENTS_COUNT - 1; j >= 0; j--) {
+			u32 len;
+
+			extent = &fork->extents[j];
+			len = le32_to_cpu(extent->len);
+
+			if (len == 0 || len >= U32_MAX)
+				continue;
+
+			if ((calculated + len) > blks_count) {
+				atomic_set(&tree->state,
+					   SSDFS_EXTENTS_BTREE_CORRUPTED);
+				SSDFS_ERR("corrupted extent: "
+					  "calculated %llu, len %u, "
+					  "blks %llu\n",
+					  calculated, len, blks_count);
+				return -ERANGE;
+			}
+
+			err = ssdfs_shextree_add_pre_invalid_extent(shextree,
+								    ino,
+								    extent);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add pre-invalid extent "
+					  "(seg_id %llu, blk %u, len %u), "
+					  "err %d\n",
+					  le64_to_cpu(extent->seg_id),
+					  le32_to_cpu(extent->logical_blk),
+					  len, err);
+				return err;
+			}
+		}
+
+		if (calculated != blks_count) {
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_ERR("calculated %llu != blks_count %llu\n",
+				  calculated, blks_count);
+			return -ERANGE;
+		}
+	}
+
+	memset(tree->inline_forks, 0xFF,
+		sizeof(struct ssdfs_raw_fork) * SSDFS_INLINE_FORKS_COUNT);
+
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_DIRTY);
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_delete_all() - delete all forks in the tree
+ * @tree: extents tree
+ *
+ * This method tries to delete all forks in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_extents_tree_delete_all(struct ssdfs_extents_btree_info *tree)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		down_write(&tree->lock);
+		err = ssdfs_delete_all_inline_forks(tree);
+		if (!err)
+			atomic64_set(&tree->forks_count, 0);
+		up_write(&tree->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("forks_count %lld\n",
+			  atomic64_read(&tree->forks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete all inline forks: "
+				  "err %d\n",
+				  err);
+		}
+		break;
+
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		down_write(&tree->lock);
+		err = ssdfs_btree_delete_all(tree->generic_tree);
+		if (!err) {
+			atomic64_set(&tree->forks_count, 0);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("forks_count %lld\n",
+				  atomic64_read(&tree->forks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		up_write(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete the all forks: "
+				  "err %d\n",
+				  err);
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid extents tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+	return err;
+}
-- 
2.34.1


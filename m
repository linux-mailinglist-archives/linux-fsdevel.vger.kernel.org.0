Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6846A2668
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBYBT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBYBTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:10 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2F03AB6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:49 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s41so7410oiw.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ni2YGbY/F+FnvC9dmCps3fVIRcw6WcCHKY2oBihVXWU=;
        b=5VKcCsYEssyXdDGC1nzC55cMPgiMkpBi4n0RrJ6/SsRKo8GWoABlB89YvQ9Lz2n60p
         MEITYOfi73BRKN1rexLv4OiIUmSH5xv1XAgjzWbSVAsZsMz7okuI7Sn9Tdg+JRCRt1V3
         kmfwnWCdclFhDhNKB1BFKwngvooJ9tKRfVyv/d8fiuFuyIospTAvSaV/Z9q5CrdOrexe
         hpJdcNEQMiyQNKXJ1Gg4Er/ja6nJRGS0tlHEJs9V43QWlHhEk14aNMAoJ0vdMyyL/DhB
         kQME4r46kuW4ZqcMaw2TdGbFVV4px5/XvGdkU7VDjULWAmDJ6gt3IYB0lp5MsJQ0IA3q
         M5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ni2YGbY/F+FnvC9dmCps3fVIRcw6WcCHKY2oBihVXWU=;
        b=CcKsfgl+uA5AWSDL9wzwEnj3U4xsfR/5Q2pMwc1fbI7RbmsITg31ian2SyjfUD78ij
         JCcihpF01Uj3DbygpG9x/71WPaBpBW/dIjF8o/24HBzFatJP9+1Z8xck82XRqMsP9EN0
         X8DbKsX2UO7+dBRsIlVf7wfJd5ZHwPK+hjZr+CJLQlxPHKGPt4V7wwzkyisDBWd9W0a+
         fpSPcBaCUYtqj6ss59qzu7z09qXm8DJItPM7/BG2N+V2vET0mA/l1wqPofB6FWtZSCpo
         q7w4iLncLuZFGPYV5Syvox9hIaC1hAemXf+mjczgaquswkxdHNNK4B+psZ74JqvCT0lG
         yEYQ==
X-Gm-Message-State: AO0yUKWhAzHYOjIv6AfSPlsbXxW1fzL266ni/H3wGzSpd5HFyIQJQBiY
        LtTiS7Ung2CK5LeVN1OQQlFx6ZJdv9ot72GW
X-Google-Smtp-Source: AK7set8rAHzFpHaRoFpUU6sLkr+ym8sLtrjpHlveaM/ZVDVmkHIsx61hWpF0Z9y4hrZ5nQ9uelS6SQ==
X-Received: by 2002:a05:6808:1a1b:b0:37a:2bf0:502d with SMTP id bk27-20020a0568081a1b00b0037a2bf0502dmr871001oib.27.1677287868298;
        Fri, 24 Feb 2023 17:17:48 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:47 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 63/76] ssdfs: dentries b-tree specialized operations
Date:   Fri, 24 Feb 2023 17:09:14 -0800
Message-Id: <20230225010927.813929-64-slava@dubeyko.com>
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

Dentries b-tree implements API:
(1) create - create dentries b-tree
(2) destroy - destroy dentries b-tree
(3) flush - flush dirty dentries b-tree
(4) find - find dentry for a name in b-tree
(5) add - add dentry object into b-tree
(6) change - change/update dentry object in b-tree
(7) delete - delete dentry object from b-tree
(8) delete_all - delete all dentries from b-tree

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/dentries_tree.c | 3369 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 3369 insertions(+)

diff --git a/fs/ssdfs/dentries_tree.c b/fs/ssdfs/dentries_tree.c
index 8c2ce87d1077..9b4115b6bffa 100644
--- a/fs/ssdfs/dentries_tree.c
+++ b/fs/ssdfs/dentries_tree.c
@@ -3011,3 +3011,3372 @@ int ssdfs_dentries_tree_change(struct ssdfs_dentries_btree_info *tree,
 
 	return err;
 }
+
+/*
+ * ssdfs_dentries_tree_delete_inline_dentry() - delete inline dentry
+ * @tree: dentries tree
+ * @search: search object
+ *
+ * This method tries to delete the inline dentry from the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - dentry doesn't exist in the tree.
+ * %-ENOENT     - no more dentries in the tree.
+ */
+static int
+ssdfs_dentries_tree_delete_inline_dentry(struct ssdfs_dentries_btree_info *tree,
+					 struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_dentry *cur;
+	struct ssdfs_dir_entry *dentry1;
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	u64 hash1, hash2;
+	u64 ino1, ino2;
+	s64 dentries_count;
+	u16 index;
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
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->inline_dentries) {
+		SSDFS_ERR("empty inline tree %p\n",
+			  tree->inline_dentries);
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
+	hash1 = search->request.start.hash;
+	ino1 = search->request.start.ino;
+
+	cur = &search->raw.dentry;
+	hash2 = le64_to_cpu(cur->header.hash_code);
+	ino2 = le64_to_cpu(cur->header.ino);
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		if (hash1 != hash2 || ino1 != ino2) {
+			SSDFS_ERR("hash1 %llx, hash2 %llx, "
+				  "ino1 %llu, ino2 %llu\n",
+				  hash1, hash2, ino1, ino2);
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
+	dentries_count = atomic64_read(&tree->dentries_count);
+	if (dentries_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		return -ENOENT;
+	} else if (dentries_count > SSDFS_INLINE_DENTRIES_COUNT) {
+		SSDFS_ERR("invalid dentries count %llu\n",
+			  dentries_count);
+		return -ERANGE;
+	}
+
+	if (search->result.start_index >= dentries_count) {
+		SSDFS_ERR("invalid search result: "
+			  "start_index %u, dentries_count %lld\n",
+			  search->result.start_index,
+			  dentries_count);
+		return -ENODATA;
+	}
+
+	index = search->result.start_index;
+
+	if ((index + 1) < dentries_count) {
+		err = ssdfs_memmove(tree->inline_dentries,
+				    index * dentry_size,
+				    ssdfs_inline_dentries_size(),
+				    tree->inline_dentries,
+				    (index + 1) * dentry_size,
+				    ssdfs_inline_dentries_size(),
+				    (dentries_count - index) * dentry_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move: err %d\n", err);
+			return err;
+		}
+	}
+
+	index = (u16)(dentries_count - 1);
+	dentry1 = &tree->inline_dentries[index];
+	memset(dentry1, 0xFF, sizeof(struct ssdfs_dir_entry));
+
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_DIRTY);
+
+	dentries_count = atomic64_dec_return(&tree->dentries_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("dentries_count %llu\n",
+		  atomic64_read(&tree->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (dentries_count == 0) {
+		SSDFS_DBG("tree is empty now\n");
+	} else if (dentries_count < 0) {
+		SSDFS_WARN("invalid dentries_count %lld\n",
+			   dentries_count);
+		atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_CORRUPTED);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_delete_dentry() - delete generic dentry
+ * @tree: dentries tree
+ * @search: search object
+ *
+ * This method tries to delete the generic dentry from the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - dentry doesn't exist in the tree.
+ * %-ENOENT     - no more dentries in the tree.
+ */
+static
+int ssdfs_dentries_tree_delete_dentry(struct ssdfs_dentries_btree_info *tree,
+				      struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_dentry *cur;
+	u64 hash1, hash2;
+	u64 ino1, ino2;
+	s64 dentries_count;
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
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
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
+	hash1 = search->request.start.hash;
+	ino1 = search->request.start.ino;
+
+	cur = &search->raw.dentry;
+	hash2 = le64_to_cpu(cur->header.hash_code);
+	ino2 = le64_to_cpu(cur->header.ino);
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		if (hash1 != hash2 || ino1 != ino2) {
+			SSDFS_ERR("hash1 %llx, hash2 %llx, "
+				  "ino1 %llu, ino2 %llu\n",
+				  hash1, hash2, ino1, ino2);
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
+	dentries_count = atomic64_read(&tree->dentries_count);
+	if (dentries_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		return -ENOENT;
+	}
+
+	if (search->result.start_index >= dentries_count) {
+		SSDFS_ERR("invalid search result: "
+			  "start_index %u, dentries_count %lld\n",
+			  search->result.start_index,
+			  dentries_count);
+		return -ENODATA;
+	}
+
+	err = ssdfs_btree_delete_item(tree->generic_tree,
+				      search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete the dentry from the tree: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_DIRTY);
+
+	err = ssdfs_btree_synchronize_root_node(tree->generic_tree,
+						tree->root);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to synchronize the root node: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	dentries_count = atomic64_read(&tree->dentries_count);
+	if (dentries_count == 0) {
+		SSDFS_DBG("tree is empty now\n");
+		return -ENOENT;
+	} else if (dentries_count < 0) {
+		SSDFS_WARN("invalid dentries_count %lld\n",
+			   dentries_count);
+		atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_CORRUPTED);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_remove_generic_items() - delete generic items
+ * @tree: dentries tree
+ * @count: requested number of items
+ * @search: search object
+ *
+ * This method tries to extract the head range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_dentries_tree_get_head_range(struct ssdfs_dentries_btree_info *tree,
+					s64 count,
+					struct ssdfs_btree_search *search)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p, count %lld\n",
+		  tree, search, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_btree_search_init(search);
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_RANGE;
+	search->request.flags = 0;
+	search->request.start.hash = U64_MAX;
+	search->request.start.ino = U64_MAX;
+	search->request.end.hash = U64_MAX;
+	search->request.end.ino = U64_MAX;
+	search->request.count = 0;
+
+	err = ssdfs_btree_get_head_range(&tree->buffer.tree,
+					 count, search);
+	if (err == -EAGAIN) {
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("need to repeat extraction: "
+			  "count %lld, search->result.count %u\n",
+			  count, search->result.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to extract dentries: "
+			  "count %lld, err %d\n",
+			  count, err);
+		return err;
+	}
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_VALID_ITEM) {
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_remove_generic_items() - delete generic items
+ * @tree: dentries tree
+ * @count: requested number of items
+ * @start_ino: starting inode ID
+ * @start_hash: starting hash
+ * @end_ino: ending inode ID
+ * @end_hash: ending hash
+ * @search: search object
+ *
+ * This method tries to delete generic items.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - tree is not empty.
+ */
+static int
+ssdfs_dentries_tree_remove_generic_items(struct ssdfs_dentries_btree_info *tree,
+					 s64 count,
+					 u64 start_ino, u64 start_hash,
+					 u64 end_ino, u64 end_hash,
+					 struct ssdfs_btree_search *search)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p, count %lld, "
+		  "start_ino %llu, start_hash %llx, "
+		  "end_ino %llu, end_hash %llx\n",
+		  tree, search, count,
+		  start_ino, start_hash,
+		  end_ino, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->request.type = SSDFS_BTREE_SEARCH_DELETE_RANGE;
+	search->request.flags = SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+				SSDFS_BTREE_SEARCH_HAS_VALID_COUNT |
+				SSDFS_BTREE_SEARCH_HAS_VALID_INO;
+	search->request.start.hash = start_hash;
+	search->request.start.ino = start_ino;
+	search->request.end.hash = end_hash;
+	search->request.end.ino = end_ino;
+	search->request.count = count;
+
+	err = ssdfs_btree_delete_range(&tree->buffer.tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete range: "
+			  "start (hash %llx, ino %llu), "
+			  "end (hash %llx, ino %llu), "
+			  "count %u, err %d\n",
+			  search->request.start.hash,
+			  search->request.start.ino,
+			  search->request.end.hash,
+			  search->request.end.ino,
+			  search->request.count,
+			  err);
+		return err;
+	}
+
+	if (!is_ssdfs_btree_empty(&tree->buffer.tree)) {
+		SSDFS_DBG("dentries tree is not empty\n");
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_migrate_generic2inline_tree() - convert generic tree into inline
+ * @tree: dentries tree
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
+int ssdfs_migrate_generic2inline_tree(struct ssdfs_dentries_btree_info *tree)
+{
+	struct ssdfs_dir_entry dentries[SSDFS_INLINE_DENTRIES_COUNT];
+	struct ssdfs_dir_entry *cur;
+	struct ssdfs_btree_search *search;
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	s64 dentries_count, dentries_capacity;
+	s64 count;
+	u64 start_ino;
+	u64 start_hash;
+	u64 end_ino;
+	u64 end_hash;
+	s64 copied = 0;
+	s64 start_index, end_index;
+	int private_flags;
+	s64 i;
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
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->owner) {
+		SSDFS_ERR("empty owner inode\n");
+		return -ERANGE;
+	}
+
+	dentries_count = atomic64_read(&tree->dentries_count);
+	private_flags = atomic_read(&tree->owner->private_flags);
+
+	dentries_capacity = SSDFS_INLINE_DENTRIES_COUNT;
+	if (private_flags & SSDFS_INODE_HAS_XATTR_BTREE)
+		dentries_capacity -= SSDFS_INLINE_DENTRIES_PER_AREA;
+
+	if (private_flags & SSDFS_INODE_HAS_INLINE_DENTRIES) {
+		SSDFS_ERR("the dentries tree is not generic\n");
+		return -ERANGE;
+	}
+
+	if (dentries_count > dentries_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("dentries_count %lld > dentries_capacity %lld\n",
+			  dentries_count, dentries_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(tree->inline_dentries || !tree->generic_tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(dentries, 0xFF, ssdfs_inline_dentries_size());
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+try_extract_range:
+	if (copied >= dentries_count) {
+		err = -ERANGE;
+		SSDFS_ERR("copied %lld >= dentries_count %lld\n",
+			  copied, dentries_count);
+		goto finish_process_range;
+	}
+
+	count = dentries_count - copied;
+
+	err = ssdfs_dentries_tree_get_head_range(tree, count, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract dentries: "
+			  "dentries_count %lld, err %d\n",
+			  dentries_count, err);
+		goto finish_process_range;
+	}
+
+	if (search->result.count == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid search->result.count %u\n",
+			  search->result.count);
+		goto finish_process_range;
+	}
+
+	if ((copied + search->result.count) > SSDFS_INLINE_DENTRIES_COUNT) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid items count: "
+			  "copied %lld, count %u, capacity %u\n",
+			  copied, search->result.count,
+			  SSDFS_INLINE_DENTRIES_COUNT);
+		goto finish_process_range;
+	}
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+		err = ssdfs_memcpy(dentries,
+				   copied * dentry_size,
+				   ssdfs_inline_dentries_size(),
+				   &search->raw.dentry.header,
+				   0, dentry_size,
+				   dentry_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			goto finish_process_range;
+		}
+		break;
+
+	case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+		if (!search->result.buf) {
+			err = -ERANGE;
+			SSDFS_ERR("empty buffer\n");
+			goto finish_process_range;
+		}
+
+		err = ssdfs_memcpy(dentries,
+				   copied * dentry_size,
+				   ssdfs_inline_dentries_size(),
+				   search->result.buf,
+				   0, search->result.buf_size,
+				   (u64)dentry_size * search->result.count);
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
+	start_index = copied;
+	end_index = copied + search->result.count - 1;
+
+	start_hash = le64_to_cpu(dentries[start_index].hash_code);
+	start_ino = le64_to_cpu(dentries[start_index].ino);
+	end_hash = le64_to_cpu(dentries[end_index].hash_code);
+	end_ino = le64_to_cpu(dentries[end_index].ino);
+
+	count = search->result.count;
+	copied += count;
+
+	err = ssdfs_dentries_tree_remove_generic_items(tree, count,
+							start_ino,
+							start_hash,
+							end_ino,
+							end_hash,
+							search);
+	if (err == -EAGAIN) {
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("need to extract more: "
+			  "copied %lld, dentries_count %lld\n",
+			  copied, dentries_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto try_extract_range;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to remove generic items: "
+			  "start (ino %llu, hash %llx), "
+			  "end (ino %llu, hash %llx), "
+			  "count %lld, err %d\n",
+			  start_ino, start_hash,
+			  end_ino, end_hash,
+			  count, err);
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
+	for (i = 0; i < dentries_count; i++) {
+		cur = &dentries[i];
+
+		cur->dentry_type = SSDFS_INLINE_DENTRY;
+	}
+
+	ssdfs_memcpy(tree->buffer.dentries,
+		     0, ssdfs_inline_dentries_size(),
+		     dentries,
+		     0, ssdfs_inline_dentries_size(),
+		     dentry_size * dentries_count);
+
+	atomic_set(&tree->type, SSDFS_INLINE_DENTRIES_ARRAY);
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_DIRTY);
+	tree->inline_dentries = tree->buffer.dentries;
+	tree->generic_tree = NULL;
+
+	atomic64_set(&tree->dentries_count, dentries_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("dentries_count %llu\n",
+		  atomic64_read(&tree->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	atomic_and(~SSDFS_INODE_HAS_DENTRIES_BTREE,
+		   &tree->owner->private_flags);
+	atomic_or(SSDFS_INODE_HAS_INLINE_DENTRIES,
+		  &tree->owner->private_flags);
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_delete() - delete dentry from the tree
+ * @tree: dentries tree
+ * @name_hash: hash of the name
+ * @ino: inode ID
+ * @search: search object
+ *
+ * This method tries to delete dentry from the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - dentry doesn't exist in the tree.
+ */
+int ssdfs_dentries_tree_delete(struct ssdfs_dentries_btree_info *tree,
+				u64 name_hash, ino_t ino,
+				struct ssdfs_btree_search *search)
+{
+	int threshold = SSDFS_INLINE_DENTRIES_PER_AREA;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, search %p, name_hash %llx\n",
+		  tree, search, name_hash);
+#else
+	SSDFS_DBG("tree %p, search %p, name_hash %llx\n",
+		  tree, search, name_hash);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	if (need_initialize_dentries_btree_search(name_hash, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT |
+			SSDFS_BTREE_SEARCH_HAS_VALID_INO;
+		search->request.start.hash = name_hash;
+		search->request.start.name = NULL;
+		search->request.start.name_len = U32_MAX;
+		search->request.start.ino = ino;
+		search->request.end.hash = name_hash;
+		search->request.end.name = NULL;
+		search->request.end.name_len = U32_MAX;
+		search->request.end.ino = ino;
+		search->request.count = 1;
+	}
+
+	ssdfs_debug_dentries_btree_object(tree);
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		down_write(&tree->lock);
+
+		err = ssdfs_dentries_tree_find_inline_dentry(tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the inline dentry: "
+				  "name_hash %llx, err %d\n",
+				  name_hash, err);
+			goto finish_delete_inline_dentry;
+		}
+
+		search->request.type = SSDFS_BTREE_SEARCH_DELETE_ITEM;
+
+		err = ssdfs_dentries_tree_delete_inline_dentry(tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete dentry: "
+				  "name_hash %llx, err %d\n",
+				  name_hash, err);
+			goto finish_delete_inline_dentry;
+		}
+
+finish_delete_inline_dentry:
+		up_write(&tree->lock);
+		break;
+
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		down_read(&tree->lock);
+
+		err = ssdfs_btree_find_item(tree->generic_tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the dentry: "
+				  "name_hash %llx, err %d\n",
+				  name_hash, err);
+			goto finish_delete_generic_dentry;
+		}
+
+		search->request.type = SSDFS_BTREE_SEARCH_DELETE_ITEM;
+
+		err = ssdfs_dentries_tree_delete_dentry(tree, search);
+
+		ssdfs_btree_search_forget_parent_node(search);
+		ssdfs_btree_search_forget_child_node(search);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete dentry: "
+				  "name_hash %llx, err %d\n",
+				  name_hash, err);
+			goto finish_delete_generic_dentry;
+		}
+
+finish_delete_generic_dentry:
+		up_read(&tree->lock);
+
+		if (!err &&
+		    need_migrate_generic2inline_btree(tree->generic_tree,
+							threshold)) {
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
+		SSDFS_ERR("invalid dentries tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_dentries_btree_object(tree);
+
+	return err;
+}
+
+/*
+ * ssdfs_delete_all_inline_dentries() - delete all inline dentries
+ * @tree: dentries tree
+ *
+ * This method tries to delete all inline dentries in the tree.
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
+int ssdfs_delete_all_inline_dentries(struct ssdfs_dentries_btree_info *tree)
+{
+	s64 dentries_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->inline_dentries) {
+		SSDFS_ERR("empty inline dentries %p\n",
+			  tree->inline_dentries);
+		return -ERANGE;
+	}
+
+	dentries_count = atomic64_read(&tree->dentries_count);
+	if (dentries_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		return -ENOENT;
+	} else if (dentries_count > SSDFS_INLINE_DENTRIES_COUNT) {
+		atomic_set(&tree->state,
+			   SSDFS_DENTRIES_BTREE_CORRUPTED);
+		SSDFS_ERR("dentries tree is corupted: "
+			  "dentries_count %lld",
+			  dentries_count);
+		return -ERANGE;
+	}
+
+	memset(tree->inline_dentries, 0xFF,
+		sizeof(struct ssdfs_dir_entry) * SSDFS_INLINE_DENTRIES_COUNT);
+
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_DIRTY);
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_delete_all() - delete all dentries in the tree
+ * @tree: dentries tree
+ *
+ * This method tries to delete all dentries in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_dentries_tree_delete_all(struct ssdfs_dentries_btree_info *tree)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p\n", tree);
+#else
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		down_write(&tree->lock);
+		err = ssdfs_delete_all_inline_dentries(tree);
+		if (!err)
+			atomic64_set(&tree->dentries_count, 0);
+		up_write(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete all inline dentries: "
+				  "err %d\n",
+				  err);
+		}
+		break;
+
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		down_write(&tree->lock);
+		err = ssdfs_btree_delete_all(tree->generic_tree);
+		if (!err) {
+			atomic64_set(&tree->dentries_count, 0);
+		}
+		up_write(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete the all dentries: "
+				  "err %d\n",
+				  err);
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid dentries tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("dentries_count %llu\n",
+		  atomic64_read(&tree->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_tree_extract_inline_range() - extract inline range
+ * @tree: dentries tree
+ * @start_index: start item index
+ * @count: requested count of items
+ * @search: search object
+ *
+ * This method tries to extract a range of items from the inline tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENOENT     - unable to extract any items.
+ */
+static int
+ssdfs_dentries_tree_extract_inline_range(struct ssdfs_dentries_btree_info *tree,
+					 u16 start_index, u16 count,
+					 struct ssdfs_btree_search *search)
+{
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	u64 dentries_count;
+	size_t buf_size;
+	u16 i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+	BUG_ON(atomic_read(&tree->type) != SSDFS_INLINE_DENTRIES_ARRAY);
+	BUG_ON(!tree->inline_dentries);
+
+	SSDFS_DBG("tree %p, start_index %u, count %u, search %p\n",
+		  tree, start_index, count, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->result.count = 0;
+
+	dentries_count = atomic64_read(&tree->dentries_count);
+	if (dentries_count == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("dentries_count %llu\n",
+			  dentries_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	} else if (dentries_count > SSDFS_INLINE_DENTRIES_COUNT) {
+		SSDFS_ERR("unexpected dentries_count %llu\n",
+			  dentries_count);
+		return -ERANGE;
+	}
+
+	if (start_index >= dentries_count) {
+		SSDFS_ERR("start_index %u >= dentries_count %llu\n",
+			  start_index, dentries_count);
+		return -ERANGE;
+	}
+
+	count = min_t(u16, count, (u16)(dentries_count - start_index));
+	buf_size = dentry_size * count;
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE:
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+		if (count == 1) {
+			search->result.buf = &search->raw.dentry;
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+			search->result.buf_size = buf_size;
+			search->result.items_in_buffer = 0;
+		} else {
+			err = ssdfs_btree_search_alloc_result_buf(search,
+								  buf_size);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to allocate buffer\n");
+				return err;
+			}
+		}
+		break;
+
+	case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+		if (count == 1) {
+			ssdfs_btree_search_free_result_buf(search);
+
+			search->result.buf = &search->raw.dentry;
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+			search->result.buf_size = buf_size;
+			search->result.items_in_buffer = 0;
+		} else {
+			search->result.buf = krealloc(search->result.buf,
+						      buf_size, GFP_KERNEL);
+			if (!search->result.buf) {
+				SSDFS_ERR("fail to allocate buffer\n");
+				return -ENOMEM;
+			}
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER;
+			search->result.buf_size = buf_size;
+			search->result.items_in_buffer = 0;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	for (i = start_index; i < (start_index + count); i++) {
+		err = ssdfs_memcpy(search->result.buf,
+				   i * dentry_size, search->result.buf_size,
+				   tree->inline_dentries,
+				   i * dentry_size,
+				   ssdfs_inline_dentries_size(),
+				   dentry_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			return err;
+		}
+
+		search->result.items_in_buffer++;
+		search->result.count++;
+	}
+
+	search->result.state = SSDFS_BTREE_SEARCH_VALID_ITEM;
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_extract_range() - extract range of items
+ * @tree: dentries tree
+ * @start_index: start item index in the node
+ * @count: requested count of items
+ * @search: search object
+ *
+ * This method tries to extract a range of items from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENOENT     - unable to extract any items.
+ */
+int ssdfs_dentries_tree_extract_range(struct ssdfs_dentries_btree_info *tree,
+				      u16 start_index, u16 count,
+				      struct ssdfs_btree_search *search)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, start_index %u, count %u, search %p\n",
+		  tree, start_index, count, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		down_read(&tree->lock);
+		err = ssdfs_dentries_tree_extract_inline_range(tree,
+								start_index,
+								count,
+								search);
+		up_read(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the inline range: "
+				  "start_index %u, count %u, err %d\n",
+				  start_index, count, err);
+		}
+		break;
+
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		down_read(&tree->lock);
+		err = ssdfs_btree_extract_range(tree->generic_tree,
+						start_index, count,
+						search);
+		up_read(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the range: "
+				  "start_index %u, count %u, err %d\n",
+				  start_index, count, err);
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid dentries tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+	return err;
+}
+
+/******************************************************************************
+ *             SPECIALIZED DENTRIES BTREE DESCRIPTOR OPERATIONS               *
+ ******************************************************************************/
+
+/*
+ * ssdfs_dentries_btree_desc_init() - specialized btree descriptor init
+ * @fsi: pointer on shared file system object
+ * @tree: pointer on dentries btree object
+ */
+static
+int ssdfs_dentries_btree_desc_init(struct ssdfs_fs_info *fsi,
+				   struct ssdfs_btree *tree)
+{
+	struct ssdfs_dentries_btree_info *tree_info = NULL;
+	struct ssdfs_btree_descriptor *desc;
+	u32 erasesize;
+	u32 node_size;
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	u16 item_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !tree);
+
+	SSDFS_DBG("fsi %p, tree %p\n",
+		  fsi, tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_info = container_of(tree,
+				 struct ssdfs_dentries_btree_info,
+				 buffer.tree);
+	desc = &tree_info->desc.desc;
+	erasesize = fsi->erasesize;
+
+	if (le32_to_cpu(desc->magic) != SSDFS_DENTRIES_BTREE_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid magic %#x\n",
+			  le32_to_cpu(desc->magic));
+		goto finish_btree_desc_init;
+	}
+
+	/* TODO: check flags */
+
+	if (desc->type != SSDFS_DENTRIES_BTREE) {
+		err = -EIO;
+		SSDFS_ERR("invalid btree type %#x\n",
+			  desc->type);
+		goto finish_btree_desc_init;
+	}
+
+	node_size = 1 << desc->log_node_size;
+	if (node_size < SSDFS_4KB || node_size > erasesize) {
+		err = -EIO;
+		SSDFS_ERR("invalid node size: "
+			  "log_node_size %u, node_size %u, erasesize %u\n",
+			  desc->log_node_size,
+			  node_size, erasesize);
+		goto finish_btree_desc_init;
+	}
+
+	item_size = le16_to_cpu(desc->item_size);
+
+	if (item_size != dentry_size) {
+		err = -EIO;
+		SSDFS_ERR("invalid item size %u\n",
+			  item_size);
+		goto finish_btree_desc_init;
+	}
+
+	if (le16_to_cpu(desc->index_area_min_size) < (2 * dentry_size)) {
+		err = -EIO;
+		SSDFS_ERR("invalid index_area_min_size %u\n",
+			  le16_to_cpu(desc->index_area_min_size));
+		goto finish_btree_desc_init;
+	}
+
+	err = ssdfs_btree_desc_init(fsi, tree, desc, (u8)item_size, item_size);
+
+finish_btree_desc_init:
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init btree descriptor: err %d\n",
+			  err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_btree_desc_flush() - specialized btree's descriptor flush
+ * @tree: pointer on btree object
+ */
+static
+int ssdfs_dentries_btree_desc_flush(struct ssdfs_btree *tree)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_dentries_btree_info *tree_info = NULL;
+	struct ssdfs_btree_descriptor desc;
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	u32 erasesize;
+	u32 node_size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi);
+
+	SSDFS_DBG("owner_ino %llu, type %#x, state %#x\n",
+		  tree->owner_ino, tree->type,
+		  atomic_read(&tree->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+
+	if (tree->type != SSDFS_DENTRIES_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_dentries_btree_info,
+					 buffer.tree);
+	}
+
+	memset(&desc, 0xFF, sizeof(struct ssdfs_btree_descriptor));
+
+	desc.magic = cpu_to_le32(SSDFS_DENTRIES_BTREE_MAGIC);
+	desc.item_size = cpu_to_le16(dentry_size);
+
+	err = ssdfs_btree_desc_flush(tree, &desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("invalid btree descriptor: err %d\n",
+			  err);
+		return err;
+	}
+
+	if (desc.type != SSDFS_DENTRIES_BTREE) {
+		SSDFS_ERR("invalid btree type %#x\n",
+			  desc.type);
+		return -ERANGE;
+	}
+
+	erasesize = fsi->erasesize;
+	node_size = 1 << desc.log_node_size;
+
+	if (node_size < SSDFS_4KB || node_size > erasesize) {
+		SSDFS_ERR("invalid node size: "
+			  "log_node_size %u, node_size %u, erasesize %u\n",
+			  desc.log_node_size,
+			  node_size, erasesize);
+		return -ERANGE;
+	}
+
+	if (le16_to_cpu(desc.index_area_min_size) < (2 * dentry_size)) {
+		SSDFS_ERR("invalid index_area_min_size %u\n",
+			  le16_to_cpu(desc.index_area_min_size));
+		return -ERANGE;
+	}
+
+	ssdfs_memcpy(&tree_info->desc.desc,
+		     0, sizeof(struct ssdfs_btree_descriptor),
+		     &desc,
+		     0, sizeof(struct ssdfs_btree_descriptor),
+		     sizeof(struct ssdfs_btree_descriptor));
+
+	return 0;
+}
+
+/******************************************************************************
+ *                   SPECIALIZED DENTRIES BTREE OPERATIONS                    *
+ ******************************************************************************/
+
+/*
+ * ssdfs_dentries_btree_create_root_node() - specialized root node creation
+ * @fsi: pointer on shared file system object
+ * @node: pointer on node object [out]
+ */
+static
+int ssdfs_dentries_btree_create_root_node(struct ssdfs_fs_info *fsi,
+					  struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_dentries_btree_info *tree_info = NULL;
+	struct ssdfs_btree_inline_root_node tmp_buffer;
+	struct ssdfs_inode *raw_inode = NULL;
+	int private_flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !node);
+
+	SSDFS_DBG("fsi %p, node %p\n",
+		  fsi, node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree = node->tree;
+	if (!tree) {
+		SSDFS_ERR("node hasn't pointer on tree\n");
+		return -ERANGE;
+	}
+
+	if (atomic_read(&tree->state) != SSDFS_BTREE_UNKNOWN_STATE) {
+		SSDFS_ERR("unexpected tree state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	}
+
+	if (tree->type != SSDFS_DENTRIES_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_dentries_btree_info,
+					 buffer.tree);
+	}
+
+	if (!tree_info->owner) {
+		SSDFS_ERR("empty inode pointer\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!rwsem_is_locked(&tree_info->owner->lock));
+	BUG_ON(!rwsem_is_locked(&tree_info->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	private_flags = atomic_read(&tree_info->owner->private_flags);
+
+	if (private_flags & SSDFS_INODE_HAS_DENTRIES_BTREE) {
+		switch (atomic_read(&tree_info->type)) {
+		case SSDFS_PRIVATE_DENTRIES_BTREE:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid tree type %#x\n",
+				  atomic_read(&tree_info->type));
+			return -ERANGE;
+		}
+
+		raw_inode = &tree_info->owner->raw_inode;
+		ssdfs_memcpy(&tmp_buffer,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     &raw_inode->internal[0].area1.dentries_root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     sizeof(struct ssdfs_btree_inline_root_node));
+	} else {
+		switch (atomic_read(&tree_info->type)) {
+		case SSDFS_INLINE_DENTRIES_ARRAY:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid tree type %#x\n",
+				  atomic_read(&tree_info->type));
+			return -ERANGE;
+		}
+
+		memset(&tmp_buffer, 0xFF,
+			sizeof(struct ssdfs_btree_inline_root_node));
+
+		tmp_buffer.header.height = SSDFS_BTREE_LEAF_NODE_HEIGHT + 1;
+		tmp_buffer.header.items_count = 0;
+		tmp_buffer.header.flags = 0;
+		tmp_buffer.header.type = SSDFS_BTREE_ROOT_NODE;
+		tmp_buffer.header.upper_node_id =
+				cpu_to_le32(SSDFS_BTREE_ROOT_NODE_ID);
+	}
+
+	ssdfs_memcpy(&tree_info->root_buffer,
+		     0, sizeof(struct ssdfs_btree_inline_root_node),
+		     &tmp_buffer,
+		     0, sizeof(struct ssdfs_btree_inline_root_node),
+		     sizeof(struct ssdfs_btree_inline_root_node));
+	tree_info->root = &tree_info->root_buffer;
+
+	err = ssdfs_btree_create_root_node(node, tree_info->root);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create root node: err %d\n",
+			  err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_btree_pre_flush_root_node() - specialized root node pre-flush
+ * @node: pointer on node object
+ */
+static
+int ssdfs_dentries_btree_pre_flush_root_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_state_bitmap *bmap;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+		SSDFS_DBG("node %u is clean\n",
+			  node->node_id);
+		return 0;
+
+	case SSDFS_BTREE_NODE_CORRUPTED:
+		SSDFS_WARN("node %u is corrupted\n",
+			   node->node_id);
+		down_read(&node->bmap_array.lock);
+		bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_DIRTY_BMAP];
+		spin_lock(&bmap->lock);
+		bitmap_clear(bmap->ptr, 0, node->bmap_array.bits_count);
+		spin_unlock(&bmap->lock);
+		up_read(&node->bmap_array.lock);
+		clear_ssdfs_btree_node_dirty(node);
+		return -EFAULT;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	tree = node->tree;
+	if (!tree) {
+		SSDFS_ERR("node hasn't pointer on tree\n");
+		return -ERANGE;
+	}
+
+	if (tree->type != SSDFS_DENTRIES_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	}
+
+	down_write(&node->full_lock);
+	down_write(&node->header_lock);
+
+	err = ssdfs_btree_pre_flush_root_node(node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-flush root node: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+	}
+
+	up_write(&node->header_lock);
+	up_write(&node->full_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_btree_flush_root_node() - specialized root node flush
+ * @node: pointer on node object
+ */
+static
+int ssdfs_dentries_btree_flush_root_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_dentries_btree_info *tree_info = NULL;
+	struct ssdfs_btree_inline_root_node tmp_buffer;
+	struct ssdfs_inode *raw_inode = NULL;
+	int private_flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node %p, node_id %u\n",
+		  node, node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree = node->tree;
+	if (!tree) {
+		SSDFS_ERR("node hasn't pointer on tree\n");
+		return -ERANGE;
+	}
+
+	if (tree->type != SSDFS_DENTRIES_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_dentries_btree_info,
+					 buffer.tree);
+	}
+
+	if (!tree_info->owner) {
+		SSDFS_ERR("empty inode pointer\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!rwsem_is_locked(&tree_info->owner->lock));
+	BUG_ON(!rwsem_is_locked(&tree_info->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	private_flags = atomic_read(&tree_info->owner->private_flags);
+
+	if (private_flags & SSDFS_INODE_HAS_DENTRIES_BTREE) {
+		switch (atomic_read(&tree_info->type)) {
+		case SSDFS_PRIVATE_DENTRIES_BTREE:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid tree type %#x\n",
+				  atomic_read(&tree_info->type));
+			return -ERANGE;
+		}
+
+		if (!tree_info->root) {
+			SSDFS_ERR("root node pointer is NULL\n");
+			return -ERANGE;
+		}
+
+		ssdfs_btree_flush_root_node(node, tree_info->root);
+
+		ssdfs_memcpy(&tmp_buffer,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     tree_info->root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     sizeof(struct ssdfs_btree_inline_root_node));
+
+		raw_inode = &tree_info->owner->raw_inode;
+		ssdfs_memcpy(&raw_inode->internal[0].area1.dentries_root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     &tmp_buffer,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     sizeof(struct ssdfs_btree_inline_root_node));
+	} else {
+		err = -ERANGE;
+		SSDFS_ERR("dentries tree is inline dentries array\n");
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_btree_create_node() - specialized node creation
+ * @node: pointer on node object
+ */
+static
+int ssdfs_dentries_btree_create_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	void *addr[SSDFS_BTREE_NODE_BMAP_COUNT];
+	size_t hdr_size = sizeof(struct ssdfs_dentries_btree_node_header);
+	u32 node_size;
+	u32 items_area_size = 0;
+	u16 item_size = 0;
+	u16 index_size = 0;
+	u16 index_area_min_size;
+	u16 items_capacity = 0;
+	u16 index_capacity = 0;
+	u32 index_area_size = 0;
+	size_t bmap_bytes;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+	WARN_ON(atomic_read(&node->state) != SSDFS_BTREE_NODE_CREATED);
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree = node->tree;
+	node_size = tree->node_size;
+	index_area_min_size = tree->index_area_min_size;
+
+	node->node_ops = &ssdfs_dentries_btree_node_ops;
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_INDEX_NODE:
+		switch (atomic_read(&node->index_area.state)) {
+		case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid index area's state %#x\n",
+				  atomic_read(&node->items_area.state));
+			return -ERANGE;
+		}
+
+		switch (atomic_read(&node->items_area.state)) {
+		case SSDFS_BTREE_NODE_AREA_ABSENT:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid items area's state %#x\n",
+				  atomic_read(&node->items_area.state));
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		switch (atomic_read(&node->index_area.state)) {
+		case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid index area's state %#x\n",
+				  atomic_read(&node->items_area.state));
+			return -ERANGE;
+		}
+
+		switch (atomic_read(&node->items_area.state)) {
+		case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid items area's state %#x\n",
+				  atomic_read(&node->items_area.state));
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		switch (atomic_read(&node->index_area.state)) {
+		case SSDFS_BTREE_NODE_AREA_ABSENT:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid index area's state %#x\n",
+				  atomic_read(&node->items_area.state));
+			return -ERANGE;
+		}
+
+		switch (atomic_read(&node->items_area.state)) {
+		case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid items area's state %#x\n",
+				  atomic_read(&node->items_area.state));
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_WARN("invalid node type %#x\n",
+			   atomic_read(&node->type));
+		return -ERANGE;
+	}
+
+	down_write(&node->header_lock);
+	down_write(&node->bmap_array.lock);
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_INDEX_NODE:
+		node->index_area.offset = (u32)hdr_size;
+		node->index_area.area_size = node_size - hdr_size;
+
+		index_area_size = node->index_area.area_size;
+		index_size = node->index_area.index_size;
+
+		node->index_area.index_capacity = index_area_size / index_size;
+		index_capacity = node->index_area.index_capacity;
+
+		node->bmap_array.index_start_bit =
+			SSDFS_BTREE_NODE_HEADER_INDEX + 1;
+		node->bmap_array.item_start_bit =
+			node->bmap_array.index_start_bit + index_capacity;
+
+		node->raw.dentries_header.dentries_count = cpu_to_le16(0);
+		node->raw.dentries_header.inline_names = cpu_to_le16(0);
+		node->raw.dentries_header.free_space = cpu_to_le16(0);
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		node->index_area.offset = (u32)hdr_size;
+
+		if (index_area_min_size == 0 ||
+		    index_area_min_size >= (node_size - hdr_size)) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid index area desc: "
+				  "index_area_min_size %u, "
+				  "node_size %u, hdr_size %zu\n",
+				  index_area_min_size,
+				  node_size, hdr_size);
+			goto finish_create_node;
+		}
+
+		node->index_area.area_size = index_area_min_size;
+
+		index_area_size = node->index_area.area_size;
+		index_size = node->index_area.index_size;
+		node->index_area.index_capacity = index_area_size / index_size;
+		index_capacity = node->index_area.index_capacity;
+
+		node->items_area.offset = node->index_area.offset +
+						node->index_area.area_size;
+
+		if (node->items_area.offset >= node_size) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid items area desc: "
+				  "area_offset %u, node_size %u\n",
+				  node->items_area.offset,
+				  node_size);
+			goto finish_create_node;
+		}
+
+		node->items_area.area_size = node_size -
+						node->items_area.offset;
+		node->items_area.free_space = node->items_area.area_size;
+		node->items_area.item_size = tree->item_size;
+		node->items_area.min_item_size = tree->min_item_size;
+		node->items_area.max_item_size = tree->max_item_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_size %u, hdr_size %zu, free_space %u\n",
+			  node_size, hdr_size,
+			  node->items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		items_area_size = node->items_area.area_size;
+		item_size = node->items_area.item_size;
+
+		node->items_area.items_count = 0;
+		node->items_area.items_capacity = items_area_size / item_size;
+		items_capacity = node->items_area.items_capacity;
+
+		if (node->items_area.items_capacity == 0) {
+			err = -ERANGE;
+			SSDFS_ERR("items area's capacity %u\n",
+				  node->items_area.items_capacity);
+			goto finish_create_node;
+		}
+
+		node->bmap_array.index_start_bit =
+			SSDFS_BTREE_NODE_HEADER_INDEX + 1;
+		node->bmap_array.item_start_bit =
+			node->bmap_array.index_start_bit + index_capacity;
+
+		node->raw.dentries_header.dentries_count = cpu_to_le16(0);
+		node->raw.dentries_header.inline_names = cpu_to_le16(0);
+		node->raw.dentries_header.free_space =
+				cpu_to_le16((u16)node->items_area.free_space);
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		node->items_area.offset = (u32)hdr_size;
+		node->items_area.area_size = node_size - hdr_size;
+		node->items_area.free_space = node->items_area.area_size;
+		node->items_area.item_size = tree->item_size;
+		node->items_area.min_item_size = tree->min_item_size;
+		node->items_area.max_item_size = tree->max_item_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_size %u, hdr_size %zu, free_space %u\n",
+			  node_size, hdr_size,
+			  node->items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		items_area_size = node->items_area.area_size;
+		item_size = node->items_area.item_size;
+
+		node->items_area.items_count = 0;
+		node->items_area.items_capacity = items_area_size / item_size;
+		items_capacity = node->items_area.items_capacity;
+
+		node->bmap_array.item_start_bit =
+				SSDFS_BTREE_NODE_HEADER_INDEX + 1;
+
+		node->raw.dentries_header.dentries_count = cpu_to_le16(0);
+		node->raw.dentries_header.inline_names = cpu_to_le16(0);
+		node->raw.dentries_header.free_space =
+				cpu_to_le16((u16)node->items_area.free_space);
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid node type %#x\n",
+			   atomic_read(&node->type));
+		goto finish_create_node;
+	}
+
+	node->bmap_array.bits_count = index_capacity + items_capacity + 1;
+
+	if (item_size > 0)
+		items_capacity = node_size / item_size;
+	else
+		items_capacity = 0;
+
+	if (index_size > 0)
+		index_capacity = node_size / index_size;
+	else
+		index_capacity = 0;
+
+	bmap_bytes = index_capacity + items_capacity + 1;
+	bmap_bytes += BITS_PER_LONG;
+	bmap_bytes /= BITS_PER_BYTE;
+
+	node->bmap_array.bmap_bytes = bmap_bytes;
+
+	if (bmap_bytes == 0 || bmap_bytes > SSDFS_DENTRIES_BMAP_SIZE) {
+		err = -EIO;
+		SSDFS_ERR("invalid bmap_bytes %zu\n",
+			  bmap_bytes);
+		goto finish_create_node;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, dentries_count %u, "
+		  "inline_names %u, free_space %u\n",
+		  node->node_id,
+		  le16_to_cpu(node->raw.dentries_header.dentries_count),
+		  le16_to_cpu(node->raw.dentries_header.inline_names),
+		  le16_to_cpu(node->raw.dentries_header.free_space));
+	SSDFS_DBG("items_count %u, items_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  node->items_area.items_count,
+		  node->items_area.items_capacity,
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+	SSDFS_DBG("index_count %u, index_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  node->index_area.index_count,
+		  node->index_area.index_capacity,
+		  node->index_area.start_hash,
+		  node->index_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_create_node:
+	up_write(&node->bmap_array.lock);
+	up_write(&node->header_lock);
+
+	if (unlikely(err))
+		return err;
+
+	err = ssdfs_btree_node_allocate_bmaps(addr, bmap_bytes);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate node's bitmaps: "
+			  "bmap_bytes %zu, err %d\n",
+			  bmap_bytes, err);
+		return err;
+	}
+
+	down_write(&node->bmap_array.lock);
+	for (i = 0; i < SSDFS_BTREE_NODE_BMAP_COUNT; i++) {
+		spin_lock(&node->bmap_array.bmap[i].lock);
+		node->bmap_array.bmap[i].ptr = addr[i];
+		addr[i] = NULL;
+		spin_unlock(&node->bmap_array.bmap[i].lock);
+	}
+	up_write(&node->bmap_array.lock);
+
+	err = ssdfs_btree_node_allocate_content_space(node, node_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate content space: "
+			  "node_size %u, err %d\n",
+			  node_size, err);
+		return err;
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_btree_init_node() - init dentries tree's node
+ * @node: pointer on node object
+ *
+ * This method tries to init the node of dentries btree.
+ *
+ *       It makes sense to allocate the bitmap with taking into
+ *       account that we will resize the node. So, it needs
+ *       to allocate the index area in bitmap is equal to
+ *       the whole node and items area is equal to the whole node.
+ *       This technique provides opportunity not to resize or
+ *       to shift the content of the bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ * %-EIO        - invalid node's header content
+ */
+static
+int ssdfs_dentries_btree_init_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_dentries_btree_info *tree_info = NULL;
+	struct ssdfs_dentries_btree_node_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_dentries_btree_node_header);
+	void *addr[SSDFS_BTREE_NODE_BMAP_COUNT];
+	struct page *page;
+	void *kaddr;
+	u64 start_hash, end_hash;
+	u32 node_size;
+	u16 item_size;
+	u64 parent_ino;
+	u32 dentries_count;
+	u16 items_capacity;
+	u16 inline_names;
+	u16 free_space;
+	u32 calculated_used_space;
+	u32 items_count;
+	u16 flags;
+	u8 index_size;
+	u32 index_area_size = 0;
+	u16 index_capacity = 0;
+	size_t bmap_bytes;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree = node->tree;
+	if (!tree) {
+		SSDFS_ERR("node hasn't pointer on tree\n");
+		return -ERANGE;
+	}
+
+	if (tree->type != SSDFS_DENTRIES_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_dentries_btree_info,
+					 buffer.tree);
+	}
+
+	if (atomic_read(&node->state) != SSDFS_BTREE_NODE_CONTENT_PREPARED) {
+		SSDFS_WARN("fail to init node: id %u, state %#x\n",
+			   node->node_id, atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	down_read(&node->full_lock);
+
+	if (pagevec_count(&node->content.pvec) == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("empty node's content: id %u\n",
+			  node->node_id);
+		goto finish_init_node;
+	}
+
+	page = node->content.pvec.pages[0];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	kaddr = kmap_local_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("PAGE DUMP\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     kaddr,
+			     PAGE_SIZE);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_dentries_btree_node_header *)kaddr;
+
+	if (!is_csum_valid(&hdr->node.check, hdr, hdr_size)) {
+		err = -EIO;
+		SSDFS_ERR("invalid checksum: node_id %u\n",
+			  node->node_id);
+		goto finish_init_operation;
+	}
+
+	if (le32_to_cpu(hdr->node.magic.common) != SSDFS_SUPER_MAGIC ||
+	    le16_to_cpu(hdr->node.magic.key) != SSDFS_DENTRIES_BNODE_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid magic: common %#x, key %#x\n",
+			  le32_to_cpu(hdr->node.magic.common),
+			  le16_to_cpu(hdr->node.magic.key));
+		goto finish_init_operation;
+	}
+
+	down_write(&node->header_lock);
+
+	ssdfs_memcpy(&node->raw.dentries_header, 0, hdr_size,
+		     hdr, 0, hdr_size,
+		     hdr_size);
+
+	err = ssdfs_btree_init_node(node, &hdr->node,
+				    hdr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init node: id %u, err %d\n",
+			  node->node_id, err);
+		goto finish_header_init;
+	}
+
+	flags = atomic_read(&node->flags);
+
+	start_hash = le64_to_cpu(hdr->node.start_hash);
+	end_hash = le64_to_cpu(hdr->node.end_hash);
+	node_size = 1 << hdr->node.log_node_size;
+	index_size = hdr->node.index_size;
+	item_size = hdr->node.min_item_size;
+	items_capacity = le16_to_cpu(hdr->node.items_capacity);
+	parent_ino = le64_to_cpu(hdr->parent_ino);
+	dentries_count = le16_to_cpu(hdr->dentries_count);
+	inline_names = le16_to_cpu(hdr->inline_names);
+	free_space = le16_to_cpu(hdr->free_space);
+
+	if (parent_ino != tree_info->owner->vfs_inode.i_ino) {
+		err = -EIO;
+		SSDFS_ERR("parent_ino %llu != ino %lu\n",
+			  parent_ino,
+			  tree_info->owner->vfs_inode.i_ino);
+		goto finish_header_init;
+	}
+
+	calculated_used_space = hdr_size;
+	calculated_used_space += dentries_count * item_size;
+
+	if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+		index_area_size = 1 << hdr->node.log_index_area_size;
+		calculated_used_space += index_area_size;
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+		/* do nothing */
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+			if (index_area_size != node->node_size) {
+				err = -EIO;
+				SSDFS_ERR("invalid index area's size: "
+					  "node_id %u, index_area_size %u, "
+					  "node_size %u\n",
+					  node->node_id,
+					  index_area_size,
+					  node->node_size);
+				goto finish_header_init;
+			}
+
+			calculated_used_space -= hdr_size;
+		} else {
+			err = -EIO;
+			SSDFS_ERR("invalid set of flags: "
+				  "node_id %u, flags %#x\n",
+				  node->node_id, flags);
+			goto finish_header_init;
+		}
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+			/*
+			 * expected state
+			 */
+		} else {
+			err = -EIO;
+			SSDFS_ERR("invalid set of flags: "
+				  "node_id %u, flags %#x\n",
+				  node->node_id, flags);
+			goto finish_header_init;
+		}
+		/* FALLTHRU */
+		fallthrough;
+	case SSDFS_BTREE_LEAF_NODE:
+		if (dentries_count > 0 &&
+		    (start_hash >= U64_MAX || end_hash >= U64_MAX)) {
+			err = -EIO;
+			SSDFS_ERR("invalid hash range: "
+				  "start_hash %llx, end_hash %llx\n",
+				  start_hash, end_hash);
+			goto finish_header_init;
+		}
+
+		if (item_size == 0 || node_size % item_size) {
+			err = -EIO;
+			SSDFS_ERR("invalid size: item_size %u, node_size %u\n",
+				  item_size, node_size);
+			goto finish_header_init;
+		}
+
+		if (item_size != sizeof(struct ssdfs_dir_entry)) {
+			err = -EIO;
+			SSDFS_ERR("invalid item_size: "
+				  "size %u, expected size %zu\n",
+				  item_size,
+				  sizeof(struct ssdfs_dir_entry));
+			goto finish_header_init;
+		}
+
+		if (items_capacity == 0 ||
+		    items_capacity > (node_size / item_size)) {
+			err = -EIO;
+			SSDFS_ERR("invalid items_capacity %u\n",
+				  items_capacity);
+			goto finish_header_init;
+		}
+
+		if (dentries_count > items_capacity) {
+			err = -EIO;
+			SSDFS_ERR("items_capacity %u != dentries_count %u\n",
+				  items_capacity,
+				  dentries_count);
+			goto finish_header_init;
+		}
+
+		if (inline_names > dentries_count) {
+			err = -EIO;
+			SSDFS_ERR("inline_names %u > dentries_count %u\n",
+				  inline_names, dentries_count);
+			goto finish_header_init;
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_space %u, index_area_size %u, "
+		  "hdr_size %zu, dentries_count %u, "
+		  "item_size %u\n",
+		  free_space, index_area_size, hdr_size,
+		  dentries_count, item_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (free_space != (node_size - calculated_used_space)) {
+		err = -EIO;
+		SSDFS_ERR("free_space %u, node_size %u, "
+			  "calculated_used_space %u\n",
+			  free_space, node_size,
+			  calculated_used_space);
+		goto finish_header_init;
+	}
+
+	node->items_area.free_space = free_space;
+	node->items_area.items_count = (u16)dentries_count;
+	node->items_area.items_capacity = items_capacity;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %u, items_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  node->items_area.items_count,
+		  node->items_area.items_capacity,
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+	SSDFS_DBG("index_count %u, index_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  node->index_area.index_count,
+		  node->index_area.index_capacity,
+		  node->index_area.start_hash,
+		  node->index_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_header_init:
+	up_write(&node->header_lock);
+
+	if (unlikely(err))
+		goto finish_init_operation;
+
+	items_count = node_size / item_size;
+
+	if (item_size > 0)
+		items_capacity = node_size / item_size;
+	else
+		items_capacity = 0;
+
+	if (index_size > 0)
+		index_capacity = node_size / index_size;
+	else
+		index_capacity = 0;
+
+	bmap_bytes = index_capacity + items_capacity + 1;
+	bmap_bytes += BITS_PER_LONG;
+	bmap_bytes /= BITS_PER_BYTE;
+
+	if (bmap_bytes == 0 || bmap_bytes > SSDFS_DENTRIES_BMAP_SIZE) {
+		err = -EIO;
+		SSDFS_ERR("invalid bmap_bytes %zu\n",
+			  bmap_bytes);
+		goto finish_init_operation;
+	}
+
+	err = ssdfs_btree_node_allocate_bmaps(addr, bmap_bytes);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate node's bitmaps: "
+			  "bmap_bytes %zu, err %d\n",
+			  bmap_bytes, err);
+		goto finish_init_operation;
+	}
+
+	down_write(&node->bmap_array.lock);
+
+	if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+		node->bmap_array.index_start_bit =
+			SSDFS_BTREE_NODE_HEADER_INDEX + 1;
+		/*
+		 * Reserve the whole node space as
+		 * potential space for indexes.
+		 */
+		index_capacity = node_size / index_size;
+		node->bmap_array.item_start_bit =
+			node->bmap_array.index_start_bit + index_capacity;
+	} else if (flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA) {
+		node->bmap_array.item_start_bit =
+				SSDFS_BTREE_NODE_HEADER_INDEX + 1;
+	} else
+		BUG();
+
+	node->bmap_array.bits_count = index_capacity + items_capacity + 1;
+	node->bmap_array.bmap_bytes = bmap_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("index_capacity %u, index_area_size %u, "
+		  "index_size %u\n",
+		  index_capacity, index_area_size, index_size);
+	SSDFS_DBG("index_start_bit %lu, item_start_bit %lu, "
+		  "bits_count %lu\n",
+		  node->bmap_array.index_start_bit,
+		  node->bmap_array.item_start_bit,
+		  node->bmap_array.bits_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_btree_node_init_bmaps(node, addr);
+
+	spin_lock(&node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].lock);
+	bitmap_set(node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].ptr,
+		   0, dentries_count);
+	spin_unlock(&node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].lock);
+
+	up_write(&node->bmap_array.lock);
+finish_init_operation:
+	kunmap_local(kaddr);
+
+	if (unlikely(err))
+		goto finish_init_node;
+
+finish_init_node:
+	up_read(&node->full_lock);
+
+	ssdfs_debug_btree_node_object(node);
+
+	return err;
+}
+
+static
+void ssdfs_dentries_btree_destroy_node(struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_dentries_btree_add_node() - add node into dentries btree
+ * @node: pointer on node object
+ *
+ * This method tries to finish addition of node into dentries btree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_dentries_btree_add_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	int type;
+	u16 items_capacity = 0;
+	u64 start_hash = U64_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid node: id %u, state %#x\n",
+			   node->node_id, atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	type = atomic_read(&node->type);
+
+	switch (type) {
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_LEAF_NODE:
+		/* expected states */
+		break;
+
+	default:
+		SSDFS_WARN("invalid node type %#x\n", type);
+		return -ERANGE;
+	};
+
+	tree = node->tree;
+	if (!tree) {
+		SSDFS_ERR("node hasn't pointer on tree\n");
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		items_capacity = node->items_area.items_capacity;
+		start_hash = node->items_area.start_hash;
+		break;
+	default:
+		items_capacity = 0;
+		break;
+	};
+
+	if (items_capacity == 0) {
+		if (type == SSDFS_BTREE_LEAF_NODE ||
+		    type == SSDFS_BTREE_HYBRID_NODE) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid node state: "
+				  "type %#x, items_capacity %u\n",
+				  type, items_capacity);
+			goto finish_add_node;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, dentries_count %u, "
+		  "inline_names %u, free_space %u\n",
+		  node->node_id,
+		  le16_to_cpu(node->raw.dentries_header.dentries_count),
+		  le16_to_cpu(node->raw.dentries_header.inline_names),
+		  le16_to_cpu(node->raw.dentries_header.free_space));
+	SSDFS_DBG("items_count %u, items_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  node->items_area.items_count,
+		  node->items_area.items_capacity,
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+	SSDFS_DBG("index_count %u, index_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  node->index_area.index_count,
+		  node->index_area.index_capacity,
+		  node->index_area.start_hash,
+		  node->index_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_add_node:
+	up_read(&node->header_lock);
+
+	ssdfs_debug_btree_node_object(node);
+
+	if (err)
+		return err;
+
+	err = ssdfs_btree_update_parent_node_pointer(tree, node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update parent pointer: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static
+int ssdfs_dentries_btree_delete_node(struct ssdfs_btree_node *node)
+{
+	/* TODO: implement */
+	SSDFS_DBG("TODO: implement\n");
+	return 0;
+
+/*
+ * TODO: it needs to add special free space descriptor in the
+ *       index area for the case of deleted nodes. Code of
+ *       allocation of new items should create empty node
+ *       with completely free items during passing through
+ *       index level.
+ */
+
+
+
+/*
+ * TODO: node can be really deleted/invalidated. But index
+ *       area should contain index for deleted node with
+ *       special flag. In this case it will be clear that
+ *       we have some capacity without real node allocation.
+ *       If some item will be added in the node then node
+ *       has to be allocated. It means that if you delete
+ *       a node then index hierachy will be the same without
+ *       necessity to delete or modify it.
+ */
+
+
+
+	/* TODO:  decrement nodes_count and/or leaf_nodes counters */
+	/* TODO:  decrease inodes_capacity and/or free_inodes */
+}
+
+/*
+ * ssdfs_dentries_btree_pre_flush_node() - pre-flush node's header
+ * @node: pointer on node object
+ *
+ * This method tries to flush node's header.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_dentries_btree_pre_flush_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_dentries_btree_node_header dentries_header;
+	size_t hdr_size = sizeof(struct ssdfs_dentries_btree_node_header);
+	struct ssdfs_btree *tree;
+	struct ssdfs_dentries_btree_info *tree_info = NULL;
+	struct ssdfs_state_bitmap *bmap;
+	struct page *page;
+	u16 items_count;
+	u32 items_area_size;
+	u16 dentries_count;
+	u16 inline_names;
+	u16 free_space;
+	u32 used_space;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+		SSDFS_DBG("node %u is clean\n",
+			  node->node_id);
+		return 0;
+
+	case SSDFS_BTREE_NODE_CORRUPTED:
+		SSDFS_WARN("node %u is corrupted\n",
+			   node->node_id);
+		down_read(&node->bmap_array.lock);
+		bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_DIRTY_BMAP];
+		spin_lock(&bmap->lock);
+		bitmap_clear(bmap->ptr, 0, node->bmap_array.bits_count);
+		spin_unlock(&bmap->lock);
+		up_read(&node->bmap_array.lock);
+		clear_ssdfs_btree_node_dirty(node);
+		return -EFAULT;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	tree = node->tree;
+	if (!tree) {
+		SSDFS_ERR("node hasn't pointer on tree\n");
+		return -ERANGE;
+	}
+
+	if (tree->type != SSDFS_DENTRIES_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_dentries_btree_info,
+					 buffer.tree);
+	}
+
+	down_write(&node->full_lock);
+	down_write(&node->header_lock);
+
+	ssdfs_memcpy(&dentries_header, 0, hdr_size,
+		     &node->raw.dentries_header, 0, hdr_size,
+		     hdr_size);
+
+	dentries_header.node.magic.common = cpu_to_le32(SSDFS_SUPER_MAGIC);
+	dentries_header.node.magic.key =
+				cpu_to_le16(SSDFS_DENTRIES_BNODE_MAGIC);
+	dentries_header.node.magic.version.major = SSDFS_MAJOR_REVISION;
+	dentries_header.node.magic.version.minor = SSDFS_MINOR_REVISION;
+
+	err = ssdfs_btree_node_pre_flush_header(node, &dentries_header.node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to flush generic header: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		goto finish_dentries_header_preparation;
+	}
+
+	if (!tree_info->owner) {
+		err = -ERANGE;
+		SSDFS_WARN("fail to extract parent_ino\n");
+		goto finish_dentries_header_preparation;
+	}
+
+	dentries_header.parent_ino =
+		cpu_to_le64(tree_info->owner->vfs_inode.i_ino);
+
+	items_count = node->items_area.items_count;
+	items_area_size = node->items_area.area_size;
+	dentries_count = le16_to_cpu(dentries_header.dentries_count);
+	inline_names = le16_to_cpu(dentries_header.inline_names);
+	free_space = le16_to_cpu(dentries_header.free_space);
+
+	if (dentries_count != items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("dentries_count %u != items_count %u\n",
+			  dentries_count, items_count);
+		goto finish_dentries_header_preparation;
+	}
+
+	if (inline_names > dentries_count) {
+		err = -ERANGE;
+		SSDFS_ERR("inline_names %u > dentries_count %u\n",
+			  inline_names, dentries_count);
+		goto finish_dentries_header_preparation;
+	}
+
+	used_space = (u32)items_count * sizeof(struct ssdfs_dir_entry);
+
+	if (used_space > items_area_size) {
+		err = -ERANGE;
+		SSDFS_ERR("used_space %u > items_area_size %u\n",
+			  used_space, items_area_size);
+		goto finish_dentries_header_preparation;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_space %u, dentries_count %u, "
+		  "items_area_size %u, item_size %zu\n",
+		  free_space, dentries_count,
+		  items_area_size,
+		  sizeof(struct ssdfs_dir_entry));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (free_space != (items_area_size - used_space)) {
+		err = -ERANGE;
+		SSDFS_ERR("free_space %u, items_area_size %u, "
+			  "used_space %u\n",
+			  free_space, items_area_size,
+			  used_space);
+		goto finish_dentries_header_preparation;
+	}
+
+	dentries_header.node.check.bytes = cpu_to_le16((u16)hdr_size);
+	dentries_header.node.check.flags = cpu_to_le16(SSDFS_CRC32);
+
+	err = ssdfs_calculate_csum(&dentries_header.node.check,
+				   &dentries_header, hdr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to calculate checksum: err %d\n", err);
+		goto finish_dentries_header_preparation;
+	}
+
+	ssdfs_memcpy(&node->raw.dentries_header, 0, hdr_size,
+		     &dentries_header, 0, hdr_size,
+		     hdr_size);
+
+finish_dentries_header_preparation:
+	up_write(&node->header_lock);
+
+	if (unlikely(err))
+		goto finish_node_pre_flush;
+
+	if (pagevec_count(&node->content.pvec) < 1) {
+		err = -ERANGE;
+		SSDFS_ERR("pagevec is empty\n");
+		goto finish_node_pre_flush;
+	}
+
+	page = node->content.pvec.pages[0];
+	ssdfs_memcpy_to_page(page, 0, PAGE_SIZE,
+			     &dentries_header, 0, hdr_size,
+			     hdr_size);
+
+finish_node_pre_flush:
+	up_write(&node->full_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_btree_flush_node() - flush node
+ * @node: pointer on node object
+ *
+ * This method tries to flush node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_dentries_btree_flush_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_dentries_btree_info *tree_info = NULL;
+	int private_flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node %p, node_id %u\n",
+		  node, node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree = node->tree;
+	if (!tree) {
+		SSDFS_ERR("node hasn't pointer on tree\n");
+		return -ERANGE;
+	}
+
+	if (tree->type != SSDFS_DENTRIES_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_dentries_btree_info,
+					 buffer.tree);
+	}
+
+	private_flags = atomic_read(&tree_info->owner->private_flags);
+
+	if (private_flags & SSDFS_INODE_HAS_DENTRIES_BTREE) {
+		switch (atomic_read(&tree_info->type)) {
+		case SSDFS_PRIVATE_DENTRIES_BTREE:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid tree type %#x\n",
+				  atomic_read(&tree_info->type));
+			return -ERANGE;
+		}
+
+		err = ssdfs_btree_common_node_flush(node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to flush node: "
+				  "node_id %u, height %u, err %d\n",
+				  node->node_id,
+				  atomic_read(&node->height),
+				  err);
+		}
+	} else {
+		err = -ERANGE;
+		SSDFS_ERR("dentries tree is inline dentries array\n");
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	return err;
+}
+
+/******************************************************************************
+ *               SPECIALIZED DENTRIES BTREE NODE OPERATIONS                   *
+ ******************************************************************************/
+
+/*
+ * ssdfs_convert_lookup2item_index() - convert lookup into item index
+ * @node_size: size of the node in bytes
+ * @lookup_index: lookup index
+ */
+static inline
+u16 ssdfs_convert_lookup2item_index(u32 node_size, u16 lookup_index)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_size %u, lookup_index %u\n",
+		  node_size, lookup_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_convert_lookup2item_index(lookup_index, node_size,
+					sizeof(struct ssdfs_dir_entry),
+					SSDFS_DENTRIES_BTREE_LOOKUP_TABLE_SIZE);
+}
+
+/*
+ * ssdfs_convert_item2lookup_index() - convert item into lookup index
+ * @node_size: size of the node in bytes
+ * @item_index: item index
+ */
+static inline
+u16 ssdfs_convert_item2lookup_index(u32 node_size, u16 item_index)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_size %u, item_index %u\n",
+		  node_size, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_convert_item2lookup_index(item_index, node_size,
+					sizeof(struct ssdfs_dir_entry),
+					SSDFS_DENTRIES_BTREE_LOOKUP_TABLE_SIZE);
+}
+
+/*
+ * is_hash_for_lookup_table() - should item's hash be into lookup table?
+ * @node_size: size of the node in bytes
+ * @item_index: item index
+ */
+static inline
+bool is_hash_for_lookup_table(u32 node_size, u16 item_index)
+{
+	u16 lookup_index;
+	u16 calculated;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_size %u, item_index %u\n",
+		  node_size, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	lookup_index = ssdfs_convert_item2lookup_index(node_size, item_index);
+	calculated = ssdfs_convert_lookup2item_index(node_size, lookup_index);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lookup_index %u, calculated %u\n",
+		  lookup_index, calculated);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return calculated == item_index;
+}
+
+/*
+ * ssdfs_dentries_btree_node_find_lookup_index() - find lookup index
+ * @node: node object
+ * @search: search object
+ * @lookup_index: lookup index [out]
+ *
+ * This method tries to find a lookup index for requested items.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - lookup index doesn't exist for requested hash.
+ */
+static
+int ssdfs_dentries_btree_node_find_lookup_index(struct ssdfs_btree_node *node,
+					    struct ssdfs_btree_search *search,
+					    u16 *lookup_index)
+{
+	__le64 *lookup_table;
+	int array_size = SSDFS_DENTRIES_BTREE_LOOKUP_TABLE_SIZE;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search || !lookup_index);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	lookup_table = node->raw.dentries_header.lookup_table;
+	err = ssdfs_btree_node_find_lookup_index_nolock(search,
+							lookup_table,
+							array_size,
+							lookup_index);
+	up_read(&node->header_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_get_dentries_hash_range() - get dentry's hash range
+ * @kaddr: pointer on dentry object
+ * @start_hash: pointer on start_hash value [out]
+ * @end_hash: pointer on end_hash value [out]
+ */
+static
+void ssdfs_get_dentries_hash_range(void *kaddr,
+				    u64 *start_hash,
+				    u64 *end_hash)
+{
+	struct ssdfs_dir_entry *dentry;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !start_hash || !end_hash);
+
+	SSDFS_DBG("kaddr %p\n", kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	dentry = (struct ssdfs_dir_entry *)kaddr;
+	*start_hash = le64_to_cpu(dentry->hash_code);
+	*end_hash = *start_hash;
+}
+
+/*
+ * ssdfs_check_found_dentry() - check found dentry
+ * @fsi: pointer on shared file system object
+ * @search: search object
+ * @kaddr: pointer on dentry object
+ * @item_index: index of the dentry
+ * @start_hash: pointer on start_hash value [out]
+ * @end_hash: pointer on end_hash value [out]
+ * @found_index: pointer on found index [out]
+ *
+ * This method tries to check the found dentry.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - corrupted dentry.
+ * %-EAGAIN     - continue the search.
+ * %-ENODATA    - possible place was found.
+ */
+static
+int ssdfs_check_found_dentry(struct ssdfs_fs_info *fsi,
+			     struct ssdfs_btree_search *search,
+			     void *kaddr,
+			     u16 item_index,
+			     u64 *start_hash,
+			     u64 *end_hash,
+			     u16 *found_index)
+{
+	struct ssdfs_dir_entry *dentry;
+	u64 hash_code;
+	u64 ino;
+	u8 type;
+	u8 flags;
+	u16 name_len;
+	u32 req_flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !kaddr || !found_index);
+	BUG_ON(!start_hash || !end_hash);
+
+	SSDFS_DBG("item_index %u\n", item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_hash = U64_MAX;
+	*end_hash = U64_MAX;
+	*found_index = U16_MAX;
+
+	dentry = (struct ssdfs_dir_entry *)kaddr;
+	hash_code = le64_to_cpu(dentry->hash_code);
+	ino = le64_to_cpu(dentry->ino);
+	type = dentry->dentry_type;
+	flags = dentry->flags;
+	name_len = le16_to_cpu(dentry->name_len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hash_code %llx, ino %llu, name_len %u\n",
+		  hash_code, ino, name_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	req_flags = search->request.flags;
+
+	if (type != SSDFS_REGULAR_DENTRY) {
+		SSDFS_ERR("corrupted dentry: "
+			  "hash_code %llx, ino %llu, "
+			  "type %#x, flags %#x\n",
+			  hash_code, ino,
+			  type, flags);
+		return -ERANGE;
+	}
+
+	if (flags & ~SSDFS_DENTRY_FLAGS_MASK) {
+		SSDFS_ERR("corrupted dentry: "
+			  "hash_code %llx, ino %llu, "
+			  "type %#x, flags %#x\n",
+			  hash_code, ino,
+			  type, flags);
+		return -ERANGE;
+	}
+
+	if (hash_code >= U64_MAX || ino >= U64_MAX) {
+		SSDFS_ERR("corrupted dentry: "
+			  "hash_code %llx, ino %llu, "
+			  "type %#x, flags %#x\n",
+			  hash_code, ino,
+			  type, flags);
+		return -ERANGE;
+	}
+
+	if (!(req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE)) {
+		SSDFS_ERR("invalid request: hash is absent\n");
+		return -ERANGE;
+	}
+
+	ssdfs_get_dentries_hash_range(kaddr, start_hash, end_hash);
+
+	err = ssdfs_check_dentry_for_request(fsi, dentry, search);
+	if (err == -ENODATA) {
+		search->result.state =
+			SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		search->result.err = err;
+		search->result.start_index = item_index;
+		search->result.count = 1;
+
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+		case SSDFS_BTREE_SEARCH_ADD_RANGE:
+		case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+			/* do nothing */
+			break;
+
+		default:
+			ssdfs_btree_search_free_result_buf(search);
+
+			search->result.buf_state =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+			search->result.buf = NULL;
+			search->result.buf_size = 0;
+			search->result.items_in_buffer = 0;
+			break;
+		}
+
+		*found_index = item_index;
+	} else if (err == -EAGAIN) {
+		/* continue to search */
+		err = 0;
+		*found_index = U16_MAX;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to check dentry: err %d\n",
+			  err);
+	} else {
+		*found_index = item_index;
+		search->result.state =
+			SSDFS_BTREE_SEARCH_VALID_ITEM;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "found_index %u\n",
+		  *start_hash, *end_hash,
+		  *found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_prepare_dentries_buffer() - prepare buffer for dentries
+ * @search: search object
+ * @found_index: found index of dentry
+ * @start_hash: starting hash
+ * @end_hash: ending hash
+ * @items_count: count of items in the sequence
+ * @item_size: size of the item
+ */
+static
+int ssdfs_prepare_dentries_buffer(struct ssdfs_btree_search *search,
+				  u16 found_index,
+				  u64 start_hash,
+				  u64 end_hash,
+				  u16 items_count,
+				  size_t item_size)
+{
+	u16 found_dentries = 0;
+	size_t buf_size = sizeof(struct ssdfs_raw_dentry);
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+
+	SSDFS_DBG("found_index %u, start_hash %llx, end_hash %llx, "
+		  "items_count %u, item_size %zu\n",
+		   found_index, start_hash, end_hash,
+		   items_count, item_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_btree_search_free_result_buf(search);
+
+	if (start_hash == end_hash) {
+		/* use inline buffer */
+		found_dentries = 1;
+	} else {
+		/* use external buffer */
+		if (found_index >= items_count) {
+			SSDFS_ERR("found_index %u >= items_count %u\n",
+				  found_index, items_count);
+			return -ERANGE;
+		}
+		found_dentries = items_count - found_index;
+	}
+
+	if (found_dentries == 1) {
+		search->result.buf_state =
+			SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+		search->result.buf = &search->raw.dentry;
+		search->result.buf_size = buf_size;
+		search->result.items_in_buffer = 0;
+
+		search->result.name_state =
+			SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+		search->result.name = &search->name;
+		search->result.name_string_size =
+			sizeof(struct ssdfs_name_string);
+		search->result.names_in_buffer = 0;
+	} else {
+		if (search->result.buf) {
+			SSDFS_WARN("search->result.buf %p, "
+				   "search->result.buf_state %#x\n",
+				   search->result.buf,
+				   search->result.buf_state);
+		}
+
+		err = ssdfs_btree_search_alloc_result_buf(search,
+						buf_size * found_dentries);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to allocate memory for buffer\n");
+			return err;
+		}
+
+		err = ssdfs_btree_search_alloc_result_name(search,
+				(size_t)found_dentries *
+					sizeof(struct ssdfs_name_string));
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to allocate memory for buffer\n");
+			ssdfs_btree_search_free_result_buf(search);
+			return err;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found_dentries %u, "
+		  "search->result.buf (buf_state %#x, "
+		  "buf_size %zu, items_in_buffer %u)\n",
+		  found_dentries,
+		  search->result.buf_state,
+		  search->result.buf_size,
+		  search->result.items_in_buffer);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_extract_found_dentry() - extract found dentry
+ * @fsi: pointer on shared file system object
+ * @search: search object
+ * @item_size: size of the item
+ * @kaddr: pointer on dentry
+ * @start_hash: pointer on start_hash value [out]
+ * @end_hash: pointer on end_hash value [out]
+ *
+ * This method tries to extract the found dentry.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_extract_found_dentry(struct ssdfs_fs_info *fsi,
+				struct ssdfs_btree_search *search,
+				size_t item_size,
+				void *kaddr,
+				u64 *start_hash,
+				u64 *end_hash)
+{
+	struct ssdfs_shared_dict_btree_info *dict;
+	struct ssdfs_dir_entry *dentry;
+	size_t buf_size = sizeof(struct ssdfs_raw_dentry);
+	struct ssdfs_name_string *name;
+	size_t name_size = sizeof(struct ssdfs_name_string);
+	u32 calculated;
+	u8 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !search || !kaddr);
+	BUG_ON(!start_hash || !end_hash);
+
+	SSDFS_DBG("kaddr %p\n", kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_hash = U64_MAX;
+	*end_hash = U64_MAX;
+
+	dict = fsi->shdictree;
+	if (!dict) {
+		SSDFS_ERR("shared dictionary is absent\n");
+		return -ERANGE;
+	}
+
+	calculated = search->result.items_in_buffer * buf_size;
+	if (calculated >= search->result.buf_size) {
+		SSDFS_ERR("calculated %u >= buf_size %zu, "
+			  "items_in_buffer %u\n",
+			  calculated, search->result.buf_size,
+			  search->result.items_in_buffer);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	dentry = (struct ssdfs_dir_entry *)kaddr;
+	ssdfs_get_dentries_hash_range(dentry, start_hash, end_hash);
+
+	err = ssdfs_memcpy(search->result.buf,
+			   calculated, search->result.buf_size,
+			   dentry, 0, item_size,
+			   item_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		return err;
+	}
+
+	search->result.items_in_buffer++;
+
+	flags = dentry->flags;
+	if (flags & SSDFS_DENTRY_HAS_EXTERNAL_STRING) {
+		calculated = search->result.names_in_buffer * name_size;
+		if (calculated >= search->result.name_string_size) {
+			SSDFS_ERR("calculated %u >= name_string_size %zu\n",
+				  calculated,
+				  search->result.name_string_size);
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!search->result.name);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		name = search->result.name + search->result.names_in_buffer;
+
+		err = ssdfs_shared_dict_get_name(dict, *start_hash, name);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the name: "
+				  "hash %llx, err %d\n",
+				  *start_hash, err);
+			return err;
+		}
+
+		search->result.names_in_buffer++;
+	}
+
+	search->result.count++;
+	search->result.state = SSDFS_BTREE_SEARCH_VALID_ITEM;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "search->result.count %u\n",
+		  *start_hash, *end_hash,
+		  search->result.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_extract_range_by_lookup_index() - extract a range of items
+ * @node: pointer on node object
+ * @lookup_index: lookup index for requested range
+ * @search: pointer on search request object
+ *
+ * This method tries to extract a range of items from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - requested range is out of the node.
+ */
+static
+int ssdfs_extract_range_by_lookup_index(struct ssdfs_btree_node *node,
+					u16 lookup_index,
+					struct ssdfs_btree_search *search)
+{
+	int capacity = SSDFS_DENTRIES_BTREE_LOOKUP_TABLE_SIZE;
+	size_t item_size = sizeof(struct ssdfs_dir_entry);
+
+	return __ssdfs_extract_range_by_lookup_index(node, lookup_index,
+						capacity, item_size,
+						search,
+						ssdfs_check_found_dentry,
+						ssdfs_prepare_dentries_buffer,
+						ssdfs_extract_found_dentry);
+}
-- 
2.34.1


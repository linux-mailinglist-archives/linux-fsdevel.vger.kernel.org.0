Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A2D78DA7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbjH3SgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244321AbjH3M6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:58:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E49CC5
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c1f7f7151fso17617915ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693400252; x=1694005052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d26r5h0CmoNOET0LiIs8p2rIU7MrnWiXaRawIuYer7M=;
        b=KweIXoJnWMLJ8OUXWAWhwDqHxJ4YL9vIQw/T006F7lfamNbqQZE9Mazy74A5aiG+09
         f56KLeLkH7l0CqUWqApnlb79bsIgaSiAGxnTnPbI3UbHHKbjGs0A2r5HJ/yIAFKBBt34
         0FV8gAQIHE+mtTDyvw2tLAv2/vIR3lDI2hrclPHzY7XaelCbg2cpS0C7tPHcm5YxNA4/
         5oGXC4d19e4b5MBHdVBTe6p3ENdfjJMC/gwP+k+dqdI806VGvTLONasvi4mFqaxquzsN
         A7Fsiu6sa3yjTaxf5JfPqtmNYsIKfpF3i9XeFI4oqz01YpEbxWxmOn6JVmRGvA2DT9/N
         ANxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400252; x=1694005052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d26r5h0CmoNOET0LiIs8p2rIU7MrnWiXaRawIuYer7M=;
        b=fGBmQ9DkNvcXyNd/CZ5mOci2BpDT8xiiIXJl7cUSl6AAkwwaGbPDIHMMKdV3J+xgkR
         J5+rO5/6LdYZgNcybGITVS0TJUdykNcgtr/mkoptMBnkV25u6nWSybAZeni27K68SVlm
         p2j0SQiNv9lZnRVOyjHC2ntLUA6VPmn+U7jIaGR460BrXMyRYT/DxuatjWe8jxPBvqvV
         iyGqqK0KaUhiuym7/HD6VTSd+UAfezbuT/pv7z3HLq/Wu3aJg7hWVKytTtVRZHUzoYFJ
         HkTWcgm9XTO2Ej1zOezVRok+mCYisHmfoYxtQvGHGlgn5U5cGPtzLi+kIAceGNODUdjw
         UJwQ==
X-Gm-Message-State: AOJu0YwD/7n+Gv0db3Tyt8LmXKakwFGCexmA9p1SGCcmZ/d1KWAvGpWD
        Xs1h7wjDAfGfyC46otGXFIzEdw==
X-Google-Smtp-Source: AGHT+IFlsKJ4gsggMjq3Qups2gBw5dyyMz0AGXGO84i6jUNMN2vnjaDbpUxjVunPZt/9zXz+SwW1rQ==
X-Received: by 2002:a17:902:edc7:b0:1bb:c5a9:6b26 with SMTP id q7-20020a170902edc700b001bbc5a96b26mr1834665plk.5.1693400252383;
        Wed, 30 Aug 2023 05:57:32 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b001bbd8cf6b57sm11023265plb.230.2023.08.30.05.57.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Aug 2023 05:57:32 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 2/6] maple_tree: Introduce interfaces __mt_dup() and mtree_dup()
Date:   Wed, 30 Aug 2023 20:56:50 +0800
Message-Id: <20230830125654.21257-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce interfaces __mt_dup() and mtree_dup(), which are used to
duplicate a maple tree. Compared with traversing the source tree and
reinserting entry by entry in the new tree, it has better performance.
The difference between __mt_dup() and mtree_dup() is that mtree_dup()
handles locks internally.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/maple_tree.h |   3 +
 lib/maple_tree.c           | 265 +++++++++++++++++++++++++++++++++++++
 2 files changed, 268 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e41c70ac7744..44fe8a57ecbd 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -327,6 +327,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
 		void *entry, gfp_t gfp);
 void *mtree_erase(struct maple_tree *mt, unsigned long index);
 
+int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
+int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
+
 void mtree_destroy(struct maple_tree *mt);
 void __mt_destroy(struct maple_tree *mt);
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ef234cf02e3e..8f841682269c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6370,6 +6370,271 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
 }
 EXPORT_SYMBOL(mtree_erase);
 
+/*
+ * mas_dup_free() - Free a half-constructed tree.
+ * @mas: Points to the last node of the half-constructed tree.
+ *
+ * This function frees all nodes starting from @mas->node in the reverse order
+ * of mas_dup_build(). There is no need to hold the source tree lock at this
+ * time.
+ */
+static void mas_dup_free(struct ma_state *mas)
+{
+	struct maple_node *node;
+	enum maple_type type;
+	void __rcu **slots;
+	unsigned char count, i;
+
+	/* Maybe the first node allocation failed. */
+	if (!mas->node)
+		return;
+
+	while (!mte_is_root(mas->node)) {
+		mas_ascend(mas);
+
+		if (mas->offset) {
+			mas->offset--;
+			do {
+				mas_descend(mas);
+				mas->offset = mas_data_end(mas);
+			} while (!mte_is_leaf(mas->node));
+
+			mas_ascend(mas);
+		}
+
+		node = mte_to_node(mas->node);
+		type = mte_node_type(mas->node);
+		slots = (void **)ma_slots(node, type);
+		count = mas_data_end(mas) + 1;
+		for (i = 0; i < count; i++)
+			((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
+
+		mt_free_bulk(count, slots);
+	}
+
+	node = mte_to_node(mas->node);
+	mt_free_one(node);
+}
+
+/*
+ * mas_copy_node() - Copy a maple node and allocate child nodes.
+ * @mas: Points to the source node.
+ * @new_mas: Points to the new node.
+ * @parent: The parent node of the new node.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * Copy @mas->node to @new_mas->node, set @parent to be the parent of
+ * @new_mas->node and allocate new child nodes for @new_mas->node.
+ * If memory allocation fails, @mas is set to -ENOMEM.
+ */
+static inline void mas_copy_node(struct ma_state *mas, struct ma_state *new_mas,
+		struct maple_node *parent, gfp_t gfp)
+{
+	struct maple_node *node = mte_to_node(mas->node);
+	struct maple_node *new_node = mte_to_node(new_mas->node);
+	enum maple_type type;
+	unsigned long val;
+	unsigned char request, count, i;
+	void __rcu **slots;
+	void __rcu **new_slots;
+
+	/* Copy the node completely. */
+	memcpy(new_node, node, sizeof(struct maple_node));
+
+	/* Update the parent node pointer. */
+	if (unlikely(ma_is_root(node)))
+		val = MA_ROOT_PARENT;
+	else
+		val = (unsigned long)node->parent & MAPLE_NODE_MASK;
+
+	new_node->parent = ma_parent_ptr(val | (unsigned long)parent);
+
+	if (mte_is_leaf(mas->node))
+		return;
+
+	/* Allocate memory for child nodes. */
+	type = mte_node_type(mas->node);
+	new_slots = ma_slots(new_node, type);
+	request = mas_data_end(mas) + 1;
+	count = mt_alloc_bulk(gfp, request, new_slots);
+	if (unlikely(count < request)) {
+		if (count)
+			mt_free_bulk(count, new_slots);
+		mas_set_err(mas, -ENOMEM);
+		return;
+	}
+
+	/* Restore node type information in slots. */
+	slots = ma_slots(node, type);
+	for (i = 0; i < count; i++)
+		((unsigned long *)new_slots)[i] |=
+			((unsigned long)mt_slot_locked(mas->tree, slots, i) &
+			MAPLE_NODE_MASK);
+}
+
+/*
+ * mas_dup_build() - Build a new maple tree from a source tree
+ * @mas: The maple state of source tree.
+ * @new_mas: The maple state of new tree.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * This function builds a new tree in DFS preorder. If the memory allocation
+ * fails, the error code -ENOMEM will be set in @mas, and @new_mas points to the
+ * last node. mas_dup_free() will free the half-constructed tree.
+ *
+ * Note that the attributes of the two trees must be exactly the same, and the
+ * new tree must be empty, otherwise -EINVAL will be returned.
+ */
+static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
+		gfp_t gfp)
+{
+	struct maple_node *node, *parent;
+	struct maple_enode *root;
+	enum maple_type type;
+
+	if (unlikely(mt_attr(mas->tree) != mt_attr(new_mas->tree)) ||
+	    unlikely(!mtree_empty(new_mas->tree))) {
+		mas_set_err(mas, -EINVAL);
+		return;
+	}
+
+	mas_start(mas);
+	if (mas_is_ptr(mas) || mas_is_none(mas)) {
+		/*
+		 * The attributes of the two trees must be the same before this.
+		 * The following assignment makes them the same height.
+		 */
+		new_mas->tree->ma_flags = mas->tree->ma_flags;
+		rcu_assign_pointer(new_mas->tree->ma_root, mas->tree->ma_root);
+		return;
+	}
+
+	node = mt_alloc_one(gfp);
+	if (!node) {
+		new_mas->node = NULL;
+		mas_set_err(mas, -ENOMEM);
+		return;
+	}
+
+	type = mte_node_type(mas->node);
+	root = mt_mk_node(node, type);
+	new_mas->node = root;
+	new_mas->min = 0;
+	new_mas->max = ULONG_MAX;
+	parent = ma_mnode_ptr(new_mas->tree);
+
+	while (1) {
+		mas_copy_node(mas, new_mas, parent, gfp);
+
+		if (unlikely(mas_is_err(mas)))
+			return;
+
+		/* Once we reach a leaf, we need to ascend, or end the loop. */
+		if (mte_is_leaf(mas->node)) {
+			if (mas->max == ULONG_MAX) {
+				new_mas->tree->ma_flags = mas->tree->ma_flags;
+				rcu_assign_pointer(new_mas->tree->ma_root,
+						   mte_mk_root(root));
+				break;
+			}
+
+			do {
+				/*
+				 * Must not at the root node, because we've
+				 * already end the loop when we reach the last
+				 * leaf.
+				 */
+				mas_ascend(mas);
+				mas_ascend(new_mas);
+			} while (mas->offset == mas_data_end(mas));
+
+			mas->offset++;
+			new_mas->offset++;
+		}
+
+		mas_descend(mas);
+		parent = mte_to_node(new_mas->node);
+		mas_descend(new_mas);
+		mas->offset = 0;
+		new_mas->offset = 0;
+	}
+}
+
+/**
+ * __mt_dup(): Duplicate a maple tree
+ * @mt: The source maple tree
+ * @new: The new maple tree
+ * @gfp: The GFP_FLAGS to use for allocations
+ *
+ * This function duplicates a maple tree using a faster method than traversing
+ * the source tree and inserting entries into the new tree one by one.
+ * The user needs to ensure that the attributes of the source tree and the new
+ * tree are the same, and the new tree needs to be an empty tree, otherwise
+ * -EINVAL will be returned.
+ * Note that the user needs to manually lock the source tree and the new tree.
+ *
+ * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
+ * the attributes of the two trees are different or the new tree is not an empty
+ * tree.
+ */
+int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
+{
+	int ret = 0;
+	MA_STATE(mas, mt, 0, 0);
+	MA_STATE(new_mas, new, 0, 0);
+
+	mas_dup_build(&mas, &new_mas, gfp);
+
+	if (unlikely(mas_is_err(&mas))) {
+		ret = xa_err(mas.node);
+		if (ret == -ENOMEM)
+			mas_dup_free(&new_mas);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(__mt_dup);
+
+/**
+ * mtree_dup(): Duplicate a maple tree
+ * @mt: The source maple tree
+ * @new: The new maple tree
+ * @gfp: The GFP_FLAGS to use for allocations
+ *
+ * This function duplicates a maple tree using a faster method than traversing
+ * the source tree and inserting entries into the new tree one by one.
+ * The user needs to ensure that the attributes of the source tree and the new
+ * tree are the same, and the new tree needs to be an empty tree, otherwise
+ * -EINVAL will be returned.
+ *
+ * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
+ * the attributes of the two trees are different or the new tree is not an empty
+ * tree.
+ */
+int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
+{
+	int ret = 0;
+	MA_STATE(mas, mt, 0, 0);
+	MA_STATE(new_mas, new, 0, 0);
+
+	mas_lock(&new_mas);
+	mas_lock(&mas);
+
+	mas_dup_build(&mas, &new_mas, gfp);
+	mas_unlock(&mas);
+
+	if (unlikely(mas_is_err(&mas))) {
+		ret = xa_err(mas.node);
+		if (ret == -ENOMEM)
+			mas_dup_free(&new_mas);
+	}
+
+	mas_unlock(&new_mas);
+
+	return ret;
+}
+EXPORT_SYMBOL(mtree_dup);
+
 /**
  * __mt_destroy() - Walk and free all nodes of a locked maple tree.
  * @mt: The maple tree
-- 
2.20.1


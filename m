Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE456A2663
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBYBTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBYBTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:09 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7948012F04
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:39 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s41so7201oiw.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ0lAmfuEaV7OCv59eNLIT6qasxQk2Pca2+gzhW7plc=;
        b=o6ForgXYdHq6e5QgTkk830RFhCSruv08DZHebfGnE8FLKv/+mQC9E32q1tCFwsLk5z
         vRY/viEexMnfKc3WxEsPl5JxHY//iC/Niano+aDpStnXT3k0rVFEqp1Hdp5UYgdEssYV
         pyZsyA9J0cAv93alUFKxVt+LY5rDWg7wpWVwhUhh7o1TK97vQKRqAricaNbiq7BOxc7v
         8IDbWdLd4qu8TnibraLTfCQvR03sy4jmYcEjYirAmafVUf+s823A6ktCnPIpw2Gh3x6c
         4y7v8AVljgOiMLLCDm6WNUTc2GkihliUpDKGbFMfTR9qVo6kwBgWTcR0o1ubw7/w2e0D
         ySsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ0lAmfuEaV7OCv59eNLIT6qasxQk2Pca2+gzhW7plc=;
        b=hrwBsT52NQwQOAG9s2T0NeV173K6QALfTrST7HTUUTnSHzaYoDLE9ZO0tH0vU71V2G
         SyyZupyCY1IGtqd42Ea+IvNvWqeN0tOff7t9M8tOd5rxLWRZg/WIPO7OzmxSRJ8JbUoI
         ipYO2blz+qU1wGF/wnof+eN1XIweMeKcGe1bgBRbr6OVxv5VcrsEY53gjMIVZgmSd0ID
         l+YCLGBEz0c7RhdJr3B9CpVvICqB4+an755qeS241Dplip8Vb4MAJnBfyeaRnIaVa/w0
         lHI9iQdfwlE8O9GFd8UDcFglTjXJy7kihgPuU29Fs4noAiDdwEloWWT8Hp+y1b/oTQD8
         WgBg==
X-Gm-Message-State: AO0yUKXRrQM/LEjcoCy9zfh+c7R4xqcqmN+sVJPt1D46lMcfLgB+ozGh
        8xkFypL/5dpjNSC3k+aiSmDTqie4ILQO3Ii8
X-Google-Smtp-Source: AK7set8WzwErCjNbCoeQkzBcsfS9JYTfTBiS/AG9FKbcfahaj3/VjhsqjkDa7yFAgaSBDNVoAZwSlw==
X-Received: by 2002:a54:4803:0:b0:37d:69cf:b6a0 with SMTP id j3-20020a544803000000b0037d69cfb6a0mr7991628oij.30.1677287857909;
        Fri, 24 Feb 2023 17:17:37 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:36 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 58/76] ssdfs: check b-tree hierarchy for update/delete operation
Date:   Fri, 24 Feb 2023 17:09:09 -0800
Message-Id: <20230225010927.813929-59-slava@dubeyko.com>
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

Every b-tree node has associated hash value that represents
starting hash value of records sequence in the node. This hash
value is stored in index key that keeps parent node. Finally,
hash values are used for search items in the b-tree.
If modification operation changes starting hash value in
the node, then index key in parent node has to be updated.
The checking logic identifies all parent nodes that requires
index keys update. As a result, modification logic executes
index keys update in all parent nodes that were selected for
update by checking logic. Delete operation requires to identify
which nodes are empty and should be deleted/invalidated.
This invalidation plan is executed by modification logic,
finally.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree_hierarchy.c | 1896 ++++++++++++++++++++++++++++++++++++
 1 file changed, 1896 insertions(+)

diff --git a/fs/ssdfs/btree_hierarchy.c b/fs/ssdfs/btree_hierarchy.c
index 6e9f91ed4541..3c1444732019 100644
--- a/fs/ssdfs/btree_hierarchy.c
+++ b/fs/ssdfs/btree_hierarchy.c
@@ -5653,3 +5653,1899 @@ int ssdfs_btree_check_hierarchy_for_add(struct ssdfs_btree *tree,
 
 	return res;
 }
+
+/*
+ * ssdfs_btree_check_level_for_delete() - check btree's level for node deletion
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the level of btree for node deletion.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_level_for_delete(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node, *child_node;
+	u16 index_count, items_count;
+	u64 hash;
+	u64 parent_start_hash, parent_end_hash;
+	u64 child_start_hash, child_end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search || !parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p, parent %p, child %p\n",
+		  tree, search, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("node is NULL\n");
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&child_node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+		/* do nothing */
+		return 0;
+
+	default:
+		if (!parent_node) {
+			SSDFS_ERR("node is NULL\n");
+			return -ERANGE;
+		}
+	}
+
+	if (child->flags & SSDFS_BTREE_LEVEL_DELETE_NODE) {
+		parent->flags |= SSDFS_BTREE_LEVEL_DELETE_INDEX;
+
+		switch (atomic_read(&parent_node->type)) {
+		case SSDFS_BTREE_ROOT_NODE:
+		case SSDFS_BTREE_HYBRID_NODE:
+		case SSDFS_BTREE_INDEX_NODE:
+			/* expected type */
+			break;
+
+		default:
+			SSDFS_ERR("invalid parent node type %#x\n",
+				  atomic_read(&parent_node->type));
+			return -ERANGE;
+		}
+
+		parent->index_area.delete.op_state =
+				SSDFS_BTREE_AREA_OP_REQUESTED;
+
+		spin_lock(&child_node->descriptor_lock);
+		ssdfs_memcpy(&parent->index_area.delete.node_index,
+			     0, sizeof(struct ssdfs_btree_index_key),
+			     &child_node->node_index,
+			     0, sizeof(struct ssdfs_btree_index_key),
+			     sizeof(struct ssdfs_btree_index_key));
+		spin_unlock(&child_node->descriptor_lock);
+
+		down_read(&parent_node->header_lock);
+		index_count = parent_node->index_area.index_count;
+		items_count = parent_node->items_area.items_count;
+		if (index_count <= 1 && items_count == 0)
+			parent->flags |= SSDFS_BTREE_LEVEL_DELETE_NODE;
+		up_read(&parent_node->header_lock);
+	} else if (child->flags & SSDFS_BTREE_LEVEL_DELETE_INDEX) {
+		struct ssdfs_btree_node_delete *delete;
+
+		delete = &child->index_area.delete;
+
+		if (delete->op_state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+			SSDFS_ERR("invalid operation state %#x\n",
+				  delete->op_state);
+			return -ERANGE;
+		}
+
+		hash = le64_to_cpu(delete->node_index.index.hash);
+
+		down_read(&child_node->header_lock);
+		child_start_hash = child_node->index_area.start_hash;
+		child_end_hash = child_node->index_area.end_hash;
+		up_read(&child_node->header_lock);
+
+		if (hash == child_start_hash || hash == child_end_hash) {
+			parent->flags |= SSDFS_BTREE_LEVEL_UPDATE_INDEX;
+
+			/*
+			 * Simply add flag.
+			 * Maybe it will need to add additional code.
+			 */
+		}
+	} else if (child->flags & SSDFS_BTREE_LEVEL_UPDATE_INDEX) {
+		down_read(&parent_node->header_lock);
+		parent_start_hash = parent_node->index_area.start_hash;
+		parent_end_hash = parent_node->index_area.end_hash;
+		up_read(&parent_node->header_lock);
+
+		down_read(&child_node->header_lock);
+		child_start_hash = child_node->index_area.start_hash;
+		child_end_hash = child_node->index_area.end_hash;
+		up_read(&child_node->header_lock);
+
+		if (child_start_hash == parent_start_hash ||
+		    child_start_hash == parent_end_hash) {
+			/* set update index flag */
+			parent->flags |= SSDFS_BTREE_LEVEL_UPDATE_INDEX;
+		} else if (child_end_hash == parent_start_hash ||
+			   child_end_hash == parent_end_hash) {
+			/* set update index flag */
+			parent->flags |= SSDFS_BTREE_LEVEL_UPDATE_INDEX;
+		} else {
+			err = ssdfs_btree_prepare_do_nothing(parent,
+							     parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare index node: "
+					  "err %d\n", err);
+				return err;
+			}
+		}
+	} else {
+		err = ssdfs_btree_prepare_do_nothing(parent,
+						     parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare index node: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_hierarchy_for_delete() - check the btree for node deletion
+ * @tree: btree object
+ * @search: search object
+ * @hierarchy: btree's hierarchy object
+ *
+ * This method tries to check the btree's hierarchy for operation of
+ * node deletion.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_check_hierarchy_for_delete(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_hierarchy *hierarchy)
+{
+	struct ssdfs_btree_level *level;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	int child_node_height, cur_height, tree_height;
+	int parent_node_type, child_node_type;
+	spinlock_t *lock = NULL;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search || !hierarchy);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, search %p, hierarchy %p\n",
+		  tree, search, hierarchy);
+#else
+	SSDFS_DBG("tree %p, search %p, hierarchy %p\n",
+		  tree, search, hierarchy);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height == 0) {
+		SSDFS_ERR("invalid tree_height %u\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	if (search->node.id == SSDFS_BTREE_ROOT_NODE_ID) {
+		SSDFS_ERR("root node cannot be deleted\n");
+		return -ERANGE;
+	} else {
+		child_node = search->node.child;
+
+		lock = &child_node->descriptor_lock;
+		spin_lock(lock);
+		parent_node = child_node->parent_node;
+		spin_unlock(lock);
+		lock = NULL;
+
+		if (!child_node || !parent_node) {
+			SSDFS_ERR("invalid search object state: "
+				  "child_node %p, parent_node %p\n",
+				  child_node, parent_node);
+			return -ERANGE;
+		}
+
+		parent_node_type = atomic_read(&parent_node->type);
+		child_node_type = atomic_read(&child_node->type);
+		child_node_height = atomic_read(&child_node->height);
+	}
+
+	cur_height = child_node_height;
+	if (cur_height >= tree_height) {
+		SSDFS_ERR("cur_height %u >= tree_height %u\n",
+			  cur_height, tree_height);
+		return -ERANGE;
+	}
+
+	if ((cur_height + 1) >= hierarchy->desc.height ||
+	    (cur_height + 1) >= tree_height) {
+		SSDFS_ERR("invalid hierarchy: "
+			  "tree_height %u, cur_height %u, "
+			  "hierarchy->desc.height %u\n",
+			  tree_height, cur_height,
+			  hierarchy->desc.height);
+		return -ERANGE;
+	}
+
+	level = hierarchy->array_ptr[cur_height];
+	level->nodes.old_node.type = child_node_type;
+	level->nodes.old_node.ptr = child_node;
+	ssdfs_btree_hierarchy_init_hash_range(level, child_node);
+	level->flags |= SSDFS_BTREE_LEVEL_DELETE_NODE;
+
+	cur_height++;
+	level = hierarchy->array_ptr[cur_height];
+	level->nodes.old_node.type = parent_node_type;
+	level->nodes.old_node.ptr = parent_node;
+	ssdfs_btree_hierarchy_init_hash_range(level, parent_node);
+
+	cur_height++;
+	lock = &parent_node->descriptor_lock;
+	spin_lock(lock);
+	parent_node = parent_node->parent_node;
+	spin_unlock(lock);
+	lock = NULL;
+	for (; cur_height < tree_height; cur_height++) {
+		if (!parent_node) {
+			SSDFS_ERR("parent node is NULL\n");
+			return -ERANGE;
+		}
+
+		parent_node_type = atomic_read(&parent_node->type);
+		level = hierarchy->array_ptr[cur_height];
+		level->nodes.old_node.type = parent_node_type;
+		level->nodes.old_node.ptr = parent_node;
+		ssdfs_btree_hierarchy_init_hash_range(level, parent_node);
+
+		lock = &parent_node->descriptor_lock;
+		spin_lock(lock);
+		parent_node = parent_node->parent_node;
+		spin_unlock(lock);
+		lock = NULL;
+	}
+
+	cur_height = child_node_height;
+	for (; cur_height < tree_height; cur_height++) {
+		struct ssdfs_btree_level *parent;
+		struct ssdfs_btree_level *child;
+
+		parent = hierarchy->array_ptr[cur_height + 1];
+		child = hierarchy->array_ptr[cur_height];
+
+		err = ssdfs_btree_check_level_for_delete(tree, search,
+							 parent, child);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to check btree's level: "
+				  "cur_height %u, tree_height %u, "
+				  "err %d\n",
+				  cur_height, tree_height, err);
+			return err;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_level_for_update() - check btree's level for index update
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the level of btree for index update.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_level_for_update(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node, *child_node;
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search || !parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p, parent %p, child %p\n",
+		  tree, search, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	child_node = child->nodes.old_node.ptr;
+	if (!child_node) {
+		SSDFS_ERR("child node is NULL\n");
+		return -ERANGE;
+	}
+
+	if (child_node->node_id == SSDFS_BTREE_ROOT_NODE_ID) {
+		SSDFS_DBG("nothing should be done for the root node\n");
+		return 0;
+	}
+
+	parent_node = parent->nodes.old_node.ptr;
+	if (!parent_node) {
+		SSDFS_ERR("parent node is NULL\n");
+		return -ERANGE;
+	}
+
+	state = atomic_read(&parent_node->index_area.state);
+	if (state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		SSDFS_ERR("parent node %u hasn't index area\n",
+			  parent_node->node_id);
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&child_node->type)) {
+	case SSDFS_BTREE_LEAF_NODE:
+		state = atomic_read(&child_node->items_area.state);
+		if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+			SSDFS_ERR("child node %u hasn't items area\n",
+				  child_node->node_id);
+			return -ERANGE;
+		}
+
+		/* set necessity to update the parent's index */
+		parent->flags |= SSDFS_BTREE_LEVEL_UPDATE_INDEX;
+		break;
+
+	default:
+		state = atomic_read(&child_node->index_area.state);
+		if (state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+			SSDFS_ERR("child node %u hasn't index area\n",
+				  child_node->node_id);
+			return -ERANGE;
+		}
+
+		/* set necessity to update the parent's index */
+		parent->flags |= SSDFS_BTREE_LEVEL_UPDATE_INDEX;
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_hierarchy_for_update() - check the btree for index update
+ * @tree: btree object
+ * @search: search object
+ * @hierarchy: btree's hierarchy object
+ *
+ * This method tries to check the btree's hierarchy for operation of
+ * index update.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_check_hierarchy_for_update(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_hierarchy *hierarchy)
+{
+	struct ssdfs_btree_level *level;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	int child_node_height, cur_height, tree_height;
+	int parent_node_type, child_node_type;
+	spinlock_t *lock;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search || !hierarchy);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, search %p, hierarchy %p\n",
+		  tree, search, hierarchy);
+#else
+	SSDFS_DBG("tree %p, search %p, hierarchy %p\n",
+		  tree, search, hierarchy);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height == 0) {
+		SSDFS_ERR("invalid tree_height %u\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	if (search->node.id == SSDFS_BTREE_ROOT_NODE_ID) {
+		SSDFS_ERR("parent node is absent\n");
+		return -ERANGE;
+	} else {
+		child_node = search->node.child;
+
+		lock = &child_node->descriptor_lock;
+		spin_lock(lock);
+		parent_node = child_node->parent_node;
+		spin_unlock(lock);
+		lock = NULL;
+
+		if (!child_node || !parent_node) {
+			SSDFS_ERR("invalid search object state: "
+				  "child_node %p, parent_node %p\n",
+				  child_node, parent_node);
+			return -ERANGE;
+		}
+
+		parent_node_type = atomic_read(&parent_node->type);
+		child_node_type = atomic_read(&child_node->type);
+		child_node_height = atomic_read(&child_node->height);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("child_node %px, child_node_id %u, child_node_type %#x\n",
+		  child_node, child_node->node_id, child_node_type);
+	SSDFS_DBG("parent_node %px, parent_node_id %u, parent_node_type %#x\n",
+		  parent_node, parent_node->node_id, parent_node_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cur_height = child_node_height;
+	if (cur_height >= tree_height) {
+		SSDFS_ERR("cur_height %u >= tree_height %u\n",
+			  cur_height, tree_height);
+		return -ERANGE;
+	}
+
+	if ((cur_height + 1) >= hierarchy->desc.height ||
+	    (cur_height + 1) >= tree_height) {
+		SSDFS_ERR("invalid hierarchy: "
+			  "tree_height %u, cur_height %u, "
+			  "hierarchy->desc.height %u\n",
+			  tree_height, cur_height,
+			  hierarchy->desc.height);
+		return -ERANGE;
+	}
+
+	level = hierarchy->array_ptr[cur_height];
+	level->nodes.old_node.type = child_node_type;
+	level->nodes.old_node.ptr = child_node;
+	ssdfs_btree_hierarchy_init_hash_range(level, child_node);
+
+	cur_height++;
+	level = hierarchy->array_ptr[cur_height];
+	level->nodes.old_node.type = parent_node_type;
+	level->nodes.old_node.ptr = parent_node;
+	ssdfs_btree_hierarchy_init_hash_range(level, parent_node);
+	level->flags |= SSDFS_BTREE_LEVEL_UPDATE_INDEX;
+
+	cur_height++;
+	lock = &parent_node->descriptor_lock;
+	spin_lock(lock);
+	parent_node = parent_node->parent_node;
+	spin_unlock(lock);
+	lock = NULL;
+	for (; cur_height < tree_height; cur_height++) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cur_height %d, tree_height %d, parent_node %px\n",
+			  cur_height, tree_height, parent_node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (!parent_node) {
+			SSDFS_ERR("parent node is NULL\n");
+			return -ERANGE;
+		}
+
+		parent_node_type = atomic_read(&parent_node->type);
+		level = hierarchy->array_ptr[cur_height];
+		level->nodes.old_node.type = parent_node_type;
+		level->nodes.old_node.ptr = parent_node;
+		ssdfs_btree_hierarchy_init_hash_range(level, parent_node);
+
+		lock = &parent_node->descriptor_lock;
+		spin_lock(lock);
+		parent_node = parent_node->parent_node;
+		spin_unlock(lock);
+		lock = NULL;
+	}
+
+	cur_height = child_node_height;
+	for (; cur_height < tree_height; cur_height++) {
+		struct ssdfs_btree_level *parent;
+		struct ssdfs_btree_level *child;
+
+		parent = hierarchy->array_ptr[cur_height + 1];
+		child = hierarchy->array_ptr[cur_height];
+
+		err = ssdfs_btree_check_level_for_update(tree, search,
+							 parent, child);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to check btree's level: "
+				  "cur_height %u, tree_height %u, "
+				  "err %d\n",
+				  cur_height, tree_height, err);
+			return err;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+static
+int ssdfs_btree_update_index_after_move(struct ssdfs_btree_level *child,
+					struct ssdfs_btree_node *parent_node);
+
+/*
+ * ssdfs_btree_move_items_left() - move head items from old to new node
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to move the head items from the old node into
+ * new one.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_move_items_left(struct ssdfs_btree_state_descriptor *desc,
+				struct ssdfs_btree_level *parent,
+				struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node;
+	struct ssdfs_btree_node *old_node;
+	struct ssdfs_btree_node *new_node;
+	int type;
+	u32 calculated;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !parent || !child);
+
+	if (!(child->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE &&
+	      child->items_area.move.direction == SSDFS_BTREE_MOVE_TO_LEFT)) {
+		SSDFS_WARN("invalid move request: "
+			   "flags %#x, direction %#x\n",
+			   child->flags,
+			   child->items_area.move.direction);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("desc %p, child %p\n",
+		  desc, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("fail to move items: "
+			  "parent_node %p\n",
+			  parent_node);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&parent_node->type);
+
+	switch (type) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("parent node has improper type: "
+			  "node_id %u, type %#x\n",
+			  parent_node->node_id, type);
+		return -ERANGE;
+	}
+
+	if (child->items_area.move.op_state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  child->items_area.move.op_state);
+		return -ERANGE;
+	} else
+		child->items_area.move.op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	old_node = child->nodes.old_node.ptr;
+	new_node = child->nodes.new_node.ptr;
+
+	if (!old_node || !new_node) {
+		SSDFS_ERR("fail to move items: "
+			  "old_node %p, new_node %p\n",
+			  old_node, new_node);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&old_node->type);
+	switch (type) {
+	case SSDFS_BTREE_LEAF_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("old node is not leaf node: "
+			  "node_id %u, type %#x\n",
+			  old_node->node_id, type);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&new_node->type);
+
+	switch (type) {
+	case SSDFS_BTREE_LEAF_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("new node is not leaf node: "
+			  "node_id %u, type %#x\n",
+			  new_node->node_id, type);
+		return -ERANGE;
+	}
+
+	switch (child->items_area.move.pos.state) {
+	case SSDFS_HASH_RANGE_INTERSECTION:
+	case SSDFS_HASH_RANGE_OUT_OF_NODE:
+		if (child->items_area.move.pos.start != 0) {
+			SSDFS_ERR("invalid position's start %u\n",
+				  child->items_area.move.pos.start);
+			return -ERANGE;
+		}
+
+		if (child->items_area.move.pos.count == 0) {
+			SSDFS_ERR("invalid position's count %u\n",
+				  child->items_area.move.pos.count);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid position's state %#x\n",
+			  child->items_area.move.pos.state);
+		return -ERANGE;
+	}
+
+	calculated = child->items_area.move.pos.count * desc->min_item_size;
+	if (calculated >= desc->node_size) {
+		SSDFS_ERR("invalid position: "
+			  "count %u, min_item_size %u, node_size %u\n",
+			  child->items_area.move.pos.count,
+			  desc->min_item_size,
+			  desc->node_size);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_move_items_range(old_node, new_node,
+					child->items_area.move.pos.start,
+					child->items_area.move.pos.count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move items range: "
+			  "src_node %u, dst_node %u, "
+			  "start_item %u, count %u, "
+			  "err %d\n",
+			  old_node->node_id,
+			  new_node->node_id,
+			  child->items_area.move.pos.start,
+			  child->items_area.move.pos.count,
+			  err);
+		return err;
+	}
+
+	down_read(&old_node->header_lock);
+	child->index_area.hash.start = old_node->index_area.start_hash;
+	child->index_area.hash.end = old_node->index_area.end_hash;
+	child->items_area.hash.start = old_node->items_area.start_hash;
+	child->items_area.hash.end = old_node->items_area.end_hash;
+	up_read(&old_node->header_lock);
+
+	err = ssdfs_btree_update_index_after_move(child, parent_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update indexes in parent: err %d\n",
+			  err);
+		return err;
+	}
+
+	child->items_area.move.op_state = SSDFS_BTREE_AREA_OP_DONE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("src_node %u, dst_node %u, "
+		  "start_item %u, count %u\n",
+		  old_node->node_id,
+		  new_node->node_id,
+		  child->items_area.move.pos.start,
+		  child->items_area.move.pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_move_items_right() - move tail items from old to new node
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to move the tail items from the old node into
+ * new one.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_move_items_right(struct ssdfs_btree_state_descriptor *desc,
+				 struct ssdfs_btree_level *parent,
+				 struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node;
+	struct ssdfs_btree_node *old_node;
+	struct ssdfs_btree_node *new_node;
+	int type;
+	u32 calculated;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !parent || !child);
+
+	if (!(child->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE &&
+	      child->items_area.move.direction == SSDFS_BTREE_MOVE_TO_RIGHT)) {
+		SSDFS_WARN("invalid move request: "
+			   "flags %#x, direction %#x\n",
+			   child->flags,
+			   child->items_area.move.direction);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("desc %p, child %p\n",
+		  desc, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("fail to move items: "
+			  "parent_node %p\n",
+			  parent_node);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&parent_node->type);
+	switch (type) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("parent node has improper type: "
+			  "node_id %u, type %#x\n",
+			  parent_node->node_id, type);
+		return -ERANGE;
+	}
+
+	if (child->items_area.move.op_state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  child->items_area.move.op_state);
+		return -ERANGE;
+	} else
+		child->items_area.move.op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	old_node = child->nodes.old_node.ptr;
+	new_node = child->nodes.new_node.ptr;
+
+	if (!old_node || !new_node) {
+		SSDFS_ERR("fail to move items: "
+			  "old_node %p, new_node %p\n",
+			  old_node, new_node);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&old_node->type);
+	switch (type) {
+	case SSDFS_BTREE_LEAF_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("old node is not leaf node: "
+			  "node_id %u, type %#x\n",
+			  old_node->node_id, type);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&new_node->type);
+	switch (type) {
+	case SSDFS_BTREE_LEAF_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("new node is not leaf node: "
+			  "node_id %u, type %#x\n",
+			  new_node->node_id, type);
+		return -ERANGE;
+	}
+
+	switch (child->items_area.move.pos.state) {
+	case SSDFS_HASH_RANGE_INTERSECTION:
+	case SSDFS_HASH_RANGE_OUT_OF_NODE:
+		if (child->items_area.move.pos.count == 0) {
+			SSDFS_ERR("invalid position's count %u\n",
+				  child->items_area.move.pos.count);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid position's state %#x\n",
+			  child->items_area.move.pos.state);
+		return -ERANGE;
+	}
+
+	calculated = child->items_area.move.pos.count * desc->min_item_size;
+	if (calculated >= desc->node_size) {
+		SSDFS_ERR("invalid position: "
+			  "count %u, min_item_size %u, node_size %u\n",
+			  child->items_area.move.pos.count,
+			  desc->min_item_size,
+			  desc->node_size);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_move_items_range(old_node, new_node,
+					child->items_area.move.pos.start,
+					child->items_area.move.pos.count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move items range: "
+			  "src_node %u, dst_node %u, "
+			  "start_item %u, count %u, "
+			  "err %d\n",
+			  old_node->node_id,
+			  new_node->node_id,
+			  child->items_area.move.pos.start,
+			  child->items_area.move.pos.count,
+			  err);
+		return err;
+	}
+
+	down_read(&old_node->header_lock);
+	child->index_area.hash.start = old_node->index_area.start_hash;
+	child->index_area.hash.end = old_node->index_area.end_hash;
+	child->items_area.hash.start = old_node->items_area.start_hash;
+	child->items_area.hash.end = old_node->items_area.end_hash;
+	up_read(&old_node->header_lock);
+
+	err = ssdfs_btree_update_index_after_move(child, parent_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update indexes in parent: err %d\n",
+			  err);
+		return err;
+	}
+
+	child->items_area.move.op_state = SSDFS_BTREE_AREA_OP_DONE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("src_node %u, dst_node %u, "
+		  "start_item %u, count %u\n",
+		  old_node->node_id,
+		  new_node->node_id,
+		  child->items_area.move.pos.start,
+		  child->items_area.move.pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_move_items_parent2child() - move items from parent to child node
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to move items from the parent node into
+ * child one.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static int
+ssdfs_btree_move_items_parent2child(struct ssdfs_btree_state_descriptor *desc,
+				    struct ssdfs_btree_level *parent,
+				    struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node;
+	struct ssdfs_btree_node *child_node;
+	int type;
+	u32 calculated;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !parent || !child);
+
+	if (!(parent->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE &&
+	      parent->items_area.move.direction == SSDFS_BTREE_MOVE_TO_CHILD)) {
+		SSDFS_WARN("invalid move request: "
+			   "flags %#x, direction %#x\n",
+			   parent->flags,
+			   parent->items_area.move.direction);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("desc %p, parent %p, child %p\n",
+		  desc, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent->items_area.move.op_state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  parent->items_area.move.op_state);
+		return -ERANGE;
+	} else
+		parent->items_area.move.op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE)
+		child_node = child->nodes.new_node.ptr;
+	else
+		child_node = child->nodes.old_node.ptr;
+
+	if (!parent_node || !child_node) {
+		SSDFS_ERR("fail to move items: "
+			  "parent_node %p, child_node %p\n",
+			  parent_node, child_node);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&parent_node->type);
+	if (type != SSDFS_BTREE_HYBRID_NODE) {
+		SSDFS_ERR("parent node has improper type: "
+			  "node_id %u, type %#x\n",
+			  parent_node->node_id, type);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&child_node->type);
+	switch (type) {
+	case SSDFS_BTREE_LEAF_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("child node has improper type: "
+			  "node_id %u, type %#x\n",
+			  child_node->node_id, type);
+		return -ERANGE;
+	}
+
+	switch (parent->items_area.move.pos.state) {
+	case SSDFS_HASH_RANGE_INTERSECTION:
+		if (parent->items_area.move.pos.count == 0) {
+			SSDFS_ERR("invalid position's count %u\n",
+				  parent->items_area.move.pos.count);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid position's state %#x\n",
+			  parent->items_area.move.pos.state);
+		return -ERANGE;
+	}
+
+	calculated = parent->items_area.move.pos.count * desc->min_item_size;
+
+	if (calculated >= desc->node_size) {
+		SSDFS_ERR("invalid position: "
+			  "count %u, min_item_size %u, node_size %u\n",
+			  parent->items_area.move.pos.count,
+			  desc->min_item_size,
+			  desc->node_size);
+		return -ERANGE;
+	}
+
+	if (!(child->flags & SSDFS_BTREE_LEVEL_ADD_NODE) &&
+	    calculated > child->items_area.free_space) {
+		SSDFS_ERR("child has not enough free space: "
+			  "calculated %u, free_space %u\n",
+			  calculated,
+			  child->items_area.free_space);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_move_items_range(parent_node, child_node,
+					parent->items_area.move.pos.start,
+					parent->items_area.move.pos.count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move items range: "
+			  "src_node %u, dst_node %u, "
+			  "start_item %u, count %u, "
+			  "err %d\n",
+			  parent_node->node_id,
+			  child_node->node_id,
+			  parent->items_area.move.pos.start,
+			  parent->items_area.move.pos.count,
+			  err);
+		return err;
+	}
+
+	down_read(&child_node->header_lock);
+
+	switch (atomic_read(&child_node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		child->index_area.area_size = child_node->index_area.area_size;
+		calculated = child_node->index_area.index_capacity;
+		calculated -= child_node->index_area.index_count;
+		calculated *= child_node->index_area.index_size;
+		child->index_area.free_space = calculated;
+		child->index_area.hash.start =
+				child_node->index_area.start_hash;
+		child->index_area.hash.end =
+				child_node->index_area.end_hash;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	switch (atomic_read(&child_node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		child->items_area.area_size = child_node->items_area.area_size;
+		child->items_area.free_space =
+					child_node->items_area.free_space;
+		child->items_area.hash.start =
+				child_node->items_area.start_hash;
+		child->items_area.hash.end =
+				child_node->items_area.end_hash;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	up_read(&child_node->header_lock);
+
+	down_read(&parent_node->header_lock);
+
+	switch (atomic_read(&parent_node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		parent->index_area.area_size =
+			parent_node->index_area.area_size;
+		calculated = parent_node->index_area.index_capacity;
+		calculated -= parent_node->index_area.index_count;
+		calculated *= parent_node->index_area.index_size;
+		parent->index_area.free_space = calculated;
+		parent->index_area.hash.start =
+				parent_node->index_area.start_hash;
+		parent->index_area.hash.end =
+				parent_node->index_area.end_hash;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	switch (atomic_read(&parent_node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		parent->items_area.area_size =
+					parent_node->items_area.area_size;
+		parent->items_area.free_space =
+					parent_node->items_area.free_space;
+		parent->items_area.hash.start =
+				parent_node->items_area.start_hash;
+		parent->items_area.hash.end =
+				parent_node->items_area.end_hash;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	up_read(&parent_node->header_lock);
+
+	parent->items_area.move.op_state = SSDFS_BTREE_AREA_OP_DONE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("src_node %u, dst_node %u, "
+		  "start_item %u, count %u\n",
+		  parent_node->node_id,
+		  child_node->node_id,
+		  parent->items_area.move.pos.start,
+		  parent->items_area.move.pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_move_items_child2parent() - move items from child to parent node
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to move items from the child node into
+ * parent one.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static int
+ssdfs_btree_move_items_child2parent(struct ssdfs_btree_state_descriptor *desc,
+				    struct ssdfs_btree_level *parent,
+				    struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node;
+	struct ssdfs_btree_node *child_node;
+	int type;
+	u32 calculated;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !parent || !child);
+
+	if (!(child->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE &&
+	      child->items_area.move.direction == SSDFS_BTREE_MOVE_TO_PARENT)) {
+		SSDFS_WARN("invalid move request: "
+			   "flags %#x, direction %#x\n",
+			   parent->flags,
+			   parent->items_area.move.direction);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("desc %p, parent %p, child %p\n",
+		  desc, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (child->items_area.move.op_state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  parent->items_area.move.op_state);
+		return -ERANGE;
+	} else
+		child->items_area.move.op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	if (parent->flags & SSDFS_BTREE_LEVEL_ADD_NODE)
+		parent_node = parent->nodes.new_node.ptr;
+	else
+		parent_node = parent->nodes.old_node.ptr;
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!parent_node || !child_node) {
+		SSDFS_ERR("fail to move items: "
+			  "parent_node %p, child_node %p\n",
+			  parent_node, child_node);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&parent_node->type);
+	if (type != SSDFS_BTREE_HYBRID_NODE) {
+		SSDFS_ERR("parent node has improper type: "
+			  "node_id %u, type %#x\n",
+			  parent_node->node_id, type);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&child_node->type);
+	switch (type) {
+	case SSDFS_BTREE_LEAF_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("child node has improper type: "
+			  "node_id %u, type %#x\n",
+			  child_node->node_id, type);
+		return -ERANGE;
+	}
+
+	switch (child->items_area.move.pos.state) {
+	case SSDFS_HASH_RANGE_INTERSECTION:
+		if (child->items_area.move.pos.count == 0) {
+			SSDFS_ERR("invalid position's count %u\n",
+				  child->items_area.move.pos.count);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid position's state %#x\n",
+			  child->items_area.move.pos.state);
+		return -ERANGE;
+	}
+
+	calculated = child->items_area.move.pos.count * desc->min_item_size;
+
+	if (calculated >= desc->node_size) {
+		SSDFS_ERR("invalid position: "
+			  "count %u, min_item_size %u, node_size %u\n",
+			  child->items_area.move.pos.count,
+			  desc->min_item_size,
+			  desc->node_size);
+		return -ERANGE;
+	}
+
+	if (!(parent->flags & SSDFS_BTREE_LEVEL_ADD_NODE) &&
+	    calculated > parent->items_area.free_space) {
+		SSDFS_ERR("child has not enough free space: "
+			  "calculated %u, free_space %u\n",
+			  calculated,
+			  parent->items_area.free_space);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_move_items_range(child_node, parent_node,
+					child->items_area.move.pos.start,
+					child->items_area.move.pos.count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move items range: "
+			  "src_node %u, dst_node %u, "
+			  "start_item %u, count %u, "
+			  "err %d\n",
+			  child_node->node_id,
+			  parent_node->node_id,
+			  child->items_area.move.pos.start,
+			  child->items_area.move.pos.count,
+			  err);
+		return err;
+	}
+
+	down_read(&child_node->header_lock);
+
+	switch (atomic_read(&child_node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		child->index_area.area_size = child_node->index_area.area_size;
+		calculated = child_node->index_area.index_capacity;
+		calculated -= child_node->index_area.index_count;
+		calculated *= child_node->index_area.index_size;
+		child->index_area.free_space = calculated;
+		child->index_area.hash.start =
+				child_node->index_area.start_hash;
+		child->index_area.hash.end =
+				child_node->index_area.end_hash;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	switch (atomic_read(&child_node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		child->items_area.area_size = child_node->items_area.area_size;
+		child->items_area.free_space =
+					child_node->items_area.free_space;
+		child->items_area.hash.start =
+				child_node->items_area.start_hash;
+		child->items_area.hash.end =
+				child_node->items_area.end_hash;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	up_read(&child_node->header_lock);
+
+	down_read(&parent_node->header_lock);
+
+	switch (atomic_read(&parent_node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		parent->index_area.area_size =
+			parent_node->index_area.area_size;
+		calculated = parent_node->index_area.index_capacity;
+		calculated -= parent_node->index_area.index_count;
+		calculated *= parent_node->index_area.index_size;
+		parent->index_area.free_space = calculated;
+		parent->index_area.hash.start =
+				parent_node->index_area.start_hash;
+		parent->index_area.hash.end =
+				parent_node->index_area.end_hash;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	switch (atomic_read(&parent_node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		parent->items_area.area_size =
+					parent_node->items_area.area_size;
+		parent->items_area.free_space =
+					parent_node->items_area.free_space;
+		parent->items_area.hash.start =
+				parent_node->items_area.start_hash;
+		parent->items_area.hash.end =
+				parent_node->items_area.end_hash;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	up_read(&parent_node->header_lock);
+
+	child->items_area.move.op_state = SSDFS_BTREE_AREA_OP_DONE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("src_node %u, dst_node %u, "
+		  "start_item %u, count %u\n",
+		  child_node->node_id,
+		  parent_node->node_id,
+		  child->items_area.move.pos.start,
+		  child->items_area.move.pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_move_items() - move items between nodes
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to move items between nodes.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_move_items(struct ssdfs_btree_state_descriptor *desc,
+			   struct ssdfs_btree_level *parent,
+			   struct ssdfs_btree_level *child)
+{
+	int op_state;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !parent || !child);
+
+	SSDFS_DBG("desc %p, parent %p, child %p\n",
+		  desc, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (child->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE) {
+		switch (child->items_area.move.direction) {
+		case SSDFS_BTREE_MOVE_TO_CHILD:
+			op_state = child->items_area.move.op_state;
+			if (op_state != SSDFS_BTREE_AREA_OP_DONE) {
+				SSDFS_ERR("invalid op_state %#x\n",
+					  op_state);
+				return -ERANGE;
+			}
+			break;
+
+		case SSDFS_BTREE_MOVE_TO_PARENT:
+			err = ssdfs_btree_move_items_child2parent(desc,
+								  parent,
+								  child);
+			if (unlikely(err)) {
+				SSDFS_ERR("failed to move items: err %d\n",
+					  err);
+				return err;
+			}
+			break;
+
+		case SSDFS_BTREE_MOVE_TO_LEFT:
+			err = ssdfs_btree_move_items_left(desc, parent, child);
+			if (unlikely(err)) {
+				SSDFS_ERR("failed to move items: err %d\n",
+					  err);
+				return err;
+			}
+			break;
+
+		case SSDFS_BTREE_MOVE_TO_RIGHT:
+			err = ssdfs_btree_move_items_right(desc, parent, child);
+			if (unlikely(err)) {
+				SSDFS_ERR("failed to move items: err %d\n",
+					  err);
+				return err;
+			}
+			break;
+
+		default:
+			SSDFS_ERR("invalid move direction %#x\n",
+				  child->items_area.move.direction);
+			return -ERANGE;
+		}
+	}
+
+	if (parent->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE) {
+		switch (parent->items_area.move.direction) {
+		case SSDFS_BTREE_MOVE_TO_CHILD:
+			err = ssdfs_btree_move_items_parent2child(desc,
+								  parent,
+								  child);
+			if (unlikely(err)) {
+				SSDFS_ERR("failed to move items: err %d\n",
+					  err);
+				return err;
+			}
+			break;
+
+		default:
+			SSDFS_ERR("invalid move direction %#x\n",
+				  parent->items_area.move.direction);
+			return -ERANGE;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_move_indexes_to_parent() - move indexes from child to parent node
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to move indexes from the child to the parent node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static int
+ssdfs_btree_move_indexes_to_parent(struct ssdfs_btree_state_descriptor *desc,
+				   struct ssdfs_btree_level *parent,
+				   struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node;
+	struct ssdfs_btree_node *child_node;
+	int type;
+	u16 start, count;
+	u32 calculated;
+	int state;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !parent || !child);
+
+	if (!(child->flags & SSDFS_BTREE_INDEX_AREA_NEED_MOVE &&
+	      child->index_area.move.direction == SSDFS_BTREE_MOVE_TO_PARENT)) {
+		SSDFS_WARN("invalid move request: "
+			   "flags %#x, direction %#x\n",
+			   child->flags,
+			   child->index_area.move.direction);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("desc %p, parent %p, child %p\n",
+		  desc, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = child->index_area.move.op_state;
+	if (state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  state);
+		return -ERANGE;
+	} else
+		child->index_area.move.op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	parent_node = parent->nodes.old_node.ptr;
+	child_node = child->nodes.old_node.ptr;
+
+	if (!parent_node || !child_node) {
+		SSDFS_ERR("fail to move items: "
+			  "parent_node %p, child_node %p\n",
+			  parent_node, child_node);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&parent_node->type);
+	switch (type) {
+	case SSDFS_BTREE_INDEX_NODE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("parent node has improper type: "
+			  "node_id %u, type %#x\n",
+			  parent_node->node_id, type);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&child_node->type);
+	switch (type) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("child node has improper type: "
+			  "node_id %u, type %#x\n",
+			  child_node->node_id, type);
+		return -ERANGE;
+	}
+
+	start = child->index_area.move.pos.start;
+	count = child->index_area.move.pos.count;
+
+	switch (child->index_area.move.pos.state) {
+	case SSDFS_HASH_RANGE_INTERSECTION:
+		if (count == 0) {
+			SSDFS_ERR("invalid position's count %u\n",
+				  count);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid position's state %#x\n",
+			  parent->index_area.move.pos.state);
+		return -ERANGE;
+	}
+
+	calculated = (start + count) * desc->index_size;
+	if (calculated >= desc->node_size) {
+		SSDFS_ERR("invalid position: "
+			  "start %u, count %u, "
+			  "index_size %u, node_size %u\n",
+			  child->index_area.move.pos.start,
+			  child->index_area.move.pos.count,
+			  desc->index_size,
+			  desc->node_size);
+		return -ERANGE;
+	}
+
+	calculated = count * desc->index_size;
+	if (calculated > parent->index_area.free_space) {
+		SSDFS_ERR("child has not enough free space: "
+			  "calculated %u, free_space %u\n",
+			  calculated,
+			  parent->index_area.free_space);
+		return -ERANGE;
+	}
+
+	state = parent->index_area.insert.op_state;
+	if (state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  state);
+		return -ERANGE;
+	} else
+		parent->index_area.insert.op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	switch (parent->index_area.insert.pos.state) {
+	case SSDFS_HASH_RANGE_RIGHT_ADJACENT:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid position's state %#x\n",
+			  parent->index_area.insert.pos.state);
+		return -ERANGE;
+	}
+
+	if (count != parent->index_area.insert.pos.count) {
+		SSDFS_ERR("inconsistent state: "
+			  "child->index_area.move.pos.count %u, "
+			  "parent->index_area.insert.pos.count %u\n",
+			  child->index_area.move.pos.count,
+			  parent->index_area.insert.pos.count);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_move_index_range(child_node,
+					child->index_area.move.pos.start,
+					parent_node,
+					parent->index_area.insert.pos.start,
+					parent->index_area.insert.pos.count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move index range: "
+			  "src_node %u, dst_node %u, "
+			  "src_start %u, dst_start %u, count %u, "
+			  "err %d\n",
+			  child_node->node_id,
+			  parent_node->node_id,
+			  child->index_area.move.pos.start,
+			  parent->index_area.insert.pos.start,
+			  parent->index_area.insert.pos.count,
+			  err);
+		return err;
+	}
+
+	down_read(&parent_node->header_lock);
+	parent->index_area.hash.start = parent_node->index_area.start_hash;
+	parent->index_area.hash.end = parent_node->index_area.end_hash;
+	parent->items_area.hash.start = parent_node->items_area.start_hash;
+	parent->items_area.hash.end = parent_node->items_area.end_hash;
+	up_read(&parent_node->header_lock);
+
+	down_read(&child_node->header_lock);
+	child->index_area.hash.start = child_node->index_area.start_hash;
+	child->index_area.hash.end = child_node->index_area.end_hash;
+	child->items_area.hash.start = child_node->items_area.start_hash;
+	child->items_area.hash.end = child_node->items_area.end_hash;
+	up_read(&child_node->header_lock);
+
+	parent->index_area.insert.op_state = SSDFS_BTREE_AREA_OP_DONE;
+	child->index_area.move.op_state = SSDFS_BTREE_AREA_OP_DONE;
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_move_indexes_to_child() - move indexes from parent to child node
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to move indexes from the parent to the child node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_move_indexes_to_child(struct ssdfs_btree_state_descriptor *desc,
+				      struct ssdfs_btree_level *parent,
+				      struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node;
+	struct ssdfs_btree_node *child_node;
+	int type;
+	u16 start, count;
+	u32 calculated;
+	int state;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !parent || !child);
+
+	if (!(parent->flags & SSDFS_BTREE_INDEX_AREA_NEED_MOVE &&
+	      parent->index_area.move.direction == SSDFS_BTREE_MOVE_TO_CHILD)) {
+		SSDFS_WARN("invalid move request: "
+			   "flags %#x, direction %#x\n",
+			   parent->flags,
+			   parent->index_area.move.direction);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("desc %p, parent %p, child %p\n",
+		  desc, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = parent->index_area.move.op_state;
+	if (state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  state);
+		return -ERANGE;
+	} else
+		parent->index_area.move.op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	if (parent->nodes.new_node.type == SSDFS_BTREE_ROOT_NODE)
+		parent_node = parent->nodes.new_node.ptr;
+	else
+		parent_node = parent->nodes.old_node.ptr;
+
+	if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE)
+		child_node = child->nodes.new_node.ptr;
+	else
+		child_node = child->nodes.old_node.ptr;
+
+	if (!parent_node || !child_node) {
+		SSDFS_ERR("fail to move items: "
+			  "parent_node %p, child_node %p\n",
+			  parent_node, child_node);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&parent_node->type);
+	switch (type) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("parent node has improper type: "
+			  "node_id %u, type %#x\n",
+			  parent_node->node_id, type);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&child_node->type);
+	switch (type) {
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("child node has improper type: "
+			  "node_id %u, type %#x\n",
+			  child_node->node_id, type);
+		return -ERANGE;
+	}
+
+	start = parent->index_area.move.pos.start;
+	count = parent->index_area.move.pos.count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start %u, count %u, state %#x\n",
+		  parent->index_area.move.pos.start,
+		  parent->index_area.move.pos.count,
+		  parent->index_area.move.pos.state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (parent->index_area.move.pos.state) {
+	case SSDFS_HASH_RANGE_INTERSECTION:
+		if (count == 0) {
+			SSDFS_ERR("invalid position's count %u\n",
+				  count);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid position's state %#x\n",
+			  parent->index_area.move.pos.state);
+		return -ERANGE;
+	}
+
+	calculated = (start + count) * desc->index_size;
+	if (calculated >= desc->node_size) {
+		SSDFS_ERR("invalid position: "
+			  "start %u, count %u, "
+			  "index_size %u, node_size %u\n",
+			  parent->index_area.move.pos.start,
+			  parent->index_area.move.pos.count,
+			  desc->index_size,
+			  desc->node_size);
+		return -ERANGE;
+	}
+
+	calculated = count * desc->index_size;
+	if (calculated > child->index_area.free_space) {
+		SSDFS_ERR("child has not enough free space: "
+			  "calculated %u, free_space %u\n",
+			  calculated,
+			  child->index_area.free_space);
+		return -ERANGE;
+	}
+
+	state = child->index_area.insert.op_state;
+	if (state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  state);
+		return -ERANGE;
+	} else
+		child->index_area.insert.op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	switch (child->index_area.insert.pos.state) {
+	case SSDFS_HASH_RANGE_LEFT_ADJACENT:
+	case SSDFS_HASH_RANGE_INTERSECTION:
+	case SSDFS_HASH_RANGE_RIGHT_ADJACENT:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid position's state %#x\n",
+			  child->index_area.insert.pos.state);
+		return -ERANGE;
+	}
+
+	if (count != child->index_area.insert.pos.count) {
+		SSDFS_ERR("inconsistent state: "
+			  "parent->index_area.move.pos.count %u, "
+			  "child->index_area.insert.pos.count %u\n",
+			  parent->index_area.move.pos.count,
+			  child->index_area.insert.pos.count);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_move_index_range(parent_node,
+					parent->index_area.move.pos.start,
+					child_node,
+					child->index_area.insert.pos.start,
+					child->index_area.insert.pos.count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move index range: "
+			  "src_node %u, dst_node %u, "
+			  "src_start %u, dst_start %u, count %u, "
+			  "err %d\n",
+			  parent_node->node_id,
+			  child_node->node_id,
+			  parent->index_area.move.pos.start,
+			  child->index_area.insert.pos.start,
+			  child->index_area.insert.pos.count,
+			  err);
+		SSDFS_ERR("child_node %u\n", child_node->node_id);
+		ssdfs_debug_show_btree_node_indexes(child_node->tree,
+						    child_node);
+		SSDFS_ERR("parent_node %u\n", parent_node->node_id);
+		ssdfs_debug_show_btree_node_indexes(parent_node->tree,
+						    parent_node);
+		return err;
+	}
+
+	down_read(&parent_node->header_lock);
+	parent->index_area.hash.start = parent_node->index_area.start_hash;
+	parent->index_area.hash.end = parent_node->index_area.end_hash;
+	parent->items_area.hash.start = parent_node->items_area.start_hash;
+	parent->items_area.hash.end = parent_node->items_area.end_hash;
+	up_read(&parent_node->header_lock);
+
+	down_read(&child_node->header_lock);
+	child->index_area.hash.start = child_node->index_area.start_hash;
+	child->index_area.hash.end = child_node->index_area.end_hash;
+	child->items_area.hash.start = child_node->items_area.start_hash;
+	child->items_area.hash.end = child_node->items_area.end_hash;
+	up_read(&child_node->header_lock);
+
+	parent->index_area.move.op_state = SSDFS_BTREE_AREA_OP_DONE;
+	child->index_area.insert.op_state = SSDFS_BTREE_AREA_OP_DONE;
+
+	return 0;
+}
-- 
2.34.1


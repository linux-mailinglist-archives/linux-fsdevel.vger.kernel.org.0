Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479146A2658
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBYBTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjBYBRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:39 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3A168B5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:19 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bk32so763837oib.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++zi/wZDtSxzts4ZrAaw6oO7n8C0CQ3WJdktQdNkSak=;
        b=AAvBca9a5wQ4pORgrhGg5LcYvIpP4NeyibldF0HZb4V7EsawzqKHCdmweJE40w1nZ6
         KgrOyz6cLyi0WCzxllPIzmha9NyHfyvFfx8FOFpEEXcJu9NLph02aC1xC2/Rj/lXU6mb
         2UXaD1KUWuyrVZiIArgmU3MwmCf95euCkeDVkEyNxqhLHTrpPtCXSCABHpX0L39CX5hw
         JhGb3hlihcz8wf0VDrxsTbPXmymbFcsEW6G9vgfnpBuYlR4HMGu9dW1zxHlRoDEmIXfs
         O/prApvWWfhYAUNbvVj+ShotddMz51Ew1Tbo+MnsnFE9Ois0f8izn0Uu72hOA2MtwLVV
         3cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++zi/wZDtSxzts4ZrAaw6oO7n8C0CQ3WJdktQdNkSak=;
        b=kZmpS4daBedax7RGCVv+kce8wFm3AqoDyERnM9lJ8yvUZT+CGhlp270fIgH4D5g3Nl
         ehGSNoqm51mnyk5H1nj56DZuS3gM5mp4bwfdmvBUozE4G8NbVxRqjS+cGr9SCwbP87lA
         DbZ1AX/1UBHvAinLa5ZilUK9/s9hmT7aExgeeV4MV6X5LVioGqV4HBOGR45EIHykl6ti
         q22Sdl0ceZxoBx4qRBNZrSs8dlz0SInQULY0vVPirv7bnwV0o+wpgGH5n5YjL6o7ofL9
         TTAsUXSq0OnzHKfBWh8ckd+rpprGMuI1l58zpItPPej6Mm7D55aoBF5n7JjtPzN8UTny
         l95g==
X-Gm-Message-State: AO0yUKWbEPnjmLaasm7alKvXd4AZNoE94yijg0LQrTHWYklYcdkh/FRp
        MriftwYuu2e7q96TjE46mdZVQmOmFDfHx1LT
X-Google-Smtp-Source: AK7set9/OmPu9Lj7TN/goZ+dwwtJ7mDJ6Bhxcep5y17XPRc/xgKiXJ/8thJe4XXSMzl0m+eFK7E/zA==
X-Received: by 2002:a05:6808:6147:b0:383:c4c4:22b0 with SMTP id dl7-20020a056808614700b00383c4c422b0mr5774883oib.20.1677287836496;
        Fri, 24 Feb 2023 17:17:16 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:15 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 48/76] ssdfs: add/delete b-tree node
Date:   Fri, 24 Feb 2023 17:08:59 -0800
Message-Id: <20230225010927.813929-49-slava@dubeyko.com>
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

B-tree can be imagined like a hierarchy of b-tree nodes.
This patch implements the logic of adding, inserting, or
deletion the node to/from b-tree. The logic is reused by
all specialized b-trees implementation.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree.c | 3054 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 3054 insertions(+)

diff --git a/fs/ssdfs/btree.c b/fs/ssdfs/btree.c
index 5780077a1eb9..d7778cdb67a1 100644
--- a/fs/ssdfs/btree.c
+++ b/fs/ssdfs/btree.c
@@ -1018,3 +1018,3057 @@ int ssdfs_btree_flush(struct ssdfs_btree *tree)
 
 	return err;
 }
+
+/*
+ * ssdfs_btree_destroy_node_range() - destroy nodes from radix tree
+ * @tree: btree object
+ * @hash: starting hash for nodes destruction
+ *
+ * This method tries to flush and destroy
+ * some nodes from radix tree
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_destroy_node_range(struct ssdfs_btree *tree,
+				   u64 hash)
+{
+	int tree_state;
+	struct radix_tree_iter iter;
+	void **slot;
+	struct ssdfs_btree_node *node;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, type %#x, state %#x\n",
+		  tree, tree->type, tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (tree_state) {
+	case SSDFS_BTREE_CREATED:
+	case SSDFS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid tree state %#x\n",
+			   tree_state);
+		return -ERANGE;
+	}
+
+	down_write(&tree->lock);
+
+	rcu_read_lock();
+
+	spin_lock(&tree->nodes_lock);
+	radix_tree_for_each_slot(slot, &tree->nodes, &iter,
+				 SSDFS_BTREE_ROOT_NODE_ID) {
+
+		node = (struct ssdfs_btree_node *)radix_tree_deref_slot(slot);
+		if (unlikely(!node)) {
+			SSDFS_WARN("empty node ptr: node_id %llu\n",
+				   (u64)iter.index);
+			continue;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (is_ssdfs_btree_node_pre_deleted(node)) {
+			if (is_ssdfs_node_shared(node)) {
+				atomic_set(&node->state,
+						SSDFS_BTREE_NODE_INVALID);
+				continue;
+			}
+		}
+
+		spin_unlock(&tree->nodes_lock);
+		rcu_read_unlock();
+
+		if (is_ssdfs_btree_node_pre_deleted(node)) {
+			clear_ssdfs_btree_node_pre_deleted(node);
+
+			ssdfs_btree_radix_tree_delete(tree,
+						node->node_id);
+
+			if (tree->btree_ops &&
+			    tree->btree_ops->delete_node) {
+				err = tree->btree_ops->delete_node(node);
+				if (unlikely(err)) {
+					SSDFS_ERR("delete node failure: "
+						  "err %d\n", err);
+				}
+			}
+
+			if (tree->btree_ops &&
+			    tree->btree_ops->destroy_node)
+				tree->btree_ops->destroy_node(node);
+
+			ssdfs_btree_node_destroy(node);
+		}
+
+		rcu_read_lock();
+		spin_lock(&tree->nodes_lock);
+	}
+	spin_unlock(&tree->nodes_lock);
+
+	rcu_read_unlock();
+
+	up_write(&tree->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_check_leaf_node_absence() - check that node is absent in the tree
+ * @tree: btree object
+ * @search: search object
+ *
+ * This method tries to detect that node is really absent before
+ * starting to add a new node. The tree should be exclusively locked
+ * for this operation in caller method.
+ *
+ * RETURN:
+ * [success] - tree hasn't requested node.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - tree is corrupted.
+ * %-EEXIST     - node exists in the tree.
+ */
+static
+int ssdfs_check_leaf_node_absence(struct ssdfs_btree *tree,
+				  struct ssdfs_btree_search *search)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("node_id %u, height %u\n",
+		  search->node.id, search->node.height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->node.state) {
+	case SSDFS_BTREE_SEARCH_ROOT_NODE_DESC:
+	case SSDFS_BTREE_SEARCH_FOUND_INDEX_NODE_DESC:
+	case SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid search object state: "
+			  "search->node.state %#x\n",
+			  search->node.state);
+		return -ERANGE;
+	}
+
+	if (!search->node.parent) {
+		SSDFS_ERR("parent node is NULL\n");
+		return -ERANGE;
+	}
+
+	err = __ssdfs_btree_find_item(tree, search);
+	if (err == -ENODATA) {
+		switch (search->result.state) {
+		case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+			/*
+			 * node doesn't exist in the tree
+			 */
+			err = 0;
+			break;
+
+		default:
+			/*
+			 * existing node has free space
+			 */
+			err = -EEXIST;
+			break;
+		}
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find index: "
+			  "start_hash %llx, err %d\n",
+			  search->request.start.hash,
+			  err);
+	} else
+		err = -EEXIST;
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_define_new_node_type() - define the type of creating node
+ * @tree: btree object
+ * @search: search object
+ *
+ * This method tries to define the type of creating node.
+ *
+ * RETURN:
+ * [success] - type of creating node.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - tree is corrupted.
+ */
+static
+int ssdfs_btree_define_new_node_type(struct ssdfs_btree *tree,
+				     struct ssdfs_btree_node *parent)
+{
+	int tree_height;
+	int parent_height;
+	int parent_type;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, parent %p\n",
+		  tree, parent);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_height = atomic_read(&tree->height);
+
+	if (tree_height <= SSDFS_BTREE_PARENT2LEAF_HEIGHT) {
+		/* btree contains root node only */
+		return SSDFS_BTREE_LEAF_NODE;
+	}
+
+	if (!parent) {
+		SSDFS_ERR("parent node is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_height = atomic_read(&parent->height);
+
+	if (parent_height == 0) {
+		SSDFS_ERR("invalid parent height %u\n",
+			  parent_height);
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent->type);
+	switch (parent_type) {
+	case SSDFS_BTREE_ROOT_NODE:
+		switch (parent_height) {
+		case SSDFS_BTREE_LEAF_NODE_HEIGHT:
+		case SSDFS_BTREE_PARENT2LEAF_HEIGHT:
+			if (can_add_new_index(parent))
+				return SSDFS_BTREE_LEAF_NODE;
+			else
+				return SSDFS_BTREE_HYBRID_NODE;
+
+		case SSDFS_BTREE_PARENT2HYBRID_HEIGHT:
+			if (can_add_new_index(parent))
+				return SSDFS_BTREE_HYBRID_NODE;
+			else
+				return SSDFS_BTREE_INDEX_NODE;
+
+		default:
+			return SSDFS_BTREE_INDEX_NODE;
+		}
+
+	case SSDFS_BTREE_INDEX_NODE:
+		switch (parent_height) {
+		case SSDFS_BTREE_PARENT2HYBRID_HEIGHT:
+			if (can_add_new_index(parent))
+				return SSDFS_BTREE_HYBRID_NODE;
+			else
+				return SSDFS_BTREE_INDEX_NODE;
+
+		case SSDFS_BTREE_PARENT2LEAF_HEIGHT:
+			return SSDFS_BTREE_LEAF_NODE;
+
+		default:
+			return SSDFS_BTREE_INDEX_NODE;
+		}
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		return SSDFS_BTREE_LEAF_NODE;
+	}
+
+	SSDFS_ERR("invalid btree node's type %#x\n",
+		  parent_type);
+	return -ERANGE;
+}
+
+/*
+ * ssdfs_current_segment_pre_allocate_node() - pre-allocate the node
+ * @node_type: type of the node
+ * @node: node object
+ *
+ * This method tries to pre-allocate the node
+ * in the current segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - tree is corrupted.
+ * %-ENOSPC     - volume hasn't free space.
+ */
+static
+int ssdfs_current_segment_pre_allocate_node(int node_type,
+					    struct ssdfs_btree_node *node)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_request *req;
+	struct ssdfs_segment_info *si;
+	u64 ino;
+	u64 logical_offset;
+	u64 seg_id;
+	int seg_type;
+	struct ssdfs_blk2off_range extent;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_type %#x\n", node_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!node) {
+		SSDFS_ERR("node is NULL\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node->tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+
+	req = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req)) {
+		err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_request_init(req);
+	ssdfs_get_request(req);
+
+	ino = node->tree->owner_ino;
+	logical_offset = (u64)node->node_id * node->node_size;
+	ssdfs_request_prepare_logical_extent(ino,
+					     logical_offset,
+					     node->node_size,
+					     0, 0, req);
+
+	switch (node_type) {
+	case SSDFS_BTREE_INDEX_NODE:
+		err = ssdfs_segment_pre_alloc_index_node_extent_async(fsi, req,
+								      &seg_id,
+								      &extent);
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		err = ssdfs_segment_pre_alloc_hybrid_node_extent_async(fsi,
+								       req,
+								       &seg_id,
+								       &extent);
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		err = ssdfs_segment_pre_alloc_leaf_node_extent_async(fsi, req,
+								     &seg_id,
+								     &extent);
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid node_type %#x\n", node_type);
+		goto finish_pre_allocate_node;
+	}
+
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to pre-allocate node: "
+			  "free space is absent\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto free_segment_request;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-allocate node: err %d\n",
+			  err);
+		goto free_segment_request;
+	}
+
+	if (node->pages_per_node != extent.len) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid request result: "
+			  "pages_per_node %u != len %u\n",
+			  node->pages_per_node,
+			  extent.len);
+		goto finish_pre_allocate_node;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg_id == U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	seg_type = NODE2SEG_TYPE(node_type);
+
+	si = ssdfs_grab_segment(fsi, seg_type, seg_id, U64_MAX);
+	if (IS_ERR_OR_NULL(si)) {
+		err = (si == NULL ? -ERANGE : PTR_ERR(si));
+		SSDFS_ERR("fail to grab segment object: "
+			  "err %d\n",
+			  err);
+		goto finish_pre_allocate_node;
+	}
+
+	spin_lock(&node->descriptor_lock);
+	node->seg = si;
+	node->extent.seg_id = cpu_to_le64(seg_id);
+	node->extent.logical_blk = cpu_to_le32(extent.start_lblk);
+	node->extent.len = cpu_to_le32(extent.len);
+	ssdfs_memcpy(&node->node_index.index.extent,
+		     0, sizeof(struct ssdfs_raw_extent),
+		     &node->extent,
+		     0, sizeof(struct ssdfs_raw_extent),
+		     sizeof(struct ssdfs_raw_extent));
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree_type %#x, node_id %u, node_type %#x, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  node->tree->type, node->node_id, node_type,
+		  seg_id, extent.start_lblk, extent.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+
+free_segment_request:
+	ssdfs_put_request(req);
+	ssdfs_request_free(req);
+
+finish_pre_allocate_node:
+	return err;
+}
+
+/*
+ * ssdfs_check_leaf_node_state() - check the leaf node's state
+ * @search: search object
+ *
+ * This method checks the leaf node's state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - node exists.
+ */
+static
+int ssdfs_check_leaf_node_state(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node;
+	int state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+
+	SSDFS_DBG("node_id %u, height %u\n",
+		  search->node.id, search->node.height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = search->node.state;
+	if (state != SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC) {
+		SSDFS_ERR("invalid node state %#x\n", state);
+		return -ERANGE;
+	}
+
+	if (!search->node.child) {
+		SSDFS_ERR("child node is NULL\n");
+		return -ERANGE;
+	}
+
+check_leaf_node_state:
+	switch (atomic_read(&search->node.child->state)) {
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		err = -EEXIST;
+		break;
+
+	case SSDFS_BTREE_NODE_CREATED:
+	case SSDFS_BTREE_NODE_CONTENT_PREPARED:
+		node = search->node.child;
+		err = SSDFS_WAIT_COMPLETION(&node->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("node init failed: "
+				  "err %d\n", err);
+		} else {
+			err = -EEXIST;
+			goto check_leaf_node_state;
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_prepare_empty_btree_for_add() - prepare empty btree for adding
+ * @tree: btree object
+ * @search: search object
+ * @hierarchy: hierarchy object
+ *
+ * This method prepares empty btree for adding a new node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+#ifdef CONFIG_SSDFS_UNDER_DEVELOPMENT_FUNC
+static
+int ssdfs_prepare_empty_btree_for_add(struct ssdfs_btree *tree,
+				      struct ssdfs_btree_search *search,
+				      struct ssdfs_btree_hierarchy *hierarchy)
+{
+	struct ssdfs_btree_level *level;
+	struct ssdfs_btree_node *parent_node;
+	int cur_height, tree_height;
+	u64 start_hash, end_hash;
+	int parent_node_type;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search || !hierarchy);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p, hierarchy %p\n",
+		  tree, search, hierarchy);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height <= 0) {
+		SSDFS_ERR("invalid tree_height %u\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	parent_node = search->node.parent;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	cur_height = search->node.height;
+	if (cur_height >= tree_height) {
+		SSDFS_ERR("cur_height %u >= tree_height %u\n",
+			  cur_height, tree_height);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	parent_node_type = atomic_read(&parent_node->type);
+
+	if (parent_node_type != SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_ERR("corrupted hierarchy: "
+			  "expected parent root node\n");
+		return -ERANGE;
+	}
+
+	if ((tree_height + 1) != hierarchy->desc.height) {
+		SSDFS_ERR("corrupted hierarchy: "
+			  "tree_height %u, "
+			  "hierarchy->desc.height %u\n",
+			  tree_height,
+			  hierarchy->desc.height);
+		return -ERANGE;
+	}
+
+	if (!can_add_new_index(parent_node)) {
+		SSDFS_ERR("unable add index into the root\n");
+		return -ERANGE;
+	}
+
+	level = hierarchy->array_ptr[cur_height];
+	ssdfs_btree_prepare_add_node(tree, SSDFS_BTREE_LEAF_NODE,
+				     start_hash, end_hash,
+				     level, NULL);
+
+	level = hierarchy->array_ptr[cur_height + 1];
+	err = ssdfs_btree_prepare_add_index(level,
+					    start_hash,
+					    end_hash,
+					    parent_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare level: "
+			  "node_id %u, height %u\n",
+			  parent_node->node_id,
+			  atomic_read(&parent_node->height));
+		return err;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_SSDFS_UNDER_DEVELOPMENT_FUNC */
+
+/*
+ * __ssdfs_btree_read_node() - create and initialize the node
+ * @tree: btree object
+ * @parent: parent node
+ * @node_index: index key of preparing node
+ * @node_type: type of the node
+ * @node_id: node ID
+ *
+ * This method tries to read the node's content from the disk.
+ *
+ * RETURN:
+ * [success] - pointer on created node object.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - node exists already.
+ */
+struct ssdfs_btree_node *
+__ssdfs_btree_read_node(struct ssdfs_btree *tree,
+			struct ssdfs_btree_node *parent,
+			struct ssdfs_btree_index_key *node_index,
+			u8 node_type, u32 node_id)
+{
+	struct ssdfs_btree_node *ptr, *node;
+	int height;
+	u64 start_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, parent %p, "
+		  "node_index %p, node_type %#x, node_id %llu\n",
+		  tree, parent, node_index,
+		  node_type, (u64)node_id);
+
+	BUG_ON(!tree || !parent || !node_index);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node_type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    node_type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_WARN("invalid node type %#x\n",
+			   node_type);
+		return ERR_PTR(-ERANGE);
+	}
+
+	height = atomic_read(&parent->height);
+	if (height <= 0) {
+		SSDFS_ERR("invalid height %u, node_id %u\n",
+			  height, parent->node_id);
+		return ERR_PTR(-ERANGE);
+	} else
+		height -= 1;
+
+	start_hash = le64_to_cpu(node_index->index.hash);
+	ptr = ssdfs_btree_node_create(tree, node_id, parent,
+				      height, node_type, start_hash);
+	if (unlikely(IS_ERR_OR_NULL(ptr))) {
+		err = !ptr ? -ENOMEM : PTR_ERR(ptr);
+		SSDFS_ERR("fail to create node: err %d\n",
+			  err);
+		return ptr;
+	}
+
+	if (tree->btree_ops && tree->btree_ops->create_node) {
+		err = tree->btree_ops->create_node(ptr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create the node: "
+				  "err %d\n", err);
+			ssdfs_btree_node_destroy(ptr);
+			return ERR_PTR(err);
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("NODE_INDEX: node_id %u, node_type %#x, "
+		  "height %u, flags %#x, hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(node_index->node_id),
+		  node_index->node_type,
+		  node_index->height,
+		  le16_to_cpu(node_index->flags),
+		  le64_to_cpu(node_index->index.hash),
+		  le64_to_cpu(node_index->index.extent.seg_id),
+		  le32_to_cpu(node_index->index.extent.logical_blk),
+		  le32_to_cpu(node_index->index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&ptr->descriptor_lock);
+	ssdfs_memcpy(&ptr->node_index,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     node_index,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     sizeof(struct ssdfs_btree_index_key));
+	spin_unlock(&ptr->descriptor_lock);
+
+try_find_node:
+	spin_lock(&tree->nodes_lock);
+	node = radix_tree_lookup(&tree->nodes, node_id);
+	spin_unlock(&tree->nodes_lock);
+
+	if (!node) {
+		err = radix_tree_preload(GFP_NOFS);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to preload radix tree: err %d\n",
+				  err);
+			goto finish_insert_node;
+		}
+
+		spin_lock(&tree->nodes_lock);
+		err = radix_tree_insert(&tree->nodes, node_id, ptr);
+		spin_unlock(&tree->nodes_lock);
+
+		radix_tree_preload_end();
+
+		if (err == -EEXIST)
+			goto try_find_node;
+		else if (unlikely(err)) {
+			SSDFS_ERR("fail to add node into radix tree: "
+				  "node_id %llu, node %p, err %d\n",
+				  (u64)node_id, ptr, err);
+			goto finish_insert_node;
+		}
+	} else {
+		switch (atomic_read(&node->state)) {
+		case SSDFS_BTREE_NODE_CREATED:
+			err = -EAGAIN;
+			goto finish_insert_node;
+
+		case SSDFS_BTREE_NODE_INITIALIZED:
+		case SSDFS_BTREE_NODE_DIRTY:
+			err = -EEXIST;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node %u has been found\n",
+				  node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_insert_node;
+
+		default:
+			err = -ERANGE;
+			SSDFS_WARN("invalid node state %#x\n",
+				   atomic_read(&node->state));
+			goto finish_insert_node;
+		}
+	}
+
+finish_insert_node:
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(&node->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("node init failed: "
+				  "err %d\n", err);
+			ssdfs_btree_node_destroy(ptr);
+			return ERR_PTR(err);
+		} else
+			goto try_find_node;
+	} else if (err == -EEXIST) {
+		ssdfs_btree_node_destroy(ptr);
+		return node;
+	} else if (unlikely(err)) {
+		ssdfs_btree_node_destroy(ptr);
+		return ERR_PTR(err);
+	}
+
+	err = ssdfs_btree_node_prepare_content(ptr, node_index);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		goto fail_read_node;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare btree node's content: "
+			  "err %d\n", err);
+		goto fail_read_node;
+	}
+
+	if (tree->btree_ops && tree->btree_ops->init_node) {
+		err = tree->btree_ops->init_node(ptr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init btree node: "
+				  "err %d\n", err);
+			goto fail_read_node;
+		}
+	}
+
+	atomic_set(&ptr->state, SSDFS_BTREE_NODE_INITIALIZED);
+	complete_all(&ptr->init_end);
+	return ptr;
+
+fail_read_node:
+	complete_all(&ptr->init_end);
+	ssdfs_btree_radix_tree_delete(tree, node_id);
+	if (tree->btree_ops && tree->btree_ops->delete_node)
+		tree->btree_ops->delete_node(ptr);
+	if (tree->btree_ops && tree->btree_ops->destroy_node)
+		tree->btree_ops->destroy_node(ptr);
+	ssdfs_btree_node_destroy(ptr);
+	return ERR_PTR(err);
+}
+
+/*
+ * ssdfs_btree_read_node() - create and initialize the node
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to read the node's content from the disk.
+ *
+ * RETURN:
+ * [success] - pointer on created node object.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+struct ssdfs_btree_node *
+ssdfs_btree_read_node(struct ssdfs_btree *tree,
+			struct ssdfs_btree_search *search)
+{
+	u8 node_type;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, id %u, node_id %u, "
+		  "hash %llx, "
+		  "extent (seg %u, logical_blk %u, len %u)\n",
+		tree,
+		search->node.id,
+		le32_to_cpu(search->node.found_index.node_id),
+		le64_to_cpu(search->node.found_index.index.hash),
+		le32_to_cpu(search->node.found_index.index.extent.seg_id),
+		le32_to_cpu(search->node.found_index.index.extent.logical_blk),
+		le32_to_cpu(search->node.found_index.index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node_type = search->node.found_index.node_type;
+	return __ssdfs_btree_read_node(tree, search->node.parent,
+					&search->node.found_index,
+					node_type, search->node.id);
+}
+
+/*
+ * ssdfs_btree_get_child_node_for_hash() - get child node for hash
+ * @tree: btree object
+ * @parent: parent node
+ * @upper_hash: upper value of the hash
+ *
+ * This method tries to extract child node for the hash value.
+ *
+ * RETURN:
+ * [success] - pointer on the child node.
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EACCES     - node is under initialization.
+ * %-ENOENT     - index area is absent.
+ */
+struct ssdfs_btree_node *
+ssdfs_btree_get_child_node_for_hash(struct ssdfs_btree *tree,
+				    struct ssdfs_btree_node *parent,
+				    u64 upper_hash)
+{
+	struct ssdfs_btree_node *child = ERR_PTR(-ERANGE);
+	struct ssdfs_btree_node_index_area area;
+	struct ssdfs_btree_index_key index_key;
+	int parent_type;
+	u16 found_index = U16_MAX;
+	u32 node_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !parent);
+	BUG_ON(upper_hash >= U64_MAX);
+
+	SSDFS_DBG("node_id %u, upper_hash %llx\n",
+		  parent->node_id, upper_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&parent->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+		err = -EACCES;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  parent->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return ERR_PTR(err);
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&parent->state));
+		return ERR_PTR(err);
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(parent)) {
+		err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't index area\n",
+			  parent->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return ERR_PTR(err);
+	}
+
+	down_read(&parent->full_lock);
+
+	parent_type = atomic_read(&parent->type);
+	if (parent_type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    parent_type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		child = ERR_PTR(-ERANGE);
+		SSDFS_ERR("invalid node type %#x\n",
+			  parent_type);
+		goto finish_child_search;
+	}
+
+	down_read(&parent->header_lock);
+	ssdfs_memcpy(&area,
+		     0, sizeof(struct ssdfs_btree_node_index_area),
+		     &parent->index_area,
+		     0, sizeof(struct ssdfs_btree_node_index_area),
+		     sizeof(struct ssdfs_btree_node_index_area));
+	err = ssdfs_find_index_by_hash(parent, &area, upper_hash,
+					&found_index);
+	up_read(&parent->header_lock);
+
+	if (err == -EEXIST) {
+		/* hash == found hash */
+		err = 0;
+	} else if (err == -ENODATA) {
+		child = ERR_PTR(err);
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find an index: "
+			  "node_id %u, hash %llx\n",
+			  parent->node_id, upper_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_child_search;
+	} else if (unlikely(err)) {
+		child = ERR_PTR(err);
+		SSDFS_ERR("fail to find an index: "
+			  "node_id %u, hash %llx, err %d\n",
+			  parent->node_id, upper_hash,
+			  err);
+		goto finish_child_search;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(found_index == U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type == SSDFS_BTREE_ROOT_NODE) {
+		err = __ssdfs_btree_root_node_extract_index(parent,
+							    found_index,
+							    &index_key);
+	} else {
+		err = __ssdfs_btree_common_node_extract_index(parent, &area,
+							      found_index,
+							      &index_key);
+	}
+
+	if (unlikely(err)) {
+		child = ERR_PTR(err);
+		SSDFS_ERR("fail to extract index: "
+			  "node_id %u, node_type %#x, "
+			  "found_index %u, err %d\n",
+			  parent->node_id, parent_type,
+			  found_index, err);
+		goto finish_child_search;
+	}
+
+	node_id = le32_to_cpu(index_key.node_id);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, node_type %#x\n",
+		  node_id, index_key.node_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_btree_radix_tree_find(tree, node_id, &child);
+	if (err == -ENOENT) {
+		err = 0;
+		child = __ssdfs_btree_read_node(tree, parent,
+						&index_key,
+						index_key.node_type,
+						node_id);
+		if (unlikely(IS_ERR_OR_NULL(child))) {
+			err = !child ? -ENOMEM : PTR_ERR(child);
+			SSDFS_ERR("fail to read: "
+				  "node %llu, err %d\n",
+				  (u64)node_id, err);
+			goto finish_child_search;
+		}
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find node in radix tree: "
+			  "node_id %llu, err %d\n",
+			  (u64)node_id, err);
+		goto finish_child_search;
+	} else if (!child) {
+		child = ERR_PTR(-ERANGE);
+		SSDFS_WARN("empty node pointer\n");
+		goto finish_child_search;
+	}
+
+finish_child_search:
+	up_read(&parent->full_lock);
+
+	if (err) {
+		SSDFS_ERR("node_id %u, upper_hash %llx\n",
+			  parent->node_id, upper_hash);
+		SSDFS_ERR("index_area: index_count %u, index_capacity %u, "
+			  "start_hash %llx, end_hash %llx\n",
+			  area.index_count, area.index_capacity,
+			  area.start_hash, area.end_hash);
+		ssdfs_debug_show_btree_node_indexes(parent->tree, parent);
+	}
+
+	return child;
+}
+
+/*
+ * ssdfs_btree_generate_node_id() - generate new node ID
+ * @tree: btree object
+ *
+ * It is possible to use the simple technique. The upper node ID will
+ * be the latest allocated ID number. Generating the node ID means
+ * simply increasing the upper node ID value. In the case of node deletion
+ * it needs to leave the empty node till the whole branch of tree will
+ * be deleted. The goal is to keep the upper node ID in valid state.
+ * And the upper node ID can be decreased if the whold branch of empty
+ * nodes will be deleted.
+ *
+ * <Currently node deletion is simple operation. Any node can be deleted.
+ * The implementation should be changed if u32 will be not enough for
+ * the node ID representation.>
+ *
+ * RETURN:
+ * [success] - new node ID
+ * [failure] - U32_MAX
+ */
+u32 ssdfs_btree_generate_node_id(struct ssdfs_btree *tree)
+{
+	struct ssdfs_btree_node *node;
+	u32 node_id = U32_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&tree->nodes_lock);
+	node_id = tree->upper_node_id;
+	if (node_id < U32_MAX) {
+		node_id++;
+		tree->upper_node_id = node_id;
+	}
+	spin_unlock(&tree->nodes_lock);
+
+	if (node_id == U32_MAX) {
+		SSDFS_DBG("node IDs are completely used\n");
+		return node_id;
+	}
+
+	err = ssdfs_btree_radix_tree_find(tree,
+					  SSDFS_BTREE_ROOT_NODE_ID,
+					  &node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find root node in radix tree: "
+			  "err %d\n", err);
+		return U32_MAX;
+	} else if (!node) {
+		SSDFS_WARN("empty node pointer\n");
+		return U32_MAX;
+	}
+
+	set_ssdfs_btree_node_dirty(node);
+
+	return node_id;
+}
+
+/*
+ * ssdfs_btree_destroy_empty_node() - destroy the empty node.
+ * @tree: btree object
+ * @node: node object
+ *
+ * This method tries to destroy the empty node.
+ */
+static inline
+void ssdfs_btree_destroy_empty_node(struct ssdfs_btree *tree,
+				    struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!node)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, height %u\n",
+		  node->node_id,
+		  atomic_read(&node->height));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (tree->btree_ops && tree->btree_ops->destroy_node)
+		tree->btree_ops->destroy_node(node);
+
+	ssdfs_btree_node_destroy(node);
+}
+
+/*
+ * ssdfs_btree_create_empty_node() - create empty node.
+ * @tree: btree object
+ * @cur_height: height for node creation
+ * @hierarchy: hierarchy object
+ *
+ * This method tries to create the empty node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_create_empty_node(struct ssdfs_btree *tree,
+				  int cur_height,
+				  struct ssdfs_btree_hierarchy *hierarchy)
+{
+	struct ssdfs_btree_level *level;
+	struct ssdfs_btree_node *parent = NULL, *ptr = NULL;
+	u32 node_id;
+	int node_type;
+	int tree_height;
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !hierarchy);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, cur_height %d\n",
+		  tree, cur_height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_height = atomic_read(&tree->height);
+
+	if (cur_height > tree_height) {
+		SSDFS_ERR("cur_height %d > tree_height %d\n",
+			  cur_height, tree_height);
+		return -ERANGE;
+	}
+
+	level = hierarchy->array_ptr[cur_height];
+
+	if (!(level->flags & SSDFS_BTREE_LEVEL_ADD_NODE))
+		return 0;
+
+	node_id = ssdfs_btree_generate_node_id(tree);
+	if (node_id == SSDFS_BTREE_NODE_INVALID_ID) {
+		SSDFS_ERR("fail to generate node_id: err %d\n",
+			  err);
+		return -ERANGE;
+	}
+
+	level = hierarchy->array_ptr[cur_height + 1];
+	if (level->flags & SSDFS_BTREE_LEVEL_ADD_NODE)
+		parent = level->nodes.new_node.ptr;
+	else if (level->nodes.new_node.type == SSDFS_BTREE_ROOT_NODE)
+		parent = level->nodes.new_node.ptr;
+	else
+		parent = level->nodes.old_node.ptr;
+
+	if (!parent) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	node_type = ssdfs_btree_define_new_node_type(tree, parent);
+	switch (node_type) {
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_LEAF_NODE:
+		/* expected state */
+		break;
+
+	default:
+		if (node_type < 0) {
+			SSDFS_ERR("fail to define the new node type: "
+				  "err %d\n", err);
+		} else {
+			SSDFS_ERR("invalid node type %#x\n",
+				  node_type);
+		}
+		return node_type < 0 ? node_type : -ERANGE;
+	}
+
+	level = hierarchy->array_ptr[cur_height];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("level: flags %#x, move.direction %#x\n",
+		  level->flags,
+		  level->index_area.move.direction);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (level->flags & SSDFS_BTREE_INDEX_AREA_NEED_MOVE) {
+		switch (level->index_area.move.direction) {
+		case SSDFS_BTREE_MOVE_TO_RIGHT:
+		case SSDFS_BTREE_MOVE_TO_LEFT:
+			SSDFS_DBG("correct node type\n");
+			/* correct node type */
+			node_type = SSDFS_BTREE_INDEX_NODE;
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, node_type %#x\n",
+		  node_id, node_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	level = hierarchy->array_ptr[cur_height];
+	ptr = ssdfs_btree_node_create(tree, node_id, parent, cur_height,
+					node_type,
+					level->items_area.hash.start);
+	if (unlikely(IS_ERR_OR_NULL(ptr))) {
+		err = !ptr ? -ENOMEM : PTR_ERR(ptr);
+		SSDFS_ERR("fail to create node: err %d\n",
+			  err);
+		return err;
+	}
+
+	if (tree->btree_ops && tree->btree_ops->create_node) {
+		err = tree->btree_ops->create_node(ptr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create the node: "
+				  "err %d\n", err);
+			goto finish_create_node;
+		}
+	}
+
+	err = ssdfs_current_segment_pre_allocate_node(node_type, ptr);
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to preallocate node: id %u\n",
+			  node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_create_node;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to preallocate node: id %u, err %d\n",
+			  node_id, err);
+		goto finish_create_node;
+	}
+
+	atomic_or(SSDFS_BTREE_NODE_PRE_ALLOCATED,
+		  &ptr->flags);
+
+	flags = le16_to_cpu(ptr->node_index.flags);
+	flags |= SSDFS_BTREE_INDEX_SHOW_PREALLOCATED_CHILD;
+	ptr->node_index.flags = cpu_to_le16(flags);
+
+	level->nodes.new_node.type = node_type;
+	level->nodes.new_node.ptr = ptr;
+	return 0;
+
+finish_create_node:
+	ssdfs_btree_destroy_empty_node(tree, ptr);
+	return err;
+}
+
+/*
+ * ssdfs_btree_update_parent_node_pointer() - update child's parent's pointer
+ * @tree: btree object
+ * @parent: parent node
+ *
+ * This method tries to update parent pointer in child nodes.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_update_parent_node_pointer(struct ssdfs_btree *tree,
+					   struct ssdfs_btree_node *parent)
+{
+	struct ssdfs_btree_node *child = NULL;
+	struct ssdfs_btree_node_index_area area;
+	struct ssdfs_btree_index_key index_key;
+	int type;
+	u32 node_id;
+	spinlock_t *lock;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!parent);
+
+	SSDFS_DBG("node_id %u, height %u\n",
+		  parent->node_id,
+		  atomic_read(&parent->height));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	type = atomic_read(&parent->type);
+
+	switch (type) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (!is_ssdfs_btree_node_index_area_exist(parent)) {
+			SSDFS_ERR("corrupted node %u\n",
+				  parent->node_id);
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		/* do nothing */
+		return 0;
+
+	default:
+		BUG();
+	}
+
+	if (is_ssdfs_btree_node_index_area_empty(parent)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u has empty index area\n",
+			  parent->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	down_read(&parent->full_lock);
+
+	down_read(&parent->header_lock);
+	ssdfs_memcpy(&area,
+		     0, sizeof(struct ssdfs_btree_node_index_area),
+		     &parent->index_area,
+		     0, sizeof(struct ssdfs_btree_node_index_area),
+		     sizeof(struct ssdfs_btree_node_index_area));
+	up_read(&parent->header_lock);
+
+	for (i = 0; i < area.index_count; i++) {
+		if (type == SSDFS_BTREE_ROOT_NODE) {
+			err = __ssdfs_btree_root_node_extract_index(parent,
+								    i,
+								    &index_key);
+		} else {
+			err = __ssdfs_btree_common_node_extract_index(parent,
+								    &area, i,
+								    &index_key);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract index key: "
+				  "index_position %d, err %d\n",
+				  i, err);
+			goto finish_index_processing;
+		}
+
+		node_id = le32_to_cpu(index_key.node_id);
+
+		if (node_id == parent->node_id) {
+			/*
+			 * Hybrid node contains index on itself
+			 * in the index area. Ignore this node_id.
+			 */
+			if (type != index_key.node_type) {
+				SSDFS_WARN("type %#x != node_type %#x\n",
+					   type, index_key.node_type);
+			}
+			continue;
+		}
+
+		up_read(&parent->full_lock);
+
+		err = ssdfs_btree_radix_tree_find(tree, node_id, &child);
+
+		if (!child) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("empty node pointer: "
+				  "node_id %u\n", node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		if (!err) {
+			lock = &child->descriptor_lock;
+			spin_lock(lock);
+			child->parent_node = parent;
+			spin_unlock(lock);
+			lock = NULL;
+		}
+
+		down_read(&parent->full_lock);
+
+		if (err == -ENOENT) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node %u is absent\n",
+				  node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find node in radix tree: "
+				  "node_id %llu, err %d\n",
+				  (u64)node_id, err);
+			goto finish_index_processing;
+		}
+	}
+
+finish_index_processing:
+	up_read(&parent->full_lock);
+
+	if (unlikely(err))
+		ssdfs_debug_show_btree_node_indexes(tree, parent);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_process_hierarchy_for_add_nolock() - process hierarchy for add
+ * @tree: btree object
+ * @search: search object [in|out]
+ * @hierarchy: hierarchy object [in|out]
+ *
+ * This method tries to add a node into the tree with the goal
+ * to increase capacity of items in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_process_hierarchy_for_add_nolock(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_hierarchy *hierarchy)
+{
+	struct ssdfs_btree_level *level;
+	struct ssdfs_btree_node *node;
+	int cur_height, tree_height;
+	u32 node_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, start_hash %llx\n",
+		  tree, search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height <= 0) {
+		SSDFS_ERR("invalid tree_height %d\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	for (cur_height = tree_height; cur_height >= 0; cur_height--) {
+		level = hierarchy->array_ptr[cur_height];
+
+		if (!need_add_node(level))
+			continue;
+
+		err = ssdfs_btree_create_empty_node(tree, cur_height,
+						    hierarchy);
+		if (err) {
+			if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to create empty node: "
+					  "err %d\n",
+					  err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else {
+				SSDFS_ERR("fail to create empty node: "
+					  "err %d\n",
+					  err);
+			}
+
+			for (cur_height++; cur_height <= tree_height; cur_height++) {
+				if (!need_add_node(level))
+					continue;
+
+				node = level->nodes.new_node.ptr;
+
+				if (!node)
+					continue;
+
+				node_id = node->node_id;
+				ssdfs_btree_radix_tree_delete(tree, node_id);
+				ssdfs_btree_destroy_empty_node(tree, node);
+			}
+
+			goto finish_create_node;
+		}
+
+		node = level->nodes.new_node.ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_btree_radix_tree_insert(tree, node->node_id,
+						    node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert node %u into radix tree: "
+				  "err %d\n",
+				  node->node_id, err);
+
+			for (; cur_height < tree_height; cur_height++) {
+				level = hierarchy->array_ptr[cur_height];
+
+				if (!need_add_node(level))
+					continue;
+
+				node = level->nodes.new_node.ptr;
+				node_id = node->node_id;
+				ssdfs_btree_radix_tree_delete(tree, node_id);
+				ssdfs_btree_destroy_empty_node(tree, node);
+			}
+
+			goto finish_create_node;
+		}
+
+		set_ssdfs_btree_node_dirty(node);
+	}
+
+	cur_height = 0;
+	for (; cur_height < hierarchy->desc.height; cur_height++) {
+		err = ssdfs_btree_process_level_for_add(hierarchy, cur_height,
+							search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to process the tree's level: "
+				  "cur_height %u, err %d\n",
+				  cur_height, err);
+			goto finish_create_node;
+		}
+	}
+
+	for (cur_height = tree_height; cur_height >= 0; cur_height--) {
+		level = hierarchy->array_ptr[cur_height];
+
+		if (!need_add_node(level))
+			continue;
+
+		node = level->nodes.new_node.ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (tree->btree_ops && tree->btree_ops->add_node) {
+			err = tree->btree_ops->add_node(node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add the node: "
+					  "err %d\n", err);
+
+				for (; cur_height < tree_height; cur_height++) {
+					level = hierarchy->array_ptr[cur_height];
+
+					if (!need_add_node(level))
+						continue;
+
+					node = level->nodes.new_node.ptr;
+					node_id = node->node_id;
+					ssdfs_btree_radix_tree_delete(tree,
+								      node_id);
+					if (tree->btree_ops &&
+						tree->btree_ops->delete_node) {
+					    tree->btree_ops->delete_node(node);
+					}
+					ssdfs_btree_destroy_empty_node(tree,
+									node);
+				}
+
+				goto finish_create_node;
+			}
+		}
+	}
+
+	if (hierarchy->desc.increment_height) {
+		/* increase tree's height */
+		atomic_inc(&tree->height);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree->height %d\n",
+		  atomic_read(&tree->height));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	atomic_set(&tree->state, SSDFS_BTREE_DIRTY);
+
+finish_create_node:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * __ssdfs_btree_add_node() - add a node into the btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to add a node into the tree with the goal
+ * to increase capacity of items in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EEXIST     - node exists already.
+ */
+static
+int __ssdfs_btree_add_node(struct ssdfs_btree *tree,
+			   struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_hierarchy *hierarchy;
+	struct ssdfs_btree_level *level;
+	struct ssdfs_btree_node *node;
+	struct ssdfs_btree_node *parent_node;
+	int cur_height, tree_height;
+#define SSDFS_BTREE_MODIFICATION_PHASE_MAX	(3)
+	int phase_id;
+	spinlock_t *lock;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+
+	SSDFS_DBG("tree %p, start_hash %llx\n",
+		  tree, search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->node.state) {
+	case SSDFS_BTREE_SEARCH_ROOT_NODE_DESC:
+	case SSDFS_BTREE_SEARCH_FOUND_INDEX_NODE_DESC:
+	case SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  search->node.state);
+		return -ERANGE;
+	}
+
+	if (!search->node.parent) {
+		SSDFS_ERR("parent node is NULL\n");
+		return -ERANGE;
+	}
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height <= 0) {
+		SSDFS_ERR("invalid tree_height %d\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	hierarchy = ssdfs_btree_hierarchy_allocate(tree);
+	if (IS_ERR_OR_NULL(hierarchy)) {
+		err = !hierarchy ? -ENOMEM : PTR_ERR(hierarchy);
+		SSDFS_ERR("fail to allocate tree levels' array: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	down_write(&tree->lock);
+
+	err = ssdfs_check_leaf_node_absence(tree, search);
+	if (err == -EEXIST) {
+		up_write(&tree->lock);
+		SSDFS_DBG("new node has been added\n");
+		return ssdfs_check_leaf_node_state(search);
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to check leaf node absence: "
+			  "err %d\n", err);
+		goto finish_create_node;
+	}
+
+	err = ssdfs_btree_check_hierarchy_for_add(tree, search, hierarchy);
+
+	phase_id = 0;
+	while (err == -EAGAIN) {
+		if (phase_id > SSDFS_BTREE_MODIFICATION_PHASE_MAX) {
+			err = -ERANGE;
+			SSDFS_WARN("too many phases of modification\n");
+			goto finish_create_node;
+		}
+
+		err = ssdfs_btree_process_hierarchy_for_add_nolock(tree,
+								   search,
+								   hierarchy);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to process hierarchy for add: "
+				  "err %d\n", err);
+			goto finish_create_node;
+		}
+
+		ssdfs_btree_hierarchy_free(hierarchy);
+
+		hierarchy = ssdfs_btree_hierarchy_allocate(tree);
+		if (IS_ERR_OR_NULL(hierarchy)) {
+			err = !hierarchy ? -ENOMEM : PTR_ERR(hierarchy);
+			SSDFS_ERR("fail to allocate tree levels' array: "
+				  "err %d\n", err);
+			goto finish_create_node;
+		}
+
+		/* correct parent node */
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		lock = &search->node.child->descriptor_lock;
+		spin_lock(lock);
+		parent_node = search->node.child->parent_node;
+		spin_unlock(lock);
+		lock = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!parent_node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_btree_search_define_parent_node(search, parent_node);
+
+		err = ssdfs_btree_check_hierarchy_for_add(tree, search,
+							  hierarchy);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare info about hierarchy: "
+				  "err %d\n", err);
+			goto finish_create_node;
+		}
+
+		phase_id++;
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare information about hierarchy: "
+			  "err %d\n", err);
+		goto finish_create_node;
+	}
+
+	err = ssdfs_btree_process_hierarchy_for_add_nolock(tree, search,
+							   hierarchy);
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to process hierarchy for add: "
+			  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_create_node;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to process hierarchy for add: "
+			  "err %d\n", err);
+		goto finish_create_node;
+	}
+
+	up_write(&tree->lock);
+
+	if (search->node.parent)
+		complete_all(&search->node.parent->init_end);
+
+	tree_height = atomic_read(&tree->height);
+	for (cur_height = 0; cur_height < tree_height; cur_height++) {
+		level = hierarchy->array_ptr[cur_height];
+
+		if (!need_add_node(level))
+			continue;
+
+		node = level->nodes.new_node.ptr;
+		complete_all(&node->init_end);
+	}
+
+	ssdfs_btree_hierarchy_free(hierarchy);
+
+	search->result.err = 0;
+	search->node.state = SSDFS_BTREE_SEARCH_NODE_DESC_EMPTY;
+	search->result.state = SSDFS_BTREE_SEARCH_UNKNOWN_RESULT;
+	return 0;
+
+finish_create_node:
+	up_write(&tree->lock);
+
+	if (search->node.parent)
+		complete_all(&search->node.parent->init_end);
+
+	if (err != -ENOSPC)
+		ssdfs_show_btree_hierarchy_object(hierarchy);
+
+	ssdfs_btree_hierarchy_free(hierarchy);
+
+	search->result.err = err;
+	search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_convert_index2id() - convert index into node ID
+ * @tree: btree object
+ * @search: search object [in|out]
+ */
+static inline
+int ssdfs_btree_node_convert_index2id(struct ssdfs_btree *tree,
+				      struct ssdfs_btree_search *search)
+{
+	u32 id;
+	u8 height;
+	u8 tree_height;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	id = le32_to_cpu(search->node.found_index.node_id);
+	height = search->node.found_index.height;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, height %u\n",
+		  id, height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (id == SSDFS_BTREE_NODE_INVALID_ID) {
+		SSDFS_ERR("invalid node_id\n");
+		return -ERANGE;
+	}
+
+	tree_height = atomic_read(&tree->height);
+
+	if (height >= tree_height) {
+		SSDFS_ERR("height %u >= tree->height %u\n",
+			  height, tree_height);
+		return -ERANGE;
+	}
+
+	search->node.id = id;
+	search->node.height = height;
+	return 0;
+}
+
+/*
+ * ssdfs_btree_find_right_sibling_leaf_node() - find sibling right leaf node
+ * @tree: btree object
+ * @node: btree node object
+ * @search: search object [in|out]
+ */
+static
+int ssdfs_btree_find_right_sibling_leaf_node(struct ssdfs_btree *tree,
+					     struct ssdfs_btree_node *node,
+					     struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *parent_node = NULL;
+	struct ssdfs_btree_node_index_area area;
+	struct ssdfs_btree_index_key index_key;
+	spinlock_t *lock;
+	size_t desc_len = sizeof(struct ssdfs_btree_node_index_area);
+	u64 start_hash = U64_MAX, end_hash = U64_MAX;
+	u64 search_hash;
+	u16 items_count, items_capacity;
+	u16 index_count = 0;
+	u16 index_capacity = 0;
+	u16 index_position;
+	int node_type;
+	u32 node_id;
+	bool is_found = false;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !node || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("node_id %u, start_hash %llx\n",
+		  node->node_id, search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	lock = &node->descriptor_lock;
+	spin_lock(lock);
+	search_hash = le64_to_cpu(node->node_index.index.hash);
+	node = node->parent_node;
+	spin_unlock(lock);
+	lock = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+
+	switch (atomic_read(&node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		index_count = node->index_area.index_count;
+		index_capacity = node->index_area.index_capacity;
+		break;
+
+	default:
+		err = -ERANGE;
+		break;
+	}
+
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("index area is absent\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_find_index_position(node, search_hash,
+						   &index_position);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find the index position: "
+			  "search_hash %llx, err %d\n",
+			  search_hash, err);
+		return err;
+	}
+
+	index_position++;
+
+	if (index_position >= index_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index_position %u >= index_count %u\n",
+			  index_position, index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+	node_type = atomic_read(&node->type);
+
+	down_read(&node->full_lock);
+
+	if (node_type == SSDFS_BTREE_ROOT_NODE) {
+		err = __ssdfs_btree_root_node_extract_index(node,
+							    index_position,
+							    &index_key);
+	} else {
+		down_read(&node->header_lock);
+		ssdfs_memcpy(&area, 0, desc_len,
+			     &node->index_area, 0, desc_len,
+			     desc_len);
+		up_read(&node->header_lock);
+
+		err = __ssdfs_btree_common_node_extract_index(node,
+							      &area,
+							      index_position,
+							      &index_key);
+	}
+
+	up_read(&node->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract index key: "
+			  "index_position %u, err %d\n",
+			  index_position, err);
+		ssdfs_debug_show_btree_node_indexes(tree, node);
+		return err;
+	}
+
+	parent_node = node;
+	node_id = le32_to_cpu(index_key.node_id);
+
+	err = ssdfs_btree_radix_tree_find(tree, node_id, &node);
+	if (err == -ENOENT) {
+		err = 0;
+		node = __ssdfs_btree_read_node(tree, parent_node,
+						&index_key,
+						index_key.node_type,
+						node_id);
+		if (unlikely(IS_ERR_OR_NULL(node))) {
+			err = !node ? -ENOMEM : PTR_ERR(node);
+			SSDFS_ERR("fail to read: "
+				  "node %llu, err %d\n",
+				  (u64)node_id, err);
+			return err;
+		}
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find node in radix tree: "
+			  "node_id %llu, err %d\n",
+			  (u64)node_id, err);
+		return err;
+	} else if (!node) {
+		SSDFS_WARN("empty node pointer\n");
+		return -ERANGE;
+	}
+
+	ssdfs_btree_search_define_parent_node(search, parent_node);
+	ssdfs_btree_search_define_child_node(search, node);
+
+	ssdfs_memcpy(&search->node.found_index,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     &index_key,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     sizeof(struct ssdfs_btree_index_key));
+
+	err = ssdfs_btree_node_convert_index2id(tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to convert index to ID: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (!is_btree_leaf_node_found(search)) {
+		SSDFS_ERR("leaf node hasn't been found\n");
+		return -ERANGE;
+	}
+
+	node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("corrupted node %u\n",
+			   node->node_id);
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	up_read(&node->header_lock);
+
+	if (start_hash == U64_MAX || end_hash == U64_MAX) {
+		SSDFS_ERR("invalid items area's hash range: "
+			  "start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		return -ERANGE;
+	}
+
+	is_found = start_hash <= search->request.start.hash &&
+		   search->request.start.hash <= end_hash;
+
+	if (!is_found && items_count >= items_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node (start_hash %llx, end_hash %llx), "
+			  "request (start_hash %llx, end_hash %llx), "
+			  "items_count %u, items_capacity %u\n",
+			  start_hash, end_hash,
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  items_count, items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_found_leaf_node() - check found leaf node
+ * @tree: btree object
+ * @search: search object [in|out]
+ */
+static
+int ssdfs_btree_check_found_leaf_node(struct ssdfs_btree *tree,
+				      struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node = NULL;
+	u64 start_hash = U64_MAX, end_hash = U64_MAX;
+	u16 items_count, items_capacity;
+	bool is_found = false;
+	bool is_right_adjacent = false;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, start_hash %llx\n",
+		  tree, search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_btree_leaf_node_found(search)) {
+		SSDFS_ERR("leaf node hasn't been found\n");
+		return -EINVAL;
+	}
+
+	node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("corrupted node %u\n",
+			   node->node_id);
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	up_read(&node->header_lock);
+
+	if (start_hash == U64_MAX || end_hash == U64_MAX) {
+		SSDFS_ERR("invalid items area's hash range: "
+			  "start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		return -ERANGE;
+	}
+
+	is_found = start_hash <= search->request.start.hash &&
+		   search->request.start.hash <= end_hash;
+	is_right_adjacent = search->request.start.hash > end_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node (start_hash %llx, end_hash %llx), "
+		  "request (start_hash %llx, end_hash %llx), "
+		  "is_found %#x, is_right_adjacent %#x, "
+		  "items_count %u, items_capacity %u\n",
+		  start_hash, end_hash,
+		  search->request.start.hash,
+		  search->request.end.hash,
+		  is_found, is_right_adjacent,
+		  items_count, items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (node->tree->type) {
+	case SSDFS_INODES_BTREE:
+		if (!is_found) {
+			SSDFS_DBG("unable to find leaf node\n");
+			goto unable_find_leaf_node;
+		}
+		break;
+
+	default:
+		if (!is_found && items_count >= items_capacity) {
+			if (!is_right_adjacent)
+				goto unable_find_leaf_node;
+
+			err = ssdfs_btree_find_right_sibling_leaf_node(tree,
+									node,
+									search);
+			if (err == -ENOENT) {
+				SSDFS_DBG("unable to find leaf node\n");
+				goto unable_find_leaf_node;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to find leaf node: "
+					  "node %u, err %d\n",
+					  node->node_id, err);
+				return err;
+			}
+		}
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found leaf node: "
+		  "node_id %u, start_hash %llx, "
+		  "end_hash %llx, search_hash %llx\n",
+		  node->node_id, start_hash, end_hash,
+		  search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+
+unable_find_leaf_node:
+	search->node.state = SSDFS_BTREE_SEARCH_FOUND_INDEX_NODE_DESC;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("unable to find a leaf node: "
+		  "start_hash %llx, end_hash %llx, "
+		  "search_hash %llx\n",
+		  start_hash, end_hash,
+		  search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return -ENOENT;
+}
+
+/*
+ * ssdfs_btree_find_leaf_node() - find a leaf node in the tree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to find a leaf node for the requested
+ * start hash and end hash pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - try the old search result.
+ * %-ENOENT     - leaf node hasn't been found.
+ */
+static
+int ssdfs_btree_find_leaf_node(struct ssdfs_btree *tree,
+				struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node;
+	u8 upper_height;
+	u8 prev_height;
+	u64 start_hash = U64_MAX, end_hash = U64_MAX;
+	bool is_found = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, start_hash %llx\n",
+		  tree, search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->node.state == SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try to use old search result: "
+			  "node_id %llu, height %u\n",
+			  (u64)search->node.id, search->node.height);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EEXIST;
+	}
+
+	if (search->request.start.hash == U64_MAX ||
+	    search->request.end.hash == U64_MAX) {
+		SSDFS_ERR("invalid hash range in the request: "
+			  "start_hash %llx, end_hash %llx\n",
+			  search->request.start.hash,
+			  search->request.end.hash);
+		return -ERANGE;
+	}
+
+	upper_height = atomic_read(&tree->height);
+	if (upper_height <= 0) {
+		SSDFS_ERR("invalid tree height %u\n",
+			  upper_height);
+		return -ERANGE;
+	} else
+		upper_height--;
+
+	search->node.id = SSDFS_BTREE_ROOT_NODE_ID;
+	search->node.height = upper_height;
+	search->node.state = SSDFS_BTREE_SEARCH_ROOT_NODE_DESC;
+
+	do {
+		unsigned long prev_id = search->node.id;
+		int node_height;
+		int node_type;
+		prev_height = search->node.height;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u, hash %llx\n",
+			  search->node.id,
+			  search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_btree_search_define_parent_node(search,
+							search->node.child);
+
+		err = ssdfs_btree_radix_tree_find(tree, search->node.id,
+						  &node);
+		if (err == -ENOENT) {
+			err = 0;
+			node = ssdfs_btree_read_node(tree, search);
+			if (unlikely(IS_ERR_OR_NULL(node))) {
+				err = !node ? -ENOMEM : PTR_ERR(node);
+				SSDFS_ERR("fail to read: "
+					  "node %llu, err %d\n",
+					  (u64)search->node.id, err);
+				goto finish_search_leaf_node;
+			}
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find node in radix tree: "
+				  "node_id %llu, err %d\n",
+				  (u64)search->node.id, err);
+			goto finish_search_leaf_node;
+		} else if (!node) {
+			err = -ERANGE;
+			SSDFS_WARN("empty node pointer\n");
+			goto finish_search_leaf_node;
+		}
+
+		ssdfs_btree_search_define_child_node(search, node);
+		node_height = atomic_read(&node->height);
+
+		if (search->node.height != node_height) {
+			err = -ERANGE;
+			SSDFS_WARN("search->height %u != height %u\n",
+				   search->node.height,
+				   node_height);
+			goto finish_search_leaf_node;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(node_height >= U8_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		search->node.height = (u8)node_height;
+
+		if (node_height == SSDFS_BTREE_LEAF_NODE_HEIGHT) {
+			if (upper_height == SSDFS_BTREE_LEAF_NODE_HEIGHT) {
+				/* there is only root node */
+				search->node.state =
+				    SSDFS_BTREE_SEARCH_ROOT_NODE_DESC;
+			} else {
+				search->node.state =
+				    SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC;
+			}
+			goto check_found_node;
+		}
+
+		down_read(&node->header_lock);
+		start_hash = node->index_area.start_hash;
+		end_hash = node->index_area.end_hash;
+		up_read(&node->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u, start_hash %llx, "
+			  "end_hash %llx\n",
+			  node->node_id, start_hash,
+			  end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		node_type = atomic_read(&node->type);
+		if (node_type == SSDFS_BTREE_HYBRID_NODE) {
+			switch (atomic_read(&node->items_area.state)) {
+			case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+				/* expected state */
+				break;
+
+			default:
+				err = -ERANGE;
+				SSDFS_WARN("corrupted node %u\n",
+					   node->node_id);
+				goto finish_search_leaf_node;
+			}
+
+			switch (atomic_read(&node->index_area.state)) {
+			case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+				/* expected state */
+				break;
+
+			default:
+				err = -ERANGE;
+				SSDFS_WARN("corrupted node %u\n",
+					   node->node_id);
+				goto finish_search_leaf_node;
+			}
+
+			down_read(&node->header_lock);
+			start_hash = node->items_area.start_hash;
+			end_hash = node->items_area.end_hash;
+			is_found = start_hash <= search->request.start.hash &&
+				   search->request.start.hash <= end_hash;
+			up_read(&node->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node_id %u, start_hash %llx, "
+				  "end_hash %llx, is_found %#x\n",
+				  node->node_id, start_hash,
+				  end_hash, is_found);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (start_hash < U64_MAX && end_hash == U64_MAX) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid items area's hash range: "
+					  "start_hash %llx, end_hash %llx\n",
+					  start_hash, end_hash);
+				goto finish_search_leaf_node;
+			}
+
+			if (is_found) {
+				search->node.state =
+					SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC;
+				goto check_found_node;
+			} else if (search->request.start.hash > end_hash) {
+				/*
+				 * Hybrid node is exausted already.
+				 * It needs to use this node as
+				 * starting point for adding a new node.
+				 */
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("node_id %u, "
+					  "request.start.hash %llx, "
+					  "end_hash %llx\n",
+					  node->node_id,
+					  search->request.start.hash,
+					  end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				search->node.state =
+					SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC;
+				goto check_found_node;
+			}
+		}
+
+try_find_index:
+		err = ssdfs_btree_node_find_index(search);
+		if (err == -ENODATA) {
+			err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find node index: "
+				  "node_state %#x, node_id %llu, "
+				  "height %u\n",
+				  search->node.state,
+				  (u64)search->node.id,
+				  search->node.height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (upper_height == 0) {
+				search->node.state =
+					SSDFS_BTREE_SEARCH_ROOT_NODE_DESC;
+			} else {
+				search->node.state =
+					SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC;
+			}
+			goto check_found_node;
+		} else if (err == -EACCES) {
+			err = SSDFS_WAIT_COMPLETION(&node->init_end);
+			if (unlikely(err)) {
+				SSDFS_ERR("node init failed: "
+					  "err %d\n", err);
+				goto finish_search_leaf_node;
+			} else
+				goto try_find_index;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find index: "
+				  "start_hash %llx, err %d\n",
+				  search->request.start.hash,
+				  err);
+			goto finish_search_leaf_node;
+		}
+
+		err = ssdfs_btree_node_convert_index2id(tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to convert index to ID: "
+				  "err %d\n", err);
+			goto finish_search_leaf_node;
+		}
+
+		search->node.state = SSDFS_BTREE_SEARCH_FOUND_INDEX_NODE_DESC;
+
+		if (!is_btree_index_search_request_valid(search,
+							 prev_id,
+							 prev_height)) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid index search request: "
+				  "prev_id %llu, prev_height %u, "
+				  "id %llu, height %u\n",
+				  (u64)prev_id, prev_height,
+				  (u64)search->node.id,
+				  search->node.height);
+			goto finish_search_leaf_node;
+		}
+	} while (prev_height > SSDFS_BTREE_LEAF_NODE_HEIGHT);
+
+check_found_node:
+	if (search->node.state == SSDFS_BTREE_SEARCH_ROOT_NODE_DESC) {
+		err = -ENOENT;
+		ssdfs_btree_search_define_parent_node(search,
+						      search->node.child);
+		ssdfs_btree_search_define_child_node(search, NULL);
+		SSDFS_DBG("btree has empty root node\n");
+		goto finish_search_leaf_node;
+	} else if (is_btree_leaf_node_found(search)) {
+		err = ssdfs_btree_check_found_leaf_node(tree, search);
+		if (err)
+			goto finish_search_leaf_node;
+	} else {
+		err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("invalid leaf node descriptor: "
+			   "node_state %#x, node_id %llu, "
+			   "height %u\n",
+			   search->node.state,
+			   (u64)search->node.id,
+			   search->node.height);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+finish_search_leaf_node:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node descriptor: "
+		   "node_state %#x, node_id %llu, "
+		   "height %u\n",
+		   search->node.state,
+		   (u64)search->node.id,
+		   search->node.height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_add_node() - add a node into the btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to add a node into the tree with the goal
+ * to increase capacity of items in the tree. It means that
+ * the new leaf node should be added into the tail of leaf
+ * nodes' chain.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - tree is corrupted.
+ * %-ENOSPC     - unable to add the new node.
+ */
+int ssdfs_btree_add_node(struct ssdfs_btree *tree,
+			 struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+
+	SSDFS_DBG("tree %p, start_hash %llx\n",
+		  tree, search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_BTREE_CREATED:
+	case SSDFS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#else
+		SSDFS_WARN("invalid tree state %#x\n",
+			   atomic_read(&tree->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	fsi = tree->fsi;
+
+	err = ssdfs_reserve_free_pages(fsi, tree->pages_per_node,
+					SSDFS_METADATA_PAGES);
+	if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add the new node: "
+			  "pages_per_node %u, err %d\n",
+			  tree->pages_per_node, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	}
+
+	down_read(&tree->lock);
+	err = ssdfs_btree_find_leaf_node(tree, search);
+	up_read(&tree->lock);
+
+	if (!err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("found leaf node %u\n",
+			  search->node.id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return ssdfs_check_leaf_node_state(search);
+	} else if (err == -ENOENT) {
+		/*
+		 * Parent node was found.
+		 */
+		err = 0;
+	} else {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define the parent node: "
+			  "hash %llx, err %d\n",
+			  search->request.start.hash,
+			  err);
+		return err;
+	}
+
+	err = __ssdfs_btree_add_node(tree, search);
+	if (err == -EEXIST) {
+		SSDFS_DBG("node has been added\n");
+	} else if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add a new node: err %d\n",
+			  err);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to add a new node: err %d\n",
+			  err);
+	}
+
+	ssdfs_debug_btree_object(tree);
+	ssdfs_check_btree_consistency(tree);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_insert_node() - insert a node into the btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to insert a node into the tree for
+ * the requested hash value.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - tree is corrupted.
+ * %-ENOSPC     - unable to insert the new node.
+ */
+int ssdfs_btree_insert_node(struct ssdfs_btree *tree,
+			    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+
+	SSDFS_DBG("tree %p, start_hash %llx\n",
+		  tree, search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_BTREE_CREATED:
+	case SSDFS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#else
+		SSDFS_WARN("invalid tree state %#x\n",
+			   atomic_read(&tree->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	fsi = tree->fsi;
+
+	err = ssdfs_reserve_free_pages(fsi, tree->pages_per_node,
+					SSDFS_METADATA_PAGES);
+	if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add the new node: "
+			  "pages_per_node %u, err %d\n",
+			  tree->pages_per_node, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	}
+
+	err = __ssdfs_btree_add_node(tree, search);
+	if (err == -EEXIST)
+		SSDFS_DBG("node has been added\n");
+	else if (unlikely(err)) {
+		SSDFS_ERR("fail to add a new node: err %d\n",
+			  err);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+
+	ssdfs_debug_btree_object(tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_check_btree_consistency(tree);
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_invalidate_node() - invalidate the node in the segment
+ * @node: node object
+ *
+ * This method tries to invalidate the node
+ * in the current segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - tree is corrupted.
+ */
+static
+int ssdfs_segment_invalidate_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_segment_info *seg;
+	u32 start_blk;
+	u32 len;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&node->descriptor_lock);
+	start_blk = le32_to_cpu(node->extent.logical_blk);
+	len = le32_to_cpu(node->extent.len);
+	seg = node->seg;
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!seg);
+
+	SSDFS_DBG("node_id %u, seg_id %llu, start_blk %u, len %u\n",
+		  node->node_id, seg->seg_id, start_blk, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_segment_invalidate_logical_extent(seg, start_blk, len);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to invalidate node: "
+			  "node_id %u, seg_id %llu, "
+			  "start_blk %u, len %u\n",
+			  node->node_id, seg->seg_id,
+			  start_blk, len);
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_delete_index_in_parent_node() - delete index in parent node
+ * @tree: btree object
+ * @search: search object
+ *
+ * This method tries to delete the index records in all parent nodes.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - tree is corrupted.
+ */
+static
+int ssdfs_btree_delete_index_in_parent_node(struct ssdfs_btree *tree,
+					    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_hierarchy *hierarchy;
+	struct ssdfs_btree_level *level;
+	struct ssdfs_btree_node *node;
+	int cur_height, tree_height;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+
+	SSDFS_DBG("tree %p, start_hash %llx\n",
+		  tree, search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_BTREE_CREATED:
+	case SSDFS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#else
+		SSDFS_WARN("invalid tree state %#x\n",
+			   atomic_read(&tree->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	switch (search->node.state) {
+	case SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  search->node.state);
+		return -ERANGE;
+	}
+
+	if (!search->node.child) {
+		SSDFS_ERR("child node is NULL\n");
+		return -ERANGE;
+	}
+
+	if (!search->node.parent) {
+		SSDFS_ERR("parent node is NULL\n");
+		return -ERANGE;
+	}
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height <= 0) {
+		SSDFS_ERR("invalid tree_height %u\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	hierarchy = ssdfs_btree_hierarchy_allocate(tree);
+	if (IS_ERR_OR_NULL(hierarchy)) {
+		err = !hierarchy ? -ENOMEM : PTR_ERR(hierarchy);
+		SSDFS_ERR("fail to allocate tree levels' array: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	err = ssdfs_btree_check_hierarchy_for_delete(tree, search, hierarchy);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare information about hierarchy: "
+			  "err %d\n",
+			  err);
+		goto finish_delete_index;
+	}
+
+	for (cur_height = 0; cur_height < tree_height; cur_height++) {
+		err = ssdfs_btree_process_level_for_delete(hierarchy,
+							   cur_height,
+							   search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to process the tree's level: "
+				  "cur_height %u, err %d\n",
+				  cur_height, err);
+			goto finish_delete_index;
+		}
+	}
+
+	for (cur_height = 0; cur_height < (tree_height - 1); cur_height++) {
+		level = hierarchy->array_ptr[cur_height];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cur_height %d, tree_height %d\n",
+			  cur_height, tree_height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (!need_delete_node(level))
+			continue;
+
+		node = level->nodes.old_node.ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node);
+		SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		set_ssdfs_btree_node_pre_deleted(node);
+
+		err = ssdfs_segment_invalidate_node(node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to invalidate node: id %u, err %d\n",
+				  node->node_id, err);
+		}
+	}
+
+	atomic_set(&tree->state, SSDFS_BTREE_DIRTY);
+	ssdfs_btree_hierarchy_free(hierarchy);
+
+	ssdfs_btree_search_define_child_node(search, NULL);
+	search->result.err = 0;
+	search->result.state = SSDFS_BTREE_SEARCH_UNKNOWN_RESULT;
+	return 0;
+
+finish_delete_index:
+	ssdfs_btree_hierarchy_free(hierarchy);
+
+	search->result.err = err;
+	search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+	return err;
+}
+
+/*
+ * ssdfs_btree_delete_node() - delete the node from the btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to delete a node from the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - cannot delete the node.
+ * %-EBUSY      - node has several owners.
+ */
+int ssdfs_btree_delete_node(struct ssdfs_btree *tree,
+			    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node;
+	u16 items_count;
+	u16 items_capacity;
+	u16 index_count;
+	u16 index_capacity;
+	bool cannot_delete = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, start_hash %llx\n",
+		  tree, search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_BTREE_CREATED:
+	case SSDFS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#else
+		SSDFS_WARN("invalid tree state %#x\n",
+			   atomic_read(&tree->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_PLEASE_DELETE_NODE) {
+		SSDFS_ERR("invalid search->result.state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	switch (search->node.state) {
+	case SSDFS_BTREE_SEARCH_FOUND_INDEX_NODE_DESC:
+	case SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_SEARCH_ROOT_NODE_DESC:
+		SSDFS_ERR("fail to delete root node\n");
+		return -ERANGE;
+
+	default:
+		BUG();
+	}
+
+	if (!search->node.child) {
+		SSDFS_ERR("child node pointer is NULL\n");
+		return -ERANGE;
+	}
+
+	if (!search->node.parent) {
+		SSDFS_ERR("parent node pointer is NULL\n");
+		return -ERANGE;
+	}
+
+	node = search->node.child;
+
+	if (node->node_id != search->node.id ||
+	    atomic_read(&node->height) != search->node.height) {
+		SSDFS_ERR("corrupted search object: "
+			  "node->node_id %u, search->node.id %u, "
+			  "node->height %u, search->node.height %u\n",
+			  node->node_id, search->node.id,
+			  atomic_read(&node->height),
+			  search->node.height);
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state: id %u, state %#x\n",
+			  node->node_id,
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	index_count = node->index_area.index_count;
+	index_capacity = node->index_area.index_capacity;
+	if (items_count != 0)
+		cannot_delete = true;
+	if (index_count != 0)
+		cannot_delete = true;
+	up_read(&node->header_lock);
+
+	if (cannot_delete) {
+		SSDFS_ERR("node has content in index/items area: "
+			  "items_count %u, items_capacity %u, "
+			  "index_count %u, index_capacity %u\n",
+			  items_count, items_capacity,
+			  index_count, index_capacity);
+		return -EFAULT;
+	}
+
+	if (is_ssdfs_node_shared(node)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u has several owners %d\n",
+			  node->node_id,
+			  atomic_read(&node->refs_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EBUSY;
+	}
+
+	down_write(&tree->lock);
+	err = ssdfs_btree_delete_index_in_parent_node(tree, search);
+	up_write(&tree->lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete index from parent node: "
+			  "err %d\n", err);
+	}
+
+	ssdfs_debug_btree_object(tree);
+	ssdfs_check_btree_consistency(tree);
+
+	return err;
+}
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2396A265B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBYBTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBYBRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:39 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05CA24487
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:19 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t22so778452oiw.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np2P0rGlao8eryLzY9RQxOCrCGk/xgT1ye7crkmQ1i8=;
        b=n1fypWCLSpS75pNxtHz0nk6T+7q3tL2l+Kjrhk5O153mHiGwFAjlTnAmo0Fq+ODsbB
         3nGKNCvGD1w2CldtLojkdChO260gxE+RVUvKVgIP/NwLGeT9cWQPHV9HRtp7czyZFbRM
         QFnDRW+1nm8LzoWJiflb0aC23NOBerbEipPE1AWP4apJTmp/patLL/rd8p+N0emfrcEi
         p2C+c1KFj+LI3R6DP9r+fOhZb9CYYqSBmmWrLOzLW+Lvt9xGxJKNPNBbYxkNYx0lRwP8
         vBw+LkRbNWfkcetMtLTZDo9bztVIIzTeOdP7+fYD5aj6l0vth6bu2NH3pWOuOydRKUOV
         HS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np2P0rGlao8eryLzY9RQxOCrCGk/xgT1ye7crkmQ1i8=;
        b=tx5nWP0wmPtEGkfb/bgx+Nu6p0dxVLSYZT9G9vAmt2h9LxMZXHmbjifltH3K5emP9C
         4SRsuOnM4KXMtISV54bqVqn/qKDQOfvuLK7pdM933aaO0PJGwn2napD8IUfVPGxESUdK
         DCGjOtEyWhl2w3wOdPmpfoyojquWH25RXJxtXv64zzW/tRCzyv9oSke2uQQTYqFscV1A
         iDoFIPtEoSbOZBsuNZI4C/mTOmZsi3JURrs3szlnQYVtvbCsWr8k/SHZA455nkvcAZ+F
         T89oK5natx2HwdOzet/7iROcLKLaQ4a/ZVDO/pMCOtm9ZH33MHeL4TrbGj8DPgU9nMJ1
         ztTg==
X-Gm-Message-State: AO0yUKVCt0G0mzD8Fz11hh2Q0BY644n9M1mYTbKgJpy/wFzAF0sxPixu
        iOvo/87iHPqKALIgkRM97hk2vKE9Nk1r6InI
X-Google-Smtp-Source: AK7set8hJBCUkPIwnpYIP27tO0iC/uCcXhxf1UBaE6xamngazcZgK3HU/4Nwns54tZxzCgI7WuMLig==
X-Received: by 2002:a05:6808:634d:b0:364:7d13:acf with SMTP id eb13-20020a056808634d00b003647d130acfmr4744113oib.13.1677287838339;
        Fri, 24 Feb 2023 17:17:18 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:17 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 49/76] ssdfs: b-tree API implementation
Date:   Fri, 24 Feb 2023 17:09:00 -0800
Message-Id: <20230225010927.813929-50-slava@dubeyko.com>
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

Generalized b-tree functionality implements API:
(1) create - create empty b-tree object
(2) destroy - destroy b-tree object
(3) flush - flush dirty b-tree object
(4) find_item - find item in b-tree hierarchy
(5) find_range - find range of items in b-tree hierarchy
(6) allocate_item - allocate item in existing b-tree's node
(7) allocate_range - allocate range of items in existing b-tree's node
(8) add_item - add item into b-tree
(9) add_range - add range of items into b-tree
(10) change_item - change existing item in b-tree
(11) delete_item - delete item from b-tree
(12) delete_range - delete range of items from b-tree
(13) delete_all - delete all items from b-tree

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree.c | 3713 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 3713 insertions(+)

diff --git a/fs/ssdfs/btree.c b/fs/ssdfs/btree.c
index d7778cdb67a1..f88f599a72df 100644
--- a/fs/ssdfs/btree.c
+++ b/fs/ssdfs/btree.c
@@ -4072,3 +4072,3716 @@ int ssdfs_btree_delete_node(struct ssdfs_btree *tree,
 
 	return err;
 }
+
+/*
+ * node_needs_in_additional_check() - does it need to check the node?
+ * @err: error code
+ * @search: search object
+ */
+static inline
+bool node_needs_in_additional_check(int err,
+				    struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err == -ENODATA &&
+		search->result.state == SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE;
+}
+
+/*
+ * ssdfs_btree_switch_on_hybrid_parent_node() - change current node
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to change the current node on hybrid parent one.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - item can be added.
+ * %-ENOENT     - no space for a new item.
+ */
+static
+int ssdfs_btree_switch_on_hybrid_parent_node(struct ssdfs_btree *tree,
+					     struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node;
+	int state;
+	u64 start_hash, end_hash;
+	u16 items_count, items_capacity;
+	u16 free_items;
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, type %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "result->err %d, result->state %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type,
+		  search->request.type, search->request.flags,
+		  search->result.err,
+		  search->result.state,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->result.err != -ENODATA) {
+		SSDFS_ERR("unexpected result's error %d\n",
+			  search->result.err);
+		return -ERANGE;
+	}
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE) {
+		SSDFS_ERR("unexpected result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->request.start.hash == U64_MAX ||
+	    search->request.end.hash == U64_MAX) {
+		SSDFS_ERR("invalid request: "
+			  "start_hash %llx, end_hash %llx\n",
+			  search->request.start.hash,
+			  search->request.end.hash);
+		return -ERANGE;
+	}
+
+	node = search->node.child;
+	if (!node) {
+		node = search->node.parent;
+
+		if (!node) {
+			SSDFS_ERR("corrupted search request: "
+				  "child and parent nodes are NULL\n");
+			return -ERANGE;
+		}
+
+		if (atomic_read(&node->type) == SSDFS_BTREE_ROOT_NODE) {
+			SSDFS_DBG("parent is root node\n");
+			return -ENOENT;
+		} else {
+			SSDFS_ERR("corrupted search request: "
+				  "child nodes is NULL\n");
+			return -ERANGE;
+		}
+	}
+
+	if (atomic_read(&node->type) == SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_DBG("child is root node\n");
+		return -ENOENT;
+	}
+
+	state = atomic_read(&node->items_area.state);
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid items area's state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	up_read(&node->header_lock);
+
+	if (start_hash == U64_MAX || end_hash == U64_MAX) {
+		SSDFS_ERR("corrupted items area: "
+			  "start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		return -ERANGE;
+	}
+
+	if (start_hash > end_hash) {
+		SSDFS_ERR("corrupted items area: "
+			  "start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		return -ERANGE;
+	}
+
+	if (items_count > items_capacity) {
+		SSDFS_ERR("corrupted items area: "
+			  "items_count %u, items_capacity %u\n",
+			  items_count, items_capacity);
+		return -ERANGE;
+	}
+
+	free_items = items_capacity - items_count;
+
+	if (free_items != 0) {
+		SSDFS_WARN("invalid free_items %u, "
+			   "items_count %u, items_capacity %u\n",
+			   free_items, items_count, items_capacity);
+		return -ERANGE;
+	}
+
+	node = search->node.parent;
+	if (!node) {
+		SSDFS_ERR("corrupted search request: parent node is NULL\n");
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		/* nothing can be done */
+		SSDFS_DBG("node is root or index\n");
+		return -ENOENT;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* it needs to check the node's state */
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		SSDFS_WARN("btree is corrupted: "
+			   "leaf node %u cannot be the parent\n",
+			   node->node_id);
+		return -ERANGE;
+
+	default:
+		SSDFS_ERR("invalid node's type %#x\n",
+			  atomic_read(&node->type));
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
+		SSDFS_WARN("invalid node's %u state %#x\n",
+			   node->node_id,
+			   atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	flags = atomic_read(&node->flags);
+
+	if (!(flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA)) {
+		SSDFS_WARN("hybrid node %u hasn't items area\n",
+			   node->node_id);
+		return -ENOENT;
+	}
+
+	ssdfs_btree_search_define_child_node(search, node);
+
+	spin_lock(&node->descriptor_lock);
+	ssdfs_btree_search_define_parent_node(search, node->parent_node);
+	spin_unlock(&node->descriptor_lock);
+
+	ssdfs_memcpy(&search->node.found_index,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     &node->node_index,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     sizeof(struct ssdfs_btree_index_key));
+
+	err = ssdfs_btree_node_convert_index2id(tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to convert index to ID: "
+			  "node %u, height %u\n",
+			  node->node_id,
+			  atomic_read(&node->height));
+		return err;
+	}
+
+	down_read(&node->header_lock);
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	up_read(&node->header_lock);
+
+	free_items = items_capacity - items_count;
+
+	if (free_items == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is exhausted: free_items %u, "
+			   "items_count %u, items_capacity %u\n",
+			   node->node_id,
+			   free_items, items_count, items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		search->result.state = SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE;
+		return -ENOENT;
+	}
+
+	if (items_count == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is empty: free_items %u, "
+			   "items_count %u, items_capacity %u\n",
+			   node->node_id,
+			   free_items, items_count, items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_node_check;
+	}
+
+	if (search->request.start.hash < start_hash) {
+		if (search->request.end.hash < start_hash) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("request (start_hash %llx, end_hash %llx), "
+				  "area (start_hash %llx, end_hash %llx)\n",
+				  search->request.start.hash,
+				  search->request.end.hash,
+				  start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_node_check;
+		} else {
+			SSDFS_ERR("invalid request: "
+				  "request (start_hash %llx, end_hash %llx), "
+				  "area (start_hash %llx, end_hash %llx)\n",
+				  search->request.start.hash,
+				  search->request.end.hash,
+				  start_hash, end_hash);
+			return -ERANGE;
+		}
+	}
+
+finish_node_check:
+	search->node.state = SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC;
+	search->result.state = SSDFS_BTREE_SEARCH_OUT_OF_RANGE;
+	search->result.err = -ENODATA;
+
+	if (items_count == 0)
+		search->result.start_index = 0;
+	else
+		search->result.start_index = items_count;
+
+	search->result.count = search->request.count;
+	search->result.search_cno = ssdfs_current_cno(tree->fsi->sb);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, items_count %u, items_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  node->node_id, items_count, items_capacity,
+		  start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return -ENODATA;
+}
+
+/*
+ * __ssdfs_btree_find_item() - find item into btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to find an item into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - item hasn't been found
+ * %-ENOSPC     - node hasn't free space.
+ */
+static
+int __ssdfs_btree_find_item(struct ssdfs_btree *tree,
+			    struct ssdfs_btree_search *search)
+{
+	int tree_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_request_valid(search)) {
+		SSDFS_ERR("invalid search object\n");
+		return -EINVAL;
+	}
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_FIND_ITEM:
+	case SSDFS_BTREE_SEARCH_ALLOCATE_ITEM:
+	case SSDFS_BTREE_SEARCH_ALLOCATE_RANGE:
+	case SSDFS_BTREE_SEARCH_ADD_ITEM:
+	case SSDFS_BTREE_SEARCH_ADD_RANGE:
+	case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+	case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -EINVAL;
+	}
+
+	err = ssdfs_btree_find_leaf_node(tree, search);
+	if (err == -EEXIST) {
+		err = 0;
+		/* try to find an item */
+	} else if (err == -ENOENT) {
+		err = -ENODATA;
+		search->result.err = -ENODATA;
+		search->result.state = SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index node was found\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+			err = ssdfs_btree_switch_on_hybrid_parent_node(tree,
+									search);
+			if (err == -ENODATA)
+				goto finish_search_item;
+			else if (err == -ENOENT) {
+				err = -ENODATA;
+				goto finish_search_item;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to switch on parent node: "
+					  "err %d\n", err);
+			} else {
+				err = -ENODATA;
+				goto finish_search_item;
+			}
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		goto finish_search_item;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find leaf node: err %d\n",
+			  err);
+		goto finish_search_item;
+	}
+
+	if (search->request.type == SSDFS_BTREE_SEARCH_ADD_ITEM) {
+try_another_node:
+		err = ssdfs_btree_node_find_item(search);
+		if (node_needs_in_additional_check(err, search)) {
+			search->result.err = -ENODATA;
+			err = ssdfs_btree_switch_on_hybrid_parent_node(tree,
+									search);
+			if (err == -ENODATA)
+				goto finish_search_item;
+			else if (err == -ENOENT) {
+				err = -ENODATA;
+				goto finish_search_item;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to switch on parent node: "
+					  "err %d\n", err);
+				goto finish_search_item;
+			} else {
+				err = -ENODATA;
+				goto finish_search_item;
+			}
+		} else if (err == -EACCES) {
+			struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = SSDFS_WAIT_COMPLETION(&node->init_end);
+			if (unlikely(err)) {
+				SSDFS_ERR("node init failed: "
+					  "err %d\n", err);
+				goto finish_search_item;
+			} else
+				goto try_another_node;
+		}
+	} else {
+try_find_item_again:
+		err = ssdfs_btree_node_find_item(search);
+		if (err == -EACCES) {
+			struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = SSDFS_WAIT_COMPLETION(&node->init_end);
+			if (unlikely(err)) {
+				SSDFS_ERR("node init failed: "
+					  "err %d\n", err);
+				goto finish_search_item;
+			} else
+				goto try_find_item_again;
+		}
+	}
+
+	if (err == -EAGAIN) {
+		if (search->result.items_in_buffer > 0 &&
+		    search->result.state == SSDFS_BTREE_SEARCH_VALID_ITEM) {
+			/* finish search */
+			err = 0;
+			search->result.err = 0;
+			goto finish_search_item;
+		} else {
+			err = -ENODATA;
+			SSDFS_DBG("node hasn't requested data\n");
+			goto finish_search_item;
+		}
+	} else if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find item: "
+			  "start_hash %llx, end_hash %llx\n",
+			  search->request.start.hash,
+			  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_search_item;
+	} else if (err == -ENOSPC) {
+		err = -ENODATA;
+		search->result.state = SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE;
+		SSDFS_DBG("index node was found\n");
+		goto finish_search_item;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find item: "
+			  "start_hash %llx, end_hash %llx, "
+			  "err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_search_item;
+	}
+
+finish_search_item:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search->result.state %#x, err %d\n",
+		  search->result.state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_find_item() - find item into btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to find an item into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - item hasn't been found
+ */
+int ssdfs_btree_find_item(struct ssdfs_btree *tree,
+			  struct ssdfs_btree_search *search)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, type %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&tree->lock);
+	err = __ssdfs_btree_find_item(tree, search);
+	up_read(&tree->lock);
+
+	return err;
+}
+
+/*
+ * __ssdfs_btree_find_range() - find a range of items into btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to find a range of item into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_btree_find_range(struct ssdfs_btree *tree,
+			     struct ssdfs_btree_search *search)
+{
+	int tree_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_request_valid(search)) {
+		SSDFS_ERR("invalid search object\n");
+		return -EINVAL;
+	}
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_FIND_RANGE:
+	case SSDFS_BTREE_SEARCH_ADD_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -EINVAL;
+	}
+
+try_next_search:
+	err = ssdfs_btree_find_leaf_node(tree, search);
+	if (err == -EEXIST) {
+		err = 0;
+		/* try to find an item */
+	} else if (err == -ENOENT) {
+		err = -ENODATA;
+		search->result.err = -ENODATA;
+		search->result.state = SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE;
+		SSDFS_DBG("index node was found\n");
+
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+			err = ssdfs_btree_switch_on_hybrid_parent_node(tree,
+									search);
+			if (err == -ENODATA) {
+				/*
+				 * do nothing
+				 */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to switch on parent node: "
+					  "err %d\n", err);
+			} else {
+				/* finish search */
+				err = -ENODATA;
+			}
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		goto finish_search_range;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find leaf node: err %d\n",
+			  err);
+		goto finish_search_range;
+	}
+
+	if (search->request.type == SSDFS_BTREE_SEARCH_ADD_RANGE) {
+try_another_node:
+		err = ssdfs_btree_node_find_range(search);
+
+		if (node_needs_in_additional_check(err, search)) {
+			search->result.err = -ENODATA;
+			err = ssdfs_btree_switch_on_hybrid_parent_node(tree,
+									search);
+			if (err == -ENODATA)
+				goto finish_search_range;
+			else if (unlikely(err)) {
+				SSDFS_ERR("fail to switch on parent node: "
+					  "err %d\n", err);
+				goto finish_search_range;
+			} else {
+				/* finish search */
+				err = -ENODATA;
+				goto finish_search_range;
+			}
+		} else if (err == -EACCES) {
+			struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = SSDFS_WAIT_COMPLETION(&node->init_end);
+			if (unlikely(err)) {
+				SSDFS_ERR("node init failed: "
+					  "err %d\n", err);
+				goto finish_search_range;
+			} else
+				goto try_another_node;
+		}
+	} else {
+try_find_range_again:
+		err = ssdfs_btree_node_find_range(search);
+		if (err == -EACCES) {
+			struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = SSDFS_WAIT_COMPLETION(&node->init_end);
+			if (unlikely(err)) {
+				SSDFS_ERR("node init failed: "
+					  "err %d\n", err);
+				goto finish_search_range;
+			} else
+				goto try_find_range_again;
+		}
+	}
+
+	if (err == -EAGAIN) {
+		if (search->result.items_in_buffer > 0 &&
+		    search->result.state == SSDFS_BTREE_SEARCH_VALID_ITEM) {
+			/* finish search */
+			err = 0;
+			search->result.err = 0;
+			goto finish_search_range;
+		} else {
+			err = 0;
+			search->node.state = SSDFS_BTREE_SEARCH_NODE_DESC_EMPTY;
+			SSDFS_DBG("try next search\n");
+			goto try_next_search;
+		}
+	} else if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find range: "
+			  "start_hash %llx, end_hash %llx\n",
+			  search->request.start.hash,
+			  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_search_range;
+	} else if (err == -ENOSPC) {
+		err = -ENODATA;
+		search->result.state = SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE;
+		SSDFS_DBG("index node was found\n");
+		goto finish_search_range;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find range: "
+			  "start_hash %llx, end_hash %llx, "
+			  "err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_search_range;
+	}
+
+finish_search_range:
+	return err;
+}
+
+/*
+ * ssdfs_btree_find_range() - find a range of items into btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to find a range of item into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_find_range(struct ssdfs_btree *tree,
+			   struct ssdfs_btree_search *search)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, type %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&tree->lock);
+	err = __ssdfs_btree_find_range(tree, search);
+	up_read(&tree->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_allocate_item() - allocate item into btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to allocate the item into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_allocate_item(struct ssdfs_btree *tree,
+			      struct ssdfs_btree_search *search)
+{
+	int tree_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#else
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_request_valid(search)) {
+		SSDFS_ERR("invalid search object\n");
+		return -EINVAL;
+	}
+
+	if (search->request.type != SSDFS_BTREE_SEARCH_ALLOCATE_ITEM) {
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -EINVAL;
+	}
+
+	down_read(&tree->lock);
+
+try_next_search:
+	err = ssdfs_btree_find_leaf_node(tree, search);
+	if (err == -EEXIST) {
+		err = 0;
+		/* try the old search result */
+	} else if (err == -ENOENT) {
+		err = -ENODATA;
+		search->result.err = -ENODATA;
+		search->result.state = SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index node was found\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		up_read(&tree->lock);
+		err = ssdfs_btree_insert_node(tree, search);
+		down_read(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert node: err %d\n",
+				  err);
+			goto finish_allocate_item;
+		}
+
+		err = ssdfs_btree_find_leaf_node(tree, search);
+		if (err == -EEXIST) {
+			err = 0;
+			/* try the old search result */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find leaf node: err %d\n",
+				  err);
+			goto finish_allocate_item;
+		}
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find leaf node: err %d\n",
+			  err);
+		goto finish_allocate_item;
+	}
+
+try_allocate_item:
+	err = ssdfs_btree_node_allocate_item(search);
+	if (err == -EAGAIN) {
+		err = 0;
+		search->node.state = SSDFS_BTREE_SEARCH_NODE_DESC_EMPTY;
+		goto try_next_search;
+	} else if (err == -EACCES) {
+		struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = SSDFS_WAIT_COMPLETION(&node->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("node init failed: "
+				  "err %d\n", err);
+			goto finish_allocate_item;
+		} else
+			goto try_allocate_item;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate item: "
+			  "start_hash %llx, end_hash %llx, "
+			  "err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_allocate_item;
+	}
+
+	atomic_set(&tree->state, SSDFS_BTREE_DIRTY);
+
+finish_allocate_item:
+	up_read(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_btree_object(tree);
+
+#ifdef CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK
+	ssdfs_check_btree_consistency(tree);
+#endif /* CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_allocate_range() - allocate range of items into btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to allocate the range of items into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_allocate_range(struct ssdfs_btree *tree,
+				struct ssdfs_btree_search *search)
+{
+	int tree_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#else
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_request_valid(search)) {
+		SSDFS_ERR("invalid search object\n");
+		return -EINVAL;
+	}
+
+	if (search->request.type != SSDFS_BTREE_SEARCH_ALLOCATE_RANGE) {
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -EINVAL;
+	}
+
+	down_read(&tree->lock);
+
+try_next_search:
+	err = ssdfs_btree_find_leaf_node(tree, search);
+	if (err == -EEXIST) {
+		err = 0;
+		/* try the old search result */
+	} else if (err == -ENOENT) {
+		err = -ENODATA;
+		search->result.err = -ENODATA;
+		search->result.state = SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index node was found\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		up_read(&tree->lock);
+		err = ssdfs_btree_insert_node(tree, search);
+		down_read(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert node: err %d\n",
+				  err);
+			goto finish_allocate_range;
+		}
+
+		err = ssdfs_btree_find_leaf_node(tree, search);
+		if (err == -EEXIST) {
+			err = 0;
+			/* try the old search result */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find leaf node: err %d\n",
+				  err);
+			goto finish_allocate_range;
+		}
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find leaf node: err %d\n",
+			  err);
+		goto finish_allocate_range;
+	}
+
+try_allocate_range:
+	err = ssdfs_btree_node_allocate_range(search);
+	if (err == -EAGAIN) {
+		err = 0;
+		search->node.state = SSDFS_BTREE_SEARCH_NODE_DESC_EMPTY;
+		goto try_next_search;
+	} else if (err == -EACCES) {
+		struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = SSDFS_WAIT_COMPLETION(&node->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("node init failed: "
+				  "err %d\n", err);
+			goto finish_allocate_range;
+		} else
+			goto try_allocate_range;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate range: "
+			  "start_hash %llx, end_hash %llx, "
+			  "err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_allocate_range;
+	}
+
+	atomic_set(&tree->state, SSDFS_BTREE_DIRTY);
+
+finish_allocate_range:
+	up_read(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_btree_object(tree);
+
+#ifdef CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK
+	ssdfs_check_btree_consistency(tree);
+#endif /* CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK */
+
+	return err;
+}
+
+/*
+ * need_update_parent_node() - check necessity to update index in parent node
+ * @search: search object
+ */
+static inline
+bool need_update_parent_node(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *child;
+	u64 start_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_hash = search->request.start.hash;
+
+	child = search->node.child;
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return need_update_parent_index_area(start_hash, child);
+}
+
+/*
+ * ssdfs_btree_update_index_in_parent_node() - update index in parent node
+ * @tree: btree object
+ * @search: search object [in|out]
+ * @ptr: hierarchy object
+ *
+ * This method tries to update an index in parent nodes.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_update_index_in_parent_node(struct ssdfs_btree *tree,
+					    struct ssdfs_btree_search *search,
+					    struct ssdfs_btree_hierarchy *ptr)
+{
+	int cur_height, tree_height;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !ptr);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, hierarchy %p\n",
+		  tree, ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height <= 0) {
+		SSDFS_ERR("invalid tree_height %u\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	for (cur_height = 0; cur_height < tree_height; cur_height++) {
+		err = ssdfs_btree_process_level_for_update(ptr,
+							   cur_height,
+							   search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to process the tree's level: "
+				  "cur_height %u, err %d\n",
+				  cur_height, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_add_item() - add item into btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to add the item into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - item exists in the tree.
+ */
+int ssdfs_btree_add_item(struct ssdfs_btree *tree,
+			 struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_hierarchy *hierarchy = NULL;
+	int tree_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#else
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_request_valid(search)) {
+		SSDFS_ERR("invalid search object\n");
+		return -EINVAL;
+	}
+
+	if (search->request.type != SSDFS_BTREE_SEARCH_ADD_ITEM) {
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -EINVAL;
+	}
+
+	down_read(&tree->lock);
+
+try_find_item:
+	err = __ssdfs_btree_find_item(tree, search);
+	if (!err) {
+		err = -EEXIST;
+		SSDFS_ERR("item exists in the tree: "
+			  "start_hash %llx, end_hash %llx\n",
+			  search->request.start.hash,
+			  search->request.end.hash);
+		goto finish_add_item;
+	} else if (err == -ENODATA) {
+		err = 0;
+		switch (search->result.state) {
+		case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+		case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+			/* position in node was found */
+			break;
+		case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+			/* none node is able to store the new item */
+			break;
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid search result: "
+				  "start_hash %llx, end_hash %llx, "
+				  "state %#x\n",
+				  search->request.start.hash,
+				  search->request.end.hash,
+				  search->result.state);
+			goto finish_add_item;
+		};
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find item: "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_add_item;
+	}
+
+	if (search->result.state == SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE) {
+		up_read(&tree->lock);
+		err = ssdfs_btree_insert_node(tree, search);
+		down_read(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert node: err %d\n",
+				  err);
+			goto finish_add_item;
+		}
+
+		err = __ssdfs_btree_find_item(tree, search);
+		if (!err) {
+			err = -EEXIST;
+			SSDFS_ERR("item exists in the tree: "
+				  "start_hash %llx, end_hash %llx\n",
+				  search->request.start.hash,
+				  search->request.end.hash);
+			goto finish_add_item;
+		} else if (err == -ENODATA) {
+			err = 0;
+			switch (search->result.state) {
+			case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+			case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+				/* position in node was found */
+				break;
+			default:
+				err = -ERANGE;
+				SSDFS_ERR("invalid search result: "
+					  "start_hash %llx, end_hash %llx, "
+					  "state %#x\n",
+					  search->request.start.hash,
+					  search->request.end.hash,
+					  search->result.state);
+				goto finish_add_item;
+			};
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find item: "
+				  "start_hash %llx, end_hash %llx, err %d\n",
+				  search->request.start.hash,
+				  search->request.end.hash,
+				  err);
+			goto finish_add_item;
+		}
+	}
+
+try_insert_item:
+	err = ssdfs_btree_node_insert_item(search);
+	if (err == -EACCES) {
+		struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = SSDFS_WAIT_COMPLETION(&node->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("node init failed: "
+				  "err %d\n", err);
+			goto finish_add_item;
+		} else
+			goto try_insert_item;
+	} else if (err == -EFBIG) {
+		int state = search->result.state;
+
+		err = 0;
+
+		if (state != SSDFS_BTREE_SEARCH_PLEASE_MOVE_BUF_CONTENT) {
+			err = -ERANGE;
+			SSDFS_WARN("invalid search's result state %#x\n",
+				   state);
+			goto finish_add_item;
+		} else
+			goto try_find_item;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to insert item: "
+			  "start_hash %llx, end_hash %llx, "
+			  "err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_add_item;
+	}
+
+	if (need_update_parent_node(search)) {
+		hierarchy = ssdfs_btree_hierarchy_allocate(tree);
+		if (!hierarchy) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate tree levels' array\n");
+			goto finish_add_item;
+		}
+
+		err = ssdfs_btree_check_hierarchy_for_update(tree, search,
+								hierarchy);
+		if (unlikely(err)) {
+			atomic_set(&search->node.child->state,
+				    SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to prepare hierarchy information : "
+				  "err %d\n",
+				  err);
+			goto finish_update_parent;
+		}
+
+		err = ssdfs_btree_update_index_in_parent_node(tree, search,
+							      hierarchy);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update index records: "
+				  "err %d\n",
+				  err);
+			goto finish_update_parent;
+		}
+
+finish_update_parent:
+		ssdfs_btree_hierarchy_free(hierarchy);
+
+		if (unlikely(err))
+			goto finish_add_item;
+	}
+
+	atomic_set(&tree->state, SSDFS_BTREE_DIRTY);
+
+finish_add_item:
+	up_read(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_btree_object(tree);
+
+#ifdef CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK
+	ssdfs_check_btree_consistency(tree);
+#endif /* CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_add_range() - add a range of items into btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to add the range of items into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - range exists in the tree.
+ */
+int ssdfs_btree_add_range(struct ssdfs_btree *tree,
+			  struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_hierarchy *hierarchy = NULL;
+	int tree_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#else
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_request_valid(search)) {
+		SSDFS_ERR("invalid search object\n");
+		return -EINVAL;
+	}
+
+	if (search->request.type != SSDFS_BTREE_SEARCH_ADD_RANGE) {
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -EINVAL;
+	}
+
+	down_read(&tree->lock);
+
+try_find_range:
+	err = __ssdfs_btree_find_range(tree, search);
+	if (!err) {
+		err = -EEXIST;
+		SSDFS_ERR("range exists in the tree: "
+			  "start_hash %llx, end_hash %llx\n",
+			  search->request.start.hash,
+			  search->request.end.hash);
+		goto finish_add_range;
+	} else if (err == -ENODATA) {
+		err = 0;
+		switch (search->result.state) {
+		case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+			/* position in node was found */
+			break;
+		case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+			/* none node is able to store the new range */
+			break;
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid search result: "
+				  "start_hash %llx, end_hash %llx, "
+				  "state %#x\n",
+				  search->request.start.hash,
+				  search->request.end.hash,
+				  search->result.state);
+			goto finish_add_range;
+		};
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find range: "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_add_range;
+	}
+
+	if (search->result.state == SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE) {
+		up_read(&tree->lock);
+		err = ssdfs_btree_insert_node(tree, search);
+		down_read(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert node: err %d\n",
+				  err);
+			goto finish_add_range;
+		}
+
+		err = __ssdfs_btree_find_range(tree, search);
+		if (!err) {
+			err = -EEXIST;
+			SSDFS_ERR("range exists in the tree: "
+				  "start_hash %llx, end_hash %llx\n",
+				  search->request.start.hash,
+				  search->request.end.hash);
+			goto finish_add_range;
+		} else if (err == -ENODATA) {
+			err = 0;
+			switch (search->result.state) {
+			case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+			case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+				/* position in node was found */
+				break;
+			default:
+				err = -ERANGE;
+				SSDFS_ERR("invalid search result: "
+					  "start_hash %llx, end_hash %llx, "
+					  "state %#x\n",
+					  search->request.start.hash,
+					  search->request.end.hash,
+					  search->result.state);
+				goto finish_add_range;
+			};
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find range: "
+				  "start_hash %llx, end_hash %llx, err %d\n",
+				  search->request.start.hash,
+				  search->request.end.hash,
+				  err);
+			goto finish_add_range;
+		}
+	}
+
+try_insert_range:
+	err = ssdfs_btree_node_insert_range(search);
+	if (err == -EAGAIN) {
+		err = 0;
+		goto try_find_range;
+	} else if (err == -EACCES) {
+		struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = SSDFS_WAIT_COMPLETION(&node->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("node init failed: "
+				  "err %d\n", err);
+			goto finish_add_range;
+		} else
+			goto try_insert_range;
+	} else if (err == -EFBIG) {
+		int state = search->result.state;
+
+		err = 0;
+
+		if (state != SSDFS_BTREE_SEARCH_PLEASE_MOVE_BUF_CONTENT) {
+			err = -ERANGE;
+			SSDFS_WARN("invalid search's result state %#x\n",
+				   state);
+			goto finish_add_range;
+		} else
+			goto try_find_range;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to insert item: "
+			  "start_hash %llx, end_hash %llx, "
+			  "err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_add_range;
+	}
+
+	if (need_update_parent_node(search)) {
+		hierarchy = ssdfs_btree_hierarchy_allocate(tree);
+		if (!hierarchy) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate tree levels' array\n");
+			goto finish_add_range;
+		}
+
+		err = ssdfs_btree_check_hierarchy_for_update(tree, search,
+								hierarchy);
+		if (unlikely(err)) {
+			atomic_set(&search->node.child->state,
+				    SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to prepare hierarchy information : "
+				  "err %d\n",
+				  err);
+			goto finish_update_parent;
+		}
+
+		err = ssdfs_btree_update_index_in_parent_node(tree, search,
+							      hierarchy);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update index records: "
+				  "err %d\n",
+				  err);
+			goto finish_update_parent;
+		}
+
+finish_update_parent:
+		ssdfs_btree_hierarchy_free(hierarchy);
+
+		if (unlikely(err))
+			goto finish_add_range;
+	}
+
+	atomic_set(&tree->state, SSDFS_BTREE_DIRTY);
+
+finish_add_range:
+	up_read(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_btree_object(tree);
+
+#ifdef CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK
+	ssdfs_check_btree_consistency(tree);
+#endif /* CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_change_item() - change an existing item in the btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to change the existing item in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_change_item(struct ssdfs_btree *tree,
+			    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_hierarchy *hierarchy = NULL;
+	int tree_state;
+	int tree_height;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#else
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_request_valid(search)) {
+		SSDFS_ERR("invalid search object\n");
+		return -EINVAL;
+	}
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -EINVAL;
+	}
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height <= 0) {
+		SSDFS_ERR("invalid tree_height %u\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	down_read(&tree->lock);
+
+try_next_search:
+	err = ssdfs_btree_find_leaf_node(tree, search);
+	if (err == -EEXIST) {
+		err = 0;
+		/* try the old search result */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find leaf node: err %d\n",
+			  err);
+		goto finish_change_item;
+	}
+
+try_change_item:
+	err = ssdfs_btree_node_change_item(search);
+	if (err == -EAGAIN) {
+		err = 0;
+		search->node.state = SSDFS_BTREE_SEARCH_NODE_DESC_EMPTY;
+		goto try_next_search;
+	} else if (err == -EACCES) {
+		struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = SSDFS_WAIT_COMPLETION(&node->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("node init failed: "
+				  "err %d\n", err);
+			goto finish_change_item;
+		} else
+			goto try_change_item;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to change item: "
+			  "start_hash %llx, end_hash %llx, "
+			  "err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_change_item;
+	}
+
+	if (need_update_parent_node(search)) {
+		hierarchy = ssdfs_btree_hierarchy_allocate(tree);
+		if (!hierarchy) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate tree levels' array\n");
+			goto finish_change_item;
+		}
+
+		err = ssdfs_btree_check_hierarchy_for_update(tree, search,
+								hierarchy);
+		if (unlikely(err)) {
+			atomic_set(&search->node.child->state,
+				    SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to prepare hierarchy information : "
+				  "err %d\n",
+				  err);
+			goto finish_update_parent;
+		}
+
+		err = ssdfs_btree_update_index_in_parent_node(tree, search,
+							      hierarchy);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update index records: "
+				  "err %d\n",
+				  err);
+			goto finish_update_parent;
+		}
+
+finish_update_parent:
+		ssdfs_btree_hierarchy_free(hierarchy);
+
+		if (unlikely(err))
+			goto finish_change_item;
+	}
+
+	atomic_set(&tree->state, SSDFS_BTREE_DIRTY);
+
+finish_change_item:
+	up_read(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_btree_object(tree);
+
+#ifdef CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK
+	ssdfs_check_btree_consistency(tree);
+#endif /* CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_delete_item() - delete an existing item in the btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to delete the existing item in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_delete_item(struct ssdfs_btree *tree,
+			    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_hierarchy *hierarchy = NULL;
+	int tree_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#else
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_request_valid(search)) {
+		SSDFS_ERR("invalid search object\n");
+		return -EINVAL;
+	}
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -EINVAL;
+	}
+
+	down_read(&tree->lock);
+
+	err = __ssdfs_btree_find_item(tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find item: "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_delete_item;
+	}
+
+try_delete_item:
+	err = ssdfs_btree_node_delete_item(search);
+	if (err == -EACCES) {
+		struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = SSDFS_WAIT_COMPLETION(&node->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("node init failed: "
+				  "err %d\n", err);
+			goto finish_delete_item;
+		} else
+			goto try_delete_item;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to delete item: "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		goto finish_delete_item;
+	}
+
+	if (search->result.state == SSDFS_BTREE_SEARCH_PLEASE_DELETE_NODE) {
+		up_read(&tree->lock);
+		err = ssdfs_btree_delete_node(tree, search);
+		down_read(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete btree node: "
+				  "node_id %llu, err %d\n",
+				  (u64)search->node.id, err);
+			goto finish_delete_item;
+		}
+	} else if (need_update_parent_node(search)) {
+		hierarchy = ssdfs_btree_hierarchy_allocate(tree);
+		if (!hierarchy) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate tree levels' array\n");
+			goto finish_delete_item;
+		}
+
+		err = ssdfs_btree_check_hierarchy_for_update(tree, search,
+								hierarchy);
+		if (unlikely(err)) {
+			atomic_set(&search->node.child->state,
+				    SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to prepare hierarchy information : "
+				  "err %d\n",
+				  err);
+			goto finish_update_parent;
+		}
+
+		err = ssdfs_btree_update_index_in_parent_node(tree, search,
+							      hierarchy);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update index records: "
+				  "err %d\n",
+				  err);
+			goto finish_update_parent;
+		}
+
+finish_update_parent:
+		ssdfs_btree_hierarchy_free(hierarchy);
+
+		if (unlikely(err))
+			goto finish_delete_item;
+	}
+
+	atomic_set(&tree->state, SSDFS_BTREE_DIRTY);
+
+finish_delete_item:
+	up_read(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_btree_object(tree);
+
+#ifdef CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK
+	ssdfs_check_btree_consistency(tree);
+#endif /* CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_delete_range() - delete a range of items in the btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to delete a range of existing items in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_delete_range(struct ssdfs_btree *tree,
+			     struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_hierarchy *hierarchy = NULL;
+	int tree_state;
+	bool need_continue_deletion = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#else
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "request->type %#x, request->flags %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, tree->type, tree_state,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash,
+		  search->request.end.hash);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_request_valid(search)) {
+		SSDFS_ERR("invalid search object\n");
+		return -EINVAL;
+	}
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_ALL:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -EINVAL;
+	}
+
+	down_read(&tree->lock);
+
+try_delete_next_range:
+	err = __ssdfs_btree_find_range(tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find range: "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		up_read(&tree->lock);
+		return err;
+	}
+
+try_delete_range_again:
+	err = ssdfs_btree_node_delete_range(search);
+	if (err == -EACCES) {
+		struct ssdfs_btree_node *node = search->node.child;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = SSDFS_WAIT_COMPLETION(&node->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("node init failed: "
+				  "err %d\n", err);
+			goto finish_delete_range;
+		} else
+			goto try_delete_range_again;
+	}
+
+finish_delete_range:
+	if (err == -EAGAIN) {
+		/* the range have to be deleted in the next node */
+		err = 0;
+		need_continue_deletion = true;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to delete range: "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		up_read(&tree->lock);
+		return err;
+	}
+
+	if (search->result.state == SSDFS_BTREE_SEARCH_PLEASE_DELETE_NODE) {
+		up_read(&tree->lock);
+		err = ssdfs_btree_delete_node(tree, search);
+		down_read(&tree->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete btree node: "
+				  "node_id %llu, err %d\n",
+				  (u64)search->node.id, err);
+			goto fail_delete_range;
+		}
+	} else if (need_update_parent_node(search)) {
+		hierarchy = ssdfs_btree_hierarchy_allocate(tree);
+		if (!hierarchy) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate tree levels' array\n");
+			goto fail_delete_range;
+		}
+
+		err = ssdfs_btree_check_hierarchy_for_update(tree, search,
+								hierarchy);
+		if (unlikely(err)) {
+			atomic_set(&search->node.child->state,
+				    SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to prepare hierarchy information : "
+				  "err %d\n",
+				  err);
+			goto finish_update_parent;
+		}
+
+		err = ssdfs_btree_update_index_in_parent_node(tree, search,
+							      hierarchy);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update index records: "
+				  "err %d\n",
+				  err);
+			goto finish_update_parent;
+		}
+
+finish_update_parent:
+		ssdfs_btree_hierarchy_free(hierarchy);
+
+		if (unlikely(err))
+			goto fail_delete_range;
+	}
+
+	if (need_continue_deletion) {
+		need_continue_deletion = false;
+		goto try_delete_next_range;
+	}
+
+	atomic_set(&tree->state, SSDFS_BTREE_DIRTY);
+
+fail_delete_range:
+	up_read(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_btree_object(tree);
+
+#ifdef CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK
+	ssdfs_check_btree_consistency(tree);
+#endif /* CONFIG_SSDFS_BTREE_STRICT_CONSISTENCY_CHECK */
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_delete_all() - delete all items in the btree
+ * @tree: btree object
+ * @search: search object [in|out]
+ *
+ * This method tries to delete all items in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_delete_all(struct ssdfs_btree *tree)
+{
+	struct ssdfs_btree_search *search;
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
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+	ssdfs_btree_search_init(search);
+
+	search->request.type = SSDFS_BTREE_SEARCH_DELETE_ALL;
+	search->request.start.hash = 0;
+	search->request.end.hash = U64_MAX;
+
+	err = ssdfs_btree_delete_range(tree, search);
+	if (unlikely(err))
+		SSDFS_ERR("fail to delete all items: err %d\n", err);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_btree_search_free(search);
+	return err;
+}
+
+/*
+ * ssdfs_btree_get_head_range() - extract head range of the tree
+ * @tree: btree object
+ * @expected_len: expected length of the range
+ * @search: search object
+ *
+ * This method tries to extract a head range of items from the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - expected length of the range is not extracted
+ */
+int ssdfs_btree_get_head_range(struct ssdfs_btree *tree,
+				u32 expected_len,
+				struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node;
+	struct ssdfs_btree_index_key key;
+	int tree_state;
+	u64 hash;
+	u32 buf_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "expected_len %u\n",
+		  tree, tree->type, tree_state,
+		  expected_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	down_read(&tree->lock);
+
+	err = ssdfs_btree_radix_tree_find(tree,
+					  SSDFS_BTREE_ROOT_NODE_ID,
+					  &node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find root node: err %d\n",
+			  err);
+		goto finish_get_range;
+	} else if (!node) {
+		err = -ERANGE;
+		SSDFS_ERR("node is NULL\n");
+		goto finish_get_range;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+		err = -ERANGE;
+		SSDFS_WARN("root node hasn't index area\n");
+		goto finish_get_range;
+	}
+
+	if (is_ssdfs_btree_node_index_area_empty(node))
+		goto finish_get_range;
+
+	down_read(&node->full_lock);
+	err = __ssdfs_btree_root_node_extract_index(node,
+						SSDFS_ROOT_NODE_LEFT_LEAF_NODE,
+						&key);
+	up_read(&node->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get index: err %d\n",
+			  err);
+		goto finish_get_range;
+	}
+
+	hash = le64_to_cpu(key.index.hash);
+	if (hash >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid hash\n");
+		goto finish_get_range;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hash %llx\n", hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+	search->request.flags = SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+				SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+	search->request.start.hash = hash;
+	search->request.end.hash = hash;
+	search->request.count = 1;
+
+	err = __ssdfs_btree_find_item(tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find the item: "
+			  "hash %llx, err %d\n",
+			  hash, err);
+		goto finish_get_range;
+	}
+
+	buf_size = expected_len * tree->max_item_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(expected_len >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_btree_node_extract_range(search->result.start_index,
+					     (u16)expected_len,
+					     search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract the range: "
+			  "start_index %u, expected_len %u, err %d\n",
+			  search->result.start_index,
+			  expected_len, err);
+		goto finish_get_range;
+	}
+
+	if (expected_len != search->result.count) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("expected_len %u != search->result.count %u\n",
+			  expected_len, search->result.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+finish_get_range:
+	up_read(&tree->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_extract_range() - extract range from the node
+ * @tree: btree object
+ * @start_index: start index in the node
+ * @count: count of items in the range
+ * @search: search object
+ *
+ * This method tries to extract a range of items from the found node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_extract_range(struct ssdfs_btree *tree,
+				u16 start_index, u16 count,
+				struct ssdfs_btree_search *search)
+{
+	int tree_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, type %#x, state %#x, "
+		  "start_index %u, count %u\n",
+		  tree, tree->type, tree_state,
+		  start_index, count);
+
+	ssdfs_debug_btree_object(tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	down_read(&tree->lock);
+
+	err = ssdfs_btree_node_extract_range(start_index, count,
+					     search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract the range: "
+			  "start_index %u, count %u, err %d\n",
+			  start_index, count, err);
+		goto finish_get_range;
+	}
+
+finish_get_range:
+	up_read(&tree->lock);
+
+	return err;
+}
+
+/*
+ * is_ssdfs_btree_empty() - check that btree is empty
+ * @tree: btree object
+ */
+bool is_ssdfs_btree_empty(struct ssdfs_btree *tree)
+{
+	struct ssdfs_btree_node *node;
+	struct ssdfs_btree_index_key key1, key2;
+	int tree_state;
+	u32 node_id1, node_id2;
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
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#else
+		SSDFS_WARN("invalid tree state %#x\n",
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+	}
+
+	down_read(&tree->lock);
+
+	err = ssdfs_btree_radix_tree_find(tree,
+					  SSDFS_BTREE_ROOT_NODE_ID,
+					  &node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find root node: err %d\n",
+			  err);
+		goto finish_check_tree;
+	} else if (!node) {
+		err = -ERANGE;
+		SSDFS_ERR("node is NULL\n");
+		goto finish_check_tree;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+		err = -ERANGE;
+		SSDFS_WARN("root node hasn't index area\n");
+		goto finish_check_tree;
+	}
+
+	if (is_ssdfs_btree_node_index_area_empty(node))
+		goto finish_check_tree;
+
+	down_read(&node->full_lock);
+	err = __ssdfs_btree_root_node_extract_index(node,
+						SSDFS_ROOT_NODE_LEFT_LEAF_NODE,
+						&key1);
+	up_read(&node->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get index: err %d\n",
+			  err);
+		goto finish_check_tree;
+	}
+
+	node_id1 = le32_to_cpu(key1.node_id);
+	if (node_id1 == SSDFS_BTREE_NODE_INVALID_ID) {
+		SSDFS_WARN("index is invalid\n");
+		goto finish_check_tree;
+	}
+
+	down_read(&node->full_lock);
+	err = __ssdfs_btree_root_node_extract_index(node,
+						SSDFS_ROOT_NODE_RIGHT_LEAF_NODE,
+						&key2);
+	up_read(&node->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get index: err %d\n",
+			  err);
+		goto finish_check_tree;
+	}
+
+	node_id2 = le32_to_cpu(key2.node_id);
+	if (node_id2 != SSDFS_BTREE_NODE_INVALID_ID) {
+		err = -EEXIST;
+		goto finish_check_tree;
+	}
+
+	err = ssdfs_btree_radix_tree_find(tree, node_id1, &node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find node: node_id %u, err %d\n",
+			  node_id1, err);
+		goto finish_check_tree;
+	} else if (!node) {
+		err = -ERANGE;
+		SSDFS_ERR("node is NULL\n");
+		goto finish_check_tree;
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_LEAF_NODE:
+		if (!is_ssdfs_btree_node_items_area_empty(node)) {
+			err = -EEXIST;
+			goto finish_check_tree;
+		} else {
+			/* empty node */
+			goto finish_check_tree;
+		}
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (!is_ssdfs_btree_node_items_area_empty(node)) {
+			err = -EEXIST;
+			goto finish_check_tree;
+		} else if (!is_ssdfs_btree_node_index_area_empty(node)) {
+			err = -EEXIST;
+			goto finish_check_tree;
+		} else {
+			/* empty node */
+			goto finish_check_tree;
+		}
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		err = -EEXIST;
+		goto finish_check_tree;
+
+	case SSDFS_BTREE_ROOT_NODE:
+		err = -ERANGE;
+		SSDFS_WARN("node %u has root node type\n",
+			   node_id1);
+		goto finish_check_tree;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid node type %#x\n",
+			  atomic_read(&node->type));
+		goto finish_check_tree;
+	}
+
+finish_check_tree:
+	up_read(&tree->lock);
+
+	return err ? false : true;
+}
+
+/*
+ * need_migrate_generic2inline_btree() - is it time to migrate?
+ * @tree: btree object
+ * @items_threshold: items migration threshold
+ */
+bool need_migrate_generic2inline_btree(struct ssdfs_btree *tree,
+					int items_threshold)
+{
+	struct ssdfs_btree_node *node;
+	struct ssdfs_btree_index_key key1, key2;
+	int tree_state;
+	u32 node_id1, node_id2;
+	u16 items_count;
+	bool need_migrate = false;
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
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#else
+		SSDFS_WARN("invalid tree state %#x\n",
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+	}
+
+	down_read(&tree->lock);
+
+	err = ssdfs_btree_radix_tree_find(tree,
+					  SSDFS_BTREE_ROOT_NODE_ID,
+					  &node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find root node: err %d\n",
+			  err);
+		goto finish_check_tree;
+	} else if (!node) {
+		err = -ERANGE;
+		SSDFS_ERR("node is NULL\n");
+		goto finish_check_tree;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+		err = -ERANGE;
+		SSDFS_WARN("root node hasn't index area\n");
+		goto finish_check_tree;
+	}
+
+	if (is_ssdfs_btree_node_index_area_empty(node))
+		goto finish_check_tree;
+
+	down_read(&node->full_lock);
+	err = __ssdfs_btree_root_node_extract_index(node,
+						SSDFS_ROOT_NODE_LEFT_LEAF_NODE,
+						&key1);
+	up_read(&node->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get index: err %d\n",
+			  err);
+		goto finish_check_tree;
+	}
+
+	node_id1 = le32_to_cpu(key1.node_id);
+	if (node_id1 == SSDFS_BTREE_NODE_INVALID_ID) {
+		SSDFS_WARN("index is invalid\n");
+		goto finish_check_tree;
+	}
+
+	down_read(&node->full_lock);
+	err = __ssdfs_btree_root_node_extract_index(node,
+						SSDFS_ROOT_NODE_RIGHT_LEAF_NODE,
+						&key2);
+	up_read(&node->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get index: err %d\n",
+			  err);
+		goto finish_check_tree;
+	}
+
+	node_id2 = le32_to_cpu(key2.node_id);
+	if (node_id2 != SSDFS_BTREE_NODE_INVALID_ID) {
+		err = -EEXIST;
+		goto finish_check_tree;
+	}
+
+	err = ssdfs_btree_radix_tree_find(tree, node_id1, &node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find node: node_id %u, err %d\n",
+			  node_id1, err);
+		goto finish_check_tree;
+	} else if (!node) {
+		err = -ERANGE;
+		SSDFS_ERR("node is NULL\n");
+		goto finish_check_tree;
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_LEAF_NODE:
+		if (!is_ssdfs_btree_node_items_area_empty(node)) {
+			down_read(&node->header_lock);
+			items_count = node->items_area.items_count;
+			up_read(&node->header_lock);
+
+			if (items_count <= items_threshold) {
+				/* time to migrate */
+				need_migrate = true;
+			}
+
+			goto finish_check_tree;
+		} else {
+			/* empty node */
+			goto finish_check_tree;
+		}
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (is_ssdfs_btree_node_index_area_empty(node) &&
+		    !is_ssdfs_btree_node_items_area_empty(node)) {
+			down_read(&node->header_lock);
+			items_count = node->items_area.items_count;
+			up_read(&node->header_lock);
+
+			if (items_count <= items_threshold) {
+				/* time to migrate */
+				need_migrate = true;
+			}
+
+			goto finish_check_tree;
+		} else if (!is_ssdfs_btree_node_index_area_empty(node)) {
+			err = -EEXIST;
+			goto finish_check_tree;
+		} else {
+			/* empty node */
+			goto finish_check_tree;
+		}
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		err = -EEXIST;
+		goto finish_check_tree;
+
+	case SSDFS_BTREE_ROOT_NODE:
+		err = -ERANGE;
+		SSDFS_WARN("node %u has root node type\n",
+			   node_id1);
+		goto finish_check_tree;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid node type %#x\n",
+			  atomic_read(&node->type));
+		goto finish_check_tree;
+	}
+
+finish_check_tree:
+	up_read(&tree->lock);
+
+	return need_migrate;
+}
+
+/*
+ * ssdfs_btree_synchronize_root_node() - synchronize root node state
+ * @tree: btree object
+ * @root: root node
+ */
+int ssdfs_btree_synchronize_root_node(struct ssdfs_btree *tree,
+				struct ssdfs_btree_inline_root_node *root)
+{
+	int tree_state;
+	struct ssdfs_btree_node *node;
+	u16 items_count;
+	int height;
+	size_t ids_array_size = sizeof(__le32) *
+				SSDFS_BTREE_ROOT_NODE_INDEX_COUNT;
+	size_t indexes_size = sizeof(struct ssdfs_btree_index) *
+				SSDFS_BTREE_ROOT_NODE_INDEX_COUNT;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !root);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, root %p, type %#x, state %#x\n",
+		  tree, root, tree->type, tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (tree_state) {
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
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	down_read(&tree->lock);
+
+	err = ssdfs_btree_radix_tree_find(tree,
+					  SSDFS_BTREE_ROOT_NODE_ID,
+					  &node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find root node: err %d\n",
+			  err);
+		goto finish_synchronize_root;
+	} else if (!node) {
+		err = -ERANGE;
+		SSDFS_ERR("node is NULL\n");
+		goto finish_synchronize_root;
+	}
+
+	down_read(&node->header_lock);
+	height = atomic_read(&node->tree->height);
+	root->header.height = (u8)height;
+	items_count = node->index_area.index_count;
+	root->header.items_count = cpu_to_le16(items_count);
+	root->header.flags = (u8)atomic_read(&node->flags);
+	root->header.type = (u8)atomic_read(&node->type);
+	ssdfs_memcpy(root->header.node_ids,
+		     0, ids_array_size,
+		     node->raw.root_node.header.node_ids,
+		     0, ids_array_size,
+		     ids_array_size);
+	ssdfs_memcpy(root->indexes, 0, indexes_size,
+		     node->raw.root_node.indexes, 0, indexes_size,
+		     indexes_size);
+	up_read(&node->header_lock);
+
+	spin_lock(&node->tree->nodes_lock);
+	root->header.upper_node_id =
+		cpu_to_le32(node->tree->upper_node_id);
+	spin_unlock(&node->tree->nodes_lock);
+
+finish_synchronize_root:
+	up_read(&tree->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_get_next_hash() - get next node's starting hash
+ * @tree: btree object
+ * @search: search object
+ * @next_hash: next node's starting hash [out]
+ */
+int ssdfs_btree_get_next_hash(struct ssdfs_btree *tree,
+			      struct ssdfs_btree_search *search,
+			      u64 *next_hash)
+{
+	struct ssdfs_btree_node *parent;
+	struct ssdfs_btree_node_index_area area;
+	struct ssdfs_btree_index_key index_key;
+	u64 old_hash = U64_MAX;
+	int type;
+	spinlock_t *lock;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search || !next_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	old_hash = le64_to_cpu(search->node.found_index.index.hash);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search %p, next_hash %p, old (node %u, hash %llx)\n",
+		  search, next_hash, search->node.id, old_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*next_hash = U64_MAX;
+
+	parent = search->node.parent;
+
+	if (!parent) {
+		SSDFS_ERR("node pointer is NULL\n");
+		return -ERANGE;
+	}
+
+	type = atomic_read(&parent->type);
+
+	down_read(&tree->lock);
+
+	do {
+		u16 found_pos;
+
+		err = -ENOENT;
+
+		down_read(&parent->full_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("old_hash %llx\n", old_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		down_read(&parent->header_lock);
+		ssdfs_memcpy(&area,
+			     0, sizeof(struct ssdfs_btree_node_index_area),
+			     &parent->index_area,
+			     0, sizeof(struct ssdfs_btree_node_index_area),
+			     sizeof(struct ssdfs_btree_node_index_area));
+		err = ssdfs_find_index_by_hash(parent, &area,
+						old_hash,
+						&found_pos);
+		up_read(&parent->header_lock);
+
+		if (err == -EEXIST) {
+			/* hash == found hash */
+			err = 0;
+		} else if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find the index position: "
+				  "old_hash %llx\n",
+				  old_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_index_search;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the index position: "
+				  "old_hash %llx, err %d\n",
+				  old_hash, err);
+			goto finish_index_search;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(found_pos == U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		found_pos++;
+
+		if (found_pos >= area.index_count) {
+			err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("index area is finished: "
+				  "found_pos %u, area.index_count %u\n",
+				  found_pos, area.index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_index_search;
+		}
+
+		if (type == SSDFS_BTREE_ROOT_NODE) {
+			err = __ssdfs_btree_root_node_extract_index(parent,
+								    found_pos,
+								    &index_key);
+		} else {
+			err = __ssdfs_btree_common_node_extract_index(parent,
+								    &area,
+								    found_pos,
+								    &index_key);
+		}
+
+finish_index_search:
+		up_read(&parent->full_lock);
+
+		if (err == -ENOENT) {
+			if (type == SSDFS_BTREE_ROOT_NODE) {
+				SSDFS_DBG("no more next hashes\n");
+				goto finish_get_next_hash;
+			}
+
+			spin_lock(&parent->descriptor_lock);
+			old_hash = le64_to_cpu(parent->node_index.index.hash);
+			spin_unlock(&parent->descriptor_lock);
+
+			/* try next parent */
+			lock = &parent->descriptor_lock;
+			spin_lock(lock);
+			parent = parent->parent_node;
+			spin_unlock(lock);
+			lock = NULL;
+
+			if (!parent) {
+				err = -ERANGE;
+				SSDFS_ERR("node pointer is NULL\n");
+				goto finish_get_next_hash;
+			}
+		} else if (err == -ENODATA) {
+			SSDFS_DBG("unable to find the index position\n");
+			goto finish_get_next_hash;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to extract index key: "
+				  "index_position %u, err %d\n",
+				  found_pos, err);
+			ssdfs_debug_show_btree_node_indexes(parent->tree,
+							    parent);
+			goto finish_get_next_hash;
+		} else {
+			/* next hash has been found */
+			err = 0;
+			*next_hash = le64_to_cpu(index_key.index.hash);
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("next_hash %llx\n", *next_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_get_next_hash;
+		}
+
+		type = atomic_read(&parent->type);
+	} while (parent != NULL);
+
+finish_get_next_hash:
+	up_read(&tree->lock);
+
+	return err;
+}
+
+void ssdfs_debug_show_btree_node_indexes(struct ssdfs_btree *tree,
+					 struct ssdfs_btree_node *parent)
+{
+#ifdef CONFIG_SSDFS_BTREE_CONSISTENCY_CHECK
+	struct ssdfs_btree_node_index_area area;
+	struct ssdfs_btree_index_key index_key;
+	int type;
+	int i;
+	int err = 0;
+
+	BUG_ON(!tree || !parent);
+
+	type = atomic_read(&parent->type);
+
+	if (!is_ssdfs_btree_node_index_area_exist(parent)) {
+		SSDFS_ERR("corrupted node %u\n",
+			  parent->node_id);
+		BUG();
+	}
+
+	if (is_ssdfs_btree_node_index_area_empty(parent)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u has empty index area\n",
+			  parent->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return;
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
+		SSDFS_ERR("index %d, node_id %u, "
+			  "node_type %#x, height %u, "
+			  "flags %#x, hash %llx, seg_id %llu, "
+			  "logical_blk %u, len %u\n",
+			  i,
+			  le32_to_cpu(index_key.node_id),
+			  index_key.node_type,
+			  index_key.height,
+			  le16_to_cpu(index_key.flags),
+			  le64_to_cpu(index_key.index.hash),
+			  le64_to_cpu(index_key.index.extent.seg_id),
+			  le32_to_cpu(index_key.index.extent.logical_blk),
+			  le32_to_cpu(index_key.index.extent.len));
+	}
+
+finish_index_processing:
+	up_read(&parent->full_lock);
+
+	ssdfs_show_btree_node_info(parent);
+#endif /* CONFIG_SSDFS_BTREE_CONSISTENCY_CHECK */
+}
+
+#ifdef CONFIG_SSDFS_BTREE_CONSISTENCY_CHECK
+static
+void ssdfs_debug_btree_check_indexes(struct ssdfs_btree *tree,
+				     struct ssdfs_btree_node *parent)
+{
+	struct ssdfs_btree_node *child = NULL;
+	struct ssdfs_btree_node_index_area area;
+	struct ssdfs_btree_index_key index_key;
+	int type;
+	u32 node_id1, node_id2;
+	u64 start_hash1 = U64_MAX;
+	u64 start_hash2 = U64_MAX;
+	u64 prev_hash = U64_MAX;
+	int i;
+	int err = 0;
+
+	BUG_ON(!tree || !parent);
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
+			ssdfs_show_btree_node_info(parent);
+			BUG();
+		}
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		/* do nothing */
+		return;
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
+		return;
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
+	node_id1 = parent->node_id;
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
+		node_id2 = le32_to_cpu(index_key.node_id);
+		start_hash1 = le64_to_cpu(index_key.index.hash);
+
+		up_read(&parent->full_lock);
+
+		err = ssdfs_btree_radix_tree_find(tree, node_id2, &child);
+
+		if (err || !child) {
+			SSDFS_ERR("node_id %u is absent\n",
+				   node_id2);
+			goto continue_tree_check;
+		}
+
+		switch (atomic_read(&child->type)) {
+		case SSDFS_BTREE_INDEX_NODE:
+			if (!is_ssdfs_btree_node_index_area_exist(child)) {
+				SSDFS_ERR("corrupted node %u\n",
+					  child->node_id);
+				ssdfs_show_btree_node_info(child);
+				BUG();
+			}
+
+			if (node_id1 == node_id2) {
+				SSDFS_WARN("node_id1 %u == node_id2 %u\n",
+					   node_id1, node_id2);
+				ssdfs_show_btree_node_info(child);
+				BUG();
+			}
+
+			down_read(&child->header_lock);
+			start_hash2 = child->index_area.start_hash;
+			up_read(&child->header_lock);
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			if (!is_ssdfs_btree_node_index_area_exist(child)) {
+				SSDFS_ERR("corrupted node %u\n",
+					  child->node_id);
+				ssdfs_show_btree_node_info(child);
+				BUG();
+			}
+
+			if (!is_ssdfs_btree_node_items_area_exist(child)) {
+				SSDFS_ERR("corrupted node %u\n",
+					  child->node_id);
+				ssdfs_show_btree_node_info(child);
+				BUG();
+			}
+
+			if (node_id1 == node_id2) {
+				down_read(&child->header_lock);
+				start_hash2 = child->items_area.start_hash;
+				up_read(&child->header_lock);
+			} else {
+				down_read(&child->header_lock);
+				start_hash2 = child->index_area.start_hash;
+				up_read(&child->header_lock);
+			}
+			break;
+
+		case SSDFS_BTREE_LEAF_NODE:
+			if (!is_ssdfs_btree_node_items_area_exist(child)) {
+				SSDFS_ERR("corrupted node %u\n",
+					  child->node_id);
+				ssdfs_show_btree_node_info(child);
+				BUG();
+			}
+
+			if (node_id1 == node_id2) {
+				SSDFS_WARN("node_id1 %u == node_id2 %u\n",
+					   node_id1, node_id2);
+				ssdfs_show_btree_node_info(child);
+				BUG();
+			}
+
+			down_read(&child->header_lock);
+			start_hash2 = child->items_area.start_hash;
+			up_read(&child->header_lock);
+			break;
+
+		default:
+			BUG();
+		}
+
+		if (start_hash1 != start_hash2) {
+			SSDFS_WARN("parent: node_id %u, "
+				   "index %d, hash %llx, "
+				   "child: node_id %u, type %#x, "
+				   "start_hash %llx\n",
+				   node_id1, i, start_hash1,
+				   node_id2, atomic_read(&child->type),
+				   start_hash2);
+				ssdfs_debug_show_btree_node_indexes(tree,
+								    parent);
+				ssdfs_show_btree_node_info(parent);
+				ssdfs_show_btree_node_info(child);
+			BUG();
+		}
+
+		if (i > 1) {
+			if (prev_hash >= start_hash1) {
+				SSDFS_WARN("node_id %u, index_position %d, "
+					   "prev_hash %llx >= hash %llx\n",
+					   node_id1, i,
+					   prev_hash, start_hash1);
+				ssdfs_debug_show_btree_node_indexes(tree,
+								    parent);
+				BUG();
+			}
+		}
+
+continue_tree_check:
+		prev_hash = start_hash1;
+
+		down_read(&parent->full_lock);
+	}
+
+finish_index_processing:
+	up_read(&parent->full_lock);
+}
+#endif /* CONFIG_SSDFS_BTREE_CONSISTENCY_CHECK */
+
+void ssdfs_check_btree_consistency(struct ssdfs_btree *tree)
+{
+#ifdef CONFIG_SSDFS_BTREE_CONSISTENCY_CHECK
+	struct radix_tree_iter iter1, iter2;
+	void **slot1;
+	void **slot2;
+	struct ssdfs_btree_node *node1;
+	struct ssdfs_btree_node *node2;
+	u32 node_id1, node_id2;
+	u64 start_hash1, start_hash2;
+	u64 end_hash1, end_hash2;
+	u16 items_count;
+	u16 index_position;
+	bool is_exist = false;
+	int err;
+
+	BUG_ON(!tree);
+
+	down_read(&tree->lock);
+
+	rcu_read_lock();
+	radix_tree_for_each_slot(slot1, &tree->nodes, &iter1,
+				 SSDFS_BTREE_ROOT_NODE_ID) {
+		node1 = SSDFS_BTN(radix_tree_deref_slot(slot1));
+
+		if (!node1)
+			continue;
+
+		if (is_ssdfs_btree_node_pre_deleted(node1)) {
+			SSDFS_DBG("node %u has pre-deleted state\n",
+				  node1->node_id);
+			continue;
+		}
+
+		rcu_read_unlock();
+
+		ssdfs_debug_btree_check_indexes(tree, node1);
+
+		switch (atomic_read(&node1->type)) {
+		case SSDFS_BTREE_ROOT_NODE:
+			rcu_read_lock();
+			continue;
+
+		case SSDFS_BTREE_INDEX_NODE:
+		case SSDFS_BTREE_HYBRID_NODE:
+			if (!is_ssdfs_btree_node_index_area_exist(node1)) {
+				SSDFS_ERR("corrupted node %u\n",
+					  node1->node_id);
+				ssdfs_show_btree_node_info(node1);
+				BUG();
+			}
+
+			down_read(&node1->header_lock);
+			start_hash1 = node1->index_area.start_hash;
+			end_hash1 = node1->index_area.end_hash;
+			up_read(&node1->header_lock);
+			break;
+
+		case SSDFS_BTREE_LEAF_NODE:
+			if (!is_ssdfs_btree_node_items_area_exist(node1)) {
+				SSDFS_ERR("corrupted node %u\n",
+					  node1->node_id);
+				ssdfs_show_btree_node_info(node1);
+				BUG();
+			}
+
+			down_read(&node1->header_lock);
+			start_hash1 = node1->items_area.start_hash;
+			end_hash1 = node1->items_area.end_hash;
+			up_read(&node1->header_lock);
+			break;
+
+		default:
+			BUG();
+		}
+
+		SSDFS_DBG("node %u, type %#x, "
+			  "start_hash %llx, end_hash %llx\n",
+			  node1->node_id, atomic_read(&node1->type),
+			  start_hash1, end_hash1);
+
+		err = ssdfs_btree_node_find_index_position(node1->parent_node,
+							   start_hash1,
+							   &index_position);
+		if (unlikely(err)) {
+			SSDFS_WARN("fail to find the index position: "
+				  "search_hash %llx, err %d\n",
+				  start_hash1, err);
+			ssdfs_show_btree_node_info(node1);
+			BUG();
+		}
+
+		node_id1 = node1->node_id;
+
+		down_read(&node1->header_lock);
+		start_hash1 = node1->items_area.start_hash;
+		end_hash1 = node1->items_area.end_hash;
+		items_count = node1->items_area.items_count;
+		up_read(&node1->header_lock);
+
+		if (start_hash1 >= U64_MAX && end_hash1 >= U64_MAX) {
+			if (items_count == 0) {
+				/*
+				 * empty node
+				 */
+				rcu_read_lock();
+				continue;
+			} else {
+				SSDFS_WARN("node_id %u, "
+					   "start_hash1 %llx, end_hash1 %llx\n",
+					   node_id1, start_hash1, end_hash1);
+				ssdfs_show_btree_node_info(node1);
+				BUG();
+			}
+		} else if (start_hash1 >= U64_MAX || end_hash1 >= U64_MAX) {
+			SSDFS_WARN("node_id %u, "
+				   "start_hash1 %llx, end_hash1 %llx\n",
+				   node_id1, start_hash1, end_hash1);
+			ssdfs_show_btree_node_info(node1);
+			BUG();
+		}
+
+		rcu_read_lock();
+		radix_tree_for_each_slot(slot2, &tree->nodes, &iter2,
+					 SSDFS_BTREE_ROOT_NODE_ID) {
+			node2 = SSDFS_BTN(radix_tree_deref_slot(slot2));
+
+			if (!node2)
+				continue;
+
+			if (is_ssdfs_btree_node_pre_deleted(node2)) {
+				SSDFS_DBG("node %u has pre-deleted state\n",
+					  node2->node_id);
+				continue;
+			}
+
+			rcu_read_unlock();
+
+			is_exist = is_ssdfs_btree_node_items_area_exist(node2);
+
+			switch (atomic_read(&node2->type)) {
+			case SSDFS_BTREE_ROOT_NODE:
+			case SSDFS_BTREE_INDEX_NODE:
+				rcu_read_lock();
+				continue;
+
+			case SSDFS_BTREE_HYBRID_NODE:
+			case SSDFS_BTREE_LEAF_NODE:
+				if (!is_exist) {
+					SSDFS_ERR("corrupted node %u\n",
+						  node2->node_id);
+					ssdfs_show_btree_node_info(node2);
+					BUG();
+				}
+				break;
+
+			default:
+				BUG();
+			}
+
+			node_id2 = node2->node_id;
+
+			if (node_id1 == node_id2) {
+				rcu_read_lock();
+				continue;
+			}
+
+			down_read(&node2->header_lock);
+			start_hash2 = node2->items_area.start_hash;
+			end_hash2 = node2->items_area.end_hash;
+			items_count = node2->items_area.items_count;
+			up_read(&node2->header_lock);
+
+			if (start_hash2 >= U64_MAX && end_hash2 >= U64_MAX) {
+				if (items_count == 0) {
+					/*
+					 * empty node
+					 */
+					rcu_read_lock();
+					continue;
+				} else {
+					SSDFS_WARN("node_id %u, "
+						   "start_hash2 %llx, "
+						   "end_hash2 %llx\n",
+						   node_id2,
+						   start_hash2,
+						   end_hash2);
+					ssdfs_show_btree_node_info(node2);
+					BUG();
+				}
+			} else if (start_hash2 >= U64_MAX ||
+				   end_hash2 >= U64_MAX) {
+				SSDFS_WARN("node_id %u, start_hash2 %llx, "
+					   "end_hash2 %llx\n",
+					   node_id2, start_hash2, end_hash2);
+				ssdfs_show_btree_node_info(node2);
+				BUG();
+			}
+
+			if (RANGE_HAS_PARTIAL_INTERSECTION(start_hash1,
+							   end_hash1,
+							   start_hash2,
+							   end_hash2)) {
+				SSDFS_WARN("there is intersection: "
+					   "node_id %u (start_hash %llx, "
+					   "end_hash %llx), "
+					   "node_id %u (start_hash %llx, "
+					   "end_hash %llx)\n",
+					   node_id1, start_hash1, end_hash1,
+					   node_id2, start_hash2, end_hash2);
+				ssdfs_debug_show_btree_node_indexes(tree,
+							node1->parent_node);
+				ssdfs_show_btree_node_info(node1);
+				ssdfs_show_btree_node_info(node2);
+				BUG();
+			}
+
+			rcu_read_lock();
+		}
+
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+
+	up_read(&tree->lock);
+#endif /* CONFIG_SSDFS_BTREE_CONSISTENCY_CHECK */
+}
+
+void ssdfs_debug_btree_object(struct ssdfs_btree *tree)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct radix_tree_iter iter;
+	void **slot;
+	struct ssdfs_btree_node *node;
+
+	BUG_ON(!tree);
+
+	down_read(&tree->lock);
+
+	SSDFS_DBG("STATIC DATA: "
+		  "type %#x, owner_ino %llu, node_size %u, "
+		  "pages_per_node %u, node_ptr_size %u, "
+		  "index_size %u, item_size %u, "
+		  "min_item_size %u, max_item_size %u, "
+		  "index_area_min_size %u, create_cno %llu, "
+		  "fsi %p\n",
+		  tree->type, tree->owner_ino,
+		  tree->node_size, tree->pages_per_node,
+		  tree->node_ptr_size, tree->index_size,
+		  tree->item_size, tree->min_item_size,
+		  tree->max_item_size, tree->index_area_min_size,
+		  tree->create_cno, tree->fsi);
+
+	SSDFS_DBG("OPERATIONS: "
+		  "desc_ops %p, btree_ops %p\n",
+		  tree->desc_ops, tree->btree_ops);
+
+	SSDFS_DBG("MUTABLE DATA: "
+		  "state %#x, flags %#x, height %d, "
+		  "upper_node_id %u\n",
+		  atomic_read(&tree->state),
+		  atomic_read(&tree->flags),
+		  atomic_read(&tree->height),
+		  tree->upper_node_id);
+
+	SSDFS_DBG("tree->lock %d, nodes_lock %d\n",
+		  rwsem_is_locked(&tree->lock),
+		  spin_is_locked(&tree->nodes_lock));
+
+	rcu_read_lock();
+	radix_tree_for_each_slot(slot, &tree->nodes, &iter,
+				 SSDFS_BTREE_ROOT_NODE_ID) {
+		node = SSDFS_BTN(radix_tree_deref_slot(slot));
+
+		if (!node)
+			continue;
+
+		SSDFS_DBG("NODE: node_id %u, state %#x, "
+			  "type %#x, height %d, refs_count %d\n",
+			  node->node_id,
+			  atomic_read(&node->state),
+			  atomic_read(&node->type),
+			  atomic_read(&node->height),
+			  atomic_read(&node->refs_count));
+
+		SSDFS_DBG("INDEX_AREA: state %#x, "
+			  "offset %u, size %u, "
+			  "index_size %u, index_count %u, "
+			  "index_capacity %u, "
+			  "start_hash %llx, end_hash %llx\n",
+			  atomic_read(&node->index_area.state),
+			  node->index_area.offset,
+			  node->index_area.area_size,
+			  node->index_area.index_size,
+			  node->index_area.index_count,
+			  node->index_area.index_capacity,
+			  node->index_area.start_hash,
+			  node->index_area.end_hash);
+
+		SSDFS_DBG("ITEMS_AREA: state %#x, "
+			  "offset %u, size %u, free_space %u, "
+			  "item_size %u, min_item_size %u, "
+			  "max_item_size %u, items_count %u, "
+			  "items_capacity %u, "
+			  "start_hash %llx, end_hash %llx\n",
+			  atomic_read(&node->items_area.state),
+			  node->items_area.offset,
+			  node->items_area.area_size,
+			  node->items_area.free_space,
+			  node->items_area.item_size,
+			  node->items_area.min_item_size,
+			  node->items_area.max_item_size,
+			  node->items_area.items_count,
+			  node->items_area.items_capacity,
+			  node->items_area.start_hash,
+			  node->items_area.end_hash);
+	}
+	rcu_read_unlock();
+
+	up_read(&tree->lock);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
-- 
2.34.1


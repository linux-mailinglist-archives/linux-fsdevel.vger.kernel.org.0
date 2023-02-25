Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998A66A2662
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBYBTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBYBRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:42 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA3514EBA
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:37 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id c184-20020a4a4fc1000000b005250b2dc0easo187302oob.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0vWwwEK2Sgn1j3SMsE4vCMD80KQjUt/bWDZ6WgkEw0=;
        b=hflc34cSNVjsVQBFsm9QMbZNr2pEIaiyW1BZPLaRuA9bxQgMEFrQGkY9geMsfdEdfX
         RcLDKqTeZ64bV2v8+Ldhy6GSrAPlsX2H+Qx2pe6wn5CG/8D2pdm00OLbclKpB0JVb2V9
         0AkHpxyIoF3SDP64mNhfhqfFQ+9RCsC5WQRwqaLO8X1/q2AL3wwr1SU/Nr6Sh+y1xsjh
         BRYhkmGOykVunEzXrTzpGxTDpBbYrazfWUi2jg9XcgPOS3zbOQn2fjk0MRaJW7DYlBwZ
         KUeuqX0BRsKTAn/D/jYPFtKJQ7APzy+igOMPfIf8nk5k80SpkpUYvnKP6lRgRqGwjWBL
         oXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0vWwwEK2Sgn1j3SMsE4vCMD80KQjUt/bWDZ6WgkEw0=;
        b=29DF4pZCbQpthEVXcVWb6BzZrVD8Ve+Ev6gk/3OSdZaLd/2027iUiZpYLgbT8BoYgc
         PnPnaU174/3Ocedjdzz6snn+7I4xDD8HmcEAgIaC882sMtabpvwDqTFuSPt5JeVw4BAK
         uXGAmxX9xJ2G9/1oIPFjDwSGvHd7aqcULdognIy/rfy6OIrIPzq9QW4e3QlXfB0c3zdI
         Q33DUE8Zd6263dV25nNyhY3guyotxITjzhWZnF/7C5AjAlwQFqrpQ6/BdLReiScCyJsN
         7vPWN0C50FHvII9P1VElYqlfOt8RU9st2Hhf8lgPKqLbOK0IR/VzZZEucnPj3Dj0a7ll
         LMlg==
X-Gm-Message-State: AO0yUKUd0vA8VfwRoI9wkQGl464erQC00msCQCKDS1MP/ww9IlxJkMYq
        UenarbLFArx49cLYjKLU2QH0hL8GQNKLujvV
X-Google-Smtp-Source: AK7set/dueR8IGlTlcAYxV11ztmkXP8UI9tBwSd+SSZX7/wO1POPKhmuC4bByyCcVZBbIxs22KVEhQ==
X-Received: by 2002:a4a:3552:0:b0:525:129c:6165 with SMTP id w18-20020a4a3552000000b00525129c6165mr5554801oog.6.1677287855466;
        Fri, 24 Feb 2023 17:17:35 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:34 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 57/76] ssdfs: check b-tree hierarchy for add operation
Date:   Fri, 24 Feb 2023 17:09:08 -0800
Message-Id: <20230225010927.813929-58-slava@dubeyko.com>
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

The main goal of checking b-tree hierarchy for add operation is
to define how many new nodes and which type(s) should be added.
Any b-tree starts with creation of root node. The root node can
store only two index keys. Initially, SSDFS logic adds leaf
nodes into empty b-tree. If root node already contains two index
keys on leaf nodes, then hybrid node needs to be added into
the b-tree. Hybrid node contains as index as item areas. New items
will be added into items area of hybrid node until this area
becomes completely full. B-tree logic allocates new leaf node,
all existing items in hybrid node are moved into newly created leaf
node, and index key is added into hybrid node's index area.
Such operation repeat multiple times until index area of hybrid
node becomes completely full. Now index area is resized by
increasing twice in size after moving existing items into newly
created node. Finally, hybrid node will be converted into index node.
If root node contains two index keys on hybrid nodes, then
index node will be added in the b-tree. Generaly speaking, the leaf
nodes are always allocated for the lowest level. Next level contains
hybrid nodes. And the rest of b-tree levels contain index nodes.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree_hierarchy.c | 2747 ++++++++++++++++++++++++++++++++++++
 1 file changed, 2747 insertions(+)

diff --git a/fs/ssdfs/btree_hierarchy.c b/fs/ssdfs/btree_hierarchy.c
index cba502e6f3a6..6e9f91ed4541 100644
--- a/fs/ssdfs/btree_hierarchy.c
+++ b/fs/ssdfs/btree_hierarchy.c
@@ -2906,3 +2906,2750 @@ int ssdfs_btree_prepare_index_area_resize(struct ssdfs_btree_level *level,
 
 	return 0;
 }
+
+/*
+ * ssdfs_btree_check_nothing_root_pair() - check pair of nothing and root nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the nothing and root nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_nothing_root_pair(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	int child_type;
+	struct ssdfs_btree_node *child_node;
+	u64 start_hash, end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("child is NULL\n");
+		return -ERANGE;
+	}
+
+	child_type = atomic_read(&child_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "child id %u, child_type %#x\n",
+		  tree, search, parent, child,
+		  child_node->node_id, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (child_type != SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_WARN("invalid child node's type %#x\n",
+			   child_type);
+		return -ERANGE;
+	}
+
+	if (!(child->flags & SSDFS_BTREE_LEVEL_ADD_NODE))
+		return 0;
+
+	down_read(&child_node->header_lock);
+	start_hash = child_node->index_area.start_hash;
+	end_hash = U64_MAX;
+	up_read(&child_node->header_lock);
+
+	err = ssdfs_btree_prepare_add_index(parent,
+					    start_hash,
+					    end_hash,
+					    child_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare level: "
+			  "node_id %u, height %u\n",
+			  child_node->node_id,
+			  atomic_read(&child_node->height));
+		return err;
+	}
+
+	err = ssdfs_btree_define_moving_indexes(parent, child);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define moving indexes: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_root_nothing_pair() - check pair of root and nothing nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the root and nothing nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_root_nothing_pair(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	int tree_height;
+	int parent_type;
+	struct ssdfs_btree_node *parent_node;
+	u64 start_hash, end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id,
+		  parent_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height <= 0 || tree_height > 1) {
+		SSDFS_WARN("unexpected tree_height %u\n",
+			  tree_height);
+		return -EINVAL;
+	}
+
+	if (!can_add_new_index(parent_node)) {
+		SSDFS_ERR("unable add index into the root\n");
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	ssdfs_btree_prepare_add_node(tree, SSDFS_BTREE_LEAF_NODE,
+				     start_hash, end_hash,
+				     child, NULL);
+
+	err = ssdfs_btree_prepare_add_index(parent, start_hash,
+					    end_hash, parent_node);
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
+
+/*
+ * ssdfs_btree_check_root_index_pair() - check pair of root and index nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the root and index nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - needs to increase the tree's height.
+ */
+static
+int ssdfs_btree_check_root_index_pair(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	int parent_type, child_type;
+	int parent_height, child_height;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	u64 start_hash, end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("child is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+	child_type = atomic_read(&child_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, parent_type %#x, "
+		  "child id %u, child_type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id, parent_type,
+		  child_node->node_id, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	if (child_type != SSDFS_BTREE_INDEX_NODE) {
+		SSDFS_WARN("invalid child node's type %#x\n",
+			   child_type);
+		return -ERANGE;
+	}
+
+	parent_height = atomic_read(&parent_node->height);
+	child_height = atomic_read(&child_node->height);
+
+	if ((child_height + 1) != parent_height) {
+		SSDFS_ERR("invalid pair: "
+			  "parent_height %u, child_height %u\n",
+			  parent_height, child_height);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE) {
+		if (can_add_new_index(parent_node)) {
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u\n",
+					  parent_node->node_id);
+				return err;
+			}
+		} else {
+			ssdfs_btree_prepare_add_node(tree,
+						     SSDFS_BTREE_INDEX_NODE,
+						     start_hash, end_hash,
+						     parent, parent_node);
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+
+			/*
+			 * it needs to prepare increasing
+			 * the tree's height
+			 */
+			return -ENOSPC;
+		}
+	} else if (need_update_parent_index_area(start_hash, child_node)) {
+		err = ssdfs_btree_prepare_update_index(parent,
+							start_hash,
+							end_hash,
+							parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare update index: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	if (!parent->flags) {
+		err = ssdfs_btree_prepare_do_nothing(parent,
+						     parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare root node: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_root_hybrid_pair() - check pair of root and hybrid nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the root and hybrid nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - needs to increase the tree's height.
+ */
+static
+int ssdfs_btree_check_root_hybrid_pair(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	int tree_height;
+	int parent_type, child_type;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	u64 start_hash, end_hash;
+	u16 items_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("child is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+	child_type = atomic_read(&child_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, parent_type %#x, "
+		  "child id %u, child_type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id, parent_type,
+		  child_node->node_id, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	if (child_type != SSDFS_BTREE_HYBRID_NODE) {
+		SSDFS_WARN("invalid child node's type %#x\n",
+			   child_type);
+		return -ERANGE;
+	}
+
+	tree_height = atomic_read(&tree->height);
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	if (tree_height < 2) {
+		SSDFS_ERR("invalid tree height %d\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	down_read(&child_node->header_lock);
+	items_count = child_node->items_area.items_count;
+	up_read(&child_node->header_lock);
+
+	if (tree_height >= 3 && items_count == 0) {
+		err = ssdfs_btree_prepare_insert_item(child, search,
+						      child_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare the insert: "
+				  "node_id %u, height %u\n",
+				  child_node->node_id,
+				  atomic_read(&child_node->height));
+			return err;
+		}
+
+		if (need_update_parent_index_area(start_hash, child_node)) {
+			err = ssdfs_btree_prepare_update_index(parent,
+								start_hash,
+								end_hash,
+								parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare update index: "
+					  "err %d\n", err);
+				return err;
+			}
+		}
+	} else if (tree_height == 2) {
+		err = ssdfs_btree_prepare_insert_item(child, search, child_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare the insert: "
+				  "node_id %u, height %u\n",
+				  child_node->node_id,
+				  atomic_read(&child_node->height));
+			return err;
+		}
+
+		ssdfs_btree_prepare_add_node(tree, SSDFS_BTREE_LEAF_NODE,
+					     start_hash, end_hash,
+					     child, child_node);
+
+		err = ssdfs_btree_prepare_add_index(child,
+						    start_hash,
+						    end_hash,
+						    child_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare level: "
+				  "node_id %u, height %u\n",
+				  child_node->node_id,
+				  atomic_read(&child_node->height));
+			return err;
+		}
+
+		err = ssdfs_btree_define_moving_items(tree, search,
+							child, child);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define moving items: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		/*
+		 * it needs to prepare increasing
+		 * the tree's height
+		 */
+		return -ENOSPC;
+	} else if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE) {
+		if (can_add_new_index(parent_node)) {
+			err = ssdfs_btree_prepare_add_index(parent,
+							start_hash,
+							end_hash,
+							parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u\n",
+					  parent_node->node_id);
+				return err;
+			}
+		} else {
+			ssdfs_btree_prepare_add_node(tree,
+						SSDFS_BTREE_INDEX_NODE,
+						start_hash, end_hash,
+						parent, parent_node);
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							start_hash,
+							end_hash,
+							parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u\n",
+					  parent_node->node_id);
+				return err;
+			}
+
+			/*
+			 * it needs to prepare increasing
+			 * the tree's height
+			 */
+			return -ENOSPC;
+		}
+	} else if (need_update_parent_index_area(start_hash,
+						 child_node)) {
+		err = ssdfs_btree_prepare_update_index(parent,
+							start_hash,
+							end_hash,
+							parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare update index: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	if (!parent->flags) {
+		err = ssdfs_btree_prepare_do_nothing(parent,
+						     parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare root node: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_root_leaf_pair() - check pair of root and leaf nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the root and leaf nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - needs to increase the tree's height.
+ */
+static
+int ssdfs_btree_check_root_leaf_pair(struct ssdfs_btree *tree,
+				     struct ssdfs_btree_search *search,
+				     struct ssdfs_btree_level *parent,
+				     struct ssdfs_btree_level *child)
+{
+	int tree_height;
+	int parent_type, child_type;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	u64 start_hash, end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("child is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+	child_type = atomic_read(&child_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, parent_type %#x, "
+		  "child id %u, child_type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id, parent_type,
+		  child_node->node_id, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	if (child_type != SSDFS_BTREE_LEAF_NODE) {
+		SSDFS_WARN("invalid child node's type %#x\n",
+			   child_type);
+		return -ERANGE;
+	}
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height > 2) {
+		SSDFS_WARN("unexpected tree_height %u\n",
+			  tree_height);
+		return -EINVAL;
+	}
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	if (can_add_new_index(parent_node)) {
+		/* tree has only one leaf node */
+		err = ssdfs_btree_prepare_insert_item(child,
+						      search,
+						      child_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare the insert: "
+				  "node_id %u, height %u\n",
+				  child_node->node_id,
+				  atomic_read(&child_node->height));
+			return err;
+		}
+
+		if (ssdfs_need_move_items_to_sibling(child)) {
+			err = ssdfs_check_capability_move_to_sibling(child);
+			if (err == -ENOSPC) {
+				/*
+				 * It needs to add a node.
+				 */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to check moving to sibling: "
+					  "err %d\n", err);
+				return err;
+			}
+		} else
+			err = -ENOSPC;
+
+		if (err == -ENOSPC) {
+			ssdfs_btree_prepare_add_node(tree,
+						     SSDFS_BTREE_LEAF_NODE,
+						     start_hash, end_hash,
+						     child, child_node);
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		} else {
+			err = ssdfs_btree_prepare_update_index(parent,
+								start_hash,
+								end_hash,
+								parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare update index: "
+					  "err %d\n", err);
+				return err;
+			}
+		}
+	} else {
+		err = ssdfs_btree_prepare_insert_item(child,
+						      search,
+						      child_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare the insert: "
+				  "node_id %u, height %u\n",
+				  child_node->node_id,
+				  atomic_read(&child_node->height));
+			return err;
+		}
+
+		if (ssdfs_need_move_items_to_sibling(child)) {
+			err = ssdfs_check_capability_move_to_sibling(child);
+			if (err == -ENOSPC) {
+				/*
+				 * It needs to add a node.
+				 */
+				ssdfs_btree_cancel_insert_item(child);
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to check moving to sibling: "
+					  "err %d\n", err);
+				return err;
+			} else {
+				err = ssdfs_btree_prepare_update_index(parent,
+								start_hash,
+								end_hash,
+								parent_node);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to prepare update: "
+						  "err %d\n", err);
+					return err;
+				}
+
+				return 0;
+			}
+		} else
+			ssdfs_btree_cancel_insert_item(child);
+
+		ssdfs_btree_prepare_add_node(tree,
+					     SSDFS_BTREE_HYBRID_NODE,
+					     start_hash, end_hash,
+					     parent, parent_node);
+
+		err = ssdfs_btree_prepare_insert_item(parent,
+						      search,
+						      parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare the insert: "
+				  "node_id %u, height %u\n",
+				  parent_node->node_id,
+				  atomic_read(&parent_node->height));
+			return err;
+		}
+
+		if (ssdfs_need_move_items_to_parent(child)) {
+			err = ssdfs_prepare_move_items_to_parent(search,
+								 parent,
+								 child);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to check moving to sibling: "
+					  "err %d\n", err);
+				return err;
+			}
+		}
+
+		/* it needs to prepare increasing the tree's height */
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_index_index_pair() - check pair of index and index nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the index and index nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_index_index_pair(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	int parent_type, child_type;
+	int parent_height, child_height;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	u64 start_hash, end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("child is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+	child_type = atomic_read(&child_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, parent_type %#x, "
+		  "child id %u, child_type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id, parent_type,
+		  child_node->node_id, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_INDEX_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	if (child_type != SSDFS_BTREE_INDEX_NODE) {
+		SSDFS_WARN("invalid child node's type %#x\n",
+			   child_type);
+		return -ERANGE;
+	}
+
+	parent_height = atomic_read(&parent_node->height);
+	child_height = atomic_read(&child_node->height);
+
+	if ((child_height + 1) != parent_height) {
+		SSDFS_ERR("invalid pair: "
+			  "parent_height %u, child_height %u\n",
+			  parent_height, child_height);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE) {
+		if (can_add_new_index(parent_node)) {
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		} else {
+			ssdfs_btree_prepare_add_node(tree,
+						     SSDFS_BTREE_INDEX_NODE,
+						     start_hash, end_hash,
+						     parent, parent_node);
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		}
+	} else if (need_update_parent_index_area(start_hash, child_node)) {
+		err = ssdfs_btree_prepare_update_index(parent,
+							start_hash,
+							end_hash,
+							parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare update index: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	if (!parent->flags) {
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
+ * ssdfs_btree_check_index_hybrid_pair() - check pair of index and hybrid nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the index and hybrid nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_index_hybrid_pair(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	int parent_type, child_type;
+	int parent_height, child_height;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	u64 start_hash, end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("child is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+	child_type = atomic_read(&child_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, parent_type %#x, "
+		  "child id %u, child_type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id, parent_type,
+		  child_node->node_id, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_INDEX_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	if (child_type != SSDFS_BTREE_HYBRID_NODE) {
+		SSDFS_WARN("invalid child node's type %#x\n",
+			   child_type);
+		return -ERANGE;
+	}
+
+	parent_height = atomic_read(&parent_node->height);
+	child_height = atomic_read(&child_node->height);
+
+	if ((child_height + 1) != parent_height) {
+		SSDFS_ERR("invalid pair: "
+			  "parent_height %u, child_height %u\n",
+			  parent_height, child_height);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	if (child->flags & SSDFS_BTREE_TRY_RESIZE_INDEX_AREA) {
+		err = ssdfs_btree_define_moving_indexes(parent, child);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define moving indexes: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		if (need_update_parent_index_area(start_hash, child_node)) {
+			err = ssdfs_btree_prepare_update_index(parent,
+								start_hash,
+								end_hash,
+								parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare update index: "
+					  "err %d\n", err);
+				return err;
+			}
+		}
+	} else if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE) {
+		if (can_add_new_index(parent_node)) {
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		} else {
+			ssdfs_btree_prepare_add_node(tree,
+						     SSDFS_BTREE_INDEX_NODE,
+						     start_hash, end_hash,
+						     parent, parent_node);
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		}
+	} else if (need_update_parent_index_area(start_hash, child_node)) {
+		err = ssdfs_btree_prepare_update_index(parent,
+							start_hash,
+							end_hash,
+							parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare update index: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	if (!parent->flags) {
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
+ * ssdfs_btree_check_index_leaf_pair() - check pair of index and leaf nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the index and leaf nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_index_leaf_pair(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	int parent_type, child_type;
+	int parent_height, child_height;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	u64 start_hash, end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("child is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+	child_type = atomic_read(&child_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, parent_type %#x, "
+		  "child id %u, child_type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id, parent_type,
+		  child_node->node_id, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_INDEX_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	if (child_type != SSDFS_BTREE_LEAF_NODE) {
+		SSDFS_WARN("invalid child node's type %#x\n",
+			   child_type);
+		return -ERANGE;
+	}
+
+	parent_height = atomic_read(&parent_node->height);
+	child_height = atomic_read(&child_node->height);
+
+	if ((child_height + 1) != parent_height) {
+		SSDFS_ERR("invalid pair: "
+			  "parent_height %u, child_height %u\n",
+			  parent_height, child_height);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	if (can_add_new_index(parent_node)) {
+		err = ssdfs_btree_prepare_insert_item(child,
+						      search,
+						      child_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare the insert: "
+				  "node_id %u, height %u\n",
+				  child_node->node_id,
+				  atomic_read(&child_node->height));
+			return err;
+		}
+
+		if (ssdfs_need_move_items_to_sibling(child)) {
+			err = ssdfs_check_capability_move_to_sibling(child);
+			if (err == -ENOSPC) {
+				/*
+				 * It needs to add a node.
+				 */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to check moving to sibling: "
+					  "err %d\n", err);
+				return err;
+			}
+		} else
+			err = -ENOSPC;
+
+		if (err == -ENOSPC) {
+			ssdfs_btree_prepare_add_node(tree,
+						     SSDFS_BTREE_LEAF_NODE,
+						     start_hash, end_hash,
+						     child, child_node);
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		} else {
+			err = ssdfs_btree_prepare_update_index(parent,
+								start_hash,
+								end_hash,
+								parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare update index: "
+					  "err %d\n", err);
+				return err;
+			}
+		}
+	} else {
+		err = ssdfs_check_capability_move_indexes_to_sibling(parent);
+		if (err == -ENOENT) {
+			ssdfs_btree_prepare_add_node(tree,
+						     SSDFS_BTREE_INDEX_NODE,
+						     U64_MAX, U64_MAX,
+						     parent, parent_node);
+
+			err = ssdfs_prepare_move_indexes_right(parent,
+								parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare to move indexes: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		} else if (err == -ENOSPC) {
+			ssdfs_btree_prepare_add_node(tree,
+						     SSDFS_BTREE_INDEX_NODE,
+						     U64_MAX, U64_MAX,
+						     parent, parent_node);
+
+			err = ssdfs_prepare_move_indexes_right(parent,
+								parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare to move indexes: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare to move indexes: "
+				  "node_id %u, height %u\n",
+				  parent_node->node_id,
+				  atomic_read(&parent_node->height));
+			return err;
+		} else {
+			/*
+			 * Do nothing.
+			 * The index moving has been prepared already.
+			 */
+		}
+
+		/* make first phase of transformation */
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_hybrid_nothing_pair() - check pair of hybrid and nothing
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the hybrid and nothing nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_hybrid_nothing_pair(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	int parent_type;
+	struct ssdfs_btree_node *parent_node;
+	u64 start_hash, end_hash;
+	u16 items_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id,
+		  parent_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_HYBRID_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	down_read(&parent_node->header_lock);
+	items_count = parent_node->items_area.items_count;
+	start_hash = parent_node->items_area.start_hash;
+	end_hash = parent_node->items_area.end_hash;
+	up_read(&parent_node->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %u, start_hash %llx, end_hash %llx\n",
+		  items_count, start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (items_count == 0) {
+		/*
+		 * Do nothing.
+		*/
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("parent id %u, type %#x, items_count == 0\n",
+			  parent_node->node_id,
+			  parent_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (can_add_new_index(parent_node)) {
+		ssdfs_btree_prepare_add_node(tree, SSDFS_BTREE_LEAF_NODE,
+					     start_hash, end_hash,
+					     child, NULL);
+
+		err = ssdfs_btree_prepare_add_index(parent,
+						    start_hash,
+						    start_hash,
+						    parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare update index: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_btree_define_moving_items(tree, search,
+							parent, child);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define moving items: "
+				  "err %d\n", err);
+			return err;
+		}
+	} else if (is_index_area_resizable(parent_node)) {
+		err = ssdfs_btree_prepare_index_area_resize(parent,
+							parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare resize of index area: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		ssdfs_btree_prepare_add_node(tree, SSDFS_BTREE_LEAF_NODE,
+					     start_hash, end_hash,
+					     child, NULL);
+
+		err = ssdfs_btree_prepare_add_index(parent,
+						    start_hash,
+						    start_hash,
+						    parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare update index: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_btree_define_moving_items(tree, search,
+							parent, child);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define moving items: "
+				  "err %d\n", err);
+			return err;
+		}
+	} else {
+		start_hash = search->request.start.hash;
+		end_hash = search->request.end.hash;
+
+		ssdfs_btree_prepare_add_node(tree, SSDFS_BTREE_HYBRID_NODE,
+					     start_hash, end_hash,
+					     parent, parent_node);
+	}
+
+	if (!parent->flags) {
+		err = ssdfs_btree_prepare_do_nothing(parent,
+						     parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare root node: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_hybrid_index_pair() - check pair of hybrid and index nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the hybrid and index nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_hybrid_index_pair(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	int parent_type, child_type;
+	int parent_height, child_height;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	u64 start_hash, end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("child is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+	child_type = atomic_read(&child_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, parent_type %#x, "
+		  "child id %u, child_type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id, parent_type,
+		  child_node->node_id, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_HYBRID_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	if (child_type != SSDFS_BTREE_INDEX_NODE) {
+		SSDFS_WARN("invalid child node's type %#x\n",
+			   child_type);
+		return -ERANGE;
+	}
+
+	parent_height = atomic_read(&parent_node->height);
+	child_height = atomic_read(&child_node->height);
+
+	if ((child_height + 1) != parent_height) {
+		SSDFS_ERR("invalid pair: "
+			  "parent_height %u, child_height %u\n",
+			  parent_height, child_height);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE) {
+		if (can_add_new_index(parent_node)) {
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		} else if (is_index_area_resizable(parent_node)) {
+			err = ssdfs_btree_prepare_index_area_resize(parent,
+								parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare resize of index area: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		} else {
+			ssdfs_btree_prepare_add_node(tree,
+						     SSDFS_BTREE_HYBRID_NODE,
+						     start_hash, end_hash,
+						     parent, parent_node);
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		}
+	} else if (need_update_parent_index_area(start_hash, child_node)) {
+		err = ssdfs_btree_prepare_update_index(parent,
+							start_hash,
+							end_hash,
+							parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare update index: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	if (!parent->flags) {
+		err = ssdfs_btree_prepare_do_nothing(parent,
+						     parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare hybrid node: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_hybrid_hybrid_pair() - check pair of hybrid + hybrid nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the hybrid and hybrid nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_hybrid_hybrid_pair(struct ssdfs_btree *tree,
+					 struct ssdfs_btree_search *search,
+					 struct ssdfs_btree_level *parent,
+					 struct ssdfs_btree_level *child)
+{
+	int parent_type, child_type;
+	int parent_height, child_height;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	u64 start_hash, end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("child is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+	child_type = atomic_read(&child_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, parent_type %#x, "
+		  "child id %u, child_type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id, parent_type,
+		  child_node->node_id, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_HYBRID_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	if (child_type != SSDFS_BTREE_HYBRID_NODE) {
+		SSDFS_WARN("invalid child node's type %#x\n",
+			   child_type);
+		return -ERANGE;
+	}
+
+	parent_height = atomic_read(&parent_node->height);
+	child_height = atomic_read(&child_node->height);
+
+	if ((child_height + 1) != parent_height) {
+		SSDFS_ERR("invalid pair: "
+			  "parent_height %u, child_height %u\n",
+			  parent_height, child_height);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	err = ssdfs_btree_define_moving_items(tree, search,
+						parent, child);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define moving items: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	if (child->flags & SSDFS_BTREE_TRY_RESIZE_INDEX_AREA) {
+		err = ssdfs_btree_define_moving_indexes(parent, child);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define moving indexes: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_btree_prepare_update_index(parent,
+							start_hash,
+							end_hash,
+							parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare update index: "
+				  "err %d\n", err);
+			return err;
+		}
+	} else if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE) {
+		if (can_add_new_index(parent_node)) {
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		} else if (is_index_area_resizable(parent_node)) {
+			err = ssdfs_btree_prepare_index_area_resize(parent,
+								parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare resize of index area: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		} else {
+			ssdfs_btree_prepare_add_node(tree,
+						     SSDFS_BTREE_HYBRID_NODE,
+						     start_hash, end_hash,
+						     parent, parent_node);
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+		}
+	} else if (need_update_parent_index_area(start_hash, child_node)) {
+		err = ssdfs_btree_prepare_update_index(parent,
+							start_hash,
+							end_hash,
+							parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare update index: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	if (!parent->flags) {
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
+ * ssdfs_btree_check_hybrid_leaf_pair() - check pair of hybrid and leaf nodes
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the hybrid and leaf nodes pair.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_check_hybrid_leaf_pair(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	int parent_type, child_type;
+	int parent_height, child_height;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	u64 start_hash, end_hash;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_node = parent->nodes.old_node.ptr;
+
+	if (!parent_node) {
+		SSDFS_ERR("parent is NULL\n");
+		return -ERANGE;
+	}
+
+	child_node = child->nodes.old_node.ptr;
+
+	if (!child_node) {
+		SSDFS_ERR("child is NULL\n");
+		return -ERANGE;
+	}
+
+	parent_type = atomic_read(&parent_node->type);
+	child_type = atomic_read(&child_node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree %p, search %p, "
+		  "parent %p, child %p, "
+		  "parent id %u, parent_type %#x, "
+		  "child id %u, child_type %#x\n",
+		  tree, search, parent, child,
+		  parent_node->node_id, parent_type,
+		  child_node->node_id, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_type != SSDFS_BTREE_HYBRID_NODE) {
+		SSDFS_WARN("invalid parent node's type %#x\n",
+			   parent_type);
+		return -ERANGE;
+	}
+
+	if (child_type != SSDFS_BTREE_LEAF_NODE) {
+		SSDFS_WARN("invalid child node's type %#x\n",
+			   child_type);
+		return -ERANGE;
+	}
+
+	parent_height = atomic_read(&parent_node->height);
+	child_height = atomic_read(&child_node->height);
+
+	if ((child_height + 1) != parent_height) {
+		SSDFS_ERR("invalid pair: "
+			  "parent_height %u, child_height %u\n",
+			  parent_height, child_height);
+		return -ERANGE;
+	}
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	err = ssdfs_btree_prepare_insert_item(child, search, child_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare the insert: "
+			  "node_id %u, height %u\n",
+			  child_node->node_id,
+			  atomic_read(&child_node->height));
+		return err;
+	}
+
+	if (ssdfs_need_move_items_to_sibling(child)) {
+		err = ssdfs_check_capability_move_to_sibling(child);
+		if (err == -ENOSPC) {
+			/*
+			 * It needs to add a node.
+			 */
+			goto try_add_node;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to check moving to sibling: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_btree_prepare_update_index(parent,
+						start_hash,
+						end_hash,
+						parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare update: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		return 0;
+	}
+
+try_add_node:
+	ssdfs_btree_prepare_add_node(tree,
+				     SSDFS_BTREE_LEAF_NODE,
+				     start_hash, end_hash,
+				     child, child_node);
+
+	if (can_add_new_index(parent_node)) {
+		err = ssdfs_btree_prepare_add_index(parent,
+						    start_hash,
+						    end_hash,
+						    parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare level: "
+				  "node_id %u, height %u\n",
+				  parent_node->node_id,
+				  atomic_read(&parent_node->height));
+			return err;
+		}
+	} else if (is_index_area_resizable(parent_node)) {
+		err = ssdfs_btree_prepare_index_area_resize(parent,
+							parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare resize: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_btree_prepare_add_index(parent,
+						    start_hash,
+						    end_hash,
+						    parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare level: "
+				  "node_id %u, height %u\n",
+				  parent_node->node_id,
+				  atomic_read(&parent_node->height));
+			return err;
+		}
+
+		err = ssdfs_btree_define_moving_items(tree, search,
+							parent, child);
+		if (err == -EAGAIN) {
+			ssdfs_btree_cancel_insert_item(child);
+			ssdfs_btree_cancel_move_items_to_sibling(child);
+			ssdfs_btree_cancel_add_index(parent);
+
+			down_read(&parent_node->header_lock);
+			start_hash = parent_node->items_area.start_hash;
+			up_read(&parent_node->header_lock);
+
+			end_hash = start_hash;
+
+			ssdfs_btree_prepare_add_node(tree,
+						     SSDFS_BTREE_LEAF_NODE,
+						     start_hash, end_hash,
+						     child, child_node);
+
+			err = ssdfs_btree_prepare_add_index(parent,
+							    start_hash,
+							    end_hash,
+							    parent_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+
+			err = ssdfs_define_hybrid_node_moving_items(tree,
+								start_hash,
+								end_hash,
+								parent_node,
+								NULL,
+								parent,
+								child);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare level: "
+					  "node_id %u, height %u\n",
+					  parent_node->node_id,
+					  atomic_read(&parent_node->height));
+				return err;
+			}
+
+			/* make first phase of transformation */
+			return -EAGAIN;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to define moving items: "
+				  "err %d\n", err);
+			return err;
+		}
+	} else {
+		ssdfs_btree_prepare_add_node(tree,
+					     SSDFS_BTREE_HYBRID_NODE,
+					     start_hash, end_hash,
+					     parent, parent_node);
+
+		if (ssdfs_need_move_items_to_parent(child)) {
+			err = ssdfs_prepare_move_items_to_parent(search,
+								 parent,
+								 child);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to check moving to parent: "
+					  "err %d\n", err);
+				return err;
+			}
+		}
+
+		err = ssdfs_btree_prepare_add_index(parent,
+						    start_hash,
+						    end_hash,
+						    parent_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare level: "
+				  "node_id %u, height %u\n",
+				  parent_node->node_id,
+				  atomic_read(&parent_node->height));
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_check_level_for_add() - check btree's level for adding a node
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to check the level of btree for adding a node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - needs to increase the tree's height.
+ */
+int ssdfs_btree_check_level_for_add(struct ssdfs_btree_state_descriptor *desc,
+				    struct ssdfs_btree *tree,
+				    struct ssdfs_btree_search *search,
+				    struct ssdfs_btree_level *parent,
+				    struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *node = NULL;
+	int parent_type, child_type;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !tree || !search);
+	BUG_ON(!parent || !child);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p, parent %p, child %p\n",
+		  tree, search, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_type = parent->nodes.old_node.type;
+	if (parent_type != SSDFS_BTREE_NODE_UNKNOWN_TYPE) {
+		BUG_ON(!parent->nodes.old_node.ptr);
+		parent_type = atomic_read(&parent->nodes.old_node.ptr->type);
+	}
+
+	child_type = child->nodes.old_node.type;
+	if (child_type != SSDFS_BTREE_NODE_UNKNOWN_TYPE) {
+		BUG_ON(!child->nodes.old_node.ptr);
+		child_type = atomic_read(&child->nodes.old_node.ptr->type);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("parent_type %#x, child_type %#x\n",
+		  parent_type, child_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (parent_type) {
+	case SSDFS_BTREE_NODE_UNKNOWN_TYPE:
+		switch (child_type) {
+		case SSDFS_BTREE_ROOT_NODE:
+			err = ssdfs_btree_check_nothing_root_pair(tree,
+								  search,
+								  parent,
+								  child);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to check nothing-root pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child_type);
+		};
+		break;
+
+	case SSDFS_BTREE_ROOT_NODE:
+		switch (child_type) {
+		case SSDFS_BTREE_NODE_UNKNOWN_TYPE:
+			err = ssdfs_btree_check_root_nothing_pair(tree,
+								  search,
+								  parent,
+								  child);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to check root-nothing pair: "
+					  "err %d\n", err);
+			}
+
+			node = parent->nodes.old_node.ptr;
+			if (is_ssdfs_btree_node_index_area_empty(node)) {
+				/* root node should be moved on upper level */
+				desc->increment_height = true;
+				SSDFS_DBG("need to grow the tree height\n");
+			}
+			break;
+
+		case SSDFS_BTREE_INDEX_NODE:
+			err = ssdfs_btree_check_root_index_pair(tree,
+								search,
+								parent,
+								child);
+			if (err == -ENOSPC) {
+				/* root node should be moved on upper level */
+				desc->increment_height = true;
+				SSDFS_DBG("need to grow the tree height\n");
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to check root-index pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			err = ssdfs_btree_check_root_hybrid_pair(tree,
+								 search,
+								 parent,
+								 child);
+			if (err == -ENOSPC) {
+				/* root node should be moved on upper level */
+				desc->increment_height = true;
+				SSDFS_DBG("need to grow the tree height\n");
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to check root-hybrid pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		case SSDFS_BTREE_LEAF_NODE:
+			err = ssdfs_btree_check_root_leaf_pair(tree,
+								search,
+								parent,
+								child);
+			if (err == -ENOSPC) {
+				/* root node should be moved on upper level */
+				desc->increment_height = true;
+				SSDFS_DBG("need to grow the tree height\n");
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to check root-leaf pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child_type);
+		};
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		switch (child_type) {
+		case SSDFS_BTREE_INDEX_NODE:
+			err = ssdfs_btree_check_index_index_pair(tree,
+								 search,
+								 parent,
+								 child);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to check index-index pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			err = ssdfs_btree_check_index_hybrid_pair(tree,
+								  search,
+								  parent,
+								  child);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to check index-hybrid pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		case SSDFS_BTREE_LEAF_NODE:
+			err = ssdfs_btree_check_index_leaf_pair(tree,
+								search,
+								parent,
+								child);
+			if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("need to prepare hierarchy: "
+					  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to check index-leaf pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child_type);
+		};
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		switch (child_type) {
+		case SSDFS_BTREE_NODE_UNKNOWN_TYPE:
+			err = ssdfs_btree_check_hybrid_nothing_pair(tree,
+								  search,
+								  parent,
+								  child);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to check hybrid-nothing pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		case SSDFS_BTREE_INDEX_NODE:
+			err = ssdfs_btree_check_hybrid_index_pair(tree,
+								  search,
+								  parent,
+								  child);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to check hybrid-index pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			err = ssdfs_btree_check_hybrid_hybrid_pair(tree,
+								   search,
+								   parent,
+								   child);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to check hybrid-hybrid pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		case SSDFS_BTREE_LEAF_NODE:
+			err = ssdfs_btree_check_hybrid_leaf_pair(tree,
+								 search,
+								 parent,
+								 child);
+			if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("need to prepare hierarchy: "
+					  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to check hybrid-leaf pair: "
+					  "err %d\n", err);
+			}
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child_type);
+		};
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid parent node's type %#x\n",
+			  parent_type);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_descend_to_leaf_node() - descend to a leaf node
+ * @tree: btree object
+ * @search: search object
+ *
+ * This method tries to descend from the current level till a leaf node.
+ *
+ * RETURN:
+ * [success] - pointer on a leaf node.
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+struct ssdfs_btree_node *
+ssdfs_btree_descend_to_leaf_node(struct ssdfs_btree *tree,
+				 struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node = NULL;
+	int type;
+	u64 upper_hash;
+	u64 start_item_hash;
+	u16 items_count;
+	u32 prev_node_id;
+	int counter = 0;
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
+	if (search->node.height == SSDFS_BTREE_LEAF_NODE_HEIGHT) {
+		SSDFS_DBG("search object contains leaf node\n");
+		return 0;
+	}
+
+	if (!search->node.child) {
+		err = -ERANGE;
+		SSDFS_ERR("child node object is NULL\n");
+		return ERR_PTR(err);
+	}
+
+	type = atomic_read(&search->node.child->type);
+	if (type != SSDFS_BTREE_HYBRID_NODE) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid search object: "
+			  "height %u, node_type %#x\n",
+			  atomic_read(&search->node.child->height),
+			  type);
+		return ERR_PTR(err);
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(search->node.child)) {
+		err = -ERANGE;
+		SSDFS_ERR("index area is absent: "
+			  "node_id %u\n",
+			  search->node.child->node_id);
+		return ERR_PTR(err);
+	}
+
+	down_read(&search->node.child->header_lock);
+	items_count = search->node.child->items_area.items_count;
+	start_item_hash = search->node.child->items_area.start_hash;
+	upper_hash = search->node.child->index_area.end_hash;
+	up_read(&search->node.child->header_lock);
+
+	if (upper_hash >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid upper hash\n");
+		return ERR_PTR(err);
+	}
+
+	node = search->node.child;
+	prev_node_id = node->node_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, items_count %u, "
+		  "start_item_hash %llx, end_index_hash %llx\n",
+		  node->node_id, items_count,
+		  start_item_hash, upper_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (type == SSDFS_BTREE_HYBRID_NODE) {
+		if (items_count == 0)
+			return node;
+		else if (start_item_hash >= U64_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid start_item_hash %llx\n",
+				  start_item_hash);
+			return ERR_PTR(err);
+		}
+
+		if (start_item_hash == upper_hash)
+			return node;
+	}
+
+	do {
+		node = ssdfs_btree_get_child_node_for_hash(tree, node,
+							   upper_hash);
+		if (IS_ERR_OR_NULL(node)) {
+			err = !node ? -ERANGE : PTR_ERR(node);
+			SSDFS_ERR("fail to get the child node: err %d\n",
+				  err);
+			return node;
+		}
+
+		if (prev_node_id == node->node_id) {
+			counter++;
+
+			if (counter > 3) {
+				SSDFS_ERR("infinite cycle suspected: "
+					  "node_id %u, counter %d\n",
+					  node->node_id,
+					  counter);
+				return ERR_PTR(-ERANGE);
+			}
+		} else
+			prev_node_id = node->node_id;
+
+		type = atomic_read(&node->type);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u, type %#x, "
+			  "end_index_hash %llx\n",
+			  node->node_id, atomic_read(&node->type),
+			  upper_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		switch (type) {
+		case SSDFS_BTREE_LEAF_NODE:
+			/* do nothing */
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+		case SSDFS_BTREE_INDEX_NODE:
+			if (!is_ssdfs_btree_node_index_area_exist(node)) {
+				err = -ERANGE;
+				SSDFS_ERR("index area is absent: "
+					  "node_id %u\n",
+					  node->node_id);
+				return ERR_PTR(err);
+			}
+
+			down_read(&node->header_lock);
+			upper_hash = node->index_area.end_hash;
+			up_read(&node->header_lock);
+
+			if (upper_hash == U64_MAX) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid upper hash\n");
+				return ERR_PTR(err);
+			}
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid node type: "
+				  "node_id %u, height %u, type %#x\n",
+				  node->node_id,
+				  atomic_read(&node->height),
+				  type);
+			return ERR_PTR(err);
+		}
+	} while (type != SSDFS_BTREE_LEAF_NODE);
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return ERR_PTR(err);
+	}
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid items area state: node_id %u\n",
+			   search->node.id);
+		return ERR_PTR(err);
+	}
+
+	return node;
+}
+
+static
+void ssdfs_btree_hierarchy_init_hash_range(struct ssdfs_btree_level *level,
+					   struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!node)
+		return;
+
+	down_read(&node->header_lock);
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		level->nodes.old_node.index_hash.start =
+					node->index_area.start_hash;
+		level->nodes.old_node.index_hash.end =
+					node->index_area.end_hash;
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		level->nodes.old_node.index_hash.start =
+					node->index_area.start_hash;
+		level->nodes.old_node.index_hash.end =
+					node->index_area.end_hash;
+		level->nodes.old_node.items_hash.start =
+					node->items_area.start_hash;
+		level->nodes.old_node.items_hash.end =
+					node->items_area.end_hash;
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		level->nodes.old_node.items_hash.start =
+					node->items_area.start_hash;
+		level->nodes.old_node.items_hash.end =
+					node->items_area.end_hash;
+		break;
+
+	default:
+		SSDFS_WARN("unexpected node type %#x\n",
+			   atomic_read(&node->type));
+		break;
+	}
+	up_read(&node->header_lock);
+}
+
+/*
+ * ssdfs_btree_check_hierarchy_for_add() - check the btree for add node
+ * @tree: btree object
+ * @search: search object
+ * @hierarchy: btree's hierarchy object
+ *
+ * This method tries to check the btree's hierarchy for operation of
+ * node addition.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_check_hierarchy_for_add(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_hierarchy *hierarchy)
+{
+	struct ssdfs_btree_level *level;
+	struct ssdfs_btree_node *parent_node, *child_node;
+	int child_node_height, cur_height, tree_height;
+	int parent_node_type, child_node_type;
+	spinlock_t *lock = NULL;
+	int err;
+	int res = 0;
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
+	if (tree_height <= 0) {
+		SSDFS_ERR("invalid tree_height %d\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	if (search->node.id == SSDFS_BTREE_ROOT_NODE_ID) {
+		if (tree_height <= 0 || tree_height > 1) {
+			SSDFS_ERR("invalid search object state: "
+				  "tree_height %u, node_id %u\n",
+				  tree_height,
+				  search->node.id);
+			return -ERANGE;
+		}
+
+		child_node = search->node.child;
+		parent_node = search->node.parent;
+
+		if (child_node || !parent_node) {
+			SSDFS_ERR("invalid search object state: "
+				  "child_node %p, parent_node %p\n",
+				  child_node, parent_node);
+			return -ERANGE;
+		}
+
+		parent_node_type = atomic_read(&parent_node->type);
+		child_node_type = SSDFS_BTREE_NODE_UNKNOWN_TYPE;
+
+		if (parent_node_type != SSDFS_BTREE_ROOT_NODE) {
+			SSDFS_ERR("invalid parent node's type %#x\n",
+				  parent_node_type);
+			return -ERANGE;
+		}
+
+		child_node_height = search->node.height;
+	} else {
+		child_node = search->node.child;
+		parent_node = search->node.parent;
+
+		if (!child_node || !parent_node) {
+			SSDFS_ERR("invalid search object state: "
+				  "child_node %p, parent_node %p\n",
+				  child_node, parent_node);
+			return -ERANGE;
+		}
+
+		switch (atomic_read(&child_node->type)) {
+		case SSDFS_BTREE_LEAF_NODE:
+			/* do nothing */
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			child_node = ssdfs_btree_descend_to_leaf_node(tree,
+								      search);
+			if (unlikely(IS_ERR_OR_NULL(child_node))) {
+				err = !child_node ?
+					-ERANGE : PTR_ERR(child_node);
+				SSDFS_ERR("fail to descend to leaf node: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			lock = &child_node->descriptor_lock;
+			spin_lock(lock);
+			parent_node = child_node->parent_node;
+			spin_unlock(lock);
+			lock = NULL;
+
+			if (!child_node || !parent_node) {
+				SSDFS_ERR("invalid search object state: "
+					  "child_node %p, parent_node %p\n",
+					  child_node, parent_node);
+				return -ERANGE;
+			}
+			break;
+
+		default:
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  atomic_read(&child_node->type));
+			return -ERANGE;
+		}
+
+		parent_node_type = atomic_read(&parent_node->type);
+		child_node_type = atomic_read(&child_node->type);
+
+		switch (child_node_type) {
+		case SSDFS_BTREE_LEAF_NODE:
+		case SSDFS_BTREE_HYBRID_NODE:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child_node_type);
+			return -ERANGE;
+		}
+
+		child_node_height = atomic_read(&child_node->height);
+	}
+
+	cur_height = child_node_height;
+	if (cur_height > tree_height) {
+		SSDFS_ERR("cur_height %u > tree_height %u\n",
+			  cur_height, tree_height);
+		return -ERANGE;
+	}
+
+	if ((cur_height + 1) >= hierarchy->desc.height) {
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
+
+	if (child_node_type == SSDFS_BTREE_HYBRID_NODE) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(cur_height < 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		cur_height--;
+	}
+
+	for (; cur_height <= tree_height; cur_height++) {
+		struct ssdfs_btree_level *parent;
+		struct ssdfs_btree_level *child;
+
+		parent = hierarchy->array_ptr[cur_height + 1];
+		child = hierarchy->array_ptr[cur_height];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cur_height %d, tree_height %d\n",
+			  cur_height, tree_height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_btree_check_level_for_add(&hierarchy->desc,
+						      tree, search,
+						      parent, child);
+		if (err == -EAGAIN) {
+			res = -EAGAIN;
+			err = 0;
+			ssdfs_debug_btree_hierarchy_object(hierarchy);
+			SSDFS_DBG("need to prepare btree hierarchy for add\n");
+			/* continue logic for upper layers */
+			continue;
+		} else if (err == -ENOSPC) {
+			if ((cur_height + 1) != (tree_height - 1)) {
+				ssdfs_debug_btree_hierarchy_object(hierarchy);
+				SSDFS_ERR("invalid current height: "
+					  "cur_height %u, tree_height %u\n",
+					  cur_height, tree_height);
+				return -ERANGE;
+			} else {
+				err = 0;
+				continue;
+			}
+		} else if (unlikely(err)) {
+			ssdfs_debug_btree_hierarchy_object(hierarchy);
+			SSDFS_ERR("fail to check btree's level: "
+				  "cur_height %u, tree_height %u, "
+				  "err %d\n",
+				  cur_height, tree_height, err);
+			return err;
+		} else if ((cur_height + 1) >= tree_height)
+			break;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_btree_hierarchy_object(hierarchy);
+
+	return res;
+}
-- 
2.34.1


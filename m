Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1E36A2664
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBYBTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBYBTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:09 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A234D16AFF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:42 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q15so781678oiw.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrU+T5eeodCOduc9KnHpBgEpwyFrwnPHYxu6nWFw+6s=;
        b=CDnXZQzQx3hRh20Q3woSjT5backRqZWn28AQgqnCyGRO15URxUOKk3fM7xVwX6TdR4
         KNglDxGaw/Fg/FuL4SOfufzs3O5KQOgXjGTq1mnAOhX7/5A9+yL9ltXN599FBT6FKNmq
         FTaKZL7VPuvFfTsLANJxu2dIkpb49AWgd9dgrPVLJhnlAlqmgS3tXuZx/1+WnvGOURf7
         CHR7fWoo5bSfInd4Tx6GyU4OsrM32HCxwzfjqs9uEw9/Vuuw3vuvjC9ICnxyFVpkguLE
         ue1jL2g6fu8AGMF2zcZDS/91Xeh5jou3/FWrjOAM+V3FB0XiZFbzA/EwG8AJrJKQ/OkQ
         57sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrU+T5eeodCOduc9KnHpBgEpwyFrwnPHYxu6nWFw+6s=;
        b=GrPzhItPmx3TD2i8nxbqAV/3Wg8bKK43IdP0NjLky/AQsociCBQRA7kMIjK32gBe9t
         4ZcSMyPh6duXPpbPR6Af7MdDRQ2zh9bpHv/Nyo9VUrk5pXXwcTgo6l06z4TxUXygm8pd
         q+5bzCLb1eNBMmPy+XBO6ST1BCDANiwGeemgP5nfG3w/LrEo3VY967PWxOtYhY9XF3XX
         oD8CSKELj/xUsd8AUlyYxnxV7+c+pBvZlVfQZv3xz91iEpXpZaNt64GqKx1qEw0N+7Ix
         XEKWGyfMo+OwfdRTxz3wFFnDJgQVkXrXAFLFDIr7MFHF+dof+1CjSk92RPC2ClfHsAHu
         ZE6Q==
X-Gm-Message-State: AO0yUKVdJHX5YIW9pIxJz8LOyV6wpZFjY89wwdrQg9LdQGiZuRBT7pDE
        /AR7N1uD+MNfgg5P2FCJa4Fbuk5qdsk+GhXG
X-Google-Smtp-Source: AK7set8GJomXWpvmkn4nMh5dYCKa4l8JlNngQGJAU761anVHKyW/usIs+swAx1AqQgdU66nprxoi1w==
X-Received: by 2002:a05:6808:2d6:b0:374:3688:36ee with SMTP id a22-20020a05680802d600b00374368836eemr4792193oid.54.1677287860272;
        Fri, 24 Feb 2023 17:17:40 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:39 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 59/76] ssdfs: execute b-tree hierarchy modification
Date:   Fri, 24 Feb 2023 17:09:10 -0800
Message-Id: <20230225010927.813929-60-slava@dubeyko.com>
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

For every b-tree modification request, file system logic creates
the hierarchy object and executes the b-tree hierarchy check.
The checking logic defines the actions that should be done for
every level of b-tree to execute b-tree node's add or delete
operation. Finally, b-tree hierarchy object represents the actions
plan that modification logic has to execute. The execution logic
simply starts from the bottom of the hierarchy and executes planned
action for every level of b-tree. The planned actions could include
adding a new empty node, moving items from hybrid parent node into
leaf one, rebalancing b-tree, updating indexes. Finally, b-tree
should be able to receive new items/indexes and be consistent.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree_hierarchy.c | 1869 ++++++++++++++++++++++++++++++++++++
 1 file changed, 1869 insertions(+)

diff --git a/fs/ssdfs/btree_hierarchy.c b/fs/ssdfs/btree_hierarchy.c
index 3c1444732019..a6a42833d57f 100644
--- a/fs/ssdfs/btree_hierarchy.c
+++ b/fs/ssdfs/btree_hierarchy.c
@@ -7549,3 +7549,1872 @@ int ssdfs_btree_move_indexes_to_child(struct ssdfs_btree_state_descriptor *desc,
 
 	return 0;
 }
+
+/*
+ * ssdfs_btree_move_indexes_right() - move indexes from old to new node
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to move indexes from the old to new node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_move_indexes_right(struct ssdfs_btree_state_descriptor *desc,
+				   struct ssdfs_btree_level *parent,
+				   struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node;
+	struct ssdfs_btree_node *old_node;
+	struct ssdfs_btree_node *new_node;
+	int type;
+	u16 start, count;
+	u32 calculated;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !parent || !child);
+
+	if (!(child->flags & SSDFS_BTREE_INDEX_AREA_NEED_MOVE &&
+	      child->index_area.move.direction == SSDFS_BTREE_MOVE_TO_RIGHT)) {
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
+	parent_node = parent->nodes.old_node.ptr;
+	if (!parent_node) {
+		SSDFS_ERR("fail to move indexes: "
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
+	if (child->index_area.move.op_state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  child->index_area.move.op_state);
+		return -ERANGE;
+	} else
+		child->index_area.move.op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	old_node = child->nodes.old_node.ptr;
+	new_node = child->nodes.new_node.ptr;
+
+	if (!old_node || !new_node) {
+		SSDFS_ERR("fail to move indexes: "
+			  "old_node %p, new_node %p\n",
+			  old_node, new_node);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&old_node->type);
+	switch (type) {
+	case SSDFS_BTREE_INDEX_NODE:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("old node is not index node: "
+			  "node_id %u, type %#x\n",
+			  old_node->node_id, type);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&new_node->type);
+	switch (type) {
+	case SSDFS_BTREE_INDEX_NODE:
+		/* expected type */
+		break;
+
+	default:
+		SSDFS_ERR("new node is not index node: "
+			  "node_id %u, type %#x\n",
+			  new_node->node_id, type);
+		return -ERANGE;
+	}
+
+	switch (child->index_area.move.pos.state) {
+	case SSDFS_HASH_RANGE_INTERSECTION:
+	case SSDFS_HASH_RANGE_OUT_OF_NODE:
+		if (child->index_area.move.pos.count == 0) {
+			SSDFS_ERR("invalid position's count %u\n",
+				  child->index_area.move.pos.count);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid position's state %#x\n",
+			  child->index_area.move.pos.state);
+		return -ERANGE;
+	}
+
+	start = child->index_area.move.pos.start;
+	count = child->index_area.move.pos.count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start %u, count %u, state %#x\n",
+		  child->index_area.move.pos.start,
+		  child->index_area.move.pos.count,
+		  child->index_area.move.pos.state);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	err = ssdfs_btree_node_move_index_range(old_node,
+					child->index_area.move.pos.start,
+					new_node,
+					0,
+					child->index_area.move.pos.count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move index range: "
+			  "src_node %u, dst_node %u, "
+			  "src_start %u, dst_start %u, count %u, "
+			  "err %d\n",
+			  old_node->node_id,
+			  new_node->node_id,
+			  child->index_area.move.pos.start,
+			  0,
+			  child->index_area.move.pos.count,
+			  err);
+		goto fail_move_indexes_right;
+	}
+
+	err = ssdfs_btree_update_index_after_move(child, parent_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update indexes in parent: err %d\n",
+			  err);
+		goto fail_move_indexes_right;
+	}
+
+	err = ssdfs_btree_update_parent_node_pointer(old_node->tree, old_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update parent pointer: "
+			  "node_id %u, err %d\n",
+			  old_node->node_id, err);
+		goto fail_move_indexes_right;
+	}
+
+	err = ssdfs_btree_update_parent_node_pointer(new_node->tree, new_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update parent pointer: "
+			  "node_id %u, err %d\n",
+			  new_node->node_id, err);
+		goto fail_move_indexes_right;
+	}
+
+	child->index_area.move.op_state = SSDFS_BTREE_AREA_OP_DONE;
+	return 0;
+
+fail_move_indexes_right:
+	SSDFS_ERR("old_node %u\n", old_node->node_id);
+	ssdfs_debug_show_btree_node_indexes(old_node->tree, old_node);
+
+	SSDFS_ERR("new_node %u\n", new_node->node_id);
+	ssdfs_debug_show_btree_node_indexes(new_node->tree, new_node);
+
+	SSDFS_ERR("parent_node %u\n", parent_node->node_id);
+	ssdfs_debug_show_btree_node_indexes(parent_node->tree, parent_node);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_move_indexes() - move indexes between parent and child nodes
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to move indexes between parent and child nodes.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_move_indexes(struct ssdfs_btree_state_descriptor *desc,
+			     struct ssdfs_btree_level *parent,
+			     struct ssdfs_btree_level *child)
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
+	if (parent->flags & SSDFS_BTREE_INDEX_AREA_NEED_MOVE) {
+		switch (parent->index_area.move.direction) {
+		case SSDFS_BTREE_MOVE_TO_PARENT:
+			/* do nothing */
+			break;
+
+		case SSDFS_BTREE_MOVE_TO_CHILD:
+			err = ssdfs_btree_move_indexes_to_child(desc,
+								parent,
+								child);
+			if (unlikely(err)) {
+				SSDFS_ERR("failed to move indexes: err %d\n",
+					  err);
+				return err;
+			}
+			break;
+
+		case SSDFS_BTREE_MOVE_TO_RIGHT:
+			/* do nothing */
+			break;
+
+		default:
+			SSDFS_ERR("invalid move direction %#x\n",
+				  parent->index_area.move.direction);
+			return -ERANGE;
+		}
+	}
+
+	if (child->flags & SSDFS_BTREE_INDEX_AREA_NEED_MOVE) {
+		switch (child->index_area.move.direction) {
+		case SSDFS_BTREE_MOVE_TO_PARENT:
+			err = ssdfs_btree_move_indexes_to_parent(desc,
+								 parent,
+								 child);
+			if (unlikely(err)) {
+				SSDFS_ERR("failed to move indexes: err %d\n",
+					  err);
+				return err;
+			}
+			break;
+
+		case SSDFS_BTREE_MOVE_TO_CHILD:
+			op_state = child->index_area.move.op_state;
+			if (op_state != SSDFS_BTREE_AREA_OP_DONE) {
+				SSDFS_ERR("invalid op_state %#x\n",
+					  op_state);
+				return -ERANGE;
+			}
+			break;
+
+		case SSDFS_BTREE_MOVE_TO_RIGHT:
+			err = ssdfs_btree_move_indexes_right(desc,
+							     parent,
+							     child);
+			if (unlikely(err)) {
+				SSDFS_ERR("failed to move indexes: err %d\n",
+					  err);
+				return err;
+			}
+			break;
+
+		default:
+			SSDFS_ERR("invalid move direction %#x\n",
+				  child->index_area.move.direction);
+			return -ERANGE;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_resize_index_area() - resize index area of the node
+ * @desc: btree state descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to resize the index area of the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - unable to resize the index area.
+ */
+static
+int ssdfs_btree_resize_index_area(struct ssdfs_btree_state_descriptor *desc,
+				  struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *node;
+	u32 index_area_size, index_free_area;
+	u32 items_area_size, items_free_area;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !child);
+
+	SSDFS_DBG("desc %p, child %p\n",
+		  desc, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node = child->nodes.old_node.ptr;
+
+	if (!node) {
+		SSDFS_ERR("node is NULL\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!(child->flags & SSDFS_BTREE_TRY_RESIZE_INDEX_AREA)) {
+		SSDFS_WARN("resize hasn't been requested\n");
+		return 0;
+	}
+
+	if (child->index_area.free_space >= desc->node_size) {
+		SSDFS_ERR("invalid index area's free space: "
+			  "free_space %u, node_size %u\n",
+			  child->index_area.free_space,
+			  desc->node_size);
+		return -ERANGE;
+	}
+
+	if (child->items_area.free_space >= desc->node_size) {
+		SSDFS_ERR("invalid items area's free space: "
+			  "free_space %u, node_size %u\n",
+			  child->items_area.free_space,
+			  desc->node_size);
+		return -ERANGE;
+	}
+
+	if (child->index_area.free_space % desc->index_size) {
+		SSDFS_ERR("invalid index area's free space: "
+			  "free_space %u, index_size %u\n",
+			  child->index_area.free_space,
+			  desc->index_size);
+		return -ERANGE;
+	}
+
+	if (desc->index_size >= desc->index_area_min_size) {
+		SSDFS_ERR("corrupted descriptor: "
+			  "index_size %u, index_area_min_size %u\n",
+			  desc->index_size,
+			  desc->index_area_min_size);
+		return -ERANGE;
+	}
+
+	if (desc->index_area_min_size % desc->index_size) {
+		SSDFS_ERR("corrupted descriptor: "
+			  "index_size %u, index_area_min_size %u\n",
+			  desc->index_size,
+			  desc->index_area_min_size);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("INITIAL_STATE: "
+		  "items_area: area_size %u, free_space %u; "
+		  "index_area: area_size %u, free_space %u\n",
+		  child->items_area.area_size,
+		  child->items_area.free_space,
+		  child->index_area.area_size,
+		  child->index_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	index_area_size = child->index_area.area_size << 1;
+	index_free_area = index_area_size - child->index_area.area_size;
+
+	if (index_area_size > desc->node_size) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to resize the index area: "
+			  "requested_size %u, node_size %u\n",
+			  index_free_area, desc->node_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	} else if (index_area_size == desc->node_size) {
+		index_area_size = desc->node_size;
+		index_free_area = child->index_area.free_space;
+		index_free_area += child->items_area.free_space;
+
+		items_area_size = 0;
+		items_free_area = 0;
+	} else if (child->items_area.free_space < index_free_area) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to resize the index area: "
+			  "free_space %u, requested_size %u\n",
+			  child->items_area.free_space,
+			  index_free_area);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	} else {
+		items_area_size = child->items_area.area_size;
+		items_area_size -= index_free_area;
+		items_free_area = child->items_area.free_space;
+		items_free_area -= index_free_area;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("NEW_STATE: "
+		  "items_area: area_size %u, free_space %u; "
+		  "index_area: area_size %u, free_space %u\n",
+		  items_area_size, items_free_area,
+		  index_area_size, index_free_area);
+
+	BUG_ON(index_area_size == 0);
+	BUG_ON(index_area_size > desc->node_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_btree_node_resize_index_area(node, index_area_size);
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to resize the index area: "
+			  "node_id %u, new_size %u\n",
+			  node->node_id, index_area_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to resize the index area: "
+			  "node_id %u, new_size %u\n",
+			  node->node_id, index_area_size);
+	} else {
+		child->index_area.area_size = index_area_size;
+		child->index_area.free_space = index_free_area;
+		child->items_area.area_size = items_area_size;
+		child->items_area.free_space = items_free_area;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_prepare_add_item() - prepare to add an item into the node
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to prepare the node for adding an item.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_prepare_add_item(struct ssdfs_btree_level *parent,
+				 struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node_insert *add;
+	struct ssdfs_btree_node *node = NULL;
+	struct ssdfs_btree_node *left_node = NULL, *right_node = NULL;
+	u64 start_hash, end_hash;
+	u16 count;
+	u8 min_item_size;
+	u32 free_space;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!parent || !child);
+
+	SSDFS_DBG("parent %p, child %p\n",
+		  parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!(child->flags & SSDFS_BTREE_LEVEL_ADD_ITEM)) {
+		SSDFS_WARN("add item hasn't been requested\n");
+		return 0;
+	}
+
+	add = &child->items_area.add;
+
+	if (add->op_state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  add->op_state);
+		return -ERANGE;
+	} else
+		add->op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	switch (add->pos.state) {
+	case SSDFS_HASH_RANGE_OUT_OF_NODE:
+		node = child->nodes.old_node.ptr;
+
+		if (!node) {
+			SSDFS_ERR("node %p\n", node);
+			return -ERANGE;
+		}
+
+		start_hash = child->items_area.add.hash.start;
+		end_hash = child->items_area.add.hash.end;
+		count = child->items_area.add.pos.count;
+
+		down_write(&node->header_lock);
+
+		if (node->items_area.items_count == 0) {
+			node->items_area.start_hash = start_hash;
+			node->items_area.end_hash = end_hash;
+		}
+
+		free_space = node->items_area.free_space;
+		min_item_size = node->items_area.min_item_size;
+
+		if (((u32)count * min_item_size) > free_space) {
+			err = -ERANGE;
+			SSDFS_ERR("free_space %u is too small\n",
+				  free_space);
+		}
+
+		up_write(&node->header_lock);
+		break;
+
+	case SSDFS_HASH_RANGE_LEFT_ADJACENT:
+		left_node = child->nodes.new_node.ptr;
+		right_node = child->nodes.old_node.ptr;
+
+		if (!left_node || !right_node) {
+			SSDFS_ERR("left_node %p, right_node %p\n",
+				  left_node, right_node);
+			return -ERANGE;
+		}
+
+		start_hash = child->items_area.add.hash.start;
+		end_hash = child->items_area.add.hash.end;
+		count = child->items_area.add.pos.count;
+
+		down_write(&left_node->header_lock);
+
+		if (left_node->items_area.items_count == 0) {
+			left_node->items_area.start_hash = start_hash;
+			left_node->items_area.end_hash = end_hash;
+		}
+
+		free_space = left_node->items_area.free_space;
+		min_item_size = left_node->items_area.min_item_size;
+
+		if (((u32)count * min_item_size) > free_space) {
+			err = -ERANGE;
+			SSDFS_ERR("free_space %u is too small\n",
+				  free_space);
+			goto finish_left_adjacent_check;
+		}
+
+finish_left_adjacent_check:
+		up_write(&left_node->header_lock);
+		break;
+
+	case SSDFS_HASH_RANGE_INTERSECTION:
+		left_node = child->nodes.old_node.ptr;
+		right_node = child->nodes.new_node.ptr;
+
+		if (!left_node) {
+			SSDFS_ERR("left_node %p, right_node %p\n",
+				  left_node, right_node);
+			return -ERANGE;
+		}
+
+		count = child->items_area.add.pos.count;
+
+		down_write(&left_node->header_lock);
+
+		free_space = left_node->items_area.free_space;
+		min_item_size = left_node->items_area.min_item_size;
+
+		if (((u32)count * min_item_size) > free_space) {
+			err = -ERANGE;
+			SSDFS_ERR("free_space %u is too small\n",
+				  free_space);
+			goto finish_intersection_check;
+		}
+
+finish_intersection_check:
+		up_write(&left_node->header_lock);
+		break;
+
+	case SSDFS_HASH_RANGE_RIGHT_ADJACENT:
+		left_node = child->nodes.old_node.ptr;
+		right_node = child->nodes.new_node.ptr;
+
+		if (!left_node || !right_node) {
+			SSDFS_ERR("left_node %p, right_node %p\n",
+				  left_node, right_node);
+			return -ERANGE;
+		}
+
+		start_hash = child->items_area.add.hash.start;
+		end_hash = child->items_area.add.hash.end;
+		count = child->items_area.add.pos.count;
+
+		down_write(&right_node->header_lock);
+
+		if (right_node->items_area.items_count == 0) {
+			right_node->items_area.start_hash = start_hash;
+			right_node->items_area.end_hash = end_hash;
+		}
+
+		free_space = right_node->items_area.free_space;
+		min_item_size = right_node->items_area.min_item_size;
+
+		if (((u32)count * min_item_size) > free_space) {
+			err = -ERANGE;
+			SSDFS_ERR("free_space %u is too small\n",
+				  free_space);
+			goto finish_right_adjacent_check;
+		}
+
+finish_right_adjacent_check:
+		up_write(&right_node->header_lock);
+		break;
+
+	default:
+		SSDFS_ERR("invalid position's state %#x\n",
+			  add->pos.state);
+		return -ERANGE;
+	}
+
+	if (!err)
+		add->op_state = SSDFS_BTREE_AREA_OP_DONE;
+
+	return err;
+}
+
+/*
+ * __ssdfs_btree_update_index() - update index in the parent node
+ * @parent_node: parent node
+ * @child_node: child node
+ *
+ * This method tries to update an index into the parent node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_btree_update_index(struct ssdfs_btree_node *parent_node,
+				struct ssdfs_btree_node *child_node)
+{
+	struct ssdfs_btree_index_key old_key, new_key;
+	int parent_type, child_type;
+	u64 start_hash = U64_MAX;
+	u64 old_hash = U64_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!parent_node || !child_node);
+
+	SSDFS_DBG("parent_node %p, child_node %p\n",
+		  parent_node, child_node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	parent_type = atomic_read(&parent_node->type);
+	child_type = atomic_read(&child_node->type);
+
+	switch (parent_type) {
+	case SSDFS_BTREE_ROOT_NODE:
+		switch (child_type) {
+		case SSDFS_BTREE_LEAF_NODE:
+			down_read(&child_node->header_lock);
+			start_hash = child_node->items_area.start_hash;
+			up_read(&child_node->header_lock);
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+		case SSDFS_BTREE_INDEX_NODE:
+			down_read(&child_node->header_lock);
+			start_hash = child_node->index_area.start_hash;
+			up_read(&child_node->header_lock);
+			break;
+
+		default:
+			SSDFS_ERR("unexpected child type %#x\n",
+				  child_type);
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		switch (child_type) {
+		case SSDFS_BTREE_LEAF_NODE:
+			down_read(&child_node->header_lock);
+			start_hash = child_node->items_area.start_hash;
+			up_read(&child_node->header_lock);
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			if (parent_node == child_node) {
+				down_read(&child_node->header_lock);
+				start_hash = child_node->items_area.start_hash;
+				up_read(&child_node->header_lock);
+			} else {
+				down_read(&child_node->header_lock);
+				start_hash = child_node->index_area.start_hash;
+				up_read(&child_node->header_lock);
+			}
+			break;
+
+		case SSDFS_BTREE_INDEX_NODE:
+			down_read(&child_node->header_lock);
+			start_hash = child_node->index_area.start_hash;
+			up_read(&child_node->header_lock);
+			break;
+
+		default:
+			SSDFS_ERR("unexpected child type %#x\n",
+				  child_type);
+			return -ERANGE;
+		}
+
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		switch (child_type) {
+		case SSDFS_BTREE_LEAF_NODE:
+			down_read(&child_node->header_lock);
+			start_hash = child_node->items_area.start_hash;
+			up_read(&child_node->header_lock);
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+		case SSDFS_BTREE_INDEX_NODE:
+			down_read(&child_node->header_lock);
+			start_hash = child_node->index_area.start_hash;
+			up_read(&child_node->header_lock);
+			break;
+
+		default:
+			SSDFS_ERR("unexpected child type %#x\n",
+				  child_type);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("unexpected parent type %#x\n",
+			  parent_type);
+		return -ERANGE;
+	}
+
+	if (parent_type == SSDFS_BTREE_HYBRID_NODE &&
+	    child_type == SSDFS_BTREE_HYBRID_NODE &&
+	    parent_node == child_node) {
+		down_read(&parent_node->header_lock);
+		old_hash = parent_node->items_area.start_hash;
+		up_read(&parent_node->header_lock);
+	}
+
+	spin_lock(&child_node->descriptor_lock);
+
+	ssdfs_memcpy(&old_key,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     &child_node->node_index,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     sizeof(struct ssdfs_btree_index_key));
+
+	if (parent_type == SSDFS_BTREE_HYBRID_NODE &&
+	    child_type == SSDFS_BTREE_HYBRID_NODE &&
+	    parent_node == child_node) {
+		if (old_hash == U64_MAX) {
+			err = -ERANGE;
+			SSDFS_WARN("invalid old hash\n");
+			goto finish_update_index;
+		}
+
+		old_key.index.hash = cpu_to_le64(old_hash);
+	}
+
+	ssdfs_memcpy(&child_node->node_index.index.extent,
+		     0, sizeof(struct ssdfs_raw_extent),
+		     &child_node->extent,
+		     0, sizeof(struct ssdfs_raw_extent),
+		     sizeof(struct ssdfs_raw_extent));
+	ssdfs_memcpy(&new_key,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     &child_node->node_index,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     sizeof(struct ssdfs_btree_index_key));
+	new_key.index.hash = cpu_to_le64(start_hash);
+	ssdfs_memcpy(&child_node->node_index,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     &new_key,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     sizeof(struct ssdfs_btree_index_key));
+
+finish_update_index:
+	spin_unlock(&child_node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, node_type %#x, "
+		  "node_height %u, hash %llx\n",
+		  le32_to_cpu(new_key.node_id),
+		  new_key.node_type,
+		  new_key.height,
+		  le64_to_cpu(new_key.index.hash));
+	SSDFS_DBG("seg_id %llu, logical_blk %u, len %u\n",
+		  le64_to_cpu(new_key.index.extent.seg_id),
+		  le32_to_cpu(new_key.index.extent.logical_blk),
+		  le32_to_cpu(new_key.index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err))
+		return err;
+
+	err = ssdfs_btree_node_change_index(parent_node,
+					    &old_key, &new_key);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update index: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_update_index() - update the index in the parent node
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to update the index into the parent node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_update_index(struct ssdfs_btree_state_descriptor *desc,
+			     struct ssdfs_btree_level *parent,
+			     struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node = NULL, *child_node = NULL;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !parent || !child);
+
+	SSDFS_DBG("desc %p, parent %p, child %p\n",
+		  desc, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!(parent->flags & SSDFS_BTREE_LEVEL_UPDATE_INDEX)) {
+		SSDFS_WARN("update index hasn't been requested\n");
+		return 0;
+	}
+
+	if (parent->flags & SSDFS_BTREE_LEVEL_ADD_NODE)
+		parent_node = parent->nodes.new_node.ptr;
+	else if (parent->nodes.old_node.ptr)
+		parent_node = parent->nodes.old_node.ptr;
+	else
+		parent_node = parent->nodes.new_node.ptr;
+
+	if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE)
+		child_node = child->nodes.new_node.ptr;
+	else
+		child_node = child->nodes.old_node.ptr;
+
+	if (!parent_node || !child_node) {
+		SSDFS_ERR("invalid pointer: "
+			  "parent_node %p, child_node %p\n",
+			  parent_node, child_node);
+		return -ERANGE;
+	}
+
+	err = __ssdfs_btree_update_index(parent_node, child_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update index: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_btree_add_index() - add index in the parent node
+ * @parent_node: parent node
+ * @child_node: child node
+ *
+ * This method tries to add an index into the parent node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_btree_add_index(struct ssdfs_btree_node *parent_node,
+			    struct ssdfs_btree_node *child_node)
+{
+	struct ssdfs_btree_index_key key;
+	int type;
+	u64 start_hash = U64_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!parent_node || !child_node);
+
+	SSDFS_DBG("parent_node %p, child_node %p\n",
+		  parent_node, child_node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	type = atomic_read(&child_node->type);
+
+	switch (type) {
+	case SSDFS_BTREE_LEAF_NODE:
+		down_read(&child_node->header_lock);
+		start_hash = child_node->items_area.start_hash;
+		up_read(&child_node->header_lock);
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		down_read(&child_node->header_lock);
+		start_hash = child_node->index_area.start_hash;
+		up_read(&child_node->header_lock);
+		break;
+	}
+
+	spin_lock(&child_node->descriptor_lock);
+	if (start_hash != U64_MAX) {
+		child_node->node_index.index.hash =
+				    cpu_to_le64(start_hash);
+	}
+	ssdfs_memcpy(&child_node->node_index.index.extent,
+		     0, sizeof(struct ssdfs_raw_extent),
+		     &child_node->extent,
+		     0, sizeof(struct ssdfs_raw_extent),
+		     sizeof(struct ssdfs_raw_extent));
+	ssdfs_memcpy(&key,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     &child_node->node_index,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     sizeof(struct ssdfs_btree_index_key));
+	spin_unlock(&child_node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, node_type %#x, "
+		  "node_height %u, hash %llx\n",
+		  le32_to_cpu(key.node_id),
+		  key.node_type,
+		  key.height,
+		  le64_to_cpu(key.index.hash));
+	SSDFS_DBG("seg_id %llu, logical_blk %u, len %u\n",
+		  le64_to_cpu(key.index.extent.seg_id),
+		  le32_to_cpu(key.index.extent.logical_blk),
+		  le32_to_cpu(key.index.extent.len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_btree_node_add_index(parent_node, &key);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add index: err %d\n", err);
+		return err;
+	}
+
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_add_index() - add an index into parent node
+ * @desc: btree state descriptor
+ * @parent: parent level descriptor
+ * @child: child level descriptor
+ *
+ * This method tries to add an index into parent node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_add_index(struct ssdfs_btree_state_descriptor *desc,
+			  struct ssdfs_btree_level *parent,
+			  struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node = NULL, *child_node = NULL;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !parent || !child);
+
+	SSDFS_DBG("desc %p, parent %p, child %p\n",
+		  desc, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!(parent->flags & SSDFS_BTREE_LEVEL_ADD_INDEX)) {
+		SSDFS_WARN("add index hasn't been requested\n");
+		return -ERANGE;
+	}
+
+	if (parent->flags & SSDFS_BTREE_LEVEL_ADD_NODE)
+		parent_node = parent->nodes.new_node.ptr;
+	else if (parent->nodes.old_node.ptr)
+		parent_node = parent->nodes.old_node.ptr;
+	else
+		parent_node = parent->nodes.new_node.ptr;
+
+	child_node = child->nodes.new_node.ptr;
+
+	if (!parent_node || !child_node) {
+		SSDFS_ERR("invalid pointer: "
+			  "parent_node %p, child_node %p\n",
+			  parent_node, child_node);
+		return -ERANGE;
+	}
+
+	err = __ssdfs_btree_add_index(parent_node, child_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add index: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_update_index_after_move() - update sibling nodes' indexes
+ * @child: child level descriptor
+ * @parent_node: parent node
+ *
+ * This method tries to update the sibling nodes' indexes
+ * after operation of moving items/indexes.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_update_index_after_move(struct ssdfs_btree_level *child,
+					struct ssdfs_btree_node *parent_node)
+{
+	struct ssdfs_btree_node *child_node = NULL;
+	int parent_type, child_type;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!child || !parent_node);
+
+	SSDFS_DBG("child %p, parent_node %p\n",
+		  child, parent_node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (child->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE ||
+	    child->flags & SSDFS_BTREE_INDEX_AREA_NEED_MOVE) {
+		struct ssdfs_btree_node_move *move;
+
+		if (child->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE)
+			move = &child->items_area.move;
+		else if (child->flags & SSDFS_BTREE_INDEX_AREA_NEED_MOVE)
+			move = &child->index_area.move;
+		else
+			BUG();
+
+		switch (move->direction) {
+		case SSDFS_BTREE_MOVE_TO_LEFT:
+		case SSDFS_BTREE_MOVE_TO_RIGHT:
+			/* expected state */
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("nothing should be done: "
+				  "direction %#x\n",
+				  move->direction);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return 0;
+		}
+
+		child_node = child->nodes.old_node.ptr;
+		if (!child_node) {
+			SSDFS_ERR("invalid child pointer\n");
+			return -ERANGE;
+		}
+
+		parent_type = atomic_read(&parent_node->type);
+		child_type = atomic_read(&child_node->type);
+
+		if (parent_type == SSDFS_BTREE_HYBRID_NODE &&
+		    child_type == SSDFS_BTREE_HYBRID_NODE &&
+		    parent_node == child_node) {
+			/*
+			 * The hybrid node has been updated already.
+			 */
+		} else {
+			err = __ssdfs_btree_update_index(parent_node,
+							 child_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to update index: err %d\n",
+					  err);
+				return err;
+			}
+		}
+
+		child_node = child->nodes.new_node.ptr;
+		if (!child_node) {
+			SSDFS_ERR("invalid child pointer\n");
+			return -ERANGE;
+		}
+
+		parent_type = atomic_read(&parent_node->type);
+		child_type = atomic_read(&child_node->type);
+
+		if (parent_type == SSDFS_BTREE_HYBRID_NODE &&
+		    child_type == SSDFS_BTREE_HYBRID_NODE &&
+		    parent_node == child_node) {
+			/*
+			 * The hybrid node has been updated already.
+			 */
+		} else {
+			if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE) {
+				/*
+				 * Do nothing. Index will be added later.
+				 */
+				SSDFS_DBG("nothing should be done: "
+					  "index will be added later\n");
+
+				/*err = __ssdfs_btree_add_index(parent_node,
+							      child_node);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to add index: "
+						  "err %d\n",
+						  err);
+					return err;
+				}*/
+			} else {
+				err = __ssdfs_btree_update_index(parent_node,
+								 child_node);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to update index: "
+						  "err %d\n",
+						  err);
+					return err;
+				}
+			}
+		}
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing should be done: "
+			  "flags %#x\n", child->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_process_level_for_add() - process a level of btree's hierarchy
+ * @hierarchy: btree's hierarchy
+ * @cur_height: current height
+ * @search: search object
+ *
+ * This method tries to process the level of btree's hierarchy.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - unable to resize the index area.
+ */
+int ssdfs_btree_process_level_for_add(struct ssdfs_btree_hierarchy *hierarchy,
+					int cur_height,
+					struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_state_descriptor *desc;
+	struct ssdfs_btree_level *cur_level;
+	struct ssdfs_btree_level *parent;
+	struct ssdfs_btree_node *node;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hierarchy || !search);
+
+	SSDFS_DBG("hierarchy %p, cur_height %d\n",
+		  hierarchy, cur_height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (cur_height >= hierarchy->desc.height) {
+		SSDFS_ERR("invalid hierarchy: "
+			  "cur_height %d, tree_height %d\n",
+			  cur_height, hierarchy->desc.height);
+		return -ERANGE;
+	}
+
+	desc = &hierarchy->desc;
+	cur_level = hierarchy->array_ptr[cur_height];
+
+	if (!cur_level->flags) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing to do: cur_height %d\n",
+			  cur_height);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	if (cur_height == (hierarchy->desc.height - 1))
+		goto check_necessity_increase_tree_height;
+
+	parent = hierarchy->array_ptr[cur_height + 1];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_height %d, tree_height %d, "
+		  "cur_level->flags %#x, parent->flags %#x\n",
+		  cur_height, hierarchy->desc.height,
+		  cur_level->flags, parent->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (cur_level->flags & ~SSDFS_BTREE_ADD_NODE_MASK ||
+	    parent->flags & ~SSDFS_BTREE_ADD_NODE_MASK) {
+		SSDFS_ERR("invalid flags: cur_level %#x, parent %#x\n",
+			  cur_level->flags,
+			  parent->flags);
+		return -ERANGE;
+	}
+
+	if (cur_level->flags & SSDFS_BTREE_LEVEL_ADD_NODE) {
+		if (!cur_level->nodes.new_node.ptr) {
+			SSDFS_ERR("new node hasn't been created\n");
+			return -ERANGE;
+		}
+	}
+
+	if (parent->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE) {
+		err = ssdfs_btree_move_items(desc, parent, cur_level);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move items: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	if (cur_level->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE) {
+		err = ssdfs_btree_move_items(desc, parent, cur_level);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move items: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	if (parent->flags & SSDFS_BTREE_TRY_RESIZE_INDEX_AREA) {
+		err = ssdfs_btree_resize_index_area(desc, parent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to resize index area: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	if (parent->flags & SSDFS_BTREE_INDEX_AREA_NEED_MOVE) {
+		err = ssdfs_btree_move_indexes(desc, parent, cur_level);
+		if (err == -ENOSPC) {
+			err = ssdfs_btree_resize_index_area(desc, cur_level);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to resize index area: err %d\n",
+					  err);
+				return err;
+			}
+
+			err = ssdfs_btree_move_indexes(desc, parent, cur_level);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move indexes: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	if (cur_level->flags & SSDFS_BTREE_INDEX_AREA_NEED_MOVE) {
+		err = ssdfs_btree_move_indexes(desc, parent, cur_level);
+		if (err == -ENOSPC) {
+			err = ssdfs_btree_resize_index_area(desc, cur_level);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to resize index area: err %d\n",
+					  err);
+				return err;
+			}
+
+			err = ssdfs_btree_move_indexes(desc, parent, cur_level);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move indexes: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	if (cur_level->flags & SSDFS_BTREE_LEVEL_ADD_ITEM) {
+		err = ssdfs_btree_prepare_add_item(parent, cur_level);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare node for add: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	if (parent->flags & SSDFS_BTREE_LEVEL_UPDATE_INDEX) {
+		err = ssdfs_btree_update_index(desc, parent, cur_level);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update the index: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	if (parent->flags & SSDFS_BTREE_LEVEL_ADD_INDEX) {
+		err = ssdfs_btree_add_index(desc, parent, cur_level);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add the index: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	if (cur_height == (hierarchy->desc.height - 1)) {
+check_necessity_increase_tree_height:
+		if (cur_level->nodes.old_node.ptr)
+			node = cur_level->nodes.old_node.ptr;
+		else if (cur_level->nodes.new_node.ptr)
+			node = cur_level->nodes.new_node.ptr;
+		else
+			goto finish_process_level_for_add;
+
+		switch (atomic_read(&node->type)) {
+		case SSDFS_BTREE_ROOT_NODE:
+			if (hierarchy->desc.increment_height)
+				atomic_inc(&node->height);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node_id %u, node height %u, "
+				  "cur_height %u, increment_height %#x\n",
+				  node->node_id, atomic_read(&node->height),
+				  cur_height, hierarchy->desc.increment_height);
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+	}
+
+finish_process_level_for_add:
+	return 0;
+}
+
+/*
+ * ssdfs_btree_delete_index() - delete index from the node
+ * @desc: btree state descriptor
+ * @level: level descriptor
+ *
+ * This method tries to delete an index from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_delete_index(struct ssdfs_btree_state_descriptor *desc,
+			     struct ssdfs_btree_level *level)
+{
+	struct ssdfs_btree_node *node;
+	struct ssdfs_btree_node_delete *delete;
+	u64 hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc || !level);
+
+	SSDFS_DBG("desc %p, level %p\n",
+		  desc, level);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!(level->flags & SSDFS_BTREE_LEVEL_DELETE_INDEX)) {
+		SSDFS_WARN("delete index hasn't been requested\n");
+		return 0;
+	}
+
+	node = level->nodes.old_node.ptr;
+	if (!node) {
+		SSDFS_ERR("invalid pointer: node %p\n",
+			  node);
+		return -ERANGE;
+	}
+
+	delete = &level->index_area.delete;
+
+	if (delete->op_state != SSDFS_BTREE_AREA_OP_REQUESTED) {
+		SSDFS_ERR("invalid operation state %#x\n",
+			  delete->op_state);
+		return -ERANGE;
+	} else
+		delete->op_state = SSDFS_BTREE_AREA_OP_FAILED;
+
+	hash = cpu_to_le64(delete->node_index.index.hash);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree type %#x, node_id %u, hash %llx\n",
+		  node->tree->type, node->node_id, hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_btree_node_delete_index(node, hash);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete index: "
+			  "hash %llx, err %d\n",
+			  hash, err);
+		return err;
+	}
+
+	delete->op_state = SSDFS_BTREE_AREA_OP_DONE;
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_process_level_for_delete() - process a level of btree's hierarchy
+ * @hierarchy: btree's hierarchy
+ * @cur_height: current height
+ * @search: search object
+ *
+ * This method tries to process the level of btree's hierarchy.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_process_level_for_delete(struct ssdfs_btree_hierarchy *ptr,
+					 int cur_height,
+					 struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_state_descriptor *desc;
+	struct ssdfs_btree_level *cur_level;
+	struct ssdfs_btree_level *parent;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !search);
+
+	SSDFS_DBG("hierarchy %p, cur_height %d\n",
+		  ptr, cur_height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (cur_height >= ptr->desc.height) {
+		SSDFS_ERR("invalid hierarchy: "
+			  "cur_height %d, tree_height %d\n",
+			  cur_height, ptr->desc.height);
+		return -ERANGE;
+	}
+
+	desc = &ptr->desc;
+	cur_level = ptr->array_ptr[cur_height];
+	parent = ptr->array_ptr[cur_height + 1];
+
+	if (!cur_level->flags) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing to do: cur_height %d\n",
+			  cur_height);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	if (cur_level->flags & ~SSDFS_BTREE_DELETE_NODE_MASK) {
+		SSDFS_ERR("invalid flags %#x\n",
+			  cur_level->flags);
+		return -ERANGE;
+	}
+
+	if (cur_level->flags & SSDFS_BTREE_LEVEL_DELETE_INDEX) {
+		err = ssdfs_btree_delete_index(desc, cur_level);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete the index: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	if (parent->flags & SSDFS_BTREE_LEVEL_UPDATE_INDEX) {
+		err = ssdfs_btree_update_index(desc, parent, cur_level);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update the index: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_process_level_for_update() - process a level of btree's hierarchy
+ * @hierarchy: btree's hierarchy
+ * @cur_height: current height
+ * @search: search object
+ *
+ * This method tries to process the level of btree's hierarchy.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_process_level_for_update(struct ssdfs_btree_hierarchy *ptr,
+					 int cur_height,
+					 struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_state_descriptor *desc;
+	struct ssdfs_btree_level *cur_level;
+	struct ssdfs_btree_level *parent;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !search);
+
+	SSDFS_DBG("hierarchy %p, cur_height %d\n",
+		  ptr, cur_height);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_debug_btree_hierarchy_object(ptr);
+
+	if (cur_height >= ptr->desc.height) {
+		SSDFS_ERR("invalid hierarchy: "
+			  "cur_height %d, tree_height %d\n",
+			  cur_height, ptr->desc.height);
+		return -ERANGE;
+	}
+
+	desc = &ptr->desc;
+	cur_level = ptr->array_ptr[cur_height];
+	parent = ptr->array_ptr[cur_height + 1];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("parent->flags %#x\n", parent->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!parent->flags) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing to do: cur_height %d\n",
+			  cur_height);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	if (parent->flags & ~SSDFS_BTREE_LEVEL_FLAGS_MASK) {
+		SSDFS_ERR("invalid flags %#x\n",
+			  cur_level->flags);
+		return -ERANGE;
+	}
+
+	if (parent->flags & SSDFS_BTREE_LEVEL_UPDATE_INDEX) {
+		err = ssdfs_btree_update_index(desc, parent, cur_level);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update the index: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+void ssdfs_show_btree_hierarchy_object(struct ssdfs_btree_hierarchy *ptr)
+{
+	struct ssdfs_btree_index_key *index_key;
+	int i;
+
+	BUG_ON(!ptr);
+
+	SSDFS_ERR("DESCRIPTOR: "
+		  "height %d, increment_height %d, "
+		  "node_size %u, index_size %u, "
+		  "min_item_size %u, max_item_size %u, "
+		  "index_area_min_size %u\n",
+		  ptr->desc.height, ptr->desc.increment_height,
+		  ptr->desc.node_size, ptr->desc.index_size,
+		  ptr->desc.min_item_size,
+		  ptr->desc.max_item_size,
+		  ptr->desc.index_area_min_size);
+
+	for (i = 0; i < ptr->desc.height; i++) {
+		struct ssdfs_btree_level *level = ptr->array_ptr[i];
+
+		SSDFS_ERR("LEVEL: height %d, flags %#x, "
+			  "OLD_NODE: type %#x, ptr %p, "
+			  "index_area (start %llx, end %llx), "
+			  "items_area (start %llx, end %llx), "
+			  "NEW_NODE: type %#x, ptr %p, "
+			  "index_area (start %llx, end %llx), "
+			  "items_area (start %llx, end %llx)\n",
+			  i, level->flags,
+			  level->nodes.old_node.type,
+			  level->nodes.old_node.ptr,
+			  level->nodes.old_node.index_hash.start,
+			  level->nodes.old_node.index_hash.end,
+			  level->nodes.old_node.items_hash.start,
+			  level->nodes.old_node.items_hash.end,
+			  level->nodes.new_node.type,
+			  level->nodes.new_node.ptr,
+			  level->nodes.new_node.index_hash.start,
+			  level->nodes.new_node.index_hash.end,
+			  level->nodes.new_node.items_hash.start,
+			  level->nodes.new_node.items_hash.end);
+
+		SSDFS_ERR("INDEX_AREA: area_size %u, free_space %u, "
+			  "start_hash %llx, end_hash %llx\n",
+			  level->index_area.area_size,
+			  level->index_area.free_space,
+			  level->index_area.hash.start,
+			  level->index_area.hash.end);
+
+		SSDFS_ERR("ADD: op_state %#x, start_hash %llx, "
+			  "end_hash %llx, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->index_area.add.op_state,
+			  level->index_area.add.hash.start,
+			  level->index_area.add.hash.end,
+			  level->index_area.add.pos.state,
+			  level->index_area.add.pos.start,
+			  level->index_area.add.pos.count);
+
+		SSDFS_ERR("INSERT: op_state %#x, start_hash %llx, "
+			  "end_hash %llx, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->index_area.insert.op_state,
+			  level->index_area.insert.hash.start,
+			  level->index_area.insert.hash.end,
+			  level->index_area.insert.pos.state,
+			  level->index_area.insert.pos.start,
+			  level->index_area.insert.pos.count);
+
+		SSDFS_ERR("MOVE: op_state %#x, direction %#x, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->index_area.move.op_state,
+			  level->index_area.move.direction,
+			  level->index_area.move.pos.state,
+			  level->index_area.move.pos.start,
+			  level->index_area.move.pos.count);
+
+		index_key = &level->index_area.delete.node_index;
+		SSDFS_ERR("DELETE: op_state %#x, "
+			  "INDEX_KEY: node_id %u, node_type %#x, "
+			  "height %u, flags %#x, hash %llx, "
+			  "seg_id %llu, logical_blk %u, len %u\n",
+			  level->index_area.delete.op_state,
+			  le32_to_cpu(index_key->node_id),
+			  index_key->node_type,
+			  index_key->height,
+			  le16_to_cpu(index_key->flags),
+			  le64_to_cpu(index_key->index.hash),
+			  le64_to_cpu(index_key->index.extent.seg_id),
+			  le32_to_cpu(index_key->index.extent.logical_blk),
+			  le32_to_cpu(index_key->index.extent.len));
+
+		SSDFS_ERR("ITEMS_AREA: area_size %u, free_space %u, "
+			  "start_hash %llx, end_hash %llx\n",
+			  level->items_area.area_size,
+			  level->items_area.free_space,
+			  level->items_area.hash.start,
+			  level->items_area.hash.end);
+
+		SSDFS_ERR("ADD: op_state %#x, start_hash %llx, "
+			  "end_hash %llx, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->items_area.add.op_state,
+			  level->items_area.add.hash.start,
+			  level->items_area.add.hash.end,
+			  level->items_area.add.pos.state,
+			  level->items_area.add.pos.start,
+			  level->items_area.add.pos.count);
+
+		SSDFS_ERR("INSERT: op_state %#x, start_hash %llx, "
+			  "end_hash %llx, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->items_area.insert.op_state,
+			  level->items_area.insert.hash.start,
+			  level->items_area.insert.hash.end,
+			  level->items_area.insert.pos.state,
+			  level->items_area.insert.pos.start,
+			  level->items_area.insert.pos.count);
+
+		SSDFS_ERR("MOVE: op_state %#x, direction %#x, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->items_area.move.op_state,
+			  level->items_area.move.direction,
+			  level->items_area.move.pos.state,
+			  level->items_area.move.pos.start,
+			  level->items_area.move.pos.count);
+	}
+}
+
+void ssdfs_debug_btree_hierarchy_object(struct ssdfs_btree_hierarchy *ptr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct ssdfs_btree_index_key *index_key;
+	int i;
+
+	BUG_ON(!ptr);
+
+	SSDFS_DBG("DESCRIPTOR: "
+		  "height %d, increment_height %d, "
+		  "node_size %u, index_size %u, "
+		  "min_item_size %u, max_item_size %u, "
+		  "index_area_min_size %u\n",
+		  ptr->desc.height, ptr->desc.increment_height,
+		  ptr->desc.node_size, ptr->desc.index_size,
+		  ptr->desc.min_item_size,
+		  ptr->desc.max_item_size,
+		  ptr->desc.index_area_min_size);
+
+	for (i = 0; i < ptr->desc.height; i++) {
+		struct ssdfs_btree_level *level = ptr->array_ptr[i];
+
+		SSDFS_DBG("LEVEL: height %d, flags %#x, "
+			  "OLD_NODE: type %#x, ptr %p, "
+			  "index_area (start %llx, end %llx), "
+			  "items_area (start %llx, end %llx), "
+			  "NEW_NODE: type %#x, ptr %p, "
+			  "index_area (start %llx, end %llx), "
+			  "items_area (start %llx, end %llx)\n",
+			  i, level->flags,
+			  level->nodes.old_node.type,
+			  level->nodes.old_node.ptr,
+			  level->nodes.old_node.index_hash.start,
+			  level->nodes.old_node.index_hash.end,
+			  level->nodes.old_node.items_hash.start,
+			  level->nodes.old_node.items_hash.end,
+			  level->nodes.new_node.type,
+			  level->nodes.new_node.ptr,
+			  level->nodes.new_node.index_hash.start,
+			  level->nodes.new_node.index_hash.end,
+			  level->nodes.new_node.items_hash.start,
+			  level->nodes.new_node.items_hash.end);
+
+		SSDFS_DBG("INDEX_AREA: area_size %u, free_space %u, "
+			  "start_hash %llx, end_hash %llx\n",
+			  level->index_area.area_size,
+			  level->index_area.free_space,
+			  level->index_area.hash.start,
+			  level->index_area.hash.end);
+
+		SSDFS_DBG("ADD: op_state %#x, start_hash %llx, "
+			  "end_hash %llx, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->index_area.add.op_state,
+			  level->index_area.add.hash.start,
+			  level->index_area.add.hash.end,
+			  level->index_area.add.pos.state,
+			  level->index_area.add.pos.start,
+			  level->index_area.add.pos.count);
+
+		SSDFS_DBG("INSERT: op_state %#x, start_hash %llx, "
+			  "end_hash %llx, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->index_area.insert.op_state,
+			  level->index_area.insert.hash.start,
+			  level->index_area.insert.hash.end,
+			  level->index_area.insert.pos.state,
+			  level->index_area.insert.pos.start,
+			  level->index_area.insert.pos.count);
+
+		SSDFS_DBG("MOVE: op_state %#x, direction %#x, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->index_area.move.op_state,
+			  level->index_area.move.direction,
+			  level->index_area.move.pos.state,
+			  level->index_area.move.pos.start,
+			  level->index_area.move.pos.count);
+
+		index_key = &level->index_area.delete.node_index;
+		SSDFS_DBG("DELETE: op_state %#x, "
+			  "INDEX_KEY: node_id %u, node_type %#x, "
+			  "height %u, flags %#x, hash %llx, "
+			  "seg_id %llu, logical_blk %u, len %u\n",
+			  level->index_area.delete.op_state,
+			  le32_to_cpu(index_key->node_id),
+			  index_key->node_type,
+			  index_key->height,
+			  le16_to_cpu(index_key->flags),
+			  le64_to_cpu(index_key->index.hash),
+			  le64_to_cpu(index_key->index.extent.seg_id),
+			  le32_to_cpu(index_key->index.extent.logical_blk),
+			  le32_to_cpu(index_key->index.extent.len));
+
+		SSDFS_DBG("ITEMS_AREA: area_size %u, free_space %u, "
+			  "start_hash %llx, end_hash %llx\n",
+			  level->items_area.area_size,
+			  level->items_area.free_space,
+			  level->items_area.hash.start,
+			  level->items_area.hash.end);
+
+		SSDFS_DBG("ADD: op_state %#x, start_hash %llx, "
+			  "end_hash %llx, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->items_area.add.op_state,
+			  level->items_area.add.hash.start,
+			  level->items_area.add.hash.end,
+			  level->items_area.add.pos.state,
+			  level->items_area.add.pos.start,
+			  level->items_area.add.pos.count);
+
+		SSDFS_DBG("INSERT: op_state %#x, start_hash %llx, "
+			  "end_hash %llx, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->items_area.insert.op_state,
+			  level->items_area.insert.hash.start,
+			  level->items_area.insert.hash.end,
+			  level->items_area.insert.pos.state,
+			  level->items_area.insert.pos.start,
+			  level->items_area.insert.pos.count);
+
+		SSDFS_DBG("MOVE: op_state %#x, direction %#x, "
+			  "POSITION(state %#x, start %u, count %u)\n",
+			  level->items_area.move.op_state,
+			  level->items_area.move.direction,
+			  level->items_area.move.pos.state,
+			  level->items_area.move.pos.start,
+			  level->items_area.move.pos.count);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B46A266D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBYBUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBYBTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:12 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66D1420C
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:00 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s41so7618oiw.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQQiVE6WIgoK7cj+rs5hZ3UPd+GufWLt79PFo8OwnJ0=;
        b=SV6Oil0WRKjRaTNlviIadx70cZGUtqK1/ShdVpao14F1bI0pysecONj4pN0e7uFSnx
         9hwTIFTWccCkpXmBOci7D9mgfIPKVeDY3cMPUIfJEcPgA29b3MsmQWXtMHiIKLB0IPtj
         WXIuIIP57qmRiqKVu6DMBFHp+NGf9anIxeCoW/9FbM5Q4Fo59hrbbGtKNOCxM1zcH+xi
         88TXS4cHViTc8H6qNsR4eZdRJAVSVRHdryOEScsYYlMOgNYDE8kykZQ+j0aMJAT/gu+G
         y+HDmmrv5BQxvakAfSa5rPLXlaMitPwZFpyYHYVip4VD+q+2lBYxYTINO1kIQ18KxYEQ
         ns4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQQiVE6WIgoK7cj+rs5hZ3UPd+GufWLt79PFo8OwnJ0=;
        b=5gOjXmWYr7ydvgvM1tUPXiMunlFQSUzHH+YLButFyHCR4BvAfkAaYZQHcMsI1/a9mz
         RxXRuG2VQKroXvlFX559W9tenEwwaJBmVSjfrTaHMw8L3Dl5QeL6juzUfpL/NT7KaetJ
         3uyF+dfQrbU5LMn6xWRPn+FWAKM8ozlYZDTymHco3sX6/dc739HuDmVmwHTW/A5BzclA
         ToincfmEPSBTARruHq/mXcB9+JkTF/580w66LeDjDGcn6IKgOTnBLlDcBkACXPMOHfkF
         DOhXKGYNx4EZKJydqELUwgZAuKp2gIH+Lbu6Qrg/nxIjigcm7PEr5mezu9DDdI578N5k
         00+w==
X-Gm-Message-State: AO0yUKVN12g2m7yK++fQKa6vm1uXiOHU/wZt6UTiz6Jq4DPScPVKmtRw
        hQ5RRE509EXFsh89cxdLScAYnM3X0F1Gr1YG
X-Google-Smtp-Source: AK7set/xawJSJyz0EhnZ3Toto6SZvNBe5T6FTmJkm8EF6OhgJE5vnL4WqfzQeUTiUaKKHHdH9S1cNQ==
X-Received: by 2002:aca:1307:0:b0:36c:a58f:a245 with SMTP id e7-20020aca1307000000b0036ca58fa245mr5016130oii.8.1677287878989;
        Fri, 24 Feb 2023 17:17:58 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:58 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 68/76] ssdfs: search extent logic in extents b-tree node
Date:   Fri, 24 Feb 2023 17:09:19 -0800
Message-Id: <20230225010927.813929-69-slava@dubeyko.com>
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

This patch implements lookup logic in extents b-tree node.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/extents_tree.c | 3111 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 3111 insertions(+)

diff --git a/fs/ssdfs/extents_tree.c b/fs/ssdfs/extents_tree.c
index f978ef0cca12..4b183308eff5 100644
--- a/fs/ssdfs/extents_tree.c
+++ b/fs/ssdfs/extents_tree.c
@@ -6887,3 +6887,3114 @@ int ssdfs_extents_tree_delete_all(struct ssdfs_extents_btree_info *tree)
 
 	return err;
 }
+
+/******************************************************************************
+ *             SPECIALIZED EXTENTS BTREE DESCRIPTOR OPERATIONS                *
+ ******************************************************************************/
+
+/*
+ * ssdfs_extents_btree_desc_init() - specialized btree descriptor init
+ * @fsi: pointer on shared file system object
+ * @tree: pointer on btree object
+ */
+static
+int ssdfs_extents_btree_desc_init(struct ssdfs_fs_info *fsi,
+				  struct ssdfs_btree *tree)
+{
+	struct ssdfs_extents_btree_info *tree_info = NULL;
+	struct ssdfs_btree_descriptor *desc;
+	u32 erasesize;
+	u32 node_size;
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
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
+				 struct ssdfs_extents_btree_info,
+				 buffer.tree);
+
+	erasesize = fsi->erasesize;
+
+	desc = &tree_info->desc.desc;
+
+	if (le32_to_cpu(desc->magic) != SSDFS_EXTENTS_BTREE_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid magic %#x\n",
+			  le32_to_cpu(desc->magic));
+		goto finish_btree_desc_init;
+	}
+
+	/* TODO: check flags */
+
+	if (desc->type != SSDFS_EXTENTS_BTREE) {
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
+	if (item_size != fork_size) {
+		err = -EIO;
+		SSDFS_ERR("invalid item size %u\n",
+			  item_size);
+		goto finish_btree_desc_init;
+	}
+
+	if (le16_to_cpu(desc->index_area_min_size) < (4 * fork_size)) {
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
+ * ssdfs_extents_btree_desc_flush() - specialized btree's descriptor flush
+ * @tree: pointer on btree object
+ */
+static
+int ssdfs_extents_btree_desc_flush(struct ssdfs_btree *tree)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_extents_btree_info *tree_info = NULL;
+	struct ssdfs_btree_descriptor desc;
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
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
+	if (tree->type != SSDFS_EXTENTS_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_extents_btree_info,
+					 buffer.tree);
+	}
+
+	memset(&desc, 0xFF, sizeof(struct ssdfs_btree_descriptor));
+
+	desc.magic = cpu_to_le32(SSDFS_EXTENTS_BTREE_MAGIC);
+	desc.item_size = cpu_to_le16(fork_size);
+
+	err = ssdfs_btree_desc_flush(tree, &desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("invalid btree descriptor: err %d\n",
+			  err);
+		return err;
+	}
+
+	if (desc.type != SSDFS_EXTENTS_BTREE) {
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
+	if (le16_to_cpu(desc.index_area_min_size) < (4 * fork_size)) {
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
+ *                   SPECIALIZED EXTENTS BTREE OPERATIONS                     *
+ ******************************************************************************/
+
+/*
+ * ssdfs_extents_btree_create_root_node() - specialized root node creation
+ * @fsi: pointer on shared file system object
+ * @node: pointer on node object [out]
+ */
+static
+int ssdfs_extents_btree_create_root_node(struct ssdfs_fs_info *fsi,
+					 struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_extents_btree_info *tree_info = NULL;
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
+	if (tree->type != SSDFS_EXTENTS_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_extents_btree_info,
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
+	if (private_flags & SSDFS_INODE_HAS_EXTENTS_BTREE) {
+		switch (atomic_read(&tree_info->type)) {
+		case SSDFS_PRIVATE_EXTENTS_BTREE:
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
+			     &raw_inode->internal[0].area1.extents_root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     sizeof(struct ssdfs_btree_inline_root_node));
+	} else {
+		switch (atomic_read(&tree_info->type)) {
+		case SSDFS_INLINE_FORKS_ARRAY:
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
+ * ssdfs_extents_btree_pre_flush_root_node() - specialized root node pre-flush
+ * @node: pointer on node object
+ */
+static
+int ssdfs_extents_btree_pre_flush_root_node(struct ssdfs_btree_node *node)
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
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is clean\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	if (tree->type != SSDFS_EXTENTS_BTREE) {
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
+ * ssdfs_extents_btree_flush_root_node() - specialized root node flush
+ * @node: pointer on node object
+ */
+static
+int ssdfs_extents_btree_flush_root_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_extents_btree_info *tree_info = NULL;
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
+	if (tree->type != SSDFS_EXTENTS_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_extents_btree_info,
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
+	if (private_flags & SSDFS_INODE_HAS_EXTENTS_BTREE) {
+		switch (atomic_read(&tree_info->type)) {
+		case SSDFS_PRIVATE_EXTENTS_BTREE:
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
+		ssdfs_memcpy(&tmp_buffer,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     tree_info->root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     sizeof(struct ssdfs_btree_inline_root_node));
+
+		raw_inode = &tree_info->owner->raw_inode;
+		ssdfs_memcpy(&raw_inode->internal[0].area1.extents_root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     &tmp_buffer,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     sizeof(struct ssdfs_btree_inline_root_node));
+	} else {
+		err = -ERANGE;
+		SSDFS_ERR("extents tree is inline forks array\n");
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_extents_btree_create_node() - specialized node creation
+ * @node: pointer on node object
+ */
+static
+int ssdfs_extents_btree_create_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	void *addr[SSDFS_BTREE_NODE_BMAP_COUNT];
+	size_t hdr_size = sizeof(struct ssdfs_extents_btree_node_header);
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
+	SSDFS_DBG("node_id %u, state %#x, type %#x\n",
+		  node->node_id, atomic_read(&node->state),
+		  atomic_read(&node->type));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree = node->tree;
+	node_size = tree->node_size;
+	index_area_min_size = tree->index_area_min_size;
+
+	node->node_ops = &ssdfs_extents_btree_node_ops;
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
+		node->raw.extents_header.blks_count = cpu_to_le64(0);
+		node->raw.extents_header.forks_count = cpu_to_le32(0);
+		node->raw.extents_header.allocated_extents = cpu_to_le32(0);
+		node->raw.extents_header.valid_extents = cpu_to_le32(0);
+		node->raw.extents_header.max_extent_blks = cpu_to_le32(0);
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
+		node->raw.extents_header.blks_count = cpu_to_le64(0);
+		node->raw.extents_header.forks_count = cpu_to_le32(0);
+		node->raw.extents_header.allocated_extents = cpu_to_le32(0);
+		node->raw.extents_header.valid_extents = cpu_to_le32(0);
+		node->raw.extents_header.max_extent_blks = cpu_to_le32(0);
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
+	if (bmap_bytes == 0 || bmap_bytes > SSDFS_EXTENT_MAX_BMAP_SIZE) {
+		err = -EIO;
+		SSDFS_ERR("invalid bmap_bytes %zu\n",
+			  bmap_bytes);
+		goto finish_create_node;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, blks_count %llu, "
+		  "forks_count %u, allocated_extents %u, "
+		  "valid_extents %u, max_extent_blks %u\n",
+		  node->node_id,
+		  le64_to_cpu(node->raw.extents_header.blks_count),
+		  le32_to_cpu(node->raw.extents_header.forks_count),
+		  le32_to_cpu(node->raw.extents_header.allocated_extents),
+		  le32_to_cpu(node->raw.extents_header.valid_extents),
+		  le32_to_cpu(node->raw.extents_header.max_extent_blks));
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
+ * ssdfs_extents_btree_init_node() - init extents tree's node
+ * @node: pointer on node object
+ *
+ * This method tries to init the node of extents btree.
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
+int ssdfs_extents_btree_init_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_extents_btree_info *tree_info = NULL;
+	struct ssdfs_extents_btree_node_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_extents_btree_node_header);
+	void *addr[SSDFS_BTREE_NODE_BMAP_COUNT];
+	struct page *page;
+	void *kaddr;
+	u64 start_hash, end_hash;
+	u32 node_size;
+	u16 item_size;
+	u16 parent_ino;
+	u32 forks_count;
+	u16 items_capacity;
+	u32 allocated_extents, valid_extents;
+	u64 calculated_extents;
+	u32 max_extent_blks;
+	u64 calculated_blks;
+	u64 blks_count;
+	u32 items_count;
+	u16 flags;
+	u8 index_size;
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
+	if (tree->type != SSDFS_EXTENTS_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_extents_btree_info,
+					 buffer.tree);
+	}
+
+	if (atomic_read(&node->state) != SSDFS_BTREE_NODE_CONTENT_PREPARED) {
+		SSDFS_WARN("fail to init node: id %u, state %#x\n",
+			   node->node_id, atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	down_write(&node->full_lock);
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
+	hdr = (struct ssdfs_extents_btree_node_header *)kaddr;
+
+	if (!is_csum_valid(&hdr->node.check, hdr, hdr_size)) {
+		err = -EIO;
+		SSDFS_ERR("invalid checksum: node_id %u\n",
+			  node->node_id);
+		goto finish_init_operation;
+	}
+
+	if (le32_to_cpu(hdr->node.magic.common) != SSDFS_SUPER_MAGIC ||
+	    le16_to_cpu(hdr->node.magic.key) != SSDFS_EXTENTS_BNODE_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid magic: common %#x, key %#x\n",
+			  le32_to_cpu(hdr->node.magic.common),
+			  le16_to_cpu(hdr->node.magic.key));
+		goto finish_init_operation;
+	}
+
+	down_write(&node->header_lock);
+
+	ssdfs_memcpy(&node->raw.extents_header, 0, hdr_size,
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
+	start_hash = le64_to_cpu(hdr->node.start_hash);
+	end_hash = le64_to_cpu(hdr->node.end_hash);
+	node_size = 1 << hdr->node.log_node_size;
+	index_size = hdr->node.index_size;
+	item_size = hdr->node.min_item_size;
+	items_capacity = le16_to_cpu(hdr->node.items_capacity);
+	parent_ino = le64_to_cpu(hdr->parent_ino);
+	forks_count = le32_to_cpu(hdr->forks_count);
+	allocated_extents = le32_to_cpu(hdr->allocated_extents);
+	valid_extents = le32_to_cpu(hdr->valid_extents);
+	max_extent_blks = le32_to_cpu(hdr->max_extent_blks);
+	blks_count = le64_to_cpu(hdr->blks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, forks_count %u, "
+		  "allocated_extents %u, valid_extents %u, "
+		  "blks_count %llu\n",
+		  start_hash, end_hash, forks_count,
+		  allocated_extents, valid_extents,
+		  blks_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (parent_ino != tree_info->owner->vfs_inode.i_ino) {
+		err = -EIO;
+		SSDFS_ERR("parent_ino %u != ino %lu\n",
+			  parent_ino,
+			  tree_info->owner->vfs_inode.i_ino);
+		goto finish_header_init;
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		/* do nothing */
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_LEAF_NODE:
+		if (item_size == 0 || node_size % item_size) {
+			err = -EIO;
+			SSDFS_ERR("invalid size: item_size %u, node_size %u\n",
+				  item_size, node_size);
+			goto finish_header_init;
+		}
+
+		if (item_size != sizeof(struct ssdfs_raw_fork)) {
+			err = -EIO;
+			SSDFS_ERR("invalid item_size: "
+				  "size %u, expected size %zu\n",
+				  item_size,
+				  sizeof(struct ssdfs_raw_fork));
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
+		if (forks_count > items_capacity) {
+			err = -EIO;
+			SSDFS_ERR("items_capacity %u != forks_count %u\n",
+				  items_capacity,
+				  forks_count);
+			goto finish_header_init;
+		}
+
+		if (valid_extents > allocated_extents) {
+			err = -EIO;
+			SSDFS_ERR("valid_extents %u > allocated_extents %u\n",
+				  valid_extents, allocated_extents);
+			goto finish_header_init;
+		}
+
+		calculated_extents = (u64)forks_count *
+					SSDFS_INLINE_EXTENTS_COUNT;
+		if (calculated_extents != allocated_extents) {
+			err = -EIO;
+			SSDFS_ERR("calculated_extents %llu != allocated_extents %u\n",
+				  calculated_extents, allocated_extents);
+			goto finish_header_init;
+		}
+
+		calculated_blks = (u64)valid_extents * max_extent_blks;
+		if (calculated_blks < blks_count) {
+			err = -EIO;
+			SSDFS_ERR("calculated_blks %llu < blks_count %llu\n",
+				  calculated_blks, blks_count);
+			goto finish_header_init;
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	node->items_area.items_count = (u16)forks_count;
+	node->items_area.items_capacity = items_capacity;
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
+	if (bmap_bytes == 0 || bmap_bytes > SSDFS_EXTENT_MAX_BMAP_SIZE) {
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
+	flags = atomic_read(&node->flags);
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
+	ssdfs_btree_node_init_bmaps(node, addr);
+
+	spin_lock(&node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].lock);
+	bitmap_set(node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].ptr,
+		   0, forks_count);
+	spin_unlock(&node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].lock);
+
+	up_write(&node->bmap_array.lock);
+finish_init_operation:
+	kunmap_local(kaddr);
+
+	if (unlikely(err))
+		goto finish_init_node;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("forks_count %lld\n",
+		  atomic64_read(&tree_info->forks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_init_node:
+	up_write(&node->full_lock);
+
+	return err;
+}
+
+static
+void ssdfs_extents_btree_destroy_node(struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_extents_btree_add_node() - add node into extents btree
+ * @node: pointer on node object
+ *
+ * This method tries to finish addition of node into extents btree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_extents_btree_add_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	int type;
+	u16 items_capacity = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u, state %#x, type %#x\n",
+		  node->node_id, atomic_read(&node->state),
+		  atomic_read(&node->type));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected states */
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
+	down_write(&node->header_lock);
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		items_capacity = node->items_area.items_capacity;
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
+finish_add_node:
+	up_write(&node->header_lock);
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
+
+static
+int ssdfs_extents_btree_delete_node(struct ssdfs_btree_node *node)
+{
+	/* TODO: implement */
+	SSDFS_DBG("TODO: implement %s\n", __func__);
+	return 0;
+
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
+ * ssdfs_extents_btree_pre_flush_node() - pre-flush node's header
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
+int ssdfs_extents_btree_pre_flush_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_extents_btree_node_header extents_header;
+	size_t hdr_size = sizeof(struct ssdfs_extents_btree_node_header);
+	struct ssdfs_btree *tree;
+	struct ssdfs_extents_btree_info *tree_info = NULL;
+	struct ssdfs_state_bitmap *bmap;
+	struct page *page;
+	u16 items_count;
+	u32 forks_count;
+	u32 allocated_extents;
+	u32 valid_extents;
+	u32 max_extent_blks;
+	u64 blks_count;
+	u64 calculated_extents;
+	u64 calculated_blks;
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
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is clean\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	if (tree->type != SSDFS_EXTENTS_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_extents_btree_info,
+					 buffer.tree);
+	}
+
+	down_write(&node->full_lock);
+	down_write(&node->header_lock);
+
+	ssdfs_memcpy(&extents_header, 0, hdr_size,
+		     &node->raw.extents_header, 0, hdr_size,
+		     hdr_size);
+
+	extents_header.node.magic.common = cpu_to_le32(SSDFS_SUPER_MAGIC);
+	extents_header.node.magic.key = cpu_to_le16(SSDFS_EXTENTS_BNODE_MAGIC);
+	extents_header.node.magic.version.major = SSDFS_MAJOR_REVISION;
+	extents_header.node.magic.version.minor = SSDFS_MINOR_REVISION;
+
+	err = ssdfs_btree_node_pre_flush_header(node, &extents_header.node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to flush generic header: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		goto finish_extents_header_preparation;
+	}
+
+	if (!tree_info->owner) {
+		err = -ERANGE;
+		SSDFS_WARN("fail to extract parent_ino\n");
+		goto finish_extents_header_preparation;
+	}
+
+	extents_header.parent_ino =
+		cpu_to_le64(tree_info->owner->vfs_inode.i_ino);
+
+	items_count = node->items_area.items_count;
+	forks_count = le32_to_cpu(extents_header.forks_count);
+	allocated_extents = le32_to_cpu(extents_header.allocated_extents);
+	valid_extents = le32_to_cpu(extents_header.valid_extents);
+	max_extent_blks = le32_to_cpu(extents_header.max_extent_blks);
+	blks_count = le64_to_cpu(extents_header.blks_count);
+
+	if (forks_count != items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("forks_count %u != items_count %u\n",
+			  forks_count, items_count);
+		goto finish_extents_header_preparation;
+	}
+
+	if (valid_extents > allocated_extents) {
+		err = -ERANGE;
+		SSDFS_ERR("valid_extents %u > allocated_extents %u\n",
+			  valid_extents, allocated_extents);
+		goto finish_extents_header_preparation;
+	}
+
+	calculated_extents = (u64)forks_count * SSDFS_INLINE_EXTENTS_COUNT;
+	if (calculated_extents != allocated_extents) {
+		err = -ERANGE;
+		SSDFS_ERR("calculated_extents %llu != allocated_extents %u\n",
+			  calculated_extents, allocated_extents);
+		goto finish_extents_header_preparation;
+	}
+
+	calculated_blks = (u64)valid_extents * max_extent_blks;
+	if (calculated_blks < blks_count) {
+		err = -ERANGE;
+		SSDFS_ERR("calculated_blks %llu < blks_count %llu\n",
+			  calculated_blks, blks_count);
+		goto finish_extents_header_preparation;
+	}
+
+	extents_header.node.check.bytes = cpu_to_le16((u16)hdr_size);
+	extents_header.node.check.flags = cpu_to_le16(SSDFS_CRC32);
+
+	err = ssdfs_calculate_csum(&extents_header.node.check,
+				   &extents_header, hdr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to calculate checksum: err %d\n", err);
+		goto finish_extents_header_preparation;
+	}
+
+	ssdfs_memcpy(&node->raw.extents_header, 0, hdr_size,
+		     &extents_header, 0, hdr_size,
+		     hdr_size);
+
+finish_extents_header_preparation:
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
+			     &extents_header, 0, hdr_size,
+			     hdr_size);
+
+finish_node_pre_flush:
+	up_write(&node->full_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_extents_btree_flush_node() - flush node
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
+int ssdfs_extents_btree_flush_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_extents_btree_info *tree_info = NULL;
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
+	if (tree->type != SSDFS_EXTENTS_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_extents_btree_info,
+					 buffer.tree);
+	}
+
+	private_flags = atomic_read(&tree_info->owner->private_flags);
+
+	if (private_flags & SSDFS_INODE_HAS_EXTENTS_BTREE) {
+		switch (atomic_read(&tree_info->type)) {
+		case SSDFS_PRIVATE_EXTENTS_BTREE:
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
+		SSDFS_ERR("extents tree is inline forks array\n");
+	}
+
+	return err;
+}
+
+/******************************************************************************
+ *               SPECIALIZED EXTENTS BTREE NODE OPERATIONS                    *
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
+					sizeof(struct ssdfs_raw_fork),
+					SSDFS_EXTENTS_BTREE_LOOKUP_TABLE_SIZE);
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
+					sizeof(struct ssdfs_raw_fork),
+					SSDFS_EXTENTS_BTREE_LOOKUP_TABLE_SIZE);
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
+	lookup_index = ssdfs_convert_item2lookup_index(node_size, item_index);
+	calculated = ssdfs_convert_lookup2item_index(node_size, lookup_index);
+
+	return calculated == item_index;
+}
+
+/*
+ * ssdfs_extents_btree_node_find_lookup_index() - find lookup index
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
+int ssdfs_extents_btree_node_find_lookup_index(struct ssdfs_btree_node *node,
+					    struct ssdfs_btree_search *search,
+					    u16 *lookup_index)
+{
+	__le64 *lookup_table;
+	int array_size = SSDFS_EXTENTS_BTREE_LOOKUP_TABLE_SIZE;
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
+	lookup_table = node->raw.extents_header.lookup_table;
+	err = ssdfs_btree_node_find_lookup_index_nolock(search,
+							lookup_table,
+							array_size,
+							lookup_index);
+	up_read(&node->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lookup_index %u, err %d\n",
+		  *lookup_index, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_get_fork_hash_range() - get fork's hash range
+ * @kaddr: pointer on the fork object
+ * @start_hash: pointer on the value of starting hash [out]
+ * @end_hash: pointer on the value of ending hash [out]
+ */
+static
+void ssdfs_get_fork_hash_range(void *kaddr,
+				u64 *start_hash,
+				u64 *end_hash)
+{
+	struct ssdfs_raw_fork *fork;
+	u64 blks_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr || !start_hash || !end_hash);
+
+	SSDFS_DBG("kaddr %p\n", kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fork = (struct ssdfs_raw_fork *)kaddr;
+	*start_hash = le64_to_cpu(fork->start_offset);
+	blks_count = le64_to_cpu(fork->blks_count);
+
+	if (blks_count > 0)
+		*end_hash = *start_hash + blks_count - 1;
+	else
+		*end_hash = *start_hash;
+}
+
+/*
+ * ssdfs_check_found_fork() - check found fork
+ * @fsi: pointer on shared file system object
+ * @search: search object
+ * @kaddr: pointer on the fork object
+ * @item_index: index of the item
+ * @start_hash: pointer on the value of starting hash [out]
+ * @end_hash: pointer on the value of ending hash [out]
+ * @found_index: pointer on the value with found index [out]
+ *
+ * This method tries to check the found fork.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - possible place was found.
+ */
+static
+int ssdfs_check_found_fork(struct ssdfs_fs_info *fsi,
+			   struct ssdfs_btree_search *search,
+			   void *kaddr,
+			   u16 item_index,
+			   u64 *start_hash,
+			   u64 *end_hash,
+			   u16 *found_index)
+{
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
+	ssdfs_get_fork_hash_range(kaddr, start_hash, end_hash);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("item_index %u, "
+		  "search (start_hash %llx, end_hash %llx), "
+		  "start_hash %llx, end_hash %llx\n",
+		  item_index,
+		  search->request.start.hash,
+		  search->request.end.hash,
+		  *start_hash, *end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (*start_hash <= search->request.start.hash &&
+	    *end_hash >= search->request.end.hash) {
+		/* start_hash is inside the fork */
+		*found_index = item_index;
+
+		search->result.state = SSDFS_BTREE_SEARCH_VALID_ITEM;
+		search->result.err = 0;
+		search->result.start_index = *found_index;
+		search->result.count = 1;
+	} else if (*start_hash > search->request.end.hash) {
+		*found_index = item_index;
+
+		search->result.state =
+			SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		search->result.err = -ENODATA;
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
+			search->result.buf_state =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+			search->result.buf = NULL;
+			search->result.buf_size = 0;
+			search->result.items_in_buffer = 0;
+			break;
+		}
+	} else if ((*end_hash + 1) == search->request.start.hash) {
+		err = -EAGAIN;
+		*found_index = item_index + 1;
+
+		search->result.state =
+			SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		search->result.err = -ENODATA;
+		search->result.start_index = *found_index;
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
+	} else if (*end_hash < search->request.start.hash) {
+		err = -EAGAIN;
+		*found_index = item_index + 1;
+	} else if (*start_hash > search->request.start.hash &&
+		   *end_hash < search->request.end.hash) {
+		err = -ERANGE;
+		SSDFS_ERR("requested range is bigger than fork: "
+			  "search (start_hash %llx, end_hash %llx), "
+			  "start_hash %llx, end_hash %llx\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  *start_hash, *end_hash);
+	} else if (*start_hash > search->request.start.hash &&
+		   *end_hash > search->request.end.hash) {
+		err = -ERANGE;
+		SSDFS_ERR("requested range exists partially: "
+			  "search (start_hash %llx, end_hash %llx), "
+			  "start_hash %llx, end_hash %llx\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  *start_hash, *end_hash);
+	} else if (*start_hash < search->request.start.hash &&
+		   *end_hash < search->request.end.hash) {
+		err = -ERANGE;
+		SSDFS_ERR("requested range exists partially: "
+			  "search (start_hash %llx, end_hash %llx), "
+			  "start_hash %llx, end_hash %llx\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  *start_hash, *end_hash);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found_index %u, err %d\n",
+		  *found_index, err);
+
+	ssdfs_debug_btree_search_object(search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_prepare_forks_buffer() - prepare buffer for the forks
+ * @search: search object
+ * @found_index: found index of the item
+ * @start_hash: starting hash of the range
+ * @end_hash: ending hash of the range
+ * @items_count: count of items in the range
+ * @item_size: size of the item in bytes
+ *
+ * This method tries to prepare the buffers for the forks' range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate the memory.
+ */
+static
+int ssdfs_prepare_forks_buffer(struct ssdfs_btree_search *search,
+				u16 found_index,
+				u64 start_hash,
+				u64 end_hash,
+				u16 items_count,
+				size_t item_size)
+{
+	u16 found_forks = 0;
+	int err = 0;
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
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_FIND_ITEM:
+	case SSDFS_BTREE_SEARCH_FIND_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_ALL:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		/* continue logic */
+		break;
+
+	default:
+		/*
+		 * Do not touch buffer.
+		 * It contains prepared fork.
+		 */
+		search->result.count = search->result.items_in_buffer;
+		return 0;
+	}
+
+	ssdfs_btree_search_free_result_buf(search);
+
+	if (start_hash <= search->request.end.hash &&
+	    search->request.end.hash <= end_hash) {
+		/* use inline buffer */
+		found_forks = 1;
+	} else {
+		/* use external buffer */
+		if (found_index >= items_count) {
+			SSDFS_ERR("found_index %u >= items_count %u\n",
+				  found_index, items_count);
+			return -ERANGE;
+		}
+		found_forks = items_count - found_index;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found_forks %u\n", found_forks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (found_forks == 1) {
+		search->result.buf_state =
+			SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+		search->result.buf = &search->raw.fork;
+		search->result.buf_size = item_size;
+		search->result.items_in_buffer = 0;
+	} else {
+		err = ssdfs_btree_search_alloc_result_buf(search,
+						item_size * found_forks);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to allocate memory for buffer\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extract_found_fork() - extract found fork
+ * @fsi: pointer on shared file system object
+ * @search: search object
+ * @item_size: size of the item in bytes
+ * @kaddr: pointer on the fork object
+ * @start_hash: pointer on the value of starting hash [out]
+ * @end_hash: pointer on the value of ending hash [out]
+ *
+ * This method tries to extract the found fork.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_extract_found_fork(struct ssdfs_fs_info *fsi,
+			     struct ssdfs_btree_search *search,
+			     size_t item_size,
+			     void *kaddr,
+			     u64 *start_hash,
+			     u64 *end_hash)
+{
+	u32 calculated;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !kaddr);
+	BUG_ON(!start_hash || !end_hash);
+
+	SSDFS_DBG("kaddr %p\n", kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_hash = U64_MAX;
+	*end_hash = U64_MAX;
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_FIND_ITEM:
+	case SSDFS_BTREE_SEARCH_FIND_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_ALL:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		/* continue logic */
+		break;
+
+	default:
+		/*
+		 * Do not touch buffer.
+		 * It contains prepared fork.
+		 */
+		search->result.count = search->result.items_in_buffer;
+		return 0;
+	}
+
+	calculated = search->result.items_in_buffer * item_size;
+	if (calculated >= search->result.buf_size) {
+		SSDFS_ERR("calculated %u >= buf_size %zu\n",
+			  calculated, search->result.buf_size);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_get_fork_hash_range(kaddr, start_hash, end_hash);
+	ssdfs_memcpy(search->result.buf, calculated,
+		     search->result.buf_size,
+		     kaddr, 0, item_size,
+		     item_size);
+	search->result.items_in_buffer++;
+	search->result.count++;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search (result.items_in_buffer %u, "
+		  "result.count %u)\n",
+		  search->result.items_in_buffer,
+		  search->result.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (*start_hash <= search->request.start.hash &&
+	    *end_hash >= search->request.end.hash) {
+		/* start_hash is inside the fork */
+		search->result.state = SSDFS_BTREE_SEARCH_VALID_ITEM;
+	} else {
+		/* request is outside the fork */
+		search->result.state = SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+	}
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
+	int capacity = SSDFS_EXTENTS_BTREE_LOOKUP_TABLE_SIZE;
+	size_t item_size = sizeof(struct ssdfs_raw_fork);
+
+	return __ssdfs_extract_range_by_lookup_index(node, lookup_index,
+						     capacity, item_size,
+						     search,
+						     ssdfs_check_found_fork,
+						     ssdfs_prepare_forks_buffer,
+						     ssdfs_extract_found_fork);
+}
+
+/*
+ * ssdfs_btree_search_result_no_data() - prepare result state for no data case
+ * @node: pointer on node object
+ * @lookup_index: lookup index
+ * @search: pointer on search request object [in|out]
+ *
+ * This method prepares result state for no data case.
+ */
+static inline
+void ssdfs_btree_search_result_no_data(struct ssdfs_btree_node *node,
+					u16 lookup_index,
+					struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
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
+	search->result.state = SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+	search->result.err = -ENODATA;
+	search->result.start_index =
+			ssdfs_convert_lookup2item_index(node->node_size,
+							lookup_index);
+	search->result.count = search->request.count;
+	search->result.search_cno = ssdfs_current_cno(node->tree->fsi->sb);
+
+	if (!is_btree_search_contains_new_item(search)) {
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+		case SSDFS_BTREE_SEARCH_ADD_RANGE:
+		case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+			/* do nothing */
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			search->result.buf_state =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+			search->result.buf = NULL;
+			search->result.buf_size = 0;
+			search->result.items_in_buffer = 0;
+			break;
+		}
+	}
+}
+
+/*
+ * ssdfs_extents_btree_node_find_range() - find a range of items into the node
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to find a range of items into the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - requested range is out of the node.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_extents_btree_node_find_range(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
+{
+	int state;
+	u16 items_count;
+	u16 items_capacity;
+	u64 start_hash;
+	u64 end_hash;
+	u16 lookup_index;
+	int res;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
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
+	state = atomic_read(&node->items_area.state);
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	up_read(&node->header_lock);
+
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	if (items_capacity == 0 || items_count > items_capacity) {
+		SSDFS_ERR("corrupted node description: "
+			  "items_count %u, items_capacity %u\n",
+			  items_count,
+			  items_capacity);
+		return -ERANGE;
+	}
+
+	if (search->request.count > items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "count %u, items_capacity %u\n",
+			  search->request.count,
+			  items_capacity);
+		return -ERANGE;
+	}
+
+	res = ssdfs_btree_node_check_hash_range(node,
+						items_count,
+						items_capacity,
+						start_hash,
+						end_hash,
+						search);
+	if (res == -ENODATA) {
+		/* continue extract the fork */
+		err = res;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items_count %u, items_capacity %u, "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  items_count, items_capacity,
+			  start_hash, end_hash, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (res) {
+		SSDFS_ERR("items_count %u, items_capacity %u, "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  items_count, items_capacity,
+			  start_hash, end_hash, res);
+		return res;
+	}
+
+	res = ssdfs_extents_btree_node_find_lookup_index(node, search,
+							 &lookup_index);
+	if (res == -ENODATA) {
+		err = res;
+		ssdfs_btree_search_result_no_data(node, lookup_index, search);
+		/* continue extract the fork */
+	} else if (unlikely(res)) {
+		SSDFS_ERR("fail to find the index: "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  res);
+		return res;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(lookup_index >= SSDFS_EXTENTS_BTREE_LOOKUP_TABLE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	res = ssdfs_extract_range_by_lookup_index(node, lookup_index,
+						  search);
+	search->request.count = search->result.count;
+	search->result.search_cno = ssdfs_current_cno(node->tree->fsi->sb);
+
+	ssdfs_debug_btree_search_object(search);
+
+	if (res == -ENODATA) {
+		err = res;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u is empty\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (res == -EAGAIN) {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u contains not all requested blocks: "
+			  "node (start_hash %llx, end_hash %llx), "
+			  "request (start_hash %llx, end_hash %llx)\n",
+			  node->node_id,
+			  start_hash, end_hash,
+			  search->request.start.hash,
+			  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		ssdfs_btree_search_result_no_data(node, lookup_index, search);
+	} else if (unlikely(res)) {
+		SSDFS_ERR("fail to extract range: "
+			  "node %u (start_hash %llx, end_hash %llx), "
+			  "request (start_hash %llx, end_hash %llx), "
+			  "err %d\n",
+			  node->node_id,
+			  start_hash, end_hash,
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		return res;
+	}
+
+	search->request.flags &= ~SSDFS_BTREE_SEARCH_INLINE_BUF_HAS_NEW_ITEM;
+
+	return err;
+}
+
+/*
+ * ssdfs_extents_btree_node_find_item() - find item into node
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to find an item into the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_extents_btree_node_find_item(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
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
+	return ssdfs_extents_btree_node_find_range(node, search);
+}
+
+static
+int ssdfs_extents_btree_node_allocate_item(struct ssdfs_btree_node *node,
+					    struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+	return -EOPNOTSUPP;
+}
+
+static
+int ssdfs_extents_btree_node_allocate_range(struct ssdfs_btree_node *node,
+					    struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+	return -EOPNOTSUPP;
+}
+
+/*
+ * __ssdfs_extents_btree_node_get_fork() - extract the fork from pagevec
+ * @pvec: pointer on pagevec
+ * @area_offset: area offset from the node's beginning
+ * @area_size: area size
+ * @node_size: size of the node
+ * @item_index: index of the fork in the node
+ * @fork: pointer on fork's buffer [out]
+ *
+ * This method tries to extract the fork from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int __ssdfs_extents_btree_node_get_fork(struct pagevec *pvec,
+					u32 area_offset,
+					u32 area_size,
+					u32 node_size,
+					u16 item_index,
+					struct ssdfs_raw_fork *fork)
+{
+	size_t item_size = sizeof(struct ssdfs_raw_fork);
+	u32 item_offset;
+	int page_index;
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec || !fork);
+
+	SSDFS_DBG("area_offset %u, area_size %u, item_index %u\n",
+		  area_offset, area_size, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_offset = (u32)item_index * item_size;
+	if (item_offset >= area_size) {
+		SSDFS_ERR("item_offset %u >= area_size %u\n",
+			  item_offset, area_size);
+		return -ERANGE;
+	}
+
+	item_offset += area_offset;
+	if (item_offset >= node_size) {
+		SSDFS_ERR("item_offset %u >= node_size %u\n",
+			  item_offset, node_size);
+		return -ERANGE;
+	}
+
+	page_index = item_offset >> PAGE_SHIFT;
+
+	if (page_index > 0)
+		item_offset %= page_index * PAGE_SIZE;
+
+	if (page_index >= pagevec_count(pvec)) {
+		SSDFS_ERR("invalid page_index: "
+			  "index %d, pvec_size %u\n",
+			  page_index,
+			  pagevec_count(pvec));
+		return -ERANGE;
+	}
+
+	page = pvec->pages[page_index];
+	err = ssdfs_memcpy_from_page(fork, 0, item_size,
+				     page, item_offset, PAGE_SIZE,
+				     item_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_btree_node_get_fork() - extract fork from the node
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @item_index: index of the fork
+ * @fork: pointer on extracted fork [out]
+ *
+ * This method tries to extract the fork from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_extents_btree_node_get_fork(struct ssdfs_btree_node *node,
+				  struct ssdfs_btree_node_items_area *area,
+				  u16 item_index,
+				  struct ssdfs_raw_fork *fork)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !fork);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_index %u\n",
+		  node->node_id, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_extents_btree_node_get_fork(&node->content.pvec,
+						   area->offset,
+						   area->area_size,
+						   node->node_size,
+						   item_index,
+						   fork);
+}
+
+/*
+ * is_requested_position_correct() - check that requested position is correct
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @search: search object
+ *
+ * This method tries to check that requested position of a fork
+ * into the node is correct.
+ *
+ * RETURN:
+ * [success]
+ *
+ * %SSDFS_CORRECT_POSITION        - requested position is correct.
+ * %SSDFS_SEARCH_LEFT_DIRECTION   - correct position from the left.
+ * %SSDFS_SEARCH_RIGHT_DIRECTION  - correct position from the right.
+ *
+ * [failure] - error code:
+ *
+ * %SSDFS_CHECK_POSITION_FAILURE  - internal error.
+ */
+static
+int is_requested_position_correct(struct ssdfs_btree_node *node,
+				  struct ssdfs_btree_node_items_area *area,
+				  struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_fork fork;
+	u16 item_index;
+	u64 start_offset;
+	u64 blks_count;
+	u64 end_offset;
+	int direction = SSDFS_CHECK_POSITION_FAILURE;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_index %u\n",
+		  node->node_id, search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_index = search->result.start_index;
+	if ((item_index + search->result.count) > area->items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, count %u\n",
+			  item_index, search->result.count);
+		return SSDFS_CHECK_POSITION_FAILURE;
+	}
+
+	if (item_index >= area->items_count) {
+		if (area->items_count == 0)
+			item_index = area->items_count;
+		else
+			item_index = area->items_count - 1;
+
+		search->result.start_index = item_index;
+	}
+
+
+	err = ssdfs_extents_btree_node_get_fork(node, area,
+						item_index, &fork);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract the fork: "
+			  "item_index %u, err %d\n",
+			  item_index, err);
+		return SSDFS_CHECK_POSITION_FAILURE;
+	}
+
+	start_offset = le64_to_cpu(fork.start_offset);
+	blks_count = le64_to_cpu(fork.blks_count);
+
+	if (start_offset >= U64_MAX || blks_count >= U64_MAX) {
+		SSDFS_ERR("invalid fork\n");
+		return SSDFS_CHECK_POSITION_FAILURE;
+	}
+
+	if (blks_count > 0)
+		end_offset = start_offset + blks_count - 1;
+	else
+		end_offset = start_offset;
+
+	if (start_offset <= search->request.start.hash &&
+	    search->request.start.hash < end_offset)
+		direction = SSDFS_CORRECT_POSITION;
+	else if (search->request.start.hash < start_offset)
+		direction = SSDFS_SEARCH_LEFT_DIRECTION;
+	else
+		direction = SSDFS_SEARCH_RIGHT_DIRECTION;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_offset %llx, end_offset %llx, "
+		  "search (start_hash %llx, end_hash %llx), "
+		  "direction %#x\n",
+		  start_offset, end_offset,
+		  search->request.start.hash,
+		  search->request.end.hash,
+		  direction);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return direction;
+}
+
+/*
+ * ssdfs_find_correct_position_from_left() - find position from the left
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @search: search object
+ *
+ * This method tries to find a correct position of the fork
+ * from the left side of forks' sequence in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_find_correct_position_from_left(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_items_area *area,
+				    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_fork fork;
+	int item_index;
+	u64 start_offset;
+	u64 blks_count;
+	u64 end_offset;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_index %u\n",
+		  node->node_id, search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_index = search->result.start_index;
+	if ((item_index + search->request.count) > area->items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %d, count %u\n",
+			  item_index, search->request.count);
+		return -ERANGE;
+	}
+
+	if (item_index >= area->items_count) {
+		if (area->items_count == 0)
+			item_index = area->items_count;
+		else
+			item_index = area->items_count - 1;
+
+		search->result.start_index = (u16)item_index;
+	}
+
+	if (area->items_count == 0)
+		return 0;
+
+	for (; item_index >= 0; item_index--) {
+		err = ssdfs_extents_btree_node_get_fork(node, area,
+							(u16)item_index,
+							&fork);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the fork: "
+				  "item_index %d, err %d\n",
+				  item_index, err);
+			return err;
+		}
+
+		start_offset = le64_to_cpu(fork.start_offset);
+		blks_count = le64_to_cpu(fork.blks_count);
+
+		if (blks_count > 0)
+			end_offset = start_offset + blks_count - 1;
+		else
+			end_offset = start_offset;
+
+		if (start_offset <= search->request.start.hash &&
+		    search->request.start.hash < end_offset) {
+			search->result.start_index = (u16)item_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("search->result.start_index %u\n",
+				  search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			return 0;
+		} else if (end_offset <= search->request.start.hash) {
+			search->result.start_index = (u16)(item_index + 1);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("search->result.start_index %u\n",
+				  search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			return 0;
+		}
+	}
+
+	search->result.start_index = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search->result.start_index %u\n",
+		  search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_find_correct_position_from_right() - find position from the right
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @search: search object
+ *
+ * This method tries to find a correct position of the fork
+ * from the right side of forks' sequence in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_find_correct_position_from_right(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_items_area *area,
+				    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_fork fork;
+	int item_index;
+	u64 start_offset;
+	u64 blks_count;
+	u64 end_offset;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_index %u\n",
+		  node->node_id, search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_index = search->result.start_index;
+	if ((item_index + search->result.count) > area->items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %d, count %u, "
+			  "area->items_capacity %u\n",
+			  item_index, search->result.count,
+			  area->items_capacity);
+		return -ERANGE;
+	}
+
+	if (item_index >= area->items_count) {
+		if (area->items_count == 0)
+			item_index = area->items_count;
+		else
+			item_index = area->items_count - 1;
+
+		search->result.start_index = (u16)item_index;
+	}
+
+
+	for (; item_index < area->items_count; item_index++) {
+		err = ssdfs_extents_btree_node_get_fork(node, area,
+							(u16)item_index,
+							&fork);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the fork: "
+				  "item_index %d, err %d\n",
+				  item_index, err);
+			return err;
+		}
+
+		start_offset = le64_to_cpu(fork.start_offset);
+		blks_count = le64_to_cpu(fork.blks_count);
+
+		if (blks_count > 0)
+			end_offset = start_offset + blks_count - 1;
+		else
+			end_offset = start_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_offset %llx, end_offset %llx, "
+			  "search (start_hash %llx, end_hash %llx)\n",
+			  start_offset, end_offset,
+			  search->request.start.hash,
+			  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (start_offset <= search->request.start.hash &&
+		    search->request.start.hash <= end_offset) {
+			search->result.start_index = (u16)item_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("search->result.start_index %u\n",
+				  search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			return 0;
+		} else if (search->request.end.hash < start_offset) {
+			if (item_index == 0) {
+				search->result.start_index =
+						(u16)item_index;
+			} else {
+				search->result.start_index =
+						(u16)(item_index - 1);
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("search->result.start_index %u\n",
+				  search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			return 0;
+		}
+	}
+
+	search->result.start_index = area->items_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search->result.start_index %u\n",
+		  search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_clean_lookup_table() - clean unused space of lookup table
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @start_index: starting index
+ *
+ * This method tries to clean the unused space of lookup table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_clean_lookup_table(struct ssdfs_btree_node *node,
+			     struct ssdfs_btree_node_items_area *area,
+			     u16 start_index)
+{
+	__le64 *lookup_table;
+	u16 lookup_index;
+	u16 item_index;
+	u16 items_count;
+	u16 items_capacity;
+	u16 cleaning_indexes;
+	u32 cleaning_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, start_index %u\n",
+		  node->node_id, start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	items_capacity = node->items_area.items_capacity;
+	if (start_index >= items_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_index %u >= items_capacity %u\n",
+			  start_index, items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	lookup_table = node->raw.extents_header.lookup_table;
+
+	lookup_index = ssdfs_convert_item2lookup_index(node->node_size,
+						       start_index);
+	if (unlikely(lookup_index >= SSDFS_EXTENTS_BTREE_LOOKUP_TABLE_SIZE)) {
+		SSDFS_ERR("invalid lookup_index %u\n",
+			  lookup_index);
+		return -ERANGE;
+	}
+
+	items_count = node->items_area.items_count;
+	item_index = ssdfs_convert_lookup2item_index(node->node_size,
+						     lookup_index);
+	if (unlikely(item_index >= items_capacity)) {
+		SSDFS_ERR("item_index %u >= items_capacity %u\n",
+			  item_index, items_capacity);
+		return -ERANGE;
+	}
+
+	if (item_index != start_index)
+		lookup_index++;
+
+	cleaning_indexes =
+		SSDFS_EXTENTS_BTREE_LOOKUP_TABLE_SIZE - lookup_index;
+	cleaning_bytes = cleaning_indexes * sizeof(__le64);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lookup_index %u, cleaning_indexes %u, cleaning_bytes %u\n",
+		  lookup_index, cleaning_indexes, cleaning_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(&lookup_table[lookup_index], 0xFF, cleaning_bytes);
+
+	return 0;
+}
+
+/*
+ * ssdfs_correct_lookup_table() - correct lookup table of the node
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @start_index: starting index of the range
+ * @range_len: number of items in the range
+ *
+ * This method tries to correct the lookup table of the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_correct_lookup_table(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *area,
+				u16 start_index, u16 range_len)
+{
+	__le64 *lookup_table;
+	struct ssdfs_raw_fork fork;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range_len == 0) {
+		SSDFS_WARN("range == 0\n");
+		return -ERANGE;
+	}
+
+	lookup_table = node->raw.extents_header.lookup_table;
+
+	for (i = 0; i < range_len; i++) {
+		int item_index = start_index + i;
+		u16 lookup_index;
+
+		if (is_hash_for_lookup_table(node->node_size, item_index)) {
+			lookup_index =
+				ssdfs_convert_item2lookup_index(node->node_size,
+								item_index);
+
+			err = ssdfs_extents_btree_node_get_fork(node, area,
+								item_index,
+								&fork);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to extract fork: "
+					  "item_index %d, err %d\n",
+					  item_index, err);
+				return err;
+			}
+
+			lookup_table[lookup_index] = fork.start_offset;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_initialize_lookup_table() - initialize lookup table
+ * @node: pointer on node object
+ */
+static
+void ssdfs_initialize_lookup_table(struct ssdfs_btree_node *node)
+{
+	__le64 *lookup_table;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	lookup_table = node->raw.extents_header.lookup_table;
+	memset(lookup_table, 0xFF,
+		sizeof(__le64) * SSDFS_EXTENTS_BTREE_LOOKUP_TABLE_SIZE);
+}
+
+/*
+ * ssdfs_calculate_range_blocks() - calculate number of blocks in range
+ * @search: search object
+ * @valid_extents: number of valid extents in the range [out]
+ * @blks_count: number of blocks in the range [out]
+ * @max_extent_blks: maximal number of blocks in one extent [out]
+ *
+ * This method tries to calculate the @valid_extents,
+ * @blks_count, @max_extent_blks in the range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_calculate_range_blocks(struct ssdfs_btree_search *search,
+				 u32 *valid_extents,
+				 u64 *blks_count,
+				 u32 *max_extent_blks)
+{
+	struct ssdfs_raw_fork *fork;
+	size_t item_size = sizeof(struct ssdfs_raw_fork);
+	u32 items;
+	int i, j;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !valid_extents || !blks_count || !max_extent_blks);
+
+	SSDFS_DBG("node_id %u\n", search->node.id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*valid_extents = 0;
+	*blks_count = 0;
+	*max_extent_blks = 0;
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+	case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	if (!search->result.buf) {
+		SSDFS_ERR("buffer pointer is NULL\n");
+		return -ERANGE;
+	}
+
+	items = search->result.items_in_buffer;
+	if (search->result.buf_size != (items * item_size)) {
+		SSDFS_ERR("buf_size %zu, items_in_buffer %u, "
+			  "item_size %zu\n",
+			  search->result.buf_size,
+			  items, item_size);
+		return -ERANGE;
+	}
+
+	for (i = 0; i < items; i++) {
+		u64 blks;
+		u64 calculated = 0;
+
+		fork = (struct ssdfs_raw_fork *)((u8 *)search->result.buf +
+							(i * item_size));
+
+		blks = le64_to_cpu(fork->blks_count);
+		if (blks >= U64_MAX || blks == 0) {
+			SSDFS_ERR("corrupted fork: blks_count %llu\n",
+				  blks);
+			return -ERANGE;
+		}
+
+		*blks_count += blks;
+
+		for (j = 0; j < SSDFS_INLINE_EXTENTS_COUNT; j++) {
+			struct ssdfs_raw_extent *extent;
+			u32 len;
+
+			extent = &fork->extents[j];
+			len = le32_to_cpu(extent->len);
+
+			if (len == 0 || len >= U32_MAX)
+				break;
+
+			calculated += len;
+			*valid_extents += 1;
+
+			if (*max_extent_blks < len)
+				*max_extent_blks = len;
+		}
+
+		if (calculated != blks) {
+			SSDFS_ERR("calculated %llu != blks %llu\n",
+				  calculated, blks);
+			return -ERANGE;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_calculate_range_blocks_in_node() - calculate number of blocks in range
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @start_index: starting index of the range
+ * @range_len: number of items in the range
+ * @valid_extents: number of valid extents in the range [out]
+ * @blks_count: number of blocks in the range [out]
+ * @max_extent_blks: maximal number of blocks in one extent [out]
+ *
+ * This method tries to calculate the @valid_extents,
+ * @blks_count, @max_extent_blks in the range inside the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_calculate_range_blocks_in_node(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_items_area *area,
+				    u16 start_index, u16 range_len,
+				    u32 *valid_extents,
+				    u64 *blks_count,
+				    u32 *max_extent_blks)
+{
+	struct ssdfs_raw_fork fork;
+	int i, j;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!valid_extents || !blks_count || !max_extent_blks);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, start_index %u, range_len %u\n",
+		  node->node_id, start_index, range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*valid_extents = 0;
+	*blks_count = 0;
+	*max_extent_blks = 0;
+
+	if (range_len == 0) {
+		SSDFS_WARN("search->request.count == 0\n");
+		return -ERANGE;
+	}
+
+	if ((start_index + range_len) > area->items_count) {
+		SSDFS_ERR("invalid request: "
+			  "start_index %u, range_len %u, items_count %u\n",
+			  start_index, range_len, area->items_count);
+		return -ERANGE;
+	}
+
+	for (i = 0; i < range_len; i++) {
+		int item_index = (int)start_index + i;
+		u64 blks;
+		u64 calculated = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(item_index >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_extents_btree_node_get_fork(node, area,
+							(u16)item_index,
+							&fork);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract fork: "
+				  "item_index %d, err %d\n",
+				  item_index, err);
+			return err;
+		}
+
+		blks = le64_to_cpu(fork.blks_count);
+		if (blks >= U64_MAX || blks == 0) {
+			SSDFS_ERR("corrupted fork: blks_count %llu\n",
+				  blks);
+			return -ERANGE;
+		}
+
+		*blks_count += blks;
+
+		for (j = 0; j < SSDFS_INLINE_EXTENTS_COUNT; j++) {
+			struct ssdfs_raw_extent *extent;
+			u32 len;
+
+			extent = &fork.extents[j];
+			len = le32_to_cpu(extent->len);
+
+			if (len == 0 || len >= U32_MAX)
+				break;
+
+			calculated += len;
+			*valid_extents += 1;
+
+			if (*max_extent_blks < len)
+				*max_extent_blks = len;
+		}
+
+		if (calculated != blks) {
+			SSDFS_ERR("calculated %llu != blks %llu\n",
+				  calculated, blks);
+			return -ERANGE;
+		}
+	}
+
+	return 0;
+}
-- 
2.34.1


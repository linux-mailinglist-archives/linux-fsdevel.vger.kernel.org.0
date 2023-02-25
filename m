Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3D6A2655
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBYBTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBYBRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:34 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509219F2D
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:15 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y184so797965oiy.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2iCXdF1K4+cgfpqgtJ38AKebGSO4Ut1e8fY9wUGoQs=;
        b=hFC1ioGG3m0KB6Q+eLqgec9uxibCudTQvABJBHgIjKS8iLwj9sZfYSNZlL4kuCBDxJ
         4ff7HCgzzjd5PfahyQhzTfvSn2ydDQcEfYsO30bn7oIFYuc6HCsp2O+CquczXK1c8hBl
         eDXoQuUe3ECEEvbemX7RQi/kTkNDzuZ+vG5qtbxoIltS7S0kx6YsAa/gLb4KUKllcVgr
         ls2FWPgfcSj25UyauoYAgkIPvQ9AcyCEi40sw7irskZPozvlDBlLJXiDU2Rl2hbV4MBf
         LWoaNr/cgXqQJjVoUconMrzCmBDN6S4ETjSfpLaH+4N3TzMmq4Ksp2aJD4dKykHqV1rw
         4gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2iCXdF1K4+cgfpqgtJ38AKebGSO4Ut1e8fY9wUGoQs=;
        b=zoYRAD/j5d+xjc/wR6ixLS+3NdmX31faQNLi96jly75QFmxjgV3HMykzSVHQOHr5K8
         04VwBqzu7+DeyBdelWHxROAlRdXXM5rriPFC7QIZ597fVyKvV3on7hB+QrMLXICX4zcI
         Ohs0x+MTIZcFGTuguFkq9ddc/P+OpZ+4j/uQQXhai+kgMnAc34/Nucbf728fmSKWbPCU
         htsI0KBDf8DMC4HvHTPvg1hkJd2mv+i4Ey5ATkrgkgU/ex9n7H7RRoUBAuLrZ1aoWTKc
         /WsvTvX1wzGeW5WOiot1lgc+mQtH0+VsRArKIftuMbA+LNNmAj2qscF1uEmW/vq5GN8F
         OpFA==
X-Gm-Message-State: AO0yUKVIsRQjSjc5Bb+xyOvNyteVifaByo8LmgGYK4M4s/UmpJfhUPnH
        6kK6IvQjLNfVYutj1fopz7DzxAw3M1DLpoxU
X-Google-Smtp-Source: AK7set/yMYcw6tUxnXjHgkSpqnTP696qqzHkMLFq655dkoqamuZF9tHXb/wsjIHAcEgENGDo/mH6xg==
X-Received: by 2002:a05:6808:206:b0:364:858:7e88 with SMTP id l6-20020a056808020600b0036408587e88mr8019614oie.29.1677287834135;
        Fri, 24 Feb 2023 17:17:14 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:13 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 47/76] ssdfs: introduce b-tree object
Date:   Fri, 24 Feb 2023 17:08:58 -0800
Message-Id: <20230225010927.813929-48-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SSDFS file system is using the logical segment, logical extent
concepts, and the "Physical" Erase Blocks (PEB) migration scheme.
Generally speaking, these techniques provide the opportunity
to exclude completely the wandering tree issue and to decrease
significantly the write amplification. SSDFS file system introduces
the technique of storing the data on the basis of logical extent
that describes this data’s position by means of segment ID and
logical block ID. Finally, PEBs migration technique guarantee that
data will be described by the same logical extent until the direct
change of segment ID or logical block ID. As a result, it means that
logical extent will be the same if data is sitting in the same logical
segment. The responsibility of PEBs migration technique is to implement
the continuous migration of data between PEBs inside of the logical
segment for the case of data updates. Generally speaking, SSDFS file
system’s internal techniques guarantee that COW policy will not update
the content of b-tree. But content of b-tree will be updated only by
regular operations of end-user with the file system.

SSDFS file system uses b-tree architecture for metadata representation
(for example, inodes tree, extents tree, dentries tree, xattr tree)
because it provides the compact way of reserving the metadata space
without the necessity to use the excessive overprovisioning of metadata
reservation (for example, in the case of plain table or array).

The b-tree provides the efficient technique of items lookup, especially,
for the case of aged or sparse b-tree that is capable to contain
the mixture of used and deleted (or freed) items. Such b-tree’s feature
could be very useful for the case of extent invalidation, for example.
Also SSDFS file system aggregates the b-tree’s root node in the superblock
(for example, inodes tree case) or in the inode (for example, extents tree
case). As a result, it means that an empty b-tree will contain only
the root node without the necessity to reserve any b-tree’s node on the
file system’s volume. Moreover, if a b-tree needs to contain only several
items (two items, for example) then the root node’s space can be used to
store these items inline without the necessity to create the full-featured
b-tree’s node. As a result, SSDFS uses b-trees with the goal to achieve
the compact representation of metadata, the flexible way to expend or
to shrink the b-tree’s space capacity, and the efficient mechanism of
items’ lookup.

SSDFS file system uses a hybrid b-tree architecture with the goal
to eliminate the index nodes’ side effect. The hybrid b-tree operates
by three node types: (1) index node, (2) hybrid node, (3) leaf node.
Generally speaking, the peculiarity of hybrid node is the mixture
as index as data records into one node. Hybrid b-tree starts with root
node that is capable to keep the two index records or two data records
inline (if size of data record is equal or lesser than size of index
record). If the b-tree needs to contain more than two items then it should
be added the first hybrid node into the b-tree. The root level of
b-tree is able to contain only two nodes because the root node is capable
to store only two index records. Generally speaking, the initial goal of
hybrid node is to store the data records in the presence of reserved
index area.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree.c        | 1020 +++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/btree.h        |  218 +++++++++
 fs/ssdfs/btree_search.c |  885 +++++++++++++++++++++++++++++++++
 fs/ssdfs/btree_search.h |  359 ++++++++++++++
 4 files changed, 2482 insertions(+)
 create mode 100644 fs/ssdfs/btree.c
 create mode 100644 fs/ssdfs/btree.h
 create mode 100644 fs/ssdfs/btree_search.c
 create mode 100644 fs/ssdfs/btree_search.h

diff --git a/fs/ssdfs/btree.c b/fs/ssdfs/btree.c
new file mode 100644
index 000000000000..5780077a1eb9
--- /dev/null
+++ b/fs/ssdfs/btree.c
@@ -0,0 +1,1020 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/btree.c - generalized btree functionality implementation.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "request_queue.h"
+#include "segment_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb_container.h"
+#include "segment.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree_hierarchy.h"
+#include "peb_mapping_table.h"
+#include "btree.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_btree_page_leaks;
+atomic64_t ssdfs_btree_memory_leaks;
+atomic64_t ssdfs_btree_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_btree_cache_leaks_increment(void *kaddr)
+ * void ssdfs_btree_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_btree_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_btree_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_btree_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_btree_kfree(void *kaddr)
+ * struct page *ssdfs_btree_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_btree_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_btree_free_page(struct page *page)
+ * void ssdfs_btree_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(btree)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(btree)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_btree_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_btree_page_leaks, 0);
+	atomic64_set(&ssdfs_btree_memory_leaks, 0);
+	atomic64_set(&ssdfs_btree_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_btree_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_btree_page_leaks) != 0) {
+		SSDFS_ERR("BTREE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_btree_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_btree_memory_leaks) != 0) {
+		SSDFS_ERR("BTREE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_btree_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_btree_cache_leaks) != 0) {
+		SSDFS_ERR("BTREE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_btree_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_btree_radix_tree_insert() - insert node into the radix tree
+ * @tree: btree pointer
+ * @node_id: node ID number
+ * @node: pointer on btree node
+ */
+static
+int ssdfs_btree_radix_tree_insert(struct ssdfs_btree *tree,
+				  unsigned long node_id,
+				  struct ssdfs_btree_node *node)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !node);
+
+	SSDFS_DBG("tree %p, node_id %llu, node %p\n",
+		  tree, (u64)node_id, node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = radix_tree_preload(GFP_NOFS);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to preload radix tree: err %d\n",
+			  err);
+		return err;
+	}
+
+	spin_lock(&tree->nodes_lock);
+	err = radix_tree_insert(&tree->nodes, node_id, node);
+	spin_unlock(&tree->nodes_lock);
+
+	radix_tree_preload_end();
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add node into radix tree: "
+			  "node_id %llu, node %p, err %d\n",
+			  (u64)node_id, node, err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_radix_tree_delete() - delete node from the radix tree
+ * @tree: btree pointer
+ * @node_id: node ID number
+ *
+ * This method tries to delete the node from the radix tree.
+ *
+ * RETURN:
+ * pointer of the node object is deleted from the radix tree
+ */
+static
+struct ssdfs_btree_node *ssdfs_btree_radix_tree_delete(struct ssdfs_btree *tree,
+							unsigned long node_id)
+{
+	struct ssdfs_btree_node *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+
+	SSDFS_DBG("tree %p, node_id %llu\n",
+		  tree, (u64)node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&tree->nodes_lock);
+	ptr = radix_tree_delete(&tree->nodes, node_id);
+	spin_unlock(&tree->nodes_lock);
+
+	return ptr;
+}
+
+/*
+ * ssdfs_btree_radix_tree_find() - find the node into the radix tree
+ * @tree: btree pointer
+ * @node_id: node ID number
+ * @node: pointer on btree node pointer [out]
+ *
+ * This method tries to find node in the radix tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOENT     - tree doesn't contain the requested node.
+ */
+int ssdfs_btree_radix_tree_find(struct ssdfs_btree *tree,
+				unsigned long node_id,
+				struct ssdfs_btree_node **node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !node);
+
+	SSDFS_DBG("tree %p, node_id %llu\n",
+		  tree, (u64)node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&tree->nodes_lock);
+	*node = radix_tree_lookup(&tree->nodes, node_id);
+	spin_unlock(&tree->nodes_lock);
+
+	if (!*node) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find the node: id %llu\n",
+			  (u64)node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static
+int __ssdfs_btree_find_item(struct ssdfs_btree *tree,
+			    struct ssdfs_btree_search *search);
+
+/*
+ * ssdfs_btree_desc_init() - init the btree's descriptor
+ * @fsi: pointer on shared file system object
+ * @tree: pointer on inodes btree object
+ * @desc: pointer on btree's descriptor
+ * @min_item_size: minimal possible item size
+ * @max_item_size: maximal possible item size
+ */
+int ssdfs_btree_desc_init(struct ssdfs_fs_info *fsi,
+			  struct ssdfs_btree *tree,
+			  struct ssdfs_btree_descriptor *desc,
+			  u8 min_item_size,
+			  u16 max_item_size)
+{
+	size_t index_size = sizeof(struct ssdfs_btree_index_key);
+	u32 pagesize;
+	u32 node_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !desc);
+
+	SSDFS_DBG("tree %p, desc %p\n",
+		  tree, desc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pagesize = fsi->pagesize;
+	node_size = 1 << desc->log_node_size;
+
+	if (node_size != (pagesize * desc->pages_per_node)) {
+		SSDFS_ERR("invalid pages_per_node: "
+			  "node_size %u, page_size %u, pages_per_node %u\n",
+			  node_size, pagesize, desc->pages_per_node);
+		return -EIO;
+	}
+
+	if (desc->node_ptr_size != index_size) {
+		SSDFS_ERR("invalid node_ptr_size %u\n",
+			  desc->node_ptr_size);
+		return -EIO;
+	}
+
+	if (le16_to_cpu(desc->index_size) != index_size) {
+		SSDFS_ERR("invalid index_size %u\n",
+			  le16_to_cpu(desc->index_size));
+		return -EIO;
+	}
+
+	tree->type = desc->type;
+	atomic_set(&tree->flags, le16_to_cpu(desc->flags));
+	tree->node_size = node_size;
+	tree->pages_per_node = desc->pages_per_node;
+	tree->node_ptr_size = desc->node_ptr_size;
+	tree->index_size = le16_to_cpu(desc->index_size);
+	tree->item_size = le16_to_cpu(desc->item_size);
+	tree->min_item_size = min_item_size;
+	tree->max_item_size = max_item_size;
+	tree->index_area_min_size = le16_to_cpu(desc->index_area_min_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("type %#x, node_size %u, "
+		  "index_size %u, item_size %u\n",
+		  tree->type, tree->node_size,
+		  tree->index_size, tree->item_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_create() - create generalized btree object
+ * @fsi: pointer on shared file system object
+ * @desc_ops: pointer on btree descriptor operations
+ * @btree_ops: pointer on btree operations
+ * @tree: pointer on memory for btree creation
+ *
+ * This method tries to create inodes btree object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_create(struct ssdfs_fs_info *fsi,
+		    u64 owner_ino,
+		    const struct ssdfs_btree_descriptor_operations *desc_ops,
+		    const struct ssdfs_btree_operations *btree_ops,
+		    struct ssdfs_btree *tree)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !desc_ops || !tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, owner_ino %llu, "
+		  "desc_ops %p, btree_ops %p, tree %p\n",
+		  fsi, owner_ino, desc_ops, btree_ops, tree);
+#else
+	SSDFS_DBG("fsi %p, owner_ino %llu, "
+		  "desc_ops %p, btree_ops %p, tree %p\n",
+		  fsi, owner_ino, desc_ops, btree_ops, tree);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	atomic_set(&tree->state, SSDFS_BTREE_UNKNOWN_STATE);
+
+	tree->owner_ino = owner_ino;
+
+	tree->fsi = fsi;
+	tree->desc_ops = desc_ops;
+	tree->btree_ops = btree_ops;
+
+	if (!desc_ops->init) {
+		SSDFS_ERR("empty btree descriptor init operation\n");
+		return -ERANGE;
+	}
+
+	err = desc_ops->init(fsi, tree);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init btree descriptor: err %d\n",
+			  err);
+		return err;
+	}
+
+	atomic_set(&tree->height, U8_MAX);
+
+	init_rwsem(&tree->lock);
+	spin_lock_init(&tree->nodes_lock);
+	tree->upper_node_id = SSDFS_BTREE_ROOT_NODE_ID;
+	INIT_RADIX_TREE(&tree->nodes, GFP_ATOMIC);
+
+	if (!btree_ops && !btree_ops->create_root_node)
+		SSDFS_WARN("empty create_root_node method\n");
+	else {
+		struct ssdfs_btree_node *node;
+
+		node = ssdfs_btree_node_create(tree,
+						SSDFS_BTREE_ROOT_NODE_ID,
+						NULL,
+						SSDFS_BTREE_LEAF_NODE_HEIGHT,
+						SSDFS_BTREE_ROOT_NODE,
+						U64_MAX);
+		if (unlikely(IS_ERR_OR_NULL(node))) {
+			err = !node ? -ENOMEM : PTR_ERR(node);
+			SSDFS_ERR("fail to create root node: err %d\n",
+				  err);
+			return err;
+		}
+
+		err = btree_ops->create_root_node(fsi, node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init the root node\n");
+			goto finish_root_node_creation;
+		}
+
+		err = ssdfs_btree_radix_tree_insert(tree,
+						    SSDFS_BTREE_ROOT_NODE_ID,
+						    node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert node into radix tree: "
+				  "err %d\n",
+				  err);
+			goto finish_root_node_creation;
+		}
+
+finish_root_node_creation:
+		if (unlikely(err)) {
+			ssdfs_btree_node_destroy(node);
+			return err;
+		}
+	}
+
+	atomic_set(&tree->state, SSDFS_BTREE_CREATED);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_destroy() - destroy generalized btree object
+ * @tree: btree object
+ */
+void ssdfs_btree_destroy(struct ssdfs_btree *tree)
+{
+	int tree_state;
+	struct radix_tree_iter iter;
+	void **slot;
+	struct ssdfs_btree_node *node;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, type %#x, state %#x\n",
+		  tree, tree->type, tree_state);
+#else
+	SSDFS_DBG("tree %p, type %#x, state %#x\n",
+		  tree, tree->type, tree_state);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (tree_state) {
+	case SSDFS_BTREE_CREATED:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_DIRTY:
+		if (!is_ssdfs_btree_empty(tree)) {
+			/* complain */
+			SSDFS_WARN("tree is dirty\n");
+		} else {
+			/* regular destroy */
+			atomic_set(&tree->state, SSDFS_BTREE_UNKNOWN_STATE);
+		}
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#else
+		SSDFS_WARN("invalid tree state %#x\n",
+			   tree_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return;
+	}
+
+	if (rwsem_is_locked(&tree->lock)) {
+		/* inform about possible trouble */
+		SSDFS_WARN("tree is locked under destruction\n");
+	}
+
+	spin_lock(&tree->nodes_lock);
+	radix_tree_for_each_slot(slot, &tree->nodes, &iter,
+				 SSDFS_BTREE_ROOT_NODE_ID) {
+		node =
+		    (struct ssdfs_btree_node *)radix_tree_delete(&tree->nodes,
+								 iter.index);
+
+		spin_unlock(&tree->nodes_lock);
+		if (!node) {
+			SSDFS_WARN("empty node pointer: "
+				   "index %llu\n",
+				   (u64)iter.index);
+		} else {
+			if (tree->btree_ops && tree->btree_ops->destroy_node)
+				tree->btree_ops->destroy_node(node);
+
+			ssdfs_btree_node_destroy(node);
+		}
+		spin_lock(&tree->nodes_lock);
+	}
+	spin_unlock(&tree->nodes_lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * ssdfs_btree_desc_flush() - generalized btree's descriptor flush method
+ * @tree: btree object
+ * @desc: pointer on btree's descriptor [out]
+ */
+int ssdfs_btree_desc_flush(struct ssdfs_btree *tree,
+			   struct ssdfs_btree_descriptor *desc)
+{
+	u32 pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !desc);
+
+	SSDFS_DBG("owner_ino %llu, type %#x, state %#x\n",
+		  tree->owner_ino, tree->type,
+		  atomic_read(&tree->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pagesize = tree->fsi->pagesize;
+
+	if (tree->node_size != (pagesize * tree->pages_per_node)) {
+		SSDFS_ERR("invalid pages_per_node: "
+			  "node_size %u, page_size %u, pages_per_node %u\n",
+			  tree->node_size, pagesize, tree->pages_per_node);
+		return -ERANGE;
+	}
+
+	if (tree->node_ptr_size != sizeof(struct ssdfs_btree_index_key)) {
+		SSDFS_ERR("invalid node_ptr_size %u\n",
+			  tree->node_ptr_size);
+		return -ERANGE;
+	}
+
+	if (tree->index_size != sizeof(struct ssdfs_btree_index_key)) {
+		SSDFS_ERR("invalid index_size %u\n",
+			  tree->index_size);
+		return -ERANGE;
+	}
+
+	desc->flags = cpu_to_le16(atomic_read(&tree->flags));
+	desc->type = tree->type;
+	desc->log_node_size = ilog2(tree->node_size);
+	desc->pages_per_node = tree->pages_per_node;
+	desc->node_ptr_size = tree->node_ptr_size;
+	desc->index_size = cpu_to_le16(tree->index_size);
+	desc->index_area_min_size = cpu_to_le16(tree->index_area_min_size);
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_flush_nolock() - flush the current state of btree object
+ * @tree: btree object
+ *
+ * This method tries to flush dirty nodes of the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_flush_nolock(struct ssdfs_btree *tree)
+{
+	struct radix_tree_iter iter;
+	void **slot;
+	struct ssdfs_btree_node *node;
+	int tree_height, cur_height;
+	struct ssdfs_segment_request *req;
+	wait_queue_head_t *wq = NULL;
+	const atomic_t *state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, type %#x, state %#x\n",
+		  tree, tree->type, atomic_read(&tree->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cur_height = SSDFS_BTREE_LEAF_NODE_HEIGHT;
+	tree_height = atomic_read(&tree->height);
+
+	for (; cur_height < tree_height; cur_height++) {
+		rcu_read_lock();
+
+		spin_lock(&tree->nodes_lock);
+		radix_tree_for_each_tagged(slot, &tree->nodes, &iter,
+					   SSDFS_BTREE_ROOT_NODE_ID,
+					   SSDFS_BTREE_NODE_DIRTY_TAG) {
+
+			node = SSDFS_BTN(radix_tree_deref_slot(slot));
+			if (unlikely(!node)) {
+				SSDFS_WARN("empty node ptr: node_id %llu\n",
+					   (u64)iter.index);
+				radix_tree_tag_clear(&tree->nodes, iter.index,
+						SSDFS_BTREE_NODE_DIRTY_TAG);
+				continue;
+			}
+			spin_unlock(&tree->nodes_lock);
+
+			ssdfs_btree_node_get(node);
+
+			rcu_read_unlock();
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (atomic_read(&node->height) != cur_height) {
+				ssdfs_btree_node_put(node);
+				rcu_read_lock();
+				spin_lock(&tree->nodes_lock);
+				continue;
+			}
+
+			if (!is_ssdfs_btree_node_pre_deleted(node)) {
+				err = ssdfs_btree_node_pre_flush(node);
+				if (unlikely(err)) {
+					ssdfs_btree_node_put(node);
+					SSDFS_ERR("fail to pre-flush node: "
+						  "node_id %llu, err %d\n",
+						  (u64)iter.index, err);
+					goto finish_flush_tree_nodes;
+				}
+
+				err = ssdfs_btree_node_flush(node);
+				if (unlikely(err)) {
+					ssdfs_btree_node_put(node);
+					SSDFS_ERR("fail to flush node: "
+						  "node_id %llu, err %d\n",
+						  (u64)iter.index, err);
+					goto finish_flush_tree_nodes;
+				}
+			}
+
+			rcu_read_lock();
+
+			spin_lock(&tree->nodes_lock);
+			radix_tree_tag_clear(&tree->nodes, iter.index,
+					     SSDFS_BTREE_NODE_DIRTY_TAG);
+			radix_tree_tag_set(&tree->nodes, iter.index,
+					   SSDFS_BTREE_NODE_TOWRITE_TAG);
+
+			ssdfs_btree_node_put(node);
+		}
+		spin_unlock(&tree->nodes_lock);
+
+		rcu_read_unlock();
+	}
+
+	cur_height = SSDFS_BTREE_LEAF_NODE_HEIGHT;
+
+	for (; cur_height < tree_height; cur_height++) {
+		rcu_read_lock();
+
+		spin_lock(&tree->nodes_lock);
+		radix_tree_for_each_tagged(slot, &tree->nodes, &iter,
+					   SSDFS_BTREE_ROOT_NODE_ID,
+					   SSDFS_BTREE_NODE_TOWRITE_TAG) {
+
+			node = SSDFS_BTN(radix_tree_deref_slot(slot));
+			if (unlikely(!node)) {
+				SSDFS_WARN("empty node ptr: node_id %llu\n",
+					   (u64)iter.index);
+				radix_tree_tag_clear(&tree->nodes, iter.index,
+						SSDFS_BTREE_NODE_TOWRITE_TAG);
+				continue;
+			}
+			spin_unlock(&tree->nodes_lock);
+
+			ssdfs_btree_node_get(node);
+
+			rcu_read_unlock();
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (atomic_read(&node->height) != cur_height) {
+				ssdfs_btree_node_put(node);
+				rcu_read_lock();
+				spin_lock(&tree->nodes_lock);
+				continue;
+			}
+
+			if (is_ssdfs_btree_node_pre_deleted(node)) {
+				ssdfs_btree_node_put(node);
+				rcu_read_lock();
+				spin_lock(&tree->nodes_lock);
+				continue;
+			}
+
+check_flush_result_state:
+			state = &node->flush_req.result.state;
+
+			switch (atomic_read(state)) {
+			case SSDFS_REQ_CREATED:
+			case SSDFS_REQ_STARTED:
+				req = &node->flush_req;
+				wq = &req->private.wait_queue;
+
+				err = wait_event_killable_timeout(*wq,
+					    has_request_been_executed(req),
+					    SSDFS_DEFAULT_TIMEOUT);
+				if (err < 0)
+					WARN_ON(err < 0);
+				else
+					err = 0;
+
+				goto check_flush_result_state;
+				break;
+
+			case SSDFS_REQ_FINISHED:
+				/* do nothing */
+				break;
+
+			case SSDFS_REQ_FAILED:
+				ssdfs_btree_node_put(node);
+				err = node->flush_req.result.err;
+
+				if (!err) {
+					err = -ERANGE;
+					SSDFS_ERR("error code is absent\n");
+				}
+
+				SSDFS_ERR("flush request is failed: "
+					  "err %d\n", err);
+				goto finish_flush_tree_nodes;
+
+			default:
+				ssdfs_btree_node_put(node);
+				err = -ERANGE;
+				SSDFS_ERR("invalid result's state %#x\n",
+				    atomic_read(&node->flush_req.result.state));
+				goto finish_flush_tree_nodes;
+			}
+
+			rcu_read_lock();
+
+			spin_lock(&tree->nodes_lock);
+			ssdfs_btree_node_put(node);
+		}
+		spin_unlock(&tree->nodes_lock);
+
+		rcu_read_unlock();
+	}
+
+	cur_height = SSDFS_BTREE_LEAF_NODE_HEIGHT;
+
+	for (; cur_height < tree_height; cur_height++) {
+		rcu_read_lock();
+
+		spin_lock(&tree->nodes_lock);
+		radix_tree_for_each_slot(slot, &tree->nodes, &iter,
+					   SSDFS_BTREE_ROOT_NODE_ID) {
+
+			node = SSDFS_BTN(radix_tree_deref_slot(slot));
+			if (unlikely(!node)) {
+				SSDFS_WARN("empty node ptr: node_id %llu\n",
+					   (u64)iter.index);
+				radix_tree_tag_clear(&tree->nodes, iter.index,
+						SSDFS_BTREE_NODE_TOWRITE_TAG);
+				continue;
+			}
+			spin_unlock(&tree->nodes_lock);
+
+			ssdfs_btree_node_get(node);
+
+			rcu_read_unlock();
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (atomic_read(&node->height) != cur_height) {
+				ssdfs_btree_node_put(node);
+				rcu_read_lock();
+				spin_lock(&tree->nodes_lock);
+				continue;
+			}
+
+			if (atomic_read(&node->type) == SSDFS_BTREE_ROOT_NODE) {
+				/*
+				 * Root node is inline.
+				 * Commit log operation is not necessary.
+				 */
+				ssdfs_btree_node_put(node);
+				rcu_read_lock();
+				spin_lock(&tree->nodes_lock);
+				continue;
+			}
+
+			if (is_ssdfs_btree_node_pre_deleted(node))
+				err = ssdfs_btree_deleted_node_commit_log(node);
+			else
+				err = ssdfs_btree_node_commit_log(node);
+
+			if (unlikely(err)) {
+				ssdfs_btree_node_put(node);
+				SSDFS_ERR("fail to request commit log: "
+					  "node_id %llu, err %d\n",
+					  (u64)iter.index, err);
+				goto finish_flush_tree_nodes;
+			}
+
+			rcu_read_lock();
+
+			spin_lock(&tree->nodes_lock);
+			ssdfs_btree_node_put(node);
+		}
+		spin_unlock(&tree->nodes_lock);
+
+		rcu_read_unlock();
+	}
+
+	cur_height = SSDFS_BTREE_LEAF_NODE_HEIGHT;
+
+	for (; cur_height < tree_height; cur_height++) {
+		rcu_read_lock();
+
+		spin_lock(&tree->nodes_lock);
+		radix_tree_for_each_slot(slot, &tree->nodes, &iter,
+					   SSDFS_BTREE_ROOT_NODE_ID) {
+
+			node = SSDFS_BTN(radix_tree_deref_slot(slot));
+			if (unlikely(!node)) {
+				SSDFS_WARN("empty node ptr: node_id %llu\n",
+					   (u64)iter.index);
+				radix_tree_tag_clear(&tree->nodes, iter.index,
+						SSDFS_BTREE_NODE_TOWRITE_TAG);
+				continue;
+			}
+			spin_unlock(&tree->nodes_lock);
+
+			ssdfs_btree_node_get(node);
+
+			rcu_read_unlock();
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (atomic_read(&node->height) != cur_height) {
+				ssdfs_btree_node_put(node);
+				rcu_read_lock();
+				spin_lock(&tree->nodes_lock);
+				continue;
+			}
+
+			if (atomic_read(&node->type) == SSDFS_BTREE_ROOT_NODE) {
+				/*
+				 * Root node is inline.
+				 * Commit log operation is not necessary.
+				 */
+				goto clear_towrite_tag;
+			}
+
+			if (is_ssdfs_btree_node_pre_deleted(node))
+				goto clear_towrite_tag;
+
+check_commit_log_result_state:
+			state = &node->flush_req.result.state;
+
+			switch (atomic_read(state)) {
+			case SSDFS_REQ_CREATED:
+			case SSDFS_REQ_STARTED:
+				req = &node->flush_req;
+				wq = &req->private.wait_queue;
+
+				err = wait_event_killable_timeout(*wq,
+					    has_request_been_executed(req),
+					    SSDFS_DEFAULT_TIMEOUT);
+				if (err < 0)
+					WARN_ON(err < 0);
+				else
+					err = 0;
+
+				goto check_commit_log_result_state;
+				break;
+
+			case SSDFS_REQ_FINISHED:
+				/* do nothing */
+				break;
+
+			case SSDFS_REQ_FAILED:
+				ssdfs_btree_node_put(node);
+				err = node->flush_req.result.err;
+
+				if (!err) {
+					err = -ERANGE;
+					SSDFS_ERR("error code is absent\n");
+				}
+
+				SSDFS_ERR("flush request is failed: "
+					  "err %d\n", err);
+				goto finish_flush_tree_nodes;
+
+			default:
+				ssdfs_btree_node_put(node);
+				err = -ERANGE;
+				SSDFS_ERR("invalid result's state %#x\n",
+				    atomic_read(&node->flush_req.result.state));
+				goto finish_flush_tree_nodes;
+			}
+
+clear_towrite_tag:
+			rcu_read_lock();
+			spin_lock(&tree->nodes_lock);
+
+			radix_tree_tag_clear(&tree->nodes, iter.index,
+					     SSDFS_BTREE_NODE_TOWRITE_TAG);
+
+			ssdfs_btree_node_put(node);
+
+			spin_unlock(&tree->nodes_lock);
+			rcu_read_unlock();
+
+			if (is_ssdfs_btree_node_pre_deleted(node)) {
+				clear_ssdfs_btree_node_pre_deleted(node);
+
+				ssdfs_btree_radix_tree_delete(tree,
+							node->node_id);
+
+				if (tree->btree_ops &&
+				    tree->btree_ops->delete_node) {
+					err = tree->btree_ops->delete_node(node);
+					if (unlikely(err)) {
+						SSDFS_ERR("delete node failure: "
+							  "err %d\n", err);
+					}
+				}
+
+				if (tree->btree_ops &&
+				    tree->btree_ops->destroy_node)
+					tree->btree_ops->destroy_node(node);
+
+				ssdfs_btree_node_destroy(node);
+			}
+
+			rcu_read_lock();
+			spin_lock(&tree->nodes_lock);
+		}
+		spin_unlock(&tree->nodes_lock);
+
+		rcu_read_unlock();
+	}
+
+finish_flush_tree_nodes:
+	if (unlikely(err))
+		goto finish_btree_flush;
+
+	if (tree->desc_ops && tree->desc_ops->flush) {
+		err = tree->desc_ops->flush(tree);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to flush tree descriptor: "
+				  "err %d\n",
+				  err);
+			goto finish_btree_flush;
+		}
+	}
+
+	atomic_set(&tree->state, SSDFS_BTREE_CREATED);
+
+finish_btree_flush:
+	return err;
+}
+
+/*
+ * ssdfs_btree_flush() - flush the current state of btree object
+ * @tree: btree object
+ *
+ * This method tries to flush dirty nodes of the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_flush(struct ssdfs_btree *tree)
+{
+	int tree_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_state = atomic_read(&tree->state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, type %#x, state %#x\n",
+		  tree, tree->type, tree_state);
+#else
+	SSDFS_DBG("tree %p, type %#x, state %#x\n",
+		  tree, tree->type, tree_state);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (tree_state) {
+	case SSDFS_BTREE_CREATED:
+		/* do nothing */
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("btree %#x is not dirty\n",
+			  tree->type);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+
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
+	down_write(&tree->lock);
+	err = ssdfs_btree_flush_nolock(tree);
+	up_write(&tree->lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to flush btree: err %d\n",
+			  err);
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
diff --git a/fs/ssdfs/btree.h b/fs/ssdfs/btree.h
new file mode 100644
index 000000000000..40009755d016
--- /dev/null
+++ b/fs/ssdfs/btree.h
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/btree.h - btree declarations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#ifndef _SSDFS_BTREE_H
+#define _SSDFS_BTREE_H
+
+struct ssdfs_btree;
+
+/*
+ * struct ssdfs_btree_descriptor_operations - btree descriptor operations
+ * @init: initialize btree object by descriptor
+ * @flush: save btree descriptor into superblock
+ */
+struct ssdfs_btree_descriptor_operations {
+	int (*init)(struct ssdfs_fs_info *fsi,
+		    struct ssdfs_btree *tree);
+	int (*flush)(struct ssdfs_btree *tree);
+};
+
+/*
+ * struct ssdfs_btree_operations - btree operations specialization
+ * @create_root_node: specialization of root node creation
+ * @create_node: specialization of node's construction operation
+ * @init_node: specialization of node's init operation
+ * @destroy_node: specialization of node's destroy operation
+ * @add_node: specialization of adding into the tree a new empty node
+ * @delete_node: specialization of deletion a node from the tree
+ * @pre_flush_root_node: specialized flush preparation of root node
+ * @flush_root_node: specialized method of root node flushing
+ * @pre_flush_node: specialized flush preparation of common node
+ * @flush_node: specialized method of common node flushing
+ */
+struct ssdfs_btree_operations {
+	int (*create_root_node)(struct ssdfs_fs_info *fsi,
+				struct ssdfs_btree_node *node);
+	int (*create_node)(struct ssdfs_btree_node *node);
+	int (*init_node)(struct ssdfs_btree_node *node);
+	void (*destroy_node)(struct ssdfs_btree_node *node);
+	int (*add_node)(struct ssdfs_btree_node *node);
+	int (*delete_node)(struct ssdfs_btree_node *node);
+	int (*pre_flush_root_node)(struct ssdfs_btree_node *node);
+	int (*flush_root_node)(struct ssdfs_btree_node *node);
+	int (*pre_flush_node)(struct ssdfs_btree_node *node);
+	int (*flush_node)(struct ssdfs_btree_node *node);
+};
+
+/*
+ * struct ssdfs_btree - generic btree
+ * @type: btree type
+ * @owner_ino: inode identification number of btree owner
+ * @node_size: size of the node in bytes
+ * @pages_per_node: physical pages per node
+ * @node_ptr_size: size in bytes of pointer on btree node
+ * @index_size: size in bytes of btree's index
+ * @item_size: default size of item in bytes
+ * @min_item_size: min size of item in bytes
+ * @max_item_size: max possible size of item in bytes
+ * @index_area_min_size: minimal size in bytes of index area in btree node
+ * @create_cno: btree's create checkpoint
+ * @state: btree state
+ * @flags: btree flags
+ * @height: current height of the tree
+ * @lock: btree's lock
+ * @nodes_lock: radix tree lock
+ * @upper_node_id: last allocated node id
+ * @nodes: nodes' radix tree
+ * @fsi: pointer on shared file system object
+ *
+ * Btree nodes are organized by radix tree.
+ * Another good point about radix tree is
+ * supporting of knowledge about dirty items.
+ */
+struct ssdfs_btree {
+	/* static data */
+	u8 type;
+	u64 owner_ino;
+	u32 node_size;
+	u8 pages_per_node;
+	u8 node_ptr_size;
+	u16 index_size;
+	u16 item_size;
+	u8 min_item_size;
+	u16 max_item_size;
+	u16 index_area_min_size;
+	u64 create_cno;
+
+	/* operation specializations */
+	const struct ssdfs_btree_descriptor_operations *desc_ops;
+	const struct ssdfs_btree_operations *btree_ops;
+
+	/* mutable data */
+	atomic_t state;
+	atomic_t flags;
+	atomic_t height;
+
+	struct rw_semaphore lock;
+
+	spinlock_t nodes_lock;
+	u32 upper_node_id;
+	struct radix_tree_root nodes;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+/* Btree object states */
+enum {
+	SSDFS_BTREE_UNKNOWN_STATE,
+	SSDFS_BTREE_CREATED,
+	SSDFS_BTREE_DIRTY,
+	SSDFS_BTREE_STATE_MAX
+};
+
+/* Radix tree tags */
+#define SSDFS_BTREE_NODE_DIRTY_TAG	PAGECACHE_TAG_DIRTY
+#define SSDFS_BTREE_NODE_TOWRITE_TAG	PAGECACHE_TAG_TOWRITE
+
+/*
+ * Btree API
+ */
+int ssdfs_btree_create(struct ssdfs_fs_info *fsi,
+		    u64 owner_ino,
+		    const struct ssdfs_btree_descriptor_operations *desc_ops,
+		    const struct ssdfs_btree_operations *btree_ops,
+		    struct ssdfs_btree *tree);
+void ssdfs_btree_destroy(struct ssdfs_btree *tree);
+int ssdfs_btree_flush(struct ssdfs_btree *tree);
+
+int ssdfs_btree_find_item(struct ssdfs_btree *tree,
+			  struct ssdfs_btree_search *search);
+int ssdfs_btree_find_range(struct ssdfs_btree *tree,
+			   struct ssdfs_btree_search *search);
+bool is_ssdfs_btree_empty(struct ssdfs_btree *tree);
+int ssdfs_btree_allocate_item(struct ssdfs_btree *tree,
+			      struct ssdfs_btree_search *search);
+int ssdfs_btree_allocate_range(struct ssdfs_btree *tree,
+				struct ssdfs_btree_search *search);
+int ssdfs_btree_add_item(struct ssdfs_btree *tree,
+			 struct ssdfs_btree_search *search);
+int ssdfs_btree_add_range(struct ssdfs_btree *tree,
+			  struct ssdfs_btree_search *search);
+int ssdfs_btree_change_item(struct ssdfs_btree *tree,
+			    struct ssdfs_btree_search *search);
+int ssdfs_btree_delete_item(struct ssdfs_btree *tree,
+			    struct ssdfs_btree_search *search);
+int ssdfs_btree_delete_range(struct ssdfs_btree *tree,
+			     struct ssdfs_btree_search *search);
+int ssdfs_btree_delete_all(struct ssdfs_btree *tree);
+
+/*
+ * Internal Btree API
+ */
+bool need_migrate_generic2inline_btree(struct ssdfs_btree *tree,
+					int items_threshold);
+int ssdfs_btree_desc_init(struct ssdfs_fs_info *fsi,
+			  struct ssdfs_btree *tree,
+			  struct ssdfs_btree_descriptor *desc,
+			  u8 min_item_size,
+			  u16 max_item_size);
+int ssdfs_btree_desc_flush(struct ssdfs_btree *tree,
+			   struct ssdfs_btree_descriptor *desc);
+struct ssdfs_btree_node *
+ssdfs_btree_get_child_node_for_hash(struct ssdfs_btree *tree,
+				    struct ssdfs_btree_node *parent,
+				    u64 hash);
+int ssdfs_btree_update_parent_node_pointer(struct ssdfs_btree *tree,
+					   struct ssdfs_btree_node *parent);
+int ssdfs_btree_add_node(struct ssdfs_btree *tree,
+			 struct ssdfs_btree_search *search);
+int ssdfs_btree_insert_node(struct ssdfs_btree *tree,
+			    struct ssdfs_btree_search *search);
+int ssdfs_btree_delete_node(struct ssdfs_btree *tree,
+			    struct ssdfs_btree_search *search);
+int ssdfs_btree_get_head_range(struct ssdfs_btree *tree,
+				u32 expected_len,
+				struct ssdfs_btree_search *search);
+int ssdfs_btree_extract_range(struct ssdfs_btree *tree,
+				u16 start_index, u16 count,
+				struct ssdfs_btree_search *search);
+int ssdfs_btree_destroy_node_range(struct ssdfs_btree *tree,
+				   u64 start_hash);
+struct ssdfs_btree_node *
+__ssdfs_btree_read_node(struct ssdfs_btree *tree,
+			struct ssdfs_btree_node *parent,
+			struct ssdfs_btree_index_key *node_index,
+			u8 node_type, u32 node_id);
+int ssdfs_btree_radix_tree_find(struct ssdfs_btree *tree,
+				unsigned long node_id,
+				struct ssdfs_btree_node **node);
+int ssdfs_btree_synchronize_root_node(struct ssdfs_btree *tree,
+				struct ssdfs_btree_inline_root_node *root);
+int ssdfs_btree_get_next_hash(struct ssdfs_btree *tree,
+			      struct ssdfs_btree_search *search,
+			      u64 *next_hash);
+
+void ssdfs_debug_show_btree_node_indexes(struct ssdfs_btree *tree,
+					 struct ssdfs_btree_node *parent);
+void ssdfs_check_btree_consistency(struct ssdfs_btree *tree);
+void ssdfs_debug_btree_object(struct ssdfs_btree *tree);
+
+#endif /* _SSDFS_BTREE_H */
diff --git a/fs/ssdfs/btree_search.c b/fs/ssdfs/btree_search.c
new file mode 100644
index 000000000000..27eb262690de
--- /dev/null
+++ b/fs/ssdfs/btree_search.c
@@ -0,0 +1,885 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/btree_search.c - btree search object functionality.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "btree_search.h"
+#include "btree_node.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_btree_search_page_leaks;
+atomic64_t ssdfs_btree_search_memory_leaks;
+atomic64_t ssdfs_btree_search_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_btree_search_cache_leaks_increment(void *kaddr)
+ * void ssdfs_btree_search_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_btree_search_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_btree_search_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_btree_search_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_btree_search_kfree(void *kaddr)
+ * struct page *ssdfs_btree_search_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_btree_search_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_btree_search_free_page(struct page *page)
+ * void ssdfs_btree_search_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(btree_search)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(btree_search)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_btree_search_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_btree_search_page_leaks, 0);
+	atomic64_set(&ssdfs_btree_search_memory_leaks, 0);
+	atomic64_set(&ssdfs_btree_search_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_btree_search_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_btree_search_page_leaks) != 0) {
+		SSDFS_ERR("BTREE SEARCH: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_btree_search_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_btree_search_memory_leaks) != 0) {
+		SSDFS_ERR("BTREE SEARCH: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_btree_search_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_btree_search_cache_leaks) != 0) {
+		SSDFS_ERR("BTREE SEARCH: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_btree_search_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/******************************************************************************
+ *                       BTREE SEARCH OBJECT CACHE                            *
+ ******************************************************************************/
+
+static struct kmem_cache *ssdfs_btree_search_obj_cachep;
+
+void ssdfs_zero_btree_search_obj_cache_ptr(void)
+{
+	ssdfs_btree_search_obj_cachep = NULL;
+}
+
+static void ssdfs_init_btree_search_object_once(void *obj)
+{
+	struct ssdfs_btree_search *search_obj = obj;
+
+	memset(search_obj, 0, sizeof(struct ssdfs_btree_search));
+}
+
+void ssdfs_shrink_btree_search_obj_cache(void)
+{
+	if (ssdfs_btree_search_obj_cachep)
+		kmem_cache_shrink(ssdfs_btree_search_obj_cachep);
+}
+
+void ssdfs_destroy_btree_search_obj_cache(void)
+{
+	if (ssdfs_btree_search_obj_cachep)
+		kmem_cache_destroy(ssdfs_btree_search_obj_cachep);
+}
+
+int ssdfs_init_btree_search_obj_cache(void)
+{
+	ssdfs_btree_search_obj_cachep =
+		kmem_cache_create_usercopy("ssdfs_btree_search_obj_cache",
+				sizeof(struct ssdfs_btree_search), 0,
+				SLAB_RECLAIM_ACCOUNT |
+				SLAB_MEM_SPREAD |
+				SLAB_ACCOUNT,
+				offsetof(struct ssdfs_btree_search, raw),
+				sizeof(union ssdfs_btree_search_raw_data) +
+				sizeof(struct ssdfs_name_string),
+				ssdfs_init_btree_search_object_once);
+	if (!ssdfs_btree_search_obj_cachep) {
+		SSDFS_ERR("unable to create btree search objects cache\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/******************************************************************************
+ *                      BTREE SEARCH OBJECT FUNCTIONALITY                     *
+ ******************************************************************************/
+
+/*
+ * ssdfs_btree_search_alloc() - allocate memory for btree search object
+ */
+struct ssdfs_btree_search *ssdfs_btree_search_alloc(void)
+{
+	struct ssdfs_btree_search *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_btree_search_obj_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = kmem_cache_alloc(ssdfs_btree_search_obj_cachep, GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate memory for btree search object\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ssdfs_btree_search_cache_leaks_increment(ptr);
+
+	return ptr;
+}
+
+/*
+ * ssdfs_btree_search_free() - free memory for btree search object
+ */
+void ssdfs_btree_search_free(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_btree_search_obj_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!search)
+		return;
+
+	if (search->node.parent) {
+		ssdfs_btree_node_put(search->node.parent);
+		search->node.parent = NULL;
+	}
+
+	if (search->node.child) {
+		ssdfs_btree_node_put(search->node.child);
+		search->node.child = NULL;
+	}
+
+	search->node.state = SSDFS_BTREE_SEARCH_NODE_DESC_EMPTY;
+
+	ssdfs_btree_search_free_result_buf(search);
+	ssdfs_btree_search_free_result_name(search);
+
+	ssdfs_btree_search_cache_leaks_decrement(search);
+	kmem_cache_free(ssdfs_btree_search_obj_cachep, search);
+}
+
+/*
+ * ssdfs_btree_search_init() - init btree search object
+ * @search: btree search object [out]
+ */
+void ssdfs_btree_search_init(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_btree_search_free_result_buf(search);
+	ssdfs_btree_search_free_result_name(search);
+
+	if (search->node.parent) {
+		ssdfs_btree_node_put(search->node.parent);
+		search->node.parent = NULL;
+	}
+
+	if (search->node.child) {
+		ssdfs_btree_node_put(search->node.child);
+		search->node.child = NULL;
+	}
+
+	memset(search, 0, sizeof(struct ssdfs_btree_search));
+	search->request.type = SSDFS_BTREE_SEARCH_UNKNOWN_TYPE;
+	search->node.state = SSDFS_BTREE_SEARCH_NODE_DESC_EMPTY;
+	search->result.state = SSDFS_BTREE_SEARCH_UNKNOWN_RESULT;
+	search->result.err = 0;
+	search->result.buf = NULL;
+	search->result.buf_state = SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+	search->result.name = NULL;
+	search->result.name_state = SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+}
+
+/*
+ * need_initialize_btree_search() - check necessity to init the search object
+ * @search: btree search object
+ */
+bool need_initialize_btree_search(struct ssdfs_btree_search *search)
+{
+	bool need_initialize = false;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_UNKNOWN_RESULT:
+	case SSDFS_BTREE_SEARCH_FAILURE:
+	case SSDFS_BTREE_SEARCH_EMPTY_RESULT:
+	case SSDFS_BTREE_SEARCH_OBSOLETE_RESULT:
+		need_initialize = true;
+		break;
+
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_FIND_ITEM:
+		case SSDFS_BTREE_SEARCH_FIND_RANGE:
+		case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+		case SSDFS_BTREE_SEARCH_MOVE_ITEM:
+		case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+		case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+		case SSDFS_BTREE_SEARCH_DELETE_ALL:
+		case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+			need_initialize = false;
+			break;
+
+		case SSDFS_BTREE_SEARCH_ALLOCATE_ITEM:
+		case SSDFS_BTREE_SEARCH_ALLOCATE_RANGE:
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+		case SSDFS_BTREE_SEARCH_ADD_RANGE:
+			need_initialize = true;
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_ERR("search->request.type %#x\n",
+				  search->request.type);
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+		};
+		break;
+
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ALLOCATE_ITEM:
+		case SSDFS_BTREE_SEARCH_ALLOCATE_RANGE:
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+		case SSDFS_BTREE_SEARCH_ADD_RANGE:
+			need_initialize = false;
+			break;
+
+		case SSDFS_BTREE_SEARCH_FIND_ITEM:
+		case SSDFS_BTREE_SEARCH_FIND_RANGE:
+		case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+		case SSDFS_BTREE_SEARCH_MOVE_ITEM:
+		case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+		case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+		case SSDFS_BTREE_SEARCH_DELETE_ALL:
+		case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+			need_initialize = true;
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_ERR("search->request.type %#x\n",
+				  search->request.type);
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+		};
+		break;
+
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+			need_initialize = false;
+			break;
+
+		case SSDFS_BTREE_SEARCH_FIND_ITEM:
+		case SSDFS_BTREE_SEARCH_FIND_RANGE:
+		case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+		case SSDFS_BTREE_SEARCH_MOVE_ITEM:
+		case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+		case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+		case SSDFS_BTREE_SEARCH_DELETE_ALL:
+		case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+			need_initialize = true;
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_ERR("search->request.type %#x\n",
+				  search->request.type);
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+		};
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_ERR("search->result.state %#x\n",
+			  search->result.state);
+		BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+	};
+
+	return need_initialize;
+}
+
+/*
+ * is_btree_search_request_valid() - check validity of search request
+ * @search: btree search object
+ */
+bool is_btree_search_request_valid(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_FIND_ITEM:
+	case SSDFS_BTREE_SEARCH_FIND_RANGE:
+	case SSDFS_BTREE_SEARCH_ALLOCATE_ITEM:
+	case SSDFS_BTREE_SEARCH_ALLOCATE_RANGE:
+	case SSDFS_BTREE_SEARCH_ADD_ITEM:
+	case SSDFS_BTREE_SEARCH_ADD_RANGE:
+	case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+	case SSDFS_BTREE_SEARCH_MOVE_ITEM:
+	case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_ALL:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		/* valid type */
+		break;
+
+	default:
+		SSDFS_WARN("invalid search request type %#x\n",
+			   search->request.type);
+		return false;
+	};
+
+	if (search->request.flags & ~SSDFS_BTREE_SEARCH_REQUEST_FLAGS_MASK) {
+		SSDFS_WARN("invalid flags set: %#x\n",
+			   search->request.flags);
+		return false;
+	}
+
+	if (search->request.start.hash == U64_MAX) {
+		SSDFS_WARN("invalid start_hash\n");
+		return false;
+	} else if (search->request.start.hash > search->request.end.hash) {
+		SSDFS_WARN("invalid range: "
+			   "start_hash %llx, end_hash %llx\n",
+			   search->request.start.hash,
+			   search->request.end.hash);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * is_btree_index_search_request_valid() - check index node search request
+ * @search: btree search object
+ * @prev_node_id: node ID from previous search
+ * @prev_node_height: node height from previous search
+ */
+bool is_btree_index_search_request_valid(struct ssdfs_btree_search *search,
+					 u32 prev_node_id,
+					 u8 prev_node_height)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+	BUG_ON(prev_node_id == SSDFS_BTREE_NODE_INVALID_ID);
+	BUG_ON(prev_node_height == U8_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_btree_search_request_valid(search))
+		return false;
+
+	if (prev_node_id == search->node.id)
+		return false;
+
+	if (search->node.height != (prev_node_height - 1))
+		return false;
+
+	if (search->node.state != SSDFS_BTREE_SEARCH_FOUND_INDEX_NODE_DESC)
+		return false;
+
+	return true;
+}
+
+/*
+ * is_btree_leaf_node_found() - check that leaf btree node has been found
+ * @search: btree search object
+ */
+bool is_btree_leaf_node_found(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->node.state != SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC)
+		return false;
+
+	if (search->node.id == SSDFS_BTREE_NODE_INVALID_ID)
+		return false;
+
+	if (search->node.child == NULL)
+		return false;
+
+	return true;
+}
+
+/*
+ * is_btree_search_node_desc_consistent() - check node descriptor consistency
+ * @search: btree search object
+ */
+bool is_btree_search_node_desc_consistent(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->node.state != SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC) {
+		SSDFS_ERR("unexpected search->node.state %#x\n",
+			  search->node.state);
+		return false;
+	}
+
+	if (!search->node.parent) {
+		SSDFS_ERR("search->node.parent is NULL\n");
+		return false;
+	}
+
+	if (!search->node.child) {
+		SSDFS_ERR("search->node.child is NULL\n");
+		return false;
+	}
+
+	if (search->node.id != search->node.child->node_id) {
+		SSDFS_ERR("search->node.id %u != search->node.child->node_id %u\n",
+			  search->node.id, search->node.child->node_id);
+		return false;
+	}
+
+	if (search->node.height != atomic_read(&search->node.child->height)) {
+		SSDFS_ERR("invalid height: "
+			  "search->node.height %u, "
+			  "search->node.child->height %d\n",
+			  search->node.height,
+			  atomic_read(&search->node.child->height));
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * ssdfs_btree_search_define_child_node() - define child node for the search
+ * @search: search object
+ * @child: child node object
+ */
+void ssdfs_btree_search_define_child_node(struct ssdfs_btree_search *search,
+					  struct ssdfs_btree_node *child)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->node.child)
+		ssdfs_btree_node_put(search->node.child);
+
+	search->node.child = child;
+
+	if (search->node.child)
+		ssdfs_btree_node_get(search->node.child);
+}
+
+/*
+ * ssdfs_btree_search_forget_child_node() - forget child node for the search
+ * @search: search object
+ */
+void ssdfs_btree_search_forget_child_node(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->node.child) {
+		ssdfs_btree_node_put(search->node.child);
+		search->node.child = NULL;
+		search->node.state = SSDFS_BTREE_SEARCH_NODE_DESC_EMPTY;
+	}
+}
+
+/*
+ * ssdfs_btree_search_define_parent_node() - define parent node for the search
+ * @search: search object
+ * @parent: parent node object
+ */
+void ssdfs_btree_search_define_parent_node(struct ssdfs_btree_search *search,
+					   struct ssdfs_btree_node *parent)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->node.parent)
+		ssdfs_btree_node_put(search->node.parent);
+
+	search->node.parent = parent;
+
+	if (search->node.parent)
+		ssdfs_btree_node_get(search->node.parent);
+}
+
+/*
+ * ssdfs_btree_search_forget_parent_node() - forget parent node for the search
+ * @search: search object
+ */
+void ssdfs_btree_search_forget_parent_node(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->node.parent) {
+		ssdfs_btree_node_put(search->node.parent);
+		search->node.parent = NULL;
+		search->node.state = SSDFS_BTREE_SEARCH_NODE_DESC_EMPTY;
+	}
+}
+
+/*
+ * ssdfs_btree_search_alloc_result_buf() - allocate result buffer
+ * @search: search object
+ * @buf_size: buffer size
+ */
+int ssdfs_btree_search_alloc_result_buf(struct ssdfs_btree_search *search,
+					size_t buf_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->result.buf = ssdfs_btree_search_kzalloc(buf_size, GFP_KERNEL);
+	if (!search->result.buf) {
+		SSDFS_ERR("fail to allocate buffer: size %zu\n",
+			  buf_size);
+		return -ENOMEM;
+	}
+
+	search->result.buf_size = buf_size;
+	search->result.buf_state = SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER;
+	search->result.items_in_buffer = 0;
+	return 0;
+}
+
+/*
+ * ssdfs_btree_search_free_result_buf() - free result buffer
+ * @search: search object
+ */
+void ssdfs_btree_search_free_result_buf(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->result.buf_state == SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER) {
+		if (search->result.buf) {
+			ssdfs_btree_search_kfree(search->result.buf);
+			search->result.buf = NULL;
+			search->result.buf_state =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+		}
+	}
+}
+
+/*
+ * ssdfs_btree_search_alloc_result_name() - allocate result name
+ * @search: search object
+ * @string_size: name string size
+ */
+int ssdfs_btree_search_alloc_result_name(struct ssdfs_btree_search *search,
+					 size_t string_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->result.name = ssdfs_btree_search_kzalloc(string_size,
+							 GFP_KERNEL);
+	if (!search->result.name) {
+		SSDFS_ERR("fail to allocate buffer: size %zu\n",
+			  string_size);
+		return -ENOMEM;
+	}
+
+	search->result.name_string_size = string_size;
+	search->result.name_state = SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER;
+	search->result.names_in_buffer = 0;
+	return 0;
+}
+
+/*
+ * ssdfs_btree_search_free_result_name() - free result name
+ * @search: search object
+ */
+void ssdfs_btree_search_free_result_name(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->result.name_state == SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER) {
+		if (search->result.name) {
+			ssdfs_btree_search_kfree(search->result.name);
+			search->result.name = NULL;
+			search->result.name =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+		}
+	}
+}
+
+void ssdfs_debug_btree_search_object(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct ssdfs_btree_index_key *node_index;
+	struct ssdfs_shdict_ltbl2_item *ltbl2_item;
+	size_t item_size;
+	size_t count;
+	int i;
+
+	BUG_ON(!search);
+
+	SSDFS_DBG("REQUEST: type %#x, flags %#x, count %u, "
+		  "START: name %p, name_len %zu, hash %llx, ino %llu, "
+		  "END: name %p, name_len %zu, hash %llx, ino %llu\n",
+		  search->request.type,
+		  search->request.flags,
+		  search->request.count,
+		  search->request.start.name,
+		  search->request.start.name_len,
+		  search->request.start.hash,
+		  search->request.start.ino,
+		  search->request.end.name,
+		  search->request.end.name_len,
+		  search->request.end.hash,
+		  search->request.end.ino);
+
+	SSDFS_DBG("NODE: state %#x, id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->node.state,
+		  search->node.id,
+		  search->node.height,
+		  search->node.parent,
+		  search->node.child);
+
+	node_index = &search->node.found_index;
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
+
+	if (search->node.parent) {
+		SSDFS_DBG("PARENT NODE: node_id %u, state %#x, "
+			  "type %#x, height %d, refs_count %d\n",
+			  search->node.parent->node_id,
+			  atomic_read(&search->node.parent->state),
+			  atomic_read(&search->node.parent->type),
+			  atomic_read(&search->node.parent->height),
+			  atomic_read(&search->node.parent->refs_count));
+	}
+
+	if (search->node.child) {
+		SSDFS_DBG("CHILD NODE: node_id %u, state %#x, "
+			  "type %#x, height %d, refs_count %d\n",
+			  search->node.child->node_id,
+			  atomic_read(&search->node.child->state),
+			  atomic_read(&search->node.child->type),
+			  atomic_read(&search->node.child->height),
+			  atomic_read(&search->node.child->refs_count));
+	}
+
+	SSDFS_DBG("RESULT: state %#x, err %d, start_index %u, count %u, "
+		  "search_cno %llu\n",
+		  search->result.state,
+		  search->result.err,
+		  search->result.start_index,
+		  search->result.count,
+		  search->result.search_cno);
+
+	SSDFS_DBG("NAME: name_state %#x, name %p, "
+		  "name_string_size %zu, names_in_buffer %u\n",
+		  search->result.name_state,
+		  search->result.name,
+		  search->result.name_string_size,
+		  search->result.names_in_buffer);
+
+	SSDFS_DBG("LOOKUP: index %u, hash_lo %u, "
+		  "start_index %u, range_len %u\n",
+		  search->name.lookup.index,
+		  le32_to_cpu(search->name.lookup.desc.hash_lo),
+		  le16_to_cpu(search->name.lookup.desc.start_index),
+		  le16_to_cpu(search->name.lookup.desc.range_len));
+
+	ltbl2_item = &search->name.strings_range.desc;
+	SSDFS_DBG("STRINGS_RANGE: index %u, hash_lo %u, "
+		  "prefix_len %u, str_count %u, "
+		  "hash_index %u\n",
+		  search->name.strings_range.index,
+		  le32_to_cpu(ltbl2_item->hash_lo),
+		  ltbl2_item->prefix_len,
+		  ltbl2_item->str_count,
+		  le16_to_cpu(ltbl2_item->hash_index));
+
+	SSDFS_DBG("PREFIX: index %u, hash_hi %u, "
+		  "str_offset %u, str_len %u, type %#x\n",
+		  search->name.prefix.index,
+		  le32_to_cpu(search->name.prefix.desc.hash_hi),
+		  le16_to_cpu(search->name.prefix.desc.str_offset),
+		  search->name.prefix.desc.str_len,
+		  search->name.prefix.desc.type);
+
+	SSDFS_DBG("LEFT_NAME: index %u, hash_hi %u, "
+		  "str_offset %u, str_len %u, type %#x\n",
+		  search->name.left_name.index,
+		  le32_to_cpu(search->name.left_name.desc.hash_hi),
+		  le16_to_cpu(search->name.left_name.desc.str_offset),
+		  search->name.left_name.desc.str_len,
+		  search->name.left_name.desc.type);
+
+	SSDFS_DBG("RIGHT_NAME: index %u, hash_hi %u, "
+		  "str_offset %u, str_len %u, type %#x\n",
+		  search->name.right_name.index,
+		  le32_to_cpu(search->name.right_name.desc.hash_hi),
+		  le16_to_cpu(search->name.right_name.desc.str_offset),
+		  search->name.right_name.desc.str_len,
+		  search->name.right_name.desc.type);
+
+	if (search->result.name) {
+		count = search->result.names_in_buffer;
+
+		if (count > 0)
+			item_size = search->result.name_string_size / count;
+		else
+			item_size = 0;
+
+		for (i = 0; i < search->result.names_in_buffer; i++) {
+			struct ssdfs_name_string *name;
+			u8 *addr;
+
+			addr = (u8 *)search->result.name + (i * item_size);
+			name = (struct ssdfs_name_string *)addr;
+
+			SSDFS_DBG("NAME: index %d, hash %llx, str_len %zu\n",
+				  i, name->hash, name->len);
+
+			SSDFS_DBG("LOOKUP: index %u, hash_lo %u, "
+				  "start_index %u, range_len %u\n",
+				  name->lookup.index,
+				  le32_to_cpu(name->lookup.desc.hash_lo),
+				  le16_to_cpu(name->lookup.desc.start_index),
+				  le16_to_cpu(name->lookup.desc.range_len));
+
+			ltbl2_item = &name->strings_range.desc;
+			SSDFS_DBG("STRINGS_RANGE: index %u, hash_lo %u, "
+				  "prefix_len %u, str_count %u, "
+				  "hash_index %u\n",
+				  name->strings_range.index,
+				  le32_to_cpu(ltbl2_item->hash_lo),
+				  ltbl2_item->prefix_len,
+				  ltbl2_item->str_count,
+				  le16_to_cpu(ltbl2_item->hash_index));
+
+			SSDFS_DBG("PREFIX: index %u, hash_hi %u, "
+				  "str_offset %u, str_len %u, type %#x\n",
+				  name->prefix.index,
+				  le32_to_cpu(name->prefix.desc.hash_hi),
+				  le16_to_cpu(name->prefix.desc.str_offset),
+				  name->prefix.desc.str_len,
+				  name->prefix.desc.type);
+
+			SSDFS_DBG("LEFT_NAME: index %u, hash_hi %u, "
+				  "str_offset %u, str_len %u, type %#x\n",
+				  name->left_name.index,
+				  le32_to_cpu(name->left_name.desc.hash_hi),
+				  le16_to_cpu(name->left_name.desc.str_offset),
+				  name->left_name.desc.str_len,
+				  name->left_name.desc.type);
+
+			SSDFS_DBG("RIGHT_NAME: index %u, hash_hi %u, "
+				  "str_offset %u, str_len %u, type %#x\n",
+				  name->right_name.index,
+				  le32_to_cpu(name->right_name.desc.hash_hi),
+				  le16_to_cpu(name->right_name.desc.str_offset),
+				  name->right_name.desc.str_len,
+				  name->right_name.desc.type);
+
+			SSDFS_DBG("RAW STRING DUMP: index %d\n",
+				  i);
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+						name->str,
+						name->len);
+			SSDFS_DBG("\n");
+		}
+	}
+
+	SSDFS_DBG("RESULT BUFFER: buf_state %#x, buf %p, "
+		  "buf_size %zu, items_in_buffer %u\n",
+		  search->result.buf_state,
+		  search->result.buf,
+		  search->result.buf_size,
+		  search->result.items_in_buffer);
+
+	if (search->result.buf) {
+		count = search->result.items_in_buffer;
+
+		if (count > 0)
+			item_size = search->result.buf_size / count;
+		else
+			item_size = 0;
+
+		for (i = 0; i < search->result.items_in_buffer; i++) {
+			void *item;
+
+			item = (u8 *)search->result.buf + (i * item_size);
+
+			SSDFS_DBG("RAW BUF DUMP: index %d\n",
+				  i);
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+						item,
+						item_size);
+			SSDFS_DBG("\n");
+		}
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
diff --git a/fs/ssdfs/btree_search.h b/fs/ssdfs/btree_search.h
new file mode 100644
index 000000000000..9fbdb796b4dd
--- /dev/null
+++ b/fs/ssdfs/btree_search.h
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/btree_search.h - btree search object declarations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#ifndef _SSDFS_BTREE_SEARCH_H
+#define _SSDFS_BTREE_SEARCH_H
+
+/* Search request types */
+enum {
+	SSDFS_BTREE_SEARCH_UNKNOWN_TYPE,
+	SSDFS_BTREE_SEARCH_FIND_ITEM,
+	SSDFS_BTREE_SEARCH_FIND_RANGE,
+	SSDFS_BTREE_SEARCH_ALLOCATE_ITEM,
+	SSDFS_BTREE_SEARCH_ALLOCATE_RANGE,
+	SSDFS_BTREE_SEARCH_ADD_ITEM,
+	SSDFS_BTREE_SEARCH_ADD_RANGE,
+	SSDFS_BTREE_SEARCH_CHANGE_ITEM,
+	SSDFS_BTREE_SEARCH_MOVE_ITEM,
+	SSDFS_BTREE_SEARCH_DELETE_ITEM,
+	SSDFS_BTREE_SEARCH_DELETE_RANGE,
+	SSDFS_BTREE_SEARCH_DELETE_ALL,
+	SSDFS_BTREE_SEARCH_INVALIDATE_TAIL,
+	SSDFS_BTREE_SEARCH_TYPE_MAX
+};
+
+/*
+ * struct ssdfs_peb_timestamps - PEB timestamps
+ * @peb_id: PEB ID
+ * @create_time: PEB's create timestamp
+ * @last_log_time: PEB's last log create timestamp
+ */
+struct ssdfs_peb_timestamps {
+	u64 peb_id;
+	u64 create_time;
+	u64 last_log_time;
+};
+
+/*
+ * struct ssdfs_btree_search_hash - btree search hash
+ * @name: name of the searching object
+ * @name_len: length of the name in bytes
+ * @uuid: UUID of the searching object
+ * @hash: hash value
+ * @ino: inode ID
+ * @fingerprint: fingerprint value
+ * @peb2time: PEB timestamps
+ */
+struct ssdfs_btree_search_hash {
+	const char *name;
+	size_t name_len;
+	u8 *uuid;
+	u64 hash;
+	u64 ino;
+	struct ssdfs_fingerprint *fingerprint;
+	struct ssdfs_peb_timestamps *peb2time;
+};
+
+/*
+ * struct ssdfs_btree_search_request - btree search request
+ * @type: request type
+ * @flags: request flags
+ * @start: starting hash value
+ * @end: ending hash value
+ * @count: range of hashes length in the request
+ */
+struct ssdfs_btree_search_request {
+	int type;
+#define SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE		(1 << 0)
+#define SSDFS_BTREE_SEARCH_HAS_VALID_COUNT		(1 << 1)
+#define SSDFS_BTREE_SEARCH_HAS_VALID_NAME		(1 << 2)
+#define SSDFS_BTREE_SEARCH_HAS_VALID_INO		(1 << 3)
+#define SSDFS_BTREE_SEARCH_NOT_INVALIDATE		(1 << 4)
+#define SSDFS_BTREE_SEARCH_HAS_VALID_UUID		(1 << 5)
+#define SSDFS_BTREE_SEARCH_HAS_VALID_FINGERPRINT	(1 << 6)
+#define SSDFS_BTREE_SEARCH_INCREMENT_REF_COUNT		(1 << 7)
+#define SSDFS_BTREE_SEARCH_DECREMENT_REF_COUNT		(1 << 8)
+#define SSDFS_BTREE_SEARCH_INLINE_BUF_HAS_NEW_ITEM	(1 << 9)
+#define SSDFS_BTREE_SEARCH_DONT_EXTRACT_RECORD		(1 << 10)
+#define SSDFS_BTREE_SEARCH_HAS_PEB2TIME_PAIR		(1 << 11)
+#define SSDFS_BTREE_SEARCH_REQUEST_FLAGS_MASK		0xFFF
+	u32 flags;
+
+	struct ssdfs_btree_search_hash start;
+	struct ssdfs_btree_search_hash end;
+	unsigned int count;
+};
+
+/* Node descriptor possible states */
+enum {
+	SSDFS_BTREE_SEARCH_NODE_DESC_EMPTY,
+	SSDFS_BTREE_SEARCH_ROOT_NODE_DESC,
+	SSDFS_BTREE_SEARCH_FOUND_INDEX_NODE_DESC,
+	SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC,
+	SSDFS_BTREE_SEARCH_NODE_DESC_STATE_MAX
+};
+
+/*
+ * struct ssdfs_btree_search_node_desc - btree node descriptor
+ * @state: descriptor state
+ * @id: node ID number
+ * @height: node height
+ * @found_index: index of child node
+ * @parent: last parent node
+ * @child: last child node
+ */
+struct ssdfs_btree_search_node_desc {
+	int state;
+
+	u32 id;
+	u8 height;
+
+	struct ssdfs_btree_index_key found_index;
+	struct ssdfs_btree_node *parent;
+	struct ssdfs_btree_node *child;
+};
+
+/* Search result possible states */
+enum {
+	SSDFS_BTREE_SEARCH_UNKNOWN_RESULT,
+	SSDFS_BTREE_SEARCH_FAILURE,
+	SSDFS_BTREE_SEARCH_EMPTY_RESULT,
+	SSDFS_BTREE_SEARCH_VALID_ITEM,
+	SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND,
+	SSDFS_BTREE_SEARCH_OUT_OF_RANGE,
+	SSDFS_BTREE_SEARCH_OBSOLETE_RESULT,
+	SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE,
+	SSDFS_BTREE_SEARCH_PLEASE_DELETE_NODE,
+	SSDFS_BTREE_SEARCH_PLEASE_MOVE_BUF_CONTENT,
+	SSDFS_BTREE_SEARCH_RESULT_STATE_MAX
+};
+
+/* Search result buffer possible states */
+enum {
+	SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE,
+	SSDFS_BTREE_SEARCH_INLINE_BUFFER,
+	SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER,
+	SSDFS_BTREE_SEARCH_BUFFER_STATE_MAX
+};
+
+/*
+ * struct ssdfs_lookup_descriptor - lookup descriptor
+ * @index: index of item in the lookup1 table
+ * @desc: descriptor of lookup1 table's item
+ */
+struct ssdfs_lookup_descriptor {
+	u16 index;
+	struct ssdfs_shdict_ltbl1_item desc;
+};
+
+/*
+ * struct ssdfs_strings_range_descriptor - strings range descriptor
+ * @index: index of item in the lookup2 table
+ * @desc: descriptor of lookup2 table's item
+ */
+struct ssdfs_strings_range_descriptor {
+	u16 index;
+	struct ssdfs_shdict_ltbl2_item desc;
+};
+
+/*
+ * struct ssdfs_string_descriptor - string descriptor
+ * @index: index of item in the hash table
+ * @desc: descriptor of hash table's item
+ */
+struct ssdfs_string_descriptor {
+	u16 index;
+	struct ssdfs_shdict_htbl_item desc;
+};
+
+/*
+ * struct ssdfs_string_table_index - string table indexes
+ * @lookup1_index: index in lookup1 table
+ * @lookup2_index: index in lookup2 table
+ * @hash_index: index in hash table
+ *
+ * Search operation defines lookup, strings_range, prefix,
+ * left_name, and right_name. This information contains
+ * potential position to store the string. However,
+ * the final position to insert string and indexes can
+ * be defined during the insert operation. This field
+ * keeps the knowledge of finally used indexes to store
+ * the string and lookup1, lookup2, hash indexes.
+ */
+struct ssdfs_string_table_index {
+	u16 lookup1_index;
+	u16 lookup2_index;
+	u16 hash_index;
+};
+
+/*
+ * struct ssdfs_name_string - name string
+ * @hash: name hash
+ * @lookup: lookup item descriptor
+ * @strings_range: range of strings descriptor
+ * @prefix: prefix descriptor
+ * @left_name: left name descriptor
+ * @right_name: right name descriptor
+ * @placement: stored indexes descriptor
+ * @len: name length
+ * @str: name buffer
+ */
+struct ssdfs_name_string {
+	u64 hash;
+	struct ssdfs_lookup_descriptor lookup;
+	struct ssdfs_strings_range_descriptor strings_range;
+	struct ssdfs_string_descriptor prefix;
+	struct ssdfs_string_descriptor left_name;
+	struct ssdfs_string_descriptor right_name;
+
+	struct ssdfs_string_table_index placement;
+
+	size_t len;
+	unsigned char str[SSDFS_MAX_NAME_LEN];
+};
+
+/*
+ * struct ssdfs_btree_search_result - btree search result
+ * @state: result state
+ * @err: result error code
+ * @start_index: starting found item index
+ * @count: count of found items
+ * @search_cno: checkpoint of search activity
+ * @name_state: state of the name buffer
+ * @name: pointer on buffer with name(s)
+ * @name_string_size: size of the buffer in bytes
+ * @names_in_buffer: count of names in buffer
+ * @buf_state: state of the buffer
+ * @buf: pointer on buffer with item(s)
+ * @buf_size: size of the buffer in bytes
+ * @items_in_buffer: count of items in buffer
+ */
+struct ssdfs_btree_search_result {
+	int state;
+	int err;
+
+	u16 start_index;
+	u16 count;
+
+	u64 search_cno;
+
+	int name_state;
+	struct ssdfs_name_string *name;
+	size_t name_string_size;
+	u32 names_in_buffer;
+
+	int buf_state;
+	void *buf;
+	size_t buf_size;
+	u32 items_in_buffer;
+};
+
+/* Position check results */
+enum {
+	SSDFS_CORRECT_POSITION,
+	SSDFS_SEARCH_LEFT_DIRECTION,
+	SSDFS_SEARCH_RIGHT_DIRECTION,
+	SSDFS_CHECK_POSITION_FAILURE
+};
+
+/*
+ * struct ssdfs_btree_search - btree search
+ * @request: search request
+ * @node: btree node descriptor
+ * @result: search result
+ * @raw.fork: raw fork buffer
+ * @raw.inode: raw inode buffer
+ * @raw.dentry.header: raw directory entry header
+ * @raw.xattr.header: raw xattr entry header
+ * @raw.shared_extent: shared extent buffer
+ * @raw.snapshot: raw snapshot info buffer
+ * @raw.peb2time: raw PEB2time set
+ * @raw.invalidated_extent: invalidated extent buffer
+ * @name: name string
+ */
+struct ssdfs_btree_search {
+	struct ssdfs_btree_search_request request;
+	struct ssdfs_btree_search_node_desc node;
+	struct ssdfs_btree_search_result result;
+	union ssdfs_btree_search_raw_data {
+		struct ssdfs_raw_fork fork;
+		struct ssdfs_inode inode;
+		struct ssdfs_raw_dentry {
+			struct ssdfs_dir_entry header;
+		} dentry;
+		struct ssdfs_raw_xattr {
+			struct ssdfs_xattr_entry header;
+		} xattr;
+		struct ssdfs_shared_extent shared_extent;
+		struct ssdfs_snapshot snapshot;
+		struct ssdfs_peb2time_set peb2time;
+		struct ssdfs_raw_extent invalidated_extent;
+	} raw;
+	struct ssdfs_name_string name;
+};
+
+/* Btree height's classification */
+enum {
+	SSDFS_BTREE_PARENT2LEAF_HEIGHT		= 1,
+	SSDFS_BTREE_PARENT2HYBRID_HEIGHT	= 2,
+	SSDFS_BTREE_PARENT2INDEX_HEIGHT		= 3,
+};
+
+/*
+ * Inline functions
+ */
+
+static inline
+bool is_btree_search_contains_new_item(struct ssdfs_btree_search *search)
+{
+	return search->request.flags &
+			SSDFS_BTREE_SEARCH_INLINE_BUF_HAS_NEW_ITEM;
+}
+
+/*
+ * Btree search object API
+ */
+struct ssdfs_btree_search *ssdfs_btree_search_alloc(void);
+void ssdfs_btree_search_free(struct ssdfs_btree_search *search);
+void ssdfs_btree_search_init(struct ssdfs_btree_search *search);
+bool need_initialize_btree_search(struct ssdfs_btree_search *search);
+bool is_btree_search_request_valid(struct ssdfs_btree_search *search);
+bool is_btree_index_search_request_valid(struct ssdfs_btree_search *search,
+					 u32 prev_node_id,
+					 u8 prev_node_height);
+bool is_btree_leaf_node_found(struct ssdfs_btree_search *search);
+bool is_btree_search_node_desc_consistent(struct ssdfs_btree_search *search);
+void ssdfs_btree_search_define_parent_node(struct ssdfs_btree_search *search,
+					   struct ssdfs_btree_node *parent);
+void ssdfs_btree_search_define_child_node(struct ssdfs_btree_search *search,
+					  struct ssdfs_btree_node *child);
+void ssdfs_btree_search_forget_parent_node(struct ssdfs_btree_search *search);
+void ssdfs_btree_search_forget_child_node(struct ssdfs_btree_search *search);
+int ssdfs_btree_search_alloc_result_buf(struct ssdfs_btree_search *search,
+					size_t buf_size);
+void ssdfs_btree_search_free_result_buf(struct ssdfs_btree_search *search);
+int ssdfs_btree_search_alloc_result_name(struct ssdfs_btree_search *search,
+					 size_t string_size);
+void ssdfs_btree_search_free_result_name(struct ssdfs_btree_search *search);
+
+void ssdfs_debug_btree_search_object(struct ssdfs_btree_search *search);
+
+#endif /* _SSDFS_BTREE_SEARCH_H */
-- 
2.34.1


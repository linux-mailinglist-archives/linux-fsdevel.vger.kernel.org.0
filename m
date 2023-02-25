Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1083A6A265F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBYBTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBYBRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:42 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377EB126E3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:35 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bi17so822773oib.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65VcY9PTZgStBDfKE4CcvrEd85eg0uLz589qSj5TVBs=;
        b=sO9CjC8ASbLqbpcTZ9MsfDsOwLI/nDIpQV1llSRBLKA4coH94xeKI+VofBY7bqwfRd
         dLOqF1X/mfcCe5bPosROCBUBbikle4t/086MALMz0JWRTIeXTLG/IqxDsrfBP70j8BKI
         xVFUIaRUWY6p9ME1G0LT8WFwODOE02Oq3LcLt+vObPN236O0o7/dleJ+lmwnAFiFp/rP
         khi6NYv0cnEXbyt56T8l4sR46rVk3VHwbUEJ/Hn0FNTz6CAJKNhi5HEmTsanRDYnQjgQ
         elGTm/QB565B93ZoZ6CWYPEFAVKOimd16Wemtto9dUh6pw2DygSwnEfOPVv2PyIQHE6P
         OMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65VcY9PTZgStBDfKE4CcvrEd85eg0uLz589qSj5TVBs=;
        b=6VAT/dncIicp8Eemkdmkaf9/zSJrZSjNdJeFmHIsr21P5k6Hk+XE9lYXB/XuiV+a4c
         5lxMS1CRWCBQowMdK58l7rZDR5KnoHfolkPu8BPUAP/Rw4Ns/bBLL6el4n5AWzk7U+JQ
         A/LYvKzETNkiTvssbzOc0mRVz6I9UwsNFAR+7tb5jaWoCUD2yD2sfM20k0CnHPoGoKCi
         m4CVtcVBJa3Sbh2Gq8S4Ki17jie1ccriZwr53vV+ysy1xvZykx8/krj/Wc523RB6j6u+
         nOTR5QSJr4q48ZtjF+sNtegDpcF/aSfedvrTlgWu++Otyndbr2/j+JoGGa0FWqGLC4XG
         ofdQ==
X-Gm-Message-State: AO0yUKXp8i/Jn+0cFHZp4FoGfME/UhDfDyYvm3jYhOBmRqJyi4jYvb7+
        MtwrM/o/RQxOeI8lW0hQE3ys13AZDdKhOSjH
X-Google-Smtp-Source: AK7set+lJT/xi5dvkCm8SAYZ9mT/hJkpvyE73pb8W6TGCJv4nolGSM7Ir/pojzkFX1TsgEmK5xspKA==
X-Received: by 2002:aca:1901:0:b0:383:ee1d:f492 with SMTP id l1-20020aca1901000000b00383ee1df492mr2438900oii.9.1677287853613;
        Fri, 24 Feb 2023 17:17:33 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:32 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 56/76] ssdfs: introduce b-tree hierarchy object
Date:   Fri, 24 Feb 2023 17:09:07 -0800
Message-Id: <20230225010927.813929-57-slava@dubeyko.com>
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

B-tree needs to serve the operations of adding items, inserting
items, and deleting items. These operations could require
modification of b-tree structure (adding and deleting nodes).
Also, indexes need to be updated in parent nodes. SSDFS file
system uses the special b-tree hierarchy object to manage
the b-tree structure. For every b-tree modification request,
file system logic creates the hierarchy object and executes
the b-tree hierarchy check. The checking logic defines the actions
that should be done for every level of b-tree to execute b-tree
node's add or delete operation. Finally, b-tree hierarchy object
represents the actions plan that modification logic has to execute.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree_hierarchy.c | 2908 ++++++++++++++++++++++++++++++++++++
 fs/ssdfs/btree_hierarchy.h |  284 ++++
 2 files changed, 3192 insertions(+)
 create mode 100644 fs/ssdfs/btree_hierarchy.c
 create mode 100644 fs/ssdfs/btree_hierarchy.h

diff --git a/fs/ssdfs/btree_hierarchy.c b/fs/ssdfs/btree_hierarchy.c
new file mode 100644
index 000000000000..cba502e6f3a6
--- /dev/null
+++ b/fs/ssdfs/btree_hierarchy.c
@@ -0,0 +1,2908 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/btree_hierarchy.c - btree hierarchy functionality implementation.
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
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb_container.h"
+#include "segment_bitmap.h"
+#include "segment.h"
+#include "extents_queue.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "btree_hierarchy.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_btree_hierarchy_page_leaks;
+atomic64_t ssdfs_btree_hierarchy_memory_leaks;
+atomic64_t ssdfs_btree_hierarchy_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_btree_hierarchy_cache_leaks_increment(void *kaddr)
+ * void ssdfs_btree_hierarchy_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_btree_hierarchy_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_btree_hierarchy_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_btree_hierarchy_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_btree_hierarchy_kfree(void *kaddr)
+ * struct page *ssdfs_btree_hierarchy_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_btree_hierarchy_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_btree_hierarchy_free_page(struct page *page)
+ * void ssdfs_btree_hierarchy_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(btree_hierarchy)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(btree_hierarchy)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_btree_hierarchy_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_btree_hierarchy_page_leaks, 0);
+	atomic64_set(&ssdfs_btree_hierarchy_memory_leaks, 0);
+	atomic64_set(&ssdfs_btree_hierarchy_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_btree_hierarchy_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_btree_hierarchy_page_leaks) != 0) {
+		SSDFS_ERR("BTREE HIERARCHY: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_btree_hierarchy_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_btree_hierarchy_memory_leaks) != 0) {
+		SSDFS_ERR("BTREE HIERARCHY: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_btree_hierarchy_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_btree_hierarchy_cache_leaks) != 0) {
+		SSDFS_ERR("BTREE HIERARCHY: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_btree_hierarchy_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_define_hierarchy_height() - define hierarchy's height
+ * @tree: btree object
+ *
+ * This method tries to define the hierarchy's height.
+ */
+static
+int ssdfs_define_hierarchy_height(struct ssdfs_btree *tree)
+{
+	int tree_height;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_height = atomic_read(&tree->height);
+	if (tree_height < 0) {
+		SSDFS_WARN("invalid tree_height %d\n",
+			   tree_height);
+		tree_height = 0;
+	}
+
+	if (tree_height == 0) {
+		/* root node + child node */
+		tree_height = 2;
+	} else {
+		/* pre-allocate additional level */
+		tree_height += 1;
+	}
+
+	return tree_height;
+}
+
+/*
+ * ssdfs_btree_hierarchy_init() - init hierarchy object
+ * @tree: btree object
+ *
+ * This method tries to init the memory for the hierarchy object.
+ */
+void ssdfs_btree_hierarchy_init(struct ssdfs_btree *tree,
+				struct ssdfs_btree_hierarchy *ptr)
+{
+	int tree_height;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr);
+
+	SSDFS_DBG("hierarchy %p\n", ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_height = ssdfs_define_hierarchy_height(tree);
+
+	ptr->desc.height = tree_height;
+	ptr->desc.increment_height = false;
+	ptr->desc.node_size = tree->node_size;
+	ptr->desc.index_size = tree->index_size;
+	ptr->desc.min_item_size = tree->min_item_size;
+	ptr->desc.max_item_size = tree->max_item_size;
+	ptr->desc.index_area_min_size = tree->index_area_min_size;
+
+	for (i = 0; i < tree_height; i++) {
+		ptr->array_ptr[i]->flags = 0;
+
+		ptr->array_ptr[i]->index_area.area_size = U32_MAX;
+		ptr->array_ptr[i]->index_area.free_space = U32_MAX;
+		ptr->array_ptr[i]->index_area.hash.start = U64_MAX;
+		ptr->array_ptr[i]->index_area.hash.end = U64_MAX;
+		ptr->array_ptr[i]->index_area.add.op_state =
+				SSDFS_BTREE_AREA_OP_UNKNOWN;
+		ptr->array_ptr[i]->index_area.add.hash.start = U64_MAX;
+		ptr->array_ptr[i]->index_area.add.hash.end = U64_MAX;
+		ptr->array_ptr[i]->index_area.add.pos.state =
+				SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED;
+		ptr->array_ptr[i]->index_area.add.pos.start = U16_MAX;
+		ptr->array_ptr[i]->index_area.add.pos.count = 0;
+		ptr->array_ptr[i]->index_area.insert.op_state =
+				SSDFS_BTREE_AREA_OP_UNKNOWN;
+		ptr->array_ptr[i]->index_area.insert.hash.start = U64_MAX;
+		ptr->array_ptr[i]->index_area.insert.hash.end = U64_MAX;
+		ptr->array_ptr[i]->index_area.insert.pos.state =
+				SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED;
+		ptr->array_ptr[i]->index_area.insert.pos.start = U16_MAX;
+		ptr->array_ptr[i]->index_area.insert.pos.count = 0;
+		ptr->array_ptr[i]->index_area.move.op_state =
+				SSDFS_BTREE_AREA_OP_UNKNOWN;
+		ptr->array_ptr[i]->index_area.move.direction =
+					SSDFS_BTREE_MOVE_NOWHERE;
+		ptr->array_ptr[i]->index_area.move.pos.state =
+				SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED;
+		ptr->array_ptr[i]->index_area.move.pos.start = U16_MAX;
+		ptr->array_ptr[i]->index_area.move.pos.count = 0;
+		ptr->array_ptr[i]->index_area.delete.op_state =
+				SSDFS_BTREE_AREA_OP_UNKNOWN;
+		memset(&ptr->array_ptr[i]->index_area.delete.node_index,
+			0xFF, sizeof(struct ssdfs_btree_index_key));
+
+		ptr->array_ptr[i]->items_area.area_size = U32_MAX;
+		ptr->array_ptr[i]->items_area.free_space = U32_MAX;
+		ptr->array_ptr[i]->items_area.hash.start = U64_MAX;
+		ptr->array_ptr[i]->items_area.hash.end = U64_MAX;
+		ptr->array_ptr[i]->items_area.add.op_state =
+				SSDFS_BTREE_AREA_OP_UNKNOWN;
+		ptr->array_ptr[i]->items_area.add.hash.start = U64_MAX;
+		ptr->array_ptr[i]->items_area.add.hash.end = U64_MAX;
+		ptr->array_ptr[i]->items_area.add.pos.state =
+				SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED;
+		ptr->array_ptr[i]->items_area.add.pos.start = U16_MAX;
+		ptr->array_ptr[i]->items_area.add.pos.count = 0;
+		ptr->array_ptr[i]->items_area.insert.op_state =
+				SSDFS_BTREE_AREA_OP_UNKNOWN;
+		ptr->array_ptr[i]->items_area.insert.hash.start = U64_MAX;
+		ptr->array_ptr[i]->items_area.insert.hash.end = U64_MAX;
+		ptr->array_ptr[i]->items_area.insert.pos.state =
+				SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED;
+		ptr->array_ptr[i]->items_area.insert.pos.start = U16_MAX;
+		ptr->array_ptr[i]->items_area.insert.pos.count = 0;
+		ptr->array_ptr[i]->items_area.move.op_state =
+				SSDFS_BTREE_AREA_OP_UNKNOWN;
+		ptr->array_ptr[i]->items_area.move.direction =
+					SSDFS_BTREE_MOVE_NOWHERE;
+		ptr->array_ptr[i]->items_area.move.pos.state =
+				SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED;
+		ptr->array_ptr[i]->items_area.move.pos.start = U16_MAX;
+		ptr->array_ptr[i]->items_area.move.pos.count = 0;
+
+		ptr->array_ptr[i]->nodes.old_node.type =
+				SSDFS_BTREE_NODE_UNKNOWN_TYPE;
+		ptr->array_ptr[i]->nodes.old_node.index_hash.start = U64_MAX;
+		ptr->array_ptr[i]->nodes.old_node.index_hash.end = U64_MAX;
+		ptr->array_ptr[i]->nodes.old_node.items_hash.start = U64_MAX;
+		ptr->array_ptr[i]->nodes.old_node.items_hash.end = U64_MAX;
+		ptr->array_ptr[i]->nodes.old_node.ptr = NULL;
+		ptr->array_ptr[i]->nodes.new_node.type =
+				SSDFS_BTREE_NODE_UNKNOWN_TYPE;
+		ptr->array_ptr[i]->nodes.new_node.index_hash.start = U64_MAX;
+		ptr->array_ptr[i]->nodes.new_node.index_hash.end = U64_MAX;
+		ptr->array_ptr[i]->nodes.new_node.items_hash.start = U64_MAX;
+		ptr->array_ptr[i]->nodes.new_node.items_hash.end = U64_MAX;
+		ptr->array_ptr[i]->nodes.new_node.ptr = NULL;
+	}
+}
+
+/*
+ * ssdfs_btree_hierarchy_allocate() - allocate hierarchy object
+ * @tree: btree object
+ *
+ * This method tries to allocate the memory for the hierarchy object.
+ *
+ * RETURN:
+ * [success] - pointer on the allocated hierarchy object.
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate the memory.
+ */
+struct ssdfs_btree_hierarchy *
+ssdfs_btree_hierarchy_allocate(struct ssdfs_btree *tree)
+{
+	struct ssdfs_btree_hierarchy *ptr;
+	size_t desc_size = sizeof(struct ssdfs_btree_hierarchy);
+	size_t ptr_size = sizeof(struct ssdfs_btree_level *);
+	size_t level_size = sizeof(struct ssdfs_btree_level);
+	int tree_height;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree_height = ssdfs_define_hierarchy_height(tree);
+	if (tree_height <= 0) {
+		SSDFS_ERR("invalid tree_height %d\n",
+			  tree_height);
+		return ERR_PTR(-ERANGE);
+	}
+
+	ptr = ssdfs_btree_hierarchy_kzalloc(desc_size, GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate tree levels' array\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ptr->array_ptr = ssdfs_btree_hierarchy_kzalloc(ptr_size * tree_height,
+							GFP_KERNEL);
+	if (!ptr) {
+		ssdfs_btree_hierarchy_kfree(ptr);
+		SSDFS_ERR("fail to allocate tree levels' array\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < tree_height; i++) {
+		ptr->array_ptr[i] = ssdfs_btree_hierarchy_kzalloc(level_size,
+								  GFP_KERNEL);
+		if (!ptr) {
+			for (--i; i >= 0; i--) {
+				ssdfs_btree_hierarchy_kfree(ptr->array_ptr[i]);
+				ptr->array_ptr[i] = NULL;
+			}
+
+			ssdfs_btree_hierarchy_kfree(ptr->array_ptr);
+			ptr->array_ptr = NULL;
+			ssdfs_btree_hierarchy_kfree(ptr);
+			SSDFS_ERR("fail to allocate tree levels' array\n");
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	ssdfs_btree_hierarchy_init(tree, ptr);
+
+	return ptr;
+}
+
+/*
+ * ssdfs_btree_hierarchy_free() - free the hierarchy object
+ * @hierarchy: pointer on the hierarchy object
+ */
+void ssdfs_btree_hierarchy_free(struct ssdfs_btree_hierarchy *hierarchy)
+{
+	int tree_height;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hierarchy %p\n", hierarchy);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!hierarchy)
+		return;
+
+	tree_height = hierarchy->desc.height;
+
+	for (i = 0; i < tree_height; i++) {
+		ssdfs_btree_hierarchy_kfree(hierarchy->array_ptr[i]);
+		hierarchy->array_ptr[i] = NULL;
+	}
+
+	ssdfs_btree_hierarchy_kfree(hierarchy->array_ptr);
+	hierarchy->array_ptr = NULL;
+
+	ssdfs_btree_hierarchy_kfree(hierarchy);
+}
+
+/*
+ * ssdfs_btree_prepare_add_node() - prepare the level for adding node
+ * @tree: btree object
+ * @node_type: type of adding node
+ * @start_hash: starting hash value
+ * @end_hash: ending hash value
+ * @level: level object [out]
+ * @node: node object [in]
+ */
+void ssdfs_btree_prepare_add_node(struct ssdfs_btree *tree,
+				  int node_type,
+				  u64 start_hash, u64 end_hash,
+				  struct ssdfs_btree_level *level,
+				  struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !level);
+
+	SSDFS_DBG("tree %p, level %p, node_type %#x, "
+		  "start_hash %llx, end_hash %llx\n",
+		  tree, level, node_type, start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	level->flags |= SSDFS_BTREE_LEVEL_ADD_NODE;
+	level->nodes.new_node.type = node_type;
+	level->nodes.old_node.ptr = node;
+
+	level->index_area.area_size = tree->index_area_min_size;
+	level->index_area.free_space = tree->index_area_min_size;
+	level->items_area.area_size =
+			tree->node_size - tree->index_area_min_size;
+	level->items_area.free_space =
+			tree->node_size - tree->index_area_min_size;
+	level->items_area.hash.start = start_hash;
+	level->items_area.hash.end = end_hash;
+}
+
+/*
+ * ssdfs_btree_prepare_add_index() - prepare the level for adding index
+ * @level: level object [out]
+ * @start_hash: starting hash value
+ * @end_hash: ending hash value
+ * @node: node object [in]
+ *
+ * This method tries to prepare the @level for adding the index.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_prepare_add_index(struct ssdfs_btree_level *level,
+				  u64 start_hash, u64 end_hash,
+				  struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree_node_insert *add;
+	int index_area_state;
+	int items_area_state;
+	u32 free_space;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level || !node);
+
+	SSDFS_DBG("level %p, node %p, "
+		  "start_hash %llx, end_hash %llx\n",
+		  level, node, start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (level->flags & SSDFS_BTREE_LEVEL_ADD_NODE) {
+		level->flags |= SSDFS_BTREE_LEVEL_ADD_INDEX;
+
+		add = &level->index_area.add;
+		add->hash.start = start_hash;
+		add->hash.end = end_hash;
+		add->pos.start = 0;
+		add->pos.state = SSDFS_HASH_RANGE_LEFT_ADJACENT;
+		add->pos.count = 1;
+		add->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+		return 0;
+	}
+
+	index_area_state = atomic_read(&node->index_area.state);
+	items_area_state = atomic_read(&node->items_area.state);
+
+	if (index_area_state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		SSDFS_ERR("index area is absent: "
+			  "node_id %u, height %u\n",
+			  node->node_id,
+			  atomic_read(&node->height));
+		return -ERANGE;
+	}
+
+	if (can_add_new_index(node)) {
+		level->flags |= SSDFS_BTREE_LEVEL_ADD_INDEX;
+		level->nodes.old_node.type = atomic_read(&node->type);
+		level->nodes.old_node.ptr = node;
+	} else if (atomic_read(&node->type) == SSDFS_BTREE_ROOT_NODE) {
+		level->flags |= SSDFS_BTREE_LEVEL_ADD_INDEX;
+		level->nodes.new_node.type = atomic_read(&node->type);
+		level->nodes.new_node.ptr = node;
+	} else if (level->flags & SSDFS_BTREE_TRY_RESIZE_INDEX_AREA) {
+		level->flags |= SSDFS_BTREE_LEVEL_ADD_INDEX;
+		level->nodes.new_node.type = atomic_read(&node->type);
+		level->nodes.new_node.ptr = node;
+	} else {
+		SSDFS_ERR("fail to add a new index: "
+			  "node_id %u, height %u\n",
+			  node->node_id,
+			  atomic_read(&node->height));
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+
+	free_space = node->index_area.index_capacity;
+
+	if (node->index_area.index_count > free_space) {
+		err = -ERANGE;
+		SSDFS_ERR("index_count %u > index_capacity %u\n",
+			  node->index_area.index_count,
+			  free_space);
+		goto finish_prepare_level;
+	}
+
+	free_space -= node->index_area.index_count;
+	free_space *= node->index_area.index_size;
+
+	level->index_area.free_space = free_space;
+	level->index_area.area_size = node->index_area.area_size;
+	level->index_area.hash.start = node->index_area.start_hash;
+	level->index_area.hash.end = node->index_area.end_hash;
+
+	if (items_area_state == SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		if (node->items_area.free_space > node->node_size) {
+			err = -ERANGE;
+			SSDFS_ERR("free_space %u > node_size %u\n",
+				  node->items_area.free_space,
+				  node->node_size);
+			goto finish_prepare_level;
+		}
+
+		level->items_area.free_space = node->items_area.free_space;
+		level->items_area.area_size = node->items_area.area_size;
+		level->items_area.hash.start = node->items_area.start_hash;
+		level->items_area.hash.end = node->items_area.end_hash;
+	}
+
+finish_prepare_level:
+	up_read(&node->header_lock);
+
+	if (unlikely(err))
+		return err;
+
+	if (start_hash > end_hash) {
+		SSDFS_ERR("invalid requested hash range: "
+			  "start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		return -ERANGE;
+	}
+
+	add = &level->index_area.add;
+
+	add->hash.start = start_hash;
+	add->hash.end = end_hash;
+
+	err = ssdfs_btree_node_find_index_position(node, start_hash,
+						   &add->pos.start);
+	if (err == -ENODATA) {
+		if (add->pos.start >= U16_MAX) {
+			SSDFS_ERR("fail to find the index position: "
+				  "start_hash %llx, err %d\n",
+				  start_hash, err);
+			return err;
+		} else
+			err = 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find the index position: "
+			  "start_hash %llx, err %d\n",
+			  start_hash, err);
+		return err;
+	} else if (level->index_area.hash.start != start_hash) {
+		/*
+		 * We've received the position of available
+		 * index record. So, correct it for the real
+		 * insert operation.
+		 */
+		add->pos.start++;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "level->index_area.hash.start %llx, "
+		  "level->index_area.hash.end %llx\n",
+		  start_hash, end_hash,
+		  level->index_area.hash.start,
+		  level->index_area.hash.end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (end_hash < level->index_area.hash.start)
+		add->pos.state = SSDFS_HASH_RANGE_LEFT_ADJACENT;
+	else if (start_hash > level->index_area.hash.end)
+		add->pos.state = SSDFS_HASH_RANGE_RIGHT_ADJACENT;
+	else
+		add->pos.state = SSDFS_HASH_RANGE_INTERSECTION;
+
+	add->pos.count = 1;
+	add->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+	return 0;
+}
+
+static inline
+void ssdfs_btree_cancel_add_index(struct ssdfs_btree_level *level)
+{
+	struct ssdfs_btree_node_insert *add;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level);
+
+	SSDFS_DBG("level %p\n", level);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	level->flags &= ~SSDFS_BTREE_LEVEL_ADD_INDEX;
+
+	add = &level->index_area.add;
+
+	add->op_state = SSDFS_BTREE_AREA_OP_UNKNOWN;
+	add->hash.start = U64_MAX;
+	add->hash.end = U64_MAX;
+	add->pos.state = SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED;
+	add->pos.start = U16_MAX;
+	add->pos.count = 0;
+}
+
+/*
+ * ssdfs_btree_prepare_update_index() - prepare the level for index update
+ * @level: level object [out]
+ * @start_hash: starting hash value
+ * @end_hash: ending hash value
+ * @node: node object [in]
+ *
+ * This method tries to prepare the @level for adding the index.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_prepare_update_index(struct ssdfs_btree_level *level,
+				     u64 start_hash, u64 end_hash,
+				     struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree_node_insert *insert;
+	int index_area_state;
+	int items_area_state;
+	u32 free_space;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level || !node);
+
+	SSDFS_DBG("level %p, start_hash %llx, "
+		  "end_hash %llx, node %p\n",
+		  level, start_hash, end_hash, node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	level->flags |= SSDFS_BTREE_LEVEL_UPDATE_INDEX;
+	level->nodes.old_node.type = atomic_read(&node->type);
+	level->nodes.old_node.ptr = node;
+
+	index_area_state = atomic_read(&node->index_area.state);
+	items_area_state = atomic_read(&node->items_area.state);
+
+	if (index_area_state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		SSDFS_ERR("index area is absent: "
+			  "node_id %u, height %u\n",
+			  node->node_id,
+			  atomic_read(&node->height));
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+
+	free_space = node->index_area.index_capacity;
+
+	if (node->index_area.index_count > free_space) {
+		err = -ERANGE;
+		SSDFS_ERR("index_count %u > index_capacity %u\n",
+			  node->index_area.index_count,
+			  free_space);
+		goto finish_prepare_level;
+	}
+
+	free_space -= node->index_area.index_count;
+	free_space *= node->index_area.index_size;
+
+	level->index_area.free_space = free_space;
+	level->index_area.area_size = node->index_area.area_size;
+	level->index_area.hash.start = node->index_area.start_hash;
+	level->index_area.hash.end = node->index_area.end_hash;
+
+	if (start_hash > end_hash) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid range: start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		goto finish_prepare_level;
+	}
+
+	if (!(level->index_area.hash.start <= start_hash &&
+	      end_hash <= level->index_area.hash.end)) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid hash range "
+			  "(start_hash %llx, end_hash %llx), "
+			  "node (start_hash %llx, end_hash %llx)\n",
+			  start_hash, end_hash,
+			  level->index_area.hash.start,
+			  level->index_area.hash.end);
+		goto finish_prepare_level;
+	}
+
+	if (items_area_state == SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		if (node->items_area.free_space > node->node_size) {
+			err = -ERANGE;
+			SSDFS_ERR("free_space %u > node_size %u\n",
+				  node->items_area.free_space,
+				  node->node_size);
+			goto finish_prepare_level;
+		}
+
+		level->items_area.free_space = node->items_area.free_space;
+		level->items_area.area_size = node->items_area.area_size;
+		level->index_area.hash.start = node->items_area.start_hash;
+		level->index_area.hash.end = node->items_area.end_hash;
+	}
+
+finish_prepare_level:
+	up_read(&node->header_lock);
+
+	if (unlikely(err))
+		return err;
+
+	insert = &level->index_area.insert;
+	err = ssdfs_btree_node_find_index_position(node, start_hash,
+						   &insert->pos.start);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find the index position: "
+			  "start_hash %llx, err %d\n",
+			  start_hash, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "level->index_area.hash.start %llx, "
+		  "level->index_area.hash.end %llx\n",
+		  start_hash, end_hash,
+		  level->index_area.hash.start,
+		  level->index_area.hash.end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (end_hash < level->index_area.hash.start)
+		insert->pos.state = SSDFS_HASH_RANGE_LEFT_ADJACENT;
+	else if (start_hash > level->index_area.hash.end)
+		insert->pos.state = SSDFS_HASH_RANGE_RIGHT_ADJACENT;
+	else
+		insert->pos.state = SSDFS_HASH_RANGE_INTERSECTION;
+
+	insert->pos.count = 1;
+	insert->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+	return 0;
+}
+
+/*
+ * ssdfs_btree_prepare_do_nothing() - prepare the level for to do nothing
+ * @level: level object [out]
+ * @node: node object [in]
+ *
+ * This method tries to prepare the @level for to do nothing.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_prepare_do_nothing(struct ssdfs_btree_level *level,
+				   struct ssdfs_btree_node *node)
+{
+	int index_area_state;
+	int items_area_state;
+	u32 free_space;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level || !node);
+
+	SSDFS_DBG("level %p, node %p\n",
+		  level, node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	level->flags = 0;
+	level->nodes.old_node.type = atomic_read(&node->type);
+	level->nodes.old_node.ptr = node;
+
+	index_area_state = atomic_read(&node->index_area.state);
+	items_area_state = atomic_read(&node->items_area.state);
+
+	if (index_area_state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		SSDFS_ERR("index area is absent: "
+			  "node_id %u, height %u\n",
+			  node->node_id,
+			  atomic_read(&node->height));
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+
+	free_space = node->index_area.index_capacity;
+
+	if (node->index_area.index_count > free_space) {
+		err = -ERANGE;
+		SSDFS_ERR("index_count %u > index_capacity %u\n",
+			  node->index_area.index_count,
+			  free_space);
+		goto finish_prepare_level;
+	}
+
+	free_space -= node->index_area.index_count;
+	free_space *= node->index_area.index_size;
+
+	level->index_area.free_space = free_space;
+	level->index_area.area_size = node->index_area.area_size;
+	level->index_area.hash.start = node->index_area.start_hash;
+	level->index_area.hash.end = node->index_area.end_hash;
+
+	if (items_area_state == SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		if (node->items_area.free_space > node->node_size) {
+			err = -ERANGE;
+			SSDFS_ERR("free_space %u > node_size %u\n",
+				  node->items_area.free_space,
+				  node->node_size);
+			goto finish_prepare_level;
+		}
+
+		level->items_area.free_space = node->items_area.free_space;
+		level->items_area.area_size = node->items_area.area_size;
+		level->items_area.hash.start = node->items_area.start_hash;
+		level->items_area.hash.end = node->items_area.end_hash;
+	}
+
+finish_prepare_level:
+	up_read(&node->header_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_prepare_insert_item() - prepare the level to insert item
+ * @level: level object [out]
+ * @search: search object
+ * @node: node object [in]
+ *
+ * This method tries to prepare the @level to insert the item.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_prepare_insert_item(struct ssdfs_btree_level *level,
+				    struct ssdfs_btree_search *search,
+				    struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree_node *parent;
+	struct ssdfs_btree_node_insert *add;
+	struct ssdfs_btree_node_move *move;
+	int index_area_state;
+	int items_area_state;
+	u32 free_space;
+	u8 index_size;
+	u64 start_hash, end_hash;
+	u16 items_count;
+	u16 min_item_size, max_item_size;
+	u32 insert_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level || !search || !node);
+
+	SSDFS_DBG("level %p, node %p\n",
+		  level, node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+		/*
+		 * Item will be added into a new node.
+		 * The tree will grow.
+		 * No logic is necessary for such case.
+		 */
+		return 0;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		/*
+		 * Item will be added into a new hybrid node.
+		 * No logic is necessary for such case.
+		 */
+		return 0;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
+	level->flags |= SSDFS_BTREE_LEVEL_ADD_ITEM;
+	level->nodes.old_node.type = atomic_read(&node->type);
+	level->nodes.old_node.ptr = node;
+
+	index_area_state = atomic_read(&node->index_area.state);
+	items_area_state = atomic_read(&node->items_area.state);
+
+	if (items_area_state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("items area is absent: "
+			  "node_id %u, height %u\n",
+			  node->node_id,
+			  atomic_read(&node->height));
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+
+	if (node->items_area.free_space > node->node_size) {
+		err = -ERANGE;
+		SSDFS_ERR("free_space %u > node_size %u\n",
+			  node->items_area.free_space,
+			  node->node_size);
+		goto finish_prepare_level;
+	}
+
+	level->items_area.free_space = node->items_area.free_space;
+	level->items_area.area_size = node->items_area.area_size;
+	level->items_area.hash.start = node->items_area.start_hash;
+	level->items_area.hash.end = node->items_area.end_hash;
+	min_item_size = node->items_area.min_item_size;
+	max_item_size = node->items_area.max_item_size;
+	items_count = node->items_area.items_count;
+
+	if (index_area_state == SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		free_space = node->index_area.index_capacity;
+
+		if (node->index_area.index_count > free_space) {
+			err = -ERANGE;
+			SSDFS_ERR("index_count %u > index_capacity %u\n",
+				  node->index_area.index_count,
+				  free_space);
+			goto finish_prepare_level;
+		}
+
+		free_space -= node->index_area.index_count;
+		free_space *= node->index_area.index_size;
+
+		index_size = node->index_area.index_size;
+
+		level->index_area.free_space = free_space;
+		level->index_area.area_size = node->index_area.area_size;
+		level->index_area.hash.start = node->index_area.start_hash;
+		level->index_area.hash.end = node->index_area.end_hash;
+	}
+
+finish_prepare_level:
+	up_read(&node->header_lock);
+
+	if (unlikely(err))
+		return err;
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	if (start_hash > end_hash) {
+		SSDFS_ERR("invalid requested hash range: "
+			  "start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		return -ERANGE;
+	}
+
+	add = &level->items_area.add;
+
+	add->hash.start = start_hash;
+	add->hash.end = end_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "level->items_area.hash.start %llx, "
+		  "level->items_area.hash.end %llx\n",
+		  start_hash, end_hash,
+		  level->items_area.hash.start,
+		  level->items_area.hash.end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (items_count == 0) {
+		add->pos.state = SSDFS_HASH_RANGE_OUT_OF_NODE;
+		add->pos.start = 0;
+		add->pos.count = search->request.count;
+		add->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+		return 0;
+	} else if (end_hash < level->items_area.hash.start)
+		add->pos.state = SSDFS_HASH_RANGE_LEFT_ADJACENT;
+	else if (start_hash > level->items_area.hash.end)
+		add->pos.state = SSDFS_HASH_RANGE_RIGHT_ADJACENT;
+	else
+		add->pos.state = SSDFS_HASH_RANGE_INTERSECTION;
+
+	add->pos.start = search->result.start_index;
+	add->pos.count = search->request.count;
+	add->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+	switch (node->tree->type) {
+	case SSDFS_INODES_BTREE:
+		/* Inodes tree doesn't need in rebalancing */
+		return 0;
+
+	case SSDFS_EXTENTS_BTREE:
+		switch (add->pos.state) {
+		case SSDFS_HASH_RANGE_RIGHT_ADJACENT:
+			/* skip rebalancing */
+			return 0;
+
+		default:
+			/* continue rebalancing */
+			break;
+		}
+		break;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
+	insert_size = max_item_size * search->request.count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("insert_size %u, free_space %u\n",
+		  insert_size, level->items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (insert_size == 0) {
+		SSDFS_ERR("search->result.start_index %u, "
+			  "search->request.count %u, "
+			  "max_item_size %u, "
+			  "insert_size %u\n",
+			  search->result.start_index,
+			  search->request.count,
+			  max_item_size,
+			  insert_size);
+		return -ERANGE;
+	}
+
+	spin_lock(&node->descriptor_lock);
+	parent = node->parent_node;
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!parent);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (level->items_area.free_space < insert_size) {
+		u16 moving_items;
+
+		if (can_add_new_index(parent))
+			moving_items = items_count / 2;
+		else
+			moving_items = search->request.count;
+
+		move = &level->items_area.move;
+
+		switch (add->pos.state) {
+		case SSDFS_HASH_RANGE_LEFT_ADJACENT:
+			level->flags |= SSDFS_BTREE_ITEMS_AREA_NEED_MOVE;
+			move->direction = SSDFS_BTREE_MOVE_TO_LEFT;
+			move->pos.state = SSDFS_HASH_RANGE_INTERSECTION;
+			move->pos.start = 0;
+			move->pos.count = moving_items;
+			move->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("MOVE_TO_LEFT: start %u, count %u\n",
+				  move->pos.start, move->pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+
+		case SSDFS_HASH_RANGE_INTERSECTION:
+			level->flags |= SSDFS_BTREE_ITEMS_AREA_NEED_MOVE;
+			move->direction = SSDFS_BTREE_MOVE_TO_RIGHT;
+			move->pos.state = SSDFS_HASH_RANGE_INTERSECTION;
+			move->pos.start = items_count - moving_items;
+			move->pos.count = moving_items;
+			move->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("MOVE_TO_RIGHT: start %u, count %u\n",
+				  move->pos.start, move->pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+
+		case SSDFS_HASH_RANGE_RIGHT_ADJACENT:
+			/* do nothing */
+			break;
+
+		default:
+			SSDFS_ERR("invalid insert position's state %#x\n",
+				  add->pos.state);
+			return -ERANGE;
+		}
+	}
+
+	return 0;
+}
+
+static inline
+void ssdfs_btree_cancel_insert_item(struct ssdfs_btree_level *level)
+{
+	struct ssdfs_btree_node_insert *add;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level);
+
+	SSDFS_DBG("level %p\n", level);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	level->flags &= ~SSDFS_BTREE_LEVEL_ADD_ITEM;
+
+	add = &level->items_area.add;
+
+	add->op_state = SSDFS_BTREE_AREA_OP_UNKNOWN;
+	add->hash.start = U64_MAX;
+	add->hash.end = U64_MAX;
+	add->pos.state = SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED;
+	add->pos.start = U16_MAX;
+	add->pos.count = 0;
+}
+
+/*
+ * ssdfs_need_move_items_to_sibling() - does it need to move items?
+ * @level: level object
+ *
+ * This method tries to check that the tree needs
+ * to be rebalanced.
+ */
+static inline
+bool ssdfs_need_move_items_to_sibling(struct ssdfs_btree_level *level)
+{
+	struct ssdfs_btree_node_move *move;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level);
+
+	SSDFS_DBG("level %p\n", level);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	move = &level->items_area.move;
+
+	if (level->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE) {
+		switch (move->direction) {
+		case SSDFS_BTREE_MOVE_TO_LEFT:
+		case SSDFS_BTREE_MOVE_TO_RIGHT:
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static inline
+void ssdfs_btree_cancel_move_items_to_sibling(struct ssdfs_btree_level *level)
+{
+	struct ssdfs_btree_node_move *move;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level);
+
+	SSDFS_DBG("level %p\n", level);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	move = &level->items_area.move;
+
+	level->flags &= ~SSDFS_BTREE_ITEMS_AREA_NEED_MOVE;
+
+	move->direction = SSDFS_BTREE_MOVE_NOWHERE;
+	move->pos.state = SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED;
+	move->pos.start = U16_MAX;
+	move->pos.count = 0;
+	move->op_state = SSDFS_BTREE_AREA_OP_UNKNOWN;
+}
+
+/*
+ * can_index_area_being_increased() - does items area has enough free space?
+ * @node: node object
+ */
+static inline
+bool can_index_area_being_increased(struct ssdfs_btree_node *node)
+{
+	int flags;
+	int items_area_state;
+	int index_area_state;
+	u32 items_area_free_space;
+	u32 index_area_min_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	flags = atomic_read(&node->tree->flags);
+
+	if (!(flags & SSDFS_BTREE_DESC_INDEX_AREA_RESIZABLE)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index area cannot be resized: "
+			  "node %u\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+	}
+
+	items_area_state = atomic_read(&node->items_area.state);
+	index_area_state = atomic_read(&node->index_area.state);
+
+	if (index_area_state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST)
+		return false;
+
+	if (items_area_state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST)
+		return false;
+
+	index_area_min_size = node->tree->index_area_min_size;
+
+	down_read(&node->header_lock);
+	items_area_free_space = node->items_area.free_space;
+	up_read(&node->header_lock);
+
+	return items_area_free_space >= index_area_min_size;
+}
+
+/*
+ * ssdfs_check_capability_move_to_sibling() - check capability to rebalance tree
+ * @level: level object
+ *
+ * This method tries to define the presence of free space in
+ * sibling node with the goal to rebalance the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - node hasn't free space.
+ */
+static
+int ssdfs_check_capability_move_to_sibling(struct ssdfs_btree_level *level)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_btree_node *node, *parent_node;
+	struct ssdfs_btree_node_move *move;
+	struct ssdfs_btree_node_index_area area;
+	struct ssdfs_btree_index_key index_key;
+	u64 hash = U64_MAX;
+	int items_area_state;
+	int index_area_state;
+	u16 index_count = 0;
+	u16 index_capacity = 0;
+	u16 vacant_indexes = 0;
+	u16 index_position;
+	u16 items_count;
+	u16 items_capacity;
+	u16 parent_items_count = 0;
+	u16 parent_items_capacity = 0;
+	u16 moving_items;
+	int node_type;
+	u32 node_id;
+	bool is_resize_possible = false;
+	spinlock_t *lock;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level);
+
+	SSDFS_DBG("level %p\n", level);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!(level->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE)) {
+		SSDFS_DBG("no items should be moved\n");
+		return 0;
+	}
+
+	move = &level->items_area.move;
+
+	switch (move->direction) {
+	case SSDFS_BTREE_MOVE_TO_LEFT:
+	case SSDFS_BTREE_MOVE_TO_RIGHT:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_DBG("nothing should be done\n");
+		return 0;
+	}
+
+	if (!level->nodes.old_node.ptr) {
+		SSDFS_ERR("node pointer is empty\n");
+		return -ERANGE;
+	}
+
+	node = level->nodes.old_node.ptr;
+	tree = node->tree;
+
+	spin_lock(&node->descriptor_lock);
+	hash = le64_to_cpu(node->node_index.index.hash);
+	spin_unlock(&node->descriptor_lock);
+
+	items_area_state = atomic_read(&node->items_area.state);
+
+	down_read(&node->header_lock);
+	if (items_area_state == SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		items_count = node->items_area.items_count;
+		items_capacity = node->items_area.items_capacity;
+	} else
+		err = -ERANGE;
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("items area is absent\n");
+		return -ERANGE;
+	}
+
+	lock = &level->nodes.old_node.ptr->descriptor_lock;
+	spin_lock(lock);
+	node = level->nodes.old_node.ptr->parent_node;
+	spin_unlock(lock);
+	lock = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	is_resize_possible = can_index_area_being_increased(node);
+
+	items_area_state = atomic_read(&node->items_area.state);
+	index_area_state = atomic_read(&node->index_area.state);
+
+	down_read(&node->header_lock);
+
+	if (items_area_state == SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		parent_items_count = node->items_area.items_count;
+		parent_items_capacity = node->items_area.items_capacity;
+	}
+
+	if (index_area_state == SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		index_count = node->index_area.index_count;
+		index_capacity = node->index_area.index_capacity;
+		vacant_indexes = index_capacity - index_count;
+	} else
+		err = -ERANGE;
+
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("index area is absent\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_find_index_position(node, hash,
+						   &index_position);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find the index position: "
+			  "hash %llx, err %d\n",
+			  hash, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hash %llx, index_position %u\n",
+		  hash, index_position);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (index_position >= index_count) {
+		SSDFS_ERR("index_position %u >= index_count %u\n",
+			  index_position, index_count);
+		return -ERANGE;
+	}
+
+	switch (move->direction) {
+	case SSDFS_BTREE_MOVE_TO_LEFT:
+		if (index_position == 0) {
+			SSDFS_DBG("no siblings on the left\n");
+
+			if (vacant_indexes == 0 && !is_resize_possible) {
+				/*
+				 * Try to move to parent node
+				 */
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("MOVE_TO_PARENT: start %u, count %u\n",
+					  move->pos.start, move->pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+				move->direction = SSDFS_BTREE_MOVE_TO_PARENT;
+				moving_items = items_capacity / 4;
+				move->pos.start = 0;
+				move->pos.count = moving_items;
+			}
+
+			return -ENOSPC;
+		}
+
+		index_position--;
+		break;
+
+	case SSDFS_BTREE_MOVE_TO_RIGHT:
+		if ((index_position + 1) == index_count) {
+			SSDFS_DBG("no siblings on the right\n");
+
+			if (vacant_indexes == 0 && !is_resize_possible) {
+				/*
+				 * Try to move to parent node
+				 */
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("MOVE_TO_PARENT: start %u, count %u\n",
+					  move->pos.start, move->pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+				move->direction = SSDFS_BTREE_MOVE_TO_PARENT;
+				moving_items = items_capacity / 4;
+				move->pos.start = items_capacity - moving_items;
+				move->pos.count = moving_items;
+			}
+
+			return -ENOSPC;
+		}
+
+		index_position++;
+		break;
+
+	default:
+		BUG();
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
+		ssdfs_memcpy(&area,
+			     0, sizeof(struct ssdfs_btree_node_index_area),
+			     &node->index_area,
+			     0, sizeof(struct ssdfs_btree_node_index_area),
+			     sizeof(struct ssdfs_btree_node_index_area));
+		up_read(&node->header_lock);
+
+		err = __ssdfs_btree_common_node_extract_index(node, &area,
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
+		ssdfs_debug_show_btree_node_indexes(node->tree, node);
+		return err;
+	}
+
+	parent_node = node;
+	node_id = le32_to_cpu(index_key.node_id);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("index_position %u, node_id %u\n",
+		  index_position, node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	items_area_state = atomic_read(&node->items_area.state);
+
+	down_read(&node->header_lock);
+	if (items_area_state == SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		items_count = node->items_area.items_count;
+		items_capacity = node->items_area.items_capacity;
+	} else
+		err = -ERANGE;
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("items area is absent\n");
+		return -ERANGE;
+	} else if (items_count >= items_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items area hasn't free space: "
+			  "items_count %u, items_capacity %u\n",
+			  items_count, items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (vacant_indexes == 0 && !is_resize_possible) {
+			/*
+			 * Try to move to parent node
+			 */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("MOVE_TO_PARENT: start %u, count %u\n",
+				  move->pos.start, move->pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			move->direction = SSDFS_BTREE_MOVE_TO_PARENT;
+			moving_items = items_capacity / 4;
+			move->pos.start = items_capacity - moving_items;
+			move->pos.count = moving_items;
+		}
+
+		return -ENOSPC;
+	}
+
+	moving_items = items_capacity - items_count;
+	moving_items /= 2;
+	if (moving_items == 0)
+		moving_items = 1;
+
+	switch (move->direction) {
+	case SSDFS_BTREE_MOVE_TO_LEFT:
+		move->pos.count = moving_items;
+		break;
+
+	case SSDFS_BTREE_MOVE_TO_RIGHT:
+		items_count = move->pos.start + move->pos.count;
+		moving_items = min_t(u16, moving_items, move->pos.count);
+		move->pos.start = items_count - moving_items;
+		move->pos.count = moving_items;
+		break;
+
+	default:
+		BUG();
+	}
+
+	level->nodes.new_node.type = atomic_read(&node->type);
+	level->nodes.new_node.ptr = node;
+
+	return 0;
+}
+
+/*
+ * ssdfs_need_move_items_to_parent() - does it need to move items?
+ * @level: level object
+ *
+ * This method tries to check that items need to move
+ * to the parent node.
+ */
+static inline
+bool ssdfs_need_move_items_to_parent(struct ssdfs_btree_level *level)
+{
+	struct ssdfs_btree_node_move *move;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level);
+
+	SSDFS_DBG("level %p\n", level);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	move = &level->items_area.move;
+
+	if (level->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE) {
+		switch (move->direction) {
+		case SSDFS_BTREE_MOVE_TO_PARENT:
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static inline
+void ssdfs_btree_cancel_move_items_to_parent(struct ssdfs_btree_level *level)
+{
+	struct ssdfs_btree_node_move *move;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level);
+
+	SSDFS_DBG("level %p\n", level);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	move = &level->items_area.move;
+
+	level->flags &= ~SSDFS_BTREE_ITEMS_AREA_NEED_MOVE;
+
+	move->direction = SSDFS_BTREE_MOVE_NOWHERE;
+	move->pos.state = SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED;
+	move->pos.start = U16_MAX;
+	move->pos.count = 0;
+	move->op_state = SSDFS_BTREE_AREA_OP_UNKNOWN;
+}
+
+/*
+ * ssdfs_prepare_move_items_to_parent() - prepare tree rebalance
+ * @search: search object
+ * @parent: parent level object
+ * @child: child level object
+ *
+ * This method tries to prepare the moving items from child
+ * to parent with the goal to rebalance the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_prepare_move_items_to_parent(struct ssdfs_btree_search *search,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *node;
+	struct ssdfs_btree_node_insert *insert;
+	struct ssdfs_btree_node_move *move;
+	int items_area_state;
+	u64 start_hash, end_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !parent || !child);
+
+	SSDFS_DBG("search %p, parent %p, child %p\n",
+		  search, parent, child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!(child->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE)) {
+		SSDFS_DBG("no items should be moved\n");
+		return 0;
+	}
+
+	move = &child->items_area.move;
+
+	switch (move->direction) {
+	case SSDFS_BTREE_MOVE_TO_PARENT:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_DBG("nothing should be done\n");
+		return 0;
+	}
+
+	if (!(parent->flags & SSDFS_BTREE_LEVEL_ADD_NODE)) {
+		SSDFS_DBG("items can be copied only into a new node\n");
+		ssdfs_btree_cancel_move_items_to_parent(child);
+		return 0;
+	}
+
+	node = child->nodes.old_node.ptr;
+
+	if (!node) {
+		SSDFS_WARN("node pointer is empty\n");
+		return -ERANGE;
+	}
+
+	items_area_state = atomic_read(&node->items_area.state);
+
+	down_read(&node->header_lock);
+	if (items_area_state == SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		start_hash = node->items_area.start_hash;
+		end_hash = node->items_area.end_hash;
+	} else
+		err = -ERANGE;
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("items area is absent\n");
+		return -ERANGE;
+	}
+
+	if (search->request.start.hash > end_hash ||
+	    search->request.end.hash < start_hash) {
+		ssdfs_btree_cancel_move_items_to_parent(child);
+		return 0;
+	}
+
+	insert = &parent->items_area.insert;
+
+	insert->hash.start = search->request.start.hash;
+	insert->hash.end = child->items_area.hash.end;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "child->items_area.hash.start %llx, "
+		  "child->items_area.hash.end %llx\n",
+		  insert->hash.start,
+		  insert->hash.end,
+		  child->items_area.hash.start,
+		  child->items_area.hash.end);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	insert->pos.state = SSDFS_HASH_RANGE_LEFT_ADJACENT;
+	insert->pos.start = 0;
+	insert->pos.count = move->pos.count;
+	insert->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_define_moving_indexes() - define moving index range
+ * @parent: parent level object [in|out]
+ * @child: child level object [in|out]
+ *
+ * This method tries to define what index range should be moved
+ * between @parent and @child levels.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_define_moving_indexes(struct ssdfs_btree_level *parent,
+				      struct ssdfs_btree_level *child)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int state;
+#endif /* CONFIG_SSDFS_DEBUG */
+	struct ssdfs_btree_node *child_node;
+	u8 index_size;
+	u16 index_count;
+	u16 index_capacity;
+	u64 start_hash;
+	u64 end_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!parent || !child);
+
+	SSDFS_DBG("parent: node_type %#x, node %p, "
+		  "child: node_type %#x, node %p\n",
+		  parent->nodes.old_node.type,
+		  parent->nodes.old_node.ptr,
+		  child->nodes.old_node.type,
+		  child->nodes.old_node.ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (parent->nodes.old_node.type) {
+	case SSDFS_BTREE_ROOT_NODE:
+		switch (child->nodes.old_node.type) {
+		case SSDFS_BTREE_INDEX_NODE:
+		case SSDFS_BTREE_HYBRID_NODE:
+			/*
+			 * Nothing should be done for the case of
+			 * adding the node.
+			 */
+			break;
+
+		case SSDFS_BTREE_LEAF_NODE:
+			/*
+			 * Nothing should be done for the case of
+			 * adding the node.
+			 */
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child->nodes.old_node.type);
+			break;
+		}
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		switch (child->nodes.old_node.type) {
+		case SSDFS_BTREE_INDEX_NODE:
+			/*
+			 * Nothing should be done for the case of
+			 * adding the node.
+			 */
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			/*
+			 * Nothing should be done for the case of
+			 * adding the node.
+			 */
+			break;
+
+		case SSDFS_BTREE_LEAF_NODE:
+			/*
+			 * Nothing should be done for the case of
+			 * adding the node.
+			 */
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child->nodes.old_node.type);
+			break;
+		}
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		switch (child->nodes.old_node.type) {
+		case SSDFS_BTREE_INDEX_NODE:
+			/*
+			 * Nothing should be done for the case of
+			 * adding the node.
+			 */
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			/*
+			 * Nothing should be done for the case of
+			 * adding the node.
+			 */
+			break;
+
+		case SSDFS_BTREE_LEAF_NODE:
+			/*
+			 * Nothing should be done for the case of
+			 * adding the node.
+			 */
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child->nodes.old_node.type);
+			break;
+		}
+		break;
+
+	default:
+		switch (child->nodes.old_node.type) {
+		case SSDFS_BTREE_ROOT_NODE:
+			child_node = child->nodes.old_node.ptr;
+#ifdef CONFIG_SSDFS_DEBUG
+			if (!child_node) {
+				SSDFS_ERR("child node is NULL\n");
+				return -ERANGE;
+			}
+
+			state = atomic_read(&child_node->index_area.state);
+			if (state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+				SSDFS_ERR("index area is absent\n");
+				return -ERANGE;
+			}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			down_read(&child_node->header_lock);
+			index_size = child_node->index_area.index_size;
+			index_count = child_node->index_area.index_count;
+			index_capacity = child_node->index_area.index_capacity;
+			start_hash = child_node->index_area.start_hash;
+			end_hash = child_node->index_area.end_hash;
+			up_read(&child_node->header_lock);
+
+			if (index_count != index_capacity) {
+				SSDFS_ERR("count %u != capacity %u\n",
+					  index_count, index_capacity);
+				return -ERANGE;
+			}
+
+			parent->nodes.new_node.type = SSDFS_BTREE_ROOT_NODE;
+			parent->nodes.new_node.ptr = child_node;
+
+			parent->flags |= SSDFS_BTREE_INDEX_AREA_NEED_MOVE;
+			parent->index_area.move.direction =
+						SSDFS_BTREE_MOVE_TO_CHILD;
+			parent->index_area.move.pos.state =
+					SSDFS_HASH_RANGE_INTERSECTION;
+			parent->index_area.move.pos.start = 0;
+			parent->index_area.move.pos.count = index_count;
+			parent->index_area.move.op_state =
+					SSDFS_BTREE_AREA_OP_REQUESTED;
+
+			child->index_area.insert.pos.state =
+					SSDFS_HASH_RANGE_LEFT_ADJACENT;
+			child->index_area.insert.hash.start = start_hash;
+			child->index_area.insert.hash.end = end_hash;
+			child->index_area.insert.pos.start = 0;
+			child->index_area.insert.pos.count = index_count;
+			child->index_area.insert.op_state =
+					SSDFS_BTREE_AREA_OP_REQUESTED;
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child->nodes.old_node.type);
+			break;
+		}
+		break;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_prepare_move_indexes_right() - prepare to move indexes (right)
+ * @parent: parent level object [in|out]
+ * @parent_node: parent node
+ *
+ * This method tries to define what index range should be moved
+ * from @parent_node to a new node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_prepare_move_indexes_right(struct ssdfs_btree_level *parent,
+				     struct ssdfs_btree_node *parent_node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int state;
+#endif /* CONFIG_SSDFS_DEBUG */
+	struct ssdfs_btree_node_move *move;
+	u16 index_count;
+	u16 index_capacity;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!parent || !parent_node);
+
+	SSDFS_DBG("parent: node_type %#x, node %p, node_id %u\n",
+		  parent->nodes.old_node.type,
+		  parent->nodes.old_node.ptr,
+		  parent_node->node_id);
+
+	state = atomic_read(&parent_node->index_area.state);
+	if (state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		SSDFS_ERR("index area is absent\n");
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&parent_node->header_lock);
+	index_count = parent_node->index_area.index_count;
+	index_capacity = parent_node->index_area.index_capacity;
+	up_read(&parent_node->header_lock);
+
+	if (index_count != index_capacity) {
+		SSDFS_ERR("count %u != capacity %u\n",
+			  index_count, index_capacity);
+		return -ERANGE;
+	}
+
+	if (index_count == 0) {
+		SSDFS_ERR("invalid count %u\n",
+			  index_count);
+		return -ERANGE;
+	}
+
+	move = &parent->index_area.move;
+
+	parent->flags |= SSDFS_BTREE_INDEX_AREA_NEED_MOVE;
+	move->direction = SSDFS_BTREE_MOVE_TO_RIGHT;
+	move->pos.state = SSDFS_HASH_RANGE_INTERSECTION;
+	move->pos.start = index_count / 2;
+	move->pos.count = index_count - move->pos.start;
+	move->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("MOVE_TO_RIGHT: start %u, count %u\n",
+		  move->pos.start, move->pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_check_capability_move_indexes_to_sibling() - check ability to rebalance
+ * @level: level object
+ *
+ * This method tries to define the presence of free space in
+ * sibling index node with the goal to rebalance the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - node hasn't free space.
+ */
+static int
+ssdfs_check_capability_move_indexes_to_sibling(struct ssdfs_btree_level *level)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_btree_node *node, *parent_node;
+	struct ssdfs_btree_node_move *move;
+	struct ssdfs_btree_node_index_area area;
+	struct ssdfs_btree_index_key index_key;
+	u64 hash = U64_MAX;
+	int index_area_state;
+	u16 index_count = 0;
+	u16 index_capacity = 0;
+	u16 vacant_indexes = 0;
+	u16 src_index_count = 0;
+	u16 index_position;
+	int node_type;
+	u32 node_id;
+	spinlock_t *lock;
+	u16 moving_indexes = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level);
+
+	SSDFS_DBG("level %p\n", level);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!level->nodes.old_node.ptr) {
+		SSDFS_ERR("node pointer is empty\n");
+		return -ERANGE;
+	}
+
+	node = level->nodes.old_node.ptr;
+	tree = node->tree;
+
+	spin_lock(&node->descriptor_lock);
+	hash = le64_to_cpu(node->node_index.index.hash);
+	spin_unlock(&node->descriptor_lock);
+
+	index_area_state = atomic_read(&node->index_area.state);
+
+	down_read(&node->header_lock);
+
+	if (index_area_state == SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		src_index_count = node->index_area.index_count;
+		index_capacity = node->index_area.index_capacity;
+		vacant_indexes = index_capacity - src_index_count;
+	} else
+		err = -ERANGE;
+
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("index area is absent\n");
+		return -ERANGE;
+	} else if (vacant_indexes != 0) {
+		SSDFS_ERR("node %u is not exhausted: "
+			  "index_count %u, index_capacity %u\n",
+			  node->node_id, src_index_count,
+			  index_capacity);
+		return -ERANGE;
+	}
+
+	lock = &level->nodes.old_node.ptr->descriptor_lock;
+	spin_lock(lock);
+	node = level->nodes.old_node.ptr->parent_node;
+	spin_unlock(lock);
+	lock = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	index_area_state = atomic_read(&node->index_area.state);
+
+	down_read(&node->header_lock);
+
+	if (index_area_state == SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		index_count = node->index_area.index_count;
+		index_capacity = node->index_area.index_capacity;
+		vacant_indexes = index_capacity - index_count;
+	} else
+		err = -ERANGE;
+
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("index area is absent\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_find_index_position(node, hash,
+						   &index_position);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find the index position: "
+			  "hash %llx, err %d\n",
+			  hash, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hash %llx, index_position %u\n",
+		  hash, index_position);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (index_position >= index_count) {
+		SSDFS_ERR("index_position %u >= index_count %u\n",
+			  index_position, index_count);
+		return -ERANGE;
+	}
+
+	if ((index_position + 1) == index_count) {
+		SSDFS_DBG("no siblings on the right\n");
+
+		if (vacant_indexes == 0) {
+			SSDFS_DBG("cannot add index\n");
+			return -ENOSPC;
+		} else {
+			SSDFS_DBG("need add empty index node\n");
+			return -ENOENT;
+		}
+	}
+
+	index_position++;
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
+		ssdfs_memcpy(&area,
+			     0, sizeof(struct ssdfs_btree_node_index_area),
+			     &node->index_area,
+			     0, sizeof(struct ssdfs_btree_node_index_area),
+			     sizeof(struct ssdfs_btree_node_index_area));
+		up_read(&node->header_lock);
+
+		err = __ssdfs_btree_common_node_extract_index(node, &area,
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
+		ssdfs_debug_show_btree_node_indexes(node->tree, node);
+		return err;
+	}
+
+	parent_node = node;
+	node_id = le32_to_cpu(index_key.node_id);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("index_position %u, node_id %u\n",
+		  index_position, node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	index_area_state = atomic_read(&node->index_area.state);
+
+	down_read(&node->header_lock);
+
+	if (index_area_state == SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		index_count = node->index_area.index_count;
+		index_capacity = node->index_area.index_capacity;
+		vacant_indexes = index_capacity - index_count;
+	} else
+		err = -ERANGE;
+
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("index area is absent\n");
+		return -ERANGE;
+	} else if (index_count >= index_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index area hasn't free space: "
+			  "index_count %u, index_capacity %u\n",
+			  index_count, index_capacity);
+		SSDFS_DBG("cannot move indexes\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+	moving_indexes = vacant_indexes / 2;
+	if (moving_indexes == 0)
+		moving_indexes = 1;
+
+	move = &level->index_area.move;
+
+	level->flags |= SSDFS_BTREE_INDEX_AREA_NEED_MOVE;
+	move->direction = SSDFS_BTREE_MOVE_TO_RIGHT;
+	move->pos.state = SSDFS_HASH_RANGE_INTERSECTION;
+	move->pos.start = src_index_count - moving_indexes;
+	move->pos.count = src_index_count - move->pos.start;
+	move->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("MOVE_TO_RIGHT: start %u, count %u\n",
+		  move->pos.start, move->pos.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	level->nodes.new_node.type = atomic_read(&node->type);
+	level->nodes.new_node.ptr = node;
+
+	return 0;
+}
+
+/*
+ * ssdfs_define_hybrid_node_moving_items() - define moving items range
+ * @tree: btree object
+ * @start_hash: starting hash
+ * @end_hash: ending hash
+ * @parent_node: pointer on parent node
+ * @child_node: pointer on child node
+ * @parent: parent level object [in|out]
+ * @child: child level object [in|out]
+ *
+ * This method tries to define what items range should be moved
+ * between @parent and @child levels.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_define_hybrid_node_moving_items(struct ssdfs_btree *tree,
+					u64 start_hash, u64 end_hash,
+					struct ssdfs_btree_node *parent_node,
+					struct ssdfs_btree_node *child_node,
+					struct ssdfs_btree_level *parent,
+					struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node_move *move;
+	struct ssdfs_btree_node_insert *insert;
+	int state;
+	u32 free_space = 0;
+	u16 item_size;
+	u16 items_count;
+	u16 items_capacity;
+	u64 parent_start_hash;
+	u64 parent_end_hash;
+	u32 index_area_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!parent || !child || !parent_node);
+
+	SSDFS_DBG("parent: node_type %#x, node %p\n",
+		  parent->nodes.old_node.type,
+		  parent->nodes.old_node.ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&parent_node->items_area.state);
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("items area is absent\n");
+		return -ERANGE;
+	}
+
+	down_read(&parent_node->header_lock);
+	item_size = parent_node->items_area.item_size;
+	items_count = parent_node->items_area.items_count;
+	items_capacity = parent_node->items_area.items_capacity;
+	parent_start_hash = parent_node->items_area.start_hash;
+	parent_end_hash = parent_node->items_area.end_hash;
+	index_area_size = parent_node->index_area.area_size;
+	up_read(&parent_node->header_lock);
+
+	if (child_node) {
+		down_read(&child_node->header_lock);
+		free_space = child_node->items_area.free_space;
+		up_read(&child_node->header_lock);
+	} else {
+		/* it needs to add a child node */
+		free_space = (u32)items_capacity * item_size;
+	}
+
+	if (items_count == 0) {
+		SSDFS_DBG("no items to move\n");
+		return 0;
+	}
+
+	if (free_space < ((u32)item_size * items_count)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to move items: "
+			  "free_space %u, item_size %u, items_count %u\n",
+			  free_space, item_size, items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	move = &parent->items_area.move;
+	insert = &child->items_area.insert;
+
+	switch (tree->type) {
+	case SSDFS_INODES_BTREE:
+	case SSDFS_EXTENTS_BTREE:
+	case SSDFS_SHARED_EXTENTS_BTREE:
+		/* no additional check is necessary */
+		break;
+
+	case SSDFS_DENTRIES_BTREE:
+	case SSDFS_XATTR_BTREE:
+	case SSDFS_SHARED_DICTIONARY_BTREE:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_hash %llx, "
+			  "end_hash %llx, "
+			  "parent: (start_hash %llx, "
+			  "end_hash %llx)\n",
+			  start_hash, end_hash,
+			  parent_start_hash,
+			  parent_end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if ((index_area_size * 2) < parent_node->node_size) {
+			/* parent node will be still hybrid one */
+			items_count /= 2;
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	parent->flags |= SSDFS_BTREE_ITEMS_AREA_NEED_MOVE;
+	move->direction = SSDFS_BTREE_MOVE_TO_CHILD;
+	move->pos.state = SSDFS_HASH_RANGE_INTERSECTION;
+	move->pos.start = 0;
+	move->pos.count = items_count;
+	move->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+	insert->pos.state = SSDFS_HASH_RANGE_LEFT_ADJACENT;
+	insert->hash.start = start_hash;
+	insert->hash.end = end_hash;
+	insert->pos.start = 0;
+	insert->pos.count = items_count;
+	insert->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+	child->flags |= SSDFS_BTREE_LEVEL_ADD_NODE;
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_define_moving_items() - define moving items range
+ * @tree: btree object
+ * @search: search object
+ * @parent: parent level object [in|out]
+ * @child: child level object [in|out]
+ *
+ * This method tries to define what items range should be moved
+ * between @parent and @child levels.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_define_moving_items(struct ssdfs_btree *tree,
+				    struct ssdfs_btree_search *search,
+				    struct ssdfs_btree_level *parent,
+				    struct ssdfs_btree_level *child)
+{
+	struct ssdfs_btree_node *parent_node, *child_node = NULL;
+	struct ssdfs_btree_node_move *move;
+	struct ssdfs_btree_node_insert *insert;
+	int state;
+	u32 free_space = 0;
+	u16 item_size;
+	u16 items_count;
+	u16 items_capacity;
+	int child_node_type;
+	u64 start_hash1, end_hash1;
+	u64 start_hash2, end_hash2;
+	bool has_intersection = false;
+	bool can_add_index = true;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search || !parent || !child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (child->flags & SSDFS_BTREE_LEVEL_ADD_NODE)
+		child_node_type = child->nodes.new_node.type;
+	else {
+		child_node_type = child->nodes.old_node.type;
+		child_node = child->nodes.old_node.ptr;
+
+		if (!child_node) {
+			SSDFS_ERR("child node is empty\n");
+			return -EINVAL;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("parent: node_type %#x, node %p, "
+		  "child: node_type %#x, node %p\n",
+		  parent->nodes.old_node.type,
+		  parent->nodes.old_node.ptr,
+		  child_node_type,
+		  child_node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (parent->nodes.old_node.type) {
+	case SSDFS_BTREE_ROOT_NODE:
+		switch (child_node_type) {
+		case SSDFS_BTREE_INDEX_NODE:
+		case SSDFS_BTREE_HYBRID_NODE:
+		case SSDFS_BTREE_LEAF_NODE:
+			/*
+			 * Nothing should be done.
+			 * The root node is pure index node.
+			 */
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child->nodes.old_node.type);
+			break;
+		}
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		switch (child_node_type) {
+		case SSDFS_BTREE_INDEX_NODE:
+		case SSDFS_BTREE_HYBRID_NODE:
+		case SSDFS_BTREE_LEAF_NODE:
+			/*
+			 * Nothing should be done.
+			 * The index node hasn't items at all.
+			 */
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child->nodes.old_node.type);
+			break;
+		}
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		switch (child_node_type) {
+		case SSDFS_BTREE_INDEX_NODE:
+			/*
+			 * Nothing should be done.
+			 * The index node hasn't items at all.
+			 */
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			parent_node = parent->nodes.old_node.ptr;
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!parent_node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			state = atomic_read(&parent_node->items_area.state);
+			if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+				SSDFS_ERR("items area is absent\n");
+				return -ERANGE;
+			}
+
+			if (!(child->flags & SSDFS_BTREE_ITEMS_AREA_NEED_MOVE))
+				return 0;
+
+			down_read(&parent_node->header_lock);
+			free_space = parent_node->items_area.area_size;
+			item_size = parent_node->items_area.item_size;
+			items_count = parent_node->items_area.items_count;
+			items_capacity = parent_node->items_area.items_capacity;
+			start_hash1 = parent_node->items_area.start_hash;
+			end_hash1 = parent_node->items_area.end_hash;
+			up_read(&parent_node->header_lock);
+
+			if (child_node) {
+				down_read(&child_node->header_lock);
+				free_space = child_node->items_area.free_space;
+				up_read(&child_node->header_lock);
+			} else {
+				/* it needs to add a child node */
+				free_space = (u32)items_capacity * item_size;
+			}
+
+			if (items_count == 0) {
+				SSDFS_DBG("no items to move\n");
+				return 0;
+			}
+
+			if (free_space < ((u32)item_size * items_count)) {
+				SSDFS_WARN("unable to move items: "
+					  "items_area.free_space %u, "
+					  "items_area.item_size %u, "
+					  "items_count %u\n",
+					  free_space, item_size,
+					  items_count);
+				return 0;
+			}
+
+			start_hash2 = search->request.start.hash;
+			end_hash2 = search->request.end.hash;
+
+			has_intersection =
+				RANGE_HAS_PARTIAL_INTERSECTION(start_hash1,
+								end_hash1,
+								start_hash2,
+								end_hash2);
+			can_add_index = can_add_new_index(parent_node);
+
+			move = &parent->items_area.move;
+			insert = &child->items_area.insert;
+
+			switch (tree->type) {
+			case SSDFS_INODES_BTREE:
+			case SSDFS_EXTENTS_BTREE:
+			case SSDFS_SHARED_EXTENTS_BTREE:
+				/* no additional check is necessary */
+				break;
+
+			case SSDFS_DENTRIES_BTREE:
+			case SSDFS_XATTR_BTREE:
+			case SSDFS_SHARED_DICTIONARY_BTREE:
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("search: (start_hash %llx, "
+					  "end_hash %llx), "
+					  "items_area: (start_hash %llx, "
+					  "end_hash %llx)\n",
+					  start_hash2, end_hash2,
+					  start_hash1, end_hash1);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				if (has_intersection)
+					items_count /= 2;
+				else if (can_add_index) {
+					SSDFS_DBG("no need to move items\n");
+
+					move->op_state =
+						SSDFS_BTREE_AREA_OP_UNKNOWN;
+					move->direction =
+						SSDFS_BTREE_MOVE_NOWHERE;
+					move->pos.start = U16_MAX;
+					move->pos.count = 0;
+					return 0;
+				} else {
+					SSDFS_DBG("need two phase adding\n");
+					return -EAGAIN;
+				}
+				break;
+
+			default:
+				BUG();
+			}
+
+			parent->flags |= SSDFS_BTREE_ITEMS_AREA_NEED_MOVE;
+			move->direction = SSDFS_BTREE_MOVE_TO_CHILD;
+			move->pos.state = SSDFS_HASH_RANGE_INTERSECTION;
+			move->pos.start = 0;
+			move->pos.count = items_count;
+			move->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+			insert->pos.state = SSDFS_HASH_RANGE_LEFT_ADJACENT;
+			insert->hash.start = start_hash1;
+			insert->hash.end = end_hash1;
+			insert->pos.start = 0;
+			insert->pos.count = items_count;
+			insert->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+			child->flags |= SSDFS_BTREE_LEVEL_ADD_NODE;
+			break;
+
+		case SSDFS_BTREE_LEAF_NODE:
+			parent_node = parent->nodes.old_node.ptr;
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!parent_node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			state = atomic_read(&parent_node->items_area.state);
+			if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+				SSDFS_ERR("items area is absent\n");
+				return -ERANGE;
+			}
+
+			down_read(&parent_node->header_lock);
+			free_space = parent_node->items_area.area_size;
+			item_size = parent_node->items_area.item_size;
+			items_count = parent_node->items_area.items_count;
+			items_capacity = parent_node->items_area.items_capacity;
+			start_hash1 = parent_node->items_area.start_hash;
+			end_hash1 = parent_node->items_area.end_hash;
+			up_read(&parent_node->header_lock);
+
+			if (child_node) {
+				down_read(&child_node->header_lock);
+				free_space = child_node->items_area.free_space;
+				up_read(&child_node->header_lock);
+			} else {
+				/* it needs to add a child node */
+				free_space = (u32)items_capacity * item_size;
+			}
+
+			if (items_count == 0) {
+				SSDFS_DBG("no items to move\n");
+				return 0;
+			}
+
+			if (free_space < ((u32)item_size * items_count)) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to move items: "
+					  "items_area.free_space %u, "
+					  "items_area.item_size %u, "
+					  "items_count %u\n",
+					  free_space, item_size,
+					  items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+				return 0;
+			}
+
+			start_hash2 = search->request.start.hash;
+			end_hash2 = search->request.end.hash;
+
+			has_intersection =
+				RANGE_HAS_PARTIAL_INTERSECTION(start_hash1,
+								end_hash1,
+								start_hash2,
+								end_hash2);
+			can_add_index = can_add_new_index(parent_node);
+
+			move = &parent->items_area.move;
+			insert = &child->items_area.insert;
+
+			switch (tree->type) {
+			case SSDFS_INODES_BTREE:
+			case SSDFS_EXTENTS_BTREE:
+			case SSDFS_SHARED_EXTENTS_BTREE:
+				/* no additional check is necessary */
+				break;
+
+			case SSDFS_DENTRIES_BTREE:
+			case SSDFS_XATTR_BTREE:
+			case SSDFS_SHARED_DICTIONARY_BTREE:
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("search: (start_hash %llx, "
+					  "end_hash %llx), "
+					  "items_area: (start_hash %llx, "
+					  "end_hash %llx)\n",
+					  start_hash2, end_hash2,
+					  start_hash1, end_hash1);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				if (has_intersection)
+					items_count /= 2;
+				else if (can_add_index) {
+					SSDFS_DBG("no need to move items\n");
+
+					move->op_state =
+						SSDFS_BTREE_AREA_OP_UNKNOWN;
+					move->direction =
+						SSDFS_BTREE_MOVE_NOWHERE;
+					move->pos.start = U16_MAX;
+					move->pos.count = 0;
+					return 0;
+				} else {
+					SSDFS_DBG("need two phase adding\n");
+					return -EAGAIN;
+				}
+				break;
+
+			default:
+				BUG();
+			}
+
+			parent->flags |= SSDFS_BTREE_ITEMS_AREA_NEED_MOVE;
+			move->direction = SSDFS_BTREE_MOVE_TO_CHILD;
+			move->pos.state = SSDFS_HASH_RANGE_INTERSECTION;
+			move->pos.start = 0;
+			move->pos.count = items_count;
+			move->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+			insert->pos.state = SSDFS_HASH_RANGE_LEFT_ADJACENT;
+			insert->hash.start = start_hash1;
+			insert->hash.end = end_hash1;
+			insert->pos.start = 0;
+			insert->pos.count = items_count;
+			insert->op_state = SSDFS_BTREE_AREA_OP_REQUESTED;
+
+			child->flags |= SSDFS_BTREE_LEVEL_ADD_NODE;
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid child node's type %#x\n",
+				  child->nodes.old_node.type);
+			break;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid parent node's type %#x\n",
+			  parent->nodes.old_node.type);
+		break;
+	}
+
+	return err;
+}
+
+/*
+ * need_update_parent_index_area() - does it need to update parent's index area
+ * @start_hash: starting hash value
+ * @child: btree node object
+ */
+bool need_update_parent_index_area(u64 start_hash,
+				   struct ssdfs_btree_node *child)
+{
+	int state;
+	u64 child_start_hash = U64_MAX;
+	bool need_update = false;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!child);
+
+	SSDFS_DBG("start_hash %llx, node_id %u, "
+		  "node type %#x, tree type %#x\n",
+		  start_hash, child->node_id,
+		  atomic_read(&child->type),
+		  child->tree->type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&child->type)) {
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		state = atomic_read(&child->index_area.state);
+		if (state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+			SSDFS_ERR("invalid index area's state %#x\n",
+				  state);
+			return false;
+		}
+
+		down_read(&child->header_lock);
+		child_start_hash = child->index_area.start_hash;
+		up_read(&child->header_lock);
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		state = atomic_read(&child->items_area.state);
+		if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+			SSDFS_ERR("invalid items area's state %#x\n",
+				  state);
+			return false;
+		}
+
+		down_read(&child->header_lock);
+		child_start_hash = child->items_area.start_hash;
+		up_read(&child->header_lock);
+		break;
+
+	default:
+		SSDFS_ERR("unexpected node's type %#x\n",
+			  atomic_read(&child->type));
+		return false;
+	}
+
+	if (child_start_hash >= U64_MAX) {
+		SSDFS_WARN("invalid start_hash %llx\n",
+			  child_start_hash);
+		return false;
+	}
+
+	if (start_hash <= child_start_hash)
+		need_update = true;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, child_start_hash %llx, "
+		  "need_update %#x\n",
+		  start_hash, child_start_hash,
+		  need_update);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return need_update;
+}
+
+/*
+ * is_index_area_resizable() - is it possible to resize the index area?
+ * @node: btree node object
+ */
+static inline
+bool is_index_area_resizable(struct ssdfs_btree_node *node)
+{
+	int flags;
+	int state;
+	u32 node_size;
+	u32 index_area_size, items_area_size;
+	size_t hdr_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	flags = atomic_read(&node->tree->flags);
+
+	if (!(flags & SSDFS_BTREE_DESC_INDEX_AREA_RESIZABLE)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index area cannot be resized: "
+			  "node %u\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+	}
+
+	node_size = node->node_size;
+	hdr_size = sizeof(node->raw);
+
+	down_read(&node->header_lock);
+	index_area_size = node->index_area.area_size;
+	items_area_size = node->items_area.area_size;
+	up_read(&node->header_lock);
+
+	state = atomic_read(&node->index_area.state);
+	if (state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST)
+		index_area_size = 0;
+
+	state = atomic_read(&node->items_area.state);
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST)
+		items_area_size = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, node_size %u, hdr_size %zu, "
+		  "index_area_size %u, items_area_size %u\n",
+		  node->node_id, node_size, hdr_size,
+		  index_area_size, items_area_size);
+
+	BUG_ON(node_size < (hdr_size + index_area_size + items_area_size));
+#else
+	if (node_size < (hdr_size + index_area_size + items_area_size)) {
+		SSDFS_WARN("node_size %u < "
+			   "(hdr_size %zu +index_area %u + items_area %u)\n",
+			   node_size, hdr_size,
+			   index_area_size, items_area_size);
+		return false;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return items_area_size == 0 ? false : true;
+}
+
+/*
+ * ssdfs_btree_prepare_index_area_resize() - prepare index area resize
+ * @level: level object
+ * @node: node object
+ *
+ * This method tries to prepare index area for resize operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_prepare_index_area_resize(struct ssdfs_btree_level *level,
+					  struct ssdfs_btree_node *node)
+{
+	int state;
+	u16 items_count;
+	u16 items_capacity;
+	u32 index_area_size, items_area_size;
+	u32 index_area_min_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!level);
+	BUG_ON(!node || !node->tree);
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+
+	BUG_ON(!is_index_area_resizable(node));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	level->flags |= SSDFS_BTREE_TRY_RESIZE_INDEX_AREA;
+
+	down_read(&node->header_lock);
+	index_area_size = node->index_area.area_size;
+	items_area_size = node->items_area.area_size;
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	up_read(&node->header_lock);
+
+	index_area_min_size = node->tree->index_area_min_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("index_area_size %u, index_area_min_size %u, "
+		  "items_area_size %u, items_count %u, "
+		  "items_capacity %u\n",
+		  index_area_size, index_area_min_size,
+		  items_area_size, items_count, items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&node->items_area.state);
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("items area doesn't exist: "
+			  "node_id %u\n",
+			  node->node_id);
+		return -ERANGE;
+	}
+
+	if (items_count == 0 || items_count > items_capacity) {
+		SSDFS_ERR("corrupted items area: "
+			  "items_count %u, items_capacity %u\n",
+			  items_count, items_capacity);
+		return -ERANGE;
+	}
+
+	return 0;
+}
diff --git a/fs/ssdfs/btree_hierarchy.h b/fs/ssdfs/btree_hierarchy.h
new file mode 100644
index 000000000000..b431be941e46
--- /dev/null
+++ b/fs/ssdfs/btree_hierarchy.h
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/btree_hierarchy.h - btree hierarchy declarations.
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
+#ifndef _SSDFS_BTREE_HIERARCHY_H
+#define _SSDFS_BTREE_HIERARCHY_H
+
+/*
+ * struct ssdfs_hash_range - hash range
+ * @start: start hash
+ * @end: end hash
+ */
+struct ssdfs_hash_range {
+	u64 start;
+	u64 end;
+};
+
+/*
+ * struct ssdfs_btree_node_position - node's position range
+ * @state: intersection state
+ * @start: starting node's position
+ * @count: number of positions in the range
+ */
+struct ssdfs_btree_node_position {
+	int state;
+	u16 start;
+	u16 count;
+};
+
+/* Intersection states */
+enum {
+	SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED,
+	SSDFS_HASH_RANGE_LEFT_ADJACENT,
+	SSDFS_HASH_RANGE_INTERSECTION,
+	SSDFS_HASH_RANGE_RIGHT_ADJACENT,
+	SSDFS_HASH_RANGE_OUT_OF_NODE,
+	SSDFS_HASH_RANGE_INTERSECTION_STATE_MAX
+};
+
+/*
+ * struct ssdfs_btree_node_insert - insert position
+ * @op_state: operation state
+ * @hash: hash range of insertion
+ * @pos: position descriptor
+ */
+struct ssdfs_btree_node_insert {
+	int op_state;
+	struct ssdfs_hash_range hash;
+	struct ssdfs_btree_node_position pos;
+};
+
+/*
+ * struct ssdfs_btree_node_move - moving range descriptor
+ * @op_state: operation state
+ * @direction: moving direction
+ * @pos: position descriptor
+ */
+struct ssdfs_btree_node_move {
+	int op_state;
+	int direction;
+	struct ssdfs_btree_node_position pos;
+};
+
+/*
+ * struct ssdfs_btree_node_delete - deleting node's index descriptor
+ * @op_state: operation state
+ * @node_index: node index for deletion
+ */
+struct ssdfs_btree_node_delete {
+	int op_state;
+	struct ssdfs_btree_index_key node_index;
+};
+
+/* Possible operation states */
+enum {
+	SSDFS_BTREE_AREA_OP_UNKNOWN,
+	SSDFS_BTREE_AREA_OP_REQUESTED,
+	SSDFS_BTREE_AREA_OP_DONE,
+	SSDFS_BTREE_AREA_OP_FAILED,
+	SSDFS_BTREE_AREA_OP_STATE_MAX
+};
+
+/* Possible moving directions */
+enum {
+	SSDFS_BTREE_MOVE_NOWHERE,
+	SSDFS_BTREE_MOVE_TO_PARENT,
+	SSDFS_BTREE_MOVE_TO_CHILD,
+	SSDFS_BTREE_MOVE_TO_LEFT,
+	SSDFS_BTREE_MOVE_TO_RIGHT,
+	SSDFS_BTREE_MOVE_DIRECTION_MAX
+};
+
+/* Btree level's flags */
+#define SSDFS_BTREE_LEVEL_ADD_NODE		(1 << 0)
+#define SSDFS_BTREE_LEVEL_ADD_INDEX		(1 << 1)
+#define SSDFS_BTREE_LEVEL_UPDATE_INDEX		(1 << 2)
+#define SSDFS_BTREE_LEVEL_ADD_ITEM		(1 << 3)
+#define SSDFS_BTREE_INDEX_AREA_NEED_MOVE	(1 << 4)
+#define SSDFS_BTREE_ITEMS_AREA_NEED_MOVE	(1 << 5)
+#define SSDFS_BTREE_TRY_RESIZE_INDEX_AREA	(1 << 6)
+#define SSDFS_BTREE_LEVEL_DELETE_NODE		(1 << 7)
+#define SSDFS_BTREE_LEVEL_DELETE_INDEX		(1 << 8)
+#define SSDFS_BTREE_LEVEL_FLAGS_MASK		0x1FF
+
+#define SSDFS_BTREE_ADD_NODE_MASK \
+	(SSDFS_BTREE_LEVEL_ADD_NODE | SSDFS_BTREE_LEVEL_ADD_INDEX | \
+	 SSDFS_BTREE_LEVEL_UPDATE_INDEX | SSDFS_BTREE_LEVEL_ADD_ITEM | \
+	 SSDFS_BTREE_INDEX_AREA_NEED_MOVE | \
+	 SSDFS_BTREE_ITEMS_AREA_NEED_MOVE | \
+	 SSDFS_BTREE_TRY_RESIZE_INDEX_AREA)
+
+#define SSDFS_BTREE_DELETE_NODE_MASK \
+	(SSDFS_BTREE_LEVEL_UPDATE_INDEX | SSDFS_BTREE_LEVEL_DELETE_NODE | \
+	 SSDFS_BTREE_LEVEL_DELETE_INDEX)
+
+/*
+ * struct ssdfs_btree_level_node - node descriptor
+ * @type: node's type
+ * @index_hash: old index area's hash pair
+ * @items_hash: old items area's hash pair
+ * @ptr: pointer on node's object
+ */
+struct ssdfs_btree_level_node {
+	int type;
+	struct ssdfs_hash_range index_hash;
+	struct ssdfs_hash_range items_hash;
+	struct ssdfs_btree_node *ptr;
+};
+
+/*
+ * struct ssdfs_btree_level_node_desc - descriptor of level's nodes
+ * @old_node: old node of the level
+ * @new_node: created empty node
+ */
+struct ssdfs_btree_level_node_desc {
+	struct ssdfs_btree_level_node old_node;
+	struct ssdfs_btree_level_node new_node;
+};
+
+/*
+ * struct ssdfs_btree_level - btree level descriptor
+ * @flags: level's flags
+ * @index_area.area_size: size of the index area
+ * @index_area.free_space: free space in index area
+ * @index_area.hash: hash range of index area
+ * @items_area.add: adding index descriptor
+ * @index_area.insert: insert position descriptor
+ * @index_area.move: move range descriptor
+ * @index_area.delete: delete index descriptor
+ * @items_area.area_size: size of the items area
+ * @items_area.free_space: free space in items area
+ * @items_area.hash: hash range of items area
+ * @items_area.add: adding item descriptor
+ * @items_area.insert: insert position descriptor
+ * @items_area.move: move range descriptor
+ * @nodes: descriptor of level's nodes
+ */
+struct ssdfs_btree_level {
+	u32 flags;
+
+	struct {
+		u32 area_size;
+		u32 free_space;
+		struct ssdfs_hash_range hash;
+		struct ssdfs_btree_node_insert add;
+		struct ssdfs_btree_node_insert insert;
+		struct ssdfs_btree_node_move move;
+		struct ssdfs_btree_node_delete delete;
+	} index_area;
+
+	struct {
+		u32 area_size;
+		u32 free_space;
+		struct ssdfs_hash_range hash;
+		struct ssdfs_btree_node_insert add;
+		struct ssdfs_btree_node_insert insert;
+		struct ssdfs_btree_node_move move;
+	} items_area;
+
+	struct ssdfs_btree_level_node_desc nodes;
+};
+
+/*
+ * struct ssdfs_btree_state_descriptor - btree's state descriptor
+ * @height: btree height
+ * @increment_height: request to increment tree's height
+ * @node_size: size of the node in bytes
+ * @index_size: size of the index record in bytes
+ * @min_item_size: minimum item size in bytes
+ * @max_item_size: maximum item size in bytes
+ * @index_area_min_size: minimum size of index area in bytes
+ */
+struct ssdfs_btree_state_descriptor {
+	int height;
+	bool increment_height;
+	u32 node_size;
+	u16 index_size;
+	u16 min_item_size;
+	u16 max_item_size;
+	u16 index_area_min_size;
+};
+
+/*
+ * struct ssdfs_btree_hierarchy - btree's hierarchy descriptor
+ * @desc: btree state's descriptor
+ * @array_ptr: btree level's array
+ */
+struct ssdfs_btree_hierarchy {
+	struct ssdfs_btree_state_descriptor desc;
+	struct ssdfs_btree_level **array_ptr;
+};
+
+/* Btree hierarchy inline methods */
+static inline
+bool need_add_node(struct ssdfs_btree_level *level)
+{
+	return level->flags & SSDFS_BTREE_LEVEL_ADD_NODE;
+}
+
+static inline
+bool need_delete_node(struct ssdfs_btree_level *level)
+{
+	return level->flags & SSDFS_BTREE_LEVEL_DELETE_NODE;
+}
+
+/* Btree hierarchy API */
+struct ssdfs_btree_hierarchy *
+ssdfs_btree_hierarchy_allocate(struct ssdfs_btree *tree);
+void ssdfs_btree_hierarchy_init(struct ssdfs_btree *tree,
+				struct ssdfs_btree_hierarchy *hierarchy);
+void ssdfs_btree_hierarchy_free(struct ssdfs_btree_hierarchy *hierarchy);
+
+bool need_update_parent_index_area(u64 start_hash,
+				   struct ssdfs_btree_node *child);
+int ssdfs_btree_check_hierarchy_for_add(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_hierarchy *ptr);
+int ssdfs_btree_process_level_for_add(struct ssdfs_btree_hierarchy *ptr,
+					int cur_height,
+					struct ssdfs_btree_search *search);
+int ssdfs_btree_check_hierarchy_for_delete(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_hierarchy *ptr);
+int ssdfs_btree_process_level_for_delete(struct ssdfs_btree_hierarchy *ptr,
+					 int cur_height,
+					 struct ssdfs_btree_search *search);
+int ssdfs_btree_check_hierarchy_for_update(struct ssdfs_btree *tree,
+					   struct ssdfs_btree_search *search,
+					   struct ssdfs_btree_hierarchy *ptr);
+int ssdfs_btree_process_level_for_update(struct ssdfs_btree_hierarchy *ptr,
+					 int cur_height,
+					 struct ssdfs_btree_search *search);
+
+/* Btree hierarchy internal API*/
+void ssdfs_btree_prepare_add_node(struct ssdfs_btree *tree,
+				  int node_type,
+				  u64 start_hash, u64 end_hash,
+				  struct ssdfs_btree_level *level,
+				  struct ssdfs_btree_node *node);
+int ssdfs_btree_prepare_add_index(struct ssdfs_btree_level *level,
+				  u64 start_hash, u64 end_hash,
+				  struct ssdfs_btree_node *node);
+
+void ssdfs_show_btree_hierarchy_object(struct ssdfs_btree_hierarchy *ptr);
+void ssdfs_debug_btree_hierarchy_object(struct ssdfs_btree_hierarchy *ptr);
+
+#endif /* _SSDFS_BTREE_HIERARCHY_H */
-- 
2.34.1


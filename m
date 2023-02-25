Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C936A265C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBYBTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBYBRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:40 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12005199CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:22 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id be35so815630oib.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5itNSNOQ7Xt/KLdPbCOiJeOxGwK3R6LkyoMJFtSgNek=;
        b=NG1/KKuzrXqidnYDpBDQzZXJ+pBHcMLKhr+2vQApQF66822ZIqKcvgj2M5b0kD32z0
         p1V9jUB7ElMOmtY5v+5H+zQGHaCSKXEJ7pPm5EvoEpggiI7VBtwoXw750cOgNABEh6/a
         2dITIetP1t0+PVFmPTUZvrZck15tv2I1kkQoMP1N4WTyfm3ZFoUY4MGRTQXzHhiO4Xpg
         v+dKMqV1zKRNIpzMnuSquTLKTcyzZZQDc5KG/duS31u7PjVt2xzVlt56QAC42ToyRwRm
         inV7VRtgSeqF3Zr/TAbn9kBlootLnqYtcxTmuIzg4pH8/KZDzJF+Ua1Ta+Xo98V+FeS7
         YJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5itNSNOQ7Xt/KLdPbCOiJeOxGwK3R6LkyoMJFtSgNek=;
        b=R5VEAJyGO7TQPqNhvf3yAojfVyIpTo5pvae1iI16hvSA0yQJwLdk0qX7Owm2SO7P5l
         9glWGnX//fUYbsKwdILnVYZuiTL//tcuJjAZKyrrTaiYDi3ZHAuU4yShDe1a1cEBIres
         2dPaKVhvf4g1fs9yW1x6I1Kuf/IJGc7UjLeQzmtD+VHDVtT3OLI3xdSvDplSVocY6ON9
         Q+lKJciJLl0gPiXAPzUNjkCNHmaofF3nOBzuvo3kyMD1i121TXawIydi3Vq1CgIkI1Sm
         hHQg3UM7EXMfEXo9Z3O+J44es+a2cdziuAPTGvSPjZEDbAAFIaTJKMgVRQhm1hJh00FH
         DygA==
X-Gm-Message-State: AO0yUKXv0WCHWxgcjJm6EcQZOwxQ3qn2Zz79+7nWB5OEc6HJ52+rAVSi
        51fE0akv0EVv/bk+ViL1We2syjw4/MylzpFb
X-Google-Smtp-Source: AK7set8wbggEZ66xf2md4rSJKLjx262WbatAuqG6daRnjmQe0kBzykqqM8JQmlT6hHa7Bgk3NaQpgQ==
X-Received: by 2002:a05:6808:4c2:b0:377:ff1d:dcb2 with SMTP id a2-20020a05680804c200b00377ff1ddcb2mr5022274oie.0.1677287840339;
        Fri, 24 Feb 2023 17:17:20 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:19 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 50/76] ssdfs: introduce b-tree node object
Date:   Fri, 24 Feb 2023 17:09:01 -0800
Message-Id: <20230225010927.813929-51-slava@dubeyko.com>
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
 fs/ssdfs/btree_node.c | 2176 +++++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/btree_node.h |  768 +++++++++++++++
 2 files changed, 2944 insertions(+)
 create mode 100644 fs/ssdfs/btree_node.c
 create mode 100644 fs/ssdfs/btree_node.h

diff --git a/fs/ssdfs/btree_node.c b/fs/ssdfs/btree_node.c
new file mode 100644
index 000000000000..9f09090e5cfd
--- /dev/null
+++ b/fs/ssdfs/btree_node.c
@@ -0,0 +1,2176 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/btree_node.c - generalized btree node implementation.
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
+#include <linux/mm.h>
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
+#include "shared_extents_tree.h"
+#include "diff_on_write.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_btree_node_page_leaks;
+atomic64_t ssdfs_btree_node_memory_leaks;
+atomic64_t ssdfs_btree_node_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_btree_node_cache_leaks_increment(void *kaddr)
+ * void ssdfs_btree_node_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_btree_node_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_btree_node_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_btree_node_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_btree_node_kfree(void *kaddr)
+ * struct page *ssdfs_btree_node_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_btree_node_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_btree_node_free_page(struct page *page)
+ * void ssdfs_btree_node_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(btree_node)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(btree_node)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_btree_node_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_btree_node_page_leaks, 0);
+	atomic64_set(&ssdfs_btree_node_memory_leaks, 0);
+	atomic64_set(&ssdfs_btree_node_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_btree_node_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_btree_node_page_leaks) != 0) {
+		SSDFS_ERR("BTREE NODE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_btree_node_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_btree_node_memory_leaks) != 0) {
+		SSDFS_ERR("BTREE NODE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_btree_node_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_btree_node_cache_leaks) != 0) {
+		SSDFS_ERR("BTREE NODE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_btree_node_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/******************************************************************************
+ *                            BTREE NODE CACHE                                *
+ ******************************************************************************/
+
+static struct kmem_cache *ssdfs_btree_node_obj_cachep;
+
+void ssdfs_zero_btree_node_obj_cache_ptr(void)
+{
+	ssdfs_btree_node_obj_cachep = NULL;
+}
+
+static void ssdfs_init_btree_node_object_once(void *obj)
+{
+	struct ssdfs_btree_node *node_obj = obj;
+
+	memset(node_obj, 0, sizeof(struct ssdfs_btree_node));
+}
+
+void ssdfs_shrink_btree_node_obj_cache(void)
+{
+	if (ssdfs_btree_node_obj_cachep)
+		kmem_cache_shrink(ssdfs_btree_node_obj_cachep);
+}
+
+void ssdfs_destroy_btree_node_obj_cache(void)
+{
+	if (ssdfs_btree_node_obj_cachep)
+		kmem_cache_destroy(ssdfs_btree_node_obj_cachep);
+}
+
+int ssdfs_init_btree_node_obj_cache(void)
+{
+	ssdfs_btree_node_obj_cachep =
+			kmem_cache_create("ssdfs_btree_node_obj_cache",
+					sizeof(struct ssdfs_btree_node), 0,
+					SLAB_RECLAIM_ACCOUNT |
+					SLAB_MEM_SPREAD |
+					SLAB_ACCOUNT,
+					ssdfs_init_btree_node_object_once);
+	if (!ssdfs_btree_node_obj_cachep) {
+		SSDFS_ERR("unable to create btree node objects cache\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_alloc() - allocate memory for btree node object
+ */
+static
+struct ssdfs_btree_node *ssdfs_btree_node_alloc(void)
+{
+	struct ssdfs_btree_node *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_btree_node_obj_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = kmem_cache_alloc(ssdfs_btree_node_obj_cachep, GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate memory for btree node object\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ssdfs_btree_node_cache_leaks_increment(ptr);
+
+	return ptr;
+}
+
+/*
+ * ssdfs_btree_node_free() - free memory for btree node object
+ */
+static
+void ssdfs_btree_node_free(struct ssdfs_btree_node *ptr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_btree_node_obj_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ptr)
+		return;
+
+	ssdfs_btree_node_cache_leaks_decrement(ptr);
+	kmem_cache_free(ssdfs_btree_node_obj_cachep, ptr);
+}
+
+/******************************************************************************
+ *                        BTREE NODE OBJECT FUNCTIONALITY                     *
+ ******************************************************************************/
+
+/*
+ * ssdfs_btree_node_create_empty_index_area() - create empty index area
+ * @tree: btree object
+ * @node: node object
+ * @type: node's type
+ * @start_hash: starting hash of the node
+ *
+ * This method tries to create the empty index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+static
+int ssdfs_btree_node_create_empty_index_area(struct ssdfs_btree *tree,
+					     struct ssdfs_btree_node *node,
+					     int type,
+					     u64 start_hash)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !node);
+
+	if (type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_WARN("invalid node type %#x\n", type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("tree %p, node %p, "
+		  "type %#x, start_hash %llx\n",
+		  tree, node, type, start_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(&node->index_area, 0xFF,
+		sizeof(struct ssdfs_btree_node_index_area));
+
+	switch (type) {
+	case SSDFS_BTREE_ROOT_NODE:
+		atomic_set(&node->index_area.state,
+				SSDFS_BTREE_NODE_INDEX_AREA_EXIST);
+		node->index_area.offset =
+			offsetof(struct ssdfs_btree_inline_root_node, indexes);
+		node->index_area.index_size = sizeof(struct ssdfs_btree_index);
+		node->index_area.index_capacity =
+					SSDFS_BTREE_ROOT_NODE_INDEX_COUNT;
+		node->index_area.area_size = node->index_area.index_size;
+		node->index_area.area_size *= node->index_area.index_capacity;
+		node->index_area.index_count = 0;
+		node->index_area.start_hash = start_hash;
+		node->index_area.end_hash = U64_MAX;
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		/*
+		 * Partial preliminary initialization.
+		 * The final creation should be done in specialized
+		 * tree->btree_ops->create_node() and
+		 * tree->btree_ops->init_node() methods.
+		 */
+		atomic_set(&node->index_area.state,
+				SSDFS_BTREE_NODE_INDEX_AREA_EXIST);
+		atomic_or(SSDFS_BTREE_NODE_HAS_INDEX_AREA, &node->flags);
+		node->index_area.index_size =
+					sizeof(struct ssdfs_btree_index_key);
+		node->index_area.index_count = 0;
+		node->index_area.start_hash = start_hash;
+		node->index_area.end_hash = U64_MAX;
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		atomic_set(&node->index_area.state,
+				SSDFS_BTREE_NODE_AREA_ABSENT);
+		node->index_area.index_size = 0;
+		node->index_area.index_capacity = 0;
+		node->index_area.area_size = 0;
+		node->index_area.index_count = 0;
+		break;
+
+	default:
+		SSDFS_WARN("invalid node type %#x\n", type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_create_empty_items_area() - create empty items area
+ * @tree: btree object
+ * @node: node object
+ * @type: node's type
+ * @start_hash: starting hash of the node
+ *
+ * This method tries to create the empty index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+static
+int ssdfs_btree_node_create_empty_items_area(struct ssdfs_btree *tree,
+					     struct ssdfs_btree_node *node,
+					     int type,
+					     u64 start_hash)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !node);
+
+	if (type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_WARN("invalid node type %#x\n", type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("tree %p, node %p, "
+		  "type %#x, start_hash %llx\n",
+		  tree, node, type, start_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(&node->items_area, 0xFF,
+		sizeof(struct ssdfs_btree_node_items_area));
+
+	switch (type) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		atomic_set(&node->items_area.state,
+				SSDFS_BTREE_NODE_AREA_ABSENT);
+		node->items_area.area_size = 0;
+		node->items_area.item_size = 0;
+		node->items_area.min_item_size = 0;
+		node->items_area.max_item_size = 0;
+		node->items_area.items_count = 0;
+		node->items_area.items_capacity = 0;
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		/*
+		 * Partial preliminary initialization.
+		 * The final creation should be done in specialized
+		 * tree->btree_ops->create_node() and
+		 * tree->btree_ops->init_node() methods.
+		 */
+		atomic_set(&node->items_area.state,
+				SSDFS_BTREE_NODE_ITEMS_AREA_EXIST);
+		atomic_or(SSDFS_BTREE_NODE_HAS_ITEMS_AREA, &node->flags);
+		node->items_area.item_size = tree->item_size;
+		node->items_area.min_item_size = tree->min_item_size;
+		node->items_area.max_item_size = tree->max_item_size;
+		node->items_area.start_hash = start_hash;
+		node->items_area.end_hash = start_hash;
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		atomic_set(&node->items_area.state,
+				SSDFS_BTREE_NODE_ITEMS_AREA_EXIST);
+		atomic_or(SSDFS_BTREE_NODE_HAS_ITEMS_AREA, &node->flags);
+		node->items_area.item_size = tree->item_size;
+		node->items_area.min_item_size = tree->min_item_size;
+		node->items_area.max_item_size = tree->max_item_size;
+		node->items_area.start_hash = start_hash;
+		node->items_area.end_hash = start_hash;
+		break;
+
+	default:
+		SSDFS_WARN("invalid node type %#x\n", type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_create_empty_lookup_table() - create empty lookup table
+ * @node: node object
+ *
+ * This method tries to create the empty lookup table area.
+ */
+static
+void ssdfs_btree_node_create_empty_lookup_table(struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node %p\n", node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(&node->lookup_tbl_area, 0xFF,
+		sizeof(struct ssdfs_btree_node_index_area));
+
+	atomic_set(&node->lookup_tbl_area.state,
+			SSDFS_BTREE_NODE_AREA_ABSENT);
+	node->lookup_tbl_area.index_size = 0;
+	node->lookup_tbl_area.index_capacity = 0;
+	node->lookup_tbl_area.area_size = 0;
+	node->lookup_tbl_area.index_count = 0;
+}
+
+/*
+ * ssdfs_btree_node_create_empty_hash_table() - create empty hash table
+ * @node: node object
+ *
+ * This method tries to create the empty hash table area.
+ */
+static
+void ssdfs_btree_node_create_empty_hash_table(struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node %p\n", node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(&node->hash_tbl_area, 0xFF,
+		sizeof(struct ssdfs_btree_node_index_area));
+
+	atomic_set(&node->hash_tbl_area.state,
+			SSDFS_BTREE_NODE_AREA_ABSENT);
+	node->hash_tbl_area.index_size = 0;
+	node->hash_tbl_area.index_capacity = 0;
+	node->hash_tbl_area.area_size = 0;
+	node->hash_tbl_area.index_count = 0;
+}
+
+/*
+ * ssdfs_btree_node_create() - create btree node object
+ * @tree: btree object
+ * @node_id: node ID number
+ * @parent: parent node
+ * @height: node's height
+ * @type: node's type
+ * @start_hash: starting hash of the node
+ *
+ * This method tries to create a btree node object.
+ *
+ * RETURN:
+ * [success] - pointer on created btree node object.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - cannot allocate memory.
+ * %-ERANGE     - internal error.
+ */
+struct ssdfs_btree_node *
+ssdfs_btree_node_create(struct ssdfs_btree *tree,
+			u32 node_id,
+			struct ssdfs_btree_node *parent,
+			u8 height, int type,
+			u64 start_hash)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_node *ptr;
+	u8 tree_height;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi);
+
+	if (type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_WARN("invalid node type %#x\n", type);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (type != SSDFS_BTREE_ROOT_NODE && !parent) {
+		SSDFS_WARN("node %u should have parent\n",
+			   node_id);
+		return ERR_PTR(-EINVAL);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, parent %p, node_id %u, "
+		  "height %u, type %#x, start_hash %llx\n",
+		  tree, parent, node_id, height,
+		  type, start_hash);
+#else
+	SSDFS_DBG("tree %p, parent %p, node_id %u, "
+		  "height %u, type %#x, start_hash %llx\n",
+		  tree, parent, node_id, height,
+		  type, start_hash);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = tree->fsi;
+
+	ptr = ssdfs_btree_node_alloc();
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate btree node object\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ptr->parent_node = parent;
+	ptr->tree = tree;
+
+	if (node_id == SSDFS_BTREE_NODE_INVALID_ID) {
+		err = -EINVAL;
+		SSDFS_WARN("invalid node_id\n");
+		goto fail_create_node;
+	}
+	ptr->node_id = node_id;
+
+	tree_height = atomic_read(&tree->height);
+	if (height > tree_height) {
+		err = -EINVAL;
+		SSDFS_WARN("height %u > tree->height %u\n",
+			   height, tree_height);
+		goto fail_create_node;
+	}
+
+	atomic_set(&ptr->height, height);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (tree->node_size < fsi->pagesize ||
+	    tree->node_size > fsi->erasesize) {
+		err = -EINVAL;
+		SSDFS_WARN("invalid node_size %u, "
+			   "pagesize %u, erasesize %u\n",
+			   tree->node_size,
+			   fsi->pagesize,
+			   fsi->erasesize);
+		goto fail_create_node;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+	ptr->node_size = tree->node_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (tree->pages_per_node != (ptr->node_size / fsi->pagesize)) {
+		err = -EINVAL;
+		SSDFS_WARN("invalid pages_per_node %u, "
+			   "node_size %u, pagesize %u\n",
+			   tree->pages_per_node,
+			   ptr->node_size,
+			   fsi->pagesize);
+		goto fail_create_node;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+	ptr->pages_per_node = tree->pages_per_node;
+
+	ptr->create_cno = ssdfs_current_cno(fsi->sb);
+	ptr->node_ops = NULL;
+
+	atomic_set(&ptr->refs_count, 0);
+	atomic_set(&ptr->flags, 0);
+	atomic_set(&ptr->type, type);
+
+	init_rwsem(&ptr->header_lock);
+	memset(&ptr->raw, 0xFF, sizeof(ptr->raw));
+
+	err = ssdfs_btree_node_create_empty_index_area(tree, ptr,
+							type,
+							start_hash);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create empty index area: err %d\n",
+			  err);
+		goto fail_create_node;
+	}
+
+	err = ssdfs_btree_node_create_empty_items_area(tree, ptr,
+							type,
+							start_hash);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create empty items area: err %d\n",
+			  err);
+		goto fail_create_node;
+	}
+
+	ssdfs_btree_node_create_empty_lookup_table(ptr);
+	ssdfs_btree_node_create_empty_hash_table(ptr);
+
+	spin_lock_init(&ptr->descriptor_lock);
+	ptr->update_cno = ptr->create_cno;
+
+	/*
+	 * Partial preliminary initialization.
+	 * The final creation should be done in specialized
+	 * tree->btree_ops->create_node() and
+	 * tree->btree_ops->init_node() methods.
+	 */
+	memset(&ptr->extent, 0xFF, sizeof(struct ssdfs_raw_extent));
+	ptr->seg = NULL;
+
+	ptr->node_index.node_id = cpu_to_le32(node_id);
+	ptr->node_index.node_type = (u8)type;
+	ptr->node_index.height = height;
+	ptr->node_index.flags = cpu_to_le16(SSDFS_BTREE_INDEX_SHOW_EMPTY_NODE);
+	ptr->node_index.index.hash = cpu_to_le64(start_hash);
+
+	init_completion(&ptr->init_end);
+
+	/*
+	 * Partial preliminary initialization.
+	 * The final creation should be done in specialized
+	 * tree->btree_ops->create_node() and
+	 * tree->btree_ops->init_node() methods.
+	 */
+	init_rwsem(&ptr->bmap_array.lock);
+	ptr->bmap_array.bits_count = 0;
+	ptr->bmap_array.bmap_bytes = 0;
+	ptr->bmap_array.index_start_bit = ULONG_MAX;
+	ptr->bmap_array.item_start_bit = ULONG_MAX;
+	for (i = 0; i < SSDFS_BTREE_NODE_BMAP_COUNT; i++) {
+		spin_lock_init(&ptr->bmap_array.bmap[i].lock);
+		ptr->bmap_array.bmap[i].flags = 0;
+		ptr->bmap_array.bmap[i].ptr = NULL;
+	}
+
+	init_waitqueue_head(&ptr->wait_queue);
+	init_rwsem(&ptr->full_lock);
+
+	atomic_set(&ptr->state, SSDFS_BTREE_NODE_CREATED);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return ptr;
+
+fail_create_node:
+	ptr->parent_node = NULL;
+	ptr->tree = NULL;
+	ssdfs_btree_node_free(ptr);
+	return ERR_PTR(err);
+}
+
+/*
+ * ssdfs_btree_create_root_node() - create root node
+ * @node: node object
+ * @root_node: pointer on the on-disk root node object
+ *
+ * This method tries to create the root node of the btree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - corrupted root node object.
+ */
+int ssdfs_btree_create_root_node(struct ssdfs_btree_node *node,
+				 struct ssdfs_btree_inline_root_node *root_node)
+{
+	struct ssdfs_btree_root_node_header *hdr;
+	struct ssdfs_btree_index *index1, *index2;
+	size_t rnode_size = sizeof(struct ssdfs_btree_inline_root_node);
+	u8 height;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !root_node);
+
+	SSDFS_DBG("node %p, root_node %p\n",
+		  node, root_node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = &root_node->header;
+
+	if (hdr->type != SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_ERR("invalid node type %#x\n",
+			  hdr->type);
+		return -EIO;
+	}
+
+	if (hdr->items_count > SSDFS_BTREE_ROOT_NODE_INDEX_COUNT) {
+		SSDFS_ERR("invalid items_count %u\n",
+			  hdr->items_count);
+		return -EIO;
+	}
+
+	height = hdr->height;
+
+	if (height >= U8_MAX) {
+		SSDFS_ERR("invalid height %u\n",
+			  height);
+		return -EIO;
+	}
+
+	if (le32_to_cpu(hdr->upper_node_id) == 0) {
+		height = 1;
+		atomic_set(&node->tree->height, height);
+		atomic_set(&node->height, height - 1);
+	} else {
+		if (height == 0) {
+			SSDFS_ERR("invalid height %u\n",
+				  height);
+			return -EIO;
+		}
+
+		atomic_set(&node->tree->height, height);
+		atomic_set(&node->height, height - 1);
+	}
+
+	node->node_size = rnode_size;
+	node->pages_per_node = 0;
+	node->create_cno = le64_to_cpu(0);
+	node->tree->create_cno = node->create_cno;
+	node->node_id = SSDFS_BTREE_ROOT_NODE_ID;
+
+	node->parent_node = NULL;
+	node->node_ops = NULL;
+
+	atomic_set(&node->flags, hdr->flags);
+	atomic_set(&node->type, hdr->type);
+
+	down_write(&node->header_lock);
+	ssdfs_memcpy(&node->raw.root_node, 0, rnode_size,
+		     root_node, 0, rnode_size,
+		     rnode_size);
+	node->index_area.index_count = hdr->items_count;
+	node->index_area.start_hash = U64_MAX;
+	node->index_area.end_hash = U64_MAX;
+	if (hdr->items_count > 0) {
+		index1 = &root_node->indexes[SSDFS_ROOT_NODE_LEFT_LEAF_NODE];
+		node->index_area.start_hash = le64_to_cpu(index1->hash);
+	}
+	if (hdr->items_count > 1) {
+		index2 = &root_node->indexes[SSDFS_ROOT_NODE_RIGHT_LEAF_NODE];
+		node->index_area.end_hash = le64_to_cpu(index2->hash);
+	}
+	up_write(&node->header_lock);
+
+	spin_lock(&node->tree->nodes_lock);
+	node->tree->upper_node_id =
+		le32_to_cpu(root_node->header.upper_node_id);
+	spin_unlock(&node->tree->nodes_lock);
+
+	atomic_set(&node->state, SSDFS_BTREE_NODE_INITIALIZED);
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_allocate_content_space() - allocate content space
+ * @node: node object
+ * @node_size: node size
+ */
+int ssdfs_btree_node_allocate_content_space(struct ssdfs_btree_node *node,
+					    u32 node_size)
+{
+	struct page *page;
+	u32 pages_count;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+
+	SSDFS_DBG("node_id %u, node_size %u\n",
+		  node->node_id, node_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pages_count = node_size / PAGE_SIZE;
+
+	if (pages_count == 0 || pages_count > PAGEVEC_SIZE) {
+		SSDFS_ERR("invalid pages_count %u\n",
+			  pages_count);
+		return -ERANGE;
+	}
+
+	down_write(&node->full_lock);
+
+	pagevec_init(&node->content.pvec);
+	for (i = 0; i < pages_count; i++) {
+		page = ssdfs_btree_node_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (IS_ERR_OR_NULL(page)) {
+			err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+			SSDFS_ERR("unable to allocate memory page\n");
+			goto finish_init_pvec;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		pagevec_add(&node->content.pvec, page);
+	}
+
+finish_init_pvec:
+	up_write(&node->full_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_allocate_bmaps() - allocate node's bitmaps
+ * @addr: array of pointers
+ * @bmap_bytes: size of the bitmap in bytes
+ */
+int ssdfs_btree_node_allocate_bmaps(void *addr[SSDFS_BTREE_NODE_BMAP_COUNT],
+				    size_t bmap_bytes)
+{
+	int i;
+
+	for (i = 0; i < SSDFS_BTREE_NODE_BMAP_COUNT; i++) {
+		addr[i] = ssdfs_btree_node_kzalloc(bmap_bytes, GFP_KERNEL);
+		if (!addr[i]) {
+			SSDFS_ERR("fail to allocate node's bmap: index %d\n",
+				  i);
+			for (; i >= 0; i--) {
+				ssdfs_btree_node_kfree(addr[i]);
+				addr[i] = NULL;
+			}
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_init_bmaps() - init node's bitmaps
+ * @node: node object
+ * @addr: array of pointers
+ */
+void ssdfs_btree_node_init_bmaps(struct ssdfs_btree_node *node,
+				 void *addr[SSDFS_BTREE_NODE_BMAP_COUNT])
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->bmap_array.lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_BTREE_NODE_BMAP_COUNT; i++) {
+		void *tmp_addr = NULL;
+
+		spin_lock(&node->bmap_array.bmap[i].lock);
+		tmp_addr = node->bmap_array.bmap[i].ptr;
+		node->bmap_array.bmap[i].ptr = addr[i];
+		addr[i] = NULL;
+		spin_unlock(&node->bmap_array.bmap[i].lock);
+
+		if (tmp_addr)
+			ssdfs_btree_node_kfree(tmp_addr);
+	}
+}
+
+/*
+ * ssdfs_btree_node_destroy() - destroy the btree node
+ * @node: node object
+ */
+void ssdfs_btree_node_destroy(struct ssdfs_btree_node *node)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("node_id %u, height %u, type %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type));
+#else
+	SSDFS_DBG("node_id %u, height %u, type %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type));
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_DIRTY:
+		switch (atomic_read(&node->type)) {
+		case SSDFS_BTREE_ROOT_NODE:
+			/* ignore root node dirty state */
+			break;
+
+		default:
+			SSDFS_WARN("node %u is dirty\n", node->node_id);
+			break;
+		}
+		/* FALLTHRU */
+		fallthrough;
+	case SSDFS_BTREE_NODE_CREATED:
+		/* FALLTHRU */
+		fallthrough;
+	case SSDFS_BTREE_NODE_INITIALIZED:
+		atomic_set(&node->state, SSDFS_BTREE_NODE_UNKNOWN_STATE);
+		wake_up_all(&node->wait_queue);
+		complete_all(&node->init_end);
+
+		spin_lock(&node->descriptor_lock);
+		if (node->seg) {
+			ssdfs_segment_put_object(node->seg);
+			node->seg = NULL;
+		}
+		spin_unlock(&node->descriptor_lock);
+
+		if (rwsem_is_locked(&node->bmap_array.lock)) {
+			/* inform about possible trouble */
+			SSDFS_WARN("node is locked under destruction\n");
+		}
+
+		node->bmap_array.bits_count = 0;
+		node->bmap_array.bmap_bytes = 0;
+		node->bmap_array.index_start_bit = ULONG_MAX;
+		node->bmap_array.item_start_bit = ULONG_MAX;
+		for (i = 0; i < SSDFS_BTREE_NODE_BMAP_COUNT; i++) {
+			spin_lock(&node->bmap_array.bmap[i].lock);
+			ssdfs_btree_node_kfree(node->bmap_array.bmap[i].ptr);
+			node->bmap_array.bmap[i].ptr = NULL;
+			spin_unlock(&node->bmap_array.bmap[i].lock);
+		}
+
+		if (rwsem_is_locked(&node->full_lock)) {
+			/* inform about possible trouble */
+			SSDFS_WARN("node is locked under destruction\n");
+		}
+
+		if (atomic_read(&node->type) != SSDFS_BTREE_ROOT_NODE) {
+			struct pagevec *pvec = &node->content.pvec;
+			ssdfs_btree_node_pagevec_release(pvec);
+		}
+		break;
+
+	default:
+		SSDFS_WARN("invalid node state: "
+			   "node %u, state %#x\n",
+			   node->node_id,
+			   atomic_read(&node->state));
+		break;
+	}
+
+	ssdfs_btree_node_free(node);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * __ssdfs_btree_node_prepare_content() - prepare the btree node's content
+ * @fsi: pointer on shared file system object
+ * @ptr: btree node's index
+ * @node_size: size of the node
+ * @owner_ino: owner inode ID
+ * @si: segment object [out]
+ * @pvec: pagevec with node's content [out]
+ *
+ * This method tries to read the raw node from the volume.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+int __ssdfs_btree_node_prepare_content(struct ssdfs_fs_info *fsi,
+					struct ssdfs_btree_index_key *ptr,
+					u32 node_size,
+					u64 owner_ino,
+					struct ssdfs_segment_info **si,
+					struct pagevec *pvec)
+{
+	struct ssdfs_segment_request *req;
+	struct ssdfs_peb_container *pebc;
+	struct ssdfs_blk2off_table *table;
+	struct ssdfs_offset_position pos;
+	u32 node_id;
+	u8 node_type;
+	u8 height;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u32 pvec_size;
+	u64 logical_offset;
+	u32 data_bytes;
+	struct completion *end;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !ptr || !si || !pvec);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node_id = le32_to_cpu(ptr->node_id);
+	node_type = ptr->node_type;
+	height = ptr->height;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, node_size %u, height %u, type %#x\n",
+		  node_id, node_size, height, node_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node_type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    node_type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_WARN("invalid node type %#x\n",
+			   node_type);
+		return -ERANGE;
+	}
+
+	if (node_type == SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_WARN("root node should be initialize during creation\n");
+		return -ERANGE;
+	}
+
+	seg_id = le64_to_cpu(ptr->index.extent.seg_id);
+	logical_blk = le32_to_cpu(ptr->index.extent.logical_blk);
+	len = le32_to_cpu(ptr->index.extent.len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, logical_blk %u, len %u\n",
+		  seg_id, logical_blk, len);
+
+	BUG_ON(seg_id == U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*si = ssdfs_grab_segment(fsi, NODE2SEG_TYPE(node_type),
+				seg_id, U64_MAX);
+	if (unlikely(IS_ERR_OR_NULL(*si))) {
+		err = !*si ? -ENOMEM : PTR_ERR(*si);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			SSDFS_ERR("fail to grab segment object: "
+				  "seg %llu, err %d\n",
+				  seg_id, err);
+		}
+		goto fail_get_segment;
+	}
+
+	pvec_size = node_size >> PAGE_SHIFT;
+
+	if (pvec_size == 0 || pvec_size > PAGEVEC_SIZE) {
+		err = -ERANGE;
+		SSDFS_WARN("invalid memory pages count: "
+			   "node_size %u, pvec_size %u\n",
+			   node_size, pvec_size);
+		goto finish_prepare_content;
+	}
+
+	req = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req)) {
+		err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		goto finish_prepare_content;
+	}
+
+	ssdfs_request_init(req);
+	ssdfs_get_request(req);
+
+	logical_offset = (u64)node_id * node_size;
+	data_bytes = node_size;
+	ssdfs_request_prepare_logical_extent(owner_ino,
+					     (u64)logical_offset,
+					     (u32)data_bytes,
+					     0, 0, req);
+
+	for (i = 0; i < pvec_size; i++) {
+		err = ssdfs_request_add_allocated_page_locked(req);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add page into request: "
+				  "err %d\n",
+				  err);
+			goto fail_read_node;
+		}
+	}
+
+	ssdfs_request_define_segment(seg_id, req);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(logical_blk >= U16_MAX);
+	BUG_ON(len >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	ssdfs_request_define_volume_extent((u16)logical_blk, (u16)len, req);
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    SSDFS_READ_PAGES_READAHEAD,
+					    SSDFS_REQ_SYNC,
+					    req);
+
+	table = (*si)->blk2off_table;
+
+	err = ssdfs_blk2off_table_get_offset_position(table, logical_blk, &pos);
+	if (err == -EAGAIN) {
+		end = &table->full_init_end;
+
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("blk2off init failed: "
+				  "seg_id %llu, logical_blk %u, "
+				  "len %u, err %d\n",
+				  seg_id, logical_blk, len, err);
+
+			for (i = 0; i < (*si)->pebs_count; i++) {
+				u64 peb_id1 = U64_MAX;
+				u64 peb_id2 = U64_MAX;
+
+				pebc = &(*si)->peb_array[i];
+
+				if (pebc->src_peb)
+					peb_id1 = pebc->src_peb->peb_id;
+
+				if (pebc->dst_peb)
+					peb_id2 = pebc->dst_peb->peb_id;
+
+				SSDFS_ERR("seg_id %llu, peb_index %u, "
+					  "src_peb %llu, dst_peb %llu\n",
+					  seg_id, i, peb_id1, peb_id2);
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			goto fail_read_node;
+		}
+
+		err = ssdfs_blk2off_table_get_offset_position(table,
+							      logical_blk,
+							      &pos);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to convert: "
+			  "seg_id %llu, logical_blk %u, len %u, err %d\n",
+			  seg_id, logical_blk, len, err);
+		goto fail_read_node;
+	}
+
+	pebc = &(*si)->peb_array[pos.peb_index];
+
+	err = ssdfs_peb_readahead_pages(pebc, req, &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("PEB init failed: "
+				  "err %d\n", err);
+			goto fail_read_node;
+		}
+
+		err = ssdfs_peb_readahead_pages(pebc, req, &end);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read page: err %d\n",
+			  err);
+		goto fail_read_node;
+	}
+
+	for (i = 0; i < req->result.processed_blks; i++)
+		ssdfs_peb_mark_request_block_uptodate(pebc, req, i);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	for (i = 0; i < pagevec_count(&req->result.pvec); i++) {
+		void *kaddr;
+		struct page *page = req->result.pvec.pages[i];
+
+		kaddr = kmap_local_page(page);
+		SSDFS_DBG("PAGE DUMP: index %d\n",
+			  i);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr,
+				     PAGE_SIZE);
+		SSDFS_DBG("\n");
+		kunmap_local(kaddr);
+
+		WARN_ON(!PageLocked(page));
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_btree_node_pagevec_release(pvec);
+
+	for (i = 0; i < pagevec_count(&req->result.pvec); i++) {
+		pagevec_add(pvec, req->result.pvec.pages[i]);
+		ssdfs_btree_node_account_page(req->result.pvec.pages[i]);
+		ssdfs_request_unlock_and_remove_page(req, i);
+	}
+	pagevec_reinit(&req->result.pvec);
+
+	ssdfs_request_unlock_and_remove_diffs(req);
+
+	ssdfs_put_request(req);
+	ssdfs_request_free(req);
+
+	return 0;
+
+fail_read_node:
+	ssdfs_request_unlock_and_remove_pages(req);
+	ssdfs_put_request(req);
+	ssdfs_request_free(req);
+
+finish_prepare_content:
+	ssdfs_segment_put_object(*si);
+
+fail_get_segment:
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_prepare_content() - prepare the btree node's content
+ * @node: node object
+ * @ptr: btree node's index
+ *
+ * This method tries to read the raw node from the volume.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_node_prepare_content(struct ssdfs_btree_node *node,
+				     struct ssdfs_btree_index_key *ptr)
+{
+	struct ssdfs_segment_info *si = NULL;
+	size_t extent_size = sizeof(struct ssdfs_raw_extent);
+	u32 node_id;
+	u8 node_type;
+	u8 height;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !ptr);
+
+	SSDFS_DBG("node_id %u, height %u, type %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node_id = le32_to_cpu(ptr->node_id);
+	node_type = ptr->node_type;
+	height = ptr->height;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (node->node_id != node_id) {
+		SSDFS_WARN("node->node_id %u != node_id %u\n",
+			   node->node_id, node_id);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&node->type) != node_type) {
+		SSDFS_WARN("node->type %#x != node_type %#x\n",
+			   atomic_read(&node->type), node_type);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&node->height) != height) {
+		SSDFS_WARN("node->height %u != height %u\n",
+			   atomic_read(&node->height), height);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&node->full_lock);
+	err = __ssdfs_btree_node_prepare_content(node->tree->fsi, ptr,
+						 node->node_size,
+						 node->tree->owner_ino,
+						 &si,
+						 &node->content.pvec);
+	up_write(&node->full_lock);
+
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		goto finish_prepare_node_content;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare node's content: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		goto finish_prepare_node_content;
+	}
+
+	spin_lock(&node->descriptor_lock);
+	ssdfs_memcpy(&node->extent, 0, extent_size,
+		     &ptr->index.extent, 0, extent_size,
+		     extent_size);
+	node->seg = si;
+	spin_unlock(&node->descriptor_lock);
+
+	atomic_set(&node->state, SSDFS_BTREE_NODE_CONTENT_PREPARED);
+
+finish_prepare_node_content:
+	return err;
+}
+
+/*
+ * __ssdfs_define_memory_page() - define memory page for the position
+ * @area_offset: area offset from the node's beginning
+ * @area_size: size of the area
+ * @node_size: node size in bytes
+ * @item_size: size of the item in bytes
+ * @position: position of index record in the node
+ * @page_index: index of memory page in the node [out]
+ * @page_off: offset from the memory page's beginning in bytes [out]
+ *
+ * This method tries to define a memory page's index and byte
+ * offset to the index record.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int __ssdfs_define_memory_page(u32 area_offset, u32 area_size,
+				u32 node_size, size_t item_size,
+				u16 position,
+				u32 *page_index, u32 *page_off)
+{
+	u32 item_offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page_index || !page_off);
+
+	SSDFS_DBG("area_offset %u, area_size %u, "
+		  "node_size %u, item_size %zu, position %u\n",
+		  area_offset, area_size,
+		  node_size, item_size, position);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*page_index = U32_MAX;
+	*page_off = U32_MAX;
+
+	item_offset = position * item_size;
+	if (item_offset >= area_size) {
+		SSDFS_ERR("item_offset %u >= area_size %u\n",
+			  item_offset, area_size);
+		return -ERANGE;
+	}
+
+	item_offset += area_offset;
+
+	if (item_offset >= (area_offset + area_size)) {
+		SSDFS_ERR("invalid index offset: "
+			  "item_offset %u, area_offset %u, "
+			  "area_size %u\n",
+			  item_offset, area_offset, area_size);
+		return -ERANGE;
+	}
+
+	*page_index = item_offset >> PAGE_SHIFT;
+	*page_off = item_offset % PAGE_SIZE;
+
+	if ((*page_off + item_size) > PAGE_SIZE) {
+		SSDFS_ERR("invalid request: "
+			  "page_off %u, item_size %zu\n",
+			  *page_off, item_size);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_define_memory_page() - define memory page for the position
+ * @node: node object
+ * @area: pointer on index area descriptor
+ * @position: position of index record in the node
+ * @page_index: index of memory page in the node [out]
+ * @page_off: offset from the memory page's beginning in bytes [out]
+ *
+ * This method tries to define a memory page's index and byte
+ * offset to the index record.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_define_memory_page(struct ssdfs_btree_node *node,
+			     struct ssdfs_btree_node_index_area *area,
+			     u16 position,
+			     u32 *page_index, u32 *page_off)
+{
+	size_t index_size = sizeof(struct ssdfs_btree_index_key);
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !page_index || !page_off);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+
+	SSDFS_DBG("node_id %u, node_type %#x, position %u\n",
+		  node->node_id, atomic_read(&node->type),
+		  position);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*page_index = U32_MAX;
+	*page_off = U32_MAX;
+
+	if (atomic_read(&area->state) != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  atomic_read(&area->state));
+		return -ERANGE;
+	}
+
+	if (area->index_capacity == 0 ||
+	    area->index_count > area->index_capacity) {
+		SSDFS_ERR("invalid area: "
+			  "index_count %u, index_capacity %u\n",
+			  area->index_count,
+			  area->index_capacity);
+		return -ERANGE;
+	}
+
+	if (position > area->index_count) {
+		SSDFS_ERR("position %u > index_count %u\n",
+			  position, area->index_count);
+		return -ERANGE;
+	}
+
+	if ((area->offset + area->area_size) > node->node_size) {
+		SSDFS_ERR("invalid area: "
+			  "offset %u, area_size %u, node_size %u\n",
+			  area->offset,
+			  area->area_size,
+			  node->node_size);
+		return -ERANGE;
+	}
+
+	if (area->index_size != index_size) {
+		SSDFS_ERR("invalid index size %u\n",
+			  area->index_size);
+		return -ERANGE;
+	}
+
+	err = __ssdfs_define_memory_page(area->offset, area->area_size,
+					 node->node_size, index_size,
+					 position, page_index, page_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define page index: err %d\n",
+			  err);
+		return err;
+	}
+
+	if ((*page_off + area->index_size) > PAGE_SIZE) {
+		SSDFS_ERR("invalid offset into the page: "
+			  "offset %u, index_size %u\n",
+			  *page_off, area->index_size);
+		return -ERANGE;
+	}
+
+	if (*page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("invalid page index: "
+			  "page_index %u, pagevec_count %u\n",
+			  *page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_init_index_area_hash_range() - extract hash range of index area
+ * @node: node object
+ * @index_count: count of indexes in the node
+ * @start_hash: starting hash of index area [out]
+ * @end_hash: ending hash of index area [out]
+ *
+ * This method tries to extract start and end hash from
+ * the raw index area.
+ *
+
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_init_index_area_hash_range(struct ssdfs_btree_node *node,
+					u16 index_count,
+					u64 *start_hash, u64 *end_hash)
+{
+	struct ssdfs_btree_index_key *ptr;
+	struct page *page;
+	void *kaddr;
+	u32 page_index;
+	u32 page_off;
+	u16 position;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+	BUG_ON(!start_hash || !end_hash);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, height %u\n",
+		  node->node_id,
+		  atomic_read(&node->height));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_hash = U64_MAX;
+	*end_hash = U64_MAX;
+
+	if (index_count == 0)
+		return 0;
+
+	position = 0;
+
+	err = ssdfs_define_memory_page(node, &node->index_area,
+					position,
+					&page_index, &page_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define memory page: "
+			  "node_id %u, position %u, err %d\n",
+			  node->node_id, position, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(page_index >= U32_MAX);
+	BUG_ON(page_off >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("page_index %u > pvec_size %u\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	page = node->content.pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_lock_page(page);
+	kaddr = kmap_local_page(page);
+	ptr = (struct ssdfs_btree_index_key *)((u8 *)kaddr + page_off);
+	*start_hash = le64_to_cpu(ptr->index.hash);
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+
+	position = index_count - 1;
+
+	if (position == 0) {
+		*end_hash = *start_hash;
+		return 0;
+	}
+
+	err = ssdfs_define_memory_page(node, &node->index_area,
+					position,
+					&page_index, &page_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define memory page: "
+			  "node_id %u, position %u, err %d\n",
+			  node->node_id, position, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(page_index >= U32_MAX);
+	BUG_ON(page_off >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("page_index %u > pvec_size %u\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	page = node->content.pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_lock_page(page);
+	kaddr = kmap_local_page(page);
+	ptr = (struct ssdfs_btree_index_key *)((u8 *)kaddr + page_off);
+	*end_hash = le64_to_cpu(ptr->index.hash);
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+
+	return 0;
+}
+
+/*
+ * ssdfs_init_index_area_hash_range() - extract hash range of index area
+ * @node: node object
+ * @hdr: node's header
+ * @start_hash: starting hash of index area [out]
+ * @end_hash: ending hash of index area [out]
+ *
+ * This method tries to extract start and end hash from
+ * the raw index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_init_index_area_hash_range(struct ssdfs_btree_node *node,
+				     struct ssdfs_btree_node_header *hdr,
+				     u64 *start_hash, u64 *end_hash)
+{
+	u16 flags;
+	u16 index_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !hdr);
+	BUG_ON(!start_hash || !end_hash);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, height %u\n",
+		  node->node_id,
+		  atomic_read(&node->height));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_hash = U64_MAX;
+	*end_hash = U64_MAX;
+
+	flags = le16_to_cpu(hdr->flags);
+	if (!(flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA))
+		return 0;
+
+	index_count = le16_to_cpu(hdr->index_count);
+	if (index_count == 0)
+		return 0;
+
+	return __ssdfs_init_index_area_hash_range(node, index_count,
+						  start_hash, end_hash);
+}
+
+/*
+ * ssdfs_btree_init_node_index_area() - init the node's index area
+ * @node: node object
+ * @hdr: node's header
+ * @hdr_size: size of the header
+ *
+ * This method tries to init the node's index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - header is corrupted.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_init_node_index_area(struct ssdfs_btree_node *node,
+				     struct ssdfs_btree_node_header *hdr,
+				     size_t hdr_size)
+{
+	u16 flags;
+	u32 index_area_size;
+	u8 index_size;
+	u16 index_count;
+	u16 index_capacity;
+	u32 offset;
+	u64 start_hash = U64_MAX;
+	u64 end_hash = U64_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !hdr);
+	BUG_ON(hdr_size <= sizeof(struct ssdfs_btree_node_header));
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, height %u\n",
+		  node->node_id,
+		  atomic_read(&node->height));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	flags = le16_to_cpu(hdr->flags);
+	index_area_size = 0;
+
+	if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+		index_area_size = 1 << hdr->log_index_area_size;
+
+		if (index_area_size == 0 ||
+		    index_area_size > node->node_size) {
+			SSDFS_ERR("invalid index area size %u\n",
+				  index_area_size);
+			return -EIO;
+		}
+
+		switch (hdr->type) {
+		case SSDFS_BTREE_INDEX_NODE:
+			if (index_area_size != node->node_size) {
+				SSDFS_ERR("invalid index area's size: "
+					  "index_area_size %u, node_size %u\n",
+					  index_area_size,
+					  node->node_size);
+				return -EIO;
+			}
+
+			index_area_size -= hdr_size;
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid node type %#x\n",
+				  hdr->type);
+			return -EIO;
+		}
+	} else {
+		if (index_area_size != 0) {
+			SSDFS_ERR("invalid index area size %u\n",
+				  index_area_size);
+			return -EIO;
+		}
+
+		switch (hdr->type) {
+		case SSDFS_BTREE_LEAF_NODE:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid node type %#x\n",
+				  hdr->type);
+			return -EIO;
+		}
+	}
+
+	index_size = hdr->index_size;
+	index_count = le16_to_cpu(hdr->index_count);
+
+	if (index_area_size < ((u32)index_count * index_size)) {
+		SSDFS_ERR("index area is corrupted: "
+			  "index_area_size %u, index_count %u, "
+			  "index_size %u\n",
+			  index_area_size,
+			  index_count,
+			  index_size);
+		return -EIO;
+	}
+
+	index_capacity = index_area_size / index_size;
+	if (index_capacity < index_count) {
+		SSDFS_ERR("index_capacity %u < index_count %u\n",
+			  index_capacity, index_count);
+		return -ERANGE;
+	}
+
+	if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+		atomic_set(&node->index_area.state,
+				SSDFS_BTREE_NODE_INDEX_AREA_EXIST);
+
+		offset = le16_to_cpu(hdr->index_area_offset);
+
+		if (offset != hdr_size) {
+			SSDFS_ERR("invalid index_area_offset %u\n",
+				  offset);
+			return -EIO;
+		}
+
+		if ((offset + index_area_size) > node->node_size) {
+			SSDFS_ERR("offset %u + area_size %u > node_size %u\n",
+				  offset, index_area_size, node->node_size);
+			return -ERANGE;
+		}
+
+		node->index_area.offset = offset;
+		node->index_area.area_size = index_area_size;
+		node->index_area.index_size = index_size;
+		node->index_area.index_count = index_count;
+		node->index_area.index_capacity = index_capacity;
+
+		err = ssdfs_init_index_area_hash_range(node, hdr,
+						       &start_hash,
+						       &end_hash);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to retrieve index area hash range: "
+				  "err %d\n",
+				  err);
+			return err;
+		}
+
+		node->index_area.start_hash = start_hash;
+		node->index_area.end_hash = end_hash;
+
+		if (start_hash > end_hash) {
+			SSDFS_WARN("node_id %u, height %u, "
+				   "start_hash %llx, end_hash %llx\n",
+				   node->node_id,
+				   atomic_read(&node->height),
+				   start_hash,
+				   end_hash);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#else
+			return -EIO;
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	} else {
+		atomic_set(&node->index_area.state,
+				SSDFS_BTREE_NODE_AREA_ABSENT);
+		node->index_area.offset = U32_MAX;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(index_area_size != 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+		node->index_area.area_size = index_area_size;
+		node->index_area.index_size = index_size;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(index_count != 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+		node->index_area.index_count = index_count;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(index_capacity != 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+		node->index_area.index_capacity = index_capacity;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(start_hash != U64_MAX);
+		BUG_ON(end_hash != U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+		node->index_area.start_hash = start_hash;
+		node->index_area.end_hash = end_hash;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "index_count %u, index_capacity %u\n",
+		  start_hash, end_hash,
+		  index_count, index_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_init_node_items_area() - init the node's items area
+ * @node: node object
+ * @hdr: node's header
+ * @hdr_size: size of the header
+ *
+ * This method tries to init the node's items area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - header is corrupted.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_init_node_items_area(struct ssdfs_btree_node *node,
+				     struct ssdfs_btree_node_header *hdr,
+				     size_t hdr_size)
+{
+	u16 flags;
+	u32 index_area_size;
+	u32 items_area_size;
+	u8 min_item_size;
+	u16 max_item_size;
+	u32 offset;
+	u64 start_hash;
+	u64 end_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !hdr);
+	BUG_ON(hdr_size <= sizeof(struct ssdfs_btree_node_header));
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, height %u\n",
+		  node->node_id,
+		  atomic_read(&node->height));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	flags = le16_to_cpu(hdr->flags);
+
+	if (hdr->log_index_area_size > 0) {
+		index_area_size = 1 << hdr->log_index_area_size;
+
+		switch (hdr->type) {
+		case SSDFS_BTREE_INDEX_NODE:
+			if (index_area_size != node->node_size) {
+				SSDFS_ERR("invalid index area's size: "
+					  "index_area_size %u, node_size %u\n",
+					  index_area_size,
+					  node->node_size);
+				return -EIO;
+			}
+
+			index_area_size -= hdr_size;
+			break;
+
+		case SSDFS_BTREE_HYBRID_NODE:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid node type %#x\n",
+				  hdr->type);
+			return -EIO;
+		}
+	} else
+		index_area_size = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON((index_area_size + hdr_size) > node->node_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	items_area_size = node->node_size;
+	items_area_size -= index_area_size;
+	items_area_size -= hdr_size;
+
+	if (flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA) {
+		if (items_area_size == 0) {
+			SSDFS_ERR("invalid items area size %u\n",
+				  items_area_size);
+			return -EIO;
+		}
+
+		switch (hdr->type) {
+		case SSDFS_BTREE_HYBRID_NODE:
+		case SSDFS_BTREE_LEAF_NODE:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid node type %#x\n",
+				  hdr->type);
+			return -EIO;
+		}
+	} else {
+		if (items_area_size != 0) {
+			SSDFS_ERR("invalid items area size %u\n",
+				  items_area_size);
+			return -EIO;
+		}
+
+		switch (hdr->type) {
+		case SSDFS_BTREE_INDEX_NODE:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_ERR("invalid node type %#x\n",
+				  hdr->type);
+			return -EIO;
+		}
+	}
+
+	offset = hdr_size + index_area_size;
+
+	switch (hdr->type) {
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_LEAF_NODE:
+		if (offset != le32_to_cpu(hdr->item_area_offset)) {
+			SSDFS_ERR("invalid item_area_offset %u\n",
+				  le32_to_cpu(hdr->item_area_offset));
+			return -EIO;
+		}
+		break;
+	}
+
+	if ((offset + items_area_size) > node->node_size) {
+		SSDFS_ERR("offset %u + items_area_size %u > node_size %u\n",
+			  offset, items_area_size, node->node_size);
+		return -ERANGE;
+	}
+
+	min_item_size = hdr->min_item_size;
+	max_item_size = le16_to_cpu(hdr->max_item_size);
+
+	if (max_item_size < min_item_size) {
+		SSDFS_ERR("invalid item size: "
+			  "min size %u, max size %u\n",
+			  min_item_size, max_item_size);
+		return -EIO;
+	}
+
+	start_hash = le64_to_cpu(hdr->start_hash);
+	end_hash = le64_to_cpu(hdr->end_hash);
+
+	if (start_hash > end_hash) {
+		SSDFS_WARN("start_hash %llx > end_hash %llx\n",
+			   start_hash, end_hash);
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#else
+		return -EIO;
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	if (flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA) {
+		atomic_set(&node->items_area.state,
+				SSDFS_BTREE_NODE_ITEMS_AREA_EXIST);
+		node->items_area.offset = offset;
+		node->items_area.area_size = items_area_size;
+		node->items_area.min_item_size = node->tree->item_size;
+		node->items_area.min_item_size = min_item_size;
+		node->items_area.max_item_size = max_item_size;
+		node->items_area.items_count = U16_MAX;
+		node->items_area.items_capacity = U16_MAX;
+		node->items_area.start_hash = start_hash;
+		node->items_area.end_hash = end_hash;
+	} else {
+		atomic_set(&node->items_area.state,
+				SSDFS_BTREE_NODE_AREA_ABSENT);
+		node->items_area.offset = U32_MAX;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(items_area_size != 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+		node->items_area.area_size = items_area_size;
+		node->items_area.min_item_size = node->tree->item_size;
+		node->items_area.min_item_size = min_item_size;
+		node->items_area.max_item_size = max_item_size;
+		node->items_area.items_count = 0;
+		node->items_area.items_capacity = 0;
+		node->items_area.start_hash = U64_MAX;
+		node->items_area.end_hash = U64_MAX;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "items_count %u, items_capacity %u\n",
+		  start_hash, end_hash,
+		  node->items_area.items_count,
+		  node->items_area.items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_init_node() - init node object
+ * @node: node object
+ * @hdr: node's header
+ * @hdr_size: size of the header
+ *
+ * This method tries to init the node object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - header is corrupted.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_init_node(struct ssdfs_btree_node *node,
+			  struct ssdfs_btree_node_header *hdr,
+			  size_t hdr_size)
+{
+	u8 tree_height;
+	u64 create_cno;
+	u16 flags;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !hdr);
+	BUG_ON(hdr_size <= sizeof(struct ssdfs_btree_node_header));
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("node %p, hdr %p, node_id %u\n",
+		  node, hdr, node->node_id);
+#else
+	SSDFS_DBG("node %p, hdr %p, node_id %u\n",
+		  node, hdr, node->node_id);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree_height = atomic_read(&node->tree->height);
+	if (hdr->height >= tree_height) {
+		SSDFS_ERR("invalid height: "
+			  "tree_height %u, node_height %u\n",
+			  tree_height, hdr->height);
+		return -EIO;
+	}
+	atomic_set(&node->height, hdr->height);
+
+	if (node->node_size != (1 << hdr->log_node_size)) {
+		SSDFS_ERR("invalid node size: "
+			  "node_size %u != node_size %u\n",
+			  node->node_size,
+			  (1 << hdr->log_node_size));
+		return -EIO;
+	}
+
+	if (le32_to_cpu(hdr->node_id) != node->node_id) {
+		SSDFS_WARN("node->node_id %u != hdr->node_id %u\n",
+			   node->node_id,
+			   le32_to_cpu(hdr->node_id));
+		return -EIO;
+	}
+
+	create_cno = le64_to_cpu(hdr->create_cno);
+	if (create_cno < node->tree->create_cno) {
+		SSDFS_ERR("create_cno %llu < node->tree->create_cno %llu\n",
+			  create_cno,
+			  node->tree->create_cno);
+		return -EIO;
+	}
+	node->create_cno = create_cno;
+
+	flags = le16_to_cpu(hdr->flags);
+	if (flags & ~SSDFS_BTREE_NODE_FLAGS_MASK) {
+		SSDFS_ERR("invalid flags %#x\n",
+			  flags);
+		return -EIO;
+	}
+	atomic_set(&node->flags, flags);
+
+	if (hdr->type <= SSDFS_BTREE_ROOT_NODE ||
+	    hdr->type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_ERR("invalid type %#x\n",
+			  hdr->type);
+		return -EIO;
+	}
+	atomic_set(&node->type, hdr->type);
+
+	switch (hdr->type) {
+	case SSDFS_BTREE_INDEX_NODE:
+		if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA &&
+		    !(flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA)) {
+			/*
+			 * expected set of flags
+			 */
+		} else {
+			SSDFS_ERR("invalid set of flags %#x for index node\n",
+				  flags);
+			return -EIO;
+		}
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA &&
+		    flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA) {
+			/*
+			 * expected set of flags
+			 */
+		} else {
+			SSDFS_ERR("invalid set of flags %#x for hybrid node\n",
+				  flags);
+			return -EIO;
+		}
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		if (!(flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) &&
+		    flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA) {
+			/*
+			 * expected set of flags
+			 */
+		} else {
+			SSDFS_ERR("invalid set of flags %#x for leaf node\n",
+				  flags);
+			return -EIO;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid node type %#x\n", hdr->type);
+		return -ERANGE;
+	};
+
+	err = ssdfs_btree_init_node_index_area(node, hdr, hdr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init index area: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		return err;
+	}
+
+	err = ssdfs_btree_init_node_items_area(node, hdr, hdr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init items area: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
diff --git a/fs/ssdfs/btree_node.h b/fs/ssdfs/btree_node.h
new file mode 100644
index 000000000000..4dbb98ab1d61
--- /dev/null
+++ b/fs/ssdfs/btree_node.h
@@ -0,0 +1,768 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/btree_node.h - btree node declarations.
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
+#ifndef _SSDFS_BTREE_NODE_H
+#define _SSDFS_BTREE_NODE_H
+
+#include "request_queue.h"
+
+/*
+ * struct ssdfs_btree_node_operations - node operations specialization
+ * @find_item: specialized item searching algorithm
+ * @find_range: specialized range searching algorithm
+ * @extract_range: specialized extract range operation
+ * @allocate_item: specialized item allocation operation
+ * @allocate_range: specialized range allocation operation
+ * @insert_item: specialized insert item operation
+ * @insert_range: specialized insert range operation
+ * @change_item: specialized change item operation
+ * @delete_item: specialized delete item operation
+ * @delete_range: specialized delete range operation
+ * @move_items_range: specialized move items operation
+ * @resize_items_area: specialized resize items area operation
+ */
+struct ssdfs_btree_node_operations {
+	int (*find_item)(struct ssdfs_btree_node *node,
+			 struct ssdfs_btree_search *search);
+	int (*find_range)(struct ssdfs_btree_node *node,
+			  struct ssdfs_btree_search *search);
+	int (*extract_range)(struct ssdfs_btree_node *node,
+			     u16 start_index, u16 count,
+			     struct ssdfs_btree_search *search);
+	int (*allocate_item)(struct ssdfs_btree_node *node,
+			     struct ssdfs_btree_search *search);
+	int (*allocate_range)(struct ssdfs_btree_node *node,
+			      struct ssdfs_btree_search *search);
+	int (*insert_item)(struct ssdfs_btree_node *node,
+			   struct ssdfs_btree_search *search);
+	int (*insert_range)(struct ssdfs_btree_node *node,
+			    struct ssdfs_btree_search *search);
+	int (*change_item)(struct ssdfs_btree_node *node,
+			   struct ssdfs_btree_search *search);
+	int (*delete_item)(struct ssdfs_btree_node *node,
+			   struct ssdfs_btree_search *search);
+	int (*delete_range)(struct ssdfs_btree_node *node,
+			    struct ssdfs_btree_search *search);
+	int (*move_items_range)(struct ssdfs_btree_node *src,
+				struct ssdfs_btree_node *dst,
+				u16 start_item, u16 count);
+	int (*resize_items_area)(struct ssdfs_btree_node *node,
+				 u32 new_size);
+};
+
+/* Btree node area's states */
+enum {
+	SSDFS_BTREE_NODE_AREA_UNKNOWN_STATE,
+	SSDFS_BTREE_NODE_AREA_ABSENT,
+	SSDFS_BTREE_NODE_INDEX_AREA_EXIST,
+	SSDFS_BTREE_NODE_ITEMS_AREA_EXIST,
+	SSDFS_BTREE_NODE_LOOKUP_TBL_EXIST,
+	SSDFS_BTREE_NODE_HASH_TBL_EXIST,
+	SSDFS_BTREE_NODE_AREA_STATE_MAX
+};
+
+/*
+ * struct ssdfs_btree_node_index_area - btree node's index area
+ * @state: area state
+ * @offset: area offset from node's beginning
+ * @area_size: area size in bytes
+ * @index_size: index size in bytes
+ * @index_count: count of indexes in area
+ * @index_capacity: index area capacity
+ * @start_hash: starting hash in index area
+ * @end_hash: ending hash in index area
+ */
+struct ssdfs_btree_node_index_area {
+	atomic_t state;
+
+	u32 offset;
+	u32 area_size;
+
+	u8 index_size;
+	u16 index_count;
+	u16 index_capacity;
+
+	u64 start_hash;
+	u64 end_hash;
+};
+
+/*
+ * struct ssdfs_btree_node_items_area - btree node's data area
+ * @state: area state
+ * @offset: area offset from node's beginning
+ * @area_size: area size in bytes
+ * @free_space: free space in bytes
+ * @item_size: item size in bytes
+ * @min_item_size: minimal possible item size in bytes
+ * @max_item_size: maximal possible item size in bytes
+ * @items_count: count of allocated items in area
+ * @items_capacity: items area capacity
+ * @start_hash: starting hash in items area
+ * @end_hash: ending hash in items area
+ */
+struct ssdfs_btree_node_items_area {
+	atomic_t state;
+
+	u32 offset;
+	u32 area_size;
+	u32 free_space;
+
+	u16 item_size;
+	u8 min_item_size;
+	u16 max_item_size;
+
+	u16 items_count;
+	u16 items_capacity;
+
+	u64 start_hash;
+	u64 end_hash;
+};
+
+struct ssdfs_btree;
+
+/*
+ * struct ssdfs_state_bitmap - bitmap of states
+ * @lock: bitmap lock
+ * @flags: bitmap's flags
+ * @ptr: bitmap
+ */
+struct ssdfs_state_bitmap {
+	spinlock_t lock;
+
+#define SSDFS_LOOKUP_TBL2_IS_USING	(1 << 0)
+#define SSDFS_HASH_TBL_IS_USING		(1 << 1)
+#define SSDFS_BMAP_ARRAY_FLAGS_MASK	0x3
+	u32 flags;
+
+	unsigned long *ptr;
+};
+
+/*
+ * struct ssdfs_state_bitmap_array - array of bitmaps
+ * @lock: bitmap array lock
+ * @bits_count: whole bits count in the bitmap
+ * @bmap_bytes: size in bytes of every bitmap
+ * @index_start_bit: starting bit of index area in the bitmap
+ * @item_start_bit: starting bit of items area in the bitmap
+ * @bmap: partial locks, alloc and dirty bitmaps
+ */
+struct ssdfs_state_bitmap_array {
+	struct rw_semaphore lock;
+	unsigned long bits_count;
+	size_t bmap_bytes;
+	unsigned long index_start_bit;
+	unsigned long item_start_bit;
+
+#define SSDFS_BTREE_NODE_LOCK_BMAP	(0)
+#define SSDFS_BTREE_NODE_ALLOC_BMAP	(1)
+#define SSDFS_BTREE_NODE_DIRTY_BMAP	(2)
+#define SSDFS_BTREE_NODE_BMAP_COUNT	(3)
+	struct ssdfs_state_bitmap bmap[SSDFS_BTREE_NODE_BMAP_COUNT];
+};
+
+/*
+ * struct ssdfs_btree_node_content - btree node's content
+ * @pvec: page vector
+ */
+struct ssdfs_btree_node_content {
+	struct pagevec pvec;
+};
+
+union ssdfs_aggregated_btree_node_header {
+	struct ssdfs_inodes_btree_node_header inodes_header;
+	struct ssdfs_dentries_btree_node_header dentries_header;
+	struct ssdfs_extents_btree_node_header extents_header;
+	struct ssdfs_xattrs_btree_node_header xattrs_header;
+};
+
+/*
+ * struct ssdfs_btree_node - btree node
+ * @height: node's height
+ * @node_size: node size in bytes
+ * @pages_per_node: count of memory pages per node
+ * @create_cno: create checkpoint
+ * @node_id: node identification number
+ * @tree: pointer on node's parent tree
+ * @node_ops: btree's node operation specialization
+ * @refs_count: reference counter
+ * @state: node state
+ * @flags: node's flags
+ * @type: node type
+ * @header_lock: header lock
+ * @raw.root_node: root node copy
+ * @raw.generic_header: generic node's header
+ * @raw.inodes_header: inodes node's header
+ * @raw.dentries_header: dentries node's header
+ * @raw.extents_header: extents node's header
+ * @raw.dict_header: shared dictionary node's header
+ * @raw.xattrs_header: xattrs node's header
+ * @raw.shextree_header: shared extents tree's header
+ * @raw.snapshots_header: snapshots node's header
+ * @raw.invextree_header: invalidated extents tree's header
+ * @index_area: index area descriptor
+ * @items_area: items area descriptor
+ * @lookup_tbl_area: lookup table's area descriptor
+ * @hash_tbl_area: hash table's area descriptor
+ * @descriptor_lock: node's descriptor lock
+ * @update_cno: last update checkpoint
+ * @parent_node: pointer on parent node
+ * @node_index: node's index (for using in search operations)
+ * @extent: node's location
+ * @seg: pointer on segment object
+ * @init_end: wait of init ending
+ * @flush_req: flush request
+ * @bmap_array: partial locks, alloc and dirty bitmaps
+ * @wait_queue: queue of threads are waiting partial lock
+ * @full_lock: the whole node lock
+ * @content: node's content
+ */
+struct ssdfs_btree_node {
+	/* static data */
+	atomic_t height;
+	u32 node_size;
+	u8 pages_per_node;
+	u64 create_cno;
+	u32 node_id;
+
+	struct ssdfs_btree *tree;
+
+	/* btree's node operation specialization */
+	const struct ssdfs_btree_node_operations *node_ops;
+
+	/*
+	 * Reference counter
+	 * The goal of reference counter is to account how
+	 * many btree search objects are referencing the
+	 * node's object. If some thread deletes all records
+	 * in a node then the node will be left undeleted
+	 * from the tree in the case of @refs_count is greater
+	 * than one.
+	 */
+	atomic_t refs_count;
+
+	/* mutable data */
+	atomic_t state;
+	atomic_t flags;
+	atomic_t type;
+
+	/* node's header */
+	struct rw_semaphore header_lock;
+	union {
+		struct ssdfs_btree_inline_root_node root_node;
+		struct ssdfs_btree_node_header generic_header;
+		struct ssdfs_inodes_btree_node_header inodes_header;
+		struct ssdfs_dentries_btree_node_header dentries_header;
+		struct ssdfs_extents_btree_node_header extents_header;
+		struct ssdfs_shared_dictionary_node_header dict_header;
+		struct ssdfs_xattrs_btree_node_header xattrs_header;
+		struct ssdfs_shextree_node_header shextree_header;
+		struct ssdfs_snapshots_btree_node_header snapshots_header;
+		struct ssdfs_invextree_node_header invextree_header;
+	} raw;
+	struct ssdfs_btree_node_index_area index_area;
+	struct ssdfs_btree_node_items_area items_area;
+	struct ssdfs_btree_node_index_area lookup_tbl_area;
+	struct ssdfs_btree_node_index_area hash_tbl_area;
+
+	/* node's descriptor */
+	spinlock_t descriptor_lock;
+	u64 update_cno;
+	struct ssdfs_btree_node *parent_node;
+	struct ssdfs_btree_index_key node_index;
+	struct ssdfs_raw_extent extent;
+	struct ssdfs_segment_info *seg;
+	struct completion init_end;
+	struct ssdfs_segment_request flush_req;
+
+	/* partial locks, alloc and dirty bitmaps */
+	struct ssdfs_state_bitmap_array bmap_array;
+	wait_queue_head_t wait_queue;
+
+	/* node raw content */
+	struct rw_semaphore full_lock;
+	struct ssdfs_btree_node_content content;
+};
+
+/* Btree node states */
+enum {
+	SSDFS_BTREE_NODE_UNKNOWN_STATE,
+	SSDFS_BTREE_NODE_CREATED,
+	SSDFS_BTREE_NODE_CONTENT_PREPARED,
+	SSDFS_BTREE_NODE_INITIALIZED,
+	SSDFS_BTREE_NODE_DIRTY,
+	SSDFS_BTREE_NODE_PRE_DELETED,
+	SSDFS_BTREE_NODE_INVALID,
+	SSDFS_BTREE_NODE_CORRUPTED,
+	SSDFS_BTREE_NODE_STATE_MAX
+};
+
+/*
+ * TODO: it is possible to use knowledge about partial
+ *       updates and to send only changed pieces of
+ *       data for the case of Diff-On-Write approach.
+ *       Metadata is good case for determination of
+ *       partial updates and to send changed part(s)
+ *       only. For example, bitmap could show dirty
+ *       items in the node.
+ */
+
+/*
+ * Inline functions
+ */
+
+/*
+ * NODE2SEG_TYPE() - convert node type into segment type
+ * @node_type: node type
+ */
+static inline
+u8 NODE2SEG_TYPE(u8 node_type)
+{
+	switch (node_type) {
+	case SSDFS_BTREE_INDEX_NODE:
+		return SSDFS_INDEX_NODE_SEG_TYPE;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		return SSDFS_HYBRID_NODE_SEG_TYPE;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		return SSDFS_LEAF_NODE_SEG_TYPE;
+	}
+
+	SSDFS_WARN("invalid node type %#x\n", node_type);
+
+	return SSDFS_UNKNOWN_SEG_TYPE;
+}
+
+/*
+ * RANGE_WITHOUT_INTERSECTION() - check that ranges have intersection
+ * @start1: starting hash of the first range
+ * @end1: ending hash of the first range
+ * @start2: starting hash of the second range
+ * @end2: ending hash of the second range
+ *
+ * This method checks that ranges have intersection.
+ *
+ * RETURN:
+ *  0  - ranges have intersection
+ *  1  - range1 > range2
+ * -1  - range1 < range2
+ */
+static inline
+int RANGE_WITHOUT_INTERSECTION(u64 start1, u64 end1, u64 start2, u64 end2)
+{
+	SSDFS_DBG("start1 %llx, end1 %llx, start2 %llx, end2 %llx\n",
+		  start1, end1, start2, end2);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(start1 >= U64_MAX || end1 >= U64_MAX ||
+		start2 >= U64_MAX || end2 >= U64_MAX);
+	BUG_ON(start1 > end1);
+	BUG_ON(start2 > end2);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (start1 > end2)
+		return 1;
+
+	if (end1 < start2)
+		return -1;
+
+	return 0;
+}
+
+/*
+ * RANGE_HAS_PARTIAL_INTERSECTION() - check that ranges intersect partially
+ * @start1: starting hash of the first range
+ * @end1: ending hash of the first range
+ * @start2: starting hash of the second range
+ * @end2: ending hash of the second range
+ */
+static inline
+bool RANGE_HAS_PARTIAL_INTERSECTION(u64 start1, u64 end1,
+				    u64 start2, u64 end2)
+{
+	SSDFS_DBG("start1 %llx, end1 %llx, start2 %llx, end2 %llx\n",
+		  start1, end1, start2, end2);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(start1 >= U64_MAX || end1 >= U64_MAX ||
+		start2 >= U64_MAX || end2 >= U64_MAX);
+	BUG_ON(start1 > end1);
+	BUG_ON(start2 > end2);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (start1 > end2)
+		return false;
+
+	if (end1 < start2)
+		return false;
+
+	return true;
+}
+
+/*
+ * __ssdfs_items_per_lookup_index() - calculate items per lookup index
+ * @items_per_node: number of items per node
+ * @lookup_table_capacity: maximal number of items in lookup table
+ */
+static inline
+u16 __ssdfs_items_per_lookup_index(u32 items_per_node,
+				   int lookup_table_capacity)
+{
+	u32 items_per_lookup_index;
+
+	items_per_lookup_index = items_per_node / lookup_table_capacity;
+
+	if (items_per_node % lookup_table_capacity)
+		items_per_lookup_index++;
+
+	SSDFS_DBG("items_per_lookup_index %u\n", items_per_lookup_index);
+
+	return items_per_lookup_index;
+}
+
+/*
+ * __ssdfs_convert_lookup2item_index() - convert lookup into item index
+ * @lookup_index: lookup index
+ * @node_size: size of the node in bytes
+ * @item_size: size of the item in bytes
+ * @lookup_table_capacity: maximal number of items in lookup table
+ */
+static inline
+u16 __ssdfs_convert_lookup2item_index(u16 lookup_index,
+					u32 node_size,
+					size_t item_size,
+					int lookup_table_capacity)
+{
+	u32 items_per_node;
+	u32 items_per_lookup_index;
+	u32 item_index;
+
+	SSDFS_DBG("lookup_index %u, node_size %u, "
+		  "item_size %zu, table_capacity %d\n",
+		  lookup_index, node_size,
+		  item_size, lookup_table_capacity);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(lookup_index >= lookup_table_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	items_per_node = node_size / item_size;
+	items_per_lookup_index = __ssdfs_items_per_lookup_index(items_per_node,
+							lookup_table_capacity);
+
+	item_index = (u32)lookup_index * items_per_lookup_index;
+
+	SSDFS_DBG("lookup_index %u, item_index %u\n",
+		  lookup_index, item_index);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(item_index >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u16)item_index;
+}
+
+/*
+ * __ssdfs_convert_item2lookup_index() - convert item into lookup index
+ * @item_index: item index
+ * @node_size: size of the node in bytes
+ * @item_size: size of the item in bytes
+ * @lookup_table_capacity: maximal number of items in lookup table
+ */
+static inline
+u16 __ssdfs_convert_item2lookup_index(u16 item_index,
+					u32 node_size,
+					size_t item_size,
+					int lookup_table_capacity)
+{
+	u32 items_per_node;
+	u32 items_per_lookup_index;
+	u16 lookup_index;
+
+	SSDFS_DBG("item_index %u, node_size %u, "
+		  "item_size %zu, table_capacity %d\n",
+		  item_index, node_size,
+		  item_size, lookup_table_capacity);
+
+	items_per_node = node_size / item_size;
+	items_per_lookup_index = __ssdfs_items_per_lookup_index(items_per_node,
+							lookup_table_capacity);
+	lookup_index = item_index / items_per_lookup_index;
+
+	SSDFS_DBG("item_index %u, lookup_index %u, table_capacity %d\n",
+		  item_index, lookup_index, lookup_table_capacity);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(lookup_index >= lookup_table_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return lookup_index;
+}
+
+/*
+ * Btree node API
+ */
+struct ssdfs_btree_node *
+ssdfs_btree_node_create(struct ssdfs_btree *tree,
+			u32 node_id,
+			struct ssdfs_btree_node *parent,
+			u8 height, int type, u64 start_hash);
+void ssdfs_btree_node_destroy(struct ssdfs_btree_node *node);
+int ssdfs_btree_node_prepare_content(struct ssdfs_btree_node *node,
+				     struct ssdfs_btree_index_key *index);
+int ssdfs_btree_init_node(struct ssdfs_btree_node *node,
+			  struct ssdfs_btree_node_header *hdr,
+			  size_t hdr_size);
+int ssdfs_btree_pre_flush_root_node(struct ssdfs_btree_node *node);
+void ssdfs_btree_flush_root_node(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_inline_root_node *root_node);
+int ssdfs_btree_node_pre_flush(struct ssdfs_btree_node *node);
+int ssdfs_btree_node_flush(struct ssdfs_btree_node *node);
+
+void ssdfs_btree_node_get(struct ssdfs_btree_node *node);
+void ssdfs_btree_node_put(struct ssdfs_btree_node *node);
+bool is_ssdfs_node_shared(struct ssdfs_btree_node *node);
+
+bool is_ssdfs_btree_node_dirty(struct ssdfs_btree_node *node);
+void set_ssdfs_btree_node_dirty(struct ssdfs_btree_node *node);
+void clear_ssdfs_btree_node_dirty(struct ssdfs_btree_node *node);
+bool is_ssdfs_btree_node_pre_deleted(struct ssdfs_btree_node *node);
+void set_ssdfs_btree_node_pre_deleted(struct ssdfs_btree_node *node);
+void clear_ssdfs_btree_node_pre_deleted(struct ssdfs_btree_node *node);
+
+bool is_ssdfs_btree_node_index_area_exist(struct ssdfs_btree_node *node);
+bool is_ssdfs_btree_node_index_area_empty(struct ssdfs_btree_node *node);
+int ssdfs_btree_node_resize_index_area(struct ssdfs_btree_node *node,
+					u32 new_size);
+int ssdfs_btree_node_find_index(struct ssdfs_btree_search *search);
+bool can_add_new_index(struct ssdfs_btree_node *node);
+int ssdfs_btree_node_add_index(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_index_key *key);
+int ssdfs_btree_node_change_index(struct ssdfs_btree_node *node,
+				  struct ssdfs_btree_index_key *old_key,
+				  struct ssdfs_btree_index_key *new_key);
+int ssdfs_btree_node_delete_index(struct ssdfs_btree_node *node,
+				  u64 hash);
+
+bool is_ssdfs_btree_node_items_area_exist(struct ssdfs_btree_node *node);
+bool is_ssdfs_btree_node_items_area_empty(struct ssdfs_btree_node *node);
+int ssdfs_btree_node_find_item(struct ssdfs_btree_search *search);
+int ssdfs_btree_node_find_range(struct ssdfs_btree_search *search);
+int ssdfs_btree_node_allocate_item(struct ssdfs_btree_search *search);
+int ssdfs_btree_node_allocate_range(struct ssdfs_btree_search *search);
+int ssdfs_btree_node_insert_item(struct ssdfs_btree_search *search);
+int ssdfs_btree_node_insert_range(struct ssdfs_btree_search *search);
+int ssdfs_btree_node_change_item(struct ssdfs_btree_search *search);
+int ssdfs_btree_node_delete_item(struct ssdfs_btree_search *search);
+int ssdfs_btree_node_delete_range(struct ssdfs_btree_search *search);
+
+/*
+ * Internal Btree node API
+ */
+int ssdfs_lock_items_range(struct ssdfs_btree_node *node,
+			   u16 start_index, u16 count);
+void ssdfs_unlock_items_range(struct ssdfs_btree_node *node,
+				u16 start_index, u16 count);
+int ssdfs_lock_whole_index_area(struct ssdfs_btree_node *node);
+void ssdfs_unlock_whole_index_area(struct ssdfs_btree_node *node);
+int ssdfs_allocate_items_range(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_search *search,
+				u16 items_capacity,
+				u16 start_index, u16 count);
+bool is_ssdfs_node_items_range_allocated(struct ssdfs_btree_node *node,
+					 u16 items_capacity,
+					 u16 start_index, u16 count);
+int ssdfs_free_items_range(struct ssdfs_btree_node *node,
+			   u16 start_index, u16 count);
+int ssdfs_set_node_header_dirty(struct ssdfs_btree_node *node,
+				u16 items_capacity);
+void ssdfs_clear_node_header_dirty_state(struct ssdfs_btree_node *node);
+int ssdfs_set_dirty_items_range(struct ssdfs_btree_node *node,
+				u16 items_capacity,
+				u16 start_index, u16 count);
+void ssdfs_clear_dirty_items_range_state(struct ssdfs_btree_node *node,
+					 u16 start_index, u16 count);
+
+int ssdfs_btree_node_allocate_bmaps(void *addr[SSDFS_BTREE_NODE_BMAP_COUNT],
+				    size_t bmap_bytes);
+void ssdfs_btree_node_init_bmaps(struct ssdfs_btree_node *node,
+				void *addr[SSDFS_BTREE_NODE_BMAP_COUNT]);
+int ssdfs_btree_node_allocate_content_space(struct ssdfs_btree_node *node,
+					    u32 node_size);
+int __ssdfs_btree_node_prepare_content(struct ssdfs_fs_info *fsi,
+					struct ssdfs_btree_index_key *ptr,
+					u32 node_size,
+					u64 owner_id,
+					struct ssdfs_segment_info **si,
+					struct pagevec *pvec);
+int ssdfs_btree_create_root_node(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_inline_root_node *root_node);
+int ssdfs_btree_node_pre_flush_header(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_node_header *hdr);
+int ssdfs_btree_common_node_flush(struct ssdfs_btree_node *node);
+int ssdfs_btree_node_commit_log(struct ssdfs_btree_node *node);
+int ssdfs_btree_deleted_node_commit_log(struct ssdfs_btree_node *node);
+int __ssdfs_btree_root_node_extract_index(struct ssdfs_btree_node *node,
+					  u16 found_index,
+					  struct ssdfs_btree_index_key *ptr);
+int ssdfs_btree_root_node_delete_index(struct ssdfs_btree_node *node,
+					u16 position);
+int ssdfs_btree_common_node_delete_index(struct ssdfs_btree_node *node,
+					 u16 position);
+int ssdfs_find_index_by_hash(struct ssdfs_btree_node *node,
+			     struct ssdfs_btree_node_index_area *area,
+			     u64 hash,
+			     u16 *found_index);
+int ssdfs_btree_node_find_index_position(struct ssdfs_btree_node *node,
+					 u64 hash,
+					 u16 *found_position);
+int ssdfs_btree_node_extract_range(u16 start_index, u16 count,
+				   struct ssdfs_btree_search *search);
+int ssdfs_btree_node_get_index(struct pagevec *pvec,
+				u32 area_offset, u32 area_size,
+				u32 node_size, u16 position,
+				struct ssdfs_btree_index_key *ptr);
+int ssdfs_btree_node_move_index_range(struct ssdfs_btree_node *src,
+				      u16 src_start,
+				      struct ssdfs_btree_node *dst,
+				      u16 dst_start, u16 count);
+int ssdfs_btree_node_move_items_range(struct ssdfs_btree_node *src,
+				      struct ssdfs_btree_node *dst,
+				      u16 start_item, u16 count);
+int ssdfs_copy_item_in_buffer(struct ssdfs_btree_node *node,
+			      u16 index,
+			      size_t item_size,
+			      struct ssdfs_btree_search *search);
+bool is_last_leaf_node_found(struct ssdfs_btree_search *search);
+int ssdfs_btree_node_find_lookup_index_nolock(struct ssdfs_btree_search *search,
+						__le64 *lookup_table,
+						int table_capacity,
+						u16 *lookup_index);
+typedef int (*ssdfs_check_found_item)(struct ssdfs_fs_info *fsi,
+					struct ssdfs_btree_search *search,
+					void *kaddr,
+					u16 item_index,
+					u64 *start_hash,
+					u64 *end_hash,
+					u16 *found_index);
+typedef int (*ssdfs_prepare_result_buffer)(struct ssdfs_btree_search *search,
+					   u16 found_index,
+					   u64 start_hash,
+					   u64 end_hash,
+					   u16 items_count,
+					   size_t item_size);
+typedef int (*ssdfs_extract_found_item)(struct ssdfs_fs_info *fsi,
+					struct ssdfs_btree_search *search,
+					size_t item_size,
+					void *kaddr,
+					u64 *start_hash,
+					u64 *end_hash);
+int __ssdfs_extract_range_by_lookup_index(struct ssdfs_btree_node *node,
+				u16 lookup_index,
+				int lookup_table_capacity,
+				size_t item_size,
+				struct ssdfs_btree_search *search,
+				ssdfs_check_found_item check_item,
+				ssdfs_prepare_result_buffer prepare_buffer,
+				ssdfs_extract_found_item extract_item);
+int ssdfs_shift_range_right(struct ssdfs_btree_node *node,
+			    struct ssdfs_btree_node_items_area *area,
+			    size_t item_size,
+			    u16 start_index, u16 range_len,
+			    u16 shift);
+int ssdfs_shift_range_right2(struct ssdfs_btree_node *node,
+			     struct ssdfs_btree_node_index_area *area,
+			     size_t item_size,
+			     u16 start_index, u16 range_len,
+			     u16 shift);
+int ssdfs_shift_range_left(struct ssdfs_btree_node *node,
+			   struct ssdfs_btree_node_items_area *area,
+			   size_t item_size,
+			   u16 start_index, u16 range_len,
+			   u16 shift);
+int ssdfs_shift_range_left2(struct ssdfs_btree_node *node,
+			    struct ssdfs_btree_node_index_area *area,
+			    size_t item_size,
+			    u16 start_index, u16 range_len,
+			    u16 shift);
+int ssdfs_shift_memory_range_right(struct ssdfs_btree_node *node,
+				   struct ssdfs_btree_node_items_area *area,
+				   u16 offset, u16 range_len,
+				   u16 shift);
+int ssdfs_shift_memory_range_right2(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_index_area *area,
+				    u16 offset, u16 range_len,
+				    u16 shift);
+int ssdfs_shift_memory_range_left(struct ssdfs_btree_node *node,
+				   struct ssdfs_btree_node_items_area *area,
+				   u16 offset, u16 range_len,
+				   u16 shift);
+int ssdfs_shift_memory_range_left2(struct ssdfs_btree_node *node,
+				   struct ssdfs_btree_node_index_area *area,
+				   u16 offset, u16 range_len,
+				   u16 shift);
+int ssdfs_generic_insert_range(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *area,
+				size_t item_size,
+				struct ssdfs_btree_search *search);
+int ssdfs_invalidate_root_node_hierarchy(struct ssdfs_btree_node *node);
+int __ssdfs_btree_node_extract_range(struct ssdfs_btree_node *node,
+				     u16 start_index, u16 count,
+				     size_t item_size,
+				     struct ssdfs_btree_search *search);
+int __ssdfs_btree_node_resize_items_area(struct ssdfs_btree_node *node,
+					 size_t item_size,
+					 size_t index_size,
+					 u32 new_size);
+int __ssdfs_define_memory_page(u32 area_offset, u32 area_size,
+				u32 node_size, size_t item_size,
+				u16 position,
+				u32 *page_index, u32 *page_off);
+int ssdfs_btree_node_get_hash_range(struct ssdfs_btree_search *search,
+				    u64 *start_hash, u64 *end_hash,
+				    u16 *items_count);
+int __ssdfs_btree_common_node_extract_index(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_index_area *area,
+				    u16 found_index,
+				    struct ssdfs_btree_index_key *ptr);
+int ssdfs_btree_node_check_hash_range(struct ssdfs_btree_node *node,
+				      u16 items_count,
+				      u16 items_capacity,
+				      u64 start_hash,
+				      u64 end_hash,
+				      struct ssdfs_btree_search *search);
+int ssdfs_btree_node_clear_range(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *area,
+				size_t item_size,
+				struct ssdfs_btree_search *search);
+int __ssdfs_btree_node_clear_range(struct ssdfs_btree_node *node,
+				   struct ssdfs_btree_node_items_area *area,
+				   size_t item_size,
+				   u16 start_index,
+				   unsigned int range_len);
+int ssdfs_btree_node_copy_header_nolock(struct ssdfs_btree_node *node,
+					struct page *page,
+					u32 *write_offset);
+
+void ssdfs_show_btree_node_info(struct ssdfs_btree_node *node);
+void ssdfs_debug_btree_node_object(struct ssdfs_btree_node *node);
+
+#endif /* _SSDFS_BTREE_NODE_H */
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94986A2665
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBYBTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBYBTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:10 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE64612BE7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:43 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q15so781706oiw.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQtdBTWPSIGinxpu9EfcnlDffR7AeQZLHgnbLDcqhUc=;
        b=b68OrgjSwsMmT/fackALFggBJMfS+WHxPkVIpbaiizA2x9rMdpOnvc1do56a7dzyg1
         KSFeRPwNq2KeZjc+pUohDmSkXEjwko65LxAYNV1GKv0AgmCWTHACb1LSENd/BDDaWCn+
         YBam4BDNDH2SunrHXLbEVntBda83oLaxo4qetEM5jN/tSLg7NMWiDfpeU9xGklwFfQ3h
         D24P6zZTjdm8LsYf9EcJHX/VDkCFMe/Vim6s/IAXA2iMmoqfkQ9a8CFR1fdLdF1GUQ6d
         ymRLNqT/V/0lppUjXdTsz+aERa3a+geRpqFdLUik6pJGvL9VJHElszdTJiLHfSQPuLZ5
         MihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQtdBTWPSIGinxpu9EfcnlDffR7AeQZLHgnbLDcqhUc=;
        b=M57DSiiOAZ4TzIYfHJhUZgN9EdLyH0usngovcplJgk3cTqqrCjE89NNia8oPIDYXcx
         4ZGQHOeZenKoBKFRFMj5/HimzZ4RbXgRrowTtm/f8LoSxIqYgqaIripDWBu+b8IOIZI3
         peQNvkcUV3jSi7MsDFMeIVTpGVdekqVSHay+7OMlDtZD1+tAF+hh2MlJM9/jvFsXdLwd
         o8JamUqvMAm+zZEOyik1Z2dPzs2jRKeAME6LPHqxmMYfL4ZoTI1gUr+aEkD4Cj1i9od3
         TY+1P0odU4xsAsFRFHy8vsl4gciH+c22e4ltyksV78UvLTGuDTYy59LQQ3/BE+386xHI
         gcGg==
X-Gm-Message-State: AO0yUKWU7tREWThzqqp0W6YKMQJeiUS9FESEYDsYhWcMQVi4NzJJTuDn
        2hassQJSI2nwvUpb0N46hcwhlYdABtZtpA2z
X-Google-Smtp-Source: AK7set+ji5n60DNn1iVTbYjlOx99fN+kzE1jmXWPswkPYVfpD6KiH0qIMp1TG0rvPR7JmFWMz9NdPA==
X-Received: by 2002:a05:6808:2811:b0:37d:cbe8:4e31 with SMTP id et17-20020a056808281100b0037dcbe84e31mr4336832oib.32.1677287862083;
        Fri, 24 Feb 2023 17:17:42 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:41 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 60/76] ssdfs: introduce inodes b-tree
Date:   Fri, 24 Feb 2023 17:09:11 -0800
Message-Id: <20230225010927.813929-61-slava@dubeyko.com>
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

SSDFS raw inode is the metadata structure of fixed size that
can vary from 256 bytes to several KBs. The size of inode is defined
during the file system’s volume creation. The most special part of
the SSDFS raw inode is the private area that is used for storing:
(1) small file inline, (2) root node of extents, dentries, and/or
xattr b-tree.

SSDFS inodes b-tree is the hybrid b-tree that includes the hybrid
nodes with the goal to use the node’s space in more efficient way
by means of combination the index and data records inside of the node.
Root node of inodes b-tree is stored into the log footer or partial
log header of every log. Generally speaking, it means that SSDFS file
system is using the massive replication of the root node of inodes
b-tree. Actually, inodes b-tree node’s space includes header,
index area (in the case of hybrid node), and array of inodes are ordered
by ID values. If node has 8 KB in size and inode structure is 256 bytes
in size then the maximum capacity of one inodes b-tree’s node is 32 inodes.

Generally speaking, inodes table can be imagined like an imaginary array
that is extended by means of adding the new inodes into the tail of
the array. However, inode can be allocated or deleted by virtue of
create file or delete file operations, for example. As a result, every
b-tree node has an allocation bitmap that is tracking the state (used
or free) of every inode in the b-tree node. The allocation bitmap provides
the mechanism of fast lookup a free inode with the goal to reuse
the inodes of deleted files.

Additionally, every b-tree node has a dirty bitmap that has goal to track
modification of inodes. Generally speaking, the dirty bitmap provides
the opportunity to flush not the whole node but the modified inodes only.
As a result, such bitmap could play the cornerstone role in
the delta-encoding or in the Diff-On-Write approach. Moreover, b-tree
node has a lock bitmap that has responsibility to implement the mechanism of
exclusive lock a particular inode without the necessity to lock
exclusively the whole node. Generally speaking, the lock bitmap was
introduced with the goal to improve the granularity of lock operation.
As a result, it provides the way to modify the different inodes in
the same b-tree node without the using of exclusive lock the whole b-tree
node. However, the exclusive lock of the whole tree has to be used for
the case of addition or deletion a b-tree node.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/inodes_tree.c | 3168 ++++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/inodes_tree.h |  177 +++
 2 files changed, 3345 insertions(+)
 create mode 100644 fs/ssdfs/inodes_tree.c
 create mode 100644 fs/ssdfs/inodes_tree.h

diff --git a/fs/ssdfs/inodes_tree.c b/fs/ssdfs/inodes_tree.c
new file mode 100644
index 000000000000..1cc42cc84513
--- /dev/null
+++ b/fs/ssdfs/inodes_tree.c
@@ -0,0 +1,3168 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/inodes_tree.c - inodes btree implementation.
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
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "inodes_tree.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_ino_tree_page_leaks;
+atomic64_t ssdfs_ino_tree_memory_leaks;
+atomic64_t ssdfs_ino_tree_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_ino_tree_cache_leaks_increment(void *kaddr)
+ * void ssdfs_ino_tree_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_ino_tree_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_ino_tree_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_ino_tree_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_ino_tree_kfree(void *kaddr)
+ * struct page *ssdfs_ino_tree_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_ino_tree_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_ino_tree_free_page(struct page *page)
+ * void ssdfs_ino_tree_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(ino_tree)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(ino_tree)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_ino_tree_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_ino_tree_page_leaks, 0);
+	atomic64_set(&ssdfs_ino_tree_memory_leaks, 0);
+	atomic64_set(&ssdfs_ino_tree_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_ino_tree_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_ino_tree_page_leaks) != 0) {
+		SSDFS_ERR("INODES TREE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_ino_tree_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_ino_tree_memory_leaks) != 0) {
+		SSDFS_ERR("INODES TREE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_ino_tree_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_ino_tree_cache_leaks) != 0) {
+		SSDFS_ERR("INODES TREE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_ino_tree_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static struct kmem_cache *ssdfs_free_ino_desc_cachep;
+
+void ssdfs_zero_free_ino_desc_cache_ptr(void)
+{
+	ssdfs_free_ino_desc_cachep = NULL;
+}
+
+static
+void ssdfs_init_free_ino_desc_once(void *obj)
+{
+	struct ssdfs_inodes_btree_range *range_desc = obj;
+
+	memset(range_desc, 0, sizeof(struct ssdfs_inodes_btree_range));
+}
+
+void ssdfs_shrink_free_ino_desc_cache(void)
+{
+	if (ssdfs_free_ino_desc_cachep)
+		kmem_cache_shrink(ssdfs_free_ino_desc_cachep);
+}
+
+void ssdfs_destroy_free_ino_desc_cache(void)
+{
+	if (ssdfs_free_ino_desc_cachep)
+		kmem_cache_destroy(ssdfs_free_ino_desc_cachep);
+}
+
+int ssdfs_init_free_ino_desc_cache(void)
+{
+	ssdfs_free_ino_desc_cachep =
+			kmem_cache_create("ssdfs_free_ino_desc_cache",
+				sizeof(struct ssdfs_inodes_btree_range), 0,
+				SLAB_RECLAIM_ACCOUNT |
+				SLAB_MEM_SPREAD |
+				SLAB_ACCOUNT,
+				ssdfs_init_free_ino_desc_once);
+	if (!ssdfs_free_ino_desc_cachep) {
+		SSDFS_ERR("unable to create free inode descriptors cache\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/******************************************************************************
+ *                      FREE INODES RANGE FUNCTIONALITY                       *
+ ******************************************************************************/
+
+/*
+ * ssdfs_free_inodes_range_alloc() - allocate memory for free inodes range
+ */
+struct ssdfs_inodes_btree_range *ssdfs_free_inodes_range_alloc(void)
+{
+	struct ssdfs_inodes_btree_range *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_free_ino_desc_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = kmem_cache_alloc(ssdfs_free_ino_desc_cachep, GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate memory for free inodes range\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ssdfs_ino_tree_cache_leaks_increment(ptr);
+
+	return ptr;
+}
+
+/*
+ * ssdfs_free_inodes_range_free() - free memory for free inodes range
+ */
+void ssdfs_free_inodes_range_free(struct ssdfs_inodes_btree_range *range)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_free_ino_desc_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!range)
+		return;
+
+	ssdfs_ino_tree_cache_leaks_decrement(range);
+	kmem_cache_free(ssdfs_free_ino_desc_cachep, range);
+}
+
+/*
+ * ssdfs_free_inodes_range_init() - init free inodes range
+ * @range: free inodes range object [out]
+ */
+void ssdfs_free_inodes_range_init(struct ssdfs_inodes_btree_range *range)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!range);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(range, 0, sizeof(struct ssdfs_inodes_btree_range));
+
+	INIT_LIST_HEAD(&range->list);
+	range->node_id = SSDFS_BTREE_NODE_INVALID_ID;
+	range->area.start_hash = SSDFS_INODES_RANGE_INVALID_START;
+	range->area.start_index = SSDFS_INODES_RANGE_INVALID_INDEX;
+}
+
+/******************************************************************************
+ *                      FREE INODES QUEUE FUNCTIONALITY                       *
+ ******************************************************************************/
+
+/*
+ * ssdfs_free_inodes_queue_init() - initialize free inodes queue
+ * @q: free inodes queue [out]
+ */
+static
+void ssdfs_free_inodes_queue_init(struct ssdfs_free_inode_range_queue *q)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!q);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock_init(&q->lock);
+	INIT_LIST_HEAD(&q->list);
+}
+
+/*
+ * is_ssdfs_free_inodes_queue_empty() - check that free inodes queue is empty
+ * @q: free inodes queue
+ */
+static
+bool is_ssdfs_free_inodes_queue_empty(struct ssdfs_free_inode_range_queue *q)
+{
+	bool is_empty;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!q);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&q->lock);
+	is_empty = list_empty_careful(&q->list);
+	spin_unlock(&q->lock);
+
+	return is_empty;
+}
+
+/*
+ * ssdfs_free_inodes_queue_add_head() - add range at the head of queue
+ * @q: free inodes queue
+ * @range: free inodes range
+ */
+static void
+ssdfs_free_inodes_queue_add_head(struct ssdfs_free_inode_range_queue *q,
+				 struct ssdfs_inodes_btree_range *range)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!q || !range);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&q->lock);
+	list_add(&range->list, &q->list);
+	spin_unlock(&q->lock);
+}
+
+/*
+ * ssdfs_free_inodes_queue_add_tail() - add range at the tail of queue
+ * @q: free inodes queue
+ * @range: free inodes range
+ */
+static void
+ssdfs_free_inodes_queue_add_tail(struct ssdfs_free_inode_range_queue *q,
+				 struct ssdfs_inodes_btree_range *range)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!q || !range);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&q->lock);
+	list_add_tail(&range->list, &q->list);
+	spin_unlock(&q->lock);
+}
+
+/*
+ * ssdfs_free_inodes_queue_get_first() - get first free inodes range
+ * @q: free inodes queue
+ * @range: pointer on value that stores range pointer [out]
+ *
+ * This method tries to retrieve the first free inode's index from
+ * queue of free inode ranges.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - queue is empty.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_free_inodes_queue_get_first(struct ssdfs_free_inode_range_queue *q,
+				      struct ssdfs_inodes_btree_range **range)
+{
+	struct ssdfs_inodes_btree_range *first = NULL, *tmp = NULL;
+	bool is_empty = true;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!q || !range);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tmp = ssdfs_free_inodes_range_alloc();
+	if (!tmp) {
+		SSDFS_ERR("fail to allocate free inodes range\n");
+		return -ERANGE;
+	}
+
+	ssdfs_free_inodes_range_init(tmp);
+
+	spin_lock(&q->lock);
+
+	is_empty = list_empty_careful(&q->list);
+	if (!is_empty) {
+		first = list_first_entry_or_null(&q->list,
+						struct ssdfs_inodes_btree_range,
+						list);
+		if (!first) {
+			err = -ENOENT;
+			SSDFS_WARN("first entry is NULL\n");
+			goto finish_get_first;
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			if (first->node_id == SSDFS_BTREE_NODE_INVALID_ID) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid node ID\n");
+				goto finish_get_first;
+			}
+
+			if (first->area.start_hash ==
+					SSDFS_INODES_RANGE_INVALID_START) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid start index\n");
+				goto finish_get_first;
+			}
+
+			if (first->area.count == 0) {
+				err = -ERANGE;
+				SSDFS_ERR("empty range\n");
+				list_del(&first->list);
+				goto finish_get_first;
+			}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			tmp->node_id = first->node_id;
+			tmp->area.start_hash = first->area.start_hash;
+			tmp->area.start_index = first->area.start_index;
+			tmp->area.count = 1;
+
+			first->area.start_hash += 1;
+			first->area.start_index += 1;
+			first->area.count -= 1;
+
+			if (first->area.count == 0)
+				list_del(&first->list);
+		}
+	}
+
+finish_get_first:
+	spin_unlock(&q->lock);
+
+	if (first && first->area.count == 0) {
+		ssdfs_free_inodes_range_free(first);
+		first = NULL;
+	}
+
+	if (unlikely(err)) {
+		ssdfs_free_inodes_range_free(tmp);
+		return err;
+	} else if (is_empty) {
+		ssdfs_free_inodes_range_free(tmp);
+		SSDFS_DBG("free inodes queue is empty\n");
+		return -ENODATA;
+	}
+
+	*range = tmp;
+
+	return 0;
+}
+
+/*
+ * ssdfs_free_inodes_queue_remove_first() - remove first free inodes range
+ * @q: free inodes queue
+ * @range: pointer on value that stores range pointer [out]
+ *
+ * This method tries to remove the first free inodes' range from
+ * queue.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - queue is empty.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_free_inodes_queue_remove_first(struct ssdfs_free_inode_range_queue *q,
+					struct ssdfs_inodes_btree_range **range)
+{
+	bool is_empty;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!q || !range);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&q->lock);
+	is_empty = list_empty_careful(&q->list);
+	if (!is_empty) {
+		*range = list_first_entry_or_null(&q->list,
+						struct ssdfs_inodes_btree_range,
+						list);
+		if (!*range) {
+			SSDFS_WARN("first entry is NULL\n");
+			err = -ENOENT;
+		} else
+			list_del(&(*range)->list);
+	}
+	spin_unlock(&q->lock);
+
+	if (is_empty) {
+		SSDFS_WARN("requests queue is empty\n");
+		return -ENODATA;
+	} else if (err)
+		return err;
+
+	return 0;
+}
+
+/*
+ * ssdfs_free_inodes_queue_remove_all() - remove all ranges from the queue
+ * @q: free inodes queue
+ */
+static
+void ssdfs_free_inodes_queue_remove_all(struct ssdfs_free_inode_range_queue *q)
+{
+	bool is_empty;
+	LIST_HEAD(tmp_list);
+	struct list_head *this, *next;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!q);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&q->lock);
+	is_empty = list_empty_careful(&q->list);
+	if (!is_empty)
+		list_replace_init(&q->list, &tmp_list);
+	spin_unlock(&q->lock);
+
+	if (is_empty)
+		return;
+
+	list_for_each_safe(this, next, &tmp_list) {
+		struct ssdfs_inodes_btree_range *range;
+
+		range = list_entry(this, struct ssdfs_inodes_btree_range, list);
+
+		if (range) {
+			list_del(&range->list);
+			ssdfs_free_inodes_range_free(range);
+		}
+	}
+}
+
+/******************************************************************************
+ *                     INODES TREE OBJECT FUNCTIONALITY                       *
+ ******************************************************************************/
+
+/*
+ * ssdfs_inodes_btree_create() - create inodes btree
+ * @fsi: pointer on shared file system object
+ *
+ * This method tries to create inodes btree object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_inodes_btree_create(struct ssdfs_fs_info *fsi)
+{
+	struct ssdfs_inodes_btree_info *ptr;
+	struct ssdfs_inodes_btree *raw_btree;
+	struct ssdfs_btree_search *search;
+	size_t raw_inode_size = sizeof(struct ssdfs_inode);
+	u32 vs_flags;
+	bool is_tree_inline = true;
+	ino_t ino;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+	BUG_ON(!rwsem_is_locked(&fsi->volume_sem));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p\n", fsi);
+#else
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ptr = ssdfs_ino_tree_kzalloc(sizeof(struct ssdfs_inodes_btree_info),
+				     GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate inodes tree\n");
+		return -ENOMEM;
+	}
+
+	fsi->inodes_tree = ptr;
+
+	err = ssdfs_btree_create(fsi,
+				 SSDFS_INODES_BTREE_INO,
+				 &ssdfs_inodes_btree_desc_ops,
+				 &ssdfs_inodes_btree_ops,
+				 &ptr->generic_tree);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create inodes tree: err %d\n",
+			  err);
+		goto fail_create_inodes_tree;
+	}
+
+	spin_lock(&fsi->volume_state_lock);
+	vs_flags = fsi->fs_flags;
+	spin_unlock(&fsi->volume_state_lock);
+
+	is_tree_inline = vs_flags & SSDFS_HAS_INLINE_INODES_TREE;
+
+	spin_lock_init(&ptr->lock);
+	raw_btree = &fsi->vs->inodes_btree;
+	ptr->upper_allocated_ino = le64_to_cpu(raw_btree->upper_allocated_ino);
+	ptr->last_free_ino = 0;
+	ptr->allocated_inodes = le64_to_cpu(raw_btree->allocated_inodes);
+	ptr->free_inodes = le64_to_cpu(raw_btree->free_inodes);
+	ptr->inodes_capacity = le64_to_cpu(raw_btree->inodes_capacity);
+	ptr->leaf_nodes = le32_to_cpu(raw_btree->leaf_nodes);
+	ptr->nodes_count = le32_to_cpu(raw_btree->nodes_count);
+	ptr->raw_inode_size = le16_to_cpu(raw_btree->desc.item_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("upper_allocated_ino %llu, allocated_inodes %llu, "
+		  "free_inodes %llu, inodes_capacity %llu\n",
+		  ptr->upper_allocated_ino,
+		  ptr->allocated_inodes,
+		  ptr->free_inodes,
+		  ptr->inodes_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_memcpy(&ptr->root_folder, 0, raw_inode_size,
+		     &fsi->vs->root_folder, 0, raw_inode_size,
+		     raw_inode_size);
+
+	if (!is_raw_inode_checksum_correct(fsi,
+					   &ptr->root_folder,
+					   raw_inode_size)) {
+		err = -EIO;
+		SSDFS_ERR("root folder inode is corrupted\n");
+		goto fail_create_inodes_tree;
+	}
+
+	ssdfs_free_inodes_queue_init(&ptr->free_inodes_queue);
+
+	if (is_tree_inline) {
+		search = ssdfs_btree_search_alloc();
+		if (!search) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate btree search object\n");
+			goto fail_create_inodes_tree;
+		}
+
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_ALLOCATE_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = 0;
+		search->request.end.hash = 0;
+		search->request.count = 1;
+
+		ptr->allocated_inodes = 0;
+		ptr->free_inodes = 0;
+		ptr->inodes_capacity = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("upper_allocated_ino %llu, allocated_inodes %llu, "
+			  "free_inodes %llu, inodes_capacity %llu\n",
+			  ptr->upper_allocated_ino,
+			  ptr->allocated_inodes,
+			  ptr->free_inodes,
+			  ptr->inodes_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_btree_add_node(&ptr->generic_tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add the node: err %d\n",
+				  err);
+			goto free_search_object;
+		}
+
+		/* allocate all reserved inodes */
+		ino = 0;
+		do {
+			search->request.start.hash = ino;
+			search->request.end.hash = ino;
+			search->request.count = 1;
+
+			err = ssdfs_inodes_btree_allocate(ptr, &ino, search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to allocate an inode: err %d\n",
+					  err);
+				goto free_search_object;
+			} else if (search->request.start.hash != ino) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid ino %lu\n",
+					  ino);
+				goto free_search_object;
+			}
+
+			ino++;
+		} while (ino <= SSDFS_ROOT_INO);
+
+		if (ino > SSDFS_ROOT_INO)
+			ino = SSDFS_ROOT_INO;
+		else {
+			err = -ERANGE;
+			SSDFS_ERR("unexpected ino %lu\n", ino);
+			goto free_search_object;
+		}
+
+		switch (search->result.buf_state) {
+		case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+		case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+			/* expected state */
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid result's buffer state: "
+				  "%#x\n",
+				  search->result.buf_state);
+			goto free_search_object;
+		}
+
+		if (!search->result.buf) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid buffer\n");
+			goto free_search_object;
+		}
+
+		if (search->result.buf_size < raw_inode_size) {
+			err = -ERANGE;
+			SSDFS_ERR("buf_size %zu < raw_inode_size %zu\n",
+				  search->result.buf_size,
+				  raw_inode_size);
+			goto free_search_object;
+		}
+
+		if (search->result.items_in_buffer != 1) {
+			SSDFS_WARN("unexpected value: "
+				   "items_in_buffer %u\n",
+				   search->result.items_in_buffer);
+		}
+
+		ssdfs_memcpy(search->result.buf, 0, search->result.buf_size,
+			     &ptr->root_folder, 0, raw_inode_size,
+			     raw_inode_size);
+
+		err = ssdfs_inodes_btree_change(ptr, ino, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change inode: "
+				  "ino %lu, err %d\n",
+				  ino, err);
+			goto free_search_object;
+		}
+
+free_search_object:
+		ssdfs_btree_search_free(search);
+
+		if (unlikely(err))
+			goto fail_create_inodes_tree;
+
+		spin_lock(&fsi->volume_state_lock);
+		vs_flags = fsi->fs_flags;
+		vs_flags &= ~SSDFS_HAS_INLINE_INODES_TREE;
+		fsi->fs_flags = vs_flags;
+		spin_unlock(&fsi->volume_state_lock);
+	} else {
+		search = ssdfs_btree_search_alloc();
+		if (!search) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate btree search object\n");
+			goto fail_create_inodes_tree;
+		}
+
+		ssdfs_btree_search_init(search);
+		err = ssdfs_inodes_btree_find(ptr, ptr->upper_allocated_ino,
+						search);
+		ssdfs_btree_search_free(search);
+
+		if (err == -ENODATA) {
+			err = 0;
+			/*
+			 * It doesn't need to find the inode.
+			 * The goal is to pass through the tree.
+			 * Simply ignores the no data error.
+			 */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare free inodes queue: "
+				  "upper_allocated_ino %llu, err %d\n",
+				  ptr->upper_allocated_ino, err);
+			goto fail_create_inodes_tree;
+		}
+
+		spin_lock(&ptr->lock);
+		if (ptr->last_free_ino > 0 &&
+		    ptr->last_free_ino < ptr->upper_allocated_ino) {
+			ptr->upper_allocated_ino = ptr->last_free_ino - 1;
+		}
+		spin_unlock(&ptr->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("last_free_ino %llu, upper_allocated_ino %llu\n",
+			  ptr->last_free_ino,
+			  ptr->upper_allocated_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("DONE: create inodes btree\n");
+#else
+	SSDFS_DBG("DONE: create inodes btree\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+fail_create_inodes_tree:
+	fsi->inodes_tree = NULL;
+	ssdfs_ino_tree_kfree(ptr);
+	return err;
+}
+
+/*
+ * ssdfs_inodes_btree_destroy - destroy inodes btree
+ * @fsi: pointer on shared file system object
+ */
+void ssdfs_inodes_btree_destroy(struct ssdfs_fs_info *fsi)
+{
+	struct ssdfs_inodes_btree_info *tree;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p\n", fsi->inodes_tree);
+#else
+	SSDFS_DBG("tree %p\n", fsi->inodes_tree);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!fsi->inodes_tree)
+		return;
+
+	ssdfs_debug_inodes_btree_object(fsi->inodes_tree);
+
+	tree = fsi->inodes_tree;
+	ssdfs_btree_destroy(&tree->generic_tree);
+	ssdfs_free_inodes_queue_remove_all(&tree->free_inodes_queue);
+
+	ssdfs_ino_tree_kfree(fsi->inodes_tree);
+	fsi->inodes_tree = NULL;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * ssdfs_inodes_btree_flush() - flush dirty inodes btree
+ * @tree: pointer on inodes btree object
+ *
+ * This method tries to flush the dirty inodes btree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_inodes_btree_flush(struct ssdfs_inodes_btree_info *tree)
+{
+	struct ssdfs_fs_info *fsi;
+	u64 upper_allocated_ino;
+	u64 allocated_inodes;
+	u64 free_inodes;
+	u64 inodes_capacity;
+	u32 leaf_nodes;
+	u32 nodes_count;
+	int err;
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
+	fsi = tree->generic_tree.fsi;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!rwsem_is_locked(&fsi->volume_sem));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_btree_flush(&tree->generic_tree);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to flush inodes btree: err %d\n",
+			  err);
+		return err;
+	}
+
+	spin_lock(&tree->lock);
+	ssdfs_memcpy(&fsi->vs->root_folder,
+		     0, sizeof(struct ssdfs_inode),
+		     &tree->root_folder,
+		     0, sizeof(struct ssdfs_inode),
+		     sizeof(struct ssdfs_inode));
+	upper_allocated_ino = tree->upper_allocated_ino;
+	allocated_inodes = tree->allocated_inodes;
+	free_inodes = tree->free_inodes;
+	inodes_capacity = tree->inodes_capacity;
+	leaf_nodes = tree->leaf_nodes;
+	nodes_count = tree->nodes_count;
+	spin_unlock(&tree->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("allocated_inodes %llu, free_inodes %llu, "
+		  "inodes_capacity %llu\n",
+		  allocated_inodes, free_inodes, inodes_capacity);
+	WARN_ON((allocated_inodes + free_inodes) != inodes_capacity);
+
+	SSDFS_DBG("leaf_nodes %u, nodes_count %u\n",
+		  leaf_nodes, nodes_count);
+	WARN_ON(leaf_nodes >= nodes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi->vs->inodes_btree.allocated_inodes = cpu_to_le64(allocated_inodes);
+	fsi->vs->inodes_btree.free_inodes = cpu_to_le64(free_inodes);
+	fsi->vs->inodes_btree.inodes_capacity = cpu_to_le64(inodes_capacity);
+	fsi->vs->inodes_btree.leaf_nodes = cpu_to_le32(leaf_nodes);
+	fsi->vs->inodes_btree.nodes_count = cpu_to_le32(nodes_count);
+	fsi->vs->inodes_btree.upper_allocated_ino =
+				cpu_to_le64(upper_allocated_ino);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_inodes_btree_object(fsi->inodes_tree);
+
+	return 0;
+}
+
+static inline
+bool need_initialize_inodes_btree_search(ino_t ino,
+					 struct ssdfs_btree_search *search)
+{
+	return need_initialize_btree_search(search) ||
+		search->request.start.hash != ino;
+}
+
+/*
+ * ssdfs_inodes_btree_find() - find raw inode
+ * @tree: pointer on inodes btree object
+ * @ino: inode ID value
+ * @search: pointer on search request object
+ *
+ * This method tries to find the raw inode for @ino.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_inodes_btree_find(struct ssdfs_inodes_btree_info *tree,
+			    ino_t ino,
+			    struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, ino %lu, search %p\n",
+		  tree, ino, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	if (need_initialize_inodes_btree_search(ino, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = ino;
+		search->request.end.hash = ino;
+		search->request.count = 1;
+	}
+
+	return ssdfs_btree_find_item(&tree->generic_tree, search);
+}
+
+/*
+ * ssdfs_inodes_btree_allocate() - allocate a new raw inode
+ * @tree: pointer on inodes btree object
+ * @ino: pointer on inode ID value [out]
+ * @search: pointer on search request object
+ *
+ * This method tries to allocate a new raw inode into
+ * the inodes btree. The @ino contains inode ID number.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_inodes_btree_allocate(struct ssdfs_inodes_btree_info *tree,
+				ino_t *ino,
+				struct ssdfs_btree_search *search)
+{
+	struct ssdfs_inodes_btree_range *range = NULL;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !ino || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, ino %p, search %p\n",
+		  tree, ino, search);
+#else
+	SSDFS_DBG("tree %p, ino %p, search %p\n",
+		  tree, ino, search);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	*ino = ULONG_MAX;
+
+	err = ssdfs_free_inodes_queue_get_first(&tree->free_inodes_queue,
+						&range);
+	if (err == -ENODATA) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_ALLOCATE_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		spin_lock(&tree->lock);
+		search->request.start.hash = tree->upper_allocated_ino + 1;
+		search->request.end.hash = tree->upper_allocated_ino + 1;
+		spin_unlock(&tree->lock);
+		search->request.count = 1;
+
+		err = ssdfs_btree_add_node(&tree->generic_tree, search);
+		if (err == -EEXIST)
+			err = 0;
+		else if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to add the node: err %d\n",
+				  err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to add the node: err %d\n",
+				  err);
+			return err;
+		}
+
+		err =
+		    ssdfs_free_inodes_queue_get_first(&tree->free_inodes_queue,
+							&range);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get first free inode hash from the queue: "
+			  "err %d\n",
+			  err);
+		return err;
+	}
+
+	if (is_free_inodes_range_invalid(range)) {
+		err = -ERANGE;
+		SSDFS_WARN("invalid free inodes range\n");
+		goto finish_inode_allocation;
+	}
+
+	if (range->area.start_hash >= ULONG_MAX) {
+		err = -EOPNOTSUPP;
+		SSDFS_WARN("start_hash %llx is too huge\n",
+			   range->area.start_hash);
+		goto finish_inode_allocation;
+	}
+
+	if (range->area.count != 1)
+		SSDFS_WARN("invalid free inodes range\n");
+
+	*ino = (ino_t)range->area.start_hash;
+	search->request.type = SSDFS_BTREE_SEARCH_ALLOCATE_ITEM;
+
+	if (need_initialize_inodes_btree_search(*ino, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_ALLOCATE_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = *ino;
+		search->request.end.hash = *ino;
+		search->request.count = 1;
+	}
+
+	search->result.state = SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+	search->result.start_index = range->area.start_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %llu, start_index %u\n",
+		  (u64)*ino, (u32)search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_btree_allocate_item(&tree->generic_tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate item: ino %llu, err %d\n",
+			  search->request.start.hash, err);
+		goto finish_inode_allocation;
+	}
+
+finish_inode_allocation:
+	ssdfs_free_inodes_range_free(range);
+
+	ssdfs_btree_search_forget_parent_node(search);
+	ssdfs_btree_search_forget_child_node(search);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_inodes_btree_change() - change raw inode
+ * @tree: pointer on inodes btree object
+ * @ino: inode ID value
+ * @search: pointer on search request object
+ *
+ * This method tries to change the raw inode for @ino.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_inodes_btree_change(struct ssdfs_inodes_btree_info *tree,
+				ino_t ino,
+				struct ssdfs_btree_search *search)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, ino %lu, search %p\n",
+		  tree, ino, search);
+#else
+	SSDFS_DBG("tree %p, ino %lu, search %p\n",
+		  tree, ino, search);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	search->request.type = SSDFS_BTREE_SEARCH_CHANGE_ITEM;
+
+	if (need_initialize_inodes_btree_search(ino, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_CHANGE_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = ino;
+		search->request.end.hash = ino;
+		search->request.count = 1;
+	}
+
+	err = ssdfs_btree_change_item(&tree->generic_tree, search);
+
+	ssdfs_btree_search_forget_parent_node(search);
+	ssdfs_btree_search_forget_child_node(search);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change inode: ino %lu, err %d\n",
+			  ino, err);
+		return err;
+	}
+
+	if (ino == SSDFS_ROOT_INO) {
+		spin_lock(&tree->lock);
+		ssdfs_memcpy(&tree->root_folder,
+			     0, sizeof(struct ssdfs_inode),
+			     search->result.buf,
+			     0, search->result.buf_size,
+			     sizeof(struct ssdfs_inode));
+		spin_unlock(&tree->lock);
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
+ * ssdfs_inodes_btree_delete_range() - delete a range of raw inodes
+ * @tree: pointer on inodes btree object
+ * @ino: starting inode ID value
+ * @count: count of raw inodes in the range
+ *
+ * This method tries to delete the @count of raw inodes
+ * that are starting from @ino.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_inodes_btree_delete_range(struct ssdfs_inodes_btree_info *tree,
+				    ino_t ino, u16 count)
+{
+	struct ssdfs_btree_search *search;
+	struct ssdfs_inodes_btree_range *range;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, ino %lu, count %u\n",
+		  tree, ino, count);
+#else
+	SSDFS_DBG("tree %p, ino %lu, count %u\n",
+		  tree, ino, count);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (count == 0) {
+		SSDFS_WARN("count == 0\n");
+		return 0;
+	}
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+	ssdfs_btree_search_init(search);
+
+	if (count == 1)
+		err = ssdfs_inodes_btree_find(tree, ino, search);
+	else {
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_RANGE;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = ino;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(ino >= U64_MAX - count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		search->request.end.hash = (u64)ino + count;
+		search->request.count = count;
+
+		err = ssdfs_btree_find_range(&tree->generic_tree, search);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find inodes range: "
+			  "ino %lu, count %u, err %d\n",
+			  ino, count, err);
+		goto finish_delete_inodes_range;
+	}
+
+	if (count == 1) {
+		search->request.type = SSDFS_BTREE_SEARCH_DELETE_ITEM;
+		err = ssdfs_btree_delete_item(&tree->generic_tree, search);
+	} else {
+		search->request.type = SSDFS_BTREE_SEARCH_DELETE_RANGE;
+		err = ssdfs_btree_delete_range(&tree->generic_tree, search);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete raw inodes range: "
+			  "ino %lu, count %u, err %d\n",
+			  ino, count, err);
+		goto finish_delete_inodes_range;
+	}
+
+	range = ssdfs_free_inodes_range_alloc();
+	if (!range) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate free inodes range object\n");
+		goto finish_delete_inodes_range;
+	}
+
+	ssdfs_free_inodes_range_init(range);
+
+	range->node_id = search->node.id;
+	range->area.start_hash = search->request.start.hash;
+	range->area.start_index = search->result.start_index;
+	range->area.count = count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("add free range: node_id %u, "
+		  "start_hash %llx, start_index %u, "
+		  "count %u\n",
+		  range->node_id,
+		  range->area.start_hash,
+		  range->area.start_index,
+		  range->area.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_free_inodes_queue_add_head(&tree->free_inodes_queue, range);
+
+	spin_lock(&tree->lock);
+	if (range->area.start_hash > tree->last_free_ino) {
+		tree->last_free_ino =
+			range->area.start_hash + range->area.count;
+	}
+	spin_unlock(&tree->lock);
+
+finish_delete_inodes_range:
+	ssdfs_btree_search_free(search);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_inodes_btree_delete() - delete raw inode
+ * @tree: pointer on inodes btree object
+ * @ino: inode ID value
+ *
+ * This method tries to delete the raw inode for @ino.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_inodes_btree_delete(struct ssdfs_inodes_btree_info *tree,
+				ino_t ino)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+
+	SSDFS_DBG("tree %p, ino %lu\n",
+		  tree, ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ssdfs_inodes_btree_delete_range(tree, ino, 1);
+}
+
+/******************************************************************************
+ *             SPECIALIZED INODES BTREE DESCRIPTOR OPERATIONS                 *
+ ******************************************************************************/
+
+/*
+ * ssdfs_inodes_btree_desc_init() - specialized btree descriptor init
+ * @fsi: pointer on shared file system object
+ * @tree: pointer on inodes btree object
+ */
+static
+int ssdfs_inodes_btree_desc_init(struct ssdfs_fs_info *fsi,
+				 struct ssdfs_btree *tree)
+{
+	struct ssdfs_btree_descriptor *desc;
+	u32 erasesize;
+	u32 node_size;
+	size_t inode_size = sizeof(struct ssdfs_inode);
+	u16 item_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !tree);
+	BUG_ON(!rwsem_is_locked(&fsi->volume_sem));
+
+	SSDFS_DBG("fsi %p, tree %p\n",
+		  fsi, tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	erasesize = fsi->erasesize;
+
+	desc = &fsi->vs->inodes_btree.desc;
+
+	if (le32_to_cpu(desc->magic) != SSDFS_INODES_BTREE_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid magic %#x\n",
+			  le32_to_cpu(desc->magic));
+		goto finish_btree_desc_init;
+	}
+
+	/* TODO: check flags */
+
+	if (desc->type != SSDFS_INODES_BTREE) {
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
+	if (item_size != inode_size) {
+		err = -EIO;
+		SSDFS_ERR("invalid item size %u\n",
+			  item_size);
+		goto finish_btree_desc_init;
+	}
+
+	if (le16_to_cpu(desc->index_area_min_size) != inode_size) {
+		err = -EIO;
+		SSDFS_ERR("invalid index_area_min_size %u\n",
+			  le16_to_cpu(desc->index_area_min_size));
+		goto finish_btree_desc_init;
+	}
+
+	err = ssdfs_btree_desc_init(fsi, tree, desc, 0, item_size);
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
+ * ssdfs_inodes_btree_desc_flush() - specialized btree's descriptor flush
+ * @tree: pointer on inodes btree object
+ */
+static
+int ssdfs_inodes_btree_desc_flush(struct ssdfs_btree *tree)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_descriptor desc;
+	size_t inode_size = sizeof(struct ssdfs_inode);
+	u32 erasesize;
+	u32 node_size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi);
+	BUG_ON(!rwsem_is_locked(&tree->fsi->volume_sem));
+
+	SSDFS_DBG("owner_ino %llu, type %#x, state %#x\n",
+		  tree->owner_ino, tree->type,
+		  atomic_read(&tree->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+
+	memset(&desc, 0xFF, sizeof(struct ssdfs_btree_descriptor));
+
+	desc.magic = cpu_to_le32(SSDFS_INODES_BTREE_MAGIC);
+	desc.item_size = cpu_to_le16(inode_size);
+
+	err = ssdfs_btree_desc_flush(tree, &desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("invalid btree descriptor: err %d\n",
+			  err);
+		return err;
+	}
+
+	if (desc.type != SSDFS_INODES_BTREE) {
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
+	if (le16_to_cpu(desc.index_area_min_size) != inode_size) {
+		SSDFS_ERR("invalid index_area_min_size %u\n",
+			  le16_to_cpu(desc.index_area_min_size));
+		return -ERANGE;
+	}
+
+	ssdfs_memcpy(&fsi->vs->inodes_btree.desc,
+		     0, sizeof(struct ssdfs_btree_descriptor),
+		     &desc,
+		     0, sizeof(struct ssdfs_btree_descriptor),
+		     sizeof(struct ssdfs_btree_descriptor));
+
+	return 0;
+}
+
+/******************************************************************************
+ *                   SPECIALIZED INODES BTREE OPERATIONS                      *
+ ******************************************************************************/
+
+/*
+ * ssdfs_inodes_btree_create_root_node() - specialized root node creation
+ * @fsi: pointer on shared file system object
+ * @node: pointer on node object [out]
+ */
+static
+int ssdfs_inodes_btree_create_root_node(struct ssdfs_fs_info *fsi,
+					struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree_inline_root_node *root_node;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->vs || !node);
+	BUG_ON(!rwsem_is_locked(&fsi->volume_sem));
+
+	SSDFS_DBG("fsi %p, node %p\n",
+		  fsi, node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	root_node = &fsi->vs->inodes_btree.root_node;
+	err = ssdfs_btree_create_root_node(node, root_node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create root node: err %d\n",
+			  err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_inodes_btree_pre_flush_root_node() - specialized root node pre-flush
+ * @node: pointer on node object
+ */
+static
+int ssdfs_inodes_btree_pre_flush_root_node(struct ssdfs_btree_node *node)
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
+	if (tree->type != SSDFS_INODES_BTREE) {
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
+ * ssdfs_inodes_btree_flush_root_node() - specialized root node flush
+ * @node: pointer on node object
+ */
+static
+int ssdfs_inodes_btree_flush_root_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree_inline_root_node *root_node;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+	BUG_ON(!rwsem_is_locked(&node->tree->fsi->volume_sem));
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_ssdfs_btree_node_dirty(node)) {
+		SSDFS_WARN("node %u is not dirty\n",
+			   node->node_id);
+		return 0;
+	}
+
+	root_node = &node->tree->fsi->vs->inodes_btree.root_node;
+	ssdfs_btree_flush_root_node(node, root_node);
+
+	return 0;
+}
+
+/*
+ * ssdfs_inodes_btree_create_node() - specialized node creation
+ * @node: pointer on node object
+ */
+static
+int ssdfs_inodes_btree_create_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	void *addr[SSDFS_BTREE_NODE_BMAP_COUNT];
+	struct ssdfs_inodes_btree_node_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_inodes_btree_node_header);
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
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree = node->tree;
+	node_size = tree->node_size;
+	index_area_min_size = tree->index_area_min_size;
+
+	node->node_ops = &ssdfs_inodes_btree_node_ops;
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
+		node->items_area.end_hash = node->items_area.start_hash +
+					    node->items_area.items_capacity - 1;
+
+		node->bmap_array.index_start_bit =
+			SSDFS_BTREE_NODE_HEADER_INDEX + 1;
+		node->bmap_array.item_start_bit =
+			node->bmap_array.index_start_bit + index_capacity;
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
+		items_area_size = node->items_area.area_size;
+		item_size = node->items_area.item_size;
+
+		node->items_area.items_count = 0;
+		node->items_area.items_capacity = items_area_size / item_size;
+		items_capacity = node->items_area.items_capacity;
+
+		node->items_area.end_hash = node->items_area.start_hash +
+					    node->items_area.items_capacity - 1;
+
+		node->bmap_array.item_start_bit =
+				SSDFS_BTREE_NODE_HEADER_INDEX + 1;
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
+	if (bmap_bytes == 0 || bmap_bytes > SSDFS_INODE_BMAP_SIZE) {
+		err = -EIO;
+		SSDFS_ERR("invalid bmap_bytes %zu\n",
+			  bmap_bytes);
+		goto finish_create_node;
+	}
+
+	hdr = &node->raw.inodes_header;
+	hdr->inodes_count = cpu_to_le16(0);
+	hdr->valid_inodes = cpu_to_le16(0);
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
+ * ssdfs_process_deleted_nodes() - process deleted nodes
+ * @node: pointer on node object
+ * @q: pointer on temporary ranges queue
+ * @start_hash: starting hash of the range
+ * @end_hash: ending hash of the range
+ * @inodes_per_node: number of inodes per leaf node
+ *
+ * This method tries to process the deleted nodes.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_process_deleted_nodes(struct ssdfs_btree_node *node,
+				struct ssdfs_free_inode_range_queue *q,
+				u64 start_hash, u64 end_hash,
+				u32 inodes_per_node)
+{
+	struct ssdfs_inodes_btree_info *tree;
+	struct ssdfs_inodes_btree_range *range;
+	u64 inodes_range;
+	u64 deleted_nodes;
+	u32 remainder;
+	s64 i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !q);
+
+	SSDFS_DBG("node_id %u, state %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "inodes_per_node %u\n",
+		  node->node_id, atomic_read(&node->state),
+		  start_hash, end_hash, inodes_per_node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node->tree->type == SSDFS_INODES_BTREE)
+		tree = (struct ssdfs_inodes_btree_info *)node->tree;
+	else {
+		SSDFS_ERR("invalid tree type %#x\n",
+			  node->tree->type);
+		return -ERANGE;
+	}
+
+	if (start_hash == U64_MAX || end_hash == U64_MAX) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("invalid range: "
+			  "start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	} else if (start_hash > end_hash) {
+		SSDFS_ERR("invalid range: "
+			  "start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		return -ERANGE;
+	}
+
+	inodes_range = end_hash - start_hash;
+	deleted_nodes = div_u64_rem(inodes_range, inodes_per_node, &remainder);
+
+	if (remainder != 0) {
+		SSDFS_ERR("invalid range: "
+			  "inodes_range %llu, inodes_per_node %u, "
+			  "remainder %u\n",
+			  inodes_range, inodes_per_node, remainder);
+		return -ERANGE;
+	}
+
+	for (i = 0; i < deleted_nodes; i++) {
+		range = ssdfs_free_inodes_range_alloc();
+		if (unlikely(!range)) {
+			SSDFS_ERR("fail to allocate inodes range\n");
+			return -ENOMEM;
+		}
+
+		ssdfs_free_inodes_range_init(range);
+		range->node_id = node->node_id;
+		range->area.start_hash = start_hash + (i * inodes_per_node);
+		range->area.start_index = 0;
+		range->area.count = (u16)inodes_per_node;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("add free range: node_id %u, "
+			  "start_hash %llx, start_index %u, "
+			  "count %u\n",
+			  range->node_id,
+			  range->area.start_hash,
+			  range->area.start_index,
+			  range->area.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_free_inodes_queue_add_tail(q, range);
+
+		spin_lock(&tree->lock);
+		if (range->area.start_hash > tree->last_free_ino) {
+			tree->last_free_ino =
+				range->area.start_hash + range->area.count;
+		}
+		spin_unlock(&tree->lock);
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_inodes_btree_detect_deleted_nodes() - detect deleted nodes
+ * @node: pointer on node object
+ * @q: pointer on temporary ranges queue
+ *
+ * This method tries to detect deleted nodes.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_inodes_btree_detect_deleted_nodes(struct ssdfs_btree_node *node,
+					struct ssdfs_free_inode_range_queue *q)
+{
+	struct ssdfs_btree_node_index_area index_area;
+	struct ssdfs_btree_index_key index;
+	size_t hdr_size = sizeof(struct ssdfs_inodes_btree_node_header);
+	u16 item_size;
+	u32 inodes_per_node;
+	u64 prev_hash, start_hash;
+	s64 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !q);
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	ssdfs_memcpy(&index_area,
+		     0, sizeof(struct ssdfs_btree_node_index_area),
+		     &node->index_area,
+		     0, sizeof(struct ssdfs_btree_node_index_area),
+		     sizeof(struct ssdfs_btree_node_index_area));
+	up_read(&node->header_lock);
+
+	item_size = node->tree->item_size;
+	inodes_per_node = node->node_size;
+	inodes_per_node -= hdr_size;
+	inodes_per_node /= item_size;
+
+	if (inodes_per_node == 0) {
+		SSDFS_ERR("invalid inodes_per_node %u\n",
+			  inodes_per_node);
+		return -ERANGE;
+	}
+
+	if (index_area.start_hash == U64_MAX ||
+	    index_area.end_hash == U64_MAX) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to detect deleted nodes: "
+			  "start_hash %llx, end_hash %llx\n",
+			  index_area.start_hash,
+			  index_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_process_index_area;
+	} else if (index_area.start_hash > index_area.end_hash) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid range: "
+			  "start_hash %llx, end_hash %llx\n",
+			  index_area.start_hash,
+			  index_area.end_hash);
+		goto finish_process_index_area;
+	} else if (index_area.start_hash == index_area.end_hash) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("empty range: "
+			  "start_hash %llx, end_hash %llx\n",
+			  index_area.start_hash,
+			  index_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_process_index_area;
+	}
+
+	prev_hash = index_area.start_hash;
+
+	for (i = 0; i < index_area.index_count; i++) {
+		err = ssdfs_btree_node_get_index(&node->content.pvec,
+						 index_area.offset,
+						 index_area.area_size,
+						 node->node_size,
+						 (u16)i, &index);
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to extract index: "
+				  "node_id %u, index %d, err %d\n",
+				  node->node_id, 0, err);
+			goto finish_process_index_area;
+		}
+
+		start_hash = le64_to_cpu(index.index.hash);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("prev_hash %llx, start_hash %llx, "
+			  "index_area.start_hash %llx\n",
+			  prev_hash, start_hash,
+			  index_area.start_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (prev_hash != start_hash) {
+			err = ssdfs_process_deleted_nodes(node, q,
+							  prev_hash,
+							  start_hash,
+							  inodes_per_node);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to process deleted nodes: "
+					  "start_hash %llx, end_hash %llx, "
+					  "err %d\n",
+					  prev_hash, start_hash, err);
+				goto finish_process_index_area;
+			}
+		}
+
+		prev_hash = start_hash + inodes_per_node;
+	}
+
+	if (prev_hash < index_area.end_hash) {
+		start_hash = index_area.end_hash + inodes_per_node;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("prev_hash %llx, start_hash %llx, "
+			  "index_area.end_hash %llx\n",
+			  prev_hash, start_hash,
+			  index_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_process_deleted_nodes(node, q,
+						  prev_hash,
+						  start_hash,
+						  inodes_per_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to process deleted nodes: "
+				  "start_hash %llx, end_hash %llx, "
+				  "err %d\n",
+				  prev_hash, start_hash, err);
+			goto finish_process_index_area;
+		}
+	}
+
+finish_process_index_area:
+	return err;
+}
+
+/*
+ * ssdfs_inodes_btree_init_node() - init inodes tree's node
+ * @node: pointer on node object
+ *
+ * This method tries to init the node of inodes btree.
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
+int ssdfs_inodes_btree_init_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_inodes_btree_info *tree;
+	struct ssdfs_inodes_btree_node_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_inodes_btree_node_header);
+	struct ssdfs_free_inode_range_queue q;
+	struct ssdfs_inodes_btree_range *range;
+	void *addr[SSDFS_BTREE_NODE_BMAP_COUNT];
+	struct page *page;
+	void *kaddr;
+	u32 node_size;
+	u16 flags;
+	u16 item_size;
+	u32 items_count = 0;
+	u8 index_size;
+	u16 items_capacity;
+	u32 index_area_size = 0;
+	u16 index_capacity = 0;
+	u16 inodes_count;
+	u16 valid_inodes;
+	size_t bmap_bytes;
+	u64 start_hash, end_hash;
+	unsigned long start, end;
+	unsigned long size, upper_bound;
+	signed long count;
+	unsigned long free_inodes;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node->tree->type == SSDFS_INODES_BTREE)
+		tree = (struct ssdfs_inodes_btree_info *)node->tree;
+	else {
+		SSDFS_ERR("invalid tree type %#x\n",
+			  node->tree->type);
+		return -ERANGE;
+	}
+
+	if (atomic_read(&node->state) != SSDFS_BTREE_NODE_CONTENT_PREPARED) {
+		SSDFS_WARN("fail to init node: id %u, state %#x\n",
+			   node->node_id, atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	down_read(&node->full_lock);
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
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("PAGE DUMP\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     kaddr,
+			     PAGE_SIZE);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_inodes_btree_node_header *)kaddr;
+
+	if (!is_csum_valid(&hdr->node.check, hdr, hdr_size)) {
+		err = -EIO;
+		SSDFS_ERR("invalid checksum: node_id %u\n",
+			  node->node_id);
+		goto finish_init_operation;
+	}
+
+	if (le32_to_cpu(hdr->node.magic.common) != SSDFS_SUPER_MAGIC ||
+	    le16_to_cpu(hdr->node.magic.key) != SSDFS_INODES_BNODE_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid magic: common %#x, key %#x\n",
+			  le32_to_cpu(hdr->node.magic.common),
+			  le16_to_cpu(hdr->node.magic.key));
+		goto finish_init_operation;
+	}
+
+	down_write(&node->header_lock);
+
+	ssdfs_memcpy(&node->raw.inodes_header, 0, hdr_size,
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
+	item_size = node->tree->item_size;
+	items_capacity = le16_to_cpu(hdr->node.items_capacity);
+	inodes_count = le16_to_cpu(hdr->inodes_count);
+	valid_inodes = le16_to_cpu(hdr->valid_inodes);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "items_capacity %u, valid_inodes %u, "
+		  "inodes_count %u\n",
+		  start_hash, end_hash, items_capacity,
+		  valid_inodes, inodes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (item_size == 0 || node_size % item_size) {
+		err = -EIO;
+		SSDFS_ERR("invalid size: item_size %u, node_size %u\n",
+			  item_size, node_size);
+		goto finish_header_init;
+	}
+
+	if (item_size != sizeof(struct ssdfs_inode)) {
+		err = -EIO;
+		SSDFS_ERR("invalid item_size: "
+			  "size %u, expected size %zu\n",
+			  item_size,
+			  sizeof(struct ssdfs_inode));
+		goto finish_header_init;
+	}
+
+	switch (hdr->node.type) {
+	case SSDFS_BTREE_LEAF_NODE:
+		if (items_capacity == 0 ||
+		    items_capacity > (node_size / item_size)) {
+			err = -EIO;
+			SSDFS_ERR("invalid items_capacity %u\n",
+				  items_capacity);
+			goto finish_header_init;
+		}
+
+		if (items_capacity != inodes_count) {
+			err = -EIO;
+			SSDFS_ERR("items_capacity %u != inodes_count %u\n",
+				  items_capacity,
+				  inodes_count);
+			goto finish_header_init;
+		}
+
+		if (valid_inodes > inodes_count) {
+			err = -EIO;
+			SSDFS_ERR("valid_inodes %u > inodes_count %u\n",
+				  valid_inodes, inodes_count);
+			goto finish_header_init;
+		}
+
+		node->items_area.items_count = valid_inodes;
+		node->items_area.items_capacity = inodes_count;
+		free_inodes = inodes_count - valid_inodes;
+
+		node->items_area.free_space = (u32)free_inodes * item_size;
+		if (node->items_area.free_space > node->items_area.area_size) {
+			err = -EIO;
+			SSDFS_ERR("free_space %u > area_size %u\n",
+				  node->items_area.free_space,
+				  node->items_area.area_size);
+			goto finish_header_init;
+		}
+
+		items_count = node_size / item_size;
+		items_capacity = node_size / item_size;
+
+		index_capacity = 0;
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (items_capacity == 0 ||
+		    items_capacity > (node_size / item_size)) {
+			err = -EIO;
+			SSDFS_ERR("invalid items_capacity %u\n",
+				  items_capacity);
+			goto finish_header_init;
+		}
+
+		if (items_capacity != inodes_count) {
+			err = -EIO;
+			SSDFS_ERR("items_capacity %u != inodes_count %u\n",
+				  items_capacity,
+				  inodes_count);
+			goto finish_header_init;
+		}
+
+		if (valid_inodes > inodes_count) {
+			err = -EIO;
+			SSDFS_ERR("valid_inodes %u > inodes_count %u\n",
+				  valid_inodes, inodes_count);
+			goto finish_header_init;
+		}
+
+		node->items_area.items_count = valid_inodes;
+		node->items_area.items_capacity = inodes_count;
+		free_inodes = inodes_count - valid_inodes;
+
+		node->items_area.free_space = (u32)free_inodes * item_size;
+		if (node->items_area.free_space > node->items_area.area_size) {
+			err = -EIO;
+			SSDFS_ERR("free_space %u > area_size %u\n",
+				  node->items_area.free_space,
+				  node->items_area.area_size);
+			goto finish_header_init;
+		}
+
+		node->index_area.start_hash =
+				le64_to_cpu(hdr->index_area.start_hash);
+		node->index_area.end_hash =
+				le64_to_cpu(hdr->index_area.end_hash);
+
+		if (node->index_area.start_hash >= U64_MAX ||
+		    node->index_area.end_hash >= U64_MAX) {
+			err = -EIO;
+			SSDFS_ERR("corrupted node: "
+				  "index_area (start_hash %llx, end_hash %llx)\n",
+				  node->index_area.start_hash,
+				  node->index_area.end_hash);
+			goto finish_header_init;
+		}
+
+		items_count = node_size / item_size;
+		items_capacity = node_size / item_size;
+
+		index_capacity = node_size / index_size;
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		node->items_area.items_count = 0;
+		node->items_area.items_capacity = 0;
+		node->items_area.free_space = 0;
+
+		items_count = 0;
+		items_capacity = 0;
+
+		if (start_hash != le64_to_cpu(hdr->index_area.start_hash) ||
+		    end_hash != le64_to_cpu(hdr->index_area.end_hash)) {
+			err = -EIO;
+			SSDFS_ERR("corrupted node: "
+				  "node index_area "
+				  "(start_hash %llx, end_hash %llx), "
+				  "header index_area "
+				  "(start_hash %llx, end_hash %llx)\n",
+				  node->index_area.start_hash,
+				  node->index_area.end_hash,
+				  le64_to_cpu(hdr->index_area.start_hash),
+				  le64_to_cpu(hdr->index_area.end_hash));
+			goto finish_header_init;
+		}
+
+		index_capacity = node_size / index_size;
+		break;
+
+	default:
+		SSDFS_ERR("unexpected node type %#x\n",
+			  hdr->node.type);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %u, area_size %u, free_space %u\n",
+		  node->items_area.items_count,
+		  node->items_area.area_size,
+		  node->items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_header_init:
+	up_write(&node->header_lock);
+
+	if (unlikely(err))
+		goto finish_init_operation;
+
+	bmap_bytes = index_capacity + items_capacity + 1;
+	bmap_bytes += BITS_PER_LONG;
+	bmap_bytes /= BITS_PER_BYTE;
+
+	if (bmap_bytes == 0 || bmap_bytes > SSDFS_INODE_BMAP_SIZE) {
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
+		index_area_size = 1 << hdr->node.log_index_area_size;
+		index_area_size += index_size - 1;
+		index_capacity = index_area_size / index_size;
+		node->bmap_array.item_start_bit =
+			node->bmap_array.index_start_bit + index_capacity;
+	} else if (flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA) {
+		node->bmap_array.item_start_bit =
+				SSDFS_BTREE_NODE_HEADER_INDEX + 1;
+	} else
+		BUG();
+
+	node->bmap_array.bits_count = index_capacity + items_capacity + 1;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("index_capacity %u, index_area_size %u, "
+		  "index_size %u\n",
+		  index_capacity, index_area_size, index_size);
+	SSDFS_DBG("index_start_bit %lu, item_start_bit %lu, "
+		  "bits_count %lu\n",
+		  node->bmap_array.index_start_bit,
+		  node->bmap_array.item_start_bit,
+		  node->bmap_array.bits_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_btree_node_init_bmaps(node, addr);
+
+	spin_lock(&node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].lock);
+	ssdfs_memcpy(node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].ptr,
+		     0, bmap_bytes,
+		     hdr->bmap,
+		     0, bmap_bytes,
+		     bmap_bytes);
+	spin_unlock(&node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].lock);
+
+	start = node->bmap_array.item_start_bit;
+
+	up_write(&node->bmap_array.lock);
+finish_init_operation:
+	kunmap_local(kaddr);
+
+	if (unlikely(err))
+		goto finish_init_node;
+
+	if (hdr->node.type == SSDFS_BTREE_INDEX_NODE)
+		goto finish_init_node;
+
+	ssdfs_free_inodes_queue_init(&q);
+
+	switch (hdr->node.type) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		err = ssdfs_inodes_btree_detect_deleted_nodes(node, &q);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to detect deleted nodes: "
+				  "err %d\n", err);
+			ssdfs_free_inodes_queue_remove_all(&q);
+			goto finish_init_node;
+		}
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	size = inodes_count;
+	upper_bound = node->bmap_array.item_start_bit + size;
+	free_inodes = 0;
+
+	do {
+		start = find_next_zero_bit((unsigned long *)hdr->bmap,
+					   upper_bound, start);
+		if (start >= upper_bound)
+			break;
+
+		end = find_next_bit((unsigned long *)hdr->bmap,
+				    upper_bound, start);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(start >= U16_MAX);
+		BUG_ON((end - start) >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		count = end - start;
+		start -= node->bmap_array.item_start_bit;
+
+		if (count <= 0) {
+			err = -ERANGE;
+			SSDFS_WARN("invalid count %ld\n", count);
+			break;
+		}
+
+		range = ssdfs_free_inodes_range_alloc();
+		if (unlikely(!range)) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate inodes range\n");
+			break;
+		}
+
+		ssdfs_free_inodes_range_init(range);
+		range->node_id = node->node_id;
+		range->area.start_hash = start_hash + start;
+		range->area.start_index = (u16)start;
+		range->area.count = (u16)count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_hash %llx, end_hash %llx, "
+			  "range->area.start_hash %llx\n",
+			  start_hash, end_hash,
+			  range->area.start_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (range->area.start_hash > end_hash) {
+			err = -EIO;
+			SSDFS_ERR("start_hash %llx > end_hash %llx\n",
+				  range->area.start_hash, end_hash);
+			ssdfs_free_inodes_range_free(range);
+			break;
+		}
+
+		free_inodes += count;
+		if ((valid_inodes + free_inodes) > inodes_count) {
+			err = -EIO;
+			SSDFS_ERR("invalid free_inodes: "
+				  "valid_inodes %u, free_inodes %lu, "
+				  "inodes_count %u\n",
+				  valid_inodes, free_inodes,
+				  inodes_count);
+			ssdfs_free_inodes_range_free(range);
+			break;
+		}
+
+		ssdfs_free_inodes_queue_add_tail(&q, range);
+
+		spin_lock(&tree->lock);
+		if (range->area.start_hash > tree->last_free_ino) {
+			tree->last_free_ino =
+				range->area.start_hash + range->area.count;
+		}
+		spin_unlock(&tree->lock);
+
+		start = end;
+	} while (start < size);
+
+	if (unlikely(err)) {
+		ssdfs_free_inodes_queue_remove_all(&q);
+		goto finish_init_node;
+	}
+
+	while (!is_ssdfs_free_inodes_queue_empty(&q)) {
+		err = ssdfs_free_inodes_queue_remove_first(&q, &range);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get range: err %d\n", err);
+			goto finish_init_node;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("add free range: node_id %u, "
+			  "start_hash %llx, start_index %u, "
+			  "count %u\n",
+			  range->node_id,
+			  range->area.start_hash,
+			  range->area.start_index,
+			  range->area.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_free_inodes_queue_add_tail(&tree->free_inodes_queue,
+						 range);
+	};
+
+finish_init_node:
+	up_read(&node->full_lock);
+
+	ssdfs_debug_btree_node_object(node);
+
+	return err;
+}
+
+static
+void ssdfs_inodes_btree_destroy_node(struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_inodes_btree_node_correct_hash_range() - correct node's hash range
+ * @node: pointer on node object
+ *
+ * This method tries to correct node's hash range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_inodes_btree_node_correct_hash_range(struct ssdfs_btree_node *node,
+						u64 start_hash)
+{
+	struct ssdfs_inodes_btree_info *itree;
+	u16 items_count;
+	u16 items_capacity;
+	u16 free_items;
+	struct ssdfs_inodes_btree_range *range = NULL;
+	struct ssdfs_btree_index_key new_key;
+	int type;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(start_hash >= U64_MAX);
+
+	SSDFS_DBG("node_id %u, state %#x, "
+		  "node_type %#x, start_hash %llx\n",
+		  node->node_id, atomic_read(&node->state),
+		  atomic_read(&node->type), start_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	itree = (struct ssdfs_inodes_btree_info *)node->tree;
+	type = atomic_read(&node->type);
+
+	switch (type) {
+	case SSDFS_BTREE_LEAF_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected state */
+		break;
+
+	default:
+		/* do nothing */
+		return 0;
+	}
+
+	down_write(&node->header_lock);
+
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+
+	switch (type) {
+	case SSDFS_BTREE_LEAF_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(items_capacity == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+		node->items_area.start_hash = start_hash;
+		node->items_area.end_hash = start_hash + items_capacity - 1;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	up_write(&node->header_lock);
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		spin_lock(&node->descriptor_lock);
+		ssdfs_memcpy(&new_key,
+			     0, sizeof(struct ssdfs_btree_index_key),
+			     &node->node_index,
+			     0, sizeof(struct ssdfs_btree_index_key),
+			     sizeof(struct ssdfs_btree_index_key));
+		spin_unlock(&node->descriptor_lock);
+
+		new_key.index.hash = cpu_to_le64(start_hash);
+
+		err = ssdfs_btree_node_add_index(node, &new_key);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add index: err %d\n",
+				  err);
+			return err;
+		}
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(items_count > items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	free_items = items_capacity - items_count;
+
+	if (items_capacity == 0) {
+		if (type == SSDFS_BTREE_LEAF_NODE ||
+		    type == SSDFS_BTREE_HYBRID_NODE) {
+			SSDFS_ERR("invalid node state: "
+				  "type %#x, items_capacity %u\n",
+				  type, items_capacity);
+			return -ERANGE;
+		}
+	} else {
+		range = ssdfs_free_inodes_range_alloc();
+		if (unlikely(!range)) {
+			SSDFS_ERR("fail to allocate inodes range\n");
+			return -ENOMEM;
+		}
+
+		ssdfs_free_inodes_range_init(range);
+		range->node_id = node->node_id;
+		range->area.start_hash = start_hash + items_count;
+		range->area.start_index = items_count;
+		range->area.count = free_items;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("add free range: node_id %u, "
+			  "start_hash %llx, start_index %u, "
+			  "count %u\n",
+			  range->node_id,
+			  range->area.start_hash,
+			  range->area.start_index,
+			  range->area.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_free_inodes_queue_add_tail(&itree->free_inodes_queue,
+						 range);
+
+		spin_lock(&itree->lock);
+		if (range->area.start_hash > itree->last_free_ino) {
+			itree->last_free_ino =
+				range->area.start_hash + range->area.count;
+		}
+		spin_unlock(&itree->lock);
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	return 0;
+}
+
+/*
+ * ssdfs_inodes_btree_add_node() - add node into inodes btree
+ * @node: pointer on node object
+ *
+ * This method tries to finish addition of node into inodes btree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_inodes_btree_add_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_inodes_btree_info *itree;
+	struct ssdfs_btree_node *parent_node = NULL;
+	int type;
+	u64 start_hash = U64_MAX;
+	u16 items_capacity;
+	spinlock_t *lock;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
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
+	itree = (struct ssdfs_inodes_btree_info *)node->tree;
+	type = atomic_read(&node->type);
+
+	down_read(&node->header_lock);
+	start_hash = node->items_area.start_hash;
+	items_capacity = node->items_area.items_capacity;
+	up_read(&node->header_lock);
+
+	switch (type) {
+	case SSDFS_BTREE_INDEX_NODE:
+		ssdfs_debug_btree_node_object(node);
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		err = ssdfs_inodes_btree_node_correct_hash_range(node,
+								 start_hash);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to correct hash range: "
+				  "err %d\n", err);
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			return err;
+		}
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		err = ssdfs_inodes_btree_node_correct_hash_range(node,
+								 start_hash);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to correct hash range: "
+				  "err %d\n", err);
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			return err;
+		}
+
+		lock = &node->descriptor_lock;
+		spin_lock(lock);
+		parent_node = node->parent_node;
+		spin_unlock(lock);
+		lock = NULL;
+
+		start_hash += items_capacity;
+
+		err = ssdfs_inodes_btree_node_correct_hash_range(parent_node,
+								 start_hash);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to correct hash range: "
+				  "err %d\n", err);
+			atomic_set(&parent_node->state,
+					SSDFS_BTREE_NODE_CORRUPTED);
+			return err;
+		}
+		break;
+
+	default:
+		SSDFS_WARN("invalid node type %#x\n", type);
+		return -ERANGE;
+	};
+
+	spin_lock(&itree->lock);
+	itree->nodes_count++;
+	if (type == SSDFS_BTREE_LEAF_NODE)
+		itree->leaf_nodes++;
+	itree->inodes_capacity += items_capacity;
+	itree->free_inodes += items_capacity;
+	spin_unlock(&itree->lock);
+
+	err = ssdfs_btree_update_parent_node_pointer(node->tree, node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update parent pointer: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		return err;
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	return 0;
+}
+
+static
+int ssdfs_inodes_btree_delete_node(struct ssdfs_btree_node *node)
+{
+	/* TODO: implement */
+	SSDFS_DBG("TODO: implement %s\n", __func__);
+	return 0;
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
+ * ssdfs_inodes_btree_pre_flush_node() - pre-flush node's header
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
+int ssdfs_inodes_btree_pre_flush_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_inodes_btree_node_header inodes_header;
+	struct ssdfs_state_bitmap *bmap;
+	size_t hdr_size = sizeof(struct ssdfs_inodes_btree_node_header);
+	u32 bmap_bytes;
+	struct page *page;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_debug_btree_node_object(node);
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
+	case SSDFS_BTREE_NODE_PRE_DELETED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is pre-deleted\n",
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
+	down_write(&node->full_lock);
+	down_write(&node->header_lock);
+
+	ssdfs_memcpy(&inodes_header, 0, hdr_size,
+		     &node->raw.inodes_header, 0, hdr_size,
+		     hdr_size);
+
+	inodes_header.node.magic.common = cpu_to_le32(SSDFS_SUPER_MAGIC);
+	inodes_header.node.magic.key = cpu_to_le16(SSDFS_INODES_BNODE_MAGIC);
+	inodes_header.node.magic.version.major = SSDFS_MAJOR_REVISION;
+	inodes_header.node.magic.version.minor = SSDFS_MINOR_REVISION;
+
+	err = ssdfs_btree_node_pre_flush_header(node, &inodes_header.node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to flush generic header: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		goto finish_inodes_header_preparation;
+	}
+
+	inodes_header.valid_inodes =
+		cpu_to_le16(node->items_area.items_count);
+	inodes_header.inodes_count =
+		cpu_to_le16(node->items_area.items_capacity);
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		inodes_header.index_area.start_hash =
+				cpu_to_le64(node->index_area.start_hash);
+		inodes_header.index_area.end_hash =
+				cpu_to_le64(node->index_area.end_hash);
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		/* do nothing */
+		break;
+
+	default:
+		SSDFS_WARN("invalid node type %#x\n",
+			   atomic_read(&node->type));
+		break;
+	};
+
+	down_read(&node->bmap_array.lock);
+	bmap_bytes = node->bmap_array.bmap_bytes;
+	spin_lock(&node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].lock);
+	ssdfs_memcpy(inodes_header.bmap,
+		     0, bmap_bytes,
+		     node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].ptr,
+		     0, bmap_bytes,
+		     bmap_bytes);
+	spin_unlock(&node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].lock);
+	up_read(&node->bmap_array.lock);
+
+	inodes_header.node.check.bytes = cpu_to_le16((u16)hdr_size);
+	inodes_header.node.check.flags = cpu_to_le16(SSDFS_CRC32);
+
+	err = ssdfs_calculate_csum(&inodes_header.node.check,
+				   &inodes_header, hdr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to calculate checksum: err %d\n", err);
+		goto finish_inodes_header_preparation;
+	}
+
+	ssdfs_memcpy(&node->raw.inodes_header, 0, hdr_size,
+		     &inodes_header, 0, hdr_size,
+		     hdr_size);
+
+finish_inodes_header_preparation:
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
+			     &inodes_header, 0, hdr_size,
+			     hdr_size);
+
+finish_node_pre_flush:
+	up_write(&node->full_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_inodes_btree_flush_node() - flush node
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
+int ssdfs_inodes_btree_flush_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree *tree;
+	u64 fs_feature_compat;
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
+	if (tree->type != SSDFS_INODES_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	}
+
+	fsi = node->tree->fsi;
+
+	spin_lock(&fsi->volume_state_lock);
+	fs_feature_compat = fsi->fs_feature_compat;
+	spin_unlock(&fsi->volume_state_lock);
+
+	if (fs_feature_compat & SSDFS_HAS_INODES_TREE_COMPAT_FLAG) {
+		err = ssdfs_btree_common_node_flush(node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to flush node: "
+				  "node_id %u, height %u, err %d\n",
+				  node->node_id,
+				  atomic_read(&node->height),
+				  err);
+		}
+	} else {
+		err = -EFAULT;
+		SSDFS_CRIT("inodes tree is absent\n");
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	return err;
+}
diff --git a/fs/ssdfs/inodes_tree.h b/fs/ssdfs/inodes_tree.h
new file mode 100644
index 000000000000..e0e8efca7b86
--- /dev/null
+++ b/fs/ssdfs/inodes_tree.h
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/inodes_tree.h - inodes btree declarations.
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
+#ifndef _SSDFS_INODES_TREE_H
+#define _SSDFS_INODES_TREE_H
+
+/*
+ * struct ssdfs_inodes_range - items range
+ * @start_hash: starting hash
+ * @start_index: staring index in the node
+ * @count: count of items in the range
+ */
+struct ssdfs_inodes_range {
+#define SSDFS_INODES_RANGE_INVALID_START	(U64_MAX)
+	u64 start_hash;
+#define SSDFS_INODES_RANGE_INVALID_INDEX	(U16_MAX)
+	u16 start_index;
+	u16 count;
+};
+
+/*
+ * struct ssdfs_inodes_btree_range - node's items range descriptor
+ * @list: free inode ranges queue
+ * @node_id: node identification number
+ * @area: items range
+ */
+struct ssdfs_inodes_btree_range {
+	struct list_head list;
+	u32 node_id;
+	struct ssdfs_inodes_range area;
+};
+
+/*
+ * struct ssdfs_free_inode_range_queue - free inode ranges queue
+ * @lock: queue's lock
+ * @list: queue's list
+ */
+struct ssdfs_free_inode_range_queue {
+	spinlock_t lock;
+	struct list_head list;
+};
+
+/*
+ * struct ssdfs_inodes_btree_info - inodes btree info
+ * @generic_tree: generic btree description
+ * @lock: inodes btree lock
+ * @root_folder: copy of root folder's inode
+ * @upper_allocated_ino: maximal allocated inode ID number
+ * @last_free_ino: latest free inode ID number
+ * @allocated_inodes: allocated inodes count in the whole tree
+ * @free_inodes: free inodes count in the whole tree
+ * @inodes_capacity: inodes capacity in the whole tree
+ * @leaf_nodes: count of leaf nodes in the whole tree
+ * @nodes_count: count of all nodes in the whole tree
+ * @raw_inode_size: size in bytes of raw inode
+ * @free_inodes_queue: queue of free inode descriptors
+ */
+struct ssdfs_inodes_btree_info {
+	struct ssdfs_btree generic_tree;
+
+	spinlock_t lock;
+	struct ssdfs_inode root_folder;
+	u64 upper_allocated_ino;
+	u64 last_free_ino;
+	u64 allocated_inodes;
+	u64 free_inodes;
+	u64 inodes_capacity;
+	u32 leaf_nodes;
+	u32 nodes_count;
+	u16 raw_inode_size;
+
+/*
+ * Inodes btree should have special allocation queue.
+ * If a btree nodes has free (not allocated) inodes
+ * items then the information about such btree node
+ * should be added into queue. Moreover, queue should
+ * contain as so many node's descriptors as free items
+ * in the node.
+ *
+ * If some btree node has deleted inodes (free items)
+ * then all node's descriptors should be added into
+ * the head of allocation queue. Descriptors of the last
+ * btree's node should be added into tail of the queue.
+ * Information about node's descriptors should be added
+ * into the allocation queue during btree node creation
+ * or reading from the volume. Otherwise, allocation of
+ * new items should be done from last leaf btree's node.
+ */
+	struct ssdfs_free_inode_range_queue free_inodes_queue;
+};
+
+/*
+ * Inline methods
+ */
+static inline
+bool is_free_inodes_range_invalid(struct ssdfs_inodes_btree_range *range)
+{
+	bool is_invalid;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!range);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	is_invalid = range->node_id == SSDFS_BTREE_NODE_INVALID_ID ||
+		range->area.start_hash == SSDFS_INODES_RANGE_INVALID_START ||
+		range->area.start_index == SSDFS_INODES_RANGE_INVALID_INDEX ||
+		range->area.count == 0;
+
+	if (is_invalid) {
+		SSDFS_ERR("node_id %u, start_hash %llx, "
+			  "start_index %u, count %u\n",
+			  range->node_id,
+			  range->area.start_hash,
+			  range->area.start_index,
+			  range->area.count);
+	}
+
+	return is_invalid;
+}
+
+/*
+ * Free inodes range API
+ */
+struct ssdfs_inodes_btree_range *ssdfs_free_inodes_range_alloc(void);
+void ssdfs_free_inodes_range_free(struct ssdfs_inodes_btree_range *range);
+void ssdfs_free_inodes_range_init(struct ssdfs_inodes_btree_range *range);
+
+/*
+ * Inodes btree API
+ */
+int ssdfs_inodes_btree_create(struct ssdfs_fs_info *fsi);
+void ssdfs_inodes_btree_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_inodes_btree_flush(struct ssdfs_inodes_btree_info *tree);
+
+int ssdfs_inodes_btree_allocate(struct ssdfs_inodes_btree_info *tree,
+				ino_t *ino,
+				struct ssdfs_btree_search *search);
+int ssdfs_inodes_btree_find(struct ssdfs_inodes_btree_info *tree,
+			    ino_t ino,
+			    struct ssdfs_btree_search *search);
+int ssdfs_inodes_btree_change(struct ssdfs_inodes_btree_info *tree,
+				ino_t ino,
+				struct ssdfs_btree_search *search);
+int ssdfs_inodes_btree_delete(struct ssdfs_inodes_btree_info *tree,
+				ino_t ino);
+int ssdfs_inodes_btree_delete_range(struct ssdfs_inodes_btree_info *tree,
+				    ino_t ino, u16 count);
+
+void ssdfs_debug_inodes_btree_object(struct ssdfs_inodes_btree_info *tree);
+
+/*
+ * Inodes btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations
+						ssdfs_inodes_btree_desc_ops;
+extern const struct ssdfs_btree_operations ssdfs_inodes_btree_ops;
+extern const struct ssdfs_btree_node_operations ssdfs_inodes_btree_node_ops;
+
+#endif /* _SSDFS_INODES_TREE_H */
-- 
2.34.1


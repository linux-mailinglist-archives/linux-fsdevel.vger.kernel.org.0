Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968336A266B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBYBUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjBYBTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:11 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6A0D33C
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:55 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bi17so823209oib.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ILxrIp7YEz/Of4dTMw2qMTAAOGvIyV39QleVA6DH+A=;
        b=UTKl/C5pwS7UC4EQyXUshung5qToYXDRMTlGZQoQQqpU3xaKfgkLz09eaYORL7xdVq
         ksVc4WWRZJx57JurofTiE5C6nnMda3J3oWRfsDI/sFpuMQXTAoPJhR6BT5C/E8AAgEZT
         ST9qaWMwWtqRgYHNsnik1v/AZvEV6x+cCa9sJ3Ge4ynRn8ZHRkuJcnWYEXuBNoqNoy43
         RAN4sTvg3X6+udPglYLYEC1z+oyrvWc2oVfYCU0EupZt7A65yMbbgwEKGJ3+mxkPTPKx
         PBc4tetAi7PET/pkiDonJWFx7mhhYkALV+TqFP+9Oh3Z9TB6iyQHKNmOmIoc+1DqLuda
         YaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ILxrIp7YEz/Of4dTMw2qMTAAOGvIyV39QleVA6DH+A=;
        b=gIso5De81ThxAqiO8sThDaEsvEw35xiLgOjsUtnUKnFApuZZU64ChZwSk1ZKjYZKZz
         qw10yNadzXlYqGw0gcRwP93AEb2RYo3xmLzWitBH+lRwh8Xl88zhB7mprPe2PYqWZ+uk
         IwFABeByP5JHv0d59i7yf0pWVZ6UORQX6JXPgGZ8VaqM3QZsfwKUs+V50L3lFjnhEA1q
         v+2qYUK/p5vY8JVVNV/CzSi4Cr96A72/Bgh4gJh7087uOgk2IAeZHJP484pPW+5O54+c
         5UvewkX7+ObA7vqv+QVlV0AlBSAD4/2lP8sy1kz9xYFBf4Tt0SSaBHXHtSpEbwAenW0g
         yXPg==
X-Gm-Message-State: AO0yUKXHU/vVH1a8Cj3uPAzhzRHWIsKAMqqhfBeKct42KMBxh+24sFgf
        02J6dkZz72KoWhgqdHvZ8PvVf9Cgvmvyp6Bn
X-Google-Smtp-Source: AK7set/dRemqYge6HkbUOsC4K9Gkzs9eqDWNspizxYxM2NkF1muqhaZyi5iI46Qzsm/mq31Ik8EuzA==
X-Received: by 2002:a54:4684:0:b0:378:1ae8:9253 with SMTP id k4-20020a544684000000b003781ae89253mr4405914oic.45.1677287874372;
        Fri, 24 Feb 2023 17:17:54 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:53 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 66/76] ssdfs: introduce extents b-tree
Date:   Fri, 24 Feb 2023 17:09:17 -0800
Message-Id: <20230225010927.813929-67-slava@dubeyko.com>
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

SSDFS raw extent describes a contiguous sequence of logical blocks
by means of segment ID, logical block number of starting position,
and length. By default, SSDFS inode has the private area of
128 bytes in size and SSDFS extent has 16 bytes in size. As a result,
the inode’s private area is capable to store not more than 8 raw
extents. Generally speaking, hybrid b-tree was opted with the goal
to store efficiently larger number of raw extents. First of all,
it was taken into account that file sizes can vary a lot on the same
file system’s volume. Moreover, the size of the same file could vary
significantly during its lifetime. Finally, b-tree is the really good
mechanism for storing the extents compactly with very flexible way of
increasing or shrinking the reserved space. Also b-tree provides very
efficient technique of extents lookup. Additionally, SSDFS file system
uses compression that guarantee the really compact storage of semi-empty
b-tree nodes. Moreover, hybrid b-tree provides the way to mix as index as
data records in the hybrid nodes with the goal to achieve much more
compact representation of b-tree’s content. It needs to point out that
extents b-tree’s nodes group the extent records into forks.
Generally speaking, the raw extent describes a position on the volume of
some contiguous sequence of logical blocks without any details about
the offset of this extent from a file’s beginning. As a result, the fork
describes an offset of some portion of file’s content from the file’s
beginning and number of logical blocks in this portion. Also fork contains
the space for three raw extents that are able to define the position of
three contiguous sequences of logical blocks on the file system’s volume.
Finally, one fork has 64 bytes in size. If anybody considers a b-tree
node of 4 KB in size then such node is capable to store about 64 forks with
192 extents in total. Generally speaking, even a small b-tree is able
to store a significant number of extents and to determine the position of
fragments of generally big file. If anybody imagines a b-tree with the two
4 KB nodes in total, every extent defines a position of 8 MB file’s
portion then such b-tree is able to describe a file of 3 GB in total.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/extents_tree.c | 3370 +++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/extents_tree.h |  171 ++
 2 files changed, 3541 insertions(+)
 create mode 100644 fs/ssdfs/extents_tree.c
 create mode 100644 fs/ssdfs/extents_tree.h

diff --git a/fs/ssdfs/extents_tree.c b/fs/ssdfs/extents_tree.c
new file mode 100644
index 000000000000..a13e7d773e7d
--- /dev/null
+++ b/fs/ssdfs/extents_tree.c
@@ -0,0 +1,3370 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/extents_tree.c - extents tree functionality.
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
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/writeback.h>
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
+#include "extents_queue.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "shared_extents_tree.h"
+#include "segment_tree.h"
+#include "extents_tree.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_ext_tree_page_leaks;
+atomic64_t ssdfs_ext_tree_memory_leaks;
+atomic64_t ssdfs_ext_tree_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_ext_tree_cache_leaks_increment(void *kaddr)
+ * void ssdfs_ext_tree_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_ext_tree_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_ext_tree_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_ext_tree_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_ext_tree_kfree(void *kaddr)
+ * struct page *ssdfs_ext_tree_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_ext_tree_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_ext_tree_free_page(struct page *page)
+ * void ssdfs_ext_tree_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(ext_tree)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(ext_tree)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_ext_tree_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_ext_tree_page_leaks, 0);
+	atomic64_set(&ssdfs_ext_tree_memory_leaks, 0);
+	atomic64_set(&ssdfs_ext_tree_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_ext_tree_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_ext_tree_page_leaks) != 0) {
+		SSDFS_ERR("EXTENTS TREE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_ext_tree_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_ext_tree_memory_leaks) != 0) {
+		SSDFS_ERR("EXTENTS TREE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_ext_tree_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_ext_tree_cache_leaks) != 0) {
+		SSDFS_ERR("EXTENTS TREE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_ext_tree_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_commit_queue_create() - create commit queue
+ * @tree: extents tree
+ *
+ * This method tries to create the commit queue.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static inline
+int ssdfs_commit_queue_create(struct ssdfs_extents_btree_info *tree)
+{
+	size_t bytes_count = sizeof(u64) * SSDFS_COMMIT_QUEUE_DEFAULT_CAPACITY;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree->updated_segs.ids = ssdfs_ext_tree_kzalloc(bytes_count,
+							GFP_KERNEL);
+	if (!tree->updated_segs.ids) {
+		SSDFS_ERR("fail to allocate commit queue\n");
+		return -ENOMEM;
+	}
+
+	tree->updated_segs.count = 0;
+	tree->updated_segs.capacity = SSDFS_COMMIT_QUEUE_DEFAULT_CAPACITY;
+
+	return 0;
+}
+
+/*
+ * ssdfs_commit_queue_destroy() - destroy commit queue
+ * @tree: extents tree
+ *
+ * This method tries to destroy the commit queue.
+ */
+static inline
+void ssdfs_commit_queue_destroy(struct ssdfs_extents_btree_info *tree)
+{
+	u32 i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!tree->updated_segs.ids)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("count %u, capacity %u\n",
+		  tree->updated_segs.count,
+		  tree->updated_segs.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (tree->updated_segs.count > tree->updated_segs.capacity ||
+	    tree->updated_segs.capacity == 0) {
+		SSDFS_WARN("count %u > capacity %u\n",
+			   tree->updated_segs.count,
+			   tree->updated_segs.capacity);
+	}
+
+	if (tree->updated_segs.count != 0) {
+		SSDFS_ERR("NOT processed segments:\n");
+
+		for (i = 0; i < tree->updated_segs.count; i++) {
+			SSDFS_ERR("ino %lu --> seg %llu\n",
+				  tree->owner->vfs_inode.i_ino,
+				  tree->updated_segs.ids[i]);
+		}
+
+		SSDFS_WARN("commit queue contains not processed segments: "
+			   "count %u\n",
+			   tree->updated_segs.count);
+	}
+
+	ssdfs_ext_tree_kfree(tree->updated_segs.ids);
+	tree->updated_segs.ids = NULL;
+	tree->updated_segs.count = 0;
+	tree->updated_segs.capacity = 0;
+}
+
+/*
+ * ssdfs_commit_queue_realloc() - realloc commit queue
+ * @tree: extents tree
+ *
+ * This method tries to realloc the commit queue.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static inline
+int ssdfs_commit_queue_realloc(struct ssdfs_extents_btree_info *tree)
+{
+	size_t old_size, new_size;
+	size_t step_size = sizeof(u64) * SSDFS_COMMIT_QUEUE_DEFAULT_CAPACITY;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!tree->updated_segs.ids) {
+		SSDFS_ERR("commit queue is absent!!!\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("count %u, capacity %u\n",
+		  tree->updated_segs.count,
+		  tree->updated_segs.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (tree->updated_segs.count > tree->updated_segs.capacity ||
+	    tree->updated_segs.capacity == 0) {
+		SSDFS_ERR("count %u > capacity %u\n",
+			   tree->updated_segs.count,
+			   tree->updated_segs.capacity);
+		return -ERANGE;
+	}
+
+	if (tree->updated_segs.count < tree->updated_segs.capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("NO realloc necessary: "
+			  "count %u < capacity %u\n",
+			  tree->updated_segs.count,
+			  tree->updated_segs.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	old_size = sizeof(u64) * tree->updated_segs.capacity;
+	new_size = old_size + step_size;
+
+	tree->updated_segs.ids = krealloc(tree->updated_segs.ids,
+					  new_size,
+					  GFP_KERNEL | __GFP_ZERO);
+	if (!tree->updated_segs.ids) {
+		SSDFS_ERR("fail to re-allocate commit queue\n");
+		return -ENOMEM;
+	}
+
+	tree->updated_segs.capacity += SSDFS_COMMIT_QUEUE_DEFAULT_CAPACITY;
+
+	return 0;
+}
+
+/*
+ * ssdfs_commit_queue_add_segment_id() - add updated segment ID in queue
+ * @tree: extents tree
+ * @seg_id: segment ID
+ *
+ * This method tries to add the updated segment ID into
+ * the commit queue.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_commit_queue_add_segment_id(struct ssdfs_extents_btree_info *tree,
+				      u64 seg_id)
+{
+	u32 i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, seg_id %llu\n", tree, seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!tree->updated_segs.ids) {
+		SSDFS_ERR("commit queue is absent!!!\n");
+		return -ERANGE;
+	}
+
+	if (seg_id >= U64_MAX) {
+		SSDFS_ERR("invalid seg_id %llu\n", seg_id);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("count %u, capacity %u\n",
+		  tree->updated_segs.count,
+		  tree->updated_segs.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (tree->updated_segs.count > tree->updated_segs.capacity ||
+	    tree->updated_segs.capacity == 0) {
+		SSDFS_ERR("count %u > capacity %u\n",
+			   tree->updated_segs.count,
+			   tree->updated_segs.capacity);
+		return -ERANGE;
+	}
+
+	for (i = 0; i < tree->updated_segs.count; i++) {
+		if (tree->updated_segs.ids[i] == seg_id) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("seg_id %llu in the queue already\n",
+				  seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return 0;
+		}
+	}
+
+	if (tree->updated_segs.count == tree->updated_segs.capacity) {
+		err = ssdfs_commit_queue_realloc(tree);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to realloc commit queue: "
+				  "seg_id %llu, count %u, "
+				  "capacity %u, err %d\n",
+				  seg_id,
+				  tree->updated_segs.count,
+				  tree->updated_segs.capacity,
+				  err);
+			return err;
+		}
+	}
+
+
+	tree->updated_segs.ids[tree->updated_segs.count] = seg_id;
+	tree->updated_segs.count++;
+
+	return 0;
+}
+
+/*
+ * __ssdfs_commit_queue_issue_requests_async() - issue commit now requests async
+ * @fsi: pointer on shared file system object
+ * @seg_id: segment ID
+ *
+ * This method tries to issue commit now requests
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static int
+__ssdfs_commit_queue_issue_requests_async(struct ssdfs_fs_info *fsi,
+					  u64 seg_id)
+{
+	struct ssdfs_segment_info *si;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi %p, seg_id %llu\n", fsi, seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = ssdfs_grab_segment(fsi, SSDFS_USER_DATA_SEG_TYPE,
+				seg_id, U64_MAX);
+	if (unlikely(IS_ERR_OR_NULL(si))) {
+		err = !si ? -ENOMEM : PTR_ERR(si);
+		SSDFS_ERR("fail to grab segment object: "
+			  "seg %llu, err %d\n",
+			  seg_id, err);
+		return err;
+	}
+
+	for (i = 0; i < si->pebs_count; i++) {
+		struct ssdfs_segment_request *req;
+
+		req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req)) {
+			err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+			SSDFS_ERR("fail to allocate segment request: err %d\n",
+				  err);
+			goto finish_issue_requests_async;
+		}
+
+		ssdfs_request_init(req);
+		ssdfs_get_request(req);
+
+		err = ssdfs_segment_commit_log_async2(si, SSDFS_REQ_ASYNC,
+						      i, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("commit log request failed: "
+				  "peb_index %d, err %d\n",
+				  i, err);
+			ssdfs_put_request(req);
+			ssdfs_request_free(req);
+			goto finish_issue_requests_async;
+		}
+	}
+
+finish_issue_requests_async:
+	ssdfs_segment_put_object(si);
+
+	return err;
+}
+
+/*
+ * ssdfs_commit_queue_issue_requests_async() - issue commit now requests async
+ * @tree: extents tree
+ *
+ * This method tries to issue commit now requests
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static int
+ssdfs_commit_queue_issue_requests_async(struct ssdfs_extents_btree_info *tree)
+{
+	struct ssdfs_fs_info *fsi;
+	size_t bytes_count;
+	u32 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+
+	if (!tree->updated_segs.ids) {
+		SSDFS_ERR("commit queue is absent!!!\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("count %u, capacity %u\n",
+		  tree->updated_segs.count,
+		  tree->updated_segs.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (tree->updated_segs.count > tree->updated_segs.capacity ||
+	    tree->updated_segs.capacity == 0) {
+		SSDFS_ERR("count %u > capacity %u\n",
+			   tree->updated_segs.count,
+			   tree->updated_segs.capacity);
+		return -ERANGE;
+	}
+
+	if (tree->updated_segs.count == 0) {
+		SSDFS_DBG("commit queue is empty\n");
+		return 0;
+	}
+
+	for (i = 0; i < tree->updated_segs.count; i++) {
+		u64 seg_id = tree->updated_segs.ids[i];
+
+		err = __ssdfs_commit_queue_issue_requests_async(fsi, seg_id);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to issue commit requests: "
+				  "seg_id %llu, err %d\n",
+				  seg_id, err);
+			goto finish_issue_requests_async;
+		}
+	}
+
+	bytes_count = sizeof(u64) * tree->updated_segs.capacity;
+	memset(tree->updated_segs.ids, 0, bytes_count);
+
+	tree->updated_segs.count = 0;
+
+finish_issue_requests_async:
+	return err;
+}
+
+/*
+ * __ssdfs_commit_queue_issue_requests_sync() - issue commit now requests sync
+ * @fsi: pointer on shared file system object
+ * @seg_id: segment ID
+ * @pair: pointer on starting seg2req pair
+ *
+ * This method tries to issue commit now requests
+ * synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static int
+__ssdfs_commit_queue_issue_requests_sync(struct ssdfs_fs_info *fsi,
+					 u64 seg_id,
+					 struct ssdfs_seg2req_pair *pair)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_seg2req_pair *cur_pair;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pair);
+
+	SSDFS_DBG("fsi %p, seg_id %llu, pair %p\n",
+		  fsi, seg_id, pair);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = ssdfs_grab_segment(fsi, SSDFS_USER_DATA_SEG_TYPE,
+				seg_id, U64_MAX);
+	if (unlikely(IS_ERR_OR_NULL(si))) {
+		err = !si ? -ENOMEM : PTR_ERR(si);
+		SSDFS_ERR("fail to grab segment object: "
+			  "seg %llu, err %d\n",
+			  seg_id, err);
+		return err;
+	}
+
+	for (i = 0; i < si->pebs_count; i++) {
+		cur_pair = pair + i;
+
+		cur_pair->req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(cur_pair->req)) {
+			err = (cur_pair->req == NULL ?
+					-ENOMEM : PTR_ERR(cur_pair->req));
+			SSDFS_ERR("fail to allocate segment request: err %d\n",
+				  err);
+			goto finish_issue_requests_sync;
+		}
+
+		ssdfs_request_init(cur_pair->req);
+		ssdfs_get_request(cur_pair->req);
+
+		err = ssdfs_segment_commit_log_async2(si,
+						      SSDFS_REQ_ASYNC_NO_FREE,
+						      i, cur_pair->req);
+		if (unlikely(err)) {
+			SSDFS_ERR("commit log request failed: "
+				  "err %d\n", err);
+			ssdfs_put_request(pair->req);
+			ssdfs_request_free(pair->req);
+			pair->req = NULL;
+			goto finish_issue_requests_sync;
+		}
+
+		ssdfs_segment_get_object(si);
+		cur_pair->si = si;
+	}
+
+finish_issue_requests_sync:
+	ssdfs_segment_put_object(si);
+
+	return err;
+}
+
+/*
+ * ssdfs_commit_queue_check_request() - check request
+ * @req: segment request
+ *
+ * This method tries to check the state of request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_commit_queue_check_request(struct ssdfs_segment_request *req)
+{
+	wait_queue_head_t *wq = NULL;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+
+	SSDFS_DBG("req %p\n", req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+check_req_state:
+	switch (atomic_read(&req->result.state)) {
+	case SSDFS_REQ_CREATED:
+	case SSDFS_REQ_STARTED:
+		wq = &req->private.wait_queue;
+
+		err = wait_event_killable_timeout(*wq,
+					has_request_been_executed(req),
+					SSDFS_DEFAULT_TIMEOUT);
+		if (err < 0)
+			WARN_ON(err < 0);
+		else
+			err = 0;
+
+		goto check_req_state;
+		break;
+
+	case SSDFS_REQ_FINISHED:
+		/* do nothing */
+		break;
+
+	case SSDFS_REQ_FAILED:
+		err = req->result.err;
+
+		if (!err) {
+			SSDFS_ERR("error code is absent: "
+				  "req %p, err %d\n",
+				  req, err);
+			err = -ERANGE;
+		}
+
+		SSDFS_ERR("flush request is failed: "
+			  "err %d\n", err);
+		return err;
+
+	default:
+		SSDFS_ERR("invalid result's state %#x\n",
+		    atomic_read(&req->result.state));
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_commit_queue_wait_commit_logs_end() - wait commit logs end
+ * @fsi: pointer on shared file system object
+ * @seg_id: segment ID
+ * @pair: pointer on starting seg2req pair
+ *
+ * This method waits the requests ending and checking
+ * the requests.
+ */
+static void
+ssdfs_commit_queue_wait_commit_logs_end(struct ssdfs_fs_info *fsi,
+					u64 seg_id,
+					struct ssdfs_seg2req_pair *pair)
+{
+	struct ssdfs_seg2req_pair *cur_pair;
+	int refs_count;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pair);
+
+	SSDFS_DBG("fsi %p, seg_id %llu, pair %p\n",
+		  fsi, seg_id, pair);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < fsi->pebs_per_seg; i++) {
+		cur_pair = pair + i;
+
+		if (cur_pair->req != NULL) {
+			err = ssdfs_commit_queue_check_request(cur_pair->req);
+			if (unlikely(err)) {
+				SSDFS_ERR("flush request failed: "
+					  "err %d\n", err);
+			}
+
+			refs_count =
+				atomic_read(&cur_pair->req->private.refs_count);
+			if (refs_count != 0) {
+				SSDFS_WARN("unexpected refs_count %d\n",
+					   refs_count);
+			}
+
+			ssdfs_request_free(cur_pair->req);
+			cur_pair->req = NULL;
+		} else {
+			SSDFS_ERR("request is NULL: "
+				  "item_index %d\n", i);
+		}
+
+		if (cur_pair->si != NULL) {
+			ssdfs_segment_put_object(cur_pair->si);
+			cur_pair->si = NULL;
+		} else {
+			SSDFS_ERR("segment is NULL: "
+				  "item_index %d\n", i);
+		}
+	}
+}
+
+/*
+ * ssdfs_commit_queue_issue_requests_sync() - issue commit now requests sync
+ * @tree: extents tree
+ *
+ * This method tries to issue commit now requests
+ * synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static int
+ssdfs_commit_queue_issue_requests_sync(struct ssdfs_extents_btree_info *tree)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_seg2req_pair *pairs;
+	u32 items_count;
+	size_t bytes_count;
+	u32 i, j;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+
+	if (!tree->updated_segs.ids) {
+		SSDFS_ERR("commit queue is absent!!!\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("count %u, capacity %u\n",
+		  tree->updated_segs.count,
+		  tree->updated_segs.capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (tree->updated_segs.count > tree->updated_segs.capacity ||
+	    tree->updated_segs.capacity == 0) {
+		SSDFS_ERR("count %u > capacity %u\n",
+			   tree->updated_segs.count,
+			   tree->updated_segs.capacity);
+		return -ERANGE;
+	}
+
+	if (tree->updated_segs.count == 0) {
+		SSDFS_DBG("commit queue is empty\n");
+		return 0;
+	}
+
+	items_count = tree->updated_segs.count * fsi->pebs_per_seg;
+
+	pairs = ssdfs_ext_tree_kcalloc(items_count,
+					sizeof(struct ssdfs_seg2req_pair),
+					GFP_KERNEL);
+	if (!pairs) {
+		SSDFS_ERR("fail to allocate requsts array\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < tree->updated_segs.count; i++) {
+		u64 seg_id = tree->updated_segs.ids[i];
+		struct ssdfs_seg2req_pair *start_pair;
+
+		start_pair = &pairs[i * fsi->pebs_per_seg];
+
+		err = __ssdfs_commit_queue_issue_requests_sync(fsi, seg_id,
+								start_pair);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to issue commit requests: "
+				  "seg_id %llu, err %d\n",
+				  seg_id, err);
+			i++;
+			break;
+		}
+	}
+
+	for (j = 0; j < i; j++) {
+		u64 seg_id = tree->updated_segs.ids[j];
+		struct ssdfs_seg2req_pair *start_pair;
+
+		start_pair = &pairs[j * fsi->pebs_per_seg];
+
+		ssdfs_commit_queue_wait_commit_logs_end(fsi, seg_id,
+							start_pair);
+	}
+
+	if (!err) {
+		bytes_count = sizeof(u64) * tree->updated_segs.capacity;
+		memset(tree->updated_segs.ids, 0, bytes_count);
+		tree->updated_segs.count = 0;
+	}
+
+	ssdfs_ext_tree_kfree(pairs);
+
+	return err;
+}
+
+/*
+ * ssdfs_extents_tree_add_updated_seg_id() - add updated segment ID in queue
+ * @tree: extents tree
+ * @seg_id: segment ID
+ *
+ * This method tries to add the updated segment ID into
+ * the commit queue.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_extents_tree_add_updated_seg_id(struct ssdfs_extents_btree_info *tree,
+					  u64 seg_id)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, seg_id %llu\n", tree, seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (tree->updated_segs.count >= SSDFS_COMMIT_QUEUE_THRESHOLD) {
+		err = ssdfs_commit_queue_issue_requests_async(tree);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to issue commit requests: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	err = ssdfs_commit_queue_add_segment_id(tree, seg_id);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add segment ID: "
+			  "seg_id %llu, err %d\n",
+			  seg_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_commit_logs_now() - commit logs now
+ * @tree: extents tree
+ *
+ * This method tries to commit logs in updated segments.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+int ssdfs_extents_tree_commit_logs_now(struct ssdfs_extents_btree_info *tree)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ssdfs_commit_queue_issue_requests_sync(tree);
+}
+
+/*
+ * ssdfs_init_inline_root_node() - initialize inline root node
+ * @fsi: pointer on shared file system object
+ * @root: pointer on inline root node [out]
+ */
+static inline
+void ssdfs_init_inline_root_node(struct ssdfs_fs_info *fsi,
+				 struct ssdfs_btree_inline_root_node *root)
+{
+	size_t index_size = sizeof(struct ssdfs_btree_index);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!root);
+
+	SSDFS_DBG("root %p\n", root);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	root->header.height = SSDFS_BTREE_LEAF_NODE_HEIGHT;
+	root->header.items_count = 0;
+	root->header.flags = 0;
+	root->header.type = 0;
+	root->header.upper_node_id = cpu_to_le32(SSDFS_BTREE_ROOT_NODE_ID);
+	memset(root->header.node_ids, 0xFF,
+		sizeof(__le32) * SSDFS_BTREE_ROOT_NODE_INDEX_COUNT);
+	memset(root->indexes, 0xFF,
+		index_size * SSDFS_BTREE_ROOT_NODE_INDEX_COUNT);
+}
+
+/*
+ * ssdfs_extents_tree_create() - create extents tree of a new inode
+ * @fsi: pointer on shared file system object
+ * @ii: pointer on in-core SSDFS inode
+ *
+ * This method tries to create extents btree for a new inode.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ */
+int ssdfs_extents_tree_create(struct ssdfs_fs_info *fsi,
+				struct ssdfs_inode_info *ii)
+{
+	struct ssdfs_extents_btree_info *ptr;
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !ii);
+	BUG_ON(!rwsem_is_locked(&ii->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("ii %p, ino %lu\n",
+		  ii, ii->vfs_inode.i_ino);
+#else
+	SSDFS_DBG("ii %p, ino %lu\n",
+		  ii, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (S_ISDIR(ii->vfs_inode.i_mode)) {
+		SSDFS_WARN("folder cannot have extents tree\n");
+		return -ERANGE;
+	} else
+		ii->extents_tree = NULL;
+
+	ptr = ssdfs_ext_tree_kzalloc(sizeof(struct ssdfs_extents_btree_info),
+				     GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate extents tree\n");
+		return -ENOMEM;
+	}
+
+	err = ssdfs_commit_queue_create(ptr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create commit queue: err %d\n",
+			  err);
+		ssdfs_ext_tree_kfree(ptr);
+		return err;
+	}
+
+	atomic_set(&ptr->state, SSDFS_EXTENTS_BTREE_UNKNOWN_STATE);
+	atomic_set(&ptr->type, SSDFS_INLINE_FORKS_ARRAY);
+	atomic64_set(&ptr->forks_count, 0);
+	init_rwsem(&ptr->lock);
+	ptr->generic_tree = NULL;
+	memset(ptr->buffer.forks, 0xFF, fork_size * SSDFS_INLINE_FORKS_COUNT);
+	ptr->inline_forks = ptr->buffer.forks;
+	memset(&ptr->root_buffer, 0xFF,
+		sizeof(struct ssdfs_btree_inline_root_node));
+	ptr->root = NULL;
+	ssdfs_memcpy(&ptr->desc,
+		     0, sizeof(struct ssdfs_extents_btree_descriptor),
+		     &fsi->segs_tree->extents_btree,
+		     0, sizeof(struct ssdfs_extents_btree_descriptor),
+		     sizeof(struct ssdfs_extents_btree_descriptor));
+	ptr->owner = ii;
+	ptr->fsi = fsi;
+	atomic_set(&ptr->state, SSDFS_EXTENTS_BTREE_CREATED);
+
+	ssdfs_debug_extents_btree_object(ptr);
+
+	ii->extents_tree = ptr;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_tree_destroy() - destroy extents tree
+ * @ii: pointer on in-core SSDFS inode
+ */
+void ssdfs_extents_tree_destroy(struct ssdfs_inode_info *ii)
+{
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
+	struct ssdfs_extents_btree_info *tree;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ii);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("ii %p, ino %lu\n",
+		  ii, ii->vfs_inode.i_ino);
+#else
+	SSDFS_DBG("ii %p, ino %lu\n",
+		  ii, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree = SSDFS_EXTREE(ii);
+
+	if (!tree) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("extents tree is absent: ino %lu\n",
+			  ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+		/* expected state*/
+		break;
+
+	case SSDFS_EXTENTS_BTREE_CORRUPTED:
+		SSDFS_WARN("extents tree is corrupted: "
+			   "ino %lu\n",
+			   ii->vfs_inode.i_ino);
+		break;
+
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		if (atomic64_read(&tree->forks_count) > 0) {
+			SSDFS_WARN("extents tree is dirty: "
+				   "ino %lu\n",
+				   ii->vfs_inode.i_ino);
+		} else {
+			/* regular destroy */
+			atomic_set(&tree->state,
+				    SSDFS_EXTENTS_BTREE_UNKNOWN_STATE);
+		}
+		break;
+
+	default:
+		SSDFS_WARN("invalid state of extents tree: "
+			   "ino %lu, state %#x\n",
+			   ii->vfs_inode.i_ino,
+			   atomic_read(&tree->state));
+		return;
+	}
+
+	if (rwsem_is_locked(&tree->lock)) {
+		/* inform about possible trouble */
+		SSDFS_WARN("tree is locked under destruction\n");
+	}
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		if (!tree->inline_forks) {
+			SSDFS_WARN("empty inline_forks pointer\n");
+			memset(tree->buffer.forks, 0xFF,
+				fork_size * SSDFS_INLINE_FORKS_COUNT);
+		} else {
+			memset(tree->inline_forks, 0xFF,
+				fork_size * SSDFS_INLINE_FORKS_COUNT);
+		}
+		tree->inline_forks = NULL;
+		break;
+
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		if (!tree->generic_tree) {
+			SSDFS_WARN("empty generic_tree pointer\n");
+			ssdfs_btree_destroy(&tree->buffer.tree);
+		} else {
+			/* destroy tree via pointer */
+			ssdfs_btree_destroy(tree->generic_tree);
+		}
+		tree->generic_tree = NULL;
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#else
+		SSDFS_WARN("invalid extents btree state %#x\n",
+			   atomic_read(&tree->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+	}
+
+	memset(&tree->root_buffer, 0xFF,
+		sizeof(struct ssdfs_btree_inline_root_node));
+	tree->root = NULL;
+
+	tree->owner = NULL;
+	tree->fsi = NULL;
+
+	ssdfs_commit_queue_destroy(tree);
+
+	atomic_set(&tree->type, SSDFS_EXTENTS_BTREE_UNKNOWN_TYPE);
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_UNKNOWN_STATE);
+
+	ssdfs_ext_tree_kfree(ii->extents_tree);
+	ii->extents_tree = NULL;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * ssdfs_extents_tree_init() - init extents tree for existing inode
+ * @fsi: pointer on shared file system object
+ * @ii: pointer on in-core SSDFS inode
+ *
+ * This method tries to create the extents tree and to initialize
+ * the root node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ * %-EIO        - corrupted raw on-disk inode.
+ */
+int ssdfs_extents_tree_init(struct ssdfs_fs_info *fsi,
+			    struct ssdfs_inode_info *ii)
+{
+	struct ssdfs_inode raw_inode;
+	struct ssdfs_btree_node *node;
+	struct ssdfs_extents_btree_info *tree;
+	struct ssdfs_btree_inline_root_node *root_node;
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
+	size_t inline_forks_size = fork_size * SSDFS_INLINE_FORKS_COUNT;
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !ii);
+	BUG_ON(!rwsem_is_locked(&ii->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("si %p, ii %p, ino %lu\n",
+		  fsi, ii, ii->vfs_inode.i_ino);
+#else
+	SSDFS_DBG("si %p, ii %p, ino %lu\n",
+		  fsi, ii, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree = SSDFS_EXTREE(ii);
+	if (!tree) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("extents tree is absent: ino %lu\n",
+			  ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	ssdfs_memcpy(&raw_inode,
+		     0, sizeof(struct ssdfs_inode),
+		     &ii->raw_inode,
+		     0, sizeof(struct ssdfs_inode),
+		     sizeof(struct ssdfs_inode));
+
+	flags = le16_to_cpu(raw_inode.private_flags);
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+		/* expected tree state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state of tree %#x\n",
+			   atomic_read(&tree->state));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		/* expected tree type */
+		break;
+
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		SSDFS_WARN("unexpected type of tree %#x\n",
+			   atomic_read(&tree->type));
+		return -ERANGE;
+
+	default:
+		SSDFS_WARN("invalid type of tree %#x\n",
+			   atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	down_write(&tree->lock);
+
+	if (flags & SSDFS_INODE_HAS_EXTENTS_BTREE) {
+		atomic64_set(&tree->forks_count,
+			     le32_to_cpu(raw_inode.count_of.forks));
+
+		if (tree->generic_tree) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_WARN("generic tree exists\n");
+			goto finish_tree_init;
+		}
+
+		tree->generic_tree = &tree->buffer.tree;
+		tree->inline_forks = NULL;
+		atomic_set(&tree->type, SSDFS_PRIVATE_EXTENTS_BTREE);
+
+		err = ssdfs_btree_create(fsi,
+					 ii->vfs_inode.i_ino,
+					 &ssdfs_extents_btree_desc_ops,
+					 &ssdfs_extents_btree_ops,
+					 tree->generic_tree);
+		if (unlikely(err)) {
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_ERR("fail to create extents tree: err %d\n",
+				  err);
+			goto finish_tree_init;
+		}
+
+		err = ssdfs_btree_radix_tree_find(tree->generic_tree,
+						  SSDFS_BTREE_ROOT_NODE_ID,
+						  &node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get the root node: err %d\n",
+				  err);
+			goto fail_create_generic_tree;
+		} else if (unlikely(!node)) {
+			err = -ERANGE;
+			SSDFS_WARN("empty node pointer\n");
+			goto fail_create_generic_tree;
+		}
+
+		root_node = &raw_inode.internal[0].area1.extents_root;
+		err = ssdfs_btree_create_root_node(node, root_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init the root node: err %d\n",
+				  err);
+			goto fail_create_generic_tree;
+		}
+
+		tree->root = &tree->root_buffer;
+
+		ssdfs_memcpy(tree->root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     root_node,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     sizeof(struct ssdfs_btree_inline_root_node));
+
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_INITIALIZED);
+
+fail_create_generic_tree:
+		if (unlikely(err)) {
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			ssdfs_btree_destroy(tree->generic_tree);
+			tree->generic_tree = NULL;
+			goto finish_tree_init;
+		}
+	} else if (flags & SSDFS_INODE_HAS_XATTR_BTREE) {
+		atomic64_set(&tree->forks_count,
+			     le32_to_cpu(raw_inode.count_of.forks));
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(atomic64_read(&tree->forks_count) > 1);
+#else
+		if (atomic64_read(&tree->forks_count) > 1) {
+			err = -EIO;
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_ERR("corrupted on-disk raw inode: "
+				  "forks_count %llu\n",
+				  (u64)atomic64_read(&tree->forks_count));
+			goto finish_tree_init;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (!tree->inline_forks) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_WARN("undefined inline forks pointer\n");
+			goto finish_tree_init;
+		} else {
+			ssdfs_memcpy(tree->inline_forks, 0, inline_forks_size,
+				     &raw_inode.internal, 0, inline_forks_size,
+				     inline_forks_size);
+		}
+
+		atomic_set(&tree->type, SSDFS_INLINE_FORKS_ARRAY);
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_INITIALIZED);
+	} else if (flags & SSDFS_INODE_HAS_INLINE_EXTENTS) {
+		atomic64_set(&tree->forks_count,
+			     le32_to_cpu(raw_inode.count_of.forks));
+
+		if (!tree->inline_forks) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_WARN("undefined inline forks pointer\n");
+			goto finish_tree_init;
+		} else {
+			ssdfs_memcpy(tree->inline_forks, 0, inline_forks_size,
+				     &raw_inode.internal, 0, inline_forks_size,
+				     inline_forks_size);
+		}
+
+		atomic_set(&tree->type, SSDFS_INLINE_FORKS_ARRAY);
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_INITIALIZED);
+	} else
+		BUG();
+
+finish_tree_init:
+	up_write(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_extents_btree_object(tree);
+
+	return err;
+}
+
+/*
+ * ssdfs_migrate_inline2generic_tree() - convert inline tree into generic
+ * @tree: extents tree
+ *
+ * This method tries to convert the inline tree into generic one.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - the tree is empty.
+ */
+static
+int ssdfs_migrate_inline2generic_tree(struct ssdfs_extents_btree_info *tree)
+{
+	struct ssdfs_raw_fork inline_forks[SSDFS_INLINE_FORKS_COUNT];
+	struct ssdfs_btree_search *search;
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
+	s64 forks_count, forks_capacity;
+	int private_flags;
+	u64 start_hash = 0, end_hash = 0;
+	u64 blks_count = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	forks_count = atomic64_read(&tree->forks_count);
+
+	if (!tree->owner) {
+		SSDFS_ERR("empty owner inode\n");
+		return -ERANGE;
+	}
+
+	private_flags = atomic_read(&tree->owner->private_flags);
+
+	forks_capacity = SSDFS_INLINE_FORKS_COUNT;
+	if (private_flags & SSDFS_INODE_HAS_XATTR_BTREE)
+		forks_capacity--;
+	if (private_flags & SSDFS_INODE_HAS_EXTENTS_BTREE) {
+		SSDFS_ERR("the extents tree is generic\n");
+		return -ERANGE;
+	}
+
+	if (forks_count > forks_capacity) {
+		SSDFS_WARN("extents tree is corrupted: "
+			   "forks_count %lld, forks_capacity %lld\n",
+			   forks_count, forks_capacity);
+		atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_CORRUPTED);
+		return -ERANGE;
+	} else if (forks_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		return -EFAULT;
+	} else if (forks_count < forks_capacity) {
+		SSDFS_WARN("forks_count %lld, forks_capacity %lld\n",
+			   forks_count, forks_capacity);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree->inline_forks || tree->generic_tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(inline_forks, 0xFF, fork_size * SSDFS_INLINE_FORKS_COUNT);
+	ssdfs_memcpy(inline_forks, 0, fork_size * forks_capacity,
+		     tree->inline_forks, 0, fork_size * forks_capacity,
+		     fork_size * forks_capacity);
+	tree->inline_forks = NULL;
+
+	tree->generic_tree = &tree->buffer.tree;
+	tree->inline_forks = NULL;
+
+	atomic64_set(&tree->forks_count, 0);
+
+	err = ssdfs_btree_create(tree->fsi,
+				 tree->owner->vfs_inode.i_ino,
+				 &ssdfs_extents_btree_desc_ops,
+				 &ssdfs_extents_btree_ops,
+				 &tree->buffer.tree);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create generic tree: err %d\n",
+			  err);
+		goto recover_inline_tree;
+	}
+
+	start_hash = le64_to_cpu(inline_forks[0].start_offset);
+	if (forks_count > 1) {
+		end_hash =
+		    le64_to_cpu(inline_forks[forks_count - 1].start_offset);
+		blks_count =
+		    le64_to_cpu(inline_forks[forks_count - 1].blks_count);
+	} else {
+		end_hash = start_hash;
+		blks_count = le64_to_cpu(inline_forks[0].blks_count);
+	}
+
+	if (blks_count == 0 || blks_count >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid blks_count %llu\n",
+			  blks_count);
+		goto destroy_generic_tree;
+	}
+
+	end_hash += blks_count - 1;
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate btree search object\n");
+		goto destroy_generic_tree;
+	}
+
+	ssdfs_btree_search_init(search);
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+	search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+	search->request.start.hash = start_hash;
+	search->request.end.hash = end_hash;
+	search->request.count = forks_count;
+
+	err = ssdfs_btree_find_item(&tree->buffer.tree, search);
+	if (err == -ENODATA) {
+		/* expected error */
+		err = 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find item: "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  start_hash, end_hash, err);
+		goto finish_add_range;
+	}
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+	case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		goto finish_add_range;
+	}
+
+	if (search->result.buf) {
+		err = -ERANGE;
+		SSDFS_ERR("search->result.buf %p\n",
+			  search->result.buf);
+		goto finish_add_range;
+	}
+
+	if (forks_count == 1) {
+		search->result.buf_state = SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+		search->result.buf_size = sizeof(struct ssdfs_raw_fork);
+		search->result.items_in_buffer = forks_count;
+		search->result.buf = &search->raw.fork;
+		ssdfs_memcpy(&search->raw.fork, 0, search->result.buf_size,
+			     inline_forks, 0, search->result.buf_size,
+			     search->result.buf_size);
+	} else {
+		err = ssdfs_btree_search_alloc_result_buf(search,
+				forks_count * sizeof(struct ssdfs_raw_fork));
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to allocate memory for buffer\n");
+			goto finish_add_range;
+		}
+		ssdfs_memcpy(search->result.buf, 0, search->result.buf_size,
+			     inline_forks, 0, search->result.buf_size,
+			     search->result.buf_size);
+		search->result.items_in_buffer = (u16)forks_count;
+	}
+
+	search->request.type = SSDFS_BTREE_SEARCH_ADD_RANGE;
+
+	err = ssdfs_btree_add_range(&tree->buffer.tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add the range into tree: "
+			   "start_hash %llx, end_hash %llx, err %d\n",
+			   start_hash, end_hash, err);
+		goto finish_add_range;
+	}
+
+finish_add_range:
+	ssdfs_btree_search_free(search);
+
+	if (unlikely(err))
+		goto destroy_generic_tree;
+
+	err = ssdfs_btree_synchronize_root_node(tree->generic_tree,
+						tree->root);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to synchronize the root node: "
+			  "err %d\n", err);
+		goto destroy_generic_tree;
+	}
+
+	atomic_set(&tree->type, SSDFS_PRIVATE_EXTENTS_BTREE);
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_DIRTY);
+
+	atomic_or(SSDFS_INODE_HAS_EXTENTS_BTREE,
+		  &tree->owner->private_flags);
+	atomic_and(~SSDFS_INODE_HAS_INLINE_EXTENTS,
+		  &tree->owner->private_flags);
+	return 0;
+
+destroy_generic_tree:
+	ssdfs_btree_destroy(&tree->buffer.tree);
+
+recover_inline_tree:
+	ssdfs_memcpy(tree->buffer.forks,
+		     0, fork_size * SSDFS_INLINE_FORKS_COUNT,
+		     inline_forks,
+		     0, fork_size * SSDFS_INLINE_FORKS_COUNT,
+		     fork_size * SSDFS_INLINE_FORKS_COUNT);
+	tree->inline_forks = tree->buffer.forks;
+	tree->generic_tree = NULL;
+	atomic64_set(&tree->forks_count, forks_count);
+	return err;
+}
+
+/*
+ * ssdfs_extents_tree_flush() - save modified extents tree
+ * @fsi: pointer on shared file system object
+ * @ii: pointer on in-core SSDFS inode
+ *
+ * This method tries to flush inode's extents btree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_extents_tree_flush(struct ssdfs_fs_info *fsi,
+			     struct ssdfs_inode_info *ii)
+{
+	struct ssdfs_extents_btree_info *tree;
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
+	size_t inline_forks_size = fork_size * SSDFS_INLINE_FORKS_COUNT;
+	int flags;
+	u64 forks_count = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !ii);
+	BUG_ON(!rwsem_is_locked(&ii->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, ii %p, ino %lu\n",
+		  fsi, ii, ii->vfs_inode.i_ino);
+#else
+	SSDFS_DBG("fsi %p, ii %p, ino %lu\n",
+		  fsi, ii, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree = SSDFS_EXTREE(ii);
+	if (!tree) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("extents tree is absent: ino %lu\n",
+			  ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ERANGE;
+	}
+
+	ssdfs_debug_extents_btree_object(tree);
+
+	flags = atomic_read(&ii->private_flags);
+
+	down_write(&tree->lock);
+
+	err = ssdfs_extents_tree_commit_logs_now(tree);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to commit logs: "
+			  "ino %lu, err %d\n",
+			  ii->vfs_inode.i_ino, err);
+		goto finish_extents_tree_flush;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* need to flush */
+		break;
+
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+		/* do nothing */
+		goto finish_extents_tree_flush;
+
+	case SSDFS_EXTENTS_BTREE_CORRUPTED:
+		err = -EOPNOTSUPP;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("extents btree corrupted: ino %lu\n",
+			  ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_extents_tree_flush;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("unexpected state of tree %#x\n",
+			   atomic_read(&tree->state));
+		goto finish_extents_tree_flush;
+	}
+
+	forks_count = atomic64_read(&tree->forks_count);
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		if (!tree->inline_forks) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_WARN("undefined inline forks pointer\n");
+			goto finish_extents_tree_flush;
+		}
+
+		if (forks_count == 0) {
+			flags = atomic_read(&ii->private_flags);
+
+			if (flags & SSDFS_INODE_HAS_XATTR_BTREE) {
+				memset(&ii->raw_inode.internal, 0xFF,
+					fork_size);
+			} else {
+				memset(&ii->raw_inode.internal, 0xFF,
+					inline_forks_size);
+			}
+		} else if (forks_count == 1) {
+			flags = atomic_read(&ii->private_flags);
+
+			if (flags & SSDFS_INODE_HAS_XATTR_BTREE) {
+				ssdfs_memcpy(&ii->raw_inode.internal,
+					     0, fork_size,
+					     tree->inline_forks,
+					     0, fork_size,
+					     fork_size);
+			} else {
+				ssdfs_memcpy(&ii->raw_inode.internal,
+					     0, inline_forks_size,
+					     tree->inline_forks,
+					     0, inline_forks_size,
+					     inline_forks_size);
+			}
+		} else if (forks_count == SSDFS_INLINE_FORKS_COUNT) {
+			flags = atomic_read(&ii->private_flags);
+
+			if (flags & SSDFS_INODE_HAS_XATTR_BTREE) {
+				err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("tree should be converted: "
+					  "ino %lu\n",
+					  ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else {
+				ssdfs_memcpy(&ii->raw_inode.internal,
+					     0, inline_forks_size,
+					     tree->inline_forks,
+					     0, inline_forks_size,
+					     inline_forks_size);
+			}
+
+			if (err == -EAGAIN) {
+				err = ssdfs_migrate_inline2generic_tree(tree);
+				if (unlikely(err)) {
+					atomic_set(&tree->state,
+						SSDFS_EXTENTS_BTREE_CORRUPTED);
+					SSDFS_ERR("fail to convert tree: "
+						  "err %d\n", err);
+					goto finish_extents_tree_flush;
+				} else
+					goto try_generic_tree_flush;
+			}
+		} else {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_WARN("invalid forks_count %llu\n",
+				   (u64)atomic64_read(&tree->forks_count));
+			goto finish_extents_tree_flush;
+		}
+
+		atomic_or(SSDFS_INODE_HAS_INLINE_EXTENTS,
+			  &ii->private_flags);
+		break;
+
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+try_generic_tree_flush:
+		if (!tree->generic_tree) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_WARN("undefined generic tree pointer\n");
+			goto finish_extents_tree_flush;
+		}
+
+		err = ssdfs_btree_flush(tree->generic_tree);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to flush extents btree: "
+				  "ino %lu, err %d\n",
+				  ii->vfs_inode.i_ino, err);
+			goto finish_generic_tree_flush;
+		}
+
+		if (!tree->root) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_EXTENTS_BTREE_CORRUPTED);
+			SSDFS_WARN("undefined root node pointer\n");
+			goto finish_generic_tree_flush;
+		}
+
+		ssdfs_memcpy(&ii->raw_inode.internal[0].area1.extents_root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     tree->root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     sizeof(struct ssdfs_btree_inline_root_node));
+
+		atomic_or(SSDFS_INODE_HAS_EXTENTS_BTREE,
+			  &ii->private_flags);
+
+finish_generic_tree_flush:
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid type of tree %#x\n",
+			   atomic_read(&tree->type));
+		goto finish_extents_tree_flush;
+	}
+
+	ii->raw_inode.count_of.forks = cpu_to_le32((u32)forks_count);
+	atomic_set(&tree->state, SSDFS_EXTENTS_BTREE_INITIALIZED);
+
+finish_extents_tree_flush:
+	up_write(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("RAW INODE DUMP\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     &ii->raw_inode,
+			     sizeof(struct ssdfs_inode));
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_prepare_volume_extent() - convert requested byte stream into extent
+ * @fsi: pointer on shared file system object
+ * @req: request object
+ *
+ * This method tries to convert logical byte stream into extent of blocks.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE      - internal error.
+ * %-ENOMEM      - fail to allocate memory.
+ * %-ENODATA     - unable to convert byte stream into extent.
+ */
+int ssdfs_prepare_volume_extent(struct ssdfs_fs_info *fsi,
+				struct ssdfs_segment_request *req)
+{
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *tree;
+	struct ssdfs_btree_search *search;
+	struct ssdfs_raw_fork *fork = NULL;
+	struct ssdfs_raw_extent *extent = NULL;
+	u32 pagesize = fsi->pagesize;
+	u64 seg_id;
+	u32 logical_blk = U32_MAX, len;
+	u64 start_blk;
+	u64 blks_count;
+	u64 requested_blk, requested_len;
+	u64 processed_blks = 0;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+	BUG_ON((req->extent.logical_offset >> fsi->log_pagesize) >= U32_MAX);
+
+	SSDFS_DBG("fsi %p, req %p, ino %llu, "
+		  "logical_offset %llu, data_bytes %u, "
+		  "cno %llu, parent_snapshot %llu\n",
+		  fsi, req, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes,
+		  req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ii = SSDFS_I(req->result.pvec.pages[0]->mapping->host);
+
+	tree = SSDFS_EXTREE(ii);
+	if (!tree) {
+		down_write(&ii->lock);
+		err = ssdfs_extents_tree_create(fsi, ii);
+		up_write(&ii->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create extents tree: "
+				  "err %d\n", err);
+			return err;
+		} else
+			tree = SSDFS_EXTREE(ii);
+	}
+
+	requested_blk = req->extent.logical_offset >> fsi->log_pagesize;
+	requested_len = (req->extent.data_bytes + pagesize - 1) >>
+				fsi->log_pagesize;
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+	ssdfs_btree_search_init(search);
+
+	err = ssdfs_extents_tree_find_fork(tree, requested_blk, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find the fork: "
+			  "blk %llu, err %d\n",
+			  requested_blk, err);
+		goto finish_prepare_volume_extent;
+	}
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid result state %#x\n",
+			  search->result.state);
+		goto finish_prepare_volume_extent;
+	}
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+	case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid buffer state %#x\n",
+			  search->result.buf_state);
+		goto finish_prepare_volume_extent;
+	}
+
+	if (!search->result.buf) {
+		err = -ERANGE;
+		SSDFS_ERR("empty result buffer pointer\n");
+		goto finish_prepare_volume_extent;
+	}
+
+	if (search->result.items_in_buffer == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("items_in_buffer %u\n",
+			  search->result.items_in_buffer);
+		goto finish_prepare_volume_extent;
+	}
+
+	fork = (struct ssdfs_raw_fork *)search->result.buf;
+	start_blk = le64_to_cpu(fork->start_offset);
+	blks_count = le64_to_cpu(fork->blks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_blk %llu, blks_count %llu\n",
+		  start_blk, blks_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_INLINE_EXTENTS_COUNT; extent = NULL, i++) {
+		if (processed_blks >= blks_count)
+			break;
+
+		extent = &fork->extents[i];
+
+		seg_id = le64_to_cpu(extent->seg_id);
+		logical_blk = le32_to_cpu(extent->logical_blk);
+		len = le32_to_cpu(extent->len);
+
+		if (seg_id == U64_MAX || logical_blk == U32_MAX ||
+		    len == U32_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("corrupted extent: index %d\n", i);
+			goto finish_prepare_volume_extent;
+		}
+
+		if (len == 0) {
+			err = -ERANGE;
+			SSDFS_ERR("corrupted extent: index %d\n", i);
+			goto finish_prepare_volume_extent;
+		}
+
+		if ((start_blk + processed_blks) <= requested_blk &&
+		    requested_blk < (start_blk + processed_blks + len)) {
+			u64 diff = requested_blk - (start_blk + processed_blks);
+
+			logical_blk += (u32)diff;
+			len -= (u32)diff;
+			len = min_t(u32, len, requested_len);
+			break;
+		}
+
+		processed_blks += len;
+	}
+
+	if (!extent) {
+		err = -ENODATA;
+		SSDFS_DBG("extent hasn't been found\n");
+		goto finish_prepare_volume_extent;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(logical_blk >= U16_MAX);
+	BUG_ON(len >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_define_segment(seg_id, req);
+	ssdfs_request_define_volume_extent((u16)logical_blk, (u16)len, req);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, len %u\n",
+		  logical_blk, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_prepare_volume_extent:
+	ssdfs_btree_search_free(search);
+	return err;
+}
+
+/*
+ * ssdfs_recommend_migration_extent() - recommend migration extent
+ * @fsi: pointer on shared file system object
+ * @req: request object
+ * @fragment: recommended fragment [out]
+ *
+ * This method tries to find an extent recommended to migration.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE      - internal error.
+ * %-ENOMEM      - fail to allocate memory.
+ * %-ENODATA     - unable to find a relevant extent.
+ */
+int ssdfs_recommend_migration_extent(struct ssdfs_fs_info *fsi,
+				     struct ssdfs_segment_request *req,
+				     struct ssdfs_zone_fragment *fragment)
+{
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *tree;
+	struct ssdfs_btree_search *search;
+	struct ssdfs_raw_fork *fork = NULL;
+	struct ssdfs_raw_extent *found = NULL;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+	u64 start_blk;
+	u64 blks_count;
+	u64 seg_id;
+	u32 logical_blk = U32_MAX, len;
+	u64 requested_blk, requested_len;
+	u64 processed_blks = 0;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req || !fragment);
+	BUG_ON((req->extent.logical_offset >> fsi->log_pagesize) >= U32_MAX);
+
+	SSDFS_DBG("fsi %p, req %p, ino %llu, "
+		  "logical_offset %llu, data_bytes %u, "
+		  "cno %llu, parent_snapshot %llu\n",
+		  fsi, req, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes,
+		  req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(fragment, 0xFF, sizeof(struct ssdfs_zone_fragment));
+
+	ii = SSDFS_I(req->result.pvec.pages[0]->mapping->host);
+
+	tree = SSDFS_EXTREE(ii);
+	if (!tree) {
+		down_write(&ii->lock);
+		err = ssdfs_extents_tree_create(fsi, ii);
+		up_write(&ii->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create extents tree: "
+				  "err %d\n", err);
+			return err;
+		} else
+			tree = SSDFS_EXTREE(ii);
+	}
+
+	requested_blk = req->extent.logical_offset >> fsi->log_pagesize;
+
+	requested_blk = req->extent.logical_offset >> fsi->log_pagesize;
+	requested_len = (req->extent.data_bytes + fsi->pagesize - 1) >>
+				fsi->log_pagesize;
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+	ssdfs_btree_search_init(search);
+
+	err = ssdfs_extents_tree_find_fork(tree, requested_blk, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find the fork: "
+			  "blk %llu, err %d\n",
+			  requested_blk, err);
+		goto finish_recommend_migration_extent;
+	}
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid result state %#x\n",
+			  search->result.state);
+		goto finish_recommend_migration_extent;
+	}
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+	case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid buffer state %#x\n",
+			  search->result.buf_state);
+		goto finish_recommend_migration_extent;
+	}
+
+	if (!search->result.buf) {
+		err = -ERANGE;
+		SSDFS_ERR("empty result buffer pointer\n");
+		goto finish_recommend_migration_extent;
+	}
+
+	if (search->result.items_in_buffer == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("items_in_buffer %u\n",
+			  search->result.items_in_buffer);
+		goto finish_recommend_migration_extent;
+	}
+
+	fork = (struct ssdfs_raw_fork *)search->result.buf;
+	start_blk = le64_to_cpu(fork->start_offset);
+	blks_count = le64_to_cpu(fork->blks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_blk %llu, blks_count %llu\n",
+		  start_blk, blks_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_INLINE_EXTENTS_COUNT; found = NULL, i++) {
+		if (processed_blks >= blks_count)
+			break;
+
+		found = &fork->extents[i];
+
+		seg_id = le64_to_cpu(found->seg_id);
+		logical_blk = le32_to_cpu(found->logical_blk);
+		len = le32_to_cpu(found->len);
+
+		if (seg_id == U64_MAX || logical_blk == U32_MAX ||
+		    len == U32_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("corrupted extent: index %d\n", i);
+			goto finish_recommend_migration_extent;
+		}
+
+		if (len == 0) {
+			err = -ERANGE;
+			SSDFS_ERR("corrupted extent: index %d\n", i);
+			goto finish_recommend_migration_extent;
+		}
+
+		if (req->place.start.seg_id == seg_id) {
+			if (logical_blk <= req->place.start.blk_index &&
+			    req->place.start.blk_index < (logical_blk + len)) {
+				/* extent has been found */
+				break;
+			}
+		}
+
+		processed_blks += len;
+		found = NULL;
+	}
+
+	if (!found) {
+		err = -ENODATA;
+		SSDFS_DBG("extent hasn't been found\n");
+		goto finish_recommend_migration_extent;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(logical_blk >= U16_MAX);
+	BUG_ON(len >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (logical_blk == req->place.start.blk_index &&
+	    req->place.len == len) {
+		err = -ENODATA;
+		SSDFS_DBG("extent hasn't been found\n");
+		goto finish_recommend_migration_extent;
+	} else {
+		fragment->ino = ii->vfs_inode.i_ino;
+		fragment->logical_blk_offset = start_blk + processed_blks;
+		ssdfs_memcpy(&fragment->extent, 0, item_size,
+			     found, 0, item_size,
+			     item_size);
+	}
+
+finish_recommend_migration_extent:
+	ssdfs_btree_search_free(search);
+	return err;
+}
+
+/*
+ * ssdfs_extents_tree_has_logical_block() - check that block exists
+ * @blk_offset: offset of logical block into file
+ * @inode: pointer on VFS inode
+ */
+bool ssdfs_extents_tree_has_logical_block(u64 blk_offset, struct inode *inode)
+{
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *tree;
+	struct ssdfs_btree_search *search;
+	ino_t ino;
+	bool is_found = false;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!inode);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ii = SSDFS_I(inode);
+	ino = inode->i_ino;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, blk_offset %llu\n",
+		  ino, blk_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree = SSDFS_EXTREE(ii);
+	if (!tree) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("extents tree is absent: ino %lu\n",
+			  ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+	}
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return false;
+	}
+
+	ssdfs_btree_search_init(search);
+
+	err = ssdfs_extents_tree_find_fork(tree, blk_offset, search);
+	if (err == -ENODATA)
+		is_found = false;
+	else if (unlikely(err)) {
+		is_found = false;
+		SSDFS_ERR("fail to find the fork: "
+			  "blk %llu, err %d\n",
+			  blk_offset, err);
+	} else
+		is_found = true;
+
+	ssdfs_btree_search_free(search);
+
+	return is_found;
+}
+
+/*
+ * ssdfs_extents_tree_add_extent() - add extent into extents tree
+ * @inode: pointer on VFS inode
+ * @req: pointer on segment request [in]
+ *
+ * This method tries to add an extent into extents tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - extents tree is unable to add requested block(s).
+ * %-EEXIST     - extent exists in the tree.
+ */
+int ssdfs_extents_tree_add_extent(struct inode *inode,
+				  struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *tree;
+	struct ssdfs_btree_search *search;
+	struct ssdfs_raw_extent extent;
+	ino_t ino;
+	u64 requested_blk;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!inode || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = SSDFS_FS_I(inode->i_sb);
+	ii = SSDFS_I(inode);
+	ino = inode->i_ino;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("ino %lu, logical_offset %llu, "
+		  "seg_id %llu, start_blk %u, len %u\n",
+		  ino, req->extent.logical_offset,
+		  req->place.start.seg_id,
+		  req->place.start.blk_index, req->place.len);
+#else
+	SSDFS_DBG("ino %lu, logical_offset %llu, "
+		  "seg_id %llu, start_blk %u, len %u\n",
+		  ino, req->extent.logical_offset,
+		  req->place.start.seg_id,
+		  req->place.start.blk_index, req->place.len);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree = SSDFS_EXTREE(ii);
+	if (!tree) {
+		down_write(&ii->lock);
+		err = ssdfs_extents_tree_create(fsi, ii);
+		up_write(&ii->lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create extents tree: "
+				  "err %d\n", err);
+			return err;
+		} else
+			tree = SSDFS_EXTREE(ii);
+	}
+
+	requested_blk = req->extent.logical_offset >> fsi->log_pagesize;
+	extent.seg_id = cpu_to_le64(req->place.start.seg_id);
+	extent.logical_blk = cpu_to_le32(req->place.start.blk_index);
+	extent.len = cpu_to_le32(req->place.len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("requested_blk %llu, "
+		  "extent (seg_id %llu, logical_blk %u, len %u)\n",
+		  requested_blk, extent.seg_id,
+		  extent.logical_blk, extent.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ERANGE;
+	}
+
+	ssdfs_btree_search_init(search);
+	err = __ssdfs_extents_tree_add_extent(tree, requested_blk,
+					       &extent, search);
+	ssdfs_btree_search_free(search);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add block into the tree: "
+			  "blk %llu, err %d\n",
+			  requested_blk, err);
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_extents_tree_truncate() - truncate extents tree
+ * @inode: pointer on VFS inode
+ *
+ * This method tries to truncate extents tree.
+ *
+ *       The key trick with truncate operation that it is possible
+ *       to store inline forks in the inode and to place the whole
+ *       heirarchy into the shared extents tree. This is the case
+ *       of deletion the whole file or practically the whole
+ *       file. The shared tree's thread will be responsible for
+ *       the real invalidation in the background. If we truncate
+ *       the file partially then we could simply correct the whole
+ *       length of the file and to delegate the responsibility
+ *       to truncate all invalidated extents of the tree to the
+ *       thread of shared extents tree.
+ *
+ *       Usually, if we need to truncate some file then we need to find
+ *       the position of the extent that will be truncated. Finally,
+ *       we will know the whole hierarchy path from the root node
+ *       till the leaf one. So, all forks/extents after truncated one
+ *       should be added into the pre-invalidated list and to be
+ *       deleted or to be obsolete into the leaf node. Also all index
+ *       records should be deleted from all parent nodes and needs
+ *       to be placed into pre-invalidated list of the shared extents tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_extents_tree_truncate(struct inode *inode)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *tree;
+	struct ssdfs_btree_search *search;
+	ino_t ino;
+	loff_t size;
+	u64 blk_offset;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!inode);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = SSDFS_FS_I(inode->i_sb);
+	ii = SSDFS_I(inode);
+	ino = inode->i_ino;
+	size = i_size_read(inode);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("ino %lu, size %llu\n",
+		  ino, size);
+#else
+	SSDFS_DBG("ino %lu, size %llu\n",
+		  ino, size);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree = SSDFS_EXTREE(ii);
+	if (!tree) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("extents tree is absent: ino %lu\n",
+			  ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+	blk_offset = (u64)size + fsi->log_pagesize - 1;
+	blk_offset >>= fsi->log_pagesize;
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ERANGE;
+	}
+
+	ssdfs_btree_search_init(search);
+	err = ssdfs_extents_tree_truncate_extent(tree, blk_offset, 0, search);
+	ssdfs_btree_search_free(search);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to truncate the tree: "
+			  "blk %llu, err %d\n",
+			  blk_offset, err);
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/******************************************************************************
+ *                     EXTENTS TREE OBJECT FUNCTIONALITY                      *
+ ******************************************************************************/
+
+/*
+ * need_initialize_extent_btree_search() - check necessity to init the search
+ * @blk: logical block number
+ * @search: search object
+ */
+static inline
+bool need_initialize_extent_btree_search(u64 blk,
+					 struct ssdfs_btree_search *search)
+{
+	return need_initialize_btree_search(search) ||
+		search->request.start.hash != blk;
+}
+
+/*
+ * ssdfs_extents_tree_find_inline_fork() - find an inline fork in the tree
+ * @tree: extents tree
+ * @blk: logical block number
+ * @search: search object
+ *
+ * This method tries to find a fork for the requested @blk.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - fork is empty (no extents).
+ * %-ENODATA    - item hasn't been found.
+ */
+static
+int ssdfs_extents_tree_find_inline_fork(struct ssdfs_extents_btree_info *tree,
+					u64 blk,
+					struct ssdfs_btree_search *search)
+{
+	size_t fork_size = sizeof(struct ssdfs_raw_fork);
+	u64 forks_count;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, blk %llu, search %p\n",
+		  tree, blk, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_read(&tree->type) != SSDFS_INLINE_FORKS_ARRAY) {
+		SSDFS_ERR("invalid tree type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	ssdfs_btree_search_free_result_buf(search);
+
+	forks_count = (u64)atomic64_read(&tree->forks_count);
+
+	if (forks_count < 0) {
+		SSDFS_ERR("invalid forks_count %llu\n",
+			  forks_count);
+		return -ERANGE;
+	} else if (forks_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		search->result.state = SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		search->result.err = -ENOENT;
+		search->result.start_index = 0;
+		search->result.count = 0;
+		search->result.search_cno = ssdfs_current_cno(tree->fsi->sb);
+		search->result.buf_state =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+		search->result.buf = NULL;
+		search->result.buf_size = 0;
+		search->result.items_in_buffer = 0;
+
+		ssdfs_debug_btree_search_object(search);
+
+		return -ENOENT;
+	} else if (forks_count > SSDFS_INLINE_FORKS_COUNT) {
+		SSDFS_ERR("invalid forks_count %llu\n",
+			  forks_count);
+		return -ERANGE;
+	}
+
+	if (!tree->inline_forks) {
+		SSDFS_ERR("inline forks haven't been initialized\n");
+		return -ERANGE;
+	}
+
+	search->result.start_index = 0;
+
+	for (i = 0; i < forks_count; i++) {
+		struct ssdfs_raw_fork *fork;
+		u64 start;
+		u64 blks_count;
+
+		search->result.state = SSDFS_BTREE_SEARCH_UNKNOWN_RESULT;
+
+		fork = &tree->inline_forks[i];
+		start = le64_to_cpu(fork->start_offset);
+		blks_count = le64_to_cpu(fork->blks_count);
+
+		if (start >= U64_MAX || blks_count >= U64_MAX) {
+			SSDFS_ERR("invalid fork state: "
+				  "start_offset %llu, blks_count %llu\n",
+				  start, blks_count);
+			return -ERANGE;
+		}
+
+		ssdfs_memcpy(&search->raw.fork, 0, fork_size,
+			     fork, 0, fork_size,
+			     fork_size);
+
+		search->result.err = 0;
+		search->result.start_index = (u16)i;
+		search->result.count = 1;
+		search->request.count = 1;
+		search->result.search_cno = ssdfs_current_cno(tree->fsi->sb);
+
+		switch (search->result.buf_state) {
+		case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+			search->result.buf = &search->raw.fork;
+			search->result.buf_size = sizeof(struct ssdfs_raw_fork);
+			search->result.items_in_buffer = 1;
+			break;
+
+		case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+			ssdfs_btree_search_free_result_buf(search);
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+			search->result.buf = &search->raw.fork;
+			search->result.buf_size = sizeof(struct ssdfs_raw_fork);
+			search->result.items_in_buffer = 1;
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+			search->result.buf = &search->raw.fork;
+			search->result.buf_size = sizeof(struct ssdfs_raw_fork);
+			search->result.items_in_buffer = 1;
+			break;
+		}
+
+		if (blk < start) {
+			err = -ENODATA;
+			search->result.err = -ENODATA;
+			search->result.state =
+				SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+			goto finish_search_inline_fork;
+		} else if (start <= blk && blk < (start + blks_count)) {
+			search->result.state = SSDFS_BTREE_SEARCH_VALID_ITEM;
+			goto finish_search_inline_fork;
+		}
+	}
+
+	err = -ENODATA;
+	search->result.err = -ENODATA;
+	search->result.state = SSDFS_BTREE_SEARCH_OUT_OF_RANGE;
+
+	ssdfs_debug_btree_search_object(search);
+
+finish_search_inline_fork:
+	return err;
+}
+
+/*
+ * ssdfs_extents_tree_find_fork() - find a fork in the tree
+ * @tree: extents tree
+ * @blk: logical block number
+ * @search: search object
+ *
+ * This method tries to find a fork for the requested @blk.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - item hasn't been found
+ */
+int ssdfs_extents_tree_find_fork(struct ssdfs_extents_btree_info *tree,
+				 u64 blk,
+				 struct ssdfs_btree_search *search)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, blk %llu, search %p\n",
+		  tree, blk, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	if (need_initialize_extent_btree_search(blk, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = blk;
+		search->request.end.hash = blk;
+		search->request.count = 1;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_EXTENTS_BTREE_CREATED:
+	case SSDFS_EXTENTS_BTREE_INITIALIZED:
+	case SSDFS_EXTENTS_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid extent tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_FORKS_ARRAY:
+		down_read(&tree->lock);
+		err = ssdfs_extents_tree_find_inline_fork(tree, blk, search);
+		up_read(&tree->lock);
+
+		if (err == -ENODATA || err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find the inline fork: "
+				  "blk %llu\n",
+				  blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the inline fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+		}
+		break;
+
+	case SSDFS_PRIVATE_EXTENTS_BTREE:
+		down_read(&tree->lock);
+		err = ssdfs_btree_find_item(tree->generic_tree, search);
+		up_read(&tree->lock);
+
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find the fork: "
+				  "blk %llu\n",
+				  blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the fork: "
+				  "blk %llu, err %d\n",
+				  blk, err);
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid extents tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_add_head_extent_into_fork() - add head extent into the fork
+ * @blk: logical block number
+ * @extent: raw extent
+ * @fork: raw fork
+ *
+ * This method tries to add @extent into the head of fork.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - need to add a new fork in the tree.
+ */
+static
+int ssdfs_add_head_extent_into_fork(u64 blk,
+				    struct ssdfs_raw_extent *extent,
+				    struct ssdfs_raw_fork *fork)
+{
+	struct ssdfs_raw_extent *cur = NULL;
+	size_t desc_size = sizeof(struct ssdfs_raw_extent);
+	u64 seg1, seg2;
+	u32 lblk1, lblk2;
+	u32 len1, len2;
+	u64 blks_count, counted_blks;
+	int valid_extents;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!extent || !fork);
+
+	SSDFS_DBG("blk %llu, extent %p, fork %p\n",
+		  blk, extent, fork);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (blk >= U64_MAX) {
+		SSDFS_ERR("invalid blk %llu\n", blk);
+		return -EINVAL;
+	}
+
+	blks_count = le64_to_cpu(fork->blks_count);
+
+	seg2 = le64_to_cpu(extent->seg_id);
+	lblk2 = le32_to_cpu(extent->logical_blk);
+	len2 = le32_to_cpu(extent->len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg2 >= U64_MAX);
+	BUG_ON(lblk2 >= U32_MAX);
+	BUG_ON(len2 >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (blks_count == 0 || blks_count >= U64_MAX) {
+		fork->start_offset = cpu_to_le64(blk);
+		fork->blks_count = cpu_to_le64(len2);
+		cur = &fork->extents[0];
+		ssdfs_memcpy(cur, 0, sizeof(struct ssdfs_raw_extent),
+			     extent, 0, sizeof(struct ssdfs_raw_extent),
+			     sizeof(struct ssdfs_raw_extent));
+		return 0;
+	} else if (le64_to_cpu(fork->start_offset) >= U64_MAX) {
+		SSDFS_ERR("corrupted fork: "
+			  "start_offset %llu, blks_count %llu\n",
+			  le64_to_cpu(fork->start_offset),
+			  blks_count);
+		return -ERANGE;
+	}
+
+	if ((blk + len2) != le64_to_cpu(fork->start_offset)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add the hole into fork: "
+			  "blk %llu, len %u, start_offset %llu\n",
+			  blk, len2,
+			  le64_to_cpu(fork->start_offset));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	counted_blks = 0;
+	valid_extents = 0;
+	for (i = 0; i < SSDFS_INLINE_EXTENTS_COUNT; i++) {
+		u32 len;
+
+		cur = &fork->extents[i];
+		len = le32_to_cpu(cur->len);
+
+		if (len >= U32_MAX)
+			break;
+		else {
+			counted_blks += len;
+			valid_extents++;
+		}
+	}
+
+	if (counted_blks != blks_count) {
+		SSDFS_ERR("corrupted fork: "
+			  "counted_blks %llu, blks_count %llu\n",
+			  counted_blks, blks_count);
+		return -ERANGE;
+	}
+
+	if (valid_extents > SSDFS_INLINE_EXTENTS_COUNT ||
+	    valid_extents == 0) {
+		SSDFS_ERR("invalid valid_extents count %d\n",
+			  valid_extents);
+		return -ERANGE;
+	}
+
+	cur = &fork->extents[0];
+
+	seg1 = le64_to_cpu(cur->seg_id);
+	lblk1 = le32_to_cpu(cur->logical_blk);
+	len1 = le32_to_cpu(cur->len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg1 >= U64_MAX);
+	BUG_ON(lblk1 >= U32_MAX);
+	BUG_ON(len1 >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (seg1 == seg2 && (lblk2 + len2) == lblk1) {
+		if ((U32_MAX - len2) <= len1) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to merge to extents: "
+				  "len1 %u, len2 %u\n",
+				  len1, len2);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto add_extent_into_fork;
+		}
+
+		cur->logical_blk = cpu_to_le32(lblk2);
+		le32_add_cpu(&cur->len, len2);
+	} else {
+add_extent_into_fork:
+		if (valid_extents == SSDFS_INLINE_EXTENTS_COUNT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to add extent: "
+				  "valid_extents %u\n",
+				  valid_extents);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENOSPC;
+		}
+
+		ssdfs_memmove(&fork->extents[1], 0, valid_extents * desc_size,
+			      &fork->extents[0], 0, valid_extents * desc_size,
+			      valid_extents * desc_size);
+		ssdfs_memcpy(cur, 0, desc_size,
+			     extent, 0, desc_size,
+			     desc_size);
+	}
+
+	fork->start_offset = cpu_to_le64(blk);
+	le64_add_cpu(&fork->blks_count, len2);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("FORK: start_offset %llu, blks_count %llu\n",
+		  le64_to_cpu(fork->start_offset),
+		  le64_to_cpu(fork->blks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_add_tail_extent_into_fork() - add tail extent into the fork
+ * @blk: logical block number
+ * @extent: raw extent
+ * @fork: raw fork
+ *
+ * This method tries to add @extent into the tail of fork.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - need to add a new fork in the tree.
+ */
+static
+int ssdfs_add_tail_extent_into_fork(u64 blk,
+				    struct ssdfs_raw_extent *extent,
+				    struct ssdfs_raw_fork *fork)
+{
+	struct ssdfs_raw_extent *cur = NULL;
+	u64 seg1, seg2;
+	u32 lblk1, lblk2;
+	u32 len1, len2;
+	u64 start_offset;
+	u64 blks_count, counted_blks;
+	int valid_extents;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!extent || !fork);
+
+	SSDFS_DBG("blk %llu, extent %p, fork %p\n",
+		  blk, extent, fork);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (blk >= U64_MAX) {
+		SSDFS_ERR("invalid blk %llu\n", blk);
+		return -EINVAL;
+	}
+
+	blks_count = le64_to_cpu(fork->blks_count);
+
+	seg2 = le64_to_cpu(extent->seg_id);
+	lblk2 = le32_to_cpu(extent->logical_blk);
+	len2 = le32_to_cpu(extent->len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg2 >= U64_MAX);
+	BUG_ON(lblk2 >= U32_MAX);
+	BUG_ON(len2 >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_offset = le64_to_cpu(fork->start_offset);
+
+	if (blks_count == 0 || blks_count >= U64_MAX) {
+		fork->start_offset = cpu_to_le64(blk);
+		fork->blks_count = cpu_to_le64(len2);
+		cur = &fork->extents[0];
+		ssdfs_memcpy(cur, 0, sizeof(struct ssdfs_raw_extent),
+			     extent, 0, sizeof(struct ssdfs_raw_extent),
+			     sizeof(struct ssdfs_raw_extent));
+		return 0;
+	} else if (start_offset >= U64_MAX) {
+		SSDFS_ERR("corrupted fork: "
+			  "start_offset %llu, blks_count %llu\n",
+			  start_offset, blks_count);
+		return -ERANGE;
+	}
+
+	if ((start_offset + blks_count) != blk) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add the hole into fork: "
+			  "blk %llu, len %u, start_offset %llu\n",
+			  blk, len2, start_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	counted_blks = 0;
+	valid_extents = 0;
+	for (i = 0; i < SSDFS_INLINE_EXTENTS_COUNT; i++) {
+		u32 len;
+
+		cur = &fork->extents[i];
+		len = le32_to_cpu(cur->len);
+
+		if (len >= U32_MAX)
+			break;
+		else {
+			counted_blks += len;
+			valid_extents++;
+		}
+	}
+
+	if (counted_blks != blks_count) {
+		SSDFS_ERR("corrupted fork: "
+			  "counted_blks %llu, blks_count %llu\n",
+			  counted_blks, blks_count);
+		return -ERANGE;
+	}
+
+	if (valid_extents > SSDFS_INLINE_EXTENTS_COUNT ||
+	    valid_extents == 0) {
+		SSDFS_ERR("invalid valid_extents count %d\n",
+			  valid_extents);
+		return -ERANGE;
+	}
+
+	cur = &fork->extents[valid_extents - 1];
+
+	seg1 = le64_to_cpu(cur->seg_id);
+	lblk1 = le32_to_cpu(cur->logical_blk);
+	len1 = le32_to_cpu(cur->len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg1 >= U64_MAX);
+	BUG_ON(lblk1 >= U32_MAX);
+	BUG_ON(len1 >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (seg1 == seg2 && (lblk1 + len1) == lblk2) {
+		if ((U32_MAX - len2) <= len1) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to merge to extents: "
+				  "len1 %u, len2 %u\n",
+				  len1, len2);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto add_extent_into_fork;
+		}
+
+		le32_add_cpu(&cur->len, len2);
+	} else {
+add_extent_into_fork:
+		if (valid_extents == SSDFS_INLINE_EXTENTS_COUNT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to add extent: "
+				  "valid_extents %u\n",
+				  valid_extents);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENOSPC;
+		}
+
+		cur = &fork->extents[valid_extents];
+		ssdfs_memcpy(cur, 0, sizeof(struct ssdfs_raw_extent),
+			     extent, 0, sizeof(struct ssdfs_raw_extent),
+			     sizeof(struct ssdfs_raw_extent));
+	}
+
+	le64_add_cpu(&fork->blks_count, len2);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("FORK: start_offset %llu, blks_count %llu\n",
+		  le64_to_cpu(fork->start_offset),
+		  le64_to_cpu(fork->blks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_add_extent_into_fork() - add extent into the fork
+ * @blk: logical block number
+ * @extent: raw extent
+ * @search: search object
+ *
+ * This method tries to add @extent into the fork.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - fork doesn't exist.
+ * %-ENOSPC     - need to add a new fork in the tree.
+ * %-EEXIST     - extent exists in the fork.
+ */
+static
+int ssdfs_add_extent_into_fork(u64 blk,
+				struct ssdfs_raw_extent *extent,
+				struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_fork *fork;
+	u64 start_offset;
+	u64 blks_count;
+	u32 len;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!extent || !search);
+
+	SSDFS_DBG("blk %llu, extent %p, search %p\n",
+		  blk, extent, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_EMPTY_RESULT:
+		SSDFS_DBG("no fork in search object\n");
+		return -ENODATA;
+
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+	case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid search object state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("search buffer state %#x\n",
+			  search->result.buf_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	if (search->result.buf_size != sizeof(struct ssdfs_raw_fork) ||
+	    search->result.items_in_buffer != 1) {
+		SSDFS_ERR("invalid search buffer state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	fork = &search->raw.fork;
+	start_offset = le64_to_cpu(fork->start_offset);
+	blks_count = le64_to_cpu(fork->blks_count);
+	len = le32_to_cpu(extent->len);
+
+	if (start_offset >= U64_MAX || blks_count >= U64_MAX) {
+		SSDFS_ERR("invalid fork state: "
+			  "start_offset %llu, blks_count %llu\n",
+			  start_offset, blks_count);
+		return -ERANGE;
+	}
+
+	if (blk >= U64_MAX || len >= U32_MAX) {
+		SSDFS_ERR("invalid extent: "
+			  "blk %llu, len %u\n",
+			  blk, len);
+		return -ERANGE;
+	}
+
+	if (start_offset <= blk && blk < (start_offset + blks_count)) {
+		SSDFS_ERR("extent exists in the fork: "
+			  "fork (start %llu, blks_count %llu), "
+			  "extent (blk %llu, len %u)\n",
+			  start_offset, blks_count,
+			  blk, len);
+		return -EEXIST;
+	}
+
+	if (start_offset < (blk + len) &&
+	    (blk + len) < (start_offset + blks_count)) {
+		SSDFS_ERR("extent exists in the fork: "
+			  "fork (start %llu, blks_count %llu), "
+			  "extent (blk %llu, len %u)\n",
+			  start_offset, blks_count,
+			  blk, len);
+		return -EEXIST;
+	}
+
+	if (blk < start_offset && (blk + len) < start_offset) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("need to add the fork: "
+			  "fork (start %llu, blks_count %llu), "
+			  "extent (blk %llu, len %u)\n",
+			  start_offset, blks_count,
+			  blk, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	if (blk > (start_offset + blks_count)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("need to add the fork: "
+			  "fork (start %llu, blks_count %llu), "
+			  "extent (blk %llu, len %u)\n",
+			  start_offset, blks_count,
+			  blk, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("fork (start %llu, blks_count %llu), "
+		  "extent (blk %llu, len %u)\n",
+		  start_offset, blks_count,
+		  blk, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((blk + len) == start_offset) {
+		err = ssdfs_add_head_extent_into_fork(blk, extent, fork);
+		if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("need to add the fork: "
+				  "fork (start %llu, blks_count %llu), "
+				  "extent (blk %llu, len %u)\n",
+				  start_offset, blks_count,
+				  blk, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to add the head extent into fork: "
+				  "fork (start %llu, blks_count %llu), "
+				  "extent (blk %llu, len %u)\n",
+				  start_offset, blks_count,
+				  blk, len);
+			return err;
+		}
+	} else if ((start_offset + blks_count) == blk) {
+		err = ssdfs_add_tail_extent_into_fork(blk, extent, fork);
+		if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("need to add the fork: "
+				  "fork (start %llu, blks_count %llu), "
+				  "extent (blk %llu, len %u)\n",
+				  start_offset, blks_count,
+				  blk, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to add the tail extent into fork: "
+				  "fork (start %llu, blks_count %llu), "
+				  "extent (blk %llu, len %u)\n",
+				  start_offset, blks_count,
+				  blk, len);
+			return err;
+		}
+	} else {
+		SSDFS_ERR("invalid extent: "
+			  "fork (start %llu, blks_count %llu), "
+			  "extent (blk %llu, len %u)\n",
+			  start_offset, blks_count,
+			  blk, len);
+		return -ERANGE;
+	}
+
+	/* Now fork's start block represent necessary change */
+	start_offset = le64_to_cpu(fork->start_offset);
+	blks_count = le64_to_cpu(fork->blks_count);
+	search->request.start.hash = start_offset;
+	search->request.end.hash = start_offset + blks_count - 1;
+	search->request.count = (int)blks_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search (request.start.hash %llx, "
+		  "request.end.hash %llx, request.count %d)\n",
+		  search->request.start.hash,
+		  search->request.end.hash,
+		  search->request.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_prepare_empty_fork() - prepare empty fork
+ * @blk: block number
+ * @search: search object
+ *
+ * This method tries to prepare empty fork for @blk into
+ * @search object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_prepare_empty_fork(u64 blk,
+			     struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+
+	SSDFS_DBG("blk %llu, search %p\n",
+		  blk, search);
+	SSDFS_DBG("search->result: (state %#x, err %d, "
+		  "start_index %u, count %u, buf_state %#x, buf %p, "
+		  "buf_size %zu, items_in_buffer %u)\n",
+		  search->result.state,
+		  search->result.err,
+		  search->result.start_index,
+		  search->result.count,
+		  search->result.buf_state,
+		  search->result.buf,
+		  search->result.buf_size,
+		  search->result.items_in_buffer);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->result.err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->result.start_index >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+		search->result.buf_state = SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+		search->result.buf = &search->raw.fork;
+		search->result.buf_size = sizeof(struct ssdfs_raw_fork);
+		search->result.items_in_buffer = 1;
+		break;
+
+	case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+		ssdfs_btree_search_free_result_buf(search);
+		search->result.buf_state = SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+		search->result.buf = &search->raw.fork;
+		search->result.buf_size = sizeof(struct ssdfs_raw_fork);
+		search->result.items_in_buffer = 1;
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+		search->result.buf_state = SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+		search->result.buf = &search->raw.fork;
+		search->result.buf_size = sizeof(struct ssdfs_raw_fork);
+		search->result.items_in_buffer = 1;
+		break;
+	}
+
+	memset(&search->raw.fork, 0xFF, sizeof(struct ssdfs_raw_fork));
+
+	search->raw.fork.start_offset = cpu_to_le64(blk);
+	search->raw.fork.blks_count = cpu_to_le64(0);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search->result: (state %#x, err %d, "
+		  "start_index %u, count %u, buf_state %#x, buf %p, "
+		  "buf_size %zu, items_in_buffer %u)\n",
+		  search->result.state,
+		  search->result.err,
+		  search->result.start_index,
+		  search->result.count,
+		  search->result.buf_state,
+		  search->result.buf,
+		  search->result.buf_size,
+		  search->result.items_in_buffer);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->request.flags |= SSDFS_BTREE_SEARCH_INLINE_BUF_HAS_NEW_ITEM;
+
+	return 0;
+}
diff --git a/fs/ssdfs/extents_tree.h b/fs/ssdfs/extents_tree.h
new file mode 100644
index 000000000000..a1524ff21f36
--- /dev/null
+++ b/fs/ssdfs/extents_tree.h
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/extents_tree.h - extents tree declarations.
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
+#ifndef _SSDFS_EXTENTS_TREE_H
+#define _SSDFS_EXTENTS_TREE_H
+
+#define SSDFS_COMMIT_QUEUE_DEFAULT_CAPACITY	(16)
+#define SSDFS_COMMIT_QUEUE_THRESHOLD		(32)
+
+/*
+ * struct ssdfs_commit_queue - array of segment IDs
+ * @ids: array of segment IDs
+ * @count: number of items in the queue
+ * @capacity: maximum number of available positions in the queue
+ */
+struct ssdfs_commit_queue {
+	u64 *ids;
+	u32 count;
+	u32 capacity;
+};
+
+/*
+ * struct ssdfs_extents_btree_info - extents btree info
+ * @type: extents btree type
+ * @state: extents btree state
+ * @forks_count: count of the forks in the whole extents tree
+ * @lock: extents btree lock
+ * @generic_tree: pointer on generic btree object
+ * @inline_forks: pointer on inline forks array
+ * @buffer.tree: piece of memory for generic btree object
+ * @buffer.forks: piece of memory for the inline forks
+ * @root: pointer on root node
+ * @root_buffer: buffer for root node
+ * @updated_segs: updated segments queue
+ * @desc: b-tree descriptor
+ * @owner: pointer on owner inode object
+ * @fsi: pointer on shared file system object
+ *
+ * A newly created inode tries to store extents into inline
+ * forks. Every fork contains three extents. The raw on-disk
+ * inode has internal private area that is able to contain the
+ * two inline forks or root node of extents btree and extended
+ * attributes btree. If inode hasn't extended attributes and
+ * the amount of extents are lesser than six then everithing
+ * can be stored inside of inline forks. Otherwise, the real
+ * extents btree should be created.
+ */
+struct ssdfs_extents_btree_info {
+	atomic_t type;
+	atomic_t state;
+	atomic64_t forks_count;
+
+	struct rw_semaphore lock;
+	struct ssdfs_btree *generic_tree;
+	struct ssdfs_raw_fork *inline_forks;
+	union {
+		struct ssdfs_btree tree;
+		struct ssdfs_raw_fork forks[SSDFS_INLINE_FORKS_COUNT];
+	} buffer;
+	struct ssdfs_btree_inline_root_node *root;
+	struct ssdfs_btree_inline_root_node root_buffer;
+	struct ssdfs_commit_queue updated_segs;
+
+	struct ssdfs_extents_btree_descriptor desc;
+	struct ssdfs_inode_info *owner;
+	struct ssdfs_fs_info *fsi;
+};
+
+/* Extents tree types */
+enum {
+	SSDFS_EXTENTS_BTREE_UNKNOWN_TYPE,
+	SSDFS_INLINE_FORKS_ARRAY,
+	SSDFS_PRIVATE_EXTENTS_BTREE,
+	SSDFS_EXTENTS_BTREE_TYPE_MAX
+};
+
+/* Extents tree states */
+enum {
+	SSDFS_EXTENTS_BTREE_UNKNOWN_STATE,
+	SSDFS_EXTENTS_BTREE_CREATED,
+	SSDFS_EXTENTS_BTREE_INITIALIZED,
+	SSDFS_EXTENTS_BTREE_DIRTY,
+	SSDFS_EXTENTS_BTREE_CORRUPTED,
+	SSDFS_EXTENTS_BTREE_STATE_MAX
+};
+
+/*
+ * Extents tree API
+ */
+int ssdfs_extents_tree_create(struct ssdfs_fs_info *fsi,
+				struct ssdfs_inode_info *ii);
+int ssdfs_extents_tree_init(struct ssdfs_fs_info *fsi,
+			    struct ssdfs_inode_info *ii);
+void ssdfs_extents_tree_destroy(struct ssdfs_inode_info *ii);
+int ssdfs_extents_tree_flush(struct ssdfs_fs_info *fsi,
+			     struct ssdfs_inode_info *ii);
+int ssdfs_extents_tree_add_updated_seg_id(struct ssdfs_extents_btree_info *tree,
+					  u64 seg_id);
+
+int ssdfs_prepare_volume_extent(struct ssdfs_fs_info *fsi,
+				struct ssdfs_segment_request *req);
+int ssdfs_recommend_migration_extent(struct ssdfs_fs_info *fsi,
+				     struct ssdfs_segment_request *req,
+				     struct ssdfs_zone_fragment *fragment);
+bool ssdfs_extents_tree_has_logical_block(u64 blk_offset, struct inode *inode);
+int ssdfs_extents_tree_add_extent(struct inode *inode,
+				  struct ssdfs_segment_request *req);
+int ssdfs_extents_tree_move_extent(struct ssdfs_extents_btree_info *tree,
+				   u64 blk,
+				   struct ssdfs_raw_extent *old_extent,
+				   struct ssdfs_raw_extent *new_extent,
+				   struct ssdfs_btree_search *search);
+int ssdfs_extents_tree_truncate(struct inode *inode);
+
+/*
+ * Extents tree internal API
+ */
+int ssdfs_extents_tree_find_fork(struct ssdfs_extents_btree_info *tree,
+				 u64 blk,
+				 struct ssdfs_btree_search *search);
+int __ssdfs_extents_tree_add_extent(struct ssdfs_extents_btree_info *tree,
+				     u64 blk,
+				     struct ssdfs_raw_extent *extent,
+				     struct ssdfs_btree_search *search);
+int ssdfs_extents_tree_change_extent(struct ssdfs_extents_btree_info *tree,
+				     u64 blk,
+				     struct ssdfs_raw_extent *extent,
+				     struct ssdfs_btree_search *search);
+int ssdfs_extents_tree_truncate_extent(struct ssdfs_extents_btree_info *tree,
+					u64 blk, u32 new_len,
+					struct ssdfs_btree_search *search);
+int ssdfs_extents_tree_delete_extent(struct ssdfs_extents_btree_info *tree,
+				     u64 blk,
+				     struct ssdfs_btree_search *search);
+int ssdfs_extents_tree_delete_all(struct ssdfs_extents_btree_info *tree);
+int __ssdfs_extents_btree_node_get_fork(struct pagevec *pvec,
+					u32 area_offset,
+					u32 area_size,
+					u32 node_size,
+					u16 item_index,
+					struct ssdfs_raw_fork *fork);
+
+void ssdfs_debug_extents_btree_object(struct ssdfs_extents_btree_info *tree);
+
+/*
+ * Extents btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations
+						ssdfs_extents_btree_desc_ops;
+extern const struct ssdfs_btree_operations ssdfs_extents_btree_ops;
+extern const struct ssdfs_btree_node_operations ssdfs_extents_btree_node_ops;
+
+#endif /* _SSDFS_EXTENTS_TREE_H */
-- 
2.34.1


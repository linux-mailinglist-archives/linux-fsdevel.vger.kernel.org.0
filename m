Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9486A266F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBYBUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBYBTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:40 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E62E12BF9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:04 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id e21so831000oie.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCHjzp5iee+rTJ3m6+0ElhtjUdZZH14etZXXSs97bbo=;
        b=K8ESAxSqUBMXGSGbSs5kBiOVJOvLVX/aFNO1jiY0ngpN6PFxOXAzz7UjpvMhAzrVM5
         jtd0u3K4kuHpcwDaXeNL1z2dvqInxeEbvjz7EXjL93SSRpfIGQcxiaGf+NUgXcnkoB9b
         Yr0YeQwAvuOcjei8LYSROjfYx7lO6RWKGMehXQS+ELcuGUyCwyQIJTEPkwkut1phQ2wC
         sdWXcQ35f+vjp0xsuVcdjz4uTqFpJRwTkkkbstfn7POyalEdIxZihP/Q1zB3iRW3nbK9
         jgi2NKwjJskbJvBjye4muwrbfkof9cBOgRKEvjbK8qU8uL48jUYFU4BnbkSXU5OEkcwl
         AozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCHjzp5iee+rTJ3m6+0ElhtjUdZZH14etZXXSs97bbo=;
        b=Kj2RQOKH/VMyLChWeLaOoLW7q+JqB3WkJGEnvSCiqO9D5h59kBPQtKf1y9nwUeqRZ/
         sRN3tQsN6dThGdhvkF7t5amJM8VktUxBWolgOb96bAgiXZnTq9b7eKIdL92UoolkFNC5
         963HFEMqMSnvEOjM4SSPE0W2CAf2JnILc6DHk0GpUNKAh33arCCKRlMfZwmhIONr9Dz0
         u16sfHReugdqVj9kt/gmfIg/+uCm3LwPNg+SgMcp/rTehx5bbdCyp6HPzkqF+gudmN8Q
         CK7NKeWKoADUi1H7W1eSB8TE+dA0WxZ/2UNl99mLSEoMgt/4dC0B6WZxc0AYtNTzXw58
         FQ6g==
X-Gm-Message-State: AO0yUKVlPDdwtUIvhtNGrKfkxPb5WAUDHdu65L68y6S6qOH0fRtsp9P9
        JSWaunCEovOCjq1MUNO8rdtDKQoG3tQGTn19
X-Google-Smtp-Source: AK7set8yxeTYycG2OB5BWJMH+hn8z4lLSbR01ntbGsrsAJlhod1VOVwx5/L+3jgdiKDBKVWCfToWcQ==
X-Received: by 2002:aca:d0d:0:b0:360:e80e:26a9 with SMTP id 13-20020aca0d0d000000b00360e80e26a9mr4336250oin.12.1677287883289;
        Fri, 24 Feb 2023 17:18:03 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:18:02 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 70/76] ssdfs: introduce invalidated extents b-tree
Date:   Fri, 24 Feb 2023 17:09:21 -0800
Message-Id: <20230225010927.813929-71-slava@dubeyko.com>
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

ZNS SSD operates by zone concept. Zone can be: (1) empty,
(2) open (implicitly or explicitly), (3) closed, (4) full.
The number of open/active zones is limited by some threshold.
To manage open/active zones limitation, SSDFS has current
user data segment for new data and current user data segment
to receive updates for closed zones. Every update of data in
closed zone requires: (1) store updated data into current
segment for updated user data, (2) update extents b-tree by
new data location, (3) add invalidated extent of closed zone
into invalidated extents b-tree. Invalidated extents b-tree
is responsible for: (1) correct erase block's (closed zone)
block bitmap by means of setting moved logical blocks as
invalidated during erase block object initialization,
(2) collect all invalidated extents of closed zone.
If the length of all closed zone's invalidated extents is equal
to zone size, then closed zone can be re-initialized or be erased.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/invalidated_extents_tree.c | 2523 +++++++++++++++++++++++++++
 fs/ssdfs/invalidated_extents_tree.h |   95 +
 2 files changed, 2618 insertions(+)
 create mode 100644 fs/ssdfs/invalidated_extents_tree.c
 create mode 100644 fs/ssdfs/invalidated_extents_tree.h

diff --git a/fs/ssdfs/invalidated_extents_tree.c b/fs/ssdfs/invalidated_extents_tree.c
new file mode 100644
index 000000000000..4cb5ffeac706
--- /dev/null
+++ b/fs/ssdfs/invalidated_extents_tree.c
@@ -0,0 +1,2523 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/invalidated_extents_tree.c - invalidated extents btree implementation.
+ *
+ * Copyright (c) 2022-2023 Bytedance Ltd. and/or its affiliates.
+ *              https://www.bytedance.com/
+ * Copyright (c) 2022-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cong Wang
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+#include <linux/time.h>
+#include <linux/time64.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "shared_dictionary.h"
+#include "dentries_tree.h"
+#include "invalidated_extents_tree.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_invext_tree_page_leaks;
+atomic64_t ssdfs_invext_tree_memory_leaks;
+atomic64_t ssdfs_invext_tree_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_invext_tree_cache_leaks_increment(void *kaddr)
+ * void ssdfs_invext_tree_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_invext_tree_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_invext_tree_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_invext_tree_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_invext_tree_kfree(void *kaddr)
+ * struct page *ssdfs_invext_tree_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_invext_tree_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_invext_tree_free_page(struct page *page)
+ * void ssdfs_invext_tree_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(invext_tree)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(invext_tree)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_invext_tree_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_invext_tree_page_leaks, 0);
+	atomic64_set(&ssdfs_invext_tree_memory_leaks, 0);
+	atomic64_set(&ssdfs_invext_tree_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_invext_tree_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_invext_tree_page_leaks) != 0) {
+		SSDFS_ERR("INVALIDATED EXTENTS TREE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_invext_tree_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_invext_tree_memory_leaks) != 0) {
+		SSDFS_ERR("INVALIDATED EXTENTS TREE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_invext_tree_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_invext_tree_cache_leaks) != 0) {
+		SSDFS_ERR("INVALIDATED EXTENTS TREE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_invext_tree_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/******************************************************************************
+ *                  INVALIDATED EXTENTS TREE OBJECT FUNCTIONALITY             *
+ ******************************************************************************/
+
+/*
+ * ssdfs_invextree_create() - create invalidated extents btree
+ * @fsi: pointer on shared file system object
+ *
+ * This method tries to create invalidated extents btree object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_invextree_create(struct ssdfs_fs_info *fsi)
+{
+	struct ssdfs_invextree_info *ptr;
+	size_t desc_size = sizeof(struct ssdfs_invextree_info);
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p\n", fsi);
+#else
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi->invextree = NULL;
+
+	ptr = ssdfs_invext_tree_kzalloc(desc_size, GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate invalidated extents tree\n");
+		return -ENOMEM;
+	}
+
+	atomic_set(&ptr->state, SSDFS_INVEXTREE_UNKNOWN_STATE);
+
+	fsi->invextree = ptr;
+	ptr->fsi = fsi;
+
+	err = ssdfs_btree_create(fsi,
+				 SSDFS_INVALID_EXTENTS_BTREE_INO,
+				 &ssdfs_invextree_desc_ops,
+				 &ssdfs_invextree_ops,
+				 &ptr->generic_tree);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create invalidated extents tree: err %d\n",
+			  err);
+		goto fail_create_invextree;
+	}
+
+	init_rwsem(&ptr->lock);
+
+	atomic64_set(&ptr->extents_count, 0);
+
+	atomic_set(&ptr->state, SSDFS_INVEXTREE_CREATED);
+
+	ssdfs_debug_invextree_object(ptr);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("DONE: create invalidated extents tree\n");
+#else
+	SSDFS_DBG("DONE: create invalidated extents tree\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+fail_create_invextree:
+	ssdfs_invext_tree_kfree(ptr);
+	fsi->invextree = NULL;
+	return err;
+}
+
+/*
+ * ssdfs_invextree_destroy - destroy invalidated extents btree
+ * @fsi: pointer on shared file system object
+ */
+void ssdfs_invextree_destroy(struct ssdfs_fs_info *fsi)
+{
+	struct ssdfs_invextree_info *tree;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p\n", fsi->invextree);
+#else
+	SSDFS_DBG("tree %p\n", fsi->invextree);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!fsi->invextree)
+		return;
+
+	tree = fsi->invextree;
+
+	ssdfs_debug_invextree_object(tree);
+
+	ssdfs_btree_destroy(&tree->generic_tree);
+
+	ssdfs_invext_tree_kfree(tree);
+	fsi->invextree = NULL;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * ssdfs_invextree_flush() - flush dirty invalidated extents btree
+ * @fsi: pointer on shared file system object
+ *
+ * This method tries to flush the dirty invalidated extents btree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_invextree_flush(struct ssdfs_fs_info *fsi)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->invextree);
+	BUG_ON(!rwsem_is_locked(&fsi->volume_sem));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p\n", fsi->invextree);
+#else
+	SSDFS_DBG("tree %p\n", fsi->invextree);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_btree_flush(&fsi->invextree->generic_tree);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to flush invalidated extents btree: err %d\n",
+			  err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_invextree_object(fsi->invextree);
+
+	return 0;
+}
+
+/******************************************************************************
+ *                INVALIDATED EXTENTS TREE OBJECT FUNCTIONALITY               *
+ ******************************************************************************/
+
+/*
+ * ssdfs_invextree_calculate_hash() - calculate hash value
+ * @fsi: pointer on shared file system object
+ * @seg_id: segment or zone ID
+ * @logical_blk: logical block index in the segment or zone
+ */
+static inline
+u64 ssdfs_invextree_calculate_hash(struct ssdfs_fs_info *fsi,
+				   u64 seg_id, u32 logical_blk)
+{
+	u64 hash = U64_MAX;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("seg_id %llu, logical_block %u\n",
+		  seg_id, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hash = seg_id;
+	hash *= fsi->pebs_per_seg;
+	hash *= fsi->pages_per_peb;
+	hash += logical_blk;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, logical_block %u, "
+		  "pebs_per_seg %u, pages_per_peb %u, "
+		  "hash %llx\n",
+		  seg_id, logical_blk,
+		  fsi->pebs_per_seg,
+		  fsi->pages_per_peb,
+		  hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return hash;
+}
+
+/*
+ * need_initialize_invextree_search() - check necessity to init the search
+ * @fsi: pointer on shared file system object
+ * @seg_id: segment or zone ID
+ * @logical_blk: logical block index in the segment or zone
+ * @search: search object
+ */
+static inline
+bool need_initialize_invextree_search(struct ssdfs_fs_info *fsi,
+					u64 seg_id, u32 logical_blk,
+					struct ssdfs_btree_search *search)
+{
+	u64 hash = ssdfs_invextree_calculate_hash(fsi, seg_id, logical_blk);
+
+	return need_initialize_btree_search(search) ||
+				search->request.start.hash != hash;
+}
+
+/*
+ * ssdfs_invextree_find() - find invalidated extent
+ * @tree: pointer on invalidated extents btree object
+ * @extent: searching range of invalidated logical blocks
+ * @search: pointer on search request object
+ *
+ * This method tries to find an invalidated extent.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_invextree_find(struct ssdfs_invextree_info *tree,
+			 struct ssdfs_raw_extent *extent,
+			 struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u64 start_hash;
+	u64 end_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !extent || !search);
+
+	SSDFS_DBG("tree %p, search %p, "
+		  "extent (seg_id %llu, logical_blk %u, len %u)\n",
+		  tree, search,
+		  le64_to_cpu(extent->seg_id),
+		  le32_to_cpu(extent->logical_blk),
+		  le32_to_cpu(extent->len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+
+	seg_id = le64_to_cpu(extent->seg_id);
+	logical_blk = le32_to_cpu(extent->logical_blk);
+	len = le32_to_cpu(extent->len);
+
+	start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id, logical_blk);
+	end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						  logical_blk + len - 1);
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_RANGE;
+
+	if (need_initialize_invextree_search(fsi, seg_id, logical_blk, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_RANGE;
+		search->request.flags = SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE;
+		search->request.start.hash = start_hash;
+		search->request.end.hash = end_hash;
+		search->request.count = len;
+	}
+
+	return ssdfs_btree_find_range(&tree->generic_tree, search);
+}
+
+/*
+ * ssdfs_invextree_find_leaf_node() - find a leaf node in the tree
+ * @tree: invalidated extents tree
+ * @seg_id: segment or zone ID
+ * @search: search object
+ *
+ * This method tries to find a leaf node for the requested @seg_id.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_invextree_find_leaf_node(struct ssdfs_invextree_info *tree,
+				   u64 seg_id,
+				   struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	u64 hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, seg_id %llu, search %p\n",
+		  tree, seg_id, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+	hash = ssdfs_invextree_calculate_hash(fsi, seg_id, 0);
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	if (need_initialize_invextree_search(fsi, seg_id, 0, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags = SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE;
+		search->request.start.hash = hash;
+		search->request.end.hash = hash;
+		search->request.count = 1;
+	}
+
+	err = ssdfs_btree_find_item(&tree->generic_tree, search);
+	if (err == -ENODATA) {
+		switch (search->result.state) {
+		case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+		case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+			/* expected state */
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("unexpected result's state %#x\n",
+				  search->result.state);
+			goto finish_find_leaf_node;
+		}
+
+		switch (search->node.state) {
+		case SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC:
+		case SSDFS_BTREE_SEARCH_FOUND_INDEX_NODE_DESC:
+			/* expected state */
+			err = 0;
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("unexpected node state %#x\n",
+				  search->node.state);
+			break;
+		}
+	}
+
+finish_find_leaf_node:
+	return err;
+}
+
+/*
+ * ssdfs_invextree_get_start_hash() - get starting hash of the tree
+ * @tree: invalidated extents tree
+ * @start_hash: extracted start hash [out]
+ *
+ * This method tries to extract a start hash of the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_invextree_get_start_hash(struct ssdfs_invextree_info *tree,
+				   u64 *start_hash)
+{
+	struct ssdfs_btree_node *node;
+	u64 extents_count;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !start_hash);
+
+	SSDFS_DBG("tree %p, start_hash %p\n",
+		  tree, start_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_hash = U64_MAX;
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_INVEXTREE_CREATED:
+	case SSDFS_INVEXTREE_INITIALIZED:
+	case SSDFS_INVEXTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid invalidated extents tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	extents_count = atomic64_read(&tree->extents_count);
+
+	if (extents_count < 0) {
+		SSDFS_WARN("invalid invalidated extents count: "
+			   "extents_count %llu\n",
+			   extents_count);
+		return -ERANGE;
+	} else if (extents_count == 0)
+		return -ENOENT;
+
+	down_read(&tree->lock);
+
+	err = ssdfs_btree_radix_tree_find(&tree->generic_tree,
+					  SSDFS_BTREE_ROOT_NODE_ID,
+					  &node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find root node in radix tree: "
+			  "err %d\n", err);
+		goto finish_get_start_hash;
+	} else if (!node) {
+		err = -ENOENT;
+		SSDFS_WARN("empty node pointer\n");
+		goto finish_get_start_hash;
+	}
+
+	down_read(&node->header_lock);
+	*start_hash = node->index_area.start_hash;
+	up_read(&node->header_lock);
+
+finish_get_start_hash:
+	up_read(&tree->lock);
+
+	if (*start_hash >= U64_MAX) {
+		/* warn about invalid hash code */
+		SSDFS_WARN("hash_code is invalid\n");
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_invextree_node_hash_range() - get node's hash range
+ * @tree: invalidated extents tree
+ * @search: search object
+ * @start_hash: extracted start hash [out]
+ * @end_hash: extracted end hash [out]
+ * @items_count: extracted number of items in node [out]
+ *
+ * This method tries to extract start hash, end hash,
+ * and items count in a node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_invextree_node_hash_range(struct ssdfs_invextree_info *tree,
+				    struct ssdfs_btree_search *search,
+				    u64 *start_hash, u64 *end_hash,
+				    u16 *items_count)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !start_hash || !end_hash || !items_count);
+
+	SSDFS_DBG("search %p, start_hash %p, "
+		  "end_hash %p, items_count %p\n",
+		  search, start_hash, end_hash, items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_hash = *end_hash = U64_MAX;
+	*items_count = 0;
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_INVEXTREE_CREATED:
+	case SSDFS_INVEXTREE_INITIALIZED:
+	case SSDFS_INVEXTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid invalidated extents tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	err = ssdfs_btree_node_get_hash_range(search,
+					      start_hash,
+					      end_hash,
+					      items_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get hash range: err %d\n",
+			  err);
+		goto finish_extract_hash_range;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, items_count %u\n",
+		  *start_hash, *end_hash, *items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_extract_hash_range:
+	return err;
+}
+
+/*
+ * ssdfs_invextree_extract_range() - extract range of items
+ * @tree: invalidated extents tree
+ * @start_index: start item index in the node
+ * @count: requested count of items
+ * @search: search object
+ *
+ * This method tries to extract a range of items from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENOENT     - unable to extract any items.
+ */
+int ssdfs_invextree_extract_range(struct ssdfs_invextree_info *tree,
+				  u16 start_index, u16 count,
+				  struct ssdfs_btree_search *search)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, start_index %u, count %u, search %p\n",
+		  tree, start_index, count, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_INVEXTREE_CREATED:
+	case SSDFS_INVEXTREE_INITIALIZED:
+	case SSDFS_INVEXTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid invalidated extents tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	down_read(&tree->lock);
+	err = ssdfs_btree_extract_range(&tree->generic_tree,
+					start_index, count,
+					search);
+	up_read(&tree->lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract the range: "
+			  "start_index %u, count %u, err %d\n",
+			  start_index, count, err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_invextree_check_search_result() - check result of search
+ * @search: search object
+ */
+int ssdfs_invextree_check_search_result(struct ssdfs_btree_search *search)
+{
+	size_t desc_size = sizeof(struct ssdfs_raw_extent);
+	u16 items_count;
+	size_t buf_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected result's state %#x\n",
+			  search->result.state);
+		return  -ERANGE;
+	}
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+	case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+		if (!search->result.buf) {
+			SSDFS_ERR("buffer pointer is NULL\n");
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("unexpected buffer's state\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->result.items_in_buffer >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	items_count = (u16)search->result.items_in_buffer;
+
+	if (items_count == 0) {
+		SSDFS_ERR("items_in_buffer %u\n",
+			  items_count);
+		return -ENOENT;
+	} else if (items_count != search->result.count) {
+		SSDFS_ERR("items_count %u != search->result.count %u\n",
+			  items_count, search->result.count);
+		return -ERANGE;
+	}
+
+	buf_size = desc_size * items_count;
+
+	if (buf_size != search->result.buf_size) {
+		SSDFS_ERR("buf_size %zu != search->result.buf_size %zu\n",
+			  buf_size,
+			  search->result.buf_size);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_invextree_get_next_hash() - get next node's starting hash
+ * @tree: invalidated extents tree
+ * @search: search object
+ * @next_hash: next node's starting hash [out]
+ */
+int ssdfs_invextree_get_next_hash(struct ssdfs_invextree_info *tree,
+				  struct ssdfs_btree_search *search,
+				  u64 *next_hash)
+{
+	u64 old_hash;
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
+	down_read(&tree->lock);
+	err = ssdfs_btree_get_next_hash(&tree->generic_tree, search, next_hash);
+	up_read(&tree->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_prepare_invalidated_extent() - prepare invalidated extent
+ * @extent: invalidated extent
+ * @search: pointer on search request object
+ *
+ * This method tries to prepare an invalidated extent.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_prepare_invalidated_extent(struct ssdfs_raw_extent *extent,
+				     struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_extent *desc = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!extent || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE:
+		search->result.buf_state = SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+		search->result.buf = &search->raw.invalidated_extent;
+		search->result.buf_size = sizeof(struct ssdfs_raw_extent);
+		search->result.items_in_buffer = 1;
+		break;
+
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!search->result.buf);
+		BUG_ON(search->result.buf_size !=
+			sizeof(struct ssdfs_raw_extent));
+		BUG_ON(search->result.items_in_buffer != 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected buffer state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	desc = &search->raw.invalidated_extent;
+
+	ssdfs_memcpy(desc, 0, sizeof(struct ssdfs_raw_extent),
+		     extent, 0, sizeof(struct ssdfs_raw_extent),
+		     sizeof(struct ssdfs_raw_extent));
+
+	return 0;
+}
+
+/*
+ * ssdfs_invextree_add() - add invalidated extent into the tree
+ * @tree: pointer on invalidated extents btree object
+ * @extent: invalidated extent
+ * @search: search object
+ *
+ * This method tries to add invalidated extent info into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - invalidated extent exists in the tree.
+ */
+int ssdfs_invextree_add(struct ssdfs_invextree_info *tree,
+			struct ssdfs_raw_extent *extent,
+			struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	u64 hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !extent || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, extent %p, search %p\n",
+		  tree, extent, search);
+#else
+	SSDFS_DBG("tree %p, extent %p, search %p\n",
+		  tree, extent, search);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = tree->fsi;
+	hash = ssdfs_invextree_calculate_hash(fsi,
+				le64_to_cpu(extent->seg_id),
+				le32_to_cpu(extent->logical_blk));
+
+	ssdfs_btree_search_init(search);
+	search->request.type = SSDFS_BTREE_SEARCH_ADD_ITEM;
+	search->request.flags = SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE;
+	search->request.start.hash = hash;
+	search->request.end.hash = hash;
+	search->request.count = 1;
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_INVEXTREE_CREATED:
+	case SSDFS_INVEXTREE_INITIALIZED:
+	case SSDFS_INVEXTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid invalidated extents tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	down_read(&tree->lock);
+
+	err = ssdfs_btree_find_item(&tree->generic_tree, search);
+	if (err == -ENODATA) {
+		/*
+		 * Invalidated extent doesn't exist.
+		 */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find the invalidated extent: "
+			  "seg_id %llu, logical_blk %u, err %d\n",
+			  le64_to_cpu(extent->seg_id),
+			  le32_to_cpu(extent->logical_blk),
+			  err);
+		goto finish_add_invalidated_extent;
+	}
+
+	if (err == -ENODATA) {
+		err = ssdfs_prepare_invalidated_extent(extent, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare invalidated extent: "
+				  "err %d\n", err);
+			goto finish_add_invalidated_extent;
+		}
+
+		search->request.type = SSDFS_BTREE_SEARCH_ADD_ITEM;
+
+		switch (search->result.state) {
+		case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+		case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+			/* expected state */
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid search result's state %#x\n",
+				  search->result.state);
+			goto finish_add_invalidated_extent;
+		}
+
+		if (search->result.buf_state !=
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid buf_state %#x\n",
+				  search->result.buf_state);
+			goto finish_add_invalidated_extent;
+		}
+
+		err = ssdfs_btree_add_item(&tree->generic_tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add invalidated extent the tree: "
+				  "err %d\n", err);
+			goto finish_add_invalidated_extent;
+		}
+
+		atomic_set(&tree->state, SSDFS_INVEXTREE_DIRTY);
+
+		ssdfs_btree_search_forget_parent_node(search);
+		ssdfs_btree_search_forget_child_node(search);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add invalidated extent: "
+				  "err %d\n", err);
+			goto finish_add_invalidated_extent;
+		}
+	} else {
+		err = -EEXIST;
+		SSDFS_DBG("invalidated extent exists in the tree\n");
+		goto finish_add_invalidated_extent;
+	}
+
+finish_add_invalidated_extent:
+	up_read(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_invextree_object(tree);
+
+	return err;
+}
+
+/*
+ * ssdfs_invextree_delete() - delete invalidated extent from the tree
+ * @tree: invalidated extents tree
+ * @extent: invalidated extent
+ * @search: search object
+ *
+ * This method tries to delete invalidated extent from the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - invalidated extent doesn't exist in the tree.
+ */
+int ssdfs_invextree_delete(struct ssdfs_invextree_info *tree,
+			   struct ssdfs_raw_extent *extent,
+			   struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_raw_extent *desc;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u64 start_hash;
+	u64 end_hash;
+	s64 extents_count;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !extent || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, extent %p, search %p\n",
+		  tree, extent, search);
+#else
+	SSDFS_DBG("tree %p, extent %p, search %p\n",
+		  tree, extent, search);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_INVEXTREE_CREATED:
+	case SSDFS_INVEXTREE_INITIALIZED:
+	case SSDFS_INVEXTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid invalidated extents tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	seg_id = le64_to_cpu(extent->seg_id);
+	logical_blk = le32_to_cpu(extent->logical_blk);
+	len = le32_to_cpu(extent->len);
+
+	fsi = tree->fsi;
+	start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id, logical_blk);
+	end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						  logical_blk + len - 1);
+
+	search->request.type = SSDFS_BTREE_SEARCH_DELETE_RANGE;
+
+	if (need_initialize_invextree_search(fsi, seg_id,
+					     logical_blk, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_DELETE_RANGE;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE;
+		search->request.start.hash = start_hash;
+		search->request.end.hash = end_hash;
+		search->request.count = len;
+	}
+
+	down_read(&tree->lock);
+
+	err = ssdfs_btree_find_item(&tree->generic_tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find the invalidated extent: "
+			  "seg_id %llu, err %d\n",
+			  seg_id, err);
+		goto finish_delete_invalidated_extent;
+	}
+
+	search->request.type = SSDFS_BTREE_SEARCH_DELETE_ITEM;
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_VALID_ITEM) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		goto finish_delete_invalidated_extent;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		goto finish_delete_invalidated_extent;
+	}
+
+	desc = &search->raw.invalidated_extent;
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		if (seg_id != cpu_to_le64(desc->seg_id)) {
+			SSDFS_ERR("invalid result state: "
+				  "seg_id1 %llu != seg_id2 %llu\n",
+				  seg_id, cpu_to_le64(desc->seg_id));
+			goto finish_delete_invalidated_extent;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("unexpected result state %#x\n",
+			   search->result.state);
+		goto finish_delete_invalidated_extent;
+	}
+
+	extents_count = atomic64_read(&tree->extents_count);
+	if (extents_count == 0) {
+		err = -ENOENT;
+		SSDFS_DBG("empty tree\n");
+		goto finish_delete_invalidated_extent;
+	}
+
+	if (search->result.start_index >= extents_count) {
+		err = -ENODATA;
+		SSDFS_ERR("invalid search result: "
+			  "start_index %u, extents_count %lld\n",
+			  search->result.start_index,
+			  extents_count);
+		goto finish_delete_invalidated_extent;
+	}
+
+	err = ssdfs_btree_delete_item(&tree->generic_tree,
+				      search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete invalidated extent from the tree: "
+			  "err %d\n", err);
+		goto finish_delete_invalidated_extent;
+	}
+
+	atomic_set(&tree->state, SSDFS_INVEXTREE_DIRTY);
+
+	ssdfs_btree_search_forget_parent_node(search);
+	ssdfs_btree_search_forget_child_node(search);
+
+	extents_count = atomic64_read(&tree->extents_count);
+
+	if (extents_count == 0) {
+		err = -ENOENT;
+		SSDFS_DBG("tree is empty now\n");
+		goto finish_delete_invalidated_extent;
+	} else if (extents_count < 0) {
+		err = -ERANGE;
+		SSDFS_WARN("invalid extents_count %lld\n",
+			   extents_count);
+		atomic_set(&tree->state, SSDFS_INVEXTREE_CORRUPTED);
+		goto finish_delete_invalidated_extent;
+	}
+
+finish_delete_invalidated_extent:
+	up_read(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_invextree_object(tree);
+
+	return err;
+}
+
+/******************************************************************************
+ *         SPECIALIZED INVALIDATED EXTENTS BTREE DESCRIPTOR OPERATIONS        *
+ ******************************************************************************/
+
+/*
+ * ssdfs_invextree_desc_init() - specialized btree descriptor init
+ * @fsi: pointer on shared file system object
+ * @tree: pointer on invalidated extents btree object
+ */
+static
+int ssdfs_invextree_desc_init(struct ssdfs_fs_info *fsi,
+			      struct ssdfs_btree *tree)
+{
+	struct ssdfs_btree_descriptor *desc;
+	u32 erasesize;
+	u32 node_size;
+	size_t desc_size = sizeof(struct ssdfs_raw_extent);
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
+	desc = &fsi->vh->invextree.desc;
+
+	if (le32_to_cpu(desc->magic) != SSDFS_INVEXT_BTREE_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid magic %#x\n",
+			  le32_to_cpu(desc->magic));
+		goto finish_btree_desc_init;
+	}
+
+	/* TODO: check flags */
+
+	if (desc->type != SSDFS_INVALIDATED_EXTENTS_BTREE) {
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
+	if (item_size != desc_size) {
+		err = -EIO;
+		SSDFS_ERR("invalid item size %u\n",
+			  item_size);
+		goto finish_btree_desc_init;
+	}
+
+	if (le16_to_cpu(desc->index_area_min_size) != (16 * desc_size)) {
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
+ * ssdfs_invextree_desc_flush() - specialized btree's descriptor flush
+ * @tree: pointer on invalidated extents btree object
+ */
+static
+int ssdfs_invextree_desc_flush(struct ssdfs_btree *tree)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_descriptor desc;
+	size_t desc_size = sizeof(struct ssdfs_raw_extent);
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
+	desc.magic = cpu_to_le32(SSDFS_INVEXT_BTREE_MAGIC);
+	desc.item_size = cpu_to_le16(desc_size);
+
+	err = ssdfs_btree_desc_flush(tree, &desc);
+	if (unlikely(err)) {
+		SSDFS_ERR("invalid btree descriptor: err %d\n",
+			  err);
+		return err;
+	}
+
+	if (desc.type != SSDFS_INVALIDATED_EXTENTS_BTREE) {
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
+	if (le16_to_cpu(desc.index_area_min_size) != (16 * desc_size)) {
+		SSDFS_ERR("invalid index_area_min_size %u\n",
+			  le16_to_cpu(desc.index_area_min_size));
+		return -ERANGE;
+	}
+
+	ssdfs_memcpy(&fsi->vh->invextree.desc,
+		     0, sizeof(struct ssdfs_btree_descriptor),
+		     &desc,
+		     0, sizeof(struct ssdfs_btree_descriptor),
+		     sizeof(struct ssdfs_btree_descriptor));
+
+	return 0;
+}
+
+/******************************************************************************
+ *              SPECIALIZED INVALIDATED EXTENTS BTREE OPERATIONS              *
+ ******************************************************************************/
+
+/*
+ * ssdfs_invextree_create_root_node() - specialized root node creation
+ * @fsi: pointer on shared file system object
+ * @node: pointer on node object [out]
+ */
+static
+int ssdfs_invextree_create_root_node(struct ssdfs_fs_info *fsi,
+				     struct ssdfs_btree_node *node)
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
+	root_node = &fsi->vh->invextree.root_node;
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
+ * ssdfs_invextree_pre_flush_root_node() - specialized root node pre-flush
+ * @node: pointer on node object
+ */
+static
+int ssdfs_invextree_pre_flush_root_node(struct ssdfs_btree_node *node)
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
+	if (tree->type != SSDFS_INVALIDATED_EXTENTS_BTREE) {
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
+ * ssdfs_invextree_flush_root_node() - specialized root node flush
+ * @node: pointer on node object
+ */
+static
+int ssdfs_invextree_flush_root_node(struct ssdfs_btree_node *node)
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
+	root_node = &node->tree->fsi->vh->invextree.root_node;
+	ssdfs_btree_flush_root_node(node, root_node);
+
+	return 0;
+}
+
+/*
+ * ssdfs_invextree_create_node() - specialized node creation
+ * @node: pointer on node object
+ */
+static
+int ssdfs_invextree_create_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	void *addr[SSDFS_BTREE_NODE_BMAP_COUNT];
+	size_t hdr_size = sizeof(struct ssdfs_invextree_node_header);
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
+	node->node_ops = &ssdfs_invextree_node_ops;
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
+	if (bmap_bytes == 0 || bmap_bytes > SSDFS_INVEXTREE_BMAP_SIZE) {
+		err = -EIO;
+		SSDFS_ERR("invalid bmap_bytes %zu\n",
+			  bmap_bytes);
+		goto finish_create_node;
+	}
+
+	node->raw.invextree_header.extents_count = cpu_to_le32(0);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, extents_count %u\n",
+		  node->node_id,
+		  le32_to_cpu(node->raw.invextree_header.extents_count));
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
+ * ssdfs_invextree_init_node() - init invalidated extents tree's node
+ * @node: pointer on node object
+ *
+ * This method tries to init the node of invalidated extents btree.
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
+int ssdfs_invextree_init_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_invextree_info *tree_info = NULL;
+	struct ssdfs_invextree_node_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_invextree_node_header);
+	void *addr[SSDFS_BTREE_NODE_BMAP_COUNT];
+	struct page *page;
+	void *kaddr;
+	u64 start_hash, end_hash;
+	u32 node_size;
+	u16 item_size;
+	u32 extents_count;
+	u16 items_capacity;
+	u32 items_count;
+	u16 free_space = 0;
+	u32 calculated_used_space;
+	u16 flags;
+	u8 index_size;
+	u32 index_area_size = 0;
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
+	if (node->tree->type == SSDFS_INVALIDATED_EXTENTS_BTREE)
+		tree_info = (struct ssdfs_invextree_info *)node->tree;
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
+	hdr = (struct ssdfs_invextree_node_header *)kaddr;
+
+	if (!is_csum_valid(&hdr->node.check, hdr, hdr_size)) {
+		err = -EIO;
+		SSDFS_ERR("invalid checksum: node_id %u\n",
+			  node->node_id);
+		goto finish_init_operation;
+	}
+
+	if (le32_to_cpu(hdr->node.magic.common) != SSDFS_SUPER_MAGIC ||
+	    le16_to_cpu(hdr->node.magic.key) != SSDFS_INVEXT_BNODE_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid magic: common %#x, key %#x\n",
+			  le32_to_cpu(hdr->node.magic.common),
+			  le16_to_cpu(hdr->node.magic.key));
+		goto finish_init_operation;
+	}
+
+	down_write(&node->header_lock);
+
+	ssdfs_memcpy(&node->raw.invextree_header, 0, hdr_size,
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
+	flags = atomic_read(&node->flags);
+
+	start_hash = le64_to_cpu(hdr->node.start_hash);
+	end_hash = le64_to_cpu(hdr->node.end_hash);
+	node_size = 1 << hdr->node.log_node_size;
+	index_size = hdr->node.index_size;
+	item_size = hdr->node.min_item_size;
+	items_capacity = le16_to_cpu(hdr->node.items_capacity);
+	extents_count = le32_to_cpu(hdr->extents_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "items_capacity %u, extents_count %u\n",
+		  start_hash, end_hash,
+		  items_capacity, extents_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (item_size == 0 || node_size % item_size) {
+		err = -EIO;
+		SSDFS_ERR("invalid size: item_size %u, node_size %u\n",
+			  item_size, node_size);
+		goto finish_header_init;
+	}
+
+	if (item_size != sizeof(struct ssdfs_raw_extent)) {
+		err = -EIO;
+		SSDFS_ERR("invalid item_size: "
+			  "size %u, expected size %zu\n",
+			  item_size,
+			  sizeof(struct ssdfs_raw_extent));
+		goto finish_header_init;
+	}
+
+	calculated_used_space = hdr_size;
+	calculated_used_space += extents_count * item_size;
+
+	if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+		index_area_size = 1 << hdr->node.log_index_area_size;
+		calculated_used_space += index_area_size;
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+		/* do nothing */
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+			if (index_area_size != node->node_size) {
+				err = -EIO;
+				SSDFS_ERR("invalid index area's size: "
+					  "node_id %u, index_area_size %u, "
+					  "node_size %u\n",
+					  node->node_id,
+					  index_area_size,
+					  node->node_size);
+				goto finish_header_init;
+			}
+
+			calculated_used_space -= hdr_size;
+		} else {
+			err = -EIO;
+			SSDFS_ERR("invalid set of flags: "
+				  "node_id %u, flags %#x\n",
+				  node->node_id, flags);
+			goto finish_header_init;
+		}
+
+		free_space = 0;
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+			/*
+			 * expected state
+			 */
+		} else {
+			err = -EIO;
+			SSDFS_ERR("invalid set of flags: "
+				  "node_id %u, flags %#x\n",
+				  node->node_id, flags);
+			goto finish_header_init;
+		}
+		/* FALLTHRU */
+		fallthrough;
+	case SSDFS_BTREE_LEAF_NODE:
+		if (extents_count > 0 &&
+		    (start_hash >= U64_MAX || end_hash >= U64_MAX)) {
+			err = -EIO;
+			SSDFS_ERR("invalid hash range: "
+				  "start_hash %llx, end_hash %llx\n",
+				  start_hash, end_hash);
+			goto finish_header_init;
+		}
+
+		if (item_size == 0 || node_size % item_size) {
+			err = -EIO;
+			SSDFS_ERR("invalid size: item_size %u, node_size %u\n",
+				  item_size, node_size);
+			goto finish_header_init;
+		}
+
+		if (item_size != sizeof(struct ssdfs_raw_extent)) {
+			err = -EIO;
+			SSDFS_ERR("invalid item_size: "
+				  "size %u, expected size %zu\n",
+				  item_size,
+				  sizeof(struct ssdfs_raw_extent));
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
+		if (extents_count > items_capacity) {
+			err = -EIO;
+			SSDFS_ERR("items_capacity %u != extents_count %u\n",
+				  items_capacity,
+				  extents_count);
+			goto finish_header_init;
+		}
+
+		free_space =
+			(u32)(items_capacity - extents_count) * item_size;
+		if (free_space > node->items_area.area_size) {
+			err = -EIO;
+			SSDFS_ERR("free_space %u > area_size %u\n",
+				  free_space,
+				  node->items_area.area_size);
+			goto finish_header_init;
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_space %u, index_area_size %u, "
+		  "hdr_size %zu, extents_count %u, "
+		  "item_size %u\n",
+		  free_space, index_area_size, hdr_size,
+		  extents_count, item_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (free_space != (node_size - calculated_used_space)) {
+		err = -EIO;
+		SSDFS_ERR("free_space %u, node_size %u, "
+			  "calculated_used_space %u\n",
+			  free_space, node_size,
+			  calculated_used_space);
+		goto finish_header_init;
+	}
+
+	node->items_area.free_space = free_space;
+	node->items_area.items_count = (u16)extents_count;
+	node->items_area.items_capacity = items_capacity;
+
+#ifdef CONFIG_SSDFS_DEBUG
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
+	if (bmap_bytes == 0 || bmap_bytes > SSDFS_INVEXTREE_BMAP_SIZE) {
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
+		   0, extents_count);
+	spin_unlock(&node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP].lock);
+
+	up_write(&node->bmap_array.lock);
+finish_init_operation:
+	kunmap_local(kaddr);
+
+	if (unlikely(err))
+		goto finish_init_node;
+
+	atomic64_add((u64)extents_count, &tree_info->extents_count);
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
+void ssdfs_invextree_destroy_node(struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_invextree_add_node() - add node into invalidated extents btree
+ * @node: pointer on node object
+ *
+ * This method tries to finish addition of node
+ * into invalidated extents btree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_invextree_add_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree *tree;
+	int type;
+	u16 items_capacity = 0;
+	u64 start_hash = U64_MAX;
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
+	case SSDFS_BTREE_NODE_CREATED:
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
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
+	down_read(&node->header_lock);
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		items_capacity = node->items_area.items_capacity;
+		start_hash = node->items_area.start_hash;
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
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, extents_count %u\n",
+		  node->node_id,
+		  le32_to_cpu(node->raw.invextree_header.extents_count));
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
+finish_add_node:
+	up_read(&node->header_lock);
+
+	ssdfs_debug_btree_node_object(node);
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
+static
+int ssdfs_invextree_delete_node(struct ssdfs_btree_node *node)
+{
+	/* TODO: implement */
+	SSDFS_DBG("TODO: implement\n");
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
+}
+
+/*
+ * ssdfs_invextree_pre_flush_node() - pre-flush node's header
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
+int ssdfs_invextree_pre_flush_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_invextree_node_header invextree_header;
+	size_t hdr_size = sizeof(struct ssdfs_invextree_node_header);
+	struct ssdfs_btree *tree;
+	struct ssdfs_invextree_info *tree_info = NULL;
+	struct ssdfs_state_bitmap *bmap;
+	struct page *page;
+	u16 items_count;
+	u32 items_area_size;
+	u16 extents_count;
+	u32 used_space;
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
+	if (tree->type != SSDFS_INVALIDATED_EXTENTS_BTREE) {
+		SSDFS_WARN("invalid tree type %#x\n",
+			   tree->type);
+		return -ERANGE;
+	} else {
+		tree_info = container_of(tree,
+					 struct ssdfs_invextree_info,
+					 generic_tree);
+	}
+
+	down_write(&node->full_lock);
+	down_write(&node->header_lock);
+
+	ssdfs_memcpy(&invextree_header, 0, hdr_size,
+		     &node->raw.invextree_header, 0, hdr_size,
+		     hdr_size);
+
+	invextree_header.node.magic.common = cpu_to_le32(SSDFS_SUPER_MAGIC);
+	invextree_header.node.magic.key =
+				cpu_to_le16(SSDFS_INVEXT_BNODE_MAGIC);
+	invextree_header.node.magic.version.major = SSDFS_MAJOR_REVISION;
+	invextree_header.node.magic.version.minor = SSDFS_MINOR_REVISION;
+
+	err = ssdfs_btree_node_pre_flush_header(node, &invextree_header.node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to flush generic header: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		goto finish_invextree_header_preparation;
+	}
+
+	items_count = node->items_area.items_count;
+	items_area_size = node->items_area.area_size;
+	extents_count = le16_to_cpu(invextree_header.extents_count);
+
+	if (extents_count != items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("extents_count %u != items_count %u\n",
+			  extents_count, items_count);
+		goto finish_invextree_header_preparation;
+	}
+
+	used_space = (u32)items_count * sizeof(struct ssdfs_raw_extent);
+
+	if (used_space > items_area_size) {
+		err = -ERANGE;
+		SSDFS_ERR("used_space %u > items_area_size %u\n",
+			  used_space, items_area_size);
+		goto finish_invextree_header_preparation;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("extents_count %u, "
+		  "items_area_size %u, item_size %zu\n",
+		  extents_count, items_area_size,
+		  sizeof(struct ssdfs_raw_extent));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	invextree_header.node.check.bytes = cpu_to_le16((u16)hdr_size);
+	invextree_header.node.check.flags = cpu_to_le16(SSDFS_CRC32);
+
+	err = ssdfs_calculate_csum(&invextree_header.node.check,
+				   &invextree_header, hdr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to calculate checksum: err %d\n", err);
+		goto finish_invextree_header_preparation;
+	}
+
+	ssdfs_memcpy(&node->raw.invextree_header, 0, hdr_size,
+		     &invextree_header, 0, hdr_size,
+		     hdr_size);
+
+finish_invextree_header_preparation:
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
+			     &invextree_header, 0, hdr_size,
+			     hdr_size);
+
+finish_node_pre_flush:
+	up_write(&node->full_lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_invextree_btree_flush_node() - flush node
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
+int ssdfs_invextree_flush_node(struct ssdfs_btree_node *node)
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
+	if (tree->type != SSDFS_INVALIDATED_EXTENTS_BTREE) {
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
+	if (fs_feature_compat & SSDFS_HAS_INVALID_EXTENTS_TREE_COMPAT_FLAG) {
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
+		SSDFS_CRIT("invalidated extents tree is absent\n");
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	return err;
+}
diff --git a/fs/ssdfs/invalidated_extents_tree.h b/fs/ssdfs/invalidated_extents_tree.h
new file mode 100644
index 000000000000..1ba613504565
--- /dev/null
+++ b/fs/ssdfs/invalidated_extents_tree.h
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/invalidated_extents_tree.h - invalidated extents btree declarations.
+ *
+ * Copyright (c) 2022-2023 Bytedance Ltd. and/or its affiliates.
+ *              https://www.bytedance.com/
+ * Copyright (c) 2022-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cong Wang
+ */
+
+#ifndef _SSDFS_INVALIDATED_EXTENTS_TREE_H
+#define _SSDFS_INVALIDATED_EXTENTS_TREE_H
+
+/*
+ * struct ssdfs_invextree_info - invalidated extents tree object
+ * @state: invalidated extents btree state
+ * @lock: invalidated extents btree lock
+ * @generic_tree: generic btree description
+ * @extents_count: count of extents in the whole tree
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_invextree_info {
+	atomic_t state;
+	struct rw_semaphore lock;
+	struct ssdfs_btree generic_tree;
+
+	atomic64_t extents_count;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+/* Invalidated extents tree states */
+enum {
+	SSDFS_INVEXTREE_UNKNOWN_STATE,
+	SSDFS_INVEXTREE_CREATED,
+	SSDFS_INVEXTREE_INITIALIZED,
+	SSDFS_INVEXTREE_DIRTY,
+	SSDFS_INVEXTREE_CORRUPTED,
+	SSDFS_INVEXTREE_STATE_MAX
+};
+
+/*
+ * Invalidated extents tree API
+ */
+int ssdfs_invextree_create(struct ssdfs_fs_info *fsi);
+void ssdfs_invextree_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_invextree_flush(struct ssdfs_fs_info *fsi);
+
+int ssdfs_invextree_find(struct ssdfs_invextree_info *tree,
+			 struct ssdfs_raw_extent *extent,
+			 struct ssdfs_btree_search *search);
+int ssdfs_invextree_add(struct ssdfs_invextree_info *tree,
+			struct ssdfs_raw_extent *extent,
+			struct ssdfs_btree_search *search);
+int ssdfs_invextree_delete(struct ssdfs_invextree_info *tree,
+			   struct ssdfs_raw_extent *extent,
+			   struct ssdfs_btree_search *search);
+
+/*
+ * Invalidated extents tree's internal API
+ */
+int ssdfs_invextree_find_leaf_node(struct ssdfs_invextree_info *tree,
+				   u64 seg_id,
+				   struct ssdfs_btree_search *search);
+int ssdfs_invextree_get_start_hash(struct ssdfs_invextree_info *tree,
+				   u64 *start_hash);
+int ssdfs_invextree_node_hash_range(struct ssdfs_invextree_info *tree,
+				    struct ssdfs_btree_search *search,
+				    u64 *start_hash, u64 *end_hash,
+				    u16 *items_count);
+int ssdfs_invextree_extract_range(struct ssdfs_invextree_info *tree,
+				  u16 start_index, u16 count,
+				  struct ssdfs_btree_search *search);
+int ssdfs_invextree_check_search_result(struct ssdfs_btree_search *search);
+int ssdfs_invextree_get_next_hash(struct ssdfs_invextree_info *tree,
+				  struct ssdfs_btree_search *search,
+				  u64 *next_hash);
+
+void ssdfs_debug_invextree_object(struct ssdfs_invextree_info *tree);
+
+/*
+ * Invalidated extents btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations ssdfs_invextree_desc_ops;
+extern const struct ssdfs_btree_operations ssdfs_invextree_ops;
+extern const struct ssdfs_btree_node_operations ssdfs_invextree_node_ops;
+
+#endif /* _SSDFS_INVALIDATED_EXTENTS_TREE_H */
-- 
2.34.1


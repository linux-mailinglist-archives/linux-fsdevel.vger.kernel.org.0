Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E586B6A2628
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBYBQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBYBQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:00 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF1913529
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:54 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bk32so762138oib.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YONuv0X0U2Lm9+hiOtlXl27ij+G6kSbWI/eMWoeQ5L0=;
        b=aYjXBxvZL0LoLfDdi56NlP0Cvt8Y0VOgmUlrASp1Pux/gXCAQLJRSfYQQ3HTt3i8KP
         KdslexxVPksCewM1CgyhXj/4sqRTWrtj4F9JcgneGPvbsRckUNCduUI9hudGh/2kZ0X/
         yvmVGdNbQtQPMMBS5KsugsAFpEo6iuaCK+bhEYC7sSagVfcWnWThEmrh4MiLj3cLlHfW
         ZK02F6si51rkqxosf9krwzrFymQ6lxSABPbUpFy0eeQqcuTyIvF+jy6aJSmq49qM4c8u
         N3kcjF+v3wgfTxnsB/zIrhMY2Awh2NGY8yWw9+UpMg/bvav5fd56n1LCGU6R/baRjejY
         smoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YONuv0X0U2Lm9+hiOtlXl27ij+G6kSbWI/eMWoeQ5L0=;
        b=t2Wwf0I3HfmKwDyKKUz34QekOiyOINmCZjgrxE6KVu5nK5GtWCP+04syhUEmzFsfmH
         elnqVEn7FF/LCitvT2Twtm5pKcFecOXgQA530m8AW0QIUEV8ahy+44RLIY6hMnGs+T0C
         zqQq/CtDF8ws/68TrOlFoXAx8gRCIwJOFiVyMM4LP7q9HfggjN19ACfOeTn+MMcvNZin
         hWO3NqSyUBMO6rM0fgsDECTD4WkHIY79E2wV2SDmR4/xpBEhun6qAAJtFFQelndWTCe/
         iG6NKZ5RRy9dD7mV0dSCrXGyQmOyc8V9ENaF7ErAkiieZRf/tfjZIAmP1cVNNNlufDLZ
         Pl3g==
X-Gm-Message-State: AO0yUKX8ZaFMjDmrrJ+9jJhjLwCzNaqZNCfDXU0PO+2Vsq4u006PAcDG
        5U/akOy5HKpUxjB9oOosF6LP68yY0GwyVNoE
X-Google-Smtp-Source: AK7set+gDD0aT9SV1hl7kb3XZyOiwyXOrdbSSlpdwAbXAXPKAlKq6WvSH/Jkle4SzYHVKk4idmPsWw==
X-Received: by 2002:a05:6808:605:b0:384:219:5691 with SMTP id y5-20020a056808060500b0038402195691mr1417663oih.15.1677287753750;
        Fri, 24 Feb 2023 17:15:53 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:15:52 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 09/76] ssdfs: internal array/sequence primitives
Date:   Fri, 24 Feb 2023 17:08:20 -0800
Message-Id: <20230225010927.813929-10-slava@dubeyko.com>
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

Page vector implements simple concept of dynamically growing
page set. For example, block bitmap requires 32 memory pages
to represent 2GB erase block. Page vector has simple interface:
(1) create - allocate page vector's metadata limited by capacity
(2) destroy - deallocate page vector's metadata
(3) init/reinit - clean metadata and set count to zero
(4) allocate - allocate memory page and add to the tail of sequence
(5) add - add memory page to the tail of sequence
(6) remove - remove a memory page for requested index
(7) release - free all pages and remove from page vector

Dynamic array implements concept of dynamically growing sequence
of fixed-sized items based on page vector primitive. Dynamic array
has API:
(1) create - create dynamic array for requested capacity and item size
(2) destroy - destroy dynamic array
(3) get_locked - get item locked for index in array
(4) release - release and unlock item for index
(5) set - set item for index
(6) copy_content - copy content of dynamic array in buffer

Sequence array is specialized structure that has goal
to provide access to items via pointers on the basis of
ID numbers. It means that every item has dedicated ID but
sequence array could contain only some portion of existing
items. Initialization phase has goal to add some limited
number of existing items into the sequence array.
The ID number could be reverted from some maximum number
(threshold) to zero value. Sequence array has API:
(1) create - create sequence array
(2) destroy - destroy sequence array
(3) init_item - init item for requested ID
(4) add_item - add item to the tail of sequence
(5) get_item - get pointer on item for requested ID
(6) apply_for_all - apply an action/function for all items
(7) change_state - change item state for requested ID
(8) change_all_state - change state of all items in sequence

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/dynamic_array.c  | 781 ++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/dynamic_array.h  |  96 +++++
 fs/ssdfs/page_vector.c    | 437 +++++++++++++++++++++
 fs/ssdfs/page_vector.h    |  64 ++++
 fs/ssdfs/sequence_array.c | 639 +++++++++++++++++++++++++++++++
 fs/ssdfs/sequence_array.h | 119 ++++++
 6 files changed, 2136 insertions(+)
 create mode 100644 fs/ssdfs/dynamic_array.c
 create mode 100644 fs/ssdfs/dynamic_array.h
 create mode 100644 fs/ssdfs/page_vector.c
 create mode 100644 fs/ssdfs/page_vector.h
 create mode 100644 fs/ssdfs/sequence_array.c
 create mode 100644 fs/ssdfs/sequence_array.h

diff --git a/fs/ssdfs/dynamic_array.c b/fs/ssdfs/dynamic_array.c
new file mode 100644
index 000000000000..ae7e121f61d0
--- /dev/null
+++ b/fs/ssdfs/dynamic_array.c
@@ -0,0 +1,781 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/dymanic_array.c - dynamic array implementation.
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
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "dynamic_array.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_dynamic_array_page_leaks;
+atomic64_t ssdfs_dynamic_array_memory_leaks;
+atomic64_t ssdfs_dynamic_array_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_dynamic_array_cache_leaks_increment(void *kaddr)
+ * void ssdfs_dynamic_array_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_dynamic_array_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_dynamic_array_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_dynamic_array_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_dynamic_array_kfree(void *kaddr)
+ * struct page *ssdfs_dynamic_array_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_dynamic_array_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_dynamic_array_free_page(struct page *page)
+ * void ssdfs_dynamic_array_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(dynamic_array)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(dynamic_array)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_dynamic_array_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_dynamic_array_page_leaks, 0);
+	atomic64_set(&ssdfs_dynamic_array_memory_leaks, 0);
+	atomic64_set(&ssdfs_dynamic_array_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_dynamic_array_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_dynamic_array_page_leaks) != 0) {
+		SSDFS_ERR("DYNAMIC ARRAY: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_dynamic_array_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_dynamic_array_memory_leaks) != 0) {
+		SSDFS_ERR("DYNAMIC ARRAY: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_dynamic_array_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_dynamic_array_cache_leaks) != 0) {
+		SSDFS_ERR("DYNAMIC ARRAY: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_dynamic_array_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_dynamic_array_create() - create dynamic array
+ * @array: pointer on dynamic array object
+ * @capacity: maximum number of items in array
+ * @item_size: item size in bytes
+ * @alloc_pattern: pattern to init memory pages
+ */
+int ssdfs_dynamic_array_create(struct ssdfs_dynamic_array *array,
+				u32 capacity, size_t item_size,
+				u8 alloc_pattern)
+{
+	struct page *page;
+	u64 max_threshold = (u64)ssdfs_page_vector_max_threshold() * PAGE_SIZE;
+	u32 pages_count;
+	u64 bytes_count;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, capacity %u, item_size %zu\n",
+		  array, capacity, item_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	array->state = SSDFS_DYNAMIC_ARRAY_STORAGE_ABSENT;
+	array->alloc_pattern = alloc_pattern;
+
+	if (capacity == 0) {
+		SSDFS_ERR("invalid capacity %u\n",
+			  capacity);
+		return -EINVAL;
+	}
+
+	if (item_size == 0 || item_size > PAGE_SIZE) {
+		SSDFS_ERR("invalid item_size %zu\n",
+			  item_size);
+		return -EINVAL;
+	}
+
+	array->capacity = capacity;
+	array->item_size = item_size;
+	array->items_per_mem_page = PAGE_SIZE / item_size;
+
+	pages_count = capacity + array->items_per_mem_page - 1;
+	pages_count /= array->items_per_mem_page;
+
+	if (pages_count == 0)
+		pages_count = 1;
+
+	bytes_count = (u64)capacity * item_size;
+
+	if (bytes_count > max_threshold) {
+		SSDFS_ERR("invalid request: "
+			  "bytes_count %llu > max_threshold %llu, "
+			  "capacity %u, item_size %zu\n",
+			  bytes_count, max_threshold,
+			  capacity, item_size);
+		return -EINVAL;
+	}
+
+	if (bytes_count > PAGE_SIZE) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(pages_count >= ssdfs_page_vector_max_threshold());
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_page_vector_create(&array->pvec, pages_count);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create page vector: "
+				  "bytes_count %llu, pages_count %u, "
+				  "err %d\n",
+				  bytes_count, pages_count, err);
+			return err;
+		}
+
+		err = ssdfs_page_vector_init(&array->pvec);
+		if (unlikely(err)) {
+			ssdfs_page_vector_destroy(&array->pvec);
+			SSDFS_ERR("fail to init page vector: "
+				  "bytes_count %llu, pages_count %u, "
+				  "err %d\n",
+				  bytes_count, pages_count, err);
+			return err;
+		}
+
+		page = ssdfs_page_vector_allocate(&array->pvec);
+		if (IS_ERR_OR_NULL(page)) {
+			err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+			SSDFS_ERR("unable to allocate page\n");
+			return err;
+		}
+
+		ssdfs_lock_page(page);
+		ssdfs_memset_page(page, 0, PAGE_SIZE,
+				  array->alloc_pattern, PAGE_SIZE);
+		ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		array->bytes_count = PAGE_SIZE;
+		array->state = SSDFS_DYNAMIC_ARRAY_STORAGE_PAGE_VEC;
+	} else {
+		array->buf = ssdfs_dynamic_array_kzalloc(bytes_count,
+							 GFP_KERNEL);
+		if (!array->buf) {
+			SSDFS_ERR("fail to allocate memory: "
+				  "bytes_count %llu\n",
+				  bytes_count);
+			return -ENOMEM;
+		}
+
+		memset(array->buf, array->alloc_pattern, bytes_count);
+
+		array->bytes_count = bytes_count;
+		array->state = SSDFS_DYNAMIC_ARRAY_STORAGE_BUFFER;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_dynamic_array_destroy() - destroy dynamic array
+ * @array: pointer on dynamic array object
+ */
+void ssdfs_dynamic_array_destroy(struct ssdfs_dynamic_array *array)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, capacity %u, "
+		  "item_size %zu, bytes_count %u\n",
+		  array, array->capacity,
+		  array->item_size, array->bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (array->state) {
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_PAGE_VEC:
+		ssdfs_page_vector_release(&array->pvec);
+		ssdfs_page_vector_destroy(&array->pvec);
+		break;
+
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_BUFFER:
+		if (array->buf)
+			ssdfs_dynamic_array_kfree(array->buf);
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x\n", array->state);
+		break;
+	}
+
+	array->capacity = 0;
+	array->item_size = 0;
+	array->items_per_mem_page = 0;
+	array->bytes_count = 0;
+	array->state = SSDFS_DYNAMIC_ARRAY_STORAGE_ABSENT;
+}
+
+/*
+ * ssdfs_dynamic_array_get_locked() - get locked item
+ * @array: pointer on dynamic array object
+ * @index: item index
+ *
+ * This method tries to get pointer on item. If short buffer
+ * (< 4K) represents dynamic array, then the logic is pretty
+ * straitforward. Otherwise, memory page is locked. The release
+ * method should be called to unlock memory page.
+ *
+ * RETURN:
+ * [success] - pointer on requested item.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-E2BIG      - request is out of array capacity.
+ * %-ERANGE     - internal error.
+ */
+void *ssdfs_dynamic_array_get_locked(struct ssdfs_dynamic_array *array,
+				     u32 index)
+{
+	struct page *page;
+	void *ptr = NULL;
+	u64 max_threshold = (u64)ssdfs_page_vector_max_threshold() * PAGE_SIZE;
+	u64 item_offset = 0;
+	u64 page_index;
+	u32 page_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, index %u, capacity %u, "
+		  "item_size %zu, bytes_count %u\n",
+		  array, index, array->capacity,
+		  array->item_size, array->bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (array->state) {
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_PAGE_VEC:
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_BUFFER:
+		/* continue logic */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x\n", array->state);
+		return ERR_PTR(-ERANGE);
+	}
+
+	if (array->item_size == 0 || array->item_size > PAGE_SIZE) {
+		SSDFS_ERR("invalid item_size %zu\n",
+			  array->item_size);
+		return ERR_PTR(-ERANGE);
+	}
+
+	if (array->capacity == 0) {
+		SSDFS_ERR("invalid capacity %u\n",
+			  array->capacity);
+		return ERR_PTR(-ERANGE);
+	}
+
+	if (array->bytes_count == 0) {
+		SSDFS_ERR("invalid bytes_count %u\n",
+			  array->bytes_count);
+		return ERR_PTR(-ERANGE);
+	}
+
+	if (index >= array->capacity) {
+		SSDFS_WARN("invalid index: index %u, capacity %u\n",
+			   index, array->capacity);
+		return ERR_PTR(-ERANGE);
+	}
+
+	item_offset = (u64)array->item_size * index;
+
+	if (item_offset >= max_threshold) {
+		SSDFS_ERR("invalid item_offset: "
+			  "index %u, item_size %zu, "
+			  "item_offset %llu, bytes_count %u, "
+			  "max_threshold %llu\n",
+			  index, array->item_size,
+			  item_offset, array->bytes_count,
+			  max_threshold);
+		return ERR_PTR(-E2BIG);
+	}
+
+	switch (array->state) {
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_PAGE_VEC:
+		page_index = index / array->items_per_mem_page;
+		page_off = index % array->items_per_mem_page;
+		page_off *= array->item_size;
+
+		if (page_index >= ssdfs_page_vector_capacity(&array->pvec)) {
+			SSDFS_ERR("invalid page index: "
+				  "page_index %llu, item_offset %llu\n",
+				  page_index, item_offset);
+			return ERR_PTR(-E2BIG);
+		}
+
+		while (page_index >= ssdfs_page_vector_count(&array->pvec)) {
+			page = ssdfs_page_vector_allocate(&array->pvec);
+			if (IS_ERR_OR_NULL(page)) {
+				err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+				SSDFS_ERR("unable to allocate page\n");
+				return ERR_PTR(err);
+			}
+
+			ssdfs_lock_page(page);
+			ssdfs_memset_page(page, 0, PAGE_SIZE,
+					  array->alloc_pattern, PAGE_SIZE);
+			ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			array->bytes_count += PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("array %p, index %u, capacity %u, "
+					  "item_size %zu, bytes_count %u, "
+					  "index %u, item_offset %llu, "
+					  "page_index %llu, page_count %u\n",
+					  array, index, array->capacity,
+					  array->item_size, array->bytes_count,
+					  index, item_offset, page_index,
+					  ssdfs_page_vector_count(&array->pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		page = array->pvec.pages[page_index];
+
+		ssdfs_lock_page(page);
+		ptr = kmap_local_page(page);
+		ptr = (u8 *)ptr + page_off;
+		break;
+
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_BUFFER:
+		ptr = (u8 *)array->buf + item_offset;
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x\n", array->state);
+		return ERR_PTR(-ERANGE);
+	}
+
+	return ptr;
+}
+
+/*
+ * ssdfs_dynamic_array_release() - release item
+ * @array: pointer on dynamic array object
+ * @index: item index
+ * @ptr: pointer on item
+ *
+ * This method tries to release item pointer.
+ *
+ * RETURN:
+ * [success] - pointer on requested item.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-E2BIG      - request is out of array capacity.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_dynamic_array_release(struct ssdfs_dynamic_array *array,
+				u32 index, void *ptr)
+{
+	struct page *page;
+	u64 item_offset = 0;
+	u64 page_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !ptr);
+
+	SSDFS_DBG("array %p, index %u, capacity %u, "
+		  "item_size %zu, bytes_count %u\n",
+		  array, index, array->capacity,
+		  array->item_size, array->bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (array->state) {
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_PAGE_VEC:
+		/* continue logic */
+		break;
+
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_BUFFER:
+		/* do nothing */
+		return 0;
+
+	default:
+		SSDFS_WARN("unexpected state %#x\n", array->state);
+		return -ERANGE;
+	}
+
+	if (array->item_size == 0 || array->item_size > PAGE_SIZE) {
+		SSDFS_ERR("invalid item_size %zu\n",
+			  array->item_size);
+		return -ERANGE;
+	}
+
+	if (array->capacity == 0) {
+		SSDFS_ERR("invalid capacity %u\n",
+			  array->capacity);
+		return -ERANGE;
+	}
+
+	if (array->bytes_count == 0) {
+		SSDFS_ERR("invalid bytes_count %u\n",
+			  array->bytes_count);
+		return -ERANGE;
+	}
+
+	if (index >= array->capacity) {
+		SSDFS_ERR("invalid index: index %u, capacity %u\n",
+			  index, array->capacity);
+		return -ERANGE;
+	}
+
+	item_offset = (u64)array->item_size * index;
+
+	if (item_offset >= array->bytes_count) {
+		SSDFS_ERR("invalid item_offset: "
+			  "index %u, item_size %zu, "
+			  "item_offset %llu, bytes_count %u\n",
+			  index, array->item_size,
+			  item_offset, array->bytes_count);
+		return -E2BIG;
+	}
+
+	page_index = index / array->items_per_mem_page;
+
+	if (page_index >= ssdfs_page_vector_count(&array->pvec)) {
+		SSDFS_ERR("invalid page index: "
+			  "page_index %llu, item_offset %llu\n",
+			  page_index, item_offset);
+		return -E2BIG;
+	}
+
+	page = array->pvec.pages[page_index];
+
+	kunmap_local(ptr);
+	ssdfs_unlock_page(page);
+
+	return 0;
+}
+
+/*
+ * ssdfs_dynamic_array_set() - store item into dynamic array
+ * @array: pointer on dynamic array object
+ * @index: item index
+ * @item: pointer on item
+ *
+ * This method tries to store item into dynamic array.
+ *
+ * RETURN:
+ * [success] - pointer on requested item.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-E2BIG      - request is out of array capacity.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_dynamic_array_set(struct ssdfs_dynamic_array *array,
+			    u32 index, void *item)
+{
+	struct page *page;
+	void *kaddr = NULL;
+	u64 max_threshold = (u64)ssdfs_page_vector_max_threshold() * PAGE_SIZE;
+	u64 item_offset = 0;
+	u64 page_index;
+	u32 page_off;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !item);
+
+	SSDFS_DBG("array %p, index %u, capacity %u, "
+		  "item_size %zu, bytes_count %u\n",
+		  array, index, array->capacity,
+		  array->item_size, array->bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (array->state) {
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_PAGE_VEC:
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_BUFFER:
+		/* continue logic */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x\n", array->state);
+		return -ERANGE;
+	}
+
+	if (array->item_size == 0 || array->item_size > PAGE_SIZE) {
+		SSDFS_ERR("invalid item_size %zu\n",
+			  array->item_size);
+		return -ERANGE;
+	}
+
+	if (array->capacity == 0) {
+		SSDFS_ERR("invalid capacity %u\n",
+			  array->capacity);
+		return -ERANGE;
+	}
+
+	if (array->bytes_count == 0) {
+		SSDFS_ERR("invalid bytes_count %u\n",
+			  array->bytes_count);
+		return -ERANGE;
+	}
+
+	if (index >= array->capacity) {
+		SSDFS_ERR("invalid index: index %u, capacity %u\n",
+			  index, array->capacity);
+		return -ERANGE;
+	}
+
+	item_offset = (u64)array->item_size * index;
+
+	if (item_offset >= max_threshold) {
+		SSDFS_ERR("invalid item_offset: "
+			  "index %u, item_size %zu, "
+			  "item_offset %llu, bytes_count %u, "
+			  "max_threshold %llu\n",
+			  index, array->item_size,
+			  item_offset, array->bytes_count,
+			  max_threshold);
+		return -E2BIG;
+	}
+
+	switch (array->state) {
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_PAGE_VEC:
+		page_index = index / array->items_per_mem_page;
+		page_off = index % array->items_per_mem_page;;
+		page_off *= array->item_size;
+
+		if (page_index >= ssdfs_page_vector_capacity(&array->pvec)) {
+			SSDFS_ERR("invalid page index: "
+				  "page_index %llu, item_offset %llu\n",
+				  page_index, item_offset);
+			return -E2BIG;
+		}
+
+		while (page_index >= ssdfs_page_vector_count(&array->pvec)) {
+			page = ssdfs_page_vector_allocate(&array->pvec);
+			if (IS_ERR_OR_NULL(page)) {
+				err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+				SSDFS_ERR("unable to allocate page\n");
+				return err;
+			}
+
+			ssdfs_lock_page(page);
+			ssdfs_memset_page(page, 0, PAGE_SIZE,
+					  array->alloc_pattern, PAGE_SIZE);
+			ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			array->bytes_count += PAGE_SIZE;
+		}
+
+		page = array->pvec.pages[page_index];
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+		err = ssdfs_memcpy(kaddr, page_off, PAGE_SIZE,
+				   item, 0, array->item_size,
+				   array->item_size);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+		break;
+
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_BUFFER:
+		err = ssdfs_memcpy(array->buf, item_offset, array->bytes_count,
+				   item, 0, array->item_size,
+				   array->item_size);
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x\n", array->state);
+		return -ERANGE;
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set item: index %u, err %d\n",
+			  index, err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_dynamic_array_copy_content() - copy the whole dynamic array
+ * @array: pointer on dynamic array object
+ * @copy_buf: pointer on copy buffer
+ * @buf_size: size of the buffer in bytes
+ *
+ * This method tries to copy the whole content of dynamic array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_dynamic_array_copy_content(struct ssdfs_dynamic_array *array,
+				     void *copy_buf, size_t buf_size)
+{
+	struct page *page;
+	u32 copied_bytes = 0;
+	u32 pages_count;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !copy_buf);
+
+	SSDFS_DBG("array %p, capacity %u, "
+		  "item_size %zu, bytes_count %u, "
+		  "copy_buf %p, buf_size %zu\n",
+		  array, array->capacity,
+		  array->item_size, array->bytes_count,
+		  copy_buf, buf_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (array->state) {
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_PAGE_VEC:
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_BUFFER:
+		/* continue logic */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x\n", array->state);
+		return -ERANGE;
+	}
+
+	if (array->bytes_count == 0) {
+		SSDFS_ERR("invalid bytes_count %u\n",
+			  array->bytes_count);
+		return -ERANGE;
+	}
+
+	switch (array->state) {
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_PAGE_VEC:
+		pages_count = ssdfs_page_vector_count(&array->pvec);
+
+		for (i = 0; i < pages_count; i++) {
+			size_t bytes_count;
+
+			if (copied_bytes >= buf_size) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("stop copy: "
+					  "copied_bytes %u, "
+					  "buf_size %zu, "
+					  "array->bytes_count %u, "
+					  "pages_count %u\n",
+					  copied_bytes,
+					  buf_size,
+					  array->bytes_count,
+					  pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+				break;
+			}
+
+			page = array->pvec.pages[i];
+
+			if (!page) {
+				err = -ERANGE;
+				SSDFS_ERR("fail to copy content: "
+					  "copied_bytes %u, "
+					  "array->bytes_count %u, "
+					  "page_index %d, "
+					  "pages_count %u\n",
+					  copied_bytes,
+					  array->bytes_count,
+					  i, pages_count);
+				goto finish_copy_content;
+			}
+
+			bytes_count =
+				array->item_size * array->items_per_mem_page;
+			bytes_count = min_t(size_t, bytes_count,
+						buf_size - copied_bytes);
+
+			err = ssdfs_memcpy_from_page(copy_buf,
+						     copied_bytes,
+						     buf_size,
+						     page,
+						     0,
+						     PAGE_SIZE,
+						     bytes_count);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy content: "
+					  "copied_bytes %u, "
+					  "array->bytes_count %u, "
+					  "page_index %d, "
+					  "pages_count %u, "
+					  "err %d\n",
+					  copied_bytes,
+					  array->bytes_count,
+					  i, pages_count,
+					  err);
+				goto finish_copy_content;
+			}
+
+			copied_bytes += bytes_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("array %p, capacity %u, "
+				  "item_size %zu, bytes_count %u, "
+				  "page_index %d, pages_count %u, "
+				  "bytes_count %zu, copied_bytes %u\n",
+				  array, array->capacity,
+				  array->item_size, array->bytes_count,
+				  i, pages_count, bytes_count, copied_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_DYNAMIC_ARRAY_STORAGE_BUFFER:
+		err = ssdfs_memcpy(copy_buf, 0, buf_size,
+				   array->buf, 0, array->bytes_count,
+				   array->bytes_count);
+		break;
+
+	default:
+		BUG();
+		break;
+	}
+
+finish_copy_content:
+	return err;
+}
diff --git a/fs/ssdfs/dynamic_array.h b/fs/ssdfs/dynamic_array.h
new file mode 100644
index 000000000000..3bb73510f389
--- /dev/null
+++ b/fs/ssdfs/dynamic_array.h
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/dynamic_array.h - dynamic array's declarations.
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
+#ifndef _SSDFS_DYNAMIC_ARRAY_H
+#define _SSDFS_DYNAMIC_ARRAY_H
+
+#include "page_vector.h"
+
+/*
+ * struct ssdfs_dynamic_array - dynamic array
+ * @state: array state
+ * @item_size: size of item in bytes
+ * @items_per_mem_page: number of items per memory page
+ * @capacity: maximum available items count
+ * @bytes_count: currently allocated bytes count
+ * @alloc_pattern: pattern to init memory pages
+ * @pvec: vector of pages
+ * @buf: pointer on memory buffer
+ */
+struct ssdfs_dynamic_array {
+	int state;
+	size_t item_size;
+	u32 items_per_mem_page;
+	u32 capacity;
+	u32 bytes_count;
+	u8 alloc_pattern;
+	struct ssdfs_page_vector pvec;
+	void *buf;
+};
+
+/* Dynamic array's states */
+enum {
+	SSDFS_DYNAMIC_ARRAY_STORAGE_ABSENT,
+	SSDFS_DYNAMIC_ARRAY_STORAGE_PAGE_VEC,
+	SSDFS_DYNAMIC_ARRAY_STORAGE_BUFFER,
+	SSDFS_DYNAMIC_ARRAY_STORAGE_STATE_MAX
+};
+
+/*
+ * Inline functions
+ */
+
+static inline
+u32 ssdfs_dynamic_array_allocated_bytes(struct ssdfs_dynamic_array *array)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return array->bytes_count;
+}
+
+static inline
+u32 ssdfs_dynamic_array_items_count(struct ssdfs_dynamic_array *array)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (array->bytes_count == 0 || array->item_size == 0)
+		return 0;
+
+	return array->bytes_count / array->item_size;
+}
+
+/*
+ * Dynamic array's API
+ */
+int ssdfs_dynamic_array_create(struct ssdfs_dynamic_array *array,
+				u32 capacity, size_t item_size,
+				u8 alloc_pattern);
+void ssdfs_dynamic_array_destroy(struct ssdfs_dynamic_array *array);
+void *ssdfs_dynamic_array_get_locked(struct ssdfs_dynamic_array *array,
+				     u32 index);
+int ssdfs_dynamic_array_release(struct ssdfs_dynamic_array *array,
+				u32 index, void *ptr);
+int ssdfs_dynamic_array_set(struct ssdfs_dynamic_array *array,
+			    u32 index, void *ptr);
+int ssdfs_dynamic_array_copy_content(struct ssdfs_dynamic_array *array,
+				     void *copy_buf, size_t buf_size);
+
+#endif /* _SSDFS_DYNAMIC_ARRAY_H */
diff --git a/fs/ssdfs/page_vector.c b/fs/ssdfs/page_vector.c
new file mode 100644
index 000000000000..b130d99df31b
--- /dev/null
+++ b/fs/ssdfs/page_vector.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/page_vector.c - page vector implementation.
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
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "page_vector.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_page_vector_page_leaks;
+atomic64_t ssdfs_page_vector_memory_leaks;
+atomic64_t ssdfs_page_vector_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_page_vector_cache_leaks_increment(void *kaddr)
+ * void ssdfs_page_vector_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_page_vector_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_page_vector_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_page_vector_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_page_vector_kfree(void *kaddr)
+ * struct page *ssdfs_page_vector_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_page_vector_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_page_vector_free_page(struct page *page)
+ * void ssdfs_page_vector_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(page_vector)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(page_vector)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_page_vector_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_page_vector_page_leaks, 0);
+	atomic64_set(&ssdfs_page_vector_memory_leaks, 0);
+	atomic64_set(&ssdfs_page_vector_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_page_vector_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_page_vector_page_leaks) != 0) {
+		SSDFS_ERR("PAGE VECTOR: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_page_vector_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_page_vector_memory_leaks) != 0) {
+		SSDFS_ERR("PAGE VECTOR: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_page_vector_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_page_vector_cache_leaks) != 0) {
+		SSDFS_ERR("PAGE VECTOR: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_page_vector_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_page_vector_create() - create page vector
+ * @array: pointer on page vector
+ * @capacity: max number of memory pages in vector
+ */
+int ssdfs_page_vector_create(struct ssdfs_page_vector *array,
+			     u32 capacity)
+{
+	size_t size = sizeof(struct page *);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	array->count = 0;
+	array->capacity = 0;
+
+	size *= capacity;
+	array->pages = ssdfs_page_vector_kzalloc(size, GFP_KERNEL);
+	if (!array->pages) {
+		SSDFS_ERR("fail to allocate memory: size %zu\n",
+			  size);
+		return -ENOMEM;
+	}
+
+	array->capacity = capacity;
+
+	return 0;
+}
+
+/*
+ * ssdfs_page_vector_destroy() - destroy page vector
+ * @array: pointer on page vector
+ */
+void ssdfs_page_vector_destroy(struct ssdfs_page_vector *array)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int i;
+
+	BUG_ON(!array);
+
+	if (array->count > 0) {
+		SSDFS_ERR("invalid state: count %u\n",
+			  array->count);
+	}
+
+	for (i = 0; i < array->capacity; i++) {
+		struct page *page = array->pages[i];
+
+		if (page)
+			SSDFS_ERR("page %d is not released\n", i);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	array->count = 0;
+
+	if (array->pages) {
+#ifdef CONFIG_SSDFS_DEBUG
+		if (array->capacity == 0) {
+			SSDFS_ERR("invalid state: capacity %u\n",
+				  array->capacity);
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		array->capacity = 0;
+		ssdfs_page_vector_kfree(array->pages);
+		array->pages = NULL;
+	}
+}
+
+/*
+ * ssdfs_page_vector_init() - init page vector
+ * @array: pointer on page vector
+ */
+int ssdfs_page_vector_init(struct ssdfs_page_vector *array)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	if (!array->pages) {
+		SSDFS_ERR("fail to init\n");
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	array->count = 0;
+
+	if (array->capacity == 0) {
+		SSDFS_ERR("invalid state: capacity %u\n",
+			  array->capacity);
+		return -ERANGE;
+	} else {
+		memset(array->pages, 0,
+			sizeof(struct page *) * array->capacity);
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_page_vector_reinit() - reinit page vector
+ * @array: pointer on page vector
+ */
+int ssdfs_page_vector_reinit(struct ssdfs_page_vector *array)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int i;
+
+	BUG_ON(!array);
+
+	if (!array->pages) {
+		SSDFS_ERR("fail to reinit\n");
+		return -ERANGE;
+	}
+
+	for (i = 0; i < array->capacity; i++) {
+		struct page *page = array->pages[i];
+
+		if (page)
+			SSDFS_WARN("page %d is not released\n", i);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	array->count = 0;
+
+	if (array->capacity == 0) {
+		SSDFS_ERR("invalid state: capacity %u\n",
+			  array->capacity);
+		return -ERANGE;
+	} else {
+		memset(array->pages, 0,
+			sizeof(struct page *) * array->capacity);
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_page_vector_count() - count of pages in page vector
+ * @array: pointer on page vector
+ */
+u32 ssdfs_page_vector_count(struct ssdfs_page_vector *array)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return array->count;
+}
+
+/*
+ * ssdfs_page_vector_space() - free space in page vector
+ * @array: pointer on page vector
+ */
+u32 ssdfs_page_vector_space(struct ssdfs_page_vector *array)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	if (array->count > array->capacity) {
+		SSDFS_ERR("count %u is bigger than max %u\n",
+			  array->count, array->capacity);
+		return 0;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return array->capacity - array->count;
+}
+
+/*
+ * ssdfs_page_vector_capacity() - capacity of page vector
+ * @array: pointer on page vector
+ */
+u32 ssdfs_page_vector_capacity(struct ssdfs_page_vector *array)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return array->capacity;
+}
+
+/*
+ * ssdfs_page_vector_add() - add page in page vector
+ * @array: pointer on page vector
+ * @page: memory page
+ */
+int ssdfs_page_vector_add(struct ssdfs_page_vector *array,
+			  struct page *page)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !page);
+
+	if (array->count >= array->capacity) {
+		SSDFS_ERR("array is full: count %u\n",
+			  array->count);
+		return -ENOSPC;
+	}
+
+	if (!array->pages) {
+		SSDFS_ERR("fail to add page: "
+			  "count %u, capacity %u\n",
+			  array->count, array->capacity);
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	array->pages[array->count] = page;
+	array->count++;
+
+	ssdfs_page_vector_account_page(page);
+
+	return 0;
+}
+
+/*
+ * ssdfs_page_vector_allocate() - allocate + add page
+ * @array: pointer on page vector
+ */
+struct page *ssdfs_page_vector_allocate(struct ssdfs_page_vector *array)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (ssdfs_page_vector_space(array) == 0) {
+		SSDFS_ERR("page vector hasn't space\n");
+		return ERR_PTR(-E2BIG);
+	}
+
+	page = ssdfs_page_vector_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		return ERR_PTR(err);
+	}
+
+	/*
+	 * ssdfs_page_vector_add() accounts page
+	 */
+	ssdfs_page_vector_forget_page(page);
+
+	err = ssdfs_page_vector_add(array, page);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add page: err %d\n",
+			  err);
+		ssdfs_free_page(page);
+		return ERR_PTR(err);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("array %p, page vector count %u\n",
+		  array->pages, ssdfs_page_vector_count(array));
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_DBG("page %p, allocated_pages %lld\n",
+		  page, atomic64_read(&ssdfs_page_vector_page_leaks));
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return page;
+}
+
+/*
+ * ssdfs_page_vector_remove() - remove page
+ * @array: pointer on page vector
+ * @page_index: index of the page
+ */
+struct page *ssdfs_page_vector_remove(struct ssdfs_page_vector *array,
+				      u32 page_index)
+{
+	struct page *page;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (ssdfs_page_vector_count(array) == 0) {
+		SSDFS_ERR("page vector is empty\n");
+		return ERR_PTR(-ENODATA);
+	}
+
+	if (array->count > array->capacity) {
+		SSDFS_ERR("page vector is corrupted: "
+			  "array->count %u, array->capacity %u\n",
+			  array->count, array->capacity);
+		return ERR_PTR(-ERANGE);
+	}
+
+	if (page_index >= array->count) {
+		SSDFS_ERR("page index is out of range: "
+			  "page_index %u, array->count %u\n",
+			  page_index, array->count);
+		return ERR_PTR(-ENOENT);
+	}
+
+	page = array->pages[page_index];
+
+	if (!page) {
+		SSDFS_ERR("page index is absent: "
+			  "page_index %u, array->count %u\n",
+			  page_index, array->count);
+		return ERR_PTR(-ENOENT);
+	}
+
+	ssdfs_page_vector_forget_page(page);
+	array->pages[page_index] = NULL;
+
+	return page;
+}
+
+/*
+ * ssdfs_page_vector_release() - release pages from page vector
+ * @array: pointer on page vector
+ */
+void ssdfs_page_vector_release(struct ssdfs_page_vector *array)
+{
+	struct page *page;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	if (!array->pages) {
+		SSDFS_ERR("fail to release: "
+			  "count %u, capacity %u\n",
+			  array->count, array->capacity);
+		return;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < ssdfs_page_vector_count(array); i++) {
+		page = array->pages[i];
+
+		if (!page)
+			continue;
+
+		ssdfs_page_vector_free_page(page);
+		array->pages[i] = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+		SSDFS_DBG("page %p, allocated_pages %lld\n",
+			  page,
+			  atomic64_read(&ssdfs_page_vector_page_leaks));
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	ssdfs_page_vector_reinit(array);
+}
diff --git a/fs/ssdfs/page_vector.h b/fs/ssdfs/page_vector.h
new file mode 100644
index 000000000000..4a4a6bcaed32
--- /dev/null
+++ b/fs/ssdfs/page_vector.h
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/page_vector.h - page vector's declarations.
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
+#ifndef _SSDFS_PAGE_VECTOR_H
+#define _SSDFS_PAGE_VECTOR_H
+
+/*
+ * struct ssdfs_page_vector - vector of memory pages
+ * @count: current number of pages in vector
+ * @capacity: max number of pages in vector
+ * @pages: array of pointers on pages
+ */
+struct ssdfs_page_vector {
+	u32 count;
+	u32 capacity;
+	struct page **pages;
+};
+
+/*
+ * Inline functions
+ */
+
+/*
+ * ssdfs_page_vector_max_threshold() - maximum possible capacity
+ */
+static inline
+u32 ssdfs_page_vector_max_threshold(void)
+{
+	return S32_MAX;
+}
+
+/*
+ * Page vector's API
+ */
+int ssdfs_page_vector_create(struct ssdfs_page_vector *array,
+			     u32 capacity);
+void ssdfs_page_vector_destroy(struct ssdfs_page_vector *array);
+int ssdfs_page_vector_init(struct ssdfs_page_vector *array);
+int ssdfs_page_vector_reinit(struct ssdfs_page_vector *array);
+u32 ssdfs_page_vector_count(struct ssdfs_page_vector *array);
+u32 ssdfs_page_vector_space(struct ssdfs_page_vector *array);
+u32 ssdfs_page_vector_capacity(struct ssdfs_page_vector *array);
+struct page *ssdfs_page_vector_allocate(struct ssdfs_page_vector *array);
+int ssdfs_page_vector_add(struct ssdfs_page_vector *array,
+			  struct page *page);
+struct page *ssdfs_page_vector_remove(struct ssdfs_page_vector *array,
+				      u32 page_index);
+void ssdfs_page_vector_release(struct ssdfs_page_vector *array);
+
+#endif /* _SSDFS_PAGE_VECTOR_H */
diff --git a/fs/ssdfs/sequence_array.c b/fs/ssdfs/sequence_array.c
new file mode 100644
index 000000000000..696fb88ab208
--- /dev/null
+++ b/fs/ssdfs/sequence_array.c
@@ -0,0 +1,639 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/sequence_array.c - sequence array implementation.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
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
+#include "sequence_array.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_seq_arr_page_leaks;
+atomic64_t ssdfs_seq_arr_memory_leaks;
+atomic64_t ssdfs_seq_arr_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_seq_arr_cache_leaks_increment(void *kaddr)
+ * void ssdfs_seq_arr_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_seq_arr_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_seq_arr_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_seq_arr_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_seq_arr_kfree(void *kaddr)
+ * struct page *ssdfs_seq_arr_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_seq_arr_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_seq_arr_free_page(struct page *page)
+ * void ssdfs_seq_arr_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(seq_arr)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(seq_arr)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_seq_arr_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_seq_arr_page_leaks, 0);
+	atomic64_set(&ssdfs_seq_arr_memory_leaks, 0);
+	atomic64_set(&ssdfs_seq_arr_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_seq_arr_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_seq_arr_page_leaks) != 0) {
+		SSDFS_ERR("SEQUENCE ARRAY: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_seq_arr_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_seq_arr_memory_leaks) != 0) {
+		SSDFS_ERR("SEQUENCE ARRAY: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_seq_arr_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_seq_arr_cache_leaks) != 0) {
+		SSDFS_ERR("SEQUENCE ARRAY: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_seq_arr_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_create_sequence_array() - create sequence array
+ * @revert_threshold: threshold of rollbacking to zero
+ *
+ * This method tries to allocate memory and to create
+ * the sequence array.
+ *
+ * RETURN:
+ * [success] - pointer on created sequence array
+ * [failure] - error code:
+ *
+ * %-EINVAL  - invalid input.
+ * %-ENOMEM  - fail to allocate memory.
+ */
+struct ssdfs_sequence_array *
+ssdfs_create_sequence_array(unsigned long revert_threshold)
+{
+	struct ssdfs_sequence_array *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("revert_threshold %lu\n", revert_threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (revert_threshold == 0) {
+		SSDFS_ERR("invalid revert_threshold %lu\n",
+			  revert_threshold);
+		return ERR_PTR(-EINVAL);
+	}
+
+	ptr = ssdfs_seq_arr_kmalloc(sizeof(struct ssdfs_sequence_array),
+				    GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate memory\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ptr->revert_threshold = revert_threshold;
+	spin_lock_init(&ptr->lock);
+	ptr->last_allocated_id = SSDFS_SEQUENCE_ARRAY_INVALID_ID;
+	INIT_RADIX_TREE(&ptr->map, GFP_ATOMIC);
+
+	return ptr;
+}
+
+/*
+ * ssdfs_destroy_sequence_array() - destroy sequence array
+ * @array: pointer on sequence array object
+ * @free_item: pointer on function that can free item
+ *
+ * This method tries to delete all items from the radix tree,
+ * to free memory of every item and to free the memory of
+ * sequence array itself.
+ */
+void ssdfs_destroy_sequence_array(struct ssdfs_sequence_array *array,
+				  ssdfs_free_item free_item)
+{
+	struct radix_tree_iter iter;
+	void __rcu **slot;
+	void *item_ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !free_item);
+
+	SSDFS_DBG("array %p\n", array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	rcu_read_lock();
+	spin_lock(&array->lock);
+	radix_tree_for_each_slot(slot, &array->map, &iter, 0) {
+		item_ptr = rcu_dereference_raw(*slot);
+
+		spin_unlock(&array->lock);
+		rcu_read_unlock();
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index %llu, ptr %p\n",
+			  (u64)iter.index, item_ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (!item_ptr) {
+			SSDFS_WARN("empty node pointer: "
+				   "index %llu\n",
+				   (u64)iter.index);
+		} else {
+			free_item(item_ptr);
+		}
+
+		rcu_read_lock();
+		spin_lock(&array->lock);
+
+		radix_tree_iter_delete(&array->map, &iter, slot);
+	}
+	array->last_allocated_id = SSDFS_SEQUENCE_ARRAY_INVALID_ID;
+	spin_unlock(&array->lock);
+	rcu_read_unlock();
+
+	ssdfs_seq_arr_kfree(array);
+}
+
+/*
+ * ssdfs_sequence_array_init_item() - initialize the array by item
+ * @array: pointer on sequence array object
+ * @id: ID of inserting item
+ * @item: pointer on inserting item
+ *
+ * This method tries to initialize the array by item.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL  - invalid input.
+ */
+int ssdfs_sequence_array_init_item(struct ssdfs_sequence_array *array,
+				   unsigned long id, void *item)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !item);
+
+	SSDFS_DBG("array %p, id %lu, item %p\n",
+		  array, id, item);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (id > array->revert_threshold) {
+		SSDFS_ERR("invalid input: "
+			  "id %lu, revert_threshold %lu\n",
+			  id, array->revert_threshold);
+		return -EINVAL;
+	}
+
+	err = radix_tree_preload(GFP_NOFS);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to preload radix tree: err %d\n",
+			  err);
+		return err;
+	}
+
+	spin_lock(&array->lock);
+	err = radix_tree_insert(&array->map, id, item);
+	spin_unlock(&array->lock);
+
+	radix_tree_preload_end();
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add item into radix tree: "
+			  "id %llu, item %p, err %d\n",
+			  (u64)id, item, err);
+		return err;
+	}
+
+	spin_lock(&array->lock);
+	if (array->last_allocated_id == SSDFS_SEQUENCE_ARRAY_INVALID_ID)
+		array->last_allocated_id = id;
+	spin_unlock(&array->lock);
+
+	return 0;
+}
+
+/*
+ * ssdfs_sequence_array_add_item() - add new item into array
+ * @array: pointer on sequence array object
+ * @item: pointer on adding item
+ * @id: pointer on ID value [out]
+ *
+ * This method tries to add a new item into the array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE  - internal error.
+ */
+int ssdfs_sequence_array_add_item(struct ssdfs_sequence_array *array,
+				  void *item, unsigned long *id)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !item || !id);
+
+	SSDFS_DBG("array %p, item %p, id %p\n",
+		  array, item, id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*id = SSDFS_SEQUENCE_ARRAY_INVALID_ID;
+
+	err = radix_tree_preload(GFP_NOFS);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to preload radix tree: err %d\n",
+			  err);
+		return err;
+	}
+
+	spin_lock(&array->lock);
+
+	if (array->last_allocated_id == SSDFS_SEQUENCE_ARRAY_INVALID_ID) {
+		err = -ERANGE;
+		goto finish_add_item;
+	} else {
+		if ((array->last_allocated_id + 1) > array->revert_threshold) {
+			*id = 0;
+			array->last_allocated_id = 0;
+		} else {
+			array->last_allocated_id++;
+			*id = array->last_allocated_id;
+		}
+	}
+
+	if (*id > array->revert_threshold) {
+		err = -ERANGE;
+		goto finish_add_item;
+	}
+
+	err = radix_tree_insert(&array->map, *id, item);
+
+finish_add_item:
+	spin_unlock(&array->lock);
+
+	radix_tree_preload_end();
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("id %lu\n", *id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add item into radix tree: "
+			  "id %llu, last_allocated_id %lu, "
+			  "item %p, err %d\n",
+			  (u64)*id, array->last_allocated_id,
+			  item, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_sequence_array_get_item() - retrieve item from array
+ * @array: pointer on sequence array object
+ * @id: ID value
+ *
+ * This method tries to retrieve the pointer on an item
+ * with @id value.
+ *
+ * RETURN:
+ * [success] - pointer on existing item.
+ * [failure] - error code:
+ *
+ * %-ENOENT  - item is absent.
+ */
+void *ssdfs_sequence_array_get_item(struct ssdfs_sequence_array *array,
+				    unsigned long id)
+{
+	void *item_ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, id %lu\n",
+		  array, id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&array->lock);
+	item_ptr = radix_tree_lookup(&array->map, id);
+	spin_unlock(&array->lock);
+
+	if (!item_ptr) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find the item: id %llu\n",
+			  (u64)id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return ERR_PTR(-ENOENT);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("item_ptr %p\n", item_ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return item_ptr;
+}
+
+/*
+ * ssdfs_sequence_array_apply_for_all() - apply action for all items
+ * @array: pointer on sequence array object
+ * @apply_action: pointer on method that needs to be applied
+ *
+ * This method tries to apply some action on all items..
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE  - internal error.
+ */
+int ssdfs_sequence_array_apply_for_all(struct ssdfs_sequence_array *array,
+					ssdfs_apply_action apply_action)
+{
+	struct radix_tree_iter iter;
+	void **slot;
+	void *item_ptr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !apply_action);
+
+	SSDFS_DBG("array %p\n", array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	rcu_read_lock();
+
+	spin_lock(&array->lock);
+	radix_tree_for_each_slot(slot, &array->map, &iter, 0) {
+		item_ptr = radix_tree_deref_slot(slot);
+		if (unlikely(!item_ptr)) {
+			SSDFS_WARN("empty item ptr: id %llu\n",
+				   (u64)iter.index);
+			continue;
+		}
+		spin_unlock(&array->lock);
+
+		rcu_read_unlock();
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("id %llu, item_ptr %p\n",
+			  (u64)iter.index, item_ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = apply_action(item_ptr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to apply action: "
+				  "id %llu, err %d\n",
+				  (u64)iter.index,  err);
+			goto finish_apply_to_all;
+		}
+
+		rcu_read_lock();
+
+		spin_lock(&array->lock);
+	}
+	spin_unlock(&array->lock);
+
+	rcu_read_unlock();
+
+finish_apply_to_all:
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to apply action for all items: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_sequence_array_change_state() - change item's state
+ * @array: pointer on sequence array object
+ * @id: ID value
+ * @old_tag: old tag value
+ * @new_tag: new tag value
+ * @change_state: pointer on method of changing item's state
+ * @old_state: old item's state value
+ * @new_state: new item's state value
+ *
+ * This method tries to change an item's state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE  - internal error.
+ * %-ENOENT  - item is absent.
+ */
+int ssdfs_sequence_array_change_state(struct ssdfs_sequence_array *array,
+					unsigned long id,
+					int old_tag, int new_tag,
+					ssdfs_change_item_state change_state,
+					int old_state, int new_state)
+{
+	void *item_ptr = NULL;
+	int res;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !change_state);
+
+	SSDFS_DBG("array %p, id %lu, "
+		  "old_tag %#x, new_tag %#x, "
+		  "old_state %#x, new_state %#x\n",
+		  array, id, old_tag, new_tag,
+		  old_state, new_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	rcu_read_lock();
+
+	spin_lock(&array->lock);
+	item_ptr = radix_tree_lookup(&array->map, id);
+	if (item_ptr) {
+		if (old_tag != SSDFS_SEQUENCE_ITEM_NO_TAG) {
+			res = radix_tree_tag_get(&array->map, id, old_tag);
+			if (res != 1)
+				err = -ERANGE;
+		}
+	} else
+		err = -ENOENT;
+	spin_unlock(&array->lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to find item id %llu with tag %#x\n",
+			  (u64)id, old_tag);
+		goto finish_change_state;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("id %llu, item_ptr %p\n",
+		  (u64)id, item_ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = change_state(item_ptr, old_state, new_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change state: "
+			  "id %llu, old_state %#x, "
+			  "new_state %#x, err %d\n",
+			  (u64)id, old_state, new_state, err);
+		goto finish_change_state;
+	}
+
+	spin_lock(&array->lock);
+	item_ptr = radix_tree_tag_set(&array->map, id, new_tag);
+	if (old_tag != SSDFS_SEQUENCE_ITEM_NO_TAG)
+		radix_tree_tag_clear(&array->map, id, old_tag);
+	spin_unlock(&array->lock);
+
+finish_change_state:
+	rcu_read_unlock();
+
+	return err;
+}
+
+/*
+ * ssdfs_sequence_array_change_all_states() - change state of all tagged items
+ * @array: pointer on sequence array object
+ * @old_tag: old tag value
+ * @new_tag: new tag value
+ * @change_state: pointer on method of changing item's state
+ * @old_state: old item's state value
+ * @new_state: new item's state value
+ * @found_items: pointer on count of found items [out]
+ *
+ * This method tries to change the state of all tagged items.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE  - internal error.
+ */
+int ssdfs_sequence_array_change_all_states(struct ssdfs_sequence_array *ptr,
+					   int old_tag, int new_tag,
+					   ssdfs_change_item_state change_state,
+					   int old_state, int new_state,
+					   unsigned long *found_items)
+{
+	struct radix_tree_iter iter;
+	void **slot;
+	void *item_ptr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !change_state || !found_items);
+
+	SSDFS_DBG("array %p, "
+		  "old_tag %#x, new_tag %#x, "
+		  "old_state %#x, new_state %#x\n",
+		  ptr, old_tag, new_tag,
+		  old_state, new_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_items = 0;
+
+	rcu_read_lock();
+
+	spin_lock(&ptr->lock);
+	radix_tree_for_each_tagged(slot, &ptr->map, &iter, 0, old_tag) {
+		item_ptr = radix_tree_deref_slot(slot);
+		if (unlikely(!item_ptr)) {
+			SSDFS_WARN("empty item ptr: id %llu\n",
+				   (u64)iter.index);
+			radix_tree_tag_clear(&ptr->map, iter.index, old_tag);
+			continue;
+		}
+		spin_unlock(&ptr->lock);
+
+		rcu_read_unlock();
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("id %llu, item_ptr %p\n",
+			  (u64)iter.index, item_ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = change_state(item_ptr, old_state, new_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change state: "
+				  "id %llu, old_state %#x, "
+				  "new_state %#x, err %d\n",
+				  (u64)iter.index, old_state,
+				  new_state, err);
+			goto finish_change_all_states;
+		}
+
+		(*found_items)++;
+
+		rcu_read_lock();
+
+		spin_lock(&ptr->lock);
+		radix_tree_tag_set(&ptr->map, iter.index, new_tag);
+		radix_tree_tag_clear(&ptr->map, iter.index, old_tag);
+	}
+	spin_unlock(&ptr->lock);
+
+	rcu_read_unlock();
+
+finish_change_all_states:
+	if (*found_items == 0 || err) {
+		SSDFS_ERR("fail to change all items' state\n");
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * has_ssdfs_sequence_array_state() - check that any item is tagged
+ * @array: pointer on sequence array object
+ * @tag: checking tag
+ *
+ * This method tries to check that any item is tagged.
+ */
+bool has_ssdfs_sequence_array_state(struct ssdfs_sequence_array *array,
+				    int tag)
+{
+	bool res;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, tag %#x\n", array, tag);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&array->lock);
+	res = radix_tree_tagged(&array->map, tag);
+	spin_unlock(&array->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("res %#x\n", res);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return res;
+}
diff --git a/fs/ssdfs/sequence_array.h b/fs/ssdfs/sequence_array.h
new file mode 100644
index 000000000000..9a9c21e30cbe
--- /dev/null
+++ b/fs/ssdfs/sequence_array.h
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/sequence_array.h - sequence array's declarations.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_SEQUENCE_ARRAY_H
+#define _SSDFS_SEQUENCE_ARRAY_H
+
+#define SSDFS_SEQUENCE_ARRAY_INVALID_ID		ULONG_MAX
+
+#define SSDFS_SEQUENCE_ITEM_NO_TAG		0
+#define SSDFS_SEQUENCE_ITEM_DIRTY_TAG		1
+#define SSDFS_SEQUENCE_ITEM_UNDER_COMMIT_TAG	2
+#define SSDFS_SEQUENCE_ITEM_COMMITED_TAG	3
+
+/*
+ * struct ssdfs_sequence_array - sequence of pointers on items
+ * @revert_threshold: threshold of reverting the ID numbers' sequence
+ * @lock: exclusive lock
+ * @last_allocated_id: the latest ID was allocated
+ * @map: pointers' radix tree
+ *
+ * The sequence array is specialized structure that has goal
+ * to provide access to items via pointers on the basis of
+ * ID numbers. It means that every item has dedicated ID but
+ * sequence array could contain only some portion of existing
+ * items. Initialization phase has goal to add some limited
+ * number of existing items into the sequence array.
+ * The ID number could be reverted from some maximum number
+ * (threshold) to zero value.
+ */
+struct ssdfs_sequence_array {
+	unsigned long revert_threshold;
+
+	spinlock_t lock;
+	unsigned long last_allocated_id;
+	struct radix_tree_root map;
+};
+
+/* function prototype */
+typedef void (*ssdfs_free_item)(void *item);
+typedef int (*ssdfs_apply_action)(void *item);
+typedef int (*ssdfs_change_item_state)(void *item,
+					int old_state,
+					int new_state);
+
+/*
+ * Inline functions
+ */
+static inline
+unsigned long ssdfs_sequence_array_last_id(struct ssdfs_sequence_array *array)
+{
+	unsigned long last_id = ULONG_MAX;
+
+	spin_lock(&array->lock);
+	last_id = array->last_allocated_id;
+	spin_unlock(&array->lock);
+
+	return last_id;
+}
+
+static inline
+void ssdfs_sequence_array_set_last_id(struct ssdfs_sequence_array *array,
+				      unsigned long id)
+{
+	spin_lock(&array->lock);
+	array->last_allocated_id = id;
+	spin_unlock(&array->lock);
+}
+
+static inline
+bool is_ssdfs_sequence_array_last_id_invalid(struct ssdfs_sequence_array *ptr)
+{
+	bool is_invalid = false;
+
+	spin_lock(&ptr->lock);
+	is_invalid = ptr->last_allocated_id == SSDFS_SEQUENCE_ARRAY_INVALID_ID;
+	spin_unlock(&ptr->lock);
+
+	return is_invalid;
+}
+
+/*
+ * Sequence array API
+ */
+struct ssdfs_sequence_array *
+ssdfs_create_sequence_array(unsigned long revert_threshold);
+void ssdfs_destroy_sequence_array(struct ssdfs_sequence_array *array,
+				  ssdfs_free_item free_item);
+int ssdfs_sequence_array_init_item(struct ssdfs_sequence_array *array,
+				   unsigned long id, void *item);
+int ssdfs_sequence_array_add_item(struct ssdfs_sequence_array *array,
+				  void *item, unsigned long *id);
+void *ssdfs_sequence_array_get_item(struct ssdfs_sequence_array *array,
+				    unsigned long id);
+int ssdfs_sequence_array_apply_for_all(struct ssdfs_sequence_array *array,
+					ssdfs_apply_action apply_action);
+int ssdfs_sequence_array_change_state(struct ssdfs_sequence_array *array,
+					unsigned long id,
+					int old_tag, int new_tag,
+					ssdfs_change_item_state change_state,
+					int old_state, int new_state);
+int ssdfs_sequence_array_change_all_states(struct ssdfs_sequence_array *ptr,
+					   int old_tag, int new_tag,
+					   ssdfs_change_item_state change_state,
+					   int old_state, int new_state,
+					   unsigned long *found_items);
+bool has_ssdfs_sequence_array_state(struct ssdfs_sequence_array *array,
+				    int tag);
+
+#endif /* _SSDFS_SEQUENCE_ARRAY_H */
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BC6A2634
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjBYBQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjBYBQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:28 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614BF1352D
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:18 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bh20so791731oib.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca27sWt17j3FFyJHkHnFEHd8JprW5tG+cG5ZkZDqYsc=;
        b=g3sGp8Tr3usIxwp4B8KAUE1iAX7C3Qm0GLQMunWOouHtkUu4a8mMRRLEr7uetOP9DS
         9FnOIRKwrKBRWELjqG9gteW50mK6CH7iZBJrNmH0braIIBvlKktg+95AVmtVibHwwTOf
         CVtxBTROhT+2gNzeMMuhNlDnXMWicByrajOPrSNJhs5wLkLl40GcUhAqeM+pZ/vdtJCf
         sKQWNOisjIo3sd3G0kLsaYc9sDds9TfZ/S4sqxxyI8ePqAZI59FXn1D9EjSG0YMcWoWt
         TaYH5QU7RpXy+gWIVKjrBzAy4f5wxYewoILB3yT8OuDX0QDmykNhkgBRhFmD1cnUzgk3
         ufwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca27sWt17j3FFyJHkHnFEHd8JprW5tG+cG5ZkZDqYsc=;
        b=lHtAAehCwO56ih4LJq98OlggCNKdug26aRcG1bctcIYh7zoyp+2/kKEDUkybtsivgg
         u76w2qjhhnUvafe6+JER4VGAXY4hhd6BLvj6rxgJ7Ruz9mNHpv0eK8A1OwqzAK/LME2B
         aYKS/aIYZv/MTjuNkz7esyLZJkWooiBsxmtjFVI7ERcMquU6c0FVi+NG2P0o5Pg/JixD
         JpL9feSE/eWm0LjWTv41djT4LAlGBXHNppX93gth7o1RNSH2Jj+6Fr6i9u6WUpLMNiLy
         0BlbX8hcR+WcNh4S4x5gZBzrItNrRdvgZWTfsGjFN6A2o42I+ZLahEp7FYwWhfUYEtvj
         82Ew==
X-Gm-Message-State: AO0yUKXLalwT5k1Wom38JUOGuMVIAoVM+6eVTmWt097kZo35BPjCxf7V
        gTMfEKfG8KC0ZM3JlPIxu/S2bHp71z5BHt5n
X-Google-Smtp-Source: AK7set8mcnCkhQCbVUWThQoehvlOiRuGM9IOwNfe9RKfKzy+79IvGziF9ooyS7ZtccVP6xitRdeVIQ==
X-Received: by 2002:a05:6808:1494:b0:378:81e7:4ee2 with SMTP id e20-20020a056808149400b0037881e74ee2mr915652oiw.10.1677287776971;
        Fri, 24 Feb 2023 17:16:16 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:16 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 20/76] ssdfs: introduce PEB object
Date:   Fri, 24 Feb 2023 17:08:31 -0800
Message-Id: <20230225010927.813929-21-slava@dubeyko.com>
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

SSDFS splits a partition/volume on sequence of fixed-sized
segments. Every segment can include one or several Logical
Erase Blocks (LEB). LEB can be mapped into "Physical" Erase
Block (PEB). PEB represent concept of erase block or zone
that can be allocated, be filled by logs, and be erased.
PEB object keeps knowledge about PEB ID, index in segment,
and current log details.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/page_array.c | 1746 +++++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/page_array.h |  119 +++
 fs/ssdfs/peb.c        |  813 +++++++++++++++++++
 fs/ssdfs/peb.h        |  970 +++++++++++++++++++++++
 4 files changed, 3648 insertions(+)
 create mode 100644 fs/ssdfs/page_array.c
 create mode 100644 fs/ssdfs/page_array.h
 create mode 100644 fs/ssdfs/peb.c
 create mode 100644 fs/ssdfs/peb.h

diff --git a/fs/ssdfs/page_array.c b/fs/ssdfs/page_array.c
new file mode 100644
index 000000000000..38e9859efa45
--- /dev/null
+++ b/fs/ssdfs/page_array.c
@@ -0,0 +1,1746 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/page_array.c - page array object's functionality.
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
+#include "page_array.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_parray_page_leaks;
+atomic64_t ssdfs_parray_memory_leaks;
+atomic64_t ssdfs_parray_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_parray_cache_leaks_increment(void *kaddr)
+ * void ssdfs_parray_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_parray_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_parray_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_parray_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_parray_kfree(void *kaddr)
+ * struct page *ssdfs_parray_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_parray_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_parray_free_page(struct page *page)
+ * void ssdfs_parray_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(parray)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(parray)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_parray_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_parray_page_leaks, 0);
+	atomic64_set(&ssdfs_parray_memory_leaks, 0);
+	atomic64_set(&ssdfs_parray_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_parray_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_parray_page_leaks) != 0) {
+		SSDFS_ERR("PAGE ARRAY: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_parray_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_parray_memory_leaks) != 0) {
+		SSDFS_ERR("PAGE ARRAY: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_parray_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_parray_cache_leaks) != 0) {
+		SSDFS_ERR("PAGE ARRAY: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_parray_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_create_page_array() - create page array
+ * @capacity: maximum number of pages in the array
+ * @array: pointer of memory area for the array creation [out]
+ *
+ * This method tries to create the page array with @capacity
+ * of maximum number of pages in the array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+int ssdfs_create_page_array(int capacity, struct ssdfs_page_array *array)
+{
+	void *addr[SSDFS_PAGE_ARRAY_BMAP_COUNT];
+	size_t bmap_bytes;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+	BUG_ON(atomic_read(&array->state) != SSDFS_PAGE_ARRAY_UNKNOWN_STATE);
+
+	SSDFS_DBG("capacity %d, array %p\n",
+		  capacity, array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (capacity == 0) {
+		SSDFS_ERR("invalid capacity %d\n",
+			  capacity);
+		return -EINVAL;
+	}
+
+	init_rwsem(&array->lock);
+	atomic_set(&array->pages_capacity, capacity);
+	array->pages_count = 0;
+	array->last_page = SSDFS_PAGE_ARRAY_INVALID_LAST_PAGE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pages_count %lu, last_page %lu\n",
+		  array->pages_count, array->last_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	array->pages = ssdfs_parray_kcalloc(capacity, sizeof(struct page *),
+					    GFP_KERNEL);
+	if (!array->pages) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate memory: capacity %d\n",
+			  capacity);
+		goto finish_create_page_array;
+	}
+
+	bmap_bytes = capacity + BITS_PER_LONG;
+	bmap_bytes /= BITS_PER_BYTE;
+	array->bmap_bytes = bmap_bytes;
+
+	for (i = 0; i < SSDFS_PAGE_ARRAY_BMAP_COUNT; i++) {
+		spin_lock_init(&array->bmap[i].lock);
+		array->bmap[i].ptr = NULL;
+	}
+
+	for (i = 0; i < SSDFS_PAGE_ARRAY_BMAP_COUNT; i++) {
+		addr[i] = ssdfs_parray_kmalloc(bmap_bytes, GFP_KERNEL);
+
+		if (!addr[i]) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate bmap: index %d\n",
+				  i);
+			for (; i >= 0; i--)
+				ssdfs_parray_kfree(addr[i]);
+			goto free_page_array;
+		}
+
+		memset(addr[i], 0xFF, bmap_bytes);
+	}
+
+	down_write(&array->lock);
+	for (i = 0; i < SSDFS_PAGE_ARRAY_BMAP_COUNT; i++) {
+		spin_lock(&array->bmap[i].lock);
+		array->bmap[i].ptr = addr[i];
+		addr[i] = NULL;
+		spin_unlock(&array->bmap[i].lock);
+	}
+	up_write(&array->lock);
+
+	atomic_set(&array->state, SSDFS_PAGE_ARRAY_CREATED);
+
+	return 0;
+
+free_page_array:
+	ssdfs_parray_kfree(array->pages);
+	array->pages = NULL;
+
+finish_create_page_array:
+	return err;
+}
+
+/*
+ * ssdfs_destroy_page_array() - destroy page array
+ * @array: page array object
+ *
+ * This method tries to destroy the page array.
+ */
+void ssdfs_destroy_page_array(struct ssdfs_page_array *array)
+{
+	int state;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+	BUG_ON(rwsem_is_locked(&array->lock));
+
+	SSDFS_DBG("array %p, state %#x\n",
+		  array,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_page_array_release_all_pages(array);
+
+	state = atomic_xchg(&array->state, SSDFS_PAGE_ARRAY_UNKNOWN_STATE);
+
+	switch (state) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+		/* expected state */
+		break;
+
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		SSDFS_WARN("page array is dirty on destruction\n");
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			  state);
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pages_count %lu, last_page %lu\n",
+		  array->pages_count, array->last_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	atomic_set(&array->pages_capacity, 0);
+	array->pages_count = 0;
+	array->last_page = SSDFS_PAGE_ARRAY_INVALID_LAST_PAGE;
+
+	if (array->pages)
+		ssdfs_parray_kfree(array->pages);
+
+	array->pages = NULL;
+
+	array->bmap_bytes = 0;
+
+	for (i = 0; i < SSDFS_PAGE_ARRAY_BMAP_COUNT; i++) {
+		spin_lock(&array->bmap[i].lock);
+		if (array->bmap[i].ptr)
+			ssdfs_parray_kfree(array->bmap[i].ptr);
+		array->bmap[i].ptr = NULL;
+		spin_unlock(&array->bmap[i].lock);
+	}
+}
+
+/*
+ * ssdfs_reinit_page_array() - change the capacity of the page array
+ * @capacity: new value of the capacity
+ * @array: pointer of memory area for the array creation
+ *
+ * This method tries to change the capacity of the page array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_reinit_page_array(int capacity, struct ssdfs_page_array *array)
+{
+	struct page **pages;
+	void *addr[SSDFS_PAGE_ARRAY_BMAP_COUNT];
+	int old_capacity;
+	size_t bmap_bytes;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, capacity %d, state %#x\n",
+		  array, capacity,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&array->state)) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			  atomic_read(&array->state));
+		return -ERANGE;
+	}
+
+	down_write(&array->lock);
+
+	old_capacity = atomic_read(&array->pages_capacity);
+
+	if (capacity < old_capacity) {
+		err = -EINVAL;
+		SSDFS_ERR("unable to shrink: "
+			  "capacity %d, pages_capacity %d\n",
+			  capacity,
+			  old_capacity);
+		goto finish_reinit;
+	}
+
+	if (capacity == old_capacity) {
+		err = 0;
+		SSDFS_WARN("capacity %d == pages_capacity %d\n",
+			   capacity,
+			   old_capacity);
+		goto finish_reinit;
+	}
+
+	atomic_set(&array->pages_capacity, capacity);
+
+	pages = ssdfs_parray_kcalloc(capacity, sizeof(struct page *),
+				     GFP_KERNEL);
+	if (!pages) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate memory: capacity %d\n",
+			  capacity);
+		goto finish_reinit;
+	}
+
+	bmap_bytes = capacity + BITS_PER_LONG;
+	bmap_bytes /= BITS_PER_BYTE;
+
+	for (i = 0; i < SSDFS_PAGE_ARRAY_BMAP_COUNT; i++) {
+		addr[i] = ssdfs_parray_kmalloc(bmap_bytes, GFP_KERNEL);
+
+		if (!addr[i]) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate bmap: index %d\n",
+				  i);
+			for (; i >= 0; i--)
+				ssdfs_parray_kfree(addr[i]);
+			ssdfs_parray_kfree(pages);
+			goto finish_reinit;
+		}
+
+		memset(addr[i], 0xFF, bmap_bytes);
+	}
+
+	err = ssdfs_memcpy(pages,
+			   0, sizeof(struct page *) * capacity,
+			   array->pages,
+			   0, sizeof(struct page *) * old_capacity,
+			   sizeof(struct page *) * old_capacity);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		goto finish_reinit;
+	}
+
+	ssdfs_parray_kfree(array->pages);
+	array->pages = pages;
+
+	for (i = 0; i < SSDFS_PAGE_ARRAY_BMAP_COUNT; i++) {
+		void *tmp_addr = NULL;
+
+		spin_lock(&array->bmap[i].lock);
+		ssdfs_memcpy(addr[i], 0, bmap_bytes,
+			     array->bmap[i].ptr, 0, array->bmap_bytes,
+			     array->bmap_bytes);
+		tmp_addr = array->bmap[i].ptr;
+		array->bmap[i].ptr = addr[i];
+		addr[i] = NULL;
+		spin_unlock(&array->bmap[i].lock);
+
+		ssdfs_parray_kfree(tmp_addr);
+	}
+
+	array->bmap_bytes = bmap_bytes;
+
+finish_reinit:
+	if (unlikely(err))
+		atomic_set(&array->pages_capacity, old_capacity);
+
+	up_write(&array->lock);
+
+	return err;
+}
+
+/*
+ * is_ssdfs_page_array_empty() - is page array empty?
+ * @array: page array object
+ *
+ * This method tries to check that page array is empty.
+ */
+bool is_ssdfs_page_array_empty(struct ssdfs_page_array *array)
+{
+	bool is_empty = false;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&array->lock);
+	is_empty = array->pages_count == 0;
+	up_read(&array->lock);
+
+	return is_empty;
+}
+
+/*
+ * ssdfs_page_array_get_last_page_index() - get latest page index
+ * @array: page array object
+ *
+ * This method tries to get latest page index.
+ */
+unsigned long
+ssdfs_page_array_get_last_page_index(struct ssdfs_page_array *array)
+{
+	unsigned long index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&array->lock);
+	index = array->last_page;
+	up_read(&array->lock);
+
+	return index;
+}
+
+/*
+ * ssdfs_page_array_add_page() - add memory page into the page array
+ * @array: page array object
+ * @page: memory page
+ * @page_index: index of the page in the page array
+ *
+ * This method tries to add a page into the page array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - page array contains the page for the index.
+ */
+int ssdfs_page_array_add_page(struct ssdfs_page_array *array,
+			      struct page *page,
+			      unsigned long page_index)
+{
+	struct ssdfs_page_array_bitmap *bmap;
+	int capacity;
+	unsigned long found;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !page);
+
+	SSDFS_DBG("array %p, page %p, page_index %lu, state %#x\n",
+		  array, page, page_index,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&array->state)) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			  atomic_read(&array->state));
+		return -ERANGE;
+	}
+
+	capacity = atomic_read(&array->pages_capacity);
+
+	if (page_index >= capacity) {
+		SSDFS_ERR("page_index %lu >= pages_capacity %d\n",
+			  page_index,
+			  capacity);
+		return -EINVAL;
+	}
+
+	down_write(&array->lock);
+
+	capacity = atomic_read(&array->pages_capacity);
+
+	if (array->pages_count > capacity) {
+		err = -ERANGE;
+		SSDFS_ERR("corrupted page array: "
+			  "pages_count %lu, pages_capacity %d\n",
+			  array->pages_count,
+			  capacity);
+		goto finish_add_page;
+	}
+
+	if (array->pages_count == capacity) {
+		err = -EEXIST;
+		SSDFS_ERR("page %lu is allocated already\n",
+			  page_index);
+		goto finish_add_page;
+	}
+
+	bmap = &array->bmap[SSDFS_PAGE_ARRAY_ALLOC_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("bitmap is empty\n");
+		goto finish_add_page;
+	}
+
+	spin_lock(&bmap->lock);
+	found = bitmap_find_next_zero_area(bmap->ptr, capacity,
+					   page_index, 1, 0);
+	if (found == page_index) {
+		/* page is allocated already */
+		err = -EEXIST;
+	} else
+		bitmap_clear(bmap->ptr, page_index, 1);
+	spin_unlock(&bmap->lock);
+
+	if (err) {
+		SSDFS_ERR("page %lu is allocated already\n",
+			  page_index);
+		goto finish_add_page;
+	}
+
+	if (array->pages[page_index]) {
+		err = -ERANGE;
+		SSDFS_WARN("position %lu contains page pointer\n",
+			   page_index);
+		goto finish_add_page;
+	} else {
+		ssdfs_get_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		array->pages[page_index] = page;
+		page->index = page_index;
+	}
+
+	ssdfs_parray_account_page(page);
+	array->pages_count++;
+
+	if (array->last_page >= SSDFS_PAGE_ARRAY_INVALID_LAST_PAGE)
+		array->last_page = page_index;
+	else if (array->last_page < page_index)
+		array->last_page = page_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pages_count %lu, last_page %lu\n",
+		  array->pages_count, array->last_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_add_page:
+	up_write(&array->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_page_array_allocate_page_locked() - allocate and add page
+ * @array: page array object
+ * @page_index: index of the page in the page array
+ *
+ * This method tries to allocate, to add into the page array and
+ * to lock page.
+ *
+ * RETURN:
+ * [success] - pointer on allocated and locked page.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - unable to allocate memory page.
+ * %-EEXIST     - page array contains the page for the index.
+ */
+struct page *
+ssdfs_page_array_allocate_page_locked(struct ssdfs_page_array *array,
+				      unsigned long page_index)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, page_index %lu, state %#x\n",
+		  array, page_index,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&array->state)) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			  atomic_read(&array->state));
+		return ERR_PTR(-ERANGE);
+	}
+
+	page = ssdfs_parray_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		return ERR_PTR(err);
+	}
+
+	/*
+	 * The ssdfs_page_array_add_page() calls
+	 * ssdfs_parray_account_page(). It needs to exclude
+	 * the improper leaks accounting.
+	 */
+	ssdfs_parray_forget_page(page);
+
+	err = ssdfs_page_array_add_page(array, page, page_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add page: "
+			  "page_index %lu, err %d\n",
+			  page_index, err);
+		ssdfs_parray_free_page(page);
+		return ERR_PTR(err);
+	}
+
+	ssdfs_lock_page(page);
+	return page;
+}
+
+/*
+ * ssdfs_page_array_get_page() - get page unlocked
+ * @array: page array object
+ * @page_index: index of the page in the page array
+ *
+ * This method tries to find a page into the page array.
+ *
+ * RETURN:
+ * [success] - pointer on page.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - no allocated page for the requested index.
+ */
+struct page *ssdfs_page_array_get_page(struct ssdfs_page_array *array,
+					unsigned long page_index)
+{
+	struct page *page;
+	struct ssdfs_page_array_bitmap *bmap;
+	int capacity;
+	unsigned long found;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, page_index %lu, state %#x\n",
+		  array, page_index,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&array->state)) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			  atomic_read(&array->state));
+		return ERR_PTR(-ERANGE);
+	}
+
+	capacity = atomic_read(&array->pages_capacity);
+
+	if (page_index >= capacity) {
+		SSDFS_ERR("page_index %lu >= pages_capacity %d\n",
+			  page_index,
+			  capacity);
+		return ERR_PTR(-EINVAL);
+	}
+
+	down_read(&array->lock);
+
+	bmap = &array->bmap[SSDFS_PAGE_ARRAY_ALLOC_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("bitmap is empty\n");
+		goto finish_get_page;
+	}
+
+	spin_lock(&bmap->lock);
+	found = bitmap_find_next_zero_area(bmap->ptr, capacity,
+					   page_index, 1, 0);
+	if (found != page_index) {
+		/* page is not allocated yet */
+		err = -ENOENT;
+	}
+	spin_unlock(&bmap->lock);
+
+	if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %lu is not allocated yet\n",
+			  page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_get_page;
+	}
+
+	page = array->pages[page_index];
+
+	if (!page) {
+		err = -ERANGE;
+		SSDFS_ERR("page pointer is NULL\n");
+		goto finish_get_page;
+	}
+
+finish_get_page:
+	up_read(&array->lock);
+
+	if (unlikely(err))
+		return ERR_PTR(err);
+
+	ssdfs_get_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return page;
+}
+
+/*
+ * ssdfs_page_array_get_page_locked() - get page locked
+ * @array: page array object
+ * @page_index: index of the page in the page array
+ *
+ * This method tries to find and to lock a page into the
+ * page array.
+ *
+ * RETURN:
+ * [success] - pointer on locked page.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - no allocated page for the requested index.
+ */
+struct page *ssdfs_page_array_get_page_locked(struct ssdfs_page_array *array,
+					      unsigned long page_index)
+{
+	struct page *page;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, page_index %lu, state %#x\n",
+		  array, page_index,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_page_array_get_page(array, page_index);
+	if (PTR_ERR(page) == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %lu is not allocated yet\n",
+			  page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (IS_ERR_OR_NULL(page)) {
+		SSDFS_ERR("fail to get the page: "
+			  "page_index %lu, err %d\n",
+			  page_index, (int)PTR_ERR(page));
+	} else
+		ssdfs_lock_page(page);
+
+	return page;
+}
+
+/*
+ * ssdfs_page_array_grab_page() - get or add page locked
+ * @array: page array object
+ * @page_index: index of the page in the page array
+ *
+ * This method tries to find and to lock a page into the
+ * page array. If no such page then to add and to lock
+ * the page.
+ *
+ * RETURN:
+ * [success] - pointer on locked page.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to add the page.
+ */
+struct page *ssdfs_page_array_grab_page(struct ssdfs_page_array *array,
+					unsigned long page_index)
+{
+	struct page *page = ERR_PTR(-ENOMEM);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, page_index %lu, state %#x\n",
+		  array, page_index,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_page_array_get_page_locked(array, page_index);
+	if (PTR_ERR(page) == -ENOENT) {
+		page = ssdfs_page_array_allocate_page_locked(array,
+							     page_index);
+		if (IS_ERR_OR_NULL(page)) {
+			if (!page)
+				page = ERR_PTR(-ENOMEM);
+
+			SSDFS_ERR("fail to allocate the page: "
+				  "page_index %lu, err %d\n",
+				  page_index, (int)PTR_ERR(page));
+		} else {
+			ssdfs_get_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	} else if (IS_ERR_OR_NULL(page)) {
+		if (!page)
+			page = ERR_PTR(-ENOMEM);
+
+		SSDFS_ERR("fail to get page: "
+			  "page_index %lu, err %d\n",
+			  page_index, (int)PTR_ERR(page));
+	}
+
+	return page;
+}
+
+/*
+ * ssdfs_page_array_set_page_dirty() - set page dirty
+ * @array: page array object
+ * @page_index: index of the page in the page array
+ *
+ * This method tries to set page as dirty in the page array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - no allocated page for the requested index.
+ */
+int ssdfs_page_array_set_page_dirty(struct ssdfs_page_array *array,
+				    unsigned long page_index)
+{
+	struct page *page;
+	struct ssdfs_page_array_bitmap *bmap;
+	int capacity;
+	unsigned long found;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, page_index %lu, state %#x\n",
+		  array, page_index,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&array->state)) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			  atomic_read(&array->state));
+		return -ERANGE;
+	}
+
+	capacity = atomic_read(&array->pages_capacity);
+
+	if (page_index >= capacity) {
+		SSDFS_ERR("page_index %lu >= pages_capacity %d\n",
+			  page_index,
+			  capacity);
+		return -EINVAL;
+	}
+
+	down_read(&array->lock);
+
+	bmap = &array->bmap[SSDFS_PAGE_ARRAY_ALLOC_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("allocation bitmap is empty\n");
+		goto finish_set_page_dirty;
+	}
+
+	spin_lock(&bmap->lock);
+	found = bitmap_find_next_zero_area(bmap->ptr, capacity,
+					   page_index, 1, 0);
+	if (found != page_index) {
+		/* page is not allocated yet */
+		err = -ENOENT;
+	}
+	spin_unlock(&bmap->lock);
+
+	if (err) {
+		SSDFS_ERR("page %lu is not allocated yet\n",
+			  page_index);
+		goto finish_set_page_dirty;
+	}
+
+	bmap = &array->bmap[SSDFS_PAGE_ARRAY_DIRTY_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("dirty bitmap is empty\n");
+		goto finish_set_page_dirty;
+	}
+
+	spin_lock(&bmap->lock);
+	found = bitmap_find_next_zero_area(bmap->ptr, capacity,
+					   page_index, 1, 0);
+	if (found == page_index) {
+		/* page is dirty already */
+		err = -EEXIST;
+	}
+	bitmap_clear(bmap->ptr, page_index, 1);
+	spin_unlock(&bmap->lock);
+
+	if (err) {
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %lu is dirty already\n",
+			  page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	page = array->pages[page_index];
+
+	if (!page) {
+		err = -ERANGE;
+		SSDFS_ERR("page pointer is NULL\n");
+		goto finish_set_page_dirty;
+	}
+
+	SetPageDirty(page);
+
+	atomic_set(&array->state, SSDFS_PAGE_ARRAY_DIRTY);
+
+finish_set_page_dirty:
+	up_read(&array->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_page_array_clear_dirty_page() - set page as clean
+ * @array: page array object
+ * @page_index: index of the page in the page array
+ *
+ * This method tries to set page as clean in the page array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - no allocated page for the requested index.
+ */
+int ssdfs_page_array_clear_dirty_page(struct ssdfs_page_array *array,
+				      unsigned long page_index)
+{
+	struct page *page;
+	struct ssdfs_page_array_bitmap *bmap;
+	int capacity;
+	unsigned long found;
+	bool is_clean = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, page_index %lu, state %#x\n",
+		  array, page_index,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&array->state)) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			  atomic_read(&array->state));
+		return -ERANGE;
+	}
+
+	capacity = atomic_read(&array->pages_capacity);
+
+	if (page_index >= capacity) {
+		SSDFS_ERR("page_index %lu >= pages_capacity %d\n",
+			  page_index,
+			  capacity);
+		return -EINVAL;
+	}
+
+	down_read(&array->lock);
+
+	bmap = &array->bmap[SSDFS_PAGE_ARRAY_ALLOC_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("allocation bitmap is empty\n");
+		goto finish_clear_page_dirty;
+	}
+
+	spin_lock(&bmap->lock);
+	found = bitmap_find_next_zero_area(bmap->ptr, capacity,
+					   page_index, 1, 0);
+	if (found != page_index) {
+		/* page is not allocated yet */
+		err = -ENOENT;
+	}
+	spin_unlock(&bmap->lock);
+
+	if (err) {
+		SSDFS_ERR("page %lu is not allocated yet\n",
+			  page_index);
+		goto finish_clear_page_dirty;
+	}
+
+	bmap = &array->bmap[SSDFS_PAGE_ARRAY_DIRTY_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("dirty bitmap is empty\n");
+		goto finish_clear_page_dirty;
+	}
+
+	spin_lock(&bmap->lock);
+	bitmap_set(bmap->ptr, page_index, 1);
+	is_clean = bitmap_full(bmap->ptr, capacity);
+	spin_unlock(&bmap->lock);
+
+	page = array->pages[page_index];
+
+	if (!page) {
+		err = -ERANGE;
+		SSDFS_ERR("page pointer is NULL\n");
+		goto finish_clear_page_dirty;
+	}
+
+	ClearPageDirty(page);
+
+	if (is_clean)
+		atomic_set(&array->state, SSDFS_PAGE_ARRAY_CREATED);
+
+finish_clear_page_dirty:
+	up_read(&array->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_page_array_clear_dirty_range() - clear dirty pages in the range
+ * @array: page array object
+ * @start: starting index
+ * @end: ending index (inclusive)
+ *
+ * This method tries to set the range's dirty pages as clean
+ * in the page array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_page_array_clear_dirty_range(struct ssdfs_page_array *array,
+					unsigned long start,
+					unsigned long end)
+{
+	struct page *page;
+	struct ssdfs_page_array_bitmap *bmap;
+	int capacity;
+	bool is_clean = false;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, start %lu, end %lu, state %#x\n",
+		  array, start, end,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&array->state)) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+		SSDFS_DBG("no dirty pages in page array\n");
+		return 0;
+
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			  atomic_read(&array->state));
+		return -ERANGE;
+	}
+
+	if (start > end) {
+		SSDFS_ERR("start %lu > end %lu\n",
+			  start, end);
+		return -EINVAL;
+	}
+
+	down_write(&array->lock);
+
+	capacity = atomic_read(&array->pages_capacity);
+
+	bmap = &array->bmap[SSDFS_PAGE_ARRAY_DIRTY_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("dirty bitmap is empty\n");
+		goto finish_clear_dirty_pages;
+	}
+
+	end = min_t(int, capacity, end + 1);
+
+	for (i = start; i < end; i++) {
+		page = array->pages[i];
+
+		if (page)
+			ClearPageDirty(page);
+	}
+
+	spin_lock(&bmap->lock);
+	bitmap_set(bmap->ptr, start, end - start);
+	is_clean = bitmap_full(bmap->ptr, capacity);
+	spin_unlock(&bmap->lock);
+
+	if (is_clean)
+		atomic_set(&array->state, SSDFS_PAGE_ARRAY_CREATED);
+
+finish_clear_dirty_pages:
+	up_write(&array->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_page_array_clear_all_dirty_pages() - clear all dirty pages
+ * @array: page array object
+ *
+ * This method tries to set all dirty pages as clean in the page array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_page_array_clear_all_dirty_pages(struct ssdfs_page_array *array)
+{
+	int capacity;
+	unsigned long start = 0, end = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, state %#x\n",
+		  array,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	capacity = atomic_read(&array->pages_capacity);
+
+	if (capacity > 0)
+		end = capacity - 1;
+
+	return ssdfs_page_array_clear_dirty_range(array, start, end);
+}
+
+/*
+ * ssdfs_page_array_lookup_range() - find pages for a requested tag
+ * @array: page array object
+ * @start: pointer on start index value [in|out]
+ * @end: ending index (inclusive)
+ * @tag: tag value for the search
+ * @max_pages: maximum number of pages in the pagevec
+ * @pvec: pagevec for storing found pages [out]
+ *
+ * This method tries to find pages in the page array for
+ * the requested tag.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - nothing was found for the requested tag.
+ */
+int ssdfs_page_array_lookup_range(struct ssdfs_page_array *array,
+				  unsigned long *start,
+				  unsigned long end,
+				  int tag, int max_pages,
+				  struct pagevec *pvec)
+{
+	int state;
+	struct page *page;
+	struct ssdfs_page_array_bitmap *bmap;
+	int capacity;
+	unsigned long found;
+	int count = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !start || !pvec);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&array->state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("array %p, start %lu, end %lu, "
+		  "tag %#x, max_pages %d, state %#x\n",
+		  array, *start, end, tag, max_pages, state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (state) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			   state);
+		return -ERANGE;
+	}
+
+	pagevec_reinit(pvec);
+
+	if (*start > end) {
+		SSDFS_ERR("start %lu > end %lu\n",
+			  *start, end);
+		return -EINVAL;
+	}
+
+	switch (tag) {
+	case SSDFS_DIRTY_PAGE_TAG:
+		if (state != SSDFS_PAGE_ARRAY_DIRTY) {
+			SSDFS_DBG("page array is clean\n");
+			return -ENOENT;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("unknown tag %#x\n",
+			  tag);
+		return -EINVAL;
+	}
+
+	max_pages = min_t(int, max_pages, (int)PAGEVEC_SIZE);
+
+	down_read(&array->lock);
+
+	capacity = atomic_read(&array->pages_capacity);
+	if (capacity <= 0) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid capacity %d\n", capacity);
+		goto finish_search;
+	}
+
+	bmap = &array->bmap[SSDFS_PAGE_ARRAY_DIRTY_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("dirty bitmap is empty\n");
+		goto finish_search;
+	}
+
+	end = min_t(int, capacity - 1, end);
+
+	spin_lock(&bmap->lock);
+	found = bitmap_find_next_zero_area(bmap->ptr, capacity,
+					   *start, 1, 0);
+	spin_unlock(&bmap->lock);
+
+	*start = (int)found;
+
+	while (found <= end) {
+		page = array->pages[found];
+
+		if (page) {
+			if (!PageDirty(page)) {
+				SSDFS_ERR("page %lu is not dirty\n",
+					  page_index(page));
+			}
+			ssdfs_get_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			pagevec_add(pvec, page);
+			count++;
+		}
+
+		if (count >= max_pages)
+			goto finish_search;
+
+		found++;
+
+		if (found >= capacity)
+			break;
+
+		spin_lock(&bmap->lock);
+		found = bitmap_find_next_zero_area(bmap->ptr, capacity,
+						   found, 1, 0);
+		spin_unlock(&bmap->lock);
+	};
+
+finish_search:
+	up_read(&array->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_page_array_define_last_page() - define last page index
+ * @array: page array object
+ * @capacity: pages capacity in array
+ *
+ * This method tries to define last page index.
+ */
+static inline
+void ssdfs_page_array_define_last_page(struct ssdfs_page_array *array,
+					int capacity)
+{
+	struct ssdfs_page_array_bitmap *alloc_bmap;
+	unsigned long *ptr;
+	unsigned long found;
+	unsigned long i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+	BUG_ON(!rwsem_is_locked(&array->lock));
+
+	SSDFS_DBG("array %p, state %#x\n",
+		  array, atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	alloc_bmap = &array->bmap[SSDFS_PAGE_ARRAY_ALLOC_BMAP];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!alloc_bmap->ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (array->pages_count == 0) {
+		/* empty array */
+		array->last_page = SSDFS_PAGE_ARRAY_INVALID_LAST_PAGE;
+	} else if (array->last_page >= SSDFS_PAGE_ARRAY_INVALID_LAST_PAGE) {
+		/* do nothing */
+	} else if (array->last_page > 0) {
+		for (i = array->last_page; i > array->pages_count; i--) {
+			spin_lock(&alloc_bmap->lock);
+			ptr = alloc_bmap->ptr;
+			found = bitmap_find_next_zero_area(ptr,
+							   capacity,
+							   i, 1, 0);
+			spin_unlock(&alloc_bmap->lock);
+
+			if (found == i)
+				break;
+		}
+
+		array->last_page = i;
+	} else
+		array->last_page = SSDFS_PAGE_ARRAY_INVALID_LAST_PAGE;
+}
+
+/*
+ * ssdfs_page_array_delete_page() - delete page from the page array
+ * @array: page array object
+ * @page_index: index of the page
+ *
+ * This method tries to delete a page from the page array.
+ *
+ * RETURN:
+ * [success] - pointer on deleted page.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - page array hasn't a page for the index.
+ */
+struct page *ssdfs_page_array_delete_page(struct ssdfs_page_array *array,
+					  unsigned long page_index)
+{
+	struct page *page;
+	struct ssdfs_page_array_bitmap *alloc_bmap, *dirty_bmap;
+	int capacity;
+	unsigned long found;
+	bool is_clean = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, page_index %lu, state %#x\n",
+		  array, page_index,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&array->state)) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			  atomic_read(&array->state));
+		return ERR_PTR(-ERANGE);
+	}
+
+	capacity = atomic_read(&array->pages_capacity);
+
+	if (page_index >= capacity) {
+		SSDFS_ERR("page_index %lu >= pages_capacity %d\n",
+			  page_index,
+			  capacity);
+		return ERR_PTR(-EINVAL);
+	}
+
+	down_write(&array->lock);
+
+	alloc_bmap = &array->bmap[SSDFS_PAGE_ARRAY_ALLOC_BMAP];
+	if (!alloc_bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("alloc bitmap is empty\n");
+		goto finish_delete_page;
+	}
+
+	dirty_bmap = &array->bmap[SSDFS_PAGE_ARRAY_DIRTY_BMAP];
+	if (!dirty_bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("dirty bitmap is empty\n");
+		goto finish_delete_page;
+	}
+
+	spin_lock(&alloc_bmap->lock);
+	found = bitmap_find_next_zero_area(alloc_bmap->ptr, capacity,
+					   page_index, 1, 0);
+	if (found != page_index) {
+		/* page is not allocated yet */
+		err = -ENOENT;
+	}
+	spin_unlock(&alloc_bmap->lock);
+
+	if (err) {
+		SSDFS_ERR("page %lu is not allocated yet\n",
+			  page_index);
+		goto finish_delete_page;
+	}
+
+	page = array->pages[page_index];
+
+	if (!page) {
+		err = -ERANGE;
+		SSDFS_ERR("page pointer is NULL\n");
+		goto finish_delete_page;
+	}
+
+	spin_lock(&alloc_bmap->lock);
+	bitmap_set(alloc_bmap->ptr, page_index, 1);
+	spin_unlock(&alloc_bmap->lock);
+
+	spin_lock(&dirty_bmap->lock);
+	bitmap_set(dirty_bmap->ptr, page_index, 1);
+	is_clean = bitmap_full(dirty_bmap->ptr, capacity);
+	spin_unlock(&dirty_bmap->lock);
+
+	array->pages_count--;
+	array->pages[page_index] = NULL;
+
+	if (array->last_page == page_index)
+		ssdfs_page_array_define_last_page(array, capacity);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pages_count %lu, last_page %lu\n",
+		  array->pages_count, array->last_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_clean)
+		atomic_set(&array->state, SSDFS_PAGE_ARRAY_CREATED);
+
+finish_delete_page:
+	up_write(&array->lock);
+
+	if (unlikely(err))
+		return ERR_PTR(err);
+
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_parray_forget_page(page);
+
+	return page;
+}
+
+/*
+ * ssdfs_page_array_release_pages() - release pages in the range
+ * @array: page array object
+ * @start: pointer on start index value [in|out]
+ * @end: ending index (inclusive)
+ *
+ * This method tries to release pages for the requested range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_page_array_release_pages(struct ssdfs_page_array *array,
+				   unsigned long *start,
+				   unsigned long end)
+{
+	struct page *page;
+	struct ssdfs_page_array_bitmap *alloc_bmap, *dirty_bmap;
+	int capacity;
+	unsigned long found, found_dirty;
+#ifdef CONFIG_SSDFS_DEBUG
+	unsigned long released = 0;
+	unsigned long allocated_pages = 0;
+	unsigned long dirty_pages = 0;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !start);
+
+	SSDFS_DBG("array %p, start %lu, end %lu, state %#x\n",
+		  array, *start, end,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&array->state)) {
+	case SSDFS_PAGE_ARRAY_CREATED:
+	case SSDFS_PAGE_ARRAY_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x of page array\n",
+			   atomic_read(&array->state));
+		return -ERANGE;
+	}
+
+	if (*start > end) {
+		SSDFS_ERR("start %lu > end %lu\n",
+			  *start, end);
+		return -EINVAL;
+	}
+
+	down_write(&array->lock);
+
+	capacity = atomic_read(&array->pages_capacity);
+	if (capacity <= 0) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid capacity %d\n", capacity);
+		goto finish_release_pages_range;
+	}
+
+	if (array->pages_count == 0) {
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("pages_count %lu\n",
+			  array->pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_release_pages_range;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	released = array->pages_count;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	alloc_bmap = &array->bmap[SSDFS_PAGE_ARRAY_ALLOC_BMAP];
+	if (!alloc_bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("allocation bitmap is empty\n");
+		goto finish_release_pages_range;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	spin_lock(&alloc_bmap->lock);
+	allocated_pages = bitmap_weight(alloc_bmap->ptr, capacity);
+	spin_unlock(&alloc_bmap->lock);
+	allocated_pages = capacity - allocated_pages;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	dirty_bmap = &array->bmap[SSDFS_PAGE_ARRAY_DIRTY_BMAP];
+	if (!dirty_bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("dirty bitmap is empty\n");
+		goto finish_release_pages_range;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	spin_lock(&dirty_bmap->lock);
+	dirty_pages = bitmap_weight(dirty_bmap->ptr, capacity);
+	spin_unlock(&dirty_bmap->lock);
+	dirty_pages = capacity - dirty_pages;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&alloc_bmap->lock);
+	found = bitmap_find_next_zero_area(alloc_bmap->ptr, capacity,
+					   *start, 1, 0);
+	spin_unlock(&alloc_bmap->lock);
+
+	end = min_t(int, capacity - 1, end);
+
+	*start = found;
+
+	while (found <= end) {
+		spin_lock(&dirty_bmap->lock);
+		found_dirty = bitmap_find_next_zero_area(dirty_bmap->ptr,
+							 capacity,
+						         found, 1, 0);
+		spin_unlock(&dirty_bmap->lock);
+
+		if (found == found_dirty) {
+			err = -ERANGE;
+			SSDFS_ERR("page %lu is dirty\n",
+				  found);
+			goto finish_release_pages_range;
+		}
+
+		page = array->pages[found];
+
+		if (page) {
+			ssdfs_lock_page(page);
+			ClearPageUptodate(page);
+			ssdfs_clear_page_private(page, 0);
+			ssdfs_unlock_page(page);
+
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_parray_free_page(page);
+			array->pages[found] = NULL;
+		}
+
+		spin_lock(&alloc_bmap->lock);
+		bitmap_set(alloc_bmap->ptr, found, 1);
+		spin_unlock(&alloc_bmap->lock);
+
+		array->pages_count--;
+
+		found++;
+
+		if (found >= capacity)
+			break;
+
+		spin_lock(&alloc_bmap->lock);
+		found = bitmap_find_next_zero_area(alloc_bmap->ptr,
+						   capacity,
+						   found, 1, 0);
+		spin_unlock(&alloc_bmap->lock);
+	};
+
+	ssdfs_page_array_define_last_page(array, capacity);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pages_count %lu, last_page %lu\n",
+		  array->pages_count, array->last_page);
+
+	released -= array->pages_count;
+
+	SSDFS_DBG("released %lu, pages_count %lu, "
+		  "allocated_pages %lu, dirty_pages %lu\n",
+		  released, array->pages_count,
+		  allocated_pages, dirty_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_release_pages_range:
+	up_write(&array->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_page_array_release_all_pages() - release all pages
+ * @array: page array object
+ *
+ * This method tries to release all pages in the page array.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_page_array_release_all_pages(struct ssdfs_page_array *array)
+{
+	int capacity;
+	unsigned long start = 0, end = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array);
+
+	SSDFS_DBG("array %p, state %#x\n",
+		  array,
+		  atomic_read(&array->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	capacity = atomic_read(&array->pages_capacity);
+
+	if (capacity > 0)
+		end = capacity - 1;
+
+	return ssdfs_page_array_release_pages(array, &start, end);
+}
diff --git a/fs/ssdfs/page_array.h b/fs/ssdfs/page_array.h
new file mode 100644
index 000000000000..020190bceaf9
--- /dev/null
+++ b/fs/ssdfs/page_array.h
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/page_array.h - page array object declarations.
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
+#ifndef _SSDFS_PAGE_ARRAY_H
+#define _SSDFS_PAGE_ARRAY_H
+
+/*
+ * struct ssdfs_page_array_bitmap - bitmap of states
+ * @lock: bitmap lock
+ * @ptr: bitmap
+ */
+struct ssdfs_page_array_bitmap {
+	spinlock_t lock;
+	unsigned long *ptr;
+};
+
+/*
+ * struct ssdfs_page_array - array of memory pages
+ * @state: page array's state
+ * @pages_capacity: maximum possible number of pages in array
+ * @lock: page array's lock
+ * @pages: array of memory pages' pointers
+ * @pages_count: current number of allocated pages
+ * @last_page: latest page index
+ * @bmap_bytes: number of bytes in every bitmap
+ * bmap: array of bitmaps
+ */
+struct ssdfs_page_array {
+	atomic_t state;
+	atomic_t pages_capacity;
+
+	struct rw_semaphore lock;
+	struct page **pages;
+	unsigned long pages_count;
+#define SSDFS_PAGE_ARRAY_INVALID_LAST_PAGE	(ULONG_MAX)
+	unsigned long last_page;
+	size_t bmap_bytes;
+
+#define SSDFS_PAGE_ARRAY_ALLOC_BMAP		(0)
+#define SSDFS_PAGE_ARRAY_DIRTY_BMAP		(1)
+#define SSDFS_PAGE_ARRAY_BMAP_COUNT		(2)
+	struct ssdfs_page_array_bitmap bmap[SSDFS_PAGE_ARRAY_BMAP_COUNT];
+};
+
+/* Page array states */
+enum {
+	SSDFS_PAGE_ARRAY_UNKNOWN_STATE,
+	SSDFS_PAGE_ARRAY_CREATED,
+	SSDFS_PAGE_ARRAY_DIRTY,
+	SSDFS_PAGE_ARRAY_STATE_MAX
+};
+
+/* Available tags */
+enum {
+	SSDFS_UNKNOWN_PAGE_TAG,
+	SSDFS_DIRTY_PAGE_TAG,
+	SSDFS_PAGE_TAG_MAX
+};
+
+/*
+ * Page array's API
+ */
+int ssdfs_create_page_array(int capacity, struct ssdfs_page_array *array);
+void ssdfs_destroy_page_array(struct ssdfs_page_array *array);
+int ssdfs_reinit_page_array(int capacity, struct ssdfs_page_array *array);
+bool is_ssdfs_page_array_empty(struct ssdfs_page_array *array);
+unsigned long
+ssdfs_page_array_get_last_page_index(struct ssdfs_page_array *array);
+int ssdfs_page_array_add_page(struct ssdfs_page_array *array,
+			      struct page *page,
+			      unsigned long page_index);
+struct page *
+ssdfs_page_array_allocate_page_locked(struct ssdfs_page_array *array,
+				      unsigned long page_index);
+struct page *ssdfs_page_array_get_page_locked(struct ssdfs_page_array *array,
+					      unsigned long page_index);
+struct page *ssdfs_page_array_get_page(struct ssdfs_page_array *array,
+					unsigned long page_index);
+struct page *ssdfs_page_array_grab_page(struct ssdfs_page_array *array,
+					unsigned long page_index);
+int ssdfs_page_array_set_page_dirty(struct ssdfs_page_array *array,
+				    unsigned long page_index);
+int ssdfs_page_array_clear_dirty_page(struct ssdfs_page_array *array,
+				      unsigned long page_index);
+int ssdfs_page_array_clear_dirty_range(struct ssdfs_page_array *array,
+					unsigned long start,
+					unsigned long end);
+int ssdfs_page_array_clear_all_dirty_pages(struct ssdfs_page_array *array);
+int ssdfs_page_array_lookup_range(struct ssdfs_page_array *array,
+				  unsigned long *start,
+				  unsigned long end,
+				  int tag, int max_pages,
+				  struct pagevec *pvec);
+struct page *ssdfs_page_array_delete_page(struct ssdfs_page_array *array,
+					  unsigned long page_index);
+int ssdfs_page_array_release_pages(struct ssdfs_page_array *array,
+				   unsigned long *start,
+				   unsigned long end);
+int ssdfs_page_array_release_all_pages(struct ssdfs_page_array *array);
+
+#endif /* _SSDFS_PAGE_ARRAY_H */
diff --git a/fs/ssdfs/peb.c b/fs/ssdfs/peb.c
new file mode 100644
index 000000000000..9f95ef176744
--- /dev/null
+++ b/fs/ssdfs/peb.c
@@ -0,0 +1,813 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb.c - Physical Erase Block (PEB) object's functionality.
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
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/kthread.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "compression.h"
+#include "page_vector.h"
+#include "block_bitmap.h"
+#include "segment_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "peb.h"
+#include "peb_container.h"
+#include "segment.h"
+#include "peb_mapping_table.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_peb_page_leaks;
+atomic64_t ssdfs_peb_memory_leaks;
+atomic64_t ssdfs_peb_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_peb_cache_leaks_increment(void *kaddr)
+ * void ssdfs_peb_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_peb_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_peb_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_peb_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_peb_kfree(void *kaddr)
+ * struct page *ssdfs_peb_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_peb_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_peb_free_page(struct page *page)
+ * void ssdfs_peb_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(peb)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(peb)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_peb_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_peb_page_leaks, 0);
+	atomic64_set(&ssdfs_peb_memory_leaks, 0);
+	atomic64_set(&ssdfs_peb_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_peb_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_peb_page_leaks) != 0) {
+		SSDFS_ERR("PEB: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_peb_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_peb_memory_leaks) != 0) {
+		SSDFS_ERR("PEB: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_peb_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_peb_cache_leaks) != 0) {
+		SSDFS_ERR("PEB: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_peb_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_create_clean_peb_object() - create "clean" PEB object
+ * @pebi: pointer on unitialized PEB object
+ *
+ * This function tries to initialize PEB object for "clean"
+ * state of the segment.
+ *
+ * RETURN:
+ * [success] - PEB object has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+static
+int ssdfs_create_clean_peb_object(struct ssdfs_peb_info *pebi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(pebi->peb_id == U64_MAX);
+
+	SSDFS_DBG("pebi %p, peb_id %llu\n",
+		  pebi, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_peb_current_log_init(pebi, pebi->log_pages, 0, 0, U32_MAX);
+
+	return 0;
+}
+
+/*
+ * ssdfs_create_using_peb_object() - create "using" PEB object
+ * @pebi: pointer on unitialized PEB object
+ *
+ * This function tries to initialize PEB object for "using"
+ * state of the segment.
+ *
+ * RETURN:
+ * [success] - PEB object has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_create_using_peb_object(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_fs_info *fsi;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(pebi->peb_id == U64_MAX);
+
+	SSDFS_DBG("pebi %p, peb_id %llu\n",
+		  pebi, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (fsi->is_zns_device) {
+		loff_t offset = pebi->peb_id * fsi->erasesize;
+
+		err = fsi->devops->reopen_zone(fsi->sb, offset);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to reopen zone: "
+				  "offset %llu, err %d\n",
+				  offset, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_create_used_peb_object() - create "used" PEB object
+ * @pebi: pointer on unitialized PEB object
+ *
+ * This function tries to initialize PEB object for "used"
+ * state of the segment.
+ *
+ * RETURN:
+ * [success] - PEB object has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_create_used_peb_object(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_fs_info *fsi;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc);
+	BUG_ON(pebi->peb_id == U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebi %p, peb_id %llu\n",
+		  pebi, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_peb_current_log_init(pebi, 0, fsi->pages_per_peb, 0, U32_MAX);
+
+	return 0;
+}
+
+/*
+ * ssdfs_create_dirty_peb_object() - create "dirty" PEB object
+ * @pebi: pointer on unitialized PEB object
+ *
+ * This function tries to initialize PEB object for "dirty"
+ * state of the PEB.
+ *
+ * RETURN:
+ * [success] - PEB object has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+static
+int ssdfs_create_dirty_peb_object(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_fs_info *fsi;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(pebi->peb_id == U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebi %p, peb_id %llu\n",
+		  pebi, pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_peb_current_log_init(pebi, 0, fsi->pages_per_peb, 0, U32_MAX);
+
+	return 0;
+}
+
+static inline
+size_t ssdfs_peb_temp_buffer_default_size(u32 pagesize)
+{
+	size_t blk_desc_size = sizeof(struct ssdfs_block_descriptor);
+	size_t size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(pagesize > SSDFS_128KB);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	size = (SSDFS_128KB / pagesize) * blk_desc_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_size %u, default_size %zu\n",
+		  pagesize, size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return size;
+}
+
+/*
+ * ssdfs_peb_realloc_read_buffer() - realloc temporary read buffer
+ * @buf: pointer on read buffer
+ */
+int ssdfs_peb_realloc_read_buffer(struct ssdfs_peb_read_buffer *buf,
+				  size_t new_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (buf->size >= PAGE_SIZE) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to realloc buffer: "
+			  "old_size %zu\n",
+			  buf->size);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -E2BIG;
+	}
+
+	if (buf->size == new_size) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("do nothing: old_size %zu, new_size %zu\n",
+			  buf->size, new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	if (buf->size > new_size) {
+		SSDFS_ERR("shrink not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	buf->ptr = krealloc(buf->ptr, new_size, GFP_KERNEL);
+	if (!buf->ptr) {
+		SSDFS_ERR("fail to allocate buffer\n");
+		return -ENOMEM;
+	}
+
+	buf->size = new_size;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_realloc_write_buffer() - realloc temporary write buffer
+ * @buf: pointer on write buffer
+ */
+int ssdfs_peb_realloc_write_buffer(struct ssdfs_peb_temp_buffer *buf)
+{
+	size_t new_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (buf->size >= PAGE_SIZE) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to realloc buffer: "
+			  "old_size %zu\n",
+			  buf->size);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -E2BIG;
+	}
+
+	new_size = min_t(size_t, buf->size * 2, (size_t)PAGE_SIZE);
+
+	buf->ptr = krealloc(buf->ptr, new_size, GFP_KERNEL);
+	if (!buf->ptr) {
+		SSDFS_ERR("fail to allocate buffer\n");
+		return -ENOMEM;
+	}
+
+	buf->size = new_size;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_current_log_prepare() - prepare current log object
+ * @pebi: pointer on PEB object
+ */
+static inline
+int ssdfs_peb_current_log_prepare(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_area *area;
+	struct ssdfs_peb_temp_buffer *write_buf;
+	size_t blk_desc_size = sizeof(struct ssdfs_block_descriptor);
+	size_t buf_size;
+	u16 flags;
+	size_t bmap_bytes;
+	size_t bmap_pages;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	flags = fsi->metadata_options.blk2off_tbl.flags;
+	buf_size = ssdfs_peb_temp_buffer_default_size(fsi->pagesize);
+
+	mutex_init(&pebi->current_log.lock);
+	atomic_set(&pebi->current_log.sequence_id, 0);
+
+	pebi->current_log.start_page = U32_MAX;
+	pebi->current_log.reserved_pages = 0;
+	pebi->current_log.free_data_pages = pebi->log_pages;
+	pebi->current_log.seg_flags = 0;
+	pebi->current_log.prev_log_bmap_bytes = U32_MAX;
+	pebi->current_log.last_log_time = U64_MAX;
+	pebi->current_log.last_log_cno = U64_MAX;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_data_pages %u\n",
+		  pebi->current_log.free_data_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bmap_bytes = BLK_BMAP_BYTES(fsi->pages_per_peb);
+	bmap_pages = (bmap_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+
+	err = ssdfs_page_vector_create(&pebi->current_log.bmap_snapshot,
+					bmap_pages);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create page vector: "
+			  "bmap_pages %zu, err %d\n",
+			  bmap_pages, err);
+		return err;
+	}
+
+	for (i = 0; i < SSDFS_LOG_AREA_MAX; i++) {
+		struct ssdfs_peb_area_metadata *metadata;
+		size_t metadata_size = sizeof(struct ssdfs_peb_area_metadata);
+		size_t blk_table_size = sizeof(struct ssdfs_area_block_table);
+
+		area = &pebi->current_log.area[i];
+		metadata = &area->metadata;
+		memset(&area->metadata, 0, metadata_size);
+
+		switch (i) {
+		case SSDFS_LOG_BLK_DESC_AREA:
+			write_buf = &area->metadata.area.blk_desc.flush_buf;
+
+			area->has_metadata = true;
+			area->write_offset = blk_table_size;
+			area->compressed_offset = blk_table_size;
+			area->metadata.reserved_offset = blk_table_size;
+
+			if (flags & SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION) {
+				write_buf->ptr = ssdfs_peb_kzalloc(buf_size,
+								   GFP_KERNEL);
+				if (!write_buf->ptr) {
+					err = -ENOMEM;
+					SSDFS_ERR("unable to allocate\n");
+					goto fail_init_current_log;
+				}
+
+				write_buf->write_offset = 0;
+				write_buf->granularity = blk_desc_size;
+				write_buf->size = buf_size;
+			} else {
+				write_buf->ptr = NULL;
+				write_buf->write_offset = 0;
+				write_buf->granularity = 0;
+				write_buf->size = 0;
+			}
+			break;
+
+		case SSDFS_LOG_MAIN_AREA:
+		case SSDFS_LOG_DIFFS_AREA:
+		case SSDFS_LOG_JOURNAL_AREA:
+			area->has_metadata = false;
+			area->write_offset = 0;
+			area->compressed_offset = 0;
+			area->metadata.reserved_offset = 0;
+			break;
+
+		default:
+			BUG();
+		};
+
+		err = ssdfs_create_page_array(fsi->pages_per_peb,
+					      &area->array);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create page array: "
+				  "capacity %u, err %d\n",
+				  fsi->pages_per_peb, err);
+			goto fail_init_current_log;
+		}
+	}
+
+	atomic_set(&pebi->current_log.state, SSDFS_LOG_PREPARED);
+	return 0;
+
+fail_init_current_log:
+	for (--i; i >= 0; i--) {
+		area = &pebi->current_log.area[i];
+
+		if (i == SSDFS_LOG_BLK_DESC_AREA) {
+			write_buf = &area->metadata.area.blk_desc.flush_buf;
+
+			area->metadata.area.blk_desc.capacity = 0;
+			area->metadata.area.blk_desc.items_count = 0;
+
+			if (write_buf->ptr) {
+				ssdfs_peb_kfree(write_buf->ptr);
+				write_buf->ptr = NULL;
+			}
+		}
+
+		ssdfs_destroy_page_array(&area->array);
+	}
+
+	ssdfs_page_vector_destroy(&pebi->current_log.bmap_snapshot);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_current_log_destroy() - destroy current log object
+ * @pebi: pointer on PEB object
+ */
+static inline
+int ssdfs_peb_current_log_destroy(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_peb_temp_buffer *write_buf;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(mutex_is_locked(&pebi->current_log.lock));
+
+	SSDFS_DBG("pebi %p\n", pebi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_peb_current_log_lock(pebi);
+
+	for (i = 0; i < SSDFS_LOG_AREA_MAX; i++) {
+		struct ssdfs_page_array *area_pages;
+
+		area_pages = &pebi->current_log.area[i].array;
+
+		if (atomic_read(&area_pages->state) == SSDFS_PAGE_ARRAY_DIRTY) {
+			ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+					__FILE__, __func__, __LINE__,
+					"PEB %llu is dirty on destruction\n",
+					pebi->peb_id);
+			err = -EIO;
+		}
+
+		if (i == SSDFS_LOG_BLK_DESC_AREA) {
+			struct ssdfs_peb_area *area;
+
+			area = &pebi->current_log.area[i];
+			area->metadata.area.blk_desc.capacity = 0;
+			area->metadata.area.blk_desc.items_count = 0;
+
+			write_buf = &area->metadata.area.blk_desc.flush_buf;
+
+			if (write_buf->ptr) {
+				ssdfs_peb_kfree(write_buf->ptr);
+				write_buf->ptr = NULL;
+				write_buf->write_offset = 0;
+				write_buf->size = 0;
+			}
+		}
+
+		ssdfs_destroy_page_array(area_pages);
+	}
+
+	ssdfs_page_vector_release(&pebi->current_log.bmap_snapshot);
+	ssdfs_page_vector_destroy(&pebi->current_log.bmap_snapshot);
+
+	atomic_set(&pebi->current_log.state, SSDFS_LOG_UNKNOWN);
+	ssdfs_peb_current_log_unlock(pebi);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_object_create() - create PEB object in array
+ * @pebi: pointer on PEB object
+ * @pebc: pointer on PEB container
+ * @peb_id: PEB identification number
+ * @peb_state: PEB's state
+ * @peb_migration_id: PEB's migration ID
+ *
+ * This function tries to create PEB object for
+ * @peb_index in array.
+ *
+ * RETURN:
+ * [success] - PEB object has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+int ssdfs_peb_object_create(struct ssdfs_peb_info *pebi,
+			    struct ssdfs_peb_container *pebc,
+			    u64 peb_id, int peb_state,
+			    u8 peb_migration_id)
+{
+	struct ssdfs_fs_info *fsi;
+	int peb_type;
+	size_t buf_size;
+	u16 flags;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebc || !pebc->parent_si);
+
+	if ((peb_id * pebc->parent_si->fsi->pebs_per_seg) >=
+	    pebc->parent_si->fsi->nsegs) {
+		SSDFS_ERR("requested peb_id %llu >= nsegs %llu\n",
+			  peb_id, pebc->parent_si->fsi->nsegs);
+		return -EINVAL;
+	}
+
+	if (pebc->peb_index >= pebc->parent_si->pebs_count) {
+		SSDFS_ERR("requested peb_index %u >= pebs_count %u\n",
+			  pebc->peb_index,
+			  pebc->parent_si->pebs_count);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("pebi %p, seg %llu, peb_id %llu, "
+		  "peb_index %u, pebc %p, "
+		  "peb_state %#x, peb_migration_id %u\n",
+		  pebi, pebc->parent_si->seg_id,
+		  pebi->peb_id, pebc->peb_index, pebc,
+		  peb_state, peb_migration_id);
+#else
+	SSDFS_DBG("pebi %p, seg %llu, peb_id %llu, "
+		  "peb_index %u, pebc %p, "
+		  "peb_state %#x, peb_migration_id %u\n",
+		  pebi, pebc->parent_si->seg_id,
+		  pebi->peb_id, pebc->peb_index, pebc,
+		  peb_state, peb_migration_id);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+	flags = fsi->metadata_options.blk2off_tbl.flags;
+	buf_size = ssdfs_peb_temp_buffer_default_size(fsi->pagesize);
+
+	atomic_set(&pebi->state, SSDFS_PEB_OBJECT_UNKNOWN_STATE);
+
+	peb_type = SEG2PEB_TYPE(pebc->parent_si->seg_type);
+	if (peb_type >= SSDFS_MAPTBL_PEB_TYPE_MAX) {
+		err = -EINVAL;
+		SSDFS_ERR("invalid seg_type %#x\n",
+			  pebc->parent_si->seg_type);
+		goto fail_conctruct_peb_obj;
+	}
+
+	pebi->peb_id = peb_id;
+	pebi->peb_index = pebc->peb_index;
+	pebi->log_pages = pebc->log_pages;
+	pebi->peb_create_time = ssdfs_current_timestamp();
+	ssdfs_set_peb_migration_id(pebi, peb_migration_id);
+	init_completion(&pebi->init_end);
+	atomic_set(&pebi->reserved_bytes.blk_bmap, 0);
+	atomic_set(&pebi->reserved_bytes.blk2off_tbl, 0);
+	atomic_set(&pebi->reserved_bytes.blk_desc_tbl, 0);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb_id %llu, "
+		  "peb_create_time %llx\n",
+		  pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  pebi->peb_create_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	init_rwsem(&pebi->read_buffer.lock);
+	if (flags & SSDFS_BLK2OFF_TBL_MAKE_COMPRESSION) {
+		pebi->read_buffer.blk_desc.ptr = ssdfs_peb_kzalloc(buf_size,
+								  GFP_KERNEL);
+		if (!pebi->read_buffer.blk_desc.ptr) {
+			err = -ENOMEM;
+			SSDFS_ERR("unable to allocate\n");
+			goto fail_conctruct_peb_obj;
+		}
+
+		pebi->read_buffer.blk_desc.offset = U32_MAX;
+		pebi->read_buffer.blk_desc.size = buf_size;
+	} else {
+		pebi->read_buffer.blk_desc.ptr = NULL;
+		pebi->read_buffer.blk_desc.offset = U32_MAX;
+		pebi->read_buffer.blk_desc.size = 0;
+	}
+
+	pebi->pebc = pebc;
+
+	err = ssdfs_create_page_array(fsi->pages_per_peb,
+				      &pebi->cache);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create page array: "
+			  "capacity %u, err %d\n",
+			  fsi->pages_per_peb, err);
+		goto fail_conctruct_peb_obj;
+	}
+
+	err = ssdfs_peb_current_log_prepare(pebi);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare current log: err %d\n",
+			  err);
+		goto fail_conctruct_peb_obj;
+	}
+
+	switch (peb_state) {
+	case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+		err = ssdfs_create_clean_peb_object(pebi);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create clean PEB object: err %d\n",
+				  err);
+			goto fail_conctruct_peb_obj;
+		}
+		break;
+
+	case SSDFS_MAPTBL_USING_PEB_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+		err = ssdfs_create_using_peb_object(pebi);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create using PEB object: err %d\n",
+				  err);
+			goto fail_conctruct_peb_obj;
+		}
+		break;
+
+	case SSDFS_MAPTBL_USED_PEB_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+	case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+		err = ssdfs_create_used_peb_object(pebi);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create used PEB object: err %d\n",
+				  err);
+			goto fail_conctruct_peb_obj;
+		}
+		break;
+
+	case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+		err = ssdfs_create_dirty_peb_object(pebi);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create dirty PEB object: err %d\n",
+				  err);
+			goto fail_conctruct_peb_obj;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid PEB state\n");
+		err = -EINVAL;
+		goto fail_conctruct_peb_obj;
+	};
+
+	atomic_set(&pebi->state, SSDFS_PEB_OBJECT_CREATED);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+fail_conctruct_peb_obj:
+	ssdfs_peb_object_destroy(pebi);
+	pebi->peb_id = U64_MAX;
+	pebi->pebc = pebc;
+	return err;
+}
+
+/*
+ * ssdfs_peb_object_destroy() - destroy PEB object in array
+ * @pebi: pointer on PEB object
+ *
+ * This function tries to destroy PEB object.
+ *
+ * RETURN:
+ * [success] - PEB object has been destroyed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EIO     - I/O errors were detected.
+ */
+int ssdfs_peb_object_destroy(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_fs_info *fsi;
+	int state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("peb_id %llu\n", pebi->peb_id);
+#else
+	SSDFS_DBG("peb_id %llu\n", pebi->peb_id);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (pebi->peb_id >= (fsi->nsegs * fsi->pebs_per_seg)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("invalid PEB id %llu\n", pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EINVAL;
+	}
+
+	err = ssdfs_peb_current_log_destroy(pebi);
+
+	down_write(&pebi->read_buffer.lock);
+	if (pebi->read_buffer.blk_desc.ptr) {
+		ssdfs_peb_kfree(pebi->read_buffer.blk_desc.ptr);
+		pebi->read_buffer.blk_desc.ptr = NULL;
+		pebi->read_buffer.blk_desc.offset = U32_MAX;
+		pebi->read_buffer.blk_desc.size = 0;
+	}
+	up_write(&pebi->read_buffer.lock);
+
+	state = atomic_read(&pebi->cache.state);
+	if (state == SSDFS_PAGE_ARRAY_DIRTY) {
+		ssdfs_fs_error(pebi->pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"PEB %llu is dirty on destruction\n",
+				pebi->peb_id);
+		err = -EIO;
+	}
+
+	ssdfs_destroy_page_array(&pebi->cache);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
diff --git a/fs/ssdfs/peb.h b/fs/ssdfs/peb.h
new file mode 100644
index 000000000000..bf20770d3b95
--- /dev/null
+++ b/fs/ssdfs/peb.h
@@ -0,0 +1,970 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb.h - Physical Erase Block (PEB) object declarations.
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
+#ifndef _SSDFS_PEB_H
+#define _SSDFS_PEB_H
+
+#include "request_queue.h"
+
+#define SSDFS_BLKBMAP_FRAG_HDR_CAPACITY \
+	(sizeof(struct ssdfs_block_bitmap_fragment) + \
+	 (sizeof(struct ssdfs_fragment_desc) * \
+	  SSDFS_BLK_BMAP_FRAGMENTS_CHAIN_MAX))
+
+#define SSDFS_BLKBMAP_HDR_CAPACITY \
+	(sizeof(struct ssdfs_block_bitmap_header) + \
+	 SSDFS_BLKBMAP_FRAG_HDR_CAPACITY)
+
+/*
+ * struct ssdfs_blk_bmap_init_env - block bitmap init environment
+ * @bmap_hdr: pointer on block bitmap header
+ * @bmap_hdr_buf: block bitmap header buffer
+ * @frag_hdr: block bitmap fragment header
+ * @frag_hdr_buf: block bitmap fragment header buffer
+ * @fragment_index: index of bmap fragment
+ * @array: page vector that stores block bitmap content
+ * @read_bytes: counter of all read bytes
+ */
+struct ssdfs_blk_bmap_init_env {
+	struct ssdfs_block_bitmap_header *bmap_hdr;
+	struct ssdfs_block_bitmap_fragment *frag_hdr;
+	u8 bmap_hdr_buf[SSDFS_BLKBMAP_HDR_CAPACITY];
+	int fragment_index;
+	struct ssdfs_page_vector array;
+	u32 read_bytes;
+};
+
+/*
+ * struct ssdfs_blk2off_table_init_env - blk2off table init environment
+ * @tbl_hdr: blk2off table header
+ * @pvec: pagevec with blk2off table fragment
+ * @blk2off_tbl_hdr_off: blk2off table header offset
+ * @read_off: current read offset
+ * @write_off: current write offset
+ */
+struct ssdfs_blk2off_table_init_env {
+	struct ssdfs_blk2off_table_header tbl_hdr;
+	struct pagevec pvec;
+	u32 blk2off_tbl_hdr_off;
+	u32 read_off;
+	u32 write_off;
+};
+
+/*
+ * struct ssdfs_blk_desc_table_init_env - blk desc table init environment
+ * @tbl_hdr: blk2off table header
+ * @pvec: pagevec with blk2off table fragment
+ * @compressed_buf: buffer for compressed blk2off table fragment
+ * @buf_size: size of compressed buffer
+ * @read_off: current read offset
+ * @write_off: current write offset
+ */
+struct ssdfs_blk_desc_table_init_env {
+	struct pagevec pvec;
+	void *compressed_buf;
+	u32 buf_size;
+	u32 read_off;
+	u32 write_off;
+};
+
+/*
+ * struct ssdfs_read_init_env - read operation init environment
+ * @log_hdr: log header
+ * @has_seg_hdr: does log have segment header?
+ * @footer: log footer
+ * @has_footer: does log have footer?
+ * @cur_migration_id: current PEB's migration ID
+ * @prev_migration_id: previous PEB's migration ID
+ * @log_offset: offset in pages of the requested log
+ * @log_pages: pages count in every log of segment
+ * @log_bytes: number of bytes in the requested log
+ * @b_init: block bitmap init environment
+ * @t_init: blk2off table init environment
+ * @bdt_init: blk desc table init environment
+ */
+struct ssdfs_read_init_env {
+	void *log_hdr;
+	bool has_seg_hdr;
+	struct ssdfs_log_footer *footer;
+	bool has_footer;
+	int cur_migration_id;
+	int prev_migration_id;
+	u32 log_offset;
+	u32 log_pages;
+	u32 log_bytes;
+
+	struct ssdfs_blk_bmap_init_env b_init;
+	struct ssdfs_blk2off_table_init_env t_init;
+	struct ssdfs_blk_desc_table_init_env bdt_init;
+};
+
+/*
+ * struct ssdfs_protection_window - protection window length
+ * @cno_lock: lock of checkpoints set
+ * @create_cno: creation checkpoint
+ * @last_request_cno: last request checkpoint
+ * @reqs_count: current number of active requests
+ * @protected_range: last measured protected range length
+ * @future_request_cno: expectation to receive a next request in the future
+ */
+struct ssdfs_protection_window {
+	spinlock_t cno_lock;
+	u64 create_cno;
+	u64 last_request_cno;
+	u32 reqs_count;
+	u64 protected_range;
+	u64 future_request_cno;
+};
+
+/*
+ * struct ssdfs_peb_diffs_area_metadata - diffs area's metadata
+ * @hdr: diffs area's table header
+ */
+struct ssdfs_peb_diffs_area_metadata {
+	struct ssdfs_block_state_descriptor hdr;
+};
+
+/*
+ * struct ssdfs_peb_journal_area_metadata - journal area's metadata
+ * @hdr: journal area's table header
+ */
+struct ssdfs_peb_journal_area_metadata {
+	struct ssdfs_block_state_descriptor hdr;
+};
+
+/*
+ * struct ssdfs_peb_read_buffer - read buffer
+ * @ptr: pointer on buffer
+ * @offset: logical offset in metadata structure
+ * @size: buffer size in bytes
+ */
+struct ssdfs_peb_read_buffer {
+	void *ptr;
+	u32 offset;
+	size_t size;
+};
+
+/*
+ * struct ssdfs_peb_temp_read_buffers - read temporary buffers
+ * @lock: temporary buffers lock
+ * @blk_desc: block descriptor table's temp read buffer
+ */
+struct ssdfs_peb_temp_read_buffers {
+	struct rw_semaphore lock;
+	struct ssdfs_peb_read_buffer blk_desc;
+};
+
+/*
+ * struct ssdfs_peb_temp_buffer - temporary (write) buffer
+ * @ptr: pointer on buffer
+ * @write_offset: current write offset into buffer
+ * @granularity: size of one item in bytes
+ * @size: buffer size in bytes
+ */
+struct ssdfs_peb_temp_buffer {
+	void *ptr;
+	u32 write_offset;
+	size_t granularity;
+	size_t size;
+};
+
+/*
+ * struct ssdfs_peb_area_metadata - descriptor of area's items chain
+ * @area.blk_desc.table: block descriptors area table
+ * @area.blk_desc.flush_buf: write block descriptors buffer (compression case)
+ * @area.blk_desc.capacity: max number of block descriptors in reserved space
+ * @area.blk_desc.items_count: number of items in the whole table
+ * @area.diffs.table: diffs area's table
+ * @area.journal.table: journal area's table
+ * @area.main.desc: main area's descriptor
+ * @reserved_offset: reserved write offset of table
+ * @sequence_id: fragment's sequence number
+ */
+struct ssdfs_peb_area_metadata {
+	union {
+		struct {
+			struct ssdfs_area_block_table table;
+			struct ssdfs_peb_temp_buffer flush_buf;
+			int capacity;
+			int items_count;
+		} blk_desc;
+
+		struct {
+			struct ssdfs_peb_diffs_area_metadata table;
+		} diffs;
+
+		struct {
+			struct ssdfs_peb_journal_area_metadata table;
+		} journal;
+
+		struct {
+			struct ssdfs_block_state_descriptor desc;
+		} main;
+	} area;
+
+	u32 reserved_offset;
+	u8 sequence_id;
+};
+
+/*
+ * struct ssdfs_peb_area - log's area descriptor
+ * @has_metadata: does area contain metadata?
+ * @metadata: descriptor of area's items chain
+ * @write_offset: current write offset
+ * @compressed_offset: current write offset for compressed data
+ * @array: area's memory pages
+ */
+struct ssdfs_peb_area {
+	bool has_metadata;
+	struct ssdfs_peb_area_metadata metadata;
+
+	u32 write_offset;
+	u32 compressed_offset;
+	struct ssdfs_page_array array;
+};
+
+/* Log possible states */
+enum {
+	SSDFS_LOG_UNKNOWN,
+	SSDFS_LOG_PREPARED,
+	SSDFS_LOG_INITIALIZED,
+	SSDFS_LOG_CREATED,
+	SSDFS_LOG_COMMITTED,
+	SSDFS_LOG_STATE_MAX,
+};
+
+/*
+ * struct ssdfs_peb_log - current log
+ * @lock: exclusive lock of current log
+ * @state: current log's state
+ * @sequence_id: index of partial log in the sequence
+ * @start_page: current log's start page index
+ * @pages_capacity: rest free pages in log
+ * @write_offset: current offset in bytes for adding data in log
+ * @seg_flags: segment header's flags for the log
+ * @prev_log_bmap_bytes: bytes count in block bitmap of previous log
+ * @last_log_time: creation timestamp of last log
+ * @last_log_cno: last log checkpoint
+ * @bmap_snapshot: snapshot of block bitmap
+ * @area: log's areas (main, diff updates, journal)
+ */
+struct ssdfs_peb_log {
+	struct mutex lock;
+	atomic_t state;
+	atomic_t sequence_id;
+	u32 start_page;
+	u32 reserved_pages; /* metadata pages in the log */
+	u32 free_data_pages; /* free data pages capacity */
+	u32 seg_flags;
+	u32 prev_log_bmap_bytes;
+	u64 last_log_time;
+	u64 last_log_cno;
+	struct ssdfs_page_vector bmap_snapshot;
+	struct ssdfs_peb_area area[SSDFS_LOG_AREA_MAX];
+};
+
+/*
+ * struct ssdfs_peb_info - Physical Erase Block (PEB) description
+ * @peb_id: PEB number
+ * @peb_index: PEB index
+ * @log_pages: count of pages in full partial log
+ * @peb_create_time: PEB creation timestamp
+ * @peb_migration_id: identification number of PEB in migration sequence
+ * @state: PEB object state
+ * @init_end: wait of full init ending
+ * @reserved_bytes.blk_bmap: reserved bytes for block bitmap
+ * @reserved_bytes.blk2off_tbl: reserved bytes for blk2off table
+ * @reserved_bytes.blk_desc_tbl: reserved bytes for block descriptor table
+ * @current_log: PEB's current log
+ * @read_buffer: temporary read buffers (compression case)
+ * @env: init environment
+ * @cache: PEB's memory pages
+ * @pebc: pointer on parent container
+ */
+struct ssdfs_peb_info {
+	/* Static data */
+	u64 peb_id;
+	u16 peb_index;
+	u32 log_pages;
+
+	u64 peb_create_time;
+
+	/*
+	 * The peb_migration_id is stored in two places:
+	 * (1) struct ssdfs_segment_header;
+	 * (2) struct ssdfs_blk_state_offset.
+	 *
+	 * The goal of peb_migration_id is to distinguish PEB
+	 * objects during PEB object's migration. Every
+	 * destination PEB is received the migration_id that
+	 * is incremented migration_id value of source PEB
+	 * object. If peb_migration_id is achieved value of
+	 * SSDFS_PEB_MIGRATION_ID_MAX then peb_migration_id
+	 * is started from SSDFS_PEB_MIGRATION_ID_START again.
+	 *
+	 * A PEB object is received the peb_migration_id value
+	 * during the PEB object creation operation. The "clean"
+	 * PEB object receives SSDFS_PEB_MIGRATION_ID_START
+	 * value. The destinaton PEB object receives incremented
+	 * peb_migration_id value of source PEB object during
+	 * creation operation. Otherwise, the real peb_migration_id
+	 * value is set during PEB's initialization
+	 * by means of extracting the actual value from segment
+	 * header.
+	 */
+	atomic_t peb_migration_id;
+
+	atomic_t state;
+	struct completion init_end;
+
+	/* Reserved bytes */
+	struct {
+		atomic_t blk_bmap;
+		atomic_t blk2off_tbl;
+		atomic_t blk_desc_tbl;
+	} reserved_bytes;
+
+	/* Current log */
+	struct ssdfs_peb_log current_log;
+
+	/* Read buffer */
+	struct ssdfs_peb_temp_read_buffers read_buffer;
+
+	/* Init environment */
+	struct ssdfs_read_init_env env;
+
+	/* PEB's memory pages */
+	struct ssdfs_page_array cache;
+
+	/* Parent container */
+	struct ssdfs_peb_container *pebc;
+};
+
+/* PEB object states */
+enum {
+	SSDFS_PEB_OBJECT_UNKNOWN_STATE,
+	SSDFS_PEB_OBJECT_CREATED,
+	SSDFS_PEB_OBJECT_INITIALIZED,
+	SSDFS_PEB_OBJECT_STATE_MAX
+};
+
+#define SSDFS_AREA_TYPE2INDEX(type)({ \
+	int index; \
+	switch (type) { \
+	case SSDFS_LOG_BLK_DESC_AREA: \
+		index = SSDFS_BLK_DESC_AREA_INDEX; \
+		break; \
+	case SSDFS_LOG_MAIN_AREA: \
+		index = SSDFS_COLD_PAYLOAD_AREA_INDEX; \
+		break; \
+	case SSDFS_LOG_DIFFS_AREA: \
+		index = SSDFS_WARM_PAYLOAD_AREA_INDEX; \
+		break; \
+	case SSDFS_LOG_JOURNAL_AREA: \
+		index = SSDFS_HOT_PAYLOAD_AREA_INDEX; \
+		break; \
+	default: \
+		BUG(); \
+	}; \
+	index; \
+})
+
+#define SSDFS_AREA_TYPE2FLAG(type)({ \
+	int flag; \
+	switch (type) { \
+	case SSDFS_LOG_BLK_DESC_AREA: \
+		flag = SSDFS_LOG_HAS_BLK_DESC_CHAIN; \
+		break; \
+	case SSDFS_LOG_MAIN_AREA: \
+		flag = SSDFS_LOG_HAS_COLD_PAYLOAD; \
+		break; \
+	case SSDFS_LOG_DIFFS_AREA: \
+		flag = SSDFS_LOG_HAS_WARM_PAYLOAD; \
+		break; \
+	case SSDFS_LOG_JOURNAL_AREA: \
+		flag = SSDFS_LOG_HAS_HOT_PAYLOAD; \
+		break; \
+	default: \
+		BUG(); \
+	}; \
+	flag; \
+})
+
+/*
+ * Inline functions
+ */
+
+/*
+ * ssdfs_peb_correct_area_write_offset() - correct write offset
+ * @write_offset: current write offset
+ * @data_size: requested size of data
+ *
+ * This function checks that we can place whole data into current
+ * memory page.
+ *
+ * RETURN: corrected value of write offset.
+ */
+static inline
+u32 ssdfs_peb_correct_area_write_offset(u32 write_offset, u32 data_size)
+{
+	u32 page_index1, page_index2;
+	u32 new_write_offset = write_offset + data_size;
+
+	page_index1 = write_offset / PAGE_SIZE;
+	page_index2 = new_write_offset / PAGE_SIZE;
+
+	if (page_index1 != page_index2) {
+		u32 calculated_write_offset = page_index2 * PAGE_SIZE;
+
+		if (new_write_offset == calculated_write_offset)
+			return write_offset;
+		else
+			return calculated_write_offset;
+	}
+
+	return write_offset;
+}
+
+/*
+ * ssdfs_peb_current_log_lock() - lock current log object
+ * @pebi: pointer on PEB object
+ */
+static inline
+void ssdfs_peb_current_log_lock(struct ssdfs_peb_info *pebi)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = mutex_lock_killable(&pebi->current_log.lock);
+	WARN_ON(err);
+}
+
+/*
+ * ssdfs_peb_current_log_unlock() - unlock current log object
+ * @pebi: pointer on PEB object
+ */
+static inline
+void ssdfs_peb_current_log_unlock(struct ssdfs_peb_info *pebi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	WARN_ON(!mutex_is_locked(&pebi->current_log.lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	mutex_unlock(&pebi->current_log.lock);
+}
+
+static inline
+bool is_ssdfs_peb_current_log_locked(struct ssdfs_peb_info *pebi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return mutex_is_locked(&pebi->current_log.lock);
+}
+
+/*
+ * ssdfs_peb_current_log_state() - check current log's state
+ * @pebi: pointer on PEB object
+ * @state: checked state
+ */
+static inline
+bool ssdfs_peb_current_log_state(struct ssdfs_peb_info *pebi,
+				 int state)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(state < SSDFS_LOG_UNKNOWN || state >= SSDFS_LOG_STATE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return atomic_read(&pebi->current_log.state) >= state;
+}
+
+/*
+ * ssdfs_peb_set_current_log_state() - set current log's state
+ * @pebi: pointer on PEB object
+ * @state: new log's state
+ */
+static inline
+void ssdfs_peb_set_current_log_state(struct ssdfs_peb_info *pebi,
+				     int state)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(state < SSDFS_LOG_UNKNOWN || state >= SSDFS_LOG_STATE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return atomic_set(&pebi->current_log.state, state);
+}
+
+/*
+ * ssdfs_peb_current_log_init() - initialize current log object
+ * @pebi: pointer on PEB object
+ * @free_pages: free pages in the current log
+ * @start_page: start page of the current log
+ * @sequence_id: index of partial log in the sequence
+ * @prev_log_bmap_bytes: bytes count in block bitmap of previous log
+ */
+static inline
+void ssdfs_peb_current_log_init(struct ssdfs_peb_info *pebi,
+				u32 free_pages,
+				u32 start_page,
+				int sequence_id,
+				u32 prev_log_bmap_bytes)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+
+	SSDFS_DBG("peb_id %llu, "
+		  "pebi->current_log.start_page %u, "
+		  "free_pages %u, sequence_id %d, "
+		  "prev_log_bmap_bytes %u\n",
+		  pebi->peb_id, start_page, free_pages,
+		  sequence_id, prev_log_bmap_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_peb_current_log_lock(pebi);
+	pebi->current_log.start_page = start_page;
+	pebi->current_log.free_data_pages = free_pages;
+	pebi->current_log.prev_log_bmap_bytes = prev_log_bmap_bytes;
+	atomic_set(&pebi->current_log.sequence_id, sequence_id);
+	atomic_set(&pebi->current_log.state, SSDFS_LOG_INITIALIZED);
+	ssdfs_peb_current_log_unlock(pebi);
+}
+
+/*
+ * ssdfs_get_leb_id_for_peb_index() - convert PEB's index into LEB's ID
+ * @fsi: pointer on shared file system object
+ * @seg: segment number
+ * @peb_index: index of PEB object in array
+ *
+ * This function converts PEB's index into LEB's identification
+ * number.
+ *
+ * RETURN:
+ * [success] - LEB's identification number.
+ * [failure] - U64_MAX.
+ */
+static inline
+u64 ssdfs_get_leb_id_for_peb_index(struct ssdfs_fs_info *fsi,
+				   u64 seg, u32 peb_index)
+{
+	u64 leb_id = U64_MAX;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	if (peb_index >= fsi->pebs_per_seg) {
+		SSDFS_ERR("requested peb_index %u >= pebs_per_seg %u\n",
+			  peb_index, fsi->pebs_per_seg);
+		return U64_MAX;
+	}
+
+	SSDFS_DBG("fsi %p, seg %llu, peb_index %u\n",
+		  fsi, seg, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (fsi->lebs_per_peb_index == SSDFS_LEBS_PER_PEB_INDEX_DEFAULT)
+		leb_id = (seg * fsi->pebs_per_seg) + peb_index;
+	else
+		leb_id = seg + (peb_index * fsi->lebs_per_peb_index);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb_index %u, leb_id %llu\n",
+		  seg, peb_index, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return leb_id;
+}
+
+/*
+ * ssdfs_get_seg_id_for_leb_id() - convert LEB's into segment's ID
+ * @fsi: pointer on shared file system object
+ * @leb_id: LEB ID
+ *
+ * This function converts LEB's ID into segment's identification
+ * number.
+ *
+ * RETURN:
+ * [success] - LEB's identification number.
+ * [failure] - U64_MAX.
+ */
+static inline
+u64 ssdfs_get_seg_id_for_leb_id(struct ssdfs_fs_info *fsi,
+				u64 leb_id)
+{
+	u64 seg_id = U64_MAX;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi %p, leb_id %llu\n",
+		  fsi, leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (fsi->lebs_per_peb_index == SSDFS_LEBS_PER_PEB_INDEX_DEFAULT)
+		seg_id = div_u64(leb_id, fsi->pebs_per_seg);
+	else
+		seg_id = div_u64(leb_id, fsi->lebs_per_peb_index);
+
+	return seg_id;
+}
+
+/*
+ * ssdfs_get_peb_migration_id() - get PEB's migration ID
+ * @pebi: pointer on PEB object
+ */
+static inline
+int ssdfs_get_peb_migration_id(struct ssdfs_peb_info *pebi)
+{
+	int id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	id = atomic_read(&pebi->peb_migration_id);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(id >= U8_MAX);
+	BUG_ON(id < 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return id;
+}
+
+/*
+ * is_peb_migration_id_valid() - check PEB's migration_id
+ * @peb_migration_id: PEB's migration ID value
+ */
+static inline
+bool is_peb_migration_id_valid(int peb_migration_id)
+{
+	if (peb_migration_id < 0 ||
+	    peb_migration_id > SSDFS_PEB_MIGRATION_ID_MAX) {
+		/* preliminary check */
+		return false;
+	}
+
+	switch (peb_migration_id) {
+	case SSDFS_PEB_MIGRATION_ID_MAX:
+	case SSDFS_PEB_UNKNOWN_MIGRATION_ID:
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * ssdfs_get_peb_migration_id_checked() - get checked PEB's migration ID
+ * @pebi: pointer on PEB object
+ */
+static inline
+int ssdfs_get_peb_migration_id_checked(struct ssdfs_peb_info *pebi)
+{
+	int res, err;
+
+	switch (atomic_read(&pebi->state)) {
+	case SSDFS_PEB_OBJECT_CREATED:
+		err = SSDFS_WAIT_COMPLETION(&pebi->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("PEB init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		if (atomic_read(&pebi->state) != SSDFS_PEB_OBJECT_INITIALIZED) {
+			SSDFS_ERR("PEB %llu is not initialized\n",
+				  pebi->peb_id);
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_PEB_OBJECT_INITIALIZED:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid PEB state %#x\n",
+			  atomic_read(&pebi->state));
+		return -ERANGE;
+	}
+
+	res = ssdfs_get_peb_migration_id(pebi);
+
+	if (!is_peb_migration_id_valid(res)) {
+		res = -ERANGE;
+		SSDFS_WARN("invalid peb_migration_id: "
+			   "peb %llu, peb_index %u, id %d\n",
+			   pebi->peb_id, pebi->peb_index, res);
+	}
+
+	return res;
+}
+
+/*
+ * ssdfs_set_peb_migration_id() - set PEB's migration ID
+ * @pebi: pointer on PEB object
+ * @id: new PEB's migration_id
+ */
+static inline
+void ssdfs_set_peb_migration_id(struct ssdfs_peb_info *pebi,
+				int id)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+
+	SSDFS_DBG("peb_id %llu, peb_migration_id %d\n",
+		  pebi->peb_id, id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	atomic_set(&pebi->peb_migration_id, id);
+}
+
+static inline
+int __ssdfs_define_next_peb_migration_id(int prev_id)
+{
+	int id = prev_id;
+
+	if (id < 0)
+		return SSDFS_PEB_MIGRATION_ID_START;
+
+	id += 1;
+
+	if (id >= SSDFS_PEB_MIGRATION_ID_MAX)
+		id = SSDFS_PEB_MIGRATION_ID_START;
+
+	return id;
+}
+
+/*
+ * ssdfs_define_next_peb_migration_id() - define next PEB's migration_id
+ * @pebi: pointer on source PEB object
+ */
+static inline
+int ssdfs_define_next_peb_migration_id(struct ssdfs_peb_info *src_peb)
+{
+	int id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!src_peb);
+
+	SSDFS_DBG("peb %llu, peb_index %u\n",
+		  src_peb->peb_id, src_peb->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	id = ssdfs_get_peb_migration_id_checked(src_peb);
+	if (id < 0) {
+		SSDFS_ERR("fail to get peb_migration_id: "
+			  "peb %llu, peb_index %u, err %d\n",
+			  src_peb->peb_id, src_peb->peb_index,
+			  id);
+		return SSDFS_PEB_MIGRATION_ID_MAX;
+	}
+
+	return __ssdfs_define_next_peb_migration_id(id);
+}
+
+/*
+ * ssdfs_define_prev_peb_migration_id() - define prev PEB's migration_id
+ * @pebi: pointer on source PEB object
+ */
+static inline
+int ssdfs_define_prev_peb_migration_id(struct ssdfs_peb_info *pebi)
+{
+	int id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+
+	SSDFS_DBG("peb %llu, peb_index %u\n",
+		  pebi->peb_id, pebi->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	id = ssdfs_get_peb_migration_id_checked(pebi);
+	if (id < 0) {
+		SSDFS_ERR("fail to get peb_migration_id: "
+			  "peb %llu, peb_index %u, err %d\n",
+			  pebi->peb_id, pebi->peb_index,
+			  id);
+		return SSDFS_PEB_MIGRATION_ID_MAX;
+	}
+
+	id--;
+
+	if (id == SSDFS_PEB_UNKNOWN_MIGRATION_ID)
+		id = SSDFS_PEB_MIGRATION_ID_MAX - 1;
+
+	return id;
+}
+
+/*
+ * IS_SSDFS_BLK_STATE_OFFSET_INVALID() - check that block state offset invalid
+ * @desc: block state offset
+ */
+static inline
+bool IS_SSDFS_BLK_STATE_OFFSET_INVALID(struct ssdfs_blk_state_offset *desc)
+{
+	if (!desc)
+		return true;
+
+	if (le16_to_cpu(desc->log_start_page) == U16_MAX &&
+	    desc->log_area == U8_MAX &&
+	    desc->peb_migration_id == U8_MAX &&
+	    le32_to_cpu(desc->byte_offset) == U32_MAX) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("log_start_page %u, log_area %u, "
+			  "peb_migration_id %u, byte_offset %u\n",
+			  le16_to_cpu(desc->log_start_page),
+			  desc->log_area,
+			  desc->peb_migration_id,
+			  le32_to_cpu(desc->byte_offset));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return true;
+	}
+
+	if (desc->peb_migration_id == SSDFS_PEB_UNKNOWN_MIGRATION_ID) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("log_start_page %u, log_area %u, "
+			  "peb_migration_id %u, byte_offset %u\n",
+			  le16_to_cpu(desc->log_start_page),
+			  desc->log_area,
+			  desc->peb_migration_id,
+			  le32_to_cpu(desc->byte_offset));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * SSDFS_BLK_DESC_INIT() - init block descriptor
+ * @blk_desc: block descriptor
+ */
+static inline
+void SSDFS_BLK_DESC_INIT(struct ssdfs_block_descriptor *blk_desc)
+{
+	if (!blk_desc) {
+		SSDFS_WARN("block descriptor pointer is NULL\n");
+		return;
+	}
+
+	memset(blk_desc, 0xFF, sizeof(struct ssdfs_block_descriptor));
+}
+
+/*
+ * IS_SSDFS_BLK_DESC_EXHAUSTED() - check that block descriptor is exhausted
+ * @blk_desc: block descriptor
+ */
+static inline
+bool IS_SSDFS_BLK_DESC_EXHAUSTED(struct ssdfs_block_descriptor *blk_desc)
+{
+	struct ssdfs_blk_state_offset *offset = NULL;
+
+	if (!blk_desc)
+		return true;
+
+	offset = &blk_desc->state[SSDFS_BLK_STATE_OFF_MAX - 1];
+
+	if (!IS_SSDFS_BLK_STATE_OFFSET_INVALID(offset))
+		return true;
+
+	return false;
+}
+
+static inline
+bool IS_SSDFS_BLK_DESC_READY_FOR_DIFF(struct ssdfs_block_descriptor *blk_desc)
+{
+	return !IS_SSDFS_BLK_STATE_OFFSET_INVALID(&blk_desc->state[0]);
+}
+
+static inline
+u8 SSDFS_GET_BLK_DESC_MIGRATION_ID(struct ssdfs_block_descriptor *blk_desc)
+{
+	if (IS_SSDFS_BLK_STATE_OFFSET_INVALID(&blk_desc->state[0]))
+		return U8_MAX;
+
+	return blk_desc->state[0].peb_migration_id;
+}
+
+static inline
+void DEBUG_BLOCK_DESCRIPTOR(u64 seg_id, u64 peb_id,
+			    struct ssdfs_block_descriptor *blk_desc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int i;
+
+	SSDFS_DBG("seg_id %llu, peb_id %llu, ino %llu, "
+		  "logical_offset %u, peb_index %u, peb_page %u\n",
+		  seg_id, peb_id,
+		  le64_to_cpu(blk_desc->ino),
+		  le32_to_cpu(blk_desc->logical_offset),
+		  le16_to_cpu(blk_desc->peb_index),
+		  le16_to_cpu(blk_desc->peb_page));
+
+	for (i = 0; i < SSDFS_BLK_STATE_OFF_MAX; i++) {
+		SSDFS_DBG("BLK STATE OFFSET %d: "
+			  "log_start_page %u, log_area %#x, "
+			  "byte_offset %u, peb_migration_id %u\n",
+			  i,
+			  le16_to_cpu(blk_desc->state[i].log_start_page),
+			  blk_desc->state[i].log_area,
+			  le32_to_cpu(blk_desc->state[i].byte_offset),
+			  blk_desc->state[i].peb_migration_id);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * PEB object's API
+ */
+int ssdfs_peb_object_create(struct ssdfs_peb_info *pebi,
+			    struct ssdfs_peb_container *pebc,
+			    u64 peb_id, int peb_state,
+			    u8 peb_migration_id);
+int ssdfs_peb_object_destroy(struct ssdfs_peb_info *pebi);
+
+/*
+ * PEB internal functions declaration
+ */
+int ssdfs_unaligned_read_cache(struct ssdfs_peb_info *pebi,
+				u32 area_offset, u32 area_size,
+				void *buf);
+int ssdfs_peb_read_log_hdr_desc_array(struct ssdfs_peb_info *pebi,
+				      struct ssdfs_segment_request *req,
+				      u16 log_start_page,
+				      struct ssdfs_metadata_descriptor *array,
+				      size_t array_size);
+u16 ssdfs_peb_estimate_min_partial_log_pages(struct ssdfs_peb_info *pebi);
+bool is_ssdfs_peb_exhausted(struct ssdfs_fs_info *fsi,
+			    struct ssdfs_peb_info *pebi);
+bool is_ssdfs_peb_ready_to_exhaust(struct ssdfs_fs_info *fsi,
+				   struct ssdfs_peb_info *pebi);
+int ssdfs_peb_realloc_read_buffer(struct ssdfs_peb_read_buffer *buf,
+				  size_t new_size);
+int ssdfs_peb_realloc_write_buffer(struct ssdfs_peb_temp_buffer *buf);
+
+#endif /* _SSDFS_PEB_H */
-- 
2.34.1


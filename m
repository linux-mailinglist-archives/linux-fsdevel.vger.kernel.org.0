Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C216A2629
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBYBQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBYBQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:02 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757012848
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:58 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id e21so828254oie.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKfbLSgIY4jw6APVHff0Z1QZ3oHknF0kOQjUcEVCXtE=;
        b=PM8ph9TzgUIxS8gunR+dY0od/4K15D2KZi15f0N9k708cmOesVWXGOK0M8iviXsipV
         94y5eQ3qLiVVMCwVolsgld0yj1aAmYIcUCaHy49lpRP0LtYbzBd6EGhJ+oyzg0ENl9xT
         X0avr28Ek/LkwKYQ2y3tt2BBQs1jKyQbNbMnDsWeiO5eIWPZPOESUtMt5n4AgiWT1bjV
         N8G8Oz9IHP//lDEFxjx6lPmpvQMycCIZcAM2Y9e1uCw0wEAAUTni3mxhUsrDJc3i83z4
         UQ+B+Yn6RRzybtDFF0jY0u8e+14WjaKvfjfJiyO8FUeJY6Sm+ALXz0mwaC/45nsN//LR
         u/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKfbLSgIY4jw6APVHff0Z1QZ3oHknF0kOQjUcEVCXtE=;
        b=2mMhzxQBDtVB1vVgvsWFO32VwSeU51ZeXx5DOeqZzvJJPwOcABb7ZIqICSVme9JC7o
         hDWJaoG8OBAmFjslHz5HFYFZZcWDuG/nnHvAkt4NR71ZbCqdRaVhghlT2Ov/F1vO2ECb
         BGIftATeGpcEUEKgkulaazhzqltbMA3vlfJcKEcI3+ySU7r8QdHCMvfVyRqt5eWUcDxV
         TLiRP3N6bR3MPFjlAIOWmDJJvs1ZZILgwquwRQeuRYXhunllPy9rvoLi3zRmlKRk+3Oj
         EpxYYYo0t4d2mZpogDoqlxCsX6VlW3AxkVR5mL20KFliNRViM65wmGsdYXnCeaRc9XF1
         k/qw==
X-Gm-Message-State: AO0yUKVo7jlyRXpTIyp+wtqzPymcAMnxk6ZGTwsy87VBMlSKs1VESK8c
        bAVoc5r2XwsV4j8ulBLSlIWLDWFggrjx+I7z
X-Google-Smtp-Source: AK7set/P+uyjm9fXrBOYRI4abHfY/L4KDqFquFyxTg0t3439k27vLw+pEvoEB+Q/ZARKVsW/NhuYMA==
X-Received: by 2002:aca:6741:0:b0:378:5987:6dc9 with SMTP id b1-20020aca6741000000b0037859876dc9mr4438335oiy.9.1677287756002;
        Fri, 24 Feb 2023 17:15:56 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:15:55 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 10/76] ssdfs: introduce PEB's block bitmap
Date:   Fri, 24 Feb 2023 17:08:21 -0800
Message-Id: <20230225010927.813929-11-slava@dubeyko.com>
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
Block (PEB). Generally speaking, PEB is fixed-sized container
that include some number of logical blocks (or NAND flash
pages). PEB has block bitmap with the goal to track the state
(free, pre-allocated, allocated, invalid) of logical blocks
and to account the physical space is used for storing log's
metadata (segment header, partial log header, footer).

Block bitmap implements API:
(1) create - create empty block bitmap
(2) destroy - destroy block bitmap object
(3) init - intialize block bitmap by metadata from PEB's log
(4) snapshot - take block bitmap snapshot for flush operation
(5) forget_snapshot - free block bitmap's snapshot resources
(6) lock/unlock - lock/unlock block bitmap
(7) test_block/test_range - check state of block or range of blocks
(8) get_free_pages - get number of free pages
(9) get_used_pages - get number of used pages
(10) get_invalid_pages - get number of invalid pages
(11) pre_allocate - pre_allocate logical block or range of blocks
(12) allocate - allocate logical block or range of blocks
(13) invalidate - invalidate logical block or range of blocks
(14) collect_garbage - get contigous range of blocks in state
(15) clean - convert the whole block bitmap into clean state

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/block_bitmap.c        | 1209 ++++++++++++++++++++++++++++++++
 fs/ssdfs/block_bitmap.h        |  370 ++++++++++
 fs/ssdfs/block_bitmap_tables.c |  310 ++++++++
 3 files changed, 1889 insertions(+)
 create mode 100644 fs/ssdfs/block_bitmap.c
 create mode 100644 fs/ssdfs/block_bitmap.h
 create mode 100644 fs/ssdfs/block_bitmap_tables.c

diff --git a/fs/ssdfs/block_bitmap.c b/fs/ssdfs/block_bitmap.c
new file mode 100644
index 000000000000..fd7e84258cf0
--- /dev/null
+++ b/fs/ssdfs/block_bitmap.c
@@ -0,0 +1,1209 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/block_bitmap.c - PEB's block bitmap implementation.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * Copyright (c) 2022-2023 Bytedance Ltd. and/or its affiliates.
+ *              https://www.bytedance.com/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ *                  Cong Wang
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
+#include "block_bitmap.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_block_bmap_page_leaks;
+atomic64_t ssdfs_block_bmap_memory_leaks;
+atomic64_t ssdfs_block_bmap_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_block_bmap_cache_leaks_increment(void *kaddr)
+ * void ssdfs_block_bmap_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_block_bmap_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_block_bmap_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_block_bmap_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_block_bmap_kfree(void *kaddr)
+ * struct page *ssdfs_block_bmap_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_block_bmap_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_block_bmap_free_page(struct page *page)
+ * void ssdfs_block_bmap_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(block_bmap)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(block_bmap)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_block_bmap_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_block_bmap_page_leaks, 0);
+	atomic64_set(&ssdfs_block_bmap_memory_leaks, 0);
+	atomic64_set(&ssdfs_block_bmap_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_block_bmap_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_block_bmap_page_leaks) != 0) {
+		SSDFS_ERR("BLOCK BMAP: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_block_bmap_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_block_bmap_memory_leaks) != 0) {
+		SSDFS_ERR("BLOCK BMAP: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_block_bmap_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_block_bmap_cache_leaks) != 0) {
+		SSDFS_ERR("BLOCK BMAP: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_block_bmap_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+extern const bool detect_free_blk[U8_MAX + 1];
+extern const bool detect_pre_allocated_blk[U8_MAX + 1];
+extern const bool detect_valid_blk[U8_MAX + 1];
+extern const bool detect_invalid_blk[U8_MAX + 1];
+
+#define ALIGNED_START_BLK(blk) ({ \
+	u32 aligned_blk; \
+	aligned_blk = (blk >> SSDFS_BLK_STATE_BITS) << SSDFS_BLK_STATE_BITS; \
+	aligned_blk; \
+})
+
+#define ALIGNED_END_BLK(blk) ({ \
+	u32 aligned_blk; \
+	aligned_blk = blk + SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS) - 1; \
+	aligned_blk >>= SSDFS_BLK_STATE_BITS; \
+	aligned_blk <<= SSDFS_BLK_STATE_BITS; \
+	aligned_blk; \
+})
+
+#define SSDFS_BLK_BMAP_STATE_FLAGS_FNS(state, name)			\
+static inline								\
+bool is_block_bmap_##name(struct ssdfs_block_bmap *blk_bmap)		\
+{									\
+	return atomic_read(&blk_bmap->flags) & SSDFS_BLK_BMAP_##state;	\
+}									\
+static inline								\
+void set_block_bmap_##name(struct ssdfs_block_bmap *blk_bmap)		\
+{									\
+	atomic_or(SSDFS_BLK_BMAP_##state, &blk_bmap->flags);		\
+}									\
+static inline								\
+void clear_block_bmap_##name(struct ssdfs_block_bmap *blk_bmap)		\
+{									\
+	atomic_and(~SSDFS_BLK_BMAP_##state, &blk_bmap->flags);		\
+}									\
+
+/*
+ * is_block_bmap_initialized()
+ * set_block_bmap_initialized()
+ * clear_block_bmap_initialized()
+ */
+SSDFS_BLK_BMAP_STATE_FLAGS_FNS(INITIALIZED, initialized)
+
+/*
+ * is_block_bmap_dirty()
+ * set_block_bmap_dirty()
+ * clear_block_bmap_dirty()
+ */
+SSDFS_BLK_BMAP_STATE_FLAGS_FNS(DIRTY, dirty)
+
+static
+int ssdfs_cache_block_state(struct ssdfs_block_bmap *blk_bmap,
+			    u32 blk, int blk_state);
+
+bool ssdfs_block_bmap_dirtied(struct ssdfs_block_bmap *blk_bmap)
+{
+	return is_block_bmap_dirty(blk_bmap);
+}
+
+bool ssdfs_block_bmap_initialized(struct ssdfs_block_bmap *blk_bmap)
+{
+	return is_block_bmap_initialized(blk_bmap);
+}
+
+void ssdfs_set_block_bmap_initialized(struct ssdfs_block_bmap *blk_bmap)
+{
+	set_block_bmap_initialized(blk_bmap);
+}
+
+void ssdfs_block_bmap_clear_dirty_state(struct ssdfs_block_bmap *blk_bmap)
+{
+	SSDFS_DBG("clear dirty state\n");
+	clear_block_bmap_dirty(blk_bmap);
+}
+
+static inline
+bool is_cache_invalid(struct ssdfs_block_bmap *blk_bmap, int blk_state);
+static
+int ssdfs_set_range_in_storage(struct ssdfs_block_bmap *blk_bmap,
+				struct ssdfs_block_bmap_range *range,
+				int blk_state);
+static
+int ssdfs_block_bmap_find_block_in_cache(struct ssdfs_block_bmap *blk_bmap,
+					 u32 start, u32 max_blk,
+					 int blk_state, u32 *found_blk);
+static
+int ssdfs_block_bmap_find_block(struct ssdfs_block_bmap *blk_bmap,
+				u32 start, u32 max_blk, int blk_state,
+				u32 *found_blk);
+
+#ifdef CONFIG_SSDFS_DEBUG
+static
+void ssdfs_debug_block_bitmap(struct ssdfs_block_bmap *bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+/*
+ * ssdfs_block_bmap_storage_destroy() - destroy block bitmap's storage
+ * @storage: pointer on block bitmap's storage
+ */
+static
+void ssdfs_block_bmap_storage_destroy(struct ssdfs_block_bmap_storage *storage)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!storage);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (storage->state) {
+	case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+		ssdfs_page_vector_release(&storage->array);
+		ssdfs_page_vector_destroy(&storage->array);
+		break;
+
+	case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+		if (storage->buf)
+			ssdfs_block_bmap_kfree(storage->buf);
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x\n", storage->state);
+		break;
+	}
+
+	storage->state = SSDFS_BLOCK_BMAP_STORAGE_ABSENT;
+}
+
+/*
+ * ssdfs_block_bmap_destroy() - destroy PEB's block bitmap
+ * @blk_bmap: pointer on block bitmap
+ *
+ * This function releases memory pages of pagevec and
+ * to free memory of ssdfs_block_bmap structure.
+ */
+void ssdfs_block_bmap_destroy(struct ssdfs_block_bmap *blk_bmap)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap);
+
+	SSDFS_DBG("blk_bmap %p, items count %zu, "
+		  "bmap bytes %zu\n",
+		  blk_bmap, blk_bmap->items_count,
+		  blk_bmap->bytes_count);
+
+	if (mutex_is_locked(&blk_bmap->lock))
+		SSDFS_WARN("block bitmap's mutex is locked\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_block_bmap_initialized(blk_bmap))
+		SSDFS_WARN("block bitmap hasn't been initialized\n");
+
+	if (is_block_bmap_dirty(blk_bmap))
+		SSDFS_WARN("block bitmap is dirty\n");
+
+	ssdfs_block_bmap_storage_destroy(&blk_bmap->storage);
+}
+
+/*
+ * ssdfs_block_bmap_create_empty_storage() - create block bitmap's storage
+ * @storage: pointer on block bitmap's storage
+ * @bmap_bytes: number of bytes in block bitmap
+ */
+static
+int ssdfs_block_bmap_create_empty_storage(struct ssdfs_block_bmap_storage *ptr,
+					  size_t bmap_bytes)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr);
+
+	SSDFS_DBG("storage %p, bmap_bytes %zu\n",
+		  ptr, bmap_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr->state = SSDFS_BLOCK_BMAP_STORAGE_ABSENT;
+
+	if (bmap_bytes > PAGE_SIZE) {
+		size_t capacity = (bmap_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(capacity >= U8_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_page_vector_create(&ptr->array, (u8)capacity);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create page vector: "
+				  "bmap_bytes %zu, capacity %zu, err %d\n",
+				  bmap_bytes, capacity, err);
+			return err;
+		}
+
+		err = ssdfs_page_vector_init(&ptr->array);
+		if (unlikely(err)) {
+			ssdfs_page_vector_destroy(&ptr->array);
+			SSDFS_ERR("fail to init page vector: "
+				  "bmap_bytes %zu, capacity %zu, err %d\n",
+				  bmap_bytes, capacity, err);
+			return err;
+		}
+
+		ptr->state = SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC;
+	} else {
+		ptr->buf = ssdfs_block_bmap_kmalloc(bmap_bytes, GFP_KERNEL);
+		if (!ptr->buf) {
+			SSDFS_ERR("fail to allocate memory: "
+				  "bmap_bytes %zu\n",
+				  bmap_bytes);
+			return -ENOMEM;
+		}
+
+		ptr->state = SSDFS_BLOCK_BMAP_STORAGE_BUFFER;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_init_clean_storage() - init clean block bitmap
+ * @ptr: pointer on block bitmap object
+ * @bmap_pages: memory pages count in block bitmap
+ *
+ * This function initializes storage space of the clean
+ * block bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_block_bmap_init_clean_storage(struct ssdfs_block_bmap *ptr,
+					size_t bmap_pages)
+{
+	struct ssdfs_page_vector *array;
+	struct page *page;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr);
+
+	SSDFS_DBG("bmap %p, storage_state %#x, "
+		  "bmap_bytes %zu, bmap_pages %zu\n",
+		  ptr, ptr->storage.state,
+		  ptr->bytes_count, bmap_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (ptr->storage.state) {
+	case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+		array = &ptr->storage.array;
+
+		if (ssdfs_page_vector_space(array) < bmap_pages) {
+			SSDFS_ERR("page vector capacity is not enough: "
+				  "capacity %u, free_space %u, "
+				  "bmap_pages %zu\n",
+				  ssdfs_page_vector_capacity(array),
+				  ssdfs_page_vector_space(array),
+				  bmap_pages);
+			return -ENOMEM;
+		}
+
+		page = ssdfs_page_vector_allocate(array);
+		if (IS_ERR_OR_NULL(page)) {
+			err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+			SSDFS_ERR("unable to allocate #%d page\n", i);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+		memset(ptr->storage.buf, 0, ptr->bytes_count);
+		break;
+
+	default:
+		SSDFS_ERR("unexpected state %#x\n", ptr->storage.state);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_create() - construct PEB's block bitmap
+ * @fsi: file system info object
+ * @ptr: pointer on block bitmap object
+ * @items_count: count of described items
+ * @flag: define necessity to allocate memory
+ * @init_state: block state is used during initialization
+ *
+ * This function prepares page vector and
+ * makes initialization of ssdfs_block_bmap structure.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EOPNOTSUPP - pagevec is too small for block bitmap
+ *                representation.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+int ssdfs_block_bmap_create(struct ssdfs_fs_info *fsi,
+			    struct ssdfs_block_bmap *ptr,
+			    u32 items_count,
+			    int flag, int init_state)
+{
+	int max_capacity = SSDFS_BLK_BMAP_FRAGMENTS_CHAIN_MAX;
+	size_t bmap_bytes = 0;
+	size_t bmap_pages = 0;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !ptr);
+
+	if (init_state > SSDFS_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid block state %#x\n", init_state);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("fsi %p, pagesize %u, segsize %u, pages_per_seg %u, "
+		  "items_count %u, flag %#x, init_state %#x\n",
+		  fsi, fsi->pagesize, fsi->segsize, fsi->pages_per_seg,
+		  items_count, flag, init_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bmap_bytes = BLK_BMAP_BYTES(items_count);
+	bmap_pages = (bmap_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+
+	if (bmap_pages > max_capacity) {
+		SSDFS_WARN("unable to allocate bmap with %zu pages\n",
+			    bmap_pages);
+		return -EOPNOTSUPP;
+	}
+
+	mutex_init(&ptr->lock);
+	atomic_set(&ptr->flags, 0);
+	ptr->bytes_count = bmap_bytes;
+	ptr->items_count = items_count;
+	ptr->metadata_items = 0;
+	ptr->used_blks = 0;
+	ptr->invalid_blks = 0;
+
+	err = ssdfs_block_bmap_create_empty_storage(&ptr->storage, bmap_bytes);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create empty bmap's storage: "
+			  "bmap_bytes %zu, err %d\n",
+			  bmap_bytes, err);
+		return err;
+	}
+
+	for (i = 0; i < SSDFS_SEARCH_TYPE_MAX; i++) {
+		ptr->last_search[i].page_index = max_capacity;
+		ptr->last_search[i].offset = U16_MAX;
+	}
+
+	if (flag == SSDFS_BLK_BMAP_INIT)
+		goto alloc_end;
+
+	err = ssdfs_block_bmap_init_clean_storage(ptr, bmap_pages);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init clean bmap's storage: "
+			  "bmap_bytes %zu, bmap_pages %zu, err %d\n",
+			  bmap_bytes, bmap_pages, err);
+		goto destroy_pagevec;
+	}
+
+	if (init_state != SSDFS_BLK_FREE) {
+		struct ssdfs_block_bmap_range range = {0, ptr->items_count};
+
+		err = ssdfs_set_range_in_storage(ptr, &range, init_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to initialize block bmap: "
+				  "range (start %u, len %u), "
+				  "init_state %#x, err %d\n",
+				  range.start, range.len, init_state, err);
+			goto destroy_pagevec;
+		}
+	}
+
+	err = ssdfs_cache_block_state(ptr, 0, SSDFS_BLK_FREE);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to cache last free page: err %d\n",
+			  err);
+		goto destroy_pagevec;
+	}
+
+	set_block_bmap_initialized(ptr);
+
+alloc_end:
+	return 0;
+
+destroy_pagevec:
+	ssdfs_block_bmap_destroy(ptr);
+	return err;
+}
+
+/*
+ * ssdfs_block_bmap_init_storage() - initialize block bitmap storage
+ * @blk_bmap: pointer on block bitmap
+ * @source: prepared pagevec after reading from volume
+ *
+ * This function initializes block bitmap's storage on
+ * the basis of pages @source are read from volume.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_block_bmap_init_storage(struct ssdfs_block_bmap *blk_bmap,
+				  struct ssdfs_page_vector *source)
+{
+	struct ssdfs_page_vector *array;
+	struct page *page;
+#ifdef CONFIG_SSDFS_DEBUG
+	void *kaddr;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !source);
+
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("bmap %p, bmap_bytes %zu\n",
+		  blk_bmap, blk_bmap->bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	array = &blk_bmap->storage.array;
+
+	if (blk_bmap->storage.state != SSDFS_BLOCK_BMAP_STORAGE_ABSENT) {
+		switch (blk_bmap->storage.state) {
+		case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+			ssdfs_page_vector_release(array);
+			break;
+
+		case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+			/* Do nothing. We have buffer already */
+			break;
+
+		default:
+			BUG();
+		}
+	} else {
+		err = ssdfs_block_bmap_create_empty_storage(&blk_bmap->storage,
+							blk_bmap->bytes_count);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create empty bmap's storage: "
+				  "err %d\n", err);
+			return err;
+		}
+	}
+
+	switch (blk_bmap->storage.state) {
+	case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+		for (i = 0; i < ssdfs_page_vector_count(source); i++) {
+			page = ssdfs_page_vector_remove(source, i);
+			if (IS_ERR_OR_NULL(page)) {
+				SSDFS_WARN("page %d is NULL\n", i);
+				return -ERANGE;
+			}
+
+			ssdfs_lock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			kaddr = kmap_local_page(page);
+			SSDFS_DBG("BMAP INIT\n");
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					     kaddr, 32);
+			kunmap_local(kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = ssdfs_page_vector_add(array, page);
+			ssdfs_unlock_page(page);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add page: "
+					  "page_index %d, err %d\n",
+					  i, err);
+				return err;
+			}
+		}
+
+		err = ssdfs_page_vector_reinit(source);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to reinit page vector: "
+				  "err %d\n", err);
+			return err;
+		}
+		break;
+
+	case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+		if (ssdfs_page_vector_count(source)  > 1) {
+			SSDFS_ERR("invalid source pvec size %u\n",
+				  ssdfs_page_vector_count(source));
+			return -ERANGE;
+		}
+
+		page = ssdfs_page_vector_remove(source, 0);
+
+		if (!page) {
+			SSDFS_WARN("page %d is NULL\n", 0);
+			return -ERANGE;
+		}
+
+		ssdfs_lock_page(page);
+
+		ssdfs_memcpy_from_page(blk_bmap->storage.buf,
+				       0, blk_bmap->bytes_count,
+				       page, 0, PAGE_SIZE,
+				       blk_bmap->bytes_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		kaddr = kmap_local_page(page);
+		SSDFS_DBG("BMAP INIT\n");
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, 32);
+		kunmap_local(kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_unlock_page(page);
+
+		ssdfs_block_bmap_account_page(page);
+		ssdfs_block_bmap_free_page(page);
+
+		ssdfs_page_vector_release(source);
+		break;
+
+	default:
+		SSDFS_ERR("unexpected state %#x\n",
+			  blk_bmap->storage.state);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pvec %p, pagevec count %u\n",
+		  source, ssdfs_page_vector_count(source));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+static
+int ssdfs_block_bmap_find_range(struct ssdfs_block_bmap *blk_bmap,
+				u32 start, u32 len, u32 max_blk,
+				int blk_state,
+				struct ssdfs_block_bmap_range *range);
+
+/*
+ * ssdfs_block_bmap_init() - initialize block bitmap pagevec
+ * @blk_bmap: pointer on block bitmap
+ * @source: prepared pagevec after reading from volume
+ * @last_free_blk: saved on volume last free page
+ * @metadata_blks: saved on volume reserved metadata blocks count
+ * @invalid_blks: saved on volume count of invalid blocks
+ *
+ * This function initializes block bitmap's pagevec on
+ * the basis of pages @source are read from volume.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+int ssdfs_block_bmap_init(struct ssdfs_block_bmap *blk_bmap,
+			  struct ssdfs_page_vector *source,
+			  u32 last_free_blk,
+			  u32 metadata_blks,
+			  u32 invalid_blks)
+{
+	struct ssdfs_block_bmap_range found;
+	int max_capacity = SSDFS_BLK_BMAP_FRAGMENTS_CHAIN_MAX;
+	u32 start_item;
+	int blk_state;
+	int free_pages;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !source);
+
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, source %p, "
+		  "last_free_blk %u, metadata_blks %u, invalid_blks %u\n",
+		  blk_bmap, source,
+		  last_free_blk, metadata_blks, invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_block_bmap_initialized(blk_bmap)) {
+		if (is_block_bmap_dirty(blk_bmap)) {
+			SSDFS_WARN("block bitmap has been initialized\n");
+			return -ERANGE;
+		}
+
+		free_pages = ssdfs_block_bmap_get_free_pages(blk_bmap);
+		if (unlikely(free_pages < 0)) {
+			err = free_pages;
+			SSDFS_ERR("fail to define free pages: err %d\n",
+				  err);
+			return err;
+		}
+
+		if (free_pages != blk_bmap->items_count) {
+			SSDFS_WARN("block bitmap has been initialized\n");
+			return -ERANGE;
+		}
+
+		for (i = 0; i < SSDFS_SEARCH_TYPE_MAX; i++) {
+			blk_bmap->last_search[i].page_index = max_capacity;
+			blk_bmap->last_search[i].offset = U16_MAX;
+		}
+
+		ssdfs_block_bmap_storage_destroy(&blk_bmap->storage);
+		clear_block_bmap_initialized(blk_bmap);
+	}
+
+	if (ssdfs_page_vector_count(source) == 0) {
+		SSDFS_ERR("fail to init because of empty pagevec\n");
+		return -EINVAL;
+	}
+
+	if (last_free_blk > blk_bmap->items_count) {
+		SSDFS_ERR("invalid values: "
+			  "last_free_blk %u, items_count %zu\n",
+			  last_free_blk, blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	if (metadata_blks > blk_bmap->items_count) {
+		SSDFS_ERR("invalid values: "
+			  "metadata_blks %u, items_count %zu\n",
+			  metadata_blks, blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	blk_bmap->metadata_items = metadata_blks;
+
+	if (invalid_blks > blk_bmap->items_count) {
+		SSDFS_ERR("invalid values: "
+			  "invalid_blks %u, last_free_blk %u, "
+			  "items_count %zu\n",
+			  invalid_blks, last_free_blk,
+			  blk_bmap->items_count);
+		return -EINVAL;
+	}
+
+	blk_bmap->invalid_blks = invalid_blks;
+
+	err = ssdfs_block_bmap_init_storage(blk_bmap, source);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init bmap's storage: err %d\n",
+			  err);
+		return err;
+	}
+
+	err = ssdfs_cache_block_state(blk_bmap, last_free_blk, SSDFS_BLK_FREE);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to cache last free page %u, err %d\n",
+			  last_free_blk, err);
+		return err;
+	}
+
+	blk_bmap->used_blks = 0;
+
+	start_item = 0;
+	blk_state = SSDFS_BLK_VALID;
+
+	do {
+		err = ssdfs_block_bmap_find_range(blk_bmap,
+					start_item,
+					blk_bmap->items_count - start_item,
+					blk_bmap->items_count,
+					blk_state, &found);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find more valid blocks: "
+				  "start_item %u\n",
+				  start_item);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto check_pre_allocated_blocks;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find range: err %d\n", err);
+			return err;
+		}
+
+		blk_bmap->used_blks += found.len;
+		start_item = found.start + found.len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("VALID_BLK: range (start %u, len %u)\n",
+			  found.start, found.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} while (start_item < blk_bmap->items_count);
+
+check_pre_allocated_blocks:
+	start_item = 0;
+	blk_state = SSDFS_BLK_PRE_ALLOCATED;
+
+	do {
+		err = ssdfs_block_bmap_find_range(blk_bmap,
+					start_item,
+					blk_bmap->items_count - start_item,
+					blk_bmap->items_count,
+					blk_state, &found);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find more pre-allocated blocks: "
+				  "start_item %u\n",
+				  start_item);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_block_bmap_init;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find range: err %d\n", err);
+			return err;
+		}
+
+		blk_bmap->used_blks += found.len;
+		start_item = found.start + found.len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("PRE_ALLOCATED_BLK: range (start %u, len %u)\n",
+			  found.start, found.len);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} while (start_item < blk_bmap->items_count);
+
+finish_block_bmap_init:
+	set_block_bmap_initialized(blk_bmap);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	ssdfs_debug_block_bitmap(blk_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_define_last_free_page() - define last free page
+ * @blk_bmap: pointer on block bitmap
+ * @found_blk: found last free page [out]
+ */
+static
+int ssdfs_define_last_free_page(struct ssdfs_block_bmap *blk_bmap,
+				u32 *found_blk)
+{
+	int cache_type;
+	struct ssdfs_last_bmap_search *last_search;
+	u32 first_cached_blk;
+	u32 max_blk;
+	u32 items_per_long = SSDFS_ITEMS_PER_LONG(SSDFS_BLK_STATE_BITS);
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("blk_bmap %p, found_blk %p\n",
+		  blk_bmap, found_blk);
+
+	BUG_ON(!blk_bmap || !found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	cache_type = SSDFS_GET_CACHE_TYPE(SSDFS_BLK_FREE);
+	max_blk = blk_bmap->items_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(cache_type >= SSDFS_SEARCH_TYPE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_cache_invalid(blk_bmap, SSDFS_BLK_FREE)) {
+		err = ssdfs_block_bmap_find_block(blk_bmap,
+						  0, max_blk,
+						  SSDFS_BLK_FREE,
+						  found_blk);
+		if (err == -ENODATA) {
+			*found_blk = blk_bmap->items_count;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find last free block: "
+				  "found_blk %u\n",
+				  *found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_define_last_free_page;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find last free block: err %d\n",
+				  err);
+			return err;
+		}
+	} else {
+		last_search = &blk_bmap->last_search[cache_type];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("last_search.cache %lx\n", last_search->cache);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		first_cached_blk = SSDFS_FIRST_CACHED_BLOCK(last_search);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("first_cached_blk %u\n",
+			  first_cached_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_block_bmap_find_block_in_cache(blk_bmap,
+							   first_cached_blk,
+							   max_blk,
+							   SSDFS_BLK_FREE,
+							   found_blk);
+		if (err == -ENODATA) {
+			first_cached_blk += items_per_long;
+			err = ssdfs_block_bmap_find_block(blk_bmap,
+							  first_cached_blk,
+							  max_blk,
+							  SSDFS_BLK_FREE,
+							  found_blk);
+			if (err == -ENODATA) {
+				*found_blk = blk_bmap->items_count;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to find last free block: "
+					  "found_blk %u\n",
+					  *found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_define_last_free_page;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to find last free block: err %d\n",
+					  err);
+				return err;
+			}
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find last free block: err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+finish_define_last_free_page:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last free block: %u\n", *found_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_snapshot_storage() - make snapshot of bmap's storage
+ * @blk_bmap: pointer on block bitmap
+ * @snapshot: pagevec with snapshot of block bitmap state [out]
+ *
+ * This function copies pages of block bitmap's styorage into
+ * @snapshot pagevec.
+ *
+ * RETURN:
+ * [success] - @snapshot contains copy of block bitmap's state
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_block_bmap_snapshot_storage(struct ssdfs_block_bmap *blk_bmap,
+					struct ssdfs_page_vector *snapshot)
+{
+	struct ssdfs_page_vector *array;
+	struct page *page;
+#ifdef CONFIG_SSDFS_DEBUG
+	void *kaddr;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !snapshot);
+	BUG_ON(ssdfs_page_vector_count(snapshot) != 0);
+
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap's mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, snapshot %p\n",
+		  blk_bmap, snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (blk_bmap->storage.state) {
+	case SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC:
+		array = &blk_bmap->storage.array;
+
+		for (i = 0; i < ssdfs_page_vector_count(array); i++) {
+			page = ssdfs_block_bmap_alloc_page(GFP_KERNEL);
+			if (IS_ERR_OR_NULL(page)) {
+				err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+				SSDFS_ERR("unable to allocate #%d page\n", i);
+				return err;
+			}
+
+			ssdfs_memcpy_page(page, 0, PAGE_SIZE,
+					  array->pages[i], 0, PAGE_SIZE,
+					  PAGE_SIZE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			kaddr = kmap_local_page(page);
+			SSDFS_DBG("BMAP SNAPSHOT\n");
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					     kaddr, 32);
+			kunmap_local(kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_block_bmap_forget_page(page);
+			err = ssdfs_page_vector_add(snapshot, page);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add page: "
+					  "index %d, err %d\n",
+					  i, err);
+				return err;
+			}
+		}
+
+		for (; i < ssdfs_page_vector_capacity(array); i++) {
+			page = ssdfs_block_bmap_alloc_page(GFP_KERNEL);
+			if (IS_ERR_OR_NULL(page)) {
+				err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+				SSDFS_ERR("unable to allocate #%d page\n", i);
+				return err;
+			}
+
+			ssdfs_memzero_page(page, 0, PAGE_SIZE, PAGE_SIZE);
+
+			ssdfs_block_bmap_forget_page(page);
+			err = ssdfs_page_vector_add(snapshot, page);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add page: "
+					  "index %d, err %d\n",
+					  i, err);
+				return err;
+			}
+		}
+		break;
+
+	case SSDFS_BLOCK_BMAP_STORAGE_BUFFER:
+		page = ssdfs_block_bmap_alloc_page(GFP_KERNEL);
+		if (IS_ERR_OR_NULL(page)) {
+			err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+			SSDFS_ERR("unable to allocate memory page\n");
+			return err;
+		}
+
+		ssdfs_memcpy_to_page(page,
+				     0, PAGE_SIZE,
+				     blk_bmap->storage.buf,
+				     0, blk_bmap->bytes_count,
+				     blk_bmap->bytes_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		kaddr = kmap_local_page(page);
+		SSDFS_DBG("BMAP SNAPSHOT\n");
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr, 32);
+		kunmap_local(kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_block_bmap_forget_page(page);
+		err = ssdfs_page_vector_add(snapshot, page);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add page: "
+				  "err %d\n", err);
+			return err;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("unexpected state %#x\n",
+			  blk_bmap->storage.state);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_block_bmap_snapshot() - make snapshot of block bitmap's pagevec
+ * @blk_bmap: pointer on block bitmap
+ * @snapshot: pagevec with snapshot of block bitmap state [out]
+ * @last_free_blk: pointer on last free page value [out]
+ * @metadata_blks: pointer on reserved metadata pages count [out]
+ * @invalid_blks: pointer on invalid blocks count [out]
+ * @bytes_count: size of block bitmap in bytes [out]
+ *
+ * This function copy pages of block bitmap's pagevec into
+ * @snapshot pagevec.
+ *
+ * RETURN:
+ * [success] - @snapshot contains copy of block bitmap's state
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+int ssdfs_block_bmap_snapshot(struct ssdfs_block_bmap *blk_bmap,
+				struct ssdfs_page_vector *snapshot,
+				u32 *last_free_page,
+				u32 *metadata_blks,
+				u32 *invalid_blks,
+				size_t *bytes_count)
+{
+	u32 used_pages;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!blk_bmap || !snapshot);
+	BUG_ON(!last_free_page || !metadata_blks || !bytes_count);
+	BUG_ON(ssdfs_page_vector_count(snapshot) != 0);
+
+	if (!mutex_is_locked(&blk_bmap->lock)) {
+		SSDFS_WARN("block bitmap's mutex should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("blk_bmap %p, snapshot %p, last_free_page %p, "
+		  "metadata_blks %p, bytes_count %p\n",
+		  blk_bmap, snapshot, last_free_page,
+		  metadata_blks, bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_block_bmap_initialized(blk_bmap)) {
+		SSDFS_WARN("block bitmap hasn't been initialized\n");
+		return -EINVAL;
+	}
+
+	err = ssdfs_block_bmap_snapshot_storage(blk_bmap, snapshot);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to snapshot bmap's storage: err %d\n", err);
+		goto cleanup_snapshot_pagevec;
+	}
+
+	err = ssdfs_define_last_free_page(blk_bmap, last_free_page);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define last free page: err %d\n", err);
+		goto cleanup_snapshot_pagevec;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("bytes_count %zu, items_count %zu, "
+		  "metadata_items %u, used_blks %u, invalid_blks %u, "
+		  "last_free_page %u\n",
+		  blk_bmap->bytes_count, blk_bmap->items_count,
+		  blk_bmap->metadata_items, blk_bmap->used_blks,
+		  blk_bmap->invalid_blks, *last_free_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (*last_free_page >= blk_bmap->items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid last_free_page: "
+			  "bytes_count %zu, items_count %zu, "
+			  "metadata_items %u, used_blks %u, invalid_blks %u, "
+			  "last_free_page %u\n",
+			  blk_bmap->bytes_count, blk_bmap->items_count,
+			  blk_bmap->metadata_items, blk_bmap->used_blks,
+			  blk_bmap->invalid_blks, *last_free_page);
+		goto cleanup_snapshot_pagevec;
+	}
+
+	*metadata_blks = blk_bmap->metadata_items;
+	*invalid_blks = blk_bmap->invalid_blks;
+	*bytes_count = blk_bmap->bytes_count;
+
+	used_pages = blk_bmap->used_blks + blk_bmap->invalid_blks +
+			blk_bmap->metadata_items;
+
+	if (used_pages > blk_bmap->items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid values: "
+			  "bytes_count %zu, items_count %zu, "
+			  "metadata_items %u, used_blks %u, invalid_blks %u, "
+			  "last_free_page %u\n",
+			  blk_bmap->bytes_count, blk_bmap->items_count,
+			  blk_bmap->metadata_items, blk_bmap->used_blks,
+			  blk_bmap->invalid_blks, *last_free_page);
+		goto cleanup_snapshot_pagevec;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("clear dirty state\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	clear_block_bmap_dirty(blk_bmap);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("last_free_page %u, metadata_blks %u, "
+		  "bytes_count %zu\n",
+		  *last_free_page, *metadata_blks, *bytes_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+
+cleanup_snapshot_pagevec:
+	ssdfs_page_vector_release(snapshot);
+	return err;
+}
+
+void ssdfs_block_bmap_forget_snapshot(struct ssdfs_page_vector *snapshot)
+{
+	if (!snapshot)
+		return;
+
+	ssdfs_page_vector_release(snapshot);
+}
diff --git a/fs/ssdfs/block_bitmap.h b/fs/ssdfs/block_bitmap.h
new file mode 100644
index 000000000000..0b036eab3707
--- /dev/null
+++ b/fs/ssdfs/block_bitmap.h
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/block_bitmap.h - PEB's block bitmap declarations.
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
+#ifndef _SSDFS_BLOCK_BITMAP_H
+#define _SSDFS_BLOCK_BITMAP_H
+
+#include "common_bitmap.h"
+
+#define SSDFS_BLK_STATE_BITS	2
+#define SSDFS_BLK_STATE_MASK	0x3
+
+enum {
+	SSDFS_BLK_FREE		= 0x0,
+	SSDFS_BLK_PRE_ALLOCATED	= 0x1,
+	SSDFS_BLK_VALID		= 0x3,
+	SSDFS_BLK_INVALID	= 0x2,
+	SSDFS_BLK_STATE_MAX	= SSDFS_BLK_VALID + 1,
+};
+
+#define SSDFS_FREE_STATES_BYTE		0x00
+#define SSDFS_PRE_ALLOC_STATES_BYTE	0x55
+#define SSDFS_VALID_STATES_BYTE		0xFF
+#define SSDFS_INVALID_STATES_BYTE	0xAA
+
+#define SSDFS_BLK_BMAP_BYTE(blk_state)({ \
+	u8 value; \
+	switch (blk_state) { \
+	case SSDFS_BLK_FREE: \
+		value = SSDFS_FREE_STATES_BYTE; \
+		break; \
+	case SSDFS_BLK_PRE_ALLOCATED: \
+		value = SSDFS_PRE_ALLOC_STATES_BYTE; \
+		break; \
+	case SSDFS_BLK_VALID: \
+		value = SSDFS_VALID_STATES_BYTE; \
+		break; \
+	case SSDFS_BLK_INVALID: \
+		value = SSDFS_INVALID_STATES_BYTE; \
+		break; \
+	default: \
+		BUG(); \
+	}; \
+	value; \
+})
+
+#define BLK_BMAP_BYTES(items_count) \
+	((items_count + SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS) - 1)  / \
+	 SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS))
+
+static inline
+int SSDFS_BLK2PAGE(u32 blk, u8 item_bits, u16 *offset)
+{
+	u32 blks_per_byte = SSDFS_ITEMS_PER_BYTE(item_bits);
+	u32 blks_per_long = SSDFS_ITEMS_PER_LONG(item_bits);
+	u32 blks_per_page = PAGE_SIZE * blks_per_byte;
+	u32 off;
+
+	if (offset) {
+		off = (blk % blks_per_page) / blks_per_long;
+		off *= sizeof(unsigned long);
+		BUG_ON(off >= U16_MAX);
+		*offset = off;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("blk %u, item_bits %u, blks_per_byte %u, "
+		  "blks_per_long %u, blks_per_page %u, "
+		  "page_index %u\n",
+		  blk, item_bits, blks_per_byte,
+		  blks_per_long, blks_per_page,
+		  blk / blks_per_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return blk / blks_per_page;
+}
+
+/*
+ * struct ssdfs_last_bmap_search - last search in bitmap
+ * @page_index: index of page in pagevec
+ * @offset: offset of cache from page's begining
+ * @cache: cached bmap's part
+ */
+struct ssdfs_last_bmap_search {
+	int page_index;
+	u16 offset;
+	unsigned long cache;
+};
+
+static inline
+u32 SSDFS_FIRST_CACHED_BLOCK(struct ssdfs_last_bmap_search *search)
+{
+	u32 blks_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS);
+	u32 blks_per_page = PAGE_SIZE * blks_per_byte;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_index %d, offset %u, "
+		  "blks_per_byte %u, blks_per_page %u\n",
+		  search->page_index,
+		  search->offset,
+		  blks_per_byte, blks_per_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (search->page_index * blks_per_page) +
+		(search->offset * blks_per_byte);
+}
+
+enum {
+	SSDFS_FREE_BLK_SEARCH,
+	SSDFS_VALID_BLK_SEARCH,
+	SSDFS_OTHER_BLK_SEARCH,
+	SSDFS_SEARCH_TYPE_MAX,
+};
+
+static inline
+int SSDFS_GET_CACHE_TYPE(int blk_state)
+{
+	switch (blk_state) {
+	case SSDFS_BLK_FREE:
+		return SSDFS_FREE_BLK_SEARCH;
+
+	case SSDFS_BLK_VALID:
+		return SSDFS_VALID_BLK_SEARCH;
+
+	case SSDFS_BLK_PRE_ALLOCATED:
+	case SSDFS_BLK_INVALID:
+		return SSDFS_OTHER_BLK_SEARCH;
+	};
+
+	return SSDFS_SEARCH_TYPE_MAX;
+}
+
+#define SSDFS_BLK_BMAP_INITIALIZED	(1 << 0)
+#define SSDFS_BLK_BMAP_DIRTY		(1 << 1)
+
+/*
+ * struct ssdfs_block_bmap_storage - block bitmap's storage
+ * @state: storage state
+ * @array: vector of pages
+ * @buf: pointer on memory buffer
+ */
+struct ssdfs_block_bmap_storage {
+	int state;
+	struct ssdfs_page_vector array;
+	void *buf;
+};
+
+/* Block bitmap's storage's states */
+enum {
+	SSDFS_BLOCK_BMAP_STORAGE_ABSENT,
+	SSDFS_BLOCK_BMAP_STORAGE_PAGE_VEC,
+	SSDFS_BLOCK_BMAP_STORAGE_BUFFER,
+	SSDFS_BLOCK_BMAP_STORAGE_STATE_MAX
+};
+
+/*
+ * struct ssdfs_block_bmap - in-core segment's block bitmap
+ * @lock: block bitmap lock
+ * @flags: block bitmap state flags
+ * @storage: block bitmap's storage
+ * @bytes_count: block bitmap size in bytes
+ * @items_count: items count in bitmap
+ * @metadata_items: count of metadata items
+ * @used_blks: count of valid blocks
+ * @invalid_blks: count of invalid blocks
+ * @last_search: last search/access cache array
+ */
+struct ssdfs_block_bmap {
+	struct mutex lock;
+	atomic_t flags;
+	struct ssdfs_block_bmap_storage storage;
+	size_t bytes_count;
+	size_t items_count;
+	u32 metadata_items;
+	u32 used_blks;
+	u32 invalid_blks;
+	struct ssdfs_last_bmap_search last_search[SSDFS_SEARCH_TYPE_MAX];
+};
+
+/*
+ * compare_block_bmap_ranges() - compare two ranges
+ * @range1: left range
+ * @range2: right range
+ *
+ * RETURN:
+ *  0: range1 == range2
+ * -1: range1 < range2
+ *  1: range1 > range2
+ */
+static inline
+int compare_block_bmap_ranges(struct ssdfs_block_bmap_range *range1,
+				struct ssdfs_block_bmap_range *range2)
+{
+	u32 range1_end, range2_end;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!range1 || !range2);
+
+	SSDFS_DBG("range1 (start %u, len %u), range2 (start %u, len %u)\n",
+		  range1->start, range1->len, range2->start, range2->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range1->start == range2->start) {
+		if (range1->len == range2->len)
+			return 0;
+		else if (range1->len < range2->len)
+			return -1;
+		else
+			return 1;
+	} else if (range1->start < range2->start) {
+		range1_end = range1->start + range1->len;
+		range2_end = range2->start + range2->len;
+
+		if (range2_end <= range1_end)
+			return 1;
+		else
+			return -1;
+	}
+
+	/* range1->start > range2->start */
+	return -1;
+}
+
+/*
+ * ranges_have_intersection() - have ranges intersection?
+ * @range1: left range
+ * @range2: right range
+ *
+ * RETURN:
+ * [true]  - ranges have intersection
+ * [false] - ranges doesn't intersect
+ */
+static inline
+bool ranges_have_intersection(struct ssdfs_block_bmap_range *range1,
+				struct ssdfs_block_bmap_range *range2)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!range1 || !range2);
+
+	SSDFS_DBG("range1 (start %u, len %u), range2 (start %u, len %u)\n",
+		  range1->start, range1->len, range2->start, range2->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((range2->start + range2->len) <= range1->start)
+		return false;
+	else if ((range1->start + range1->len) <= range2->start)
+		return false;
+
+	return true;
+}
+
+enum {
+	SSDFS_BLK_BMAP_CREATE,
+	SSDFS_BLK_BMAP_INIT,
+};
+
+/* Function prototypes */
+int ssdfs_block_bmap_create(struct ssdfs_fs_info *fsi,
+			    struct ssdfs_block_bmap *bmap,
+			    u32 items_count,
+			    int flag, int init_state);
+void ssdfs_block_bmap_destroy(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_init(struct ssdfs_block_bmap *blk_bmap,
+			  struct ssdfs_page_vector *source,
+			  u32 last_free_blk,
+			  u32 metadata_blks,
+			  u32 invalid_blks);
+int ssdfs_block_bmap_snapshot(struct ssdfs_block_bmap *blk_bmap,
+				struct ssdfs_page_vector *snapshot,
+				u32 *last_free_page,
+				u32 *metadata_blks,
+				u32 *invalid_blks,
+				size_t *bytes_count);
+void ssdfs_block_bmap_forget_snapshot(struct ssdfs_page_vector *snapshot);
+
+int ssdfs_block_bmap_lock(struct ssdfs_block_bmap *blk_bmap);
+bool ssdfs_block_bmap_is_locked(struct ssdfs_block_bmap *blk_bmap);
+void ssdfs_block_bmap_unlock(struct ssdfs_block_bmap *blk_bmap);
+
+bool ssdfs_block_bmap_dirtied(struct ssdfs_block_bmap *blk_bmap);
+void ssdfs_block_bmap_clear_dirty_state(struct ssdfs_block_bmap *blk_bmap);
+bool ssdfs_block_bmap_initialized(struct ssdfs_block_bmap *blk_bmap);
+void ssdfs_set_block_bmap_initialized(struct ssdfs_block_bmap *blk_bmap);
+
+bool ssdfs_block_bmap_test_block(struct ssdfs_block_bmap *blk_bmap,
+				 u32 blk, int blk_state);
+bool ssdfs_block_bmap_test_range(struct ssdfs_block_bmap *blk_bmap,
+				 struct ssdfs_block_bmap_range *range,
+				 int blk_state);
+int ssdfs_get_block_state(struct ssdfs_block_bmap *blk_bmap, u32 blk);
+int ssdfs_get_range_state(struct ssdfs_block_bmap *blk_bmap,
+			  struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_reserve_metadata_pages(struct ssdfs_block_bmap *blk_bmap,
+					    u32 count);
+int ssdfs_block_bmap_free_metadata_pages(struct ssdfs_block_bmap *blk_bmap,
+					 u32 count);
+int ssdfs_block_bmap_get_free_pages(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_get_used_pages(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_get_invalid_pages(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_pre_allocate(struct ssdfs_block_bmap *blk_bmap,
+				  u32 start, u32 *len,
+				  struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_allocate(struct ssdfs_block_bmap *blk_bmap,
+				u32 start, u32 *len,
+				struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_invalidate(struct ssdfs_block_bmap *blk_bmap,
+				struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_collect_garbage(struct ssdfs_block_bmap *blk_bmap,
+				     u32 start, u32 max_len,
+				     int blk_state,
+				     struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_clean(struct ssdfs_block_bmap *blk_bmap);
+
+#define SSDFS_BLK_BMAP_FNS(state, name)					\
+static inline								\
+bool is_block_##name(struct ssdfs_block_bmap *blk_bmap, u32 blk)	\
+{									\
+	return ssdfs_block_bmap_test_block(blk_bmap, blk,		\
+					    SSDFS_BLK_##state);		\
+}									\
+static inline								\
+bool is_range_##name(struct ssdfs_block_bmap *blk_bmap,			\
+			struct ssdfs_block_bmap_range *range)		\
+{									\
+	return ssdfs_block_bmap_test_range(blk_bmap, range,		\
+					    SSDFS_BLK_##state);		\
+}									\
+
+/*
+ * is_block_free()
+ * is_range_free()
+ */
+SSDFS_BLK_BMAP_FNS(FREE, free)
+
+/*
+ * is_block_pre_allocated()
+ * is_range_pre_allocated()
+ */
+SSDFS_BLK_BMAP_FNS(PRE_ALLOCATED, pre_allocated)
+
+/*
+ * is_block_valid()
+ * is_range_valid()
+ */
+SSDFS_BLK_BMAP_FNS(VALID, valid)
+
+/*
+ * is_block_invalid()
+ * is_range_invalid()
+ */
+SSDFS_BLK_BMAP_FNS(INVALID, invalid)
+
+#endif /* _SSDFS_BLOCK_BITMAP_H */
diff --git a/fs/ssdfs/block_bitmap_tables.c b/fs/ssdfs/block_bitmap_tables.c
new file mode 100644
index 000000000000..4f7e04a8a9b6
--- /dev/null
+++ b/fs/ssdfs/block_bitmap_tables.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/block_bitmap_tables.c - declaration of block bitmap's search tables.
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
+
+/*
+ * Table for determination presence of free block
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_free_blk[U8_MAX + 1] = {
+/* 00 - 0x00 */	true, true, true, true,
+/* 01 - 0x04 */	true, true, true, true,
+/* 02 - 0x08 */	true, true, true, true,
+/* 03 - 0x0C */	true, true, true, true,
+/* 04 - 0x10 */	true, true, true, true,
+/* 05 - 0x14 */	true, true, true, true,
+/* 06 - 0x18 */	true, true, true, true,
+/* 07 - 0x1C */	true, true, true, true,
+/* 08 - 0x20 */	true, true, true, true,
+/* 09 - 0x24 */	true, true, true, true,
+/* 10 - 0x28 */	true, true, true, true,
+/* 11 - 0x2C */	true, true, true, true,
+/* 12 - 0x30 */	true, true, true, true,
+/* 13 - 0x34 */	true, true, true, true,
+/* 14 - 0x38 */	true, true, true, true,
+/* 15 - 0x3C */	true, true, true, true,
+/* 16 - 0x40 */	true, true, true, true,
+/* 17 - 0x44 */	true, true, true, true,
+/* 18 - 0x48 */	true, true, true, true,
+/* 19 - 0x4C */	true, true, true, true,
+/* 20 - 0x50 */	true, true, true, true,
+/* 21 - 0x54 */	true, false, false, false,
+/* 22 - 0x58 */	true, false, false, false,
+/* 23 - 0x5C */	true, false, false, false,
+/* 24 - 0x60 */	true, true, true, true,
+/* 25 - 0x64 */	true, false, false, false,
+/* 26 - 0x68 */	true, false, false, false,
+/* 27 - 0x6C */	true, false, false, false,
+/* 28 - 0x70 */	true, true, true, true,
+/* 29 - 0x74 */	true, false, false, false,
+/* 30 - 0x78 */	true, false, false, false,
+/* 31 - 0x7C */	true, false, false, false,
+/* 32 - 0x80 */	true, true, true, true,
+/* 33 - 0x84 */	true, true, true, true,
+/* 34 - 0x88 */	true, true, true, true,
+/* 35 - 0x8C */	true, true, true, true,
+/* 36 - 0x90 */	true, true, true, true,
+/* 37 - 0x94 */	true, false, false, false,
+/* 38 - 0x98 */	true, false, false, false,
+/* 39 - 0x9C */	true, false, false, false,
+/* 40 - 0xA0 */	true, true, true, true,
+/* 41 - 0xA4 */	true, false, false, false,
+/* 42 - 0xA8 */	true, false, false, false,
+/* 43 - 0xAC */	true, false, false, false,
+/* 44 - 0xB0 */	true, true, true, true,
+/* 45 - 0xB4 */	true, false, false, false,
+/* 46 - 0xB8 */	true, false, false, false,
+/* 47 - 0xBC */	true, false, false, false,
+/* 48 - 0xC0 */	true, true, true, true,
+/* 49 - 0xC4 */	true, true, true, true,
+/* 50 - 0xC8 */	true, true, true, true,
+/* 51 - 0xCC */	true, true, true, true,
+/* 52 - 0xD0 */	true, true, true, true,
+/* 53 - 0xD4 */	true, false, false, false,
+/* 54 - 0xD8 */	true, false, false, false,
+/* 55 - 0xDC */	true, false, false, false,
+/* 56 - 0xE0 */	true, true, true, true,
+/* 57 - 0xE4 */	true, false, false, false,
+/* 58 - 0xE8 */	true, false, false, false,
+/* 59 - 0xEC */	true, false, false, false,
+/* 60 - 0xF0 */	true, true, true, true,
+/* 61 - 0xF4 */	true, false, false, false,
+/* 62 - 0xF8 */	true, false, false, false,
+/* 63 - 0xFC */	true, false, false, false
+};
+
+/*
+ * Table for determination presence of pre-allocated
+ * block state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_pre_allocated_blk[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, true, false, false,
+/* 01 - 0x04 */	true, true, true, true,
+/* 02 - 0x08 */	false, true, false, false,
+/* 03 - 0x0C */	false, true, false, false,
+/* 04 - 0x10 */	true, true, true, true,
+/* 05 - 0x14 */	true, true, true, true,
+/* 06 - 0x18 */	true, true, true, true,
+/* 07 - 0x1C */	true, true, true, true,
+/* 08 - 0x20 */	false, true, false, false,
+/* 09 - 0x24 */	true, true, true, true,
+/* 10 - 0x28 */	false, true, false, false,
+/* 11 - 0x2C */	false, true, false, false,
+/* 12 - 0x30 */	false, true, false, false,
+/* 13 - 0x34 */	true, true, true, true,
+/* 14 - 0x38 */	false, true, false, false,
+/* 15 - 0x3C */	false, true, false, false,
+/* 16 - 0x40 */	true, true, true, true,
+/* 17 - 0x44 */	true, true, true, true,
+/* 18 - 0x48 */	true, true, true, true,
+/* 19 - 0x4C */	true, true, true, true,
+/* 20 - 0x50 */	true, true, true, true,
+/* 21 - 0x54 */	true, true, true, true,
+/* 22 - 0x58 */	true, true, true, true,
+/* 23 - 0x5C */	true, true, true, true,
+/* 24 - 0x60 */	true, true, true, true,
+/* 25 - 0x64 */	true, true, true, true,
+/* 26 - 0x68 */	true, true, true, true,
+/* 27 - 0x6C */	true, true, true, true,
+/* 28 - 0x70 */	true, true, true, true,
+/* 29 - 0x74 */	true, true, true, true,
+/* 30 - 0x78 */	true, true, true, true,
+/* 31 - 0x7C */	true, true, true, true,
+/* 32 - 0x80 */	false, true, false, false,
+/* 33 - 0x84 */	true, true, true, true,
+/* 34 - 0x88 */	false, true, false, false,
+/* 35 - 0x8C */	false, true, false, false,
+/* 36 - 0x90 */	true, true, true, true,
+/* 37 - 0x94 */	true, true, true, true,
+/* 38 - 0x98 */	true, true, true, true,
+/* 39 - 0x9C */	true, true, true, true,
+/* 40 - 0xA0 */	false, true, false, false,
+/* 41 - 0xA4 */	true, true, true, true,
+/* 42 - 0xA8 */	false, true, false, false,
+/* 43 - 0xAC */	false, true, false, false,
+/* 44 - 0xB0 */	false, true, false, false,
+/* 45 - 0xB4 */	true, true, true, true,
+/* 46 - 0xB8 */	false, true, false, false,
+/* 47 - 0xBC */	false, true, false, false,
+/* 48 - 0xC0 */	false, true, false, false,
+/* 49 - 0xC4 */	true, true, true, true,
+/* 50 - 0xC8 */	false, true, false, false,
+/* 51 - 0xCC */	false, true, false, false,
+/* 52 - 0xD0 */	true, true, true, true,
+/* 53 - 0xD4 */	true, true, true, true,
+/* 54 - 0xD8 */	true, true, true, true,
+/* 55 - 0xDC */	true, true, true, true,
+/* 56 - 0xE0 */	false, true, false, false,
+/* 57 - 0xE4 */	true, true, true, true,
+/* 58 - 0xE8 */	false, true, false, false,
+/* 59 - 0xEC */	false, true, false, false,
+/* 60 - 0xF0 */	false, true, false, false,
+/* 61 - 0xF4 */	true, true, true, true,
+/* 62 - 0xF8 */	false, true, false, false,
+/* 63 - 0xFC */	false, true, false, false
+};
+
+/*
+ * Table for determination presence of valid block
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_valid_blk[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, false, true,
+/* 01 - 0x04 */	false, false, false, true,
+/* 02 - 0x08 */	false, false, false, true,
+/* 03 - 0x0C */	true, true, true, true,
+/* 04 - 0x10 */	false, false, false, true,
+/* 05 - 0x14 */	false, false, false, true,
+/* 06 - 0x18 */	false, false, false, true,
+/* 07 - 0x1C */	true, true, true, true,
+/* 08 - 0x20 */	false, false, false, true,
+/* 09 - 0x24 */	false, false, false, true,
+/* 10 - 0x28 */	false, false, false, true,
+/* 11 - 0x2C */	true, true, true, true,
+/* 12 - 0x30 */	true, true, true, true,
+/* 13 - 0x34 */	true, true, true, true,
+/* 14 - 0x38 */	true, true, true, true,
+/* 15 - 0x3C */	true, true, true, true,
+/* 16 - 0x40 */	false, false, false, true,
+/* 17 - 0x44 */	false, false, false, true,
+/* 18 - 0x48 */	false, false, false, true,
+/* 19 - 0x4C */	true, true, true, true,
+/* 20 - 0x50 */	false, false, false, true,
+/* 21 - 0x54 */	false, false, false, true,
+/* 22 - 0x58 */	false, false, false, true,
+/* 23 - 0x5C */	true, true, true, true,
+/* 24 - 0x60 */	false, false, false, true,
+/* 25 - 0x64 */	false, false, false, true,
+/* 26 - 0x68 */	false, false, false, true,
+/* 27 - 0x6C */	true, true, true, true,
+/* 28 - 0x70 */	true, true, true, true,
+/* 29 - 0x74 */	true, true, true, true,
+/* 30 - 0x78 */	true, true, true, true,
+/* 31 - 0x7C */	true, true, true, true,
+/* 32 - 0x80 */	false, false, false, true,
+/* 33 - 0x84 */	false, false, false, true,
+/* 34 - 0x88 */	false, false, false, true,
+/* 35 - 0x8C */	true, true, true, true,
+/* 36 - 0x90 */	false, false, false, true,
+/* 37 - 0x94 */	false, false, false, true,
+/* 38 - 0x98 */	false, false, false, true,
+/* 39 - 0x9C */	true, true, true, true,
+/* 40 - 0xA0 */	false, false, false, true,
+/* 41 - 0xA4 */	false, false, false, true,
+/* 42 - 0xA8 */	false, false, false, true,
+/* 43 - 0xAC */	true, true, true, true,
+/* 44 - 0xB0 */	true, true, true, true,
+/* 45 - 0xB4 */	true, true, true, true,
+/* 46 - 0xB8 */	true, true, true, true,
+/* 47 - 0xBC */	true, true, true, true,
+/* 48 - 0xC0 */	true, true, true, true,
+/* 49 - 0xC4 */	true, true, true, true,
+/* 50 - 0xC8 */	true, true, true, true,
+/* 51 - 0xCC */	true, true, true, true,
+/* 52 - 0xD0 */	true, true, true, true,
+/* 53 - 0xD4 */	true, true, true, true,
+/* 54 - 0xD8 */	true, true, true, true,
+/* 55 - 0xDC */	true, true, true, true,
+/* 56 - 0xE0 */	true, true, true, true,
+/* 57 - 0xE4 */	true, true, true, true,
+/* 58 - 0xE8 */	true, true, true, true,
+/* 59 - 0xEC */	true, true, true, true,
+/* 60 - 0xF0 */	true, true, true, true,
+/* 61 - 0xF4 */	true, true, true, true,
+/* 62 - 0xF8 */	true, true, true, true,
+/* 63 - 0xFC */	true, true, true, true
+};
+
+/*
+ * Table for determination presence of invalid block
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_invalid_blk[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, true, false,
+/* 01 - 0x04 */	false, false, true, false,
+/* 02 - 0x08 */	true, true, true, true,
+/* 03 - 0x0C */	false, false, true, false,
+/* 04 - 0x10 */	false, false, true, false,
+/* 05 - 0x14 */	false, false, true, false,
+/* 06 - 0x18 */	true, true, true, true,
+/* 07 - 0x1C */	false, false, true, false,
+/* 08 - 0x20 */	true, true, true, true,
+/* 09 - 0x24 */	true, true, true, true,
+/* 10 - 0x28 */	true, true, true, true,
+/* 11 - 0x2C */	true, true, true, true,
+/* 12 - 0x30 */	false, false, true, false,
+/* 13 - 0x34 */	false, false, true, false,
+/* 14 - 0x38 */	true, true, true, true,
+/* 15 - 0x3C */	false, false, true, false,
+/* 16 - 0x40 */	false, false, true, false,
+/* 17 - 0x44 */	false, false, true, false,
+/* 18 - 0x48 */	true, true, true, true,
+/* 19 - 0x4C */	false, false, true, false,
+/* 20 - 0x50 */	false, false, true, false,
+/* 21 - 0x54 */	false, false, true, false,
+/* 22 - 0x58 */	true, true, true, true,
+/* 23 - 0x5C */	false, false, true, false,
+/* 24 - 0x60 */	true, true, true, true,
+/* 25 - 0x64 */	true, true, true, true,
+/* 26 - 0x68 */	true, true, true, true,
+/* 27 - 0x6C */	true, true, true, true,
+/* 28 - 0x70 */	false, false, true, false,
+/* 29 - 0x74 */	false, false, true, false,
+/* 30 - 0x78 */	true, true, true, true,
+/* 31 - 0x7C */	false, false, true, false,
+/* 32 - 0x80 */	true, true, true, true,
+/* 33 - 0x84 */	true, true, true, true,
+/* 34 - 0x88 */	true, true, true, true,
+/* 35 - 0x8C */	true, true, true, true,
+/* 36 - 0x90 */	true, true, true, true,
+/* 37 - 0x94 */	true, true, true, true,
+/* 38 - 0x98 */	true, true, true, true,
+/* 39 - 0x9C */	true, true, true, true,
+/* 40 - 0xA0 */	true, true, true, true,
+/* 41 - 0xA4 */	true, true, true, true,
+/* 42 - 0xA8 */	true, true, true, true,
+/* 43 - 0xAC */	true, true, true, true,
+/* 44 - 0xB0 */	true, true, true, true,
+/* 45 - 0xB4 */	true, true, true, true,
+/* 46 - 0xB8 */	true, true, true, true,
+/* 47 - 0xBC */	true, true, true, true,
+/* 48 - 0xC0 */	false, false, true, false,
+/* 49 - 0xC4 */	false, false, true, false,
+/* 50 - 0xC8 */	true, true, true, true,
+/* 51 - 0xCC */	false, false, true, false,
+/* 52 - 0xD0 */	false, false, true, false,
+/* 53 - 0xD4 */	false, false, true, false,
+/* 54 - 0xD8 */	true, true, true, true,
+/* 55 - 0xDC */	false, false, true, false,
+/* 56 - 0xE0 */	true, true, true, true,
+/* 57 - 0xE4 */	true, true, true, true,
+/* 58 - 0xE8 */	true, true, true, true,
+/* 59 - 0xEC */	true, true, true, true,
+/* 60 - 0xF0 */	false, false, true, false,
+/* 61 - 0xF4 */	false, false, true, false,
+/* 62 - 0xF8 */	true, true, true, true,
+/* 63 - 0xFC */	false, false, true, false
+};
-- 
2.34.1


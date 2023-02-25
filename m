Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC0C6A2631
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBYBQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBYBQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:28 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186FE126FB
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:12 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id e21so828566oie.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V7o+mnWJmceniHH5yuCWtrowlXjF5Z0w+XxdNBjCjo=;
        b=ZhxW5qSNl8eHoQQMScxomqpw/7HBvZAN9/lHiT03uCtL70l8ommFsui9UTjM6p0NIA
         WIuSwbzaNA6H2wafC1KY1cH2w2A3hXWFI0Nd+woF3ZS+YdYipQl1NtB1Y18dJti5rZzO
         ucaUj7F1EkFhdvUJEvYahAkShHqTEWSTPoypDHCt1NZxweT56QLvg67OlVdG8TuM42S2
         i74fvJ63hJk5CZrxhVKDlQYjg1NK8WiJzGtpRyJBc0bRRy96NwWhPHvzQOJjcORH1ZiT
         bov8UzH6ZSpkp322vpulPOaeyHpoMq1+pMBnUPc7SGrm8T2keYrT7KsQYUQlu2ft2VQ+
         5oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V7o+mnWJmceniHH5yuCWtrowlXjF5Z0w+XxdNBjCjo=;
        b=b+a/Nq9DM3EfSKP2daX1bJ4SaYe9gD1h2vxXgSoGLyDr8JxEyp6/nSowYgIEQ5Mp7l
         KuNk1Krbkkh6Xd3/yYBJp0XH3/0o8cu1Rt4+tY/n6tvujd0JGIhI74nzh7YqpM+59asO
         bIldtRxJhf89WwIh0+edGKcYbgxsRnOk87PJa02/91C9n76Vk0mmdhFAN+5CiMpVUZmD
         7oNeSiIVv0cdpYPfdbVAyzZqGhpVVz2EFpXnSVaHR0ZL+eRhvrlAhNH//vkHOOUAcD6S
         Q8iZnEYJG422cCrYGe5ZMQxrQJrkQUT3B2nVf3dPt00iFDi9esx/WEuz0jndDATtW7uu
         g8PA==
X-Gm-Message-State: AO0yUKXgVyBEdXmNwa6BoXAgIgXDWXRMHsmw1zeBzRgN9dQUN/q8Z6F2
        fSTQjOPYij7m9PE8ksFV1bgwK863NE20AJOk
X-Google-Smtp-Source: AK7set/P4Y8bOwKTr1ylLu8RFlvKnH8h7adLRo66uLg6l15bex4rWEaaZSYQleKcsOL7BTt26qUdrg==
X-Received: by 2002:aca:1215:0:b0:384:9f4:dd3c with SMTP id 21-20020aca1215000000b0038409f4dd3cmr1205399ois.38.1677287770667;
        Fri, 24 Feb 2023 17:16:10 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:09 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 17/76] ssdfs: introduce offset translation table
Date:   Fri, 24 Feb 2023 17:08:28 -0800
Message-Id: <20230225010927.813929-18-slava@dubeyko.com>
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

One of the key goal of SSDFS is to decrease the write
amplification factor. Logical extent concept is the
fundamental technique to achieve the goal. Logical extent
describes any volume extent on the basis of segment ID,
logical block ID, and length. Migration scheme guarantee
that segment ID will be always the same for any logical
extent. Offset translation table provides the way to convert
logical block ID into offset inside of a log of particular
"Physical" Erase Block (PEB). As a result, extents b-tree
never needs to be updated because logical extent will never
change until intentional movement from one segment into
another one.

Offset translation table is a metadata structure that
is stored as metadata in every log. The responsibility of
offset translation table keeps the knowledge which particular
logical blocks are stored into log's payload and which offset
in the payload should be used to access and retrieve the
content of logical block.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/offset_translation_table.c | 2914 +++++++++++++++++++++++++++
 fs/ssdfs/offset_translation_table.h |  446 ++++
 2 files changed, 3360 insertions(+)
 create mode 100644 fs/ssdfs/offset_translation_table.c
 create mode 100644 fs/ssdfs/offset_translation_table.h

diff --git a/fs/ssdfs/offset_translation_table.c b/fs/ssdfs/offset_translation_table.c
new file mode 100644
index 000000000000..169f8106c5be
--- /dev/null
+++ b/fs/ssdfs/offset_translation_table.c
@@ -0,0 +1,2914 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/offset_translation_table.c - offset translation table functionality.
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
+#include <linux/bitmap.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb.h"
+#include "peb_container.h"
+#include "segment_bitmap.h"
+#include "segment.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_blk2off_page_leaks;
+atomic64_t ssdfs_blk2off_memory_leaks;
+atomic64_t ssdfs_blk2off_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_blk2off_cache_leaks_increment(void *kaddr)
+ * void ssdfs_blk2off_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_blk2off_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_blk2off_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_blk2off_kvzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_blk2off_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_blk2off_kfree(void *kaddr)
+ * void ssdfs_blk2off_kvfree(void *kaddr)
+ * struct page *ssdfs_blk2off_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_blk2off_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_blk2off_free_page(struct page *page)
+ * void ssdfs_blk2off_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(blk2off)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(blk2off)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_blk2off_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_blk2off_page_leaks, 0);
+	atomic64_set(&ssdfs_blk2off_memory_leaks, 0);
+	atomic64_set(&ssdfs_blk2off_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_blk2off_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_blk2off_page_leaks) != 0) {
+		SSDFS_ERR("BLK2OFF TABLE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_blk2off_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_blk2off_memory_leaks) != 0) {
+		SSDFS_ERR("BLK2OFF TABLE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_blk2off_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_blk2off_cache_leaks) != 0) {
+		SSDFS_ERR("BLK2OFF TABLE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_blk2off_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/******************************************************************************
+ *                           BLK2OFF TABLE CACHE                              *
+ ******************************************************************************/
+
+static struct kmem_cache *ssdfs_blk2off_frag_obj_cachep;
+
+void ssdfs_zero_blk2off_frag_obj_cache_ptr(void)
+{
+	ssdfs_blk2off_frag_obj_cachep = NULL;
+}
+
+static void ssdfs_init_blk2off_frag_object_once(void *obj)
+{
+	struct ssdfs_phys_offset_table_fragment *frag_obj = obj;
+
+	memset(frag_obj, 0, sizeof(struct ssdfs_phys_offset_table_fragment));
+}
+
+void ssdfs_shrink_blk2off_frag_obj_cache(void)
+{
+	if (ssdfs_blk2off_frag_obj_cachep)
+		kmem_cache_shrink(ssdfs_blk2off_frag_obj_cachep);
+}
+
+void ssdfs_destroy_blk2off_frag_obj_cache(void)
+{
+	if (ssdfs_blk2off_frag_obj_cachep)
+		kmem_cache_destroy(ssdfs_blk2off_frag_obj_cachep);
+}
+
+int ssdfs_init_blk2off_frag_obj_cache(void)
+{
+	size_t obj_size = sizeof(struct ssdfs_phys_offset_table_fragment);
+
+	ssdfs_blk2off_frag_obj_cachep =
+			kmem_cache_create("ssdfs_blk2off_frag_obj_cache",
+					obj_size, 0,
+					SLAB_RECLAIM_ACCOUNT |
+					SLAB_MEM_SPREAD |
+					SLAB_ACCOUNT,
+					ssdfs_init_blk2off_frag_object_once);
+	if (!ssdfs_blk2off_frag_obj_cachep) {
+		SSDFS_ERR("unable to create blk2off fragments cache\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_frag_alloc() - allocate memory for blk2off fragment
+ */
+static
+struct ssdfs_phys_offset_table_fragment *ssdfs_blk2off_frag_alloc(void)
+{
+	struct ssdfs_phys_offset_table_fragment *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_blk2off_frag_obj_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = kmem_cache_alloc(ssdfs_blk2off_frag_obj_cachep, GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate memory for blk2off fragment\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ssdfs_blk2off_cache_leaks_increment(ptr);
+
+	return ptr;
+}
+
+/*
+ * ssdfs_blk2off_frag_free() - free memory for blk2off fragment
+ */
+static
+void ssdfs_blk2off_frag_free(void *ptr)
+{
+	struct ssdfs_phys_offset_table_fragment *frag;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_blk2off_frag_obj_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ptr)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ptr %p\n", ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	frag = (struct ssdfs_phys_offset_table_fragment *)ptr;
+
+	WARN_ON(atomic_read(&frag->state) == SSDFS_BLK2OFF_FRAG_DIRTY);
+
+	if (frag->buf) {
+		ssdfs_blk2off_kfree(frag->buf);
+		frag->buf = NULL;
+	}
+
+	ssdfs_blk2off_cache_leaks_decrement(frag);
+	kmem_cache_free(ssdfs_blk2off_frag_obj_cachep, frag);
+}
+
+/******************************************************************************
+ *                      BLK2OFF TABLE OBJECT FUNCTIONALITY                    *
+ ******************************************************************************/
+
+/*
+ * struct ssdfs_blk2off_init - initialization environment
+ * @table: pointer on translation table object
+ * @blk2off_pvec: blk2off table fragment
+ * @blk_desc_pvec: blk desc table fragment
+ * @peb_index: PEB's index
+ * @cno: checkpoint
+ * @fragments_count: count of fragments in portion
+ * @capacity: maximum amount of items
+ * @tbl_hdr: portion header
+ * @tbl_hdr_off: portion header's offset
+ * @pot_hdr: fragment header
+ * @pot_hdr_off: fragment header's offset
+ * @bmap: temporary bitmap
+ * @bmap_bytes: bytes in temporaray bitmap
+ * @extent_array: translation extents temporary array
+ * @extents_count: count of extents in array
+ */
+struct ssdfs_blk2off_init {
+	struct ssdfs_blk2off_table *table;
+	struct pagevec *blk2off_pvec;
+	struct pagevec *blk_desc_pvec;
+	u16 peb_index;
+	u64 cno;
+	u32 fragments_count;
+	u16 capacity;
+
+	struct ssdfs_blk2off_table_header tbl_hdr;
+	u32 tbl_hdr_off;
+	struct ssdfs_phys_offset_table_header pot_hdr;
+	u32 pot_hdr_off;
+
+	unsigned long *bmap;
+	u32 bmap_bytes;
+
+	struct ssdfs_translation_extent *extent_array;
+	u16 extents_count;
+};
+
+static
+void ssdfs_debug_blk2off_table_object(struct ssdfs_blk2off_table *tbl);
+
+/*
+ * ssdfs_blk2off_table_init_fragment() - init PEB's fragment
+ * @ptr: fragment pointer
+ * @sequence_id: fragment's sequence ID
+ * @start_id: fragment's start ID
+ * @pages_per_peb: PEB's pages count
+ * @state: fragment state after initialization
+ * @buf_size: pointer on buffer size
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static int
+ssdfs_blk2off_table_init_fragment(struct ssdfs_phys_offset_table_fragment *ptr,
+				  u16 sequence_id, u16 start_id,
+				  u32 pages_per_peb, int state,
+				  size_t *buf_size)
+{
+	size_t blk2off_tbl_hdr_size = sizeof(struct ssdfs_blk2off_table_header);
+	size_t hdr_size = sizeof(struct ssdfs_phys_offset_table_header);
+	size_t off_size = sizeof(struct ssdfs_phys_offset_descriptor);
+	size_t fragment_size = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ptr %p, sequence_id %u, start_id %u, "
+		  "pages_per_peb %u, state %#x, buf_size %p\n",
+		  ptr, sequence_id, start_id, pages_per_peb,
+		  state, buf_size);
+
+	BUG_ON(!ptr);
+	BUG_ON(sequence_id > SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD);
+	BUG_ON(state < SSDFS_BLK2OFF_FRAG_CREATED ||
+		state >= SSDFS_BLK2OFF_FRAG_STATE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	init_rwsem(&ptr->lock);
+
+	down_write(&ptr->lock);
+
+	if (buf_size) {
+		fragment_size = min_t(size_t, *buf_size, PAGE_SIZE);
+	} else {
+		fragment_size += blk2off_tbl_hdr_size;
+		fragment_size += hdr_size + (off_size * pages_per_peb);
+		fragment_size = min_t(size_t, fragment_size, PAGE_SIZE);
+	}
+
+	ptr->buf_size = fragment_size;
+	ptr->buf = ssdfs_blk2off_kzalloc(ptr->buf_size, GFP_KERNEL);
+	if (!ptr->buf) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate table buffer\n");
+		goto finish_fragment_init;
+	}
+
+	ptr->start_id = start_id;
+	ptr->sequence_id = sequence_id;
+	atomic_set(&ptr->id_count, 0);
+
+	ptr->hdr = SSDFS_POFFTH(ptr->buf);
+	ptr->phys_offs = SSDFS_PHYSOFFD(ptr->buf + hdr_size);
+
+	atomic_set(&ptr->state, state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("FRAGMENT: sequence_id %u, start_id %u, id_count %d\n",
+		  sequence_id, start_id, atomic_read(&ptr->id_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_fragment_init:
+	up_write(&ptr->lock);
+	return err;
+}
+
+/*
+ * ssdfs_get_migrating_block() - get pointer on migrating block
+ * @table: pointer on translation table object
+ * @logical_blk: logical block ID
+ * @need_allocate: should descriptor being allocated?
+ *
+ * This method tries to return pointer on migrating block's
+ * descriptor. In the case of necessity the descriptor
+ * will be allocated (if @need_allocate is true).
+ *
+ * RETURN:
+ * [success] - pointer on migrating block's descriptor.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid value.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+struct ssdfs_migrating_block *
+ssdfs_get_migrating_block(struct ssdfs_blk2off_table *table,
+			  u16 logical_blk,
+			  bool need_allocate)
+{
+	struct ssdfs_migrating_block *migrating_blk = NULL;
+	void *kaddr;
+	size_t blk_desc_size = sizeof(struct ssdfs_migrating_block);
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+	BUG_ON(logical_blk >= table->lblk2off_capacity);
+
+	SSDFS_DBG("logical_blk %u, need_allocate %#x\n",
+		  logical_blk, need_allocate);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (need_allocate) {
+		migrating_blk = ssdfs_blk2off_kzalloc(blk_desc_size,
+							GFP_KERNEL);
+		if (!migrating_blk) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate migrating block desc\n");
+			goto fail_get_migrating_blk;
+		}
+
+		err = ssdfs_dynamic_array_set(&table->migrating_blks,
+						logical_blk, &migrating_blk);
+		if (unlikely(err)) {
+			ssdfs_blk2off_kfree(migrating_blk);
+			SSDFS_ERR("fail to store migrating block in array: "
+				  "logical_blk %u, err %d\n",
+				  logical_blk, err);
+			goto fail_get_migrating_blk;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_blk %u descriptor has been allocated\n",
+			  logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+		kaddr = ssdfs_dynamic_array_get_locked(&table->migrating_blks,
+							logical_blk);
+		if (IS_ERR_OR_NULL(kaddr)) {
+			err = (kaddr == NULL ? -ENOENT : PTR_ERR(kaddr));
+			SSDFS_ERR("fail to get migrating block: "
+				  "logical_blk %u, err %d\n",
+				  logical_blk, err);
+			goto fail_get_migrating_blk;
+		}
+
+		migrating_blk = SSDFS_MIGRATING_BLK(*(u8 **)kaddr);
+
+		err = ssdfs_dynamic_array_release(&table->migrating_blks,
+						  logical_blk, kaddr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to release: "
+				  "logical_blk %u, err %d\n",
+				  logical_blk, err);
+			goto fail_get_migrating_blk;
+		}
+	}
+
+	if (migrating_blk) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_blk %u, state %#x\n",
+			  logical_blk, migrating_blk->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return migrating_blk;
+
+fail_get_migrating_blk:
+	return ERR_PTR(err);
+}
+
+/*
+ * ssdfs_destroy_migrating_blocks_array() - destroy descriptors array
+ * @table: pointer on translation table object
+ *
+ * This method tries to free memory of migrating block
+ * descriptors array.
+ */
+static
+void ssdfs_destroy_migrating_blocks_array(struct ssdfs_blk2off_table *table)
+{
+	struct ssdfs_migrating_block *migrating_blk = NULL;
+	void *kaddr;
+	u32 items_count;
+	u32 i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	items_count = table->last_allocated_blk + 1;
+
+	for (i = 0; i < items_count; i++) {
+		kaddr = ssdfs_dynamic_array_get_locked(&table->migrating_blks,
+							i);
+		if (IS_ERR_OR_NULL(kaddr))
+			continue;
+
+		migrating_blk = SSDFS_MIGRATING_BLK(*(u8 **)kaddr);
+
+		if (migrating_blk)
+			ssdfs_blk2off_kfree(migrating_blk);
+
+		ssdfs_dynamic_array_release(&table->migrating_blks,
+					    i, kaddr);
+	}
+
+	ssdfs_dynamic_array_destroy(&table->migrating_blks);
+}
+
+/*
+ * ssdfs_blk2off_table_create() - create translation table object
+ * @fsi: pointer on shared file system object
+ * @items_count: table's capacity
+ * @type: table's type
+ * @state: initial state of object
+ *
+ * This method tries to create translation table object.
+ *
+ * RETURN:
+ * [success] - pointer on created object.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid value.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+struct ssdfs_blk2off_table *
+ssdfs_blk2off_table_create(struct ssdfs_fs_info *fsi,
+			   u16 items_count, u8 type,
+			   int state)
+{
+	struct ssdfs_blk2off_table *ptr;
+	size_t table_size = sizeof(struct ssdfs_blk2off_table);
+	size_t off_pos_size = sizeof(struct ssdfs_offset_position);
+	size_t ptr_size = sizeof(struct ssdfs_migrating_block *);
+	u32 bytes;
+	u32 bits_count;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+	BUG_ON(state <= SSDFS_BLK2OFF_OBJECT_UNKNOWN ||
+		state >= SSDFS_BLK2OFF_OBJECT_STATE_MAX);
+	BUG_ON(items_count > (2 * fsi->pages_per_seg));
+	BUG_ON(type <= SSDFS_UNKNOWN_OFF_TABLE_TYPE ||
+		type >= SSDFS_OFF_TABLE_MAX_TYPE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, items_count %u, type %u, state %#x\n",
+		  fsi, items_count, type,  state);
+#else
+	SSDFS_DBG("fsi %p, items_count %u, type %u, state %#x\n",
+		  fsi, items_count, type,  state);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ptr = (struct ssdfs_blk2off_table *)ssdfs_blk2off_kzalloc(table_size,
+								  GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate translation table\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ptr->fsi = fsi;
+
+	atomic_set(&ptr->flags, 0);
+	atomic_set(&ptr->state, SSDFS_BLK2OFF_OBJECT_UNKNOWN);
+
+	ptr->pages_per_peb = fsi->pages_per_peb;
+	ptr->pages_per_seg = fsi->pages_per_seg;
+	ptr->type = type;
+
+	init_rwsem(&ptr->translation_lock);
+	init_waitqueue_head(&ptr->wait_queue);
+
+	ptr->init_cno = U64_MAX;
+	ptr->used_logical_blks = 0;
+	ptr->free_logical_blks = items_count;
+	ptr->last_allocated_blk = U16_MAX;
+
+	bytes = ssdfs_blk2off_table_bmap_bytes(items_count);
+	bytes = min_t(u32, bytes, PAGE_SIZE);
+	bits_count = bytes * BITS_PER_BYTE;
+
+	ptr->lbmap.bits_count = bits_count;
+	ptr->lbmap.bytes_count = bytes;
+
+	for (i = 0; i < SSDFS_LBMAP_ARRAY_MAX; i++) {
+		ptr->lbmap.array[i] =
+			(unsigned long *)ssdfs_blk2off_kvzalloc(bytes,
+								GFP_KERNEL);
+		if (!ptr->lbmap.array[i]) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate bitmaps\n");
+			goto free_bmap;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("init_bmap %lx, state_bmap %lx, modification_bmap %lx\n",
+		  *ptr->lbmap.array[SSDFS_LBMAP_INIT_INDEX],
+		  *ptr->lbmap.array[SSDFS_LBMAP_STATE_INDEX],
+		  *ptr->lbmap.array[SSDFS_LBMAP_MODIFICATION_INDEX]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr->lblk2off_capacity = items_count;
+
+	err = ssdfs_dynamic_array_create(&ptr->lblk2off,
+					 ptr->lblk2off_capacity,
+					 off_pos_size,
+					 0xFF);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create translation array: "
+			  "off_pos_size %zu, items_count %u\n",
+			  off_pos_size,
+			  ptr->lblk2off_capacity);
+		goto free_bmap;
+	}
+
+	err = ssdfs_dynamic_array_create(&ptr->migrating_blks,
+					 ptr->lblk2off_capacity,
+					 ptr_size,
+					 0);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create migrating blocks array: "
+			  "ptr_size %zu, items_count %u\n",
+			  ptr_size,
+			  ptr->lblk2off_capacity);
+		goto free_bmap;
+	}
+
+	ptr->pebs_count = fsi->pebs_per_seg;
+
+	ptr->peb = ssdfs_blk2off_kcalloc(ptr->pebs_count,
+				 sizeof(struct ssdfs_phys_offset_table_array),
+				 GFP_KERNEL);
+	if (!ptr->peb) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate phys offsets array\n");
+		goto free_translation_array;
+	}
+
+	for (i = 0; i < ptr->pebs_count; i++) {
+		struct ssdfs_phys_offset_table_array *table = &ptr->peb[i];
+		struct ssdfs_sequence_array *seq_ptr = NULL;
+		u32 threshold = SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD;
+
+		seq_ptr = ssdfs_create_sequence_array(threshold);
+		if (IS_ERR_OR_NULL(seq_ptr)) {
+			err = (seq_ptr == NULL ? -ENOMEM : PTR_ERR(seq_ptr));
+			SSDFS_ERR("fail to allocate sequence: "
+				  "err %d\n", err);
+			goto free_phys_offs_array;
+		} else
+			table->sequence = seq_ptr;
+
+		if (state == SSDFS_BLK2OFF_OBJECT_COMPLETE_INIT) {
+			struct ssdfs_phys_offset_table_fragment *fragment;
+			u16 start_id = i * fsi->pages_per_peb;
+			u32 pages_per_peb = fsi->pages_per_peb;
+			int fragment_state = SSDFS_BLK2OFF_FRAG_INITIALIZED;
+
+			atomic_set(&table->fragment_count, 1);
+
+			fragment = ssdfs_blk2off_frag_alloc();
+			if (IS_ERR_OR_NULL(fragment)) {
+				err = (fragment == NULL ? -ENOMEM :
+							PTR_ERR(fragment));
+				SSDFS_ERR("fail to allocate fragment: "
+					  "err %d\n", err);
+				goto free_phys_offs_array;
+			}
+
+			err = ssdfs_sequence_array_init_item(table->sequence,
+							     0, fragment);
+			if (unlikely(err)) {
+				ssdfs_blk2off_frag_free(fragment);
+				SSDFS_ERR("fail to init fragment: "
+					  "err %d\n", err);
+				goto free_phys_offs_array;
+			}
+
+			err = ssdfs_blk2off_table_init_fragment(fragment, 0,
+								start_id,
+								pages_per_peb,
+								fragment_state,
+								NULL);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to init fragment: "
+					  "fragment_index %d, err %d\n",
+					  i, err);
+				goto free_phys_offs_array;
+			}
+
+			atomic_set(&table->state,
+				   SSDFS_BLK2OFF_TABLE_COMPLETE_INIT);
+		} else if (state == SSDFS_BLK2OFF_OBJECT_CREATED) {
+			atomic_set(&table->fragment_count, 0);
+			atomic_set(&table->state,
+				   SSDFS_BLK2OFF_TABLE_CREATED);
+		} else
+			BUG();
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("init_bmap %lx, state_bmap %lx, modification_bmap %lx\n",
+		  *ptr->lbmap.array[SSDFS_LBMAP_INIT_INDEX],
+		  *ptr->lbmap.array[SSDFS_LBMAP_STATE_INDEX],
+		  *ptr->lbmap.array[SSDFS_LBMAP_MODIFICATION_INDEX]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	init_completion(&ptr->partial_init_end);
+	init_completion(&ptr->full_init_end);
+
+	atomic_set(&ptr->state, state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return ptr;
+
+free_phys_offs_array:
+	for (i = 0; i < ptr->pebs_count; i++) {
+		struct ssdfs_sequence_array *sequence;
+
+		sequence = ptr->peb[i].sequence;
+		ssdfs_destroy_sequence_array(sequence, ssdfs_blk2off_frag_free);
+		ptr->peb[i].sequence = NULL;
+	}
+
+	ssdfs_blk2off_kfree(ptr->peb);
+
+free_translation_array:
+	ssdfs_dynamic_array_destroy(&ptr->lblk2off);
+
+free_bmap:
+	for (i = 0; i < SSDFS_LBMAP_ARRAY_MAX; i++) {
+		ssdfs_blk2off_kvfree(ptr->lbmap.array[i]);
+		ptr->lbmap.array[i] = NULL;
+	}
+
+	ptr->lbmap.bits_count = 0;
+	ptr->lbmap.bytes_count = 0;
+
+	ssdfs_blk2off_kfree(ptr);
+
+	return ERR_PTR(err);
+}
+
+/*
+ * ssdfs_blk2off_table_destroy() - destroy translation table object
+ * @table: pointer on translation table object
+ */
+void ssdfs_blk2off_table_destroy(struct ssdfs_blk2off_table *table)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int migrating_blks = -1;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int state;
+	int i;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("table %p\n", table);
+#else
+	SSDFS_DBG("table %p\n", table);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!table) {
+		WARN_ON(!table);
+		return;
+	}
+
+	if (table->peb) {
+		for (i = 0; i < table->pebs_count; i++) {
+			struct ssdfs_sequence_array *sequence;
+
+			sequence = table->peb[i].sequence;
+			ssdfs_destroy_sequence_array(sequence,
+						ssdfs_blk2off_frag_free);
+			table->peb[i].sequence = NULL;
+
+			state = atomic_read(&table->peb[i].state);
+
+			switch (state) {
+			case SSDFS_BLK2OFF_TABLE_DIRTY:
+			case SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT:
+				SSDFS_WARN("unexpected table state %#x\n",
+					   state);
+				break;
+
+			default:
+				/* do nothing */
+				break;
+			}
+		}
+
+		ssdfs_blk2off_kfree(table->peb);
+		table->peb = NULL;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (table->last_allocated_blk >= U16_MAX)
+		migrating_blks = 0;
+	else
+		migrating_blks = table->last_allocated_blk + 1;
+
+	for (i = 0; i < migrating_blks; i++) {
+		struct ssdfs_migrating_block *blk =
+				ssdfs_get_migrating_block(table, i, false);
+
+		if (IS_ERR_OR_NULL(blk))
+			continue;
+
+		switch (blk->state) {
+		case SSDFS_LBLOCK_UNDER_MIGRATION:
+		case SSDFS_LBLOCK_UNDER_COMMIT:
+			SSDFS_ERR("logical blk %d is under migration\n", i);
+			ssdfs_blk2off_pagevec_release(&blk->pvec);
+			break;
+		}
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_dynamic_array_destroy(&table->lblk2off);
+
+	ssdfs_destroy_migrating_blocks_array(table);
+
+	for (i = 0; i < SSDFS_LBMAP_ARRAY_MAX; i++) {
+		ssdfs_blk2off_kvfree(table->lbmap.array[i]);
+		table->lbmap.array[i] = NULL;
+	}
+
+	table->lbmap.bits_count = 0;
+	table->lbmap.bytes_count = 0;
+
+	ssdfs_blk2off_kfree(table);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * ssdfs_blk2off_table_resize_bitmap_array() - resize bitmap array
+ * @lbmap: bitmap pointer
+ * @logical_blk: new threshold
+ */
+static inline
+int ssdfs_blk2off_table_resize_bitmap_array(struct ssdfs_bitmap_array *lbmap,
+					    u16 logical_blk)
+{
+	unsigned long *bmap_ptr;
+	u32 new_bits_count;
+	u32 new_bytes_count;
+	u32 bits_per_page;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap);
+
+	SSDFS_DBG("lbmap %p, logical_blk %u\n",
+		  lbmap, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bits_per_page = PAGE_SIZE * BITS_PER_BYTE;
+
+	new_bits_count = logical_blk + bits_per_page - 1;
+	new_bits_count /= bits_per_page;
+	new_bits_count *= bits_per_page;
+
+	new_bytes_count = ssdfs_blk2off_table_bmap_bytes(new_bits_count);
+
+	for (i = 0; i < SSDFS_LBMAP_ARRAY_MAX; i++) {
+		bmap_ptr = kvrealloc(lbmap->array[i],
+				     lbmap->bytes_count,
+				     new_bytes_count,
+				     GFP_KERNEL | __GFP_ZERO);
+		if (!bmap_ptr) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate bitmaps\n");
+			goto finish_bitmap_array_resize;
+		} else
+			lbmap->array[i] = (unsigned long *)bmap_ptr;
+	}
+
+	lbmap->bits_count = new_bits_count;
+	lbmap->bytes_count = new_bytes_count;
+
+finish_bitmap_array_resize:
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_table_bmap_set() - set bit for logical block
+ * @lbmap: bitmap pointer
+ * @bitmap_index: index of bitmap
+ * @logical_blk: logical block number
+ */
+static inline
+int ssdfs_blk2off_table_bmap_set(struct ssdfs_bitmap_array *lbmap,
+				 int bitmap_index, u16 logical_blk)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap);
+
+	SSDFS_DBG("lbmap %p, bitmap_index %d, logical_blk %u\n",
+		  lbmap, bitmap_index, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (bitmap_index >= SSDFS_LBMAP_ARRAY_MAX) {
+		SSDFS_ERR("invalid bitmap index %d\n",
+			  bitmap_index);
+		return -EINVAL;
+	}
+
+	if (logical_blk >= lbmap->bits_count) {
+		err = ssdfs_blk2off_table_resize_bitmap_array(lbmap,
+							      logical_blk);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to realloc bitmap array: "
+				  "logical_blk %u, err %d\n",
+				  logical_blk, err);
+			return err;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap->array[bitmap_index]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bitmap_set(lbmap->array[bitmap_index], logical_blk, 1);
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_table_bmap_clear() - clear bit for logical block
+ * @lbmap: bitmap pointer
+ * @bitmap_index: index of bitmap
+ * @logical_blk: logical block number
+ */
+static inline
+int ssdfs_blk2off_table_bmap_clear(struct ssdfs_bitmap_array *lbmap,
+				   int bitmap_index, u16 logical_blk)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap);
+
+	SSDFS_DBG("lbmap %p, bitmap_index %d, logical_blk %u\n",
+		  lbmap, bitmap_index, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (bitmap_index >= SSDFS_LBMAP_ARRAY_MAX) {
+		SSDFS_ERR("invalid bitmap index %d\n",
+			  bitmap_index);
+		return -EINVAL;
+	}
+
+	if (logical_blk >= lbmap->bits_count) {
+		err = ssdfs_blk2off_table_resize_bitmap_array(lbmap,
+							      logical_blk);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to realloc bitmap array: "
+				  "logical_blk %u, err %d\n",
+				  logical_blk, err);
+			return err;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap->array[bitmap_index]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bitmap_clear(lbmap->array[bitmap_index], logical_blk, 1);
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_table_bmap_vacant() - check bit for logical block
+ * @lbmap: bitmap pointer
+ * @bitmap_index: index of bitmap
+ * @lbmap_bits: count of bits in bitmap
+ * @logical_blk: logical block number
+ */
+static inline
+bool ssdfs_blk2off_table_bmap_vacant(struct ssdfs_bitmap_array *lbmap,
+				     int bitmap_index,
+				     u16 lbmap_bits,
+				     u16 logical_blk)
+{
+	unsigned long found;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap);
+
+	SSDFS_DBG("lbmap %p, bitmap_index %d, "
+		  "lbmap_bits %u, logical_blk %u\n",
+		  lbmap, bitmap_index,
+		  lbmap_bits, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (bitmap_index >= SSDFS_LBMAP_ARRAY_MAX) {
+		SSDFS_ERR("invalid bitmap index %d\n",
+			  bitmap_index);
+		return false;
+	}
+
+	if (logical_blk >= lbmap->bits_count)
+		return true;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap->array[bitmap_index]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	found = find_next_zero_bit(lbmap->array[bitmap_index],
+				   lbmap_bits, logical_blk);
+
+	return found == logical_blk;
+}
+
+/*
+ * ssdfs_blk2off_table_extent_vacant() - check extent vacancy
+ * @lbmap: bitmap pointer
+ * @bitmap_index: index of bitmap
+ * @lbmap_bits: count of bits in bitmap
+ * @extent: pointer on extent
+ */
+static inline
+bool ssdfs_blk2off_table_extent_vacant(struct ssdfs_bitmap_array *lbmap,
+					int bitmap_index,
+					u16 lbmap_bits,
+					struct ssdfs_blk2off_range *extent)
+{
+	unsigned long start, end;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap || !extent);
+
+	SSDFS_DBG("lbmap %p, bitmap_index %d, "
+		  "lbmap_bits %u, extent (start %u, len %u)\n",
+		  lbmap, bitmap_index, lbmap_bits,
+		  extent->start_lblk, extent->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (bitmap_index >= SSDFS_LBMAP_ARRAY_MAX) {
+		SSDFS_ERR("invalid bitmap index %d\n",
+			  bitmap_index);
+		return false;
+	}
+
+	if (extent->start_lblk >= lbmap_bits) {
+		SSDFS_ERR("invalid extent start %u\n",
+			  extent->start_lblk);
+		return false;
+	}
+
+	if (extent->len == 0 || extent->len >= U16_MAX) {
+		SSDFS_ERR("invalid extent length\n");
+		return false;
+	}
+
+	if (extent->start_lblk >= lbmap->bits_count)
+		return true;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!lbmap->array[bitmap_index]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start = find_next_zero_bit(lbmap->array[bitmap_index],
+				   lbmap_bits, extent->start_lblk);
+
+	if (start != extent->start_lblk)
+		return false;
+	else if (extent->len == 1)
+		return true;
+
+	end = find_next_bit(lbmap->array[bitmap_index], lbmap_bits, start);
+
+	if ((end - start) == extent->len)
+		return true;
+
+	return false;
+}
+
+/*
+ * is_ssdfs_table_header_magic_valid() - check segment header's magic
+ * @hdr: table header
+ */
+bool is_ssdfs_table_header_magic_valid(struct ssdfs_blk2off_table_header *hdr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return le16_to_cpu(hdr->magic.key) == SSDFS_BLK2OFF_TABLE_HDR_MAGIC;
+}
+
+/*
+ * ssdfs_check_table_header() - check table header
+ * @hdr: table header
+ * @size: size of header
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO     - header is invalid.
+ */
+static
+int ssdfs_check_table_header(struct ssdfs_blk2off_table_header *hdr,
+			     size_t size)
+{
+	u16 extents_off = offsetof(struct ssdfs_blk2off_table_header,
+				   sequence);
+	size_t extent_size = sizeof(struct ssdfs_translation_extent);
+	size_t extent_area;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr);
+
+	SSDFS_DBG("hdr %p, size %zu\n", hdr, size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_ssdfs_magic_valid(&hdr->magic) ||
+	    !is_ssdfs_table_header_magic_valid(hdr)) {
+		SSDFS_ERR("invalid table magic\n");
+		return -EIO;
+	}
+
+	if (!is_csum_valid(&hdr->check, hdr, size)) {
+		SSDFS_ERR("invalid checksum\n");
+		return -EIO;
+	}
+
+	if (extents_off != le16_to_cpu(hdr->extents_off)) {
+		SSDFS_ERR("invalid extents offset %u\n",
+			  le16_to_cpu(hdr->extents_off));
+		return -EIO;
+	}
+
+	extent_area = extent_size * le16_to_cpu(hdr->extents_count);
+	if (le16_to_cpu(hdr->offset_table_off) != (extents_off + extent_area)) {
+		SSDFS_ERR("invalid table offset: extents_off %u, "
+			  "extents_count %u, offset_table_off %u\n",
+			  le16_to_cpu(hdr->extents_off),
+			  le16_to_cpu(hdr->extents_count),
+			  le16_to_cpu(hdr->offset_table_off));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_check_fragment() - check table's fragment
+ * @table: pointer on table object
+ * @peb_index: PEB's index
+ * @hdr: fragment's header
+ * @fragment_size: size of fragment in bytes
+ *
+ * Method tries to check fragment validity.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - corrupted fragment.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_check_fragment(struct ssdfs_blk2off_table *table,
+			 u16 peb_index,
+			 struct ssdfs_phys_offset_table_header *hdr,
+			 size_t fragment_size)
+{
+	u16 start_id;
+	u16 sequence_id;
+	u16 id_count;
+	u32 byte_size;
+	u32 items_size;
+	__le32 csum1, csum2;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !hdr);
+	BUG_ON(peb_index >= table->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_id = le16_to_cpu(hdr->start_id);
+	id_count = le16_to_cpu(hdr->id_count);
+	byte_size = le32_to_cpu(hdr->byte_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("table %p, peb_index %u, start_id %u, "
+		  "id_count %u, byte_size %u, "
+		  "fragment_id %u\n",
+		  table, peb_index,
+		  start_id, id_count, byte_size,
+		  hdr->sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (le32_to_cpu(hdr->magic) != SSDFS_PHYS_OFF_TABLE_MAGIC) {
+		SSDFS_ERR("invalid magic %#x\n",
+			  le32_to_cpu(hdr->magic));
+		return -EIO;
+	}
+
+	if (byte_size > fragment_size) {
+		SSDFS_ERR("byte_size %u > fragment_size %zu\n",
+			  byte_size, fragment_size);
+		return -ERANGE;
+	}
+
+	csum1 = hdr->checksum;
+	hdr->checksum = 0;
+	csum2 = ssdfs_crc32_le(hdr, byte_size);
+	hdr->checksum = csum1;
+
+	if (csum1 != csum2) {
+		SSDFS_ERR("csum1 %#x != csum2 %#x\n",
+			  le32_to_cpu(csum1),
+			  le32_to_cpu(csum2));
+		return -EIO;
+	}
+
+	if (le16_to_cpu(hdr->peb_index) != peb_index) {
+		SSDFS_ERR("invalid peb_index %u\n",
+			  le16_to_cpu(hdr->peb_index));
+		return -EIO;
+	}
+
+	if (start_id == U16_MAX) {
+		SSDFS_ERR("invalid start_id %u for peb_index %u\n",
+			  start_id, peb_index);
+		return -EIO;
+	}
+
+	if (id_count == 0 || id_count > table->pages_per_peb) {
+		SSDFS_ERR("invalid id_count %u for peb_index %u\n",
+			  le16_to_cpu(hdr->id_count),
+			  peb_index);
+		return -EIO;
+	}
+
+	items_size = (u32)id_count *
+			sizeof(struct ssdfs_phys_offset_descriptor);
+
+	if (byte_size < items_size) {
+		SSDFS_ERR("invalid byte_size %u for peb_index %u\n",
+			  le32_to_cpu(hdr->byte_size),
+			  peb_index);
+		return -EIO;
+	}
+
+	sequence_id = le16_to_cpu(hdr->sequence_id);
+	if (sequence_id > SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD) {
+		SSDFS_ERR("invalid sequence_id %u for peb_index %u\n",
+			  sequence_id, peb_index);
+		return -EIO;
+	}
+
+	if (le16_to_cpu(hdr->type) == SSDFS_UNKNOWN_OFF_TABLE_TYPE ||
+	    le16_to_cpu(hdr->type) >= SSDFS_OFF_TABLE_MAX_TYPE) {
+		SSDFS_ERR("invalid type %#x for peb_index %u\n",
+			  le16_to_cpu(hdr->type), peb_index);
+		return -EIO;
+	}
+
+	if (le16_to_cpu(hdr->flags) & ~SSDFS_OFF_TABLE_FLAGS_MASK) {
+		SSDFS_ERR("invalid flags set %#x for peb_index %u\n",
+			  le16_to_cpu(hdr->flags), peb_index);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_get_checked_table_header() - get and check table header
+ * @portion: pointer on portion init environment [out]
+ */
+static
+int ssdfs_get_checked_table_header(struct ssdfs_blk2off_init *portion)
+{
+	size_t hdr_size = sizeof(struct ssdfs_blk2off_table_header);
+	struct page *page;
+	int page_index;
+	u32 page_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!portion || !portion->blk2off_pvec);
+
+	SSDFS_DBG("source %p, offset %u\n",
+		  portion->blk2off_pvec, portion->tbl_hdr_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = portion->tbl_hdr_off >> PAGE_SHIFT;
+	if (portion->tbl_hdr_off >= PAGE_SIZE)
+		page_off = portion->tbl_hdr_off % PAGE_SIZE;
+	else
+		page_off = portion->tbl_hdr_off;
+
+	if (page_index >= pagevec_count(portion->blk2off_pvec)) {
+		SSDFS_ERR("invalid page index %d: "
+			  "offset %u, pagevec_count %u\n",
+			  page_index, portion->tbl_hdr_off,
+			  pagevec_count(portion->blk2off_pvec));
+		return -EINVAL;
+	}
+
+	page = portion->blk2off_pvec->pages[page_index];
+
+	ssdfs_lock_page(page);
+	err = ssdfs_memcpy_from_page(&portion->tbl_hdr, 0, hdr_size,
+				     page, page_off, PAGE_SIZE,
+				     hdr_size);
+	ssdfs_unlock_page(page);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: "
+			  "page_off %u, hdr_size %zu\n",
+			  page_off, hdr_size);
+		return err;
+	}
+
+	err = ssdfs_check_table_header(&portion->tbl_hdr, hdr_size);
+	if (err) {
+		SSDFS_ERR("invalid table header\n");
+		return err;
+	}
+
+	portion->fragments_count =
+		le16_to_cpu(portion->tbl_hdr.fragments_count);
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_prepare_temp_bmap() - prepare temporary bitmap
+ * @portion: initialization environment [in | out]
+ */
+static inline
+int ssdfs_blk2off_prepare_temp_bmap(struct ssdfs_blk2off_init *portion)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!portion || portion->bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	portion->bmap_bytes = ssdfs_blk2off_table_bmap_bytes(portion->capacity);
+	portion->bmap = ssdfs_blk2off_kvzalloc(portion->bmap_bytes,
+						GFP_KERNEL);
+	if (unlikely(!portion->bmap)) {
+		SSDFS_ERR("fail to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_prepare_extent_array() - prepare extents array
+ * @portion: initialization environment [in | out]
+ */
+static
+int ssdfs_blk2off_prepare_extent_array(struct ssdfs_blk2off_init *portion)
+{
+	size_t extent_size = sizeof(struct ssdfs_translation_extent);
+	u32 extents_off, table_off;
+	size_t ext_array_size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!portion || !portion->blk2off_pvec || portion->extent_array);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	extents_off = offsetof(struct ssdfs_blk2off_table_header, sequence);
+	if (extents_off != le16_to_cpu(portion->tbl_hdr.extents_off)) {
+		SSDFS_ERR("invalid extents offset %u\n",
+			  le16_to_cpu(portion->tbl_hdr.extents_off));
+		return -EIO;
+	}
+
+	portion->extents_count = le16_to_cpu(portion->tbl_hdr.extents_count);
+	ext_array_size = extent_size * portion->extents_count;
+	table_off = le16_to_cpu(portion->tbl_hdr.offset_table_off);
+
+	if (ext_array_size == 0 ||
+	    (extents_off + ext_array_size) != table_off) {
+		SSDFS_ERR("invalid table header: "
+			  "extents_off %u, extents_count %u, "
+			  "offset_table_off %u\n",
+			  extents_off, portion->extents_count, table_off);
+		return -EIO;
+	}
+
+	if (ext_array_size > 0) {
+		u32 array_size = ext_array_size;
+		u32 read_bytes = 0;
+		int page_index;
+		u32 page_off;
+#ifdef CONFIG_SSDFS_DEBUG
+		int i;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		portion->extent_array = ssdfs_blk2off_kzalloc(ext_array_size,
+							      GFP_KERNEL);
+		if (unlikely(!portion->extent_array)) {
+			SSDFS_ERR("fail to allocate memory\n");
+			return -ENOMEM;
+		}
+
+		extents_off = offsetof(struct ssdfs_blk2off_table_header,
+					sequence);
+		page_index = extents_off >> PAGE_SHIFT;
+		page_off = extents_off % PAGE_SIZE;
+
+		while (array_size > 0) {
+			u32 size;
+			struct page *page;
+
+			if (page_index >= pagevec_count(portion->blk2off_pvec)) {
+				SSDFS_ERR("invalid request: "
+					  "page_index %d, pagevec_size %u\n",
+					  page_index,
+					  pagevec_count(portion->blk2off_pvec));
+				return -ERANGE;
+			}
+
+			size = min_t(u32, PAGE_SIZE - page_off,
+					array_size);
+			page = portion->blk2off_pvec->pages[page_index];
+
+			ssdfs_lock_page(page);
+			err = ssdfs_memcpy_from_page(portion->extent_array,
+						     read_bytes, ext_array_size,
+						     page,
+						     page_off, PAGE_SIZE,
+						     size);
+			ssdfs_unlock_page(page);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy: err %d\n",
+					  err);
+				return err;
+			}
+
+			read_bytes += size;
+			array_size -= size;
+			extents_off += size;
+
+			page_index = extents_off >> PAGE_SHIFT;
+			page_off = extents_off % PAGE_SIZE;
+		};
+
+#ifdef CONFIG_SSDFS_DEBUG
+		for (i = 0; i < portion->extents_count; i++) {
+			struct ssdfs_translation_extent *extent;
+			extent = &portion->extent_array[i];
+
+			SSDFS_DBG("index %d, logical_blk %u, offset_id %u, "
+				  "len %u, sequence_id %u, state %u\n",
+				  i,
+				  le16_to_cpu(extent->logical_blk),
+				  le16_to_cpu(extent->offset_id),
+				  le16_to_cpu(extent->len),
+				  extent->sequence_id,
+				  extent->state);
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_get_fragment_header() - get fragment header
+ * @portion: initialization environment [in | out]
+ * @offset: header offset in bytes
+ */
+static
+int ssdfs_get_fragment_header(struct ssdfs_blk2off_init *portion,
+			      u32 offset)
+{
+	size_t hdr_size = sizeof(struct ssdfs_phys_offset_table_header);
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!portion || !portion->blk2off_pvec);
+
+	SSDFS_DBG("source %p, offset %u\n",
+		  portion->blk2off_pvec, offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_unaligned_read_pagevec(portion->blk2off_pvec,
+					   offset,
+					   hdr_size,
+					   &portion->pot_hdr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_get_checked_fragment() - get checked table's fragment
+ * @portion: initialization environment [in | out]
+ *
+ * This method tries to get and to check fragment validity.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EIO        - corrupted fragment.
+ * %-EEXIST     - has been initialized already.
+ */
+static
+int ssdfs_get_checked_fragment(struct ssdfs_blk2off_init *portion)
+{
+	struct ssdfs_phys_offset_table_array *phys_off_table;
+	struct ssdfs_phys_offset_table_fragment *fragment;
+	struct page *page;
+	void *kaddr;
+	int page_index;
+	u32 page_off;
+	size_t fragment_size;
+	u16 start_id;
+	u16 sequence_id;
+	int state;
+	u32 read_bytes;
+#ifdef CONFIG_SSDFS_DEBUG
+	int i;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!portion || !portion->table || !portion->blk2off_pvec);
+
+	SSDFS_DBG("table %p, peb_index %u, source %p, offset %u\n",
+		  portion->table, portion->peb_index,
+		  portion->blk2off_pvec, portion->pot_hdr_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragment_size = le32_to_cpu(portion->pot_hdr.byte_size);
+	start_id = le16_to_cpu(portion->pot_hdr.start_id);
+	sequence_id = le16_to_cpu(portion->pot_hdr.sequence_id);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("sequence_id %u\n", sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (fragment_size > PAGE_SIZE) {
+		SSDFS_ERR("invalid fragment_size %zu\n",
+			  fragment_size);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		for (i = 0; i < pagevec_count(portion->blk2off_pvec); i++) {
+			page = portion->blk2off_pvec->pages[i];
+
+			kaddr = kmap_local_page(page);
+			SSDFS_DBG("PAGE DUMP: index %d\n",
+				  i);
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					     kaddr,
+					     PAGE_SIZE);
+			SSDFS_DBG("\n");
+			kunmap_local(kaddr);
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return -EIO;
+	}
+
+	if (sequence_id > SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD) {
+		SSDFS_ERR("invalid sequence_id %u\n",
+			  sequence_id);
+		return -EIO;
+	}
+
+	phys_off_table = &portion->table->peb[portion->peb_index];
+
+	kaddr = ssdfs_sequence_array_get_item(phys_off_table->sequence,
+						sequence_id);
+	if (IS_ERR_OR_NULL(kaddr)) {
+		/* expected state -> continue logic */
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment %u is absent\n",
+			  sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment %u has been initialized already\n",
+			  sequence_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EEXIST;
+	}
+
+	fragment = ssdfs_blk2off_frag_alloc();
+	if (IS_ERR_OR_NULL(fragment)) {
+		err = (fragment == NULL ? -ENOMEM : PTR_ERR(fragment));
+		SSDFS_ERR("fail to allocate fragment: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	err = ssdfs_sequence_array_init_item(phys_off_table->sequence,
+					     sequence_id,
+					     fragment);
+	if (unlikely(err)) {
+		ssdfs_blk2off_frag_free(fragment);
+		SSDFS_ERR("fail to init fragment: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	state = SSDFS_BLK2OFF_FRAG_CREATED;
+	err = ssdfs_blk2off_table_init_fragment(fragment,
+						sequence_id,
+						start_id,
+						portion->table->pages_per_peb,
+						state,
+						&fragment_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to initialize fragment: err %d\n",
+			  err);
+		return err;
+	}
+
+	page_index = portion->pot_hdr_off >> PAGE_SHIFT;
+	if (portion->pot_hdr_off >= PAGE_SIZE)
+		page_off = portion->pot_hdr_off % PAGE_SIZE;
+	else
+		page_off = portion->pot_hdr_off;
+
+	down_write(&fragment->lock);
+
+	read_bytes = 0;
+	while (fragment_size > 0) {
+		u32 size;
+
+		size = min_t(u32, PAGE_SIZE - page_off, fragment_size);
+
+		if (page_index >= pagevec_count(portion->blk2off_pvec)) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid request: "
+				  "page_index %d, pvec_size %u\n",
+				  page_index,
+				  pagevec_count(portion->blk2off_pvec));
+			goto finish_fragment_read;
+		}
+
+		page = portion->blk2off_pvec->pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("read_bytes %u, fragment->buf_size %zu, "
+			  "page_off %u, size %u\n",
+			  read_bytes, fragment->buf_size, page_off, page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		err = ssdfs_memcpy_from_page(fragment->buf,
+					     read_bytes, fragment->buf_size,
+					     page, page_off, PAGE_SIZE,
+					     size);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			goto finish_fragment_read;
+		}
+
+		read_bytes += size;
+		fragment_size -= size;
+		portion->pot_hdr_off += size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("read_bytes %u, fragment_size %zu, "
+			  "pot_hdr_off %u\n",
+			  read_bytes, fragment_size,
+			  portion->pot_hdr_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page_index = portion->pot_hdr_off >> PAGE_SHIFT;
+		if (portion->pot_hdr_off >= PAGE_SIZE)
+			page_off = portion->pot_hdr_off % PAGE_SIZE;
+		else
+			page_off = portion->pot_hdr_off;
+	};
+
+	err = ssdfs_check_fragment(portion->table, portion->peb_index,
+				   fragment->hdr,
+				   fragment->buf_size);
+	if (err)
+		goto finish_fragment_read;
+
+	fragment->start_id = start_id;
+	atomic_set(&fragment->id_count,
+		   le16_to_cpu(fragment->hdr->id_count));
+	atomic_set(&fragment->state, SSDFS_BLK2OFF_FRAG_INITIALIZED);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("FRAGMENT: sequence_id %u, start_id %u, id_count %d\n",
+		  sequence_id, start_id, atomic_read(&fragment->id_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_fragment_read:
+	up_write(&fragment->lock);
+
+	if (err) {
+		SSDFS_ERR("corrupted fragment: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * is_ssdfs_offset_position_older() - is position checkpoint older?
+ * @pos: position offset
+ * @cno: checkpoint number for comparison
+ */
+static inline
+bool is_ssdfs_offset_position_older(struct ssdfs_offset_position *pos,
+				    u64 cno)
+{
+	if (pos->cno != SSDFS_INVALID_CNO)
+		return pos->cno >= cno;
+
+	return false;
+}
+
+/*
+ * ssdfs_check_translation_extent() - check translation extent
+ * @extent: pointer on translation extent
+ * @capacity: logical blocks capacity
+ * @sequence_id: extent's sequence id
+ *
+ * This method tries to check extent's validity.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - corrupted translation extent.
+ */
+static
+int ssdfs_check_translation_extent(struct ssdfs_translation_extent *extent,
+				   u16 capacity, u8 sequence_id)
+{
+	u16 logical_blk;
+	u16 offset_id;
+	u16 len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!extent);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_blk = le16_to_cpu(extent->logical_blk);
+	offset_id = le16_to_cpu(extent->offset_id);
+	len = le16_to_cpu(extent->len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, offset_id %u, len %u, "
+		  "sequence_id %u, state %#x\n",
+		  logical_blk, offset_id, len,
+		  extent->sequence_id, extent->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (extent->state <= SSDFS_LOGICAL_BLK_UNKNOWN_STATE ||
+	    extent->state >= SSDFS_LOGICAL_BLK_STATE_MAX) {
+		SSDFS_ERR("invalid translation extent: "
+			  "unknown state %#x\n",
+			  extent->state);
+		return -EIO;
+	}
+
+	if (logical_blk > (U16_MAX - len) ||
+	    (logical_blk + len) > capacity) {
+		SSDFS_ERR("invalid translation extent: "
+			  "logical_blk %u, len %u, capacity %u\n",
+			  logical_blk, len, capacity);
+		return -EIO;
+	}
+
+	if (extent->state != SSDFS_LOGICAL_BLK_FREE) {
+		if (offset_id > (U16_MAX - len)) {
+			SSDFS_ERR("invalid translation extent: "
+				  "offset_id %u, len %u\n",
+				  offset_id, len);
+			return -EIO;
+		}
+	}
+
+	if (sequence_id != extent->sequence_id) {
+		SSDFS_ERR("invalid translation extent: "
+			  "sequence_id %u != extent->sequence_id %u\n",
+			  sequence_id, extent->sequence_id);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_process_used_translation_extent() - process used translation extent
+ * @portion: pointer on portion init environment [in | out]
+ * @extent_index: index of extent
+ *
+ * This method checks translation extent, to set bitmap for
+ * logical blocks in the extent and to fill portion of
+ * offset position array by physical offsets id.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EIO        - corrupted translation extent.
+ * %-EAGAIN     - extent is partially processed in the fragment.
+ */
+static
+int ssdfs_process_used_translation_extent(struct ssdfs_blk2off_init *portion,
+					  int *extent_index)
+{
+	struct ssdfs_sequence_array *sequence = NULL;
+	struct ssdfs_phys_offset_table_fragment *frag = NULL;
+	struct ssdfs_phys_offset_descriptor *phys_off = NULL;
+	struct ssdfs_translation_extent *extent = NULL;
+	struct ssdfs_dynamic_array *lblk2off;
+	void *ptr;
+	u16 peb_index;
+	u16 sequence_id;
+	u16 pos_array_items;
+	u16 start_id;
+	u16 id_count;
+	u16 id_diff;
+	u32 logical_blk;
+	u16 offset_id;
+	u16 len;
+	int phys_off_index;
+	bool is_partially_processed = false;
+	struct ssdfs_blk_state_offset *state_off;
+	int i, j;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!portion || !extent_index);
+	BUG_ON(!portion->bmap || !portion->extent_array);
+	BUG_ON(portion->cno == SSDFS_INVALID_CNO);
+	BUG_ON(*extent_index >= portion->extents_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	lblk2off = &portion->table->lblk2off;
+
+	peb_index = portion->peb_index;
+	sequence_id = le16_to_cpu(portion->pot_hdr.sequence_id);
+
+	sequence = portion->table->peb[peb_index].sequence;
+	ptr = ssdfs_sequence_array_get_item(sequence, sequence_id);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = (ptr == NULL ? -ENOENT : PTR_ERR(ptr));
+		SSDFS_ERR("fail to get fragment: "
+			  "sequence_id %u, err %d\n",
+			  sequence_id, err);
+		return err;
+	}
+	frag = (struct ssdfs_phys_offset_table_fragment *)ptr;
+
+	start_id = le16_to_cpu(portion->pot_hdr.start_id);
+	id_count = le16_to_cpu(portion->pot_hdr.id_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_id %u, id_count %u\n",
+		  start_id, id_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	extent = &portion->extent_array[*extent_index];
+
+	err = ssdfs_check_translation_extent(extent, portion->capacity,
+					     *extent_index);
+	if (err) {
+		SSDFS_ERR("invalid translation extent: "
+			  "index %u, err %d\n",
+			  *extent_index, err);
+		return err;
+	}
+
+	if (*extent_index == 0 && extent->state != SSDFS_LOGICAL_BLK_USED) {
+		SSDFS_ERR("invalid translation extent state %#x\n",
+			  extent->state);
+		return -EIO;
+	}
+
+	logical_blk = le16_to_cpu(extent->logical_blk);
+	offset_id = le16_to_cpu(extent->offset_id);
+	len = le16_to_cpu(extent->len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, offset_id %u, len %u, "
+		  "sequence_id %u, state %#x\n",
+		  logical_blk, offset_id, len,
+		  extent->sequence_id, extent->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((start_id + id_count) < offset_id) {
+		SSDFS_ERR("start_id %u + id_count %u < offset_id %u\n",
+			  start_id, id_count, offset_id);
+		return -EIO;
+	}
+
+	if ((offset_id + len) <= start_id) {
+		SSDFS_ERR("offset_id %u + len %u <= start_id %u\n",
+			  offset_id, len, start_id);
+		return -EIO;
+	}
+
+	if (offset_id < start_id) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("offset_id %u, len %u, "
+			  "start_id %u,id_count %u\n",
+			  offset_id, len,
+			  start_id, id_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		id_diff = start_id - offset_id;
+		offset_id += id_diff;
+		logical_blk += id_diff;
+		len -= id_diff;
+	}
+
+	if ((offset_id + len) > (start_id + id_count)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("offset_id %u, len %u, "
+			  "start_id %u,id_count %u\n",
+			  offset_id, len,
+			  start_id, id_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		is_partially_processed = true;
+
+		/* correct lenght */
+		len = (start_id + id_count) - offset_id;
+	}
+
+	pos_array_items = portion->capacity - logical_blk;
+
+	if (pos_array_items < len) {
+		SSDFS_ERR("array_items %u < len %u\n",
+			  pos_array_items, len);
+		return -EINVAL;
+	}
+
+	if (id_count > atomic_read(&frag->id_count)) {
+		SSDFS_ERR("id_count %u > frag->id_count %d\n",
+			  id_count,
+			  atomic_read(&frag->id_count));
+		return -EIO;
+	}
+
+	phys_off_index = offset_id - start_id;
+
+	if ((phys_off_index + len) > id_count) {
+		SSDFS_ERR("phys_off_index %d, len %u, id_count %u\n",
+			  phys_off_index, len, id_count);
+		return -EIO;
+	}
+
+	bitmap_clear(portion->bmap, 0, portion->capacity);
+
+	down_read(&frag->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	for (j = 0; j < pagevec_count(portion->blk_desc_pvec); j++) {
+		void *kaddr;
+		struct page *page = portion->blk_desc_pvec->pages[j];
+
+		kaddr = kmap_local_page(page);
+		SSDFS_DBG("PAGE DUMP: index %d\n",
+			  j);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr,
+				     PAGE_SIZE);
+		SSDFS_DBG("\n");
+		kunmap_local(kaddr);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < len; i++) {
+		size_t area_tbl_size = sizeof(struct ssdfs_area_block_table);
+		size_t desc_size = sizeof(struct ssdfs_block_descriptor);
+		struct ssdfs_offset_position *pos;
+		u16 id = offset_id + i;
+		u16 cur_blk;
+		u32 byte_offset;
+		bool is_invalid = false;
+
+		phys_off = &frag->phys_offs[phys_off_index + i];
+
+		cur_blk = le16_to_cpu(phys_off->page_desc.logical_blk);
+		byte_offset = le32_to_cpu(phys_off->blk_state.byte_offset);
+
+		if (byte_offset < area_tbl_size) {
+			err = -EIO;
+			SSDFS_ERR("corrupted phys offset: "
+				  "byte_offset %u, area_tbl_size %zu\n",
+				  byte_offset, area_tbl_size);
+			goto finish_process_fragment;
+		}
+
+		byte_offset -= area_tbl_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cur_blk %u, byte_offset %u\n",
+			  cur_blk, byte_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (cur_blk >= portion->capacity) {
+			err = -EIO;
+			SSDFS_ERR("logical_blk %u >= portion->capacity %u\n",
+				  cur_blk, portion->capacity);
+			goto finish_process_fragment;
+		}
+
+		if (cur_blk < logical_blk || cur_blk >= (logical_blk + len)) {
+			err = -EIO;
+			SSDFS_ERR("cur_blk %u, logical_blk %u, len %u\n",
+				  cur_blk, logical_blk, len);
+			goto finish_process_fragment;
+		}
+
+		pos = SSDFS_OFF_POS(ssdfs_dynamic_array_get_locked(lblk2off,
+								   cur_blk));
+		if (IS_ERR_OR_NULL(pos)) {
+			err = (pos == NULL ? -ENOENT : PTR_ERR(pos));
+			SSDFS_ERR("fail to get logical block: "
+				  "cur_blk %u, err %d\n",
+				  cur_blk, err);
+			goto finish_process_fragment;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("portion->cno %#llx, "
+			  "pos (cno %#llx, id %u, peb_index %u, "
+			  "sequence_id %u, offset_index %u)\n",
+			  portion->cno,
+			  pos->cno, pos->id, pos->peb_index,
+			  pos->sequence_id, pos->offset_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (is_ssdfs_offset_position_older(pos, portion->cno)) {
+			/* logical block has been initialized already */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("logical block %u has been initialized already\n",
+				  cur_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+			err = ssdfs_dynamic_array_release(lblk2off,
+							  cur_blk, pos);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to release: "
+					  "cur_blk %u, err %d\n",
+					  cur_blk, err);
+				goto finish_process_fragment;
+			} else
+				continue;
+		}
+
+		peb_index = portion->peb_index;
+
+		bitmap_set(portion->bmap, cur_blk, 1);
+
+		pos->cno = portion->cno;
+		pos->id = id;
+		pos->peb_index = peb_index;
+		pos->sequence_id = sequence_id;
+		pos->offset_index = phys_off_index + i;
+
+		err = ssdfs_unaligned_read_pagevec(portion->blk_desc_pvec,
+						   byte_offset,
+						   desc_size,
+						   &pos->blk_desc.buf);
+		if (err == -E2BIG) {
+			err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable init block descriptor: "
+				  "logical block %u\n",
+				  cur_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			pos->blk_desc.status = SSDFS_BLK_DESC_BUF_UNKNOWN_STATE;
+			memset(&pos->blk_desc.buf, 0xFF,
+				sizeof(desc_size));
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to read block descriptor: "
+				  "cur_blk %u, err %d\n",
+				  cur_blk, err);
+			ssdfs_dynamic_array_release(lblk2off,
+						    cur_blk, pos);
+			goto finish_process_fragment;
+		} else
+			pos->blk_desc.status = SSDFS_BLK_DESC_BUF_INITIALIZED;
+
+		state_off = &pos->blk_desc.buf.state[0];
+
+		switch (pos->blk_desc.status) {
+		case SSDFS_BLK_DESC_BUF_INITIALIZED:
+			is_invalid =
+				IS_SSDFS_BLK_STATE_OFFSET_INVALID(state_off);
+			break;
+
+		default:
+			is_invalid = false;
+			break;
+		}
+
+		if (is_invalid) {
+			err = -ERANGE;
+			SSDFS_ERR("block state offset invalid\n");
+
+			SSDFS_ERR("status %#x, ino %llu, "
+				  "logical_offset %u, peb_index %u, "
+				  "peb_page %u\n",
+				  pos->blk_desc.status,
+				  le64_to_cpu(pos->blk_desc.buf.ino),
+				  le32_to_cpu(pos->blk_desc.buf.logical_offset),
+				  le16_to_cpu(pos->blk_desc.buf.peb_index),
+				  le16_to_cpu(pos->blk_desc.buf.peb_page));
+
+			for (j = 0; j < SSDFS_BLK_STATE_OFF_MAX; j++) {
+				state_off = &pos->blk_desc.buf.state[j];
+
+				SSDFS_ERR("BLK STATE OFFSET %d: "
+					  "log_start_page %u, log_area %#x, "
+					  "byte_offset %u, "
+					  "peb_migration_id %u\n",
+					  j,
+					  le16_to_cpu(state_off->log_start_page),
+					  state_off->log_area,
+					  le32_to_cpu(state_off->byte_offset),
+					  state_off->peb_migration_id);
+			}
+
+			ssdfs_dynamic_array_release(lblk2off, cur_blk, pos);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			goto finish_process_fragment;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("status %#x, ino %llu, "
+			  "logical_offset %u, peb_index %u, peb_page %u\n",
+			  pos->blk_desc.status,
+			  le64_to_cpu(pos->blk_desc.buf.ino),
+			  le32_to_cpu(pos->blk_desc.buf.logical_offset),
+			  le16_to_cpu(pos->blk_desc.buf.peb_index),
+			  le16_to_cpu(pos->blk_desc.buf.peb_page));
+
+		for (j = 0; j < SSDFS_BLK_STATE_OFF_MAX; j++) {
+			state_off = &pos->blk_desc.buf.state[j];
+
+			SSDFS_DBG("BLK STATE OFFSET %d: "
+				  "log_start_page %u, log_area %#x, "
+				  "byte_offset %u, peb_migration_id %u\n",
+				  j,
+				  le16_to_cpu(state_off->log_start_page),
+				  state_off->log_area,
+				  le32_to_cpu(state_off->byte_offset),
+				  state_off->peb_migration_id);
+		}
+
+		SSDFS_DBG("set init bitmap: cur_blk %u\n",
+			  cur_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_dynamic_array_release(lblk2off, cur_blk, pos);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to release: "
+				  "cur_blk %u, err %d\n",
+				  cur_blk, err);
+			goto finish_process_fragment;
+		}
+
+		err = ssdfs_blk2off_table_bmap_set(&portion->table->lbmap,
+						   SSDFS_LBMAP_INIT_INDEX,
+						   cur_blk);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set init bitmap: "
+				  "logical_blk %u, err %d\n",
+				  cur_blk, err);
+			goto finish_process_fragment;
+		}
+	}
+
+finish_process_fragment:
+	up_read(&frag->lock);
+
+	if (unlikely(err))
+		return err;
+
+	if (bitmap_intersects(portion->bmap,
+			portion->table->lbmap.array[SSDFS_LBMAP_STATE_INDEX],
+			portion->table->lbmap.bits_count)) {
+		SSDFS_ERR("invalid translation extent: "
+			  "logical_blk %u, offset_id %u, len %u\n",
+			  logical_blk, offset_id, len);
+		return -EIO;
+	}
+
+	bitmap_or(portion->table->lbmap.array[SSDFS_LBMAP_STATE_INDEX],
+		  portion->bmap,
+		  portion->table->lbmap.array[SSDFS_LBMAP_STATE_INDEX],
+		  portion->table->lbmap.bits_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("init_bmap %lx, state_bmap %lx, modification_bmap %lx\n",
+		  *portion->table->lbmap.array[SSDFS_LBMAP_INIT_INDEX],
+		  *portion->table->lbmap.array[SSDFS_LBMAP_STATE_INDEX],
+		  *portion->table->lbmap.array[SSDFS_LBMAP_MODIFICATION_INDEX]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_partially_processed) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("extent has been processed partially: "
+			  "index %u\n", *extent_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_process_free_translation_extent() - process free translation extent
+ * @portion: pointer on portion init environment [in | out]
+ * @extent_index: index of extent
+ *
+ * This method checks translation extent, to set bitmap for
+ * logical blocks in the extent and to fill portion of
+ * offset position array by physical offsets id.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EIO        - corrupted translation extent.
+ */
+static
+int ssdfs_process_free_translation_extent(struct ssdfs_blk2off_init *portion,
+					  int *extent_index)
+{
+	struct ssdfs_sequence_array *sequence = NULL;
+	struct ssdfs_phys_offset_table_fragment *frag = NULL;
+	struct ssdfs_translation_extent *extent = NULL;
+	struct ssdfs_dynamic_array *lblk2off;
+	void *ptr;
+	u16 peb_index;
+	u16 sequence_id;
+	u16 pos_array_items;
+	size_t pos_size = sizeof(struct ssdfs_offset_position);
+	u32 logical_blk;
+	u16 len;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!portion || !extent_index);
+	BUG_ON(!portion->extent_array);
+	BUG_ON(portion->cno == SSDFS_INVALID_CNO);
+	BUG_ON(*extent_index >= portion->extents_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	lblk2off = &portion->table->lblk2off;
+
+	peb_index = portion->peb_index;
+	sequence_id = le16_to_cpu(portion->pot_hdr.sequence_id);
+
+	sequence = portion->table->peb[peb_index].sequence;
+	ptr = ssdfs_sequence_array_get_item(sequence, sequence_id);
+	if (IS_ERR_OR_NULL(ptr)) {
+		err = (ptr == NULL ? -ENOENT : PTR_ERR(ptr));
+		SSDFS_ERR("fail to get fragment: "
+			  "sequence_id %u, err %d\n",
+			  sequence_id, err);
+		return err;
+	}
+	frag = (struct ssdfs_phys_offset_table_fragment *)ptr;
+
+	extent = &portion->extent_array[*extent_index];
+	logical_blk = le16_to_cpu(extent->logical_blk);
+	len = le16_to_cpu(extent->len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("logical_blk %u, len %u, "
+		  "sequence_id %u, state %#x\n",
+		  logical_blk, len,
+		  extent->sequence_id, extent->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pos_array_items = portion->capacity - logical_blk;
+
+	if (pos_array_items < len) {
+		SSDFS_ERR("array_items %u < len %u\n",
+			  pos_array_items, len);
+		return -EINVAL;
+	}
+
+	err = ssdfs_check_translation_extent(extent, portion->capacity,
+					     *extent_index);
+	if (err) {
+		SSDFS_ERR("invalid translation extent: "
+			  "sequence_id %u, err %d\n",
+			  *extent_index, err);
+		return err;
+	}
+
+	down_read(&frag->lock);
+
+	for (i = 0; i < len; i++) {
+		struct ssdfs_offset_position *pos;
+		u32 cur_blk = logical_blk + i;
+
+		pos = SSDFS_OFF_POS(ssdfs_dynamic_array_get_locked(lblk2off,
+								   cur_blk));
+		if (IS_ERR_OR_NULL(pos)) {
+			err = (pos == NULL ? -ENOENT : PTR_ERR(pos));
+			SSDFS_ERR("fail to get logical block: "
+				  "cur_blk %u, err %d\n",
+				  cur_blk, err);
+			goto finish_process_fragment;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("portion->cno %#llx, "
+			  "pos (cno %#llx, id %u, peb_index %u, "
+			  "sequence_id %u, offset_index %u)\n",
+			  portion->cno,
+			  pos->cno, pos->id, pos->peb_index,
+			  pos->sequence_id, pos->offset_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (is_ssdfs_offset_position_older(pos, portion->cno)) {
+			/* logical block has been initialized already */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("logical block %u has been initialized already\n",
+				  cur_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+			err = ssdfs_dynamic_array_release(lblk2off,
+							  cur_blk, pos);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to release: "
+					  "cur_blk %u, err %d\n",
+					  cur_blk, err);
+				goto finish_process_fragment;
+			} else
+				continue;
+		}
+
+		err = ssdfs_blk2off_table_bmap_clear(&portion->table->lbmap,
+						     SSDFS_LBMAP_STATE_INDEX,
+						     cur_blk);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to clear state bitmap: "
+				  "logical_blk %u, err %d\n",
+				  cur_blk, err);
+			goto finish_process_fragment;
+		}
+
+		memset(pos, 0xFF, pos_size);
+
+		pos->cno = portion->cno;
+		pos->peb_index = portion->peb_index;
+
+		err = ssdfs_dynamic_array_release(lblk2off, cur_blk, pos);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to release: "
+				  "cur_blk %u, err %d\n",
+				  cur_blk, err);
+			goto finish_process_fragment;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("set init bitmap: cur_blk %u\n",
+			  cur_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_blk2off_table_bmap_set(&portion->table->lbmap,
+						   SSDFS_LBMAP_INIT_INDEX,
+						   cur_blk);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set init bitmap: "
+				  "logical_blk %u, err %d\n",
+				  cur_blk, err);
+			goto finish_process_fragment;
+		}
+
+		/*
+		 * Free block needs to be marked as modified
+		 * with the goal not to lose the information
+		 * about free blocks in the case of PEB migration.
+		 * Because, offsets translation table's snapshot
+		 * needs to contain information about free blocks.
+		 */
+		err = ssdfs_blk2off_table_bmap_set(&portion->table->lbmap,
+						SSDFS_LBMAP_MODIFICATION_INDEX,
+						cur_blk);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set modification bitmap: "
+				  "logical_blk %u, err %d\n",
+				  cur_blk, err);
+			goto finish_process_fragment;
+		}
+	}
+
+finish_process_fragment:
+	up_read(&frag->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_blk2off_fragment_init() - initialize portion's fragment
+ * @portion: pointer on portion init environment [in | out]
+ * @fragment_index: index of fragment
+ * @extent_index: pointer on extent index [in | out]
+ */
+static
+int ssdfs_blk2off_fragment_init(struct ssdfs_blk2off_init *portion,
+				int fragment_index,
+				int *extent_index)
+{
+	struct ssdfs_sequence_array *sequence = NULL;
+	struct ssdfs_translation_extent *extent = NULL;
+	u16 logical_blk;
+	u16 offset_id;
+	u16 len;
+	u16 start_id;
+	u16 id_count;
+	u16 processed_offset_ids = 0;
+	int state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!portion || !portion->table || !portion->blk2off_pvec);
+	BUG_ON(!portion->bmap || !portion->extent_array);
+	BUG_ON(!extent_index);
+	BUG_ON(portion->peb_index >= portion->table->pebs_count);
+
+	SSDFS_DBG("peb_index %u, fragment_index %d, "
+		  "extent_index %u, extents_count %u\n",
+		  portion->peb_index, fragment_index,
+		  *extent_index, portion->extents_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (fragment_index == 0) {
+		portion->pot_hdr_off = portion->tbl_hdr_off +
+				le16_to_cpu(portion->tbl_hdr.offset_table_off);
+		err = ssdfs_get_fragment_header(portion, portion->pot_hdr_off);
+	} else {
+		portion->pot_hdr_off = portion->tbl_hdr_off +
+				le16_to_cpu(portion->pot_hdr.next_fragment_off);
+		err = ssdfs_get_fragment_header(portion, portion->pot_hdr_off);
+	}
+
+	if (err) {
+		SSDFS_ERR("fail to get fragment header: err %d\n",
+			  err);
+		return err;
+	}
+
+	err = ssdfs_get_checked_fragment(portion);
+	if (err == -EEXIST) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment has been initialized already: "
+			  "peb_index %u, offset %u\n",
+			  portion->peb_index,
+			  portion->pot_hdr_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (err) {
+		SSDFS_ERR("fail to get checked fragment: "
+			  "peb_index %u, offset %u, err %d\n",
+			  portion->peb_index,
+			  portion->pot_hdr_off, err);
+		return err;
+	}
+
+	if (*extent_index >= portion->extents_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("extent_index %u >= extents_count %u\n",
+			  *extent_index, portion->extents_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	start_id = le16_to_cpu(portion->pot_hdr.start_id);
+	id_count = le16_to_cpu(portion->pot_hdr.id_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_id %u, id_count %u\n",
+		  start_id, id_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	while (*extent_index < portion->extents_count) {
+		extent = &portion->extent_array[*extent_index];
+		logical_blk = le16_to_cpu(extent->logical_blk);
+		offset_id = le16_to_cpu(extent->offset_id);
+		len = le16_to_cpu(extent->len);
+		state = extent->state;
+
+		if (processed_offset_ids > id_count) {
+			SSDFS_ERR("processed_offset_ids %u > id_count %u\n",
+				  processed_offset_ids, id_count);
+			return -ERANGE;
+		} else if (processed_offset_ids == id_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fragment has been processed: "
+				  "processed_offset_ids %u == id_count %u\n",
+				  processed_offset_ids, id_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_fragment_processing;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_blk %u, len %u, "
+			  "state %#x, extent_index %d\n",
+			  logical_blk, len, state, *extent_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (logical_blk >= portion->capacity) {
+			err = -ERANGE;
+			SSDFS_ERR("logical_blk %u >= capacity %u\n",
+				  logical_blk, portion->capacity);
+			return err;
+		}
+
+		if (state != SSDFS_LOGICAL_BLK_FREE) {
+			if (offset_id >= (start_id + id_count)) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("offset_id %u, start_id %u, "
+					  "id_count %u\n",
+					  offset_id, start_id, id_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_fragment_processing;
+			}
+		}
+
+		if (state == SSDFS_LOGICAL_BLK_USED) {
+			err = ssdfs_process_used_translation_extent(portion,
+								extent_index);
+			if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("extent has been processed partially: "
+					  "sequence_id %u, err %d\n",
+					  *extent_index, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("invalid translation extent: "
+					  "sequence_id %u, err %d\n",
+					  *extent_index, err);
+				return err;
+			}
+		} else if (state == SSDFS_LOGICAL_BLK_FREE) {
+			err = ssdfs_process_free_translation_extent(portion,
+								extent_index);
+			if (err) {
+				SSDFS_ERR("invalid translation extent: "
+					  "sequence_id %u, err %d\n",
+					  *extent_index, err);
+				return err;
+			}
+		} else
+			BUG();
+
+		if (err == -EAGAIN) {
+			SSDFS_DBG("don't increment extent index\n");
+			goto finish_fragment_processing;
+		} else
+			++*extent_index;
+
+		if (state != SSDFS_LOGICAL_BLK_FREE)
+			processed_offset_ids += len;
+	};
+
+finish_fragment_processing:
+	if (portion->table->init_cno == U64_MAX ||
+	    portion->cno >= portion->table->init_cno) {
+		u16 peb_index = portion->peb_index;
+		u16 sequence_id = le16_to_cpu(portion->pot_hdr.sequence_id);
+
+		sequence = portion->table->peb[peb_index].sequence;
+
+		if (is_ssdfs_sequence_array_last_id_invalid(sequence) ||
+		    ssdfs_sequence_array_last_id(sequence) <= sequence_id) {
+			portion->table->init_cno = portion->cno;
+			portion->table->used_logical_blks =
+				le16_to_cpu(portion->pot_hdr.used_logical_blks);
+			portion->table->free_logical_blks =
+				le16_to_cpu(portion->pot_hdr.free_logical_blks);
+			portion->table->last_allocated_blk =
+				le16_to_cpu(portion->pot_hdr.last_allocated_blk);
+
+			ssdfs_sequence_array_set_last_id(sequence, sequence_id);
+		}
+	}
+
+	atomic_inc(&portion->table->peb[portion->peb_index].fragment_count);
+
+	return err;
+}
+
+/*
+ * ssdfs_define_peb_table_state() - define PEB's table state
+ * @table: pointer on translation table object
+ * @peb_index: PEB's index
+ */
+static inline
+int ssdfs_define_peb_table_state(struct ssdfs_blk2off_table *table,
+				 u16 peb_index)
+{
+	int state;
+	u16 last_allocated_blk;
+	u16 allocated_blks;
+	int init_bits;
+	int count;
+	unsigned long last_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+	BUG_ON(peb_index >= table->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	count = atomic_read(&table->peb[peb_index].fragment_count);
+	last_id = ssdfs_sequence_array_last_id(table->peb[peb_index].sequence);
+	last_allocated_blk = table->last_allocated_blk;
+
+	if (last_allocated_blk >= U16_MAX)
+		allocated_blks = 0;
+	else
+		allocated_blks = last_allocated_blk + 1;
+
+	init_bits = bitmap_weight(table->lbmap.array[SSDFS_LBMAP_INIT_INDEX],
+				  allocated_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("table %p, peb_index %u, count %d, last_id %lu, "
+		  "last_allocated_blk %u, init_bits %d, "
+		  "allocated_blks %u\n",
+		  table, peb_index, count, last_id,
+		  last_allocated_blk, init_bits,
+		  allocated_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (init_bits < 0) {
+		SSDFS_ERR("invalid init bmap: weight %d\n",
+			  init_bits);
+		return -ERANGE;
+	}
+
+	if (count == 0) {
+		SSDFS_ERR("fragment_count == 0\n");
+		return -ERANGE;
+	}
+
+	state = atomic_cmpxchg(&table->peb[peb_index].state,
+				SSDFS_BLK2OFF_TABLE_CREATED,
+				SSDFS_BLK2OFF_TABLE_PARTIAL_INIT);
+	if (state <= SSDFS_BLK2OFF_TABLE_UNDEFINED ||
+	    state > SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT) {
+		SSDFS_WARN("unexpected state %#x\n",
+			   state);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("state %#x\n", state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (init_bits > 0) {
+		if (init_bits >= allocated_blks) {
+			state = atomic_cmpxchg(&table->peb[peb_index].state,
+					SSDFS_BLK2OFF_TABLE_PARTIAL_INIT,
+					SSDFS_BLK2OFF_TABLE_COMPLETE_INIT);
+			if (state == SSDFS_BLK2OFF_TABLE_PARTIAL_INIT) {
+				/* table is completely initialized */
+				goto finish_define_peb_table_state;
+			}
+
+			state = atomic_cmpxchg(&table->peb[peb_index].state,
+					SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT,
+					SSDFS_BLK2OFF_TABLE_DIRTY);
+			if (state == SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT) {
+				/* table is dirty already */
+				goto finish_define_peb_table_state;
+			}
+
+			if (state < SSDFS_BLK2OFF_TABLE_PARTIAL_INIT ||
+			    state > SSDFS_BLK2OFF_TABLE_COMPLETE_INIT) {
+				SSDFS_WARN("unexpected state %#x\n",
+					   state);
+				return -ERANGE;
+			}
+		}
+	} else {
+		SSDFS_WARN("init_bits == 0\n");
+		return -ERANGE;
+	}
+
+finish_define_peb_table_state:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("state %#x\n", atomic_read(&table->peb[peb_index].state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_define_blk2off_table_object_state() - define table object state
+ * @table: pointer on translation table object
+ */
+static inline
+int ssdfs_define_blk2off_table_object_state(struct ssdfs_blk2off_table *table)
+{
+	int state;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = SSDFS_BLK2OFF_TABLE_STATE_MAX;
+	for (i = 0; i < table->pebs_count; i++) {
+		int peb_tbl_state = atomic_read(&table->peb[i].state);
+
+		if (peb_tbl_state < state)
+			state = peb_tbl_state;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("table %p, state %#x\n", table, state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (state) {
+	case SSDFS_BLK2OFF_TABLE_CREATED:
+		state = atomic_read(&table->state);
+		if (state != SSDFS_BLK2OFF_OBJECT_CREATED) {
+			SSDFS_WARN("unexpected state %#x\n",
+				   state);
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_BLK2OFF_TABLE_PARTIAL_INIT:
+	case SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT:
+		state = atomic_cmpxchg(&table->state,
+					SSDFS_BLK2OFF_OBJECT_CREATED,
+					SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT);
+		complete_all(&table->partial_init_end);
+
+		if (state <= SSDFS_BLK2OFF_OBJECT_UNKNOWN ||
+		    state > SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT) {
+			SSDFS_WARN("unexpected state %#x\n",
+				   state);
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_BLK2OFF_TABLE_COMPLETE_INIT:
+	case SSDFS_BLK2OFF_TABLE_DIRTY:
+		state = atomic_cmpxchg(&table->state,
+					SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT,
+					SSDFS_BLK2OFF_OBJECT_COMPLETE_INIT);
+		if (state == SSDFS_BLK2OFF_OBJECT_CREATED) {
+			state = atomic_cmpxchg(&table->state,
+					SSDFS_BLK2OFF_OBJECT_CREATED,
+					SSDFS_BLK2OFF_OBJECT_COMPLETE_INIT);
+		}
+		complete_all(&table->partial_init_end);
+		complete_all(&table->full_init_end);
+
+		if (state < SSDFS_BLK2OFF_OBJECT_CREATED ||
+		    state > SSDFS_BLK2OFF_OBJECT_COMPLETE_INIT) {
+			SSDFS_WARN("unexpected state %#x\n",
+				   state);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state %#x\n", state);
+		return -ERANGE;
+	};
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("state %#x\n", atomic_read(&table->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_blk2off_table_partial_init() - initialize PEB's table fragment
+ * @table: pointer on translation table object
+ * @blk2off_pvec: blk2off fragment
+ * @blk_desc_pvec: blk desc fragment
+ * @peb_index: PEB's index
+ * @cno: fragment's checkpoint (log's checkpoint)
+ *
+ * This method tries to initialize PEB's table fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EIO        - corrupted translation extent.
+ */
+int ssdfs_blk2off_table_partial_init(struct ssdfs_blk2off_table *table,
+				     struct pagevec *blk2off_pvec,
+				     struct pagevec *blk_desc_pvec,
+				     u16 peb_index,
+				     u64 cno)
+{
+	struct ssdfs_blk2off_init portion;
+	int extent_index = 0;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!table || !blk2off_pvec || !blk_desc_pvec);
+	BUG_ON(peb_index >= table->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("table %p, peb_index %u\n",
+		  table, peb_index);
+#else
+	SSDFS_DBG("table %p, peb_index %u\n",
+		  table, peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	memset(&portion, 0, sizeof(struct ssdfs_blk2off_init));
+
+	if (pagevec_count(blk2off_pvec) == 0) {
+		SSDFS_ERR("fail to init because of empty pagevec\n");
+		return -EINVAL;
+	}
+
+	if (ssdfs_blk2off_table_initialized(table, peb_index)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("PEB's table has been initialized already: "
+			   "peb_index %u\n",
+			   peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	portion.table = table;
+	portion.blk2off_pvec = blk2off_pvec;
+	portion.blk_desc_pvec = blk_desc_pvec;
+	portion.peb_index = peb_index;
+	portion.cno = cno;
+
+	portion.tbl_hdr_off = 0;
+	err = ssdfs_get_checked_table_header(&portion);
+	if (err) {
+		SSDFS_ERR("invalid table header\n");
+		return err;
+	}
+
+	down_write(&table->translation_lock);
+
+	portion.capacity = table->lblk2off_capacity;
+
+	err = ssdfs_blk2off_prepare_temp_bmap(&portion);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate memory\n");
+		goto unlock_translation_table;
+	}
+
+	err = ssdfs_blk2off_prepare_extent_array(&portion);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate memory\n");
+		goto unlock_translation_table;
+	}
+
+	portion.pot_hdr_off = portion.tbl_hdr_off +
+			le16_to_cpu(portion.tbl_hdr.offset_table_off);
+
+	for (i = 0; i < portion.fragments_count; i++) {
+		err = ssdfs_blk2off_fragment_init(&portion,
+						  i,
+						  &extent_index);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("continue to process extent: "
+				  "fragment %d, extent_index %d\n",
+				  i, extent_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		} else if (err == -EEXIST) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fragment has been initiliazed already: "
+				  "fragment_index %d, extent_index %d\n",
+				  i, extent_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to initialize fragment: "
+				  "fragment_index %d, extent_index %d, "
+				  "err %d\n",
+				  i, extent_index, err);
+			goto unlock_translation_table;
+		}
+	}
+
+	err = ssdfs_define_peb_table_state(table, peb_index);
+	if (err) {
+		SSDFS_ERR("fail to define PEB's table state: "
+			  "peb_index %u, err %d\n",
+			  peb_index, err);
+		goto unlock_translation_table;
+	}
+
+	err = ssdfs_define_blk2off_table_object_state(table);
+	if (err) {
+		SSDFS_ERR("fail to define table object state: "
+			  "err %d\n",
+			  err);
+		goto unlock_translation_table;
+	}
+
+unlock_translation_table:
+	up_write(&table->translation_lock);
+
+	ssdfs_blk2off_kvfree(portion.bmap);
+	portion.bmap = NULL;
+	ssdfs_blk2off_kfree(portion.extent_array);
+	portion.extent_array = NULL;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
diff --git a/fs/ssdfs/offset_translation_table.h b/fs/ssdfs/offset_translation_table.h
new file mode 100644
index 000000000000..a999531dae59
--- /dev/null
+++ b/fs/ssdfs/offset_translation_table.h
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/offset_translation_table.h - offset table declarations.
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
+#ifndef _SSDFS_OFFSET_TRANSLATION_TABLE_H
+#define _SSDFS_OFFSET_TRANSLATION_TABLE_H
+
+#include <linux/pagevec.h>
+
+#include "request_queue.h"
+#include "sequence_array.h"
+#include "dynamic_array.h"
+
+/*
+ * struct ssdfs_phys_offset_table_fragment - fragment of phys offsets table
+ * @lock: table fragment lock
+ * @start_id: starting physical offset id number in fragment
+ * @sequence_id: fragment's sequence_id in PEB
+ * @id_count: count of id numbers in sequence
+ * @state: fragment state
+ * @hdr: pointer on fragment's header
+ * @phys_offs: array of physical offsets in fragment
+ * @buf: buffer of fragment
+ * @buf_size: size of buffer in bytes
+ *
+ * One fragment can be used for one PEB's log. But one log can contain
+ * several fragments too. In memory exists the same count of fragments
+ * as on volume.
+ */
+struct ssdfs_phys_offset_table_fragment {
+	struct rw_semaphore lock;
+	u16 start_id;
+	u16 sequence_id;
+	atomic_t id_count;
+	atomic_t state;
+
+	struct ssdfs_phys_offset_table_header *hdr;
+	struct ssdfs_phys_offset_descriptor *phys_offs;
+	unsigned char *buf;
+	size_t buf_size;
+};
+
+enum {
+	SSDFS_BLK2OFF_FRAG_UNDEFINED,
+	SSDFS_BLK2OFF_FRAG_CREATED,
+	SSDFS_BLK2OFF_FRAG_INITIALIZED,
+	SSDFS_BLK2OFF_FRAG_DIRTY,
+	SSDFS_BLK2OFF_FRAG_UNDER_COMMIT,
+	SSDFS_BLK2OFF_FRAG_COMMITED,
+	SSDFS_BLK2OFF_FRAG_STATE_MAX,
+};
+
+#define SSDFS_INVALID_FRAG_ID			U16_MAX
+#define SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD	(U16_MAX - 1)
+
+/*
+ * struct ssdfs_phys_offset_table_array - array of log's fragments in PEB
+ * @state: PEB's translation table state
+ * @fragment_count: fragments count
+ * @array: array of fragments
+ */
+struct ssdfs_phys_offset_table_array {
+	atomic_t state;
+	atomic_t fragment_count;
+	struct ssdfs_sequence_array *sequence;
+};
+
+enum {
+	SSDFS_BLK2OFF_TABLE_UNDEFINED,
+	SSDFS_BLK2OFF_TABLE_CREATED,
+	SSDFS_BLK2OFF_TABLE_PARTIAL_INIT,
+	SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT,
+	SSDFS_BLK2OFF_TABLE_COMPLETE_INIT,
+	SSDFS_BLK2OFF_TABLE_DIRTY,
+	SSDFS_BLK2OFF_TABLE_STATE_MAX,
+};
+
+#define SSDFS_BLK2OFF_TABLE_INVALID_ID		U16_MAX
+
+/*
+ * struct ssdfs_block_descriptor_state - block descriptor state
+ * @status: state of block descriptor buffer
+ * @buf: block descriptor buffer
+ */
+struct ssdfs_block_descriptor_state {
+	u32 status;
+	struct ssdfs_block_descriptor buf;
+};
+
+/*
+ * Block descriptor buffer state
+ */
+enum {
+	SSDFS_BLK_DESC_BUF_UNKNOWN_STATE,
+	SSDFS_BLK_DESC_BUF_INITIALIZED,
+	SSDFS_BLK_DESC_BUF_STATE_MAX,
+	SSDFS_BLK_DESC_BUF_ALLOCATED = U32_MAX,
+};
+
+/*
+ * struct ssdfs_offset_position - defines offset id and position
+ * @cno: checkpoint of change
+ * @id: physical offset ID
+ * @peb_index: PEB's index
+ * @sequence_id: sequence ID of physical offset table's fragment
+ * @offset_index: offset index inside of fragment
+ * @blk_desc: logical block descriptor
+ */
+struct ssdfs_offset_position {
+	u64 cno;
+	u16 id;
+	u16 peb_index;
+	u16 sequence_id;
+	u16 offset_index;
+
+	struct ssdfs_block_descriptor_state blk_desc;
+};
+
+/*
+ * struct ssdfs_migrating_block - migrating block state
+ * @state: logical block's state
+ * @peb_index: PEB's index
+ * @pvec: copy of logical block's content (under migration only)
+ */
+struct ssdfs_migrating_block {
+	int state;
+	u16 peb_index;
+	struct pagevec pvec;
+};
+
+/*
+ * Migrating block's states
+ */
+enum {
+	SSDFS_LBLOCK_UNKNOWN_STATE,
+	SSDFS_LBLOCK_UNDER_MIGRATION,
+	SSDFS_LBLOCK_UNDER_COMMIT,
+	SSDFS_LBLOCK_STATE_MAX
+};
+
+enum {
+	SSDFS_LBMAP_INIT_INDEX,
+	SSDFS_LBMAP_STATE_INDEX,
+	SSDFS_LBMAP_MODIFICATION_INDEX,
+	SSDFS_LBMAP_ARRAY_MAX,
+};
+
+
+/*
+ * struct ssdfs_bitmap_array - bitmap array
+ * @bits_count: number of available bits in every bitmap
+ * @bytes_count: number of allocated bytes in every bitmap
+ * @array: array of bitmaps
+ */
+struct ssdfs_bitmap_array {
+	u32 bits_count;
+	u32 bytes_count;
+	unsigned long *array[SSDFS_LBMAP_ARRAY_MAX];
+};
+
+/*
+ * struct ssdfs_blk2off_table - in-core translation table
+ * @flags: flags of translation table
+ * @state: translation table object state
+ * @pages_per_peb: pages per physical erase block
+ * @pages_per_seg: pages per segment
+ * @type: translation table type
+ * @translation_lock: lock of translation operation
+ * @init_cno: last actual checkpoint
+ * @used_logical_blks: count of used logical blocks
+ * @free_logical_blks: count of free logical blocks
+ * @last_allocated_blk: last allocated block (hint for allocation)
+ * @lbmap: array of block bitmaps
+ * @lblk2off: array of correspondence between logical numbers and phys off ids
+ * @migrating_blks: array of migrating blocks
+ * @lblk2off_capacity: capacity of correspondence array
+ * @peb: sequence of physical offset arrays
+ * @pebs_count: count of PEBs in segment
+ * @partial_init_end: wait of partial init ending
+ * @full_init_end: wait of full init ending
+ * @wait_queue: wait queue of blk2off table
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_blk2off_table {
+	atomic_t flags;
+	atomic_t state;
+
+	u32 pages_per_peb;
+	u32 pages_per_seg;
+	u8 type;
+
+	struct rw_semaphore translation_lock;
+	u64 init_cno;
+	u16 used_logical_blks;
+	u16 free_logical_blks;
+	u16 last_allocated_blk;
+	struct ssdfs_bitmap_array lbmap;
+	struct ssdfs_dynamic_array lblk2off;
+	struct ssdfs_dynamic_array migrating_blks;
+	u16 lblk2off_capacity;
+
+	struct ssdfs_phys_offset_table_array *peb;
+	u16 pebs_count;
+
+	struct completion partial_init_end;
+	struct completion full_init_end;
+	wait_queue_head_t wait_queue;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+#define SSDFS_OFF_POS(ptr) \
+	((struct ssdfs_offset_position *)(ptr))
+#define SSDFS_MIGRATING_BLK(ptr) \
+	((struct ssdfs_migrating_block *)(ptr))
+
+enum {
+	SSDFS_BLK2OFF_OBJECT_UNKNOWN,
+	SSDFS_BLK2OFF_OBJECT_CREATED,
+	SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT,
+	SSDFS_BLK2OFF_OBJECT_COMPLETE_INIT,
+	SSDFS_BLK2OFF_OBJECT_STATE_MAX,
+};
+
+/*
+ * struct ssdfs_blk2off_table_snapshot - table state snapshot
+ * @cno: checkpoint of snapshot
+ * @bmap_copy: copy of modification bitmap
+ * @tbl_copy: copy of translation table
+ * @capacity: capacity of table
+ * @used_logical_blks: count of used logical blocks
+ * @free_logical_blks: count of free logical blocks
+ * @last_allocated_blk: last allocated block (hint for allocation)
+ * @peb_index: PEB index
+ * @start_sequence_id: sequence ID of the first dirty fragment
+ * @dirty_fragments: count of dirty fragments
+ * @fragments_count: total count of fragments
+ *
+ * The @bmap_copy and @tbl_copy are allocated during getting
+ * snapshot inside of called function. Freeing of allocated
+ * memory SHOULD BE MADE by caller.
+ */
+struct ssdfs_blk2off_table_snapshot {
+	u64 cno;
+
+	unsigned long *bmap_copy;
+	struct ssdfs_offset_position *tbl_copy;
+	u16 capacity;
+
+	u16 used_logical_blks;
+	u16 free_logical_blks;
+	u16 last_allocated_blk;
+
+	u16 peb_index;
+	u16 start_sequence_id;
+	u16 dirty_fragments;
+	u32 fragments_count;
+};
+
+/*
+ * struct ssdfs_blk2off_range - extent of logical blocks
+ * @start_lblk: start logical block number
+ * @len: count of logical blocks in extent
+ */
+struct ssdfs_blk2off_range {
+	u16 start_lblk;
+	u16 len;
+};
+
+/*
+ * Inline functions
+ */
+
+/*
+ * ssdfs_blk2off_table_bmap_bytes() - calculate bmap bytes count
+ * @items_count: bits count in bitmap
+ */
+static inline
+size_t ssdfs_blk2off_table_bmap_bytes(size_t items_count)
+{
+	size_t bytes;
+
+	bytes = (items_count + BITS_PER_LONG - 1) / BITS_PER_BYTE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %zu, bmap_bytes %zu\n",
+		  items_count, bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return bytes;
+}
+
+static inline
+bool is_ssdfs_logical_block_migrating(int blk_state)
+{
+	bool is_migrating = false;
+
+	switch (blk_state) {
+	case SSDFS_LBLOCK_UNDER_MIGRATION:
+	case SSDFS_LBLOCK_UNDER_COMMIT:
+		is_migrating = true;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return is_migrating;
+}
+
+/* Function prototypes */
+struct ssdfs_blk2off_table *
+ssdfs_blk2off_table_create(struct ssdfs_fs_info *fsi,
+			   u16 items_count, u8 type,
+			   int state);
+void ssdfs_blk2off_table_destroy(struct ssdfs_blk2off_table *table);
+int ssdfs_blk2off_table_partial_init(struct ssdfs_blk2off_table *table,
+				     struct pagevec *blk2off_pvec,
+				     struct pagevec *blk2_desc_pvec,
+				     u16 peb_index,
+				     u64 cno);
+int ssdfs_blk2off_table_blk_desc_init(struct ssdfs_blk2off_table *table,
+					u16 logical_blk,
+					struct ssdfs_offset_position *pos);
+int ssdfs_blk2off_table_resize(struct ssdfs_blk2off_table *table,
+				u16 new_items_count);
+int ssdfs_blk2off_table_snapshot(struct ssdfs_blk2off_table *table,
+				 u16 peb_index,
+				 struct ssdfs_blk2off_table_snapshot *snapshot);
+void ssdfs_blk2off_table_free_snapshot(struct ssdfs_blk2off_table_snapshot *sp);
+int ssdfs_blk2off_table_extract_extents(struct ssdfs_blk2off_table_snapshot *sp,
+					struct ssdfs_translation_extent *array,
+					u16 capacity,
+					u16 *extent_count);
+int ssdfs_blk2off_table_prepare_for_commit(struct ssdfs_blk2off_table *table,
+				    u16 peb_index, u16 sequence_id,
+				    u32 *offset_table_off,
+				    struct ssdfs_blk2off_table_snapshot *sp);
+int ssdfs_peb_store_offsets_table_header(struct ssdfs_peb_info *pebi,
+					 struct ssdfs_blk2off_table_header *hdr,
+					 pgoff_t *cur_page,
+					 u32 *write_offset);
+int
+ssdfs_peb_store_offsets_table_extents(struct ssdfs_peb_info *pebi,
+				      struct ssdfs_translation_extent *array,
+				      u16 extent_count,
+				      pgoff_t *cur_page,
+				      u32 *write_offset);
+int ssdfs_peb_store_offsets_table_fragment(struct ssdfs_peb_info *pebi,
+					   struct ssdfs_blk2off_table *table,
+					   u16 peb_index, u16 sequence_id,
+					   pgoff_t *cur_page,
+					   u32 *write_offset);
+int ssdfs_peb_store_offsets_table(struct ssdfs_peb_info *pebi,
+				  struct ssdfs_metadata_descriptor *desc,
+				  pgoff_t *cur_page,
+				  u32 *write_offset);
+int
+ssdfs_blk2off_table_forget_snapshot(struct ssdfs_blk2off_table *table,
+				    struct ssdfs_blk2off_table_snapshot *sp,
+				    struct ssdfs_translation_extent *array,
+				    u16 extent_count);
+
+bool ssdfs_blk2off_table_dirtied(struct ssdfs_blk2off_table *table,
+				 u16 peb_index);
+bool ssdfs_blk2off_table_initialized(struct ssdfs_blk2off_table *table,
+				     u16 peb_index);
+
+int ssdfs_blk2off_table_get_used_logical_blks(struct ssdfs_blk2off_table *tbl,
+						u16 *used_blks);
+int ssdfs_blk2off_table_get_offset_position(struct ssdfs_blk2off_table *table,
+					    u16 logical_blk,
+					    struct ssdfs_offset_position *pos);
+struct ssdfs_phys_offset_descriptor *
+ssdfs_blk2off_table_convert(struct ssdfs_blk2off_table *table,
+			    u16 logical_blk, u16 *peb_index,
+			    int *migration_state,
+			    struct ssdfs_offset_position *pos);
+int ssdfs_blk2off_table_allocate_block(struct ssdfs_blk2off_table *table,
+					u16 *logical_blk);
+int ssdfs_blk2off_table_allocate_extent(struct ssdfs_blk2off_table *table,
+					u16 len,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_blk2off_table_change_offset(struct ssdfs_blk2off_table *table,
+				      u16 logical_blk,
+				      u16 peb_index,
+				      struct ssdfs_block_descriptor *blk_desc,
+				      struct ssdfs_phys_offset_descriptor *off);
+int ssdfs_blk2off_table_free_block(struct ssdfs_blk2off_table *table,
+				   u16 peb_index, u16 logical_blk);
+int ssdfs_blk2off_table_free_extent(struct ssdfs_blk2off_table *table,
+				    u16 peb_index,
+				    struct ssdfs_blk2off_range *extent);
+
+int ssdfs_blk2off_table_get_block_migration(struct ssdfs_blk2off_table *table,
+					    u16 logical_blk,
+					    u16 peb_index);
+int ssdfs_blk2off_table_set_block_migration(struct ssdfs_blk2off_table *table,
+					    u16 logical_blk,
+					    u16 peb_index,
+					    struct ssdfs_segment_request *req);
+int ssdfs_blk2off_table_get_block_state(struct ssdfs_blk2off_table *table,
+					struct ssdfs_segment_request *req);
+int ssdfs_blk2off_table_update_block_state(struct ssdfs_blk2off_table *table,
+					   struct ssdfs_segment_request *req);
+int ssdfs_blk2off_table_set_block_commit(struct ssdfs_blk2off_table *table,
+					 u16 logical_blk,
+					 u16 peb_index);
+int ssdfs_blk2off_table_revert_migration_state(struct ssdfs_blk2off_table *tbl,
+						u16 peb_index);
+
+#ifdef CONFIG_SSDFS_TESTING
+int ssdfs_blk2off_table_fragment_set_clean(struct ssdfs_blk2off_table *table,
+					   u16 peb_index, u16 sequence_id);
+#else
+static inline
+int ssdfs_blk2off_table_fragment_set_clean(struct ssdfs_blk2off_table *table,
+					   u16 peb_index, u16 sequence_id)
+{
+	SSDFS_ERR("set fragment clean is not supported\n");
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_SSDFS_TESTING */
+
+#endif /* _SSDFS_OFFSET_TRANSLATION_TABLE_H */
-- 
2.34.1


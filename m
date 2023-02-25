Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535B26A2630
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBYBQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBYBQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:27 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA7312864
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:07 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bl7so858685oib.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eI+flnUK3bNkddtmqhNy5+pOxr2iizZbF1weqywGzc=;
        b=U0/He9X0tTdwHSYp2/QXT6L2aH9QXHHviFoYDBwPpQtcLWCES+fns0nOrLqgSIFh7+
         A70OD+SspO+L/l4UCya3PJDVV9qCAYemA7MXahQGi8AkHMyQtqhz4OSl/IU5oCG2fGFL
         nAQGg8lkm3fldOYkGIt6K2WbZzrhx3LZ2wGwtCa6KMnp7yvjUPuy3ct1QVPlHbKIcFRZ
         xer80X4BXr2JjY2XTAYrtIUNT3sPj+oOJNHRxdod68brqF3Hjgiy+bMXXPEJ7y/Yj3Yh
         AAUBMOKaz5tJ09qB1dsnlkqmyzY4xNZmHN7Y3+TZgme+cnsVcoDAX9DCXlSdZgTfD0eR
         4dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eI+flnUK3bNkddtmqhNy5+pOxr2iizZbF1weqywGzc=;
        b=yE1pHQ+l6IxukcQG+rX9MbATsPhClAlJV+MMXPHP/qDLhGp1GrLTZqYcAhPkxs3R8N
         3sX3kanWbzFhS7KV817G9ybUxrNHDhQNqz8oKI2gtQp6gW0An0itN1VaSyG23oa0SOgy
         8Sa4OEEv52acgiN+d0N1QQb2SKnGGzUNtuF+v7qbwHCjPb5u+wREaupZWEk+u66zsUZG
         N5Nu11bOIiITGsv+G5I1zcOs/2jiLwZ0eQk9DxFVpyhorYtjvbhW0s08GrLPGyIBFYAO
         b+lj6IU6vq1vObQ9eP1/jr4Tzz1Th9rR8typKca3CWnZBcqKwwg3w77/w2JQgeSrCNBx
         AgVw==
X-Gm-Message-State: AO0yUKXBHPxWAIQ8BZGkf0fLlk0JhGruhOSJ6BZwoetvi2JvPQENmsN+
        XQDbq/I4/KNn9NYWxWG5Bsg0YHt0QRageINY
X-Google-Smtp-Source: AK7set9BOCIPuereytrinA2daM3oM9LMDNbHc2Awp0UaQ0hHU+4p89YBSxy2HcQYpiXJ4CYZNvb/1g==
X-Received: by 2002:a05:6808:3093:b0:383:9108:5b13 with SMTP id bl19-20020a056808309300b0038391085b13mr990760oib.1.1677287766158;
        Fri, 24 Feb 2023 17:16:06 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:05 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 15/76] ssdfs: introduce segment block bitmap
Date:   Fri, 24 Feb 2023 17:08:26 -0800
Message-Id: <20230225010927.813929-16-slava@dubeyko.com>
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
Block (PEB). PEB block bitmap object represents the aggregation
of source PEB's block bitmap and destination PEB's block bitmap.
Finally, segment block bitmap implements an array of PEB block
bitmaps. Segment block bitmap has API:
(1) create - create segment block bitmap
(2) destroy - destroy segment block bitmap
(3) partial_init - initialize by state of one PEB block bitmap
(4) get_free_pages - get free pages in segment block bitmap
(5) get_used_pages - get used pages in segment block bitmap
(6) get_invalid_pages - get invalid pages in segment block bitmap
(7) reserve_block - reserve a free block
(8) reserved_extent - reserve some number of free blocks
(9) pre_allocate - pre_allocate page/range in segment block bitmap
(10) allocate - allocate page/range in segment block bitmap
(11) update_range - change the state of range in segment block bitmap

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/segment_block_bitmap.c | 1425 +++++++++++++++++++++++++++++++
 fs/ssdfs/segment_block_bitmap.h |  205 +++++
 2 files changed, 1630 insertions(+)
 create mode 100644 fs/ssdfs/segment_block_bitmap.c
 create mode 100644 fs/ssdfs/segment_block_bitmap.h

diff --git a/fs/ssdfs/segment_block_bitmap.c b/fs/ssdfs/segment_block_bitmap.c
new file mode 100644
index 000000000000..824c3d4fd31d
--- /dev/null
+++ b/fs/ssdfs/segment_block_bitmap.c
@@ -0,0 +1,1425 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment_block_bitmap.c - segment's block bitmap implementation.
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
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "page_vector.h"
+#include "peb_block_bitmap.h"
+#include "segment_block_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "peb_container.h"
+#include "segment_bitmap.h"
+#include "page_array.h"
+#include "segment.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_seg_blk_page_leaks;
+atomic64_t ssdfs_seg_blk_memory_leaks;
+atomic64_t ssdfs_seg_blk_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_seg_blk_cache_leaks_increment(void *kaddr)
+ * void ssdfs_seg_blk_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_seg_blk_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_seg_blk_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_seg_blk_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_seg_blk_kfree(void *kaddr)
+ * struct page *ssdfs_seg_blk_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_seg_blk_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_seg_blk_free_page(struct page *page)
+ * void ssdfs_seg_blk_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(seg_blk)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(seg_blk)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_seg_blk_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_seg_blk_page_leaks, 0);
+	atomic64_set(&ssdfs_seg_blk_memory_leaks, 0);
+	atomic64_set(&ssdfs_seg_blk_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_seg_blk_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_seg_blk_page_leaks) != 0) {
+		SSDFS_ERR("SEGMENT BLOCK BITMAP: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_seg_blk_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_seg_blk_memory_leaks) != 0) {
+		SSDFS_ERR("SEGMENT BLOCK BITMAP: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_seg_blk_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_seg_blk_cache_leaks) != 0) {
+		SSDFS_ERR("SEGMENT BLOCK BITMAP: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_seg_blk_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+#define SSDFS_SEG_BLK_BMAP_STATE_FNS(value, name)			\
+static inline								\
+bool is_seg_block_bmap_##name(struct ssdfs_segment_blk_bmap *bmap)	\
+{									\
+	return atomic_read(&bmap->state) == SSDFS_SEG_BLK_BMAP_##value;	\
+}									\
+static inline								\
+void set_seg_block_bmap_##name(struct ssdfs_segment_blk_bmap *bmap)	\
+{									\
+	atomic_set(&bmap->state, SSDFS_SEG_BLK_BMAP_##value);		\
+}									\
+
+/*
+ * is_seg_block_bmap_created()
+ * set_seg_block_bmap_created()
+ */
+SSDFS_SEG_BLK_BMAP_STATE_FNS(CREATED, created)
+
+/*
+ * ssdfs_segment_blk_bmap_create() - create segment block bitmap
+ * @si: segment object
+ * @init_flag: definition of block bitmap's creation state
+ * @init_state: block state is used during initialization
+ *
+ * This method tries to create segment block bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_blk_bmap_create(struct ssdfs_segment_info *si,
+				  int init_flag, int init_state)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_blk_bmap *bmap;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !si->fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("si %p, seg_id %llu, "
+		  "init_flag %#x, init_state %#x\n",
+		  si, si->seg_id,
+		  init_flag, init_state);
+#else
+	SSDFS_DBG("si %p, seg_id %llu, "
+		  "init_flag %#x, init_state %#x\n",
+		  si, si->seg_id,
+		  init_flag, init_state);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = si->fsi;
+	bmap = &si->blk_bmap;
+
+	bmap->parent_si = si;
+	atomic_set(&bmap->state, SSDFS_SEG_BLK_BMAP_STATE_UNKNOWN);
+
+	bmap->pages_per_peb = fsi->pages_per_peb;
+	bmap->pages_per_seg = fsi->pages_per_seg;
+
+	init_rwsem(&bmap->modification_lock);
+	atomic_set(&bmap->seg_valid_blks, 0);
+	atomic_set(&bmap->seg_invalid_blks, 0);
+	atomic_set(&bmap->seg_free_blks, 0);
+
+	bmap->pebs_count = si->pebs_count;
+
+	bmap->peb = ssdfs_seg_blk_kcalloc(bmap->pebs_count,
+				  sizeof(struct ssdfs_peb_blk_bmap),
+				  GFP_KERNEL);
+	if (!bmap->peb) {
+		SSDFS_ERR("fail to allocate PEBs' block bitmaps\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < bmap->pebs_count; i++) {
+		err = ssdfs_peb_blk_bmap_create(bmap, i, fsi->pages_per_peb,
+						init_flag, init_state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create PEB's block bitmap: "
+				  "peb_index %u, err %d\n",
+				  i, err);
+			goto fail_create_seg_blk_bmap;
+		}
+	}
+
+	set_seg_block_bmap_created(bmap);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+fail_create_seg_blk_bmap:
+	ssdfs_segment_blk_bmap_destroy(bmap);
+	return err;
+}
+
+/*
+ * ssdfs_segment_blk_bmap_destroy() - destroy segment block bitmap
+ * @ptr: segment block bitmap pointer
+ */
+void ssdfs_segment_blk_bmap_destroy(struct ssdfs_segment_blk_bmap *ptr)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ptr->parent_si) {
+		/* object is not created yet */
+		return;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, state %#x\n",
+		  ptr->parent_si->seg_id,
+		  atomic_read(&ptr->state));
+#else
+	SSDFS_DBG("seg_id %llu, state %#x\n",
+		  ptr->parent_si->seg_id,
+		  atomic_read(&ptr->state));
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	atomic_set(&ptr->seg_valid_blks, 0);
+	atomic_set(&ptr->seg_invalid_blks, 0);
+	atomic_set(&ptr->seg_free_blks, 0);
+
+	for (i = 0; i < ptr->pebs_count; i++)
+		ssdfs_peb_blk_bmap_destroy(&ptr->peb[i]);
+
+	ssdfs_seg_blk_kfree(ptr->peb);
+	ptr->peb = NULL;
+
+	atomic_set(&ptr->state, SSDFS_SEG_BLK_BMAP_STATE_UNKNOWN);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * ssdfs_segment_blk_bmap_partial_init() - partial init of segment bitmap
+ * @bmap: pointer on segment block bitmap
+ * @peb_index: PEB's index
+ * @source: pointer on pagevec with bitmap state
+ * @hdr: header of block bitmap fragment
+ * @cno: log's checkpoint
+ */
+int ssdfs_segment_blk_bmap_partial_init(struct ssdfs_segment_blk_bmap *bmap,
+					u16 peb_index,
+					struct ssdfs_page_vector *source,
+					struct ssdfs_block_bitmap_fragment *hdr,
+					u64 cno)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !bmap->peb || !bmap->parent_si);
+	BUG_ON(!source || !hdr);
+	BUG_ON(ssdfs_page_vector_count(source) == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u, cno %llu\n",
+		  bmap->parent_si->seg_id, peb_index, cno);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u, cno %llu\n",
+		  bmap->parent_si->seg_id, peb_index, cno);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (atomic_read(&bmap->state) != SSDFS_SEG_BLK_BMAP_CREATED) {
+		SSDFS_ERR("invalid segment block bitmap state %#x\n",
+			  atomic_read(&bmap->state));
+		return -ERANGE;
+	}
+
+	if (peb_index >= bmap->pebs_count) {
+		SSDFS_ERR("peb_index %u >= seg_blkbmap->pebs_count %u\n",
+			  peb_index, bmap->pebs_count);
+		return -ERANGE;
+	}
+
+	err = ssdfs_peb_blk_bmap_init(&bmap->peb[peb_index],
+					source, hdr, cno);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: err %d\n", err);
+#else
+	SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_blk_bmap_init_failed() - process failure of segment bitmap init
+ * @bmap: pointer on segment block bitmap
+ * @peb_index: PEB's index
+ */
+void ssdfs_segment_blk_bmap_init_failed(struct ssdfs_segment_blk_bmap *bmap,
+					u16 peb_index)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !bmap->peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (peb_index >= bmap->pebs_count) {
+		SSDFS_WARN("peb_index %u >= seg_blkbmap->pebs_count %u\n",
+			  peb_index, bmap->pebs_count);
+		return;
+	}
+
+	ssdfs_peb_blk_bmap_init_failed(&bmap->peb[peb_index]);
+}
+
+/*
+ * is_ssdfs_segment_blk_bmap_dirty() - check that PEB block bitmap is dirty
+ * @bmap: pointer on segment block bitmap
+ * @peb_index: PEB's index
+ */
+bool is_ssdfs_segment_blk_bmap_dirty(struct ssdfs_segment_blk_bmap *bmap,
+					u16 peb_index)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !bmap->peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (peb_index >= bmap->pebs_count) {
+		SSDFS_WARN("peb_index %u >= seg_blkbmap->pebs_count %u\n",
+			  peb_index, bmap->pebs_count);
+		return false;
+	}
+
+	return is_ssdfs_peb_blk_bmap_dirty(&bmap->peb[peb_index]);
+}
+
+/*
+ * ssdfs_define_bmap_index() - define block bitmap for operation
+ * @pebc: pointer on PEB container
+ * @bmap_index: pointer on block bitmap index value [out]
+ * @peb_index: pointer on PEB's index [out]
+ *
+ * This method tries to define bitmap index and PEB's index
+ * for operation with block bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_define_bmap_index(struct ssdfs_peb_container *pebc,
+			    int *bmap_index, u16 *peb_index)
+{
+	struct ssdfs_segment_info *si;
+	int migration_state, items_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+	BUG_ON(!bmap_index || !peb_index);
+	BUG_ON(!rwsem_is_locked(&pebc->lock));
+	BUG_ON(!mutex_is_locked(&pebc->migration_lock));
+
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+	*bmap_index = -1;
+	*peb_index = U16_MAX;
+
+try_define_bmap_index:
+	migration_state = atomic_read(&pebc->migration_state);
+	items_state = atomic_read(&pebc->items_state);
+	switch (migration_state) {
+	case SSDFS_PEB_NOT_MIGRATING:
+		*bmap_index = SSDFS_PEB_BLK_BMAP_SOURCE;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!pebc->src_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		*peb_index = pebc->src_peb->peb_index;
+		break;
+
+	case SSDFS_PEB_UNDER_MIGRATION:
+		switch (items_state) {
+		case SSDFS_PEB1_DST_CONTAINER:
+		case SSDFS_PEB2_DST_CONTAINER:
+		case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+		case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+			*bmap_index = SSDFS_PEB_BLK_BMAP_SOURCE;
+			break;
+
+		case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+		case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+			switch (atomic_read(&pebc->migration_phase)) {
+			case SSDFS_SRC_PEB_NOT_EXHAUSTED:
+				*bmap_index = SSDFS_PEB_BLK_BMAP_SOURCE;
+				break;
+
+			default:
+				*bmap_index = SSDFS_PEB_BLK_BMAP_DESTINATION;
+				break;
+			}
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_WARN("invalid items_state %#x\n",
+				   items_state);
+			goto finish_define_bmap_index;
+		};
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!pebc->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		*peb_index = pebc->dst_peb->peb_index;
+		break;
+
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_FINISHING_MIGRATION:
+#ifdef CONFIG_SSDFS_DEBUG
+		/* unexpected situation */
+		SSDFS_WARN("unexpected situation\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = -EAGAIN;
+		goto finish_define_bmap_index;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid migration_state %#x\n",
+			   migration_state);
+		goto finish_define_bmap_index;
+	}
+
+finish_define_bmap_index:
+	if (err == -EAGAIN) {
+		DEFINE_WAIT(wait);
+
+		err = 0;
+
+		mutex_unlock(&pebc->migration_lock);
+		up_read(&pebc->lock);
+		prepare_to_wait(&pebc->migration_wq, &wait,
+				TASK_UNINTERRUPTIBLE);
+		schedule();
+		finish_wait(&pebc->migration_wq, &wait);
+		down_read(&pebc->lock);
+		mutex_lock(&pebc->migration_lock);
+		goto try_define_bmap_index;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to define bmap_index: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index, err);
+		return err;
+	}
+
+	return 0;
+}
+
+bool has_ssdfs_segment_blk_bmap_initialized(struct ssdfs_segment_blk_bmap *ptr,
+					    struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	u16 peb_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->peb || !ptr->parent_si || !pebc);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  ptr->parent_si->seg_id,
+		  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_read(&ptr->state) != SSDFS_SEG_BLK_BMAP_CREATED) {
+		SSDFS_ERR("invalid segment block bitmap state %#x\n",
+			  atomic_read(&ptr->state));
+		return false;
+	}
+
+	down_read(&pebc->lock);
+	if (pebc->dst_peb)
+		peb_index = pebc->dst_peb->peb_index;
+	else
+		peb_index = pebc->src_peb->peb_index;
+	up_read(&pebc->lock);
+
+	if (peb_index >= ptr->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  peb_index, ptr->pebs_count);
+		return false;
+	}
+
+	peb_blkbmap = &ptr->peb[peb_index];
+
+	return has_ssdfs_peb_blk_bmap_initialized(peb_blkbmap);
+}
+
+int ssdfs_segment_blk_bmap_wait_init_end(struct ssdfs_segment_blk_bmap *ptr,
+					 struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	u16 peb_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->peb || !ptr->parent_si || !pebc);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  ptr->parent_si->seg_id,
+		  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_read(&ptr->state) != SSDFS_SEG_BLK_BMAP_CREATED) {
+		SSDFS_ERR("invalid segment block bitmap state %#x\n",
+			  atomic_read(&ptr->state));
+		return -ERANGE;
+	}
+
+	down_read(&pebc->lock);
+	if (pebc->dst_peb)
+		peb_index = pebc->dst_peb->peb_index;
+	else
+		peb_index = pebc->src_peb->peb_index;
+	up_read(&pebc->lock);
+
+	if (peb_index >= ptr->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  peb_index, ptr->pebs_count);
+		return -ERANGE;
+	}
+
+	peb_blkbmap = &ptr->peb[peb_index];
+
+	return ssdfs_peb_blk_bmap_wait_init_end(peb_blkbmap);
+}
+
+/*
+ * ssdfs_segment_blk_bmap_reserve_metapages() - reserve metapages
+ * @ptr: segment block bitmap object
+ * @pebc: pointer on PEB container
+ * @count: amount of metadata pages for reservation
+ *
+ * This method tries to reserve @count metadata pages into
+ * block bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_blk_bmap_reserve_metapages(struct ssdfs_segment_blk_bmap *ptr,
+					     struct ssdfs_peb_container *pebc,
+					     u32 count)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	int bmap_index = SSDFS_PEB_BLK_BMAP_INDEX_MAX;
+	u16 peb_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->peb || !ptr->parent_si || !pebc);
+	BUG_ON(!rwsem_is_locked(&pebc->lock));
+
+	SSDFS_DBG("seg_id %llu, peb_index %u, count %u\n",
+		  ptr->parent_si->seg_id,
+		  pebc->peb_index, count);
+	SSDFS_DBG("free_logical_blks %d, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, pages_per_seg %u\n",
+		  atomic_read(&ptr->seg_free_blks),
+		  atomic_read(&ptr->seg_valid_blks),
+		  atomic_read(&ptr->seg_invalid_blks),
+		  ptr->pages_per_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_read(&ptr->state) != SSDFS_SEG_BLK_BMAP_CREATED) {
+		SSDFS_ERR("invalid segment block bitmap state %#x\n",
+			  atomic_read(&ptr->state));
+		return -ERANGE;
+	}
+
+	err = ssdfs_define_bmap_index(pebc, &bmap_index, &peb_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define bmap_index: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  ptr->parent_si->seg_id,
+			  pebc->peb_index, err);
+		return err;
+	}
+
+	if (peb_index >= ptr->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  peb_index, ptr->pebs_count);
+		return -ERANGE;
+	}
+
+	peb_blkbmap = &ptr->peb[peb_index];
+
+	return ssdfs_peb_blk_bmap_reserve_metapages(peb_blkbmap,
+						    bmap_index,
+						    count);
+}
+
+/*
+ * ssdfs_segment_blk_bmap_free_metapages() - free metapages
+ * @ptr: segment block bitmap object
+ * @pebc: pointer on PEB container
+ * @count: amount of metadata pages for freeing
+ *
+ * This method tries to free @count metadata pages into
+ * block bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_blk_bmap_free_metapages(struct ssdfs_segment_blk_bmap *ptr,
+					  struct ssdfs_peb_container *pebc,
+					  u32 count)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	int bmap_index = SSDFS_PEB_BLK_BMAP_INDEX_MAX;
+	u16 peb_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->peb || !ptr->parent_si || !pebc);
+	BUG_ON(!rwsem_is_locked(&pebc->lock));
+
+	SSDFS_DBG("seg_id %llu, peb_index %u, count %u\n",
+		  ptr->parent_si->seg_id,
+		  pebc->peb_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_read(&ptr->state) != SSDFS_SEG_BLK_BMAP_CREATED) {
+		SSDFS_ERR("invalid segment block bitmap state %#x\n",
+			  atomic_read(&ptr->state));
+		return -ERANGE;
+	}
+
+	err = ssdfs_define_bmap_index(pebc, &bmap_index, &peb_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define bmap_index: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  ptr->parent_si->seg_id,
+			  pebc->peb_index, err);
+		return err;
+	}
+
+	if (peb_index >= ptr->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  peb_index, ptr->pebs_count);
+		return -ERANGE;
+	}
+
+	peb_blkbmap = &ptr->peb[peb_index];
+
+	return ssdfs_peb_blk_bmap_free_metapages(peb_blkbmap,
+						 bmap_index,
+						 count);
+}
+
+/*
+ * ssdfs_segment_blk_bmap_reserve_extent() - reserve free extent
+ * @ptr: segment block bitmap object
+ * @count: number of logical blocks
+ *
+ * This function tries to reserve some number of free blocks.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-E2BIG      - segment hasn't enough free space.
+ */
+int ssdfs_segment_blk_bmap_reserve_extent(struct ssdfs_segment_blk_bmap *ptr,
+					  u32 count)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	int free_blks;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->peb || !ptr->parent_si);
+
+	SSDFS_DBG("seg_id %llu\n",
+		  ptr->parent_si->seg_id);
+	SSDFS_DBG("BEFORE: free_logical_blks %d, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, pages_per_seg %u\n",
+		  atomic_read(&ptr->seg_free_blks),
+		  atomic_read(&ptr->seg_valid_blks),
+		  atomic_read(&ptr->seg_invalid_blks),
+		  ptr->pages_per_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_read(&ptr->state) != SSDFS_SEG_BLK_BMAP_CREATED) {
+		SSDFS_ERR("invalid segment block bitmap state %#x\n",
+			  atomic_read(&ptr->state));
+		return -ERANGE;
+	}
+
+	down_read(&ptr->modification_lock);
+
+	free_blks = atomic_read(&ptr->seg_free_blks);
+
+	if (free_blks < count) {
+		err = -E2BIG;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("segment %llu hasn't enough free pages: "
+			  "free_pages %u, requested_pages %u\n",
+			  ptr->parent_si->seg_id, free_blks, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		atomic_set(&ptr->seg_free_blks, 0);
+	} else {
+		atomic_sub(count, &ptr->seg_free_blks);
+	}
+
+	up_read(&ptr->modification_lock);
+
+	if (err)
+		goto finish_reserve_extent;
+
+	si = ptr->parent_si;
+	fsi = si->fsi;
+
+	if (si->seg_type == SSDFS_USER_DATA_SEG_TYPE) {
+		u64 reserved = 0;
+		u32 pending = 0;
+
+		spin_lock(&fsi->volume_state_lock);
+		reserved = fsi->reserved_new_user_data_pages;
+		if (fsi->reserved_new_user_data_pages >= count) {
+			fsi->reserved_new_user_data_pages -= count;
+		} else
+			err = -ERANGE;
+		spin_unlock(&fsi->volume_state_lock);
+
+		if (err) {
+			SSDFS_ERR("count %u is bigger than reserved %llu\n",
+				  count, reserved);
+			goto finish_reserve_extent;
+		}
+
+		spin_lock(&si->pending_lock);
+		si->pending_new_user_data_pages += count;
+		pending = si->pending_new_user_data_pages;
+		spin_unlock(&si->pending_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg_id %llu, pending %u\n",
+			  si->seg_id, pending);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("AFTER: free_logical_blks %d, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, pages_per_seg %u\n",
+		  atomic_read(&ptr->seg_free_blks),
+		  atomic_read(&ptr->seg_valid_blks),
+		  atomic_read(&ptr->seg_invalid_blks),
+		  ptr->pages_per_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_reserve_extent:
+	return err;
+}
+
+/*
+ * ssdfs_segment_blk_bmap_reserve_block() - reserve free block
+ * @ptr: segment block bitmap object
+ * @count: number of logical blocks
+ *
+ * This function tries to reserve a free block.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-E2BIG      - segment hasn't enough free space.
+ */
+int ssdfs_segment_blk_bmap_reserve_block(struct ssdfs_segment_blk_bmap *ptr)
+{
+	return ssdfs_segment_blk_bmap_reserve_extent(ptr, 1);
+}
+
+/*
+ * ssdfs_segment_blk_bmap_pre_allocate() - pre-allocate range of blocks
+ * @ptr: segment block bitmap object
+ * @pebc: pointer on PEB container
+ * @len: pointer on variable with requested length of range
+ * @range: pointer on blocks' range [in | out]
+ *
+ * This function tries to find contiguous range of free blocks and
+ * to set the found range in pre-allocated state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_blk_bmap_pre_allocate(struct ssdfs_segment_blk_bmap *ptr,
+					struct ssdfs_peb_container *pebc,
+					u32 *len,
+					struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	int bmap_index = SSDFS_PEB_BLK_BMAP_INDEX_MAX;
+	u16 peb_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->peb || !ptr->parent_si || !pebc);
+	BUG_ON(!rwsem_is_locked(&pebc->lock));
+
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  ptr->parent_si->seg_id,
+		  pebc->peb_index);
+	SSDFS_DBG("free_logical_blks %d, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, pages_per_seg %u\n",
+		  atomic_read(&ptr->seg_free_blks),
+		  atomic_read(&ptr->seg_valid_blks),
+		  atomic_read(&ptr->seg_invalid_blks),
+		  ptr->pages_per_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_read(&ptr->state) != SSDFS_SEG_BLK_BMAP_CREATED) {
+		SSDFS_ERR("invalid segment block bitmap state %#x\n",
+			  atomic_read(&ptr->state));
+		return -ERANGE;
+	}
+
+	err = ssdfs_define_bmap_index(pebc, &bmap_index, &peb_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define bmap_index: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  ptr->parent_si->seg_id,
+			  pebc->peb_index, err);
+		return err;
+	}
+
+	if (peb_index >= ptr->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  peb_index, ptr->pebs_count);
+		return -ERANGE;
+	}
+
+	peb_blkbmap = &ptr->peb[peb_index];
+
+	return ssdfs_peb_blk_bmap_pre_allocate(peb_blkbmap, bmap_index,
+						len, range);
+}
+
+/*
+ * ssdfs_segment_blk_bmap_allocate() - allocate range of blocks
+ * @ptr: segment block bitmap object
+ * @pebc: pointer on PEB container
+ * @len: pointer on variable with requested length of range
+ * @range: pointer on blocks' range [in | out]
+ *
+ * This function tries to find contiguous range of free blocks and
+ * to set the found range in allocated state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_blk_bmap_allocate(struct ssdfs_segment_blk_bmap *ptr,
+				    struct ssdfs_peb_container *pebc,
+				    u32 *len,
+				    struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	int bmap_index = SSDFS_PEB_BLK_BMAP_INDEX_MAX;
+	u16 peb_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr || !ptr->peb || !ptr->parent_si || !pebc);
+	BUG_ON(!rwsem_is_locked(&pebc->lock));
+
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  ptr->parent_si->seg_id,
+		  pebc->peb_index);
+	SSDFS_DBG("free_logical_blks %d, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, pages_per_seg %u\n",
+		  atomic_read(&ptr->seg_free_blks),
+		  atomic_read(&ptr->seg_valid_blks),
+		  atomic_read(&ptr->seg_invalid_blks),
+		  ptr->pages_per_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_read(&ptr->state) != SSDFS_SEG_BLK_BMAP_CREATED) {
+		SSDFS_ERR("invalid segment block bitmap state %#x\n",
+			  atomic_read(&ptr->state));
+		return -ERANGE;
+	}
+
+	err = ssdfs_define_bmap_index(pebc, &bmap_index, &peb_index);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define bmap_index: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  ptr->parent_si->seg_id,
+			  pebc->peb_index, err);
+		return err;
+	}
+
+	if (peb_index >= ptr->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  peb_index, ptr->pebs_count);
+		return -ERANGE;
+	}
+
+	peb_blkbmap = &ptr->peb[peb_index];
+
+	return ssdfs_peb_blk_bmap_allocate(peb_blkbmap, bmap_index,
+					   len, range);
+}
+
+/*
+ * ssdfs_segment_blk_bmap_update_range() - update range of blocks' state
+ * @ptr: segment block bitmap object
+ * @pebc: pointer on PEB container
+ * @peb_migration_id: migration_id of PEB
+ * @range_state: new state of range
+ * @range: pointer on blocks' range [in | out]
+ *
+ * This function tries to change state of @range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_blk_bmap_update_range(struct ssdfs_segment_blk_bmap *bmap,
+				    struct ssdfs_peb_container *pebc,
+				    u8 peb_migration_id,
+				    int range_state,
+				    struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_container *dst_pebc;
+	struct ssdfs_peb_blk_bmap *dst_blkbmap;
+	int bmap_index = SSDFS_PEB_BLK_BMAP_INDEX_MAX;
+	u16 peb_index;
+	int migration_state, migration_phase, items_state;
+	bool need_migrate = false;
+	bool need_move = false;
+	int src_migration_id = -1, dst_migration_id = -1;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !bmap->peb || !bmap->parent_si);
+	BUG_ON(!pebc || !range);
+	BUG_ON(!rwsem_is_locked(&pebc->lock));
+	BUG_ON(!mutex_is_locked(&pebc->migration_lock));
+
+	SSDFS_DBG("seg_id %llu, peb_index %u, peb_migration_id %u, "
+		  "range (start %u, len %u)\n",
+		  bmap->parent_si->seg_id, pebc->peb_index,
+		  peb_migration_id, range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+
+try_define_bmap_index:
+	migration_state = atomic_read(&pebc->migration_state);
+	migration_phase = atomic_read(&pebc->migration_phase);
+	items_state = atomic_read(&pebc->items_state);
+	switch (migration_state) {
+	case SSDFS_PEB_NOT_MIGRATING:
+		need_migrate = false;
+		need_move = false;
+		bmap_index = SSDFS_PEB_BLK_BMAP_SOURCE;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!pebc->src_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		src_migration_id =
+			ssdfs_get_peb_migration_id_checked(pebc->src_peb);
+		if (unlikely(src_migration_id < 0)) {
+			err = src_migration_id;
+			SSDFS_ERR("invalid peb_migration_id: "
+				  "err %d\n",
+				  err);
+			goto finish_define_bmap_index;
+		}
+
+		if (peb_migration_id > src_migration_id) {
+			err = -ERANGE;
+			SSDFS_ERR("migration_id %u > src_migration_id %u\n",
+				  peb_migration_id,
+				  src_migration_id);
+			goto finish_define_bmap_index;
+		}
+		peb_index = pebc->src_peb->peb_index;
+		break;
+
+	case SSDFS_PEB_UNDER_MIGRATION:
+		switch (items_state) {
+		case SSDFS_PEB1_DST_CONTAINER:
+		case SSDFS_PEB2_DST_CONTAINER:
+			need_migrate = false;
+			need_move = false;
+			bmap_index = SSDFS_PEB_BLK_BMAP_SOURCE;
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!pebc->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			dst_migration_id =
+			    ssdfs_get_peb_migration_id_checked(pebc->dst_peb);
+			if (unlikely(dst_migration_id < 0)) {
+				err = dst_migration_id;
+				SSDFS_ERR("invalid peb_migration_id: "
+					  "err %d\n",
+					  err);
+				goto finish_define_bmap_index;
+			}
+
+			if (peb_migration_id != dst_migration_id) {
+				err = -ERANGE;
+				SSDFS_ERR("migration_id %u != "
+					  "dst_migration_id %u\n",
+					  peb_migration_id,
+					  dst_migration_id);
+				goto finish_define_bmap_index;
+			}
+			peb_index = pebc->dst_peb->peb_index;
+			break;
+
+		case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+		case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!pebc->src_peb || !pebc->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			src_migration_id =
+			    ssdfs_get_peb_migration_id_checked(pebc->src_peb);
+			if (unlikely(src_migration_id < 0)) {
+				err = src_migration_id;
+				SSDFS_ERR("invalid peb_migration_id: "
+					  "err %d\n",
+					  err);
+				goto finish_define_bmap_index;
+			}
+
+			dst_migration_id =
+			    ssdfs_get_peb_migration_id_checked(pebc->dst_peb);
+			if (unlikely(dst_migration_id < 0)) {
+				err = dst_migration_id;
+				SSDFS_ERR("invalid peb_migration_id: "
+					  "err %d\n",
+					  err);
+				goto finish_define_bmap_index;
+			}
+
+			if (src_migration_id == dst_migration_id) {
+				err = -ERANGE;
+				SSDFS_ERR("src_migration_id %u == "
+					  "dst_migration_id %u\n",
+					  src_migration_id,
+					  dst_migration_id);
+				goto finish_define_bmap_index;
+			}
+
+			if (peb_migration_id == src_migration_id) {
+				int state;
+
+				need_migrate = true;
+				need_move = false;
+
+				dst_pebc = pebc->dst_peb->pebc;
+				state = atomic_read(&dst_pebc->items_state);
+				switch (state) {
+				case SSDFS_PEB1_DST_CONTAINER:
+				case SSDFS_PEB2_DST_CONTAINER:
+					bmap_index = SSDFS_PEB_BLK_BMAP_SOURCE;
+					break;
+
+				case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+				case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+					bmap_index =
+					    SSDFS_PEB_BLK_BMAP_DESTINATION;
+					break;
+
+				default:
+					BUG();
+				}
+
+				peb_index = U16_MAX;
+			} else if (peb_migration_id == dst_migration_id) {
+				err = -ERANGE;
+				SSDFS_WARN("invalid request: "
+					   "peb_migration_id %u, "
+					   "dst_migration_id %u\n",
+					   peb_migration_id,
+					   dst_migration_id);
+				goto finish_define_bmap_index;
+			} else {
+				err = -ERANGE;
+				SSDFS_ERR("fail to select PEB: "
+					  "peb_migration_id %u, "
+					  "src_migration_id %u, "
+					  "dst_migration_id %u\n",
+					  peb_migration_id,
+					  src_migration_id,
+					  dst_migration_id);
+				goto finish_define_bmap_index;
+			}
+			break;
+
+		case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+		case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!pebc->src_peb || !pebc->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			src_migration_id =
+			    ssdfs_get_peb_migration_id_checked(pebc->src_peb);
+			if (unlikely(src_migration_id < 0)) {
+				err = src_migration_id;
+				SSDFS_ERR("invalid peb_migration_id: "
+					  "err %d\n",
+					  err);
+				goto finish_define_bmap_index;
+			}
+
+			dst_migration_id =
+			    ssdfs_get_peb_migration_id_checked(pebc->dst_peb);
+			if (unlikely(dst_migration_id < 0)) {
+				err = dst_migration_id;
+				SSDFS_ERR("invalid peb_migration_id: "
+					  "err %d\n",
+					  err);
+				goto finish_define_bmap_index;
+			}
+
+			if (src_migration_id == dst_migration_id) {
+				err = -ERANGE;
+				SSDFS_ERR("src_migration_id %u == "
+					  "dst_migration_id %u\n",
+					  src_migration_id,
+					  dst_migration_id);
+				goto finish_define_bmap_index;
+			}
+
+			if (peb_migration_id == src_migration_id) {
+				switch (migration_phase) {
+				case SSDFS_SRC_PEB_NOT_EXHAUSTED:
+					need_migrate = false;
+					need_move = false;
+					bmap_index =
+						SSDFS_PEB_BLK_BMAP_SOURCE;
+					peb_index = pebc->src_peb->peb_index;
+					break;
+
+				default:
+					need_migrate = true;
+					need_move = false;
+					bmap_index =
+						SSDFS_PEB_BLK_BMAP_INDEX_MAX;
+					peb_index = pebc->src_peb->peb_index;
+					break;
+				}
+			} else if (peb_migration_id == dst_migration_id) {
+				need_migrate = false;
+				need_move = false;
+				bmap_index = SSDFS_PEB_BLK_BMAP_DESTINATION;
+				peb_index = pebc->dst_peb->peb_index;
+			} else if ((peb_migration_id + 1) == src_migration_id) {
+				switch (migration_phase) {
+				case SSDFS_SRC_PEB_NOT_EXHAUSTED:
+					need_migrate = false;
+					need_move = false;
+					bmap_index =
+						SSDFS_PEB_BLK_BMAP_SOURCE;
+					peb_index = pebc->src_peb->peb_index;
+					break;
+
+				default:
+					need_migrate = false;
+					need_move = true;
+					bmap_index =
+					    SSDFS_PEB_BLK_BMAP_DESTINATION;
+					peb_index = pebc->dst_peb->peb_index;
+					break;
+				}
+			} else {
+				err = -ERANGE;
+				SSDFS_ERR("fail to select PEB: "
+					  "peb_migration_id %u, "
+					  "src_migration_id %u, "
+					  "dst_migration_id %u\n",
+					  peb_migration_id,
+					  src_migration_id,
+					  dst_migration_id);
+				goto finish_define_bmap_index;
+			}
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_WARN("invalid items_state %#x\n",
+				   items_state);
+			goto finish_define_bmap_index;
+		};
+		break;
+
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_FINISHING_MIGRATION:
+#ifdef CONFIG_SSDFS_DEBUG
+		/* unexpected situation */
+		SSDFS_WARN("unexpected situation\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = -EAGAIN;
+		goto finish_define_bmap_index;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid migration_state %#x\n",
+			   migration_state);
+		goto finish_define_bmap_index;
+	}
+
+finish_define_bmap_index:
+	if (err == -EAGAIN) {
+		DEFINE_WAIT(wait);
+
+		err = 0;
+		mutex_unlock(&pebc->migration_lock);
+		up_read(&pebc->lock);
+		prepare_to_wait(&pebc->migration_wq, &wait,
+				TASK_UNINTERRUPTIBLE);
+		schedule();
+		finish_wait(&pebc->migration_wq, &wait);
+		down_read(&pebc->lock);
+		mutex_lock(&pebc->migration_lock);
+		goto try_define_bmap_index;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to define bmap_index: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(need_migrate && need_move);
+
+	SSDFS_DBG("seg_id %llu, migration_state %#x, items_state %#x, "
+		  "peb_migration_id %u, src_migration_id %d, "
+		  "dst_migration_id %d, migration_phase %#x\n",
+		  si->seg_id, migration_state, items_state,
+		  peb_migration_id, src_migration_id,
+		  dst_migration_id, migration_phase);
+	SSDFS_DBG("seg_id %llu, need_migrate %#x, need_move %#x\n",
+		  si->seg_id, need_migrate, need_move);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (need_migrate) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(peb_index >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (peb_index >= bmap->pebs_count) {
+			SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+				  peb_index, bmap->pebs_count);
+			return -ERANGE;
+		}
+
+		dst_blkbmap = &bmap->peb[peb_index];
+
+		err = ssdfs_peb_blk_bmap_migrate(dst_blkbmap,
+						 range_state,
+						 range);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to migrate: "
+				  "range (start %u, len %u), "
+				  "range_state %#x, "
+				  "err %d\n",
+				  range->start, range->len,
+				  range_state, err);
+			SSDFS_ERR("seg_id %llu, peb_index %u, "
+				  "peb_migration_id %u, "
+				  "range (start %u, len %u)\n",
+				  bmap->parent_si->seg_id,
+				  pebc->peb_index,
+				  peb_migration_id,
+				  range->start, range->len);
+			SSDFS_ERR("seg_id %llu, migration_state %#x, "
+				  "items_state %#x, "
+				  "peb_migration_id %u, src_migration_id %d, "
+				  "dst_migration_id %d, migration_phase %#x\n",
+				  si->seg_id, migration_state, items_state,
+				  peb_migration_id, src_migration_id,
+				  dst_migration_id, migration_phase);
+			SSDFS_ERR("seg_id %llu, need_migrate %#x, "
+				  "need_move %#x\n",
+				  si->seg_id, need_migrate, need_move);
+			return err;
+		}
+	} else if (need_move) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!pebc->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		peb_index = pebc->dst_peb->peb_index;
+
+		if (peb_index >= bmap->pebs_count) {
+			SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+				  peb_index, bmap->pebs_count);
+			return -ERANGE;
+		}
+
+		dst_blkbmap = &bmap->peb[peb_index];
+
+		if (range_state == SSDFS_BLK_PRE_ALLOCATED) {
+			err = ssdfs_peb_blk_bmap_pre_allocate(dst_blkbmap,
+							      bmap_index,
+							      NULL,
+							      range);
+		} else {
+			err = ssdfs_peb_blk_bmap_allocate(dst_blkbmap,
+							  bmap_index,
+							  NULL,
+							  range);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move: "
+				  "range (start %u, len %u), "
+				  "range_state %#x, "
+				  "err %d\n",
+				  range->start, range->len,
+				  range_state, err);
+			SSDFS_ERR("seg_id %llu, peb_index %u, "
+				  "peb_migration_id %u, "
+				  "range (start %u, len %u)\n",
+				  bmap->parent_si->seg_id,
+				  pebc->peb_index,
+				  peb_migration_id,
+				  range->start, range->len);
+			SSDFS_ERR("seg_id %llu, migration_state %#x, "
+				  "items_state %#x, "
+				  "peb_migration_id %u, src_migration_id %d, "
+				  "dst_migration_id %d, migration_phase %#x\n",
+				  si->seg_id, migration_state, items_state,
+				  peb_migration_id, src_migration_id,
+				  dst_migration_id, migration_phase);
+			SSDFS_ERR("seg_id %llu, need_migrate %#x, "
+				  "need_move %#x\n",
+				  si->seg_id, need_migrate, need_move);
+			return err;
+		}
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(peb_index >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (peb_index >= bmap->pebs_count) {
+			SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+				  peb_index, bmap->pebs_count);
+			return -ERANGE;
+		}
+
+		dst_blkbmap = &bmap->peb[peb_index];
+
+		err = ssdfs_peb_blk_bmap_update_range(dst_blkbmap,
+						      bmap_index,
+						      range_state,
+						      range);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update range: "
+				  "range (start %u, len %u), "
+				  "range_state %#x, "
+				  "err %d\n",
+				  range->start, range->len,
+				  range_state, err);
+			SSDFS_ERR("seg_id %llu, peb_index %u, "
+				  "peb_migration_id %u, "
+				  "range (start %u, len %u)\n",
+				  bmap->parent_si->seg_id,
+				  pebc->peb_index,
+				  peb_migration_id,
+				  range->start, range->len);
+			SSDFS_ERR("seg_id %llu, migration_state %#x, "
+				  "items_state %#x, "
+				  "peb_migration_id %u, src_migration_id %d, "
+				  "dst_migration_id %d, migration_phase %#x\n",
+				  si->seg_id, migration_state, items_state,
+				  peb_migration_id, src_migration_id,
+				  dst_migration_id, migration_phase);
+			SSDFS_ERR("seg_id %llu, need_migrate %#x, "
+				  "need_move %#x\n",
+				  si->seg_id, need_migrate, need_move);
+			return err;
+		}
+	}
+
+	return 0;
+}
diff --git a/fs/ssdfs/segment_block_bitmap.h b/fs/ssdfs/segment_block_bitmap.h
new file mode 100644
index 000000000000..899e34a4343a
--- /dev/null
+++ b/fs/ssdfs/segment_block_bitmap.h
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment_block_bitmap.h - segment's block bitmap declarations.
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
+#ifndef _SSDFS_SEGMENT_BLOCK_BITMAP_H
+#define _SSDFS_SEGMENT_BLOCK_BITMAP_H
+
+#include "peb_block_bitmap.h"
+
+/*
+ * struct ssdfs_segment_blk_bmap - segment block bitmap object
+ * @state: segment block bitmap's state
+ * @pages_per_peb: pages per physical erase block
+ * @pages_per_seg: pages per segment
+ * @modification_lock: lock for modification operations
+ * @seg_valid_blks: segment's valid logical blocks count
+ * @seg_invalid_blks: segment's invalid logical blocks count
+ * @seg_free_blks: segment's free logical blocks count
+ * @peb: array of PEB block bitmap objects
+ * @pebs_count: PEBs count in segment
+ * @parent_si: pointer on parent segment object
+ */
+struct ssdfs_segment_blk_bmap {
+	atomic_t state;
+
+	u32 pages_per_peb;
+	u32 pages_per_seg;
+
+	struct rw_semaphore modification_lock;
+	atomic_t seg_valid_blks;
+	atomic_t seg_invalid_blks;
+	atomic_t seg_free_blks;
+
+	struct ssdfs_peb_blk_bmap *peb;
+	u16 pebs_count;
+
+	struct ssdfs_segment_info *parent_si;
+};
+
+/* Segment block bitmap's possible states */
+enum {
+	SSDFS_SEG_BLK_BMAP_STATE_UNKNOWN,
+	SSDFS_SEG_BLK_BMAP_CREATED,
+	SSDFS_SEG_BLK_BMAP_STATE_MAX,
+};
+
+/*
+ * Segment block bitmap API
+ */
+int ssdfs_segment_blk_bmap_create(struct ssdfs_segment_info *si,
+				  int init_flag, int init_state);
+void ssdfs_segment_blk_bmap_destroy(struct ssdfs_segment_blk_bmap *ptr);
+int ssdfs_segment_blk_bmap_partial_init(struct ssdfs_segment_blk_bmap *bmap,
+				    u16 peb_index,
+				    struct ssdfs_page_vector *source,
+				    struct ssdfs_block_bitmap_fragment *hdr,
+				    u64 cno);
+void ssdfs_segment_blk_bmap_init_failed(struct ssdfs_segment_blk_bmap *bmap,
+					u16 peb_index);
+
+bool is_ssdfs_segment_blk_bmap_dirty(struct ssdfs_segment_blk_bmap *bmap,
+					u16 peb_index);
+
+bool has_ssdfs_segment_blk_bmap_initialized(struct ssdfs_segment_blk_bmap *ptr,
+					    struct ssdfs_peb_container *pebc);
+int ssdfs_segment_blk_bmap_wait_init_end(struct ssdfs_segment_blk_bmap *ptr,
+					 struct ssdfs_peb_container *pebc);
+
+int ssdfs_segment_blk_bmap_reserve_metapages(struct ssdfs_segment_blk_bmap *ptr,
+					     struct ssdfs_peb_container *pebc,
+					     u32 count);
+int ssdfs_segment_blk_bmap_free_metapages(struct ssdfs_segment_blk_bmap *ptr,
+					  struct ssdfs_peb_container *pebc,
+					  u32 count);
+int ssdfs_segment_blk_bmap_reserve_block(struct ssdfs_segment_blk_bmap *ptr);
+int ssdfs_segment_blk_bmap_reserve_extent(struct ssdfs_segment_blk_bmap *ptr,
+					  u32 count);
+int ssdfs_segment_blk_bmap_pre_allocate(struct ssdfs_segment_blk_bmap *ptr,
+					struct ssdfs_peb_container *pebc,
+					u32 *len,
+					struct ssdfs_block_bmap_range *range);
+int ssdfs_segment_blk_bmap_allocate(struct ssdfs_segment_blk_bmap *ptr,
+				    struct ssdfs_peb_container *pebc,
+				    u32 *len,
+				    struct ssdfs_block_bmap_range *range);
+int ssdfs_segment_blk_bmap_update_range(struct ssdfs_segment_blk_bmap *ptr,
+				    struct ssdfs_peb_container *pebc,
+				    u8 peb_migration_id,
+				    int range_state,
+				    struct ssdfs_block_bmap_range *range);
+
+static inline
+int ssdfs_segment_blk_bmap_get_free_pages(struct ssdfs_segment_blk_bmap *ptr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int free_blks;
+	int valid_blks;
+	int invalid_blks;
+	int calculated;
+
+	BUG_ON(!ptr);
+
+	free_blks = atomic_read(&ptr->seg_free_blks);
+	valid_blks = atomic_read(&ptr->seg_valid_blks);
+	invalid_blks = atomic_read(&ptr->seg_invalid_blks);
+	calculated = free_blks + valid_blks + invalid_blks;
+
+	SSDFS_DBG("free_logical_blks %d, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, pages_per_seg %u\n",
+		  free_blks, valid_blks, invalid_blks,
+		  ptr->pages_per_seg);
+
+	if (calculated > ptr->pages_per_seg) {
+		SSDFS_WARN("free_logical_blks %d, valid_logical_blks %d, "
+			   "invalid_logical_blks %d, calculated %d, "
+			   "pages_per_seg %u\n",
+			   free_blks, valid_blks, invalid_blks,
+			   calculated, ptr->pages_per_seg);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+	return atomic_read(&ptr->seg_free_blks);
+}
+
+static inline
+int ssdfs_segment_blk_bmap_get_used_pages(struct ssdfs_segment_blk_bmap *ptr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int free_blks;
+	int valid_blks;
+	int invalid_blks;
+	int calculated;
+
+	BUG_ON(!ptr);
+
+	free_blks = atomic_read(&ptr->seg_free_blks);
+	valid_blks = atomic_read(&ptr->seg_valid_blks);
+	invalid_blks = atomic_read(&ptr->seg_invalid_blks);
+	calculated = free_blks + valid_blks + invalid_blks;
+
+	SSDFS_DBG("free_logical_blks %d, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, pages_per_seg %u\n",
+		  free_blks, valid_blks, invalid_blks,
+		  ptr->pages_per_seg);
+
+	if (calculated > ptr->pages_per_seg) {
+		SSDFS_WARN("free_logical_blks %d, valid_logical_blks %d, "
+			   "invalid_logical_blks %d, calculated %d, "
+			   "pages_per_seg %u\n",
+			   free_blks, valid_blks, invalid_blks,
+			   calculated, ptr->pages_per_seg);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+	return atomic_read(&ptr->seg_valid_blks);
+}
+
+static inline
+int ssdfs_segment_blk_bmap_get_invalid_pages(struct ssdfs_segment_blk_bmap *ptr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int free_blks;
+	int valid_blks;
+	int invalid_blks;
+	int calculated;
+
+	BUG_ON(!ptr);
+
+	free_blks = atomic_read(&ptr->seg_free_blks);
+	valid_blks = atomic_read(&ptr->seg_valid_blks);
+	invalid_blks = atomic_read(&ptr->seg_invalid_blks);
+	calculated = free_blks + valid_blks + invalid_blks;
+
+	SSDFS_DBG("free_logical_blks %d, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, pages_per_seg %u\n",
+		  free_blks, valid_blks, invalid_blks,
+		  ptr->pages_per_seg);
+
+	if (calculated > ptr->pages_per_seg) {
+		SSDFS_WARN("free_logical_blks %d, valid_logical_blks %d, "
+			   "invalid_logical_blks %d, calculated %d, "
+			   "pages_per_seg %u\n",
+			   free_blks, valid_blks, invalid_blks,
+			   calculated, ptr->pages_per_seg);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+	return atomic_read(&ptr->seg_invalid_blks);
+}
+
+#endif /* _SSDFS_SEGMENT_BLOCK_BITMAP_H */
-- 
2.34.1


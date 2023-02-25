Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D86A262C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBYBQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBYBQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:09 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADBC15C88
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:04 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q15so779634oiw.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Vp8yFd/CK3RAMFUu4dR8uwEv3Xl03K9pf0agNYOIQs=;
        b=YUEi/ymScdXiaXJQD86T4HbabiqTCsxD+dMDproQii0yGRZg1/8yLZz8uC6/+2/A0K
         vWYAkGReSj1Zw6zkaXtGwcCJY42kzkRDwBdXo5uGz25OBa86aEYgBWdGSjfH4L86vrHg
         Jb1h8BNBBlFGLTwkcrZHe6xRLmySmHGt4wHJ0gQ1W0uTl7pxCZDE7WVA9vhtQXUxO6Gn
         SZ8XN5EQ/gNwZeS6FZxlJoAmXMwmJMlFyQusYuj+3O+9HILsEaWPjDGZNyiyGt0uBYXq
         Pr1haM5pDUdoaLyZtmkpsIHZMNsT2xWnhU5MtsX81PR/rBuGPax/5IAFQrcCSPQ1dk0q
         p1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Vp8yFd/CK3RAMFUu4dR8uwEv3Xl03K9pf0agNYOIQs=;
        b=xhFGbks9Ej3AmiFzjdyQAVILtr+JnfqggkHJoIoy6+sAYY+FWHPERZS3px1S35Ekwc
         IKajoNnTOQbHc3AG8rDzNLyFEVUppmakq71UQDJ4JSLyhA96magBYuxjSLwndwRDGaUn
         AEffIsdIErcf5bXwFZUBNjWDA+RfTWJtJjNwl3IgBPJBhLiNv+yt3TLj+92WVmbCSQTX
         RDN7nDFdq5Syerdnnf4ALQdoXvqBN/L0DucEqfM/lMABROt8ys8i83TI5DFEZlH105iK
         r9F9ieAHPyFxzi/ZrJKvvDgNsYLFmgaZQqvC8pU5Tda0GS8W5Xc5FdrxpM/hMKz3ZceW
         V0gw==
X-Gm-Message-State: AO0yUKUY7+UCSvZ2uY+zAPPIGLIqyXUKkAq2qcttrCVmJdAJPj0UXQXK
        Sl3orq2nSIXGh/hfo+7Hce/CGvFFXoVTmQev
X-Google-Smtp-Source: AK7set/wYPoEgLgmV+EAIleOUPl40wwfwfNwTStEc5blh2xccjAnqWNNJehARs5L+Y7oErC89lcR2A==
X-Received: by 2002:a05:6808:642:b0:383:b777:8518 with SMTP id z2-20020a056808064200b00383b7778518mr6771379oih.24.1677287761959;
        Fri, 24 Feb 2023 17:16:01 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:01 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 13/76] ssdfs: introduce PEB block bitmap
Date:   Fri, 24 Feb 2023 17:08:24 -0800
Message-Id: <20230225010927.813929-14-slava@dubeyko.com>
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

SSDFS implements a migration scheme. Migration scheme is
a fundamental technique of GC overhead management. The key
responsibility of the migration scheme is to guarantee
the presence of data in the same segment for any update
operations. Generally speaking, the migration scheme’s model
is implemented on the basis of association an exhausted
"Physical" Erase Block (PEB) with a clean one. The goal such
association of two PEBs is to implement the gradual migration
of data by means of the update operations in the initial
(exhausted) PEB. As a result, the old, exhausted PEB becomes
invalidated after complete data migration and it will be
possible to apply the erase operation to convert it in the
clean state. Moreover, the destination PEB in the association
changes the initial PEB for some index in the segment and, finally,
it becomes the only PEB for this position. Namely such technique
implements the concept of logical extent with the goal to decrease
the write amplification issue and to manage the GC overhead.
Because the logical extent concept excludes the necessity
to update metadata is tracking the position of user data on
the file system’s volume. Generally speaking, the migration scheme
is capable to decrease the GC activity significantly by means of
excluding the necessity to update metadata and by means of
self-migration of data between of PEBs is triggered by regular
update operations.

To implement the migration scheme concept, SSDFS introduces
PEB container that includes source and destination erase blocks.
As a result, PEB block bitmap object represents the same aggregation
for source PEB's block bitmap and destination PEB's block bitmap.
PEB block bitmap implements API:
(1) create - create PEB block bitmap
(2) destroy - destroy PEB block bitmap
(3) init - initialize PEB block bitmap by metadata from a log
(4) get_free_pages - get free pages in aggregation of block bitmaps
(5) get_used_pages - get used pages in aggregation of block bitmaps
(6) get_invalid_pages - get invalid pages in aggregation of block bitmaps
(7) pre_allocate - pre_allocate page/range in aggregation of block bitmaps
(8) allocate - allocate page/range in aggregation of block bitmaps
(9) invalidate - invalidate page/range in aggregation of block bitmaps
(10) update_range - change the state of range in aggregation of block bitmaps
(11) collect_garbage - find contiguous range for requested state
(12) start_migration - prepare PEB's environment for migration
(13) migrate - move range from source block bitmap into destination one
(14) finish_migration - clean source block bitmap and swap block bitmaps

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_block_bitmap.c | 1540 +++++++++++++++++++++++++++++++++++
 fs/ssdfs/peb_block_bitmap.h |  165 ++++
 2 files changed, 1705 insertions(+)
 create mode 100644 fs/ssdfs/peb_block_bitmap.c
 create mode 100644 fs/ssdfs/peb_block_bitmap.h

diff --git a/fs/ssdfs/peb_block_bitmap.c b/fs/ssdfs/peb_block_bitmap.c
new file mode 100644
index 000000000000..0011ed7dc306
--- /dev/null
+++ b/fs/ssdfs/peb_block_bitmap.c
@@ -0,0 +1,1540 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_block_bitmap.c - PEB's block bitmap implementation.
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
+#include "segment.h"
+
+#define SSDFS_PEB_BLK_BMAP_STATE_FNS(value, name)			\
+static inline								\
+bool is_peb_block_bmap_##name(struct ssdfs_peb_blk_bmap *bmap)		\
+{									\
+	return atomic_read(&bmap->state) == SSDFS_PEB_BLK_BMAP_##value;	\
+}									\
+static inline								\
+void set_peb_block_bmap_##name(struct ssdfs_peb_blk_bmap *bmap)		\
+{									\
+	atomic_set(&bmap->state, SSDFS_PEB_BLK_BMAP_##value);		\
+}									\
+
+/*
+ * is_peb_block_bmap_created()
+ * set_peb_block_bmap_created()
+ */
+SSDFS_PEB_BLK_BMAP_STATE_FNS(CREATED, created)
+
+/*
+ * is_peb_block_bmap_initialized()
+ * set_peb_block_bmap_initialized()
+ */
+SSDFS_PEB_BLK_BMAP_STATE_FNS(INITIALIZED, initialized)
+
+bool ssdfs_peb_blk_bmap_initialized(struct ssdfs_peb_blk_bmap *ptr)
+{
+	return is_peb_block_bmap_initialized(ptr);
+}
+
+/*
+ * ssdfs_peb_blk_bmap_create() - construct PEB's block bitmap
+ * @parent: parent segment's block bitmap
+ * @peb_index: PEB's index in segment's array
+ * @items_count: count of described items
+ * @flag: define necessity to allocate memory
+ * @init_flag: definition of block bitmap's creation state
+ * @init_state: block state is used during initialization
+ *
+ * This function tries to create the source and destination block
+ * bitmap objects.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_create(struct ssdfs_segment_blk_bmap *parent,
+			      u16 peb_index, u32 items_count,
+			      int init_flag, int init_state)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_blk_bmap *bmap;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!parent || !parent->peb);
+	BUG_ON(peb_index >= parent->pebs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("parent %p, peb_index %u, "
+		  "items_count %u, init_flag %#x, init_state %#x\n",
+		  parent, peb_index,
+		  items_count, init_flag, init_state);
+#else
+	SSDFS_DBG("parent %p, peb_index %u, "
+		  "items_count %u, init_flag %#x, init_state %#x\n",
+		  parent, peb_index,
+		  items_count, init_flag, init_state);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = parent->parent_si->fsi;
+	si = parent->parent_si;
+	bmap = &parent->peb[peb_index];
+	atomic_set(&bmap->state, SSDFS_PEB_BLK_BMAP_STATE_UNKNOWN);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  si->seg_id, bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (items_count > parent->pages_per_peb) {
+		SSDFS_ERR("items_count %u > pages_per_peb %u\n",
+			  items_count, parent->pages_per_peb);
+		return -ERANGE;
+	}
+
+	bmap->parent = parent;
+	bmap->peb_index = peb_index;
+	bmap->pages_per_peb = parent->pages_per_peb;
+
+	init_rwsem(&bmap->modification_lock);
+	atomic_set(&bmap->peb_valid_blks, 0);
+	atomic_set(&bmap->peb_invalid_blks, 0);
+	atomic_set(&bmap->peb_free_blks, 0);
+
+	atomic_set(&bmap->buffers_state, SSDFS_PEB_BMAP_BUFFERS_EMPTY);
+	init_rwsem(&bmap->lock);
+	bmap->init_cno = U64_MAX;
+
+	err = ssdfs_block_bmap_create(fsi,
+				      &bmap->buffer[SSDFS_PEB_BLK_BMAP1],
+				      items_count, init_flag, init_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create source block bitmap: "
+			  "peb_index %u, items_count %u, "
+			  "init_flag %#x, init_state %#x\n",
+			  peb_index, items_count,
+			  init_flag, init_state);
+		goto fail_create_peb_bmap;
+	}
+
+	err = ssdfs_block_bmap_create(fsi,
+				      &bmap->buffer[SSDFS_PEB_BLK_BMAP2],
+				      items_count,
+				      SSDFS_BLK_BMAP_CREATE,
+				      SSDFS_BLK_FREE);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create destination block bitmap: "
+			  "peb_index %u, items_count %u\n",
+			  peb_index, items_count);
+		goto fail_create_peb_bmap;
+	}
+
+	if (init_flag == SSDFS_BLK_BMAP_CREATE) {
+		atomic_set(&bmap->peb_free_blks, items_count);
+		atomic_add(items_count, &parent->seg_free_blks);
+	}
+
+	bmap->src = &bmap->buffer[SSDFS_PEB_BLK_BMAP1];
+	bmap->dst = NULL;
+
+	init_completion(&bmap->init_end);
+
+	atomic_set(&bmap->buffers_state, SSDFS_PEB_BMAP1_SRC);
+	atomic_set(&bmap->state, SSDFS_PEB_BLK_BMAP_CREATED);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+fail_create_peb_bmap:
+	ssdfs_peb_blk_bmap_destroy(bmap);
+	return err;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_destroy() - destroy PEB's block bitmap
+ * @ptr: PEB's block bitmap object
+ *
+ * This function tries to destroy PEB's block bitmap object.
+ */
+void ssdfs_peb_blk_bmap_destroy(struct ssdfs_peb_blk_bmap *ptr)
+{
+	if (!ptr)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(rwsem_is_locked(&ptr->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("ptr %p, peb_index %u, "
+		  "state %#x, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, "
+		  "free_logical_blks %d\n",
+		  ptr, ptr->peb_index,
+		  atomic_read(&ptr->state),
+		  atomic_read(&ptr->peb_valid_blks),
+		  atomic_read(&ptr->peb_invalid_blks),
+		  atomic_read(&ptr->peb_free_blks));
+#else
+	SSDFS_DBG("ptr %p, peb_index %u, "
+		  "state %#x, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, "
+		  "free_logical_blks %d\n",
+		  ptr, ptr->peb_index,
+		  atomic_read(&ptr->state),
+		  atomic_read(&ptr->peb_valid_blks),
+		  atomic_read(&ptr->peb_invalid_blks),
+		  atomic_read(&ptr->peb_free_blks));
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!is_peb_block_bmap_initialized(ptr))
+		SSDFS_WARN("PEB's block bitmap hasn't been initialized\n");
+
+	atomic_set(&ptr->peb_valid_blks, 0);
+	atomic_set(&ptr->peb_invalid_blks, 0);
+	atomic_set(&ptr->peb_free_blks, 0);
+
+	ptr->src = NULL;
+	ptr->dst = NULL;
+	atomic_set(&ptr->buffers_state, SSDFS_PEB_BMAP_BUFFERS_EMPTY);
+
+	ssdfs_block_bmap_destroy(&ptr->buffer[SSDFS_PEB_BLK_BMAP1]);
+	ssdfs_block_bmap_destroy(&ptr->buffer[SSDFS_PEB_BLK_BMAP2]);
+
+	atomic_set(&ptr->state, SSDFS_PEB_BLK_BMAP_STATE_UNKNOWN);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * ssdfs_peb_blk_bmap_init() - init PEB's block bitmap
+ * @bmap: pointer on PEB's block bitmap object
+ * @source: pointer on pagevec with bitmap state
+ * @hdr: header of block bitmap fragment
+ * @cno: log's checkpoint
+ *
+ * This function tries to init PEB's block bitmap.
+ *
+ * RETURN:
+ * [success] - count of free pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ */
+int ssdfs_peb_blk_bmap_init(struct ssdfs_peb_blk_bmap *bmap,
+			    struct ssdfs_page_vector *source,
+			    struct ssdfs_block_bitmap_fragment *hdr,
+			    u64 cno)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_container *pebc;
+	struct ssdfs_block_bmap *blk_bmap = NULL;
+	int bmap_state = SSDFS_PEB_BLK_BMAP_STATE_UNKNOWN;
+	bool is_dst_peb_clean = false;
+	u8 flags;
+	u8 type;
+	bool under_migration = false;
+	bool has_ext_ptr = false;
+	bool has_relation = false;
+	u64 old_cno = U64_MAX;
+	u32 last_free_blk;
+	u32 metadata_blks;
+	u32 free_blks;
+	u32 used_blks;
+	u32 invalid_blks;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !bmap->parent || !bmap->parent->parent_si);
+	BUG_ON(!bmap->parent->parent_si->peb_array);
+	BUG_ON(!source || !hdr);
+	BUG_ON(ssdfs_page_vector_count(source) == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = bmap->parent->parent_si->fsi;
+	si = bmap->parent->parent_si;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u, cno %llu\n",
+		  si->seg_id, bmap->peb_index, cno);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u, cno %llu\n",
+		  si->seg_id, bmap->peb_index, cno);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	bmap_state = atomic_read(&bmap->state);
+	switch (bmap_state) {
+	case SSDFS_PEB_BLK_BMAP_CREATED:
+		/* regular init */
+		break;
+
+	case SSDFS_PEB_BLK_BMAP_HAS_CLEAN_DST:
+		/*
+		 * PEB container is under migration.
+		 * But the destination PEB is clean.
+		 * It means that destination PEB doesn't need
+		 * in init operation.
+		 */
+		is_dst_peb_clean = true;
+		break;
+
+	default:
+		SSDFS_ERR("invalid PEB block bitmap state %#x\n",
+			  atomic_read(&bmap->state));
+		return -ERANGE;
+	}
+
+	if (bmap->peb_index >= si->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  bmap->peb_index, si->pebs_count);
+		return -ERANGE;
+	}
+
+	pebc = &si->peb_array[bmap->peb_index];
+
+	flags = hdr->flags;
+	type = hdr->type;
+
+	if (flags & ~SSDFS_FRAG_BLK_BMAP_FLAG_MASK) {
+		SSDFS_ERR("invalid flags set: %#x\n", flags);
+		return -EIO;
+	}
+
+	if (type >= SSDFS_FRAG_BLK_BMAP_TYPE_MAX) {
+		SSDFS_ERR("invalid type: %#x\n", type);
+		return -EIO;
+	}
+
+	if (is_dst_peb_clean) {
+		under_migration = true;
+		has_relation = true;
+	} else {
+		under_migration = flags & SSDFS_MIGRATING_BLK_BMAP;
+		has_ext_ptr = flags & SSDFS_PEB_HAS_EXT_PTR;
+		has_relation = flags & SSDFS_PEB_HAS_RELATION;
+	}
+
+	if (type == SSDFS_SRC_BLK_BMAP && (has_ext_ptr && has_relation)) {
+		SSDFS_ERR("invalid flags set: %#x\n", flags);
+		return -EIO;
+	}
+
+	down_write(&bmap->lock);
+
+	old_cno = bmap->init_cno;
+	if (bmap->init_cno == U64_MAX)
+		bmap->init_cno = cno;
+	else if (bmap->init_cno != cno) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid bmap state: "
+			  "bmap->init_cno %llu, cno %llu\n",
+			  bmap->init_cno, cno);
+		goto fail_init_blk_bmap;
+	}
+
+	switch (type) {
+	case SSDFS_SRC_BLK_BMAP:
+		if (under_migration && has_relation) {
+			if (is_dst_peb_clean)
+				bmap->dst = &bmap->buffer[SSDFS_PEB_BLK_BMAP2];
+			bmap->src = &bmap->buffer[SSDFS_PEB_BLK_BMAP1];
+			blk_bmap = bmap->src;
+			atomic_set(&bmap->buffers_state,
+				    SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST);
+		} else if (under_migration && has_ext_ptr) {
+			bmap->src = &bmap->buffer[SSDFS_PEB_BLK_BMAP1];
+			blk_bmap = bmap->src;
+			atomic_set(&bmap->buffers_state,
+				    SSDFS_PEB_BMAP1_SRC);
+		} else if (under_migration) {
+			err = -EIO;
+			SSDFS_ERR("invalid flags set: %#x\n", flags);
+			goto fail_init_blk_bmap;
+		} else {
+			bmap->src = &bmap->buffer[SSDFS_PEB_BLK_BMAP1];
+			blk_bmap = bmap->src;
+			atomic_set(&bmap->buffers_state,
+				    SSDFS_PEB_BMAP1_SRC);
+		}
+		break;
+
+	case SSDFS_DST_BLK_BMAP:
+		if (under_migration && has_relation) {
+			bmap->dst = &bmap->buffer[SSDFS_PEB_BLK_BMAP2];
+			blk_bmap = bmap->dst;
+			atomic_set(&bmap->buffers_state,
+				    SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST);
+		} else if (under_migration && has_ext_ptr) {
+			bmap->src = &bmap->buffer[SSDFS_PEB_BLK_BMAP1];
+			blk_bmap = bmap->src;
+			atomic_set(&bmap->buffers_state,
+				    SSDFS_PEB_BMAP1_SRC);
+		} else {
+			err = -EIO;
+			SSDFS_ERR("invalid flags set: %#x\n", flags);
+			goto fail_init_blk_bmap;
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	last_free_blk = le32_to_cpu(hdr->last_free_blk);
+	metadata_blks = le32_to_cpu(hdr->metadata_blks);
+	invalid_blks = le32_to_cpu(hdr->invalid_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_index %u, cno %llu, "
+		  "last_free_blk %u, metadata_blks %u, invalid_blks %u\n",
+		  si->seg_id, bmap->peb_index, cno,
+		  last_free_blk, metadata_blks, invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_block_bmap_lock(blk_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock bitmap: err %d\n", err);
+		goto fail_init_blk_bmap;
+	}
+
+	err = ssdfs_block_bmap_init(blk_bmap, source, last_free_blk,
+				    metadata_blks, invalid_blks);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to initialize block bitmap: "
+			  "err %d\n", err);
+		goto fail_define_pages_count;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(blk_bmap);
+	if (unlikely(err < 0)) {
+		SSDFS_ERR("fail to get free pages: err %d\n", err);
+		goto fail_define_pages_count;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(blk_bmap);
+	if (unlikely(err < 0)) {
+		SSDFS_ERR("fail to get used pages: err %d\n", err);
+		goto fail_define_pages_count;
+	} else {
+		used_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(blk_bmap);
+	if (unlikely(err < 0)) {
+		SSDFS_ERR("fail to get invalid pages: err %d\n", err);
+		goto fail_define_pages_count;
+	} else {
+		invalid_blks = err;
+		err = 0;
+	}
+
+fail_define_pages_count:
+	ssdfs_block_bmap_unlock(blk_bmap);
+
+	if (unlikely(err))
+		goto fail_init_blk_bmap;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_index %u, cno %llu, "
+		  "type %#x, under_migration %#x, has_relation %#x, "
+		  "last_free_blk %u, metadata_blks %u, "
+		  "free_blks %u, used_blks %u, "
+		  "invalid_blks %u, shared_free_dst_blks %d\n",
+		  si->seg_id, bmap->peb_index, cno,
+		  type, under_migration, has_relation,
+		  last_free_blk, metadata_blks,
+		  free_blks, used_blks, invalid_blks,
+		  atomic_read(&pebc->shared_free_dst_blks));
+	SSDFS_DBG("seg_id %llu, peb_index %u, cno %llu, "
+		  "free_blks %d, valid_blks %d, invalid_blks %d\n",
+		  si->seg_id, bmap->peb_index, cno,
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (type) {
+	case SSDFS_SRC_BLK_BMAP:
+		if (is_dst_peb_clean && !(flags & SSDFS_MIGRATING_BLK_BMAP)) {
+			down_write(&bmap->modification_lock);
+			atomic_set(&bmap->peb_valid_blks, used_blks);
+			atomic_add(fsi->pages_per_peb - used_blks,
+					&bmap->peb_free_blks);
+			up_write(&bmap->modification_lock);
+
+			atomic_set(&pebc->shared_free_dst_blks,
+					fsi->pages_per_peb - used_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("SRC: seg_id %llu, peb_index %u, cno %llu, "
+				  "pages_per_peb %u, used_blks %u, "
+				  "shared_free_dst_blks %d\n",
+				  si->seg_id, bmap->peb_index, cno,
+				  fsi->pages_per_peb, used_blks,
+				  atomic_read(&pebc->shared_free_dst_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			down_write(&bmap->parent->modification_lock);
+			atomic_add(atomic_read(&bmap->peb_valid_blks),
+				   &bmap->parent->seg_valid_blks);
+			atomic_add(atomic_read(&bmap->peb_free_blks),
+				   &bmap->parent->seg_free_blks);
+			up_write(&bmap->parent->modification_lock);
+		} else if (under_migration && has_relation) {
+			int current_free_blks =
+				atomic_read(&bmap->peb_free_blks);
+
+			if (used_blks > current_free_blks) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("used_blks %u > free_blks %d\n",
+					  used_blks, current_free_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				down_write(&bmap->modification_lock);
+				atomic_set(&bmap->peb_free_blks, 0);
+				atomic_add(used_blks, &bmap->peb_valid_blks);
+				up_write(&bmap->modification_lock);
+
+				atomic_set(&pebc->shared_free_dst_blks, 0);
+
+				down_write(&bmap->parent->modification_lock);
+				atomic_sub(current_free_blks,
+					   &bmap->parent->seg_free_blks);
+				atomic_add(used_blks,
+					   &bmap->parent->seg_valid_blks);
+				up_write(&bmap->parent->modification_lock);
+			} else {
+				down_write(&bmap->modification_lock);
+				atomic_sub(used_blks, &bmap->peb_free_blks);
+				atomic_add(used_blks, &bmap->peb_valid_blks);
+				up_write(&bmap->modification_lock);
+
+				atomic_sub(used_blks,
+					   &pebc->shared_free_dst_blks);
+
+				down_write(&bmap->parent->modification_lock);
+				atomic_sub(used_blks,
+					   &bmap->parent->seg_free_blks);
+				atomic_add(used_blks,
+					   &bmap->parent->seg_valid_blks);
+				up_write(&bmap->parent->modification_lock);
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("shared_free_dst_blks %d\n",
+				  atomic_read(&pebc->shared_free_dst_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (under_migration && has_ext_ptr) {
+			down_write(&bmap->modification_lock);
+			atomic_add(used_blks, &bmap->peb_valid_blks);
+			atomic_add(invalid_blks, &bmap->peb_invalid_blks);
+			atomic_add(free_blks, &bmap->peb_free_blks);
+			up_write(&bmap->modification_lock);
+		} else if (under_migration) {
+			err = -EIO;
+			SSDFS_ERR("invalid flags set: %#x\n", flags);
+			goto fail_init_blk_bmap;
+		} else {
+			down_write(&bmap->modification_lock);
+			atomic_set(&bmap->peb_valid_blks, used_blks);
+			atomic_set(&bmap->peb_invalid_blks, invalid_blks);
+			atomic_set(&bmap->peb_free_blks, free_blks);
+			up_write(&bmap->modification_lock);
+
+			down_write(&bmap->parent->modification_lock);
+			atomic_add(atomic_read(&bmap->peb_valid_blks),
+				   &bmap->parent->seg_valid_blks);
+			atomic_add(atomic_read(&bmap->peb_invalid_blks),
+				   &bmap->parent->seg_invalid_blks);
+			atomic_add(atomic_read(&bmap->peb_free_blks),
+				   &bmap->parent->seg_free_blks);
+			up_write(&bmap->parent->modification_lock);
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("SRC: seg_id %llu, peb_index %u, cno %llu, "
+			  "free_blks %d, valid_blks %d, invalid_blks %d, "
+			  "parent (used_blks %d, free_blks %d, invalid_blks %d)\n",
+			  si->seg_id, bmap->peb_index, cno,
+			  atomic_read(&bmap->peb_free_blks),
+			  atomic_read(&bmap->peb_valid_blks),
+			  atomic_read(&bmap->peb_invalid_blks),
+			  atomic_read(&bmap->parent->seg_valid_blks),
+			  atomic_read(&bmap->parent->seg_free_blks),
+			  atomic_read(&bmap->parent->seg_invalid_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	case SSDFS_DST_BLK_BMAP:
+		if (under_migration) {
+			down_write(&bmap->modification_lock);
+			atomic_add(used_blks, &bmap->peb_valid_blks);
+			atomic_add(invalid_blks, &bmap->peb_invalid_blks);
+			atomic_add(free_blks, &bmap->peb_free_blks);
+			up_write(&bmap->modification_lock);
+
+			atomic_add(free_blks, &pebc->shared_free_dst_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("DST: seg_id %llu, peb_index %u, cno %llu, "
+				  "free_blks %u, "
+				  "shared_free_dst_blks %d\n",
+				  si->seg_id, bmap->peb_index, cno,
+				  free_blks,
+				  atomic_read(&pebc->shared_free_dst_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			down_write(&bmap->parent->modification_lock);
+			atomic_add(used_blks,
+				   &bmap->parent->seg_valid_blks);
+			atomic_add(invalid_blks,
+				   &bmap->parent->seg_invalid_blks);
+			atomic_add(free_blks,
+				   &bmap->parent->seg_free_blks);
+			up_write(&bmap->parent->modification_lock);
+		} else {
+			err = -EIO;
+			SSDFS_ERR("invalid flags set: %#x\n", flags);
+			goto fail_init_blk_bmap;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("DST: seg_id %llu, peb_index %u, cno %llu, "
+			  "free_blks %d, valid_blks %d, invalid_blks %d, "
+			  "parent (used_blks %d, free_blks %d, invalid_blks %d)\n",
+			  si->seg_id, bmap->peb_index, cno,
+			  atomic_read(&bmap->peb_free_blks),
+			  atomic_read(&bmap->peb_valid_blks),
+			  atomic_read(&bmap->peb_invalid_blks),
+			  atomic_read(&bmap->parent->seg_valid_blks),
+			  atomic_read(&bmap->parent->seg_free_blks),
+			  atomic_read(&bmap->parent->seg_invalid_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	default:
+		BUG();
+	}
+
+	switch (type) {
+	case SSDFS_SRC_BLK_BMAP:
+		if (under_migration && has_relation) {
+			if (!bmap->dst)
+				goto finish_init_blk_bmap;
+			else if (!ssdfs_block_bmap_initialized(bmap->dst))
+				goto finish_init_blk_bmap;
+		}
+		break;
+
+	case SSDFS_DST_BLK_BMAP:
+		if (under_migration && has_relation) {
+			if (!bmap->src)
+				goto finish_init_blk_bmap;
+			else if (!ssdfs_block_bmap_initialized(bmap->src))
+				goto finish_init_blk_bmap;
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (atomic_read(&pebc->shared_free_dst_blks) < 0) {
+		SSDFS_WARN("type %#x, under_migration %#x, has_relation %#x, "
+			   "last_free_blk %u, metadata_blks %u, "
+			   "free_blks %u, used_blks %u, "
+			   "invalid_blks %u, shared_free_dst_blks %d\n",
+			   type, under_migration, has_relation,
+			   last_free_blk, metadata_blks,
+			   free_blks, used_blks, invalid_blks,
+			   atomic_read(&pebc->shared_free_dst_blks));
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_index %u, cno %llu, "
+		  "free_blks %d, used_blks %d, invalid_blks %d, "
+		  "shared_free_dst_blks %d\n",
+		  si->seg_id, bmap->peb_index, cno,
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  atomic_read(&pebc->shared_free_dst_blks));
+	SSDFS_DBG("seg_id %llu, peb_index %u, cno %llu, "
+		  "parent (used_blks %d, free_blks %d, invalid_blks %d)\n",
+		  si->seg_id, bmap->peb_index, cno,
+		  atomic_read(&bmap->parent->seg_valid_blks),
+		  atomic_read(&bmap->parent->seg_free_blks),
+		  atomic_read(&bmap->parent->seg_invalid_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	atomic_set(&bmap->state, SSDFS_PEB_BLK_BMAP_INITIALIZED);
+	complete_all(&bmap->init_end);
+
+fail_init_blk_bmap:
+	if (unlikely(err)) {
+		bmap->init_cno = old_cno;
+		complete_all(&bmap->init_end);
+	}
+
+finish_init_blk_bmap:
+	up_write(&bmap->lock);
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
+ * ssdfs_peb_blk_bmap_init_failed() - process failure of block bitmap init
+ * @bmap: pointer on PEB's block bitmap object
+ */
+void ssdfs_peb_blk_bmap_init_failed(struct ssdfs_peb_blk_bmap *bmap)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	complete_all(&bmap->init_end);
+}
+
+/*
+ * is_ssdfs_peb_blk_bmap_dirty() - check that PEB block bitmap is dirty
+ * @bmap: pointer on PEB's block bitmap object
+ */
+bool is_ssdfs_peb_blk_bmap_dirty(struct ssdfs_peb_blk_bmap *bmap)
+{
+	bool is_src_dirty = false;
+	bool is_dst_dirty = false;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap))
+		return false;
+
+	down_read(&bmap->lock);
+	if (bmap->src != NULL)
+		is_src_dirty = ssdfs_block_bmap_dirtied(bmap->src);
+	if (bmap->dst != NULL)
+		is_dst_dirty = ssdfs_block_bmap_dirtied(bmap->dst);
+	up_read(&bmap->lock);
+
+	return is_src_dirty || is_dst_dirty;
+}
+
+/*
+ * ssdfs_peb_define_reserved_pages_per_log() - estimate reserved pages per log
+ * @bmap: pointer on PEB's block bitmap object
+ */
+int ssdfs_peb_define_reserved_pages_per_log(struct ssdfs_peb_blk_bmap *bmap)
+{
+	struct ssdfs_segment_blk_bmap *parent = bmap->parent;
+	struct ssdfs_segment_info *si = parent->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	u32 page_size = fsi->pagesize;
+	u32 pages_per_peb = parent->pages_per_peb;
+	u32 pebs_per_seg = fsi->pebs_per_seg;
+	u16 log_pages = si->log_pages;
+	bool is_migrating = false;
+
+	switch (atomic_read(&bmap->buffers_state)) {
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		is_migrating = true;
+		break;
+
+	default:
+		is_migrating = false;
+		break;
+	}
+
+	return ssdfs_peb_estimate_reserved_metapages(page_size,
+						     pages_per_peb,
+						     log_pages,
+						     pebs_per_seg,
+						     is_migrating);
+}
+
+bool has_ssdfs_peb_blk_bmap_initialized(struct ssdfs_peb_blk_bmap *bmap)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !bmap->parent || !bmap->parent->parent_si);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  bmap->parent->parent_si->seg_id,
+		  bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ssdfs_peb_blk_bmap_initialized(bmap);
+}
+
+int ssdfs_peb_blk_bmap_wait_init_end(struct ssdfs_peb_blk_bmap *bmap)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !bmap->parent || !bmap->parent->parent_si);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  bmap->parent->parent_si->seg_id,
+		  bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (ssdfs_peb_blk_bmap_initialized(bmap))
+		return 0;
+	else {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_get_free_pages() - determine PEB's free pages count
+ * @bmap: pointer on PEB's block bitmap object
+ *
+ * This function tries to detect PEB's free pages count.
+ *
+ * RETURN:
+ * [success] - count of free pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ */
+int ssdfs_peb_blk_bmap_get_free_pages(struct ssdfs_peb_blk_bmap *bmap)
+{
+	int free_pages;
+	int log_pages;
+	int created_logs;
+	int reserved_pages_per_log;
+	int used_pages;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !bmap->parent || !bmap->parent->parent_si);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  bmap->parent->parent_si->seg_id,
+		  bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			SSDFS_ERR("seg_id %llu, free_logical_blks %u, "
+					  "valid_logical_blks %u, "
+					  "invalid_logical_blks %u, pages_per_peb %u\n",
+					  bmap->parent->parent_si->seg_id,
+					  atomic_read(&bmap->peb_free_blks),
+					  atomic_read(&bmap->peb_valid_blks),
+					  atomic_read(&bmap->peb_invalid_blks),
+					  bmap->pages_per_peb);
+
+			if (bmap->src) {
+				SSDFS_ERR("SRC BLOCK BITMAP: bytes_count %zu, items_count %zu, "
+					  "metadata_items %u, used_blks %u, invalid_blks %u, "
+					  "flags %#x\n",
+					  bmap->src->bytes_count,
+					  bmap->src->items_count,
+					  bmap->src->metadata_items,
+					  bmap->src->used_blks,
+					  bmap->src->invalid_blks,
+					  atomic_read(&bmap->src->flags));
+			}
+
+			if (bmap->dst) {
+				SSDFS_ERR("DST BLOCK BITMAP: bytes_count %zu, items_count %zu, "
+					  "metadata_items %u, used_blks %u, invalid_blks %u, "
+					  "flags %#x\n",
+					  bmap->dst->bytes_count,
+					  bmap->dst->items_count,
+					  bmap->dst->metadata_items,
+					  bmap->dst->used_blks,
+					  bmap->dst->invalid_blks,
+					  atomic_read(&bmap->dst->flags));
+			}
+
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, free_logical_blks %u, "
+		  "valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u\n",
+		  bmap->parent->parent_si->seg_id,
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb);
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	    atomic_read(&bmap->peb_valid_blks) +
+	    atomic_read(&bmap->peb_invalid_blks)) > bmap->pages_per_peb) {
+		SSDFS_WARN("seg_id %llu, peb_index %u, "
+			   "free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   bmap->parent->parent_si->seg_id,
+			   bmap->peb_index,
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	log_pages = bmap->parent->parent_si->log_pages;
+	reserved_pages_per_log = ssdfs_peb_define_reserved_pages_per_log(bmap);
+	free_pages = atomic_read(&bmap->peb_free_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("log_pages %d, reserved_pages_per_log %d, "
+		  "free_pages %d\n",
+		  log_pages, reserved_pages_per_log, free_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (free_pages > 0) {
+		int upper_threshold, lower_threshold;
+
+		created_logs = (bmap->pages_per_peb - free_pages) / log_pages;
+		used_pages = bmap->pages_per_peb - free_pages;
+
+		if (created_logs == 0) {
+			upper_threshold = log_pages;
+			lower_threshold = reserved_pages_per_log;
+		} else {
+			upper_threshold = (created_logs + 1) * log_pages;
+			lower_threshold = ((created_logs - 1) * log_pages) +
+					    reserved_pages_per_log;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("created_logs %d, used_pages %d, "
+			  "upper_threshold %d, lower_threshold %d\n",
+			  created_logs, used_pages,
+			  upper_threshold, lower_threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		BUG_ON(used_pages > upper_threshold);
+
+		if (used_pages == upper_threshold)
+			free_pages -= reserved_pages_per_log;
+		else if (used_pages < lower_threshold)
+			free_pages -= (lower_threshold - used_pages);
+
+		if (free_pages < 0)
+			free_pages = 0;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_pages %d\n", free_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return free_pages;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_get_used_pages() - determine PEB's used data pages count
+ * @bmap: pointer on PEB's block bitmap object
+ *
+ * This function tries to detect PEB's used data pages count.
+ *
+ * RETURN:
+ * [success] - count of used data pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ */
+int ssdfs_peb_blk_bmap_get_used_pages(struct ssdfs_peb_blk_bmap *bmap)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("peb_index %u\n", bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u\n",
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb);
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	    atomic_read(&bmap->peb_valid_blks) +
+	    atomic_read(&bmap->peb_invalid_blks)) > bmap->pages_per_peb) {
+		SSDFS_WARN("seg_id %llu, peb_index %u, "
+			   "free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   bmap->parent->parent_si->seg_id,
+			   bmap->peb_index,
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return atomic_read(&bmap->peb_valid_blks);
+}
+
+/*
+ * ssdfs_peb_blk_bmap_get_invalid_pages() - determine PEB's invalid pages count
+ * @bmap: pointer on PEB's block bitmap object
+ *
+ * This function tries to detect PEB's invalid pages count.
+ *
+ * RETURN:
+ * [success] - count of invalid pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ */
+int ssdfs_peb_blk_bmap_get_invalid_pages(struct ssdfs_peb_blk_bmap *bmap)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("peb_index %u\n", bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u\n",
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb);
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	    atomic_read(&bmap->peb_valid_blks) +
+	    atomic_read(&bmap->peb_invalid_blks)) > bmap->pages_per_peb) {
+		SSDFS_WARN("seg_id %llu, peb_index %u, "
+			   "free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   bmap->parent->parent_si->seg_id,
+			   bmap->peb_index,
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return atomic_read(&bmap->peb_invalid_blks);
+}
+
+/*
+ * ssdfs_src_blk_bmap_get_free_pages() - determine free pages count
+ * @bmap: pointer on PEB's block bitmap object
+ *
+ * This function tries to detect the free pages count
+ * in the source bitmap.
+ *
+ * RETURN:
+ * [success] - count of free pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ */
+int ssdfs_src_blk_bmap_get_free_pages(struct ssdfs_peb_blk_bmap *bmap)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("peb_index %u\n", bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	down_read(&bmap->lock);
+
+	if (bmap->src == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_get_src_free_pages;
+	}
+
+	err = ssdfs_block_bmap_lock(bmap->src);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_get_src_free_pages;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(bmap->src);
+	ssdfs_block_bmap_unlock(bmap->src);
+
+finish_get_src_free_pages:
+	up_read(&bmap->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_src_blk_bmap_get_used_pages() - determine used pages count
+ * @bmap: pointer on PEB's block bitmap object
+ *
+ * This function tries to detect the used pages count
+ * in the source bitmap.
+ *
+ * RETURN:
+ * [success] - count of used pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ */
+int ssdfs_src_blk_bmap_get_used_pages(struct ssdfs_peb_blk_bmap *bmap)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("peb_index %u\n", bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	down_read(&bmap->lock);
+
+	if (bmap->src == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_get_src_used_pages;
+	}
+
+	err = ssdfs_block_bmap_lock(bmap->src);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_get_src_used_pages;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(bmap->src);
+	ssdfs_block_bmap_unlock(bmap->src);
+
+finish_get_src_used_pages:
+	up_read(&bmap->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_src_blk_bmap_get_invalid_pages() - determine invalid pages count
+ * @bmap: pointer on PEB's block bitmap object
+ *
+ * This function tries to detect the invalid pages count
+ * in the source bitmap.
+ *
+ * RETURN:
+ * [success] - count of invalid pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ */
+int ssdfs_src_blk_bmap_get_invalid_pages(struct ssdfs_peb_blk_bmap *bmap)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("peb_index %u\n", bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	down_read(&bmap->lock);
+
+	if (bmap->src == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_get_src_invalid_pages;
+	}
+
+	err = ssdfs_block_bmap_lock(bmap->src);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_get_src_invalid_pages;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(bmap->src);
+	ssdfs_block_bmap_unlock(bmap->src);
+
+finish_get_src_invalid_pages:
+	up_read(&bmap->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_dst_blk_bmap_get_free_pages() - determine free pages count
+ * @bmap: pointer on PEB's block bitmap object
+ *
+ * This function tries to detect the free pages count
+ * in the destination bitmap.
+ *
+ * RETURN:
+ * [success] - count of free pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ */
+int ssdfs_dst_blk_bmap_get_free_pages(struct ssdfs_peb_blk_bmap *bmap)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("peb_index %u\n", bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	down_read(&bmap->lock);
+
+	if (bmap->dst == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_get_dst_free_pages;
+	}
+
+	err = ssdfs_block_bmap_lock(bmap->dst);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_get_dst_free_pages;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(bmap->dst);
+	ssdfs_block_bmap_unlock(bmap->dst);
+
+finish_get_dst_free_pages:
+	up_read(&bmap->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_dst_blk_bmap_get_used_pages() - determine used pages count
+ * @bmap: pointer on PEB's block bitmap object
+ *
+ * This function tries to detect the used pages count
+ * in the destination bitmap.
+ *
+ * RETURN:
+ * [success] - count of used pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ */
+int ssdfs_dst_blk_bmap_get_used_pages(struct ssdfs_peb_blk_bmap *bmap)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("peb_index %u\n", bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	down_read(&bmap->lock);
+
+	if (bmap->dst == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_get_dst_used_pages;
+	}
+
+	err = ssdfs_block_bmap_lock(bmap->dst);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_get_dst_used_pages;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(bmap->dst);
+	ssdfs_block_bmap_unlock(bmap->dst);
+
+finish_get_dst_used_pages:
+	up_read(&bmap->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_dst_blk_bmap_get_invalid_pages() - determine invalid pages count
+ * @bmap: pointer on PEB's block bitmap object
+ *
+ * This function tries to detect the invalid pages count
+ * in the destination bitmap.
+ *
+ * RETURN:
+ * [success] - count of invalid pages.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input value.
+ * %-ERANGE     - invalid internal calculations.
+ */
+int ssdfs_dst_blk_bmap_get_invalid_pages(struct ssdfs_peb_blk_bmap *bmap)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("peb_index %u\n", bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	down_read(&bmap->lock);
+
+	if (bmap->dst == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_get_dst_invalid_pages;
+	}
+
+	err = ssdfs_block_bmap_lock(bmap->dst);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_get_dst_invalid_pages;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(bmap->dst);
+	ssdfs_block_bmap_unlock(bmap->dst);
+
+finish_get_dst_invalid_pages:
+	up_read(&bmap->lock);
+
+	return err;
+}
diff --git a/fs/ssdfs/peb_block_bitmap.h b/fs/ssdfs/peb_block_bitmap.h
new file mode 100644
index 000000000000..7cbeebe1a59e
--- /dev/null
+++ b/fs/ssdfs/peb_block_bitmap.h
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_block_bitmap.h - PEB's block bitmap declarations.
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
+#ifndef _SSDFS_PEB_BLOCK_BITMAP_H
+#define _SSDFS_PEB_BLOCK_BITMAP_H
+
+#include "block_bitmap.h"
+
+/* PEB's block bitmap indexes */
+enum {
+	SSDFS_PEB_BLK_BMAP1,
+	SSDFS_PEB_BLK_BMAP2,
+	SSDFS_PEB_BLK_BMAP_ITEMS_MAX
+};
+
+/*
+ * struct ssdfs_peb_blk_bmap - PEB container's block bitmap object
+ * @state: PEB container's block bitmap's state
+ * @peb_index: PEB index in array
+ * @pages_per_peb: pages per physical erase block
+ * @modification_lock: lock for modification operations
+ * @peb_valid_blks: PEB container's valid logical blocks count
+ * @peb_invalid_blks: PEB container's invalid logical blocks count
+ * @peb_free_blks: PEB container's free logical blocks count
+ * @buffers_state: buffers state
+ * @lock: buffers lock
+ * @init_cno: initialization checkpoint
+ * @src: source PEB's block bitmap object's pointer
+ * @dst: destination PEB's block bitmap object's pointer
+ * @buffers: block bitmap buffers
+ * @init_end: wait of init ending
+ * @parent: pointer on parent segment block bitmap
+ */
+struct ssdfs_peb_blk_bmap {
+	atomic_t state;
+
+	u16 peb_index;
+	u32 pages_per_peb;
+
+	struct rw_semaphore modification_lock;
+	atomic_t peb_valid_blks;
+	atomic_t peb_invalid_blks;
+	atomic_t peb_free_blks;
+
+	atomic_t buffers_state;
+	struct rw_semaphore lock;
+	u64 init_cno;
+	struct ssdfs_block_bmap *src;
+	struct ssdfs_block_bmap *dst;
+	struct ssdfs_block_bmap buffer[SSDFS_PEB_BLK_BMAP_ITEMS_MAX];
+	struct completion init_end;
+
+	struct ssdfs_segment_blk_bmap *parent;
+};
+
+/* PEB container's block bitmap's possible states */
+enum {
+	SSDFS_PEB_BLK_BMAP_STATE_UNKNOWN,
+	SSDFS_PEB_BLK_BMAP_CREATED,
+	SSDFS_PEB_BLK_BMAP_HAS_CLEAN_DST,
+	SSDFS_PEB_BLK_BMAP_INITIALIZED,
+	SSDFS_PEB_BLK_BMAP_STATE_MAX,
+};
+
+/* PEB's buffer array possible states */
+enum {
+	SSDFS_PEB_BMAP_BUFFERS_EMPTY,
+	SSDFS_PEB_BMAP1_SRC,
+	SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST,
+	SSDFS_PEB_BMAP2_SRC,
+	SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST,
+	SSDFS_PEB_BMAP_BUFFERS_STATE_MAX
+};
+
+/* PEB's block bitmap operation destination */
+enum {
+	SSDFS_PEB_BLK_BMAP_SOURCE,
+	SSDFS_PEB_BLK_BMAP_DESTINATION,
+	SSDFS_PEB_BLK_BMAP_INDEX_MAX
+};
+
+/*
+ * PEB block bitmap API
+ */
+int ssdfs_peb_blk_bmap_create(struct ssdfs_segment_blk_bmap *parent,
+			      u16 peb_index, u32 items_count,
+			      int init_flag, int init_state);
+void ssdfs_peb_blk_bmap_destroy(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_peb_blk_bmap_init(struct ssdfs_peb_blk_bmap *bmap,
+			    struct ssdfs_page_vector *source,
+			    struct ssdfs_block_bitmap_fragment *hdr,
+			    u64 cno);
+void ssdfs_peb_blk_bmap_init_failed(struct ssdfs_peb_blk_bmap *bmap);
+
+bool has_ssdfs_peb_blk_bmap_initialized(struct ssdfs_peb_blk_bmap *bmap);
+int ssdfs_peb_blk_bmap_wait_init_end(struct ssdfs_peb_blk_bmap *bmap);
+
+bool ssdfs_peb_blk_bmap_initialized(struct ssdfs_peb_blk_bmap *ptr);
+bool is_ssdfs_peb_blk_bmap_dirty(struct ssdfs_peb_blk_bmap *ptr);
+
+int ssdfs_peb_blk_bmap_get_free_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_peb_blk_bmap_get_used_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_peb_blk_bmap_get_invalid_pages(struct ssdfs_peb_blk_bmap *ptr);
+
+int ssdfs_peb_define_reserved_pages_per_log(struct ssdfs_peb_blk_bmap *bmap);
+int ssdfs_peb_blk_bmap_reserve_metapages(struct ssdfs_peb_blk_bmap *bmap,
+					 int bmap_index,
+					 u32 count);
+int ssdfs_peb_blk_bmap_free_metapages(struct ssdfs_peb_blk_bmap *bmap,
+				      int bmap_index,
+				      u32 count);
+int ssdfs_peb_blk_bmap_pre_allocate(struct ssdfs_peb_blk_bmap *bmap,
+				    int bmap_index,
+				    u32 *len,
+				    struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_allocate(struct ssdfs_peb_blk_bmap *bmap,
+				int bmap_index,
+				u32 *len,
+				struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_invalidate(struct ssdfs_peb_blk_bmap *bmap,
+				  int bmap_index,
+				  struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_update_range(struct ssdfs_peb_blk_bmap *bmap,
+				    int bmap_index,
+				    int new_range_state,
+				    struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_collect_garbage(struct ssdfs_peb_blk_bmap *bmap,
+					u32 start, u32 max_len,
+					int blk_state,
+					struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_start_migration(struct ssdfs_peb_blk_bmap *bmap);
+int ssdfs_peb_blk_bmap_migrate(struct ssdfs_peb_blk_bmap *bmap,
+				int new_range_state,
+				struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_finish_migration(struct ssdfs_peb_blk_bmap *bmap);
+
+/*
+ * PEB block bitmap internal API
+ */
+int ssdfs_src_blk_bmap_get_free_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_src_blk_bmap_get_used_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_src_blk_bmap_get_invalid_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_dst_blk_bmap_get_free_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_dst_blk_bmap_get_used_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_dst_blk_bmap_get_invalid_pages(struct ssdfs_peb_blk_bmap *ptr);
+
+#endif /* _SSDFS_PEB_BLOCK_BITMAP_H */
-- 
2.34.1


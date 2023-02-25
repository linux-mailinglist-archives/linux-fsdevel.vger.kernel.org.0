Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9758C6A264A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBYBRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBYBQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:56 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E90013529
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:51 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t22so777846oiw.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fynaQ0+S+275hebR9iXIxiakj9lVqXF0oruYbxkQCD8=;
        b=5+cEdQDc+/TU+DPfb7abrsWUFqrxOtqw24FQguVZmRFt8c1M9uik0z10eRueyVYd+E
         taW5eK2Iyj7d54yIRG+fr14OWPBeXb09Z1XkEXIYgvyY9ihoVADNDqF2RwtMRjbuQMis
         o0tl8UxWGcEzivcmr/iVwmXz9O5UvOhHEs/8H0TIrDv3xLcdBNJ/aUvlCAh6CIGq67UB
         kUkK7PEgXWfoiiqDGaq4oyHOYKIYjhta0rbcVGEJ5lOEA0pYx081khhf1hv4tnj6EpuX
         ZG4Qm/n8IC/Elcc477+TqBaLdyaWODEy7grTVuStEBKvryodZlXl+7OYDjjwwbbB5usV
         /FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fynaQ0+S+275hebR9iXIxiakj9lVqXF0oruYbxkQCD8=;
        b=lZPFyvycWCz0v73ChVHutTu/rZwpNjcSSJT4ibIb7SuYEsjPs36VOIB6hFmLcs/NvF
         768Pu9+fnWsPWf0hRZPeGux8h/tkYnFui10nQAboIOldQKBJ/arucQo9Z6K8097Ncg0m
         wsVqI0Ak1D/kj3iAWNxNzdg4HB/sptv2s3LJK/v0yqrx0APWHCdmTLNkyzujU+NRrp2Y
         qJrFNSM6OPr2uRHvSHOWLEUjZMG1mHOwSDuFTVJF6i9b625+qzFcS9qlRXTj6k20GStX
         MkY5TedYk+eqiNSqYQNideNHTP0g90xbiq/PJh/PKAmIrqfLOh4lQb0F8a5/doAzRzbO
         mj5A==
X-Gm-Message-State: AO0yUKVNYywtYbd557HUcG+6vKBjJ3DquRbChd2w+PdpuRWE43lY9RBO
        sjzG8MgIB0+2mnmgTrIdBEtXbP1dJYDtyIdr
X-Google-Smtp-Source: AK7set+TtD3ruqf/uaiKXH1gyt1f2VDsSR5WRGREQ3wbFW1grg81DUHVDsVcKuRhPA57Dz/+0GA0hQ==
X-Received: by 2002:a54:4415:0:b0:383:fa46:af3e with SMTP id k21-20020a544415000000b00383fa46af3emr1669186oiw.44.1677287808881;
        Fri, 24 Feb 2023 17:16:48 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:48 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 35/76] ssdfs: introduce segment object
Date:   Fri, 24 Feb 2023 17:08:46 -0800
Message-Id: <20230225010927.813929-36-slava@dubeyko.com>
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

Segment is a basic unit for allocation, manage and free a file
system volume space. It's a fixed size portion of volume that
can contain one or several Logical Erase Blocks (LEB). Initially,
segment is empty container that has clean state. File system logic
can find a clean segment by means of search operation in segment
bitmap. LEBs of clean segment need to be mapped into "Physical"
Erase Blocks (PEB) by using PEB mapping table. Technically
speaking, not every LEB can be mapped into PEB if mapping table
hasn't any clean PEB. Segment can be imagined like a container
that includes an array of PEB containers. Segment object implements
the logic of logical blocks allocation, prepare create and update
requests. Current segment has create queue that is used to add
new data into file, for example. PEB container has update queue
that is used for adding update requests. Flush thread is woken up
after every operation of adding request into queue. Finally,
flush thread executes create/update requests and commit logs with
compressed and compacted user data or metadata.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/segment.c      | 1315 +++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/segment.h      |  957 ++++++++++++++++++++++++++++
 fs/ssdfs/segment_tree.c |  748 ++++++++++++++++++++++
 fs/ssdfs/segment_tree.h |   66 ++
 4 files changed, 3086 insertions(+)
 create mode 100644 fs/ssdfs/segment.c
 create mode 100644 fs/ssdfs/segment.h
 create mode 100644 fs/ssdfs/segment_tree.c
 create mode 100644 fs/ssdfs/segment_tree.h

diff --git a/fs/ssdfs/segment.c b/fs/ssdfs/segment.c
new file mode 100644
index 000000000000..6f23c16fe800
--- /dev/null
+++ b/fs/ssdfs/segment.c
@@ -0,0 +1,1315 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment.c - segment concept related functionality.
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
+#include "block_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "peb_container.h"
+#include "segment_bitmap.h"
+#include "segment.h"
+#include "current_segment.h"
+#include "segment_tree.h"
+#include "peb_mapping_table.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_seg_obj_page_leaks;
+atomic64_t ssdfs_seg_obj_memory_leaks;
+atomic64_t ssdfs_seg_obj_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_seg_obj_cache_leaks_increment(void *kaddr)
+ * void ssdfs_seg_obj_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_seg_obj_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_seg_obj_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_seg_obj_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_seg_obj_kfree(void *kaddr)
+ * struct page *ssdfs_seg_obj_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_seg_obj_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_seg_obj_free_page(struct page *page)
+ * void ssdfs_seg_obj_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(seg_obj)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(seg_obj)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_seg_obj_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_seg_obj_page_leaks, 0);
+	atomic64_set(&ssdfs_seg_obj_memory_leaks, 0);
+	atomic64_set(&ssdfs_seg_obj_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_seg_obj_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_seg_obj_page_leaks) != 0) {
+		SSDFS_ERR("SEGMENT: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_seg_obj_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_seg_obj_memory_leaks) != 0) {
+		SSDFS_ERR("SEGMENT: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_seg_obj_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_seg_obj_cache_leaks) != 0) {
+		SSDFS_ERR("SEGMENT: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_seg_obj_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static struct kmem_cache *ssdfs_seg_obj_cachep;
+
+static void ssdfs_init_seg_object_once(void *obj)
+{
+	struct ssdfs_segment_info *seg_obj = obj;
+
+	atomic_set(&seg_obj->refs_count, 0);
+}
+
+void ssdfs_shrink_seg_obj_cache(void)
+{
+	if (ssdfs_seg_obj_cachep)
+		kmem_cache_shrink(ssdfs_seg_obj_cachep);
+}
+
+void ssdfs_zero_seg_obj_cache_ptr(void)
+{
+	ssdfs_seg_obj_cachep = NULL;
+}
+
+void ssdfs_destroy_seg_obj_cache(void)
+{
+	if (ssdfs_seg_obj_cachep)
+		kmem_cache_destroy(ssdfs_seg_obj_cachep);
+}
+
+int ssdfs_init_seg_obj_cache(void)
+{
+	ssdfs_seg_obj_cachep = kmem_cache_create("ssdfs_seg_obj_cache",
+					sizeof(struct ssdfs_segment_info), 0,
+					SLAB_RECLAIM_ACCOUNT |
+					SLAB_MEM_SPREAD |
+					SLAB_ACCOUNT,
+					ssdfs_init_seg_object_once);
+	if (!ssdfs_seg_obj_cachep) {
+		SSDFS_ERR("unable to create segment objects cache\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/******************************************************************************
+ *                       SEGMENT OBJECT FUNCTIONALITY                         *
+ ******************************************************************************/
+
+/*
+ * ssdfs_segment_allocate_object() - allocate segment object
+ * @seg_id: segment number
+ *
+ * This function tries to allocate segment object.
+ *
+ * RETURN:
+ * [success] - pointer on allocated segment object
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ */
+struct ssdfs_segment_info *ssdfs_segment_allocate_object(u64 seg_id)
+{
+	struct ssdfs_segment_info *ptr;
+
+	ptr = kmem_cache_alloc(ssdfs_seg_obj_cachep, GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate memory for segment %llu\n",
+			  seg_id);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ssdfs_seg_obj_cache_leaks_increment(ptr);
+
+	memset(ptr, 0, sizeof(struct ssdfs_segment_info));
+	atomic_set(&ptr->obj_state, SSDFS_SEG_OBJECT_UNDER_CREATION);
+	atomic_set(&ptr->activity_type, SSDFS_SEG_OBJECT_NO_ACTIVITY);
+	ptr->seg_id = seg_id;
+	atomic_set(&ptr->refs_count, 0);
+	init_waitqueue_head(&ptr->object_queue);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("segment object %p, seg_id %llu\n",
+		  ptr, seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ptr;
+}
+
+/*
+ * ssdfs_segment_free_object() - free segment object
+ * @si: pointer on segment object
+ *
+ * This function tries to free segment object.
+ */
+void ssdfs_segment_free_object(struct ssdfs_segment_info *si)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("segment object %p\n", si);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!si)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu\n", si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&si->obj_state)) {
+	case SSDFS_SEG_OBJECT_UNDER_CREATION:
+	case SSDFS_SEG_OBJECT_CREATED:
+	case SSDFS_CURRENT_SEG_OBJECT:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected segment object's state %#x\n",
+			   atomic_read(&si->obj_state));
+		break;
+	}
+
+	switch (atomic_read(&si->activity_type)) {
+	case SSDFS_SEG_OBJECT_NO_ACTIVITY:
+	case SSDFS_SEG_OBJECT_REGULAR_ACTIVITY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected segment object's activity %#x\n",
+			   atomic_read(&si->activity_type));
+		break;
+	}
+
+	ssdfs_seg_obj_cache_leaks_decrement(si);
+	kmem_cache_free(ssdfs_seg_obj_cachep, si);
+}
+
+/*
+ * ssdfs_segment_destroy_object() - destroy segment object
+ * @si: pointer on segment object
+ *
+ * This function tries to destroy segment object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EBUSY      - segment object is referenced yet.
+ * %-EIO        - I/O error.
+ */
+int ssdfs_segment_destroy_object(struct ssdfs_segment_info *si)
+{
+	int refs_count;
+	int err = 0;
+
+	if (!si)
+		return 0;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, seg_state %#x, log_pages %u, "
+		  "create_threads %u\n",
+		  si->seg_id, atomic_read(&si->seg_state),
+		  si->log_pages, si->create_threads);
+	SSDFS_ERR("obj_state %#x\n",
+		  atomic_read(&si->obj_state));
+#else
+	SSDFS_DBG("seg %llu, seg_state %#x, log_pages %u, "
+		  "create_threads %u\n",
+		  si->seg_id, atomic_read(&si->seg_state),
+		  si->log_pages, si->create_threads);
+	SSDFS_DBG("obj_state %#x\n",
+		  atomic_read(&si->obj_state));
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (atomic_read(&si->obj_state)) {
+	case SSDFS_SEG_OBJECT_UNDER_CREATION:
+	case SSDFS_SEG_OBJECT_CREATED:
+	case SSDFS_CURRENT_SEG_OBJECT:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected segment object's state %#x\n",
+			   atomic_read(&si->obj_state));
+		break;
+	}
+
+	refs_count = atomic_read(&si->refs_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("si %p, seg %llu, refs_count %d\n",
+		  si, si->seg_id, refs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (refs_count != 0) {
+		wait_queue_head_t *wq = &si->object_queue;
+
+		err = wait_event_killable_timeout(*wq,
+				atomic_read(&si->refs_count) <= 0,
+				SSDFS_DEFAULT_TIMEOUT);
+		if (err < 0) {
+			WARN_ON(err < 0);
+		} else
+			err = 0;
+
+		if (atomic_read(&si->refs_count) != 0) {
+			SSDFS_WARN("unable to destroy object of segment %llu: "
+				   "refs_count %d\n",
+				   si->seg_id, refs_count);
+			return -EBUSY;
+		}
+	}
+
+	ssdfs_sysfs_delete_seg_group(si);
+
+	if (si->peb_array) {
+		struct ssdfs_peb_container *pebc;
+		int i;
+
+		for (i = 0; i < si->pebs_count; i++) {
+			pebc = &si->peb_array[i];
+			ssdfs_peb_container_destroy(pebc);
+		}
+
+		ssdfs_seg_obj_kfree(si->peb_array);
+	}
+
+	ssdfs_segment_blk_bmap_destroy(&si->blk_bmap);
+
+	if (si->blk2off_table)
+		ssdfs_blk2off_table_destroy(si->blk2off_table);
+
+	if (!is_ssdfs_requests_queue_empty(&si->create_rq)) {
+		SSDFS_WARN("create queue is not empty\n");
+		ssdfs_requests_queue_remove_all(&si->create_rq, -ENOSPC);
+	}
+
+	ssdfs_segment_free_object(si);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_create_object() - create segment object
+ * @fsi: pointer on shared file system object
+ * @seg: segment number
+ * @seg_state: segment state
+ * @seg_type: segment type
+ * @log_pages: count of pages in log
+ * @create_threads: number of flush PEB's threads for new page requests
+ * @si: pointer on segment object [in|out]
+ *
+ * This function tries to create segment object for @seg
+ * identification number.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_create_object(struct ssdfs_fs_info *fsi,
+				u64 seg,
+				int seg_state,
+				u16 seg_type,
+				u16 log_pages,
+				u8 create_threads,
+				struct ssdfs_segment_info *si)
+{
+	int state = SSDFS_BLK2OFF_OBJECT_CREATED;
+	struct ssdfs_migration_destination *destination;
+	int refs_count = fsi->pebs_per_seg;
+	int destination_pebs = 0;
+	int init_flag, init_state;
+	u32 logical_blk_capacity;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !si);
+
+	if (seg_state >= SSDFS_SEG_STATE_MAX) {
+		SSDFS_ERR("invalid segment state %#x\n", seg_state);
+		return -EINVAL;
+	}
+
+	if (seg_type > SSDFS_LAST_KNOWN_SEG_TYPE) {
+		SSDFS_ERR("invalid segment type %#x\n", seg_type);
+		return -EINVAL;
+	}
+
+	if (create_threads > fsi->pebs_per_seg ||
+	    fsi->pebs_per_seg % create_threads) {
+		SSDFS_ERR("invalid create threads count %u\n",
+			  create_threads);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, seg %llu, seg_state %#x, log_pages %u, "
+		  "create_threads %u\n",
+		  fsi, seg, seg_state, log_pages, create_threads);
+#else
+	SSDFS_DBG("fsi %p, seg %llu, seg_state %#x, log_pages %u, "
+		  "create_threads %u\n",
+		  fsi, seg, seg_state, log_pages, create_threads);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (seg >= fsi->nsegs) {
+		SSDFS_ERR("requested seg %llu >= nsegs %llu\n",
+			  seg, fsi->nsegs);
+		return -EINVAL;
+	}
+
+	switch (atomic_read(&si->obj_state)) {
+	case SSDFS_SEG_OBJECT_UNDER_CREATION:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid segment object's state %#x\n",
+			   atomic_read(&si->obj_state));
+		ssdfs_segment_free_object(si);
+		return -EINVAL;
+	}
+
+	si->seg_id = seg;
+	si->seg_type = seg_type;
+	si->log_pages = log_pages;
+	si->create_threads = create_threads;
+	si->fsi = fsi;
+	atomic_set(&si->seg_state, seg_state);
+	ssdfs_requests_queue_init(&si->create_rq);
+
+	spin_lock_init(&si->protection.cno_lock);
+	si->protection.create_cno = ssdfs_current_cno(fsi->sb);
+	si->protection.last_request_cno = si->protection.create_cno;
+	si->protection.reqs_count = 0;
+	si->protection.protected_range = 0;
+	si->protection.future_request_cno = si->protection.create_cno;
+
+	spin_lock_init(&si->pending_lock);
+	si->pending_new_user_data_pages = 0;
+	si->invalidated_user_data_pages = 0;
+
+	si->pebs_count = fsi->pebs_per_seg;
+	si->peb_array = ssdfs_seg_obj_kcalloc(si->pebs_count,
+				       sizeof(struct ssdfs_peb_container),
+				       GFP_KERNEL);
+	if (!si->peb_array) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate memory for peb array\n");
+		goto destroy_seg_obj;
+	}
+
+	atomic_set(&si->migration.migrating_pebs, 0);
+	spin_lock_init(&si->migration.lock);
+
+	destination = &si->migration.array[SSDFS_LAST_DESTINATION];
+	destination->state = SSDFS_EMPTY_DESTINATION;
+	destination->destination_pebs = 0;
+	destination->shared_peb_index = -1;
+
+	destination = &si->migration.array[SSDFS_CREATING_DESTINATION];
+	destination->state = SSDFS_EMPTY_DESTINATION;
+	destination->destination_pebs = 0;
+	destination->shared_peb_index = -1;
+
+	for (i = 0; i < SSDFS_PEB_THREAD_TYPE_MAX; i++)
+		init_waitqueue_head(&si->wait_queue[i]);
+
+	if (seg_state == SSDFS_SEG_CLEAN) {
+		state = SSDFS_BLK2OFF_OBJECT_COMPLETE_INIT;
+		init_flag = SSDFS_BLK_BMAP_CREATE;
+		init_state = SSDFS_BLK_FREE;
+	} else {
+		init_flag = SSDFS_BLK_BMAP_INIT;
+		init_state = SSDFS_BLK_STATE_MAX;
+	}
+
+	logical_blk_capacity = fsi->leb_pages_capacity * fsi->pebs_per_seg;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create segment block bitmap: seg %llu\n", seg);
+#else
+	SSDFS_DBG("create segment block bitmap: seg %llu\n", seg);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_segment_blk_bmap_create(si, init_flag, init_state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create segment block bitmap: "
+			  "err %d\n", err);
+		goto destroy_seg_obj;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create blk2off table: seg %llu\n", seg);
+#else
+	SSDFS_DBG("create blk2off table: seg %llu\n", seg);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	si->blk2off_table = ssdfs_blk2off_table_create(fsi,
+							logical_blk_capacity,
+							SSDFS_SEG_OFF_TABLE,
+							state);
+	if (!si->blk2off_table) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate memory for translation table\n");
+		goto destroy_seg_obj;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create PEB containers: seg %llu\n", seg);
+#else
+	SSDFS_DBG("create PEB containers: seg %llu\n", seg);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	for (i = 0; i < si->pebs_count; i++) {
+		err = ssdfs_peb_container_create(fsi, seg, i,
+						  SEG2PEB_TYPE(seg_type),
+						  log_pages, si);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			goto destroy_seg_obj;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to create PEB container: "
+				  "seg %llu, peb index %d, err %d\n",
+				  seg, i, err);
+			goto destroy_seg_obj;
+		}
+	}
+
+	for (i = 0; i < si->pebs_count; i++) {
+		int cur_refs = atomic_read(&si->peb_array[i].dst_peb_refs);
+		int items_state = atomic_read(&si->peb_array[i].items_state);
+
+		switch (items_state) {
+		case SSDFS_PEB1_DST_CONTAINER:
+		case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+		case SSDFS_PEB2_DST_CONTAINER:
+		case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+			destination_pebs++;
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		if (cur_refs == 0)
+			continue;
+
+		if (cur_refs < refs_count)
+			refs_count = cur_refs;
+	}
+
+	destination = &si->migration.array[SSDFS_LAST_DESTINATION];
+	spin_lock(&si->migration.lock);
+	destination->shared_peb_index = refs_count;
+	destination->destination_pebs = destination_pebs;
+	destination->state = SSDFS_VALID_DESTINATION;
+	spin_unlock(&si->migration.lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("get free pages: seg %llu\n", seg);
+#else
+	SSDFS_DBG("get free pages: seg %llu\n", seg);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	/*
+	 * The goal of this cycle is to finish segment object
+	 * initialization. The segment object should have
+	 * valid value of free blocks number.
+	 * The ssdfs_peb_get_free_pages() method waits the
+	 * ending of PEB object complete initialization.
+	 */
+	for (i = 0; i < si->pebs_count; i++) {
+		int peb_free_pages;
+		struct ssdfs_peb_container *pebc = &si->peb_array[i];
+
+		if (is_peb_container_empty(pebc)) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("segment %llu hasn't PEB %d\n",
+				  seg, i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		peb_free_pages = ssdfs_peb_get_free_pages(pebc);
+		if (unlikely(peb_free_pages < 0)) {
+			err = peb_free_pages;
+			SSDFS_ERR("fail to calculate PEB's free pages: "
+				  "seg %llu, peb index %d, err %d\n",
+				  seg, i, err);
+			goto destroy_seg_obj;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("create sysfs group: seg %llu\n", seg);
+#else
+	SSDFS_DBG("create sysfs group: seg %llu\n", seg);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	err = ssdfs_sysfs_create_seg_group(si);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create segment's sysfs group: "
+			  "seg %llu, err %d\n",
+			  seg, err);
+		goto destroy_seg_obj;
+	}
+
+	atomic_set(&si->obj_state, SSDFS_SEG_OBJECT_CREATED);
+	atomic_set(&si->activity_type, SSDFS_SEG_OBJECT_REGULAR_ACTIVITY);
+	wake_up_all(&si->object_queue);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("segment %llu has been created\n",
+		  seg);
+#else
+	SSDFS_DBG("segment %llu has been created\n",
+		  seg);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+destroy_seg_obj:
+	atomic_set(&si->obj_state, SSDFS_SEG_OBJECT_FAILURE);
+	wake_up_all(&si->object_queue);
+	ssdfs_segment_destroy_object(si);
+	return err;
+}
+
+/*
+ * ssdfs_segment_get_object() - increment segment's reference counter
+ * @si: pointer on segment object
+ */
+void ssdfs_segment_get_object(struct ssdfs_segment_info *si)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+
+	SSDFS_DBG("seg_id %llu, refs_count %d\n",
+		  si->seg_id, atomic_read(&si->refs_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	WARN_ON(atomic_inc_return(&si->refs_count) <= 0);
+}
+
+/*
+ * ssdfs_segment_put_object() - decerement segment's reference counter
+ * @si: pointer on segment object
+ */
+void ssdfs_segment_put_object(struct ssdfs_segment_info *si)
+{
+	if (!si)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, refs_count %d\n",
+		  si->seg_id, atomic_read(&si->refs_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	WARN_ON(atomic_dec_return(&si->refs_count) < 0);
+
+	if (atomic_read(&si->refs_count) <= 0)
+		wake_up_all(&si->object_queue);
+}
+
+/*
+ * ssdfs_segment_detect_search_range() - detect search range
+ * @fsi: pointer on shared file system object
+ * @start_seg: starting ID for segment search [in|out]
+ * @end_seg: ending ID for segment search [out]
+ *
+ * This method tries to detect the search range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - unable to find valid range for search.
+ */
+int ssdfs_segment_detect_search_range(struct ssdfs_fs_info *fsi,
+				      u64 *start_seg, u64 *end_seg)
+{
+	struct completion *init_end;
+	u64 start_leb;
+	u64 end_leb;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !start_seg || !end_seg);
+
+	SSDFS_DBG("fsi %p, start_search_id %llu\n",
+		  fsi, *start_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (*start_seg >= fsi->nsegs) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_seg %llu >= nsegs %llu\n",
+			  *start_seg, fsi->nsegs);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+	start_leb = ssdfs_get_leb_id_for_peb_index(fsi, *start_seg, 0);
+	if (start_leb >= U64_MAX) {
+		SSDFS_ERR("invalid leb_id for seg_id %llu\n",
+			  *start_seg);
+		return -ERANGE;
+	}
+
+	err = ssdfs_maptbl_recommend_search_range(fsi, &start_leb,
+						  &end_leb, &init_end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			goto finish_seg_id_correction;
+		}
+
+		start_leb = ssdfs_get_leb_id_for_peb_index(fsi, *start_seg, 0);
+		if (start_leb >= U64_MAX) {
+			SSDFS_ERR("invalid leb_id for seg_id %llu\n",
+				  *start_seg);
+			return -ERANGE;
+		}
+
+		err = ssdfs_maptbl_recommend_search_range(fsi, &start_leb,
+							  &end_leb, &init_end);
+	}
+
+	if (err == -ENOENT) {
+		*start_seg = U64_MAX;
+		*end_seg = U64_MAX;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find search range: leb_id %llu\n",
+			  start_leb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_seg_id_correction;
+	} else if (unlikely(err)) {
+		*start_seg = U64_MAX;
+		*end_seg = U64_MAX;
+		SSDFS_ERR("fail to find search range: "
+			  "leb_id %llu, err %d\n",
+			  start_leb, err);
+		goto finish_seg_id_correction;
+	}
+
+	*start_seg = SSDFS_LEB2SEG(fsi, start_leb);
+	*end_seg = SSDFS_LEB2SEG(fsi, end_leb);
+
+finish_seg_id_correction:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_seg %llu, end_seg %llu, err %d\n",
+		  *start_seg, *end_seg, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * __ssdfs_find_new_segment() - find a new segment
+ * @fsi: pointer on shared file system object
+ * @seg_type: segment type
+ * @start_search_id: starting ID for segment search
+ * @seg_id: found segment ID [out]
+ * @seg_state: found segment state [out]
+ *
+ * This method tries to find a new segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - unable to find a new segment.
+ */
+static
+int __ssdfs_find_new_segment(struct ssdfs_fs_info *fsi, int seg_type,
+			     u64 start_search_id, u64 *seg_id,
+			     int *seg_state)
+{
+	int new_state;
+	u64 start_seg = start_search_id;
+	u64 end_seg = U64_MAX;
+	struct completion *init_end;
+	int res;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !seg_id || !seg_state);
+
+	SSDFS_DBG("fsi %p, seg_type %#x, start_search_id %llu\n",
+		  fsi, seg_type, start_search_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*seg_id = U64_MAX;
+	*seg_state = SSDFS_SEG_STATE_MAX;
+
+	switch (seg_type) {
+	case SSDFS_USER_DATA_SEG_TYPE:
+		new_state = SSDFS_SEG_DATA_USING;
+		break;
+
+	case SSDFS_LEAF_NODE_SEG_TYPE:
+		new_state = SSDFS_SEG_LEAF_NODE_USING;
+		break;
+
+	case SSDFS_HYBRID_NODE_SEG_TYPE:
+		new_state = SSDFS_SEG_HYBRID_NODE_USING;
+		break;
+
+	case SSDFS_INDEX_NODE_SEG_TYPE:
+		new_state = SSDFS_SEG_INDEX_NODE_USING;
+		break;
+
+	default:
+		BUG();
+	};
+
+	err = ssdfs_segment_detect_search_range(fsi,
+						&start_seg,
+						&end_seg);
+	if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find fragment for search: "
+			  "start_seg %llu, end_seg %llu\n",
+			  start_seg, end_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_search;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to define a search range: "
+			  "start_search_id %llu, err %d\n",
+			  start_search_id, err);
+		goto finish_search;
+	}
+
+	res = ssdfs_segbmap_find_and_set(fsi->segbmap,
+					 start_seg, end_seg,
+					 SSDFS_SEG_CLEAN,
+					 SEG_TYPE2MASK(seg_type),
+					 new_state,
+					 seg_id, &init_end);
+	if (res >= 0) {
+		/* Define segment state */
+		*seg_state = res;
+	} else if (res == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("segbmap init failed: "
+				  "err %d\n", err);
+			goto finish_search;
+		}
+
+		res = ssdfs_segbmap_find_and_set(fsi->segbmap,
+						 start_seg, end_seg,
+						 SSDFS_SEG_CLEAN,
+						 SEG_TYPE2MASK(seg_type),
+						 new_state,
+						 seg_id, &init_end);
+		if (res >= 0) {
+			/* Define segment state */
+			*seg_state = res;
+		} else if (res == -ENODATA) {
+			err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find segment in range: "
+				  "start_seg %llu, end_seg %llu\n",
+				  start_seg, end_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_search;
+		} else {
+			err = res;
+			SSDFS_ERR("fail to find segment in range: "
+				  "start_seg %llu, end_seg %llu, err %d\n",
+				  start_seg, end_seg, res);
+			goto finish_search;
+		}
+	} else if (res == -ENODATA) {
+		err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find segment in range: "
+			  "start_seg %llu, end_seg %llu\n",
+			  start_seg, end_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_search;
+	} else {
+		SSDFS_ERR("fail to find segment in range: "
+			  "start_seg %llu, end_seg %llu, err %d\n",
+			  start_seg, end_seg, res);
+		goto finish_search;
+	}
+
+finish_search:
+	if (err == -ENOENT)
+		*seg_id = end_seg;
+
+	return err;
+}
+
+/*
+ * ssdfs_find_new_segment() - find a new segment
+ * @fsi: pointer on shared file system object
+ * @seg_type: segment type
+ * @start_search_id: starting ID for segment search
+ * @seg_id: found segment ID [out]
+ * @seg_state: found segment state [out]
+ *
+ * This method tries to find a new segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - unable to find a new segment.
+ */
+static
+int ssdfs_find_new_segment(struct ssdfs_fs_info *fsi, int seg_type,
+			   u64 start_search_id, u64 *seg_id,
+			   int *seg_state)
+{
+	u64 cur_id = start_search_id;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !seg_id || !seg_state);
+
+	SSDFS_DBG("fsi %p, seg_type %#x, start_search_id %llu\n",
+		  fsi, seg_type, start_search_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	while (cur_id < fsi->nsegs) {
+		err = __ssdfs_find_new_segment(fsi, seg_type, cur_id,
+						seg_id, seg_state);
+		if (err == -ENOENT) {
+			err = 0;
+			cur_id = *seg_id;
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find a new segment: "
+				  "cur_id %llu, err %d\n",
+				  cur_id, err);
+			return err;
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("found seg_id %llu\n", *seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return 0;
+		}
+	}
+
+	cur_id = 0;
+
+	while (cur_id < start_search_id) {
+		err = __ssdfs_find_new_segment(fsi, seg_type, cur_id,
+						seg_id, seg_state);
+		if (err == -ENOENT) {
+			err = 0;
+			cur_id = *seg_id;
+			continue;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find a new segment: "
+				  "cur_id %llu, err %d\n",
+				  cur_id, err);
+			return err;
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("found seg_id %llu\n", *seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return 0;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("no free space for a new segment\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return -ENOSPC;
+}
+
+/*
+ * __ssdfs_create_new_segment() - create new segment and add into the tree
+ * @fsi: pointer on shared file system object
+ * @seg_id: segment number
+ * @seg_state: segment state
+ * @seg_type: segment type
+ * @log_pages: count of pages in log
+ * @create_threads: number of flush PEB's threads for new page requests
+ *
+ * This function tries to create segment object for @seg
+ * identification number.
+ *
+ * RETURN:
+ * [success] - pointer on created segment object
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+struct ssdfs_segment_info *
+__ssdfs_create_new_segment(struct ssdfs_fs_info *fsi,
+			   u64 seg_id, int seg_state,
+			   u16 seg_type, u16 log_pages,
+			   u8 create_threads)
+{
+	struct ssdfs_segment_info *si;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	if (seg_state >= SSDFS_SEG_STATE_MAX) {
+		SSDFS_ERR("invalid segment state %#x\n", seg_state);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (seg_type > SSDFS_LAST_KNOWN_SEG_TYPE) {
+		SSDFS_ERR("invalid segment type %#x\n", seg_type);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (create_threads > fsi->pebs_per_seg ||
+	    fsi->pebs_per_seg % create_threads) {
+		SSDFS_ERR("invalid create threads count %u\n",
+			  create_threads);
+		return ERR_PTR(-EINVAL);
+	}
+
+	SSDFS_DBG("fsi %p, seg %llu, seg_state %#x, log_pages %u, "
+		  "create_threads %u\n",
+		  fsi, seg_id, seg_state, log_pages, create_threads);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = ssdfs_segment_allocate_object(seg_id);
+	if (IS_ERR_OR_NULL(si)) {
+		SSDFS_ERR("fail to allocate segment: "
+			  "seg %llu, err %ld\n",
+			  seg_id, PTR_ERR(si));
+		return si;
+	}
+
+	err = ssdfs_segment_tree_add(fsi, si);
+	if (err == -EEXIST) {
+		wait_queue_head_t *wq = &si->object_queue;
+
+		ssdfs_segment_free_object(si);
+
+		si = ssdfs_segment_tree_find(fsi, seg_id);
+		if (IS_ERR_OR_NULL(si)) {
+			SSDFS_ERR("fail to find segment: "
+				  "seg %llu, err %d\n",
+				  seg_id, err);
+			return ERR_PTR(err);
+		}
+
+		ssdfs_segment_get_object(si);
+
+		err = wait_event_killable_timeout(*wq,
+				is_ssdfs_segment_created(si),
+				SSDFS_DEFAULT_TIMEOUT);
+		if (err < 0) {
+			WARN_ON(err < 0);
+		} else
+			err = 0;
+
+		switch (atomic_read(&si->obj_state)) {
+		case SSDFS_SEG_OBJECT_CREATED:
+		case SSDFS_CURRENT_SEG_OBJECT:
+			/* do nothing */
+			break;
+
+		default:
+			ssdfs_segment_put_object(si);
+			SSDFS_ERR("fail to create segment: "
+				  "seg %llu\n",
+				  seg_id);
+			return ERR_PTR(-ERANGE);
+		}
+
+		return si;
+	} else if (unlikely(err)) {
+		ssdfs_segment_free_object(si);
+		SSDFS_ERR("fail to add segment into tree: "
+			  "seg %llu, err %d\n",
+			  seg_id, err);
+		return ERR_PTR(err);
+	} else {
+		err = ssdfs_segment_create_object(fsi,
+						  seg_id,
+						  seg_state,
+						  seg_type,
+						  log_pages,
+						  create_threads,
+						  si);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			return ERR_PTR(err);
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to create segment: "
+				  "seg %llu, err %d\n",
+				  seg_id, err);
+			return ERR_PTR(err);
+		}
+	}
+
+	ssdfs_segment_get_object(si);
+	return si;
+}
+
+/*
+ * ssdfs_grab_segment() - get or create segment object
+ * @fsi: pointer on shared file system object
+ * @seg_type: type of segment
+ * @seg_id: segment number
+ * @start_search_id: starting ID for segment search
+ *
+ * This method tries to get or to create segment object of
+ * @seg_type. If @seg_id is U64_MAX then it needs to find
+ * segment that will be in "clean" or "using" state.
+ * The @start_search_id is defining the range for search.
+ * If this value is equal to U64_MAX then it is ignored.
+ * The found segment number should be used for segment object
+ * creation and adding into the segment tree. Otherwise,
+ * if @seg_id contains valid segment number, the method should try
+ * to find segment object in the segments tree. If the segment
+ * object is not found then segment state will be detected via
+ * segment bitmap, segment object will be created and to be added
+ * into the segment tree. Finally, reference counter of segment
+ * object will be incremented.
+ *
+ * RETURN:
+ * [success] - pointer on segment object.
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+struct ssdfs_segment_info *
+ssdfs_grab_segment(struct ssdfs_fs_info *fsi, int seg_type, u64 seg_id,
+		   u64 start_search_id)
+{
+	struct ssdfs_segment_info *si;
+	int seg_state = SSDFS_SEG_STATE_MAX;
+	struct completion *init_end;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+	BUG_ON(seg_type != SSDFS_LEAF_NODE_SEG_TYPE &&
+		seg_type != SSDFS_HYBRID_NODE_SEG_TYPE &&
+		seg_type != SSDFS_INDEX_NODE_SEG_TYPE &&
+		seg_type != SSDFS_USER_DATA_SEG_TYPE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, seg_type %#x, "
+		  "seg_id %llu, start_search_id %llu\n",
+		  fsi, seg_type, seg_id, start_search_id);
+#else
+	SSDFS_DBG("fsi %p, seg_type %#x, "
+		  "seg_id %llu, start_search_id %llu\n",
+		  fsi, seg_type, seg_id, start_search_id);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (seg_id == U64_MAX) {
+		err = ssdfs_find_new_segment(fsi, seg_type,
+					     start_search_id,
+					     &seg_id, &seg_state);
+		if (err == -ENOSPC) {
+			SSDFS_DBG("no free space for a new segment\n");
+			return ERR_PTR(err);
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find a new segment: "
+				  "start_search_id %llu, "
+				  "seg_type %#x, err %d\n",
+				  start_search_id, seg_type, err);
+			return ERR_PTR(err);
+		}
+	}
+
+	si = ssdfs_segment_tree_find(fsi, seg_id);
+	if (IS_ERR_OR_NULL(si)) {
+		err = PTR_ERR(si);
+
+		if (err == -ENODATA) {
+			u16 log_pages;
+			u8 create_threads;
+
+			if (seg_state != SSDFS_SEG_STATE_MAX)
+				goto create_segment_object;
+
+			seg_state = ssdfs_segbmap_get_state(fsi->segbmap,
+							    seg_id, &init_end);
+			if (seg_state == -EAGAIN) {
+				err = SSDFS_WAIT_COMPLETION(init_end);
+				if (unlikely(err)) {
+					SSDFS_ERR("segbmap init failed: "
+						  "err %d\n", err);
+					return ERR_PTR(err);
+				}
+
+				seg_state =
+					ssdfs_segbmap_get_state(fsi->segbmap,
+								seg_id,
+								&init_end);
+				if (seg_state < 0)
+					goto fail_define_seg_state;
+			} else if (seg_state < 0) {
+fail_define_seg_state:
+				SSDFS_ERR("fail to define segment state: "
+					  "seg %llu\n",
+					  seg_id);
+				return ERR_PTR(seg_state);
+			}
+
+			switch (seg_state) {
+			case SSDFS_SEG_DATA_USING:
+			case SSDFS_SEG_LEAF_NODE_USING:
+			case SSDFS_SEG_HYBRID_NODE_USING:
+			case SSDFS_SEG_INDEX_NODE_USING:
+			case SSDFS_SEG_USED:
+			case SSDFS_SEG_PRE_DIRTY:
+				/* expected state */
+				break;
+
+			default:
+				err = -ERANGE;
+				SSDFS_ERR("seg %llu has unexpected state %#x\n",
+					  seg_id, seg_state);
+				return ERR_PTR(err);
+			};
+
+create_segment_object:
+			switch (seg_type) {
+			case SSDFS_USER_DATA_SEG_TYPE:
+				log_pages =
+					fsi->segs_tree->user_data_log_pages;
+				break;
+
+			case SSDFS_LEAF_NODE_SEG_TYPE:
+				log_pages =
+					fsi->segs_tree->lnodes_seg_log_pages;
+				break;
+
+			case SSDFS_HYBRID_NODE_SEG_TYPE:
+				log_pages =
+					fsi->segs_tree->hnodes_seg_log_pages;
+				break;
+
+			case SSDFS_INDEX_NODE_SEG_TYPE:
+				log_pages =
+					fsi->segs_tree->inodes_seg_log_pages;
+				break;
+
+			default:
+				log_pages =
+					fsi->segs_tree->default_log_pages;
+				break;
+			};
+
+			create_threads = fsi->create_threads_per_seg;
+			si = __ssdfs_create_new_segment(fsi,
+							seg_id,
+							seg_state,
+							seg_type,
+							log_pages,
+							create_threads);
+			if (IS_ERR_OR_NULL(si)) {
+				err = (si == NULL ? -ENOMEM : PTR_ERR(si));
+				if (err == -EINTR) {
+					/*
+					 * Ignore this error.
+					 */
+				} else {
+					SSDFS_ERR("fail to add new segment: "
+						  "seg %llu, err %d\n",
+						  seg_id, err);
+				}
+			}
+
+			return si;
+		} else if (err == 0) {
+			SSDFS_ERR("segment tree returns NULL\n");
+			return ERR_PTR(-ERANGE);
+		} else {
+			SSDFS_ERR("segment tree fail to find segment: "
+				  "seg %llu, err %d\n",
+				  seg_id, err);
+			return ERR_PTR(err);
+		}
+	}
+
+	ssdfs_segment_get_object(si);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return si;
+}
diff --git a/fs/ssdfs/segment.h b/fs/ssdfs/segment.h
new file mode 100644
index 000000000000..cf11f5e5b04f
--- /dev/null
+++ b/fs/ssdfs/segment.h
@@ -0,0 +1,957 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment.h - segment concept declarations.
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
+#ifndef _SSDFS_SEGMENT_H
+#define _SSDFS_SEGMENT_H
+
+#include "peb.h"
+#include "segment_block_bitmap.h"
+
+/* Available indexes for destination */
+enum {
+	SSDFS_LAST_DESTINATION,
+	SSDFS_CREATING_DESTINATION,
+	SSDFS_DESTINATION_MAX
+};
+
+/* Possible states of destination descriptor */
+enum {
+	SSDFS_EMPTY_DESTINATION,
+	SSDFS_DESTINATION_UNDER_CREATION,
+	SSDFS_VALID_DESTINATION,
+	SSDFS_OBSOLETE_DESTINATION,
+	SSDFS_DESTINATION_STATE_MAX
+};
+
+/*
+ * struct ssdfs_migration_destination - destination descriptor
+ * @state: descriptor's state
+ * @destination_pebs: count of destination PEBs for migration
+ * @shared_peb_index: shared index of destination PEB for migration
+ */
+struct ssdfs_migration_destination {
+	int state;
+	int destination_pebs;
+	int shared_peb_index;
+};
+
+/*
+ * struct ssdfs_segment_migration_info - migration info
+ * @migrating_pebs: count of migrating PEBs
+ * @lock: migration data lock
+ * @array: destination descriptors
+ */
+struct ssdfs_segment_migration_info {
+	atomic_t migrating_pebs;
+
+	spinlock_t lock;
+	struct ssdfs_migration_destination array[SSDFS_DESTINATION_MAX];
+};
+
+/*
+ * struct ssdfs_segment_info - segment object description
+ * @seg_id: segment identification number
+ * @log_pages: count of pages in full partial log
+ * @create_threads: number of flush PEB's threads for new page requests
+ * @seg_type: segment type
+ * @protection: segment's protection window
+ * @seg_state: current state of segment
+ * @obj_state: segment object's state
+ * @activity_type: type of activity with segment object
+ * @peb_array: array of PEB's descriptors
+ * @pebs_count: count of items in PEBS array
+ * @migration: migration info
+ * @refs_count: counter of references on segment object
+ * @object_queue: wait queue for segment creation/destruction
+ * @create_rq: new page requests queue
+ * @pending_lock: lock of pending pages' counter
+ * @pending_new_user_data_pages: counter of pending new user data pages
+ * @invalidated_user_data_pages: counter of invalidated user data pages
+ * @wait_queue: array of PEBs' wait queues
+ * @blk_bmap: segment's block bitmap
+ * @blk2off_table: offset translation table
+ * @fsi: pointer on shared file system object
+ * @seg_kobj: /sys/fs/ssdfs/<device>/segments/<segN> kernel object
+ * @seg_kobj_unregister: completion state for <segN> kernel object
+ * @pebs_kobj: /sys/fs/<ssdfs>/<device>/segments/<segN>/pebs kernel object
+ * @pebs_kobj_unregister: completion state for pebs kernel object
+ */
+struct ssdfs_segment_info {
+	/* Static data */
+	u64 seg_id;
+	u16 log_pages;
+	u8 create_threads;
+	u16 seg_type;
+
+	/* Checkpoints set */
+	struct ssdfs_protection_window protection;
+
+	/* Mutable data */
+	atomic_t seg_state;
+	atomic_t obj_state;
+	atomic_t activity_type;
+
+	/* Segment's PEB's containers array */
+	struct ssdfs_peb_container *peb_array;
+	u16 pebs_count;
+
+	/* Migration info */
+	struct ssdfs_segment_migration_info migration;
+
+	/* Reference counter */
+	atomic_t refs_count;
+	wait_queue_head_t object_queue;
+
+	/*
+	 * New pages processing:
+	 * requests queue, wait queue
+	 */
+	struct ssdfs_requests_queue create_rq;
+
+	spinlock_t pending_lock;
+	u32 pending_new_user_data_pages;
+	u32 invalidated_user_data_pages;
+
+	/* Threads' wait queues */
+	wait_queue_head_t wait_queue[SSDFS_PEB_THREAD_TYPE_MAX];
+
+	struct ssdfs_segment_blk_bmap blk_bmap;
+	struct ssdfs_blk2off_table *blk2off_table;
+	struct ssdfs_fs_info *fsi;
+
+	/* /sys/fs/ssdfs/<device>/segments/<segN> */
+	struct kobject *seg_kobj;
+	struct kobject seg_kobj_buf;
+	struct completion seg_kobj_unregister;
+
+	/* /sys/fs/<ssdfs>/<device>/segments/<segN>/pebs */
+	struct kobject pebs_kobj;
+	struct completion pebs_kobj_unregister;
+};
+
+/* Segment object states */
+enum {
+	SSDFS_SEG_OBJECT_UNKNOWN_STATE,
+	SSDFS_SEG_OBJECT_UNDER_CREATION,
+	SSDFS_SEG_OBJECT_CREATED,
+	SSDFS_CURRENT_SEG_OBJECT,
+	SSDFS_SEG_OBJECT_FAILURE,
+	SSDFS_SEG_OBJECT_STATE_MAX
+};
+
+/* Segment object's activity type */
+enum {
+	SSDFS_SEG_OBJECT_NO_ACTIVITY,
+	SSDFS_SEG_OBJECT_REGULAR_ACTIVITY,
+	SSDFS_SEG_UNDER_GC_ACTIVITY,
+	SSDFS_SEG_UNDER_INVALIDATION,
+	SSDFS_SEG_OBJECT_ACTIVITY_TYPE_MAX
+};
+
+/*
+ * Inline functions
+ */
+
+/*
+ * is_ssdfs_segment_created() - check that segment object is created
+ *
+ * This function returns TRUE for the case of successful
+ * creation of segment's object or failure of the creation.
+ * The responsibility of the caller to check that
+ * segment object has been created successfully.
+ */
+static inline
+bool is_ssdfs_segment_created(struct ssdfs_segment_info *si)
+{
+	bool is_created = false;
+
+	switch (atomic_read(&si->obj_state)) {
+	case SSDFS_SEG_OBJECT_CREATED:
+	case SSDFS_CURRENT_SEG_OBJECT:
+	case SSDFS_SEG_OBJECT_FAILURE:
+		is_created = true;
+		break;
+
+	default:
+		is_created = false;
+		break;
+	}
+
+	return is_created;
+}
+
+/*
+ * CUR_SEG_TYPE() - convert request class into current segment type
+ */
+static inline
+int CUR_SEG_TYPE(int req_class)
+{
+	int cur_seg_type = SSDFS_CUR_SEGS_COUNT;
+
+	switch (req_class) {
+	case SSDFS_PEB_PRE_ALLOCATE_DATA_REQ:
+	case SSDFS_PEB_CREATE_DATA_REQ:
+		cur_seg_type = SSDFS_CUR_DATA_SEG;
+		break;
+
+	case SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ:
+	case SSDFS_PEB_CREATE_LNODE_REQ:
+		cur_seg_type = SSDFS_CUR_LNODE_SEG;
+		break;
+
+	case SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ:
+	case SSDFS_PEB_CREATE_HNODE_REQ:
+		cur_seg_type = SSDFS_CUR_HNODE_SEG;
+		break;
+
+	case SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ:
+	case SSDFS_PEB_CREATE_IDXNODE_REQ:
+		cur_seg_type = SSDFS_CUR_IDXNODE_SEG;
+		break;
+
+	case SSDFS_ZONE_USER_DATA_MIGRATE_REQ:
+		cur_seg_type = SSDFS_CUR_DATA_UPDATE_SEG;
+		break;
+
+	default:
+		BUG();
+	}
+
+	return cur_seg_type;
+}
+
+/*
+ * SEG_TYPE() - convert request class into segment type
+ */
+static inline
+int SEG_TYPE(int req_class)
+{
+	int seg_type = SSDFS_LAST_KNOWN_SEG_TYPE;
+
+	switch (req_class) {
+	case SSDFS_PEB_PRE_ALLOCATE_DATA_REQ:
+	case SSDFS_PEB_CREATE_DATA_REQ:
+		seg_type = SSDFS_USER_DATA_SEG_TYPE;
+		break;
+
+	case SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ:
+	case SSDFS_PEB_CREATE_LNODE_REQ:
+		seg_type = SSDFS_LEAF_NODE_SEG_TYPE;
+		break;
+
+	case SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ:
+	case SSDFS_PEB_CREATE_HNODE_REQ:
+		seg_type = SSDFS_HYBRID_NODE_SEG_TYPE;
+		break;
+
+	case SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ:
+	case SSDFS_PEB_CREATE_IDXNODE_REQ:
+		seg_type = SSDFS_INDEX_NODE_SEG_TYPE;
+		break;
+
+	default:
+		BUG();
+	}
+
+	return seg_type;
+}
+
+/*
+ * SEG_TYPE_TO_USING_STATE() - convert segment type to segment using state
+ * @seg_type: segment type
+ */
+static inline
+int SEG_TYPE_TO_USING_STATE(u16 seg_type)
+{
+	switch (seg_type) {
+	case SSDFS_USER_DATA_SEG_TYPE:
+		return SSDFS_SEG_DATA_USING;
+
+	case SSDFS_LEAF_NODE_SEG_TYPE:
+		return SSDFS_SEG_LEAF_NODE_USING;
+
+	case SSDFS_HYBRID_NODE_SEG_TYPE:
+		return SSDFS_SEG_HYBRID_NODE_USING;
+
+	case SSDFS_INDEX_NODE_SEG_TYPE:
+		return SSDFS_SEG_INDEX_NODE_USING;
+	}
+
+	return SSDFS_SEG_STATE_MAX;
+}
+
+/*
+ * SEG_TYPE2MASK() - convert segment type into search mask
+ */
+static inline
+int SEG_TYPE2MASK(int seg_type)
+{
+	int mask;
+
+	switch (seg_type) {
+	case SSDFS_USER_DATA_SEG_TYPE:
+		mask = SSDFS_SEG_DATA_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_LEAF_NODE_SEG_TYPE:
+		mask = SSDFS_SEG_LEAF_NODE_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_HYBRID_NODE_SEG_TYPE:
+		mask = SSDFS_SEG_HYBRID_NODE_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_INDEX_NODE_SEG_TYPE:
+		mask = SSDFS_SEG_INDEX_NODE_USING_STATE_FLAG;
+		break;
+
+	default:
+		BUG();
+	};
+
+	return mask;
+}
+
+static inline
+void ssdfs_account_user_data_flush_request(struct ssdfs_segment_info *si)
+{
+	u64 flush_requests = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (si->seg_type == SSDFS_USER_DATA_SEG_TYPE) {
+		spin_lock(&si->fsi->volume_state_lock);
+		si->fsi->flushing_user_data_requests++;
+		flush_requests = si->fsi->flushing_user_data_requests;
+		spin_unlock(&si->fsi->volume_state_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg_id %llu, flush_requests %llu\n",
+			  si->seg_id, flush_requests);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+}
+
+static inline
+void ssdfs_forget_user_data_flush_request(struct ssdfs_segment_info *si)
+{
+	u64 flush_requests = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (si->seg_type == SSDFS_USER_DATA_SEG_TYPE) {
+		spin_lock(&si->fsi->volume_state_lock);
+		flush_requests = si->fsi->flushing_user_data_requests;
+		if (flush_requests > 0) {
+			si->fsi->flushing_user_data_requests--;
+			flush_requests = si->fsi->flushing_user_data_requests;
+		} else
+			err = -ERANGE;
+		spin_unlock(&si->fsi->volume_state_lock);
+
+		if (unlikely(err))
+			SSDFS_WARN("fail to decrement\n");
+
+		if (flush_requests == 0)
+			wake_up_all(&si->fsi->finish_user_data_flush_wq);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg_id %llu, flush_requests %llu\n",
+			  si->seg_id, flush_requests);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+}
+
+static inline
+bool is_user_data_pages_invalidated(struct ssdfs_segment_info *si)
+{
+	u64 invalidated = 0;
+
+	if (si->seg_type != SSDFS_USER_DATA_SEG_TYPE)
+		return false;
+
+	spin_lock(&si->pending_lock);
+	invalidated = si->invalidated_user_data_pages;
+	spin_unlock(&si->pending_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, invalidated %llu\n",
+		  si->seg_id, invalidated);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return invalidated > 0;
+}
+
+static inline
+void ssdfs_account_invalidated_user_data_pages(struct ssdfs_segment_info *si,
+						u32 count)
+{
+	u64 invalidated = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+
+	SSDFS_DBG("si %p, count %u\n",
+		  si, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (si->seg_type == SSDFS_USER_DATA_SEG_TYPE) {
+		spin_lock(&si->pending_lock);
+		si->invalidated_user_data_pages += count;
+		invalidated = si->invalidated_user_data_pages;
+		spin_unlock(&si->pending_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg_id %llu, invalidated %llu\n",
+			  si->seg_id, invalidated);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+}
+
+static inline
+void ssdfs_forget_invalidated_user_data_pages(struct ssdfs_segment_info *si)
+{
+	u64 invalidated = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (si->seg_type == SSDFS_USER_DATA_SEG_TYPE) {
+		spin_lock(&si->pending_lock);
+		invalidated = si->invalidated_user_data_pages;
+		si->invalidated_user_data_pages = 0;
+		spin_unlock(&si->pending_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg_id %llu, invalidated %llu\n",
+			  si->seg_id, invalidated);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+}
+
+static inline
+void ssdfs_protection_account_request(struct ssdfs_protection_window *ptr,
+				      u64 current_cno)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	u64 create_cno;
+	u64 last_request_cno;
+	u32 reqs_count;
+	u64 protected_range;
+	u64 future_request_cno;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&ptr->cno_lock);
+
+	if (ptr->reqs_count == 0) {
+		ptr->reqs_count = 1;
+		ptr->last_request_cno = current_cno;
+	} else
+		ptr->reqs_count++;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	create_cno = ptr->create_cno;
+	last_request_cno = ptr->last_request_cno;
+	reqs_count = ptr->reqs_count;
+	protected_range = ptr->protected_range;
+	future_request_cno = ptr->future_request_cno;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_unlock(&ptr->cno_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("create_cno %llu, "
+		  "last_request_cno %llu, reqs_count %u, "
+		  "protected_range %llu, future_request_cno %llu\n",
+		  create_cno,
+		  last_request_cno, reqs_count,
+		  protected_range, future_request_cno);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+static inline
+void ssdfs_protection_forget_request(struct ssdfs_protection_window *ptr,
+				     u64 current_cno)
+{
+	u64 create_cno;
+	u64 last_request_cno;
+	u32 reqs_count;
+	u64 protected_range;
+	u64 future_request_cno;
+	int err = 0;
+
+	spin_lock(&ptr->cno_lock);
+
+	if (ptr->reqs_count == 0) {
+		err = -ERANGE;
+		goto finish_process_request;
+	} else if (ptr->reqs_count == 1) {
+		ptr->reqs_count--;
+
+		if (ptr->last_request_cno >= current_cno) {
+			err = -ERANGE;
+			goto finish_process_request;
+		} else {
+			u64 diff = current_cno - ptr->last_request_cno;
+			u64 last_range = ptr->protected_range;
+			ptr->protected_range = max_t(u64, last_range, diff);
+			ptr->last_request_cno = current_cno;
+			ptr->future_request_cno =
+				current_cno + ptr->protected_range;
+		}
+	} else
+		ptr->reqs_count--;
+
+finish_process_request:
+	create_cno = ptr->create_cno;
+	last_request_cno = ptr->last_request_cno;
+	reqs_count = ptr->reqs_count;
+	protected_range = ptr->protected_range;
+	future_request_cno = ptr->future_request_cno;
+
+	spin_unlock(&ptr->cno_lock);
+
+	if (unlikely(err)) {
+		SSDFS_WARN("create_cno %llu, "
+			   "last_request_cno %llu, reqs_count %u, "
+			   "protected_range %llu, future_request_cno %llu\n",
+			   create_cno,
+			   last_request_cno, reqs_count,
+			   protected_range, future_request_cno);
+		return;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("create_cno %llu, "
+		  "last_request_cno %llu, reqs_count %u, "
+		  "protected_range %llu, future_request_cno %llu\n",
+		  create_cno,
+		  last_request_cno, reqs_count,
+		  protected_range, future_request_cno);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+static inline
+void ssdfs_segment_create_request_cno(struct ssdfs_segment_info *si)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu\n", si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_protection_account_request(&si->protection,
+				ssdfs_current_cno(si->fsi->sb));
+}
+
+static inline
+void ssdfs_segment_finish_request_cno(struct ssdfs_segment_info *si)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu\n", si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_protection_forget_request(&si->protection,
+				ssdfs_current_cno(si->fsi->sb));
+}
+
+static inline
+bool should_gc_doesnt_touch_segment(struct ssdfs_segment_info *si)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	u64 create_cno;
+	u64 last_request_cno;
+	u32 reqs_count;
+	u64 protected_range;
+	u64 future_request_cno;
+#endif /* CONFIG_SSDFS_DEBUG */
+	u64 cur_cno;
+	bool dont_touch = false;
+
+	spin_lock(&si->protection.cno_lock);
+	if (si->protection.reqs_count > 0) {
+		/* segment is under processing */
+		dont_touch = true;
+	} else {
+		cur_cno = ssdfs_current_cno(si->fsi->sb);
+		if (cur_cno <= si->protection.future_request_cno) {
+			/* segment is under protection window yet */
+			dont_touch = true;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	create_cno = si->protection.create_cno;
+	last_request_cno = si->protection.last_request_cno;
+	reqs_count = si->protection.reqs_count;
+	protected_range = si->protection.protected_range;
+	future_request_cno = si->protection.future_request_cno;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_unlock(&si->protection.cno_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, create_cno %llu, "
+		  "last_request_cno %llu, reqs_count %u, "
+		  "protected_range %llu, future_request_cno %llu, "
+		  "dont_touch %#x\n",
+		  si->seg_id, create_cno,
+		  last_request_cno, reqs_count,
+		  protected_range, future_request_cno,
+		  dont_touch);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return dont_touch;
+}
+
+static inline
+void ssdfs_peb_read_request_cno(struct ssdfs_peb_container *pebc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_protection_account_request(&pebc->cache_protection,
+			ssdfs_current_cno(pebc->parent_si->fsi->sb));
+}
+
+static inline
+void ssdfs_peb_finish_read_request_cno(struct ssdfs_peb_container *pebc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_protection_forget_request(&pebc->cache_protection,
+			ssdfs_current_cno(pebc->parent_si->fsi->sb));
+}
+
+static inline
+bool is_it_time_free_peb_cache_memory(struct ssdfs_peb_container *pebc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	u64 create_cno;
+	u64 last_request_cno;
+	u32 reqs_count;
+	u64 protected_range;
+	u64 future_request_cno;
+#endif /* CONFIG_SSDFS_DEBUG */
+	u64 cur_cno;
+	bool dont_touch = false;
+
+	spin_lock(&pebc->cache_protection.cno_lock);
+	if (pebc->cache_protection.reqs_count > 0) {
+		/* PEB has read requests */
+		dont_touch = true;
+	} else {
+		cur_cno = ssdfs_current_cno(pebc->parent_si->fsi->sb);
+		if (cur_cno <= pebc->cache_protection.future_request_cno) {
+			/* PEB is under protection window yet */
+			dont_touch = true;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	create_cno = pebc->cache_protection.create_cno;
+	last_request_cno = pebc->cache_protection.last_request_cno;
+	reqs_count = pebc->cache_protection.reqs_count;
+	protected_range = pebc->cache_protection.protected_range;
+	future_request_cno = pebc->cache_protection.future_request_cno;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_unlock(&pebc->cache_protection.cno_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_index %u, create_cno %llu, "
+		  "last_request_cno %llu, reqs_count %u, "
+		  "protected_range %llu, future_request_cno %llu, "
+		  "dont_touch %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index,
+		  create_cno,
+		  last_request_cno, reqs_count,
+		  protected_range, future_request_cno,
+		  dont_touch);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return !dont_touch;
+}
+
+/*
+ * Segment object's API
+ */
+struct ssdfs_segment_info *ssdfs_segment_allocate_object(u64 seg_id);
+void ssdfs_segment_free_object(struct ssdfs_segment_info *si);
+int ssdfs_segment_create_object(struct ssdfs_fs_info *fsi,
+				u64 seg,
+				int seg_state,
+				u16 seg_type,
+				u16 log_pages,
+				u8 create_threads,
+				struct ssdfs_segment_info *si);
+int ssdfs_segment_destroy_object(struct ssdfs_segment_info *si);
+void ssdfs_segment_get_object(struct ssdfs_segment_info *si);
+void ssdfs_segment_put_object(struct ssdfs_segment_info *si);
+
+struct ssdfs_segment_info *
+ssdfs_grab_segment(struct ssdfs_fs_info *fsi, int seg_type, u64 seg_id,
+		   u64 start_search_id);
+
+int ssdfs_segment_read_block_sync(struct ssdfs_segment_info *si,
+				  struct ssdfs_segment_request *req);
+int ssdfs_segment_read_block_async(struct ssdfs_segment_info *si,
+				  int req_type,
+				  struct ssdfs_segment_request *req);
+
+int ssdfs_segment_pre_alloc_data_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_data_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_leaf_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_leaf_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_hybrid_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_hybrid_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_index_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_index_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+
+int ssdfs_segment_add_data_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_data_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_migrate_zone_block_sync(struct ssdfs_fs_info *fsi,
+					  int req_type,
+					  struct ssdfs_segment_request *req,
+					  u64 *seg_id,
+					  struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_migrate_zone_block_async(struct ssdfs_fs_info *fsi,
+					   int req_type,
+					   struct ssdfs_segment_request *req,
+					   u64 *seg_id,
+					   struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_leaf_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_leaf_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_hybrid_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_hybrid_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_index_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_index_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+
+int ssdfs_segment_pre_alloc_data_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_data_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_leaf_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_leaf_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_hybrid_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_hybrid_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_index_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_pre_alloc_index_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+
+int ssdfs_segment_add_data_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_data_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_migrate_zone_extent_sync(struct ssdfs_fs_info *fsi,
+					   int req_type,
+					   struct ssdfs_segment_request *req,
+					   u64 *seg_id,
+					   struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_migrate_zone_extent_async(struct ssdfs_fs_info *fsi,
+					    int req_type,
+					    struct ssdfs_segment_request *req,
+					    u64 *seg_id,
+					    struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_leaf_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_leaf_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_hybrid_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_hybrid_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_index_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_segment_add_index_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent);
+
+int ssdfs_segment_update_block_sync(struct ssdfs_segment_info *si,
+				    struct ssdfs_segment_request *req);
+int ssdfs_segment_update_block_async(struct ssdfs_segment_info *si,
+				     int req_type,
+				     struct ssdfs_segment_request *req);
+int ssdfs_segment_update_extent_sync(struct ssdfs_segment_info *si,
+				     struct ssdfs_segment_request *req);
+int ssdfs_segment_update_extent_async(struct ssdfs_segment_info *si,
+				      int req_type,
+				      struct ssdfs_segment_request *req);
+int ssdfs_segment_update_pre_alloc_block_sync(struct ssdfs_segment_info *si,
+					    struct ssdfs_segment_request *req);
+int ssdfs_segment_update_pre_alloc_block_async(struct ssdfs_segment_info *si,
+					    int req_type,
+					    struct ssdfs_segment_request *req);
+int ssdfs_segment_update_pre_alloc_extent_sync(struct ssdfs_segment_info *si,
+					    struct ssdfs_segment_request *req);
+int ssdfs_segment_update_pre_alloc_extent_async(struct ssdfs_segment_info *si,
+					    int req_type,
+					    struct ssdfs_segment_request *req);
+
+int ssdfs_segment_node_diff_on_write_sync(struct ssdfs_segment_info *si,
+					  struct ssdfs_segment_request *req);
+int ssdfs_segment_node_diff_on_write_async(struct ssdfs_segment_info *si,
+					   int req_type,
+					   struct ssdfs_segment_request *req);
+int ssdfs_segment_data_diff_on_write_sync(struct ssdfs_segment_info *si,
+					  struct ssdfs_segment_request *req);
+int ssdfs_segment_data_diff_on_write_async(struct ssdfs_segment_info *si,
+					   int req_type,
+					   struct ssdfs_segment_request *req);
+
+int ssdfs_segment_prepare_migration_sync(struct ssdfs_segment_info *si,
+					 struct ssdfs_segment_request *req);
+int ssdfs_segment_prepare_migration_async(struct ssdfs_segment_info *si,
+					  int req_type,
+					  struct ssdfs_segment_request *req);
+int ssdfs_segment_commit_log_sync(struct ssdfs_segment_info *si,
+				  struct ssdfs_segment_request *req);
+int ssdfs_segment_commit_log_async(struct ssdfs_segment_info *si,
+				   int req_type,
+				   struct ssdfs_segment_request *req);
+int ssdfs_segment_commit_log_sync2(struct ssdfs_segment_info *si,
+				   u16 peb_index,
+				   struct ssdfs_segment_request *req);
+int ssdfs_segment_commit_log_async2(struct ssdfs_segment_info *si,
+				    int req_type, u16 peb_index,
+				    struct ssdfs_segment_request *req);
+
+int ssdfs_segment_invalidate_logical_block(struct ssdfs_segment_info *si,
+					   u32 blk_offset);
+int ssdfs_segment_invalidate_logical_extent(struct ssdfs_segment_info *si,
+					    u32 start_off, u32 blks_count);
+
+int ssdfs_segment_migrate_range_async(struct ssdfs_segment_info *si,
+				      struct ssdfs_segment_request *req);
+int ssdfs_segment_migrate_pre_alloc_page_async(struct ssdfs_segment_info *si,
+					    struct ssdfs_segment_request *req);
+int ssdfs_segment_migrate_fragment_async(struct ssdfs_segment_info *si,
+					 struct ssdfs_segment_request *req);
+
+/*
+ * Internal segment object's API
+ */
+struct ssdfs_segment_info *
+__ssdfs_create_new_segment(struct ssdfs_fs_info *fsi,
+			   u64 seg_id, int seg_state,
+			   u16 seg_type, u16 log_pages,
+			   u8 create_threads);
+int ssdfs_segment_change_state(struct ssdfs_segment_info *si);
+int ssdfs_segment_detect_search_range(struct ssdfs_fs_info *fsi,
+				      u64 *start_seg, u64 *end_seg);
+
+#endif /* _SSDFS_SEGMENT_H */
diff --git a/fs/ssdfs/segment_tree.c b/fs/ssdfs/segment_tree.c
new file mode 100644
index 000000000000..2cb3ae2c5c9c
--- /dev/null
+++ b/fs/ssdfs/segment_tree.c
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment_tree.c - segment tree implementation.
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
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "segment_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb_container.h"
+#include "segment.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "extents_tree.h"
+#include "segment_tree.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_seg_tree_page_leaks;
+atomic64_t ssdfs_seg_tree_memory_leaks;
+atomic64_t ssdfs_seg_tree_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_seg_tree_cache_leaks_increment(void *kaddr)
+ * void ssdfs_seg_tree_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_seg_tree_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_seg_tree_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_seg_tree_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_seg_tree_kfree(void *kaddr)
+ * struct page *ssdfs_seg_tree_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_seg_tree_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_seg_tree_free_page(struct page *page)
+ * void ssdfs_seg_tree_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(seg_tree)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(seg_tree)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_seg_tree_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_seg_tree_page_leaks, 0);
+	atomic64_set(&ssdfs_seg_tree_memory_leaks, 0);
+	atomic64_set(&ssdfs_seg_tree_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_seg_tree_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_seg_tree_page_leaks) != 0) {
+		SSDFS_ERR("SEGMENT TREE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_seg_tree_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_seg_tree_memory_leaks) != 0) {
+		SSDFS_ERR("SEGMENT TREE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_seg_tree_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_seg_tree_cache_leaks) != 0) {
+		SSDFS_ERR("SEGMENT TREE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_seg_tree_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/******************************************************************************
+ *                        SEGMENTS TREE FUNCTIONALITY                         *
+ ******************************************************************************/
+
+static
+void ssdfs_segment_tree_invalidate_folio(struct folio *folio, size_t offset,
+					 size_t length)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("do nothing: offset %zu, length %zu\n",
+		  offset, length);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_segment_tree_release_folio() - Release fs-specific metadata on a folio.
+ * @folio: The folio which the kernel is trying to free.
+ * @gfp: Memory allocation flags (and I/O mode).
+ *
+ * The address_space is trying to release any data attached to a folio
+ * (presumably at folio->private).
+ *
+ * This will also be called if the private_2 flag is set on a page,
+ * indicating that the folio has other metadata associated with it.
+ *
+ * The @gfp argument specifies whether I/O may be performed to release
+ * this page (__GFP_IO), and whether the call may block
+ * (__GFP_RECLAIM & __GFP_FS).
+ *
+ * Return: %true if the release was successful, otherwise %false.
+ */
+static
+bool ssdfs_segment_tree_release_folio(struct folio *folio, gfp_t gfp)
+{
+	return false;
+}
+
+static
+bool ssdfs_segment_tree_noop_dirty_folio(struct address_space *mapping,
+					 struct folio *folio)
+{
+	return true;
+}
+
+const struct address_space_operations ssdfs_segment_tree_aops = {
+	.invalidate_folio	= ssdfs_segment_tree_invalidate_folio,
+	.release_folio		= ssdfs_segment_tree_release_folio,
+	.dirty_folio		= ssdfs_segment_tree_noop_dirty_folio,
+};
+
+/*
+ * ssdfs_segment_tree_mapping_init() - segment tree's mapping init
+ */
+static inline
+void ssdfs_segment_tree_mapping_init(struct address_space *mapping,
+				     struct inode *inode)
+{
+	address_space_init_once(mapping);
+	mapping->a_ops = &ssdfs_segment_tree_aops;
+	mapping->host = inode;
+	mapping->flags = 0;
+	atomic_set(&mapping->i_mmap_writable, 0);
+	mapping_set_gfp_mask(mapping, GFP_KERNEL | __GFP_ZERO);
+	mapping->private_data = NULL;
+	mapping->writeback_index = 0;
+	inode->i_mapping = mapping;
+}
+
+static const struct inode_operations def_segment_tree_ino_iops;
+static const struct file_operations def_segment_tree_ino_fops;
+static const struct address_space_operations def_segment_tree_ino_aops;
+
+/*
+ * ssdfs_create_segment_tree_inode() - create segments tree's inode
+ * @fsi: pointer on shared file system object
+ */
+static
+int ssdfs_create_segment_tree_inode(struct ssdfs_fs_info *fsi)
+{
+	struct inode *inode;
+	struct ssdfs_inode_info *ii;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode = iget_locked(fsi->sb, SSDFS_SEG_TREE_INO);
+	if (unlikely(!inode)) {
+		err = -ENOMEM;
+		SSDFS_ERR("unable to allocate segment tree inode: err %d\n",
+			  err);
+		return err;
+	}
+
+	BUG_ON(!(inode->i_state & I_NEW));
+
+	inode->i_mode = S_IFREG;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_KERNEL);
+
+	inode->i_op = &def_segment_tree_ino_iops;
+	inode->i_fop = &def_segment_tree_ino_fops;
+	inode->i_mapping->a_ops = &def_segment_tree_ino_aops;
+
+	ii = SSDFS_I(inode);
+	ii->birthtime = current_time(inode);
+	ii->parent_ino = U64_MAX;
+
+	down_write(&ii->lock);
+	err = ssdfs_extents_tree_create(fsi, ii);
+	up_write(&ii->lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create the extents tree: "
+			  "err %d\n", err);
+		unlock_new_inode(inode);
+		iput(inode);
+		return -ERANGE;
+	}
+
+	unlock_new_inode(inode);
+
+	fsi->segs_tree_inode = inode;
+
+	return 0;
+}
+
+/*
+ * ssdfs_segment_tree_create() - create segments tree
+ * @fsi: pointer on shared file system object
+ */
+int ssdfs_segment_tree_create(struct ssdfs_fs_info *fsi)
+{
+	size_t dentries_desc_size =
+		sizeof(struct ssdfs_dentries_btree_descriptor);
+	size_t extents_desc_size =
+		sizeof(struct ssdfs_extents_btree_descriptor);
+	size_t xattr_desc_size =
+		sizeof(struct ssdfs_xattr_btree_descriptor);
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+	BUG_ON(!rwsem_is_locked(&fsi->volume_sem));
+
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi->segs_tree =
+		ssdfs_seg_tree_kzalloc(sizeof(struct ssdfs_segment_tree),
+					GFP_KERNEL);
+	if (!fsi->segs_tree) {
+		SSDFS_ERR("fail to allocate segment tree's root object\n");
+		return -ENOMEM;
+	}
+
+	ssdfs_memcpy(&fsi->segs_tree->dentries_btree,
+		     0, dentries_desc_size,
+		     &fsi->vh->dentries_btree,
+		     0, dentries_desc_size,
+		     dentries_desc_size);
+	ssdfs_memcpy(&fsi->segs_tree->extents_btree, 0, extents_desc_size,
+		     &fsi->vh->extents_btree, 0, extents_desc_size,
+		     extents_desc_size);
+	ssdfs_memcpy(&fsi->segs_tree->xattr_btree, 0, xattr_desc_size,
+		     &fsi->vh->xattr_btree, 0, xattr_desc_size,
+		     xattr_desc_size);
+
+	err = ssdfs_create_segment_tree_inode(fsi);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create segment tree's inode: "
+			  "err %d\n",
+			  err);
+		goto free_memory;
+	}
+
+	fsi->segs_tree->lnodes_seg_log_pages =
+		le16_to_cpu(fsi->vh->lnodes_seg_log_pages);
+	fsi->segs_tree->hnodes_seg_log_pages =
+		le16_to_cpu(fsi->vh->hnodes_seg_log_pages);
+	fsi->segs_tree->inodes_seg_log_pages =
+		le16_to_cpu(fsi->vh->inodes_seg_log_pages);
+	fsi->segs_tree->user_data_log_pages =
+		le16_to_cpu(fsi->vh->user_data_log_pages);
+	fsi->segs_tree->default_log_pages = SSDFS_LOG_PAGES_DEFAULT;
+
+	ssdfs_segment_tree_mapping_init(&fsi->segs_tree->pages,
+					fsi->segs_tree_inode);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("DONE: create segment tree\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+
+free_memory:
+	ssdfs_seg_tree_kfree(fsi->segs_tree);
+	fsi->segs_tree = NULL;
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_tree_destroy_objects_in_page() - destroy objects in page
+ * @fsi: pointer on shared file system object
+ * @page: pointer on memory page
+ */
+static
+void ssdfs_segment_tree_destroy_objects_in_page(struct ssdfs_fs_info *fsi,
+						struct page *page)
+{
+	struct ssdfs_segment_info **kaddr;
+	size_t ptr_size = sizeof(struct ssdfs_segment_info *);
+	size_t ptrs_per_page = PAGE_SIZE / ptr_size;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page || !fsi || !fsi->segs_tree);
+
+	SSDFS_DBG("page %p\n", page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_lock_page(page);
+
+	kaddr = (struct ssdfs_segment_info **)kmap_local_page(page);
+
+	for (i = 0; i < ptrs_per_page; i++) {
+		struct ssdfs_segment_info *si = *(kaddr + i);
+
+		if (si) {
+			wait_queue_head_t *wq = &si->object_queue;
+			int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("si %p, seg_id %llu\n", si, si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (atomic_read(&si->refs_count) > 0) {
+				ssdfs_unlock_page(page);
+
+				err = wait_event_killable_timeout(*wq,
+					atomic_read(&si->refs_count) <= 0,
+					SSDFS_DEFAULT_TIMEOUT);
+				if (err < 0)
+					WARN_ON(err < 0);
+				else
+					err = 0;
+
+				ssdfs_lock_page(page);
+			}
+
+			err = ssdfs_segment_destroy_object(si);
+			if (err) {
+				SSDFS_WARN("fail to destroy segment object: "
+					   "seg %llu, err %d\n",
+					   si->seg_id, err);
+			}
+		}
+
+	}
+
+	kunmap_local(kaddr);
+
+	__ssdfs_clear_dirty_page(page);
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+	SSDFS_DBG("page_index %ld, flags %#lx\n",
+		  page->index, page->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_segment_tree_destroy_objects_in_array() - destroy objects in array
+ * @fsi: pointer on shared file system object
+ * @array: pointer on array of pages
+ * @pages_count: count of pages in array
+ */
+static
+void ssdfs_segment_tree_destroy_objects_in_array(struct ssdfs_fs_info *fsi,
+						 struct page **array,
+						 size_t pages_count)
+{
+	struct page *page;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!array || !fsi);
+
+	SSDFS_DBG("array %p, pages_count %zu\n",
+		  array, pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < pages_count; i++) {
+		page = array[i];
+
+		if (!page) {
+			SSDFS_WARN("page pointer is NULL: "
+				   "index %d\n",
+				   i);
+			continue;
+		}
+
+		ssdfs_segment_tree_destroy_objects_in_page(fsi, page);
+	}
+}
+
+#define SSDFS_MEM_PAGE_ARRAY_SIZE	(16)
+
+/*
+ * ssdfs_segment_tree_destroy_segment_objects() - destroy all segment objects
+ * @fsi: pointer on shared file system object
+ */
+static
+void ssdfs_segment_tree_destroy_segment_objects(struct ssdfs_fs_info *fsi)
+{
+	pgoff_t start = 0;
+	pgoff_t end = -1;
+	size_t pages_count = 0;
+	struct page *array[SSDFS_MEM_PAGE_ARRAY_SIZE] = {0};
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->segs_tree);
+
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	do {
+		pages_count = find_get_pages_range_tag(&fsi->segs_tree->pages,
+					    &start, end,
+					    PAGECACHE_TAG_DIRTY,
+					    SSDFS_MEM_PAGE_ARRAY_SIZE,
+					    &array[0]);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start %lu, pages_count %zu\n",
+			  start, pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (pages_count != 0) {
+			ssdfs_segment_tree_destroy_objects_in_array(fsi,
+								&array[0],
+								pages_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!array[pages_count - 1]);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			start = page_index(array[pages_count - 1]) + 1;
+		}
+	} while (pages_count != 0);
+}
+
+/*
+ * ssdfs_segment_tree_destroy() - destroy segments tree
+ * @fsi: pointer on shared file system object
+ */
+void ssdfs_segment_tree_destroy(struct ssdfs_fs_info *fsi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->segs_tree);
+
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode_lock(fsi->segs_tree_inode);
+
+	ssdfs_segment_tree_destroy_segment_objects(fsi);
+
+	if (fsi->segs_tree->pages.nrpages != 0)
+		truncate_inode_pages(&fsi->segs_tree->pages, 0);
+
+	inode_unlock(fsi->segs_tree_inode);
+
+	iput(fsi->segs_tree_inode);
+	ssdfs_seg_tree_kfree(fsi->segs_tree);
+	fsi->segs_tree = NULL;
+}
+
+/*
+ * ssdfs_segment_tree_add() - add segment object into the tree
+ * @fsi: pointer on shared file system object
+ * @si: pointer on segment object
+ *
+ * This method tries to add the valid pointer on segment
+ * object into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM  - fail to allocate memory.
+ * %-EEXIST  - segment has been added already.
+ */
+int ssdfs_segment_tree_add(struct ssdfs_fs_info *fsi,
+			   struct ssdfs_segment_info *si)
+{
+	pgoff_t page_index;
+	u32 object_index;
+	struct page *page;
+	struct ssdfs_segment_info **kaddr, *object;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->segs_tree || !si);
+
+	SSDFS_DBG("fsi %p, si %p, seg %llu\n",
+		  fsi, si, si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = div_u64_rem(si->seg_id, SSDFS_SEG_OBJ_PTR_PER_PAGE,
+				 &object_index);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_index %lu, object_index %u\n",
+		  page_index, object_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode_lock(fsi->segs_tree_inode);
+
+	page = grab_cache_page(&fsi->segs_tree->pages, page_index);
+	if (!page) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to grab page: page_index %lu\n",
+			  page_index);
+		goto finish_add_segment;
+	}
+
+	ssdfs_account_locked_page(page);
+
+	kaddr = (struct ssdfs_segment_info **)kmap_local_page(page);
+	object = *(kaddr + object_index);
+	if (object) {
+		err = -EEXIST;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("object exists for segment %llu\n",
+			  si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else
+		*(kaddr + object_index) = si;
+	kunmap_local(kaddr);
+
+	SetPageUptodate(page);
+	if (!PageDirty(page))
+		ssdfs_set_page_dirty(page);
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+	SSDFS_DBG("page_index %ld, flags %#lx\n",
+		  page->index, page->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_add_segment:
+	inode_unlock(fsi->segs_tree_inode);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_tree_remove() - remove segment object from the tree
+ * @fsi: pointer on shared file system object
+ * @si: pointer on segment object
+ *
+ * This method tries to remove the valid pointer on segment
+ * object from the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA  - segment tree hasn't object for @si.
+ */
+int ssdfs_segment_tree_remove(struct ssdfs_fs_info *fsi,
+			      struct ssdfs_segment_info *si)
+{
+	pgoff_t page_index;
+	u32 object_index;
+	struct page *page;
+	struct ssdfs_segment_info **kaddr, *object;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->segs_tree || !si);
+
+	SSDFS_DBG("fsi %p, si %p, seg %llu\n",
+		  fsi, si, si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = div_u64_rem(si->seg_id, SSDFS_SEG_OBJ_PTR_PER_PAGE,
+				 &object_index);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_index %lu, object_index %u\n",
+		  page_index, object_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode_lock(fsi->segs_tree_inode);
+
+	page = find_lock_page(&fsi->segs_tree->pages, page_index);
+	if (!page) {
+		err = -ENODATA;
+		SSDFS_ERR("failed to remove segment object: "
+			  "seg %llu\n",
+			  si->seg_id);
+		goto finish_remove_segment;
+	}
+
+	ssdfs_account_locked_page(page);
+	kaddr = (struct ssdfs_segment_info **)kmap_local_page(page);
+	object = *(kaddr + object_index);
+	if (!object) {
+		err = -ENODATA;
+		SSDFS_WARN("object ptr is NULL: "
+			   "seg %llu\n",
+			   si->seg_id);
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(object != si);
+#endif /* CONFIG_SSDFS_DEBUG */
+		*(kaddr + object_index) = NULL;
+	}
+	kunmap_local(kaddr);
+
+	SetPageUptodate(page);
+	if (!PageDirty(page))
+		ssdfs_set_page_dirty(page);
+
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	/*
+	 * Prevent from error of creation
+	 * the same segment in another thread.
+	 */
+	ssdfs_sysfs_delete_seg_group(si);
+
+finish_remove_segment:
+	inode_unlock(fsi->segs_tree_inode);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_tree_find() - find segment object in the tree
+ * @fsi: pointer on shared file system object
+ * @seg_id: segment number
+ *
+ * This method tries to find the valid pointer on segment
+ * object for @seg_id.
+ *
+ * RETURN:
+ * [success] - pointer on found segment object
+ * [failure] - error code:
+ *
+ * %-EINVAL   - invalid input.
+ * %-ENODATA  - segment tree hasn't object for @seg_id.
+ */
+struct ssdfs_segment_info *
+ssdfs_segment_tree_find(struct ssdfs_fs_info *fsi, u64 seg_id)
+{
+	pgoff_t page_index;
+	u32 object_index;
+	struct page *page;
+	struct ssdfs_segment_info **kaddr, *object;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->segs_tree);
+
+	if (seg_id >= fsi->nsegs) {
+		SSDFS_ERR("seg_id %llu >= fsi->nsegs %llu\n",
+			  seg_id, fsi->nsegs);
+		return ERR_PTR(-EINVAL);
+	}
+
+	SSDFS_DBG("fsi %p, seg_id %llu\n",
+		  fsi, seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = div_u64_rem(seg_id, SSDFS_SEG_OBJ_PTR_PER_PAGE,
+				 &object_index);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page_index %lu, object_index %u\n",
+		  page_index, object_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode_lock_shared(fsi->segs_tree_inode);
+
+	page = find_lock_page(&fsi->segs_tree->pages, page_index);
+	if (!page) {
+		object = ERR_PTR(-ENODATA);
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find segment object: "
+			  "seg %llu\n",
+			  seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_find_segment;
+	}
+
+	ssdfs_account_locked_page(page);
+	kaddr = (struct ssdfs_segment_info **)kmap_local_page(page);
+	object = *(kaddr + object_index);
+	if (!object) {
+		object = ERR_PTR(-ENODATA);
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find segment object: "
+			  "seg %llu\n",
+			  seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_find_segment:
+	inode_unlock_shared(fsi->segs_tree_inode);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return object;
+}
diff --git a/fs/ssdfs/segment_tree.h b/fs/ssdfs/segment_tree.h
new file mode 100644
index 000000000000..9d76fa784e7c
--- /dev/null
+++ b/fs/ssdfs/segment_tree.h
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment_tree.h - segment tree declarations.
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
+#ifndef _SSDFS_SEGMENT_TREE_H
+#define _SSDFS_SEGMENT_TREE_H
+
+/*
+ * struct ssdfs_segment_tree - tree of segment objects
+ * @lnodes_seg_log_pages: full log size in leaf nodes segment (pages count)
+ * @hnodes_seg_log_pages: full log size in hybrid nodes segment (pages count)
+ * @inodes_seg_log_pages: full log size in index nodes segment (pages count)
+ * @user_data_log_pages: full log size in user data segment (pages count)
+ * @default_log_pages: default full log size (pages count)
+ * @dentries_btree: dentries b-tree descriptor
+ * @extents_btree: extents b-tree descriptor
+ * @xattr_btree: xattrs b-tree descriptor
+ * @pages: pages of segment tree
+ */
+struct ssdfs_segment_tree {
+	u16 lnodes_seg_log_pages;
+	u16 hnodes_seg_log_pages;
+	u16 inodes_seg_log_pages;
+	u16 user_data_log_pages;
+	u16 default_log_pages;
+
+	struct ssdfs_dentries_btree_descriptor dentries_btree;
+	struct ssdfs_extents_btree_descriptor extents_btree;
+	struct ssdfs_xattr_btree_descriptor xattr_btree;
+
+	struct address_space pages;
+};
+
+#define SSDFS_SEG_OBJ_PTR_PER_PAGE \
+	(PAGE_SIZE / sizeof(struct ssdfs_segment_info *))
+
+/*
+ * Segments' tree API
+ */
+int ssdfs_segment_tree_create(struct ssdfs_fs_info *fsi);
+void ssdfs_segment_tree_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_segment_tree_add(struct ssdfs_fs_info *fsi,
+			   struct ssdfs_segment_info *si);
+int ssdfs_segment_tree_remove(struct ssdfs_fs_info *fsi,
+			      struct ssdfs_segment_info *si);
+struct ssdfs_segment_info *
+ssdfs_segment_tree_find(struct ssdfs_fs_info *fsi, u64 seg_id);
+
+#endif /* _SSDFS_SEGMENT_TREE_H */
-- 
2.34.1


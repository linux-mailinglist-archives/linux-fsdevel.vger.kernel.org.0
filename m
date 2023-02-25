Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F066A6A264C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBYBRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjBYBQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:59 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B196216AFF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:54 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id c11so825049oiw.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhBKIydBkBXqbowXVpb9pwIgj7S9o/tmgVJHT8762+0=;
        b=nJEFiVQiNWfOK1gvhKQGXdvHdOjEsTYdr7v3iCnwM9bcLStepTb//S8HYLFlJeSkH+
         8ZVvtLDOBXIvfCHrILKBSnsaBIWRslQB3oyrNoPgni+Ixgq4+TDd6ihbrLm6fLIpSdPZ
         k37DW4kzXToVWkx+tye11ZhLw9GtJEFrM5sZVpso4L3IeU6Wxmbmf4sb3iI60t0aZys7
         GVMwOyubvs92PSKd0zJFlqsHwY3Nw+ldOkiosx+wQhelyspeRjoMg3pbtNHxS60Ys/Ws
         AfcnkgB6E98AmPMK5F/hyWNomYEwEnO5vwCAE1ccaxVpr+Nv8DSboj17qWaJxZ97jK0n
         Pwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhBKIydBkBXqbowXVpb9pwIgj7S9o/tmgVJHT8762+0=;
        b=kL61OLzU4/qMIfSxmq+FxpUWPKSI5ce1iwgjEjHD2tdg2EZwamyVDWzZarnXM0Kt88
         QcIF0HSCCNWbcMoY1A8pvNwkFAELCx6L5Sw1vjVYlgi1f977KvJQ2M1hzuKBWf7yK4AU
         zRYOK7RJPlbY1S3p+iV2LGO7LvsYGPJFz6o8CZTOsZBS3I37i89W+5jN70QsrXlziP9M
         8cyRrY4G2ta7ORbOMw/BEpCOyJ620vJ2wi0JveazFFZhCbUDtQokiJYw9Va9JTvUvDm9
         sgaRuaqHyohQVDlcuDKb3qMRYBF9Di2IAEkte0nOrTys174gdEWObwKesL/Nyv7/lSFK
         4n0Q==
X-Gm-Message-State: AO0yUKVx10V7KZWEoEoeVMyMNLr0oH+7XqY7nQlff08nJexvSNKJ11d4
        FUKFLnkMcC7ZrfqPokG1zPCkjufUtpbVdd6C
X-Google-Smtp-Source: AK7set+qeATFN92qXGqwCVEP8yMWevx4I/wsFX7OgdukPv2inEctZ/LuG8ejDdMsOrgg/prtikN3vg==
X-Received: by 2002:a05:6808:2345:b0:383:b4f8:9e3 with SMTP id ef5-20020a056808234500b00383b4f809e3mr6808743oib.44.1677287813026;
        Fri, 24 Feb 2023 17:16:53 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:52 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 37/76] ssdfs: segment object's update/invalidate data/metadata
Date:   Fri, 24 Feb 2023 17:08:48 -0800
Message-Id: <20230225010927.813929-38-slava@dubeyko.com>
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

Any file or metadata structure can be updated, truncated, or
deleted. Segment object supports the update and invalidate
operations with user data or metadata. SSDFS uses logical extent
concept to track the location of any user data or metadata.
It means that every metadata structure is described by a sequence
of extents. Inode object keeps inline extents or root node of
extents b-tree that tracks the location of a file's content.
Extent identifies a segment ID, logical block ID, and length of
extent. Segment ID is used to create or access the segment object.
The segment object has offset translation table that provides
the mechanism to convert a logical block ID into "Physical"
Erase Block (PEB) ID. Finally, it is possible to add update or
invalidation request into PEB's update queue. PEB's flush thread
takes the update/invalidate requests from the queue and executes
the requests. Execution of request means the creation of new
log that will contain the actual state of updated or invalidated
data in the log's metadata (header, block bitmap, offset
translation table) and payload.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/current_segment.c |  682 ++++++++++++++++
 fs/ssdfs/current_segment.h |   76 ++
 fs/ssdfs/segment.c         | 1521 ++++++++++++++++++++++++++++++++++++
 3 files changed, 2279 insertions(+)
 create mode 100644 fs/ssdfs/current_segment.c
 create mode 100644 fs/ssdfs/current_segment.h

diff --git a/fs/ssdfs/current_segment.c b/fs/ssdfs/current_segment.c
new file mode 100644
index 000000000000..10067f0d8753
--- /dev/null
+++ b/fs/ssdfs/current_segment.c
@@ -0,0 +1,682 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/current_segment.c - current segment abstraction implementation.
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
+#include "page_vector.h"
+#include "peb_block_bitmap.h"
+#include "segment_block_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "peb_container.h"
+#include "segment_bitmap.h"
+#include "segment.h"
+#include "current_segment.h"
+#include "segment_tree.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_cur_seg_page_leaks;
+atomic64_t ssdfs_cur_seg_memory_leaks;
+atomic64_t ssdfs_cur_seg_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_cur_seg_cache_leaks_increment(void *kaddr)
+ * void ssdfs_cur_seg_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_cur_seg_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_cur_seg_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_cur_seg_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_cur_seg_kfree(void *kaddr)
+ * struct page *ssdfs_cur_seg_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_cur_seg_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_cur_seg_free_page(struct page *page)
+ * void ssdfs_cur_seg_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(cur_seg)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(cur_seg)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_cur_seg_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_cur_seg_page_leaks, 0);
+	atomic64_set(&ssdfs_cur_seg_memory_leaks, 0);
+	atomic64_set(&ssdfs_cur_seg_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_cur_seg_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_cur_seg_page_leaks) != 0) {
+		SSDFS_ERR("CURRENT SEGMENT: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_cur_seg_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_cur_seg_memory_leaks) != 0) {
+		SSDFS_ERR("CURRENT SEGMENT: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_cur_seg_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_cur_seg_cache_leaks) != 0) {
+		SSDFS_ERR("CURRENT SEGMENT: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_cur_seg_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/******************************************************************************
+ *               CURRENT SEGMENT CONTAINER FUNCTIONALITY                      *
+ ******************************************************************************/
+
+/*
+ * ssdfs_current_segment_init() - init current segment container
+ * @fsi: pointer on shared file system object
+ * @type: current segment type
+ * @seg_id: segment ID
+ * @cur_seg: pointer on current segment container [out]
+ */
+static
+void ssdfs_current_segment_init(struct ssdfs_fs_info *fsi,
+				int type,
+				u64 seg_id,
+				struct ssdfs_current_segment *cur_seg)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !cur_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	mutex_init(&cur_seg->lock);
+	cur_seg->type = type;
+	cur_seg->seg_id = seg_id;
+	cur_seg->real_seg = NULL;
+	cur_seg->fsi = fsi;
+}
+
+/*
+ * ssdfs_current_segment_destroy() - destroy current segment
+ * @cur_seg: pointer on current segment container
+ */
+static
+void ssdfs_current_segment_destroy(struct ssdfs_current_segment *cur_seg)
+{
+	if (!cur_seg)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(mutex_is_locked(&cur_seg->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_ssdfs_current_segment_empty(cur_seg)) {
+		ssdfs_current_segment_lock(cur_seg);
+		ssdfs_current_segment_remove(cur_seg);
+		ssdfs_current_segment_unlock(cur_seg);
+	}
+}
+
+/*
+ * ssdfs_current_segment_lock() - lock current segment
+ * @cur_seg: pointer on current segment container
+ */
+void ssdfs_current_segment_lock(struct ssdfs_current_segment *cur_seg)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cur_seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = mutex_lock_killable(&cur_seg->lock);
+	WARN_ON(err);
+}
+
+/*
+ * ssdfs_current_segment_unlock() - unlock current segment
+ * @cur_seg: pointer on current segment container
+ */
+void ssdfs_current_segment_unlock(struct ssdfs_current_segment *cur_seg)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cur_seg);
+	WARN_ON(!mutex_is_locked(&cur_seg->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	mutex_unlock(&cur_seg->lock);
+}
+
+/*
+ * need_select_flush_threads() - check necessity to select flush threads
+ * @seg_state: segment state
+ */
+static inline
+bool need_select_flush_threads(int seg_state)
+{
+	bool need_select = true;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(seg_state >= SSDFS_SEG_STATE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (seg_state) {
+	case SSDFS_SEG_CLEAN:
+	case SSDFS_SEG_DATA_USING:
+	case SSDFS_SEG_LEAF_NODE_USING:
+	case SSDFS_SEG_HYBRID_NODE_USING:
+	case SSDFS_SEG_INDEX_NODE_USING:
+		need_select = true;
+		break;
+
+	case SSDFS_SEG_USED:
+	case SSDFS_SEG_PRE_DIRTY:
+	case SSDFS_SEG_DIRTY:
+		need_select = false;
+		break;
+
+	default:
+		BUG();
+	}
+
+	return need_select;
+}
+
+/*
+ * ssdfs_segment_select_flush_threads() - select flush threads
+ * @si: pointer on segment object
+ * @max_free_pages: max value and position pair
+ *
+ * This function selects PEBs' flush threads that will process
+ * new pages requests.
+ */
+static
+int ssdfs_segment_select_flush_threads(struct ssdfs_segment_info *si,
+					struct ssdfs_value_pair *max_free_pages)
+{
+	int start_pos;
+	u8 found_flush_threads = 0;
+	int peb_free_pages;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !max_free_pages);
+	BUG_ON(max_free_pages->value <= 0);
+	BUG_ON(max_free_pages->pos < 0);
+	BUG_ON(max_free_pages->pos >= si->pebs_count);
+
+	SSDFS_DBG("seg %llu, max free pages: value %d, pos %d\n",
+		  si->seg_id, max_free_pages->value, max_free_pages->pos);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!need_select_flush_threads(atomic_read(&si->seg_state)) ||
+	    atomic_read(&si->blk_bmap.seg_free_blks) == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("segment %llu can't be used as current: \n",
+			  si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	start_pos = max_free_pages->pos + si->create_threads - 1;
+	start_pos /= si->create_threads;
+	start_pos *= si->create_threads;
+
+	if (start_pos >= si->pebs_count)
+		start_pos = 0;
+
+	for (i = start_pos; i < si->pebs_count; i++) {
+		struct ssdfs_peb_container *pebc = &si->peb_array[i];
+
+		if (found_flush_threads == si->create_threads)
+			break;
+
+		peb_free_pages = ssdfs_peb_get_free_pages(pebc);
+		if (unlikely(peb_free_pages < 0)) {
+			err = peb_free_pages;
+			SSDFS_ERR("fail to calculate PEB's free pages: "
+				  "pebc %p, seg %llu, peb index %d, err %d\n",
+				  pebc, si->seg_id, i, err);
+			return err;
+		}
+
+		if (peb_free_pages == 0 ||
+		    is_peb_joined_into_create_requests_queue(pebc))
+			continue;
+
+		err = ssdfs_peb_join_create_requests_queue(pebc,
+							   &si->create_rq);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to join create requests queue: "
+				  "seg %llu, peb index %d, err %d\n",
+				  si->seg_id, i, err);
+			return err;
+		}
+		found_flush_threads++;
+	}
+
+	for (i = 0; i < start_pos; i++) {
+		struct ssdfs_peb_container *pebc = &si->peb_array[i];
+
+		if (found_flush_threads == si->create_threads)
+			break;
+
+		peb_free_pages = ssdfs_peb_get_free_pages(pebc);
+		if (unlikely(peb_free_pages < 0)) {
+			err = peb_free_pages;
+			SSDFS_ERR("fail to calculate PEB's free pages: "
+				  "pebc %p, seg %llu, peb index %d, err %d\n",
+				  pebc, si->seg_id, i, err);
+			return err;
+		}
+
+		if (peb_free_pages == 0 ||
+		    is_peb_joined_into_create_requests_queue(pebc))
+			continue;
+
+		err = ssdfs_peb_join_create_requests_queue(pebc,
+							   &si->create_rq);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to join create requests queue: "
+				  "seg %llu, peb index %d, err %d\n",
+				  si->seg_id, i, err);
+			return err;
+		}
+		found_flush_threads++;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_current_segment_add() - prepare current segment
+ * @cur_seg: pointer on current segment container
+ * @si: pointer on segment object
+ *
+ * This function tries to make segment object @si as current.
+ * If segment is "clean" or "using" then it can be a current
+ * segment that processes new page requests.
+ * In such case, segment object is initialized by pointer on
+ * new page requests queue. Also it chooses flush threads of several
+ * PEBs as actual threads for proccessing new page requests in
+ * parallel. It makes sense to restrict count of such threads by
+ * CPUs number or independent dies number. Number of free pages in
+ * PEB can be a basis for choosing thread as actual thread for
+ * proccessing new page requests. Namely, first @flush_threads that
+ * has as maximum as possible free pages choose for this role, firstly.
+ * When some thread fills the log then it delegates your role
+ * to a next candidate thread in the chain.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+int ssdfs_current_segment_add(struct ssdfs_current_segment *cur_seg,
+			      struct ssdfs_segment_info *si)
+{
+	struct ssdfs_value_pair max_free_pages;
+	int state;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cur_seg || !si);
+
+	if (!mutex_is_locked(&cur_seg->lock)) {
+		SSDFS_WARN("current segment container should be locked\n");
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("seg %llu, log_pages %u, create_threads %u, seg_type %#x\n",
+		  si->seg_id, si->log_pages,
+		  si->create_threads, si->seg_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	BUG_ON(!is_ssdfs_current_segment_empty(cur_seg));
+
+	max_free_pages.value = 0;
+	max_free_pages.pos = -1;
+
+	for (i = 0; i < si->pebs_count; i++) {
+		int peb_free_pages;
+		struct ssdfs_peb_container *pebc = &si->peb_array[i];
+
+		peb_free_pages = ssdfs_peb_get_free_pages(pebc);
+		if (unlikely(peb_free_pages < 0)) {
+			err = peb_free_pages;
+			SSDFS_ERR("fail to calculate PEB's free pages: "
+				  "pebc %p, seg %llu, peb index %d, err %d\n",
+				  pebc, si->seg_id, i, err);
+			return err;
+		} else if (peb_free_pages == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("seg %llu, peb_index %u, free_pages %d\n",
+				  si->seg_id, pebc->peb_index,
+				  peb_free_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		if (max_free_pages.value < peb_free_pages) {
+			max_free_pages.value = peb_free_pages;
+			max_free_pages.pos = i;
+		}
+	}
+
+	if (max_free_pages.value <= 0 || max_free_pages.pos < 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("segment %llu can't be used as current: "
+			  "max_free_pages.value %d, "
+			  "max_free_pages.pos %d\n",
+			  si->seg_id,
+			  max_free_pages.value,
+			  max_free_pages.pos);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	err = ssdfs_segment_select_flush_threads(si, &max_free_pages);
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("segment %llu can't be used as current\n",
+			  si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to select flush threads: "
+			  "seg %llu, max free pages: value %d, pos %d, "
+			  "err %d\n",
+			  si->seg_id, max_free_pages.value, max_free_pages.pos,
+			  err);
+		return err;
+	}
+
+	ssdfs_segment_get_object(si);
+
+	state = atomic_cmpxchg(&si->obj_state,
+				SSDFS_SEG_OBJECT_CREATED,
+				SSDFS_CURRENT_SEG_OBJECT);
+	if (state < SSDFS_SEG_OBJECT_CREATED ||
+	    state >= SSDFS_CURRENT_SEG_OBJECT) {
+		ssdfs_segment_put_object(si);
+		SSDFS_WARN("unexpected state %#x\n",
+			   state);
+		return -ERANGE;
+	}
+
+	cur_seg->real_seg = si;
+	cur_seg->seg_id = si->seg_id;
+
+	return 0;
+}
+
+/*
+ * ssdfs_current_segment_remove() - remove current segment
+ * @cur_seg: pointer on current segment container
+ */
+void ssdfs_current_segment_remove(struct ssdfs_current_segment *cur_seg)
+{
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cur_seg);
+
+	if (!mutex_is_locked(&cur_seg->lock))
+		SSDFS_WARN("current segment container should be locked\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_ssdfs_current_segment_empty(cur_seg)) {
+		SSDFS_WARN("current segment container is empty\n");
+		return;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, log_pages %u, create_threads %u, seg_type %#x\n",
+		  cur_seg->real_seg->seg_id,
+		  cur_seg->real_seg->log_pages,
+		  cur_seg->real_seg->create_threads,
+		  cur_seg->real_seg->seg_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_cmpxchg(&cur_seg->real_seg->obj_state,
+				SSDFS_CURRENT_SEG_OBJECT,
+				SSDFS_SEG_OBJECT_CREATED);
+	if (state <= SSDFS_SEG_OBJECT_CREATED ||
+	    state > SSDFS_CURRENT_SEG_OBJECT) {
+		SSDFS_WARN("unexpected state %#x\n",
+			   state);
+	}
+
+	ssdfs_segment_put_object(cur_seg->real_seg);
+	cur_seg->real_seg = NULL;
+}
+
+/******************************************************************************
+ *                 CURRENT SEGMENTS ARRAY FUNCTIONALITY                       *
+ ******************************************************************************/
+
+/*
+ * ssdfs_current_segment_array_create() - create current segments array
+ * @fsi: pointer on shared file system object
+ */
+int ssdfs_current_segment_array_create(struct ssdfs_fs_info *fsi)
+{
+	struct ssdfs_segment_info *si;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+	BUG_ON(!rwsem_is_locked(&fsi->volume_sem));
+
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi->cur_segs =
+		ssdfs_cur_seg_kzalloc(sizeof(struct ssdfs_current_segs_array),
+					     GFP_KERNEL);
+	if (!fsi->cur_segs) {
+		SSDFS_ERR("fail to allocate current segments array\n");
+		return -ENOMEM;
+	}
+
+	init_rwsem(&fsi->cur_segs->lock);
+
+	for (i = 0; i < SSDFS_CUR_SEGS_COUNT; i++) {
+		u64 seg;
+		size_t offset = i * sizeof(struct ssdfs_current_segment);
+		u8 *start_ptr = fsi->cur_segs->buffer;
+		struct ssdfs_current_segment *object = NULL;
+		int seg_state, seg_type;
+		u16 log_pages;
+
+		object = (struct ssdfs_current_segment *)(start_ptr + offset);
+		fsi->cur_segs->objects[i] = object;
+		seg = le64_to_cpu(fsi->vs->cur_segs[i]);
+
+		ssdfs_current_segment_init(fsi, i, seg, object);
+
+		if (seg == U64_MAX)
+			continue;
+
+		switch (i) {
+		case SSDFS_CUR_DATA_SEG:
+		case SSDFS_CUR_DATA_UPDATE_SEG:
+			seg_state = SSDFS_SEG_DATA_USING;
+			seg_type = SSDFS_USER_DATA_SEG_TYPE;
+			log_pages = le16_to_cpu(fsi->vh->user_data_log_pages);
+			break;
+
+		case SSDFS_CUR_LNODE_SEG:
+			seg_state = SSDFS_SEG_LEAF_NODE_USING;
+			seg_type = SSDFS_LEAF_NODE_SEG_TYPE;
+			log_pages = le16_to_cpu(fsi->vh->lnodes_seg_log_pages);
+			break;
+
+		case SSDFS_CUR_HNODE_SEG:
+			seg_state = SSDFS_SEG_HYBRID_NODE_USING;
+			seg_type = SSDFS_HYBRID_NODE_SEG_TYPE;
+			log_pages = le16_to_cpu(fsi->vh->hnodes_seg_log_pages);
+			break;
+
+		case SSDFS_CUR_IDXNODE_SEG:
+			seg_state = SSDFS_SEG_INDEX_NODE_USING;
+			seg_type = SSDFS_INDEX_NODE_SEG_TYPE;
+			log_pages = le16_to_cpu(fsi->vh->inodes_seg_log_pages);
+			break;
+
+		default:
+			BUG();
+		};
+
+		si = __ssdfs_create_new_segment(fsi, seg,
+						seg_state, seg_type,
+						log_pages,
+						fsi->create_threads_per_seg);
+		if (IS_ERR_OR_NULL(si)) {
+			err = (si == NULL ? -ENOMEM : PTR_ERR(si));
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto destroy_cur_segs;
+			} else {
+				SSDFS_WARN("fail to create segment object: "
+					   "seg %llu, err %d\n",
+					   seg, err);
+				goto destroy_cur_segs;
+			}
+		}
+
+		ssdfs_current_segment_lock(object);
+		err = ssdfs_current_segment_add(object, si);
+		ssdfs_current_segment_unlock(object);
+
+		if (err == -ENOSPC) {
+			err = ssdfs_segment_change_state(si);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change segment's state: "
+					  "seg %llu, err %d\n",
+					  seg, err);
+				goto destroy_cur_segs;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("current segment is absent\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+			ssdfs_segment_put_object(si);
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to make segment %llu as current: "
+				  "err %d\n",
+				  seg, err);
+			goto destroy_cur_segs;
+		} else {
+			/*
+			 * Segment object was referenced two times
+			 * in __ssdfs_create_new_segment() and
+			 * ssdfs_current_segment_add().
+			 */
+			ssdfs_segment_put_object(si);
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("DONE: create current segment array\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+
+destroy_cur_segs:
+	for (; i >= 0; i--) {
+		struct ssdfs_current_segment *cur_seg;
+
+		cur_seg = fsi->cur_segs->objects[i];
+
+		ssdfs_current_segment_lock(cur_seg);
+		ssdfs_current_segment_remove(cur_seg);
+		ssdfs_current_segment_unlock(cur_seg);
+	}
+
+	ssdfs_cur_seg_kfree(fsi->cur_segs);
+	fsi->cur_segs = NULL;
+
+	return err;
+}
+
+/*
+ * ssdfs_destroy_all_curent_segments() - destroy all current segments
+ * @fsi: pointer on shared file system object
+ */
+void ssdfs_destroy_all_curent_segments(struct ssdfs_fs_info *fsi)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi->cur_segs %p\n", fsi->cur_segs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!fsi->cur_segs)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(rwsem_is_locked(&fsi->cur_segs->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&fsi->cur_segs->lock);
+	for (i = 0; i < SSDFS_CUR_SEGS_COUNT; i++)
+		ssdfs_current_segment_destroy(fsi->cur_segs->objects[i]);
+	up_write(&fsi->cur_segs->lock);
+}
+
+/*
+ * ssdfs_current_segment_array_destroy() - destroy current segments array
+ * @fsi: pointer on shared file system object
+ */
+void ssdfs_current_segment_array_destroy(struct ssdfs_fs_info *fsi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi->cur_segs %p\n", fsi->cur_segs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!fsi->cur_segs)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(rwsem_is_locked(&fsi->cur_segs->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_cur_seg_kfree(fsi->cur_segs);
+	fsi->cur_segs = NULL;
+}
diff --git a/fs/ssdfs/current_segment.h b/fs/ssdfs/current_segment.h
new file mode 100644
index 000000000000..668ab3311b59
--- /dev/null
+++ b/fs/ssdfs/current_segment.h
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/current_segment.h - current segment abstraction declarations.
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
+#ifndef _SSDFS_CURRENT_SEGMENT_H
+#define _SSDFS_CURRENT_SEGMENT_H
+
+/*
+ * struct ssdfs_current_segment - current segment container
+ * @lock: exclusive lock of current segment object
+ * @type: current segment type
+ * @seg_id: last known segment ID
+ * @real_seg: concrete current segment
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_current_segment {
+	struct mutex lock;
+	int type;
+	u64 seg_id;
+	struct ssdfs_segment_info *real_seg;
+	struct ssdfs_fs_info *fsi;
+};
+
+/*
+ * struct ssdfs_current_segs_array - array of current segments
+ * @lock: current segments array's lock
+ * @objects: array of pointers on current segment objects
+ * @buffer: buffer for all current segment objects
+ */
+struct ssdfs_current_segs_array {
+	struct rw_semaphore lock;
+	struct ssdfs_current_segment *objects[SSDFS_CUR_SEGS_COUNT];
+	u8 buffer[sizeof(struct ssdfs_current_segment) * SSDFS_CUR_SEGS_COUNT];
+};
+
+/*
+ * Inline functions
+ */
+static inline
+bool is_ssdfs_current_segment_empty(struct ssdfs_current_segment *cur_seg)
+{
+	return cur_seg->real_seg == NULL;
+}
+
+/*
+ * Current segment container's API
+ */
+int ssdfs_current_segment_array_create(struct ssdfs_fs_info *fsi);
+void ssdfs_destroy_all_curent_segments(struct ssdfs_fs_info *fsi);
+void ssdfs_current_segment_array_destroy(struct ssdfs_fs_info *fsi);
+
+void ssdfs_current_segment_lock(struct ssdfs_current_segment *cur_seg);
+void ssdfs_current_segment_unlock(struct ssdfs_current_segment *cur_seg);
+
+int ssdfs_current_segment_add(struct ssdfs_current_segment *cur_seg,
+			      struct ssdfs_segment_info *si);
+void ssdfs_current_segment_remove(struct ssdfs_current_segment *cur_seg);
+
+#endif /* _SSDFS_CURRENT_SEGMENT_H */
diff --git a/fs/ssdfs/segment.c b/fs/ssdfs/segment.c
index 9496b18aa1f3..bf61804980cc 100644
--- a/fs/ssdfs/segment.c
+++ b/fs/ssdfs/segment.c
@@ -3739,3 +3739,1524 @@ int ssdfs_segment_add_index_node_extent_async(struct ssdfs_fs_info *fsi,
 						SSDFS_PEB_CREATE_IDXNODE_REQ,
 						req, seg_id, extent);
 }
+
+static inline
+int ssdfs_account_user_data_pages_as_pending(struct ssdfs_peb_container *pebc,
+					     u32 count)
+{
+	struct ssdfs_fs_info *fsi;
+	u64 updated = 0;
+	u32 pending = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebc->parent_si->fsi;
+
+	if (!is_ssdfs_peb_containing_user_data(pebc))
+		return 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_index %u, count %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&fsi->volume_state_lock);
+	updated = fsi->updated_user_data_pages;
+	if (fsi->updated_user_data_pages >= count) {
+		fsi->updated_user_data_pages -= count;
+	} else {
+		err = -ERANGE;
+		fsi->updated_user_data_pages = 0;
+	}
+	spin_unlock(&fsi->volume_state_lock);
+
+	if (err) {
+		SSDFS_WARN("count %u is bigger than updated %llu\n",
+			  count, updated);
+
+		spin_lock(&pebc->pending_lock);
+		pebc->pending_updated_user_data_pages += updated;
+		pending = pebc->pending_updated_user_data_pages;
+		spin_unlock(&pebc->pending_lock);
+	} else {
+		spin_lock(&pebc->pending_lock);
+		pebc->pending_updated_user_data_pages += count;
+		pending = pebc->pending_updated_user_data_pages;
+		spin_unlock(&pebc->pending_lock);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_index %u, "
+		  "updated %llu, pending %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  updated, pending);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * __ssdfs_segment_update_block() - update block in segment
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to update a block in segment.
+ */
+static
+int __ssdfs_segment_update_block(struct ssdfs_segment_info *si,
+				 struct ssdfs_segment_request *req)
+{
+	struct ssdfs_blk2off_table *table;
+	struct ssdfs_phys_offset_descriptor *po_desc;
+	struct ssdfs_peb_container *pebc;
+	struct ssdfs_requests_queue *rq;
+	wait_queue_head_t *wait;
+	struct ssdfs_offset_position pos = {0};
+	u16 peb_index = U16_MAX;
+	u16 logical_blk;
+	u16 len;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#else
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, blks %u, "
+		  "cno %llu, parent_snapshot %llu\n",
+		  si->seg_id,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->place.len,
+		  req->extent.cno, req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	table = si->blk2off_table;
+	logical_blk = req->place.start.blk_index;
+	len = req->place.len;
+
+	po_desc = ssdfs_blk2off_table_convert(table, logical_blk,
+						&peb_index, NULL, &pos);
+	if (IS_ERR(po_desc) && PTR_ERR(po_desc) == -EAGAIN) {
+		struct completion *end;
+		end = &table->full_init_end;
+
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("blk2off init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		po_desc = ssdfs_blk2off_table_convert(table, logical_blk,
+							&peb_index, NULL,
+							&pos);
+	}
+
+	if (IS_ERR_OR_NULL(po_desc)) {
+		err = (po_desc == NULL ? -ERANGE : PTR_ERR(po_desc));
+		SSDFS_ERR("fail to convert: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		return err;
+	}
+
+	if (peb_index >= si->pebs_count) {
+		SSDFS_ERR("peb_index %u >= si->pebs_count %u\n",
+			  peb_index, si->pebs_count);
+		return -ERANGE;
+	}
+
+	pebc = &si->peb_array[peb_index];
+	rq = &pebc->update_rq;
+
+	if (req->private.cmd != SSDFS_COMMIT_LOG_NOW) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+			  "logical_blk %u, data_bytes %u, blks %u, "
+			  "cno %llu, parent_snapshot %llu\n",
+			  si->seg_id,
+			  req->extent.ino, req->extent.logical_offset,
+			  req->place.start.blk_index,
+			  req->extent.data_bytes, req->place.len,
+			  req->extent.cno, req->extent.parent_snapshot);
+		SSDFS_DBG("req->private.class %#x, req->private.cmd %#x\n",
+			  req->private.class, req->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (len > 0) {
+			err = ssdfs_account_user_data_pages_as_pending(pebc,
+									len);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to make pages as pending: "
+					  "len %u, err %d\n",
+					  len, err);
+				return err;
+			}
+		} else {
+			SSDFS_WARN("unexpected len %u\n", len);
+		}
+	}
+
+	ssdfs_account_user_data_flush_request(si);
+	ssdfs_segment_create_request_cno(si);
+
+	switch (req->private.class) {
+	case SSDFS_PEB_COLLECT_GARBAGE_REQ:
+		ssdfs_requests_queue_add_head_inc(si->fsi, rq, req);
+		break;
+
+	default:
+		ssdfs_requests_queue_add_tail_inc(si->fsi, rq, req);
+		break;
+	}
+
+	wait = &si->wait_queue[SSDFS_PEB_FLUSH_THREAD];
+	wake_up_all(wait);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_segment_update_block_sync() - update block synchronously
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to update the block synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_update_block_sync(struct ssdfs_segment_info *si,
+				    struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_UPDATE_BLOCK,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_block(si, req);
+}
+
+/*
+ * ssdfs_segment_update_block_async() - update block asynchronously
+ * @si: segment info
+ * @req_type: request type
+ * @req: segment request [in|out]
+ *
+ * This function tries to update the block asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_update_block_async(struct ssdfs_segment_info *si,
+				     int req_type,
+				     struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_UPDATE_BLOCK,
+					    req_type, req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_block(si, req);
+}
+
+/*
+ * __ssdfs_segment_update_extent() - update extent in segment
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to update an extent in segment.
+ */
+static
+int __ssdfs_segment_update_extent(struct ssdfs_segment_info *si,
+				  struct ssdfs_segment_request *req)
+{
+	struct ssdfs_blk2off_table *table;
+	struct ssdfs_phys_offset_descriptor *po_desc;
+	struct ssdfs_peb_container *pebc;
+	struct ssdfs_requests_queue *rq;
+	wait_queue_head_t *wait;
+	u16 blk, len;
+	u16 peb_index = U16_MAX;
+	struct ssdfs_offset_position pos = {0};
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, ino %llu, logical_offset %llu, "
+		  "logical_blk %u, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->place.start.blk_index,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#else
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "logical_blk %u, data_bytes %u, blks %u, "
+		  "cno %llu, parent_snapshot %llu\n",
+		  si->seg_id,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->place.start.blk_index,
+		  req->extent.data_bytes, req->place.len,
+		  req->extent.cno, req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	table = si->blk2off_table;
+	blk = req->place.start.blk_index;
+	len = req->place.len;
+
+	if (len == 0) {
+		SSDFS_WARN("empty extent\n");
+		return -ERANGE;
+	}
+
+	for (i = 0; i < len; i++) {
+		u16 cur_peb_index = U16_MAX;
+
+		po_desc = ssdfs_blk2off_table_convert(table, blk + i,
+							&cur_peb_index,
+							NULL, &pos);
+		if (IS_ERR(po_desc) && PTR_ERR(po_desc) == -EAGAIN) {
+			struct completion *end;
+			end = &table->full_init_end;
+
+			err = SSDFS_WAIT_COMPLETION(end);
+			if (unlikely(err)) {
+				SSDFS_ERR("blk2off init failed: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			po_desc = ssdfs_blk2off_table_convert(table, blk + i,
+								&cur_peb_index,
+								NULL, &pos);
+		}
+
+		if (IS_ERR_OR_NULL(po_desc)) {
+			err = (po_desc == NULL ? -ERANGE : PTR_ERR(po_desc));
+			SSDFS_ERR("fail to convert: "
+				  "logical_blk %u, err %d\n",
+				  blk + i, err);
+			return err;
+		}
+
+		if (cur_peb_index >= U16_MAX) {
+			SSDFS_ERR("invalid peb_index\n");
+			return -ERANGE;
+		}
+
+		if (peb_index == U16_MAX)
+			peb_index = cur_peb_index;
+		else if (peb_index != cur_peb_index) {
+			SSDFS_ERR("peb_index %u != cur_peb_index %u\n",
+				  peb_index, cur_peb_index);
+			return -ERANGE;
+		}
+	}
+
+	if (peb_index >= si->pebs_count) {
+		SSDFS_ERR("peb_index %u >= si->pebs_count %u\n",
+			  peb_index, si->pebs_count);
+		return -ERANGE;
+	}
+
+	pebc = &si->peb_array[peb_index];
+	rq = &pebc->update_rq;
+
+	if (req->private.cmd != SSDFS_COMMIT_LOG_NOW) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+			  "logical_blk %u, data_bytes %u, blks %u, "
+			  "cno %llu, parent_snapshot %llu\n",
+			  si->seg_id,
+			  req->extent.ino, req->extent.logical_offset,
+			  req->place.start.blk_index,
+			  req->extent.data_bytes, req->place.len,
+			  req->extent.cno, req->extent.parent_snapshot);
+		SSDFS_DBG("req->private.class %#x, req->private.cmd %#x\n",
+			  req->private.class, req->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (len > 0) {
+			err = ssdfs_account_user_data_pages_as_pending(pebc,
+									len);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to make pages as pending: "
+					  "len %u, err %d\n",
+					  len, err);
+				return err;
+			}
+		} else {
+			SSDFS_WARN("unexpected len %u\n", len);
+		}
+	}
+
+	ssdfs_account_user_data_flush_request(si);
+	ssdfs_segment_create_request_cno(si);
+
+	switch (req->private.class) {
+	case SSDFS_PEB_COLLECT_GARBAGE_REQ:
+		ssdfs_requests_queue_add_head_inc(si->fsi, rq, req);
+		break;
+
+	default:
+		ssdfs_requests_queue_add_tail_inc(si->fsi, rq, req);
+		break;
+	}
+
+	wait = &si->wait_queue[SSDFS_PEB_FLUSH_THREAD];
+	wake_up_all(wait);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_segment_update_extent_sync() - update extent synchronously
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to update the extent synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_update_extent_sync(struct ssdfs_segment_info *si,
+				     struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_UPDATE_EXTENT,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_update_extent_async() - update extent asynchronously
+ * @si: segment info
+ * @req_type: request type
+ * @req: segment request [in|out]
+ *
+ * This function tries to update the extent asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_update_extent_async(struct ssdfs_segment_info *si,
+				      int req_type,
+				      struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_UPDATE_EXTENT,
+					    req_type, req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_update_pre_alloc_block_sync() - update pre-allocated block
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to update the pre-allocated block synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_update_pre_alloc_block_sync(struct ssdfs_segment_info *si,
+					    struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_PRE_ALLOC_UPDATE_REQ,
+					    SSDFS_UPDATE_PRE_ALLOC_BLOCK,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_update_pre_alloc_block_async() - update pre-allocated block
+ * @si: segment info
+ * @req_type: request type
+ * @req: segment request [in|out]
+ *
+ * This function tries to update the pre-allocated block asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_update_pre_alloc_block_async(struct ssdfs_segment_info *si,
+					    int req_type,
+					    struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_PRE_ALLOC_UPDATE_REQ,
+					    SSDFS_UPDATE_PRE_ALLOC_BLOCK,
+					    req_type, req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_update_pre_alloc_extent_sync() - update pre-allocated extent
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to update the pre-allocated extent synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_update_pre_alloc_extent_sync(struct ssdfs_segment_info *si,
+					    struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_PRE_ALLOC_UPDATE_REQ,
+					    SSDFS_UPDATE_PRE_ALLOC_EXTENT,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_update_pre_alloc_extent_async() - update pre-allocated extent
+ * @si: segment info
+ * @req_type: request type
+ * @req: segment request [in|out]
+ *
+ * This function tries to update the pre-allocated extent asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_update_pre_alloc_extent_async(struct ssdfs_segment_info *si,
+					    int req_type,
+					    struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_PRE_ALLOC_UPDATE_REQ,
+					    SSDFS_UPDATE_PRE_ALLOC_EXTENT,
+					    req_type, req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_node_diff_on_write_sync() - Diff-On-Write btree node
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to execute Diff-On-Write operation
+ * on btree node synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_node_diff_on_write_sync(struct ssdfs_segment_info *si,
+					  struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_DIFF_ON_WRITE_REQ,
+					    SSDFS_BTREE_NODE_DIFF,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_node_diff_on_write_async() - Diff-On-Write btree node
+ * @si: segment info
+ * @req_type: request type
+ * @req: segment request [in|out]
+ *
+ * This function tries to execute Diff-On-Write operation
+ * on btree node asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_node_diff_on_write_async(struct ssdfs_segment_info *si,
+					   int req_type,
+					   struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_DIFF_ON_WRITE_REQ,
+					    SSDFS_BTREE_NODE_DIFF,
+					    req_type, req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_data_diff_on_write_sync() - Diff-On-Write user data
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to execute Diff-On-Write operation
+ * on user data synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_data_diff_on_write_sync(struct ssdfs_segment_info *si,
+					  struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_DIFF_ON_WRITE_REQ,
+					    SSDFS_USER_DATA_DIFF,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_block(si, req);
+}
+
+/*
+ * ssdfs_segment_data_diff_on_write_async() - Diff-On-Write user data
+ * @si: segment info
+ * @req_type: request type
+ * @req: segment request [in|out]
+ *
+ * This function tries to execute Diff-On-Write operation
+ * on user data asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_data_diff_on_write_async(struct ssdfs_segment_info *si,
+					   int req_type,
+					   struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_DIFF_ON_WRITE_REQ,
+					    SSDFS_USER_DATA_DIFF,
+					    req_type, req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_block(si, req);
+}
+
+/*
+ * ssdfs_segment_prepare_migration_sync() - request to prepare migration
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to request to prepare or to start the migration
+ * synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_prepare_migration_sync(struct ssdfs_segment_info *si,
+					 struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_START_MIGRATION_NOW,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_prepare_migration_async() - request to prepare migration
+ * @si: segment info
+ * @req_type: request type
+ * @req: segment request [in|out]
+ *
+ * This function tries to request to prepare or to start the migration
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_prepare_migration_async(struct ssdfs_segment_info *si,
+					  int req_type,
+					  struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_START_MIGRATION_NOW,
+					    req_type, req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_commit_log_sync() - request the commit log operation
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to request the commit log operation
+ * synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_commit_log_sync(struct ssdfs_segment_info *si,
+				  struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_COMMIT_LOG_NOW,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_commit_log_async() - request the commit log operation
+ * @si: segment info
+ * @req_type: request type
+ * @req: segment request [in|out]
+ *
+ * This function tries to request the commit log operation
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_commit_log_async(struct ssdfs_segment_info *si,
+				   int req_type,
+				   struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_COMMIT_LOG_NOW,
+					    req_type, req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * __ssdfs_segment_commit_log2() - request the commit log operation
+ * @si: segment info
+ * @peb_index: PEB's index
+ * @req: segment request [in|out]
+ *
+ * This function tries to request the commit log operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_segment_commit_log2(struct ssdfs_segment_info *si,
+				u16 peb_index,
+				struct ssdfs_segment_request *req)
+{
+	struct ssdfs_peb_container *pebc;
+	struct ssdfs_requests_queue *rq;
+	wait_queue_head_t *wait;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, peb_index, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (peb_index >= si->pebs_count) {
+		SSDFS_ERR("peb_index %u >= si->pebs_count %u\n",
+			  peb_index, si->pebs_count);
+		return -ERANGE;
+	}
+
+	ssdfs_account_user_data_flush_request(si);
+	ssdfs_segment_create_request_cno(si);
+
+	pebc = &si->peb_array[peb_index];
+	rq = &pebc->update_rq;
+
+	switch (req->private.class) {
+	case SSDFS_PEB_COLLECT_GARBAGE_REQ:
+		ssdfs_requests_queue_add_head_inc(si->fsi, rq, req);
+		break;
+
+	default:
+		ssdfs_requests_queue_add_tail_inc(si->fsi, rq, req);
+		break;
+	}
+
+	wait = &si->wait_queue[SSDFS_PEB_FLUSH_THREAD];
+	wake_up_all(wait);
+
+	return 0;
+}
+
+/*
+ * ssdfs_segment_commit_log_sync2() - request the commit log operation
+ * @si: segment info
+ * @peb_index: PEB's index
+ * @req: segment request [in|out]
+ *
+ * This function tries to request the commit log operation
+ * synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_commit_log_sync2(struct ssdfs_segment_info *si,
+				   u16 peb_index,
+				   struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, peb_index, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_COMMIT_LOG_NOW,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_commit_log2(si, peb_index, req);
+}
+
+/*
+ * ssdfs_segment_commit_log_async2() - request the commit log operation
+ * @si: segment info
+ * @req_type: request type
+ * @peb_index: PEB's index
+ * @req: segment request [in|out]
+ *
+ * This function tries to request the commit log operation
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_commit_log_async2(struct ssdfs_segment_info *si,
+				    int req_type, u16 peb_index,
+				    struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, peb_index, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_COMMIT_LOG_NOW,
+					    req_type, req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_commit_log2(si, peb_index, req);
+}
+
+/*
+ * ssdfs_segment_invalidate_logical_extent() - invalidate logical extent
+ * @si: segment info
+ * @start_off: starting logical block
+ * @blks_count: count of logical blocks in the extent
+ *
+ * This function tries to invalidate extent of logical blocks.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_invalidate_logical_extent(struct ssdfs_segment_info *si,
+					    u32 start_off, u32 blks_count)
+{
+	struct ssdfs_blk2off_table *blk2off_tbl;
+	struct ssdfs_phys_offset_descriptor *off_desc = NULL;
+	struct ssdfs_phys_offset_descriptor old_desc;
+	size_t desc_size = sizeof(struct ssdfs_phys_offset_descriptor);
+	u32 blk;
+	u32 upper_blk = start_off + blks_count;
+	struct completion *init_end;
+	struct ssdfs_offset_position pos = {0};
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("si %p, seg %llu, start_off %u, blks_count %u\n",
+		  si, si->seg_id, start_off, blks_count);
+#else
+	SSDFS_DBG("si %p, seg %llu, start_off %u, blks_count %u\n",
+		  si, si->seg_id, start_off, blks_count);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	blk2off_tbl = si->blk2off_table;
+
+	ssdfs_account_invalidated_user_data_pages(si, blks_count);
+
+	for (blk = start_off; blk < upper_blk; blk++) {
+		struct ssdfs_segment_request *req;
+		struct ssdfs_peb_container *pebc;
+		struct ssdfs_requests_queue *rq;
+		wait_queue_head_t *wait;
+		u16 peb_index = U16_MAX;
+		u16 peb_page;
+
+		if (blk >= U16_MAX) {
+			SSDFS_ERR("invalid logical block number: %u\n",
+				  blk);
+			return -ERANGE;
+		}
+
+		off_desc = ssdfs_blk2off_table_convert(blk2off_tbl,
+							(u16)blk,
+							&peb_index,
+							NULL, &pos);
+		if (PTR_ERR(off_desc) == -EAGAIN) {
+			init_end = &blk2off_tbl->full_init_end;
+
+			err = SSDFS_WAIT_COMPLETION(init_end);
+			if (unlikely(err)) {
+				SSDFS_ERR("blk2off init failed: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			off_desc = ssdfs_blk2off_table_convert(blk2off_tbl,
+								(u16)blk,
+								&peb_index,
+								NULL,
+								&pos);
+		}
+
+		if (IS_ERR_OR_NULL(off_desc)) {
+			err = !off_desc ? -ERANGE : PTR_ERR(off_desc);
+			SSDFS_ERR("fail to convert logical block: "
+				  "blk %u, err %d\n",
+				  blk, err);
+			return err;
+		}
+
+		ssdfs_memcpy(&old_desc, 0, desc_size,
+			     off_desc, 0, desc_size,
+			     desc_size);
+
+		peb_page = le16_to_cpu(old_desc.page_desc.peb_page);
+
+		if (peb_index >= si->pebs_count) {
+			SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+				  peb_index, si->pebs_count);
+			return -ERANGE;
+		}
+
+		pebc = &si->peb_array[peb_index];
+
+		err = ssdfs_blk2off_table_free_block(blk2off_tbl,
+						     peb_index,
+						     (u16)blk);
+		if (err == -EAGAIN) {
+			init_end = &blk2off_tbl->full_init_end;
+
+			err = SSDFS_WAIT_COMPLETION(init_end);
+			if (unlikely(err)) {
+				SSDFS_ERR("blk2off init failed: "
+					  "err %d\n", err);
+				return err;
+			}
+
+			err = ssdfs_blk2off_table_free_block(blk2off_tbl,
+							     peb_index,
+							     (u16)blk);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to free logical block: "
+				  "blk %u, err %d\n",
+				  blk, err);
+			return err;
+		}
+
+		mutex_lock(&pebc->migration_lock);
+
+		err = ssdfs_peb_container_invalidate_block(pebc, &old_desc);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to invalidate: "
+				  "logical_blk %u, peb_index %u, "
+				  "err %d\n",
+				  blk, peb_index, err);
+			goto finish_invalidate_block;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("valid_blks %d, invalid_blks %d\n",
+			  atomic_read(&si->blk_bmap.seg_valid_blks),
+			  atomic_read(&si->blk_bmap.seg_invalid_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req)) {
+			err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+			SSDFS_ERR("fail to allocate segment request: err %d\n",
+				  err);
+			goto finish_invalidate_block;
+		}
+
+		ssdfs_request_init(req);
+		ssdfs_get_request(req);
+
+		ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+					    SSDFS_EXTENT_WAS_INVALIDATED,
+					    SSDFS_REQ_ASYNC, req);
+		ssdfs_request_define_segment(si->seg_id, req);
+
+		ssdfs_account_user_data_flush_request(si);
+		ssdfs_segment_create_request_cno(si);
+
+		rq = &pebc->update_rq;
+		ssdfs_requests_queue_add_tail_inc(si->fsi, rq, req);
+
+finish_invalidate_block:
+		mutex_unlock(&pebc->migration_lock);
+
+		if (unlikely(err))
+			return err;
+
+		wait = &si->wait_queue[SSDFS_PEB_FLUSH_THREAD];
+		wake_up_all(wait);
+	}
+
+	err = ssdfs_segment_change_state(si);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change segment state: "
+			  "seg %llu, err %d\n",
+			  si->seg_id, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_segment_invalidate_logical_block() - invalidate logical block
+ * @si: segment info
+ * @blk_offset: logical block number
+ *
+ * This function tries to invalidate a logical block.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_invalidate_logical_block(struct ssdfs_segment_info *si,
+					   u32 blk_offset)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+
+	SSDFS_DBG("si %p, seg %llu, blk_offset %u\n",
+		  si, si->seg_id, blk_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ssdfs_segment_invalidate_logical_extent(si, blk_offset, 1);
+}
+
+/*
+ * ssdfs_segment_migrate_range_async() - migrate range by flush thread
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to migrate the range by flush thread
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_migrate_range_async(struct ssdfs_segment_info *si,
+				      struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_COLLECT_GARBAGE_REQ,
+					    SSDFS_MIGRATE_RANGE,
+					    SSDFS_REQ_ASYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_migrate_pre_alloc_page_async() - migrate page by flush thread
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to migrate the pre-allocated page by flush thread
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_migrate_pre_alloc_page_async(struct ssdfs_segment_info *si,
+					    struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_COLLECT_GARBAGE_REQ,
+					    SSDFS_MIGRATE_PRE_ALLOC_PAGE,
+					    SSDFS_REQ_ASYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
+
+/*
+ * ssdfs_segment_migrate_fragment_async() - migrate fragment by flush thread
+ * @si: segment info
+ * @req: segment request [in|out]
+ *
+ * This function tries to migrate the fragment by flush thread
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_migrate_fragment_async(struct ssdfs_segment_info *si,
+					 struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_COLLECT_GARBAGE_REQ,
+					    SSDFS_MIGRATE_FRAGMENT,
+					    SSDFS_REQ_ASYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_update_extent(si, req);
+}
-- 
2.34.1


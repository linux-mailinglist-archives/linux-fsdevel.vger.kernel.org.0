Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09A46A2643
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBYBRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBYBQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:47 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F317125AF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:35 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bh20so792098oib.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKa22wtce+DWoyIhrWY3cXyJT9fBmG2vw46A6+4YMDc=;
        b=P8JOH+DU+XMgRU7RjvbY43TilUaROOTJKi6M6TeuTZFjqYB/ktRxzQPoFUlHUfs3Y9
         UfLSOKevx2QeHGguebNJKT3zOF1Q8px2ZWSrJ/DWqh/Iq69hDbDBBvGNAw00HUrnmF+4
         xP+kQNLEe7PoJ6i7lCKB9ct5smdScvqB7yWilo4BWJLZHD5YRJ+kBV91lQ7+DNrdItAj
         rgKnXb81zVOrxistLlc9Hp/XcRGnBEDVQFOCn90Ytbx9tZvyPbl7b19xOH1vdNhTqOX9
         KHg8hjY6BdAt5WhmKIkYxYP7HXykQ6eSoWtAA5ylkd8kLs+22aQhEf4tHq8doiQzz3yG
         tAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKa22wtce+DWoyIhrWY3cXyJT9fBmG2vw46A6+4YMDc=;
        b=GMvuiReFabgjFdw6aG5PlksXYBYNt/8EkvgthQXKt4EgX5uzAXxquLrNyPgi3DzTTd
         Jt/Vi4ECnS+iIv4iaIF6WkvkX4NWUt3uFMaSyJMjF7GZELyQJLvKc5SDoKH+yQfK5DUS
         1DdCDx6lEYkLMY6jSsDAcNpF2uHfiiWqgC8jmxac5ycXiNMJkkPNSM+l3kBh9hnnLVKQ
         Wehky1WqGJLatTMdUSP4IcAUxiWMODbdwq1SI31stDNqlS7RzkNN8w3RhSC4s3Jejzzc
         19bfpVMpx5BH1GcGHYnUoi0FtHIcMw6YRWB/OFBruiXFAWSiQuYdLd/zQvL+L1/LNdoO
         Exfw==
X-Gm-Message-State: AO0yUKVZP9An7ZzTEK8Y781KwSMnTB4t82nRyAQd1JITP1yRbNlUyJaY
        1BfJlSJneP6pVRecDHce6t9nxf/rLrxD2Rru
X-Google-Smtp-Source: AK7set9FONSQrZetizfVjAXdf2l41g4kB7NN/QiuwdO8vh0ZAY8AKHbVJOum7ejbMi+oRDn9j9abHQ==
X-Received: by 2002:a05:6808:a97:b0:37f:978d:45ba with SMTP id q23-20020a0568080a9700b0037f978d45bamr7552913oij.37.1677287793821;
        Fri, 24 Feb 2023 17:16:33 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:33 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 28/76] ssdfs: PEB flush thread's finite state machine
Date:   Fri, 24 Feb 2023 17:08:39 -0800
Message-Id: <20230225010927.813929-29-slava@dubeyko.com>
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

"Physical" Erase Block (PEB) has flush thread that implements
logic of log preparation and commit/flush. Segment object
has create queue that could contain requests for adding new
data or metadata. PEB container object has update queue that
contains requests to update existing data. Caller is responsible
for allocation, preparation, and adding request(s) into particular
queue (create or update). Then flush thread needs to be woken up.
Flush thread checks the state of queues, takes request by request,
and execute requests. If full log is prepared in memory or
commit is requested, then flush thread commits the prepared log
into storage device to make it persistent.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_flush_thread.c | 3364 +++++++++++++++++++++++++++++++++++
 1 file changed, 3364 insertions(+)
 create mode 100644 fs/ssdfs/peb_flush_thread.c

diff --git a/fs/ssdfs/peb_flush_thread.c b/fs/ssdfs/peb_flush_thread.c
new file mode 100644
index 000000000000..6a9032762ea6
--- /dev/null
+++ b/fs/ssdfs/peb_flush_thread.c
@@ -0,0 +1,3364 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_flush_thread.c - flush thread functionality.
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
+#include <linux/kthread.h>
+#include <linux/pagevec.h>
+#include <linux/delay.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "compression.h"
+#include "page_vector.h"
+#include "block_bitmap.h"
+#include "peb_block_bitmap.h"
+#include "segment_block_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "peb.h"
+#include "peb_container.h"
+#include "segment_bitmap.h"
+#include "segment.h"
+#include "current_segment.h"
+#include "peb_mapping_table.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "extents_tree.h"
+#include "diff_on_write.h"
+#include "invalidated_extents_tree.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_flush_page_leaks;
+atomic64_t ssdfs_flush_memory_leaks;
+atomic64_t ssdfs_flush_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_flush_cache_leaks_increment(void *kaddr)
+ * void ssdfs_flush_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_flush_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_flush_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_flush_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_flush_kfree(void *kaddr)
+ * struct page *ssdfs_flush_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_flush_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_flush_free_page(struct page *page)
+ * void ssdfs_flush_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(flush)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(flush)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_flush_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_flush_page_leaks, 0);
+	atomic64_set(&ssdfs_flush_memory_leaks, 0);
+	atomic64_set(&ssdfs_flush_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_flush_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_flush_page_leaks) != 0) {
+		SSDFS_ERR("FLUSH THREAD: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_flush_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_flush_memory_leaks) != 0) {
+		SSDFS_ERR("FLUSH THREAD: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_flush_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_flush_cache_leaks) != 0) {
+		SSDFS_ERR("FLUSH THREAD: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_flush_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/******************************************************************************
+ *                         FLUSH THREAD FUNCTIONALITY                         *
+ ******************************************************************************/
+
+/*
+ * __ssdfs_finish_request() - common logic of request's finishing
+ * @pebc: pointer on PEB container
+ * @req: request
+ * @wait: wait queue head
+ * @err: error of processing request
+ */
+static
+void __ssdfs_finish_request(struct ssdfs_peb_container *pebc,
+			    struct ssdfs_segment_request *req,
+			    wait_queue_head_t *wait,
+			    int err)
+{
+	u32 pagesize;
+	u32 processed_bytes_max;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req);
+
+	SSDFS_DBG("req %p, cmd %#x, type %#x, err %d\n",
+		  req, req->private.cmd, req->private.type, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pagesize = pebc->parent_si->fsi->pagesize;
+	processed_bytes_max = req->result.processed_blks * pagesize;
+
+	if (req->extent.data_bytes > processed_bytes_max) {
+		SSDFS_WARN("data_bytes %u > processed_bytes_max %u\n",
+			   req->extent.data_bytes,
+			   processed_bytes_max);
+	}
+
+	req->result.err = err;
+
+	switch (req->private.type) {
+	case SSDFS_REQ_SYNC:
+		/* do nothing */
+		break;
+
+	case SSDFS_REQ_ASYNC:
+		ssdfs_free_flush_request_pages(req);
+		pagevec_reinit(&req->result.pvec);
+		break;
+
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		ssdfs_free_flush_request_pages(req);
+		pagevec_reinit(&req->result.pvec);
+		break;
+
+	default:
+		BUG();
+	};
+
+	switch (req->private.type) {
+	case SSDFS_REQ_SYNC:
+		if (err) {
+			SSDFS_DBG("failure: req %p, err %d\n", req, err);
+			atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+		} else
+			atomic_set(&req->result.state, SSDFS_REQ_FINISHED);
+
+		complete(&req->result.wait);
+		wake_up_all(&req->private.wait_queue);
+		break;
+
+	case SSDFS_REQ_ASYNC:
+		ssdfs_put_request(req);
+
+		if (err) {
+			SSDFS_DBG("failure: req %p, err %d\n", req, err);
+			atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+		} else
+			atomic_set(&req->result.state, SSDFS_REQ_FINISHED);
+
+		complete(&req->result.wait);
+
+		if (atomic_read(&req->private.refs_count) != 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("start waiting: refs_count %d\n",
+				   atomic_read(&req->private.refs_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = wait_event_killable_timeout(*wait,
+			    atomic_read(&req->private.refs_count) == 0,
+			    SSDFS_DEFAULT_TIMEOUT);
+			if (err < 0)
+				WARN_ON(err < 0);
+			else
+				err = 0;
+		}
+
+		wake_up_all(&req->private.wait_queue);
+		ssdfs_request_free(req);
+		break;
+
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		ssdfs_put_request(req);
+
+		if (err) {
+			SSDFS_DBG("failure: req %p, err %d\n", req, err);
+			atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+		} else
+			atomic_set(&req->result.state, SSDFS_REQ_FINISHED);
+
+		complete(&req->result.wait);
+
+		if (atomic_read(&req->private.refs_count) != 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("start waiting: refs_count %d\n",
+				   atomic_read(&req->private.refs_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = wait_event_killable_timeout(*wait,
+			    atomic_read(&req->private.refs_count) == 0,
+			    SSDFS_DEFAULT_TIMEOUT);
+			if (err < 0)
+				WARN_ON(err < 0);
+			else
+				err = 0;
+		}
+
+		wake_up_all(&req->private.wait_queue);
+		break;
+
+	default:
+		atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+		BUG();
+	};
+}
+
+/*
+ * ssdfs_finish_pre_allocate_request() - finish pre-allocate request
+ * @pebc: pointer on PEB container
+ * @req: request
+ * @wait: wait queue head
+ * @err: error of processing request
+ *
+ * This function finishes pre-allocate request processing. If attempt of
+ * pre-allocate an extent has been resulted with %-EAGAIN error then
+ * function returns request into create queue for final
+ * processing.
+ */
+static
+void ssdfs_finish_pre_allocate_request(struct ssdfs_peb_container *pebc,
+					struct ssdfs_segment_request *req,
+					wait_queue_head_t *wait,
+					int err)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req);
+
+	SSDFS_DBG("req %p, cmd %#x, type %#x, err %d\n",
+		  req, req->private.cmd, req->private.type, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!err) {
+		WARN_ON(pagevec_count(&req->result.pvec) != 0);
+		ssdfs_flush_pagevec_release(&req->result.pvec);
+	}
+
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("return request into queue: "
+			  "seg %llu, peb_index %u, "
+			  "ino %llu, logical_offset %llu, "
+			  "data_bytes %u, cno %llu, parent_snapshot %llu"
+			  "seg %llu, logical_block %u, cmd %#x, type %#x, "
+			  "processed_blks %d\n",
+			  pebc->parent_si->seg_id, pebc->peb_index,
+			  req->extent.ino, req->extent.logical_offset,
+			  req->extent.data_bytes, req->extent.cno,
+			  req->extent.parent_snapshot,
+			  req->place.start.seg_id, req->place.start.blk_index,
+			  req->private.cmd, req->private.type,
+			  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		atomic_set(&req->result.state, SSDFS_REQ_CREATED);
+
+		spin_lock(&pebc->crq_ptr_lock);
+		ssdfs_requests_queue_add_head(pebc->create_rq, req);
+		spin_unlock(&pebc->crq_ptr_lock);
+	} else
+		__ssdfs_finish_request(pebc, req, wait, err);
+}
+
+/*
+ * ssdfs_finish_create_request() - finish create request
+ * @pebc: pointer on PEB container
+ * @req: request
+ * @wait: wait queue head
+ * @err: error of processing request
+ *
+ * This function finishes create request processing. If attempt of
+ * adding data block has been resulted with %-EAGAIN error then
+ * function returns request into create queue for final
+ * processing.
+ */
+static
+void ssdfs_finish_create_request(struct ssdfs_peb_container *pebc,
+				 struct ssdfs_segment_request *req,
+				 wait_queue_head_t *wait,
+				 int err)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req);
+
+	SSDFS_DBG("req %p, cmd %#x, type %#x, err %d\n",
+		  req, req->private.cmd, req->private.type, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!err) {
+		for (i = 0; i < req->result.processed_blks; i++)
+			ssdfs_peb_mark_request_block_uptodate(pebc, req, i);
+	}
+
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("return request into queue: "
+			  "seg %llu, peb_index %u, "
+			  "ino %llu, logical_offset %llu, "
+			  "data_bytes %u, cno %llu, parent_snapshot %llu"
+			  "seg %llu, logical_block %u, cmd %#x, type %#x, "
+			  "processed_blks %d\n",
+			  pebc->parent_si->seg_id, pebc->peb_index,
+			  req->extent.ino, req->extent.logical_offset,
+			  req->extent.data_bytes, req->extent.cno,
+			  req->extent.parent_snapshot,
+			  req->place.start.seg_id, req->place.start.blk_index,
+			  req->private.cmd, req->private.type,
+			  req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		atomic_set(&req->result.state, SSDFS_REQ_CREATED);
+
+		spin_lock(&pebc->crq_ptr_lock);
+		ssdfs_requests_queue_add_head(pebc->create_rq, req);
+		spin_unlock(&pebc->crq_ptr_lock);
+	} else
+		__ssdfs_finish_request(pebc, req, wait, err);
+}
+
+/*
+ * ssdfs_finish_update_request() - finish update request
+ * @pebc: pointer on PEB container
+ * @req: request
+ * @wait: wait queue head
+ * @err: error of processing request
+ *
+ * This function finishes update request processing.
+ */
+static
+void ssdfs_finish_update_request(struct ssdfs_peb_container *pebc,
+				 struct ssdfs_segment_request *req,
+				 wait_queue_head_t *wait,
+				 int err)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req);
+
+	SSDFS_DBG("req %p, cmd %#x, type %#x, err %d\n",
+		  req, req->private.cmd, req->private.type, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!err) {
+		for (i = 0; i < req->result.processed_blks; i++)
+			ssdfs_peb_mark_request_block_uptodate(pebc, req, i);
+	}
+
+	__ssdfs_finish_request(pebc, req, wait, err);
+}
+
+/*
+ * ssdfs_finish_flush_request() - finish flush request
+ * @pebc: pointer on PEB container
+ * @req: request
+ * @wait: wait queue head
+ * @err: error of processing request
+ */
+static inline
+void ssdfs_finish_flush_request(struct ssdfs_peb_container *pebc,
+				struct ssdfs_segment_request *req,
+				wait_queue_head_t *wait,
+				int err)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req);
+
+	SSDFS_DBG("req %p, cmd %#x, type %#x, err %d\n",
+		  req, req->private.cmd, req->private.type, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req->private.class) {
+	case SSDFS_PEB_PRE_ALLOCATE_DATA_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ:
+		ssdfs_finish_pre_allocate_request(pebc, req, wait, err);
+		break;
+
+	case SSDFS_PEB_CREATE_DATA_REQ:
+	case SSDFS_PEB_CREATE_LNODE_REQ:
+	case SSDFS_PEB_CREATE_HNODE_REQ:
+	case SSDFS_PEB_CREATE_IDXNODE_REQ:
+		ssdfs_finish_create_request(pebc, req, wait, err);
+		break;
+
+	case SSDFS_PEB_UPDATE_REQ:
+	case SSDFS_PEB_PRE_ALLOC_UPDATE_REQ:
+	case SSDFS_PEB_DIFF_ON_WRITE_REQ:
+	case SSDFS_PEB_COLLECT_GARBAGE_REQ:
+	case SSDFS_ZONE_USER_DATA_MIGRATE_REQ:
+		ssdfs_finish_update_request(pebc, req, wait, err);
+		break;
+
+	default:
+		BUG();
+	};
+
+	ssdfs_forget_user_data_flush_request(pebc->parent_si);
+	ssdfs_segment_finish_request_cno(pebc->parent_si);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("flush_reqs %lld\n",
+		  atomic64_read(&pebc->parent_si->fsi->flush_reqs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	WARN_ON(atomic64_dec_return(&pebc->parent_si->fsi->flush_reqs) < 0);
+}
+
+/*
+ * ssdfs_peb_clear_current_log_pages() - clear dirty pages of current log
+ * @pebi: pointer on PEB object
+ */
+static inline
+void ssdfs_peb_clear_current_log_pages(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_page_array *area_pages;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_LOG_AREA_MAX; i++) {
+		area_pages = &pebi->current_log.area[i].array;
+		err = ssdfs_page_array_clear_all_dirty_pages(area_pages);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to clear dirty pages: "
+				  "area_type %#x, err %d\n",
+				  i, err);
+		}
+	}
+}
+
+/*
+ * ssdfs_peb_clear_current_log_pages() - clear dirty pages of PEB's cache
+ * @pebi: pointer on PEB object
+ */
+static inline
+void ssdfs_peb_clear_cache_dirty_pages(struct ssdfs_peb_info *pebi)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb %llu\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_page_array_clear_all_dirty_pages(&pebi->cache);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to clear dirty pages: "
+			  "err %d\n",
+			  err);
+	}
+}
+
+/*
+ * ssdfs_peb_commit_log_on_thread_stop() - commit log on thread stopping
+ * @pebi: pointer on PEB object
+ * @cur_segs: current segment IDs array
+ * @size: size of segment IDs array size in bytes
+ */
+static
+int ssdfs_peb_commit_log_on_thread_stop(struct ssdfs_peb_info *pebi,
+					__le64 *cur_segs, size_t size)
+{
+	struct ssdfs_fs_info *fsi;
+	u64 reserved_new_user_data_pages;
+	u64 updated_user_data_pages;
+	u64 flushing_user_data_requests;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!is_ssdfs_peb_current_log_locked(pebi));
+
+	SSDFS_DBG("seg %llu, peb_index %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	if (ssdfs_peb_has_dirty_pages(pebi)) {
+		/*
+		 * Unexpected situation.
+		 * Try to commit anyway.
+		 */
+
+		spin_lock(&fsi->volume_state_lock);
+		reserved_new_user_data_pages =
+			fsi->reserved_new_user_data_pages;
+		updated_user_data_pages =
+			fsi->updated_user_data_pages;
+		flushing_user_data_requests =
+			fsi->flushing_user_data_requests;
+		spin_unlock(&fsi->volume_state_lock);
+
+		SSDFS_WARN("PEB has dirty pages: "
+			   "seg %llu, peb %llu, peb_type %#x, "
+			   "global_fs_state %#x, "
+			   "reserved_new_user_data_pages %llu, "
+			   "updated_user_data_pages %llu, "
+			   "flushing_user_data_requests %llu\n",
+			   pebi->pebc->parent_si->seg_id,
+			   pebi->peb_id, pebi->pebc->peb_type,
+			   atomic_read(&fsi->global_fs_state),
+			   reserved_new_user_data_pages,
+			   updated_user_data_pages,
+			   flushing_user_data_requests);
+
+		err = ssdfs_peb_commit_log(pebi, cur_segs, size);
+		if (unlikely(err)) {
+			SSDFS_CRIT("fail to commit log: "
+				   "seg %llu, peb_index %u, err %d\n",
+				   pebi->pebc->parent_si->seg_id,
+				   pebi->peb_index, err);
+
+			ssdfs_peb_clear_current_log_pages(pebi);
+			ssdfs_peb_clear_cache_dirty_pages(pebi);
+		}
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_get_current_log_state() - get state of PEB's current log
+ * @pebc: pointer on PEB container
+ */
+static
+int ssdfs_peb_get_current_log_state(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_info *pebi = NULL;
+	bool is_peb_exhausted;
+	int state;
+	int err = 0;
+
+	fsi = pebc->parent_si->fsi;
+
+try_get_current_state:
+	down_read(&pebc->lock);
+
+	switch (atomic_read(&pebc->migration_state)) {
+	case SSDFS_PEB_NOT_MIGRATING:
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			err = -ERANGE;
+			SSDFS_WARN("source PEB is NULL\n");
+			goto finish_get_current_log_state;
+		}
+		state = atomic_read(&pebi->current_log.state);
+		break;
+
+	case SSDFS_PEB_UNDER_MIGRATION:
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			err = -ERANGE;
+			SSDFS_WARN("source PEB is NULL\n");
+			goto finish_get_current_log_state;
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		is_peb_exhausted = is_ssdfs_peb_exhausted(fsi, pebi);
+		ssdfs_peb_current_log_unlock(pebi);
+
+		if (is_peb_exhausted) {
+			pebi = pebc->dst_peb;
+			if (!pebi) {
+				err = -ERANGE;
+				SSDFS_WARN("destination PEB is NULL\n");
+				goto finish_get_current_log_state;
+			}
+		}
+
+		state = atomic_read(&pebi->current_log.state);
+		break;
+
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_FINISHING_MIGRATION:
+		err = -EAGAIN;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid state: %#x\n",
+			   atomic_read(&pebc->migration_state));
+		goto finish_get_current_log_state;
+		break;
+	}
+
+finish_get_current_log_state:
+	up_read(&pebc->lock);
+
+	if (err == -EAGAIN) {
+		DEFINE_WAIT(wait);
+
+		err = 0;
+		prepare_to_wait(&pebc->migration_wq, &wait,
+				TASK_UNINTERRUPTIBLE);
+		schedule();
+		finish_wait(&pebc->migration_wq, &wait);
+		goto try_get_current_state;
+	} else if (unlikely(err))
+		state = SSDFS_LOG_UNKNOWN;
+
+	return state;
+}
+
+bool is_ssdfs_peb_exhausted(struct ssdfs_fs_info *fsi,
+			    struct ssdfs_peb_info *pebi)
+{
+	bool is_exhausted = false;
+	u16 start_page;
+	u32 pages_per_peb;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pebi);
+	BUG_ON(!mutex_is_locked(&pebi->current_log.lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_page = pebi->current_log.start_page;
+	pages_per_peb = min_t(u32, fsi->leb_pages_capacity,
+				   fsi->peb_pages_capacity);
+
+	switch (atomic_read(&pebi->current_log.state)) {
+	case SSDFS_LOG_INITIALIZED:
+	case SSDFS_LOG_COMMITTED:
+	case SSDFS_LOG_CREATED:
+		is_exhausted = start_page >= pages_per_peb;
+		break;
+
+	default:
+		is_exhausted = false;
+		break;
+	};
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_id %llu, start_page %u, "
+		  "pages_per_peb %u, is_exhausted %#x\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, start_page,
+		  pages_per_peb, is_exhausted);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return is_exhausted;
+}
+
+bool is_ssdfs_peb_ready_to_exhaust(struct ssdfs_fs_info *fsi,
+				   struct ssdfs_peb_info *pebi)
+{
+	bool is_ready_to_exhaust = false;
+	u16 start_page;
+	u32 pages_per_peb;
+	u16 free_data_pages;
+	u16 reserved_pages;
+	u16 min_partial_log_pages;
+	int empty_pages;
+	int migration_state;
+	int migration_phase;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!mutex_is_locked(&pebi->current_log.lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	migration_state = atomic_read(&pebi->pebc->migration_state);
+	migration_phase = atomic_read(&pebi->pebc->migration_phase);
+
+	switch (migration_state) {
+	case SSDFS_PEB_NOT_MIGRATING:
+		/* continue logic */
+		break;
+
+	case SSDFS_PEB_UNDER_MIGRATION:
+		switch (migration_phase) {
+		case SSDFS_SRC_PEB_NOT_EXHAUSTED:
+			is_ready_to_exhaust = false;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("peb under migration: "
+				  "src_peb %llu is not exhausted\n",
+				  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return is_ready_to_exhaust;
+
+		default:
+			/* continue logic */
+			break;
+		}
+		break;
+
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_FINISHING_MIGRATION:
+		is_ready_to_exhaust = true;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb is going to migrate: "
+			  "src_peb %llu is exhausted\n",
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return is_ready_to_exhaust;
+
+	default:
+		SSDFS_WARN("migration_state %#x, migration_phase %#x\n",
+			   migration_state, migration_phase);
+		BUG();
+		break;
+	}
+
+	start_page = pebi->current_log.start_page;
+	pages_per_peb = min_t(u32, fsi->leb_pages_capacity,
+				   fsi->peb_pages_capacity);
+	empty_pages = pages_per_peb - start_page;
+	free_data_pages = pebi->current_log.free_data_pages;
+	reserved_pages = pebi->current_log.reserved_pages;
+	min_partial_log_pages = ssdfs_peb_estimate_min_partial_log_pages(pebi);
+
+	switch (atomic_read(&pebi->current_log.state)) {
+	case SSDFS_LOG_INITIALIZED:
+	case SSDFS_LOG_COMMITTED:
+	case SSDFS_LOG_CREATED:
+		if (empty_pages > min_partial_log_pages)
+			is_ready_to_exhaust = false;
+		else if (reserved_pages == 0) {
+			if (free_data_pages <= min_partial_log_pages)
+				is_ready_to_exhaust = true;
+			else
+				is_ready_to_exhaust = false;
+		} else {
+			if (free_data_pages < min_partial_log_pages)
+				is_ready_to_exhaust = true;
+			else
+				is_ready_to_exhaust = false;
+		}
+		break;
+
+	default:
+		is_ready_to_exhaust = false;
+		break;
+	};
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_id %llu, free_data_pages %u, "
+		  "reserved_pages %u, min_partial_log_pages %u, "
+		  "is_ready_to_exhaust %#x\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, free_data_pages,
+		  reserved_pages, min_partial_log_pages,
+		  is_ready_to_exhaust);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return is_ready_to_exhaust;
+}
+
+static inline
+bool ssdfs_peb_has_partial_empty_log(struct ssdfs_fs_info *fsi,
+				     struct ssdfs_peb_info *pebi)
+{
+	bool has_partial_empty_log = false;
+	u16 start_page;
+	u32 pages_per_peb;
+	u16 log_pages;
+	int empty_pages;
+	u16 min_partial_log_pages;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pebi);
+	BUG_ON(!mutex_is_locked(&pebi->current_log.lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_page = pebi->current_log.start_page;
+	pages_per_peb = min_t(u32, fsi->leb_pages_capacity,
+				   fsi->peb_pages_capacity);
+	log_pages = pebi->log_pages;
+	min_partial_log_pages = ssdfs_peb_estimate_min_partial_log_pages(pebi);
+
+	switch (atomic_read(&pebi->current_log.state)) {
+	case SSDFS_LOG_INITIALIZED:
+	case SSDFS_LOG_COMMITTED:
+	case SSDFS_LOG_CREATED:
+		empty_pages = pages_per_peb - start_page;
+		if (empty_pages < 0)
+			has_partial_empty_log = false;
+		else if (empty_pages < min_partial_log_pages)
+			has_partial_empty_log = true;
+		else
+			has_partial_empty_log = false;
+		break;
+
+	default:
+		has_partial_empty_log = false;
+		break;
+	};
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_id %llu, start_page %u, "
+		  "pages_per_peb %u, log_pages %u, "
+		  "min_partial_log_pages %u, "
+		  "has_partial_empty_log %#x\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, start_page,
+		  pages_per_peb, log_pages,
+		  min_partial_log_pages,
+		  has_partial_empty_log);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return has_partial_empty_log;
+}
+
+static inline
+bool has_commit_log_now_requested(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_request *req = NULL;
+	bool commit_log_now = false;
+	int err;
+
+	if (is_ssdfs_requests_queue_empty(&pebc->update_rq))
+		return false;
+
+	err = ssdfs_requests_queue_remove_first(&pebc->update_rq, &req);
+	if (err || !req)
+		return false;
+
+	commit_log_now = req->private.cmd == SSDFS_COMMIT_LOG_NOW;
+	ssdfs_requests_queue_add_head(&pebc->update_rq, req);
+	return commit_log_now;
+}
+
+static inline
+bool has_start_migration_now_requested(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_request *req = NULL;
+	bool start_migration_now = false;
+	int err;
+
+	if (is_ssdfs_requests_queue_empty(&pebc->update_rq))
+		return false;
+
+	err = ssdfs_requests_queue_remove_first(&pebc->update_rq, &req);
+	if (err || !req)
+		return false;
+
+	start_migration_now = req->private.cmd == SSDFS_START_MIGRATION_NOW;
+	ssdfs_requests_queue_add_head(&pebc->update_rq, req);
+	return start_migration_now;
+}
+
+static inline
+void ssdfs_peb_check_update_queue(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_request *req = NULL;
+	int err;
+
+	if (is_ssdfs_requests_queue_empty(&pebc->update_rq)) {
+		SSDFS_DBG("update request queue is empty\n");
+		return;
+	}
+
+	err = ssdfs_requests_queue_remove_first(&pebc->update_rq, &req);
+	if (err || !req)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index);
+	SSDFS_DBG("req->private.class %#x, req->private.cmd %#x\n",
+		  req->private.class, req->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_requests_queue_add_head(&pebc->update_rq, req);
+	return;
+}
+
+static inline
+int __ssdfs_peb_finish_migration(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_segment_request *req;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_peb_finish_migration(pebc);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to finish migration: "
+			  "seg %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+		return err;
+	}
+
+	/*
+	 * The responsibility of finish migration code
+	 * is to copy the state of valid blocks of
+	 * source erase block into the buffers.
+	 * So, this buffered state of valid blocks
+	 * should be commited ASAP. It needs to send
+	 * the COMMIT_LOG_NOW command to guarantee
+	 * that valid blocks will be flushed on the volume.
+	 */
+
+	req = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req)) {
+		err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+		SSDFS_ERR("fail to allocate request: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	ssdfs_request_init(req);
+	ssdfs_get_request(req);
+
+	err = ssdfs_segment_commit_log_async2(si, SSDFS_REQ_ASYNC,
+						pebc->peb_index, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("commit log request failed: "
+			  "err %d\n", err);
+		ssdfs_put_request(req);
+		ssdfs_request_free(req);
+		return err;
+	}
+
+	return 0;
+}
+
+static inline
+bool need_wait_next_create_data_request(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_segment_info *si = pebi->pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	bool has_pending_pages = false;
+	bool has_reserved_pages = false;
+	int state;
+	bool is_current_seg = false;
+	u64 reserved_pages = 0;
+	u64 pending_pages = 0;
+	bool need_wait = false;
+
+	if (!is_ssdfs_peb_containing_user_data(pebi->pebc))
+		goto finish_check;
+
+	spin_lock(&si->pending_lock);
+	pending_pages = si->pending_new_user_data_pages;
+	has_pending_pages = si->pending_new_user_data_pages > 0;
+	spin_unlock(&si->pending_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pending_pages %llu\n", pending_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (has_pending_pages) {
+		need_wait = true;
+		goto finish_check;
+	}
+
+	spin_lock(&fsi->volume_state_lock);
+	reserved_pages = fsi->reserved_new_user_data_pages;
+	has_reserved_pages = fsi->reserved_new_user_data_pages > 0;
+	spin_unlock(&fsi->volume_state_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("reserved_pages %llu\n", reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&si->obj_state);
+	is_current_seg = (state == SSDFS_CURRENT_SEG_OBJECT);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("is_current_seg %#x, has_reserved_pages %#x\n",
+		  is_current_seg, has_reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	need_wait = is_current_seg && has_reserved_pages;
+
+finish_check:
+	return need_wait;
+}
+
+static inline
+bool need_wait_next_update_request(struct ssdfs_peb_info *pebi)
+{
+	struct ssdfs_segment_info *si = pebi->pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	bool has_pending_pages = false;
+	bool has_updated_pages = false;
+	u64 updated_pages = 0;
+	u64 pending_pages = 0;
+	bool need_wait = false;
+
+	if (!is_ssdfs_peb_containing_user_data(pebi->pebc))
+		goto finish_check;
+
+	spin_lock(&pebi->pebc->pending_lock);
+	pending_pages = pebi->pebc->pending_updated_user_data_pages;
+	has_pending_pages = pending_pages > 0;
+	spin_unlock(&pebi->pebc->pending_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pending_pages %llu\n", pending_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (has_pending_pages) {
+		need_wait = true;
+		goto finish_check;
+	}
+
+	spin_lock(&fsi->volume_state_lock);
+	updated_pages = fsi->updated_user_data_pages;
+	has_updated_pages = fsi->updated_user_data_pages > 0;
+	spin_unlock(&fsi->volume_state_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("updated_pages %llu\n", updated_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	need_wait = has_updated_pages;
+
+finish_check:
+	return need_wait;
+}
+
+static inline
+bool no_more_updated_pages(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	bool has_updated_pages = false;
+
+	if (!is_ssdfs_peb_containing_user_data(pebc))
+		return true;
+
+	spin_lock(&fsi->volume_state_lock);
+	has_updated_pages = fsi->updated_user_data_pages > 0;
+	spin_unlock(&fsi->volume_state_lock);
+
+	return !has_updated_pages;
+}
+
+static inline
+bool is_regular_fs_operations(struct ssdfs_peb_container *pebc)
+{
+	int state;
+
+	state = atomic_read(&pebc->parent_si->fsi->global_fs_state);
+	return state == SSDFS_REGULAR_FS_OPERATIONS;
+}
+
+/* Flush thread possible states */
+enum {
+	SSDFS_FLUSH_THREAD_ERROR,
+	SSDFS_FLUSH_THREAD_FREE_SPACE_ABSENT,
+	SSDFS_FLUSH_THREAD_RO_STATE,
+	SSDFS_FLUSH_THREAD_NEED_CREATE_LOG,
+	SSDFS_FLUSH_THREAD_CHECK_STOP_CONDITION,
+	SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST,
+	SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST,
+	SSDFS_FLUSH_THREAD_PROCESS_CREATE_REQUEST,
+	SSDFS_FLUSH_THREAD_PROCESS_UPDATE_REQUEST,
+	SSDFS_FLUSH_THREAD_PROCESS_INVALIDATED_EXTENT,
+	SSDFS_FLUSH_THREAD_CHECK_MIGRATION_NEED,
+	SSDFS_FLUSH_THREAD_START_MIGRATION_NOW,
+	SSDFS_FLUSH_THREAD_COMMIT_LOG,
+	SSDFS_FLUSH_THREAD_DELEGATE_CREATE_ROLE,
+};
+
+#define FLUSH_THREAD_WAKE_CONDITION(pebc) \
+	(kthread_should_stop() || have_flush_requests(pebc))
+#define FLUSH_FAILED_THREAD_WAKE_CONDITION() \
+	(kthread_should_stop())
+#define FLUSH_THREAD_CUR_SEG_WAKE_CONDITION(pebc) \
+	(kthread_should_stop() || have_flush_requests(pebc) || \
+	 !is_regular_fs_operations(pebc) || \
+	 atomic_read(&pebc->parent_si->obj_state) != SSDFS_CURRENT_SEG_OBJECT)
+#define FLUSH_THREAD_UPDATE_WAKE_CONDITION(pebc) \
+	(kthread_should_stop() || have_flush_requests(pebc) || \
+	 no_more_updated_pages(pebc) || !is_regular_fs_operations(pebc))
+#define FLUSH_THREAD_INVALIDATE_WAKE_CONDITION(pebc) \
+	(kthread_should_stop() || have_flush_requests(pebc) || \
+	 !is_regular_fs_operations(pebc))
+
+static
+int wait_next_create_request(struct ssdfs_peb_container *pebc,
+			     int *thread_state)
+{
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	struct ssdfs_peb_info *pebi;
+	u64 reserved_pages = 0;
+	bool has_reserved_pages = false;
+	int state;
+	bool is_current_seg = false;
+	bool has_dirty_pages = false;
+	bool need_commit_log = false;
+	wait_queue_head_t *wq = NULL;
+	struct ssdfs_segment_request *req;
+	int err;
+
+	if (!is_ssdfs_peb_containing_user_data(pebc)) {
+		*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+		return -ERANGE;
+	}
+
+	spin_lock(&fsi->volume_state_lock);
+	reserved_pages = fsi->reserved_new_user_data_pages;
+	has_reserved_pages = reserved_pages > 0;
+	spin_unlock(&fsi->volume_state_lock);
+
+	state = atomic_read(&si->obj_state);
+	is_current_seg = (state == SSDFS_CURRENT_SEG_OBJECT);
+
+	if (is_current_seg && has_reserved_pages) {
+		wq = &fsi->pending_wq;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("wait next data request: reserved_pages %llu\n",
+			  reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = wait_event_killable_timeout(*wq,
+				FLUSH_THREAD_CUR_SEG_WAKE_CONDITION(pebc),
+				SSDFS_DEFAULT_TIMEOUT);
+		if (err < 0)
+			WARN_ON(err < 0);
+		else
+			err = 0;
+	}
+
+	state = atomic_read(&si->obj_state);
+	is_current_seg = (state == SSDFS_CURRENT_SEG_OBJECT);
+
+	pebi = ssdfs_get_current_peb_locked(pebc);
+	if (!IS_ERR_OR_NULL(pebi)) {
+		ssdfs_peb_current_log_lock(pebi);
+		has_dirty_pages = ssdfs_peb_has_dirty_pages(pebi);
+		ssdfs_peb_current_log_unlock(pebi);
+		ssdfs_unlock_current_peb(pebc);
+	}
+
+	if (!is_regular_fs_operations(pebc))
+		need_commit_log = true;
+	else if (!is_current_seg)
+		need_commit_log = true;
+	else if (!have_flush_requests(pebc) && has_dirty_pages)
+		need_commit_log = true;
+
+	if (need_commit_log) {
+		req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req)) {
+			err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+			SSDFS_ERR("fail to allocate request: "
+				  "err %d\n", err);
+			*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			return err;
+		}
+
+		ssdfs_request_init(req);
+		ssdfs_get_request(req);
+
+		err = ssdfs_segment_commit_log_async2(si, SSDFS_REQ_ASYNC,
+							pebc->peb_index, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("commit log request failed: "
+				  "err %d\n", err);
+			ssdfs_put_request(req);
+			ssdfs_request_free(req);
+			*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("request commit log now: reserved_pages %llu\n",
+			  reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("get next create request: reserved_pages %llu\n",
+			  reserved_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	*thread_state = SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST;
+	return 0;
+}
+
+static
+int wait_next_update_request(struct ssdfs_peb_container *pebc,
+			     int *thread_state)
+{
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_peb_info *pebi;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	u64 updated_pages = 0;
+	bool has_updated_pages = false;
+	bool has_dirty_pages = false;
+	bool need_commit_log = false;
+	wait_queue_head_t *wq = NULL;
+	struct ssdfs_segment_request *req;
+	int err;
+
+	if (!is_ssdfs_peb_containing_user_data(pebc)) {
+		*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+		return -ERANGE;
+	}
+
+	spin_lock(&fsi->volume_state_lock);
+	updated_pages = fsi->updated_user_data_pages;
+	has_updated_pages = updated_pages > 0;
+	spin_unlock(&fsi->volume_state_lock);
+
+	if (has_updated_pages) {
+		wq = &fsi->pending_wq;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("wait next update request: updated_pages %llu\n",
+			  updated_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = wait_event_killable_timeout(*wq,
+				FLUSH_THREAD_UPDATE_WAKE_CONDITION(pebc),
+				SSDFS_DEFAULT_TIMEOUT);
+		if (err < 0)
+			WARN_ON(err < 0);
+		else
+			err = 0;
+	}
+
+	pebi = ssdfs_get_current_peb_locked(pebc);
+	if (!IS_ERR_OR_NULL(pebi)) {
+		ssdfs_peb_current_log_lock(pebi);
+		has_dirty_pages = ssdfs_peb_has_dirty_pages(pebi);
+		ssdfs_peb_current_log_unlock(pebi);
+		ssdfs_unlock_current_peb(pebc);
+	}
+
+	if (!is_regular_fs_operations(pebc))
+		need_commit_log = true;
+	else if (no_more_updated_pages(pebc))
+		need_commit_log = true;
+	else if (!have_flush_requests(pebc) && has_dirty_pages)
+		need_commit_log = true;
+
+	if (need_commit_log) {
+		req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req)) {
+			err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+			SSDFS_ERR("fail to allocate request: "
+				  "err %d\n", err);
+			*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			return err;
+		}
+
+		ssdfs_request_init(req);
+		ssdfs_get_request(req);
+
+		err = ssdfs_segment_commit_log_async2(si, SSDFS_REQ_ASYNC,
+							pebc->peb_index, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("commit log request failed: "
+				  "err %d\n", err);
+			ssdfs_put_request(req);
+			ssdfs_request_free(req);
+			*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("request commit log now: updated_pages %llu\n",
+			  updated_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("get next create request: updated_pages %llu\n",
+			  updated_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	*thread_state = SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST;
+	return 0;
+}
+
+static
+int wait_next_invalidate_request(struct ssdfs_peb_container *pebc,
+				 int *thread_state)
+{
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	int state;
+	wait_queue_head_t *wq = NULL;
+	struct ssdfs_segment_request *req;
+	int err;
+
+	if (!is_ssdfs_peb_containing_user_data(pebc)) {
+		*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+		return -ERANGE;
+	}
+
+	if (!is_user_data_pages_invalidated(si)) {
+		*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+		return -ERANGE;
+	}
+
+	state = atomic_read(&fsi->global_fs_state);
+	switch(state) {
+	case SSDFS_REGULAR_FS_OPERATIONS:
+		wq = &fsi->pending_wq;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("wait next invalidate request\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = wait_event_killable_timeout(*wq,
+				FLUSH_THREAD_INVALIDATE_WAKE_CONDITION(pebc),
+				SSDFS_DEFAULT_TIMEOUT);
+		if (err < 0)
+			WARN_ON(err < 0);
+		else
+			err = 0;
+
+		if (have_flush_requests(pebc))
+			SSDFS_DBG("get next create request\n");
+		else
+			goto request_commit_log_now;
+		break;
+
+	case SSDFS_METADATA_GOING_FLUSHING:
+request_commit_log_now:
+		req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req)) {
+			err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+			SSDFS_ERR("fail to allocate request: "
+				  "err %d\n", err);
+			*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			return err;
+		}
+
+		ssdfs_request_init(req);
+		ssdfs_get_request(req);
+
+		err = ssdfs_segment_commit_log_async2(si, SSDFS_REQ_ASYNC,
+							pebc->peb_index, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("commit log request failed: "
+				  "err %d\n", err);
+			ssdfs_put_request(req);
+			ssdfs_request_free(req);
+			*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("request commit log now\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected global FS state %#x\n",
+			  state);
+		*thread_state = SSDFS_FLUSH_THREAD_ERROR;
+		return -ERANGE;
+	}
+
+	*thread_state = SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST;
+	return 0;
+}
+
+static inline
+int ssdfs_check_peb_init_state(u64 seg_id, u64 peb_id, int state,
+				struct completion *init_end)
+{
+	int res;
+
+	if (peb_id >= U64_MAX ||
+	    state == SSDFS_PEB_OBJECT_INITIALIZED ||
+	    !init_end) {
+		/* do nothing */
+		return 0;
+	}
+
+	res = wait_for_completion_timeout(init_end, SSDFS_DEFAULT_TIMEOUT);
+	if (res == 0) {
+		SSDFS_ERR("PEB init failed: "
+			  "seg %llu, peb %llu\n",
+			  seg_id, peb_id);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+static inline
+int ssdfs_check_src_peb_init_state(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_peb_info *pebi = NULL;
+	struct completion *init_end = NULL;
+	u64 peb_id = U64_MAX;
+	int state = SSDFS_PEB_OBJECT_UNKNOWN_STATE;
+
+	down_read(&pebc->lock);
+	pebi = pebc->src_peb;
+	if (pebi) {
+		init_end = &pebi->init_end;
+		peb_id = pebi->peb_id;
+		state = atomic_read(&pebi->state);
+	}
+	up_read(&pebc->lock);
+
+	return ssdfs_check_peb_init_state(pebc->parent_si->seg_id,
+					  peb_id, state, init_end);
+}
+
+static inline
+int ssdfs_check_dst_peb_init_state(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_peb_info *pebi = NULL;
+	struct completion *init_end = NULL;
+	u64 peb_id = U64_MAX;
+	int state = SSDFS_PEB_OBJECT_UNKNOWN_STATE;
+
+	down_read(&pebc->lock);
+	pebi = pebc->dst_peb;
+	if (pebi) {
+		init_end = &pebi->init_end;
+		peb_id = pebi->peb_id;
+		state = atomic_read(&pebi->state);
+	}
+	up_read(&pebc->lock);
+
+	return ssdfs_check_peb_init_state(pebc->parent_si->seg_id,
+					  peb_id, state, init_end);
+}
+
+static inline
+int ssdfs_check_peb_container_init_state(struct ssdfs_peb_container *pebc)
+{
+	int err;
+
+	err = ssdfs_check_src_peb_init_state(pebc);
+	if (!err)
+		err = ssdfs_check_dst_peb_init_state(pebc);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_flush_thread_func() - main fuction of flush thread
+ * @data: pointer on data object
+ *
+ * This function is main fuction of flush thread.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+int ssdfs_peb_flush_thread_func(void *data)
+{
+	struct ssdfs_peb_container *pebc = data;
+	struct ssdfs_segment_info *si = pebc->parent_si;
+	struct ssdfs_fs_info *fsi = si->fsi;
+	struct ssdfs_peb_mapping_table *maptbl = fsi->maptbl;
+	wait_queue_head_t *wait_queue;
+	struct ssdfs_segment_request *req;
+	struct ssdfs_segment_request *postponed_req = NULL;
+	struct ssdfs_peb_info *pebi = NULL;
+	u64 peb_id = U64_MAX;
+	int state;
+	int thread_state = SSDFS_FLUSH_THREAD_NEED_CREATE_LOG;
+	__le64 cur_segs[SSDFS_CUR_SEGS_COUNT];
+	size_t size = sizeof(__le64) * SSDFS_CUR_SEGS_COUNT;
+	bool is_peb_exhausted = false;
+	bool is_peb_ready_to_exhaust = false;
+	bool peb_has_dirty_pages = false;
+	bool has_partial_empty_log = false;
+	bool skip_finish_flush_request = false;
+	bool need_create_log = true;
+	bool has_migration_check_requested = false;
+	bool has_extent_been_invalidated = false;
+	bool is_user_data = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (!pebc) {
+		SSDFS_ERR("pointer on PEB container is NULL\n");
+		BUG();
+	}
+
+	SSDFS_DBG("flush thread: seg %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	wait_queue = &pebc->parent_si->wait_queue[SSDFS_PEB_FLUSH_THREAD];
+
+repeat:
+	if (err)
+		thread_state = SSDFS_FLUSH_THREAD_ERROR;
+
+	if (thread_state != SSDFS_FLUSH_THREAD_ERROR &&
+	    thread_state != SSDFS_FLUSH_THREAD_FREE_SPACE_ABSENT) {
+		if (fsi->sb->s_flags & SB_RDONLY)
+			thread_state = SSDFS_FLUSH_THREAD_RO_STATE;
+	}
+
+next_partial_step:
+	switch (thread_state) {
+	case SSDFS_FLUSH_THREAD_ERROR:
+		BUG_ON(err == 0);
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("[FLUSH THREAD STATE] ERROR\n");
+		SSDFS_DBG("thread after-error state: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  pebc->parent_si->seg_id, pebc->peb_index, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (have_flush_requests(pebc)) {
+			ssdfs_requests_queue_remove_all(&pebc->update_rq,
+							-EROFS);
+		}
+
+		if (is_peb_joined_into_create_requests_queue(pebc))
+			ssdfs_peb_find_next_log_creation_thread(pebc);
+
+		/*
+		 * Check that we've delegated log creation role.
+		 * Otherwise, simply forget about creation queue.
+		 */
+		if (is_peb_joined_into_create_requests_queue(pebc)) {
+			spin_lock(&pebc->crq_ptr_lock);
+			ssdfs_requests_queue_remove_all(pebc->create_rq,
+							-EROFS);
+			spin_unlock(&pebc->crq_ptr_lock);
+
+			ssdfs_peb_forget_create_requests_queue(pebc);
+		}
+
+check_necessity_to_stop_thread:
+		if (kthread_should_stop()) {
+			struct completion *ptr;
+
+stop_flush_thread:
+			ptr = &pebc->thread[SSDFS_PEB_FLUSH_THREAD].full_stop;
+			complete_all(ptr);
+			return err;
+		} else
+			goto sleep_failed_flush_thread;
+		break;
+
+	case SSDFS_FLUSH_THREAD_FREE_SPACE_ABSENT:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("[FLUSH THREAD STATE] FREE SPACE ABSENT: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (is_peb_joined_into_create_requests_queue(pebc)) {
+			err = ssdfs_peb_find_next_log_creation_thread(pebc);
+			if (err == -ENOSPC)
+				err = 0;
+			else if (unlikely(err)) {
+				SSDFS_WARN("fail to delegate log creation role:"
+					   " seg %llu, peb_index %u, err %d\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+		}
+
+		/*
+		 * Check that we've delegated log creation role.
+		 * Otherwise, simply forget about creation queue.
+		 */
+		if (is_peb_joined_into_create_requests_queue(pebc)) {
+			spin_lock(&pebc->crq_ptr_lock);
+			ssdfs_requests_queue_remove_all(pebc->create_rq,
+							-EROFS);
+			spin_unlock(&pebc->crq_ptr_lock);
+
+			ssdfs_peb_forget_create_requests_queue(pebc);
+		}
+
+		if (err == -ENOSPC && have_flush_requests(pebc)) {
+			err = 0;
+
+			if (is_peb_under_migration(pebc)) {
+				err = __ssdfs_peb_finish_migration(pebc);
+				if (unlikely(err))
+					goto finish_process_free_space_absence;
+			}
+
+			err = ssdfs_peb_start_migration(pebc);
+			if (unlikely(err))
+				goto finish_process_free_space_absence;
+
+			pebi = ssdfs_get_current_peb_locked(pebc);
+			if (IS_ERR_OR_NULL(pebi)) {
+				err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+				SSDFS_ERR("fail to get PEB object: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto finish_process_free_space_absence;
+			}
+
+			if (is_ssdfs_maptbl_going_to_be_destroyed(maptbl)) {
+				SSDFS_WARN("seg %llu, peb_index %u\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index);
+			}
+
+			err = ssdfs_peb_container_change_state(pebc);
+			ssdfs_unlock_current_peb(pebc);
+
+finish_process_free_space_absence:
+			if (unlikely(err)) {
+				SSDFS_WARN("fail to start PEB's migration: "
+					   "seg %llu, peb_index %u, err %d\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index, err);
+			       ssdfs_requests_queue_remove_all(&pebc->update_rq,
+								-ENOSPC);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			thread_state = SSDFS_FLUSH_THREAD_NEED_CREATE_LOG;
+			goto next_partial_step;
+		} else if (have_flush_requests(pebc)) {
+			ssdfs_requests_queue_remove_all(&pebc->update_rq,
+							-ENOSPC);
+		}
+
+		goto check_necessity_to_stop_thread;
+		break;
+
+	case SSDFS_FLUSH_THREAD_RO_STATE:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("[FLUSH THREAD STATE] READ-ONLY STATE: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_prepare_current_segment_ids(fsi, cur_segs, size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare current segments IDs: "
+				  "err %d\n",
+				  err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+		pebi = ssdfs_get_current_peb_locked(pebc);
+		if (IS_ERR_OR_NULL(pebi)) {
+			err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+			SSDFS_ERR("fail to get PEB object: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+		if (!(fsi->sb->s_flags & SB_RDONLY)) {
+			/*
+			 * File system state was changed.
+			 * Now file system has RW state.
+			 */
+			if (fsi->fs_state == SSDFS_ERROR_FS) {
+				ssdfs_peb_current_log_lock(pebi);
+				if (ssdfs_peb_has_dirty_pages(pebi))
+					ssdfs_peb_clear_current_log_pages(pebi);
+				ssdfs_peb_current_log_unlock(pebi);
+				ssdfs_unlock_current_peb(pebc);
+				goto check_necessity_to_stop_thread;
+			} else {
+				state = ssdfs_peb_get_current_log_state(pebc);
+				if (state <= SSDFS_LOG_UNKNOWN ||
+				    state >= SSDFS_LOG_STATE_MAX) {
+					err = -ERANGE;
+					SSDFS_WARN("invalid log state: "
+						   "state %#x\n",
+						   state);
+					ssdfs_unlock_current_peb(pebc);
+					goto repeat;
+				}
+
+				if (state != SSDFS_LOG_CREATED) {
+					thread_state =
+					    SSDFS_FLUSH_THREAD_NEED_CREATE_LOG;
+					ssdfs_unlock_current_peb(pebc);
+					goto next_partial_step;
+				}
+
+				thread_state =
+					SSDFS_FLUSH_THREAD_CHECK_STOP_CONDITION;
+				ssdfs_unlock_current_peb(pebc);
+				goto repeat;
+			}
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		if (ssdfs_peb_has_dirty_pages(pebi)) {
+			if (fsi->fs_state == SSDFS_ERROR_FS)
+				ssdfs_peb_clear_current_log_pages(pebi);
+			else {
+				mutex_lock(&pebc->migration_lock);
+				err = ssdfs_peb_commit_log(pebi,
+							   cur_segs, size);
+				mutex_unlock(&pebc->migration_lock);
+
+				if (unlikely(err)) {
+					SSDFS_CRIT("fail to commit log: "
+						   "seg %llu, peb_index %u, "
+						   "err %d\n",
+						   pebc->parent_si->seg_id,
+						   pebc->peb_index,
+						   err);
+					ssdfs_peb_clear_current_log_pages(pebi);
+					ssdfs_peb_clear_cache_dirty_pages(pebi);
+					thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				}
+			}
+		}
+		ssdfs_peb_current_log_unlock(pebi);
+
+		if (!err) {
+			if (is_ssdfs_maptbl_going_to_be_destroyed(maptbl)) {
+				SSDFS_WARN("seg %llu, peb_index %u\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index);
+			}
+
+			err = ssdfs_peb_container_change_state(pebc);
+			if (unlikely(err)) {
+				SSDFS_CRIT("fail to change peb state: "
+					  "err %d\n", err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			}
+		}
+
+		ssdfs_unlock_current_peb(pebc);
+
+		goto check_necessity_to_stop_thread;
+		break;
+
+	case SSDFS_FLUSH_THREAD_NEED_CREATE_LOG:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("[FLUSH THREAD STATE] NEED CREATE LOG: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#else
+		SSDFS_DBG("[FLUSH THREAD STATE] NEED CREATE LOG: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (fsi->sb->s_flags & SB_RDONLY) {
+			thread_state = SSDFS_FLUSH_THREAD_RO_STATE;
+			goto repeat;
+		}
+
+		if (kthread_should_stop()) {
+			if (have_flush_requests(pebc)) {
+				SSDFS_WARN("discovered unprocessed requests: "
+					   "seg %llu, peb_index %u\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index);
+			} else {
+				thread_state =
+				    SSDFS_FLUSH_THREAD_CHECK_STOP_CONDITION;
+				goto repeat;
+			}
+		}
+
+		if (!has_ssdfs_segment_blk_bmap_initialized(&si->blk_bmap,
+							    pebc)) {
+			err = ssdfs_segment_blk_bmap_wait_init_end(&si->blk_bmap,
+								   pebc);
+			if (unlikely(err)) {
+				SSDFS_ERR("block bitmap init failed: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  si->seg_id, pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+		}
+
+		err = ssdfs_check_peb_container_init_state(pebc);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to check init state: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  si->seg_id, pebc->peb_index, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+		pebi = ssdfs_get_current_peb_locked(pebc);
+		if (IS_ERR_OR_NULL(pebi)) {
+			err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+			SSDFS_ERR("fail to get PEB object: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg %llu, peb_index %u, migration_state %#x\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  atomic_read(&pebc->migration_state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_peb_current_log_lock(pebi);
+		peb_id = pebi->peb_id;
+		peb_has_dirty_pages = ssdfs_peb_has_dirty_pages(pebi);
+		need_create_log = peb_has_dirty_pages ||
+					have_flush_requests(pebc);
+		is_peb_exhausted = is_ssdfs_peb_exhausted(fsi, pebi);
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb_id %llu, ssdfs_peb_has_dirty_pages %#x, "
+			  "have_flush_requests %#x, need_create_log %#x, "
+			  "is_peb_exhausted %#x\n",
+			  peb_id, peb_has_dirty_pages,
+			  have_flush_requests(pebc),
+			  need_create_log, is_peb_exhausted);
+#endif /* CONFIG_SSDFS_DEBUG */
+		ssdfs_peb_current_log_unlock(pebi);
+
+		if (!need_create_log) {
+			ssdfs_unlock_current_peb(pebc);
+			thread_state = SSDFS_FLUSH_THREAD_NEED_CREATE_LOG;
+			goto sleep_flush_thread;
+		}
+
+		if (has_commit_log_now_requested(pebc) &&
+		    is_create_requests_queue_empty(pebc)) {
+			/*
+			 * If no other commands in the queue
+			 * then ignore the log creation now.
+			 */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("Don't create log: "
+				  "COMMIT_LOG_NOW command: "
+				  "seg %llu, peb_index %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			ssdfs_unlock_current_peb(pebc);
+			thread_state = SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+			goto repeat;
+		}
+
+		if (has_start_migration_now_requested(pebc)) {
+			/*
+			 * No necessity to create log
+			 * for START_MIGRATION_NOW command.
+			 */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("Don't create log: "
+				  "START_MIGRATION_NOW command: "
+				  "seg %llu, peb_index %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			ssdfs_unlock_current_peb(pebc);
+			thread_state = SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+			goto repeat;
+		}
+
+		if (is_peb_exhausted) {
+			ssdfs_unlock_current_peb(pebc);
+
+			if (is_ssdfs_maptbl_under_flush(fsi)) {
+				if (is_ssdfs_peb_containing_user_data(pebc)) {
+					/*
+					 * Continue logic for user data.
+					 */
+#ifdef CONFIG_SSDFS_DEBUG
+					SSDFS_DBG("ignore mapping table's "
+						  "flush for user data\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+				} else if (have_flush_requests(pebc)) {
+					SSDFS_ERR("maptbl is flushing: "
+						  "unprocessed requests: "
+						  "seg %llu, peb %llu\n",
+						  pebc->parent_si->seg_id,
+						  peb_id);
+
+#ifdef CONFIG_SSDFS_DEBUG
+					ssdfs_peb_check_update_queue(pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+					BUG();
+				} else {
+					SSDFS_ERR("maptbl is flushing\n");
+					thread_state =
+					    SSDFS_FLUSH_THREAD_NEED_CREATE_LOG;
+					goto sleep_flush_thread;
+				}
+			}
+
+			if (is_peb_under_migration(pebc)) {
+				err = __ssdfs_peb_finish_migration(pebc);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to finish migration: "
+						  "seg %llu, peb_index %u, "
+						  "err %d\n",
+						  pebc->parent_si->seg_id,
+						  pebc->peb_index, err);
+					thread_state = SSDFS_FLUSH_THREAD_ERROR;
+					goto repeat;
+				}
+			}
+
+			if (!has_peb_migration_done(pebc)) {
+				SSDFS_ERR("migration is not finished: "
+					  "seg %llu, peb_index %u, "
+					  "err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			err = ssdfs_peb_start_migration(pebc);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to start migration: "
+					  "seg %llu, peb_index %u, "
+					  "err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			pebi = ssdfs_get_current_peb_locked(pebc);
+			if (IS_ERR_OR_NULL(pebi)) {
+				err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+				SSDFS_ERR("fail to get PEB object: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			if (is_ssdfs_maptbl_going_to_be_destroyed(maptbl)) {
+				SSDFS_WARN("seg %llu, peb_index %u\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index);
+			}
+
+			err = ssdfs_peb_container_change_state(pebc);
+			if (unlikely(err)) {
+				ssdfs_unlock_current_peb(pebc);
+				SSDFS_ERR("fail to change peb state: "
+					  "err %d\n", err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("is_peb_under_migration %#x, "
+			  "has_peb_migration_done %#x\n",
+			  is_peb_under_migration(pebc),
+			  has_peb_migration_done(pebc));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (is_peb_under_migration(pebc) &&
+		    has_peb_migration_done(pebc)) {
+			ssdfs_unlock_current_peb(pebc);
+
+			err = __ssdfs_peb_finish_migration(pebc);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to finish migration: "
+					  "seg %llu, peb_index %u, "
+					  "err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			pebi = ssdfs_get_current_peb_locked(pebc);
+			if (IS_ERR_OR_NULL(pebi)) {
+				err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+				SSDFS_ERR("fail to get PEB object: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			if (is_ssdfs_maptbl_going_to_be_destroyed(maptbl)) {
+				SSDFS_WARN("seg %llu, peb_index %u\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index);
+			}
+
+			err = ssdfs_peb_container_change_state(pebc);
+			if (unlikely(err)) {
+				ssdfs_unlock_current_peb(pebc);
+				SSDFS_ERR("fail to change peb state: "
+					  "err %d\n", err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+		}
+
+		mutex_lock(&pebc->migration_lock);
+		err = ssdfs_peb_create_log(pebi);
+		mutex_unlock(&pebc->migration_lock);
+		ssdfs_unlock_current_peb(pebc);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("finished: err %d\n", err);
+#else
+		SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (err == -EAGAIN) {
+			if (kthread_should_stop())
+				goto fail_create_log;
+			else {
+				err = 0;
+				goto sleep_flush_thread;
+			}
+		} else if (err == -ENOSPC) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("PEB hasn't free space: "
+				  "seg %llu, peb_index %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			thread_state = SSDFS_FLUSH_THREAD_FREE_SPACE_ABSENT;
+		} else if (unlikely(err)) {
+fail_create_log:
+			SSDFS_CRIT("fail to create log: "
+				   "seg %llu, peb_index %u, err %d\n",
+				   pebc->parent_si->seg_id,
+				   pebc->peb_index, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+		} else
+			thread_state = SSDFS_FLUSH_THREAD_CHECK_STOP_CONDITION;
+		goto repeat;
+		break;
+
+	case SSDFS_FLUSH_THREAD_CHECK_STOP_CONDITION:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("[FLUSH THREAD STATE] CHECK NECESSITY TO STOP: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#else
+		SSDFS_DBG("[FLUSH THREAD STATE] CHECK NECESSITY TO STOP: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (kthread_should_stop()) {
+			if (have_flush_requests(pebc)) {
+				state = ssdfs_peb_get_current_log_state(pebc);
+				if (state <= SSDFS_LOG_UNKNOWN ||
+				    state >= SSDFS_LOG_STATE_MAX) {
+					err = -ERANGE;
+					SSDFS_WARN("invalid log state: "
+						   "state %#x\n",
+						   state);
+					goto repeat;
+				}
+
+				if (state != SSDFS_LOG_CREATED) {
+					thread_state =
+					    SSDFS_FLUSH_THREAD_NEED_CREATE_LOG;
+					goto next_partial_step;
+				} else
+					goto process_flush_requests;
+			}
+
+			err = ssdfs_prepare_current_segment_ids(fsi,
+								cur_segs,
+								size);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare current seg IDs: "
+					  "err %d\n",
+					  err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			pebi = ssdfs_get_current_peb_locked(pebc);
+			if (IS_ERR_OR_NULL(pebi)) {
+				err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+				SSDFS_ERR("fail to get PEB object: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			ssdfs_peb_current_log_lock(pebi);
+			mutex_lock(&pebc->migration_lock);
+			err = ssdfs_peb_commit_log_on_thread_stop(pebi,
+								  cur_segs,
+								  size);
+			mutex_unlock(&pebc->migration_lock);
+			ssdfs_peb_current_log_unlock(pebi);
+
+			if (unlikely(err)) {
+				SSDFS_CRIT("fail to commit log: "
+					   "seg %llu, peb_index %u, err %d\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			}
+
+			ssdfs_unlock_current_peb(pebc);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+			SSDFS_ERR("finished: err %d\n", err);
+#else
+			SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+			goto stop_flush_thread;
+		} else {
+process_flush_requests:
+			state = ssdfs_peb_get_current_log_state(pebc);
+			if (state <= SSDFS_LOG_UNKNOWN ||
+			    state >= SSDFS_LOG_STATE_MAX) {
+				err = -ERANGE;
+				SSDFS_WARN("invalid log state: "
+					   "state %#x\n",
+					   state);
+				goto repeat;
+			}
+
+			if (state != SSDFS_LOG_CREATED) {
+				thread_state =
+					SSDFS_FLUSH_THREAD_NEED_CREATE_LOG;
+			} else {
+				thread_state =
+					SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST;
+			}
+			goto repeat;
+		}
+		break;
+
+	case SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("[FLUSH THREAD STATE] GET CREATE REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#else
+		SSDFS_DBG("[FLUSH THREAD STATE] GET CREATE REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (!have_flush_requests(pebc)) {
+			thread_state = SSDFS_FLUSH_THREAD_CHECK_STOP_CONDITION;
+			if (kthread_should_stop())
+				goto repeat;
+			else
+				goto sleep_flush_thread;
+		}
+
+		if (!is_peb_joined_into_create_requests_queue(pebc) ||
+		    is_create_requests_queue_empty(pebc)) {
+			thread_state = SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+			goto repeat;
+		}
+
+		spin_lock(&pebc->crq_ptr_lock);
+		err = ssdfs_requests_queue_remove_first(pebc->create_rq, &req);
+		spin_unlock(&pebc->crq_ptr_lock);
+
+		if (err == -ENODATA) {
+			SSDFS_DBG("empty create queue\n");
+			err = 0;
+			thread_state = SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+			goto repeat;
+		} else if (err == -ENOENT) {
+			SSDFS_WARN("request queue contains NULL request\n");
+			err = 0;
+			thread_state = SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+			goto repeat;
+		} else if (unlikely(err < 0)) {
+			SSDFS_CRIT("fail to get request from create queue: "
+				   "err %d\n",
+				   err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("req->private.class %#x, req->private.cmd %#x\n",
+			  req->private.class, req->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		thread_state = SSDFS_FLUSH_THREAD_PROCESS_CREATE_REQUEST;
+		goto next_partial_step;
+		break;
+
+	case SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("[FLUSH THREAD STATE] GET UPDATE REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#else
+		SSDFS_DBG("[FLUSH THREAD STATE] GET UPDATE REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (is_ssdfs_requests_queue_empty(&pebc->update_rq)) {
+			if (have_flush_requests(pebc)) {
+				thread_state =
+					SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST;
+				goto next_partial_step;
+			} else {
+				thread_state =
+					SSDFS_FLUSH_THREAD_CHECK_STOP_CONDITION;
+				goto sleep_flush_thread;
+			}
+		}
+
+		err = ssdfs_requests_queue_remove_first(&pebc->update_rq, &req);
+		if (err == -ENODATA) {
+			SSDFS_DBG("empty update queue\n");
+			err = 0;
+			thread_state = SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+			goto repeat;
+		} else if (err == -ENOENT) {
+			SSDFS_WARN("request queue contains NULL request\n");
+			err = 0;
+			thread_state = SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+			goto repeat;
+		} else if (unlikely(err < 0)) {
+			SSDFS_CRIT("fail to get request from update queue: "
+				   "err %d\n",
+				   err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("req->private.class %#x, req->private.cmd %#x\n",
+			  req->private.class, req->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		thread_state = SSDFS_FLUSH_THREAD_PROCESS_UPDATE_REQUEST;
+		goto next_partial_step;
+		break;
+
+	case SSDFS_FLUSH_THREAD_PROCESS_CREATE_REQUEST:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("[FLUSH THREAD STATE] PROCESS CREATE REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+		SSDFS_ERR("req->private.class %#x, req->private.cmd %#x\n",
+			  req->private.class, req->private.cmd);
+#else
+		SSDFS_DBG("[FLUSH THREAD STATE] PROCESS CREATE REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+		SSDFS_DBG("req->private.class %#x, req->private.cmd %#x\n",
+			  req->private.class, req->private.cmd);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		is_user_data = is_ssdfs_peb_containing_user_data(pebc);
+
+		if (!has_ssdfs_segment_blk_bmap_initialized(&si->blk_bmap,
+							    pebc)) {
+			err = ssdfs_segment_blk_bmap_wait_init_end(&si->blk_bmap,
+								   pebc);
+			if (unlikely(err)) {
+				SSDFS_ERR("block bitmap init failed: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  si->seg_id, pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+		}
+
+		pebi = ssdfs_get_current_peb_locked(pebc);
+		if (IS_ERR_OR_NULL(pebi)) {
+			err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+			SSDFS_ERR("fail to get PEB object: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+
+		mutex_lock(&pebc->migration_lock);
+		err = ssdfs_process_create_request(pebi, req);
+		mutex_unlock(&pebc->migration_lock);
+
+		if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to process create request: "
+				  "seg %llu, peb_index %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			ssdfs_finish_flush_request(pebc, req, wait_queue, err);
+			thread_state = SSDFS_FLUSH_THREAD_FREE_SPACE_ABSENT;
+			goto finish_create_request_processing;
+		} else if (err == -EAGAIN) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to process create request : "
+				  "seg %llu, peb_index %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			spin_lock(&pebc->crq_ptr_lock);
+			ssdfs_requests_queue_add_head(pebc->create_rq, req);
+			spin_unlock(&pebc->crq_ptr_lock);
+			req = NULL;
+			skip_finish_flush_request = true;
+			thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+			goto finish_create_request_processing;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to process create request: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			ssdfs_finish_flush_request(pebc, req, wait_queue, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto finish_create_request_processing;
+		}
+
+		if (req->private.type == SSDFS_REQ_SYNC) {
+			thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+			goto finish_create_request_processing;
+		}
+
+		/* SSDFS_REQ_ASYNC */
+		if (is_full_log_ready(pebi)) {
+			skip_finish_flush_request = false;
+			thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+			goto finish_create_request_processing;
+		} else if (should_partial_log_being_commited(pebi)) {
+			skip_finish_flush_request = false;
+			thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+			goto finish_create_request_processing;
+		} else if (!have_flush_requests(pebc)) {
+			if (need_wait_next_create_data_request(pebi)) {
+				ssdfs_account_user_data_flush_request(si);
+				ssdfs_finish_flush_request(pebc, req,
+							   wait_queue, err);
+				ssdfs_peb_current_log_unlock(pebi);
+				ssdfs_unlock_current_peb(pebc);
+
+				err = wait_next_create_request(pebc,
+							     &thread_state);
+				ssdfs_forget_user_data_flush_request(si);
+				skip_finish_flush_request = false;
+				goto finish_wait_next_create_request;
+			} else if (is_user_data) {
+				skip_finish_flush_request = false;
+				thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+				goto finish_create_request_processing;
+			} else {
+				goto get_next_update_request;
+			}
+		} else {
+get_next_update_request:
+			ssdfs_finish_flush_request(pebc, req,
+						   wait_queue, err);
+			thread_state =
+				SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+		}
+
+finish_create_request_processing:
+		ssdfs_peb_current_log_unlock(pebi);
+		ssdfs_unlock_current_peb(pebc);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("finished\n");
+#else
+		SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+finish_wait_next_create_request:
+		if (thread_state == SSDFS_FLUSH_THREAD_COMMIT_LOG)
+			goto next_partial_step;
+		else
+			goto repeat;
+		break;
+
+	case SSDFS_FLUSH_THREAD_PROCESS_UPDATE_REQUEST:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("[FLUSH THREAD STATE] PROCESS UPDATE REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+		SSDFS_ERR("req->private.class %#x, req->private.cmd %#x\n",
+			  req->private.class, req->private.cmd);
+#else
+		SSDFS_DBG("[FLUSH THREAD STATE] PROCESS UPDATE REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+		SSDFS_DBG("req->private.class %#x, req->private.cmd %#x\n",
+			  req->private.class, req->private.cmd);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		is_user_data = is_ssdfs_peb_containing_user_data(pebc);
+
+		if (!has_ssdfs_segment_blk_bmap_initialized(&si->blk_bmap,
+							    pebc)) {
+			err = ssdfs_segment_blk_bmap_wait_init_end(&si->blk_bmap,
+								   pebc);
+			if (unlikely(err)) {
+				SSDFS_ERR("block bitmap init failed: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  si->seg_id, pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+		}
+
+		pebi = ssdfs_get_current_peb_locked(pebc);
+		if (IS_ERR_OR_NULL(pebi)) {
+			err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+			SSDFS_ERR("fail to get PEB object: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+
+		mutex_lock(&pebc->migration_lock);
+		err = ssdfs_process_update_request(pebi, req);
+		mutex_unlock(&pebc->migration_lock);
+
+		if (err == -EAGAIN) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to process update request : "
+				  "seg %llu, peb_index %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			ssdfs_requests_queue_add_head(&pebc->update_rq, req);
+			req = NULL;
+			skip_finish_flush_request = true;
+			thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+			goto finish_update_request_processing;
+		} else if (err == -ENOENT &&
+			   req->private.cmd == SSDFS_BTREE_NODE_DIFF) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to process update request : "
+				  "seg %llu, peb_index %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			req = NULL;
+			thread_state = SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+			goto finish_update_request_processing;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to process update request: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			ssdfs_finish_flush_request(pebc, req, wait_queue, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto finish_update_request_processing;
+		}
+
+		switch (req->private.cmd) {
+		case SSDFS_EXTENT_WAS_INVALIDATED:
+			/* log has to be committed */
+			has_extent_been_invalidated = true;
+			thread_state =
+				SSDFS_FLUSH_THREAD_PROCESS_INVALIDATED_EXTENT;
+			goto finish_update_request_processing;
+
+		case SSDFS_START_MIGRATION_NOW:
+			thread_state = SSDFS_FLUSH_THREAD_START_MIGRATION_NOW;
+			goto finish_update_request_processing;
+
+		case SSDFS_COMMIT_LOG_NOW:
+			if (has_commit_log_now_requested(pebc)) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("Ignore current COMMIT_LOG_NOW: "
+					  "seg %llu, peb_index %u\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+				ssdfs_finish_flush_request(pebc, req,
+							   wait_queue, err);
+				thread_state =
+					SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST;
+			} else if (have_flush_requests(pebc)) {
+				ssdfs_requests_queue_add_tail(&pebc->update_rq,
+								req);
+				req = NULL;
+
+				state = atomic_read(&pebi->current_log.state);
+				if (state == SSDFS_LOG_COMMITTED) {
+					thread_state =
+					  SSDFS_FLUSH_THREAD_NEED_CREATE_LOG;
+				} else {
+					thread_state =
+					  SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST;
+				}
+			} else if (has_extent_been_invalidated) {
+				if (is_user_data_pages_invalidated(si) &&
+				    is_regular_fs_operations(pebc)) {
+					ssdfs_account_user_data_flush_request(si);
+					ssdfs_finish_flush_request(pebc, req,
+							   wait_queue, err);
+					ssdfs_peb_current_log_unlock(pebi);
+					ssdfs_unlock_current_peb(pebc);
+
+					err = wait_next_invalidate_request(pebc,
+								 &thread_state);
+					ssdfs_forget_user_data_flush_request(si);
+					skip_finish_flush_request = false;
+					goto finish_wait_next_data_request;
+				} else {
+					thread_state =
+						SSDFS_FLUSH_THREAD_COMMIT_LOG;
+				}
+			} else if (ssdfs_peb_has_dirty_pages(pebi)) {
+				if (need_wait_next_create_data_request(pebi)) {
+					ssdfs_account_user_data_flush_request(si);
+					ssdfs_finish_flush_request(pebc, req,
+							   wait_queue, err);
+					ssdfs_peb_current_log_unlock(pebi);
+					ssdfs_unlock_current_peb(pebc);
+
+					err = wait_next_create_request(pebc,
+								&thread_state);
+					ssdfs_forget_user_data_flush_request(si);
+					skip_finish_flush_request = false;
+					goto finish_wait_next_data_request;
+				} else if (need_wait_next_update_request(pebi)) {
+					ssdfs_account_user_data_flush_request(si);
+					ssdfs_finish_flush_request(pebc, req,
+							   wait_queue, err);
+					ssdfs_peb_current_log_unlock(pebi);
+					ssdfs_unlock_current_peb(pebc);
+
+					err = wait_next_update_request(pebc,
+								&thread_state);
+					ssdfs_forget_user_data_flush_request(si);
+					skip_finish_flush_request = false;
+					goto finish_wait_next_data_request;
+
+				} else {
+					thread_state =
+						SSDFS_FLUSH_THREAD_COMMIT_LOG;
+				}
+			} else {
+				ssdfs_finish_flush_request(pebc, req,
+							   wait_queue, err);
+
+				state = atomic_read(&pebi->current_log.state);
+				if (state == SSDFS_LOG_COMMITTED) {
+					thread_state =
+					  SSDFS_FLUSH_THREAD_NEED_CREATE_LOG;
+				} else {
+					thread_state =
+					  SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST;
+				}
+			}
+			goto finish_update_request_processing;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		if (req->private.type == SSDFS_REQ_SYNC) {
+			thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+			goto finish_update_request_processing;
+		} else if (has_migration_check_requested) {
+			ssdfs_finish_flush_request(pebc, req,
+						   wait_queue, err);
+			thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+			goto finish_update_request_processing;
+		} else if (is_full_log_ready(pebi)) {
+			skip_finish_flush_request = false;
+			thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+			goto finish_update_request_processing;
+		} else if (should_partial_log_being_commited(pebi)) {
+			skip_finish_flush_request = false;
+			thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+			goto finish_update_request_processing;
+		} else if (!have_flush_requests(pebc)) {
+			if (need_wait_next_update_request(pebi)) {
+				ssdfs_account_user_data_flush_request(si);
+				ssdfs_finish_flush_request(pebc, req,
+							   wait_queue, err);
+				ssdfs_peb_current_log_unlock(pebi);
+				ssdfs_unlock_current_peb(pebc);
+
+				err = wait_next_update_request(pebc,
+							     &thread_state);
+				ssdfs_forget_user_data_flush_request(si);
+				skip_finish_flush_request = false;
+				goto finish_wait_next_data_request;
+			} else if (is_user_data &&
+				   ssdfs_peb_has_dirty_pages(pebi)) {
+				skip_finish_flush_request = false;
+				thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+				goto finish_update_request_processing;
+			} else
+				goto get_next_create_request;
+		} else {
+get_next_create_request:
+			ssdfs_finish_flush_request(pebc, req, wait_queue, err);
+			thread_state = SSDFS_FLUSH_THREAD_GET_CREATE_REQUEST;
+			goto finish_update_request_processing;
+		}
+
+finish_update_request_processing:
+		ssdfs_peb_current_log_unlock(pebi);
+		ssdfs_unlock_current_peb(pebc);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("finished\n");
+#else
+		SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+finish_wait_next_data_request:
+		if (thread_state == SSDFS_FLUSH_THREAD_COMMIT_LOG ||
+		    thread_state == SSDFS_FLUSH_THREAD_START_MIGRATION_NOW) {
+			goto next_partial_step;
+		} else if (thread_state == SSDFS_FLUSH_THREAD_NEED_CREATE_LOG)
+			goto sleep_flush_thread;
+		else
+			goto repeat;
+		break;
+
+	case SSDFS_FLUSH_THREAD_PROCESS_INVALIDATED_EXTENT:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("[FLUSH THREAD STATE] PROCESS INVALIDATED EXTENT: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#else
+		SSDFS_DBG("[FLUSH THREAD STATE] PROCESS INVALIDATED EXTENT: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		pebi = ssdfs_get_current_peb_locked(pebc);
+		if (IS_ERR_OR_NULL(pebi)) {
+			err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+			SSDFS_ERR("fail to get PEB object: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+		if (is_peb_under_migration(pebc) &&
+		    has_peb_migration_done(pebc)) {
+			ssdfs_unlock_current_peb(pebc);
+
+			err = __ssdfs_peb_finish_migration(pebc);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to finish migration: "
+					  "seg %llu, peb_index %u, "
+					  "err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			pebi = ssdfs_get_current_peb_locked(pebc);
+			if (IS_ERR_OR_NULL(pebi)) {
+				err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+				SSDFS_ERR("fail to get PEB object: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			if (is_ssdfs_maptbl_going_to_be_destroyed(maptbl)) {
+				SSDFS_WARN("seg %llu, peb_index %u\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index);
+			}
+
+			err = ssdfs_peb_container_change_state(pebc);
+			if (unlikely(err)) {
+				ssdfs_unlock_current_peb(pebc);
+				SSDFS_ERR("fail to change peb state: "
+					  "err %d\n", err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		ssdfs_finish_flush_request(pebc, req, wait_queue, err);
+		ssdfs_peb_current_log_unlock(pebi);
+
+		ssdfs_unlock_current_peb(pebc);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("finished\n");
+#else
+		SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		thread_state = SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+		goto next_partial_step;
+		break;
+
+	case SSDFS_FLUSH_THREAD_START_MIGRATION_NOW:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("[FLUSH THREAD STATE] START MIGRATION REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#else
+		SSDFS_DBG("[FLUSH THREAD STATE] START MIGRATION REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		pebi = ssdfs_get_current_peb_locked(pebc);
+		if (IS_ERR_OR_NULL(pebi)) {
+			err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+			SSDFS_ERR("fail to get PEB object: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		is_peb_exhausted = is_ssdfs_peb_exhausted(fsi, pebi);
+		is_peb_ready_to_exhaust =
+			is_ssdfs_peb_ready_to_exhaust(fsi, pebi);
+		has_partial_empty_log =
+			ssdfs_peb_has_partial_empty_log(fsi, pebi);
+		ssdfs_peb_current_log_unlock(pebi);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("is_peb_exhausted %#x, "
+			  "is_peb_ready_to_exhaust %#x\n",
+			  is_peb_exhausted, is_peb_ready_to_exhaust);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (is_peb_exhausted || is_peb_ready_to_exhaust) {
+			ssdfs_unlock_current_peb(pebc);
+
+			if (is_peb_under_migration(pebc)) {
+				/*
+				 * START_MIGRATION_NOW is requested during
+				 * the flush operation of PEB mapping table,
+				 * segment bitmap or any btree. It is the first
+				 * step to initiate the migration.
+				 * Then, fragments or nodes will be flushed.
+				 * And final step is the COMMIT_LOG_NOW
+				 * request. So, it doesn't need to request
+				 * the COMMIT_LOG_NOW here.
+				 */
+				err = ssdfs_peb_finish_migration(pebc);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to finish migration: "
+						  "seg %llu, peb_index %u, "
+						  "err %d\n",
+						  pebc->parent_si->seg_id,
+						  pebc->peb_index, err);
+					thread_state = SSDFS_FLUSH_THREAD_ERROR;
+					goto process_migration_failure;
+				}
+			}
+
+			if (!has_peb_migration_done(pebc)) {
+				SSDFS_ERR("migration is not finished: "
+					  "seg %llu, peb_index %u, "
+					  "err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto process_migration_failure;
+			}
+
+			err = ssdfs_peb_start_migration(pebc);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to start migration: "
+					  "seg %llu, peb_index %u, "
+					  "err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto process_migration_failure;
+			}
+
+process_migration_failure:
+			pebi = ssdfs_get_current_peb_locked(pebc);
+			if (err) {
+				if (IS_ERR_OR_NULL(pebi)) {
+					thread_state = SSDFS_FLUSH_THREAD_ERROR;
+					goto repeat;
+				}
+
+				ssdfs_peb_current_log_lock(pebi);
+				ssdfs_finish_flush_request(pebc, req,
+							   wait_queue,
+							   err);
+				ssdfs_peb_current_log_unlock(pebi);
+				ssdfs_unlock_current_peb(pebc);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			} else if (IS_ERR_OR_NULL(pebi)) {
+				err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+				SSDFS_ERR("fail to get PEB object: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			if (is_ssdfs_maptbl_going_to_be_destroyed(maptbl)) {
+				SSDFS_WARN("seg %llu, peb_index %u\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index);
+			}
+
+			err = ssdfs_peb_container_change_state(pebc);
+			if (unlikely(err)) {
+				ssdfs_unlock_current_peb(pebc);
+				SSDFS_ERR("fail to change peb state: "
+					  "err %d\n", err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+		} else if (has_partial_empty_log) {
+			/*
+			 * TODO: it will need to implement logic here
+			 */
+			SSDFS_WARN("log is partially empty\n");
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		ssdfs_finish_flush_request(pebc, req, wait_queue, err);
+		ssdfs_peb_current_log_unlock(pebi);
+		ssdfs_unlock_current_peb(pebc);
+
+		state = ssdfs_peb_get_current_log_state(pebc);
+		if (state <= SSDFS_LOG_UNKNOWN ||
+		    state >= SSDFS_LOG_STATE_MAX) {
+			err = -ERANGE;
+			SSDFS_WARN("invalid log state: "
+				   "state %#x\n",
+				   state);
+			goto repeat;
+		}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("finished\n");
+#else
+		SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (state != SSDFS_LOG_CREATED) {
+			thread_state =
+				SSDFS_FLUSH_THREAD_NEED_CREATE_LOG;
+			goto sleep_flush_thread;
+		} else {
+			thread_state =
+				SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+		}
+		goto next_partial_step;
+		break;
+
+	case SSDFS_FLUSH_THREAD_COMMIT_LOG:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("[FLUSH THREAD STATE] COMMIT LOG: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#else
+		SSDFS_DBG("[FLUSH THREAD STATE] COMMIT LOG: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (postponed_req) {
+			req = postponed_req;
+			postponed_req = NULL;
+			has_migration_check_requested = false;
+		} else if (req != NULL) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("req->private.class %#x, "
+				  "req->private.cmd %#x\n",
+				  req->private.class,
+				  req->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			switch (req->private.class) {
+			case SSDFS_PEB_COLLECT_GARBAGE_REQ:
+				/* ignore this case */
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("ignore request class %#x\n",
+					  req->private.class);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto make_log_commit;
+
+			default:
+				/* Try to stimulate the migration */
+				break;
+			}
+
+			if (is_peb_under_migration(pebc) &&
+			    !has_migration_check_requested) {
+				SSDFS_DBG("Try to stimulate the migration\n");
+				thread_state =
+					SSDFS_FLUSH_THREAD_CHECK_MIGRATION_NEED;
+				has_migration_check_requested = true;
+				postponed_req = req;
+				req = NULL;
+				goto next_partial_step;
+			} else
+				has_migration_check_requested = false;
+		}
+
+make_log_commit:
+		err = ssdfs_prepare_current_segment_ids(fsi, cur_segs, size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare current segments IDs: "
+				  "err %d\n",
+				  err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+		pebi = ssdfs_get_current_peb_locked(pebc);
+		if (IS_ERR_OR_NULL(pebi)) {
+			err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+			SSDFS_ERR("fail to get PEB object: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			goto repeat;
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		mutex_lock(&pebc->migration_lock);
+		peb_id = pebi->peb_id;
+		err = ssdfs_peb_commit_log(pebi, cur_segs, size);
+		mutex_unlock(&pebc->migration_lock);
+
+		if (err) {
+			ssdfs_peb_clear_current_log_pages(pebi);
+			ssdfs_peb_clear_cache_dirty_pages(pebi);
+			ssdfs_requests_queue_remove_all(&pebc->update_rq,
+							-EROFS);
+
+			ssdfs_fs_error(fsi->sb,
+					__FILE__, __func__, __LINE__,
+					"fail to commit log: "
+					"seg %llu, peb_index %u, err %d\n",
+					pebc->parent_si->seg_id,
+					pebc->peb_index, err);
+		}
+		ssdfs_peb_current_log_unlock(pebi);
+
+		if (!err) {
+			has_extent_been_invalidated = false;
+
+			if (is_ssdfs_maptbl_going_to_be_destroyed(maptbl)) {
+				SSDFS_WARN("mapping table is near destroy: "
+					   "seg %llu, peb_index %u, "
+					   "peb_id %llu, peb_type %#x, "
+					   "req->private.class %#x, "
+					   "req->private.cmd %#x\n",
+					   pebc->parent_si->seg_id,
+					   pebc->peb_index,
+					   peb_id,
+					   pebc->peb_type,
+					   req->private.class,
+					   req->private.cmd);
+			}
+
+			ssdfs_forget_invalidated_user_data_pages(si);
+
+			err = ssdfs_peb_container_change_state(pebc);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change peb state: "
+					  "err %d\n", err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+			}
+		}
+
+		ssdfs_peb_current_log_lock(pebi);
+		if (skip_finish_flush_request)
+			skip_finish_flush_request = false;
+		else
+			ssdfs_finish_flush_request(pebc, req, wait_queue, err);
+		ssdfs_peb_current_log_unlock(pebi);
+
+		ssdfs_unlock_current_peb(pebc);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		ssdfs_peb_check_update_queue(pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("finished: err %d\n", err);
+#else
+		SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (unlikely(err))
+			goto repeat;
+
+		thread_state = SSDFS_FLUSH_THREAD_DELEGATE_CREATE_ROLE;
+		goto next_partial_step;
+		break;
+
+	case SSDFS_FLUSH_THREAD_CHECK_MIGRATION_NEED:
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("[FLUSH THREAD STATE] CHECK MIGRATION NEED REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#else
+		SSDFS_DBG("[FLUSH THREAD STATE] CHECK MIGRATION NEED REQUEST: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+		if (is_peb_under_migration(pebc)) {
+			u32 free_space1, free_space2;
+			u16 free_data_pages;
+
+			pebi = ssdfs_get_current_peb_locked(pebc);
+			if (IS_ERR_OR_NULL(pebi)) {
+				err = pebi == NULL ? -ERANGE : PTR_ERR(pebi);
+				SSDFS_ERR("fail to get PEB object: "
+					  "seg %llu, peb_index %u, err %d\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index, err);
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			}
+
+			ssdfs_peb_current_log_lock(pebi);
+			free_space1 = ssdfs_area_free_space(pebi,
+						SSDFS_LOG_JOURNAL_AREA);
+			free_space2 = ssdfs_area_free_space(pebi,
+						SSDFS_LOG_DIFFS_AREA);
+			free_data_pages = pebi->current_log.free_data_pages;
+			peb_has_dirty_pages = ssdfs_peb_has_dirty_pages(pebi);
+			ssdfs_peb_current_log_unlock(pebi);
+			ssdfs_unlock_current_peb(pebc);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("free_space1 %u, free_space2 %u, "
+				  "free_data_pages %u, peb_has_dirty_pages %#x\n",
+				  free_space1, free_space2,
+				  free_data_pages, peb_has_dirty_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (!peb_has_dirty_pages) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("PEB has no dirty pages: "
+					  "seg_id %llu, peb_index %u\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_check_migration_need;
+			}
+
+			if (free_data_pages == 0) {
+				/*
+				 * No free space for shadow migration.
+				 */
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("No free space for shadow migration: "
+					  "seg_id %llu, peb_index %u\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_check_migration_need;
+			}
+
+			if (free_space1 < (PAGE_SIZE / 2) &&
+			    free_space2 < (PAGE_SIZE / 2)) {
+				/*
+				 * No free space for shadow migration.
+				 */
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("No free space for shadow migration: "
+					  "seg_id %llu, peb_index %u\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_check_migration_need;
+			}
+
+			if (!has_ssdfs_source_peb_valid_blocks(pebc)) {
+				/*
+				 * No used blocks in the source PEB.
+				 */
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("No used blocks in the source PEB: "
+					  "seg_id %llu, peb_index %u\n",
+					  pebc->parent_si->seg_id,
+					  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto finish_check_migration_need;
+			}
+
+			mutex_lock(&pebc->migration_lock);
+
+			if (free_space1 >= (PAGE_SIZE / 2)) {
+				err = ssdfs_peb_prepare_range_migration(pebc, 1,
+						    SSDFS_BLK_PRE_ALLOCATED);
+				if (err == -ENODATA) {
+					err = 0;
+					SSDFS_DBG("unable to migrate: "
+						  "no pre-allocated blocks\n");
+				} else
+					goto stimulate_migration_done;
+			}
+
+			if (free_space2 >= (PAGE_SIZE / 2)) {
+				err = ssdfs_peb_prepare_range_migration(pebc, 1,
+						    SSDFS_BLK_VALID);
+				if (err == -ENODATA) {
+					SSDFS_DBG("unable to migrate: "
+						  "no valid blocks\n");
+				}
+			}
+
+stimulate_migration_done:
+			mutex_unlock(&pebc->migration_lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+			SSDFS_ERR("finished: err %d\n", err);
+#else
+			SSDFS_DBG("finished: err %d\n", err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+			if (err == -ENODATA) {
+				err = 0;
+				goto finish_check_migration_need;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare range migration: "
+					  "err %d\n", err);
+				thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+				goto next_partial_step;
+			}
+
+			thread_state = SSDFS_FLUSH_THREAD_GET_UPDATE_REQUEST;
+			goto next_partial_step;
+		} else {
+finish_check_migration_need:
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("no migration necessary: "
+				  "seg_id %llu, peb_index %u\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+			thread_state = SSDFS_FLUSH_THREAD_COMMIT_LOG;
+			goto next_partial_step;
+		}
+		break;
+
+	case SSDFS_FLUSH_THREAD_DELEGATE_CREATE_ROLE:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("[FLUSH THREAD STATE] DELEGATE CREATE ROLE: "
+			  "seg_id %llu, peb_index %u\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (!is_peb_joined_into_create_requests_queue(pebc)) {
+finish_delegation:
+			if (err) {
+				thread_state = SSDFS_FLUSH_THREAD_ERROR;
+				goto repeat;
+			} else {
+				thread_state =
+					SSDFS_FLUSH_THREAD_CHECK_STOP_CONDITION;
+				goto sleep_flush_thread;
+			}
+		}
+
+		err = ssdfs_peb_find_next_log_creation_thread(pebc);
+		if (unlikely(err)) {
+			SSDFS_WARN("fail to delegate log creation role: "
+				   "seg %llu, peb_index %u, err %d\n",
+				   pebc->parent_si->seg_id,
+				   pebc->peb_index, err);
+		}
+		goto finish_delegation;
+		break;
+
+	default:
+		BUG();
+	};
+
+/*
+ * Every thread should be added into one wait queue only.
+ * Segment object should have several queues:
+ * (1) read threads waiting queue;
+ * (2) flush threads waiting queue;
+ * (3) GC threads waiting queue.
+ * The wakeup operation should be the operation under group
+ * of threads of the same type. Thread function should check
+ * several condition in the case of wakeup.
+ */
+
+sleep_flush_thread:
+#ifdef CONFIG_SSDFS_DEBUG
+	if (is_ssdfs_peb_containing_user_data(pebc)) {
+		pebi = ssdfs_get_current_peb_locked(pebc);
+		if (!IS_ERR_OR_NULL(pebi)) {
+			ssdfs_peb_current_log_lock(pebi);
+
+			if (ssdfs_peb_has_dirty_pages(pebi)) {
+				u64 reserved_new_user_data_pages;
+				u64 updated_user_data_pages;
+				u64 flushing_user_data_requests;
+
+				spin_lock(&fsi->volume_state_lock);
+				reserved_new_user_data_pages =
+					fsi->reserved_new_user_data_pages;
+				updated_user_data_pages =
+					fsi->updated_user_data_pages;
+				flushing_user_data_requests =
+					fsi->flushing_user_data_requests;
+				spin_unlock(&fsi->volume_state_lock);
+
+				SSDFS_WARN("seg %llu, peb %llu, peb_type %#x, "
+					  "global_fs_state %#x, "
+					  "reserved_new_user_data_pages %llu, "
+					  "updated_user_data_pages %llu, "
+					  "flushing_user_data_requests %llu\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id, pebi->pebc->peb_type,
+					  atomic_read(&fsi->global_fs_state),
+					  reserved_new_user_data_pages,
+					  updated_user_data_pages,
+					  flushing_user_data_requests);
+			}
+
+			ssdfs_peb_current_log_unlock(pebi);
+			ssdfs_unlock_current_peb(pebc);
+		}
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	wait_event_interruptible(*wait_queue,
+				 FLUSH_THREAD_WAKE_CONDITION(pebc));
+	goto repeat;
+
+sleep_failed_flush_thread:
+	wait_event_interruptible(*wait_queue,
+		FLUSH_FAILED_THREAD_WAKE_CONDITION());
+	goto repeat;
+}
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552E36A262F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjBYBQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBYBQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:27 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940C114EBA
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:09 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bk32so762466oib.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEtIMF7jvR+q3tDMJmdQuHQ1cOBS0qnrBNVMhJsDmig=;
        b=X3iyCXxucZJkxPcK6qbUWCCSdWXilxfoYYOhHnjDhpyQZnGcSHcM0oorbsEYtLvZYo
         w98l6d1Glgxue/LPAPSuJjd82y1k/d4h/RG1UA+uGzW4S4s8PT/BDiWBYsIHo8HTqC9y
         q3poXNM7DqQIkgCkj916iQmabEcfghUUlkuYfp0y0IWIuQTfT01KXaA4INy/tXBwpWMg
         XMHPySWd5lHdJMeOaJnPls71nH5b8Rx0fkTYP4Be2pIg6m6kqeh7XgQDNm9yOP+43COY
         8eQB7X8DYetYmfMT9ioVm3K/45h3HWkfI5md1rgBjLAI7dagEuGuzRTXgnf6iv0pa6kF
         ReuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEtIMF7jvR+q3tDMJmdQuHQ1cOBS0qnrBNVMhJsDmig=;
        b=QpdWIos1ArgcLzHSnExejdxI6tC37XoxDJsjYVZIL2dV6sbwLi9wPzDAVLLBHhN9yt
         Yh0cy9d1dawNBTamWyIPwDlQhUDyG5woQzzwTfGrqti/aNBARWOG7Mz3NCP67P55C2Bn
         RDHPm3/cQeiKE1yHAxJ7aEGUKr/CQ+D+OCqy3XF9WtC3GCYVGTldWlESwBVUUR7w01kk
         8JVNfUOuCI/DzVDGGWisDp2FGReGskZ+kzMIwho+aEAUuQw2b8HLi/qjhs4yAynaoNYi
         wISF0CwSlDQGwQ9Fcv/fs/FKDEGxIl13BHKOg/5JSwn3mtjvNt0XfIJpxHCU1Xm+v9uW
         YCFg==
X-Gm-Message-State: AO0yUKX9OiJe/sfnt2TRQkG3koONK/7OW47h/+/Ft6dojXZuySHs6gyN
        KKe/fAGDDgAIpJV8/WcWjIpnBKH0NpWrtOoH
X-Google-Smtp-Source: AK7set8LpXTa9elhrOEEehfwu97q7TqRG7UNNY1Ci+sFfztQE+7Ne44MdzV3sNfxsq/nwPHgrdfbjg==
X-Received: by 2002:a54:4103:0:b0:371:c6e:f45a with SMTP id l3-20020a544103000000b003710c6ef45amr7553995oic.34.1677287768332;
        Fri, 24 Feb 2023 17:16:08 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:07 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 16/76] ssdfs: introduce segment request queue
Date:   Fri, 24 Feb 2023 17:08:27 -0800
Message-Id: <20230225010927.813929-17-slava@dubeyko.com>
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

SSDFS implements a current segment concept. This concept implies
that current segment object receives requests for adding new data
or metadata. Also, PEB container object can receive requests for
update of existing data or metadata. Segment request queue implements
concept of such add new data or update requests.

Segment request object defines:
(1) logical extent (inode ID, logical offset from file's beginning
    in bytes, valid bytes count in request);
(2) volume extent (segment ID, logical block ID, length in logical
    blocks);
(3) request class (read, create, update, and so on);
(4) request command (read page, create block, update block, and so on);
(5) request type (synchronous, asynchronous, and so on).

Current segment has create queue and every PEB container object
has update queue. Caller needs to allocate segment request object,
initialize it, and add into particular request queue. PEB's
dedicated thread takes requests from the queue and executes
requested action.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/request_queue.c | 1240 ++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/request_queue.h |  417 +++++++++++++
 2 files changed, 1657 insertions(+)
 create mode 100644 fs/ssdfs/request_queue.c
 create mode 100644 fs/ssdfs/request_queue.h

diff --git a/fs/ssdfs/request_queue.c b/fs/ssdfs/request_queue.c
new file mode 100644
index 000000000000..985adfe31bb3
--- /dev/null
+++ b/fs/ssdfs/request_queue.c
@@ -0,0 +1,1240 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/request_queue.c - request queue implementation.
+ *
+ * Copyright (c) 2014-2019, HGST, a Western Digital Company.
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
+#include "request_queue.h"
+#include "segment_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb_container.h"
+#include "segment.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "snapshots_tree.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_req_queue_page_leaks;
+atomic64_t ssdfs_req_queue_memory_leaks;
+atomic64_t ssdfs_req_queue_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_req_queue_cache_leaks_increment(void *kaddr)
+ * void ssdfs_req_queue_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_req_queue_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_req_queue_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_req_queue_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_req_queue_kfree(void *kaddr)
+ * struct page *ssdfs_req_queue_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_req_queue_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_req_queue_free_page(struct page *page)
+ * void ssdfs_req_queue_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(req_queue)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(req_queue)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_req_queue_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_req_queue_page_leaks, 0);
+	atomic64_set(&ssdfs_req_queue_memory_leaks, 0);
+	atomic64_set(&ssdfs_req_queue_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_req_queue_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_req_queue_page_leaks) != 0) {
+		SSDFS_ERR("REQUESTS QUEUE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_req_queue_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_req_queue_memory_leaks) != 0) {
+		SSDFS_ERR("REQUESTS QUEUE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_req_queue_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_req_queue_cache_leaks) != 0) {
+		SSDFS_ERR("REQUESTS QUEUE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_req_queue_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static struct kmem_cache *ssdfs_seg_req_obj_cachep;
+
+void ssdfs_zero_seg_req_obj_cache_ptr(void)
+{
+	ssdfs_seg_req_obj_cachep = NULL;
+}
+
+static
+void ssdfs_init_seg_req_object_once(void *obj)
+{
+	struct ssdfs_segment_request *req_obj = obj;
+
+	memset(req_obj, 0, sizeof(struct ssdfs_segment_request));
+}
+
+void ssdfs_shrink_seg_req_obj_cache(void)
+{
+	if (ssdfs_seg_req_obj_cachep)
+		kmem_cache_shrink(ssdfs_seg_req_obj_cachep);
+}
+
+void ssdfs_destroy_seg_req_obj_cache(void)
+{
+	if (ssdfs_seg_req_obj_cachep)
+		kmem_cache_destroy(ssdfs_seg_req_obj_cachep);
+}
+
+int ssdfs_init_seg_req_obj_cache(void)
+{
+	ssdfs_seg_req_obj_cachep = kmem_cache_create("ssdfs_seg_req_obj_cache",
+					sizeof(struct ssdfs_segment_request), 0,
+					SLAB_RECLAIM_ACCOUNT |
+					SLAB_MEM_SPREAD |
+					SLAB_ACCOUNT,
+					ssdfs_init_seg_req_object_once);
+	if (!ssdfs_seg_req_obj_cachep) {
+		SSDFS_ERR("unable to create segment request objects cache\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_requests_queue_init() - initialize request queue
+ * @rq: initialized request queue
+ */
+void ssdfs_requests_queue_init(struct ssdfs_requests_queue *rq)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!rq);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock_init(&rq->lock);
+	INIT_LIST_HEAD(&rq->list);
+}
+
+/*
+ * is_ssdfs_requests_queue_empty() - check that requests queue is empty
+ * @rq: requests queue
+ */
+bool is_ssdfs_requests_queue_empty(struct ssdfs_requests_queue *rq)
+{
+	bool is_empty;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!rq);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&rq->lock);
+	is_empty = list_empty_careful(&rq->list);
+	spin_unlock(&rq->lock);
+
+	return is_empty;
+}
+
+/*
+ * ssdfs_requests_queue_add_head() - add request at the head of queue
+ * @rq: requests queue
+ * @req: request
+ */
+void ssdfs_requests_queue_add_head(struct ssdfs_requests_queue *rq,
+				   struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!rq || !req);
+
+	SSDFS_DBG("seg_id %llu, class %#x, cmd %#x\n",
+		  req->place.start.seg_id,
+		  req->private.class,
+		  req->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&rq->lock);
+	list_add(&req->list, &rq->list);
+	spin_unlock(&rq->lock);
+}
+
+/*
+ * ssdfs_requests_queue_add_head_inc() - add request at the head of queue
+ * @fsi: pointer on shared file system object
+ * @rq: requests queue
+ * @req: request
+ */
+void ssdfs_requests_queue_add_head_inc(struct ssdfs_fs_info *fsi,
+					struct ssdfs_requests_queue *rq,
+					struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !rq || !req);
+
+	SSDFS_DBG("seg_id %llu, class %#x, cmd %#x\n",
+		  req->place.start.seg_id,
+		  req->private.class,
+		  req->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_requests_queue_add_head(rq, req);
+	atomic64_inc(&fsi->flush_reqs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("flush_reqs %lld\n",
+		  atomic64_read(&fsi->flush_reqs));
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_requests_queue_add_tail() - add request at the tail of queue
+ * @rq: requests queue
+ * @req: request
+ */
+void ssdfs_requests_queue_add_tail(struct ssdfs_requests_queue *rq,
+				   struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!rq || !req);
+
+	SSDFS_DBG("seg_id %llu, class %#x, cmd %#x\n",
+		  req->place.start.seg_id,
+		  req->private.class,
+		  req->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&rq->lock);
+	list_add_tail(&req->list, &rq->list);
+	spin_unlock(&rq->lock);
+}
+
+/*
+ * ssdfs_requests_queue_add_tail_inc() - add request at the tail of queue
+ * @fsi: pointer on shared file system object
+ * @rq: requests queue
+ * @req: request
+ */
+void ssdfs_requests_queue_add_tail_inc(struct ssdfs_fs_info *fsi,
+					struct ssdfs_requests_queue *rq,
+					struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !rq || !req);
+
+	SSDFS_DBG("seg_id %llu, class %#x, cmd %#x\n",
+		  req->place.start.seg_id,
+		  req->private.class,
+		  req->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_requests_queue_add_tail(rq, req);
+	atomic64_inc(&fsi->flush_reqs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("flush_reqs %lld\n",
+		  atomic64_read(&fsi->flush_reqs));
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * is_request_command_valid() - check request's command validity
+ * @class: request's class
+ * @cmd: request's command
+ */
+static inline
+bool is_request_command_valid(int class, int cmd)
+{
+	bool is_valid = false;
+
+	switch (class) {
+	case SSDFS_PEB_READ_REQ:
+		is_valid = cmd > SSDFS_UNKNOWN_CMD &&
+				cmd < SSDFS_READ_CMD_MAX;
+		break;
+
+	case SSDFS_PEB_PRE_ALLOCATE_DATA_REQ:
+	case SSDFS_PEB_CREATE_DATA_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ:
+	case SSDFS_PEB_CREATE_LNODE_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ:
+	case SSDFS_PEB_CREATE_HNODE_REQ:
+	case SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ:
+	case SSDFS_PEB_CREATE_IDXNODE_REQ:
+	case SSDFS_ZONE_USER_DATA_MIGRATE_REQ:
+		is_valid = cmd > SSDFS_READ_CMD_MAX &&
+				cmd < SSDFS_CREATE_CMD_MAX;
+		break;
+
+	case SSDFS_PEB_UPDATE_REQ:
+	case SSDFS_PEB_PRE_ALLOC_UPDATE_REQ:
+		is_valid = cmd > SSDFS_CREATE_CMD_MAX &&
+				cmd < SSDFS_UPDATE_CMD_MAX;
+		break;
+
+	case SSDFS_PEB_DIFF_ON_WRITE_REQ:
+		is_valid = cmd > SSDFS_UPDATE_CMD_MAX &&
+				cmd < SSDFS_DIFF_ON_WRITE_MAX;
+		break;
+
+	case SSDFS_PEB_COLLECT_GARBAGE_REQ:
+		is_valid = cmd > SSDFS_DIFF_ON_WRITE_MAX &&
+				cmd < SSDFS_COLLECT_GARBAGE_CMD_MAX;
+		break;
+
+	default:
+		is_valid = false;
+	}
+
+	return is_valid;
+}
+
+/*
+ * ssdfs_requests_queue_remove_first() - get request and remove from queue
+ * @rq: requests queue
+ * @req: first request [out]
+ *
+ * This function get first request in @rq, remove it from queue
+ * and return as @req.
+ *
+ * RETURN:
+ * [success] - @req contains pointer on request.
+ * [failure] - error code:
+ *
+ * %-ENODATA     - queue is empty.
+ * %-ENOENT      - first empty is NULL.
+ */
+int ssdfs_requests_queue_remove_first(struct ssdfs_requests_queue *rq,
+				      struct ssdfs_segment_request **req)
+{
+	bool is_empty;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!rq || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&rq->lock);
+	is_empty = list_empty_careful(&rq->list);
+	if (!is_empty) {
+		*req = list_first_entry_or_null(&rq->list,
+						struct ssdfs_segment_request,
+						list);
+		if (!*req) {
+			SSDFS_WARN("first entry is NULL\n");
+			err = -ENOENT;
+		} else
+			list_del(&(*req)->list);
+	}
+	spin_unlock(&rq->lock);
+
+	if (is_empty) {
+		SSDFS_WARN("requests queue is empty\n");
+		return -ENODATA;
+	} else if (err)
+		return err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!is_request_command_valid((*req)->private.class,
+					 (*req)->private.cmd));
+	BUG_ON((*req)->private.type >= SSDFS_REQ_TYPE_MAX);
+
+	SSDFS_DBG("seg_id %llu, class %#x, cmd %#x\n",
+		  (*req)->place.start.seg_id,
+		  (*req)->private.class,
+		  (*req)->private.cmd);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_requests_queue_remove_all() - remove all requests from queue
+ * @rq: requests queue
+ * @err: error code
+ *
+ * This function removes all requests from the queue.
+ */
+void ssdfs_requests_queue_remove_all(struct ssdfs_requests_queue *rq,
+				     int err)
+{
+	bool is_empty;
+	LIST_HEAD(tmp_list);
+	struct list_head *this, *next;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!rq);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&rq->lock);
+	is_empty = list_empty_careful(&rq->list);
+	if (!is_empty)
+		list_replace_init(&rq->list, &tmp_list);
+	spin_unlock(&rq->lock);
+
+	if (is_empty)
+		return;
+
+	list_for_each_safe(this, next, &tmp_list) {
+		struct ssdfs_segment_request *req;
+		unsigned int i;
+
+		req = list_entry(this, struct ssdfs_segment_request, list);
+
+		if (!req) {
+			SSDFS_WARN("empty request ptr\n");
+			continue;
+		}
+
+		list_del(&req->list);
+
+		SSDFS_WARN("delete request: "
+			   "class %#x, cmd %#x, type %#x, refs_count %u, "
+			   "seg %llu, extent (start %u, len %u)\n",
+			   req->private.class, req->private.cmd,
+			   req->private.type,
+			   atomic_read(&req->private.refs_count),
+			   req->place.start.seg_id,
+			   req->place.start.blk_index,
+			   req->place.len);
+
+		atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+
+		switch (req->private.type) {
+		case SSDFS_REQ_SYNC:
+			req->result.err = err;
+			complete(&req->result.wait);
+			wake_up_all(&req->private.wait_queue);
+			break;
+
+		case SSDFS_REQ_ASYNC:
+			complete(&req->result.wait);
+			wake_up_all(&req->private.wait_queue);
+
+			for (i = 0; i < pagevec_count(&req->result.pvec); i++) {
+				struct page *page = req->result.pvec.pages[i];
+
+				if (!page) {
+					SSDFS_WARN("empty page ptr: index %u\n", i);
+					continue;
+				}
+
+#ifdef CONFIG_SSDFS_DEBUG
+				WARN_ON(!PageLocked(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				ClearPageUptodate(page);
+				ssdfs_clear_page_private(page, 0);
+				ClearPageMappedToDisk(page);
+				ssdfs_clear_dirty_page(page);
+				ssdfs_unlock_page(page);
+				end_page_writeback(page);
+			}
+
+			ssdfs_put_request(req);
+			ssdfs_request_free(req);
+			break;
+
+		case SSDFS_REQ_ASYNC_NO_FREE:
+			complete(&req->result.wait);
+			wake_up_all(&req->private.wait_queue);
+
+			for (i = 0; i < pagevec_count(&req->result.pvec); i++) {
+				struct page *page = req->result.pvec.pages[i];
+
+				if (!page) {
+					SSDFS_WARN("empty page ptr: index %u\n", i);
+					continue;
+				}
+
+#ifdef CONFIG_SSDFS_DEBUG
+				WARN_ON(!PageLocked(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				ClearPageUptodate(page);
+				ssdfs_clear_page_private(page, 0);
+				ClearPageMappedToDisk(page);
+				ssdfs_clear_dirty_page(page);
+				ssdfs_unlock_page(page);
+				end_page_writeback(page);
+			}
+
+			ssdfs_put_request(req);
+			break;
+
+		default:
+			BUG();
+		};
+	}
+}
+
+/*
+ * ssdfs_request_alloc() - allocate memory for segment request object
+ */
+struct ssdfs_segment_request *ssdfs_request_alloc(void)
+{
+	struct ssdfs_segment_request *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_seg_req_obj_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = kmem_cache_alloc(ssdfs_seg_req_obj_cachep, GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate memory for request\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ssdfs_req_queue_cache_leaks_increment(ptr);
+
+	return ptr;
+}
+
+/*
+ * ssdfs_request_free() - free memory for segment request object
+ */
+void ssdfs_request_free(struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_seg_req_obj_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!req)
+		return;
+
+	ssdfs_req_queue_cache_leaks_decrement(req);
+	kmem_cache_free(ssdfs_seg_req_obj_cachep, req);
+}
+
+/*
+ * ssdfs_request_init() - common request initialization
+ * @req: request [out]
+ */
+void ssdfs_request_init(struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(req, 0, sizeof(struct ssdfs_segment_request));
+
+	INIT_LIST_HEAD(&req->list);
+	atomic_set(&req->private.refs_count, 0);
+	init_waitqueue_head(&req->private.wait_queue);
+	pagevec_init(&req->result.pvec);
+	pagevec_init(&req->result.diffs);
+	atomic_set(&req->result.state, SSDFS_REQ_CREATED);
+	init_completion(&req->result.wait);
+	req->result.err = 0;
+}
+
+/*
+ * ssdfs_get_request() - increment reference counter
+ * @req: request
+ */
+void ssdfs_get_request(struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	WARN_ON(atomic_inc_return(&req->private.refs_count) <= 0);
+}
+
+/*
+ * ssdfs_put_request() - decrement reference counter
+ * @req: request
+ */
+void ssdfs_put_request(struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_dec_return(&req->private.refs_count) < 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("request's reference count %d\n",
+			  atomic_read(&req->private.refs_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+}
+
+/*
+ * ssdfs_request_add_page() - add memory page into segment request
+ * @page: memory page
+ * @req: segment request [out]
+ */
+int ssdfs_request_add_page(struct page *page,
+			   struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_space(&req->result.pvec) == 0) {
+		SSDFS_WARN("request's pagevec is full\n");
+		return -E2BIG;
+	}
+
+	pagevec_add(&req->result.pvec, page);
+	return 0;
+}
+
+/*
+ * ssdfs_request_add_diff_page() - add diff page into segment request
+ * @page: memory page
+ * @req: segment request [out]
+ */
+int ssdfs_request_add_diff_page(struct page *page,
+				struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_space(&req->result.diffs) == 0) {
+		SSDFS_WARN("request's pagevec is full\n");
+		return -E2BIG;
+	}
+
+	pagevec_add(&req->result.diffs, page);
+	return 0;
+}
+
+/*
+ * ssdfs_request_allocate_and_add_page() - allocate and add page into request
+ * @req: segment request [out]
+ */
+struct page *
+ssdfs_request_allocate_and_add_page(struct ssdfs_segment_request *req)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+
+	SSDFS_DBG("pagevec count %d\n",
+		  pagevec_count(&req->result.pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_space(&req->result.pvec) == 0) {
+		SSDFS_WARN("request's pagevec is full\n");
+		return ERR_PTR(-E2BIG);
+	}
+
+	page = ssdfs_req_queue_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		return ERR_PTR(err);
+	}
+
+	pagevec_add(&req->result.pvec, page);
+	return page;
+}
+
+/*
+ * ssdfs_request_allocate_and_add_diff_page() - allocate and add diff page
+ * @req: segment request [out]
+ */
+struct page *
+ssdfs_request_allocate_and_add_diff_page(struct ssdfs_segment_request *req)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+
+	SSDFS_DBG("pagevec count %d\n",
+		  pagevec_count(&req->result.diffs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_space(&req->result.diffs) == 0) {
+		SSDFS_WARN("request's pagevec is full\n");
+		return ERR_PTR(-E2BIG);
+	}
+
+	page = ssdfs_req_queue_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		return ERR_PTR(err);
+	}
+
+	pagevec_add(&req->result.diffs, page);
+	return page;
+}
+
+/*
+ * ssdfs_request_allocate_and_add_old_state_page() - allocate+add old state page
+ * @req: segment request [out]
+ */
+struct page *
+ssdfs_request_allocate_and_add_old_state_page(struct ssdfs_segment_request *req)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+
+	SSDFS_DBG("pagevec count %d\n",
+		  pagevec_count(&req->result.old_state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_space(&req->result.old_state) == 0) {
+		SSDFS_WARN("request's pagevec is full\n");
+		return ERR_PTR(-E2BIG);
+	}
+
+	page = ssdfs_req_queue_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		return ERR_PTR(err);
+	}
+
+	pagevec_add(&req->result.old_state, page);
+	return page;
+}
+
+/*
+ * ssdfs_request_allocate_locked_page() - allocate and add locked page
+ * @req: segment request [out]
+ * @page_index: index of the page
+ */
+struct page *
+ssdfs_request_allocate_locked_page(struct ssdfs_segment_request *req,
+				   int page_index)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+
+	SSDFS_DBG("pagevec count %d\n",
+		  pagevec_count(&req->result.pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_space(&req->result.pvec) == 0) {
+		SSDFS_WARN("request's pagevec is full\n");
+		return ERR_PTR(-E2BIG);
+	}
+
+	if (page_index >= PAGEVEC_SIZE) {
+		SSDFS_ERR("invalid page index %d\n",
+			  page_index);
+		return ERR_PTR(-EINVAL);
+	}
+
+	page = req->result.pvec.pages[page_index];
+
+	if (page) {
+		SSDFS_ERR("page already exists: index %d\n",
+			  page_index);
+		return ERR_PTR(-EINVAL);
+	}
+
+	page = ssdfs_req_queue_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		return ERR_PTR(err);
+	}
+
+	req->result.pvec.pages[page_index] = page;
+
+	if ((page_index + 1) > req->result.pvec.nr)
+		req->result.pvec.nr = page_index + 1;
+
+	ssdfs_lock_page(page);
+
+	return page;
+}
+
+/*
+ * ssdfs_request_allocate_locked_diff_page() - allocate locked diff page
+ * @req: segment request [out]
+ * @page_index: index of the page
+ */
+struct page *
+ssdfs_request_allocate_locked_diff_page(struct ssdfs_segment_request *req,
+					int page_index)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+
+	SSDFS_DBG("pagevec count %d\n",
+		  pagevec_count(&req->result.diffs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_space(&req->result.diffs) == 0) {
+		SSDFS_WARN("request's pagevec is full\n");
+		return ERR_PTR(-E2BIG);
+	}
+
+	if (page_index >= PAGEVEC_SIZE) {
+		SSDFS_ERR("invalid page index %d\n",
+			  page_index);
+		return ERR_PTR(-EINVAL);
+	}
+
+	page = req->result.diffs.pages[page_index];
+
+	if (page) {
+		SSDFS_ERR("page already exists: index %d\n",
+			  page_index);
+		return ERR_PTR(-EINVAL);
+	}
+
+	page = ssdfs_req_queue_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		return ERR_PTR(err);
+	}
+
+	req->result.diffs.pages[page_index] = page;
+
+	if ((page_index + 1) > req->result.diffs.nr)
+		req->result.diffs.nr = page_index + 1;
+
+	ssdfs_lock_page(page);
+
+	return page;
+}
+
+/*
+ * ssdfs_request_add_allocated_page_locked() - allocate, add and lock page
+ * @req: segment request [out]
+ */
+int ssdfs_request_add_allocated_page_locked(struct ssdfs_segment_request *req)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_request_allocate_and_add_page(req);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("fail to allocate page: err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_lock_page(page);
+	return 0;
+}
+
+/*
+ * ssdfs_request_add_allocated_diff_locked() - allocate, add and lock page
+ * @req: segment request [out]
+ */
+int ssdfs_request_add_allocated_diff_locked(struct ssdfs_segment_request *req)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_request_allocate_and_add_diff_page(req);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("fail to allocate page: err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_lock_page(page);
+	return 0;
+}
+
+/*
+ * ssdfs_request_add_old_state_page_locked() - allocate, add and lock page
+ * @req: segment request [out]
+ */
+int ssdfs_request_add_old_state_page_locked(struct ssdfs_segment_request *req)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = ssdfs_request_allocate_and_add_old_state_page(req);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("fail to allocate page: err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_lock_page(page);
+	return 0;
+}
+
+/*
+ * ssdfs_request_unlock_and_remove_pages() - unlock and remove pages
+ * @req: segment request [out]
+ */
+void ssdfs_request_unlock_and_remove_pages(struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_unlock_and_remove_old_state(req);
+	ssdfs_request_unlock_and_remove_update(req);
+	ssdfs_request_unlock_and_remove_diffs(req);
+}
+
+/*
+ * ssdfs_request_unlock_and_remove_update() - unlock and remove update pages
+ * @req: segment request [out]
+ */
+void ssdfs_request_unlock_and_remove_update(struct ssdfs_segment_request *req)
+{
+	unsigned count;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	count = pagevec_count(&req->result.pvec);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("result: pages count %u\n",
+		  count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < count; i++) {
+		struct page *page = req->result.pvec.pages[i];
+
+		if (!page) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %d is NULL\n", i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		ssdfs_unlock_page(page);
+	}
+
+	ssdfs_req_queue_pagevec_release(&req->result.pvec);
+}
+
+/*
+ * ssdfs_request_unlock_and_remove_diffs() - unlock and remove diffs
+ * @req: segment request [out]
+ */
+void ssdfs_request_unlock_and_remove_diffs(struct ssdfs_segment_request *req)
+{
+	unsigned count;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	count = pagevec_count(&req->result.diffs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("diff: pages count %u\n",
+		  count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < count; i++) {
+		struct page *page = req->result.diffs.pages[i];
+
+		if (!page) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %d is NULL\n", i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		ssdfs_unlock_page(page);
+	}
+
+	ssdfs_req_queue_pagevec_release(&req->result.diffs);
+}
+
+/*
+ * ssdfs_request_unlock_and_remove_old_state() - unlock and remove old state
+ * @req: segment request [out]
+ */
+void ssdfs_request_unlock_and_remove_old_state(struct ssdfs_segment_request *req)
+{
+	unsigned count;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	count = pagevec_count(&req->result.old_state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("old_state: pages count %u\n",
+		  count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < count; i++) {
+		struct page *page = req->result.old_state.pages[i];
+
+		if (!page) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %d is NULL\n", i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		ssdfs_unlock_page(page);
+	}
+
+	ssdfs_req_queue_pagevec_release(&req->result.old_state);
+}
+
+/*
+ * ssdfs_request_switch_update_on_diff() - switch block update on diff page
+ * @fsi: shared file system info object
+ * @diff_page: page with prepared delta
+ * @req: segment request [out]
+ */
+int ssdfs_request_switch_update_on_diff(struct ssdfs_fs_info *fsi,
+					struct page *diff_page,
+					struct ssdfs_segment_request *req)
+{
+	struct page *page;
+	u32 mem_pages_per_block;
+	int page_index;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	mem_pages_per_block = fsi->pagesize / PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(mem_pages_per_block == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_unlock_and_remove_old_state(req);
+
+	page_index = req->result.processed_blks * mem_pages_per_block;
+
+	for (i = 0; i < mem_pages_per_block; i++) {
+		page_index += i;
+
+		if (page_index >= pagevec_count(&req->result.pvec)) {
+			SSDFS_ERR("page_index %d >= pvec_size %u\n",
+				  page_index,
+				  pagevec_count(&req->result.pvec));
+			return -ERANGE;
+		}
+
+		page = req->result.pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		clear_page_new(page);
+		SetPageUptodate(page);
+		ssdfs_clear_dirty_page(page);
+
+		ssdfs_unlock_page(page);
+		end_page_writeback(page);
+
+		if (!(req->private.flags & SSDFS_REQ_DONT_FREE_PAGES))
+			ssdfs_req_queue_forget_page(page);
+
+		req->result.pvec.pages[page_index] = NULL;
+	}
+
+	page_index = req->result.processed_blks * mem_pages_per_block;
+	set_page_new(diff_page);
+	req->result.pvec.pages[page_index] = diff_page;
+	req->result.diffs.pages[0] = NULL;
+
+	if (pagevec_count(&req->result.diffs) > 1) {
+		SSDFS_WARN("diff pagevec contains several pages %u\n",
+			   pagevec_count(&req->result.diffs));
+		ssdfs_req_queue_pagevec_release(&req->result.diffs);
+	} else
+		pagevec_reinit(&req->result.diffs);
+
+	return 0;
+}
+
+/*
+ * ssdfs_request_unlock_and_remove_page() - unlock and remove page
+ * @req: segment request [in|out]
+ * @page_index: page index
+ */
+void ssdfs_request_unlock_and_remove_page(struct ssdfs_segment_request *req,
+					  int page_index)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_index >= pagevec_count(&req->result.pvec)) {
+		SSDFS_ERR("page_index %d >= pagevec_count %u\n",
+			  page_index,
+			  pagevec_count(&req->result.pvec));
+		return;
+	}
+
+	if (!req->result.pvec.pages[page_index]) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %d is NULL\n", page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return;
+	}
+
+	ssdfs_unlock_page(req->result.pvec.pages[page_index]);
+	ssdfs_req_queue_forget_page(req->result.pvec.pages[page_index]);
+	req->result.pvec.pages[page_index] = NULL;
+}
+
+/*
+ * ssdfs_free_flush_request_pages() - unlock and remove flush request's pages
+ * @req: segment request [out]
+ */
+void ssdfs_free_flush_request_pages(struct ssdfs_segment_request *req)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < pagevec_count(&req->result.pvec); i++) {
+		struct page *page = req->result.pvec.pages[i];
+		bool need_free_page = false;
+
+		if (!page) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %d is NULL\n", i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		if (need_add_block(page)) {
+			clear_page_new(page);
+
+			if (req->private.flags & SSDFS_REQ_PREPARE_DIFF)
+				need_free_page = true;
+		}
+
+		if (PageWriteback(page))
+			end_page_writeback(page);
+		else {
+			SSDFS_WARN("page %d is not under writeback: "
+				   "cmd %#x, type %#x\n",
+				   i, req->private.cmd,
+				   req->private.type);
+		}
+
+		if (PageLocked(page))
+			ssdfs_unlock_page(page);
+		else {
+			SSDFS_WARN("page %d is not locked: "
+				   "cmd %#x, type %#x\n",
+				   i, req->private.cmd,
+				   req->private.type);
+		}
+
+		req->result.pvec.pages[i] = NULL;
+
+		if (need_free_page)
+			ssdfs_req_queue_free_page(page);
+		else if (!(req->private.flags & SSDFS_REQ_DONT_FREE_PAGES))
+			ssdfs_req_queue_free_page(page);
+	}
+
+	if (req->private.flags & SSDFS_REQ_DONT_FREE_PAGES) {
+		/*
+		 * Do nothing
+		 */
+	} else
+		pagevec_reinit(&req->result.pvec);
+}
+
+/*
+ * ssdfs_peb_extent_length() - determine extent length in pagevec
+ * @si: segment object
+ * @pvec: page vector
+ */
+u8 ssdfs_peb_extent_length(struct ssdfs_segment_info *si,
+			   struct pagevec *pvec)
+{
+	u32 len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !si->fsi || !pvec);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (si->fsi->pagesize < PAGE_SIZE) {
+		BUG_ON(PAGE_SIZE % si->fsi->pagesize);
+		len = PAGE_SIZE / si->fsi->pagesize;
+		len *= pagevec_count(pvec);
+		BUG_ON(len == 0);
+	} else {
+		len = pagevec_count(pvec) * PAGE_SIZE;
+		BUG_ON(len == 0);
+		BUG_ON(len % si->fsi->pagesize);
+		len = si->fsi->pagesize / len;
+		BUG_ON(len == 0);
+	}
+
+	BUG_ON(len >= U8_MAX);
+	return (u8)len;
+}
diff --git a/fs/ssdfs/request_queue.h b/fs/ssdfs/request_queue.h
new file mode 100644
index 000000000000..7287182a3875
--- /dev/null
+++ b/fs/ssdfs/request_queue.h
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/request_queue.h - request queue declarations.
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
+#ifndef _SSDFS_REQUEST_QUEUE_H
+#define _SSDFS_REQUEST_QUEUE_H
+
+#include <linux/pagevec.h>
+
+/*
+ * struct ssdfs_requests_queue - requests queue descriptor
+ * @lock: requests queue's lock
+ * @list: requests queue's list
+ */
+struct ssdfs_requests_queue {
+	spinlock_t lock;
+	struct list_head list;
+};
+
+/*
+ * Request classes
+ */
+enum {
+	SSDFS_UNKNOWN_REQ_CLASS,		/* 0x00 */
+	SSDFS_PEB_READ_REQ,			/* 0x01 */
+	SSDFS_PEB_PRE_ALLOCATE_DATA_REQ,	/* 0x02 */
+	SSDFS_PEB_CREATE_DATA_REQ,		/* 0x03 */
+	SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ,	/* 0x04 */
+	SSDFS_PEB_CREATE_LNODE_REQ,		/* 0x05 */
+	SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ,	/* 0x06 */
+	SSDFS_PEB_CREATE_HNODE_REQ,		/* 0x07 */
+	SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ,	/* 0x08 */
+	SSDFS_PEB_CREATE_IDXNODE_REQ,		/* 0x09 */
+	SSDFS_PEB_UPDATE_REQ,			/* 0x0A */
+	SSDFS_PEB_PRE_ALLOC_UPDATE_REQ,		/* 0x0B */
+	SSDFS_PEB_DIFF_ON_WRITE_REQ,		/* 0x0C */
+	SSDFS_PEB_COLLECT_GARBAGE_REQ,		/* 0x0D */
+	SSDFS_ZONE_USER_DATA_MIGRATE_REQ,	/* 0x0E */
+	SSDFS_PEB_REQ_CLASS_MAX,		/* 0x0F */
+};
+
+/*
+ * Request commands
+ */
+enum {
+	SSDFS_UNKNOWN_CMD,			/* 0x00 */
+	SSDFS_READ_PAGE,			/* 0x01 */
+	SSDFS_READ_PAGES_READAHEAD,		/* 0x02 */
+	SSDFS_READ_SRC_ALL_LOG_HEADERS,		/* 0x03 */
+	SSDFS_READ_DST_ALL_LOG_HEADERS,		/* 0x04 */
+	SSDFS_READ_BLK_BMAP_SRC_USING_PEB,	/* 0x05 */
+	SSDFS_READ_BLK_BMAP_DST_USING_PEB,	/* 0x06 */
+	SSDFS_READ_BLK_BMAP_SRC_USED_PEB,	/* 0x07 */
+	SSDFS_READ_BLK_BMAP_DST_USED_PEB,	/* 0x08 */
+	SSDFS_READ_BLK2OFF_TABLE_SRC_PEB,	/* 0x09 */
+	SSDFS_READ_BLK2OFF_TABLE_DST_PEB,	/* 0x0A */
+	SSDFS_READ_INIT_SEGBMAP,		/* 0x0B */
+	SSDFS_READ_INIT_MAPTBL,			/* 0x0C */
+	SSDFS_READ_SRC_LAST_LOG_FOOTER,		/* 0x0D */
+	SSDFS_READ_DST_LAST_LOG_FOOTER,		/* 0x0E */
+	SSDFS_READ_CMD_MAX,			/* 0x0F */
+	SSDFS_CREATE_BLOCK,			/* 0x10 */
+	SSDFS_CREATE_EXTENT,			/* 0x11 */
+	SSDFS_MIGRATE_ZONE_USER_BLOCK,		/* 0x12 */
+	SSDFS_MIGRATE_ZONE_USER_EXTENT,		/* 0x13 */
+	SSDFS_CREATE_CMD_MAX,			/* 0x14 */
+	SSDFS_UPDATE_BLOCK,			/* 0x15 */
+	SSDFS_UPDATE_PRE_ALLOC_BLOCK,		/* 0x16 */
+	SSDFS_UPDATE_EXTENT,			/* 0x17 */
+	SSDFS_UPDATE_PRE_ALLOC_EXTENT,		/* 0x18 */
+	SSDFS_COMMIT_LOG_NOW,			/* 0x19 */
+	SSDFS_START_MIGRATION_NOW,		/* 0x1A */
+	SSDFS_EXTENT_WAS_INVALIDATED,		/* 0x1B */
+	SSDFS_UPDATE_CMD_MAX,			/* 0x1C */
+	SSDFS_BTREE_NODE_DIFF,			/* 0x1D */
+	SSDFS_USER_DATA_DIFF,			/* 0x1E */
+	SSDFS_DIFF_ON_WRITE_MAX,		/* 0x1F */
+	SSDFS_COPY_PAGE,			/* 0x20 */
+	SSDFS_COPY_PRE_ALLOC_PAGE,		/* 0x21 */
+	SSDFS_MIGRATE_RANGE,			/* 0x22 */
+	SSDFS_MIGRATE_PRE_ALLOC_PAGE,		/* 0x23 */
+	SSDFS_MIGRATE_FRAGMENT,			/* 0x24 */
+	SSDFS_COLLECT_GARBAGE_CMD_MAX,		/* 0x25 */
+	SSDFS_KNOWN_CMD_MAX,			/* 0x26 */
+};
+
+/*
+ * Request types
+ */
+enum {
+	SSDFS_UNKNOWN_REQ_TYPE,
+	SSDFS_REQ_SYNC,
+	SSDFS_REQ_ASYNC,
+	SSDFS_REQ_ASYNC_NO_FREE,
+	SSDFS_REQ_TYPE_MAX,
+};
+
+/*
+ * Request flags
+ */
+#define SSDFS_REQ_DONT_FREE_PAGES			(1 << 0)
+#define SSDFS_REQ_READ_ONLY_CACHE			(1 << 1)
+#define SSDFS_REQ_PREPARE_DIFF				(1 << 2)
+#define SSDFS_REQ_FLAGS_MASK				0x7
+
+/*
+ * Result states
+ */
+enum {
+	SSDFS_UNKNOWN_REQ_RESULT,
+	SSDFS_REQ_CREATED,
+	SSDFS_REQ_STARTED,
+	SSDFS_REQ_FINISHED,
+	SSDFS_REQ_FAILED,
+	SSDFS_REQ_RESULT_MAX
+};
+
+/*
+ * struct ssdfs_logical_extent - logical extent descriptor
+ * @ino: inode identification number
+ * @logical_offset: logical offset from file's begin in bytes
+ * @data_bytes: valid bytes count in request
+ * @cno: checkpoint
+ * @parent_snapshot: parent snapshot
+ */
+struct ssdfs_logical_extent {
+	u64 ino;
+	u64 logical_offset;
+	u32 data_bytes;
+	u64 cno;
+	u64 parent_snapshot;
+};
+
+/*
+ * struct ssdfs_request_internal_data - private request data
+ * @class: request class
+ * @cmd: request command
+ * @type: request type
+ * @refs_count: reference counter
+ * @flags: request flags
+ * @wait_queue: queue for result waiting
+ */
+struct ssdfs_request_internal_data {
+	int class;
+	int cmd;
+	int type;
+	atomic_t refs_count;
+	u32 flags;
+	wait_queue_head_t wait_queue;
+};
+
+/*
+ * struct ssdfs_request_result - requst result
+ * @pvec: array of memory pages
+ * @old_state: array of memory pages with initial state
+ * @diffs: array of diffs
+ * @processed_blks: count of processed physical pages
+ * @state: result's state
+ * @wait: wait-for-completion of operation
+ * @err: code of error
+ */
+struct ssdfs_request_result {
+	struct pagevec pvec;
+	struct pagevec old_state;
+	struct pagevec diffs;
+	int processed_blks;
+	atomic_t state;
+	struct completion wait;
+	int err;
+};
+
+/*
+ * struct ssdfs_segment_request - segment I/O request
+ * @list: requests queue list
+ * @extent: logical extent descriptor
+ * @place: logical blocks placement in segment
+ * @private: internal data of request
+ * @result: request result description
+ */
+struct ssdfs_segment_request {
+	struct list_head list;
+	struct ssdfs_logical_extent extent;
+	struct ssdfs_volume_extent place;
+	struct ssdfs_request_internal_data private;
+	struct ssdfs_request_result result;
+};
+
+/*
+ * struct ssdfs_peb_phys_offset - PEB's physical offset
+ * @peb_index: PEB's index
+ * @peb_migration_id: identification number of PEB in migration sequence
+ * @peb_page: PEB's page index
+ * @log_area: identification number of log area
+ * @byte_offset: offset in bytes from area's beginning
+ */
+struct ssdfs_peb_phys_offset {
+	u16 peb_index;
+	u8 peb_migration_id;
+	u16 peb_page;
+	u8 log_area;
+	u32 byte_offset;
+};
+
+struct ssdfs_segment_info;
+
+/*
+ * struct ssdfs_seg2req_pair - segment/request pair
+ * @si: pointer on segment object
+ * @req: pointer on request object
+ */
+struct ssdfs_seg2req_pair {
+	struct ssdfs_segment_info *si;
+	struct ssdfs_segment_request *req;
+};
+
+/*
+ * Request's inline functions
+ */
+
+/*
+ * ssdfs_request_prepare_logical_extent() - prepare logical extent
+ * @ino: inode id
+ * @logical_offset: logical offset in bytes from file's beginning
+ * @data_bytes: extent length in bytes
+ * @cno: checkpoint number
+ * @parent_snapshot: parent snapshot number
+ * @req: segment request [out]
+ */
+static inline
+void ssdfs_request_prepare_logical_extent(u64 ino,
+					  u64 logical_offset,
+					  u32 data_bytes,
+					  u64 cno,
+					  u64 parent_snapshot,
+					  struct ssdfs_segment_request *req)
+{
+	req->extent.ino = ino;
+	req->extent.logical_offset = logical_offset;
+	req->extent.data_bytes = data_bytes;
+	req->extent.cno = cno;
+	req->extent.parent_snapshot = parent_snapshot;
+}
+
+/*
+ * ssdfs_request_prepare_internal_data() - prepare request's internal data
+ * @class: request class
+ * @cmd: request command
+ * @type: request type
+ * @req: segment request [out]
+ */
+static inline
+void ssdfs_request_prepare_internal_data(int class, int cmd, int type,
+					 struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+	BUG_ON(class <= SSDFS_UNKNOWN_REQ_CLASS ||
+		class >= SSDFS_PEB_REQ_CLASS_MAX);
+	BUG_ON(cmd <= SSDFS_UNKNOWN_CMD || cmd >= SSDFS_KNOWN_CMD_MAX);
+	BUG_ON(type <= SSDFS_UNKNOWN_REQ_TYPE ||
+		type >= SSDFS_REQ_TYPE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	req->private.class = class;
+	req->private.cmd = cmd;
+	req->private.type = type;
+}
+
+/*
+ * ssdfs_request_define_segment() - define segment number
+ * @seg_id: segment number
+ * @req: segment request [out]
+ */
+static inline
+void ssdfs_request_define_segment(u64 seg_id,
+				  struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+	BUG_ON(seg_id == U64_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	req->place.start.seg_id = seg_id;
+}
+
+/*
+ * ssdfs_request_define_volume_extent() - define logical volume extent
+ * @start: starting logical block number
+ * @len: count of logical blocks in the extent
+ * @req: segment request [out]
+ */
+static inline
+void ssdfs_request_define_volume_extent(u16 start, u16 len,
+					struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+	BUG_ON(start == U16_MAX);
+	BUG_ON(len == U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	req->place.start.blk_index = start;
+	req->place.len = len;
+}
+
+/*
+ * has_request_been_executed() - check that reqeust has been executed
+ * @req: segment request
+ */
+static inline
+bool has_request_been_executed(struct ssdfs_segment_request *req)
+{
+	bool has_been_executed = false;
+
+	switch (atomic_read(&req->result.state)) {
+	case SSDFS_REQ_CREATED:
+	case SSDFS_REQ_STARTED:
+		has_been_executed = false;
+		break;
+
+	case SSDFS_REQ_FINISHED:
+	case SSDFS_REQ_FAILED:
+		has_been_executed = true;
+		break;
+
+	default:
+		SSDFS_ERR("invalid result's state %#x\n",
+			  atomic_read(&req->result.state));
+		has_been_executed = true;
+	}
+
+	return has_been_executed;
+}
+
+/*
+ * Request queue's API
+ */
+void ssdfs_requests_queue_init(struct ssdfs_requests_queue *rq);
+bool is_ssdfs_requests_queue_empty(struct ssdfs_requests_queue *rq);
+void ssdfs_requests_queue_add_tail(struct ssdfs_requests_queue *rq,
+				   struct ssdfs_segment_request *req);
+void ssdfs_requests_queue_add_tail_inc(struct ssdfs_fs_info *fsi,
+					struct ssdfs_requests_queue *rq,
+					struct ssdfs_segment_request *req);
+void ssdfs_requests_queue_add_head(struct ssdfs_requests_queue *rq,
+				   struct ssdfs_segment_request *req);
+void ssdfs_requests_queue_add_head_inc(struct ssdfs_fs_info *fsi,
+					struct ssdfs_requests_queue *rq,
+					struct ssdfs_segment_request *req);
+int ssdfs_requests_queue_remove_first(struct ssdfs_requests_queue *rq,
+				      struct ssdfs_segment_request **req);
+void ssdfs_requests_queue_remove_all(struct ssdfs_requests_queue *rq,
+				     int err);
+
+/*
+ * Request's API
+ */
+void ssdfs_zero_seg_req_obj_cache_ptr(void);
+int ssdfs_init_seg_req_obj_cache(void);
+void ssdfs_shrink_seg_req_obj_cache(void);
+void ssdfs_destroy_seg_req_obj_cache(void);
+
+struct ssdfs_segment_request *ssdfs_request_alloc(void);
+void ssdfs_request_free(struct ssdfs_segment_request *req);
+void ssdfs_request_init(struct ssdfs_segment_request *req);
+void ssdfs_get_request(struct ssdfs_segment_request *req);
+void ssdfs_put_request(struct ssdfs_segment_request *req);
+int ssdfs_request_add_page(struct page *page,
+			   struct ssdfs_segment_request *req);
+int ssdfs_request_add_diff_page(struct page *page,
+				struct ssdfs_segment_request *req);
+struct page *
+ssdfs_request_allocate_and_add_page(struct ssdfs_segment_request *req);
+struct page *
+ssdfs_request_allocate_and_add_diff_page(struct ssdfs_segment_request *req);
+struct page *
+ssdfs_request_allocate_and_add_old_state_page(struct ssdfs_segment_request *req);
+struct page *
+ssdfs_request_allocate_locked_page(struct ssdfs_segment_request *req,
+				   int page_index);
+struct page *
+ssdfs_request_allocate_locked_diff_page(struct ssdfs_segment_request *req,
+					int page_index);
+int ssdfs_request_add_allocated_page_locked(struct ssdfs_segment_request *req);
+int ssdfs_request_add_allocated_diff_locked(struct ssdfs_segment_request *req);
+int ssdfs_request_add_old_state_page_locked(struct ssdfs_segment_request *req);
+void ssdfs_request_unlock_and_remove_page(struct ssdfs_segment_request *req,
+					  int page_index);
+void ssdfs_request_unlock_and_remove_pages(struct ssdfs_segment_request *req);
+void ssdfs_request_unlock_and_remove_update(struct ssdfs_segment_request *req);
+void ssdfs_request_unlock_and_remove_diffs(struct ssdfs_segment_request *req);
+void ssdfs_request_unlock_and_remove_old_state(struct ssdfs_segment_request *req);
+int ssdfs_request_switch_update_on_diff(struct ssdfs_fs_info *fsi,
+					struct page *diff_page,
+					struct ssdfs_segment_request *req);
+void ssdfs_free_flush_request_pages(struct ssdfs_segment_request *req);
+u8 ssdfs_peb_extent_length(struct ssdfs_segment_info *si,
+			   struct pagevec *pvec);
+
+#endif /* _SSDFS_REQUEST_QUEUE_H */
-- 
2.34.1


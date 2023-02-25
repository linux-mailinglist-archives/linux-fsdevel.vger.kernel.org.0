Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5326A263D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBYBRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBYBQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:29 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38E14997
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:22 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bl7so859011oib.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhRCif+96swTaLHU6Gyio1NAw0Od79etdDjB0vZ0cBQ=;
        b=R6VbJTP0w3HH8ITuY8a9F3XQAXE3tLlJYo+KyRrV5bNWmD2kWRjI7F1neyz56OAK5Z
         wErX+jBvBC5plbzirKrbjtAJd1ZcM8DbZLjVOGpRdz73z+gF6aayoO0SjhDjO4Y8klWh
         kH9Mjn27stk979kDdO/m1ggiRivstEi+D+UwucO/PBN1nrc7E+IPiggB97vU1KCZJ7kx
         /gzfmb+WZgdlwBgdQdVOl6yZloCWmBXtXEJN/pIICsnPSMPdLUzMM8Yit6EZ+yhnzLmv
         X+CWWcuzYplD6UpWG7qgxUl4yuQ4tynRsslPGckuNTMGH4kYuVJ1cKOedVCl8rBkFSyU
         jqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhRCif+96swTaLHU6Gyio1NAw0Od79etdDjB0vZ0cBQ=;
        b=bXL4wWOGbdzXDWR64AyL8HgBpV2ONrtNWwq15MBOZq9Z1MTEz0yUKO4xFaSD1ZzdM9
         Cjp70sKfrXNvihbADpEJvlCOnoCPIViO8RmUYIOTLrvPHabGh5jdjr9Ljg8eo/oYNZ7H
         e8N3Zz9+lJqk3zXnBGQZ+Lfl/YlTrjy4Ib42IPZnxbvet/e3xosHMwsg8O7lCC+ENHfh
         rE2yooiIh14kx7EYVMJs4oltSX4xV2JfgrsuvvlRchf4ZSMDmJNQV4f+k7bLrSmqnPs1
         bxh3GVyizV8wAv/SToou8EluEbCY9KVCNETKZDMmCqFzpZDcYwUSHDVkcdMT/5BUNqmW
         booQ==
X-Gm-Message-State: AO0yUKUbzwkiGYSBCFPbXFd2z/XNWRltQEPf1yn4TankrkaV4jW83Utj
        UNsCGvLpsS23TP84IhqX8t4WJZml8rcRXF8T
X-Google-Smtp-Source: AK7set9dunxArKT4UgDXeU/xVpGSWeMX1bPUvGw6r5ER2XxZYvFzQE6wJvH4Bi8DrEOc8XoYUlXAYw==
X-Received: by 2002:a05:6808:6393:b0:37f:acd5:20ff with SMTP id ec19-20020a056808639300b0037facd520ffmr5087382oib.43.1677287781318;
        Fri, 24 Feb 2023 17:16:21 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:20 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 22/76] ssdfs: create/destroy PEB container
Date:   Fri, 24 Feb 2023 17:08:33 -0800
Message-Id: <20230225010927.813929-23-slava@dubeyko.com>
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

"Physical" Erase Block object can be in one of the possible
state (clean, using, used, pre-dirty, dirty). It means that
PEB container creation logic needs to define the state of
particular erase block and detect that it's under migration
or not. As a result, creation logic prepare proper sequence
of initialization requests, add these request into request
queue, and start threads that executes PEB container
initialization.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_container.c | 2669 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 2669 insertions(+)
 create mode 100644 fs/ssdfs/peb_container.c

diff --git a/fs/ssdfs/peb_container.c b/fs/ssdfs/peb_container.c
new file mode 100644
index 000000000000..668ded673719
--- /dev/null
+++ b/fs/ssdfs/peb_container.c
@@ -0,0 +1,2669 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+ /*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_container.c - PEB container implementation.
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
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb_container.h"
+#include "segment_bitmap.h"
+#include "segment.h"
+#include "current_segment.h"
+#include "peb_mapping_table.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "invalidated_extents_tree.h"
+
+enum {
+	SSDFS_SRC_PEB,
+	SSDFS_DST_PEB,
+	SSDFS_SRC_AND_DST_PEB
+};
+
+static
+struct ssdfs_thread_descriptor thread_desc[SSDFS_PEB_THREAD_TYPE_MAX] = {
+	{.threadfn = ssdfs_peb_read_thread_func,
+	 .fmt = "ssdfs-r%llu-%u",},
+	{.threadfn = ssdfs_peb_flush_thread_func,
+	 .fmt = "ssdfs-f%llu-%u",},
+	{.threadfn = ssdfs_peb_gc_thread_func,
+	 .fmt = "ssdfs-gc%llu-%u",},
+};
+
+/*
+ * ssdfs_peb_mark_request_block_uptodate() - mark block uptodate
+ * @pebc: pointer on PEB container
+ * @req: request
+ * @blk_index: index of block in request's sequence
+ *
+ * This function mark memory pages of request as uptodate and
+ * not dirty. Page should be locked.
+ */
+void ssdfs_peb_mark_request_block_uptodate(struct ssdfs_peb_container *pebc,
+					   struct ssdfs_segment_request *req,
+					   int blk_index)
+{
+	u32 pagesize;
+	u32 mem_pages;
+	pgoff_t page_index;
+	u32 page_off;
+	u32 i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!req);
+
+	SSDFS_DBG("blk_index %d, processed_blocks %d\n",
+		  blk_index, req->result.processed_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(&req->result.pvec) == 0) {
+		SSDFS_DBG("pagevec is empty\n");
+		return;
+	}
+
+	BUG_ON(blk_index >= req->result.processed_blks);
+
+	pagesize = pebc->parent_si->fsi->pagesize;
+	mem_pages = (pagesize + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	page_index = ssdfs_phys_page_to_mem_page(pebc->parent_si->fsi,
+						 blk_index);
+	page_off = (page_index * pagesize) % PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(mem_pages > 1 && page_off != 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < mem_pages; i++) {
+		if ((page_off + pagesize) != PAGE_SIZE)
+			return;
+		else {
+			struct page *page;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(i >= pagevec_count(&req->result.pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			page = req->result.pvec.pages[i];
+
+			if (!PageLocked(page)) {
+				SSDFS_WARN("failed to mark block uptodate: "
+					   "page %d is not locked\n",
+					   i);
+			} else {
+				if (!PageError(page)) {
+					ClearPageDirty(page);
+					SetPageUptodate(page);
+				}
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+			SSDFS_DBG("page_index %ld, flags %#lx\n",
+				  page->index, page->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	}
+}
+
+/*
+ * ssdfs_peb_start_thread() - start PEB's thread
+ * @pebc: pointer on PEB container
+ * @type: thread type
+ *
+ * This function tries to start PEB's thread of @type.
+ *
+ * RETURN:
+ * [success] - PEB's thread has been started.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+static
+int ssdfs_peb_start_thread(struct ssdfs_peb_container *pebc, int type)
+{
+	struct ssdfs_segment_info *si;
+	ssdfs_threadfn threadfn;
+	const char *fmt;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+
+	if (type >= SSDFS_PEB_THREAD_TYPE_MAX) {
+		SSDFS_ERR("invalid thread type %d\n", type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("seg_id %llu, peb_index %u, thread_type %d\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index,
+		  type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+	threadfn = thread_desc[type].threadfn;
+	fmt = thread_desc[type].fmt;
+
+	pebc->thread[type].task = kthread_create(threadfn, pebc, fmt,
+						 pebc->parent_si->seg_id,
+						 pebc->peb_index);
+	if (IS_ERR_OR_NULL(pebc->thread[type].task)) {
+		err = PTR_ERR(pebc->thread[type].task);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			if (err == 0)
+				err = -ERANGE;
+			SSDFS_ERR("fail to start thread: "
+				  "seg_id %llu, peb_index %u, thread_type %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, type);
+		}
+
+		return err;
+	}
+
+	init_waitqueue_entry(&pebc->thread[type].wait,
+				pebc->thread[type].task);
+	add_wait_queue(&si->wait_queue[type],
+			&pebc->thread[type].wait);
+	init_completion(&pebc->thread[type].full_stop);
+
+	wake_up_process(pebc->thread[type].task);
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_stop_thread() - stop PEB's thread
+ * @pebc: pointer on PEB container
+ * @type: thread type
+ *
+ * This function tries to stop PEB's thread of @type.
+ *
+ * RETURN:
+ * [success] - PEB's thread has been stopped.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+static
+int ssdfs_peb_stop_thread(struct ssdfs_peb_container *pebc, int type)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+
+	if (type >= SSDFS_PEB_THREAD_TYPE_MAX) {
+		SSDFS_ERR("invalid thread type %d\n", type);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("type %#x, task %p\n",
+		  type, pebc->thread[type].task);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!pebc->thread[type].task)
+		return 0;
+
+	err = kthread_stop(pebc->thread[type].task);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 * The wake_up_process() was never called.
+		 */
+		return 0;
+	} else if (unlikely(err)) {
+		SSDFS_WARN("thread function had some issue: err %d\n",
+			    err);
+		return err;
+	}
+
+	finish_wait(&pebc->parent_si->wait_queue[type],
+			&pebc->thread[type].wait);
+
+	pebc->thread[type].task = NULL;
+
+	err = SSDFS_WAIT_COMPLETION(&pebc->thread[type].full_stop);
+	if (unlikely(err)) {
+		SSDFS_ERR("stop thread fails: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_map_leb2peb() - map LEB ID into PEB ID
+ * @fsi: pointer on shared file system object
+ * @leb_id: LEB ID number
+ * @peb_type: PEB type
+ * @pebr: pointer on PEBs association container [out]
+ *
+ * This method tries to map LEB ID into PEB ID.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - can't map LEB to PEB.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_map_leb2peb(struct ssdfs_fs_info *fsi,
+			  u64 leb_id, int peb_type,
+			  struct ssdfs_maptbl_peb_relation *pebr)
+{
+	struct completion *end;
+#ifdef CONFIG_SSDFS_DEBUG
+	struct ssdfs_maptbl_peb_descriptor *ptr;
+#endif /* CONFIG_SSDFS_DEBUG */
+	u64 peb_id;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->maptbl || !pebr);
+	BUG_ON(leb_id == U64_MAX);
+
+	SSDFS_DBG("leb_id %llu, peb_type %#x\n",
+		  leb_id, peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_maptbl_map_leb2peb(fsi, leb_id, peb_type,
+					pebr, &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_maptbl_map_leb2peb(fsi, leb_id, peb_type,
+						pebr, &end);
+	}
+
+	if (err == -EACCES || err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("can't map LEB to PEB: "
+			  "leb_id %llu, peb_type %#x, err %d\n",
+			  leb_id, peb_type, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	} else if (err == -EEXIST) {
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("LEB is mapped already: "
+			  "leb_id %llu, peb_type %#x\n",
+			  leb_id, peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_maptbl_convert_leb2peb(fsi, leb_id,
+						   peb_type,
+						   pebr, &end);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to convert LEB to PEB: "
+				  "leb_id %llu, peb_type %#x, err %d\n",
+				  leb_id, peb_type, err);
+			return err;
+		}
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to map LEB to PEB: "
+			  "leb_id %llu, peb_type %#x, err %d\n",
+			  leb_id, peb_type, err);
+		return err;
+	}
+
+	peb_id = pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id;
+
+	if (peb_id == U64_MAX) {
+		SSDFS_ERR("invalid peb_id\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("LEB %llu, PEB %llu\n", leb_id, peb_id);
+
+	ptr = &pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX];
+	SSDFS_DBG("MAIN: peb_id %llu, shared_peb_index %u, "
+		  "erase_cycles %u, type %#x, state %#x, "
+		  "flags %#x\n",
+		  ptr->peb_id, ptr->shared_peb_index,
+		  ptr->erase_cycles, ptr->type,
+		  ptr->state, ptr->flags);
+	ptr = &pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX];
+	SSDFS_DBG("RELATION: peb_id %llu, shared_peb_index %u, "
+		  "erase_cycles %u, type %#x, state %#x, "
+		  "flags %#x\n",
+		  ptr->peb_id, ptr->shared_peb_index,
+		  ptr->erase_cycles, ptr->type,
+		  ptr->state, ptr->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_convert_leb2peb() - convert LEB ID into PEB ID
+ * @fsi: pointer on shared file system object
+ * @leb_id: LEB ID number
+ * @peb_type: PEB type
+ * @pebr: pointer on PEBs association container [out]
+ *
+ * This method tries to convert LEB ID into PEB ID.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - can't convert LEB to PEB.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_convert_leb2peb(struct ssdfs_fs_info *fsi,
+			      u64 leb_id, int peb_type,
+			      struct ssdfs_maptbl_peb_relation *pebr)
+{
+	struct completion *end;
+#ifdef CONFIG_SSDFS_DEBUG
+	struct ssdfs_maptbl_peb_descriptor *ptr;
+#endif /* CONFIG_SSDFS_DEBUG */
+	u64 peb_id;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->maptbl || !pebr);
+	BUG_ON(leb_id == U64_MAX);
+
+	SSDFS_DBG("leb_id %llu, peb_type %#x\n",
+		  leb_id, peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_maptbl_convert_leb2peb(fsi, leb_id,
+					   peb_type,
+					   pebr, &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_maptbl_convert_leb2peb(fsi, leb_id, peb_type,
+						   pebr, &end);
+	}
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("LEB doesn't mapped: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to convert LEB to PEB: "
+			  "leb_id %llu, peb_type %#x, err %d\n",
+			  leb_id, peb_type, err);
+		return err;
+	}
+
+	peb_id = pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id;
+	if (peb_id == U64_MAX) {
+		SSDFS_ERR("invalid peb_id\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("LEB %llu, PEB %llu\n", leb_id, peb_id);
+
+	ptr = &pebr->pebs[SSDFS_MAPTBL_MAIN_INDEX];
+	SSDFS_DBG("MAIN: peb_id %llu, shared_peb_index %u, "
+		  "erase_cycles %u, type %#x, state %#x, "
+		  "flags %#x\n",
+		  ptr->peb_id, ptr->shared_peb_index,
+		  ptr->erase_cycles, ptr->type,
+		  ptr->state, ptr->flags);
+	ptr = &pebr->pebs[SSDFS_MAPTBL_RELATION_INDEX];
+	SSDFS_DBG("RELATION: peb_id %llu, shared_peb_index %u, "
+		  "erase_cycles %u, type %#x, state %#x, "
+		  "flags %#x\n",
+		  ptr->peb_id, ptr->shared_peb_index,
+		  ptr->erase_cycles, ptr->type,
+		  ptr->state, ptr->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_create_clean_peb_container() - create "clean" PEB container
+ * @pebc: pointer on PEB container
+ * @selected_peb: source or destination PEB?
+ *
+ * This function tries to initialize PEB container for "clean"
+ * state of the PEB.
+ *
+ * RETURN:
+ * [success] - PEB container has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+static
+int ssdfs_create_clean_peb_container(struct ssdfs_peb_container *pebc,
+				     int selected_peb)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_blk2off_table *blk2off_table;
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+
+	SSDFS_DBG("peb_index %u, peb_type %#x, "
+		  "selected_peb %d\n",
+		  pebc->peb_index, pebc->peb_type,
+		  selected_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+	blk2off_table = si->blk2off_table;
+
+	atomic_set(&blk2off_table->peb[pebc->peb_index].state,
+		   SSDFS_BLK2OFF_TABLE_COMPLETE_INIT);
+
+	peb_blkbmap = &si->blk_bmap.peb[pebc->peb_index];
+	ssdfs_set_block_bmap_initialized(peb_blkbmap->src);
+	atomic_set(&peb_blkbmap->state, SSDFS_PEB_BLK_BMAP_INITIALIZED);
+
+	if (selected_peb == SSDFS_SRC_PEB) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!pebc->src_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		ssdfs_set_peb_migration_id(pebc->src_peb,
+					   SSDFS_PEB_MIGRATION_ID_START);
+		atomic_set(&pebc->src_peb->state,
+			   SSDFS_PEB_OBJECT_INITIALIZED);
+		complete_all(&pebc->src_peb->init_end);
+	} else if (selected_peb == SSDFS_DST_PEB) {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!pebc->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		ssdfs_set_peb_migration_id(pebc->dst_peb,
+					   SSDFS_PEB_MIGRATION_ID_START);
+		atomic_set(&pebc->dst_peb->state,
+			   SSDFS_PEB_OBJECT_INITIALIZED);
+		complete_all(&pebc->dst_peb->init_end);
+	} else
+		BUG();
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_READ_THREAD);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		goto fail_create_clean_peb_obj;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to start read thread: "
+			  "peb_index %u, err %d\n",
+			  pebc->peb_index, err);
+		goto fail_create_clean_peb_obj;
+	}
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_FLUSH_THREAD);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		goto stop_read_thread;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to start flush thread: "
+			  "peb_index %u, err %d\n",
+			  pebc->peb_index, err);
+		goto stop_read_thread;
+	}
+
+	return 0;
+
+stop_read_thread:
+	ssdfs_peb_stop_thread(pebc, SSDFS_PEB_READ_THREAD);
+
+fail_create_clean_peb_obj:
+	return err;
+}
+
+/*
+ * ssdfs_create_using_peb_container() - create "using" PEB container
+ * @pebc: pointer on PEB container
+ * @selected_peb: source or destination PEB?
+ *
+ * This function tries to initialize PEB conatiner for "using"
+ * state of the PEB.
+ *
+ * RETURN:
+ * [success] - PEB object has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_create_using_peb_container(struct ssdfs_peb_container *pebc,
+				     int selected_peb)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_segment_request *req1, *req2, *req3, *req4, *req5;
+	int command;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+	BUG_ON(selected_peb < SSDFS_SRC_PEB ||
+		selected_peb > SSDFS_SRC_AND_DST_PEB);
+
+	SSDFS_DBG("seg %llu, peb_index %u, peb_type %#x, "
+		  "selected_peb %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  selected_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (selected_peb == SSDFS_SRC_PEB)
+		command = SSDFS_READ_SRC_ALL_LOG_HEADERS;
+	else if (selected_peb == SSDFS_DST_PEB)
+		command = SSDFS_READ_DST_ALL_LOG_HEADERS;
+	else if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_DST_ALL_LOG_HEADERS;
+	else
+		BUG();
+
+	req1 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req1)) {
+		err = (req1 == NULL ? -ENOMEM : PTR_ERR(req1));
+		req1 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		goto fail_create_using_peb_obj;
+	}
+
+	ssdfs_request_init(req1);
+	/* read thread puts request */
+	ssdfs_get_request(req1);
+	/* it needs to be sure that request will be not freed */
+	ssdfs_get_request(req1);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req1);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req1);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req1);
+
+	if (selected_peb == SSDFS_SRC_PEB)
+		command = SSDFS_READ_BLK_BMAP_SRC_USING_PEB;
+	else if (selected_peb == SSDFS_DST_PEB)
+		command = SSDFS_READ_BLK_BMAP_DST_USING_PEB;
+	else if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_BLK_BMAP_DST_USING_PEB;
+	else
+		BUG();
+
+	req2 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req2)) {
+		err = (req2 == NULL ? -ENOMEM : PTR_ERR(req2));
+		req2 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_using_peb_obj;
+	}
+
+	ssdfs_request_init(req2);
+	ssdfs_get_request(req2);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req2);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req2);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req2);
+
+	if (selected_peb == SSDFS_SRC_AND_DST_PEB) {
+		command = SSDFS_READ_SRC_LAST_LOG_FOOTER;
+
+		req3 = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req3)) {
+			err = (req3 == NULL ? -ENOMEM : PTR_ERR(req3));
+			req1 = NULL;
+			SSDFS_ERR("fail to allocate segment request: err %d\n",
+				  err);
+			ssdfs_requests_queue_remove_all(&pebc->read_rq,
+							-ERANGE);
+			goto fail_create_using_peb_obj;
+		}
+
+		ssdfs_request_init(req3);
+		ssdfs_get_request(req3);
+		ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+						    command,
+						    SSDFS_REQ_ASYNC,
+						    req3);
+		ssdfs_request_define_segment(pebc->parent_si->seg_id, req3);
+		ssdfs_peb_read_request_cno(pebc);
+		ssdfs_requests_queue_add_tail(&pebc->read_rq, req3);
+
+		command = SSDFS_READ_SRC_ALL_LOG_HEADERS;
+
+		req4 = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req4)) {
+			err = (req4 == NULL ? -ENOMEM : PTR_ERR(req4));
+			req4 = NULL;
+			SSDFS_ERR("fail to allocate segment request: err %d\n",
+				  err);
+			ssdfs_requests_queue_remove_all(&pebc->read_rq,
+							-ERANGE);
+			goto fail_create_using_peb_obj;
+		}
+
+		ssdfs_request_init(req4);
+		ssdfs_get_request(req4);
+		ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+						    command,
+						    SSDFS_REQ_ASYNC,
+						    req4);
+		ssdfs_request_define_segment(pebc->parent_si->seg_id, req4);
+		ssdfs_peb_read_request_cno(pebc);
+		ssdfs_requests_queue_add_tail(&pebc->read_rq, req4);
+	}
+
+	if (selected_peb == SSDFS_SRC_PEB)
+		command = SSDFS_READ_BLK2OFF_TABLE_SRC_PEB;
+	else if (selected_peb == SSDFS_DST_PEB)
+		command = SSDFS_READ_BLK2OFF_TABLE_DST_PEB;
+	else if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_BLK2OFF_TABLE_DST_PEB;
+	else
+		BUG();
+
+	req5 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req5)) {
+		err = (req5 == NULL ? -ENOMEM : PTR_ERR(req5));
+		req5 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_using_peb_obj;
+	}
+
+	ssdfs_request_init(req5);
+	ssdfs_get_request(req5);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req5);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req5);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req5);
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_READ_THREAD);
+	if (unlikely(err)) {
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			SSDFS_ERR("fail to start read thread: "
+				  "peb_index %u, err %d\n",
+				  pebc->peb_index, err);
+		}
+
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_using_peb_obj;
+	}
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_FLUSH_THREAD);
+	if (unlikely(err)) {
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			SSDFS_ERR("fail to start flush thread: "
+				  "peb_index %u, err %d\n",
+				  pebc->peb_index, err);
+		}
+
+		goto stop_read_thread;
+	}
+
+	peb_blkbmap = &pebc->parent_si->blk_bmap.peb[pebc->peb_index];
+
+	if (!ssdfs_peb_blk_bmap_initialized(peb_blkbmap)) {
+		err = SSDFS_WAIT_COMPLETION(&req1->result.wait);
+		if (unlikely(err)) {
+			SSDFS_ERR("read thread fails: err %d\n",
+				  err);
+			goto stop_flush_thread;
+		}
+
+		/*
+		 * Block bitmap has been locked for initialization.
+		 * Now it isn't initialized yet. It should check
+		 * block bitmap initialization state during first
+		 * request about free pages count.
+		 */
+	}
+
+	ssdfs_put_request(req1);
+
+	/*
+	 * Current log start_page and data_free_pages count was defined
+	 * in the read thread during searching last actual state of block
+	 * bitmap.
+	 */
+
+	/*
+	 * Wake up read request if it waits zeroing
+	 * of reference counter.
+	 */
+	wake_up_all(&pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD]);
+
+	return 0;
+
+stop_flush_thread:
+	ssdfs_peb_stop_thread(pebc, SSDFS_PEB_FLUSH_THREAD);
+
+stop_read_thread:
+	ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+	wake_up_all(&pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD]);
+	ssdfs_peb_stop_thread(pebc, SSDFS_PEB_READ_THREAD);
+
+fail_create_using_peb_obj:
+	return err;
+}
+
+/*
+ * ssdfs_create_used_peb_container() - create "used" PEB container
+ * @pebi: pointer on PEB container
+ * @selected_peb: source or destination PEB?
+ *
+ * This function tries to initialize PEB container for "used"
+ * state of the PEB.
+ *
+ * RETURN:
+ * [success] - PEB container has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_create_used_peb_container(struct ssdfs_peb_container *pebc,
+				    int selected_peb)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_segment_request *req1, *req2, *req3;
+	int command;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+	BUG_ON(selected_peb < SSDFS_SRC_PEB || selected_peb > SSDFS_DST_PEB);
+
+	SSDFS_DBG("seg %llu, peb_index %u, peb_type %#x, "
+		  "selected_peb %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  selected_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (selected_peb == SSDFS_SRC_PEB)
+		command = SSDFS_READ_SRC_ALL_LOG_HEADERS;
+	else if (selected_peb == SSDFS_DST_PEB)
+		command = SSDFS_READ_DST_ALL_LOG_HEADERS;
+	else
+		BUG();
+
+	req1 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req1)) {
+		err = (req1 == NULL ? -ENOMEM : PTR_ERR(req1));
+		req1 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		goto fail_create_used_peb_obj;
+	}
+
+	ssdfs_request_init(req1);
+	/* read thread puts request */
+	ssdfs_get_request(req1);
+	/* it needs to be sure that request will be not freed */
+	ssdfs_get_request(req1);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req1);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req1);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req1);
+
+	if (selected_peb == SSDFS_SRC_PEB)
+		command = SSDFS_READ_BLK_BMAP_SRC_USED_PEB;
+	else if (selected_peb == SSDFS_DST_PEB)
+		command = SSDFS_READ_BLK_BMAP_DST_USED_PEB;
+	else
+		BUG();
+
+	req2 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req2)) {
+		err = (req2 == NULL ? -ENOMEM : PTR_ERR(req2));
+		req2 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_used_peb_obj;
+	}
+
+	ssdfs_request_init(req2);
+	ssdfs_get_request(req2);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req2);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req2);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req2);
+
+	if (selected_peb == SSDFS_SRC_PEB)
+		command = SSDFS_READ_BLK2OFF_TABLE_SRC_PEB;
+	else if (selected_peb == SSDFS_DST_PEB)
+		command = SSDFS_READ_BLK2OFF_TABLE_DST_PEB;
+	else
+		BUG();
+
+	req3 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req3)) {
+		err = (req3 == NULL ? -ENOMEM : PTR_ERR(req3));
+		req3 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_used_peb_obj;
+	}
+
+	ssdfs_request_init(req3);
+	ssdfs_get_request(req3);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req3);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req3);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req3);
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_READ_THREAD);
+	if (unlikely(err)) {
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			SSDFS_ERR("fail to start read thread: "
+				  "peb_index %u, err %d\n",
+				  pebc->peb_index, err);
+		}
+
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_used_peb_obj;
+	}
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_FLUSH_THREAD);
+	if (unlikely(err)) {
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			SSDFS_ERR("fail to start flush thread: "
+				  "peb_index %u, err %d\n",
+				  pebc->peb_index, err);
+		}
+
+		goto stop_read_thread;
+	}
+
+	peb_blkbmap = &pebc->parent_si->blk_bmap.peb[pebc->peb_index];
+
+	if (!ssdfs_peb_blk_bmap_initialized(peb_blkbmap)) {
+		err = SSDFS_WAIT_COMPLETION(&req1->result.wait);
+		if (unlikely(err)) {
+			SSDFS_ERR("read thread fails: err %d\n",
+				  err);
+			goto stop_flush_thread;
+		}
+
+		/*
+		 * Block bitmap has been locked for initialization.
+		 * Now it isn't initialized yet. It should check
+		 * block bitmap initialization state during first
+		 * request about free pages count.
+		 */
+	}
+
+	ssdfs_put_request(req1);
+
+	/*
+	 * Current log start_page and data_free_pages count was defined
+	 * in the read thread during searching last actual state of block
+	 * bitmap.
+	 */
+
+	/*
+	 * Wake up read request if it waits zeroing
+	 * of reference counter.
+	 */
+	wake_up_all(&pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD]);
+
+	return 0;
+
+stop_flush_thread:
+	ssdfs_peb_stop_thread(pebc, SSDFS_PEB_FLUSH_THREAD);
+
+stop_read_thread:
+	ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+	wake_up_all(&pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD]);
+	ssdfs_peb_stop_thread(pebc, SSDFS_PEB_READ_THREAD);
+
+fail_create_used_peb_obj:
+	return err;
+}
+
+/*
+ * ssdfs_create_pre_dirty_peb_container() - create "pre-dirty" PEB container
+ * @pebi: pointer on PEB container
+ * @selected_peb: source or destination PEB?
+ *
+ * This function tries to initialize PEB container for "pre-dirty"
+ * state of the PEB.
+ *
+ * RETURN:
+ * [success] - PEB container has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_create_pre_dirty_peb_container(struct ssdfs_peb_container *pebc,
+					 int selected_peb)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+	BUG_ON(selected_peb < SSDFS_SRC_PEB || selected_peb > SSDFS_DST_PEB);
+
+	SSDFS_DBG("seg %llu, peb_index %u, peb_type %#x, "
+		  "selected_peb %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  selected_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ssdfs_create_used_peb_container(pebc, selected_peb);
+}
+
+/*
+ * ssdfs_create_dirty_peb_container() - create "dirty" PEB container
+ * @pebi: pointer on PEB container
+ * @selected_peb: source or destination PEB?
+ *
+ * This function tries to initialize PEB container for "dirty"
+ * state of the PEB.
+ *
+ * RETURN:
+ * [success] - PEB container has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+static
+int ssdfs_create_dirty_peb_container(struct ssdfs_peb_container *pebc,
+				     int selected_peb)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_blk2off_table *blk2off_table;
+	struct ssdfs_segment_request *req;
+	int command;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+	BUG_ON(selected_peb < SSDFS_SRC_PEB || selected_peb > SSDFS_DST_PEB);
+
+	SSDFS_DBG("seg %llu, peb_index %u, peb_type %#x, "
+		  "selected_peb %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  selected_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = pebc->parent_si;
+	blk2off_table = si->blk2off_table;
+
+	command = SSDFS_READ_SRC_LAST_LOG_FOOTER;
+
+	req = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req)) {
+		err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+		req = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		goto fail_create_dirty_peb_obj;
+	}
+
+	ssdfs_request_init(req);
+	/* read thread puts request */
+	ssdfs_get_request(req);
+	/* it needs to be sure that request will be not freed */
+	ssdfs_get_request(req);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req);
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_READ_THREAD);
+	if (unlikely(err)) {
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			SSDFS_ERR("fail to start read thread: "
+				  "peb_index %u, err %d\n",
+				  pebc->peb_index, err);
+		}
+
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_dirty_peb_obj;
+	}
+
+	err = SSDFS_WAIT_COMPLETION(&req->result.wait);
+	if (unlikely(err)) {
+		SSDFS_ERR("read thread fails: err %d\n",
+			  err);
+		goto stop_read_thread;
+	}
+
+	ssdfs_put_request(req);
+
+	/*
+	 * Wake up read request if it waits zeroing
+	 * of reference counter.
+	 */
+	wake_up_all(&pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD]);
+
+	atomic_set(&blk2off_table->peb[pebc->peb_index].state,
+		   SSDFS_BLK2OFF_TABLE_COMPLETE_INIT);
+
+	return 0;
+
+stop_read_thread:
+	ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+	wake_up_all(&pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD]);
+	ssdfs_peb_stop_thread(pebc, SSDFS_PEB_READ_THREAD);
+
+fail_create_dirty_peb_obj:
+	return err;
+}
+
+/*
+ * ssdfs_create_dirty_using_container() - create "dirty" + "using" PEB container
+ * @pebc: pointer on PEB container
+ * @selected_peb: source or destination PEB?
+ *
+ * This function tries to initialize PEB conatiner for "dirty" + "using"
+ * state of the PEBs.
+ *
+ * RETURN:
+ * [success] - PEB object has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_create_dirty_using_container(struct ssdfs_peb_container *pebc,
+					int selected_peb)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_segment_request *req1, *req2, *req3, *req4;
+	int command;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+	BUG_ON(selected_peb != SSDFS_SRC_AND_DST_PEB);
+
+	SSDFS_DBG("seg %llu, peb_index %u, peb_type %#x, "
+		  "selected_peb %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  selected_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_SRC_LAST_LOG_FOOTER;
+	else
+		BUG();
+
+	req1 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req1)) {
+		err = (req1 == NULL ? -ENOMEM : PTR_ERR(req1));
+		req1 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		goto fail_create_dirty_using_peb_obj;
+	}
+
+	ssdfs_request_init(req1);
+	ssdfs_get_request(req1);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req1);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req1);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req1);
+
+	if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_DST_ALL_LOG_HEADERS;
+	else
+		BUG();
+
+	req2 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req2)) {
+		err = (req2 == NULL ? -ENOMEM : PTR_ERR(req2));
+		req2 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		goto fail_create_dirty_using_peb_obj;
+	}
+
+	ssdfs_request_init(req2);
+	/* read thread puts request */
+	ssdfs_get_request(req2);
+	/* it needs to be sure that request will be not freed */
+	ssdfs_get_request(req2);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req2);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req2);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req2);
+
+	if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_BLK_BMAP_DST_USING_PEB;
+	else
+		BUG();
+
+	req3 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req3)) {
+		err = (req3 == NULL ? -ENOMEM : PTR_ERR(req3));
+		req3 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_dirty_using_peb_obj;
+	}
+
+	ssdfs_request_init(req3);
+	ssdfs_get_request(req3);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req3);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req3);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req3);
+
+	if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_BLK2OFF_TABLE_DST_PEB;
+	else
+		BUG();
+
+	req4 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req4)) {
+		err = (req4 == NULL ? -ENOMEM : PTR_ERR(req4));
+		req4 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_dirty_using_peb_obj;
+	}
+
+	ssdfs_request_init(req4);
+	ssdfs_get_request(req4);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req4);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req4);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req4);
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_READ_THREAD);
+	if (unlikely(err)) {
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			SSDFS_ERR("fail to start read thread: "
+				  "peb_index %u, err %d\n",
+				  pebc->peb_index, err);
+		}
+
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_dirty_using_peb_obj;
+	}
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_FLUSH_THREAD);
+	if (unlikely(err)) {
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			SSDFS_ERR("fail to start flush thread: "
+				  "peb_index %u, err %d\n",
+				  pebc->peb_index, err);
+		}
+
+		goto stop_read_thread;
+	}
+
+	peb_blkbmap = &pebc->parent_si->blk_bmap.peb[pebc->peb_index];
+
+	if (!ssdfs_peb_blk_bmap_initialized(peb_blkbmap)) {
+		err = SSDFS_WAIT_COMPLETION(&req2->result.wait);
+		if (unlikely(err)) {
+			SSDFS_ERR("read thread fails: err %d\n",
+				  err);
+			goto stop_flush_thread;
+		}
+
+		/*
+		 * Block bitmap has been locked for initialization.
+		 * Now it isn't initialized yet. It should check
+		 * block bitmap initialization state during first
+		 * request about free pages count.
+		 */
+	}
+
+	ssdfs_put_request(req2);
+
+	/*
+	 * Current log start_page and data_free_pages count was defined
+	 * in the read thread during searching last actual state of block
+	 * bitmap.
+	 */
+
+	/*
+	 * Wake up read request if it waits zeroing
+	 * of reference counter.
+	 */
+	wake_up_all(&pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD]);
+
+	return 0;
+
+stop_flush_thread:
+	ssdfs_peb_stop_thread(pebc, SSDFS_PEB_FLUSH_THREAD);
+
+stop_read_thread:
+	ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+	wake_up_all(&pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD]);
+	ssdfs_peb_stop_thread(pebc, SSDFS_PEB_READ_THREAD);
+
+fail_create_dirty_using_peb_obj:
+	return err;
+}
+
+/*
+ * ssdfs_create_dirty_used_container() - create "dirty" + "used" PEB container
+ * @pebi: pointer on PEB container
+ * @selected_peb: source or destination PEB?
+ *
+ * This function tries to initialize PEB container for "dirty" + "used"
+ * state of the PEBs.
+ *
+ * RETURN:
+ * [success] - PEB container has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_create_dirty_used_container(struct ssdfs_peb_container *pebc,
+				      int selected_peb)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	struct ssdfs_segment_request *req1, *req2, *req3, *req4;
+	int command;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si);
+	BUG_ON(!pebc->parent_si->blk_bmap.peb);
+	BUG_ON(selected_peb != SSDFS_SRC_AND_DST_PEB);
+
+	SSDFS_DBG("seg %llu, peb_index %u, peb_type %#x, "
+		  "selected_peb %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, pebc->peb_type,
+		  selected_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_SRC_LAST_LOG_FOOTER;
+	else
+		BUG();
+
+	req1 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req1)) {
+		err = (req1 == NULL ? -ENOMEM : PTR_ERR(req1));
+		req1 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		goto fail_create_dirty_used_peb_obj;
+	}
+
+	ssdfs_request_init(req1);
+	ssdfs_get_request(req1);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req1);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req1);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req1);
+
+	if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_DST_ALL_LOG_HEADERS;
+	else
+		BUG();
+
+	req2 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req2)) {
+		err = (req2 == NULL ? -ENOMEM : PTR_ERR(req2));
+		req2 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		goto fail_create_dirty_used_peb_obj;
+	}
+
+	ssdfs_request_init(req2);
+	/* read thread puts request */
+	ssdfs_get_request(req2);
+	/* it needs to be sure that request will be not freed */
+	ssdfs_get_request(req2);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req2);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req2);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req2);
+
+	if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_BLK_BMAP_DST_USED_PEB;
+	else
+		BUG();
+
+	req3 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req3)) {
+		err = (req3 == NULL ? -ENOMEM : PTR_ERR(req3));
+		req3 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_dirty_used_peb_obj;
+	}
+
+	ssdfs_request_init(req3);
+	ssdfs_get_request(req3);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req3);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req3);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req3);
+
+	if (selected_peb == SSDFS_SRC_AND_DST_PEB)
+		command = SSDFS_READ_BLK2OFF_TABLE_DST_PEB;
+	else
+		BUG();
+
+	req4 = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req4)) {
+		err = (req4 == NULL ? -ENOMEM : PTR_ERR(req4));
+		req4 = NULL;
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_dirty_used_peb_obj;
+	}
+
+	ssdfs_request_init(req4);
+	ssdfs_get_request(req4);
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    command,
+					    SSDFS_REQ_ASYNC,
+					    req4);
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req4);
+	ssdfs_peb_read_request_cno(pebc);
+	ssdfs_requests_queue_add_tail(&pebc->read_rq, req4);
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_READ_THREAD);
+	if (unlikely(err)) {
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			SSDFS_ERR("fail to start read thread: "
+				  "peb_index %u, err %d\n",
+				  pebc->peb_index, err);
+		}
+
+		ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+		goto fail_create_dirty_used_peb_obj;
+	}
+
+	err = ssdfs_peb_start_thread(pebc, SSDFS_PEB_FLUSH_THREAD);
+	if (unlikely(err)) {
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+		} else {
+			SSDFS_ERR("fail to start flush thread: "
+				  "peb_index %u, err %d\n",
+				  pebc->peb_index, err);
+		}
+
+		goto stop_read_thread;
+	}
+
+	peb_blkbmap = &pebc->parent_si->blk_bmap.peb[pebc->peb_index];
+
+	if (!ssdfs_peb_blk_bmap_initialized(peb_blkbmap)) {
+		err = SSDFS_WAIT_COMPLETION(&req2->result.wait);
+		if (unlikely(err)) {
+			SSDFS_ERR("read thread fails: err %d\n",
+				  err);
+			goto stop_flush_thread;
+		}
+
+		/*
+		 * Block bitmap has been locked for initialization.
+		 * Now it isn't initialized yet. It should check
+		 * block bitmap initialization state during first
+		 * request about free pages count.
+		 */
+	}
+
+	ssdfs_put_request(req2);
+
+	/*
+	 * Current log start_page and data_free_pages count was defined
+	 * in the read thread during searching last actual state of block
+	 * bitmap.
+	 */
+
+	/*
+	 * Wake up read request if it waits zeroing
+	 * of reference counter.
+	 */
+	wake_up_all(&pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD]);
+
+	return 0;
+
+stop_flush_thread:
+	ssdfs_peb_stop_thread(pebc, SSDFS_PEB_FLUSH_THREAD);
+
+stop_read_thread:
+	ssdfs_requests_queue_remove_all(&pebc->read_rq, -ERANGE);
+	wake_up_all(&pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD]);
+	ssdfs_peb_stop_thread(pebc, SSDFS_PEB_READ_THREAD);
+
+fail_create_dirty_used_peb_obj:
+	return err;
+}
+
+/*
+ * ssdfs_peb_container_get_peb_relation() - get description of relation
+ * @fsi: file system info object
+ * @seg: segment identification number
+ * @peb_index: PEB's index
+ * @peb_type: PEB's type
+ * @seg_state: segment state
+ * @pebr: description of PEBs relation [out]
+ *
+ * This function tries to retrieve PEBs' relation description.
+ *
+ * RETURN:
+ * [success].
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENODATA    - cannott map LEB to PEB.
+ */
+static
+int ssdfs_peb_container_get_peb_relation(struct ssdfs_fs_info *fsi,
+					 u64 seg, u32 peb_index,
+					 u8 peb_type, int seg_state,
+					 struct ssdfs_maptbl_peb_relation *pebr)
+{
+	u64 leb_id;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pebr);
+
+	SSDFS_DBG("fsi %p, seg %llu, peb_index %u, "
+		  "peb_type %#x, seg_state %#x\n",
+		  fsi, seg, peb_index, peb_type, seg_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	leb_id = ssdfs_get_leb_id_for_peb_index(fsi, seg, peb_index);
+	if (leb_id == U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  seg, peb_index);
+		return -EINVAL;
+	}
+
+	switch (seg_state) {
+	case SSDFS_SEG_CLEAN:
+		err = ssdfs_peb_map_leb2peb(fsi, leb_id, peb_type,
+					    pebr);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("can't map LEB to PEB: "
+				  "leb_id %llu, peb_type %#x, err %d\n",
+				  leb_id, peb_type, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to map LEB to PEB: "
+				  "leb_id %llu, peb_type %#x, err %d\n",
+				  leb_id, peb_type, err);
+			return err;
+		}
+		break;
+
+	case SSDFS_SEG_DATA_USING:
+	case SSDFS_SEG_LEAF_NODE_USING:
+	case SSDFS_SEG_HYBRID_NODE_USING:
+	case SSDFS_SEG_INDEX_NODE_USING:
+		err = ssdfs_peb_map_leb2peb(fsi, leb_id, peb_type,
+					    pebr);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("can't map LEB to PEB: "
+				  "leb_id %llu, peb_type %#x, err %d\n",
+				  leb_id, peb_type, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to map LEB to PEB: "
+				  "leb_id %llu, peb_type %#x, err %d\n",
+				  leb_id, peb_type, err);
+			return err;
+		}
+		break;
+
+	case SSDFS_SEG_USED:
+	case SSDFS_SEG_PRE_DIRTY:
+		err = ssdfs_peb_convert_leb2peb(fsi, leb_id, peb_type,
+						pebr);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("LEB doesn't mapped: leb_id %llu\n",
+				  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to convert LEB to PEB: "
+				  "leb_id %llu, peb_type %#x, err %d\n",
+				  leb_id, peb_type, err);
+			return err;
+		}
+		break;
+
+	case SSDFS_SEG_DIRTY:
+		err = ssdfs_peb_convert_leb2peb(fsi, leb_id, peb_type,
+						pebr);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("LEB doesn't mapped: leb_id %llu\n",
+				  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to convert LEB to PEB: "
+				  "leb_id %llu, peb_type %#x, err %d\n",
+				  leb_id, peb_type, err);
+			return err;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid segment state\n");
+		return -EINVAL;
+	};
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_container_start_threads() - start PEB container's threads
+ * @pebc: pointer on PEB container
+ * @src_peb_state: source PEB's state
+ * @dst_peb_state: destination PEB's state
+ * @src_peb_flags: source PEB's flags
+ *
+ * This function tries to start PEB's container threads.
+ *
+ * RETURN:
+ * [success].
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_peb_container_start_threads(struct ssdfs_peb_container *pebc,
+				      int src_peb_state,
+				      int dst_peb_state,
+				      u8 src_peb_flags)
+{
+	struct ssdfs_peb_blk_bmap *peb_blkbmap;
+	bool peb_has_ext_ptr;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+
+	SSDFS_DBG("seg %llu, peb_index %u, src_peb_state %#x, "
+		  "dst_peb_state %#x, src_peb_flags %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, src_peb_state,
+		  dst_peb_state, src_peb_flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	peb_has_ext_ptr = src_peb_flags & SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR;
+
+	switch (src_peb_state) {
+	case SSDFS_MAPTBL_UNKNOWN_PEB_STATE:
+		switch (dst_peb_state) {
+		case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+			err = ssdfs_create_clean_peb_container(pebc,
+								SSDFS_DST_PEB);
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create clean PEB container: "
+					  "err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			err = ssdfs_create_using_peb_container(pebc,
+								SSDFS_DST_PEB);
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create using PEB container: "
+					  "err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+		case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			err = ssdfs_create_used_peb_container(pebc,
+							      SSDFS_DST_PEB);
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create used PEB container: "
+					  "err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			err = ssdfs_create_pre_dirty_peb_container(pebc,
+								SSDFS_DST_PEB);
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create pre-dirty PEB "
+					  "container: err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+			err = ssdfs_create_dirty_peb_container(pebc,
+								SSDFS_DST_PEB);
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create dirty PEB container: "
+					  "err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		default:
+			SSDFS_ERR("invalid PEB state: "
+				  "source %#x, destination %#x\n",
+				  src_peb_state, dst_peb_state);
+			err = -ERANGE;
+			goto fail_start_threads;
+		}
+		break;
+
+	case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+		err = ssdfs_create_clean_peb_container(pebc,
+							SSDFS_SRC_PEB);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			goto fail_start_threads;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to create clean PEB container: "
+				  "err %d\n", err);
+			goto fail_start_threads;
+		}
+		break;
+
+	case SSDFS_MAPTBL_USING_PEB_STATE:
+		err = ssdfs_create_using_peb_container(pebc,
+							SSDFS_SRC_PEB);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			goto fail_start_threads;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to create using PEB container: "
+				  "err %d\n", err);
+			goto fail_start_threads;
+		}
+		break;
+
+	case SSDFS_MAPTBL_USED_PEB_STATE:
+		err = ssdfs_create_used_peb_container(pebc,
+							SSDFS_SRC_PEB);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			goto fail_start_threads;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to create used PEB container: "
+				  "err %d\n", err);
+			goto fail_start_threads;
+		}
+		break;
+
+	case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+		err = ssdfs_create_pre_dirty_peb_container(pebc,
+							   SSDFS_SRC_PEB);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			goto fail_start_threads;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to create pre-dirty PEB container: "
+				  "err %d\n", err);
+			goto fail_start_threads;
+		}
+		break;
+
+	case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+		err = ssdfs_create_dirty_peb_container(pebc,
+							SSDFS_SRC_PEB);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			goto fail_start_threads;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to create dirty PEB container: "
+				  "err %d\n", err);
+			goto fail_start_threads;
+		}
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+		switch (dst_peb_state) {
+		case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+			peb_blkbmap =
+			    &pebc->parent_si->blk_bmap.peb[pebc->peb_index];
+			atomic_set(&peb_blkbmap->state,
+					SSDFS_PEB_BLK_BMAP_HAS_CLEAN_DST);
+
+			err = ssdfs_create_used_peb_container(pebc,
+							      SSDFS_SRC_PEB);
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create used PEB container: "
+					  "err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			if (peb_has_ext_ptr) {
+				err = ssdfs_create_used_peb_container(pebc,
+								SSDFS_SRC_PEB);
+			} else {
+				err = ssdfs_create_using_peb_container(pebc,
+							SSDFS_SRC_AND_DST_PEB);
+			}
+
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create using PEB container: "
+					  "err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		default:
+			SSDFS_ERR("invalid PEB state: "
+				  "source %#x, destination %#x\n",
+				  src_peb_state, dst_peb_state);
+			err = -ERANGE;
+			goto fail_start_threads;
+		}
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+		switch (dst_peb_state) {
+		case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+			peb_blkbmap =
+			    &pebc->parent_si->blk_bmap.peb[pebc->peb_index];
+			atomic_set(&peb_blkbmap->state,
+					SSDFS_PEB_BLK_BMAP_HAS_CLEAN_DST);
+
+			err = ssdfs_create_pre_dirty_peb_container(pebc,
+								SSDFS_SRC_PEB);
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create pre-dirty PEB "
+					  "container: err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			if (peb_has_ext_ptr) {
+				err = ssdfs_create_pre_dirty_peb_container(pebc,
+								SSDFS_SRC_PEB);
+			} else {
+				err = ssdfs_create_using_peb_container(pebc,
+							SSDFS_SRC_AND_DST_PEB);
+			}
+
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create using PEB container: "
+					  "err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		default:
+			SSDFS_ERR("invalid PEB state: "
+				  "source %#x, destination %#x\n",
+				  src_peb_state, dst_peb_state);
+			err = -ERANGE;
+			goto fail_start_threads;
+		}
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+		switch (dst_peb_state) {
+		case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+			if (peb_has_ext_ptr) {
+				err = ssdfs_create_dirty_peb_container(pebc,
+								SSDFS_SRC_PEB);
+			} else {
+				err = ssdfs_create_dirty_using_container(pebc,
+							SSDFS_SRC_AND_DST_PEB);
+			}
+
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create using PEB container: "
+					  "err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+			if (peb_has_ext_ptr) {
+				err = ssdfs_create_dirty_peb_container(pebc,
+								SSDFS_SRC_PEB);
+			} else {
+				err = ssdfs_create_dirty_used_container(pebc,
+							SSDFS_SRC_AND_DST_PEB);
+			}
+
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create used PEB container: "
+					  "err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+			if (peb_has_ext_ptr) {
+				err = ssdfs_create_dirty_peb_container(pebc,
+								SSDFS_SRC_PEB);
+			} else {
+				err = ssdfs_create_dirty_used_container(pebc,
+							SSDFS_SRC_AND_DST_PEB);
+			}
+
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create pre-dirty PEB "
+					  "container: err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+			if (peb_has_ext_ptr) {
+				err = ssdfs_create_dirty_peb_container(pebc,
+								SSDFS_SRC_PEB);
+			} else {
+				err = ssdfs_create_dirty_peb_container(pebc,
+								SSDFS_DST_PEB);
+			}
+
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				goto fail_start_threads;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create dirty PEB container: "
+					  "err %d\n", err);
+				goto fail_start_threads;
+			}
+			break;
+
+		default:
+			SSDFS_ERR("invalid PEB state: "
+				  "source %#x, destination %#x\n",
+				  src_peb_state, dst_peb_state);
+			err = -ERANGE;
+			goto fail_start_threads;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid PEB state: "
+			  "source %#x, destination %#x\n",
+			  src_peb_state, dst_peb_state);
+		err = -ERANGE;
+		goto fail_start_threads;
+	};
+
+fail_start_threads:
+	return err;
+}
+
+/*
+ * ssdfs_peb_container_create() - create PEB's container object
+ * @fsi: pointer on shared file system object
+ * @seg: segment number
+ * @peb_index: index of PEB object in array
+ * @log_pages: count of pages in log
+ * @si: pointer on parent segment object
+ *
+ * This function tries to create PEB object(s) for @seg
+ * identification number and for @peb_index in array.
+ *
+ * RETURN:
+ * [success] - PEB object(s) has been constructed sucessfully.
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+int ssdfs_peb_container_create(struct ssdfs_fs_info *fsi,
+				u64 seg, u32 peb_index,
+				u8 peb_type,
+				u32 log_pages,
+				struct ssdfs_segment_info *si)
+{
+	struct ssdfs_peb_container *pebc;
+	struct ssdfs_peb_info *pebi;
+	struct ssdfs_maptbl_peb_relation pebr;
+	struct ssdfs_maptbl_peb_descriptor *mtblpd;
+	int src_peb_state = SSDFS_MAPTBL_UNKNOWN_PEB_STATE;
+	int dst_peb_state = SSDFS_MAPTBL_UNKNOWN_PEB_STATE;
+	u8 src_peb_flags = 0;
+	u8 dst_peb_flags = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !si || !si->peb_array);
+
+	if (seg >= fsi->nsegs) {
+		SSDFS_ERR("requested seg %llu >= nsegs %llu\n",
+			  seg, fsi->nsegs);
+		return -EINVAL;
+	}
+
+	if (peb_index >= si->pebs_count) {
+		SSDFS_ERR("requested peb_index %u >= pebs_count %u\n",
+			  peb_index, si->pebs_count);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, seg %llu, peb_index %u, "
+		  "peb_type %#x, si %p\n",
+		  fsi, seg, peb_index, peb_type, si);
+#else
+	SSDFS_DBG("fsi %p, seg %llu, peb_index %u, "
+		  "peb_type %#x, si %p\n",
+		  fsi, seg, peb_index, peb_type, si);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	pebc = &si->peb_array[peb_index];
+
+	memset(pebc, 0, sizeof(struct ssdfs_peb_container));
+	mutex_init(&pebc->migration_lock);
+	atomic_set(&pebc->migration_state, SSDFS_PEB_UNKNOWN_MIGRATION_STATE);
+	atomic_set(&pebc->migration_phase, SSDFS_PEB_MIGRATION_STATUS_UNKNOWN);
+	atomic_set(&pebc->items_state, SSDFS_PEB_CONTAINER_EMPTY);
+	atomic_set(&pebc->shared_free_dst_blks, 0);
+	init_waitqueue_head(&pebc->migration_wq);
+	init_rwsem(&pebc->lock);
+	atomic_set(&pebc->dst_peb_refs, 0);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("shared_free_dst_blks %d\n",
+		  atomic_read(&pebc->shared_free_dst_blks));
+	SSDFS_DBG("dst_peb_refs %d\n",
+		  atomic_read(&pebc->dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pebc->peb_type = peb_type;
+	if (peb_type >= SSDFS_MAPTBL_PEB_TYPE_MAX) {
+		SSDFS_ERR("invalid seg_type %#x\n", si->seg_type);
+		return -EINVAL;
+	}
+
+	pebc->peb_index = peb_index;
+	pebc->log_pages = log_pages;
+	pebc->parent_si = si;
+
+	ssdfs_requests_queue_init(&pebc->read_rq);
+	ssdfs_requests_queue_init(&pebc->update_rq);
+	spin_lock_init(&pebc->pending_lock);
+	pebc->pending_updated_user_data_pages = 0;
+	spin_lock_init(&pebc->crq_ptr_lock);
+	pebc->create_rq = NULL;
+
+	spin_lock_init(&pebc->cache_protection.cno_lock);
+	pebc->cache_protection.create_cno = ssdfs_current_cno(fsi->sb);
+	pebc->cache_protection.last_request_cno =
+					pebc->cache_protection.create_cno;
+	pebc->cache_protection.reqs_count = 0;
+	pebc->cache_protection.protected_range = 0;
+	pebc->cache_protection.future_request_cno =
+					pebc->cache_protection.create_cno;
+
+	err = ssdfs_peb_container_get_peb_relation(fsi, seg, peb_index,
+						   peb_type,
+						   atomic_read(&si->seg_state),
+						   &pebr);
+	if (err == -ENODATA) {
+		struct ssdfs_peb_blk_bmap *peb_blkbmap;
+
+		err = 0;
+
+		peb_blkbmap = &pebc->parent_si->blk_bmap.peb[pebc->peb_index];
+		ssdfs_set_block_bmap_initialized(peb_blkbmap->src);
+		atomic_set(&peb_blkbmap->state, SSDFS_PEB_BLK_BMAP_INITIALIZED);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("can't map LEB to PEB: "
+			  "seg %llu, peb_index %u, "
+			  "peb_type %#x, err %d\n",
+			  seg, peb_index, peb_type, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_init_peb_container;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to map LEB to PEB: "
+			  "seg %llu, peb_index %u, "
+			  "peb_type %#x, err %d\n",
+			  seg, peb_index, peb_type, err);
+		goto fail_init_peb_container;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("MAIN_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x; "
+		  "RELATION_INDEX: peb_id %llu, type %#x, "
+		  "state %#x, consistency %#x\n",
+		  pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].peb_id,
+		  pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].type,
+		  pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].state,
+		  pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX].consistency,
+		  pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].peb_id,
+		  pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].type,
+		  pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].state,
+		  pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX].consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&pebc->lock);
+
+	mtblpd = &pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX];
+
+	if (mtblpd->peb_id == U64_MAX)
+		goto try_process_relation;
+
+	pebi = &pebc->items[SSDFS_SEG_PEB1];
+
+	err = ssdfs_peb_object_create(pebi, pebc,
+					mtblpd->peb_id,
+					mtblpd->state,
+					SSDFS_PEB_UNKNOWN_MIGRATION_ID);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create PEB object: "
+			  "seg %llu, peb_index %u, "
+			  "peb_id %llu, peb_state %#x\n",
+			  seg, peb_index,
+			  mtblpd->peb_id,
+			  mtblpd->state);
+		goto fail_create_peb_objects;
+	}
+
+	pebc->src_peb = pebi;
+	src_peb_state = mtblpd->state;
+	src_peb_flags = mtblpd->flags;
+
+	if (mtblpd->flags & SSDFS_MAPTBL_SHARED_DESTINATION_PEB ||
+	    (mtblpd->flags & SSDFS_MAPTBL_SHARED_DESTINATION_PEB &&
+	     mtblpd->flags & SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR)) {
+		SSDFS_ERR("invalid set of flags %#x\n",
+			  mtblpd->flags);
+		err = -EIO;
+		goto fail_create_peb_objects;
+	}
+
+	atomic_set(&pebc->migration_state, SSDFS_PEB_NOT_MIGRATING);
+	atomic_set(&pebc->items_state, SSDFS_PEB1_SRC_CONTAINER);
+
+	switch (mtblpd->state) {
+	case SSDFS_MAPTBL_CLEAN_PEB_STATE:
+	case SSDFS_MAPTBL_USING_PEB_STATE:
+	case SSDFS_MAPTBL_USED_PEB_STATE:
+	case SSDFS_MAPTBL_PRE_DIRTY_PEB_STATE:
+	case SSDFS_MAPTBL_DIRTY_PEB_STATE:
+		/* PEB container has been created */
+		goto start_container_threads;
+		break;
+
+	case SSDFS_MAPTBL_MIGRATION_SRC_USED_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_PRE_DIRTY_STATE:
+	case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+		/*
+		 * Do nothing here.
+		 * Follow to create second PEB object.
+		 */
+		break;
+
+	default:
+		SSDFS_WARN("invalid PEB state: "
+			   "seg %llu, peb_index %u, "
+			   "peb_id %llu, peb_state %#x\n",
+			   seg, peb_index,
+			   mtblpd->peb_id,
+			   mtblpd->state);
+		err = -ERANGE;
+		goto fail_create_peb_objects;
+	}
+
+try_process_relation:
+	mtblpd = &pebr.pebs[SSDFS_MAPTBL_RELATION_INDEX];
+
+	if (mtblpd->peb_id == U64_MAX) {
+		SSDFS_ERR("invalid peb_id\n");
+		err = -ERANGE;
+		goto fail_create_peb_objects;
+	}
+
+	switch (mtblpd->state) {
+	case SSDFS_MAPTBL_MIGRATION_DST_CLEAN_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USING_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_USED_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_PRE_DIRTY_STATE:
+	case SSDFS_MAPTBL_MIGRATION_DST_DIRTY_STATE:
+		/*
+		 * Do nothing here.
+		 * Follow to create second PEB object.
+		 */
+		break;
+
+	default:
+		SSDFS_WARN("invalid PEB state: "
+			   "seg %llu, peb_index %u, "
+			   "peb_id %llu, peb_state %#x\n",
+			   seg, peb_index,
+			   mtblpd->peb_id,
+			   mtblpd->state);
+		err = -ERANGE;
+		goto fail_create_peb_objects;
+	}
+
+	if (mtblpd->flags & SSDFS_MAPTBL_SHARED_DESTINATION_PEB) {
+		u8 shared_peb_index = mtblpd->shared_peb_index;
+
+		if (!pebc->src_peb) {
+			SSDFS_ERR("source PEB is absent\n");
+			err = -ERANGE;
+			goto fail_create_peb_objects;
+		}
+
+		if (shared_peb_index >= si->pebs_count) {
+			SSDFS_ERR("shared_peb_index %u >= si->pebs_count %u\n",
+				  shared_peb_index, si->pebs_count);
+			err = -ERANGE;
+			goto fail_create_peb_objects;
+		}
+
+		pebi = &si->peb_array[shared_peb_index].items[SSDFS_SEG_PEB2];
+		pebc->dst_peb = pebi;
+		atomic_set(&pebc->items_state,
+				SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER);
+		atomic_inc(&si->peb_array[shared_peb_index].dst_peb_refs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb_id %llu, dst_peb_refs %d\n",
+		    pebi->peb_id,
+		    atomic_read(&si->peb_array[shared_peb_index].dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+		pebi = &pebc->items[SSDFS_SEG_PEB2];
+
+		err = ssdfs_peb_object_create(pebi, pebc,
+						mtblpd->peb_id,
+						mtblpd->state,
+						SSDFS_PEB_UNKNOWN_MIGRATION_ID);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create PEB object: "
+				  "seg %llu, peb_index %u, "
+				  "peb_id %llu, peb_state %#x\n",
+				  seg, peb_index,
+				  mtblpd->peb_id,
+				  mtblpd->state);
+			goto fail_create_peb_objects;
+		}
+
+		pebc->dst_peb = pebi;
+
+		if (!pebc->src_peb) {
+			atomic_set(&pebc->items_state,
+				    SSDFS_PEB2_DST_CONTAINER);
+		} else {
+			atomic_set(&pebc->items_state,
+				    SSDFS_PEB1_SRC_PEB2_DST_CONTAINER);
+			atomic_inc(&pebc->dst_peb_refs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("peb_id %llu, dst_peb_refs %d\n",
+				  mtblpd->peb_id,
+				  atomic_read(&pebc->dst_peb_refs));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	}
+
+	dst_peb_state = mtblpd->state;
+	dst_peb_flags = mtblpd->flags;
+
+	if (mtblpd->flags & SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR ||
+	    (mtblpd->flags & SSDFS_MAPTBL_SHARED_DESTINATION_PEB &&
+	     mtblpd->flags & SSDFS_MAPTBL_SOURCE_PEB_HAS_EXT_PTR)) {
+		SSDFS_ERR("invalid set of flags %#x\n",
+			  mtblpd->flags);
+		err = -EIO;
+		goto fail_create_peb_objects;
+	}
+
+	atomic_set(&pebc->migration_state, SSDFS_PEB_UNDER_MIGRATION);
+	atomic_inc(&si->migration.migrating_pebs);
+
+start_container_threads:
+	up_write(&pebc->lock);
+
+	err = ssdfs_peb_container_start_threads(pebc, src_peb_state,
+						dst_peb_state,
+						src_peb_flags);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		goto fail_init_peb_container;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to start PEB's threads: "
+			  "err %d\n", err);
+		goto fail_init_peb_container;
+	}
+
+finish_init_peb_container:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("PEB has been created: "
+		  "seg %llu, peb_index %u\n",
+		  seg, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+fail_create_peb_objects:
+	up_write(&pebc->lock);
+
+fail_init_peb_container:
+	ssdfs_peb_container_destroy(pebc);
+	return err;
+}
+
+/*
+ * ssdfs_peb_container_destroy() - destroy PEB's container object
+ * @ptr: pointer on container placement
+ */
+void ssdfs_peb_container_destroy(struct ssdfs_peb_container *ptr)
+{
+	int migration_state;
+	int items_state;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	migration_state = atomic_read(&ptr->migration_state);
+	items_state = atomic_read(&ptr->items_state);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("ptr %p, migration_state %#x, items_state %#x\n",
+		  ptr, migration_state, items_state);
+#else
+	SSDFS_DBG("ptr %p, migration_state %#x, items_state %#x\n",
+		  ptr, migration_state, items_state);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!is_ssdfs_requests_queue_empty(&ptr->read_rq)) {
+		ssdfs_fs_error(ptr->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"read requests queue isn't empty\n");
+		err = -EIO;
+		ssdfs_requests_queue_remove_all(&ptr->read_rq, err);
+	}
+
+	if (!is_ssdfs_requests_queue_empty(&ptr->update_rq)) {
+		ssdfs_fs_error(ptr->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"flush requests queue isn't empty\n");
+		err = -EIO;
+		ssdfs_requests_queue_remove_all(&ptr->update_rq, err);
+	}
+
+	if (is_peb_container_empty(ptr)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("PEB container is empty: "
+			  "peb_type %#x, peb_index %u\n",
+			  ptr->peb_type, ptr->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return;
+	}
+
+	if (migration_state <= SSDFS_PEB_UNKNOWN_MIGRATION_STATE ||
+	    migration_state >= SSDFS_PEB_MIGRATION_STATE_MAX) {
+		SSDFS_WARN("invalid migration_state %#x\n",
+			   migration_state);
+	}
+
+	if (items_state < SSDFS_PEB_CONTAINER_EMPTY ||
+	    items_state >= SSDFS_PEB_CONTAINER_STATE_MAX) {
+		SSDFS_WARN("invalid items_state %#x\n",
+			   items_state);
+	}
+
+	for (i = 0; i < SSDFS_PEB_THREAD_TYPE_MAX; i++) {
+		int err2;
+
+		err2 = ssdfs_peb_stop_thread(ptr, i);
+		if (err2 == -EIO) {
+			ssdfs_fs_error(ptr->parent_si->fsi->sb,
+					__FILE__, __func__, __LINE__,
+					"thread I/O issue: "
+					"peb_index %u, thread type %#x\n",
+					ptr->peb_index, i);
+		} else if (unlikely(err2)) {
+			SSDFS_WARN("thread stopping issue: "
+				   "peb_index %u, thread type %#x, err %d\n",
+				   ptr->peb_index, i, err2);
+		}
+	}
+
+	down_write(&ptr->lock);
+
+	switch (atomic_read(&ptr->items_state)) {
+	case SSDFS_PEB_CONTAINER_EMPTY:
+#ifdef CONFIG_SSDFS_DEBUG
+		WARN_ON(ptr->src_peb);
+		WARN_ON(ptr->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		ptr->src_peb = NULL;
+		ptr->dst_peb = NULL;
+		break;
+
+	case SSDFS_PEB1_SRC_CONTAINER:
+	case SSDFS_PEB2_SRC_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!ptr->src_peb);
+		WARN_ON(ptr->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = ssdfs_peb_object_destroy(ptr->src_peb);
+		if (unlikely(err)) {
+			SSDFS_WARN("fail to destroy PEB object: "
+				   "err %d\n",
+				   err);
+		}
+		ptr->src_peb = NULL;
+		ptr->dst_peb = NULL;
+		break;
+
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!ptr->dst_peb);
+		WARN_ON(ptr->src_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = ssdfs_peb_object_destroy(ptr->dst_peb);
+		if (unlikely(err)) {
+			SSDFS_WARN("fail to destroy PEB object: "
+				   "err %d\n",
+				   err);
+		}
+
+		ptr->src_peb = NULL;
+		ptr->dst_peb = NULL;
+		break;
+
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!ptr->src_peb);
+		BUG_ON(!ptr->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = ssdfs_peb_object_destroy(ptr->src_peb);
+		if (unlikely(err)) {
+			SSDFS_WARN("fail to destroy PEB object: "
+				   "err %d\n",
+				   err);
+		}
+		ptr->src_peb = NULL;
+		ptr->dst_peb = NULL;
+		break;
+
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!ptr->src_peb);
+		BUG_ON(!ptr->dst_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = ssdfs_peb_object_destroy(ptr->src_peb);
+		if (unlikely(err)) {
+			SSDFS_WARN("fail to destroy PEB object: "
+				   "err %d\n",
+				   err);
+		}
+		err = ssdfs_peb_object_destroy(ptr->dst_peb);
+		if (unlikely(err)) {
+			SSDFS_WARN("fail to destroy PEB object: "
+				   "err %d\n",
+				   err);
+		}
+		ptr->src_peb = NULL;
+		ptr->dst_peb = NULL;
+		break;
+
+	default:
+		BUG();
+	}
+
+	memset(ptr->items, 0,
+		sizeof(struct ssdfs_peb_info) * SSDFS_SEG_PEB_ITEMS_MAX);
+
+	up_write(&ptr->lock);
+
+	atomic_set(&ptr->migration_state, SSDFS_PEB_UNKNOWN_MIGRATION_STATE);
+	atomic_set(&ptr->items_state, SSDFS_PEB_CONTAINER_EMPTY);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
-- 
2.34.1


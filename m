Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563A36A2677
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBYBVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjBYBTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:40 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C95215165
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:15 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id o12so805104oik.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSf5Hi6No/q/6dleGU3lmrW6Qw9rlCHUll6SgrFQxaE=;
        b=T9TdIftTIoAIYnbWpMYSRROshFqxBJP4sR1A4YIPBvv8t0FRMGn3A3YWM7uYwmy4wa
         1U08WgtfMuMmRjwCHyW9KFV0rtd3LkO6e2MvaVkPlxU6boDWGnC8wGD3tkC2mHEu+LUn
         wN21Uhr5GG6BaQmA+0FygF9qrdC7lkcqPhQeC185oSKwQKFO2nlPKqgxWjhD6tH+XqUO
         XwywB6ItlKfu6lTSncNEJCQOXPVzL6QfsoxL4vfUDRazFVZzKOm3DzeEfCUdvr/govTJ
         cz3PAyPEjsYZdzN2BG7amzXeD/5N1Rm8uFPKHaa0e+ntalsmTkKddYbbiD41C1kHxH3x
         8yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSf5Hi6No/q/6dleGU3lmrW6Qw9rlCHUll6SgrFQxaE=;
        b=2kw7XrqSi57gXP0yjf/wWC5n6p2083YXiFdH+A0S7HC6eH0rfZlOujsgmF5DEnld8/
         C/y13Avp7+4yWTp2jBf5UIjnfkpU651xIsVoy72/4XT24lTuUNw3J3P/v8HIfqaJZ3hp
         kSnh3Ro6qsbzPaJcW0IDSu0y5sYepfJcAnM2WxoDREc5bznhXLOJPd1VLt9Yh1K5q5oT
         k5CvhLy+CwIOdP5Ua2dlH89nqhoDKzM6YTDarZxMqa4bT3gelpgOHPjUb5/77ylCOisr
         Q736KRiiUsL5KOqmc1YrDBK02O7uGFXgalDSjnkc/d+qqeVcxeEkxnd6XFMlKcfOzp8g
         nMEg==
X-Gm-Message-State: AO0yUKXZXUl2BoHlQ1AdIfhct5zxuo34BCWZs1rS2ORwLy7nfiqMfhAA
        PgITzX78lRaTnVeagT/mt75C6DNjUlRyxgOe
X-Google-Smtp-Source: AK7set9ypx7RXwg2Lg6LlRtFYpsqKdfA5Q0gcVrw3V/meXP/YW4X3XSCJc4pSpeO0nzVD4jtt+cNOA==
X-Received: by 2002:a54:418a:0:b0:384:637:a4f with SMTP id 10-20020a54418a000000b0038406370a4fmr1299414oiy.10.1677287893769;
        Fri, 24 Feb 2023 17:18:13 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:18:12 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 75/76] ssdfs: implement file operations support
Date:   Fri, 24 Feb 2023 17:09:26 -0800
Message-Id: <20230225010927.813929-76-slava@dubeyko.com>
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

Implement file operations support.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/file.c | 2523 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2523 insertions(+)
 create mode 100644 fs/ssdfs/file.c

diff --git a/fs/ssdfs/file.c b/fs/ssdfs/file.c
new file mode 100644
index 000000000000..24110db0e209
--- /dev/null
+++ b/fs/ssdfs/file.c
@@ -0,0 +1,2523 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/file.c - file operations.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/writeback.h>
+#include <linux/pagevec.h>
+#include <linux/blkdev.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "request_queue.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb_container.h"
+#include "segment_bitmap.h"
+#include "segment.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "inodes_tree.h"
+#include "extents_tree.h"
+#include "xattr.h"
+#include "acl.h"
+#include "peb_mapping_table.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_file_page_leaks;
+atomic64_t ssdfs_file_memory_leaks;
+atomic64_t ssdfs_file_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_file_cache_leaks_increment(void *kaddr)
+ * void ssdfs_file_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_file_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_file_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_file_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_file_kfree(void *kaddr)
+ * struct page *ssdfs_file_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_file_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_file_free_page(struct page *page)
+ * void ssdfs_file_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(file)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(file)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_file_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_file_page_leaks, 0);
+	atomic64_set(&ssdfs_file_memory_leaks, 0);
+	atomic64_set(&ssdfs_file_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_file_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_file_page_leaks) != 0) {
+		SSDFS_ERR("FILE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_file_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_file_memory_leaks) != 0) {
+		SSDFS_ERR("FILE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_file_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_file_cache_leaks) != 0) {
+		SSDFS_ERR("FILE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_file_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+enum {
+	SSDFS_BLOCK_BASED_REQUEST,
+	SSDFS_EXTENT_BASED_REQUEST,
+};
+
+enum {
+	SSDFS_CURRENT_THREAD_READ,
+	SSDFS_DELEGATE_TO_READ_THREAD,
+};
+
+static inline
+bool can_file_be_inline(struct inode *inode, loff_t new_size)
+{
+	size_t capacity = ssdfs_inode_inline_file_capacity(inode);
+
+	if (capacity == 0)
+		return false;
+
+	if (capacity < new_size)
+		return false;
+
+	return true;
+}
+
+static inline
+size_t ssdfs_inode_size_threshold(void)
+{
+	return sizeof(struct ssdfs_inode) -
+			offsetof(struct ssdfs_inode, internal);
+}
+
+int ssdfs_allocate_inline_file_buffer(struct inode *inode)
+{
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+	size_t threshold = ssdfs_inode_size_threshold();
+	size_t inline_capacity;
+
+	if (ii->inline_file)
+		return 0;
+
+	inline_capacity = ssdfs_inode_inline_file_capacity(inode);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("inline_capacity %zu, threshold %zu\n",
+		  inline_capacity, threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (inline_capacity < threshold) {
+		SSDFS_ERR("inline_capacity %zu < threshold %zu\n",
+			  inline_capacity, threshold);
+		return -ERANGE;
+	} else if (inline_capacity == threshold) {
+		ii->inline_file = ii->raw_inode.internal;
+	} else {
+		ii->inline_file =
+			ssdfs_file_kzalloc(inline_capacity, GFP_KERNEL);
+		if (!ii->inline_file) {
+			SSDFS_ERR("fail to allocate inline buffer: "
+				  "ino %lu, inline_capacity %zu\n",
+				  inode->i_ino, inline_capacity);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+void ssdfs_destroy_inline_file_buffer(struct inode *inode)
+{
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+	size_t threshold = ssdfs_inode_size_threshold();
+	size_t inline_capacity;
+
+	if (!ii->inline_file)
+		return;
+
+	inline_capacity = ssdfs_inode_inline_file_capacity(inode);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("inline_capacity %zu, threshold %zu\n",
+		  inline_capacity, threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (inline_capacity <= threshold) {
+		ii->inline_file = NULL;
+	} else {
+		ssdfs_file_kfree(ii->inline_file);
+		ii->inline_file = NULL;
+	}
+}
+
+/*
+ * ssdfs_read_block_async() - read block async
+ * @fsi: pointer on shared file system object
+ * @req: request object
+ */
+static
+int ssdfs_read_block_async(struct ssdfs_fs_info *fsi,
+			   struct ssdfs_segment_request *req)
+{
+	struct ssdfs_segment_info *si;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+	BUG_ON((req->extent.logical_offset >> fsi->log_pagesize) >= U32_MAX);
+
+	SSDFS_DBG("fsi %p, req %p\n", fsi, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_prepare_volume_extent(fsi, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare volume extent: "
+			  "ino %llu, logical_offset %llu, "
+			  "data_bytes %u, cno %llu, "
+			  "parent_snapshot %llu, err %d\n",
+			  req->extent.ino,
+			  req->extent.logical_offset,
+			  req->extent.data_bytes,
+			  req->extent.cno,
+			  req->extent.parent_snapshot,
+			  err);
+		return err;
+	}
+
+	req->place.len = 1;
+
+	si = ssdfs_grab_segment(fsi, SSDFS_USER_DATA_SEG_TYPE,
+				req->place.start.seg_id, U64_MAX);
+	if (unlikely(IS_ERR_OR_NULL(si))) {
+		SSDFS_ERR("fail to grab segment object: "
+			  "seg %llu, err %ld\n",
+			  req->place.start.seg_id,
+			  PTR_ERR(si));
+		return PTR_ERR(si);
+	}
+
+	err = ssdfs_segment_read_block_async(si, SSDFS_REQ_ASYNC, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("read request failed: "
+			  "ino %llu, logical_offset %llu, size %u, err %d\n",
+			  req->extent.ino, req->extent.logical_offset,
+			  req->extent.data_bytes, err);
+		return err;
+	}
+
+	ssdfs_segment_put_object(si);
+
+	return 0;
+}
+
+/*
+ * ssdfs_read_block_by_current_thread() - read block by current thread
+ * @fsi: pointer on shared file system object
+ * @req: request object
+ */
+static
+int ssdfs_read_block_by_current_thread(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_container *pebc;
+	struct ssdfs_blk2off_table *table;
+	struct ssdfs_offset_position pos;
+	u16 logical_blk;
+	struct completion *end;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+	BUG_ON((req->extent.logical_offset >> fsi->log_pagesize) >= U32_MAX);
+
+	SSDFS_DBG("fsi %p, req %p\n", fsi, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_prepare_volume_extent(fsi, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare volume extent: "
+			  "ino %llu, logical_offset %llu, "
+			  "data_bytes %u, cno %llu, "
+			  "parent_snapshot %llu, err %d\n",
+			  req->extent.ino,
+			  req->extent.logical_offset,
+			  req->extent.data_bytes,
+			  req->extent.cno,
+			  req->extent.parent_snapshot,
+			  err);
+		return err;
+	}
+
+	req->place.len = 1;
+
+	si = ssdfs_grab_segment(fsi, SSDFS_USER_DATA_SEG_TYPE,
+				req->place.start.seg_id, U64_MAX);
+	if (unlikely(IS_ERR_OR_NULL(si))) {
+		SSDFS_ERR("fail to grab segment object: "
+			  "seg %llu, err %d\n",
+			  req->place.start.seg_id, err);
+		return PTR_ERR(si);
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    SSDFS_READ_PAGE,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	table = si->blk2off_table;
+	logical_blk = req->place.start.blk_index;
+
+	err = ssdfs_blk2off_table_get_offset_position(table, logical_blk, &pos);
+	if (err == -EAGAIN) {
+		end = &table->full_init_end;
+
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("blk2off init failed: "
+				  "err %d\n", err);
+			goto finish_read_block;
+		}
+
+		err = ssdfs_blk2off_table_get_offset_position(table,
+							      logical_blk,
+							      &pos);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to convert: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		goto finish_read_block;
+	}
+
+	pebc = &si->peb_array[pos.peb_index];
+
+	ssdfs_peb_read_request_cno(pebc);
+
+	err = ssdfs_peb_read_page(pebc, req, &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("PEB init failed: "
+				  "err %d\n", err);
+			goto forget_request_cno;
+		}
+
+		err = ssdfs_peb_read_page(pebc, req, &end);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read page: err %d\n",
+			  err);
+		goto forget_request_cno;
+	}
+
+	for (i = 0; i < req->result.processed_blks; i++)
+		ssdfs_peb_mark_request_block_uptodate(pebc, req, i);
+
+forget_request_cno:
+	ssdfs_peb_finish_read_request_cno(pebc);
+
+finish_read_block:
+	req->result.err = err;
+	complete(&req->result.wait);
+	ssdfs_segment_put_object(si);
+
+	return 0;
+}
+
+static
+int ssdfs_readpage_nolock(struct file *file, struct page *page,
+			  int read_mode)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(file_inode(file)->i_sb);
+	struct inode *inode = file_inode(file);
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+	ino_t ino = file_inode(file)->i_ino;
+	pgoff_t index = page_index(page);
+	struct ssdfs_segment_request *req;
+	loff_t logical_offset;
+	loff_t data_bytes;
+	loff_t file_size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, page_index %llu, read_mode %#x\n",
+		  ino, (u64)index, read_mode);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_offset = (loff_t)index << PAGE_SHIFT;
+
+	file_size = i_size_read(file_inode(file));
+	data_bytes = file_size - logical_offset;
+	data_bytes = min_t(loff_t, PAGE_SIZE, data_bytes);
+
+	BUG_ON(data_bytes > U32_MAX);
+
+	ssdfs_memzero_page(page, 0, PAGE_SIZE, PAGE_SIZE);
+
+	if (logical_offset >= file_size) {
+		/* Reading beyond inode */
+		SetPageUptodate(page);
+		ClearPageError(page);
+		flush_dcache_page(page);
+		return 0;
+	}
+
+	if (is_ssdfs_file_inline(ii)) {
+		size_t inline_capacity =
+				ssdfs_inode_inline_file_capacity(inode);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("inline_capacity %zu, file_size %llu\n",
+			  inline_capacity, file_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (file_size > inline_capacity) {
+			ClearPageUptodate(page);
+			ssdfs_clear_page_private(page, 0);
+			SetPageError(page);
+			SSDFS_ERR("file_size %llu is greater capacity %zu\n",
+				  file_size, inline_capacity);
+			return -E2BIG;
+		}
+
+		err = ssdfs_memcpy_to_page(page, 0, PAGE_SIZE,
+					   ii->inline_file, 0, inline_capacity,
+					   data_bytes);
+		if (unlikely(err)) {
+			ClearPageUptodate(page);
+			ssdfs_clear_page_private(page, 0);
+			SetPageError(page);
+			SSDFS_ERR("fail to copy file's content: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		SetPageUptodate(page);
+		ClearPageError(page);
+		flush_dcache_page(page);
+		return 0;
+	}
+
+	req = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req)) {
+		err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_request_init(req);
+	ssdfs_get_request(req);
+
+	ssdfs_request_prepare_logical_extent(ino,
+					     (u64)logical_offset,
+					     (u32)data_bytes,
+					     0, 0, req);
+
+	err = ssdfs_request_add_page(page, req);
+	if (err) {
+		SSDFS_ERR("fail to add page into request: "
+			  "ino %lu, page_index %lu, err %d\n",
+			  ino, index, err);
+		goto fail_read_page;
+	}
+
+	switch (read_mode) {
+	case SSDFS_CURRENT_THREAD_READ:
+		err = ssdfs_read_block_by_current_thread(fsi, req);
+		if (err) {
+			SSDFS_ERR("fail to read block: err %d\n", err);
+			goto fail_read_page;
+		}
+
+		err = SSDFS_WAIT_COMPLETION(&req->result.wait);
+		if (unlikely(err)) {
+			SSDFS_ERR("read request failed: "
+				  "ino %lu, logical_offset %llu, "
+				  "size %u, err %d\n",
+				  ino, (u64)logical_offset,
+				  (u32)data_bytes, err);
+			goto fail_read_page;
+		}
+
+		if (req->result.err) {
+			SSDFS_ERR("read request failed: "
+				  "ino %lu, logical_offset %llu, "
+				  "size %u, err %d\n",
+				  ino, (u64)logical_offset,
+				  (u32)data_bytes,
+				  req->result.err);
+			goto fail_read_page;
+		}
+
+		ssdfs_put_request(req);
+		ssdfs_request_free(req);
+		break;
+
+	case SSDFS_DELEGATE_TO_READ_THREAD:
+		err = ssdfs_read_block_async(fsi, req);
+		if (err) {
+			SSDFS_ERR("fail to read block: err %d\n", err);
+			goto fail_read_page;
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	return 0;
+
+fail_read_page:
+	ClearPageUptodate(page);
+	ssdfs_clear_page_private(page, 0);
+	SetPageError(page);
+	ssdfs_put_request(req);
+	ssdfs_request_free(req);
+
+	return err;
+}
+
+static
+int ssdfs_read_folio(struct file *file, struct folio *folio)
+{
+	struct page *page = &folio->page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, page_index %lu\n",
+		  file_inode(file)->i_ino, page_index(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_account_locked_page(page);
+	err = ssdfs_readpage_nolock(file, page, SSDFS_CURRENT_THREAD_READ);
+	ssdfs_unlock_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, page_index %lu, page %p, "
+		  "count %d, flags %#lx\n",
+		  file_inode(file)->i_ino, page_index(page),
+		  page, page_ref_count(page), page->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+static
+struct ssdfs_segment_request *
+ssdfs_issue_read_request(struct file *file, struct page *page)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(file_inode(file)->i_sb);
+	struct ssdfs_segment_request *req = NULL;
+	struct ssdfs_segment_info *si;
+	ino_t ino = file_inode(file)->i_ino;
+	pgoff_t index = page_index(page);
+	loff_t logical_offset;
+	loff_t data_bytes;
+	loff_t file_size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, page_index %lu\n",
+		  file_inode(file)->i_ino, page_index(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_offset = (loff_t)index << PAGE_SHIFT;
+
+	file_size = i_size_read(file_inode(file));
+	data_bytes = file_size - logical_offset;
+	data_bytes = min_t(loff_t, PAGE_SIZE, data_bytes);
+
+	BUG_ON(data_bytes > U32_MAX);
+
+	ssdfs_memzero_page(page, 0, PAGE_SIZE, PAGE_SIZE);
+
+	if (logical_offset >= file_size) {
+		/* Reading beyond inode */
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("Reading beyond inode: "
+			  "logical_offset %llu, file_size %llu\n",
+			  logical_offset, file_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+		SetPageUptodate(page);
+		ClearPageError(page);
+		flush_dcache_page(page);
+		return ERR_PTR(-ENODATA);
+	}
+
+	req = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(req)) {
+		err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		return req;
+	}
+
+	ssdfs_request_init(req);
+	ssdfs_get_request(req);
+
+	ssdfs_request_prepare_logical_extent(ino,
+					     (u64)logical_offset,
+					     (u32)data_bytes,
+					     0, 0, req);
+
+	err = ssdfs_request_add_page(page, req);
+	if (err) {
+		SSDFS_ERR("fail to add page into request: "
+			  "ino %lu, page_index %lu, err %d\n",
+			  ino, index, err);
+		goto fail_issue_read_request;
+	}
+
+	err = ssdfs_prepare_volume_extent(fsi, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare volume extent: "
+			  "ino %llu, logical_offset %llu, "
+			  "data_bytes %u, cno %llu, "
+			  "parent_snapshot %llu, err %d\n",
+			  req->extent.ino,
+			  req->extent.logical_offset,
+			  req->extent.data_bytes,
+			  req->extent.cno,
+			  req->extent.parent_snapshot,
+			  err);
+		goto fail_issue_read_request;
+	}
+
+	req->place.len = 1;
+
+	si = ssdfs_grab_segment(fsi, SSDFS_USER_DATA_SEG_TYPE,
+				req->place.start.seg_id, U64_MAX);
+	if (unlikely(IS_ERR_OR_NULL(si))) {
+		err = (si == NULL ? -ENOMEM : PTR_ERR(si));
+		SSDFS_ERR("fail to grab segment object: "
+			  "seg %llu, err %d\n",
+			  req->place.start.seg_id,
+			  err);
+		goto fail_issue_read_request;
+	}
+
+	err = ssdfs_segment_read_block_async(si, SSDFS_REQ_ASYNC_NO_FREE, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("read request failed: "
+			  "ino %llu, logical_offset %llu, size %u, err %d\n",
+			  req->extent.ino, req->extent.logical_offset,
+			  req->extent.data_bytes, err);
+		goto fail_issue_read_request;
+	}
+
+	ssdfs_segment_put_object(si);
+
+	return req;
+
+fail_issue_read_request:
+	ClearPageUptodate(page);
+	ssdfs_clear_page_private(page, 0);
+	SetPageError(page);
+	ssdfs_put_request(req);
+	ssdfs_request_free(req);
+
+	return ERR_PTR(err);
+}
+
+static
+int ssdfs_check_read_request(struct ssdfs_segment_request *req)
+{
+	wait_queue_head_t *wq = NULL;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req);
+
+	SSDFS_DBG("req %p\n", req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+check_req_state:
+	switch (atomic_read(&req->result.state)) {
+	case SSDFS_REQ_CREATED:
+	case SSDFS_REQ_STARTED:
+		wq = &req->private.wait_queue;
+
+		err = wait_event_killable_timeout(*wq,
+					has_request_been_executed(req),
+					SSDFS_DEFAULT_TIMEOUT);
+		if (err < 0)
+			WARN_ON(err < 0);
+		else
+			err = 0;
+
+		goto check_req_state;
+		break;
+
+	case SSDFS_REQ_FINISHED:
+		/* do nothing */
+		break;
+
+	case SSDFS_REQ_FAILED:
+		err = req->result.err;
+
+		if (!err) {
+			SSDFS_ERR("error code is absent: "
+				  "req %p, err %d\n",
+				  req, err);
+			err = -ERANGE;
+		}
+
+		SSDFS_ERR("read request is failed: "
+			  "err %d\n", err);
+		return err;
+
+	default:
+		SSDFS_ERR("invalid result's state %#x\n",
+		    atomic_read(&req->result.state));
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+static
+int ssdfs_wait_read_request_end(struct ssdfs_segment_request *req)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("req %p\n", req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!req)
+		return 0;
+
+	err = ssdfs_check_read_request(req);
+	if (unlikely(err)) {
+		SSDFS_ERR("read request failed: "
+			  "err %d\n", err);
+	}
+
+	ssdfs_request_free(req);
+
+	return err;
+}
+
+struct ssdfs_readahead_env {
+	struct file *file;
+	struct ssdfs_segment_request **reqs;
+	unsigned count;
+	unsigned capacity;
+};
+
+static inline
+int ssdfs_readahead_page(void *data, struct page *page)
+{
+	struct ssdfs_readahead_env *env = (struct ssdfs_readahead_env *)data;
+	unsigned index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, page_index %lu, page %p, "
+		  "count %d, flags %#lx\n",
+		  file_inode(env->file)->i_ino, page_index(page),
+		  page, page_ref_count(page), page->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (env->count >= env->capacity) {
+		SSDFS_ERR("count %u >= capacity %u\n",
+			  env->count, env->capacity);
+		return -ERANGE;
+	}
+
+	index = env->count;
+
+	ssdfs_get_page(page);
+	ssdfs_account_locked_page(page);
+
+	env->reqs[index] = ssdfs_issue_read_request(env->file, page);
+	if (IS_ERR_OR_NULL(env->reqs[index])) {
+		err = (env->reqs[index] == NULL ? -ENOMEM :
+						PTR_ERR(env->reqs[index]));
+		env->reqs[index] = NULL;
+
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("no data for the page: "
+				  "index %d\n", index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to issue request: "
+				  "index %d, err %d\n",
+				  index, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			SetPageError(page);
+			zero_user_segment(page, 0, PAGE_SIZE);
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+		}
+	} else
+		env->count++;
+
+	return err;
+}
+
+/*
+ * The ssdfs_readahead() is called by the VM to read pages
+ * associated with the address_space object. The pages are
+ * consecutive in the page cache and are locked.
+ * The implementation should decrement the page refcount
+ * after starting I/O on each page. Usually the page will be
+ * unlocked by the I/O completion handler. The ssdfs_readahead()
+ * is only used for read-ahead, so read errors are ignored.
+ */
+static
+void ssdfs_readahead(struct readahead_control *rac)
+{
+	struct inode *inode = file_inode(rac->file);
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+	struct ssdfs_readahead_env env;
+	struct page *page;
+	unsigned i;
+	int res;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, nr_pages %u\n",
+		  file_inode(rac->file)->i_ino, readahead_count(rac));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_ssdfs_file_inline(ii)) {
+		/* do nothing */
+		return;
+	}
+
+	env.file = rac->file;
+	env.count = 0;
+	env.capacity = readahead_count(rac);
+
+	env.reqs = ssdfs_file_kcalloc(readahead_count(rac),
+				  sizeof(struct ssdfs_segment_request *),
+				  GFP_KERNEL);
+	if (!env.reqs) {
+		SSDFS_ERR("fail to allocate requests array\n");
+		return;
+	}
+
+	while ((page = readahead_page(rac))) {
+		prefetchw(&page->flags);
+		err = ssdfs_readahead_page((void *)&env, page);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to process page: "
+				  "index %u, err %d\n",
+				  env.count, err);
+			break;
+		}
+	};
+
+	for (i = 0; i < readahead_count(rac); i++) {
+		res = ssdfs_wait_read_request_end(env.reqs[i]);
+		if (res) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("waiting has finished with issue: "
+				  "index %u, err %d\n",
+				  i, res);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		if (err == 0)
+			err = res;
+
+		env.reqs[i] = NULL;
+	}
+
+	if (env.reqs)
+		ssdfs_file_kfree(env.reqs);
+
+	if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("readahead fails: "
+			  "ino %lu, nr_pages %u, err %d\n",
+			  file_inode(rac->file)->i_ino,
+			  readahead_count(rac), err);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return;
+}
+
+/*
+ * ssdfs_update_block() - update block.
+ * @fsi: pointer on shared file system object
+ * @req: request object
+ */
+static
+int ssdfs_update_block(struct ssdfs_fs_info *fsi,
+		       struct ssdfs_segment_request *req,
+		       struct writeback_control *wbc)
+{
+	struct ssdfs_segment_info *si;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+	BUG_ON((req->extent.logical_offset >> fsi->log_pagesize) >= U32_MAX);
+
+	SSDFS_DBG("fsi %p, req %p\n", fsi, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_prepare_volume_extent(fsi, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare volume extent: "
+			  "ino %llu, logical_offset %llu, "
+			  "data_bytes %u, cno %llu, "
+			  "parent_snapshot %llu, err %d\n",
+			  req->extent.ino,
+			  req->extent.logical_offset,
+			  req->extent.data_bytes,
+			  req->extent.cno,
+			  req->extent.parent_snapshot,
+			  err);
+		return err;
+	}
+
+	req->place.len = 1;
+
+	si = ssdfs_grab_segment(fsi, SSDFS_USER_DATA_SEG_TYPE,
+				req->place.start.seg_id, U64_MAX);
+	if (unlikely(IS_ERR_OR_NULL(si))) {
+		SSDFS_ERR("fail to grab segment object: "
+			  "seg %llu, err %d\n",
+			  req->place.start.seg_id, err);
+		return PTR_ERR(si);
+	}
+
+	if (wbc->sync_mode == WB_SYNC_NONE) {
+		err = ssdfs_segment_update_block_async(si,
+						       SSDFS_REQ_ASYNC,
+						       req);
+	} else if (wbc->sync_mode == WB_SYNC_ALL)
+		err = ssdfs_segment_update_block_sync(si, req);
+	else
+		BUG();
+
+	if (unlikely(err)) {
+		SSDFS_ERR("update request failed: "
+			  "ino %llu, logical_offset %llu, size %u, err %d\n",
+			  req->extent.ino, req->extent.logical_offset,
+			  req->extent.data_bytes, err);
+		return err;
+	}
+
+	ssdfs_segment_put_object(si);
+
+	return 0;
+}
+
+/*
+ * ssdfs_update_extent() - update extent.
+ * @fsi: pointer on shared file system object
+ * @req: request object
+ */
+static
+int ssdfs_update_extent(struct ssdfs_fs_info *fsi,
+			struct ssdfs_segment_request *req,
+			struct writeback_control *wbc)
+{
+	struct ssdfs_segment_info *si;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+	BUG_ON((req->extent.logical_offset >> fsi->log_pagesize) >= U32_MAX);
+
+	SSDFS_DBG("fsi %p, req %p\n", fsi, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_prepare_volume_extent(fsi, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to prepare volume extent: "
+			  "ino %llu, logical_offset %llu, "
+			  "data_bytes %u, cno %llu, "
+			  "parent_snapshot %llu, err %d\n",
+			  req->extent.ino,
+			  req->extent.logical_offset,
+			  req->extent.data_bytes,
+			  req->extent.cno,
+			  req->extent.parent_snapshot,
+			  err);
+		return err;
+	}
+
+	si = ssdfs_grab_segment(fsi, SSDFS_USER_DATA_SEG_TYPE,
+				req->place.start.seg_id, U64_MAX);
+	if (unlikely(IS_ERR_OR_NULL(si))) {
+		SSDFS_ERR("fail to grab segment object: "
+			  "seg %llu, err %d\n",
+			  req->place.start.seg_id, err);
+		return PTR_ERR(si);
+	}
+
+	if (wbc->sync_mode == WB_SYNC_NONE) {
+		err = ssdfs_segment_update_extent_async(si,
+							SSDFS_REQ_ASYNC,
+							req);
+	} else if (wbc->sync_mode == WB_SYNC_ALL)
+		err = ssdfs_segment_update_extent_sync(si, req);
+	else
+		BUG();
+
+	if (unlikely(err)) {
+		SSDFS_ERR("update request failed: "
+			  "ino %llu, logical_offset %llu, size %u, err %d\n",
+			  req->extent.ino, req->extent.logical_offset,
+			  req->extent.data_bytes, err);
+		return err;
+	}
+
+	ssdfs_segment_put_object(si);
+
+	return 0;
+}
+
+static
+int ssdfs_issue_async_block_write_request(struct writeback_control *wbc,
+					  struct ssdfs_segment_request **req)
+{
+	struct page *page;
+	struct inode *inode;
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *etree;
+	struct ssdfs_fs_info *fsi;
+	ino_t ino;
+	u64 logical_offset;
+	u32 data_bytes;
+	u64 seg_id = U64_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!wbc || !req || !*req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(&(*req)->result.pvec) == 0) {
+		SSDFS_ERR("pagevec is empty\n");
+		return -ERANGE;
+	}
+
+	page = (*req)->result.pvec.pages[0];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode = page->mapping->host;
+	ii = SSDFS_I(inode);
+	fsi = SSDFS_FS_I(inode->i_sb);
+	ino = inode->i_ino;
+	logical_offset = (*req)->extent.logical_offset;
+	data_bytes = (*req)->extent.data_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, logical_offset %llu, "
+		  "data_bytes %u, sync_mode %#x\n",
+		  ino, logical_offset, data_bytes, wbc->sync_mode);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (need_add_block(page)) {
+		struct ssdfs_blk2off_range extent;
+
+		err = ssdfs_segment_add_data_block_async(fsi, *req,
+							 &seg_id,
+							 &extent);
+		if (!err) {
+			err = ssdfs_extents_tree_add_extent(inode, *req);
+			if (err) {
+				SSDFS_ERR("fail to add extent: "
+					  "ino %lu, page_index %llu, "
+					  "err %d\n",
+					  ino, (u64)page_index(page),
+					  err);
+				return err;
+			}
+
+			inode_add_bytes(inode, fsi->pagesize);
+		}
+	} else {
+		err = ssdfs_update_block(fsi, *req, wbc);
+		seg_id = (*req)->place.start.seg_id;
+	}
+
+	if (err) {
+		SSDFS_ERR("fail to write page async: "
+			  "ino %lu, page_index %llu, err %d\n",
+			  ino, (u64)page_index(page), err);
+		return err;
+	}
+
+	etree = SSDFS_EXTREE(ii);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!etree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&etree->lock);
+	err = ssdfs_extents_tree_add_updated_seg_id(etree, seg_id);
+	up_write(&etree->lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add updated segment in queue: "
+			  "seg_id %llu, err %d\n",
+			  seg_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static
+int ssdfs_issue_sync_block_write_request(struct writeback_control *wbc,
+					 struct ssdfs_segment_request **req)
+{
+	struct page *page;
+	struct inode *inode;
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *etree;
+	struct ssdfs_fs_info *fsi;
+	ino_t ino;
+	u64 logical_offset;
+	u32 data_bytes;
+	u64 seg_id = U64_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!wbc || !req || !*req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(&(*req)->result.pvec) == 0) {
+		SSDFS_ERR("pagevec is empty\n");
+		return -ERANGE;
+	}
+
+	page = (*req)->result.pvec.pages[0];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode = page->mapping->host;
+	ii = SSDFS_I(inode);
+	fsi = SSDFS_FS_I(inode->i_sb);
+	ino = inode->i_ino;
+	logical_offset = (*req)->extent.logical_offset;
+	data_bytes = (*req)->extent.data_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, logical_offset %llu, "
+		  "data_bytes %u, sync_mode %#x\n",
+		  ino, logical_offset, data_bytes, wbc->sync_mode);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (need_add_block(page)) {
+		struct ssdfs_blk2off_range extent;
+
+		err = ssdfs_segment_add_data_block_sync(fsi, *req,
+							&seg_id,
+							&extent);
+		if (!err) {
+			err = ssdfs_extents_tree_add_extent(inode, *req);
+			if (!err)
+				inode_add_bytes(inode, fsi->pagesize);
+		}
+	} else {
+		err = ssdfs_update_block(fsi, *req, wbc);
+		seg_id = (*req)->place.start.seg_id;
+	}
+
+	if (err) {
+		SSDFS_ERR("fail to write page sync: "
+			  "ino %lu, page_index %llu, err %d\n",
+			  ino, (u64)page_index(page), err);
+		return err;
+	}
+
+	etree = SSDFS_EXTREE(ii);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!etree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&etree->lock);
+	err = ssdfs_extents_tree_add_updated_seg_id(etree, seg_id);
+	up_write(&etree->lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add updated segment in queue: "
+			  "seg_id %llu, err %d\n",
+			  seg_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static
+int ssdfs_issue_async_extent_write_request(struct writeback_control *wbc,
+					   struct ssdfs_segment_request **req)
+{
+	struct page *page;
+	struct inode *inode;
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *etree;
+	struct ssdfs_fs_info *fsi;
+	ino_t ino;
+	u64 logical_offset;
+	u32 data_bytes;
+	u64 seg_id = U64_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!wbc || !req || !*req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(&(*req)->result.pvec) == 0) {
+		SSDFS_ERR("pagevec is empty\n");
+		return -ERANGE;
+	}
+
+	page = (*req)->result.pvec.pages[0];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode = page->mapping->host;
+	ii = SSDFS_I(inode);
+	fsi = SSDFS_FS_I(inode->i_sb);
+	ino = inode->i_ino;
+	logical_offset = (*req)->extent.logical_offset;
+	data_bytes = (*req)->extent.data_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, logical_offset %llu, "
+		  "data_bytes %u, sync_mode %#x\n",
+		  ino, logical_offset, data_bytes, wbc->sync_mode);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (need_add_block(page)) {
+		struct ssdfs_blk2off_range extent;
+
+		err = ssdfs_segment_add_data_extent_async(fsi, *req,
+							  &seg_id,
+							  &extent);
+		if (!err) {
+			u32 extent_bytes = data_bytes;
+
+			err = ssdfs_extents_tree_add_extent(inode, *req);
+			if (err) {
+				SSDFS_ERR("fail to add extent: "
+					  "ino %lu, page_index %llu, "
+					  "err %d\n",
+					  ino, (u64)page_index(page), err);
+				return err;
+			}
+
+			if (fsi->pagesize > PAGE_SIZE)
+				extent_bytes += fsi->pagesize - 1;
+			else if (fsi->pagesize <= PAGE_SIZE)
+				extent_bytes += PAGE_SIZE - 1;
+
+			extent_bytes >>= fsi->log_pagesize;
+			extent_bytes <<= fsi->log_pagesize;
+
+			inode_add_bytes(inode, extent_bytes);
+		}
+	} else {
+		err = ssdfs_update_extent(fsi, *req, wbc);
+		seg_id = (*req)->place.start.seg_id;
+	}
+
+	if (err) {
+		SSDFS_ERR("fail to write extent async: "
+			  "ino %lu, page_index %llu, err %d\n",
+			  ino, (u64)page_index(page), err);
+		return err;
+	}
+
+	etree = SSDFS_EXTREE(ii);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!etree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&etree->lock);
+	err = ssdfs_extents_tree_add_updated_seg_id(etree, seg_id);
+	up_write(&etree->lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add updated segment in queue: "
+			  "seg_id %llu, err %d\n",
+			  seg_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static
+int ssdfs_issue_sync_extent_write_request(struct writeback_control *wbc,
+					  struct ssdfs_segment_request **req)
+{
+	struct page *page;
+	struct inode *inode;
+	struct ssdfs_inode_info *ii;
+	struct ssdfs_extents_btree_info *etree;
+	struct ssdfs_fs_info *fsi;
+	ino_t ino;
+	u64 logical_offset;
+	u32 data_bytes;
+	u64 seg_id = U64_MAX;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!wbc || !req || !*req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_count(&(*req)->result.pvec) == 0) {
+		SSDFS_ERR("pagevec is empty\n");
+		return -ERANGE;
+	}
+
+	page = (*req)->result.pvec.pages[0];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode = page->mapping->host;
+	ii = SSDFS_I(inode);
+	fsi = SSDFS_FS_I(inode->i_sb);
+	ino = inode->i_ino;
+	logical_offset = (*req)->extent.logical_offset;
+	data_bytes = (*req)->extent.data_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, logical_offset %llu, "
+		  "data_bytes %u, sync_mode %#x\n",
+		  ino, logical_offset, data_bytes, wbc->sync_mode);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (need_add_block(page)) {
+		struct ssdfs_blk2off_range extent;
+
+		err = ssdfs_segment_add_data_extent_sync(fsi, *req,
+							 &seg_id,
+							 &extent);
+		if (!err) {
+			u32 extent_bytes = data_bytes;
+
+			err = ssdfs_extents_tree_add_extent(inode, *req);
+			if (err) {
+				SSDFS_ERR("fail to add extent: "
+					  "ino %lu, page_index %llu, "
+					  "err %d\n",
+					  ino, (u64)page_index(page), err);
+				return err;
+			}
+
+			if (fsi->pagesize > PAGE_SIZE)
+				extent_bytes += fsi->pagesize - 1;
+			else if (fsi->pagesize <= PAGE_SIZE)
+				extent_bytes += PAGE_SIZE - 1;
+
+			extent_bytes >>= fsi->log_pagesize;
+			extent_bytes <<= fsi->log_pagesize;
+
+			inode_add_bytes(inode, extent_bytes);
+		}
+	} else {
+		err = ssdfs_update_extent(fsi, *req, wbc);
+		seg_id = (*req)->place.start.seg_id;
+	}
+
+	if (err) {
+		SSDFS_ERR("fail to write page sync: "
+			  "ino %lu, page_index %llu, err %d\n",
+			  ino, (u64)page_index(page), err);
+		return err;
+	}
+
+	etree = SSDFS_EXTREE(ii);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!etree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&etree->lock);
+	err = ssdfs_extents_tree_add_updated_seg_id(etree, seg_id);
+	up_write(&etree->lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add updated segment in queue: "
+			  "seg_id %llu, err %d\n",
+			  seg_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static
+int ssdfs_issue_write_request(struct writeback_control *wbc,
+			      struct ssdfs_segment_request **req,
+			      int req_type)
+{
+	struct ssdfs_fs_info *fsi;
+	struct inode *inode;
+	struct page *page;
+	ino_t ino;
+	u64 logical_offset;
+	u32 data_bytes;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!wbc || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!*req) {
+		SSDFS_ERR("empty segment request\n");
+		return -ERANGE;
+	}
+
+	if (pagevec_count(&(*req)->result.pvec) == 0) {
+		SSDFS_ERR("pagevec is empty\n");
+		return -ERANGE;
+	}
+
+	page = (*req)->result.pvec.pages[0];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode = page->mapping->host;
+	fsi = SSDFS_FS_I(inode->i_sb);
+	ino = inode->i_ino;
+	logical_offset = (*req)->extent.logical_offset;
+	data_bytes = (*req)->extent.data_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, logical_offset %llu, "
+		  "data_bytes %u, sync_mode %#x\n",
+		  ino, logical_offset, data_bytes, wbc->sync_mode);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < pagevec_count(&(*req)->result.pvec); i++) {
+		page = (*req)->result.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		set_page_writeback(page);
+		ssdfs_clear_dirty_page(page);
+	}
+
+	if (wbc->sync_mode == WB_SYNC_NONE) {
+		if (req_type == SSDFS_BLOCK_BASED_REQUEST)
+			err = ssdfs_issue_async_block_write_request(wbc, req);
+		else if (req_type == SSDFS_EXTENT_BASED_REQUEST)
+			err = ssdfs_issue_async_extent_write_request(wbc, req);
+		else
+			BUG();
+
+		if (err) {
+			SSDFS_ERR("fail to write async: "
+				  "ino %lu, err %d\n",
+				  ino, err);
+				goto fail_issue_write_request;
+		}
+
+		wake_up_all(&fsi->pending_wq);
+
+		/*
+		 * Async request is completely managed by flush thread.
+		 * Forget request because next request will be allocated.
+		 */
+		*req = NULL;
+	} else if (wbc->sync_mode == WB_SYNC_ALL) {
+		if (req_type == SSDFS_BLOCK_BASED_REQUEST)
+			err = ssdfs_issue_sync_block_write_request(wbc, req);
+		else if (req_type == SSDFS_EXTENT_BASED_REQUEST)
+			err = ssdfs_issue_sync_extent_write_request(wbc, req);
+		else
+			BUG();
+
+		if (err) {
+			SSDFS_ERR("fail to write sync: "
+				  "ino %lu, err %d\n",
+				  ino, err);
+				goto fail_issue_write_request;
+		}
+
+		wake_up_all(&fsi->pending_wq);
+
+		err = SSDFS_WAIT_COMPLETION(&(*req)->result.wait);
+		if (unlikely(err)) {
+			SSDFS_ERR("write request failed: "
+				  "ino %lu, logical_offset %llu, size %u, "
+				  "err %d\n",
+				  ino, (u64)logical_offset,
+				  (u32)data_bytes, err);
+			goto fail_issue_write_request;
+		}
+
+		if ((*req)->result.err) {
+			err = (*req)->result.err;
+			SSDFS_ERR("write request failed: "
+				  "ino %lu, logical_offset %llu, size %u, "
+				  "err %d\n",
+				  ino, (u64)logical_offset, (u32)data_bytes,
+				  (*req)->result.err);
+			goto fail_issue_write_request;
+		}
+
+		for (i = 0; i < pagevec_count(&(*req)->result.pvec); i++) {
+			page = (*req)->result.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			clear_page_new(page);
+			SetPageUptodate(page);
+			ssdfs_clear_dirty_page(page);
+
+			ssdfs_unlock_page(page);
+			end_page_writeback(page);
+		}
+
+		ssdfs_put_request(*req);
+		ssdfs_request_free(*req);
+		*req = NULL;
+	} else
+		BUG();
+
+	return 0;
+
+fail_issue_write_request:
+	if (wbc->sync_mode == WB_SYNC_ALL) {
+		for (i = 0; i < pagevec_count(&(*req)->result.pvec); i++) {
+			page = (*req)->result.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (!PageLocked(page)) {
+				SSDFS_WARN("page %p, PageLocked %#x\n",
+					   page, PageLocked(page));
+				ssdfs_lock_page(page);
+			}
+
+			clear_page_new(page);
+			SetPageUptodate(page);
+			ClearPageDirty(page);
+
+			ssdfs_unlock_page(page);
+			end_page_writeback(page);
+		}
+
+		ssdfs_put_request(*req);
+		ssdfs_request_free(*req);
+	}
+
+	return err;
+}
+
+static
+int __ssdfs_writepage(struct page *page, u32 len,
+		      struct writeback_control *wbc,
+		      struct ssdfs_segment_request **req)
+{
+	struct inode *inode = page->mapping->host;
+	ino_t ino = inode->i_ino;
+	pgoff_t index = page_index(page);
+	loff_t logical_offset;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, page_index %llu, len %u, sync_mode %#x\n",
+		  ino, (u64)index, len, wbc->sync_mode);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*req = ssdfs_request_alloc();
+	if (IS_ERR_OR_NULL(*req)) {
+		err = (*req == NULL ? -ENOMEM : PTR_ERR(*req));
+		SSDFS_ERR("fail to allocate segment request: err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_request_init(*req);
+	ssdfs_get_request(*req);
+
+	(*req)->private.flags |= SSDFS_REQ_DONT_FREE_PAGES;
+
+	logical_offset = (loff_t)index << PAGE_SHIFT;
+	ssdfs_request_prepare_logical_extent(ino, (u64)logical_offset,
+					     len, 0, 0, *req);
+
+	err = ssdfs_request_add_page(page, *req);
+	if (err) {
+		SSDFS_ERR("fail to add page into request: "
+			  "ino %lu, page_index %lu, err %d\n",
+			  ino, index, err);
+		goto free_request;
+	}
+
+	return ssdfs_issue_write_request(wbc, req, SSDFS_BLOCK_BASED_REQUEST);
+
+free_request:
+	ssdfs_put_request(*req);
+	ssdfs_request_free(*req);
+
+	return err;
+}
+
+static
+int __ssdfs_writepages(struct page *page, u32 len,
+			struct writeback_control *wbc,
+			struct ssdfs_segment_request **req)
+{
+	struct inode *inode = page->mapping->host;
+	ino_t ino = inode->i_ino;
+	pgoff_t index = page_index(page);
+	loff_t logical_offset;
+	bool need_create_request;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, page_index %llu, len %u, sync_mode %#x\n",
+		  ino, (u64)index, len, wbc->sync_mode);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_offset = (loff_t)index << PAGE_SHIFT;
+
+try_add_page_into_request:
+	need_create_request = *req == NULL;
+
+	if (need_create_request) {
+		*req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(*req)) {
+			err = (*req == NULL ? -ENOMEM : PTR_ERR(*req));
+			SSDFS_ERR("fail to allocate segment request: err %d\n",
+				  err);
+			goto fail_write_pages;
+		}
+
+		ssdfs_request_init(*req);
+		ssdfs_get_request(*req);
+
+		(*req)->private.flags |= SSDFS_REQ_DONT_FREE_PAGES;
+
+		err = ssdfs_request_add_page(page, *req);
+		if (err) {
+			SSDFS_ERR("fail to add page into request: "
+				  "ino %lu, page_index %lu, err %d\n",
+				  ino, index, err);
+			goto free_request;
+		}
+
+		ssdfs_request_prepare_logical_extent(ino, (u64)logical_offset,
+						     len, 0, 0, *req);
+	} else {
+		u64 upper_bound = (*req)->extent.logical_offset +
+					(*req)->extent.data_bytes;
+		u32 last_index;
+		struct page *last_page;
+
+		if (pagevec_count(&(*req)->result.pvec) == 0) {
+			err = -ERANGE;
+			SSDFS_WARN("pagevec is empty\n");
+			goto free_request;
+		}
+
+		last_index = pagevec_count(&(*req)->result.pvec) - 1;
+		last_page = (*req)->result.pvec.pages[last_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_offset %llu, upper_bound %llu, "
+			  "last_index %u\n",
+			  (u64)logical_offset, upper_bound, last_index);
+
+		BUG_ON(!last_page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (logical_offset == upper_bound &&
+		    can_be_merged_into_extent(last_page, page)) {
+			err = ssdfs_request_add_page(page, *req);
+			if (err) {
+				err = ssdfs_issue_write_request(wbc, req,
+						    SSDFS_EXTENT_BASED_REQUEST);
+				if (err)
+					goto fail_write_pages;
+
+				*req = NULL;
+				goto try_add_page_into_request;
+			}
+
+			(*req)->extent.data_bytes += len;
+		} else {
+			err = ssdfs_issue_write_request(wbc, req,
+						    SSDFS_EXTENT_BASED_REQUEST);
+			if (err)
+				goto fail_write_pages;
+
+			*req = NULL;
+			goto try_add_page_into_request;
+		}
+	}
+
+	return 0;
+
+free_request:
+	ssdfs_put_request(*req);
+	ssdfs_request_free(*req);
+
+fail_write_pages:
+	return err;
+}
+
+/* writepage function prototype */
+typedef int (*ssdfs_writepagefn)(struct page *page, u32 len,
+				 struct writeback_control *wbc,
+				 struct ssdfs_segment_request **req);
+
+static
+int ssdfs_writepage_wrapper(struct page *page,
+			    struct writeback_control *wbc,
+			    struct ssdfs_segment_request **req,
+			    ssdfs_writepagefn writepage)
+{
+	struct inode *inode = page->mapping->host;
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+	ino_t ino = inode->i_ino;
+	pgoff_t index = page_index(page);
+	loff_t i_size = i_size_read(inode);
+	pgoff_t end_index = i_size >> PAGE_SHIFT;
+	int len = i_size & (PAGE_SIZE - 1);
+	loff_t cur_blk;
+	bool is_new_blk = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, page_index %llu, "
+		  "i_size %llu, len %d\n",
+		  ino, (u64)index,
+		  (u64)i_size, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (inode->i_sb->s_flags & SB_RDONLY) {
+		/*
+		 * It means that filesystem was remounted in read-only
+		 * mode because of error or metadata corruption. But we
+		 * have dirty pages that try to be flushed in background.
+		 * So, here we simply discard this dirty page.
+		 */
+		err = -EROFS;
+		goto discard_page;
+	}
+
+	/* Is the page fully outside @i_size? (truncate in progress) */
+	if (index > end_index || (index == end_index && !len)) {
+		err = 0;
+		goto finish_write_page;
+	}
+
+	if (is_ssdfs_file_inline(ii)) {
+		size_t inline_capacity =
+				ssdfs_inode_inline_file_capacity(inode);
+
+		if (len > inline_capacity) {
+			err = -ENOSPC;
+			SSDFS_ERR("len %d is greater capacity %zu\n",
+				  len, inline_capacity);
+			goto discard_page;
+		}
+
+		set_page_writeback(page);
+
+		err = ssdfs_memcpy_from_page(ii->inline_file,
+					     0, inline_capacity,
+					     page,
+					     0, PAGE_SIZE,
+					     len);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy file's content: "
+				  "err %d\n", err);
+			goto discard_page;
+		}
+
+		inode_add_bytes(inode, len);
+
+		clear_page_new(page);
+		SetPageUptodate(page);
+		ClearPageDirty(page);
+
+		ssdfs_unlock_page(page);
+		end_page_writeback(page);
+
+		return 0;
+	}
+
+	cur_blk = (index << PAGE_SHIFT) >> fsi->log_pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_blk %llu\n", (u64)cur_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!need_add_block(page)) {
+		is_new_blk = !ssdfs_extents_tree_has_logical_block(cur_blk,
+								   inode);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cur_blk %llu, is_new_blk %#x\n",
+			  (u64)cur_blk, is_new_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (is_new_blk)
+			set_page_new(page);
+	}
+
+	/* Is the page fully inside @i_size? */
+	if (index < end_index) {
+		err = (*writepage)(page, PAGE_SIZE, wbc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(inode->i_sb, __FILE__,
+					__func__, __LINE__,
+					"fail to write page: "
+					"ino %lu, page_index %llu, err %d\n",
+					ino, (u64)index, err);
+			goto discard_page;
+		}
+
+		return 0;
+	}
+
+	/*
+	 * The page straddles @i_size. It must be zeroed out on each and every
+	 * writepage invocation because it may be mmapped. "A file is mapped
+	 * in multiples of the page size. For a file that is not a multiple of
+	 * the page size, the remaining memory is zeroed when mapped, and
+	 * writes to that region are not written out to the file."
+	 */
+	zero_user_segment(page, len, PAGE_SIZE);
+
+	err = (*writepage)(page, len, wbc, req);
+	if (unlikely(err)) {
+		ssdfs_fs_error(inode->i_sb, __FILE__,
+				__func__, __LINE__,
+				"fail to write page: "
+				"ino %lu, page_index %llu, err %d\n",
+				ino, (u64)index, err);
+		goto discard_page;
+	}
+
+	return 0;
+
+finish_write_page:
+	ssdfs_unlock_page(page);
+
+discard_page:
+	return err;
+}
+
+/*
+ * The ssdfs_writepage() is called by the VM to write
+ * a dirty page to backing store. This may happen for data
+ * integrity reasons (i.e. 'sync'), or to free up memory
+ * (flush). The difference can be seen in wbc->sync_mode.
+ */
+static
+int ssdfs_writepage(struct page *page, struct writeback_control *wbc)
+{
+	struct ssdfs_segment_request *req = NULL;
+#ifdef CONFIG_SSDFS_DEBUG
+	struct inode *inode = page->mapping->host;
+	ino_t ino = inode->i_ino;
+	pgoff_t index = page_index(page);
+
+	SSDFS_DBG("ino %lu, page_index %llu\n",
+		  ino, (u64)index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ssdfs_writepage_wrapper(page, wbc, &req,
+					__ssdfs_writepage);
+}
+
+/*
+ * The ssdfs_writepages() is called by the VM to write out pages associated
+ * with the address_space object. If wbc->sync_mode is WBC_SYNC_ALL, then
+ * the writeback_control will specify a range of pages that must be
+ * written out.  If it is WBC_SYNC_NONE, then a nr_to_write is given
+ * and that many pages should be written if possible.
+ * If no ->writepages is given, then mpage_writepages is used
+ * instead.  This will choose pages from the address space that are
+ * tagged as DIRTY and will pass them to ->writepage.
+ */
+static
+int ssdfs_writepages(struct address_space *mapping,
+		     struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+	ino_t ino = inode->i_ino;
+	struct ssdfs_segment_request *req = NULL;
+	struct pagevec pvec;
+	int nr_pages;
+	pgoff_t index = 0;
+	pgoff_t end;		/* Inclusive */
+	pgoff_t done_index = 0;
+	int range_whole = 0;
+	int tag;
+	int i;
+	int done = 0;
+	int ret = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, nr_to_write %lu, "
+		  "range_start %llu, range_end %llu, "
+		  "writeback_index %llu, "
+		  "wbc->range_cyclic %#x\n",
+		  ino, wbc->nr_to_write,
+		  (u64)wbc->range_start,
+		  (u64)wbc->range_end,
+		  (u64)mapping->writeback_index,
+		  wbc->range_cyclic);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	/*
+	 * No pages to write?
+	 */
+	if (!mapping->nrpages || !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
+		goto out_writepages;
+
+	pagevec_init(&pvec);
+
+	if (wbc->range_cyclic) {
+		index = mapping->writeback_index; /* prev offset */
+		end = -1;
+	} else {
+		index = wbc->range_start >> PAGE_SHIFT;
+		end = wbc->range_end >> PAGE_SHIFT;
+		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
+			range_whole = 1;
+	}
+
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
+		tag = PAGECACHE_TAG_TOWRITE;
+		tag_pages_for_writeback(mapping, index, end);
+	} else
+		tag = PAGECACHE_TAG_DIRTY;
+
+	done_index = index;
+
+	while (!done && (index <= end)) {
+		nr_pages = (int)min_t(pgoff_t, end - index,
+					(pgoff_t)PAGEVEC_SIZE-1) + 1;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index %llu, end %llu, "
+			  "nr_pages %d, tag %#x\n",
+			  (u64)index, (u64)end, nr_pages, tag);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index,
+						    end, tag);
+		if (nr_pages == 0)
+			break;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("FOUND: nr_pages %d\n", nr_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		for (i = 0; i < nr_pages; i++) {
+			struct page *page = pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, index %d, page->index %ld\n",
+				  page, i, page->index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			/*
+			 * At this point, the page may be truncated or
+			 * invalidated (changing page->mapping to NULL), or
+			 * even swizzled back from swapper_space to tmpfs file
+			 * mapping. However, page->index will not change
+			 * because we have a reference on the page.
+			 */
+			if (page->index > end) {
+				/*
+				 * can't be range_cyclic (1st pass) because
+				 * end == -1 in that case.
+				 */
+				done = 1;
+				break;
+			}
+
+			done_index = page->index + 1;
+
+			ssdfs_lock_page(page);
+
+			/*
+			 * Page truncated or invalidated. We can freely skip it
+			 * then, even for data integrity operations: the page
+			 * has disappeared concurrently, so there could be no
+			 * real expectation of this data interity operation
+			 * even if there is now a new, dirty page at the same
+			 * pagecache address.
+			 */
+			if (unlikely(page->mapping != mapping)) {
+continue_unlock:
+				ssdfs_unlock_page(page);
+				continue;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, index %d, page->index %ld, "
+				  "PageLocked %#x, PageDirty %#x, "
+				  "PageWriteback %#x\n",
+				  page, i, page->index,
+				  PageLocked(page), PageDirty(page),
+				  PageWriteback(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (!PageDirty(page)) {
+				/* someone wrote it for us */
+				goto continue_unlock;
+			}
+
+			if (PageWriteback(page)) {
+				if (wbc->sync_mode != WB_SYNC_NONE)
+					wait_on_page_writeback(page);
+				else
+					goto continue_unlock;
+			}
+
+			BUG_ON(PageWriteback(page));
+			if (!clear_page_dirty_for_io(page))
+				goto continue_unlock;
+
+			ret = ssdfs_writepage_wrapper(page, wbc, &req,
+						      __ssdfs_writepages);
+			if (unlikely(ret)) {
+				if (ret == -EROFS) {
+					/*
+					 * continue to discard pages
+					 */
+				} else {
+					/*
+					 * done_index is set past this page,
+					 * so media errors will not choke
+					 * background writeout for the entire
+					 * file. This has consequences for
+					 * range_cyclic semantics (ie. it may
+					 * not be suitable for data integrity
+					 * writeout).
+					 */
+					done_index = page->index + 1;
+					done = 1;
+					break;
+				}
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, index %d, page->index %ld, "
+				  "PageLocked %#x, PageDirty %#x, "
+				  "PageWriteback %#x\n",
+				  page, i, page->index,
+				  PageLocked(page), PageDirty(page),
+				  PageWriteback(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			/*
+			 * We stop writing back only if we are not doing
+			 * integrity sync. In case of integrity sync we have to
+			 * keep going until we have written all the pages
+			 * we tagged for writeback prior to entering this loop.
+			 */
+			if (--wbc->nr_to_write <= 0 &&
+			    wbc->sync_mode == WB_SYNC_NONE) {
+				done = 1;
+				break;
+			}
+		}
+
+		if (!is_ssdfs_file_inline(ii)) {
+			ret = ssdfs_issue_write_request(wbc, &req,
+						SSDFS_EXTENT_BASED_REQUEST);
+			if (ret < 0) {
+				SSDFS_ERR("ino %lu, nr_to_write %lu, "
+					  "range_start %llu, range_end %llu, "
+					  "writeback_index %llu, "
+					  "wbc->range_cyclic %#x, "
+					  "index %llu, end %llu, "
+					  "done_index %llu\n",
+					  ino, wbc->nr_to_write,
+					  (u64)wbc->range_start,
+					  (u64)wbc->range_end,
+					  (u64)mapping->writeback_index,
+					  wbc->range_cyclic,
+					  (u64)index, (u64)end,
+					  (u64)done_index);
+
+				for (i = 0; i < pagevec_count(&pvec); i++) {
+					struct page *page;
+
+					page = pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+					BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+					SSDFS_ERR("page %p, index %d, "
+						  "page->index %ld, "
+						  "PageLocked %#x, "
+						  "PageDirty %#x, "
+						  "PageWriteback %#x\n",
+						  page, i, page->index,
+						  PageLocked(page),
+						  PageDirty(page),
+						  PageWriteback(page));
+				}
+
+				goto out_writepages;
+			}
+		}
+
+		index = done_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index %llu, end %llu, nr_to_write %lu\n",
+			  (u64)index, (u64)end, wbc->nr_to_write);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		pagevec_reinit(&pvec);
+		cond_resched();
+	};
+
+	/*
+	 * If we hit the last page and there is more work to be done: wrap
+	 * back the index back to the start of the file for the next
+	 * time we are called.
+	 */
+	if (wbc->range_cyclic && !done)
+		done_index = 0;
+
+out_writepages:
+	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
+		mapping->writeback_index = done_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, nr_to_write %lu, "
+		  "range_start %llu, range_end %llu, "
+		  "writeback_index %llu\n",
+		  ino, wbc->nr_to_write,
+		  (u64)wbc->range_start,
+		  (u64)wbc->range_end,
+		  (u64)mapping->writeback_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return ret;
+}
+
+static void ssdfs_write_failed(struct address_space *mapping, loff_t to)
+{
+	struct inode *inode = mapping->host;
+
+	if (to > inode->i_size)
+		truncate_pagecache(inode, inode->i_size);
+}
+
+/*
+ * The ssdfs_write_begin() is called by the generic
+ * buffered write code to ask the filesystem to prepare
+ * to write len bytes at the given offset in the file.
+ */
+static
+int ssdfs_write_begin(struct file *file, struct address_space *mapping,
+		      loff_t pos, unsigned len,
+		      struct page **pagep, void **fsdata)
+{
+	struct inode *inode = mapping->host;
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(inode->i_sb);
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+	struct page *page;
+	pgoff_t index = pos >> PAGE_SHIFT;
+	unsigned blks = 0;
+	loff_t start_blk, end_blk, cur_blk;
+	u64 last_blk = U64_MAX;
+#ifdef CONFIG_SSDFS_DEBUG
+	u64 free_pages = 0;
+#endif /* CONFIG_SSDFS_DEBUG */
+	bool is_new_blk = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, pos %llu, len %u\n",
+		  inode->i_ino, pos, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (inode->i_sb->s_flags & SB_RDONLY)
+		return -EROFS;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, index %lu\n",
+		  inode->i_ino, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page = grab_cache_page_write_begin(mapping, index);
+	if (!page) {
+		SSDFS_ERR("fail to grab page: index %lu\n",
+			  index);
+		return -ENOMEM;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_account_locked_page(page);
+
+	if (can_file_be_inline(inode, pos + len)) {
+		if (!ii->inline_file) {
+			err = ssdfs_allocate_inline_file_buffer(inode);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to allocate inline buffer\n");
+				goto try_regular_write;
+			}
+
+			/*
+			 * TODO: pre-fetch file's content in buffer
+			 *       (if inode size > 256 bytes)
+			 */
+		}
+
+		atomic_or(SSDFS_INODE_HAS_INLINE_FILE,
+			  &SSDFS_I(inode)->private_flags);
+	} else {
+try_regular_write:
+		atomic_and(~SSDFS_INODE_HAS_INLINE_FILE,
+			   &SSDFS_I(inode)->private_flags);
+
+		start_blk = pos >> fsi->log_pagesize;
+		end_blk = (pos + len) >> fsi->log_pagesize;
+
+		if (can_file_be_inline(inode, i_size_read(inode))) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("change from inline to regular file: "
+				  "old_size %llu, new_size %llu\n",
+				  (u64)i_size_read(inode),
+				  (u64)(pos + len));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			last_blk = U64_MAX;
+		} else if (i_size_read(inode) > 0) {
+			last_blk = (i_size_read(inode) - 1) >>
+						fsi->log_pagesize;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_blk %llu, end_blk %llu, last_blk %llu\n",
+			  (u64)start_blk, (u64)end_blk,
+			  (u64)last_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		cur_blk = start_blk;
+		do {
+			if (last_blk >= U64_MAX)
+				is_new_blk = true;
+			else
+				is_new_blk = cur_blk > last_blk;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cur_blk %llu, is_new_blk %#x, blks %u\n",
+				  (u64)cur_blk, is_new_blk, blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (is_new_blk) {
+				if (!need_add_block(page)) {
+					set_page_new(page);
+					err = ssdfs_reserve_free_pages(fsi, 1,
+							SSDFS_USER_DATA_PAGES);
+					if (!err)
+						blks++;
+				}
+
+#ifdef CONFIG_SSDFS_DEBUG
+				spin_lock(&fsi->volume_state_lock);
+				free_pages = fsi->free_pages;
+				spin_unlock(&fsi->volume_state_lock);
+
+				SSDFS_DBG("free_pages %llu, blks %u, err %d\n",
+					  free_pages, blks, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+				if (err) {
+					spin_lock(&fsi->volume_state_lock);
+					fsi->free_pages += blks;
+					spin_unlock(&fsi->volume_state_lock);
+
+					ssdfs_unlock_page(page);
+					ssdfs_put_page(page);
+
+					ssdfs_write_failed(mapping, pos + len);
+
+#ifdef CONFIG_SSDFS_DEBUG
+					SSDFS_DBG("page %p, count %d\n",
+						  page, page_ref_count(page));
+					SSDFS_DBG("volume hasn't free space\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+					return err;
+				}
+			} else if (!PageDirty(page)) {
+				/*
+				 * ssdfs_write_end() marks page as dirty
+				 */
+				ssdfs_account_updated_user_data_pages(fsi, 1);
+			}
+
+			cur_blk++;
+		} while (cur_blk < end_blk);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*pagep = page;
+
+	if ((len == PAGE_SIZE) || PageUptodate(page))
+		return 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pos %llu, inode_size %llu\n",
+		  pos, (u64)i_size_read(inode));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((pos & PAGE_MASK) >= i_size_read(inode)) {
+		unsigned start = pos & (PAGE_SIZE - 1);
+		unsigned end = start + len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start %u, end %u, len %u\n",
+			  start, end, len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		/* Reading beyond i_size is simple: memset to zero */
+		zero_user_segments(page, 0, start, end, PAGE_SIZE);
+		return 0;
+	}
+
+	return ssdfs_readpage_nolock(file, page, SSDFS_CURRENT_THREAD_READ);
+}
+
+/*
+ * After a successful ssdfs_write_begin(), and data copy,
+ * ssdfs_write_end() must be called.
+ */
+static
+int ssdfs_write_end(struct file *file, struct address_space *mapping,
+		    loff_t pos, unsigned len, unsigned copied,
+		    struct page *page, void *fsdata)
+{
+	struct inode *inode = mapping->host;
+	pgoff_t index = page->index;
+	unsigned start = pos & (PAGE_SIZE - 1);
+	unsigned end = start + copied;
+	loff_t old_size = i_size_read(inode);
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, pos %llu, len %u, copied %u, "
+		  "index %lu, start %u, end %u, old_size %llu\n",
+		  inode->i_ino, pos, len, copied,
+		  index, start, end, old_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (copied < len) {
+		/*
+		 * VFS copied less data to the page that it intended and
+		 * declared in its '->write_begin()' call via the @len
+		 * argument. Just tell userspace to retry the entire page.
+		 */
+		if (!PageUptodate(page)) {
+			copied = 0;
+			goto out;
+		}
+	}
+
+	if (old_size < (index << PAGE_SHIFT) + end) {
+		i_size_write(inode, (index << PAGE_SHIFT) + end);
+		mark_inode_dirty_sync(inode);
+	}
+
+	flush_dcache_page(page);
+
+	SetPageUptodate(page);
+	if (!PageDirty(page))
+		__set_page_dirty_nobuffers(page);
+
+out:
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err ? err : copied;
+}
+
+/*
+ * The ssdfs_direct_IO() is called by the generic read/write
+ * routines to perform direct_IO - that is IO requests which
+ * bypass the page cache and transfer data directly between
+ * the storage and the application's address space.
+ */
+static ssize_t ssdfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	/* TODO: implement */
+	return -ERANGE;
+}
+
+/*
+ * The ssdfs_fsync() is called by the fsync(2) system call.
+ */
+int ssdfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct inode *inode = file->f_mapping->host;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %lu, start %llu, end %llu, datasync %#x\n",
+		  (unsigned long)inode->i_ino, (unsigned long long)start,
+		  (unsigned long long)end, datasync);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	trace_ssdfs_sync_file_enter(inode);
+
+	err = filemap_write_and_wait_range(inode->i_mapping, start, end);
+	if (err) {
+		trace_ssdfs_sync_file_exit(file, datasync, err);
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fsync failed: ino %lu, start %llu, "
+			  "end %llu, err %d\n",
+			  (unsigned long)inode->i_ino,
+			  (unsigned long long)start,
+			  (unsigned long long)end,
+			  err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	}
+
+	inode_lock(inode);
+	sync_inode_metadata(inode, 1);
+	blkdev_issue_flush(inode->i_sb->s_bdev);
+	inode_unlock(inode);
+
+	trace_ssdfs_sync_file_exit(file, datasync, err);
+
+	return err;
+}
+
+const struct file_operations ssdfs_file_operations = {
+	.llseek		= generic_file_llseek,
+	.read_iter	= generic_file_read_iter,
+	.write_iter	= generic_file_write_iter,
+	.unlocked_ioctl	= ssdfs_ioctl,
+	.mmap		= generic_file_mmap,
+	.open		= generic_file_open,
+	.fsync		= ssdfs_fsync,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
+};
+
+const struct inode_operations ssdfs_file_inode_operations = {
+	.getattr	= ssdfs_getattr,
+	.setattr	= ssdfs_setattr,
+	.listxattr	= ssdfs_listxattr,
+	.get_inode_acl	= ssdfs_get_acl,
+	.set_acl	= ssdfs_set_acl,
+};
+
+const struct inode_operations ssdfs_special_inode_operations = {
+	.setattr	= ssdfs_setattr,
+	.listxattr	= ssdfs_listxattr,
+	.get_inode_acl	= ssdfs_get_acl,
+	.set_acl	= ssdfs_set_acl,
+};
+
+const struct inode_operations ssdfs_symlink_inode_operations = {
+	.get_link	= page_get_link,
+	.getattr	= ssdfs_getattr,
+	.setattr	= ssdfs_setattr,
+	.listxattr	= ssdfs_listxattr,
+};
+
+const struct address_space_operations ssdfs_aops = {
+	.read_folio		= ssdfs_read_folio,
+	.readahead		= ssdfs_readahead,
+	.writepage		= ssdfs_writepage,
+	.writepages		= ssdfs_writepages,
+	.write_begin		= ssdfs_write_begin,
+	.write_end		= ssdfs_write_end,
+	.direct_IO		= ssdfs_direct_IO,
+};
-- 
2.34.1


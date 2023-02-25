Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583026A263F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBYBRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBYBQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:31 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D749C15142
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:26 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id o12so802829oik.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZrMueduaHlrNnwqrIXonCbfUTBWboBtLdItB0mqdHU=;
        b=ADYiF+NUl2S6EHqCopcK7zkBITVAgxe3fhBzMXWu0kY540dOS1b9iCTvypD2f4Cvjt
         vdF7hrqLLieUBRvXfd3SBKF/2AojC9soq+YSK0t92gVUhGRiAFAQztCMJXjyifXJl22T
         QC4S6Kq0hs1MMzKnOOVRkNwKpebPirentntc0llnO5qP0uUXA+7i67Tmy7VsPrwhUDAY
         AcXgbCrLveMYhttR13H2XVJ3IITr9RpMXCtE7N+Qr+fZcnOd022cir6IbaB9DSL4GVMq
         hif3wd6IepmBhCIH7414r0Qyt4j5Be8BGa3rnPI9E/MeerhOt7sWhzidRuq7FOivnTP2
         Hd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZrMueduaHlrNnwqrIXonCbfUTBWboBtLdItB0mqdHU=;
        b=p9N8MLG0VEX6kVU4ZLegT5w3Y6gCtvJYGKpLJSVefemrY0oRNv3DgT2+RE0wGFpPI+
         ZFnT1islSlCIeHhO2nMuBvpO8Eg1bsehCYICBJURAcUvMeZJhSw/Q+GiakpPLaZHH/eE
         iPUxzFJSnpLIdJCMyuTMp4phN/YOgL4O5gmVLCiAFPADGG26AQKXgPTi6xT8a1c2+4IM
         E7ZYQZs1orUudhpthew2c8bLcRdqi8KsNdIUv6bJXidhBcV8WxoVZlLBTCN4PleKVDwK
         FDV5fCUTpMcM2crLyYf27JPZO/7eFf+CeO3qmJ56JrTBMNDC+sKDfpNNXLaNaJn3Y9Nu
         /EcQ==
X-Gm-Message-State: AO0yUKWaEI9p7x0zT1KHfascjGA2c6YkD4qvDaCplcvFWbv5ettlo66u
        SIlTw9BLvLhH0qGgQ9NgLmyFZXFxZCCcXhuw
X-Google-Smtp-Source: AK7set9Y44IHRYOTu5DEqVccsAejoCWWoPLzy4GgOZwALeCjsmTNaA4ZEniPxkGPWLaS2Xy9tcg3TQ==
X-Received: by 2002:aca:1010:0:b0:384:111a:54bb with SMTP id 16-20020aca1010000000b00384111a54bbmr308604oiq.36.1677287785331;
        Fri, 24 Feb 2023 17:16:25 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:24 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 24/76] ssdfs: PEB read thread's init logic
Date:   Fri, 24 Feb 2023 17:08:35 -0800
Message-Id: <20230225010927.813929-25-slava@dubeyko.com>
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

"Physical" Erase Block (PEB) container has read thread.
This thread is used to execute:
(1) background PEB initialization logic
(2) background readahead
(3) free PEB object's cache memory pages in background

This patch implements finite state machine of read thread
and declare main command that read thread can process.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_read_thread.c | 3053 ++++++++++++++++++++++++++++++++++++
 1 file changed, 3053 insertions(+)
 create mode 100644 fs/ssdfs/peb_read_thread.c

diff --git a/fs/ssdfs/peb_read_thread.c b/fs/ssdfs/peb_read_thread.c
new file mode 100644
index 000000000000..c5087373df8d
--- /dev/null
+++ b/fs/ssdfs/peb_read_thread.c
@@ -0,0 +1,3053 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_read_thread.c - read thread functionality.
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
+#include "peb_mapping_table.h"
+#include "extents_queue.h"
+#include "request_queue.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "diff_on_write.h"
+#include "shared_extents_tree.h"
+#include "invalidated_extents_tree.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_read_page_leaks;
+atomic64_t ssdfs_read_memory_leaks;
+atomic64_t ssdfs_read_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_read_cache_leaks_increment(void *kaddr)
+ * void ssdfs_read_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_read_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_read_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_read_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_read_kfree(void *kaddr)
+ * struct page *ssdfs_read_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_read_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_read_free_page(struct page *page)
+ * void ssdfs_read_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(read)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(read)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_read_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_read_page_leaks, 0);
+	atomic64_set(&ssdfs_read_memory_leaks, 0);
+	atomic64_set(&ssdfs_read_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_read_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_read_page_leaks) != 0) {
+		SSDFS_ERR("READ THREAD: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_read_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_read_memory_leaks) != 0) {
+		SSDFS_ERR("READ THREAD: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_read_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_read_cache_leaks) != 0) {
+		SSDFS_ERR("READ THREAD: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_read_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * struct ssdfs_segbmap_extent - segbmap extent
+ * @logical_offset: logical offset inside of segbmap's content
+ * @data_size: requested data size
+ * @fragment_size: fragment size of segbmap
+ */
+struct ssdfs_segbmap_extent {
+	u64 logical_offset;
+	u32 data_size;
+	u16 fragment_size;
+};
+
+static
+void ssdfs_prepare_blk_bmap_init_env(struct ssdfs_blk_bmap_init_env *env,
+				     u32 pages_per_peb)
+{
+	size_t bmap_bytes;
+	size_t bmap_pages;
+
+	memset(env->bmap_hdr_buf, 0, SSDFS_BLKBMAP_HDR_CAPACITY);
+	env->bmap_hdr = (struct ssdfs_block_bitmap_header *)env->bmap_hdr_buf;
+	env->frag_hdr =
+		(struct ssdfs_block_bitmap_fragment *)(env->bmap_hdr_buf +
+				    sizeof(struct ssdfs_block_bitmap_header));
+	env->fragment_index = -1;
+
+	bmap_bytes = BLK_BMAP_BYTES(pages_per_peb);
+	bmap_pages = (bmap_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+	ssdfs_page_vector_create(&env->array, bmap_pages);
+
+	env->read_bytes = 0;
+}
+
+static void
+ssdfs_prepare_blk2off_table_init_env(struct ssdfs_blk2off_table_init_env *env)
+{
+	memset(&env->tbl_hdr, 0, sizeof(struct ssdfs_blk2off_table_header));
+	pagevec_init(&env->pvec);
+	env->blk2off_tbl_hdr_off = 0;
+	env->read_off = 0;
+	env->write_off = 0;
+}
+
+static void
+ssdfs_prepare_blk_desc_table_init_env(struct ssdfs_blk_desc_table_init_env *env)
+{
+	pagevec_init(&env->pvec);
+	env->compressed_buf = NULL;
+	env->buf_size = 0;
+	env->read_off = 0;
+	env->write_off = 0;
+}
+
+static
+int ssdfs_prepare_read_init_env(struct ssdfs_read_init_env *env,
+				u32 pages_per_peb)
+{
+	size_t hdr_size;
+	size_t footer_buf_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("env %p\n", env);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr_size = sizeof(struct ssdfs_segment_header);
+	hdr_size = max_t(size_t, hdr_size, (size_t)SSDFS_4KB);
+
+	env->log_hdr = ssdfs_read_kzalloc(hdr_size, GFP_KERNEL);
+	if (!env->log_hdr) {
+		SSDFS_ERR("fail to allocate log header buffer\n");
+		return -ENOMEM;
+	}
+
+	env->has_seg_hdr = false;
+
+	footer_buf_size = max_t(size_t, hdr_size,
+				sizeof(struct ssdfs_log_footer));
+	env->footer = ssdfs_read_kzalloc(footer_buf_size, GFP_KERNEL);
+	if (!env->footer) {
+		SSDFS_ERR("fail to allocate log footer buffer\n");
+		return -ENOMEM;
+	}
+
+	env->has_footer = false;
+
+	env->cur_migration_id = -1;
+	env->prev_migration_id = -1;
+
+	env->log_offset = 0;
+	env->log_pages = U32_MAX;
+	env->log_bytes = U32_MAX;
+
+	ssdfs_prepare_blk_bmap_init_env(&env->b_init, pages_per_peb);
+	ssdfs_prepare_blk2off_table_init_env(&env->t_init);
+	ssdfs_prepare_blk_desc_table_init_env(&env->bdt_init);
+
+	return 0;
+}
+
+static
+void ssdfs_destroy_init_env(struct ssdfs_read_init_env *env)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("env %p\n", env);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (env->log_hdr)
+		ssdfs_read_kfree(env->log_hdr);
+
+	env->log_hdr = NULL;
+	env->has_seg_hdr = false;
+
+	if (env->footer)
+		ssdfs_read_kfree(env->footer);
+
+	env->footer = NULL;
+	env->has_footer = false;
+
+	ssdfs_page_vector_release(&env->b_init.array);
+	ssdfs_page_vector_destroy(&env->b_init.array);
+
+	ssdfs_read_pagevec_release(&env->t_init.pvec);
+	ssdfs_read_pagevec_release(&env->bdt_init.pvec);
+
+	if (env->bdt_init.compressed_buf)
+		ssdfs_read_kfree(env->bdt_init.compressed_buf);
+}
+
+static
+int ssdfs_read_blk2off_table_fragment(struct ssdfs_peb_info *pebi,
+				      struct ssdfs_read_init_env *env);
+
+/******************************************************************************
+ *                          READ THREAD FUNCTIONALITY                         *
+ ******************************************************************************/
+
+/*
+ * ssdfs_find_prev_partial_log() - find previous partial log
+ * @fsi: file system info object
+ * @pebi: pointer on PEB object
+ * @env: read operation's init environment [in|out]
+ * @log_diff: offset for logs processing
+ *
+ * This function tries to find a previous partial log.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EIO        - I/O error.
+ * %-ENOENT     - unable to find any log.
+ */
+static
+int ssdfs_find_prev_partial_log(struct ssdfs_fs_info *fsi,
+				struct ssdfs_peb_info *pebi,
+				struct ssdfs_read_init_env *env,
+				int log_diff)
+{
+	struct ssdfs_signature *magic = NULL;
+	struct ssdfs_segment_header *seg_hdr = NULL;
+	struct ssdfs_partial_log_header *pl_hdr = NULL;
+	struct ssdfs_log_footer *footer = NULL;
+	struct page *page;
+	void *kaddr;
+	size_t hdr_buf_size = sizeof(struct ssdfs_segment_header);
+	int start_offset;
+	int skipped_logs = 0;
+	int i;
+	int err = -ENOENT;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pebi || !pebi->pebc || !env);
+
+	SSDFS_DBG("seg %llu, peb %llu, peb_index %u, "
+		  "log_offset %u, log_diff %d\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, pebi->peb_index,
+		  env->log_offset, log_diff);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (env->log_offset > fsi->pages_per_peb) {
+		SSDFS_ERR("log_offset %u > pages_per_peb %u\n",
+			  env->log_offset, fsi->pages_per_peb);
+		return -ERANGE;
+	} else if (env->log_offset == fsi->pages_per_peb)
+		env->log_offset--;
+
+	start_offset = env->log_offset;
+
+	if (log_diff > 0) {
+		SSDFS_ERR("invalid log_diff %d\n", log_diff);
+		return -EINVAL;
+	}
+
+	if (env->log_offset == 0) {
+		SSDFS_DBG("previous log is absent\n");
+		return -ENOENT;
+	}
+
+	for (i = start_offset; i >= 0; i--) {
+		page = ssdfs_page_array_get_page_locked(&pebi->cache, i);
+		if (IS_ERR_OR_NULL(page)) {
+			if (page == NULL) {
+				SSDFS_ERR("fail to get page: "
+					  "index %d\n",
+					  i);
+				return -ERANGE;
+			} else {
+				err = PTR_ERR(page);
+
+				if (err == -ENOENT)
+					continue;
+				else {
+					SSDFS_ERR("fail to get page: "
+						  "index %d, err %d\n",
+						  i, err);
+					return err;
+				}
+			}
+		}
+
+		kaddr = kmap_local_page(page);
+		ssdfs_memcpy(env->log_hdr, 0, hdr_buf_size,
+			     kaddr, 0, PAGE_SIZE,
+			     hdr_buf_size);
+		ssdfs_memcpy(env->footer, 0, hdr_buf_size,
+			     kaddr, 0, PAGE_SIZE,
+			     hdr_buf_size);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		magic = (struct ssdfs_signature *)env->log_hdr;
+
+		if (__is_ssdfs_segment_header_magic_valid(magic)) {
+			seg_hdr = SSDFS_SEG_HDR(env->log_hdr);
+
+			err = ssdfs_check_segment_header(fsi, seg_hdr,
+							 false);
+			if (unlikely(err)) {
+				SSDFS_ERR("log header is corrupted: "
+					  "seg %llu, peb %llu, index %u\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id,
+					  i);
+				return -EIO;
+			}
+
+			if (start_offset == i) {
+				/*
+				 * Requested starting log_offset points out
+				 * on segment header. It needs to skip this
+				 * header because of searching the previous
+				 * log.
+				 */
+				continue;
+			}
+
+			env->has_seg_hdr = true;
+			env->has_footer = ssdfs_log_has_footer(seg_hdr);
+			env->log_offset = (u16)i;
+
+			if (skipped_logs > log_diff) {
+				skipped_logs--;
+				err = -ENOENT;
+				continue;
+			} else {
+				/* log has been found */
+				err = 0;
+				goto finish_prev_log_search;
+			}
+		} else if (is_ssdfs_partial_log_header_magic_valid(magic)) {
+			u32 flags;
+
+			pl_hdr = SSDFS_PLH(env->log_hdr);
+
+			err = ssdfs_check_partial_log_header(fsi, pl_hdr,
+							     false);
+			if (unlikely(err)) {
+				SSDFS_ERR("partial log header is corrupted: "
+					  "seg %llu, peb %llu, index %u\n",
+					  pebi->pebc->parent_si->seg_id,
+					  pebi->peb_id,
+					  i);
+				return -EIO;
+			}
+
+			env->has_seg_hdr = false;
+			env->has_footer = ssdfs_pl_has_footer(pl_hdr);
+
+			env->log_bytes =
+				le32_to_cpu(pl_hdr->log_bytes);
+
+			flags = le32_to_cpu(pl_hdr->pl_flags);
+
+			if (flags & SSDFS_PARTIAL_HEADER_INSTEAD_FOOTER) {
+				/* first partial log */
+				err = -ENOENT;
+				continue;
+			} else if (flags & SSDFS_LOG_HAS_FOOTER) {
+				/* last partial log */
+				if (start_offset == i) {
+					/*
+					 * Requested starting log_offset
+					 * points out on segment header.
+					 * It needs to skip this header
+					 * because of searching the previous
+					 * log.
+					 */
+					continue;
+				}
+
+				env->log_offset = (u16)i;
+
+				if (skipped_logs > log_diff) {
+					skipped_logs--;
+					err = -ENOENT;
+					continue;
+				} else {
+					/* log has been found */
+					err = 0;
+					goto finish_prev_log_search;
+				}
+			} else {
+				/* intermediate partial log */
+				if (start_offset == i) {
+					/*
+					 * Requested starting log_offset
+					 * points out on segment header.
+					 * It needs to skip this header
+					 * because of searching the previous
+					 * log.
+					 */
+					continue;
+				}
+
+				env->log_offset = (u16)i;
+
+				if (skipped_logs > log_diff) {
+					skipped_logs--;
+					err = -ENOENT;
+					continue;
+				} else {
+					/* log has been found */
+					err = 0;
+					goto finish_prev_log_search;
+				}
+			}
+		} else if (__is_ssdfs_log_footer_magic_valid(magic)) {
+			footer = SSDFS_LF(env->footer);
+
+			env->log_bytes =
+				le32_to_cpu(footer->log_bytes);
+			continue;
+		} else {
+			err = -ENOENT;
+			continue;
+		}
+	}
+
+finish_prev_log_search:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("log_offset %u, log_bytes %u\n",
+		  env->log_offset,
+		  env->log_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_complete_init_blk2off_table() - init blk2off table's fragment
+ * @pebi: pointer on PEB object
+ * @log_diff: offset for logs processing
+ * @req: read request
+ *
+ * This function tries to init blk2off table's fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_peb_complete_init_blk2off_table(struct ssdfs_peb_info *pebi,
+					  int log_diff,
+					  struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_blk2off_table *blk2off_table = NULL;
+	u64 cno;
+	unsigned long last_page_idx;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+	BUG_ON(!req);
+
+	SSDFS_DBG("seg %llu, peb %llu, log_diff %d, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, log_diff,
+		  req->private.class,
+		  req->private.cmd,
+		  req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	blk2off_table = pebi->pebc->parent_si->blk2off_table;
+
+	switch (atomic_read(&blk2off_table->state)) {
+	case SSDFS_BLK2OFF_OBJECT_COMPLETE_INIT:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("blk2off table has been initialized: "
+			  "peb_id %llu\n",
+			  pebi->peb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+
+	default:
+		/* continue to init blk2off table */
+		break;
+	}
+
+	err = ssdfs_prepare_read_init_env(&pebi->env, fsi->pages_per_peb);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init read environment: err %d\n",
+			  err);
+		return err;
+	}
+
+	last_page_idx = ssdfs_page_array_get_last_page_index(&pebi->cache);
+
+	if (last_page_idx >= SSDFS_PAGE_ARRAY_INVALID_LAST_PAGE) {
+		SSDFS_ERR("empty page array: last_page_idx %lu\n",
+			  last_page_idx);
+		return -ERANGE;
+	}
+
+	if (last_page_idx >= fsi->pages_per_peb) {
+		SSDFS_ERR("corrupted page array: "
+			  "last_page_idx %lu, fsi->pages_per_peb %u\n",
+			  last_page_idx, fsi->pages_per_peb);
+		return -ERANGE;
+	}
+
+	pebi->env.log_offset = (u32)last_page_idx + 1;
+
+	do {
+		err = ssdfs_find_prev_partial_log(fsi, pebi,
+						  &pebi->env, log_diff);
+		if (err == -ENOENT) {
+			if (pebi->env.log_offset > 0) {
+				SSDFS_ERR("fail to find prev log: "
+					  "log_offset %u, err %d\n",
+					  pebi->env.log_offset, err);
+				goto fail_init_blk2off_table;
+			} else {
+				/* no previous log exists */
+				err = 0;
+				SSDFS_DBG("no previous log exists\n");
+				goto fail_init_blk2off_table;
+			}
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find prev log: "
+				  "log_offset %u, err %d\n",
+				  pebi->env.log_offset, err);
+			goto fail_init_blk2off_table;
+		}
+
+		err = ssdfs_pre_fetch_blk2off_table_area(pebi, &pebi->env);
+		if (err == -ENOENT) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("blk2off table's fragment is absent: "
+				  "seg %llu, peb %llu, log_offset %u\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  pebi->env.log_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto try_next_log;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to pre-fetch blk2off_table area: "
+				  "seg %llu, peb %llu, log_offset %u, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  pebi->env.log_offset,
+				  err);
+			goto fail_init_blk2off_table;
+		}
+
+		err = ssdfs_pre_fetch_blk_desc_table_area(pebi, &pebi->env);
+		if (err == -ENOENT) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("blk desc table's fragment is absent: "
+				  "seg %llu, peb %llu, log_offset %u\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  pebi->env.log_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto try_next_log;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to pre-fetch blk desc table area: "
+				  "seg %llu, peb %llu, log_offset %u, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  pebi->env.log_offset,
+				  err);
+			goto fail_init_blk2off_table;
+		}
+
+		err = ssdfs_read_blk2off_table_fragment(pebi, &pebi->env);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read translation table fragments: "
+				  "seg %llu, peb %llu, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, err);
+			goto fail_init_blk2off_table;
+		}
+
+		if (pebi->env.has_seg_hdr) {
+			struct ssdfs_segment_header *seg_hdr = NULL;
+
+			seg_hdr = SSDFS_SEG_HDR(pebi->env.log_hdr);
+			cno = le64_to_cpu(seg_hdr->cno);
+		} else {
+			struct ssdfs_partial_log_header *pl_hdr = NULL;
+
+			pl_hdr = SSDFS_PLH(pebi->env.log_hdr);
+			cno = le64_to_cpu(pl_hdr->cno);
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg_id %llu, peb %llu, "
+			  "env.log_offset %u\n",
+			  pebi->pebc->parent_si->seg_id, pebi->peb_id,
+			  pebi->env.log_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_blk2off_table_partial_init(blk2off_table,
+						       &pebi->env.t_init.pvec,
+						       &pebi->env.bdt_init.pvec,
+						       pebi->peb_index,
+						       cno);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to start init of offset table: "
+				  "seg %llu, peb %llu, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id, err);
+			goto fail_init_blk2off_table;
+		}
+
+try_next_log:
+		ssdfs_read_pagevec_release(&pebi->env.t_init.pvec);
+		ssdfs_read_pagevec_release(&pebi->env.bdt_init.pvec);
+		log_diff = 0;
+	} while (pebi->env.log_offset > 0);
+
+fail_init_blk2off_table:
+	ssdfs_destroy_init_env(&pebi->env);
+	return err;
+}
+
+/*
+ * ssdfs_start_complete_init_blk2off_table() - start to init blk2off table
+ * @pebi: pointer on PEB object
+ * @req: read request
+ *
+ * This function tries to start the initialization of blk2off table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_start_complete_init_blk2off_table(struct ssdfs_peb_info *pebi,
+					    struct ssdfs_segment_request *req)
+{
+	int log_diff = -1;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !req);
+
+	SSDFS_DBG("peb_id %llu, peb_index %u\n",
+		  pebi->peb_id, pebi->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&pebi->current_log.state)) {
+	case SSDFS_LOG_INITIALIZED:
+	case SSDFS_LOG_CREATED:
+	case SSDFS_LOG_COMMITTED:
+		/*
+		 * The last log was processed during initialization of
+		 * "using" or "used" PEB. So, it needs to process the
+		 * log before the last one.
+		 */
+		log_diff = -1;
+		break;
+
+	default:
+		/*
+		 * It needs to process the last log.
+		 */
+		log_diff = 0;
+		break;
+	}
+
+	err = ssdfs_peb_complete_init_blk2off_table(pebi, log_diff, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to complete blk2off table init: "
+			  "peb_id %llu, peb_index %u, "
+			  "log_diff %d, err %d\n",
+			  pebi->peb_id, pebi->peb_index,
+			  log_diff, err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_finish_complete_init_blk2off_table() - finish to init blk2off table
+ * @pebi: pointer on PEB object
+ * @req: read request
+ *
+ * This function tries to finish the initialization of blk2off table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_finish_complete_init_blk2off_table(struct ssdfs_peb_info *pebi,
+					     struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_maptbl_peb_relation pebr;
+	struct completion *end;
+	struct ssdfs_maptbl_peb_descriptor *ptr;
+	u64 leb_id;
+	int log_diff = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !req);
+	BUG_ON(!pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi);
+
+	SSDFS_DBG("peb_id %llu, peb_index %u\n",
+		  pebi->peb_id, pebi->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+
+	leb_id = ssdfs_get_leb_id_for_peb_index(fsi,
+				pebi->pebc->parent_si->seg_id,
+				pebi->peb_index);
+	if (leb_id == U64_MAX) {
+		SSDFS_ERR("fail to convert PEB index into LEB ID: "
+			  "seg %llu, peb_index %u\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_index);
+		return -ERANGE;
+	}
+
+	err = ssdfs_maptbl_convert_leb2peb(fsi, leb_id,
+					   pebi->pebc->peb_type,
+					   &pebr, &end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_maptbl_convert_leb2peb(fsi, leb_id,
+						   pebi->pebc->peb_type,
+						   &pebr, &end);
+	}
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("LEB is not mapped: leb_id %llu\n",
+			  leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to convert LEB to PEB: "
+			  "leb_id %llu, peb_type %#x, err %d\n",
+			  leb_id, pebi->pebc->peb_type, err);
+		return err;
+	}
+
+	ptr = &pebr.pebs[SSDFS_MAPTBL_MAIN_INDEX];
+
+	if (ptr->peb_id != pebi->peb_id) {
+		SSDFS_ERR("ptr->peb_id %llu != pebi->peb_id %llu\n",
+			  ptr->peb_id, pebi->peb_id);
+		return -ERANGE;
+	}
+
+	switch (ptr->state) {
+	case SSDFS_MAPTBL_MIGRATION_SRC_DIRTY_STATE:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("ignore PEB: peb_id %llu, state %#x\n",
+			  pebi->peb_id, ptr->state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
+	switch (atomic_read(&pebi->current_log.state)) {
+	case SSDFS_LOG_INITIALIZED:
+	case SSDFS_LOG_CREATED:
+	case SSDFS_LOG_COMMITTED:
+		/*
+		 * It needs to process the last log of source PEB.
+		 * The destination PEB has been/will be processed
+		 * in a real pair.
+		 */
+		log_diff = 0;
+		break;
+
+	default:
+		/*
+		 * It needs to process the last log.
+		 */
+		log_diff = 0;
+		break;
+	}
+
+	err = ssdfs_peb_complete_init_blk2off_table(pebi, log_diff, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to complete blk2off table init: "
+			  "peb_id %llu, peb_index %u, "
+			  "log_diff %d, err %d\n",
+			  pebi->peb_id, pebi->peb_index, log_diff, err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_src_peb_complete_init_blk2off_table() - init src PEB's blk2off table
+ * @pebi: pointer on PEB object
+ * @req: read request
+ *
+ * This function tries to init the source PEB's blk2off table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_src_peb_complete_init_blk2off_table(struct ssdfs_peb_container *pebc,
+					      struct ssdfs_segment_request *req)
+{
+	struct ssdfs_peb_info *pebi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	down_read(&pebc->lock);
+
+	pebi = pebc->src_peb;
+	if (!pebi) {
+		SSDFS_WARN("source PEB is NULL\n");
+		err = -ERANGE;
+		goto finish_src_peb_init_blk2off_table;
+	}
+
+	err = ssdfs_start_complete_init_blk2off_table(pebi, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to complete blk2off table init: "
+			  "seg_id %llu, peb_index %u, "
+			  "err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index,
+			  err);
+		goto finish_src_peb_init_blk2off_table;
+	}
+
+finish_src_peb_init_blk2off_table:
+	up_read(&pebc->lock);
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
+ * ssdfs_dst_peb_complete_init_blk2off_table() - init dst PEB's blk2off table
+ * @pebi: pointer on PEB object
+ * @req: read request
+ *
+ * This function tries to init the destination PEB's blk2off table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EIO        - I/O error.
+ */
+static
+int ssdfs_dst_peb_complete_init_blk2off_table(struct ssdfs_peb_container *pebc,
+					      struct ssdfs_segment_request *req)
+{
+	struct ssdfs_peb_info *pebi;
+	int items_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#else
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	down_read(&pebc->lock);
+
+	items_state = atomic_read(&pebc->items_state);
+	switch (items_state) {
+	case SSDFS_PEB1_DST_CONTAINER:
+	case SSDFS_PEB2_DST_CONTAINER:
+		pebi = pebc->dst_peb;
+		if (!pebi) {
+			SSDFS_WARN("destination PEB is NULL\n");
+			err = -ERANGE;
+			goto finish_dst_peb_init_blk2off_table;
+		}
+
+		err = ssdfs_start_complete_init_blk2off_table(pebi, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to complete blk2off table init: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  err);
+			goto finish_dst_peb_init_blk2off_table;
+		}
+		break;
+
+	case SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER:
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			SSDFS_WARN("source PEB is NULL\n");
+			err = -ERANGE;
+			goto finish_dst_peb_init_blk2off_table;
+		}
+
+		err = ssdfs_finish_complete_init_blk2off_table(pebi, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to complete blk2off table init: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  err);
+			goto finish_dst_peb_init_blk2off_table;
+		}
+		break;
+
+	case SSDFS_PEB1_SRC_PEB2_DST_CONTAINER:
+	case SSDFS_PEB2_SRC_PEB1_DST_CONTAINER:
+		pebi = pebc->dst_peb;
+		if (!pebi) {
+			SSDFS_WARN("destination PEB is NULL\n");
+			err = -ERANGE;
+			goto finish_dst_peb_init_blk2off_table;
+		}
+
+		err = ssdfs_start_complete_init_blk2off_table(pebi, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to complete blk2off table init: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  err);
+			goto finish_dst_peb_init_blk2off_table;
+		}
+
+		pebi = pebc->src_peb;
+		if (!pebi) {
+			SSDFS_WARN("source PEB is NULL\n");
+			err = -ERANGE;
+			goto finish_dst_peb_init_blk2off_table;
+		}
+
+		err = ssdfs_finish_complete_init_blk2off_table(pebi, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to complete blk2off table init: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index,
+				  err);
+			goto finish_dst_peb_init_blk2off_table;
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+finish_dst_peb_init_blk2off_table:
+	up_read(&pebc->lock);
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
+ * ssdfs_peb_define_segbmap_seg_index() - define segbmap segment index
+ * @pebc: pointer on PEB container
+ *
+ * RETURN:
+ * [success] - segbmap segment index
+ * [failure] - U16_MAX
+ */
+static
+u16 ssdfs_peb_define_segbmap_seg_index(struct ssdfs_peb_container *pebc)
+{
+	struct ssdfs_segment_bmap *segbmap;
+	int seg_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!pebc->parent_si->fsi->segbmap);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	segbmap = pebc->parent_si->fsi->segbmap;
+
+	down_read(&segbmap->resize_lock);
+
+	seg_index = ssdfs_segbmap_seg_id_2_seg_index(segbmap,
+						     pebc->parent_si->seg_id);
+	if (seg_index < 0) {
+		SSDFS_ERR("fail to convert seg_id %llu, err %d\n",
+			  pebc->parent_si->seg_id, seg_index);
+		seg_index = U16_MAX;
+	}
+
+	up_read(&segbmap->resize_lock);
+
+	return (u16)seg_index;
+}
+
+/*
+ * ssdfs_peb_define_segbmap_sequence_id() - define fragment's sequence ID
+ * @pebc: pointer on PEB container
+ * @seg_index: index of segment in segbmap's segments sequence
+ * @logical_offset: logical offset
+ *
+ * RETURN:
+ * [success] - sequence ID
+ * [failure] - U16_MAX
+ */
+static
+u16 ssdfs_peb_define_segbmap_sequence_id(struct ssdfs_peb_container *pebc,
+					 u16 seg_index,
+					 u64 logical_offset)
+{
+	struct ssdfs_segment_bmap *segbmap;
+	u16 peb_index;
+	u16 fragments_per_seg;
+	u16 fragment_size;
+	u32 fragments_bytes_per_seg;
+	u64 seg_logical_offset;
+	u32 id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!pebc->parent_si->fsi->segbmap);
+
+	SSDFS_DBG("seg_id %llu, seg_index %u, "
+		  "peb_index %u, logical_offset %llu\n",
+		  pebc->parent_si->seg_id, seg_index,
+		  pebc->peb_index, logical_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	segbmap = pebc->parent_si->fsi->segbmap;
+	peb_index = pebc->peb_index;
+
+	down_read(&segbmap->resize_lock);
+	fragments_per_seg = segbmap->fragments_per_seg;
+	fragment_size = segbmap->fragment_size;
+	fragments_bytes_per_seg =
+		(u32)segbmap->fragments_per_seg * fragment_size;
+	up_read(&segbmap->resize_lock);
+
+	seg_logical_offset = (u64)seg_index * fragments_bytes_per_seg;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_index %u, seg_logical_offset %llu, "
+		  "logical_offset %llu\n",
+		  seg_index, seg_logical_offset,
+		  logical_offset);
+
+	BUG_ON(seg_logical_offset > logical_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_offset -= seg_logical_offset;
+
+	id = logical_offset / fragment_size;
+	id += seg_index * fragments_per_seg;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_index %u, fragments_per_seg %u, "
+		  "logical_offset %llu, fragment_size %u, "
+		  "id %u\n",
+		  seg_index, fragments_per_seg,
+		  logical_offset, fragment_size,
+		  id);
+
+	BUG_ON(id >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u16)id;
+}
+
+/*
+ * ssdfs_peb_define_segbmap_logical_extent() - define logical extent
+ * @pebc: pointer on PEB container
+ * @seg_index: index of segment in segment bitmap
+ * @ptr: pointer on segbmap extent [out]
+ */
+static
+void ssdfs_peb_define_segbmap_logical_extent(struct ssdfs_peb_container *pebc,
+					     u16 seg_index,
+					     struct ssdfs_segbmap_extent *ptr)
+{
+	struct ssdfs_segment_bmap *segbmap;
+	u16 peb_index;
+	u32 fragments_bytes_per_seg;
+	u32 fragments_bytes_per_peb;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!pebc->parent_si->fsi->segbmap);
+	BUG_ON(!ptr);
+
+	SSDFS_DBG("seg_id %llu, seg_index %u, peb_index %u, extent %p\n",
+		  pebc->parent_si->seg_id, seg_index,
+		  pebc->peb_index, ptr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	segbmap = pebc->parent_si->fsi->segbmap;
+	peb_index = pebc->peb_index;
+
+	down_read(&segbmap->resize_lock);
+	ptr->fragment_size = segbmap->fragment_size;
+	fragments_bytes_per_seg =
+		(u32)segbmap->fragments_per_seg * ptr->fragment_size;
+	fragments_bytes_per_peb =
+		(u32)segbmap->fragments_per_peb * ptr->fragment_size;
+	ptr->logical_offset = fragments_bytes_per_seg * seg_index;
+	ptr->logical_offset += fragments_bytes_per_peb * peb_index;
+	ptr->data_size = segbmap->fragments_per_peb * ptr->fragment_size;
+	up_read(&segbmap->resize_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("fragment_size %u, fragments_bytes_per_seg %u, "
+		  "fragments_bytes_per_peb %u, seg_index %u, "
+		  "peb_index %u, logical_offset %llu, data_size %u\n",
+		  ptr->fragment_size,
+		  fragments_bytes_per_seg,
+		  fragments_bytes_per_peb,
+		  seg_index, peb_index,
+		  ptr->logical_offset,
+		  ptr->data_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_peb_define_segbmap_logical_block() - convert offset into block number
+ * @pebc: pointer on PEB container
+ * @seg_index: index of segment in segment bitmap
+ * @logical_offset: logical offset
+ *
+ * RETURN:
+ * [success] - logical block number
+ * [failure] - U16_MAX
+ */
+static
+u16 ssdfs_peb_define_segbmap_logical_block(struct ssdfs_peb_container *pebc,
+					   u16 seg_index,
+					   u64 logical_offset)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_bmap *segbmap;
+	u16 peb_index;
+	u32 fragments_bytes_per_seg;
+	u32 fragments_bytes_per_peb;
+	u32 blks_per_peb;
+	u64 seg_logical_offset;
+	u32 peb_blk_off, blk_off;
+	u32 logical_blk;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!pebc->parent_si->fsi->segbmap);
+
+	SSDFS_DBG("seg_id %llu, peb_index %u, "
+		  "logical_offset %llu\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  logical_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebc->parent_si->fsi;
+	segbmap = fsi->segbmap;
+	peb_index = pebc->peb_index;
+
+	down_read(&segbmap->resize_lock);
+	fragments_bytes_per_seg =
+		(u32)segbmap->fragments_per_seg * segbmap->fragment_size;
+	fragments_bytes_per_peb =
+		(u32)segbmap->fragments_per_peb * segbmap->fragment_size;
+	blks_per_peb = fragments_bytes_per_peb;
+	blks_per_peb >>= fsi->log_pagesize;
+	up_read(&segbmap->resize_lock);
+
+	seg_logical_offset = (u64)seg_index * fragments_bytes_per_seg;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_index %u, seg_logical_offset %llu, "
+		  "logical_offset %llu\n",
+		  seg_index, seg_logical_offset,
+		  logical_offset);
+
+	BUG_ON(seg_logical_offset > logical_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	logical_offset -= seg_logical_offset;
+
+	logical_blk = blks_per_peb * peb_index;
+	peb_blk_off = blks_per_peb * peb_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(peb_blk_off >= U16_MAX);
+	BUG_ON((logical_offset >> fsi->log_pagesize) >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	blk_off = (u32)(logical_offset >> fsi->log_pagesize);
+
+	if (blk_off < peb_blk_off || blk_off >= (peb_blk_off + blks_per_peb)) {
+		SSDFS_ERR("invalid logical offset: "
+			  "blk_off %u, peb_blk_off %u, "
+			  "blks_per_peb %u, logical_offset %llu\n",
+			  blk_off, peb_blk_off,
+			  blks_per_peb, logical_offset);
+		return U16_MAX;
+	}
+
+	logical_blk = blk_off - peb_blk_off;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_blk_off %u, blk_off %u, "
+		  "logical_blk %u\n",
+		  peb_blk_off, blk_off,
+		  logical_blk);
+
+	BUG_ON(logical_blk >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u16)logical_blk;
+}
+
+/*
+ * ssdfs_peb_read_segbmap_first_page() - read first page of segbmap
+ * @pebc: pointer on PEB container
+ * @seg_index: index of segment in segbmap's segments sequence
+ * @extent: requested extent for reading
+ *
+ * This method tries to read first page of segbmap, to check it
+ * and to initialize the available fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA     - no pages for read.
+ * %-ENOMEM      - fail to allocate memory.
+ * %-ERANGE      - internal error.
+ */
+static
+int ssdfs_peb_read_segbmap_first_page(struct ssdfs_peb_container *pebc,
+				      u16 seg_index,
+				      struct ssdfs_segbmap_extent *extent)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_request *req;
+	u16 pages_count = 1;
+	u16 logical_blk;
+	u16 sequence_id;
+	int state;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!extent);
+	BUG_ON(extent->fragment_size != PAGE_SIZE);
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "logical_offset %llu, data_size %u, "
+		  "fragment_size %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  extent->logical_offset, extent->data_size,
+		  extent->fragment_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebc->parent_si->fsi;
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
+	ssdfs_request_prepare_logical_extent(SSDFS_SEG_BMAP_INO,
+					     extent->logical_offset,
+					     extent->fragment_size,
+					     0, 0, req);
+
+	err = ssdfs_request_add_allocated_page_locked(req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail allocate memory page: err %d\n", err);
+		goto fail_read_segbmap_page;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    SSDFS_READ_PAGE,
+					    SSDFS_REQ_SYNC,
+					    req);
+
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req);
+
+	logical_blk = ssdfs_peb_define_segbmap_logical_block(pebc,
+							seg_index,
+							extent->logical_offset);
+	if (unlikely(logical_blk == U16_MAX)) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define logical block\n");
+		goto fail_read_segbmap_page;
+	}
+
+	if (fsi->pagesize < PAGE_SIZE)
+		pages_count = PAGE_SIZE >> fsi->log_pagesize;
+
+	ssdfs_request_define_volume_extent(logical_blk, pages_count, req);
+
+	err = ssdfs_peb_read_page(pebc, req, NULL);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read page: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index, err);
+		goto fail_read_segbmap_page;
+	}
+
+	if (!err) {
+		for (i = 0; i < req->result.processed_blks; i++)
+			ssdfs_peb_mark_request_block_uptodate(pebc, req, i);
+	}
+
+	if (!ssdfs_segbmap_fragment_has_content(req->result.pvec.pages[0])) {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb_index %u hasn't segbmap's fragments\n",
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto fail_read_segbmap_page;
+	}
+
+	sequence_id = ssdfs_peb_define_segbmap_sequence_id(pebc, seg_index,
+							extent->logical_offset);
+	if (unlikely(sequence_id == U16_MAX)) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define sequence_id\n");
+		goto fail_read_segbmap_page;
+	}
+
+	err = ssdfs_segbmap_check_fragment_header(pebc, seg_index, sequence_id,
+						  req->result.pvec.pages[0]);
+	if (unlikely(err)) {
+		SSDFS_CRIT("segbmap fragment is corrupted: err %d\n",
+			   err);
+	}
+
+	if (err) {
+		state = SSDFS_SEGBMAP_FRAG_INIT_FAILED;
+		goto fail_read_segbmap_page;
+	} else
+		state = SSDFS_SEGBMAP_FRAG_INITIALIZED;
+
+	err = ssdfs_segbmap_fragment_init(pebc, sequence_id,
+					  req->result.pvec.pages[0],
+					  state);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init fragment: "
+			  "sequence_id %u, err %d\n",
+			  sequence_id, err);
+		goto fail_read_segbmap_page;
+	} else
+		ssdfs_request_unlock_and_remove_page(req, 0);
+
+	extent->logical_offset += extent->fragment_size;
+	extent->data_size -= extent->fragment_size;
+
+fail_read_segbmap_page:
+	ssdfs_request_unlock_and_remove_pages(req);
+	ssdfs_put_request(req);
+	ssdfs_request_free(req);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_read_segbmap_pages() - read pagevec-based amount of pages
+ * @pebc: pointer on PEB container
+ * @seg_index: index of segment in segbmap's segments sequence
+ * @extent: requested extent for reading
+ *
+ * This method tries to read pagevec-based amount of pages of
+ * segbmap in PEB (excluding the first one) and to initialize all
+ * available fragments.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA     - no pages for read.
+ * %-ENOMEM      - fail to allocate memory.
+ * %-ERANGE      - internal error.
+ */
+static
+int ssdfs_peb_read_segbmap_pages(struct ssdfs_peb_container *pebc,
+				 u16 seg_index,
+				 struct ssdfs_segbmap_extent *extent)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_request *req;
+	u32 read_bytes;
+	u16 fragments_count;
+	u16 pages_count = 1;
+	u16 logical_blk;
+	u16 sequence_id;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!extent);
+	BUG_ON(extent->fragment_size != PAGE_SIZE);
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "logical_offset %llu, data_size %u, "
+		  "fragment_size %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  extent->logical_offset, extent->data_size,
+		  extent->fragment_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebc->parent_si->fsi;
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
+	read_bytes = min_t(u32, PAGEVEC_SIZE * PAGE_SIZE,
+			   extent->data_size);
+
+	ssdfs_request_prepare_logical_extent(SSDFS_SEG_BMAP_INO,
+					     extent->logical_offset,
+					     read_bytes,
+					     0, 0, req);
+
+	fragments_count = read_bytes + extent->fragment_size - 1;
+	fragments_count /= extent->fragment_size;
+
+	for (i = 0; i < fragments_count; i++) {
+		err = ssdfs_request_add_allocated_page_locked(req);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail allocate memory page: err %d\n", err);
+			goto fail_read_segbmap_pages;
+		}
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    SSDFS_READ_PAGES_READAHEAD,
+					    SSDFS_REQ_SYNC,
+					    req);
+
+	ssdfs_request_define_segment(pebc->parent_si->seg_id, req);
+
+	logical_blk = ssdfs_peb_define_segbmap_logical_block(pebc,
+							seg_index,
+							extent->logical_offset);
+	if (unlikely(logical_blk == U16_MAX)) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define logical block\n");
+		goto fail_read_segbmap_pages;
+	}
+
+	pages_count = (read_bytes + fsi->pagesize - 1) >> PAGE_SHIFT;
+	ssdfs_request_define_volume_extent(logical_blk, pages_count, req);
+
+	err = ssdfs_peb_readahead_pages(pebc, req, NULL);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read pages: "
+			  "seg %llu, peb_index %u, err %d\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index, err);
+		goto fail_read_segbmap_pages;
+	}
+
+	for (i = 0; i < req->result.processed_blks; i++)
+		ssdfs_peb_mark_request_block_uptodate(pebc, req, i);
+
+	sequence_id = ssdfs_peb_define_segbmap_sequence_id(pebc, seg_index,
+							extent->logical_offset);
+	if (unlikely(sequence_id == U16_MAX)) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to define sequence_id\n");
+		goto fail_read_segbmap_pages;
+	}
+
+	for (i = 0; i < fragments_count; i++) {
+		int state;
+		struct page *page = req->result.pvec.pages[i];
+
+		err = ssdfs_segbmap_check_fragment_header(pebc, seg_index,
+							  sequence_id, page);
+		if (unlikely(err)) {
+			SSDFS_CRIT("segbmap fragment is corrupted: "
+				   "sequence_id %u, err %d\n",
+				   sequence_id, err);
+		}
+
+		if (err) {
+			state = SSDFS_SEGBMAP_FRAG_INIT_FAILED;
+			goto fail_read_segbmap_pages;
+		} else
+			state = SSDFS_SEGBMAP_FRAG_INITIALIZED;
+
+		err = ssdfs_segbmap_fragment_init(pebc, sequence_id,
+						  page, state);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init fragment: "
+				  "sequence_id %u, err %d\n",
+				  sequence_id, err);
+			goto fail_read_segbmap_pages;
+		} else
+			ssdfs_request_unlock_and_remove_page(req, i);
+
+		sequence_id++;
+	}
+
+	extent->logical_offset += read_bytes;
+	extent->data_size -= read_bytes;
+
+fail_read_segbmap_pages:
+	ssdfs_request_unlock_and_remove_pages(req);
+	ssdfs_put_request(req);
+	ssdfs_request_free(req);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_read_segbmap_rest_pages() - read all pages of segbmap in PEB
+ * @pebc: pointer on PEB container
+ * @seg_index: index of segment in segbmap's segments sequence
+ * @extent: requested extent for reading
+ *
+ * This method tries to read all pages of segbmap in PEB (excluding
+ * the first one) and initialize all available fragments.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA     - no pages for read.
+ */
+static
+int ssdfs_peb_read_segbmap_rest_pages(struct ssdfs_peb_container *pebc,
+				      u16 seg_index,
+				      struct ssdfs_segbmap_extent *extent)
+{
+	int err = 0, err1;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!extent);
+	BUG_ON(extent->fragment_size != PAGE_SIZE);
+
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "logical_offset %llu, data_size %u, "
+		  "fragment_size %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  extent->logical_offset, extent->data_size,
+		  extent->fragment_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (extent->data_size == 0) {
+		SSDFS_DBG("extent->data_size == 0\n");
+		return -ENODATA;
+	}
+
+	do {
+		err1 = ssdfs_peb_read_segbmap_pages(pebc, seg_index,
+						   extent);
+		if (unlikely(err1)) {
+			SSDFS_ERR("fail to read segbmap's pages: "
+				  "logical_offset %llu, data_bytes %u, "
+				  "err %d\n",
+				  extent->logical_offset,
+				  extent->data_size,
+				  err1);
+			err = err1;
+			break;
+		}
+	} while (extent->data_size > 0);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_init_segbmap_object() - init segment bitmap object
+ * @pebc: pointer on PEB container
+ * @req: read request
+ *
+ * This method tries to initialize segment bitmap object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_init_segbmap_object(struct ssdfs_peb_container *pebc,
+				  struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	u16 seg_index;
+	struct ssdfs_segbmap_extent extent = {0};
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#else
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+
+	seg_index = ssdfs_peb_define_segbmap_seg_index(pebc);
+	if (seg_index == U16_MAX) {
+		SSDFS_ERR("fail to determine segment index\n");
+		return -ERANGE;
+	}
+
+	ssdfs_peb_define_segbmap_logical_extent(pebc, seg_index, &extent);
+
+	err = ssdfs_peb_read_segbmap_first_page(pebc, seg_index, &extent);
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb_index %u hasn't segbmap's content\n",
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to read PEB's segbmap first page: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	err = ssdfs_peb_read_segbmap_rest_pages(pebc, seg_index, &extent);
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("peb_index %u has only one page\n",
+			  pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to read PEB's segbmap rest pages: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	{
+		int err1 = ssdfs_peb_release_pages(pebc);
+		if (err1 == -ENODATA) {
+			SSDFS_DBG("PEB cache is empty\n");
+		} else if (unlikely(err1)) {
+			SSDFS_ERR("fail to release pages: err %d\n",
+				  err1);
+		}
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
+ * ssdfs_maptbl_fragment_pages_count() - calculate count of pages in fragment
+ * @fsi: file system info object
+ *
+ * This method calculates count of pages in the mapping table's
+ * fragment.
+ *
+ * RETURN:
+ * [success] - count of pages in fragment
+ * [failure] - U16_MAX
+ */
+static inline
+u16 ssdfs_maptbl_fragment_pages_count(struct ssdfs_fs_info *fsi)
+{
+	u32 fragment_pages;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (fsi->maptbl->fragment_bytes % PAGE_SIZE) {
+		SSDFS_WARN("invalid fragment_bytes %u\n",
+			   fsi->maptbl->fragment_bytes);
+		return U16_MAX;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragment_pages = fsi->maptbl->fragment_bytes / PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(fragment_pages >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return fragment_pages;
+}
+
+/*
+ * ssdfs_peb_read_maptbl_fragment() - read mapping table's fragment's pages
+ * @pebc: pointer on PEB container
+ * @index: index of fragment in the PEB
+ * @logical_offset: logical offset of fragment in mapping table
+ * @logical_blk: starting logical block of fragment
+ * @fragment_bytes: size of fragment in bytes
+ * @area: fragment content [out]
+ *
+ * This method tries to read mapping table's fragment's pages.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENODATA    - fragment hasn't content.
+ */
+static
+int ssdfs_peb_read_maptbl_fragment(struct ssdfs_peb_container *pebc,
+				   int index, u64 logical_offset,
+				   u16 logical_blk,
+				   u32 fragment_bytes,
+				   struct ssdfs_maptbl_area *area)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_request *req;
+	u32 pagevec_bytes = (u32)PAGEVEC_SIZE << PAGE_SHIFT;
+	u32 cur_offset = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi || !area);
+
+	SSDFS_DBG("pebc %p, index %d, logical_offset %llu, "
+		  "logical_blk %u, fragment_bytes %u, area %p\n",
+		  pebc, index, logical_offset,
+		  logical_blk, fragment_bytes, area);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebc->parent_si->fsi;
+
+	if (fragment_bytes == 0) {
+		SSDFS_ERR("invalid fragment_bytes %u\n",
+			  fragment_bytes);
+		return -ERANGE;
+	}
+
+	do {
+		u32 size;
+		u16 pages_count;
+		int i;
+
+		req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req)) {
+			err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+			SSDFS_ERR("fail to allocate segment request: err %d\n",
+				  err);
+			return err;
+		}
+
+		ssdfs_request_init(req);
+		ssdfs_get_request(req);
+
+		if (cur_offset == 0)
+			size = fsi->pagesize;
+		else
+			size = min_t(u32, fragment_bytes, pagevec_bytes);
+
+		ssdfs_request_prepare_logical_extent(SSDFS_MAPTBL_INO,
+						     logical_offset, size,
+						     0, 0, req);
+
+		pages_count = (size + fsi->pagesize - 1) >> PAGE_SHIFT;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(pages_count > PAGEVEC_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		for (i = 0; i < pages_count; i++) {
+			err = ssdfs_request_add_allocated_page_locked(req);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail allocate memory page: err %d\n",
+					  err);
+				goto fail_read_maptbl_pages;
+			}
+		}
+
+		ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+						    SSDFS_READ_PAGES_READAHEAD,
+						    SSDFS_REQ_SYNC,
+						    req);
+
+		ssdfs_request_define_segment(pebc->parent_si->seg_id, req);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("logical_offset %llu, size %u, "
+			  "logical_blk %u, pages_count %u\n",
+			  logical_offset, size,
+			  logical_blk, pages_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_request_define_volume_extent((u16)logical_blk,
+						   pages_count, req);
+
+		err = ssdfs_peb_readahead_pages(pebc, req, NULL);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to read pages: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+			goto fail_read_maptbl_pages;
+		}
+
+		for (i = 0; i < req->result.processed_blks; i++)
+			ssdfs_peb_mark_request_block_uptodate(pebc, req, i);
+
+		if (cur_offset == 0) {
+			struct ssdfs_leb_table_fragment_header *hdr;
+			u16 magic;
+			void *kaddr;
+			bool is_fragment_valid = false;
+
+			kaddr = kmap_local_page(req->result.pvec.pages[0]);
+			hdr = (struct ssdfs_leb_table_fragment_header *)kaddr;
+			magic = le16_to_cpu(hdr->magic);
+			is_fragment_valid = magic == SSDFS_LEB_TABLE_MAGIC;
+			area->portion_id = le16_to_cpu(hdr->portion_id);
+			kunmap_local(kaddr);
+
+			if (!is_fragment_valid) {
+				err = -ENODATA;
+				area->portion_id = U16_MAX;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("empty fragment: "
+					  "peb_index %u, index %d\n",
+					  pebc->peb_index, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+				goto fail_read_maptbl_pages;
+			}
+		}
+
+		ssdfs_maptbl_move_fragment_pages(req, area, pages_count);
+		ssdfs_request_unlock_and_remove_pages(req);
+		ssdfs_put_request(req);
+		ssdfs_request_free(req);
+
+		fragment_bytes -= size;
+		logical_offset += size;
+		cur_offset += size;
+		logical_blk += pages_count;
+	} while (fragment_bytes > 0);
+
+	return 0;
+
+fail_read_maptbl_pages:
+	ssdfs_request_unlock_and_remove_pages(req);
+	ssdfs_put_request(req);
+	ssdfs_request_free(req);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_init_maptbl_object() - init mapping table's fragment
+ * @pebc: pointer on PEB container
+ * @req: read request
+ *
+ * This method tries to read and to init mapping table's fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_peb_init_maptbl_object(struct ssdfs_peb_container *pebc,
+				 struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_maptbl_area area = {0};
+	u64 logical_offset;
+	u32 logical_blk;
+	u32 fragment_bytes;
+	u32 blks_per_fragment;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#else
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+
+	down_read(&fsi->maptbl->tbl_lock);
+	fragment_bytes = fsi->maptbl->fragment_bytes;
+	area.pages_count = 0;
+	area.pages_capacity = ssdfs_maptbl_fragment_pages_count(fsi);
+	up_read(&fsi->maptbl->tbl_lock);
+
+	if (unlikely(area.pages_capacity >= U16_MAX)) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid fragment pages_capacity\n");
+		goto end_init;
+	}
+
+	area.pages = ssdfs_read_kcalloc(area.pages_capacity,
+				   sizeof(struct page *),
+				   GFP_KERNEL);
+	if (!area.pages) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate memory: "
+			  "area.pages_capacity %zu\n",
+			  area.pages_capacity);
+		goto end_init;
+	}
+
+	logical_offset = req->extent.logical_offset;
+	logical_blk = req->place.start.blk_index;
+
+	blks_per_fragment =
+		(fragment_bytes + fsi->pagesize - 1) / fsi->pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(blks_per_fragment >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < fsi->maptbl->fragments_per_peb; i++) {
+		logical_offset = logical_offset + ((u64)fragment_bytes * i);
+		logical_blk = logical_blk + (blks_per_fragment * i);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(logical_blk >= U16_MAX);
+
+		SSDFS_DBG("seg %llu, peb_index %d, "
+			  "logical_offset %llu, logical_blk %u\n",
+			  pebc->parent_si->seg_id, i,
+			  logical_offset, logical_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_peb_read_maptbl_fragment(pebc, i,
+						     logical_offset,
+						     (u16)logical_blk,
+						     fragment_bytes,
+						     &area);
+		if (err == -ENODATA) {
+			err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("peb_index %u hasn't more maptbl fragments: "
+				  "last index %d\n",
+				  pebc->peb_index, i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto end_init;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to read maptbl fragment: "
+				  "index %d, err %d\n",
+				  i, err);
+			goto end_init;
+		}
+
+		down_read(&fsi->maptbl->tbl_lock);
+		err = ssdfs_maptbl_fragment_init(pebc, &area);
+		up_read(&fsi->maptbl->tbl_lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init maptbl fragment: "
+				  "index %d, err %d\n",
+				  i, err);
+			goto end_init;
+		}
+	}
+
+end_init:
+	for (i = 0; i < area.pages_capacity; i++) {
+		if (area.pages[i]) {
+			ssdfs_read_free_page(area.pages[i]);
+			area.pages[i] = NULL;
+		}
+	}
+
+	ssdfs_read_kfree(area.pages);
+
+	{
+		int err1 = ssdfs_peb_release_pages(pebc);
+		if (err1 == -ENODATA) {
+			SSDFS_DBG("PEB cache is empty\n");
+		} else if (unlikely(err1)) {
+			SSDFS_ERR("fail to release pages: err %d\n",
+				  err1);
+		}
+	}
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
+ * ssdfs_peb_get_last_log_time() - get PEB's last log timestamp
+ * @fsi: file system info object
+ * @pebi: pointer on PEB object
+ * @page_off: page offset to footer's placement
+ * @peb_create_time: PEB's create timestamp [out]
+ * @last_log_time: PEB's last log timestamp
+ *
+ * This method tries to read the last log footer of PEB
+ * and retrieve peb_create_time and last_log_time.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENODATA    - no valid log footer.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_get_last_log_time(struct ssdfs_fs_info *fsi,
+				struct ssdfs_peb_info *pebi,
+				u32 page_off,
+				u64 *peb_create_time,
+				u64 *last_log_time)
+{
+	struct ssdfs_signature *magic = NULL;
+	struct ssdfs_partial_log_header *plh_hdr = NULL;
+	struct ssdfs_log_footer *footer = NULL;
+	struct page *page;
+	void *kaddr;
+	u32 bytes_off;
+	size_t read_bytes;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !pebi || !pebi->pebc || !pebi->pebc->parent_si);
+	BUG_ON(!peb_create_time || !last_log_time);
+
+	SSDFS_DBG("seg %llu, peb_id %llu, page_off %u\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id, page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*peb_create_time = U64_MAX;
+	*last_log_time = U64_MAX;
+
+	page = ssdfs_page_array_grab_page(&pebi->cache, page_off);
+	if (unlikely(IS_ERR_OR_NULL(page))) {
+		SSDFS_ERR("fail to grab page: index %u\n",
+			  page_off);
+		return -ENOMEM;
+	}
+
+	kaddr = kmap_local_page(page);
+
+	if (PageUptodate(page) || PageDirty(page))
+		goto check_footer_magic;
+
+	bytes_off = page_off * fsi->pagesize;
+
+	err = ssdfs_aligned_read_buffer(fsi, pebi->peb_id,
+					bytes_off,
+					(u8 *)kaddr,
+					PAGE_SIZE,
+					&read_bytes);
+	if (unlikely(err))
+		goto fail_read_footer;
+	else if (unlikely(read_bytes != PAGE_SIZE)) {
+		err = -ERANGE;
+		goto fail_read_footer;
+	}
+
+	SetPageUptodate(page);
+
+check_footer_magic:
+	magic = (struct ssdfs_signature *)kaddr;
+
+	if (!is_ssdfs_magic_valid(magic)) {
+		err = -ENODATA;
+		goto fail_read_footer;
+	}
+
+	if (is_ssdfs_partial_log_header_magic_valid(magic)) {
+		plh_hdr = SSDFS_PLH(kaddr);
+		*peb_create_time = le64_to_cpu(plh_hdr->peb_create_time);
+		*last_log_time = le64_to_cpu(plh_hdr->timestamp);
+	} else if (__is_ssdfs_log_footer_magic_valid(magic)) {
+		footer = SSDFS_LF(kaddr);
+		*peb_create_time = le64_to_cpu(footer->peb_create_time);
+		*last_log_time = le64_to_cpu(footer->timestamp);
+	} else {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("log footer is corrupted: "
+			  "peb %llu, page_off %u\n",
+			  pebi->peb_id, page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto fail_read_footer;
+	}
+
+fail_read_footer:
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("valid footer is not detected: "
+			  "seg_id %llu, peb_id %llu, "
+			  "page_off %u\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  page_off);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to read footer: "
+			  "seg %llu, peb %llu, "
+			  "pages_off %u, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  page_off,
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_read_last_log_footer() - read PEB's last log footer
+ * @pebi: pointer on PEB object
+ * @req: read request
+ *
+ * This method tries to read the last log footer of PEB
+ * and initialize peb_create_time and last_log_time fields.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENODATA    - no valid log footer.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_read_last_log_footer(struct ssdfs_peb_info *pebi,
+				   struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 log_bytes;
+	u32 pages_per_log;
+	u32 logs_count;
+	u32 page_off;
+	u64 peb_create_time;
+	u64 last_log_time;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi || !pebi->pebc->parent_si);
+	BUG_ON(!pebi->pebc->parent_si->fsi || !req);
+
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebi->pebc->parent_si->fsi;
+	page_off = 0;
+
+	err = __ssdfs_peb_read_log_header(fsi, pebi, page_off,
+					  &log_bytes);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read log header: "
+			  "seg %llu, peb %llu, page_off %u, "
+			  "err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id,
+			  page_off,
+			  err);
+		return err;
+	}
+
+	pages_per_log = log_bytes + fsi->pagesize - 1;
+	pages_per_log /= fsi->pagesize;
+	logs_count = fsi->pages_per_peb / pages_per_log;
+
+	for (i = logs_count; i > 0; i--) {
+		page_off = (i * pages_per_log) - 1;
+
+		err = ssdfs_peb_get_last_log_time(fsi, pebi,
+						  page_off,
+						  &peb_create_time,
+						  &last_log_time);
+		if (err == -ENODATA)
+			continue;
+		else if (unlikely(err)) {
+			SSDFS_ERR("fail to get last log time: "
+				  "seg %llu, peb %llu, "
+				  "page_off %u, err %d\n",
+				  pebi->pebc->parent_si->seg_id,
+				  pebi->peb_id,
+				  page_off,
+				  err);
+			return err;
+		} else
+			break;
+	}
+
+	if (i <= 0 || err == -ENODATA) {
+		SSDFS_ERR("fail to get last log time: "
+			  "seg %llu, peb %llu, err %d\n",
+			  pebi->pebc->parent_si->seg_id,
+			  pebi->peb_id, err);
+		return -ERANGE;
+	}
+
+	pebi->peb_create_time = peb_create_time;
+	pebi->current_log.last_log_time = last_log_time;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg %llu, peb %llu, "
+		  "peb_create_time %llx, last_log_time %llx\n",
+		  pebi->pebc->parent_si->seg_id,
+		  pebi->peb_id,
+		  peb_create_time,
+		  last_log_time);
+
+	BUG_ON(pebi->peb_create_time > last_log_time);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_read_src_last_log_footer() - read src PEB's last log footer
+ * @pebc: pointer on PEB container
+ * @req: read request
+ *
+ * This method tries to read the last log footer of source PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENODATA    - no valid log footer.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_read_src_last_log_footer(struct ssdfs_peb_container *pebc,
+					struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_info *pebi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#else
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+
+	down_read(&pebc->lock);
+
+	pebi = pebc->src_peb;
+	if (!pebi) {
+		SSDFS_WARN("source PEB is NULL\n");
+		err = -ERANGE;
+		goto finish_read_src_last_log_footer;
+	}
+
+	err = ssdfs_peb_read_last_log_footer(pebi, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read last log's footer: "
+			  "peb_id %llu, peb_index %u, err %d\n",
+			  pebi->peb_id, pebi->peb_index, err);
+		goto finish_read_src_last_log_footer;
+	}
+
+finish_read_src_last_log_footer:
+	up_read(&pebc->lock);
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
+ * ssdfs_peb_read_dst_last_log_footer() - read dst PEB's last log footer
+ * @pebc: pointer on PEB container
+ * @req: read request
+ *
+ * This method tries to read the last log footer of destination PEB.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENODATA    - no valid log footer.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_peb_read_dst_last_log_footer(struct ssdfs_peb_container *pebc,
+					struct ssdfs_segment_request *req)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_info *pebi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi || !req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#else
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "class %#x, cmd %#x, type %#x\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  req->private.class, req->private.cmd,
+		  req->private.type);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+
+	down_read(&pebc->lock);
+
+	pebi = pebc->dst_peb;
+	if (!pebi) {
+		SSDFS_WARN("destination PEB is NULL\n");
+		err = -ERANGE;
+		goto finish_read_dst_last_log_footer;
+	}
+
+	err = ssdfs_peb_read_last_log_footer(pebi, req);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to read last log's footer: "
+			  "peb_id %llu, peb_index %u, err %d\n",
+			  pebi->peb_id, pebi->peb_index, err);
+		goto finish_read_dst_last_log_footer;
+	}
+
+finish_read_dst_last_log_footer:
+	up_read(&pebc->lock);
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
+ * ssdfs_process_read_request() - process read request
+ * @pebc: pointer on PEB container
+ * @req: read request
+ *
+ * This function detects command of read request and
+ * to call a proper function for request processing.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+static
+int ssdfs_process_read_request(struct ssdfs_peb_container *pebc,
+				struct ssdfs_segment_request *req)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !req);
+
+	SSDFS_DBG("req %p, class %#x, cmd %#x, type %#x\n",
+		  req, req->private.class, req->private.cmd,
+		  req->private.type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (req->private.cmd < SSDFS_READ_PAGE ||
+	    req->private.cmd >= SSDFS_READ_CMD_MAX) {
+		SSDFS_ERR("unknown read command %d, seg %llu, peb_index %u\n",
+			  req->private.cmd, pebc->parent_si->seg_id,
+			  pebc->peb_index);
+		atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+		req->result.err = -EINVAL;
+		return -EINVAL;
+	}
+
+	atomic_set(&req->result.state, SSDFS_REQ_STARTED);
+
+	switch (req->private.cmd) {
+	case SSDFS_READ_PAGE:
+		err = ssdfs_peb_read_page(pebc, req, NULL);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to read page: "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_PAGES_READAHEAD:
+		err = ssdfs_peb_readahead_pages(pebc, req, NULL);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to read pages: "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_SRC_ALL_LOG_HEADERS:
+		err = ssdfs_peb_read_src_all_log_headers(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to read log headers: "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_DST_ALL_LOG_HEADERS:
+		err = ssdfs_peb_read_dst_all_log_headers(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to read log headers: "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_BLK_BMAP_SRC_USING_PEB:
+		err = ssdfs_src_peb_init_using_metadata_state(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to init source PEB (using state): "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_BLK_BMAP_DST_USING_PEB:
+		err = ssdfs_dst_peb_init_using_metadata_state(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to init destination PEB (using state): "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_BLK_BMAP_SRC_USED_PEB:
+		err = ssdfs_src_peb_init_used_metadata_state(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to init source PEB (used state): "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_BLK_BMAP_DST_USED_PEB:
+		err = ssdfs_dst_peb_init_used_metadata_state(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to init destination PEB (used state): "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_BLK2OFF_TABLE_SRC_PEB:
+		err = ssdfs_src_peb_complete_init_blk2off_table(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to finish offset table init: "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_BLK2OFF_TABLE_DST_PEB:
+		err = ssdfs_dst_peb_complete_init_blk2off_table(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to finish offset table init: "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_INIT_SEGBMAP:
+		err = ssdfs_peb_init_segbmap_object(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to init segment bitmap object: "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_INIT_MAPTBL:
+		err = ssdfs_peb_init_maptbl_object(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to init mapping table object: "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_SRC_LAST_LOG_FOOTER:
+		err = ssdfs_peb_read_src_last_log_footer(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to read last log footer: "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	case SSDFS_READ_DST_LAST_LOG_FOOTER:
+		err = ssdfs_peb_read_dst_last_log_footer(pebc, req);
+		if (unlikely(err)) {
+			ssdfs_fs_error(pebc->parent_si->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to read last log footer: "
+				"seg %llu, peb_index %u, err %d\n",
+				pebc->parent_si->seg_id,
+				pebc->peb_index, err);
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG();
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (unlikely(err))
+		atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+
+	return err;
+}
+
+/*
+ * ssdfs_finish_read_request() - finish read request
+ * @pebc: pointer on PEB container
+ * @req: segment request
+ * @wait: wait queue head
+ * @err: error code (read request failure code)
+ *
+ * This function makes final activity with read request.
+ */
+static
+void ssdfs_finish_read_request(struct ssdfs_peb_container *pebc,
+				struct ssdfs_segment_request *req,
+				wait_queue_head_t *wait, int err)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !req);
+
+	SSDFS_DBG("req %p, class %#x, cmd %#x, type %#x, err %d\n",
+		  req, req->private.class, req->private.cmd,
+		  req->private.type, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!err) {
+		for (i = 0; i < req->result.processed_blks; i++)
+			ssdfs_peb_mark_request_block_uptodate(pebc, req, i);
+	}
+
+	req->result.err = err;
+
+	if (err)
+		atomic_set(&req->result.state, SSDFS_REQ_FAILED);
+	else
+		atomic_set(&req->result.state, SSDFS_REQ_FINISHED);
+
+	switch (req->private.type) {
+	case SSDFS_REQ_SYNC:
+		complete(&req->result.wait);
+		wake_up_all(&req->private.wait_queue);
+		break;
+
+	case SSDFS_REQ_ASYNC:
+		complete(&req->result.wait);
+
+		ssdfs_put_request(req);
+		if (atomic_read(&req->private.refs_count) != 0) {
+			err = wait_event_killable_timeout(*wait,
+				atomic_read(&req->private.refs_count) == 0,
+				SSDFS_DEFAULT_TIMEOUT);
+			if (err < 0)
+				WARN_ON(err < 0);
+			else
+				err = 0;
+		}
+
+		wake_up_all(&req->private.wait_queue);
+
+		for (i = 0; i < pagevec_count(&req->result.pvec); i++) {
+			struct page *page = req->result.pvec.pages[i];
+
+			if (!page) {
+				SSDFS_WARN("page %d is NULL\n", i);
+				continue;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			WARN_ON(!PageLocked(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+			SSDFS_DBG("page_index %llu, flags %#lx\n",
+				  (u64)page_index(page), page->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		ssdfs_request_free(req);
+		break;
+
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		complete(&req->result.wait);
+
+		ssdfs_put_request(req);
+		if (atomic_read(&req->private.refs_count) != 0) {
+			err = wait_event_killable_timeout(*wait,
+				atomic_read(&req->private.refs_count) == 0,
+				SSDFS_DEFAULT_TIMEOUT);
+			if (err < 0)
+				WARN_ON(err < 0);
+			else
+				err = 0;
+		}
+
+		wake_up_all(&req->private.wait_queue);
+
+		for (i = 0; i < pagevec_count(&req->result.pvec); i++) {
+			struct page *page = req->result.pvec.pages[i];
+
+			if (!page) {
+				SSDFS_WARN("page %d is NULL\n", i);
+				continue;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			WARN_ON(!PageLocked(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+			SSDFS_DBG("page_index %llu, flags %#lx\n",
+				  (u64)page_index(page), page->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+		break;
+
+	default:
+		BUG();
+	};
+
+	ssdfs_peb_finish_read_request_cno(pebc);
+}
+
+#define READ_THREAD_WAKE_CONDITION(pebc) \
+	(kthread_should_stop() || \
+	 !is_ssdfs_requests_queue_empty(READ_RQ_PTR(pebc)))
+#define READ_FAILED_THREAD_WAKE_CONDITION() \
+	(kthread_should_stop())
+#define READ_THREAD_WAKEUP_TIMEOUT	(msecs_to_jiffies(3000))
+
+/*
+ * ssdfs_peb_read_thread_func() - main fuction of read thread
+ * @data: pointer on data object
+ *
+ * This function is main fuction of read thread.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ */
+int ssdfs_peb_read_thread_func(void *data)
+{
+	struct ssdfs_peb_container *pebc = data;
+	wait_queue_head_t *wait_queue;
+	struct ssdfs_segment_request *req;
+	u64 timeout = READ_THREAD_WAKEUP_TIMEOUT;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (!pebc) {
+		SSDFS_ERR("pointer on PEB container is NULL\n");
+		BUG();
+	}
+
+	SSDFS_DBG("read thread: seg %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id, pebc->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	wait_queue = &pebc->parent_si->wait_queue[SSDFS_PEB_READ_THREAD];
+
+repeat:
+	if (kthread_should_stop()) {
+		complete_all(&pebc->thread[SSDFS_PEB_READ_THREAD].full_stop);
+		return err;
+	}
+
+	if (is_ssdfs_requests_queue_empty(&pebc->read_rq))
+		goto sleep_read_thread;
+
+	do {
+		err = ssdfs_requests_queue_remove_first(&pebc->read_rq,
+							&req);
+		if (err == -ENODATA) {
+			/* empty queue */
+			err = 0;
+			break;
+		} else if (err == -ENOENT) {
+			SSDFS_WARN("request queue contains NULL request\n");
+			err = 0;
+			continue;
+		} else if (unlikely(err < 0)) {
+			SSDFS_CRIT("fail to get request from the queue: "
+				   "err %d\n",
+				   err);
+			goto sleep_failed_read_thread;
+		}
+
+		err = ssdfs_process_read_request(pebc, req);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to process read request: "
+				  "seg %llu, peb_index %u, err %d\n",
+				  pebc->parent_si->seg_id,
+				  pebc->peb_index, err);
+		}
+
+		ssdfs_finish_read_request(pebc, req, wait_queue, err);
+	} while (!is_ssdfs_requests_queue_empty(&pebc->read_rq));
+
+sleep_read_thread:
+	wait_event_interruptible_timeout(*wait_queue,
+					 READ_THREAD_WAKE_CONDITION(pebc),
+					 timeout);
+	if (!is_ssdfs_requests_queue_empty(&pebc->read_rq)) {
+		/* do requests processing */
+		goto repeat;
+	} else {
+		if (is_it_time_free_peb_cache_memory(pebc)) {
+			err = ssdfs_peb_release_pages(pebc);
+			if (err == -ENODATA) {
+				err = 0;
+				timeout = min_t(u64, timeout * 2,
+						(u64)SSDFS_DEFAULT_TIMEOUT);
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to release pages: "
+					  "err %d\n", err);
+				err = 0;
+			} else
+				timeout = READ_THREAD_WAKEUP_TIMEOUT;
+		}
+
+		if (!is_ssdfs_requests_queue_empty(&pebc->read_rq) ||
+		    kthread_should_stop())
+			goto repeat;
+		else
+			goto sleep_read_thread;
+	}
+
+sleep_failed_read_thread:
+	ssdfs_peb_release_pages(pebc);
+	wait_event_interruptible(*wait_queue,
+			READ_FAILED_THREAD_WAKE_CONDITION());
+	goto repeat;
+}
-- 
2.34.1


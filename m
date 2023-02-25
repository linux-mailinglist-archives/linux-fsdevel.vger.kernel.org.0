Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F16A2657
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBYBTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBYBRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:16 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF57614997
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:11 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id o12so803825oik.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F99qk9sU9ZnW6t9yqSpVrYW6OhUnUQD1p/y5nsFiOYA=;
        b=UHpgeM0ZL/TK0evZJiOfO8az8vpYtgxiQPOmnhcwEVfHndHDc701/eLq7mhTzVjteQ
         DdXJf5xxz6zDb8ypp2zIs9gQxAG+RjnF3Cg9VNxGDsigq4KjYEOmV4L8lzD4isR/59jV
         KWwYxK+0CmGzNKj3Ws5DA8v7hIwpNn17m/woZK2R/uFOCvqPncTWUyRIul2rzWvaPj83
         VCZngYQFL9My+f2zxYK1itP7JhAEcnByI0cI+CfrxmQPO/7B5Rj5THvOEMO3kKm0lZ42
         B8kXYYAWkdvAIrwYtKIQuo10fP0B2Ub4Xu4e9UpaeWxpXQXw3woGQX1yMUL/GE8Tjuc2
         1gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F99qk9sU9ZnW6t9yqSpVrYW6OhUnUQD1p/y5nsFiOYA=;
        b=54RoV/tdVaHxdItJWlmio6+UbYmJnP0Y9lsy3zXVdRckCR7z3qVUKrLMD8SgeTtqjk
         kfvpfZphJfkmRPok5JUR/LvHtVkW8xM+EkIxmPEILeXX+Tk8RS/Y6Wn6NMvkjTiOzt17
         DwQmj9Y91Ok3ZP3RFYH/TbdzsQKU/rOlmlkUdZPct2QNdnTw+OxpCk9RyHKkFF+MgBlm
         kx+sMOQVVlPw9rweiC1Pb2j0ZPkQllmvcBd3gxTjn5EL/X+oYG1paUsfV0ZUPywZY4ee
         4dVmxbLUBklI/rR2Vwt5WVpAXCPqDDx88xKjDNETbU2KZQ+v1yY9OGC5qoMMkAuMwJ/H
         DGpA==
X-Gm-Message-State: AO0yUKUEKlgmkT++6Onu/nTlvqcOvBnMI235gg9WNvf4YMZkQESfQKfn
        iSoCHWow9N6Z8tGR/+mxQsujPLJ+/CPsVaMM
X-Google-Smtp-Source: AK7set/U456NzbJlcOi6ANoeQx34HsF7sMt/nsnZBV85v7Jmodz36v3U7hlXsqURgGMEG58GRQNUew==
X-Received: by 2002:aca:d0d:0:b0:360:e80e:26a9 with SMTP id 13-20020aca0d0d000000b00360e80e26a9mr4335510oin.12.1677287830005;
        Fri, 24 Feb 2023 17:17:10 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:09 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 45/76] ssdfs: introduce segment bitmap
Date:   Fri, 24 Feb 2023 17:08:56 -0800
Message-Id: <20230225010927.813929-46-slava@dubeyko.com>
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

Segment bitmap is the critical metadata structure of SSDFS file
system that implements several goals: (1) searching for a candidate
for a current segment capable of storing new data, (2) searching
by GC subsystem for a most optimal segment (dirty state,
for example) with the goal of preparing the segment in background
for storing new data (converting in clean state). Segment bitmap is
able to represent a set of states: (1) clean state means that
a segment contains the free logical blocks only, (2) using state means
that a segment could contain valid, invalid, and free logical blocks,
(3) used state means that a segment contains the valid logical
blocks only, (4) pre-dirty state means that a segment contains valid
and invalid logical blocks, (5) dirty state means that a segment
contains only invalid blocks, (6) reserved state is used for
reservation the segment numbers for some metadata structures
(for example, for the case of superblock segment).

PEB migration scheme implies that segments are able to migrate from
one state into another one without the explicit using of GC subsystem.
For example, if some segment receives enough truncate operations (data
invalidation) then the segment could change the used state in pre-dirty
state. Additionally, the segment is able to migrate from pre-dirty into
using state by means of PEBs migration in the case of receiving enough
data update requests. As a result, the segment in using state could be
selected like the current segment without any GC-related activity. However,
a segment is able to stick in pre-dirty state in the case of absence
the update requests. Finally, such situation can be resolved by GC
subsystem by means of valid blocks migration in the background and pre-dirty
segment can be transformed into the using state.

Segment bitmap is implemented like the bitmap metadata structure
that is split on several fragments. Every fragment is stored into a log of
specialized PEB. As a result, the full size of segment bitmap and
PEB’s capacity define the number of fragments. The mkfs utility reserves
the necessary number of segments for storing the segment bitmap’s fragments
during a SSDFS file system’s volume creation. Finally, the numbers of
reserved segments are stored into the superblock metadata structure.
The segment bitmap ”lives” in the same set of reserved segments during
the whole lifetime of the volume. However, the update operations of segment
bitmap could trigger the PEBs migration in the case of exhaustion of any
PEB used for keeping the segment bitmap’s content.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/segment_bitmap.c        | 1807 ++++++++++++++++++++++++++++++
 fs/ssdfs/segment_bitmap.h        |  459 ++++++++
 fs/ssdfs/segment_bitmap_tables.c |  814 ++++++++++++++
 3 files changed, 3080 insertions(+)
 create mode 100644 fs/ssdfs/segment_bitmap.c
 create mode 100644 fs/ssdfs/segment_bitmap.h
 create mode 100644 fs/ssdfs/segment_bitmap_tables.c

diff --git a/fs/ssdfs/segment_bitmap.c b/fs/ssdfs/segment_bitmap.c
new file mode 100644
index 000000000000..633cd4cfca0a
--- /dev/null
+++ b/fs/ssdfs/segment_bitmap.c
@@ -0,0 +1,1807 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment_bitmap.c - segment bitmap implementation.
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
+#include <linux/wait.h>
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
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "extents_tree.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_seg_bmap_page_leaks;
+atomic64_t ssdfs_seg_bmap_memory_leaks;
+atomic64_t ssdfs_seg_bmap_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_seg_bmap_cache_leaks_increment(void *kaddr)
+ * void ssdfs_seg_bmap_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_seg_bmap_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_seg_bmap_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_seg_bmap_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_seg_bmap_kfree(void *kaddr)
+ * struct page *ssdfs_seg_bmap_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_seg_bmap_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_seg_bmap_free_page(struct page *page)
+ * void ssdfs_seg_bmap_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(seg_bmap)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(seg_bmap)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_seg_bmap_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_seg_bmap_page_leaks, 0);
+	atomic64_set(&ssdfs_seg_bmap_memory_leaks, 0);
+	atomic64_set(&ssdfs_seg_bmap_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_seg_bmap_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_seg_bmap_page_leaks) != 0) {
+		SSDFS_ERR("SEGMENT BITMAP: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_seg_bmap_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_seg_bmap_memory_leaks) != 0) {
+		SSDFS_ERR("SEGMENT BITMAP: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_seg_bmap_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_seg_bmap_cache_leaks) != 0) {
+		SSDFS_ERR("SEGMENT BITMAP: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_seg_bmap_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+extern const bool detect_clean_seg[U8_MAX + 1];
+extern const bool detect_data_using_seg[U8_MAX + 1];
+extern const bool detect_lnode_using_seg[U8_MAX + 1];
+extern const bool detect_hnode_using_seg[U8_MAX + 1];
+extern const bool detect_idxnode_using_seg[U8_MAX + 1];
+extern const bool detect_used_seg[U8_MAX + 1];
+extern const bool detect_pre_dirty_seg[U8_MAX + 1];
+extern const bool detect_dirty_seg[U8_MAX + 1];
+extern const bool detect_bad_seg[U8_MAX + 1];
+extern const bool detect_clean_using_mask[U8_MAX + 1];
+extern const bool detect_used_dirty_mask[U8_MAX + 1];
+
+static
+void ssdfs_segbmap_invalidate_folio(struct folio *folio, size_t offset,
+				    size_t length)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("do nothing: offset %zu, length %zu\n",
+		  offset, length);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_segbmap_release_folio() - Release fs-specific metadata on a folio.
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
+bool ssdfs_segbmap_release_folio(struct folio *folio, gfp_t gfp)
+{
+	return false;
+}
+
+static
+bool ssdfs_segbmap_noop_dirty_folio(struct address_space *mapping,
+				    struct folio *folio)
+{
+	return true;
+}
+
+const struct address_space_operations ssdfs_segbmap_aops = {
+	.invalidate_folio	= ssdfs_segbmap_invalidate_folio,
+	.release_folio		= ssdfs_segbmap_release_folio,
+	.dirty_folio		= ssdfs_segbmap_noop_dirty_folio,
+};
+
+/*
+ * ssdfs_segbmap_mapping_init() - segment bitmap's mapping init
+ */
+static inline
+void ssdfs_segbmap_mapping_init(struct address_space *mapping,
+				struct inode *inode)
+{
+	address_space_init_once(mapping);
+	mapping->a_ops = &ssdfs_segbmap_aops;
+	mapping->host = inode;
+	mapping->flags = 0;
+	atomic_set(&mapping->i_mmap_writable, 0);
+	mapping_set_gfp_mask(mapping, GFP_KERNEL);
+	mapping->private_data = NULL;
+	mapping->writeback_index = 0;
+	inode->i_mapping = mapping;
+}
+
+static const struct inode_operations def_segbmap_ino_iops;
+static const struct file_operations def_segbmap_ino_fops;
+static const struct address_space_operations def_segbmap_ino_aops;
+
+/*
+ * ssdfs_segbmap_get_inode() - create segment bitmap's inode object
+ * @fsi: file system info object
+ */
+static
+int ssdfs_segbmap_get_inode(struct ssdfs_fs_info *fsi)
+{
+	struct inode *inode;
+	struct ssdfs_inode_info *ii;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi %p\n", fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inode = iget_locked(fsi->sb, SSDFS_SEG_BMAP_INO);
+	if (unlikely(!inode)) {
+		err = -ENOMEM;
+		SSDFS_ERR("unable to allocate segment bitmap inode: "
+			  "err %d\n",
+			  err);
+		return err;
+	}
+
+	BUG_ON(!(inode->i_state & I_NEW));
+
+	inode->i_mode = S_IFREG;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_KERNEL);
+
+	inode->i_op = &def_segbmap_ino_iops;
+	inode->i_fop = &def_segbmap_ino_fops;
+	inode->i_mapping->a_ops = &def_segbmap_ino_aops;
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
+	fsi->segbmap_inode = inode;
+
+	return 0;
+}
+
+/*
+ * ssdfs_segbmap_define_segments() - determine segment bitmap segment numbers
+ * @fsi: file system info object
+ * @array_type: array type (main or copy)
+ * @segbmap: pointer on segment bitmap object [out]
+ *
+ * The method tries to retrieve segment numbers from volume header.
+ *
+ * RETURN:
+ * [success] - count of valid segment numbers in the array.
+ * [failure] - error code:
+ *
+ * %-EIO     - volume header is corrupted.
+ */
+static
+int ssdfs_segbmap_define_segments(struct ssdfs_fs_info *fsi,
+				  int array_type,
+				  struct ssdfs_segment_bmap *segbmap)
+{
+	u64 seg;
+	u8 count = 0;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !segbmap);
+	BUG_ON(array_type >= SSDFS_SEGBMAP_SEG_COPY_MAX);
+
+	SSDFS_DBG("fsi %p, array_type %#x, segbmap %p\n",
+		  fsi, array_type, segbmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_SEGBMAP_SEGS; i++)
+		segbmap->seg_numbers[i][array_type] = U64_MAX;
+
+	for (i = 0; i < SSDFS_SEGBMAP_SEGS; i++) {
+		seg = le64_to_cpu(fsi->vh->segbmap.segs[i][array_type]);
+
+		if (seg == U64_MAX)
+			break;
+		else if (seg >= fsi->nsegs) {
+			SSDFS_ERR("invalid segment %llu, nsegs %llu\n",
+				  seg, fsi->nsegs);
+			return -EIO;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("segbmap: seg[%d][%d] = %llu\n",
+			  i, array_type, seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		segbmap->seg_numbers[i][array_type] = seg;
+		count++;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("segbmap segments count %u\n", count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return count;
+}
+
+/*
+ * ssdfs_segbmap_create_segments() - create segbmap's segment objects
+ * @fsi: file system info object
+ * @array_type: array type (main or copy)
+ * @segbmap: pointer on segment bitmap object [out]
+ */
+static
+int ssdfs_segbmap_create_segments(struct ssdfs_fs_info *fsi,
+				  int array_type,
+				  struct ssdfs_segment_bmap *segbmap)
+{
+	u64 seg;
+	struct ssdfs_segment_info **kaddr;
+	u16 log_pages;
+	u16 create_threads;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !segbmap);
+	BUG_ON(array_type >= SSDFS_SEGBMAP_SEG_COPY_MAX);
+	BUG_ON(!rwsem_is_locked(&fsi->volume_sem));
+
+	SSDFS_DBG("fsi %p, array_type %#x, segbmap %p\n",
+		  fsi, array_type, segbmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	log_pages = le16_to_cpu(fsi->vh->segbmap_log_pages);
+	create_threads = fsi->create_threads_per_seg;
+
+	for (i = 0; i < segbmap->segs_count; i++) {
+		seg = segbmap->seg_numbers[i][array_type];
+		kaddr = &segbmap->segs[i][array_type];
+		BUG_ON(*kaddr != NULL);
+
+		*kaddr = ssdfs_segment_allocate_object(seg);
+		if (IS_ERR_OR_NULL(*kaddr)) {
+			err = !*kaddr ? -ENOMEM : PTR_ERR(*kaddr);
+			*kaddr = NULL;
+			SSDFS_ERR("fail to allocate segment object: "
+				  "seg %llu, err %d\n",
+				  seg, err);
+			return err;
+		}
+
+		err = ssdfs_segment_create_object(fsi, seg,
+						  SSDFS_SEG_LEAF_NODE_USING,
+						  SSDFS_SEGBMAP_SEG_TYPE,
+						  log_pages,
+						  create_threads,
+						  *kaddr);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			return err;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to create segment: "
+				  "seg %llu, err %d\n",
+				  seg, err);
+			return err;
+		}
+
+		ssdfs_segment_get_object(*kaddr);
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_segbmap_destroy_segments() - destroy segbmap's segment objects
+ * @segbmap: pointer on segment bitmap object
+ */
+static
+void ssdfs_segbmap_destroy_segments(struct ssdfs_segment_bmap *segbmap)
+{
+	struct ssdfs_segment_info *si;
+	int i, j;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+
+	SSDFS_DBG("segbmap %p\n", segbmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < segbmap->segs_count; i++) {
+		for (j = 0; j < SSDFS_SEGBMAP_SEG_COPY_MAX; j++) {
+			si = segbmap->segs[i][j];
+
+			if (!si)
+				continue;
+
+			ssdfs_segment_put_object(si);
+			err = ssdfs_segment_destroy_object(si);
+			if (unlikely(err == -EBUSY))
+				BUG();
+			else if (unlikely(err)) {
+				SSDFS_WARN("issue during segment destroy: "
+					   "err %d\n",
+					   err);
+			}
+		}
+	}
+}
+
+/*
+ * ssdfs_segbmap_segment_init() - issue segbmap init command for PEBs
+ * @segbmap: pointer on segment bitmap object
+ * @si: segment object
+ * @seg_index: index of segment in the sequence
+ */
+static
+int ssdfs_segbmap_segment_init(struct ssdfs_segment_bmap *segbmap,
+				struct ssdfs_segment_info *si,
+				int seg_index)
+{
+	u64 logical_offset;
+	u32 fragment_bytes = segbmap->fragment_size;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+
+	SSDFS_DBG("si %p, seg %llu, seg_index %d\n",
+		  si, si->seg_id, seg_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < si->pebs_count; i++) {
+		struct ssdfs_peb_container *pebc = &si->peb_array[i];
+		struct ssdfs_segment_request *req;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("i %d, pebc %p\n", i, pebc);
+
+		BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (is_peb_container_empty(pebc)) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("PEB container empty: "
+				  "seg %llu, peb_index %d\n",
+				  si->seg_id, i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req)) {
+			err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+			req = NULL;
+			SSDFS_ERR("fail to allocate segment request: err %d\n",
+				  err);
+			return err;
+		}
+
+		ssdfs_request_init(req);
+		ssdfs_get_request(req);
+
+		logical_offset =
+			(u64)segbmap->fragments_per_peb * fragment_bytes;
+		logical_offset *= si->pebs_count;
+		logical_offset *= seg_index;
+		ssdfs_request_prepare_logical_extent(SSDFS_MAPTBL_INO,
+						     logical_offset,
+						     fragment_bytes,
+						     0, 0, req);
+		ssdfs_request_define_segment(si->seg_id, req);
+
+		ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+						    SSDFS_READ_INIT_SEGBMAP,
+						    SSDFS_REQ_ASYNC,
+						    req);
+		ssdfs_peb_read_request_cno(pebc);
+		ssdfs_requests_queue_add_tail(&pebc->read_rq, req);
+	}
+
+	wake_up_all(&si->wait_queue[SSDFS_PEB_READ_THREAD]);
+
+	return 0;
+}
+
+/*
+ * ssdfs_segbmap_init() - issue segbmap init command for all segments
+ * @segbmap: pointer on segment bitmap object
+ */
+static
+int ssdfs_segbmap_init(struct ssdfs_segment_bmap *segbmap)
+{
+	struct ssdfs_segment_info *si;
+	int i, j;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+
+	SSDFS_DBG("segbmap %p, segbmap->segs_count %u\n",
+		  segbmap, segbmap->segs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < segbmap->segs_count; i++) {
+		for (j = 0; j < SSDFS_SEGBMAP_SEG_COPY_MAX; j++) {
+			si = segbmap->segs[i][j];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("i %d, j %d, si %p\n", i, j, si);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (!si)
+				continue;
+
+			err = ssdfs_segbmap_segment_init(segbmap, si, i);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to init segment: "
+					  "seg %llu, err %d\n",
+					  si->seg_id, err);
+				return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_segbmap_create_fragment_bitmaps() - create fragment bitmaps
+ * @segbmap: pointer on segment bitmap object
+ */
+static
+int ssdfs_segbmap_create_fragment_bitmaps(struct ssdfs_segment_bmap *segbmap)
+{
+	size_t bmap_bytes;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(segbmap->fragments_count == 0);
+
+	SSDFS_DBG("segbmap %p\n", segbmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bmap_bytes = segbmap->fragments_count + BITS_PER_LONG - 1;
+	bmap_bytes /= BITS_PER_BYTE;
+
+	for (i = 0; i < SSDFS_SEGBMAP_FBMAP_TYPE_MAX; i++) {
+		unsigned long **ptr = &segbmap->fbmap[i];
+
+		BUG_ON(*ptr);
+
+		*ptr = ssdfs_seg_bmap_kzalloc(bmap_bytes, GFP_KERNEL);
+		if (!*ptr) {
+			err = -ENOMEM;
+			SSDFS_ERR("fail to allocate fbmap: "
+				  "index %d\n", i);
+			goto free_fbmaps;
+		}
+	}
+
+	return 0;
+
+free_fbmaps:
+	for (; i >= 0; i--)
+		ssdfs_seg_bmap_kfree(segbmap->fbmap[i]);
+
+	return err;
+}
+
+/*
+ * ssdfs_segbmap_destroy_fragment_bitmaps() - destroy fragment bitmaps
+ * @segbmap: pointer on segment bitmap object
+ */
+static inline
+void ssdfs_segbmap_destroy_fragment_bitmaps(struct ssdfs_segment_bmap *segbmap)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+
+	SSDFS_DBG("segbmap %p\n", segbmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_SEGBMAP_FBMAP_TYPE_MAX; i++)
+		ssdfs_seg_bmap_kfree(segbmap->fbmap[i]);
+}
+
+/*
+ * ssdfs_segbmap_create() - create segment bitmap object
+ * @fsi: file system info object
+ *
+ * This method tries to create segment bitmap object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO        - volume header is corrupted.
+ * %-EROFS      - segbmap's flags contain error field.
+ * %-EOPNOTSUPP - fragment size isn't supported.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segbmap_create(struct ssdfs_fs_info *fsi)
+{
+	struct ssdfs_segment_bmap *ptr;
+	size_t segbmap_obj_size = sizeof(struct ssdfs_segment_bmap);
+	size_t frag_desc_size = sizeof(struct ssdfs_segbmap_fragment_desc);
+	int count;
+	u32 calculated;
+	void *kaddr;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, segs_count %llu\n", fsi, fsi->nsegs);
+#else
+	SSDFS_DBG("fsi %p, segs_count %llu\n", fsi, fsi->nsegs);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	kaddr = ssdfs_seg_bmap_kzalloc(segbmap_obj_size, GFP_KERNEL);
+	if (!kaddr) {
+		SSDFS_ERR("fail to allocate segment bitmap object\n");
+		return -ENOMEM;
+	}
+
+	fsi->segbmap = ptr = (struct ssdfs_segment_bmap *)kaddr;
+
+	ptr->fsi = fsi;
+
+	init_rwsem(&fsi->segbmap->resize_lock);
+
+	ptr->flags = le16_to_cpu(fsi->vh->segbmap.flags);
+	if (ptr->flags & ~SSDFS_SEGBMAP_FLAGS_MASK) {
+		err = -EIO;
+		SSDFS_CRIT("segbmap header corrupted: "
+			   "unknown flags %#x\n",
+			   ptr->flags);
+		goto free_segbmap_object;
+	}
+
+	if (ptr->flags & SSDFS_SEGBMAP_ERROR) {
+		err = -EROFS;
+		SSDFS_NOTICE("segment bitmap has corrupted state: "
+			     "Please, run fsck utility\n");
+		goto free_segbmap_object;
+	}
+
+	ptr->items_count = fsi->nsegs;
+
+	ptr->bytes_count = le32_to_cpu(fsi->vh->segbmap.bytes_count);
+	if (ptr->bytes_count != SEG_BMAP_BYTES(ptr->items_count)) {
+		err = -EIO;
+		SSDFS_CRIT("segbmap header corrupted: "
+			   "bytes_count %u != calculated %u\n",
+			   ptr->bytes_count,
+			   SEG_BMAP_BYTES(ptr->items_count));
+		goto free_segbmap_object;
+	}
+
+	ptr->fragment_size = le16_to_cpu(fsi->vh->segbmap.fragment_size);
+	if (ptr->fragment_size != PAGE_SIZE) {
+		err = -EOPNOTSUPP;
+		SSDFS_ERR("fragment size %u isn't supported\n",
+			  ptr->fragment_size);
+		goto free_segbmap_object;
+	}
+
+	ptr->fragments_count = le16_to_cpu(fsi->vh->segbmap.fragments_count);
+	if (ptr->fragments_count != SEG_BMAP_FRAGMENTS(ptr->items_count)) {
+		err = -EIO;
+		SSDFS_CRIT("segbmap header corrupted: "
+			   "fragments_count %u != calculated %u\n",
+			   ptr->fragments_count,
+			   SEG_BMAP_FRAGMENTS(ptr->items_count));
+		goto free_segbmap_object;
+	}
+
+	ptr->fragments_per_seg =
+		le16_to_cpu(fsi->vh->segbmap.fragments_per_seg);
+	calculated = (u32)ptr->fragments_per_seg * ptr->fragment_size;
+	if (fsi->segsize < calculated) {
+		err = -EIO;
+		SSDFS_CRIT("segbmap header corrupted: "
+			   "fragments_per_seg %u is invalid\n",
+			   ptr->fragments_per_seg);
+		goto free_segbmap_object;
+	}
+
+	ptr->fragments_per_peb =
+		le16_to_cpu(fsi->vh->segbmap.fragments_per_peb);
+	calculated = (u32)ptr->fragments_per_peb * ptr->fragment_size;
+	if (fsi->erasesize < calculated) {
+		err = -EIO;
+		SSDFS_CRIT("segbmap header corrupted: "
+			   "fragments_per_peb %u is invalid\n",
+			   ptr->fragments_per_peb);
+		goto free_segbmap_object;
+	}
+
+	init_rwsem(&ptr->search_lock);
+
+	err = ssdfs_segbmap_create_fragment_bitmaps(ptr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create fragment bitmaps\n");
+		goto free_segbmap_object;
+	}
+
+	kaddr = ssdfs_seg_bmap_kcalloc(ptr->fragments_count,
+					frag_desc_size, GFP_KERNEL);
+	if (!kaddr) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate fragment descriptors array\n");
+		goto free_fragment_bmaps;
+	}
+
+	ptr->desc_array = (struct ssdfs_segbmap_fragment_desc *)kaddr;
+
+	for (i = 0; i < ptr->fragments_count; i++)
+		init_completion(&ptr->desc_array[i].init_end);
+
+	err = ssdfs_segbmap_get_inode(fsi);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create segment bitmap's inode: "
+			  "err %d\n",
+			  err);
+		goto free_desc_array;
+	}
+
+	ssdfs_segbmap_mapping_init(&ptr->pages, fsi->segbmap_inode);
+
+	count = ssdfs_segbmap_define_segments(fsi, SSDFS_MAIN_SEGBMAP_SEG,
+					      ptr);
+	if (count < 0) {
+		err = count;
+		SSDFS_ERR("fail to get segbmap segment numbers: err %d\n",
+			  err);
+		goto free_desc_array;
+	} else if (count == 0 || count > SSDFS_SEGBMAP_SEGS) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid segbmap segment numbers count %d\n",
+			  count);
+		goto forget_inode;
+	}
+
+	ptr->segs_count = le16_to_cpu(fsi->vh->segbmap.segs_count);
+	if (ptr->segs_count != count) {
+		err = -EIO;
+		SSDFS_CRIT("segbmap header corrupted: "
+			   "segs_count %u != calculated %u\n",
+			   ptr->segs_count, count);
+		goto forget_inode;
+	}
+
+	count = ssdfs_segbmap_define_segments(fsi, SSDFS_COPY_SEGBMAP_SEG,
+					      ptr);
+	if (count < 0) {
+		err = count;
+		SSDFS_ERR("fail to get segbmap segment numbers: err %d\n",
+			  err);
+		goto free_desc_array;
+	} else if (count > SSDFS_SEGBMAP_SEGS) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid segbmap segment numbers count %d\n",
+			  count);
+		goto forget_inode;
+	}
+
+	if (ptr->flags & SSDFS_SEGBMAP_HAS_COPY) {
+		if (count == 0) {
+			err = -EIO;
+			SSDFS_CRIT("segbmap header corrupted: "
+				   "copy segments' chain is absent\n");
+			goto forget_inode;
+		} else if (count != ptr->segs_count) {
+			SSDFS_ERR("count %u != ptr->segs_count %u\n",
+				  count, ptr->segs_count);
+			goto forget_inode;
+		}
+	} else {
+		if (count != 0) {
+			err = -EIO;
+			SSDFS_CRIT("segbmap header corrupted: "
+				   "copy segments' chain is present\n");
+			goto forget_inode;
+		}
+	}
+
+	err = ssdfs_segbmap_create_segments(fsi, SSDFS_MAIN_SEGBMAP_SEG, ptr);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		goto destroy_seg_objects;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to create segbmap's segment objects: "
+			  "err %d\n",
+			  err);
+		goto destroy_seg_objects;
+	}
+
+	if (ptr->flags & SSDFS_SEGBMAP_HAS_COPY) {
+		err = ssdfs_segbmap_create_segments(fsi,
+						    SSDFS_COPY_SEGBMAP_SEG,
+						    ptr);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create segbmap's segment objects: "
+				  "err %d\n",
+				  err);
+			goto destroy_seg_objects;
+		}
+	}
+
+	err = ssdfs_segbmap_init(ptr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init segment bitmap: err %d\n",
+			  err);
+		goto destroy_seg_objects;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("DONE: create segment bitmap\n");
+#else
+	SSDFS_DBG("DONE: create segment bitmap\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+destroy_seg_objects:
+	ssdfs_segbmap_destroy_segments(fsi->segbmap);
+
+forget_inode:
+	iput(fsi->segbmap_inode);
+
+free_desc_array:
+	ssdfs_seg_bmap_kfree(fsi->segbmap->desc_array);
+
+free_fragment_bmaps:
+	ssdfs_segbmap_destroy_fragment_bitmaps(fsi->segbmap);
+
+free_segbmap_object:
+	ssdfs_seg_bmap_kfree(fsi->segbmap);
+
+	fsi->segbmap = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(err == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_segbmap_destroy() - destroy segment bitmap object
+ * @fsi: file system info object
+ *
+ * This method destroys segment bitmap object.
+ */
+void ssdfs_segbmap_destroy(struct ssdfs_fs_info *fsi)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("segbmap %p\n", fsi->segbmap);
+#else
+	SSDFS_DBG("segbmap %p\n", fsi->segbmap);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!fsi->segbmap)
+		return;
+
+	inode_lock(fsi->segbmap_inode);
+	down_write(&fsi->segbmap->resize_lock);
+	down_write(&fsi->segbmap->search_lock);
+
+	ssdfs_segbmap_destroy_segments(fsi->segbmap);
+
+	if (mapping_tagged(&fsi->segbmap->pages, PAGECACHE_TAG_DIRTY)) {
+		ssdfs_fs_error(fsi->sb, __FILE__, __func__, __LINE__,
+				"segment bitmap is dirty on destruction\n");
+	}
+
+	for (i = 0; i < fsi->segbmap->fragments_count; i++) {
+		struct page *page;
+
+		xa_lock_irq(&fsi->segbmap->pages.i_pages);
+		page = __xa_erase(&fsi->segbmap->pages.i_pages, i);
+		xa_unlock_irq(&fsi->segbmap->pages.i_pages);
+
+		if (!page) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %d is NULL\n", i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		page->mapping = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_put_page(page);
+		ssdfs_seg_bmap_free_page(page);
+	}
+
+	if (fsi->segbmap->pages.nrpages != 0)
+		truncate_inode_pages(&fsi->segbmap->pages, 0);
+
+	ssdfs_segbmap_destroy_fragment_bitmaps(fsi->segbmap);
+
+	ssdfs_seg_bmap_kfree(fsi->segbmap->desc_array);
+
+	up_write(&fsi->segbmap->resize_lock);
+	up_write(&fsi->segbmap->search_lock);
+	inode_unlock(fsi->segbmap_inode);
+
+	iput(fsi->segbmap_inode);
+	ssdfs_seg_bmap_kfree(fsi->segbmap);
+	fsi->segbmap = NULL;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * ssdfs_segbmap_get_state_from_byte() - retrieve state of item from byte
+ * @byte_ptr: pointer on byte
+ * @byte_item: index of item in byte
+ */
+static inline
+int ssdfs_segbmap_get_state_from_byte(u8 *byte_ptr, u32 byte_item)
+{
+	u32 shift;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("byte_ptr %p, byte_item %u\n",
+		  byte_ptr, byte_item);
+
+	BUG_ON(!byte_ptr);
+	BUG_ON(byte_item >= SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	shift = byte_item * SSDFS_SEG_STATE_BITS;
+	return (int)((*byte_ptr >> shift) & SSDFS_SEG_STATE_MASK);
+}
+
+/*
+ * ssdfs_segbmap_check_fragment_header() - check fragment's header
+ * @pebc: pointer on PEB container
+ * @seg_index: index of segment in segbmap's segments sequence
+ * @sequence_id: sequence ID of fragment
+ * @page: page contains fragment
+ *
+ * This method tries to check fragment's header.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO     - fragment is corrupted.
+ */
+int ssdfs_segbmap_check_fragment_header(struct ssdfs_peb_container *pebc,
+					u16 seg_index,
+					u16 sequence_id,
+					struct page *page)
+{
+	struct ssdfs_segment_bmap *segbmap;
+	struct ssdfs_segbmap_fragment_header *hdr;
+	size_t hdr_size = sizeof(struct ssdfs_segbmap_fragment_header);
+	void *kaddr;
+	u16 fragment_bytes;
+	__le32 old_csum, csum;
+	u16 total_segs, calculated_segs;
+	u16 clean_or_using_segs, used_or_dirty_segs, bad_segs;
+#ifdef CONFIG_SSDFS_DEBUG
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS);
+	u32 byte_offset;
+	u8 *byte_ptr;
+	u32 byte_item;
+	int state = SSDFS_SEG_STATE_MAX;
+	u16 clean_or_using_segs_calculated;
+	u16 used_or_dirty_segs_calculated;
+	u16 bad_segs_calculated;
+	int i;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!page);
+
+	SSDFS_DBG("seg %llu, peb_index %u, page %p\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	segbmap = pebc->parent_si->fsi->segbmap;
+
+	kaddr = kmap_local_page(page);
+
+	hdr = SSDFS_SBMP_FRAG_HDR(kaddr);
+
+	if (le32_to_cpu(hdr->magic) != SSDFS_SEGBMAP_HDR_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "invalid magic\n");
+		goto fragment_hdr_corrupted;
+	}
+
+	fragment_bytes = le16_to_cpu(hdr->fragment_bytes);
+	if (fragment_bytes > segbmap->fragment_size) {
+		err = -EIO;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "invalid fragment size %u\n",
+			  fragment_bytes);
+		goto fragment_hdr_corrupted;
+	}
+
+	old_csum = hdr->checksum;
+	hdr->checksum = 0;
+	csum = ssdfs_crc32_le(kaddr, fragment_bytes);
+	hdr->checksum = old_csum;
+
+	if (old_csum != csum) {
+		err = -EIO;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "old_csum %u != csum %u\n",
+			  le32_to_cpu(old_csum),
+			  le32_to_cpu(csum));
+		goto fragment_hdr_corrupted;
+	}
+
+	if (seg_index != le16_to_cpu(hdr->seg_index)) {
+		err = -EIO;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "seg_index %u != hdr->seg_index %u\n",
+			  seg_index, le16_to_cpu(hdr->seg_index));
+		goto fragment_hdr_corrupted;
+	}
+
+	if (pebc->peb_index != le16_to_cpu(hdr->peb_index)) {
+		err = -EIO;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "peb_index %u != hdr->peb_index %u\n",
+			  pebc->peb_index,
+			  le16_to_cpu(hdr->peb_index));
+		goto fragment_hdr_corrupted;
+	}
+
+	if (hdr->seg_type >= SSDFS_SEGBMAP_SEG_COPY_MAX) {
+		err = -EIO;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "invalid seg_type %u\n",
+			  hdr->seg_type);
+		goto fragment_hdr_corrupted;
+	}
+
+	if (sequence_id != le16_to_cpu(hdr->sequence_id)) {
+		err = -EIO;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "sequence_id %u != hdr->sequence_id %u\n",
+			  sequence_id,
+			  le16_to_cpu(hdr->sequence_id));
+		goto fragment_hdr_corrupted;
+	}
+
+	total_segs = le16_to_cpu(hdr->total_segs);
+	if (fragment_bytes != (SEG_BMAP_BYTES(total_segs) + hdr_size)) {
+		err = -EIO;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "invalid fragment's items count %u\n",
+			  total_segs);
+		goto fragment_hdr_corrupted;
+	}
+
+	clean_or_using_segs = le16_to_cpu(hdr->clean_or_using_segs);
+	used_or_dirty_segs = le16_to_cpu(hdr->used_or_dirty_segs);
+	bad_segs = le16_to_cpu(hdr->bad_segs);
+	calculated_segs = clean_or_using_segs + used_or_dirty_segs + bad_segs;
+
+	if (total_segs != calculated_segs) {
+		err = -EIO;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "clean_or_using_segs %u, "
+			  "used_or_dirty_segs %u, "
+			  "bad_segs %u, total_segs %u\n",
+			  clean_or_using_segs, used_or_dirty_segs,
+			  bad_segs, total_segs);
+		goto fragment_hdr_corrupted;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	clean_or_using_segs_calculated = 0;
+	used_or_dirty_segs_calculated = 0;
+	bad_segs_calculated = 0;
+
+	for (i = 0; i < total_segs; i++) {
+		byte_offset = ssdfs_segbmap_get_item_byte_offset(i);
+
+		if (byte_offset >= PAGE_SIZE) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid byte_offset %u\n",
+				  byte_offset);
+			goto fragment_hdr_corrupted;
+		}
+
+		byte_item = i - ((byte_offset - hdr_size) * items_per_byte);
+
+		byte_ptr = (u8 *)kaddr + byte_offset;
+		state = ssdfs_segbmap_get_state_from_byte(byte_ptr, byte_item);
+
+		switch (state) {
+		case SSDFS_SEG_CLEAN:
+		case SSDFS_SEG_DATA_USING:
+		case SSDFS_SEG_LEAF_NODE_USING:
+		case SSDFS_SEG_HYBRID_NODE_USING:
+		case SSDFS_SEG_INDEX_NODE_USING:
+		case SSDFS_SEG_RESERVED:
+			clean_or_using_segs_calculated++;
+			break;
+
+		case SSDFS_SEG_USED:
+		case SSDFS_SEG_PRE_DIRTY:
+		case SSDFS_SEG_DIRTY:
+			used_or_dirty_segs_calculated++;
+			break;
+
+		case SSDFS_SEG_BAD:
+			bad_segs_calculated++;
+			break;
+
+		default:
+			err = -EIO;
+			SSDFS_ERR("unexpected state %#x\n",
+				  state);
+			goto fragment_hdr_corrupted;
+		}
+	}
+
+	if (clean_or_using_segs_calculated != clean_or_using_segs) {
+		err = -EIO;
+		SSDFS_ERR("calculated %u != clean_or_using_segs %u\n",
+			  clean_or_using_segs_calculated,
+			  clean_or_using_segs);
+	}
+
+	if (used_or_dirty_segs_calculated != used_or_dirty_segs) {
+		err = -EIO;
+		SSDFS_ERR("calculated %u != used_or_dirty_segs %u\n",
+			  used_or_dirty_segs_calculated,
+			  used_or_dirty_segs);
+	}
+
+	if (bad_segs_calculated != bad_segs) {
+		err = -EIO;
+		SSDFS_ERR("calculated %u != bad_segs %u\n",
+			  bad_segs_calculated,
+			  bad_segs);
+	}
+
+	if (err)
+		goto fragment_hdr_corrupted;
+#endif /* CONFIG_SSDFS_DEBUG */
+
+fragment_hdr_corrupted:
+	kunmap_local(kaddr);
+
+	return err;
+}
+
+/*
+ * ssdfs_segbmap_fragment_init() - init segbmap's fragment
+ * @pebc: pointer on PEB container
+ * @sequence_id: sequence ID of fragment
+ * @page: page contains fragment
+ * @state: state of fragment
+ */
+int ssdfs_segbmap_fragment_init(struct ssdfs_peb_container *pebc,
+				u16 sequence_id,
+				struct page *page,
+				int state)
+{
+	struct ssdfs_segment_bmap *segbmap;
+	struct ssdfs_segbmap_fragment_header *hdr;
+	struct ssdfs_segbmap_fragment_desc *desc;
+	unsigned long *fbmap;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!pebc->parent_si->fsi->segbmap || !page);
+	BUG_ON(state <= SSDFS_SEGBMAP_FRAG_CREATED ||
+		state >= SSDFS_SEGBMAP_FRAG_DIRTY);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, peb_index %u, "
+		  "sequence_id %u, page %p, "
+		  "state %#x\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  sequence_id, page, state);
+#else
+	SSDFS_DBG("seg %llu, peb_index %u, "
+		  "sequence_id %u, page %p, "
+		  "state %#x\n",
+		  pebc->parent_si->seg_id, pebc->peb_index,
+		  sequence_id, page, state);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	segbmap = pebc->parent_si->fsi->segbmap;
+
+	inode_lock_shared(pebc->parent_si->fsi->segbmap_inode);
+
+	ssdfs_get_page(page);
+	page->index = sequence_id;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&segbmap->search_lock);
+
+	desc = &segbmap->desc_array[sequence_id];
+
+	xa_lock_irq(&segbmap->pages.i_pages);
+	err = __xa_insert(&segbmap->pages.i_pages,
+			 sequence_id, page, GFP_NOFS);
+	if (unlikely(err < 0)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fail to add page %u into address space: err %d\n",
+			  sequence_id, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page->mapping = NULL;
+		ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else {
+		page->mapping = &segbmap->pages;
+		segbmap->pages.nrpages++;
+	}
+	xa_unlock_irq(&segbmap->pages.i_pages);
+
+	if (unlikely(err))
+		goto unlock_search_lock;
+
+	if (desc->state != SSDFS_SEGBMAP_FRAG_CREATED) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to initialize segbmap fragment\n");
+	} else {
+		hdr = SSDFS_SBMP_FRAG_HDR(kmap_local_page(page));
+		desc->total_segs = le16_to_cpu(hdr->total_segs);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("total_segs %u, clean_or_using_segs %u, "
+			  "used_or_dirty_segs %u, bad_segs %u\n",
+			  le16_to_cpu(hdr->total_segs),
+			  le16_to_cpu(hdr->clean_or_using_segs),
+			  le16_to_cpu(hdr->used_or_dirty_segs),
+			  le16_to_cpu(hdr->bad_segs));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_CLEAN_USING_FBMAP];
+		desc->clean_or_using_segs =
+			le16_to_cpu(hdr->clean_or_using_segs);
+		if (desc->clean_or_using_segs == 0)
+			bitmap_clear(fbmap, sequence_id, 1);
+		else
+			bitmap_set(fbmap, sequence_id, 1);
+
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_USED_DIRTY_FBMAP];
+		desc->used_or_dirty_segs =
+			le16_to_cpu(hdr->used_or_dirty_segs);
+		if (desc->used_or_dirty_segs == 0)
+			bitmap_clear(fbmap, sequence_id, 1);
+		else
+			bitmap_set(fbmap, sequence_id, 1);
+
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_BAD_FBMAP];
+		desc->bad_segs = le16_to_cpu(hdr->bad_segs);
+		if (desc->bad_segs == 0)
+			bitmap_clear(fbmap, sequence_id, 1);
+		else
+			bitmap_set(fbmap, sequence_id, 1);
+
+		desc->state = state;
+		kunmap_local(hdr);
+	}
+
+	ssdfs_seg_bmap_account_page(page);
+
+unlock_search_lock:
+	complete_all(&desc->init_end);
+	up_write(&segbmap->search_lock);
+	inode_unlock_shared(pebc->parent_si->fsi->segbmap_inode);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_sb_segbmap_header_correct_state() - save segbmap's state in superblock
+ * @segbmap: pointer on segment bitmap object
+ */
+static
+void ssdfs_sb_segbmap_header_correct_state(struct ssdfs_segment_bmap *segbmap)
+{
+	struct ssdfs_segbmap_sb_header *hdr;
+	__le64 seg;
+	int i, j;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(!rwsem_is_locked(&segbmap->resize_lock));
+	BUG_ON(!rwsem_is_locked(&segbmap->fsi->volume_sem));
+
+	SSDFS_DBG("segbmap %p\n",
+		  segbmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = &segbmap->fsi->vh->segbmap;
+
+	hdr->fragments_count = cpu_to_le16(segbmap->fragments_count);
+	hdr->fragments_per_seg = cpu_to_le16(segbmap->fragments_per_seg);
+	hdr->fragments_per_peb = cpu_to_le16(segbmap->fragments_per_peb);
+	hdr->fragment_size = cpu_to_le16(segbmap->fragment_size);
+
+	hdr->bytes_count = cpu_to_le32(segbmap->bytes_count);
+	hdr->flags = cpu_to_le16(segbmap->flags);
+	hdr->segs_count = cpu_to_le16(segbmap->segs_count);
+
+	for (i = 0; i < segbmap->segs_count; i++) {
+		j = SSDFS_MAIN_SEGBMAP_SEG;
+		seg = cpu_to_le64(segbmap->seg_numbers[i][j]);
+		hdr->segs[i][j] = seg;
+
+		j = SSDFS_COPY_SEGBMAP_SEG;
+		seg = cpu_to_le64(segbmap->seg_numbers[i][j]);
+		hdr->segs[i][j] = seg;
+	}
+}
+
+/*
+ * ssdfs_segbmap_copy_dirty_fragment() - copy dirty fragment into request
+ * @segbmap: pointer on segment bitmap object
+ * @fragment_index: index of fragment
+ * @page_index: index of page in request
+ * @req: segment request
+ *
+ * This method tries to copy dirty fragment into request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_segbmap_copy_dirty_fragment(struct ssdfs_segment_bmap *segbmap,
+				      u16 fragment_index,
+				      u16 page_index,
+				      struct ssdfs_segment_request *req)
+{
+	struct ssdfs_segbmap_fragment_desc *desc;
+	struct ssdfs_segbmap_fragment_header *hdr;
+	struct page *dpage, *spage;
+	void *kaddr;
+	u16 fragment_bytes;
+	__le32 old_csum, csum;
+	u16 total_segs;
+	u16 clean_or_using_segs;
+	u16 used_or_dirty_segs;
+	u16 bad_segs;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap || !req);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+	BUG_ON(page_index >= PAGEVEC_SIZE);
+
+	SSDFS_DBG("segbmap %p, fragment_index %u, "
+		  "page_index %u, req %p\n",
+		  segbmap, fragment_index, page_index, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	desc = &segbmap->desc_array[fragment_index];
+
+	if (desc->state != SSDFS_SEGBMAP_FRAG_DIRTY) {
+		SSDFS_ERR("fragment %u isn't dirty\n",
+			  fragment_index);
+		return -ERANGE;
+	}
+
+	spage = find_lock_page(&segbmap->pages, fragment_index);
+	if (!spage) {
+		SSDFS_ERR("fail to find page: fragment_index %u\n",
+			  fragment_index);
+		return -ERANGE;
+	}
+
+	ssdfs_account_locked_page(spage);
+
+	kaddr = kmap_local_page(spage);
+	hdr = SSDFS_SBMP_FRAG_HDR(kaddr);
+
+	if (le32_to_cpu(hdr->magic) != SSDFS_SEGBMAP_HDR_MAGIC) {
+		err = -ERANGE;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "invalid magic\n");
+		goto fail_copy_fragment;
+	}
+
+	fragment_bytes = le16_to_cpu(hdr->fragment_bytes);
+
+	old_csum = hdr->checksum;
+	hdr->checksum = 0;
+	csum = ssdfs_crc32_le(kaddr, fragment_bytes);
+	hdr->checksum = old_csum;
+
+	if (old_csum != csum) {
+		err = -ERANGE;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "old_csum %u != csum %u\n",
+			  le32_to_cpu(old_csum),
+			  le32_to_cpu(csum));
+		goto fail_copy_fragment;
+	}
+
+	total_segs = desc->total_segs;
+	if (total_segs != le16_to_cpu(hdr->total_segs)) {
+		err = -ERANGE;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "desc->total_segs %u != hdr->total_segs %u\n",
+			  desc->total_segs,
+			  le16_to_cpu(hdr->total_segs));
+		goto fail_copy_fragment;
+	}
+
+	clean_or_using_segs = desc->clean_or_using_segs;
+	if (clean_or_using_segs != le16_to_cpu(hdr->clean_or_using_segs)) {
+		err = -ERANGE;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "desc->clean_or_using_segs %u != "
+			  "hdr->clean_or_using_segs %u\n",
+			  desc->clean_or_using_segs,
+			  le16_to_cpu(hdr->clean_or_using_segs));
+		goto fail_copy_fragment;
+	}
+
+	used_or_dirty_segs = desc->used_or_dirty_segs;
+	if (used_or_dirty_segs != le16_to_cpu(hdr->used_or_dirty_segs)) {
+		err = -ERANGE;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "desc->used_or_dirty_segs %u != "
+			  "hdr->used_or_dirty_segs %u\n",
+			  desc->used_or_dirty_segs,
+			  le16_to_cpu(hdr->used_or_dirty_segs));
+		goto fail_copy_fragment;
+	}
+
+	bad_segs = desc->bad_segs;
+	if (bad_segs != le16_to_cpu(hdr->bad_segs)) {
+		err = -ERANGE;
+		SSDFS_ERR("segbmap header is corrupted: "
+			  "desc->bad_segs %u != "
+			  "hdr->bad_segs %u\n",
+			  desc->bad_segs,
+			  le16_to_cpu(hdr->bad_segs));
+		goto fail_copy_fragment;
+	}
+
+	dpage = req->result.pvec.pages[page_index];
+
+	if (!dpage) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid page: page_index %u\n",
+			  page_index);
+		goto fail_copy_fragment;
+	}
+
+	ssdfs_memcpy_to_page(dpage, 0, PAGE_SIZE,
+			     kaddr, 0, PAGE_SIZE,
+			     PAGE_SIZE);
+
+	SetPageUptodate(dpage);
+	if (!PageDirty(dpage))
+		ssdfs_set_page_dirty(dpage);
+	set_page_writeback(dpage);
+
+	__ssdfs_clear_dirty_page(spage);
+
+	desc->state = SSDFS_SEGBMAP_FRAG_TOWRITE;
+
+fail_copy_fragment:
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(spage);
+	ssdfs_put_page(spage);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  spage, page_ref_count(spage));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_segbmap_replicate_fragment() - replicate fragment between requests
+ * @req1: source request
+ * @page_index: index of replicated page in @req1
+ * @req2: destination request
+ */
+static
+void ssdfs_segbmap_replicate_fragment(struct ssdfs_segment_request *req1,
+				     u16 page_index,
+				     struct ssdfs_segment_request *req2)
+{
+	struct ssdfs_segbmap_fragment_header *hdr;
+	u16 fragment_bytes;
+	struct page *spage, *dpage;
+	void *kaddr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req1 || !req2);
+	BUG_ON(page_index >= pagevec_count(&req1->result.pvec));
+	BUG_ON(page_index >= pagevec_count(&req2->result.pvec));
+
+	SSDFS_DBG("req1 %p, req2 %p, page_index %u\n",
+		  req1, req2, page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spage = req1->result.pvec.pages[page_index];
+	dpage = req2->result.pvec.pages[page_index];
+
+	ssdfs_memcpy_page(dpage, 0, PAGE_SIZE,
+			  spage, 0, PAGE_SIZE,
+			  PAGE_SIZE);
+
+	kaddr = kmap_local_page(dpage);
+	hdr = SSDFS_SBMP_FRAG_HDR(kaddr);
+	hdr->seg_type = SSDFS_COPY_SEGBMAP_SEG;
+	fragment_bytes = le16_to_cpu(hdr->fragment_bytes);
+	hdr->checksum = 0;
+	hdr->checksum = ssdfs_crc32_le(kaddr, fragment_bytes);
+	flush_dcache_page(dpage);
+	kunmap_local(kaddr);
+
+	SetPageUptodate(dpage);
+	if (!PageDirty(dpage))
+		ssdfs_set_page_dirty(dpage);
+	set_page_writeback(dpage);
+}
+
+/*
+ * ssdfs_segbmap_define_volume_extent() - define volume extent for request
+ * @segbmap: pointer on segment bitmap object
+ * @req: segment request
+ * @hdr: fragment's header
+ * @fragments_count: count of fragments in the chunk
+ * @seg_index: index of segment in segbmap's array [out]
+ */
+static
+int ssdfs_segbmap_define_volume_extent(struct ssdfs_segment_bmap *segbmap,
+				    struct ssdfs_segment_request *req,
+				    struct ssdfs_segbmap_fragment_header *hdr,
+				    u16 fragments_count,
+				    u16 *seg_index)
+{
+	u16 sequence_id;
+	u16 fragment_index;
+	u32 pagesize;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap || !req || !hdr || !seg_index);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+	BUG_ON(!rwsem_is_locked(&segbmap->resize_lock));
+
+	SSDFS_DBG("segbmap %p, req %p\n",
+		  segbmap, req);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*seg_index = le16_to_cpu(hdr->seg_index);
+	sequence_id = le16_to_cpu(hdr->sequence_id);
+
+	if (*seg_index != (sequence_id / segbmap->fragments_per_seg)) {
+		SSDFS_ERR("invalid seg_index %u or sequence_id %u\n",
+			  *seg_index, sequence_id);
+		return -ERANGE;
+	}
+
+	fragment_index = sequence_id % segbmap->fragments_per_seg;
+	pagesize = segbmap->fsi->pagesize;
+
+	if (pagesize < segbmap->fragment_size) {
+		u32 pages_per_item;
+
+		pages_per_item = segbmap->fragment_size + pagesize - 1;
+		pages_per_item /= pagesize;
+		req->place.start.blk_index = fragment_index * pages_per_item;
+		req->place.len = fragments_count * pages_per_item;
+	} else if (pagesize > segbmap->fragment_size) {
+		u32 items_per_page;
+
+		items_per_page = pagesize + segbmap->fragment_size - 1;
+		items_per_page /= segbmap->fragment_size;
+		req->place.start.blk_index = fragment_index / items_per_page;
+		req->place.len = fragments_count + items_per_page - 1;
+		req->place.len /= items_per_page;
+	} else {
+		req->place.start.blk_index = fragment_index;
+		req->place.len = fragments_count;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_segbmap_issue_fragments_update() - issue fragment updates
+ * @segbmap: pointer on segment bitmap object
+ * @start_fragment: start fragment number for dirty bitmap
+ * @fragment_size: size of fragment in bytes
+ * @dirty_bmap: bitmap for dirty states searching
+ *
+ * This method tries to issue updates for all dirty fragments
+ * in @dirty_bmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - @dirty_bmap hasn't dirty fragments.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_segbmap_issue_fragments_update(struct ssdfs_segment_bmap *segbmap,
+					 u16 start_fragment,
+					 u16 fragment_size,
+					 unsigned long dirty_bmap)
+{
+	struct ssdfs_segment_request *req1 = NULL, *req2 = NULL;
+	struct ssdfs_segbmap_fragment_desc *fragment;
+	struct ssdfs_segbmap_fragment_header *hdr;
+	struct ssdfs_segment_info *si;
+	void *kaddr;
+	bool is_bit_found;
+	bool has_backup;
+	u64 ino = SSDFS_SEG_BMAP_INO;
+	u64 offset;
+	u32 size;
+	u16 fragments_count;
+	u16 seg_index;
+	int i = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+	BUG_ON(!rwsem_is_locked(&segbmap->resize_lock));
+
+	SSDFS_DBG("segbmap %p, start_fragment %u, dirty_bmap %#lx\n",
+		  segbmap, start_fragment, dirty_bmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (dirty_bmap == 0) {
+		SSDFS_DBG("bmap doesn't contain dirty bits\n");
+		return -ENODATA;
+	}
+
+	has_backup = segbmap->flags & SSDFS_SEGBMAP_HAS_COPY;
+
+	do {
+		is_bit_found = test_bit(i, &dirty_bmap);
+
+		if (!is_bit_found) {
+			i++;
+			continue;
+		}
+
+		fragment = &segbmap->desc_array[start_fragment + i];
+
+		if (fragment->state != SSDFS_SEGBMAP_FRAG_DIRTY) {
+			SSDFS_ERR("invalid fragment's state %#x\n",
+				  fragment->state);
+			return -ERANGE;
+		}
+
+		req1 = &fragment->flush_req1;
+		req2 = &fragment->flush_req2;
+
+		ssdfs_request_init(req1);
+		ssdfs_get_request(req1);
+
+		if (has_backup) {
+			ssdfs_request_init(req2);
+			ssdfs_get_request(req2);
+		}
+
+		err = ssdfs_request_add_allocated_page_locked(req1);
+		if (!err && has_backup)
+			err = ssdfs_request_add_allocated_page_locked(req2);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail allocate memory page: err %d\n", err);
+			goto fail_issue_fragment_updates;
+		}
+
+		err = ssdfs_segbmap_copy_dirty_fragment(segbmap,
+							start_fragment + i,
+							0, req1);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy dirty fragment: "
+				  "fragment %u, err %d\n",
+				  start_fragment + i, err);
+			goto fail_issue_fragment_updates;
+		}
+
+		if (has_backup)
+			ssdfs_segbmap_replicate_fragment(req1, 0, req2);
+
+		offset = (u64)start_fragment + i;
+		offset *= fragment_size;
+		size = fragment_size;
+
+		ssdfs_request_prepare_logical_extent(ino, offset, size,
+						     0, 0, req1);
+
+		if (has_backup) {
+			ssdfs_request_prepare_logical_extent(ino,
+							     offset,
+							     size,
+							     0, 0,
+							     req2);
+		}
+
+		fragments_count = (u16)pagevec_count(&req1->result.pvec);
+		kaddr = kmap_local_page(req1->result.pvec.pages[0]);
+		hdr = SSDFS_SBMP_FRAG_HDR(kaddr);
+		err = ssdfs_segbmap_define_volume_extent(segbmap, req1,
+							 hdr,
+							 fragments_count,
+							 &seg_index);
+		kunmap_local(kaddr);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define volume extent: "
+				  "err %d\n",
+				  err);
+			goto fail_issue_fragment_updates;
+		}
+
+		if (has_backup) {
+			ssdfs_memcpy(&req2->place,
+				     0, sizeof(struct ssdfs_volume_extent),
+				     &req1->place,
+				     0, sizeof(struct ssdfs_volume_extent),
+				     sizeof(struct ssdfs_volume_extent));
+		}
+
+		si = segbmap->segs[seg_index][SSDFS_MAIN_SEGBMAP_SEG];
+		err = ssdfs_segment_update_extent_async(si,
+							SSDFS_REQ_ASYNC_NO_FREE,
+							req1);
+		si = segbmap->segs[seg_index][SSDFS_COPY_SEGBMAP_SEG];
+		if (!err && has_backup) {
+			err = ssdfs_segment_update_extent_async(si,
+							SSDFS_REQ_ASYNC_NO_FREE,
+							req2);
+		}
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to update extent: "
+				  "seg_index %u, err %d\n",
+				  seg_index, err);
+			goto fail_issue_fragment_updates;
+		}
+
+		i++;
+	} while (i < BITS_PER_LONG);
+
+	return 0;
+
+fail_issue_fragment_updates:
+	ssdfs_request_unlock_and_remove_pages(req1);
+	ssdfs_put_request(req1);
+
+	if (has_backup) {
+		ssdfs_request_unlock_and_remove_pages(req2);
+		ssdfs_put_request(req2);
+	}
+
+	return err;
+}
diff --git a/fs/ssdfs/segment_bitmap.h b/fs/ssdfs/segment_bitmap.h
new file mode 100644
index 000000000000..ddf2d8a15897
--- /dev/null
+++ b/fs/ssdfs/segment_bitmap.h
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment_bitmap.h - segment bitmap declarations.
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
+ *                  Zvonimir Badic
+ */
+
+#ifndef _SSDFS_SEGMENT_BITMAP_H
+#define _SSDFS_SEGMENT_BITMAP_H
+
+#include "common_bitmap.h"
+#include "request_queue.h"
+
+/* Segment states */
+enum {
+	SSDFS_SEG_CLEAN			= 0x0,
+	SSDFS_SEG_DATA_USING		= 0x1,
+	SSDFS_SEG_LEAF_NODE_USING	= 0x2,
+	SSDFS_SEG_HYBRID_NODE_USING	= 0x5,
+	SSDFS_SEG_INDEX_NODE_USING	= 0x3,
+	SSDFS_SEG_USED			= 0x7,
+	SSDFS_SEG_PRE_DIRTY		= 0x6,
+	SSDFS_SEG_DIRTY			= 0x4,
+	SSDFS_SEG_BAD			= 0x8,
+	SSDFS_SEG_RESERVED		= 0x9,
+	SSDFS_SEG_STATE_MAX		= SSDFS_SEG_RESERVED + 1,
+};
+
+/* Segment state flags */
+#define SSDFS_SEG_CLEAN_STATE_FLAG		(1 << 0)
+#define SSDFS_SEG_DATA_USING_STATE_FLAG		(1 << 1)
+#define SSDFS_SEG_LEAF_NODE_USING_STATE_FLAG	(1 << 2)
+#define SSDFS_SEG_HYBRID_NODE_USING_STATE_FLAG	(1 << 3)
+#define SSDFS_SEG_INDEX_NODE_USING_STATE_FLAG	(1 << 4)
+#define SSDFS_SEG_USED_STATE_FLAG		(1 << 5)
+#define SSDFS_SEG_PRE_DIRTY_STATE_FLAG		(1 << 6)
+#define SSDFS_SEG_DIRTY_STATE_FLAG		(1 << 7)
+#define SSDFS_SEG_BAD_STATE_FLAG		(1 << 8)
+#define SSDFS_SEG_RESERVED_STATE_FLAG		(1 << 9)
+
+/* Segment state masks */
+#define SSDFS_SEG_CLEAN_USING_MASK \
+	(SSDFS_SEG_CLEAN_STATE_FLAG | \
+	 SSDFS_SEG_DATA_USING_STATE_FLAG | \
+	 SSDFS_SEG_LEAF_NODE_USING_STATE_FLAG | \
+	 SSDFS_SEG_HYBRID_NODE_USING_STATE_FLAG | \
+	 SSDFS_SEG_INDEX_NODE_USING_STATE_FLAG)
+#define SSDFS_SEG_USED_DIRTY_MASK \
+	(SSDFS_SEG_USED_STATE_FLAG | \
+	 SSDFS_SEG_PRE_DIRTY_STATE_FLAG | \
+	 SSDFS_SEG_DIRTY_STATE_FLAG)
+#define SSDFS_SEG_BAD_STATE_MASK \
+	(SSDFS_SEG_BAD_STATE_FLAG)
+
+#define SSDFS_SEG_STATE_BITS	4
+#define SSDFS_SEG_STATE_MASK	0xF
+
+/*
+ * struct ssdfs_segbmap_fragment_desc - fragment descriptor
+ * @state: fragment's state
+ * @total_segs: total count of segments in fragment
+ * @clean_or_using_segs: count of clean or using segments in fragment
+ * @used_or_dirty_segs: count of used, pre-dirty, dirty or reserved segments
+ * @bad_segs: count of bad segments in fragment
+ * @init_end: wait of init ending
+ * @flush_req1: main flush request
+ * @flush_req2: backup flush request
+ */
+struct ssdfs_segbmap_fragment_desc {
+	int state;
+	u16 total_segs;
+	u16 clean_or_using_segs;
+	u16 used_or_dirty_segs;
+	u16 bad_segs;
+	struct completion init_end;
+	struct ssdfs_segment_request flush_req1;
+	struct ssdfs_segment_request flush_req2;
+};
+
+/* Fragment's state */
+enum {
+	SSDFS_SEGBMAP_FRAG_CREATED	= 0,
+	SSDFS_SEGBMAP_FRAG_INIT_FAILED	= 1,
+	SSDFS_SEGBMAP_FRAG_INITIALIZED	= 2,
+	SSDFS_SEGBMAP_FRAG_DIRTY	= 3,
+	SSDFS_SEGBMAP_FRAG_TOWRITE	= 4,
+	SSDFS_SEGBMAP_FRAG_STATE_MAX	= 5,
+};
+
+/* Fragments bitmap types */
+enum {
+	SSDFS_SEGBMAP_CLEAN_USING_FBMAP,
+	SSDFS_SEGBMAP_USED_DIRTY_FBMAP,
+	SSDFS_SEGBMAP_BAD_FBMAP,
+	SSDFS_SEGBMAP_MODIFICATION_FBMAP,
+	SSDFS_SEGBMAP_FBMAP_TYPE_MAX,
+};
+
+/*
+ * struct ssdfs_segment_bmap - segments bitmap
+ * @resize_lock: lock for possible resize operation
+ * @flags: bitmap flags
+ * @bytes_count: count of bytes in the whole segment bitmap
+ * @items_count: count of volume's segments
+ * @fragments_count: count of fragments in the whole segment bitmap
+ * @fragments_per_seg: segbmap's fragments per segment
+ * @fragments_per_peb: segbmap's fragments per PEB
+ * @fragment_size: size of fragment in bytes
+ * @seg_numbers: array of segment bitmap's segment numbers
+ * @segs_count: count of segment objects are used for segment bitmap
+ * @segs: array of pointers on segment objects
+ * @search_lock: lock for search and change state operations
+ * @fbmap: array of fragment bitmaps
+ * @desc_array: array of fragments' descriptors
+ * @pages: memory pages of the whole segment bitmap
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_segment_bmap {
+	struct rw_semaphore resize_lock;
+	u16 flags;
+	u32 bytes_count;
+	u64 items_count;
+	u16 fragments_count;
+	u16 fragments_per_seg;
+	u16 fragments_per_peb;
+	u16 fragment_size;
+#define SEGS_LIMIT1	SSDFS_SEGBMAP_SEGS
+#define SEGS_LIMIT2	SSDFS_SEGBMAP_SEG_COPY_MAX
+	u64 seg_numbers[SEGS_LIMIT1][SEGS_LIMIT2];
+	u16 segs_count;
+	struct ssdfs_segment_info *segs[SEGS_LIMIT1][SEGS_LIMIT2];
+
+	struct rw_semaphore search_lock;
+	unsigned long *fbmap[SSDFS_SEGBMAP_FBMAP_TYPE_MAX];
+	struct ssdfs_segbmap_fragment_desc *desc_array;
+	struct address_space pages;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+/*
+ * Inline functions
+ */
+static inline
+u32 SEG_BMAP_BYTES(u64 items_count)
+{
+	u64 bytes;
+
+	bytes = items_count + SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS) - 1;
+	bytes /= SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS);
+
+	BUG_ON(bytes >= U32_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %llu, bytes %llu\n",
+		  items_count, bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u32)bytes;
+}
+
+static inline
+u16 SEG_BMAP_FRAGMENTS(u64 items_count)
+{
+	u32 hdr_size = sizeof(struct ssdfs_segbmap_fragment_header);
+	u32 bytes = SEG_BMAP_BYTES(items_count);
+	u32 pages, fragments;
+
+	pages = (bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	bytes += pages * hdr_size;
+
+	fragments = (bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	BUG_ON(fragments >= U16_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %llu, pages %u, "
+		  "bytes %u, fragments %u\n",
+		  items_count, pages,
+		  bytes, fragments);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u16)fragments;
+}
+
+static inline
+u16 ssdfs_segbmap_seg_2_fragment_index(u64 seg)
+{
+	u16 fragments_count = SEG_BMAP_FRAGMENTS(seg + 1);
+
+	BUG_ON(fragments_count == 0);
+	return fragments_count - 1;
+}
+
+static inline
+u32 ssdfs_segbmap_items_per_fragment(size_t fragment_size)
+{
+	u32 hdr_size = sizeof(struct ssdfs_segbmap_fragment_header);
+	u32 payload_bytes;
+	u64 items;
+
+	BUG_ON(hdr_size >= fragment_size);
+
+	payload_bytes = fragment_size - hdr_size;
+	items = payload_bytes * SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS);
+
+	BUG_ON(items >= U32_MAX);
+
+	return (u32)items;
+}
+
+static inline
+u64 ssdfs_segbmap_define_first_fragment_item(pgoff_t fragment_index,
+					     size_t fragment_size)
+{
+	return fragment_index * ssdfs_segbmap_items_per_fragment(fragment_size);
+}
+
+static inline
+u32 ssdfs_segbmap_get_item_byte_offset(u32 fragment_item)
+{
+	u32 hdr_size = sizeof(struct ssdfs_segbmap_fragment_header);
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS);
+	return hdr_size + (fragment_item / items_per_byte);
+}
+
+static inline
+int ssdfs_segbmap_seg_id_2_seg_index(struct ssdfs_segment_bmap *segbmap,
+				     u64 seg_id)
+{
+	int i;
+
+	if (seg_id == U64_MAX)
+		return -ENODATA;
+
+	for (i = 0; i < segbmap->segs_count; i++) {
+		if (seg_id == segbmap->seg_numbers[i][SSDFS_MAIN_SEGBMAP_SEG])
+			return i;
+		if (seg_id == segbmap->seg_numbers[i][SSDFS_COPY_SEGBMAP_SEG])
+			return i;
+	}
+
+	return -ENODATA;
+}
+
+static inline
+bool ssdfs_segbmap_fragment_has_content(struct page *page)
+{
+	bool has_content = false;
+	void *kaddr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page);
+
+	SSDFS_DBG("page %p\n", page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	kaddr = kmap_local_page(page);
+	if (memchr_inv(kaddr, 0xff, PAGE_SIZE) != NULL)
+		has_content = true;
+	kunmap_local(kaddr);
+
+	return has_content;
+}
+
+static inline
+bool IS_STATE_GOOD_FOR_MASK(int mask, int state)
+{
+	bool is_good = false;
+
+	switch (state) {
+	case SSDFS_SEG_CLEAN:
+		is_good = mask & SSDFS_SEG_CLEAN_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_DATA_USING:
+		is_good = mask & SSDFS_SEG_DATA_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_LEAF_NODE_USING:
+		is_good = mask & SSDFS_SEG_LEAF_NODE_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_HYBRID_NODE_USING:
+		is_good = mask & SSDFS_SEG_HYBRID_NODE_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_INDEX_NODE_USING:
+		is_good = mask & SSDFS_SEG_INDEX_NODE_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_USED:
+		is_good = mask & SSDFS_SEG_USED_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_PRE_DIRTY:
+		is_good = mask & SSDFS_SEG_PRE_DIRTY_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_DIRTY:
+		is_good = mask & SSDFS_SEG_DIRTY_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_BAD:
+		is_good = mask & SSDFS_SEG_BAD_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_RESERVED:
+		is_good = mask & SSDFS_SEG_RESERVED_STATE_FLAG;
+		break;
+
+	default:
+		BUG();
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("mask %#x, state %#x, is_good %#x\n",
+		  mask, state, is_good);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return is_good;
+}
+
+static inline
+void ssdfs_debug_segbmap_object(struct ssdfs_segment_bmap *bmap)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int i, j;
+	size_t bytes;
+
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("flags %#x, bytes_count %u, items_count %llu, "
+		  "fragments_count %u, fragments_per_seg %u, "
+		  "fragments_per_peb %u, fragment_size %u\n",
+		  bmap->flags, bmap->bytes_count, bmap->items_count,
+		  bmap->fragments_count, bmap->fragments_per_seg,
+		  bmap->fragments_per_peb, bmap->fragment_size);
+
+	for (i = 0; i < SSDFS_SEGBMAP_SEGS; i++) {
+		for (j = 0; j < SSDFS_SEGBMAP_SEG_COPY_MAX; j++) {
+			SSDFS_DBG("seg_numbers[%d][%d] = %llu\n",
+				  i, j, bmap->seg_numbers[i][j]);
+		}
+	}
+
+	SSDFS_DBG("segs_count %u\n", bmap->segs_count);
+
+	for (i = 0; i < SSDFS_SEGBMAP_SEGS; i++) {
+		for (j = 0; j < SSDFS_SEGBMAP_SEG_COPY_MAX; j++) {
+			SSDFS_DBG("segs[%d][%d] = %p\n",
+				  i, j, bmap->segs[i][j]);
+		}
+	}
+
+	bytes = bmap->fragments_count + BITS_PER_LONG - 1;
+	bytes /= BITS_PER_BYTE;
+
+	for (i = 0; i < SSDFS_SEGBMAP_FBMAP_TYPE_MAX; i++) {
+		SSDFS_DBG("fbmap[%d]\n", i);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					bmap->fbmap[i], bytes);
+	}
+
+	for (i = 0; i < bmap->fragments_count; i++) {
+		struct ssdfs_segbmap_fragment_desc *desc;
+
+		desc = &bmap->desc_array[i];
+
+		SSDFS_DBG("state %#x, total_segs %u, "
+			  "clean_or_using_segs %u, used_or_dirty_segs %u, "
+			  "bad_segs %u\n",
+			  desc->state, desc->total_segs,
+			  desc->clean_or_using_segs,
+			  desc->used_or_dirty_segs,
+			  desc->bad_segs);
+	}
+
+	for (i = 0; i < bmap->fragments_count; i++) {
+		struct page *page;
+		void *kaddr;
+
+		page = find_lock_page(&bmap->pages, i);
+
+		SSDFS_DBG("page[%d] %p\n", i, page);
+		if (!page)
+			continue;
+
+		ssdfs_account_locked_page(page);
+
+		SSDFS_DBG("page_index %llu, flags %#lx\n",
+			  (u64)page_index(page), page->flags);
+
+		kaddr = kmap_local_page(page);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					kaddr, PAGE_SIZE);
+		kunmap_local(kaddr);
+
+		ssdfs_unlock_page(page);
+		ssdfs_put_page(page);
+
+		SSDFS_DBG("page %p, count %d\n",
+			  page, page_ref_count(page));
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * Segment bitmap's API
+ */
+int ssdfs_segbmap_create(struct ssdfs_fs_info *fsi);
+void ssdfs_segbmap_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_segbmap_check_fragment_header(struct ssdfs_peb_container *pebc,
+					u16 seg_index,
+					u16 sequence_id,
+					struct page *page);
+int ssdfs_segbmap_fragment_init(struct ssdfs_peb_container *pebc,
+				u16 sequence_id,
+				struct page *page,
+				int state);
+int ssdfs_segbmap_flush(struct ssdfs_segment_bmap *segbmap);
+int ssdfs_segbmap_resize(struct ssdfs_segment_bmap *segbmap,
+			 u64 new_items_count);
+
+int ssdfs_segbmap_check_state(struct ssdfs_segment_bmap *segbmap,
+				u64 seg, int state,
+				struct completion **end);
+int ssdfs_segbmap_get_state(struct ssdfs_segment_bmap *segbmap,
+			    u64 seg, struct completion **end);
+int ssdfs_segbmap_change_state(struct ssdfs_segment_bmap *segbmap,
+				u64 seg, int new_state,
+				struct completion **end);
+int ssdfs_segbmap_find(struct ssdfs_segment_bmap *segbmap,
+			u64 start, u64 max,
+			int state, int mask,
+			u64 *seg, struct completion **end);
+int ssdfs_segbmap_find_and_set(struct ssdfs_segment_bmap *segbmap,
+				u64 start, u64 max,
+				int state, int mask,
+				int new_state,
+				u64 *seg, struct completion **end);
+int ssdfs_segbmap_reserve_clean_segment(struct ssdfs_segment_bmap *segbmap,
+					u64 start, u64 max,
+					u64 *seg, struct completion **end);
+
+#endif /* _SSDFS_SEGMENT_BITMAP_H */
diff --git a/fs/ssdfs/segment_bitmap_tables.c b/fs/ssdfs/segment_bitmap_tables.c
new file mode 100644
index 000000000000..a1eeba918a12
--- /dev/null
+++ b/fs/ssdfs/segment_bitmap_tables.c
@@ -0,0 +1,814 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment_bitmap_tables.c - declaration of segbmap's search tables.
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
+#include <linux/kernel.h>
+
+/*
+ * Table for determination presence of clean segment
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_clean_seg[U8_MAX + 1] = {
+/* 00 - 0x00 */	true, true, true, true,
+/* 01 - 0x04 */	true, true, true, true,
+/* 02 - 0x08 */	true, true, true, true,
+/* 03 - 0x0C */	true, true, true, true,
+/* 04 - 0x10 */	true, false, false, false,
+/* 05 - 0x14 */	false, false, false, false,
+/* 06 - 0x18 */	false, false, false, false,
+/* 07 - 0x1C */	false, false, false, false,
+/* 08 - 0x20 */	true, false, false, false,
+/* 09 - 0x24 */	false, false, false, false,
+/* 10 - 0x28 */	false, false, false, false,
+/* 11 - 0x2C */	false, false, false, false,
+/* 12 - 0x30 */	true, false, false, false,
+/* 13 - 0x34 */	false, false, false, false,
+/* 14 - 0x38 */	false, false, false, false,
+/* 15 - 0x3C */	false, false, false, false,
+/* 16 - 0x40 */	true, false, false, false,
+/* 17 - 0x44 */	false, false, false, false,
+/* 18 - 0x48 */	false, false, false, false,
+/* 19 - 0x4C */	false, false, false, false,
+/* 20 - 0x50 */	true, false, false, false,
+/* 21 - 0x54 */	false, false, false, false,
+/* 22 - 0x58 */	false, false, false, false,
+/* 23 - 0x5C */	false, false, false, false,
+/* 24 - 0x60 */	true, false, false, false,
+/* 25 - 0x64 */	false, false, false, false,
+/* 26 - 0x68 */	false, false, false, false,
+/* 27 - 0x6C */	false, false, false, false,
+/* 28 - 0x70 */	true, false, false, false,
+/* 29 - 0x74 */	false, false, false, false,
+/* 30 - 0x78 */	false, false, false, false,
+/* 31 - 0x7C */	false, false, false, false,
+/* 32 - 0x80 */	true, false, false, false,
+/* 33 - 0x84 */	false, false, false, false,
+/* 34 - 0x88 */	false, false, false, false,
+/* 35 - 0x8C */	false, false, false, false,
+/* 36 - 0x90 */	true, false, false, false,
+/* 37 - 0x94 */	false, false, false, false,
+/* 38 - 0x98 */	false, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	true, false, false, false,
+/* 41 - 0xA4 */	false, false, false, false,
+/* 42 - 0xA8 */	false, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	true, false, false, false,
+/* 45 - 0xB4 */	false, false, false, false,
+/* 46 - 0xB8 */	false, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	true, false, false, false,
+/* 49 - 0xC4 */	false, false, false, false,
+/* 50 - 0xC8 */	false, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	true, false, false, false,
+/* 53 - 0xD4 */	false, false, false, false,
+/* 54 - 0xD8 */	false, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	true, false, false, false,
+/* 57 - 0xE4 */	false, false, false, false,
+/* 58 - 0xE8 */	false, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	true, false, false, false,
+/* 61 - 0xF4 */	false, false, false, false,
+/* 62 - 0xF8 */	false, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
+
+/*
+ * Table for determination presence of data using segment
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_data_using_seg[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, true, false, false,
+/* 01 - 0x04 */	false, false, false, false,
+/* 02 - 0x08 */	false, false, false, false,
+/* 03 - 0x0C */	false, false, false, false,
+/* 04 - 0x10 */	true, true, true, true,
+/* 05 - 0x14 */	true, true, true, true,
+/* 06 - 0x18 */	true, true, true, true,
+/* 07 - 0x1C */	true, true, true, true,
+/* 08 - 0x20 */	false, true, false, false,
+/* 09 - 0x24 */	false, false, false, false,
+/* 10 - 0x28 */	false, false, false, false,
+/* 11 - 0x2C */	false, false, false, false,
+/* 12 - 0x30 */	false, true, false, false,
+/* 13 - 0x34 */	false, false, false, false,
+/* 14 - 0x38 */	false, false, false, false,
+/* 15 - 0x3C */	false, false, false, false,
+/* 16 - 0x40 */	false, true, false, false,
+/* 17 - 0x44 */	false, false, false, false,
+/* 18 - 0x48 */	false, false, false, false,
+/* 19 - 0x4C */	false, false, false, false,
+/* 20 - 0x50 */	false, true, false, false,
+/* 21 - 0x54 */	false, false, false, false,
+/* 22 - 0x58 */	false, false, false, false,
+/* 23 - 0x5C */	false, false, false, false,
+/* 24 - 0x60 */	false, true, false, false,
+/* 25 - 0x64 */	false, false, false, false,
+/* 26 - 0x68 */	false, false, false, false,
+/* 27 - 0x6C */	false, false, false, false,
+/* 28 - 0x70 */	false, true, false, false,
+/* 29 - 0x74 */	false, false, false, false,
+/* 30 - 0x78 */	false, false, false, false,
+/* 31 - 0x7C */	false, false, false, false,
+/* 32 - 0x80 */	false, true, false, false,
+/* 33 - 0x84 */	false, false, false, false,
+/* 34 - 0x88 */	false, false, false, false,
+/* 35 - 0x8C */	false, false, false, false,
+/* 36 - 0x90 */	false, true, false, false,
+/* 37 - 0x94 */	false, false, false, false,
+/* 38 - 0x98 */	false, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	false, true, false, false,
+/* 41 - 0xA4 */	false, false, false, false,
+/* 42 - 0xA8 */	false, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	false, true, false, false,
+/* 45 - 0xB4 */	false, false, false, false,
+/* 46 - 0xB8 */	false, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	false, true, false, false,
+/* 49 - 0xC4 */	false, false, false, false,
+/* 50 - 0xC8 */	false, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	false, true, false, false,
+/* 53 - 0xD4 */	false, false, false, false,
+/* 54 - 0xD8 */	false, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	false, true, false, false,
+/* 57 - 0xE4 */	false, false, false, false,
+/* 58 - 0xE8 */	false, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	false, true, false, false,
+/* 61 - 0xF4 */	false, false, false, false,
+/* 62 - 0xF8 */	false, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
+
+/*
+ * Table for determination presence of leaf node segment
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_lnode_using_seg[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, true, false,
+/* 01 - 0x04 */	false, false, false, false,
+/* 02 - 0x08 */	false, false, false, false,
+/* 03 - 0x0C */	false, false, false, false,
+/* 04 - 0x10 */	false, false, true, false,
+/* 05 - 0x14 */	false, false, false, false,
+/* 06 - 0x18 */	false, false, false, false,
+/* 07 - 0x1C */	false, false, false, false,
+/* 08 - 0x20 */	true, true, true, true,
+/* 09 - 0x24 */	true, true, true, true,
+/* 10 - 0x28 */	true, true, true, true,
+/* 11 - 0x2C */	true, true, true, true,
+/* 12 - 0x30 */	false, false, true, false,
+/* 13 - 0x34 */	false, false, false, false,
+/* 14 - 0x38 */	false, false, false, false,
+/* 15 - 0x3C */	false, false, false, false,
+/* 16 - 0x40 */	false, false, true, false,
+/* 17 - 0x44 */	false, false, false, false,
+/* 18 - 0x48 */	false, false, false, false,
+/* 19 - 0x4C */	false, false, false, false,
+/* 20 - 0x50 */	false, false, true, false,
+/* 21 - 0x54 */	false, false, false, false,
+/* 22 - 0x58 */	false, false, false, false,
+/* 23 - 0x5C */	false, false, false, false,
+/* 24 - 0x60 */	false, false, true, false,
+/* 25 - 0x64 */	false, false, false, false,
+/* 26 - 0x68 */	false, false, false, false,
+/* 27 - 0x6C */	false, false, false, false,
+/* 28 - 0x70 */	false, false, true, false,
+/* 29 - 0x74 */	false, false, false, false,
+/* 30 - 0x78 */	false, false, false, false,
+/* 31 - 0x7C */	false, false, false, false,
+/* 32 - 0x80 */	false, false, true, false,
+/* 33 - 0x84 */	false, false, false, false,
+/* 34 - 0x88 */	false, false, false, false,
+/* 35 - 0x8C */	false, false, false, false,
+/* 36 - 0x90 */	false, false, true, false,
+/* 37 - 0x94 */	false, false, false, false,
+/* 38 - 0x98 */	false, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	false, false, true, false,
+/* 41 - 0xA4 */	false, false, false, false,
+/* 42 - 0xA8 */	false, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	false, false, true, false,
+/* 45 - 0xB4 */	false, false, false, false,
+/* 46 - 0xB8 */	false, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	false, false, true, false,
+/* 49 - 0xC4 */	false, false, false, false,
+/* 50 - 0xC8 */	false, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	false, false, true, false,
+/* 53 - 0xD4 */	false, false, false, false,
+/* 54 - 0xD8 */	false, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	false, false, true, false,
+/* 57 - 0xE4 */	false, false, false, false,
+/* 58 - 0xE8 */	false, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	false, false, true, false,
+/* 61 - 0xF4 */	false, false, false, false,
+/* 62 - 0xF8 */	false, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
+
+/*
+ * Table for determination presence of hybrid node segment
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_hnode_using_seg[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, false, false,
+/* 01 - 0x04 */	false, true, false, false,
+/* 02 - 0x08 */	false, false, false, false,
+/* 03 - 0x0C */	false, false, false, false,
+/* 04 - 0x10 */	false, false, false, false,
+/* 05 - 0x14 */	false, true, false, false,
+/* 06 - 0x18 */	false, false, false, false,
+/* 07 - 0x1C */	false, false, false, false,
+/* 08 - 0x20 */	false, false, false, false,
+/* 09 - 0x24 */	false, true, false, false,
+/* 10 - 0x28 */	false, false, false, false,
+/* 11 - 0x2C */	false, false, false, false,
+/* 12 - 0x30 */	false, false, false, false,
+/* 13 - 0x34 */	false, true, false, false,
+/* 14 - 0x38 */	false, false, false, false,
+/* 15 - 0x3C */	false, false, false, false,
+/* 16 - 0x40 */	false, false, false, false,
+/* 17 - 0x44 */	false, true, false, false,
+/* 18 - 0x48 */	false, false, false, false,
+/* 19 - 0x4C */	false, false, false, false,
+/* 20 - 0x50 */	true, true, true, true,
+/* 21 - 0x54 */	true, true, true, true,
+/* 22 - 0x58 */	true, true, true, true,
+/* 23 - 0x5C */	true, true, true, true,
+/* 24 - 0x60 */	false, false, false, false,
+/* 25 - 0x64 */	false, true, false, false,
+/* 26 - 0x68 */	false, false, false, false,
+/* 27 - 0x6C */	false, false, false, false,
+/* 28 - 0x70 */	false, false, false, false,
+/* 29 - 0x74 */	false, true, false, false,
+/* 30 - 0x78 */	false, false, false, false,
+/* 31 - 0x7C */	false, false, false, false,
+/* 32 - 0x80 */	false, false, false, false,
+/* 33 - 0x84 */	false, true, false, false,
+/* 34 - 0x88 */	false, false, false, false,
+/* 35 - 0x8C */	false, false, false, false,
+/* 36 - 0x90 */	false, false, false, false,
+/* 37 - 0x94 */	false, true, false, false,
+/* 38 - 0x98 */	false, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	false, false, false, false,
+/* 41 - 0xA4 */	false, true, false, false,
+/* 42 - 0xA8 */	false, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	false, false, false, false,
+/* 45 - 0xB4 */	false, true, false, false,
+/* 46 - 0xB8 */	false, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	false, false, false, false,
+/* 49 - 0xC4 */	false, true, false, false,
+/* 50 - 0xC8 */	false, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	false, false, false, false,
+/* 53 - 0xD4 */	false, true, false, false,
+/* 54 - 0xD8 */	false, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	false, false, false, false,
+/* 57 - 0xE4 */	false, true, false, false,
+/* 58 - 0xE8 */	false, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	false, false, false, false,
+/* 61 - 0xF4 */	false, true, false, false,
+/* 62 - 0xF8 */	false, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
+
+/*
+ * Table for determination presence of index node segment
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_idxnode_using_seg[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, false, true,
+/* 01 - 0x04 */	false, false, false, false,
+/* 02 - 0x08 */	false, false, false, false,
+/* 03 - 0x0C */	false, false, false, false,
+/* 04 - 0x10 */	false, false, false, true,
+/* 05 - 0x14 */	false, false, false, false,
+/* 06 - 0x18 */	false, false, false, false,
+/* 07 - 0x1C */	false, false, false, false,
+/* 08 - 0x20 */	false, false, false, true,
+/* 09 - 0x24 */	false, false, false, false,
+/* 10 - 0x28 */	false, false, false, false,
+/* 11 - 0x2C */	false, false, false, false,
+/* 12 - 0x30 */	true, true, true, true,
+/* 13 - 0x34 */	true, true, true, true,
+/* 14 - 0x38 */	true, true, true, true,
+/* 15 - 0x3C */	true, true, true, true,
+/* 16 - 0x40 */	false, false, false, true,
+/* 17 - 0x44 */	false, false, false, false,
+/* 18 - 0x48 */	false, false, false, false,
+/* 19 - 0x4C */	false, false, false, false,
+/* 20 - 0x50 */	false, false, false, true,
+/* 21 - 0x54 */	false, false, false, false,
+/* 22 - 0x58 */	false, false, false, false,
+/* 23 - 0x5C */	false, false, false, false,
+/* 24 - 0x60 */	false, false, false, true,
+/* 25 - 0x64 */	false, false, false, false,
+/* 26 - 0x68 */	false, false, false, false,
+/* 27 - 0x6C */	false, false, false, false,
+/* 28 - 0x70 */	false, false, false, true,
+/* 29 - 0x74 */	false, false, false, false,
+/* 30 - 0x78 */	false, false, false, false,
+/* 31 - 0x7C */	false, false, false, false,
+/* 32 - 0x80 */	false, false, false, true,
+/* 33 - 0x84 */	false, false, false, false,
+/* 34 - 0x88 */	false, false, false, false,
+/* 35 - 0x8C */	false, false, false, false,
+/* 36 - 0x90 */	false, false, false, true,
+/* 37 - 0x94 */	false, false, false, false,
+/* 38 - 0x98 */	false, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	false, false, false, true,
+/* 41 - 0xA4 */	false, false, false, false,
+/* 42 - 0xA8 */	false, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	false, false, false, true,
+/* 45 - 0xB4 */	false, false, false, false,
+/* 46 - 0xB8 */	false, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	false, false, false, true,
+/* 49 - 0xC4 */	false, false, false, false,
+/* 50 - 0xC8 */	false, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	false, false, false, true,
+/* 53 - 0xD4 */	false, false, false, false,
+/* 54 - 0xD8 */	false, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	false, false, false, true,
+/* 57 - 0xE4 */	false, false, false, false,
+/* 58 - 0xE8 */	false, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	false, false, false, true,
+/* 61 - 0xF4 */	false, false, false, false,
+/* 62 - 0xF8 */	false, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
+
+/*
+ * Table for determination presence of used segment
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_used_seg[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, false, false,
+/* 01 - 0x04 */	false, false, false, true,
+/* 02 - 0x08 */	false, false, false, false,
+/* 03 - 0x0C */	false, false, false, false,
+/* 04 - 0x10 */	false, false, false, false,
+/* 05 - 0x14 */	false, false, false, true,
+/* 06 - 0x18 */	false, false, false, false,
+/* 07 - 0x1C */	false, false, false, false,
+/* 08 - 0x20 */	false, false, false, false,
+/* 09 - 0x24 */	false, false, false, true,
+/* 10 - 0x28 */	false, false, false, false,
+/* 11 - 0x2C */	false, false, false, false,
+/* 12 - 0x30 */	false, false, false, false,
+/* 13 - 0x34 */	false, false, false, true,
+/* 14 - 0x38 */	false, false, false, false,
+/* 15 - 0x3C */	false, false, false, false,
+/* 16 - 0x40 */	false, false, false, false,
+/* 17 - 0x44 */	false, false, false, true,
+/* 18 - 0x48 */	false, false, false, false,
+/* 19 - 0x4C */	false, false, false, false,
+/* 20 - 0x50 */	false, false, false, false,
+/* 21 - 0x54 */	false, false, false, true,
+/* 22 - 0x58 */	false, false, false, false,
+/* 23 - 0x5C */	false, false, false, false,
+/* 24 - 0x60 */	false, false, false, false,
+/* 25 - 0x64 */	false, false, false, true,
+/* 26 - 0x68 */	false, false, false, false,
+/* 27 - 0x6C */	false, false, false, false,
+/* 28 - 0x70 */	true, true, true, true,
+/* 29 - 0x74 */	true, true, true, true,
+/* 30 - 0x78 */	true, true, true, true,
+/* 31 - 0x7C */	true, true, true, true,
+/* 32 - 0x80 */	false, false, false, false,
+/* 33 - 0x84 */	false, false, false, true,
+/* 34 - 0x88 */	false, false, false, false,
+/* 35 - 0x8C */	false, false, false, false,
+/* 36 - 0x90 */	false, false, false, false,
+/* 37 - 0x94 */	false, false, false, true,
+/* 38 - 0x98 */	false, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	false, false, false, false,
+/* 41 - 0xA4 */	false, false, false, true,
+/* 42 - 0xA8 */	false, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	false, false, false, false,
+/* 45 - 0xB4 */	false, false, false, true,
+/* 46 - 0xB8 */	false, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	false, false, false, false,
+/* 49 - 0xC4 */	false, false, false, true,
+/* 50 - 0xC8 */	false, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	false, false, false, false,
+/* 53 - 0xD4 */	false, false, false, true,
+/* 54 - 0xD8 */	false, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	false, false, false, false,
+/* 57 - 0xE4 */	false, false, false, true,
+/* 58 - 0xE8 */	false, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	false, false, false, false,
+/* 61 - 0xF4 */	false, false, false, true,
+/* 62 - 0xF8 */	false, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
+
+/*
+ * Table for determination presence of pre-dirty segment
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_pre_dirty_seg[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, false, false,
+/* 01 - 0x04 */	false, false, true, false,
+/* 02 - 0x08 */	false, false, false, false,
+/* 03 - 0x0C */	false, false, false, false,
+/* 04 - 0x10 */	false, false, false, false,
+/* 05 - 0x14 */	false, false, true, false,
+/* 06 - 0x18 */	false, false, false, false,
+/* 07 - 0x1C */	false, false, false, false,
+/* 08 - 0x20 */	false, false, false, false,
+/* 09 - 0x24 */	false, false, true, false,
+/* 10 - 0x28 */	false, false, false, false,
+/* 11 - 0x2C */	false, false, false, false,
+/* 12 - 0x30 */	false, false, false, false,
+/* 13 - 0x34 */	false, false, true, false,
+/* 14 - 0x38 */	false, false, false, false,
+/* 15 - 0x3C */	false, false, false, false,
+/* 16 - 0x40 */	false, false, false, false,
+/* 17 - 0x44 */	false, false, true, false,
+/* 18 - 0x48 */	false, false, false, false,
+/* 19 - 0x4C */	false, false, false, false,
+/* 20 - 0x50 */	false, false, false, false,
+/* 21 - 0x54 */	false, false, true, false,
+/* 22 - 0x58 */	false, false, false, false,
+/* 23 - 0x5C */	false, false, false, false,
+/* 24 - 0x60 */	true, true, true, true,
+/* 25 - 0x64 */	true, true, true, true,
+/* 26 - 0x68 */	true, true, true, true,
+/* 27 - 0x6C */	true, true, true, true,
+/* 28 - 0x70 */	false, false, false, false,
+/* 29 - 0x74 */	false, false, true, false,
+/* 30 - 0x78 */	false, false, false, false,
+/* 31 - 0x7C */	false, false, false, false,
+/* 32 - 0x80 */	false, false, false, false,
+/* 33 - 0x84 */	false, false, true, false,
+/* 34 - 0x88 */	false, false, false, false,
+/* 35 - 0x8C */	false, false, false, false,
+/* 36 - 0x90 */	false, false, false, false,
+/* 37 - 0x94 */	false, false, true, false,
+/* 38 - 0x98 */	false, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	false, false, false, false,
+/* 41 - 0xA4 */	false, false, true, false,
+/* 42 - 0xA8 */	false, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	false, false, false, false,
+/* 45 - 0xB4 */	false, false, true, false,
+/* 46 - 0xB8 */	false, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	false, false, false, false,
+/* 49 - 0xC4 */	false, false, true, false,
+/* 50 - 0xC8 */	false, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	false, false, false, false,
+/* 53 - 0xD4 */	false, false, true, false,
+/* 54 - 0xD8 */	false, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	false, false, false, false,
+/* 57 - 0xE4 */	false, false, true, false,
+/* 58 - 0xE8 */	false, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	false, false, false, false,
+/* 61 - 0xF4 */	false, false, true, false,
+/* 62 - 0xF8 */	false, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
+
+/*
+ * Table for determination presence of dirty segment
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_dirty_seg[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, false, false,
+/* 01 - 0x04 */	true, false, false, false,
+/* 02 - 0x08 */	false, false, false, false,
+/* 03 - 0x0C */	false, false, false, false,
+/* 04 - 0x10 */	false, false, false, false,
+/* 05 - 0x14 */	true, false, false, false,
+/* 06 - 0x18 */	false, false, false, false,
+/* 07 - 0x1C */	false, false, false, false,
+/* 08 - 0x20 */	false, false, false, false,
+/* 09 - 0x24 */	true, false, false, false,
+/* 10 - 0x28 */	false, false, false, false,
+/* 11 - 0x2C */	false, false, false, false,
+/* 12 - 0x30 */	false, false, false, false,
+/* 13 - 0x34 */	true, false, false, false,
+/* 14 - 0x38 */	false, false, false, false,
+/* 15 - 0x3C */	false, false, false, false,
+/* 16 - 0x40 */	true, true, true, true,
+/* 17 - 0x44 */	true, true, true, true,
+/* 18 - 0x48 */	true, true, true, true,
+/* 19 - 0x4C */	true, true, true, true,
+/* 20 - 0x50 */	false, false, false, false,
+/* 21 - 0x54 */	true, false, false, false,
+/* 22 - 0x58 */	false, false, false, false,
+/* 23 - 0x5C */	false, false, false, false,
+/* 24 - 0x60 */	false, false, false, false,
+/* 25 - 0x64 */	true, false, false, false,
+/* 26 - 0x68 */	false, false, false, false,
+/* 27 - 0x6C */	false, false, false, false,
+/* 28 - 0x70 */	false, false, false, false,
+/* 29 - 0x74 */	true, false, false, false,
+/* 30 - 0x78 */	false, false, false, false,
+/* 31 - 0x7C */	false, false, false, false,
+/* 32 - 0x80 */	false, false, false, false,
+/* 33 - 0x84 */	true, false, false, false,
+/* 34 - 0x88 */	false, false, false, false,
+/* 35 - 0x8C */	false, false, false, false,
+/* 36 - 0x90 */	false, false, false, false,
+/* 37 - 0x94 */	true, false, false, false,
+/* 38 - 0x98 */	false, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	false, false, false, false,
+/* 41 - 0xA4 */	true, false, false, false,
+/* 42 - 0xA8 */	false, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	false, false, false, false,
+/* 45 - 0xB4 */	true, false, false, false,
+/* 46 - 0xB8 */	false, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	false, false, false, false,
+/* 49 - 0xC4 */	true, false, false, false,
+/* 50 - 0xC8 */	false, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	false, false, false, false,
+/* 53 - 0xD4 */	true, false, false, false,
+/* 54 - 0xD8 */	false, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	false, false, false, false,
+/* 57 - 0xE4 */	true, false, false, false,
+/* 58 - 0xE8 */	false, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	false, false, false, false,
+/* 61 - 0xF4 */	true, false, false, false,
+/* 62 - 0xF8 */	false, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
+
+/*
+ * Table for determination presence of bad segment
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_bad_seg[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, false, false,
+/* 01 - 0x04 */	false, false, false, false,
+/* 02 - 0x08 */	true, false, false, false,
+/* 03 - 0x0C */	false, false, false, false,
+/* 04 - 0x10 */	false, false, false, false,
+/* 05 - 0x14 */	false, false, false, false,
+/* 06 - 0x18 */	true, false, false, false,
+/* 07 - 0x1C */	false, false, false, false,
+/* 08 - 0x20 */	false, false, false, false,
+/* 09 - 0x24 */	false, false, false, false,
+/* 10 - 0x28 */	true, false, false, false,
+/* 11 - 0x2C */	false, false, false, false,
+/* 12 - 0x30 */	false, false, false, false,
+/* 13 - 0x34 */	false, false, false, false,
+/* 14 - 0x38 */	true, false, false, false,
+/* 15 - 0x3C */	false, false, false, false,
+/* 16 - 0x40 */	false, false, false, false,
+/* 17 - 0x44 */	false, false, false, false,
+/* 18 - 0x48 */	true, false, false, false,
+/* 19 - 0x4C */	false, false, false, false,
+/* 20 - 0x50 */	false, false, false, false,
+/* 21 - 0x54 */	false, false, false, false,
+/* 22 - 0x58 */	true, false, false, false,
+/* 23 - 0x5C */	false, false, false, false,
+/* 24 - 0x60 */	false, false, false, false,
+/* 25 - 0x64 */	false, false, false, false,
+/* 26 - 0x68 */	true, false, false, false,
+/* 27 - 0x6C */	false, false, false, false,
+/* 28 - 0x70 */	false, false, false, false,
+/* 29 - 0x74 */	false, false, false, false,
+/* 30 - 0x78 */	true, false, false, false,
+/* 31 - 0x7C */	false, false, false, false,
+/* 32 - 0x80 */	true, true, true, true,
+/* 33 - 0x84 */	true, true, true, true,
+/* 34 - 0x88 */	true, true, true, true,
+/* 35 - 0x8C */	true, true, true, true,
+/* 36 - 0x90 */	false, false, false, false,
+/* 37 - 0x94 */	false, false, false, false,
+/* 38 - 0x98 */	true, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	false, false, false, false,
+/* 41 - 0xA4 */	false, false, false, false,
+/* 42 - 0xA8 */	true, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	false, false, false, false,
+/* 45 - 0xB4 */	false, false, false, false,
+/* 46 - 0xB8 */	true, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	false, false, false, false,
+/* 49 - 0xC4 */	false, false, false, false,
+/* 50 - 0xC8 */	true, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	false, false, false, false,
+/* 53 - 0xD4 */	false, false, false, false,
+/* 54 - 0xD8 */	true, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	false, false, false, false,
+/* 57 - 0xE4 */	false, false, false, false,
+/* 58 - 0xE8 */	true, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	false, false, false, false,
+/* 61 - 0xF4 */	false, false, false, false,
+/* 62 - 0xF8 */	true, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
+
+/*
+ * Table for determination presence of clean or using segment
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_clean_using_mask[U8_MAX + 1] = {
+/* 00 - 0x00 */	true, true, true, true,
+/* 01 - 0x04 */	true, true, true, true,
+/* 02 - 0x08 */	true, true, true, true,
+/* 03 - 0x0C */	true, true, true, true,
+/* 04 - 0x10 */	true, true, true, true,
+/* 05 - 0x14 */	true, true, true, true,
+/* 06 - 0x18 */	true, true, true, true,
+/* 07 - 0x1C */	true, true, true, true,
+/* 08 - 0x20 */	true, true, true, true,
+/* 09 - 0x24 */	true, true, true, true,
+/* 10 - 0x28 */	true, true, true, true,
+/* 11 - 0x2C */	true, true, true, true,
+/* 12 - 0x30 */	true, true, true, true,
+/* 13 - 0x34 */	true, true, true, true,
+/* 14 - 0x38 */	true, true, true, true,
+/* 15 - 0x3C */	true, true, true, true,
+/* 16 - 0x40 */	true, true, true, true,
+/* 17 - 0x44 */	false, true, false, false,
+/* 18 - 0x48 */	false, false, false, false,
+/* 19 - 0x4C */	false, false, false, false,
+/* 20 - 0x50 */	true, true, true, true,
+/* 21 - 0x54 */	true, true, true, true,
+/* 22 - 0x58 */	true, true, true, true,
+/* 23 - 0x5C */	true, true, true, true,
+/* 24 - 0x60 */	true, true, true, true,
+/* 25 - 0x64 */	false, true, false, false,
+/* 26 - 0x68 */	false, false, false, false,
+/* 27 - 0x6C */	false, false, false, false,
+/* 28 - 0x70 */	true, true, true, true,
+/* 29 - 0x74 */	false, true, false, false,
+/* 30 - 0x78 */	false, false, false, false,
+/* 31 - 0x7C */	false, false, false, false,
+/* 32 - 0x80 */	true, true, true, true,
+/* 33 - 0x84 */	false, true, false, false,
+/* 34 - 0x88 */	false, false, false, false,
+/* 35 - 0x8C */	false, false, false, false,
+/* 36 - 0x90 */	true, true, true, true,
+/* 37 - 0x94 */	false, true, false, false,
+/* 38 - 0x98 */	false, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	true, true, true, true,
+/* 41 - 0xA4 */	false, true, false, false,
+/* 42 - 0xA8 */	false, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	true, true, true, true,
+/* 45 - 0xB4 */	false, true, false, false,
+/* 46 - 0xB8 */	false, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	true, true, true, true,
+/* 49 - 0xC4 */	false, true, false, false,
+/* 50 - 0xC8 */	false, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	true, true, true, true,
+/* 53 - 0xD4 */	false, true, false, false,
+/* 54 - 0xD8 */	false, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	true, true, true, true,
+/* 57 - 0xE4 */	false, true, false, false,
+/* 58 - 0xE8 */	false, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	true, true, true, true,
+/* 61 - 0xF4 */	false, true, false, false,
+/* 62 - 0xF8 */	false, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
+
+/*
+ * Table for determination presence of used, pre-dirty or
+ * dirty segment state in provided byte.
+ * Checking byte is used as index in array.
+ */
+const bool detect_used_dirty_mask[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, false, false,
+/* 01 - 0x04 */	true, false, true, true,
+/* 02 - 0x08 */	false, false, false, false,
+/* 03 - 0x0C */	false, false, false, false,
+/* 04 - 0x10 */	false, false, false, false,
+/* 05 - 0x14 */	true, false, true, true,
+/* 06 - 0x18 */	false, false, false, false,
+/* 07 - 0x1C */	false, false, false, false,
+/* 08 - 0x20 */	false, false, false, false,
+/* 09 - 0x24 */	true, false, true, true,
+/* 10 - 0x28 */	false, false, false, false,
+/* 11 - 0x2C */	false, false, false, false,
+/* 12 - 0x30 */	false, false, false, false,
+/* 13 - 0x34 */	true, false, true, true,
+/* 14 - 0x38 */	false, false, false, false,
+/* 15 - 0x3C */	false, false, false, false,
+/* 16 - 0x40 */	true, true, true, true,
+/* 17 - 0x44 */	true, true, true, true,
+/* 18 - 0x48 */	true, true, true, true,
+/* 19 - 0x4C */	true, true, true, true,
+/* 20 - 0x50 */	false, false, false, false,
+/* 21 - 0x54 */	true, false, true, true,
+/* 22 - 0x58 */	false, false, false, false,
+/* 23 - 0x5C */	false, false, false, false,
+/* 24 - 0x60 */	true, true, true, true,
+/* 25 - 0x64 */	true, true, true, true,
+/* 26 - 0x68 */	true, true, true, true,
+/* 27 - 0x6C */	true, true, true, true,
+/* 28 - 0x70 */	true, true, true, true,
+/* 29 - 0x74 */	true, true, true, true,
+/* 30 - 0x78 */	true, true, true, true,
+/* 31 - 0x7C */	true, true, true, true,
+/* 32 - 0x80 */	false, false, false, false,
+/* 33 - 0x84 */	true, false, true, true,
+/* 34 - 0x88 */	false, false, false, false,
+/* 35 - 0x8C */	false, false, false, false,
+/* 36 - 0x90 */	false, false, false, false,
+/* 37 - 0x94 */	true, false, true, true,
+/* 38 - 0x98 */	false, false, false, false,
+/* 39 - 0x9C */	false, false, false, false,
+/* 40 - 0xA0 */	false, false, false, false,
+/* 41 - 0xA4 */	true, false, true, true,
+/* 42 - 0xA8 */	false, false, false, false,
+/* 43 - 0xAC */	false, false, false, false,
+/* 44 - 0xB0 */	false, false, false, false,
+/* 45 - 0xB4 */	true, false, true, true,
+/* 46 - 0xB8 */	false, false, false, false,
+/* 47 - 0xBC */	false, false, false, false,
+/* 48 - 0xC0 */	false, false, false, false,
+/* 49 - 0xC4 */	true, false, true, true,
+/* 50 - 0xC8 */	false, false, false, false,
+/* 51 - 0xCC */	false, false, false, false,
+/* 52 - 0xD0 */	false, false, false, false,
+/* 53 - 0xD4 */	true, false, true, true,
+/* 54 - 0xD8 */	false, false, false, false,
+/* 55 - 0xDC */	false, false, false, false,
+/* 56 - 0xE0 */	false, false, false, false,
+/* 57 - 0xE4 */	true, false, true, true,
+/* 58 - 0xE8 */	false, false, false, false,
+/* 59 - 0xEC */	false, false, false, false,
+/* 60 - 0xF0 */	false, false, false, false,
+/* 61 - 0xF4 */	true, false, true, true,
+/* 62 - 0xF8 */	false, false, false, false,
+/* 63 - 0xFC */	false, false, false, false
+};
-- 
2.34.1


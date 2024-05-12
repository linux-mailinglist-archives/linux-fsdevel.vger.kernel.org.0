Return-Path: <linux-fsdevel+bounces-19338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E428C34CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 03:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C6B1C20D8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 01:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3E6610C;
	Sun, 12 May 2024 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6gvR4Xw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC362579
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715475979; cv=none; b=UyBQ0kYMqxB32HSRGzizJ1ifnwmFDEB11eEOAVlFwGHjUaeCP1EsCDnJ3/Wg+TiStpG9BlpYbqD+zfwon+Qt/ywUBwBgaVcCrgLsLCVZ+tzP7lST1nTPDXQj57DOWoioDkx+vJR2Pm935aKhmoWj7aGwbrzLl3cMfgWebCQvEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715475979; c=relaxed/simple;
	bh=uFUbAbSRf9jdRUhr+PC2JPqs1KH0PWqpM/2YdraW0wo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=gfnfhh9a8fgbjG463wKLVyd7rPuDtu90BTig4kTfO8wvYozEGaFg4uVhktk2DsoNJt5h33Wrqs9e8k0TQ1+QS71PvIu/486pJ554VW4oa2XoY8OCEmFlKaFiTJ4tSGr6kq/DH7axtP79iZIO9joaSIqaP4h22RZmt2r4m6P+RVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6gvR4Xw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b402090778so3306540a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 18:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715475976; x=1716080776; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kku9r8c20t6N8G9TMWlm80m7+rQKWFfJHyiSJYpFo8U=;
        b=s6gvR4Xw12dY8TgOfaXktqjB2z2sKCiXAk/a0WrIlmBaMrK7RU7ubh90Kbz6Sd9LMP
         Gj+e7ET4yWyp8zoK2hTJkVi+kLFw838LH9phaWwrQN89P5WIp2n2pFD9IxDqWIJEQ5X+
         ErPe9aauCu8b4fkZFz6EMPocYXEvCJ2iNewiSiti/HHHUT1YTK1760Y6RSYc6roKLX7e
         w+1mZyvCPSVC+3XtGvjBB8WhgqDyJM77e9owpwW45dwNtXSeq7mbNg/tKjwBYRFHZxlv
         T2BWOtZf5JnkT4755Tq12BUwuBqTWi4ac3VrrOTAZP72nhFyAKd8q8jeY5K771NwNVJr
         /S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715475976; x=1716080776;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kku9r8c20t6N8G9TMWlm80m7+rQKWFfJHyiSJYpFo8U=;
        b=ZxX+up/HNz2iEjvzdtIr1z7PcuxTjlk/tKy/ILONmZKeJsrTe4BsyMtdjMIwnPwLoX
         u97h2fHt+8wuaimIqwsZuPFjJ0PPbbb/VcrYrDxEufP5tbB520UvZxBpxH2e5kOMh9RJ
         KLeZc0QFyG2Rkzc9hWYAzMc8NQ+NLCWMCvf9SInzHzz8tTOFx16UgeeqRfX2KbedJUSf
         ru5TRqS2dXT7v89y8dG4tcSNwxYak0o0heQE4K7ZpkTbopxaPP2BssmI3IJVFWblKwec
         1dBwi+nP5oq+HavCbO/Z4Fjcio0rsgRgNT1TVrER0OLmyrnSfmsUCLZ/phNZbXvYKvnC
         VVNA==
X-Forwarded-Encrypted: i=1; AJvYcCVTtucuBcICod2KV383dxODdxAX2aMcLlrGhuxh0RleAiZxpDZvHtUhhKnS+Izhe3A5aRJKWU0353vz7arNRPBZJzzqIjZGcZq9galxkA==
X-Gm-Message-State: AOJu0Yzv6bcPIVvY3xLwrcHvzk+/2O9bFSJHCe6On6X1qBJ/l6LEeeVP
	WN3ygANDsYliPvqc5hiPEcW2rpju6FkpASuyew4yqR2dZryc32YkShldsZvc5Xifo2JA782NzKk
	pFeuVRs09gDuvDgJUDRqvRg==
X-Google-Smtp-Source: AGHT+IGTqI1+1anxvkwMj/yzX5AJtsVqV9YsNDEYZtHE9VeGmLxgqc6IWpExt75H8AqBvsGfEF3gBEFp7AHj97pgLg==
X-Received: from souravbig.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b3a])
 (user=souravpanda job=sendgmr) by 2002:a17:90b:190e:b0:2b5:af18:5f98 with
 SMTP id 98e67ed59e1d1-2b6cc76d3efmr17547a91.3.1715475976093; Sat, 11 May 2024
 18:06:16 -0700 (PDT)
Date: Sun, 12 May 2024 01:06:11 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240512010611.290464-1-souravpanda@google.com>
Subject: [PATCH v12] mm: report per-page metadata information
From: Sourav Panda <souravpanda@google.com>
To: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, souravpanda@google.com, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, hannes@cmpxchg.org, 
	shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@Oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"

Today, we do not have any observability of per-page metadata
and how much it takes away from the machine capacity. Thus,
we want to describe the amount of memory that is going towards
per-page metadata, which can vary depending on build
configuration, machine architecture, and system use.

This patch adds 2 fields to /proc/vmstat that can used as shown
below:

Accounting per-page metadata allocated by boot-allocator:
	/proc/vmstat:nr_memmap_boot * PAGE_SIZE

Accounting per-page metadata allocated by buddy-allocator:
	/proc/vmstat:nr_memmap * PAGE_SIZE

Accounting total Perpage metadata allocated on the machine:
	(/proc/vmstat:nr_memmap_boot +
	 /proc/vmstat:nr_memmap) * PAGE_SIZE

Utility for userspace:

Observability: Describe the amount of memory overhead that is
going to per-page metadata on the system at any given time since
this overhead is not currently observable.

Debugging: Tracking the changes or absolute value in struct pages
can help detect anomalies as they can be correlated with other
metrics in the machine (e.g., memtotal, number of huge pages,
etc).

page_ext overheads: Some kernel features such as page_owner
page_table_check that use page_ext can be optionally enabled via
kernel parameters. Having the total per-page metadata information
helps users precisely measure impact. Furthermore, page-metadata
metrics will reflect the amount of struct pages reliquished
(or overhead reduced) when hugetlbfs pages are reserved which
will vary depending on whether hugetlb vmemmap optimization is
enabled or not.

For background and results see:
lore.kernel.org/all/20240220214558.3377482-1-souravpanda@google.com

Signed-off-by: Sourav Panda <souravpanda@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
Changelog:
Restructured the cover-letter.
Removed the Memmap field being exported to /proc/meminfo.
Synchronized with 6.9-rc7.

v11:
https://lore.kernel.org/all/20240427202840.4123201-1-souravpanda@google.com
---
 include/linux/mmzone.h |  2 ++
 include/linux/vmstat.h |  4 ++++
 mm/hugetlb_vmemmap.c   | 17 +++++++++++++----
 mm/mm_init.c           |  3 +++
 mm/page_alloc.c        |  1 +
 mm/page_ext.c          | 32 +++++++++++++++++++++++---------
 mm/sparse-vmemmap.c    |  8 ++++++++
 mm/sparse.c            |  7 ++++++-
 mm/vmstat.c            | 26 +++++++++++++++++++++++++-
 9 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c11b7cde81efa..780855f72b4db 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -217,6 +217,8 @@ enum node_stat_item {
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
+	NR_MEMMAP, /* page metadata allocated through buddy allocator */
+	NR_MEMMAP_BOOT, /* page metadata allocated through boot allocator */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 343906a98d6ee..c3785fdd3668d 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -632,4 +632,8 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
 {
 	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
 }
+
+void __meminit mod_node_early_perpage_metadata(int nid, long delta);
+void __meminit store_early_perpage_metadata(void);
+
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index da177e49d9564..2da8689aeb93f 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -184,10 +184,13 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
  */
 static inline void free_vmemmap_page(struct page *page)
 {
-	if (PageReserved(page))
+	if (PageReserved(page)) {
 		free_bootmem_page(page);
-	else
+		mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1);
+	} else {
 		__free_page(page);
+		mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
+	}
 }
 
 /* Free a list of the vmemmap pages */
@@ -338,6 +341,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, vmemmap_pages);
+		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, 1);
 	}
 
 	/*
@@ -384,14 +388,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
 	int nid = page_to_nid((struct page *)start);
 	struct page *page, *next;
+	int i;
 
-	while (nr_pages--) {
+	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page)
+		if (!page) {
+			mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i);
 			goto out;
+		}
 		list_add(&page->lru, list);
 	}
 
+	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
+
 	return 0;
 out:
 	list_for_each_entry_safe(page, next, list, lru)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 549e76af8f82a..1a429c73b32e4 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -27,6 +27,7 @@
 #include <linux/swap.h>
 #include <linux/cma.h>
 #include <linux/crash_dump.h>
+#include <linux/vmstat.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -1656,6 +1657,8 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 		panic("Failed to allocate %ld bytes for node %d memory map\n",
 		      size, pgdat->node_id);
 	pgdat->node_mem_map = map + offset;
+	mod_node_early_perpage_metadata(pgdat->node_id,
+					DIV_ROUND_UP(size, PAGE_SIZE));
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
 		 __func__, pgdat->node_id, (unsigned long)pgdat,
 		 (unsigned long)pgdat->node_mem_map);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 14d39f34d3367..aa8dd5bccb7ac 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5650,6 +5650,7 @@ void __init setup_per_cpu_pageset(void)
 	for_each_online_pgdat(pgdat)
 		pgdat->per_cpu_nodestats =
 			alloc_percpu(struct per_cpu_nodestat);
+	store_early_perpage_metadata();
 }
 
 __meminit void zone_pcp_init(struct zone *zone)
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4548fcc66d74d..c1e324a1427e0 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
 	total_usage += table_size;
+	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
+			    DIV_ROUND_UP(table_size, PAGE_SIZE));
 	return 0;
 }
 
@@ -255,12 +257,15 @@ static void *__meminit alloc_page_ext(size_t size, int nid)
 	void *addr = NULL;
 
 	addr = alloc_pages_exact_nid(nid, size, flags);
-	if (addr) {
+	if (addr)
 		kmemleak_alloc(addr, size, 1, flags);
-		return addr;
-	}
+	else
+		addr = vzalloc_node(size, nid);
 
-	addr = vzalloc_node(size, nid);
+	if (addr) {
+		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
+				    DIV_ROUND_UP(size, PAGE_SIZE));
+	}
 
 	return addr;
 }
@@ -303,18 +308,27 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
 
 static void free_page_ext(void *addr)
 {
+	size_t table_size;
+	struct page *page;
+	struct pglist_data *pgdat;
+
+	table_size = page_ext_size * PAGES_PER_SECTION;
+
 	if (is_vmalloc_addr(addr)) {
+		page = vmalloc_to_page(addr);
+		pgdat = page_pgdat(page);
 		vfree(addr);
 	} else {
-		struct page *page = virt_to_page(addr);
-		size_t table_size;
-
-		table_size = page_ext_size * PAGES_PER_SECTION;
-
+		page = virt_to_page(addr);
+		pgdat = page_pgdat(page);
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
+
+	mod_node_page_state(pgdat, NR_MEMMAP,
+			    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
+
 }
 
 static void __free_page_ext(unsigned long pfn)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a2cbe44c48e10..1dda6c53370b0 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -469,5 +469,13 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
+	if (system_state == SYSTEM_BOOTING) {
+		mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(end - start,
+								  PAGE_SIZE));
+	} else {
+		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
+				    DIV_ROUND_UP(end - start, PAGE_SIZE));
+	}
+
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index aed0951b87fa0..684a91773bd76 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -14,7 +14,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/bootmem_info.h>
-
+#include <linux/vmstat.h>
 #include "internal.h"
 #include <asm/dma.h>
 
@@ -465,6 +465,9 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	 */
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+	mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_SIZE));
+#endif
 }
 
 static void __init sparse_buffer_fini(void)
@@ -641,6 +644,8 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
+	mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_MEMMAP,
+			    -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a543..79466450040e6 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1252,7 +1252,8 @@ const char * const vmstat_text[] = {
 	"pgdemote_kswapd",
 	"pgdemote_direct",
 	"pgdemote_khugepaged",
-
+	"nr_memmap",
+	"nr_memmap_boot",
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
@@ -2279,4 +2280,27 @@ static int __init extfrag_debug_init(void)
 }
 
 module_init(extfrag_debug_init);
+
 #endif
+
+/*
+ * Page metadata size (struct page and page_ext) in pages
+ */
+static unsigned long early_perpage_metadata[MAX_NUMNODES] __meminitdata;
+
+void __meminit mod_node_early_perpage_metadata(int nid, long delta)
+{
+	early_perpage_metadata[nid] += delta;
+}
+
+void __meminit store_early_perpage_metadata(void)
+{
+	int nid;
+	struct pglist_data *pgdat;
+
+	for_each_online_pgdat(pgdat) {
+		nid = pgdat->node_id;
+		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
+				    early_perpage_metadata[nid]);
+	}
+}
-- 
2.45.0.118.g7fe29c98d7-goog



Return-Path: <linux-fsdevel+bounces-9465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2560B8415DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 23:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934C91F23E12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 22:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980A851C51;
	Mon, 29 Jan 2024 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7s8EfOf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602DD4F21A
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568132; cv=none; b=Ra2M9zBgj4m0HFN+ELgaN/zQdrTYwVcB880svVFKp1G1oXkFFG0LJ75UU+GxD2fj/QqJ7ykyX+NJ8wH0+546MrKcx1XchzlKWvipHkv4bs6oAaHN7yubjYfAtQlikOI9Yi802FGQX4zJlyBV47BIVe76GbFvtSBHp71WhajOJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568132; c=relaxed/simple;
	bh=7ihW8v3OxecNnJC1d8g5Zh24OWhPpxRNRbvzDG4DMcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=s+Kp/JotuqHFKK91pmIjHHNFJaitFmNMMQalcKSOZL1GnNilHuo2OKhZ0EleiX3+udBKzn2X5mDAeEPyXZB0mxxly95eYiPTMRM+Q7spcej6ZKfACpLgIKGUMq0QxNawjmlkDyKy3n703FuKpJf4DLVs+bY4m4tlqDGR1WoD5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7s8EfOf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc2629d180fso7012397276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 14:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706568128; x=1707172928; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9UNYM3oon+KNRFJae/Hoj+b56jmVC1VTPRCIvAyqKxA=;
        b=q7s8EfOfT0uwD3nzstPnum8XsyLzk2gftJ9OFB1RhUua1Hc8SGAh0qTnYeHBaoJ58Q
         +VO3kiolPGZOEzY4bISvsebUVZb4r58aOqf2kN1WNykf9jUoyD14aZKicaYf5z6Yrf7R
         ydMA0GL/wSsfkTgq7U9uXXc8JUQTOSp+Df13EiX69c7yI6804KKGPacm9/EwvhNpyVjQ
         I0hZwsJOK861m/COabu908s/1bCsrg0EKlH5i6N4u+6MNr4pdxcopMah0MVFTNHaOZGD
         Eqhm73xDkRA9K2q3cSw2qo8KhM8bsfrazAFgv3cdl0sd/mnvljqQQeqK1oYsUtaQrhFE
         nhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568128; x=1707172928;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UNYM3oon+KNRFJae/Hoj+b56jmVC1VTPRCIvAyqKxA=;
        b=VNZJiN/YuF1nIBQN95mNUsFv3lsztNjVp61DLpQgX6G4NmuogaKWQJSK3uH+2GHTMR
         VvRzsyhGepy63FfaKAFVPAalebv1Aik+AbVNdJKpJ2C/QaC2hLSALQOE7tYGQukkHZjt
         ijgL3TysGKIZK6uQytRZcZOf0PAgiw1hhHK1a1d7arUoI1n8Cpbmv2TSppL2071a/gEI
         xG6qq7+Lx3Ugrs7AR7OVoK2cNNS/YZ1ZwgfN70s/U9mv4iyHLQNZcQJ78atnu4GD/jVs
         j4/VLOfmyp7mONhTAN1ZpWvOmu9/iLX94NPO20REUEiKamqn7adH87S37fxVznj7U6Zk
         WCpQ==
X-Gm-Message-State: AOJu0Yy7i8BsCv/paStbmbk3Iw0JwS72+KLxsk9Yvn0kOWkrhArpDIZG
	OTBet9xYQ8VYrM0bJCoaco3NP+z9ZoFGhRIlsdnfV49VaT/6j+KqSQsjbhLo6pM0QEYUla7+s+0
	qn0bDX7NYweGo3Q8fGrjunA==
X-Google-Smtp-Source: AGHT+IFIwjXI8QdrNO2hjjRChw9VzzQSU6llG5rLPa0v4OGIgPbgC31I1t/gHAyQmqw71DIgaScvKCvjc0ALBa3dCg==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:56e5:d75e:57c4:836c])
 (user=souravpanda job=sendgmr) by 2002:a05:6902:2405:b0:dc2:6501:f42 with
 SMTP id dr5-20020a056902240500b00dc265010f42mr2414782ybb.5.1706568128376;
 Mon, 29 Jan 2024 14:42:08 -0800 (PST)
Date: Mon, 29 Jan 2024 14:42:04 -0800
In-Reply-To: <20240129224204.1812062-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129224204.1812062-1-souravpanda@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129224204.1812062-2-souravpanda@google.com>
Subject: [PATCH v7 1/1] mm: report per-page metadata information
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

Adds two new per-node fields, namely nr_page_metadata and
nr_page_metadata_boot, to /sys/devices/system/node/nodeN/vmstat
and a global PageMetadata field to /proc/meminfo. This information can
be used by users to see how much memory is being used by per-page
metadata, which can vary depending on build configuration, machine
architecture, and system use.

Per-page metadata is the amount of memory that Linux needs in order to
manage memory at the page granularity. The majority of such memory is
used by "struct page" and "page_ext" data structures. In contrast to
most other memory consumption statistics, per-page metadata might not
be included in MemTotal. For example, MemTotal does not include memblock
allocations but includes buddy allocations. In this patch, exported
field nr_page_metadata in /sys/devices/system/node/nodeN/vmstat would
exclusively track buddy allocations while nr_page_metadata_boot would
exclusively track memblock allocations. Furthermore, PageMetadata in
/proc/meminfo would exclusively track buddy allocations allowing it to
be compared against MemTotal.

This memory depends on build configurations, machine architectures, and
the way system is used:

Build configuration may include extra fields into "struct page",
and enable / disable "page_ext"
Machine architecture defines base page sizes. For example 4K x86,
8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
overhead is smaller on machines with larger page sizes.
System use can change per-page overhead by using vmemmap
optimizations with hugetlb pages, and emulated pmem devdax pages.
Also, boot parameters can determine whether page_ext is needed
to be allocated. This memory can be part of MemTotal or be outside
MemTotal depending on whether the memory was hot-plugged, booted with,
or hugetlb memory was returned back to the system.

Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 Documentation/filesystems/proc.rst |  3 +++
 fs/proc/meminfo.c                  |  4 ++++
 include/linux/mmzone.h             |  4 ++++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb_vmemmap.c               | 19 ++++++++++++++----
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  8 ++++++++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 26 +++++++++++++++++++++++-
 11 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 49ef12df631b..d5901d04e082 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -993,6 +993,7 @@ Example output. You may not have all of these fields.
     AnonPages:       4654780 kB
     Mapped:           266244 kB
     Shmem:              9976 kB
+    PageMetadata:     513419 kB
     KReclaimable:     517708 kB
     Slab:             660044 kB
     SReclaimable:     517708 kB
@@ -1095,6 +1096,8 @@ Mapped
               files which have been mmapped, such as libraries
 Shmem
               Total memory used by shared memory (shmem) and tmpfs
+PageMetadata
+              Memory used for per-page metadata
 KReclaimable
               Kernel allocations that the kernel will attempt to reclaim
               under memory pressure. Includes SReclaimable (below), and other
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 45af9a989d40..e0bde16717fd 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -39,6 +39,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	long available;
 	unsigned long pages[NR_LRU_LISTS];
 	unsigned long sreclaimable, sunreclaim;
+	unsigned long nr_page_metadata;
 	int lru;
 
 	si_meminfo(&i);
@@ -57,6 +58,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
 	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
 
+	nr_page_metadata = global_node_page_state_pages(NR_PAGE_METADATA);
+
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
 	show_val_kb(m, "MemAvailable:   ", available);
@@ -104,6 +107,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Mapped:         ",
 		    global_node_page_state(NR_FILE_MAPPED));
 	show_val_kb(m, "Shmem:          ", i.sharedram);
+	show_val_kb(m, "PageMetadata:   ", nr_page_metadata);
 	show_val_kb(m, "KReclaimable:   ", sreclaimable +
 		    global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
 	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3c25226beeed..ef176152be7c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -207,6 +207,10 @@ enum node_stat_item {
 	PGPROMOTE_SUCCESS,	/* promote successfully */
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
 #endif
+	NR_PAGE_METADATA,	/* Page metadata size (struct page and page_ext)
+				 * in pages
+				 */
+	NR_PAGE_METADATA_BOOT,	/* NR_PAGE_METADATA for bootmem */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fed855bae6d8..af096a881f03 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -656,4 +656,8 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
 {
 	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
 }
+
+void __init mod_node_early_perpage_metadata(int nid, long delta);
+void __init store_early_perpage_metadata(void);
+
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 87818ee7f01d..5b10d8d2b471 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -230,10 +230,14 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
  */
 static inline void free_vmemmap_page(struct page *page)
 {
-	if (PageReserved(page))
+	if (PageReserved(page)) {
 		free_bootmem_page(page);
-	else
+		mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA_BOOT,
+				    -1);
+	} else {
 		__free_page(page);
+		mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA, -1);
+	}
 }
 
 /* Free a list of the vmemmap pages */
@@ -389,6 +393,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, vmemmap_pages);
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, 1);
 	}
 
 	/*
@@ -437,14 +442,20 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
 	int nid = page_to_nid((struct page *)start);
 	struct page *page, *next;
+	int i;
 
-	while (nr_pages--) {
+	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page)
+		if (!page) {
+			mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+					    i);
 			goto out;
+		}
 		list_add(&page->lru, list);
 	}
 
+	mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, nr_pages);
+
 	return 0;
 out:
 	list_for_each_entry_safe(page, next, list, lru)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 077bfe393b5e..38f8e1f454a0 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
+#include <linux/vmstat.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -1656,6 +1657,8 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 			panic("Failed to allocate %ld bytes for node %d memory map\n",
 			      size, pgdat->node_id);
 		pgdat->node_mem_map = map + offset;
+		mod_node_early_perpage_metadata(pgdat->node_id,
+						DIV_ROUND_UP(size, PAGE_SIZE));
 	}
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
 				__func__, pgdat->node_id, (unsigned long)pgdat,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 733732e7e0ba..dd78017105b0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5636,6 +5636,7 @@ void __init setup_per_cpu_pageset(void)
 	for_each_online_pgdat(pgdat)
 		pgdat->per_cpu_nodestats =
 			alloc_percpu(struct per_cpu_nodestat);
+	store_early_perpage_metadata();
 }
 
 __meminit void zone_pcp_init(struct zone *zone)
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4548fcc66d74..4ca9f298f34e 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
 	total_usage += table_size;
+	mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA_BOOT,
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
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
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
+	mod_node_page_state(pgdat, NR_PAGE_METADATA,
+			    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
+
 }
 
 static void __free_page_ext(unsigned long pfn)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a2cbe44c48e1..054b49539843 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -469,5 +469,13 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
+	if (system_state == SYSTEM_BOOTING) {
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA_BOOT,
+				    DIV_ROUND_UP(end - start, PAGE_SIZE));
+	} else {
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+				    DIV_ROUND_UP(end - start, PAGE_SIZE));
+	}
+
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 77d91e565045..0c100ae1cf8b 100644
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
 
+	mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_PAGE_METADATA,
+			    -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 359460deb377..23e88d8c21b7 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1249,7 +1249,8 @@ const char * const vmstat_text[] = {
 	"pgpromote_success",
 	"pgpromote_candidate",
 #endif
-
+	"nr_page_metadata",
+	"nr_page_metadata_boot",
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
@@ -2278,4 +2279,27 @@ static int __init extfrag_debug_init(void)
 }
 
 module_init(extfrag_debug_init);
+
 #endif
+
+/*
+ * Page metadata size (struct page and page_ext) in pages
+ */
+static unsigned long early_perpage_metadata[MAX_NUMNODES] __initdata;
+
+void __init mod_node_early_perpage_metadata(int nid, long delta)
+{
+	early_perpage_metadata[nid] += delta;
+}
+
+void __init store_early_perpage_metadata(void)
+{
+	int nid;
+	struct pglist_data *pgdat;
+
+	for_each_online_pgdat(pgdat) {
+		nid = pgdat->node_id;
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA_BOOT,
+				    early_perpage_metadata[nid]);
+	}
+}
-- 
2.43.0.429.g432eaa2c6b-goog



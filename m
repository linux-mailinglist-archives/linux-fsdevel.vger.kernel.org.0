Return-Path: <linux-fsdevel+bounces-17075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F042C8A7553
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 22:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD55282ED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB7139D1F;
	Tue, 16 Apr 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LBg+e43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CD13959D
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298441; cv=none; b=Kmqwl8xseTpSF4aO2PKNKZXNbb+ocO4AwUJpuehLac2e3WvtCf6DVuFiafp1b6AOwVSGStHN/U2SpS8bOwgyCcg2PIyDazoIaqVHyuZNig/utaNLXYUyeLJvS+Y2Y+KOe/NwuqcaZqWnOI4dWwilSfT7IcslQyjp92+hakuVNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298441; c=relaxed/simple;
	bh=eRv7C6mi/HY3w+g5Y3tiaa27Xxhee/YCOinhKGaZKbw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=gzDcJaLLVVB9uy9c4EBPuL7N84BKA0EJgU7F4IPAPWjaZ4ZHu+XhON2J1zwdOXha2EmGfX1zdAXhX05u6SPVrmPNyOPPoRBnSC5uCe5L9rivbZyrai3cyuA8ph5LqgRH8NdWjiiofeJBURduSkO1NFQZS58YdGPRzSPEXNNhzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1LBg+e43; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a5d989e820so4903834a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713298438; x=1713903238; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5+0mWDj5YyL9/GrbgHCkcu0KcQyCV85rLEHru7HoU1U=;
        b=1LBg+e43KNoUQ7rPCWBv/zEUr8W3V30S8wIhip6bYjlPL1DWk6ErOatBlByq1v6k2/
         vD7mCWepcZnbtYvvuI5X/NfR9bWLdd3wWFiEg0xuPjTRlYHptM4WJSWivIjltYyaDAY0
         8XVDSxYt/wF86amnNnEZCYxV4VAbP/Nnii8b9mYPoUg8GNCCVhUVHQgst2Cv0H37AHVy
         FE6emDoCZmHWB7O2ve8H6Wusf0PMFTqyThteXhG2U8KRIHiLFzSE0jB4igRmUnZAIorb
         6JrhGpjn2WtwAAjZF51c5aLnWU/p3emFBiJouAzjPKZbIOOm60KGnEcIftmUdNXB5z0L
         erOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713298438; x=1713903238;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+0mWDj5YyL9/GrbgHCkcu0KcQyCV85rLEHru7HoU1U=;
        b=gJKurmW1J4NYXSLO/OGOlkxVHzzJjDeH4vzI1xeeG0il6cJjsuldiTPBWCy2hWdNOI
         /RgEtWEe3VTGTkU5L3m4+OfNawQs1INM3uOqW6n9Rj23zMDPDdFF5wD9fMg0gBXPxpQk
         WczSTw4vDFDxe+Xrt17HH6fjmsc6gNLvcTLAM/YPRG6ahw5lJMyjDFNhVfC/am8o7GYg
         w5uLuB1kQfEqL77z7/zWnTGWN7SeuMkgwSwxExPRp3YRRDgtYbGhQ2bScnnrYsU6db/K
         qFLvJuzld8D1SJYe3Is1tMR/dLdDiEz9jjkG6aHlDUceXq/uPmrmKYJ8MMk/DBipGe4o
         1r6Q==
X-Forwarded-Encrypted: i=1; AJvYcCURhMqNgf1aKwIe2VAIih6u7OoD+uNXBPsJnLMVu/n+NfaKLSufwzaD9aYVSJBP2Jnk4T/87glURnFkMob/+tzWpaWizzYI2AkjSUlaLw==
X-Gm-Message-State: AOJu0Yyc2C9SH44SRbrtxIJGPLXmFcVUIaeHeHaNUu55pH2UnQUot/aG
	ygAwhi2qk/2AfGUCnUEcP7y8zoZYTJjSHJY8me54AwI5dA9NpuZq61qb54f950+88hAFefxa6GY
	RXr6RIZL9dzYqxyg28qpy7A==
X-Google-Smtp-Source: AGHT+IGKjsM4HOOcxA5N+OnChlDcXH7sG0GTDw4eWq03GgmEnDAf0FLS/U1ves8jAerwenJfm+VDDKdaN/IkrbKZ3Q==
X-Received: from souravbig.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b3a])
 (user=souravpanda job=sendgmr) by 2002:a17:90b:3108:b0:2a5:c859:f94f with
 SMTP id gc8-20020a17090b310800b002a5c859f94fmr56933pjb.3.1713298438008; Tue,
 16 Apr 2024 13:13:58 -0700 (PDT)
Date: Tue, 16 Apr 2024 20:13:35 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416201335.3551099-1-souravpanda@google.com>
Subject: [PATCH v10] mm: report per-page metadata information
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

Adds a global Memmap field to /proc/meminfo. This information can
be used by users to see how much memory is being used by per-page
metadata, which can vary depending on build configuration, machine
architecture, and system use.

Accounting per-page metadata allocated by boot-allocator:
    /proc/vmstat:nr_memmap_boot * PAGE_SIZE

Accounting per-page metadata allocated by buddy-allocator:
    /proc/vmstat:nr_memmap * PAGE_SIZE

Accounting total Perpage metadata allocated on the machine:
    (/proc/vmstat:nr_memmap_boot + /proc/vmstat:nr_memmap) * PAGE_SIZE

Utility for userspace:

Application Optimization: Depending on the kernel version and command
line options, the kernel would relinquish a different number of pages
(that contain struct pages) when a hugetlb page is reserved (e.g., 0, 6
or 7 for a 2MB hugepage). This patch allows the userspace application
to know the exact savings achieved through page metadata deallocation
without dealing with the intricacies of the kernel.

Observability: Struct page overhead can only be calculated on-paper at
boot time (e.g., 1.5% machine capacity). Beyond boot once hugepages are
reserved or memory is hotplugged, the computation becomes complex.
Per-page metrics will help explain part of the system memory overhead,
which shall help guide memory optimizations and memory cgroup sizing.

Debugging: Tracking the changes or absolute value in struct pages can
help detect anomalies as they can be correlated with other metrics in
the machine (e.g., memtotal, number of huge pages, etc).

page_ext overheads: Some kernel features such as page_owner
page_table_check that use page_ext can be optionally enabled via kernel
parameters. Having the total per-page metadata information helps users
precisely measure impact.

For background and results see:
lore.kernel.org/all/20240220214558.3377482-1-souravpanda@google.com

Signed-off-by: Sourav Panda <souravpanda@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
Changelog:
Consolidated changelog and coverletter.
Synchronized with 6.9-rc4.

v9:
lore.kernel.org/all/20240220214558.3377482-1-souravpanda@google.com
---
 Documentation/filesystems/proc.rst |  3 +++
 fs/proc/meminfo.c                  |  4 ++++
 include/linux/mmzone.h             |  4 ++++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb_vmemmap.c               | 17 ++++++++++++----
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  8 ++++++++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 26 +++++++++++++++++++++++-
 11 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c6a6b9df21049..a7445d49a3bb7 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -993,6 +993,7 @@ Example output. You may not have all of these fields.
     AnonPages:       4654780 kB
     Mapped:           266244 kB
     Shmem:              9976 kB
+    Memmap:           513419 kB
     KReclaimable:     517708 kB
     Slab:             660044 kB
     SReclaimable:     517708 kB
@@ -1095,6 +1096,8 @@ Mapped
               files which have been mmapped, such as libraries
 Shmem
               Total memory used by shared memory (shmem) and tmpfs
+Memmap
+              Memory used for per-page metadata
 KReclaimable
               Kernel allocations that the kernel will attempt to reclaim
               under memory pressure. Includes SReclaimable (below), and other
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 45af9a989d404..3d3db55cfeab6 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -39,6 +39,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	long available;
 	unsigned long pages[NR_LRU_LISTS];
 	unsigned long sreclaimable, sunreclaim;
+	unsigned long nr_memmap;
 	int lru;
 
 	si_meminfo(&i);
@@ -57,6 +58,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
 	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
 
+	nr_memmap = global_node_page_state_pages(NR_MEMMAP);
+
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
 	show_val_kb(m, "MemAvailable:   ", available);
@@ -104,6 +107,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Mapped:         ",
 		    global_node_page_state(NR_FILE_MAPPED));
 	show_val_kb(m, "Shmem:          ", i.sharedram);
+	show_val_kb(m, "Memmap:         ", nr_memmap);
 	show_val_kb(m, "KReclaimable:   ", sreclaimable +
 		    global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
 	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c11b7cde81efa..ba9143f90977f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -217,6 +217,10 @@ enum node_stat_item {
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
+	NR_MEMMAP,		/* Page metadata size (struct page and page_ext)
+				 * in pages
+				 */
+	NR_MEMMAP_BOOT,		/* NR_MEMMAP for bootmem */
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
2.44.0.683.g7961c838ac-goog



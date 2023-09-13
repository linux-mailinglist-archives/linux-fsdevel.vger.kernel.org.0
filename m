Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72979F065
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjIMRaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjIMRaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:30:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD469E
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 10:30:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so106971276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694626204; x=1695231004; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZythF5qJnF0wFfPZY5fIiXts+Lu4h1VVptJJPd7woHw=;
        b=pLvwF8YIzkaKcMENglsEmaE0IkF/HJzw7U+3NMRl/mpytFJ2wtP3H4IwIEZ0Gu58Q9
         4X+2VzpvePHcnIt3KuFlzzKFIKg9j4YI1Kh31NTZIoTxeTdfQCD/9wZrLtb96xhUXIFq
         QY/b7QNXe1Xnp9hYmOUuhowmQXbfSkKifGVM5B9Kmfdnu6q9mrYidg4EQBr1fDpnavGa
         L6OaC8re59Njh902cvSLeBO+NuIAuAHz9t7PiR5DNwC1lUeLmesQUnwnUf+1Adsv2Pha
         UtXtjmDzbQMRXpQ1YSlaf8iWt8075bGzhFZVIw1usrbUOq+aXJH32uZNhOapEAtckrhB
         uFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626204; x=1695231004;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZythF5qJnF0wFfPZY5fIiXts+Lu4h1VVptJJPd7woHw=;
        b=HchgfbFPgV+dBykQE+QfpfQVTnT5g9UyscILCMsJTAGzP/c+Xr9cj8u4+Bk3YxtqK0
         R9qFycqDEu8BsjR3bQaau2JdjP4vyvgQnaLyk9yf6RkPqaWF8KOfBGBr+OUIu2EhEDjA
         kx929q0Hxze/T26CsDtNi6jPfNELWf2g/uR79klhlGVXRuYUA+RRp1suF2Mj2zBy1ZcS
         7yvlMVmE11ioMCzDyi0bEpi7BYYGFn7qsZZa0PQtmWOw+6Rhw8N3uQTpfrW29EOQqOd3
         qLfqWLbSk0RoTchglb1kx8Tr3+RkVIFdu4se+MKrhIA7qaDu2oLuHlqUCUK5SR6pyaFL
         YeeA==
X-Gm-Message-State: AOJu0YxOUZFjLPMYP+Q7PkpOM8O76mY0ojuex620S00As03up4x62PdW
        OWewDmVaMQDi5v5j3Mmqs6oGbMGz7shWl6aX5Q==
X-Google-Smtp-Source: AGHT+IE8oEUWL2avrPVtB0a1//kd5SsQQm0oounKKJMx5HfRSTj+6eo2tXR3os30UdPJ4OtY05sIoJ1tl9LY+fsJzQ==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:2718:5cf5:d91:d21d])
 (user=souravpanda job=sendgmr) by 2002:a05:6902:1816:b0:d0e:e780:81b3 with
 SMTP id cf22-20020a056902181600b00d0ee78081b3mr75185ybb.2.1694626204504; Wed,
 13 Sep 2023 10:30:04 -0700 (PDT)
Date:   Wed, 13 Sep 2023 10:30:00 -0700
In-Reply-To: <20230913173000.4016218-1-souravpanda@google.com>
Mime-Version: 1.0
References: <20230913173000.4016218-1-souravpanda@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230913173000.4016218-2-souravpanda@google.com>
Subject: [PATCH v1 1/1] mm: report per-page metadata information
From:   Sourav Panda <souravpanda@google.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
        rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, souravpanda@google.com,
        tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@Oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds a new per-node PageMetadata field to
/sys/devices/system/node/nodeN/meminfo
and a global PageMetadata field to /proc/meminfo. This information can
be used by users to see how much memory is being used by per-page
metadata, which can vary depending on build configuration, machine
architecture, and system use.

Per-page metadata is the amount of memory that Linux needs in order to
manage memory at the page granularity. The majority of such memory is
used by "struct page" and "page_ext" data structures.

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
 drivers/base/node.c                |  2 ++
 fs/proc/meminfo.c                  |  7 +++++++
 include/linux/mmzone.h             |  3 +++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb.c                       |  8 +++++++-
 mm/hugetlb_vmemmap.c               |  9 ++++++++-
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 17 +++++++++++++----
 mm/sparse-vmemmap.c                |  3 +++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 21 +++++++++++++++++++++
 13 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2b59cff8be17..c121f2ef9432 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -987,6 +987,7 @@ Example output. You may not have all of these fields.
     AnonPages:       4654780 kB
     Mapped:           266244 kB
     Shmem:              9976 kB
+    PageMetadata:     513419 kB
     KReclaimable:     517708 kB
     Slab:             660044 kB
     SReclaimable:     517708 kB
@@ -1089,6 +1090,8 @@ Mapped
               files which have been mmapped, such as libraries
 Shmem
               Total memory used by shared memory (shmem) and tmpfs
+PageMetadata
+              Memory used for per-page metadata
 KReclaimable
               Kernel allocations that the kernel will attempt to reclaim
               under memory pressure. Includes SReclaimable (below), and other
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 493d533f8375..da728542265f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -428,6 +428,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d Mapped:         %8lu kB\n"
 			     "Node %d AnonPages:      %8lu kB\n"
 			     "Node %d Shmem:          %8lu kB\n"
+			     "Node %d PageMetadata:   %8lu kB\n"
 			     "Node %d KernelStack:    %8lu kB\n"
 #ifdef CONFIG_SHADOW_CALL_STACK
 			     "Node %d ShadowCallStack:%8lu kB\n"
@@ -458,6 +459,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
 			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
 			     nid, K(i.sharedram),
+			     nid, K(node_page_state(pgdat, NR_PAGE_METADATA)),
 			     nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
 #ifdef CONFIG_SHADOW_CALL_STACK
 			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 45af9a989d40..f141bb2a550d 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -39,7 +39,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	long available;
 	unsigned long pages[NR_LRU_LISTS];
 	unsigned long sreclaimable, sunreclaim;
+	unsigned long nr_page_metadata;
 	int lru;
+	int nid;
 
 	si_meminfo(&i);
 	si_swapinfo(&i);
@@ -57,6 +59,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
 	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
 
+	nr_page_metadata = 0;
+	for_each_online_node(nid)
+		nr_page_metadata += node_page_state(NODE_DATA(nid), NR_PAGE_METADATA);
+
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
 	show_val_kb(m, "MemAvailable:   ", available);
@@ -104,6 +110,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Mapped:         ",
 		    global_node_page_state(NR_FILE_MAPPED));
 	show_val_kb(m, "Shmem:          ", i.sharedram);
+	show_val_kb(m, "PageMetadata:   ", nr_page_metadata);
 	show_val_kb(m, "KReclaimable:   ", sreclaimable +
 		    global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
 	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..dda1ad522324 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -207,6 +207,9 @@ enum node_stat_item {
 	PGPROMOTE_SUCCESS,	/* promote successfully */
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
 #endif
+	NR_PAGE_METADATA,	/* Page metadata size (struct page and page_ext)
+				 * in pages
+				 */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fed855bae6d8..b5c292560f37 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -656,4 +656,8 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
 {
 	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
 }
+
+void __init mod_node_early_perpage_metadata(int nid, long delta);
+void __init writeout_early_perpage_metadata(void);
+
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ba6d39b71cb1..ca36751be50e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1758,6 +1758,10 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+		__mod_node_page_state(NODE_DATA(page_to_nid(&folio->page)),
+				      NR_PAGE_METADATA, -huge_page_order(h));
+#endif
 		__free_pages(&folio->page, huge_page_order(h));
 	}
 }
@@ -2143,7 +2147,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		__count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
 		return NULL;
 	}
-
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, huge_page_order(h));
+#endif
 	__count_vm_event(HTLB_BUDDY_PGALLOC);
 	return page_folio(page);
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4b9734777f69..7f920bfa8e79 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -214,6 +214,8 @@ static inline void free_vmemmap_page(struct page *page)
 		free_bootmem_page(page);
 	else
 		__free_page(page);
+	__mod_node_page_state(NODE_DATA(page_to_nid(page)),
+			      NR_PAGE_METADATA, -1);
 }
 
 /* Free a list of the vmemmap pages */
@@ -336,6 +338,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, &vmemmap_pages);
 	}
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, 1);
 
 	/*
 	 * In order to make remapping routine most efficient for the huge pages,
@@ -387,8 +390,12 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 
 	while (nr_pages--) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page)
+		if (!page) {
 			goto out;
+		} else {
+			__mod_node_page_state(NODE_DATA(page_to_nid(page)),
+					      NR_PAGE_METADATA, 1);
+		}
 		list_add_tail(&page->lru, list);
 	}
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 50f2f34745af..e02dce7e2e9a 100644
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
+						PAGE_ALIGN(size) >> PAGE_SHIFT);
 	}
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
 				__func__, pgdat->node_id, (unsigned long)pgdat,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0c5be12f9336..4e295d5087f4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5443,6 +5443,7 @@ void __init setup_per_cpu_pageset(void)
 	for_each_online_pgdat(pgdat)
 		pgdat->per_cpu_nodestats =
 			alloc_percpu(struct per_cpu_nodestat);
+	writeout_early_perpage_metadata();
 }
 
 __meminit void zone_pcp_init(struct zone *zone)
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4548fcc66d74..b5b9d3079e20 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
 	total_usage += table_size;
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+			      PAGE_ALIGN(table_size) >> PAGE_SHIFT);
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
+		__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+				      PAGE_ALIGN(size) >> PAGE_SHIFT);
+	}
 
 	return addr;
 }
@@ -314,6 +319,10 @@ static void free_page_ext(void *addr)
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
+
+		__mod_node_page_state(NODE_DATA(page_to_nid(page)), NR_PAGE_METADATA,
+				      (long)-1 * (PAGE_ALIGN(table_size) >> PAGE_SHIFT));
+
 	}
 }
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a2cbe44c48e1..e33f302db7c6 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -469,5 +469,8 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+			      PAGE_ALIGN(end - start) >> PAGE_SHIFT);
+
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 77d91e565045..db78233a85ef 100644
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
+	mod_node_early_perpage_metadata(nid, PAGE_ALIGN(size) >> PAGE_SHIFT);
+#endif
 }
 
 static void __init sparse_buffer_fini(void)
@@ -641,6 +644,8 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
+	__mod_node_page_state(NODE_DATA(page_to_nid(pfn_to_page(pfn))), NR_PAGE_METADATA,
+			      (long)-1 * (PAGE_ALIGN(end - start) >> PAGE_SHIFT));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 00e81e99c6ee..731eb5264b49 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1245,6 +1245,7 @@ const char * const vmstat_text[] = {
 	"pgpromote_success",
 	"pgpromote_candidate",
 #endif
+	"nr_page_metadata",
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
@@ -2274,4 +2275,24 @@ static int __init extfrag_debug_init(void)
 }
 
 module_init(extfrag_debug_init);
+
+// Page metadata size (struct page and page_ext) in pages
+unsigned long early_perpage_metadata[MAX_NUMNODES] __initdata;
+
+void __init mod_node_early_perpage_metadata(int nid, long delta)
+{
+	early_perpage_metadata[nid] += delta;
+}
+
+void __init writeout_early_perpage_metadata(void)
+{
+	int nid;
+	struct pglist_data *pgdat;
+
+	for_each_online_pgdat(pgdat) {
+		nid = pgdat->node_id;
+		__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+				      early_perpage_metadata[nid]);
+	}
+}
 #endif
-- 
2.42.0.283.g2d96d420d3-goog


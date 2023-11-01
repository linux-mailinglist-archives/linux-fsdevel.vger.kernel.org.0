Return-Path: <linux-fsdevel+bounces-1685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E6A7DDBA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 04:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB79B210A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 03:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECA51116;
	Wed,  1 Nov 2023 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WZUFlbhz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F4010EE
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 03:44:36 +0000 (UTC)
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 20:44:31 PDT
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [IPv6:2001:41d0:203:375::ac])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4094A4
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 20:44:31 -0700 (PDT)
Message-ID: <4a1de79e-a3e8-2544-e975-e17cad0d2f8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698809881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHsD1OxylQ1MZ5/PkTl+8I2miWubAK63+BdXoKTK7E0=;
	b=WZUFlbhzBzGtSN6xnm/357Bfy7rs1qNAROrVHbu6QZ8TnCKIp5jyL3cf6/z5bNYV37U66w
	6rwWU73C48JKgYuENNWb1SWrIMpDW0/OHUtWPcdY/OAYtHEkSecdWhQLFSKOK0UcAiKLww
	gIK2lbtripNKO2++a8BSsuO3yUs2Kc0=
Date: Wed, 1 Nov 2023 11:37:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/1] mm: report per-page metadata information
To: Sourav Panda <souravpanda@google.com>
References: <20231031223846.827173-1-souravpanda@google.com>
 <20231031223846.827173-2-souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
 akpm@linux-foundation.org, mike.kravetz@oracle.com, rppt@kernel.org,
 david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
 yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, bhelgaas@google.com,
 ivan@cloudflare.com, pasha.tatashin@soleen.com, yosryahmed@google.com,
 hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com,
 wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz,
 Liam.Howlett@Oracle.com, surenb@google.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231031223846.827173-2-souravpanda@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2023/11/1 06:38, Sourav Panda wrote:
> Adds a new per-node PageMetadata field to
> /sys/devices/system/node/nodeN/meminfo
> and a global PageMetadata field to /proc/meminfo. This information can
> be used by users to see how much memory is being used by per-page
> metadata, which can vary depending on build configuration, machine
> architecture, and system use.
>
> Per-page metadata is the amount of memory that Linux needs in order to
> manage memory at the page granularity. The majority of such memory is
> used by "struct page" and "page_ext" data structures. In contrast to
> most other memory consumption statistics, per-page metadata might not
> be included in MemTotal. For example, MemTotal does not include memblock
> allocations but includes buddy allocations. While on the other hand,
> per-page metadata would include both memblock and buddy allocations.
>
> This memory depends on build configurations, machine architectures, and
> the way system is used:
>
> Build configuration may include extra fields into "struct page",
> and enable / disable "page_ext"
> Machine architecture defines base page sizes. For example 4K x86,
> 8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
> overhead is smaller on machines with larger page sizes.
> System use can change per-page overhead by using vmemmap
> optimizations with hugetlb pages, and emulated pmem devdax pages.
> Also, boot parameters can determine whether page_ext is needed
> to be allocated. This memory can be part of MemTotal or be outside
> MemTotal depending on whether the memory was hot-plugged, booted with,
> or hugetlb memory was returned back to the system.
>
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Sourav Panda <souravpanda@google.com>
> ---
>   Documentation/filesystems/proc.rst |  3 +++
>   drivers/base/node.c                |  2 ++
>   fs/proc/meminfo.c                  |  7 +++++++
>   include/linux/mmzone.h             |  3 +++
>   include/linux/vmstat.h             |  4 ++++
>   mm/hugetlb.c                       | 11 ++++++++--
>   mm/hugetlb_vmemmap.c               |  8 ++++++--
>   mm/mm_init.c                       |  3 +++
>   mm/page_alloc.c                    |  1 +
>   mm/page_ext.c                      | 32 +++++++++++++++++++++---------
>   mm/sparse-vmemmap.c                |  3 +++
>   mm/sparse.c                        |  7 ++++++-
>   mm/vmstat.c                        | 24 ++++++++++++++++++++++
>   13 files changed, 94 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2b59cff8be17..c121f2ef9432 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -987,6 +987,7 @@ Example output. You may not have all of these fields.
>       AnonPages:       4654780 kB
>       Mapped:           266244 kB
>       Shmem:              9976 kB
> +    PageMetadata:     513419 kB
>       KReclaimable:     517708 kB
>       Slab:             660044 kB
>       SReclaimable:     517708 kB
> @@ -1089,6 +1090,8 @@ Mapped
>                 files which have been mmapped, such as libraries
>   Shmem
>                 Total memory used by shared memory (shmem) and tmpfs
> +PageMetadata
> +              Memory used for per-page metadata
>   KReclaimable
>                 Kernel allocations that the kernel will attempt to reclaim
>                 under memory pressure. Includes SReclaimable (below), and other
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 493d533f8375..da728542265f 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -428,6 +428,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>   			     "Node %d Mapped:         %8lu kB\n"
>   			     "Node %d AnonPages:      %8lu kB\n"
>   			     "Node %d Shmem:          %8lu kB\n"
> +			     "Node %d PageMetadata:   %8lu kB\n"
>   			     "Node %d KernelStack:    %8lu kB\n"
>   #ifdef CONFIG_SHADOW_CALL_STACK
>   			     "Node %d ShadowCallStack:%8lu kB\n"
> @@ -458,6 +459,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>   			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
>   			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
>   			     nid, K(i.sharedram),
> +			     nid, K(node_page_state(pgdat, NR_PAGE_METADATA)),
>   			     nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
>   #ifdef CONFIG_SHADOW_CALL_STACK
>   			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 45af9a989d40..f141bb2a550d 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -39,7 +39,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>   	long available;
>   	unsigned long pages[NR_LRU_LISTS];
>   	unsigned long sreclaimable, sunreclaim;
> +	unsigned long nr_page_metadata;
>   	int lru;
> +	int nid;
>   
>   	si_meminfo(&i);
>   	si_swapinfo(&i);
> @@ -57,6 +59,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>   	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
>   	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
>   
> +	nr_page_metadata = 0;
> +	for_each_online_node(nid)
> +		nr_page_metadata += node_page_state(NODE_DATA(nid), NR_PAGE_METADATA);
> +
>   	show_val_kb(m, "MemTotal:       ", i.totalram);
>   	show_val_kb(m, "MemFree:        ", i.freeram);
>   	show_val_kb(m, "MemAvailable:   ", available);
> @@ -104,6 +110,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>   	show_val_kb(m, "Mapped:         ",
>   		    global_node_page_state(NR_FILE_MAPPED));
>   	show_val_kb(m, "Shmem:          ", i.sharedram);
> +	show_val_kb(m, "PageMetadata:   ", nr_page_metadata);
>   	show_val_kb(m, "KReclaimable:   ", sreclaimable +
>   		    global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
>   	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 4106fbc5b4b3..dda1ad522324 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -207,6 +207,9 @@ enum node_stat_item {
>   	PGPROMOTE_SUCCESS,	/* promote successfully */
>   	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
>   #endif
> +	NR_PAGE_METADATA,	/* Page metadata size (struct page and page_ext)
> +				 * in pages
> +				 */
>   	NR_VM_NODE_STAT_ITEMS
>   };
>   
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index fed855bae6d8..af096a881f03 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -656,4 +656,8 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
>   {
>   	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
>   }
> +
> +void __init mod_node_early_perpage_metadata(int nid, long delta);
> +void __init store_early_perpage_metadata(void);
> +
>   #endif /* _LINUX_VMSTAT_H */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1301ba7b2c9a..cd3158a9c7f3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1790,6 +1790,9 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>   		destroy_compound_gigantic_folio(folio, huge_page_order(h));
>   		free_gigantic_folio(folio, huge_page_order(h));
>   	} else {
> +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> +		__node_stat_sub_folio(folio, NR_PAGE_METADATA);
> +#endif
>   		__free_pages(&folio->page, huge_page_order(h));
>   	}
>   }
> @@ -2125,6 +2128,7 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
>   	struct page *page;
>   	bool alloc_try_hard = true;
>   	bool retry = true;
> +	struct folio *folio;
>   
>   	/*
>   	 * By default we always try hard to allocate the page with
> @@ -2175,9 +2179,12 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
>   		__count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
>   		return NULL;
>   	}
> -
> +	folio = page_folio(page);
> +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> +	__node_stat_add_folio(folio, NR_PAGE_METADATA)

Seems you have not tested this patch with CONFIG_SPARSEMEM_VMEMMAP disabled.
You missed ";" in the end.

> +#endif

I am curious why we should account HugeTLB pages as metadata.

>   	__count_vm_event(HTLB_BUDDY_PGALLOC);
> -	return page_folio(page);
> +	return folio;
>   }
>   
>   /*
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 4b9734777f69..804a93d18cab 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -214,6 +214,7 @@ static inline void free_vmemmap_page(struct page *page)
>   		free_bootmem_page(page);
>   	else
>   		__free_page(page);
> +	__mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA, -1);
>   }
>   
>   /* Free a list of the vmemmap pages */
> @@ -336,6 +337,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   			  (void *)walk.reuse_addr);
>   		list_add(&walk.reuse_page->lru, &vmemmap_pages);
>   	}
> +	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, 1);

What if allocation of walk.reuse_page fails?

>   
>   	/*
>   	 * In order to make remapping routine most efficient for the huge pages,
> @@ -381,14 +383,16 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>   				   struct list_head *list)
>   {
>   	gfp_t gfp_mask = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_THISNODE;
> -	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
> +	unsigned long nr_pages = DIV_ROUND_UP(end - start, PAGE_SIZE);

"end - start" is always multiple of PAGE_SIZE, why we need DIV_ROUND_UP 
here?

>   	int nid = page_to_nid((struct page *)start);
>   	struct page *page, *next;
> +	int i;
>   
> -	while (nr_pages--) {
> +	for (i = 0; i < nr_pages; i++) {
>   		page = alloc_pages_node(nid, gfp_mask, 0);
>   		if (!page)
>   			goto out;
> +		__mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA, 1);
>   		list_add_tail(&page->lru, list);
>   	}

Count one by ine is really inefficient. Can't we count *nr_pages* at
one time?

>   
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 50f2f34745af..6997bf00945b 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -26,6 +26,7 @@
>   #include <linux/pgtable.h>
>   #include <linux/swap.h>
>   #include <linux/cma.h>
> +#include <linux/vmstat.h>
>   #include "internal.h"
>   #include "slab.h"
>   #include "shuffle.h"
> @@ -1656,6 +1657,8 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
>   			panic("Failed to allocate %ld bytes for node %d memory map\n",
>   			      size, pgdat->node_id);
>   		pgdat->node_mem_map = map + offset;
> +		mod_node_early_perpage_metadata(pgdat->node_id,
> +						DIV_ROUND_UP(size, PAGE_SIZE));
>   	}
>   	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
>   				__func__, pgdat->node_id, (unsigned long)pgdat,
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 85741403948f..522dc0c52610 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5443,6 +5443,7 @@ void __init setup_per_cpu_pageset(void)
>   	for_each_online_pgdat(pgdat)
>   		pgdat->per_cpu_nodestats =
>   			alloc_percpu(struct per_cpu_nodestat);
> +	store_early_perpage_metadata();
>   }
>   
>   __meminit void zone_pcp_init(struct zone *zone)
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 4548fcc66d74..d8d6db9c3d75 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
>   		return -ENOMEM;
>   	NODE_DATA(nid)->node_page_ext = base;
>   	total_usage += table_size;
> +	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> +			      DIV_ROUND_UP(table_size, PAGE_SIZE));
>   	return 0;
>   }
>   
> @@ -255,12 +257,15 @@ static void *__meminit alloc_page_ext(size_t size, int nid)
>   	void *addr = NULL;
>   
>   	addr = alloc_pages_exact_nid(nid, size, flags);
> -	if (addr) {
> +	if (addr)
>   		kmemleak_alloc(addr, size, 1, flags);
> -		return addr;
> -	}
> +	else
> +		addr = vzalloc_node(size, nid);
>   
> -	addr = vzalloc_node(size, nid);
> +	if (addr) {
> +		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> +				    DIV_ROUND_UP(size, PAGE_SIZE));
> +	}
>   
>   	return addr;
>   }
> @@ -303,18 +308,27 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
>   
>   static void free_page_ext(void *addr)
>   {
> +	size_t table_size;
> +	struct page *page;
> +	struct pglist_data *pgdat;
> +
> +	table_size = page_ext_size * PAGES_PER_SECTION;
> +
>   	if (is_vmalloc_addr(addr)) {
> +		page = vmalloc_to_page(addr);
> +		pgdat = page_pgdat(page);
>   		vfree(addr);
>   	} else {
> -		struct page *page = virt_to_page(addr);
> -		size_t table_size;
> -
> -		table_size = page_ext_size * PAGES_PER_SECTION;
> -
> +		page = virt_to_page(addr);
> +		pgdat = page_pgdat(page);
>   		BUG_ON(PageReserved(page));
>   		kmemleak_free(addr);
>   		free_pages_exact(addr, table_size);
>   	}
> +
> +	__mod_node_page_state(pgdat, NR_PAGE_METADATA,
> +			      -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
> +
>   }
>   
>   static void __free_page_ext(unsigned long pfn)
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index a2cbe44c48e1..2bc67b2c2aa2 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -469,5 +469,8 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
>   	if (r < 0)
>   		return NULL;
>   
> +	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> +			      DIV_ROUND_UP(end - start, PAGE_SIZE));
> +
>   	return pfn_to_page(pfn);
>   }
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 77d91e565045..7f67b5486cd1 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -14,7 +14,7 @@
>   #include <linux/swap.h>
>   #include <linux/swapops.h>
>   #include <linux/bootmem_info.h>
> -
> +#include <linux/vmstat.h>
>   #include "internal.h"
>   #include <asm/dma.h>
>   
> @@ -465,6 +465,9 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>   	 */
>   	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
>   	sparsemap_buf_end = sparsemap_buf + size;
> +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> +	mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_SIZE));
> +#endif
>   }
>   
>   static void __init sparse_buffer_fini(void)
> @@ -641,6 +644,8 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
>   	unsigned long start = (unsigned long) pfn_to_page(pfn);
>   	unsigned long end = start + nr_pages * sizeof(struct page);
>   
> +	__mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_PAGE_METADATA,
> +			      -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
>   	vmemmap_free(start, end, altmap);
>   }
>   static void free_map_bootmem(struct page *memmap)
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 00e81e99c6ee..070d2b3d2bcc 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1245,6 +1245,7 @@ const char * const vmstat_text[] = {
>   	"pgpromote_success",
>   	"pgpromote_candidate",
>   #endif
> +	"nr_page_metadata",
>   
>   	/* enum writeback_stat_item counters */
>   	"nr_dirty_threshold",
> @@ -2274,4 +2275,27 @@ static int __init extfrag_debug_init(void)
>   }
>   
>   module_init(extfrag_debug_init);
> +
>   #endif
> +
> +/*
> + * Page metadata size (struct page and page_ext) in pages
> + */
> +static unsigned long early_perpage_metadata[MAX_NUMNODES] __initdata;
> +
> +void __init mod_node_early_perpage_metadata(int nid, long delta)
> +{
> +	early_perpage_metadata[nid] += delta;
> +}
> +
> +void __init store_early_perpage_metadata(void)
> +{
> +	int nid;
> +	struct pglist_data *pgdat;
> +
> +	for_each_online_pgdat(pgdat) {
> +		nid = pgdat->node_id;
> +		__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> +				      early_perpage_metadata[nid]);
> +	}
> +}



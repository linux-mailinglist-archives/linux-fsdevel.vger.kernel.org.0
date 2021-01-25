Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4273302091
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 03:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbhAYCuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 21:50:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11854 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbhAYCuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 21:50:04 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DPDmt4TMHz7ZW7;
        Mon, 25 Jan 2021 10:47:42 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 10:48:47 +0800
Subject: Re: [PATCH v13 01/12] mm: memory_hotplug: factor out bootmem core
 functions to bootmem_info.c
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <duanxiongchun@bytedance.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <corbet@lwn.net>,
        <mike.kravetz@oracle.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <viro@zeniv.linux.org.uk>,
        <akpm@linux-foundation.org>, <paulmck@kernel.org>,
        <mchehab+huawei@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
        <rdunlap@infradead.org>, <oneukum@suse.com>,
        <anshuman.khandual@arm.com>, <jroedel@suse.de>,
        <almasrymina@google.com>, <rientjes@google.com>,
        <willy@infradead.org>, <osalvador@suse.de>, <mhocko@suse.com>,
        <song.bao.hua@hisilicon.com>, <david@redhat.com>,
        <naoya.horiguchi@nec.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-2-songmuchun@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <20e72d65-0a97-4108-ac41-a65f04942d37@huawei.com>
Date:   Mon, 25 Jan 2021 10:48:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210117151053.24600-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi:
On 2021/1/17 23:10, Muchun Song wrote:
> Move bootmem info registration common API to individual bootmem_info.c.
> And we will use {get,put}_page_bootmem() to initialize the page for the
> vmemmap pages or free the vmemmap pages to buddy in the later patch.
> So move them out of CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code
> movement without any functional change.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/x86/mm/init_64.c          |   3 +-
>  include/linux/bootmem_info.h   |  40 +++++++++++++
>  include/linux/memory_hotplug.h |  27 ---------
>  mm/Makefile                    |   1 +
>  mm/bootmem_info.c              | 124 +++++++++++++++++++++++++++++++++++++++++
>  mm/memory_hotplug.c            | 116 --------------------------------------
>  mm/sparse.c                    |   1 +
>  7 files changed, 168 insertions(+), 144 deletions(-)
>  create mode 100644 include/linux/bootmem_info.h
>  create mode 100644 mm/bootmem_info.c
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index b5a3fa4033d3..0a45f062826e 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -33,6 +33,7 @@
>  #include <linux/nmi.h>
>  #include <linux/gfp.h>
>  #include <linux/kcore.h>
> +#include <linux/bootmem_info.h>
>  
>  #include <asm/processor.h>
>  #include <asm/bios_ebda.h>
> @@ -1571,7 +1572,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  	return err;
>  }
>  
> -#if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_HAVE_BOOTMEM_INFO_NODE)
> +#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
>  void register_page_bootmem_memmap(unsigned long section_nr,
>  				  struct page *start_page, unsigned long nr_pages)
>  {
> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> new file mode 100644
> index 000000000000..4ed6dee1adc9
> --- /dev/null
> +++ b/include/linux/bootmem_info.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_BOOTMEM_INFO_H
> +#define __LINUX_BOOTMEM_INFO_H
> +
> +#include <linux/mmzone.h>
> +
> +/*
> + * Types for free bootmem stored in page->lru.next. These have to be in
> + * some random range in unsigned long space for debugging purposes.
> + */
> +enum {
> +	MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE = 12,
> +	SECTION_INFO = MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE,
> +	MIX_SECTION_INFO,
> +	NODE_INFO,
> +	MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE = NODE_INFO,
> +};
> +
> +#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
> +void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
> +
> +void get_page_bootmem(unsigned long info, struct page *page,
> +		      unsigned long type);
> +void put_page_bootmem(struct page *page);
> +#else
> +static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
> +{
> +}
> +
> +static inline void put_page_bootmem(struct page *page)
> +{
> +}
> +
> +static inline void get_page_bootmem(unsigned long info, struct page *page,
> +				    unsigned long type)
> +{
> +}
> +#endif
> +
> +#endif /* __LINUX_BOOTMEM_INFO_H */
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 15acce5ab106..84590964ad35 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -33,18 +33,6 @@ struct vmem_altmap;
>  	___page;						   \
>  })
>  
> -/*
> - * Types for free bootmem stored in page->lru.next. These have to be in
> - * some random range in unsigned long space for debugging purposes.
> - */
> -enum {
> -	MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE = 12,
> -	SECTION_INFO = MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE,
> -	MIX_SECTION_INFO,
> -	NODE_INFO,
> -	MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE = NODE_INFO,
> -};
> -
>  /* Types for control the zone type of onlined and offlined memory */
>  enum {
>  	/* Offline the memory. */
> @@ -222,17 +210,6 @@ static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
>  #endif /* CONFIG_NUMA */
>  #endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
>  
> -#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
> -extern void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
> -#else
> -static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
> -{
> -}
> -#endif
> -extern void put_page_bootmem(struct page *page);
> -extern void get_page_bootmem(unsigned long ingo, struct page *page,
> -			     unsigned long type);
> -
>  void get_online_mems(void);
>  void put_online_mems(void);
>  
> @@ -260,10 +237,6 @@ static inline void zone_span_writelock(struct zone *zone) {}
>  static inline void zone_span_writeunlock(struct zone *zone) {}
>  static inline void zone_seqlock_init(struct zone *zone) {}
>  
> -static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
> -{
> -}
> -
>  static inline int try_online_node(int nid)
>  {
>  	return 0;
> diff --git a/mm/Makefile b/mm/Makefile
> index a1af02ba8f3f..ed4b88fa0f5e 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_SLUB) += slub.o
>  obj-$(CONFIG_KASAN)	+= kasan/
>  obj-$(CONFIG_KFENCE) += kfence/
>  obj-$(CONFIG_FAILSLAB) += failslab.o
> +obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
>  obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
>  obj-$(CONFIG_MEMTEST)		+= memtest.o
>  obj-$(CONFIG_MIGRATION) += migrate.o
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> new file mode 100644
> index 000000000000..fcab5a3f8cc0
> --- /dev/null
> +++ b/mm/bootmem_info.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  linux/mm/bootmem_info.c
> + *
> + *  Copyright (C)
> + */
> +#include <linux/mm.h>
> +#include <linux/compiler.h>
> +#include <linux/memblock.h>
> +#include <linux/bootmem_info.h>
> +#include <linux/memory_hotplug.h>
> +
> +void get_page_bootmem(unsigned long info, struct page *page, unsigned long type)
> +{
> +	page->freelist = (void *)type;
> +	SetPagePrivate(page);
> +	set_page_private(page, info);
> +	page_ref_inc(page);
> +}
> +
> +void put_page_bootmem(struct page *page)
> +{
> +	unsigned long type;
> +
> +	type = (unsigned long) page->freelist;
> +	BUG_ON(type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
> +	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
> +
> +	if (page_ref_dec_return(page) == 1) {
> +		page->freelist = NULL;
> +		ClearPagePrivate(page);
> +		set_page_private(page, 0);
> +		INIT_LIST_HEAD(&page->lru);
> +		free_reserved_page(page);
> +	}
> +}
> +
> +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> +static void register_page_bootmem_info_section(unsigned long start_pfn)
> +{
> +	unsigned long mapsize, section_nr, i;
> +	struct mem_section *ms;
> +	struct page *page, *memmap;
> +	struct mem_section_usage *usage;
> +
> +	section_nr = pfn_to_section_nr(start_pfn);
> +	ms = __nr_to_section(section_nr);
> +
> +	/* Get section's memmap address */
> +	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> +
> +	/*
> +	 * Get page for the memmap's phys address
> +	 * XXX: need more consideration for sparse_vmemmap...
> +	 */
> +	page = virt_to_page(memmap);
> +	mapsize = sizeof(struct page) * PAGES_PER_SECTION;
> +	mapsize = PAGE_ALIGN(mapsize) >> PAGE_SHIFT;
> +
> +	/* remember memmap's page */
> +	for (i = 0; i < mapsize; i++, page++)
> +		get_page_bootmem(section_nr, page, SECTION_INFO);
> +
> +	usage = ms->usage;
> +	page = virt_to_page(usage);
> +
> +	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
> +
> +	for (i = 0; i < mapsize; i++, page++)
> +		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
> +
> +}
> +#else /* CONFIG_SPARSEMEM_VMEMMAP */
> +static void register_page_bootmem_info_section(unsigned long start_pfn)
> +{
> +	unsigned long mapsize, section_nr, i;
> +	struct mem_section *ms;
> +	struct page *page, *memmap;
> +	struct mem_section_usage *usage;
> +
> +	section_nr = pfn_to_section_nr(start_pfn);
> +	ms = __nr_to_section(section_nr);
> +
> +	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> +
> +	register_page_bootmem_memmap(section_nr, memmap, PAGES_PER_SECTION);
> +
> +	usage = ms->usage;
> +	page = virt_to_page(usage);
> +
> +	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
> +
> +	for (i = 0; i < mapsize; i++, page++)
> +		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
> +}
> +#endif /* !CONFIG_SPARSEMEM_VMEMMAP */
> +
> +void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
> +{
> +	unsigned long i, pfn, end_pfn, nr_pages;
> +	int node = pgdat->node_id;
> +	struct page *page;
> +
> +	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
> +	page = virt_to_page(pgdat);
> +
> +	for (i = 0; i < nr_pages; i++, page++)
> +		get_page_bootmem(node, page, NODE_INFO);
> +
> +	pfn = pgdat->node_start_pfn;
> +	end_pfn = pgdat_end_pfn(pgdat);
> +
> +	/* register section info */
> +	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> +		/*
> +		 * Some platforms can assign the same pfn to multiple nodes - on
> +		 * node0 as well as nodeN.  To avoid registering a pfn against
> +		 * multiple nodes we check that this pfn does not already
> +		 * reside in some other nodes.
> +		 */
> +		if (pfn_valid(pfn) && (early_pfn_to_nid(pfn) == node))
> +			register_page_bootmem_info_section(pfn);
> +	}
> +}
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index a8cef4955907..4c4ca99745b7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -141,122 +141,6 @@ static void release_memory_resource(struct resource *res)
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> -void get_page_bootmem(unsigned long info,  struct page *page,
> -		      unsigned long type)
> -{
> -	page->freelist = (void *)type;
> -	SetPagePrivate(page);
> -	set_page_private(page, info);
> -	page_ref_inc(page);
> -}
> -
> -void put_page_bootmem(struct page *page)
> -{
> -	unsigned long type;
> -
> -	type = (unsigned long) page->freelist;
> -	BUG_ON(type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
> -	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
> -
> -	if (page_ref_dec_return(page) == 1) {
> -		page->freelist = NULL;
> -		ClearPagePrivate(page);
> -		set_page_private(page, 0);
> -		INIT_LIST_HEAD(&page->lru);
> -		free_reserved_page(page);
> -	}
> -}
> -
> -#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
> -#ifndef CONFIG_SPARSEMEM_VMEMMAP
> -static void register_page_bootmem_info_section(unsigned long start_pfn)
> -{
> -	unsigned long mapsize, section_nr, i;
> -	struct mem_section *ms;
> -	struct page *page, *memmap;
> -	struct mem_section_usage *usage;
> -
> -	section_nr = pfn_to_section_nr(start_pfn);
> -	ms = __nr_to_section(section_nr);
> -
> -	/* Get section's memmap address */
> -	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> -
> -	/*
> -	 * Get page for the memmap's phys address
> -	 * XXX: need more consideration for sparse_vmemmap...
> -	 */
> -	page = virt_to_page(memmap);
> -	mapsize = sizeof(struct page) * PAGES_PER_SECTION;
> -	mapsize = PAGE_ALIGN(mapsize) >> PAGE_SHIFT;
> -
> -	/* remember memmap's page */
> -	for (i = 0; i < mapsize; i++, page++)
> -		get_page_bootmem(section_nr, page, SECTION_INFO);
> -
> -	usage = ms->usage;
> -	page = virt_to_page(usage);
> -
> -	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
> -
> -	for (i = 0; i < mapsize; i++, page++)
> -		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
> -
> -}
> -#else /* CONFIG_SPARSEMEM_VMEMMAP */
> -static void register_page_bootmem_info_section(unsigned long start_pfn)
> -{
> -	unsigned long mapsize, section_nr, i;
> -	struct mem_section *ms;
> -	struct page *page, *memmap;
> -	struct mem_section_usage *usage;
> -
> -	section_nr = pfn_to_section_nr(start_pfn);
> -	ms = __nr_to_section(section_nr);
> -
> -	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> -
> -	register_page_bootmem_memmap(section_nr, memmap, PAGES_PER_SECTION);
> -
> -	usage = ms->usage;
> -	page = virt_to_page(usage);
> -
> -	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
> -
> -	for (i = 0; i < mapsize; i++, page++)
> -		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
> -}
> -#endif /* !CONFIG_SPARSEMEM_VMEMMAP */
> -
> -void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
> -{
> -	unsigned long i, pfn, end_pfn, nr_pages;
> -	int node = pgdat->node_id;
> -	struct page *page;
> -
> -	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
> -	page = virt_to_page(pgdat);
> -
> -	for (i = 0; i < nr_pages; i++, page++)
> -		get_page_bootmem(node, page, NODE_INFO);
> -
> -	pfn = pgdat->node_start_pfn;
> -	end_pfn = pgdat_end_pfn(pgdat);
> -
> -	/* register section info */
> -	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> -		/*
> -		 * Some platforms can assign the same pfn to multiple nodes - on
> -		 * node0 as well as nodeN.  To avoid registering a pfn against
> -		 * multiple nodes we check that this pfn does not already
> -		 * reside in some other nodes.
> -		 */
> -		if (pfn_valid(pfn) && (early_pfn_to_nid(pfn) == node))
> -			register_page_bootmem_info_section(pfn);
> -	}
> -}
> -#endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
> -
>  static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>  		const char *reason)
>  {
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7bd23f9d6cef..87676bf3af40 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
> +#include <linux/bootmem_info.h>
>  
>  #include "internal.h"
>  #include <asm/dma.h>
> 

Huge but straightforward change. This patchset would do a big deal.
Looks good to me. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>


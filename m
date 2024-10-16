Return-Path: <linux-fsdevel+bounces-32119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF89A0CE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 16:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B05E1F21FAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C4920C014;
	Wed, 16 Oct 2024 14:38:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766CD156225;
	Wed, 16 Oct 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089487; cv=none; b=OzAhOgHaHhqvYKAREi57V5o1gNk/Tdl6fV9qIJVStM9pl/G6Hhzam4t5J49Rreuoft/uI0ErMIHRK8vQvB+DQBh0icbLzn8sabsAIPEL3xHVmZqYx25sqBkug0dYdpW9XBKrhfGOt/HPBPvqAVo3y+DGogvcMrHF0skBZXPy3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089487; c=relaxed/simple;
	bh=wE+Tk0teM1O/8JvtpEGGB5Mc/ioX6WvBEmyunfQU9us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SV00xRumKCDZnkWqgm4fl7DRFjjPh33Lg9/KiQL54OdYrEYgNEtEJ4gw/XRvRE1iOpoG3Pk0yMw+eshDH4EjABXq5m0NdVOESCbR7oTdfit+xt4FgDdLi6ttOuw5MzdQqXu0eoIjRBu3O2+H5pCJ5uXTN1/BEg/g4nztrlYFlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9160BFEC;
	Wed, 16 Oct 2024 07:38:34 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77FA33F71E;
	Wed, 16 Oct 2024 07:37:59 -0700 (PDT)
Message-ID: <18546e4a-81c7-41f4-b07f-2e6501a936b8@arm.com>
Date: Wed, 16 Oct 2024 15:37:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 06/57] mm: Remove PAGE_SIZE compile-time constant
 assumption
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Lameter <cl@linux.com>, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Michal Hocko <mhocko@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Miroslav Benes <mbenes@suse.cz>, Pekka Enberg <penberg@kernel.org>,
 Richard Weinberger <richard@nod.at>, Shakeel Butt <shakeel.butt@linux.dev>,
 Vignesh Raghavendra <vigneshr@ti.com>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-6-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Matthew Wilcox

This was a rather tricky series to get the recipients correct for and my script
did not realize that "supporter" was a pseudonym for "maintainer" so you were
missed off the original post. Appologies!

More context in cover letter:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/


On 14/10/2024 11:58, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Refactor "struct vmap_block" to use a flexible array for used_mmap since
> VMAP_BBMAP_BITS is not a compile time constant for the boot-time page
> size case.
> 
> Update various BUILD_BUG_ON() instances to check against appropriate
> page size limit.
> 
> Re-define "union swap_header" so that it's no longer exactly page-sized.
> Instead define a flexible "magic" array with a define which tells the
> offset to where the magic signature begins.
> 
> Consider page size limit in some CPP condditionals.
> 
> Wrap global variables that are initialized with PAGE_SIZE derived values
> using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
> deferred for boot-time page size builds.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  drivers/mtd/mtdswap.c         |  4 ++--
>  include/linux/mm.h            |  2 +-
>  include/linux/mm_types_task.h |  2 +-
>  include/linux/mmzone.h        |  3 ++-
>  include/linux/slab.h          |  7 ++++---
>  include/linux/swap.h          | 17 ++++++++++++-----
>  include/linux/swapops.h       |  6 +++++-
>  mm/memcontrol.c               |  2 +-
>  mm/memory.c                   |  4 ++--
>  mm/mmap.c                     |  2 +-
>  mm/page-writeback.c           |  2 +-
>  mm/slub.c                     |  2 +-
>  mm/sparse.c                   |  2 +-
>  mm/swapfile.c                 |  2 +-
>  mm/vmalloc.c                  |  7 ++++---
>  15 files changed, 39 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
> index 680366616da24..7412a32708114 100644
> --- a/drivers/mtd/mtdswap.c
> +++ b/drivers/mtd/mtdswap.c
> @@ -1062,13 +1062,13 @@ static int mtdswap_auto_header(struct mtdswap_dev *d, char *buf)
>  {
>  	union swap_header *hd = (union swap_header *)(buf);
>  
> -	memset(buf, 0, PAGE_SIZE - 10);
> +	memset(buf, 0, SWAP_HEADER_MAGIC);
>  
>  	hd->info.version = 1;
>  	hd->info.last_page = d->mbd_dev->size - 1;
>  	hd->info.nr_badpages = 0;
>  
> -	memcpy(buf + PAGE_SIZE - 10, "SWAPSPACE2", 10);
> +	memcpy(buf + SWAP_HEADER_MAGIC, "SWAPSPACE2", 10);
>  
>  	return 0;
>  }
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 09a840517c23a..49c2078354e6e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2927,7 +2927,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
>  {
>  	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
> -	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
> +	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE_MAX);
>  	return ptlock_ptr(virt_to_ptdesc(pte));
>  }
>  
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
> index a2f6179b672b8..c356897d5f41c 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -37,7 +37,7 @@ struct page;
>  
>  struct page_frag {
>  	struct page *page;
> -#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
> +#if (BITS_PER_LONG > 32) || (PAGE_SIZE_MAX >= 65536)
>  	__u32 offset;
>  	__u32 size;
>  #else
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 1dc6248feb832..cd58034b82c81 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1744,6 +1744,7 @@ static inline bool movable_only_nodes(nodemask_t *nodes)
>   */
>  #define PA_SECTION_SHIFT	(SECTION_SIZE_BITS)
>  #define PFN_SECTION_SHIFT	(SECTION_SIZE_BITS - PAGE_SHIFT)
> +#define PFN_SECTION_SHIFT_MIN	(SECTION_SIZE_BITS - PAGE_SHIFT_MAX)
>  
>  #define NR_MEM_SECTIONS		(1UL << SECTIONS_SHIFT)
>  
> @@ -1753,7 +1754,7 @@ static inline bool movable_only_nodes(nodemask_t *nodes)
>  #define SECTION_BLOCKFLAGS_BITS \
>  	((1UL << (PFN_SECTION_SHIFT - pageblock_order)) * NR_PAGEBLOCK_BITS)
>  
> -#if (MAX_PAGE_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
> +#if (MAX_PAGE_ORDER + PAGE_SHIFT_MAX) > SECTION_SIZE_BITS
>  #error Allocator MAX_PAGE_ORDER exceeds SECTION_SIZE
>  #endif
>  
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index eb2bf46291576..11c6ff3a12579 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -347,7 +347,7 @@ static inline unsigned int arch_slab_minalign(void)
>   */
>  #define __assume_kmalloc_alignment __assume_aligned(ARCH_KMALLOC_MINALIGN)
>  #define __assume_slab_alignment __assume_aligned(ARCH_SLAB_MINALIGN)
> -#define __assume_page_alignment __assume_aligned(PAGE_SIZE)
> +#define __assume_page_alignment __assume_aligned(PAGE_SIZE_MIN)
>  
>  /*
>   * Kmalloc array related definitions
> @@ -358,6 +358,7 @@ static inline unsigned int arch_slab_minalign(void)
>   * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
>   */
>  #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> +#define KMALLOC_SHIFT_HIGH_MAX	(PAGE_SHIFT_MAX + 1)
>  #define KMALLOC_SHIFT_MAX	(MAX_PAGE_ORDER + PAGE_SHIFT)
>  #ifndef KMALLOC_SHIFT_LOW
>  #define KMALLOC_SHIFT_LOW	3
> @@ -426,7 +427,7 @@ enum kmalloc_cache_type {
>  	NR_KMALLOC_TYPES
>  };
>  
> -typedef struct kmem_cache * kmem_buckets[KMALLOC_SHIFT_HIGH + 1];
> +typedef struct kmem_cache * kmem_buckets[KMALLOC_SHIFT_HIGH_MAX + 1];
>  
>  extern kmem_buckets kmalloc_caches[NR_KMALLOC_TYPES];
>  
> @@ -524,7 +525,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>  	/* Will never be reached. Needed because the compiler may complain */
>  	return -1;
>  }
> -static_assert(PAGE_SHIFT <= 20);
> +static_assert(PAGE_SHIFT_MAX <= 20);
>  #define kmalloc_index(s) __kmalloc_index(s, true)
>  
>  #include <linux/alloc_tag.h>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index ba7ea95d1c57a..e85df0332979f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -132,10 +132,17 @@ static inline int current_is_kswapd(void)
>   * bootbits...
>   */
>  union swap_header {
> -	struct {
> -		char reserved[PAGE_SIZE - 10];
> -		char magic[10];			/* SWAP-SPACE or SWAPSPACE2 */
> -	} magic;
> +	/*
> +	 * Exists conceptually, but since PAGE_SIZE may not be known at compile
> +	 * time, we must access through pointer arithmetic at run time.
> +	 *
> +	 * struct {
> +	 * 	char reserved[PAGE_SIZE - 10];
> +	 * 	char magic[10];			   SWAP-SPACE or SWAPSPACE2
> +	 * } magic;
> +	 */
> +#define SWAP_HEADER_MAGIC	(PAGE_SIZE - 10)
> +	char magic[1];
>  	struct {
>  		char		bootbits[1024];	/* Space for disklabel etc. */
>  		__u32		version;
> @@ -201,7 +208,7 @@ struct swap_extent {
>   * Max bad pages in the new format..
>   */
>  #define MAX_SWAP_BADPAGES \
> -	((offsetof(union swap_header, magic.magic) - \
> +	((SWAP_HEADER_MAGIC - \
>  	  offsetof(union swap_header, info.badpages)) / sizeof(int))
>  
>  enum {
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index cb468e418ea11..890fe6a3e6702 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -34,10 +34,14 @@
>   */
>  #ifdef MAX_PHYSMEM_BITS
>  #define SWP_PFN_BITS		(MAX_PHYSMEM_BITS - PAGE_SHIFT)
> +#define SWP_PFN_BITS_MAX	(MAX_PHYSMEM_BITS - PAGE_SHIFT_MIN)
>  #else  /* MAX_PHYSMEM_BITS */
>  #define SWP_PFN_BITS		min_t(int, \
>  				      sizeof(phys_addr_t) * 8 - PAGE_SHIFT, \
>  				      SWP_TYPE_SHIFT)
> +#define SWP_PFN_BITS_MAX	min_t(int, \
> +				      sizeof(phys_addr_t) * 8 - PAGE_SHIFT_MIN, \
> +				      SWP_TYPE_SHIFT)
>  #endif	/* MAX_PHYSMEM_BITS */
>  #define SWP_PFN_MASK		(BIT(SWP_PFN_BITS) - 1)
>  
> @@ -519,7 +523,7 @@ static inline struct folio *pfn_swap_entry_folio(swp_entry_t entry)
>  static inline bool is_pfn_swap_entry(swp_entry_t entry)
>  {
>  	/* Make sure the swp offset can always store the needed fields */
> -	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
> +	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS_MAX);
>  
>  	return is_migration_entry(entry) || is_device_private_entry(entry) ||
>  	       is_device_exclusive_entry(entry) || is_hwpoison_entry(entry);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c5f9195f76c65..4b17bec566fbd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4881,7 +4881,7 @@ static int __init mem_cgroup_init(void)
>  	 * to work fine, we should make sure that the overfill threshold can't
>  	 * exceed S32_MAX / PAGE_SIZE.
>  	 */
> -	BUILD_BUG_ON(MEMCG_CHARGE_BATCH > S32_MAX / PAGE_SIZE);
> +	BUILD_BUG_ON(MEMCG_CHARGE_BATCH > S32_MAX / PAGE_SIZE_MIN);
>  
>  	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
>  				  memcg_hotplug_cpu_dead);
> diff --git a/mm/memory.c b/mm/memory.c
> index ebfc9768f801a..14b5ef6870486 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4949,8 +4949,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> -static unsigned long fault_around_pages __read_mostly =
> -	65536 >> PAGE_SHIFT;
> +static __DEFINE_GLOBAL_PAGE_SIZE_VAR(unsigned long, fault_around_pages,
> +				     __read_mostly, 65536 >> PAGE_SHIFT);
>  
>  #ifdef CONFIG_DEBUG_FS
>  static int fault_around_bytes_get(void *data, u64 *val)
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0dfc85b209bb..d9642aba07ac4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2279,7 +2279,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  }
>  
>  /* enforced gap between the expanding stack and other mappings. */
> -unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
> +DEFINE_GLOBAL_PAGE_SIZE_VAR(unsigned long, stack_guard_gap, 256UL<<PAGE_SHIFT);
>  
>  static int __init cmdline_parse_stack_guard_gap(char *p)
>  {
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 4430ac68e4c41..8fc9ac50749bd 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2292,7 +2292,7 @@ static int page_writeback_cpu_online(unsigned int cpu)
>  #ifdef CONFIG_SYSCTL
>  
>  /* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
> -static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
> +static DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(unsigned long, dirty_bytes_min, 2 * PAGE_SIZE);
>  
>  static struct ctl_table vm_page_writeback_sysctls[] = {
>  	{
> diff --git a/mm/slub.c b/mm/slub.c
> index a77f354f83251..82f6e98cf25bb 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5001,7 +5001,7 @@ init_kmem_cache_node(struct kmem_cache_node *n)
>  static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
>  {
>  	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
> -			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
> +			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH_MAX *
>  			sizeof(struct kmem_cache_cpu));
>  
>  	/*
> diff --git a/mm/sparse.c b/mm/sparse.c
> index dc38539f85603..2491425930c4d 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -277,7 +277,7 @@ static unsigned long sparse_encode_mem_map(struct page *mem_map, unsigned long p
>  {
>  	unsigned long coded_mem_map =
>  		(unsigned long)(mem_map - (section_nr_to_pfn(pnum)));
> -	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
> +	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT_MIN);
>  	BUG_ON(coded_mem_map & ~SECTION_MAP_MASK);
>  	return coded_mem_map;
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 38bdc439651ac..6311a1cc7e46b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2931,7 +2931,7 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
>  	unsigned long swapfilepages;
>  	unsigned long last_page;
>  
> -	if (memcmp("SWAPSPACE2", swap_header->magic.magic, 10)) {
> +	if (memcmp("SWAPSPACE2", &swap_header->magic[SWAP_HEADER_MAGIC], 10)) {
>  		pr_err("Unable to find swap-space signature\n");
>  		return 0;
>  	}
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a0df1e2e155a8..b4fbba204603c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2497,12 +2497,12 @@ struct vmap_block {
>  	spinlock_t lock;
>  	struct vmap_area *va;
>  	unsigned long free, dirty;
> -	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
>  	unsigned long dirty_min, dirty_max; /*< dirty range */
>  	struct list_head free_list;
>  	struct rcu_head rcu_head;
>  	struct list_head purge;
>  	unsigned int cpu;
> +	unsigned long used_map[];
>  };
>  
>  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> @@ -2600,11 +2600,12 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	unsigned long vb_idx;
>  	int node, err;
>  	void *vaddr;
> +	size_t size;
>  
>  	node = numa_node_id();
>  
> -	vb = kmalloc_node(sizeof(struct vmap_block),
> -			gfp_mask & GFP_RECLAIM_MASK, node);
> +	size = struct_size(vb, used_map, BITS_TO_LONGS(VMAP_BBMAP_BITS));
> +	vb = kmalloc_node(size, gfp_mask & GFP_RECLAIM_MASK, node);
>  	if (unlikely(!vb))
>  		return ERR_PTR(-ENOMEM);
>  



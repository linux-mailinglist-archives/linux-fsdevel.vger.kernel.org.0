Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFFF6FA0C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 09:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjEHHOP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 03:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHHOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 03:14:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688951AEEA;
        Mon,  8 May 2023 00:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683530030; x=1715066030;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=RoOthzliZsr3LKOZyuzYp5kyWs7Vrsjx6KCun+y22zw=;
  b=G+oFRIYip8JS+qeZSod05+V1+svlgBYRKhT02qQjZMuHNvpLzC8hgRPr
   dBibw+yl18b/dUZVMsiYX31Gf0JXCchUQNCwrGE4omDqPsiJRSCR6MRMz
   Bp/4Bxxy1E9yiQeFOg6ZbuIFbN+d3XfaC/QEF+OwPJziEVY/qEtZAky6C
   0TNjFhgY1DdwuYRgbOeDjqLHt5IenrIUsGFQvSN5pRslzV8DK+boqo0XC
   BVDgfMBMgRoLroqKC2R9yua5Xy/zVu1pE+eQY6EeuXstcPkyGjkMVJYiZ
   e1nBlf3vOgYnTQ85GiwJJHnoJAF3b7lyno+c5BVgAxtnY/aToFOzg9s6Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329937467"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329937467"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 00:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="698419425"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="698419425"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 00:13:13 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/12] mm: page_alloc: move set_zone_contiguous() into
 mm_init.c
References: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
        <20230508071200.123962-4-wangkefeng.wang@huawei.com>
Date:   Mon, 08 May 2023 15:12:08 +0800
In-Reply-To: <20230508071200.123962-4-wangkefeng.wang@huawei.com> (Kefeng
        Wang's message of "Mon, 8 May 2023 15:11:51 +0800")
Message-ID: <87jzxj9u0n.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

> set_zone_contiguous() is only used in mm init/hotplug, and
> clear_zone_contiguous() only used in hotplug, move them from
> page_alloc.c to the more appropriate file.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/memory_hotplug.h |  3 --
>  mm/internal.h                  |  7 +++
>  mm/mm_init.c                   | 74 +++++++++++++++++++++++++++++++
>  mm/page_alloc.c                | 79 ----------------------------------
>  4 files changed, 81 insertions(+), 82 deletions(-)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 9fcbf5706595..04bc286eed42 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -326,9 +326,6 @@ static inline int remove_memory(u64 start, u64 size)
>  static inline void __remove_memory(u64 start, u64 size) {}
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
> -extern void set_zone_contiguous(struct zone *zone);
> -extern void clear_zone_contiguous(struct zone *zone);
> -
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
>  extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
> diff --git a/mm/internal.h b/mm/internal.h
> index e28442c0858a..9482862b28cc 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -371,6 +371,13 @@ static inline struct page *pageblock_pfn_to_page(unsigned long start_pfn,
>  	return __pageblock_pfn_to_page(start_pfn, end_pfn, zone);
>  }
>  
> +void set_zone_contiguous(struct zone *zone);
> +
> +static inline void clear_zone_contiguous(struct zone *zone)
> +{
> +	zone->contiguous = false;
> +}
> +
>  extern int __isolate_free_page(struct page *page, unsigned int order);
>  extern void __putback_isolated_page(struct page *page, unsigned int order,
>  				    int mt);
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 15201887f8e0..1f30b9e16577 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2330,6 +2330,80 @@ void __init init_cma_reserved_pageblock(struct page *page)
>  }
>  #endif
>  
> +/*
> + * Check that the whole (or subset of) a pageblock given by the interval of
> + * [start_pfn, end_pfn) is valid and within the same zone, before scanning it
> + * with the migration of free compaction scanner.
> + *
> + * Return struct page pointer of start_pfn, or NULL if checks were not passed.
> + *
> + * It's possible on some configurations to have a setup like node0 node1 node0
> + * i.e. it's possible that all pages within a zones range of pages do not
> + * belong to a single zone. We assume that a border between node0 and node1
> + * can occur within a single pageblock, but not a node0 node1 node0
> + * interleaving within a single pageblock. It is therefore sufficient to check
> + * the first and last page of a pageblock and avoid checking each individual
> + * page in a pageblock.
> + *
> + * Note: the function may return non-NULL struct page even for a page block
> + * which contains a memory hole (i.e. there is no physical memory for a subset
> + * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
> + * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
> + * even though the start pfn is online and valid. This should be safe most of
> + * the time because struct pages are still initialized via init_unavailable_range()
> + * and pfn walkers shouldn't touch any physical memory range for which they do
> + * not recognize any specific metadata in struct pages.
> + */
> +struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
> +				     unsigned long end_pfn, struct zone *zone)

__pageblock_pfn_to_page() is also called by compaction code too (e.g.,
isolate_freepages_range() -> pageblock_pfn_to_page() ->
__pageblock_pfn_to_page()).

So, it is used not only by initialization and hotplug?

Best Regards,
Huang, Ying

> +{
> +	struct page *start_page;
> +	struct page *end_page;
> +
> +	/* end_pfn is one past the range we are checking */
> +	end_pfn--;
> +
> +	if (!pfn_valid(end_pfn))
> +		return NULL;
> +
> +	start_page = pfn_to_online_page(start_pfn);
> +	if (!start_page)
> +		return NULL;
> +
> +	if (page_zone(start_page) != zone)
> +		return NULL;
> +
> +	end_page = pfn_to_page(end_pfn);
> +
> +	/* This gives a shorter code than deriving page_zone(end_page) */
> +	if (page_zone_id(start_page) != page_zone_id(end_page))
> +		return NULL;
> +
> +	return start_page;
> +}
> +
> +void set_zone_contiguous(struct zone *zone)
> +{
> +	unsigned long block_start_pfn = zone->zone_start_pfn;
> +	unsigned long block_end_pfn;
> +
> +	block_end_pfn = pageblock_end_pfn(block_start_pfn);
> +	for (; block_start_pfn < zone_end_pfn(zone);
> +			block_start_pfn = block_end_pfn,
> +			 block_end_pfn += pageblock_nr_pages) {
> +
> +		block_end_pfn = min(block_end_pfn, zone_end_pfn(zone));
> +
> +		if (!__pageblock_pfn_to_page(block_start_pfn,
> +					     block_end_pfn, zone))
> +			return;
> +		cond_resched();
> +	}
> +
> +	/* We confirm that there is no hole */
> +	zone->contiguous = true;
> +}
> +
>  void __init page_alloc_init_late(void)
>  {
>  	struct zone *zone;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4f094ba7c8fb..fe7c1ee5becd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1480,85 +1480,6 @@ void __free_pages_core(struct page *page, unsigned int order)
>  	__free_pages_ok(page, order, FPI_TO_TAIL);
>  }
>  
> -/*
> - * Check that the whole (or subset of) a pageblock given by the interval of
> - * [start_pfn, end_pfn) is valid and within the same zone, before scanning it
> - * with the migration of free compaction scanner.
> - *
> - * Return struct page pointer of start_pfn, or NULL if checks were not passed.
> - *
> - * It's possible on some configurations to have a setup like node0 node1 node0
> - * i.e. it's possible that all pages within a zones range of pages do not
> - * belong to a single zone. We assume that a border between node0 and node1
> - * can occur within a single pageblock, but not a node0 node1 node0
> - * interleaving within a single pageblock. It is therefore sufficient to check
> - * the first and last page of a pageblock and avoid checking each individual
> - * page in a pageblock.
> - *
> - * Note: the function may return non-NULL struct page even for a page block
> - * which contains a memory hole (i.e. there is no physical memory for a subset
> - * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
> - * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
> - * even though the start pfn is online and valid. This should be safe most of
> - * the time because struct pages are still initialized via init_unavailable_range()
> - * and pfn walkers shouldn't touch any physical memory range for which they do
> - * not recognize any specific metadata in struct pages.
> - */
> -struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
> -				     unsigned long end_pfn, struct zone *zone)
> -{
> -	struct page *start_page;
> -	struct page *end_page;
> -
> -	/* end_pfn is one past the range we are checking */
> -	end_pfn--;
> -
> -	if (!pfn_valid(end_pfn))
> -		return NULL;
> -
> -	start_page = pfn_to_online_page(start_pfn);
> -	if (!start_page)
> -		return NULL;
> -
> -	if (page_zone(start_page) != zone)
> -		return NULL;
> -
> -	end_page = pfn_to_page(end_pfn);
> -
> -	/* This gives a shorter code than deriving page_zone(end_page) */
> -	if (page_zone_id(start_page) != page_zone_id(end_page))
> -		return NULL;
> -
> -	return start_page;
> -}
> -
> -void set_zone_contiguous(struct zone *zone)
> -{
> -	unsigned long block_start_pfn = zone->zone_start_pfn;
> -	unsigned long block_end_pfn;
> -
> -	block_end_pfn = pageblock_end_pfn(block_start_pfn);
> -	for (; block_start_pfn < zone_end_pfn(zone);
> -			block_start_pfn = block_end_pfn,
> -			 block_end_pfn += pageblock_nr_pages) {
> -
> -		block_end_pfn = min(block_end_pfn, zone_end_pfn(zone));
> -
> -		if (!__pageblock_pfn_to_page(block_start_pfn,
> -					     block_end_pfn, zone))
> -			return;
> -		cond_resched();
> -	}
> -
> -	/* We confirm that there is no hole */
> -	zone->contiguous = true;
> -}
> -
> -void clear_zone_contiguous(struct zone *zone)
> -{
> -	zone->contiguous = false;
> -}
> -
>  /*
>   * The order of subdivision here is critical for the IO subsystem.
>   * Please do not alter this order without good reasons and regression

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056BE2DAE05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 14:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgLONbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 08:31:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:42888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgLONb0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:31:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608039039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3XPa6B5Agc5X6gtCtpcj1Z+hTlPDBybjc3CU9O9vvm8=;
        b=lwTzTrU4ZpC9WAg1Lcxkfq6ExedXTJyBvr3P+BNvrZTJMYbNYj15XQHLVfMroQosvrZ4mr
        fvFXk7otxv0Q/1eEnx3sQmIHMMBgLHwpNq0mUHe5mQfYL7zi6AqG9keKKuL5R9rcMaOTam
        T+c6FIrXI3rjbfewiF6OnCYKHHoY8vo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52CBBAD64;
        Tue, 15 Dec 2020 13:30:39 +0000 (UTC)
Date:   Tue, 15 Dec 2020 14:30:38 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/7] mm: memcontrol: convert NR_ANON_THPS account to
 pages
Message-ID: <20201215133038.GO32193@dhcp22.suse.cz>
References: <20201208041847.72122-1-songmuchun@bytedance.com>
 <20201208041847.72122-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208041847.72122-3-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-12-20 12:18:42, Muchun Song wrote:
> The unit of NR_ANON_THPS is HPAGE_PMD_NR. Convert the NR_ANON_THPS
> account to pages.

This changelog could benefit from some improvements. First of all you
should be clear about the motivation. I believe the previous feedback
was also to explicitly mention what effect this has on the pcp
accounting flushing.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  drivers/base/node.c |  3 +--
>  fs/proc/meminfo.c   |  2 +-
>  mm/huge_memory.c    |  3 ++-
>  mm/memcontrol.c     | 20 ++++++--------------
>  mm/page_alloc.c     |  2 +-
>  mm/rmap.c           |  7 ++++---
>  6 files changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 04f71c7bc3f8..ec35cb567940 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -461,8 +461,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>  			     nid, K(sunreclaimable)
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  			     ,
> -			     nid, K(node_page_state(pgdat, NR_ANON_THPS) *
> -				    HPAGE_PMD_NR),
> +			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
>  			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
>  				    HPAGE_PMD_NR),
>  			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index d6fc74619625..a635c8a84ddf 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -129,7 +129,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	show_val_kb(m, "AnonHugePages:  ",
> -		    global_node_page_state(NR_ANON_THPS) * HPAGE_PMD_NR);
> +		    global_node_page_state(NR_ANON_THPS));
>  	show_val_kb(m, "ShmemHugePages: ",
>  		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
>  	show_val_kb(m, "ShmemPmdMapped: ",
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 10dd3cae5f53..66ec454120de 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2178,7 +2178,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		lock_page_memcg(page);
>  		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
>  			/* Last compound_mapcount is gone. */
> -			__dec_lruvec_page_state(page, NR_ANON_THPS);
> +			__mod_lruvec_page_state(page, NR_ANON_THPS,
> +						-HPAGE_PMD_NR);
>  			if (TestClearPageDoubleMap(page)) {
>  				/* No need in mapcount reference anymore */
>  				for (i = 0; i < HPAGE_PMD_NR; i++)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8818bf64d6fe..b18e25a5cdf3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1532,7 +1532,7 @@ static struct memory_stat memory_stats[] = {
>  	 * on some architectures, the macro of HPAGE_PMD_SIZE is not
>  	 * constant(e.g. powerpc).
>  	 */
> -	{ "anon_thp", 0, NR_ANON_THPS },
> +	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
>  	{ "file_thp", 0, NR_FILE_THPS },
>  	{ "shmem_thp", 0, NR_SHMEM_THPS },
>  #endif
> @@ -1565,8 +1565,7 @@ static int __init memory_stats_init(void)
>  
>  	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -		if (memory_stats[i].idx == NR_ANON_THPS ||
> -		    memory_stats[i].idx == NR_FILE_THPS ||
> +		if (memory_stats[i].idx == NR_FILE_THPS ||
>  		    memory_stats[i].idx == NR_SHMEM_THPS)
>  			memory_stats[i].ratio = HPAGE_PMD_SIZE;
>  #endif
> @@ -4088,10 +4087,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
>  			continue;
>  		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -		if (memcg1_stats[i] == NR_ANON_THPS)
> -			nr *= HPAGE_PMD_NR;
> -#endif
>  		seq_printf(m, "%s %lu\n", memcg1_stat_names[i], nr * PAGE_SIZE);
>  	}
>  
> @@ -4122,10 +4117,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
>  			continue;
>  		nr = memcg_page_state(memcg, memcg1_stats[i]);
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -		if (memcg1_stats[i] == NR_ANON_THPS)
> -			nr *= HPAGE_PMD_NR;
> -#endif
>  		seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
>  						(u64)nr * PAGE_SIZE);
>  	}
> @@ -5653,10 +5644,11 @@ static int mem_cgroup_move_account(struct page *page,
>  			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
>  			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
>  			if (PageTransHuge(page)) {
> -				__dec_lruvec_state(from_vec, NR_ANON_THPS);
> -				__inc_lruvec_state(to_vec, NR_ANON_THPS);
> +				__mod_lruvec_state(from_vec, NR_ANON_THPS,
> +						   -nr_pages);
> +				__mod_lruvec_state(to_vec, NR_ANON_THPS,
> +						   nr_pages);
>  			}
> -
>  		}
>  	} else {
>  		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 469e28f95ce7..1700f52b7869 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5580,7 +5580,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  			K(node_page_state(pgdat, NR_SHMEM_THPS) * HPAGE_PMD_NR),
>  			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
>  					* HPAGE_PMD_NR),
> -			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
> +			K(node_page_state(pgdat, NR_ANON_THPS)),
>  #endif
>  			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
>  			node_page_state(pgdat, NR_KERNEL_STACK_KB),
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 08c56aaf72eb..f59e92e26b61 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1144,7 +1144,8 @@ void do_page_add_anon_rmap(struct page *page,
>  		 * disabled.
>  		 */
>  		if (compound)
> -			__inc_lruvec_page_state(page, NR_ANON_THPS);
> +			__mod_lruvec_page_state(page, NR_ANON_THPS,
> +						HPAGE_PMD_NR);
>  		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
>  	}
>  
> @@ -1186,7 +1187,7 @@ void page_add_new_anon_rmap(struct page *page,
>  		if (hpage_pincount_available(page))
>  			atomic_set(compound_pincount_ptr(page), 0);
>  
> -		__inc_lruvec_page_state(page, NR_ANON_THPS);
> +		__mod_lruvec_page_state(page, NR_ANON_THPS, HPAGE_PMD_NR);
>  	} else {
>  		/* Anon THP always mapped first with PMD */
>  		VM_BUG_ON_PAGE(PageTransCompound(page), page);
> @@ -1292,7 +1293,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
>  	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>  		return;
>  
> -	__dec_lruvec_page_state(page, NR_ANON_THPS);
> +	__mod_lruvec_page_state(page, NR_ANON_THPS, -HPAGE_PMD_NR);
>  
>  	if (TestClearPageDoubleMap(page)) {
>  		/*
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs

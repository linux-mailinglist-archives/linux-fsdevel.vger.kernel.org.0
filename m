Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C823D0C09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhGUJG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237471AbhGUJE0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:04:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C31CE61181;
        Wed, 21 Jul 2021 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626860639;
        bh=D6dUEy2u2WAwK3Wav/+todv+3LklSEqNky2DVPOIV50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxyUmfBvxcIFV+vIpWm4eZHp7gLCPBwsfZvtGrgYZgCcxVP+wfTLKY5nlT8DSAVSx
         gd9kIeu9gVFcsX1B++GCcPrPEB3MaNPeB0UTzGATyylqZCLmQ0tG+CCFAe2nV5cUlG
         79RLzUNBePkQeD4MG7kY4g0KAmHvufaLIgS4qoOMzMRLp/8IZbmFa/7ZVqFX8KP7bf
         pLBe0Nq+lQDXIz9axBJeYTDi3+gZIApKGbDuc8EEx00DR6bW9RHbLIfr41SDvtd4Cr
         xsrzCnWq5l40iLwSbVJKT083L6Me4kdyIaU3QgRBTRpuN2/01tMdHL7XwIh7IGrDya
         Thm5TroTtgNMg==
Date:   Wed, 21 Jul 2021 12:43:53 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 048/138] mm/memcg: Add folio_lruvec_lock() and
 similar functions
Message-ID: <YPfsWdV6AyrFOWsG@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-49-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-49-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:34AM +0100, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of lock_page_lruvec() and similar
> functions.  Also convert lruvec_memcg_debug() to take a folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/memcontrol.h | 32 ++++++++++++++-----------
>  mm/compaction.c            |  2 +-
>  mm/huge_memory.c           |  5 ++--
>  mm/memcontrol.c            | 48 ++++++++++++++++----------------------
>  mm/rmap.c                  |  2 +-
>  mm/swap.c                  |  8 ++++---
>  mm/vmscan.c                |  3 ++-
>  7 files changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index fd578d70b579..5935f06316b1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1158,67 +1158,59 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  }
>  
>  #ifdef CONFIG_DEBUG_VM
> -void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
> +void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
>  {
>  	struct mem_cgroup *memcg;
>  
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	memcg = page_memcg(page);
> +	memcg = folio_memcg(folio);
>  
>  	if (!memcg)
> -		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != root_mem_cgroup, page);
> +		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != root_mem_cgroup, folio);
>  	else
> -		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != memcg, page);
> +		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
>  }
>  #endif
>  
>  /**
> - * lock_page_lruvec - lock and return lruvec for a given page.
> - * @page: the page
> + * folio_lruvec_lock - lock and return lruvec for a given folio.
> + * @folio: Pointer to the folio.
>   *
>   * These functions are safe to use under any of the following conditions:
> - * - page locked
> - * - PageLRU cleared
> - * - lock_page_memcg()
> - * - page->_refcount is zero
> + * - folio locked
> + * - folio_test_lru false
> + * - folio_memcg_lock()
> + * - folio frozen (refcount of 0)

Missing return description

>   */
> -struct lruvec *lock_page_lruvec(struct page *page)
> +struct lruvec *folio_lruvec_lock(struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -	struct lruvec *lruvec;
> +	struct lruvec *lruvec = folio_lruvec(folio);
>  
> -	lruvec = folio_lruvec(folio);
>  	spin_lock(&lruvec->lru_lock);
> -
> -	lruvec_memcg_debug(lruvec, page);
> +	lruvec_memcg_debug(lruvec, folio);
>  
>  	return lruvec;
>  }
>  

-- 
Sincerely yours,
Mike.

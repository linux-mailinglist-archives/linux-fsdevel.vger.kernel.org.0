Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18F23B3F19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 10:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFYI2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 04:28:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43090 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhFYI2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:28:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0FDE821C23;
        Fri, 25 Jun 2021 08:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624609545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUgka/jsXYIFlXbsTn7ZrQFiKrwsVaDLpTN3DoUyc8s=;
        b=ngqGKScsP6EcFXD7BqS3u6wNiM2QXjXyEZDAsYJIz/N7snZjq9Cs7k8OHMGrubkvk2h/j/
        4Xic9S+liB6jhxJwCZ5tZ/DdGOudRwgv7f6T7Uhisv9N2FYzvZ4Aq5Xfg/zTkVzNE/M+9l
        cDwui4toG+ThcADmQ1NlVfaDQhhR+9g=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D5AC4A3BB4;
        Fri, 25 Jun 2021 08:25:44 +0000 (UTC)
Date:   Fri, 25 Jun 2021 10:25:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/46] mm/memcg: Add folio_uncharge_cgroup()
Message-ID: <YNWTCG3s910H3to2@dhcp22.suse.cz>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-16-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 22-06-21 13:15:20, Matthew Wilcox wrote:
> Reimplement mem_cgroup_uncharge() as a wrapper around
> folio_uncharge_cgroup().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Similar to the previous patch. Is there any reason why we cannot simply
stick with mem_cgroup_{un}charge and only change the parameter to folio?

> ---
>  include/linux/memcontrol.h |  5 +++++
>  mm/folio-compat.c          |  5 +++++
>  mm/memcontrol.c            | 14 +++++++-------
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a50e5cee6d2c..d4b2bc939eee 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -705,6 +705,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
>  }
>  
>  int folio_charge_cgroup(struct folio *, struct mm_struct *, gfp_t);
> +void folio_uncharge_cgroup(struct folio *);
>  
>  int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
>  int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
> @@ -1224,6 +1225,10 @@ static inline int folio_charge_cgroup(struct folio *folio,
>  	return 0;
>  }
>  
> +static inline void folio_uncharge_cgroup(struct folio *folio)
> +{
> +}
> +
>  static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
>  				    gfp_t gfp_mask)
>  {
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 1d71b8b587f8..d229b979b00d 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -54,4 +54,9 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp)
>  {
>  	return folio_charge_cgroup(page_folio(page), mm, gfp);
>  }
> +
> +void mem_cgroup_uncharge(struct page *page)
> +{
> +	folio_uncharge_cgroup(page_folio(page));
> +}
>  #endif
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 69638f84d11b..a6befc0843e7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6717,24 +6717,24 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  }
>  
>  /**
> - * mem_cgroup_uncharge - uncharge a page
> - * @page: page to uncharge
> + * folio_uncharge_cgroup - Uncharge a folio.
> + * @folio: Folio to uncharge.
>   *
> - * Uncharge a page previously charged with mem_cgroup_charge().
> + * Uncharge a folio previously charged with folio_charge_cgroup().
>   */
> -void mem_cgroup_uncharge(struct page *page)
> +void folio_uncharge_cgroup(struct folio *folio)
>  {
>  	struct uncharge_gather ug;
>  
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	/* Don't touch page->lru of any random page, pre-check: */
> -	if (!page_memcg(page))
> +	/* Don't touch folio->lru of any random page, pre-check: */
> +	if (!folio_memcg(folio))
>  		return;
>  
>  	uncharge_gather_clear(&ug);
> -	uncharge_page(page, &ug);
> +	uncharge_page(&folio->page, &ug);
>  	uncharge_batch(&ug);
>  }
>  
> -- 
> 2.30.2

-- 
Michal Hocko
SUSE Labs

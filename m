Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987AA3B3E44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFYINa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 04:13:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60282 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFYIN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:13:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F3CE51FE5E;
        Fri, 25 Jun 2021 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624608668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVIH1esBD9VFAEJAEFqDktBcj3lfhTJUdrlqCqIPwYg=;
        b=hZll+1qbTsCnNd40Zvjw/ueHvgCu6TwSoeM1JMbultQ1CDID9mrC/m7pbIIY7YPZHUgmx9
        KG8oFxWGxy6BzYNYKMU1pwU1IblwBT7Gr1Y+L1jl9YCCOqTt58N1bl1ET7O6UNIX4Un+Uk
        6HZma729QTHDpGWGhtfdVxMM5coJBhk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C6906A3C0D;
        Fri, 25 Jun 2021 08:11:07 +0000 (UTC)
Date:   Fri, 25 Jun 2021 10:11:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/46] mm/memcg: Convert commit_charge() to take a
 folio
Message-ID: <YNWPm/IC97CHLr8O@dhcp22.suse.cz>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-14-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 22-06-21 13:15:18, Matthew Wilcox wrote:
> The memcg_data is only set on the head page, so enforce that by
> typing it as a folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/memcontrol.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7423cb11eb88..7939e4e9118d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2700,9 +2700,9 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  }
>  #endif
>  
> -static void commit_charge(struct page *page, struct mem_cgroup *memcg)
> +static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  {
> -	VM_BUG_ON_PAGE(page_memcg(page), page);
> +	VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
>  	/*
>  	 * Any of the following ensures page's memcg stability:
>  	 *
> @@ -2711,7 +2711,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
>  	 * - lock_page_memcg()
>  	 * - exclusive reference
>  	 */
> -	page->memcg_data = (unsigned long)memcg;
> +	folio->memcg_data = (unsigned long)memcg;
>  }
>  
>  static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
> @@ -6506,7 +6506,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>  			       gfp_t gfp)
>  {
> -	unsigned int nr_pages = thp_nr_pages(page);
> +	struct folio *folio = page_folio(page);
> +	unsigned int nr_pages = folio_nr_pages(folio);
>  	int ret;
>  
>  	ret = try_charge(memcg, gfp, nr_pages);
> @@ -6514,7 +6515,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>  		goto out;
>  
>  	css_get(&memcg->css);
> -	commit_charge(page, memcg);
> +	commit_charge(folio, memcg);
>  
>  	local_irq_disable();
>  	mem_cgroup_charge_statistics(memcg, nr_pages);
> @@ -6771,21 +6772,21 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
>   */
>  void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  {
> +	struct folio *newfolio = page_folio(newpage);
>  	struct mem_cgroup *memcg;
> -	unsigned int nr_pages;
> +	unsigned int nr_pages = folio_nr_pages(newfolio);
>  	unsigned long flags;
>  
>  	VM_BUG_ON_PAGE(!PageLocked(oldpage), oldpage);
> -	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
> -	VM_BUG_ON_PAGE(PageAnon(oldpage) != PageAnon(newpage), newpage);
> -	VM_BUG_ON_PAGE(PageTransHuge(oldpage) != PageTransHuge(newpage),
> -		       newpage);
> +	VM_BUG_ON_FOLIO(!folio_locked(newfolio), newfolio);
> +	VM_BUG_ON_FOLIO(PageAnon(oldpage) != folio_anon(newfolio), newfolio);
> +	VM_BUG_ON_FOLIO(compound_nr(oldpage) != nr_pages, newfolio);
>  
>  	if (mem_cgroup_disabled())
>  		return;
>  
>  	/* Page cache replacement: new page already charged? */
> -	if (page_memcg(newpage))
> +	if (folio_memcg(newfolio))
>  		return;
>  
>  	memcg = page_memcg(oldpage);
> @@ -6794,14 +6795,12 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  		return;
>  
>  	/* Force-charge the new page. The old one will be freed soon */
> -	nr_pages = thp_nr_pages(newpage);
> -
>  	page_counter_charge(&memcg->memory, nr_pages);
>  	if (do_memsw_account())
>  		page_counter_charge(&memcg->memsw, nr_pages);
>  
>  	css_get(&memcg->css);
> -	commit_charge(newpage, memcg);
> +	commit_charge(newfolio, memcg);
>  
>  	local_irq_save(flags);
>  	mem_cgroup_charge_statistics(memcg, nr_pages);
> -- 
> 2.30.2

-- 
Michal Hocko
SUSE Labs

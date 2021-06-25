Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DF53B3E18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 09:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFYIBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 04:01:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37546 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhFYIBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:01:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2751121C12;
        Fri, 25 Jun 2021 07:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624607936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qSzuM8LtK7m5H6T2smtw4LRb8ekj+mhdxEL6qx2sV5A=;
        b=Ki3jau646Mv+YtF00epTZkVw0GdibYD508xlDZP4IEcQ/va23dYPqq0pZNigFlJf0rPibU
        Tz3UI80uMHooNd7ok87KYdM0tAPYKGCYEWAoQVeScZd6kroJNuNXDe2Okrqt6lc6X0X9H+
        R2J3GayBEZxwi7kNxWum2OgtW2kSKT8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E8A26A3BF2;
        Fri, 25 Jun 2021 07:58:55 +0000 (UTC)
Date:   Fri, 25 Jun 2021 09:58:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/46] mm/memcg: Remove 'page' parameter to
 mem_cgroup_charge_statistics()
Message-ID: <YNWMv48TaZWWIa0d@dhcp22.suse.cz>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-12-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 22-06-21 13:15:16, Matthew Wilcox wrote:
> The last use of 'page' was removed by commit 468c398233da ("mm:
> memcontrol: switch to native NR_ANON_THPS counter"), so we can now remove
> the parameter from the function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/memcontrol.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 64ada9e650a5..1204c6a0c671 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -814,7 +814,6 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>  }
>  
>  static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
> -					 struct page *page,
>  					 int nr_pages)
>  {
>  	/* pagein of a big page is an event. So, ignore page size */
> @@ -5504,9 +5503,9 @@ static int mem_cgroup_move_account(struct page *page,
>  	ret = 0;
>  
>  	local_irq_disable();
> -	mem_cgroup_charge_statistics(to, page, nr_pages);
> +	mem_cgroup_charge_statistics(to, nr_pages);
>  	memcg_check_events(to, page);
> -	mem_cgroup_charge_statistics(from, page, -nr_pages);
> +	mem_cgroup_charge_statistics(from, -nr_pages);
>  	memcg_check_events(from, page);
>  	local_irq_enable();
>  out_unlock:
> @@ -6527,7 +6526,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>  	commit_charge(page, memcg);
>  
>  	local_irq_disable();
> -	mem_cgroup_charge_statistics(memcg, page, nr_pages);
> +	mem_cgroup_charge_statistics(memcg, nr_pages);
>  	memcg_check_events(memcg, page);
>  	local_irq_enable();
>  out:
> @@ -6814,7 +6813,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  	commit_charge(newpage, memcg);
>  
>  	local_irq_save(flags);
> -	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
> +	mem_cgroup_charge_statistics(memcg, nr_pages);
>  	memcg_check_events(memcg, newpage);
>  	local_irq_restore(flags);
>  }
> @@ -7044,7 +7043,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	 * only synchronisation we have for updating the per-CPU variables.
>  	 */
>  	VM_BUG_ON(!irqs_disabled());
> -	mem_cgroup_charge_statistics(memcg, page, -nr_entries);
> +	mem_cgroup_charge_statistics(memcg, -nr_entries);
>  	memcg_check_events(memcg, page);
>  
>  	css_put(&memcg->css);
> -- 
> 2.30.2

-- 
Michal Hocko
SUSE Labs

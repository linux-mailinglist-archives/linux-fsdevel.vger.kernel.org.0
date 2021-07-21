Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44723D0C08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbhGUJG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237476AbhGUJE0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:04:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F383E611CE;
        Wed, 21 Jul 2021 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626860650;
        bh=UcNsCOeP9E0aJ5CeOiZ43ZkdbySOVX/gLMDfuWMg0lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQfxrCv7K1DRsCJrlA6pb9QQ2+m22y0FLER/jNbiP0qEsls6jh+qHMorntKQ/VE0m
         EOtCHqkJNXuUj2Y3tWSgyFsZaiIJOI28KBZg4+VwZq8aHZwlEKF1VQA7vvHgnhv+HH
         i2FRkkp8P6pb0i2IjrbfMGI1aKqTo1AdCpXPWWH9+OzUV1ErweCsz2DZhy5rSCE7Vh
         3wXAi0OtLLymRENzQ4i8TieEP2y1CWns8RTBVMpnSYjak86o8QWrpIkSyPKDwI+9DD
         ZYuLrAzyqBjGjYj3BAayXkgN4mkiao74mmNA8qKQNuLErGc3Dm2ecFABX4YQG9OPo0
         XzwPdboK77NEg==
Date:   Wed, 21 Jul 2021 12:44:04 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 040/138] mm/memcg: Convert mem_cgroup_charge() to
 take a folio
Message-ID: <YPfsZIZZqT6SAYub@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-41-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-41-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:26AM +0100, Matthew Wilcox (Oracle) wrote:
> Convert all callers of mem_cgroup_charge() to call page_folio() on the
> page they're currently passing in.  Many of them will be converted to
> use folios themselves soon.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/memcontrol.h |  6 +++---
>  kernel/events/uprobes.c    |  3 ++-
>  mm/filemap.c               |  2 +-
>  mm/huge_memory.c           |  2 +-
>  mm/khugepaged.c            |  4 ++--
>  mm/ksm.c                   |  3 ++-
>  mm/memcontrol.c            | 26 +++++++++++++-------------
>  mm/memory.c                |  9 +++++----
>  mm/migrate.c               |  2 +-
>  mm/shmem.c                 |  2 +-
>  mm/userfaultfd.c           |  2 +-
>  11 files changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c2ffad021e09..03283d97b62a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6697,27 +6696,27 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>  
>  	local_irq_disable();
>  	mem_cgroup_charge_statistics(memcg, nr_pages);
> -	memcg_check_events(memcg, page_to_nid(page));
> +	memcg_check_events(memcg, folio_nid(folio));
>  	local_irq_enable();
>  out:
>  	return ret;
>  }
>  
>  /**
> - * mem_cgroup_charge - charge a newly allocated page to a cgroup
> - * @page: page to charge
> - * @mm: mm context of the victim
> - * @gfp_mask: reclaim mode
> + * mem_cgroup_charge - Charge a newly allocated folio to a cgroup.
> + * @folio: Folio to charge.
> + * @mm: mm context of the allocating task.
> + * @gfp: reclaim mode
>   *
> - * Try to charge @page to the memcg that @mm belongs to, reclaiming
> - * pages according to @gfp_mask if necessary. if @mm is NULL, try to
> + * Try to charge @folio to the memcg that @mm belongs to, reclaiming
> + * pages according to @gfp if necessary.  If @mm is NULL, try to
>   * charge to the active memcg.
>   *
> - * Do not use this for pages allocated for swapin.
> + * Do not use this for folios allocated for swapin.
>   *
>   * Returns 0 on success. Otherwise, an error code is returned.

Missing return description

>   */
> -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> +int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
>  {
>  	struct mem_cgroup *memcg;
>  	int ret;

-- 
Sincerely yours,
Mike.

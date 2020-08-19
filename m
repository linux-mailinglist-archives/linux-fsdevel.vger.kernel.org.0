Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B210C24933F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 05:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgHSDJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 23:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgHSDJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:09:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2935AC061389;
        Tue, 18 Aug 2020 20:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F5wTaICdDFqxr2lOQHsLPPgf5C2VHfmiS1ulJQG/qrA=; b=pRNzF+FYBoVBpJhZ4R4i+WnjDI
        1rGRrz3LMMHXZBee7/S7chsnLOL2j7o5Jr/cV5H8htkVDLem2lYo0Lke8nmwFxDJHpKdjHDmm/Qfj
        vIiqSF0Bc9PicVZTRIcQlx/WT8Hw3kx6YjAQ7KtmxoUD+LxdnOq7ALqN3uSoukkBTHLfSph2A0C+u
        6dh8dO6PnhRztlEwDtYhRRBnUCeKmQtXH4Xec4upjPxDBV6IZKheIh6mc8YbPn90+R0NZ9TBsPipt
        SAHQVYYOIcHf98RhwJx4Y9SvcQ4hxpyQSHGjuq63nJs+8tNjG+hmxf2tUE8tOLmpZWngTYxUpw/0G
        tvc8/y7w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8ET6-00039Y-GW; Wed, 19 Aug 2020 03:08:52 +0000
Date:   Wed, 19 Aug 2020 04:08:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        mhocko@kernel.org, akpm@linux-foundation.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5 1/2] mm: Add become_kswapd and restore_kswapd
Message-ID: <20200819030852.GX17456@casper.infradead.org>
References: <20200819022425.25188-1-laoar.shao@gmail.com>
 <20200819022425.25188-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819022425.25188-2-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:24:24AM +0800, Yafang Shao wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Since XFS needs to pretend to be kswapd in some of its worker threads,
> create methods to save & restore kswapd state.  Don't bother restoring
> kswapd state in kswapd -- the only time we reach this code is when we're
> exiting and the task_struct is about to be destroyed anyway.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

See https://lore.kernel.org/linux-mm/20200625123143.GK1320@dhcp22.suse.cz/

Please add:

Acked-by: Michal Hocko <mhocko@suse.com>

> +/*
> + * Tell the memory management that we're a "memory allocator",
> + * and that if we need more memory we should get access to it
> + * regardless (see "__alloc_pages()"). "kswapd" should
> + * never get caught in the normal page freeing logic.
> + *
> + * (Kswapd normally doesn't need memory anyway, but sometimes
> + * you need a small amount of memory in order to be able to
> + * page out something else, and this flag essentially protects
> + * us from recursively trying to free more memory as we're
> + * trying to free the first piece of memory in the first place).
> + */

And let's change that comment as suggested by Michal (slightly edited
by me):

/* 
 * Tell the memory management code that this thread is working on behalf
 * of background memory reclaim (like kswapd).  That means that it will
 * get access to memory reserves should it need to allocate memory in
 * order to make forward progress.  With this great power comes great
 * responsibility to not exhaust those reserves.
 */

> +#define KSWAPD_PF_FLAGS		(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD)
> +
> +static inline unsigned long become_kswapd(void)
> +{
> +	unsigned long flags = current->flags & KSWAPD_PF_FLAGS;
> +
> +	current->flags |= KSWAPD_PF_FLAGS;
> +
> +	return flags;
> +}
> +
> +static inline void restore_kswapd(unsigned long flags)
> +{
> +	current->flags &= ~(flags ^ KSWAPD_PF_FLAGS);
> +}
> +
>  #ifdef CONFIG_MEMCG
>  /**
>   * memalloc_use_memcg - Starts the remote memcg charging scope.
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 99e1796eb833..3a2615bfde35 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3859,19 +3859,7 @@ static int kswapd(void *p)
>  	if (!cpumask_empty(cpumask))
>  		set_cpus_allowed_ptr(tsk, cpumask);
>  
> -	/*
> -	 * Tell the memory management that we're a "memory allocator",
> -	 * and that if we need more memory we should get access to it
> -	 * regardless (see "__alloc_pages()"). "kswapd" should
> -	 * never get caught in the normal page freeing logic.
> -	 *
> -	 * (Kswapd normally doesn't need memory anyway, but sometimes
> -	 * you need a small amount of memory in order to be able to
> -	 * page out something else, and this flag essentially protects
> -	 * us from recursively trying to free more memory as we're
> -	 * trying to free the first piece of memory in the first place).
> -	 */
> -	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> +	become_kswapd();
>  	set_freezable();
>  
>  	WRITE_ONCE(pgdat->kswapd_order, 0);
> @@ -3921,8 +3909,6 @@ static int kswapd(void *p)
>  			goto kswapd_try_sleep;
>  	}
>  
> -	tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
> -
>  	return 0;
>  }
>  
> -- 
> 2.18.1
> 

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD545ABFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 20:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhKWTI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 14:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237126AbhKWTI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:08:26 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7513EC061574;
        Tue, 23 Nov 2021 11:05:17 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id l9so201146ljq.5;
        Tue, 23 Nov 2021 11:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JPHSM6FHDBEnPAnUfKWTeGLE1lt0hmKq+LObheWUdUc=;
        b=qGyniNBPclg5LBcAsgNiOAX94lkM7+vNsTmObbvgIvI6z3IHXjNsahr2e2toxX2pMr
         LcAq3VyUNu5v/B/6nzm1yJvdlDVLdBHU6I9fsSTYRp4O2KCJ96mI5intxfR8DFUXk4Bi
         3qug5GSwlwMwaZB7gciSl9FhpsITwxLc9UWp9iMRfczs9nKBr4gjsFZ7INQNa6Cn72a7
         fzGRYhqlUgc4s+SktJXTw7Cxp9l3cw9cO6RPVnGvlA+uJb8qHm2Ur9yvcIThGdnjYUy6
         /w3yWtfqHkG2C4bnQgWV7asFqJUCfaECMh3FoCH+xDl4nlIXHKJJgow/HrII3KMGHhyD
         beUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JPHSM6FHDBEnPAnUfKWTeGLE1lt0hmKq+LObheWUdUc=;
        b=OnE1rlX4NaP2ilzg87KHwjtju3gkj2N8EHrOByefXtpHyBmho7lykWioFvVFwi2OHG
         0hVvn1mH3HX4eiDl0XzoYgyrjOYzr0G8ZR3zJaHYMIbeJclVRdQIdnr641Ww+3Nv/NY7
         VpfLJXcW41bzordD72yjxIYWYjHfqSSpYNgyhh8zf1RJJx4E0Prp6I+PFuFaIPFvANIe
         Z4DdJ7YEtJ7NvJPyXHZwDiA4hixho6RbXygdhsU7UsoCsMSWlYtyOVm/QI2LG91rCWlV
         Byxs5LsxQ6P6uVpvNDFIJNIyEiK7FFs8z6Nw6O8Hrg11jiYpLIWtj84uG7goVeRP3zRA
         335g==
X-Gm-Message-State: AOAM533Qo8AdtYMT9YP2sNTLhpnU2NWjBIg8Y7us9ZS/m/KW5MA6SiAs
        x/khRYf6mSsjBf9qWRjqY+k=
X-Google-Smtp-Source: ABdhPJwP6Hxbdd6hLW/UfjajZFWX15YEPhp3DehzFt8oV9Vk7NM6M/NGIQm/KJDAUrBb++Unu4mk9g==
X-Received: by 2002:a05:651c:b0e:: with SMTP id b14mr7869353ljr.495.1637694315668;
        Tue, 23 Nov 2021 11:05:15 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t12sm1554741ljg.63.2021.11.23.11.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:05:15 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 23 Nov 2021 20:05:12 +0100
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 1/4] mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc
Message-ID: <YZ07aL9tcqiwcUgi@pc638.lan>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-2-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122153233.9924-2-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:32:30PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> vmalloc historically hasn't supported GFP_NO{FS,IO} requests because
> page table allocations do not support externally provided gfp mask
> and performed GFP_KERNEL like allocations.
> 
> Since few years we have scope (memalloc_no{fs,io}_{save,restore}) APIs
> to enforce NOFS and NOIO constrains implicitly to all allocators within
> the scope. There was a hope that those scopes would be defined on a
> higher level when the reclaim recursion boundary starts/stops (e.g. when
> a lock required during the memory reclaim is required etc.). It seems
> that not all NOFS/NOIO users have adopted this approach and instead
> they have taken a workaround approach to wrap a single [k]vmalloc
> allocation by a scope API.
> 
> These workarounds do not serve the purpose of a better reclaim recursion
> documentation and reduction of explicit GFP_NO{FS,IO} usege so let's
> just provide them with the semantic they are asking for without a need
> for workarounds.
> 
> Add support for GFP_NOFS and GFP_NOIO to vmalloc directly. All internal
> allocations already comply with the given gfp_mask. The only current
> exception is vmap_pages_range which maps kernel page tables. Infer the
> proper scope API based on the given gfp mask.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmalloc.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..17ca7001de1f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2926,6 +2926,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	unsigned long array_size;
>  	unsigned int nr_small_pages = size >> PAGE_SHIFT;
>  	unsigned int page_order;
> +	unsigned int flags;
> +	int ret;
>  
>  	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
>  	gfp_mask |= __GFP_NOWARN;
> @@ -2967,8 +2969,24 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		goto fail;
>  	}
>  
> -	if (vmap_pages_range(addr, addr + size, prot, area->pages,
> -			page_shift) < 0) {
> +	/*
> +	 * page tables allocations ignore external gfp mask, enforce it
> +	 * by the scope API
> +	 */
> +	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> +		flags = memalloc_nofs_save();
> +	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> +		flags = memalloc_noio_save();
> +
> +	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> +			page_shift);
> +
> +	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> +		memalloc_nofs_restore(flags);
> +	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> +		memalloc_noio_restore(flags);
> +
> +	if (ret < 0) {
>  		warn_alloc(orig_gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to map pages",
>  			area->nr_pages * PAGE_SIZE);
> -- 
> 2.30.2
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0143F84E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhJ2H75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 03:59:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34806 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhJ2H74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:59:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 415AC1FD5C;
        Fri, 29 Oct 2021 07:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635494247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlivbYwS5gofQ32MIR1pehLeT+z7pyR3VleP+HxZjy4=;
        b=KJL61TUdZkK2YX3YO83Ki+43ubq3UVSh8je4M+TGe1XRLtT7ZkepWVDJY2XvpF53O670hm
        qiAUGz2BZLw9qJyjEDX2AY7jpl5vIKp1dUxncnAZKIhX7wtJu7Hv0ql2Omi98nqY39m2UF
        nNaMc7jYBxlIkqn033SbCboS5l86EIo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0DD98A3B83;
        Fri, 29 Oct 2021 07:57:27 +0000 (UTC)
Date:   Fri, 29 Oct 2021 09:57:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXupZjQgLAi6ClRi@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-3-mhocko@kernel.org>
 <CA+KHdyVqOuKny7bT+CtrCk8BrnARYz744Ze6cKMuy2BXo5e7jw@mail.gmail.com>
 <YXgsxF/NRlHjH+Ng@dhcp22.suse.cz>
 <20211026193315.GA1860@pc638.lan>
 <20211027175550.GA1776@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027175550.GA1776@pc638.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-10-21 19:55:50, Uladzislau Rezki wrote:
> On Tue, Oct 26, 2021 at 09:33:15PM +0200, Uladzislau Rezki wrote:
> > On Tue, Oct 26, 2021 at 06:28:52PM +0200, Michal Hocko wrote:
> > > On Tue 26-10-21 17:48:32, Uladzislau Rezki wrote:
> > > > > From: Michal Hocko <mhocko@suse.com>
> > > > >
> > > > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > > > cannot fail and they do not fit into a single page.
> > > > >
> > > > > The larg part of the vmalloc implementation already complies with the
> > > > > given gfp flags so there is no work for those to be done. The area
> > > > > and page table allocations are an exception to that. Implement a retry
> > > > > loop for those.
> > > > >
> > > > > Add a short sleep before retrying. 1 jiffy is a completely random
> > > > > timeout. Ideally the retry would wait for an explicit event - e.g.
> > > > > a change to the vmalloc space change if the failure was caused by
> > > > > the space fragmentation or depletion. But there are multiple different
> > > > > reasons to retry and this could become much more complex. Keep the retry
> > > > > simple for now and just sleep to prevent from hogging CPUs.
> > > > >
> > > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > > > ---
> > > > >  mm/vmalloc.c | 10 +++++++++-
> > > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index c6cc77d2f366..602649919a9d 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -2941,8 +2941,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > > >         else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> > > > >                 flags = memalloc_noio_save();
> > > > >
> > > > > -       ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > > > > +       do {
> > > > > +               ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > > > >                         page_shift);
> > > > > +               if (ret < 0)
> > > > > +                       schedule_timeout_uninterruptible(1);
> > > > > +       } while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
> > > > >
> > > > 
> > > > 1.
> > > > After that change a below code:
> > > > 
> > > > <snip>
> > > > if (ret < 0) {
> > > >     warn_alloc(orig_gfp_mask, NULL,
> > > >         "vmalloc error: size %lu, failed to map pages",
> > > >         area->nr_pages * PAGE_SIZE);
> > > >     goto fail;
> > > > }
> > > > <snip>
> > > > 
> > > > does not make any sense anymore.
> > > 
> > > Why? Allocations without __GFP_NOFAIL can still fail, no?
> > > 
> > Right. I meant one thing but wrote slightly differently. In case of
> > vmap_pages_range() fails(if __GFP_NOFAIL is set) should we emit any
> > warning message? Because either we can recover on a future iteration
> > or it stuck there infinitely so a user does not understand what happened.
> > From the other hand this is how __GFP_NOFAIL works, hm..
> > 
> > Another thing, i see that schedule_timeout_uninterruptible(1) is invoked
> > for all cases even when __GFP_NOFAIL is not set, in that scenario we do
> > not want to wait, instead we should return back to a caller asap. Or am
> > i missing something here?
> > 
> > > > 2.
> > > > Can we combine two places where we handle __GFP_NOFAIL into one place?
> > > > That would look like as more sorted out.
> > > 
> > > I have to admit I am not really fluent at vmalloc code so I wanted to
> > > make the code as simple as possible. How would I unwind all the allocated
> > > memory (already allocated as GFP_NOFAIL) before retrying at
> > > __vmalloc_node_range (if that is what you suggest). And isn't that a
> > > bit wasteful?
> > > 
> > > Or did you have anything else in mind?
> > >
> > It depends on how often all this can fail. But let me double check if
> > such combining is easy.
> > 
> I mean something like below. The idea is to not spread the __GFP_NOFAIL
> across the vmalloc file keeping it in one solid place:
> 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d77830ff604c..f4b7927e217e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2889,8 +2889,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	unsigned long array_size;
>  	unsigned int nr_small_pages = size >> PAGE_SHIFT;
>  	unsigned int page_order;
> +	unsigned long flags;
> +	int ret;
>  
>  	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
> +
> +	/*
> +	 * This is i do not understand why we do not want to see warning messages.
> +	 */
>  	gfp_mask |= __GFP_NOWARN;

I suspect this is becauser vmalloc wants to have its own failure
reporting.

[...]
> @@ -3010,16 +3037,22 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
>  				  VM_UNINITIALIZED | vm_flags, start, end, node,
>  				  gfp_mask, caller);
> -	if (!area) {
> -		warn_alloc(gfp_mask, NULL,
> -			"vmalloc error: size %lu, vm_struct allocation failed",
> -			real_size);
> -		goto fail;
> -	}
> +	if (area)
> +		addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
> +
> +	if (!area || !addr) {
> +		if (gfp_mask & __GFP_NOFAIL) {
> +			schedule_timeout_uninterruptible(1);
> +			goto again;
> +		}
> +
> +		if (!area)
> +			warn_alloc(gfp_mask, NULL,
> +				"vmalloc error: size %lu, vm_struct allocation failed",
> +				real_size);
>  
> -	addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
> -	if (!addr)
>  		goto fail;
> +	}
>  
>  	/*
>  	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
> <snip>

OK, this looks easier from the code reading but isn't it quite wasteful
to throw all the pages backing the area (all of them allocated as
__GFP_NOFAIL) just to then fail to allocate few page tables pages and
drop all of that on the floor (this will happen in __vunmap AFAICS).

I mean I do not care all that strongly but it seems to me that more
changes would need to be done here and optimizations can be done on top.

Is this something you feel strongly about?
-- 
Michal Hocko
SUSE Labs

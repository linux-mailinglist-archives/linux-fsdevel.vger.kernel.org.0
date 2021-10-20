Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41FC4346CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 10:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhJTI12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 04:27:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJTI1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:27:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B10A61FD9D;
        Wed, 20 Oct 2021 08:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634718306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8kM5MPhqrfnEDHU7vUn3OWBK24lQfifgPAWKlJM6Fw=;
        b=sY2/IOBwR+E08DVd4U1l0h6736ab9RIlZ26ejS+mfebDxHyqNsShLLL5GO3G8dHBe9CghW
        hKWyNed18jTBDa8gkmDDUdaMJaZNsV60vG7gQZPSJ4noBV1yX1TWA6cMWD7yd0S0COIhUJ
        MA36WcUHo7Kb01AXOxBAEIowOoDfXa8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 83531A3B84;
        Wed, 20 Oct 2021 08:25:06 +0000 (UTC)
Date:   Wed, 20 Oct 2021 10:25:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
References: <20211018114712.9802-1-mhocko@kernel.org>
 <20211018114712.9802-3-mhocko@kernel.org>
 <20211019110649.GA1933@pc638.lan>
 <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
 <20211019194658.GA1787@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019194658.GA1787@pc638.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-10-21 21:46:58, Uladzislau Rezki wrote:
> On Tue, Oct 19, 2021 at 01:52:07PM +0200, Michal Hocko wrote:
> > On Tue 19-10-21 13:06:49, Uladzislau Rezki wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > > cannot fail and they do not fit into a single page.
> > > > 
> > > > The larg part of the vmalloc implementation already complies with the
> > > > given gfp flags so there is no work for those to be done. The area
> > > > and page table allocations are an exception to that. Implement a retry
> > > > loop for those.
> > > > 
> > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > > ---
> > > >  mm/vmalloc.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 7455c89598d3..3a5a178295d1 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -2941,8 +2941,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > >  	else if (!(gfp_mask & (__GFP_FS | __GFP_IO)))
> > > >  		flags = memalloc_noio_save();
> > > >  
> > > > -	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > > > +	do {
> > > > +		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > > >  			page_shift);
> > > > +	} while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
> > > >  
> > > >  	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> > > >  		memalloc_nofs_restore(flags);
> > > > @@ -3032,6 +3034,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> > > >  		warn_alloc(gfp_mask, NULL,
> > > >  			"vmalloc error: size %lu, vm_struct allocation failed",
> > > >  			real_size);
> > > > +		if (gfp_mask && __GFP_NOFAIL)
> > > > +			goto again;
> > > >  		goto fail;
> > > >  	}
> > > >  
> > > > -- 
> > > > 2.30.2
> > > > 
> > > I have checked the vmap code how it aligns with the __GFP_NOFAIL flag.
> > > To me it looks correct from functional point of view.
> > > 
> > > There is one place though it is kasan_populate_vmalloc_pte(). It does
> > > not use gfp_mask, instead it directly deals with GFP_KERNEL for its
> > > internal purpose. If it fails the code will end up in loping in the
> > > __vmalloc_node_range().
> > > 
> > > I am not sure how it is important to pass __GFP_NOFAIL into KASAN code.
> > > 
> > > Any thoughts about it?
> > 
> > The flag itself is not really necessary down there as long as we
> > guarantee that the high level logic doesn't fail. In this case we keep
> > retrying at __vmalloc_node_range level which should be possible to cover
> > all callers that can control gfp mask. I was thinking to put it into
> > __get_vm_area_node but that was slightly more hairy and we would be
> > losing the warning which might turn out being helpful in cases where the
> > failure is due to lack of vmalloc space or similar constrain. Btw. do we
> > want some throttling on a retry?
> > 
> I think adding kind of schedule() will not make things worse and in corner
> cases could prevent a power drain by CPU. It is important for mobile devices. 

I suspect you mean schedule_timeout here? Or cond_resched? I went with a
later for now, I do not have a good idea for how to long to sleep here.
I am more than happy to change to to a sleep though.

> As for vmap space, it can be that a user specifies a short range that does
> not contain any free area. In that case we might never return back to a caller.

This is to be expected. The caller cannot fail and if it would be
looping around vmalloc it wouldn't return anyway.

> Maybe add a good comment something like: think what you do when deal with the
> __vmalloc_node_range() and __GFP_NOFAIL?

We have a generic documentation for gfp flags and __GFP_NOFAIL is
docuemented to "The allocation could block indefinitely but will never
return with failure." We are discussing improvements for the generic
documentation in another thread [1] and we will likely extend it so I
suspect we do not have to repeat drawbacks here again.

[1] http://lkml.kernel.org/r/163184741778.29351.16920832234899124642.stgit@noble.brown

Anyway the gfp mask description and constrains for vmalloc are not
documented. I will add a new patch to fill that gap and send it as a
reply to this one
-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1532542BA35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 10:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhJMI3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 04:29:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59052 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhJMI3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:29:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4721822293;
        Wed, 13 Oct 2021 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634113619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=McR6yLTw26IMl2q+Ttf8E0wCs6FpSGK2pEn0KwZBs4Q=;
        b=Bc2vAIAmillFOD/w7gXfw+OemzeQe4gw3MeuwYVov4/Uno6d88ZQytx35zg3gnZFoo+m3e
        AraEWcP/ZW/YS59FTqCxuwlTSWG1/rZVgyI/zedQilBYDcaev36ZPoV+ig2L2nyPz7u5gb
        IVIZNlkwo/2ROs3X6NM9FabSSFwkYiw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B41AAA3B83;
        Wed, 13 Oct 2021 08:26:58 +0000 (UTC)
Date:   Wed, 13 Oct 2021 10:26:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     NeilBrown <neilb@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
Message-ID: <YWaYUsXgXS6GXM+M@dhcp22.suse.cz>
References: <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
 <20211006231452.GF54211@dread.disaster.area>
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>
 <163364854551.31063.4377741712039731672@noble.neil.brown.name>
 <YV/31+qXwqEgaxJL@dhcp22.suse.cz>
 <20211008223649.GJ54211@dread.disaster.area>
 <YWQmsESyyiea0zle@dhcp22.suse.cz>
 <20211013023231.GV2361455@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013023231.GV2361455@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-10-21 13:32:31, Dave Chinner wrote:
> On Mon, Oct 11, 2021 at 01:57:36PM +0200, Michal Hocko wrote:
> > On Sat 09-10-21 09:36:49, Dave Chinner wrote:
> > > On Fri, Oct 08, 2021 at 09:48:39AM +0200, Michal Hocko wrote:
> > > > > > > Even the API constaints of kvmalloc() w.r.t. only doing the vmalloc
> > > > > > > fallback if the gfp context is GFP_KERNEL - we already do GFP_NOFS
> > > > > > > kvmalloc via memalloc_nofs_save/restore(), so this behavioural
> > > > > > > restriction w.r.t. gfp flags just makes no sense at all.
> > > > > > 
> > > > > > GFP_NOFS (without using the scope API) has the same problem as NOFAIL in
> > > > > > the vmalloc. Hence it is not supported. If you use the scope API then
> > > > > > you can GFP_KERNEL for kvmalloc. This is clumsy but I am not sure how to
> > > > > > define these conditions in a more sensible way. Special case NOFS if the
> > > > > > scope api is in use? Why do you want an explicit NOFS then?
> > > 
> > > Exactly my point - this is clumsy and a total mess. I'm not asking
> > > for an explicit GFP_NOFS, just pointing out that the documented
> > > restrictions that "vmalloc can only do GFP_KERNEL allocations" is
> > > completely wrong.
> > > 
> > > vmalloc()
> > > {
> > > 	if (!(gfp_flags &  __GFP_FS))
> > > 		memalloc_nofs_save();
> > > 	p = __vmalloc(gfp_flags | GFP_KERNEL)
> > > 	if (!(gfp_flags &  __GFP_FS))
> > > 		memalloc_nofs_restore();
> > > }
> > > 
> > > Yup, that's how simple it is to support GFP_NOFS support in
> > > vmalloc().
> > 
> > Yes, this would work from the functionality POV but it defeats the
> > philosophy behind the scope API. Why would you even need this if the
> > scope was defined by the caller of the allocator?
> 
> Who actually cares that vmalloc might be using the scoped API
> internally to implement GFP_NOFS or GFP_NOIO? Nobody at all.
> It is far more useful (and self documenting!) for one-off allocations
> to pass a GFP_NOFS flag than it is to use a scope API...

I would agree with you if the explicit GFP_NOFS usage was consistent
and actually justified in the majority cases. My experience tells me
otherwise though. Many filesystems use the flag just because that is
easier. That leads to a huge overuse of the flag that leads to practical
problems.

I was hoping that if we offer an API that would define problematic
reclaim recursion scopes then it would reduce the abuse. I haven't
expected this to happen overnight but it is few years and it seems
it will not happen soon either.

[...]

> > > It also points out that the scope API is highly deficient.
> > > We can do GFP_NOFS via the scope API, but we can't
> > > do anything else because *there is no scope API for other GFP
> > > flags*.
> > > 
> > > Why don't we have a GFP_NOFAIL/__GFP_RETRY_FOREVER scope API?
> > 
> > NO{FS,IO} where first flags to start this approach. And I have to admit
> > the experiment was much less successful then I hoped for. There are
> > still thousands of direct NOFS users so for some reason defining scopes
> > is not an easy thing to do.
> > 
> > I am not against NOFAIL scopes in principle but seeing the nofs
> > "success" I am worried this will not go really well either and it is
> > much more tricky as NOFAIL has much stronger requirements than NOFS.
> > Just imagine how tricky this can be if you just call a library code
> > that is not under your control within a NOFAIL scope. What if that
> > library code decides to allocate (e.g. printk that would attempt to do
> > an optimistic NOWAIT allocation).
> 
> I already asked you that _exact_ question earlier in the thread
> w.r.t.  kvmalloc(GFP_NOFAIL) using optimistic NOWAIT kmalloc
> allocation. I asked you as a MM expert to define *and document* the
> behaviour that should result, not turn around and use the fact that
> it is undefined behaviour as a "this is too hard" excuse for not
> changing anything.

Dave, you have "thrown" a lot of complains in previous emails and it is
hard to tell rants from features requests apart. I am sorry but I
believe it would be much more productive to continue this discussion if
you could mild your tone.

Can I ask you to break down your feature requests into separate emails
so that we can discuss and track them separately rather in this quite a
long thread which has IMHO diverghed from the initial topic. Thanks!

> THe fact is that the scope APIs are only really useful for certain
> contexts where restrictions are set by higher level functionality.
> For one-off allocation constraints the API sucks and we end up with

Could you be more specific about these one-off allocation constrains?
What would be the reason to define one-off NO{FS,IO} allocation
constrain? Or did you have your NOFAIL example in mind?

> crap like this (found in btrfs):
> 
>                 /*                                                               
>                  * We're holding a transaction handle, so use a NOFS memory      
>                  * allocation context to avoid deadlock if reclaim happens.      
>                  */                                                              
>                 nofs_flag = memalloc_nofs_save();                                
>                 value = kmalloc(size, GFP_KERNEL);                               
>                 memalloc_nofs_restore(nofs_flag);                                

Yes this looks wrong indeed! If I were to review such a code I would ask
why the scope cannot match the transaction handle context. IIRC jbd does
that.

I am aware of these patterns. I was pulled in some discussions in the
past and in some it turned out that the constrain is not needed at all
and in some cases that has led to a proper scope definition. As you
point out in your other examples it just happens that it is easier to
go an easy path and define scopes ad-hoc to work around allocation
API limitations.

[...]

> IOWs, a large number of the users of the scope API simply make
> [k]vmalloc() provide GFP_NOFS behaviour. ceph_kvmalloc() is pretty
> much a wrapper that indicates how all vmalloc functions should
> behave. Honour GFP_NOFS and GFP_NOIO by using the scope API
> internally.

I was discouraging from this behavior at vmalloc level to push people
to use scopes properly - aka at the level where the reclaim recursion is
really a problem. If that is infeasible in practice then we can
re-evaluate of course. I was really hoping we can get rid of cargo cult
GFP_NOFS usage this way but the reality often disagrees with hopes.

All that being said, let's discuss [k]vmalloc constrains and usecases
that need changes in a separate email thread.

Thanks!
-- 
Michal Hocko
SUSE Labs

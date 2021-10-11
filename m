Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4092428C6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 13:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhJKL7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 07:59:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhJKL7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:59:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 16BBD22057;
        Mon, 11 Oct 2021 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633953459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ce77qI6y3DipquGPPaJP7OvYNOPemKuisxdnRJGV4SQ=;
        b=lwm8crMgqqTsgbAJ4MtooXFvCeRaAmXhklSum+w87BWcFxQ997RXtx1Dx3er0/ZvOKoJSZ
        /Dsy9YIxlXz5LVEKG8X878CAvG8puCucTRjfWYF/s78WLAy4RnDhcMh/CQd0q7Rp8Z9JLd
        40t4GjR9pNknv+UfI5BtETmboA6ySUo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 820F3A3B89;
        Mon, 11 Oct 2021 11:57:38 +0000 (UTC)
Date:   Mon, 11 Oct 2021 13:57:36 +0200
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
Message-ID: <YWQmsESyyiea0zle@dhcp22.suse.cz>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
 <163184741778.29351.16920832234899124642.stgit@noble.brown>
 <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
 <20211006231452.GF54211@dread.disaster.area>
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>
 <163364854551.31063.4377741712039731672@noble.neil.brown.name>
 <YV/31+qXwqEgaxJL@dhcp22.suse.cz>
 <20211008223649.GJ54211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008223649.GJ54211@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 09-10-21 09:36:49, Dave Chinner wrote:
> On Fri, Oct 08, 2021 at 09:48:39AM +0200, Michal Hocko wrote:
> > __GFP_NOFAIL usage is a risk on its own. It is a hard requirement that
> > the allocator cannot back off.
[...]
> 
> No, "allocator cannot back off" isn't a hard requirement for most
> GFP_NOFAIL uses. *Not failing the allocation* is the hard
> requirement.

We are talking about the same thing here I belive. By cannot back off I
really mean cannot fail. Just for the clarification.

> How long it takes for the allocation to actually succeed is
> irrelevant to most callers, and given that we are replacing loops
> that do
> 
> 	while (!(p = kmalloc(sizeof(*p), GFP_KERNEL))
> 
> with __GFP_NOFAIL largely indicates that allocation *latency* and/or
> deadlocks are not an issue here.

Agreed. 

> Indeed, if we deadlock in XFS because there is no memory available,
> that is *not a problem kmalloc() should be trying to solve*. THe
> problem is the caller being unable to handle allocation failure, so
> if allocation cannot make progress, that needs to be fixed by the
> caller getting rid of the unfailable allocation.
> 
> The fact is that we've had these loops in production code for a
> couple of decades and these subsystems just aren't failing or
> deadlocking with such loops. IOWs, we don't need __GFP_NOFAIL to dig
> deep into reserves or drive the system to OOM killing - we just need
> to it keep retrying the same allocation until it succeeds.
> 
> Put simply, we want "retry forever" semantics to match what
> production kernels have been doing for the past couple of decades,
> but all we've been given are "never fail" semantics that also do
> something different and potentially much more problematic.
> 
> Do you see the difference here? __GFP_NOFAIL is not what we
> need in the vast majority of cases where it is used. We don't want
> the failing allocations to drive the machine hard into critical
> reserves, we just want the allocation to -eventually succeed- and if
> it doesn't, that's our problem to handle, not kmalloc()....

I can see your point. I do have a recollection that there were some
instance involved where an emergency access to memory reserves helped
in OOM situations.

Anway as I've tried to explain earlier that this all is an
implementation detail users of the flag shouldn't really care about. If
this heuristic is not doing any good then it should be removed.

[...]
> > > > > Even the API constaints of kvmalloc() w.r.t. only doing the vmalloc
> > > > > fallback if the gfp context is GFP_KERNEL - we already do GFP_NOFS
> > > > > kvmalloc via memalloc_nofs_save/restore(), so this behavioural
> > > > > restriction w.r.t. gfp flags just makes no sense at all.
> > > > 
> > > > GFP_NOFS (without using the scope API) has the same problem as NOFAIL in
> > > > the vmalloc. Hence it is not supported. If you use the scope API then
> > > > you can GFP_KERNEL for kvmalloc. This is clumsy but I am not sure how to
> > > > define these conditions in a more sensible way. Special case NOFS if the
> > > > scope api is in use? Why do you want an explicit NOFS then?
> 
> Exactly my point - this is clumsy and a total mess. I'm not asking
> for an explicit GFP_NOFS, just pointing out that the documented
> restrictions that "vmalloc can only do GFP_KERNEL allocations" is
> completely wrong.
> 
> vmalloc()
> {
> 	if (!(gfp_flags &  __GFP_FS))
> 		memalloc_nofs_save();
> 	p = __vmalloc(gfp_flags | GFP_KERNEL)
> 	if (!(gfp_flags &  __GFP_FS))
> 		memalloc_nofs_restore();
> }
> 
> Yup, that's how simple it is to support GFP_NOFS support in
> vmalloc().

Yes, this would work from the functionality POV but it defeats the
philosophy behind the scope API. Why would you even need this if the
scope was defined by the caller of the allocator? The initial hope was
to get rid of the NOFS abuse that can be seen in many filesystems. All
allocations from the scope would simply inherit the NOFS semantic so
an explicit NOFS shouldn't be really necessary, right?

> This goes along with the argument that "it's impossible to do
> GFP_NOFAIL with vmalloc" as I addressed above. These things are not
> impossible, but we hide behind "we don't want people to use vmalloc"
> as an excuse for having shitty behaviour whilst ignoring that
> vmalloc is *heavily used* by core subsystems like filesystems
> because they cannot rely on high order allocations succeeding....

I do not think there is any reason to discourage anybody from using
vmalloc these days. 32b is dying out and vmalloc space is no longer a
very scarce resource.

> It also points out that the scope API is highly deficient.
> We can do GFP_NOFS via the scope API, but we can't
> do anything else because *there is no scope API for other GFP
> flags*.
> 
> Why don't we have a GFP_NOFAIL/__GFP_RETRY_FOREVER scope API?

NO{FS,IO} where first flags to start this approach. And I have to admit
the experiment was much less successful then I hoped for. There are
still thousands of direct NOFS users so for some reason defining scopes
is not an easy thing to do.

I am not against NOFAIL scopes in principle but seeing the nofs
"success" I am worried this will not go really well either and it is
much more tricky as NOFAIL has much stronger requirements than NOFS.
Just imagine how tricky this can be if you just call a library code
that is not under your control within a NOFAIL scope. What if that
library code decides to allocate (e.g. printk that would attempt to do
an optimistic NOWAIT allocation).

> That
> would save us a lot of bother in XFS. What about GFP_DIRECT_RECLAIM?
> I'd really like to turn that off for allocations in the XFS
> transaction commit path (as noted already in this thread) because
> direct reclaim that can make no progress is actively harmful (as
> noted already in this thread)

As always if you have reasonable usecases then it is best to bring them
up on the MM list and we can discuss them.

> Like I said - this is more than just bad documentation - the problem
> is that the whole allocation API is an inconsistent mess of control
> mechanisms to begin with...

I am not going to disagree. There is a lot of historical baggage and
it doesn't help that any change is really hard to review because this
interface is used throughout the kernel. I have tried to change some
most obvious inconsistencies and I can tell this has always been a
frustrating experience with a very small "reward" in the end because
there are so many other problems.

That being said, I would more than love to have a consistent and well
defined interface and if you want to spend a lot of time on that then be
my guest.

> > > It would seem to make sense for kvmalloc to WARN_ON if it is passed
> > > flags that does not allow it to use vmalloc.
> > 
> > vmalloc is certainly not the hottest path in the kernel so I wouldn't be
> > opposed.
> 
> kvmalloc is most certainly becoming one of the hottest paths in XFS.
> IOWs, arguments that "vmalloc is not a hot path" are simply invalid
> these days because they are simply untrue. e.g. the profiles I
> posted in this thread...

Is it such a hot path that a check for compatible flags would be visible
in profiles though?
-- 
Michal Hocko
SUSE Labs

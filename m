Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A19A4337EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 15:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhJSOBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 10:01:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44968 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJSOBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:01:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BC05921A98;
        Tue, 19 Oct 2021 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634651966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sfqlwk+VcUMh+bOLPZdkXDNbL+XuwCC01NkQcfvVDWg=;
        b=t3ds4oRWdbI54awak280gkx0hi/8gcb+B5yOlBFsZCx6doySQBmUM6aeqSnovEQ8W8suI3
        xLWwFO6HyamqFNUiCYMdUNEZorK8Mb37Lz2X27AXVF18fNU+SVq324IO4bqQyoe+dIyYbr
        lBmaKv9ItwGDCFjmUTnPR1CeFfZMfYI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 74342A3B84;
        Tue, 19 Oct 2021 13:59:26 +0000 (UTC)
Date:   Tue, 19 Oct 2021 15:59:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <YW7PPViS0fEdTaKH@dhcp22.suse.cz>
References: <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
 <20211006231452.GF54211@dread.disaster.area>
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>
 <163364854551.31063.4377741712039731672@noble.neil.brown.name>
 <YV/31+qXwqEgaxJL@dhcp22.suse.cz>
 <20211008223649.GJ54211@dread.disaster.area>
 <YWQmsESyyiea0zle@dhcp22.suse.cz>
 <163398898675.17149.16715168325131099480@noble.neil.brown.name>
 <YW1LLlwjbyv8dcmn@dhcp22.suse.cz>
 <163461794761.17149.1193247176490791274@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163461794761.17149.1193247176490791274@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-10-21 15:32:27, Neil Brown wrote:
> On Mon, 18 Oct 2021, Michal Hocko wrote:
> > On Tue 12-10-21 08:49:46, Neil Brown wrote:
> > > On Mon, 11 Oct 2021, Michal Hocko wrote:
> > > > On Sat 09-10-21 09:36:49, Dave Chinner wrote:
> > > > > 
> > > > > Put simply, we want "retry forever" semantics to match what
> > > > > production kernels have been doing for the past couple of decades,
> > > > > but all we've been given are "never fail" semantics that also do
> > > > > something different and potentially much more problematic.
> > > > > 
> > > > > Do you see the difference here? __GFP_NOFAIL is not what we
> > > > > need in the vast majority of cases where it is used. We don't want
> > > > > the failing allocations to drive the machine hard into critical
> > > > > reserves, we just want the allocation to -eventually succeed- and if
> > > > > it doesn't, that's our problem to handle, not kmalloc()....
> > > > 
> > > > I can see your point. I do have a recollection that there were some
> > > > instance involved where an emergency access to memory reserves helped
> > > > in OOM situations.
> > > 
> > > It might have been better to annotate those particular calls with
> > > __GFP_ATOMIC or similar rather then change GFP_NOFAIL for everyone.
> > 
> > For historical reasons __GFP_ATOMIC is reserved for non sleeping
> > allocations. __GFP_HIGH would be an alternative.
> 
> Historical reasons certainly shouldn't be ignored.  But they can be
> questioned.

Agreed. Changing them is a more challenging task though. For example I
really dislike how access to memory reserves is bound to "no reclaim"
requirement. Ideally those should be completely orthogonal.

I also do not think we need as many ways to ask for memory reserves as
we have. Can a "regular" kernel developer tell a difference between
__GFP_ATOMIC and __GFP_HIGH?

I do not think so, unless one is willing to do ...

> __GFP_ATOMIC is documented as "the caller cannot reclaim or sleep and is
> high priority".
> This seems to over-lap with __GFP_DIRECT_RECLAIM (which permits reclaim
> and is the only place where page_alloc sleeps ... I think).
> 
> The effect of setting __GFP_ATOMIC is:
>   - triggers WARN_ON if  __GFP_DIRECT_RECLAIM is also set.
>   - bypass memcg limits
>   - ignore the watermark_boost_factor effect
>   - clears ALLOC_CPUSET
>   - sets ALLOC_HARDER which provides:
>    - access to nr_reserved_highatomic reserves
>    - access to 1/4 the low-watermark reserves (ALLOC_HIGH gives 1/2)
>      Combine them and you get access to 5/8 of the reserves.

... exactly this. And these are bunch of hacks developed over time and
the baggage which is hard to change as I've said. Somebody with a
sufficient time budget should start questioning all those and eventually
make __GFP_ATOMIC a story of the past.

> It is also used by driver/iommu/tegra-smmu.c to decide if a spinlock
> should remain held, or should be dropped over the alloc_page().  That's
> .... not my favourite code.

Exactly!

> So apart from the tegra thing and the WARN_ON, there is nothing about
> __GFP_ATOMIC which suggests it should only be used for non-sleeping
> allocations.

The warning was added when the original GFP_ATOMIC was untangled from the
reclaim implications to keep the "backward compatibility" IIRC. Mostly
for IRQ handlers where the GFP_ATOMIC was used the most. My memory might
fail me though.

> It *should* only be used for allocations with a high failure cost and
> relatively short time before the memory will be returned and that likely
> includes many non sleeping allocations.  It isn't clear to me why an
> allocation that is willing to sleep (if absolutely necessary) shouldn't
> be able to benefit from the priority boost of __GFP_ATOMIC.  Or at least
> of ALLOC_HARDER...

I completely agree! As mentioned above memory reserves should be
completely orthogonal. I am not sure we want an API for many different
levels of reserves access. Do we need more than __GFP_HIGH? Maybe with a
more descriptive name.

> Maybe __GFP_HIGH should get the memcg and watermark_boost benefits too? 
> 
> Given that we have ALLOC_HARDER and ALLOC_HIGH, it would seem to be
> sensible to export those two settings in GFP_foo, and not forbid one of
> them to be used with __GFP_DIRECT_RECLAIM.

I think ALLOC_HARDER should be kept internal implementation detail when
the allocator needs to give somebody a boost on top of requests for
internal balancing between requests.
ALLOC_HIGH already matches __GFP_HIGH and that should be the way to
ask for a boost explicitly IMO. We also have ALLOC_OOM as another level of
internal memory reserves for OOM victims. Again something to be in hands
of the allocator.
 
> > > Too late to fix that now though I think.  Maybe the best way forward is
> > > to discourage new uses of GFP_NOFAIL.  We would need a well-documented
> > > replacement.
> > 
> > I am not sure what that should be. Really if the memory reserves
> > behavior of GFP_NOFAIL is really problematic then let's just reap it
> > out. I do not see a new nofail like flag is due.
> 
> Presumably there is a real risk of deadlock if we just remove the
> memory-reserves boosts of __GFP_NOFAIL.  Maybe it would be safe to
> replace all current users of __GFP_NOFAIL with __GFP_NOFAIL|__GFP_HIGH,
> and then remove the __GFP_HIGH where analysis suggests there is no risk
> of deadlocks.

I would much rather not bind those together and go other way around. If
somebody can actually hit deadlocks (those are quite easy to spot as
they do not go away) then we can talk about how to deal with them.
Memory reserves can help only > < this much.

> Or maybe rename the __GFP_NOFAIL flag and #define __GFP_NOFAIL to
> include __GFP_HIGH?

Wouldn't that lead to the __GFP_ATOMIC story again?
 
> This would certainly be a better result than adding a new flag.
> 
> > 
> > > > Anway as I've tried to explain earlier that this all is an
> > > > implementation detail users of the flag shouldn't really care about. If
> > > > this heuristic is not doing any good then it should be removed.
> > > 
> > > Maybe users shouldn't care about implementation details, but they do
> > > need to care about semantics and costs.
> > > We need to know when it is appropriate to use GFP_NOFAIL, and when it is
> > > not.  And what alternatives there are when it is not appropriate.
> > > Just saying "try to avoid using it" and "requires careful analysis"
> > > isn't acceptable.  Sometimes it is unavoidable and analysis can only be
> > > done with a clear understanding of costs.  Possibly analysis can only be
> > > done with a clear understanding of the internal implementation details.
> > 
> > What we document currently is this
> >  * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
> >  * cannot handle allocation failures. The allocation could block
> >  * indefinitely but will never return with failure. Testing for
> >  * failure is pointless.
> 
> This implies it is incompatible with __GFP_NORETRY and (probably)
> requires __GFP_RECLAIM.  That is worth documenting, and possibly also a
> WARN_ON.

Yes, I thought this would be obvious as those are reclaim modifiers so
they require a reclaim. But I do see a point that being explicit here
cannot hurt. Same with combining them together. It just doesn't make
much sense to retry for ever and requesting noretry or retry and fail
at the same time. Again a clarification cannot hurt though.

> >  * New users should be evaluated carefully (and the flag should be
> >  * used only when there is no reasonable failure policy) but it is
> >  * definitely preferable to use the flag rather than opencode endless
> >  * loop around allocator.
> 
> How do we perform this evaluation? And why is it preferable to a loop?
> There are times when a loop makes sense, if there might be some other
> event that could provide the needed memory ...  or if a SIGKILL might
> make it irrelevant.
> slab allocators presumably shouldn't pass __GFP_NOFAIL to alloc_page(),
> but should instead loop around
>   1/ check if any existing slabs have space
>   2/ if not, try to allocate a new page
> Providing the latter blocks for a while but not indefinitely that should
> be optimal.
> Why is __GFP_NOFAIL better?

Because the allocator can do something if it knows that the allocation
cannot fail. E.g. give such an allocation a higher priority over those
that are allowed to fail. This is not limited to memory reserves,
although this is the only measure that is implemented currently IIRC.
On the other hand if there is something interesting the caller can do
directly - e.g. do internal object management like mempool does - then
it is better to retry at that level.

> >  * Using this flag for costly allocations is _highly_ discouraged.
> 
> This is unhelpful.  Saying something is "discouraged" carries an implied
> threat.  This is open source and threats need to be open.
> Why is it discouraged? IF it is not forbidden, then it is clearly
> permitted.  Maybe there are costs  - so a clear statement of those costs
> would be appropriate.
> Also, what is a suitable alternative?
> 
> Current code will trigger a WARN_ON, so it is effectively forbidden.
> Maybe we should document that __GFP_NOFAIL is forbidden for orders above
> 1, and that vmalloc() should be used instead (thanks for proposing that
> patch!).

I think we want to recommend kvmalloc as an alternative once vmalloc is
NOFAIL aware.

I will skip over some of the specific regarding SLAB and NOFS usage if
you do not mind and focus on points that have direct documentation
consequences. Also I do not feel qualified commenting on neither SLAB
nor FS internals.

[...]
> There is a lot of stuff there.... the bits that are important to me are:
> 
>  - why is __GFP_NOFAIL preferred? It is a valuable convenience, but I
>    don't see that it is necessary

I think it is preferred for one and a half reasons. It tells allocator
that this allocation cannot really fail and the caller doesn't have a
very good/clever retry policy (e.g. like mempools mentioned above). The
half reason would be for tracking purposes (git grep __GFP_NOFAIL) is
easier than trying to catch all sorts of while loops over allocation
which do not do anything really interesting.

>  - is it reasonable to use __GFP_HIGH when looping if there is a risk of
>    deadlock?

As I've said above. Memory reserves are a finite resource and as such
they cannot fundamentally solve deadlocks. They can help prioritize
though.

>  - Will __GFP_DIRECT_RECLAIM always result in a delay before failure? In
>    that case it should be safe to loop around allocations using
>    __GFP_DIRECT_RECLAIM without needing congestion_wait() (so it can
>    just be removed.

This is a good question and I do not think we have that documented
anywhere. We do cond_resched() for sure. I do not think we guarantee a
sleeping point in general. Maybe we should, I am not really sure.

Thanks for good comments and tough questions
-- 
Michal Hocko
SUSE Labs

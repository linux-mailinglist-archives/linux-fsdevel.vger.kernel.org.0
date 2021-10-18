Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A655B4315F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 12:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhJRKZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 06:25:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52972 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhJRKZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:25:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 643AE21977;
        Mon, 18 Oct 2021 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634552626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5pfBZDoLk4ZpCwseu4wfT52O1HEr2BW47ti2eIQLJ4c=;
        b=n0iHqSz5Cdj/OTCOaFShvFFM3HOJkLGulYHz3YmOxvsTJQHe4ZBJbT6BZ0PsLhHzC1qK1r
        XzT1k+43pV+TIW0BeKEK9xAbgn/mfh3rf/l7kVlx0skRtB9V60FHexH00EZqFhijkGP3o3
        Tx+phI7k6TkIzgV8fV0oJFXiU/Zlsnw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E8622A3B81;
        Mon, 18 Oct 2021 10:23:45 +0000 (UTC)
Date:   Mon, 18 Oct 2021 12:23:42 +0200
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
Message-ID: <YW1LLlwjbyv8dcmn@dhcp22.suse.cz>
References: <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
 <20211006231452.GF54211@dread.disaster.area>
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>
 <163364854551.31063.4377741712039731672@noble.neil.brown.name>
 <YV/31+qXwqEgaxJL@dhcp22.suse.cz>
 <20211008223649.GJ54211@dread.disaster.area>
 <YWQmsESyyiea0zle@dhcp22.suse.cz>
 <163398898675.17149.16715168325131099480@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163398898675.17149.16715168325131099480@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 12-10-21 08:49:46, Neil Brown wrote:
> On Mon, 11 Oct 2021, Michal Hocko wrote:
> > On Sat 09-10-21 09:36:49, Dave Chinner wrote:
> > > 
> > > Put simply, we want "retry forever" semantics to match what
> > > production kernels have been doing for the past couple of decades,
> > > but all we've been given are "never fail" semantics that also do
> > > something different and potentially much more problematic.
> > > 
> > > Do you see the difference here? __GFP_NOFAIL is not what we
> > > need in the vast majority of cases where it is used. We don't want
> > > the failing allocations to drive the machine hard into critical
> > > reserves, we just want the allocation to -eventually succeed- and if
> > > it doesn't, that's our problem to handle, not kmalloc()....
> > 
> > I can see your point. I do have a recollection that there were some
> > instance involved where an emergency access to memory reserves helped
> > in OOM situations.
> 
> It might have been better to annotate those particular calls with
> __GFP_ATOMIC or similar rather then change GFP_NOFAIL for everyone.

For historical reasons __GFP_ATOMIC is reserved for non sleeping
allocations. __GFP_HIGH would be an alternative.

> Too late to fix that now though I think.  Maybe the best way forward is
> to discourage new uses of GFP_NOFAIL.  We would need a well-documented
> replacement.

I am not sure what that should be. Really if the memory reserves
behavior of GFP_NOFAIL is really problematic then let's just reap it
out. I do not see a new nofail like flag is due.

> > Anway as I've tried to explain earlier that this all is an
> > implementation detail users of the flag shouldn't really care about. If
> > this heuristic is not doing any good then it should be removed.
> 
> Maybe users shouldn't care about implementation details, but they do
> need to care about semantics and costs.
> We need to know when it is appropriate to use GFP_NOFAIL, and when it is
> not.  And what alternatives there are when it is not appropriate.
> Just saying "try to avoid using it" and "requires careful analysis"
> isn't acceptable.  Sometimes it is unavoidable and analysis can only be
> done with a clear understanding of costs.  Possibly analysis can only be
> done with a clear understanding of the internal implementation details.

What we document currently is this
 * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
 * cannot handle allocation failures. The allocation could block
 * indefinitely but will never return with failure. Testing for
 * failure is pointless.
 * New users should be evaluated carefully (and the flag should be
 * used only when there is no reasonable failure policy) but it is
 * definitely preferable to use the flag rather than opencode endless
 * loop around allocator.
 * Using this flag for costly allocations is _highly_ discouraged.

so we tell when to use it - aka no reasonable failure policy. We put
some discouragind language there. There is some discouraging language
for high order allocations. Maybe we should suggest an alternative
there. It seems there are usecases for those as well so we should
implement a proper NOFAIL kvmalloc and recommend it for that instead.

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
> 
> I'm not certain your conclusion is valid.  It could be that defining
> scopes is easy enough, but no one feels motivated to do it.
> We need to do more than provide functionality.  We need to tell people. 
> Repeatedly.  And advertise widely.  And propose patches to make use of
> the functionality.  And... and... and...

Been there, done that for the low hanging fruit. Others were much more
complex for me to follow up and I had other stuff on my table.
 
> I think changing to the scope API is a good change, but it is
> conceptually a big change.  It needs to be driven.

Agreed.

> > I am not against NOFAIL scopes in principle but seeing the nofs
> > "success" I am worried this will not go really well either and it is
> > much more tricky as NOFAIL has much stronger requirements than NOFS.
> > Just imagine how tricky this can be if you just call a library code
> > that is not under your control within a NOFAIL scope. What if that
> > library code decides to allocate (e.g. printk that would attempt to do
> > an optimistic NOWAIT allocation).
> 
> __GFP_NOMEMALLOC holds a lesson worth learning here.  PF_MEMALLOC
> effectively adds __GFP_MEMALLOC to all allocations, but some call sites
> need to over-ride that because there are alternate strategies available.
> This need-to-over-ride doesn't apply to NOFS or NOIO as that really is a
> thread-wide state.  But MEMALLOC and NOFAIL are different.  Some call
> sites can reasonably handle failure locally.
> 
> I imagine the scope-api would say something like "NO_ENOMEM".  i.e.
> memory allocations can fail as long as ENOMEM is never returned.
> Any caller that sets __GFP_RETRY_MAYFAIL or __GFP_NORETRY or maybe some
> others which not be affected by the NO_ENOMEM scope.  But a plain
> GFP_KERNEL would.
> 
> Introducing the scope api would be a good opportunity to drop the
> priority boost and *just* block until success.  Priority boosts could
> then be added (possibly as a scope) only where they are measurably needed.
> 
> I think we have 28 process flags in use.  So we can probably afford one
> more for PF_MEMALLOC_NO_ENOMEM.  What other scope flags might be useful?
> PF_MEMALLOC_BOOST which added __GFP_ATOMIC but not __GFP_MEMALLOC ??
> PF_MEMALLOC_NORECLAIM ??

I dunno. PF_MEMALLOC and its GFP_$FOO counterparts are quite hard to
wrap my head around. I have never liked thos much TBH and building more
on top sounds like step backward. I might be wrong but this sounds like
even more work than NOFS scopes.
 
> > > That
> > > would save us a lot of bother in XFS. What about GFP_DIRECT_RECLAIM?
> > > I'd really like to turn that off for allocations in the XFS
> > > transaction commit path (as noted already in this thread) because
> > > direct reclaim that can make no progress is actively harmful (as
> > > noted already in this thread)
> > 
> > As always if you have reasonable usecases then it is best to bring them
> > up on the MM list and we can discuss them.
> 
> We are on the MM lists now... let's discuss :-)

Sure we can but this thread is a mix of so many topics that finding
something useful will turn to be hard from my past experience.

> Dave: How would you feel about an effort to change xfs to stop using
> GFP_NOFS, and to use memalloc_nofs_save/restore instead?

xfs is an example of a well behaved scope user. In fact the API has been
largely based on xfs previous interface. There are still NOFS usesages
in xfs which would be great to get rid of (e.g. the default mapping NOFS
which was added due to lockdep false positives but that is unrelated).

> Having a major
> filesystem make the transition would be a good test-case, and could be
> used to motivate other filesystems to follow.
> We could add and use memalloc_no_enomem_save() too.

ext has converted their transaction context to the scope API as well.
There is still some explicit NOFS usage but I haven't checked details
recently.
-- 
Michal Hocko
SUSE Labs

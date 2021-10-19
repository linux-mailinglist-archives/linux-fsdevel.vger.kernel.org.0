Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D41432CD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 06:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhJSEey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 00:34:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59116 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhJSEew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 00:34:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05C421FD8A;
        Tue, 19 Oct 2021 04:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634617958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+Ty1P/ZVVGtUapvdrpgP+8ZdftQTOtLyA7nyYCgGHk=;
        b=vjyehZv58QkQsdezQQmCoiwft0hknaqybVV5cRgmrNyJaiJUBF3Ylk3XkJyb21DE9/YFF/
        fHWBXJWurkigVozmbKPnsxLANYRSXx70+YcrYQWreiRBznP7+0QJUPY7rpOAfI1Mp+d0ys
        /nIRrJ8sfVjLsUqOgJsYSSahgyH/p74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634617958;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+Ty1P/ZVVGtUapvdrpgP+8ZdftQTOtLyA7nyYCgGHk=;
        b=V4E3Rzf1vx5xONR6+OUBW6FvHaIjJRmM3ERFGdmezjqxGQZGORYXhjQ3e9hCbUvSiqazyk
        rcrdO2pmRT16NzBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81FD313C26;
        Tue, 19 Oct 2021 04:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GGJwC19KbmFSMAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 19 Oct 2021 04:32:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>, "Jonathan Corbet" <corbet@lwn.net>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
In-reply-to: <YW1LLlwjbyv8dcmn@dhcp22.suse.cz>
References: <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>,
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>,
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>,
 <20211006231452.GF54211@dread.disaster.area>,
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>,
 <163364854551.31063.4377741712039731672@noble.neil.brown.name>,
 <YV/31+qXwqEgaxJL@dhcp22.suse.cz>,
 <20211008223649.GJ54211@dread.disaster.area>,
 <YWQmsESyyiea0zle@dhcp22.suse.cz>,
 <163398898675.17149.16715168325131099480@noble.neil.brown.name>,
 <YW1LLlwjbyv8dcmn@dhcp22.suse.cz>
Date:   Tue, 19 Oct 2021 15:32:27 +1100
Message-id: <163461794761.17149.1193247176490791274@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Oct 2021, Michal Hocko wrote:
> On Tue 12-10-21 08:49:46, Neil Brown wrote:
> > On Mon, 11 Oct 2021, Michal Hocko wrote:
> > > On Sat 09-10-21 09:36:49, Dave Chinner wrote:
> > > > 
> > > > Put simply, we want "retry forever" semantics to match what
> > > > production kernels have been doing for the past couple of decades,
> > > > but all we've been given are "never fail" semantics that also do
> > > > something different and potentially much more problematic.
> > > > 
> > > > Do you see the difference here? __GFP_NOFAIL is not what we
> > > > need in the vast majority of cases where it is used. We don't want
> > > > the failing allocations to drive the machine hard into critical
> > > > reserves, we just want the allocation to -eventually succeed- and if
> > > > it doesn't, that's our problem to handle, not kmalloc()....
> > > 
> > > I can see your point. I do have a recollection that there were some
> > > instance involved where an emergency access to memory reserves helped
> > > in OOM situations.
> > 
> > It might have been better to annotate those particular calls with
> > __GFP_ATOMIC or similar rather then change GFP_NOFAIL for everyone.
> 
> For historical reasons __GFP_ATOMIC is reserved for non sleeping
> allocations. __GFP_HIGH would be an alternative.

Historical reasons certainly shouldn't be ignored.  But they can be
questioned.
__GFP_ATOMIC is documented as "the caller cannot reclaim or sleep and is
high priority".
This seems to over-lap with __GFP_DIRECT_RECLAIM (which permits reclaim
and is the only place where page_alloc sleeps ... I think).

The effect of setting __GFP_ATOMIC is:
  - triggers WARN_ON if  __GFP_DIRECT_RECLAIM is also set.
  - bypass memcg limits
  - ignore the watermark_boost_factor effect
  - clears ALLOC_CPUSET
  - sets ALLOC_HARDER which provides:
   - access to nr_reserved_highatomic reserves
   - access to 1/4 the low-watermark reserves (ALLOC_HIGH gives 1/2)
     Combine them and you get access to 5/8 of the reserves.

It is also used by driver/iommu/tegra-smmu.c to decide if a spinlock
should remain held, or should be dropped over the alloc_page().  That's
.... not my favourite code.

So apart from the tegra thing and the WARN_ON, there is nothing about
__GFP_ATOMIC which suggests it should only be used for non-sleeping
allocations.
It *should* only be used for allocations with a high failure cost and
relatively short time before the memory will be returned and that likely
includes many non sleeping allocations.  It isn't clear to me why an
allocation that is willing to sleep (if absolutely necessary) shouldn't
be able to benefit from the priority boost of __GFP_ATOMIC.  Or at least
of ALLOC_HARDER...

Maybe __GFP_HIGH should get the memcg and watermark_boost benefits too? 

Given that we have ALLOC_HARDER and ALLOC_HIGH, it would seem to be
sensible to export those two settings in GFP_foo, and not forbid one of
them to be used with __GFP_DIRECT_RECLAIM.

> 
> > Too late to fix that now though I think.  Maybe the best way forward is
> > to discourage new uses of GFP_NOFAIL.  We would need a well-documented
> > replacement.
> 
> I am not sure what that should be. Really if the memory reserves
> behavior of GFP_NOFAIL is really problematic then let's just reap it
> out. I do not see a new nofail like flag is due.

Presumably there is a real risk of deadlock if we just remove the
memory-reserves boosts of __GFP_NOFAIL.  Maybe it would be safe to
replace all current users of __GFP_NOFAIL with __GFP_NOFAIL|__GFP_HIGH,
and then remove the __GFP_HIGH where analysis suggests there is no risk
of deadlocks.

Or maybe rename the __GFP_NOFAIL flag and #define __GFP_NOFAIL to
include __GFP_HIGH?

This would certainly be a better result than adding a new flag.

> 
> > > Anway as I've tried to explain earlier that this all is an
> > > implementation detail users of the flag shouldn't really care about. If
> > > this heuristic is not doing any good then it should be removed.
> > 
> > Maybe users shouldn't care about implementation details, but they do
> > need to care about semantics and costs.
> > We need to know when it is appropriate to use GFP_NOFAIL, and when it is
> > not.  And what alternatives there are when it is not appropriate.
> > Just saying "try to avoid using it" and "requires careful analysis"
> > isn't acceptable.  Sometimes it is unavoidable and analysis can only be
> > done with a clear understanding of costs.  Possibly analysis can only be
> > done with a clear understanding of the internal implementation details.
> 
> What we document currently is this
>  * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
>  * cannot handle allocation failures. The allocation could block
>  * indefinitely but will never return with failure. Testing for
>  * failure is pointless.

This implies it is incompatible with __GFP_NORETRY and (probably)
requires __GFP_RECLAIM.  That is worth documenting, and possibly also a
WARN_ON.

>  * New users should be evaluated carefully (and the flag should be
>  * used only when there is no reasonable failure policy) but it is
>  * definitely preferable to use the flag rather than opencode endless
>  * loop around allocator.

How do we perform this evaluation? And why is it preferable to a loop?
There are times when a loop makes sense, if there might be some other
event that could provide the needed memory ...  or if a SIGKILL might
make it irrelevant.
slab allocators presumably shouldn't pass __GFP_NOFAIL to alloc_page(),
but should instead loop around
  1/ check if any existing slabs have space
  2/ if not, try to allocate a new page
Providing the latter blocks for a while but not indefinitely that should
be optimal.
Why is __GFP_NOFAIL better?

>  * Using this flag for costly allocations is _highly_ discouraged.

This is unhelpful.  Saying something is "discouraged" carries an implied
threat.  This is open source and threats need to be open.
Why is it discouraged? IF it is not forbidden, then it is clearly
permitted.  Maybe there are costs  - so a clear statement of those costs
would be appropriate.
Also, what is a suitable alternative?

Current code will trigger a WARN_ON, so it is effectively forbidden.
Maybe we should document that __GFP_NOFAIL is forbidden for orders above
1, and that vmalloc() should be used instead (thanks for proposing that
patch!).

But that would mean __GFP_NOFAIL cannot be used for slabs which happen
to use large orders.
Hmmm.  it appears that slub.c disables __GFP_NOFAIL when it tries for a
large order allocation, and slob.c never tries large order allocations.
So this only affects slab.c.
xfs makes heavy use of kmem_cache_zalloc with __GFP_NOFAIL.  I wonder if
any of these slabs have large order with slab.c.

> 
> so we tell when to use it - aka no reasonable failure policy. We put
> some discouragind language there. There is some discouraging language
> for high order allocations. Maybe we should suggest an alternative
> there. It seems there are usecases for those as well so we should
> implement a proper NOFAIL kvmalloc and recommend it for that instead.

yes- suggest an alternative and also say what the tradeoffs are.

> 
> > > > It also points out that the scope API is highly deficient.
> > > > We can do GFP_NOFS via the scope API, but we can't
> > > > do anything else because *there is no scope API for other GFP
> > > > flags*.
> > > > 
> > > > Why don't we have a GFP_NOFAIL/__GFP_RETRY_FOREVER scope API?
> > > 
> > > NO{FS,IO} where first flags to start this approach. And I have to admit
> > > the experiment was much less successful then I hoped for. There are
> > > still thousands of direct NOFS users so for some reason defining scopes
> > > is not an easy thing to do.
> > 
> > I'm not certain your conclusion is valid.  It could be that defining
> > scopes is easy enough, but no one feels motivated to do it.
> > We need to do more than provide functionality.  We need to tell people. 
> > Repeatedly.  And advertise widely.  And propose patches to make use of
> > the functionality.  And... and... and...
> 
> Been there, done that for the low hanging fruit. Others were much more
> complex for me to follow up and I had other stuff on my table.

I have no doubt that is a slow and rather thankless task, with no real
payoff until it is complete.  It reminds me a bit of BKL removal and
64-bit time.  I think it is worth doing though.  Finding the balance
between letting it consume you and just giving up would be a challenge.

>  
> > I think changing to the scope API is a good change, but it is
> > conceptually a big change.  It needs to be driven.
> 
> Agreed.
> 
> > > I am not against NOFAIL scopes in principle but seeing the nofs
> > > "success" I am worried this will not go really well either and it is
> > > much more tricky as NOFAIL has much stronger requirements than NOFS.
> > > Just imagine how tricky this can be if you just call a library code
> > > that is not under your control within a NOFAIL scope. What if that
> > > library code decides to allocate (e.g. printk that would attempt to do
> > > an optimistic NOWAIT allocation).
> > 
> > __GFP_NOMEMALLOC holds a lesson worth learning here.  PF_MEMALLOC
> > effectively adds __GFP_MEMALLOC to all allocations, but some call sites
> > need to over-ride that because there are alternate strategies available.
> > This need-to-over-ride doesn't apply to NOFS or NOIO as that really is a
> > thread-wide state.  But MEMALLOC and NOFAIL are different.  Some call
> > sites can reasonably handle failure locally.
> > 
> > I imagine the scope-api would say something like "NO_ENOMEM".  i.e.
> > memory allocations can fail as long as ENOMEM is never returned.
> > Any caller that sets __GFP_RETRY_MAYFAIL or __GFP_NORETRY or maybe some
> > others which not be affected by the NO_ENOMEM scope.  But a plain
> > GFP_KERNEL would.
> > 
> > Introducing the scope api would be a good opportunity to drop the
> > priority boost and *just* block until success.  Priority boosts could
> > then be added (possibly as a scope) only where they are measurably needed.
> > 
> > I think we have 28 process flags in use.  So we can probably afford one
> > more for PF_MEMALLOC_NO_ENOMEM.  What other scope flags might be useful?
> > PF_MEMALLOC_BOOST which added __GFP_ATOMIC but not __GFP_MEMALLOC ??
> > PF_MEMALLOC_NORECLAIM ??
> 
> I dunno. PF_MEMALLOC and its GFP_$FOO counterparts are quite hard to
> wrap my head around. I have never liked thos much TBH and building more
> on top sounds like step backward. I might be wrong but this sounds like
> even more work than NOFS scopes.
>  
> > > > That
> > > > would save us a lot of bother in XFS. What about GFP_DIRECT_RECLAIM?
> > > > I'd really like to turn that off for allocations in the XFS
> > > > transaction commit path (as noted already in this thread) because
> > > > direct reclaim that can make no progress is actively harmful (as
> > > > noted already in this thread)
> > > 
> > > As always if you have reasonable usecases then it is best to bring them
> > > up on the MM list and we can discuss them.
> > 
> > We are on the MM lists now... let's discuss :-)
> 
> Sure we can but this thread is a mix of so many topics that finding
> something useful will turn to be hard from my past experience.

Unfortunately life is messy.  I just wanted to remove all
congestion_wait() calls.  But that lead to __GFP_NOFAIL and to scopes
allocation API, and there are still more twisty passages waiting.
Sometimes you don't know what topic will usefully start a constructive
thread until you've already figured out the answer :-(

> 
> > Dave: How would you feel about an effort to change xfs to stop using
> > GFP_NOFS, and to use memalloc_nofs_save/restore instead?
> 
> xfs is an example of a well behaved scope user. In fact the API has been
> largely based on xfs previous interface. There are still NOFS usesages
> in xfs which would be great to get rid of (e.g. the default mapping NOFS
> which was added due to lockdep false positives but that is unrelated).
> 
> > Having a major
> > filesystem make the transition would be a good test-case, and could be
> > used to motivate other filesystems to follow.
> > We could add and use memalloc_no_enomem_save() too.
> 
> ext has converted their transaction context to the scope API as well.
> There is still some explicit NOFS usage but I haven't checked details
> recently.

Of the directories in fs/,
  42 contain no mention of GFP_NOFS
  17 contain fewer than 10
The 10 with most frequent usage (including comments) are:

47 fs/afs/
48 fs/f2fs/
49 fs/nfs/
54 fs/dlm/
59 fs/ceph/
66 fs/ext4/
73 fs/ntfs3/
73 fs/ocfs2/
83 fs/ubifs/
231 fs/btrfs/

xfs is 28 - came in number 12.  Though there are 25 KM_NOFS
allocations, which would push it up to 7th place.

A few use GFP_NOIO - nfs(11) and f2fs(9) being the biggest users.
So clearly there is work to do
Maybe we could add something to checkpatch.pl to discourage the addition
of new GFP_NOFS usage.

There is a lot of stuff there.... the bits that are important to me are:

 - why is __GFP_NOFAIL preferred? It is a valuable convenience, but I
   don't see that it is necessary
 - is it reasonable to use __GFP_HIGH when looping if there is a risk of
   deadlock?
 - Will __GFP_DIRECT_RECLAIM always result in a delay before failure? In
   that case it should be safe to loop around allocations using
   __GFP_DIRECT_RECLAIM without needing congestion_wait() (so it can
   just be removed.

Thanks,
NeilBrown

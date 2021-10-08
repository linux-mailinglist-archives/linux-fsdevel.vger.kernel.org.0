Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319B34273D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 00:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbhJHWiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 18:38:52 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:33445 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243505AbhJHWiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:38:52 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 28688108AC6;
        Sat,  9 Oct 2021 09:36:50 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mYyTx-0042Ma-CL; Sat, 09 Oct 2021 09:36:49 +1100
Date:   Sat, 9 Oct 2021 09:36:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20211008223649.GJ54211@dread.disaster.area>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
 <163184741778.29351.16920832234899124642.stgit@noble.brown>
 <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
 <20211006231452.GF54211@dread.disaster.area>
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>
 <163364854551.31063.4377741712039731672@noble.neil.brown.name>
 <YV/31+qXwqEgaxJL@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV/31+qXwqEgaxJL@dhcp22.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6160c805
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=7-415B0cAAAA:8
        a=6S5xgBsxOMK7_jEV4OcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:48:39AM +0200, Michal Hocko wrote:
> On Fri 08-10-21 10:15:45, Neil Brown wrote:
> > On Thu, 07 Oct 2021, Michal Hocko wrote:
> > > On Thu 07-10-21 10:14:52, Dave Chinner wrote:
> > > > On Tue, Oct 05, 2021 at 02:27:45PM +0200, Vlastimil Babka wrote:
> > > > > On 10/5/21 13:09, Michal Hocko wrote:
> > > > > > On Tue 05-10-21 11:20:51, Vlastimil Babka wrote:
> > > > > > [...]
> > > > > >> > --- a/include/linux/gfp.h
> > > > > >> > +++ b/include/linux/gfp.h
> > > > > >> > @@ -209,7 +209,11 @@ struct vm_area_struct;
> > > > > >> >   * used only when there is no reasonable failure policy) but it is
> > > > > >> >   * definitely preferable to use the flag rather than opencode endless
> > > > > >> >   * loop around allocator.
> > > > > >> > - * Using this flag for costly allocations is _highly_ discouraged.
> > > > > >> > + * Use of this flag may lead to deadlocks if locks are held which would
> > > > > >> > + * be needed for memory reclaim, write-back, or the timely exit of a
> > > > > >> > + * process killed by the OOM-killer.  Dropping any locks not absolutely
> > > > > >> > + * needed is advisable before requesting a %__GFP_NOFAIL allocate.
> > > > > >> > + * Using this flag for costly allocations (order>1) is _highly_ discouraged.
> > > > > >> 
> > > > > >> We define costly as 3, not 1. But sure it's best to avoid even order>0 for
> > > > > >> __GFP_NOFAIL. Advising order>1 seems arbitrary though?
> > > > > > 
> > > > > > This is not completely arbitrary. We have a warning for any higher order
> > > > > > allocation.
> > > > > > rmqueue:
> > > > > > 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> > > > > 
> > > > > Oh, I missed that.
> > > > > 
> > > > > > I do agree that "Using this flag for higher order allocations is
> > > > > > _highly_ discouraged.
> > > > > 
> > > > > Well, with the warning in place this is effectively forbidden, not just
> > > > > discouraged.
> > > > 
> > > > Yup, especially as it doesn't obey __GFP_NOWARN.
> > > > 
> > > > See commit de2860f46362 ("mm: Add kvrealloc()") as a direct result
> > > > of unwittingly tripping over this warning when adding __GFP_NOFAIL
> > > > annotations to replace open coded high-order kmalloc loops that have
> > > > been in place for a couple of decades without issues.
> > > > 
> > > > Personally I think that the way __GFP_NOFAIL is first of all
> > > > recommended over open coded loops and then only later found to be
> > > > effectively forbidden and needing to be replaced with open coded
> > > > loops to be a complete mess.
> > > 
> > > Well, there are two things. Opencoding something that _can_ be replaced
> > > by __GFP_NOFAIL and those that cannot because the respective allocator
> > > doesn't really support that semantic. kvmalloc is explicit about that
> > > IIRC. If you have a better way to consolidate the documentation then I
> > > am all for it.
> > 
> > I think one thing that might help make the documentation better is to
> > explicitly state *why* __GFP_NOFAIL is better than a loop.
> > 
> > It occurs to me that
> >   while (!(p = kmalloc(sizeof(*p), GFP_KERNEL));
> > 
> > would behave much the same as adding __GFP_NOFAIL and dropping the
> > 'while'.  So why not? I certainly cannot see the need to add any delay
> > to this loop as kmalloc does a fair bit of sleeping when permitted.
> > 
> > I understand that __GFP_NOFAIL allows page_alloc to dip into reserves,
> > but Mel holds that up as a reason *not* to use __GFP_NOFAIL as it can
> > impact on other subsystems.
> 
> __GFP_NOFAIL usage is a risk on its own. It is a hard requirement that
> the allocator cannot back off.

No, "allocator cannot back off" isn't a hard requirement for most
GFP_NOFAIL uses. *Not failing the allocation* is the hard
requirement.

How long it takes for the allocation to actually succeed is
irrelevant to most callers, and given that we are replacing loops
that do

	while (!(p = kmalloc(sizeof(*p), GFP_KERNEL))

with __GFP_NOFAIL largely indicates that allocation *latency* and/or
deadlocks are not an issue here.

Indeed, if we deadlock in XFS because there is no memory available,
that is *not a problem kmalloc() should be trying to solve*. THe
problem is the caller being unable to handle allocation failure, so
if allocation cannot make progress, that needs to be fixed by the
caller getting rid of the unfailable allocation.

The fact is that we've had these loops in production code for a
couple of decades and these subsystems just aren't failing or
deadlocking with such loops. IOWs, we don't need __GFP_NOFAIL to dig
deep into reserves or drive the system to OOM killing - we just need
to it keep retrying the same allocation until it succeeds.

Put simply, we want "retry forever" semantics to match what
production kernels have been doing for the past couple of decades,
but all we've been given are "never fail" semantics that also do
something different and potentially much more problematic.

Do you see the difference here? __GFP_NOFAIL is not what we
need in the vast majority of cases where it is used. We don't want
the failing allocations to drive the machine hard into critical
reserves, we just want the allocation to -eventually succeed- and if
it doesn't, that's our problem to handle, not kmalloc()....

> So it has to absolutely everything to
> suceed. Whether it cheats and dips into reserves or not is a mere
> implementation detail and a subject to the specific implementation.

My point exactly: that's how the MM interprets __GFP_NOFAIL is supposed to
provide callers with. What we are trying to tell you is that the
semantics associated with __GFP_NOFAIL is not actually what we
require, and it's the current semantics of __GFP_NOFAIL that cause
all the "can't be applied consistently across the entire allocation
APIs" problems....

> > > > So, effectively, we have to open-code around kvmalloc() in
> > > > situations where failure is not an option. Even if we pass
> > > > __GFP_NOFAIL to __vmalloc(), it isn't guaranteed to succeed because
> > > > of the "we won't honor gfp flags passed to __vmalloc" semantics it
> > > > has.
> > > 
> > > yes vmalloc doesn't support nofail semantic and it is not really trivial
> > > to craft it there.

Yet retry-forever is trivial to implement across everything:

kvmalloc(size, gfp_mask)
{
	gfp_t	flags = gfp_mask & ~__GFP_RETRY_FOREVER;

	do {
		p = __kvmalloc(size, flags)
	} while (!p && (gfp_mask & __GFP_RETRY_FOREVER));

	return p;
}

That provides "allocation will eventually succeed" semantics just
fine, yes? It doesn't guarantee forwards progress or success, just
that *it won't fail*.

It should be obvious what the difference between "retry forever" and
__GFP_NOFAIL semantics are now, and why we don't actually want
__GFP_NOFAIL. We just want __GFP_RETRY_FOREVER semantics that can be
applied consistently across the entire allocation API regardless of
whatever other flags are passed into the allocation: don't return
until an allocation with the provided semantics succeeds.



> > > > Even the API constaints of kvmalloc() w.r.t. only doing the vmalloc
> > > > fallback if the gfp context is GFP_KERNEL - we already do GFP_NOFS
> > > > kvmalloc via memalloc_nofs_save/restore(), so this behavioural
> > > > restriction w.r.t. gfp flags just makes no sense at all.
> > > 
> > > GFP_NOFS (without using the scope API) has the same problem as NOFAIL in
> > > the vmalloc. Hence it is not supported. If you use the scope API then
> > > you can GFP_KERNEL for kvmalloc. This is clumsy but I am not sure how to
> > > define these conditions in a more sensible way. Special case NOFS if the
> > > scope api is in use? Why do you want an explicit NOFS then?

Exactly my point - this is clumsy and a total mess. I'm not asking
for an explicit GFP_NOFS, just pointing out that the documented
restrictions that "vmalloc can only do GFP_KERNEL allocations" is
completely wrong.

vmalloc()
{
	if (!(gfp_flags &  __GFP_FS))
		memalloc_nofs_save();
	p = __vmalloc(gfp_flags | GFP_KERNEL)
	if (!(gfp_flags &  __GFP_FS))
		memalloc_nofs_restore();
}

Yup, that's how simple it is to support GFP_NOFS support in
vmalloc().

This goes along with the argument that "it's impossible to do
GFP_NOFAIL with vmalloc" as I addressed above. These things are not
impossible, but we hide behind "we don't want people to use vmalloc"
as an excuse for having shitty behaviour whilst ignoring that
vmalloc is *heavily used* by core subsystems like filesystems
because they cannot rely on high order allocations succeeding....

It also points out that the scope API is highly deficient.
We can do GFP_NOFS via the scope API, but we can't
do anything else because *there is no scope API for other GFP
flags*.

Why don't we have a GFP_NOFAIL/__GFP_RETRY_FOREVER scope API? That
would save us a lot of bother in XFS. What about GFP_DIRECT_RECLAIM?
I'd really like to turn that off for allocations in the XFS
transaction commit path (as noted already in this thread) because
direct reclaim that can make no progress is actively harmful (as
noted already in this thread)

Like I said - this is more than just bad documentation - the problem
is that the whole allocation API is an inconsistent mess of control
mechanisms to begin with...

> > It would seem to make sense for kvmalloc to WARN_ON if it is passed
> > flags that does not allow it to use vmalloc.
> 
> vmalloc is certainly not the hottest path in the kernel so I wouldn't be
> opposed.

kvmalloc is most certainly becoming one of the hottest paths in XFS.
IOWs, arguments that "vmalloc is not a hot path" are simply invalid
these days because they are simply untrue. e.g. the profiles I
posted in this thread...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

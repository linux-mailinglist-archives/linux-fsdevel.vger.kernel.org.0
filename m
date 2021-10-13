Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD742B2AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 04:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbhJMCel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 22:34:41 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:35514 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233316AbhJMCel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 22:34:41 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 89ADC104FAB;
        Wed, 13 Oct 2021 13:32:32 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1maU4F-005boy-4E; Wed, 13 Oct 2021 13:32:31 +1100
Date:   Wed, 13 Oct 2021 13:32:31 +1100
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
Message-ID: <20211013023231.GV2361455@dread.disaster.area>
References: <163184741778.29351.16920832234899124642.stgit@noble.brown>
 <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
 <20211006231452.GF54211@dread.disaster.area>
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>
 <163364854551.31063.4377741712039731672@noble.neil.brown.name>
 <YV/31+qXwqEgaxJL@dhcp22.suse.cz>
 <20211008223649.GJ54211@dread.disaster.area>
 <YWQmsESyyiea0zle@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWQmsESyyiea0zle@dhcp22.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=61664544
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=7-415B0cAAAA:8
        a=neU_OqogJPR7JUYaiz0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 01:57:36PM +0200, Michal Hocko wrote:
> On Sat 09-10-21 09:36:49, Dave Chinner wrote:
> > On Fri, Oct 08, 2021 at 09:48:39AM +0200, Michal Hocko wrote:
> > > > > > Even the API constaints of kvmalloc() w.r.t. only doing the vmalloc
> > > > > > fallback if the gfp context is GFP_KERNEL - we already do GFP_NOFS
> > > > > > kvmalloc via memalloc_nofs_save/restore(), so this behavioural
> > > > > > restriction w.r.t. gfp flags just makes no sense at all.
> > > > > 
> > > > > GFP_NOFS (without using the scope API) has the same problem as NOFAIL in
> > > > > the vmalloc. Hence it is not supported. If you use the scope API then
> > > > > you can GFP_KERNEL for kvmalloc. This is clumsy but I am not sure how to
> > > > > define these conditions in a more sensible way. Special case NOFS if the
> > > > > scope api is in use? Why do you want an explicit NOFS then?
> > 
> > Exactly my point - this is clumsy and a total mess. I'm not asking
> > for an explicit GFP_NOFS, just pointing out that the documented
> > restrictions that "vmalloc can only do GFP_KERNEL allocations" is
> > completely wrong.
> > 
> > vmalloc()
> > {
> > 	if (!(gfp_flags &  __GFP_FS))
> > 		memalloc_nofs_save();
> > 	p = __vmalloc(gfp_flags | GFP_KERNEL)
> > 	if (!(gfp_flags &  __GFP_FS))
> > 		memalloc_nofs_restore();
> > }
> > 
> > Yup, that's how simple it is to support GFP_NOFS support in
> > vmalloc().
> 
> Yes, this would work from the functionality POV but it defeats the
> philosophy behind the scope API. Why would you even need this if the
> scope was defined by the caller of the allocator?

Who actually cares that vmalloc might be using the scoped API
internally to implement GFP_NOFS or GFP_NOIO? Nobody at all.
It is far more useful (and self documenting!) for one-off allocations
to pass a GFP_NOFS flag than it is to use a scope API...

> The initial hope was
> to get rid of the NOFS abuse that can be seen in many filesystems. All
> allocations from the scope would simply inherit the NOFS semantic so
> an explicit NOFS shouldn't be really necessary, right?

Yes, but I think you miss my point entirely: that the vmalloc
restrictions on what gfp flags can be passed without making it
entirely useless are completely arbitrary and non-sensical.

> > This goes along with the argument that "it's impossible to do
> > GFP_NOFAIL with vmalloc" as I addressed above. These things are not
> > impossible, but we hide behind "we don't want people to use vmalloc"
> > as an excuse for having shitty behaviour whilst ignoring that
> > vmalloc is *heavily used* by core subsystems like filesystems
> > because they cannot rely on high order allocations succeeding....
> 
> I do not think there is any reason to discourage anybody from using
> vmalloc these days. 32b is dying out and vmalloc space is no longer a
> very scarce resource.

We are still discouraged from doing high order allocations and
should only use pages directly. Not to mention that the API doesn't
make it simple to use vmalloc as a direct replacement for high order
kmalloc tends to discourage new users...

> > It also points out that the scope API is highly deficient.
> > We can do GFP_NOFS via the scope API, but we can't
> > do anything else because *there is no scope API for other GFP
> > flags*.
> > 
> > Why don't we have a GFP_NOFAIL/__GFP_RETRY_FOREVER scope API?
> 
> NO{FS,IO} where first flags to start this approach. And I have to admit
> the experiment was much less successful then I hoped for. There are
> still thousands of direct NOFS users so for some reason defining scopes
> is not an easy thing to do.
> 
> I am not against NOFAIL scopes in principle but seeing the nofs
> "success" I am worried this will not go really well either and it is
> much more tricky as NOFAIL has much stronger requirements than NOFS.
> Just imagine how tricky this can be if you just call a library code
> that is not under your control within a NOFAIL scope. What if that
> library code decides to allocate (e.g. printk that would attempt to do
> an optimistic NOWAIT allocation).

I already asked you that _exact_ question earlier in the thread
w.r.t.  kvmalloc(GFP_NOFAIL) using optimistic NOWAIT kmalloc
allocation. I asked you as a MM expert to define *and document* the
behaviour that should result, not turn around and use the fact that
it is undefined behaviour as a "this is too hard" excuse for not
changing anything.

THe fact is that the scope APIs are only really useful for certain
contexts where restrictions are set by higher level functionality.
For one-off allocation constraints the API sucks and we end up with
crap like this (found in btrfs):

                /*                                                               
                 * We're holding a transaction handle, so use a NOFS memory      
                 * allocation context to avoid deadlock if reclaim happens.      
                 */                                                              
                nofs_flag = memalloc_nofs_save();                                
                value = kmalloc(size, GFP_KERNEL);                               
                memalloc_nofs_restore(nofs_flag);                                

But also from btrfs, this pattern is repeated in several places:

        nofs_flag = memalloc_nofs_save();                                        
        ctx = kvmalloc(struct_size(ctx, chunks, num_chunks), GFP_KERNEL);        
        memalloc_nofs_restore(nofs_flag);                                        

This needs to use the scoped API because vmalloc doesn't support
GFP_NOFS. So the poor "vmalloc needs scoped API" pattern is bleeding
over into other code that doesn't have the problems vmalloc does. Do
you see how this leads to poorly written code now?

Or perhaps I should just point at ceph?

/*
 * kvmalloc() doesn't fall back to the vmalloc allocator unless flags are
 * compatible with (a superset of) GFP_KERNEL.  This is because while the
 * actual pages are allocated with the specified flags, the page table pages
 * are always allocated with GFP_KERNEL.
 *
 * ceph_kvmalloc() may be called with GFP_KERNEL, GFP_NOFS or GFP_NOIO.
 */
void *ceph_kvmalloc(size_t size, gfp_t flags)
{
        void *p;

        if ((flags & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS)) {
                p = kvmalloc(size, flags);
        } else if ((flags & (__GFP_IO | __GFP_FS)) == __GFP_IO) {
                unsigned int nofs_flag = memalloc_nofs_save();
                p = kvmalloc(size, GFP_KERNEL);
                memalloc_nofs_restore(nofs_flag);
        } else {
                unsigned int noio_flag = memalloc_noio_save();
                p = kvmalloc(size, GFP_KERNEL);
                memalloc_noio_restore(noio_flag);
        }

        return p;
}

IOWs, a large number of the users of the scope API simply make
[k]vmalloc() provide GFP_NOFS behaviour. ceph_kvmalloc() is pretty
much a wrapper that indicates how all vmalloc functions should
behave. Honour GFP_NOFS and GFP_NOIO by using the scope API
internally.

> > That
> > would save us a lot of bother in XFS. What about GFP_DIRECT_RECLAIM?
> > I'd really like to turn that off for allocations in the XFS
> > transaction commit path (as noted already in this thread) because
> > direct reclaim that can make no progress is actively harmful (as
> > noted already in this thread)
> 
> As always if you have reasonable usecases then it is best to bring them
> up on the MM list and we can discuss them.

They've been pointed out many times in the past, and I've pointed
them out again in this thread. Telling me to "bring them up on the
mm list" when that's exactly what I'm doing right now is not a
helpful response.

> > Like I said - this is more than just bad documentation - the problem
> > is that the whole allocation API is an inconsistent mess of control
> > mechanisms to begin with...
> 
> I am not going to disagree. There is a lot of historical baggage and
> it doesn't help that any change is really hard to review because this
> interface is used throughout the kernel. I have tried to change some
> most obvious inconsistencies and I can tell this has always been a
> frustrating experience with a very small "reward" in the end because
> there are so many other problems.

Technical debt in the mm APIs is something the mm developers need to
address, not the people who tell you it's a problem for them.
Telling the messenger "do my job for me because I find it too
frustrating to make progress myself" doesn't help anyone make
progress. If you find it frustrating trying to get mm code changed,
imagine what it feels like for someone on the outside asking for
relatively basic things like a consistent control API....

> That being said, I would more than love to have a consistent and well
> defined interface and if you want to spend a lot of time on that then be
> my guest.

My point exactly: saying "fix it yourself" is not a good response....

> > > > It would seem to make sense for kvmalloc to WARN_ON if it is passed
> > > > flags that does not allow it to use vmalloc.
> > > 
> > > vmalloc is certainly not the hottest path in the kernel so I wouldn't be
> > > opposed.
> > 
> > kvmalloc is most certainly becoming one of the hottest paths in XFS.
> > IOWs, arguments that "vmalloc is not a hot path" are simply invalid
> > these days because they are simply untrue. e.g. the profiles I
> > posted in this thread...
> 
> Is it such a hot path that a check for compatible flags would be visible
> in profiles though?

No, that doesn't even show up as noise - the overhead of global
spinlock contention and direct reclaim are the elephants that
profiles point to, not a couple of flag checks on function
parameters...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

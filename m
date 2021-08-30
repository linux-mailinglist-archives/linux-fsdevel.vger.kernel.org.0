Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2FB3FBE68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 23:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbhH3Vju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 17:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbhH3Vju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:39:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24640C061575;
        Mon, 30 Aug 2021 14:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BzSa/Xav9Mi+TvgtPf5PEb+bv34epRMNiJiGroKt5hY=; b=EQq8XZBvGzzaVQQkII1GFhV+pF
        ufb0CpPaLNxgkq6Mha4e+V9EJXlzyEJQ0oWc9SGriOEaAsfJ2YXNkelEtuh3YbQvn2QpYgnL/vDxx
        m7jZ2tbE/sVPY0MiysKVbrDfrJHW5oceX+95lE8gBJNtuP9HZmSMG9OFCS2s0T44VNl450KBGXjl5
        puy6m/J/PmS5td/fkbjQEMJpk47V3qH41/uBxAcq6ukNoG+dlWiS7cGEhen50Cs5xhChebaVQJz19
        poaL7o4VK7zhVHPRx0UcLdhntFcnr3KxuLJW8Dc+GMw0Pc0XvSIHIPzke2da9rmbEIbSu5mINQXTR
        u/x4xwrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKoyy-000YoT-QA; Mon, 30 Aug 2021 21:38:27 +0000
Date:   Mon, 30 Aug 2021 22:38:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YS1PzKLr2AWenbHF@casper.infradead.org>
References: <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia>
 <YSjxlNl9jeEX2Yff@cmpxchg.org>
 <YSkyjcX9Ih816mB9@casper.infradead.org>
 <YS0WR38gCSrd6r41@cmpxchg.org>
 <YS0h4cFhwYoW3MBI@casper.infradead.org>
 <YS0/GHBG15+2Mglk@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0/GHBG15+2Mglk@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 04:27:04PM -0400, Johannes Weiner wrote:
> Right, page tables only need a pfn. The struct page is for us to
> maintain additional state about the object.
> 
> For the objects that are subpage sized, we should be able to hold that
> state (shrinker lru linkage, referenced bit, dirtiness, ...) inside
> ad-hoc allocated descriptors.
> 
> Descriptors which could well be what struct folio {} is today, IMO. As
> long as it doesn't innately assume, or will assume, in the API the
> 1:1+ mapping to struct page that is inherent to the compound page.

Maybe this is where we fundamentally disagree.  I don't think there's
any point in *managing* memory in a different size from that in which it
is *allocated*.  There's no point in tracking dirtiness, LRU position,
locked, etc, etc in different units from allocation size.  The point of
tracking all these things is so we can allocate and free memory.  If
a 'cache descriptor' reaches the end of the LRU and should be reclaimed,
that's wasted effort in tracking if the rest of the 'cache descriptor'
is dirty and heavily in use.  So a 'cache descriptor' should always be
at least a 'struct page' in size (assuming you're using 'struct page'
to mean "the size of the smallest allocation unit from the page
allocator")

> > > > I genuinely don't understand.  We have five primary users of memory
> > > > in Linux (once we're in a steady state after boot):
> > > > 
> > > >  - Anonymous memory
> > > >  - File-backed memory
> > > >  - Slab
> > > >  - Network buffers
> > > >  - Page tables
> > > > 
> > > > The relative importance of each one very much depends on your workload.
> > > > Slab already uses medium order pages and can be made to use larger.
> > > > Folios should give us large allocations of file-backed memory and
> > > > eventually anonymous memory.  Network buffers seem to be headed towards
> > > > larger allocations too.  Page tables will need some more thought, but
> > > > once we're no longer interleaving file cache pages, anon pages and
> > > > page tables, they become less of a problem to deal with.
> > > > 
> > > > Once everybody's allocating order-4 pages, order-4 pages become easy
> > > > to allocate.  When everybody's allocating order-0 pages, order-4 pages
> > > > require the right 16 pages to come available, and that's really freaking
> > > > hard.
> > > 
> > > Well yes, once (and iff) everybody is doing that. But for the
> > > foreseeable future we're expecting to stay in a world where the
> > > *majority* of memory is in larger chunks, while we continue to see 4k
> > > cache entries, anon pages, and corresponding ptes, yes?
> > 
> > No.  4k page table entries are demanded by the architecture, and there's
> > little we can do about that.
> 
> I wasn't claiming otherwise..?

You snipped the part of my paragraph that made the 'No' make sense.
I'm agreeing that page tables will continue to be a problem, but
everything else (page cache, anon, networking, slab) I expect to be
using higher order allocations within the next year.

> > > The slab allocator has proven to be an excellent solution to this
> > > problem, because the mailing lists are not flooded with OOM reports
> > > where smaller allocations fragmented the 4k page space. And even large
> > > temporary slab explosions (inodes, dentries etc.) are usually pushed
> > > back with fairly reasonable CPU overhead.
> > 
> > You may not see the bug reports, but they exist.  Right now, we have
> > a service that is echoing 2 to drop_caches every hour on systems which
> > are lightly loaded, otherwise the dcache swamps the entire machine and
> > takes hours or days to come back under control.
> 
> Sure, but compare that to the number of complaints about higher-order
> allocations failing or taking too long (THP in the fault path e.g.)...

Oh, we have those bug reports too ...

> Typegrouping isn't infallible for fighting fragmentation, but it seems
> to be good enough for most cases. Unlike the buddy allocator.

You keep saying that the buddy allocator isn't given enough information to
do any better, but I think it is.  Page cache and anon memory are marked
with GFP_MOVABLE.  Slab, network and page tables aren't.  Is there a
reason that isn't enough?

I think something that might actually help is if we added a pair of new
GFP flags, __GFP_FAST and __GFP_DENSE.  Dense allocations are those which
are expected to live for a long time, and so the page allocator should
try to group them with other dense allocations.  Slab and page tables
should use DENSE, along with things like superblocks, or fs bitmaps where
the speed of allocation is almost unimportant, but attempting to keep
them out of the way of other allocations is useful.  Fast allocations
are for allocations which should not live for very long.  The speed of
allocation dominates, and it's OK if the allocation gets in the way of
defragmentation for a while.

An example of another allocator that could care about DENSE vs FAST
would be vmalloc.  Today, it does:

        if (array_size > PAGE_SIZE) {
                area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
                                        area->caller);
        } else {
                area->pages = kmalloc_node(array_size, nested_gfp, node);
        }

That's actually pretty bad; if you have, say, a 768kB vmalloc space,
you need a 12kB array.  We currently allocate 16kB for the array, when we
could use alloc_pages_exact() to free the 4kB we're never going to use.
If this is GFP_DENSE, we know it's a long-lived allocation and we can
let somebody else use the extra 4kB.  If it's not, it's probably not
worth bothering with.

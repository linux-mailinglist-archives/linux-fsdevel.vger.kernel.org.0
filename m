Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E818E40F196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 07:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244834AbhIQF0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 01:26:11 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:51621 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229704AbhIQF0L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 01:26:11 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 83903108908;
        Fri, 17 Sep 2021 15:24:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mR6Ma-00DPVi-2v; Fri, 17 Sep 2021 15:24:40 +1000
Date:   Fri, 17 Sep 2021 15:24:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <20210917052440.GJ1756565@dread.disaster.area>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUN2vokEM8wgASk8@cmpxchg.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=07d9gI8wAAAA:8 a=7-415B0cAAAA:8
        a=9cucT3Egwqn4mvU-lKMA:9 a=CjuIK1q_8ugA:10 a=e2CUPOnPG4QKp8I52DXD:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 12:54:22PM -0400, Johannes Weiner wrote:
> On Wed, Sep 15, 2021 at 07:58:54PM -0700, Darrick J. Wong wrote:
> > On Wed, Sep 15, 2021 at 11:40:11AM -0400, Johannes Weiner wrote:
> > > On Fri, Sep 10, 2021 at 04:16:28PM -0400, Kent Overstreet wrote:
> The MM POV (and the justification for both the acks and the naks of
> the patchset) is that it's a generic, untyped compound page
> abstraction, which applies to file, anon, slab, networking
> pages. Certainly, the folio patches as of right now also convert anon
> page handling to the folio. If followed to its conclusion, the folio
> will have plenty of members and API functions for non-pagecache users
> and look pretty much like struct page today, just with a dynamic size.
> 
> I know Kent was surprised by this. I know Dave Chinner suggested to
> call it "cache page" or "cage" early on, which also suggests an
> understanding of a *dedicated* cache page descriptor.

Don't take a flippant I comment made in a bikeshed as any sort of
representation of what I think about this current situation. I've
largely been silent because of your history of yelling incoherently
in response to anything I say that you don't agree with.

But now you've explicitly drawn me into this discussion, I'll point
out that I'm one of very few people in the wider Linux mm/fs
community who has any *direct experience* with the cache handle
based architecture being advocated for here.

I don't agree with your assertion that cache handle based objects
are the way forward, so please read and try to understand what
I've just put a couple of hours into writing before you start
shouting. Please?

---

Ok, so this cache page descriptor/handle/object architecture has
been implemented in other operating systems.  It's the solution that
Irix implemented back in the early _1990s_ via it's chunk cache.

I've talked about this a few times in the past 15 years, so I guess
I'll talk about it again. eg at LSFMM 2014 where I said "we
don't really want to go down that path" in reference to supporting
sector sizes > PAGE_SIZE:

https://lwn.net/Articles/592101/

So, in more gory detail why I don't think we really want to go down
that path.....

The Irix chunk cache sat between the low layer global, disk address
indexed buffer cache[1] and the high layer per-mm-context page cache
used for mmap().

A "chunk" was a variable sized object indexed by file offset on a
per-inode AVL tree - basically the same caching architecture as our
current per-inode mapping tree uses to index pages. But unlike the
Linux page cache, these chunks were an extension of the low level
buffer cache. Hence they were also indexed by physical disk
address and the life-cycle was managed by the buffer cache shrinker
rather than the mm-based page cache reclaim algorithms.

Chunks were built from page cache pages, and pages pointed back to
the chunk that they belonged to. Chunks needed their own locking. IO
was done based on chunks, not pages. Filesystems decided the size of
chunks, not the page cache. Pages attached to chunks could be of any
hardware supported size - the only limitation was that all pages
attached to a chunk had to be the same size. A large hardware page
in the page cache could be mapped by multiple smaller chunks. A
chunk made up of multiple hardware pages could vmap it's contents if
the user needed contiguous access.[2]

Chunks were largely unaware of ongoing mmap operations. page faults
on pages that had no associated chunk (e.g. originally populated
into the page cache by a read fault into hole or a cached page that
the buffer cache had torn down) then a new chunk had to be built. 
The code needed to handle to partially populated chunks in this sort
of situation was really, really nasty as it required interacting
with the filesystem and having the filesystem take locks and call
back up into the page cache to build the new chunk in the IO path.

Similarly, dirty page state from page faults needed to be propagated
down to the chunks, because dirty tracking for writeback was done at
the chunk level, not the page cache level. This was *really* nasty,
because if the page didn't have a chunk already built, it couldn't
be built in a write fault context.  Hence sweeping dirty page state
to the IO subsystem was handled periodically by a pdflush daemon ,
which could work with the filesytsem to build new (dirty) chunks and
insert them into the chunk cache for writeback.

Similar problems will have to be considered during design for Linux
because the dirty tracking in Linux for writeback is done at the
per-inode mapping tree level. Hence things like ->page_mkwrite are
going to have to dig through the page to the cached chunk and mark
the chunk dirty rather than the page. Whether deadlocks are going to
have to be worked around is an open question; I don't have answers
to these concerns because nobody is proposing an architecture
detailed enough to explore these situations.

This also leads to really interesting questions about how page and
chunk state w.r.t. IO is kept coherent.  e.g. if we are not tracking
IO state on individual page cache pages, how do we ensure all the
pages stay stable when IO is being done to a block device that
requires stable pages? Along similar lines: what's the interlock
mechanism that we'll use to ensure that IO or truncate can lock out
per-page accesses if the filesystem IO paths no longer directly
interact with page state any more? I also wonder how will we manage
cached chunks if the filesystem currently relies on page level
locking for atomicity, concurrency and existence guarantees (e.g.
ext4 buffered IO)?

IOWs, it is extremely likely that there will still be situations
where we have to blast directly through the cache handle abstraction
to manipulate the objects behind the abstraction so that we can make
specific functionality work correctly, without regressions and/or
efficiently.

Hence the biggest issue that a chunk-like cache handle introduces
is the complex multi-dimensional state update interactions. These will
require more complex locking and that locking will be required to
work in arbitrary orders for operations to be performed safely and
atomically. e.g IO needs inode->chunk->page order, whilst page
migration/comapction needs page->chunk->inode order. Page migration
and compaction on Irix had some unfixable deadlocks in rare corner
cases because of locking inversion problems between filesystems,
chunks, pages and mm contexts. I don't see any fundamental
difference in Linux architecture that makes me think that it will
be any different.[3]

I've got war chest full of chunk cache related data corruption bugs
on Irix that were crazy hard to reproduce and even more difficult to
fix. At least half the bugs I had to fix in the chunk cache over
3-4 years as maintainer were data corruption bugs resulting from
inconsistencies in multi-object state updates.

I've got a whole 'nother barrel full of problem cases that revolve
around memory reclaim, too. The cache handles really need to pin the
pages that back them, and so we can't really do access optimised
per-page based reclaim of file-backed pages anymore.  The Irix chunk
cache had it's own LRUs and shrinker[4] to manage life-cycles of
chunks under memory pressure, and the mm code had it's own
independent page cache shrinker. Hence pages didn't get freed until
both the chunk cache and the page cache released the pages they had
references to.

IOWs, we're going to end up needing to reclaim cache handles before
we can do page reclaim. This needs careful thought and will likely
need a complete redesign of the vmscan.c algorithms to work
properly. I really, really don't want to see awful layer violations
like bufferhead reclaim getting hacked into the low layer page
reclaim algorithms happen ever again. We're still paying the price
for that.

And given the way Linux uses the mapping tree for keeping stuff like
per-page working set refault information after the pages have been
removed from the page cache, I really struggle to see how
functionality like this can be supported with a chunk based cache
index that doesn't actually have direct tracking of individual page
access and reclaim behaviour.

We're also going to need a range-based indexing mechanism for the
mapping tree if we want to avoid the inefficiencies that mapping
large objects into the Xarray require. We'll need an rcu-aware tree
of some kind, be it a btree, maple tree or something else so that we
can maintain lockless lookups of cache objects. That infrastructure
doesn't exist yet, either.

And on that note, it is worth keeping in mind that one of the
reasons that the current linux page cache architecture scales better
for single files than the Irix architecture ever did is because the
Irix chunk cache could not be made lockless. The requirements for
atomic multi-dimensional indexing updates and coherent, atomic
multi-object state changes could never be solved in a lockless
manner. It was not for lack of trying or talent; people way
smarter than me couldn't solve that problem. SO there's an open
question as to whether we can maintain existing lockless algorithms
when a chunk cache is layered over the top of the page cache.

IOWs, I see significant, fundamental problems that chunk cache
architectures suffer from. I know there are inherent problems with
state coherency, locking, complexity in the IO path, etc. Some of
these problems will inot be discovered until the implementation is
well under way. Some of these problem may well be unsolveable, too.
And until there's an actual model proposed of how everything will
interact and work, we can't actually do any of this architectural
analysis to determine if it might work or not. The chunk cache
proposal is really just a grand thought experiment at this point in
time.

OTOH, folios have none of these problems and are here right now.
Sure, they have their own issues, but we can see them for what they
are given the code is already out there, and pretty much everyone
sees them as a big step forwards.

Folios don't prevent a chunk cache from being implemented. In fact,
to make folios highly efficient, we have to do things a chunk cache
would also require to be implemented. e.g. range-based cache
indexing. Unlike a chunk cache, folios don't depend on this being
done first - they stand alone without those changes, and will only
improve from making them. IOWs, you can't use the "folios being
mapped 512 times into the mapping tree" as a reason the chunk cache
is better - the chunk cache also requires this same problem to be
solved, but the chunk cache needs efficient range lookups done
*before* it is implemented, not provided afterwards as an
optimisation.

IOWs, if we want to move towards a chunk cache, the first step is to
move to folios to allow large objects in the page cache. Then we can
implement a lock-less range based index mechanism for the mapping
tree. Then we can look to replace folios with a typed cache handle
without having to worry about all the whacky multi-object coherency
problems because they only need to point to a single folio. Then we
can work out all the memory reclaim issues, locking issues, sort out
the API that filesystems use instead of folios, etc that ineed to be
done when cache handles are introduced.  And once we've worked
through all that, then we can add support for multiple folios within
a single cache object and discover all the really hard problems that
this exposes. At this point, the cache objects are no longer
dependent on folios to provide objects > PAGE_SIZE to the
filesystems, and we can start to remove folios from the mm code and
replace them with something else that the cache handle uses to
provide the backing store to the filesysetms...

Seriously, I have given a lot of thought over the years to a chunk
cache for Linux. Right now, a chunk cache is a solution looking for
a problem to solve. Unless there's an overall architectural mm
plan that is being worked towards that requires a chunk cache, then
I just don't see the justification for doing all this work because
the first two steps above get filesystems everything they are
currently asking for. Everything else past that is really just an
experiment...

> I agree with what I think the filesystems want: instead of an untyped,
> variable-sized block of memory, I think we should have a typed page
> cache desciptor.

I don't think that's what fs devs want at all. It's what you think
fs devs want. If you'd been listening to us the same way that Willy
has been for the past year, maybe you'd have a different opinion.

Indeed, we don't actually need a new page cache abstraction.
fs/iomap already provides filesystems with a complete, efficient
page cache abstraction that only requires filesytems to provide
block mapping services. Filesystems using iomap do not interact with
the page cache at all. And David Howells is working with Willy and
all the network fs devs to build an equivalent generic netfs page
cache abstraction based on folios that is supported by the major
netfs client implementations in the kernel.

IOWs, fs devs don't need a new page cache abstraction - we've got
our own abstractions tailored directly to our needs. What we need
are API cleanups, consistency in object access mechanisms and
dynamic object size support to simplify and fill out the feature set
of the abstractions we've already built.

The fact that so many fs developers are pushing *hard* for folios is
that it provides what we've been asking for individually over last
few years. Willy has done a great job of working with the fs
developers and getting feedback at every step of the process, and
you see that in the amount of work that in progress that is already
based on folios. ANd it provides those cleanups and new
functionality without changing or invalidating any of the knowledge
we collectively hold about how the page cache works. That's _pure
gold_ right there.

In summary:

If you don't know anything about the architecture and limitations of
the XFS buffer cache (also read the footnotes), you'd do very well
to pay heed to what I've said in this email considering the direct
relevancy it's history has to the alternative cache handle proposal
being made here.  We also need to consider the evidence that
filesystems do not actually need a new page cache abstraction - they
just need the existing page cache to be able to index objects larger
than PAGE_SIZE.

So with all that in mind, I consider folios (or whatever we call
them) to be the best stepping stone towards a PAGE_SIZE indepedent
future that we currently have. folios don't prevent us from
introducing a cache handle based architecture if we have a
compelling reason to do so in the future, nor do they stop anyone
working on such infrastructure in parallel if it really is
necessary. But the reality is that we don't need such a fundamental
architectural change to provide the functionality that folios
provide us with _right now_.

Folios are not perfect, but they are here and they solve many issues
we need solved. We're never going to have a perfect solution that
everyone agrees with, so the real question is "are folios good
enough?". To me the answer is a resounding yes.

Cheers,

Dave.

[1] fs/xfs/xfs_buf.c is an example of a high performance handle
based, variable object size cache that abstracts away the details of
the data store being allocated from slab, discontiguous pages,
contiguous pages or [2] vmapped memory. It is basically two decade
old re-implementation of the Irix low layer global disk-addressed
buffer cache, modernised and tailored directly to the needs of XFS
metadata caching.

[3] Keep in mind that the xfs_buf cache used to be page cache
backed. The page cache provided the caching and memory reclaim
infrastructure to the xfs_buf handles - and so we do actually have
recent direct experience on Linux with the architecture you are
proposing here. This architecture proved to be a major limitation
from a performance, multi-object state coherency and cache residency
prioritisation aspects. It really sucked with systems that had 64KB
page sizes and 4kB metadata block sizes, and ....

[4] So we went back to the old Irix way of managing the cache - our
own buffer based LRUs and aging mechanisms, with memory reclaim run
by a shrinkers based on buffer-type base priorities. We use bulk
page allocation for buffers that >= PAGE_SIZE, and slab allocation <
PAGE_SIZE. That's exactly what you are suggesting we do with 2MB
sized base pages, but without having to care about mmap() at all.

-- 
Dave Chinner
david@fromorbit.com

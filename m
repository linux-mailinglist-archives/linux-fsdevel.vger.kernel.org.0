Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7212845056
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 01:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFMX4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 19:56:31 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:36296 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbfFMX4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:56:31 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id BA4F33DD573;
        Fri, 14 Jun 2019 09:56:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hbZYy-0004TE-N2; Fri, 14 Jun 2019 09:55:24 +1000
Date:   Fri, 14 Jun 2019 09:55:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
Message-ID: <20190613235524.GK14363@dread.disaster.area>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel>
 <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613183625.GA28171@kmo-pixel>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=LKujGtbL0NNE4ZLgYmkA:9 a=mFbICs-dwuItUDgk:21
        a=WMtmk-cKf8VlWF7L:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 02:36:25PM -0400, Kent Overstreet wrote:
> On Thu, Jun 13, 2019 at 09:02:24AM +1000, Dave Chinner wrote:
> > On Wed, Jun 12, 2019 at 12:21:44PM -0400, Kent Overstreet wrote:
> > > Ok, I'm totally on board with returning EDEADLOCK.
> > > 
> > > Question: Would we be ok with returning EDEADLOCK for any IO where the buffer is
> > > in the same address space as the file being read/written to, even if the buffer
> > > and the IO don't technically overlap?
> > 
> > I'd say that depends on the lock granularity. For a range lock,
> > we'd be able to do the IO for non-overlapping ranges. For a normal
> > mutex or rwsem, then we risk deadlock if the page fault triggers on
> > the same address space host as we already have locked for IO. That's
> > the case we currently handle with the second IO lock in XFS, ext4,
> > btrfs, etc (XFS_MMAPLOCK_* in XFS).
> > 
> > One of the reasons I'm looking at range locks for XFS is to get rid
> > of the need for this second mmap lock, as there is no reason for it
> > existing if we can lock ranges and EDEADLOCK inside page faults and
> > return errors.
> 
> My concern is that range locks are going to turn out to be both more complicated
> and heavier weight, performance wise, than the approach I've taken of just a
> single lock per address space.

That's the battle I'm fighting at the moment with them for direct
IO(*), but range locks are something I'm doing for XFS and I don't
really care if anyone else wants to use them or not.

(*)Direct IO on XFS is a pure shared lock workload, so the rwsem
scales until single atomic update cache line bouncing limits
throughput. That means I can max out my hardware at 1.6 million
random 4k read/write IOPS (a bit over 6GB/s)(**) to a single file
with a rwsem at 32 AIO+DIO dispatch threads. I've only got range
locks to about 1.1M IOPS on the same workload, though it's within a
couple of percent of a rwsem up to 16 threads...

(**) A small handful of nvme SSDs fed by AIO+DIO are /way faster/
than pmem that is emulated with RAM, let alone real pmem which is
much slower at random writes than RAM.

> Reason being range locks only help when you've got multiple operations going on
> simultaneously that don't conflict - i.e. it's really only going to be useful
> for applications that are doing buffered IO and direct IO simultaneously to the
> same file.

Yes, they do that, but that's not why I'm looking at this.  Range
locks are primarily for applications that mix multiple different
types of operations to the same file concurrently. e.g:

- fallocate and read/write() can be run concurrently if they
don't overlap, but right now we serialise them because we have no
visibility into what other operations require.

- buffered read and buffered write can run concurrently if they
don't overlap, but right now they are serialised because that's the
only way to provide POSIX atomic write vs read semantics (only XFS
provides userspace with that guarantee).

- Sub-block direct IO is serialised against all other direct IO
because we can't tell if it overlaps with some other direct IO and
so we have to take the slow but safe option - range locks solve that
problem, too.

- there's inode_dio_wait() for DIO truncate serialisation
because AIO doesn't hold inode locks across IO - range locks can be
held all the way to AIO completion so we can get rid of
inode_Dio_wait() in XFS and that allows truncate/fallocate to run
concurrently with non-overlapping direct IO.

- holding non-overlapping range locks on either side of page
faults which then gets rid of the need for the special mmap locking
path to serialise it against invalidation operations.

IOWs, range locks for IO solve a bunch of long term problems we have
in XFS and largely simplify the lock algorithms within the
filesystem. And it puts us on the path to introduce range locks for
extent mapping serialisation, allowing concurrent mapping lookups
and allocation within a single file. It also has the potential to
allow us to do concurrent directory modifications....

> Personally, I think that would be a pretty gross thing to do and I'm
> not particularly interested in optimizing for that case myself... but, if you
> know of applications that do depend on that I might change my opinion. If not, I
> want to try and get the simpler, one-lock-per-address space approach to work.
> 
> That said though - range locks on the page cache can be viewed as just a
> performance optimization over my approach, they've got the same semantics
> (locking a subset of the page cache vs. the entire thing). So that's a bit of a
> digression.

IO range locks are not "locking the page cache". IO range locks are
purely for managing concurrent IO state in a fine grained manner.
The page cache already has it's own locking - that just needs to
nest inside IO range locks as teh io locks are what provide the high
level exclusion from overlapping page cache operations...

> > > This would simplify things a lot and eliminate a really nasty corner case - page
> > > faults trigger readahead. Even if the buffer and the direct IO don't overlap,
> > > readahead can pull in pages that do overlap with the dio.
> > 
> > Page cache readahead needs to be moved under the filesystem IO
> > locks. There was a recent thread about how readahead can race with
> > hole punching and other fallocate() operations because page cache
> > readahead bypasses the filesystem IO locks used to serialise page
> > cache invalidation.
> > 
> > e.g. Readahead can be directed by userspace via fadvise, so we now
> > have file->f_op->fadvise() so that filesystems can lock the inode
> > before calling generic_fadvise() such that page cache instantiation
> > and readahead dispatch can be serialised against page cache
> > invalidation. I have a patch for XFS sitting around somewhere that
> > implements the ->fadvise method.
> 
> I just puked a little in my mouth.

Yeah, it's pretty gross. But the page cache simply isn't designed to
allow atomic range operations to be performed. We ahven't be able to
drag it out of the 1980s - we wrote the fs/iomap.c code so we could
do range based extent mapping for IOs rather than the horrible,
inefficient page-by-page block mapping the generic page cache code
does - that gave us a 30+% increase in buffered IO throughput
because we only do a single mapping lookup per IO rather than one
per page...

That said, the page cache is still far, far slower than direct IO,
and the gap is just getting wider and wider as nvme SSDs get faster
and faster. PCIe 4 SSDs are just going to make this even more
obvious - it's getting to the point where the only reason for having
a page cache is to support mmap() and cheap systems with spinning
rust storage.

> > I think there are some other patches floating around to address the
> > other readahead mechanisms to only be done under filesytem IO locks,
> > but I haven't had time to dig into it any further. Readahead from
> > page faults most definitely needs to be under the MMAPLOCK at
> > least so it serialises against fallocate()...
> 
> So I think there's two different approaches we should distinguish between. We
> can either add the locking to all the top level IO paths - what you just
> described - or, the locking can be pushed down to protect _only_ adding pages to
> the page cache, which is the approach I've been taking.

I'm don't think just serialising adding pages is sufficient for
filesystems like XFS because, e.g., DAX.

> I think both approaches are workable, but I do think that pushing the locking
> down to __add_to_page_cache_locked is fundamentally the better, more correct
> approach.
> 
>  - It better matches the semantics of what we're trying to do. All these
>    operations we're trying to protect - dio, fallocate, truncate - they all have
>    in common that they just want to shoot down a range of the page cache and
>    keep it from being readded. And in general, it's better to have locks that
>    protect specific data structures ("adding to this radix tree"), vs. large
>    critical sections ("the io path").

I disagree :)

The high level IO locks provide the IO concurrency policy for the
filesystem. The page cache is an internal structure for caching
pages - it is not a structure for efficiently and cleanly
implementing IO concurrency policy. That's the mistake the current
page cache architecture makes - it tries to be the central control
for all the filesystem IO (because filesystems are dumb and the page
cache knows best!) but, unfortunately, this does not provide the
semantics or functionality that all filesystems want and/or need.

Just look at the truncate detection mess we have every time we
lookup and lock a page anywhere in the mm/ code - do you see any
code in all that which detects a hole punch race? Nope, you don't
because the filesystems take responsibility for serialising that
functionality. Unfortunately, we have so much legacy filesystem
cruft we'll never get rid of those truncate hacks.

That's my beef with relying on the page cache - the page cache is
rapidly becoming a legacy structure that only serves to slow modern
IO subsystems down. More and more we are going to bypass the page
cache and push/pull data via DMA directly into user buffers because
that's the only way we have enough CPU power in the systems to keep
the storage we have fully utilised.

That means, IMO, making the page cache central to solving an IO
concurrency problem is going the wrong way....

>    In bcachefs, at least for buffered IO I don't currently need any per-inode IO
>    locks, page granularity locks suffice, so I'd like to keep that - under the
>    theory that buffered IO to pages already in cache is more of a fast path than
>    faulting pages in.
> 
>  - If we go with the approach of using the filesystem IO locks, we need to be
>    really careful about auditing and adding assertions to make sure we've found
>    and fixed all the code paths that can potentially add pages to the page
>    cache. I didn't even know about the fadvise case, eesh.

Sure, but we've largely done that already. There aren't a lot of
places that add pages to the page cache.

>  - We still need to do something about the case where we're recursively faulting
>    pages back in, which means we need _something_ in place to even detect that
>    that's happening. Just trying to cover everything with the filesystem IO
>    locks isn't useful here.

Haven't we just addressed that with setting a current task lock
context and returning -EDEADLOCK?

> So to summarize - if we have locking specifically for adding pages to the page
> cache, we don't need to extend the filesystem IO locks to all these places, and
> we need something at that level anyways to handle recursive faults from gup()
> anyways.
> 
> The tricky part is that there's multiple places that want to call
> add_to_page_cache() while holding this pagecache_add_lock.
> 
>  - dio -> gup(): but, you had the idea of just returning -EDEADLOCK here which I
>    like way better than my recursive locking approach.
> 
>  - the other case is truncate/fpunch/etc - they make use of buffered IO to
>    handle operations that aren't page/block aligned.  But those look a lot more
>    tractable than dio, since they're calling find_get_page()/readpage() directly
>    instead of via gup(), and possibly they could be structured to not have to
>    truncate/punch the partial page while holding the pagecache_add_lock at all
>    (but that's going to be heavily filesystem dependent).

That sounds like it is going to be messy. :(

> One other tricky thing we need is a way to write out and then evict a page
> without allowing it to be redirtied - i.e. something that combines
> filemap_write_and_wait_range() with invalidate_inode_pages2_range(). Otherwise,
> a process continuously redirtying a page is going to make truncate/dio
> operations spin trying to shoot down the page cache - in bcachefs I'm currently
> taking pagecache_add_lock in write_begin and mkwrite to prevent this, but I
> really want to get rid of that. If we can get that combined
> write_and_invalidate() operation, then I think the locking will turn out fairly
> clean.

IMO, this isn't a page cache problem - this is a filesystem
operation vs page fault serialisation issue. Why? Because the
problem exists for DAX, and it doesn't add pages to the page cache
for mappings...

i.e.  We've already solved these problems with the same high level
IO locks that solve all the truncate, hole punch, etc issues for
both the page cache and DAX operation. i.e. The MMAPLOCK prevents
the PTE being re-dirtied across the entire filesystem operation, not
just the writeback and invalidation. The XFS flush+inval code
looks like this:

	xfs_ilock(ip, XFS_IOLOCK_EXCL);
	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
	xfs_flush_unmap_range(ip, offset, len);

	<do operation that requires invalidated page cache>
	<flush modifications if necessary>

	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
	xfs_iunlock(ip, XFS_IOLOCK_EXCL);

With range locks it looks like this;

	range_lock_init(&rl, offset, len);
	range_lock_write(&ip->i_iolock, &rl);
	xfs_flush_unmap_range(ip, offset, len);

	<do operation that requires invalidated page cache>
	<flush modified range if necessary>

	range_unlock_write(&ip->i_iolock, &rl);

---

In summary, I can see why the page cache add lock works well for
bcachefs, but on the other hand I can say that it really doesn't
match well for filesystems like XFS or for filesystems that
implement DAX and so may not be using the page cache at all...

Don't get me wrong - I'm not opposed to incuding page cache add
locking - I'm just saying that the problems it tries to address (and
ones it cannot address) are already largely solved in existing
filesystems. I suspect that if we do merge this code, whatever
locking is added would have to be optional....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

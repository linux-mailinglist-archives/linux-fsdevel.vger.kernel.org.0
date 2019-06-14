Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3F46561
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfFNRIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 13:08:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43643 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNRIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:08:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so3266685qtj.10;
        Fri, 14 Jun 2019 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/udZ+XKhmU+OszK8smPM8oGZk8QF4Cy4qCBY6y2RIjs=;
        b=Zg4GHicSH0SA67Lurj0dHJ8Aalf8qUYYteUtE1xCmNj19Qa1/k3S2EWPIlhNnER/p1
         kRPQFiS9Pwv+lxXxdP88geqRcOpOjYqSE3TU4edo6ju6PbnBhrM98/WOG54O5R04+WQC
         By2Mw3ZMEP19GgYHdVwERtogFy5q4ZzaFuPHQFW4fSgzJyg7LlrAdZe92nJrxm54bNbM
         QD43DkevfZexhbVGhYTAM1SxuPo9lSHoot+WmEgJggik05rfFaHQwMI04h+A9TlU7C9T
         /4FI48jVDpEmqe32gqDGCY3RtB4N3K9p5HL7CaWJbsKYrJGvW8lVxxFRlCfSchlVNajv
         /WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/udZ+XKhmU+OszK8smPM8oGZk8QF4Cy4qCBY6y2RIjs=;
        b=jSdsOXO2nsWABad0cfVLNkJ8pFEEJnZ4QsUjYPmuZ7okX58OBNcWLuSt27MXLnd1q+
         df56ZHK0hvCbVIl63gGwumh0qHL+IsDOkaNfBhOM8u2I56hsXxB9j5TDIhlbCkenFWh+
         SRhWnsmDklf7FAdndAWzWPIDg73PvZDLQQy9ngHTUzrdNYVTmuELsOgx3u9nDl7CvzqX
         EZok+79jRkrzeCz/0PudePtGWz0BimX8RPBE/+NwoUloV7GQ0S/kpCvhvq7dZ2p8is53
         5DBJPERCxG+s9osWQ1lFRmUNi60Ui42Mc/3pdoxlQ7MwykNWJA5ApYA6W85flp4fEHwj
         CuIw==
X-Gm-Message-State: APjAAAXp09tiHghiDd8vHciN2JhXWwA99te4Uv9U0mDNozr2K+ypjJEq
        aW7lAKCYB6HxQ18Pz4vIAw==
X-Google-Smtp-Source: APXvYqyYQmIgrFkFqFuc8FXidyVdqHNPFHGQ2/Xw7RvFkXqhU4kXZeBRb6Ky36ceLTfraSV1T72uhw==
X-Received: by 2002:a0c:8927:: with SMTP id 36mr9581015qvp.131.1560532123111;
        Fri, 14 Jun 2019 10:08:43 -0700 (PDT)
Received: from kmo-pixel ([69.5.123.9])
        by smtp.gmail.com with ESMTPSA id a21sm2164126qkg.47.2019.06.14.10.08.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 10:08:42 -0700 (PDT)
Date:   Fri, 14 Jun 2019 13:08:40 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <20190614170840.GA32023@kmo-pixel>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel>
 <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel>
 <20190613235524.GK14363@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613235524.GK14363@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 14, 2019 at 09:55:24AM +1000, Dave Chinner wrote:
> On Thu, Jun 13, 2019 at 02:36:25PM -0400, Kent Overstreet wrote:
> > On Thu, Jun 13, 2019 at 09:02:24AM +1000, Dave Chinner wrote:
> > > On Wed, Jun 12, 2019 at 12:21:44PM -0400, Kent Overstreet wrote:
> > > > Ok, I'm totally on board with returning EDEADLOCK.
> > > > 
> > > > Question: Would we be ok with returning EDEADLOCK for any IO where the buffer is
> > > > in the same address space as the file being read/written to, even if the buffer
> > > > and the IO don't technically overlap?
> > > 
> > > I'd say that depends on the lock granularity. For a range lock,
> > > we'd be able to do the IO for non-overlapping ranges. For a normal
> > > mutex or rwsem, then we risk deadlock if the page fault triggers on
> > > the same address space host as we already have locked for IO. That's
> > > the case we currently handle with the second IO lock in XFS, ext4,
> > > btrfs, etc (XFS_MMAPLOCK_* in XFS).
> > > 
> > > One of the reasons I'm looking at range locks for XFS is to get rid
> > > of the need for this second mmap lock, as there is no reason for it
> > > existing if we can lock ranges and EDEADLOCK inside page faults and
> > > return errors.
> > 
> > My concern is that range locks are going to turn out to be both more complicated
> > and heavier weight, performance wise, than the approach I've taken of just a
> > single lock per address space.
> 
> That's the battle I'm fighting at the moment with them for direct
> IO(*), but range locks are something I'm doing for XFS and I don't
> really care if anyone else wants to use them or not.

I'm not saying I won't use them :)

I just want to do the simple thing first, and then if range locks turn out well
I don't think it'll be hard to switch bcachefs to them. Or if the simple thing
turns out to be good enough, even better :)

> (*)Direct IO on XFS is a pure shared lock workload, so the rwsem
> scales until single atomic update cache line bouncing limits
> throughput. That means I can max out my hardware at 1.6 million
> random 4k read/write IOPS (a bit over 6GB/s)(**) to a single file
> with a rwsem at 32 AIO+DIO dispatch threads. I've only got range
> locks to about 1.1M IOPS on the same workload, though it's within a
> couple of percent of a rwsem up to 16 threads...
> 
> (**) A small handful of nvme SSDs fed by AIO+DIO are /way faster/
> than pmem that is emulated with RAM, let alone real pmem which is
> much slower at random writes than RAM.

So something I should mention is that I've been 

> 
> > Reason being range locks only help when you've got multiple operations going on
> > simultaneously that don't conflict - i.e. it's really only going to be useful
> > for applications that are doing buffered IO and direct IO simultaneously to the
> > same file.
> 
> Yes, they do that, but that's not why I'm looking at this.  Range
> locks are primarily for applications that mix multiple different
> types of operations to the same file concurrently. e.g:
> 
> - fallocate and read/write() can be run concurrently if they
> don't overlap, but right now we serialise them because we have no
> visibility into what other operations require.

True true. Have you ever seen this be an issue for real applications?

> - buffered read and buffered write can run concurrently if they
> don't overlap, but right now they are serialised because that's the
> only way to provide POSIX atomic write vs read semantics (only XFS
> provides userspace with that guarantee).

We already talked about this on IRC, but it's not the _only_ way - page locks
suffice if we lock all the pages for the read/write at once, and that's actually
a really good thing to for performance.

bcachefs doesn't currently provide any guarantees here, but since we already are
batching up the page operations for buffered writes (and I have patches to do so
for the buffered read path in filemap.c) I will tweak that slightly to provide
some sort of guarantee.

This is something I care about in bcachefs because I'm pretty sure I can make
both the buffered read and write paths work without taking any per inode locks -
so unrelated IOs to the same file won't be modifying at shared cachelines at
all. Haven't gotten around to it yet for the buffered write path, but it's on
the todo list.

> - Sub-block direct IO is serialised against all other direct IO
> because we can't tell if it overlaps with some other direct IO and
> so we have to take the slow but safe option - range locks solve that
> problem, too.

This feels like an internal filesystem implementation detail (not objecting,
just doesn't sound like something applicable outside xfs to me).
 
> - there's inode_dio_wait() for DIO truncate serialisation
> because AIO doesn't hold inode locks across IO - range locks can be
> held all the way to AIO completion so we can get rid of
> inode_Dio_wait() in XFS and that allows truncate/fallocate to run
> concurrently with non-overlapping direct IO.

getting rid of inode_dio_wait() and unifying that with other locking would be
great, for sure.

> - holding non-overlapping range locks on either side of page
> faults which then gets rid of the need for the special mmap locking
> path to serialise it against invalidation operations.
> 
> IOWs, range locks for IO solve a bunch of long term problems we have
> in XFS and largely simplify the lock algorithms within the
> filesystem. And it puts us on the path to introduce range locks for
> extent mapping serialisation, allowing concurrent mapping lookups
> and allocation within a single file. It also has the potential to
> allow us to do concurrent directory modifications....

*nod*

Don't take any of what I'm saying as arguing against range locks. They don't
seem _as_ useful to me for bcachefs because a lot of what you want them for I
can already do concurrently - but if they turn out to work better than my
pagecache add lock I'll happily switch to them later. I'm just reserving
judgement until I see them and get to play with them.

> IO range locks are not "locking the page cache". IO range locks are
> purely for managing concurrent IO state in a fine grained manner.
> The page cache already has it's own locking - that just needs to
> nest inside IO range locks as teh io locks are what provide the high
> level exclusion from overlapping page cache operations...

I suppose I worded it badly, my point was just that range locks can be viewed as
a superset of my pagecache add lock so switching to them would be an easy
conversion.

> > > > This would simplify things a lot and eliminate a really nasty corner case - page
> > > > faults trigger readahead. Even if the buffer and the direct IO don't overlap,
> > > > readahead can pull in pages that do overlap with the dio.
> > > 
> > > Page cache readahead needs to be moved under the filesystem IO
> > > locks. There was a recent thread about how readahead can race with
> > > hole punching and other fallocate() operations because page cache
> > > readahead bypasses the filesystem IO locks used to serialise page
> > > cache invalidation.
> > > 
> > > e.g. Readahead can be directed by userspace via fadvise, so we now
> > > have file->f_op->fadvise() so that filesystems can lock the inode
> > > before calling generic_fadvise() such that page cache instantiation
> > > and readahead dispatch can be serialised against page cache
> > > invalidation. I have a patch for XFS sitting around somewhere that
> > > implements the ->fadvise method.
> > 
> > I just puked a little in my mouth.
> 
> Yeah, it's pretty gross. But the page cache simply isn't designed to
> allow atomic range operations to be performed. We ahven't be able to
> drag it out of the 1980s - we wrote the fs/iomap.c code so we could
> do range based extent mapping for IOs rather than the horrible,
> inefficient page-by-page block mapping the generic page cache code
> does - that gave us a 30+% increase in buffered IO throughput
> because we only do a single mapping lookup per IO rather than one
> per page...

I don't think there's anything _fundamentally_ wrong with the pagecache design -
i.e. a radix tree of pages.

We do _badly_ need support for arbitrary power of 2 sized pages in the
pagecache (and it _really_ needs to be compound pages, not just hugepages - a
lot of the work that's been done that just adds if (hugepage) to page cache code
is FUCKING RETARDED) - the overhead of working with 4k pages has gotten to be
completely absurd. But AFAIK the radix tree/xarray side of that is done, what
needs to be fixed is all the stuff in e.g. filemap.c that assumes it's iterating
over fixed size pages - that code needs to be reworked to be more like iterating
over extents.

> That said, the page cache is still far, far slower than direct IO,
> and the gap is just getting wider and wider as nvme SSDs get faster
> and faster. PCIe 4 SSDs are just going to make this even more
> obvious - it's getting to the point where the only reason for having
> a page cache is to support mmap() and cheap systems with spinning
> rust storage.

It is true that buffered IO performance is _way_ behind direct IO performance
today in a lot of situations, but this is mostly due to the fact that we've
completely dropped the ball and it's 2019 and we're STILL DOING EVERYTHING 4k AT
A TIME.

> > I think both approaches are workable, but I do think that pushing the locking
> > down to __add_to_page_cache_locked is fundamentally the better, more correct
> > approach.
> > 
> >  - It better matches the semantics of what we're trying to do. All these
> >    operations we're trying to protect - dio, fallocate, truncate - they all have
> >    in common that they just want to shoot down a range of the page cache and
> >    keep it from being readded. And in general, it's better to have locks that
> >    protect specific data structures ("adding to this radix tree"), vs. large
> >    critical sections ("the io path").
> 
> I disagree :)
> 
> The high level IO locks provide the IO concurrency policy for the
> filesystem. The page cache is an internal structure for caching
> pages - it is not a structure for efficiently and cleanly
> implementing IO concurrency policy. That's the mistake the current
> page cache architecture makes - it tries to be the central control
> for all the filesystem IO (because filesystems are dumb and the page
> cache knows best!) but, unfortunately, this does not provide the
> semantics or functionality that all filesystems want and/or need.

We might be talking past each other a bit.

I think we both agree that there should be a separation of concerns w.r.t.
locking, and that hanging too much stuff off the page cache has been a mistake
in the past (e.g. buffer heads).

But that doesn't mean the page cache shouldn't have locking, just that that
locking should only protect the page cache, not other filesystem state.

I am _not_ arguing that this should replace filesystem IO path locks for other,
not page cache purposes.

> Just look at the truncate detection mess we have every time we
> lookup and lock a page anywhere in the mm/ code - do you see any
> code in all that which detects a hole punch race? Nope, you don't
> because the filesystems take responsibility for serialising that
> functionality.

Yeah, I know.

> Unfortunately, we have so much legacy filesystem cruft we'll never get rid of
> those truncate hacks.

Actually - I honestly think that this page cache add lock is simple and
straightforward enough to use that converting legacy filesystems to it wouldn't
be crazypants, and getting rid of all those hacks would be _awesome_. The legacy
filesystems tend to to implement the really crazy fallocate stuff, it's just
truncate that really has to be dealt with.

> Don't get me wrong - I'm not opposed to incuding page cache add
> locking - I'm just saying that the problems it tries to address (and
> ones it cannot address) are already largely solved in existing
> filesystems. I suspect that if we do merge this code, whatever
> locking is added would have to be optional....

That's certainly a fair point. There is more than one way to skin a cat.

Not sure "largely solved" is true though - solved in XFS yes, but these issues
have not been taken seriously in other filesystems up until pretty recently...

That said, I do think this will prove useful for non bcachefs filesystems at
some point. Like you alluded to, truncate synchronization is hot garbage in most
filesystems, and this would give us an easy way of improving that and possibly
getting rid of those truncate hacks in filemap.c.

And because (on the add side at least) this lock only needs to taken when adding
pages to the page cache, not when the pages needed are already present - in
bcachefs at least this is a key enabler for making buffered IO not modify any
per-inode cachelines in the fast path, and I think other filesystems could do
the same thing.

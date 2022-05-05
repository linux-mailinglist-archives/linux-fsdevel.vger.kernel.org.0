Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1100751B865
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245548AbiEEHJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 03:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiEEHJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 03:09:18 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE73922BC0
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 00:05:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E4E0E534578;
        Thu,  5 May 2022 17:05:36 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nmVYM-008E5b-Vq; Thu, 05 May 2022 17:05:35 +1000
Date:   Thu, 5 May 2022 17:05:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 00/10] Make O_SYNC writethrough
Message-ID: <20220505070534.GB1949718@dread.disaster.area>
References: <20220503064008.3682332-1-willy@infradead.org>
 <20220505045821.GA1949718@dread.disaster.area>
 <YnNbf9dPhJ3FiHzH@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnNbf9dPhJ3FiHzH@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62737741
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=3XtGqXo65XAlBLoekegA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 06:07:11AM +0100, Matthew Wilcox wrote:
> On Thu, May 05, 2022 at 02:58:21PM +1000, Dave Chinner wrote:
> > On Tue, May 03, 2022 at 07:39:58AM +0100, Matthew Wilcox (Oracle) wrote:
> > > This is very much in development and basically untested, but Damian
> > > started describing to me something that he wanted, and I told him he
> > > was asking for the wrong thing, and I already had this patch series
> > > in progress.  If someone wants to pick it up and make it mergable,
> > > that'd be grand.
> > 
> > That've very non-descriptive. Saying "someone wanted something, I said it's
> > wrong, so here's a patch series about something else" doesn't tell me anything
> > about the problem that Damien was trying to solve.
> 
> Sorry about that.  I was a bit jet-lagged when I wrote it.
> 
> > > The idea is that an O_SYNC write is always going to want to write, and
> > > we know that at the time we're storing into the page cache.  So for an
> > > otherwise clean folio, we can skip the part where we dirty the folio,
> > > find the dirty folios and wait for their writeback.
> > 
> > What exactly is this shortcut trying to optimise away? A bit of CPU
> > time?
> > 
> > O_SYNC is already a write-through operation - we just call
> > filemap_write_and_wait_range() once we've copied the data into the
> > page cache and dirtied the page. What does skipping the dirty page
> > step gain us?
> 
> Two things; the original reason I was doing this, and Damien's reason.
> 
> My reason: a small write to a large folio will cause the entire folio to
> be dirtied and written.

If that's a problem, then shouldn't we track sub-folio dirty
regions? Because normal non-O_SYNC buffered writes will still cause
this to happen...

> This is unnecessary with O_SYNC; we're about
> to force the write anyway; we may as well do the write of the part of
> the folio which is modified, and skip the whole dirtying step.

What happens when another part of the folio is concurrently dirtied?

What happens if the folio already has other parts of it under
writeback? How do we avoid and/or resolve concurent "partial folio
writeback" race conditions?

> Damien's reason: It's racy.  Somebody else (... even vmscan) could cause
> folios to be written out of order.  This matters for ZoneFS because
> writing a file out of order is Not Allowed.  He was looking at relaxing
> O_DIRECT, but I think what he really wants is a writethrough page cache.

Zonefs has other mechanisms to solve this. It already has the
inode_lock() to serialise all dio writes to a zone because they must
be append IOs. i.e. new writes must be located at the write pointer,
and the write pointer does not get incremented until the IO
has been submitted (for DIO+AIO) or completed (for non-AIO).

Hence for buffered writes, we have the same situation: once we have
sampled the zone write pointer to get the offset, we cannot start
another write until the current IO has been submitted.

Further, for zonefs, we cannot get another write to that page cache
page *ever*; we can only get reads from it. Hence page state really
doesn't matter at all - once there is data in the page cache page,
all that can happen is it can be invalidated but it cannot change
(ah, the beauties of write-once media!). Hence the dirty state is
completely meaningless from a coherency and integrity POV, as is the
writeback state.

IOWs, for zonefs we can already ignore the page dirtying and
writeback mechanisms fairly safely. Hence we could do something like
this in the zonefs buffered write path:

- lock the inode
- sample the write pointer to get the file offset
- instantiate a page cache folio at the given offset
- copy the data into the folio, mark it up to date.
- mark it as under writeback or lock the folio to keep reclaim away
- add the page cache folio to an iter_iov
- pass the iter_iov to the direct IO write path to submit the IO and
  wait for completion.
- clear the folio writeback state.
- move the write pointer
- unlock the inode

and that gets us writethrough O_SYNC buffered writes. In fact, I
think it may even work with async writes, too, just like the DIO
write path seems to work with AIO.

The best part about the above mechanism is that there is
almost no new iomap, page cache or direct IO functionality required
to do this. All the magic is all in the zonefs sequential zone write
path. Hence I don't see needing to substantially modify the iomap
buffered write path to do zonefs write-through....

> > > The biggest problem with all this is that iomap doesn't have the necessary
> > > information to cause extent allocation, so if you do an O_SYNC write
> > > to an extent which is HOLE or DELALLOC, we can't do this optimisation.
> > > Maybe that doesn't really matter for interesting applications.  I suspect
> > > it doesn't matter for ZoneFS.
> > 
> > This seems like a lot of complexity for only partial support. It
> > introduces races with page dirtying and cleaning, it likely has
> > interesting issues with all the VM dirty/writeback accounting
> > (because this series is using a completion path that expects the
> > submission path has done it's side of the accounting) and it only
> > works in certain preconditions are met.
> 
> If we want to have better O_SYNC support, I think we can improve those
> conditions.  For example, XFS could preallocate the blocks before calling
> into iomap.  Since it's an O_SYNC write, everything is already terrible.

Ugh, that's even worse.

Quite frankly, designing pure O_SYNC writethrough is a classic case
of not seeing the forest for the trees.  What we actually need is
*async* page cache write-through.

Ever wondered why you can only get 60-70k write IOPS out of buffered
writes? e.g untarring really large tarballs of small files always
end up at 60-70k write IOPS regardless of filesystem, how many
threads you break the writes up into, etc? io_uring buffered writes
won't save us here, either, because it's not the data ingest side
that limits performance. Yeah, it's the writeback side that limits
us.

There's a simple reason for that: the flusher thread becomes CPU
bound doing the writeback of hundreds of thousands of dirty inodes.

Writeback caching is a major bottleneck on high performance storage;
when your storage can do 6.5GB/s and buffered writes can only copy
into the page cache and flush to disk at 2GB/s (typically lower than
this!), writeback caching is robbing us of major amounts of
performance.

It's even worse with small files - the flusher thread becomes CPU
bound at 60-80k IOPS on XFS, ext4 and btrfs because block allocation
is an expensive operation. On a device with a couple of million IOPS
available, having the kernel top out at under 5% of it's capacity is
pretty bad.

However, if I do a hacky "writethrough" of small writes by calling
filemap_flush() in ->release() (i.e. when close is called after the
write), then multithreaded small file write workloads can push
*several hundred thousand* write IOPS to disk before I run out of
CPU.

Write-through enables submission concurrency for small IOs. It
avoids lots of page state management overehad for high data
throughput IO. That's where all the performance wins with high end
storage are - keeping the pipes full. Buffered writes stopped being
able to do that years ago, and modern PCIe4 SSDs have only made that
gulf wider again.

IOWs, what we actually need is a clean page cache write-through
model that doesn't have any nasty quirks or side effects. IOWs, I
think you are on the right conceptual path, just the wrong
architectural path.

My preference would be for the page cache write-through mode to be a
thin shim over the DIO write path. The DIO write path is a highly
concurrent async IO engine - it's designed to handle everything
AIO and io_uring can throw at it. Forget about "direct IO", just
treat it as a high concurrency, high throughput async IO engine.

Hence for page cache write-through, all we do is instantiate the
page cache page, lock it, copy the data into it and then pass it to
the direct IO write implementation to submit it and then unlock it
on completion.  There's nothing else we really need to do - the DIO
path already handles everything else.

And if we use page/folio locking for concurrency synchronisation of
write-through mode instead of an exclusive inode lock, the model
allows for concurrent, non-overlapping buffered writes to a single
inode, just like we have for direct IO. It also allows us to avoid
all dirty and writeback page cache and VM state/accounting
manipulations. ANd by using the page/folio lock we avoid racing
state transitions until the write-through op is complete.

Sure, if there is an existing dirty folio in the page cache, then
punt it down the existing buffered IO path - something else is
already using write-back caching for this folio (e.g. mmap), so we
don't want to deal with trying to change modes.

But otherwise, we don't want to go near the normal buffered write
paths - they are all optimised for *write back* caching.  From an IO
and filesystem allocation optimisation perspective, page-cache
write-through IO is exactly the same as direct IO writes.  Hence we
ireally want page cache write-through to use the same allocator
paths and optimisations as the direct IO path, not the existing
buffered write path.

This sort of setup will get write-through buffered writes close to
the throughput of what direct IO is capable of on modern storage. It
won't quite match it, because DIO is zero copy and buffered IO is
copy-once, but it'll get a *lot* closer than it does now....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F915BDA17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 04:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiITCYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 22:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiITCYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:24:43 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC8752198;
        Mon, 19 Sep 2022 19:24:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-183-60.pa.nsw.optusnet.com.au [49.180.183.60])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id DFD521100A0C;
        Tue, 20 Sep 2022 12:24:39 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oaSwB-009pkO-5K; Tue, 20 Sep 2022 12:24:39 +1000
Date:   Tue, 20 Sep 2022 12:24:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw
 workload
Message-ID: <20220920022439.GP3600936@dread.disaster.area>
References: <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan>
 <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan>
 <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
 <CAOQ4uxguwnx4AxXqp_zjg39ZUaTGJEM2wNUPnNdtiqV2Q9woqA@mail.gmail.com>
 <YyH61deSiW1TnY//@magnolia>
 <CAOQ4uxhFJWW-ykyzomHCUWfWvbJNEmetw0G5mUYjFGoYJBb7NA@mail.gmail.com>
 <YyIR4XmDYkYIK2ad@magnolia>
 <20220919230947.GM3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919230947.GM3600936@dread.disaster.area>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=63292468
        a=mj5ET7k2jFntY++HerHxfg==:117 a=mj5ET7k2jFntY++HerHxfg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=FzvLjUrc44N2CQQ84gcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:09:47AM +1000, Dave Chinner wrote:
> On Wed, Sep 14, 2022 at 10:39:45AM -0700, Darrick J. Wong wrote:
> > On Wed, Sep 14, 2022 at 07:29:15PM +0300, Amir Goldstein wrote:
> > > > > Dave, Christoph,
> > > > >
> > > > > I know that you said that changing the atomic buffered read semantics
> > > > > is out of the question and that you also objected to a mount option
> > > > > (which nobody will know how to use) and I accept that.
> > > > >
> > > > > Given that a performant range locks implementation is not something
> > > > > trivial to accomplish (Dave please correct me if I am wrong),
> > > > > and given the massive performance impact of XFS_IOLOCK_SHARED
> > > > > on this workload,
> > > > > what do you think about POSIX_FADV_TORN_RW that a specific
> > > > > application can use to opt-out of atomic buffer read semantics?
> > > > >
> > > > > The specific application that I want to modify to use this hint is Samba.
> > > > > Samba uses IO threads by default to issue pread/pwrite on the server
> > > > > for IO requested by the SMB client. The IO size is normally larger than
> > > > > xfs block size and the range may not be block aligned.
> > > > >
> > > > > The SMB protocol has explicit byte range locks and the server implements
> > > > > them, so it is pretty safe to assume that a client that did not request
> > > > > range locks does not need xfs to do the implicit range locking for it.

That doesn't cover concurrent local (server side) access to the
file. It's not uncommon to have the same filesystems exported by
both Samba and NFS at the same time, and the only point of
co-ordination between the two is the underlying local filesystem....

IOWs, when we are talking about local filesystem behaviour, what a
network protocol does above the filesystem is largely irrelevant to
the synchronisation required within the filesystem
implementation....

> > > > > For this reason and because of the huge performance win,
> > > > > I would like to implement POSIX_FADV_TORN_RW in xfs and
> > > > > have Samba try to set this hint when supported.
> > > > >
> > > > > It is very much possible that NFSv4 servers (user and kennel)
> > > > > would also want to set this hint for very similar reasons.
> > > > >
> > > > > Thoughts?
> > > >
> > > > How about range locks for i_rwsem and invalidate_lock?  That could
> > > > reduce contention on VM farms, though I can only assume that, given that
> > > > I don't have a reference implementation to play with...
> > > >
> > > 
> > > If you are asking if I have the bandwidth to work on range lock
> > > then the answer is that I do not.
> > > 
> > > IIRC, Dave had a WIP and ran some benchmarks with range locks,
> > > but I do not know at which state that work is.
> > 
> > Yeah, that's what I was getting at -- I really wish Dave would post that
> > as an RFC.  The last time I talked to him about it, he was worried that
> > the extra complexity of the range lock structure would lead to more
> > memory traffic and overhead.
> 
> The reason I haven't posted it is that I don't think range locks can
> ever be made to perform and scale as we need for the IO path.

[snip range lock scalability and perf issues]

As I just discussed on #xfs with Darrick, there are other options
we can persue here.

The first question we need to ask ourselves is this: what are we
protecting against with exclusive buffered write behaviour?

The answer is that we know there are custom enterprise database
applications out there that assume that 8-16kB buffered writes are
atomic. I wish I could say these are legacy applications these days,
but they aren't - they are still in production use, and the
applications build on those custom database engines are still under
active development and use.

AFAIK, the 8kB atomic write behaviour is historical and came from
applications originally designed for Solaris and hardware that
had an 8kB page size. Hence buffered 8kB writes were assumed to be
the largest atomic write size that concurrent reads would not see
write tearing. These applications are now run on x86-64 boxes with
4kB page size, but they still assume that 8kB writes are atomic and
can't tear.

So, really, these days the atomic write behaviour of XFS is catering
for these small random read/write IO applications, not to provide
atomic writes for bulk data moving applications writing 2GB of data
per write() syscall. Hence we can fairly safely say that we really
only need "exclusive" buffered write locking for relatively small
multipage IOs, not huge IOs.

We can do single page shared buffered writes immediately - we
guarantee that while the folio is locked, a buffered read cannot
access the data until the folio is unlocked. So that could be the
first step to relaxing the exclusive locking requirement for
buffered writes.

Next we need to consider that we now have large folio support in the
page cache, which means we can treat contiguous file ranges larger
than a single page a single atomic unit if they are covered by a
multi-page folio. As such, if we have a single multi-page folio that
spans the entire write() range already in cache, we can run that
write atomically under a shared IO lock the same as we can do with
single page folios.

However, what happens if the folio is smaller than the range we need
to write? Well, in that case, we have to abort the shared lock write
and upgrade to an exclusive lock before trying again.

Of course, we can only determine if the write can go ahead once we
have the folio locked. That means we need a new non-blocking write
condition to be handled by the iomap code. We already have several
of them because of IOCB_NOWAIT semantics that io_uring requires for
buffered writes, so we are already well down the path of needing to
support fully non-blocking writes through iomap.

Further, the recent concurrent write data corruption that we
uncovered requires a new hook in the iomap write path to allow
writes to be aborted for remapping because the cached iomap has
become stale. This validity check can only be done once the folio
has locked - if the cached iomap is stale once we have the page
locked, then we have to back out and remap the write range and
re-run the write.

IOWs, we are going to have to add write retries to the iomap write
path for data integrity purposes. These checks must be done only
after the folio has been locked, so we really end up getting the
"can't do atomic write" retry infrastructure for free with the data
corruption fixes...

With this in place, it becomes trivial to support atomic writes with
shared locking all the way up to PMD sizes (or whatever the maximum
multipage folio size the arch supports is) with a minimal amount of
extra code.

At this point, we have a buffered write path that tries to do shared
locking first, and only falls back to exclusive locking if the page
cache doesn't contain a folio large enough to soak up the entire
write.

In future, Darrick suggested we might be able to do a "trygetlock a
bunch of folios" operation that locks a range of folios within the
current iomap in one go, and then we write into all of them in a
batch before unlocking them all. This would give us multi-folio
atomic writes with shared locking - this is much more complex, and
it's unclear that multi-folio write batching will gain us anything
over the single folio check described above...

Finally, for anything that is concurrently reading and writing lots
of data in chunks larger than PMD sizes, the application should
really be using DIO with AIO or io_uring. So falling back to
exclusive locking for such large single buffered write IOs doesn't
seem like a huge issue right now....

Thoughts?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

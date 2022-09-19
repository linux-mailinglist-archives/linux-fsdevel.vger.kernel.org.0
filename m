Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EADC5BD7D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 01:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiISXJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 19:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiISXJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:09:55 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DB7A6588;
        Mon, 19 Sep 2022 16:09:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-183-60.pa.nsw.optusnet.com.au [49.180.183.60])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CB9018A9C44;
        Tue, 20 Sep 2022 09:09:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oaPtb-009mXt-At; Tue, 20 Sep 2022 09:09:47 +1000
Date:   Tue, 20 Sep 2022 09:09:47 +1000
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
Message-ID: <20220919230947.GM3600936@dread.disaster.area>
References: <20220617151135.yc6vytge6hjabsuz@quack3>
 <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan>
 <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan>
 <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
 <CAOQ4uxguwnx4AxXqp_zjg39ZUaTGJEM2wNUPnNdtiqV2Q9woqA@mail.gmail.com>
 <YyH61deSiW1TnY//@magnolia>
 <CAOQ4uxhFJWW-ykyzomHCUWfWvbJNEmetw0G5mUYjFGoYJBb7NA@mail.gmail.com>
 <YyIR4XmDYkYIK2ad@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyIR4XmDYkYIK2ad@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6328f6bd
        a=mj5ET7k2jFntY++HerHxfg==:117 a=mj5ET7k2jFntY++HerHxfg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=9EkRCnL_sJbdCUU_ZCUA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:39:45AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 14, 2022 at 07:29:15PM +0300, Amir Goldstein wrote:
> > > > Dave, Christoph,
> > > >
> > > > I know that you said that changing the atomic buffered read semantics
> > > > is out of the question and that you also objected to a mount option
> > > > (which nobody will know how to use) and I accept that.
> > > >
> > > > Given that a performant range locks implementation is not something
> > > > trivial to accomplish (Dave please correct me if I am wrong),
> > > > and given the massive performance impact of XFS_IOLOCK_SHARED
> > > > on this workload,
> > > > what do you think about POSIX_FADV_TORN_RW that a specific
> > > > application can use to opt-out of atomic buffer read semantics?
> > > >
> > > > The specific application that I want to modify to use this hint is Samba.
> > > > Samba uses IO threads by default to issue pread/pwrite on the server
> > > > for IO requested by the SMB client. The IO size is normally larger than
> > > > xfs block size and the range may not be block aligned.
> > > >
> > > > The SMB protocol has explicit byte range locks and the server implements
> > > > them, so it is pretty safe to assume that a client that did not request
> > > > range locks does not need xfs to do the implicit range locking for it.
> > > >
> > > > For this reason and because of the huge performance win,
> > > > I would like to implement POSIX_FADV_TORN_RW in xfs and
> > > > have Samba try to set this hint when supported.
> > > >
> > > > It is very much possible that NFSv4 servers (user and kennel)
> > > > would also want to set this hint for very similar reasons.
> > > >
> > > > Thoughts?
> > >
> > > How about range locks for i_rwsem and invalidate_lock?  That could
> > > reduce contention on VM farms, though I can only assume that, given that
> > > I don't have a reference implementation to play with...
> > >
> > 
> > If you are asking if I have the bandwidth to work on range lock
> > then the answer is that I do not.
> > 
> > IIRC, Dave had a WIP and ran some benchmarks with range locks,
> > but I do not know at which state that work is.
> 
> Yeah, that's what I was getting at -- I really wish Dave would post that
> as an RFC.  The last time I talked to him about it, he was worried that
> the extra complexity of the range lock structure would lead to more
> memory traffic and overhead.

The reason I haven't posted it is that I don't think range locks can
ever be made to perform and scale as we need for the IO path.

The problem with range locks is that the structure that tracks the
locked ranges needs locking itself, and that means taking an IO lock
is no longer just a single atomic operation - it's at least two
atomic ops (lock, unlock on a spin lock) and then a bunch of cache
misses while searching up the structure containing the range locks
looking for overlaps.

Hence a { range_lock(); range_unlock(); } pair is at minimum twice as
costly { down_read(); up_read(); } and that shows up dramatically
with direct IO. My test system (2s, 32p) handles about 3 million
atomic ops for a single cacheline across many CPUs before it breaks
down into cacheline contention and goes really slow.

That means I can run 1.6 million read/write DIO iops to a single
file on the test machine with shared rwsem locking (~3.2 million
atomic ops a second) but with range locks (assuming just atomic op
overhead) that drops to ~800k r/w DIO ops. The hardware IO capacity
is just over 1.7MIOPS...

In reality, this contended cacheline is not the limiting factor for
range locks - the limiting factor is the time it takes to run the
critical section inside that lock.  This was found with the mmap_sem
when it was converted to range locks - the cache misses doing
rb-tree pointer chasing with the spinlock held meant that the actual
range lock rate topped out at about 180k lock,unlock pairs per
second. i.e. an order of magnitude slower than a rwsem on this
machine.

Read this thread again:

https://lore.kernel.org/linux-xfs/20190416122240.GN29573@dread.disaster.area/

That's really the elephant in the range locking room: a range lock
with a locked search and update aglorithm can't scale beyond a
single CPU in it's critical section. It's a hard limit no matter how
many CPUs you have and how much concurrency the workload has - the
range lock has a single threaded critical section that results in a
hard computational limit on range lock operations.

Hence I was looking at using a novel OLC btree algorithm for storing
the range locks. The RCU-based OLC btree is largely lockless,
allowing conconcurrent search, insert and delete operations on range
based index. I've largely got the OLC btree to work, but that simply
exposed a further problem that range locks need to handle.

That is, the biggest problem for scaling range lock performance is
that locking is mostly singleton operation - very few workloads
actually use concurrent access to a single file and hence need
multiple range locks held at once. As a result, the typical
concurrent IO range lock workload results in a single node btree,
and so all lookups, inserts and remove hammer the seqlocks on a
single node and we end up contending on a single cache line again.
Comared to a rwsem, we consume a lot more CPU overhead before we
detect a change has occurred and we need to go around and try again.

That said, it's better than previous range lock implementations in
that it gets up to about 400-450k mixed DIO and buffered iops, but
it is still way, way down on using a shared rwsem or serialising at
a page granularity via page locks.

Yes, I know there are many advantages to range locking. Because we
can exclude specific ranges, operations like truncate, fallocate,
buffered writes, etc can all run concurrently with reads. DIO can
run perfectly coherently with buffered IO (mmap is still a
problem!). We can extend files without having to serialise against
other IO within the existing EOF. We can pass lock contexts with AIO
so that the inode can be unlocked at completion and we can get rid
of the nasty inode_dio_wait() stuff we have for synchronisation with
DIO. And so on.

IOWs, while there are many upsides to range locking the reality is
that single file IO performance will not scale to storage hardware
capability any more. I have few thoughts on how range locking could
be further optimised to avoid such overheads in the cases where
range locking is not necessary, but I really don't think that the
scalability of a range lock will ever be sufficient to allow us to
track every IO we have in flight.

> I /know/ there are a lot of cloud vendors that would appreciate the
> speedup that range locking might provide.  I'm also fairly sure there
> are also people who want maximum single threaded iops and will /not/
> like range locks, but I think we ought to let kernel distributors choose
> which one they want.

Speedup for what operations? Not single file DIO, and only for mixed
buffered read/write. Perhaps for mixed fallocate/DIO workloads might
benefit, but I reluctantly came to the conclusion that there really
aren't many workloads that even a highly optimised rangelock would
actually end up improving performance for...

> Recently I've been playing around with static keys, because certain
> parts of xfs online fsck need to hook into libxfs.  The hooks have some
> overhead, so I'd want to reduce the cost of that to making the
> instruction prefetcher skip over a nop sled when fsck isn't running.
> I sorta suspect this is a way out -- the distributor selects a default
> locking implementation at kbuild time, and we allow a kernel command
> line parameter to switch (if desired) during early boot.  That only
> works if the compiler supports asm goto (iirc) but that's not /so/
> uncommon.

I think it's a lot harder than that. The range lock requires a
signification on-stack structure to be declared in the context that
the lock is being taken. i.e.:

+#define RANGE_LOCK_FULL                (LLONG_MAX)
+
+struct range_lock {
+       uint64_t                start;
+       uint64_t                end;
+       struct list_head        wait_list;
+#ifdef __KERNEL__
+       struct task_struct      *task;
+#else
+       pthread_cond_t          task;
+#endif
+};
+
+#define __RANGE_LOCK_INITIALIZER(__name, __start, __end) {             \
+               .start = (__start)                                      \
+               ,.end = (__end)                                         \
+               ,.wait_list = LIST_HEAD_INIT((__name).wait_list)        \
+       }
+
+#define DEFINE_RANGE_LOCK(name, start, end)                            \
+       struct range_lock name = __RANGE_LOCK_INITIALIZER((name), (start), (end))
+
+#define DEFINE_RANGE_LOCK_FULL(name)                                   \
+       struct range_lock name = __RANGE_LOCK_INITIALIZER((name), 0, RANGE_LOCK_FULL)


And code that uses it looks like:

+static inline void
+xfs_iolock_range_init(
+       struct xfs_inode        *ip,
+       struct range_lock       *rlock,
+       uint64_t                start,
+       uint64_t                count)
+{
+       int                     rounding;
+
+       rounding = max_t(int, i_blocksize(VFS_I(ip)), PAGE_SIZE);
+       range_lock_init(rlock, round_down(start, rounding),
+                               round_up(start + count, rounding));
+}
+
 STATIC ssize_t
 xfs_file_dio_read(
        struct kiocb            *iocb,
        struct iov_iter         *to)
 {
        struct xfs_inode        *ip = XFS_I(file_inode(iocb->ki_filp));
+       size_t                  count = iov_iter_count(to);
        ssize_t                 ret;
+       struct range_lock       rlock;

        trace_xfs_file_direct_read(iocb, to);

-       if (!iov_iter_count(to))
+       if (!count)
                return 0; /* skip atime */

        file_accessed(iocb->ki_filp);

-       ret = xfs_ilock_iocb(iocb, XFS_VFSLOCK_SHARED);
+       xfs_iolock_range_init(ip, &rlock, iocb->ki_pos, count);
+       ret = xfs_ilock_iocb(iocb, &rlock, XFS_VFSLOCK_SHARED);

Hence I don't think this is as simple as using static keys to switch
code paths as there's a whole lot more information that needs to be
set up for range locks compared to just using rwsems....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

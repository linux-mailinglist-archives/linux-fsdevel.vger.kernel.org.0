Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905EF63E74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 01:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfGIXs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 19:48:28 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:36398 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbfGIXs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 19:48:28 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id E64D43DC978;
        Wed, 10 Jul 2019 09:48:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hkzpI-0000zG-My; Wed, 10 Jul 2019 09:47:12 +1000
Date:   Wed, 10 Jul 2019 09:47:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Boaz Harrosh <openosd@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: pagecache locking
Message-ID: <20190709234712.GL7689@dread.disaster.area>
References: <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
 <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
 <20190617224714.GR14363@dread.disaster.area>
 <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
 <CAOQ4uxjqQjrCCt=ixgdUYjBJvKLhw4R9NeMZOB_s2rrWvoDMBw@mail.gmail.com>
 <20190619103838.GB32409@quack2.suse.cz>
 <20190619223756.GC26375@dread.disaster.area>
 <3f394239-f532-23eb-9ff1-465f7d1f3cb4@gmail.com>
 <20190705233157.GD7689@dread.disaster.area>
 <20190708133114.GC20507@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708133114.GC20507@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=rxuHOKLteiQnnr429Q0A:9 a=0n0zNvapn8EemG9u:21
        a=17OF_ookA9SLsmvY:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 03:31:14PM +0200, Jan Kara wrote:
> On Sat 06-07-19 09:31:57, Dave Chinner wrote:
> > On Wed, Jul 03, 2019 at 03:04:45AM +0300, Boaz Harrosh wrote:
> > > On 20/06/2019 01:37, Dave Chinner wrote:
> > > <>
> > > > 
> > > > I'd prefer it doesn't get lifted to the VFS because I'm planning on
> > > > getting rid of it in XFS with range locks. i.e. the XFS_MMAPLOCK is
> > > > likely to go away in the near term because a range lock can be
> > > > taken on either side of the mmap_sem in the page fault path.
> > > > 
> > > <>
> > > Sir Dave
> > > 
> > > Sorry if this was answered before. I am please very curious. In the zufs
> > > project I have an equivalent rw_MMAPLOCK that I _read_lock on page_faults.
> > > (Read & writes all take read-locks ...)
> > > The only reason I have it is because of lockdep actually.
> > > 
> > > Specifically for those xfstests that mmap a buffer then direct_IO in/out
> > > of that buffer from/to another file in the same FS or the same file.
> > > (For lockdep its the same case).
> > 
> > Which can deadlock if the same inode rwsem is taken on both sides of
> > the mmap_sem, as lockdep tells you...
> > 
> > > I would be perfectly happy to recursively _read_lock both from the top
> > > of the page_fault at the DIO path, and under in the page_fault. I'm
> > > _read_locking after all. But lockdep is hard to convince. So I stole the
> > > xfs idea of having an rw_MMAPLOCK. And grab yet another _write_lock at
> > > truncate/punch/clone time when all mapping traversal needs to stop for
> > > the destructive change to take place. (Allocations are done another way
> > > and are race safe with traversal)
> > > 
> > > How do you intend to address this problem with range-locks? ie recursively
> > > taking the same "lock"? because if not for the recursive-ity and lockdep I would
> > > not need the extra lock-object per inode.
> > 
> > As long as the IO ranges to the same file *don't overlap*, it should
> > be perfectly safe to take separate range locks (in read or write
> > mode) on either side of the mmap_sem as non-overlapping range locks
> > can be nested and will not self-deadlock.
> 
> I'd be really careful with nesting range locks. You can have nasty
> situations like:
> 
> Thread 1		Thread 2
> read_lock(0,1000)	
> 			write_lock(500,1500) -> blocks due to read lock
> read_lock(1001,1500) -> blocks due to write lock (or you have to break
>   fairness and then deal with starvation issues).
>
> So once you allow nesting of range locks, you have to very carefully define
> what is and what is not allowed.

Yes. I do understand the problem with rwsem read nesting and how
that can translate to reange locks.

That's why my range locks don't even try to block on other pending
waiters. The case where read nesting vs write might occur like above
is something like copy_file_range() vs truncate, but otherwise for
IO locks we simply don't have arbitrarily deep nesting of range
locks.

i.e. for your example my range lock would result in:

Thread 1		Thread 2
read_lock(0,1000)	
			write_lock(500,1500)
			<finds conflicting read lock>
			<marks read lock as having a write waiter>
			<parks on range lock wait list>
<...>
read_lock_nested(1001,1500)
<no overlapping range in tree>
<gets nested range lock>

<....>
read_unlock(1001,1500)	<stays blocked because nothing is waiting
		         on (1001,1500) so no wakeup>
<....>
read_unlock(0,1000)
<sees write waiter flag, runs wakeup>
			<gets woken>
			<retries write lock>
			<write lock gained>

IOWs, I'm not trying to complicate the range lock implementation
with complex stuff like waiter fairness or anti-starvation semantics
at this point in time. Waiters simply don't impact whether a new lock
can be gained or not, and hence the limitations of rwsem semantics
don't apply.

If such functionality is necessary (and I suspect it will be to
prevent AIO from delaying truncate and fallocate-like operations
indefinitely) then I'll add a "barrier" lock type (e.g.
range_lock_write_barrier()) that will block new range lock attempts
across it's span.

However, because this can cause deadlocks like the above, a barrier
lock will not block new *_lock_nested() or *_trylock() calls, hence
allowing runs of nested range locking to complete and drain without
deadlocking on a conflicting barrier range. And that still can't be
modelled by existing rwsem semantics....

> That's why in my range lock implementation
> ages back I've decided to treat range lock as a rwsem for deadlock
> verification purposes.

IMO, treating a range lock as a rwsem for deadlock purposes defeats
the purpose of adding range locks in the first place. The
concurrency models are completely different, and some of the
limitations on rwsems are a result of implementation choices rather
than limitations of a rwsem construct.

In reality I couldn't care less about what lockdep can or can't
verify. I've always said lockdep is a crutch for people who don't
understand locks and the concurrency model of the code they
maintain. That obviously extends to the fact that lockdep
verification limitations should not limit what we allow new locking
primitives to do.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

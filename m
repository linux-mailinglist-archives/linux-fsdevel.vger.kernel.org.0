Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50421416C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 10:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgARJ2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 04:28:47 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47614 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbgARJ2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 04:28:47 -0500
Received: from dread.disaster.area (pa49-181-172-170.pa.nsw.optusnet.com.au [49.181.172.170])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 96D4543FD14;
        Sat, 18 Jan 2020 20:28:39 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iskPG-0003Oh-RX; Sat, 18 Jan 2020 20:28:38 +1100
Date:   Sat, 18 Jan 2020 20:28:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200118092838.GB9407@dread.disaster.area>
References: <20200114161225.309792-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114161225.309792-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=IIEU8dkfCNxGYurWsojP/w==:117 a=IIEU8dkfCNxGYurWsojP/w==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=ITVTHrnrj4Og1yiqg0wA:9 a=CjuIK1q_8ugA:10
        a=igBNqPyMv6gA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 05:12:13PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> Asynchronous read/write operations currently use a rather magic locking
> scheme, were access to file data is normally protected using a rw_semaphore,
> but if we are doing aio where the syscall returns to userspace before the
> I/O has completed we also use an atomic_t to track the outstanding aio
> ops.  This scheme has lead to lots of subtle bugs in file systems where
> didn't wait to the count to reach zero, and due to its adhoc nature also
> means we have to serialize direct I/O writes that are smaller than the
> file system block size.
> 
> All this is solved by releasing i_rwsem only when the I/O has actually
> completed, but doings so is against to mantras of Linux locking primites:
> 
>  (1) no unlocking by another process than the one that acquired it
>  (2) no return to userspace with locks held
> 
> It actually happens we have various places that work around this.  A few
> callers do non-owner unlocks of rwsems, which are pretty nasty for
> PREEMPT_RT as the owner tracking doesn't work.  OTOH the file system
> freeze code has both problems and works around them a little better,
> although in a somewhat awkward way, in that it releases the lockdep
> object when returning to userspace, and reacquires it when done, and
> also clears the rwsem owner when returning to userspace, and then sets
> the new onwer before unlocking.
> 
> This series tries to follow that scheme, also it doesn't fully work.  The
> first issue is that the rwsem code has a bug where it doesn't properly
> handle clearing the owner.  This series has a patch to fix that, but it
> is ugly and might not be correct so some help is needed.  Second I/O
> completions often come from interrupt context, which means the re-acquire
> is recorded as from irq context, leading to warnings about incorrect
> contexts.  I wonder if we could just have a bit in lockdep that says
> returning to userspace is ok for this particular lock?  That would also
> clean up the fsfreeze situation a lot.
> 
> Let me know what you think of all this.  While I converted all the iomap
> using file systems only XFS is actually tested.

I think it's pretty gross, actually. It  makes the same mistake made
with locking in the old direct IO code - it encodes specific lock
operations via flags into random locations in the DIO path. This is
a very slippery slope, and IMO it is an layering violation to encode
specific filesystem locking smeantics into a layer that is supposed
to be generic and completely filesystem agnostic. i.e.  this
mechanism breaks if a filesystem moves to a different type of lock
(e.g. range locks), and history teaches us that we'll end up making
a horrible, unmaintainable mess to support different locking
mechanisms and contexts.

I think that we should be moving to a model where the filesystem
provides an unlock method in the iomap operations structure, and if
the method is present in iomap_dio_complete() it gets called for the
filesystem to unlock the inode at the appropriate point. This also
allows the filesystem to provide a different method for read or
write unlock, depending on what type of lock it held at submission.
This gets rid of the need for the iomap code to know what type of
lock the caller holds, too.

This way we always have a consistent point in the AIO/DIO completion
model where the inode gets unlocked, it only gets called for the IO
contexts where the filesystem wants/needs unlock on IO competion
semantics, and it's completely filesystem IO-lock implementation
agnostic. And for filesystems that use the inode i_rwsem, we can
just provide simple helper functions for their read/write unlock
methods.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

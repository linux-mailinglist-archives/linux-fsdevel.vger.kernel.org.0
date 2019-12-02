Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE810F31C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 00:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfLBXG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 18:06:26 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44607 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbfLBXG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:06:26 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 861A83A30BB;
        Tue,  3 Dec 2019 10:06:18 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ibulm-0006jy-5F; Tue, 03 Dec 2019 10:06:18 +1100
Date:   Tue, 3 Dec 2019 10:06:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rong Chen <rong.a.chen@intel.com>, Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191202230618.GI2695@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191128094003.752-1-hdanton@sina.com>
 <20191202090158.15016-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202090158.15016-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=vHaZCrEJwQDmUnyvPvAA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 02, 2019 at 05:01:58PM +0800, Hillf Danton wrote:
> 
> On Mon, 2 Dec 2019 14:08:44 +1100 Dave Chinner wrote:
> > On Thu, Nov 28, 2019 at 05:40:03PM +0800, Hillf Danton wrote:
> > > On Sat, 16 Nov 2019 10:40:05 Dave Chinner wrote:
> > > > Yeah, the fio task averages 13.4ms on any given CPU before being
> > > > switched to another CPU. Mind you, the stddev is 12ms, so the range
> > > > of how long it spends on any one CPU is pretty wide (330us to
> > > > 330ms).
> > > > 
> > > Hey Dave
> > > 
> > > > IOWs, this doesn't look like a workqueue problem at all - this looks
> > > 
> > > Surprised to see you're so sure it has little to do with wq,
> > 
> > Because I understand how the workqueue is used here.
> > 
> > Essentially, the workqueue is not necessary for a -pure- overwrite
> > where no metadata updates or end-of-io filesystem work is required.
> > 
> > However, change the workload just slightly, such as allocating the
> > space, writing into preallocated space (unwritten extents), using
> > AIO writes to extend the file, using O_DSYNC, etc, and we *must*
> > use a workqueue as we have to take blocking locks and/or run
> > transactions.
> > 
> > These may still be very short (e.g. updating inode size) and in most
> > cases will not block, but if they do, then if we don't move the work
> > out of the block layer completion context (i.e. softirq running the
> > block bh) then we risk deadlocking the code.
> > 
> > Not to mention none of the filesytem inode locks are irq safe.
> > 
> > IOWs, we can remove the workqueue for this -one specific instance-
> > but it does not remove the requirement for using a workqueue for all
> > the other types of write IO that pass through this code.
> > 
> So it's not true that it doesn't has anything to do with workqueue.

You misunderstood what I was saying. I meant that this adverse
schdeuler behaviour is not *unique to this specific workqueue
instance* or workload. There are another 5+ workqueues in XFS alone
that are based around the same "do all the deferred work on the same
CPU" queuing behaviour. Several of them are IO completion
processing workqueues, and it is designed this way to avoid running
completion work that access common structures across all the CPUs in
the system.

And, FWIW, we've had this "per-cpu delayed work" processing
mechanism in XFS since ~2002 when per-cpu work queues were
introduced in ~2.5.40. What we are doing with workqueues here is not
new or novel, and it's worked just fine for most of this time...

> > >  			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> > > -			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> > > +			schedule_work(&dio->aio.work);
> > 
> > This does nothing but change the workqueue from a per-sb wq to the
> > system wq. The work is still bound to the same CPU it is queued on,
> > so nothing will change.
> > 
> The system wq is enough here to make some visible difference as CFS will
> be looking to make new lb decision in particular when submitter and
> completion are running on different CPUs.

That's noise caused by slightly different loading of the system
workqueue vs a private work queue. It's likely just enough to move
the scheduler out of the window where it makes incorrect decisions.
i.e. Add a bit more user load or load onto other CPUs, and the
problem will reappear.

As I said, this is *not* a fix for the problem - it just moves it
around so that you can't see it for this specific workload instance.

> It's claimed that "Maintaining CPU affinity across dispatch and completion
> work has been proven to be a significant performance win." If completion
> is running in the softirq context then it would take some time to sort
> out why irq (not CPU) affinity is making difference across CPUs.

We use irq steering to provide CPU affinity for the structures being
used by completion because they are the same ones used by
submission. If completion happens quickly enough, those structures
are still hot in the cache of the submission CPU, and so we don't
drag bio and filesystem structures out of the CPU cache they sit in
by steering the completion to the submission CPU.

Most of the modern high perofrmance storage hardware has hardware
interrupt steering so the block layer doesn't have to do this. See
__blk_mq_complete_request() and __blk_complete_request(). If the
device has multiple hardware queues, they are already delivering CPU
affine completions. Otherwise __blk_complete_request() uses IPIs
to steer the completion to a CPU that shares a cache with the
submission CPU....

IOWs, we are trying to ensure that we run the data IO completion on
the CPU with that has that data hot in cache. When we are running
millions of IOs every second, this matters -a lot-. IRQ steering is
just a mechansim that is used to ensure completion processing hits
hot caches.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

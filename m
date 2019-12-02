Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3B10E4CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 04:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLBDIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 22:08:54 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57264 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727298AbfLBDIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 22:08:53 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6A26143FD51;
        Mon,  2 Dec 2019 14:08:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ibc4q-0008Aa-1R; Mon, 02 Dec 2019 14:08:44 +1100
Date:   Mon, 2 Dec 2019 14:08:44 +1100
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
Message-ID: <20191202030844.GD2695@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191128094003.752-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128094003.752-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=mzcwEs8pYe_3sm9skFEA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 28, 2019 at 05:40:03PM +0800, Hillf Danton wrote:
> On Sat, 16 Nov 2019 10:40:05 Dave Chinner wrote:
> > Yeah, the fio task averages 13.4ms on any given CPU before being
> > switched to another CPU. Mind you, the stddev is 12ms, so the range
> > of how long it spends on any one CPU is pretty wide (330us to
> > 330ms).
> > 
> Hey Dave
> 
> > IOWs, this doesn't look like a workqueue problem at all - this looks
> 
> Surprised to see you're so sure it has little to do with wq,

Because I understand how the workqueue is used here.

Essentially, the workqueue is not necessary for a -pure- overwrite
where no metadata updates or end-of-io filesystem work is required.

However, change the workload just slightly, such as allocating the
space, writing into preallocated space (unwritten extents), using
AIO writes to extend the file, using O_DSYNC, etc, and we *must*
use a workqueue as we have to take blocking locks and/or run
transactions.

These may still be very short (e.g. updating inode size) and in most
cases will not block, but if they do, then if we don't move the work
out of the block layer completion context (i.e. softirq running the
block bh) then we risk deadlocking the code.

Not to mention none of the filesytem inode locks are irq safe.

IOWs, we can remove the workqueue for this -one specific instance-
but it does not remove the requirement for using a workqueue for all
the other types of write IO that pass through this code.

> > like the scheduler is repeatedly making the wrong load balancing
> > decisions when mixing a very short runtime task (queued work) with a
> > long runtime task on the same CPU....
> > 
> and it helps more to know what is driving lb to make decisions like
> this.

I know exactly what is driving it through both observation and
understanding of the code, and I've explained it elsewhere
in this thread.

> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -157,10 +157,8 @@ static void iomap_dio_bio_end_io(struct
>  			WRITE_ONCE(dio->submit.waiter, NULL);
>  			blk_wake_io_task(waiter);
>  		} else if (dio->flags & IOMAP_DIO_WRITE) {
> -			struct inode *inode = file_inode(dio->iocb->ki_filp);
> -
>  			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> -			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> +			schedule_work(&dio->aio.work);

This does nothing but change the workqueue from a per-sb wq to the
system wq. The work is still bound to the same CPU it is queued on,
so nothing will change.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B1D10E4F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 05:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLBEDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 23:03:01 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47388 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727285AbfLBEDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 23:03:01 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C290243FB53;
        Mon,  2 Dec 2019 15:02:56 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ibcvI-0008VF-8f; Mon, 02 Dec 2019 15:02:56 +1100
Date:   Mon, 2 Dec 2019 15:02:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Hillf Danton <hdanton@sina.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Rong Chen <rong.a.chen@intel.com>, Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191202040256.GE2695@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191128094003.752-1-hdanton@sina.com>
 <CAKfTPtA23ErKGCEJVmg6vk-QoufkiUM3NbXd31mZmKnuwbTkFw@mail.gmail.com>
 <20191202024625.GD24512@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202024625.GD24512@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=QY18SFpNAAAA:8 a=7-415B0cAAAA:8 a=O3AchcIIkV7hgp5uPPkA:9
        a=VhM0DojlG1CNIegh:21 a=LWgaBQf-yoKGiJ_h:21 a=CjuIK1q_8ugA:10
        a=LYL6_n6_bXSRrjLcjcND:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 02, 2019 at 10:46:25AM +0800, Ming Lei wrote:
> On Thu, Nov 28, 2019 at 10:53:33AM +0100, Vincent Guittot wrote:
> > On Thu, 28 Nov 2019 at 10:40, Hillf Danton <hdanton@sina.com> wrote:
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -157,10 +157,8 @@ static void iomap_dio_bio_end_io(struct
> > >                         WRITE_ONCE(dio->submit.waiter, NULL);
> > >                         blk_wake_io_task(waiter);
> > >                 } else if (dio->flags & IOMAP_DIO_WRITE) {
> > > -                       struct inode *inode = file_inode(dio->iocb->ki_filp);
> > > -
> > >                         INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> > > -                       queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> > > +                       schedule_work(&dio->aio.work);
> > 
> > I'm not sure that this will make a real difference because it ends up
> > to call queue_work(system_wq, ...) and system_wq is bounded as well so
> > the work will still be pinned to a CPU
> > Using system_unbound_wq should make a difference because it doesn't
> > pin the work on a CPU
> >  +                       queue_work(system_unbound_wq, &dio->aio.work);
> 
> Indeed, just run a quick test on my KVM guest, looks the following patch
> makes a difference:
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 9329ced91f1d..2f4488b0ecec 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -613,7 +613,8 @@ int sb_init_dio_done_wq(struct super_block *sb)
>  {
>         struct workqueue_struct *old;
>         struct workqueue_struct *wq = alloc_workqueue("dio/%s",
> -                                                     WQ_MEM_RECLAIM, 0,
> +                                                     WQ_MEM_RECLAIM |
> +                                                     WQ_UNBOUND, 0,
>                                                       sb->s_id);

That's not an answer to the user task migration issue.

That is, all this patch does is trade user task migration when the
CPU is busy for migrating all the queued work off the CPU so the
user task does not get migrated. IOWs, this forces all the queued
work to be migrated rather than the user task. IOWs, it does not
address the issue we've exposed in the scheduler between tasks with
competing CPU affinity scheduling requirements - it just hides the
symptom.

Maintaining CPU affinity across dispatch and completion work has
been proven to be a significant performance win. Right throughout
the IO stack we try to keep this submitter/completion affinity,
and that's the whole point of using a bound wq in the first place:
efficient delayed batch processing of work on the local CPU.

Spewing deferred completion work across every idle CPU in the
machine because the local cpu is temporarily busy is a bad choice,
both from a performance perspective (dirty cacheline bouncing) and
from a power efficiency point of view as it causes CPUs to be taken
out of idle state much more frequently[*].

The fact that the scheduler migrates the user task we use workqueues
for deferred work as they were intended doesn't make this a
workqueue problem. If the answer to this problem is "make all IO
workqueues WQ_UNBOUND" then we are effectively saying "the scheduler
has unfixable problems when mixing bound and unbound work on the
same run queue".

And, besides, what happens when every other CPU is also completely
busy and can't run the work in a timely fashion? We've just moved
the work to some random CPU where we wait to be scheduled instead of
just sitting on the local CPU and waiting....

So, yes, we can work around the -symptoms- we see (frequent user
task migration) by changing the work queue configuration or
bypassing the workqueue for this specific workload. But these only
address the visible symptom and don't take into account the wider
goals of retaining CPU affinity in the IO stack, and they will have
variable scheduling latency and perofrmance and as the overall
system load changes.

So, we can fiddle with workqueues, but it doesn't address the
underlying issue that the scheduler appears to be migrating
non-bound tasks off a busy CPU too easily....

-Dave.

[*] Pay attention to the WQ_POWER_EFFICIENT definition for a work
queue: it's designed for interrupt routines that defer work via work
queues to avoid doing work on otherwise idle CPUs. It does this by
turning the per-cpu wq into an unbound wq so that work gets
scheduled on a non-idle CPUs in preference to the local idle CPU
which can then remain in low power states.

That's the exact opposite of what using WQ_UNBOUND ends up doing in
this IO completion context: it pushes the work out over idle CPUs
rather than keeping them confined on the already busy CPUs where CPU
affinity allows the work to be done quickly. So while WQ_UNBOUND
avoids the user task being migrated frequently, it results in the
work being spread around many more CPUs and we burn more power to do
the same work.

-- 
Dave Chinner
david@fromorbit.com

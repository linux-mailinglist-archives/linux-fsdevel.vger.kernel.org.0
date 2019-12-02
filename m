Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9127610F39D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 00:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLBXx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 18:53:28 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41335 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfLBXx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:53:27 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 60BD27E9A0F;
        Tue,  3 Dec 2019 10:53:23 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ibvVJ-0006vv-Nh; Tue, 03 Dec 2019 10:53:21 +1100
Date:   Tue, 3 Dec 2019 10:53:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Hillf Danton <hdanton@sina.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Rong Chen <rong.a.chen@intel.com>, Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191202235321.GJ2695@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191128094003.752-1-hdanton@sina.com>
 <CAKfTPtA23ErKGCEJVmg6vk-QoufkiUM3NbXd31mZmKnuwbTkFw@mail.gmail.com>
 <20191202024625.GD24512@ming.t460p>
 <20191202040256.GE2695@dread.disaster.area>
 <CAKfTPtD8Q97qJ_+hdCXQRt=gy7k96XrhnFmGYP1G88YSFW0vNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD8Q97qJ_+hdCXQRt=gy7k96XrhnFmGYP1G88YSFW0vNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=QY18SFpNAAAA:8 a=0-rSKxhP8GJoaAKyaOwA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22 a=LYL6_n6_bXSRrjLcjcND:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 02, 2019 at 02:45:42PM +0100, Vincent Guittot wrote:
> On Mon, 2 Dec 2019 at 05:02, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Dec 02, 2019 at 10:46:25AM +0800, Ming Lei wrote:
> > > On Thu, Nov 28, 2019 at 10:53:33AM +0100, Vincent Guittot wrote:
> > > > On Thu, 28 Nov 2019 at 10:40, Hillf Danton <hdanton@sina.com> wrote:
> > > > > --- a/fs/iomap/direct-io.c
> > > > > +++ b/fs/iomap/direct-io.c
> > > > > @@ -157,10 +157,8 @@ static void iomap_dio_bio_end_io(struct
> > > > >                         WRITE_ONCE(dio->submit.waiter, NULL);
> > > > >                         blk_wake_io_task(waiter);
> > > > >                 } else if (dio->flags & IOMAP_DIO_WRITE) {
> > > > > -                       struct inode *inode = file_inode(dio->iocb->ki_filp);
> > > > > -
> > > > >                         INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> > > > > -                       queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> > > > > +                       schedule_work(&dio->aio.work);
> > > >
> > > > I'm not sure that this will make a real difference because it ends up
> > > > to call queue_work(system_wq, ...) and system_wq is bounded as well so
> > > > the work will still be pinned to a CPU
> > > > Using system_unbound_wq should make a difference because it doesn't
> > > > pin the work on a CPU
> > > >  +                       queue_work(system_unbound_wq, &dio->aio.work);
> > >
> > > Indeed, just run a quick test on my KVM guest, looks the following patch
> > > makes a difference:
> > >
> > > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > > index 9329ced91f1d..2f4488b0ecec 100644
> > > --- a/fs/direct-io.c
> > > +++ b/fs/direct-io.c
> > > @@ -613,7 +613,8 @@ int sb_init_dio_done_wq(struct super_block *sb)
> > >  {
> > >         struct workqueue_struct *old;
> > >         struct workqueue_struct *wq = alloc_workqueue("dio/%s",
> > > -                                                     WQ_MEM_RECLAIM, 0,
> > > +                                                     WQ_MEM_RECLAIM |
> > > +                                                     WQ_UNBOUND, 0,
> > >                                                       sb->s_id);
> >
> > That's not an answer to the user task migration issue.
> >
> > That is, all this patch does is trade user task migration when the
> > CPU is busy for migrating all the queued work off the CPU so the
> > user task does not get migrated. IOWs, this forces all the queued
> > work to be migrated rather than the user task. IOWs, it does not
> > address the issue we've exposed in the scheduler between tasks with
> > competing CPU affinity scheduling requirements - it just hides the
> > symptom.
> >
> > Maintaining CPU affinity across dispatch and completion work has
> > been proven to be a significant performance win. Right throughout
> > the IO stack we try to keep this submitter/completion affinity,
> > and that's the whole point of using a bound wq in the first place:
> > efficient delayed batch processing of work on the local CPU.
> 
> Do you really want to target the same CPU ? looks like what you really
> want to target the same cache instead

Well, yes, ideally we want to target the same cache, but we can't do
that with workqueues.

However, the block layer already does that same-cache steering for
it's directed completions (see __blk_mq_complete_request()), so we
are *already running in a "hot cache" CPU context* when we queue
work. When we queue to the same CPU, we are simply maintaining the
"cache-hot" context that we are already running in.

Besides, selecting a specific "hot cache" CPU and bind the work to
that CPU (via queue_work_on()) doesn't fix the scheduler problem -
it just moves it to another CPU. If the destination CPU is loaded
like the local CPU, then it's jsut going to cause migrations on the
destination CPU instead of the local CPU.

IOWs, this is -not a fix- for the scheduler making an incorrect
migration decisions when we are mixing bound and unbound tasks on
the local run queue. Yes, it will hide the problem from this
specific workload instance but it doesn't fix it. We'll just hit it
under heavier load, such as when production workloads start running
AIO submission from tens of CPUs at a time while burning near 100%
CPU in userspace.......

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

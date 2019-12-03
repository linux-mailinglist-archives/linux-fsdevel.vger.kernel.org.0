Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0039610FEE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 14:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfLCNfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 08:35:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37189 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLCNe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:34:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so3857942lja.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2019 05:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kynqR1nbDFIkNKzP6Rkxf3MwtpXbGnrKe/XIiwd66B8=;
        b=ncYaZ0A+JzkeM+ueWb7Kifpkxut0gtLLA1cbU1CdBhq8424ouIPeYcI8VrlUIZi2HK
         ARuI9iS9mt9y1I2Wo0vzJ2wi8CrOnKV0UdWPOs1279yY+FtKokdBqoyts4c4cDI01F+i
         hlxmeVO07Cs7w6gy5eVtSxPZQzb7yoeadp4A2qQ2Uv3F4W7Wy7CU7vOPY3A4jLu/XE+R
         0re4qP/VHYbQ77R6oAx5r4E/U7/iTFiMyF/Muec79DsknnWcCLJ96uUmvv5gyjeC0Jdt
         joEACFNe/3rxV3zC1kHfAv6q+0T0vnLD3bAXlJ/3mIBP1UbDBFTkWAQt0l7++SyIbWZA
         G3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kynqR1nbDFIkNKzP6Rkxf3MwtpXbGnrKe/XIiwd66B8=;
        b=q5SshQYghjlr8idr5+KNkEfwQ9qq0TcHVmdR72ruCJeGAC5YhWZKBcfXDkT+caOlNO
         mf15RIVFuJL088iUuN50yTM2uQTl3DUCz2i9Qfubc+Y059aYRCb9tacgqER2g4tqvO++
         SFmhqShnb+XYDEeDCGiyg99sD3IhLzIOdjQgwZ9l4YMX8WhA4lqcxKtXyWtTQ9gWU3HB
         FVJbaRbu1wKZOmTDgnqf7eUaJgc///qe5f3tLWB8Xthje8APyHcrWEBJtJZQFxkFSXTX
         fRdxGXjro85+UmfVv6UpqyGZVMyKeWEaGuj8LbRqud1/R2raBT/PFEvnl/vlzOyiLUNG
         NdAg==
X-Gm-Message-State: APjAAAUb5vf+IwBYXer85IBefxUl/0UNoeX639dyd8ewI2rW98PmM3sK
        XLzUG3Hn0LEnnHRP+HbBeEueeL8dE8nrH0s6vMccUQ==
X-Google-Smtp-Source: APXvYqyfksBIvduXxfZXQ1244/HfjibHAUIU18bKSJ12ttxuchYS0O2dIXjWalUWt92xwMvRluPOyqvnjHwrfiIu7y0=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr1975431ljj.206.1575380094771;
 Tue, 03 Dec 2019 05:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20191114113153.GB4213@ming.t460p> <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p> <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p> <20191128094003.752-1-hdanton@sina.com>
 <CAKfTPtA23ErKGCEJVmg6vk-QoufkiUM3NbXd31mZmKnuwbTkFw@mail.gmail.com>
 <20191202024625.GD24512@ming.t460p> <20191202040256.GE2695@dread.disaster.area>
 <CAKfTPtD8Q97qJ_+hdCXQRt=gy7k96XrhnFmGYP1G88YSFW0vNA@mail.gmail.com> <20191202235321.GJ2695@dread.disaster.area>
In-Reply-To: <20191202235321.GJ2695@dread.disaster.area>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 3 Dec 2019 14:34:43 +0100
Message-ID: <CAKfTPtCX39HS5Qsqq4rjq=M_u25Wnu6xscmSbW=aEaqA6U-wLw@mail.gmail.com>
Subject: Re: single aio thread is migrated crazily by scheduler
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Hillf Danton <hdanton@sina.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Rong Chen <rong.a.chen@intel.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 3 Dec 2019 at 00:53, Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Dec 02, 2019 at 02:45:42PM +0100, Vincent Guittot wrote:
> > On Mon, 2 Dec 2019 at 05:02, Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Mon, Dec 02, 2019 at 10:46:25AM +0800, Ming Lei wrote:
> > > > On Thu, Nov 28, 2019 at 10:53:33AM +0100, Vincent Guittot wrote:
> > > > > On Thu, 28 Nov 2019 at 10:40, Hillf Danton <hdanton@sina.com> wrote:
> > > > > > --- a/fs/iomap/direct-io.c
> > > > > > +++ b/fs/iomap/direct-io.c
> > > > > > @@ -157,10 +157,8 @@ static void iomap_dio_bio_end_io(struct
> > > > > >                         WRITE_ONCE(dio->submit.waiter, NULL);
> > > > > >                         blk_wake_io_task(waiter);
> > > > > >                 } else if (dio->flags & IOMAP_DIO_WRITE) {
> > > > > > -                       struct inode *inode = file_inode(dio->iocb->ki_filp);
> > > > > > -
> > > > > >                         INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> > > > > > -                       queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> > > > > > +                       schedule_work(&dio->aio.work);
> > > > >
> > > > > I'm not sure that this will make a real difference because it ends up
> > > > > to call queue_work(system_wq, ...) and system_wq is bounded as well so
> > > > > the work will still be pinned to a CPU
> > > > > Using system_unbound_wq should make a difference because it doesn't
> > > > > pin the work on a CPU
> > > > >  +                       queue_work(system_unbound_wq, &dio->aio.work);
> > > >
> > > > Indeed, just run a quick test on my KVM guest, looks the following patch
> > > > makes a difference:
> > > >
> > > > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > > > index 9329ced91f1d..2f4488b0ecec 100644
> > > > --- a/fs/direct-io.c
> > > > +++ b/fs/direct-io.c
> > > > @@ -613,7 +613,8 @@ int sb_init_dio_done_wq(struct super_block *sb)
> > > >  {
> > > >         struct workqueue_struct *old;
> > > >         struct workqueue_struct *wq = alloc_workqueue("dio/%s",
> > > > -                                                     WQ_MEM_RECLAIM, 0,
> > > > +                                                     WQ_MEM_RECLAIM |
> > > > +                                                     WQ_UNBOUND, 0,
> > > >                                                       sb->s_id);
> > >
> > > That's not an answer to the user task migration issue.
> > >
> > > That is, all this patch does is trade user task migration when the
> > > CPU is busy for migrating all the queued work off the CPU so the
> > > user task does not get migrated. IOWs, this forces all the queued
> > > work to be migrated rather than the user task. IOWs, it does not
> > > address the issue we've exposed in the scheduler between tasks with
> > > competing CPU affinity scheduling requirements - it just hides the
> > > symptom.
> > >
> > > Maintaining CPU affinity across dispatch and completion work has
> > > been proven to be a significant performance win. Right throughout
> > > the IO stack we try to keep this submitter/completion affinity,
> > > and that's the whole point of using a bound wq in the first place:
> > > efficient delayed batch processing of work on the local CPU.
> >
> > Do you really want to target the same CPU ? looks like what you really
> > want to target the same cache instead
>
> Well, yes, ideally we want to target the same cache, but we can't do
> that with workqueues.

Yes, this seems to be your main problem IMHO. You want to stay on the
same cache and the only way to do so it to pin the work on one single
CPU. But by doing so and increasing sched_wakeup_granularity_ns, the
scheduler detects an imbalanced state because of pinned task that it
wants to fix.
Being able to set the work on a cpumask that covers the cache would be
the solution so the scheduler would be able to select an idle CPU that
share the cache instead of being pinned to a CPU

>
> However, the block layer already does that same-cache steering for
> it's directed completions (see __blk_mq_complete_request()), so we
> are *already running in a "hot cache" CPU context* when we queue
> work. When we queue to the same CPU, we are simply maintaining the
> "cache-hot" context that we are already running in.
>
> Besides, selecting a specific "hot cache" CPU and bind the work to
> that CPU (via queue_work_on()) doesn't fix the scheduler problem -
> it just moves it to another CPU. If the destination CPU is loaded
> like the local CPU, then it's jsut going to cause migrations on the
> destination CPU instead of the local CPU.
>
> IOWs, this is -not a fix- for the scheduler making an incorrect
> migration decisions when we are mixing bound and unbound tasks on
> the local run queue. Yes, it will hide the problem from this
> specific workload instance but it doesn't fix it. We'll just hit it
> under heavier load, such as when production workloads start running
> AIO submission from tens of CPUs at a time while burning near 100%
> CPU in userspace.......
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com

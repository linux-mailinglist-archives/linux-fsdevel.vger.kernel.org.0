Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED910E50E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 05:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLBEW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 23:22:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26747 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727318AbfLBEW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 23:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575260546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RAQwdSGI/J5XsC44f2BDL68Ox237P+Fd4spno9x/dA=;
        b=IGcGivQ5PHAFifZBrUixNAgqB5AJVhu6+I8BjjpnWYYcgXmX3Il52hqn1ASVKYsvnhLyf7
        RDbZ/sXOlDjERF393QqtCD/SpOZmlx4DnVnoW5uAgg7rQWRskpKrDp3sZaUwdLVaf0WC34
        3orrfcE3kknavdvI4eNeBpbcPnJp/48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-Bc8xasMOOESXR_rNx_9-3w-1; Sun, 01 Dec 2019 23:22:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 683FA1852E20;
        Mon,  2 Dec 2019 04:22:21 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F24067E52;
        Mon,  2 Dec 2019 04:22:13 +0000 (UTC)
Date:   Mon, 2 Dec 2019 12:22:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <20191202042208.GE24512@ming.t460p>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191128094003.752-1-hdanton@sina.com>
 <CAKfTPtA23ErKGCEJVmg6vk-QoufkiUM3NbXd31mZmKnuwbTkFw@mail.gmail.com>
 <20191202024625.GD24512@ming.t460p>
 <20191202040256.GE2695@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191202040256.GE2695@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Bc8xasMOOESXR_rNx_9-3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 02, 2019 at 03:02:56PM +1100, Dave Chinner wrote:
> On Mon, Dec 02, 2019 at 10:46:25AM +0800, Ming Lei wrote:
> > On Thu, Nov 28, 2019 at 10:53:33AM +0100, Vincent Guittot wrote:
> > > On Thu, 28 Nov 2019 at 10:40, Hillf Danton <hdanton@sina.com> wrote:
> > > > --- a/fs/iomap/direct-io.c
> > > > +++ b/fs/iomap/direct-io.c
> > > > @@ -157,10 +157,8 @@ static void iomap_dio_bio_end_io(struct
> > > >                         WRITE_ONCE(dio->submit.waiter, NULL);
> > > >                         blk_wake_io_task(waiter);
> > > >                 } else if (dio->flags & IOMAP_DIO_WRITE) {
> > > > -                       struct inode *inode =3D file_inode(dio->ioc=
b->ki_filp);
> > > > -
> > > >                         INIT_WORK(&dio->aio.work, iomap_dio_complet=
e_work);
> > > > -                       queue_work(inode->i_sb->s_dio_done_wq, &dio=
->aio.work);
> > > > +                       schedule_work(&dio->aio.work);
> > >=20
> > > I'm not sure that this will make a real difference because it ends up
> > > to call queue_work(system_wq, ...) and system_wq is bounded as well s=
o
> > > the work will still be pinned to a CPU
> > > Using system_unbound_wq should make a difference because it doesn't
> > > pin the work on a CPU
> > >  +                       queue_work(system_unbound_wq, &dio->aio.work=
);
> >=20
> > Indeed, just run a quick test on my KVM guest, looks the following patc=
h
> > makes a difference:
> >=20
> > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > index 9329ced91f1d..2f4488b0ecec 100644
> > --- a/fs/direct-io.c
> > +++ b/fs/direct-io.c
> > @@ -613,7 +613,8 @@ int sb_init_dio_done_wq(struct super_block *sb)
> >  {
> >         struct workqueue_struct *old;
> >         struct workqueue_struct *wq =3D alloc_workqueue("dio/%s",
> > -                                                     WQ_MEM_RECLAIM, 0=
,
> > +                                                     WQ_MEM_RECLAIM |
> > +                                                     WQ_UNBOUND, 0,
> >                                                       sb->s_id);
>=20
> That's not an answer to the user task migration issue.
>=20
> That is, all this patch does is trade user task migration when the
> CPU is busy for migrating all the queued work off the CPU so the
> user task does not get migrated. IOWs, this forces all the queued
> work to be migrated rather than the user task. IOWs, it does not
> address the issue we've exposed in the scheduler between tasks with
> competing CPU affinity scheduling requirements - it just hides the
> symptom.

Yeah, I believe we all reach the agreement that this is one issue in
scheduler's load balance.

>=20
> Maintaining CPU affinity across dispatch and completion work has
> been proven to be a significant performance win. Right throughout
> the IO stack we try to keep this submitter/completion affinity,
> and that's the whole point of using a bound wq in the first place:
> efficient delayed batch processing of work on the local CPU.
>=20
> Spewing deferred completion work across every idle CPU in the
> machine because the local cpu is temporarily busy is a bad choice,
> both from a performance perspective (dirty cacheline bouncing) and
> from a power efficiency point of view as it causes CPUs to be taken
> out of idle state much more frequently[*].
>=20
> The fact that the scheduler migrates the user task we use workqueues
> for deferred work as they were intended doesn't make this a
> workqueue problem. If the answer to this problem is "make all IO
> workqueues WQ_UNBOUND" then we are effectively saying "the scheduler
> has unfixable problems when mixing bound and unbound work on the
> same run queue".
>=20
> And, besides, what happens when every other CPU is also completely
> busy and can't run the work in a timely fashion? We've just moved
> the work to some random CPU where we wait to be scheduled instead of
> just sitting on the local CPU and waiting....
>=20
> So, yes, we can work around the -symptoms- we see (frequent user
> task migration) by changing the work queue configuration or
> bypassing the workqueue for this specific workload. But these only
> address the visible symptom and don't take into account the wider
> goals of retaining CPU affinity in the IO stack, and they will have
> variable scheduling latency and perofrmance and as the overall
> system load changes.

So far, not see any progress in fixing the load balance issue,
I'd suggest to workaround the issue via the patch if no one objects.
We can comment it explicitly that it is just for workround scheduler's
problem.

BTW, there is lots of WQ_UNBOUND uses in kernel:

[linux]$ git grep -n -w WQ_UNBOUND ./ | grep -v "kernel\/workqueue" | wc
     86     524    7356

Some of them are used in fast IO path too.

>=20
> So, we can fiddle with workqueues, but it doesn't address the
> underlying issue that the scheduler appears to be migrating
> non-bound tasks off a busy CPU too easily....
>=20
> -Dave.
>=20
> [*] Pay attention to the WQ_POWER_EFFICIENT definition for a work
> queue: it's designed for interrupt routines that defer work via work
> queues to avoid doing work on otherwise idle CPUs. It does this by
> turning the per-cpu wq into an unbound wq so that work gets
> scheduled on a non-idle CPUs in preference to the local idle CPU
> which can then remain in low power states.
>=20
> That's the exact opposite of what using WQ_UNBOUND ends up doing in
> this IO completion context: it pushes the work out over idle CPUs
> rather than keeping them confined on the already busy CPUs where CPU
> affinity allows the work to be done quickly. So while WQ_UNBOUND
> avoids the user task being migrated frequently, it results in the
> work being spread around many more CPUs and we burn more power to do
> the same work.

That can't be worse than this crazy migration, which schedules the
IO thread on other IDLE CPUs too.


Thanks,
Ming


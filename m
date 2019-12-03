Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5710F3DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 01:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfLCATE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 19:19:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbfLCATE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 19:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575332342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGy9gNxFygdeVSOn26qERscsGS2TmpnSERzq58aUv+M=;
        b=U/RDFWVTkHFvjhh8TR01NbvNHJaFhD6GeicAHPZoB1LGabPQqqQkfgZ/n72M/D3i45qC5U
        f6LgMKgVTRgIvZ62vu+BWvg8uKVuRxtIqXE4Ikr0w3ZZ2ktPh4XAFwdeu3FvPWm6TVp8kD
        5Cq/V39dxTs5up2mVSLhSPjDU+/xyJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-JjZf2RbAMwWcrpXGTlnKsg-1; Mon, 02 Dec 2019 19:18:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 675A2CF989;
        Tue,  3 Dec 2019 00:18:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDED660BEC;
        Tue,  3 Dec 2019 00:18:47 +0000 (UTC)
Date:   Tue, 3 Dec 2019 08:18:43 +0800
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
Message-ID: <20191203001843.GA25002@ming.t460p>
References: <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191128094003.752-1-hdanton@sina.com>
 <CAKfTPtA23ErKGCEJVmg6vk-QoufkiUM3NbXd31mZmKnuwbTkFw@mail.gmail.com>
 <20191202024625.GD24512@ming.t460p>
 <20191202040256.GE2695@dread.disaster.area>
 <CAKfTPtD8Q97qJ_+hdCXQRt=gy7k96XrhnFmGYP1G88YSFW0vNA@mail.gmail.com>
 <20191202235321.GJ2695@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191202235321.GJ2695@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JjZf2RbAMwWcrpXGTlnKsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:53:21AM +1100, Dave Chinner wrote:
> On Mon, Dec 02, 2019 at 02:45:42PM +0100, Vincent Guittot wrote:
> > On Mon, 2 Dec 2019 at 05:02, Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Mon, Dec 02, 2019 at 10:46:25AM +0800, Ming Lei wrote:
> > > > On Thu, Nov 28, 2019 at 10:53:33AM +0100, Vincent Guittot wrote:
> > > > > On Thu, 28 Nov 2019 at 10:40, Hillf Danton <hdanton@sina.com> wro=
te:
> > > > > > --- a/fs/iomap/direct-io.c
> > > > > > +++ b/fs/iomap/direct-io.c
> > > > > > @@ -157,10 +157,8 @@ static void iomap_dio_bio_end_io(struct
> > > > > >                         WRITE_ONCE(dio->submit.waiter, NULL);
> > > > > >                         blk_wake_io_task(waiter);
> > > > > >                 } else if (dio->flags & IOMAP_DIO_WRITE) {
> > > > > > -                       struct inode *inode =3D file_inode(dio-=
>iocb->ki_filp);
> > > > > > -
> > > > > >                         INIT_WORK(&dio->aio.work, iomap_dio_com=
plete_work);
> > > > > > -                       queue_work(inode->i_sb->s_dio_done_wq, =
&dio->aio.work);
> > > > > > +                       schedule_work(&dio->aio.work);
> > > > >
> > > > > I'm not sure that this will make a real difference because it end=
s up
> > > > > to call queue_work(system_wq, ...) and system_wq is bounded as we=
ll so
> > > > > the work will still be pinned to a CPU
> > > > > Using system_unbound_wq should make a difference because it doesn=
't
> > > > > pin the work on a CPU
> > > > >  +                       queue_work(system_unbound_wq, &dio->aio.=
work);
> > > >
> > > > Indeed, just run a quick test on my KVM guest, looks the following =
patch
> > > > makes a difference:
> > > >
> > > > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > > > index 9329ced91f1d..2f4488b0ecec 100644
> > > > --- a/fs/direct-io.c
> > > > +++ b/fs/direct-io.c
> > > > @@ -613,7 +613,8 @@ int sb_init_dio_done_wq(struct super_block *sb)
> > > >  {
> > > >         struct workqueue_struct *old;
> > > >         struct workqueue_struct *wq =3D alloc_workqueue("dio/%s",
> > > > -                                                     WQ_MEM_RECLAI=
M, 0,
> > > > +                                                     WQ_MEM_RECLAI=
M |
> > > > +                                                     WQ_UNBOUND, 0=
,
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
> >=20
> > Do you really want to target the same CPU ? looks like what you really
> > want to target the same cache instead
>=20
> Well, yes, ideally we want to target the same cache, but we can't do
> that with workqueues.
>=20
> However, the block layer already does that same-cache steering for
> it's directed completions (see __blk_mq_complete_request()), so we
> are *already running in a "hot cache" CPU context* when we queue
> work. When we queue to the same CPU, we are simply maintaining the
> "cache-hot" context that we are already running in.

__blk_mq_complete_request() doesn't always complete the request on
the submission CPU, which is only done in case of 1:1 queue mapping
and N:1 mapping when nr_hw_queues < nr_nodes. Also, the default
completion flag is SAME_GROUP, which just requires the completion
CPU to share cache with submission CPU:

#define QUEUE_FLAG_SAME_COMP    4       /* complete on same CPU-group */



Thanks,=20
Ming


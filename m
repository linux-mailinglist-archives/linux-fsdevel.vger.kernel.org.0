Return-Path: <linux-fsdevel+bounces-64323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF2BBE0EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 00:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB05035352D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 22:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94388305E2C;
	Wed, 15 Oct 2025 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe2urUNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290D62C15A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566786; cv=none; b=etGsEkxuCvsDrK/deWGOVTHHM8/CT2kD3hv6mTeJzPnLVlXyA1Hqx4vbZHeHm7PT/1JVPgX0vFWJMnyDeB5LYIXs0yPhiozdppDilg5UzhPKaFq/Nwfcjs6wGL90eMyBlzcyWYfWkhetnHMzRq8EBz/x9yepedeeksX6QTiORLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566786; c=relaxed/simple;
	bh=yrM0FT/IQ7Y2bz1+ICmrSbJo6hkVbjItnr53p9lSsYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9HuB0/ygIFmXkQmxnS+6lr5TeQfhJfDAYV/Nb1EAH+Sue5XjCUWSIMs+S/Nv6pZO2CERnUGRpyayekumQiywa32VpCKr4G6oX7TANH0dmWq/PY/PQOgKDRbEYVOoSfdnyzHBKPiBbXeNU/OVyX9zXrLPU1eRYl2GPPWvo9gao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe2urUNX; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-79599d65f75so1589386d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760566783; x=1761171583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zD3CRUuo7JmDpHceh1xPXr7deTS5hsKxbCWSD3zg8g=;
        b=Pe2urUNXxjD1wwHJJv1LVoNuLS/HYobSS7xgc8PoQnKkxhIBHuPYWYEBrfIv09lmJv
         ruP4p2UwFyVimkGi+9hbG836tOnosfvC91MgB+z3tDS91cJPj8/7FDWAKF6N2yVBN1ph
         RFyRMiipxIZZ7FB8anasUN2kuKU0LqHD5renwWJtyB/778Zp+9MHmlc0mUIJZEAPejqf
         uBkCeAQd2sX9bWFPUlJsYSkFKOFPuMs/mG3mTcSZDRxNmMM165wXIcPcFQ8N2Umlsz0Z
         GLaD7oYSLc6lLdnL6dzmDyJQoEDpqvM4QnX3Mj9zf8sfd1nMnYMxlcbYzSI5dTBO1K6Y
         DOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760566783; x=1761171583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zD3CRUuo7JmDpHceh1xPXr7deTS5hsKxbCWSD3zg8g=;
        b=IV7yyX5v5VWTjQ5ZoZoinSg4Gq900We53+oXKojjkuqYfOAlOINMRfbjUUoJZor9c8
         mFk9BsAulcPToAVZV1tIVPr+3O0VG7wXhuHLYETZ/SfO4dSVGxQRmQjEU3tj384pwcog
         Q0Pu1s+Nk5l3kU/GwQqQYsSWrPYcClMyHgu8nCY21efelPY7rqED9mGaplFbqWMvW7vx
         hRpdRDDy08f01BbuavlV0k9zExQwzLhq8DDfARJ6Pq/ZzsTcZncbt9fRS0J+RIGCzyhk
         j3iNd4g5DnuQ2XJXGa8RQOxD6KtM95E4/krDAawWVeeRKKgMI5wqO+v32vJWxJV4qSsE
         Ni7g==
X-Forwarded-Encrypted: i=1; AJvYcCXmtlICT58XAwdZe0gH6fXJMgx5eFSG/caQGOos72M8EjZSfXlVbRhqde0JDfEPY6xPHypuR+ngubGiYR54@vger.kernel.org
X-Gm-Message-State: AOJu0YyPJyciLMXcOqX4zwaMBoqjdH6t7navtoIZgewBCk9KYaxmLc+C
	ZSSsTUeYIVka+/WD6cYkukINSqN+tJG658jZMyfYhxSST2HtLF7ydtfQTH0b7CBo1ey3TGNfyNZ
	qMO0qXv34wle9hZB/VchrV7/Ep1BN92w=
X-Gm-Gg: ASbGncvNTydV/0nilqNPHX6sVAlZqpk9IwU7kDfbY8Rju8ECVa21V6g63jtgcCJ3O4h
	Fl20TByAgRKYdnr912ryhBOwbdsy8DWDrRpT9K82X/M83LGwtGULyobav1nf6PEfvGhFXaM5MfS
	wvJeWbMdRXap3jqeIWBkJpTL2N3ZbUo0u+2vLyFKUiSs6eF0ZdPkrp7Klxmm9NZxUzr53wkKu5E
	6Zj2Qy5HFshizovv2P7LaBzFUsysuRp2IxI/kV7zL3px1OZB+BzDinT0IFjWdH7SaAT3sRQ/ITs
	Yq2kKpR/w1ep6Icg4yHbFizdKFE=
X-Google-Smtp-Source: AGHT+IGf3+Aanp43sqbP1d8GPlJPvxXLHlW/nXrY3lyFBTwvLNdLTZGZtFcKrb+NG1195LFaFP8rVGIrZ/CkXIzWYmc=
X-Received: by 2002:a05:622a:1a9e:b0:4e7:1f73:b40a with SMTP id
 d75a77b69052e-4e71f73b42emr182581961cf.1.1760566782818; Wed, 15 Oct 2025
 15:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
 <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com> <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com>
In-Reply-To: <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Oct 2025 15:19:31 -0700
X-Gm-Features: AS18NWCX8sRL6X2mjIWbljBBx73w8jStnKxmQGrFtNcqH_lQ2vZDP9ktspgPyg0
Message-ID: <CAJnrk1b9xVqmDY9kgDjPpjs7zuXNbiNaQnMyvY0iJirJbHi1yw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Wake requests on the same cpu
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:30=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 10/15/25 01:11, Joanne Koong wrote:
> > On Tue, Oct 14, 2025 at 2:50=E2=80=AFAM Bernd Schubert <bschubert@ddn.c=
om> wrote:
> >>
> >> For io-uring it makes sense to wake the waiting application (synchrono=
us
> >> IO) on the same core.
> >>
> >> With queue-per-pore
> >
> > nit typo: core, not pore
>
> :) Thanks, dunno how I managed to get that.
>
> >
> >>
> >> fio --directory=3D/tmp/dest --name=3Diops.\$jobnum --rw=3Drandread --b=
s=3D4k \
> >>      --size=3D1G --numjobs=3D1 --iodepth=3D1 --time_based --runtime=3D=
30s
> >>      \ --group_reporting --ioengine=3Dpsync --direct=3D1
> >>
> >
> > Which server are you using for these benchmarks? passthrough_hp?
>
> passthrough_hp on tmpfs, system has 256GB RAM - enough for these benchmar=
ks, with 16 (32 HT) cores.
>

Thanks!

> >
> >> no-io-uring
> >>     READ: bw=3D116MiB/s (122MB/s), 116MiB/s-116MiB/s
> >> no-io-uring wake on the same core (not part of this patch)
> >>     READ: bw=3D115MiB/s (120MB/s), 115MiB/s-115MiB/s
> >> unpatched
> >>     READ: bw=3D260MiB/s (273MB/s), 260MiB/s-260MiB/s
> >> patched
> >>     READ: bw=3D345MiB/s (362MB/s), 345MiB/s-345MiB/s
> >>
> >> Without io-uring and core bound fuse-server queues there is almost
> >> not difference. In fact, fio results are very fluctuating, in
> >> between 85MB/s and 205MB/s during the run.
> >>
> >> With --numjobs=3D8
> >>
> >> unpatched
> >>     READ: bw=3D2378MiB/s (2493MB/s), 2378MiB/s-2378MiB/s
> >> patched
> >>     READ: bw=3D2402MiB/s (2518MB/s), 2402MiB/s-2402MiB/s
> >> (differences within the confidence interval)
> >>
> >> '-o io_uring_q_mask=3D0-3:8-11' (16 core / 32 SMT core system) and
> >>
> >> unpatched
> >>     READ: bw=3D1286MiB/s (1348MB/s), 1286MiB/s-1286MiB/s
> >> patched
> >>     READ: bw=3D1561MiB/s (1637MB/s), 1561MiB/s-1561MiB/s
> >>
> >> I.e. no differences with many application threads and queue-per-core,
> >> but perf gain with overloaded queues - a bit surprising.
> >>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >> ---
> >> This was already part of the RFC series and was then removed on
> >> request to keep out optimizations from the main fuse-io-uring
> >> series.
> >> Later I was hesitating to add it back, as I was working on reducing th=
e
> >> required number of queues/rings and initially thought
> >> wake-on-current-cpu needs to be a conditional if queue-per-core or
> >> a reduced number of queues is used.
> >> After testing with reduced number of queues, there is still a measurab=
le
> >> benefit with reduced number of queues - no condition on that needed
> >> and the patch can be handled independently of queue size reduction.
> >> ---
> >> Changes in v2:
> >> - Fix the doxygen comment for __wake_up_on_current_cpu
> >> - Move up the ' Wake up waiter sleeping in
> >>    request_wait_answer()' comment in fuse_request_end()
> >> - Link to v1: https://lore.kernel.org/r/20251013-wake-same-cpu-v1-1-45=
d8059adde7@ddn.com
> >> ---
> >>   fs/fuse/dev.c        |  5 ++++-
> >>   include/linux/wait.h |  6 +++---
> >>   kernel/sched/wait.c  | 16 +++++++++++++++-
> >>   3 files changed, 22 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >> index 132f38619d70720ce74eedc002a7b8f31e760a61..3a3d88e60e48df3ac57cff=
3be8df12c4f20ace9a 100644
> >> --- a/fs/fuse/dev.c
> >> +++ b/fs/fuse/dev.c
> >> @@ -500,7 +500,10 @@ void fuse_request_end(struct fuse_req *req)
> >>                  spin_unlock(&fc->bg_lock);
> >>          } else {
> >>                  /* Wake up waiter sleeping in request_wait_answer() *=
/
> >> -               wake_up(&req->waitq);
> >> +               if (test_bit(FR_URING, &req->flags))
> >
> > might be worth having a separate helper for this since this is also
> > called in request_wait_answer()
>
> Ok, I can do that in v3

That could also be part of a different patchset. Sorry, didn't mean to
imply that it should be necessary for this one.
>
> >
> >> +                       wake_up_on_current_cpu(&req->waitq);
> >
> > Won't this lose cache locality for all the other data that is in the
> > client thread's cache on the previous CPU? It seems to me like on
> > average this would be a costlier miss overall? What are your thoughts
> > on this?
>
> So as in the introduction, which b4 made a '---' comment below,
> initially I thought this should be a conditional on queue-per-core.
> With queue-per-core it should be easy to explain, I think.
>
> App submits request on core-X, waits/sleeps, request gets handle on
> core-X by queue-X.
> If there are more applications running on this core, they
> get likely re-scheduled to another core, as the libfuse queue thread is
> core bound. If other applications don't get re-scheduled either the
> entire system is overloaded or someone sets manual application core
> affinity - we can't do much about that in either case. With
> queue-per-core there is also no debate about "previous CPU".
> Worse is actually scheduler behavior here, although the ring thread
> itself goes to sleep soon enough. Application gets still quite often
> re-scheduled to another core. Without wake-on-same core behavior is
> even worse and it jumps across all the time. Not good for CPU cache...

Maybe this is a lack of my understanding of scheduler internals,  but
I'm having a hard time seeing what the benefit of
wake_up_on_current_cpu() is over wake_up() for the queue-per-core
case.

As I understand it, with wake_up() the scheduler already will try to
wake up the thread and put it back on the same core to maintain cache
locality, which in this case is the same core
"wake_up_on_current_cpu()" is trying to put it on. If there's too much
load imbalance then regardless of whether you call wake_up() or
wake_up_on_current_cpu(), the scheduler will migrate the task to
whatever other core is better for it.

So I guess the main benefit of calling wake_up_on_current_cpu() over
wake_up() is that for situations where there is only some but not too
much load imbalance we force the application to run on the current
core even despite the scheduler thinking it's better for overall
system health to distribute the load? I don't see an issue if the
application thread runs very briefly but it seems more likely that the
application thread could be work intensive in which case it seems like
the thread would get migrated anyways or lead to more latency in the
long term with trying to compete on an overloaded core?

>
> With reduced queues we can assume that it to jump between cores, I
> have no problem to make it a conditional on that, just results are
> encouraging to apply it unconditionally - see the results above for
> "-o io_uring_q_mask=3D0-3:8-11' (16 core / 32 SMT core system)"

I'm wondering if that's because the application workloads being run
through fio aren't workloads where there is other locally cached data
the app is using.

> >
> >> +               else
> >> +                       wake_up(&req->waitq);
> >>          }
> >>
> >>          if (test_bit(FR_ASYNC, &req->flags))
> >> diff --git a/include/linux/wait.h b/include/linux/wait.h
> >> index f648044466d5f55f2d65a3aa153b4dfe39f0b6dc..831a187b3f68f0707c75ce=
ee919fec338db410b3 100644
> >> --- a/include/linux/wait.h
> >> +++ b/include/linux/wait.h
> >> @@ -219,6 +219,7 @@ void __wake_up_sync(struct wait_queue_head *wq_hea=
d, unsigned int mode);
> >>   void __wake_up_pollfree(struct wait_queue_head *wq_head);
> >>
> >>   #define wake_up(x)                     __wake_up(x, TASK_NORMAL, 1, =
NULL)
> >> +#define wake_up_on_current_cpu(x)      __wake_up_on_current_cpu(x, TA=
SK_NORMAL, NULL)
> >>   #define wake_up_nr(x, nr)              __wake_up(x, TASK_NORMAL, nr,=
 NULL)
> >>   #define wake_up_all(x)                 __wake_up(x, TASK_NORMAL, 0, =
NULL)
> >>   #define wake_up_locked(x)              __wake_up_locked((x), TASK_NO=
RMAL, 1)
> >> @@ -479,9 +480,8 @@ do {                                              =
                                  \
> >>          __wait_event_cmd(wq_head, condition, cmd1, cmd2);            =
           \
> >>   } while (0)
> >>
> >> -#define __wait_event_interruptible(wq_head, condition)               =
          \
> >> -       ___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,   =
          \
> >> -                     schedule())
> >> +#define __wait_event_interruptible(wq_head, condition) \
> >> +       ___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0, sc=
hedule())
> >>
> >>   /**
> >>    * wait_event_interruptible - sleep until a condition gets true
> >> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> >> index 20f27e2cf7aec691af040fcf2236a20374ec66bf..94120076bc1ae465735843=
cc5821ca532d9c398a 100644
> >> --- a/kernel/sched/wait.c
> >> +++ b/kernel/sched/wait.c
> >> @@ -147,10 +147,24 @@ int __wake_up(struct wait_queue_head *wq_head, u=
nsigned int mode,
> >>   }
> >>   EXPORT_SYMBOL(__wake_up);
> >>
> >> -void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsign=
ed int mode, void *key)
> >> +/**
> >> + * __wake_up_on_current_cpu - wake up threads blocked on a waitqueue,=
 on the
> >> + * current cpu
> >> + * @wq_head: the waitqueue
> >> + * @mode: which threads
> >> + * @nr_exclusive: how many wake-one or wake-many threads to wake up
> >
> > I don't think you meant to include this line?
>
> Yeah, the entire comment is broken :( Sorry about that.
>
> >
> >> + * @key: is directly passed to the wakeup function
> >> + *
> >> + * If this function wakes up a task, it executes a full memory barrie=
r
> >> + * before accessing the task state.  Returns the number of exclusive
> >> + * tasks that were awaken.
> >
> > Doesn't this return a void?
> >
>
> Yeah, I promise I triple check next time when I copy and paste comments.

No worries at all!

Thanks,
Joanne

>
>
> Thanks,
> Bernd


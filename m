Return-Path: <linux-fsdevel+bounces-64168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4ABBDBBA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E0C189EE53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 23:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B571C2DC794;
	Tue, 14 Oct 2025 23:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOexQPYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB832D9EDF
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483491; cv=none; b=JcxU/+Xrn50YvUm4/9HdZb0rkAh0nL88vZ0uMKFsFEwpkXET5kI6ZsZ33N2R+S9lWxmJqCk9Qx6WBiNMprkua+wC538VGCA20vw1Tc6hdXlfygoGVGOfOo0Pw72VPCQR73VOtrSKGEu1brJOLjRvvrXju905zSijEVKRqXn/L5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483491; c=relaxed/simple;
	bh=V3hSkohjQH9IcJeQkk9/8c/RiAD6ZLlDj5JzTIlHNSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXR5icn1FsNpKim4RG1kZylOUwjlk7GeAayc9eqr5AqtNx5IVFRDmvczVDiALmtUWADGy9OUVj9MG6d/Prgw/8JCBptNf0SyLYfjOhf16O9XiGOjTwiShOZURalOJ/fK9UmTZz89Mmjwlux5Apt23QT03ynw3R7+N4uEH1/vbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOexQPYn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-863fa984ef5so993425185a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760483488; x=1761088288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Np7Xh+l7dC2yjt0QIuWV42FRJlARbOqj/A5UDPqNQAw=;
        b=QOexQPYnufYUfPbeNydvdnDPn++cBuYarToXcBe5Dlu8uts4r/B0XurHnZcmuhZzX8
         vy9fGMFrb1wlrua7zZjmbz1L8K2pZgAGMfZwroOxexR19iTvVcllXcgZG9xQIx3XWJpO
         FaqKYJ9hwUqg/5Ypq9WS3qZxJJxOf09sKDHq4yYhmZWEGTKtvvEqHPeMHYqJlQm1mUSG
         LnyxMvGEloGteNPz9mlLc6YM0MyAC9mBqdOgw8/GMDTgOdwmmJj5KA6mZ75SvOPoLnda
         6PmmXDTbBtf2Bqzsk77OLfRXzY4LEJX9k3qmWC2uAsQHffor4HinYeazqv5N9lBiQBJG
         03EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483488; x=1761088288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Np7Xh+l7dC2yjt0QIuWV42FRJlARbOqj/A5UDPqNQAw=;
        b=mQgIRcEG8yqgMxJJ4DZSQ0UwpNhE3iGI55y9qirqhU2KiOtQVyFyIbWf2ZoldwlLqY
         ro2amSxYLi7hzHwjA3tmQTHX8FxTDaRK2ScGbKjoZ9JI+FUOYjhMMIf3Jsx7a79nci+8
         H166ZI+4BgcWSRAQrtxe9aUF4g1CNpy479FPdHl0Or3CrUifL8A0OwY1rhcMdWGbtqGq
         8LCeYsimC03Jq+w8lBHcH6cKi412FXoSue6C5BcjvXShHd8E0ToER2EEDYct+GV7oSRh
         AdOTixgbot7RwY3Tvs6Q9K+HtQSGIVi6alsub4fTCEuTr/qw7weN/nMR1KmGnjV9+25b
         mDJA==
X-Forwarded-Encrypted: i=1; AJvYcCV3JjWoiHcLr+jMCpk/PFaCr6Spqn9FdXVcWoWzHrTbnzenL47QKxTFGN9mXKvFHWsy2wuQF0q4DdH3Gtf9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0nZF9pgSyCB1ajzG71/MIb+wh/kLA89sXzsETUnA2eQaqzr4R
	/R90ww4HF9phfwHJ3B2uh9FCx0+wzq9XFglyafLB8t6ljJorCd2IOKV5C4pAgi40c96bX4m1PbK
	u/8LH8fr+Vso9JPOS6HEcWSSWQINhdiU=
X-Gm-Gg: ASbGncud/GA/M3k1x5yl7CGTD7Ngn1GxqXp3MrljcHRFwccNNJfpHNCQWzeHt3QaO+c
	cYM0BZwBVniKJjgE6su/yvQafba7BAQUBs6DpnI1cMJqE3mu0CRreLt/kooD+5g/4JSk5f0d8f/
	d8+rVkxBXgj4NyXgyDbWzycngX4w62gZHA7y8Tlc75pPEibSPUSCnAP2/nNUmWbgIyLAN+rvDCl
	Tcz/pMgEyKbqOy7stH56JEUbLNy6OQ8/i0qg5YupSji754zRkq8bP4FTt3ihqAMalvw
X-Google-Smtp-Source: AGHT+IEvDIuKbHchPuF8vjsBbZ5GQssNO4wq6o6fSqVEA8H179zsxCttkBIeKjH161jtO9H7+PojOgfjJKFI0oLRZYs=
X-Received: by 2002:a05:622a:40f:b0:4c7:9b85:f6d4 with SMTP id
 d75a77b69052e-4e6eace808cmr390954881cf.22.1760483488217; Tue, 14 Oct 2025
 16:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
In-Reply-To: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Oct 2025 16:11:17 -0700
X-Gm-Features: AS18NWBZ1KKN5_XyXrIRa-aBFgFx0OJ8EHzzz3uLWru2c81eEh_H_lC_kmudKiA
Message-ID: <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Wake requests on the same cpu
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 2:50=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> For io-uring it makes sense to wake the waiting application (synchronous
> IO) on the same core.
>
> With queue-per-pore

nit typo: core, not pore

>
> fio --directory=3D/tmp/dest --name=3Diops.\$jobnum --rw=3Drandread --bs=
=3D4k \
>     --size=3D1G --numjobs=3D1 --iodepth=3D1 --time_based --runtime=3D30s
>     \ --group_reporting --ioengine=3Dpsync --direct=3D1
>

Which server are you using for these benchmarks? passthrough_hp?

> no-io-uring
>    READ: bw=3D116MiB/s (122MB/s), 116MiB/s-116MiB/s
> no-io-uring wake on the same core (not part of this patch)
>    READ: bw=3D115MiB/s (120MB/s), 115MiB/s-115MiB/s
> unpatched
>    READ: bw=3D260MiB/s (273MB/s), 260MiB/s-260MiB/s
> patched
>    READ: bw=3D345MiB/s (362MB/s), 345MiB/s-345MiB/s
>
> Without io-uring and core bound fuse-server queues there is almost
> not difference. In fact, fio results are very fluctuating, in
> between 85MB/s and 205MB/s during the run.
>
> With --numjobs=3D8
>
> unpatched
>    READ: bw=3D2378MiB/s (2493MB/s), 2378MiB/s-2378MiB/s
> patched
>    READ: bw=3D2402MiB/s (2518MB/s), 2402MiB/s-2402MiB/s
> (differences within the confidence interval)
>
> '-o io_uring_q_mask=3D0-3:8-11' (16 core / 32 SMT core system) and
>
> unpatched
>    READ: bw=3D1286MiB/s (1348MB/s), 1286MiB/s-1286MiB/s
> patched
>    READ: bw=3D1561MiB/s (1637MB/s), 1561MiB/s-1561MiB/s
>
> I.e. no differences with many application threads and queue-per-core,
> but perf gain with overloaded queues - a bit surprising.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
> This was already part of the RFC series and was then removed on
> request to keep out optimizations from the main fuse-io-uring
> series.
> Later I was hesitating to add it back, as I was working on reducing the
> required number of queues/rings and initially thought
> wake-on-current-cpu needs to be a conditional if queue-per-core or
> a reduced number of queues is used.
> After testing with reduced number of queues, there is still a measurable
> benefit with reduced number of queues - no condition on that needed
> and the patch can be handled independently of queue size reduction.
> ---
> Changes in v2:
> - Fix the doxygen comment for __wake_up_on_current_cpu
> - Move up the ' Wake up waiter sleeping in
>   request_wait_answer()' comment in fuse_request_end()
> - Link to v1: https://lore.kernel.org/r/20251013-wake-same-cpu-v1-1-45d80=
59adde7@ddn.com
> ---
>  fs/fuse/dev.c        |  5 ++++-
>  include/linux/wait.h |  6 +++---
>  kernel/sched/wait.c  | 16 +++++++++++++++-
>  3 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 132f38619d70720ce74eedc002a7b8f31e760a61..3a3d88e60e48df3ac57cff3be=
8df12c4f20ace9a 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -500,7 +500,10 @@ void fuse_request_end(struct fuse_req *req)
>                 spin_unlock(&fc->bg_lock);
>         } else {
>                 /* Wake up waiter sleeping in request_wait_answer() */
> -               wake_up(&req->waitq);
> +               if (test_bit(FR_URING, &req->flags))

might be worth having a separate helper for this since this is also
called in request_wait_answer()

> +                       wake_up_on_current_cpu(&req->waitq);

Won't this lose cache locality for all the other data that is in the
client thread's cache on the previous CPU? It seems to me like on
average this would be a costlier miss overall? What are your thoughts
on this?

> +               else
> +                       wake_up(&req->waitq);
>         }
>
>         if (test_bit(FR_ASYNC, &req->flags))
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index f648044466d5f55f2d65a3aa153b4dfe39f0b6dc..831a187b3f68f0707c75ceee9=
19fec338db410b3 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -219,6 +219,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, =
unsigned int mode);
>  void __wake_up_pollfree(struct wait_queue_head *wq_head);
>
>  #define wake_up(x)                     __wake_up(x, TASK_NORMAL, 1, NULL=
)
> +#define wake_up_on_current_cpu(x)      __wake_up_on_current_cpu(x, TASK_=
NORMAL, NULL)
>  #define wake_up_nr(x, nr)              __wake_up(x, TASK_NORMAL, nr, NUL=
L)
>  #define wake_up_all(x)                 __wake_up(x, TASK_NORMAL, 0, NULL=
)
>  #define wake_up_locked(x)              __wake_up_locked((x), TASK_NORMAL=
, 1)
> @@ -479,9 +480,8 @@ do {                                                 =
                               \
>         __wait_event_cmd(wq_head, condition, cmd1, cmd2);                =
       \
>  } while (0)
>
> -#define __wait_event_interruptible(wq_head, condition)                  =
       \
> -       ___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,      =
       \
> -                     schedule())
> +#define __wait_event_interruptible(wq_head, condition) \
> +       ___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0, sched=
ule())
>
>  /**
>   * wait_event_interruptible - sleep until a condition gets true
> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> index 20f27e2cf7aec691af040fcf2236a20374ec66bf..94120076bc1ae465735843cc5=
821ca532d9c398a 100644
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -147,10 +147,24 @@ int __wake_up(struct wait_queue_head *wq_head, unsi=
gned int mode,
>  }
>  EXPORT_SYMBOL(__wake_up);
>
> -void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned =
int mode, void *key)
> +/**
> + * __wake_up_on_current_cpu - wake up threads blocked on a waitqueue, on=
 the
> + * current cpu
> + * @wq_head: the waitqueue
> + * @mode: which threads
> + * @nr_exclusive: how many wake-one or wake-many threads to wake up

I don't think you meant to include this line?

> + * @key: is directly passed to the wakeup function
> + *
> + * If this function wakes up a task, it executes a full memory barrier
> + * before accessing the task state.  Returns the number of exclusive
> + * tasks that were awaken.

Doesn't this return a void?

Thanks,
Joanne

> + */
> +void __wake_up_on_current_cpu(struct wait_queue_head *wq_head,
> +                             unsigned int mode, void *key)
>  {
>         __wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
>  }
> +EXPORT_SYMBOL_GPL(__wake_up_on_current_cpu);
>
>  /*
>   * Same as __wake_up but called with the spinlock in wait_queue_head_t h=
eld.
>
> ---
> base-commit: ec714e371f22f716a04e6ecb2a24988c92b26911
> change-id: 20251013-wake-same-cpu-b7ddb0b0688e
>
> Best regards,
> --
> Bernd Schubert <bschubert@ddn.com>
>


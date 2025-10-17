Return-Path: <linux-fsdevel+bounces-64402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B70BE5D94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 02:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086C53BBE83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 00:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640A1F95C;
	Fri, 17 Oct 2025 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3M6O40b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54CE3208
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659289; cv=none; b=OJ9xXsqbxHhsvXwrQYkb5nRSzwToajNBEj014XUvoawN8kxopPBPy0xBlwrSx92e6MDCfT0/oCDL+6vE0WZSRyFBTSf+mm0Ibes4zmfXFJsblWZyciYfoCvtSBC0g5k9aATxPkIKZSo4WG627EjvEPBglszebTcsQm8s5oTUYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659289; c=relaxed/simple;
	bh=HDyLLT6sdhUNv3Hamn4SvCHFTzND+MdUNR3KrSCksj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7gqFX+QtZie3yGcYqn+a2nZ+EIhgH1xjVYzaFRT9DYW+LkNOT91p7f3hre92qxQGskoeYh1sRz47SVFC/W3ef0/Mfp6R70dYhRWwIfgbWHXnsKcXFLMBmD286db9Ew7e3cZtGG8Q3ji4mgu+HnF+vjkIZjgjK13LuZWPjnxhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3M6O40b; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87bf3d1e7faso26788536d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 17:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760659286; x=1761264086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ft2vx3iqQHJJLbJleVxWaZH4DOd5s4IBQsGpXQreGc=;
        b=E3M6O40bjkNMOYbL/pSrfIPgLdvLa374EyqLrkiTMwgB8sajziZ1PrnotlmLexbRZS
         4FDtOjlIYTIsvphsInxeHKpKxax36IQ50uXZSctEWs+GDklS6OA7YivpfSxHdFG3YLSw
         Z4btxAcSQyuPp7knPxPyVDw3Y7miO3AWBj9iQ5XMmSG0u4bWXBc9ME8QySlXp9gD61BB
         FqhbJRTWp5OCUsjqkSIDG8X6ES4skkPuthOPbTYunjcyyZE56uenrLssj7Qcz0TLv8jw
         XBxf7l1LyQpsQa8vx4RrYh/wObDSA/T3gb2Jtboas2Q8PEZhyEf6gXiKaTeSkozbgFE2
         vj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659286; x=1761264086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ft2vx3iqQHJJLbJleVxWaZH4DOd5s4IBQsGpXQreGc=;
        b=EFmqWZQCiosyFw2FHSRojb5foD98e/MVr0UkvNtuQdh1hdN6BbXWdEeosudiV9RgdR
         TPK0kzPeJqL2wNmSOTp+mAqMKrSTm3uTztfu1A3BGpIf4poF+/t0FI9D32aWJve+pdp8
         fKvNTtmTesCS0DE2JxVguqbeJtZsizs5tV+ajYToR/2pAIMSXkSmHdxh0UBTwTzrK7Ia
         JFhHbZAufXtZHJ3wz2kf5gF4FAPIufPD/sDSn58XX7QvCWY/gIT35aDjvjn0xSGr62QG
         VEI5Uj4qJUAGUN6pJEQPy2c7fL7J1m0AwXvj8rGW3JsfwkmxiiXIil27iybHp6feUMOC
         cP2A==
X-Forwarded-Encrypted: i=1; AJvYcCX7t9zQ+bb9ydFAPm86K95Erkx25raBLYn85geMG9PUDp7FgNM1fzc5dFTrP/iC559D/IMfbD2Ye9eNMJUq@vger.kernel.org
X-Gm-Message-State: AOJu0YxigW9MjMF6gt8FcfwHA0hDRW0pbQSkueLlH+RPWfbbAVcJcULa
	uajw160oMiNOMcOSEeNER2S3oEap0GBvIBVxB9Kcv0Tq+BKE2RDIdtdmMk0QEgFFNkZOzypI8LB
	eYnq/POLZwA5Hz4cWRS4chySuVvY1+bI=
X-Gm-Gg: ASbGncsMc6AilsUzM4Z4MceuGloP2GAOFFlClrUPjavnUjVhrvX81m63vgnGij7NIna
	jeHVv3g76IdoFLOCnGiKsNgxe4/8cSd6vM9fixDdRd5KDEiP2Oc4VfvHBFlja71+alNpMPPUT/a
	AmoXanH4LZ/lr12mxi/kzuUsNOobuXUdCnTUJVyrtfLj/ADkKfbBljVhcrDTxWY8MRTCfB6I5tx
	ufK2Kh9uOmegO3tEfMonqhydwLKlddbxAVHgGXXogny7vLGG/8Ty9TBvlGR1KoamRe5UPV3GS1S
	VV0u2BQQPzcQR+90kbCYPQqoyEg=
X-Google-Smtp-Source: AGHT+IEeLUPJEqmY55QRg8pqHdzdW8JeUTMl6YMJ48R24DIbbCNvXmZNVsRKMZhWOcdLeNalIi0ItgSiVWi8BQ0mu1I=
X-Received: by 2002:a05:6214:624:b0:87b:af56:c851 with SMTP id
 6a1803df08f44-87c2065165amr32159836d6.45.1760659285993; Thu, 16 Oct 2025
 17:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
 <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com>
 <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com> <CAJnrk1b9xVqmDY9kgDjPpjs7zuXNbiNaQnMyvY0iJirJbHi1yw@mail.gmail.com>
 <20251016085813.GB3245006@noisy.programming.kicks-ass.net>
 <20251016090019.GH4068168@noisy.programming.kicks-ass.net>
 <CAJnrk1aoPZj6KWKhBhPSASs-kgWDxipfY3MjPDBtG4v-zay3rg@mail.gmail.com> <90ecb50a-926b-45f1-b047-95e07f2e6e6f@ddn.com>
In-Reply-To: <90ecb50a-926b-45f1-b047-95e07f2e6e6f@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Oct 2025 17:01:15 -0700
X-Gm-Features: AS18NWBy8mW6VOuzfb1jrlVadeaxmYMJtNK0qLnYMVRgwZKm111uNOhieRMGwhI
Message-ID: <CAJnrk1baSLo_uXEe1gJOL3b9QP=7gA0fjdrEKQCKSQYda6cSQQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Wake requests on the same cpu
To: Bernd Schubert <bschubert@ddn.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Bernd Schubert <bernd@bsbernd.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	Luis Henriques <luis@igalia.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:54=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> On 10/16/25 22:13, Joanne Koong wrote:
> > On Thu, Oct 16, 2025 at 2:00=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> >>
> >> On Thu, Oct 16, 2025 at 10:58:14AM +0200, Peter Zijlstra wrote:
> >>> On Wed, Oct 15, 2025 at 03:19:31PM -0700, Joanne Koong wrote:
> >>>
> >>>>>> Won't this lose cache locality for all the other data that is in t=
he
> >>>>>> client thread's cache on the previous CPU? It seems to me like on
> >>>>>> average this would be a costlier miss overall? What are your thoug=
hts
> >>>>>> on this?
> >>>>>
> >>>>> So as in the introduction, which b4 made a '---' comment below,
> >>>>> initially I thought this should be a conditional on queue-per-core.
> >>>>> With queue-per-core it should be easy to explain, I think.
> >>>>>
> >>>>> App submits request on core-X, waits/sleeps, request gets handle on
> >>>>> core-X by queue-X.
> >>>>> If there are more applications running on this core, they
> >>>>> get likely re-scheduled to another core, as the libfuse queue threa=
d is
> >>>>> core bound. If other applications don't get re-scheduled either the
> >>>>> entire system is overloaded or someone sets manual application core
> >>>>> affinity - we can't do much about that in either case. With
> >>>>> queue-per-core there is also no debate about "previous CPU".
> >>>>> Worse is actually scheduler behavior here, although the ring thread
> >>>>> itself goes to sleep soon enough. Application gets still quite ofte=
n
> >>>>> re-scheduled to another core. Without wake-on-same core behavior is
> >>>>> even worse and it jumps across all the time. Not good for CPU cache=
...
> >>>>
> >>>> Maybe this is a lack of my understanding of scheduler internals,  bu=
t
> >>>> I'm having a hard time seeing what the benefit of
> >>>> wake_up_on_current_cpu() is over wake_up() for the queue-per-core
> >>>> case.
> >>>>
> >>>> As I understand it, with wake_up() the scheduler already will try to
> >>>> wake up the thread and put it back on the same core to maintain cach=
e
> >>>> locality, which in this case is the same core
> >>>> "wake_up_on_current_cpu()" is trying to put it on. If there's too mu=
ch
> >>>> load imbalance then regardless of whether you call wake_up() or
> >>>> wake_up_on_current_cpu(), the scheduler will migrate the task to
> >>>> whatever other core is better for it.
> >>>>
> >>>> So I guess the main benefit of calling wake_up_on_current_cpu() over
> >>>> wake_up() is that for situations where there is only some but not to=
o
> >>>> much load imbalance we force the application to run on the current
> >>>> core even despite the scheduler thinking it's better for overall
> >>>> system health to distribute the load? I don't see an issue if the
> >>>> application thread runs very briefly but it seems more likely that t=
he
> >>>> application thread could be work intensive in which case it seems li=
ke
> >>>> the thread would get migrated anyways or lead to more latency in the
> >>>> long term with trying to compete on an overloaded core?
> >>>
> >>> So the scheduler will try and wake on the previous CPU, but if that C=
PU
> >>> is not idle it will look for any non-idle CPU in the same L3 and very
> >>
> >> Typing hard: s/non-//
> >>
> >>> aggressively move tasks around.
> >>>
> >>> Notably if Task-A is waking Task-B, and Task-A is running on CPU-1 an=
d
> >>> Task-B was previously running on CPU-1, then the wakeup will see CPU-=
1
> >>> is not idle (it is running Task-A) and it will try and find another C=
PU
> >>> in the same L3.
> >>>
> >>> This is fine if Task-A continues running; however in the case where
> >>> Task-A is going to sleep right after doing the wakeup, this is perhap=
s
> >>> sub-optimal, CPU-1 will end up idle.
> >>>
> >>> We have the WF_SYNC (wake-flag) that tries to indicate this latter ca=
se;
> >>> trouble is, it often gets used where it should not be, it is unreliab=
le.
> >>> Therefore it not a strong hint.
> >>>
> >>> Then we 'recently' grew WF_CURRENT_CPU, that forces the wakeup to the
> >>> same CPU. If you abuse, you keep pieces :-)
> >>>
> >>> So it all depends a bit on the workload, machine and situation.
> >>>
> >>> Some machines L3 is fine, some machines L3 has exclusive L2 and it hu=
rts
> >>> more to move tasks. Some workloads don't fit L2 so it doesn't matter
> >>> anyway. TL;DR is we need this damn crystal ball instruction :-)
> >
> > Thanks for the explanation! I found it very helpful.
> >
> > In light of that information, it seems to me that the original
> > wake_up() would be more optimal here than wake_up_on_current_cpu()
> > then. After fuse_request_end(), the thread still has work to do with
> > fetching and servicing the next requests. If it wakes up the
> > application on its cpu, then with queue-per-core the thread would be
> > forced to sleep since on the libfuse side during setup the thread is
> > pinned to the core, which would prevent any migration while the
> > application task runs. Or am I misassuming something in this analysis,
> > Bernd?
>
>
> Well, the numbers speak a different language. And I still don't see

Thanks for all the data points and your work on this.

> why wouldn't want to take on the current CPU at least if we have
> queue-per-core.

In my understanding, it's because if there are other requests on that
io-uring queue, then they would get delayed in being relayed /
serviced by the server thread since the application thread is now
running on that core, whereas if it was scheduled onto another core,
they could run in parallel.

> Thanks a lot @Peter for the explanation. To my understanding WF_SYNC
> should do the trick, i.e. wake on the same core, when the current task
> is going to sleep anyway and there is nothing else running on that core.
> For a blocking IO with queue-per-core this is exactly what we have.
>
> Example
>
> + echo 'Running: example/passthrough_hp' -o allow_other --foreground --no=
passthrough -o io_uring -o io_uring_nr_qs=3D2 /tmp/source /tmp/dest
>
>
> And then
>
> bschubert2@imesrv3 ~>fio --directory=3D/tmp/dest --name=3Diops.\$jobnum -=
-rw=3Drandread --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D1 --time_bas=
ed --runtime=3D30s --group_reporting --ioengine=3Dpsync --direct=3D1
>
>
> With WF_CURRENT_CPU: READ: bw=3D269MiB/s
> With WF_SYNC:        READ: bw=3D214MiB/s
> With plain wake_up:  READ: bw=3D217MiB/s

If you have time, could you run the fio job with something like
--ioengine=3Dlibaio --numjobs=3D8 --iodepth=3D8? I'm wondering how that
would compare.

With psync, numjobs=3D1 and iodepth=3D1, I think this is a single-threaded
synchronous i/o environment where it does make sense to wake up the
client task on the current core because there are no pending requests
for the thread to fetch and execute in the meantime (since additional
requests are only enqueued after the application's read/write call has
returned). I'm curious how this looks with libaio and multiple threads
where there would be other pending requests on the queue when waking
up the client. I'm also happy to run this on my end tomorrow if you're
pressed for time and busy with other stuff.

>
> With WF_SYNC and plain wake_up I see a persistent core switching
> of the fio process between two cores on one numa node - so much
> about L1/L2 cpu cache.
> With more fuse-io-uring queues there also would be additional
> switching for that and even lower perf, but with only one queue
> per numa that gets a bit restricted.
>
> My guess is that WF_SYNC doesn't detect that the current libfuse
> ring thread will go to sleep in the io_uring_enter() system call
> rather quickly.

This is the part I'm confused about. Does the ring thread go to sleep
in the io_uring_enter() system call? My understanding is that it
doesn't unless IOSQE_ASYNC is set on the sqes which to my knowledge
libfuse doesn't do.

Thanks,
Joanne

> I can try to get some time and figure out why the fio process
> bounces between two cores. I had already started to ftrace
> things, because even WF_CURRENT_CPU isn't ideal. Although this
> discussion here goes the other direction.
>
>
> Thanks,
> Bernd
>
>


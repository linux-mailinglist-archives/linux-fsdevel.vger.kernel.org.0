Return-Path: <linux-fsdevel+bounces-25869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B4B9512F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E81282699
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 03:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7386383BF;
	Wed, 14 Aug 2024 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoP48sBp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A513394;
	Wed, 14 Aug 2024 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605371; cv=none; b=Zz+eg8uOgcOtgafO1lzCZKwN0tU9R6KiGqvo6S3bMtEhEiNHXv93H/4Bur5vxySOy7Cqf489NK3oA8T+/RzgwzZmT70c8K/3FbkSbpmFTj6JgnKOfDrOP0/ywRaK9orMp6G7yLfeP7EWM5/As2bhuDp2hjUKbZ8RpvPi2aeJmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605371; c=relaxed/simple;
	bh=gL5kFHzDGcNpuQvhLnaEZyo7Fuok7+JFbobMGciEdQQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=s0UOEV2saX6gEWdBoTyNdouAtP2WRmMzDVxRrBpc7eTDjUuCcBfjUh6oaaPAjMX4fTgV7ASeloZPgTQ705FA6rIAjNesJURTPV1cpRBB2J/ebtELyyksce6KgP44PJt8sFrBsqvCxcfp5M941F/4nAHaTnVrtLkRCaw+lli37Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoP48sBp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d7bc07b7so413139985a.0;
        Tue, 13 Aug 2024 20:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723605368; x=1724210168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL5kFHzDGcNpuQvhLnaEZyo7Fuok7+JFbobMGciEdQQ=;
        b=MoP48sBp1aLDgBl02x+5Go9R7zN9PJD6QKLme0M9c2fUtyeo17LEw9mmL6zEnqwAVS
         J928h/pDNCNzV8NjurbvMw7TWBbz/uiJ79J+hZxslNvHkoCgCusob7KcRiBY36Su9y6C
         hJtE0+E3pz23ZYLs8mzpk6QtacPN9Rc04MBz5GQVoGvOBRHFmDDZSPuK2NWcEw62VcWx
         fl2Oq0dd0r1sM2M1nDegqOZAUh8mTfZu+SqvlBnsnAOR532db7kCxm27/SYgJ2iwUfp/
         FAgx7yxMKkPfGPFWbcKtmVgIq1mTjtK2FXQY0/TargTaIsVCc3Rwnlp5D4QOBcqPAxvz
         RMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723605368; x=1724210168;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gL5kFHzDGcNpuQvhLnaEZyo7Fuok7+JFbobMGciEdQQ=;
        b=jqrJPiDk4J8iuAH05z7/xKkCP/OXr1C5tGjzypEyWc0q68T3FH+mQIuF5DpWk8nPUu
         OEgwtF6/5aJHDIgGdGw7egPE/d9biOeH+9MxpMCYY0p9nFVsKJ8EU23NWYsaCCBgmCtV
         L4BdAatPZA0iMIjNjxUIezYBu5rZo2T81aefBmOF5fFdqhXQgERayqNduj/G8fftP8Ea
         QL+e/KQGq7zWAt3EnoKF1nHJMzZ8hjcuccRdPfM0xnjUa6zF6kNv8HAzkN9wQVXZ7tYM
         KBMjMI5ucXyHB10MttQjfyGQ/MfpI6/IWafCwLWwH7X/f7lyyLaRMfNKTpufGU03/4I8
         WjBg==
X-Forwarded-Encrypted: i=1; AJvYcCWnPAidAKNH+lwPx62KxqNmhqE8iYam0AoTpba/UHQsnLkdH48O2RDtz86qwjQDJNRB+ve7V3JnFcyWfz59ZMn5qqCf+NPX1uXeTkOHMi7WkMaxy91HWmDAhWj9h4sABpnCzmhrGakFrJtJ+97/bS9qdgXF4AkHQec1CV2VAUURfuyRhAWWyg==
X-Gm-Message-State: AOJu0Yy+4NpBTbe3hPuEr0FaNStfYiv5oNBISkJNu9X+/x7jDr5oHwhj
	fsZYHf/P7yLSlXBvNNJIimQPQhPU0FQA+QmwqG3nrqUZPapBWjU5
X-Google-Smtp-Source: AGHT+IF1qSogIJgN39CK/edq9OoeNnK2AmQgxeHsjP18PzTXK8fS7OFyyR4Z5adA4z2oUrk2/odenQ==
X-Received: by 2002:a05:620a:4621:b0:79f:44d:bafb with SMTP id af79cd13be357-7a4ee33e84cmr164403685a.38.1723605368035;
        Tue, 13 Aug 2024 20:16:08 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dedf55sm392014285a.95.2024.08.13.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:16:07 -0700 (PDT)
Date: Tue, 13 Aug 2024 23:16:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin Karsten <mkarsten@uwaterloo.ca>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, 
 Joe Damato <jdamato@fastly.com>, 
 amritha.nambiar@intel.com, 
 sridhar.samudrala@intel.com, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Breno Leitao <leitao@debian.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Johannes Berg <johannes.berg@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
 "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <66bc21772c6bd_985bf294b0@willemb.c.googlers.com.notmuch>
In-Reply-To: <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Martin Karsten wrote:
> On 2024-08-13 00:07, Stanislav Fomichev wrote:
> > On 08/12, Martin Karsten wrote:
> >> On 2024-08-12 21:54, Stanislav Fomichev wrote:
> >>> On 08/12, Martin Karsten wrote:
> >>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
> >>>>> On 08/12, Martin Karsten wrote:
> >>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
> >>>>>>> On 08/12, Joe Damato wrote:
> >>>>>>>> Greetings:
> =

> [snip]
> =

> >>>>>>> Maybe expand more on what code paths are we trying to improve? =
Existing
> >>>>>>> busy polling code is not super readable, so would be nice to si=
mplify
> >>>>>>> it a bit in the process (if possible) instead of adding one mor=
e tunable.
> >>>>>>
> >>>>>> There are essentially three possible loops for network processin=
g:
> >>>>>>
> >>>>>> 1) hardirq -> softirq -> napi poll; this is the baseline functio=
nality
> >>>>>>
> >>>>>> 2) timer -> softirq -> napi poll; this is deferred irq processin=
g scheme
> >>>>>> with the shortcomings described above
> >>>>>>
> >>>>>> 3) epoll -> busy-poll -> napi poll
> >>>>>>
> >>>>>> If a system is configured for 1), not much can be done, as it is=
 difficult
> >>>>>> to interject anything into this loop without adding state and si=
de effects.
> >>>>>> This is what we tried for the paper, but it ended up being a hac=
k.
> >>>>>>
> >>>>>> If however the system is configured for irq deferral, Loops 2) a=
nd 3)
> >>>>>> "wrestle" with each other for control. Injecting the larger
> >>>>>> irq-suspend-timeout for 'timer' in Loop 2) essentially tilts thi=
s in favour
> >>>>>> of Loop 3) and creates the nice pattern describe above.
> >>>>>
> >>>>> And you hit (2) when the epoll goes to sleep and/or when the user=
space
> >>>>> isn't fast enough to keep up with the timer, presumably? I wonder=

> >>>>> if need to use this opportunity and do proper API as Joe hints in=
 the
> >>>>> cover letter. Something over netlink to say "I'm gonna busy-poll =
on
> >>>>> this queue / napi_id and with this timeout". And then we can esse=
ntially make
> >>>>> gro_flush_timeout per queue (and avoid
> >>>>> napi_resume_irqs/napi_suspend_irqs). Existing gro_flush_timeout f=
eels
> >>>>> too hacky already :-(
> >>>>
> >>>> If someone would implement the necessary changes to make these par=
ameters
> >>>> per-napi, this would improve things further, but note that the cur=
rent
> >>>> proposal gives strong performance across a range of workloads, whi=
ch is
> >>>> otherwise difficult to impossible to achieve.
> >>>
> >>> Let's see what other people have to say. But we tried to do a simil=
ar
> >>> setup at Google recently and getting all these parameters right
> >>> was not trivial. Joe's recent patch series to push some of these in=
to
> >>> epoll context are a step in the right direction. It would be nice t=
o
> >>> have more explicit interface to express busy poling preference for
> >>> the users vs chasing a bunch of global tunables and fighting agains=
t softirq
> >>> wakups.
> >>
> >> One of the goals of this patch set is to reduce parameter tuning and=
 make
> >> the parameter setting independent of workload dynamics, so it should=
 make
> >> things easier. This is of course notwithstanding that per-napi setti=
ngs
> >> would be even better.

I don't follow how adding another tunable reduces parameter tuning.

> >>
> >> If you are able to share more details of your previous experiments (=
here or
> >> off-list), I would be very interested.
> > =

> > We went through a similar exercise of trying to get the tail latencie=
s down.
> > Starting with SO_BUSY_POLL, then switching to the per-epoll variant (=
except
> > we went with a hard-coded napi_id argument instead of tracking) and t=
rying to
> > get a workable set of budget/timeout/gro_flush. We were fine with bur=
ning all
> > cpu capacity we had and no sleep at all, so we ended up having a bunc=
h
> > of special cases in epoll loop to avoid the sleep.
> > =

> > But we were trying to make a different model work (the one you mentio=
n in the
> > paper as well) where the userspace busy-pollers are just running napi=
_poll
> > on one cpu and the actual work is consumed by the userspace on a diff=
erent cpu.
> > (we had two epoll fds - one with napi_id=3Dxxx and no sockets to driv=
e napi_poll
> > and another epoll fd with actual sockets for signaling).
> > =

> > This mode has a different set of challenges with socket lock, socket =
rx
> > queue and the backlog processing :-(
> =

> I agree. That model has challenges and is extremely difficult to tune r=
ight.
> =

> >>>> Note that napi_suspend_irqs/napi_resume_irqs is needed even for th=
e sake of
> >>>> an individual queue or application to make sure that IRQ suspensio=
n is
> >>>> enabled/disabled right away when the state of the system changes f=
rom busy
> >>>> to idle and back.
> >>>
> >>> Can we not handle everything in napi_busy_loop? If we can mark some=
 napi
> >>> contexts as "explicitly polled by userspace with a larger defer tim=
eout",
> >>> we should be able to do better compared to current NAPI_F_PREFER_BU=
SY_POLL
> >>> which is more like "this particular napi_poll call is user busy pol=
ling".
> >>
> >> Then either the application needs to be polling all the time (wastin=
g cpu
> >> cycles) or latencies will be determined by the timeout.
> >>
> >> Only when switching back and forth between polling and interrupts is=
 it
> >> possible to get low latencies across a large spectrum of offered loa=
ds
> >> without burning cpu cycles at 100%.
> > =

> > Ah, I see what you're saying, yes, you're right. In this case ignore =
my comment
> > about ep_suspend_napi_irqs/napi_resume_irqs.
> =

> Thanks for probing and double-checking everything! Feedback is importan=
t =

> for us to properly document our proposal.
> =

> > Let's see how other people feel about per-dev irq_suspend_timeout. Pr=
operly
> > disabling napi during busy polling is super useful, but it would stil=
l
> > be nice to plumb irq_suspend_timeout via epoll context or have it set=
 on
> > a per-napi basis imho.
> =

> Fingers crossed. I hope this patch will be accepted, because it has =

> practical performance and efficiency benefits, and that this will =

> further increase the motivation to re-design the entire irq =

> defer(/suspend) infrastructure for per-napi settings.

Overall, the idea of keeping interrupts disabled during event
processing is very interesting.

Hopefully the interface can be made more intuitive. Or documented more
easily. I had to read the kernel patches to fully (perhaps) grasp it.

Another +1 on the referenced paper. Pointing out a specific difference
in behavior that is unrelated to the protection domain, rather than a
straightforward kernel vs user argument. The paper also had some
explanation that may be clearer for a commit message than the current
cover letter:

"user-level network stacks put the application in charge of the entire
network stack processing (cf. Section 2). Interrupts are disabled and
the application coordinates execution by alternating between
processing existing requests and polling the RX queues for new data"
" [This series extends this behavior to kernel busy polling, while
falling back onto interrupt processing to limit CPU overhead.]

"Instead of re-enabling the respective interrupt(s) as soon as
epoll_wait() returns from its NAPI busy loop, the relevant IRQs stay
masked until a subsequent epoll_wait() call comes up empty, i.e., no
events of interest are found and the application thread is about to be
blocked."

"A fallback technical approach would use a kernel timeout set on the
return path from epoll_wait(). If necessary, the timeout re-enables
interrupts regardless of the application=E2=80=99s (mis)behaviour."
[Where misbehavior is not calling epoll_wait again]

"The resulting execution model mimics the execution model of typical
user-level network stacks and does not add any requirements compared
to user-level networking. In fact, it is slightly better, because it
can resort to blocking and interrupt delivery, instead of having to
continuously busyloop during idle times."

This last part shows a preference on your part to a trade-off:
you want low latency, but also low cpu utilization if possible.
This also came up in this thread. Please state that design decision
explicitly.

There are plenty of workloads where burning a core is acceptable
(especially as core count continues increasing), not "slightly worse".
Kernel polling with full busy polling is also already possible, by
choosing a very high napi_defer_hard_irqs and gro_flush_timeout. So
high in fact, that these tunables need not be tuned carefully. So
what this series add is not interrupt suppression during event
processing per se, but doing so in a hybrid mode balancing latency
and cpu load.




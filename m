Return-Path: <linux-fsdevel+bounces-26154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5CD955226
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 22:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4B3B2297E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A401C688D;
	Fri, 16 Aug 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3xF0FM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E01C57A8;
	Fri, 16 Aug 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841933; cv=none; b=iLB7nYzUDmfhFCQqAdvK0b3PxmHK7p93sBNiZGeh03Cj9KbJYLu3JmfGqXzxZ9YmV55ltZk9gKID4dA0ChgNCjk9cUzoBjjxRWZ/Ep2XomYfDKCkGELBFvuIqqSFz3DxAfo5DElVelRFruapy7dloVPJavkfZl8e8Q8jqRD2FAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841933; c=relaxed/simple;
	bh=Hkseho2gbj9M73LGJxgB5OFhE3ZRRs44yU8CaNeyeYM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uryfE6eGlpszbvF0AwvPQvFeN8hn62udEXBecssGsChSXRCKaH+ZFWjJjx4DoR7LwIFozwr8jMJXsR2QfFza4EFTD61TlFFrMWOJXyLskFKRgey2YTFLQInWI6LKZlZahfZjCWNVvjvbCzCVwlo4kk0liijSD91Kv3rSta3o4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3xF0FM+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so12209956d6.0;
        Fri, 16 Aug 2024 13:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723841930; x=1724446730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50ZMsm0NckQShxpbUylHY0WLBAGbdAiawYsjxO+GGiQ=;
        b=G3xF0FM+xGA9hH1Jdbxkjijf82/YWqb4FDVo6tfPcfCC2KAd2NB+ITJH4IMaUQV3vE
         dqU5CSOJoACXK223uNmzHSlm5trJ8ybkl3/eV3sEBitnuJWPYP0D6BHZuFZD7znyJxrB
         Q6B8pWoFrm30yVwHPRG32gMWVWBOpioL0O0vb7c5+1RNl3uz3ZZ8w+cYAI7DXD5DGwrD
         Zh71MOLFNI8ycfQiysryL7jTugcB59kTtXDROeTYy6TxKF1T4DS0J2Aq/nX2w1HDhCb3
         dD8PiiPXboR64IqereCNdpkfRiILj5l65JePY6e9fx+6UrPH+JI38yJTYbMBYpX2jDLl
         OJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723841930; x=1724446730;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=50ZMsm0NckQShxpbUylHY0WLBAGbdAiawYsjxO+GGiQ=;
        b=ChCJGqLR1Gh6yip/2z048nbb/tN7LYrPxtAiJq+U0bRHff0KaQXIr8EPWSsJZXaE3p
         ipIzQ3AlEhnTc1d9Trp+xnpXCPVSNRRTzyMWkfcjOjsJizOAsJ8zTEfUZeQnelNqdxLB
         8WKA8tkYVqRD7FnxF0uaGCjLr5t5vzCAJhfdiFPLds8zlGu58dVIxFzRM/0QpS1bxDH5
         jD47xqUGP4Fw7VX4GwfHey6qDbHVeaY0WWfoIoMxndLilgIKV73CtbSzfcJP/Y+PDw+s
         SpL/ztWCepuvS95MhEkX053Y81IbAwAUAcYjXPUdIqTKYgPA9/v++qIGztx89TaR975h
         F66A==
X-Forwarded-Encrypted: i=1; AJvYcCXGsNAxhapN2a9uZ/WQ0Uo7p26HLNOStdS5iPCSMVj34lmgjMtDRDoG/dvoFvpQmWD312JqtQEpVlHoznhyiHpfCW4oqx+2fPywtmbOAtHUcvXNuSYyB49bWl4pte4ls0xUSmw3BhqDVX20Q0Fx7h+KbALfNDpVHbkpzZNPy0otm/vX35UHAdtnArv9TRfuXfLgvcgdh26DJDtKFBnMsw==
X-Gm-Message-State: AOJu0YzpyYjppVp+OJwSFJ1H380PSKP5AnER0DhJraGRnO5zX9LpNBRJ
	2SGDtp0S6mrub3Pn8NVodLhu5Dk5u7/EvevK9tDjJPUeFTQgsfOH
X-Google-Smtp-Source: AGHT+IEMZWEggv7hC0PHC/Feg286AIeQvGaJlAZoIrFHOPu101CmQQUSM1qpEq6z+K68Yv/IEfvOKQ==
X-Received: by 2002:a05:6214:4283:b0:6bf:7ea9:b5d9 with SMTP id 6a1803df08f44-6bf89564fe6mr6973876d6.38.1723841929781;
        Fri, 16 Aug 2024 13:58:49 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0a5a6sm21522856d6.138.2024.08.16.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 13:58:49 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:58:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin Karsten <mkarsten@uwaterloo.ca>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Joe Damato <jdamato@fastly.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 netdev@vger.kernel.org, 
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
Message-ID: <66bfbd88dc0c6_18d7b829435@willemb.c.googlers.com.notmuch>
In-Reply-To: <02091b4b-de85-457d-993e-0548f788f4a1@uwaterloo.ca>
References: <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
 <CAAywjhRsRYUHT0wdyPgqH82mmb9zUPspoitU0QPGYJTu+zL03A@mail.gmail.com>
 <d63dd3e8-c9e2-45d6-b240-0b91c827cc2f@uwaterloo.ca>
 <66bf61d4ed578_17ec4b294ba@willemb.c.googlers.com.notmuch>
 <66bf696788234_180e2829481@willemb.c.googlers.com.notmuch>
 <Zr9vavqD-QHD-JcG@LQ3V64L9R2>
 <66bf85f635b2e_184d66294b9@willemb.c.googlers.com.notmuch>
 <02091b4b-de85-457d-993e-0548f788f4a1@uwaterloo.ca>
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
> On 2024-08-16 13:01, Willem de Bruijn wrote:
> > Joe Damato wrote:
> >> On Fri, Aug 16, 2024 at 10:59:51AM -0400, Willem de Bruijn wrote:
> >>> Willem de Bruijn wrote:
> >>>> Martin Karsten wrote:
> >>>>> On 2024-08-14 15:53, Samiullah Khawaja wrote:
> >>>>>> On Tue, Aug 13, 2024 at 6:19=E2=80=AFAM Martin Karsten <mkarsten=
@uwaterloo.ca> wrote:
> >>>>>>>
> >>>>>>> On 2024-08-13 00:07, Stanislav Fomichev wrote:
> >>>>>>>> On 08/12, Martin Karsten wrote:
> >>>>>>>>> On 2024-08-12 21:54, Stanislav Fomichev wrote:
> >>>>>>>>>> On 08/12, Martin Karsten wrote:
> >>>>>>>>>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
> >>>>>>>>>>>> On 08/12, Martin Karsten wrote:
> >>>>>>>>>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
> >>>>>>>>>>>>>> On 08/12, Joe Damato wrote:
> >>>>>>>>>>>>>>> Greetings:
> >>>>>
> >>>>> [snip]
> >>>>>
> >>>>>>>>>>> Note that napi_suspend_irqs/napi_resume_irqs is needed even=
 for the sake of
> >>>>>>>>>>> an individual queue or application to make sure that IRQ su=
spension is
> >>>>>>>>>>> enabled/disabled right away when the state of the system ch=
anges from busy
> >>>>>>>>>>> to idle and back.
> >>>>>>>>>>
> >>>>>>>>>> Can we not handle everything in napi_busy_loop? If we can ma=
rk some napi
> >>>>>>>>>> contexts as "explicitly polled by userspace with a larger de=
fer timeout",
> >>>>>>>>>> we should be able to do better compared to current NAPI_F_PR=
EFER_BUSY_POLL
> >>>>>>>>>> which is more like "this particular napi_poll call is user b=
usy polling".
> >>>>>>>>>
> >>>>>>>>> Then either the application needs to be polling all the time =
(wasting cpu
> >>>>>>>>> cycles) or latencies will be determined by the timeout.
> >>>>>> But if I understand correctly, this means that if the applicatio=
n
> >>>>>> thread that is supposed
> >>>>>> to do napi busy polling gets busy doing work on the new data/eve=
nts in
> >>>>>> userspace, napi polling
> >>>>>> will not be done until the suspend_timeout triggers? Do you disp=
atch
> >>>>>> work to a separate worker
> >>>>>> threads, in userspace, from the thread that is doing epoll_wait?=

> >>>>>
> >>>>> Yes, napi polling is suspended while the application is busy betw=
een
> >>>>> epoll_wait calls. That's where the benefits are coming from.
> >>>>>
> >>>>> The consequences depend on the nature of the application and over=
all
> >>>>> preferences for the system. If there's a "dominant" application f=
or a
> >>>>> number of queues and cores, the resulting latency for other backg=
round
> >>>>> applications using the same queues might not be a problem at all.=

> >>>>>
> >>>>> One other simple mitigation is limiting the number of events that=
 each
> >>>>> epoll_wait call accepts. Note that this batch size also determine=
s the
> >>>>> worst-case latency for the application in question, so there is a=

> >>>>> natural incentive to keep it limited.
> >>>>>
> >>>>> A more complex application design, like you suggest, might also b=
e an
> >>>>> option.
> >>>>>
> >>>>>>>>> Only when switching back and forth between polling and interr=
upts is it
> >>>>>>>>> possible to get low latencies across a large spectrum of offe=
red loads
> >>>>>>>>> without burning cpu cycles at 100%.
> >>>>>>>>
> >>>>>>>> Ah, I see what you're saying, yes, you're right. In this case =
ignore my comment
> >>>>>>>> about ep_suspend_napi_irqs/napi_resume_irqs.
> >>>>>>>
> >>>>>>> Thanks for probing and double-checking everything! Feedback is =
important
> >>>>>>> for us to properly document our proposal.
> >>>>>>>
> >>>>>>>> Let's see how other people feel about per-dev irq_suspend_time=
out. Properly
> >>>>>>>> disabling napi during busy polling is super useful, but it wou=
ld still
> >>>>>>>> be nice to plumb irq_suspend_timeout via epoll context or have=
 it set on
> >>>>>>>> a per-napi basis imho.
> >>>>>> I agree, this would allow each napi queue to tune itself based o=
n
> >>>>>> heuristics. But I think
> >>>>>> doing it through epoll independent interface makes more sense as=
 Stan
> >>>>>> suggested earlier.
> >>>>>
> >>>>> The question is whether to add a useful mechanism (one sysfs para=
meter
> >>>>> and a few lines of code) that is optional, but with demonstrable =
and
> >>>>> significant performance/efficiency improvements for an important =
class
> >>>>> of applications - or wait for an uncertain future?
> >>>>
> >>>> The issue is that this one little change can never be removed, as =
it
> >>>> becomes ABI.
> >>>>
> >>>> Let's get the right API from the start.
> >>>>
> >>>> Not sure that a global variable, or sysfs as API, is the right one=
.
> >>>
> >>> Sorry per-device, not global.
> >>>
> >>> My main concern is that it adds yet another user tunable integer, f=
or
> >>> which the right value is not obvious.
> >>
> >> This is a feature for advanced users just like SO_INCOMING_NAPI_ID
> >> and countless other features.
> >>
> >> The value may not be obvious, but guidance (in the form of
> >> documentation) can be provided.
> > =

> > Okay. Could you share a stab at what that would look like?
> =

> The timeout needs to be large enough that an application can get a =

> meaningful number of incoming requests processed without softirq =

> interference. At the same time, the timeout value determines the =

> worst-case delivery delay that a concurrent application using the same =

> queue(s) might experience. Please also see my response to Samiullah =

> quoted above. The specific circumstances and trade-offs might vary, =

> that's why a simple constant likely won't do.

Thanks. I really do mean this as an exercise of what documentation in
Documentation/networking/napi.rst will look like. That helps makes the
case that the interface is reasonably ease to use (even if only
targeting advanced users).

How does a user measure how much time a process will spend on
processing a meaningful number of incoming requests, for instance.
In practice, probably just a hunch?

Playing devil's advocate some more: given that ethtool usecs have to
be chosen with a similar trade-off between latency and efficiency,
could a multiplicative factor of this (or gro_flush_timeout, same
thing) be sufficient and easier to choose? The documentation does
state that the value chosen must be >=3D gro_flush_timeout.
 =

> >>> If the only goal is to safely reenable interrupts when the applicat=
ion
> >>> stops calling epoll_wait, does this have to be user tunable?
> >>>
> >>> Can it be either a single good enough constant, or derived from
> >>> another tunable, like busypoll_read.
> >>
> >> I believe you meant busy_read here, is that right?
> >>
> >> At any rate:
> >>
> >>    - I don't think a single constant is appropriate, just as it
> >>      wasn't appropriate for the existing mechanism
> >>      (napi_defer_hard_irqs/gro_flush_timeout), and
> >>
> >>    - Deriving the value from a pre-existing parameter to preserve th=
e
> >>      ABI, like busy_read, makes using this more confusing for users
> >>      and complicates the API significantly.
> >>
> >> I agree we should get the API right from the start; that's why we've=

> >> submit this as an RFC ;)
> >>
> >> We are happy to take suggestions from the community, but, IMHO,
> >> re-using an existing parameter for a different purpose only in
> >> certain circumstances (if I understand your suggestions) is a much
> >> worse choice than adding a new tunable that clearly states its
> >> intended singular purpose.
> > =

> > Ack. I was thinking whether an epoll flag through your new epoll
> > ioctl interface to toggle the IRQ suspension (and timer start)
> > would be preferable. Because more fine grained.
> =

> A value provided by an application through the epoll ioctl would not be=
 =

> subject to admin oversight, so a misbehaving application could set an =

> arbitrary timeout value. A sysfs value needs to be set by an admin. The=
 =

> ideal timeout value depends both on the particular target application a=
s =

> well as concurrent applications using the same queue(s) - as sketched a=
bove.

I meant setting the value systemwide (or per-device), but opting in to
the feature a binary epoll options. Really an epoll_wait flag, if we
had flags.

Any admin privileged operations can also be protected at the epoll
level by requiring CAP_NET_ADMIN too, of course. But fair point that
this might operate in a multi-process environment, so values should
not be hardcoded into the binaries.

Just asking questions to explore the option space so as not to settle
on an API too soon. Given that, as said, we cannot remove it later.

> > Also, the value is likely dependent more on the expected duration
> > of userspace processing? If so, it would be the same for all
> > devices, so does a per-netdev value make sense?
> =

> It is per-netdev in the current proposal to be at the same granularity =

> as gro_flush_timeout and napi_defer_hard_irqs, because irq suspension =

> operates at the same level/granularity. This allows for more control =

> than a global setting and it can be migrated to per-napi settings along=
 =

> with gro_flush_timeout and napi_defer_hard_irqs when the time comes.

Ack, makes sense. Many of these design choices and their rationale are
good to explicitly capture in the commit message.


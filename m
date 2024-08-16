Return-Path: <linux-fsdevel+bounces-26127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAF5954C5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 16:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4211C21A26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970191BD016;
	Fri, 16 Aug 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2MT2ZLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131C1E520;
	Fri, 16 Aug 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818457; cv=none; b=cxUHuq4HGN588V511rJO8XGjrEJEvxipFzjOD5+mKAUWS4hXcupl+aVFaY72jrIqduespZub4ocqISqi4PKzX351Ie020yMng2i6rZ6pPl7PFfWO/KLqj4EUGDsuo9dXCSmrHVkug2KIGgeQFNnzEoxreZETzXHadOrLdma3Fhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818457; c=relaxed/simple;
	bh=epUQhCUoZJomPlLyNhHI2k19KhOtsav0prihszzKOeI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o8CcbOJ3+bZ72XYB4j7fMj9t/PTEj2xQS0jLqqbFXHnTNH9b2jYLNICdU/fNHowVtz14qa0aNeLUOApe5EsT0pflT8LWA2bhI17i6MNWKv4qY9vayGeEmEcUDdQ8sBlpllX0HGvH1UjfuZY0AYf5HKz8MqnX3cFo5ztondDC+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2MT2ZLB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-65fe1239f12so20325307b3.0;
        Fri, 16 Aug 2024 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723818454; x=1724423254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epUQhCUoZJomPlLyNhHI2k19KhOtsav0prihszzKOeI=;
        b=X2MT2ZLBKj1f0vC5LYVbMoO1+rJt1XwoFuVNSuPjiHq1Byxczh7X3x21BMYtJy4hCw
         OB4MzYSbuwUnurhV7mMqK2Gq58FFW5G/pvpirNX65c3IvlMHdEwWHgRFhA+vM45id9Gf
         c/+JF4yL2zHyhp+9XQW11irk+wa14w2bAZGuJuCguuJ16YJVqBvli8evZSVROr2OAtJ0
         ixJNLtR57TDoKl6k+HiDuXYMuPiXEz9FXdtQBjTFR8hzSY4RoFkd3TmBvmmcYN2HriAL
         ecmiPMwVlCjtluGfXaSFhKckZ7Do7Bz7XVEzGCjHnL3QKOuxXhkTkSg1JyIfT7P/uIQZ
         rwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723818454; x=1724423254;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=epUQhCUoZJomPlLyNhHI2k19KhOtsav0prihszzKOeI=;
        b=VBSGAIlqi8tt6FmSDq8AfNgGtGq8UhfcjJ0d/iWwhbAR3j/4PmkIbmskJCak+vsvNb
         +iKAAMFI4WKK9Us5oELtZQX9/eMDlw48sfT6rzPIR7ZPn5IoiqAyrHiY156CjWHOTo5A
         ASJsC/xgBbUhqF190umCaQFfGQTBXpLeNF4emBq2NZrTodtj+bJpzhnUuzI6Vxn7Xl9K
         wJzTHHo7qqiqtGLd9ANrldVdwEkJF08UksRIZAe73sngG/nohovi3SbHvpqmCtnbhzbj
         zI++BlBFCQIxwxhBKt1lLJecMKGJlCr/1sSAMIU6bRE7gOZFZyagJVPoINJ/RKjMq9Q3
         UpEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaiEvhEhLgGyRjxH48UCAwXgNm5y/yyU1CvEo7SupMoVveZLh4TafJDBNxHjIP5JbWiJ5GXMi+EPmHzI7zLRMbSlhBQjmSkHJvYd0hFM/FhfuZZ65Fm+NiiNhtegSczvEWjFnMaPDbJjHry1v3P8iMXPsHMVII/sqVkraPzqkWuOkqRofZQ3lJ0j2fC1e0SR7MkqY6PG6F3RPSQ3Msng==
X-Gm-Message-State: AOJu0Yz13DGD0CEG02UiZVOnn09+9wyBUdC4ti6RGfxZxlbJvVfpF15U
	1yaM1hrIHXZjREll7NdMXIVdrzNpS9wUfNuEUElfPEbsWs5voFxQ
X-Google-Smtp-Source: AGHT+IGt/dJGWf0EDGxWM6ryJxB8oHTyXH4vDL8ur9dEAQcu5rwOL7x8XtvPchwmTEGKORnNrV19DQ==
X-Received: by 2002:a05:690c:2f0b:b0:61b:3364:d193 with SMTP id 00721157ae682-6b1bb570dd9mr28289787b3.40.1723818454218;
        Fri, 16 Aug 2024 07:27:34 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe06fd4sm18000986d6.43.2024.08.16.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:27:33 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:27:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin Karsten <mkarsten@uwaterloo.ca>, 
 Samiullah Khawaja <skhawaja@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 netdev@vger.kernel.org, 
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
Message-ID: <66bf61d4ed578_17ec4b294ba@willemb.c.googlers.com.notmuch>
In-Reply-To: <d63dd3e8-c9e2-45d6-b240-0b91c827cc2f@uwaterloo.ca>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
 <CAAywjhRsRYUHT0wdyPgqH82mmb9zUPspoitU0QPGYJTu+zL03A@mail.gmail.com>
 <d63dd3e8-c9e2-45d6-b240-0b91c827cc2f@uwaterloo.ca>
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
> On 2024-08-14 15:53, Samiullah Khawaja wrote:
> > On Tue, Aug 13, 2024 at 6:19=E2=80=AFAM Martin Karsten <mkarsten@uwat=
erloo.ca> wrote:
> >>
> >> On 2024-08-13 00:07, Stanislav Fomichev wrote:
> >>> On 08/12, Martin Karsten wrote:
> >>>> On 2024-08-12 21:54, Stanislav Fomichev wrote:
> >>>>> On 08/12, Martin Karsten wrote:
> >>>>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
> >>>>>>> On 08/12, Martin Karsten wrote:
> >>>>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
> >>>>>>>>> On 08/12, Joe Damato wrote:
> >>>>>>>>>> Greetings:
> =

> [snip]
> =

> >>>>>> Note that napi_suspend_irqs/napi_resume_irqs is needed even for =
the sake of
> >>>>>> an individual queue or application to make sure that IRQ suspens=
ion is
> >>>>>> enabled/disabled right away when the state of the system changes=
 from busy
> >>>>>> to idle and back.
> >>>>>
> >>>>> Can we not handle everything in napi_busy_loop? If we can mark so=
me napi
> >>>>> contexts as "explicitly polled by userspace with a larger defer t=
imeout",
> >>>>> we should be able to do better compared to current NAPI_F_PREFER_=
BUSY_POLL
> >>>>> which is more like "this particular napi_poll call is user busy p=
olling".
> >>>>
> >>>> Then either the application needs to be polling all the time (wast=
ing cpu
> >>>> cycles) or latencies will be determined by the timeout.
> > But if I understand correctly, this means that if the application
> > thread that is supposed
> > to do napi busy polling gets busy doing work on the new data/events i=
n
> > userspace, napi polling
> > will not be done until the suspend_timeout triggers? Do you dispatch
> > work to a separate worker
> > threads, in userspace, from the thread that is doing epoll_wait?
> =

> Yes, napi polling is suspended while the application is busy between =

> epoll_wait calls. That's where the benefits are coming from.
> =

> The consequences depend on the nature of the application and overall =

> preferences for the system. If there's a "dominant" application for a =

> number of queues and cores, the resulting latency for other background =

> applications using the same queues might not be a problem at all.
> =

> One other simple mitigation is limiting the number of events that each =

> epoll_wait call accepts. Note that this batch size also determines the =

> worst-case latency for the application in question, so there is a =

> natural incentive to keep it limited.
> =

> A more complex application design, like you suggest, might also be an =

> option.
> =

> >>>> Only when switching back and forth between polling and interrupts =
is it
> >>>> possible to get low latencies across a large spectrum of offered l=
oads
> >>>> without burning cpu cycles at 100%.
> >>>
> >>> Ah, I see what you're saying, yes, you're right. In this case ignor=
e my comment
> >>> about ep_suspend_napi_irqs/napi_resume_irqs.
> >>
> >> Thanks for probing and double-checking everything! Feedback is impor=
tant
> >> for us to properly document our proposal.
> >>
> >>> Let's see how other people feel about per-dev irq_suspend_timeout. =
Properly
> >>> disabling napi during busy polling is super useful, but it would st=
ill
> >>> be nice to plumb irq_suspend_timeout via epoll context or have it s=
et on
> >>> a per-napi basis imho.
> > I agree, this would allow each napi queue to tune itself based on
> > heuristics. But I think
> > doing it through epoll independent interface makes more sense as Stan=

> > suggested earlier.
> =

> The question is whether to add a useful mechanism (one sysfs parameter =

> and a few lines of code) that is optional, but with demonstrable and =

> significant performance/efficiency improvements for an important class =

> of applications - or wait for an uncertain future?

The issue is that this one little change can never be removed, as it
becomes ABI.

Let's get the right API from the start.

Not sure that a global variable, or sysfs as API, is the right one.
 =

> Note that adding our mechanism in no way precludes switching the contro=
l =

> parameters from per-device to per-napi as Joe alluded to earlier. In =

> fact, it increases the incentive for doing so.
> =

> After working on this for quite a while, I am skeptical that anything =

> fundamentally different could be done without re-architecting the entir=
e =

> napi control flow.
> =

> Thanks,
> Martin
> =





Return-Path: <linux-fsdevel+bounces-26132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA34954D4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 17:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1621F2353E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43E41BD03B;
	Fri, 16 Aug 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBdT4xN1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45672BB0D;
	Fri, 16 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820395; cv=none; b=UbD7vQSpuN/4O1SwtRUtozRz2DC2VEllmbyfyy649ixVajUwhKx1ofvdc+9l9AfERJka/drxJR6Pcu7C9iqade5PEv3uGib5FVCeIEB8JdUavA9O5UVn3W3qFUWE95MB57/Tgd46WRhbpyqF1wd7SdsPEuCzBFyf1KFxHVDZkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820395; c=relaxed/simple;
	bh=9uudIYw7JfGhepxtxZOatr+V5nc/nujXyLaeMxNmwnI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AytkqjhtKfnutP3x4aAD9L03On65dGUrR2JoAXpLYVAtW38vdWv+fNsecsMLCombddOBV9Csscavh1g4nRCbHW1fvHcYDIIjBN7dUlXweHWp1DqSUZ2WLn/yjh8jB34YHy1ApGzWbIHfj8EE+xpqMlzPqd3V9xwjwIPNcbyb4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBdT4xN1; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093705c708so2062357a34.1;
        Fri, 16 Aug 2024 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723820393; x=1724425193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uudIYw7JfGhepxtxZOatr+V5nc/nujXyLaeMxNmwnI=;
        b=aBdT4xN1tj70NCTRZH2PRAZ0l+dL8UzpPIUvMPVKYuNmnibb0pDGnLSozzn9ny5eGC
         LRjmQ0sRRt4iTj+CDKk2/3Oo4Q5AGcUzhpFD2KUXV4xgyfGcwnRibV+4l8N6Ag31gGKd
         8F9Ji/V0jvTH/IJYEofzE40qme64wfS7PQ21eKdrWbtnIAANY5mrwDgFPKsSpL35NbLq
         FMyGIu0G850gYdD2BR5rhZX1Z3rUYsLij0xFRZl38x+hEkmnBHFYXkjlPwLMlvgSRLZ/
         8LQGuH1Y1+TSgvP602Wx4PX7mZXMet/GIpY7HioNKMVnNwztV1WILlt63CkCtRHT91Au
         1k4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723820393; x=1724425193;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9uudIYw7JfGhepxtxZOatr+V5nc/nujXyLaeMxNmwnI=;
        b=rE2pqx/p87Xk4Jvs780dFmWWDz/qZq4cmA91AdAdGPjMe1h7YULw4M8KMUmPhKVRad
         qnK6xF8os1RZxmI4IXFDy09EAmK8n1WNXQGo0V/lK3RbaChl+OG8dFtttUE3kXyhaaUS
         zKOeJBcPxyEYuC1OjhZSnrMfQkOuhQ2+0ofaWiRUxChOwya9DQurhVZ4+J+hB5A3+7n7
         GRYEAnw7i4Pw+cJrs8nIEr0qmiOEd0xzkLJ9f2u8OB+QZGi2J/o8R3xIkB6lO/4BjDUD
         nLZpvuMNRVG+tfquBE69Bh83xKXgzgXZob9RegvGjPgSlM/CZhMSIE27Efep1/DHCQgW
         5RNA==
X-Forwarded-Encrypted: i=1; AJvYcCX/owUUaS8xUaDqwbKsl0maNAB3KgxA23YA15162lFeCFP8/S9t86thnFQEc7UZXor3loZOoKdrju93sCl54pc942K74g5rJwA/pDy4QJTeWXwK1GcPYMf42EFqEbD80mkK3ang8J3iUvRzmqowGBhT+/9r9g8Cjlrsx7Pfg3IO2/bhjCsKn2/vlpggizeyAvO6blJjfDCHhQmOc4C8fw==
X-Gm-Message-State: AOJu0YzoSMpHr/Lw19kPJIgx7VRGGPcaqcTPagEFkbgmKW7VeB9GPfPu
	+XmG54EvEnsFKUCFyEL1IyI2h0ki2Ppy3E3kuvv3ZDJhpiF+3LjA
X-Google-Smtp-Source: AGHT+IH8bNKxlLVLRFW31fzvhnrm6P/uFjcbBZfMpnQ0C0jYoE9r99AQRbAKARdhOb9UQlmmh6jTFQ==
X-Received: by 2002:a05:6830:6e99:b0:708:721b:4077 with SMTP id 46e09a7af769-70cac8af7f8mr3841658a34.23.1723820392605;
        Fri, 16 Aug 2024 07:59:52 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a050f7esm17012891cf.66.2024.08.16.07.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:59:52 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:59:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin Karsten <mkarsten@uwaterloo.ca>, 
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
Message-ID: <66bf696788234_180e2829481@willemb.c.googlers.com.notmuch>
In-Reply-To: <66bf61d4ed578_17ec4b294ba@willemb.c.googlers.com.notmuch>
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
 <66bf61d4ed578_17ec4b294ba@willemb.c.googlers.com.notmuch>
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

Willem de Bruijn wrote:
> Martin Karsten wrote:
> > On 2024-08-14 15:53, Samiullah Khawaja wrote:
> > > On Tue, Aug 13, 2024 at 6:19=E2=80=AFAM Martin Karsten <mkarsten@uw=
aterloo.ca> wrote:
> > >>
> > >> On 2024-08-13 00:07, Stanislav Fomichev wrote:
> > >>> On 08/12, Martin Karsten wrote:
> > >>>> On 2024-08-12 21:54, Stanislav Fomichev wrote:
> > >>>>> On 08/12, Martin Karsten wrote:
> > >>>>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
> > >>>>>>> On 08/12, Martin Karsten wrote:
> > >>>>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
> > >>>>>>>>> On 08/12, Joe Damato wrote:
> > >>>>>>>>>> Greetings:
> > =

> > [snip]
> > =

> > >>>>>> Note that napi_suspend_irqs/napi_resume_irqs is needed even fo=
r the sake of
> > >>>>>> an individual queue or application to make sure that IRQ suspe=
nsion is
> > >>>>>> enabled/disabled right away when the state of the system chang=
es from busy
> > >>>>>> to idle and back.
> > >>>>>
> > >>>>> Can we not handle everything in napi_busy_loop? If we can mark =
some napi
> > >>>>> contexts as "explicitly polled by userspace with a larger defer=
 timeout",
> > >>>>> we should be able to do better compared to current NAPI_F_PREFE=
R_BUSY_POLL
> > >>>>> which is more like "this particular napi_poll call is user busy=
 polling".
> > >>>>
> > >>>> Then either the application needs to be polling all the time (wa=
sting cpu
> > >>>> cycles) or latencies will be determined by the timeout.
> > > But if I understand correctly, this means that if the application
> > > thread that is supposed
> > > to do napi busy polling gets busy doing work on the new data/events=
 in
> > > userspace, napi polling
> > > will not be done until the suspend_timeout triggers? Do you dispatc=
h
> > > work to a separate worker
> > > threads, in userspace, from the thread that is doing epoll_wait?
> > =

> > Yes, napi polling is suspended while the application is busy between =

> > epoll_wait calls. That's where the benefits are coming from.
> > =

> > The consequences depend on the nature of the application and overall =

> > preferences for the system. If there's a "dominant" application for a=
 =

> > number of queues and cores, the resulting latency for other backgroun=
d =

> > applications using the same queues might not be a problem at all.
> > =

> > One other simple mitigation is limiting the number of events that eac=
h =

> > epoll_wait call accepts. Note that this batch size also determines th=
e =

> > worst-case latency for the application in question, so there is a =

> > natural incentive to keep it limited.
> > =

> > A more complex application design, like you suggest, might also be an=
 =

> > option.
> > =

> > >>>> Only when switching back and forth between polling and interrupt=
s is it
> > >>>> possible to get low latencies across a large spectrum of offered=
 loads
> > >>>> without burning cpu cycles at 100%.
> > >>>
> > >>> Ah, I see what you're saying, yes, you're right. In this case ign=
ore my comment
> > >>> about ep_suspend_napi_irqs/napi_resume_irqs.
> > >>
> > >> Thanks for probing and double-checking everything! Feedback is imp=
ortant
> > >> for us to properly document our proposal.
> > >>
> > >>> Let's see how other people feel about per-dev irq_suspend_timeout=
. Properly
> > >>> disabling napi during busy polling is super useful, but it would =
still
> > >>> be nice to plumb irq_suspend_timeout via epoll context or have it=
 set on
> > >>> a per-napi basis imho.
> > > I agree, this would allow each napi queue to tune itself based on
> > > heuristics. But I think
> > > doing it through epoll independent interface makes more sense as St=
an
> > > suggested earlier.
> > =

> > The question is whether to add a useful mechanism (one sysfs paramete=
r =

> > and a few lines of code) that is optional, but with demonstrable and =

> > significant performance/efficiency improvements for an important clas=
s =

> > of applications - or wait for an uncertain future?
> =

> The issue is that this one little change can never be removed, as it
> becomes ABI.
> =

> Let's get the right API from the start.
> =

> Not sure that a global variable, or sysfs as API, is the right one.

Sorry per-device, not global.

My main concern is that it adds yet another user tunable integer, for
which the right value is not obvious.

If the only goal is to safely reenable interrupts when the application
stops calling epoll_wait, does this have to be user tunable?

Can it be either a single good enough constant, or derived from
another tunable, like busypoll_read.


Return-Path: <linux-fsdevel+bounces-26141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5137954F73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 19:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B141F21707
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86AD1C230B;
	Fri, 16 Aug 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWX1aWb/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B08558A5;
	Fri, 16 Aug 2024 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827706; cv=none; b=TkaeAyxyi0FGqRQF3j4phVK7g2gxKBxMhjgnkFB/q4q8qMJT8kJFWU6SesMS9m2YAOtW/oRQ4/u45xePXjKfIlq05c2fDDzIRJr4AIBhzvxKO09bNjdKfLYWHpqtdBvf6K7kUdc9o0qFfS2NyaMFw7CcertoJCJ4s3FkF9K3OPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827706; c=relaxed/simple;
	bh=wtqGZiDectN+F/2/mxoLuM1XsFhhc+wGSAV5cI5J0eM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pOqs8/hNIUCxGgatj01DQ6FRhrqu9+M0l6XDgflOTEoJVU/GXSZgEe4b149lYzv3kma7da2NnvSxMH7p9cONlW07GXv+3vvzTYCP2Q9DZzzIwnwWfsHC4eqGIi51B/eTqy/KJ5b/ueI4+36Kt5ctlRRuceIvGy+G6qoJNVZ7dSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWX1aWb/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d3874c1eso136205085a.2;
        Fri, 16 Aug 2024 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723827703; x=1724432503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv8TAzirmAB9ZYNm4E7DiO13V7tV1XD5jIFjpoelYkw=;
        b=aWX1aWb/08Zlxe5w/P7ucJVxhTZ86mMQf/PCkLLuJyrb0JxVUQpzAqi/WmLd7L98OD
         vbk24FyE8oO4jjkz5sAwhwxEq2VC3sPRRv9wbdX6Wc14AuylEeTF2p66E2APuy+lj4je
         b9tgDFn8Y4UNGJDyLdWGQPN05SM9dGxr/4nx517866B8oOBLdPQpb/w9zu87ugpxsacR
         QraYbwzPZgE4rzcsg6GKif5utrQD/96xPiVM1dmtzCp28UI+cr4UHEM8/2kehQawwpWB
         Q4NZ7+hMUb4JShX/op007BnFY+woZOInYCJ7RYWg9f3anjo5c3guu6RUDSiAlBu2VQYE
         SKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723827703; x=1724432503;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tv8TAzirmAB9ZYNm4E7DiO13V7tV1XD5jIFjpoelYkw=;
        b=V9n+3Me4fhNVOsQk5v7phP4eal58ZgpoQBCY3DE/3amHosAIzYjEvaHliFB1NZIn2T
         noEtm6H1jMj5jYagaQCQVwwD5GzhRJxuy74IJigCvulOG1C7598vnJ+vj4D2QKj3R2NE
         tQoMSx+8dlIKwXmhUXTxx2e+MZ9TGh5aJh8wu/sTUJHvtVQY8QGXSxpU8WIZzfv3Onvf
         bGWBypIvskCheVHa0XnZT4Cjc6ZkKvkc0+uQ3wV5T5VWSAcpqjwvTlyvo739SmseCuS1
         awqGJR0xqUvTE2VR9QkD5o5Mc0WENjbukLiauWcCC9baFq2EKyWEJJpKRtNxw8aEjQj1
         nPYA==
X-Forwarded-Encrypted: i=1; AJvYcCWyhmC4vKJCQXQxeMrXCCPso9AlGY4lyFFLb3jiwL0sxwaGG4+VhGhgVVgkjbhq4f2vhE/g2yGspZ6K8AsPXcqu4gLDWXvEHvKtx6g/5QayOSTHjY0u6irP2O+J/rN3EoaMlGF/Dnj8/Dq8u+9pJfSD2zTCXth/LJ2Nz/YVC7TMlxIQc/6VbyCtC0IKdyQG9zgKEyD1ps4M69I2Kq5Cgg==
X-Gm-Message-State: AOJu0Yx+U8S8/aA1Z0x/Mr6UnkmQIAT5NmzI90q1Aa6r/CW74BLnynCE
	tOigZc4CvFrL8p2G7Y3CaBlYqcqqATyUvHlAez7EyBXYi+0WbIWHVAORUg==
X-Google-Smtp-Source: AGHT+IHZKZPnBdi6rEz+5Ly8m7fMLZlAAS0dpEdJUuYWej00PVqNYc2WCSUsxifBsAZ70bRm4RaReA==
X-Received: by 2002:a05:620a:4687:b0:79f:a2f:a673 with SMTP id af79cd13be357-7a5069e74a5mr467513985a.68.1723827703145;
        Fri, 16 Aug 2024 10:01:43 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0524eesm195300485a.40.2024.08.16.10.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:01:42 -0700 (PDT)
Date: Fri, 16 Aug 2024 13:01:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>, 
 Samiullah Khawaja <skhawaja@google.com>, 
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
Message-ID: <66bf85f635b2e_184d66294b9@willemb.c.googlers.com.notmuch>
In-Reply-To: <Zr9vavqD-QHD-JcG@LQ3V64L9R2>
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

Joe Damato wrote:
> On Fri, Aug 16, 2024 at 10:59:51AM -0400, Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> > > Martin Karsten wrote:
> > > > On 2024-08-14 15:53, Samiullah Khawaja wrote:
> > > > > On Tue, Aug 13, 2024 at 6:19=E2=80=AFAM Martin Karsten <mkarste=
n@uwaterloo.ca> wrote:
> > > > >>
> > > > >> On 2024-08-13 00:07, Stanislav Fomichev wrote:
> > > > >>> On 08/12, Martin Karsten wrote:
> > > > >>>> On 2024-08-12 21:54, Stanislav Fomichev wrote:
> > > > >>>>> On 08/12, Martin Karsten wrote:
> > > > >>>>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
> > > > >>>>>>> On 08/12, Martin Karsten wrote:
> > > > >>>>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
> > > > >>>>>>>>> On 08/12, Joe Damato wrote:
> > > > >>>>>>>>>> Greetings:
> > > > =

> > > > [snip]
> > > > =

> > > > >>>>>> Note that napi_suspend_irqs/napi_resume_irqs is needed eve=
n for the sake of
> > > > >>>>>> an individual queue or application to make sure that IRQ s=
uspension is
> > > > >>>>>> enabled/disabled right away when the state of the system c=
hanges from busy
> > > > >>>>>> to idle and back.
> > > > >>>>>
> > > > >>>>> Can we not handle everything in napi_busy_loop? If we can m=
ark some napi
> > > > >>>>> contexts as "explicitly polled by userspace with a larger d=
efer timeout",
> > > > >>>>> we should be able to do better compared to current NAPI_F_P=
REFER_BUSY_POLL
> > > > >>>>> which is more like "this particular napi_poll call is user =
busy polling".
> > > > >>>>
> > > > >>>> Then either the application needs to be polling all the time=
 (wasting cpu
> > > > >>>> cycles) or latencies will be determined by the timeout.
> > > > > But if I understand correctly, this means that if the applicati=
on
> > > > > thread that is supposed
> > > > > to do napi busy polling gets busy doing work on the new data/ev=
ents in
> > > > > userspace, napi polling
> > > > > will not be done until the suspend_timeout triggers? Do you dis=
patch
> > > > > work to a separate worker
> > > > > threads, in userspace, from the thread that is doing epoll_wait=
?
> > > > =

> > > > Yes, napi polling is suspended while the application is busy betw=
een =

> > > > epoll_wait calls. That's where the benefits are coming from.
> > > > =

> > > > The consequences depend on the nature of the application and over=
all =

> > > > preferences for the system. If there's a "dominant" application f=
or a =

> > > > number of queues and cores, the resulting latency for other backg=
round =

> > > > applications using the same queues might not be a problem at all.=

> > > > =

> > > > One other simple mitigation is limiting the number of events that=
 each =

> > > > epoll_wait call accepts. Note that this batch size also determine=
s the =

> > > > worst-case latency for the application in question, so there is a=
 =

> > > > natural incentive to keep it limited.
> > > > =

> > > > A more complex application design, like you suggest, might also b=
e an =

> > > > option.
> > > > =

> > > > >>>> Only when switching back and forth between polling and inter=
rupts is it
> > > > >>>> possible to get low latencies across a large spectrum of off=
ered loads
> > > > >>>> without burning cpu cycles at 100%.
> > > > >>>
> > > > >>> Ah, I see what you're saying, yes, you're right. In this case=
 ignore my comment
> > > > >>> about ep_suspend_napi_irqs/napi_resume_irqs.
> > > > >>
> > > > >> Thanks for probing and double-checking everything! Feedback is=
 important
> > > > >> for us to properly document our proposal.
> > > > >>
> > > > >>> Let's see how other people feel about per-dev irq_suspend_tim=
eout. Properly
> > > > >>> disabling napi during busy polling is super useful, but it wo=
uld still
> > > > >>> be nice to plumb irq_suspend_timeout via epoll context or hav=
e it set on
> > > > >>> a per-napi basis imho.
> > > > > I agree, this would allow each napi queue to tune itself based =
on
> > > > > heuristics. But I think
> > > > > doing it through epoll independent interface makes more sense a=
s Stan
> > > > > suggested earlier.
> > > > =

> > > > The question is whether to add a useful mechanism (one sysfs para=
meter =

> > > > and a few lines of code) that is optional, but with demonstrable =
and =

> > > > significant performance/efficiency improvements for an important =
class =

> > > > of applications - or wait for an uncertain future?
> > > =

> > > The issue is that this one little change can never be removed, as i=
t
> > > becomes ABI.
> > > =

> > > Let's get the right API from the start.
> > > =

> > > Not sure that a global variable, or sysfs as API, is the right one.=

> > =

> > Sorry per-device, not global.
> > =

> > My main concern is that it adds yet another user tunable integer, for=

> > which the right value is not obvious.
> =

> This is a feature for advanced users just like SO_INCOMING_NAPI_ID
> and countless other features.
> =

> The value may not be obvious, but guidance (in the form of
> documentation) can be provided.

Okay. Could you share a stab at what that would look like?

> > If the only goal is to safely reenable interrupts when the applicatio=
n
> > stops calling epoll_wait, does this have to be user tunable?
> > =

> > Can it be either a single good enough constant, or derived from
> > another tunable, like busypoll_read.
> =

> I believe you meant busy_read here, is that right?
> =

> At any rate:
> =

>   - I don't think a single constant is appropriate, just as it
>     wasn't appropriate for the existing mechanism
>     (napi_defer_hard_irqs/gro_flush_timeout), and
> =

>   - Deriving the value from a pre-existing parameter to preserve the
>     ABI, like busy_read, makes using this more confusing for users
>     and complicates the API significantly.
> =

> I agree we should get the API right from the start; that's why we've
> submit this as an RFC ;)
> =

> We are happy to take suggestions from the community, but, IMHO,
> re-using an existing parameter for a different purpose only in
> certain circumstances (if I understand your suggestions) is a much
> worse choice than adding a new tunable that clearly states its
> intended singular purpose.

Ack. I was thinking whether an epoll flag through your new epoll
ioctl interface to toggle the IRQ suspension (and timer start)
would be preferable. Because more fine grained.

Also, the value is likely dependent more on the expected duration
of userspace processing? If so, it would be the same for all
devices, so does a per-netdev value make sense?



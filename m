Return-Path: <linux-fsdevel+bounces-26206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D899955CA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 14:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBBDB21146
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF6B47F69;
	Sun, 18 Aug 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlRIdFvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349CCA6B;
	Sun, 18 Aug 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985710; cv=none; b=AASvVm959CkF2gjPSJO9UBTxACxmtKY2ShegaNWCIYBrOO59B347T0lmmltIXRdjJFYwsITd88wOjTlUe6mH8yB5eewUd7iEdHpIXN4nD+ArnnFJ1DAEtipb9vYQNrzfdq9BfLJnD4i7DatoPTptR1/Z+VKMdCW8I1OgbjRRTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985710; c=relaxed/simple;
	bh=Y3b3/eSoBdaAQ/aiYFD0jOOTCuomiR75iL8y6Ek3v+I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RO+F03lumtW6glp4D0AlU8wxgVJgfhRp7cTfd/aPfOxrikIESkEygrOJd7EC0N+1iLeFACWWp39o1S4PqK34pTkAdLbnetH2bOQN8vl+p1cRyKKc+aWXpG1sRz1ULVyPabGrP4tmrbSZEXpwyw3qVryBad4C/SH5503X1Q6SolM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlRIdFvx; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a3574acafeso227535385a.1;
        Sun, 18 Aug 2024 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723985708; x=1724590508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjPNQ2hdnuzOp+Zw7QWesXyWkAdRx5XpbRcEGdtXU6Q=;
        b=GlRIdFvx9E9B6TIrHeJKMv455q77yMeVl81EZ398CsAqRtRnKCAQrTbLeRpNJdDZ1y
         Tdc8GAWmzwxPjeM6QmlrwKS41fK+si7TgdHwq+JW4e9FsxYpdQvZz358zsqUnvQP/qri
         lCR5pfxBJkb/i80RCxdk9bE5UTCZqgRNZCiYJPcB0zEYDYUHQxcFjGamp2YkF1MmPf9f
         UYssmv+XQGXlgCJmoW7IQ/jAkJo3T8ckYRpGHxt//mB+ifTK6j8LISlLnNzujAnwKVyH
         tYyN9RwSYVTJy4qu0A6qxvlG8n8HxiNG9fdLlEYoCWcPxiXPH2QaHIbt9ipEWk0KiMSM
         oDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723985708; x=1724590508;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjPNQ2hdnuzOp+Zw7QWesXyWkAdRx5XpbRcEGdtXU6Q=;
        b=Y1aALEh2/CgA8PyB+1twWjsBGF5FKhiuAUQAJD+3rZerR98i36KpNxq4OE36HMgdeQ
         xLMSSU1h5e8Ci9c/yYpWIsQBsaq9BLDm+sUQSQPJE0632OZbfYv+MG6g5e0jhBtah7f6
         n/Vnxd004vEv6I8TQuQqRrrl2OMqmUa4UMbpXj+bTNq4ptVtX5z2STsKokTw+qAeLZhn
         h3K5T0YAvzRsJ0ZpFJNnN16ydMY2POEP3uDcaFKRvAXQd8LAWq23z3q9hnInyU6avc9E
         f9I8Uaw193pVyxMA5BWErpxvtbVar21yz5DYAr04o7k7y2S+PIiQU3Uooy9u68jwBj6J
         a81Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoh82GouYYhAY1KlwUqxPkesc295pZIbJAeEpM9u8gB3o/0M9uF9upKihY+5a4+Wqku0Cop/HPBgGjFUVlx7v4nK9HQS75cR9PsXjZC2YISrTIgVjtCMNix7mQ46Kuqqo6X4M2W29ruVLPfdgZLi2NWJX8/Rg2WZzevPa0FxCZ2kKtjFDdtfTqRBRwVJmF1IRfIg2/w+UAtLMMWXuJ5w==
X-Gm-Message-State: AOJu0Ywr9hG4p9vF+Pj7IsygrI0nijv/JDEEfkbB7I9PEwGO7Ry6Yq2l
	DkG/shqxbUyZuIuzs3qir78KSx4ir1nPGQDvSbkcCZfv0RkoUbbw
X-Google-Smtp-Source: AGHT+IHXou7EVQZ4L9O73YUn4QevN6HlCLXEx1eNoii0u5tbjCLWMah8dxMkJ3k0lkAwqrBGWE+a7Q==
X-Received: by 2002:a05:622a:4016:b0:453:15f2:a320 with SMTP id d75a77b69052e-453741b5a35mr102611211cf.12.1723985707905;
        Sun, 18 Aug 2024 05:55:07 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fee649sm32610841cf.29.2024.08.18.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 05:55:06 -0700 (PDT)
Date: Sun, 18 Aug 2024 08:55:06 -0400
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
Message-ID: <66c1ef2a2e94c_362202942d@willemb.c.googlers.com.notmuch>
In-Reply-To: <e4f6639e-53eb-412d-b998-699099570107@uwaterloo.ca>
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
 <66bfbd88dc0c6_18d7b829435@willemb.c.googlers.com.notmuch>
 <e4f6639e-53eb-412d-b998-699099570107@uwaterloo.ca>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> >>>> The value may not be obvious, but guidance (in the form of
> >>>> documentation) can be provided.
> >>>
> >>> Okay. Could you share a stab at what that would look like?
> >>
> >> The timeout needs to be large enough that an application can get a
> >> meaningful number of incoming requests processed without softirq
> >> interference. At the same time, the timeout value determines the
> >> worst-case delivery delay that a concurrent application using the same
> >> queue(s) might experience. Please also see my response to Samiullah
> >> quoted above. The specific circumstances and trade-offs might vary,
> >> that's why a simple constant likely won't do.
> > 
> > Thanks. I really do mean this as an exercise of what documentation in
> > Documentation/networking/napi.rst will look like. That helps makes the
> > case that the interface is reasonably ease to use (even if only
> > targeting advanced users).
> > 
> > How does a user measure how much time a process will spend on
> > processing a meaningful number of incoming requests, for instance.
> > In practice, probably just a hunch?
> 
> As an example, we measure around 1M QPS in our experiments, fully 
> utilizing 8 cores and knowing that memcached is quite scalable. Thus we 
> can conclude a single request takes about 8 us processing time on 
> average. That has led us to a 20 us small timeout (gro_flush_timeout), 
> enough to make sure that a single request is likely not interfered with, 
> but otherwise as small as possible. If multiple requests arrive, the 
> system will quickly switch back to polling mode.
> 
> At the other end, we have picked a very large irq_suspend_timeout of 
> 20,000 us to demonstrate that it does not negatively impact latency. 
> This would cover 2,500 requests, which is likely excessive, but was 
> chosen for demonstration purposes. One can easily measure the 
> distribution of epoll_wait batch sizes and batch sizes as low as 64 are 
> already very efficient, even in high-load situations.

Overall Ack on both your and Joe's responses.

epoll_wait disables the suspend if no events are found and ep_poll
would go to sleep. As the paper also hints, the timeout is only there
for misbehaving applications that stop calling epoll_wait, correct?
If so, then picking a value is not that critical, as long as not too
low to do meaningful work.

> Also see next paragraph.
> 
> > Playing devil's advocate some more: given that ethtool usecs have to
> > be chosen with a similar trade-off between latency and efficiency,
> > could a multiplicative factor of this (or gro_flush_timeout, same
> > thing) be sufficient and easier to choose? The documentation does
> > state that the value chosen must be >= gro_flush_timeout.
> 
> I believe this would take away flexibility without gaining much. You'd 
> still want some sort of admin-controlled 'enable' flag, so you'd still 
> need some kind of parameter.
> 
> When using our scheme, the factor between gro_flush_timeout and 
> irq_suspend_timeout should *roughly* correspond to the maximum batch 
> size that an application would process in one go (orders of magnitude, 
> see above). This determines both the target application's worst-case 
> latency as well as the worst-case latency of concurrent applications, if 
> any, as mentioned previously.

Oh is concurrent applications the argument against a very high
timeout?

> I believe the optimal factor will vary 
> between different scenarios.
> 
> >>>>> If the only goal is to safely reenable interrupts when the application
> >>>>> stops calling epoll_wait, does this have to be user tunable?
> >>>>>
> >>>>> Can it be either a single good enough constant, or derived from
> >>>>> another tunable, like busypoll_read.
> >>>>
> >>>> I believe you meant busy_read here, is that right?
> >>>>
> >>>> At any rate:
> >>>>
> >>>>     - I don't think a single constant is appropriate, just as it
> >>>>       wasn't appropriate for the existing mechanism
> >>>>       (napi_defer_hard_irqs/gro_flush_timeout), and
> >>>>
> >>>>     - Deriving the value from a pre-existing parameter to preserve the
> >>>>       ABI, like busy_read, makes using this more confusing for users
> >>>>       and complicates the API significantly.
> >>>>
> >>>> I agree we should get the API right from the start; that's why we've
> >>>> submit this as an RFC ;)
> >>>>
> >>>> We are happy to take suggestions from the community, but, IMHO,
> >>>> re-using an existing parameter for a different purpose only in
> >>>> certain circumstances (if I understand your suggestions) is a much
> >>>> worse choice than adding a new tunable that clearly states its
> >>>> intended singular purpose.
> >>>
> >>> Ack. I was thinking whether an epoll flag through your new epoll
> >>> ioctl interface to toggle the IRQ suspension (and timer start)
> >>> would be preferable. Because more fine grained.
> >>
> >> A value provided by an application through the epoll ioctl would not be
> >> subject to admin oversight, so a misbehaving application could set an
> >> arbitrary timeout value. A sysfs value needs to be set by an admin. The
> >> ideal timeout value depends both on the particular target application as
> >> well as concurrent applications using the same queue(s) - as sketched above.
> > 
> > I meant setting the value systemwide (or per-device), but opting in to
> > the feature a binary epoll options. Really an epoll_wait flag, if we
> > had flags.
> > 
> > Any admin privileged operations can also be protected at the epoll
> > level by requiring CAP_NET_ADMIN too, of course. But fair point that
> > this might operate in a multi-process environment, so values should
> > not be hardcoded into the binaries.
> > 
> > Just asking questions to explore the option space so as not to settle
> > on an API too soon. Given that, as said, we cannot remove it later.
> 
> I agree, but I believe we are converging? Also taking into account Joe's 
> earlier response, given that the suspend mechanism dovetails so nicely 
> with gro_flush_timeout and napi_defer_hard_irqs, it just seems natural 
> to put irq_suspend_timeout at the same level and I haven't seen any 
> strong reason to put it elsewhere.

Yes, this sounds good.
 
> >>> Also, the value is likely dependent more on the expected duration
> >>> of userspace processing? If so, it would be the same for all
> >>> devices, so does a per-netdev value make sense?
> >>
> >> It is per-netdev in the current proposal to be at the same granularity
> >> as gro_flush_timeout and napi_defer_hard_irqs, because irq suspension
> >> operates at the same level/granularity. This allows for more control
> >> than a global setting and it can be migrated to per-napi settings along
> >> with gro_flush_timeout and napi_defer_hard_irqs when the time comes.
> > 
> > Ack, makes sense. Many of these design choices and their rationale are
> > good to explicitly capture in the commit message.
> 
> Agreed.
> 
> Thanks,
> Martin




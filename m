Return-Path: <linux-fsdevel+bounces-53584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EBDAF04EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 22:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC86B4E3AFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38712EE5E7;
	Tue,  1 Jul 2025 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Y6kN1y46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330D285CAF
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401996; cv=none; b=fWQdTLiAzqdhIvCVJsJ597MIaH4f1FJx26fWu3bZueg/a9pSoSg3wPxq55HfhGY8TmoZrrgVZAglIIe3cV8hXjHoEKFWllNnMcdaJHBhCjfobsl/sYd69VRlenW75JIDTuOcX02uKrK5xm5RD10EgoW0NfQdtafd6HuyyX8lPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401996; c=relaxed/simple;
	bh=911JYjHmj6gjJY5DPIg00EEUOKP+CfWg2wJM8NLTVE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7EPaMEPp3gj9ps3bpDQhRU1r+unrKtCsS3HVw0QscPo/g4cJpVg88l10EaNnSC8qoNFm8mOV7YZz8DyGVdCH5ziTuSneCyfODPxGMcchOQA9UerojaJzvPOijDAF/dMnQKPqW+vhNkEYg21x7rZosJdKUV4jBSqR2Xf57iy8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Y6kN1y46; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202507012033081ba1a02aafea25f199
        for <linux-fsdevel@vger.kernel.org>;
        Tue, 01 Jul 2025 22:33:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Md1ee6YGuXICMCHtrMUM5ihwD3M3vo1BsbApFOWCUKM=;
 b=Y6kN1y46aoIqKlsuyz3ipyhxjA8T3yrHi7FTv7uqzZV1VRWR6FV6ZS62sR939Z65UEDhhv
 FVvuTkMXVlc2RpyqYHzxBdA0HkyAUz3YtuSxqGXAvM32fAyGSrC7sFzHb0wk69k0JdmoWXoL
 c0q52117v+p8JSyYJn7RvdK7eqnS2A6ZmBON75zJUDPLRFh3F90izn/b8ERM4R+ZKqtmIo3T
 xY6HtvN2aHeaNwwZdGy+wGE4fXBr5vNVVupLrBM8Ph59F2wRWDxE3qaSkekpSxm6r+4261VN
 HQ5Q/RMJHuIQw8kxHrm+8gZlhDOpsdVXkvx0EI2VaYjdPhexVs5Vd1SA==;
Message-ID: <7d49c9b5b533ee2b4b1883faf4c87ac8ebf60eb4.camel@siemens.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Nam Cao
 <namcao@linutronix.de>,  Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,  Sebastian
 Andrzej Siewior	 <bigeasy@linutronix.de>, John Ogness
 <john.ogness@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, 	linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-rt-devel@lists.linux.dev,
 linux-rt-users@vger.kernel.org, Joe Damato	 <jdamato@fastly.com>, Martin
 Karsten <mkarsten@uwaterloo.ca>, Jens Axboe	 <axboe@kernel.dk>
Cc: Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider
	 <vschneid@redhat.com>
Date: Tue, 01 Jul 2025 22:33:05 +0200
In-Reply-To: <773266ac-aa33-497f-b889-6d9f784e850b@amd.com>
References: <20250527090836.1290532-1-namcao@linutronix.de>
	 <773266ac-aa33-497f-b889-6d9f784e850b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2025-06-30 at 20:38 +0530, K Prateek Nayak wrote:
> Hello Nam,
>=20
> On 5/27/2025 2:38 PM, Nam Cao wrote:
> > The ready event list of an epoll object is protected by read-write
> > semaphore:
> >=20
> >    - The consumer (waiter) acquires the write lock and takes items.
> >    - the producer (waker) takes the read lock and adds items.
> >=20
> > The point of this design is enabling epoll to scale well with large num=
ber
> > of producers, as multiple producers can hold the read lock at the same
> > time.
> >=20
> > Unfortunately, this implementation may cause scheduling priority invers=
ion
> > problem. Suppose the consumer has higher scheduling priority than the
> > producer. The consumer needs to acquire the write lock, but may be bloc=
ked
> > by the producer holding the read lock. Since read-write semaphore does =
not
> > support priority-boosting for the readers (even with CONFIG_PREEMPT_RT=
=3Dy),
> > we have a case of priority inversion: a higher priority consumer is blo=
cked
> > by a lower priority producer. This problem was reported in [1].
> >=20
> > Furthermore, this could also cause stall problem, as described in [2].
> >=20
> > To fix this problem, make the event list half-lockless:
> >=20
> >    - The consumer acquires a mutex (ep->mtx) and takes items.
> >    - The producer locklessly adds items to the list.
> >=20
> > Performance is not the main goal of this patch, but as the producer now=
 can
> > add items without waiting for consumer to release the lock, performance
> > improvement is observed using the stress test from
> > https://github.com/rouming/test-tools/blob/master/stress-epoll.c. This =
is
> > the same test that justified using read-write semaphore in the past.
> >=20
> > Testing using 12 x86_64 CPUs:
> >=20
> >            Before     After        Diff
> > threads  events/ms  events/ms
> >        8       6932      19753    +185%
> >       16       7820      27923    +257%
> >       32       7648      35164    +360%
> >       64       9677      37780    +290%
> >      128      11166      38174    +242%
> >=20
> > Testing using 1 riscv64 CPU (averaged over 10 runs, as the numbers are
> > noisy):
> >=20
> >            Before     After        Diff
> > threads  events/ms  events/ms
> >        1         73        129     +77%
> >        2        151        216     +43%
> >        4        216        364     +69%
> >        8        234        382     +63%
> >       16        251        392     +56%
> >=20
>=20
> I gave this patch a spin on top of tip:sched/core (PREEMPT_RT) with
> Jan's reproducer from
> https://lore.kernel.org/all/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.=
com/.
>=20
> On tip:sched/core, I see a hang few seconds into the run and rcu-stall
> a minute after when I pin the epoll-stall and epoll-stall-writer on the
> same CPU as the Bandwidth timer on a 2vCPU VM. (I'm using a printk to
> log the CPU where the timer was started in pinned mode)
>=20
> With this series, I haven't seen any stalls yet over multiple short
> runs (~10min) and even a longer run (~3Hrs).

Many thanks for running those tests and posting the results as comments
to this series. Highly appreciated!

Florian




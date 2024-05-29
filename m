Return-Path: <linux-fsdevel+bounces-20423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9AF8D3170
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 10:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8191F2147B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A356174ECD;
	Wed, 29 May 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SRPNYFeO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rAokD/kt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40107169AD9;
	Wed, 29 May 2024 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971356; cv=none; b=ZuBXN+ki5vd6+A2bUeajjTiQtsIkD5ehhLsXkDnEa7hxB5+hNpfovy0q3CRFnwbr+XdeLxlc3qs/cOMlh2Bzb0HaIL2UqypPV9JApk8f4+tAG613d5mKM0j8dCDRmCR2GVBUKEp/QaQot0DvBshe1W/6VBn11GWz4BOEahA7Q60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971356; c=relaxed/simple;
	bh=o9DQnDi62SVThmHsJFN8GzWXXKPHm4neh84ypARH/kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QX7Cnmzl2Avc6IZN6+y5UMRVekir9D7UD8jpR13LVURd9FYTJia1ZS+mrcygZc0ARUz11qRyTsrLWT+knkV5DDVKk7kOuNxrCmc9owHjSs/qcLIYE5xr3z2gngs8mi5Kecj+ZVZ+u5K9zj393b10Gw2p2mcLG60WUrenVYcLChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SRPNYFeO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rAokD/kt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 May 2024 10:29:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716971353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9DQnDi62SVThmHsJFN8GzWXXKPHm4neh84ypARH/kY=;
	b=SRPNYFeOAAQ6EO5TmISg+WdT5xutmuEvGiHVPiLk25JF94IvoO5dJe74+yTlf+DsVN1+3o
	NPprB2daAAUrPDhsX3A77MeaqdhBxfcCBrc1U+p4hQGJmJ2vCdnBZHifjh7Au/EyYZyy48
	eN2gSKSyo6HPBxwLSjqbON6PvxdgfJE9sDcN9lZ8ZHJGRNhXB2gHiGac0VJv8ht3dFGK2j
	F1raEtP3dyshOrsuQc452RucueZ9nPqZSBOSWeE667FRSeHDAu77un7wZNNJ8hdZpApqfI
	/dQVgOKXP9T1J8ZpTzvli/9R8iB9UQMWg5WiHD/UUt2jBGHUMe5gYscrwf2pDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716971353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9DQnDi62SVThmHsJFN8GzWXXKPHm4neh84ypARH/kY=;
	b=rAokD/ktxO9WLt/FyEsByG7MpgD69acVBS3P8Uyiz3JZZBqcPShAqUFCb1T1KDpFYJfRac
	soZjOVMB1ERztlCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240529082912.gPDpgVy3@linutronix.de>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240521110035.KRIwllGe@linutronix.de>
 <20240527172650.kieptfl3zhyljkzx@airbuntu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240527172650.kieptfl3zhyljkzx@airbuntu>

On 2024-05-27 18:26:50 [+0100], Qais Yousef wrote:
> > In order to be PI-boosted you need to acquire a lock and the only lock
> > you can sleep while acquired without generating a warning is a mutex_t
> > (or equivalent sleeping lock) on PREEMPT_RT.=20
>=20
> Note we care about the behavior for !PREEMPT_RT. PI issues are important =
there
> too. I assume the fact the PREEMPT_RT changes the locks behavior is what =
you're
> referring to here and not applicable to normal case.

So for !PREEMPT_RT you need a rtmutex for PI. RCU and i2c is using it
within the kernel and this shouldn't go via the `slack' API.

The FUTEX API on the other hand is a different story and it might
matter. So you have one task running SCHED_OTHER and acquiring a lock in
userspace (pthread_mutex_t, PTHREAD_PRIO_INHERIT). Another task running
at SCHED_FIFO/ RR/ DL would also acquire that lock, block on it and
then inherit its priority.
This is the point where the former task has a different policy vs
priority considering PI-boosting. You could argue that the task
shouldn't sleep or invoke anything possible sleeping with a timeout > 0
because it is using an important lock.
But then it is userland and has the freedom to do whatever it wants you
know=E2=80=A6

So it might be better to forget what I said and keeping the current
behaviour. But then it is insistent which matters only in the RT case.
Puh. Any sched folks regarding policy?

> Thanks!

Sebastian


Return-Path: <linux-fsdevel+bounces-25366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0926D94B33F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 00:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59956B23084
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 22:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F62B155C8F;
	Wed,  7 Aug 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T730Czqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6B148FFF;
	Wed,  7 Aug 2024 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071066; cv=none; b=hbKs64LGDPXB0C/YtCynxtwWVp06Vvg9K8NCcCpLhhMhlEMsYM9scaWDd2ImkEMAiW/WfogxhmuxLiAy7QcC012gqd1wkG1i4QCyhXO2gCpPBw+vQzqQHui6tbQ6cGQT7eEYnFT1bs+Rco7K/S30tkiRzOxevlxA8XGzOky96Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071066; c=relaxed/simple;
	bh=CxYlX3VUGo8QOENfa1E0JSJYFSv6wAo1b1J4jmI3448=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ajh19lt8DtG+BKfiGZPwdNppUTI4VtDwSNt9nLg/3ritJz3KfE86R8UZQVt9KJD4vRtqoK3KlO2ieBktU1cdJlhXktTjcRUdvVXhtaAbzzMzzBwTLyyv4fMXDYxmKIxYEJuUB9uotiVWTtiePheSTJ7y22zDUVytt2bahEx1OUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T730Czqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C01EC32781;
	Wed,  7 Aug 2024 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723071066;
	bh=CxYlX3VUGo8QOENfa1E0JSJYFSv6wAo1b1J4jmI3448=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T730CzqgzI3cweZ/coawbyGyByQnEjCSOHORlwh/Xnk8PquRny9qHKLMt0Edghe8j
	 c8hYxXNwrVb1DVAIAQ1SwJLVQDKVLPbwHUMJuVX/PMZ9VaCC9eU9FbL2gxj+H/YxEg
	 F915QiWqSoz5QhuEqQ6gIAAosssovNbRysey21VpsEBUmnMZyRu92onMfFlVlONMvP
	 91bC6vnCgkH/u17Sf+tVs28jfe1jsjHIDffl5hyK7pYYUowbyEeXB6dRqpSeEAJ+Tu
	 Mq/SqVMc2jvUNnEf4AnsF0xnkNc0oCcZOnFJfAPLd3LfTD8AYW1S63GV9G2RDk15al
	 38t5+TTkePG0A==
Date: Wed, 7 Aug 2024 15:51:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240807225106.GM6051@frogsfrogsfrogs>
References: <20240731031033.GP6352@frogsfrogsfrogs>
 <20240731053341.GQ6352@frogsfrogsfrogs>
 <20240731105557.GY33588@noisy.programming.kicks-ass.net>
 <20240805143522.GA623936@frogsfrogsfrogs>
 <20240806094413.GS37996@noisy.programming.kicks-ass.net>
 <20240806103808.GT37996@noisy.programming.kicks-ass.net>
 <875xsc4ehr.ffs@tglx>
 <20240807143407.GC31338@noisy.programming.kicks-ass.net>
 <87wmks2xhi.ffs@tglx>
 <20240807150503.GF6051@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807150503.GF6051@frogsfrogsfrogs>

On Wed, Aug 07, 2024 at 08:05:03AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 07, 2024 at 04:55:53PM +0200, Thomas Gleixner wrote:
> > On Wed, Aug 07 2024 at 16:34, Peter Zijlstra wrote:
> > > On Wed, Aug 07, 2024 at 04:03:12PM +0200, Thomas Gleixner wrote:
> > >
> > >> > +	if (static_key_dec(key, true)) // dec-not-one
> > >> 
> > >> Eeew.
> > >
> > > :-) I knew you'd hate on that
> > 
> > So you added it just to make me grumpy enough to fix it for you, right?
> 
> FWIW with peter's 'ugly' patch applied, fstests didn't cough up any
> static key complaints overnight.

But with Thomas' patch and the "if (v < 0) return false;" change
applied, the kernel crashes on boot:

[   11.563329] jump_label: Fatal kernel bug, unexpected op at mem_cgroup_sk_alloc+0x5/0xc0 [ffffffff81377af5] (eb 01 c3 53 48 != 66 90 0f 1f 00)) size:2 type:1
[   11.566166] ------------[ cut here ]------------
[   11.567150] kernel BUG at arch/x86/kernel/jump_label.c:73!
[   11.568416] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
[   11.569586] CPU: 1 UID: 0 PID: 58 Comm: 1:1 Not tainted 6.11.0-rc2-djwx #rc2 d917e89fa198c1bdec418be517dc3e49f564823f
[   11.571790] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   11.573738] Workqueue: cgroup_destroy css_free_rwork_fn
[   11.574898] RIP: 0010:__jump_label_patch+0x10a/0x110
[   11.576122] Code: eb a0 0f 0b 0f 0b 48 c7 c3 a4 7a 7b 82 41 56 45 89 e1 49 89 d8 4c 89 e9 4c 89 ea 4c 89 ee 48 c7 c7 60 8a e7 81 e8 66 dd 0d 00 <0f> 0b 0f 1f 40 00 0f 1f 44 00 00 e9 36 0
[   11.579843] RSP: 0018:ffffc90000527d70 EFLAGS: 00010246
[   11.580986] RAX: 0000000000000090 RBX: ffffffff81c088c1 RCX: 0000000000000000
[   11.582470] RDX: 0000000000000000 RSI: ffffffff81eacf61 RDI: 00000000ffffffff
[   11.583962] RBP: ffffc90000527da0 R08: 0000000000000000 R09: 205d393233333635
[   11.585449] R10: 0000000000000731 R11: 62616c5f706d756a R12: 0000000000000002
[   11.589526] R13: ffffffff81377af5 R14: 0000000000000001 R15: 0000000000000000
[   11.591030] FS:  0000000000000000(0000) GS:ffff88803ed00000(0000) knlGS:0000000000000000
[   11.592776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.594018] CR2: 00007fec0a3f5d90 CR3: 0000000002033004 CR4: 00000000001706f0
[   11.595506] Call Trace:
[   11.596174]  <TASK>
[   11.605028]  arch_jump_label_transform_queue+0x33/0x70
[   11.606170]  __jump_label_update+0x6e/0x130
[   11.607131]  __static_key_slow_dec_cpuslocked+0x50/0x60
[   11.608280]  static_key_slow_dec+0x2d/0x50
[   11.609230]  mem_cgroup_css_free+0xc2/0xd0
[   11.610183]  css_free_rwork_fn+0x40/0x3f0
[   11.612094]  process_one_work+0x17a/0x3b0
[   11.613045]  worker_thread+0x252/0x360
[   11.615974]  kthread+0xe5/0x120

--D

> > >> +/*
> > >> + * Fastpath: Decrement if the reference count is greater than one
> > >> + *
> > >> + * Returns false, if the reference count is 1 or -1 to force the caller
> > >> + * into the slowpath.
> > >> + *
> > >> + * The -1 case is to handle a decrement during a concurrent first enable,
> > >> + * which sets the count to -1 in static_key_slow_inc_cpuslocked(). As the
> > >> + * slow path is serialized the caller will observe 1 once it acquired the
> > >> + * jump_label_mutex, so the slow path can succeed.
> > >> + */
> > >> +static bool static_key_dec_not_one(struct static_key *key)
> > >> +{
> > >> +	int v = static_key_dec(key, true);
> > >> +
> > >> +	return v != 1 && v != -1;
> > >
> > > 	if (v < 0)
> > > 		return false;
> > 
> > Hmm. I think we should do:
> > 
> > #define KEY_ENABLE_IN_PROGRESS		-1
> > 
> > or even a more distinct value like (INT_MIN / 2)
> > 
> > and replace all the magic -1 numbers with it. Then the check becomes
> > explicit:
> > 
> >         if (v == KEY_ENABLE_IN_PROGRESS)
> >         	return false;
> > 
> > > 	/*
> > > 	 * Notably, 0 (underflow) returns true such that it bails out
> > > 	 * without doing anything.
> > > 	 */
> > > 	return v != 1;
> > >
> > > Perhaps?
> > 
> > Sure.
> > 
> > >> +}
> > >> +
> > >> +/*
> > >> + * Slowpath: Decrement and test whether the refcount hit 0.
> > >> + *
> > >> + * Returns true if the refcount hit zero, i.e. the previous value was one.
> > >> + */
> > >> +static bool static_key_dec_and_test(struct static_key *key)
> > >> +{
> > >> +	int v = static_key_dec(key, false);
> > >> +
> > >> +	lockdep_assert_held(&jump_label_mutex);
> > >> +	return v == 1;
> > >>  }
> > >
> > > But yeah, this is nicer!
> > 
> > :)
> 
> It probably goes without saying that if either of you send a cleaned up
> patch with all these changes baked in, I will test it for you all. :)
> 
> --D
> 
> > 
> > Thanks,
> > 
> >         tglx
> > 
> 


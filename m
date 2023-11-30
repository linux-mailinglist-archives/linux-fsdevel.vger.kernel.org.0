Return-Path: <linux-fsdevel+bounces-4351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8697FED05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3784EB20D17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B673C06F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXKJQhdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415F8495
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 10:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E0BC433C8;
	Thu, 30 Nov 2023 10:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701338459;
	bh=mXRqrFM+aVKneL3d4wYNbix8eaz7ITX9BjXWcAUu8xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sXKJQhdFDvdI/0rzfJUWtzE5/4gKFeV3QfBC1F98uKIfnkLHzOTuRudSLGlSLG60U
	 VQ8tDbDqCFCS1Qzvd1wU9j70wFSnu5hEpfzG7/kX8PiSoq6byrkWTVwhd5uslO/G9q
	 +Ol0QV5ZF+MM+uOizOX02viirRwtu0gnFEiWmPghjYMyrpIzr9XAvh/y1ERHoZTfdz
	 qNdRxdQotWahlflZRYcYkHTpyxtsQI84w0Dh3MnsfAid5ezgyjcPM/Y9nmTbfXqKCG
	 rtTptIcC6au6W1CI3/Q5CHpbKVedi8Jym2gdIB2WS0wUp6XNHGF4bD4dEAzV4JTqJ1
	 qfUQj9UvIN8ww==
Date: Thu, 30 Nov 2023 05:00:54 -0500
From: Guo Ren <guoren@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
Message-ID: <ZWhdVpij9iCeMnog@gmail.com>
References: <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV>
 <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com>
 <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <ZWN0ycxvzNzVXyNQ@gmail.com>
 <CAHk-=wiehwt_aYcmAyZXyM7LWbXsne6+JWqLkMtnv=4CJT1gwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiehwt_aYcmAyZXyM7LWbXsne6+JWqLkMtnv=4CJT1gwQ@mail.gmail.com>

On Sun, Nov 26, 2023 at 08:51:35AM -0800, Linus Torvalds wrote:
> On Sun, 26 Nov 2023 at 08:39, Guo Ren <guoren@kernel.org> wrote:
> >
> > Here is my optimization advice:
> >
> > #define CMPXCHG_LOOP(CODE, SUCCESS) do {                                        \
> >         int retry = 100;                                                        \
> >         struct lockref old;                                                     \
> >         BUILD_BUG_ON(sizeof(old) != 8);                                         \
> > +       prefetchw(lockref);                                                     \\
> 
> No.
> 
> We're not adding software prefetches to generic code. Been there, done
> that. They *never* improve performance on good hardware. They end up
> helping on some random (usually particularly bad) microarchitecture,
> and then they hurt everybody else.
> 
> And the real optimization advice is: "don't run on crap hardware".
> 
> It really is that simple. Good hardware does OoO and sees the future write.
That needs the expensive mechanism DynAMO [1], but some power-efficient
core lacks the capability. Yes, powerful OoO hardware could virtually
satisfy you by a minimum number of retries, but why couldn't we
explicitly tell hardware for "prefetchw"?

Advanced hardware would treat cmpxchg as interconnect transactions when
cache miss(far atomic), which means L3 cache wouldn't return a unique
cacheline even when cmpxchg fails. The cmpxchg loop would continue to
read data bypassing the L1/L2 cache, which means every failure cmpxchg
is a cache-miss read. Because of the "new.count++"/CODE data dependency,
the continuous cmpxchg requests must wait first finish. This will cause
a gap between cmpxchg requests, which will cause most CPU's cmpxchgs
continue failling during serious contention.

   cas: Compare-And-Swap

   L1&L2          L3 cache
 +------+       +-----------
 | CPU1 | wait  |
 | cas2 |------>| CPU1_cas1 --+
 +------+       |             |
 +------+       |             |
 | CPU2 | wait  |             |
 | cas2 |------>| CPU2_cas1 --+--> If queued with CPU1_cas1 CPU2_cas1
 +------+       |             |    CPU3_cas1, and most of CPUs would
 +------+       |             |    fail and retry.
 | CPU3 | wait  |             |
 | cas2 |------>| CPU3_cas1---+
 +------+       +----------

The entire system moves forward with inefficiency:
 - A large number of invalid read requests CPU->L3
 - High power consumption
 - Poor performance

But, the “far atomic” is suitable for scenarios where contention is
not particularly serious. So it is reasonable to let the software give
prompts. That is "prefetchw":
 - The prefetchw is the preparation of "load + cmpxchg loop."
 - The prefetchw is not for single AMO or CAS or Store.

[1] https://dl.acm.org/doi/10.1145/3579371.3589065

> 
> > Micro-arch could give prefetchw more guarantee:
> 
> Well, in practice, they never do, and in fact they are often buggy and
> cause problems because they weren't actually tested very much.
> 
>                  Linus
> 


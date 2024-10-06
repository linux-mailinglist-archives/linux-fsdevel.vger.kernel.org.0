Return-Path: <linux-fsdevel+bounces-31116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED28991D8C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 11:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE72B21C65
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 09:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5771714CA;
	Sun,  6 Oct 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6s5LsbD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2514C588
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728208140; cv=none; b=dXXgR3UUtGAJWT2cBGFkn4C3TCX5u8XYdbdnyz5geFpStspprOjjMOql6HRARgyyaTBtHAz1T+cRihklNj4NCiiE7ZHnBkzzddgm1QG+78OSqcObCP13jypE8mlhAmYp5SfoAQaRLqcI8/5QejGytgSCGC01pMz7J5W594ZWY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728208140; c=relaxed/simple;
	bh=qlcUxzIxyATriuhJcUTe9A9FWGsKhyduD19BvMRqTMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpdG24hwmM8aKbWalagP3weI4DL4uIywv4PaQEylXiA8wKGDBqCkMJRZDptWHlejCN2/66BYq71pC1PK4o/jqM8yXbVAZr2hWmPHj2Qn8NCtYL+2z2YVtHnUzVscLady1ZBkxU+r/ZL4kVhMOEhd8271qVjrn+jZML49eFiXpbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6s5LsbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B34C4CEC5;
	Sun,  6 Oct 2024 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728208140;
	bh=qlcUxzIxyATriuhJcUTe9A9FWGsKhyduD19BvMRqTMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6s5LsbDZPnTxwHX9cHyeIcyKMC9UYMTIrxuRLpjH/nOwn379XlRNNbxiW/cjKU3G
	 JNjrIEOJIFLHBGfB4+PLBLNcC/SPnFAr6KO+OrNWIiEjfxZuuT0klWb8o3zjkdFOs0
	 B78hUr2WvpH0dLte/FDqneNweHLkkO2wXJnFKun2gKC5Emes/xqDRKiVau341+6bPV
	 aXAxSM/ltOusPPbooFHYXKI6T7QFDOtVfInjEWJxYq8eKzo4YOOkA9bjNHWHdkE2/r
	 h1xmSgqTBU5b/RZzrP5qqQR6+zp6n60CtivXLZFHkkgHbOWVTw7Tdw9tf3sAA5snHV
	 VJkjUgenqjl2g==
Date: Sun, 6 Oct 2024 11:48:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
Message-ID: <20241006-gewaschen-sprossen-812e28c75bbd@brauner>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
 <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>

On Sat, Oct 05, 2024 at 02:42:25PM GMT, Linus Torvalds wrote:
> On Sat, 5 Oct 2024 at 12:17, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Note that atomic_inc_not_zero() contained a full memory barrier that we
> > relied upon. But we only need an acquire barrier and so I replaced the
> > second load from the file table with a smp_load_acquire(). I'm not
> > completely sure this is correct or if we could get away with something
> > else. Linus, maybe you have input here?
> 
> I don't think this is valid.
> 
> You go from  this:
> 
>         file = rcu_dereference_raw(*f);
>         if (!file)
>                 return NULL;
>         if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
>                 return ERR_PTR(-EAGAIN);
>         file_reloaded = rcu_dereference_raw(*f);
> 
> to this:
> 
>         file = rcu_dereference_raw(*f);
>         if (!file)
>                 return NULL;
>         if (unlikely(!rcuref_long_get(&file->f_count)))
>                 return ERR_PTR(-EAGAIN);
>         file_reloaded = smp_load_acquire(f);
> 
> and the thing is, that rcuref_long_get() had better be a *full* memory barrier.
> 
> The smp_load_acquire() does absolutely nothing: it means that the load
> will be done before *subsequent* memory operations. But it is not a
> barrier to preceding memory operations.

Right, because we need the increment to be ordered against the second
load not the two loads against each other.

> 
> So if rcuref_long_get() isn't ordered (and you made it relaxed, the
> same way the existing rcuref_get() is), the CPU can basically move
> that down past the smp_load_acquire(), so the code actually
> effectively turns into this:
> 
>         file = rcu_dereference_raw(*f);
>         if (!file)
>                 return NULL;
>         file_reloaded = smp_load_acquire(f);
>         if (unlikely(!rcuref_long_get(&file->f_count)))
>                 return ERR_PTR(-EAGAIN);
> 
> and now the "file_reloaded" thing is completely pointless.
> 
> Of course, you will never *see* this on x86, because all atomics are
> always full memory barriers on x86, so when you test this all on that
> noce 256-thread CPU, it all works fine. Because on x86, the "relaxed"
> memory ordering isn't.

Yeah, I was aware of that but I don't have a 64bit arm box. It would be
nice for testing anyway.

> 
> So no. You can't use atomic_long_add_negative_relaxed() in the file
> handling, because it really does require a proper memory barrier.
> 
> Now, I do think that replacing the cmpxchg loop with
> atomic_long_add_negative() is a good idea.
> 
> But you can't do it this way, and you can't use the RCUREF logic and
> just extend it to the file ref.
> 
> I would suggest you take that whole "rcuref_long_get()" code and *not*
> try to make it look like the rcuref code, but instead make it
> explicitly just about the file counting. Because the file counting
> really does have these special rules.
> 
> Also, honestly, the only reason the file counting is using a "long" is
> because the code does *NOT* do overflow checking. But once you start
> looking at the sign and do conditional increments, you can actually
> just make the whole refcount be a "int" instead, and make "struct
> file" potentially smaller.

I've already shrunk it down to three cachelines.

> 
> And yes, that requires that people who get a file() will fail when the
> file count goes negative, but that's *good*.

Yeah, the overflow protection would be neat to have.


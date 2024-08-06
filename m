Return-Path: <linux-fsdevel+bounces-25189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20BE949AB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690EA28517C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F00C172BBC;
	Tue,  6 Aug 2024 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2uV6y7p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128C171E61;
	Tue,  6 Aug 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981677; cv=none; b=kJJCAPVcSW53fk9HPKJlzFLewFK9XUd2O4HoO8ske4XsvrGKXHAn5FrDjdWOtD34cX24ufdqnz2F2GZ6XwDz7WmJUZHqRe6/bSyZn2OxuHW6jQgUs3/Y2Kog0aCZfhu6KXcRL7TDPra/Iy3LX0bj9yi4nZPFdsR2ZcvnF/QWTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981677; c=relaxed/simple;
	bh=3O2F0dhbujAAe3QdNEIIsduxEQUZMXrFfkhNOLE8mJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBo5PpXHRrDitvP58cH4a4eFPtaDZ2K6cnbdqpY+hpg3iXdZ76nab+m8IOxYt6wm+m4ywqdy5SAD9k3CUVyyZ2vKumF/xIIlEtDnFlvIeZY4rEKYHsstBfd0/ZmfiapcfXlOjlvdymLl8+aDPXtRzPDfppTohp6lQ1dyy5lQyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2uV6y7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C6AC4AF10;
	Tue,  6 Aug 2024 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722981676;
	bh=3O2F0dhbujAAe3QdNEIIsduxEQUZMXrFfkhNOLE8mJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P2uV6y7piAQ2bFmzGGGGvAfoQ8eJjOXelGUVftgvXw+nBV/Aq2L+ZxHMIrRmBRREE
	 qmC89YOlLMRzo3c9MSWDhsfABmQlJhLAGmJb67fzkCpBk9RZaKsgfmGvb7cjOjtVir
	 T0ikzr+6GL4bSXa9uPKGrDFq/bq4pLtoi0W3R8yOf13qBUAtx+0fegqQXlvmBZ5Eeq
	 0ku0gXS0lU/q0U2UG9dIqdtaTWOBLiipp61Ws9VOUcp0vWWiHsl/0DU6+TiOH8SPQz
	 xOt51yKhogO9FAx7GDxx1ZvUHaLtTOuPMGeoo4VmGtJ+TqDgtjky5/Gz2KwikMNPx4
	 RBfrKCrBFPXAQ==
Date: Tue, 6 Aug 2024 15:01:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
	tglx@linutronix.de
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240806220116.GH623957@frogsfrogsfrogs>
References: <20240730033849.GH6352@frogsfrogsfrogs>
 <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240730132626.GV26599@noisy.programming.kicks-ass.net>
 <20240731001950.GN6352@frogsfrogsfrogs>
 <20240731031033.GP6352@frogsfrogsfrogs>
 <20240731053341.GQ6352@frogsfrogsfrogs>
 <20240731105557.GY33588@noisy.programming.kicks-ass.net>
 <20240805143522.GA623936@frogsfrogsfrogs>
 <20240806094413.GS37996@noisy.programming.kicks-ass.net>
 <20240806103808.GT37996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806103808.GT37996@noisy.programming.kicks-ass.net>

On Tue, Aug 06, 2024 at 12:38:08PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 06, 2024 at 11:44:13AM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 05, 2024 at 07:35:22AM -0700, Darrick J. Wong wrote:
> > > On Wed, Jul 31, 2024 at 12:55:57PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Jul 30, 2024 at 10:33:41PM -0700, Darrick J. Wong wrote:
> > > > 
> > > > > Sooooo... it turns out that somehow your patch got mismerged on the
> > > > > first go-round, and that worked.  The second time, there was no
> > > > > mismerge, which mean that the wrong atomic_cmpxchg() callsite was
> > > > > tested.
> > > > > 
> > > > > Looking back at the mismerge, it actually changed
> > > > > __static_key_slow_dec_cpuslocked, which had in 6.10:
> > > > > 
> > > > > 	if (atomic_dec_and_test(&key->enabled))
> > > > > 		jump_label_update(key);
> > > > > 
> > > > > Decrement, then return true if the value was set to zero.  With the 6.11
> > > > > code, it looks like we want to exchange a 1 with a 0, and act only if
> > > > > the previous value had been 1.
> > > > > 
> > > > > So perhaps we really want this change?  I'll send it out to the fleet
> > > > > and we'll see what it reports tomorrow morning.
> > > > 
> > > > Bah yes, I missed we had it twice. Definitely both sites want this.
> > > > 
> > > > I'll tentatively merge the below patch in tip/locking/urgent. I can
> > > > rebase if there is need.
> > > 
> > > Hi Peter,
> > > 
> > > This morning, I noticed the splat below with -rc2.
> > > 
> > > WARNING: CPU: 0 PID: 8578 at kernel/jump_label.c:295 __static_key_slow_dec_cpuslocked.part.0+0x50/0x60
> > > 
> > > Line 295 is the else branch of this code:
> > > 
> > > 	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
> > > 		jump_label_update(key);
> > > 	else
> > > 		WARN_ON_ONCE(!static_key_slow_try_dec(key));
> > > 
> > > Apparently static_key_slow_try_dec returned false?  Looking at that
> > > function, I suppose the atomic_read of key->enabled returned 0, since it
> > > didn't trigger the "WARN_ON_ONCE(v < 0)" code.  Does that mean the value
> > > must have dropped from positive N to 0 without anyone ever taking the
> > > jump_label_mutex?
> > 
> > One possible scenario I see:
> > 
> >   slow_dec
> >     if (try_dec) // dec_not_one-ish, false
> >     // enabled == 1
> > 				slow_inc
> > 				  if (inc_not_disabled) // inc_not_zero-ish
> > 				  // enabled == 2
> > 				    return
> > 
> >     guard((mutex)(&jump_label_mutex);
> >     if (atomic_cmpxchg(1,0)==1) // false, we're 2
> >     
> > 				slow_dec
> > 				  if (try-dec) // dec_not_one, true
> > 				  // enabled == 1
> > 				    return
> >     else
> >       try_dec() // dec_not_one, false
> >       WARN
> > 
> > 
> > Let me go play to see how best to cure this.
> 
> I've ended up with this, not exactly pretty :/
> 
> Thomas?

It seems to survive a short test, will send it out for overnight testing
on the full fleet, thanks.

--D

> ---
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 6dc76b590703..5fa2c9f094b1 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -168,8 +168,8 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
>  		jump_label_update(key);
>  		/*
>  		 * Ensure that when static_key_fast_inc_not_disabled() or
> -		 * static_key_slow_try_dec() observe the positive value,
> -		 * they must also observe all the text changes.
> +		 * static_key_dec() observe the positive value, they must also
> +		 * observe all the text changes.
>  		 */
>  		atomic_set_release(&key->enabled, 1);
>  	} else {
> @@ -250,7 +250,7 @@ void static_key_disable(struct static_key *key)
>  }
>  EXPORT_SYMBOL_GPL(static_key_disable);
>  
> -static bool static_key_slow_try_dec(struct static_key *key)
> +static bool static_key_dec(struct static_key *key, bool fast)
>  {
>  	int v;
>  
> @@ -268,31 +268,45 @@ static bool static_key_slow_try_dec(struct static_key *key)
>  	v = atomic_read(&key->enabled);
>  	do {
>  		/*
> -		 * Warn about the '-1' case though; since that means a
> -		 * decrement is concurrent with a first (0->1) increment. IOW
> -		 * people are trying to disable something that wasn't yet fully
> -		 * enabled. This suggests an ordering problem on the user side.
> +		 * Warn about the '-1' case; since that means a decrement is
> +		 * concurrent with a first (0->1) increment. IOW people are
> +		 * trying to disable something that wasn't yet fully enabled.
> +		 * This suggests an ordering problem on the user side.
> +		 *
> +		 * Warn about the '0' case; simple underflow.
> +		 *
> +		 * Neither case should succeed and change things.
> +		 */
> +		if (WARN_ON_ONCE(v <= 0))
> +			return false;
> +
> +		/*
> +		 * Lockless fast-path, dec-not-one like behaviour.
>  		 */
> -		WARN_ON_ONCE(v < 0);
> -		if (v <= 1)
> +		if (fast && v <= 1)
>  			return false;
>  	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
>  
> -	return true;
> +	if (fast)
> +		return true;
> +
> +	/*
> +	 * Locked slow path, dec-and-test like behaviour.
> +	 */
> +	lockdep_assert_held(&jump_label_mutex);
> +	return v == 1;
>  }
>  
>  static void __static_key_slow_dec_cpuslocked(struct static_key *key)
>  {
>  	lockdep_assert_cpus_held();
>  
> -	if (static_key_slow_try_dec(key))
> +	if (static_key_dec(key, true)) // dec-not-one
>  		return;
>  
>  	guard(mutex)(&jump_label_mutex);
> -	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
> +	if (static_key_dec(key, false)) // dec-and-test
>  		jump_label_update(key);
> -	else
> -		WARN_ON_ONCE(!static_key_slow_try_dec(key));
>  }
>  
>  static void __static_key_slow_dec(struct static_key *key)
> @@ -329,7 +343,7 @@ void __static_key_slow_dec_deferred(struct static_key *key,
>  {
>  	STATIC_KEY_CHECK_USE(key);
>  
> -	if (static_key_slow_try_dec(key))
> +	if (static_key_dec(key, true)) // dec-not-one
>  		return;
>  
>  	schedule_delayed_work(work, timeout);


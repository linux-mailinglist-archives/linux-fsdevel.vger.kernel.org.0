Return-Path: <linux-fsdevel+bounces-25312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0F94AA33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9462812ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF57BAE3;
	Wed,  7 Aug 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b6bd+2AY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351D2B9A1;
	Wed,  7 Aug 2024 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041252; cv=none; b=r/QGkQtu5RWcYy4f3RkOjt+Y6VmPROHnelbBitB73F/ZdSUfOPbVC/OKjuZ/1oXZT1qVRHtZ4ayqgHbHIYEuMEXMEhx4goHBO20LwL8Xmp+I9BZRr/hOGT/v/AaNNCjJuUekTiMGOn3HzaHt0unoAv1qXFEeYddaNXP9tJIDpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041252; c=relaxed/simple;
	bh=WqkhNT4x7/zQlM4AhmFxq4Q+ZY4U6nP+ET/fhr6SeRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6ZJSGr+DmnqQ91Fxv8Rfv9MXIs4F4kn8b9DK+8pNIZFkn4ew+u1U1OdC6W1GaZnVI3lDksA+XNS7pi4hYtyxSW4FuvGbclxjogXmWFQztPljTmxA5Tj7CCPbCrrJMeQ7Brp/OCAgwSM0NVPkrRz+6naxmB/gGaueqsKF6gKYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b6bd+2AY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jkNguGjcftL7vwINObLdbFR92eHWY0kd9agR1JH7w6w=; b=b6bd+2AYpZJxUv+Pl0+aUW9ZdA
	ilPREVFTAntdp7SYyHawfVlrWu9oa7IHIfMO5V+7Z+b4VrS2ZfNLgfZBwSvRaRCy67DLaTIIZ2YXI
	8rlaRX7BWS3Z7WE6vWo2Bg+LRH/nqyczCM0fx01lYC8s2xL9bk6vJ/2KDhfBX1bHeVxa4Z/L9Ct93
	6t5xMXboQVgxMNg0lpVNnChlPtzGGPnnfoPaBmlZ0rZotJ7+3khUYKrOJaI0FIHHs0Y6uEmCurd0p
	CjgPhlb/jUBV3U+GXdbu/pPkMKdcDV2ZJ/nM2GuCVfobyLNR9UGMbA+3B/nEEt+yP1UPE70n9Knuf
	PHdMhTWQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbhjs-00000006dRC-1A60;
	Wed, 07 Aug 2024 14:34:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 65FB830033D; Wed,  7 Aug 2024 16:34:07 +0200 (CEST)
Date: Wed, 7 Aug 2024 16:34:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240807143407.GC31338@noisy.programming.kicks-ass.net>
References: <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240730132626.GV26599@noisy.programming.kicks-ass.net>
 <20240731001950.GN6352@frogsfrogsfrogs>
 <20240731031033.GP6352@frogsfrogsfrogs>
 <20240731053341.GQ6352@frogsfrogsfrogs>
 <20240731105557.GY33588@noisy.programming.kicks-ass.net>
 <20240805143522.GA623936@frogsfrogsfrogs>
 <20240806094413.GS37996@noisy.programming.kicks-ass.net>
 <20240806103808.GT37996@noisy.programming.kicks-ass.net>
 <875xsc4ehr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xsc4ehr.ffs@tglx>

On Wed, Aug 07, 2024 at 04:03:12PM +0200, Thomas Gleixner wrote:

> > +	if (static_key_dec(key, true)) // dec-not-one
> 
> Eeew.

:-) I knew you'd hate on that

> Something like the below?
> 
> Thanks,
> 
>         tglx
> ---
> @@ -250,49 +250,71 @@ void static_key_disable(struct static_ke
>  }
>  EXPORT_SYMBOL_GPL(static_key_disable);
>  
> -static bool static_key_slow_try_dec(struct static_key *key)
> +static bool static_key_dec(struct static_key *key, bool dec_not_one)
>  {
> +	int v = atomic_read(&key->enabled);
>  
>  	do {
>  		/*
> +		 * Warn about the '-1' case; since that means a decrement is
> +		 * concurrent with a first (0->1) increment. IOW people are
> +		 * trying to disable something that wasn't yet fully enabled.
> +		 * This suggests an ordering problem on the user side.
> +		 *
> +		 * Warn about the '0' case; simple underflow.
>  		 */
> +		if (WARN_ON_ONCE(v <= 0))
> +			return v;
> +
> +		if (dec_not_one && v == 1)
> +			return v;
> +
>  	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
>  
> +	return v;
> +}
> +
> +/*
> + * Fastpath: Decrement if the reference count is greater than one
> + *
> + * Returns false, if the reference count is 1 or -1 to force the caller
> + * into the slowpath.
> + *
> + * The -1 case is to handle a decrement during a concurrent first enable,
> + * which sets the count to -1 in static_key_slow_inc_cpuslocked(). As the
> + * slow path is serialized the caller will observe 1 once it acquired the
> + * jump_label_mutex, so the slow path can succeed.
> + */
> +static bool static_key_dec_not_one(struct static_key *key)
> +{
> +	int v = static_key_dec(key, true);
> +
> +	return v != 1 && v != -1;

	if (v < 0)
		return false;

	/*
	 * Notably, 0 (underflow) returns true such that it bails out
	 * without doing anything.
	 */
	return v != 1;

Perhaps?

> +}
> +
> +/*
> + * Slowpath: Decrement and test whether the refcount hit 0.
> + *
> + * Returns true if the refcount hit zero, i.e. the previous value was one.
> + */
> +static bool static_key_dec_and_test(struct static_key *key)
> +{
> +	int v = static_key_dec(key, false);
> +
> +	lockdep_assert_held(&jump_label_mutex);
> +	return v == 1;
>  }

But yeah, this is nicer!


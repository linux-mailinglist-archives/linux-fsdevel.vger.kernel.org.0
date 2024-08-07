Return-Path: <linux-fsdevel+bounces-25320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9332994AAC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E001C21C6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15528175F;
	Wed,  7 Aug 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZM0z8jH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sM6c1+/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39980611;
	Wed,  7 Aug 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042557; cv=none; b=RYv5fjeyllc24sGv2FnvzxIw5BA+6d87SZ0fDimE2YDB0nvcdPbv0iJOwZjuNjd1mltl7HX0YRCg84PZcNgVHXwrXi21Y7PySsP6YAp+4fJFSBvtsStQ+YpsR9QRbO8wzl0yLzion4sdjujkEGI2LVQ81hzlQHTf+rZeEYLHzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042557; c=relaxed/simple;
	bh=pCh0QTCzKuTwxpJi7m4EvWhJ590B+sM2LRLozH6+H4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rbjkpVjRXTDmbKKh8PvD7LpdT8Gt5k+GSmHB7TEzM/jbk7mFVYcBYRuK1z/GvHx62P7Bh6TK38jSlgcBNaxPrB6R2qTGNddzgdyNhmfo5D5zNU/cN75U3ryi3F1nWp2czvsj4TwD0ZO2HqUZrZGzDpgoeZ9XkIdrOFPcxWnUPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZM0z8jH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sM6c1+/G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723042553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/PqSPq5J2V5SxAq6EKi7bTelvIqzFyX/Zbc6FDTSbY=;
	b=IZM0z8jHha2AVen6B9WWK4nUorYAiuZF3ju4+y5VjStJiUnvhIiugbBWXPT/mCWe3Dt8d7
	quPRlXUhl92ELXdnfJLgFh58we4frengzX80JKP3yi7v72SBn0ZVwdKRB1XJErawztTklU
	X0TpQ/pUU7WADJbsn4yoITcYciTrxoe3BdrIdqdf9NmrY6OGYf+v/DCwxM/TU8pV3gTd4m
	brVEZuXwywAtJ4yCclwN+cxQrGvBb7TMVBaeSgpkZWL49VS7WUpW1EFv6cPohm5iIJqEwJ
	Mm+yCln0Hpiwr+2srflPzaQcDwU82GCmFwtWhkS0Sm9JH7hcszoTZm5ruA7NaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723042553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/PqSPq5J2V5SxAq6EKi7bTelvIqzFyX/Zbc6FDTSbY=;
	b=sM6c1+/Gn9dQ1A4igB2LOsyC/0EY8RYDqUBp8EDPVxKSmkesK5rGsM4B9es4qm98WI2DQp
	4DoCF4bCsowfU8Bg==
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chandan Babu R
 <chandanbabu@kernel.org>, Matthew Wilcox <willy@infradead.org>, xfs
 <linux-xfs@vger.kernel.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: Are jump labels broken on 6.11-rc1?
In-Reply-To: <20240807143407.GC31338@noisy.programming.kicks-ass.net>
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
 <20240807143407.GC31338@noisy.programming.kicks-ass.net>
Date: Wed, 07 Aug 2024 16:55:53 +0200
Message-ID: <87wmks2xhi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 07 2024 at 16:34, Peter Zijlstra wrote:
> On Wed, Aug 07, 2024 at 04:03:12PM +0200, Thomas Gleixner wrote:
>
>> > +	if (static_key_dec(key, true)) // dec-not-one
>> 
>> Eeew.
>
> :-) I knew you'd hate on that

So you added it just to make me grumpy enough to fix it for you, right?

>> +/*
>> + * Fastpath: Decrement if the reference count is greater than one
>> + *
>> + * Returns false, if the reference count is 1 or -1 to force the caller
>> + * into the slowpath.
>> + *
>> + * The -1 case is to handle a decrement during a concurrent first enable,
>> + * which sets the count to -1 in static_key_slow_inc_cpuslocked(). As the
>> + * slow path is serialized the caller will observe 1 once it acquired the
>> + * jump_label_mutex, so the slow path can succeed.
>> + */
>> +static bool static_key_dec_not_one(struct static_key *key)
>> +{
>> +	int v = static_key_dec(key, true);
>> +
>> +	return v != 1 && v != -1;
>
> 	if (v < 0)
> 		return false;

Hmm. I think we should do:

#define KEY_ENABLE_IN_PROGRESS		-1

or even a more distinct value like (INT_MIN / 2)

and replace all the magic -1 numbers with it. Then the check becomes
explicit:

        if (v == KEY_ENABLE_IN_PROGRESS)
        	return false;

> 	/*
> 	 * Notably, 0 (underflow) returns true such that it bails out
> 	 * without doing anything.
> 	 */
> 	return v != 1;
>
> Perhaps?

Sure.

>> +}
>> +
>> +/*
>> + * Slowpath: Decrement and test whether the refcount hit 0.
>> + *
>> + * Returns true if the refcount hit zero, i.e. the previous value was one.
>> + */
>> +static bool static_key_dec_and_test(struct static_key *key)
>> +{
>> +	int v = static_key_dec(key, false);
>> +
>> +	lockdep_assert_held(&jump_label_mutex);
>> +	return v == 1;
>>  }
>
> But yeah, this is nicer!

:)

Thanks,

        tglx


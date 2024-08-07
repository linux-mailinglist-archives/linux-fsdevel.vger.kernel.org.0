Return-Path: <linux-fsdevel+bounces-25323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1194AB66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 17:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471B41F2856E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 15:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC6912AAC6;
	Wed,  7 Aug 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amhx43EE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C1E85260;
	Wed,  7 Aug 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043104; cv=none; b=prywxcmg8VkkCJHVv2pfGFdnks9/w+SHHfQXyeDv2UG4+U1MqIo8igZPf/DELo7vSI1id1Wa/A9tHA+N/x+UnFDj7zKY/X4Toz/7v+Ld51AdTCYehCAlOswiP3Ru2N27AWBh4YiXAHx7D8urv5uZxGtvytU832gBOyPVFlhavks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043104; c=relaxed/simple;
	bh=SON7N8k6UkNd7FbM5lJZtVzzXQPqSyE42P7od40nS48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOhEHoiwITYRckljUpMy2V8kDTDJuBG6PhQnfVSd8fvgaTcw8ijzO/7CHW8Z3RsVmprKqAOr6rjUS4hZtoSp13iOkBFExykduQOIlEAAAUUwGUpNOHJ2+KwhPpm5B2GqKyBqho1Mij+UBirLva7acq1bvDyPX/ujhQnUGGrOSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amhx43EE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00E4C4AF0D;
	Wed,  7 Aug 2024 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723043103;
	bh=SON7N8k6UkNd7FbM5lJZtVzzXQPqSyE42P7od40nS48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Amhx43EER3PtJ0PDPyhuXsFnIw9/O3th6dr/8OYvyCURztLgIcUDj/6r1illec8w6
	 4aiDq4ylFmHw47V9zR4C8ut8WUG206lLrwem58tqdDlY7bzUxoOpBp9jFUFBfzyHap
	 b77uDCAMeUaDLy8Ad+ww6ADeoVxHrkj/AYzybu43mUXOsXjlyzQixrXD63M7aUJB4O
	 M7ISfBOhiz6HUN429jK/TrPC/o4SWXkNm6Tyc+IskNgzWMe0DNi1qQTOJiarpYgN/I
	 ZXvmQN2ISVtWO/DK0oJbmwMC5zYEvVevK5o+FEefaXmlvfVkMs8BwO2ecsVioJu22X
	 yHGdZTx4XqxwA==
Date: Wed, 7 Aug 2024 08:05:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240807150503.GF6051@frogsfrogsfrogs>
References: <20240731001950.GN6352@frogsfrogsfrogs>
 <20240731031033.GP6352@frogsfrogsfrogs>
 <20240731053341.GQ6352@frogsfrogsfrogs>
 <20240731105557.GY33588@noisy.programming.kicks-ass.net>
 <20240805143522.GA623936@frogsfrogsfrogs>
 <20240806094413.GS37996@noisy.programming.kicks-ass.net>
 <20240806103808.GT37996@noisy.programming.kicks-ass.net>
 <875xsc4ehr.ffs@tglx>
 <20240807143407.GC31338@noisy.programming.kicks-ass.net>
 <87wmks2xhi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmks2xhi.ffs@tglx>

On Wed, Aug 07, 2024 at 04:55:53PM +0200, Thomas Gleixner wrote:
> On Wed, Aug 07 2024 at 16:34, Peter Zijlstra wrote:
> > On Wed, Aug 07, 2024 at 04:03:12PM +0200, Thomas Gleixner wrote:
> >
> >> > +	if (static_key_dec(key, true)) // dec-not-one
> >> 
> >> Eeew.
> >
> > :-) I knew you'd hate on that
> 
> So you added it just to make me grumpy enough to fix it for you, right?

FWIW with peter's 'ugly' patch applied, fstests didn't cough up any
static key complaints overnight.

> >> +/*
> >> + * Fastpath: Decrement if the reference count is greater than one
> >> + *
> >> + * Returns false, if the reference count is 1 or -1 to force the caller
> >> + * into the slowpath.
> >> + *
> >> + * The -1 case is to handle a decrement during a concurrent first enable,
> >> + * which sets the count to -1 in static_key_slow_inc_cpuslocked(). As the
> >> + * slow path is serialized the caller will observe 1 once it acquired the
> >> + * jump_label_mutex, so the slow path can succeed.
> >> + */
> >> +static bool static_key_dec_not_one(struct static_key *key)
> >> +{
> >> +	int v = static_key_dec(key, true);
> >> +
> >> +	return v != 1 && v != -1;
> >
> > 	if (v < 0)
> > 		return false;
> 
> Hmm. I think we should do:
> 
> #define KEY_ENABLE_IN_PROGRESS		-1
> 
> or even a more distinct value like (INT_MIN / 2)
> 
> and replace all the magic -1 numbers with it. Then the check becomes
> explicit:
> 
>         if (v == KEY_ENABLE_IN_PROGRESS)
>         	return false;
> 
> > 	/*
> > 	 * Notably, 0 (underflow) returns true such that it bails out
> > 	 * without doing anything.
> > 	 */
> > 	return v != 1;
> >
> > Perhaps?
> 
> Sure.
> 
> >> +}
> >> +
> >> +/*
> >> + * Slowpath: Decrement and test whether the refcount hit 0.
> >> + *
> >> + * Returns true if the refcount hit zero, i.e. the previous value was one.
> >> + */
> >> +static bool static_key_dec_and_test(struct static_key *key)
> >> +{
> >> +	int v = static_key_dec(key, false);
> >> +
> >> +	lockdep_assert_held(&jump_label_mutex);
> >> +	return v == 1;
> >>  }
> >
> > But yeah, this is nicer!
> 
> :)

It probably goes without saying that if either of you send a cleaned up
patch with all these changes baked in, I will test it for you all. :)

--D

> 
> Thanks,
> 
>         tglx
> 


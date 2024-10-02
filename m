Return-Path: <linux-fsdevel+bounces-30702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB6398DA8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219A21F218AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D108D1D12E6;
	Wed,  2 Oct 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QjG1JrIy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ylouc4cZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0691D0DED;
	Wed,  2 Oct 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878626; cv=none; b=PZguxEX7Peidaf3PDcKU3luhaZYvrcvp2kNcU8dpSO5LmEp5IRDGDfxO8zQ0g4BvUBM4nwNr1k/9Pdnj8M2xPt7Cp65asiIu2osQ0vorLy+xhKRnwS85Aken7NZnY4eqLxhGCV6oM/t3tflHMIkmbr40UbAPwmf1b8Ab56tHiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878626; c=relaxed/simple;
	bh=xpvHwwmdO3eqrkURj8Y+rlVSEXmxn77Ygc+a06eVTRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rP0MRlNVmzTWEWa0iFWIx+ZkILJORMtpR7qBM0BRjo9KKSd+OE3PuVxIcEcNBe0tJRo47wy90MWYRk7SKgjgNAOoUW9i3pydgkcJMrkdJs4MwRcbf2IU2vOn3TVpdR5oLgqWVFC1X2FPWa4ZGjGvuMgdFlaDsoQzqQJEQpK0eTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QjG1JrIy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ylouc4cZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727878620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7i4rK6W5zJ0/yjJszcGEJbo9yZLPfZxTe1UrEGBeh8s=;
	b=QjG1JrIylWzjxiXp1whjsFK9TUMeqt2bSYE8DiPOFO5i8RyuIyjUOSk0JeXZrSfJl2K9w+
	gyOtbGT26MGm9HwukROwgsLGE9R2Z7SzFrx3kAEzPRDeMG7yh9uUp7NVAsRq9snzhqQe77
	toOLZztyH9NBtNUljdzrNwtOvXUyOrPKK9VkJX7lyXWeWreL2pDUA/q++KS3WnylvxU86o
	viwUkVCpG9RFAGWnoiNFu7W/TfF7dYDSatgkkceV9sePjhgFZxGd4PtDsuEKfF1av3bD3x
	trsyUhwbntn3Bx7X5vvWgcD5qhuPK/N0nVYpUif0NAFxMMohpzGGWj2zlxQO5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727878620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7i4rK6W5zJ0/yjJszcGEJbo9yZLPfZxTe1UrEGBeh8s=;
	b=ylouc4cZ0hfaX61gauH/9wkiYjDPiyaoj7UxIpSQUmkhbFC3z1xq3zRd95zob83mHdyaj7
	fIZMz4gyPFqWU/Cw==
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Chandan Babu R
 <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
 <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Chuck Lever <chuck.lever@oracle.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v8 01/12] timekeeping: add interfaces for handling
 timestamps with a floor value
In-Reply-To: <20241001-mgtime-v8-1-903343d91bc3@kernel.org>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
 <20241001-mgtime-v8-1-903343d91bc3@kernel.org>
Date: Wed, 02 Oct 2024 16:16:59 +0200
Message-ID: <87zfnmwpwk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 01 2024 at 06:58, Jeff Layton wrote:

V8 ? I remember that I reviewed v* already :)

Also the sentence after the susbsystem prefix starts with an uppercase
letter.

> Multigrain timestamps allow the kernel to use fine-grained timestamps
> when an inode's attributes is being actively observed via ->getattr().
> With this support, it's possible for a file to get a fine-grained
> timestamp, and another modified after it to get a coarse-grained stamp
> that is earlier than the fine-grained time.  If this happens then the
> files can appear to have been modified in reverse order, which breaks
> VFS ordering guarantees.
>
> To prevent this, maintain a floor value for multigrain timestamps.
> Whenever a fine-grained timestamp is handed out, record it, and when
> coarse-grained stamps are handed out, ensure they are not earlier than
> that value. If the coarse-grained timestamp is earlier than the
> fine-grained floor, return the floor value instead.
>
> Add a static singleton atomic64_t into timekeeper.c that we can use to

s/we can use/is used/

> keep track of the latest fine-grained time ever handed out. This is
> tracked as a monotonic ktime_t value to ensure that it isn't affected by
> clock jumps. Because it is updated at different times than the rest of
> the timekeeper object, the floor value is managed independently of the
> timekeeper via a cmpxchg() operation, and sits on its own cacheline.
>
> This patch also adds two new public interfaces:

git grep 'This patch' Docuementation/process/

> - ktime_get_coarse_real_ts64_mg() fills a timespec64 with the later of the
>   coarse-grained clock and the floor time
>
> - ktime_get_real_ts64_mg() gets the fine-grained clock value, and tries
>   to swap it into the floor. A timespec64 is filled with the result.
>
> Since the floor is global, take care to avoid updating it unless it's
> absolutely necessary. If we do the cmpxchg and find that the value has

We do nothing. Please describe your changes in passive voice and do not
impersonate code.

> been updated since we fetched it, then we discard the fine-grained time
> that was fetched in favor of the recent update.

This still is confusing. Something like this:

  The floor value is global and updated via a single try_cmpxchg(). If
  that fails then the operation raced with a concurrent update. It does
  not matter whether the new value is later than the value, which the
  failed cmpxchg() tried to write, or not. Add sensible technical
  explanation.

> +/*
> + * Multigrain timestamps require that we keep track of the latest fine-grained
> + * timestamp that has been issued, and never return a coarse-grained timestamp
> + * that is earlier than that value.
> + *
> + * mg_floor represents the latest fine-grained time that we have handed out as
> + * a timestamp on the system. Tracked as a monotonic ktime_t, and converted to
> + * the realtime clock on an as-needed basis.
> + *
> + * This ensures that we never issue a timestamp earlier than one that has
> + * already been issued, as long as the realtime clock never experiences a
> + * backward clock jump. If the realtime clock is set to an earlier time, then
> + * realtime timestamps can appear to go backward.
> + */
> +static __cacheline_aligned_in_smp atomic64_t mg_floor;
> +
>  static inline void tk_normalize_xtime(struct timekeeper *tk)
>  {
>  	while (tk->tkr_mono.xtime_nsec >= ((u64)NSEC_PER_SEC << tk->tkr_mono.shift)) {
> @@ -2394,6 +2410,86 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
>  }
>  EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
>  
> +/**
> + * ktime_get_coarse_real_ts64_mg - return latter of coarse grained time or floor
> + * @ts: timespec64 to be filled
> + *
> + * Fetch the global mg_floor value, convert it to realtime and
> + * compare it to the current coarse-grained time. Fill @ts with
> + * whichever is latest. Note that this is a filesystem-specific
> + * interface and should be avoided outside of that context.
> + */
> +void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	u64 floor = atomic64_read(&mg_floor);
> +	ktime_t f_real, offset, coarse;
> +	unsigned int seq;
> +
> +	do {
> +		seq = read_seqcount_begin(&tk_core.seq);
> +		*ts = tk_xtime(tk);
> +		offset = tk_core.timekeeper.offs_real;
> +	} while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +	coarse = timespec64_to_ktime(*ts);
> +	f_real = ktime_add(floor, offset);
> +	if (ktime_after(f_real, coarse))
> +		*ts = ktime_to_timespec64(f_real);
> +}
> +EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_mg);
> +
> +/**
> + * ktime_get_real_ts64_mg - attempt to update floor value and return result
> + * @ts:		pointer to the timespec to be set
> + *
> + * Get a monotonic fine-grained time value and attempt to swap it into the
> + * floor. If it succeeds then accept the new floor value. If it fails
> + * then another task raced in during the interim time and updated the floor.
> + * That value is just as valid, so accept that value in this case.

Why? 'just as valid' does not tell me anything.

> + * @ts will be filled with the resulting floor value, regardless of
> + * the outcome of the swap. Note that this is a filesystem specific interface
> + * and should be avoided outside of that context.
> + */
> +void ktime_get_real_ts64_mg(struct timespec64 *ts)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	ktime_t old = atomic64_read(&mg_floor);
> +	ktime_t offset, mono;
> +	unsigned int seq;
> +	u64 nsecs;
> +
> +	do {
> +		seq = read_seqcount_begin(&tk_core.seq);
> +
> +		ts->tv_sec = tk->xtime_sec;
> +		mono = tk->tkr_mono.base;
> +		nsecs = timekeeping_get_ns(&tk->tkr_mono);
> +		offset = tk_core.timekeeper.offs_real;
> +	} while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +	mono = ktime_add_ns(mono, nsecs);
> +
> +	/*
> +	 * Attempt to update the floor with the new time value. Accept the
> +	 * resulting floor value regardless of the outcome of the swap.
> +	 */
> +	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
> +		ts->tv_nsec = 0;
> +		timespec64_add_ns(ts, nsecs);
> +	} else {
> +		/*
> +		 * Something has changed mg_floor since "old" was

I complained about 'something has changed ...' before. Can we please
have proper technical explanations?

> +		 * fetched. "old" has now been updated with the
> +		 * current value of mg_floor, so use that to return
> +		 * the current coarse floor value.

This still does not explain why the new floor value is valid even when
it is before the value in @mono.

Thanks,

        tglx


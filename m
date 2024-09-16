Return-Path: <linux-fsdevel+bounces-29448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD6E979EFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA01284B9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF5014F9FB;
	Mon, 16 Sep 2024 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1sVvDod";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ft94qdf3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542DD14BFB0;
	Mon, 16 Sep 2024 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481581; cv=none; b=PpixcNevIYC8HE6xL65nbcSMlvo04w3Zh0Ttiq5XmzgmHVsIask1/9Ha8cvrAhbg1N5xgY86WMQZmcHnIHbte+CffDOJNAxEC4KV+Kvsn+TpAxTlsLOAClPXasIJEnYfQ8df7lLa0WAQ8heEFX4GFC8hO4SUWlQ8337TCgr0TY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481581; c=relaxed/simple;
	bh=7f22G+6r66QEwau72pU8x4w4ZuPvjQGUXc8asSZd1lI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UaOQMJm1JaeMiVU4tSZDBhKKOVC8Npq/iseFUs9P0hqGQnXuAzTS0QaMYDLAm2KtGr8cahzyH8fEGuRkvV0J877xTTfvcJmOHCEpYbxjKRVrqrTLSc5bKKLGBtdVqG9lmJW64aTDVViwW/x3tfl6Gbg58ZjoGEFdwqn5/Lr9qgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v1sVvDod; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ft94qdf3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726481577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v3ll6KO8H5UrZC6yCuHnxrKwZc40QeoVwfA712SGpCg=;
	b=v1sVvDodszPQaC6MYGfaSe4O0YiaY1fze0PmCKJ6c2G23tPz7qhE8S1B1sLtwUgWIXMmak
	lcl5g5XiApkWPI1SCVyw7s9z1iO9KN6mpCWlZuVUdZluKI8O4fUF6eIdjm1NesbAgwTjm9
	L5r8Exaw6kxoLg3DrFsWi8+mp8bsCM3zkFSSojxJ6whDP0q0k1EnEEodbLafdu9xFs6uaz
	8eHdofzdFoTnlGmddqeYRaFKXUxsd24x8fzw0LItUenj5KjkqN5heAotraD7Uf01iomULo
	x3kKNZ67/a7jl0TuyFLafUFm2vFpo2t7LtFrG+RNKJkiP8/m8yTSt9sPqggSzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726481577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v3ll6KO8H5UrZC6yCuHnxrKwZc40QeoVwfA712SGpCg=;
	b=ft94qdf3mKKez4Fq6giUKHTG2x5ATRcMmRN9N6Lxg1hlqvpyZTzutygIeaN9KywFwHwHHJ
	c1DaKC+nUT0MDZDQ==
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Chuck Lever
 <chuck.lever@oracle.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, Jeff Layton
 <jlayton@kernel.org>
Subject: Re: [PATCH v8 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
In-Reply-To: <20240914-mgtime-v8-1-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-1-5bd872330bed@kernel.org>
Date: Mon, 16 Sep 2024 12:12:55 +0200
Message-ID: <87a5g79aag.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Sep 14 2024 at 13:07, Jeff Layton wrote:
> For multigrain timestamps, we must keep track of the latest timestamp

What is a multgrain timestamp? Can you please describe the concept
behind it? I'm not going to chase random documentation or whatever
because change logs have to self contained.

And again 'we' do nothing. Describe the problem in technical terms and
do not impersonate code.

> To maximize the window of this occurring when multiple tasks are racing
> to update the floor, ktime_get_coarse_real_ts64_mg returns a cookie
> value that represents the state of the floor tracking word, and
> ktime_get_real_ts64_mg accepts a cookie value that it uses as the "old"
> value when calling cmpxchg().

Clearly:

> +void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)

Can you please get your act together?

> +/**
> + * ktime_get_coarse_real_ts64_mg - get later of coarse grained time or floor
> + * @ts: timespec64 to be filled
> + *
> + * Adjust floor to realtime and compare it to the coarse time. Fill
> + * @ts with the latest one.

This explains nothing.

>      Note that this is a filesystem-specific
> + * interface and should be avoided outside of that context.
> + */
> +void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	u64 floor = atomic64_read(&mg_floor);
> +	ktime_t f_real, offset, coarse;
> +	unsigned int seq;
> +
> +	WARN_ON(timekeeping_suspended);
> +
> +	do {
> +		seq = read_seqcount_begin(&tk_core.seq);
> +		*ts = tk_xtime(tk);
> +		offset = *offsets[TK_OFFS_REAL];

Why this indirection? What's wrong with using
tk_core.timekeeper.offs_real directly?

> +	} while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +	coarse = timespec64_to_ktime(*ts);
> +	f_real = ktime_add(floor, offset);

How is any of this synchronized against concurrent updates of the floor
value or the offset? I'm failing to see anything which keeps this
consistent. If this is magically consistent then it wants a big fat
comment in the code which explains it.

> +void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)

What is this cookie argument for and how does that match the
declaration?

> +extern void ktime_get_real_ts64_mg(struct timespec64 *ts);

This does not even build.

> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	ktime_t old = atomic64_read(&mg_floor);
> +	ktime_t offset, mono;
> +	unsigned int seq;
> +	u64 nsecs;
> +
> +	WARN_ON(timekeeping_suspended);

WARN_ON_ONCE() if at all.

> +	do {
> +		seq = read_seqcount_begin(&tk_core.seq);
> +
> +		ts->tv_sec = tk->xtime_sec;
> +		mono = tk->tkr_mono.base;
> +		nsecs = timekeeping_get_ns(&tk->tkr_mono);
> +		offset = *offsets[TK_OFFS_REAL];
> +	} while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +	mono = ktime_add_ns(mono, nsecs);
> +
> +	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
> +		ts->tv_nsec = 0;
> +		timespec64_add_ns(ts, nsecs);
> +	} else {
> +		/*
> +		 * Something has changed mg_floor since "old" was
> +		 * fetched. "old" has now been updated with the
> +		 * current value of mg_floor, so use that to return
> +		 * the current coarse floor value.

'Something has changed' is a truly understandable technical
explanation.

I'm not going to accept this voodoo which makes everyone scratch his
head who wasn't involved in this.

Thanks,

        tglx


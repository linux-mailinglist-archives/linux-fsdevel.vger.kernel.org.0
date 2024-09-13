Return-Path: <linux-fsdevel+bounces-29305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07009977E70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB751F21437
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F6F1D86F6;
	Fri, 13 Sep 2024 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yrz2niQz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e/xA5RyY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yrz2niQz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e/xA5RyY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C772C80;
	Fri, 13 Sep 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226767; cv=none; b=KkDMW7uS1i/8RCOroCDYd1bvlKlNwmXwoAEzmk6oADO7BJErXgCohDDsShr1BDy1VShMW3I5XsdGntSz3zUl4oaI//OUOQRUXnOzYJ0kmEFL/xvfcF72KoYF/+FhDSqVLBVp78tIdO+2F0JDxyVmSk4eJa8hFcAe9PH0pfWIIO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226767; c=relaxed/simple;
	bh=zlDV6hlWvRrb9yxKmE87JK+o+Aay6EZMjys3p9+w8D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9dM7lHGFffUE/XKH0KAqRttVByZu2lvKjAVCyx7gAK/XqxvzMN9/8gcs38LzBFUvL0rIj3/fpmtvQHkDFEljL0pmwZniTDukPffkkVGhK7Vft8jJ+1eciiwfNPfmNQPihXX5OeR7tOBDDXJchveijyEN6C+SAMdC9/MwBpsHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yrz2niQz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e/xA5RyY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yrz2niQz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e/xA5RyY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D8771FBF8;
	Fri, 13 Sep 2024 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726226763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q34UerNnqD8tq4CX1au8i6+LM/nIl2ErNCyvhrpNZeQ=;
	b=Yrz2niQzCntRXzJyQ+yXyIQGr0I53qsuh7uy+dRbIw6VZ3Itnio7qKNHc8vFmSU6naYF/1
	PqhutBLnAeRBqDYbE+C/x+3KmSJ77wBuH9rpccee66jpgp1bjIL4nRnNmgNZSQPDfuUm5G
	Aj2iqd9qXFR6HouZdoCk6+k9gOsI4xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726226763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q34UerNnqD8tq4CX1au8i6+LM/nIl2ErNCyvhrpNZeQ=;
	b=e/xA5RyYGBQlBQ56l8YXVjIzoSEoCuNOdyf/RM5fGHIC38S76u78IBkwVV8q9RFs5VeX6b
	OswlcRBKK4RTaOCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726226763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q34UerNnqD8tq4CX1au8i6+LM/nIl2ErNCyvhrpNZeQ=;
	b=Yrz2niQzCntRXzJyQ+yXyIQGr0I53qsuh7uy+dRbIw6VZ3Itnio7qKNHc8vFmSU6naYF/1
	PqhutBLnAeRBqDYbE+C/x+3KmSJ77wBuH9rpccee66jpgp1bjIL4nRnNmgNZSQPDfuUm5G
	Aj2iqd9qXFR6HouZdoCk6+k9gOsI4xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726226763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q34UerNnqD8tq4CX1au8i6+LM/nIl2ErNCyvhrpNZeQ=;
	b=e/xA5RyYGBQlBQ56l8YXVjIzoSEoCuNOdyf/RM5fGHIC38S76u78IBkwVV8q9RFs5VeX6b
	OswlcRBKK4RTaOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F9E713999;
	Fri, 13 Sep 2024 11:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dbCXC0sh5Ga2eAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Sep 2024 11:26:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E38EAA08EF; Fri, 13 Sep 2024 13:26:02 +0200 (CEST)
Date: Fri, 13 Sep 2024 13:26:02 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] timekeeping: move multigrain timestamp floor handling
 into timekeeper
Message-ID: <20240913112602.xrfdn7hinz32bhso@quack3>
References: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 12-09-24 14:02:52, Jeff Layton wrote:
> The kernel test robot reported a performance hit in some will-it-scale
> tests due to the multigrain timestamp patches.  My own testing showed
> about a 7% drop in performance on the pipe1_threads test, and the data
> showed that coarse_ctime() was slowing down current_time().
> 
> Move the multigrain timestamp floor tracking word into timekeeper.c. Add
> two new public interfaces: The first fills a timespec64 with the later
> of the coarse-grained clock and the floor time, and the second gets a
> fine-grained time and tries to swap it into the floor and fills a
> timespec64 with the result.
> 
> The first function returns an opaque cookie that is suitable for passing
> to the second, which will use it as the "old" value in the cmpxchg.
> 
> With this patch on top of the multigrain series, the will-it-scale
> pipe1_threads microbenchmark shows these averages on my test rig:
> 
> 	v6.11-rc7:			103561295 (baseline)
> 	v6.11-rc7 + mgtime + this:	101357203 (~2% performance drop)
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409091303.31b2b713-oliver.sang@intel.com
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

One question regarding the cookie handling as well :)

> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 5391e4167d60..bb039c9d525e 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -114,6 +114,13 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
>  	.base[1] = FAST_TK_INIT,
>  };
>  
> +/*
> + * This represents the latest fine-grained time that we have handed out as a
> + * timestamp on the system. Tracked as a monotonic ktime_t, and converted to the
> + * realtime clock on an as-needed basis.
> + */
> +static __cacheline_aligned_in_smp atomic64_t mg_floor;
> +
>  static inline void tk_normalize_xtime(struct timekeeper *tk)
>  {
>  	while (tk->tkr_mono.xtime_nsec >= ((u64)NSEC_PER_SEC << tk->tkr_mono.shift)) {
> @@ -2394,6 +2401,76 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
>  }
>  EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
>  
> +/**
> + * ktime_get_coarse_real_ts64_mg - get later of coarse grained time or floor
> + * @ts: timespec64 to be filled
> + *
> + * Adjust floor to realtime and compare it to the coarse time. Fill
> + * @ts with the latest one. Returns opaque cookie suitable to pass
> + * to ktime_get_real_ts64_mg.
> + */
> +u64 ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
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
> +	} while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +	coarse = timespec64_to_ktime(*ts);
> +	f_real = ktime_add(floor, offset);
> +	if (ktime_after(f_real, coarse))
> +		*ts = ktime_to_timespec64(f_real);
> +	return floor;
> +}
> +EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_mg);
> +
> +/**
> + * ktime_get_real_ts64_mg - attempt to update floor value and return result
> + * @ts:		pointer to the timespec to be set
> + * @cookie:	opaque cookie from earlier call to ktime_get_coarse_real_ts64_mg()
> + *
> + * Get a current monotonic fine-grained time value and attempt to swap
> + * it into the floor using @cookie as the "old" value. @ts will be
> + * filled with the resulting floor value, regardless of the outcome of
> + * the swap.
> + */
> +void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	ktime_t offset, mono, old = (ktime_t)cookie;
> +	unsigned int seq;
> +	u64 nsecs;

So what would be the difference if we did instead:

	old = atomic64_read(&mg_floor);

and not bother with the cookie? AFAIU this could result in somewhat more
updates to mg_floor (the contention on the mg_floor cacheline would be the
same but there would be more invalidates of the cacheline). OTOH these
updates can happen only if max(current_coarse_time, mg_floor) ==
inode->i_ctime which is presumably rare? What is your concern that I'm
missing?

								Honza	
> +
> +	WARN_ON(timekeeping_suspended);
> +
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
> +	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
> +		ts->tv_nsec = 0;
> +		timespec64_add_ns(ts, nsecs);
> +	} else {
> +		*ts = ktime_to_timespec64(ktime_add(old, offset));
> +	}
> +
> +}
> +EXPORT_SYMBOL(ktime_get_real_ts64_mg);
> +
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


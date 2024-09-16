Return-Path: <linux-fsdevel+bounces-29449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2B8979F28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A04281627
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78064153814;
	Mon, 16 Sep 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E94SEr6H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X9vlzHNg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83CA935;
	Mon, 16 Sep 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482041; cv=none; b=mjPNOkeiNJd3hRvXM0jOgp+495axDkTWA5pV+IJG9mbZMJKkMq60ZFsN+UGPkg/3DaIC30NPmFEtOT7rBN3fSjGeLZuHCSCBs2aik5wKIvEWLNZSxmmNmHVGeD1mog7513wyCZ6h4Ndl7TFaOt4u2tJv3Tj2JVD9tYHszUEHvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482041; c=relaxed/simple;
	bh=E/w4+xa3amQXpGI5fCZ/ptW0dOLoQK0QOmDuZUDIOP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y112G5awmGDBPCSkgjcZ1vHa8Vf73EjHTJTc47p18ERXJMPdXc3tewgQj2PvYHsOY7tVMyzf3x/6c7jtlNnjTkAt1+DEj0EzA3UScCx29CXplIPygGQFR47G1O++CTk3itG3PIxQNiSPvCgtkSwU3lxyU034PdqQnE6LNDgtx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E94SEr6H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X9vlzHNg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726482038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVG16f7Lu6e/H23VRJ+O/4IkmfuMphsrI/ipqzuRwhM=;
	b=E94SEr6HGjjaRf5H7+ZkfgZowKYiFKpF328zjde6biUZeuGmGrtQv6oS3PBXA3GIoHTyKH
	mQlJbIgW5eYuB9Qlvfl4V2sBvjGis+xqWMvwHYULSu2I9gleX8ZCTMU12a7jWzdcYLH9jl
	LlwCnTAIHGLPcKhOqS6Gju9gsGcihltDLI9EUw5/JiygRw72jIjI+rP4BQPrr0Fs+5M3/D
	OW+FIoCrmGJ9vK79YGucwB4XWRiKZmHjbiUFjrMmi2Bk3tbVVtwa4npQSIX7CmsQnEQvb9
	xJdlZuWC6RRwTl2JzrFR4gwnJAsKly0FnZRlnIgwihMwy/O6ZrI4Brk8w2PyLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726482038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVG16f7Lu6e/H23VRJ+O/4IkmfuMphsrI/ipqzuRwhM=;
	b=X9vlzHNgUVa0a3OKlhqGWstodYRShttuTWSfa1R6XCAL0ByC2d7QTL8VeW7MjLvjBlT+Lg
	qpOskyA6Rt0z6SDQ==
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
Subject: Re: [PATCH v8 06/11] fs: add percpu counters for significant
 multigrain timestamp events
In-Reply-To: <20240914-mgtime-v8-6-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-6-5bd872330bed@kernel.org>
Date: Mon, 16 Sep 2024 12:20:37 +0200
Message-ID: <877cbb99xm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Sep 14 2024 at 13:07, Jeff Layton wrote:
>  fs/inode.c                         | 76 ++++++++++++++++++++++++++++++++++++--
>  include/linux/timekeeping.h        |  1 +
>  kernel/time/timekeeping.c          |  3 +-
>  kernel/time/timekeeping_debug.c    | 12 ++++++
>  kernel/time/timekeeping_internal.h |  3 ++

So the subject says 'fs:'. This is not how it works.

Provide the timekeeping changes in a separate patch and then add the fs
voodoo. Documentation is pretty clear about this, no?

> diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
> index b73e8850e58d..9a3792072762 100644
> --- a/kernel/time/timekeeping_debug.c
> +++ b/kernel/time/timekeeping_debug.c
> @@ -17,6 +17,9 @@
>  
>  #define NUM_BINS 32
>  
> +/* incremented every time mg_floor is updated */

Sentences start with a uppercase letter.

> +DEFINE_PER_CPU(long, mg_floor_swaps);

Why is this long? This is a counter which always counts up..

>  static unsigned int sleep_time_bin[NUM_BINS] = {0};
>  
>  static int tk_debug_sleep_time_show(struct seq_file *s, void *data)
> @@ -53,3 +56,12 @@ void tk_debug_account_sleep_time(const struct timespec64 *t)
>  			   (s64)t->tv_sec, t->tv_nsec / NSEC_PER_MSEC);
>  }
>  
> +long get_mg_floor_swaps(void)

Can we please have a proper subsystem prefix and not this get_*()
notation. It's horrible to grep for. timekeeping_mg_get_...() makes it
clear where this function belongs to, no?

> +{
> +	int i;
> +	long sum = 0;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

Also please use 'cpu' instead of 'i'. Self explanatory variable names
have a value.

> +	for_each_possible_cpu(i)
> +		sum += per_cpu(mg_floor_swaps, i);

This needs annotation for kcsan as this is a racy access.

> +	return sum < 0 ? 0 : sum;
> +}
> diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
> index 4ca2787d1642..2b49332b45a5 100644
> --- a/kernel/time/timekeeping_internal.h
> +++ b/kernel/time/timekeeping_internal.h
> @@ -11,8 +11,11 @@
>   */
>  #ifdef CONFIG_DEBUG_FS
>  extern void tk_debug_account_sleep_time(const struct timespec64 *t);
> +DECLARE_PER_CPU(long, mg_floor_swaps);
> +#define mgtime_counter_inc(__var)	this_cpu_inc(__var)

Please use static inlines for this.

Thanks,

        tglx


Return-Path: <linux-fsdevel+bounces-59084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FB4B342BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06CE189AB05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F22EFD89;
	Mon, 25 Aug 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+P4bdmi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BBD26A08C;
	Mon, 25 Aug 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130510; cv=none; b=duq1Vx9z+ylAMPq62Js/v0npqI8v8CWLlvCX5M52q7ZbYYUBpQklHe2oGE4bLWnRaAKcn9gMBfhMyQjyMJJ61T/cgy8Fsd6HFJX+KnTyoAxLeq/L5rSb+U2b4wGq1QYd02m5vwVSxdt26Upmb2/UV3fBoQvHUcCDAMISPi2IQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130510; c=relaxed/simple;
	bh=JYK5oZx2jKAoGrqaNkjjnyjA3UiseVMaOJbii9Eo/aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfFHoYhyzoRfdFdw7Z8jZyOTOvONdvXtP+lahUdRhY7A2sdEirqLB76NKxQf57utU8yP0oi3ijzLWaqxjnb8dEicv9nhpERaDwBboYVxRvrInaYE8SfZusbmuMaAquL0kdQASu1widz5+Dhs2oVCU9G/KCytBzUcJPr6RH33xyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+P4bdmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D597AC4CEED;
	Mon, 25 Aug 2025 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756130509;
	bh=JYK5oZx2jKAoGrqaNkjjnyjA3UiseVMaOJbii9Eo/aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+P4bdmi9cT5ft6PawuA6vnhqp21nyGNK7WDeDtmw/FLomN9WHQc3dbJhc8Lg5HyH
	 7rb0HFOIuHa8mmRXv2Wx+Tnu5lI7xBC/AM1kAi+pGpfMM83+QiGVohyp0ecbYqQ2jp
	 Nk5UrKQDuAU3UdohGu9UC9C5Yn/SRowMZBtKLhbwtaKtc8tZbLqTvylx9zG1cTUldH
	 YFcgx2q0G2YBuHgRmwCebPdVUlkne55rdbRsNPOpFB5NhboHVIbtHXQyG28pi3Fz1f
	 dmvyqcOz+ybEWaNi3pkk10d/0vm2aXBe62lUAdUeXqJgDd/T6qCRwUAMuzVvQe+35m
	 rVYnNuaHDYJow==
Date: Mon, 25 Aug 2025 07:01:49 -0700
From: Kees Cook <kees@kernel.org>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-trace-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH v8 4/5] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <202508250656.9D56526@keescook>
References: <20250821102152.323367-1-bhupesh@igalia.com>
 <20250821102152.323367-5-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821102152.323367-5-bhupesh@igalia.com>

On Thu, Aug 21, 2025 at 03:51:51PM +0530, Bhupesh wrote:
> As Linus mentioned in [1], currently we have several memcpy() use-cases
> which use 'current->comm' to copy the task name over to local copies.
> For an example:
> 
>  ...
>  char comm[TASK_COMM_LEN];
>  memcpy(comm, current->comm, TASK_COMM_LEN);
>  ...
> 
> These should be rather calling a wrappper like "get_task_array()",
> which is implemented as:
> 
>    static __always_inline void
>        __cstr_array_copy(char *dst,
>             const char *src, __kernel_size_t size)
>    {
>         memcpy(dst, src, size);
>         dst[size] = 0;
>    }
> 
>    #define get_task_array(dst,src) \
>       __cstr_array_copy(dst, src, __must_be_array(dst))
> 
> The relevant 'memcpy()' users were identified using the following search
> pattern:
>  $ git grep 'memcpy.*->comm\>'
> 
> Link: https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/ #1
> 
> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> ---
>  include/linux/coredump.h                      |  2 +-
>  include/linux/sched.h                         | 32 +++++++++++++++++++
>  include/linux/tracepoint.h                    |  4 +--
>  include/trace/events/block.h                  | 10 +++---
>  include/trace/events/oom.h                    |  2 +-
>  include/trace/events/osnoise.h                |  2 +-
>  include/trace/events/sched.h                  | 13 ++++----
>  include/trace/events/signal.h                 |  2 +-
>  include/trace/events/task.h                   |  4 +--
>  tools/bpf/bpftool/pids.c                      |  6 ++--
>  .../bpf/test_kmods/bpf_testmod-events.h       |  2 +-
>  11 files changed, 54 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> index 68861da4cf7c..bcee0afc5eaf 100644
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -54,7 +54,7 @@ extern void vfs_coredump(const kernel_siginfo_t *siginfo);
>  	do {	\
>  		char comm[TASK_COMM_LEN];	\
>  		/* This will always be NUL terminated. */ \
> -		memcpy(comm, current->comm, sizeof(comm)); \
> +		get_task_array(comm, current->comm); \
>  		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
>  			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
>  	} while (0)	\
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5a58c1270474..d26d1dfb9904 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1960,12 +1960,44 @@ extern void wake_up_new_task(struct task_struct *tsk);
>  
>  extern void kick_process(struct task_struct *tsk);
>  
> +/*
> + * - Why not use task_lock()?
> + *   User space can randomly change their names anyway, so locking for readers
> + *   doesn't make sense. For writers, locking is probably necessary, as a race
> + *   condition could lead to long-term mixed results.
> + *   The logic inside __set_task_comm() should ensure that the task comm is
> + *   always NUL-terminated and zero-padded. Therefore the race condition between
> + *   reader and writer is not an issue.
> + */
> +
>  extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
>  #define set_task_comm(tsk, from) ({			\
>  	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
>  	__set_task_comm(tsk, from, false);		\
>  })
>  
> +/*
> + * 'get_task_array' can be 'data-racy' in the destination and
> + * should not be used for cases where a 'stable NUL at the end'
> + * is needed. Its better to use strscpy and friends for such
> + * use-cases.
> + *
> + * It is suited mainly for a 'just copy comm to a constant-sized
> + * array' case - especially in performance sensitive use-cases,
> + * like tracing.
> + */
> +
> +static __always_inline void
> +	__cstr_array_copy(char *dst, const char *src,
> +			  __kernel_size_t size)
> +{
> +	memcpy(dst, src, size);
> +	dst[size] = 0;
> +}

Please don't reinvent the wheel. :) We already have memtostr, please use
that (or memtostr_pad).

> +
> +#define get_task_array(dst, src) \
> +	__cstr_array_copy(dst, src, __must_be_array(dst))

Uh, __must_be_array(dst) returns 0 on success. :P Are you sure you
tested this?

-- 
Kees Cook


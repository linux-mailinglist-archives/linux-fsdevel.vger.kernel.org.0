Return-Path: <linux-fsdevel+bounces-20065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104058CD787
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 17:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C061C2143E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A50312B72;
	Thu, 23 May 2024 15:44:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87411720;
	Thu, 23 May 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479098; cv=none; b=b1j06ITsYVH34feGRvW3VxjcO59iudlFp0mcbam2zRIqpviNuUvuCC7+gbkQ/P3J/US2/Kpkuu2w3StgBiPB7+poyExUiuid+l59qb0gJ4eJdyXL1whqY8inEcqOrePETGGtdZ0nbH3n2TlVzIYlNN/gORA4unaVVGUkfeA23Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479098; c=relaxed/simple;
	bh=0zM6tALU7shidJdLtZOrXtoH17h4De0WmF255Z4Mza4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSo3pO5iv1z6aLQJIpKAIzWbh8MLoZAbc0PulfX7qd51GwQW+ksA1VM2sNw2W18xolbGE1O3BEqK4uXtQV0RDH36KGVszVyt1nAqVlh07QAtJFJtUJHPHEdel1h6fY/j3G4LdxNnZqBmjk1KMkguGGdViAQHBxbhdvDanVVFdl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C0EC2BD10;
	Thu, 23 May 2024 15:44:56 +0000 (UTC)
Date: Thu, 23 May 2024 11:45:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, Phil Auld
 <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240523114540.2856c109@gandalf.local.home>
In-Reply-To: <20240515220536.823145-1-qyousef@layalina.io>
References: <20240515220536.823145-1-qyousef@layalina.io>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 May 2024 23:05:36 +0100
Qais Yousef <qyousef@layalina.io> wrote:
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index df3aca89d4f5..5cb88b748ad6 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -10,8 +10,6 @@
>  
>  #include <linux/sched.h>
>  
> -#define MAX_DL_PRIO		0
> -
>  static inline int dl_prio(int prio)
>  {
>  	if (unlikely(prio < MAX_DL_PRIO))
> @@ -19,6 +17,10 @@ static inline int dl_prio(int prio)
>  	return 0;
>  }
>  
> +/*
> + * Returns true if a task has a priority that belongs to DL class. PI-boosted
> + * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
> + */
>  static inline int dl_task(struct task_struct *p)
>  {
>  	return dl_prio(p->prio);
> diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
> index ab83d85e1183..6ab43b4f72f9 100644
> --- a/include/linux/sched/prio.h
> +++ b/include/linux/sched/prio.h
> @@ -14,6 +14,7 @@
>   */
>  
>  #define MAX_RT_PRIO		100
> +#define MAX_DL_PRIO		0
>  
>  #define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
>  #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)
> diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
> index b2b9e6eb9683..a055dd68a77c 100644
> --- a/include/linux/sched/rt.h
> +++ b/include/linux/sched/rt.h
> @@ -7,18 +7,43 @@
>  struct task_struct;
>  
>  static inline int rt_prio(int prio)
> +{
> +	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
> +		return 1;
> +	return 0;
> +}
> +
> +static inline int realtime_prio(int prio)
>  {
>  	if (unlikely(prio < MAX_RT_PRIO))
>  		return 1;
>  	return 0;
>  }

I'm thinking we should change the above to bool (separate patch), as
returning an int may give one the impression that it returns the actual
priority number. Having it return bool will clear that up.

In fact, if we are touching theses functions, might as well change all of
them to bool when returning true/false. Just to make it easier to
understand what they are doing.

>  
> +/*
> + * Returns true if a task has a priority that belongs to RT class. PI-boosted
> + * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
> + */
>  static inline int rt_task(struct task_struct *p)
>  {
>  	return rt_prio(p->prio);
>  }
>  
> -static inline bool task_is_realtime(struct task_struct *tsk)
> +/*
> + * Returns true if a task has a priority that belongs to RT or DL classes.
> + * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
> + * PI-boosted tasks.
> + */
> +static inline int realtime_task(struct task_struct *p)
> +{
> +	return realtime_prio(p->prio);
> +}
> +
> +/*
> + * Returns true if a task has a policy that belongs to RT or DL classes.
> + * PI-boosted tasks will return false.
> + */
> +static inline bool realtime_task_policy(struct task_struct *tsk)
>  {
>  	int policy = tsk->policy;
>  



> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index 0469a04a355f..19d737742e29 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -545,7 +545,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
>  	 *  - wakeup_dl handles tasks belonging to sched_dl class only.
>  	 */
>  	if (tracing_dl || (wakeup_dl && !dl_task(p)) ||
> -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
> +	    (wakeup_rt && !realtime_task(p)) ||
>  	    (!dl_task(p) && (p->prio >= wakeup_prio || p->prio >= current->prio)))
>  		return;
>  

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>




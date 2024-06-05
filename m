Return-Path: <linux-fsdevel+bounces-21016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B28FC3F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 08:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489061C241F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 06:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFEA18C321;
	Wed,  5 Jun 2024 06:54:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D9019046E;
	Wed,  5 Jun 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570474; cv=none; b=djJZhVadB9ZGZvJoqKP2cWaxRSHciSfk4pMcXCwRYnNLB1dukF/nW7vduYPupxNegBKJBLSGVVv1XaKgdF44yXpGvBmHhq3ODzZHelQwd/uoIei3+m1qVYDpyBp9292PKbH9z4ZeLKmRrX3Wcth/aE88/9LwlqVyUKe7JOCSooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570474; c=relaxed/simple;
	bh=fovqmaL8GE2v0nXhtsKkRl+/v2E0D+OdwswGcKfLpcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cF5h9zWMdMIe5B5p6DlkUY5LQyp7ghwhAwjNbN8B9PDUNDSFBARVxGWT6ZD2UCEPUc6N3+jFgbJlq1FViLwVh1BVzcUzGGGwdmtuN25ih7EAiqZGetjdjcyQtz7xIKcnZupeknB77BEFoW0HIzQAjBkq5e6im6lXkCJEdTyAYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ED45DA7;
	Tue,  4 Jun 2024 23:54:54 -0700 (PDT)
Received: from [10.57.5.217] (unknown [10.57.5.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AE613F762;
	Tue,  4 Jun 2024 23:54:26 -0700 (PDT)
Message-ID: <643a7106-921f-4916-9f48-b979e0b5b4fe@arm.com>
Date: Wed, 5 Jun 2024 07:54:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] sched/rt, dl: Convert functions to return bool
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-3-qyousef@layalina.io>
Content-Language: en-US
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20240604144228.1356121-3-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2024 3:42 pm, Qais Yousef wrote:
> {rt, realtime, dl}_{task, prio}() functions return value is actually

Super-nit: s/functions/functions'/ ?

With that,

Reviewed-by: Metin Kaya <metin.kaya@arm.com>

> a bool.  Convert their return type to reflect that.
> 
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>   include/linux/sched/deadline.h |  8 +++-----
>   include/linux/sched/rt.h       | 16 ++++++----------
>   2 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 5cb88b748ad6..3a912ab42bb5 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -10,18 +10,16 @@
>   
>   #include <linux/sched.h>
>   
> -static inline int dl_prio(int prio)
> +static inline bool dl_prio(int prio)
>   {
> -	if (unlikely(prio < MAX_DL_PRIO))
> -		return 1;
> -	return 0;
> +	return unlikely(prio < MAX_DL_PRIO);
>   }
>   
>   /*
>    * Returns true if a task has a priority that belongs to DL class. PI-boosted
>    * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
>    */
> -static inline int dl_task(struct task_struct *p)
> +static inline bool dl_task(struct task_struct *p)
>   {
>   	return dl_prio(p->prio);
>   }
> diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
> index a055dd68a77c..91ef1ef2019f 100644
> --- a/include/linux/sched/rt.h
> +++ b/include/linux/sched/rt.h
> @@ -6,25 +6,21 @@
>   
>   struct task_struct;
>   
> -static inline int rt_prio(int prio)
> +static inline bool rt_prio(int prio)
>   {
> -	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
> -		return 1;
> -	return 0;
> +	return unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO);
>   }
>   
> -static inline int realtime_prio(int prio)
> +static inline bool realtime_prio(int prio)
>   {
> -	if (unlikely(prio < MAX_RT_PRIO))
> -		return 1;
> -	return 0;
> +	return unlikely(prio < MAX_RT_PRIO);
>   }
>   
>   /*
>    * Returns true if a task has a priority that belongs to RT class. PI-boosted
>    * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
>    */
> -static inline int rt_task(struct task_struct *p)
> +static inline bool rt_task(struct task_struct *p)
>   {
>   	return rt_prio(p->prio);
>   }
> @@ -34,7 +30,7 @@ static inline int rt_task(struct task_struct *p)
>    * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
>    * PI-boosted tasks.
>    */
> -static inline int realtime_task(struct task_struct *p)
> +static inline bool realtime_task(struct task_struct *p)
>   {
>   	return realtime_prio(p->prio);
>   }



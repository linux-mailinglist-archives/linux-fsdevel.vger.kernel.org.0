Return-Path: <linux-fsdevel+bounces-20791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8196D8D7C7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22751C21345
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E0F47F6B;
	Mon,  3 Jun 2024 07:34:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FAB63D5;
	Mon,  3 Jun 2024 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400040; cv=none; b=I+K9srFyvtZjmrGKcs+jU2v5G+IvgZqndZvJ+gmT8cBej9iNdKoGwFeuH9zjVHd5V3BoLdKl333dcu1M6T9KdsMAt4Chw4PG6N+pWibzbjX3TqXusYWlcBrH5m/IBhl8KyY+s1zLEGA1qye3f0OLOrj0D+4xNMu25N54PtgKCM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400040; c=relaxed/simple;
	bh=bMwHq1gbaaHFe+5rDN7x7ihdVSCPg5KBQmDrKPdlJ5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNd1P20TbGs3J6iVwGUaMZXYWigs9NoLLOVvvFTXz0PcOI1ZRnsAhPVzwMQHQ8lXn2GqR3JodA8Sj0CY0hHfNx6K90PiEly/syb71/SrfmoprxOmYyq/8xWVsfre1PDc9NrqpVvrwRSlhNJU4zMXnVX/uKjwNa2QH2QVEncXDFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A35E1042;
	Mon,  3 Jun 2024 00:34:21 -0700 (PDT)
Received: from [10.57.5.79] (unknown [10.57.5.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45BC03F762;
	Mon,  3 Jun 2024 00:33:54 -0700 (PDT)
Message-ID: <417b39d1-8de8-4234-92dc-f1ef5fd95da7@arm.com>
Date: Mon, 3 Jun 2024 08:33:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] sched/rt, dl: Convert functions to return bool
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
References: <20240601213309.1262206-1-qyousef@layalina.io>
 <20240601213309.1262206-3-qyousef@layalina.io>
Content-Language: en-US
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20240601213309.1262206-3-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/06/2024 10:33 pm, Qais Yousef wrote:
> {rt, realtime, dl}_{task, prio}() functions return value is actually
> a bool.  Convert their return type to reflect that.
> 
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>   include/linux/sched/deadline.h |  8 ++++----
>   include/linux/sched/rt.h       | 16 ++++++++--------
>   2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 5cb88b748ad6..f2053f46f1d5 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -10,18 +10,18 @@
>   
>   #include <linux/sched.h>
>   
> -static inline int dl_prio(int prio)
> +static inline bool dl_prio(int prio)
>   {
>   	if (unlikely(prio < MAX_DL_PRIO))
> -		return 1;
> -	return 0;
> +		return true;
> +	return false;

Nit: `return unlikely(prio < MAX_DL_PRIO)` would be simpler.
The same can be applied to rt_prio() and realtime_prio(). This would 
make {dl, rt, realtime}_task() single-liner. Maybe further 
simplification can be done.

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
> index a055dd68a77c..efbdd2e57765 100644
> --- a/include/linux/sched/rt.h
> +++ b/include/linux/sched/rt.h
> @@ -6,25 +6,25 @@
>   
>   struct task_struct;
>   
> -static inline int rt_prio(int prio)
> +static inline bool rt_prio(int prio)
>   {
>   	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
> -		return 1;
> -	return 0;
> +		return true;
> +	return false;
>   }
>   
> -static inline int realtime_prio(int prio)
> +static inline bool realtime_prio(int prio)
>   {
>   	if (unlikely(prio < MAX_RT_PRIO))
> -		return 1;
> -	return 0;
> +		return true;
> +	return false;
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
> @@ -34,7 +34,7 @@ static inline int rt_task(struct task_struct *p)
>    * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
>    * PI-boosted tasks.
>    */
> -static inline int realtime_task(struct task_struct *p)
> +static inline bool realtime_task(struct task_struct *p)
>   {
>   	return realtime_prio(p->prio);
>   }



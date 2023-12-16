Return-Path: <linux-fsdevel+bounces-6322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F1815B54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 20:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB0BB2324D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 19:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAEC321B0;
	Sat, 16 Dec 2023 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG82qlJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDA31A8E;
	Sat, 16 Dec 2023 19:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B57C433C8;
	Sat, 16 Dec 2023 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702755304;
	bh=UfbayCVz3R0ZIOss7ruExChm+cAdSZgFI69SFvbtnVE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iG82qlJJxrxPmgOppyb2c5/aYH3AUsa/8R8WAKqPPfFJGR4m5wEX6OAQClUlDPkfB
	 kYOv4k7VZBW3x2e6HqHkXGcLulm0wwUY45F9gO2a0EW3/qDi2GfRBmuYtPAYiEjrB/
	 JpkoFYLoZhnTE751txj9qH0mLuSUkA4uVTDaGHFulwj6A1xYs3wyy05knjaiFp1iDZ
	 S4s2ZVKNILO/MmUA81jPkbmKycmdQ6d94VZ2g5vDg881EoLVp5zI/+eV7o2UMamOy4
	 cWDi4K6XT3VZJNW/O93wxwnRShIekbIuuO44WVIk3uOtyvsS7QXS+1hJiCEK9//vit
	 coQIP8AOoLrRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 588AECE0965; Sat, 16 Dec 2023 11:35:04 -0800 (PST)
Date: Sat, 16 Dec 2023 11:35:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	keescook@chromium.org, dave.hansen@linux.intel.com,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 50/50] Kill sched.h dependency on rcupdate.h
Message-ID: <a22b69cc-40e3-451c-a18e-ee610aef5150@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-7-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216033552.3553579-7-kent.overstreet@linux.dev>

On Fri, Dec 15, 2023 at 10:35:51PM -0500, Kent Overstreet wrote:
> by moving cond_resched_rcu() to rcupdate.h, we can kill another big
> sched.h dependency.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Could you please instead move the cond_resched_rcu() function to
include/linux/rcupdate_wait.h?  This would avoid breaking Ingo's
separation that makes it possible to include rcupdate.h without also
pulling in sched.h.

							Thanx, Paul

> ---
>  include/linux/rcupdate.h | 11 +++++++++++
>  include/linux/sched.h    | 13 +++----------
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index f7206b2623c9..8ebfa57e0164 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1058,4 +1058,15 @@ extern int rcu_normal;
>  
>  DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
>  
> +#if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
> +#define cond_resched_rcu()		\
> +do {					\
> +	rcu_read_unlock();		\
> +	cond_resched();			\
> +	rcu_read_lock();		\
> +} while (0)
> +#else
> +#define cond_resched_rcu()
> +#endif
> +
>  #endif /* __LINUX_RCUPDATE_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d528057c99e4..b781ac7e0a02 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -10,8 +10,11 @@
>  #include <uapi/linux/sched.h>
>  
>  #include <asm/current.h>
> +#include <linux/thread_info.h>
> +#include <linux/preempt.h>
>  
>  #include <linux/irqflags_types.h>
> +#include <linux/smp_types.h>
>  #include <linux/pid_types.h>
>  #include <linux/sem_types.h>
>  #include <linux/shm.h>
> @@ -22,7 +25,6 @@
>  #include <linux/timer_types.h>
>  #include <linux/seccomp_types.h>
>  #include <linux/nodemask_types.h>
> -#include <linux/rcupdate.h>
>  #include <linux/refcount_types.h>
>  #include <linux/resource.h>
>  #include <linux/latencytop.h>
> @@ -2058,15 +2060,6 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
>  	__cond_resched_rwlock_write(lock);					\
>  })
>  
> -static inline void cond_resched_rcu(void)
> -{
> -#if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
> -	rcu_read_unlock();
> -	cond_resched();
> -	rcu_read_lock();
> -#endif
> -}
> -
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  
>  extern bool preempt_model_none(void);
> -- 
> 2.43.0
> 


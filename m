Return-Path: <linux-fsdevel+bounces-48656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E952EAB1CC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 20:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87252A0182D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B02405EC;
	Fri,  9 May 2025 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv4X1708"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCA22D4CE;
	Fri,  9 May 2025 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817002; cv=none; b=UV0P8vgOUC8MlX19AwIbxAIHMyxEyOjUfK7himW0dZQpH1sD26jRm67xUeQ4Up4dlaX1gw03RqEdpPG77wb1NvY6QQGYxNy1Sw0nptiopoFcD+g4kw4s1hfApFFpBg+OBCtTARiTCHgyeH/Eq81ypXo2LWDAdbAH1Hfm1p1cNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817002; c=relaxed/simple;
	bh=mUxEVjMyxn2ufS687Uv1jEwonkP9xfj+lje4fRPivVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLqIzwAqfAxsz3uR/cfTn8904syaT+WN9tMyT/NcqZ8B/MxCoOJhs/p8/3DpOKIhfoZ47iOZQsgTzXAySekGWfOXPjfwz4QBTrBOSdNCXZIF5TaNonX7B/IioLzcEpuRIp691Y3yHEqGatr8DrUHgaLga71IqlYXBd/C906batE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv4X1708; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F93C4CEE4;
	Fri,  9 May 2025 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817001;
	bh=mUxEVjMyxn2ufS687Uv1jEwonkP9xfj+lje4fRPivVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iv4X1708547EcVt7OI6Ts64jpx9PJrcWPUVIGGIjsk7Rev/grJeIEIUw4XFc5WZcb
	 cN/lrad7TQKW4xjutOCMy8tLhIjIvRhevgYgsCn+PPUTYk7MA1CXsTjaLyEuYEZj6y
	 JqxV7wm3mFNVnUOMIG2qi8B1ffiPK2MXqIZxzv5t36shv13vJHHZZNYhYgz+fa0ZnI
	 YsarZGpH4IWyerXPuJbcBLcR8Ou+TmsiioroHmf4xeFtBNOvLv4FkMoF1cBQkT2Em7
	 kElg2k47qUuOkupYEKIG4MT5aU+969LlNHqLn+eQU+LrgHJR0v2OtMOmi9EouaYOOk
	 Vrql2REAKVslw==
Date: Fri, 9 May 2025 11:56:38 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org,
	linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 02/12] locking/rtmutex: Move max_lock_depth into rtmutex.c
Message-ID: <202505091156.8B42E42@keescook>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-2-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-2-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:06PM +0200, Joel Granados wrote:
> Move the max_lock_depth sysctl table element and variable into
> rtmutex.c. Make the variable static as it no longer needs to be
> exported. Removed the rtmutex.h include from sysctl.c.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Yup, all looks good, including the variable relocation.

Reviewed-by: Kees Cook <kees@kernel.org>

> ---
>  include/linux/rtmutex.h      |  2 --
>  kernel/locking/rtmutex.c     | 23 +++++++++++++++++++++++
>  kernel/locking/rtmutex_api.c |  5 -----
>  kernel/sysctl.c              | 12 ------------
>  4 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
> index 7d049883a08ace049384d70b4c97e3f4fb0e46f8..dc9a51cda97cdb6ac8e12be5209071744101b703 100644
> --- a/include/linux/rtmutex.h
> +++ b/include/linux/rtmutex.h
> @@ -18,8 +18,6 @@
>  #include <linux/rbtree_types.h>
>  #include <linux/spinlock_types_raw.h>
>  
> -extern int max_lock_depth; /* for sysctl */
> -
>  struct rt_mutex_base {
>  	raw_spinlock_t		wait_lock;
>  	struct rb_root_cached   waiters;
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index c80902eacd797c669dedcf10966a8cff38524b50..705a0e0fd72ab8da051e4227a5b89cb3d1539524 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -29,6 +29,29 @@
>  #include "rtmutex_common.h"
>  #include "lock_events.h"
>  
> +/*
> + * Max number of times we'll walk the boosting chain:
> + */
> +static int max_lock_depth = 1024;
> +
> +static const struct ctl_table rtmutex_sysctl_table[] = {
> +	{
> +		.procname	= "max_lock_depth",
> +		.data		= &max_lock_depth,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +};
> +
> +static int __init init_rtmutex_sysctl(void)
> +{
> +	register_sysctl_init("kernel", rtmutex_sysctl_table);
> +	return 0;
> +}
> +
> +subsys_initcall(init_rtmutex_sysctl);
> +
>  #ifndef WW_RT
>  # define build_ww_mutex()	(false)
>  # define ww_container_of(rtm)	NULL
> diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
> index 191e4720e546627aed0d7ec715673b1b8753b130..2b5da8af206da6ee72df1234a4db94f5c4f6f882 100644
> --- a/kernel/locking/rtmutex_api.c
> +++ b/kernel/locking/rtmutex_api.c
> @@ -8,11 +8,6 @@
>  #define RT_MUTEX_BUILD_MUTEX
>  #include "rtmutex.c"
>  
> -/*
> - * Max number of times we'll walk the boosting chain:
> - */
> -int max_lock_depth = 1024;
> -
>  /*
>   * Debug aware fast / slowpath lock,trylock,unlock
>   *
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 473133d9651eac4ef44b8b63a44b77189818ac08..a22f35013da0d838ef421fc5d192f00d1e70fb0f 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -59,9 +59,6 @@
>  #include <asm/nmi.h>
>  #include <asm/io.h>
>  #endif
> -#ifdef CONFIG_RT_MUTEXES
> -#include <linux/rtmutex.h>
> -#endif
>  
>  /* shared constants to be used in various sysctls */
>  const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
> @@ -1709,15 +1706,6 @@ static const struct ctl_table kern_table[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif
> -#ifdef CONFIG_RT_MUTEXES
> -	{
> -		.procname	= "max_lock_depth",
> -		.data		= &max_lock_depth,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -	},
> -#endif
>  #ifdef CONFIG_TREE_RCU
>  	{
>  		.procname	= "panic_on_rcu_stall",
> 
> -- 
> 2.47.2
> 
> 

-- 
Kees Cook


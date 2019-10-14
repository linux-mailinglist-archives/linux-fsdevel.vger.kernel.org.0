Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF88D69B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfJNSsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 14:48:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35913 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbfJNSsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:48:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id j11so8386099plk.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2019 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sjM15tTgKj3X6UIGIKv9yo7y4Z0++2yHpJVAwICI39U=;
        b=FINe/HkyYgzCZMpzzJa0VdHcrhwqPEOVm8IYAmsjZctp7jETjAd66xmj9RZqGvrPmj
         H+FXIhIyR9JSZsKbgRmxWh8p28fI2KaUWsusFrvNmbNdsTSE3WiaTc27SDDPElkItf6I
         z/5s0o92bcyT34XUr1rDgKnW/+LXvtxg1VAP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sjM15tTgKj3X6UIGIKv9yo7y4Z0++2yHpJVAwICI39U=;
        b=I/GQ3fStV6d1mCHHnGNrJoPEs5bUzRqmGfO2nsIa6wqNrSgEvoUT3li7W88QzJCy4D
         oyLRq+dYBmzUecdsPSZCOnPCJq5NyMCAQHbLmMAsGuVLhBmtqPj2rAW/4rCsLAAPsczu
         b7xejpA5rC/ehQXwAVbBxaDUO8BsFdLNTnSSHbhHSyPzQpYXRjEIzAhJ6ATKy6eJ93DH
         7+htxajssCeP3B1fqjgKn6iIrcG9XeP19FG7k4+5uA3BbQTx7wOI0DbvGsowuYapHFAS
         qw3/m5vO5y6wTftL9hUCZNyGSZz7k/L+Esm8mpienTishwSAnEZBzEx6EOjmcEoWx67Q
         9Vpw==
X-Gm-Message-State: APjAAAV7vSZOOAYyhbNk2VjJfyVND+F07n7uXOj2AGeOL8zJE+o3CvYI
        IS4SeJsWnR5/YVfVasVtKdCGCA==
X-Google-Smtp-Source: APXvYqzR872QIebmrMRQzexybPQBLDCvqPQOvZpwTZP2NY+lIhk2vjsBWna0jd+hGgKFRTdxl/i3zA==
X-Received: by 2002:a17:902:aa91:: with SMTP id d17mr30610336plr.69.1571078913729;
        Mon, 14 Oct 2019 11:48:33 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j26sm18406495pgl.38.2019.10.14.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 11:48:33 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:48:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Sterba <dsterba@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] rcu: make PREEMPT_RCU to be a decoration of TREE_RCU
Message-ID: <20191014184832.GA125935@google.com>
References: <20191013125959.3280-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013125959.3280-1-laijs@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 13, 2019 at 12:59:57PM +0000, Lai Jiangshan wrote:
> Currently PREEMPT_RCU and TREE_RCU are "contrary" configs
> when they can't be both on. But PREEMPT_RCU is actually a kind
> of TREE_RCU in the implementation. It seams to be appropriate
> to make PREEMPT_RCU to be a decorative option of TREE_RCU.
> 

Looks like a nice simplification and so far I could not poke any holes in the
code...

I am in support of this patch for further review and testing. Thanks!

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  include/linux/rcupdate.h   |  4 ++--
>  include/trace/events/rcu.h |  4 ++--
>  kernel/rcu/Kconfig         | 13 +++++++------
>  kernel/rcu/Makefile        |  1 -
>  kernel/rcu/rcu.h           |  2 +-
>  kernel/rcu/update.c        |  2 +-
>  kernel/sysctl.c            |  2 +-
>  7 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 75a2eded7aa2..1eee9f6c27f9 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -167,7 +167,7 @@ do { \
>   * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
>   */
>  
> -#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
> +#if defined(CONFIG_TREE_RCU)
>  #include <linux/rcutree.h>
>  #elif defined(CONFIG_TINY_RCU)
>  #include <linux/rcutiny.h>
> @@ -583,7 +583,7 @@ do {									      \
>   * read-side critical section that would block in a !PREEMPT kernel.
>   * But if you want the full story, read on!
>   *
> - * In non-preemptible RCU implementations (TREE_RCU and TINY_RCU),
> + * In non-preemptible RCU implementations (pure TREE_RCU and TINY_RCU),
>   * it is illegal to block while in an RCU read-side critical section.
>   * In preemptible RCU implementations (PREEMPT_RCU) in CONFIG_PREEMPTION
>   * kernel builds, RCU read-side critical sections may be preempted,
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 694bd040cf51..1ce15c5be4c8 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -41,7 +41,7 @@ TRACE_EVENT(rcu_utilization,
>  	TP_printk("%s", __entry->s)
>  );
>  
> -#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
> +#if defined(CONFIG_TREE_RCU)
>  
>  /*
>   * Tracepoint for grace-period events.  Takes a string identifying the
> @@ -425,7 +425,7 @@ TRACE_EVENT_RCU(rcu_fqs,
>  		  __entry->cpu, __entry->qsevent)
>  );
>  
> -#endif /* #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU) */
> +#endif /* #if defined(CONFIG_TREE_RCU) */
>  
>  /*
>   * Tracepoint for dyntick-idle entry/exit events.  These take a string
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 7644eda17d62..0303934e6ef0 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -7,7 +7,7 @@ menu "RCU Subsystem"
>  
>  config TREE_RCU
>  	bool
> -	default y if !PREEMPTION && SMP
> +	default y if SMP
>  	help
>  	  This option selects the RCU implementation that is
>  	  designed for very large SMP system with hundreds or
> @@ -17,6 +17,7 @@ config TREE_RCU
>  config PREEMPT_RCU
>  	bool
>  	default y if PREEMPTION
> +	select TREE_RCU
>  	help
>  	  This option selects the RCU implementation that is
>  	  designed for very large SMP systems with hundreds or
> @@ -78,7 +79,7 @@ config TASKS_RCU
>  	  user-mode execution as quiescent states.
>  
>  config RCU_STALL_COMMON
> -	def_bool ( TREE_RCU || PREEMPT_RCU )
> +	def_bool TREE_RCU
>  	help
>  	  This option enables RCU CPU stall code that is common between
>  	  the TINY and TREE variants of RCU.  The purpose is to allow
> @@ -86,13 +87,13 @@ config RCU_STALL_COMMON
>  	  making these warnings mandatory for the tree variants.
>  
>  config RCU_NEED_SEGCBLIST
> -	def_bool ( TREE_RCU || PREEMPT_RCU || TREE_SRCU )
> +	def_bool ( TREE_RCU || TREE_SRCU )
>  
>  config RCU_FANOUT
>  	int "Tree-based hierarchical RCU fanout value"
>  	range 2 64 if 64BIT
>  	range 2 32 if !64BIT
> -	depends on (TREE_RCU || PREEMPT_RCU) && RCU_EXPERT
> +	depends on TREE_RCU && RCU_EXPERT
>  	default 64 if 64BIT
>  	default 32 if !64BIT
>  	help
> @@ -112,7 +113,7 @@ config RCU_FANOUT_LEAF
>  	int "Tree-based hierarchical RCU leaf-level fanout value"
>  	range 2 64 if 64BIT
>  	range 2 32 if !64BIT
> -	depends on (TREE_RCU || PREEMPT_RCU) && RCU_EXPERT
> +	depends on TREE_RCU && RCU_EXPERT
>  	default 16
>  	help
>  	  This option controls the leaf-level fanout of hierarchical
> @@ -187,7 +188,7 @@ config RCU_BOOST_DELAY
>  
>  config RCU_NOCB_CPU
>  	bool "Offload RCU callback processing from boot-selected CPUs"
> -	depends on TREE_RCU || PREEMPT_RCU
> +	depends on TREE_RCU
>  	depends on RCU_EXPERT || NO_HZ_FULL
>  	default n
>  	help
> diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
> index 020e8b6a644b..82d5fba48b2f 100644
> --- a/kernel/rcu/Makefile
> +++ b/kernel/rcu/Makefile
> @@ -9,6 +9,5 @@ obj-$(CONFIG_TINY_SRCU) += srcutiny.o
>  obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
>  obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
>  obj-$(CONFIG_TREE_RCU) += tree.o
> -obj-$(CONFIG_PREEMPT_RCU) += tree.o
>  obj-$(CONFIG_TINY_RCU) += tiny.o
>  obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 8fd4f82c9b3d..4149ba76824f 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -452,7 +452,7 @@ enum rcutorture_type {
>  	INVALID_RCU_FLAVOR
>  };
>  
> -#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
> +#if defined(CONFIG_TREE_RCU)
>  void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
>  			    unsigned long *gp_seq);
>  void rcutorture_record_progress(unsigned long vernum);
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 1861103662db..34a7452b25fd 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -435,7 +435,7 @@ struct debug_obj_descr rcuhead_debug_descr = {
>  EXPORT_SYMBOL_GPL(rcuhead_debug_descr);
>  #endif /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
>  
> -#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU) || defined(CONFIG_RCU_TRACE)
> +#if defined(CONFIG_TREE_RCU) || defined(CONFIG_RCU_TRACE)
>  void do_trace_rcu_torture_read(const char *rcutorturename, struct rcu_head *rhp,
>  			       unsigned long secs,
>  			       unsigned long c_old, unsigned long c)
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 00fcea236eba..2ace158a4d72 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1268,7 +1268,7 @@ static struct ctl_table kern_table[] = {
>  		.proc_handler	= proc_do_static_key,
>  	},
>  #endif
> -#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
> +#if defined(CONFIG_TREE_RCU)
>  	{
>  		.procname	= "panic_on_rcu_stall",
>  		.data		= &sysctl_panic_on_rcu_stall,
> -- 
> 2.20.1
> 

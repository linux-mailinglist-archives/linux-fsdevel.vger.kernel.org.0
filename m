Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617751802C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 17:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCJQFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 12:05:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35131 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgCJQFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:05:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so5974439pfb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sLf7cjV6sKyJ3S2m+wChaUAMrLlKHv984iQszIo5XuY=;
        b=HcJKtKV3OKjj6dhRPoQYRG/kvS0+vNnaxm8j8U4T+m9qfTsZmvxGf2+QCNc2SFMk+m
         q9QatLbpA48uHbIkMybJqE4CQQlwl4c7w2p0YoC8aQ9KEJ35K615PWp7FamupISL5Ffh
         Nr9DHNRl3duMZPUhQ2LZg5FwCcDrtWfM45ntY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sLf7cjV6sKyJ3S2m+wChaUAMrLlKHv984iQszIo5XuY=;
        b=i1E69w9dSNilzF809DHIwxBX4ii8t4cyuK99hSGvXd5VshVQcQpKoOVGOe6kYMBwIj
         8gh05CF2roWX9FX3ItrPEdo3OpER/BFvYfMMEd8nRHE4OacEme6TpLFcz2ZEZN2rR/Qq
         2GQ4f6rKSkUmGpvh8JFVxRp+4sjJhguVDF4umzshEhZZoe3VwEykH3U8j6BRUgL1/Wqr
         SaFHXknZBMe1CJKZBdj6cotKlcuiP/WXBzyIUTFExfnjo1y8q4ATgqIQKwMcxJG3COXC
         tY3rj+s+grLDY3H75sLLqPOU3CllhFNNdBtzvYjuPx+sV7C+2uTEiHIZcKf0bwgvc5MM
         98Zw==
X-Gm-Message-State: ANhLgQ0tSlYxKUQv1Vjc5eddgVaxxlNcVXFUTk4daqiVdSLd8umnxKZ/
        FLvQmfE+Z5dntpWQZTkANSitRw==
X-Google-Smtp-Source: ADFU+vuXyYflO0g/EvFIzQokRR+IW62j+HNAi7eXxAMSobOsn1ELnJtq5DP4tFSNLj5MqXDtXL3yZw==
X-Received: by 2002:a62:25c3:: with SMTP id l186mr22397268pfl.52.1583856322805;
        Tue, 10 Mar 2020 09:05:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j126sm41079485pfb.129.2020.03.10.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 09:05:21 -0700 (PDT)
Date:   Tue, 10 Mar 2020 09:05:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org, yzaikin@google.com,
        tglx@linutronix.de, kernel@gpiccoli.net,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] kernel/hung_task.c: Introduce sysctl to print all traces
 when a hung task is detected
Message-ID: <202003100904.A4EBBD532@keescook>
References: <20200310155650.17968-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310155650.17968-1-gpiccoli@canonical.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:56:50PM -0300, Guilherme G. Piccoli wrote:
> Commit 401c636a0eeb ("kernel/hung_task.c: show all hung tasks before panic")
> introduced a change in that we started to show all CPUs backtraces when a
> hung task is detected _and_ the sysctl/kernel parameter "hung_task_panic"
> is set. The idea is good, because usually when observing deadlocks (that
> may lead to hung tasks), the culprit is another task holding a lock and
> not necessarily the task detected as hung.
> 
> The problem with this approach is that dumping backtraces is a slightly
> expensive task, specially printing that on console (and specially in many
> CPU machines, as servers commonly found nowadays). So, users that plan to
> collect a kdump to investigate the hung tasks and narrow down the deadlock
> definitely don't need the CPUs backtrace on dmesg/console, which will delay
> the panic and pollute the log (crash tool would easily grab all CPUs traces
> with 'bt -a' command).
> Also, there's the reciprocal scenario: some users may be interested in
> seeing the CPUs backtraces but not have the system panic when a hung task
> is detected. The current approach hence is almost as embedding a policy in
> the kernel, by forcing the CPUs backtraces' dump (only) on hung_task_panic.
> 
> This patch decouples the panic event on hung task from the CPUs backtraces
> dump, by creating (and documenting) a new sysctl/kernel parameter called
> "hung_task_all_cpu_backtrace", analog to the approach taken on soft/hard
> lockups, that have both a panic and an "all_cpu_backtrace" sysctl to allow
> individual control. The new mechanism for dumping the CPUs backtraces on
> hung task detection respects "hung_task_warnings" by not dumping the
> traces in case there's no warnings left.
> 
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

bikeshed: should hung_task_show_bt be renamed hung_task_show_all_bt ?

-Kees

> ---
>  .../admin-guide/kernel-parameters.txt         |  6 ++++
>  Documentation/admin-guide/sysctl/kernel.rst   | 15 ++++++++++
>  include/linux/sched/sysctl.h                  |  7 +++++
>  kernel/hung_task.c                            | 30 +++++++++++++++++--
>  kernel/sysctl.c                               | 11 +++++++
>  5 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index adf77ead02c3..4c6595b5f6c8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1453,6 +1453,12 @@
>  			x86-64 are 2M (when the CPU supports "pse") and 1G
>  			(when the CPU supports the "pdpe1gb" cpuinfo flag).
>  
> +	hung_task_all_cpu_backtrace=
> +			[KNL] Should kernel generates backtraces on all cpus
> +			when a hung task is detected. Defaults to 0 and can
> +			be controlled by hung_task_all_cpu_backtrace sysctl.
> +			Format: <integer>
> +
>  	hung_task_panic=
>  			[KNL] Should the hung task detector generate panics.
>  			Format: <integer>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 95b2f3256323..218c717c1354 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -40,6 +40,7 @@ show up in /proc/sys/kernel:
>  - hotplug
>  - hardlockup_all_cpu_backtrace
>  - hardlockup_panic
> +- hung_task_all_cpu_backtrace
>  - hung_task_panic
>  - hung_task_check_count
>  - hung_task_timeout_secs
> @@ -339,6 +340,20 @@ Path for the hotplug policy agent.
>  Default value is "/sbin/hotplug".
>  
>  
> +hung_task_all_cpu_backtrace:
> +================
> +
> +Determines if kernel should NMI all CPUs to dump their backtraces when
> +a hung task is detected. This file shows up if CONFIG_DETECT_HUNG_TASK
> +and CONFIG_SMP are enabled.
> +
> +0: Won't show all CPUs backtraces when a hung task is detected.
> +This is the default behavior.
> +
> +1: Will NMI all CPUs and dump their backtraces when a hung task
> +is detected.
> +
> +
>  hung_task_panic:
>  ================
>  
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index d4f6215ee03f..8cd29440ec8a 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -7,6 +7,13 @@
>  struct ctl_table;
>  
>  #ifdef CONFIG_DETECT_HUNG_TASK
> +
> +#ifdef CONFIG_SMP
> +extern unsigned int sysctl_hung_task_all_cpu_backtrace;
> +#else
> +#define sysctl_hung_task_all_cpu_backtrace 0
> +#endif /* CONFIG_SMP */
> +
>  extern int	     sysctl_hung_task_check_count;
>  extern unsigned int  sysctl_hung_task_panic;
>  extern unsigned long sysctl_hung_task_timeout_secs;
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 14a625c16cb3..54152b26117e 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -53,9 +53,28 @@ int __read_mostly sysctl_hung_task_warnings = 10;
>  static int __read_mostly did_panic;
>  static bool hung_task_show_lock;
>  static bool hung_task_call_panic;
> +static bool hung_task_show_bt;
>  
>  static struct task_struct *watchdog_task;
>  
> +#ifdef CONFIG_SMP
> +/*
> + * Should we dump all CPUs backtraces in a hung task event?
> + * Defaults to 0, can be changed either via cmdline or sysctl.
> + */
> +unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
> +
> +static int __init hung_task_backtrace_setup(char *str)
> +{
> +	int rc = kstrtouint(str, 0, &sysctl_hung_task_all_cpu_backtrace);
> +
> +	if (rc)
> +		return rc;
> +	return 1;
> +}
> +__setup("hung_task_all_cpu_backtrace=", hung_task_backtrace_setup);
> +#endif /* CONFIG_SMP */
> +
>  /*
>   * Should we panic (and reboot, if panic_timeout= is set) when a
>   * hung task is detected:
> @@ -137,6 +156,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  			" disables this message.\n");
>  		sched_show_task(t);
>  		hung_task_show_lock = true;
> +
> +		if (sysctl_hung_task_all_cpu_backtrace)
> +			hung_task_show_bt = true;
>  	}
>  
>  	touch_nmi_watchdog();
> @@ -201,10 +223,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  	rcu_read_unlock();
>  	if (hung_task_show_lock)
>  		debug_show_all_locks();
> -	if (hung_task_call_panic) {
> +
> +	if (hung_task_show_bt) {
> +		hung_task_show_bt = false;
>  		trigger_all_cpu_backtrace();
> +	}
> +
> +	if (hung_task_call_panic)
>  		panic("hung_task: blocked tasks");
> -	}
>  }
>  
>  static long hung_timeout_jiffies(unsigned long last_checked,
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ad5b88a53c5a..238f268de486 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1098,6 +1098,17 @@ static struct ctl_table kern_table[] = {
>  	},
>  #endif
>  #ifdef CONFIG_DETECT_HUNG_TASK
> +#ifdef CONFIG_SMP
> +	{
> +		.procname	= "hung_task_all_cpu_backtrace",
> +		.data		= &sysctl_hung_task_all_cpu_backtrace,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +#endif /* CONFIG_SMP */
>  	{
>  		.procname	= "hung_task_panic",
>  		.data		= &sysctl_hung_task_panic,
> -- 
> 2.25.1
> 

-- 
Kees Cook

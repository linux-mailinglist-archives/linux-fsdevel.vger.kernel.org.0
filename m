Return-Path: <linux-fsdevel+bounces-43026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC60A4D120
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F737A69D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CF5142E83;
	Tue,  4 Mar 2025 01:44:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6733D8;
	Tue,  4 Mar 2025 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052646; cv=none; b=ajpJoocNxcgtDbxaVEoNtDauL0PBlMXtLxIGp7I7ESO57pbiujW39yN59OM8bhIYrez2cW72VIuxenf21f6eizNTs1J9XlBptRLKLaktz6PS6JTaSZgBFRge+HlQ2sYdWuI/EdmnkLAMrZWNMVzsFfRhigAaxrqnQ9JqYatbyAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052646; c=relaxed/simple;
	bh=Hm8/JkSd6ej479ogJ1QTyYgA3ezyJHCm2ycDRDJXQAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hli6e3NDUzYi+n+hzLHl5luYKINqwmvQ8kHIuCTTZ6yA2ww2SH/tXGMgsMmoGmCGpGeyHxBeRKynL4o464nzftqfpXAlAMdaSyCTuurmH2mreR28SBJ8wFchf0FqFQN7N6n3DpIqI9vbVCpQJ9cUsCqBjpwberDbthhecECaWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E424C4CEE4;
	Tue,  4 Mar 2025 01:44:02 +0000 (UTC)
Date: Mon, 3 Mar 2025 20:44:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/8] ftrace: Move trace sysctls into trace.c
Message-ID: <20250303204455.69723c20@gandalf.local.home>
In-Reply-To: <20250218-jag-mv_ctltables-v1-3-cd3698ab8d29@kernel.org>
References: <20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org>
	<20250218-jag-mv_ctltables-v1-3-cd3698ab8d29@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 10:56:19 +0100
Joel Granados <joel.granados@kernel.org> wrote:

Nit, change the subject to:

  tracing: Move trace sysctls into trace.c

as I try to only have the "ftrace:" label for modifications that affect
attaching to functions, and "tracing:" for everything else.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> Move trace ctl tables into their own const array in
> kernel/trace/trace.c. The sysctl table register is called with
> subsys_initcall placing if after its original place in proc_root_init.
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kerenel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  include/linux/ftrace.h |  7 -------
>  kernel/sysctl.c        | 24 ------------------------
>  kernel/trace/trace.c   | 36 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 35 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index fbabc3d848b3..59774513ae45 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1298,16 +1298,9 @@ static inline void unpause_graph_tracing(void) { }
>  #ifdef CONFIG_TRACING
>  enum ftrace_dump_mode;
>  
> -#define MAX_TRACER_SIZE		100
> -extern char ftrace_dump_on_oops[];
>  extern int ftrace_dump_on_oops_enabled(void);
> -extern int tracepoint_printk;
>  
>  extern void disable_trace_on_warning(void);
> -extern int __disable_trace_on_warning;
> -
> -int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
> -			     void *buffer, size_t *lenp, loff_t *ppos);
>  
>  #else /* CONFIG_TRACING */
>  static inline void  disable_trace_on_warning(void) { }
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 6514c13800a4..baa250e223a2 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -51,7 +51,6 @@
>  #include <linux/nfs_fs.h>
>  #include <linux/acpi.h>
>  #include <linux/reboot.h>
> -#include <linux/ftrace.h>
>  #include <linux/perf_event.h>
>  #include <linux/oom.h>
>  #include <linux/kmod.h>
> @@ -1684,29 +1683,6 @@ static const struct ctl_table kern_table[] = {
>  		.proc_handler	= stack_trace_sysctl,
>  	},
>  #endif
> -#ifdef CONFIG_TRACING
> -	{
> -		.procname	= "ftrace_dump_on_oops",
> -		.data		= &ftrace_dump_on_oops,
> -		.maxlen		= MAX_TRACER_SIZE,
> -		.mode		= 0644,
> -		.proc_handler	= proc_dostring,
> -	},
> -	{
> -		.procname	= "traceoff_on_warning",
> -		.data		= &__disable_trace_on_warning,
> -		.maxlen		= sizeof(__disable_trace_on_warning),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -	},
> -	{
> -		.procname	= "tracepoint_printk",
> -		.data		= &tracepoint_printk,
> -		.maxlen		= sizeof(tracepoint_printk),
> -		.mode		= 0644,
> -		.proc_handler	= tracepoint_printk_sysctl,
> -	},
> -#endif
>  #ifdef CONFIG_MODULES
>  	{
>  		.procname	= "modprobe",
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 0e6d517e74e0..abfc0e56173b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -117,6 +117,7 @@ static int tracing_disabled = 1;
>  
>  cpumask_var_t __read_mostly	tracing_buffer_mask;
>  
> +#define MAX_TRACER_SIZE		100
>  /*
>   * ftrace_dump_on_oops - variable to dump ftrace buffer on oops
>   *
> @@ -139,7 +140,40 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
>  char ftrace_dump_on_oops[MAX_TRACER_SIZE] = "0";
>  
>  /* When set, tracing will stop when a WARN*() is hit */
> -int __disable_trace_on_warning;
> +static int __disable_trace_on_warning;
> +
> +int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
> +			     void *buffer, size_t *lenp, loff_t *ppos);
> +static const struct ctl_table trace_sysctl_table[] = {
> +	{
> +		.procname	= "ftrace_dump_on_oops",
> +		.data		= &ftrace_dump_on_oops,
> +		.maxlen		= MAX_TRACER_SIZE,
> +		.mode		= 0644,
> +		.proc_handler	= proc_dostring,
> +	},
> +	{
> +		.procname	= "traceoff_on_warning",
> +		.data		= &__disable_trace_on_warning,
> +		.maxlen		= sizeof(__disable_trace_on_warning),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
> +		.procname	= "tracepoint_printk",
> +		.data		= &tracepoint_printk,
> +		.maxlen		= sizeof(tracepoint_printk),
> +		.mode		= 0644,
> +		.proc_handler	= tracepoint_printk_sysctl,
> +	},
> +};
> +
> +static int __init init_trace_sysctls(void)
> +{
> +	register_sysctl_init("kernel", trace_sysctl_table);
> +	return 0;
> +}
> +subsys_initcall(init_trace_sysctls);
>  
>  #ifdef CONFIG_TRACE_EVAL_MAP_FILE
>  /* Map of enums to their values, for "eval_map" file */
> 



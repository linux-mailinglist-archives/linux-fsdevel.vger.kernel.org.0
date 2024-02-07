Return-Path: <linux-fsdevel+bounces-10591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F5084C88E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 11:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D7F1F22FFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65625628;
	Wed,  7 Feb 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iw/wB+nK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DA325602
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301507; cv=none; b=kw6DipXMMxsh6HpM8ZfOlndwxDkgb9xxBAHQ9BjUX8KdbiIgaihHC14t+qqmVpDWSeQqcuZa1d+TEjzswmJv3BGNUsg3Ln5phMKp9+MxghOUli0sdqI+veO3i7wuMdhcif1Qu/FwoE/nqeNn92Ae5gX/RuyJqGac6aGbU41+jX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301507; c=relaxed/simple;
	bh=3eqHy4mi9rdoFfLNOfRe9uaolV2OwWorxpGY1Z3toRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfoJPEwIIZP9bX3ZUnsJp4Xiwe5w+p36xZSa5xD8p+JpcflY+/uz7s7r8oOX+tlW2/bFXIW68rUs42UQkS7crAH7nEiujZSySvfLfEgQkeR46Ci5PkZCjK2TdZHaCD3nva54ZOVaQteBWfEpCt/rjisXj/Xdws3i+0ogM0ltje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=iw/wB+nK; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5edfcba97e3so4344467b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 02:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707301504; x=1707906304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98ifEdE4FmSU48BVNN6QSrgy+9niRVjwhRvQi5f/Mfs=;
        b=iw/wB+nKWov/sIwQvQrKlGTEfswbrYxPoqChRxGw1lVwftq7YD4A7BGh69QHpvKYhX
         Ca/yhotDygdedOp4HM/Dkq232iqbE4wzCEX7vJilPBk4ytXhQ7ihcVTLaBFIopeYrVyy
         KaJPbIp+LYD+mz5OfLrfRfwMlHFrnwrNPbZqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301504; x=1707906304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98ifEdE4FmSU48BVNN6QSrgy+9niRVjwhRvQi5f/Mfs=;
        b=aFRHAvUeRSxKjJ9Kcsg+6OZ1Xwk7lihwD7TeGSUAdirC7faEiVwgz+OwriHfGJ4d6I
         jqkmbdirjaS5tSxeyql2jfi8clT7y0R0hLf4KyPj2lHSb6rs1oqY1BkoD7gFGrBj0q7x
         aIUbcI/Ed/MSqbqOSeuV0+xvAXgm0VdX5FKVUkv5wIrC8BL15iSK4hXPhpianRzgKs8C
         Vgp7rUjSpWUmu+d6F86Vu19SgXynFcTLnPY2CIQBkzfOqzBNFzTClF/D9E9xQiphmipE
         yRNLoa8yGbXjIbcIZfR7IcgKUzxNkHOaE69UYNiVXxZgmOKMEBLvgQZj1ei8Nr4QGUOc
         BPug==
X-Forwarded-Encrypted: i=1; AJvYcCWetqvwmXwB55AHavNh+KPGNvRSEHd3z+6aOhAyOMI4gMcgJxiQzH1J0XWtDaQWfqeaOzRfYZi92Ngdw0uh5JOaPf+EPM3S9d5gtDXMIQ==
X-Gm-Message-State: AOJu0YxHKucEUwAtP/sxoOCUWVDlD0llnEZM1tpwDcrqGxIPqrqzWjRz
	+k7fYmNB1dm1Nn8X7dfMQK8HNW1eZtfU4ItheKbTEX2WCNI/sqwgi4E0aYSwfVs=
X-Google-Smtp-Source: AGHT+IG5fSvL6rkwrBZw6BrYyhl7ktB4T/w7nGPeesxKXMZDbxRA3qQOhFlc2eSqzUzVgiyPs4ktWA==
X-Received: by 2002:a81:9b06:0:b0:5ff:4e3b:dc89 with SMTP id s6-20020a819b06000000b005ff4e3bdc89mr4644708ywg.11.1707301504331;
        Wed, 07 Feb 2024 02:25:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5P2o33qOicUCFpZgid9ufWKrzLhBciV/4ta/zuhROzsSJr4AXF2Zxm8QI9KrNN2ybuR8yhmCcUndz64pzpSlGcc41Sc5MnbCa0lzJxbcAONX6DEqldwrE8zn8I2D81RvlHW+ImkbE7/vBgxCwuZt0koYqGsWPJ+z6PlhhVexKnVO+N/KshlBmM3FPHcoChWk6h5Ws9/6UPLUPFQDgvj1D9jl1vTUEXgtdwuT3rMT0PpCF+Doeo7P7HepQjlSC4WheFS8Lt21LjIBoMGH/ATA0lDfstGMb/gA+SC+ykXwe+IXJ/2cJZdvh0wb66x4mphWHYTABJWvYHyShQTn5yvJQLfLgsb42U8v4TT0mG+zN/wK8A7XxXvrtO0Hs3Xn5eHHa337RmW55qNPAv4FvZf3mbGO8ZBSGsL8arXkjqExMonjkiV2Lma7m6kL547vY1n3k4PvuJmT5bKUm2tL+gbeDcEomTDO3ethZUvfu3j5AJn9lSUU41PmdRpMSvwzCaNtdqcGDkZhKotgfRhsypLDqQTFu5vuU8lQ9Vq0Aqx+YQl50h2EI0s84fQrPb/RGpT/1C3VwEv+AR50lVApZp2ON0v2GnByyX4eq2Gw=
Received: from [192.168.0.226] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id j21-20020ac85f95000000b0042c3948f2f7sm393402qta.57.2024.02.07.02.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 02:25:03 -0800 (PST)
Message-ID: <50cdbe95-c14c-49db-86aa-458e87ae9513@joelfernandes.org>
Date: Wed, 7 Feb 2024 05:24:58 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Content-Language: en-US
To: Huang Yiwei <quic_hyiwei@quicinc.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mcgrof@kernel.org,
 keescook@chromium.org, j.granados@samsung.com,
 mathieu.desnoyers@efficios.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_bjorande@quicinc.com, quic_tsoni@quicinc.com, quic_satyap@quicinc.com,
 quic_aiquny@quicinc.com, kernel@quicinc.com,
 Ross Zwisler <zwisler@google.com>
References: <20240206094650.1696566-1-quic_hyiwei@quicinc.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240206094650.1696566-1-quic_hyiwei@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/2024 4:46 AM, Huang Yiwei wrote:
> Currently ftrace only dumps the global trace buffer on an OOPs. For
> debugging a production usecase, instance trace will be helpful to
> check specific problems since global trace buffer may be used for
> other purposes.
> 
> This patch extend the ftrace_dump_on_oops parameter to dump a specific
> or multiple trace instances:
> 
>   - ftrace_dump_on_oops=0: as before -- don't dump
>   - ftrace_dump_on_oops[=1]: as before -- dump the global trace buffer
>   on all CPUs
>   - ftrace_dump_on_oops=2 or =orig_cpu: as before -- dump the global
>   trace buffer on CPU that triggered the oops
>   - ftrace_dump_on_oops=<instance_name>: new behavior -- dump the
>   tracing instance matching <instance_name>
>   - ftrace_dump_on_oops[=2/orig_cpu],<instance1_name>[=2/orig_cpu],
>   <instrance2_name>[=2/orig_cpu]: new behavior -- dump the global trace
>   buffer and multiple instance buffer on all CPUs, or only dump on CPU
>   that triggered the oops if =2 or =orig_cpu is given
> 
> Also, the sysctl node can handle the input accordingly.
> 
> Cc: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
> ---
> Link: https://lore.kernel.org/linux-trace-kernel/20240119080824.907101-1-quic_hyiwei@quicinc.com/
> 
>  .../admin-guide/kernel-parameters.txt         |  26 ++-
>  Documentation/admin-guide/sysctl/kernel.rst   |  30 +++-
>  include/linux/ftrace.h                        |   4 +-
>  include/linux/kernel.h                        |   1 +
>  kernel/sysctl.c                               |   4 +-
>  kernel/trace/trace.c                          | 156 +++++++++++++-----
>  kernel/trace/trace_selftest.c                 |   2 +-
>  7 files changed, 168 insertions(+), 55 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 31b3a25680d0..f4c05a43b561 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1561,12 +1561,28 @@
>  			The above will cause the "foo" tracing instance to trigger
>  			a snapshot at the end of boot up.
>  
> -	ftrace_dump_on_oops[=orig_cpu]
> +	ftrace_dump_on_opps[=2(orig_cpu) | =<instance>][,<instance> |

You introduced a typo to 'oops' here.

> +			  ,<instance>=2(orig_cpu)]
>  			[FTRACE] will dump the trace buffers on oops.
> -			If no parameter is passed, ftrace will dump
> -			buffers of all CPUs, but if you pass orig_cpu, it will
> -			dump only the buffer of the CPU that triggered the
> -			oops.
> +			If no parameter is passed, ftrace will dump global
> +			buffers of all CPUs, if you pass 2 or orig_cpu, it> +			will dump only the buffer of the CPU that triggered
> +			the oops, or the specific instance will be dumped if
> +			its name is passed. Multiple instance dump is also
> +			supported, and instances are separated by commas. Each
> +			instance supports only dump on CPU that triggered the
> +			oops by passing 2 or orig_cpu to it.
> +
> +			ftrace_dump_on_opps=foo=orig_cpu


> +
> +			The above will dump only the buffer of "foo" instance
> +			on CPU that triggered the oops.
> +
> +			ftrace_dump_on_opps,foo,bar=orig_cpu
> +
> +			The above will dump global buffer on all CPUs, the
> +			buffer of "foo" instance on all CPUs and the buffer
> +			of "bar" instance on CPU that triggered the oops.
>  
>  	ftrace_filter=[function-list]
>  			[FTRACE] Limit the functions traced by the function
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 6584a1f9bfe3..ea8e5f152edc 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -296,12 +296,30 @@ kernel panic). This will output the contents of the ftrace buffers to
>  the console.  This is very useful for capturing traces that lead to
>  crashes and outputting them to a serial console.
>  
> -= ===================================================
> -0 Disabled (default).
> -1 Dump buffers of all CPUs.
> -2 Dump the buffer of the CPU that triggered the oops.
> -= ===================================================
> -
> +======================= ===========================================
> +0                       Disabled (default).
> +1                       Dump buffers of all CPUs.
> +2(orig_cpu)             Dump the buffer of the CPU that triggered the
> +                        oops.
> +<instance>              Dump the specific instance buffer on all CPUs.
> +<instance>=2(orig_cpu)  Dump the specific instance buffer on the CPU
> +                        that triggered the oops.
> +======================= ===========================================
> +
> +Multiple instance dump is also supported, and instances are separated
> +by commas. If global buffer also needs to be dumped, please specify
> +the dump mode (1/2/orig_cpu) first for global buffer.
> +
> +So for example to dump "foo" and "bar" instance buffer on all CPUs,
> +user can::
> +
> +  echo "foo,bar" > /proc/sys/kernel/ftrace_dump_on_oops
> +
> +To dump global buffer and "foo" instance buffer on all
> +CPUs along with the "bar" instance buffer on CPU that triggered the
> +oops, user can::
> +
> +  echo "1,foo,bar=2" > /proc/sys/kernel/ftrace_dump_on_oops
>  
>  ftrace_enabled, stack_tracer_enabled
>  ====================================
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index e8921871ef9a..54d53f345d14 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1151,7 +1151,9 @@ static inline void unpause_graph_tracing(void) { }
>  #ifdef CONFIG_TRACING
>  enum ftrace_dump_mode;
>  
> -extern enum ftrace_dump_mode ftrace_dump_on_oops;
> +#define MAX_TRACER_SIZE		100
> +extern char ftrace_dump_on_oops[];
> +extern int ftrace_dump_on_oops_enabled(void);
>  extern int tracepoint_printk;
>  
>  extern void disable_trace_on_warning(void);
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index d9ad21058eed..b142a4f41d34 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -255,6 +255,7 @@ enum ftrace_dump_mode {
>  	DUMP_NONE,
>  	DUMP_ALL,
>  	DUMP_ORIG,
> +	DUMP_PARAM,
>  };
>  
>  #ifdef CONFIG_TRACING
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 157f7ce2942d..81cc974913bb 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1710,9 +1710,9 @@ static struct ctl_table kern_table[] = {
>  	{
>  		.procname	= "ftrace_dump_on_oops",
>  		.data		= &ftrace_dump_on_oops,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= MAX_TRACER_SIZE,
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dostring,
>  	},
>  	{
>  		.procname	= "traceoff_on_warning",
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2a7c6fd934e9..5622614d3035 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -130,9 +130,12 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
>   * /proc/sys/kernel/ftrace_dump_on_oops
>   * Set 1 if you want to dump buffers of all CPUs
>   * Set 2 if you want to dump the buffer of the CPU that triggered oops
> + * Set instance name if you want to dump the specific trace instance
> + * Multiple instance dump is also supported, and instances are seperated
> + * by commas.
>   */
> -
> -enum ftrace_dump_mode ftrace_dump_on_oops;
> +/* Set to string format zero to disable by default */
> +char ftrace_dump_on_oops[MAX_TRACER_SIZE] = "0";
>  
>  /* When set, tracing will stop when a WARN*() is hit */
>  int __disable_trace_on_warning;
> @@ -178,7 +181,6 @@ static void ftrace_trace_userstack(struct trace_array *tr,
>  				   struct trace_buffer *buffer,
>  				   unsigned int trace_ctx);
>  
> -#define MAX_TRACER_SIZE		100
>  static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
>  static char *default_bootup_tracer;
>  
> @@ -201,19 +203,33 @@ static int __init set_cmdline_ftrace(char *str)
>  }
>  __setup("ftrace=", set_cmdline_ftrace);
>  
> +int ftrace_dump_on_oops_enabled(void)
> +{
> +	if (!strcmp("0", ftrace_dump_on_oops))
> +		return 0;
> +	else
> +		return 1;
> +}
> +
>  static int __init set_ftrace_dump_on_oops(char *str)
>  {
> -	if (*str++ != '=' || !*str || !strcmp("1", str)) {
> -		ftrace_dump_on_oops = DUMP_ALL;
> +	if (!*str) {
> +		strscpy(ftrace_dump_on_oops, "1", MAX_TRACER_SIZE);
>  		return 1;
>  	}
>  
> -	if (!strcmp("orig_cpu", str) || !strcmp("2", str)) {
> -		ftrace_dump_on_oops = DUMP_ORIG;
> -                return 1;
> -        }
> +	if (*str == ',') {
> +		strscpy(ftrace_dump_on_oops, "1", MAX_TRACER_SIZE);
> +		strscpy(ftrace_dump_on_oops + 1, str, MAX_TRACER_SIZE - 1);
> +		return 1;
> +	}
> +
> +	if (*str++ == '=') {
> +		strscpy(ftrace_dump_on_oops, str, MAX_TRACER_SIZE);
> +		return 1;
> +	}
>  
> -        return 0;
> +	return 0;
>  }
>  __setup("ftrace_dump_on_oops", set_ftrace_dump_on_oops);
>  
> @@ -10243,14 +10259,14 @@ static struct notifier_block trace_die_notifier = {
>  static int trace_die_panic_handler(struct notifier_block *self,
>  				unsigned long ev, void *unused)
>  {
> -	if (!ftrace_dump_on_oops)
> +	if (!ftrace_dump_on_oops_enabled())
>  		return NOTIFY_DONE;
>  
>  	/* The die notifier requires DIE_OOPS to trigger */
>  	if (self == &trace_die_notifier && ev != DIE_OOPS)
>  		return NOTIFY_DONE;
>  
> -	ftrace_dump(ftrace_dump_on_oops);
> +	ftrace_dump(DUMP_PARAM);
>  
>  	return NOTIFY_DONE;
>  }
> @@ -10291,12 +10307,12 @@ trace_printk_seq(struct trace_seq *s)
>  	trace_seq_init(s);
>  }
>  
> -void trace_init_global_iter(struct trace_iterator *iter)
> +static void trace_init_iter(struct trace_iterator *iter, struct trace_array *tr)
>  {
> -	iter->tr = &global_trace;
> +	iter->tr = tr;
>  	iter->trace = iter->tr->current_trace;
>  	iter->cpu_file = RING_BUFFER_ALL_CPUS;
> -	iter->array_buffer = &global_trace.array_buffer;
> +	iter->array_buffer = &tr->array_buffer;
>  
>  	if (iter->trace && iter->trace->open)
>  		iter->trace->open(iter);
> @@ -10316,22 +10332,19 @@ void trace_init_global_iter(struct trace_iterator *iter)
>  	iter->fmt_size = STATIC_FMT_BUF_SIZE;
>  }
>  
> -void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
> +void trace_init_global_iter(struct trace_iterator *iter)
> +{
> +	trace_init_iter(iter, &global_trace);
> +}
> +
> +void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_mode)
>  {
>  	/* use static because iter can be a bit big for the stack */
>  	static struct trace_iterator iter;
> -	static atomic_t dump_running;
> -	struct trace_array *tr = &global_trace;
>  	unsigned int old_userobj;
>  	unsigned long flags;>  	int cnt = 0, cpu;
>  
> -	/* Only allow one dump user at a time. */
> -	if (atomic_inc_return(&dump_running) != 1) {
> -		atomic_dec(&dump_running);
> -		return;
> -	}
> -
>  	/*
>  	 * Always turn off tracing when we dump.
>  	 * We don't need to show trace output of what happens
> @@ -10340,12 +10353,12 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
>  	 * If the user does a sysrq-z, then they can re-enable
>  	 * tracing with echo 1 > tracing_on.
>  	 */
> -	tracing_off();
> +	tracer_tracing_off(tr);
>  
>  	local_irq_save(flags);
>  
>  	/* Simulate the iterator */
> -	trace_init_global_iter(&iter);
> +	trace_init_iter(&iter, tr);
>  
>  	for_each_tracing_cpu(cpu) {
>  		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
> @@ -10356,21 +10369,15 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
>  	/* don't look at user memory in panic mode */
>  	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
>  
> -	switch (oops_dump_mode) {
> -	case DUMP_ALL:
> -		iter.cpu_file = RING_BUFFER_ALL_CPUS;
> -		break;
> -	case DUMP_ORIG:
> +	if (dump_mode == DUMP_ORIG)
>  		iter.cpu_file = raw_smp_processor_id();
> -		break;
> -	case DUMP_NONE:
> -		goto out_enable;
> -	default:
> -		printk(KERN_TRACE "Bad dumping mode, switching to all CPUs dump\n");
> +	else
>  		iter.cpu_file = RING_BUFFER_ALL_CPUS;
> -	}
>  
> -	printk(KERN_TRACE "Dumping ftrace buffer:\n");
> +	if (tr == &global_trace)
> +		printk(KERN_TRACE "Dumping ftrace buffer:\n");
> +	else
> +		printk(KERN_TRACE "Dumping ftrace instance %s buffer:\n", tr->name);
>  
>  	/* Did function tracer already get disabled? */
>  	if (ftrace_is_dead()) {
> @@ -10412,15 +10419,84 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
>  	else
>  		printk(KERN_TRACE "---------------------------------\n");
>  
> - out_enable:
>  	tr->trace_flags |= old_userobj;
>  
>  	for_each_tracing_cpu(cpu) {
>  		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
>  	}
> -	atomic_dec(&dump_running);
>  	local_irq_restore(flags);
>  }
> +
> +static void ftrace_dump_by_param(void)
> +{
> +	bool first_param = true;
> +	char dump_param[MAX_TRACER_SIZE];
> +	char *buf, *token, *inst_name;
> +	struct trace_array *tr;
> +
> +	strscpy(dump_param, ftrace_dump_on_oops, MAX_TRACER_SIZE);
> +	buf = dump_param;
> +
> +	while ((token = strsep(&buf, ",")) != NULL) {
> +		if (first_param) {
> +			first_param = false;
> +			if (!strcmp("0", token))
> +				continue;
> +			else if (!strcmp("1", token)) {
> +				ftrace_dump_one(&global_trace, DUMP_ALL);
> +				continue;
> +			}
> +			else if (!strcmp("2", token) ||
> +			  !strcmp("orig_cpu", token)) {
> +				ftrace_dump_one(&global_trace, DUMP_ORIG);

DUMP_PARAM and ftrace_dump_by_param() is a bit of a misnomer, because it
optionally also dumps the original buffer, not just the instances. That's
probably OK though.

FWIW:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Btw, hopefully the "trace off on warning" and related boot parameters also apply
to instances, I haven't personally checked but I often couple those with the
dump-on-oops ones.

Thanks.


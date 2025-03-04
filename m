Return-Path: <linux-fsdevel+bounces-43027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10732A4D132
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DFC174127
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B511553AB;
	Tue,  4 Mar 2025 01:46:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE7136347;
	Tue,  4 Mar 2025 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052804; cv=none; b=H0k2hBQxyoalM28+l/xpuB/D7YdIbyUfYZROlwcjERMX7dys3QGjmPLqW8YzCf1E1EtjmfU4jv4h/5knt2EW6/V740oMthPrKmSpIFQOrXe43CSomWM7QOTRbXX3bYzcLnmTYhQJo55YeqJEoSebk5lStMJuUfhnPlI5hTdPphU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052804; c=relaxed/simple;
	bh=uI4aKqpuzt3742VEL0ucD83H5oRjcLrVnMEmZ0UADgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gpwzh+p6gdc53K2GXBxUCzj8OcEKh0c556MYK33v+b/RMKBNzxoH/ZbcNfHp88sQCJWy3ycrWb1xMkbaMqhxISusHixenx1aQleRFuOkayVfxZrNqOwOFT0qRPchDtD7sEGJ/6ub9XxATZ61vPlAtkP7c33MBNRB9+MAYysWaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0706C4CEE8;
	Tue,  4 Mar 2025 01:46:39 +0000 (UTC)
Date: Mon, 3 Mar 2025 20:47:32 -0500
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
Subject: Re: [PATCH 4/8] stack_tracer: move sysctl registration to
 kernel/trace/trace.c
Message-ID: <20250303204732.1f5af40d@gandalf.local.home>
In-Reply-To: <20250218-jag-mv_ctltables-v1-4-cd3698ab8d29@kernel.org>
References: <20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org>
	<20250218-jag-mv_ctltables-v1-4-cd3698ab8d29@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 10:56:20 +0100
Joel Granados <joel.granados@kernel.org> wrote:

> Squash with ftrace:
> Move stac_tracer_enabled into trace_sysctl_table while keeping the
> CONFIG_STACK_TRACER ifdef. This is part of a greater effort to move ctl
> tables into their respective subsystems which will reduce the merge
> conflicts in kerenel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  kernel/sysctl.c      | 10 ----------
>  kernel/trace/trace.c |  9 +++++++++
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index baa250e223a2..dc3747cc72d4 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -68,7 +68,6 @@
>  
>  #ifdef CONFIG_X86
>  #include <asm/nmi.h>
> -#include <asm/stacktrace.h>
>  #include <asm/io.h>
>  #endif
>  #ifdef CONFIG_SPARC
> @@ -1674,15 +1673,6 @@ static const struct ctl_table kern_table[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif
> -#ifdef CONFIG_STACK_TRACER
> -	{
> -		.procname	= "stack_tracer_enabled",
> -		.data		= &stack_tracer_enabled,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= stack_trace_sysctl,
> -	},
> -#endif
>  #ifdef CONFIG_MODULES
>  	{
>  		.procname	= "modprobe",
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index abfc0e56173b..17b449f9e330 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c

This should go into kernel/trace/trace_stack.c, and remove the #ifdef.

-- Steve

> @@ -166,6 +166,15 @@ static const struct ctl_table trace_sysctl_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= tracepoint_printk_sysctl,
>  	},
> +#ifdef CONFIG_STACK_TRACER
> +	{
> +		.procname	= "stack_tracer_enabled",
> +		.data		= &stack_tracer_enabled,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= stack_trace_sysctl,
> +	},
> +#endif
>  };
>  
>  static int __init init_trace_sysctls(void)
> 



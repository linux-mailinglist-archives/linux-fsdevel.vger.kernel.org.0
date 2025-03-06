Return-Path: <linux-fsdevel+bounces-43367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4209A54F41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 16:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF047189C231
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9F211A3E;
	Thu,  6 Mar 2025 15:31:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB720E71F;
	Thu,  6 Mar 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275100; cv=none; b=IbFj/h3e+h0Wi0L1yxqLCdloQy7xPfg0zR20Xc5iE4WLsIXDkV0xFiKauVjt3y2psHtP9SZh4gt2exvBpxq73PWFvyN1zi65ItZEP/rnI2RHqIUk8RljB1IbW/Z9kd9Isen7XFYd1I3ZQsUk9aerw0mfvQvr5tOZlZA/uFSd4rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275100; c=relaxed/simple;
	bh=SQ4miVnhmPAoOA/6WTcJSGaPc/CNU83guyGxo0OGbvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwuhCBDV47wPMx4E5OlxGd9tBSzWPoNQ+wN4SCzkkdF/Z+cSNkQgOy33popx0pJmciuFW6yR9x/V45aMGDET1gESRnCixJhnFo6/7rfUBnxZd1OfcEwRH4KSBOiOVanAqw/uggeteDuD26h+6AOln3nPaJYR0CjVVEyQ7oKRb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A15C4CEE4;
	Thu,  6 Mar 2025 15:31:38 +0000 (UTC)
Date: Thu, 6 Mar 2025 10:31:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 4/6] stack_tracer: move sysctl registration to
 kernel/trace/trace_stack.c
Message-ID: <20250306103138.3cfc2955@gandalf.local.home>
In-Reply-To: <20250306-jag-mv_ctltables-v2-4-71b243c8d3f8@kernel.org>
References: <20250306-jag-mv_ctltables-v2-0-71b243c8d3f8@kernel.org>
	<20250306-jag-mv_ctltables-v2-4-71b243c8d3f8@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Mar 2025 12:29:44 +0100
Joel Granados <joel.granados@kernel.org> wrote:

> Move stack_tracer_enabled into trace_stack_sysctl_table. This is part of
> a greater effort to move ctl tables into their respective subsystems
> which will reduce the merge conflicts in kerenel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  kernel/sysctl.c            | 10 ----------
>  kernel/trace/trace_stack.c | 20 ++++++++++++++++++++
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index baa250e223a26bafc39cb7a7d7635b4f7f5dcf56..dc3747cc72d470662879e4f2b7f2651505b7ca90 100644
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
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 14c6f272c4d8a382070d45e1cf0ee97db38831c9..b7ffbc1da8357f9c252cb8936c8f789daa97eb9a 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -578,3 +578,23 @@ static __init int stack_trace_init(void)
>  }
>  
>  device_initcall(stack_trace_init);
> +
> +
> +static const struct ctl_table trace_stack_sysctl_table[] = {
> +	{
> +		.procname	= "stack_tracer_enabled",
> +		.data		= &stack_tracer_enabled,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= stack_trace_sysctl,
> +	},
> +};
> +
> +static int __init init_trace_stack_sysctls(void)
> +{
> +	register_sysctl_init("kernel", trace_stack_sysctl_table);
> +	return 0;
> +}
> +subsys_initcall(init_trace_stack_sysctls);
> +
> +
> 

This should also make the variable "stack_tracer_enabled" static and
removed from the ftrace.h header.

-- Steve



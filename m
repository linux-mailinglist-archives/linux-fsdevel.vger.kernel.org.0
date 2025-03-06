Return-Path: <linux-fsdevel+bounces-43332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E59A547F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAF41712B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D444207E12;
	Thu,  6 Mar 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FE270KjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39320468E;
	Thu,  6 Mar 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257450; cv=none; b=DQ1NACpCpyJyWP2BRXHRgEUEz++/R2YURV0cIKzGIsYK4i8oZm94jg1Dv1ZXCYA2QPL0QfsdCDJXA/4yvYISkdLf6d7/hptWMMjWo5IyATCoS1kAFUo25cuylD2Z6y52EtPodpgis2ikCvCYCVxupRFD7KjUdAtWaTVCAvlXUMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257450; c=relaxed/simple;
	bh=qevjN5tUatdD4sRyacUuX0cpfWvxaopsOVfxeABNgSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqPLSzCOKjBD4JTJL5hEbnej1a76DX7LTs+nij/uO2m6oIOoyx2Qv++zL+2MzEc8pXsNDq8MdS7SFmHFgybAwLJPsProQYpIpasE8tZ+R4DYPgJLVMOFNCROMVnCgLTCeqqTh7IH+2s6+ITF2Go2r0h3IaFBlLwYgU9UMjLt4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FE270KjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB1CC4CEE0;
	Thu,  6 Mar 2025 10:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741257450;
	bh=qevjN5tUatdD4sRyacUuX0cpfWvxaopsOVfxeABNgSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FE270KjJC49vsjvPwANMviQ4xzGVAwPXLtdLVrLcnC/xBC0D/nSnefHiAKdLduxHX
	 v08BqHo2rdOAZwy0krwrM3GdzgFV4NDZ/I89Xa0Srcs38toyi5DyWr4OEGSFO+Y/mr
	 w/KwAFMXqAzH4TqXwZ+W+ejJGinyIsVQh4Gk7NYpf+YbJg4gY0bYE9s/uTVb/3xxVA
	 7+td4U/iJCL8RcjO9UyBSdlG/e1RcfrZfx27TEdHOdR/uyAyVZfLyBle7dKIFjFmJy
	 H9QeBGuGwpzfhC5ei9Zi7O0bzykpAIF8kR5Sh0bwe0rTpJUsP+7xdF0kIN6W0VjrY4
	 4ITbFAf0Y62yQ==
Date: Thu, 6 Mar 2025 11:37:24 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 4/8] stack_tracer: move sysctl registration to
 kernel/trace/trace.c
Message-ID: <f574knvwbip2hvyvorxcxfjrojd2bblmewvfsv6utivydljrpj@h2cryrh7cojq>
References: <20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org>
 <20250218-jag-mv_ctltables-v1-4-cd3698ab8d29@kernel.org>
 <20250303204732.1f5af40d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303204732.1f5af40d@gandalf.local.home>

On Mon, Mar 03, 2025 at 08:47:32PM -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2025 10:56:20 +0100
> Joel Granados <joel.granados@kernel.org> wrote:
> 
> > Squash with ftrace:
I'll also fix this little marker that I missed. And I'll not squash it,
as it is now going into trace_stack.c

> > Move stac_tracer_enabled into trace_sysctl_table while keeping the
> > CONFIG_STACK_TRACER ifdef. This is part of a greater effort to move ctl
I'll remove these comments from the commit message

> > tables into their respective subsystems which will reduce the merge
> > conflicts in kerenel/sysctl.c.
> > 
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> >  kernel/sysctl.c      | 10 ----------
> >  kernel/trace/trace.c |  9 +++++++++
> >  2 files changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index baa250e223a2..dc3747cc72d4 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -68,7 +68,6 @@
> >  
> >  #ifdef CONFIG_X86
> >  #include <asm/nmi.h>
> > -#include <asm/stacktrace.h>
> >  #include <asm/io.h>
> >  #endif
> >  #ifdef CONFIG_SPARC
> > @@ -1674,15 +1673,6 @@ static const struct ctl_table kern_table[] = {
> >  		.proc_handler	= proc_dointvec,
> >  	},
> >  #endif
> > -#ifdef CONFIG_STACK_TRACER
> > -	{
> > -		.procname	= "stack_tracer_enabled",
> > -		.data		= &stack_tracer_enabled,
> > -		.maxlen		= sizeof(int),
> > -		.mode		= 0644,
> > -		.proc_handler	= stack_trace_sysctl,
> > -	},
> > -#endif
> >  #ifdef CONFIG_MODULES
> >  	{
> >  		.procname	= "modprobe",
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index abfc0e56173b..17b449f9e330 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> 
> This should go into kernel/trace/trace_stack.c, and remove the #ifdef.
Will send my V2 shortly with this modification.
> 
> -- Steve
> 
> > @@ -166,6 +166,15 @@ static const struct ctl_table trace_sysctl_table[] = {
> >  		.mode		= 0644,
> >  		.proc_handler	= tracepoint_printk_sysctl,
> >  	},
> > +#ifdef CONFIG_STACK_TRACER
> > +	{
> > +		.procname	= "stack_tracer_enabled",
> > +		.data		= &stack_tracer_enabled,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= stack_trace_sysctl,
> > +	},
> > +#endif
> >  };
> >  
> >  static int __init init_trace_sysctls(void)
> > 
> 

Thx for the review

Best

-- 

Joel Granados


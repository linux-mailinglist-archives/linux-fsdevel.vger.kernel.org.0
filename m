Return-Path: <linux-fsdevel+bounces-43909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F207A5FB58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47610188F4E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481AC269823;
	Thu, 13 Mar 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu8prNQf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211A268FF4;
	Thu, 13 Mar 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882752; cv=none; b=uXVBYZykiPqdIfF9h/GkP1zAZBDNnKpNpqTmdllRCSdlDc89Pr44Y9oMV9CsWJn42Jr4EiXBfdOaby8r0wU/4jtaIa/9jcez7N32dHQAPO3TZHtsB6UsT+vi2sNcTCa6AhpbrfsHMSYw4ezTzGnnr0hYAEbo5Ws4OzaW1sjT6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882752; c=relaxed/simple;
	bh=CM3XdOQtMRDGoNrytaM4lxfbhkyuqNr4n2ugVSRqcDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/TqOQLTu6UBujf8WNFaV1QG5gPAE+oI0x5pGi/qiSzYjA9kpOMtx5woqFaRIG0gQqEz6FAyfqt094VJlH8TXsx6FqBn6FB16fJN/VaBzppDgxRSa8GBUNGvuEtyCw9c47nIzNKFS/j6gJokQbe8noKabveaHLsW20FCxPa4xEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu8prNQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E17C4CEEA;
	Thu, 13 Mar 2025 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882752;
	bh=CM3XdOQtMRDGoNrytaM4lxfbhkyuqNr4n2ugVSRqcDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cu8prNQfApsdNwHKLjiD6EWiOTEp7fGiIH/TZ9N64o7KQSIbVlWhqReYofAl637kX
	 BUTyt2Hxhav+62TzBQH4pBDjK8lN49jU+NbNVegqnODzvdI5VMCNkzmkTrDtW99z7Z
	 ruyYL5qA+AJMKNPvxqrlzL3BXJN4GLWEvyWrAXYiXj/ur4yy/D9iWKX+RUFeHzseXr
	 JRzTuVR1j0QX3g7sX6Jxaw/tgsyzjlinrn34BuU0m2w1eaVp5aPq/Bq2ELqPgFFbkQ
	 EvhNr3kSNuPHXD0ola7saJYckFpPdIYEoJvTULwTC9aIhekI8oQ9jXIsFraxfVlpML
	 IVtIkOwmchynw==
Date: Thu, 13 Mar 2025 17:19:06 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 4/6] stack_tracer: move sysctl registration to
 kernel/trace/trace_stack.c
Message-ID: <zeijhrq5umjjiectrpbuebdnnwrdaqjoxd3aonhkesxj6a3pgi@mmqoadbqoh4n>
References: <20250306-jag-mv_ctltables-v2-0-71b243c8d3f8@kernel.org>
 <20250306-jag-mv_ctltables-v2-4-71b243c8d3f8@kernel.org>
 <20250306103138.3cfc2955@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306103138.3cfc2955@gandalf.local.home>

On Thu, Mar 06, 2025 at 10:31:38AM -0500, Steven Rostedt wrote:
> On Thu, 06 Mar 2025 12:29:44 +0100
> Joel Granados <joel.granados@kernel.org> wrote:
> 
> > Move stack_tracer_enabled into trace_stack_sysctl_table. This is part of
> > a greater effort to move ctl tables into their respective subsystems
> > which will reduce the merge conflicts in kerenel/sysctl.c.
> > 
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> >  kernel/sysctl.c            | 10 ----------
> >  kernel/trace/trace_stack.c | 20 ++++++++++++++++++++
> >  2 files changed, 20 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index baa250e223a26bafc39cb7a7d7635b4f7f5dcf56..dc3747cc72d470662879e4f2b7f2651505b7ca90 100644
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
> > diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> > index 14c6f272c4d8a382070d45e1cf0ee97db38831c9..b7ffbc1da8357f9c252cb8936c8f789daa97eb9a 100644
> > --- a/kernel/trace/trace_stack.c
> > +++ b/kernel/trace/trace_stack.c
> > @@ -578,3 +578,23 @@ static __init int stack_trace_init(void)
> >  }
> >  
> >  device_initcall(stack_trace_init);
> > +
> > +
> > +static const struct ctl_table trace_stack_sysctl_table[] = {
> > +	{
> > +		.procname	= "stack_tracer_enabled",
> > +		.data		= &stack_tracer_enabled,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= stack_trace_sysctl,
> > +	},
> > +};
> > +
> > +static int __init init_trace_stack_sysctls(void)
> > +{
> > +	register_sysctl_init("kernel", trace_stack_sysctl_table);
> > +	return 0;
> > +}
> > +subsys_initcall(init_trace_stack_sysctls);
> > +
> > +
> > 
> 
> This should also make the variable "stack_tracer_enabled" static and
> removed from the ftrace.h header.
oops, my bad. just sent out V3.

Thx
Best

-- 

Joel Granados


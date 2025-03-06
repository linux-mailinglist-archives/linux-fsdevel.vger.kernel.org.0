Return-Path: <linux-fsdevel+bounces-43331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C226A54784
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0FF189281C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A37120011D;
	Thu,  6 Mar 2025 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAwOtLHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C717B50B;
	Thu,  6 Mar 2025 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256159; cv=none; b=f9qyFQSJFGv6EMAVMFUt9anvh/boqo2b9nehgchV817+E2i4dDD7ZSmU1TDzT768YRAaE8TPNy9yKDZ2b7f3k4r+eHngog1qdFDrY+SbN6i2t27dGsVLXQR9ju8Fz81H/unmYXr1+sncu+JaSVGWNbOJsfNVIDMKB285/tT3zu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256159; c=relaxed/simple;
	bh=GyD5rv2egr2dMdLAzHO0FeBEFkCMJ1OAl97tzWJuVcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AALKbeI6voHNJtWx/Ps7MWW06ssQXuoy0PBWPLXxSv09MlbfCV6xr8mj+glcxnmP3C6IJBSda7r0UMwwzNrCDKIfnDZMfBEFhOLZUGDybq2fMr3tlouLFFyRf7Gi3uPr/keakXcbag2j4KQv8OGbVNEvioACD5VXUteUaZPEiL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAwOtLHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FC0C4CEE0;
	Thu,  6 Mar 2025 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741256159;
	bh=GyD5rv2egr2dMdLAzHO0FeBEFkCMJ1OAl97tzWJuVcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QAwOtLHaszWKb2z40qTZfmkWj0elqbFbgDTWAWlnnJmPwsE83GHvKS39FnQV7SPYR
	 T2zNPUk/TXzzSyelENHgIPOHOtQJlwZ0sfnqoDPq0EHzH0t8BmfHfDntuhK5UxsiaF
	 amwC8JcF/NU+7jisf7pDtdeqOHlGmP/YTZk+h+qQYwxAzi3WJgkOxdr5rNGjUc7OfO
	 eGcciFwbQDCh8fAlo5Jja8gYTso8yrFqO4UPHA+SP8rhSoml84JkH3JbJS/DBYnzFg
	 1uEeH+9418DNDOK+0O0gSvKi+G10D6q6Q0cSDfQ/aaUIg9eNn4z6rWdB1vaBKl27FZ
	 annRwzXDVmOLA==
Date: Thu, 6 Mar 2025 11:15:38 +0100
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
Subject: Re: [PATCH 3/8] ftrace: Move trace sysctls into trace.c
Message-ID: <dekaemtglzq5el2omrusxyqntdqbzyllcalzor4jrindici25g@x2bdsiblw6iw>
References: <20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org>
 <20250218-jag-mv_ctltables-v1-3-cd3698ab8d29@kernel.org>
 <20250303204455.69723c20@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303204455.69723c20@gandalf.local.home>

On Mon, Mar 03, 2025 at 08:44:55PM -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2025 10:56:19 +0100
> Joel Granados <joel.granados@kernel.org> wrote:
> 
> Nit, change the subject to:
> 
>   tracing: Move trace sysctls into trace.c
Done. Thx for the feedback 

Best
> 
> as I try to only have the "ftrace:" label for modifications that affect
> attaching to functions, and "tracing:" for everything else.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 
> 
> > Move trace ctl tables into their own const array in
> > kernel/trace/trace.c. The sysctl table register is called with
> > subsys_initcall placing if after its original place in proc_root_init.
> > This is part of a greater effort to move ctl tables into their
> > respective subsystems which will reduce the merge conflicts in
> > kerenel/sysctl.c.
> > 
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
...
> > +	},
> > +};
> > +
> > +static int __init init_trace_sysctls(void)
> > +{
> > +	register_sysctl_init("kernel", trace_sysctl_table);
> > +	return 0;
> > +}
> > +subsys_initcall(init_trace_sysctls);
> >  
> >  #ifdef CONFIG_TRACE_EVAL_MAP_FILE
> >  /* Map of enums to their values, for "eval_map" file */
> > 
> 

-- 

Joel Granados


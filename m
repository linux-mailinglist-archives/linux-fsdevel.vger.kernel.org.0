Return-Path: <linux-fsdevel+bounces-42216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F99A3EFB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 10:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B33188FF0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F08A2036F4;
	Fri, 21 Feb 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULDQ2ZjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6291FC11E;
	Fri, 21 Feb 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129219; cv=none; b=Vog2NBZnEjv8DqQhUU3zC8QiRDz2GRdCQmriVEq8sgYMrrSGbvtWjylid/Y9FZK2KJCcviOJV8CY+rHTxgYGJEN0JijrhqjvroejpnvhnTRJ6qni17y8vSt77k2ujBx2TO2c4cPA9hDbKe0NEb5RryX2dri0x8DGEdDID7vTCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129219; c=relaxed/simple;
	bh=rDEihz2SYq+qWRIswF8iAj6c1YlBHyFHD/d/IEGQKvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBChZbL0JFpTNqklEgRFpcP2zePKyiZeUexAr2Kj0nh6tQ0JpPiFXbD43ohu47M6H+0MHOI+ilwKF12lj2RgGtJXiZ5snEUnFvKEGdYMacti00T1NqgPDtnMksV0FUHCfGdGWkYJTCwIrpKhcQaMsFkTwPZwFnGowd3m3pvBv9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULDQ2ZjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B57C4CED6;
	Fri, 21 Feb 2025 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740129219;
	bh=rDEihz2SYq+qWRIswF8iAj6c1YlBHyFHD/d/IEGQKvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULDQ2ZjH02Hj782GvcFfA82R6BeT8ck4xAGbF1R7G9A1V6rPQ+XUGRLwETaN5KaRH
	 iJsup2Fu+bhvBseHfPDLh3UbOgoTzye12t+JfSzVVAu9tk5/Zviqzh8uSqjt0oFWPq
	 k/Scy0aQAwbKtKeIDAaBF/6j6XRPGLqal+hgUbcwL2XIdtZj4a0GgEMYtREIFuEU0x
	 Zv7bFWsLpR83Rwm/3dDdXlVa4jevjYdDmA080UR1FlIBH2uzTx+xNAYlKLNyUOLMLq
	 nK4s2UecTMKwxGxVK2a+Z9MWB++Xg9c0Y7KjorfLW0oPTQBmSKyjeAwPWN93Xo2MXT
	 IaQ0uqQjn2iIA==
Date: Fri, 21 Feb 2025 08:59:54 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 7/8] s390: mv s390 sysctls into their own file under
 arch/s390 dir
Message-ID: <yiuirrlckwb5ressit6gcoi6yljcy6ggtopaf5bsgpxb5jp4v4@azntrnnk7zdr>
References: <20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org>
 <20250218-jag-mv_ctltables-v1-7-cd3698ab8d29@kernel.org>
 <20250218140821.7740Ab5-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218140821.7740Ab5-hca@linux.ibm.com>

On Tue, Feb 18, 2025 at 03:08:21PM +0100, Heiko Carstens wrote:
> On Tue, Feb 18, 2025 at 10:56:23AM +0100, joel granados wrote:
> > Move s390 sysctls (spin_retry and userprocess_debug) into their own
> > files under arch/s390. We create two new sysctl tables
> > (2390_{fault,spin}_sysctl_table) which will be initialized with
> > arch_initcall placing them after their original place in proc_root_init.
> > 
> > This is part of a greater effort to move ctl tables into their
> > respective subsystems which will reduce the merge conflicts in
> > kerenel/sysctl.c.
>   ^^^^^^^
> typo
Fixed

> 
> > diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
> > index a81a01c44927..4483fdc9d472 100644
> > --- a/arch/s390/lib/spinlock.c
> > +++ b/arch/s390/lib/spinlock.c
> > @@ -17,6 +17,10 @@
> >  #include <asm/alternative.h>
> >  #include <asm/asm.h>
> >  
> > +#if defined(CONFIG_SMP)
> > +#include <linux/sysctl.h>
> > +#endif
> > +
> ...
> > +#if defined(CONFIG_SMP)
> > +static const struct ctl_table s390_spin_sysctl_table[] = {
> > +	{
> > +		.procname	= "spin_retry",
> > +		.data		= &spin_retry,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= proc_dointvec,
> > +	},
> > +};
> > +
> > +static int __init init_s390_spin_sysctls(void)
> > +{
> > +	register_sysctl_init("kernel", s390_spin_sysctl_table);
> > +	return 0;
> > +}
> > +arch_initcall(init_s390_spin_sysctls);
> > +#endif
> 
> I see that you want to keep the existing CONFIG_SMP behaviour, but since a
> long time s390 enforces CONFIG_SMP=y (this was obviously never reflected in
> kernel/sysctl.c).
> Therefore the above ifdefs should be removed, and in addition the include
> statement should be added to the other linux includes at the top of the file.
I'll add these changes to my V2

Thx for the review

-- 

Joel Granados


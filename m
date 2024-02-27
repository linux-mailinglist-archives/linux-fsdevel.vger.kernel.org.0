Return-Path: <linux-fsdevel+bounces-12912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFD868640
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 02:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999AF2848DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 01:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C50CA6B;
	Tue, 27 Feb 2024 01:45:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3BC2916;
	Tue, 27 Feb 2024 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998359; cv=none; b=qaNfWJtHf/M9o9HJXZnDpl0QwsnBwz4FUy1zMZJV/ITIaWeFpqLKyIORATpwbPO6IfiP98qPz2kiqlDLefIm8pZFZiY4gbWq/PiFU12f1ayt7cOKE14wi2VY82c3oStYPB7n+mz2SHmGMff9U7SMEpX2V0pDmNN04QHeOjgmcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998359; c=relaxed/simple;
	bh=LuyC8MIBSY/6X2DV9kyguJMcgXgow64FfJ55DNaRInI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+i56kCQXs5W5iL0+lwW2FrMlDhSxL0YgIUNKqQ6MmEAlG+ZY/76u4yYuJGamB3OjmmiGYhogclfPzRPcZue4sTK01ptkdgZClNhXjRfhiSFKJHrjbuQqmqPjPtzSciRCH+SbcC2SwNmI5/MUr1FbleT6GxQSXyUOwJH8PyX8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A64C43390;
	Tue, 27 Feb 2024 01:45:56 +0000 (UTC)
Date: Mon, 26 Feb 2024 20:47:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Huang Yiwei <quic_hyiwei@quicinc.com>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>, <mcgrof@kernel.org>,
 <keescook@chromium.org>, <j.granados@samsung.com>,
 <mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <quic_bjorande@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
 Ross Zwisler <zwisler@google.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v5] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Message-ID: <20240226204757.1a968a10@gandalf.local.home>
In-Reply-To: <20240208131814.614691-1-quic_hyiwei@quicinc.com>
References: <20240208131814.614691-1-quic_hyiwei@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 21:18:14 +0800
Huang Yiwei <quic_hyiwei@quicinc.com> wrote:

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

So we need to add that the syntax is:

 ftrace_dump_on_oops[=[<0|1|2|orig_cpu>,][<instance_name>[=<1|2|orig_cpu>][,...]]

> 
> Also, the sysctl node can handle the input accordingly.
> 
> Cc: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
> ---
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
> index 31b3a25680d0..3d6ea8e80c2f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1561,12 +1561,28 @@
>  			The above will cause the "foo" tracing instance to trigger
>  			a snapshot at the end of boot up.
>  
> -	ftrace_dump_on_oops[=orig_cpu]
> +	ftrace_dump_on_oops[=2(orig_cpu) | =<instance>][,<instance> |
> +			  ,<instance>=2(orig_cpu)]
>  			[FTRACE] will dump the trace buffers on oops.
> -			If no parameter is passed, ftrace will dump
> -			buffers of all CPUs, but if you pass orig_cpu, it will
> -			dump only the buffer of the CPU that triggered the
> -			oops.
> +			If no parameter is passed, ftrace will dump global
> +			buffers of all CPUs, if you pass 2 or orig_cpu, it
> +			will dump only the buffer of the CPU that triggered
> +			the oops, or the specific instance will be dumped if
> +			its name is passed. Multiple instance dump is also
> +			supported, and instances are separated by commas. Each
> +			instance supports only dump on CPU that triggered the
> +			oops by passing 2 or orig_cpu to it.
> +
> +			ftrace_dump_on_oops=foo=orig_cpu
> +
> +			The above will dump only the buffer of "foo" instance
> +			on CPU that triggered the oops.
> +
> +			ftrace_dump_on_oops,foo,bar=orig_cpu

I believe the above is incorrect. It should be:

			ftrace_dump_on_oops=foo,bar=orig_cpu

And you can add here as well:

  ftrace_dump_on_oops[=[<0|1|2|orig_cpu>,][<instance_name>[=<1|2|orig_cpu>][,...]]


Thanks,

--Steve

> +
> +			The above will dump global buffer on all CPUs, the
> +			buffer of "foo" instance on all CPUs and the buffer
> +			of "bar" instance on CPU that triggered the oops.
>  
>  	ftrace_filter=[function-list]


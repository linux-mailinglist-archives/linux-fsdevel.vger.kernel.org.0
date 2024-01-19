Return-Path: <linux-fsdevel+bounces-8319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E1E832D8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 17:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA48B253E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D00F55E54;
	Fri, 19 Jan 2024 16:55:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758255784;
	Fri, 19 Jan 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683307; cv=none; b=HtiaZJmkG9ApnPLFs2kzGy3DKKGX5Pf44FiTjpXv+WhCQUopJRM7SWPJd3FjAZ55Bd32QnNo6/aAbz1TcK3krbEjUW2Iej+4rP1j30p2vsErqwsWqgK1PDmMGefCDU65iwqFapjXuIUqO7g78QaeRGWA247p+RiHKI84p5pwFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683307; c=relaxed/simple;
	bh=su/Rz+5699sb7UQeTkajOvLoS6GIiWIG1/7YwxHT1uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ad1h3bH5UnKZSqF8KlfA4C/Qm0HnQGv8ZSWW04PxnZ1TXO6HX9Rv8KpwXV3VFRg/cNea9mGm8x1JRZZvTiNUr7m6xoj7pEzhgAzfhbv2Ddtm9Bddk8PW8b37rZiK+TRArRVjTzSflLuPKF7uUCudd/yz7zXnOP7gPun5M/Z2z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FBEC433F1;
	Fri, 19 Jan 2024 16:55:04 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:56:25 -0500
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
Subject: Re: [PATCH v3] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Message-ID: <20240119115625.603188d1@gandalf.local.home>
In-Reply-To: <20240119080824.907101-1-quic_hyiwei@quicinc.com>
References: <20240119080824.907101-1-quic_hyiwei@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 16:08:24 +0800
Huang Yiwei <quic_hyiwei@quicinc.com> wrote:

> -	ftrace_dump_on_oops[=orig_cpu]
> +	ftrace_dump_on_oops[=orig_cpu | =<instance>]

I wonder if we should have it be:

	ftrace_dump_on_oops[=orig_cpu | =<instance> | =<instance>:orig_cpu ]

Then last would be to only print out a specific CPU trace of the given instance.

And if we really want to be fancy!

	ftrace_dump_on_opps[=orig_cpu | =<instance> | =orig_cpu:<instance> ][,<instance> | ,<instance>:orig_cpu]

That would allow dumping more than one instance.

If you want to dump the main buffer and an instance foo:

	ftrace_dump_on_opps,foo

Where the ',' says to dump the top instance as well as the foo instance.

-- Steve


>  			[FTRACE] will dump the trace buffers on oops.
> -			If no parameter is passed, ftrace will dump
> -			buffers of all CPUs, but if you pass orig_cpu, it will
> +			If no parameter is passed, ftrace will dump global
> +			buffers of all CPUs, if you pass orig_cpu, it will
>  			dump only the buffer of the CPU that triggered the
> -			oops.
> +			oops, or specific instance will be dumped if instance
> +			name is passed.
>  


Return-Path: <linux-fsdevel+bounces-12865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E5867FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 19:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33657B22818
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607DA12F366;
	Mon, 26 Feb 2024 18:42:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11181DFF4;
	Mon, 26 Feb 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972950; cv=none; b=OtXkHRqPiOW+7O11VyLpAcAiHP8XSHXSZNaV4CJKdDBXEq+mfAYltkTUjyNJby1eaeXznIXBUpiGmiINHtpZkR2YOqCx7WbsenSyNcrdwsd9o922fmp1klcHXqIqB3a+Jr0DTeG20pOeYOB84Mgwcg3eCqQPNMrdwj/fSPnr9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972950; c=relaxed/simple;
	bh=Hjg6gAVYSPGPkuU/WK2hyxogEVFTpcy0yZUtOOorB+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iX3XREWM6RP3bCNvoLFs4sHUF6yLgL5snKR7HogRU/F69smLfT+VSKfUch0P48aSI1nFO9io195r25WHYPU/bZXv/14iM5JyUx4ZGkD4Uf7GbjK7yQHxUPBgFYMlqtZ0iB5XHAaO8zQLQ2xvjh81nx8v8lOEeAVT7AiOK9sd2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778D5C433C7;
	Mon, 26 Feb 2024 18:42:27 +0000 (UTC)
Date: Mon, 26 Feb 2024 13:44:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Huang Yiwei <quic_hyiwei@quicinc.com>, <mark.rutland@arm.com>,
 <mcgrof@kernel.org>, <keescook@chromium.org>, <j.granados@samsung.com>,
 <mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <quic_bjorande@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
 Ross Zwisler <zwisler@google.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v5] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Message-ID: <20240226134427.3a033d4a@gandalf.local.home>
In-Reply-To: <20240226085158.526e8044a85ceca8578a1656@kernel.org>
References: <20240208131814.614691-1-quic_hyiwei@quicinc.com>
	<20240226085158.526e8044a85ceca8578a1656@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 08:51:58 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 8 Feb 2024 21:18:14 +0800
> Huang Yiwei <quic_hyiwei@quicinc.com> wrote:
> 
> > Currently ftrace only dumps the global trace buffer on an OOPs. For
> > debugging a production usecase, instance trace will be helpful to
> > check specific problems since global trace buffer may be used for
> > other purposes.
> > 
> > This patch extend the ftrace_dump_on_oops parameter to dump a specific
> > or multiple trace instances:
> > 
> >   - ftrace_dump_on_oops=0: as before -- don't dump
> >   - ftrace_dump_on_oops[=1]: as before -- dump the global trace buffer
> >   on all CPUs
> >   - ftrace_dump_on_oops=2 or =orig_cpu: as before -- dump the global
> >   trace buffer on CPU that triggered the oops
> >   - ftrace_dump_on_oops=<instance_name>: new behavior -- dump the
> >   tracing instance matching <instance_name>
> >   - ftrace_dump_on_oops[=2/orig_cpu],<instance1_name>[=2/orig_cpu],  
> 
> Would you mean "ftrace_dump_on_oops,<instance1_name>" ?

??

> As far as I can see, it doesn't work. Command line parser requires "="
> for parameter value. 

Not sure what you mean, but it does work with:

 ftrace_dump_on_oops=1,foo=2

As well as

 ftrace_dump_on_oops=foo


If you want to dump with an instance, yes you need a '=' sign.

> Also, is there any reason to limit the parameter
> to 2 or orig_cpu?

There's 3 options: 0 = off, 1 = all (default), 2 = orig_cpu

I don't see it limited.

You don't need the equal sign if you just want the top buffer.

> 
> What about this syntax?
> 
> ftrace_dump_on_oops=<0|1|2|orig_cpu>[,<instance_name>[=<1|2|orig_cpu>][,...]

That should work now. But why add the requirement of an '=' as that isn't
needed now? That is, the syntax is:

 ftrace_dump_on_oops[=[<0|1|2|orig_cpu>,][<instance_name>[=<1|2|orig_cpu>][,...]]

> 
> or
> 
> ftrace_dump_on_oops=instance_name[=<1|2|orig_cpu>][,...]

This works.

> 
> or
> 
> ftrace_dump_on_oops

This works.

> 
> e.g.
> "ftrace_dump_on_oops=0,foo=orig_cpu" is equal to "ftrace_dump_on_oops=foo=orig_cpu"
> 

And that does.

I think this patch does what you are asking for.

-- Steve


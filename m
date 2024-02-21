Return-Path: <linux-fsdevel+bounces-12271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D79285E01C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 15:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD2BB281CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FFC8063D;
	Wed, 21 Feb 2024 14:41:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495138004F;
	Wed, 21 Feb 2024 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526468; cv=none; b=CU39PU0nvOuIx164Jg5J91RmO7lpit2T1PDWYhGBSsByhNiQmpQmbf7k1r3n48hZz4iPJJiT1CED+2D3ET9dKTXG7iLj2vzJASaTBIPdwlGu4720AVV0nlMMokRE4512o8OizMKwDCrRNUClw48luynyYjrNd0ar9Nc5PYw69Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526468; c=relaxed/simple;
	bh=fOisjaUB4CADFBOpLJPvCbrHieV64D68kPH4bfQotJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuDBC3tKqxl+/zzoLLNZGg8SxY/qi/kquSkWDLI/YYpUJbmWV7p/S6nvfDu9N5ti3CRn2TLx9PWor7zpQz9vCaikBTTvAvU4cQOhP/83Fz4lYCSZneBHVAXUr8piZ5ZvayDGuHtLpRYz6iMtuk8fUKMWkQNWTjSGAB7ERbC6iNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADC5C43142;
	Wed, 21 Feb 2024 14:41:05 +0000 (UTC)
Date: Wed, 21 Feb 2024 09:42:53 -0500
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
Message-ID: <20240221094253.4a8b2a62@gandalf.local.home>
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
> 
> Also, the sysctl node can handle the input accordingly.
> 
> Cc: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

What's the reason for Joel's Signed-off-by? Was he a co-author. If so, then
it should be stated in the change log.

-- Steve


> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>


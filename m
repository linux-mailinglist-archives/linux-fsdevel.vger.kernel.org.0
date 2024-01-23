Return-Path: <linux-fsdevel+bounces-8601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027C83937B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013221F23926
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6683D66B20;
	Tue, 23 Jan 2024 15:37:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7F60DCB;
	Tue, 23 Jan 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024260; cv=none; b=uDls7Pv0zWVb4SYRXBuB0hn0zbOr7rz68yqm467cRu0QkzWYzutXzhw/sBXqiLP0hh84kb5fRU3SpUGMvyzwYBGV5d9WutGjafycWrFX9bsosJ5SvwKb3+WCrQBtje8z7kfBAX9sSfoBNd6n4yolvnqtu5A0VnpdetjYN7uooX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024260; c=relaxed/simple;
	bh=MLAhwwGHU/3Yecw28oC/pA0NXAJpTVerqjiXcGUDpXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTVwZ1LX1vf6py0WfqR4AM7LIVWdnKisfv3Wyl+yXpQduFh4flfhJnYWeHMRm8GWjaF009N1hpzhDEtmOgvrS3VEG68hutZiGoVIea+a+tJpACglAFlO6MWkuNb0XKBlSQ+L6ir5FFt5e/DZl6FwSyNiJzEsrOk9dUN+Yh0VZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2365EC43394;
	Tue, 23 Jan 2024 15:37:37 +0000 (UTC)
Date: Tue, 23 Jan 2024 10:39:07 -0500
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
Message-ID: <20240123103907.636c1840@gandalf.local.home>
In-Reply-To: <20240123094900.6f96572c@gandalf.local.home>
References: <20240119080824.907101-1-quic_hyiwei@quicinc.com>
	<20240119115625.603188d1@gandalf.local.home>
	<0279a4cb-ced0-447a-a06f-37c38650ed5b@quicinc.com>
	<20240123094900.6f96572c@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 09:49:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 23 Jan 2024 18:23:58 +0800
> Huang Yiwei <quic_hyiwei@quicinc.com> wrote:
> 
> > > And if we really want to be fancy!
> > > 
> > > 	ftrace_dump_on_opps[=orig_cpu | =<instance> | =orig_cpu:<instance> ][,<instance> | ,<instance>:orig_cpu]
> > >     
> > Yeah, I agree to make the parameter more flexible.
> > 
> > "=orig_cpu:<instance>" means to dump global and another instance?  
> 
> No, I added a comma for that:
> 
>   =,orig_cpu:<instance>
> 
> Would mean to dump all of global and just the origin CPU of the instance.
> 
> > 
> > I'm thinking of the following format:
> > 
> > ftrace_dump_on_opps[=orig_cpu | =<instance>][,<instance> | 
> > ,<instance>=orig_cpu]
> > 
> > Here list some possible situations:
> > 
> > 1. Dump global on orig_cpu:
> > ftrace_dump_on_oops=orig_cpu
> > 
> > 2. Dump global and instance1 on all cpu, instance2 on orig_cpu:
> > ftrace_dump_on_opps,<instance1>,<instance2>=orig_cpu
> > 
> > 3. Dump global and instance1 on orig_cpu, instance2 on all cpu:
> > ftrace_dump_on_opps=orig_cpu,<instance1>=orig_cpu,<instance2>
> > 
> > 4. Dump instance1 on all cpu, instance2 on orig_cpu:
> > ftrace_dump_on_opps=<instance1>,<instance2>=orig_cpu
> > 
> > 5. Dump instance1 and instance2 on orig_cpu:
> > ftrace_dump_on_opps=<instance1>=orig_cpu,<instance2>=orig_cpu
> > 
> > This makes orig_cpu dump for global same as instance, the parameter may 
> > seems more unified and users don't need to remember another markers to 
> > request orig_cpu dump.
> > 
> > But one problem here is if there's an instance named "orig_cpu", then we 
> > may not dump it correctly.  
> 
> I would put that under:
> 
>    Patient: Doctor it hurts me when I do this
>    Doctor:  Then don't do that
> 
> ;-)

Oh, and I'm fine with what you proposed above.

-- Steve



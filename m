Return-Path: <linux-fsdevel+bounces-8584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82038391B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6030A28F4D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9E05FB9F;
	Tue, 23 Jan 2024 14:47:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA560259;
	Tue, 23 Jan 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706021252; cv=none; b=YYkJMDdmmYOOtDxsqfWi6nlD3+Os6pT6dQlz5X0XfHjTAaS/mXo95nRSwKuZR1O6FpNZb/eWSPAthdvekIDo2cqVF5PmjaIYBGDYi/e8Y0Symb38/WcUvf+IQJspXA3OE0Cv5zhKzWF9iaYNpBmKtsAwbqiG8d074T2NVt1YHSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706021252; c=relaxed/simple;
	bh=SyOCDDjWY9xeLbCSe4FxdSgAc8OEaImCI2tOJVIHOBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0f5nNTGW581C7Ec1IKRG5x98xXh77N+hcOJnF6w2WIoHA2xhkFrB2lQWtqMVSeHGb05eEiC9q/lzffQ8u5C6dMQzS3WcH7CjhviZM0YDi9LA9+V12qkNnt7YXZ/HhnR+McwF0oL5nzySque8z24pl5OcVNggu65YDS5OjC67d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B149C3277A;
	Tue, 23 Jan 2024 14:47:29 +0000 (UTC)
Date: Tue, 23 Jan 2024 09:49:00 -0500
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
Message-ID: <20240123094900.6f96572c@gandalf.local.home>
In-Reply-To: <0279a4cb-ced0-447a-a06f-37c38650ed5b@quicinc.com>
References: <20240119080824.907101-1-quic_hyiwei@quicinc.com>
	<20240119115625.603188d1@gandalf.local.home>
	<0279a4cb-ced0-447a-a06f-37c38650ed5b@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 18:23:58 +0800
Huang Yiwei <quic_hyiwei@quicinc.com> wrote:

> > And if we really want to be fancy!
> > 
> > 	ftrace_dump_on_opps[=orig_cpu | =<instance> | =orig_cpu:<instance> ][,<instance> | ,<instance>:orig_cpu]
> >   
> Yeah, I agree to make the parameter more flexible.
> 
> "=orig_cpu:<instance>" means to dump global and another instance?

No, I added a comma for that:

  =,orig_cpu:<instance>

Would mean to dump all of global and just the origin CPU of the instance.

> 
> I'm thinking of the following format:
> 
> ftrace_dump_on_opps[=orig_cpu | =<instance>][,<instance> | 
> ,<instance>=orig_cpu]
> 
> Here list some possible situations:
> 
> 1. Dump global on orig_cpu:
> ftrace_dump_on_oops=orig_cpu
> 
> 2. Dump global and instance1 on all cpu, instance2 on orig_cpu:
> ftrace_dump_on_opps,<instance1>,<instance2>=orig_cpu
> 
> 3. Dump global and instance1 on orig_cpu, instance2 on all cpu:
> ftrace_dump_on_opps=orig_cpu,<instance1>=orig_cpu,<instance2>
> 
> 4. Dump instance1 on all cpu, instance2 on orig_cpu:
> ftrace_dump_on_opps=<instance1>,<instance2>=orig_cpu
> 
> 5. Dump instance1 and instance2 on orig_cpu:
> ftrace_dump_on_opps=<instance1>=orig_cpu,<instance2>=orig_cpu
> 
> This makes orig_cpu dump for global same as instance, the parameter may 
> seems more unified and users don't need to remember another markers to 
> request orig_cpu dump.
> 
> But one problem here is if there's an instance named "orig_cpu", then we 
> may not dump it correctly.

I would put that under:

   Patient: Doctor it hurts me when I do this
   Doctor:  Then don't do that

;-)

-- Steve



Return-Path: <linux-fsdevel+bounces-20862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 647788D8C31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 23:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E36B5B24D02
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251E13BAFE;
	Mon,  3 Jun 2024 21:19:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DDF824B9;
	Mon,  3 Jun 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449540; cv=none; b=b65ZmroNdr4hmzfEmEfumgiy+9uYV6EszTZv/0u1uMrOJnzp0EaUh6mvcwOx/gm/YcVNOLm0D6SfBo38xlWijGLI1FLpAE0278v8Aiqqk48UHAh5UQUCxt3nbrAsrYR+pg/z4vB1TRjBNYZb9WS1bSeUcmQLaAYNwlCLDnLVNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449540; c=relaxed/simple;
	bh=ScoySN/oj4utKm4Ctnzn/XmRIoTSg+GkDzPM2hb7tOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4Ip5xhOSmWpgABqt/cPBx9fdX3yYetOLa6q6mIgn8eOUdbXCqRZhtykMb79g2m3eKAswrxI4Uw6SeptRR/yk3i8v4tZGYQjJILxVMNa5sLg8zz2Ck9Ouw7yWDN3gVXfjxRCGJtXpy5VWXM8+4+CVMLCTFI6OBsmjxC7PDP+Fyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACC8C2BD10;
	Mon,  3 Jun 2024 21:18:58 +0000 (UTC)
Date: Mon, 3 Jun 2024 17:20:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 audit@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
Message-ID: <20240603172008.19ba98ff@gandalf.local.home>
In-Reply-To: <20240602023754.25443-3-laoar.shao@gmail.com>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
	<20240602023754.25443-3-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Jun 2024 10:37:50 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> Using __get_task_comm() to read the task comm ensures that the name is
> always NUL-terminated, regardless of the source string. This approach also
> facilitates future extensions to the task comm.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  include/linux/tracepoint.h     |  4 ++--
>  include/trace/events/block.h   | 10 +++++-----
>  include/trace/events/oom.h     |  2 +-
>  include/trace/events/osnoise.h |  2 +-
>  include/trace/events/sched.h   | 27 ++++++++++++++-------------
>  include/trace/events/signal.h  |  2 +-
>  include/trace/events/task.h    |  4 ++--
>  7 files changed, 26 insertions(+), 25 deletions(-)
> 
[..]

> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 68973f650c26..2a9d7c62c58a 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -9,6 +9,7 @@
>  #include <linux/sched/numa_balancing.h>
>  #include <linux/tracepoint.h>
>  #include <linux/binfmts.h>
> +#include <linux/sched.h>
>  
>  /*
>   * Tracepoint for calling kthread_stop, performed to end a kthread:
> @@ -25,7 +26,7 @@ TRACE_EVENT(sched_kthread_stop,
>  	),
>  
>  	TP_fast_assign(
> -		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
> +		__get_task_comm(__entry->comm, TASK_COMM_LEN, t);
>  		__entry->pid	= t->pid;
>  	),
>  
> @@ -152,7 +153,7 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
>  	),
>  
>  	TP_fast_assign(
> -		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
> +		__get_task_comm(__entry->comm, TASK_COMM_LEN, p);
>  		__entry->pid		= p->pid;
>  		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
>  		__entry->target_cpu	= task_cpu(p);


> @@ -239,11 +240,11 @@ TRACE_EVENT(sched_switch,
>  	),
>  
>  	TP_fast_assign(
> -		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> +		__get_task_comm(__entry->next_comm, TASK_COMM_LEN, next);
>  		__entry->prev_pid	= prev->pid;
>  		__entry->prev_prio	= prev->prio;
>  		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
> -		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
> +		__get_task_comm(__entry->prev_comm, TASK_COMM_LEN, prev);
>  		__entry->next_pid	= next->pid;
>  		__entry->next_prio	= next->prio;
>  		/* XXX SCHED_DEADLINE */

sched_switch is special so we could probably hold off, but the rest should
be converted to the normal way strings are processed in trace events. That
is, to use __string(), __assign_str() and __get_str() for task->comm. I've
been wanting to do that for a while, but thought that memcpy() was a bit
faster than the need for strlen(). But this now needs to test the length of
comm. This method will also allow comms to be recorded that are larger than
16 bytes (if we extend comm).

TRACE_EVENT(sched_migrate_task,

	TP_PROTO(struct task_struct *p, int dest_cpu),

	TP_ARGS(p, dest_cpu),

	TP_STRUCT__entry(
-		__array(	char,	comm,	TASK_COMM_LEN	)
+		__string(	comm,	strlen(comm)		)
		__field(	pid_t,	pid			)
		__field(	int,	prio			)
		__field(	int,	orig_cpu		)
		__field(	int,	dest_cpu		)
	),

	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__assign_str(comm);
		__entry->pid		= p->pid;
		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
		__entry->orig_cpu	= task_cpu(p);
		__entry->dest_cpu	= dest_cpu;
	),

	TP_printk("comm=%s pid=%d prio=%d orig_cpu=%d dest_cpu=%d",
-		  __entry->comm, __entry->pid, __entry->prio,
+		  __get_str(comm), __entry->pid, __entry->prio,
		  __entry->orig_cpu, __entry->dest_cpu)
);

-- Steve


> @@ -286,7 +287,7 @@ TRACE_EVENT(sched_migrate_task,
>  	),
>  
>  	TP_fast_assign(
> -		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
> +		__get_task_comm(__entry->comm, TASK_COMM_LEN, p);
>  		__entry->pid		= p->pid;
>  		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
>  		__entry->orig_cpu	= task_cpu(p);


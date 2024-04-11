Return-Path: <linux-fsdevel+bounces-16710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF888A1CDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71275B295A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055245A4C7;
	Thu, 11 Apr 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UShYJHoo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C55A0EB;
	Thu, 11 Apr 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850987; cv=none; b=k1rfQc3OVR7QcPt2TN/FdoSyq/ToxdDT7i36a88VIYYYaRI8mKr/LlCvUsbtUzymIB9BPklOt2fxB0qDKdjdIe7t1j2eP1WkenICVEwxnxH7Zk+u513+xZ4OK5mSkFzsrQirzP33F777nbxRKiThlbcHF4RUZj/VMDSS9ZrzlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850987; c=relaxed/simple;
	bh=bbnRRo7spo5+ab0ewdvfbug8lWhA1ZDBE8cVFJKpfRk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=axug2Q9AAQwW8aKErfGUuo+IxefE7wYuT+yqs5rDSzD3ai31i5+j46C9QM4aQUQy3PiTqFJyERQtAgP+tULmQsUNr72vT6lt+TjRoMsLWi2fa8JbnOeq3mcFcIom36FFwMqfHI5khnQaJrC5c5w93T5JW3ku1Gfpc7n/46x8bYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UShYJHoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3EEC113CD;
	Thu, 11 Apr 2024 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850987;
	bh=bbnRRo7spo5+ab0ewdvfbug8lWhA1ZDBE8cVFJKpfRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UShYJHook8wRAmez4mDPl6cjJjQJ5JqjbzROxMgvciHBQcjxSderHpXdIEpc9FlV7
	 h0HoHxiABAxMVu6eEHykY992zhZQoVVD0D0zJ1X2HlKqU/dzwwarW+o9cwe6rQ4bLJ
	 tB3aHCjGRCvZ5SA99SDcxdVGlgSKCQT1vIeqJIW4kMZNFeV5tprEwiPXbs4JuOum3e
	 5JnkCegGndS975r/vZauTGHhaTjep/kdOsl+/KcOBYlxPEMwuPiKMKW8JiYrCirmXB
	 w/ZPkmn+ySBDQh3C5tA+Ykf7vHb27F0vYuyvqTd9QBDDhEbpnH927Qd3xdyAajmAlW
	 gOUaD7+STQaRg==
Date: Fri, 12 Apr 2024 00:56:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Azeem Shaikh
 <azeemshaikh38@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] tracing: Add sched_prepare_exec tracepoint
Message-Id: <20240412005621.205fd8cf208d98f2e9511ce1@kernel.org>
In-Reply-To: <20240411102158.1272267-1-elver@google.com>
References: <20240411102158.1272267-1-elver@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 12:20:57 +0200
Marco Elver <elver@google.com> wrote:

> Add "sched_prepare_exec" tracepoint, which is run right after the point
> of no return but before the current task assumes its new exec identity.
> 
> Unlike the tracepoint "sched_process_exec", the "sched_prepare_exec"
> tracepoint runs before flushing the old exec, i.e. while the task still
> has the original state (such as original MM), but when the new exec
> either succeeds or crashes (but never returns to the original exec).
> 
> Being able to trace this event can be helpful in a number of use cases:
> 
>   * allowing tracing eBPF programs access to the original MM on exec,
>     before current->mm is replaced;
>   * counting exec in the original task (via perf event);
>   * profiling flush time ("sched_prepare_exec" to "sched_process_exec").
> 
> Example of tracing output:
> 
>  $ cat /sys/kernel/debug/tracing/trace_pipe
>     <...>-379  [003] .....  179.626921: sched_prepare_exec: interp=/usr/bin/sshd filename=/usr/bin/sshd pid=379 comm=sshd
>     <...>-381  [002] .....  180.048580: sched_prepare_exec: interp=/bin/bash filename=/bin/bash pid=381 comm=sshd
>     <...>-385  [001] .....  180.068277: sched_prepare_exec: interp=/usr/bin/tty filename=/usr/bin/tty pid=385 comm=bash
>     <...>-389  [006] .....  192.020147: sched_prepare_exec: interp=/usr/bin/dmesg filename=/usr/bin/dmesg pid=389 comm=bash
> 
> Signed-off-by: Marco Elver <elver@google.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> v2:
> * Add more documentation.
> * Also show bprm->interp in trace.
> * Rename to sched_prepare_exec.
> ---
>  fs/exec.c                    |  8 ++++++++
>  include/trace/events/sched.h | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 38bf71cbdf5e..57fee729dd92 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1268,6 +1268,14 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		return retval;
>  
> +	/*
> +	 * This tracepoint marks the point before flushing the old exec where
> +	 * the current task is still unchanged, but errors are fatal (point of
> +	 * no return). The later "sched_process_exec" tracepoint is called after
> +	 * the current task has successfully switched to the new exec.
> +	 */
> +	trace_sched_prepare_exec(current, bprm);
> +
>  	/*
>  	 * Ensure all future errors are fatal.
>  	 */
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index dbb01b4b7451..226f47c6939c 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -420,6 +420,41 @@ TRACE_EVENT(sched_process_exec,
>  		  __entry->pid, __entry->old_pid)
>  );
>  
> +/**
> + * sched_prepare_exec - called before setting up new exec
> + * @task:	pointer to the current task
> + * @bprm:	pointer to linux_binprm used for new exec
> + *
> + * Called before flushing the old exec, where @task is still unchanged, but at
> + * the point of no return during switching to the new exec. At the point it is
> + * called the exec will either succeed, or on failure terminate the task. Also
> + * see the "sched_process_exec" tracepoint, which is called right after @task
> + * has successfully switched to the new exec.
> + */
> +TRACE_EVENT(sched_prepare_exec,
> +
> +	TP_PROTO(struct task_struct *task, struct linux_binprm *bprm),
> +
> +	TP_ARGS(task, bprm),
> +
> +	TP_STRUCT__entry(
> +		__string(	interp,		bprm->interp	)
> +		__string(	filename,	bprm->filename	)
> +		__field(	pid_t,		pid		)
> +		__string(	comm,		task->comm	)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(interp, bprm->interp);
> +		__assign_str(filename, bprm->filename);
> +		__entry->pid = task->pid;
> +		__assign_str(comm, task->comm);
> +	),
> +
> +	TP_printk("interp=%s filename=%s pid=%d comm=%s",
> +		  __get_str(interp), __get_str(filename),
> +		  __entry->pid, __get_str(comm))
> +);
>  
>  #ifdef CONFIG_SCHEDSTATS
>  #define DEFINE_EVENT_SCHEDSTAT DEFINE_EVENT
> -- 
> 2.44.0.478.gd926399ef9-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


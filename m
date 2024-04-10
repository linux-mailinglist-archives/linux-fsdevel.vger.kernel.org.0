Return-Path: <linux-fsdevel+bounces-16571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF90789F912
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B851C28366
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F20615FA71;
	Wed, 10 Apr 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNj8Q1fe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3764158D76;
	Wed, 10 Apr 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757414; cv=none; b=HoAyq455jsD0tJsWXXtIheKceCFObxh6gQVeMhb0soQH+I5OvxfShZMmHg/KcDeosuLmnkj3rFsNwc2H2LvYjlIaZxFpFxcETYz539GFcTwGHcYu6AqeJVIXOXacKlumTBCwNdLyDj/9vknsMwvkZXpxGV5dVkw28x1bxKd1IOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757414; c=relaxed/simple;
	bh=lhXxlgOSdVu5J2H9D+fqrRFhQyc0zvYsi/r8+KBO404=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M9Sa1HsuQ0KeFDKcsgZnzx3r6Y+IL8p7Brhol3EMnznkZWcJATc4DscwUdyKRH0DMhYI4bjHKAjhxieqi/koK+E0m+M9PBhMgy9Kiai5geoS9WxyKe6oVNGXkl3JSaHFh910sOWBcIJs7G/vD+HEmoLyOoDMmpSdWAeNtWxM8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNj8Q1fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAFCC433F1;
	Wed, 10 Apr 2024 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712757414;
	bh=lhXxlgOSdVu5J2H9D+fqrRFhQyc0zvYsi/r8+KBO404=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eNj8Q1feNt/ZrcbKAt3E0RlvlQqaaAhjlBqqhBHsKqcvtX/mgO8NfSZ1mDFgDS12N
	 F0dFBSZkCLbZT9xKaO/Vgh86z/bnZspm3mlRs+RuoUUvVX00FT4KGxJSnErE9uwoyi
	 I0eIpRFvGHxnDJ8T4F2PYIgk97HMrp+Ym7+kLZLndFSaKt1ZUdElWLLaJ9/3RSjhYE
	 gkRqoYoITucNFR6egzQyMTP/1JuvQZ631XYuk/OVN6hjja6UBaAmkobTZ8YgS44J0B
	 e/AYhdcbcczpPEcAG+iptJCUShzY0lBzKpjwZ/+Q6sUf/pHKqzRbneMVG2bSOFWBaw
	 4dvnSb22JSJrQ==
Date: Wed, 10 Apr 2024 22:56:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
Message-Id: <20240410225648.7a815ba873c8d55c44385c24@kernel.org>
In-Reply-To: <20240408090205.3714934-1-elver@google.com>
References: <20240408090205.3714934-1-elver@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 11:01:54 +0200
Marco Elver <elver@google.com> wrote:

> Add "new_exec" tracepoint, which is run right after the point of no
> return but before the current task assumes its new exec identity.
> 
> Unlike the tracepoint "sched_process_exec", the "new_exec" tracepoint
> runs before flushing the old exec, i.e. while the task still has the
> original state (such as original MM), but when the new exec either
> succeeds or crashes (but never returns to the original exec).
> 
> Being able to trace this event can be helpful in a number of use cases:
> 
>   * allowing tracing eBPF programs access to the original MM on exec,
>     before current->mm is replaced;
>   * counting exec in the original task (via perf event);
>   * profiling flush time ("new_exec" to "sched_process_exec").
> 
> Example of tracing output ("new_exec" and "sched_process_exec"):

nit: "new_exec" name a bit stands out compared to other events, and hard to
expect it comes before or after "sched_process_exec". Since "begin_new_exec"
is internal implementation name, IMHO, it should not exposed to user.
What do you think about calling this "sched_prepare_exec" ?

Thank you,

> 
>   $ cat /sys/kernel/debug/tracing/trace_pipe
>       <...>-379     [003] .....   179.626921: new_exec: filename=/usr/bin/sshd pid=379 comm=sshd
>       <...>-379     [003] .....   179.629131: sched_process_exec: filename=/usr/bin/sshd pid=379 old_pid=379
>       <...>-381     [002] .....   180.048580: new_exec: filename=/bin/bash pid=381 comm=sshd
>       <...>-381     [002] .....   180.053122: sched_process_exec: filename=/bin/bash pid=381 old_pid=381
>       <...>-385     [001] .....   180.068277: new_exec: filename=/usr/bin/tty pid=385 comm=bash
>       <...>-385     [001] .....   180.069485: sched_process_exec: filename=/usr/bin/tty pid=385 old_pid=385
>       <...>-389     [006] .....   192.020147: new_exec: filename=/usr/bin/dmesg pid=389 comm=bash
>        bash-389     [006] .....   192.021377: sched_process_exec: filename=/usr/bin/dmesg pid=389 old_pid=389
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  fs/exec.c                   |  2 ++
>  include/trace/events/task.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 38bf71cbdf5e..ab778ae1fc06 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1268,6 +1268,8 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		return retval;
>  
> +	trace_new_exec(current, bprm);
> +
>  	/*
>  	 * Ensure all future errors are fatal.
>  	 */
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 47b527464d1a..8853dc44783d 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -56,6 +56,36 @@ TRACE_EVENT(task_rename,
>  		__entry->newcomm, __entry->oom_score_adj)
>  );
>  
> +/**
> + * new_exec - called before setting up new exec
> + * @task:	pointer to the current task
> + * @bprm:	pointer to linux_binprm used for new exec
> + *
> + * Called before flushing the old exec, but at the point of no return during
> + * switching to the new exec.
> + */
> +TRACE_EVENT(new_exec,
> +
> +	TP_PROTO(struct task_struct *task, struct linux_binprm *bprm),
> +
> +	TP_ARGS(task, bprm),
> +
> +	TP_STRUCT__entry(
> +		__string(	filename,	bprm->filename	)
> +		__field(	pid_t,		pid		)
> +		__string(	comm,		task->comm	)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(filename, bprm->filename);
> +		__entry->pid = task->pid;
> +		__assign_str(comm, task->comm);
> +	),
> +
> +	TP_printk("filename=%s pid=%d comm=%s",
> +		  __get_str(filename), __entry->pid, __get_str(comm))
> +);
> +
>  #endif
>  
>  /* This part must be outside protection */
> -- 
> 2.44.0.478.gd926399ef9-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


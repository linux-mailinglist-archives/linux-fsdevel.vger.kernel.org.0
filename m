Return-Path: <linux-fsdevel+bounces-33469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97F9B91ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438E5283BD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E224619F485;
	Fri,  1 Nov 2024 13:22:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FE19D8A9;
	Fri,  1 Nov 2024 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467366; cv=none; b=MNol6QT1gklOHkFsXHLOUTQwg723s5XdjBJ1KyAAPxZbI5MBB7kUsDkICc61tAXfYJTFX/Wr4t7h/2kd3PGwOQid5c3ViACOH7sFheuXqHVUQP671L8yRDDgpSSmN7pfBEaM+amk5rps1xxYWN9OBElgGxNzvTDXOZai43FKMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467366; c=relaxed/simple;
	bh=/SWaip6hxY92SF7BfMD4lYgeQArC8OMAbqGlc2LQc1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKlStwNzesmR9d4Z44aJBci3JXJOCXdg8SjGq9S5pPnyxXWqA4JsjQlpfujodrqWt+0zMh3qfsUMUEAgUc0voqVm+AhHkXSHw6edJ3PMe9ZyArhGEcMCc4rExq0eTqvtrMOK3yu7Nfw2zkssiBs+lhfatoDWCQsrHnWiiF/CK70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DAFC4CECD;
	Fri,  1 Nov 2024 13:22:44 +0000 (UTC)
Date: Fri, 1 Nov 2024 09:23:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: <mcgrof@kernel.org>, <kees@kernel.org>, <joel.granados@kernel.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: add pid_max to pid_namespace
Message-ID: <20241101092342.30f15908@gandalf.local.home>
In-Reply-To: <20241030052933.1041408-1-yun.zhou@windriver.com>
References: <20241030052933.1041408-1-yun.zhou@windriver.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 13:29:33 +0800
Yun Zhou <yun.zhou@windriver.com> wrote:

> diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
> index 4966e6bbdf6f..c62b9b3cfb3d 100644
> --- a/kernel/trace/pid_list.c
> +++ b/kernel/trace/pid_list.c
> @@ -414,7 +414,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
>  	int i;
>  
>  	/* According to linux/thread.h, pids can be no bigger that 30 bits */
> -	WARN_ON_ONCE(pid_max > (1 << 30));
> +	WARN_ON_ONCE(init_pid_ns.pid_max > (1 << 30));
>  
>  	pid_list = kzalloc(sizeof(*pid_list), GFP_KERNEL);
>  	if (!pid_list)
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index c866991b9c78..e51851d64e4d 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -715,8 +715,6 @@ extern unsigned long tracing_thresh;
>  
>  /* PID filtering */
>  
> -extern int pid_max;
> -
>  bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
>  			     pid_t search_pid);
>  bool trace_ignore_this_task(struct trace_pid_list *filtered_pids,
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> index 8a407adb0e1c..c20c80abe065 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -442,7 +442,7 @@ int trace_alloc_tgid_map(void)
>  	if (tgid_map)
>  		return 0;
>  
> -	tgid_map_max = pid_max;
> +	tgid_map_max = init_pid_ns.pid_max;
>  	map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
>  		       GFP_KERNEL);
>  	if (!map)


Acked-by: Steven Rostedt (Google) <rostedt@goodmis>org>

-- Steve


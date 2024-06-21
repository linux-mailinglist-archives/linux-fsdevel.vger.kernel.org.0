Return-Path: <linux-fsdevel+bounces-22065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8EB911993
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 06:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74EA2858A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96012D1FF;
	Fri, 21 Jun 2024 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k505hdpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E53EBE;
	Fri, 21 Jun 2024 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944669; cv=none; b=DiAZlAqCkAaEYAEjamGyEGuqKFCwAdYCza6cq3aMtCj2tJt0x90PMO7Tebispe/xGwJAL+26451oxhOqqVGFeJ1c3o4w44erGVc25Rx3ru2UCDc7ro44bCOpliNHiDSVz++7cCekqEXfi1n0/z2k0RIKfdL/uy44KST8Gr2sMTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944669; c=relaxed/simple;
	bh=dtuG/8FVyfxt6cdJEnSMBi5db48doHCJHLe3KcIUws4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MzAyKaSYGUf0IAof7bHeLrbbhNGJmwW285PHeh7PdJD6MZtdxViy7uMA8le8edjt2iaO9x9xsGG/puKUVeuqJpmPfzHDp2F3KoAEml5ETSmGm2nKWetHiGL/bRNswcLsn+3+sPbRj0M/ZTm09A1pt9j8pOicFkQ0CJwcDgQIKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k505hdpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216A4C2BBFC;
	Fri, 21 Jun 2024 04:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718944668;
	bh=dtuG/8FVyfxt6cdJEnSMBi5db48doHCJHLe3KcIUws4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k505hdpzwMMojH9wRfDeKs5BlNmsCDhP4RZMfHss9GZvJxLyRPPFXiUgVFptQKDL5
	 S5gsaSJiKe4LG3AqF7BLkgArN2fQ6qmD9TPovctggZUcd3SKbL9/4LgiQ6RebmHXx8
	 Sa6lkZ4xCYaOuzo7Zws7B8aGMz8VF6yVl5HZS3oaFEGqgpml4yS2vYF6N/jfvJPDIj
	 4wIEtSyU5vQLJwGLXsMqM/tqNHAvajbwv14JxtQRT0slq+fIxjIz53UIWoTOFHUheC
	 qn8EFjVtrHKjnNWfmNSVO6/Cns8JaNBbD/GTXf78g5DeCI791W20rOIkGVStMEvPqS
	 TWkLY4TaxbGVQ==
Date: Fri, 21 Jun 2024 13:37:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com,
 alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com,
 akpm@linux-foundation.org, penguin-kernel@i-love.sakura.ne.jp,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 09/11] tracing: Replace strncpy() with
 __get_task_comm()
Message-Id: <20240621133742.6692d3bda4faafab878f197d@kernel.org>
In-Reply-To: <20240621022959.9124-10-laoar.shao@gmail.com>
References: <20240621022959.9124-1-laoar.shao@gmail.com>
	<20240621022959.9124-10-laoar.shao@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 10:29:57 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> Using __get_task_comm() to read the task comm ensures that the name is
> always NUL-terminated, regardless of the source string. This approach also
> facilitates future extensions to the task comm.

Good catch! Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/trace/trace.c             | 2 +-
>  kernel/trace/trace_events_hist.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 578a49ff5c32..ce94a86154a2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1907,7 +1907,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  	max_data->critical_start = data->critical_start;
>  	max_data->critical_end = data->critical_end;
>  
> -	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
> +	__get_task_comm(max_data->comm, TASK_COMM_LEN, tsk);
>  	max_data->pid = tsk->pid;
>  	/*
>  	 * If tsk == current, then use current_uid(), as that does not use
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 6ece1308d36a..721d4758a79f 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
>  		return;
>  	}
>  
> -	strncpy(comm, task->comm, TASK_COMM_LEN);
> +	__get_task_comm(comm, TASK_COMM_LEN, task);
>  }
>  
>  static void hist_elt_data_free(struct hist_elt_data *elt_data)
> -- 
> 2.39.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


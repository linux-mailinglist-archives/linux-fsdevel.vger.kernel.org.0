Return-Path: <linux-fsdevel+bounces-40033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 349A3A1B2E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 10:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC8C1887CAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98421A450;
	Fri, 24 Jan 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5sDAFyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF718D63C;
	Fri, 24 Jan 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711956; cv=none; b=Kob+uJbiMA4wCiLTwnkK0/eS1U2aN2NCg/EKSuCDRYAEoLs6j8Xgz68Wvtx0GET5uxBzScQ1XrKPAq8vSIXFGNc8RuchD5ivQ/lWOfmzcC5qoFSPnJ+LUijdoDzLdV/CNX9Lf5vwQzQRENLlLbM563Ls0MC3+SeebczvKi+rjUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711956; c=relaxed/simple;
	bh=eB2zDntAjt8L+m9HIlRkkULjJqOEs9/jE8oisXlLBWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdeqFvNMB8tyrkmE7qPVeWsfqYZNxN7123qnOWgbwQHzzVXeV+olWaErFcrsdPQtcIhoqJQZkbfX0d9SELQFgDHZ/q1h8BVTzG4B39sATAlHIZ5caDk+fK2olSjHKkC3E/VW4kU+xmj1wrDe/sVYEgOOHoQ0McbYmitN4aJbJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5sDAFyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B960C4CED2;
	Fri, 24 Jan 2025 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737711956;
	bh=eB2zDntAjt8L+m9HIlRkkULjJqOEs9/jE8oisXlLBWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5sDAFytysFAd08xigMIdNSQaON3PfDxZ9tc2l98pwn0W46Ey2NIYkhf0+iCBAHls
	 1+on1E+DvhXwG4zDqHZUhtELbONQvdPAIWLAgT4ke458UWqPtrerWhznFTx6LmtEcn
	 ZByXndeHa8U9otquiYrS+xKHlt6wgIs6yLqefkaa5acZpR8OejesrGUtZRjgCL3hGf
	 BVnePg8OtowoCgFrP8cGL7+qi+ugAKLi7RS3UW+xRArwnq1y4xu3En9+PwD/gIOPht
	 3cJh1+WuLGlR+d34M7Gsp5/oDDSJDkJIpwgpuyZKbrOaiDPbArRMfQqNumuRYPLpKM
	 jO3u/iaJNGQwg==
Date: Fri, 24 Jan 2025 10:45:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, shakeel.butt@linux.dev, rppt@kernel.org, liam.howlett@oracle.com, 
	surenb@google.com
Subject: Re: [PATCH] mm,procfs: allow read-only remote mm access under
 CAP_PERFMON
Message-ID: <20250124-zander-restaurant-7583fe1634b9@brauner>
References: <20250123214342.4145818-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123214342.4145818-1-andrii@kernel.org>

On Thu, Jan 23, 2025 at 01:43:42PM -0800, Andrii Nakryiko wrote:
> It's very common for various tracing and profiling toolis to need to
> access /proc/PID/maps contents for stack symbolization needs to learn
> which shared libraries are mapped in memory, at which file offset, etc.
> Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
> are looking at data for our own process, which is a trivial case not too
> relevant for profilers use cases).
> 
> Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> discover memory layout of another process: it allows to fully control
> arbitrary other processes. This is problematic from security POV for
> applications that only need read-only /proc/PID/maps (and other similar
> read-only data) access, and in large production settings CAP_SYS_PTRACE
> is frowned upon even for the system-wide profilers.
> 
> On the other hand, it's already possible to access similar kind of
> information (and more) with just CAP_PERFMON capability. E.g., setting
> up PERF_RECORD_MMAP collection through perf_event_open() would give one
> similar information to what /proc/PID/maps provides.
> 
> CAP_PERFMON, together with CAP_BPF, is already a very common combination
> for system-wide profiling and observability application. As such, it's
> reasonable and convenient to be able to access /proc/PID/maps with
> CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
> 
> For procfs, these permissions are checked through common mm_access()
> helper, and so we augment that with cap_perfmon() check *only* if
> requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't be
> permitted by CAP_PERFMON.
> 
> Besides procfs itself, mm_access() is used by process_madvise() and
> process_vm_{readv,writev}() syscalls. The former one uses
> PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMON
> seems like a meaningful allowable capability as well.
> 
> process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
> permissions (though for readv PTRACE_MODE_READ seems more reasonable,
> but that's outside the scope of this change), and as such won't be
> affected by this patch.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/fork.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ded49f18cd95..c57cb3ad9931 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1547,6 +1547,15 @@ struct mm_struct *get_task_mm(struct task_struct *task)
>  }
>  EXPORT_SYMBOL_GPL(get_task_mm);
>  
> +static bool can_access_mm(struct mm_struct *mm, struct task_struct *task, unsigned int mode)
> +{
> +	if (mm == current->mm)
> +		return true;
> +	if ((mode & PTRACE_MODE_READ) && perfmon_capable())
> +		return true;

Just fyi, I suspect that this will trigger new audit denials if the task
doesn't have CAP_SYS_ADMIN or CAP_PERFORM in the initial user namespace
but where it would still have access through ptrace_may_access(). Such
changes have led to complaints before.

I'm not sure how likely that is but it might be noticable. If that's the
case ns_capable_noaudit(&init_user_ns, ...) would help.

> +	return ptrace_may_access(task, mode);
> +}
> +
>  struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
>  {
>  	struct mm_struct *mm;
> @@ -1559,7 +1568,7 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
>  	mm = get_task_mm(task);
>  	if (!mm) {
>  		mm = ERR_PTR(-ESRCH);
> -	} else if (mm != current->mm && !ptrace_may_access(task, mode)) {
> +	} else if (!can_access_mm(mm, task, mode)) {
>  		mmput(mm);
>  		mm = ERR_PTR(-EACCES);
>  	}
> -- 
> 2.43.5
> 


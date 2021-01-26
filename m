Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5401C304C4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 23:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbhAZWg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395483AbhAZT0e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:26:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3060321919;
        Tue, 26 Jan 2021 19:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611689149;
        bh=7p17PBfMCykVh1TIGmJBWLR2D/SrpQqGJdfo8kfnJCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zqtjfJr5D5BXLs8eV+utNBwa4j1u4xciLLVwIjLMkAsLwmF++rPICPsNvADiiQDn3
         vDvKDd5BLubjILbSPCtXLNr883Tr3+hF3BGUgHHQFvsxu1fPj6bnk60K6PjO415jAQ
         xAi7Mlcp2scZFHh6fhwApXuihk5x4mLwo0jY5HXM=
Date:   Tue, 26 Jan 2021 11:25:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Piotr Figiel <figiel@google.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk,
        peterz@infradead.org, paulmck@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        posk@google.com, kyurtsever@google.com, ckennelly@google.com,
        pjt@google.com
Subject: Re: [PATCH v3] fs/proc: Expose RSEQ configuration
Message-Id: <20210126112547.d3f18b6a2abe864e8bfa7fcd@linux-foundation.org>
In-Reply-To: <20210126185412.175204-1-figiel@google.com>
References: <20210126185412.175204-1-figiel@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Jan 2021 19:54:12 +0100 Piotr Figiel <figiel@google.com> wrote:

> For userspace checkpoint and restore (C/R) some way of getting process
> state containing RSEQ configuration is needed.
> 
> There are two ways this information is going to be used:
>  - to re-enable RSEQ for threads which had it enabled before C/R
>  - to detect if a thread was in a critical section during C/R
> 
> Since C/R preserves TLS memory and addresses RSEQ ABI will be restored
> using the address registered before C/R.
> 
> Detection whether the thread is in a critical section during C/R is
> needed to enforce behavior of RSEQ abort during C/R. Attaching with
> ptrace() before registers are dumped itself doesn't cause RSEQ abort.
> Restoring the instruction pointer within the critical section is
> problematic because rseq_cs may get cleared before the control is
> passed to the migrated application code leading to RSEQ invariants not
> being preserved.
> 
> To achieve above goals expose the RSEQ structure address and the
> signature value with the new per-thread procfs file "rseq".

Using "/proc/<pid>/rseq" would be more informative.

>  fs/exec.c      |  2 ++
>  fs/proc/base.c | 22 ++++++++++++++++++++++
>  kernel/rseq.c  |  4 ++++

A Documentation/ update would be appropriate.

>  3 files changed, 28 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 5d4d52039105..5d84f98847f1 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1830,7 +1830,9 @@ static int bprm_execve(struct linux_binprm *bprm,
>  	/* execve succeeded */
>  	current->fs->in_exec = 0;
>  	current->in_execve = 0;
> +	task_lock(current);
>  	rseq_execve(current);
> +	task_unlock(current);

There's a comment over the task_lock() implementation which explains
what things it locks.  An update to that would be helpful.

> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -662,6 +662,22 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
>  
>  	return 0;
>  }
> +
> +#ifdef CONFIG_RSEQ
> +static int proc_pid_rseq(struct seq_file *m, struct pid_namespace *ns,
> +				struct pid *pid, struct task_struct *task)
> +{
> +	int res = lock_trace(task);
> +
> +	if (res)
> +		return res;
> +	task_lock(task);
> +	seq_printf(m, "%px %08x\n", task->rseq, task->rseq_sig);
> +	task_unlock(task);
> +	unlock_trace(task);
> +	return 0;
> +}

Do we actually need task_lock() for this purpose?  Would
exec_update_lock() alone be adequate and appropriate?



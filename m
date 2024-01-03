Return-Path: <linux-fsdevel+bounces-7221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3CC822F2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F5A1F2435D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0A1A590;
	Wed,  3 Jan 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKTr7qNL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20E1A28A;
	Wed,  3 Jan 2024 14:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CE6C433C7;
	Wed,  3 Jan 2024 14:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704290699;
	bh=RYNKFXB1pA6ACfuaqdpya+quA/X8Ww41O670fD+ZNNg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=rKTr7qNLBKgIMnnNZD5kydCgVoB0ShDhCqxZzuZqnQaHxHN+3n8eAD5Q1loCLVjJR
	 uU1d0eneow4rgu1o41DaW+lS1T3SB/GWC+sAZEwEzhpsz6huPi7L5ffd+A/Osns3xs
	 7guQ8ydipmDJb1pAO2A/VCrWuk4yQep6SMzb5AfD3U77wP7mA/+hlmJnmLhgOvoAC0
	 COBE5pracc5vYmGzZV2GMs3Sos2+unnWsqjHeTlXI//wPfvHXLMVJNxASe2Dt+0fkt
	 aYVcIIjciGqJKBRkXKDfoRcP2UEytgT1ESXUAN6VvIJUMkEXdR8r+HD0owcPqTQJdy
	 NYdIoSbmFVuKw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 16:04:54 +0200
Message-Id: <CY54MOETXVFI.1102C6BQTO36@suppilovahvero>
Cc: <kernel@quicinc.com>, <quic_pkondeti@quicinc.com>,
 <keescook@chromium.or>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
 <oleg@redhat.com>, <dhowells@redhat.com>, <paul@paul-moore.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Maria Yu" <quic_aiquny@quicinc.com>, <ebiederm@xmission.com>
X-Mailer: aerc 0.15.2
References: <20231225081932.17752-1-quic_aiquny@quicinc.com>
In-Reply-To: <20231225081932.17752-1-quic_aiquny@quicinc.com>

On Mon Dec 25, 2023 at 10:19 AM EET, Maria Yu wrote:
> As a rwlock for tasklist_lock, there are multiple scenarios to acquire
> read lock which write lock needed to be waiting for.
> In freeze_process/thaw_processes it can take about 200+ms for holding rea=
d
> lock of tasklist_lock by walking and freezing/thawing tasks in commercial
> devices. And write_lock_irq will have preempt disabled and local irq
> disabled to spin until the tasklist_lock can be acquired. This leading to
> a bad responsive performance of current system.
> Take an example:
> 1. cpu0 is holding read lock of tasklist_lock to thaw_processes.
> 2. cpu1 is waiting write lock of tasklist_lock to exec a new thread with
>    preempt_disabled and local irq disabled.
> 3. cpu2 is waiting write lock of tasklist_lock to do_exit with
>    preempt_disabled and local irq disabled.
> 4. cpu3 is waiting write lock of tasklist_lock to do_exit with
>    preempt_disabled and local irq disabled.
> So introduce a write lock/unlock wrapper for tasklist_lock specificly.
> The current taskslist_lock writers all have write_lock_irq to hold
> tasklist_lock, and write_unlock_irq to release tasklist_lock, that means
> the writers are not suitable or workable to wait on tasklist_lock in irq
> disabled scenarios. So the write lock/unlock wrapper here only follow the
> current design of directly use local_irq_disable and local_irq_enable,
> and not take already irq disabled writer callers into account.
> Use write_trylock in the loop and enabled irq for cpu to repsond if lock
> cannot be taken.
>
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>  fs/exec.c                  | 10 +++++-----
>  include/linux/sched/task.h | 29 +++++++++++++++++++++++++++++
>  kernel/exit.c              | 16 ++++++++--------
>  kernel/fork.c              |  6 +++---
>  kernel/ptrace.c            | 12 ++++++------
>  kernel/sys.c               |  8 ++++----
>  security/keys/keyctl.c     |  4 ++--
>  7 files changed, 57 insertions(+), 28 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 4aa19b24f281..030eef6852eb 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1086,7 +1086,7 @@ static int de_thread(struct task_struct *tsk)
> =20
>  		for (;;) {
>  			cgroup_threadgroup_change_begin(tsk);
> -			write_lock_irq(&tasklist_lock);
> +			write_lock_tasklist_lock();
>  			/*
>  			 * Do this under tasklist_lock to ensure that
>  			 * exit_notify() can't miss ->group_exec_task
> @@ -1095,7 +1095,7 @@ static int de_thread(struct task_struct *tsk)
>  			if (likely(leader->exit_state))
>  				break;
>  			__set_current_state(TASK_KILLABLE);
> -			write_unlock_irq(&tasklist_lock);
> +			write_unlock_tasklist_lock();
>  			cgroup_threadgroup_change_end(tsk);
>  			schedule();
>  			if (__fatal_signal_pending(tsk))
> @@ -1150,7 +1150,7 @@ static int de_thread(struct task_struct *tsk)
>  		 */
>  		if (unlikely(leader->ptrace))
>  			__wake_up_parent(leader, leader->parent);
> -		write_unlock_irq(&tasklist_lock);
> +		write_unlock_tasklist_lock();
>  		cgroup_threadgroup_change_end(tsk);
> =20
>  		release_task(leader);
> @@ -1198,13 +1198,13 @@ static int unshare_sighand(struct task_struct *me=
)
> =20
>  		refcount_set(&newsighand->count, 1);
> =20
> -		write_lock_irq(&tasklist_lock);
> +		write_lock_tasklist_lock();
>  		spin_lock(&oldsighand->siglock);
>  		memcpy(newsighand->action, oldsighand->action,
>  		       sizeof(newsighand->action));
>  		rcu_assign_pointer(me->sighand, newsighand);
>  		spin_unlock(&oldsighand->siglock);
> -		write_unlock_irq(&tasklist_lock);
> +		write_unlock_tasklist_lock();
> =20
>  		__cleanup_sighand(oldsighand);
>  	}
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index a23af225c898..6f69d9a3c868 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -50,6 +50,35 @@ struct kernel_clone_args {
>   * a separate lock).
>   */
>  extern rwlock_t tasklist_lock;
> +
> +/*
> + * Tasklist_lock is a special lock, it takes a good amount of time of
> + * taskslist_lock readers to finish, and the pure write_irq_lock api
> + * will do local_irq_disable at the very first, and put the current cpu
> + * waiting for the lock while is non-responsive for interrupts.
> + *
> + * The current taskslist_lock writers all have write_lock_irq to hold
> + * tasklist_lock, and write_unlock_irq to release tasklist_lock, that
> + * means the writers are not suitable or workable to wait on
> + * tasklist_lock in irq disabled scenarios. So the write lock/unlock
> + * wrapper here only follow the current design of directly use
> + * local_irq_disable and local_irq_enable.
> + */
> +static inline void write_lock_tasklist_lock(void)
> +{
> +	while (1) {
> +		local_irq_disable();
> +		if (write_trylock(&tasklist_lock))
> +			break;
> +		local_irq_enable();
> +		cpu_relax();
> +	}

Maybe:

	local_irq_disable();
	while (!write_trylock(&tasklist_lock)) {
		local_irq_enable();
		cpu_relax();
		local_irq_disable();
	}

BR, Jarkko


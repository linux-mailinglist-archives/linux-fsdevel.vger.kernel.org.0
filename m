Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190F621472D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgGDQAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 12:00:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57226 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgGDQAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 12:00:52 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jrkav-00008Q-2S; Sat, 04 Jul 2020 16:00:49 +0000
Date:   Sat, 4 Jul 2020 18:00:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 13/16] exit: Factor thread_group_exited out of
 pidfd_poll
Message-ID: <20200704160048.l2yvs3w5k4vclpdv@wittgenstein>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
 <20200702164140.4468-13-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200702164140.4468-13-ebiederm@xmission.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 11:41:37AM -0500, Eric W. Biederman wrote:
> Create an independent helper thread_group_exited report return true

s/report return/which reports/

> when all threads have passed exit_notify in do_exit.  AKA all of the
> threads are at least zombies and might be dead or completely gone.
> 
> Create this helper by taking the logic out of pidfd_poll where
> it is already tested, and adding a missing READ_ONCE on
> the read of task->exit_state.

I would prefer to have this comment dropped as this read_once() is not
missing as you can see from the comments elsewhere in this thread.

> 
> I will be changing the user mode driver code to use this same logic
> to know when a user mode driver needs to be restarted.
> 
> Place the new helper thread_group_exited in kernel/exit.c and
> EXPORT it so it can be used by modules.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

Minus the typos above and below, this looks good and passes the pidfd
and process test-suite.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!
Christian

>  include/linux/sched/signal.h |  2 ++
>  kernel/exit.c                | 24 ++++++++++++++++++++++++
>  kernel/fork.c                |  6 +-----
>  3 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 0ee5e696c5d8..1bad18a1d8ba 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -674,6 +674,8 @@ static inline int thread_group_empty(struct task_struct *p)
>  #define delay_group_leader(p) \
>  		(thread_group_leader(p) && !thread_group_empty(p))
>  
> +extern bool thread_group_exited(struct pid *pid);
> +
>  extern struct sighand_struct *__lock_task_sighand(struct task_struct *task,
>  							unsigned long *flags);
>  
> diff --git a/kernel/exit.c b/kernel/exit.c
> index d3294b611df1..a7f112feb0f6 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1713,6 +1713,30 @@ COMPAT_SYSCALL_DEFINE5(waitid,
>  }
>  #endif
>  
> +/**
> + * thread_group_exited - check that a thread group has exited
> + * @pid: tgid of thread group to be checked.
> + *
> + * Test if thread group is has exited (all threads are zombies, dead

s/is has exited/has exited/

> + * or completely gone).
> + *
> + * Return: true if the thread group has exited. false otherwise.
> + */
> +bool thread_group_exited(struct pid *pid)
> +{
> +	struct task_struct *task;
> +	bool exited;
> +
> +	rcu_read_lock();
> +	task = pid_task(pid, PIDTYPE_PID);
> +	exited = !task ||
> +		(READ_ONCE(task->exit_state) && thread_group_empty(task));
> +	rcu_read_unlock();
> +
> +	return exited;
> +}
> +EXPORT_SYMBOL(thread_group_exited);
> +
>  __weak void abort(void)
>  {
>  	BUG();
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 142b23645d82..bf215af7a904 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1787,22 +1787,18 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>   */
>  static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  {
> -	struct task_struct *task;
>  	struct pid *pid = file->private_data;
>  	__poll_t poll_flags = 0;
>  
>  	poll_wait(file, &pid->wait_pidfd, pts);
>  
> -	rcu_read_lock();
> -	task = pid_task(pid, PIDTYPE_PID);
>  	/*
>  	 * Inform pollers only when the whole thread group exits.
>  	 * If the thread group leader exits before all other threads in the
>  	 * group, then poll(2) should block, similar to the wait(2) family.
>  	 */
> -	if (!task || (task->exit_state && thread_group_empty(task)))
> +	if (thread_group_exited(pid))
>  		poll_flags = EPOLLIN | EPOLLRDNORM;
> -	rcu_read_unlock();
>  
>  	return poll_flags;
>  }
> -- 
> 2.25.0
> 

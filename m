Return-Path: <linux-fsdevel+bounces-6902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1461A81DF2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 09:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380521C217B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67981443E;
	Mon, 25 Dec 2023 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YdMzfP2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146B10A18;
	Mon, 25 Dec 2023 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP6qNtO006658;
	Mon, 25 Dec 2023 08:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yxCLrL/yVL15F/US1vFj5o7e5bNuXgY748JTjMCwiFs=; b=Yd
	MzfP2cjO4PLBkW8MzooB6c3jI+VtQsaBDnYE2WPTiZ3scjsT2iDtQqrUPwZ39eR/
	6iTj4r6S6jGLWPCySDNvGDrk1gIPa4EApZL6X2RBLmaiHUywa9xNlJ9K/SRVt56M
	20ekjdzoudWsxbnXZstbyPZhboikN8j1IWQ4LyJIwUW/xbEGWAeeGQOawGyrctWH
	fq05gQxNk+YLr3VIgMmCyJxLEUiyBvLeNt2d2O+bCJLp3zMZA9CBB9x8cN38ZnIq
	X6KRuunDx539z2ix9BnxcxgKWHLp8cMI1VOlx8BlmxRxeN5XGmegh5WvgUnTopM2
	euvlKirizXY1+sPB8ujw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5pjbk9mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:26:21 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BP8QKrD012823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:26:20 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Dec
 2023 00:26:12 -0800
Message-ID: <8c52a652-01c9-46ef-bbc2-ec3c9895dfbc@quicinc.com>
Date: Mon, 25 Dec 2023 16:26:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Content-Language: en-US
To: <ebiederm@xmission.com>
CC: <kernel@quicinc.com>, <quic_pkondeti@quicinc.com>, <keescook@chromium.or>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <oleg@redhat.com>,
        <dhowells@redhat.com>, <jarkko@kernel.org>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20231225081932.17752-1-quic_aiquny@quicinc.com>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <20231225081932.17752-1-quic_aiquny@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J7lr71_7I2uRSRPpZFu9lgYI2xDRo7eo
X-Proofpoint-ORIG-GUID: J7lr71_7I2uRSRPpZFu9lgYI2xDRo7eo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=413 mlxscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250063



On 12/25/2023 4:19 PM, Maria Yu wrote:
> As a rwlock for tasklist_lock, there are multiple scenarios to acquire
> read lock which write lock needed to be waiting for.
> In freeze_process/thaw_processes it can take about 200+ms for holding read
> lock of tasklist_lock by walking and freezing/thawing tasks in commercial
> devices. And write_lock_irq will have preempt disabled and local irq
> disabled to spin until the tasklist_lock can be acquired. This leading to
> a bad responsive performance of current system.
> Take an example:
> 1. cpu0 is holding read lock of tasklist_lock to thaw_processes.
> 2. cpu1 is waiting write lock of tasklist_lock to exec a new thread with
>     preempt_disabled and local irq disabled.
> 3. cpu2 is waiting write lock of tasklist_lock to do_exit with
>     preempt_disabled and local irq disabled.
> 4. cpu3 is waiting write lock of tasklist_lock to do_exit with
>     preempt_disabled and local irq disabled.
> So introduce a write lock/unlock wrapper for tasklist_lock specificly.
> The current taskslist_lock writers all have write_lock_irq to hold
> tasklist_lock, and write_unlock_irq to release tasklist_lock, that means
> the writers are not suitable or workable to wait on tasklist_lock in irq
> disabled scenarios. So the write lock/unlock wrapper here only follow the
> current design of directly use local_irq_disable and local_irq_enable,
> and not take already irq disabled writer callers into account.
> Use write_trylock in the loop and enabled irq for cpu to repsond if lock
> cannot be taken.
Pls ignore this patch.
Change is not ready for review.
Re-send by mistake.
> 
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>   fs/exec.c                  | 10 +++++-----
>   include/linux/sched/task.h | 29 +++++++++++++++++++++++++++++
>   kernel/exit.c              | 16 ++++++++--------
>   kernel/fork.c              |  6 +++---
>   kernel/ptrace.c            | 12 ++++++------
>   kernel/sys.c               |  8 ++++----
>   security/keys/keyctl.c     |  4 ++--
>   7 files changed, 57 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 4aa19b24f281..030eef6852eb 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1086,7 +1086,7 @@ static int de_thread(struct task_struct *tsk)
>   
>   		for (;;) {
>   			cgroup_threadgroup_change_begin(tsk);
> -			write_lock_irq(&tasklist_lock);
> +			write_lock_tasklist_lock();
>   			/*
>   			 * Do this under tasklist_lock to ensure that
>   			 * exit_notify() can't miss ->group_exec_task
> @@ -1095,7 +1095,7 @@ static int de_thread(struct task_struct *tsk)
>   			if (likely(leader->exit_state))
>   				break;
>   			__set_current_state(TASK_KILLABLE);
> -			write_unlock_irq(&tasklist_lock);
> +			write_unlock_tasklist_lock();
>   			cgroup_threadgroup_change_end(tsk);
>   			schedule();
>   			if (__fatal_signal_pending(tsk))
> @@ -1150,7 +1150,7 @@ static int de_thread(struct task_struct *tsk)
>   		 */
>   		if (unlikely(leader->ptrace))
>   			__wake_up_parent(leader, leader->parent);
> -		write_unlock_irq(&tasklist_lock);
> +		write_unlock_tasklist_lock();
>   		cgroup_threadgroup_change_end(tsk);
>   
>   		release_task(leader);
> @@ -1198,13 +1198,13 @@ static int unshare_sighand(struct task_struct *me)
>   
>   		refcount_set(&newsighand->count, 1);
>   
> -		write_lock_irq(&tasklist_lock);
> +		write_lock_tasklist_lock();
>   		spin_lock(&oldsighand->siglock);
>   		memcpy(newsighand->action, oldsighand->action,
>   		       sizeof(newsighand->action));
>   		rcu_assign_pointer(me->sighand, newsighand);
>   		spin_unlock(&oldsighand->siglock);
> -		write_unlock_irq(&tasklist_lock);
> +		write_unlock_tasklist_lock();
>   
>   		__cleanup_sighand(oldsighand);
>   	}
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index a23af225c898..6f69d9a3c868 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -50,6 +50,35 @@ struct kernel_clone_args {
>    * a separate lock).
>    */
>   extern rwlock_t tasklist_lock;
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
> +}
> +static inline void write_unlock_tasklist_lock(void)
> +{
> +	write_unlock_irq(&tasklist_lock);
> +}
> +
>   extern spinlock_t mmlist_lock;
>   
>   extern union thread_union init_thread_union;
> diff --git a/kernel/exit.c b/kernel/exit.c
> index ee9f43bed49a..18b00f477079 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -251,7 +251,7 @@ void release_task(struct task_struct *p)
>   
>   	cgroup_release(p);
>   
> -	write_lock_irq(&tasklist_lock);
> +	write_lock_tasklist_lock();
>   	ptrace_release_task(p);
>   	thread_pid = get_pid(p->thread_pid);
>   	__exit_signal(p);
> @@ -275,7 +275,7 @@ void release_task(struct task_struct *p)
>   			leader->exit_state = EXIT_DEAD;
>   	}
>   
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   	seccomp_filter_release(p);
>   	proc_flush_pid(thread_pid);
>   	put_pid(thread_pid);
> @@ -598,7 +598,7 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
>   		return reaper;
>   	}
>   
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   
>   	list_for_each_entry_safe(p, n, dead, ptrace_entry) {
>   		list_del_init(&p->ptrace_entry);
> @@ -606,7 +606,7 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
>   	}
>   
>   	zap_pid_ns_processes(pid_ns);
> -	write_lock_irq(&tasklist_lock);
> +	write_lock_tasklist_lock();
>   
>   	return father;
>   }
> @@ -730,7 +730,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>   	struct task_struct *p, *n;
>   	LIST_HEAD(dead);
>   
> -	write_lock_irq(&tasklist_lock);
> +	write_lock_tasklist_lock();
>   	forget_original_parent(tsk, &dead);
>   
>   	if (group_dead)
> @@ -758,7 +758,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>   	/* mt-exec, de_thread() is waiting for group leader */
>   	if (unlikely(tsk->signal->notify_count < 0))
>   		wake_up_process(tsk->signal->group_exec_task);
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   
>   	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
>   		list_del_init(&p->ptrace_entry);
> @@ -1172,7 +1172,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
>   	wo->wo_stat = status;
>   
>   	if (state == EXIT_TRACE) {
> -		write_lock_irq(&tasklist_lock);
> +		write_lock_tasklist_lock();
>   		/* We dropped tasklist, ptracer could die and untrace */
>   		ptrace_unlink(p);
>   
> @@ -1181,7 +1181,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
>   		if (do_notify_parent(p, p->exit_signal))
>   			state = EXIT_DEAD;
>   		p->exit_state = state;
> -		write_unlock_irq(&tasklist_lock);
> +		write_unlock_tasklist_lock();
>   	}
>   	if (state == EXIT_DEAD)
>   		release_task(p);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10917c3e1f03..06c4b4ab9102 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2623,7 +2623,7 @@ __latent_entropy struct task_struct *copy_process(
>   	 * Make it visible to the rest of the system, but dont wake it up yet.
>   	 * Need tasklist lock for parent etc handling!
>   	 */
> -	write_lock_irq(&tasklist_lock);
> +	write_lock_tasklist_lock();
>   
>   	/* CLONE_PARENT re-uses the old parent */
>   	if (clone_flags & (CLONE_PARENT|CLONE_THREAD)) {
> @@ -2714,7 +2714,7 @@ __latent_entropy struct task_struct *copy_process(
>   	hlist_del_init(&delayed.node);
>   	spin_unlock(&current->sighand->siglock);
>   	syscall_tracepoint_update(p);
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   
>   	if (pidfile)
>   		fd_install(pidfd, pidfile);
> @@ -2735,7 +2735,7 @@ __latent_entropy struct task_struct *copy_process(
>   bad_fork_cancel_cgroup:
>   	sched_core_free(p);
>   	spin_unlock(&current->sighand->siglock);
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   	cgroup_cancel_fork(p, args);
>   bad_fork_put_pidfd:
>   	if (clone_flags & CLONE_PIDFD) {
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index d8b5e13a2229..a8d7e2d06f3e 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -435,7 +435,7 @@ static int ptrace_attach(struct task_struct *task, long request,
>   	if (retval)
>   		goto unlock_creds;
>   
> -	write_lock_irq(&tasklist_lock);
> +	write_lock_tasklist_lock();
>   	retval = -EPERM;
>   	if (unlikely(task->exit_state))
>   		goto unlock_tasklist;
> @@ -479,7 +479,7 @@ static int ptrace_attach(struct task_struct *task, long request,
>   
>   	retval = 0;
>   unlock_tasklist:
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   unlock_creds:
>   	mutex_unlock(&task->signal->cred_guard_mutex);
>   out:
> @@ -508,7 +508,7 @@ static int ptrace_traceme(void)
>   {
>   	int ret = -EPERM;
>   
> -	write_lock_irq(&tasklist_lock);
> +	write_lock_tasklist_lock();
>   	/* Are we already being traced? */
>   	if (!current->ptrace) {
>   		ret = security_ptrace_traceme(current->parent);
> @@ -522,7 +522,7 @@ static int ptrace_traceme(void)
>   			ptrace_link(current, current->real_parent);
>   		}
>   	}
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   
>   	return ret;
>   }
> @@ -588,7 +588,7 @@ static int ptrace_detach(struct task_struct *child, unsigned int data)
>   	/* Architecture-specific hardware disable .. */
>   	ptrace_disable(child);
>   
> -	write_lock_irq(&tasklist_lock);
> +	write_lock_tasklist_lock();
>   	/*
>   	 * We rely on ptrace_freeze_traced(). It can't be killed and
>   	 * untraced by another thread, it can't be a zombie.
> @@ -600,7 +600,7 @@ static int ptrace_detach(struct task_struct *child, unsigned int data)
>   	 */
>   	child->exit_code = data;
>   	__ptrace_detach(current, child);
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   
>   	proc_ptrace_connector(child, PTRACE_DETACH);
>   
> diff --git a/kernel/sys.c b/kernel/sys.c
> index e219fcfa112d..0b1647d3ed32 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1088,7 +1088,7 @@ SYSCALL_DEFINE2(setpgid, pid_t, pid, pid_t, pgid)
>   	/* From this point forward we keep holding onto the tasklist lock
>   	 * so that our parent does not change from under us. -DaveM
>   	 */
> -	write_lock_irq(&tasklist_lock);
> +	write_lock_tasklist_lock();
>   
>   	err = -ESRCH;
>   	p = find_task_by_vpid(pid);
> @@ -1136,7 +1136,7 @@ SYSCALL_DEFINE2(setpgid, pid_t, pid, pid_t, pgid)
>   	err = 0;
>   out:
>   	/* All paths lead to here, thus we are safe. -DaveM */
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   	rcu_read_unlock();
>   	return err;
>   }
> @@ -1229,7 +1229,7 @@ int ksys_setsid(void)
>   	pid_t session = pid_vnr(sid);
>   	int err = -EPERM;
>   
> -	write_lock_irq(&tasklist_lock);
> +	write_lock_tasklist_lock();
>   	/* Fail if I am already a session leader */
>   	if (group_leader->signal->leader)
>   		goto out;
> @@ -1247,7 +1247,7 @@ int ksys_setsid(void)
>   
>   	err = session;
>   out:
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   	if (err > 0) {
>   		proc_sid_connector(group_leader);
>   		sched_autogroup_create_attach(group_leader);
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 19be69fa4d05..dd8aed20486a 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1652,7 +1652,7 @@ long keyctl_session_to_parent(void)
>   
>   	me = current;
>   	rcu_read_lock();
> -	write_lock_irq(&tasklist_lock);
> +	write_lock_tasklist_lock();
>   
>   	ret = -EPERM;
>   	oldwork = NULL;
> @@ -1702,7 +1702,7 @@ long keyctl_session_to_parent(void)
>   	if (!ret)
>   		newwork = NULL;
>   unlock:
> -	write_unlock_irq(&tasklist_lock);
> +	write_unlock_tasklist_lock();
>   	rcu_read_unlock();
>   	if (oldwork)
>   		put_cred(container_of(oldwork, struct cred, rcu));
> 
> base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b

-- 
Thx and BRs,
Aiqun(Maria) Yu


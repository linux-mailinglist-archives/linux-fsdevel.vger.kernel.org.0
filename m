Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241B93A3D9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhFKH4v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 03:56:51 -0400
Received: from mail-vi1eur05olkn2103.outbound.protection.outlook.com ([40.92.90.103]:40736
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229733AbhFKH4v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:56:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz5Neb7/N90KHDe/d9A7bZEr5tR+Jf2Tmo5dRltjBjqOe3MpjowkuIS4XddKdjPaOhAAIx0pIgHf+/pLJhqYNPW7lm+djcHSv7u8r1EtF5M0TAv2RKZuvMR+ATYVsdrdNR+l+Hj53S8SGZpD7u8LcbWL7LvBlMQZymddDCG4NQ0th0NOsvb1k+zHOu8U6O+Ywhi0d5IdZGBgJJOJdmgvcdv1LneoWZ9aMfbmhHgxyEhIHckTYdl/gTXbCmAjE7imqDBS5mB7e+LT3ruoqcNULT3YmwG5zqAV4X9VxeFvbqwsJNKlCzXLNmGcHDobDYun7aa4ZNPfK1CjTbeGAqI8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx6uBGF/SB+xpDufkt/8LaMdwutc7PM9gme5bRyel1Y=;
 b=EF4Vq1jpWZG8019YaTqIbv8VIdDiNJEQdcKF2Smd7bkO67fNbxaXhP4ovZELM866ub6YaXES+T1ukwLa2nZd96nmQdP2KRDfD9FK82JK7rzLisBK9e4kb7e9+Y2AWl93W3kISmkZTrpFh4vVbHNMAI+cWeZzkP4sWccmpVvFjhulL5cRK1BCsC7v5E+JM19U6K1jpkwlzeH+Tg4S//uHgq6ZRLYKCueEuGQ9hjMiSK+e0jb/ZbUkk/fdC3yoP3V2JF2MDLHNn7RpUvxlWoQKyV53Ku7OZZV98teJxiQ1xRXVE8fZHgivuLp7qp0Dh2bv0rY1qTHoGhbCmjvs0zUh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM6EUR05FT014.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::4c) by
 AM6EUR05HT025.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::231)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 07:54:51 +0000
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2a01:111:e400:fc11::51) by AM6EUR05FT014.mail.protection.outlook.com
 (2a01:111:e400:fc11::213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Fri, 11 Jun 2021 07:54:51 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:98EAF226AA0A8626824AE4ED14A5B9BA571F33D152A34CEC8B0633F7B014E1BB;UpperCasedChecksum:207D82F442299995080053084C03239E23AC758D5F5C9FA8218FD17BB95DEA72;SizeAsReceived:8812;Count:47
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e5e5:7b7a:5ea5:c75a]) by AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e5e5:7b7a:5ea5:c75a%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 07:54:51 +0000
Subject: Re: [PATCHv8] exec: Fix dead-lock in de_thread with ptrace_attach
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Charles Haithcock <chaithco@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Helge Deller <deller@gmx.de>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Adrian Reber <areber@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
References: <AM8PR10MB4708AFBD838138A84CE89EF8E4359@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <AM8PR10MB4708E1B4093506AE249BC7A6E4349@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Date:   Fri, 11 Jun 2021 09:54:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <AM8PR10MB4708AFBD838138A84CE89EF8E4359@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [sfEgw4Ad2ZTY22NTgLT5iNO/mGozI7Sa]
X-ClientProxiedBy: AM9P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::20) To AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:364::23)
X-Microsoft-Original-Message-ID: <ddd51910-89e3-2994-d406-b16affd7d56a@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (84.57.61.94) by AM9P193CA0015.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:54:49 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 203c622c-8dbe-42f8-0934-08d92cae30b0
X-MS-TrafficTypeDiagnostic: AM6EUR05HT025:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2hgx/R7P7Pxpa/YBppHRDPm+0H0KcyBoj7nDwl0nI2JtepCMsWfYpdKqmBorpz4BV7gYv7nK/aABHjOOCYytVbp7s6uNaZq9kQCsH66IxP6tAlYIX2vOamc/j0WvTvb+LSmEkQl8deXTUR5nausAVZIV8Lu1WaU8Qpvt0F/sdyo6AXrFpKuGdgbxcVRXdev8dDJ08uiqVFMiGlO8aU71T7rXLjt4/1csjnqqX3TGsC3/QLyIq6JFrYL5vhJLXd0jOe2POcGdgBaq7EO0dPPyBDSlqQqrZGCx/EfBZcGxMmugdDlWe1hMg7mesckf4Evm4kcFDYj1iIHojxRyLYRg/t9EgYKEMPpI3aFzb0t9YERk5/2NOqDl6ftaT86orsL0VgxduGzvD7IBGi6qZNhadWOERReOHJ825zQpjkmN70oc1WmLKwvmPEjEsvFhbU19E4wKpRb6z8ZJGWE/nEW05Zmfv4TtJ3DNUTikSHJ398=
X-MS-Exchange-AntiSpam-MessageData: wmoRP6BVZJzyUCAf+1E9fcau2kwUFTSM/dDboWXm8qU/5FStfPIQs03PUt02rVruOd9kKkjpPW+Q94e3JRQWyrzgzXwFNgsowNHIB0XJuEmwerkdSqcI44aBVwi/GS2NppqgkD6WkELTcD541/TZKA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203c622c-8dbe-42f8-0934-08d92cae30b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:54:51.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT014.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT025
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/21 9:31 AM, Bernd Edlinger wrote:
> This introduces signal->unsafe_execve_in_progress,
> which is used to fix the case when at least one of the
> sibling threads is traced, and therefore the trace
> process may dead-lock in ptrace_attach, but de_thread
> will need to wait for the tracer to continue execution.
> 
> The solution is to detect this situation and allow
> ptrace_attach to continue, while de_thread() is still
> waiting for traced zombies to be eventually released.
> When the current thread changed the ptrace status from
> non-traced to traced, we can simply abort the whole
> execve and restart it by returning -ERESTARTSYS.
> This needs to be done before changing the thread leader,
> because the PTRACE_EVENT_EXEC needs to know the old
> thread pid.
> 
> Although it is technically after the point of no return,
> we just have to reset bprm->point_of_no_return here,
> since at this time only the other threads have received
> a fatal signal, not the current thread.
> 
> From the user's point of view the whole execve was
> simply delayed until after the ptrace_attach.
> 
> Other threads die quickly since the cred_guard_mutex
> is released, but a deadly signal is already pending.
> In case the mutex_lock_killable misses the signal,
> ->unsafe_execve_in_progress makes sure they release
> the mutex immediately and return with -ERESTARTNOINTR.
> 
> This means there is no API change, unlike the previous
> version of this patch which was discussed here:
> 
> https://lore.kernel.org/lkml/b6537ae6-31b1-5c50-f32b-8b8332ace882@hotmail.de/
> 
> See tools/testing/selftests/ptrace/vmaccess.c
> for a test case that gets fixed by this change.
> 
> Note that since the test case was originally designed to
> test the ptrace_attach returning an error in this situation,
> the test expectation needed to be adjusted, to allow the
> API to succeed at the first attempt.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>  fs/exec.c                                 | 45 ++++++++++++++++++++++++++-----
>  fs/proc/base.c                            |  6 +++++
>  include/linux/sched/signal.h              | 13 +++++++++
>  kernel/ptrace.c                           |  9 +++++++
>  kernel/seccomp.c                          | 12 ++++++---
>  tools/testing/selftests/ptrace/vmaccess.c | 25 +++++++++++------
>  6 files changed, 92 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 8344fba..ac3fec1 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1040,6 +1040,8 @@ static int de_thread(struct task_struct *tsk)
>  	struct signal_struct *sig = tsk->signal;
>  	struct sighand_struct *oldsighand = tsk->sighand;
>  	spinlock_t *lock = &oldsighand->siglock;
> +	unsigned int prev_ptrace = tsk->ptrace;
> +	struct task_struct *t = tsk;
>  
>  	if (thread_group_empty(tsk))
>  		goto no_thread_group;
> @@ -1057,20 +1059,40 @@ static int de_thread(struct task_struct *tsk)
>  		return -EAGAIN;
>  	}
>  
> +	while_each_thread(tsk, t) {
> +		if (unlikely(t->ptrace) && t != tsk->group_leader)
> +			sig->unsafe_execve_in_progress = true;
> +	}
> +
>  	sig->group_exit_task = tsk;
>  	sig->notify_count = zap_other_threads(tsk);
>  	if (!thread_group_leader(tsk))
>  		sig->notify_count--;
> +	spin_unlock_irq(lock);
>  
> -	while (sig->notify_count) {
> -		__set_current_state(TASK_KILLABLE);
> -		spin_unlock_irq(lock);
> +	if (unlikely(sig->unsafe_execve_in_progress))
> +		mutex_unlock(&sig->cred_guard_mutex);
> +
> +	for (;;) {
> +		set_current_state(TASK_KILLABLE);
> +		if (!sig->notify_count)
> +			break;
>  		schedule();
>  		if (__fatal_signal_pending(tsk))
>  			goto killed;
> -		spin_lock_irq(lock);
>  	}
> -	spin_unlock_irq(lock);
> +	__set_current_state(TASK_RUNNING);

Oh, sorry, I think I'll need to keep this spin_lock here,
because otherwise the assignment sig->group_exit_task = NULL
below will race with 

kernel/exit.c (__exit_signal):
                if (sig->notify_count > 0 && !--sig->notify_count)
                        wake_up_process(sig->group_exit_task);

which runs under spin_lock(&sighand->siglock) and tasklist_lock write-locked.

Will send an updaten the patch later today.


Bernd.

> +
> +	if (unlikely(sig->unsafe_execve_in_progress)) {
> +		if (mutex_lock_killable(&sig->cred_guard_mutex))
> +			goto killed;
> +		sig->unsafe_execve_in_progress = false;
> +		if (!prev_ptrace && tsk->ptrace) {
> +			sig->group_exit_task = NULL;
> +			sig->notify_count = 0;
> +			return -ERESTARTSYS;
> +		}
> +	}
>  
>  	/*
>  	 * At this point all other threads have exited, all we have to
> @@ -1255,8 +1277,11 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	 * Make this the only thread in the thread group.
>  	 */
>  	retval = de_thread(me);
> -	if (retval)
> +	if (retval) {
> +		if (retval == -ERESTARTSYS)
> +			bprm->point_of_no_return = false;
>  		goto out;
> +	}
>  
>  	/*
>  	 * Cancel any io_uring activity across execve
> @@ -1466,6 +1491,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
>  	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>  		return -ERESTARTNOINTR;
>  
> +	if (unlikely(current->signal->unsafe_execve_in_progress)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		return -ERESTARTNOINTR;
> +	}
> +
>  	bprm->cred = prepare_exec_creds();
>  	if (likely(bprm->cred))
>  		return 0;
> @@ -1482,7 +1512,8 @@ static void free_bprm(struct linux_binprm *bprm)
>  	}
>  	free_arg_pages(bprm);
>  	if (bprm->cred) {
> -		mutex_unlock(&current->signal->cred_guard_mutex);
> +		if (!current->signal->unsafe_execve_in_progress)
> +			mutex_unlock(&current->signal->cred_guard_mutex);
>  		abort_creds(bprm->cred);
>  	}
>  	if (bprm->file) {
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 3851bfc..3b2a55c 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2739,6 +2739,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>  	if (rv < 0)
>  		goto out_free;
>  
> +	if (unlikely(current->signal->unsafe_execve_in_progress)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		rv = -ERESTARTNOINTR;
> +		goto out_free;
> +	}
> +
>  	rv = security_setprocattr(PROC_I(inode)->op.lsm,
>  				  file->f_path.dentry->d_name.name, page,
>  				  count);
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 3f6a0fc..220a083 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -214,6 +214,17 @@ struct signal_struct {
>  #endif
>  
>  	/*
> +	 * Set while execve is executing but is *not* holding
> +	 * cred_guard_mutex to avoid possible dead-locks.
> +	 * The cred_guard_mutex is released *after* de_thread() has
> +	 * called zap_other_threads(), therefore a fatal signal is
> +	 * guaranteed to be already pending in the unlikely event, that
> +	 * current->signal->unsafe_execve_in_progress happens to be
> +	 * true after the cred_guard_mutex was acquired.
> +	 */
> +	bool unsafe_execve_in_progress;
> +
> +	/*
>  	 * Thread is the potential origin of an oom condition; kill first on
>  	 * oom
>  	 */
> @@ -227,6 +238,8 @@ struct signal_struct {
>  	struct mutex cred_guard_mutex;	/* guard against foreign influences on
>  					 * credential calculations
>  					 * (notably. ptrace)
> +					 * Held while execve runs, except when
> +					 * a sibling thread is being traced.
>  					 * Deprecated do not use in new code.
>  					 * Use exec_update_lock instead.
>  					 */
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 61db50f..0cbc1eb 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -468,6 +468,14 @@ static int ptrace_traceme(void)
>  {
>  	int ret = -EPERM;
>  
> +	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
> +		return -ERESTARTNOINTR;
> +
> +	if (unlikely(current->signal->unsafe_execve_in_progress)) {
> +		mutex_unlock(&current->signal->cred_guard_mutex);
> +		return -ERESTARTNOINTR;
> +	}
> +
>  	write_lock_irq(&tasklist_lock);
>  	/* Are we already being traced? */
>  	if (!current->ptrace) {
> @@ -483,6 +491,7 @@ static int ptrace_traceme(void)
>  		}
>  	}
>  	write_unlock_irq(&tasklist_lock);
> +	mutex_unlock(&current->signal->cred_guard_mutex);
>  
>  	return ret;
>  }
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 1d60fc2..b1389ee 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1824,9 +1824,15 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  	 * Make sure we cannot change seccomp or nnp state via TSYNC
>  	 * while another thread is in the middle of calling exec.
>  	 */
> -	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
> -	    mutex_lock_killable(&current->signal->cred_guard_mutex))
> -		goto out_put_fd;
> +	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
> +		if (mutex_lock_killable(&current->signal->cred_guard_mutex))
> +			goto out_put_fd;
> +
> +		if (unlikely(current->signal->unsafe_execve_in_progress)) {
> +			mutex_unlock(&current->signal->cred_guard_mutex);
> +			goto out_put_fd;
> +		}
> +	}
>  
>  	spin_lock_irq(&current->sighand->siglock);
>  
> diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
> index 4db327b..c7c2242 100644
> --- a/tools/testing/selftests/ptrace/vmaccess.c
> +++ b/tools/testing/selftests/ptrace/vmaccess.c
> @@ -39,8 +39,15 @@ static void *thread(void *arg)
>  	f = open(mm, O_RDONLY);
>  	ASSERT_GE(f, 0);
>  	close(f);
> -	f = kill(pid, SIGCONT);
> -	ASSERT_EQ(f, 0);
> +	f = waitpid(-1, NULL, 0);
> +	ASSERT_NE(f, -1);
> +	ASSERT_NE(f, 0);
> +	ASSERT_NE(f, pid);
> +	f = waitpid(-1, NULL, 0);
> +	ASSERT_EQ(f, pid);
> +	f = waitpid(-1, NULL, 0);
> +	ASSERT_EQ(f, -1);
> +	ASSERT_EQ(errno, ECHILD);
>  }
>  
>  TEST(attach)
> @@ -57,22 +64,24 @@ static void *thread(void *arg)
>  
>  	sleep(1);
>  	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
> -	ASSERT_EQ(errno, EAGAIN);
> -	ASSERT_EQ(k, -1);
> +	ASSERT_EQ(k, 0);
>  	k = waitpid(-1, &s, WNOHANG);
>  	ASSERT_NE(k, -1);
>  	ASSERT_NE(k, 0);
>  	ASSERT_NE(k, pid);
>  	ASSERT_EQ(WIFEXITED(s), 1);
>  	ASSERT_EQ(WEXITSTATUS(s), 0);
> -	sleep(1);
> -	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
> -	ASSERT_EQ(k, 0);
>  	k = waitpid(-1, &s, 0);
>  	ASSERT_EQ(k, pid);
>  	ASSERT_EQ(WIFSTOPPED(s), 1);
>  	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> -	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
> +	ASSERT_EQ(k, 0);
> +	k = waitpid(-1, &s, 0);
> +	ASSERT_EQ(k, pid);
> +	ASSERT_EQ(WIFSTOPPED(s), 1);
> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
>  	ASSERT_EQ(k, 0);
>  	k = waitpid(-1, &s, 0);
>  	ASSERT_EQ(k, pid);
> 

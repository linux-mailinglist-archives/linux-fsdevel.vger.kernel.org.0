Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF03A2580
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 09:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhFJHdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 03:33:44 -0400
Received: from mail-oln040092068050.outbound.protection.outlook.com ([40.92.68.50]:1954
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229634AbhFJHdn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:33:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jou/MlUNYkyQIAI9WT74e8NDI6vWtj7tr+8NLRrwagcka4sLAnyVSB8OC1JgGIpem1j272a92yF7U2orYo5qR/yYKjFLdWwCf+poYx/jQHOelv/4sbc7C3hCelPoAQWnFbuKR+R4fRTtMRDX7YqP448ZSsA8CJk6ZbHupIst+E5JdP2rtEeUYZqSgfykykfW3yBHc1gnqbp5OsWXGktfy6pG78I78/olyfZ9TE4VxsFfIL0guccPcAB5oUMRfT7aQ5PZ0aCqpAQdsgE341EHwupAM846Nro9GfT30ufd7NB9Lm0fPW8T39l41ciHiJRYl2quI0C/s212KMz0l14bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPkkyZ47V5zAEGSID4qleXk0HmNBPy9GQzoaKWmnYuM=;
 b=NMLrrIJZioLgiMOyIJUKSjs1xhj7lQfVo21lIhf6UOeIcUjajsKnG1AkfpZli3OpnEgDi6JreZOlYq6PJN+DpN+uVH9HeR46TFjrFLjab3c0torLhQeVFp9iD82UGndu0j92Alam5UJvDRMN8g+ejwH5o35naqcOvjbiFJlrdLgzRoO9zBzq2/FKAu8zO6k8PPMkgR5iSqA571zt/BbknOGd5EDvSmXi7igRFajvERUA0RTV0wDCMFdKj0SieVserjkksE65H4Jfsg2SYK76GpQ1qMtztEiESgGj+Nl4d741TQjxzCYUpipa4Kjyy1X2N6GZHSKFvZehVyA95jrXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR02FT027.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1c::53) by
 AM5EUR02HT170.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1c::416)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 07:31:45 +0000
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2a01:111:e400:7e1c::4e) by AM5EUR02FT027.mail.protection.outlook.com
 (2a01:111:e400:7e1c::127) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 07:31:45 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:6949A61FA24BAD072CAF2572ABE453DBA6F5C321648791FA1C9A3C4209432A47;UpperCasedChecksum:DD106DCB3008963A715CA47109EDF287098F2D34CB85AC246F0CF48824E1032F;SizeAsReceived:8583;Count:45
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e5e5:7b7a:5ea5:c75a]) by AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e5e5:7b7a:5ea5:c75a%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 07:31:45 +0000
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
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCHv8] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <AM8PR10MB4708AFBD838138A84CE89EF8E4359@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Date:   Thu, 10 Jun 2021 09:31:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [L+ONw775kzR9E9QlfNHbr9oNdi2aNLpr]
X-ClientProxiedBy: PR3PR09CA0024.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::29) To AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:364::23)
X-Microsoft-Original-Message-ID: <54426f73-aa89-752f-aa5a-6bdf14ac288f@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (84.57.61.94) by PR3PR09CA0024.eurprd09.prod.outlook.com (2603:10a6:102:b7::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 07:31:43 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 95165da8-abe6-4cbe-b138-08d92be1cc50
X-MS-TrafficTypeDiagnostic: AM5EUR02HT170:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQ9eghDsUek4ekDbOn6HnFGN7EPHivTuWXgzVbqOzUYR+P5HAApj0stdulvngRdsTYRS3G8ffmHqTlT0GsRL3AB1Ke5YpFcpQvSKt0r/36zFl4YHap8fxHEfLdZwNBubM0hfa+ce1YFvjuYJuIx1fKgURjkvgb45/LtTzqVEU+byvj1Uy98m/0eEW1UeSg7nDgmBVqsYHC+TR8dW1No9pSu5kQRHgTcABA/6fTerYhqUNnNVHXZUzXzEmZ8zLwvKZtJXZswQSAOGJZ0GV1DlbRBY33xYzwefi/kgDDcoIVoUcrXeis7etCPiiLkCb15QNoBgDJLFZ581lHiTh8VTY6vAr2HrJS8vRunMkAQBOZbPiEoKeTTENeGkLppUSywE0Cbud0zjPxl3GCi1fWK2ER97z1Mq6/QLvEKRXNWbTrYyOFFVL20Qz2PQuA1REvO9SR4XumlSuJ/5CNfkNmkt1Iy3RGFdKGIeJ/uhOZzrHoU=
X-MS-Exchange-AntiSpam-MessageData: BISle2dBfegWkjZEufPp+mE228pxQN+VTcb74rIVbtw8hc47/tIEoWWnH60RsafwvqoqeAegrn2IX1HrZ2EOMESUtMx8VVkyz18u3zxACuXc6FkFf4WtXx9zOfejCSNVwMeSk8MWp2Wz632oS37KTw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95165da8-abe6-4cbe-b138-08d92be1cc50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 07:31:45.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT027.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT170
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This introduces signal->unsafe_execve_in_progress,
which is used to fix the case when at least one of the
sibling threads is traced, and therefore the trace
process may dead-lock in ptrace_attach, but de_thread
will need to wait for the tracer to continue execution.

The solution is to detect this situation and allow
ptrace_attach to continue, while de_thread() is still
waiting for traced zombies to be eventually released.
When the current thread changed the ptrace status from
non-traced to traced, we can simply abort the whole
execve and restart it by returning -ERESTARTSYS.
This needs to be done before changing the thread leader,
because the PTRACE_EVENT_EXEC needs to know the old
thread pid.

Although it is technically after the point of no return,
we just have to reset bprm->point_of_no_return here,
since at this time only the other threads have received
a fatal signal, not the current thread.

From the user's point of view the whole execve was
simply delayed until after the ptrace_attach.

Other threads die quickly since the cred_guard_mutex
is released, but a deadly signal is already pending.
In case the mutex_lock_killable misses the signal,
->unsafe_execve_in_progress makes sure they release
the mutex immediately and return with -ERESTARTNOINTR.

This means there is no API change, unlike the previous
version of this patch which was discussed here:

https://lore.kernel.org/lkml/b6537ae6-31b1-5c50-f32b-8b8332ace882@hotmail.de/

See tools/testing/selftests/ptrace/vmaccess.c
for a test case that gets fixed by this change.

Note that since the test case was originally designed to
test the ptrace_attach returning an error in this situation,
the test expectation needed to be adjusted, to allow the
API to succeed at the first attempt.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 fs/exec.c                                 | 45 ++++++++++++++++++++++++++-----
 fs/proc/base.c                            |  6 +++++
 include/linux/sched/signal.h              | 13 +++++++++
 kernel/ptrace.c                           |  9 +++++++
 kernel/seccomp.c                          | 12 ++++++---
 tools/testing/selftests/ptrace/vmaccess.c | 25 +++++++++++------
 6 files changed, 92 insertions(+), 18 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 8344fba..ac3fec1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1040,6 +1040,8 @@ static int de_thread(struct task_struct *tsk)
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	unsigned int prev_ptrace = tsk->ptrace;
+	struct task_struct *t = tsk;
 
 	if (thread_group_empty(tsk))
 		goto no_thread_group;
@@ -1057,20 +1059,40 @@ static int de_thread(struct task_struct *tsk)
 		return -EAGAIN;
 	}
 
+	while_each_thread(tsk, t) {
+		if (unlikely(t->ptrace) && t != tsk->group_leader)
+			sig->unsafe_execve_in_progress = true;
+	}
+
 	sig->group_exit_task = tsk;
 	sig->notify_count = zap_other_threads(tsk);
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
+	spin_unlock_irq(lock);
 
-	while (sig->notify_count) {
-		__set_current_state(TASK_KILLABLE);
-		spin_unlock_irq(lock);
+	if (unlikely(sig->unsafe_execve_in_progress))
+		mutex_unlock(&sig->cred_guard_mutex);
+
+	for (;;) {
+		set_current_state(TASK_KILLABLE);
+		if (!sig->notify_count)
+			break;
 		schedule();
 		if (__fatal_signal_pending(tsk))
 			goto killed;
-		spin_lock_irq(lock);
 	}
-	spin_unlock_irq(lock);
+	__set_current_state(TASK_RUNNING);
+
+	if (unlikely(sig->unsafe_execve_in_progress)) {
+		if (mutex_lock_killable(&sig->cred_guard_mutex))
+			goto killed;
+		sig->unsafe_execve_in_progress = false;
+		if (!prev_ptrace && tsk->ptrace) {
+			sig->group_exit_task = NULL;
+			sig->notify_count = 0;
+			return -ERESTARTSYS;
+		}
+	}
 
 	/*
 	 * At this point all other threads have exited, all we have to
@@ -1255,8 +1277,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * Make this the only thread in the thread group.
 	 */
 	retval = de_thread(me);
-	if (retval)
+	if (retval) {
+		if (retval == -ERESTARTSYS)
+			bprm->point_of_no_return = false;
 		goto out;
+	}
 
 	/*
 	 * Cancel any io_uring activity across execve
@@ -1466,6 +1491,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
 		return -ERESTARTNOINTR;
 
+	if (unlikely(current->signal->unsafe_execve_in_progress)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		return -ERESTARTNOINTR;
+	}
+
 	bprm->cred = prepare_exec_creds();
 	if (likely(bprm->cred))
 		return 0;
@@ -1482,7 +1512,8 @@ static void free_bprm(struct linux_binprm *bprm)
 	}
 	free_arg_pages(bprm);
 	if (bprm->cred) {
-		mutex_unlock(&current->signal->cred_guard_mutex);
+		if (!current->signal->unsafe_execve_in_progress)
+			mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
 	if (bprm->file) {
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 3851bfc..3b2a55c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2739,6 +2739,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
+	if (unlikely(current->signal->unsafe_execve_in_progress)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		rv = -ERESTARTNOINTR;
+		goto out_free;
+	}
+
 	rv = security_setprocattr(PROC_I(inode)->op.lsm,
 				  file->f_path.dentry->d_name.name, page,
 				  count);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3f6a0fc..220a083 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -214,6 +214,17 @@ struct signal_struct {
 #endif
 
 	/*
+	 * Set while execve is executing but is *not* holding
+	 * cred_guard_mutex to avoid possible dead-locks.
+	 * The cred_guard_mutex is released *after* de_thread() has
+	 * called zap_other_threads(), therefore a fatal signal is
+	 * guaranteed to be already pending in the unlikely event, that
+	 * current->signal->unsafe_execve_in_progress happens to be
+	 * true after the cred_guard_mutex was acquired.
+	 */
+	bool unsafe_execve_in_progress;
+
+	/*
 	 * Thread is the potential origin of an oom condition; kill first on
 	 * oom
 	 */
@@ -227,6 +238,8 @@ struct signal_struct {
 	struct mutex cred_guard_mutex;	/* guard against foreign influences on
 					 * credential calculations
 					 * (notably. ptrace)
+					 * Held while execve runs, except when
+					 * a sibling thread is being traced.
 					 * Deprecated do not use in new code.
 					 * Use exec_update_lock instead.
 					 */
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 61db50f..0cbc1eb 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -468,6 +468,14 @@ static int ptrace_traceme(void)
 {
 	int ret = -EPERM;
 
+	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
+		return -ERESTARTNOINTR;
+
+	if (unlikely(current->signal->unsafe_execve_in_progress)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		return -ERESTARTNOINTR;
+	}
+
 	write_lock_irq(&tasklist_lock);
 	/* Are we already being traced? */
 	if (!current->ptrace) {
@@ -483,6 +491,7 @@ static int ptrace_traceme(void)
 		}
 	}
 	write_unlock_irq(&tasklist_lock);
+	mutex_unlock(&current->signal->cred_guard_mutex);
 
 	return ret;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 1d60fc2..b1389ee 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1824,9 +1824,15 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	 * Make sure we cannot change seccomp or nnp state via TSYNC
 	 * while another thread is in the middle of calling exec.
 	 */
-	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
-	    mutex_lock_killable(&current->signal->cred_guard_mutex))
-		goto out_put_fd;
+	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
+		if (mutex_lock_killable(&current->signal->cred_guard_mutex))
+			goto out_put_fd;
+
+		if (unlikely(current->signal->unsafe_execve_in_progress)) {
+			mutex_unlock(&current->signal->cred_guard_mutex);
+			goto out_put_fd;
+		}
+	}
 
 	spin_lock_irq(&current->sighand->siglock);
 
diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
index 4db327b..c7c2242 100644
--- a/tools/testing/selftests/ptrace/vmaccess.c
+++ b/tools/testing/selftests/ptrace/vmaccess.c
@@ -39,8 +39,15 @@ static void *thread(void *arg)
 	f = open(mm, O_RDONLY);
 	ASSERT_GE(f, 0);
 	close(f);
-	f = kill(pid, SIGCONT);
-	ASSERT_EQ(f, 0);
+	f = waitpid(-1, NULL, 0);
+	ASSERT_NE(f, -1);
+	ASSERT_NE(f, 0);
+	ASSERT_NE(f, pid);
+	f = waitpid(-1, NULL, 0);
+	ASSERT_EQ(f, pid);
+	f = waitpid(-1, NULL, 0);
+	ASSERT_EQ(f, -1);
+	ASSERT_EQ(errno, ECHILD);
 }
 
 TEST(attach)
@@ -57,22 +64,24 @@ static void *thread(void *arg)
 
 	sleep(1);
 	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
-	ASSERT_EQ(errno, EAGAIN);
-	ASSERT_EQ(k, -1);
+	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, WNOHANG);
 	ASSERT_NE(k, -1);
 	ASSERT_NE(k, 0);
 	ASSERT_NE(k, pid);
 	ASSERT_EQ(WIFEXITED(s), 1);
 	ASSERT_EQ(WEXITSTATUS(s), 0);
-	sleep(1);
-	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
-	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, 0);
 	ASSERT_EQ(k, pid);
 	ASSERT_EQ(WIFSTOPPED(s), 1);
 	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
-	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
 	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, 0);
 	ASSERT_EQ(k, pid);
-- 
1.9.1

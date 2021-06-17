Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5193AB37D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhFQM0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 08:26:01 -0400
Received: from mail-oln040092075031.outbound.protection.outlook.com ([40.92.75.31]:62392
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232690AbhFQM0B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:26:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2q74SEmIwZK8kPo5UopzbVNWU+Y6qNTt7xcR21YtXT/LBboklz3MD26G4IH4lPO0V/5Lu9xFbkDeSogytV5lwdD7MdDDwPOcjLFBXislIk3OhbvnutOe9xsQXDgzMnpUkofmPdgvPNRItUYWRQVNrTw5SDfO+XXWCuQ9AXAtHF8Zg2IAdCflN6Kud2822nJNOuYo8sAeC2zX8FXKXJjOMyLvhfA3JqcuUPJO82AhfVlhXktp7HoQcFowvrpFiXsPnJ2VE6E/2pOZiYMf2Rnxsuuh/Eh3EAf9GF0zkEAVQ1ONWVmOF52H7nnM3MMVPSqbLVdA1GhdelUiVcg8fhHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIzUbznV664F/B/jvLyuiGu712ufDNsWbRitNS+yZPA=;
 b=G3Rmb+VTb6ytYX/G3S+rCs4fYbDRI0gsB/rgOm8+tqCu6zMmHm5LZuJ6OJQ14eK1HsWGsHDO284RTGtyzEmF5/vDta0hgFpswvL9p/ybCXRK0kXXd7rA4w2XadZHeqOtQCk4PFkU7gBdy4xI4RkLp7AzOXjZc9eLvCJtGZUwBPSWnHmKaIcQgUPCWvgQgSM/yCQing7PG4M0lei+urAkl/CMyqK24cHH4L8y/Z/PD4+Q5O2teW+77Uq0pVpwgDMVOAvw6klkGmnXyr0pgcKnxqNbJvwr0MKdz00BMacsCwtKrkzTJPonAlorRUZL5Pk0at6w6uxv9EbCAzEDAOqpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR04FT039.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::4e) by
 VI1EUR04HT180.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::66)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 12:23:51 +0000
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2a01:111:e400:7e0e::49) by VI1EUR04FT039.mail.protection.outlook.com
 (2a01:111:e400:7e0e::315) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Thu, 17 Jun 2021 12:23:50 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E8F058413FB5AAA58BC5A8C7C6DA16D5525DFAF91C8ECB46424B716D25EE644B;UpperCasedChecksum:5AAF016DE26ED6173091C4EAA8E3FEC31B41C1ABE62C27A68D092658E38D4D44;SizeAsReceived:8591;Count:45
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d5c4:2d6f:ddf3:3119]) by AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d5c4:2d6f:ddf3:3119%9]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 12:23:50 +0000
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Yafang Shao <laoar.shao@gmail.com>,
        Helge Deller <deller@gmx.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Adrian Reber <areber@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH v10] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Date:   Thu, 17 Jun 2021 14:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [7Dr51V9HpzS4AqnJOjIDGFi5c5PVmmqc]
X-ClientProxiedBy: PR0P264CA0146.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::14) To AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:364::23)
X-Microsoft-Original-Message-ID: <160f025e-0b7b-7da1-1743-cf29c3e12f53@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (84.57.55.161) by PR0P264CA0146.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Thu, 17 Jun 2021 12:23:49 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 2c02be13-119f-4e77-9505-08d9318ac355
X-MS-TrafficTypeDiagnostic: VI1EUR04HT180:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2Zt+LTx+Fu+6nFsN1BtWpYdNVWb21TQ3z2x1yyc1N6CykJC71mReabZskEX+Q6C3OIS9z2FJLD2kZT5PSIly+vq8cZo/y/Nj8pd2zQZXA0zXOcRSARMU7cl4NU4hUkY7CBZqNYQ0XRui0jXdXt520q3ilKwX2zokBhJ9MBpqFIHjeV/cXUJ3hUtqDTgsopZ03/RVdeawNDWy5zUwTy1TDrCRW9IIy5xhmoAWskumc5ltfPFo92tAGf0Zl8R2m6gkZSm/0wJ75aag6RzEHFJF1VNtEbsESI8/G7JiQjK9O/whwtzHFhaTsdW+N8Gf8I/LIfgv4EQARpG98oEi6+FKdVv9LuqREoMq9TphdHmJjU0xt+QZdXzknksCsYzrvNHJIcCA+wq+X1O5Ow5YI3RyQ==
X-MS-Exchange-AntiSpam-MessageData: Z/eilA5YEGT7TE9bFMUzVjEK/LjW1gn7HoxP3Y+u87xTtJ9w5u0JsVtKmrpk5TCBTnRYCinjItKTv5q+6IcePpCu0IpoNbH7CFhKLk5xDgPSGBO3eWfVpnc/k401B5ljxOOUvIG0X3O1ey1Fx4gW/w==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c02be13-119f-4e77-9505-08d9318ac355
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 12:23:50.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT039.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT180
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This introduces signal->unsafe_execve_in_progress,
which is used to fix the case when at least one of the
sibling threads is traced, and therefore the trace
process may dead-lock in ptrace_attach, but de_thread
will need to wait for the tracer to continue execution.

All threads that are traced with PTRACE_O_TRACEEXIT
send a PTRACE_EVENT_EXIT to the tracer, and wait
for the tracer to do a PTRACE_CONT before reaching
the ZOMBIE state.  This wait state is not interrupted
by zap_other_threads.

All threads except the thread leader do also wait
for the tracer to receive the exit signal with waitpid
before de_thread can continue.

When the cred_guard_mutex is held for so long time,
any attempt to ptrace_attach this thread will block
the tracer.

The solution is to detect this situation and make
ptrace_attach return -EAGAIN.  Do that only after all
other checks have been done, and only for the thread
that does the execve, other threads can be allowed to
proceed, since that has not influence the credentials
of the new process.

This means this is an API change, but only when some
threads are being traced while execve happens in a
non-traced thread.

See tools/testing/selftests/ptrace/vmaccess.c
for a test case that gets fixed by this change.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 fs/exec.c                    | 26 +++++++++++++++++++++++++-
 fs/proc/base.c               |  6 ++++++
 include/linux/sched/signal.h | 13 +++++++++++++
 kernel/ptrace.c              | 24 ++++++++++++++++++++++++
 kernel/seccomp.c             | 12 +++++++++---
 5 files changed, 77 insertions(+), 4 deletions(-)

v10: Changes to previous version, make the PTRACE_ATTACH
retun -EAGAIN, instead of execve return -ERESTARTSYS.
Added some lessions learned to the description.

diff --git a/fs/exec.c b/fs/exec.c
index 8344fba..9b987ef 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1040,6 +1040,7 @@ static int de_thread(struct task_struct *tsk)
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	struct task_struct *t = tsk;
 
 	if (thread_group_empty(tsk))
 		goto no_thread_group;
@@ -1062,6 +1063,17 @@ static int de_thread(struct task_struct *tsk)
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
 
+	while_each_thread(tsk, t) {
+		if (unlikely(t->ptrace))
+			sig->unsafe_execve_in_progress = true;
+	}
+
+	if (unlikely(sig->unsafe_execve_in_progress)) {
+		spin_unlock_irq(lock);
+		mutex_unlock(&sig->cred_guard_mutex);
+		spin_lock_irq(lock);
+	}
+
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
@@ -1152,6 +1164,12 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
+	if (unlikely(sig->unsafe_execve_in_progress)) {
+		if (mutex_lock_killable(&sig->cred_guard_mutex))
+			goto killed;
+		sig->unsafe_execve_in_progress = false;
+	}
+
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
 
@@ -1466,6 +1484,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
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
@@ -1482,7 +1505,8 @@ static void free_bprm(struct linux_binprm *bprm)
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
index 61db50f..b10530a 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -402,6 +402,21 @@ static int ptrace_attach(struct task_struct *task, long request,
 	if (task->ptrace)
 		goto unlock_tasklist;
 
+	/*
+	 * It may happen that de_thread() has to release the
+	 * cred_guard_mutex in order to prevent deadlocks.
+	 * In that case unsafe_execve_in_progress will be set.
+	 * If that happens you cannot assume that the usual
+	 * guarantees implied by cred_guard_mutex are valid.
+	 * Just return -EAGAIN in that case.
+	 * The tracer is expected to call wait(2) and handle
+	 * possible events before calling this API again.
+	 */
+	retval = -EAGAIN;
+	if (unlikely(task->signal->unsafe_execve_in_progress) &&
+	    task->in_execve)
+		goto unlock_tasklist;
+
 	if (seize)
 		flags |= PT_SEIZED;
 	task->ptrace = flags;
@@ -468,6 +483,14 @@ static int ptrace_traceme(void)
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
@@ -483,6 +506,7 @@ static int ptrace_traceme(void)
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
 
-- 
1.9.1

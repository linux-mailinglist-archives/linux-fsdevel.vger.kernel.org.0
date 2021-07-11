Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADBB3C3E78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jul 2021 19:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhGKRqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 13:46:40 -0400
Received: from mail-am7eur06olkn2087.outbound.protection.outlook.com ([40.92.16.87]:60544
        "EHLO EUR06-AM7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230415AbhGKRqi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:46:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBuj0yNX++dG5vqVY5vm1dtHgxL8T273VNhU5sOAZ36fJRLmxel0nGlub0x421C9wfUoVBR1WlsLprwsKZ3xzgbWOiEpyxgbwB+rQXFGsSSDaL+gYj2Uc3aZsBzGJUzkSeqqSY6BmbZ023Z86acgkXbFiuZU1PVynIuyy2fOJfRvRVRzQWWBvwVX7WfnnYZOYvixaut+fhoNQ7qfIp/tbWPddPs6IBNCLV1vLI9toNOHSpevCcJivgCwBjlUXtV6NsFhu3GOx9FpdLCMjrEa0dnd3hakm+Oj08bpAuFXHi7+M6YHpLIy0ITwE/9plxUJwHcBHM4DmlUyeI5BJ01cRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H++ORXzkunoVcBXU38KbBtQ2WIdVlLbZnVftwN3WX98=;
 b=J6rH4XvUx+KqLvlxK7DKyoMpdWGKZ2yK0DCqVXawMHhdG7Mbq1NWGxUS/hjtHwG8eAB4Jql3n27AMvvsgesfFR2AG7LnwA6avBc5CAwePkrNpCsahOw5HSoJFhL71mXFSEE5ZUe8Z9qkU0/Fm4stpumtYy3tk9yw36YxxFXRZSGDBMSj5xCYbkwVFlRVZCJxSlUmcLWZPcT6fbekugSGFlA8fRE6EQHYsMt7lDWvluq4M3ynjT8NJYwUEs8IKnclQMHxSCUFrzEGQurHIF8m2i2StFEImGl1zBzuFU8VQcAeiYcl1b8vzIHrlZtbPjB32jjs3QCh42eKY4AKCkY8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR06FT063.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc37::4b) by
 VI1EUR06HT159.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc37::107)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Sun, 11 Jul
 2021 17:43:48 +0000
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2a01:111:e400:fc37::41) by VI1EUR06FT063.mail.protection.outlook.com
 (2a01:111:e400:fc37::260) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Sun, 11 Jul 2021 17:43:48 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:1AB572F4431F649BE5752DE95C263579C0A400C97D268115EC061D875BCB9014;UpperCasedChecksum:BC32D7D8665635D493687C5F80A4DD52C685CAC537901229236213BEF636A385;SizeAsReceived:8784;Count:47
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cfe:7434:1813:e18f]) by AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cfe:7434:1813:e18f%8]) with mapi id 15.20.4308.026; Sun, 11 Jul 2021
 17:43:48 +0000
Subject: [PATCH v11] exec: Fix dead-lock in de_thread with ptrace_attach
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
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
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Date:   Sun, 11 Jul 2021 19:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [G/OkK5Lc8apvj1SLc/i8+27VpgnyPDr5]
X-ClientProxiedBy: PR0P264CA0200.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::20) To AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:364::23)
X-Microsoft-Original-Message-ID: <10850fe4-47a2-5188-a75b-85d2add96f83@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (88.76.118.196) by PR0P264CA0200.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Sun, 11 Jul 2021 17:43:46 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 4a5e44de-fa6f-491e-21e2-08d944936fe5
X-MS-TrafficTypeDiagnostic: VI1EUR06HT159:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFM97hLI/Z9Cx5cjGeMMXy1LY3oZw5bSdHHOmRO+o9dyFyA2CGstGoT96towXKYXKhrcAy9hE0Cfu5MOcDOTgWIlPdgTuJBiWuwSKgdEcVBGD/sD8xerqqQFQSqH4VXo2hbL/jupHMuEJTdg14r01AGqgOy+UNXCllB/iiAHyCNN+p46FFkUqoXLhpqhv7Zbajl0YqqxZJNlpTgp7UTMG4N7NpAN5Gd51gTNJVK5/KkwvXzpGczFcVYHO4H65WmpMgZ68T8k3FsRNRGB2Bj3q4Y6sB7uib2QtvUEcilsmBc8IgSNBE0WbTawbmGaOaYaWm52kDNDPic8G/LXtyJEjggtDRjEmT5/RSzMsd7TGjdYTgb3ZdK4GXplIZWysvop32DySrA2CoJEILjRCyzg9bzHCn4Ipk/yE7uN3l6l3AJ1mpvA3SwNeWBNmPASBQAl0GUsS3JdmahQVmLRq4/YGkfXG3YdLwDluF5xz4Jw/C0=
X-MS-Exchange-AntiSpam-MessageData: oyzu60o7eqPP9ffPej3aX1ICsRfF1bvYLjheGd8XlXJHDmAaz92CHXA5W6E91NqnSl8YzVdhIgDS4fPr1XtvK+NEYcBzmt9AQfo5l4lvqHcXt2sdKqXj8WkxunEmouCrYqdGJ5G+VHJltv6XxZzz6w==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5e44de-fa6f-491e-21e2-08d944936fe5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2021 17:43:48.3350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR06FT063.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR06HT159
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This introduces signal->exec_bprm, which is used to
fix the case when at least one of the sibling threads
is traced, and therefore the trace process may dead-lock
in ptrace_attach, but de_thread will need to wait for the
tracer to continue execution.

The solution is to detect this situation and allow
ptrace_attach to continue by temporarily releasing the
cred_guard_mutex, while de_thread() is still waiting for
traced zombies to be eventually released by the tracer.
In the case of the thread group leader we only have to wait
for the thread to become a zombie, which may also need
co-operation from the tracer due to PTRACE_O_TRACEEXIT.

When a tracer wants to ptrace_attach a task that already
is in execve, we simply retry the ptrace_may_access
check while temporarily installing the new credentials
and dumpability which are about to be used after execve
completes.  If the ptrace_attach happens on a thread that
is a sibling-thread of the thread doing execve, it is
sufficient to check against the old credentials, as this
thread will be waited for, before the new credentials are
installed.

Other threads die quickly since the cred_guard_mutex is
released, but a deadly signal is already pending.  In case
the mutex_lock_killable misses the signal, the non-zero
current->signal->exec_bprm makes sure they release the
mutex immediately and return with -ERESTARTNOINTR.

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
 fs/exec.c                                 | 69 ++++++++++++++++++++++---------
 fs/proc/base.c                            |  6 +++
 include/linux/cred.h                      |  1 +
 include/linux/sched/signal.h              | 18 ++++++++
 kernel/cred.c                             | 28 ++++++++++---
 kernel/ptrace.c                           | 32 ++++++++++++++
 kernel/seccomp.c                          | 12 ++++--
 tools/testing/selftests/ptrace/vmaccess.c | 23 +++++++----
 8 files changed, 155 insertions(+), 34 deletions(-)

v8: retry execve with returning -ERESTARTSYS after PTRACE_ATTACH.

v9: fixed a race condition in v8.

v10: Changes to previous version, make the PTRACE_ATTACH
retun -EAGAIN, instead of execve return -ERESTARTSYS.
Added some lessions learned to the description.

v11: Check old and new credentials in PTRACE_ATTACH again without
changing the API.


Note: v8+v9 are more or less fundamentally broken, the longer I
look at them.

v10 is not really broken but does unfortunately imply an API change.

v11 is passing the new credentials to PTRACE_ATTACH and would avoid
the API change.

The difficult part is getting the right dumpability flags assigned
before de_thread starts, hope you like this version.
If not, the v10 is of course also acceptable.


Thanks
Bernd.

diff --git a/fs/exec.c b/fs/exec.c
index 8344fba..2c7415d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1035,11 +1035,13 @@ static int exec_mmap(struct mm_struct *mm)
 	return 0;
 }
 
-static int de_thread(struct task_struct *tsk)
+static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
 {
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	struct task_struct *t = tsk;
+	bool unsafe_execve_in_progress = false;
 
 	if (thread_group_empty(tsk))
 		goto no_thread_group;
@@ -1062,6 +1064,19 @@ static int de_thread(struct task_struct *tsk)
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
 
+	while_each_thread(tsk, t) {
+		if (unlikely(t->ptrace)
+		    && (t != tsk->group_leader || !t->exit_state))
+			unsafe_execve_in_progress = true;
+	}
+
+	if (unlikely(unsafe_execve_in_progress)) {
+		spin_unlock_irq(lock);
+		sig->exec_bprm = bprm;
+		mutex_unlock(&sig->cred_guard_mutex);
+		spin_lock_irq(lock);
+	}
+
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
@@ -1152,6 +1167,11 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
+	if (unlikely(unsafe_execve_in_progress)) {
+		mutex_lock(&sig->cred_guard_mutex);
+		sig->exec_bprm = NULL;
+	}
+
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
 
@@ -1163,6 +1183,11 @@ static int de_thread(struct task_struct *tsk)
 	return 0;
 
 killed:
+	if (unlikely(unsafe_execve_in_progress)) {
+		mutex_lock(&sig->cred_guard_mutex);
+		sig->exec_bprm = NULL;
+	}
+
 	/* protects against exit_notify() and __exit_signal() */
 	read_lock(&tasklist_lock);
 	sig->group_exit_task = NULL;
@@ -1246,6 +1271,24 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		return retval;
 
+	/* If the binary is not readable then enforce mm->dumpable=0 */
+	would_dump(bprm, bprm->file);
+	if (bprm->have_execfd)
+		would_dump(bprm, bprm->executable);
+
+	/*
+	 * Figure out dumpability. Note that this checking only of current
+	 * is wrong, but userspace depends on it. This should be testing
+	 * bprm->secureexec instead.
+	 */
+	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
+	    is_dumpability_changed(current_cred(), bprm->cred) ||
+	    !(uid_eq(current_euid(), current_uid()) &&
+	      gid_eq(current_egid(), current_gid())))
+		set_dumpable(bprm->mm, suid_dumpable);
+	else
+		set_dumpable(bprm->mm, SUID_DUMP_USER);
+
 	/*
 	 * Ensure all future errors are fatal.
 	 */
@@ -1254,7 +1297,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	/*
 	 * Make this the only thread in the thread group.
 	 */
-	retval = de_thread(me);
+	retval = de_thread(me, bprm);
 	if (retval)
 		goto out;
 
@@ -1275,11 +1318,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	set_mm_exe_file(bprm->mm, bprm->file);
 
-	/* If the binary is not readable then enforce mm->dumpable=0 */
-	would_dump(bprm, bprm->file);
-	if (bprm->have_execfd)
-		would_dump(bprm, bprm->executable);
-
 	/*
 	 * Release all of the old mmap stuff
 	 */
@@ -1340,18 +1378,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	me->sas_ss_sp = me->sas_ss_size = 0;
 
-	/*
-	 * Figure out dumpability. Note that this checking only of current
-	 * is wrong, but userspace depends on it. This should be testing
-	 * bprm->secureexec instead.
-	 */
-	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
-	    !(uid_eq(current_euid(), current_uid()) &&
-	      gid_eq(current_egid(), current_gid())))
-		set_dumpable(current->mm, suid_dumpable);
-	else
-		set_dumpable(current->mm, SUID_DUMP_USER);
-
 	perf_event_exec();
 	__set_task_comm(me, kbasename(bprm->filename), true);
 
@@ -1466,6 +1492,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
 		return -ERESTARTNOINTR;
 
+	if (unlikely(current->signal->exec_bprm)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		return -ERESTARTNOINTR;
+	}
+
 	bprm->cred = prepare_exec_creds();
 	if (likely(bprm->cred))
 		return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9cbd915..3c9c8e8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2750,6 +2750,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
+	if (unlikely(current->signal->exec_bprm)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		rv = -ERESTARTNOINTR;
+		goto out_free;
+	}
+
 	rv = security_setprocattr(PROC_I(inode)->op.lsm,
 				  file->f_path.dentry->d_name.name, page,
 				  count);
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 1497132..5ee3fbc 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -158,6 +158,7 @@ struct cred {
 extern struct cred *cred_alloc_blank(void);
 extern struct cred *prepare_creds(void);
 extern struct cred *prepare_exec_creds(void);
+extern bool is_dumpability_changed(const struct cred *, const struct cred *);
 extern int commit_creds(struct cred *);
 extern void abort_creds(struct cred *);
 extern const struct cred *override_creds(const struct cred *);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7f4278f..771ddac 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -224,9 +224,27 @@ struct signal_struct {
 	struct mm_struct *oom_mm;	/* recorded mm when the thread group got
 					 * killed by the oom killer */
 
+	struct linux_binprm *exec_bprm;	/* Used to check ptrace_may_access
+					 * against new credentials while
+					 * de_thread is waiting for other
+					 * traced threads to terminate.
+					 * Set while de_thread is executing.
+					 * The cred_guard_mutex is released
+					 * after de_thread() has called
+					 * zap_other_threads(), therefore
+					 * a fatal signal is guaranteed to be
+					 * already pending in the unlikely
+					 * event, that
+					 * current->signal->exec_bprm happens
+					 * to be non-zero after the
+					 * cred_guard_mutex was acquired.
+					 */
+
 	struct mutex cred_guard_mutex;	/* guard against foreign influences on
 					 * credential calculations
 					 * (notably. ptrace)
+					 * Held while execve runs, except when
+					 * a sibling thread is being traced.
 					 * Deprecated do not use in new code.
 					 * Use exec_update_lock instead.
 					 */
diff --git a/kernel/cred.c b/kernel/cred.c
index e1d274cd7..347c527 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -421,6 +421,28 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
 }
 
 /**
+ * is_dumpability_changed - Will changing creds from old to new
+ * affect the dumpability in commit_creds?
+ *
+ * Return: false - dumpability will not be changed in commit_creds.
+ * Return: true  - dumpability will be changed to non-dumpable.
+ *
+ * @old: The old credentials
+ * @new: The new credentials
+ */
+bool is_dumpability_changed(const struct cred *old, const struct cred *new)
+{
+	if (!uid_eq(old->euid, new->euid) ||
+	    !gid_eq(old->egid, new->egid) ||
+	    !uid_eq(old->fsuid, new->fsuid) ||
+	    !gid_eq(old->fsgid, new->fsgid) ||
+	    !cred_cap_issubset(old, new))
+		return true;
+
+	return false;
+}
+
+/**
  * commit_creds - Install new credentials upon the current task
  * @new: The credentials to be assigned
  *
@@ -454,11 +476,7 @@ int commit_creds(struct cred *new)
 	get_cred(new); /* we will require a ref for the subj creds too */
 
 	/* dumpability changes */
-	if (!uid_eq(old->euid, new->euid) ||
-	    !gid_eq(old->egid, new->egid) ||
-	    !uid_eq(old->fsuid, new->fsuid) ||
-	    !gid_eq(old->fsgid, new->fsgid) ||
-	    !cred_cap_issubset(old, new)) {
+	if (is_dumpability_changed(old, new)) {
 		if (task->mm)
 			set_dumpable(task->mm, suid_dumpable);
 		task->pdeath_signal = 0;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2997ca6..df45ddcd 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -20,6 +20,7 @@
 #include <linux/pagemap.h>
 #include <linux/ptrace.h>
 #include <linux/security.h>
+#include <linux/binfmts.h>
 #include <linux/signal.h>
 #include <linux/uio.h>
 #include <linux/audit.h>
@@ -412,6 +413,28 @@ static int ptrace_attach(struct task_struct *task, long request,
 	if (retval)
 		goto unlock_creds;
 
+	if (unlikely(task->in_execve)) {
+		struct linux_binprm *bprm = task->signal->exec_bprm;
+		const struct cred *old_cred;
+		struct mm_struct *old_mm;
+
+		retval = down_write_killable(&task->signal->exec_update_lock);
+		if (retval)
+			goto unlock_creds;
+		task_lock(task);
+		old_cred = task->real_cred;
+		old_mm = task->mm;
+		rcu_assign_pointer(task->real_cred, bprm->cred);
+		task->mm = bprm->mm;
+		retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+		rcu_assign_pointer(task->real_cred, old_cred);
+		task->mm = old_mm;
+		task_unlock(task);
+		up_write(&task->signal->exec_update_lock);
+		if (retval)
+			goto unlock_creds;
+	}
+
 	write_lock_irq(&tasklist_lock);
 	retval = -EPERM;
 	if (unlikely(task->exit_state))
@@ -485,6 +508,14 @@ static int ptrace_traceme(void)
 {
 	int ret = -EPERM;
 
+	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
+		return -ERESTARTNOINTR;
+
+	if (unlikely(current->signal->exec_bprm)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		return -ERESTARTNOINTR;
+	}
+
 	write_lock_irq(&tasklist_lock);
 	/* Are we already being traced? */
 	if (!current->ptrace) {
@@ -500,6 +531,7 @@ static int ptrace_traceme(void)
 		}
 	}
 	write_unlock_irq(&tasklist_lock);
+	mutex_unlock(&current->signal->cred_guard_mutex);
 
 	return ret;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 9f58049..42799a0 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1833,9 +1833,15 @@ static long seccomp_set_mode_filter(unsigned int flags,
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
+		if (unlikely(current->signal->exec_bprm)) {
+			mutex_unlock(&current->signal->cred_guard_mutex);
+			goto out_put_fd;
+		}
+	}
 
 	spin_lock_irq(&current->sighand->siglock);
 
diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
index 4db327b..3b7d81fb 100644
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
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
 	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, 0);
 	ASSERT_EQ(k, pid);
 	ASSERT_EQ(WIFSTOPPED(s), 1);
 	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
-	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
 	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, 0);
 	ASSERT_EQ(k, pid);
-- 
1.9.1

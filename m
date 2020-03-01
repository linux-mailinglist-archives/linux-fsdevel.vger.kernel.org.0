Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088C0174CFB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 12:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCAL13 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 1 Mar 2020 06:27:29 -0500
Received: from mail-oln040092073096.outbound.protection.outlook.com ([40.92.73.96]:28485
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbgCAL12 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 06:27:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixcmuX5hqtxt8d65hizu3O7ImsEA0pJ5ODvEeTjvTKwKRb9+Cv9skDCVWra2WS9O8O3TYpY7Dct3JKhVmAu6QH8gLyMG9+/XSYbax7mWv1z1PGowoQOMBCECcPSWAphvBDsBUmqZRfQ+m9/JIAekJZNwCXHGklF8yuWMXIbRcxjWa5p6vW/1xGBa8RL7DC4i2oUGuJr+ZgTMP9vak3CS0f3rTL310hodIdWEORErHdMQwtv56STuGe1BjaWssZJxnB3jrIG8+NkRp7jvhYptB2A2JlyoUtaEC2vJZkQLfHlJR0QzKNThvUiXK+4NyUqcAbFtIHETvhYu4FlNKr0VSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yORDbcV5Lq6jDYNRZepgBEneqeE2wbwuz3ycRFaqus=;
 b=oer1KuTvv2UoF0MfCQS9Ex3gO50U3sUrTRlW3bUwHpxelnNFkpsX72fdy2irbDaowVrao05Y8y+2Z5KrE6/ZVSGqJRJ4qbeoXodbk+fAWtGtvG97k8rtK4Wiw2IIjhbYoJRW+3mIXRTSmj/CaKK03pz/CPg/E2IAcRs7k469rbwgdwycR1LSyfteq4yT0kUM/WkfJJr2o71wDqNucpt8p6N2OYCaxdPgoVWCNJJRIq6nx4RFl9aIUKxXxFihH8wAXQmY5CNQ8am8JkxHKkMkogGs8NmPzSWrhaZREXoqtrLJIoCRIHTZPZTbNuY/wZUC57v2Z8vktjfpiZeVz0PxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB3EUR04FT043.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0c::35) by
 DB3EUR04HT053.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0c::326)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Sun, 1 Mar
 2020 11:27:19 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com (10.152.24.59) by
 DB3EUR04FT043.mail.protection.outlook.com (10.152.25.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Sun, 1 Mar 2020 11:27:19 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::1956:d274:cab3:b4dd]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::1956:d274:cab3:b4dd%6]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 11:27:19 +0000
Received: from [192.168.1.101] (92.77.140.102) by AM0PR05CA0055.eurprd05.prod.outlook.com (2603:10a6:208:be::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16 via Frontend Transport; Sun, 1 Mar 2020 11:27:16 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [PATCH] exec: Fix a deadlock in ptrace
Thread-Topic: [PATCH] exec: Fix a deadlock in ptrace
Thread-Index: AQHV77xesuLGQPzl+kmhVsL8mVFkuw==
Date:   Sun, 1 Mar 2020 11:27:18 +0000
Message-ID: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR05CA0055.eurprd05.prod.outlook.com
 (2603:10a6:208:be::32) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
x-incomingtopheadermarker: OriginalChecksum:A599C26DD226E0EDED3C4092BF4CFBFD72E5EDE84A51D647B7B724D9A44DAE68;UpperCasedChecksum:1BD6262FD36A574130568C2C110984A874F2DE2A25EB494B48F7AA478A525256;SizeAsReceived:8660;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [PogcoD09EjsUiwiAWvD5co+pXpV8oyVk]
x-microsoft-original-message-id: <7fc23f9e-e76c-34bb-6ad8-8bb40cab2a8a@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 428ddd92-4d6d-4bc3-74f1-08d7bdd38064
x-ms-traffictypediagnostic: DB3EUR04HT053:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Po2iZl4Ny7dOQc80OUMo+tbZ2CkHkSKxPvduDFjBgJ6xMLX+DVkdLk91JzrekHCqTHAx9ZrFi6/yGrBPB0QfS7Q6QnT/GNwL5oWzc6V6HfcjV4DHY2hHsVDxAV84wVlYNpV0QfSUpqbYUQoJeFuyVmMnzYgVKPUcxzMTY6diA7bbuAT4jwdweVj9EHNgbPxX
x-ms-exchange-antispam-messagedata: LyotnHtVpDGlj615zQAk//1+FlXkYyq9Pf7yob7l2mZqclWE3eGWs3po0AULOUgiNk+MszRJeQT94YQmwTMjoHjgTKpJ+igFCH63ghoP3LNbKarmxdyQxPvCcq3TF99g5VFgnyo4nV96G/RM6vawTA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6B03745694A187438FC7C99F7614CE7C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 428ddd92-4d6d-4bc3-74f1-08d7bdd38064
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 11:27:18.9988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3EUR04HT053
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This fixes a deadlock in the tracer when tracing a multi-threaded
application that calls execve while more than one thread are running.

I observed that when running strace on the gcc test suite, it always
blocks after a while, when expect calls execve, because other threads
have to be terminated.  They send ptrace events, but the strace is no
longer able to respond, since it is blocked in vm_access.

The deadlock is always happening when strace needs to access the
tracees process mmap, while another thread in the tracee starts to
execve a child process, but that cannot continue until the
PTRACE_EVENT_EXIT is handled and the WIFEXITED event is received:

strace          D    0 30614  30584 0x00000000
Call Trace:
__schedule+0x3ce/0x6e0
schedule+0x5c/0xd0
schedule_preempt_disabled+0x15/0x20
__mutex_lock.isra.13+0x1ec/0x520
__mutex_lock_killable_slowpath+0x13/0x20
mutex_lock_killable+0x28/0x30
mm_access+0x27/0xa0
process_vm_rw_core.isra.3+0xff/0x550
process_vm_rw+0xdd/0xf0
__x64_sys_process_vm_readv+0x31/0x40
do_syscall_64+0x64/0x220
entry_SYSCALL_64_after_hwframe+0x44/0xa9

expect          D    0 31933  30876 0x80004003
Call Trace:
__schedule+0x3ce/0x6e0
schedule+0x5c/0xd0
flush_old_exec+0xc4/0x770
load_elf_binary+0x35a/0x16c0
search_binary_handler+0x97/0x1d0
__do_execve_file.isra.40+0x5d4/0x8a0
__x64_sys_execve+0x49/0x60
do_syscall_64+0x64/0x220
entry_SYSCALL_64_after_hwframe+0x44/0xa9

The proposed solution is to have a second mutex that is
used in mm_access, so it is allowed to continue while the
dying threads are not yet terminated.

I also took the opportunity to improve the documentation
of prepare_creds, which is obviously out of sync.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 Documentation/security/credentials.rst | 18 ++++++++++--------
 fs/exec.c                              |  9 +++++++++
 include/linux/binfmts.h                |  6 +++++-
 include/linux/sched/signal.h           |  1 +
 init/init_task.c                       |  1 +
 kernel/cred.c                          |  2 +-
 kernel/fork.c                          |  5 +++--
 mm/process_vm_access.c                 |  2 +-
 8 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
index 282e79f..c98e0a8 100644
--- a/Documentation/security/credentials.rst
+++ b/Documentation/security/credentials.rst
@@ -437,9 +437,13 @@ new set of credentials by calling::
 
 	struct cred *prepare_creds(void);
 
-this locks current->cred_replace_mutex and then allocates and constructs a
-duplicate of the current process's credentials, returning with the mutex still
-held if successful.  It returns NULL if not successful (out of memory).
+this allocates and constructs a duplicate of the current process's credentials.
+It returns NULL if not successful (out of memory).
+
+If called from __do_execve_file, the mutex current->signal->cred_guard_mutex
+is acquired before this function gets called, and the mutex
+current->signal->cred_change_mutex is acquired later, while the credentials
+and the process mmap are actually changed.
 
 The mutex prevents ``ptrace()`` from altering the ptrace state of a process
 while security checks on credentials construction and changing is taking place
@@ -466,9 +470,8 @@ by calling::
 
 This will alter various aspects of the credentials and the process, giving the
 LSM a chance to do likewise, then it will use ``rcu_assign_pointer()`` to
-actually commit the new credentials to ``current->cred``, it will release
-``current->cred_replace_mutex`` to allow ``ptrace()`` to take place, and it
-will notify the scheduler and others of the changes.
+actually commit the new credentials to ``current->cred``, and it will notify
+the scheduler and others of the changes.
 
 This function is guaranteed to return 0, so that it can be tail-called at the
 end of such functions as ``sys_setresuid()``.
@@ -486,8 +489,7 @@ invoked::
 
 	void abort_creds(struct cred *new);
 
-This releases the lock on ``current->cred_replace_mutex`` that
-``prepare_creds()`` got and then releases the new credentials.
+This releases the new credentials.
 
 
 A typical credentials alteration function would look something like this::
diff --git a/fs/exec.c b/fs/exec.c
index 74d88da..a6884e4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1266,6 +1266,12 @@ int flush_old_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	retval = mutex_lock_killable(&current->signal->cred_change_mutex);
+	if (retval)
+		goto out;
+
+	bprm->called_flush_old_exec = 1;
+
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
 	 * not visibile until then. This also enables the update
@@ -1420,6 +1426,8 @@ static void free_bprm(struct linux_binprm *bprm)
 {
 	free_arg_pages(bprm);
 	if (bprm->cred) {
+		if (bprm->called_flush_old_exec)
+			mutex_unlock(&current->signal->cred_change_mutex);
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
@@ -1469,6 +1477,7 @@ void install_exec_creds(struct linux_binprm *bprm)
 	 * credentials; any time after this it may be unlocked.
 	 */
 	security_bprm_committed_creds(bprm);
+	mutex_unlock(&current->signal->cred_change_mutex);
 	mutex_unlock(&current->signal->cred_guard_mutex);
 }
 EXPORT_SYMBOL(install_exec_creds);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index b40fc63..2e1318b 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -44,7 +44,11 @@ struct linux_binprm {
 		 * exec has happened. Used to sanitize execution environment
 		 * and to set AT_SECURE auxv for glibc.
 		 */
-		secureexec:1;
+		secureexec:1,
+		/*
+		 * Set by flush_old_exec, when the cred_change_mutex is taken.
+		 */
+		called_flush_old_exec:1;
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 8805025..37eeabe 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -225,6 +225,7 @@ struct signal_struct {
 	struct mutex cred_guard_mutex;	/* guard against foreign influences on
 					 * credential calculations
 					 * (notably. ptrace) */
+	struct mutex cred_change_mutex; /* guard against credentials change */
 } __randomize_layout;
 
 /*
diff --git a/init/init_task.c b/init/init_task.c
index 9e5cbe5..6cd9a0f 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -26,6 +26,7 @@
 	.multiprocess	= HLIST_HEAD_INIT,
 	.rlim		= INIT_RLIMITS,
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
+	.cred_change_mutex = __MUTEX_INITIALIZER(init_signals.cred_change_mutex),
 #ifdef CONFIG_POSIX_TIMERS
 	.posix_timers = LIST_HEAD_INIT(init_signals.posix_timers),
 	.cputimer	= {
diff --git a/kernel/cred.c b/kernel/cred.c
index 809a985..e4c78de 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -676,7 +676,7 @@ void __init cred_init(void)
  *
  * Returns the new credentials or NULL if out of memory.
  *
- * Does not take, and does not return holding current->cred_replace_mutex.
+ * Does not take, and does not return holding ->cred_guard_mutex.
  */
 struct cred *prepare_kernel_cred(struct task_struct *daemon)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 0808095..0395154 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1224,7 +1224,7 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 	struct mm_struct *mm;
 	int err;
 
-	err =  mutex_lock_killable(&task->signal->cred_guard_mutex);
+	err =  mutex_lock_killable(&task->signal->cred_change_mutex);
 	if (err)
 		return ERR_PTR(err);
 
@@ -1234,7 +1234,7 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 		mmput(mm);
 		mm = ERR_PTR(-EACCES);
 	}
-	mutex_unlock(&task->signal->cred_guard_mutex);
+	mutex_unlock(&task->signal->cred_change_mutex);
 
 	return mm;
 }
@@ -1594,6 +1594,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	sig->oom_score_adj_min = current->signal->oom_score_adj_min;
 
 	mutex_init(&sig->cred_guard_mutex);
+	mutex_init(&sig->cred_change_mutex);
 
 	return 0;
 }
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 357aa7b..b3e6eb5 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -204,7 +204,7 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
 	if (!mm || IS_ERR(mm)) {
 		rc = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
 		/*
-		 * Explicitly map EACCES to EPERM as EPERM is a more a
+		 * Explicitly map EACCES to EPERM as EPERM is a more
 		 * appropriate error code for process_vw_readv/writev
 		 */
 		if (rc == -EACCES)
-- 
1.9.1

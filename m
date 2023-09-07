Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F25797D89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbjIGUoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjIGUoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:44:07 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340CA1BCB;
        Thu,  7 Sep 2023 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=na/YxXTVI1qQn9ck4pZ96HjTGea7ATsA0kF9+ebpm6c=; b=LHcbIienhvTZv+5F/Vf5xwc6pC
        spUQLd/GIbdkYAu6DvoObPDj07HEk2p560gaB5knXz4Zgd6BORvNQckIWcQUIdJOOKZVDh9qm83mM
        qeHz7Iaro6BYMkTckJ/QwofhTDC7JCnkFDHx1MwigfWPuu+HSEN5udGsvdAph8iDjgNikWxOJRi3m
        wZVLIu46o4AgsjypAcWyGcMeOsVh908anGDWbl9uMlIqz7eLNyl3WJ59j1y955y9dhLD8DB/cl8wE
        +5UEMGIp6mWVT4AqKRFjtbRIESeMxYJb3d9tBRv+wzL13iszbcT8X46cF8AeG/HSndOkddqGsZodt
        RROgYafQ==;
Received: from [179.232.147.2] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qeLr0-000goj-4i; Thu, 07 Sep 2023 22:43:54 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        keescook@chromium.org, ebiederm@xmission.com, oleg@redhat.com,
        yzaikin@google.com, mcgrof@kernel.org, akpm@linux-foundation.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, willy@infradead.org,
        david@redhat.com, dave@stgolabs.net, sonicadvance1@gmail.com,
        joshua@froggi.es, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [RFC PATCH 2/2] fork, procfs: Introduce /proc/self/interpreter symlink
Date:   Thu,  7 Sep 2023 17:24:51 -0300
Message-ID: <20230907204256.3700336-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907204256.3700336-1-gpiccoli@igalia.com>
References: <20230907204256.3700336-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we have the /proc/self/exe_file symlink, that points
to the executable binary of the running process - or to the
*interpreted* file if flag 'I' is set on binfmt_misc. In this
second case, we then lose the ability of having a symlink to
the interpreter.

Introduce hereby the /proc/self/interpreter symlink which always
points to the *interpreter* when we're under interpretation, like
on binfmt_misc use. We don't require to have a new file pointer
since mm_struct contains exe_file, which points to such interpreter.

Suggested-by: Ryan Houdek <sonicadvance1@gmail.com>
Tested-by: Ryan Houdek <sonicadvance1@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Design choices / questions:

(a) The file /proc/self/interpreter is always present, and in
most cases, points to nothing (since we're running an ELF binary,
with no interpreter!). Is it OK? The implementation follows the
pattern of /proc/self/exe_file, returns -ENOENT when we have
no interpreter. I'm not sure if there's a way to implement this
as a procfs file that is not always visible, i.e., it would only
show up if such interpreter exists. If that would be possible,
is it better than the current implementation though? Also, we could
somehow make /proc/self/interpreter points to the LD preloader for
ELFs, if that's considered a better approach.

(b) I like xmacros to avoid repeating code, but I'm totally
fine changing that as well as naming of stuff.

(c) Should we extend functionality present on exe_file to
the interpreter, like prctl replacing mechanism, audit info
collection, etc?

Any feedback here is greatly appreciated - thanks in advance!
Cheers,

Guilherme


 fs/exec.c                |  8 +++++++
 fs/proc/base.c           | 48 ++++++++++++++++++++++++++--------------
 include/linux/binfmts.h  |  1 +
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h |  1 +
 kernel/fork.c            | 26 ++++++++++++++++++++++
 6 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index bb1574f37b67..39f9c86d5ebc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1285,6 +1285,13 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	/*
+	 * In case we're in an interpreted scenario (like binfmt_misc,
+	 * for example), flag it on mm_struct in order to expose such
+	 * interpreter as the symlink /proc/self/interpreter.
+	 */
+	bprm->mm->has_interpreter = bprm->has_interpreter;
+
 	/* If the binary is not readable then enforce mm->dumpable=0 */
 	would_dump(bprm, bprm->file);
 	if (bprm->have_execfd)
@@ -1796,6 +1803,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 
 		exec = bprm->file;
 		bprm->file = bprm->interpreter;
+		bprm->has_interpreter = true;
 		bprm->interpreter = NULL;
 
 		allow_write_access(exec);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index a13fbfc46997..ecd5ea05acb0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1719,25 +1719,39 @@ static const struct file_operations proc_pid_set_comm_operations = {
 	.release	= single_release,
 };
 
-static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
+static struct file *proc_get_task_exe_file(struct task_struct *task)
 {
-	struct task_struct *task;
-	struct file *exe_file;
-
-	task = get_proc_task(d_inode(dentry));
-	if (!task)
-		return -ENOENT;
-	exe_file = get_task_exe_file(task, true);
-	put_task_struct(task);
-	if (exe_file) {
-		*exe_path = exe_file->f_path;
-		path_get(&exe_file->f_path);
-		fput(exe_file);
-		return 0;
-	} else
-		return -ENOENT;
+	return get_task_exe_file(task, true);
 }
 
+static struct file *proc_get_task_interpreter_file(struct task_struct *task)
+{
+	return get_task_interpreter_file(task);
+}
+
+/* Definition of proc_exe_link and proc_interpreter_link. */
+#define PROC_GET_LINK_FUNC(type) \
+static int proc_##type##_link(struct dentry *dentry, struct path *path)	\
+{									\
+	struct task_struct *task;					\
+	struct file *file;						\
+									\
+	task = get_proc_task(d_inode(dentry));				\
+	if (!task)							\
+		return -ENOENT;						\
+	file = proc_get_task_##type##_file(task);			\
+	put_task_struct(task);						\
+	if (file) {							\
+		*path = file->f_path;					\
+		path_get(&file->f_path);				\
+		fput(file);						\
+		return 0;						\
+	} else								\
+		return -ENOENT;						\
+}
+PROC_GET_LINK_FUNC(exe);
+PROC_GET_LINK_FUNC(interpreter);
+
 static const char *proc_pid_get_link(struct dentry *dentry,
 				     struct inode *inode,
 				     struct delayed_call *done)
@@ -3276,6 +3290,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	LNK("cwd",        proc_cwd_link),
 	LNK("root",       proc_root_link),
 	LNK("exe",        proc_exe_link),
+	LNK("interpreter", proc_interpreter_link),
 	REG("mounts",     S_IRUGO, proc_mounts_operations),
 	REG("mountinfo",  S_IRUGO, proc_mountinfo_operations),
 	REG("mountstats", S_IRUSR, proc_mountstats_operations),
@@ -3626,6 +3641,7 @@ static const struct pid_entry tid_base_stuff[] = {
 	LNK("cwd",       proc_cwd_link),
 	LNK("root",      proc_root_link),
 	LNK("exe",       proc_exe_link),
+	LNK("interpreter", proc_interpreter_link),
 	REG("mounts",    S_IRUGO, proc_mounts_operations),
 	REG("mountinfo",  S_IRUGO, proc_mountinfo_operations),
 #ifdef CONFIG_PROC_PAGE_MONITOR
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 5dde52de7877..2362c6bc6ead 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -46,6 +46,7 @@ struct linux_binprm {
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
 	struct file *interpreted_file; /* only for binfmt_misc with flag I */
+	bool has_interpreter; /* In order to expose /proc/self/interpreter */
 	struct file *file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a00b32906604..e06b703db494 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3261,6 +3261,7 @@ extern int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file);
 extern struct file *get_mm_exe_file(struct mm_struct *mm);
 extern struct file *get_task_exe_file(struct task_struct *task,
 				      bool prefer_interpreted);
+extern struct file *get_task_interpreter_file(struct task_struct *task);
 
 extern bool may_expand_vm(struct mm_struct *, vm_flags_t, unsigned long npages);
 extern void vm_stat_account(struct mm_struct *, vm_flags_t, long npages);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 346f81875f3e..19a73c41991c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -843,6 +843,7 @@ struct mm_struct {
 		/* store ref to file /proc/<pid>/exe symlink points to */
 		struct file __rcu *exe_file;
 		struct file __rcu *interpreted_file; /* see binfmt_misc flag I */
+		bool has_interpreter; /* exposes (or not) /proc/self/interpreter */
 #ifdef CONFIG_MMU_NOTIFIER
 		struct mmu_notifier_subscriptions *notifier_subscriptions;
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 8c4824dcc433..5cb542f92d5e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1568,6 +1568,32 @@ struct file *get_task_exe_file(struct task_struct *task,
 	return exe_file;
 }
 
+/**
+ * get_task_interpreter_file - acquire a reference to the task's *interpreter*
+ * executable (which is in fact the exe_file on mm_struct!). This is used in
+ * order to expose /proc/self/interpreter, if we're under an interpreted
+ * scenario (like binfmt_misc).
+ *
+ * Returns %NULL if exe_file is not an interpreter (i.e., it is the truly
+ * running binary indeed).
+ */
+struct file *get_task_interpreter_file(struct task_struct *task)
+{
+	struct file *interpreter_file = NULL;
+	struct mm_struct *mm;
+
+	task_lock(task);
+
+	mm = task->mm;
+	if (mm && mm->has_interpreter) {
+		if (!(task->flags & PF_KTHREAD))
+			interpreter_file = get_mm_exe_file(mm);
+	}
+
+	task_unlock(task);
+	return interpreter_file;
+}
+
 /**
  * get_task_mm - acquire a reference to the task's mm
  *
-- 
2.42.0


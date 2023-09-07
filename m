Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C92797D86
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239911AbjIGUno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjIGUnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:43:43 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23E1BD7;
        Thu,  7 Sep 2023 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1614qr0a3xvZg52JkdN3J4gqei97vnZdO0WxcgdVcIc=; b=ZaiAn2GwvSjVTVg3aUFddeQAot
        pT5bNqn57LVLF5TGI0vaVdAGW2OXM2XdAkJLv6JL7wknhRg7BuOnJhaPtBp9d9IWwQ0jg83jbxI71
        7DUhcvHY+iOII3BMuLTAiZ4SHwoH/p5QBjwNGwR5wTN3dNl2lv6Rxt6At6IKMjUE5CyBkWftDVzyU
        9mWsgNOxmD934tsNGsCrmFTCq3ckGoiMF7PjJdaQcrfGipIh9wxMMBDNzv6CusNz4p7AgcxxmMhVY
        F69XCJVrIPrFIcQwiifB1FK1fdh6648rFQVA2TrwpfHM4CGSx/vkYzkIT99GD0hgeudhBX0KCuf3z
        DNaVrldA==;
Received: from [179.232.147.2] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qeLqg-000goK-J3; Thu, 07 Sep 2023 22:43:34 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        keescook@chromium.org, ebiederm@xmission.com, oleg@redhat.com,
        yzaikin@google.com, mcgrof@kernel.org, akpm@linux-foundation.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, willy@infradead.org,
        david@redhat.com, dave@stgolabs.net, sonicadvance1@gmail.com,
        joshua@froggi.es, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [RFC PATCH 1/2] binfmt_misc, fork, proc: Introduce flag to expose the interpreted binary in procfs
Date:   Thu,  7 Sep 2023 17:24:50 -0300
Message-ID: <20230907204256.3700336-2-gpiccoli@igalia.com>
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

The procfs symlink /proc/self/exe_file points to the executable binary
of the running process/thread. What happens though for binfmt_misc
interpreted cases is that it effectively points to the *interpreter*,
which is valid as the interpreter is in fact the one binary running.

But there are cases in which this is considered a limitation - see for
example the case of Linux architecture emulators, like FEX [0]. A binary
running under such emulator could check its own symlink, and that'd
be invalid, pointing instead to the emulator (its interpreter).
This adds overhead to the emulation process, that must trap accesses
to such symlink to guarantee it is exposed properly to the emulated binary.

Add hereby the flag 'I' to binfmt_misc to allow override this default
behavior of mapping the interpreter as /proc/self/exe - with this flag,
the *interpreted* file is exposed in procfs instead.

[0] https://github.com/FEX-Emu/FEX

Suggested-by: Ryan Houdek <sonicadvance1@gmail.com>
Tested-by: Ryan Houdek <sonicadvance1@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Some design decisions / questions:

(a) The patch makes use of interpreted_file == NULL to diverge if
the flag is set or not. In other words: in any case but binfmt_misc
with flag 'I' set, this pointer is NULL and the real exe_file
is retrieved. This way, we don't need to propagate some flag from the
ends of binfmt_misc up to procfs code. Does it make sense?

(b) Of course there's various places affected by this change that
I'm not sure if we should care or not, i.e., if we need to somehow
change the behavior as well. Examples are audit code, tomoyo, etc.
Even worse is the case of users setting the exe_file through prctl;
what to do in these cases? I've marked them on code using comments
starting with FIXME (BINPRM_FLAGS_EXPOSE_INTERP) so we can debate.

(c) Keeping interpreted_file on mm_struct *seems* to make sense
to me, though I'm not really sure of the impact of this new
member there, for cache locality or anything else I'm not seeing.
An alternative would be a small struct exec_files{} that contains
both exe_file and interpreted_file, if that's somehow better...

(d) Naming: both "interpreted_file" and the flag "I" were simple
choices and subject to change to any community suggestion, I'm not
attached to them in any way.

Probably there's more implicit design decisions here and any feedback
is greatly appreciated! Thanks in advance,

Guilherme


 Documentation/admin-guide/binfmt-misc.rst |  11 +++
 arch/arc/kernel/troubleshoot.c            |   5 ++
 fs/binfmt_elf.c                           |   7 ++
 fs/binfmt_misc.c                          |  11 +++
 fs/coredump.c                             |   5 ++
 fs/exec.c                                 |  18 +++-
 fs/proc/base.c                            |   2 +-
 include/linux/binfmts.h                   |   3 +
 include/linux/mm.h                        |   6 +-
 include/linux/mm_types.h                  |   1 +
 kernel/audit.c                            |   5 ++
 kernel/audit_watch.c                      |   7 +-
 kernel/fork.c                             | 105 ++++++++++++++++------
 kernel/signal.c                           |   7 +-
 kernel/sys.c                              |   5 ++
 kernel/taskstats.c                        |   7 +-
 security/tomoyo/util.c                    |   5 ++
 17 files changed, 173 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 59cd902e3549..175fca8439d6 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -88,6 +88,17 @@ Here is what the fields mean:
 	    emulation is installed and uses the opened image to spawn the
 	    emulator, meaning it is always available once installed,
 	    regardless of how the environment changes.
+      ``I`` - expose the interpreted file in the /proc/self/exe symlink
+            By default, binfmt_misc executing binaries expose their interpreter
+            as the /proc/self/exe file, which makes sense given that the actual
+            executable running is the interpreter indeed. But there are some
+            cases in which we want to change that behavior - imagine an emulator
+            of Linux binaries (of different architecture, for example) which
+            needs to deal with the different behaviors when running native - the
+            binary's symlink (/proc/self/exe) points to the binary itself - vs
+            the emulated case, whereas the link points to the interpreter. This
+            flag allows to change the default behavior and have the proc symlink
+            pointing to the **interpreted** file, not the interpreter.
 
 
 There are some restrictions:
diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index d5b3ed2c58f5..d078af66f07b 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -62,6 +62,11 @@ static void print_task_path_n_nm(struct task_struct *tsk)
 	if (!mm)
 		goto done;
 
+	/*
+	 * FIXME (BINPRM_FLAGS_EXPOSE_INTERP): observe that if using binfmt_misc
+	 * with flag 'I' set, this functionality will diverge from the
+	 * /proc/self/exe symlink with regards of what executable is running.
+	 */
 	exe_file = get_mm_exe_file(mm);
 	mmput(mm);
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7b3d2d491407..fb0c22fa3635 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1162,6 +1162,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 		}
 
+		/*
+		 * FIXME (BINPRM_FLAGS_EXPOSE_INTERP): here is one of our problems - bprm->file is
+		 * elf_mapped(), whereas our saved bprm->interpreted_file isn't. Now, why not just
+		 * map it, right? Because we're not sure how to (or if it's indeed necessary).
+		 * What if the interpreted file is not ELF? Could be anything that its interpreter
+		 * is able to read and execute...
+		 */
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index e0108d17b085..36350c3d73f5 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -48,6 +48,7 @@ enum {Enabled, Magic};
 #define MISC_FMT_OPEN_BINARY (1UL << 30)
 #define MISC_FMT_CREDENTIALS (1UL << 29)
 #define MISC_FMT_OPEN_FILE (1UL << 28)
+#define MISC_FMT_EXPOSE_INTERPRETED (1UL << 27)
 
 typedef struct {
 	struct list_head list;
@@ -181,6 +182,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		goto ret;
 
+	if (fmt->flags & MISC_FMT_EXPOSE_INTERPRETED)
+		bprm->interp_flags |= BINPRM_FLAGS_EXPOSE_INTERP;
+
 	if (fmt->flags & MISC_FMT_OPEN_FILE) {
 		interp_file = file_clone_open(fmt->interp_file);
 		if (!IS_ERR(interp_file))
@@ -258,6 +262,11 @@ static char *check_special_flags(char *sfs, Node *e)
 			p++;
 			e->flags |= MISC_FMT_OPEN_FILE;
 			break;
+		case 'I':
+			pr_debug("register: flag: I: (expose interpreted binary)\n");
+			p++;
+			e->flags |= MISC_FMT_EXPOSE_INTERPRETED;
+			break;
 		default:
 			cont = 0;
 		}
@@ -524,6 +533,8 @@ static void entry_status(Node *e, char *page)
 		*dp++ = 'C';
 	if (e->flags & MISC_FMT_OPEN_FILE)
 		*dp++ = 'F';
+	if (e->flags & MISC_FMT_EXPOSE_INTERPRETED)
+		*dp++ = 'I';
 	*dp++ = '\n';
 
 	if (!test_bit(Magic, &e->flags)) {
diff --git a/fs/coredump.c b/fs/coredump.c
index 9d235fa14ab9..1a771c7cba67 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -164,6 +164,11 @@ static int cn_print_exe_file(struct core_name *cn, bool name_only)
 	char *pathbuf, *path, *ptr;
 	int ret;
 
+	/*
+	 * FIXME (BINPRM_FLAGS_EXPOSE_INTERP): observe that if using binfmt_misc
+	 * with flag 'I' set, this coredump functionality will diverge from the
+	 * /proc/self/exe symlink with regards of what executable is running.
+	 */
 	exe_file = get_mm_exe_file(current->mm);
 	if (!exe_file)
 		return cn_esc_printf(cn, "%s (path unknown)", current->comm);
diff --git a/fs/exec.c b/fs/exec.c
index 6518e33ea813..bb1574f37b67 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1280,7 +1280,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * not visible until then. Doing it here also ensures
 	 * we don't race against replace_mm_exe_file().
 	 */
-	retval = set_mm_exe_file(bprm->mm, bprm->file);
+	retval = set_mm_exe_file(bprm->mm, bprm->file,
+				 bprm->interpreted_file);
 	if (retval)
 		goto out;
 
@@ -1405,6 +1406,13 @@ int begin_new_exec(struct linux_binprm * bprm)
 		fd_install(retval, bprm->executable);
 		bprm->executable = NULL;
 		bprm->execfd = retval;
+		/*
+		 * Since bprm->interpreted_file points to bprm->executable and
+		 * fd_install() consumes its refcount, we need to bump the refcount
+		 * here to avoid warnings as "file count is 0" on kernel log.
+		 */
+		if (unlikely(bprm->interp_flags & BINPRM_FLAGS_EXPOSE_INTERP))
+			get_file(bprm->interpreted_file);
 	}
 	return 0;
 
@@ -1500,6 +1508,8 @@ static void free_bprm(struct linux_binprm *bprm)
 		allow_write_access(bprm->file);
 		fput(bprm->file);
 	}
+	if (bprm->interpreted_file)
+		fput(bprm->interpreted_file);
 	if (bprm->executable)
 		fput(bprm->executable);
 	/* If a binfmt changed the interp, free it. */
@@ -1789,6 +1799,9 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->interpreter = NULL;
 
 		allow_write_access(exec);
+		if (unlikely(bprm->interp_flags & BINPRM_FLAGS_EXPOSE_INTERP))
+			bprm->interpreted_file = exec;
+
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
 				fput(exec);
@@ -1796,7 +1809,8 @@ static int exec_binprm(struct linux_binprm *bprm)
 			}
 			bprm->executable = exec;
 		} else
-			fput(exec);
+			if (!(bprm->interp_flags & BINPRM_FLAGS_EXPOSE_INTERP))
+				fput(exec);
 	}
 
 	audit_bprm(bprm);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ffd54617c354..a13fbfc46997 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1727,7 +1727,7 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
 	task = get_proc_task(d_inode(dentry));
 	if (!task)
 		return -ENOENT;
-	exe_file = get_task_exe_file(task);
+	exe_file = get_task_exe_file(task, true);
 	put_task_struct(task);
 	if (exe_file) {
 		*exe_path = exe_file->f_path;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 8d51f69f9f5e..5dde52de7877 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -45,6 +45,7 @@ struct linux_binprm {
 		point_of_no_return:1;
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
+	struct file *interpreted_file; /* only for binfmt_misc with flag I */
 	struct file *file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
@@ -75,6 +76,8 @@ struct linux_binprm {
 #define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
 #define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
 
+#define BINPRM_FLAGS_EXPOSE_INTERP_BIT 4
+#define BINPRM_FLAGS_EXPOSE_INTERP (1 << BINPRM_FLAGS_EXPOSE_INTERP_BIT)
 /*
  * This structure defines the functions that are used to load the binary formats that
  * linux accepts.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..a00b32906604 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3255,10 +3255,12 @@ static inline int check_data_rlimit(unsigned long rlim,
 extern int mm_take_all_locks(struct mm_struct *mm);
 extern void mm_drop_all_locks(struct mm_struct *mm);
 
-extern int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file);
+extern int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file,
+			   struct file *new_interpreted_file);
 extern int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file);
 extern struct file *get_mm_exe_file(struct mm_struct *mm);
-extern struct file *get_task_exe_file(struct task_struct *task);
+extern struct file *get_task_exe_file(struct task_struct *task,
+				      bool prefer_interpreted);
 
 extern bool may_expand_vm(struct mm_struct *, vm_flags_t, unsigned long npages);
 extern void vm_stat_account(struct mm_struct *, vm_flags_t, long npages);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e6..346f81875f3e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -842,6 +842,7 @@ struct mm_struct {
 
 		/* store ref to file /proc/<pid>/exe symlink points to */
 		struct file __rcu *exe_file;
+		struct file __rcu *interpreted_file; /* see binfmt_misc flag I */
 #ifdef CONFIG_MMU_NOTIFIER
 		struct mmu_notifier_subscriptions *notifier_subscriptions;
 #endif
diff --git a/kernel/audit.c b/kernel/audit.c
index 16205dd29843..83c64c376c0c 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2197,6 +2197,11 @@ void audit_log_d_path_exe(struct audit_buffer *ab,
 	if (!mm)
 		goto out_null;
 
+	/*
+	 * FIXME (BINPRM_FLAGS_EXPOSE_INTERP): observe that if using binfmt_misc
+	 * with flag 'I' set, this audit functionality will diverge from the
+	 * /proc/self/exe symlink with regards of what executable is running.
+	 */
 	exe_file = get_mm_exe_file(mm);
 	if (!exe_file)
 		goto out_null;
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 65075f1e4ac8..b8f947849fb2 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -527,7 +527,12 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 	unsigned long ino;
 	dev_t dev;
 
-	exe_file = get_task_exe_file(tsk);
+	/*
+	 * FIXME (BINPRM_FLAGS_EXPOSE_INTERP): if using the binfmt_misc flag 'I', we diverge
+	 * here from proc_exe_link(), exposing the true exe_file (instead of the interpreted
+	 * binary as proc). Should we expose here the same exe_file as proc's one *always*?
+	 */
+	exe_file = get_task_exe_file(tsk, false);
 	if (!exe_file)
 		return 0;
 	ino = file_inode(exe_file)->i_ino;
diff --git a/kernel/fork.c b/kernel/fork.c
index 3b6d20dfb9a8..8c4824dcc433 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -628,12 +628,47 @@ void free_task(struct task_struct *tsk)
 }
 EXPORT_SYMBOL(free_task);
 
-static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
+/**
+ * __get_mm_exe_or_interp_file - helper that acquires a reference to the mm's
+ * executable file, or if prefer_interp is set, go with mm->interpreted_file
+ * instead.
+ *
+ * Returns %NULL if mm has no associated executable/interpreted file.
+ * User must release file via fput().
+ */
+static inline struct file *__get_mm_exe_or_interp_file(struct mm_struct *mm,
+						       bool prefer_interp)
 {
 	struct file *exe_file;
 
+	rcu_read_lock();
+
+	if (unlikely(prefer_interp))
+		exe_file = rcu_dereference(mm->interpreted_file);
+	else
+		exe_file = rcu_dereference(mm->exe_file);
+
+	if (exe_file && !get_file_rcu(exe_file))
+		exe_file = NULL;
+	rcu_read_unlock();
+	return exe_file;
+}
+
+struct file *get_mm_exe_file(struct mm_struct *mm)
+{
+	return __get_mm_exe_or_interp_file(mm, false);
+}
+
+static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	struct file *exe_file, *interp_file;
+
 	exe_file = get_mm_exe_file(oldmm);
 	RCU_INIT_POINTER(mm->exe_file, exe_file);
+
+	interp_file = __get_mm_exe_or_interp_file(oldmm, true);
+	RCU_INIT_POINTER(mm->interpreted_file, interp_file);
+
 	/*
 	 * We depend on the oldmm having properly denied write access to the
 	 * exe_file already.
@@ -1279,6 +1314,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_owner(mm, p);
 	mm_pasid_init(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
+	RCU_INIT_POINTER(mm->interpreted_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
@@ -1348,7 +1384,7 @@ static inline void __mmput(struct mm_struct *mm)
 	khugepaged_exit(mm); /* must run before exit_mmap */
 	exit_mmap(mm);
 	mm_put_huge_zero_page(mm);
-	set_mm_exe_file(mm, NULL);
+	set_mm_exe_file(mm, NULL, NULL);
 	if (!list_empty(&mm->mmlist)) {
 		spin_lock(&mmlist_lock);
 		list_del(&mm->mmlist);
@@ -1394,7 +1430,9 @@ EXPORT_SYMBOL_GPL(mmput_async);
 /**
  * set_mm_exe_file - change a reference to the mm's executable file
  *
- * This changes mm's executable file (shown as symlink /proc/[pid]/exe).
+ * This changes mm's executable file (shown as symlink /proc/[pid]/exe),
+ * and if new_interpreted_file != NULL, also sets this field (check the
+ * binfmt_misc documentation, flag 'I', for details about this).
  *
  * Main users are mmput() and sys_execve(). Callers prevent concurrent
  * invocations: in mmput() nobody alive left, in execve it happens before
@@ -1402,16 +1440,19 @@ EXPORT_SYMBOL_GPL(mmput_async);
  *
  * Can only fail if new_exe_file != NULL.
  */
-int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
+int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file,
+		    struct file *new_interpreted_file)
 {
 	struct file *old_exe_file;
+	struct file *old_interpreted_file;
 
 	/*
-	 * It is safe to dereference the exe_file without RCU as
-	 * this function is only called if nobody else can access
-	 * this mm -- see comment above for justification.
+	 * It is safe to dereference exe_file / interpreted_file
+	 * without RCU as this function is only called if nobody else
+	 * can access this mm -- see comment above for justification.
 	 */
 	old_exe_file = rcu_dereference_raw(mm->exe_file);
+	old_interpreted_file = rcu_dereference_raw(mm->interpreted_file);
 
 	if (new_exe_file) {
 		/*
@@ -1423,10 +1464,20 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 		get_file(new_exe_file);
 	}
 	rcu_assign_pointer(mm->exe_file, new_exe_file);
+
+	/* For this one we don't care about write access... */
+	if (new_interpreted_file)
+		get_file(new_interpreted_file);
+	rcu_assign_pointer(mm->interpreted_file, new_interpreted_file);
+
 	if (old_exe_file) {
 		allow_write_access(old_exe_file);
 		fput(old_exe_file);
 	}
+
+	if (old_interpreted_file)
+		fput(old_interpreted_file);
+
 	return 0;
 }
 
@@ -1436,6 +1487,12 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
  * This changes mm's executable file (shown as symlink /proc/[pid]/exe).
  *
  * Main user is sys_prctl(PR_SET_MM_MAP/EXE_FILE).
+ *
+ * FIXME (BINPRM_FLAGS_EXPOSE_INTERP): imagine user performs the sys_prctl()
+ * aiming to change /proc/self/exe symlink - suppose user is interested
+ * in the executable path itself. With binfmt_misc flag 'I', this change
+ * **won't reflect** since procfs make use of interpreted_file. What to do
+ * in this case? Do we care?
  */
 int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 {
@@ -1482,31 +1539,15 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 }
 
 /**
- * get_mm_exe_file - acquire a reference to the mm's executable file
- *
- * Returns %NULL if mm has no associated executable file.
- * User must release file via fput().
- */
-struct file *get_mm_exe_file(struct mm_struct *mm)
-{
-	struct file *exe_file;
-
-	rcu_read_lock();
-	exe_file = rcu_dereference(mm->exe_file);
-	if (exe_file && !get_file_rcu(exe_file))
-		exe_file = NULL;
-	rcu_read_unlock();
-	return exe_file;
-}
-
-/**
- * get_task_exe_file - acquire a reference to the task's executable file
+ * get_task_exe_file - acquire a reference to the task's executable or
+ * interpreted file (only for procfs, when under binfmt_misc with flag 'I').
  *
  * Returns %NULL if task's mm (if any) has no associated executable file or
  * this is a kernel thread with borrowed mm (see the comment above get_task_mm).
  * User must release file via fput().
  */
-struct file *get_task_exe_file(struct task_struct *task)
+struct file *get_task_exe_file(struct task_struct *task,
+			       bool prefer_interpreted)
 {
 	struct file *exe_file = NULL;
 	struct mm_struct *mm;
@@ -1514,8 +1555,14 @@ struct file *get_task_exe_file(struct task_struct *task)
 	task_lock(task);
 	mm = task->mm;
 	if (mm) {
-		if (!(task->flags & PF_KTHREAD))
-			exe_file = get_mm_exe_file(mm);
+		if (!(task->flags & PF_KTHREAD)) {
+			if (unlikely(prefer_interpreted)) {
+				exe_file = __get_mm_exe_or_interp_file(mm, true);
+				if (!exe_file)
+					exe_file = get_mm_exe_file(mm);
+			} else
+				exe_file = get_mm_exe_file(mm);
+		}
 	}
 	task_unlock(task);
 	return exe_file;
diff --git a/kernel/signal.c b/kernel/signal.c
index 09019017d669..3a8d85a65c49 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1263,7 +1263,12 @@ static void print_fatal_signal(int signr)
 	struct pt_regs *regs = task_pt_regs(current);
 	struct file *exe_file;
 
-	exe_file = get_task_exe_file(current);
+	/*
+	 * FIXME (BINPRM_FLAGS_EXPOSE_INTERP): if using the binfmt_misc flag 'I', we diverge
+	 * here from proc_exe_link(), exposing the true exe_file (instead of the interpreted
+	 * binary as proc). Should we expose here the same exe_file as proc's one *always*?
+	 */
+	exe_file = get_task_exe_file(current, false);
 	if (exe_file) {
 		pr_info("%pD: %s: potentially unexpected fatal signal %d.\n",
 			exe_file, current->comm, signr);
diff --git a/kernel/sys.c b/kernel/sys.c
index 2410e3999ebe..17fab2f71443 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1912,6 +1912,11 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 	if (err)
 		goto exit;
 
+	/*
+	 * FIXME (BINPRM_FLAGS_EXPOSE_INTERP): please read the comment
+	 * on replace_mm_exe_file() to ponder about the divergence when
+	 * using binfmt_misc with flag 'I'.
+	 */
 	err = replace_mm_exe_file(mm, exe.file);
 exit:
 	fdput(exe);
diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 8ce3fa0c19e2..a5d5afc1919a 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -157,7 +157,12 @@ static void send_cpu_listeners(struct sk_buff *skb,
 static void exe_add_tsk(struct taskstats *stats, struct task_struct *tsk)
 {
 	/* No idea if I'm allowed to access that here, now. */
-	struct file *exe_file = get_task_exe_file(tsk);
+	struct file *exe_file = get_task_exe_file(tsk, false);
+	/*
+	 * FIXME (BINPRM_FLAGS_EXPOSE_INTERP): if using the binfmt_misc flag 'I', we diverge
+	 * here from proc_exe_link(), exposing the true exe_file (instead of the interpreted
+	 * binary as proc). Should we expose here the same exe_file as proc's one *always*?
+	 */
 
 	if (exe_file) {
 		/* Following cp_new_stat64() in stat.c . */
diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index 6799b1122c9d..844bdbd27240 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -971,6 +971,11 @@ const char *tomoyo_get_exe(void)
 
 	if (!mm)
 		return NULL;
+	/*
+	 * FIXME (BINPRM_FLAGS_EXPOSE_INTERP): observe that if using binfmt_misc
+	 * with flag 'I' set, this tomoyo functionality will diverge from the
+	 * /proc/self/exe symlink with regards of what executable is running.
+	 */
 	exe_file = get_mm_exe_file(mm);
 	if (!exe_file)
 		return NULL;
-- 
2.42.0


Return-Path: <linux-fsdevel+bounces-21643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3FA907400
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4141F1C22621
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24533145B04;
	Thu, 13 Jun 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YjpbSKaU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C091448E4;
	Thu, 13 Jun 2024 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286012; cv=none; b=DsjrPG/hSMyuR45cnY427R+kS/ukG95V7qoByMMMMMKHWDa4+6nG2sPYZDPzeOJrpAxQBVuAe5Y8wR/Hs7Va2ZOoIHcG2JLdLu9fO+omeUobKZuGKp+qTTw8DEKiLb804B0iejgMyXmrgQdT3Z3RGyAi+PRXwdL84BtzykfwNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286012; c=relaxed/simple;
	bh=96nh+1IvFVd7pu3Dw9rMghbTYNTK3cg+pRalZYlkWAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSBxVnkRglMzezzlOCPzXL6+BFjs3B05/fTdbJBJOrG801K1kRxPAcU3CpcuIv9Kl30kBnx5nd60BoBhBtpGBTGfr849raPzfLmaJtedFW/YjosUKKi5UCnbmZKFAHtl0Auum01FXYF5sbnCefbA19BVSRQBuFiNgKSOutM314A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YjpbSKaU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718286008;
	bh=96nh+1IvFVd7pu3Dw9rMghbTYNTK3cg+pRalZYlkWAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjpbSKaUgFI0Zb7WZjEt7o7wpZfW0PsACpIaimK2T9HBBNlAxUiBwAyTW1ncAvvYf
	 VDAUTI91+4sHHP2UMoE/oC2X9UBdEjOkAlAZbhl9A2GTffEWpqNXJ657bs/0CBUpmQ
	 r3sQZh76uayE4ez8l3ZgfqxQSoAA9ik+X0W8hk+AGfch2KGhpWHXou9nNYr2OPt7z9
	 XsHhJ+CBjFy6dG1nyveFRByHm8VorVJuXfynUiZ23gSksUH2QDK3PdOWNunU9FshAI
	 F4y1acb+92khb3vGPfCLHasrmztz6baXNAGCWyj6xexr9jntJqjOLgKJWZNitd3ZZK
	 JoS+6WmEzk1zw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 25D223782199;
	Thu, 13 Jun 2024 13:40:07 +0000 (UTC)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel@collabora.com,
	gbiv@google.com,
	ryanbeltran@google.com,
	inglorion@google.com,
	ajordanr@google.com,
	jorgelo@chromium.org,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Xu <jeffxu@google.com>,
	Mike Frysinger <vapier@chromium.org>
Subject: [PATCH v6 2/2] proc: restrict /proc/pid/mem
Date: Thu, 13 Jun 2024 16:39:37 +0300
Message-ID: <20240613133937.2352724-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240613133937.2352724-1-adrian.ratiu@collabora.com>
References: <20240613133937.2352724-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
after which it got allowed in commit 198214a7ee50 ("proc: enable
writing to /proc/pid/mem"). Famous last words from that patch:
"no longer a security hazard". :)

Afterwards exploits started causing drama like [1]. The exploits
using /proc/*/mem can be rather sophisticated like [2] which
installed an arbitrary payload from noexec storage into a running
process then exec'd it, which itself could include an ELF loader
to run arbitrary code off noexec storage.

One of the well-known problems with /proc/*/mem writes is they
ignore page permissions via FOLL_FORCE, as opposed to writes via
process_vm_writev which respect page permissions. These writes can
also be used to bypass mode bits.

To harden against these types of attacks, distrbutions might want
to restrict /proc/pid/mem accesses, either entirely or partially,
for eg. to restrict FOLL_FORCE usage.

Known valid use-cases which still need these accesses are:

* Debuggers which also have ptrace permissions, so they can access
memory anyway via PTRACE_POKEDATA & co. Some debuggers like GDB
are designed to write /proc/pid/mem for basic functionality.

* Container supervisors using the seccomp notifier to intercept
syscalls and rewrite memory of calling processes by passing
around /proc/pid/mem file descriptors.

There might be more, that's why these params default to disabled.

Regarding other mechanisms which can block these accesses:

* seccomp filters can be used to block mmap/mprotect calls with W|X
perms, but they often can't block open calls as daemons want to
read/write their runtime state and seccomp filters cannot check
file paths, so plain write calls can't be easily blocked.

* Since the mem file is part of the dynamic /proc/<pid>/ space, we
can't run chmod once at boot to restrict it (and trying to react
to every process and run chmod doesn't scale, and the kernel no
longer allows chmod on any of these paths).

* SELinux could be used with a rule to cover all /proc/*/mem files,
but even then having multiple ways to deny an attack is useful in
case one layer fails.

Thus we introduce four kernel parameters to restrict /proc/*/mem
access: open-read, open-write, write and foll_force. All these can
be independently set to the following values:

all     => restrict all access unconditionally.
ptracer => restrict all access except for ptracer processes.

If left unset, the existing behaviour is preserved, i.e. access
is governed by basic file permissions.

Examples which can be passed by bootloaders:

proc_mem.restrict_foll_force=all
proc_mem.restrict_open_write=ptracer
proc_mem.restrict_open_read=ptracer
proc_mem.restrict_write=all

These knobs can also be enabled via Kconfig like for eg:

CONFIG_PROC_MEM_RESTRICT_WRITE_PTRACE_DEFAULT=y
CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE_DEFAULT=y

Each distribution needs to decide what restrictions to apply,
depending on its use-cases. Embedded systems might want to do
more, while general-purpouse distros might want a more relaxed
policy, because for e.g. foll_force=all and write=all both break
break GDB, so it might be a bit excessive.

Based on an initial patch by Mike Frysinger <vapier@chromium.org>.

Link: https://lwn.net/Articles/476947/ [1]
Link: https://issues.chromium.org/issues/40089045 [2]
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>
Co-developed-by: Mike Frysinger <vapier@chromium.org>
Signed-off-by: Mike Frysinger <vapier@chromium.org>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
Changes in v6:
* Replaced slow_inc() with static_key_enable/disable
* Added pr_warn() when restricting calls to warn userspace
* Reworked Kconfig menu to be choices with 3 states each
* Reworked static key defines to add OFF state
* Double checked all combinations, including OFF work as
  expected (booted and run GDB/gdbserver)
---
 .../admin-guide/kernel-parameters.txt         |  38 ++++
 fs/proc/base.c                                | 197 +++++++++++++++++-
 security/Kconfig                              | 121 +++++++++++
 3 files changed, 355 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..ad2cb6b3c54d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4814,6 +4814,44 @@
 	printk.time=	Show timing data prefixed to each printk message line
 			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
 
+	proc_mem.restrict_foll_force= [KNL]
+			Format: {all | ptracer}
+			Restricts the use of the FOLL_FORCE flag for /proc/*/mem access.
+			If restricted, the FOLL_FORCE flag will not be added to vm accesses.
+			Can be one of:
+			- 'all' restricts all access unconditionally.
+			- 'ptracer' allows access only for ptracer processes.
+			If not specified, FOLL_FORCE is always used.
+
+	proc_mem.restrict_open_read= [KNL]
+			Format: {all | ptracer}
+			Allows restricting read access to /proc/*/mem files during open().
+			Depending on restriction level, open for reads return -EACCES.
+			Can be one of:
+			- 'all' restricts all access unconditionally.
+			- 'ptracer' allows access only for ptracer processes.
+			If not specified, then basic file permissions continue to apply.
+
+	proc_mem.restrict_open_write= [KNL]
+			Format: {all | ptracer}
+			Allows restricting write access to /proc/*/mem files during open().
+			Depending on restriction level, open for writes return -EACCES.
+			Can be one of:
+			- 'all' restricts all access unconditionally.
+			- 'ptracer' allows access only for ptracer processes.
+			If not specified, then basic file permissions continue to apply.
+
+	proc_mem.restrict_write= [KNL]
+			Format: {all | ptracer}
+			Allows restricting write access to /proc/*/mem after the files
+			have been opened, during the actual write calls. This is useful for
+			systems which can't block writes earlier during open().
+			Depending on restriction level, writes will return -EACCES.
+			Can be one of:
+			- 'all' restricts all access unconditionally.
+			- 'ptracer' allows access only for ptracer processes.
+			If not specified, then basic file permissions continue to apply.
+
 	processor.max_cstate=	[HW,ACPI]
 			Limit processor to maximum C-state
 			max_cstate=9 overrides any DMI blacklist limit.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4c607089f66e..9ad9ddd94784 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -152,6 +152,77 @@ struct pid_entry {
 		NULL, &proc_pid_attr_operations,	\
 		{ .lsmid = LSMID })
 
+#if IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_OPEN_READ_ALL)
+DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_open_read_all);
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_read_ptracer);
+#elif IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_OPEN_READ_PTRACE)
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_read_all);
+DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_open_read_ptracer);
+#else
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_read_all);
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_read_ptracer);
+#endif
+
+#if IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_ALL)
+DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_open_write_all);
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_write_ptracer);
+#elif IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_PTRACE)
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_write_all);
+DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_open_write_ptracer);
+#else
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_write_all);
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_write_ptracer);
+#endif
+
+#if IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_WRITE_ALL)
+DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_write_all);
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_write_ptracer);
+#elif IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_WRITE_PTRACE)
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_write_all);
+DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_write_ptracer);
+#else
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_write_all);
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_write_ptracer);
+#endif
+
+#if IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_ALL)
+DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_foll_force_all);
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_foll_force_ptracer);
+#elif IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE)
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_foll_force_all);
+DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_foll_force_ptracer);
+#else
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_foll_force_all);
+DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_foll_force_ptracer);
+#endif
+
+#define DEFINE_EARLY_PROC_MEM_RESTRICT(name)					\
+static int __init early_proc_mem_restrict_##name(char *buf)			\
+{										\
+	if (!buf)								\
+		return -EINVAL;							\
+										\
+	if (strcmp(buf, "all") == 0) {						\
+		static_key_enable(&proc_mem_restrict_##name##_all.key);		\
+		static_key_disable(&proc_mem_restrict_##name##_ptracer.key);	\
+	} else if (strcmp(buf, "ptracer") == 0) {				\
+		static_key_disable(&proc_mem_restrict_##name##_all.key);	\
+		static_key_enable(&proc_mem_restrict_##name##_ptracer.key);	\
+	} else if (strcmp(buf, "off") == 0) {					\
+		static_key_disable(&proc_mem_restrict_##name##_all.key);	\
+		static_key_disable(&proc_mem_restrict_##name##_ptracer.key);	\
+	} else									\
+		pr_warn("%s: ignoring unknown option '%s'\n",			\
+			"proc_mem.restrict_" #name, buf);			\
+	return 0;								\
+}										\
+early_param("proc_mem.restrict_" #name, early_proc_mem_restrict_##name)
+
+DEFINE_EARLY_PROC_MEM_RESTRICT(open_read);
+DEFINE_EARLY_PROC_MEM_RESTRICT(open_write);
+DEFINE_EARLY_PROC_MEM_RESTRICT(write);
+DEFINE_EARLY_PROC_MEM_RESTRICT(foll_force);
+
 /*
  * Count the number of hardlinks for the pid_entry table, excluding the .
  * and .. links.
@@ -794,12 +865,71 @@ static const struct file_operations proc_single_file_operations = {
 };
 
 
+static void report_mem_rw_reject(const char *action, struct task_struct *task)
+{
+	pr_warn_ratelimited("Denied %s of /proc/%d/mem (%s) by pid %d (%s)\n",
+			    action, task_pid_nr(task), task->comm,
+			    task_pid_nr(current), current->comm);
+}
+
+static int __mem_open_access_permitted(struct file *file, struct task_struct *task)
+{
+	bool is_ptracer;
+
+	rcu_read_lock();
+	is_ptracer = current == ptrace_parent(task);
+	rcu_read_unlock();
+
+	if (file->f_mode & FMODE_WRITE) {
+		/* Deny if writes are unconditionally disabled via param */
+		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_DEFAULT,
+					&proc_mem_restrict_open_write_all)) {
+			report_mem_rw_reject("all open-for-write", task);
+			return -EACCES;
+		}
+
+		/* Deny if writes are allowed only for ptracers via param */
+		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_PTRACE_DEFAULT,
+					&proc_mem_restrict_open_write_ptracer) &&
+		    !is_ptracer) {
+			report_mem_rw_reject("non-ptracer open-for-write", task);
+			return -EACCES;
+		}
+	}
+
+	if (file->f_mode & FMODE_READ) {
+		/* Deny if reads are unconditionally disabled via param */
+		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_READ_DEFAULT,
+					&proc_mem_restrict_open_read_all)) {
+			report_mem_rw_reject("all open-for-read", task);
+			return -EACCES;
+		}
+
+		/* Deny if reads are allowed only for ptracers via param */
+		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_READ_PTRACE_DEFAULT,
+					&proc_mem_restrict_open_read_ptracer) &&
+		    !is_ptracer) {
+			report_mem_rw_reject("non-ptracer open-for-read", task);
+			return -EACCES;
+		}
+	}
+
+	return 0; /* R/W are not restricted */
+}
+
 struct mm_struct *proc_mem_open(struct file  *file, unsigned int mode)
 {
 	struct task_struct *task = get_proc_task(file->f_inode);
 	struct mm_struct *mm = ERR_PTR(-ESRCH);
+	int ret;
 
 	if (task) {
+		ret = __mem_open_access_permitted(file, task);
+		if (ret) {
+			put_task_struct(task);
+			return ERR_PTR(ret);
+		}
+
 		mm = mm_access(task, mode | PTRACE_MODE_FSCREDS);
 		put_task_struct(task);
 
@@ -835,10 +965,67 @@ static int mem_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static bool __mem_rw_current_is_ptracer(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct task_struct *task = get_proc_task(inode);
+	struct mm_struct *mm = NULL;
+	int is_ptracer = false, has_mm_access = false;
+
+	if (task) {
+		rcu_read_lock();
+		is_ptracer = current == ptrace_parent(task);
+		rcu_read_unlock();
+
+		mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
+		if (mm && file->private_data == mm) {
+			has_mm_access = true;
+			mmput(mm);
+		}
+
+		put_task_struct(task);
+	}
+
+	return is_ptracer && has_mm_access;
+}
+
+static unsigned int __mem_rw_get_foll_force_flag(struct file *file)
+{
+	/* Deny if FOLL_FORCE is disabled via param */
+	if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_DEFAULT,
+				&proc_mem_restrict_foll_force_all))
+		return 0;
+
+	/* Deny if FOLL_FORCE is allowed only for ptracers via param */
+	if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE_DEFAULT,
+				&proc_mem_restrict_foll_force_ptracer) &&
+	    !__mem_rw_current_is_ptracer(file))
+		return 0;
+
+	return FOLL_FORCE;
+}
+
+static bool __mem_rw_block_writes(struct file *file)
+{
+	/* Block if writes are disabled via param proc_mem.restrict_write=all */
+	if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_WRITE_DEFAULT,
+				&proc_mem_restrict_write_all))
+		return true;
+
+	/* Block with an exception only for ptracers */
+	if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_WRITE_PTRACE_DEFAULT,
+				&proc_mem_restrict_write_ptracer) &&
+	    !__mem_rw_current_is_ptracer(file))
+		return true;
+
+	return false;
+}
+
 static ssize_t mem_rw(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos, int write)
 {
 	struct mm_struct *mm = file->private_data;
+	struct task_struct *task = NULL;
 	unsigned long addr = *ppos;
 	ssize_t copied;
 	char *page;
@@ -847,6 +1034,13 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mm)
 		return 0;
 
+	if (write && __mem_rw_block_writes(file)) {
+		task = get_proc_task(file->f_inode);
+		if (task)
+			report_mem_rw_reject("write call", task);
+		return -EACCES;
+	}
+
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
@@ -855,7 +1049,8 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mmget_not_zero(mm))
 		goto free;
 
-	flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
+	flags = (write ? FOLL_WRITE : 0);
+	flags |= __mem_rw_get_foll_force_flag(file);
 
 	while (count > 0) {
 		size_t this_len = min_t(size_t, count, PAGE_SIZE);
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d..da4d9aa2c99f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -183,6 +183,127 @@ config STATIC_USERMODEHELPER_PATH
 	  If you wish for all usermode helper programs to be disabled,
 	  specify an empty string here (i.e. "").
 
+choice
+	prompt "Restrict /proc/pid/mem FOLL_FORCE usage"
+	default PROC_MEM_RESTRICT_FOLL_FORCE_OFF
+	help
+	  Reading and writing of /proc/pid/mem bypasses memory permission
+	  checks due to the internal use of the FOLL_FORCE flag. This can be
+	  used by attackers to manipulate process memory contents that would
+	  have been otherwise protected. However, debuggers, like GDB, use
+	  this to set breakpoints, etc. To force debuggers to fall back to
+	  PEEK/POKE, see PROC_MEM_RESTRICT_OPEN_WRITE_ALL.
+
+	config PROC_MEM_RESTRICT_FOLL_FORCE_OFF
+	bool "Do not restrict FOLL_FORCE usage with /proc/pid/mem (regular)"
+	help
+	  Regular behavior: continue to use the FOLL_FORCE flag for
+	  /proc/pid/mem access.
+
+	config PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE
+	bool "Only allow ptracers to use FOLL_FORCE with /proc/pid/mem (safer)"
+	help
+	  Only use the FOLL_FORCE flag for /proc/pid/mem access when the
+	  current task is the active ptracer of the target task. (Safer,
+	  least disruptive to most usage patterns.)
+
+	config PROC_MEM_RESTRICT_FOLL_FORCE_ALL
+	bool "Do not use FOLL_FORCE with /proc/pid/mem (safest)"
+	help
+	  Remove the FOLL_FORCE flag for all /proc/pid/mem accesses.
+	  (Safest, but may be disruptive to some usage patterns.)
+endchoice
+
+choice
+	prompt "Restrict /proc/pid/mem OPEN_READ usage"
+	default PROC_MEM_RESTRICT_OPEN_READ_OFF
+	help
+	  Reading and writing of /proc/pid/mem bypasses memory permission
+	  checks due to the internal use of the FOLL_FORCE flag. This can be
+	  used by attackers to manipulate process memory contents that would
+	  have been otherwise protected. However, debuggers, like GDB, use
+	  this to set breakpoints, etc. To force debuggers to fall back to
+	  PEEK/POKE, see PROC_MEM_RESTRICT_OPEN_WRITE_ALL.
+
+	config PROC_MEM_RESTRICT_OPEN_READ_OFF
+	bool "Do not restrict /proc/pid/mem open for read (regular)"
+	help
+	  Regular behavior: allow /proc/pid/mem open for read access.
+
+	config PROC_MEM_RESTRICT_OPEN_READ_PTRACE
+	bool "Only allow ptracers to open /proc/pid/mem for read (safer)"
+	help
+	  Only allow opening /proc/pid/mem for reading when the current
+	  task is the active ptracer of the target task. (Safer, least
+	  disruptive to most usage patterns.)
+
+	config PROC_MEM_RESTRICT_OPEN_READ_ALL
+	bool "Do not allow /proc/pid/mem open for read (safest)"
+	help
+	  Do not allow /proc/pid/mem open for reading access.
+	  (Safest, but may be disruptive to some usage patterns.)
+endchoice
+
+choice
+	prompt "Restrict /proc/pid/mem OPEN_WRITE usage"
+	default PROC_MEM_RESTRICT_OPEN_WRITE_OFF
+	help
+	  Reading and writing of /proc/pid/mem bypasses memory permission
+	  checks due to the internal use of the FOLL_FORCE flag. This can be
+	  used by attackers to manipulate process memory contents that would
+	  have been otherwise protected. However, debuggers, like GDB, use
+	  this to set breakpoints, etc. To force debuggers to fall back to
+	  PEEK/POKE, see PROC_MEM_RESTRICT_OPEN_WRITE_ALL.
+
+	config PROC_MEM_RESTRICT_OPEN_WRITE_OFF
+	bool "Do not restrict /proc/pid/mem open for write (regular)"
+	help
+	  Regular behavior: allow /proc/pid/mem open for write access.
+
+	config PROC_MEM_RESTRICT_OPEN_WRITE_PTRACE
+	bool "Only allow ptracers to open /proc/pid/mem for write (safer)"
+	help
+	  Only allow opening /proc/pid/mem for writing when the current
+	  task is the active ptracer of the target task. (Safer, least
+	  disruptive to most usage patterns.)
+
+	config PROC_MEM_RESTRICT_OPEN_WRITE_ALL
+	bool "Do not allow /proc/pid/mem open for write (safest)"
+	help
+	  Do not allow /proc/pid/mem open for writing access.
+	  (Safest, but may be disruptive to some usage patterns.)
+endchoice
+
+choice
+	prompt "Restrict /proc/pid/mem WRITE usage"
+	default PROC_MEM_RESTRICT_WRITE_OFF
+	help
+	  Reading and writing of /proc/pid/mem bypasses memory permission
+	  checks due to the internal use of the FOLL_FORCE flag. This can be
+	  used by attackers to manipulate process memory contents that would
+	  have been otherwise protected. However, debuggers, like GDB, use
+	  this to set breakpoints, etc. To force debuggers to fall back to
+	  PEEK/POKE, see PROC_MEM_RESTRICT_OPEN_WRITE_ALL.
+
+	config PROC_MEM_RESTRICT_WRITE_OFF
+	bool "Do not restrict /proc/pid/mem writes (regular)"
+	help
+	  Regular behavior: allow /proc/pid/mem write access.
+
+	config PROC_MEM_RESTRICT_WRITE_PTRACE
+	bool "Only allow ptracers to write to /proc/pid/mem (safer)"
+	help
+	  Only allow writing to /proc/pid/mem when the current task is
+	  the active ptracer of the target task. (Safer, least disruptive
+	  to most usage patterns.)
+
+	config PROC_MEM_RESTRICT_WRITE_ALL
+	bool "Do not allow writes to /proc/pid/mem (safest)"
+	help
+	  Do not allow writing to /proc/pid/mem.
+	  (Safest, but may be disruptive to some usage patterns.)
+endchoice
+
 source "security/selinux/Kconfig"
 source "security/smack/Kconfig"
 source "security/tomoyo/Kconfig"
-- 
2.44.2



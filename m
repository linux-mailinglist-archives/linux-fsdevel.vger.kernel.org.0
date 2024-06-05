Return-Path: <linux-fsdevel+bounces-21068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774578FD322
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1ECC1F22D16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83A1922F9;
	Wed,  5 Jun 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TX/mcEVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640F18F2F4;
	Wed,  5 Jun 2024 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606228; cv=none; b=PlUQ1lw1FksAOBIcuqqlHIt1Evajv9Mbc9US3dQ4267Grp9zUqGYvj7FstL5hDSGFJHxNbeZJjKJ/nLoP/LrpkiRH5piS8nut879XCjJIVckrz46MF5w+uzJ4ALHE/FOlCmQX498LObWRKSOR1tbNlx7TvYFfjPioxzSqwSdwxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606228; c=relaxed/simple;
	bh=kzuN9oxg8OP/9rJGGivC7fdmn8uFhtEGTxAstmuYmJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvVOz/3aYNtw7PCb5LLcBVsEEJzzX674DPZK8YPGQuFCZ56POiubekbyMgAcDwlAuagbTZOkGuMW8KrnqMHF5s0KnaTuSOhme3Q/ydTBrdvPhEbjesWc+zJ4OwCFekRo+q/82OlYT7Tpahml7FVKjKGsp4DOLi7kAB0Rm3PsEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TX/mcEVP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717606217;
	bh=kzuN9oxg8OP/9rJGGivC7fdmn8uFhtEGTxAstmuYmJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TX/mcEVPsB3RBATJT6jy5psw0s2w+Eq1bx5ouZ6HJgSzomiGuxz06d5kgmHA7RY5e
	 frDy/k1WGqDHiqceENPYK+mN1ZXQ5x4JziXf/C8zJb8U7vZaY6ke4MEwVcTkoIUE5E
	 HQ06fl2wRr52ewIRkk8uBk87jrJhZElubRJb/kyST6YgLVBdi7TQlTM+JAJAyryf99
	 WSsIHKdo7dZ1442G4AVBCFEvElje6VvI+xjBmNXijtZ9Mj579pXx02QdcVyEkN9ZGa
	 zLc/wf+SDidHAN46xYID4P62WopRQfxNGVr3e4FA1RL2sMh+ThlxCie2Yb6W4WKodG
	 uR2iRVef5WerA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 87F7037821A8;
	Wed,  5 Jun 2024 16:50:16 +0000 (UTC)
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
Subject: [PATCH v5 2/2] proc: restrict /proc/pid/mem
Date: Wed,  5 Jun 2024 19:49:31 +0300
Message-ID: <20240605164931.3753-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240605164931.3753-1-adrian.ratiu@collabora.com>
References: <20240605164931.3753-1-adrian.ratiu@collabora.com>
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
Changes in v5:
* Fixed 2 typos by Randy D. (thanks!)
* Fixed mm_access() resource leak
* Rebased on next-20240605
---
 .../admin-guide/kernel-parameters.txt         |  38 +++++
 fs/proc/base.c                                | 130 +++++++++++++++++-
 security/Kconfig                              |  68 +++++++++
 3 files changed, 235 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f4f2b0ab61fae..035ed61a3e4e3 100644
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
index 4c607089f66ed..3f33c579cb65c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -152,6 +152,30 @@ struct pid_entry {
 		NULL, &proc_pid_attr_operations,	\
 		{ .lsmid = LSMID })
 
+#define DEFINE_EARLY_PROC_MEM_RESTRICT(CFG, name)				\
+DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_PROC_MEM_RESTRICT_##CFG##_DEFAULT,		\
+			   proc_mem_restrict_##name##_all);			\
+DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_PROC_MEM_RESTRICT_##CFG##_PTRACE_DEFAULT,	\
+			   proc_mem_restrict_##name##_ptracer);			\
+										\
+static int __init early_proc_mem_restrict_##name(char *buf)			\
+{										\
+	if (!buf)								\
+		return -EINVAL;							\
+										\
+	if (strcmp(buf, "all") == 0)						\
+		static_key_slow_inc(&proc_mem_restrict_##name##_all.key);	\
+	else if (strcmp(buf, "ptracer") == 0)					\
+		static_key_slow_inc(&proc_mem_restrict_##name##_ptracer.key);	\
+	return 0;								\
+}										\
+early_param("proc_mem.restrict_" #name, early_proc_mem_restrict_##name)
+
+DEFINE_EARLY_PROC_MEM_RESTRICT(OPEN_READ, open_read);
+DEFINE_EARLY_PROC_MEM_RESTRICT(OPEN_WRITE, open_write);
+DEFINE_EARLY_PROC_MEM_RESTRICT(WRITE, write);
+DEFINE_EARLY_PROC_MEM_RESTRICT(FOLL_FORCE, foll_force);
+
 /*
  * Count the number of hardlinks for the pid_entry table, excluding the .
  * and .. links.
@@ -794,12 +818,56 @@ static const struct file_operations proc_single_file_operations = {
 };
 
 
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
+					&proc_mem_restrict_open_write_all))
+			return -EACCES;
+
+		/* Deny if writes are allowed only for ptracers via param */
+		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_PTRACE_DEFAULT,
+					&proc_mem_restrict_open_write_ptracer) &&
+		    !is_ptracer)
+			return -EACCES;
+	}
+
+	if (file->f_mode & FMODE_READ) {
+		/* Deny if reads are unconditionally disabled via param */
+		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_READ_DEFAULT,
+					&proc_mem_restrict_open_read_all))
+			return -EACCES;
+
+		/* Deny if reads are allowed only for ptracers via param */
+		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_READ_PTRACE_DEFAULT,
+					&proc_mem_restrict_open_read_ptracer) &&
+		    !is_ptracer)
+			return -EACCES;
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
 
@@ -835,6 +903,62 @@ static int mem_open(struct inode *inode, struct file *file)
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
@@ -847,6 +971,9 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mm)
 		return 0;
 
+	if (write && __mem_rw_block_writes(file))
+		return -EACCES;
+
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
@@ -855,7 +982,8 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mmget_not_zero(mm))
 		goto free;
 
-	flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
+	flags = (write ? FOLL_WRITE : 0);
+	flags |= __mem_rw_get_foll_force_flag(file);
 
 	while (count > 0) {
 		size_t this_len = min_t(size_t, count, PAGE_SIZE);
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d0..873f7c048a0b3 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -183,6 +183,74 @@ config STATIC_USERMODEHELPER_PATH
 	  If you wish for all usermode helper programs to be disabled,
 	  specify an empty string here (i.e. "").
 
+menu "Procfs mem restriction options"
+
+config PROC_MEM_RESTRICT_FOLL_FORCE_DEFAULT
+	bool "Restrict all FOLL_FORCE flag usage"
+	default n
+	help
+	  Restrict all FOLL_FORCE usage during /proc/*/mem RW.
+	  Debuggers like GDB require using FOLL_FORCE for basic
+	  functionality.
+
+config PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE_DEFAULT
+	bool "Restrict FOLL_FORCE usage except for ptracers"
+	default n
+	help
+	  Restrict FOLL_FORCE usage during /proc/*/mem RW, except
+	  for ptracer processes. Debuggers like GDB require using
+	  FOLL_FORCE for basic functionality.
+
+config PROC_MEM_RESTRICT_OPEN_READ_DEFAULT
+	bool "Restrict all open() read access"
+	default n
+	help
+	  Restrict all open() read access to /proc/*/mem files.
+	  Use with caution: this can break init systems, debuggers,
+	  container supervisors and other tasks using /proc/*/mem.
+
+config PROC_MEM_RESTRICT_OPEN_READ_PTRACE_DEFAULT
+	bool "Restrict open() for reads except for ptracers"
+	default n
+	help
+	  Restrict open() read access except for ptracer processes.
+	  Use with caution: this can break init systems, debuggers,
+	  container supervisors and other non-ptrace capable tasks
+	  using /proc/*/mem.
+
+config PROC_MEM_RESTRICT_OPEN_WRITE_DEFAULT
+	bool "Restrict all open() write access"
+	default n
+	help
+	  Restrict all open() write access to /proc/*/mem files.
+	  Debuggers like GDB and some container supervisors tasks
+	  require opening as RW and may break.
+
+config PROC_MEM_RESTRICT_OPEN_WRITE_PTRACE_DEFAULT
+	bool "Restrict open() for writes except for ptracers"
+	default n
+	help
+	  Restrict open() write access except for ptracer processes,
+	  usually debuggers.
+
+config PROC_MEM_RESTRICT_WRITE_DEFAULT
+	bool "Restrict all write() calls"
+	default n
+	help
+	  Restrict all /proc/*/mem direct write calls.
+	  Open calls with RW modes are still allowed, this blocks
+	  just the write() calls.
+
+config PROC_MEM_RESTRICT_WRITE_PTRACE_DEFAULT
+	bool "Restrict write() calls except for ptracers"
+	default n
+	help
+	  Restrict /proc/*/mem direct write calls except for ptracer processes.
+	  Open calls with RW modes are still allowed, this blocks just
+	  the write() calls.
+
+endmenu
+
 source "security/selinux/Kconfig"
 source "security/smack/Kconfig"
 source "security/tomoyo/Kconfig"
-- 
2.30.2



Return-Path: <linux-fsdevel+bounces-20131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B53C8CEA4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA8C1C20B97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6355A7AB;
	Fri, 24 May 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="34sOzR54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892750263;
	Fri, 24 May 2024 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716578989; cv=none; b=DvR9TayTQAfGAuPYAIaKbU4+PENG0+O0itsOmMXOm0yJP+TYEXQv/c92ldOjAVmWrmAUtZxnkeAZ+ZXLkZPk1VdNGwSRMOnFkGmONZ3sAJqTwX6o6ADJmqZP6AT5bvBz0WOceCeiTsBPDMZ9G6a+FvCjZzj5CyHvL7gswJjkWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716578989; c=relaxed/simple;
	bh=2ota9ETbMMm4d9b+Rjde03LvfpRP9QIhTZEqalpuRZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLtvjdtVez2p21ZZwwo+/xMpQ5vzAb6yk5UhnhCO4ozwewpTUN3K3oXnMBrOKDE/6LPf4ndk5OBRuL30xxs/8/HaP+wmgIU81aXKU3faoqkbS5aZ33nELVSzeCv39/xvAYROMeOlXRrVt6QQ/w53RlJKEYdvxXQrp7GM2oV1AV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=34sOzR54; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716578985;
	bh=2ota9ETbMMm4d9b+Rjde03LvfpRP9QIhTZEqalpuRZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=34sOzR54QW4RHjHaBbgs9kFevVSWKwOHhIKax3uOs4b4eA5R6XNU5Cnosz7yq719Y
	 zXpbOFlqNCndxQmmHqyiKwBB2hee8/63ubxju8DhS10TOBAJHC7hCIqapz/kd74sRK
	 C82MGII7btYOH6j32TfkvvgJhaeIol+IGg3MHrUI1IrTGdpUp76AL9uzyQxWsdhqU6
	 70FKGQvYYPRX/RfS+z0ecwx8HwfWK8U506/rC+znIUHETg53X0rhIY0ifdIqTNEmkZ
	 0TRpUOP8ZgGyScvsRvgufipa+OCHVvKNzqSFN3yJCN4Duev7zc0MN7gxhMnjvBtnCo
	 as3MU/vJO7e7g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 542313782168;
	Fri, 24 May 2024 19:29:44 +0000 (UTC)
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
	Mike Frysinger <vapier@chromium.org>
Subject: [PATCH v4 2/2] proc: restrict /proc/pid/mem
Date: Fri, 24 May 2024 22:28:58 +0300
Message-ID: <20240524192858.3206-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240524192858.3206-1-adrian.ratiu@collabora.com>
References: <20240524192858.3206-1-adrian.ratiu@collabora.com>
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
Co-developed-by: Mike Frysinger <vapier@chromium.org>
Signed-off-by: Mike Frysinger <vapier@chromium.org>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
Changes in v4:
* Renamed parameters to use a fake namespace and respect
  subject-verb-objec pattern (eg proc_mem.restrict_read)
* Replaced static key array with individual definitions.
  Still need 6 key definitions because we need to store 3
  states for each parameter, eg read all/ptrace/DAC states,
  so we need 2 keys for each parameter -- they will not fit
  into just 1 static key.
* Replaced strncmp -> strcmp and dropped redundant helper,
  significantly simplified DEFINE_EARLY_PROC_MEM_RESTRICT
  macro.
* Dropped else from __mem_open_check_access_restriction()
* Moved ptracer check to proc_mem_open to avoid ToCToU
* Added extra mm_access() check for the mem_rw() case
* Found a use case for blocking just writes independent
  of open restrictions, so added a new param
* Added *_DEFAULT Kconfigs
---
 .../admin-guide/kernel-parameters.txt         |  38 ++++++
 fs/proc/base.c                                | 124 +++++++++++++++++-
 security/Kconfig                              |  68 ++++++++++
 3 files changed, 229 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 500cfa776225..3fdfeaefccf2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4792,6 +4792,44 @@
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
index 6faf1b3a4117..9223eaaf055b 100644
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
 
@@ -835,6 +903,56 @@ static int mem_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static bool __mem_rw_current_is_ptracer(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct task_struct *task = get_proc_task(inode);
+	int is_ptracer = false, has_mm_access = false;
+
+	if (task) {
+		rcu_read_lock();
+		is_ptracer = current == ptrace_parent(task);
+		rcu_read_unlock();
+
+		has_mm_access = file->private_data == mm_access(task, PTRACE_MODE_READ_FSCREDS);
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
@@ -847,6 +965,9 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mm)
 		return 0;
 
+	if (write && __mem_rw_block_writes(file))
+		return -EACCES;
+
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
@@ -855,7 +976,8 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mmget_not_zero(mm))
 		goto free;
 
-	flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
+	flags = (write ? FOLL_WRITE : 0);
+	flags |= __mem_rw_get_foll_force_flag(file);
 
 	while (count > 0) {
 		size_t this_len = min_t(size_t, count, PAGE_SIZE);
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d..0cd73f848b5a 100644
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
+	  Debuggerg like GDB require using FOLL_FORCE for basic
+	  functionality.
+
+config PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE_DEFAULT
+	bool "Restrict FOLL_FORCE usage except for ptracers"
+	default n
+	help
+	  Restrict FOLL_FORCE usage during /proc/*/mem RW, except
+	  for ptracer processes. Debuggerg like GDB require using
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
2.44.1



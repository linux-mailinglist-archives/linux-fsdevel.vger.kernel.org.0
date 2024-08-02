Return-Path: <linux-fsdevel+bounces-24851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43267945971
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 10:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671201C2157E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 08:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF61C0DEC;
	Fri,  2 Aug 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PgtGf+SS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE43D6A;
	Fri,  2 Aug 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585813; cv=none; b=t/WJPq+FIzZMdPlnnD69uHuw0/aQBao9nC+hQrUlJfMT1zqMvvuHOwNmJiivrNNSBGvZKDOZclcXoBtPWA84OeqvKRhFmOum81H92XPl/oFLe/RfrIBvDzTn/nkPoI0kRBSxgykeINAZb1kauQHPqJJFlNMJQbUWJ+P3gPbWzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585813; c=relaxed/simple;
	bh=kaMFpxHzNkrDtihVBi54kX+DE52xC/pY5UehobLP9Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gPiz1cpFMG6jK0Nk+7pjaIHsjfokOpISkteO923/pE0sye0F0gwDk5aV57KvA1CtALN/WV0uajYJ/AxXsvOn2/nB74szfrZJVafUaxPfDzoqtgaTC1Bt8kmptfeISvYaSc2rfMsBPbksGEuke0NWQhAccS1OjKd9N073fpl1cd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PgtGf+SS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722585810;
	bh=kaMFpxHzNkrDtihVBi54kX+DE52xC/pY5UehobLP9Qo=;
	h=From:To:Cc:Subject:Date:From;
	b=PgtGf+SS3vqXcgSlHZT/DCu/JHcsY70Bkl3xXMc5XTShbHXgqoAws5LlSaHPQry6u
	 4HixZbwpw2m4EScPp31nvs3sKqIn4uQiGRxLmQ1LMrdZCW/stHXq/44SrW9FCnkyUy
	 FBpqCt3L+oxMol+cCcRxZo91gB9i1LjJXISTRouIu815zK0aUSaCTJ++383IsHJJ7j
	 lhj2LLSs99xtPrG4Mzh1d+o7kwcKjx4YYSMIJMNKTjiV+nsurWbXlfRhjj+8/eR/0N
	 +j1lrwoQjg8JHnvqIfNucpnrpLotE8+srObIdsarEoF71p0ErPdlRNOAdo0bz+6c8D
	 a92XuB4kUiDfQ==
Received: from gentoo.ratioveremundo.com (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0D3FC3782212;
	Fri,  2 Aug 2024 08:03:28 +0000 (UTC)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kernel@collabora.com,
	gbiv@google.com,
	inglorion@google.com,
	ajordanr@google.com,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Doug Anderson <dianders@chromium.org>,
	Jeff Xu <jeffxu@google.com>,
	Jann Horn <jannh@google.com>,
	Kees Cook <kees@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v5] proc: add config & param to block forcing mem writes
Date: Fri,  2 Aug 2024 11:02:25 +0300
Message-ID: <20240802080225.89408-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a Kconfig option and boot param to allow removing
the FOLL_FORCE flag from /proc/pid/mem write calls because
it can be abused.

The traditional forcing behavior is kept as default because
it can break GDB and some other use cases.

Previously we tried a more sophisticated approach allowing
distributions to fine-tune /proc/pid/mem behavior, however
that got NAK-ed by Linus [1], who prefers this simpler
approach with semantics also easier to understand for users.

Link: https://lore.kernel.org/lkml/CAHk-=wiGWLChxYmUA5HrT5aopZrB7_2VTa0NLZcxORgkUe5tEQ@mail.gmail.com/ [1]
Cc: Doug Anderson <dianders@chromium.org>
Cc: Jeff Xu <jeffxu@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
Changes in v5:
* Wrapped task fields accesses in READ_ONCE()
* Added all values to proc_mem_force_table[] and changed
  the default of lookup_constant() to preserve the initial
  value set via Kconfig

Changes in v4:
* Fixed doc punctuation, used passive tense, improved
  wording consistency, fixed default value wording
* Made struct constant_table a static const __initconst
* Reworked proc_mem_foll_force() indentation and var
  declarations to make code clearer
* Reworked enum + struct definition so lookup_constant()
  defaults to 'always'.

Changes in v3:
* Simplified code to use shorthand ifs and a
  lookup_constant() table

Changes in v2:
* Added bootparam on top of Linus' patch
* Slightly reworded commit msg
---
 .../admin-guide/kernel-parameters.txt         | 10 +++
 fs/proc/base.c                                | 61 ++++++++++++++++++-
 security/Kconfig                              | 32 ++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1384c7b59c9..8396e015aab3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4788,6 +4788,16 @@
 	printk.time=	Show timing data prefixed to each printk message line
 			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
 
+	proc_mem.force_override= [KNL]
+			Format: {always | ptrace | never}
+			Traditionally /proc/pid/mem allows memory permissions to be
+			overridden without restrictions. This option may be set to
+			restrict that. Can be one of:
+			- 'always': traditional behavior always allows mem overrides.
+			- 'ptrace': only allow mem overrides for active ptracers.
+			- 'never':  never allow mem overrides.
+			If not specified, default is the CONFIG_PROC_MEM_* choice.
+
 	processor.max_cstate=	[HW,ACPI]
 			Limit processor to maximum C-state
 			max_cstate=9 overrides any DMI blacklist limit.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..f389c69767fa 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -85,6 +85,7 @@
 #include <linux/elf.h>
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
+#include <linux/fs_parser.h>
 #include <linux/fs_struct.h>
 #include <linux/slab.h>
 #include <linux/sched/autogroup.h>
@@ -117,6 +118,40 @@
 static u8 nlink_tid __ro_after_init;
 static u8 nlink_tgid __ro_after_init;
 
+enum proc_mem_force {
+	PROC_MEM_FORCE_ALWAYS,
+	PROC_MEM_FORCE_PTRACE,
+	PROC_MEM_FORCE_NEVER
+};
+
+static enum proc_mem_force proc_mem_force_override __ro_after_init =
+	IS_ENABLED(CONFIG_PROC_MEM_NO_FORCE) ? PROC_MEM_FORCE_NEVER :
+	IS_ENABLED(CONFIG_PROC_MEM_FORCE_PTRACE) ? PROC_MEM_FORCE_PTRACE :
+	PROC_MEM_FORCE_ALWAYS;
+
+static const struct constant_table proc_mem_force_table[] __initconst = {
+	{ "always", PROC_MEM_FORCE_ALWAYS },
+	{ "ptrace", PROC_MEM_FORCE_PTRACE },
+	{ "never", PROC_MEM_FORCE_NEVER },
+	{ }
+};
+
+static int __init early_proc_mem_force_override(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	/*
+	 * lookup_constant() defaults to proc_mem_force_override to preseve
+	 * the initial Kconfig choice in case an invalid param gets passed.
+	 */
+	proc_mem_force_override = lookup_constant(proc_mem_force_table,
+						  buf, proc_mem_force_override);
+
+	return 0;
+}
+early_param("proc_mem.force_override", early_proc_mem_force_override);
+
 struct pid_entry {
 	const char *name;
 	unsigned int len;
@@ -835,6 +870,28 @@ static int mem_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
+{
+	struct task_struct *task;
+	bool ptrace_active = false;
+
+	switch (proc_mem_force_override) {
+	case PROC_MEM_FORCE_NEVER:
+		return false;
+	case PROC_MEM_FORCE_PTRACE:
+		task = get_proc_task(file_inode(file));
+		if (task) {
+			ptrace_active =	READ_ONCE(task->ptrace) &&
+					READ_ONCE(task->mm) == mm &&
+					READ_ONCE(task->parent) == current;
+			put_task_struct(task);
+		}
+		return ptrace_active;
+	default:
+		return true;
+	}
+}
+
 static ssize_t mem_rw(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos, int write)
 {
@@ -855,7 +912,9 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mmget_not_zero(mm))
 		goto free;
 
-	flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
+	flags = write ? FOLL_WRITE : 0;
+	if (proc_mem_foll_force(file, mm))
+		flags |= FOLL_FORCE;
 
 	while (count > 0) {
 		size_t this_len = min_t(size_t, count, PAGE_SIZE);
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d..a93c1a9b7c28 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -19,6 +19,38 @@ config SECURITY_DMESG_RESTRICT
 
 	  If you are unsure how to answer this question, answer N.
 
+choice
+	prompt "Allow /proc/pid/mem access override"
+	default PROC_MEM_ALWAYS_FORCE
+	help
+	  Traditionally /proc/pid/mem allows users to override memory
+	  permissions for users like ptrace, assuming they have ptrace
+	  capability.
+
+	  This allows people to limit that - either never override, or
+	  require actual active ptrace attachment.
+
+	  Defaults to the traditional behavior (for now)
+
+config PROC_MEM_ALWAYS_FORCE
+	bool "Traditional /proc/pid/mem behavior"
+	help
+	  This allows /proc/pid/mem accesses to override memory mapping
+	  permissions if you have ptrace access rights.
+
+config PROC_MEM_FORCE_PTRACE
+	bool "Require active ptrace() use for access override"
+	help
+	  This allows /proc/pid/mem accesses to override memory mapping
+	  permissions for active ptracers like gdb.
+
+config PROC_MEM_NO_FORCE
+	bool "Never"
+	help
+	  Never override memory mapping permissions
+
+endchoice
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.44.2



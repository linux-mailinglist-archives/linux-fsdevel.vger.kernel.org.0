Return-Path: <linux-fsdevel+bounces-24606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E33941315
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAC6284E50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11B719FA87;
	Tue, 30 Jul 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i6r2ymPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0F18FC6E;
	Tue, 30 Jul 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345939; cv=none; b=MqX98F3x9Ua0v2coO/+bBB2/b/LMPaCGKOacY6NhPJ+c0PGh+9JQEDlNjNvL9bZQsby034S5RKnPsLg207HLOHH+x2utkPa+G3Ec/Vuq2kA2dnJqP4HTMUE4ER+Vi/z6+vo9unjRujk7O58MHMQl8s0YvFCuo1iLQiwULYPUQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345939; c=relaxed/simple;
	bh=WT3Bb5gBjWLfxiTfkrDaL+wPbGJlxpfE99B3tCgVJE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAH1VWG5AU1r/ugkTLpGfGBSpKasPfTam6eoOSlnNZhi3U53i+T6gE0q8T55C7ON6US48pye1nAm3J/qpSBpXjnAEHeAWJtnqMIKlWD4Fs+Gi7WGM4NDEcp33+6UMlgita3L8X5rSaEoDkFs/+h8nwx0UzScNpf3zk+ZLG0ZE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i6r2ymPk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722345935;
	bh=WT3Bb5gBjWLfxiTfkrDaL+wPbGJlxpfE99B3tCgVJE0=;
	h=From:To:Cc:Subject:Date:From;
	b=i6r2ymPkk0GsxsZXI5ObZyrXVDEWTM1SgzRiuQNPTczIRkgtGJnrzMko+y03lkMZ+
	 Dt+ZYVH5kKTRdBiC+K6TEc1WZn2IoZ+v4/7lLhNJOImu/kyfZpJst9IoWjOQ7gaMjX
	 Z3kQl1nJuZHxprHguYpslfOHiZ31GWksw0R5kzaWLDjj09gY2k+Dip1wJCKMQbo/la
	 rUknisIm7JjnSCs+XeYi4CGqBC9wytVm8mquSPjFdTZnS14V4q5yADZ+70e95hjojC
	 gY3kV3NtZk3lp51w0AYalkruWwDPtzBbVY9pn6kwQkBLS2pfTQlnd2om8ly+bNuPIg
	 U6k5c+A2DMYyw==
Received: from gentoo.ratioveremundo.com (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D9E4F3781188;
	Tue, 30 Jul 2024 13:25:34 +0000 (UTC)
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
Subject: [PATCH v4] proc: add config & param to block forcing mem writes
Date: Tue, 30 Jul 2024 16:25:28 +0300
Message-ID: <20240730132528.1143520-1-adrian.ratiu@collabora.com>
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
 .../admin-guide/kernel-parameters.txt         | 10 ++++
 fs/proc/base.c                                | 54 ++++++++++++++++++-
 security/Kconfig                              | 32 +++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

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
index 72a1acd03675..daacb8070042 100644
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
@@ -117,6 +118,35 @@
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
+	{ "never", PROC_MEM_FORCE_NEVER },
+	{ "ptrace", PROC_MEM_FORCE_PTRACE },
+	{ }
+};
+
+static int __init early_proc_mem_force_override(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	proc_mem_force_override = lookup_constant(proc_mem_force_table,
+						  buf, PROC_MEM_FORCE_ALWAYS);
+
+	return 0;
+}
+early_param("proc_mem.force_override", early_proc_mem_force_override);
+
 struct pid_entry {
 	const char *name;
 	unsigned int len;
@@ -835,6 +865,26 @@ static int mem_open(struct inode *inode, struct file *file)
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
+			ptrace_active = task->ptrace && task->mm == mm && task->parent == current;
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
@@ -855,7 +905,9 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
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



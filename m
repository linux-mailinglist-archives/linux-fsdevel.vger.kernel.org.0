Return-Path: <linux-fsdevel+bounces-24305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCF593D034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 11:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C088B225DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBCA178365;
	Fri, 26 Jul 2024 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D0yDXv5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88886116;
	Fri, 26 Jul 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985069; cv=none; b=hgBvWL1jAobg4CmM3As9ZMH/pWbo3OidvsDo34cQc5JhRfzxJ1fr5aRbOV0UZXuZs3RKKJUApZoZvVMgiHc3ekUmZ/rvrZ+sQPLqkmnliOqRRrvrWVcUazHe6RrdHNqCX8tEzlGlEvxRhZl8DALRWn0ROt1IZi0Lvm0fRhHF0Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985069; c=relaxed/simple;
	bh=bq3iCME2nAnit/kbDFA2bmrEht0puPIAaBbXD4f/7G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jj10fTTeaKdKKEKexZsicRzscZWxJvJiQ/xWlLVuV38cl7eujim2NMZ4+EWvAr7ORl2vC9RLDhoq4A4VSLIV0rVGiUaIKdE0kUARYzwiJiwZx9/gzNb1utcT8zeJv4QJB9/tFCIWMPjr2HJBxgLfrxQXlQY/2VplYZixcRBkYMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D0yDXv5R; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721985064;
	bh=bq3iCME2nAnit/kbDFA2bmrEht0puPIAaBbXD4f/7G4=;
	h=From:To:Cc:Subject:Date:From;
	b=D0yDXv5RURjaGL6RYrw4S2mI3km2BF/m6xn8fN5qbKb+ap76+jhz8fHxRbyNz4WOQ
	 4y3gCsHZlDMvWCYnBs91Zn/WObe2LBiqE7Ta6SvhhfwjWjsFgYrFEFpyf8Jm7JlFnR
	 ecsC1P2p2pY3IaGI8yO7J5dFPfUPtRV9vMGeiWR2Gb2DZ5km237GoVVZ5/2dFYXRbZ
	 E1zGh43l9sk2Ek1Md6zS353hAiGi1L6Ot0agw5mlb/0ws47MmeNZXuO5KSzf4dcRpm
	 TkDU5wRa4MRz1y34jMuOeaopuf3D4t1PoKfgYjda0brFn0YQiAJ4u+o3yBGtXiM3uw
	 QDlwj3kq/wu9Q==
Received: from gentoo.ratioveremundo.com (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4F04137804D4;
	Fri, 26 Jul 2024 09:11:03 +0000 (UTC)
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
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3] proc: add config & param to block forcing mem writes
Date: Fri, 26 Jul 2024 12:08:58 +0300
Message-ID: <20240726090858.71541-1-adrian.ratiu@collabora.com>
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
Cc: Christian Brauner <brauner@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
Changes in v3:
* Simplified code to use shorthand ifs and a
  lookup_constant() table.

Changes in v2:
* Added bootparam on top of Linus' patch.
* Slightly reworded commit msg.
---
 .../admin-guide/kernel-parameters.txt         | 10 ++++
 fs/proc/base.c                                | 54 ++++++++++++++++++-
 security/Kconfig                              | 32 +++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c1134ad5f06d..793301f360ec 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4791,6 +4791,16 @@
 	printk.time=	Show timing data prefixed to each printk message line
 			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
 
+	proc_mem.force_override= [KNL]
+			Format: {always | ptrace | never}
+			Traditionally /proc/pid/mem allows users to override memory
+			permissions. This allows people to limit that.
+			Can be one of:
+			- 'always' traditional behavior always allows mem overrides.
+			- 'ptrace' only allow for active ptracers.
+			- 'never'  never allow mem permission overrides.
+			If not specified, default is always.
+
 	processor.max_cstate=	[HW,ACPI]
 			Limit processor to maximum C-state
 			max_cstate=9 overrides any DMI blacklist limit.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..0ca3fc3d9e0e 100644
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
+	IS_ENABLED(CONFIG_PROC_MEM_ALWAYS_FORCE) ? PROC_MEM_FORCE_ALWAYS :
+	IS_ENABLED(CONFIG_PROC_MEM_FORCE_PTRACE) ? PROC_MEM_FORCE_PTRACE :
+	PROC_MEM_FORCE_NEVER;
+
+struct constant_table proc_mem_force_table[] = {
+	{ "always", PROC_MEM_FORCE_ALWAYS },
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
+						  buf, PROC_MEM_FORCE_NEVER);
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
+	switch (proc_mem_force_override) {
+	case PROC_MEM_FORCE_NEVER:
+		return false;
+	case PROC_MEM_FORCE_PTRACE: {
+		bool ptrace_active = false;
+		struct task_struct *task = get_proc_task(file_inode(file));
+
+		if (task) {
+			ptrace_active = task->ptrace && task->mm == mm && task->parent == current;
+			put_task_struct(task);
+		}
+		return ptrace_active;
+	}
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



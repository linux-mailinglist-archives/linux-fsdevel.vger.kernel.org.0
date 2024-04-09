Return-Path: <linux-fsdevel+bounces-16466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CE789E1FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8871C21AE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006715698F;
	Tue,  9 Apr 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f4CYRqGJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474C0156863;
	Tue,  9 Apr 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685506; cv=none; b=XNQuHjf/pPCjUeFt0tUwH1KCXptr+FiJnDoS3sl/2pvGU2unr6L4pikGt1XNQCoSXnDjhDmTRsZ+P//3xU8txTFQ0kBKGcq8oDtmFJxgTJMC8x1KZsfToEaUzb53cq4E4tcaSYuKsVgWmQg/XrnJEJJmFFwPs9/qo0lmZpcASl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685506; c=relaxed/simple;
	bh=UWdi+TN6xIGyQZX90sWax8qyNw488wXoKlGHiiGcybc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fERuZBfWKndqqZ3dMOVcdS/8l/9azMJ1vzx7m8dv7NiK8iGg7+VQ+rLanZaoc69uqJjQJG5H4JAJtgOSiBVU/UYwYISEfKyfP/qmR3T09eP5vAu/n/Va9DyP+ZsNQcmb/WYgoJl04cvEhWMXxH8NyQkM0zqHNWFpLB2MmCsN760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f4CYRqGJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712685502;
	bh=UWdi+TN6xIGyQZX90sWax8qyNw488wXoKlGHiiGcybc=;
	h=From:To:Cc:Subject:Date:From;
	b=f4CYRqGJe75VU574Z5+xNKQT1c04p73rXVb2l+xEpBZYIuMaChLCjx7Zdrwp76ROi
	 LE7tKWN7LLKJKiTVMlg5jamQbBH9Hxbcr93YqH10cMnCuPVIM9Siq6QKoQMLCX9nc9
	 gLVP/U0MmCU4EZ2DRzaH9J0ClzrVLMgmaQVvbHv5jTTsY7CazdJriIc9OI3ozVNLvL
	 Fl7rvPer1vD+TXgB8+r/acXZ3g2LcndDPix39qxnIzhBfldHX0DyIBb8m42uqRfgLy
	 YpkquIoTOYQ9n0cEIGRGwTekgvb8MpRqEo2ZqdFg8A4LNPQgxcQSlBpQycjkhPR4C7
	 t5OM5q3laxm1w==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 304253780029;
	Tue,  9 Apr 2024 17:58:21 +0000 (UTC)
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
Subject: [PATCH v3 1/2] proc: restrict /proc/pid/mem access via param knobs
Date: Tue,  9 Apr 2024 20:57:49 +0300
Message-ID: <20240409175750.206445-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.43.2
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

Thus we introduce three kernel parameters to restrict /proc/*/mem
access: read, write and foll_force. All three can be independently
set to the following values:

all     => restrict all access unconditionally.
ptracer => restrict all access except for ptracer processes.

If left unset, the existing behaviour is preserved, i.e. access
is governed by basic file permissions.

Examples which can be passed by bootloaders:

restrict_proc_mem_foll_force=all
restrict_proc_mem_write=ptracer
restrict_proc_mem_read=ptracer

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
 .../admin-guide/kernel-parameters.txt         |  27 +++++
 fs/proc/base.c                                | 103 +++++++++++++++++-
 include/linux/jump_label.h                    |   5 +
 3 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6e62b8cb19c8d..d7f7db41369c7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5665,6 +5665,33 @@
 	reset_devices	[KNL] Force drivers to reset the underlying device
 			during initialization.
 
+	restrict_proc_mem_read= [KNL]
+			Format: {all | ptracer}
+			Allows restricting read access to /proc/*/mem files.
+			Depending on restriction level, open for reads return -EACCESS.
+			Can be one of:
+			- 'all' restricts all access unconditionally.
+			- 'ptracer' allows access only for ptracer processes.
+			If not specified, then basic file permissions continue to apply.
+
+	restrict_proc_mem_write= [KNL]
+			Format: {all | ptracer}
+			Allows restricting write access to /proc/*/mem files.
+			Depending on restriction level, open for writes return -EACCESS.
+			Can be one of:
+			- 'all' restricts all access unconditionally.
+			- 'ptracer' allows access only for ptracer processes.
+			If not specified, then basic file permissions continue to apply.
+
+	restrict_proc_mem_foll_force= [KNL]
+			Format: {all | ptracer}
+			Restricts the use of the FOLL_FORCE flag for /proc/*/mem access.
+			If restricted, the FOLL_FORCE flag will not be added to vm accesses.
+			Can be one of:
+			- 'all' restricts all access unconditionally.
+			- 'ptracer' allows access only for ptracer processes.
+			If not specified, FOLL_FORCE is always used.
+
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
 			Format:
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 18550c071d71c..c733836c42a65 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -152,6 +152,41 @@ struct pid_entry {
 		NULL, &proc_pid_attr_operations,	\
 		{ .lsmid = LSMID })
 
+/*
+ * each restrict_proc_mem_* param controls the following static branches:
+ * key[0] = restrict all writes
+ * key[1] = restrict writes except for ptracers
+ * key[2] = restrict all reads
+ * key[3] = restrict reads except for ptracers
+ * key[4] = restrict all FOLL_FORCE usage
+ * key[5] = restrict FOLL_FORCE usage except for ptracers
+ */
+DEFINE_STATIC_KEY_ARRAY_FALSE_RO(restrict_proc_mem, 6);
+
+static int __init early_restrict_proc_mem(char *buf, int offset)
+{
+	if (!buf)
+		return -EINVAL;
+
+	if (strncmp(buf, "all", 3) == 0)
+		static_branch_enable(&restrict_proc_mem[offset]);
+	else if (strncmp(buf, "ptracer", 7) == 0)
+		static_branch_enable(&restrict_proc_mem[offset + 1]);
+
+	return 0;
+}
+
+#define DEFINE_EARLY_RESTRICT_PROC_MEM(name, offset)			\
+static int __init early_restrict_proc_mem_##name(char *buf)		\
+{									\
+	return early_restrict_proc_mem(buf, offset);			\
+}									\
+early_param("restrict_proc_mem_" #name, early_restrict_proc_mem_##name)
+
+DEFINE_EARLY_RESTRICT_PROC_MEM(write, 0);
+DEFINE_EARLY_RESTRICT_PROC_MEM(read, 2);
+DEFINE_EARLY_RESTRICT_PROC_MEM(foll_force, 4);
+
 /*
  * Count the number of hardlinks for the pid_entry table, excluding the .
  * and .. links.
@@ -825,9 +860,58 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 	return 0;
 }
 
+static bool __mem_open_current_is_ptracer(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct task_struct *task = get_proc_task(inode);
+	int ret = false;
+
+	if (task) {
+		rcu_read_lock();
+		if (current == ptrace_parent(task))
+			ret = true;
+		rcu_read_unlock();
+		put_task_struct(task);
+	}
+
+	return ret;
+}
+
+static int __mem_open_check_access_restriction(struct file *file)
+{
+	if (file->f_mode & FMODE_WRITE) {
+		/* Deny if writes are unconditionally disabled via param */
+		if (static_branch_unlikely(&restrict_proc_mem[0]))
+			return -EACCES;
+
+		/* Deny if writes are allowed only for ptracers via param */
+		if (static_branch_unlikely(&restrict_proc_mem[1]) &&
+		    !__mem_open_current_is_ptracer(file))
+			return -EACCES;
+
+	} else if (file->f_mode & FMODE_READ) {
+		/* Deny if reads are unconditionally disabled via param */
+		if (static_branch_unlikely(&restrict_proc_mem[2]))
+			return -EACCES;
+
+		/* Deny if reads are allowed only for ptracers via param */
+		if (static_branch_unlikely(&restrict_proc_mem[3]) &&
+		    !__mem_open_current_is_ptracer(file))
+			return -EACCES;
+	}
+
+	return 0;
+}
+
 static int mem_open(struct inode *inode, struct file *file)
 {
-	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
+	int ret;
+
+	ret = __mem_open_check_access_restriction(file);
+	if (ret)
+		return ret;
+
+	ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
 
 	/* OK to pass negative loff_t, we can catch out-of-range */
 	file->f_mode |= FMODE_UNSIGNED_OFFSET;
@@ -835,6 +919,20 @@ static int mem_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static unsigned int __mem_rw_get_foll_force_flag(struct file *file)
+{
+	/* Deny if FOLL_FORCE is disabled via param */
+	if (static_branch_unlikely(&restrict_proc_mem[4]))
+		return 0;
+
+	/* Deny if FOLL_FORCE is allowed only for ptracers via param */
+	if (static_branch_unlikely(&restrict_proc_mem[5]) &&
+	    !__mem_open_current_is_ptracer(file))
+		return 0;
+
+	return FOLL_FORCE;
+}
+
 static ssize_t mem_rw(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos, int write)
 {
@@ -855,7 +953,8 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mmget_not_zero(mm))
 		goto free;
 
-	flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
+	flags = (write ? FOLL_WRITE : 0);
+	flags |= __mem_rw_get_foll_force_flag(file);
 
 	while (count > 0) {
 		size_t this_len = min_t(size_t, count, PAGE_SIZE);
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index f5a2727ca4a9a..ba2460fe878c5 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -398,6 +398,11 @@ struct static_key_false {
 		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
 	}
 
+#define DEFINE_STATIC_KEY_ARRAY_FALSE_RO(name, count)		\
+	struct static_key_false name[count] __ro_after_init = {	\
+		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
+	}
+
 #define _DEFINE_STATIC_KEY_1(name)	DEFINE_STATIC_KEY_TRUE(name)
 #define _DEFINE_STATIC_KEY_0(name)	DEFINE_STATIC_KEY_FALSE(name)
 #define DEFINE_STATIC_KEY_MAYBE(cfg, name)			\
-- 
2.30.2



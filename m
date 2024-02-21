Return-Path: <linux-fsdevel+bounces-12354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3484D85E982
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDD11C224A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866888664F;
	Wed, 21 Feb 2024 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rfw6Bzj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38895126F3A;
	Wed, 21 Feb 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549596; cv=none; b=BtmEEpaz339wLeSQ0QohQc3TRhQTC2yTgjW/TtE5755mDAwyo55PU/ZnROObHju8ZlswN6FUQMrV41ExVI6r9CtuCEhTDQ67djkmqbNDeppIAc1821Q17xpfnt5lI9cO52cn2jedYFGt32q3qbJu5aydHZdqPWiQjCYPvWu2nW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549596; c=relaxed/simple;
	bh=8VXcAAJto8svyUnZ97pB7BNBTXBuRwzYNmSFpJXmiLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6148Rj+X7jhOBgmDLSPuy2PM1NBHbX0Bku6gh/XMS667Bt359Xe+VezS7Cq8NiLGeTeQwmb+eUlIVPey1TMEreMZVjvvP+GVy1RLOiR1haigNQDl5JG1sg5t9N1sXsAHJ/0pJDaY9ZDTVLgJzWsU4LT2Sy3z62fAKmq61KyJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rfw6Bzj3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708549593;
	bh=8VXcAAJto8svyUnZ97pB7BNBTXBuRwzYNmSFpJXmiLs=;
	h=From:To:Cc:Subject:Date:From;
	b=Rfw6Bzj3tefn3WJ80NhDISRYJyhzmubBd3g7vnQA01bWTgOvBAuF4u3KfJgDFJ6bo
	 PHAcLX+0Td8RDueLE4WCAlRg9HTPaW2Y8jfyIwFUyYRz8TBoR0aWp7m0qXafnDdeYT
	 joTS2suyoGcf9sKky0E7nFeMtDHOi94M+GFwdiHtjWKfHkGXziB0WhdMXaHHtefe8P
	 7Dvm/fT6c/i6/MRtdw6krH/lsKGeJYgKg75YTelZ0H1hVr9LorZbY3cZ7tIf0aCUjO
	 DtacEfTSJWuWccTgP4xSjcZaCMZWGDHSFfA8/mw+qf67bJBe+dJGNV4kdjsxgmAAwd
	 7D7Eic7Z3uqqg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ED19D37820D3;
	Wed, 21 Feb 2024 21:06:32 +0000 (UTC)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: [PATCH] proc: allow restricting /proc/pid/mem writes
Date: Wed, 21 Feb 2024 23:06:26 +0200
Message-ID: <20240221210626.155534-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.43.0
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

Afterwards exploits appeared started causing drama like [1]. The
/proc/*/mem exploits can be rather sophisticated like [2] which
installed an arbitrary payload from noexec storage into a running
process then exec'd it, which itself could include an ELF loader
to run arbitrary code off noexec storage.

As part of hardening against these types of attacks, distrbutions
can restrict /proc/*/mem to only allow writes when they makes sense,
like in case of debuggers which have ptrace permissions, as they
are able to access memory anyway via PTRACE_POKEDATA and friends.

Dropping the mode bits disables write access for non-root users.
Trying to `chmod` the paths back fails as the kernel rejects it.

For users with CAP_DAC_OVERRIDE (usually just root) we have to
disable the mem_write callback to avoid bypassing the mode bits.

Writes can be used to bypass permissions on memory maps, even if a
memory region is mapped r-x (as is a program's executable pages),
the process can open its own /proc/self/mem file and write to the
pages directly.

Even if seccomp filters block mmap/mprotect calls with W|X perms,
they often cannot block open calls as daemons want to read/write
their own runtime state and seccomp filters cannot check file paths.
Write calls also can't be blocked in general via seccomp.

Since the mem file is part of the dynamic /proc/<pid>/ space, we
can't run chmod once at boot to restrict it (and trying to react
to every process and run chmod doesn't scale, and the kernel no
longer allows chmod on any of these paths).

SELinux could be used with a rule to cover all /proc/*/mem files,
but even then having multiple ways to deny an attack is useful in
case on layer fails.

[1] https://lwn.net/Articles/476947/
[2] https://issues.chromium.org/issues/40089045

Based on an initial patch by Mike Frysinger <vapier@chromium.org>.

Cc: Guenter Roeck <groeck@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Mike Frysinger <vapier@chromium.org>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
Tested on next-20240220.

I would really like to avoid depending on CONFIG_MEMCG which is
required for the struct mm_stryct "owner" pointer.

Any suggestions how check the ptrace owner without MEMCG?
---
 fs/proc/base.c   | 26 ++++++++++++++++++++++++--
 security/Kconfig | 13 +++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 98a031ac2648..e4d6829c5d1a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -152,6 +152,12 @@ struct pid_entry {
 		NULL, &proc_pid_attr_operations,	\
 		{ .lsmid = LSMID })
 
+#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITES
+# define PROC_PID_MEM_MODE S_IRUSR
+#else
+# define PROC_PID_MEM_MODE (S_IRUSR|S_IWUSR)
+#endif
+
 /*
  * Count the number of hardlinks for the pid_entry table, excluding the .
  * and .. links.
@@ -899,7 +905,24 @@ static ssize_t mem_read(struct file *file, char __user *buf,
 static ssize_t mem_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
+#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITES
+	/* Allow processes already ptracing the target process */
+#ifdef CONFIG_MEMCG
+	struct mm_struct *mm = file->private_data;
+
+	rcu_read_lock();
+	if (ptracer_capable(current, mm->user_ns) &&
+	    current == ptrace_parent(mm->owner)) {
+		rcu_read_unlock();
+		return mem_rw(file, (char __user *)buf, count, ppos, 1);
+	}
+	rcu_read_unlock();
+#endif
+
+	return -EACCES;
+#else
 	return mem_rw(file, (char __user*)buf, count, ppos, 1);
+#endif
 }
 
 loff_t mem_lseek(struct file *file, loff_t offset, int orig)
@@ -3281,7 +3303,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_NUMA
 	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
 #endif
-	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
+	REG("mem",        PROC_PID_MEM_MODE, proc_mem_operations),
 	LNK("cwd",        proc_cwd_link),
 	LNK("root",       proc_root_link),
 	LNK("exe",        proc_exe_link),
@@ -3631,7 +3653,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_NUMA
 	REG("numa_maps", S_IRUGO, proc_pid_numa_maps_operations),
 #endif
-	REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
+	REG("mem",       PROC_PID_MEM_MODE, proc_mem_operations),
 	LNK("cwd",       proc_cwd_link),
 	LNK("root",      proc_root_link),
 	LNK("exe",       proc_exe_link),
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d..4082a07a33e5 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -19,6 +19,19 @@ config SECURITY_DMESG_RESTRICT
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_PROC_MEM_RESTRICT_WRITES
+	bool "Restrict /proc/<pid>/mem write access"
+	default n
+	help
+	  This restricts writes to /proc/<pid>/mem, except when the current
+	  process ptraces the /proc/<pid>/mem task, because a ptracer already
+	  has write access to the tracee memory.
+
+	  Write access to this file allows bypassing memory map permissions,
+	  such as modifying read-only code.
+
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.30.2



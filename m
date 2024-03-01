Return-Path: <linux-fsdevel+bounces-13337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89B86EB47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 22:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C7EB23FD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 21:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE158AAA;
	Fri,  1 Mar 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HT5uddga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E152575F;
	Fri,  1 Mar 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328933; cv=none; b=lcqg4yYbZZOBAp1SNA3K9jlwhnY6CgEUoDCXjlRd1LWpgRQCniXsAOKIIfJInFXKqOgOGwgsS165duZFjfFWuG+o9bnYBuRpJGX5kf5/7P0175OYGU1mSO9ZG03BGsXOnxRt4b0/z3fw9SBmeblrhTqRomlwyDAl90VkZZQtzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328933; c=relaxed/simple;
	bh=ovQaWvkaGZ/LnYGPrkBjG38YueW5tZyWNmaAd4cJT+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqXI9iaYyk3ehd02QYhkvi2fUD2vE2qdhDE4ch85W8KmVnLhkRMg1cRT7FCzY/H2r1+nQRtybogDcwaEjhXjgfmanonrA1ndfzeR0SWmcR36gj1ZF+JIGorwr+RvbSKNWJ+MRG4JEM3BIPZfNYgYcLTUwHLu9v/87VTG4Vj6s9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HT5uddga; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709328929;
	bh=ovQaWvkaGZ/LnYGPrkBjG38YueW5tZyWNmaAd4cJT+M=;
	h=From:To:Cc:Subject:Date:From;
	b=HT5uddgaUVon2LEaN6yJDtC6YitYrB2ajbiq0KSRqv5VzTTaeGvVz53y07xxY2l9R
	 QJ/spXcam/3piLZHkPcrBxRAv4BouXNJW3gxcreJUReEgaQx6APmN9tyqhueOb1zZT
	 oRYZ0EMQGZMZu8pC4lI9Syuq/h2iXTfXA9srOHZQAE7JbzfNG3h1zIlmrNwt180Lkb
	 aSwOJBLeXLfNk8PNYOBrVUweqG5yqOgWb3aQwPIamWdLDoBXo0rOalDVOGAIuX46FV
	 4Uzqg+sC8pmb0L/cbffytNEuLO9JtHw8Utf0Lg0TbKM9mrz8QQGowphB3RQZA0AoEt
	 3OGPljWk4gk8g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 09BB7378208B;
	Fri,  1 Mar 2024 21:35:28 +0000 (UTC)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: linux-fsdevel@vger.kernel.org
Cc: kernel@collabora.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Date: Fri,  1 Mar 2024 23:34:42 +0200
Message-ID: <20240301213442.198443-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.44.0
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
Cc: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>
Co-developed-by: Mike Frysinger <vapier@chromium.org>
Signed-off-by: Mike Frysinger <vapier@chromium.org>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
Changes in v2:
 * Added boot time parameter with default kconfig option
 * Moved check earlier in mem_open() instead of mem_write()
 * Simplified implementation branching
 * Removed dependency on CONFIG_MEMCG
---
 .../admin-guide/kernel-parameters.txt         |  4 ++
 fs/proc/base.c                                | 47 ++++++++++++++++++-
 security/Kconfig                              | 22 +++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 460b97a1d0da..0647e2f54248 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5618,6 +5618,10 @@
 	reset_devices	[KNL] Force drivers to reset the underlying device
 			during initialization.
 
+	restrict_proc_mem_write= [KNL]
+			Enable or disable write access to /proc/*/mem files.
+			Default is SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON.
+
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
 			Format:
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 98a031ac2648..92f668191312 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -152,6 +152,30 @@ struct pid_entry {
 		NULL, &proc_pid_attr_operations,	\
 		{ .lsmid = LSMID })
 
+#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE
+DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON,
+			   restrict_proc_mem_write);
+static int __init early_restrict_proc_mem_write(char *buf)
+{
+	int ret;
+	bool bool_result;
+
+	ret = kstrtobool(buf, &bool_result);
+	if (ret)
+		return ret;
+
+	if (bool_result)
+		static_branch_enable(&restrict_proc_mem_write);
+	else
+		static_branch_disable(&restrict_proc_mem_write);
+	return 0;
+}
+early_param("restrict_proc_mem_write", early_restrict_proc_mem_write);
+# define PROC_PID_MEM_MODE S_IRUSR
+#else
+# define PROC_PID_MEM_MODE (S_IRUSR|S_IWUSR)
+#endif
+
 /*
  * Count the number of hardlinks for the pid_entry table, excluding the .
  * and .. links.
@@ -829,6 +853,25 @@ static int mem_open(struct inode *inode, struct file *file)
 {
 	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
 
+#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE
+	struct mm_struct *mm = file->private_data;
+	struct task_struct *task = get_proc_task(inode);
+
+	if (mm && task) {
+		/* Only allow writes by processes already ptracing the target task */
+		if (file->f_mode & FMODE_WRITE &&
+		    static_branch_maybe(CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON,
+					&restrict_proc_mem_write)) {
+			rcu_read_lock();
+			if (!ptracer_capable(current, mm->user_ns) ||
+			    current != ptrace_parent(task))
+				ret = -EACCES;
+			rcu_read_unlock();
+		}
+		put_task_struct(task);
+	}
+#endif
+
 	/* OK to pass negative loff_t, we can catch out-of-range */
 	file->f_mode |= FMODE_UNSIGNED_OFFSET;
 
@@ -3281,7 +3324,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_NUMA
 	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
 #endif
-	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
+	REG("mem",        PROC_PID_MEM_MODE, proc_mem_operations),
 	LNK("cwd",        proc_cwd_link),
 	LNK("root",       proc_root_link),
 	LNK("exe",        proc_exe_link),
@@ -3631,7 +3674,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_NUMA
 	REG("numa_maps", S_IRUGO, proc_pid_numa_maps_operations),
 #endif
-	REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
+	REG("mem",       PROC_PID_MEM_MODE, proc_mem_operations),
 	LNK("cwd",       proc_cwd_link),
 	LNK("root",      proc_root_link),
 	LNK("exe",       proc_exe_link),
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d..ffee9e847ed9 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -19,6 +19,28 @@ config SECURITY_DMESG_RESTRICT
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_PROC_MEM_RESTRICT_WRITE
+	bool "Restrict /proc/*/mem write access"
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
+config SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON
+	bool "Default state of /proc/*/mem write restriction"
+	depends on SECURITY_PROC_MEM_RESTRICT_WRITE
+	default y
+	help
+	  /proc/*/mem write access is controlled by kernel boot param
+	  "restrict_proc_mem_write" and this config chooses the default
+	  boot state.
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.30.2



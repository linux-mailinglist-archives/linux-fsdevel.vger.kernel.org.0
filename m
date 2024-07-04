Return-Path: <linux-fsdevel+bounces-23155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1AD927D8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806E21C238E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BF6132122;
	Thu,  4 Jul 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RoJpMmrw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB213D608;
	Thu,  4 Jul 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119739; cv=none; b=Yle/pfJV+2JqAwIpTxMRbH/w1cbrg8E0fHKnPrFpbFSmoOx4FQg3CKleopzwN/CmgKURA/mAvIgoVOhZuOJAnsAqIwYsnfXqo98fm4FpBotJcXvnRokZdF7UZYS6HbIZH+DHL9KHwCM9imyrEGvS5SWqSA6pzdoWMBzjPgzwMsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119739; c=relaxed/simple;
	bh=QkSeR/S7n24t9rwdBxmCu1WbP7aeAIrwOrKa2VVZbjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoxNucjD78ljwxXLfIxVcXSoFFPQVOqClycV+XMpJ3zpw5ke6Mw/dG6EvXN4kQMZIxwtpXWj8xdHvYTOa3Ho32N0REmUJw+D8ZGVXMMifoOzzphBh+CUpM+/OePhfsOp/p04mkxFem1w2qDhOar+Z1SRX/V17z8emeK5kXHWNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RoJpMmrw; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WFQxW5nlpzC3q;
	Thu,  4 Jul 2024 21:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720119727;
	bh=Y9d96OsDMPb7+yCSisfZWoz+qtMBDpJ4FX9JzX/byVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RoJpMmrwajgMIZzj+FDE8d2fMbX6V4zlKWa7FHgUGq82BsioXPo8PzYQfoHIFVUkz
	 TV8A2QFNZM2+q+h0r43ok920fl0wvuPue9FRnVPait38jkHnUbIUXrLRWLEaLimXlR
	 1rX+c3eFRYDpywr2XT9ozXTEknnIa3ZHKGwnQiAQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WFQxR1bl1z3JG;
	Thu,  4 Jul 2024 21:02:03 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	Theodore Ts'o <tytso@mit.edu>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alejandro Colomar <alx.manpages@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Date: Thu,  4 Jul 2024 21:01:33 +0200
Message-ID: <20240704190137.696169-2-mic@digikod.net>
In-Reply-To: <20240704190137.696169-1-mic@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a new AT_CHECK flag to execveat(2) to check if a file would be
allowed for execution.  The main use case is for script interpreters and
dynamic linkers to check execution permission according to the kernel's
security policy. Another use case is to add context to access logs e.g.,
which script (instead of interpreter) accessed a file.  As any
executable code, scripts could also use this check [1].

This is different than faccessat(2) which only checks file access
rights, but not the full context e.g. mount point's noexec, stack limit,
and all potential LSM extra checks (e.g. argv, envp, credentials).
Since the use of AT_CHECK follows the exact kernel semantic as for a
real execution, user space gets the same error codes.

With the information that a script interpreter is about to interpret a
script, an LSM security policy can adjust caller's access rights or log
execution request as for native script execution (e.g. role transition).
This is possible thanks to the call to security_bprm_creds_for_exec().

Because LSMs may only change bprm's credentials, use of AT_CHECK with
current kernel code should not be a security issue (e.g. unexpected role
transition).  LSMs willing to update the caller's credential could now
do so when bprm->is_check is set.  Of course, such policy change should
be in line with the new user space code.

Because AT_CHECK is dedicated to user space interpreters, it doesn't
make sense for the kernel to parse the checked files, look for
interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
if the format is unknown.  Because of that, security_bprm_check() is
never called when AT_CHECK is used.

It should be noted that script interpreters cannot directly use
execveat(2) (without this new AT_CHECK flag) because this could lead to
unexpected behaviors e.g., `python script.sh` could lead to Bash being
executed to interpret the script.  Unlike the kernel, script
interpreters may just interpret the shebang as a simple comment, which
should not change for backward compatibility reasons.

Because scripts or libraries files might not currently have the
executable permission set, or because we might want specific users to be
allowed to run arbitrary scripts, the following patch provides a dynamic
configuration mechanism with the SECBIT_SHOULD_EXEC_CHECK and
SECBIT_SHOULD_EXEC_RESTRICT securebits.

This is a redesign of the CLIP OS 4's O_MAYEXEC:
https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
This patch has been used for more than a decade with customized script
interpreters.  Some examples can be found here:
https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Link: https://docs.python.org/3/library/io.html#io.open_code [1]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240704190137.696169-2-mic@digikod.net
---

New design since v18:
https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
---
 fs/exec.c                  |  5 +++--
 include/linux/binfmts.h    |  7 ++++++-
 include/uapi/linux/fcntl.h | 30 ++++++++++++++++++++++++++++++
 kernel/audit.h             |  1 +
 kernel/auditsc.c           |  1 +
 5 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..ea2a1867afdc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -931,7 +931,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 		.lookup_flags = LOOKUP_FOLLOW,
 	};
 
-	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_CHECK)) != 0)
 		return ERR_PTR(-EINVAL);
 	if (flags & AT_SYMLINK_NOFOLLOW)
 		open_exec_flags.lookup_flags &= ~LOOKUP_FOLLOW;
@@ -1595,6 +1595,7 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
 		bprm->filename = bprm->fdpath;
 	}
 	bprm->interp = bprm->filename;
+	bprm->is_check = !!(flags & AT_CHECK);
 
 	retval = bprm_mm_init(bprm);
 	if (!retval)
@@ -1885,7 +1886,7 @@ static int bprm_execve(struct linux_binprm *bprm)
 
 	/* Set the unchanging part of bprm->cred */
 	retval = security_bprm_creds_for_exec(bprm);
-	if (retval)
+	if (retval || bprm->is_check)
 		goto out;
 
 	retval = exec_binprm(bprm);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 70f97f685bff..8ff9c9e33aed 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -42,7 +42,12 @@ struct linux_binprm {
 		 * Set when errors can no longer be returned to the
 		 * original userspace.
 		 */
-		point_of_no_return:1;
+		point_of_no_return:1,
+		/*
+		 * Set by user space to check executability according to the
+		 * caller's environment.
+		 */
+		is_check:1;
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
 	struct file *file;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index c0bcc185fa48..bcd05c59b7df 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -118,6 +118,36 @@
 #define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
 					compare object identity and may not
 					be usable to open_by_handle_at(2) */
+
+/*
+ * AT_CHECK only performs a check on a regular file and returns 0 if execution
+ * of this file would be allowed, ignoring the file format and then the related
+ * interpreter dependencies (e.g. ELF libraries, script's shebang).  AT_CHECK
+ * should only be used if SECBIT_SHOULD_EXEC_CHECK is set for the calling
+ * thread.  See securebits.h documentation.
+ *
+ * Programs should use this check to apply kernel-level checks against files
+ * that are not directly executed by the kernel but directly passed to a user
+ * space interpreter instead.  All files that contain executable code, from the
+ * point of view of the interpreter, should be checked.  The main purpose of
+ * this flag is to improve the security and consistency of an execution
+ * environment to ensure that direct file execution (e.g. ./script.sh) and
+ * indirect file execution (e.g. sh script.sh) lead to the same result.  For
+ * instance, this can be used to check if a file is trustworthy according to
+ * the caller's environment.
+ *
+ * In a secure environment, libraries and any executable dependencies should
+ * also be checked.  For instance dynamic linking should make sure that all
+ * libraries are allowed for execution to avoid trivial bypass (e.g. using
+ * LD_PRELOAD).  For such secure execution environment to make sense, only
+ * trusted code should be executable, which also requires integrity guarantees.
+ *
+ * To avoid race conditions leading to time-of-check to time-of-use issues,
+ * AT_CHECK should be used with AT_EMPTY_PATH to check against a file
+ * descriptor instead of a path.
+ */
+#define AT_CHECK		0x10000
+
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000
 #endif
diff --git a/kernel/audit.h b/kernel/audit.h
index a60d2840559e..8ebdabd2ab81 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -197,6 +197,7 @@ struct audit_context {
 		struct open_how openat2;
 		struct {
 			int			argc;
+			bool			is_check;
 		} execve;
 		struct {
 			char			*name;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..b6316e284342 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2662,6 +2662,7 @@ void __audit_bprm(struct linux_binprm *bprm)
 
 	context->type = AUDIT_EXECVE;
 	context->execve.argc = bprm->argc;
+	context->execve.is_check = bprm->is_check;
 }
 
 
-- 
2.45.2



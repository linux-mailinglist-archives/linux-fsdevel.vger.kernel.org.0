Return-Path: <linux-fsdevel+bounces-23157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E998D927DA0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE891F23DF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194143219F;
	Thu,  4 Jul 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qDP+FohS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEFC12FB2A
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120328; cv=none; b=n7q4jduU6XznV1eeyXs8V7tuBs5c3UTxtFx1osHQUcnzCIUQmsv6T+13nVLceZsZ3b7ANJ808PzfhAfWaGXJ+PbN6+pXdjjnUCAfnnczHx0dADN9YRxzrWgbgXEV6jh5If10//MhXaEJu4uq+X4WdmJJYxDgP4dEIdK/MWAcULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120328; c=relaxed/simple;
	bh=EBHdqI81Shfe7Ji2XgN1x+T8QX1m9WCcGRjbASaPEi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWYBlddf85dwzH39p4ymU1xvE/AoFOZm1FKu8FL3rKN32X5unkIom9yV3gnf8cDNh0EoZYI4EhVZ9vNI48HUlYDxH6nqbck56OGhWZ5H9MBR4axz5MMQ7c9dqEQ8oImEpppwPIrM+oD4SdyW29FMvrekGDlNX8Etq/Ii5qOTIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qDP+FohS; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WFQxX6ncnz157l;
	Thu,  4 Jul 2024 21:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720119728;
	bh=vlgO1yPB2S138oeh4MchQUq5CiNsXtuZszsawNERxBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDP+FohSa9f5xw0vJOaviMSAXsyQWam0Xx9SyLOrW3xaNe305z7EM3RN2aP6++27k
	 CQnxUkS0Ytdxe17Vk7PtTTw6QNab0pAqj4c7bTaN2u31LglVcO4K80jbxaFCj2lhIq
	 yUyequX2BN91Fu4sQv5yZEiM9rhXzXijUDXRkzf4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WFQxX1QNszVW3;
	Thu,  4 Jul 2024 21:02:08 +0200 (CEST)
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
Subject: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and SHOULD_EXEC_RESTRICT securebits
Date: Thu,  4 Jul 2024 21:01:34 +0200
Message-ID: <20240704190137.696169-3-mic@digikod.net>
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

These new SECBIT_SHOULD_EXEC_CHECK, SECBIT_SHOULD_EXEC_RESTRICT, and
their *_LOCKED counterparts are designed to be set by processes setting
up an execution environment, such as a user session, a container, or a
security sandbox.  Like seccomp filters or Landlock domains, the
securebits are inherited across proceses.

When SECBIT_SHOULD_EXEC_CHECK is set, programs interpreting code should
check executable resources with execveat(2) + AT_CHECK (see previous
patch).

When SECBIT_SHOULD_EXEC_RESTRICT is set, a process should only allow
execution of approved resources, if any (see SECBIT_SHOULD_EXEC_CHECK).

For a secure environment, we might also want
SECBIT_SHOULD_EXEC_CHECK_LOCKED and SECBIT_SHOULD_EXEC_RESTRICT_LOCKED
to be set.  For a test environment (e.g. testing on a fleet to identify
potential issues), only the SECBIT_SHOULD_EXEC_CHECK* bits can be set to
still be able to identify potential issues (e.g. with interpreters logs
or LSMs audit entries).

It should be noted that unlike other security bits, the
SECBIT_SHOULD_EXEC_CHECK and SECBIT_SHOULD_EXEC_RESTRICT bits are
dedicated to user space willing to restrict itself.  Because of that,
they only make sense in the context of a trusted environment (e.g.
sandbox, container, user session, full system) where the process
changing its behavior (according to these bits) and all its parent
processes are trusted.  Otherwise, any parent process could just execute
its own malicious code (interpreting a script or not), or even enforce a
seccomp filter to mask these bits.

Such a secure environment can be achieved with an appropriate access
control policy (e.g. mount's noexec option, file access rights, LSM
configuration) and an enlighten ld.so checking that libraries are
allowed for execution e.g., to protect against illegitimate use of
LD_PRELOAD.

Scripts may need some changes to deal with untrusted data (e.g. stdin,
environment variables), but that is outside the scope of the kernel.

The only restriction enforced by the kernel is the right to ptrace
another process.  Processes are denied to ptrace less restricted ones,
unless the tracer has CAP_SYS_PTRACE.  This is mainly a safeguard to
avoid trivial privilege escalations e.g., by a debugging process being
abused with a confused deputy attack.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240704190137.696169-3-mic@digikod.net
---

New design since v18:
https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
---
 include/uapi/linux/securebits.h | 56 ++++++++++++++++++++++++++++-
 security/commoncap.c            | 63 ++++++++++++++++++++++++++++-----
 2 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/securebits.h
index d6d98877ff1a..3fdb0382718b 100644
--- a/include/uapi/linux/securebits.h
+++ b/include/uapi/linux/securebits.h
@@ -52,10 +52,64 @@
 #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
 			(issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED))
 
+/*
+ * When SECBIT_SHOULD_EXEC_CHECK is set, a process should check all executable
+ * files with execveat(2) + AT_CHECK.  However, such check should only be
+ * performed if all to-be-executed code only comes from regular files.  For
+ * instance, if a script interpreter is called with both a script snipped as
+ * argument and a regular file, the interpreter should not check any file.
+ * Doing otherwise would mislead the kernel to think that only the script file
+ * is being executed, which could for instance lead to unexpected permission
+ * change and break current use cases.
+ *
+ * This secure bit may be set by user session managers, service managers,
+ * container runtimes, sandboxer tools...  Except for test environments, the
+ * related SECBIT_SHOULD_EXEC_CHECK_LOCKED bit should also be set.
+ *
+ * Ptracing another process is deny if the tracer has SECBIT_SHOULD_EXEC_CHECK
+ * but not the tracee.  SECBIT_SHOULD_EXEC_CHECK_LOCKED also checked.
+ */
+#define SECURE_SHOULD_EXEC_CHECK		8
+#define SECURE_SHOULD_EXEC_CHECK_LOCKED		9  /* make bit-8 immutable */
+
+#define SECBIT_SHOULD_EXEC_CHECK (issecure_mask(SECURE_SHOULD_EXEC_CHECK))
+#define SECBIT_SHOULD_EXEC_CHECK_LOCKED \
+			(issecure_mask(SECURE_SHOULD_EXEC_CHECK_LOCKED))
+
+/*
+ * When SECBIT_SHOULD_EXEC_RESTRICT is set, a process should only allow
+ * execution of approved files, if any (see SECBIT_SHOULD_EXEC_CHECK).  For
+ * instance, script interpreters called with a script snippet as argument
+ * should always deny such execution if SECBIT_SHOULD_EXEC_RESTRICT is set.
+ * However, if a script interpreter is called with both
+ * SECBIT_SHOULD_EXEC_CHECK and SECBIT_SHOULD_EXEC_RESTRICT, they should
+ * interpret the provided script files if no unchecked code is also provided
+ * (e.g. directly as argument).
+ *
+ * This secure bit may be set by user session managers, service managers,
+ * container runtimes, sandboxer tools...  Except for test environments, the
+ * related SECBIT_SHOULD_EXEC_RESTRICT_LOCKED bit should also be set.
+ *
+ * Ptracing another process is deny if the tracer has
+ * SECBIT_SHOULD_EXEC_RESTRICT but not the tracee.
+ * SECBIT_SHOULD_EXEC_RESTRICT_LOCKED is also checked.
+ */
+#define SECURE_SHOULD_EXEC_RESTRICT		10
+#define SECURE_SHOULD_EXEC_RESTRICT_LOCKED	11  /* make bit-8 immutable */
+
+#define SECBIT_SHOULD_EXEC_RESTRICT (issecure_mask(SECURE_SHOULD_EXEC_RESTRICT))
+#define SECBIT_SHOULD_EXEC_RESTRICT_LOCKED \
+			(issecure_mask(SECURE_SHOULD_EXEC_RESTRICT_LOCKED))
+
 #define SECURE_ALL_BITS		(issecure_mask(SECURE_NOROOT) | \
 				 issecure_mask(SECURE_NO_SETUID_FIXUP) | \
 				 issecure_mask(SECURE_KEEP_CAPS) | \
-				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE))
+				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE) | \
+				 issecure_mask(SECURE_SHOULD_EXEC_CHECK) | \
+				 issecure_mask(SECURE_SHOULD_EXEC_RESTRICT))
 #define SECURE_ALL_LOCKS	(SECURE_ALL_BITS << 1)
 
+#define SECURE_ALL_UNPRIVILEGED (issecure_mask(SECURE_SHOULD_EXEC_CHECK) | \
+				 issecure_mask(SECURE_SHOULD_EXEC_RESTRICT))
+
 #endif /* _UAPI_LINUX_SECUREBITS_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index 162d96b3a676..34b4493e2a69 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -117,6 +117,33 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
 	return 0;
 }
 
+static bool ptrace_secbits_allowed(const struct cred *tracer,
+				   const struct cred *tracee)
+{
+	const unsigned long tracer_secbits = SECURE_ALL_UNPRIVILEGED &
+					     tracer->securebits;
+	const unsigned long tracee_secbits = SECURE_ALL_UNPRIVILEGED &
+					     tracee->securebits;
+	/* Ignores locking of unset secure bits (cf. SECURE_ALL_LOCKS). */
+	const unsigned long tracer_locked = (tracer_secbits << 1) &
+					    tracer->securebits;
+	const unsigned long tracee_locked = (tracee_secbits << 1) &
+					    tracee->securebits;
+
+	/* The tracee must not have less constraints than the tracer. */
+	if ((tracer_secbits | tracee_secbits) != tracee_secbits)
+		return false;
+
+	/*
+	 * Makes sure that the tracer's locks for restrictions are the same for
+	 * the tracee.
+	 */
+	if ((tracer_locked | tracee_locked) != tracee_locked)
+		return false;
+
+	return true;
+}
+
 /**
  * cap_ptrace_access_check - Determine whether the current process may access
  *			   another
@@ -146,7 +173,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 	else
 		caller_caps = &cred->cap_permitted;
 	if (cred->user_ns == child_cred->user_ns &&
-	    cap_issubset(child_cred->cap_permitted, *caller_caps))
+	    cap_issubset(child_cred->cap_permitted, *caller_caps) &&
+	    ptrace_secbits_allowed(cred, child_cred))
 		goto out;
 	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
@@ -178,7 +206,8 @@ int cap_ptrace_traceme(struct task_struct *parent)
 	cred = __task_cred(parent);
 	child_cred = current_cred();
 	if (cred->user_ns == child_cred->user_ns &&
-	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
+	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted) &&
+	    ptrace_secbits_allowed(cred, child_cred))
 		goto out;
 	if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
@@ -1302,21 +1331,39 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 		     & (old->securebits ^ arg2))			/*[1]*/
 		    || ((old->securebits & SECURE_ALL_LOCKS & ~arg2))	/*[2]*/
 		    || (arg2 & ~(SECURE_ALL_LOCKS | SECURE_ALL_BITS))	/*[3]*/
-		    || (cap_capable(current_cred(),
-				    current_cred()->user_ns,
-				    CAP_SETPCAP,
-				    CAP_OPT_NONE) != 0)			/*[4]*/
 			/*
 			 * [1] no changing of bits that are locked
 			 * [2] no unlocking of locks
 			 * [3] no setting of unsupported bits
-			 * [4] doing anything requires privilege (go read about
-			 *     the "sendmail capabilities bug")
 			 */
 		    )
 			/* cannot change a locked bit */
 			return -EPERM;
 
+		/*
+		 * Doing anything requires privilege (go read about the
+		 * "sendmail capabilities bug"), except for unprivileged bits.
+		 * Indeed, the SECURE_ALL_UNPRIVILEGED bits are not
+		 * restrictions enforced by the kernel but by user space on
+		 * itself.  The kernel is only in charge of protecting against
+		 * privilege escalation with ptrace protections.
+		 */
+		if (cap_capable(current_cred(), current_cred()->user_ns,
+				CAP_SETPCAP, CAP_OPT_NONE) != 0) {
+			const unsigned long unpriv_and_locks =
+				SECURE_ALL_UNPRIVILEGED |
+				SECURE_ALL_UNPRIVILEGED << 1;
+			const unsigned long changed = old->securebits ^ arg2;
+
+			/* For legacy reason, denies non-change. */
+			if (!changed)
+				return -EPERM;
+
+			/* Denies privileged changes. */
+			if (changed & ~unpriv_and_locks)
+				return -EPERM;
+		}
+
 		new = prepare_creds();
 		if (!new)
 			return -ENOMEM;
-- 
2.45.2



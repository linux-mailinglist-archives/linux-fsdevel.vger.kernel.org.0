Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4A7260CE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 10:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgIHICN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 04:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbgIHIAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:00:36 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E79FC061786
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2020 01:00:15 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BlyHV5v0DzlhYvB;
        Tue,  8 Sep 2020 10:00:06 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4BlyHT6BDPzlh8TV;
        Tue,  8 Sep 2020 10:00:05 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Subject: [RFC PATCH v8 2/3] fs,doc: Enable to configure exec checks for AT_INTERPRETED
Date:   Tue,  8 Sep 2020 09:59:55 +0200
Message-Id: <20200908075956.1069018-3-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075956.1069018-1-mic@digikod.net>
References: <20200908075956.1069018-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

This enables to configure a policy for executable scripts which can be
queried with faccessat2(2) and the AT_INTERPRETED flag.  This may allow
script interpreters to check execution permission before reading
commands from a file, or dynamic linkers to allow shared object loading.
This may be seen as a way for a trusted task (e.g. interpreter) to check
the trustworthiness of files (e.g. scripts) before extending its control
flow graph with new ones originating from these files.

Add a new sysctl fs.interpreted_access to enable system administrators
to enforce two complementary security policies according to the
installed system: enforce the noexec mount option, and enforce
executable file permission.  Indeed, because of compatibility with
installed systems, only system administrators are able to check that
this new enforcement is in line with the system mount points and file
permissions.

Being able to restrict execution also enables to protect the kernel by
restricting arbitrary syscalls that an attacker could perform with a
crafted binary or certain script languages.  It also improves multilevel
isolation by reducing the ability of an attacker to use side channels
with specific code.  These restrictions can natively be enforced for ELF
binaries (with the noexec mount option) but require this kernel
extension to properly handle scripts (e.g. Python, Perl).  To get a
consistent execution policy, additional memory restrictions should also
be enforced (e.g. thanks to SELinux).

Because the AT_INTERPRETED flag combined with X_OK mode is a mean to
enforce a system-wide security policy (but not application-centric
policies), it does not make sense for user space to check the sysctl
value.  Indeed, this new flag only enables to extend the system ability
to enforce a policy thanks to (some trusted) user space collaboration.
Moreover, additional security policies could be managed by LSMs.  This
is a best-effort approach from the application developer point of view:
https://lore.kernel.org/lkml/1477d3d7-4b36-afad-7077-a38f42322238@digikod.net/

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
---

Changes since v7:
* Handle special file descriptors.
* Add a compatibility mode for execute/read check.
* Move the sysctl policy from fs/namei.c to fs/open.c for the new
  faccessat2/AT_INTERPRETED.
* Rename the sysctl from fs.open_mayexec_enforce to
  fs.interpreted_access .
* Update documentation accordingly.

Changes since v6:
* Allow opening pipes, block devices and character devices with
  O_MAYEXEC when there is no enforced policy, but forbid any non-regular
  file opened with O_MAYEXEC otherwise (i.e. for any enforced policy).
* Add a paragraph about the non-regular files policy.
* Move path_noexec() calls out of the fast-path (suggested by Kees
  Cook).

Changes since v5:
* Remove the static enforcement configuration through Kconfig because it
  makes the code more simple like this, and because the current sysctl
  configuration can only be set with CAP_SYS_ADMIN, the same way mount
  options (i.e. noexec) can be set.  If an harden distro wants to
  enforce a configuration, it should restrict capabilities or sysctl
  configuration.  Furthermore, an LSM can easily leverage O_MAYEXEC to
  fit its need.
* Move checks from inode_permission() to may_open() and make the error
  codes more consistent according to file types (in line with a previous
  commit): opening a directory with O_MAYEXEC returns EISDIR and other
  non-regular file types may return EACCES.
* In may_open(), when OMAYEXEC_ENFORCE_FILE is set, replace explicit
  call to generic_permission() with an artificial MAY_EXEC to avoid
  double calls.  This makes sense especially when an LSM policy forbids
  execution of a file.
* Replace the custom proc_omayexec() with
  proc_dointvec_minmax_sysadmin(), and then replace the CAP_MAC_ADMIN
  check with a CAP_SYS_ADMIN one (suggested by Kees Cook and Stephen
  Smalley).
* Use BIT() (suggested by Kees Cook).
* Rename variables (suggested by Kees Cook).
* Reword the kconfig help.
* Import the documentation patch (suggested by Kees Cook):
  https://lore.kernel.org/lkml/20200505153156.925111-6-mic@digikod.net/
* Update documentation and add LWN.net article.

Changes since v4:
* Add kernel configuration options to enforce O_MAYEXEC at build time,
  and disable the sysctl in such case (requested by James Morris).
* Reword commit message.

Changes since v3:
* Update comment with O_MAYEXEC.

Changes since v2:
* Cosmetic changes.

Changes since v1:
* Move code from Yama to the FS subsystem (suggested by Kees Cook).
* Make omayexec_inode_permission() static (suggested by Jann Horn).
* Use mode 0600 for the sysctl.
* Only match regular files (not directories nor other types), which
  follows the same semantic as commit 73601ea5b7b1 ("fs/open.c: allow
  opening only regular files during execve()").
---
 Documentation/admin-guide/sysctl/fs.rst | 54 +++++++++++++++++++++++++
 fs/open.c                               | 38 ++++++++++++++++-
 include/linux/fs.h                      |  1 +
 kernel/sysctl.c                         | 12 +++++-
 4 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index f48277a0a850..66d1c1bd67a5 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -36,6 +36,7 @@ Currently, these files are in /proc/sys/fs:
 - inode-max
 - inode-nr
 - inode-state
+- interpreted_access
 - nr_open
 - overflowuid
 - overflowgid
@@ -165,6 +166,59 @@ system needs to prune the inode list instead of allocating
 more.
 
 
+interpreted_access
+------------------
+
+The ``AT_INTERPRETED`` flag with an ``X_OK`` mode can be passed to
+:manpage:`faccessat2(2)` by an interpreter to check that regular files are
+expected to be executable.  If the file is not identified as executable, then
+the syscall returns -EACCES.  This may allow a script interpreter to check
+executable permission before reading commands from a file, or a dynamic linker
+to only load executable shared objects.  One interesting use case is to enforce
+a "write xor execute" policy through interpreters.
+
+To avoid race-conditions, it is highly recommended to first open the file and
+then do the check on the new file descriptor thanks to the ``AT_EMPTY_PATH``
+flag.
+
+The ability to restrict code execution must be thought as a system-wide policy,
+which first starts by restricting mount points with the ``noexec`` option.
+This option is also automatically applied to special filesystems such as /proc .
+This prevents files on such mount points to be directly executed by the kernel
+or mapped as executable memory (e.g. libraries).  With script interpreters
+using :manpage:`faccessat2(2)` and ``AT_INTERPRETED``, the executable
+permission can then be checked before reading commands from files.  This makes
+it possible to enforce the ``noexec`` at the interpreter level, and thus
+propagates this security policy to scripts.  To be fully effective, these
+interpreters also need to handle the other ways to execute code: command line
+parameters (e.g., option ``-e`` for Perl), module loading (e.g., option ``-m``
+for Python), stdin, file sourcing, environment variables, configuration files,
+etc.  According to the threat model, it may be acceptable to allow some script
+interpreters (e.g. Bash) to interpret commands from stdin, may it be a TTY or a
+pipe, because it may not be enough to (directly) perform syscalls.
+
+There are two complementary security policies: enforce the ``noexec`` mount
+option, and enforce executable file permission.  These policies are handled by
+the ``fs.interpreted_access`` sysctl (writable only with ``CAP_SYS_ADMIN``)
+as a bitmask:
+
+1 - Mount restriction: checks that the mount options for the underlying VFS
+    mount do not prevent execution.
+
+2 - File permission restriction: checks that the file is marked as
+    executable for the current process (e.g., POSIX permissions, ACLs).
+
+Note that as long as a policy is enforced, checking any non-regular file with
+``AT_INTERPRETED`` returns -EINVAL (e.g. TTYs, pipe), even when such a file is
+marked as executable or is on an executable mount point.
+
+Code samples can be found in
+tools/testing/selftests/interpreter/interpreted_access_test.c and interpreter
+patches (for the original O_MAYEXEC) are available at
+https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC .
+See also an overview article: https://lwn.net/Articles/820000/ .
+
+
 overflowgid & overflowuid
 -------------------------
 
diff --git a/fs/open.c b/fs/open.c
index 879bdfbdc6fa..ef01ab35449d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -32,6 +32,7 @@
 #include <linux/ima.h>
 #include <linux/dnotify.h>
 #include <linux/compat.h>
+#include <linux/sysctl.h>
 
 #include "internal.h"
 
@@ -394,6 +395,11 @@ static const struct cred *access_override_creds(void)
 	return old_cred;
 }
 
+#define INTERPRETED_EXEC_MOUNT		BIT(0)
+#define INTERPRETED_EXEC_FILE		BIT(1)
+
+int sysctl_interpreted_access __read_mostly;
+
 static long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
 {
 	struct path path;
@@ -443,13 +449,43 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 		 */
 		if ((mode & MAY_EXEC)) {
 			mode |= MAY_INTERPRETED_EXEC;
+			res = -EACCES;
+			/*
+			 * If there is a system-wide execute policy enforced,
+			 * then forbids access to non-regular files and special
+			 * superblocks.
+			 */
+			if ((sysctl_interpreted_access & (INTERPRETED_EXEC_MOUNT |
+							INTERPRETED_EXEC_FILE))) {
+				if (!S_ISREG(inode->i_mode))
+					goto out_path_release;
+				/*
+				 * Denies access to pseudo filesystems that
+				 * will never be mountable (e.g. sockfs,
+				 * pipefs) but can still be reachable through
+				 * /proc/self/fd, or memfd-like file
+				 * descriptors, or nsfs-like files.
+				 *
+				 * According to the tests, SB_NOEXEC seems to
+				 * be only used by proc and nsfs filesystems.
+				 * Is it correct?
+				 */
+				if ((path.dentry->d_sb->s_flags &
+							(SB_NOUSER | SB_KERNMOUNT | SB_NOEXEC)))
+					goto out_path_release;
+			}
+
+			if ((sysctl_interpreted_access & INTERPRETED_EXEC_MOUNT) &&
+					path_noexec(&path))
+				goto out_path_release;
 			/*
 			 * For compatibility reasons, if the system-wide policy
 			 * doesn't enforce file permission checks, then
 			 * replaces the execute permission request with a read
 			 * permission request.
 			 */
-			mode &= ~MAY_EXEC;
+			if (!(sysctl_interpreted_access & INTERPRETED_EXEC_FILE))
+				mode &= ~MAY_EXEC;
 			/* To be executed *by* user space, files must be readable. */
 			mode |= MAY_READ;
 		}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 03f1b2da6a87..ef39550f2464 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -83,6 +83,7 @@ extern int sysctl_protected_symlinks;
 extern int sysctl_protected_hardlinks;
 extern int sysctl_protected_fifos;
 extern int sysctl_protected_regular;
+extern int sysctl_interpreted_access;
 
 typedef __kernel_rwf_t rwf_t;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 09e70ee2332e..899fa52b4ee8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -113,6 +113,7 @@ static int sixty = 60;
 
 static int __maybe_unused neg_one = -1;
 static int __maybe_unused two = 2;
+static int __maybe_unused three = 3;
 static int __maybe_unused four = 4;
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
@@ -887,7 +888,6 @@ static int proc_taint(struct ctl_table *table, int write,
 	return err;
 }
 
-#ifdef CONFIG_PRINTK
 static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -896,7 +896,6 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 
 	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 }
-#endif
 
 /**
  * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
@@ -3293,6 +3292,15 @@ static struct ctl_table fs_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
+	{
+		.procname       = "interpreted_access",
+		.data           = &sysctl_interpreted_access,
+		.maxlen         = sizeof(int),
+		.mode           = 0600,
+		.proc_handler	= proc_dointvec_minmax_sysadmin,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= &three,
+	},
 #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
 	{
 		.procname	= "binfmt_misc",
-- 
2.28.0


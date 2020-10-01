Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7A3280487
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbgJARDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 13:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732853AbgJARC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:02:56 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8B2C0613E2
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 10:02:56 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4C2KFB0hgFzlhNHp;
        Thu,  1 Oct 2020 19:02:54 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4C2KF94PN8zlh8TM;
        Thu,  1 Oct 2020 19:02:53 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v11 1/3] fs: Add trusted_for(2) syscall implementation and related sysctl
Date:   Thu,  1 Oct 2020 19:02:30 +0200
Message-Id: <20201001170232.522331-2-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001170232.522331-1-mic@digikod.net>
References: <20201001170232.522331-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

The trusted_for() syscall enables user space tasks to check that files
are trusted to be executed or interpreted by user space.  This may allow
script interpreters to check execution permission before reading
commands from a file, or dynamic linkers to allow shared object loading.
This may be seen as a way for a trusted task (e.g. interpreter) to check
the trustworthiness of files (e.g. scripts) before extending its control
flow graph with new ones originating from these files.

The security policy is consistently managed by the kernel through the
new sysctl: fs.trust_policy .  This enables system administrators to
enforce two complementary security policies according to the installed
system: enforce the noexec mount option, and enforce executable file
permission.  Indeed, because of compatibility with installed systems,
only system administrators are able to check that this new enforcement
is in line with the system mount points and file permissions.

For this to be possible, script interpreters must use trusted_for(2)
with the TRUSTED_FOR_EXECUTION usage.  To be fully effective, these
interpreters also need to handle the other ways to execute code: command
line parameters (e.g., option -e for Perl), module loading (e.g., option
-m for Python), stdin, file sourcing, environment variables,
configuration files, etc.  According to the threat model, it may be
acceptable to allow some script interpreters (e.g. Bash) to interpret
commands from stdin, may it be a TTY or a pipe, because it may not be
enough to (directly) perform syscalls.

Even without enforced security policy, user space interpreters can use
this syscall to try as much as possible to enforce the system policy at
their level, knowing that it will not break anything on running systems
which do not care about this feature.  However, on systems which want
this feature enforced, there will be knowledgeable people (i.e. system
administrator who configured fs.trust_policy deliberately) to manage it.

Because trusted_for(2) is a mean to enforce a system-wide security
policy (but not application-centric policies), it does not make sense
for user space to check the sysctl value.  Indeed, this new flag only
enables to extend the system ability to enforce a policy thanks to (some
trusted) user space collaboration.  Moreover, additional security
policies could be managed by LSMs.  This is a best-effort approach from
the application developer point of view:
https://lore.kernel.org/lkml/1477d3d7-4b36-afad-7077-a38f42322238@digikod.net/

trusted_for(2) with TRUSTED_FOR_EXECUTION should not be confused with
the O_EXEC flag (for open) which is intended for execute-only, which
obviously doesn't work for scripts.  However, a similar behavior could
be implemented in user space with O_PATH:
https://lore.kernel.org/lkml/1e2f6913-42f2-3578-28ed-567f6a4bdda1@digikod.net/

Being able to restrict execution also enables to protect the kernel by
restricting arbitrary syscalls that an attacker could perform with a
crafted binary or certain script languages.  It also improves multilevel
isolation by reducing the ability of an attacker to use side channels
with specific code.  These restrictions can natively be enforced for ELF
binaries (with the noexec mount option) but require this kernel
extension to properly handle scripts (e.g. Python, Perl).  To get a
consistent execution policy, additional memory restrictions should also
be enforced (e.g. thanks to SELinux).

This is a new implementation of a patch initially written by
Vincent Strubel for CLIP OS 4:
https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
This patch has been used for more than 12 years with customized script
interpreters.  Some examples (with the original O_MAYEXEC) can be found
here:
https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC

Co-developed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
---

Changes since v10:
* Add enum definition to syscalls.h .

Changes since v9:
* Rename the syscall to trusted_for(2) and the sysctl to fs.trust_policy
* Add a dedicated enum trusted_for_usage with include/uapi/linux/trusted-for.h
* Remove the extra MAY_INTROSPECTION_EXEC bit.  LSMs can still implement
  this feature themselves.

Changes since v8:
* Add a dedicated syscall introspect_access() (requested by Al Viro).
* Rename MAY_INTERPRETED_EXEC to MAY_INTROSPECTION_EXEC .
* Rename the sysctl fs.interpreted_access to fs.introspection_policy .
* Update documentation.

Changes since v7:
* Replaces openat2/O_MAYEXEC with faccessat2/X_OK/AT_INTERPRETED .
  Switching to an FD-based syscall was suggested by Al Viro and Jann
  Horn.
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
* Do not set __FMODE_EXEC for now because of inconsistent behavior:
  https://lore.kernel.org/lkml/202007160822.CCDB5478@keescook/
* Returns EISDIR when opening a directory with O_MAYEXEC.
* Removed Deven Bowers and Kees Cook Reviewed-by tags because of the
  current update.

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
* Switch back to O_MAYEXEC, but only handle it with openat2(2) which
  checks unknown flags (suggested by Aleksa Sarai). Cf.
  https://lore.kernel.org/lkml/20200430015429.wuob7m5ofdewubui@yavin.dot.cyphar.com/

Changes since v2:
* Replace O_MAYEXEC with RESOLVE_MAYEXEC from openat2(2).  This change
  enables to not break existing application using bogus O_* flags that
  may be ignored by current kernels by using a new dedicated flag, only
  usable through openat2(2) (suggested by Jeff Layton).  Using this flag
  will results in an error if the running kernel does not support it.
  User space needs to manage this case, as with other RESOLVE_* flags.
  The best effort approach to security (for most common distros) will
  simply consists of ignoring such an error and retry without
  RESOLVE_MAYEXEC.  However, a fully controlled system may which to
  error out if such an inconsistency is detected.
* Cosmetic changes.

Changes since v1:
* Set __FMODE_EXEC when using O_MAYEXEC to make this information
  available through the new fanotify/FAN_OPEN_EXEC event (suggested by
  Jan Kara and Matthew Bobrowski):
  https://lore.kernel.org/lkml/20181213094658.GA996@lithium.mbobrowski.org/
* Move code from Yama to the FS subsystem (suggested by Kees Cook).
* Make omayexec_inode_permission() static (suggested by Jann Horn).
* Use mode 0600 for the sysctl.
* Only match regular files (not directories nor other types), which
  follows the same semantic as commit 73601ea5b7b1 ("fs/open.c: allow
  opening only regular files during execve()").
---
 Documentation/admin-guide/sysctl/fs.rst | 50 ++++++++++++++++
 fs/open.c                               | 77 +++++++++++++++++++++++++
 include/linux/fs.h                      |  1 +
 include/linux/syscalls.h                |  2 +
 include/uapi/linux/trusted-for.h        | 18 ++++++
 kernel/sysctl.c                         | 12 +++-
 6 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/trusted-for.h

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index f48277a0a850..c163ae050bdd 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -48,6 +48,7 @@ Currently, these files are in /proc/sys/fs:
 - suid_dumpable
 - super-max
 - super-nr
+- trust_policy
 
 
 aio-nr & aio-max-nr
@@ -382,3 +383,52 @@ Each "watch" costs roughly 90 bytes on a 32bit kernel, and roughly 160 bytes
 on a 64bit one.
 The current default value for  max_user_watches  is the 1/32 of the available
 low memory, divided for the "watch" cost in bytes.
+
+
+trust_policy
+------------
+
+An interpreter can call :manpage:`trusted_for(2)` with a
+``TRUSTED_FOR_EXECUTION`` usage to check that opened regular files are expected
+to be executable.  If the file is not identified as executable, then the
+syscall returns -EACCES.  This may allow a script interpreter to check
+executable permission before reading commands from a file, or a dynamic linker
+to only load executable shared objects.  One interesting use case is to enforce
+a "write xor execute" policy through interpreters.
+
+The ability to restrict code execution must be thought as a system-wide policy,
+which first starts by restricting mount points with the ``noexec`` option.
+This option is also automatically applied to special filesystems such as /proc .
+This prevents files on such mount points to be directly executed by the kernel
+or mapped as executable memory (e.g. libraries).  With script interpreters
+using :manpage:`trusted_for(2)`, the executable permission can then be checked
+before reading commands from files.  This makes it possible to enforce the
+``noexec`` at the interpreter level, and thus propagates this security policy
+to scripts.  To be fully effective, these interpreters also need to handle the
+other ways to execute code: command line parameters (e.g., option ``-e`` for
+Perl), module loading (e.g., option ``-m`` for Python), stdin, file sourcing,
+environment variables, configuration files, etc.  According to the threat
+model, it may be acceptable to allow some script interpreters (e.g.  Bash) to
+interpret commands from stdin, may it be a TTY or a pipe, because it may not be
+enough to (directly) perform syscalls.
+
+There are two complementary security policies: enforce the ``noexec`` mount
+option, and enforce executable file permission.  These policies are handled by
+the ``fs.trust_policy`` sysctl (writable only with ``CAP_SYS_ADMIN``) as a
+bitmask:
+
+1 - Mount restriction: checks that the mount options for the underlying VFS
+    mount do not prevent execution.
+
+2 - File permission restriction: checks that the file is marked as
+    executable for the current process (e.g., POSIX permissions, ACLs).
+
+Note that as long as a policy is enforced, checking any non-regular file with
+:manpage:`trusted_for(2)` returns -EACCES (e.g. TTYs, pipe), even when such a
+file is marked as executable or is on an executable mount point.
+
+Code samples can be found in
+tools/testing/selftests/interpreter/trust_policy_test.c and interpreter patches
+(for the original O_MAYEXEC) are available at
+https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC .
+See also an overview article: https://lwn.net/Articles/820000/ .
diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..25f63314e105 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -32,6 +32,8 @@
 #include <linux/ima.h>
 #include <linux/dnotify.h>
 #include <linux/compat.h>
+#include <linux/sysctl.h>
+#include <uapi/linux/trusted-for.h>
 
 #include "internal.h"
 
@@ -482,6 +484,81 @@ SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 	return do_faccessat(AT_FDCWD, filename, mode, 0);
 }
 
+#define TRUST_POLICY_EXEC_MOUNT			BIT(0)
+#define TRUST_POLICY_EXEC_FILE			BIT(1)
+
+int sysctl_trust_policy __read_mostly;
+
+SYSCALL_DEFINE3(trusted_for, const int, fd, const enum trusted_for_usage, usage,
+		const u32, flags)
+{
+	int mask, err = -EACCES;
+	struct fd f;
+	struct inode *inode;
+
+	if (flags)
+		return -EINVAL;
+
+	/* Only handles execution for now. */
+	if (usage != TRUSTED_FOR_EXECUTION)
+		return -EINVAL;
+	mask = MAY_EXEC;
+
+	f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+	inode = d_backing_inode(f.file->f_path.dentry);
+
+	/*
+	 * For compatibility reasons, without a defined security policy, we
+	 * must map the execute permission to the read permission.  Indeed,
+	 * from user space point of view, being able to execute data (e.g.
+	 * scripts) implies to be able to read this data.
+	 */
+	if ((mask & MAY_EXEC)) {
+		/*
+		 * If there is a system-wide execute policy enforced, then
+		 * forbids access to non-regular files and special superblocks.
+		 */
+		if ((sysctl_trust_policy & (TRUST_POLICY_EXEC_MOUNT |
+						TRUST_POLICY_EXEC_FILE))) {
+			if (!S_ISREG(inode->i_mode))
+				goto out_fd;
+			/*
+			 * Denies access to pseudo filesystems that will never
+			 * be mountable (e.g. sockfs, pipefs) but can still be
+			 * reachable through /proc/self/fd, or memfd-like file
+			 * descriptors, or nsfs-like files.
+			 *
+			 * According to the selftests, SB_NOEXEC seems to be
+			 * only used by proc and nsfs filesystems.
+			 */
+			if ((f.file->f_path.dentry->d_sb->s_flags &
+						(SB_NOUSER | SB_KERNMOUNT | SB_NOEXEC)))
+				goto out_fd;
+		}
+
+		if ((sysctl_trust_policy & TRUST_POLICY_EXEC_MOUNT) &&
+				path_noexec(&f.file->f_path))
+			goto out_fd;
+		/*
+		 * For compatibility reasons, if the system-wide policy doesn't
+		 * enforce file permission checks, then replaces the execute
+		 * permission request with a read permission request.
+		 */
+		if (!(sysctl_trust_policy & TRUST_POLICY_EXEC_FILE))
+			mask &= ~MAY_EXEC;
+		/* To be executed *by* user space, files must be readable. */
+		mask |= MAY_READ;
+	}
+
+	err = inode_permission(inode, mask | MAY_ACCESS);
+
+out_fd:
+	fdput(f);
+	return err;
+}
+
 SYSCALL_DEFINE1(chdir, const char __user *, filename)
 {
 	struct path path;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a08..a9b25674b128 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -83,6 +83,7 @@ extern int sysctl_protected_symlinks;
 extern int sysctl_protected_hardlinks;
 extern int sysctl_protected_fifos;
 extern int sysctl_protected_regular;
+extern int sysctl_trust_policy;
 
 typedef __kernel_rwf_t rwf_t;
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 75ac7f8ae93c..90bbf30eb6e9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -68,6 +68,7 @@ union bpf_attr;
 struct io_uring_params;
 struct clone_args;
 struct open_how;
+enum trusted_for_usage;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -429,6 +430,7 @@ asmlinkage long sys_fallocate(int fd, int mode, loff_t offset, loff_t len);
 asmlinkage long sys_faccessat(int dfd, const char __user *filename, int mode);
 asmlinkage long sys_faccessat2(int dfd, const char __user *filename, int mode,
 			       int flags);
+asmlinkage long sys_trusted_for(int fd, enum trusted_for_usage usage, u32 flags);
 asmlinkage long sys_chdir(const char __user *filename);
 asmlinkage long sys_fchdir(unsigned int fd);
 asmlinkage long sys_chroot(const char __user *filename);
diff --git a/include/uapi/linux/trusted-for.h b/include/uapi/linux/trusted-for.h
new file mode 100644
index 000000000000..cc4f030c5103
--- /dev/null
+++ b/include/uapi/linux/trusted-for.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_TRUSTED_FOR_H
+#define _UAPI_LINUX_TRUSTED_FOR_H
+
+/**
+ * enum trusted_for_usage - Usage for which a file descriptor is trusted
+ *
+ * Argument of trusted_for(2).
+ */
+enum trusted_for_usage {
+	/**
+	 * @TRUSTED_FOR_EXECUTION: Check that the data read from a file
+	 * descriptor is trusted to be executed or interpreted (e.g. scripts).
+	 */
+	TRUSTED_FOR_EXECUTION = 1,
+};
+
+#endif /* _UAPI_LINUX_TRUSTED_FOR_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index afad085960b8..b33b63a8388c 100644
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
@@ -3301,6 +3300,15 @@ static struct ctl_table fs_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
+	{
+		.procname       = "trust_policy",
+		.data           = &sysctl_trust_policy,
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


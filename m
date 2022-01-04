Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8265348450E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 16:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiADPpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 10:45:20 -0500
Received: from smtp-8fa9.mail.infomaniak.ch ([83.166.143.169]:43481 "EHLO
        smtp-8fa9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235050AbiADPpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:45:17 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4JSxlF6tS6zMqwsy;
        Tue,  4 Jan 2022 16:45:13 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4JSxlF3gFTzlhMBf;
        Tue,  4 Jan 2022 16:45:13 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v18 2/4] fs: Add trusted_for(2) syscall implementation and related sysctl
Date:   Tue,  4 Jan 2022 16:50:22 +0100
Message-Id: <20220104155024.48023-3-mic@digikod.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104155024.48023-1-mic@digikod.net>
References: <20220104155024.48023-1-mic@digikod.net>
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
new sysctl: fs.trusted_for_policy .  This enables system administrators
to enforce two complementary security policies according to the
installed system: enforce the noexec mount option, and enforce
executable file permission.  Indeed, because of compatibility with
installed systems, only system administrators are able to check that
this new enforcement is in line with the system mount points and file
permissions.

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
administrator who configured fs.trusted_for_policy deliberately) to
manage it.

Because trusted_for(2) is a mean to enforce a system-wide security
policy (but not application-centric policies), it does not make sense
for user space to check the sysctl value.  Indeed, this new syscall only
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
This patch has been used for more than 13 years with customized script
interpreters.  Some examples (with the original O_MAYEXEC) can be found
here:
https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Co-developed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
---

Changes since v17:
* Move the trusted_for_policy sysctl to a dedicated table in fs/open.c
  to make kernel/sysctl.c easier to maintain.

Changes since v16:
* Replace the enum trusted_for_usage with an int in the syscall
  signature to avoid C unspecified behavior (suggested by Alejandro
  Colomar).  This is mostly a cosmetic fix according to the current
  kernel compilers and used options, but let's remove
  implementation-defined hazard.

Changes since v14:
* Add full syscall documentation (requested by Andrew Morton).

Changes since v13:
* Rename sysctl from "trust_policy" to "trusted_for_policy" (suggested
  by Kees Cook).
* Add Acked-by Kees Cook.

Changes since v12:
* Update inode_permission() call to allign with commit 47291baa8ddf
  ("namei: make permission helpers idmapped mount aware").
* Switch from d_backing_inode(f.file->f_path.dentry) to
  file_inode(f.file).

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
 Documentation/admin-guide/sysctl/fs.rst |  50 +++++++++
 fs/open.c                               | 133 ++++++++++++++++++++++++
 fs/proc/proc_sysctl.c                   |   2 +-
 include/linux/syscalls.h                |   1 +
 include/linux/sysctl.h                  |   1 +
 include/uapi/linux/trusted-for.h        |  18 ++++
 6 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/trusted-for.h

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 2a501c9ddc55..e364d6c45790 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -48,6 +48,7 @@ Currently, these files are in /proc/sys/fs:
 - suid_dumpable
 - super-max
 - super-nr
+- trusted_for_policy
 
 
 aio-nr & aio-max-nr
@@ -382,3 +383,52 @@ Each "watch" costs roughly 90 bytes on a 32bit kernel, and roughly 160 bytes
 on a 64bit one.
 The current default value for  max_user_watches  is the 1/25 (4%) of the
 available low memory, divided for the "watch" cost in bytes.
+
+
+trusted_for_policy
+------------------
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
+the ``fs.trusted_for_policy`` sysctl (writable only with ``CAP_SYS_ADMIN``) as
+a bitmask:
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
index 9ff2f621b760..cf4cddc4e3f5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -33,6 +33,8 @@
 #include <linux/dnotify.h>
 #include <linux/compat.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/sysctl.h>
+#include <uapi/linux/trusted-for.h>
 
 #include "internal.h"
 
@@ -481,6 +483,137 @@ SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 	return do_faccessat(AT_FDCWD, filename, mode, 0);
 }
 
+#define TRUST_POLICY_EXEC_MOUNT			BIT(0)
+#define TRUST_POLICY_EXEC_FILE			BIT(1)
+
+static int sysctl_trusted_for_policy __read_mostly;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table open_sysctls[] = {
+	{
+		.procname       = "trusted_for_policy",
+		.data           = &sysctl_trusted_for_policy,
+		.maxlen         = sizeof(int),
+		.mode           = 0600,
+		.proc_handler	= proc_dointvec_minmax_sysadmin,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_THREE,
+	},
+	{ }
+};
+
+static int __init init_fs_open_sysctls(void)
+{
+	register_sysctl_init("fs", open_sysctls);
+	return 0;
+}
+fs_initcall(init_fs_open_sysctls);
+#endif /* CONFIG_SYSCTL */
+
+/**
+ * sys_trusted_for - Check that a FD is trusted for a specific usage
+ *
+ * @fd: File descriptor to check.
+ * @usage: Identify the user space usage (defined by enum trusted_for_usage)
+ *         intended for the file descriptor (only TRUSTED_FOR_EXECUTION for
+ *         now).
+ *
+ * @flags: Must be 0.
+ *
+ * This system call enables user space to ask the kernel: is this file
+ * descriptor's content trusted to be used for this purpose?  The set of @usage
+ * currently only contains TRUSTED_FOR_EXECUTION, but other may follow (e.g.
+ * configuration, sensitive data).  If the kernel identifies the file
+ * descriptor as trustworthy for this usage, this call returns 0 and the caller
+ * should then take this information into account.
+ *
+ * The execution usage means that the content of the file descriptor is trusted
+ * according to the system policy to be executed by user space, which means
+ * that it interprets the content or (try to) maps it as executable memory.
+ *
+ * A simple system-wide security policy can be set by the system administrator
+ * through a sysctl configuration consistent with the mount points or the file
+ * access rights: Documentation/admin-guide/sysctl/fs.rst
+ *
+ * @flags could be used in the future to do complementary checks (e.g.
+ * signature or integrity requirements, origin of the file).
+ *
+ * Possible returned errors are:
+ *
+ * - EINVAL: unknown @usage or unknown @flags;
+ * - EBADF: @fd is not a file descriptor for the calling thread;
+ * - EACCES: the requested usage is denied (and user space should enforce it).
+ */
+SYSCALL_DEFINE3(trusted_for, const int, fd, const int, usage, const u32, flags)
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
+	inode = file_inode(f.file);
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
+		if ((sysctl_trusted_for_policy & (TRUST_POLICY_EXEC_MOUNT |
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
+		if ((sysctl_trusted_for_policy & TRUST_POLICY_EXEC_MOUNT) &&
+				path_noexec(&f.file->f_path))
+			goto out_fd;
+		/*
+		 * For compatibility reasons, if the system-wide policy doesn't
+		 * enforce file permission checks, then replaces the execute
+		 * permission request with a read permission request.
+		 */
+		if (!(sysctl_trusted_for_policy & TRUST_POLICY_EXEC_FILE))
+			mask &= ~MAY_EXEC;
+		/* To be executed *by* user space, files must be readable. */
+		mask |= MAY_READ;
+	}
+
+	err = inode_permission(file_mnt_user_ns(f.file), inode,
+			mask | MAY_ACCESS);
+
+out_fd:
+	fdput(f);
+	return err;
+}
+
 SYSCALL_DEFINE1(chdir, const char __user *, filename)
 {
 	struct path path;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index a553ed36c0b8..949281dbc6a8 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -26,7 +26,7 @@ static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
 /* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, INT_MAX, 65535 };
+const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, INT_MAX, 65535, 3 };
 EXPORT_SYMBOL(sysctl_vals);
 
 const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 819c0cb00b6d..f812521be8e7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -462,6 +462,7 @@ asmlinkage long sys_fallocate(int fd, int mode, loff_t offset, loff_t len);
 asmlinkage long sys_faccessat(int dfd, const char __user *filename, int mode);
 asmlinkage long sys_faccessat2(int dfd, const char __user *filename, int mode,
 			       int flags);
+asmlinkage long sys_trusted_for(int fd, int usage, u32 flags);
 asmlinkage long sys_chdir(const char __user *filename);
 asmlinkage long sys_fchdir(unsigned int fd);
 asmlinkage long sys_chroot(const char __user *filename);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index cf1ba98aab50..7e55f3475952 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -51,6 +51,7 @@ struct ctl_dir;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 #define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
+#define SYSCTL_THREE			((void *)&sysctl_vals[11])
 
 extern const int sysctl_vals[];
 
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
-- 
2.34.1


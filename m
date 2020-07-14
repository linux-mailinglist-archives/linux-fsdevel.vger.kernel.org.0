Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1655821F8F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 20:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgGNSRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 14:17:00 -0400
Received: from smtp-42ad.mail.infomaniak.ch ([84.16.66.173]:47709 "EHLO
        smtp-42ad.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729188AbgGNSQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:16:59 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B5pd35KySzlhbgx;
        Tue, 14 Jul 2020 20:16:55 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4B5pd31hkCzlh8TF;
        Tue, 14 Jul 2020 20:16:55 +0200 (CEST)
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
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 5/7] fs,doc: Enable to enforce noexec mounts or file exec through O_MAYEXEC
Date:   Tue, 14 Jul 2020 20:16:36 +0200
Message-Id: <20200714181638.45751-6-mic@digikod.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714181638.45751-1-mic@digikod.net>
References: <20200714181638.45751-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow for the enforcement of the O_MAYEXEC openat2(2) flag.  Thanks to
the noexec option from the underlying VFS mount, or to the file execute
permission, userspace can enforce these execution policies.  This may
allow script interpreters to check execution permission before reading
commands from a file, or dynamic linkers to allow shared object loading.

Add a new sysctl fs.open_mayexec_enforce to enable system administrators
to enforce two complementary security policies according to the
installed system: enforce the noexec mount option, and enforce
executable file permission.  Indeed, because of compatibility with
installed systems, only system administrators are able to check that
this new enforcement is in line with the system mount points and file
permissions.  A following patch adds documentation.

Being able to restrict execution also enables to protect the kernel by
restricting arbitrary syscalls that an attacker could perform with a
crafted binary or certain script languages.  It also improves multilevel
isolation by reducing the ability of an attacker to use side channels
with specific code.  These restrictions can natively be enforced for ELF
binaries (with the noexec mount option) but require this kernel
extension to properly handle scripts (e.g., Python, Perl).  To get a
consistent execution policy, additional memory restrictions should also
be enforced (e.g. thanks to SELinux).

Because the O_MAYEXEC flag is a meant to enforce a system-wide security
policy (but not application-centric policies), it does not make sense
for userland to check the sysctl value.  Indeed, this new flag only
enables to extend the system ability to enforce a policy thanks to (some
trusted) userland collaboration.  Moreover, additional security policies
could be managed by LSMs.  This is a best-effort approach from the
application developer point of view:
https://lore.kernel.org/lkml/1477d3d7-4b36-afad-7077-a38f42322238@digikod.net/

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>
---

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
 Documentation/admin-guide/sysctl/fs.rst | 45 +++++++++++++++++++++++++
 fs/namei.c                              | 29 +++++++++++++---
 include/linux/fs.h                      |  1 +
 kernel/sysctl.c                         | 12 +++++--
 4 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 2a45119e3331..02ec384b8bbf 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -37,6 +37,7 @@ Currently, these files are in /proc/sys/fs:
 - inode-nr
 - inode-state
 - nr_open
+- open_mayexec_enforce
 - overflowuid
 - overflowgid
 - pipe-user-pages-hard
@@ -165,6 +166,50 @@ system needs to prune the inode list instead of allocating
 more.
 
 
+open_mayexec_enforce
+--------------------
+
+While being ignored by :manpage:`open(2)` and :manpage:`openat(2)`, the
+``O_MAYEXEC`` flag can be passed to :manpage:`openat2(2)` to only open regular
+files that are expected to be executable.  If the file is not identified as
+executable, then the syscall returns -EACCES.  This may allow a script
+interpreter to check executable permission before reading commands from a file,
+or a dynamic linker to only load executable shared objects.  One interesting
+use case is to enforce a "write xor execute" policy through interpreters.
+
+The ability to restrict code execution must be thought as a system-wide policy,
+which first starts by restricting mount points with the ``noexec`` option.
+This option is also automatically applied to special filesystems such as /proc
+.  This prevents files on such mount points to be directly executed by the
+kernel or mapped as executable memory (e.g. libraries).  With script
+interpreters using the ``O_MAYEXEC`` flag, the executable permission can then
+be checked before reading commands from files. This makes it possible to
+enforce the ``noexec`` at the interpreter level, and thus propagates this
+security policy to scripts.  To be fully effective, these interpreters also
+need to handle the other ways to execute code: command line parameters (e.g.,
+option ``-e`` for Perl), module loading (e.g., option ``-m`` for Python),
+stdin, file sourcing, environment variables, configuration files, etc.
+According to the threat model, it may be acceptable to allow some script
+interpreters (e.g. Bash) to interpret commands from stdin, may it be a TTY or a
+pipe, because it may not be enough to (directly) perform syscalls.
+
+There are two complementary security policies: enforce the ``noexec`` mount
+option, and enforce executable file permission.  These policies are handled by
+the ``fs.open_mayexec_enforce`` sysctl (writable only with ``CAP_SYS_ADMIN``)
+as a bitmask:
+
+1 - Mount restriction: checks that the mount options for the underlying VFS
+    mount do not prevent execution.
+
+2 - File permission restriction: checks that the to-be-opened file is marked as
+    executable for the current process (e.g., POSIX permissions).
+
+Code samples can be found in tools/testing/selftests/openat2/omayexec_test.c
+and interpreter patches (for the original O_MAYEXEC version) may be found at
+https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC .
+See also an overview article: https://lwn.net/Articles/820000/ .
+
+
 overflowgid & overflowuid
 -------------------------
 
diff --git a/fs/namei.c b/fs/namei.c
index ddc9b25540fe..9a9166e5ddd3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -39,6 +39,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/sysctl.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -425,10 +426,15 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 	return 0;
 }
 
+#define OPEN_MAYEXEC_ENFORCE_MOUNT	BIT(0)
+#define OPEN_MAYEXEC_ENFORCE_FILE	BIT(1)
+
+int sysctl_open_mayexec_enforce __read_mostly;
+
 /**
  * inode_permission - Check for access rights to a given inode
  * @inode: Inode to check permission on
- * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
+ * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC, %MAY_OPENEXEC)
  *
  * Check for read/write/execute permissions on an inode.  We use fs[ug]id for
  * this, letting us set arbitrary permissions for filesystem access without
@@ -2849,7 +2855,7 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	case S_IFLNK:
 		return -ELOOP;
 	case S_IFDIR:
-		if (acc_mode & (MAY_WRITE | MAY_EXEC))
+		if (acc_mode & (MAY_WRITE | MAY_EXEC | MAY_OPENEXEC))
 			return -EISDIR;
 		break;
 	case S_IFBLK:
@@ -2859,13 +2865,26 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 		fallthrough;
 	case S_IFIFO:
 	case S_IFSOCK:
-		if (acc_mode & MAY_EXEC)
+		if (acc_mode & (MAY_EXEC | MAY_OPENEXEC))
 			return -EACCES;
 		flag &= ~O_TRUNC;
 		break;
 	case S_IFREG:
-		if ((acc_mode & MAY_EXEC) && path_noexec(path))
-			return -EACCES;
+		if (path_noexec(path)) {
+			if (acc_mode & MAY_EXEC)
+				return -EACCES;
+			if ((acc_mode & MAY_OPENEXEC) &&
+					(sysctl_open_mayexec_enforce & OPEN_MAYEXEC_ENFORCE_MOUNT))
+				return -EACCES;
+		}
+		if ((acc_mode & MAY_OPENEXEC) &&
+				(sysctl_open_mayexec_enforce & OPEN_MAYEXEC_ENFORCE_FILE))
+			/*
+			 * Because acc_mode may change here, the next and only
+			 * use of acc_mode should then be by the following call
+			 * to inode_permission().
+			 */
+			acc_mode |= MAY_EXEC;
 		break;
 	}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 56f835c9a87a..071f37707ccc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -83,6 +83,7 @@ extern int sysctl_protected_symlinks;
 extern int sysctl_protected_hardlinks;
 extern int sysctl_protected_fifos;
 extern int sysctl_protected_regular;
+extern int sysctl_open_mayexec_enforce;
 
 typedef __kernel_rwf_t rwf_t;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index db1ce7af2563..5008a2566e79 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -113,6 +113,7 @@ static int sixty = 60;
 
 static int __maybe_unused neg_one = -1;
 static int __maybe_unused two = 2;
+static int __maybe_unused three = 3;
 static int __maybe_unused four = 4;
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
@@ -888,7 +889,6 @@ static int proc_taint(struct ctl_table *table, int write,
 	return err;
 }
 
-#ifdef CONFIG_PRINTK
 static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -897,7 +897,6 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 
 	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 }
-#endif
 
 /**
  * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
@@ -3264,6 +3263,15 @@ static struct ctl_table fs_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
+	{
+		.procname       = "open_mayexec_enforce",
+		.data           = &sysctl_open_mayexec_enforce,
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
2.27.0


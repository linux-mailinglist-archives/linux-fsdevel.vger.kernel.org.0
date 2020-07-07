Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD147217646
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgGGSRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 14:17:18 -0400
Received: from smtp-42af.mail.infomaniak.ch ([84.16.66.175]:34271 "EHLO
        smtp-42af.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728628AbgGGSRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:17:13 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B1Vpb4rhWzlhXmb;
        Tue,  7 Jul 2020 20:10:15 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4B1Vpb1vw6zlh8TB;
        Tue,  7 Jul 2020 20:10:15 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v19 08/12] landlock: Add syscall implementation
Date:   Tue,  7 Jul 2020 20:09:51 +0200
Message-Id: <20200707180955.53024-9-mic@digikod.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707180955.53024-1-mic@digikod.net>
References: <20200707180955.53024-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This system call, inspired from seccomp(2) and bpf(2), is designed to be
used by unprivileged processes to sandbox themselves.  It has the same
usage restrictions as seccomp(2): the caller must have the no_new_privs
attribute set or have CAP_SYS_ADMIN in the current user namespace.

Here are the motivations for this new syscall:
* A sandboxed process may not have access to file systems, including
  /dev, /sys or /proc, but it should still be able to add more
  restrictions to itself.
* Neither prctl(2) nor seccomp(2) (which was used in a previous version)
  fit well with the current definition of a Landlock security policy.
* It is quite easy to whitelist this syscall with seccomp-bpf to enable
  all processes to use it.  It is also easy to filter specific commands
  or options to restrict a process to a subset of Landlock features.

There is currently four commands:
* LANDLOCK_CMD_GET_FEATURES: Gets the supported features (required for
  backward and forward compatibility, and best-effort security).
* LANDLOCK_CMD_CREATE_RULESET: Creates a ruleset and returns its file
  descriptor.
* LANDLOCK_CMD_ADD_RULE: Adds a rule (e.g. file hierarchy access) to a
  ruleset, identified by the dedicated file descriptor.
* LANDLOCK_CMD_ENFORCE_RULESET: Enforces a ruleset on the current thread
  and its future children (similar to seccomp).

Each command has at least one option, which enables to define the
attribute types passed to the syscall.  All attribute types (structures)
are checked at build time to ensure that they don't contain holes and
that they are aligned the same way for each architecture.  The struct
landlock_attr_features contains __u32 options_* fields which is enough
to store 32-bits syscall arguments, and __u16 size_attr_* fields which
is enough for the maximal struct size (i.e. page size) passed through
the landlock syscall.  The other fields can have __u64 type for flags
and bitfields, and __s32 type for file descriptors.

See the user and kernel documentation for more details (provided by a
following commit): Documentation/security/landlock/

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v18:
* Remove useless include.
* Remove LLATTR_SIZE() which was only used to shorten lines. Cf. commit
  bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning").

Changes since v17:
* Synchronize syscall declaration.
* Fix comment.

Changes since v16:
* Add a size_attr_features field to struct landlock_attr_features for
  self-introspection, and move the access_fs field to be more
  consistent.
* Replace __aligned_u64 types of attribute fields with __u16, __s32,
  __u32 and __u64, and check at build time that these structures does
  not contain hole and that they are aligned the same way (8-bits) on
  all architectures.  This shrinks the size of the userspace ABI, which
  may be appreciated especially for struct landlock_attr_features which
  could grow a lot in the future.  For instance, struct
  landlock_attr_features shrinks from 72 bytes to 32 bytes.  This change
  also enables to remove 64-bits to 32-bits conversion checks.
* Switch syscall attribute pointer and size arguments to follow similar
  syscall argument order (e.g. bpf, clone3, openat2).
* Set LANDLOCK_OPT_* types to 32-bits.
* Allow enforcement of empty ruleset, which enables deny-all policies.
* Fix documentation inconsistency.

Changes since v15:
* Do not add file descriptors referring to internal filesystems (e.g.
  nsfs) in a ruleset.
* Replace is_user_mountable() with in-place clean checks.
* Replace EBADR with EBADFD in get_ruleset_from_fd() and
  get_path_from_fd().
* Remove ruleset's show_fdinfo() for now.

Changes since v14:
* Remove the security_file_open() check in get_path_from_fd(): an
  opened FD should not be restricted here, and even less with this hook.
  As a result, it is now allowed to add a path to a ruleset even if the
  access to this path is not allowed (without O_PATH). This doesn't
  change the fact that enforcing a ruleset can't grant any right, only
  remove some rights.  The new layer levels add more consistent
  restrictions.
* Check minimal landlock_attr_* size/content. This fix the case when
  no data was provided and e.g., FD 0 was interpreted as ruleset_fd.
  Now this leads to a returned -EINVAL.
* Fix credential double-free error case.
* Complete struct landlock_attr_size with size_attr_enforce.
* Fix undefined reference to syscall when Landlock is not selected.
* Remove f.file->f_path.mnt check (suggested by Al Viro).
* Add build-time checks.
* Move ABI checks from fs.c .
* Constify variables.
* Fix spelling.
* Add comments.

Changes since v13:
* New implementation, replacing the dependency on seccomp(2) and bpf(2).
---
 include/linux/syscalls.h      |   3 +
 include/uapi/linux/landlock.h | 224 +++++++++++++++
 kernel/sys_ni.c               |   3 +
 security/landlock/Makefile    |   2 +-
 security/landlock/syscall.c   | 526 ++++++++++++++++++++++++++++++++++
 5 files changed, 757 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/syscall.c

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b951a87da987..3c0d8830d3bc 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1005,6 +1005,9 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_landlock(unsigned int command, unsigned int options,
+			     void __user *attr1_ptr, size_t attr1_size,
+			     void __user *attr2_ptr, size_t attr2_size);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 5141185e6487..0e5829f2178b 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -9,6 +9,230 @@
 #ifndef _UAPI__LINUX_LANDLOCK_H__
 #define _UAPI__LINUX_LANDLOCK_H__
 
+#include <linux/types.h>
+
+/**
+ * enum landlock_cmd - Landlock commands
+ *
+ * First argument of sys_landlock().
+ */
+enum landlock_cmd {
+	/**
+	 * @LANDLOCK_CMD_GET_FEATURES: Asks the kernel for supported Landlock
+	 * features.  The option argument must contains
+	 * %LANDLOCK_OPT_GET_FEATURES.  This commands fills the &struct
+	 * landlock_attr_features provided as first attribute.
+	 */
+	LANDLOCK_CMD_GET_FEATURES = 1,
+	/**
+	 * @LANDLOCK_CMD_CREATE_RULESET: Creates a new ruleset and return its
+	 * file descriptor on success.  The option argument must contains
+	 * %LANDLOCK_OPT_CREATE_RULESET.  The ruleset is defined by the &struct
+	 * landlock_attr_ruleset provided as first attribute.
+	 */
+	LANDLOCK_CMD_CREATE_RULESET,
+	/**
+	 * @LANDLOCK_CMD_ADD_RULE: Adds a rule to a ruleset.  The option
+	 * argument must contains %LANDLOCK_OPT_ADD_RULE_PATH_BENEATH.  The
+	 * ruleset and the rule are both defined by the &struct
+	 * landlock_attr_path_beneath provided as first attribute.
+	 */
+	LANDLOCK_CMD_ADD_RULE,
+	/**
+	 * @LANDLOCK_CMD_ENFORCE_RULESET: Enforces a ruleset on the current
+	 * process.  The option argument must contains
+	 * %LANDLOCK_OPT_ENFORCE_RULESET.  The ruleset is defined by the
+	 * &struct landlock_attr_enforce provided as first attribute.
+	 */
+	LANDLOCK_CMD_ENFORCE_RULESET,
+};
+
+/**
+ * DOC: options_intro
+ *
+ * These options may be used as second argument of sys_landlock().  Each
+ * command have a dedicated set of options, represented as bitmasks.  For two
+ * different commands, their options may overlap.  Each command have at least
+ * one option defining the used attribute type.  This also enables to always
+ * have a usable &struct landlock_attr_features (i.e. filled with bits).
+ */
+
+/**
+ * DOC: options_get_features
+ *
+ * Options for ``LANDLOCK_CMD_GET_FEATURES``
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * - %LANDLOCK_OPT_GET_FEATURES: the attr type is `struct
+ *   landlock_attr_features`.
+ */
+#define LANDLOCK_OPT_GET_FEATURES			(1 << 0)
+
+/**
+ * DOC: options_create_ruleset
+ *
+ * Options for ``LANDLOCK_CMD_CREATE_RULESET``
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * - %LANDLOCK_OPT_CREATE_RULESET: the attr type is `struct
+ *   landlock_attr_ruleset`.
+ */
+#define LANDLOCK_OPT_CREATE_RULESET			(1 << 0)
+
+/**
+ * DOC: options_add_rule
+ *
+ * Options for ``LANDLOCK_CMD_ADD_RULE``
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * - %LANDLOCK_OPT_ADD_RULE_PATH_BENEATH: the attr type is `struct
+ *   landlock_attr_path_beneath`.
+ */
+#define LANDLOCK_OPT_ADD_RULE_PATH_BENEATH		(1 << 0)
+
+/**
+ * DOC: options_enforce_ruleset
+ *
+ * Options for ``LANDLOCK_CMD_ENFORCE_RULESET``
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * - %LANDLOCK_OPT_ENFORCE_RULESET: the attr type is `struct
+ *   landlock_attr_enforce`.
+ */
+#define LANDLOCK_OPT_ENFORCE_RULESET			(1 << 0)
+
+/**
+ * struct landlock_attr_features - Receives the supported features
+ *
+ * This struct should be allocated by user space but it will be filled by the
+ * kernel to indicate the subset of Landlock features effectively handled by
+ * the running kernel.  This enables backward compatibility for applications
+ * which are developed on a newer kernel than the one running the application.
+ * This helps avoid hard errors that may entirely disable the use of Landlock
+ * features because some of them may not be supported.  Indeed, because
+ * Landlock is a security feature, even if the kernel doesn't support all the
+ * requested features, user space applications should still use the subset
+ * which is supported by the running kernel.  Indeed, a partial security policy
+ * can still improve the security of the application and better protect the
+ * user (i.e. best-effort approach).  The %LANDLOCK_CMD_GET_FEATURES command
+ * and &struct landlock_attr_features are future-proof because the future
+ * unknown fields requested by user space (i.e. a larger &struct
+ * landlock_attr_features) can still be filled with zeros.
+ *
+ * The Landlock commands will fail if an unsupported option or access is
+ * requested.  By firstly requesting the supported options and accesses, it is
+ * quite easy for the developer to binary AND these returned bitmasks with the
+ * used options and accesses from the attribute structs (e.g. &struct
+ * landlock_attr_ruleset), and even infer the supported Landlock commands.
+ * Indeed, because each command must support at least one option, the options_*
+ * fields are always filled if the related commands are supported.  The
+ * supported attributes are also discoverable thanks to the size_* fields.  All
+ * this data enable to create applications doing their best to sandbox
+ * themselves regardless of the running kernel.
+ */
+struct landlock_attr_features {
+	/**
+	 * @options_get_features: Options supported by the
+	 * %LANDLOCK_CMD_GET_FEATURES command. Cf. `Options`_.
+	 */
+	__u32 options_get_features;
+	/**
+	 * @options_create_ruleset: Options supported by the
+	 * %LANDLOCK_CMD_CREATE_RULESET command. Cf. `Options`_.
+	 */
+	__u32 options_create_ruleset;
+	/**
+	 * @options_add_rule: Options supported by the %LANDLOCK_CMD_ADD_RULE
+	 * command. Cf. `Options`_.
+	 */
+	__u32 options_add_rule;
+	/**
+	 * @options_enforce_ruleset: Options supported by the
+	 * %LANDLOCK_CMD_ENFORCE_RULESET command. Cf. `Options`_.
+	 */
+	__u32 options_enforce_ruleset;
+	/**
+	 * @size_attr_features: Size of the &struct landlock_attr_features as
+	 * known by the kernel (i.e.  ``sizeof(struct
+	 * landlock_attr_features)``).
+	 */
+	__u16 size_attr_features;
+	/**
+	 * @size_attr_ruleset: Size of the &struct landlock_attr_ruleset as
+	 * known by the kernel (i.e.  ``sizeof(struct
+	 * landlock_attr_ruleset)``).
+	 */
+	__u16 size_attr_ruleset;
+	/**
+	 * @size_attr_path_beneath: Size of the &struct
+	 * landlock_attr_path_beneath as known by the kernel (i.e.
+	 * ``sizeof(struct landlock_path_beneath)``).
+	 */
+	__u16 size_attr_path_beneath;
+	/**
+	 * @size_attr_enforce: Size of the &struct landlock_attr_enforce as
+	 * known by the kernel (i.e.  ``sizeof(struct landlock_enforce)``).
+	 */
+	__u16 size_attr_enforce;
+	/**
+	 * @access_fs: Subset of file system access supported by the running
+	 * kernel, used in &struct landlock_attr_ruleset and &struct
+	 * landlock_attr_path_beneath.  Cf. `Filesystem flags`_.
+	 */
+	__u64 access_fs;
+};
+
+/**
+ * struct landlock_attr_ruleset- Defines a new ruleset
+ *
+ * Used as first attribute for the %LANDLOCK_CMD_CREATE_RULESET command and
+ * with the %LANDLOCK_OPT_CREATE_RULESET option.
+ */
+struct landlock_attr_ruleset {
+	/**
+	 * @handled_access_fs: Bitmask of actions (cf. `Filesystem flags`_)
+	 * that is handled by this ruleset and should then be forbidden if no
+	 * rule explicitly allow them.  This is needed for backward
+	 * compatibility reasons.  The user space code should check the
+	 * effectively supported actions thanks to %LANDLOCK_CMD_GET_SUPPORTED
+	 * and &struct landlock_attr_features, and then adjust the arguments of
+	 * the next calls to sys_landlock() accordingly.
+	 */
+	__u64 handled_access_fs;
+};
+
+/**
+ * struct landlock_attr_path_beneath - Defines a path hierarchy
+ */
+struct landlock_attr_path_beneath {
+	/**
+	 * @ruleset_fd: File descriptor tied to the ruleset which should be
+	 * extended with this new access.
+	 */
+	__s32 ruleset_fd;
+	/**
+	 * @parent_fd: File descriptor, open with ``O_PATH``, which identify
+	 * the parent directory of a file hierarchy, or just a file.
+	 */
+	__s32 parent_fd;
+	/**
+	 * @allowed_access: Bitmask of allowed actions for this file hierarchy
+	 * (cf. `Filesystem flags`_).
+	 */
+	__u64 allowed_access;
+};
+
+/**
+ * struct landlock_attr_enforce - Describes the enforcement
+ */
+struct landlock_attr_enforce {
+	/**
+	 * @ruleset_fd: File descriptor tied to the ruleset to merge with the
+	 * current domain.
+	 */
+	__s32 ruleset_fd;
+};
+
 /**
  * DOC: fs_access
  *
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac..70cea36eb7ce 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -264,6 +264,9 @@ COND_SYSCALL(request_key);
 COND_SYSCALL(keyctl);
 COND_SYSCALL_COMPAT(keyctl);
 
+/* security/landlock/syscall.c */
+COND_SYSCALL(landlock);
+
 /* arch/example/kernel/sys_example.c */
 
 /* mm/fadvise.c */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 92e3d80ab8ed..4388494779ec 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
-landlock-y := setup.o object.o ruleset.o \
+landlock-y := setup.o syscall.o object.o ruleset.o \
 	cred.o ptrace.o fs.o
diff --git a/security/landlock/syscall.c b/security/landlock/syscall.c
new file mode 100644
index 000000000000..1559304bcfec
--- /dev/null
+++ b/security/landlock/syscall.c
@@ -0,0 +1,526 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - System call and user space interfaces
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#include <asm/current.h>
+#include <linux/anon_inodes.h>
+#include <linux/build_bug.h>
+#include <linux/capability.h>
+#include <linux/compiler_types.h>
+#include <linux/dcache.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/limits.h>
+#include <linux/mount.h>
+#include <linux/path.h>
+#include <linux/sched.h>
+#include <linux/security.h>
+#include <linux/stddef.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/landlock.h>
+
+#include "cred.h"
+#include "fs.h"
+#include "ruleset.h"
+#include "setup.h"
+
+/**
+ * copy_struct_if_any_from_user - Safe future-proof argument copying
+ *
+ * Extend copy_struct_from_user() to handle NULL @src, which allows for future
+ * use of @src even if it is not used right now.
+ *
+ * @dst: Kernel space pointer or NULL.
+ * @ksize: Actual size of the data pointed to by @dst.
+ * @ksize_min: Minimal required size to be copied.
+ * @src: User space pointer or NULL.
+ * @usize: (Alleged) size of the data pointed to by @src.
+ */
+static int copy_struct_if_any_from_user(void *const dst, const size_t ksize,
+		const size_t ksize_min, const void __user *const src,
+		const size_t usize)
+{
+	int ret;
+
+	/* Checks kernel buffer size inconsistencies. */
+	if (dst) {
+		if (WARN_ON_ONCE(ksize == 0))
+			return -EFAULT;
+	} else {
+		if (WARN_ON_ONCE(ksize != 0))
+			return -EFAULT;
+	}
+
+	/* Checks minimal size. */
+	if (WARN_ON_ONCE(ksize < ksize_min))
+		return -EFAULT;
+	if (usize < ksize_min)
+		return -EINVAL;
+
+	/* Handles empty user buffer. */
+	if (!src) {
+		if (usize != 0)
+			return -EFAULT;
+		if (dst)
+			memset(dst, 0, ksize);
+		return 0;
+	}
+
+	/* Checks user buffer size inconsistency and limit. */
+	if (usize == 0)
+		return -ENODATA;
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+
+	/* Copies user buffer and fills with zeros. */
+	if (dst)
+		return copy_struct_from_user(dst, ksize, src, usize);
+
+	/* Checks unknown user data. */
+	ret = check_zeroed_user(src, usize);
+	if (ret <= 0)
+		return ret ?: -E2BIG;
+	return 0;
+}
+
+/* Features */
+
+#define _LANDLOCK_OPT_GET_FEATURES_LAST		LANDLOCK_OPT_GET_FEATURES
+#define _LANDLOCK_OPT_GET_FEATURES_MASK		((_LANDLOCK_OPT_GET_FEATURES_LAST << 1) - 1)
+
+#define _LANDLOCK_OPT_CREATE_RULESET_LAST	LANDLOCK_OPT_CREATE_RULESET
+#define _LANDLOCK_OPT_CREATE_RULESET_MASK	((_LANDLOCK_OPT_CREATE_RULESET_LAST << 1) - 1)
+
+#define _LANDLOCK_OPT_ADD_RULE_LAST		LANDLOCK_OPT_ADD_RULE_PATH_BENEATH
+#define _LANDLOCK_OPT_ADD_RULE_MASK		((_LANDLOCK_OPT_ADD_RULE_LAST << 1) - 1)
+
+#define _LANDLOCK_OPT_ENFORCE_RULESET_LAST	LANDLOCK_OPT_ENFORCE_RULESET
+#define _LANDLOCK_OPT_ENFORCE_RULESET_MASK	((_LANDLOCK_OPT_ENFORCE_RULESET_LAST << 1) - 1)
+
+static int syscall_get_features(void __user *const attr_ptr,
+		const size_t attr_size)
+{
+	size_t data_size, fill_size;
+	const struct landlock_attr_features supported = {
+		.options_get_features = _LANDLOCK_OPT_GET_FEATURES_MASK,
+		.options_create_ruleset = _LANDLOCK_OPT_CREATE_RULESET_MASK,
+		.options_add_rule = _LANDLOCK_OPT_ADD_RULE_MASK,
+		.options_enforce_ruleset = _LANDLOCK_OPT_ENFORCE_RULESET_MASK,
+		.size_attr_features = sizeof(struct landlock_attr_features),
+		.size_attr_ruleset = sizeof(struct landlock_attr_ruleset),
+		.size_attr_path_beneath = sizeof(struct
+				landlock_attr_path_beneath),
+		.size_attr_enforce = sizeof(struct landlock_attr_enforce),
+		.access_fs = _LANDLOCK_ACCESS_FS_MASK,
+	};
+
+	BUILD_BUG_ON(!__same_type(supported.access_fs,
+		((struct landlock_attr_ruleset *)NULL)->handled_access_fs));
+	BUILD_BUG_ON(!__same_type(supported.access_fs,
+		((struct landlock_attr_path_beneath *)NULL)->allowed_access));
+
+	/* Checks attribute consistency. */
+	if (attr_size == 0)
+		return -ENODATA;
+	if (attr_size > PAGE_SIZE)
+		return -E2BIG;
+
+	/* Copy a subset of features to user space. */
+	data_size = min(sizeof(supported), attr_size);
+	if (copy_to_user(attr_ptr, &supported, data_size))
+		return -EFAULT;
+
+	/* Fills with zeros. */
+	fill_size = attr_size - data_size;
+	if (fill_size > 0 && clear_user(attr_ptr + data_size, fill_size))
+		return -EFAULT;
+	return 0;
+}
+
+/* Ruleset handling */
+
+static int fop_ruleset_release(struct inode *const inode,
+		struct file *const filp)
+{
+	struct landlock_ruleset *ruleset = filp->private_data;
+
+	landlock_put_ruleset(ruleset);
+	return 0;
+}
+
+static ssize_t fop_dummy_read(struct file *const filp, char __user *const buf,
+		const size_t size, loff_t *const ppos)
+{
+	/* Dummy handler to enable FMODE_CAN_READ. */
+	return -EINVAL;
+}
+
+static ssize_t fop_dummy_write(struct file *const filp,
+		const char __user *const buf, const size_t size,
+		loff_t *const ppos)
+{
+	/* Dummy handler to enable FMODE_CAN_WRITE. */
+	return -EINVAL;
+}
+
+/*
+ * A ruleset file descriptor enables to build a ruleset by adding (i.e.
+ * writing) rule after rule, without relying on the task's context.  This
+ * reentrant design is also used in a read way to enforce the ruleset on the
+ * current task.
+ */
+static const struct file_operations ruleset_fops = {
+	.release = fop_ruleset_release,
+	.read = fop_dummy_read,
+	.write = fop_dummy_write,
+};
+
+static int syscall_create_ruleset(const void __user *const attr_ptr,
+		const size_t attr_size)
+{
+	struct landlock_attr_ruleset attr_ruleset;
+	struct landlock_ruleset *ruleset;
+	int err, ruleset_fd;
+
+	/* Copies raw user space buffer. */
+	err = copy_struct_if_any_from_user(&attr_ruleset, sizeof(attr_ruleset),
+			offsetofend(typeof(attr_ruleset), handled_access_fs),
+			attr_ptr, attr_size);
+	if (err)
+		return err;
+
+	/* Checks content (and 32-bits cast). */
+	if ((attr_ruleset.handled_access_fs | _LANDLOCK_ACCESS_FS_MASK) !=
+			_LANDLOCK_ACCESS_FS_MASK)
+		return -EINVAL;
+
+	/* Checks arguments and transforms to kernel struct. */
+	ruleset = landlock_create_ruleset(attr_ruleset.handled_access_fs);
+	if (IS_ERR(ruleset))
+		return PTR_ERR(ruleset);
+
+	/* Creates anonymous FD referring to the ruleset. */
+	ruleset_fd = anon_inode_getfd("landlock-ruleset", &ruleset_fops,
+			ruleset, O_RDWR | O_CLOEXEC);
+	if (ruleset_fd < 0)
+		landlock_put_ruleset(ruleset);
+	return ruleset_fd;
+}
+
+/*
+ * Returns an owned ruleset from a FD. It is thus needed to call
+ * landlock_put_ruleset() on the return value.
+ */
+static struct landlock_ruleset *get_ruleset_from_fd(const s32 fd,
+		const fmode_t mode)
+{
+	struct fd ruleset_f;
+	struct landlock_ruleset *ruleset;
+	int err;
+
+	BUILD_BUG_ON(!__same_type(fd,
+		((struct landlock_attr_path_beneath *)NULL)->ruleset_fd));
+	BUILD_BUG_ON(!__same_type(fd,
+		((struct landlock_attr_enforce *)NULL)->ruleset_fd));
+
+	ruleset_f = fdget(fd);
+	if (!ruleset_f.file)
+		return ERR_PTR(-EBADF);
+
+	/* Checks FD type and access right. */
+	err = 0;
+	if (ruleset_f.file->f_op != &ruleset_fops)
+		err = -EBADFD;
+	else if (!(ruleset_f.file->f_mode & mode))
+		err = -EPERM;
+	if (!err) {
+		ruleset = ruleset_f.file->private_data;
+		landlock_get_ruleset(ruleset);
+	}
+	fdput(ruleset_f);
+	return err ? ERR_PTR(err) : ruleset;
+}
+
+/* Path handling */
+
+/*
+ * @path: Must call put_path(@path) after the call if it succeeded.
+ */
+static int get_path_from_fd(const s32 fd, struct path *const path)
+{
+	struct fd f;
+	int err = 0;
+
+	BUILD_BUG_ON(!__same_type(fd,
+		((struct landlock_attr_path_beneath *)NULL)->parent_fd));
+
+	/* Handles O_PATH. */
+	f = fdget_raw(fd);
+	if (!f.file)
+		return -EBADF;
+	/*
+	 * Only allows O_PATH file descriptor: enables to restrict ambient
+	 * filesystem access without requiring to open and risk leaking or
+	 * misusing a file descriptor.  Forbid internal filesystems (e.g.
+	 * nsfs), including pseudo filesystems that will never be mountable
+	 * (e.g. sockfs, pipefs).
+	 */
+	if (!(f.file->f_mode & FMODE_PATH) ||
+			(f.file->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
+			(f.file->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
+			d_is_negative(f.file->f_path.dentry) ||
+			IS_PRIVATE(d_backing_inode(f.file->f_path.dentry))) {
+		err = -EBADFD;
+		goto out_fdput;
+	}
+	path->mnt = f.file->f_path.mnt;
+	path->dentry = f.file->f_path.dentry;
+	path_get(path);
+
+out_fdput:
+	fdput(f);
+	return err;
+}
+
+static int syscall_add_rule_path_beneath(const void __user *const attr_ptr,
+		const size_t attr_size)
+{
+	struct landlock_attr_path_beneath attr_path_beneath;
+	struct path path;
+	struct landlock_ruleset *ruleset;
+	int err;
+
+	/* Copies raw user space buffer. */
+	err = copy_struct_if_any_from_user(&attr_path_beneath,
+			sizeof(attr_path_beneath),
+			offsetofend(typeof(attr_path_beneath), allowed_access),
+			attr_ptr, attr_size);
+	if (err)
+		return err;
+
+	/* Gets and checks the ruleset. */
+	ruleset = get_ruleset_from_fd(attr_path_beneath.ruleset_fd,
+			FMODE_CAN_WRITE);
+	if (IS_ERR(ruleset))
+		return PTR_ERR(ruleset);
+
+	/*
+	 * Checks that allowed_access matches the @ruleset constraints
+	 * (ruleset->fs_access_mask is automatically upgraded to 64-bits).
+	 * Allows empty allowed_access i.e., deny @ruleset->fs_access_mask .
+	 */
+	if ((attr_path_beneath.allowed_access | ruleset->fs_access_mask) !=
+			ruleset->fs_access_mask) {
+		err = -EINVAL;
+		goto out_put_ruleset;
+	}
+
+	/* Gets and checks the new rule. */
+	err = get_path_from_fd(attr_path_beneath.parent_fd, &path);
+	if (err)
+		goto out_put_ruleset;
+
+	/* Imports the new rule. */
+	err = landlock_append_fs_rule(ruleset, &path,
+			attr_path_beneath.allowed_access);
+	path_put(&path);
+
+out_put_ruleset:
+	landlock_put_ruleset(ruleset);
+	return err;
+}
+
+/* Enforcement */
+
+static int syscall_enforce_ruleset(const void __user *const attr_ptr,
+		const size_t attr_size)
+{
+	struct landlock_ruleset *new_dom, *ruleset;
+	struct cred *new_cred;
+	struct landlock_cred_security *new_llcred;
+	struct landlock_attr_enforce attr_enforce;
+	int err;
+
+	/*
+	 * Enforcing a Landlock ruleset requires that the task has
+	 * CAP_SYS_ADMIN in its namespace or be running with no_new_privs.
+	 * This avoids scenarios where unprivileged tasks can affect the
+	 * behavior of privileged children.  These are similar checks as for
+	 * seccomp(2), except that an -EPERM may be returned.
+	 */
+	if (!task_no_new_privs(current)) {
+		err = security_capable(current_cred(), current_user_ns(),
+				CAP_SYS_ADMIN, CAP_OPT_NOAUDIT);
+		if (err)
+			return err;
+	}
+
+	/* Copies raw user space buffer. */
+	err = copy_struct_if_any_from_user(&attr_enforce, sizeof(attr_enforce),
+			offsetofend(typeof(attr_enforce), ruleset_fd),
+			attr_ptr, attr_size);
+	if (err)
+		return err;
+
+	/* Gets and checks the ruleset. */
+	ruleset = get_ruleset_from_fd(attr_enforce.ruleset_fd, FMODE_CAN_READ);
+	if (IS_ERR(ruleset))
+		return PTR_ERR(ruleset);
+
+	/* Prepares new credentials. */
+	new_cred = prepare_creds();
+	if (!new_cred) {
+		err = -ENOMEM;
+		goto out_put_ruleset;
+	}
+	new_llcred = landlock_cred(new_cred);
+
+	/*
+	 * There is no possible race condition while copying and manipulating
+	 * the current credentials because they are dedicated per thread.
+	 */
+	new_dom = landlock_merge_ruleset(new_llcred->domain, ruleset);
+	if (IS_ERR(new_dom)) {
+		err = PTR_ERR(new_dom);
+		goto out_put_creds;
+	}
+
+	/* Replaces the old (prepared) domain. */
+	landlock_put_ruleset(new_llcred->domain);
+	new_llcred->domain = new_dom;
+
+	landlock_put_ruleset(ruleset);
+	return commit_creds(new_cred);
+
+out_put_creds:
+	abort_creds(new_cred);
+	return err;
+
+out_put_ruleset:
+	landlock_put_ruleset(ruleset);
+	return err;
+}
+
+/*
+ * This function only contains arithmetic operations with constants, leading to
+ * BUILD_BUG_ON().  The related code is evaluated and checked at build time,
+ * but it is then ignored thanks to compiler optimizations.
+ */
+static void build_check_abi(void)
+{
+	size_t size_features, size_ruleset, size_path_beneath, size_enforce;
+
+	/*
+	 * For each user space ABI structures, first checks that there is no
+	 * hole in them, then checks that all architectures have the same
+	 * struct size.
+	 */
+	size_features = sizeof_field(struct landlock_attr_features, options_get_features);
+	size_features += sizeof_field(struct landlock_attr_features, options_create_ruleset);
+	size_features += sizeof_field(struct landlock_attr_features, options_add_rule);
+	size_features += sizeof_field(struct landlock_attr_features, options_enforce_ruleset);
+	size_features += sizeof_field(struct landlock_attr_features, size_attr_features);
+	size_features += sizeof_field(struct landlock_attr_features, size_attr_ruleset);
+	size_features += sizeof_field(struct landlock_attr_features, size_attr_path_beneath);
+	size_features += sizeof_field(struct landlock_attr_features, size_attr_enforce);
+	size_features += sizeof_field(struct landlock_attr_features, access_fs);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_features) != size_features);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_features) != 32);
+
+	size_ruleset = sizeof_field(struct landlock_attr_ruleset, handled_access_fs);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_ruleset) != size_ruleset);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_ruleset) != 8);
+
+	size_path_beneath = sizeof_field(struct landlock_attr_path_beneath, ruleset_fd);
+	size_path_beneath += sizeof_field(struct landlock_attr_path_beneath, parent_fd);
+	size_path_beneath += sizeof_field(struct landlock_attr_path_beneath, allowed_access);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_path_beneath) != size_path_beneath);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_path_beneath) != 16);
+
+	size_enforce = sizeof_field(struct landlock_attr_enforce, ruleset_fd);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_enforce) != size_enforce);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_enforce) != 4);
+}
+
+/**
+ * sys_landlock - System call to enable a process to safely sandbox itself
+ *
+ * @command: Landlock command to perform miscellaneous, but safe, actions. Cf.
+ *           `Commands`_.
+ * @options: Bitmask of options dedicated to one command. Cf. `Options`_.
+ * @attr1_ptr: Pointer to the first attribute. Cf. `Attributes`_.
+ * @attr1_size: First attribute size (i.e. size of the struct).
+ * @attr2_ptr: Unused for now, must be NULL.
+ * @attr2_size: Unused for now, must be 0.
+ *
+ * The @command and @options arguments enable a seccomp-bpf policy to control
+ * the requested actions.  However, it should be noted that Landlock is
+ * designed from the ground to enable unprivileged process to drop privileges
+ * and accesses in a way that can not harm other processes.  This syscall and
+ * all its arguments should then be allowed for any process, which will then
+ * enable applications to strengthen the security of the whole system.
+ *
+ * @attr2_ptr and @attr2_size describe a second attribute which could be used
+ * in the future to compose with the first attribute (e.g. a
+ * landlock_attr_path_beneath with a landlock_attr_ioctl).
+ *
+ * The order of return errors begins with ENOPKG (disabled Landlock),
+ * EOPNOTSUPP (unknown command or option) and then EINVAL (invalid attribute).
+ * The other error codes may be specific to each command.
+ */
+SYSCALL_DEFINE6(landlock, const unsigned int, command,
+		const unsigned int, options,
+		void __user *const, attr1_ptr, const size_t, attr1_size,
+		void __user *const, attr2_ptr, const size_t, attr2_size)
+{
+	build_check_abi();
+	/*
+	 * Enables user space to identify if Landlock is disabled, thanks to a
+	 * specific error code.
+	 */
+	if (!landlock_initialized)
+		return -ENOPKG;
+
+	switch ((enum landlock_cmd)command) {
+	case LANDLOCK_CMD_GET_FEATURES:
+		if (options == LANDLOCK_OPT_GET_FEATURES) {
+			if (attr2_ptr || attr2_size)
+				return -EINVAL;
+			return syscall_get_features(attr1_ptr, attr1_size);
+		}
+		return -EOPNOTSUPP;
+
+	case LANDLOCK_CMD_CREATE_RULESET:
+		if (options == LANDLOCK_OPT_CREATE_RULESET) {
+			if (attr2_ptr || attr2_size)
+				return -EINVAL;
+			return syscall_create_ruleset(attr1_ptr, attr1_size);
+		}
+		return -EOPNOTSUPP;
+
+	case LANDLOCK_CMD_ADD_RULE:
+		if (options == LANDLOCK_OPT_ADD_RULE_PATH_BENEATH) {
+			if (attr2_ptr || attr2_size)
+				return -EINVAL;
+			return syscall_add_rule_path_beneath(attr1_ptr,
+					attr1_size);
+		}
+		return -EOPNOTSUPP;
+
+	case LANDLOCK_CMD_ENFORCE_RULESET:
+		if (options == LANDLOCK_OPT_ENFORCE_RULESET) {
+			if (attr2_ptr || attr2_size)
+				return -EINVAL;
+			return syscall_enforce_ruleset(attr1_ptr, attr1_size);
+		}
+		return -EOPNOTSUPP;
+	}
+	return -EOPNOTSUPP;
+}
-- 
2.27.0


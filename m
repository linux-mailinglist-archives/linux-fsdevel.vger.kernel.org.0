Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE9E239C97
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 00:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgHBWAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 18:00:16 -0400
Received: from smtp-bc0a.mail.infomaniak.ch ([45.157.188.10]:37043 "EHLO
        smtp-bc0a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728254AbgHBWAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 18:00:08 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BKZg971HPzlhb57;
        Sun,  2 Aug 2020 23:59:33 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4BKZg93bJKzlh8T5;
        Sun,  2 Aug 2020 23:59:33 +0200 (CEST)
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
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v20 08/12] landlock: Add syscall implementations
Date:   Sun,  2 Aug 2020 23:58:59 +0200
Message-Id: <20200802215903.91936-9-mic@digikod.net>
X-Mailer: git-send-email 2.28.0.rc2
In-Reply-To: <20200802215903.91936-1-mic@digikod.net>
References: <20200802215903.91936-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These 4 system calls are designed to be used by unprivileged processes
to sandbox themselves:
* landlock_get_features(2): Gets the supported features (required for
  backward and forward compatibility, and best-effort security).
* landlock_create_ruleset(2): Creates a ruleset and returns its file
  descriptor.
* landlock_add_rule(2): Adds a rule (e.g. file hierarchy access) to a
  ruleset, identified by the dedicated file descriptor.
* landlock_enforce_ruleset(2): Enforces a ruleset on the current thread
  and its future children (similar to seccomp).  This syscall has the
  same usage restrictions as seccomp(2): the caller must have the
  no_new_privs attribute set or have CAP_SYS_ADMIN in the current user
  namespace.

All these syscalls have an options argument (not currently used) to
enable extensibility.

Here are the motivations for these new syscalls:
* A sandboxed process may not have access to file systems, including
  /dev, /sys or /proc, but it should still be able to add more
  restrictions to itself.
* Neither prctl(2) nor seccomp(2) (which was used in a previous version)
  fit well with the current definition of a Landlock security policy.
* It is quite easy to whitelist this syscall with seccomp-bpf to enable
  all processes to use it.  It is also easy to filter specific commands
  or options to restrict a process to a subset of Landlock features.

All variable attributes are checked at build time to ensure that they
don't contain holes and that they are aligned the same way for each
architecture.  The struct landlock_attr_features contains __u32
options_* fields which is enough to store 32-bits syscall arguments, and
__u16 size_attr_* fields which is enough for the maximal struct size
(i.e. page size) passed through the landlock syscall.  The other fields
can have __u64 type for flags and bitfields, and __s32 type for file
descriptors.

See the user and kernel documentation for more details (provided by a
following commit): Documentation/security/landlock/

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v19:
* Replace the landlock(2) syscall with 4 syscalls (one for each
  command): landlock_get_features(2), landlock_create_ruleset(2),
  landlock_add_rule(2) and landlock_enforce_ruleset(2) (suggested by
  Arnd Bergmann).
  https://lore.kernel.org/lkml/56d15841-e2c1-2d58-59b8-3a6a09b23b4a@digikod.net/
* Return EOPNOTSUPP (instead of ENOPKG) when Landlock is disabled.
* Add two new fields to landlock_attr_features to fit with the new
  syscalls: last_rule_type and last_target_type.  This enable to easily
  identify which types are supported.
* Pack landlock_attr_path_beneath struct because of the removed
  ruleset_fd.
* Update documentation and fix spelling.

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
 include/linux/syscalls.h      |   8 +
 include/uapi/linux/landlock.h | 166 ++++++++++
 kernel/sys_ni.c               |   6 +
 security/landlock/Makefile    |   2 +-
 security/landlock/syscall.c   | 554 ++++++++++++++++++++++++++++++++++
 5 files changed, 735 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/syscall.c

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b951a87da987..8373fb28eb44 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1005,6 +1005,14 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_landlock_get_features(struct landlock_attr_features __user *features_ptr,
+		size_t features_size, __u32 options);
+asmlinkage long sys_landlock_create_ruleset(const struct landlock_attr_ruleset __user *ruleset_ptr,
+		size_t ruleset_size, __u32 options);
+asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
+		const void __user *rule_ptr, size_t rule_size, __u32 options);
+asmlinkage long sys_landlock_enforce_ruleset(int ruleset_fd, enum landlock_target_type target_type,
+		int target_fd, __u32 options);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 5141185e6487..eb2a5e0d61a4 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -9,6 +9,172 @@
 #ifndef _UAPI__LINUX_LANDLOCK_H__
 #define _UAPI__LINUX_LANDLOCK_H__
 
+#include <linux/types.h>
+
+#if 0
+/**
+ * DOC: options_intro
+ *
+ * These options may be used as second argument of sys_landlock().  Each
+ * command have a dedicated set of options, represented as bitmasks.  For two
+ * different commands, their options may overlap.  Each command have at least
+ * one option defining the used attribute type.  This also enables to always
+ * have a usable &struct landlock_attr_features (i.e. filled with bits).
+ */
+#endif
+
+/**
+ * enum landlock_rule_type - Landlock rule type
+ *
+ * Argument of sys_landlock_add_rule().
+ */
+enum landlock_rule_type {
+	/**
+	 * @LANDLOCK_RULE_PATH_BENEATH: Type of a &struct
+	 * landlock_attr_path_beneath .
+	 */
+	LANDLOCK_RULE_PATH_BENEATH = 1,
+};
+
+/**
+ * enum landlock_target_type - Landlock target type
+ *
+ * Argument of sys_landlock_enforce_ruleset().
+ */
+enum landlock_target_type {
+	/**
+	 * @LANDLOCK_TARGET_CURRENT_THREAD: Enforce a ruleset on the thread
+	 * asking for (i.e. seccomp-like).
+	 */
+	LANDLOCK_TARGET_CURRENT_THREAD = 1,
+};
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
+	 * @options_get_features: Options supported by
+	 * sys_landlock_get_features().
+	 */
+	__u32 options_get_features;
+	/**
+	 * @options_create_ruleset: Options supported by
+	 * sys_landlock_create_ruleset().
+	 */
+	__u32 options_create_ruleset;
+	/**
+	 * @options_add_rule: Options supported by sys_landlock_add_rule().
+	 */
+	__u32 options_add_rule;
+	/**
+	 * @options_enforce_ruleset: Options supported by
+	 * sys_landlock_enforce_ruleset().
+	 */
+	__u32 options_enforce_ruleset;
+	/**
+	 * @access_fs: Subset of file system access supported by the running
+	 * kernel, used in &landlock_attr_ruleset.handled_access_fs and
+	 * &landlock_attr_path_beneath.allowed_access .  Cf. `Filesystem
+	 * flags`_.
+	 */
+	__u64 access_fs;
+	/**
+	 * @size_attr_features: Size of the &struct landlock_attr_features
+	 * (current struct) as known by the kernel (i.e. ``sizeof(struct
+	 * landlock_attr_features)``).
+	 */
+	__u16 size_attr_features;
+	/**
+	 * @size_attr_ruleset: Size of the &struct landlock_attr_ruleset as
+	 * known by the kernel (i.e. ``sizeof(struct
+	 * landlock_attr_ruleset)``).
+	 */
+	__u16 size_attr_ruleset;
+	/**
+	 * @size_attr_path_beneath: Size of the &struct
+	 * landlock_attr_path_beneath as known by the kernel (i.e.
+	 * ``sizeof(struct landlock_attr_path_beneath)``).
+	 */
+	__u16 size_attr_path_beneath;
+	/**
+	 * @last_rule_type: Indicate the last entry of &enum
+	 * landlock_rule_type.
+	 */
+	__u8 last_rule_type;
+	/**
+	 * @last_target_type: Indicate the last entry of &enum
+	 * landlock_target_type.
+	 */
+	__u8 last_target_type;
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
+	 * effectively supported actions thanks to %LANDLOCK_CMD_GET_FEATURES
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
+	 * @allowed_access: Bitmask of allowed actions for this file hierarchy
+	 * (cf. `Filesystem flags`_).
+	 */
+	__u64 allowed_access;
+	/**
+	 * @parent_fd: File descriptor, open with ``O_PATH``, which identify
+	 * the parent directory of a file hierarchy, or just a file.
+	 */
+	__s32 parent_fd;
+	/*
+	 * This struct is packed to enable to append future members without
+	 * requiring to have dummy reserved members.
+	 * Cf. security/landlock/syscall.c:build_check_abi()
+	 */
+} __attribute__((packed));
+
 /**
  * DOC: fs_access
  *
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac..d0f3cf333d86 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -264,6 +264,12 @@ COND_SYSCALL(request_key);
 COND_SYSCALL(keyctl);
 COND_SYSCALL_COMPAT(keyctl);
 
+/* security/landlock/syscall.c */
+COND_SYSCALL(landlock_get_features);
+COND_SYSCALL(landlock_create_ruleset);
+COND_SYSCALL(landlock_add_rule);
+COND_SYSCALL(landlock_enforce_ruleset);
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
index 000000000000..7bf4dc175dee
--- /dev/null
+++ b/security/landlock/syscall.c
@@ -0,0 +1,554 @@
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
+/*
+ * This function only contains arithmetic operations with constants, leading to
+ * BUILD_BUG_ON().  The related code is evaluated and checked at build time,
+ * but it is then ignored thanks to compiler optimizations.
+ */
+static void build_check_abi(void)
+{
+	size_t size_features, size_ruleset, size_path_beneath;
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
+	size_features += sizeof_field(struct landlock_attr_features, access_fs);
+	size_features += sizeof_field(struct landlock_attr_features, size_attr_features);
+	size_features += sizeof_field(struct landlock_attr_features, size_attr_ruleset);
+	size_features += sizeof_field(struct landlock_attr_features, size_attr_path_beneath);
+	size_features += sizeof_field(struct landlock_attr_features, last_rule_type);
+	size_features += sizeof_field(struct landlock_attr_features, last_target_type);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_features) != size_features);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_features) != 32);
+
+	size_ruleset = sizeof_field(struct landlock_attr_ruleset, handled_access_fs);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_ruleset) != size_ruleset);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_ruleset) != 8);
+
+	size_path_beneath = sizeof_field(struct landlock_attr_path_beneath, allowed_access);
+	size_path_beneath += sizeof_field(struct landlock_attr_path_beneath, parent_fd);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_path_beneath) != size_path_beneath);
+	BUILD_BUG_ON(sizeof(struct landlock_attr_path_beneath) != 12);
+}
+
+/**
+ * sys_landlock_get_features - Identify the supported Landlock features
+ *
+ * @features_ptr: Pointer to a &struct landlock_attr_features to be filled by
+ *		  the supported features.
+ * @features_size: Size of the pointed &struct landlock_attr_features (needed
+ *		   for backward and forward compatibility).
+ * @options: Must be 0.
+ *
+ * This system call enables to ask the kernel for supported Landlock features.
+ * This is important to build user space code compatible with older and newer
+ * kernels.
+ *
+ * Possible returned errors are:
+ *
+ * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
+ * - EINVAL: @options is not 0;
+ * - ENODATA, E2BIG or EFAULT: @features_ptr or @feature_size inconsistencies.
+ */
+SYSCALL_DEFINE3(landlock_get_features,
+		struct landlock_attr_features __user *const, features_ptr,
+		const size_t, features_size, const __u32, options)
+{
+	size_t data_size, fill_size;
+	const struct landlock_attr_features supported = {
+		.options_get_features = 0,
+		.options_create_ruleset = 0,
+		.options_add_rule = 0,
+		.options_enforce_ruleset = 0,
+		.access_fs = _LANDLOCK_ACCESS_FS_MASK,
+		.size_attr_features = sizeof(struct landlock_attr_features),
+		.size_attr_ruleset = sizeof(struct landlock_attr_ruleset),
+		.size_attr_path_beneath = sizeof(struct landlock_attr_path_beneath),
+		.last_rule_type = LANDLOCK_RULE_PATH_BENEATH,
+		.last_target_type = LANDLOCK_TARGET_CURRENT_THREAD,
+	};
+
+	BUILD_BUG_ON(!__same_type(supported.access_fs,
+		((struct landlock_attr_ruleset *)NULL)->handled_access_fs));
+	BUILD_BUG_ON(!__same_type(supported.access_fs,
+		((struct landlock_attr_path_beneath *)NULL)->allowed_access));
+	build_check_abi();
+
+	/*
+	 * Enables user space to identify if Landlock is disabled, thanks to a
+	 * specific error code.
+	 */
+	if (!landlock_initialized)
+		return -EOPNOTSUPP;
+
+	/* No option for now. */
+	if (options)
+		return -EINVAL;
+
+	/* Checks argument consistency. */
+	if (features_size == 0)
+		return -ENODATA;
+	if (features_size > PAGE_SIZE)
+		return -E2BIG;
+
+	/* Copy a subset of features to user space. */
+	data_size = min(sizeof(supported), features_size);
+	if (copy_to_user(features_ptr, &supported, data_size))
+		return -EFAULT;
+
+	/* Fills with zeros. */
+	fill_size = features_size - data_size;
+	if (fill_size > 0 && clear_user((void __user *)features_ptr + data_size, fill_size))
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
+/**
+ * sys_landlock_create_ruleset - Create a new ruleset
+ *
+ * @ruleset_ptr: Pointer to a &struct landlock_attr_ruleset identifying the
+ *		 scope of the new ruleset.
+ * @ruleset_size: Size of the pointed &struct landlock_attr_ruleset (needed for
+ *		  backward and forward compatibility).
+ * @options: Must be 0.
+ *
+ * This system call enables to create a new Landlock ruleset, and returns the
+ * related file descriptor on success.
+ *
+ * Possible returned errors are:
+ *
+ * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
+ * - EINVAL: @options is not 0, or unknown access, or too small @ruleset_size;
+ * - ENODATA, E2BIG or EFAULT: @ruleset_ptr or @ruleset_size inconsistencies;
+ * - ENOMSG: empty &landlock_attr_ruleset.handled_access_fs.
+ */
+SYSCALL_DEFINE3(landlock_create_ruleset,
+		const struct landlock_attr_ruleset __user *const, ruleset_ptr,
+		const size_t, ruleset_size, const __u32, options)
+{
+	struct landlock_attr_ruleset attr_ruleset;
+	struct landlock_ruleset *ruleset;
+	int err, ruleset_fd;
+
+	if (!landlock_initialized)
+		return -EOPNOTSUPP;
+
+	/* No option for now. */
+	if (options)
+		return -EINVAL;
+
+	/* Copies raw user space buffer. */
+	err = copy_struct_if_any_from_user(&attr_ruleset, sizeof(attr_ruleset),
+			offsetofend(typeof(attr_ruleset), handled_access_fs),
+			ruleset_ptr, ruleset_size);
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
+static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
+		const fmode_t mode)
+{
+	struct fd ruleset_f;
+	struct landlock_ruleset *ruleset;
+	int err;
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
+/**
+ * sys_landlock_add_rule - Add a new rule to a ruleset
+ *
+ * @ruleset_fd: File descriptor tied to the ruleset which should be extended
+ *		with the new rule.
+ * @rule_type: Identify the structure type pointed to by @rule_ptr.
+ * @rule_ptr: Pointer to a rule (the currently only supported rule is &struct
+ *	      landlock_attr_path_beneath).
+ * @rule_size: Size of the struct pointed to by @rule_ptr.
+ * @options: Must be 0.
+ *
+ * This system call enables to define a new rule and add it to an existing
+ * ruleset.
+ *
+ * Possible returned errors are:
+ *
+ * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
+ * - EINVAL: @options is not 0, or inconsistent access in the rule (i.e.
+ *   &landlock_attr_path_beneath.allowed_access is not a subset of the rule's
+ *   accesses), or too small @rule_size (according to the underlying rule
+ *   type);
+ * - EBADF: @ruleset_fd is not a file descriptor for the current thread;
+ * - EBADFD: @ruleset_fd is not a ruleset file descriptor;
+ * - EPERM: @ruleset_fd has no write access to the underlying ruleset;
+ * - ENODATA, E2BIG or EFAULT: @rule_ptr or @rule_size inconsistencies;
+ */
+SYSCALL_DEFINE5(landlock_add_rule,
+		const int, ruleset_fd, const enum landlock_rule_type, rule_type,
+		const void __user *const, rule_ptr, const size_t, rule_size,
+		const __u32, options)
+{
+	struct landlock_attr_path_beneath attr_path_beneath;
+	struct path path;
+	struct landlock_ruleset *ruleset;
+	int err;
+
+	if (!landlock_initialized)
+		return -EOPNOTSUPP;
+
+	/* No option for now. */
+	if (options)
+		return -EINVAL;
+
+	if (rule_type != LANDLOCK_RULE_PATH_BENEATH)
+		return -EINVAL;
+
+	/* Copies raw user space buffer. */
+	err = copy_struct_if_any_from_user(&attr_path_beneath,
+			sizeof(attr_path_beneath),
+			offsetofend(typeof(attr_path_beneath), allowed_access),
+			rule_ptr, rule_size);
+	if (err)
+		return err;
+
+	/* Gets and checks the ruleset. */
+	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
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
+/**
+ * sys_landlock_enforce_ruleset - Enforce a ruleset
+ *
+ * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
+ * @target_type: Identify which type of target to enforce the ruleset on,
+ *		 currently only the current thread is supported (i.e.
+ *		 seccomp-like).
+ * @target_fd: Must be -1.
+ * @options: Must be 0.
+ *
+ * This system call enables to enforce a Landlock ruleset on the current
+ * thread.  Enforcing a ruleset requires that the task has CAP_SYS_ADMIN in its
+ * namespace or be running with no_new_privs.  This avoids scenarios where
+ * unprivileged tasks can affect the behavior of privileged children.
+ *
+ * Possible returned errors are:
+ *
+ * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
+ * - EINVAL: @options is not 0, or @target_type is not
+ *   %LANDLOCK_TARGET_CURRENT_THREAD, or @target_fd is not -1;
+ * - EBADF: @ruleset_fd is not a file descriptor for the current thread;
+ * - EBADFD: @ruleset_fd is not a ruleset file descriptor;
+ * - EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
+ *   current thread is not running with no_new_privs (or doesn't have
+ *   CAP_SYS_ADMIN in its namespace).
+ */
+SYSCALL_DEFINE4(landlock_enforce_ruleset,
+		const int, ruleset_fd, const enum landlock_target_type, target_type,
+		const int, target_fd, const __u32, options)
+{
+	struct landlock_ruleset *new_dom, *ruleset;
+	struct cred *new_cred;
+	struct landlock_cred_security *new_llcred;
+	int err;
+
+	if (!landlock_initialized)
+		return -EOPNOTSUPP;
+
+	/* No option for now. */
+	if (options)
+		return -EINVAL;
+
+	/* Only target the current thread for now. */
+	if (target_type != LANDLOCK_TARGET_CURRENT_THREAD)
+		return -EINVAL;
+	if (target_fd != -1)
+		return -EINVAL;
+
+	/*
+	 * Similar checks as for seccomp(2), except that an -EPERM may be
+	 * returned.
+	 */
+	if (!task_no_new_privs(current)) {
+		err = security_capable(current_cred(), current_user_ns(),
+				CAP_SYS_ADMIN, CAP_OPT_NOAUDIT);
+		if (err)
+			return err;
+	}
+
+	/* Gets and checks the ruleset. */
+	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
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
-- 
2.28.0.rc2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8435210A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhDAUwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 16:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbhDAUv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:51:26 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B959C0613B1
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 13:51:13 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FBFhc5ZNnzMpttm;
        Thu,  1 Apr 2021 22:51:12 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4FBFhc2Qhmzlppyh;
        Thu,  1 Apr 2021 22:51:12 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v32 08/12] landlock: Add syscall implementations
Date:   Thu,  1 Apr 2021 22:52:04 +0200
Message-Id: <20210401205208.2756565-9-mic@digikod.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401205208.2756565-1-mic@digikod.net>
References: <20210401205208.2756565-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

These 3 system calls are designed to be used by unprivileged processes
to sandbox themselves:
* landlock_create_ruleset(2): Creates a ruleset and returns its file
  descriptor.
* landlock_add_rule(2): Adds a rule (e.g. file hierarchy access) to a
  ruleset, identified by the dedicated file descriptor.
* landlock_restrict_self(2): Enforces a ruleset on the calling thread
  and its future children (similar to seccomp).  This syscall has the
  same usage restrictions as seccomp(2): the caller must have the
  no_new_privs attribute set or have CAP_SYS_ADMIN in the current user
  namespace.

All these syscalls have a "flags" argument (not currently used) to
enable extensibility.

Here are the motivations for these new syscalls:
* A sandboxed process may not have access to file systems, including
  /dev, /sys or /proc, but it should still be able to add more
  restrictions to itself.
* Neither prctl(2) nor seccomp(2) (which was used in a previous version)
  fit well with the current definition of a Landlock security policy.

All passed structs (attributes) are checked at build time to ensure that
they don't contain holes and that they are aligned the same way for each
architecture.

See the user and kernel documentation for more details (provided by a
following commit):
* Documentation/userspace-api/landlock.rst
* Documentation/security/landlock.rst

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/r/20210401205208.2756565-9-mic@digikod.net
---

Changes since v29:
* Rebase on v5.12-rc3 and fix trivial conflict with mount_setattr(2).

Changes since v28:
* Add Acked-by Serge Hallyn.
* Add extra check to be sure to not include ruleset FDs in a dependency
  of a ruleset (e.g. a path_beneath rule).  This case was already
  forbiden thanks to FMODE_PATH and other flags check, but it makes it
  explicit now.

Changes since v27:
* Forbid creation of rules with an empty allowed_access value because
  they are now ignored (since v26) in path walks.
* Rename landlock_enforce_ruleset_self(2) to landlock_restrict_self(2):
  shorter and consistent with the two other syscalls (i.e. verb + direct
  object).
* Update ruleset access check according to the new access stack.
* Improve landlock_add_rule(2) documentation.
* Fix comment.
* Remove Reviewed-by Jann Horn because of the above changes.

Changes since v26:
* Rename landlock_enforce_ruleset_current(2) to
  landlock_enforce_ruleset_self(2).  "current" makes sense for a kernel
  developer, but much less from a user space developer stand point.
  "self" is widely used to refer to the current task (e.g. /proc/self).
  "current" may refer to temporal properties, which could be added later
  to this syscall flags (cf. /proc/self/attr/{current,exec}).
* Simplify build_check_abi().
* Rename syscall.c to syscalls.c .
* Use less ambiguous comments.
* Fix spelling.

Changes since v25:
* Revert build_check_abi() as non-inline to trigger a warning if it is
  not called.
* Use the new limit names.

Changes since v24:
* Add Reviewed-by: Jann Horn <jannh@google.com>
* Set build_check_abi() as inline.

Changes since v23:
* Rewrite get_ruleset_from_fd() to please the 0-DAY CI Kernel Test
  Service that reported an uninitialized variable (false positive):
  https://lore.kernel.org/linux-security-module/202011101854.zGbWwusK-lkp@intel.com/
  Anyway, it is cleaner like this.
* Add a comment about E2BIG which can be returned by
  landlock_enforce_ruleset_current(2) when there is no more room for
  another stacked ruleset (i.e. domain).

Changes since v22:
* Replace security_capable() with ns_capable_noaudit() (suggested by
  Jann Horn) and explicitly return EPERM.
* Fix landlock_enforce_ruleset_current(2)'s out_put_creds (spotted by
  Jann Horn).
* Add __always_inline to copy_min_struct_from_user() to make its
  BUILD_BUG_ON() checks reliable (suggested by Jann Horn).
* Simplify path assignation in get_path_from_fd() (suggested by Jann
  Horn).
* Fix spelling (spotted by Jann Horn).

Changes since v21:
* Fix and improve comments.

Changes since v20:
* Remove two arguments to landlock_enforce_ruleset(2) (requested by Arnd
  Bergmann) and rename it to landlock_enforce_ruleset_current(2): remove
  the enum landlock_target_type and the target file descriptor (not used
  for now).  A ruleset can only be enforced on the current thread.
* Remove the size argument in landlock_add_rule() (requested by Arnd
  Bergmann).
* Remove landlock_get_features(2) (suggested by Arnd Bergmann).
* Simplify and rename copy_struct_if_any_from_user() to
  copy_min_struct_from_user().
* Rename "options" to "flags" to allign with current syscalls.
* Rename some types and variables in a more consistent way.
* Fix missing type declarations in syscalls.h .

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
 include/linux/syscalls.h      |   7 +
 include/uapi/linux/landlock.h |  53 ++++
 kernel/sys_ni.c               |   5 +
 security/landlock/Makefile    |   2 +-
 security/landlock/syscalls.c  | 445 ++++++++++++++++++++++++++++++++++
 5 files changed, 511 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/syscalls.c

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2839dc9a7c01..fa3971012e1c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -69,6 +69,8 @@ struct io_uring_params;
 struct clone_args;
 struct open_how;
 struct mount_attr;
+struct landlock_ruleset_attr;
+enum landlock_rule_type;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1041,6 +1043,11 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr __user *attr,
+		size_t size, __u32 flags);
+asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
+		const void __user *rule_attr, __u32 flags);
+asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index b1a81b5a8b86..ba946a1e40b2 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -9,6 +9,59 @@
 #ifndef _UAPI_LINUX_LANDLOCK_H
 #define _UAPI_LINUX_LANDLOCK_H
 
+#include <linux/types.h>
+
+/**
+ * struct landlock_ruleset_attr - Ruleset definition
+ *
+ * Argument of sys_landlock_create_ruleset().  This structure can grow in
+ * future versions.
+ */
+struct landlock_ruleset_attr {
+	/**
+	 * @handled_access_fs: Bitmask of actions (cf. `Filesystem flags`_)
+	 * that is handled by this ruleset and should then be forbidden if no
+	 * rule explicitly allow them.  This is needed for backward
+	 * compatibility reasons.
+	 */
+	__u64 handled_access_fs;
+};
+
+/**
+ * enum landlock_rule_type - Landlock rule type
+ *
+ * Argument of sys_landlock_add_rule().
+ */
+enum landlock_rule_type {
+	/**
+	 * @LANDLOCK_RULE_PATH_BENEATH: Type of a &struct
+	 * landlock_path_beneath_attr .
+	 */
+	LANDLOCK_RULE_PATH_BENEATH = 1,
+};
+
+/**
+ * struct landlock_path_beneath_attr - Path hierarchy definition
+ *
+ * Argument of sys_landlock_add_rule().
+ */
+struct landlock_path_beneath_attr {
+	/**
+	 * @allowed_access: Bitmask of allowed actions for this file hierarchy
+	 * (cf. `Filesystem flags`_).
+	 */
+	__u64 allowed_access;
+	/**
+	 * @parent_fd: File descriptor, open with ``O_PATH``, which identifies
+	 * the parent directory of a file hierarchy, or just a file.
+	 */
+	__s32 parent_fd;
+	/*
+	 * This struct is packed to avoid trailing reserved members.
+	 * Cf. security/landlock/syscalls.c:build_check_abi()
+	 */
+} __attribute__((packed));
+
 /**
  * DOC: fs_access
  *
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 19aa806890d5..cce430cf2ff2 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -266,6 +266,11 @@ COND_SYSCALL(request_key);
 COND_SYSCALL(keyctl);
 COND_SYSCALL_COMPAT(keyctl);
 
+/* security/landlock/syscalls.c */
+COND_SYSCALL(landlock_create_ruleset);
+COND_SYSCALL(landlock_add_rule);
+COND_SYSCALL(landlock_restrict_self);
+
 /* arch/example/kernel/sys_example.c */
 
 /* mm/fadvise.c */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 92e3d80ab8ed..7bbd2f413b3e 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
-landlock-y := setup.o object.o ruleset.o \
+landlock-y := setup.o syscalls.o object.o ruleset.o \
 	cred.o ptrace.o fs.o
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
new file mode 100644
index 000000000000..48d0073e3ffd
--- /dev/null
+++ b/security/landlock/syscalls.c
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - System call implementations and user space interfaces
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
+#include "limits.h"
+#include "ruleset.h"
+#include "setup.h"
+
+/**
+ * copy_min_struct_from_user - Safe future-proof argument copying
+ *
+ * Extend copy_struct_from_user() to check for consistent user buffer.
+ *
+ * @dst: Kernel space pointer or NULL.
+ * @ksize: Actual size of the data pointed to by @dst.
+ * @ksize_min: Minimal required size to be copied.
+ * @src: User space pointer or NULL.
+ * @usize: (Alleged) size of the data pointed to by @src.
+ */
+static __always_inline int copy_min_struct_from_user(void *const dst,
+		const size_t ksize, const size_t ksize_min,
+		const void __user *const src, const size_t usize)
+{
+	/* Checks buffer inconsistencies. */
+	BUILD_BUG_ON(!dst);
+	if (!src)
+		return -EFAULT;
+
+	/* Checks size ranges. */
+	BUILD_BUG_ON(ksize <= 0);
+	BUILD_BUG_ON(ksize < ksize_min);
+	if (usize < ksize_min)
+		return -EINVAL;
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+
+	/* Copies user buffer and fills with zeros. */
+	return copy_struct_from_user(dst, ksize, src, usize);
+}
+
+/*
+ * This function only contains arithmetic operations with constants, leading to
+ * BUILD_BUG_ON().  The related code is evaluated and checked at build time,
+ * but it is then ignored thanks to compiler optimizations.
+ */
+static void build_check_abi(void)
+{
+	struct landlock_ruleset_attr ruleset_attr;
+	struct landlock_path_beneath_attr path_beneath_attr;
+	size_t ruleset_size, path_beneath_size;
+
+	/*
+	 * For each user space ABI structures, first checks that there is no
+	 * hole in them, then checks that all architectures have the same
+	 * struct size.
+	 */
+	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != 8);
+
+	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
+	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
+	BUILD_BUG_ON(sizeof(path_beneath_attr) != path_beneath_size);
+	BUILD_BUG_ON(sizeof(path_beneath_attr) != 12);
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
+ * @attr: Pointer to a &struct landlock_ruleset_attr identifying the scope of
+ *        the new ruleset.
+ * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
+ *        backward and forward compatibility).
+ * @flags: Must be 0.
+ *
+ * This system call enables to create a new Landlock ruleset, and returns the
+ * related file descriptor on success.
+ *
+ * Possible returned errors are:
+ *
+ * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
+ * - EINVAL: @flags is not 0, or unknown access, or too small @size;
+ * - E2BIG or EFAULT: @attr or @size inconsistencies;
+ * - ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
+ */
+SYSCALL_DEFINE3(landlock_create_ruleset,
+		const struct landlock_ruleset_attr __user *const, attr,
+		const size_t, size, const __u32, flags)
+{
+	struct landlock_ruleset_attr ruleset_attr;
+	struct landlock_ruleset *ruleset;
+	int err, ruleset_fd;
+
+	/* Build-time checks. */
+	build_check_abi();
+
+	if (!landlock_initialized)
+		return -EOPNOTSUPP;
+
+	/* No flag for now. */
+	if (flags)
+		return -EINVAL;
+
+	/* Copies raw user space buffer. */
+	err = copy_min_struct_from_user(&ruleset_attr, sizeof(ruleset_attr),
+			offsetofend(typeof(ruleset_attr), handled_access_fs),
+			attr, size);
+	if (err)
+		return err;
+
+	/* Checks content (and 32-bits cast). */
+	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=
+			LANDLOCK_MASK_ACCESS_FS)
+		return -EINVAL;
+
+	/* Checks arguments and transforms to kernel struct. */
+	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs);
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
+
+	ruleset_f = fdget(fd);
+	if (!ruleset_f.file)
+		return ERR_PTR(-EBADF);
+
+	/* Checks FD type and access right. */
+	if (ruleset_f.file->f_op != &ruleset_fops) {
+		ruleset = ERR_PTR(-EBADFD);
+		goto out_fdput;
+	}
+	if (!(ruleset_f.file->f_mode & mode)) {
+		ruleset = ERR_PTR(-EPERM);
+		goto out_fdput;
+	}
+	ruleset = ruleset_f.file->private_data;
+	if (WARN_ON_ONCE(ruleset->num_layers != 1)) {
+		ruleset = ERR_PTR(-EINVAL);
+		goto out_fdput;
+	}
+	landlock_get_ruleset(ruleset);
+
+out_fdput:
+	fdput(ruleset_f);
+	return ruleset;
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
+		((struct landlock_path_beneath_attr *)NULL)->parent_fd));
+
+	/* Handles O_PATH. */
+	f = fdget_raw(fd);
+	if (!f.file)
+		return -EBADF;
+	/*
+	 * Only allows O_PATH file descriptor: enables to restrict ambient
+	 * filesystem access without requiring to open and risk leaking or
+	 * misusing a file descriptor.  Forbids ruleset FDs, internal
+	 * filesystems (e.g. nsfs), including pseudo filesystems that will
+	 * never be mountable (e.g. sockfs, pipefs).
+	 */
+	if (!(f.file->f_mode & FMODE_PATH) ||
+			(f.file->f_op == &ruleset_fops) ||
+			(f.file->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
+			(f.file->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
+			d_is_negative(f.file->f_path.dentry) ||
+			IS_PRIVATE(d_backing_inode(f.file->f_path.dentry))) {
+		err = -EBADFD;
+		goto out_fdput;
+	}
+	*path = f.file->f_path;
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
+ * @ruleset_fd: File descriptor tied to the ruleset that should be extended
+ *		with the new rule.
+ * @rule_type: Identify the structure type pointed to by @rule_attr (only
+ *             LANDLOCK_RULE_PATH_BENEATH for now).
+ * @rule_attr: Pointer to a rule (only of type &struct
+ *             landlock_path_beneath_attr for now).
+ * @flags: Must be 0.
+ *
+ * This system call enables to define a new rule and add it to an existing
+ * ruleset.
+ *
+ * Possible returned errors are:
+ *
+ * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
+ * - EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
+ *   &landlock_path_beneath_attr.allowed_access is not a subset of the rule's
+ *   accesses);
+ * - ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access);
+ * - EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
+ *   member of @rule_attr is not a file descriptor as expected;
+ * - EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
+ *   @rule_attr is not the expected file descriptor type (e.g. file open
+ *   without O_PATH);
+ * - EPERM: @ruleset_fd has no write access to the underlying ruleset;
+ * - EFAULT: @rule_attr inconsistency.
+ */
+SYSCALL_DEFINE4(landlock_add_rule,
+		const int, ruleset_fd, const enum landlock_rule_type, rule_type,
+		const void __user *const, rule_attr, const __u32, flags)
+{
+	struct landlock_path_beneath_attr path_beneath_attr;
+	struct path path;
+	struct landlock_ruleset *ruleset;
+	int res, err;
+
+	if (!landlock_initialized)
+		return -EOPNOTSUPP;
+
+	/* No flag for now. */
+	if (flags)
+		return -EINVAL;
+
+	if (rule_type != LANDLOCK_RULE_PATH_BENEATH)
+		return -EINVAL;
+
+	/* Copies raw user space buffer, only one type for now. */
+	res = copy_from_user(&path_beneath_attr, rule_attr,
+			sizeof(path_beneath_attr));
+	if (res)
+		return -EFAULT;
+
+	/* Gets and checks the ruleset. */
+	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
+	if (IS_ERR(ruleset))
+		return PTR_ERR(ruleset);
+
+	/*
+	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
+	 * are ignored in path walks.
+	 */
+	if (!path_beneath_attr.allowed_access) {
+		err = -ENOMSG;
+		goto out_put_ruleset;
+	}
+	/*
+	 * Checks that allowed_access matches the @ruleset constraints
+	 * (ruleset->fs_access_masks[0] is automatically upgraded to 64-bits).
+	 */
+	if ((path_beneath_attr.allowed_access | ruleset->fs_access_masks[0]) !=
+			ruleset->fs_access_masks[0]) {
+		err = -EINVAL;
+		goto out_put_ruleset;
+	}
+
+	/* Gets and checks the new rule. */
+	err = get_path_from_fd(path_beneath_attr.parent_fd, &path);
+	if (err)
+		goto out_put_ruleset;
+
+	/* Imports the new rule. */
+	err = landlock_append_fs_rule(ruleset, &path,
+			path_beneath_attr.allowed_access);
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
+ * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
+ *
+ * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
+ * @flags: Must be 0.
+ *
+ * This system call enables to enforce a Landlock ruleset on the current
+ * thread.  Enforcing a ruleset requires that the task has CAP_SYS_ADMIN in its
+ * namespace or is running with no_new_privs.  This avoids scenarios where
+ * unprivileged tasks can affect the behavior of privileged children.
+ *
+ * Possible returned errors are:
+ *
+ * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
+ * - EINVAL: @flags is not 0.
+ * - EBADF: @ruleset_fd is not a file descriptor for the current thread;
+ * - EBADFD: @ruleset_fd is not a ruleset file descriptor;
+ * - EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
+ *   current thread is not running with no_new_privs, or it doesn't have
+ *   CAP_SYS_ADMIN in its namespace.
+ * - E2BIG: The maximum number of stacked rulesets is reached for the current
+ *   thread.
+ */
+SYSCALL_DEFINE2(landlock_restrict_self,
+		const int, ruleset_fd, const __u32, flags)
+{
+	struct landlock_ruleset *new_dom, *ruleset;
+	struct cred *new_cred;
+	struct landlock_cred_security *new_llcred;
+	int err;
+
+	if (!landlock_initialized)
+		return -EOPNOTSUPP;
+
+	/* No flag for now. */
+	if (flags)
+		return -EINVAL;
+
+	/*
+	 * Similar checks as for seccomp(2), except that an -EPERM may be
+	 * returned.
+	 */
+	if (!task_no_new_privs(current) &&
+			!ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
+		return -EPERM;
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
+
+out_put_ruleset:
+	landlock_put_ruleset(ruleset);
+	return err;
+}
-- 
2.30.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA516AAF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 17:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBXQK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 11:10:59 -0500
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:51414 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgBXQK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:10:58 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 11:10:31 EST
Received: from smtp-2-0001.mail.infomaniak.ch ([10.5.36.108])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id 01OG2VCE021831
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Feb 2020 17:02:31 +0100
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48R6K25ktqzln9HX;
        Mon, 24 Feb 2020 17:02:30 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [RFC PATCH v14 06/10] landlock: Add syscall implementation
Date:   Mon, 24 Feb 2020 17:02:11 +0100
Message-Id: <20200224160215.4136-7-mic@digikod.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224160215.4136-1-mic@digikod.net>
References: <20200224160215.4136-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This syscall, inspired from seccomp(2) and bpf(2), is designed to be
used by unprivileged processes to sandbox themselves.  It has the same
usage restrictions as seccomp(2): no_new_privs check.

There is currently four commands:
* get_features: Gets the supported features (required for backward
  compatibility and best-effort security).
* create_ruleset: Creates a ruleset and returns its file descriptor.
* add_rule: Adds a rule (e.g. file hierarchy access) to a ruleset,
  identified by the dedicated file descriptor.
* enforce_ruleset: Enforces a ruleset on the current thread (similar to
  seccomp).

See the user and code documentation for more details.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v13:
* New implementation, replacing the dependency on seccomp(2) and bpf(2).
---
 include/linux/syscalls.h      |   3 +
 include/uapi/linux/landlock.h | 213 +++++++++++++++
 security/landlock/Makefile    |   2 +-
 security/landlock/ruleset.c   |   3 +
 security/landlock/syscall.c   | 470 ++++++++++++++++++++++++++++++++++
 5 files changed, 690 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/syscall.c

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..beaadcf4ef77 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1003,6 +1003,9 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_landlock(unsigned int command, unsigned int options,
+			     size_t attr1_size, void __user *attr1_ptr,
+			     size_t attr2_size, void __user *attr2_ptr);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 92760aca3645..0b6d3e9f4b37 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -9,6 +9,219 @@
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
+#define LANDLOCK_OPT_GET_FEATURES			(1ULL << 0)
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
+#define LANDLOCK_OPT_CREATE_RULESET			(1ULL << 0)
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
+#define LANDLOCK_OPT_ADD_RULE_PATH_BENEATH		(1ULL << 0)
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
+#define LANDLOCK_OPT_ENFORCE_RULESET			(1ULL << 0)
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
+	__aligned_u64 options_get_features;
+	/**
+	 * @options_create_ruleset: Options supported by the
+	 * %LANDLOCK_CMD_CREATE_RULESET command. Cf. `Options`_.
+	 */
+	__aligned_u64 options_create_ruleset;
+	/**
+	 * @options_add_rule: Options supported by the %LANDLOCK_CMD_ADD_RULE
+	 * command. Cf. `Options`_.
+	 */
+	__aligned_u64 options_add_rule;
+	/**
+	 * @options_enforce_ruleset: Options supported by the
+	 * %LANDLOCK_CMD_ENFORCE_RULESET command. Cf. `Options`_.
+	 */
+	__aligned_u64 options_enforce_ruleset;
+	/**
+	 * @access_fs: Subset of file system access supported by the running
+	 * kernel, used in &struct landlock_attr_ruleset and &struct
+	 * landlock_attr_path_beneath.  Cf. `Filesystem flags`_.
+	 */
+	__aligned_u64 access_fs;
+	/**
+	 * @size_attr_ruleset: Size of the &struct landlock_attr_ruleset as
+	 * known by the kernel (i.e.  ``sizeof(struct
+	 * landlock_attr_ruleset)``).
+	 */
+	__aligned_u64 size_attr_ruleset;
+	/**
+	 * @size_attr_path_beneath: Size of the &struct
+	 * landlock_attr_path_beneath as known by the kernel (i.e.
+	 * ``sizeof(struct landlock_path_beneath)``).
+	 */
+	__aligned_u64 size_attr_path_beneath;
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
+	__aligned_u64 handled_access_fs;
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
+	__aligned_u64 ruleset_fd;
+	/**
+	 * @parent_fd: File descriptor, open with ``O_PATH``, which identify
+	 * the parent directory of a file hierarchy, or just a file.
+	 */
+	__aligned_u64 parent_fd;
+	/**
+	 * @allowed_access: Bitmask of allowed actions for this file hierarchy
+	 * (cf. `Filesystem flags`_).
+	 */
+	__aligned_u64 allowed_access;
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
+	__aligned_u64 ruleset_fd;
+};
+
 /**
  * DOC: fs_access
  *
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 92e3d80ab8ed..4388494779ec 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
-landlock-y := setup.o object.o ruleset.o \
+landlock-y := setup.o syscall.o object.o ruleset.o \
 	cred.o ptrace.o fs.o
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 5ec013a4188d..fab17110804f 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/landlock.h>
 
 #include "object.h"
 #include "ruleset.h"
@@ -40,6 +41,8 @@ struct landlock_ruleset *landlock_create_ruleset(u64 fs_access_mask)
 	struct landlock_ruleset *ruleset;
 
 	/* Safely handles 32-bits conversion. */
+	BUILD_BUG_ON(!__same_type(fs_access_mask, ((struct
+		landlock_attr_ruleset *)NULL)->handled_access_fs));
 	BUILD_BUG_ON(!__same_type(fs_access_mask, _LANDLOCK_ACCESS_FS_LAST));
 
 	/* Checks content. */
diff --git a/security/landlock/syscall.c b/security/landlock/syscall.c
new file mode 100644
index 000000000000..da80e3061b5a
--- /dev/null
+++ b/security/landlock/syscall.c
@@ -0,0 +1,470 @@
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
+#include <linux/dcache.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/landlock.h>
+#include <linux/limits.h>
+#include <linux/path.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+#include <linux/sched.h>
+#include <linux/security.h>
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
+ * @dst: kernel space pointer or NULL
+ * @ksize: size of the data pointed by @dst
+ * @src: user space pointer or NULL
+ * @usize: size of the data pointed by @src
+ */
+static int copy_struct_if_any_from_user(void *dst, size_t ksize,
+		const void __user *src, size_t usize)
+{
+	int ret;
+
+	if (dst) {
+		if (WARN_ON_ONCE(ksize == 0))
+			return -EFAULT;
+	} else {
+		if (WARN_ON_ONCE(ksize != 0))
+			return -EFAULT;
+	}
+	if (!src) {
+		if (usize != 0)
+			return -EFAULT;
+		if (dst)
+			memset(dst, 0, ksize);
+		return 0;
+	}
+	if (usize == 0)
+		return -ENODATA;
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+	if (dst)
+		return copy_struct_from_user(dst, ksize, src, usize);
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
+static int syscall_get_features(size_t attr_size, void __user *attr_ptr)
+{
+	size_t data_size, fill_size;
+	struct landlock_attr_features supported = {
+		.options_get_features = _LANDLOCK_OPT_GET_FEATURES_MASK,
+		.options_create_ruleset = _LANDLOCK_OPT_CREATE_RULESET_MASK,
+		.options_add_rule = _LANDLOCK_OPT_ADD_RULE_MASK,
+		.options_enforce_ruleset = _LANDLOCK_OPT_ENFORCE_RULESET_MASK,
+		.access_fs = _LANDLOCK_ACCESS_FS_MASK,
+		.size_attr_ruleset = sizeof(struct landlock_attr_ruleset),
+		.size_attr_path_beneath = sizeof(struct
+				landlock_attr_path_beneath),
+	};
+
+	if (attr_size == 0)
+		return -ENODATA;
+	if (attr_size > PAGE_SIZE)
+		return -E2BIG;
+	data_size = min(sizeof(supported), attr_size);
+	if (copy_to_user(attr_ptr, &supported, data_size))
+		return -EFAULT;
+	/* Fills the rest with zeros. */
+	fill_size = attr_size - data_size;
+	if (fill_size > 0 && clear_user(attr_ptr + data_size, fill_size))
+		return -EFAULT;
+	return 0;
+}
+
+/* Ruleset handling */
+
+#ifdef CONFIG_PROC_FS
+static void fop_ruleset_show_fdinfo(struct seq_file *m, struct file *filp)
+{
+	const struct landlock_ruleset *ruleset = filp->private_data;
+
+	seq_printf(m, "handled_access_fs:\t%x\n", ruleset->fs_access_mask);
+	seq_printf(m, "nb_rules:\t%d\n", atomic_read(&ruleset->nb_rules));
+}
+#endif
+
+static int fop_ruleset_release(struct inode *inode, struct file *filp)
+{
+	struct landlock_ruleset *ruleset = filp->private_data;
+
+	landlock_put_ruleset(ruleset);
+	return 0;
+}
+
+static ssize_t fop_dummy_read(struct file *filp, char __user *buf, size_t size,
+		loff_t *ppos)
+{
+	/* Dummy handler to enable FMODE_CAN_READ. */
+	return -EINVAL;
+}
+
+static ssize_t fop_dummy_write(struct file *filp, const char __user *buf,
+			       size_t size, loff_t *ppos)
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
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= fop_ruleset_show_fdinfo,
+#endif
+	.release	= fop_ruleset_release,
+	.read		= fop_dummy_read,
+	.write		= fop_dummy_write,
+};
+
+static int syscall_create_ruleset(size_t attr_size, void __user *attr_ptr)
+{
+	struct landlock_attr_ruleset attr_ruleset;
+	struct landlock_ruleset *ruleset;
+	int err, ruleset_fd;
+
+	/* Copies raw userspace struct. */
+	err = copy_struct_if_any_from_user(&attr_ruleset, sizeof(attr_ruleset),
+			attr_ptr, attr_size);
+	if (err)
+		return err;
+
+	/* Checks arguments and transform to kernel struct. */
+	ruleset = landlock_create_ruleset(attr_ruleset.handled_access_fs);
+	if (IS_ERR(ruleset))
+		return PTR_ERR(ruleset);
+
+	/* Creates anonymous FD referring to the ruleset, with safe flags. */
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
+static struct landlock_ruleset *get_ruleset_from_fd(u64 fd, fmode_t mode)
+{
+	struct fd ruleset_f;
+	struct landlock_ruleset *ruleset;
+	int err;
+
+	BUILD_BUG_ON(!__same_type(fd,
+		((struct landlock_attr_path_beneath *)NULL)->ruleset_fd));
+	BUILD_BUG_ON(!__same_type(fd,
+		((struct landlock_attr_enforce *)NULL)->ruleset_fd));
+	/* Checks 32-bits overflow. fdget() checks for INT_MAX/FD. */
+	if (fd > U32_MAX)
+		return ERR_PTR(-EINVAL);
+	ruleset_f = fdget(fd);
+	if (!ruleset_f.file)
+		return ERR_PTR(-EBADF);
+	err = 0;
+	if (ruleset_f.file->f_op != &ruleset_fops)
+		err = -EBADR;
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
+static inline bool is_user_mountable(struct dentry *dentry)
+{
+	/*
+	 * Check pseudo-filesystems that will never be mountable (e.g. sockfs,
+	 * pipefs, bdev), cf. fs/libfs.c:init_pseudo().
+	 */
+	return d_is_positive(dentry) &&
+		!IS_PRIVATE(dentry->d_inode) &&
+		!(dentry->d_sb->s_flags & SB_NOUSER);
+}
+
+/*
+ * @path: Must call put_path(@path) after the call if it succeeded.
+ */
+static int get_path_from_fd(u64 fd, struct path *path)
+{
+	struct fd f;
+	int err;
+
+	BUILD_BUG_ON(!__same_type(fd,
+		((struct landlock_attr_path_beneath *)NULL)->parent_fd));
+	/* Checks 32-bits overflow. fdget_raw() checks for INT_MAX/FD. */
+	if (fd > U32_MAX)
+		return -EINVAL;
+	/* Handles O_PATH. */
+	f = fdget_raw(fd);
+	if (!f.file)
+		return -EBADF;
+	/*
+	 * Forbids to add to a ruleset a path which is forbidden to open (by
+	 * Landlock, another LSM, DAC...).  Because the file was open with
+	 * O_PATH, the file mode doesn't have FMODE_READ nor FMODE_WRITE.
+	 *
+	 * WARNING: security_file_open() was only called in do_dentry_open()
+	 * until now.  The main difference now is that f_op may be NULL.  This
+	 * field doesn't seem to be dereferenced by any upstream LSM though.
+	 */
+	err = security_file_open(f.file);
+	if (err)
+		goto out_fdput;
+	/*
+	 * Only allows O_PATH FD: enable to restrict ambiant (FS) accesses
+	 * without requiring to open and risk leaking or misuing a FD.  Accept
+	 * removed, but still open directory (S_DEAD).
+	 */
+	if (!(f.file->f_mode & FMODE_PATH) || !f.file->f_path.mnt ||
+			!is_user_mountable(f.file->f_path.dentry)) {
+		err = -EBADR;
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
+static int syscall_add_rule_path_beneath(size_t attr_size,
+		void __user *attr_ptr)
+{
+	struct landlock_attr_path_beneath attr_path_beneath;
+	struct path path;
+	struct landlock_ruleset *ruleset;
+	int err;
+
+	/* Copies raw userspace struct. */
+	err = copy_struct_if_any_from_user(&attr_path_beneath,
+			sizeof(attr_path_beneath), attr_ptr, attr_size);
+	if (err)
+		return err;
+
+	/* Gets the ruleset. */
+	ruleset = get_ruleset_from_fd(attr_path_beneath.ruleset_fd,
+			FMODE_CAN_WRITE);
+	if (IS_ERR(ruleset))
+		return PTR_ERR(ruleset);
+
+	/* Checks content (fs_access_mask is upgraded to 64-bits). */
+	if ((attr_path_beneath.allowed_access | ruleset->fs_access_mask) !=
+			ruleset->fs_access_mask) {
+		err = -EINVAL;
+		goto out_put_ruleset;
+	}
+
+	err = get_path_from_fd(attr_path_beneath.parent_fd, &path);
+	if (err)
+		goto out_put_ruleset;
+
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
+static int syscall_enforce_ruleset(size_t attr_size,
+		void __user *attr_ptr)
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
+	/* Copies raw userspace struct. */
+	err = copy_struct_if_any_from_user(&attr_enforce, sizeof(attr_enforce),
+			attr_ptr, attr_size);
+	if (err)
+		return err;
+
+	/* Get the ruleset. */
+	ruleset = get_ruleset_from_fd(attr_enforce.ruleset_fd, FMODE_CAN_READ);
+	if (IS_ERR(ruleset))
+		return PTR_ERR(ruleset);
+	/* Informs about useless ruleset. */
+	if (!atomic_read(&ruleset->nb_rules)) {
+		err = -ENOMSG;
+		goto out_put_ruleset;
+	}
+
+	new_cred = prepare_creds();
+	if (!new_cred) {
+		err = -ENOMEM;
+		goto out_put_ruleset;
+	}
+	new_llcred = landlock_cred(new_cred);
+	/*
+	 * There is no possible race condition while copying and manipulating
+	 * the current credentials because they are dedicated per thread.
+	 */
+	new_dom = landlock_merge_ruleset(new_llcred->domain, ruleset);
+	if (IS_ERR(new_dom)) {
+		err = PTR_ERR(new_dom);
+		goto out_put_creds;
+	}
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
+
+/**
+ * landlock - System call to enable a process to safely sandbox itself
+ *
+ * @command: Landlock command to perform miscellaneous, but safe, actions. Cf.
+ *           `Commands`_.
+ * @options: Bitmask of options dedicated to one command. Cf. `Options`_.
+ * @attr1_size: First attribute size (i.e. size of the struct).
+ * @attr1_ptr: Pointer to the first attribute. Cf. `Attributes`_.
+ * @attr2_size: Unused for now.
+ * @attr2_ptr: Unused for now.
+ *
+ * The @command and @options arguments enable a seccomp-bpf policy to control
+ * the requested actions.  However, it should be noted that Landlock is
+ * designed from the ground to enable unprivileged process to drop privileges
+ * and accesses in a way that can not harm other processes.  This syscall and
+ * all its arguments should then be allowed for any process, which will then
+ * enable applications to strengthen the security of the whole system.
+ *
+ * @attr2_size and @attr2_ptr describe a second attribute which could be used
+ * in the future to compose with the first attribute (e.g. a
+ * landlock_attr_path_beneath with a landlock_attr_ioctl).
+ *
+ * The order of return errors begins with ENOPKG (disabled Landlock),
+ * EOPNOTSUPP (unknown command or option) and then EINVAL (invalid attribute).
+ * The other error codes may be specific to each command.
+ */
+SYSCALL_DEFINE6(landlock, unsigned int, command, unsigned int, options,
+		size_t, attr1_size, void __user *, attr1_ptr,
+		size_t, attr2_size, void __user *, attr2_ptr)
+{
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
+			if (attr2_size || attr2_ptr)
+				return -EINVAL;
+			return syscall_get_features(attr1_size, attr1_ptr);
+		}
+		return -EOPNOTSUPP;
+	case LANDLOCK_CMD_CREATE_RULESET:
+		if (options == LANDLOCK_OPT_CREATE_RULESET) {
+			if (attr2_size || attr2_ptr)
+				return -EINVAL;
+			return syscall_create_ruleset(attr1_size, attr1_ptr);
+		}
+		return -EOPNOTSUPP;
+	case LANDLOCK_CMD_ADD_RULE:
+		/*
+		 * A future extension could add a
+		 * LANDLOCK_OPT_ADD_RULE_PATH_RANGE.
+		 */
+		if (options == LANDLOCK_OPT_ADD_RULE_PATH_BENEATH) {
+			if (attr2_size || attr2_ptr)
+				return -EINVAL;
+			return syscall_add_rule_path_beneath(attr1_size,
+					attr1_ptr);
+		}
+		return -EOPNOTSUPP;
+	case LANDLOCK_CMD_ENFORCE_RULESET:
+		if (options == LANDLOCK_OPT_ENFORCE_RULESET) {
+			if (attr2_size || attr2_ptr)
+				return -EINVAL;
+			return syscall_enforce_ruleset(attr1_size, attr1_ptr);
+		}
+		return -EOPNOTSUPP;
+	}
+	return -EOPNOTSUPP;
+}
-- 
2.25.0


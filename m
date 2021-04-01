Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED212352116
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 22:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbhDAUwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 16:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhDAUvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:51:52 -0400
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A1CC0613B6;
        Thu,  1 Apr 2021 13:51:17 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FBFhh5dJBzMqKyt;
        Thu,  1 Apr 2021 22:51:16 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4FBFhh2s4Dzlppyh;
        Thu,  1 Apr 2021 22:51:16 +0200 (CEST)
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
Subject: [PATCH v32 11/12] samples/landlock: Add a sandbox manager example
Date:   Thu,  1 Apr 2021 22:52:07 +0200
Message-Id: <20210401205208.2756565-12-mic@digikod.net>
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

Add a basic sandbox tool to launch a command which can only access a
list of file hierarchies in a read-only or read-write way.

Cc: James Morris <jmorris@namei.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210401205208.2756565-12-mic@digikod.net
---

Changes since v30:
* Add Reviewed-by Kees Cook.

Changes since v28:
* Simplify Kconfig option title.

Changes since v27:
* Add samples/landlock/ to MAINTAINERS.
* Update landlock_restrict_self(2).
* Tweak Kconfig title and description.

Changes since v25:
* Improve comments and fix help (suggested by Jann Horn).
* Add a safeguard for errno check (suggested by Jann Horn).
* Allows users to not use all possible restrictions (e.g. use LL_FS_RO
  without LL_FS_RW).
* Update syscall names.
* Improve Makefile:
  - Replace hostprogs/always-y with userprogs-always-y, available since
    commit faabed295ccc ("kbuild: introduce hostprogs-always-y and
    userprogs-always-y").
  - Depends on CC_CAN_LINK.
* Add Reviewed-by Jann Horn.

Changes since v25:
* Remove useless errno set in the syscall wrappers.
* Cosmetic variable renames.

Changes since v23:
* Re-add hints to help users understand the required kernel
  configuration.  This was removed with the removal of
  landlock_get_features(2).

Changes since v21:
* Remove LANDLOCK_ACCESS_FS_CHROOT.
* Clean up help.

Changes since v20:
* Update with new syscalls and type names.
* Update errno check for EOPNOTSUPP.
* Use the full syscall interfaces: explicitely set the "flags" field to
  zero.

Changes since v19:
* Update with the new Landlock syscalls.
* Comply with commit 5f2fb52fac15 ("kbuild: rename hostprogs-y/always to
  hostprogs/always-y").

Changes since v16:
* Switch syscall attribute pointer and size arguments.

Changes since v15:
* Update access right names.
* Properly assign access right to files according to the new related
  syscall restriction.
* Replace "select" with "depends on" HEADERS_INSTALL (suggested by Randy
  Dunlap).

Changes since v14:
* Fix Kconfig dependency.
* Remove access rights that may be required for FD-only requests:
  mmap, truncate, getattr, lock, chmod, chown, chgrp, ioctl.
* Fix useless hardcoded syscall number.
* Use execvpe().
* Follow symlinks.
* Extend help with common file paths.
* Constify variables.
* Clean up comments.
* Improve error message.

Changes since v11:
* Add back the filesystem sandbox manager and update it to work with the
  new Landlock syscall.

Previous changes:
https://lore.kernel.org/lkml/20190721213116.23476-9-mic@digikod.net/
---
 MAINTAINERS                  |   1 +
 samples/Kconfig              |   7 ++
 samples/Makefile             |   1 +
 samples/landlock/.gitignore  |   1 +
 samples/landlock/Makefile    |  13 ++
 samples/landlock/sandboxer.c | 238 +++++++++++++++++++++++++++++++++++
 6 files changed, 261 insertions(+)
 create mode 100644 samples/landlock/.gitignore
 create mode 100644 samples/landlock/Makefile
 create mode 100644 samples/landlock/sandboxer.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cab5854844e..88175ed1f315 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10004,6 +10004,7 @@ S:	Supported
 W:	https://landlock.io
 T:	git https://github.com/landlock-lsm/linux.git
 F:	include/uapi/linux/landlock.h
+F:	samples/landlock/
 F:	security/landlock/
 F:	tools/testing/selftests/landlock/
 K:	landlock
diff --git a/samples/Kconfig b/samples/Kconfig
index e76cdfc50e25..b5a1a7aa7e23 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -124,6 +124,13 @@ config SAMPLE_HIDRAW
 	bool "hidraw sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
 
+config SAMPLE_LANDLOCK
+	bool "Landlock example"
+	depends on CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  Build a simple Landlock sandbox manager able to start a process
+	  restricted by a user-defined filesystem access control policy.
+
 config SAMPLE_PIDFD
 	bool "pidfd sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index c3392a595e4b..087e0988ccc5 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
 obj-$(CONFIG_SAMPLE_KFIFO)		+= kfifo/
 obj-$(CONFIG_SAMPLE_KOBJECT)		+= kobject/
 obj-$(CONFIG_SAMPLE_KPROBES)		+= kprobes/
+subdir-$(CONFIG_SAMPLE_LANDLOCK)	+= landlock
 obj-$(CONFIG_SAMPLE_LIVEPATCH)		+= livepatch/
 subdir-$(CONFIG_SAMPLE_PIDFD)		+= pidfd
 obj-$(CONFIG_SAMPLE_QMI_CLIENT)		+= qmi/
diff --git a/samples/landlock/.gitignore b/samples/landlock/.gitignore
new file mode 100644
index 000000000000..f43668b2d318
--- /dev/null
+++ b/samples/landlock/.gitignore
@@ -0,0 +1 @@
+/sandboxer
diff --git a/samples/landlock/Makefile b/samples/landlock/Makefile
new file mode 100644
index 000000000000..5d601e51c2eb
--- /dev/null
+++ b/samples/landlock/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: BSD-3-Clause
+
+userprogs-always-y := sandboxer
+
+userccflags += -I usr/include
+
+.PHONY: all clean
+
+all:
+	$(MAKE) -C ../.. samples/landlock/
+
+clean:
+	$(MAKE) -C ../.. M=samples/landlock/ clean
diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
new file mode 100644
index 000000000000..7a15910d2171
--- /dev/null
+++ b/samples/landlock/sandboxer.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Simple Landlock sandbox manager able to launch a process restricted by a
+ * user-defined filesystem access control policy.
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2020 ANSSI
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <linux/prctl.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#ifndef landlock_create_ruleset
+static inline int landlock_create_ruleset(
+		const struct landlock_ruleset_attr *const attr,
+		const size_t size, const __u32 flags)
+{
+	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
+}
+#endif
+
+#ifndef landlock_add_rule
+static inline int landlock_add_rule(const int ruleset_fd,
+		const enum landlock_rule_type rule_type,
+		const void *const rule_attr, const __u32 flags)
+{
+	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type,
+			rule_attr, flags);
+}
+#endif
+
+#ifndef landlock_restrict_self
+static inline int landlock_restrict_self(const int ruleset_fd,
+		const __u32 flags)
+{
+	return syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
+}
+#endif
+
+#define ENV_FS_RO_NAME "LL_FS_RO"
+#define ENV_FS_RW_NAME "LL_FS_RW"
+#define ENV_PATH_TOKEN ":"
+
+static int parse_path(char *env_path, const char ***const path_list)
+{
+	int i, num_paths = 0;
+
+	if (env_path) {
+		num_paths++;
+		for (i = 0; env_path[i]; i++) {
+			if (env_path[i] == ENV_PATH_TOKEN[0])
+				num_paths++;
+		}
+	}
+	*path_list = malloc(num_paths * sizeof(**path_list));
+	for (i = 0; i < num_paths; i++)
+		(*path_list)[i] = strsep(&env_path, ENV_PATH_TOKEN);
+
+	return num_paths;
+}
+
+#define ACCESS_FILE ( \
+	LANDLOCK_ACCESS_FS_EXECUTE | \
+	LANDLOCK_ACCESS_FS_WRITE_FILE | \
+	LANDLOCK_ACCESS_FS_READ_FILE)
+
+static int populate_ruleset(
+		const char *const env_var, const int ruleset_fd,
+		const __u64 allowed_access)
+{
+	int num_paths, i, ret = 1;
+	char *env_path_name;
+	const char **path_list = NULL;
+	struct landlock_path_beneath_attr path_beneath = {
+		.parent_fd = -1,
+	};
+
+	env_path_name = getenv(env_var);
+	if (!env_path_name) {
+		/* Prevents users to forget a setting. */
+		fprintf(stderr, "Missing environment variable %s\n", env_var);
+		return 1;
+	}
+	env_path_name = strdup(env_path_name);
+	unsetenv(env_var);
+	num_paths = parse_path(env_path_name, &path_list);
+	if (num_paths == 1 && path_list[0][0] == '\0') {
+		/*
+		 * Allows to not use all possible restrictions (e.g. use
+		 * LL_FS_RO without LL_FS_RW).
+		 */
+		ret = 0;
+		goto out_free_name;
+	}
+
+	for (i = 0; i < num_paths; i++) {
+		struct stat statbuf;
+
+		path_beneath.parent_fd = open(path_list[i], O_PATH |
+				O_CLOEXEC);
+		if (path_beneath.parent_fd < 0) {
+			fprintf(stderr, "Failed to open \"%s\": %s\n",
+					path_list[i],
+					strerror(errno));
+			goto out_free_name;
+		}
+		if (fstat(path_beneath.parent_fd, &statbuf)) {
+			close(path_beneath.parent_fd);
+			goto out_free_name;
+		}
+		path_beneath.allowed_access = allowed_access;
+		if (!S_ISDIR(statbuf.st_mode))
+			path_beneath.allowed_access &= ACCESS_FILE;
+		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+					&path_beneath, 0)) {
+			fprintf(stderr, "Failed to update the ruleset with \"%s\": %s\n",
+					path_list[i], strerror(errno));
+			close(path_beneath.parent_fd);
+			goto out_free_name;
+		}
+		close(path_beneath.parent_fd);
+	}
+	ret = 0;
+
+out_free_name:
+	free(env_path_name);
+	return ret;
+}
+
+#define ACCESS_FS_ROUGHLY_READ ( \
+	LANDLOCK_ACCESS_FS_EXECUTE | \
+	LANDLOCK_ACCESS_FS_READ_FILE | \
+	LANDLOCK_ACCESS_FS_READ_DIR)
+
+#define ACCESS_FS_ROUGHLY_WRITE ( \
+	LANDLOCK_ACCESS_FS_WRITE_FILE | \
+	LANDLOCK_ACCESS_FS_REMOVE_DIR | \
+	LANDLOCK_ACCESS_FS_REMOVE_FILE | \
+	LANDLOCK_ACCESS_FS_MAKE_CHAR | \
+	LANDLOCK_ACCESS_FS_MAKE_DIR | \
+	LANDLOCK_ACCESS_FS_MAKE_REG | \
+	LANDLOCK_ACCESS_FS_MAKE_SOCK | \
+	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
+	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
+	LANDLOCK_ACCESS_FS_MAKE_SYM)
+
+int main(const int argc, char *const argv[], char *const *const envp)
+{
+	const char *cmd_path;
+	char *const *cmd_argv;
+	int ruleset_fd;
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_FS_ROUGHLY_READ |
+			ACCESS_FS_ROUGHLY_WRITE,
+	};
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s=\"...\" %s=\"...\" %s <cmd> [args]...\n\n",
+				ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
+		fprintf(stderr, "Launch a command in a restricted environment.\n\n");
+		fprintf(stderr, "Environment variables containing paths, "
+				"each separated by a colon:\n");
+		fprintf(stderr, "* %s: list of paths allowed to be used in a read-only way.\n",
+				ENV_FS_RO_NAME);
+		fprintf(stderr, "* %s: list of paths allowed to be used in a read-write way.\n",
+				ENV_FS_RW_NAME);
+		fprintf(stderr, "\nexample:\n"
+				"%s=\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
+				"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
+				"%s bash -i\n",
+				ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
+		return 1;
+	}
+
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	if (ruleset_fd < 0) {
+		const int err = errno;
+
+		perror("Failed to create a ruleset");
+		switch (err) {
+		case ENOSYS:
+			fprintf(stderr, "Hint: Landlock is not supported by the current kernel. "
+					"To support it, build the kernel with "
+					"CONFIG_SECURITY_LANDLOCK=y and prepend "
+					"\"landlock,\" to the content of CONFIG_LSM.\n");
+			break;
+		case EOPNOTSUPP:
+			fprintf(stderr, "Hint: Landlock is currently disabled. "
+					"It can be enabled in the kernel configuration by "
+					"prepending \"landlock,\" to the content of CONFIG_LSM, "
+					"or at boot time by setting the same content to the "
+					"\"lsm\" kernel parameter.\n");
+			break;
+		}
+		return 1;
+	}
+	if (populate_ruleset(ENV_FS_RO_NAME, ruleset_fd,
+				ACCESS_FS_ROUGHLY_READ)) {
+		goto err_close_ruleset;
+	}
+	if (populate_ruleset(ENV_FS_RW_NAME, ruleset_fd,
+				ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE)) {
+		goto err_close_ruleset;
+	}
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+		perror("Failed to restrict privileges");
+		goto err_close_ruleset;
+	}
+	if (landlock_restrict_self(ruleset_fd, 0)) {
+		perror("Failed to enforce ruleset");
+		goto err_close_ruleset;
+	}
+	close(ruleset_fd);
+
+	cmd_path = argv[1];
+	cmd_argv = argv + 1;
+	execvpe(cmd_path, cmd_argv, envp);
+	fprintf(stderr, "Failed to execute \"%s\": %s\n", cmd_path,
+			strerror(errno));
+	fprintf(stderr, "Hint: access to the binary, the interpreter or "
+			"shared libraries may be denied.\n");
+	return 1;
+
+err_close_ruleset:
+	close(ruleset_fd);
+	return 1;
+}
-- 
2.30.2


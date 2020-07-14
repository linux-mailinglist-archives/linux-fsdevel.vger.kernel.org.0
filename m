Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF821F8F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 20:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgGNSRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 14:17:01 -0400
Received: from smtp-42aa.mail.infomaniak.ch ([84.16.66.170]:54781 "EHLO
        smtp-42aa.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729150AbgGNSRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:17:00 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B5pd5143WzlhCYJ;
        Tue, 14 Jul 2020 20:16:57 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4B5pd44Pj7zlh8TK;
        Tue, 14 Jul 2020 20:16:56 +0200 (CEST)
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
Subject: [PATCH v6 6/7] selftest/openat2: Add tests for O_MAYEXEC enforcing
Date:   Tue, 14 Jul 2020 20:16:37 +0200
Message-Id: <20200714181638.45751-7-mic@digikod.net>
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

Test propagation of noexec mount points or file executability through
files open with or without O_MAYEXEC, thanks to the
fs.open_mayexec_enforce sysctl.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
---

Changes since v5:
* Refactor with FIXTURE_VARIANT, which make the tests much more easy to
  read and maintain.
* Save and restore initial sysctl value (suggested by Kees Cook).
* Test with a sysctl value of 0.
* Check errno in sysctl_access_write test.
* Update tests for the CAP_SYS_ADMIN switch.
* Update tests to check -EISDIR (replacing -EACCES).
* Replace FIXTURE_DATA() with FIXTURE() (spotted by Kees Cook).
* Use global const strings.

Changes since v3:
* Replace RESOLVE_MAYEXEC with O_MAYEXEC.
* Add tests to check that O_MAYEXEC is ignored by open(2) and openat(2).

Changes since v2:
* Move tests from exec/ to openat2/ .
* Replace O_MAYEXEC with RESOLVE_MAYEXEC from openat2(2).
* Cleanup tests.

Changes since v1:
* Move tests from yama/ to exec/ .
* Fix _GNU_SOURCE in kselftest_harness.h .
* Add a new test sysctl_access_write to check if CAP_MAC_ADMIN is taken
  into account.
* Test directory execution which is always forbidden since commit
  73601ea5b7b1 ("fs/open.c: allow opening only regular files during
  execve()"), and also check that even the root user can not bypass file
  execution checks.
* Make sure delete_workspace() always as enough right to succeed.
* Cosmetic cleanup.
---
 tools/testing/selftests/kselftest_harness.h   |   3 +
 tools/testing/selftests/openat2/Makefile      |   3 +-
 tools/testing/selftests/openat2/config        |   1 +
 tools/testing/selftests/openat2/helpers.h     |   1 +
 .../testing/selftests/openat2/omayexec_test.c | 262 ++++++++++++++++++
 5 files changed, 269 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/openat2/config
 create mode 100644 tools/testing/selftests/openat2/omayexec_test.c

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index c9f03ef93338..68a0acd9ea1e 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -50,7 +50,10 @@
 #ifndef __KSELFTEST_HARNESS_H
 #define __KSELFTEST_HARNESS_H
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
+
 #include <asm/types.h>
 #include <errno.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 4b93b1417b86..cb98bdb4d5b1 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
-TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
+LDLIBS += -lcap
+TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test omayexec_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/openat2/config b/tools/testing/selftests/openat2/config
new file mode 100644
index 000000000000..dd53c266bf52
--- /dev/null
+++ b/tools/testing/selftests/openat2/config
@@ -0,0 +1 @@
+CONFIG_SYSCTL=y
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index a6ea27344db2..1dcd3e1e2f38 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -9,6 +9,7 @@
 
 #define _GNU_SOURCE
 #include <stdint.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <linux/types.h>
 #include "../kselftest.h"
diff --git a/tools/testing/selftests/openat2/omayexec_test.c b/tools/testing/selftests/openat2/omayexec_test.c
new file mode 100644
index 000000000000..a33f31e59045
--- /dev/null
+++ b/tools/testing/selftests/openat2/omayexec_test.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test O_MAYEXEC
+ *
+ * Copyright © 2018-2020 ANSSI
+ *
+ * Author: Mickaël Salaün <mic@digikod.net>
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/capability.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "helpers.h"
+#include "../kselftest_harness.h"
+
+#ifndef O_MAYEXEC
+#define O_MAYEXEC		040000000
+#endif
+
+static const char sysctl_path[] = "/proc/sys/fs/open_mayexec_enforce";
+
+static const char workdir_path[] = "./test-mount";
+static const char file_path[] = "./test-mount/file";
+static const char dir_path[] = "./test-mount/directory";
+
+static void ignore_dac(struct __test_metadata *_metadata, int override)
+{
+	cap_t caps;
+	const cap_value_t cap_val[2] = {
+		CAP_DAC_OVERRIDE,
+		CAP_DAC_READ_SEARCH,
+	};
+
+	caps = cap_get_proc();
+	ASSERT_NE(NULL, caps);
+	ASSERT_EQ(0, cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_val,
+				override ? CAP_SET : CAP_CLEAR));
+	ASSERT_EQ(0, cap_set_proc(caps));
+	EXPECT_EQ(0, cap_free(caps));
+}
+
+static void ignore_sys_admin(struct __test_metadata *_metadata, int override)
+{
+	cap_t caps;
+	const cap_value_t cap_val[1] = {
+		CAP_SYS_ADMIN,
+	};
+
+	caps = cap_get_proc();
+	ASSERT_NE(NULL, caps);
+	ASSERT_EQ(0, cap_set_flag(caps, CAP_EFFECTIVE, 1, cap_val,
+				override ? CAP_SET : CAP_CLEAR));
+	ASSERT_EQ(0, cap_set_proc(caps));
+	EXPECT_EQ(0, cap_free(caps));
+}
+
+static void test_omx(struct __test_metadata *_metadata,
+		const char *const path, const int err_code)
+{
+	struct open_how how = {
+		.flags = O_RDONLY | O_CLOEXEC,
+	};
+	int fd;
+
+	/* Opens without O_MAYEXEC. */
+	fd = sys_openat2(AT_FDCWD, path, &how);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+
+	how.flags |= O_MAYEXEC;
+
+	/* Checks that O_MAYEXEC is ignored with open(2). */
+	fd = open(path, how.flags);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+
+	/* Checks that O_MAYEXEC is ignored with openat(2). */
+	fd = openat(AT_FDCWD, path, how.flags);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+
+	/* Opens with O_MAYEXEC. */
+	fd = sys_openat2(AT_FDCWD, path, &how);
+	if (!err_code) {
+		ASSERT_LE(0, fd);
+		EXPECT_EQ(0, close(fd));
+	} else {
+		ASSERT_EQ(err_code, fd);
+	}
+}
+
+static void test_omx_dir_file(struct __test_metadata *_metadata, const int err_code)
+{
+	test_omx(_metadata, dir_path, -EISDIR);
+	test_omx(_metadata, file_path, err_code);
+}
+
+static void test_dir_file(struct __test_metadata *_metadata, const int err_code)
+{
+	/* Tests as root. */
+	ignore_dac(_metadata, 1);
+	test_omx_dir_file(_metadata, err_code);
+
+	/* Tests without bypass. */
+	ignore_dac(_metadata, 0);
+	test_omx_dir_file(_metadata, err_code);
+}
+
+static void sysctl_write_char(struct __test_metadata *_metadata, const char value)
+{
+	int fd;
+
+	fd = open(sysctl_path, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	ASSERT_EQ(1, write(fd, &value, 1));
+	EXPECT_EQ(0, close(fd));
+}
+
+static char sysctl_read_char(struct __test_metadata *_metadata)
+{
+	int fd;
+	char sysctl_value;
+
+	fd = open(sysctl_path, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	ASSERT_EQ(1, read(fd, &sysctl_value, 1));
+	EXPECT_EQ(0, close(fd));
+	return sysctl_value;
+}
+
+FIXTURE(omayexec) {
+	char initial_sysctl_value;
+};
+
+FIXTURE_VARIANT(omayexec) {
+	const bool mount_exec;
+	const bool file_exec;
+	const int sysctl_err_code[3];
+};
+
+FIXTURE_VARIANT_ADD(omayexec, mount_exec_file_exec) {
+	.mount_exec = true,
+	.file_exec = true,
+	.sysctl_err_code = {0, 0, 0},
+};
+
+FIXTURE_VARIANT_ADD(omayexec, mount_exec_file_noexec)
+{
+	.mount_exec = true,
+	.file_exec = false,
+	.sysctl_err_code = {0, -EACCES, -EACCES},
+};
+
+FIXTURE_VARIANT_ADD(omayexec, mount_noexec_file_exec)
+{
+	.mount_exec = false,
+	.file_exec = true,
+	.sysctl_err_code = {-EACCES, 0, -EACCES},
+};
+
+FIXTURE_VARIANT_ADD(omayexec, mount_noexec_file_noexec)
+{
+	.mount_exec = false,
+	.file_exec = false,
+	.sysctl_err_code = {-EACCES, -EACCES, -EACCES},
+};
+
+FIXTURE_SETUP(omayexec)
+{
+	int fd;
+
+	/*
+	 * Cleans previous workspace if any error previously happened (don't
+	 * check errors).
+	 */
+	umount(workdir_path);
+	rmdir(workdir_path);
+
+	/* Creates a clean mount point. */
+	ASSERT_EQ(0, mkdir(workdir_path, 00700));
+	ASSERT_EQ(0, mount("test", workdir_path, "tmpfs", MS_MGC_VAL |
+				(variant->mount_exec ? 0 : MS_NOEXEC),
+				"mode=0700,size=4k"));
+
+	/* Creates a test file. */
+	fd = open(file_path, O_CREAT | O_RDONLY | O_CLOEXEC,
+			variant->file_exec ? 00500 : 00400);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+
+	/* Creates a test directory. */
+	ASSERT_EQ(0, mkdir(dir_path, variant->file_exec ? 00500 : 00400));
+
+	/* Saves initial sysctl value. */
+	self->initial_sysctl_value = sysctl_read_char(_metadata);
+
+	/* Prepares for sysctl writes. */
+	ignore_sys_admin(_metadata, 1);
+}
+
+FIXTURE_TEARDOWN(omayexec)
+{
+	/* Restores initial sysctl value. */
+	sysctl_write_char(_metadata, self->initial_sysctl_value);
+
+	/* There is no need to unlink file_path nor dir_path. */
+	ASSERT_EQ(0, umount(workdir_path));
+	ASSERT_EQ(0, rmdir(workdir_path));
+}
+
+TEST_F(omayexec, sysctl_0)
+{
+	/* Do not enforce anything. */
+	sysctl_write_char(_metadata, '0');
+	test_dir_file(_metadata, 0);
+}
+
+TEST_F(omayexec, sysctl_1)
+{
+	/* Enforces mount exec check. */
+	sysctl_write_char(_metadata, '1');
+	test_dir_file(_metadata, variant->sysctl_err_code[0]);
+}
+
+TEST_F(omayexec, sysctl_2)
+{
+	/* Enforces file exec check. */
+	sysctl_write_char(_metadata, '2');
+	test_dir_file(_metadata, variant->sysctl_err_code[1]);
+}
+
+TEST_F(omayexec, sysctl_3)
+{
+	/* Enforces mount and file exec check. */
+	sysctl_write_char(_metadata, '3');
+	test_dir_file(_metadata, variant->sysctl_err_code[2]);
+}
+
+TEST(sysctl_access_write)
+{
+	int fd;
+	ssize_t ret;
+
+	ignore_sys_admin(_metadata, 1);
+	sysctl_write_char(_metadata, '0');
+
+	ignore_sys_admin(_metadata, 0);
+	fd = open(sysctl_path, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	ret = write(fd, "0", 1);
+	ASSERT_EQ(-1, ret);
+	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(0, close(fd));
+}
+
+TEST_HARNESS_MAIN
-- 
2.27.0


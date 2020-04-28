Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BAE1BC736
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgD1RwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 13:52:23 -0400
Received: from smtp-42aa.mail.infomaniak.ch ([84.16.66.170]:40195 "EHLO
        smtp-42aa.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728337AbgD1RwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:52:22 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49BTjd5tz7zlhJLg;
        Tue, 28 Apr 2020 19:51:49 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49BTjd35h5zmFgNv;
        Tue, 28 Apr 2020 19:51:49 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
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
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/5] selftest/openat2: Add tests for RESOLVE_MAYEXEC enforcing
Date:   Tue, 28 Apr 2020 19:51:28 +0200
Message-Id: <20200428175129.634352-5-mic@digikod.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428175129.634352-1-mic@digikod.net>
References: <20200428175129.634352-1-mic@digikod.net>
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
files open with or without RESOLVE_MAYEXEC.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
---

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
 tools/testing/selftests/openat2/helpers.h     |   3 +
 .../testing/selftests/openat2/omayexec_test.c | 315 ++++++++++++++++++
 5 files changed, 324 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/openat2/config
 create mode 100644 tools/testing/selftests/openat2/omayexec_test.c

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2bb8c81fc0b4..f6e056ba4a13 100644
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
index a6ea27344db2..2a46d5446110 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -9,6 +9,7 @@
 
 #define _GNU_SOURCE
 #include <stdint.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <linux/types.h>
 #include "../kselftest.h"
@@ -60,6 +61,8 @@ bool needs_openat2(const struct open_how *how);
 #define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
 					be scoped inside the dirfd
 					(similar to chroot(2)). */
+#define RESOLVE_MAYEXEC		0x20 /* Command execution from file is
+					intended, checks exec permissions. */
 #endif /* RESOLVE_IN_ROOT */
 
 #define E_func(func, ...)						\
diff --git a/tools/testing/selftests/openat2/omayexec_test.c b/tools/testing/selftests/openat2/omayexec_test.c
new file mode 100644
index 000000000000..5298cbd5b7e9
--- /dev/null
+++ b/tools/testing/selftests/openat2/omayexec_test.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test openat2(2) with RESOLVE_MAYEXEC
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
+#include <string.h>
+#include <sys/capability.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "helpers.h"
+#include "../kselftest_harness.h"
+
+#define SYSCTL_MAYEXEC	"/proc/sys/fs/open_mayexec_enforce"
+
+#define BIN_DIR		"./test-mount"
+#define BIN_PATH	BIN_DIR "/file"
+#define DIR_PATH	BIN_DIR "/directory"
+
+#define ALLOWED		1
+#define DENIED		0
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
+static void ignore_mac(struct __test_metadata *_metadata, int override)
+{
+	cap_t caps;
+	const cap_value_t cap_val[1] = {
+		CAP_MAC_ADMIN,
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
+		const char *const path, const int exec_allowed)
+{
+	struct open_how how = {
+		.flags = O_RDONLY | O_CLOEXEC,
+	};
+	int fd;
+
+	/* Opens without MAYEXEC. */
+	fd = sys_openat2(AT_FDCWD, path, &how);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+
+	/* Opens with MAYEXEC. */
+	how.resolve = RESOLVE_MAYEXEC;
+	fd = sys_openat2(AT_FDCWD, path, &how);
+	if (exec_allowed) {
+		ASSERT_LE(0, fd);
+		EXPECT_EQ(0, close(fd));
+	} else {
+		ASSERT_EQ(-EACCES, fd);
+	}
+}
+
+static void test_omx_dir_file(struct __test_metadata *_metadata,
+		const char *const dir_path, const char *const file_path,
+		const int exec_allowed)
+{
+	/*
+	 * Directory execution is always denied since commit 73601ea5b7b1
+	 * ("fs/open.c: allow opening only regular files during execve()").
+	 */
+	test_omx(_metadata, dir_path, DENIED);
+	test_omx(_metadata, file_path, exec_allowed);
+}
+
+static void test_dir_file(struct __test_metadata *_metadata,
+		const char *const dir_path, const char *const file_path,
+		const int exec_allowed)
+{
+	/* Tests as root. */
+	ignore_dac(_metadata, 1);
+	test_omx_dir_file(_metadata, dir_path, file_path, exec_allowed);
+
+	/* Tests without bypass. */
+	ignore_dac(_metadata, 0);
+	test_omx_dir_file(_metadata, dir_path, file_path, exec_allowed);
+}
+
+static void sysctl_write(struct __test_metadata *_metadata,
+		const char *path, const char *value)
+{
+	int fd;
+	size_t len_value;
+	ssize_t len_wrote;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	len_value = strlen(value);
+	len_wrote = write(fd, value, len_value);
+	ASSERT_EQ(len_wrote, len_value);
+	EXPECT_EQ(0, close(fd));
+}
+
+static void create_workspace(struct __test_metadata *_metadata,
+		int mount_exec, int file_exec)
+{
+	int fd;
+
+	/*
+	 * Cleans previous workspace if any error previously happened (don't
+	 * check errors).
+	 */
+	umount(BIN_DIR);
+	rmdir(BIN_DIR);
+
+	/* Creates a clean mount point. */
+	ASSERT_EQ(0, mkdir(BIN_DIR, 00700));
+	ASSERT_EQ(0, mount("test", BIN_DIR, "tmpfs",
+				MS_MGC_VAL | (mount_exec ? 0 : MS_NOEXEC),
+				"mode=0700,size=4k"));
+
+	/* Creates a test file. */
+	fd = open(BIN_PATH, O_CREAT | O_RDONLY | O_CLOEXEC,
+			file_exec ? 00500 : 00400);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, close(fd));
+
+	/* Creates a test directory. */
+	ASSERT_EQ(0, mkdir(DIR_PATH, file_exec ? 00500 : 00400));
+}
+
+static void delete_workspace(struct __test_metadata *_metadata)
+{
+	ignore_mac(_metadata, 1);
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "0");
+
+	/* There is no need to unlink BIN_PATH nor DIR_PATH. */
+	ASSERT_EQ(0, umount(BIN_DIR));
+	ASSERT_EQ(0, rmdir(BIN_DIR));
+}
+
+FIXTURE_DATA(mount_exec_file_exec) { };
+
+FIXTURE_SETUP(mount_exec_file_exec)
+{
+	create_workspace(_metadata, 1, 1);
+}
+
+FIXTURE_TEARDOWN(mount_exec_file_exec)
+{
+	delete_workspace(_metadata);
+}
+
+TEST_F(mount_exec_file_exec, mount)
+{
+	/* Enforces mount exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "1");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, ALLOWED);
+}
+
+TEST_F(mount_exec_file_exec, file)
+{
+	/* Enforces file exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "2");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, ALLOWED);
+}
+
+TEST_F(mount_exec_file_exec, mount_file)
+{
+	/* Enforces mount and file exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "3");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, ALLOWED);
+}
+
+FIXTURE_DATA(mount_exec_file_noexec) { };
+
+FIXTURE_SETUP(mount_exec_file_noexec)
+{
+	create_workspace(_metadata, 1, 0);
+}
+
+FIXTURE_TEARDOWN(mount_exec_file_noexec)
+{
+	delete_workspace(_metadata);
+}
+
+TEST_F(mount_exec_file_noexec, mount)
+{
+	/* Enforces mount exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "1");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, ALLOWED);
+}
+
+TEST_F(mount_exec_file_noexec, file)
+{
+	/* Enforces file exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "2");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+TEST_F(mount_exec_file_noexec, mount_file)
+{
+	/* Enforces mount and file exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "3");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+FIXTURE_DATA(mount_noexec_file_exec) { };
+
+FIXTURE_SETUP(mount_noexec_file_exec)
+{
+	create_workspace(_metadata, 0, 1);
+}
+
+FIXTURE_TEARDOWN(mount_noexec_file_exec)
+{
+	delete_workspace(_metadata);
+}
+
+TEST_F(mount_noexec_file_exec, mount)
+{
+	/* Enforces mount exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "1");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+TEST_F(mount_noexec_file_exec, file)
+{
+	/* Enforces file exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "2");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, ALLOWED);
+}
+
+TEST_F(mount_noexec_file_exec, mount_file)
+{
+	/* Enforces mount and file exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "3");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+FIXTURE_DATA(mount_noexec_file_noexec) { };
+
+FIXTURE_SETUP(mount_noexec_file_noexec)
+{
+	create_workspace(_metadata, 0, 0);
+}
+
+FIXTURE_TEARDOWN(mount_noexec_file_noexec)
+{
+	delete_workspace(_metadata);
+}
+
+TEST_F(mount_noexec_file_noexec, mount)
+{
+	/* Enforces mount exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "1");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+TEST_F(mount_noexec_file_noexec, file)
+{
+	/* Enforces file exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "2");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+TEST_F(mount_noexec_file_noexec, mount_file)
+{
+	/* Enforces mount and file exec check. */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "3");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+TEST(sysctl_access_write)
+{
+	int fd;
+	ssize_t len_wrote;
+
+	ignore_mac(_metadata, 1);
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "0");
+
+	ignore_mac(_metadata, 0);
+	fd = open(SYSCTL_MAYEXEC, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	len_wrote = write(fd, "0", 1);
+	ASSERT_EQ(len_wrote, -1);
+	EXPECT_EQ(0, close(fd));
+
+	ignore_mac(_metadata, 1);
+}
+
+TEST_HARNESS_MAIN
-- 
2.26.2


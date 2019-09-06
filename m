Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D5CABC6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 17:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405760AbfIFP06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 11:26:58 -0400
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:56639 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404175AbfIFP0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:26:38 -0400
Received: from smtp5.infomaniak.ch (smtp5.infomaniak.ch [83.166.132.18])
        by smtp-sh2.infomaniak.ch (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id x86FP8CG085979
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Sep 2019 17:25:08 +0200
Received: from localhost (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp5.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x86FP8Ai047682;
        Fri, 6 Sep 2019 17:25:08 +0200
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/5] selftest/exec: Add tests for O_MAYEXEC enforcing
Date:   Fri,  6 Sep 2019 17:24:54 +0200
Message-Id: <20190906152455.22757-5-mic@digikod.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190906152455.22757-1-mic@digikod.net>
References: <20190906152455.22757-1-mic@digikod.net>
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
files open with or without O_MAYEXEC.

Changes since v1:
* move tests from yama to exec
* fix _GNU_SOURCE in kselftest_harness.h
* add a new test sysctl_access_write to check if CAP_MAC_ADMIN is taken
  into account
* test directory execution which is always forbidden since commit
  73601ea5b7b1 ("fs/open.c: allow opening only regular files during
  execve()"), and also check that even the root user can not bypass file
  execution checks
* make sure delete_workspace() always as enough right to succeed
* cosmetic cleanup

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mickaël Salaün <mickael.salaun@ssi.gouv.fr>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/exec/.gitignore     |   1 +
 tools/testing/selftests/exec/Makefile       |   4 +-
 tools/testing/selftests/exec/omayexec.c     | 317 ++++++++++++++++++++
 tools/testing/selftests/kselftest_harness.h |   3 +
 4 files changed, 324 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/exec/omayexec.c

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index b02279da6fa1..78487c987c07 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -1,3 +1,4 @@
+/omayexec
 subdir*
 script*
 execveat
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 33339e31e365..a62b9ca306e7 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -3,7 +3,7 @@ CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
-TEST_GEN_PROGS := execveat
+TEST_GEN_PROGS := execveat omayexec
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
@@ -26,3 +26,5 @@ $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
 	cp $< $@
 	chmod -x $@
 
+$(OUTPUT)/omayexec: omayexec.c ../kselftest_harness.h
+	$(CC) $(CFLAGS) -Wl,-no-as-needed $(LDFLAGS) -lcap $< -o $@
diff --git a/tools/testing/selftests/exec/omayexec.c b/tools/testing/selftests/exec/omayexec.c
new file mode 100644
index 000000000000..e4307b5a5417
--- /dev/null
+++ b/tools/testing/selftests/exec/omayexec.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * O_MAYEXEC tests
+ *
+ * Copyright © 2018-2019 ANSSI
+ *
+ * Author: Mickaël Salaün <mic@digikod.net>
+ */
+
+#include <errno.h>
+#include <fcntl.h> /* O_CLOEXEC */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h> /* strlen */
+#include <sys/capability.h>
+#include <sys/mount.h>
+#include <sys/stat.h> /* mkdir */
+#include <unistd.h> /* unlink, rmdir */
+
+#include "../kselftest_harness.h"
+
+#ifndef O_MAYEXEC
+#define O_MAYEXEC      040000000
+#endif
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
+	ASSERT_TRUE(!!caps);
+	ASSERT_FALSE(cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_val,
+				override ? CAP_SET : CAP_CLEAR));
+	ASSERT_FALSE(cap_set_proc(caps));
+	EXPECT_FALSE(cap_free(caps));
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
+	ASSERT_TRUE(!!caps);
+	ASSERT_FALSE(cap_set_flag(caps, CAP_EFFECTIVE, 1, cap_val,
+				override ? CAP_SET : CAP_CLEAR));
+	ASSERT_FALSE(cap_set_proc(caps));
+	EXPECT_FALSE(cap_free(caps));
+}
+
+static void test_omx(struct __test_metadata *_metadata,
+		const char *const path, const int exec_allowed)
+{
+	int fd;
+
+	/* without O_MAYEXEC */
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	ASSERT_NE(-1, fd);
+	EXPECT_FALSE(close(fd));
+
+	/* with O_MAYEXEC */
+	fd = open(path, O_RDONLY | O_CLOEXEC | O_MAYEXEC);
+	if (exec_allowed) {
+		/* open should succeed */
+		ASSERT_NE(-1, fd);
+		EXPECT_FALSE(close(fd));
+	} else {
+		/* open should return EACCES */
+		ASSERT_EQ(-1, fd);
+		ASSERT_EQ(EACCES, errno);
+	}
+}
+
+static void test_omx_dir_file(struct __test_metadata *_metadata,
+		const char *const dir_path, const char *const file_path,
+		const int exec_allowed)
+{
+	/*
+	 * directory execution is always denied since commit 73601ea5b7b1
+	 * ("fs/open.c: allow opening only regular files during execve()")
+	 */
+	test_omx(_metadata, dir_path, DENIED);
+	test_omx(_metadata, file_path, exec_allowed);
+}
+
+static void test_dir_file(struct __test_metadata *_metadata,
+		const char *const dir_path, const char *const file_path,
+		const int exec_allowed)
+{
+	/* test as root */
+	ignore_dac(_metadata, 1);
+	test_omx_dir_file(_metadata, dir_path, file_path, exec_allowed);
+
+	/* test without bypass */
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
+	ASSERT_NE(-1, fd);
+	len_value = strlen(value);
+	len_wrote = write(fd, value, len_value);
+	ASSERT_EQ(len_wrote, len_value);
+	EXPECT_FALSE(close(fd));
+}
+
+static void create_workspace(struct __test_metadata *_metadata,
+		int mount_exec, int file_exec)
+{
+	int fd;
+
+	/*
+	 * Cleanup previous workspace if any error previously happened (don't
+	 * check errors).
+	 */
+	umount(BIN_DIR);
+	rmdir(BIN_DIR);
+
+	/* create a clean mount point */
+	ASSERT_FALSE(mkdir(BIN_DIR, 00700));
+	ASSERT_FALSE(mount("test", BIN_DIR, "tmpfs",
+				MS_MGC_VAL | (mount_exec ? 0 : MS_NOEXEC),
+				"mode=0700,size=4k"));
+
+	/* create a test file */
+	fd = open(BIN_PATH, O_CREAT | O_RDONLY | O_CLOEXEC,
+			file_exec ? 00500 : 00400);
+	ASSERT_NE(-1, fd);
+	EXPECT_NE(-1, close(fd));
+
+	/* create a test directory */
+	ASSERT_FALSE(mkdir(DIR_PATH, file_exec ? 00500 : 00400));
+}
+
+static void delete_workspace(struct __test_metadata *_metadata)
+{
+	ignore_mac(_metadata, 1);
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "0");
+
+	/* no need to unlink BIN_PATH nor DIR_PATH */
+	ASSERT_FALSE(umount(BIN_DIR));
+	ASSERT_FALSE(rmdir(BIN_DIR));
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
+	/* enforce mount exec check */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "1");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, ALLOWED);
+}
+
+TEST_F(mount_exec_file_exec, file)
+{
+	/* enforce file exec check */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "2");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, ALLOWED);
+}
+
+TEST_F(mount_exec_file_exec, mount_file)
+{
+	/* enforce mount and file exec check */
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
+	/* enforce mount exec check */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "1");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, ALLOWED);
+}
+
+TEST_F(mount_exec_file_noexec, file)
+{
+	/* enforce file exec check */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "2");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+TEST_F(mount_exec_file_noexec, mount_file)
+{
+	/* enforce mount and file exec check */
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
+	/* enforce mount exec check */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "1");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+TEST_F(mount_noexec_file_exec, file)
+{
+	/* enforce file exec check */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "2");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, ALLOWED);
+}
+
+TEST_F(mount_noexec_file_exec, mount_file)
+{
+	/* enforce mount and file exec check */
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
+	/* enforce mount exec check */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "1");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+TEST_F(mount_noexec_file_noexec, file)
+{
+	/* enforce file exec check */
+	sysctl_write(_metadata, SYSCTL_MAYEXEC, "2");
+	test_dir_file(_metadata, DIR_PATH, BIN_PATH, DENIED);
+}
+
+TEST_F(mount_noexec_file_noexec, mount_file)
+{
+	/* enforce mount and file exec check */
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
+	ASSERT_NE(-1, fd);
+	len_wrote = write(fd, "0", 1);
+	ASSERT_EQ(len_wrote, -1);
+	EXPECT_FALSE(close(fd));
+
+	ignore_mac(_metadata, 1);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5336b26506ab..6ae816fa2f62 100644
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
-- 
2.23.0


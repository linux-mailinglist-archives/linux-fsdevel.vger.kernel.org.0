Return-Path: <linux-fsdevel+bounces-40448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FBEA236DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFD73A1492
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0646E1F1524;
	Thu, 30 Jan 2025 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaHAZjAp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729A1F190A;
	Thu, 30 Jan 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738273001; cv=none; b=QV1KXxNmt3s6ofgThLlh2kdZu1zf96ht8f8byvxoIz/oeen+Vrx6Ok8Uxa//qBzE1lmqewHqK+/Mb7FbldV1jY8aVitnJ91Wcbglbe12RMsiI2qrFc2tYTKn0xyFmKOLd4oeIPhldwOwm5wgdHMf2o03ivUBf1AyX5IHzFTfkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738273001; c=relaxed/simple;
	bh=fuGYW/1zNIvvDw4pAzEC/dfR1GTOdiw8eWV8eiTYGLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKx+fdT9qfBpawNM2fTCxSpD5TnkAoKTPGu0nSzXkIGsyQaqfDgeOALUkx6khIYucPcvLKUXB3TfTTkIYXawJ5r5q+Hq6fiaAZdL24OnT39EbnJvD9RlHMQ/HRjj7sxu1ZjBElf1c6uI5FlWOfgWfHRKnhtlBWrqsWVhmovaWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaHAZjAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63595C4CED3;
	Thu, 30 Jan 2025 21:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738273001;
	bh=fuGYW/1zNIvvDw4pAzEC/dfR1GTOdiw8eWV8eiTYGLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WaHAZjApLLBWGQmZ870hDnGvANj0DU3tWSRh5DMJtjXd6XHOesBGOBcdyJFigBPAf
	 nxgLRX57gpece+bhWdKEMeoxZXwS5z9BhRwyR6egZFotYpeDZBUZd9MyzOHrhm0Map
	 hP4VRoGtqGoKeTUyGQ3fBwSrExPdwBXoaXQTRBxEs19i1OoTqUg6zP4EvrmniYiRxY
	 lEDawkV1yLvdNk7AoSDD2LHnehFQ/QvrSgMEfTCmZUi1AlHy6m8Sd7iDmV3RPu0DJP
	 oXMriDMLAAqnIMANtXWtyCB3M/8J5M25j0yi/AJ05DaU2vV1aMe/TQLZLgyGOptIGE
	 78c1Msgk9NunQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	liamwisehart@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v12 bpf-next 5/5] selftests/bpf: Test kfuncs that set and remove xattr from BPF programs
Date: Thu, 30 Jan 2025 13:35:49 -0800
Message-ID: <20250130213549.3353349-6-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250130213549.3353349-1-song@kernel.org>
References: <20250130213549.3353349-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two sets of tests are added to exercise the not _locked and _locked
version of the kfuncs. For both tests, user space accesses xattr
security.bpf.foo on a testfile. The BPF program is triggered by user
space access (on LSM hook inode_[set|get]_xattr) and sets or removes
xattr security.bpf.bar. Then user space then validates that xattr
security.bpf.bar is set or removed as expected.

Note that, in both tests, the BPF programs use the not _locked kfuncs.
The verifier picks the proper kfuncs based on the calling context.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 125 ++++++++++++++++
 .../bpf/progs/test_set_remove_xattr.c         | 133 ++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 2eb3483f2fb0..8215c9b3115e 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -87,4 +87,9 @@ struct dentry;
  */
 extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name,
 			      struct bpf_dynptr *value_ptr) __ksym __weak;
+
+extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
+				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
+extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 419f45b56472..43a26ec69a8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <test_progs.h>
 #include "test_get_xattr.skel.h"
+#include "test_set_remove_xattr.skel.h"
 #include "test_fsverity.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
@@ -72,6 +73,127 @@ static void test_get_xattr(const char *name, const char *value, bool allow_acces
 	remove(testfile);
 }
 
+/* xattr value we will set to security.bpf.foo */
+static const char value_foo[] = "hello";
+
+static void read_and_validate_foo(struct test_set_remove_xattr *skel)
+{
+	char value_out[32];
+	int err;
+
+	err = getxattr(testfile, skel->rodata->xattr_foo, value_out, sizeof(value_out));
+	ASSERT_EQ(err, sizeof(value_foo), "getxattr size foo");
+	ASSERT_EQ(strncmp(value_out, value_foo, sizeof(value_foo)), 0, "strncmp value_foo");
+}
+
+static void set_foo(struct test_set_remove_xattr *skel)
+{
+	ASSERT_OK(setxattr(testfile, skel->rodata->xattr_foo, value_foo, strlen(value_foo) + 1, 0),
+		  "setxattr foo");
+}
+
+static void validate_bar_match(struct test_set_remove_xattr *skel)
+{
+	char value_out[32];
+	int err;
+
+	err = getxattr(testfile, skel->rodata->xattr_bar, value_out, sizeof(value_out));
+	ASSERT_EQ(err, sizeof(skel->data->value_bar), "getxattr size bar");
+	ASSERT_EQ(strncmp(value_out, skel->data->value_bar, sizeof(skel->data->value_bar)), 0,
+		  "strncmp value_bar");
+}
+
+static void validate_bar_removed(struct test_set_remove_xattr *skel)
+{
+	char value_out[32];
+	int err;
+
+	err = getxattr(testfile, skel->rodata->xattr_bar, value_out, sizeof(value_out));
+	ASSERT_LT(err, 0, "getxattr size bar should fail");
+}
+
+static void test_set_remove_xattr(void)
+{
+	struct test_set_remove_xattr *skel = NULL;
+	int fd = -1, err;
+
+	fd = open(testfile, O_CREAT | O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		return;
+
+	close(fd);
+	fd = -1;
+
+	skel = test_set_remove_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_set_remove_xattr__open_and_load"))
+		return;
+
+	/* Set security.bpf.foo to "hello" */
+	err = setxattr(testfile, skel->rodata->xattr_foo, value_foo, strlen(value_foo) + 1, 0);
+	if (err && errno == EOPNOTSUPP) {
+		printf("%s:SKIP:local fs doesn't support xattr (%d)\n"
+		       "To run this test, make sure /tmp filesystem supports xattr.\n",
+		       __func__, errno);
+		test__skip();
+		goto out;
+	}
+
+	if (!ASSERT_OK(err, "setxattr"))
+		goto out;
+
+	skel->bss->monitored_pid = getpid();
+	err = test_set_remove_xattr__attach(skel);
+	if (!ASSERT_OK(err, "test_set_remove_xattr__attach"))
+		goto out;
+
+	/* First, test not _locked version of the kfuncs with getxattr. */
+
+	/* Read security.bpf.foo and trigger test_inode_getxattr. This
+	 * bpf program will set security.bpf.bar to "world".
+	 */
+	read_and_validate_foo(skel);
+	validate_bar_match(skel);
+
+	/* Read security.bpf.foo and trigger test_inode_getxattr again.
+	 * This will remove xattr security.bpf.bar.
+	 */
+	read_and_validate_foo(skel);
+	validate_bar_removed(skel);
+
+	ASSERT_TRUE(skel->bss->set_security_bpf_bar_success, "set_security_bpf_bar_success");
+	ASSERT_TRUE(skel->bss->remove_security_bpf_bar_success, "remove_security_bpf_bar_success");
+	ASSERT_TRUE(skel->bss->set_security_selinux_fail, "set_security_selinux_fail");
+	ASSERT_TRUE(skel->bss->remove_security_selinux_fail, "remove_security_selinux_fail");
+
+	/* Second, test _locked version of the kfuncs, with setxattr */
+
+	/* Set security.bpf.foo and trigger test_inode_setxattr. This
+	 * bpf program will set security.bpf.bar to "world".
+	 */
+	set_foo(skel);
+	validate_bar_match(skel);
+
+	/* Set security.bpf.foo and trigger test_inode_setxattr again.
+	 * This will remove xattr security.bpf.bar.
+	 */
+	set_foo(skel);
+	validate_bar_removed(skel);
+
+	ASSERT_TRUE(skel->bss->locked_set_security_bpf_bar_success,
+		    "locked_set_security_bpf_bar_success");
+	ASSERT_TRUE(skel->bss->locked_remove_security_bpf_bar_success,
+		    "locked_remove_security_bpf_bar_success");
+	ASSERT_TRUE(skel->bss->locked_set_security_selinux_fail,
+		    "locked_set_security_selinux_fail");
+	ASSERT_TRUE(skel->bss->locked_remove_security_selinux_fail,
+		    "locked_remove_security_selinux_fail");
+
+out:
+	close(fd);
+	test_set_remove_xattr__destroy(skel);
+	remove(testfile);
+}
+
 #ifndef SHA256_DIGEST_SIZE
 #define SHA256_DIGEST_SIZE      32
 #endif
@@ -161,6 +283,9 @@ void test_fs_kfuncs(void)
 	if (test__start_subtest("security_selinux_xattr_error"))
 		test_get_xattr("security.selinux", "hello", false);
 
+	if (test__start_subtest("set_remove_xattr"))
+		test_set_remove_xattr();
+
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c b/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
new file mode 100644
index 000000000000..6a612cf168d3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+
+const char xattr_foo[] = "security.bpf.foo";
+const char xattr_bar[] = "security.bpf.bar";
+static const char xattr_selinux[] = "security.selinux";
+char value_bar[] = "world";
+char read_value[32];
+
+bool set_security_bpf_bar_success;
+bool remove_security_bpf_bar_success;
+bool set_security_selinux_fail;
+bool remove_security_selinux_fail;
+
+char name_buf[32];
+
+static inline bool name_match_foo(const char *name)
+{
+	bpf_probe_read_kernel(name_buf, sizeof(name_buf), name);
+
+	return !bpf_strncmp(name_buf, sizeof(xattr_foo), xattr_foo);
+}
+
+/* Test bpf_set_dentry_xattr and bpf_remove_dentry_xattr */
+SEC("lsm.s/inode_getxattr")
+int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid;
+	int ret;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	/* Only do the following for security.bpf.foo */
+	if (!name_match_foo(name))
+		return 0;
+
+	bpf_dynptr_from_mem(read_value, sizeof(read_value), 0, &value_ptr);
+
+	/* read security.bpf.bar */
+	ret = bpf_get_dentry_xattr(dentry, xattr_bar, &value_ptr);
+
+	if (ret < 0) {
+		/* If security.bpf.bar doesn't exist, set it */
+		bpf_dynptr_from_mem(value_bar, sizeof(value_bar), 0, &value_ptr);
+
+		ret = bpf_set_dentry_xattr(dentry, xattr_bar, &value_ptr, 0);
+		if (!ret)
+			set_security_bpf_bar_success = true;
+		ret = bpf_set_dentry_xattr(dentry, xattr_selinux, &value_ptr, 0);
+		if (ret)
+			set_security_selinux_fail = true;
+	} else {
+		/* If security.bpf.bar exists, remove it */
+		ret = bpf_remove_dentry_xattr(dentry, xattr_bar);
+		if (!ret)
+			remove_security_bpf_bar_success = true;
+
+		ret = bpf_remove_dentry_xattr(dentry, xattr_selinux);
+		if (ret)
+			remove_security_selinux_fail = true;
+	}
+
+	return 0;
+}
+
+bool locked_set_security_bpf_bar_success;
+bool locked_remove_security_bpf_bar_success;
+bool locked_set_security_selinux_fail;
+bool locked_remove_security_selinux_fail;
+
+/* Test bpf_set_dentry_xattr_locked and bpf_remove_dentry_xattr_locked.
+ * It not necessary to differentiate the _locked version and the
+ * not-_locked version in the BPF program. The verifier will fix them up
+ * properly.
+ */
+SEC("lsm.s/inode_setxattr")
+int BPF_PROG(test_inode_setxattr, struct mnt_idmap *idmap,
+	     struct dentry *dentry, const char *name,
+	     const void *value, size_t size, int flags)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid;
+	int ret;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	/* Only do the following for security.bpf.foo */
+	if (!name_match_foo(name))
+		return 0;
+
+	bpf_dynptr_from_mem(read_value, sizeof(read_value), 0, &value_ptr);
+
+	/* read security.bpf.bar */
+	ret = bpf_get_dentry_xattr(dentry, xattr_bar, &value_ptr);
+
+	if (ret < 0) {
+		/* If security.bpf.bar doesn't exist, set it */
+		bpf_dynptr_from_mem(value_bar, sizeof(value_bar), 0, &value_ptr);
+
+		ret = bpf_set_dentry_xattr(dentry, xattr_bar, &value_ptr, 0);
+		if (!ret)
+			locked_set_security_bpf_bar_success = true;
+		ret = bpf_set_dentry_xattr(dentry, xattr_selinux, &value_ptr, 0);
+		if (ret)
+			locked_set_security_selinux_fail = true;
+	} else {
+		/* If security.bpf.bar exists, remove it */
+		ret = bpf_remove_dentry_xattr(dentry, xattr_bar);
+		if (!ret)
+			locked_remove_security_bpf_bar_success = true;
+
+		ret = bpf_remove_dentry_xattr(dentry, xattr_selinux);
+		if (ret)
+			locked_remove_security_selinux_fail = true;
+	}
+
+	return 0;
+}
-- 
2.43.5



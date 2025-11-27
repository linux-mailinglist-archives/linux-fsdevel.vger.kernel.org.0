Return-Path: <linux-fsdevel+bounces-69950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E81C8C7C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82B4C4E55DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA08226738D;
	Thu, 27 Nov 2025 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdfYHNaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389891DB551;
	Thu, 27 Nov 2025 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204660; cv=none; b=PJrCwfJYB+Y3XvCBPdqCEflF/LpvCy+p0BnfgE+y6NDc/amqm11lZ4Ay92DZz9Vm/+nzqQe0AWJ25md2oxBDQhRFMRUmpoOcs8njVGOQdXF2mAw68aVYLngtsc5tCMWmVKdOwzphR2Fl4d6DOfZUJe5MYh2tRjx5zJt7gJVLSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204660; c=relaxed/simple;
	bh=qoSQa1plkMFsI2f6c/GpGmV68F+RuDQPN2OoZpdusEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLtwNmrX3vVFPMel8SAaq4nlHAlLmiggrABACtqIaV6OG11R5JRi6t0gjc0iNXnG2Xa2vgiu6Bqc68hHxtLFcCa7cOYzs1jWuGURtnC9OEtiTuDOghqdkWPIDM8Gd6nmenlxA2KJKE3Ka1TDWy98Tw5NDP3lukHtaAgXRKOqfw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdfYHNaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7E5C4CEF7;
	Thu, 27 Nov 2025 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764204660;
	bh=qoSQa1plkMFsI2f6c/GpGmV68F+RuDQPN2OoZpdusEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdfYHNaM4hM0sN+qVi8Y9wSn4Z8yTg2CA2d/EJrOL7rNxf5vwDXHfBuPFPqnK9fBf
	 R3ylc/ZxBJmWTICzunKEB4TU6rWzexD2CCpEcySTORCX3xENxKTGcRRjatlL5izlGC
	 mc4emAo5hhOYbpfYctgNOi4klLL4HXoWmpckDYak4miAYl3rOqG8asn3EJpzhWW3JW
	 +HvBaqLEo83dZPdpbEWZAZKsWx2bc/V80jqn7jczMb7WZj3miqMbMwInC57aExRfL/
	 MQ/klD/wBdEoe0a2q+cKM50c5jNkT2MTmebCHkqEWB7G/BtwgVwcu7pT1x3Ad2v8Hv
	 SxmXP3n3T51aQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel-team@meta.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add tests for bpf_kern_path kfunc
Date: Wed, 26 Nov 2025 16:50:11 -0800
Message-ID: <20251127005011.1872209-8-song@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127005011.1872209-1-song@kernel.org>
References: <20251127005011.1872209-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive selftests for the new bpf_kern_path and bpf_path_put
kfuncs:

1. Functional tests (prog_tests/kern_path.c, progs/test_kern_path.c):
   - test_kern_path_basic: Tests successful path resolution using
     /proc/self/exe and validates the resolved path with bpf_path_d_path
   - test_kern_path_sb_mount: Tests bpf_kern_path with dynamic input
     from LSM hook parameter (dev_name from sb_mount), demonstrating
     real-world usage where BPF programs resolve paths from hook args

2. Verifier success tests (progs/verifier_kern_path.c):
   - kern_path_success: Proper acquire -> use -> release pattern
   - kern_path_multiple_paths: Multiple concurrent path acquisitions

3. Verifier failure tests (progs/verifier_kern_path_fail.c):
   - kern_path_unreleased: Resource leak detection
   - path_put_unacquired: Releasing unacquired path
   - path_use_after_put: Use-after-free detection
   - double_path_put: Double-free detection
   - kern_path_non_lsm: Program type restrictions (LSM only)
   - kern_path_non_const_str: reject none const string

These tests verify both the functionality of the kfuncs and that the
verifier properly enforces acquire/release semantics to prevent
resource leaks.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  4 +
 .../selftests/bpf/prog_tests/kern_path.c      | 82 ++++++++++++++++
 .../selftests/bpf/progs/test_kern_path.c      | 56 +++++++++++
 .../selftests/bpf/progs/verifier_kern_path.c  | 52 ++++++++++
 .../bpf/progs/verifier_kern_path_fail.c       | 97 +++++++++++++++++++
 5 files changed, 291 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kern_path.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kern_path.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kern_path.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kern_path_fail.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2cd9165c7348..c512c9a14752 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -221,6 +221,10 @@ extern void bpf_put_file(struct file *file) __ksym;
  */
 extern int bpf_path_d_path(const struct path *path, char *buf, size_t buf__sz) __ksym;
 
+extern struct path *bpf_kern_path(const char *pathname, unsigned int flags) __ksym;
+extern void bpf_path_put(struct path *path) __ksym;
+extern int bpf_path_d_path(const struct path *path, char *buf, size_t buf__sz) __ksym;
+
 /* This macro must be used to mark the exception callback corresponding to the
  * main program. For example:
  *
diff --git a/tools/testing/selftests/bpf/prog_tests/kern_path.c b/tools/testing/selftests/bpf/prog_tests/kern_path.c
new file mode 100644
index 000000000000..f4cdfe202a26
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kern_path.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. */
+
+#include <test_progs.h>
+#include <sys/mount.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "test_kern_path.skel.h"
+#include "verifier_kern_path.skel.h"
+#include "verifier_kern_path_fail.skel.h"
+
+static void __test_kern_path(void (*trigger)(void))
+{
+	struct test_kern_path *skel;
+	int err;
+
+	skel = test_kern_path__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_kern_path__open_and_load"))
+		return;
+
+	skel->bss->monitored_pid = getpid();
+
+	err = test_kern_path__attach(skel);
+	if (!ASSERT_OK(err, "test_kern_path__attach"))
+		goto cleanup;
+
+	trigger();
+
+	/* Verify the bpf_path_d_path worked */
+	ASSERT_GT(skel->bss->path_len, 0, "path_len > 0");
+
+cleanup:
+	test_kern_path__destroy(skel);
+}
+
+static void trigger_file_open(void)
+{
+	int fd;
+
+	fd = open("/dev/null", O_RDONLY);
+	if (!ASSERT_OK_FD(fd, "open /dev/null"))
+		return;
+	close(fd);
+}
+
+static void trigger_sb_mount(void)
+{
+	char tmpdir[] = "/tmp/bpf_kern_path_test_XXXXXX";
+	int err;
+
+	if (!ASSERT_OK_PTR(mkdtemp(tmpdir), "mkdtemp"))
+		return;
+
+	err = mount("/tmp", tmpdir, NULL, MS_BIND, NULL);
+	if (!ASSERT_OK(err, "bind mount"))
+		goto rmdir;
+
+	umount(tmpdir);
+rmdir:
+	rmdir(tmpdir);
+}
+
+void test_kern_path(void)
+{
+	if (test__start_subtest("file_open"))
+		__test_kern_path(trigger_file_open);
+
+	if (test__start_subtest("sb_mount"))
+		__test_kern_path(trigger_sb_mount);
+}
+
+void test_verifier_kern_path(void)
+{
+	RUN_TESTS(verifier_kern_path);
+}
+
+void test_verifier_kern_path_fail(void)
+{
+	RUN_TESTS(verifier_kern_path_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kern_path.c b/tools/testing/selftests/bpf/progs/test_kern_path.c
new file mode 100644
index 000000000000..e9186a1aa990
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_kern_path.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#define MAX_PATH_LEN 256
+
+char buf[MAX_PATH_LEN];
+int path_len = 0;
+u32 monitored_pid = 0;
+
+SEC("lsm.s/file_open")
+int BPF_PROG(test_kern_path_basic, struct file *file)
+{
+	struct path *p;
+	int ret;
+
+	if (bpf_get_current_pid_tgid() >> 32 != monitored_pid)
+		return 0;
+
+	p = bpf_kern_path("/proc/self/exe", 0);
+	if (p) {
+		ret = bpf_path_d_path(p, buf, MAX_PATH_LEN);
+		if (ret > 0)
+			path_len = ret;
+		bpf_path_put(p);
+	}
+
+	return 0;
+}
+
+SEC("lsm.s/sb_mount")
+int BPF_PROG(test_kern_path_from_sb_mount, const char *dev_name, const struct path *path,
+	     const char *type, unsigned long flags, void *data)
+{
+	struct path *p;
+	int ret;
+
+	if (bpf_get_current_pid_tgid() >> 32 != monitored_pid)
+		return 0;
+
+	p = bpf_kern_path(dev_name, 0);
+	if (p) {
+		ret = bpf_path_d_path(p, buf, MAX_PATH_LEN);
+		if (ret > 0)
+			path_len = ret;
+		bpf_path_put(p);
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_kern_path.c b/tools/testing/selftests/bpf/progs/verifier_kern_path.c
new file mode 100644
index 000000000000..0e6ccf640b64
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kern_path.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <linux/limits.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+static char buf[PATH_MAX];
+
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(kern_path_success)
+{
+	struct path *p;
+
+	p = bpf_kern_path("/proc/self/exe", 0);
+	if (!p)
+		return 0;
+
+	bpf_path_d_path(p, buf, sizeof(buf));
+
+	bpf_path_put(p);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(kern_path_multiple_paths)
+{
+	struct path *p1, *p2;
+
+	p1 = bpf_kern_path("/proc/self/exe", 0);
+	if (!p1)
+		return 0;
+
+	p2 = bpf_kern_path("/proc/self/cwd", 0);
+	if (!p2) {
+		bpf_path_put(p1);
+		return 0;
+	}
+
+	bpf_path_d_path(p1, buf, sizeof(buf));
+	bpf_path_d_path(p2, buf, sizeof(buf));
+
+	bpf_path_put(p2);
+	bpf_path_put(p1);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_kern_path_fail.c b/tools/testing/selftests/bpf/progs/verifier_kern_path_fail.c
new file mode 100644
index 000000000000..520c227af5ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kern_path_fail.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <linux/limits.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+static char buf[PATH_MAX];
+
+SEC("lsm.s/file_open")
+__failure __msg("Unreleased reference")
+int BPF_PROG(kern_path_unreleased)
+{
+	struct path *p;
+
+	p = bpf_kern_path("/proc/self/exe", 0);
+	if (!p)
+		return 0;
+
+	/* Acquired but never released - should fail verification */
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("pointer type STRUCT path must point to scalar, or struct with scalar")
+int BPF_PROG(path_put_unacquired)
+{
+	struct path p = {};
+
+	/* Can't release an unacquired path - should fail verification */
+	bpf_path_put(&p);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("pointer type STRUCT path must point to scalar, or struct with scalar")
+int BPF_PROG(path_use_after_put, struct file *file)
+{
+	struct path *p;
+
+	p = bpf_kern_path("/proc/self/exe", 0);
+	if (!p)
+		return 0;
+
+	bpf_path_put(p);
+
+	/* Using path after put - should fail verification */
+	bpf_path_d_path(p, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("pointer type STRUCT path must point to scalar, or struct with scalar")
+int BPF_PROG(double_path_put)
+{
+	struct path *p;
+
+	p = bpf_kern_path("/proc/self/exe", 0);
+	if (!p)
+		return 0;
+
+	bpf_path_put(p);
+	/* Double put - should fail verification */
+	bpf_path_put(p);
+	return 0;
+}
+
+SEC("fentry/vfs_open")
+__failure __msg("calling kernel function bpf_kern_path is not allowed")
+int BPF_PROG(kern_path_non_lsm)
+{
+	struct path *p;
+
+	/* Calling bpf_kern_path() from a non-LSM BPF program isn't permitted */
+	p = bpf_kern_path("/proc/self/exe", 0);
+	if (p)
+		bpf_path_put(p);
+	return 0;
+}
+
+SEC("lsm.s/sb_eat_lsm_opts")
+__failure __msg("arg#0 doesn't point to a const string")
+int BPF_PROG(kern_path_non_const_str, char *options, void **mnt_opts)
+{
+	struct path *p;
+
+	/* Calling bpf_kern_path() from a with non-const string isn't permitted */
+	p = bpf_kern_path(options, 0);
+	if (p)
+		bpf_path_put(p);
+	return 0;
+}
+
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-8668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336DD839F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A30E1C219F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CDC1862A;
	Wed, 24 Jan 2024 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WokHPKK+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE9182DB;
	Wed, 24 Jan 2024 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063001; cv=none; b=mCS3U6VPY3neSTRk9eRApryrb4GIpOfYMoytZHUKO3qrn4ZRUhSYAJhIUm0ev6c/BiE8seusPGVWZ/aaGKPWhpIe59F702lMJBeYSMf5JP160F33GBqOHbdMaQFwjRiC4Y/K1xmdQWgNfIiYxQUMV4ivm8qG5fKgaz4ZbQKmq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063001; c=relaxed/simple;
	bh=muJIGdBADXvaupNzMGpqn19IiVMmSzPN8MTdcttLlUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdwRQtFVRhp+ZusvW84ka+cNyUP62UjkHCyAChZfQIc+zIgHWOkA/aR2W1Jh6r+9+uEYSPCPzEUs+2xGIbTKbXauVS4zCCQFtT8cQ21rOy/RqW64wtnkRAu1cgW7WANRwSxzCQGN9U8LEjLVAVAkUF4o2YaK9hZzUBjNc85xhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WokHPKK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32B7C433F1;
	Wed, 24 Jan 2024 02:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706063001;
	bh=muJIGdBADXvaupNzMGpqn19IiVMmSzPN8MTdcttLlUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WokHPKK+ybTsgyNGxCSnHzQGoeuUa7kKCXc2yqwhXXpws6WUgbJKMFkb5gMkSF5Fr
	 YnuVR3bVq3ebwOKR2Y3vQUUC0KcZWsBKVCettek8Ann6icAF1/wVspZ1HVmcTEjTgX
	 Cym0R5/8qG2UUuBKzRxJDOs86yXo8Bq1LUYI0g7cat4Y++9/jTkVJiaM5+yqV3WezI
	 MXmnA+30+GB5oSoeGOgsKuqGJpVBY7L7YnHha8lwHcRytud+C/xcZ213B7a8HNY6QC
	 gpC3COcidHr+gpwLIUnPFryG/wGMBrFJJW7Dev5R3YK+FNewtZSfcq9YW4r+U6MgAO
	 M6+mpPagBKvDg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 30/30] selftests/bpf: incorporate LSM policy to token-based tests
Date: Tue, 23 Jan 2024 18:21:27 -0800
Message-Id: <20240124022127.2379740-31-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
References: <20240124022127.2379740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for LSM interactions (both bpf_token_capable and bpf_token_cmd
LSM hooks) with BPF token in bpf() subsystem. Now child process passes
back token FD for parent to be able to do tests with token originating
in "wrong" userns. But we also create token in initns and check that
token LSMs don't accidentally reject BPF operations when capable()
checks pass without BPF token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 89 +++++++++++++++----
 tools/testing/selftests/bpf/progs/token_lsm.c | 32 +++++++
 2 files changed, 104 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/token_lsm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index 1f6aa685e6f7..fc4a175d8d76 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -18,6 +18,7 @@
 #include "priv_map.skel.h"
 #include "priv_prog.skel.h"
 #include "dummy_st_ops_success.skel.h"
+#include "token_lsm.skel.h"
 
 static inline int sys_mount(const char *dev_name, const char *dir_name,
 			    const char *type, unsigned long flags,
@@ -279,12 +280,23 @@ static int create_and_enter_userns(void)
 	return 0;
 }
 
-typedef int (*child_callback_fn)(int);
+typedef int (*child_callback_fn)(int bpffs_fd, struct token_lsm *lsm_skel);
 
 static void child(int sock_fd, struct bpffs_opts *opts, child_callback_fn callback)
 {
-	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
-	int mnt_fd = -1, fs_fd = -1, err = 0, bpffs_fd = -1;
+	int mnt_fd = -1, fs_fd = -1, err = 0, bpffs_fd = -1, token_fd = -1;
+	struct token_lsm *lsm_skel = NULL;
+
+	/* load and attach LSM "policy" before we go into unpriv userns */
+	lsm_skel = token_lsm__open_and_load();
+	if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel_load")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+	lsm_skel->bss->my_pid = getpid();
+	err = token_lsm__attach(lsm_skel);
+	if (!ASSERT_OK(err, "lsm_skel_attach"))
+		goto cleanup;
 
 	/* setup userns with root mappings */
 	err = create_and_enter_userns();
@@ -365,8 +377,19 @@ static void child(int sock_fd, struct bpffs_opts *opts, child_callback_fn callba
 		goto cleanup;
 	}
 
+	/* create BPF token FD and pass it to parent for some extra checks */
+	token_fd = bpf_token_create(bpffs_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "child_token_create")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+	err = sendfd(sock_fd, token_fd);
+	if (!ASSERT_OK(err, "send_token_fd"))
+		goto cleanup;
+	zclose(token_fd);
+
 	/* do custom test logic with customly set up BPF FS instance */
-	err = callback(bpffs_fd);
+	err = callback(bpffs_fd, lsm_skel);
 	if (!ASSERT_OK(err, "test_callback"))
 		goto cleanup;
 
@@ -376,6 +399,10 @@ static void child(int sock_fd, struct bpffs_opts *opts, child_callback_fn callba
 	zclose(mnt_fd);
 	zclose(fs_fd);
 	zclose(bpffs_fd);
+	zclose(token_fd);
+
+	lsm_skel->bss->my_pid = 0;
+	token_lsm__destroy(lsm_skel);
 
 	exit(-err);
 }
@@ -401,7 +428,7 @@ static int wait_for_pid(pid_t pid)
 
 static void parent(int child_pid, struct bpffs_opts *bpffs_opts, int sock_fd)
 {
-	int fs_fd = -1, mnt_fd = -1, err;
+	int fs_fd = -1, mnt_fd = -1, token_fd = -1, err;
 
 	err = recvfd(sock_fd, &fs_fd);
 	if (!ASSERT_OK(err, "recv_bpffs_fd"))
@@ -420,6 +447,11 @@ static void parent(int child_pid, struct bpffs_opts *bpffs_opts, int sock_fd)
 		goto cleanup;
 	zclose(mnt_fd);
 
+	/* receive BPF token FD back from child for some extra tests */
+	err = recvfd(sock_fd, &token_fd);
+	if (!ASSERT_OK(err, "recv_token_fd"))
+		goto cleanup;
+
 	err = wait_for_pid(child_pid);
 	ASSERT_OK(err, "waitpid_child");
 
@@ -427,12 +459,14 @@ static void parent(int child_pid, struct bpffs_opts *bpffs_opts, int sock_fd)
 	zclose(sock_fd);
 	zclose(fs_fd);
 	zclose(mnt_fd);
+	zclose(token_fd);
 
 	if (child_pid > 0)
 		(void)kill(child_pid, SIGKILL);
 }
 
-static void subtest_userns(struct bpffs_opts *bpffs_opts, child_callback_fn cb)
+static void subtest_userns(struct bpffs_opts *bpffs_opts,
+			   child_callback_fn child_cb)
 {
 	int sock_fds[2] = { -1, -1 };
 	int child_pid = 0, err;
@@ -447,7 +481,7 @@ static void subtest_userns(struct bpffs_opts *bpffs_opts, child_callback_fn cb)
 
 	if (child_pid == 0) {
 		zclose(sock_fds[0]);
-		return child(sock_fds[1], bpffs_opts, cb);
+		return child(sock_fds[1], bpffs_opts, child_cb);
 
 	} else {
 		zclose(sock_fds[1]);
@@ -461,7 +495,7 @@ static void subtest_userns(struct bpffs_opts *bpffs_opts, child_callback_fn cb)
 		(void)kill(child_pid, SIGKILL);
 }
 
-static int userns_map_create(int mnt_fd)
+static int userns_map_create(int mnt_fd, struct token_lsm *lsm_skel)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
 	int err, token_fd = -1, map_fd = -1;
@@ -529,7 +563,7 @@ static int userns_map_create(int mnt_fd)
 	return err;
 }
 
-static int userns_btf_load(int mnt_fd)
+static int userns_btf_load(int mnt_fd, struct token_lsm *lsm_skel)
 {
 	LIBBPF_OPTS(bpf_btf_load_opts, btf_opts);
 	int err, token_fd = -1, btf_fd = -1;
@@ -598,7 +632,7 @@ static int userns_btf_load(int mnt_fd)
 	return err;
 }
 
-static int userns_prog_load(int mnt_fd)
+static int userns_prog_load(int mnt_fd, struct token_lsm *lsm_skel)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
 	int err, token_fd = -1, prog_fd = -1;
@@ -677,7 +711,7 @@ static int userns_prog_load(int mnt_fd)
 	return err;
 }
 
-static int userns_obj_priv_map(int mnt_fd)
+static int userns_obj_priv_map(int mnt_fd, struct token_lsm *lsm_skel)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	char buf[256];
@@ -705,7 +739,7 @@ static int userns_obj_priv_map(int mnt_fd)
 	return 0;
 }
 
-static int userns_obj_priv_prog(int mnt_fd)
+static int userns_obj_priv_prog(int mnt_fd, struct token_lsm *lsm_skel)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	char buf[256];
@@ -724,12 +758,33 @@ static int userns_obj_priv_prog(int mnt_fd)
 	skel = priv_prog__open_opts(&opts);
 	if (!ASSERT_OK_PTR(skel, "obj_token_path_open"))
 		return -EINVAL;
-
 	err = priv_prog__load(skel);
 	priv_prog__destroy(skel);
 	if (!ASSERT_OK(err, "obj_token_path_load"))
 		return -EINVAL;
 
+	/* provide BPF token, but reject bpf_token_capable() with LSM */
+	lsm_skel->bss->reject_capable = true;
+	lsm_skel->bss->reject_cmd = false;
+	skel = priv_prog__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_token_lsm_reject_cap_open"))
+		return -EINVAL;
+	err = priv_prog__load(skel);
+	priv_prog__destroy(skel);
+	if (!ASSERT_ERR(err, "obj_token_lsm_reject_cap_load"))
+		return -EINVAL;
+
+	/* provide BPF token, but reject bpf_token_cmd() with LSM */
+	lsm_skel->bss->reject_capable = false;
+	lsm_skel->bss->reject_cmd = true;
+	skel = priv_prog__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_token_lsm_reject_cmd_open"))
+		return -EINVAL;
+	err = priv_prog__load(skel);
+	priv_prog__destroy(skel);
+	if (!ASSERT_ERR(err, "obj_token_lsm_reject_cmd_load"))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -763,12 +818,12 @@ static int validate_struct_ops_load(int mnt_fd, bool expect_success)
 	return 0;
 }
 
-static int userns_obj_priv_btf_fail(int mnt_fd)
+static int userns_obj_priv_btf_fail(int mnt_fd, struct token_lsm *lsm_skel)
 {
 	return validate_struct_ops_load(mnt_fd, false /* should fail */);
 }
 
-static int userns_obj_priv_btf_success(int mnt_fd)
+static int userns_obj_priv_btf_success(int mnt_fd, struct token_lsm *lsm_skel)
 {
 	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
 }
@@ -776,7 +831,7 @@ static int userns_obj_priv_btf_success(int mnt_fd)
 #define TOKEN_ENVVAR "LIBBPF_BPF_TOKEN_PATH"
 #define TOKEN_BPFFS_CUSTOM "/bpf-token-fs"
 
-static int userns_obj_priv_implicit_token(int mnt_fd)
+static int userns_obj_priv_implicit_token(int mnt_fd, struct token_lsm *lsm_skel)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct dummy_st_ops_success *skel;
@@ -835,7 +890,7 @@ static int userns_obj_priv_implicit_token(int mnt_fd)
 	return 0;
 }
 
-static int userns_obj_priv_implicit_token_envvar(int mnt_fd)
+static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *lsm_skel)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct dummy_st_ops_success *skel;
diff --git a/tools/testing/selftests/bpf/progs/token_lsm.c b/tools/testing/selftests/bpf/progs/token_lsm.c
new file mode 100644
index 000000000000..e4d59b6ba743
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/token_lsm.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int my_pid;
+bool reject_capable;
+bool reject_cmd;
+
+SEC("lsm/bpf_token_capable")
+int BPF_PROG(token_capable, struct bpf_token *token, int cap)
+{
+	if (my_pid == 0 || my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+	if (reject_capable)
+		return -1;
+	return 0;
+}
+
+SEC("lsm/bpf_token_cmd")
+int BPF_PROG(token_cmd, struct bpf_token *token, enum bpf_cmd cmd)
+{
+	if (my_pid == 0 || my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+	if (reject_cmd)
+		return -1;
+	return 0;
+}
-- 
2.34.1



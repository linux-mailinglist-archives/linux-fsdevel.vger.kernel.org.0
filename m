Return-Path: <linux-fsdevel+bounces-52140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126A7ADF9D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 01:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8368A3BCE7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 23:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BBC2F4A16;
	Wed, 18 Jun 2025 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK+gCY65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CEC29B221;
	Wed, 18 Jun 2025 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750289892; cv=none; b=s88uSA9sbPmOUV/UNKx0sZnK0Xmuq+u74MV9ezwWoXip/04ZkaTx1UvfdysVCgvnI4YJvQ6CbxplW02gvjM9tEQDx44RhpL8ITuY4tATVUxU+KRuyY5WYpwEAcjoZPZTzRQowKeH1thnt0i743dDwiOOa360mexi5z/AB0pxTuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750289892; c=relaxed/simple;
	bh=XUqG1vdMsgMYI/VRCB/BmmdtBIx3k72lJdL4ZezPJyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ck+Bch7lxJN7srRmOjssaDP39jNjydIqKibYhgzEpcqwr4HtgFCN9YyzDUw83h6JEd3MJaMFenDZlbXhVQMS6WAzadg/JHiTLxUXgnoWpudX5UTBgvkiIKIHg/aKXJg/WPzQrPoEo7yyOZ6UvLgp/SqNHz6lsX999Oy4xJ8LwXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK+gCY65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AF4C4CEE7;
	Wed, 18 Jun 2025 23:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750289891;
	bh=XUqG1vdMsgMYI/VRCB/BmmdtBIx3k72lJdL4ZezPJyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZK+gCY65lV5Wcvx3fgQsrFNipIOQHaFb6xxqf9MaYhVICC0mnbUETyNCX4D2hkzz4
	 LPSHAlHgaGFjvMZbo/K0Yx08Al9YEdNTRe2pFPPz/1qwv2PXv0cBl+9ikmR1cKnfM8
	 xOpNv92Peb0EwJYfzdyBUcdw5n6mztV3BGVpVHJvGIpePuwEk41amGzR+OTx7WPbXo
	 QkcK0susK2ZXcKuKqXc9BPFhgmSedXnQ/jzh3JWw0VTcXgse5QOVH24dNX4kZMfNeU
	 MWocEkdeYORK361MlgCkygSrafU/EYSS9laznCk9Y8qMptDLv3vVfBH2CmREHFlEjP
	 aWuy7fAYmkgKg==
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
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	daan.j.demeyer@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add tests for bpf_kernfs_read_xattr
Date: Wed, 18 Jun 2025 16:37:39 -0700
Message-ID: <20250618233739.189106-5-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618233739.189106-1-song@kernel.org>
References: <20250618233739.189106-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for different scenarios with bpf_kernfs_read_xattr:
1. Read cgroup xattr from bpf_cgroup_from_id;
2. Read cgroup xattr from bpf_cgroup_ancestor;
3. Read cgroup xattr from css_iter;
4. Verifier reject using bpf_kernfs_read_xattr in sleepable contexts.
5. Use bpf_kernfs_read_xattr in LSM hook security_socket_connect.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/prog_tests/kernfs_xattr.c   | 145 ++++++++++++++++++
 .../selftests/bpf/progs/kernfs_read_xattr.c   | 117 ++++++++++++++
 .../selftests/bpf/progs/read_cgroupfs_xattr.c |  60 ++++++++
 3 files changed, 322 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kernfs_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/kernfs_read_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kernfs_xattr.c b/tools/testing/selftests/bpf/prog_tests/kernfs_xattr.c
new file mode 100644
index 000000000000..b60ccfdc4c4d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kernfs_xattr.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/xattr.h>
+
+#include <test_progs.h>
+
+#include "read_cgroupfs_xattr.skel.h"
+#include "kernfs_read_xattr.skel.h"
+
+#define CGROUP_FS_ROOT "/sys/fs/cgroup/"
+#define CGROUP_FS_PARENT CGROUP_FS_ROOT "foo/"
+#define CGROUP_FS_CHILD CGROUP_FS_PARENT "bar/"
+
+static int move_pid_to_cgroup(const char *cgroup_folder, pid_t pid)
+{
+	char filename[128];
+	char pid_str[64];
+	int procs_fd;
+	int ret;
+
+	snprintf(filename, sizeof(filename), "%scgroup.procs", cgroup_folder);
+	snprintf(pid_str, sizeof(pid_str), "%d", pid);
+
+	procs_fd = open(filename, O_WRONLY | O_APPEND);
+	if (!ASSERT_OK_FD(procs_fd, "open"))
+		return -1;
+
+	ret = write(procs_fd, pid_str, strlen(pid_str));
+	close(procs_fd);
+	if (!ASSERT_GT(ret, 0, "write cgroup.procs"))
+		return -1;
+	return 0;
+}
+
+static void reset_cgroups_and_lo(void)
+{
+	rmdir(CGROUP_FS_CHILD);
+	rmdir(CGROUP_FS_PARENT);
+	system("ip addr del 1.1.1.1/32 dev lo");
+	system("ip link set dev lo down");
+}
+
+static const char xattr_value_a[] = "bpf_selftest_value_a";
+static const char xattr_value_b[] = "bpf_selftest_value_b";
+static const char xattr_name[] = "user.bpf_test";
+
+static int setup_cgroups_and_lo(void)
+{
+	int err;
+
+	err = mkdir(CGROUP_FS_PARENT, 0755);
+	if (!ASSERT_OK(err, "mkdir 1"))
+		goto error;
+	err = mkdir(CGROUP_FS_CHILD, 0755);
+	if (!ASSERT_OK(err, "mkdir 2"))
+		goto error;
+
+	err = setxattr(CGROUP_FS_PARENT, xattr_name, xattr_value_a,
+		       strlen(xattr_value_a) + 1, 0);
+	if (!ASSERT_OK(err, "setxattr 1"))
+		goto error;
+
+	err = setxattr(CGROUP_FS_CHILD, xattr_name, xattr_value_b,
+		       strlen(xattr_value_b) + 1, 0);
+	if (!ASSERT_OK(err, "setxattr 2"))
+		goto error;
+
+	err = system("ip link set dev lo up");
+	if (!ASSERT_OK(err, "lo up"))
+		goto error;
+
+	err = system("ip addr add 1.1.1.1 dev lo");
+	if (!ASSERT_OK(err, "lo addr v4"))
+		goto error;
+
+	err = write_sysctl("/proc/sys/net/ipv4/ping_group_range", "0 0");
+	if (!ASSERT_OK(err, "write_sysctl"))
+		goto error;
+
+	return 0;
+error:
+	reset_cgroups_and_lo();
+	return err;
+}
+
+static void test_read_cgroup_xattr(void)
+{
+	struct sockaddr_in sa4 = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	struct read_cgroupfs_xattr *skel = NULL;
+	pid_t pid = gettid();
+	int sock_fd = -1;
+	int connect_fd = -1;
+
+	if (!ASSERT_OK(setup_cgroups_and_lo(), "setup_cgroups_and_lo"))
+		return;
+	if (!ASSERT_OK(move_pid_to_cgroup(CGROUP_FS_CHILD, pid),
+		       "move_pid_to_cgroup"))
+		goto out;
+
+	skel = read_cgroupfs_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "read_cgroupfs_xattr__open_and_load"))
+		goto out;
+
+	skel->bss->target_pid = pid;
+
+	if (!ASSERT_OK(read_cgroupfs_xattr__attach(skel), "read_cgroupfs_xattr__attach"))
+		goto out;
+
+	sock_fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
+	if (!ASSERT_OK_FD(sock_fd, "sock create"))
+		goto out;
+
+	connect_fd = connect(sock_fd, &sa4, sizeof(sa4));
+	if (!ASSERT_OK_FD(connect_fd, "connect 1"))
+		goto out;
+	close(connect_fd);
+
+	ASSERT_TRUE(skel->bss->found_value_a, "found_value_a");
+	ASSERT_TRUE(skel->bss->found_value_b, "found_value_b");
+
+out:
+	close(connect_fd);
+	close(sock_fd);
+	read_cgroupfs_xattr__destroy(skel);
+	move_pid_to_cgroup(CGROUP_FS_ROOT, pid);
+	reset_cgroups_and_lo();
+}
+
+void test_kernfs_xattr(void)
+{
+	RUN_TESTS(kernfs_read_xattr);
+
+	if (test__start_subtest("read_cgroupfs_xattr"))
+		test_read_cgroup_xattr();
+}
diff --git a/tools/testing/selftests/bpf/progs/kernfs_read_xattr.c b/tools/testing/selftests/bpf/progs/kernfs_read_xattr.c
new file mode 100644
index 000000000000..851cdcec05a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kernfs_read_xattr.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+char value[16];
+
+__always_inline void read_xattr(struct cgroup *cgroup)
+{
+	struct bpf_dynptr value_ptr;
+
+	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
+	bpf_kernfs_read_xattr(cgroup->kn, "user.bpf_test",
+			      &value_ptr);
+}
+
+SEC("lsm.s/socket_connect")
+__failure __msg("R1 must be a rcu pointer")
+int BPF_PROG(sleepable_missing_rcu_lock, struct file *f)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp;
+
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp)
+		return 0;
+
+	/* Sleepable, so cgrp->kn is not trusted */
+	read_xattr(cgrp);
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("lsm.s/socket_connect")
+__success
+int BPF_PROG(sleepable_with_rcu_lock, struct file *f)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp;
+
+	bpf_rcu_read_lock();
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp)
+		goto out;
+
+	/* In rcu read lock, so cgrp->kn is trusted */
+	read_xattr(cgrp);
+	bpf_cgroup_release(cgrp);
+out:
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("lsm/socket_connect")
+__success
+int BPF_PROG(non_sleepable, struct file *f)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp;
+
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp)
+		return 0;
+
+	/* non-sleepable, so cgrp->kn is trusted */
+	read_xattr(cgrp);
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("lsm/socket_connect")
+__success
+int BPF_PROG(use_css_iter, struct file *f)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup_subsys_state *css;
+	struct cgroup *cgrp;
+
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp)
+		return 0;
+
+	bpf_for_each(css, css, &cgrp->self, BPF_CGROUP_ITER_ANCESTORS_UP)
+		read_xattr(css->cgroup);
+
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("lsm/socket_connect")
+__success
+int BPF_PROG(use_bpf_cgroup_ancestor, struct file *f)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp, *ancestor;
+
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp)
+		return 0;
+
+	ancestor = bpf_cgroup_ancestor(cgrp, 1);
+	if (!ancestor)
+		goto out;
+	/* non-sleepable, so cgrp->kn is trusted */
+	read_xattr(cgrp);
+	bpf_cgroup_release(ancestor);
+out:
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c b/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
new file mode 100644
index 000000000000..5109e800a443
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+pid_t target_pid = 0;
+
+char xattr_value[64];
+const char expected_value_a[] = "bpf_selftest_value_a";
+const char expected_value_b[] = "bpf_selftest_value_b";
+bool found_value_a;
+bool found_value_b;
+
+SEC("lsm.s/socket_connect")
+int BPF_PROG(test_socket_connect, struct file *f)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup_subsys_state *css, *tmp;
+	struct bpf_dynptr value_ptr;
+	struct cgroup *cgrp;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	bpf_rcu_read_lock();
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+
+	css = &cgrp->self;
+	bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value), 0, &value_ptr);
+	bpf_for_each(css, tmp, css, BPF_CGROUP_ITER_ANCESTORS_UP) {
+		int ret;
+
+		ret = bpf_kernfs_read_xattr(tmp->cgroup->kn, "user.bpf_test",
+					    &value_ptr);
+		if (ret < 0)
+			continue;
+
+		if (ret == sizeof(expected_value_a) &&
+		    !bpf_strncmp(xattr_value, sizeof(expected_value_a), expected_value_a))
+			found_value_a = true;
+		if (ret == sizeof(expected_value_b) &&
+		    !bpf_strncmp(xattr_value, sizeof(expected_value_b), expected_value_b))
+			found_value_b = true;
+	}
+
+	bpf_rcu_read_unlock();
+	bpf_cgroup_release(cgrp);
+
+	return 0;
+}
-- 
2.47.1



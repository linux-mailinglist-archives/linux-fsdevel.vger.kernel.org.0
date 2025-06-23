Return-Path: <linux-fsdevel+bounces-52486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F043AE35E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 08:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A58716E899
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342CA1F4E34;
	Mon, 23 Jun 2025 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS4OWkcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83798136348;
	Mon, 23 Jun 2025 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660765; cv=none; b=PGr6ejATyhhYdJatO5NCQIU5DFb1A+uDVv4EXG0iKgz4X8JRwpDYQHZIWpLhNTffVNgXtGSntehxBEexYQpbMbg96XPso21eWqbhYxf+SYfybHdGB5a+JtdxEKj6ndLovdgT4ZA50ClK2wHADCJjsZs7z3vgJaenwR6Rrq7XK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660765; c=relaxed/simple;
	bh=RcUGPc+CuikCuze+InFNKjdzSi3ukfT0DGxKJP07Vco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhZKRHsc8Ky1gF32cKjbJPRQaN7NcNK3FGeolarsoty/nYZmhkRy5qC7RGtiilcHxgUvFSICKWuTufl3Ax6tDL/yDQBldLmyE3FiuB7pnOENxENtYN5tfRFP0MLdUm11nqcg0Ucs60rX+SDDZby7vgnvTTflN4ZqNROVdfMJ4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS4OWkcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFC3C4CEED;
	Mon, 23 Jun 2025 06:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750660765;
	bh=RcUGPc+CuikCuze+InFNKjdzSi3ukfT0DGxKJP07Vco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JS4OWkcr+Irv3m69dm0SIirYZcN8qYX4Raz0oEZuTcWU3LSFA48MZ2hE5ZZ7Z8Mzj
	 glhLBrzjLqTfwyl1w1yVWDRQ+Kb4p0VOOe4K4Fu95z18RExJIkyrFYFEnxOPF3vAGf
	 YE0+Q61os1v7R6WR/XNquj1xAyiIshjbkafrKBqJ3ElfdMACYwKksEHb1MaqLABfAl
	 vKyLw9r2n2OYkNRFLGDJMUS2Rx5z4QpEMIdlHLjVXvyXHgI+fFuFEDSM1uEhUf9+8c
	 +BAHbXwCbvOBpBrMzZDVsuuqKNTzFK7fxlf0uDm7b5KVjPKT3g4WuT7eG/EQWVl9OI
	 Le+0JbRKhrdMw==
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
Subject: [PATCH v3 bpf-next 4/4] selftests/bpf: Add tests for bpf_cgroup_read_xattr
Date: Sun, 22 Jun 2025 23:38:54 -0700
Message-ID: <20250623063854.1896364-5-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250623063854.1896364-1-song@kernel.org>
References: <20250623063854.1896364-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for different scenarios with bpf_cgroup_read_xattr:
1. Read cgroup xattr from bpf_cgroup_from_id;
2. Read cgroup xattr from bpf_cgroup_ancestor;
3. Read cgroup xattr from css_iter;
4. Use bpf_cgroup_read_xattr in LSM hook security_socket_connect.
5. Use bpf_cgroup_read_xattr in cgroup program.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  |   3 +
 .../selftests/bpf/prog_tests/cgroup_xattr.c   | 145 ++++++++++++++++
 .../selftests/bpf/progs/cgroup_read_xattr.c   | 158 ++++++++++++++++++
 .../selftests/bpf/progs/read_cgroupfs_xattr.c |  60 +++++++
 4 files changed, 366 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 5e512a1d09d1..da7e230f2781 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -596,4 +596,7 @@ extern int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it) __weak __ksym;
 extern struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it) __weak __ksym;
 extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __ksym;
 
+extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
+				 struct bpf_dynptr *value_p) __weak __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c b/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
new file mode 100644
index 000000000000..87978a0f7eb7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
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
+#include "cgroup_read_xattr.skel.h"
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
+void test_cgroup_xattr(void)
+{
+	RUN_TESTS(cgroup_read_xattr);
+
+	if (test__start_subtest("read_cgroupfs_xattr"))
+		test_read_cgroup_xattr();
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
new file mode 100644
index 000000000000..092db1d0435e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
@@ -0,0 +1,158 @@
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
+static __always_inline void read_xattr(struct cgroup *cgroup)
+{
+	struct bpf_dynptr value_ptr;
+
+	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
+	bpf_cgroup_read_xattr(cgroup, "user.bpf_test",
+			      &value_ptr);
+}
+
+SEC("lsm.s/socket_connect")
+__success
+int BPF_PROG(trusted_cgroup_ptr_sleepable)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp;
+
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp)
+		return 0;
+
+	read_xattr(cgrp);
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("lsm/socket_connect")
+__success
+int BPF_PROG(trusted_cgroup_ptr_non_sleepable)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp;
+
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp)
+		return 0;
+
+	read_xattr(cgrp);
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("lsm/socket_connect")
+__success
+int BPF_PROG(use_css_iter_non_sleepable)
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
+SEC("lsm.s/socket_connect")
+__failure __msg("expected an RCU CS")
+int BPF_PROG(use_css_iter_sleepable_missing_rcu_lock)
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
+SEC("lsm.s/socket_connect")
+__success
+int BPF_PROG(use_css_iter_sleepable_with_rcu_lock)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup_subsys_state *css;
+	struct cgroup *cgrp;
+
+	bpf_rcu_read_lock();
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp)
+		goto out;
+
+	bpf_for_each(css, css, &cgrp->self, BPF_CGROUP_ITER_ANCESTORS_UP)
+		read_xattr(css->cgroup);
+
+	bpf_cgroup_release(cgrp);
+out:
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("lsm/socket_connect")
+__success
+int BPF_PROG(use_bpf_cgroup_ancestor)
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
+
+	read_xattr(cgrp);
+	bpf_cgroup_release(ancestor);
+out:
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("cgroup/sendmsg4")
+__success
+int BPF_PROG(cgroup_skb)
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
+
+	read_xattr(cgrp);
+	bpf_cgroup_release(ancestor);
+out:
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c b/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
new file mode 100644
index 000000000000..855f85fc5522
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
+static const char expected_value_a[] = "bpf_selftest_value_a";
+static const char expected_value_b[] = "bpf_selftest_value_b";
+bool found_value_a;
+bool found_value_b;
+
+SEC("lsm.s/socket_connect")
+int BPF_PROG(test_socket_connect)
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
+		ret = bpf_cgroup_read_xattr(tmp->cgroup, "user.bpf_test",
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



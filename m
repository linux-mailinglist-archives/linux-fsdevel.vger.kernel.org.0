Return-Path: <linux-fsdevel+bounces-52271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D718BAE0F67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 00:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BCC1BC65CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9FA29C349;
	Thu, 19 Jun 2025 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baF9UeMj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75858257ACF;
	Thu, 19 Jun 2025 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370528; cv=none; b=G3ftiqenRal9ZSYmXnR1KnEwcrw3aPQKxGkUElxXOMgJj/utl2s9HCO6NeAYC9LBlSIgmo5/CUU92renx5D9eV4LpdhPKHTdb7GFImQQy2uAN4GRY3LE8WX0pFrVzkTaWuxz13DS2ngQ3m2SZyAByOPUFNSwX9T8z5iHcClJXJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370528; c=relaxed/simple;
	bh=jdWK/5a3W2+xBoAYx3DkNi8AquzLoEdQcA05Mo/5SrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPCcIYS+1/lC5e+elSR1JOikJvJo1YidVlm9chVlo+oKwwDqiLBI7MMH60D/FeOWs+lOBpnVk52mwJIELSzAQiwl7VPgNz9zpCaLUF2uxZ6ZXltG25wAEyCAQxl7R2XXdm7PbBCwTlBp1L8ALoVxb/QM9ZYGWJuMNCvWTgfGXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baF9UeMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CB5C4CEEA;
	Thu, 19 Jun 2025 22:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370527;
	bh=jdWK/5a3W2+xBoAYx3DkNi8AquzLoEdQcA05Mo/5SrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baF9UeMjNGgQuJ96ScrNta9r9aC6VonmOkkfWm0D1VkmbU9cnWjIrxw6cdS2cFr/F
	 B+25VQWEBLO3M4npDgVqbL2HTK9qfDBayHqpa/SXMfiQIk8yiL6WrMKpdA6EZm18T0
	 NVmVKqGXx9hHTdNGQ4vsd2ysb3j2lAa74r/2eGGiDbzKUX8+46CJzT359n/GGrTKfM
	 DQ3y+t2Sy8L6qsNdFhGOlm05XTlT5ghKBe1zUNQpWrK5x60SGd4TPmj6ejcOHb3P+y
	 W15DtO/D8KwL28rYifR5kcdLZEIDlG7Jd1c56U4Sma4psXPOb/xZowNMSYXfh/8Wtx
	 eBnKIBetJqkJA==
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
Subject: [PATCH v2 bpf-next 4/5] selftests/bpf: Add tests for bpf_cgroup_read_xattr
Date: Thu, 19 Jun 2025 15:01:13 -0700
Message-ID: <20250619220114.3956120-5-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250619220114.3956120-1-song@kernel.org>
References: <20250619220114.3956120-1-song@kernel.org>
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

Signed-off-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/prog_tests/cgroup_xattr.c   | 145 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_read_xattr.c   | 136 ++++++++++++++++
 .../selftests/bpf/progs/read_cgroupfs_xattr.c |  60 ++++++++
 3 files changed, 341 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c

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
index 000000000000..b50ccb3aebcf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
@@ -0,0 +1,136 @@
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



Return-Path: <linux-fsdevel+bounces-8664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC77839F0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9928F28C9C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D6717C91;
	Wed, 24 Jan 2024 02:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4sepBHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A50817C64;
	Wed, 24 Jan 2024 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062987; cv=none; b=rnH5fSpwtdByVhINiOoyN9wgk+9Veto7geSx3sauoYxu28ZnFSP5NueWeWRUg5WQNbRzPkLRF0O0yYA6h3aU7Am5wRzhzSkveX8wWOrSAKScPlAqT6cqNZtCgaRBkXPCQ8/nix3efvowMafJMqFinupj5Z5Lmj9PRtYldrlekcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062987; c=relaxed/simple;
	bh=tQr5RfYWrBCMnOzVfH0l30kst8l4l8Ob5YwKecd1ilA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgeVHXNw0m1m4AoV6eRCPE7xo9fFmzZ0J/YWBAAs7V20c2aYo/p3MFG4Gnc3bhvgqJD/bCMsBO8V2V2OD3poLHzMuE6UYcxdmVCfBzFs3mMcW5FQiKlfEO7y0HWIS6B04ajFX8LrPbzimezyd+oNIEcXOxT1UXzw7S5Mew+aZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4sepBHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF3DC433C7;
	Wed, 24 Jan 2024 02:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062986;
	bh=tQr5RfYWrBCMnOzVfH0l30kst8l4l8Ob5YwKecd1ilA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4sepBHyVFevczPDamrOHoOLvfxZa4Cb9WVGtUdVWMVmgJzIco7qmdrBv93pM6w/g
	 i/b1yCMX9C5kjC90W4jrPngLXBL/LfKRZhIR1UP/FZ9U0HBSPPMNU4lgdBXKPqTpp6
	 e30usUgm5irg+LNkxQvZTMlYpTEjCXTcjc6OctIIYnFyWHn26IVLq5T4YNkf+q/bIQ
	 taOtHwQToseBwhKldDR/TlumkAMjNeuM6a1d5k/F20uotUgJDyFITdkjh1/cRCRDsz
	 agR2XCyaoaMMD6awPHYgFGyjxp0JXHYJUj5KZiPxeO1Z0INO9BNmAPOfYzzbZU8VBK
	 pAR0P4n10FeTA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 26/30] selftests/bpf: add BPF object loading tests with explicit token passing
Date: Tue, 23 Jan 2024 18:21:23 -0800
Message-Id: <20240124022127.2379740-27-andrii@kernel.org>
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

Add a few tests that attempt to load BPF object containing privileged
map, program, and the one requiring mandatory BTF uploading into the
kernel (to validate token FD propagation to BPF_BTF_LOAD command).

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 140 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/priv_map.c  |  13 ++
 tools/testing/selftests/bpf/progs/priv_prog.c |  13 ++
 3 files changed, 166 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index 185ed2f79315..1594d9b94b13 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -14,6 +14,9 @@
 #include <sys/socket.h>
 #include <sys/syscall.h>
 #include <sys/un.h>
+#include "priv_map.skel.h"
+#include "priv_prog.skel.h"
+#include "dummy_st_ops_success.skel.h"
 
 static inline int sys_mount(const char *dev_name, const char *dir_name,
 			    const char *type, unsigned long flags,
@@ -666,6 +669,104 @@ static int userns_prog_load(int mnt_fd)
 	return err;
 }
 
+static int userns_obj_priv_map(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	char buf[256];
+	struct priv_map *skel;
+	int err;
+
+	skel = priv_map__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_tokenless_load")) {
+		priv_map__destroy(skel);
+		return -EINVAL;
+	}
+
+	/* use bpf_token_path to provide BPF FS path */
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", mnt_fd);
+	opts.bpf_token_path = buf;
+	skel = priv_map__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_token_path_open"))
+		return -EINVAL;
+
+	err = priv_map__load(skel);
+	priv_map__destroy(skel);
+	if (!ASSERT_OK(err, "obj_token_path_load"))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int userns_obj_priv_prog(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	char buf[256];
+	struct priv_prog *skel;
+	int err;
+
+	skel = priv_prog__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_tokenless_load")) {
+		priv_prog__destroy(skel);
+		return -EINVAL;
+	}
+
+	/* use bpf_token_path to provide BPF FS path */
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", mnt_fd);
+	opts.bpf_token_path = buf;
+	skel = priv_prog__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_token_path_open"))
+		return -EINVAL;
+
+	err = priv_prog__load(skel);
+	priv_prog__destroy(skel);
+	if (!ASSERT_OK(err, "obj_token_path_load"))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* this test is called with BPF FS that doesn't delegate BPF_BTF_LOAD command,
+ * which should cause struct_ops application to fail, as BTF won't be uploaded
+ * into the kernel, even if STRUCT_OPS programs themselves are allowed
+ */
+static int validate_struct_ops_load(int mnt_fd, bool expect_success)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	char buf[256];
+	struct dummy_st_ops_success *skel;
+	int err;
+
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", mnt_fd);
+	opts.bpf_token_path = buf;
+	skel = dummy_st_ops_success__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_token_path_open"))
+		return -EINVAL;
+
+	err = dummy_st_ops_success__load(skel);
+	dummy_st_ops_success__destroy(skel);
+	if (expect_success) {
+		if (!ASSERT_OK(err, "obj_token_path_load"))
+			return -EINVAL;
+	} else /* expect failure */ {
+		if (!ASSERT_ERR(err, "obj_token_path_load"))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int userns_obj_priv_btf_fail(int mnt_fd)
+{
+	return validate_struct_ops_load(mnt_fd, false /* should fail */);
+}
+
+static int userns_obj_priv_btf_success(int mnt_fd)
+{
+	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
+}
+
+#define bit(n) (1ULL << (n))
+
 void test_token(void)
 {
 	if (test__start_subtest("map_token")) {
@@ -692,4 +793,43 @@ void test_token(void)
 
 		subtest_userns(&opts, userns_prog_load);
 	}
+	if (test__start_subtest("obj_priv_map")) {
+		struct bpffs_opts opts = {
+			.cmds = bit(BPF_MAP_CREATE),
+			.maps = bit(BPF_MAP_TYPE_QUEUE),
+		};
+
+		subtest_userns(&opts, userns_obj_priv_map);
+	}
+	if (test__start_subtest("obj_priv_prog")) {
+		struct bpffs_opts opts = {
+			.cmds = bit(BPF_PROG_LOAD),
+			.progs = bit(BPF_PROG_TYPE_KPROBE),
+			.attachs = ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_prog);
+	}
+	if (test__start_subtest("obj_priv_btf_fail")) {
+		struct bpffs_opts opts = {
+			/* disallow BTF loading */
+			.cmds = bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
+			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.attachs = ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_btf_fail);
+	}
+	if (test__start_subtest("obj_priv_btf_success")) {
+		struct bpffs_opts opts = {
+			/* allow BTF loading */
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
+			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.attachs = ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_btf_success);
+	}
 }
diff --git a/tools/testing/selftests/bpf/progs/priv_map.c b/tools/testing/selftests/bpf/progs/priv_map.c
new file mode 100644
index 000000000000..9085be50f03b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/priv_map.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 1);
+	__type(value, __u32);
+} priv_map SEC(".maps");
diff --git a/tools/testing/selftests/bpf/progs/priv_prog.c b/tools/testing/selftests/bpf/progs/priv_prog.c
new file mode 100644
index 000000000000..3c7b2b618c8a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/priv_prog.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("kprobe")
+int kprobe_prog(void *ctx)
+{
+	return 1;
+}
-- 
2.34.1



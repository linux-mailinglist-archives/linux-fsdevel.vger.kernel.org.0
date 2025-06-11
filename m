Return-Path: <linux-fsdevel+bounces-51370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D115AD6225
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 00:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112F73AAA96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 22:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADEF25487A;
	Wed, 11 Jun 2025 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU26z/Z3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5D24BC1A;
	Wed, 11 Jun 2025 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679373; cv=none; b=oCQg6Z4uChaiXG5F8R5QKZ05PQL26oK18h9WhBHcjn3w+i+uOCxnZX/pLGNpz9XVBYLd2Es10kNwsvs2/pB8Xbf7FGE4XeqeYqAPZNjuU/rYKll8bi4nzUn/geVtarbGOJxrkY80fu3ky3tPNwMewccYyF6VkVQUHNBUl8GxzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679373; c=relaxed/simple;
	bh=vl/pVqr2RXH2Xn1E+8wtiXLeu/mTXlC3sdSyiyVMmIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATxO1DKQTWC9B48LarnkFcQl4OiTvXWRr2smkFl3i9KvuJnbsSh3ViaMFj/udIy9V7huNfLcBuwRMkaciMTPdxsfdxID9DGGAYaYzPLa8ML9Uyltapw6SJ4ERKzh1fv4lqdfZFesqWgiTwCn0S7va1diCKZgDs9ff5xr+0z3+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU26z/Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E08C4CEEE;
	Wed, 11 Jun 2025 22:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749679372;
	bh=vl/pVqr2RXH2Xn1E+8wtiXLeu/mTXlC3sdSyiyVMmIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KU26z/Z3kicXR0SNyEAcbe8ylvH0cNGYTroG/WWfzY0qIqMgmOyzqYxkPw+N272eP
	 zyuz+iDYcepkgPEP/3p0a8DLH2pWnRbabhDhPY6Lv6LyoxCovzK5D7eo2wzE8PgRB2
	 9BByU8MYRU2eeDHFgg9H01booGZ0WFQps+ZwMWxUiPUYguX8JwPoVb4JldapUb2CSl
	 yoRQlWeN9NIZ7Lq33x0rR4D6LW2aPEov8X8pZ8jHoMp2MuJt0v0Lhyf4mErOTOnSI1
	 F8jHSMXWrZPOSn6KvtzdS3V/RdupHMehrX1WWcTneygQH1oNDwBZ4SEjy/o4G/P1aW
	 Uv9VZ5r37zxWA==
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
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	m@maowtm.org,
	neil@brown.name,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 5/5] selftests/bpf: Path walk test
Date: Wed, 11 Jun 2025 15:02:20 -0700
Message-ID: <20250611220220.3681382-6-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611220220.3681382-1-song@kernel.org>
References: <20250611220220.3681382-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an end-to-end test with path_iter on security hook file_open.

A test file is created in folder /tmp/test_progs_path_iter/folder. On
file_open, walk file->f_path up to its parent and grand parent, and test
bpf_get_dentry_xattr and bpf_path_d_path on the folders.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/prog_tests/path_iter.c      | 99 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/path_walk.c | 59 +++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/path_walk.c

diff --git a/tools/testing/selftests/bpf/prog_tests/path_iter.c b/tools/testing/selftests/bpf/prog_tests/path_iter.c
index 3c99c24fbd96..b9772026fbf7 100644
--- a/tools/testing/selftests/bpf/prog_tests/path_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/path_iter.c
@@ -2,11 +2,110 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <test_progs.h>
+#include <fcntl.h>
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
+#include <sys/stat.h>
+#include <sys/xattr.h>
+
 #include "path_iter.skel.h"
+#include "path_walk.skel.h"
+
+static const char grand_parent_path[] = "/tmp/test_progs_path_iter";
+static const char parent_path[] = "/tmp/test_progs_path_iter/folder";
+static const char file_path[] = "/tmp/test_progs_path_iter/folder/file";
+static const char xattr_name[] = "user.bpf.selftests";
+static const char xattr_value[] = "selftest_path_iter";
+
+static void cleanup_files(void)
+{
+	remove(file_path);
+	rmdir(parent_path);
+	rmdir(grand_parent_path);
+}
+
+static int setup_files_and_xattrs(void)
+{
+	int ret = -1;
+
+	/* create test folders */
+	if (mkdir(grand_parent_path, 0755))
+		goto error;
+	if (mkdir(parent_path, 0755))
+		goto error;
+
+	/* setxattr for test folders */
+	ret = setxattr(grand_parent_path, xattr_name,
+		       xattr_value, sizeof(xattr_value), 0);
+	if (ret < 0) {
+		/* return errno, so that we can handle EOPNOTSUPP in the caller */
+		ret = errno;
+		goto error;
+	}
+	ret = setxattr(parent_path, xattr_name,
+		       xattr_value, sizeof(xattr_value), 0);
+	if (ret < 0) {
+		/* return errno, so that we can handle EOPNOTSUPP in the caller */
+		ret = errno;
+		goto error;
+	}
+
+	return 0;
+error:
+	cleanup_files();
+	return ret;
+}
+
+static void test_path_walk(void)
+{
+	struct path_walk *skel = NULL;
+	int file_fd;
+	int err;
+
+	err = setup_files_and_xattrs();
+	if (err == EOPNOTSUPP) {
+		printf("%s:SKIP:local fs doesn't support xattr (%d)\n"
+		       "To run this test, make sure /tmp filesystem supports xattr.\n",
+		       __func__, errno);
+		test__skip();
+		return;
+	}
+
+	if (!ASSERT_OK(err, "setup_file"))
+		return;
+
+	skel = path_walk__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "path_walk__open_and_load"))
+		goto cleanup;
+
+	skel->bss->monitored_pid = getpid();
+	if (!ASSERT_OK(path_walk__attach(skel), "path_walk__attach"))
+		goto cleanup;
+
+	file_fd = open(file_path, O_CREAT);
+	if (!ASSERT_OK_FD(file_fd, "open_file"))
+		goto cleanup;
+	close(file_fd);
+
+	ASSERT_OK(strncmp(skel->bss->parent_xattr_buf, xattr_value, strlen(xattr_value)),
+		  "parent_xattr");
+	ASSERT_OK(strncmp(skel->bss->grand_parent_xattr_buf, xattr_value, strlen(xattr_value)),
+		  "grand_parent_xattr");
+
+	ASSERT_OK(strncmp(skel->bss->parent_path_buf, parent_path, strlen(parent_path)),
+		  "parent_d_path");
+	ASSERT_OK(strncmp(skel->bss->grand_parent_path_buf, grand_parent_path,
+			  strlen(grand_parent_path)),
+		  "grand_parent_d_path");
+
+cleanup:
+	path_walk__destroy(skel);
+	cleanup_files();
+}
 
 void test_path_iter(void)
 {
 	RUN_TESTS(path_iter);
+	if (test__start_subtest("path_walk_example"))
+		test_path_walk();
 }
diff --git a/tools/testing/selftests/bpf/progs/path_walk.c b/tools/testing/selftests/bpf/progs/path_walk.c
new file mode 100644
index 000000000000..1e1ae82b47a2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_walk.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+
+#define BUF_SIZE 1024
+char parent_path_buf[BUF_SIZE] = {};
+char parent_xattr_buf[BUF_SIZE] = {};
+char grand_parent_path_buf[BUF_SIZE] = {};
+char grand_parent_xattr_buf[BUF_SIZE] = {};
+
+static __always_inline void d_path_and_read_xattr(struct path *p, char *path, char *xattr)
+{
+	struct bpf_dynptr ptr;
+	struct dentry *dentry;
+
+	if (!p)
+		return;
+	bpf_path_d_path(p, path, BUF_SIZE);
+	bpf_dynptr_from_mem(xattr, BUF_SIZE, 0, &ptr);
+	dentry = p->dentry;
+	if (dentry)
+		bpf_get_dentry_xattr(dentry, "user.bpf.selftests", &ptr);
+}
+
+SEC("lsm.s/file_open")
+int BPF_PROG(test_file_open, struct file *f)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct bpf_iter_path path_it;
+	struct path *p;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_iter_path_new(&path_it, &f->f_path, 0);
+
+	/* Get d_path and xattr for the parent directory */
+	p = bpf_iter_path_next(&path_it);
+	d_path_and_read_xattr(p, parent_path_buf, parent_xattr_buf);
+
+	/* Get d_path and xattr for the grand parent directory */
+	p = bpf_iter_path_next(&path_it);
+	d_path_and_read_xattr(p, grand_parent_path_buf, grand_parent_xattr_buf);
+
+	bpf_iter_path_destroy(&path_it);
+
+	return 0;
+}
-- 
2.47.1



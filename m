Return-Path: <linux-fsdevel+bounces-79636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC2ILEICq2nDZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:35:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D715F22512B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97BF83105F0D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F1A3ED5D0;
	Fri,  6 Mar 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeNXuh/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4E3EDAAE
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814529; cv=none; b=L4NcxgypEQvAU5ovWMu/bV9nPhbTeG1sMFCixveisYatNIORzoM+N6h4B8uAWxXC9oYcLoBkwcZsWrTqKHSOaHFKwLfDGgOndrXNH5g7NO01zlagdhTypeYUhqSlquFkHDsk0PdvUmBnPVKZSA+F8mJVtF5GwEoP0d2ZOrJkcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814529; c=relaxed/simple;
	bh=QZLTJT3Dqf1DReGy32QvcCvCWFcYqyejsg/OxqTTvFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=cUuiVmnvHJTQUkH/W+31++/mvV/O6QRnTGlUzC0J/BPv8yQn6A2L18upTzuTXfywYBseQjYNDiY29Vj7+xTSyIOSIq/deAHsxTLbscM2hKpieUTgqEJWSpExO+wNJvre65fAgmRVXHsXpiGj0v0FLVndyQa3rFJlBGMk6UVJ2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeNXuh/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95703C4CEF7;
	Fri,  6 Mar 2026 16:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772814529;
	bh=QZLTJT3Dqf1DReGy32QvcCvCWFcYqyejsg/OxqTTvFo=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=EeNXuh/0FmFHlvyd2RqqN3HQixobSmKUFDwPKF7hsmzEC4mlHXkDYO/3prgZCxLYO
	 Y8lllEiDonBCLMBDNe2H2FVk72KTVJz/105fuuKPJzthL4hAQ6spxOEaNz724oA5g1
	 qDH3PmZs9d9NnQccmVpy5gV9bJiAnh/FgEsmYc84wXM0EwASXSVhGDND/6dCtyTBqD
	 EJpbYx0EUXlKSCxa1nEfe2MNAwOJFwVpEtKb6nClPf5oO4g570fNE4JN5TbSmPV/at
	 6pREZ1IIJJpAA/0yG2jD5kBC1zxAzw4jiMqeThnS0qAyC67rf28bjFyG2VOXGL9AqK
	 6RxvEeVFCG0Mg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 17:28:39 +0100
Subject: [PATCH 3/3] selftests/filesystems: add clone3 tests for empty
 mount namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-empty-mntns-consolidated-v1-3-6eb30529bbb0@kernel.org>
References: <20260306-work-empty-mntns-consolidated-v1-0-6eb30529bbb0@kernel.org>
In-Reply-To: <20260306-work-empty-mntns-consolidated-v1-0-6eb30529bbb0@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-e55a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=22129; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QZLTJT3Dqf1DReGy32QvcCvCWFcYqyejsg/OxqTTvFo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuZtiRtjSy32TN8dmdwWvD75VoTb4cVLdwyk9hf26xI
 4YukXaaHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpNWb4Z2NxXvjeS4Y9DK4q
 PimP935cKpTo/jZm9cXT+rELlvj8usXwm1X5lZd1tPwB3QcdP3P+PpgZ99h7+oppGy881trziHX
 nTBYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: D715F22512B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79636-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.926];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a test suite for the CLONE_EMPTY_MNTNS flag exercising the empty
mount namespace functionality through the clone3() syscall.

The clone3() code path is distinct from the unshare() path already
tested in empty_mntns_test.c.  With clone3(), CLONE_EMPTY_MNTNS
(0x400000000ULL) is a 64-bit flag that implies CLONE_NEWNS.  The
implication happens in kernel_clone() before copy_process(), unlike
unshare() where it goes through UNSHARE_EMPTY_MNTNS to
CLONE_EMPTY_MNTNS conversion in unshare_nsproxy_namespaces().

The tests cover:

- basic functionality: clone3 child gets empty mount namespace with
  exactly one mount, root and cwd point to the same mount
- CLONE_NEWNS implication: CLONE_EMPTY_MNTNS works without explicit
  CLONE_NEWNS, also works with redundant CLONE_NEWNS
- flag interactions: combines correctly with CLONE_NEWUSER,
  CLONE_NEWPID, CLONE_NEWUTS, CLONE_NEWIPC, CLONE_PIDFD
- mutual exclusion: CLONE_EMPTY_MNTNS | CLONE_FS returns EINVAL
  because the implied CLONE_NEWNS conflicts with CLONE_FS
- error paths: EPERM without capabilities, unknown 64-bit flags
  rejected
- parent isolation: parent mount namespace is unchanged after clone
- many parent mounts: child still gets exactly one mount
- mount properties: root mount is nullfs, is its own parent, is the
  only listmount entry
- overmount workflow: child can mount tmpfs over nullfs root to build
  a writable filesystem from scratch
- repeated clone3: each child gets a distinct mount namespace
- setns: parent can join child's empty mount namespace via setns()
- regression: plain CLONE_NEWNS via clone3 still copies the full
  mount tree

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/empty_mntns/.gitignore   |   1 +
 .../selftests/filesystems/empty_mntns/Makefile     |   3 +-
 .../empty_mntns/clone3_empty_mntns_test.c          | 938 +++++++++++++++++++++
 3 files changed, 941 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/empty_mntns/.gitignore b/tools/testing/selftests/filesystems/empty_mntns/.gitignore
index 48054440b7e1..99f89d329db2 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/.gitignore
+++ b/tools/testing/selftests/filesystems/empty_mntns/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
+clone3_empty_mntns_test
 empty_mntns_test
 overmount_chroot_test
diff --git a/tools/testing/selftests/filesystems/empty_mntns/Makefile b/tools/testing/selftests/filesystems/empty_mntns/Makefile
index 5d4cffa4c4ae..22e3fb915e81 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/Makefile
+++ b/tools/testing/selftests/filesystems/empty_mntns/Makefile
@@ -3,9 +3,10 @@
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
-TEST_GEN_PROGS := empty_mntns_test overmount_chroot_test
+TEST_GEN_PROGS := empty_mntns_test overmount_chroot_test clone3_empty_mntns_test
 
 include ../../lib.mk
 
 $(OUTPUT)/empty_mntns_test: ../utils.c
 $(OUTPUT)/overmount_chroot_test: ../utils.c
+$(OUTPUT)/clone3_empty_mntns_test: ../utils.c
diff --git a/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c b/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
new file mode 100644
index 000000000000..130cc1a1b407
--- /dev/null
+++ b/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
@@ -0,0 +1,938 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Tests for empty mount namespace creation via clone3() CLONE_EMPTY_MNTNS
+ *
+ * These tests exercise the clone3() code path for creating empty mount
+ * namespaces, which is distinct from the unshare() path tested in
+ * empty_mntns_test.c.  With clone3(), CLONE_EMPTY_MNTNS (0x400000000ULL)
+ * is a 64-bit flag that implies CLONE_NEWNS.  The implication happens in
+ * kernel_clone() before copy_process(), unlike unshare() where it goes
+ * through UNSHARE_EMPTY_MNTNS -> CLONE_EMPTY_MNTNS conversion in
+ * unshare_nsproxy_namespaces().
+ *
+ * Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <linux/mount.h>
+#include <linux/stat.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../utils.h"
+#include "../wrappers.h"
+#include "clone3/clone3_selftests.h"
+#include "empty_mntns.h"
+#include "kselftest_harness.h"
+
+static pid_t clone3_empty_mntns(uint64_t extra_flags)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_EMPTY_MNTNS | extra_flags,
+		.exit_signal	= SIGCHLD,
+	};
+
+	return sys_clone3(&args, sizeof(args));
+}
+
+static bool clone3_empty_mntns_supported(void)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	if (pid < 0)
+		return false;
+
+	if (pid == 0) {
+		if (enter_userns())
+			_exit(1);
+
+		pid = clone3_empty_mntns(0);
+		if (pid < 0)
+			_exit(1);
+
+		if (pid == 0)
+			_exit(0);
+
+		_exit(wait_for_pid(pid) != 0);
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return false;
+
+	if (!WIFEXITED(status))
+		return false;
+
+	return WEXITSTATUS(status) == 0;
+}
+
+FIXTURE(clone3_empty_mntns) {};
+
+FIXTURE_SETUP(clone3_empty_mntns)
+{
+	if (!clone3_empty_mntns_supported())
+		SKIP(return, "CLONE_EMPTY_MNTNS via clone3 not supported");
+}
+
+FIXTURE_TEARDOWN(clone3_empty_mntns) {}
+
+/*
+ * Basic clone3() with CLONE_EMPTY_MNTNS: child gets empty mount namespace
+ * with exactly 1 mount and root == cwd.
+ */
+TEST_F(clone3_empty_mntns, basic)
+{
+	pid_t pid, inner;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		if (enter_userns())
+			_exit(1);
+
+		inner = clone3_empty_mntns(0);
+		if (inner < 0)
+			_exit(2);
+
+		if (inner == 0) {
+			uint64_t root_id, cwd_id;
+
+			if (count_mounts() != 1)
+				_exit(3);
+
+			root_id = get_unique_mnt_id("/");
+			cwd_id = get_unique_mnt_id(".");
+			if (root_id == 0 || cwd_id == 0)
+				_exit(4);
+
+			if (root_id != cwd_id)
+				_exit(5);
+
+			_exit(0);
+		}
+
+		_exit(wait_for_pid(inner));
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * CLONE_EMPTY_MNTNS implies CLONE_NEWNS.  Verify that it works without
+ * explicitly setting CLONE_NEWNS (tests fork.c:2627-2630).
+ */
+TEST_F(clone3_empty_mntns, implies_newns)
+{
+	pid_t pid, inner;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ssize_t parent_mounts;
+
+		if (enter_userns())
+			_exit(1);
+
+		/* Verify we have mounts in our current namespace. */
+		parent_mounts = count_mounts();
+		if (parent_mounts < 1)
+			_exit(2);
+
+		/* Only CLONE_EMPTY_MNTNS, no explicit CLONE_NEWNS. */
+		inner = clone3_empty_mntns(0);
+		if (inner < 0)
+			_exit(3);
+
+		if (inner == 0) {
+			if (count_mounts() != 1)
+				_exit(4);
+
+			_exit(0);
+		}
+
+		/* Parent still has its mounts. */
+		if (count_mounts() != parent_mounts)
+			_exit(5);
+
+		_exit(wait_for_pid(inner));
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Helper macro: generate a test that clones with CLONE_EMPTY_MNTNS |
+ * @extra_flags and verifies the child has exactly one mount.
+ */
+#define TEST_CLONE3_FLAGS(test_name, extra_flags)			\
+TEST_F(clone3_empty_mntns, test_name)					\
+{									\
+	pid_t pid, inner;						\
+									\
+	pid = fork();							\
+	ASSERT_GE(pid, 0);						\
+									\
+	if (pid == 0) {							\
+		if (enter_userns())					\
+			_exit(1);					\
+									\
+		inner = clone3_empty_mntns(extra_flags);		\
+		if (inner < 0)						\
+			_exit(2);					\
+									\
+		if (inner == 0) {					\
+			if (count_mounts() != 1)			\
+				_exit(3);				\
+			_exit(0);					\
+		}							\
+									\
+		_exit(wait_for_pid(inner));				\
+	}								\
+									\
+	ASSERT_EQ(wait_for_pid(pid), 0);				\
+}
+
+/* Redundant CLONE_NEWNS | CLONE_EMPTY_MNTNS should succeed. */
+TEST_CLONE3_FLAGS(with_explicit_newns, CLONE_NEWNS)
+
+/* CLONE_EMPTY_MNTNS combined with CLONE_NEWUSER. */
+TEST_CLONE3_FLAGS(with_newuser, CLONE_NEWUSER)
+
+/* CLONE_EMPTY_MNTNS combined with other namespace flags. */
+TEST_CLONE3_FLAGS(with_other_ns_flags, CLONE_NEWUTS | CLONE_NEWIPC)
+
+/*
+ * CLONE_EMPTY_MNTNS combined with CLONE_NEWPID.
+ */
+TEST_F(clone3_empty_mntns, with_newpid)
+{
+	pid_t pid, inner;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		if (enter_userns())
+			_exit(1);
+
+		inner = clone3_empty_mntns(CLONE_NEWPID);
+		if (inner < 0)
+			_exit(2);
+
+		if (inner == 0) {
+			if (count_mounts() != 1)
+				_exit(3);
+
+			/* In a new PID namespace, getpid() returns 1. */
+			if (getpid() != 1)
+				_exit(4);
+
+			_exit(0);
+		}
+
+		_exit(wait_for_pid(inner));
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * CLONE_EMPTY_MNTNS | CLONE_FS must fail because the implied CLONE_NEWNS
+ * and CLONE_FS are mutually exclusive (fork.c:1981).
+ */
+TEST_F(clone3_empty_mntns, with_clone_fs_fails)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct __clone_args args = {
+			.flags		= CLONE_EMPTY_MNTNS | CLONE_FS,
+			.exit_signal	= SIGCHLD,
+		};
+		pid_t ret;
+
+		if (enter_userns())
+			_exit(1);
+
+		ret = sys_clone3(&args, sizeof(args));
+		if (ret >= 0) {
+			if (ret == 0)
+				_exit(0);
+			wait_for_pid(ret);
+			_exit(2);
+		}
+
+		if (errno != EINVAL)
+			_exit(3);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * CLONE_EMPTY_MNTNS combined with CLONE_PIDFD returns a valid pidfd.
+ */
+TEST_F(clone3_empty_mntns, with_pidfd)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct __clone_args args = {
+			.flags		= CLONE_EMPTY_MNTNS | CLONE_PIDFD,
+			.exit_signal	= SIGCHLD,
+		};
+		int pidfd = -1;
+		pid_t inner;
+
+		if (enter_userns())
+			_exit(1);
+
+		args.pidfd = (uintptr_t)&pidfd;
+
+		inner = sys_clone3(&args, sizeof(args));
+		if (inner < 0)
+			_exit(2);
+
+		if (inner == 0) {
+			if (count_mounts() != 1)
+				_exit(3);
+
+			_exit(0);
+		}
+
+		/* Verify we got a valid pidfd. */
+		if (pidfd < 0)
+			_exit(4);
+
+		close(pidfd);
+		_exit(wait_for_pid(inner));
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * clone3 without CAP_SYS_ADMIN must fail with EPERM.
+ */
+TEST_F(clone3_empty_mntns, eperm_without_caps)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pid_t ret;
+
+		/* Skip if already root. */
+		if (getuid() == 0)
+			_exit(0);
+
+		ret = clone3_empty_mntns(0);
+		if (ret >= 0) {
+			if (ret == 0)
+				_exit(0);
+			wait_for_pid(ret);
+			_exit(1);
+		}
+
+		if (errno != EPERM)
+			_exit(2);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Parent's mount namespace is unaffected after clone3 with CLONE_EMPTY_MNTNS.
+ */
+TEST_F(clone3_empty_mntns, parent_unchanged)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ssize_t nr_before, nr_after;
+		pid_t inner;
+
+		if (enter_userns())
+			_exit(1);
+
+		nr_before = count_mounts();
+		if (nr_before < 1)
+			_exit(2);
+
+		inner = clone3_empty_mntns(0);
+		if (inner < 0)
+			_exit(3);
+
+		if (inner == 0)
+			_exit(0);
+
+		if (wait_for_pid(inner) != 0)
+			_exit(4);
+
+		nr_after = count_mounts();
+		if (nr_after != nr_before)
+			_exit(5);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Parent with many mounts: child still gets exactly 1 mount.
+ */
+TEST_F(clone3_empty_mntns, many_parent_mounts)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		char tmpdir[] = "/tmp/clone3_mntns_test.XXXXXX";
+		pid_t inner;
+		int i;
+
+		if (enter_userns())
+			_exit(1);
+
+		if (unshare(CLONE_NEWNS))
+			_exit(2);
+
+		if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL))
+			_exit(3);
+
+		if (!mkdtemp(tmpdir))
+			_exit(4);
+
+		if (mount("tmpfs", tmpdir, "tmpfs", 0, "size=1M"))
+			_exit(5);
+
+		for (i = 0; i < 5; i++) {
+			char subdir[256];
+
+			snprintf(subdir, sizeof(subdir), "%s/sub%d", tmpdir, i);
+			if (mkdir(subdir, 0755) && errno != EEXIST)
+				_exit(6);
+			if (mount(subdir, subdir, NULL, MS_BIND, NULL))
+				_exit(7);
+		}
+
+		if (count_mounts() < 5)
+			_exit(8);
+
+		inner = clone3_empty_mntns(0);
+		if (inner < 0)
+			_exit(9);
+
+		if (inner == 0) {
+			if (count_mounts() != 1)
+				_exit(10);
+
+			_exit(0);
+		}
+
+		_exit(wait_for_pid(inner));
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Verify the child's root mount is nullfs with expected statmount properties.
+ */
+TEST_F(clone3_empty_mntns, mount_properties)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pid_t inner;
+
+		if (enter_userns())
+			_exit(1);
+
+		inner = clone3_empty_mntns(0);
+		if (inner < 0)
+			_exit(2);
+
+		if (inner == 0) {
+			struct statmount *sm;
+			uint64_t root_id;
+
+			root_id = get_unique_mnt_id("/");
+			if (!root_id)
+				_exit(3);
+
+			sm = statmount_alloc(root_id, 0,
+					     STATMOUNT_MNT_BASIC |
+					     STATMOUNT_MNT_POINT |
+					     STATMOUNT_FS_TYPE);
+			if (!sm)
+				_exit(4);
+
+			/* Root mount point is "/". */
+			if (!(sm->mask & STATMOUNT_MNT_POINT))
+				_exit(5);
+			if (strcmp(sm->str + sm->mnt_point, "/") != 0)
+				_exit(6);
+
+			/* Filesystem type is nullfs. */
+			if (!(sm->mask & STATMOUNT_FS_TYPE))
+				_exit(7);
+			if (strcmp(sm->str + sm->fs_type, "nullfs") != 0)
+				_exit(8);
+
+			/* Root mount is its own parent. */
+			if (!(sm->mask & STATMOUNT_MNT_BASIC))
+				_exit(9);
+			if (sm->mnt_parent_id != sm->mnt_id)
+				_exit(10);
+
+			free(sm);
+			_exit(0);
+		}
+
+		_exit(wait_for_pid(inner));
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Listmount returns only the root mount in the child's empty namespace.
+ */
+TEST_F(clone3_empty_mntns, listmount_single_entry)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pid_t inner;
+
+		if (enter_userns())
+			_exit(1);
+
+		inner = clone3_empty_mntns(0);
+		if (inner < 0)
+			_exit(2);
+
+		if (inner == 0) {
+			uint64_t list[16];
+			ssize_t nr_mounts;
+			uint64_t root_id;
+
+			nr_mounts = listmount(LSMT_ROOT, 0, 0, list, 16, 0);
+			if (nr_mounts != 1)
+				_exit(3);
+
+			root_id = get_unique_mnt_id("/");
+			if (!root_id)
+				_exit(4);
+
+			if (list[0] != root_id)
+				_exit(5);
+
+			_exit(0);
+		}
+
+		_exit(wait_for_pid(inner));
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Child can mount tmpfs over nullfs root (the primary container use case).
+ *
+ * Uses the new mount API (fsopen/fsmount/move_mount) because resolving
+ * "/" returns the process root directly without following overmounts.
+ * The mount fd from fsmount lets us fchdir + chroot into the new tmpfs.
+ */
+TEST_F(clone3_empty_mntns, child_overmount_tmpfs)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pid_t inner;
+
+		if (enter_userns())
+			_exit(1);
+
+		inner = clone3_empty_mntns(0);
+		if (inner < 0)
+			_exit(2);
+
+		if (inner == 0) {
+			struct statmount *sm;
+			uint64_t root_id;
+			int fd, fsfd, mntfd;
+
+			if (count_mounts() != 1)
+				_exit(3);
+
+			/* Verify root is nullfs. */
+			root_id = get_unique_mnt_id("/");
+			if (!root_id)
+				_exit(4);
+
+			sm = statmount_alloc(root_id, 0, STATMOUNT_FS_TYPE);
+			if (!sm)
+				_exit(5);
+			if (!(sm->mask & STATMOUNT_FS_TYPE))
+				_exit(6);
+			if (strcmp(sm->str + sm->fs_type, "nullfs") != 0)
+				_exit(7);
+			free(sm);
+
+			/* Create tmpfs via the new mount API. */
+			fsfd = sys_fsopen("tmpfs", 0);
+			if (fsfd < 0)
+				_exit(8);
+
+			if (sys_fsconfig(fsfd, FSCONFIG_SET_STRING,
+					 "size", "1M", 0)) {
+				close(fsfd);
+				_exit(9);
+			}
+
+			if (sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE,
+					 NULL, NULL, 0)) {
+				close(fsfd);
+				_exit(10);
+			}
+
+			mntfd = sys_fsmount(fsfd, 0, 0);
+			close(fsfd);
+			if (mntfd < 0)
+				_exit(11);
+
+			/* Attach tmpfs to "/". */
+			if (sys_move_mount(mntfd, "", AT_FDCWD, "/",
+					   MOVE_MOUNT_F_EMPTY_PATH)) {
+				close(mntfd);
+				_exit(12);
+			}
+
+			if (count_mounts() != 2) {
+				close(mntfd);
+				_exit(13);
+			}
+
+			/* Enter the tmpfs. */
+			if (fchdir(mntfd)) {
+				close(mntfd);
+				_exit(14);
+			}
+
+			if (chroot(".")) {
+				close(mntfd);
+				_exit(15);
+			}
+
+			close(mntfd);
+
+			/* Verify "/" is now tmpfs. */
+			root_id = get_unique_mnt_id("/");
+			if (!root_id)
+				_exit(16);
+
+			sm = statmount_alloc(root_id, 0, STATMOUNT_FS_TYPE);
+			if (!sm)
+				_exit(17);
+			if (!(sm->mask & STATMOUNT_FS_TYPE))
+				_exit(18);
+			if (strcmp(sm->str + sm->fs_type, "tmpfs") != 0)
+				_exit(19);
+			free(sm);
+
+			/* Verify tmpfs is writable. */
+			fd = open("/testfile", O_CREAT | O_RDWR, 0644);
+			if (fd < 0)
+				_exit(20);
+
+			if (write(fd, "test", 4) != 4) {
+				close(fd);
+				_exit(21);
+			}
+			close(fd);
+
+			if (access("/testfile", F_OK))
+				_exit(22);
+
+			_exit(0);
+		}
+
+		_exit(wait_for_pid(inner));
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Multiple clone3 calls with CLONE_EMPTY_MNTNS produce children with
+ * distinct mount namespace root mount IDs.
+ */
+TEST_F(clone3_empty_mntns, repeated)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int pipe1[2], pipe2[2];
+		uint64_t id1 = 0, id2 = 0;
+		pid_t inner1, inner2;
+
+		if (enter_userns())
+			_exit(1);
+
+		if (pipe(pipe1) || pipe(pipe2))
+			_exit(2);
+
+		inner1 = clone3_empty_mntns(0);
+		if (inner1 < 0)
+			_exit(3);
+
+		if (inner1 == 0) {
+			uint64_t root_id;
+
+			close(pipe1[0]);
+			root_id = get_unique_mnt_id("/");
+			if (write(pipe1[1], &root_id, sizeof(root_id)) != sizeof(root_id))
+				_exit(1);
+			close(pipe1[1]);
+			_exit(0);
+		}
+
+		inner2 = clone3_empty_mntns(0);
+		if (inner2 < 0)
+			_exit(4);
+
+		if (inner2 == 0) {
+			uint64_t root_id;
+
+			close(pipe2[0]);
+			root_id = get_unique_mnt_id("/");
+			if (write(pipe2[1], &root_id, sizeof(root_id)) != sizeof(root_id))
+				_exit(1);
+			close(pipe2[1]);
+			_exit(0);
+		}
+
+		close(pipe1[1]);
+		close(pipe2[1]);
+
+		if (read(pipe1[0], &id1, sizeof(id1)) != sizeof(id1))
+			_exit(5);
+		if (read(pipe2[0], &id2, sizeof(id2)) != sizeof(id2))
+			_exit(6);
+
+		close(pipe1[0]);
+		close(pipe2[0]);
+
+		if (wait_for_pid(inner1) || wait_for_pid(inner2))
+			_exit(7);
+
+		/* Each child must have a distinct root mount ID. */
+		if (id1 == 0 || id2 == 0)
+			_exit(8);
+		if (id1 == id2)
+			_exit(9);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Verify setns() into a child's empty mount namespace works.
+ */
+TEST_F(clone3_empty_mntns, setns_into_child_mntns)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int pipe_fd[2];
+		pid_t inner;
+		char c;
+
+		if (enter_userns())
+			_exit(1);
+
+		if (pipe(pipe_fd))
+			_exit(2);
+
+		inner = clone3_empty_mntns(0);
+		if (inner < 0)
+			_exit(3);
+
+		if (inner == 0) {
+			/* Signal parent we're ready. */
+			close(pipe_fd[0]);
+			if (write(pipe_fd[1], "r", 1) != 1)
+				_exit(1);
+
+			/*
+			 * Wait for parent to finish.  Reading from our
+			 * write end will block until the parent closes
+			 * its read end, giving us an implicit barrier.
+			 */
+			if (read(pipe_fd[1], &c, 1) < 0)
+				;
+			close(pipe_fd[1]);
+			_exit(0);
+		}
+
+		close(pipe_fd[1]);
+
+		/* Wait for child to be ready. */
+		if (read(pipe_fd[0], &c, 1) != 1)
+			_exit(4);
+
+		/* Open child's mount namespace. */
+		{
+			char path[64];
+			int mntns_fd;
+
+			snprintf(path, sizeof(path), "/proc/%d/ns/mnt", inner);
+			mntns_fd = open(path, O_RDONLY);
+			if (mntns_fd < 0)
+				_exit(5);
+
+			if (setns(mntns_fd, CLONE_NEWNS))
+				_exit(6);
+
+			close(mntns_fd);
+		}
+
+		/* Now we should be in the child's empty mntns. */
+		if (count_mounts() != 1)
+			_exit(7);
+
+		close(pipe_fd[0]);
+		_exit(wait_for_pid(inner));
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Tests below do not require CLONE_EMPTY_MNTNS support.
+ */
+
+/*
+ * Unknown 64-bit flags beyond the known set are rejected.
+ */
+TEST(unknown_flags_rejected)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct __clone_args args = {
+			.flags		= 0x800000000ULL,
+			.exit_signal	= SIGCHLD,
+		};
+		pid_t ret;
+
+		ret = sys_clone3(&args, sizeof(args));
+		if (ret >= 0) {
+			if (ret == 0)
+				_exit(0);
+			wait_for_pid(ret);
+			_exit(1);
+		}
+
+		if (errno != EINVAL)
+			_exit(2);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Regular clone3 with CLONE_NEWNS (without CLONE_EMPTY_MNTNS) still
+ * copies the full mount tree.
+ */
+TEST(clone3_newns_full_copy)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct __clone_args args = {
+			.flags		= CLONE_NEWNS,
+			.exit_signal	= SIGCHLD,
+		};
+		ssize_t parent_mounts;
+		pid_t inner;
+
+		if (enter_userns())
+			_exit(1);
+
+		parent_mounts = count_mounts();
+		if (parent_mounts < 1)
+			_exit(2);
+
+		inner = sys_clone3(&args, sizeof(args));
+		if (inner < 0)
+			_exit(3);
+
+		if (inner == 0) {
+			/* Full copy should have at least as many mounts. */
+			if (count_mounts() < parent_mounts)
+				_exit(1);
+
+			_exit(0);
+		}
+
+		_exit(wait_for_pid(inner));
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3



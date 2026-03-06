Return-Path: <linux-fsdevel+bounces-79635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAZQGR4Cq2nDZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:34:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6B225040
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE04D3035247
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5F3EF0A3;
	Fri,  6 Mar 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFvgunA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58623F0744
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814528; cv=none; b=Q/Thf+V128jyzzGMBOlgOf4Qq35wPcRn8l/NPMtHSZf1KZNB+jDCgqaOFzsrPjpGJXrLS2tRazEAZyagA4wDUHwYNWwRGozLt/uIslYGOiBwcX0FCOh63kqmU0Dw9KkzF77o36B22MDzeaMPYdCPqX+Pa2u5qmkubevj+kprwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814528; c=relaxed/simple;
	bh=BLaH4TwDz1CK2ve2oshlKMk50zhFvwTPJmOy2GCiTlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=J6nKGPUbiHllW+L6CSDiDyZEyDgW0+KmLWGQ5XA/3NIHa6ISvJvBl5xWuf4lp0GxHJadnuktGgkj0vMt8tF8+iluTOlDS7RN0+OlVlDnj2KkZNI84Zq4aiMyAAxc8rQIxiGoxo1CX/d2KQQw9oUnxT5/Iqf1jKhfqvkX8CkmsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFvgunA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E516C2BC86;
	Fri,  6 Mar 2026 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772814527;
	bh=BLaH4TwDz1CK2ve2oshlKMk50zhFvwTPJmOy2GCiTlo=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=iFvgunA8f5xcjxk1EgjVc6UrLwVj/GqD1HkcnnTdF0siH0cUuwkckt7HDO37Jws8P
	 vwAP6OEA/7y30ac1oifQptfXb2GACqVpQN2e8Za0ZkDYXVb+N1zAG8jPIM8S/fvmk3
	 T/hpeL2/x1+6v0x5xVUUL4Y5w7YhXL5aezhuQma0fZiZZSLp/7ubOVkQ9Q4REXYwBg
	 +4DMoW+inUqixx3ADHoxx40g/q5HUvP5Ah1/n4l8Fm3Zt4aoXAx7D0cYwHXO2fmPxD
	 PHUCHE01SO2SRcT5ZSUiWTv4BYiXqbx7ru1sczT5vArbunSxw/nibjDebPLRiW9Uv8
	 OpYuxHZP0tYfA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 17:28:38 +0100
Subject: [PATCH 2/3] selftests/filesystems: add tests for empty mount
 namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-empty-mntns-consolidated-v1-2-6eb30529bbb0@kernel.org>
References: <20260306-work-empty-mntns-consolidated-v1-0-6eb30529bbb0@kernel.org>
In-Reply-To: <20260306-work-empty-mntns-consolidated-v1-0-6eb30529bbb0@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-e55a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=26175; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BLaH4TwDz1CK2ve2oshlKMk50zhFvwTPJmOy2GCiTlo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuZtghs3xpZt3HSVtnzrY29d3t4rK4kaVAOdr4SMW/V
 YffvN6f0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRWdoM/yyS5OJb+XQOFGTW
 MB5K449+3pe8+vmTrdX/VvR6FOZMsmf4zVocvLp/lZpMpexMfR1JyyxVDqZv6Qk9Ct8l9u768TK
 dEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: EDE6B225040
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79635-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a test suite for the UNSHARE_EMPTY_MNTNS and CLONE_EMPTY_MNTNS
flags exercising the empty mount namespace functionality through the
kselftest harness.

The tests cover:

- basic functionality: unshare succeeds, exactly one mount exists in
  the new namespace, root and cwd point to the same mount
- flag interactions: UNSHARE_EMPTY_MNTNS works standalone without
  explicit CLONE_NEWNS, combines correctly with CLONE_NEWUSER and
  other namespace flags (CLONE_NEWUTS, CLONE_NEWIPC)
- edge cases: EPERM without capabilities, works from a user namespace,
  many source mounts still result in one mount, cwd on a different
  mount gets reset to root
- error paths: invalid flags return EINVAL
- regression: plain CLONE_NEWNS still copies the full mount tree,
  other namespace unshares are unaffected
- mount properties: the root mount has the expected statmount
  properties, is its own parent, and is the only entry returned by
  listmount
- repeated unshare: consecutive UNSHARE_EMPTY_MNTNS calls each
  produce a new namespace with a distinct mount ID
- overmount workflow: verifies the intended usage pattern of creating
  an empty mount namespace with a nullfs root and then mounting tmpfs
  over it to build a writable filesystem from scratch

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/empty_mntns/.gitignore   |   3 +
 .../selftests/filesystems/empty_mntns/Makefile     |  11 +
 .../filesystems/empty_mntns/empty_mntns.h          |  50 ++
 .../filesystems/empty_mntns/empty_mntns_test.c     | 725 +++++++++++++++++++++
 .../empty_mntns/overmount_chroot_test.c            | 225 +++++++
 tools/testing/selftests/filesystems/utils.c        |   4 +-
 tools/testing/selftests/filesystems/utils.h        |   2 +
 7 files changed, 1018 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/empty_mntns/.gitignore b/tools/testing/selftests/filesystems/empty_mntns/.gitignore
new file mode 100644
index 000000000000..48054440b7e1
--- /dev/null
+++ b/tools/testing/selftests/filesystems/empty_mntns/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+empty_mntns_test
+overmount_chroot_test
diff --git a/tools/testing/selftests/filesystems/empty_mntns/Makefile b/tools/testing/selftests/filesystems/empty_mntns/Makefile
new file mode 100644
index 000000000000..5d4cffa4c4ae
--- /dev/null
+++ b/tools/testing/selftests/filesystems/empty_mntns/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+LDLIBS += -lcap
+
+TEST_GEN_PROGS := empty_mntns_test overmount_chroot_test
+
+include ../../lib.mk
+
+$(OUTPUT)/empty_mntns_test: ../utils.c
+$(OUTPUT)/overmount_chroot_test: ../utils.c
diff --git a/tools/testing/selftests/filesystems/empty_mntns/empty_mntns.h b/tools/testing/selftests/filesystems/empty_mntns/empty_mntns.h
new file mode 100644
index 000000000000..9e2d69e9d14a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/empty_mntns/empty_mntns.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef EMPTY_MNTNS_H
+#define EMPTY_MNTNS_H
+
+#include <errno.h>
+#include <stdlib.h>
+
+#include "../statmount/statmount.h"
+
+#ifndef UNSHARE_EMPTY_MNTNS
+#define UNSHARE_EMPTY_MNTNS	0x00100000
+#endif
+
+#ifndef CLONE_EMPTY_MNTNS
+#define CLONE_EMPTY_MNTNS	0x400000000ULL
+#endif
+
+static inline ssize_t count_mounts(void)
+{
+	uint64_t list[4096];
+
+	return listmount(LSMT_ROOT, 0, 0, list, sizeof(list) / sizeof(list[0]), 0);
+}
+
+static inline struct statmount *statmount_alloc(uint64_t mnt_id,
+						uint64_t mnt_ns_id,
+						uint64_t mask)
+{
+	size_t bufsize = 1 << 15;
+	struct statmount *buf;
+	int ret;
+
+	for (;;) {
+		buf = malloc(bufsize);
+		if (!buf)
+			return NULL;
+
+		ret = statmount(mnt_id, mnt_ns_id, 0, mask, buf, bufsize, 0);
+		if (ret == 0)
+			return buf;
+
+		free(buf);
+		if (errno != EOVERFLOW)
+			return NULL;
+
+		bufsize <<= 1;
+	}
+}
+
+#endif /* EMPTY_MNTNS_H */
diff --git a/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c b/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c
new file mode 100644
index 000000000000..733aad83dbbf
--- /dev/null
+++ b/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c
@@ -0,0 +1,725 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Tests for empty mount namespace creation via UNSHARE_EMPTY_MNTNS
+ *
+ * Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <linux/mount.h>
+#include <linux/stat.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../utils.h"
+#include "../wrappers.h"
+#include "empty_mntns.h"
+#include "kselftest_harness.h"
+
+static bool unshare_empty_mntns_supported(void)
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
+		if (unshare(UNSHARE_EMPTY_MNTNS) && errno == EINVAL)
+			_exit(1);
+		_exit(0);
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
+
+FIXTURE(empty_mntns) {};
+
+FIXTURE_SETUP(empty_mntns)
+{
+	if (!unshare_empty_mntns_supported())
+		SKIP(return, "UNSHARE_EMPTY_MNTNS not supported");
+}
+
+FIXTURE_TEARDOWN(empty_mntns) {}
+
+/* Verify unshare succeeds, produces exactly 1 mount, and root == cwd */
+TEST_F(empty_mntns, basic)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		uint64_t root_id, cwd_id;
+
+		if (enter_userns())
+			_exit(1);
+
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(2);
+
+		if (count_mounts() != 1)
+			_exit(3);
+
+		root_id = get_unique_mnt_id("/");
+		cwd_id = get_unique_mnt_id(".");
+		if (root_id == 0 || cwd_id == 0)
+			_exit(4);
+
+		if (root_id != cwd_id)
+			_exit(5);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * UNSHARE_EMPTY_MNTNS combined with CLONE_NEWUSER.
+ *
+ * The user namespace must be created first so /proc is still accessible
+ * for writing uid_map/gid_map.  The empty mount namespace is created
+ * afterwards.
+ */
+TEST_F(empty_mntns, with_clone_newuser)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		uid_t uid = getuid();
+		gid_t gid = getgid();
+		char map[100];
+
+		if (unshare(CLONE_NEWUSER))
+			_exit(1);
+
+		snprintf(map, sizeof(map), "0 %d 1", uid);
+		if (write_file("/proc/self/uid_map", map))
+			_exit(2);
+
+		if (write_file("/proc/self/setgroups", "deny"))
+			_exit(3);
+
+		snprintf(map, sizeof(map), "0 %d 1", gid);
+		if (write_file("/proc/self/gid_map", map))
+			_exit(4);
+
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(5);
+
+		if (count_mounts() != 1)
+			_exit(6);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/* UNSHARE_EMPTY_MNTNS combined with other namespace flags */
+TEST_F(empty_mntns, with_other_ns_flags)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		if (enter_userns())
+			_exit(1);
+
+		if (unshare(UNSHARE_EMPTY_MNTNS | CLONE_NEWUTS | CLONE_NEWIPC))
+			_exit(2);
+
+		if (count_mounts() != 1)
+			_exit(3);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/* EPERM without proper capabilities */
+TEST_F(empty_mntns, eperm_without_caps)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Skip if already root */
+		if (getuid() == 0)
+			_exit(0);
+
+		if (unshare(UNSHARE_EMPTY_MNTNS) == 0)
+			_exit(1);
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
+/* Many source mounts still result in exactly 1 mount */
+TEST_F(empty_mntns, many_source_mounts)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		char tmpdir[] = "/tmp/empty_mntns_test.XXXXXX";
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
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(9);
+
+		if (count_mounts() != 1)
+			_exit(10);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/* CWD on a different mount gets reset to root */
+TEST_F(empty_mntns, cwd_reset)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		char tmpdir[] = "/tmp/empty_mntns_cwd.XXXXXX";
+		uint64_t root_id, cwd_id;
+		struct statmount *sm;
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
+		if (chdir(tmpdir))
+			_exit(6);
+
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(7);
+
+		root_id = get_unique_mnt_id("/");
+		cwd_id = get_unique_mnt_id(".");
+		if (root_id == 0 || cwd_id == 0)
+			_exit(8);
+
+		if (root_id != cwd_id)
+			_exit(9);
+
+		sm = statmount_alloc(root_id, 0, STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT);
+		if (!sm)
+			_exit(10);
+
+		if (strcmp(sm->str + sm->mnt_point, "/") != 0)
+			_exit(11);
+
+		free(sm);
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/* Verify statmount properties of the root mount */
+TEST_F(empty_mntns, mount_properties)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct statmount *sm;
+		uint64_t root_id;
+
+		if (enter_userns())
+			_exit(1);
+
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(2);
+
+		root_id = get_unique_mnt_id("/");
+		if (!root_id)
+			_exit(3);
+
+		sm = statmount_alloc(root_id, 0, STATMOUNT_MNT_BASIC | STATMOUNT_MNT_ROOT |
+				     STATMOUNT_MNT_POINT | STATMOUNT_FS_TYPE);
+		if (!sm)
+			_exit(4);
+
+		if (!(sm->mask & STATMOUNT_MNT_POINT))
+			_exit(5);
+
+		if (strcmp(sm->str + sm->mnt_point, "/") != 0)
+			_exit(6);
+
+		if (!(sm->mask & STATMOUNT_MNT_BASIC))
+			_exit(7);
+
+		if (sm->mnt_id != root_id)
+			_exit(8);
+
+		free(sm);
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/* Consecutive UNSHARE_EMPTY_MNTNS calls produce new namespaces */
+TEST_F(empty_mntns, repeated_unshare)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		uint64_t first_root_id, second_root_id;
+
+		if (enter_userns())
+			_exit(1);
+
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(2);
+
+		if (count_mounts() != 1)
+			_exit(3);
+
+		first_root_id = get_unique_mnt_id("/");
+
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(4);
+
+		if (count_mounts() != 1)
+			_exit(5);
+
+		second_root_id = get_unique_mnt_id("/");
+
+		if (first_root_id == second_root_id)
+			_exit(6);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/* Root mount's parent is itself */
+TEST_F(empty_mntns, root_is_own_parent)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct statmount sm;
+		uint64_t root_id;
+
+		if (enter_userns())
+			_exit(1);
+
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(2);
+
+		root_id = get_unique_mnt_id("/");
+		if (!root_id)
+			_exit(3);
+
+		if (statmount(root_id, 0, 0, STATMOUNT_MNT_BASIC, &sm, sizeof(sm), 0) < 0)
+			_exit(4);
+
+		if (!(sm.mask & STATMOUNT_MNT_BASIC))
+			_exit(5);
+
+		if (sm.mnt_parent_id != sm.mnt_id)
+			_exit(6);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/* Listmount returns only the root mount */
+TEST_F(empty_mntns, listmount_single_entry)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		uint64_t list[16];
+		ssize_t nr_mounts;
+		uint64_t root_id;
+
+		if (enter_userns())
+			_exit(1);
+
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(2);
+
+		nr_mounts = listmount(LSMT_ROOT, 0, 0, list, 16, 0);
+		if (nr_mounts != 1)
+			_exit(3);
+
+		root_id = get_unique_mnt_id("/");
+		if (!root_id)
+			_exit(4);
+
+		if (list[0] != root_id)
+			_exit(5);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Mount tmpfs over nullfs root to build a writable filesystem from scratch.
+ * This exercises the intended usage pattern: create an empty mount namespace
+ * (which has a nullfs root), then mount a real filesystem over it.
+ *
+ * Because resolving "/" returns the process root directly (via nd_jump_root)
+ * without following overmounts, we use the new mount API (fsopen/fsmount)
+ * to obtain a mount fd, then fchdir + chroot to enter the new filesystem.
+ */
+TEST_F(empty_mntns, overmount_tmpfs)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct statmount *sm;
+		uint64_t root_id, cwd_id;
+		int fd, fsfd, mntfd;
+
+		if (enter_userns())
+			_exit(1);
+
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(2);
+
+		if (count_mounts() != 1)
+			_exit(3);
+
+		root_id = get_unique_mnt_id("/");
+		if (!root_id)
+			_exit(4);
+
+		/* Verify root is nullfs */
+		sm = statmount_alloc(root_id, 0, STATMOUNT_FS_TYPE);
+		if (!sm)
+			_exit(5);
+
+		if (!(sm->mask & STATMOUNT_FS_TYPE))
+			_exit(6);
+
+		if (strcmp(sm->str + sm->fs_type, "nullfs") != 0)
+			_exit(7);
+
+		free(sm);
+
+		cwd_id = get_unique_mnt_id(".");
+		if (!cwd_id || root_id != cwd_id)
+			_exit(8);
+
+		/*
+		 * nullfs root is immutable.  open(O_CREAT) returns ENOENT
+		 * because empty_dir_lookup() returns -ENOENT before the
+		 * IS_IMMUTABLE permission check in may_o_create() is reached.
+		 */
+		fd = open("/test", O_CREAT | O_RDWR, 0644);
+		if (fd >= 0) {
+			close(fd);
+			_exit(9);
+		}
+		if (errno != ENOENT)
+			_exit(10);
+
+		/*
+		 * Use the new mount API to create tmpfs and get a mount fd.
+		 * We need the fd because after attaching the tmpfs on top of
+		 * "/", path resolution of "/" still returns the process root
+		 * (nullfs) without following the overmount.  The mount fd
+		 * lets us fchdir + chroot into the tmpfs.
+		 */
+		fsfd = sys_fsopen("tmpfs", 0);
+		if (fsfd < 0)
+			_exit(11);
+
+		if (sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "size", "1M", 0)) {
+			close(fsfd);
+			_exit(12);
+		}
+
+		if (sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)) {
+			close(fsfd);
+			_exit(13);
+		}
+
+		mntfd = sys_fsmount(fsfd, 0, 0);
+		close(fsfd);
+		if (mntfd < 0)
+			_exit(14);
+
+		if (sys_move_mount(mntfd, "", AT_FDCWD, "/",
+				   MOVE_MOUNT_F_EMPTY_PATH)) {
+			close(mntfd);
+			_exit(15);
+		}
+
+		if (count_mounts() != 2) {
+			close(mntfd);
+			_exit(16);
+		}
+
+		/* Enter the tmpfs via the mount fd */
+		if (fchdir(mntfd)) {
+			close(mntfd);
+			_exit(17);
+		}
+
+		if (chroot(".")) {
+			close(mntfd);
+			_exit(18);
+		}
+
+		close(mntfd);
+
+		/* Verify "/" now resolves to tmpfs */
+		root_id = get_unique_mnt_id("/");
+		if (!root_id)
+			_exit(19);
+
+		sm = statmount_alloc(root_id, 0, STATMOUNT_FS_TYPE);
+		if (!sm)
+			_exit(20);
+
+		if (!(sm->mask & STATMOUNT_FS_TYPE))
+			_exit(21);
+
+		if (strcmp(sm->str + sm->fs_type, "tmpfs") != 0)
+			_exit(22);
+
+		free(sm);
+
+		/* Verify tmpfs is writable */
+		fd = open("/testfile", O_CREAT | O_RDWR, 0644);
+		if (fd < 0)
+			_exit(23);
+
+		if (write(fd, "test", 4) != 4) {
+			close(fd);
+			_exit(24);
+		}
+
+		close(fd);
+
+		if (access("/testfile", F_OK))
+			_exit(25);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/*
+ * Tests below do not require UNSHARE_EMPTY_MNTNS support.
+ */
+
+/* Invalid unshare flags return EINVAL */
+TEST(invalid_flags)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		if (enter_userns())
+			_exit(1);
+
+		if (unshare(0x80000000) == 0)
+			_exit(2);
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
+/* Regular CLONE_NEWNS still copies the full mount tree */
+TEST(clone_newns_full_copy)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ssize_t nr_mounts_before, nr_mounts_after;
+		char tmpdir[] = "/tmp/empty_mntns_regr.XXXXXX";
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
+		for (i = 0; i < 3; i++) {
+			char subdir[256];
+
+			snprintf(subdir, sizeof(subdir), "%s/sub%d", tmpdir, i);
+			if (mkdir(subdir, 0755) && errno != EEXIST)
+				_exit(6);
+			if (mount(subdir, subdir, NULL, MS_BIND, NULL))
+				_exit(7);
+		}
+
+		nr_mounts_before = count_mounts();
+		if (nr_mounts_before < 3)
+			_exit(8);
+
+		if (unshare(CLONE_NEWNS))
+			_exit(9);
+
+		nr_mounts_after = count_mounts();
+		if (nr_mounts_after < nr_mounts_before)
+			_exit(10);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/* Other namespace unshares are unaffected */
+TEST(other_ns_unaffected)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		char hostname[256];
+
+		if (enter_userns())
+			_exit(1);
+
+		if (unshare(CLONE_NEWUTS))
+			_exit(2);
+
+		if (sethostname("test-empty-mntns", 16))
+			_exit(3);
+
+		if (gethostname(hostname, sizeof(hostname)))
+			_exit(4);
+
+		if (strcmp(hostname, "test-empty-mntns") != 0)
+			_exit(5);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c b/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c
new file mode 100644
index 000000000000..0b623d0c6bb9
--- /dev/null
+++ b/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Test: rootfs overmounted multiple times with chroot into topmost
+ *
+ * This test creates a scenario where:
+ * 1. A new mount namespace is created with a tmpfs root (via pivot_root)
+ * 2. A mountpoint is created and overmounted multiple times
+ * 3. The caller chroots into the topmost mount layer
+ *
+ * The test verifies that:
+ * - Multiple overmounts create separate mount layers
+ * - Each layer's files are isolated
+ * - chroot correctly sets the process's root to the topmost layer
+ * - After chroot, only the topmost layer's files are visible
+ *
+ * Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <linux/mount.h>
+#include <linux/stat.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../utils.h"
+#include "empty_mntns.h"
+#include "kselftest_harness.h"
+
+#define NR_OVERMOUNTS 5
+
+/*
+ * Setup a proper root filesystem using pivot_root.
+ * This ensures we own the root directory in our user namespace.
+ */
+static int setup_root(void)
+{
+	char tmpdir[] = "/tmp/overmount_test.XXXXXX";
+	char oldroot[256];
+
+	if (!mkdtemp(tmpdir))
+		return -1;
+
+	/* Mount tmpfs at the temporary directory */
+	if (mount("tmpfs", tmpdir, "tmpfs", 0, "size=10M"))
+		return -1;
+
+	/* Create directory for old root */
+	snprintf(oldroot, sizeof(oldroot), "%s/oldroot", tmpdir);
+	if (mkdir(oldroot, 0755))
+		return -1;
+
+	/* pivot_root to use the tmpfs as new root */
+	if (syscall(SYS_pivot_root, tmpdir, oldroot))
+		return -1;
+
+	if (chdir("/"))
+		return -1;
+
+	/* Unmount old root */
+	if (umount2("/oldroot", MNT_DETACH))
+		return -1;
+
+	/* Remove oldroot directory */
+	if (rmdir("/oldroot"))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * Test scenario:
+ * 1. Enter a user namespace to gain CAP_SYS_ADMIN
+ * 2. Create a new mount namespace
+ * 3. Setup a tmpfs root via pivot_root
+ * 4. Create a mountpoint /newroot and overmount it multiple times
+ * 5. Create a marker file in each layer
+ * 6. Chroot into /newroot (the topmost overmount)
+ * 7. Verify we're in the topmost layer (only topmost marker visible)
+ */
+TEST(overmount_chroot)
+{
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ssize_t nr_mounts;
+		uint64_t mnt_ids[NR_OVERMOUNTS + 1];
+		uint64_t root_id_before, root_id_after;
+		struct statmount *sm;
+		char marker[64];
+		int fd, i;
+
+		/* Step 1: Enter user namespace for privileges */
+		if (enter_userns())
+			_exit(1);
+
+		/* Step 2: Create a new mount namespace */
+		if (unshare(CLONE_NEWNS))
+			_exit(2);
+
+		/* Step 3: Make the mount tree private */
+		if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL))
+			_exit(3);
+
+		/* Step 4: Setup a proper tmpfs root via pivot_root */
+		if (setup_root())
+			_exit(4);
+
+		/* Create the base mount point for overmounting */
+		if (mkdir("/newroot", 0755))
+			_exit(5);
+
+		/* Mount base tmpfs on /newroot */
+		if (mount("tmpfs", "/newroot", "tmpfs", 0, "size=1M"))
+			_exit(6);
+
+		/* Record base mount ID */
+		mnt_ids[0] = get_unique_mnt_id("/newroot");
+		if (!mnt_ids[0])
+			_exit(7);
+
+		/* Create marker in base layer */
+		fd = open("/newroot/layer_0", O_CREAT | O_RDWR, 0644);
+		if (fd < 0)
+			_exit(8);
+		if (write(fd, "layer_0", 7) != 7) {
+			close(fd);
+			_exit(9);
+		}
+		close(fd);
+
+		/* Step 5: Overmount /newroot multiple times with tmpfs */
+		for (i = 0; i < NR_OVERMOUNTS; i++) {
+			if (mount("tmpfs", "/newroot", "tmpfs", 0, "size=1M"))
+				_exit(10);
+
+			/* Record mount ID for this layer */
+			mnt_ids[i + 1] = get_unique_mnt_id("/newroot");
+			if (!mnt_ids[i + 1])
+				_exit(11);
+
+			/* Create a marker file in each layer */
+			snprintf(marker, sizeof(marker), "/newroot/layer_%d", i + 1);
+			fd = open(marker, O_CREAT | O_RDWR, 0644);
+			if (fd < 0)
+				_exit(12);
+
+			if (write(fd, marker, strlen(marker)) != (ssize_t)strlen(marker)) {
+				close(fd);
+				_exit(13);
+			}
+			close(fd);
+		}
+
+		/* Verify mount count increased */
+		nr_mounts = count_mounts();
+		if (nr_mounts < NR_OVERMOUNTS + 2)
+			_exit(14);
+
+		/* Record root mount ID before chroot */
+		root_id_before = get_unique_mnt_id("/newroot");
+
+		/* Verify this is the topmost layer's mount */
+		if (root_id_before != mnt_ids[NR_OVERMOUNTS])
+			_exit(15);
+
+		/* Step 6: Chroot into /newroot (the topmost overmount) */
+		if (chroot("/newroot"))
+			_exit(16);
+
+		/* Change to root directory within the chroot */
+		if (chdir("/"))
+			_exit(17);
+
+		/* Step 7: Verify we're in the topmost layer */
+		root_id_after = get_unique_mnt_id("/");
+
+		/* The mount ID should be the same as the topmost layer */
+		if (root_id_after != mnt_ids[NR_OVERMOUNTS])
+			_exit(18);
+
+		/* Verify the topmost layer's marker file exists */
+		snprintf(marker, sizeof(marker), "/layer_%d", NR_OVERMOUNTS);
+		if (access(marker, F_OK))
+			_exit(19);
+
+		/* Verify we cannot see markers from lower layers (they're hidden) */
+		for (i = 0; i < NR_OVERMOUNTS; i++) {
+			snprintf(marker, sizeof(marker), "/layer_%d", i);
+			if (access(marker, F_OK) == 0)
+				_exit(20);
+		}
+
+		/* Verify the root mount is tmpfs */
+		sm = statmount_alloc(root_id_after, 0,
+				     STATMOUNT_MNT_BASIC | STATMOUNT_MNT_ROOT |
+				     STATMOUNT_MNT_POINT | STATMOUNT_FS_TYPE);
+		if (!sm)
+			_exit(21);
+
+		if (sm->mask & STATMOUNT_FS_TYPE) {
+			if (strcmp(sm->str + sm->fs_type, "tmpfs") != 0) {
+				free(sm);
+				_exit(22);
+			}
+		}
+
+		free(sm);
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index d6f26f849053..d73d7d8171db 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -158,7 +158,7 @@ static int get_userns_fd_cb(void *data)
 	_exit(0);
 }
 
-static int wait_for_pid(pid_t pid)
+int wait_for_pid(pid_t pid)
 {
 	int status, ret;
 
@@ -450,7 +450,7 @@ static int create_userns_hierarchy(struct userns_hierarchy *h)
 	return fret;
 }
 
-static int write_file(const char *path, const char *val)
+int write_file(const char *path, const char *val)
 {
 	int fd = open(path, O_WRONLY);
 	size_t len = strlen(val);
diff --git a/tools/testing/selftests/filesystems/utils.h b/tools/testing/selftests/filesystems/utils.h
index 0bccfed666a9..d03085cef5cb 100644
--- a/tools/testing/selftests/filesystems/utils.h
+++ b/tools/testing/selftests/filesystems/utils.h
@@ -44,6 +44,8 @@ static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
 	return true;
 }
 
+extern int wait_for_pid(pid_t pid);
+extern int write_file(const char *path, const char *val);
 extern uint64_t get_unique_mnt_id(const char *path);
 
 #endif /* __IDMAP_UTILS_H */

-- 
2.47.3



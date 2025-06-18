Return-Path: <linux-fsdevel+bounces-52130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC293ADF824
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACB8189868A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A9D21FF26;
	Wed, 18 Jun 2025 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Maq3YvLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C351921E0B7
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280062; cv=none; b=j1CD+n+BN6m1y0ZP5kudAMahEbFwJsCinYhGgEY0tX4Xevmmx6jJqv5lQIqatbDPibU4Q3JyKWyMUhDMTgBQiI4/fdBdERwAD9NegFkjECnZiNyI07331pAxt8zaqCprpLYOkB8Emj7JDBsDJ03wwa0Ddhu4JsonYpdYX+2PjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280062; c=relaxed/simple;
	bh=KMvpAWSodoSsrtpouN04b6OOcS21wvgJb7lhmUpwii8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLKpRgASpye2RIg3f1MkFALYZ9Lrkmi1BP7Og3ly4rwrL1OhGSvjnzczkKwRHMdl4UCzvxktF3UnbkRGnntJOHZT/UgsnArfQ9zRCirZmZs6cmeIzZ33P7zF/8obIQlMrIbvOPZpO27yoqB8J8LdwcWruHvYQujK2Bp8GtC003U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Maq3YvLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134A4C4CEED;
	Wed, 18 Jun 2025 20:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280062;
	bh=KMvpAWSodoSsrtpouN04b6OOcS21wvgJb7lhmUpwii8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Maq3YvLdKvb+ndYq6XyhQnuEuiKo5l3r/2KOXRWIflNMqum0VeYz4bKr/205zVDEf
	 iL9qjgPvJLaXlD/wwDoYpj62AtOtsR+zG7gxGFHOViGJABgemBraTkNpptwmgCiT/s
	 2otccj+FY1m4BEIinwbHNdPg3j+rCeK887F7CVnM9FNAgqcN058rnu96wuHybrZSeL
	 j9294Whky8t55o6nTLlo0uPNSGBrRLPxJ0i7QqJLvsrP7O0NDkjquACfRebXbvf2xI
	 eAFQVixlKWNnS5tkodFTb/InhqXU6ANyEsnLdexrdWeUdOagDgJyAzizsI5Oq8yOhb
	 Vj9GMuFfo7YMg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:47 +0200
Subject: [PATCH v2 13/16] selftests/pidfd: test extended attribute support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-13-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4174; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KMvpAWSodoSsrtpouN04b6OOcS21wvgJb7lhmUpwii8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0f6nTlo7HnxQqH6Vs4HjSsjlPN7NXqefzvrvbs0U
 PDgjmOPOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi/Yvhn9qRZdFPohlWm5xv
 s/J//pLXS1ilvy9GUGOVvKHUppbiJQz/rE60xEVtL6/XrPsZ1a8jF1mmOnHKi9qPKRyWXMbKs2O
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add tests for extended attribute support on pidfds.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore         |  1 +
 tools/testing/selftests/pidfd/Makefile           |  3 +-
 tools/testing/selftests/pidfd/pidfd_xattr_test.c | 97 ++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index 0406a065deb4..bc4130506eda 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -10,3 +10,4 @@ pidfd_file_handle_test
 pidfd_bind_mount
 pidfd_info_test
 pidfd_exec_helper
+pidfd_xattr_test
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index fcbefc0d77f6..c9fd5023ef15 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -3,7 +3,8 @@ CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
-	pidfd_file_handle_test pidfd_bind_mount pidfd_info_test
+	pidfd_file_handle_test pidfd_bind_mount pidfd_info_test \
+	pidfd_xattr_test
 
 TEST_GEN_PROGS_EXTENDED := pidfd_exec_helper
 
diff --git a/tools/testing/selftests/pidfd/pidfd_xattr_test.c b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
new file mode 100644
index 000000000000..00d400ac515b
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <poll.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <linux/kcmp.h>
+#include <sys/stat.h>
+#include <sys/xattr.h>
+
+#include "pidfd.h"
+#include "../kselftest_harness.h"
+
+FIXTURE(pidfs_xattr)
+{
+	pid_t child_pid;
+	int child_pidfd;
+};
+
+FIXTURE_SETUP(pidfs_xattr)
+{
+	self->child_pid = create_child(&self->child_pidfd, CLONE_NEWUSER | CLONE_NEWPID);
+	EXPECT_GE(self->child_pid, 0);
+
+	if (self->child_pid == 0)
+		_exit(EXIT_SUCCESS);
+}
+
+FIXTURE_TEARDOWN(pidfs_xattr)
+{
+	sys_waitid(P_PID, self->child_pid, NULL, WEXITED);
+}
+
+TEST_F(pidfs_xattr, set_get_list_xattr_multiple)
+{
+	int ret, i;
+	char xattr_name[32];
+	char xattr_value[32];
+	char buf[32];
+	const int num_xattrs = 10;
+	char list[PATH_MAX] = {};
+
+	for (i = 0; i < num_xattrs; i++) {
+		snprintf(xattr_name, sizeof(xattr_name), "trusted.testattr%d", i);
+		snprintf(xattr_value, sizeof(xattr_value), "testvalue%d", i);
+		ret = fsetxattr(self->child_pidfd, xattr_name, xattr_value, strlen(xattr_value), 0);
+		ASSERT_EQ(ret, 0);
+	}
+
+	for (i = 0; i < num_xattrs; i++) {
+		snprintf(xattr_name, sizeof(xattr_name), "trusted.testattr%d", i);
+		snprintf(xattr_value, sizeof(xattr_value), "testvalue%d", i);
+		memset(buf, 0, sizeof(buf));
+		ret = fgetxattr(self->child_pidfd, xattr_name, buf, sizeof(buf));
+		ASSERT_EQ(ret, strlen(xattr_value));
+		ASSERT_EQ(strcmp(buf, xattr_value), 0);
+	}
+
+	ret = flistxattr(self->child_pidfd, list, sizeof(list));
+	ASSERT_GT(ret, 0);
+	for (i = 0; i < num_xattrs; i++) {
+		snprintf(xattr_name, sizeof(xattr_name), "trusted.testattr%d", i);
+		bool found = false;
+		for (char *it = list; it < list + ret; it += strlen(it) + 1) {
+			if (strcmp(it, xattr_name))
+				continue;
+			found = true;
+			break;
+		}
+		ASSERT_TRUE(found);
+	}
+
+	for (i = 0; i < num_xattrs; i++) {
+		snprintf(xattr_name, sizeof(xattr_name), "trusted.testattr%d", i);
+		ret = fremovexattr(self->child_pidfd, xattr_name);
+		ASSERT_EQ(ret, 0);
+
+		ret = fgetxattr(self->child_pidfd, xattr_name, buf, sizeof(buf));
+		ASSERT_EQ(ret, -1);
+		ASSERT_EQ(errno, ENODATA);
+	}
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.2



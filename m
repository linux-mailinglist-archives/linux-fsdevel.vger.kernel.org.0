Return-Path: <linux-fsdevel+bounces-51940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17E2ADD2EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14287AAECE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B6D2EE5FA;
	Tue, 17 Jun 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnROnnxi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5F2E92BC
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175143; cv=none; b=PXYkWSNUTFyBoTzra43DEhDjsuGDg/eg5Nr7x0WIruCsthhGDR62jxoa0ultbUfJFojBR3cYKR9JjKUdrPN6NanHqxcyHPYPnq9hL2U8MxiBeslntkYf59zJzXrtbl1OYe3ZXFDtGAvfDR48DQLFknuFyYcCaI7jstKbnQs0zCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175143; c=relaxed/simple;
	bh=W4Z5v6mI8jm1Nj/+ZjgHLfhbbC8XiVN2M2XGtS/xh8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UewpzA+HUKw/HWCJhCYMJsiWnq3mN3WQt9y2ScrHnGMH+HI4Zn6GitReBo/71IWO14/chL3M+OD5a99cbz4n+o+dWAIYzTRKFouUgFsoi25R5xt01zKLHIwEOAVLmzlIckW+jwRXIa6d3c4Yjep7XaQTJLvjOQTrwR9bZpgwaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnROnnxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEC9C4CEF0;
	Tue, 17 Jun 2025 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750175142;
	bh=W4Z5v6mI8jm1Nj/+ZjgHLfhbbC8XiVN2M2XGtS/xh8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XnROnnxihibTI37jXRuurrAvl+3IptHVwKuGTTVuMsZz+gJ7J26wepvfpwheb179p
	 6O1+oUaFq4S1E9+RqGd0r0zRVKoUJPEtarG/cCKjFMPinz9BYgQ/wOCM+kjAD6R6Sy
	 /1Ahc+vhGAIqQGeluc4qan1m7IK0tWZYz1TEtwuzzZD0QUu42hdGNKiMS7H1TakjEC
	 JmhC5gaRT3csVFg8xS3aWqvJjXvoSAVKYdKT369XQQloGFUG52pfvTr8yOZz2T1p4/
	 4Tf6Q8BBO4pIlyMgJqYm1GkK3GoePsjNa27J16sEzLyF+OhV8/QcWNgL/4C5Lx+kB3
	 winqjxeG58MKw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Jun 2025 17:45:17 +0200
Subject: [PATCH RFC 7/7] selftests/pidfd: test setattr support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-work-pidfs-xattr-v1-7-d9466a20da2e@kernel.org>
References: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094; i=brauner@kernel.org;
 h=from:subject:message-id; bh=W4Z5v6mI8jm1Nj/+ZjgHLfhbbC8XiVN2M2XGtS/xh8E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9k7cVPnfauK596a3fppOKuoXZkpc9HVBdZt3XunVk
 KuthzJrOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbC18fIMH3htNYtx6+9XW/a
 xsEQdTpZh+HJtAKXSuG1z3R9My4HXWRkuPPSyanJJE6NZX7jWi1ftr+Jd91WVr5RfZW/gP3v4sh
 93AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Verify that ->setattr() on a pidfd doens't work.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore           |  1 +
 tools/testing/selftests/pidfd/Makefile             |  2 +-
 tools/testing/selftests/pidfd/pidfd_setattr_test.c | 69 ++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index bc4130506eda..144e7ff65d6a 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -11,3 +11,4 @@ pidfd_bind_mount
 pidfd_info_test
 pidfd_exec_helper
 pidfd_xattr_test
+pidfd_setattr_test
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index c9fd5023ef15..03a6eede9c9e 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
 	pidfd_file_handle_test pidfd_bind_mount pidfd_info_test \
-	pidfd_xattr_test
+	pidfd_xattr_test pidfd_setattr_test
 
 TEST_GEN_PROGS_EXTENDED := pidfd_exec_helper
 
diff --git a/tools/testing/selftests/pidfd/pidfd_setattr_test.c b/tools/testing/selftests/pidfd/pidfd_setattr_test.c
new file mode 100644
index 000000000000..d7de05edc4b3
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_setattr_test.c
@@ -0,0 +1,69 @@
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
+FIXTURE(pidfs_setattr)
+{
+	pid_t child_pid;
+	int child_pidfd;
+};
+
+FIXTURE_SETUP(pidfs_setattr)
+{
+	self->child_pid = create_child(&self->child_pidfd, CLONE_NEWUSER | CLONE_NEWPID);
+	EXPECT_GE(self->child_pid, 0);
+
+	if (self->child_pid == 0)
+		_exit(EXIT_SUCCESS);
+}
+
+FIXTURE_TEARDOWN(pidfs_setattr)
+{
+	sys_waitid(P_PID, self->child_pid, NULL, WEXITED);
+	EXPECT_EQ(close(self->child_pidfd), 0);
+}
+
+TEST_F(pidfs_setattr, no_chown)
+{
+	ASSERT_LT(fchown(self->child_pidfd, 1234, 5678), 0);
+	ASSERT_EQ(errno, EOPNOTSUPP);
+}
+
+TEST_F(pidfs_setattr, no_chmod)
+{
+	ASSERT_LT(fchmod(self->child_pidfd, 0777), 0);
+	ASSERT_EQ(errno, EOPNOTSUPP);
+}
+
+TEST_F(pidfs_setattr, no_exec)
+{
+	char *const argv[] = { NULL };
+	char *const envp[] = { NULL };
+
+	ASSERT_LT(execveat(self->child_pidfd, "", argv, envp, AT_EMPTY_PATH), 0);
+	ASSERT_EQ(errno, EACCES);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.2



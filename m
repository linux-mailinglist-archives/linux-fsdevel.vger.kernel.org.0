Return-Path: <linux-fsdevel+bounces-52132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B771FADF826
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2B41BC32BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB2B21FF54;
	Wed, 18 Jun 2025 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHNWrdO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB59121FF3C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280068; cv=none; b=TXnxS/DtVpZjy0h0B9ojUc6Rdext63SkxUBi33tOqioJuJG5yTBD6P9JIr9uv8jaVgYATGaGA/1Y+XN6zT7jf+MeKGpoIXAa5PxnuFsTH5ECFY98TU5TYKOonbxDu5sEWtvIFz6+oExLx2TxzvqqSi0qdCdT8h4BRUXX8hArO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280068; c=relaxed/simple;
	bh=W4Z5v6mI8jm1Nj/+ZjgHLfhbbC8XiVN2M2XGtS/xh8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Evsa0Rf9EHuYURJvRIuNIyMacR5RVUwZE89cKBpmdkX+WKekwE0ECgKHy56RxFFOQpYjEnD09spw2LwA+LhSLzbBSyfTm2lIT4FcYc8+nB+e/bWwbQ6quFgWAHKTWXZ5F8L9cTLqTEZ/d0YsHR1qJWYPIx12RG2rU+XP6Dr/50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHNWrdO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C8DC4CEED;
	Wed, 18 Jun 2025 20:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280067;
	bh=W4Z5v6mI8jm1Nj/+ZjgHLfhbbC8XiVN2M2XGtS/xh8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZHNWrdO6lGpyKnQmhH0QGuCvOOiLaNcLUM/To8RXA7dvSdslL2Bl4l8/oxwiYIhCL
	 oKCmfTdfnPHlxYJSnOnj/CY0cnzuhNoSuQM22EH/PN1E/Sk2GU21eAfrWyyx1FybfR
	 gYwDkpVTDkgSdHSeXNfA+du2c6sBymb6Slp5teRUOhdOr8eK6h6GtrRcFQAgC1OEiA
	 JBB1aw0FRoW2Ml2UvuXhLu1b0mbAqhUN+mOGVENiKDOvk1TB8GZDQHWLDEn+FQnGas
	 PKS6Ws2QN5WYISujJIinS+Af2y7ZmyIL0xni3RW8JRMpdnmuenVPPgNVyey4vN7PnG
	 8B9vE0ksoM+iQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:49 +0200
Subject: [PATCH v2 15/16] selftests/pidfd: test setattr support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-15-98f3456fd552@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094; i=brauner@kernel.org;
 h=from:subject:message-id; bh=W4Z5v6mI8jm1Nj/+ZjgHLfhbbC8XiVN2M2XGtS/xh8E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0d6Net9Wrv1lxFLRaC81NundoZmD5cH+OVkd0uf+
 PymqmJLRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERCXjIyzNCQffUv8ao1b+7E
 01zqabIy3w6rie7UMvu8ROfagUDjTwz/9Ir0XhxvDbx1v7zHo6rE5vpEc1vpM4tMNDrO6z6de+U
 kDwA=
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



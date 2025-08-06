Return-Path: <linux-fsdevel+bounces-56873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F00B1CB7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0690818C33C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C32BD025;
	Wed,  6 Aug 2025 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="M3u0mtN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148B2BCF5D;
	Wed,  6 Aug 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502948; cv=none; b=Wx+XX6QYWuZeLyc48k7FI3wyT14sfmRX1+CW+7zsvn7J/lO0ffogdopnR6VTTAOQFfksiKbvBZEtasrGVmVbnXLejwkrY41N+KryRWppDyKGLW0KCEs4fdNlJl2Zv6GQ/mJsJki6ANabTmyA5daGxINRCUSQQWctZClPwDM1XRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502948; c=relaxed/simple;
	bh=YfzESCjmw7efFV3Bycvd9p6+JMPz/pBQ3JyWrH1QtCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EeAdO4UMYtZTWgiDyNQ43LR1Pc7WdsuSm2Enftoi+jTuT2C+rHmAA9P4lf9Qq44Ihpd3hau2gMvJQ4nDIqJpr1HBd2u0tA7wBBz2JQLZSPLPD3e3vr0IWrm3ch3JpzTYg+PbhdEmg9eKuFSnspb1vfIt0kEvIJyluAamc+Z+ZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=M3u0mtN8; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bxyd95hCLz9tmC;
	Wed,  6 Aug 2025 19:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgHcJ8FhweBKsT5Y/D492w6gSm+YeJZzSPhVUGFdD20=;
	b=M3u0mtN8SUXUZdMrfkndbmCAWNckXJ1hVWL8pWTn0sSKc1gnbIhV7sEjDO7ojFIkXF3XJu
	+YSeuwWop84DbMG4rQ+0Y+sZShOh7lIRW24eFgWlIu+fkQy+6a3qfOCY2Nu20er/x/ZopH
	yXAfOFBlw9NOZR9DQEjYV/592tvIyA0617v1zdzBtwVijOtcrG72LpvkETZFDLt/O8b3F+
	NzRpbnIJh4/1HvRe3fpwqahqkpZxIivt2tZ7w/DPJk9B0YwRwXcV49lZPI+a/TMD9UguJd
	GlUXNK2o3gNg43xWk1FMojyfFW73vw4ArusAr2sifhfJtyke2p14gUgPVNMhhw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:55:24 +1000
Subject: [PATCH v3 2/2] selftests/filesystems: add basic fscontext log
 tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-fscontext-log-cleanups-v3-2-8d91d6242dc3@cyphar.com>
References: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
In-Reply-To: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5274; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=YfzESCjmw7efFV3Bycvd9p6+JMPz/pBQ3JyWrH1QtCo=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMns6/VGvj81OTt9x+yjlPIjT5+pOrtowLP96Pa7X6G
 TVj6WFG8Y5SFgYxLgZZMUWWbX6eoZvmL76S/GklG8wcViaQIQxcnAIwEYtVDP/ju2tfL3/Nsv7N
 u5XsH9q/SjGGpnpt9vtx5ccizq3n+/4sYWS4lqc/PZKtVSO9PrfxVzz71ev+NlFBNXdOuL49e9p
 z2RFWAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/filesystems/.gitignore |   1 +
 tools/testing/selftests/filesystems/Makefile   |   2 +-
 tools/testing/selftests/filesystems/fclog.c    | 130 +++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index fcbdb1297e24..64ac0dfa46b7 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dnotify_test
 devpts_pts
+fclog
 file_stressor
 anon_inode_test
 kernfs_test
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 73d4650af1a5..85427d7f19b9 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test
+TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/fclog.c b/tools/testing/selftests/filesystems/fclog.c
new file mode 100644
index 000000000000..912a8b755c3b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fclog.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2025 SUSE LLC.
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mount.h>
+
+#include "../kselftest_harness.h"
+
+#define ASSERT_ERRNO(expected, _t, seen)				\
+	__EXPECT(expected, #expected,					\
+		({__typeof__(seen) _tmp_seen = (seen);			\
+		  _tmp_seen >= 0 ? _tmp_seen : -errno; }), #seen, _t, 1)
+
+#define ASSERT_ERRNO_EQ(expected, seen) \
+	ASSERT_ERRNO(expected, ==, seen)
+
+#define ASSERT_SUCCESS(seen) \
+	ASSERT_ERRNO(0, <=, seen)
+
+FIXTURE(ns)
+{
+	int host_mntns;
+};
+
+FIXTURE_SETUP(ns)
+{
+	/* Stash the old mntns. */
+	self->host_mntns = open("/proc/self/ns/mnt", O_RDONLY|O_CLOEXEC);
+	ASSERT_SUCCESS(self->host_mntns);
+
+	/* Create a new mount namespace and make it private. */
+	ASSERT_SUCCESS(unshare(CLONE_NEWNS));
+	ASSERT_SUCCESS(mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL));
+}
+
+FIXTURE_TEARDOWN(ns)
+{
+	ASSERT_SUCCESS(setns(self->host_mntns, CLONE_NEWNS));
+	ASSERT_SUCCESS(close(self->host_mntns));
+}
+
+TEST_F(ns, fscontext_log_enodata)
+{
+	int fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
+	ASSERT_SUCCESS(fsfd);
+
+	/* A brand new fscontext has no log entries. */
+	char buf[128] = {};
+	for (int i = 0; i < 16; i++)
+		ASSERT_ERRNO_EQ(-ENODATA, read(fsfd, buf, sizeof(buf)));
+
+	ASSERT_SUCCESS(close(fsfd));
+}
+
+TEST_F(ns, fscontext_log_errorfc)
+{
+	int fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
+	ASSERT_SUCCESS(fsfd);
+
+	ASSERT_ERRNO_EQ(-EINVAL, fsconfig(fsfd, FSCONFIG_SET_STRING, "invalid-arg", "123", 0));
+
+	char buf[128] = {};
+	ASSERT_SUCCESS(read(fsfd, buf, sizeof(buf)));
+	EXPECT_STREQ("e tmpfs: Unknown parameter 'invalid-arg'\n", buf);
+
+	/* The message has been consumed. */
+	ASSERT_ERRNO_EQ(-ENODATA, read(fsfd, buf, sizeof(buf)));
+	ASSERT_SUCCESS(close(fsfd));
+}
+
+TEST_F(ns, fscontext_log_errorfc_after_fsmount)
+{
+	int fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
+	ASSERT_SUCCESS(fsfd);
+
+	ASSERT_ERRNO_EQ(-EINVAL, fsconfig(fsfd, FSCONFIG_SET_STRING, "invalid-arg", "123", 0));
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	int mfd = fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NOEXEC | MOUNT_ATTR_NOSUID);
+	ASSERT_SUCCESS(mfd);
+	ASSERT_SUCCESS(move_mount(mfd, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH));
+
+	/*
+	 * The fscontext log should still contain data even after
+	 * FSCONFIG_CMD_CREATE and fsmount().
+	 */
+	char buf[128] = {};
+	ASSERT_SUCCESS(read(fsfd, buf, sizeof(buf)));
+	EXPECT_STREQ("e tmpfs: Unknown parameter 'invalid-arg'\n", buf);
+
+	/* The message has been consumed. */
+	ASSERT_ERRNO_EQ(-ENODATA, read(fsfd, buf, sizeof(buf)));
+	ASSERT_SUCCESS(close(fsfd));
+}
+
+TEST_F(ns, fscontext_log_emsgsize)
+{
+	int fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
+	ASSERT_SUCCESS(fsfd);
+
+	ASSERT_ERRNO_EQ(-EINVAL, fsconfig(fsfd, FSCONFIG_SET_STRING, "invalid-arg", "123", 0));
+
+	char buf[128] = {};
+	/*
+	 * Attempting to read a message with too small a buffer should not
+	 * result in the message getting consumed.
+	 */
+	ASSERT_ERRNO_EQ(-EMSGSIZE, read(fsfd, buf, 0));
+	ASSERT_ERRNO_EQ(-EMSGSIZE, read(fsfd, buf, 1));
+	for (int i = 0; i < 16; i++)
+		ASSERT_ERRNO_EQ(-EMSGSIZE, read(fsfd, buf, 16));
+
+	ASSERT_SUCCESS(read(fsfd, buf, sizeof(buf)));
+	EXPECT_STREQ("e tmpfs: Unknown parameter 'invalid-arg'\n", buf);
+
+	/* The message has been consumed. */
+	ASSERT_ERRNO_EQ(-ENODATA, read(fsfd, buf, sizeof(buf)));
+	ASSERT_SUCCESS(close(fsfd));
+}
+
+TEST_HARNESS_MAIN

-- 
2.50.1



Return-Path: <linux-fsdevel+bounces-56825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EAEB1C0A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B717AE2AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C621ABDC;
	Wed,  6 Aug 2025 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="1A7Hy5M2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB5215F4A;
	Wed,  6 Aug 2025 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463030; cv=none; b=CmYoEfUSmglJAVvWdEGjgxZ7uhseTrxgumrrG4zOv/V6xS83cXCo7LahchI8CeHHTE0G0jejOA1MBQRCsvKEq/kaU6U+N7dxPHjSGjKb7+JwRYKGDuSYw6mFhkppWKRoxeStc8XOq/WUSkkIIfZ612MVliSxT/jDrksyjohZrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463030; c=relaxed/simple;
	bh=ywwewS385OKjgO2wdr1q2wlVq4LCbsBdwndMRD40U3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=di74ZjOm/6iP7AYV9BP87G/5KErMhWyuOb8xYV2GjsACYUJQEJ1bwEwImUAW4VEJMlJuPJbnLxErvyGdIuwkAEQOmaS0gY87oQlafMH0QVzNfXYYv7qvLGNUQPmXhreBnC87aHllmZmrZmVoV9WfxdLAEUMWAr08VanMmPjqrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=1A7Hy5M2; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bxgsX1cz8z9tgH;
	Wed,  6 Aug 2025 08:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754463024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fqmLqILN4T5IaIJwYDk6Qayp/CB0VtXSWMEFdEUZF0=;
	b=1A7Hy5M2P/MKtq2oqlcPowZkUFrKm4bm2d9RqNQVWcAMRy096zGMiwq3C8eowEMV2A8mwu
	+yUumg4uC1/mPwwNQVu9/FYEruwJETvo0uX4aU4syjkr03Te+0qwSPDXH0n5LmRYTepF1D
	Xj2+Li2PpTC4huQuQbslYgq7pzOlhgESwaCNk/mI9GDw/P+sJIkjc9Lj9KMTUKu4EQrGJv
	nxOMJkX3wKiKKra6JQ1tSAJckTCQmqTAFdeXyMqJzeTo+Zrgz91nyxMEr8C7aHc8bNCGa7
	szKGqgt/a7pfXeyL33CIJiezJM0ljmC3/FjeooCZ4Re4AporiwW9p+Au/n22tg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 06 Aug 2025 16:49:55 +1000
Subject: [PATCH v2 2/2] selftests/filesystems: add basic fscontext log
 tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-fscontext-log-cleanups-v2-2-88e9d34d142f@cyphar.com>
References: <20250806-fscontext-log-cleanups-v2-0-88e9d34d142f@cyphar.com>
In-Reply-To: <20250806-fscontext-log-cleanups-v2-0-88e9d34d142f@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5412; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=ywwewS385OKjgO2wdr1q2wlVq4LCbsBdwndMRD40U3c=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRM+i2es9lK29NyHtNmvRrnI+y5u96cbi60XB24fHr62
 /W7fy6b0VHKwiDGxSArpsiyzc8zdNP8xVeSP61kg5nDygQyhIGLUwAmUviBkeHd75/l9bPnfgpK
 +Hb0v8mvtm7p7J/Oq3ged3RHKshkKBow/OE9+q4jIzGpd/GF9TWHa4J2u2kUxT488Ph00dr4mjM
 Lc7kB
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/filesystems/.gitignore |   1 +
 tools/testing/selftests/filesystems/Makefile   |   2 +-
 tools/testing/selftests/filesystems/fclog.c    | 135 +++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 1 deletion(-)

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
index 000000000000..b1084432f195
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fclog.c
@@ -0,0 +1,135 @@
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
+
+	printf("fsconfig(): %s\n", buf);
+	ASSERT_EQ(strcmp(buf, "e tmpfs: Unknown parameter 'invalid-arg'\n"), 0);
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
+
+	printf("fsconfig(): %s\n", buf);
+	ASSERT_EQ(strcmp(buf, "e tmpfs: Unknown parameter 'invalid-arg'\n"), 0);
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
+	ASSERT_SUCCESS(read(fsfd, buf, sizeof(buf)));
+
+	printf("fsconfig(): %s\n", buf);
+	ASSERT_EQ(strcmp(buf, "e tmpfs: Unknown parameter 'invalid-arg'\n"), 0);
+
+	/* The message has been consumed. */
+	ASSERT_ERRNO_EQ(-ENODATA, read(fsfd, buf, sizeof(buf)));
+	ASSERT_SUCCESS(close(fsfd));
+}
+
+TEST_HARNESS_MAIN

-- 
2.50.1



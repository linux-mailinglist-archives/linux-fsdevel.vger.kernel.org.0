Return-Path: <linux-fsdevel+bounces-56812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B6B1BFF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 07:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EAA3A4DCE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 05:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF42200132;
	Wed,  6 Aug 2025 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="FfjkQBy5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C941FECD4;
	Wed,  6 Aug 2025 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458295; cv=none; b=p1xSkmKn6awDxmWgs+oHaxSfaX3biQeyvpMWsyAQpb5/qBrutmdhwRCE0uVGCogIgSDtds37OgGMVD1qRJcW59OpTdMrxGl+EQLJss/VxDWT4fZ0jnmvbDuuxysAIdrtuLiDhA9HfQxigRUpfgNKDjSrppfMX9UISnhlardkL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458295; c=relaxed/simple;
	bh=Yv4RRmNeO9isqficU05qBD/VkyxIM3He3e4z12DA3e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJpfd3TDJGL7giZLCWc5ZKqQo140ENAbrgCSrYIjM57gFBxEh2rvPunIU4sslNnspSn2TCpkOdTEuTQ2TrNf5pBO3tV+G27k2E0p2QukGnrMAbWZMXUgDRQ+ibciApd0xV+5E9RgFlOBB09Xh0jY7yjYby/452dou+IhfniC91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=FfjkQBy5; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxf6T6Hcdz9t87;
	Wed,  6 Aug 2025 07:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754458289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68QMYqi1n6KdQADbsGhGyxYlrXRfqj2JDm4Cojhf0m8=;
	b=FfjkQBy5Etc7NtLUvteqVpw1gYJPzEOV1uE48u0+W9/OOZpzsxhEfU5KlvYsvvi7mhIfpS
	72cSUxo7nKXatkNrzYJbQg8l1U0nrR0ySB7Cmm1Op38SrujEfy+7Z4JVJC0Ov4Mc3F1kRJ
	X1bsSaU2F2T4YqQBd0YEA7V0/9pUfwVcevPHSaR+JHAnHwG9UuReOqfmtEU1hDdXIN8osJ
	0FJ+gMZAxxLPgELFy0WCTWizTAAVXP1PbjXZENp2t4hMqBGVrklTm7nkS/UcFtr81L279+
	78g71Li7a0veMeuR5VtrSpPVAvTccJi8d2nqDrVFGfWfPmyQ03jjYPBFk2muIw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 06 Aug 2025 15:31:11 +1000
Subject: [PATCH 2/2] selftests/filesystems: add basic fscontext log tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-fscontext-log-cleanups-v1-2-880597d42a5a@cyphar.com>
References: <20250806-fscontext-log-cleanups-v1-0-880597d42a5a@cyphar.com>
In-Reply-To: <20250806-fscontext-log-cleanups-v1-0-880597d42a5a@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5406; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Yv4RRmNeO9isqficU05qBD/VkyxIM3He3e4z12DA3e0=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMerFYT2BSikb9/41TfVbe+MQs9OCnp4FPIUf9q/33F
 G1vZb4X7ihlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATeSPPyDDBWv9WQ6fbiYwV
 e++JnyvY/kgi6Iubr2Pb/eyFPAG12p8YGWZ+nP578dYyHta7mybYXfvd0WkgGye1W/pcbNanRc7
 CixkB
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/filesystems/.gitignore |   1 +
 tools/testing/selftests/filesystems/Makefile   |   2 +-
 tools/testing/selftests/filesystems/fclog.c    | 137 +++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)

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
index 000000000000..2bdb6d6a1ff1
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fclog.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2025 SUSE LLC.
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/prctl.h>
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
+	for (int i = 0; i < 16; i++)
+		ASSERT_ERRNO_EQ(-EMSGSIZE, read(fsfd, buf, 1));
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



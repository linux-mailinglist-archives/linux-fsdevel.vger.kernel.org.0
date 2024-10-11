Return-Path: <linux-fsdevel+bounces-31786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA6E99AE45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 23:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630661F21DCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E921D1727;
	Fri, 11 Oct 2024 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2O6kdjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9071D1741;
	Fri, 11 Oct 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683180; cv=none; b=R+dUiK208qUVchfDA4m1naSQCWCAJXk/zGpgmW7QbjyETlC3Mw91D2en9KxO3+lDN2kGMzIq/kitrk7BzGQdc4BmKXZk1Z/qTHRfO8y+n67IpQZvIgM6/1uPB/BEH0MhsXmsoPdNfNX+CiaLAnuT+tF2nl1/TIO87xnm/OkAH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683180; c=relaxed/simple;
	bh=4zdhHcyUigfcaZd/+sZsZAsCVbg3OR83S3y+KsQlK0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NaAFzl8t3k7q2k8FR7VVfbMDGhn7queLsyg78S9FUza1mMhtc4yS3aZezGRT/BV1cuv4IfZ4p5zt3ZIbAY6NrUoM51J6atVC+gYVTJDxi+aNorwUmLOne4t2X8ksClE3qRPYwxSJCKuLBJqpMGKq5R5+sU9F95TUq/eEhMLSg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2O6kdjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93BDC4CEC3;
	Fri, 11 Oct 2024 21:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728683179;
	bh=4zdhHcyUigfcaZd/+sZsZAsCVbg3OR83S3y+KsQlK0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l2O6kdjl9QJ9+/Su6JtnxOYnfJ/dSHD/Y1pN87j9DlIpJayvPMSqquZxxf8oMxJSq
	 /Jwh74t9G6xH+vuPG3vovQo7YA7H5ELkxxmhU/1Tg0qSGRDZH4xloN3kyj7rbpxdkn
	 fu+ysZ3ERYn2O4QdmmyO86+IoOW4KDDDPJiCarZyvtye7tSpR3seD0EDKTKcxxzMPI
	 PTt9MUrz/BiO3X4QjI8D3u7VK5ocm5YAE5OsyNRLp0K3J9WVtgk2TjCtDgvwImiyl8
	 cPl0jDY/OhH2IcikWCaZMQjAejMZ9O7G02ypMuK+wiOzPhzC8th9layOqoTeO6jBCh
	 1oaPvlvtSAHOA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 11 Oct 2024 23:45:53 +0200
Subject: [PATCH RFC v2 4/4] selftests: add overlayfs fd mounting selftests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-work-overlayfs-v2-4-1b43328c5a31@kernel.org>
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=6353; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4zdhHcyUigfcaZd/+sZsZAsCVbg3OR83S3y+KsQlK0g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRzzlksdDq4fXp6hJbc5ZNVvP8DxX5d4J3//bOE2IVTM
 g9nGiVt7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIbSMjw/m5Z+dszZL1U9ZX
 DNM/EPNT3sfoKneBANv1vYt/mDak1TAyPNiiPnXiZHmubvXD8bzcGabCU64+/akcWvBHWqkp5Xo
 dDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/overlayfs/.gitignore     |   1 +
 .../selftests/filesystems/overlayfs/Makefile       |   2 +-
 .../filesystems/overlayfs/set_layers_via_fds.c     | 122 +++++++++++++++++++++
 .../selftests/filesystems/overlayfs/wrappers.h     |   4 +
 4 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/overlayfs/.gitignore b/tools/testing/selftests/filesystems/overlayfs/.gitignore
index 52ae618fdd980ee22424d35d79f077077b132401..e23a18c8b37f2cdbb121496b1df1faffd729ad79 100644
--- a/tools/testing/selftests/filesystems/overlayfs/.gitignore
+++ b/tools/testing/selftests/filesystems/overlayfs/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dev_in_maps
+set_layers_via_fds
diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
index 56b2b48a765b1d6706faee14616597ed0315f267..e8d1adb021af44588dd7af1049de66833bb584ce 100644
--- a/tools/testing/selftests/filesystems/overlayfs/Makefile
+++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_GEN_PROGS := dev_in_maps
+TEST_GEN_PROGS := dev_in_maps set_layers_via_fds
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
new file mode 100644
index 0000000000000000000000000000000000000000..d3b497eea5e5c9f718caa4957f7fec7c40970502
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
+
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <unistd.h>
+
+#include "../../kselftest_harness.h"
+#include "log.h"
+#include "wrappers.h"
+
+FIXTURE(set_layers_via_fds) {
+};
+
+FIXTURE_SETUP(set_layers_via_fds)
+{
+	ASSERT_EQ(mkdir("/set_layers_via_fds", 0755), 0);
+}
+
+FIXTURE_TEARDOWN(set_layers_via_fds)
+{
+	umount2("/set_layers_via_fds", 0);
+	ASSERT_EQ(rmdir("/set_layers_via_fds"), 0);
+}
+
+TEST_F(set_layers_via_fds, set_layers_via_fds)
+{
+	int fd_context, fd_tmpfs, fd_overlay;
+	int layer_fds[5] = { -EBADF, -EBADF, -EBADF, -EBADF, -EBADF };
+	bool layers_found[5] = { false, false, false, false, false };
+	size_t len = 0;
+	char *line = NULL;
+	FILE *f_mountinfo;
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
+
+	fd_context = sys_fsopen("tmpfs", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+	fd_tmpfs = sys_fsmount(fd_context, 0, 0);
+	ASSERT_GE(fd_tmpfs, 0);
+	ASSERT_EQ(close(fd_context), 0);
+
+	ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
+	ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
+	ASSERT_EQ(mkdirat(fd_tmpfs, "l1", 0755), 0);
+	ASSERT_EQ(mkdirat(fd_tmpfs, "l2", 0755), 0);
+	ASSERT_EQ(mkdirat(fd_tmpfs, "l3", 0755), 0);
+
+	layer_fds[0] = openat(fd_tmpfs, "w", O_DIRECTORY);
+	ASSERT_GE(layer_fds[0], 0);
+
+	layer_fds[1] = openat(fd_tmpfs, "u", O_DIRECTORY);
+	ASSERT_GE(layer_fds[1], 0);
+
+	layer_fds[2] = openat(fd_tmpfs, "l1", O_DIRECTORY);
+	ASSERT_GE(layer_fds[2], 0);
+
+	layer_fds[3] = openat(fd_tmpfs, "l2", O_DIRECTORY);
+	ASSERT_GE(layer_fds[3], 0);
+
+	layer_fds[4] = openat(fd_tmpfs, "l3", O_DIRECTORY);
+	ASSERT_GE(layer_fds[4], 0);
+
+	ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	ASSERT_EQ(close(fd_tmpfs), 0);
+
+	fd_context = sys_fsopen("overlay", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir", NULL, layer_fds[2]), 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir", NULL, layer_fds[0]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir", NULL, layer_fds[1]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[4]), 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+
+	fd_overlay = sys_fsmount(fd_context, 0, 0);
+	ASSERT_GE(fd_overlay, 0);
+
+	ASSERT_EQ(sys_move_mount(fd_overlay, "", -EBADF, "/set_layers_via_fds", MOVE_MOUNT_F_EMPTY_PATH), 0);
+
+	f_mountinfo = fopen("/proc/self/mountinfo", "r");
+	ASSERT_NE(f_mountinfo, NULL);
+
+	while (getline(&line, &len, f_mountinfo) != -1) {
+		char *haystack = line;
+
+		if (strstr(haystack, "workdir=/tmp/w"))
+			layers_found[0] = true;
+		if (strstr(haystack, "upperdir=/tmp/u"))
+			layers_found[1] = true;
+		if (strstr(haystack, "lowerdir+=/tmp/l1"))
+			layers_found[2] = true;
+		if (strstr(haystack, "lowerdir+=/tmp/l2"))
+			layers_found[3] = true;
+		if (strstr(haystack, "lowerdir+=/tmp/l3"))
+			layers_found[4] = true;
+	}
+	free(line);
+
+	for (int i = 0; i < 5; i++) {
+		ASSERT_EQ(layers_found[i], true);
+		ASSERT_EQ(close(layer_fds[i]), 0);
+	}
+
+	ASSERT_EQ(close(fd_context), 0);
+	ASSERT_EQ(close(fd_overlay), 0);
+	ASSERT_EQ(fclose(f_mountinfo), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/overlayfs/wrappers.h b/tools/testing/selftests/filesystems/overlayfs/wrappers.h
index 4f99e10f7f018fd9a7be5263f68d34807da4c53c..071b95fd2ac0ad7b02d90e8e89df73fd27be69c3 100644
--- a/tools/testing/selftests/filesystems/overlayfs/wrappers.h
+++ b/tools/testing/selftests/filesystems/overlayfs/wrappers.h
@@ -32,6 +32,10 @@ static inline int sys_mount(const char *src, const char *tgt, const char *fst,
 	return syscall(__NR_mount, src, tgt, fst, flags, data);
 }
 
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
+#endif
+
 static inline int sys_move_mount(int from_dfd, const char *from_pathname,
 				 int to_dfd, const char *to_pathname,
 				 unsigned int flags)

-- 
2.45.2



Return-Path: <linux-fsdevel+bounces-31735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4ED99A81B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5211F248BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC8197A9E;
	Fri, 11 Oct 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uokheuNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79214188CB1;
	Fri, 11 Oct 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661427; cv=none; b=q7LEPFVqfTR7bEbTZouymETJhb3pyPmBusMgejOF/5THoRi8vGoAoD1Gd/vp0SDGBadB+Ybm6L9qVy8eRarTi0/igyqWuqNh7tn45iYIgZLw7L+nEUzxxk/T/YDealioRtB49aV6uf3XzPm4qt/+e6W5CC11MsdzM5gH6gZTgK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661427; c=relaxed/simple;
	bh=bCbit3F4y36FfZnMyApzouUE8QDKB2Nl49dJAtQVd7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctnV3k9RdpFgJkLmPZ0dlnjDCAHvUcvqFvRE5Myl0y5fcjQ+WaBh8cc0DI/11sKhJWMsysdBDKZeBC1vjOnSHYCK4hM+Atklg64dX6M2tp0LKnY7TVwsjQ2SjMsobkzSFJnUp45RaT27YSm8yCE0WdDILn1tezMFw1NYs+rGuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uokheuNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AB6C4CECF;
	Fri, 11 Oct 2024 15:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661427;
	bh=bCbit3F4y36FfZnMyApzouUE8QDKB2Nl49dJAtQVd7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uokheuNXxSOCalqh5xhh+QrAxqCu87HSbNEerh1iiZxlRcTMhlfssxqePJbPuxcRE
	 XBYdWKqeJ+XR1Fqi9MXJTqkjJ5MXgnfL9eNqlomrPCGJzzwmbR5Im13zxEUKHOrPFc
	 AGWmyEgRe91LDWWu0YfVYQ0xZ6HSINfPLQe9J+QTUDSu8iqvtrFitRYOGJ+EJmkPHl
	 +3RuH/CFZTzvC/B+JV+85SgFPHqDKDF6o3pf+1c3Ef/rb2yWwZaNbl8LuClqJo27ZD
	 8do6aemilpUGMhnCutWY+becxNswknudNMxT+jr5ZexPY3kePcRC1samOM9a6RQ4St
	 Vy/KIK4RaB/Kw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 11 Oct 2024 17:43:37 +0200
Subject: [PATCH RFC 3/3] selftests: add overlayfs fd mounting selftests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-work-overlayfs-v1-3-e34243841279@kernel.org>
References: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=6371; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bCbit3F4y36FfZnMyApzouUE8QDKB2Nl49dJAtQVd7I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRzuq/5LsCS9Pq1z5mfXx7tD6nW4Hq8NT6nz/ryy+jaV
 WvqHr516ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgI/0OG3yxfiyM6Jhh/udp+
 wnBByMKHWoYxAtXWZ6t2WdXnM/+Jv87wv2ja1iWz2rXvnTVYcXvTL+f996zSFzBaXGx8oHv8tK9
 PAisA
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
index 0000000000000000000000000000000000000000..1796da8c2350f5063172a7cd591e5324f87a4c38
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
+	ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir_fd", NULL, layer_fds[2]), 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir_fd", NULL, layer_fds[0]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir_fd", NULL, layer_fds[1]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir_fd+", NULL, layer_fds[2]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir_fd+", NULL, layer_fds[3]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir_fd+", NULL, layer_fds[4]), 0);
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



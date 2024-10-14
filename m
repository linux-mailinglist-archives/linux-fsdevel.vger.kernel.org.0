Return-Path: <linux-fsdevel+bounces-31872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4399C607
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE9528681A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3D21581E0;
	Mon, 14 Oct 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSGcUw5W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A0157495;
	Mon, 14 Oct 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898876; cv=none; b=h4td4edVmbNeF4TarhbLbhlEKVLlZPQf/1lfWnvunBpMROnyN9FoE1tI+mDhCKvxSZzZbFPB6lZd+IEI3VgOSmIlBm1TkDYPpEG/tRltjmNsTYtVX4qF3wh3wkpz/t4f2eTR456oaB7yzkd9eM2DWS7buGiabuI4THyXl6XgdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898876; c=relaxed/simple;
	bh=YE3nKWXbOHwrammoCXdDmbHesrdSCFRCRJKrflEt6Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bh2TwqrWUNW3eAKRe5x6V2Ls5Bdp67ibzWbYvTIyuZl9g8+h4bvyuR4C+ZzVcXHUBU9J1QQujpuwkVql0rDOYdwnTdkylwttw1EAdwSR58m1xVgLUtOoawBGXGsjYb1AUmbBwGvaZ80aBx8WcKbhG8hGNiM8+LK4+w55P/NBy8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSGcUw5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B94C4CED0;
	Mon, 14 Oct 2024 09:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728898876;
	bh=YE3nKWXbOHwrammoCXdDmbHesrdSCFRCRJKrflEt6Fc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sSGcUw5WlR+5S40VMqG1HnlzvPhohIDR1r2JEU8NjOGTS4LiLQTXHwrATW5sJiv/u
	 +ZF8SGkqVRMWpkItVlFqTOxFuqWqvcyCvubGXQbQTx42RQWxLy+xSsHhJtM8bCeE/F
	 POKA2GnQ/3OCBnBNww7Kcv5S8rp/yCiiDpqpwd5iJ8rI+zzrYrpHg3ayoRs809wnWz
	 dKZasH0uxQay7I/lKd/qA52F/TW6cSWaVpHVg/39tfaAHbG9k612sPHgADqwbneuxK
	 LRFNWj4nFsQGkPjh8I4TbmojDxMhhInamHRRTEGAQKnDHJFX4Lz5ONi+Y9AUs7H6Tn
	 IPlbvREf4PuTw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 14 Oct 2024 11:41:00 +0200
Subject: [PATCH v3 5/5] selftests: add overlayfs fd mounting selftests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-work-overlayfs-v3-5-32b3fed1286e@kernel.org>
References: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
In-Reply-To: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=7648; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YE3nKWXbOHwrammoCXdDmbHesrdSCFRCRJKrflEt6Fc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzPDcM071b//RSdYr3mZt/zn2dIbm/ZpufnENOr+nu8
 J5Xhdcfd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkNx8jw13JdXEGa4/vKi46
 LnhUKMYyYf/KrHW5epdd7RgOTTxrlMzIsP6A8MHJrwLWif6SPmJ8+uy3hGvvRG49EklfM8VcuGz
 jMiYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/overlayfs/.gitignore     |   1 +
 .../selftests/filesystems/overlayfs/Makefile       |   2 +-
 .../filesystems/overlayfs/set_layers_via_fds.c     | 152 +++++++++++++++++++++
 .../selftests/filesystems/overlayfs/wrappers.h     |   4 +
 4 files changed, 158 insertions(+), 1 deletion(-)

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
index 0000000000000000000000000000000000000000..301fb5c02852e3ddff2f649b61c2833ce555df36
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -0,0 +1,152 @@
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
+	int layer_fds[] = { [0 ... 8] = -EBADF };
+	bool layers_found[] = { [0 ... 8] =  false };
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
+	ASSERT_EQ(mkdirat(fd_tmpfs, "l4", 0755), 0);
+	ASSERT_EQ(mkdirat(fd_tmpfs, "d1", 0755), 0);
+	ASSERT_EQ(mkdirat(fd_tmpfs, "d2", 0755), 0);
+	ASSERT_EQ(mkdirat(fd_tmpfs, "d3", 0755), 0);
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
+	layer_fds[5] = openat(fd_tmpfs, "l4", O_DIRECTORY);
+	ASSERT_GE(layer_fds[5], 0);
+
+	layer_fds[6] = openat(fd_tmpfs, "d1", O_DIRECTORY);
+	ASSERT_GE(layer_fds[6], 0);
+
+	layer_fds[7] = openat(fd_tmpfs, "d2", O_DIRECTORY);
+	ASSERT_GE(layer_fds[7], 0);
+
+	layer_fds[8] = openat(fd_tmpfs, "d3", O_DIRECTORY);
+	ASSERT_GE(layer_fds[8], 0);
+
+	ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	ASSERT_EQ(close(fd_tmpfs), 0);
+
+	fd_context = sys_fsopen("overlay", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir", NULL, layer_fds[2]), 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   NULL, layer_fds[0]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  NULL, layer_fds[1]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[4]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[5]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "datadir+",  NULL, layer_fds[6]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "datadir+",  NULL, layer_fds[7]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "datadir+",  NULL, layer_fds[8]), 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_STRING, "metacopy", "on", 0), 0);
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
+		if (strstr(haystack, "lowerdir+=/tmp/l4"))
+			layers_found[5] = true;
+		if (strstr(haystack, "datadir+=/tmp/d1"))
+			layers_found[6] = true;
+		if (strstr(haystack, "datadir+=/tmp/d2"))
+			layers_found[7] = true;
+		if (strstr(haystack, "datadir+=/tmp/d3"))
+			layers_found[8] = true;
+	}
+	free(line);
+
+	for (int i = 0; i < ARRAY_SIZE(layer_fds); i++) {
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



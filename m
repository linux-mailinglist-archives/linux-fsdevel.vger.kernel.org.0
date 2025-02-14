Return-Path: <linux-fsdevel+bounces-41737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF4A36368
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4943AE37A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92243267AF2;
	Fri, 14 Feb 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJrFBDZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7399267AEA;
	Fri, 14 Feb 2025 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551564; cv=none; b=rXEDtnHYZkbchLMUsttJrr1+huImPJKBYs4TDLwvFCG9ySUgzSS1PlUQ1WmkJXjPCN1dD/Cw3gBzJ8ysel2KI2w5THOIF8/Od5DCasB3+A9WKEoAwIt3LofZaU+31WlF2UU361NBaDm5WSgzCVsq9KOugd6rZV4bY4gbt6ZJAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551564; c=relaxed/simple;
	bh=Gp+IOpyEurmWUgULKqOPO0AzC6JRJDl5JHa5HhOmT9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKbHMxyWohclAlF2cVOFu64LI7PMwIMDEFmlcEzoKWN2gcBdbtT+W+hl/PmeU+x2BottFyv8+XUsL/mMTvJc7pULYyuFNADPQmvlCclqXz+C2cxpvccuzk6auvXHLMjgRMYYjtnQBKTQeLJQ2ejD/v7vHIjL1baAD98bveJJWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJrFBDZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFC4C4CEDD;
	Fri, 14 Feb 2025 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739551563;
	bh=Gp+IOpyEurmWUgULKqOPO0AzC6JRJDl5JHa5HhOmT9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YJrFBDZEa7jLwYRCK7piX2l/YjTQxHcZI3d11WBR03SRAxO4qsEIypKDdvLnXcGQg
	 NVcq7UQiSUPJPRLEv2tBRdYfDu3JZfCCk/qGs+0czZCEZbX5fAu/KWg6gxsi/MykSZ
	 dP0tJSwAGkJrHWMaf8ZT05d0WaTZm+cfxwEQzITqvo8rwBKoVicco1fGEvFBxcePul
	 kyptUuRfY9WJn5JM/w9f+eqU9bKloLhuZWU2g2NtW1aDWrGGVebZRj9MVmD2YxKhhB
	 56J8if8ICNCno7J6HLGupwF2LR9dswZuHw2SUSvvui+mPwgzrQ22dKACnCoK05dw5m
	 W58KE7RTmV8Gw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Feb 2025 17:45:18 +0100
Subject: [PATCH RFC 2/2] selftests/ovl: add selftests for "override_creds"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-work-overlayfs-v1-2-465d1867d3d4@kernel.org>
References: <20250214-work-overlayfs-v1-0-465d1867d3d4@kernel.org>
In-Reply-To: <20250214-work-overlayfs-v1-0-465d1867d3d4@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>
Cc: Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4423; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Gp+IOpyEurmWUgULKqOPO0AzC6JRJDl5JHa5HhOmT9g=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGevc0SgrMi3C8q9/fc6eBjbc0QiB2tiVozFgct9Ve6CgZR8P
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmevc0QACgkQkcYbwGV43KKmDwD9FM4X
 ZhzqSqvUAoSW2qb/B44Nbg0CsZHbWOlNE0RVd3QA/A0JIkthmksxdbO7B0jNe5BRfNNEe3kzyF+
 dKBCU7d0K
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test to verify that the new "override_creds" option works.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../filesystems/overlayfs/set_layers_via_fds.c     | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index e65d95d97846..9caf5444f4c3 100644
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -6,11 +6,13 @@
 #include <sched.h>
 #include <stdio.h>
 #include <string.h>
+#include <sys/fsuid.h>
 #include <sys/stat.h>
 #include <sys/mount.h>
 #include <unistd.h>
 
 #include "../../kselftest_harness.h"
+#include "../../pidfd/pidfd.h"
 #include "log.h"
 #include "wrappers.h"
 
@@ -409,4 +411,111 @@ TEST_F(set_layers_via_fds, set_layers_via_detached_mount_fds)
 	ASSERT_EQ(fclose(f_mountinfo), 0);
 }
 
+TEST_F(set_layers_via_fds, set_override_creds)
+{
+	int fd_context, fd_tmpfs, fd_overlay;
+	int layer_fds[] = { [0 ... 3] = -EBADF };
+	bool found = false;;
+	size_t len = 0;
+	char *line = NULL;
+	FILE *f_mountinfo;
+	pid_t pid;
+	int pidfd;
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
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_STRING, "metacopy", "on", 0), 0);
+
+	pid = create_child(&pidfd, CLONE_NEWUSER);
+	EXPECT_GE(pid, 0);
+	if (pid == 0) {
+		if (!sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override_creds", NULL, 0)) {
+			TH_LOG("sys_fsconfig should have failed");
+			_exit(EXIT_FAILURE);
+		}
+
+		_exit(EXIT_SUCCESS);
+	}
+	EXPECT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+	EXPECT_EQ(close(pidfd), 0);
+
+	pid = create_child(&pidfd, 0);
+	EXPECT_GE(pid, 0);
+	if (pid == 0) {
+		if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override_creds", NULL, 0)) {
+			TH_LOG("sys_fsconfig should have succeeded");
+			_exit(EXIT_FAILURE);
+		}
+
+		_exit(EXIT_SUCCESS);
+	}
+	EXPECT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+	EXPECT_EQ(close(pidfd), 0);
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
+		if (strstr(haystack, "override_creds")) {
+			found = true;
+			break;
+		}
+	}
+	free(line);
+
+	ASSERT_EQ(found, true);
+
+	ASSERT_EQ(close(fd_context), 0);
+	ASSERT_EQ(close(fd_overlay), 0);
+	ASSERT_EQ(fclose(f_mountinfo), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2



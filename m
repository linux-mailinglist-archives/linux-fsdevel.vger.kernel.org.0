Return-Path: <linux-fsdevel+bounces-41834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA48CA37FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45816170CE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693F2185A0;
	Mon, 17 Feb 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE9cN0cy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E395217678;
	Mon, 17 Feb 2025 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787646; cv=none; b=ldXCGBklU9eq8aoQwhmCDVsXg0jPW6tI8oKCEKPSDGCetyDa14svPnzzs9wlzeeNxgq+3TC04Zh7rmMZMdLpmyNp5WJ+BPQCwBI68T6JULWIefG5J9sp14nztlZQBmEr4gB6XtdmSr1TQWbLqmX6DHlMvZaoNgT/cNDPuR5zFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787646; c=relaxed/simple;
	bh=hhlmQBgSfHwKmRW6xFe03YCHZsaMERLa/kMgHcJ1vtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENlf8+2Sza+wECFoxi86DJvUn+4GhSO32p81YRt7oafOXa/l69KnhfM9PBEEjI896uYDfRNFJYPYOicU3LQOoWHXQRRrVYcuQhu6QkyAnixuCAHEDRgjaitX9AxQiT/PjnljqqvE+EQEaIKJ/ExjFgPx7GM2Jvn03ocfvB8rCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE9cN0cy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00136C4CEE2;
	Mon, 17 Feb 2025 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739787644;
	bh=hhlmQBgSfHwKmRW6xFe03YCHZsaMERLa/kMgHcJ1vtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LE9cN0cypZm9VIb1bSxYMKzGmlW5uWpURkHtFv/2kYBfDTcYwHpoSxQAy5suSczTi
	 fCkmzpia1p7lC6/A3WYI7B6JbI17fCPJPJMc5XGetjbEhsGxOWDvLScOGOuPdgfh1J
	 XiPkRIdLAMlh+EkboLaPMHpbLhfLsL1+G+Hi5WdhXYSPqqxqd6ySkG6JXuFpCnPmNg
	 WVy+QyoNHFYRTqKUo3AEr4fA6cUMicyQVgsdTE/YDeCyPcH5J7wrmNSW2I3dJQhQHO
	 1dqKjRAOi9OA8/MVbEdzKLxj6GmDZpi56dVpLAy5R7qOODgOBciCYudCIaEiz0Xsj5
	 w2BXDuwRiqxyg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Feb 2025 11:20:30 +0100
Subject: [PATCH RFC v2 2/2] selftests/ovl: add selftests for
 "override_creds"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-work-overlayfs-v2-2-41dfe7718963@kernel.org>
References: <20250217-work-overlayfs-v2-0-41dfe7718963@kernel.org>
In-Reply-To: <20250217-work-overlayfs-v2-0-41dfe7718963@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>
Cc: Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3988; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hhlmQBgSfHwKmRW6xFe03YCHZsaMERLa/kMgHcJ1vtc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRv5i27/3YFx6f8hf9i/a6sdkz20FTeom15SPyXIbtno
 b/YwZseHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRPs7IsNzzRLVUPdezRdOk
 Odis1Exj725gkdxVnrDc62TOu7geeUaGe5+rhPO+v4t39mP+vuXgl+JWffkTW+e9fb3zpe2zf4F
 n2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test to verify that the new "override_creds" option works.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../filesystems/overlayfs/set_layers_via_fds.c     | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index e65d95d97846..6c9f4df5df8d 100644
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
 
@@ -409,4 +411,91 @@ TEST_F(set_layers_via_fds, set_layers_via_detached_mount_fds)
 	ASSERT_EQ(fclose(f_mountinfo), 0);
 }
 
+TEST_F(set_layers_via_fds, set_override_creds)
+{
+	int fd_context, fd_tmpfs, fd_overlay;
+	int layer_fds[] = { [0 ... 3] = -EBADF };
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
+	ASSERT_EQ(close(fd_context), 0);
+	ASSERT_EQ(close(fd_overlay), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2



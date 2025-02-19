Return-Path: <linux-fsdevel+bounces-42052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C07A3BB35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9DC3A4608
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692B71DD88D;
	Wed, 19 Feb 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc8CAVsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C504917A302;
	Wed, 19 Feb 2025 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959344; cv=none; b=ngiDu7ZlwUFU905Jea0MeoMP119A7VTszBo2vIZ5dKYg/FLM4Ob0xyPgWbSI0Z78qS3/3Z0IdP37gpqKDjo0ZLIxxpwjKTxWsC9QN6SY8sLAJ5y6yvCPzXl3mXJ426Pk/aYBxMPXgvFLpO2o1RA4b2djIaWm1I4b54amkY6PqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959344; c=relaxed/simple;
	bh=q41j+ox7rOuV1b/dMSn7KbOkJKy8kD1MpckFVr8+NFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tyliXUGVNMFyYJDZ+6jILmk2oPd0uWKr+ReBrA0ZXjGn8vseKQMO06ibKn9+Sylti1iyWnj2niTCs9YCK2WDGqBO8NbSSQcGNlSLaV80tzyroSpNJo8/nIg8bPPStV0ygroVlcUX+ASrQtYK2y1VzakQTPFgF3bKW6sFV8yB7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc8CAVsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC24CC4CEEA;
	Wed, 19 Feb 2025 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739959344;
	bh=q41j+ox7rOuV1b/dMSn7KbOkJKy8kD1MpckFVr8+NFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gc8CAVslm3YtkEaUO3h60FqotlxMRKTDPL4NQmg5BVE3X3zGe//eKWCMv2Yc/SZ3B
	 UYZuKYmhRD53oLwMY+eX0S/VXePYcjhFsUpnfGJnyZxUEc9aoudlSppBD+m5USZ/tG
	 M+DgNtAm9rnWCruu2/yXvjntOvTr0jOd05W2Q5eWaNeFnpcfKu/oZ7IyekcXwKDg2p
	 qJkI+vux6U8KdSsq7E39/bbaXCcX3OyI1O9ajUmMTHWMSk9m5z8Xg4QgGqJFTBCMVx
	 vu4b0M8gc7EC8hGzJNIoYD6LJhoikaQPMVNIeSYERDcbp6VFMV3NKBg7zYNOrZieWd
	 mHLddP309nYwg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 19 Feb 2025 11:01:52 +0100
Subject: [PATCH v3 4/4] selftests/ovl: add third selftest for
 "override_creds"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-work-overlayfs-v3-4-46af55e4ceda@kernel.org>
References: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org>
In-Reply-To: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>
Cc: Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5035; i=brauner@kernel.org;
 h=from:subject:message-id; bh=q41j+ox7rOuV1b/dMSn7KbOkJKy8kD1MpckFVr8+NFo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRvXaN2c81Ur4bchKO/rK147iooJk9PEy1Y3VX+555a4
 A7d49V+HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPh8GT477gs8JjJ4luvyk8e
 EH5err+q/vhN4bCdU/+UPDobJ/Fuszgjw6tv85jWH70cYSLdEXzZpliP4/ORHxUOwnuVP33j9Zl
 1jw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test to verify that the new "override_creds" option works.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../filesystems/overlayfs/set_layers_via_fds.c     | 80 ++++++++++++++++++++++
 tools/testing/selftests/filesystems/utils.c        | 27 ++++++++
 tools/testing/selftests/filesystems/utils.h        |  1 +
 3 files changed, 108 insertions(+)

diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index 6b65e3610578..fd1e5d7c13a3 100644
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <sys/mount.h>
 #include <unistd.h>
 
@@ -442,4 +443,83 @@ TEST_F(set_layers_via_fds, set_override_creds_invalid)
 	ASSERT_EQ(close(fd_userns2), 0);
 }
 
+TEST_F(set_layers_via_fds, set_override_creds_nomknod)
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
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "userxattr", NULL, 0), 0);
+
+	pid = create_child(&pidfd, 0);
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		if (!cap_down(CAP_MKNOD))
+			_exit(EXIT_FAILURE);
+
+		if (!cap_down(CAP_SYS_ADMIN))
+			_exit(EXIT_FAILURE);
+
+		if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override_creds", NULL, 0))
+			_exit(EXIT_FAILURE);
+
+		_exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+	ASSERT_GE(close(pidfd), 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+
+	fd_overlay = sys_fsmount(fd_context, 0, 0);
+	ASSERT_GE(fd_overlay, 0);
+
+	ASSERT_EQ(sys_move_mount(fd_overlay, "", -EBADF, "/set_layers_via_fds", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	ASSERT_EQ(mknodat(fd_overlay, "dev-zero", S_IFCHR | 0644, makedev(1, 5)), -1);
+	ASSERT_EQ(errno, EPERM);
+
+	ASSERT_EQ(close(fd_context), 0);
+	ASSERT_EQ(close(fd_overlay), 0);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index 0e8080bd0aea..e553c89c5b19 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -472,3 +472,30 @@ int caps_down(void)
 	cap_free(caps);
 	return fret;
 }
+
+/* cap_down - lower an effective cap */
+int cap_down(cap_value_t down)
+{
+	bool fret = false;
+	cap_t caps = NULL;
+	cap_value_t cap = down;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	ret = cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, 0);
+	if (ret)
+		goto out;
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+
+out:
+	cap_free(caps);
+	return fret;
+}
diff --git a/tools/testing/selftests/filesystems/utils.h b/tools/testing/selftests/filesystems/utils.h
index f35001a75f99..7f1df2a3e94c 100644
--- a/tools/testing/selftests/filesystems/utils.h
+++ b/tools/testing/selftests/filesystems/utils.h
@@ -24,6 +24,7 @@ extern int get_userns_fd(unsigned long nsid, unsigned long hostid,
 			 unsigned long range);
 
 extern int caps_down(void);
+extern int cap_down(cap_value_t down);
 
 extern bool switch_ids(uid_t uid, gid_t gid);
 

-- 
2.47.2



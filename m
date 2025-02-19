Return-Path: <linux-fsdevel+bounces-42050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B29A3BB32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C493AA819
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4021DC184;
	Wed, 19 Feb 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtxdED70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F71D5142;
	Wed, 19 Feb 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959340; cv=none; b=hR0FTtd+KJj6DDGqms5EiJUcXRtTgqP0vXJGp+w/ts9Ga1eHQznvAFY/PhOKMN4qD8i5kIAWqGh0K35+epy5AOfxUg3EmRmF6WpJXrDGxIH4Q0iCts7bxyaYUIK1Z02YKKOzV/8gIzvAvVr2GP+48A/3EXOvKGj24PX00SDV0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959340; c=relaxed/simple;
	bh=pBQYo8lPHQAvpUZDBzm9cwZIYliLH/B65iWPLGEETok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kp8sQofkwUoEENTxT6W+f9pChp8tIkCIbEUurkTF2hiZRjjE3hbsuCSic2IeGWEUxEvpWiR83Bhcd3OCz61ux22QFg6JVwJsUwCtnvVG7xlAQroP4/RtZpjLZni4Ic7VAAWyzbQh1yK653H8zEEO7lnWfUBDx3SFQoO7c6gcSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtxdED70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E39FC4CED1;
	Wed, 19 Feb 2025 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739959340;
	bh=pBQYo8lPHQAvpUZDBzm9cwZIYliLH/B65iWPLGEETok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AtxdED70evMy8pZl+iPIfGZsddJgu0fgrmdB5A9/keGl+KtsrlJYitizkXkf/ppNN
	 4myx6HEvB9Nxs/mBr89J9Adz8e3SqJdwzBrXNTJxtPfzaVhJDjZDrKWytFZNw0wPjF
	 Jez1H5lPyYGBosBBgWUpjoE7N9CSDOuTZKOfLtgP9Or/n+IQEZtCJO08/0MMehRqdD
	 yw7WaBfks0BRADrFrjAyJZ8me5dLJqou28/bKCmKLluQcj0hk+fCyMfBQFHvmDeCV2
	 aqZyY3xK8woBv9GSIb6W0NyvQ67higgYkAllzIY6qymP0nfHaPq7Qh3kND8XplFsJA
	 mTFwNPYLD4JqA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 19 Feb 2025 11:01:50 +0100
Subject: [PATCH v3 2/4] selftests/ovl: add first selftest for
 "override_creds"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-work-overlayfs-v3-2-46af55e4ceda@kernel.org>
References: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org>
In-Reply-To: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>
Cc: Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4244; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pBQYo8lPHQAvpUZDBzm9cwZIYliLH/B65iWPLGEETok=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRvXaPmWhYa/GDKjKDjzJcWNzkfqb1VKpvdc/zwqej7G
 1NUt+o/7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIwW9GhrdNp/XVT524btLi
 7qFSq7W2w/jwjwfXne7ed6+VmvB3zy1Ghvlz7c/rLw+P1Pif3d+w+Nwny4OP5jA0nso9ETHBbGL
 UTx4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test to verify that the new "override_creds" option works.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../filesystems/overlayfs/set_layers_via_fds.c     | 101 +++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index 1d0ae785a667..70acd833581d 100644
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -11,6 +11,7 @@
 #include <unistd.h>
 
 #include "../../kselftest_harness.h"
+#include "../../pidfd/pidfd.h"
 #include "log.h"
 #include "wrappers.h"
 
@@ -214,4 +215,104 @@ TEST_F(set_layers_via_fds, set_500_layers_via_fds)
 	ASSERT_EQ(close(fd_overlay), 0);
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
+	pid = create_child(&pidfd, 0);
+	EXPECT_GE(pid, 0);
+	if (pid == 0) {
+		if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "nooverride_creds", NULL, 0)) {
+			TH_LOG("sys_fsconfig should have succeeded");
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



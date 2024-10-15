Return-Path: <linux-fsdevel+bounces-31961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7DE99E555
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01209284B04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4721C7274;
	Tue, 15 Oct 2024 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqm4mbqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA09139597;
	Tue, 15 Oct 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990936; cv=none; b=NyJtw3R+1Y/2Lp/Fn1HvVOkqcUdDe0vQ4wuFsQoOWE+v2IZ/RGJWXngTyCTI2xzd9LrC2tH+EI8Nx+8RMIJmLZTiTvHG9QvBa3+TZCVSexyHopzSl9xtDC0+TcDCwBdp58FS7iol6rd/u0FDWLuzrqjRqva1p2ojlbDMMewkPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990936; c=relaxed/simple;
	bh=CZZ2IgrC2iNgpPzy5AQdPc+XnlTLB3/8DV5uzJx8yRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5P61ino4JoCB5UsRR7dFE/rBov1kyMxT9LSrxhQ51qkkA4xKq3Xz/faZrRmQEOL5cNVRymJz3J1DkIoygbcMsOBB0di76aLdlVhRK+CCfPnSWLgxrJPI3mlNFHt/Aex3Xd6ZMbSFKfYjAApt9NWN2ehJ0rIzFhPiArMcCL2hJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqm4mbqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9E2C4CEC6;
	Tue, 15 Oct 2024 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728990936;
	bh=CZZ2IgrC2iNgpPzy5AQdPc+XnlTLB3/8DV5uzJx8yRM=;
	h=From:To:Cc:Subject:Date:From;
	b=aqm4mbqJS+vIYOK9R5W2Kujc4vRSCgFLjUpVh0ukCr0CP2skNkbxrIXeTM1tfraWM
	 0PuZtyOLlNRETcOIBXz1bGZXFOveSgePacehkfGQKdPXtNLskfAvEp5YysYMbOBmy9
	 1B+XSxp7Vg65oj4mP+2C6UwbTcQK2OKhe2b1pVIf232hLtxDRvypnudwFROsr9nRQF
	 bSShVscxchN/22SbRbHAwBKl1swny0+1f3HSLXY5PnEZx9/1DoKstNYcj6fu1KaML5
	 NEOvIcHO/VUDPr8hiHRJnWKRHbV8PC6VEGu0HQbgk2jWMtsvNEFpVXcWIsbVbViAfm
	 OURusfvtevFow==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH] selftests: add test for specifying 500 lower layers
Date: Tue, 15 Oct 2024 13:15:29 +0200
Message-ID: <20241015-leiht-filmabend-a86eed4ff304@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3100; i=brauner@kernel.org; h=from:subject:message-id; bh=CZZ2IgrC2iNgpPzy5AQdPc+XnlTLB3/8DV5uzJx8yRM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTz+V1sSdUXtmJkXOr3/vpXr+kHtlc/O7pe53NS9sSpG fP8AhomdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkLofhvwezYVD5ZIOorRlP mibdKOe6fWTm7yTLZ9JyB7i/1/40smFk6HpwfuJTnsOMSVqK92567i5ijNhTF6xUwudY3aPKmne GGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Verify that we can actually specify 500 lower layers and fail at the
501st one.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Just noticed that we didn't have that and we'd already regressed that
once and now that I've done new selftests already just add a selftest
for this on top.
---
 .../overlayfs/set_layers_via_fds.c            | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index 301fb5c02852..1d0ae785a667 100644
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -149,4 +149,69 @@ TEST_F(set_layers_via_fds, set_layers_via_fds)
 	ASSERT_EQ(fclose(f_mountinfo), 0);
 }
 
+TEST_F(set_layers_via_fds, set_500_layers_via_fds)
+{
+	int fd_context, fd_tmpfs, fd_overlay, fd_work, fd_upper, fd_lower;
+	int layer_fds[500] = { [0 ... 499] = -EBADF };
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
+	for (int i = 0; i < ARRAY_SIZE(layer_fds); i++) {
+		char path[100];
+
+		sprintf(path, "l%d", i);
+		ASSERT_EQ(mkdirat(fd_tmpfs, path, 0755), 0);
+		layer_fds[i] = openat(fd_tmpfs, path, O_DIRECTORY);
+		ASSERT_GE(layer_fds[i], 0);
+	}
+
+	ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
+	fd_work = openat(fd_tmpfs, "w", O_DIRECTORY);
+	ASSERT_GE(fd_work, 0);
+
+	ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
+	fd_upper = openat(fd_tmpfs, "u", O_DIRECTORY);
+	ASSERT_GE(fd_upper, 0);
+
+	ASSERT_EQ(mkdirat(fd_tmpfs, "l501", 0755), 0);
+	fd_lower = openat(fd_tmpfs, "l501", O_DIRECTORY);
+	ASSERT_GE(fd_lower, 0);
+
+	ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	ASSERT_EQ(close(fd_tmpfs), 0);
+
+	fd_context = sys_fsopen("overlay", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   NULL, fd_work), 0);
+	ASSERT_EQ(close(fd_work), 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  NULL, fd_upper), 0);
+	ASSERT_EQ(close(fd_upper), 0);
+
+	for (int i = 0; i < ARRAY_SIZE(layer_fds); i++) {
+		ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[i]), 0);
+		ASSERT_EQ(close(layer_fds[i]), 0);
+	}
+
+	ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower), 0);
+	ASSERT_EQ(close(fd_lower), 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+
+	fd_overlay = sys_fsmount(fd_context, 0, 0);
+	ASSERT_GE(fd_overlay, 0);
+	ASSERT_EQ(close(fd_context), 0);
+	ASSERT_EQ(close(fd_overlay), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.45.2



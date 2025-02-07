Return-Path: <linux-fsdevel+bounces-41226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46512A2C7CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 16:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775813ABE6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE282500DC;
	Fri,  7 Feb 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj4WD1z1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F12500C5;
	Fri,  7 Feb 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943219; cv=none; b=ELgrY5yzNHz2NwluJ9dcYZ2yTLDV2nBxPkt5Lghg0+KRF+Jhfp9vdIdRjNvDC0SCv26vDPMRFuAJVf1EGM59F4vRIKF4UpSJQOeXeaIzG+AbTj2Rc2cxDwzm1etF6UI7I1cZRcMLdWMulR7lMxokQ4v9UFVbv/ue9mCYSOTiHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943219; c=relaxed/simple;
	bh=K9c0rt0XWDv9lF7rhjy20/wBTcF2vjxT8MhbMHuq5m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=COKskGSIEBBCn2kihuWbC6Hy3D0wNUoF/AKXSAIFoBPYBViV6OjeyQMJfC2ew6tcNAKB0UOGn4yr/0JNCtjQf1XT4qVJnMrxOX8+Cqc4VnkQTzNBU7eNUFfb1/ZOh8lVB/vgo2GjLxPYQZ/MR88z/UDGP6aQxyNK0+bQPc46e4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pj4WD1z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F76AC4CEDF;
	Fri,  7 Feb 2025 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738943218;
	bh=K9c0rt0XWDv9lF7rhjy20/wBTcF2vjxT8MhbMHuq5m4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pj4WD1z1/6z8mdA4mWEG1h4P/B0axJvNw2WZedEeeK48QAcjNMgsFwFbP4xUACwDM
	 0M41g4lAdQIHEjzn0DlcA8q5a7DNcx067KWePBCQ3uVsSHYKuv7U8z1XyioDupxmGi
	 4bXm7Cj12LBF2E6gbxEYhq0fpv9q52Ua9G/5YaBjg9P5GlC6028Eb9R4+R+MJ/xbPQ
	 xNDwxs5f2DExt97iNA7zIFUG0K4uIl8moBAvBmFNvFhNwEL7uXM+j28YpFix3x09VJ
	 /GNGitpVwj/i2VLcITdJNpMHAxz6NkolwU4ik0+3he/r4vhV55ywfAa/XOGELCFYpd
	 78+h9bcv2UnXA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 07 Feb 2025 16:46:40 +0100
Subject: [PATCH 2/2] selftests/overlayfs: test specifying layers as O_PATH
 file descriptors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-work-overlayfs-v1-2-611976e73373@kernel.org>
References: <20250207-work-overlayfs-v1-0-611976e73373@kernel.org>
In-Reply-To: <20250207-work-overlayfs-v1-0-611976e73373@kernel.org>
To: linux-unionfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=brauner@kernel.org;
 h=from:subject:message-id; bh=K9c0rt0XWDv9lF7rhjy20/wBTcF2vjxT8MhbMHuq5m4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv03rz4/mFze+u7MhMeC2i/r6hJMNfcUb87zn5bCGT5
 8dc/vvFsaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiTaEMf2W2L9JUY92vfVni
 8BJROefHSVf7JdlTsj4LS528kbAgToaR4V7zk2t/G3Ye391aFPGwleO+h1LBeutqrjj3Cu8ik7e
 /+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Verify that userspace can specify layers via O_PATH file descriptors.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../filesystems/overlayfs/set_layers_via_fds.c     | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index 1d0ae785a667..e693e4102d22 100644
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -214,4 +214,69 @@ TEST_F(set_layers_via_fds, set_500_layers_via_fds)
 	ASSERT_EQ(close(fd_overlay), 0);
 }
 
+TEST_F(set_layers_via_fds, set_500_layers_via_opath_fds)
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
+		layer_fds[i] = openat(fd_tmpfs, path, O_DIRECTORY | O_PATH);
+		ASSERT_GE(layer_fds[i], 0);
+	}
+
+	ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
+	fd_work = openat(fd_tmpfs, "w", O_DIRECTORY | O_PATH);
+	ASSERT_GE(fd_work, 0);
+
+	ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
+	fd_upper = openat(fd_tmpfs, "u", O_DIRECTORY | O_PATH);
+	ASSERT_GE(fd_upper, 0);
+
+	ASSERT_EQ(mkdirat(fd_tmpfs, "l501", 0755), 0);
+	fd_lower = openat(fd_tmpfs, "l501", O_DIRECTORY | O_PATH);
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
2.47.2



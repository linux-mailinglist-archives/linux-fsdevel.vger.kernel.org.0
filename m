Return-Path: <linux-fsdevel+bounces-41394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83AA2ECAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB0618864BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CE322331A;
	Mon, 10 Feb 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQj1zgh/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957B222575;
	Mon, 10 Feb 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191154; cv=none; b=hzKLHCJzzhnFYViqDL1+Wf75tL0SSl6JSAEyKcpxz5rW7qmfZ4uu47UkhgatfPY0oA2AisxFUhMD4N3nmxwKVb2gYlwhTt9OzmA/8YQoOqbw1Lv6S8NEfTNPS5qa4sjvUBXbF6G4QQbp31rnRrXBqJIodfOecXtD8h20g2ZLOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191154; c=relaxed/simple;
	bh=ljIOXA2bPardzFGibNKxD83ReIm1uSuY3/J//GCCwjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxeg71kEfFrwsof+v1OOt878x6GCfnbGEvWLBz97k4aWKSXPGXuVGT6tbT16bW6WrqVoT4qvhT2TJT1I7WSQNIHKsKleksOxCvjMDTS6X30TjSjlBIY+qkBeIGX7Nrlg6xWcKH7yK6yYLDf0W9hX3tP+luSrJuNWTI3ev+5Epck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQj1zgh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A145C4CEDF;
	Mon, 10 Feb 2025 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739191153;
	bh=ljIOXA2bPardzFGibNKxD83ReIm1uSuY3/J//GCCwjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gQj1zgh/XuVpah/4rMm12Of2bVI5ZavQN16MK/rZjq1hYIY2UJ7k8M19DR9cnC1R5
	 KDZj1tjEOW4yBRQjSHZ2TNC/N94Krz4ktiw3fut/lY5I1YvBX3+di5e4kL3GyINTlZ
	 jCeiQsSk8oFlYz6/6q982wGVh+A7Xw+iwAEjQXU/+F6ltP5oYVk+H1nipFsW0RiSic
	 pGj6vSKMNNphS6h9ROHwQoNdCbelWbcHHastdDKacb/tKxq71M9jmGORLodj/T6Vpc
	 snA1lD9yP7KLuQAP1bSHHi85AmyAJ0f5PCJfiKZXidwHXWPKFcX1cJekvs6tczv4+g
	 P8i1NnegESUGw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Feb 2025 13:39:00 +0100
Subject: [PATCH v2 2/2] selftests/overlayfs: test specifying layers as
 O_PATH file descriptors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-work-overlayfs-v2-2-ed2a949b674b@kernel.org>
References: <20250210-work-overlayfs-v2-0-ed2a949b674b@kernel.org>
In-Reply-To: <20250210-work-overlayfs-v2-0-ed2a949b674b@kernel.org>
To: linux-unionfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ljIOXA2bPardzFGibNKxD83ReIm1uSuY3/J//GCCwjI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSv/Jyz/5LUzFLRtUufZ1Tts97bNemsRmSn9ZP5bZtPu
 XdXGxe/6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIDmOGf9ZuTyt0ONlCvRw1
 Nlv4NKpoCj13MP26b5/ATO451fNDDRgZNn+7+kjlzIZtUZ+r1y7eqbDwscO5TedfJhw9Wl1wZMJ
 ETX4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Verify that userspace can specify layers via O_PATH file descriptors.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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



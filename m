Return-Path: <linux-fsdevel+bounces-42235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4371AA3F59E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD14A863369
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745B8211712;
	Fri, 21 Feb 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECeZNgAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75552116FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143634; cv=none; b=JmpVt0kAECXtBnQJMYz7KH4+qjcZ5fod6NeHlX3EA7akOfc4nGIeeNZ1bzP4KZy7yq8k/b5taWdX6pUfDb5HlD9Ms0wvSQGfbIPwytFvmwdj077ZUCIfOxqazuPRfzU7CenBJLxaNgZeLqE9LGgiKjWBWufQqhHW/mKE73OSF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143634; c=relaxed/simple;
	bh=9vWuRBLRV3+s9+qLggYdFzY5+/UjTMa+6MuyH5bEhlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kF8/m1mG2p90NfTl6+j9+Fnp4mLrYuGvcF2xIWczbGX0NQMWqg+KQflLph5soaceSW8cSDGLzeKyb9wMpKGapUe4FnysEawn3nBauC/4jRMrwbbruYbTA8/hmAgRqWMcYymDxL+Cqx6hSeWBD20AWY9p4PVDPOUeTNTdWnr8bMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECeZNgAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39D5C4CEE4;
	Fri, 21 Feb 2025 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143634;
	bh=9vWuRBLRV3+s9+qLggYdFzY5+/UjTMa+6MuyH5bEhlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ECeZNgAg/Qg7MZ8eRzwUvY6zapPgIARGW7BIBkEuhdgy7PnK0irjxk4LAylBVC9fb
	 /8pGyWQk7SbMJvhzq22rseWOCJ9PwIg8jq/DXAEsYiTCyEu1ZvBS9NpVTnn7uX4wFt
	 XVqpkAtpwLNTn0goN75DljopTdUScbUk5W2vkiA5S5WtHC6wV3StIWhy5RkqcfomZf
	 v61bV1JdRQPMwLNAZ0gniTE337y8lKMhhzBcoUd9uV30wP3klh22jZn9eo9QAV7/KP
	 InjxvWy5dm/qXt4qiOlRztvfGfzmAHVpEV1b7XIO/BYz0D6laNYPdMVCB3ssGxgTbM
	 OGuw4PvXh+KlA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:09 +0100
Subject: [PATCH RFC 10/16] selftests: first test for mounting detached
 mounts onto detached mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-10-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2084; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9vWuRBLRV3+s9+qLggYdFzY5+/UjTMa+6MuyH5bEhlA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP4V7qDSvywxljM28opa91vp3INGN62eHuq40+I67
 XxAyyTnjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIloBzD8r7KMszKruprz5Osf
 29MrRCeelUhK/pTv+cA19W/Hn/O+ogz/M+f3vxMPWt9+xaTd+tydbF2rbnkNxrqOiVONGU/d/Lq
 dCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test to verify that detached mounts behave correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 885d98f2d889..0641d2e22e02 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1789,4 +1789,44 @@ TEST_F(mount_setattr, open_tree_detached_fail3)
 	ASSERT_EQ(errno, EINVAL);
 }
 
+TEST_F(mount_setattr, mount_detached_mount_on_detached_mount_then_close)
+{
+	int fd_tree_base = -EBADF, fd_tree_subdir = -EBADF;
+	struct statx stx;
+
+	fd_tree_base = sys_open_tree(-EBADF, "/mnt",
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree_base, 0);
+	/*
+	 * /mnt testing tmpfs
+	 */
+	ASSERT_EQ(statx(fd_tree_base, "A", 0, 0, &stx), 0);
+	ASSERT_FALSE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	fd_tree_subdir = sys_open_tree(fd_tree_base, "",
+				       AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				       AT_EMPTY_PATH | OPEN_TREE_CLOEXEC |
+				       OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree_subdir, 0);
+	/*
+	 * /mnt testing tmpfs
+	 */
+	ASSERT_EQ(statx(fd_tree_subdir, "A", 0, 0, &stx), 0);
+	ASSERT_FALSE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	/*
+	 * /mnt   testing tmpfs
+	 * `-/mnt testing tmpfs
+	 */
+	ASSERT_EQ(move_mount(fd_tree_subdir, "", fd_tree_base, "", MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH), 0);
+	ASSERT_EQ(statx(fd_tree_subdir, "", AT_EMPTY_PATH, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	ASSERT_NE(move_mount(fd_tree_subdir, "", fd_tree_base, "", MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH), 0);
+
+	EXPECT_EQ(close(fd_tree_base), 0);
+	EXPECT_EQ(close(fd_tree_subdir), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2



Return-Path: <linux-fsdevel+bounces-42236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6CA3F577
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB747A6FCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B314B211A21;
	Fri, 21 Feb 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfxrjahA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6C21171C
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143637; cv=none; b=XkaEWG66HVzjmAD8g4/oPDbgN+9CIWUpJBoszV4vDlNlOSU05Af4UCcUJsrndCog5fzVoQ+v2qknC4NAPvBy2ajwi5YM1wvAnk+hbdQdXb6ix2rOEPQSOfqOC49M2tvbQefK56p9kHUA7h7BphM/VQXvtCGEIkpvlSY9KPSRhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143637; c=relaxed/simple;
	bh=7ES0SPMiRlraClgcS8merlzkxXeLOVw73ScNSfGlIBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwOsGaONLRY5wOoTWoMi9f+ZrEgTESUiD7Lg9ydx8B6psic5OLvmN0rSnhkqDC9W3kjQn922fVNiTeTg1PeTBG9onfQkX+jF5w8eQSW5sJw767F8R3Uar564X7EHeKIuM28dxwg8FDQrKysO864nYadhMGIRQF3OiVmec0itIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfxrjahA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1099C4CEE7;
	Fri, 21 Feb 2025 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143636;
	bh=7ES0SPMiRlraClgcS8merlzkxXeLOVw73ScNSfGlIBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cfxrjahA2k91T0Wsb3BYNrDu1Ikp7ntI1Jp9KZMHdni9hwyzTD/oWVhfing795ULQ
	 yyiwt5l2eSda0fWxseCaRRqA3XUtojCmqBSW2aLTdipLTwgJIH9SbPB7rGwgVRt9LP
	 5OOnaGcXnArQY/5OukY79XvbRJ9qucLlkfgWpOhwueJf8amz8ui169tYyVe6gWTgsw
	 TyBaVtVjbSGGdkWBUR4XhLrppYqYJew9BJRSDARMjAdFa2ZbP5zDSmMf3Fau7MuSlA
	 N4mbP4LZ4o5qqEcIuGJgbfSYX++LWyxsd3GqtIolaLuYkrFpww2dTCOPFQZ+hwreYc
	 JlF1Oc4BuSqqg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:10 +0100
Subject: [PATCH RFC 11/16] selftests: second test for mounting detached
 mounts onto detached mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-11-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7ES0SPMiRlraClgcS8merlzkxXeLOVw73ScNSfGlIBk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP4dPUl+v958TR7m4hXlEbcWpCl9ZvSYzfmda6ltz
 drnP2dt7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIhNuMDJMlDO6ndGR2P4h8
 GieYLfDkM/eZ5rOCyXoHEsSz5Y5L/WNkuByuvtn0XJ9eymlLlYgj3ZksaZydwZ4TJx/NPjTrpFI
 4PwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test to verify that detached mounts behave correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 0641d2e22e02..082fdf19a9be 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1829,4 +1829,53 @@ TEST_F(mount_setattr, mount_detached_mount_on_detached_mount_then_close)
 	EXPECT_EQ(close(fd_tree_subdir), 0);
 }
 
+TEST_F(mount_setattr, mount_detached_mount_on_detached_mount_and_attach)
+{
+	int fd_tree_base = -EBADF, fd_tree_subdir = -EBADF;
+	struct statx stx;
+	__u64 mnt_id = 0;
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
+	ASSERT_EQ(statx(fd_tree_subdir, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_TRUE(stx.stx_mask & STATX_MNT_ID_UNIQUE);
+	mnt_id = stx.stx_mnt_id;
+
+	ASSERT_NE(move_mount(fd_tree_subdir, "", fd_tree_base, "", MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH), 0);
+
+	ASSERT_EQ(move_mount(fd_tree_base, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	ASSERT_EQ(statx(-EBADF, "/tmp/target1", 0, STATX_MNT_ID_UNIQUE, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_TRUE(stx.stx_mask & STATX_MNT_ID_UNIQUE);
+	ASSERT_EQ(stx.stx_mnt_id, mnt_id);
+
+	EXPECT_EQ(close(fd_tree_base), 0);
+	EXPECT_EQ(close(fd_tree_subdir), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2



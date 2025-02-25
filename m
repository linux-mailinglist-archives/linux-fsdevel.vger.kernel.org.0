Return-Path: <linux-fsdevel+bounces-42561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E63A43B24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D881883E83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A1254858;
	Tue, 25 Feb 2025 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0Wh783J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A8260A29
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478604; cv=none; b=sQegRjdyYiTyQ8ShW+cFqbDmr6nJNLOVnFJicizfFh7aEWrpxP0sKuyzirfFOTz2cBlYOuaapbh4mvCCRoifptwBAxsZxsZSLCxZM+EY1OgQSbgyMhFDCnO6WBWmaukt7PeN5ZW/7tvDVKsN6/0+9BMNNC0RZI/EPMNgTR+p6s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478604; c=relaxed/simple;
	bh=jzgaL9QEFpgT1eLVjkZdeP1VLY3REOIuPXo96ADe/wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRr53bDveeRJZ2qYq8gsQ458pro9av4wL+4kH66crgPn5DmVaCvx2erzdUBvVal117twgDXw7VTbpLCXqkr8kyFs2xM5tX48FoBPASkY7yeNtwGKTIJcOTrVBW00aebft5vfzyCIwfFnKjLX7cNjqP24B9Cv5DPSuruNRMRp3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0Wh783J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA4BC4CEE2;
	Tue, 25 Feb 2025 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478603;
	bh=jzgaL9QEFpgT1eLVjkZdeP1VLY3REOIuPXo96ADe/wY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J0Wh783J3BPebhxUPuYnus+V6T07e3LRhudF9YijCiYzdr9MiMkx0goauNxFAACca
	 17yNGEP1XJ/QgcJlIld6nGz/+cIX0DaAdDx9yYsGEyEqcomQmVYCVzD3J5CwNuWvxh
	 2lAtU5rU7w5+Ftf+8bo9BY0fpQ2+4k9eBFrUlwpyzZri6/PAm7M5grq8JAAjlHY4Rx
	 somA1+kD7ZrkwzdcpyZmoOLKa9zfhvszwTUniZdKzC1j4C8V5TPgHI42LZ8fQ/tBjd
	 qOIfOynoacSUTOi6aTxsVZkSXOyf8G8/3QK2SmrwSpGhH1n34rsdTluNRSOnNO2UVR
	 gWMMpLK+ZSSEQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 25 Feb 2025 11:15:47 +0100
Subject: [PATCH 2/3] selftests: add test for detached mount tree
 propagation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-work-mount-propagation-v1-2-e6e3724500eb@kernel.org>
References: <20250225-work-mount-propagation-v1-0-e6e3724500eb@kernel.org>
In-Reply-To: <20250225-work-mount-propagation-v1-0-e6e3724500eb@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3349; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jzgaL9QEFpgT1eLVjkZdeP1VLY3REOIuPXo96ADe/wY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvndFqmfXwfS/n/otmjxKdE3WbDE4fXKi9zrjh2feGW
 Y9bduTM6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIaCkjw6nZIjtesMl8ZOad
 e+ygTNtOu91mPFf1o+rEL61adHLWrnZGhofPNBK3W3Vu/rVmhSPHRRO94vd6OqtiL3Tm/BdsPRk
 4nREA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that detached mount trees receive propagation events.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 1e0508cb5c2d..33fa1f53fdf5 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -2097,4 +2097,74 @@ TEST_F(mount_setattr, two_detached_subtrees_of_same_anonymous_mount_namespace)
 	ASSERT_EQ(move_mount(fd_tree1, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
 }
 
+TEST_F(mount_setattr, detached_tree_propagation)
+{
+	int fd_tree = -EBADF;
+	struct statx stx1, stx2, stx3, stx4;
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/mnt", NULL, MS_REC | MS_SHARED, NULL), 0);
+
+	/*
+	 * Copy the following mount tree:
+	 *
+         * /mnt                   testing tmpfs
+         * |-/mnt/A               testing tmpfs
+         * | `-/mnt/A/AA          testing tmpfs
+         * |   `-/mnt/A/AA/B      testing tmpfs
+         * |     `-/mnt/A/AA/B/BB testing tmpfs
+         * `-/mnt/B               testing ramfs
+	 */
+	fd_tree = sys_open_tree(-EBADF, "/mnt",
+				 AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				 AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				 OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree, 0);
+
+	ASSERT_EQ(statx(-EBADF, "/mnt/A", 0, 0, &stx1), 0);
+	ASSERT_EQ(statx(fd_tree, "A", 0, 0, &stx2), 0);
+
+	/*
+	 * Copying the mount namespace like done above doesn't alter the
+	 * mounts in any way so the filesystem mounted on /mnt must be
+	 * identical even though the mounts will differ. Use the device
+	 * information to verify that. Note that tmpfs will have a 0
+	 * major number so comparing the major number is misleading.
+	 */
+	ASSERT_EQ(stx1.stx_dev_minor, stx2.stx_dev_minor);
+
+	/* Mount a tmpfs filesystem over /mnt/A. */
+	ASSERT_EQ(mount(NULL, "/mnt/A", "tmpfs", 0, NULL), 0);
+
+
+	ASSERT_EQ(statx(-EBADF, "/mnt/A", 0, 0, &stx3), 0);
+	ASSERT_EQ(statx(fd_tree, "A", 0, 0, &stx4), 0);
+
+	/*
+	 * A new filesystem has been mounted on top of /mnt/A which
+	 * means that the device information will be different for any
+	 * statx() that was taken from /mnt/A before the mount compared
+	 * to one after the mount.
+	 *
+	 * Since we already now that the device information between the
+	 * stx1 and stx2 samples are identical we also now that stx2 and
+	 * stx3 device information will necessarily differ.
+	 */
+	ASSERT_NE(stx1.stx_dev_minor, stx3.stx_dev_minor);
+
+	/*
+	 * If mount propagation worked correctly then the tmpfs mount
+	 * that was created after the mount namespace was unshared will
+	 * have propagated onto /mnt/A in the detached mount tree.
+	 *
+	 * Verify that the device information for stx3 and stx4 are
+	 * identical. It is already established that stx3 is different
+	 * from both stx1 and stx2 sampled before the tmpfs mount was
+	 * done so if stx3 and stx4 are identical the proof is done.
+	 */
+	ASSERT_EQ(stx3.stx_dev_minor, stx4.stx_dev_minor);
+
+	EXPECT_EQ(close(fd_tree), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2



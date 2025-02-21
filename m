Return-Path: <linux-fsdevel+bounces-42239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9738BA3F5BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7146F426E64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD721019A;
	Fri, 21 Feb 2025 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEB1SfyV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3685921018D
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143643; cv=none; b=W0FfI9UtypEu/3ElExZP4canrG4btaVTQsvGWnxAOTfUescrTd+Mxt5MAYAgHxoq5bPzrJie+27pfkWO/OBS2i7E2RY1TMLZeIPbfteyQOuEena7Oa6X46Oo5ypucBYBpQNEQ9mCxSYFhTo35IbQ9U/TguX0RdrzfOrwxKr97m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143643; c=relaxed/simple;
	bh=CUM7AcjQ1bE0N/g/uXDnf5agWimRQMLUPaVINZNX1DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbzDtoQwrAmW0NxsXhHmO/u/CeTMsousuFJ02LKI6YtS8bxc47xc+wY0tK66mV9QPhYkggNfiqYVd2mmsPRXEst1LW+4w5AW6/PuQ8LyqLGjxigDUvIRsEgBVbQNm2+KqYo53L7ltPdmQeS1hWihhk039f4sPh4HVAkpmzrAZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEB1SfyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BF8C4CED6;
	Fri, 21 Feb 2025 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143642;
	bh=CUM7AcjQ1bE0N/g/uXDnf5agWimRQMLUPaVINZNX1DU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LEB1SfyVTNP/G/WJXJLByD3PlZClnsQEvkvfyHAk46wCJ1WnY6QyoZzYk3p7qvH/q
	 g9a/e/ZqHVsd0Advy1kKUhxhMa6x73kK1McjI4bIb29wdeiG9gBBxFaBl10tzp6H3P
	 7GeSqkAz6SRp3u86UqdBQWYJz7ZZkTQI5Jayx+tkKQspyk12/1eIJl2Ao9nSmB9pED
	 9/mg3qwS8HkPkglIwzjSuNqBMkwChRCmSZF8eDpn5OY3zbR/7rY8r60nEO9orFFUeE
	 ClVGqpbUIAB5brJ5BrrIYaB9efDGVNxFO95FVTA9wNvfUlHPGHGS+oObC4jnX3tGFS
	 l/5rbXo6aRfvQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:13 +0100
Subject: [PATCH RFC 14/16] selftests: fifth test for mounting detached
 mounts onto detached mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-14-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3683; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CUM7AcjQ1bE0N/g/uXDnf5agWimRQMLUPaVINZNX1DU=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGe4e/uhpEFef3iA6zVzsIcXbbtt4lmyCnr+VrCd42u0sKbqU
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAme4e/sACgkQkcYbwGV43KLZRQD/U2Nd
 N12yhLuxg0hTkZtQZx8Nc40DLV5i3w5QbKTgixIBAMA/K1/abcW8JALfV6yF9muJJV9GgDytR3X
 YYJA1auMH
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test to verify that detached mounts behave correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 0ee4e5b27c68..938c9e33ac00 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1939,4 +1939,82 @@ TEST_F(mount_setattr, attach_detached_mount_then_umount_then_close)
 	EXPECT_EQ(close(fd_tree), 0);
 }
 
+TEST_F(mount_setattr, mount_detached1_onto_detached2_then_close_detached1_then_mount_detached2_onto_attached)
+{
+	int fd_tree1 = -EBADF, fd_tree2 = -EBADF;
+
+	/*
+	 * |-/mnt/A               testing tmpfs
+	 *   `-/mnt/A/AA          testing tmpfs
+	 *     `-/mnt/A/AA/B      testing tmpfs
+	 *       `-/mnt/A/AA/B/BB testing tmpfs
+	 */
+	fd_tree1 = sys_open_tree(-EBADF, "/mnt/A",
+				 AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				 AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				 OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree1, 0);
+
+	/*
+	 * `-/mnt/B testing ramfs
+	 */
+	fd_tree2 = sys_open_tree(-EBADF, "/mnt/B",
+				 AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				 AT_EMPTY_PATH | OPEN_TREE_CLOEXEC |
+				 OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree2, 0);
+
+	/*
+	 * Move the source detached mount tree to the target detached
+	 * mount tree. This will move all the mounts in the source mount
+	 * tree from the source anonymous mount namespace to the target
+	 * anonymous mount namespace.
+	 *
+	 * The source detached mount tree and the target detached mount
+	 * tree now both refer to the same anonymous mount namespace.
+	 *
+	 * |-""                 testing ramfs
+	 *   `-""               testing tmpfs
+	 *     `-""/AA          testing tmpfs
+	 *       `-""/AA/B      testing tmpfs
+	 *         `-""/AA/B/BB testing tmpfs
+	 */
+	ASSERT_EQ(move_mount(fd_tree1, "", fd_tree2, "", MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH), 0);
+
+	/*
+	 * The source detached mount tree @fd_tree1 is now an attached
+	 * mount, i.e., it has a parent. Specifically, it now has the
+	 * root mount of the mount tree of @fd_tree2 as its parent.
+	 *
+	 * That means we are no longer allowed to attach it as we only
+	 * allow attaching the root of an anonymous mount tree, not
+	 * random bits and pieces. Verify that the kernel enforces this.
+	 */
+	ASSERT_NE(move_mount(fd_tree1, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
+
+	/*
+	 * Closing the source detached mount tree must not unmount and
+	 * free the shared anonymous mount namespace. The kernel will
+	 * quickly yell at us because the anonymous mount namespace
+	 * won't be empty when it's freed.
+	 */
+	EXPECT_EQ(close(fd_tree1), 0);
+
+	/*
+	 * Attach the mount tree to a non-anonymous mount namespace.
+	 * This can only succeed if closing fd_tree1 had proper
+	 * semantics and didn't cause the anonymous mount namespace to
+	 * be freed. If it did this will trigger a UAF which will be
+	 * visible on any KASAN enabled kernel.
+	 *
+	 * |-/tmp/target1                 testing ramfs
+	 *   `-/tmp/target1               testing tmpfs
+	 *     `-/tmp/target1/AA          testing tmpfs
+	 *       `-/tmp/target1/AA/B      testing tmpfs
+	 *         `-/tmp/target1/AA/B/BB testing tmpfs
+	 */
+	ASSERT_EQ(move_mount(fd_tree2, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	EXPECT_EQ(close(fd_tree2), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2



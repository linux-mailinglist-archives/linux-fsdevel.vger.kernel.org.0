Return-Path: <linux-fsdevel+bounces-42241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F058A3F5BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3172E4277D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022F210F69;
	Fri, 21 Feb 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvW9l7hn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BB111A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143647; cv=none; b=SrBLgNPc+QcDvxbpR4w6h1VagnEcOCEpx+v/PSbASMZVE/7168zC3WL0va1kEnd1g8FWQEE9Ku5LG2qPHESO7Y+KPxDKfI0OIjm4bZ1wUHoKHUMRVtlmYBS2CHNeCWQk17gNBX5Bb4WcB593Xq6qlOO9p0h8WdYK2mbKs4QCj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143647; c=relaxed/simple;
	bh=1clxT3Zpmz6FTLemMwi5prQ4u2yWEBWniWHuv5h5jfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qPweQekzVnS/XbA00CQ/wXaXVJ3b9Dfu5BrkefT3/NiXhsbs1hLom+7ntrPRiorWG3IIuW0EpAGaQtUwtXeZWUh8cShn0v+Q8+akGG4o81LDeqfR0YRP/2UcfJY+mV/z9jCspide781bxoFSrORUZPldaJZAIX7/shenrWB3LVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvW9l7hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D493C4CEE6;
	Fri, 21 Feb 2025 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143646;
	bh=1clxT3Zpmz6FTLemMwi5prQ4u2yWEBWniWHuv5h5jfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VvW9l7hn7oRsjVbePc8HdtcZQJedS9L/XiO97bRFhX5JuE3KI7DsR9M1Y8AtQh5fY
	 r1nn97ZJAnf6FLglrfx4dlkvG9C7mBA966Xe9jGPIpPkCY+v3URwH5cT9f7prMRvyO
	 6s2sGiwEoMr6XbxyUEVLGUC3em8fqTxqwXNxV6WlmFnMXJIBupzWIAmFYIPZqUkJu4
	 YbWBeJtBODwJjuUmTGF3niAbAbpdLTi1WlPxQ+d30Xb4f00SY07W1m69T8s0cTN4Fz
	 JMfojlaiols/7KsLXSlTxidkgwqo1v3Y8AUfrz9ZR+rLrCmxiA0t/nEFYZrspDdji4
	 d4GGD7K5kMXMg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:15 +0100
Subject: [PATCH RFC 16/16] selftests: seventh test for mounting detached
 mounts onto detached mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-16-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1clxT3Zpmz6FTLemMwi5prQ4u2yWEBWniWHuv5h5jfg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP496Vhc6vNGRYm7Lsq/rL785Dh/95pb6pzi/1tE9
 YyXGIc87ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI8mCG/0FdFxql9d5/fvZ6
 8nMmm4di/XH/A9s/bEtQM7ef6G3afIzhn/1945OSH6x53/p77vFI2R61g3Um7yWdBau6FKy5tr9
 W4QQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test to verify that detached mounts behave correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index d2bf8b77df3f..1e0508cb5c2d 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -2061,4 +2061,40 @@ TEST_F(mount_setattr, two_detached_mounts_referring_to_same_anonymous_mount_name
 	ASSERT_NE(move_mount(fd_tree1, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
 }
 
+TEST_F(mount_setattr, two_detached_subtrees_of_same_anonymous_mount_namespace)
+{
+	int fd_tree1 = -EBADF, fd_tree2 = -EBADF;
+
+	/*
+	 * Copy the following mount tree:
+	 *
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
+	 * Create an O_PATH file descriptors with a separate struct file that
+	 * refers to a subtree of the same detached mount tree as @fd_tree1
+	 */
+	fd_tree2 = sys_open_tree(fd_tree1, "AA",
+				 AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				 AT_EMPTY_PATH | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(fd_tree2, 0);
+
+	/*
+	 * This must fail as it is only possible to attach the root of a
+	 * detached mount tree.
+	 */
+	ASSERT_NE(move_mount(fd_tree2, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
+
+	ASSERT_EQ(move_mount(fd_tree1, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2



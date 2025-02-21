Return-Path: <linux-fsdevel+bounces-42240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B8A3F57D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93967ACD47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575F2101BE;
	Fri, 21 Feb 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsaAmlXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467220B814
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143645; cv=none; b=ZJrS9nQmgVk8rn6ykI+nyHcL/S5yxoBrftjhsniT/BWG4h/jQGZhe2FtkhNYxYcj62cSXOW0o/u6hrWys9TxnfLECiMOyMIcNl1UczqDVhSD6F1Wzs5i3dht8+WkZgI0OP0ntJHyfP3IvukmEsmkGCBco3vc9REhcRXWnAMHh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143645; c=relaxed/simple;
	bh=TikpQoOL5dJxg567LqT01WHKTVtVZgC7ie2DVaqsIHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhx4stf+YHXDT8pa/1wOU2wftgYBXj7A8W+iYM1GuzcqSrnI6vXrrD7ZbvLmrob+apZwmNr2qXtP0TNexFQfE8PjVXMlz8Q1/skRhSy7fQiJZYaQ1bxeIejkesd14VhRyvvkq13YS0MC871n28/gM6IFxUSrnqpgnjuqnRjrlI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsaAmlXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6EBC4CEE4;
	Fri, 21 Feb 2025 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143644;
	bh=TikpQoOL5dJxg567LqT01WHKTVtVZgC7ie2DVaqsIHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EsaAmlXJ/hfqvcN7nxNQpqnKOugsVMuoWjGyykXuY4V0my8NRTrAkvgBhmHixqkiy
	 xwT/lOd9Fmz2fMP6LqxOl8YFPQKRI13XB1GMgF33D369wDuRflgSNZyIZ5wOLU3oEe
	 Ge/m/L0a0r9JaKGzInQQwd+d935+jeOo3skye46qjCe4Rz6HfvOW1aITm6TMKthho0
	 8EzohL1iRXkMu1UatqzXLCRSNtnUqMx5Mp9E22pxwf28HNTmx0Gt3dV8eC86QvyyHs
	 o99/DchSQ87WLmfAw5mI0sPx3XfJTY8Z68hME378jyMeSVaXNsCMaTeGGcoH5NXoeQ
	 s9xrrs6JuRmcA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:14 +0100
Subject: [PATCH RFC 15/16] selftests: sixth test for mounting detached
 mounts onto detached mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-15-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2152; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TikpQoOL5dJxg567LqT01WHKTVtVZgC7ie2DVaqsIHc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP7tyt09mTmp1U5ql5X0B/bOtDvtW9P3t50qCVl3v
 WijyFKejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlsCmL47yuwcv7nma2JDivq
 gx+ZtczKvH5KeYZE9PcHPy9FL5Gd+Y/hf37ChKIEpQUL94TeOrp/mrDoB7M9BWU8Vt/6587afzq
 BlQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test to verify that detached mounts behave correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 938c9e33ac00..d2bf8b77df3f 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -2017,4 +2017,48 @@ TEST_F(mount_setattr, mount_detached1_onto_detached2_then_close_detached1_then_m
 	EXPECT_EQ(close(fd_tree2), 0);
 }
 
+TEST_F(mount_setattr, two_detached_mounts_referring_to_same_anonymous_mount_namespace)
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
+	 * Create an O_PATH file descriptors with a separate struct file
+	 * that refers to the same detached mount tree as @fd_tree1
+	 */
+	fd_tree2 = sys_open_tree(fd_tree1, "",
+				 AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				 AT_EMPTY_PATH | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(fd_tree2, 0);
+
+	/*
+	 * Copy the following mount tree:
+	 *
+	 * |-/tmp/target1               testing tmpfs
+	 *   `-/tmp/target1/AA          testing tmpfs
+	 *     `-/tmp/target1/AA/B      testing tmpfs
+	 *       `-/tmp/target1/AA/B/BB testing tmpfs
+	 */
+	ASSERT_EQ(move_mount(fd_tree2, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
+
+	/*
+	 * This must fail as this would mean adding the same mount tree
+	 * into the same mount tree.
+	 */
+	ASSERT_NE(move_mount(fd_tree1, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2



Return-Path: <linux-fsdevel+bounces-51915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88366ADD2A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26FE57AB9C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62A02ECD0B;
	Tue, 17 Jun 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B20I7xNq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9A2ECD2F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174945; cv=none; b=RLGhVy8IYB1MWpAfKtFonI6EUYzAoxaBkyrxOxArBFBfyqzDyiDyJPcxPPpHYCYUFPO6arf+En6WRlz+Bubchxohu3bhcFukoYK1Z38UBEWX8uQAuA4UqoGvGC2ABTa7SKAgAebt/Rjbv/xW0b0ViKEv3ZKn5lYj52ApbeRUG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174945; c=relaxed/simple;
	bh=lqp4HgX+oLAfdl7M76maixRqie1onJlHfXvyqDJjV5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHtUn2pMpsJJKmNXHJCHu9ghCG174Boqjhl0kJpvz+mzcCXr6bM8n3vdi5InkqSYj67Hz7ncBO4Cu8wxsS5T0QHKvlT9AHvNSJqOw/cFCdqj4DVQoA1yfouHlUDJpdMMSp/KQqekKQGVfCaZEI1QWcM2/b7hw4dtfG34e6gU5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B20I7xNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7B9C4CEF4;
	Tue, 17 Jun 2025 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750174944;
	bh=lqp4HgX+oLAfdl7M76maixRqie1onJlHfXvyqDJjV5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B20I7xNqkDXjtAfZH1dAwqWpDqhW5eWvYin38Ea3EU33CFby/HelzRrUwCbqnREc/
	 8cLaY4V4TYTEhRZrg1gNVHXeQl+gccjgr2qpGAc19tS/PKY+BRnjtcR9rKm6zsjfvd
	 KitFL1fEg4rPvsjrHTi4sgXTiLACEYAcQwDF7MKLC+tSwoJ+AjNSyDz8jAvW7UF1BJ
	 g8KiO+E4ipfEkdeZgi8N1ANkQoC1FK0Js1/6ueKF2saZzQOYYMA3DWwkvWyiRNMZG+
	 r/jTMGE/LR7Gi5WcHXkzlkW/K4zWzPRcIB7dr4p8ZZ/B6a91rJv5z5m3wzowyeT5bQ
	 eM4UzHNyU2+oA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Jun 2025 17:42:10 +0200
Subject: [PATCH RFC 2/9] pidfs: remove pidfs_pid_valid()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-work-pidfs-xattr-v1-2-2d0df10405bb@kernel.org>
References: <20250617-work-pidfs-xattr-v1-0-2d0df10405bb@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-0-2d0df10405bb@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2494; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lqp4HgX+oLAfdl7M76maixRqie1onJlHfXvyqDJjV5A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9txYe3XWxTDnDRa7as/ZuBRvPcEe+2j76y+Hdyb6T
 Favb7ni21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRV1MZ/ulrv5s2eVOjY4LT
 9K9W65Z7VFvUxMbE6bU0iL/PatDq8WD4X+Mf+HqOjrKVmox7jo60pmPqv/Opph4LGb6XrdLpbw9
 hAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The validation is now completely handled in path_from_stashed().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 48 ------------------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index ee5e9a18c2d3..9373d03fd263 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -869,53 +869,8 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
 	return 0;
 }
 
-static inline bool pidfs_pid_valid(struct pid *pid, const struct path *path,
-				   unsigned int flags)
-{
-	enum pid_type type;
-
-	if (flags & PIDFD_STALE)
-		return true;
-
-	/*
-	 * Make sure that if a pidfd is created PIDFD_INFO_EXIT
-	 * information will be available. So after an inode for the
-	 * pidfd has been allocated perform another check that the pid
-	 * is still alive. If it is exit information is available even
-	 * if the task gets reaped before the pidfd is returned to
-	 * userspace. The only exception are indicated by PIDFD_STALE:
-	 *
-	 * (1) The kernel is in the middle of task creation and thus no
-	 *     task linkage has been established yet.
-	 * (2) The caller knows @pid has been registered in pidfs at a
-	 *     time when the task was still alive.
-	 *
-	 * In both cases exit information will have been reported.
-	 */
-	if (flags & PIDFD_THREAD)
-		type = PIDTYPE_PID;
-	else
-		type = PIDTYPE_TGID;
-
-	/*
-	 * Since pidfs_exit() is called before struct pid's task linkage
-	 * is removed the case where the task got reaped but a dentry
-	 * was already attached to struct pid and exit information was
-	 * recorded and published can be handled correctly.
-	 */
-	if (unlikely(!pid_has_task(pid, type))) {
-		struct inode *inode = d_inode(path->dentry);
-		return !!READ_ONCE(pidfs_i(inode)->exit_info);
-	}
-
-	return true;
-}
-
 static struct file *pidfs_export_open(struct path *path, unsigned int oflags)
 {
-	if (!pidfs_pid_valid(d_inode(path->dentry)->i_private, path, oflags))
-		return ERR_PTR(-ESRCH);
-
 	/*
 	 * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
 	 * O_RDWR as pidfds always are.
@@ -1032,9 +987,6 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	if (!pidfs_pid_valid(pid, &path, flags))
-		return ERR_PTR(-ESRCH);
-
 	flags &= ~PIDFD_STALE;
 	flags |= O_RDWR;
 	pidfd_file = dentry_open(&path, flags, current_cred());

-- 
2.47.2



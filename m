Return-Path: <linux-fsdevel+bounces-51912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B10ADD21F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8331917D3DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFEA2ECD36;
	Tue, 17 Jun 2025 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTfhOtt0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DC2E9753
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174755; cv=none; b=iTTL+caVDTb9SkUwiUqxoZI9VcJjXpv0YvqVh/WzKKbwqCJeJY4zfmcykyh8Q5+4+KJn8Q5nANqEQvpbwvsbmuN5jLnYkLj4ekkfWs5LUyartgAMhJeR1NgNyPal9DUhUHkNtFfnd5p1kulY4PgiS0YPoM7Ad08oX7kwjV40WBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174755; c=relaxed/simple;
	bh=lqp4HgX+oLAfdl7M76maixRqie1onJlHfXvyqDJjV5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AaxAw3jdeqgaS765XyGX9z938je2s5Yf9Kd4qsHU+BF3GfR3Mxh2mngX+zcnTYPVEzahE2n9dr5ynLSU5Mu51e6Gqfd65KWF5S8r7+RXI1DH4QGjy4xygMor2vjEnq05IUJX4QvqKUx4yO7xzOLnEdzWKC+WuEUQcIG0CJhRLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTfhOtt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C4AC4CEE7;
	Tue, 17 Jun 2025 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750174754;
	bh=lqp4HgX+oLAfdl7M76maixRqie1onJlHfXvyqDJjV5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fTfhOtt02f3w2fsZnDR467CtVS7b7UI01lpLm4yVwiyKTXZ4Pq2XryXIY1YPm5A5U
	 mjVQsVZU+3EVe8SgzywBRdeZa6xcVU8u7wsTS0D1RyKX2Dg37Ny0pmb11+xo9lcw6U
	 zEqUwnMrH5XuLr5kIr1iXVv7ecR72y+U8ew4GudPBowQMDMtMiM3FxVz1CRnSxuS2O
	 pIYyIBx2iANV43j4AU6l5LOWMhuINiLQZQxcON1PahF5JLWZ66/3u1nPFD2hnNqPz/
	 StrrQi5MiuDz71NPfatyR9MgVn9Wo5YmW/vq/vxJyjVqH/kgDyRvqg98b3FKwq7LpE
	 YujWTZYdwIN5w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Jun 2025 17:39:04 +0200
Subject: [PATCH RFC v2 2/2] pidfs: remove pidfs_pid_valid()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-work-pidfs-v2-2-529ca1990401@kernel.org>
References: <20250617-work-pidfs-v2-0-529ca1990401@kernel.org>
In-Reply-To: <20250617-work-pidfs-v2-0-529ca1990401@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2494; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lqp4HgX+oLAfdl7M76maixRqie1onJlHfXvyqDJjV5A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9sgfcak2Ovor/L5gZeuW2Ys1f6nzcRalWaiHZjJvX
 Ooc7KjdUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGeswz/g7tKWe6mlWxIX9Wh
 38HrWL/xSdH/evtLR/bvq1VMYdCtZGTYdHLPPz7l33fcPP+1d55sd1HLuSLesNluy2IJN2vbdn8
 +AA==
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



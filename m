Return-Path: <linux-fsdevel+bounces-51764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6BADB2EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99611171127
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135235972;
	Mon, 16 Jun 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md+S+BfD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93531E008B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082581; cv=none; b=Aj6fmRHimA3dJrccyg1hZWrLZejJZkBpajGjvYK5/CPCPdI8pg3T5GkIPgaSalYMwW9Vz/3QvUxMQPZvh4/W55sajtgDd+XzLKBH+as+ITAY8p9pdU9X+Bi6BcLbTDhwl163WQrYw0YoYOdNlAwH6uMamLBz4vqDjoVqMcYjf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082581; c=relaxed/simple;
	bh=7LmUDLDhtimSjYbU4Qa8MpsmqyG/C+MrZAIzVuriqYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tiSbp26Cm241RhL0TsMOW7Qamj85GdjqQZ82hc6EP+eOkLsRbY5onFTfJF4f3At/wLWl8dm6qcYl090eztgn14HCRjyJSRYdRt99d5cW/vTcDqFav8D41yafv38bz5e0GTiHTttzNzZAJzqNpRKq2BvOdYL2uZE7ATqF04Ot+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md+S+BfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8050C4CEED;
	Mon, 16 Jun 2025 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750082580;
	bh=7LmUDLDhtimSjYbU4Qa8MpsmqyG/C+MrZAIzVuriqYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Md+S+BfD5CChXA+z/4eET7QkUdrG7krDhzpv2Vkf4HkBgxV96jGFjKGaoHDf5svxC
	 JaVLKkDKxnUeauVP86O+Gd1QlfcLgEPewNbLqQPIVevPynbeQkjAIWS1+lI/x/cTIZ
	 SGOpK5riOXURvR2SS0DT580lmFVpX5MOZ/qxnMqNYnCJQhb1BKRAq60GjQxZ0fkt8y
	 kI/Eoo8lvChkmiKOR8RvuQ0p/tqajoOaFVma72lfXj624b9fmAnV0ZiUzp45UjfZf5
	 ef0pyOdzZAyHGDfpeSSvV4Vt4xgY6UIKHeOVX4f7uQFiO8OEdR/xlxeF70XxtfsFiW
	 HSovYw63d+omQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Jun 2025 16:02:48 +0200
Subject: [PATCH RFC 2/2] pidfs: remove pidfs_pid_valid()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-work-pidfs-v1-2-a3babc8aa62b@kernel.org>
References: <20250616-work-pidfs-v1-0-a3babc8aa62b@kernel.org>
In-Reply-To: <20250616-work-pidfs-v1-0-a3babc8aa62b@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2494; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7LmUDLDhtimSjYbU4Qa8MpsmqyG/C+MrZAIzVuriqYo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEqAhMsi2/soU9JmB6Mc/WGa4ZlY3Hp+fNlrq3XnRD+
 mp5FbmFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNhOcrIsE2yQVDp3WsGRstT
 jVPuLhN6EPWH3fGe5jZe8Yb0Ca6Wfgx/pX4Xl4uyLz278sGSbWqP1wi8n1S/03qHqfYvNabZmYu
 5eAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The validation is now completely handled in path_from_stashed().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 48 ------------------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 69b10ec9b993..5d7bce362836 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -851,53 +851,8 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
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
@@ -1010,9 +965,6 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
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



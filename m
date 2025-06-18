Return-Path: <linux-fsdevel+bounces-52126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F5ADF81E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25B54A0057
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8521D3E1;
	Wed, 18 Jun 2025 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPtxE9As"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19E21CFF4
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280051; cv=none; b=XHirfPvzBV1mo64avrxZ2rbdooRjpu9mhNPfvHxJnQ0Q33rSIFL5gBNooCz3esKzSood6a0eFNV1OXySoTEEJ/lWVBjIDApv22A2pziu4qwbpHSxoixQZqQlw9nCvxOIs+YSYoZ070LNYUbmIDF6+HimuJQfQNHJiNtnw07xulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280051; c=relaxed/simple;
	bh=0itYpbskKx8uPFZF43TyV8k3UHlIRYNLQs/TP3EP0oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilHjDbqdYIeCbl8dZkNPqXG3XqrhpGgysR+TDc9xLVSkQmfecYH7mZ6KULV8VhzO8dU39nxG6em7bwjVeNU6n8GXnh+fpgoibC2Z9zaHDPr82YpQrPhl1N3o8eHtg2ZYLfSbQHWOoBg2Sh2Q49qX2ArRr7lkiGc68603NBvoEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPtxE9As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08B9C4CEE7;
	Wed, 18 Jun 2025 20:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280051;
	bh=0itYpbskKx8uPFZF43TyV8k3UHlIRYNLQs/TP3EP0oE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oPtxE9AsBgZvUN3APh4/assfjaYVvw4OOkYBcZj/efYkoivViO3qmfi75ulGrZrRZ
	 DT+HqwtDMcUmXnT933S/M250R5smGvlKbI4USvVCM8z8xa4q3r6IFTZA0D5rGYOD9a
	 DoGPVVRFKc7WbRgHmQfJuLUD9l2N1gNgjm1oidz6MK1brb8ofghf27SUbMKf9XHx07
	 NL3F0QUImM/CzYDhKGgJwv/7BbYuUWFzRIqOyhOcuik3W4SGKzDNiSHgwf+z9Mb6hl
	 yYzyzB4oicl9+L6oYVN+ePQzs/X0hQ5JcDW605UwcrSAqHdTzPPKGwzeeB6RjrzrOa
	 s3OVhMJCThVgA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:43 +0200
Subject: [PATCH v2 09/16] pidfs: remove pidfs_pid_valid()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-9-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2553; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0itYpbskKx8uPFZF43TyV8k3UHlIRYNLQs/TP3EP0oE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0eqHim4XWH1MyX59bYHh+Z++TRtWxozy8bSZOWUM
 Oe8+9YVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZJcrwT4dhxSoNjt1mX6v9
 Hre+EqxR5+ZaMOv3zZLalJbPbqKFdQx/uBz3vuZ7nHbX/rFWTbuupFuHYf37yfvFE58+Ej5T/2o
 9LwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The validation is now completely handled in path_from_stashed().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 53 -----------------------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index bc2342cf4492..ec375692a710 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -804,58 +804,8 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
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
-		struct pidfs_attr *attr;
-
-		attr = READ_ONCE(pid->attr);
-		if (!attr)
-			return false;
-		if (!READ_ONCE(attr->exit_info))
-			return false;
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
@@ -993,9 +943,6 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
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



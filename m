Return-Path: <linux-fsdevel+bounces-68651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E581AC633FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55AF935D1C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB39329363;
	Mon, 17 Nov 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHgkwmIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7672328B75;
	Mon, 17 Nov 2025 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372039; cv=none; b=riuiQiDj2p9dPYUgy8sqaw26hgrgtlVmP9X4a4WB8dQzP6KTEJleec2b3IySpLkui8s1oAboRvuENgmZHDDUt+H7GMd98bdm4Ok/qWNZkZPoZk7sHKifKXkkiNo0FNe671xFAUM0gaeqoiGz+x8vkLS1Qh+XS+zqQuLyoSzbbcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372039; c=relaxed/simple;
	bh=KFGHaLeqXLLXrh32v5PfFDZYIcKwEziBKk3OT7fXu5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBoO5JwTa4SEKisp37wSTTA0eAFSSD/270aOZv7Mcn8oSyEKaMEw9+KH4wsYi9S33br9KODJsOglei7ZWoiEJuTyxpGsl8zEst3xZ+32Z9RwQ40hWlM46ZZaIXN5yKo85u4aclgQ6SmnzFTOp7wVrDhAzmqrnR2n13caIYIRWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHgkwmIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE45EC2BC9E;
	Mon, 17 Nov 2025 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372039;
	bh=KFGHaLeqXLLXrh32v5PfFDZYIcKwEziBKk3OT7fXu5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qHgkwmIuVzz+SAVMlaVIohH0NKzF3mU63n5KpIFa7Pc+pUzaaLd3mtl2hK68mwCZL
	 3w8mHTguWP/6Kbj27ZJYnLeKhkteWTqO7tURyjUpYxwAhuQ4yc7RNMbsc32EMlU8QX
	 mc9FzxUXxFDO8oddnNLT2IHHHTevTGqMFxoLBwwPbrZzXIl801MHrEsJOw/YHCW2wK
	 WD49SI99wli7R+uKyMmO34psbDkDOjTA7GZx8HVZ7hojjKt5JbY73Di02I1+d9YXNO
	 eFJCuxI85p6YIzAnfA1w0zgepB/hu39vcVlwTDX96fLFaY2gxwJsxrd1NVtoJfIZnb
	 sg/kIz9+tTk9A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:39 +0100
Subject: [PATCH v4 08/42] ovl: port ovl_llseek() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-8-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KFGHaLeqXLLXrh32v5PfFDZYIcKwEziBKk3OT7fXu5s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf6SfoOl/uH6/VV7mxiVc5bU3BOd5XhRVeCm9OHaI
 qm8k2IKHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZKM/wz2jfg8WLtRS033As
 2/7w8aQzkvUrWvgiX9qsP8P/W/bNZjNGhit/eqsCZvz4tHx53/R5KznlVP3TptfNOvNtqfvhKad
 OnOYAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 1f606b62997b..e713f27d70aa 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -245,7 +245,6 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
 	struct file *realfile;
-	const struct cred *old_cred;
 	loff_t ret;
 
 	/*
@@ -274,9 +273,8 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	ovl_inode_lock(inode);
 	realfile->f_pos = file->f_pos;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	with_ovl_creds(inode->i_sb)
 		ret = vfs_llseek(realfile, offset, whence);
-	ovl_revert_creds(old_cred);
 
 	file->f_pos = realfile->f_pos;
 	ovl_inode_unlock(inode);

-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-68303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB7C58ECB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 401FF352274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637BC361DCB;
	Thu, 13 Nov 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAdXf6ar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D41361DD1;
	Thu, 13 Nov 2025 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051868; cv=none; b=kKi7Jo2KEZeUMr4LqXvxLMMhluaeV8kj+72pDo47IZbH7XV6TLMjVDsDHUVTCR9qsGcJQJTMc2Mm8R/AihJ9Tknmpmayiasf5IhSX9phv8/Lrsnp3bMH5G35npuuoNkv6l6lOBXDsvdaLlHukofWroVV8NjTQbrehf2e5JJvI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051868; c=relaxed/simple;
	bh=qQg/Z7zAN8VFyV20tut3UuqsxMt7VrM3Oe5gYpSqhIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=njV2DI1G6sIcWXthhu741lDCZDtFA5EvtSIA9BYdcO4mGj4Po+SSvpfCxrPOLc5iDYpCi4V9Wh4ifRcxU12bIbXGeJepkF/LCgBpxfVZUMsj5oJpkCLDLDU3bjGLQvFsyNVSpAhuUuWexo4X6YXTOHNatr8NrFKVPWxpiZc8n2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAdXf6ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A2CC116D0;
	Thu, 13 Nov 2025 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051868;
	bh=qQg/Z7zAN8VFyV20tut3UuqsxMt7VrM3Oe5gYpSqhIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KAdXf6arFjVmG74qXBVrLb/RLNpnWSf9MJkTH/HsHbtR1HuG8jnMsXkYM1OZVuPA0
	 EnxMhca+FvIwMYUbWq10jq6wnGV706C6hPyR8VM4xJ/xgiwBrNKKy13Hq90VFOHwe5
	 YuOaGq+KQsCihd+95VV2ujAdShsQH0FuWwVCbX1eNIOIKPQuHYygDQLGKZ5Wx34Yj2
	 GGpE3QXjo3wDnTFeawZ33Hf+ybKGQgdv3IKeP5MCvYGQTjzJZXovDqAKn71wuGMD9s
	 cgtBzMjFTjOaxI3fKNhT4+OsR14AUerLDSfIIqWWEys8FK82lmzq6TfGh/TKrrl3r/
	 eJlMmLC74Lj1w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:15 +0100
Subject: [PATCH v2 10/42] ovl: port ovl_fallocate() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-10-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qQg/Z7zAN8VFyV20tut3UuqsxMt7VrM3Oe5gYpSqhIc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbpZRGwsKTp0PPk/65ueqIh464CeUIengpsWrbGq8
 zLi317TUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGVdxh+MZ3I+nR/+8bIcPWF
 Eg4yzj0s5eft8mutuY+mNL094az+hOGv7PXED3pcz7u3Lts18x+nDGdizh5ngfqGQyITVudbcKt
 zAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 6c5aa74f63ec..28263ad00dee 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -481,7 +481,6 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 {
 	struct inode *inode = file_inode(file);
 	struct file *realfile;
-	const struct cred *old_cred;
 	int ret;
 
 	inode_lock(inode);
@@ -496,9 +495,8 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (IS_ERR(realfile))
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	with_ovl_creds(inode->i_sb)
 		ret = vfs_fallocate(realfile, mode, offset, len);
-	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file);

-- 
2.47.3



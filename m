Return-Path: <linux-fsdevel+bounces-68366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AFFC5A311
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6814A4E9C41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006DD32692D;
	Thu, 13 Nov 2025 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9LOVxcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C720320CAC;
	Thu, 13 Nov 2025 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069548; cv=none; b=P22J2pOt+TPaX8MBYNbEZImbVtZO308YJh1nSUeR83COH80k0lap9T+5MNPnjb5afVLvHF/F46l8p6gPPFdAMCxQXu1VETZOZHKJRpodbH/VUSpOVT7rVW98dJa5V4KS43fI0mNROkrA4RMVlh44W4UcPS2t6IZKJyaXwFi9+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069548; c=relaxed/simple;
	bh=NoVjUYZ1utZcTOi9AJM0qIsrY7IB57NX1QwQdKEtCe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3QblBFPy0vMjfS/iqi/zEAgqrtfrOHT/X2ibltAk6ySEoL40O6D0C44bPsMI4pLI41nLPeKndOoNgCg3/NIHLdCRigrIi+5OQWIiCcmS+y7fYIMyVCrer7MV/4FWiodmIU0RubaHyJYLT4nuac6eZ4HKWlSti+ZViEO+QJv+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9LOVxcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7102C4CEF7;
	Thu, 13 Nov 2025 21:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069548;
	bh=NoVjUYZ1utZcTOi9AJM0qIsrY7IB57NX1QwQdKEtCe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e9LOVxcBWFpI2KygThMEr5AYpQpKPVeePLcjszBJRq3Z+GLSkvvSEgxHEcG8NTorS
	 pPBIs1G3n/NVqkb/7s0GAcgkk31LJguFAKVOhRRQkWTRoByWYTLiH9+fJ9WJh2yANh
	 q7iio1tIIM3ursmEEqS24qwD+hXNdSRZC3935UaSuYSL0Qmzvuse1xlhq3u+JkeN/u
	 NpUa59cDLpCvTew3kLrCiA6t/H8AxNWfb+w5K39i9BLkt3TLXctx0ZYD8lG4GuHghn
	 TDoKcQD4mlWYNWoc9ZmwlRP2PReqR9vHKorDb+jL0TFo9/BK8H8jR5oBWsFgI2Rapg
	 C8ovvTEtfFl9g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:53 +0100
Subject: [PATCH v3 10/42] ovl: port ovl_fallocate() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-10-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NoVjUYZ1utZcTOi9AJM0qIsrY7IB57NX1QwQdKEtCe0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YWJC2zqv/EvitUlx5u/POhMmISE/6+yy5ceW9xj8
 /vSfeFORykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEROBjL8d48RfheTMeXnwrNN
 yr0XFkbyRNonnlT6UPopis9HffZtJkaGdvsDJyIzWRTez9OQOVHVaSlYNvXIDMGXanuvW92O+Pu
 NAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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



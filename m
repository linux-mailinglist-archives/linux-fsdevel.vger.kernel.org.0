Return-Path: <linux-fsdevel+bounces-68647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF64BC6339A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 321154F1D62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD65328636;
	Mon, 17 Nov 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzVrny5+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14466328617;
	Mon, 17 Nov 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372032; cv=none; b=XibNc1bgzVA0dc/ObVUZdKQmogUBUjK0OV8roppTf4+gvn96UXgxH7Qn0kSOI1fYoELsO/TEuPIIdF+sTZXZw7ISLojUpnEpWQhytL8pc/1jMfOLrc/yd3uIX6Zfr4xp2j2G02KH+ALMbInzCRTm1v3Z4qKy2DtBK8fc8ka1sZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372032; c=relaxed/simple;
	bh=PoqS5RC6mWfN4ESvPtp+W7dgI8cqy1lmKFGiUe5AKOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UByx4+vQrp7dd/I2HTsGm6WMsFYRRO0njBCEqxRXUwpzrwxmnmZbRxhbU/hZBk8UmLvD0qER+sUu9FtWeOOQt7MfUBQicUgvZOqI7Np9puwQRNJAEeFmTvTjbUUSJybww0iIRYlA2niHe0tmc+7TWqWVyWrlykI21V9PCIcZKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzVrny5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0838C2BCAF;
	Mon, 17 Nov 2025 09:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372031;
	bh=PoqS5RC6mWfN4ESvPtp+W7dgI8cqy1lmKFGiUe5AKOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WzVrny5+tZQBcCGJRdHhE510/YCjSKIi8szo8pge6ebx3qYp35Oio7ifVhoKV9Byk
	 ddT0Xyp+FRvG433M/0hWHCVwCMSCXXUiyz3EVx1MtJO0lLIaBFl07kpeVhxqLTwHnS
	 Ab4J0aG6MgU4N0OxhfBI6upWEF2e5RWtvZozq3MKzIlXoFHQ/Pull5ExZN/h2rdMqq
	 CYw0/wD5hhIvFpgWWRyAyPYHoipKdS7f9+U0mKUbcWDylj/F77uJzx+Kgns3gaDOlK
	 VsRo6aYrWCawKAOb5CQ0GY8dFzz6Bfcx5c1IsA1ooaIt5J1+UkOmJciJYZ30AnOnjj
	 ASbQF3SfdWSYA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:35 +0100
Subject: [PATCH v4 04/42] ovl: port ovl_set_link_redirect() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-4-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PoqS5RC6mWfN4ESvPtp+W7dgI8cqy1lmKFGiUe5AKOw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf7S+SPmiMl/2V0fp63yC61x2Xcy987se1Xf/p6rK
 7wea2RQ0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRHG1Ghj175hrYtL7ZZWIk
 uk7n26TrX3kj3lX1Gp1VmPh1igDD4xZGhkdqbgufeq9buuhI7omtYWwHzFIubKlf5f3UcvrJLwL
 fHZgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 93b81d4b6fb1..63f2b3d07f54 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -726,14 +726,8 @@ static int ovl_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 static int ovl_set_link_redirect(struct dentry *dentry)
 {
-	const struct cred *old_cred;
-	int err;
-
-	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_set_redirect(dentry, false);
-	ovl_revert_creds(old_cred);
-
-	return err;
+	with_ovl_creds(dentry->d_sb)
+		return ovl_set_redirect(dentry, false);
 }
 
 static int ovl_link(struct dentry *old, struct inode *newdir,

-- 
2.47.3



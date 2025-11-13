Return-Path: <linux-fsdevel+bounces-68244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14162C5788A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03C3B4E1CC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10552352942;
	Thu, 13 Nov 2025 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqqoH++j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E17E352953;
	Thu, 13 Nov 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039000; cv=none; b=LUA3G0SD+eOFzbjmGT5AlXettnAiu1NTY98RuU9aL5qAs/71QbnQB1b1mGRMjrSVqhk/ZGOijSLgltsijkHaWN8fGKJfk/lBRtk7itymJBKKCbG+ZVzGRz2x6k6sPzJ1/u/LsyaCx170M4MbNbprV0p+YszH/oIcoOc8zo0GMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039000; c=relaxed/simple;
	bh=id0jh7NbKUCTkfpXjnAgJmy6s+BWP7cXRuB13amyyQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7OmKL8sDHjRkR+sIg6P9o+eDwdcqJPdcu9OYbn8qaFzZ1CBDg6GIW6C7+WrOrQN/DMRykxtyq6Pue5Lk/bZ5G5VQkgXUAttbQlwz0svLkvoRp4fv91vWf3pr5elyfr+xR36IePpiMYbP0Juwu6y0CM08wjvXx+iBJwHJivD16k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqqoH++j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730B2C19422;
	Thu, 13 Nov 2025 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038999;
	bh=id0jh7NbKUCTkfpXjnAgJmy6s+BWP7cXRuB13amyyQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nqqoH++jKiuLo2eFqeLgCbLp8Ou3rYDNBvWqfRPM7lLJ7PtwJBc2f65vNHHO7YqS4
	 mkoy/gM7FT4JVTUFcDV16a7KBoSdwXOzhyZIWEG8FppB61mkAbRMXUERzYGq89DpJL
	 iPbMM+/YtnqsqUwpiPhIwqBMy4nTxHeJ47K/mbmRml1bdjDDgVX412dwFVBtaOiQb5
	 fSwB/n07prJ/P5cki1BAd2VIx3oLMLJWTEstVUubwMNcXwF7Eqp38Ravduk5DIgh5+
	 QdtERhpflU+vOxaxlEVY2hzBYwIoqsGQ/SEPsnX64pr8QnJxp/wRuLd5jQDix2Avxf
	 k8xVXJPX0pFoQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:47 +0100
Subject: [PATCH RFC 27/42] ovl: port ovl_dir_llseek() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-27-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=brauner@kernel.org;
 h=from:subject:message-id; bh=id0jh7NbKUCTkfpXjnAgJmy6s+BWP7cXRuB13amyyQY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvCEZZ8z737yo/roZtqy67tL10eUabQ+jD615cLl
 21brQ797ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIufmMDIer5gWpzq62EFrH
 ND2n6s3XFSLJJ4NvXK2vXdd1a4bEqjKG/27Lf6iaMHfFqL5gNDJI6tt2cHKk5Jx4bs1pn+R2BCl
 uZwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 389f83aca57b..502fcc0f0399 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -936,14 +936,8 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 static struct file *ovl_dir_open_realfile(const struct file *file,
 					  const struct path *realpath)
 {
-	struct file *res;
-	const struct cred *old_cred;
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	ovl_revert_creds(old_cred);
-
-	return res;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
 }
 
 /*

-- 
2.47.3



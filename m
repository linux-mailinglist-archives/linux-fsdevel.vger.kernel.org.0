Return-Path: <linux-fsdevel+bounces-68644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA2C633D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 025AF35C387
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66196327216;
	Mon, 17 Nov 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR4hsXHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA0260580;
	Mon, 17 Nov 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372029; cv=none; b=UcGGM0G9n4Xltwpo5Fnu63En20mGE1xYALUGLjmuYIt6huow/lkQ7xm5DYJi8PrqaJmDcoCeWkl7HM29AgThcsF5FG5MZytVsktIVyrjF0gfR92pdK5rJDdA1RyKStkBfhvXcRGILQKWzgrpxlTPA1DXMc9wPCj6LOaHeiaLqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372029; c=relaxed/simple;
	bh=jWaE5YKn/LlM2xmgC7PRVuH+dwbfgM8GZZeUmesP9FE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucVyGapMiJeZ8J9kMZw5FZkv/pxMkn6hbufOpP2NQKJVBi6RrS+puyNYCCp9tdYhYx3AUedCUzeTwgjU2VvKh2436UdPajYohA+zDjOn2TtAZNKgj2kRRVZe298P7xac0yEp+rWUygoyNNMxUtEoHgXdhwQr6SSzKSqTkRrEdsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR4hsXHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A440C4CEF1;
	Mon, 17 Nov 2025 09:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372028;
	bh=jWaE5YKn/LlM2xmgC7PRVuH+dwbfgM8GZZeUmesP9FE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YR4hsXHgvHT8x3n7NkAetBGbunDjHqoAKOHGDKTw1lN44KClbo5ut+DY4bj0zGjsF
	 cn0a+nIlQlDKsZf9YKfzEBRyU63eZmxhsM1Q2aaS7HDM0ZOYRBHUmSVK1KLk27xM+R
	 arT/+huad1+1TeUchhjL0FTHsWt66B+Ve7kwsU9Ecca7jQ+JssCqcZ9ktyI4cecvDl
	 c2BOwnXj7exELDwJTFa4Bse6+1G5D/nYeMeIj0kCeW5eG9pCQ1SFdOx0Jw83/yxUHE
	 8LTzt6RbebBwtXMPicZsaMQ4qYpfP/ISwL2vGdMkOoabWlPKpuNH9LUigvsCISSgYn
	 cwyo3zF9eYAcQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:33 +0100
Subject: [PATCH v4 02/42] ovl: port ovl_copy_up_flags() to cred guards
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-2-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jWaE5YKn/LlM2xmgC7PRVuH+dwbfgM8GZZeUmesP9FE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf6yjz8gwXPdHeYJTLVvLMxbPnYnXAqyCbI7pds9P
 5vjQk5dRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETYexgZvrk7Xmxm8NwneLwk
 2Xxudbmz0u1tF7a3Ptq3/vx1Zg/VG4wMv/ZsOJr/Pr8j6sfPqnY+j12Kbktctx5/lrQ4afE+vTR
 1HgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 604a82acd164..bb0231fc61fc 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1214,7 +1214,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 {
 	int err = 0;
-	const struct cred *old_cred;
 	bool disconnected = (dentry->d_flags & DCACHE_DISCONNECTED);
 
 	/*
@@ -1234,7 +1233,6 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
 	while (!err) {
 		struct dentry *next;
 		struct dentry *parent = NULL;
@@ -1254,12 +1252,12 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 			next = parent;
 		}
 
+		with_ovl_creds(dentry->d_sb)
 			err = ovl_copy_up_one(parent, next, flags);
 
 		dput(parent);
 		dput(next);
 	}
-	ovl_revert_creds(old_cred);
 
 	return err;
 }

-- 
2.47.3



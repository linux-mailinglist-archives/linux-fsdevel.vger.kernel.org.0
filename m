Return-Path: <linux-fsdevel+bounces-68465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01550C5C8A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A374356F88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5830F7F9;
	Fri, 14 Nov 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5gKuKN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E918730DD14;
	Fri, 14 Nov 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115343; cv=none; b=WsjGAq9aRzzL1LHqvccuCiXyiLy8BPEOwSt37quPGNh0W+yNjaWasGfA0fPlp2Wh3IU6qgi/oon50+J8FSON2HF4eBxanngQJb2KVnAXeRJvoeltg436it819oLgK7/HdzJ6VxHKc4bEFo4+KgIQuJQG6uRWKlawoSiFMLib/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115343; c=relaxed/simple;
	bh=yT1y1X7ltmRX13hx2o08J20FuFvNtmnHABDZSX7pQeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2zMhP194AlT4X2giZfLRvHkSMC+MmoWhsmP++UdGi8kP1QgAyiG/5FZUV8f0wsxZyyvwGb7ZafKpr13dtvA1GJfT35RCctHplMf+/i2/NyJwQKKG7osJXW6DdpisKjKEiZhdS5j+KwIm8f4OwvVT0L9vh8Xb1swOcl6LuaamH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5gKuKN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3623DC113D0;
	Fri, 14 Nov 2025 10:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115342;
	bh=yT1y1X7ltmRX13hx2o08J20FuFvNtmnHABDZSX7pQeI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o5gKuKN2wIn1ej3RhpwRpSGH8Xyt11L6nL+YRKF47PTPMdkRb7CmMiyuDFhEumrF2
	 gZXnslUwCE52g6oW4VxnA2sZ2SNlKNzKts9PHzZQEXn07PC5pxzUZpcv1gPfwtuzjX
	 S3YSo+8mlg+1HzngIAhBL5ydm4HWNdEc1We9xQh0c3vGz+x8714amaViaryj5Wefze
	 sCwUAH87rlDr6C3psIlBN+EKb954+U1+8YAwQnSe9eBMa5zHEjzeM9E34VtxFyPtta
	 DcEW4YovntZ7rjIu/G8+0xEkBkdYHlpEYsG3LlqB3f2QYLYbXdRJ8sprmgwtQDTNyI
	 qcTIlngkVWP+g==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 11:15:21 +0100
Subject: [PATCH 6/6] ovl: drop ovl_setup_cred_for_create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-prepare-v1-6-4fc1208afa3d@kernel.org>
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yT1y1X7ltmRX13hx2o08J20FuFvNtmnHABDZSX7pQeI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKMzoFLzEPrDuuz2O7aXag7rJvTzXiv5bun930dctkm
 eX+wWfZO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaydQYjwz2NrBm337txZ4hr
 HT7o1+dnufCV3PR93j5nps4+4bhF4Dcjw42i1/OCzuVvjpqp+453xjFt9W/bpWRXp9XVPLO59M/
 7DSMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It is now unused and can be removed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index d6a3589c0da7..7d365203dd0e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -611,39 +611,6 @@ DEFINE_CLASS(prepare_creds_ovl,
 	     ovl_prepare_creds(dentry, inode, mode),
 	     struct dentry *dentry, struct inode *inode, umode_t mode)
 
-static const __maybe_unused struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
-						    struct inode *inode,
-						    umode_t mode,
-						    const struct cred *old_cred)
-{
-	int err;
-	struct cred *override_cred;
-
-	override_cred = prepare_creds();
-	if (!override_cred)
-		return ERR_PTR(-ENOMEM);
-
-	override_cred->fsuid = inode->i_uid;
-	override_cred->fsgid = inode->i_gid;
-	err = security_dentry_create_files_as(dentry, mode, &dentry->d_name,
-					      old_cred, override_cred);
-	if (err) {
-		put_cred(override_cred);
-		return ERR_PTR(err);
-	}
-
-	/*
-	 * Caller is going to match this with revert_creds() and drop
-	 * referenec on the returned creds.
-	 * We must be called with creator creds already, otherwise we risk
-	 * leaking creds.
-	 */
-	old_cred = override_creds(override_cred);
-	WARN_ON_ONCE(old_cred != ovl_creds(dentry->d_sb));
-
-	return override_cred;
-}
-
 static int do_ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 				 struct ovl_cattr *attr)
 {

-- 
2.47.3



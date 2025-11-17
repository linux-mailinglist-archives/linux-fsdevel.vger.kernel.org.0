Return-Path: <linux-fsdevel+bounces-68666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07804C63343
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08C23A7125
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AFA32D45B;
	Mon, 17 Nov 2025 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbCmxOc2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C732D0F9;
	Mon, 17 Nov 2025 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372066; cv=none; b=m6eTrWjS5BvRsswzltSboqXrahPc9wFCrBILi1I00TlZ99mCbzdQGEzex2+mGlaqTIwzgqj3AxnE8hpaIVWy/ntKUd5jl/3XU9a9y0w3CE3NdSkU8W1wnFrkOQfVU31ZuqCnjPtikVbjCD/2ShPWmwIdte0Us1d+Qhtkq5RERAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372066; c=relaxed/simple;
	bh=+g/GluygF5pVg5i/7eHUgEExa2gHAg95DrhJtpYm2Sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cepi1kOZ30b6HLrLmPjnNHtpOFP82Qj/fSWMysCmjnD0fFluOBTa69ojrZPmMciUZqx1jD4vzBXq4yMO/VH6/6nSgIECeMZ7hCO4FfhiXAWbwLPoZ85Q98cgPGF4iFKcYHookoVX5MGPz8uIFuJi+zwK3yL59SbUxCmZqYFy0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbCmxOc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD9FC4CEF5;
	Mon, 17 Nov 2025 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372066;
	bh=+g/GluygF5pVg5i/7eHUgEExa2gHAg95DrhJtpYm2Sg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hbCmxOc2Rsz3/Aa2Cr117l4Ud9g8Zf4xObbp+M/iz6DpcRoeP2/mf/BbD/o6iIfMV
	 yibhKFfnklZUvdxrEDUEt8tI0kH7rmD+edtFLuKfcHPmMlcRDrDRY6/1SnEtYhX3qf
	 Qgrz9GRqxE/9cL8gyCHh2h2zDFthWr0yUfp3J1d/JzMldw+CmmC9mMjj3qonMx8cSe
	 NPTz0Y5tCJYQwc4fp2nYJfg+lAih73eDSSBfR6rBcxrXQL3j9qol1tYUBQYmj27r7n
	 mPVkD7UU2x/peUKT3zKUfbDuaazLRpXhoJGLEZVnRLaNrTRvHss/JLwULAI1ODbb1a
	 0FiHPOnaMWylQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:54 +0100
Subject: [PATCH v4 23/42] ovl: port ovl_maybe_lookup_lowerdata() to cred
 guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-23-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+g/GluygF5pVg5i/7eHUgEExa2gHAg95DrhJtpYm2Sg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf468WNcEnPpAY6/dw4WyW01Pe1dwZ+ieuPKsrCLL
 j+sfgZ96yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIPRtGhkU3F+cVTstLsUuR
 3ibxk2XfXD4tFaF5Zzdl/KmuPLSx5AQjw8EDIjP2zzieyb3Azr942g6O3fdqvCdeCpp27oGJ6p9
 oSVYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index dbacf02423cb..49874525cf52 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -996,7 +996,6 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 	const char *redirect = ovl_lowerdata_redirect(inode);
 	struct ovl_path datapath = {};
-	const struct cred *old_cred;
 	int err;
 
 	if (!redirect || ovl_dentry_lowerdata(dentry))
@@ -1014,9 +1013,8 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	if (ovl_dentry_lowerdata(dentry))
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb)
 		err = ovl_lookup_data_layers(dentry, redirect, &datapath);
-	ovl_revert_creds(old_cred);
 	if (err)
 		goto out_err;
 

-- 
2.47.3



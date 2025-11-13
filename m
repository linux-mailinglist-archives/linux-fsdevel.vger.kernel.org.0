Return-Path: <linux-fsdevel+bounces-68394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 427CCC5A3DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0B394F667D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2E329C5F;
	Thu, 13 Nov 2025 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7Xf5Lv1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2FD329C50;
	Thu, 13 Nov 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069599; cv=none; b=oQxaB5bf0xK5dyv4FP1r5L7bvwvkYjM0evQMjmH8jox1GQyj9hkhTuxOjBP4dL4Dcnq35ZcON4RIsdN3SEJTKMlWdwpbl2rIBvNB8CRogRpjkFAEIIuYmj7ZdaCYCmIX9M1ETicFR2Gvsj2frxvdqqJMMpFUK/OP8X/w5lUkLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069599; c=relaxed/simple;
	bh=tQdiCJOVAeQftK6LxowC47B1FIJEhrUOstx3PBXlZTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aoYLuut17uhv7RsrdjoIqr+5z6dc0il59h2/o6aMe7HOUMNTMrntOV8tLpeA2m4toO8BamgWUaoENoly8YSoMDAbk1uzrntImC0l5S2eJe+rOphgxHJvtpkEfwuPHszQZilMJsbnj/Qm+ZoxW7E3bw0tdbR5B8Na7L0XJsT/qTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7Xf5Lv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF80C16AAE;
	Thu, 13 Nov 2025 21:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069599;
	bh=tQdiCJOVAeQftK6LxowC47B1FIJEhrUOstx3PBXlZTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D7Xf5Lv1aqSJboGgH/hcpSPExKVMSTLHLat9V6XdqfEnRs6xEgTbUHgoWbx+vOS3W
	 J86yDjASH7jBVtKJv++ja2oQveGlkDXyV3PYEDnQR6rYrPNx8hkpdvd0yyWA+OUECr
	 3Vh/jxQa7XoNPyrVtyZDCX68vw+czdB7pozl8Lh8hC+RuRpa95MNnrlk+dLMdmo5N+
	 xD8MmrtyCuNdZ61HexkaCRX27PUQkJTwoi9JF3wcYLYmh/BlVVttQkCNiVx8a5ztP7
	 L+Ag06JrTG+/RDZxdr226sJIufjhYIF1ceM84qeJYcxB+7uIl5PY2APrnjDjVKTDkH
	 PuyKT9zv6baTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:21 +0100
Subject: [PATCH v3 38/42] ovl: port ovl_lookup() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-38-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tQdiCJOVAeQftK6LxowC47B1FIJEhrUOstx3PBXlZTA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+UXcSpT/YX02PfTv2Znq/x9fWhdTN0t60r0zEkVBK
 ndSvmhs6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIXybDP/ViW8lgw+uyLWXW
 EYce/ny0wePmqV3Tfq1jUdzn45q9JJSRYV7kv++qB6Iq5xX8eOk3J5v3uZF5lRNTwQHNpIRbEut
 tuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 4368f9f6ff9c..9c0c539b3a37 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1376,7 +1376,6 @@ static int do_ovl_lookup(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data *d)
 struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags)
 {
-	const struct cred *old_cred;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
@@ -1394,11 +1393,9 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-
+	with_ovl_creds(dentry->d_sb)
 		err = do_ovl_lookup(&ctx, &d);
 
-	ovl_revert_creds(old_cred);
 	if (ctx.origin_path) {
 		dput(ctx.origin_path->dentry);
 		kfree(ctx.origin_path);

-- 
2.47.3



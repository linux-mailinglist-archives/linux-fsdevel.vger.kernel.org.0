Return-Path: <linux-fsdevel+bounces-68330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0842AC591DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAD86563DFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13809369976;
	Thu, 13 Nov 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6ekWCnN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475835A94B;
	Thu, 13 Nov 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051918; cv=none; b=cST1cH75XESj/nCq3cGvHC5/tpIlhE4s7as/gR5A1hhPfFCrk1TXYZoSQhS9QFFwERvbadkMNuHop+C6tw0tY9uFxdqCvM/QCflGEYvz494/SH2T50vlsowwopeiCI1QtfOZGhhMjOQ53PYN9vs3/4YbmZYlIAATiFBdJ3YaCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051918; c=relaxed/simple;
	bh=50NcF/XCNCfqIL+9aXfSpk2ZLpaqzg3DDkBAlwMbPb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O97FrtJWG8HuPLxHbu8HLZPIes+Mc9z1B+zfHuA38M4RH2HelFMw5b4EgQz3PDVL8oTptaOl0CNQUt5F7FxqM/b12vm7BKh+45YSNlkRIlaweMMGGI3W/fkN3yUUoBG7e/GvIqiyfef11IuUcah3aM4SiIJOV6D6JdwJjn50xUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6ekWCnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16A6C4CEFB;
	Thu, 13 Nov 2025 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051917;
	bh=50NcF/XCNCfqIL+9aXfSpk2ZLpaqzg3DDkBAlwMbPb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U6ekWCnNAq11BxUcYNTtK7DUU2Aw6kuhNDhdrBt9ph8qi/zBQ8yF7I4U7ZCkOB6WO
	 /gFKBrJYSNzksD+1OVxGArfDAgRdoCe7LLmgv+RVX7cezKZIO2L3nzyu+uAgl0wLEz
	 eX0UA6c7zOCdm4zA8b0WqPCnmCPkQPUzXyqAWpCsTLWWlrlvBVIj2dmocDM0vMF/nf
	 yYNflnsltTlZ+zEvb6Wg3vyT9FbpRBRonh3v0uTZoVdf520m9S6H6hAiN8zxzbB4GM
	 7Vw2bqp9E2RHyiPOsdoVFqu72NaG5QpFGNAje2U3ARIx8ti565/F4K9vS/YW5PJGTw
	 FU0HDmDH50m2Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:42 +0100
Subject: [PATCH v2 37/42] ovl: port ovl_lookup() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-37-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=brauner@kernel.org;
 h=from:subject:message-id; bh=50NcF/XCNCfqIL+9aXfSpk2ZLpaqzg3DDkBAlwMbPb4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcboL3FQR+J7167fA7twVRz5ONjbhvWXjdaywy1vw+
 f3mucycHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJOMfwP7FcNZ/V5+zRVMc9
 U00PbNtbLP8pt7I+ducM50t/raxmH2JkmBD1muvY3IA1XPaaLpP5/s1XXh73QFjSvY95YcG6DYm
 FTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

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



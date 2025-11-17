Return-Path: <linux-fsdevel+bounces-68664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA70BC63469
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A634684B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815AF32D0C8;
	Mon, 17 Nov 2025 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nslTJZCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796032B996;
	Mon, 17 Nov 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372062; cv=none; b=IjIkd5TLIXh8QF0cabNvRczecZ5gp8wAycRf/Ytfq09IuIcjhvmyh8SabXdXkZ3X3X95D62AasRPYOGKqaPc3aaxrPZIIE9KLYOGlf7V0Ug9wCXTha2LvSq7vmvSsSZZS13lZPZyNugkdrzJr/5mIaZVtq3X+5Ibf/R/zXNa3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372062; c=relaxed/simple;
	bh=U7fo1b25mcxC7193uxI6I2izgbqi0wn9lOUyo/GnAtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X74BWCv684vke68qaVh5RdiwVkPynFCPZclFeqc1gxO/xfBG5R0v67ZwzUEVCoxRZBQccbh8sSBUT0zJIEjwTtNQQ3y0llKQZMpi/WTemNA4kv8UZN5DQDOWbZIAqPhje6y4JAKDeyIBfjBOrx9+vo0urEah5NoHcuynu4jif/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nslTJZCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C38BC113D0;
	Mon, 17 Nov 2025 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372062;
	bh=U7fo1b25mcxC7193uxI6I2izgbqi0wn9lOUyo/GnAtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nslTJZCkEpRjtfuJjHCyUH1CHQRfxWto18feYrrUTIHipFToIFqAhyLrsD/AjaGCO
	 hFxnJyMDFY0yAUEVnSp0xHyBCDYOJaZak8nGbHgTGPF1Z7yGkX4oFOgquG3Botlji9
	 pwQqm5rGFPSiGu05zApgokgPphn5lDGdkX3jcpLpqdCBWsaDLSdO/q1UV4LfDsRNDM
	 osj6FUyq2Xw1uGpWE/otSPWCVXWjx4BzPTpfpG9iHENYGt3rM+miQccaifNAdStcXj
	 q7fc8UQFHTGLvzBuWvpmWSXi5ue0ckhXs2iUDbn7ZbMoN/ojUgC9i4b/jnUB4yL37Q
	 x+hUHmfCojJ2A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:52 +0100
Subject: [PATCH v4 21/42] ovl: port ovl_fileattr_get() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-21-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=brauner@kernel.org;
 h=from:subject:message-id; bh=U7fo1b25mcxC7193uxI6I2izgbqi0wn9lOUyo/GnAtc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf7aeFJ5mm/b4qc1Xp/WeeXtiq0OOGbv0uy08fC1d
 xxZByJfdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk4myG/7UVh10sBa0YXX0e
 TMqQFflgsvf0edWVMz143p2N608OTGP478P1PPC8qO2dgKwlrPfy4n+J8s+9nnfrj61UguuEopK
 jHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 3a23eb038097..40671fcc6c4e 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -714,15 +714,13 @@ int ovl_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct path realpath;
-	const struct cred *old_cred;
 	int err;
 
 	ovl_path_real(dentry, &realpath);
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	with_ovl_creds(inode->i_sb)
 		err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
-	ovl_revert_creds(old_cred);
 
 	return err;
 }

-- 
2.47.3



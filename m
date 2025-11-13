Return-Path: <linux-fsdevel+bounces-68314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F43BC58E00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F4D3B9344
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3369366562;
	Thu, 13 Nov 2025 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc72ld8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA7035B157;
	Thu, 13 Nov 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051889; cv=none; b=iffez1Epvyit0ySdE8YIxjZKl3MKIA+lnD+PuXMFOjb35iInbQUwYedIDbTym3up/M441htYgscxvPkNucWarWr5L2vVw6uChlFRN64ifsv6mejUEQC3BXBf5hwMTg8Mz3/c2wwokfC4gDxQ2Rz0F4j88uUSBkf35hQ2Y1E4jkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051889; c=relaxed/simple;
	bh=4VGubPAlnRpXUixqX2KUafd8FQOO+JGZhfJ1L/vjEpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqnQ95PTMdv7E+FVoIqXSKY+bBzPoY7EK2ALDBJRZaw/2Wqhap0MS+u1lh+Kt0q9tG1B2YFoPxKhiYKqvY1pinvYnp1qc43T8iv9BsvImyyyd6jjscbyECPfhZszfYqQE44NGtrK4kIi6Pqza10Xro2+A/tINhQzlIqzMZOsJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc72ld8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD74C4CEF7;
	Thu, 13 Nov 2025 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051888;
	bh=4VGubPAlnRpXUixqX2KUafd8FQOO+JGZhfJ1L/vjEpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xc72ld8KilB8cRGMWeQpP14ySOmiqCH6qs2RcJPhX45UxqqOEWRUDp7+EScal/wSd
	 OFTtT4X5ojGtw5oWnFoexnh8tq9ASyatedsaetFxZM1272JGuhzmnZLQgHCbVWOp+0
	 pQVzJ3i7POPuhErVmtBUS0+u16Dbzt+5OBSi/+QysbXkwjJjCRJemkOD+QcKMrnnf2
	 I9SKOYVX52wmQUosbwh6PK9no/0++FCr7R+5ooqLrXUjrJ1X+r3N9ZVOAXEmRSJCwq
	 RwoG9NZ5GeIzrJDexZKsuMsQbAdM6JUB9n8p476aQ0lLyHi8jv85e6bS3hYoNsv8yn
	 hkiidG9zU/0Vw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:26 +0100
Subject: [PATCH v2 21/42] ovl: port ovl_fileattr_get() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-21-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4VGubPAlnRpXUixqX2KUafd8FQOO+JGZhfJ1L/vjEpY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbq1OdsL7roptrfmY+X84wZ1kd+Y2EyUS4yObuDd+
 7P0+IJjHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNh72NkuNeqdnSu4xnF/1Vs
 6darWn5c8o7U+MPP9/DCKeHV6dHdcxn+O+qllKr+edjxrPSyoVD/hBPHXFbmr96eGLBE98s9671
 n2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

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



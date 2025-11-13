Return-Path: <linux-fsdevel+bounces-68360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9FEC5A284
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AABB84F035C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D420325715;
	Thu, 13 Nov 2025 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOOKPoAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8839324B3C;
	Thu, 13 Nov 2025 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069537; cv=none; b=JCBo11524qjT+YAuGujo2go+sqwX8qUY7TG9efhpYBbT2Tv1v35nuxQoeOdb9RlcjIQ4nEtbc1eq/LEwKbw+nKVAMN6VVWDfcYU4ucJdg6MoKE89xolcLlJ1Fz2FWNovJ7RUiusimNtawzf52N0RptHLe/bTHgwEesJ582YQW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069537; c=relaxed/simple;
	bh=PoqS5RC6mWfN4ESvPtp+W7dgI8cqy1lmKFGiUe5AKOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQnrXsrmecPTDtxMUs8Cdqy/CmBXUqRtW7IUTIdO3dWLOcNmKW30GG2pESFz/DK1g3H8vJo+ZX5fRTkD0gyjO8N3unAQdCJyYZRyMmU08sN/UDvXoLNEX3RoMP2uXz021s5Ahpj3zfu0HUnV36bggbVGLblNF0LalJnLq91nUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOOKPoAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F359AC2BC9E;
	Thu, 13 Nov 2025 21:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069537;
	bh=PoqS5RC6mWfN4ESvPtp+W7dgI8cqy1lmKFGiUe5AKOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tOOKPoAFHVIFdJDFpRzHIgssl1HTibr6H3znZZu4iCB39PTjlTN2+IDVr3QpEmxyl
	 du2edtP7wGTPyrdNZp5RKU9I5MzNjrmHZU6YuAbILqXcF3WRjH/YJW/aj9IIPKYSiB
	 fe4VAipbILvSVT9mPeMS0RvIITVBFY4BE6u3V3Bu09BAR2DhOR7muO+QKT859UAxnm
	 EKyVswUlR0f3CcmN+RAUGXgKdWucrCe5IEUcXq7GEI1ic0xg3wK+5oazzI4EWS1eaH
	 /a0cjNdnmn180C32Gm8FgRSySckWxqXuf0O+z5ZlTjmaSB+32FikS5a4kyHfMQYat+
	 nI5BxYNhO3JPQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:47 +0100
Subject: [PATCH v3 04/42] ovl: port ovl_set_link_redirect() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-4-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PoqS5RC6mWfN4ESvPtp+W7dgI8cqy1lmKFGiUe5AKOw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YUZ7Oa5U2/hcaxy3/3+6MPsy89/tdUPfXt7F+Mp6
 d1hfufnd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk+hNGhu9qmdzmct+U+GSX
 advaf5yzyvaz554jpc7vj4XxM8+cIMHwm90yZ+m/5qO1zxyCbtX2Fyx7VXvCq0zo4BKrxM8PY/1
 VuAA=
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



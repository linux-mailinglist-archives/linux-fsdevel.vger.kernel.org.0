Return-Path: <linux-fsdevel+bounces-68308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCA9C58DF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD63426C63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF382364023;
	Thu, 13 Nov 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+ROrZ6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1D35A15B;
	Thu, 13 Nov 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051878; cv=none; b=ulFoMha1bSItGrHrTCCHWPmbQGWsSR211tE8gbWtv4vqBCdtATm2QWZe/edWlelcHkrTbjzIPMeS963W3/2RX+aaNnJJE7aAUaOgqL+Vjg5In6P+L+M2Otg/dqvWyRUHSOjkbj2EyQI1mieTnFHiMdZ6CAXDDB5HznmcDFMaJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051878; c=relaxed/simple;
	bh=vSZZ3kOjDoglfOlN739d6HlBnFXiDUMtxbEUkcA38zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZsdKWIrubtLwJ7iUQEUex5k+/+8x3fOFptlYR3Kn/nUtJNlEqY2Lq6T4C9yxq5I9Cy/pmjpmI1YLdxHBSjDnk8VtyINDzglzLubQXM2RTjLSe0z7nIZhVSThZSGnehRiz8rR/xL0y7040QdwZ1gYlVvIp3K6lscigcH1gij6xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+ROrZ6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67371C4CEFB;
	Thu, 13 Nov 2025 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051877;
	bh=vSZZ3kOjDoglfOlN739d6HlBnFXiDUMtxbEUkcA38zA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P+ROrZ6Qu0iAKdlmrgiSEWh7uOrg7REaFd1uNw4Ghs5nELEXF/1Kzi9sVxBjiOBXq
	 6V23s8sJcHNEg2UfimXLl75X1FyKKCcOr7vp6rFY0Dn6mQX5/lDx3/QiU2Jy4XA8Sd
	 HweF3rbfXsvbBXQkRy6RPwTHD6MY7UF/qnTnfmA5deqklFW56aeouHMJ4AqU5pWpdb
	 6179DVwFBQfsGo/jvLD5krN0nM+ahJhyH+5td40SvyoPBb6YYyfQcgKjctC4y1e+4B
	 MRHdXtd7uoUxU1F51QVdZAcIu6rtEpyB6lO1iOqhaKFBaBROuaTMO+Xa+QBfb2EpDI
	 oyzd0eOYuIsQA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:20 +0100
Subject: [PATCH v2 15/42] ovl: port ovl_permission() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-15-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vSZZ3kOjDoglfOlN739d6HlBnFXiDUMtxbEUkcA38zA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbo5lZ354/Ym2sLvlObZes7C5DB9yz1fGXbOzTao7
 Cjeulyzo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCI9Oxj+WexYc+LZWeeT5tIV
 1/kLb/wUPT1x6Z/sWVXvli++cy2fUYDhrwTz/ZcaarN5GCeH6DwoPjeV/dv9TE6/AxM6bl3mW5d
 4iR0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 00e1a47116d4..dca96db19f81 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -295,7 +295,6 @@ int ovl_permission(struct mnt_idmap *idmap,
 	struct inode *upperinode = ovl_inode_upper(inode);
 	struct inode *realinode;
 	struct path realpath;
-	const struct cred *old_cred;
 	int err;
 
 	/* Careful in RCU walk mode */
@@ -313,17 +312,15 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(inode->i_sb);
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
 		mask &= ~(MAY_WRITE | MAY_APPEND);
 		/* Make sure mounter can read file for copy up later */
 		mask |= MAY_READ;
 	}
-	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
-	ovl_revert_creds(old_cred);
 
-	return err;
+	with_ovl_creds(inode->i_sb)
+		return inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
 }
 
 static const char *ovl_get_link(struct dentry *dentry,

-- 
2.47.3



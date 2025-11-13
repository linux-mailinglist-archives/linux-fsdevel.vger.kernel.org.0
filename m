Return-Path: <linux-fsdevel+bounces-68233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313AFC57948
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C1E3BB491
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF213538B5;
	Thu, 13 Nov 2025 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3N4O2pD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538553538AE;
	Thu, 13 Nov 2025 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038980; cv=none; b=aLHVEeIs4wQGNVRGUrdlebsqqsJNTl781/DCzR5r2esBeWm3RGWXgbDJ/yY5MB8iAfnUfrY7/FeCh8yxmCNaD+p8CRRvqwQNPVKPqCOdxr/MLAo2iDX87ZoGefk9pUAe1qpojiSGfR/Z/AVGYTQzAEAGs9PNFlLG2uNgmdErAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038980; c=relaxed/simple;
	bh=vSZZ3kOjDoglfOlN739d6HlBnFXiDUMtxbEUkcA38zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLTupq0gLCQBfBFV1pTVWB5peJbS/msdbRoQWhhhhD5dStoDsKRtu4+Xk5lHmfJTbYwX8XZNtWBYEzZlr7Weaxygc/nfHcXP369WC+W9st8JWt0yx4pyaOhnghe2tYmNM1xmpEErXOzY8TTnO5KraY5dde+qxho36b9jJgMJ+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3N4O2pD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EE5C4CEF5;
	Thu, 13 Nov 2025 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038979;
	bh=vSZZ3kOjDoglfOlN739d6HlBnFXiDUMtxbEUkcA38zA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R3N4O2pD9LhQzbbwd+7A4MUdtCRcnCzO+gd+z28vBFS3MfiHI/g9sD3iKbX6M+C2G
	 0AXOcF2mYTz12Dmq0S796NiKgPmjS/5qgOPVBR+r5zdS1QtMONsKr/6SRpNp+M+Nem
	 d71tZUfKIGdKcKqRc3RHWZlBBcjm1M3xmSfUfSswTZ7U3M/fHF3vjpmUOHRVN70qpi
	 heIh1FSMASUtqCq0AecYkcqpK5QAPU/3zrkD09PChov+yZtSxL1/jh0kHfznjR+p/C
	 k4oUwwMNaaAa+BdGA2qBBgibZp5QtYZyXSdCuSg44wkkVNxAPwvAFSb72oIhkX5OOl
	 SFVDS95kuvo0g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:36 +0100
Subject: [PATCH RFC 16/42] ovl: port ovl_permission() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-16-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vSZZ3kOjDoglfOlN739d6HlBnFXiDUMtxbEUkcA38zA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvcIy/Hmz51aphCWZvGi8K9SpaaSoFXYrm2sMbxF
 8yZ9fdDRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQW9zL8Uz9y74A56x2taVfW
 BVz9fPDpfinjb12hR9PW7JO++7h2yXRGhtdMco26BVNi5vzb69zozeZ9+nVx/tcXv00V7x6dont
 ElhUA
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



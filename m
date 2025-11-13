Return-Path: <linux-fsdevel+bounces-68321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E2C592B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76A4A4FE9C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9F3624C3;
	Thu, 13 Nov 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPu7w+RF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47DC351FBA;
	Thu, 13 Nov 2025 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051901; cv=none; b=F7QPh7yEOxU9JwQi1uLQRDu6NK/5QoCk4kLgNcK7xtQaSB9/wh00oNpgSG07JNceFvTAL1yF3C+G5c/bSbvyUTrzRAKx+GyUmJ8/bxZValnkcXtIvzkJhtIYLZEjpFqxzDfwCq/MEDLBJUbJM/yEVBAAQNyflNHacKAyL2qlJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051901; c=relaxed/simple;
	bh=O3U1D7mY4/CvbQNcbKeeoYRLD3HG1PhLW8qHUImHGeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HaFjiH35Z7yHnoAgj5t0/hRyKuGg/fNgRkiAQIz5jx9Ckydvc9U9KcWkYQS4d1o7pzi6tnx/A9Bm7bzSrf5dXDbxIdJOz/UrZBhsdZKiKMmwaW3TZ4WGlMLN2GYg9nwR5tTBXGC4Kko2vjYbUwKtczUNAwDY/MeMMJZaD3V+1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPu7w+RF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54517C4CEF5;
	Thu, 13 Nov 2025 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051901;
	bh=O3U1D7mY4/CvbQNcbKeeoYRLD3HG1PhLW8qHUImHGeU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LPu7w+RFDQkKT5LnX/IomJlLTSG7oz/4mSyzkHwjs7bVWTbgZQwpcw+39epMBw8xM
	 AXRMCqIS2zfbOWmnDdrxSKa0KRlP3uvmz/CRXsxuIk0FkT6Q7zRI6yLighFVlV8b/C
	 1Kw8RuoXEScEPNC2NKKyiRzy4Yenr0nyFBwb8GVzoNguyj4uk3HxmlyJdQjbllzkgh
	 wMsPvWNqBWkWvM7B+k8vtVlRARMXEPPFCRfCgPXy4vLH6ky2h6EiHG8+hcLTgY0Fxe
	 J/3y14tqR6KhWsGBPIeyFdhTg5nW7AaoCUc2TQsniRf7ir5nb+jxmmpxo9RmeQpYpn
	 5+yckirJDLFIg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:33 +0100
Subject: [PATCH v2 28/42] ovl: port ovl_nlink_start() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-28-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=brauner@kernel.org;
 h=from:subject:message-id; bh=O3U1D7mY4/CvbQNcbKeeoYRLD3HG1PhLW8qHUImHGeU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbq7NklPf/lYIGXZC5Nls6Lf5LpeSFgTJqsfW9iV4
 64T3/6mo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ1nowM99TXvjL97BdlJfmy
 a1PnWzOBBRrnvZ9MLm5LmLnltM7FuQy/2SSk5Pfkv5nZ1Cq/9Lan9czPq3uXlgsUxTYecfx7tCG
 TCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f76672f2e686..2280980cb3c3 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1147,7 +1147,6 @@ static void ovl_cleanup_index(struct dentry *dentry)
 int ovl_nlink_start(struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	const struct cred *old_cred;
 	int err;
 
 	if (WARN_ON(!inode))
@@ -1184,15 +1183,14 @@ int ovl_nlink_start(struct dentry *dentry)
 	if (d_is_dir(dentry) || !ovl_test_flag(OVL_INDEX, inode))
 		return 0;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
 	/*
 	 * The overlay inode nlink should be incremented/decremented IFF the
 	 * upper operation succeeds, along with nlink change of upper inode.
 	 * Therefore, before link/unlink/rename, we store the union nlink
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
+	with_ovl_creds(dentry->d_sb)
 		err = ovl_set_nlink_upper(dentry);
-	ovl_revert_creds(old_cred);
 	if (err)
 		goto out_drop_write;
 

-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-68384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A417AC5A2EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E70964ECFA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F52328612;
	Thu, 13 Nov 2025 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTvyQ9Wj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47693328608;
	Thu, 13 Nov 2025 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069581; cv=none; b=PTA1OCyHWFoj90qrTbMgIu40NBhctOrfJ3K9XMxYQlt54BAgzoomqtY8iUMTC6xuFgtlmORHBbp9lVhfKcztje6xNZlOp6f1RhXVC08+ui/1cHerqHm2fvRIc0m0SpWXRIz5JrYyunDRtqTWican5CMyuHPe2Js961n2mfi9GqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069581; c=relaxed/simple;
	bh=rPoSuECMAKBN9m8sbIu3E2PkfIRUFNoqozRYSn9OzDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUzfCMvNUcZQJa6WQXjsCz36Z3Ks4Nap61zdaaCn1JwuRwUUhgme01hRZq9M8h+57fYbn75crtr6tntSNmYSVQb2I4cD+/vsnNmS+sSyQLQOApxHEXrQRipVCHLCGCVDtA1Xphe4fLamj9Wi2PymVJAbPje5e81zvODKjKdtlBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTvyQ9Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC760C4CEFB;
	Thu, 13 Nov 2025 21:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069581;
	bh=rPoSuECMAKBN9m8sbIu3E2PkfIRUFNoqozRYSn9OzDE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RTvyQ9Wj9lDNTIR4EgTiabkUwvx0xCk++2UMjkJUc3WINYnxdJZ3yArfq+TyGKmc2
	 jLUyQaziyeQI+GUJIwW5DxRChKZO0XF9ecfo0cev8uFdTjWFGtS5Jog8ycZNrsFOQU
	 NHsXXU7Zu/o2r8VeeGt53EiSfWM9pM5QLU+Qfe2jtU6Z2X8njRURJInaPLVH3P+Dbd
	 yLMNWc27kdEC2cmkZEQYn1R3c8X3edPbpucweg7mqvXKc0GmmnRn1Tsu71Hc7FQu7w
	 mFYpYOnO/YRRxmT2UUxEMDLFCNUWi6oaPdlZJRMJa1E8bONQs/ThBXYwI5bPxo7YQk
	 qX64X2zYJZG+A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:11 +0100
Subject: [PATCH v3 28/42] ovl: port ovl_nlink_start() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-28-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rPoSuECMAKBN9m8sbIu3E2PkfIRUFNoqozRYSn9OzDE=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGkWTlfIVbftwgDUeX5iqjMcAJYYFFH4sNDJBDchMDUzvWUGY
 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkWTlcACgkQkcYbwGV43KKN4AD/fNZV
 3/yGB+s7jm77PPTPwYr2m1ZDuLD1WVc+l0VL1BUBAI9c7+5RhIPGPJrc8u3HmFRtKbyAxx/y8rE
 DvAFAXLYD
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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



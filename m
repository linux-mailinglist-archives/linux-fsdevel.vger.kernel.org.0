Return-Path: <linux-fsdevel+bounces-68375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2200EC5A2D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 003BE4F23CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B634326D79;
	Thu, 13 Nov 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH0MKqWk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931A3254B6;
	Thu, 13 Nov 2025 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069564; cv=none; b=GKQcdmPUItX5si7GOv4S+Y6Jvm6weYYzirE6dCDFkuR+IxdN+NDC6FPHfAw3IsLIMuTdgMl3GQ68L5RojgZrN7ojO7WuWelsVuBWflwRwB8iqjIODgcg3YIW/3zEbAI0agbXQrWsZs2RqxCiP20l+ryZ9ydA2bIbQaz0cOKJkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069564; c=relaxed/simple;
	bh=Iart+ZiBD15gJWXZaXHTY4U2G+xILumZmopHdJ0h0IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7eq3qEWzQZllPPLuGQUEjvwEedtAAYmx4Dv1kQT42pA8e+Sk6V1/NNtEmknJbJ3k9JBkTzvykM/J0MtpdiAOPk0XrRD4T/Q/JJELqN0vvT7BHRz9bU6wvuVBwcc5o9pZIqBTTHrl7JIF2sgDg0IhJoqocpfe/DaQjuLuc+2klA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH0MKqWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E073C4CEF8;
	Thu, 13 Nov 2025 21:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069564;
	bh=Iart+ZiBD15gJWXZaXHTY4U2G+xILumZmopHdJ0h0IM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MH0MKqWkelgYjWUI48IGY1XOz/COK0HhqEtxiA7a44vNKaWNELtLZph5q7ZuqI0WR
	 JSZwvx5+Vb57R42IyuaYbP5+PUXo75zvNewIVDr629HLDH/CKxDCXSC1NQDR0aBhAR
	 /3G4/4celO3JL7cp1HUpah/PIOsqj58W4kh0eXJnwx79zY5SSUHDC6HbmclPBK7T3B
	 0qb4XCCJbG/LMbX5EXdqIfTLysyAn82g1QY0Aqb+vUUGvBhEnFJ1JfSt/eT2BMcztL
	 wVcQSBhc6khXx3Osatirb7Nx0cPGwZuvNh9nr5bTjibgc4+r6WuWiE7rAF/VJjT1uk
	 +I6pe3mIRfekQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:02 +0100
Subject: [PATCH v3 19/42] ovl: port ovl_fiemap() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-19-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Iart+ZiBD15gJWXZaXHTY4U2G+xILumZmopHdJ0h0IM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YXruW+Xmv3PL6TtdPOGExV/dI9J7hBcvGCJutjfr
 0GnMjhmdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkviYjw5Gl5pmsT783Xvbl
 4WybNy8kc53D5OmZR5dZFL1R+Z+54TjD/7iA2dEHYm5uW/26VtlkynlBf6Uy971LVHfs5buxauZ
 dG04A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index e6d6cfd9335d..5574ce30e0b2 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -578,9 +578,7 @@ int ovl_update_time(struct inode *inode, int flags)
 static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 len)
 {
-	int err;
 	struct inode *realinode = ovl_inode_realdata(inode);
-	const struct cred *old_cred;
 
 	if (!realinode)
 		return -EIO;
@@ -588,11 +586,8 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!realinode->i_op->fiemap)
 		return -EOPNOTSUPP;
 
-	old_cred = ovl_override_creds(inode->i_sb);
-	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	ovl_revert_creds(old_cred);
-
-	return err;
+	with_ovl_creds(inode->i_sb)
+		return realinode->i_op->fiemap(realinode, fieinfo, start, len);
 }
 
 /*

-- 
2.47.3



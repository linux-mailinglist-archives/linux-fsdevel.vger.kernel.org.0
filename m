Return-Path: <linux-fsdevel+bounces-68234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9EAC578CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFAB634F947
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2BB3546E1;
	Thu, 13 Nov 2025 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uowl+HdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275935292A;
	Thu, 13 Nov 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038982; cv=none; b=pPUtDgCmSAebjQaiSFcpk62z1j7rSmC2izvV2GilFT+aE7Ey08wcSlCz4V5svUKPROxaabehPNdSQ0jD2O3nyt4+LXtr79dea7qC1yenlJ9wK/dTiLRgQs4L6ArnOzq60i9wnKXYNhUyRufliDYobbV+QZuQNTjw9ikkLg0tuC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038982; c=relaxed/simple;
	bh=qDyOOnsKgjDMJECVSKZHFCLTntFUXNRakxJ39KMrkIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnV1dEK2JQ+xWzDwiI3zNKkhFnKmara7+Vdk3Hn4QV7cMiO06EM3Xxt2n2DZE9MENo9II+UPqyYKXLtwGaHvnIUHSF+YT59OORAN8r2GUjy36e+5uOhEhfxhg3IMTYnxyEdHvUKoa6WsmBOnRUCuNbzhN2YVAdktoqslXurnvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uowl+HdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A832C4CEFB;
	Thu, 13 Nov 2025 13:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038981;
	bh=qDyOOnsKgjDMJECVSKZHFCLTntFUXNRakxJ39KMrkIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uowl+HdFYyw8a9EWxH9Ad07w7lQaeORNwR7MS0/eD1MkR3UE+2Ra5EacTiIua9CA1
	 0dlO57gXQI7eQrW6ixySFlrOgaz2+VQpr2vgTABhnF1KrEwMsTl40Hp4l3xrIJGJAQ
	 FPx6jHCqBsY2Vaoi41TxavITNl77HtEVutD/CpHE9ML4PEbPU838gwdxxyKOWTKhfu
	 5zDWfn7VcTShMMHnWutPHRBOw5PcxgBXG1Bb1ApdC9LSieM/smgCwFBfEjDyk7RcnM
	 su/hMV7b9w0eK3VIpDgkI3pG9Pgwc+VsiY+5uczCcBmN1wEiGEk/gWIooq4xyCYwlk
	 c/X5rnVUuYO+Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:37 +0100
Subject: [PATCH RFC 17/42] ovl: port ovl_get_link() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-17-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qDyOOnsKgjDMJECVSKZHFCLTntFUXNRakxJ39KMrkIw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnt8+8vnd/0CHxa+NlvgySq0p+it0NunFVPyo2NtS
 h6f+x9a01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRrcsY/tfyFZoU3te7fCQ4
 dq9ZtpiZbuq+FKkNW70aF2/4U/TTp5eRoX9znti0aCf9UzudlbJqd18J1SyWvLy59drhXSd92jO
 KGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index dca96db19f81..3a35f9b125f4 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -327,16 +327,11 @@ static const char *ovl_get_link(struct dentry *dentry,
 				struct inode *inode,
 				struct delayed_call *done)
 {
-	const struct cred *old_cred;
-	const char *p;
-
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	ovl_revert_creds(old_cred);
-	return p;
+	with_ovl_creds(dentry->d_sb)
+		return vfs_get_link(ovl_dentry_real(dentry), done);
 }
 
 #ifdef CONFIG_FS_POSIX_ACL

-- 
2.47.3



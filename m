Return-Path: <linux-fsdevel+bounces-68464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18958C5C8CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D11A14F773E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441128643A;
	Fri, 14 Nov 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIkJc6Fp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500A3101DB;
	Fri, 14 Nov 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115341; cv=none; b=bB/EqtYFtTS+F+FgYSzka7+ygs2ojLsxIIhYZth5ta+3SZqLHXBKMpwL+/mQvwqYZt+n2weO+RFJnpQzQwyNu7BMB7CfUJKZOGZcI9TYz9HSUcar1f7NpYsIH1tBnaPJcGRQLw2tbPEz3G58G8USe+GIZmTWfPFWaA49MB3u39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115341; c=relaxed/simple;
	bh=27DGrkkfP6pw9zbZy5PChVq2SysrDaOP0ngseY9icsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LnW26A49rzFduZIAB1Ig+xwSjmidYBkpbB7SyBCF2Ug6mSuo7XVMoZSJaIre/iA1IxMWmfxYC2AgsyMKkcGRMwnqkcYDg2rOGfgrQN8G+wy/LvbZFj1L80yWBgdkqqS+mXuiZcExARY6oo4nDeV+QveQzYvcS0VmAOcoJZkJ0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIkJc6Fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A694C4CEF5;
	Fri, 14 Nov 2025 10:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115340;
	bh=27DGrkkfP6pw9zbZy5PChVq2SysrDaOP0ngseY9icsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XIkJc6FpqB0SgHAjZBEV23eVp78IsnXOBVnm1yvJ+8vIgnx8IOYX8kB8NXZ+vlcEv
	 BgxaPuwKMhQd6lks9KTv3GJJXVUztyqTok6lYPr/uaDprAeHXakVmV37V1tVCZQ44k
	 vt6WiXCeSaXVD5h8d3ZRN1rcDPSsoDz3e8rjyArcNLQvqdddwG2uost35yHp48LDiD
	 NcSTYgzeCj0rQQTjcnNNjJLkjiLp+51qPHuReqTdAtf5qReUh8i86MQ7iGu8UosyIb
	 oTo1IVpqW2LxtjsDxNhjBiYmg+4FMevO1DnKmz2duDBEjP7PLN0+YNQ2k5cf209Qos
	 4FeGYk7qj7Osw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 11:15:20 +0100
Subject: [PATCH 5/6] ovl: port ovl_create_or_link() to new
 prepare_creds_ovl cleanup guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-prepare-v1-5-4fc1208afa3d@kernel.org>
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=brauner@kernel.org;
 h=from:subject:message-id; bh=27DGrkkfP6pw9zbZy5PChVq2SysrDaOP0ngseY9icsc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKMzoFMroJZqX3ehm5nOM7vlP2zryoqOT0lTxX5uWIf
 5k0x/FARykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERWWzD8MzsZZnxnm09/a9Sy
 /2qbfSUXNLraepXr/HD6ee5S+vx2FYZ/Sqrnf2RNYli9ZLviYS2u6Pyqrvwne3vnnPk3x2DyFf8
 vrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This clearly indicates the double-credential override and makes the code
a lot easier to grasp with one glance.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index f42e1a22bcb8..d6a3589c0da7 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -659,8 +659,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	int err;
 	struct dentry *parent = dentry->d_parent;
 
-	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
-		const struct cred *new_cred __free(put_cred) = NULL;
+	with_ovl_creds(dentry->d_sb) {
 		/*
 		 * When linking a file with copy up origin into a new parent, mark the
 		 * new parent dir "impure".
@@ -688,12 +687,12 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		if (attr->hardlink)
 			return do_ovl_create_or_link(dentry, inode, attr);
 
-		new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
-		if (IS_ERR(new_cred))
-			return PTR_ERR(new_cred);
-
+		scoped_class(prepare_creds_ovl, cred, dentry, inode, attr->mode) {
+			if (IS_ERR(cred))
+				return PTR_ERR(cred);
 			return do_ovl_create_or_link(dentry, inode, attr);
 		}
+	}
 	return err;
 }
 

-- 
2.47.3



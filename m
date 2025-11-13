Return-Path: <linux-fsdevel+bounces-68306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10638C58E0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D181426AD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C73363C75;
	Thu, 13 Nov 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDWx23vb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861043624B2;
	Thu, 13 Nov 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051874; cv=none; b=WknfHYiHGVCbY3n834qBPMalot1+MXOnR+K5LpO4sTOqjxA0ZLf8UToxyrY3Ph9b/ixfFSA330tlYpojcOdU4SqEAPscIHlmuKVzzI+zsFcygmFqVVMjE2S5gFgzLO3xtHdfVOf2eqJhIWh/VSm1sc5F25BASEMabmXIIcYCq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051874; c=relaxed/simple;
	bh=OLFfA6JOP4L6kD+qZnDBkgJYgoM7jWb9ChxcibD70RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dMw9zEfAnyrhYPOFEfTSSF1iuzI7s0EXumoAgPInjUi7Pqnduj8FSQtBhTBJqWxpM8bdwMwAcZZ/KPzEjCAx+q7Guc0M1vPItFCVCahfNsQqBAnynQxgmlMrd1+z0qiNx6FSISW97Xooacv2oohR5YtWXZkdVCLB7cMk4OP0Gec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDWx23vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96797C19423;
	Thu, 13 Nov 2025 16:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051874;
	bh=OLFfA6JOP4L6kD+qZnDBkgJYgoM7jWb9ChxcibD70RQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uDWx23vb10q2r3sgs814t9gOipTSLyK28b8uKP/sfKJ/PmzxgPYLT4hAYiAya/dzn
	 0Eo35rtAwgX4PEScpbBLMwad3y012lvfb8qed0HrbGcFPR8uw3vPIime+UfPQGGSZZ
	 hGMrByPClyb4FfTD/0XDLBg112RE2d6k9xtb2vdYqDle/gbe3IQGr7xhkxqqONPVik
	 tsNQnqikWyNRxzp5PFARoVo/2UQq2m/FC6lufH2Dbkp0AkmK8V6ePfYnhXlR/oh6FV
	 R87zi0u903hKJMfEW6iUO/v1/ny3wX0gh+RaCzq2gTmML+13Un6tVRNXAAvQ7o8gpE
	 1oQJEy4H2b4wg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:18 +0100
Subject: [PATCH v2 13/42] ovl: port ovl_setattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-13-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OLFfA6JOP4L6kD+qZnDBkgJYgoM7jWb9ChxcibD70RQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbqdjOG/rLNWKuC5161FHc1uj6JCVip8fu/5exLLV
 k8tFf6yjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcz2b4Hzxx2syTQoY9y/lT
 a03/fXtfrG2ncj7EQTs7xbd1zsxuHkaGPra9yZwlkyeZzHm8YYZ9Rlb8fEWH/nsWXbUa2z2tz/J
 wAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index e11f310ce092..7b28318b7f31 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -25,7 +25,6 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	bool full_copy_up = false;
 	struct dentry *upperdentry;
-	const struct cred *old_cred;
 
 	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err)
@@ -78,9 +77,8 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out_put_write;
 
 		inode_lock(upperdentry->d_inode);
-		old_cred = ovl_override_creds(dentry->d_sb);
+		with_ovl_creds(dentry->d_sb)
 			err = ovl_do_notify_change(ofs, upperdentry, attr);
-		ovl_revert_creds(old_cred);
 		if (!err)
 			ovl_copyattr(dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);

-- 
2.47.3



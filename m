Return-Path: <linux-fsdevel+bounces-68224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3A6C5789F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BBF53531A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986D1350A12;
	Thu, 13 Nov 2025 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0mST+fE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0688352F9F;
	Thu, 13 Nov 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038964; cv=none; b=RHFSLi/j+1p2TXRc3k687dmELH92fnYbK1QeAouPCwmA/osqHZNiLFdI/2MeOAXYWMDq3RpcegVgvQ3Ikna11h2Uz6Rxg/HOr1MbA7DzSMBEi+rYPTuWiUUURf8SIQaQ1Y1su6S04XB7umCgldVfbkZwCRkmq7XyA+XxYeFqbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038964; c=relaxed/simple;
	bh=yUEwwUkFL2HYUxiojPHXAznYZW0i4+rirvhdG1HtqWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxMBdZIk6nWVPX29RSB2spq5s3b1x05Fzo5n30yX8LnkvFouVotANk+e57U9DnpxKxAinQ67UhQEPvzTiE6kfifNIcq/bMFo+QdH1lmJJR8L5Rzs8QMnG8YSohjOQN0IAKepf1MDpri5YKM2cxY34HOsQ30zMjB1vqN05k3oJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0mST+fE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F285C4CEFB;
	Thu, 13 Nov 2025 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038963;
	bh=yUEwwUkFL2HYUxiojPHXAznYZW0i4+rirvhdG1HtqWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S0mST+fEiXlFK05vkOlNTrZCJz3p47p0gYxLdL0icIzNMgifAb3P9Nn1+uslQ7XCy
	 lGO5AFLjXADUFOM2xWZ1EyBzde3E4ZAzp4d+leArxLMjXrlDVOjONQE+m1wDf3uVVf
	 8iwc7rsM3McGwEB5/l2gKJEHU3oVaLX6MYcSuLxByPN2e1OXHfx+aZe/fvcVepohfE
	 Mz2hdBIRCpEOR0tNy3H2NLntnE4wKacu+LIX1VekkeiAWKDg22t7E9QdQmnyWirKBV
	 UF46QIYXXb4xWG5VOiDw2PHYAWDfa/pyVXOn1KKI5EWqBBznUzvxcshQfQL+rKj4iI
	 /0t+bmCK5gBlw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:27 +0100
Subject: [PATCH RFC 07/42] ovl: port ovl_open_realfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-7-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yUEwwUkFL2HYUxiojPHXAznYZW0i4+rirvhdG1HtqWM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvkM7U3PO7VwufMvDbPJknx12gv/T7/z9b244Em5
 fIT8z8HdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkJRMjw07uKYwaWzYHs5jw
 LPcqWWv7XudRwJRi99QKJ86dPesYhRkZjp35K/Q7dAvfq1X8L04dOypybULIdZbjBum+WqdUPdL
 b2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7ab2c9daffd0..1f606b62997b 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -31,7 +31,6 @@ static struct file *ovl_open_realfile(const struct file *file,
 	struct inode *inode = file_inode(file);
 	struct mnt_idmap *real_idmap;
 	struct file *realfile;
-	const struct cred *old_cred;
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int acc_mode = ACC_MODE(flags);
 	int err;
@@ -39,19 +38,21 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
-	old_cred = ovl_override_creds(inode->i_sb);
-	real_idmap = mnt_idmap(realpath->mnt);
-	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
-	if (err) {
-		realfile = ERR_PTR(err);
-	} else {
-		if (!inode_owner_or_capable(real_idmap, realinode))
-			flags &= ~O_NOATIME;
-
-		realfile = backing_file_open(file_user_path(file),
-					     flags, realpath, current_cred());
+	with_ovl_creds(inode->i_sb) {
+		real_idmap = mnt_idmap(realpath->mnt);
+		err = inode_permission(real_idmap, realinode,
+				       MAY_OPEN | acc_mode);
+		if (err) {
+			realfile = ERR_PTR(err);
+		} else {
+			if (!inode_owner_or_capable(real_idmap, realinode))
+				flags &= ~O_NOATIME;
+
+			realfile = backing_file_open(file_user_path(file),
+						     flags, realpath,
+						     current_cred());
+		}
 	}
-	ovl_revert_creds(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,

-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-68230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B582C578B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 871313545A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C2351FD5;
	Thu, 13 Nov 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/EtseIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB89831A554;
	Thu, 13 Nov 2025 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038975; cv=none; b=jyx8fO3OTWZExQce3rXyl+PCP847Uk5JI0vOFRS+aVV8OlAD0D7a4RFR8gkY72/3zjSKc9qDRc+m2GBC2rrgI+koKb5GLdNgeZ+LAOjv5IM3Mb+nmcUhgw0OaTzQC4p5mI6fq97ufxHRBth2CyPH8IMe7fgECD14uUH8EPCGs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038975; c=relaxed/simple;
	bh=s59GJd+3qbQosJPVYIBystxZvR+2Nr2DP7U6ljLzoAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sf+NheKlM1Xj4quXWOsjeCar/2MwkQ3Ms0nV5ekxhUSL8Z0T0p8UdBgjemAy7smtrgnZIkmhHnOh+xClPwP87Z3xjw6fpY6hmZrt4uq3DLsmwynalR+UUHwi7WAaDDmS5imLae1oz5ogOYfmoXA+XjaYoP0eCUVMa7rvFG6yy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/EtseIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA09C4CEF1;
	Thu, 13 Nov 2025 13:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038974;
	bh=s59GJd+3qbQosJPVYIBystxZvR+2Nr2DP7U6ljLzoAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i/EtseIs5aupb4hrezY8YjjzrrevxAnQADu1qxwjYzuhA+w9+00UKkaJTeoJtOuhP
	 j362neicYL4LZitIE7hLPmgOYehNmItKqWSbNdKshnfANaeQ5s+neBF+48x//rEPwR
	 eWGFZs2D84wGp6IhhMmjt/mP1cDtJf60wTRPlWmbcHHKEnw3/vMOjuiTNpj+0ZufMR
	 G0ucAnAoUYyo84mBHEjB2T/O9wyODt+ov6U0Z9HK85eH4H2zYML+qXhg7KCpP8FSQO
	 qg8T2mqSZhdk/dalghhQNWIjapqQLUfdKCxTFpZyNPYnqetL/Bm3jp9ZTa1I1f+D7/
	 t7AS3ea8ogRWQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:33 +0100
Subject: [PATCH RFC 13/42] ovl: port ovl_setattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-13-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s59GJd+3qbQosJPVYIBystxZvR+2Nr2DP7U6ljLzoAc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXns8cxFjlsibY0q3e64dsv2tZKuoKWgS8m6HvsCfH
 esd09ezd5SwMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk3oDhm1rzngvsBquWimuv
 OKd2Ya1qlqil5tz7LeGz0h3sVE1/MzL83KDbsmrfbKnq7RUS3RyzvkYw6O+rfMda0s5odGtZTBc
 LAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

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
-		err = ovl_do_notify_change(ofs, upperdentry, attr);
-		ovl_revert_creds(old_cred);
+		with_ovl_creds(dentry->d_sb)
+			err = ovl_do_notify_change(ofs, upperdentry, attr);
 		if (!err)
 			ovl_copyattr(dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);

-- 
2.47.3



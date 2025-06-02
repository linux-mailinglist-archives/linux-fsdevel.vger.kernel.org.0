Return-Path: <linux-fsdevel+bounces-50333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F827ACB06C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687E73A26A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E42226D08;
	Mon,  2 Jun 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzifuCHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77C0224B0D;
	Mon,  2 Jun 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872949; cv=none; b=S7BayKwJ+ETxkLwiNQnv8r5Dhp0g+gA+K3CH3pX9xsPbwyLNEz/VTch53Za1YB2Xln7BREgjK2bs4/QUpHZWvBV8+6sYsgPbSpL0BH9VYOmKIRiEOIJwILdk7ZJ1+wsOBUeX+V/6Ls+THvbFC/f5d0+rIYUenUvdULhtmFTBaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872949; c=relaxed/simple;
	bh=x7aiTOFWz2bzqHo5/KSyfTkqfew35Z2CcU5pcuEOZks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hitZ+RHXXVMIRCn18QPqOxLIZCkOPMrCV/39VjSliWetD7y7JnQHvoJMR/aCVSgkmFxouvAFO+Ul+fdqysWZBkjZVyAmWw1DwvWL/RmAIicC3fO0SoZsdPPFH9AB4WA8hpdx1OhGP05rV51JJojmaiH8YX8L9HrC0jLjlF70jaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzifuCHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0D6C4CEEE;
	Mon,  2 Jun 2025 14:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872948;
	bh=x7aiTOFWz2bzqHo5/KSyfTkqfew35Z2CcU5pcuEOZks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bzifuCHCS/WZCVd9UJkV/NtmB3Bb8whCyDanGcQKy0JqZg9r1orGjp56Ds1/bwHsq
	 DtTnIevfiSgzUv2HKLCIQETTcRfMJCWvOYJELxCmrKqXdWG/2c8gbaekJMznKhO0y9
	 H1IXMnq2PH/1RVeRKYj/O7n4bWM4/k7ib3S85tlOdko/4uwNVBN2A18Nd6NahETYXH
	 J6sVupQPlI/PYxN8qWn72/hD44zbVrWpl+8sj/O8r4tvgG1JbGw0K5+Gtohl+iTRGP
	 VaBA7XyPNnCN5y/eAmHiJ3/4rtxZeTTCksuNQb8Oif/U2UNBoaZlUovP6Zv8gTReh2
	 RK7AFbATVC6OQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:46 -0400
Subject: [PATCH RFC v2 03/28] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-3-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=x7aiTOFWz2bzqHo5/KSyfTkqfew35Z2CcU5pcuEOZks=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7kzTqGni5Ja5kAcAQpI0svqT+14uiOlWvyh
 NxdnTsxBO2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5AAKCRAADmhBGVaC
 Fc6yD/wKBJg9QCb43FABMtBsjLoBcnpwlMFHkEulA5zhX5uLV59pfNnhk7JCY/iEgBf+yMgBgTT
 hd/PKS0Ioa3IOw7Q6Gu8L5Ao/e9H9+RP2nxGmKQB7vjdcD5WMEbNMlgzQv2Kw7TxjufA5kZA99R
 EGI6AAnVut3h60GYW4FfPxthQAy7SQvhQl9rilLkYMgdDSH/O/iZyY2QVLk6Ijooa1ubGMpUSPa
 pJgSTh3wDRgYDO61bBH3uN75EGxdPZ9nTEdu5MEfieddxr0fNkUv1lmDTHGgpfXJvD6haWbGqmU
 yTvR8ro7PrJCd69vkl8x9JgR4PR2hzd6671kJ9/P8RS/Gw56hFezomI5HTNPdmdZga5l8LACSgj
 Er2krGYblOhoSGxof3b21DqMzM/V3SJWttF21Y3Tf03XhzTuWe6rckb4hRpwgVx34iSNuOJBotk
 +luYzfvap3t9B4+77W1a1B/he8AMMprJDzyGh7xCLmaa3a6/DoxZyvWDGdjwdx0lYt1WKSc5V+K
 fU+rM+zorEYICtUgvae5kLCrJhPoInfxIJyAUIGFhKWTAKJHn94s6j8T0WEgRFEDXOVOkWqWG3A
 ESffo86gu55A5zImpPgdTpVNX9Hydl1r3MIF2F4ubZ5lJLGKAsCYaYDtty+ab43rv3U+DRloQ5u
 UpMrwc8kemdbBAg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

vfs_link, vfs_unlink, and vfs_rename all have existing delegation break
handling for the children in the rename. Add the necessary calls for
breaking delegations in the parent(s) as well.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b7d44914e11ec38ae3e8fdfbafadd..0fea12860036162c01a291558e068fde9c986142 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4580,6 +4580,9 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	else {
 		error = security_inode_unlink(dir, dentry);
 		if (!error) {
+			error = try_break_deleg(dir, delegated_inode);
+			if (error)
+				goto out;
 			error = try_break_deleg(target, delegated_inode);
 			if (error)
 				goto out;
@@ -4849,7 +4852,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	else if (max_links && inode->i_nlink >= max_links)
 		error = -EMLINK;
 	else {
-		error = try_break_deleg(inode, delegated_inode);
+		error = try_break_deleg(dir, delegated_inode);
+		if (!error)
+			error = try_break_deleg(inode, delegated_inode);
 		if (!error)
 			error = dir->i_op->link(old_dentry, dir, new_dentry);
 	}
@@ -5115,6 +5120,14 @@ int vfs_rename(struct renamedata *rd)
 		    old_dir->i_nlink >= max_links)
 			goto out;
 	}
+	error = try_break_deleg(old_dir, delegated_inode);
+	if (error)
+		goto out;
+	if (new_dir != old_dir) {
+		error = try_break_deleg(new_dir, delegated_inode);
+		if (error)
+			goto out;
+	}
 	if (!is_dir) {
 		error = try_break_deleg(source, delegated_inode);
 		if (error)

-- 
2.49.0



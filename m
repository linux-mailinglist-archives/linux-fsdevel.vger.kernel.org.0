Return-Path: <linux-fsdevel+bounces-68674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E7C6334F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 20C0B28B84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFDE32E143;
	Mon, 17 Nov 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyHZgo7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DDA329C75;
	Mon, 17 Nov 2025 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372081; cv=none; b=egqu3V/gq3WfizJLZURb6S/bE5cKfchdO4rGNa4rWKyUxaWnaTBmS3wCRjphXzJHNZFCgSKe3Yr7HY3EUmbBCr7DXdVyhTKoQcVV5MBRQpF6zwLH0Z7M6D0/WIA+Ch4bDjao2gYd+gnqPLTjVJqyb0831GpLJsuuH9Fr0Tp3zI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372081; c=relaxed/simple;
	bh=NZvpWdrgEQg6od6W+evXbcQuCw7gbUadQdivoyup+a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AaItpcdGF5bp7QxV12fKN3qfF+unmGEZjIIkMx/kGh513D1xaZG55uewzb5cj1F3/gR2TK9GWXAl3NPS7b79RODc4tiJFKv2eKKkq4b93E2NfTFdXS+4/BUNsaqpphb//S8wYfMQor5DbPjPuEMTbQRCwKML9uMhkukbB9RvnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyHZgo7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C7AC4CEF1;
	Mon, 17 Nov 2025 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372080;
	bh=NZvpWdrgEQg6od6W+evXbcQuCw7gbUadQdivoyup+a4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uyHZgo7IeFWFXx/lRs9IlvUkiRP+Pn1Ri/5uvwcH/77yEerwf7i/7ws5SM4oaMSkn
	 eP/2pXPWl/UhhkjyXh3TbrWwS+Z4fkGsqmWaf8LdLDm0T1mVXnRcILBjzqVfsHYntl
	 arZ8pone4wakSQgBFu/qBhh2GJvlQHAESpELtS7zsus+4BYFiY37ZEh/ns6OYprFko
	 d1AmxnS+cUPRqWZPwb8E35jL3o2C5Vcuc+bDJ9LR6L/VPGbi8k+i2HMqreU/+kzax/
	 1VTcLo4HQhXfXkFhx1CRgtYhwdl7eIkXAyNbnw6/rL+pHMuFPCbFFk+EbXucXVhViq
	 ZJQhRNDp5+JOQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:02 +0100
Subject: [PATCH v4 31/42] ovl: port ovl_xattr_get() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-31-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NZvpWdrgEQg6od6W+evXbcQuCw7gbUadQdivoyup+a4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf72vtotP8DJVumkC5tl5aW6o3+MRQpzN8gJKZ2zP
 JY478WSjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkYHWb4X/77xIzMp5Odf53x
 rlKy+iW0Yu7Ntc9vFrqxBZ/x2eRaoszwP2lqz4y37vPucerdUNXZVZaqt8VwS7n+GmOxjbeMwgr
 2MgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/xattrs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 787df86acb26..788182fff3e0 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -81,15 +81,11 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 			 void *value, size_t size)
 {
-	ssize_t res;
-	const struct cred *old_cred;
 	struct path realpath;
 
 	ovl_i_path_real(inode, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
-	ovl_revert_creds(old_cred);
-	return res;
+	with_ovl_creds(dentry->d_sb)
+		return vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
 }
 
 static bool ovl_can_list(struct super_block *sb, const char *s)

-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-68374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA8BC5A2D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEC514F12E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8013B326D70;
	Thu, 13 Nov 2025 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9ojuXKJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A13254B5;
	Thu, 13 Nov 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069563; cv=none; b=eDx2DdBgUJRg+u5IdvS2LL0C3jSj0EozGnGFicf8+D2w9LNcI/J7WxN6EaKWvfPtmNvmkpGcSA5nfeE8uqBkNs5Bk/toD7elGD0Igqf2KZ6B2491BplztyNEnn/nXe6FfgAmkSfyMGR9ngB/Tgi9TJnCBYmspnCaG91fK6dPwhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069563; c=relaxed/simple;
	bh=ntIJxwq4IL/xi2aMz0jG9JSu3LvZ3tfRHfUm6SBzyR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLskelWRfcTTkalTqtDIrcK0m+v07yUGkhbnNF/pQ+r3WHhMSCVLv8pniNegwjvmaIemOhqE8382HYVH2fCc9W9Q6T5yHa3s2g84fvBKH1+urwljuHXfQ3lC3LFHl4tnkfO7GxWZrM75IQmxjkScDSKUIHiFZeK2j140VTVzoXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9ojuXKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE92C19423;
	Thu, 13 Nov 2025 21:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069562;
	bh=ntIJxwq4IL/xi2aMz0jG9JSu3LvZ3tfRHfUm6SBzyR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I9ojuXKJp5ItACxJ/elI+ESvBzTCuMsoxGx5ih/KMX/uRzn+xtRD8RopTD6lGD86d
	 v2BfL51cNxFgYupDBT0911blEBCw4nAq+89snJFCebcRrAh6z0vO/PdLgIWZVGDdHK
	 K/EHvm/YUgx0CdknVQZyf0VrsOIAc1gmHEPcqJXrfX+0z6XPP3bfKEsHQXkdJgCfeY
	 rtlo5a1KbvsMXD4MKUR3GIrX72586n6h9OBTZLYzFYM0PingPenZQolrEAKvJhDAy3
	 WHLtDri0UBpkUzqHf9fSESuWkjzmrrq11p1EI50LV5l+C2blyBxgjps4/rtTbsWmUl
	 XVBOzLd88NQhQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:01 +0100
Subject: [PATCH v3 18/42] ovl: port ovl_set_or_remove_acl() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-18-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ntIJxwq4IL/xi2aMz0jG9JSu3LvZ3tfRHfUm6SBzyR8=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGkWTleh9UHJh1q5maFaFjeRPLjc/40djsv9FbWaan1zcje9v
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkWTlcACgkQkcYbwGV43KK37wEAyi34
 hFI//oQpHNStZTnA0jcTedXXUrMFVLwtc9Q320QBAKNXLzpG4gA3pLFUr38zzvbC/ZxuqLTFz2J
 xxVPE/iYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 1e74b3d9b7f3..e6d6cfd9335d 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -474,7 +474,6 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	int err;
 	struct path realpath;
 	const char *acl_name;
-	const struct cred *old_cred;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdentry = ovl_dentry_upper(dentry);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
@@ -488,10 +487,8 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		struct posix_acl *real_acl;
 
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
-		real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
-				       acl_name);
-		ovl_revert_creds(old_cred);
+		with_ovl_creds(dentry->d_sb)
+			real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry, acl_name);
 		if (IS_ERR(real_acl)) {
 			err = PTR_ERR(real_acl);
 			goto out;
@@ -511,12 +508,12 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb) {
 		if (acl)
 			err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
 		else
 			err = ovl_do_remove_acl(ofs, realdentry, acl_name);
-	ovl_revert_creds(old_cred);
+	}
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */

-- 
2.47.3



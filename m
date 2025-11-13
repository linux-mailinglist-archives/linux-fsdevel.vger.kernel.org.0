Return-Path: <linux-fsdevel+bounces-68248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B83AC578AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDD564E1C93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C2435502E;
	Thu, 13 Nov 2025 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXZwJb5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E935293B;
	Thu, 13 Nov 2025 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039007; cv=none; b=kCOP3pADD8F0oKRDOxlgJ7G4RG4XCg5/plLyp2HddWjfsBOkToEIA0LdatRlZpidcF3iE45qKKkDLhAxAAcvj1l5LGPUpe+dXl+3Js/ayM/PJYvQlVVH6mkmhddUYPziTrgRkOFP6WIsb4aYPbxYHRcIwo/F7A8o8zXmhm0LeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039007; c=relaxed/simple;
	bh=GXgBkaOSkxYVKbrSoNSMhW7w2EvqQOFZHi7PWxp3shs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VzUPHVSMgbL+PEXP6M0tP7RNauCjefLsfvibukkB4YrTiOTMH296asSBbxLWYLkQ2LBVjjHmtsz83Eq8Dp68JKfw2nYyMMR2+w0O/Tq5G/7+gv1Cg1bwKYPi1i7nWFIaqERkfwAFkoJoTnniq27Q5tLtlnQpueMVtIue1EaM/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXZwJb5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F84EC4CEF5;
	Thu, 13 Nov 2025 13:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039007;
	bh=GXgBkaOSkxYVKbrSoNSMhW7w2EvqQOFZHi7PWxp3shs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NXZwJb5drtAPFB4nJq1r9qncN0JrFuozFBTWX7rtYy3We/tQjL1vjbn1kY77LhUjd
	 JI7O5Td+BZK+dJG4Dwr7NjVba26YyzVFLGxoRGKbUAWyu0VcKEU8+WiJQYGXtBIZ/+
	 JqeWETtwOSaV0ggTEL3XQWNHKoEPdNacm9Cefv2oFR0UsanoK3iT+oIKNhUxh/6Q65
	 2yDPsrOZpubZPmB4MvH8zu+LeLBSyqbkTsQsQ94ieZCPSxQMaKB9p2BRkbpgRLrAh1
	 VN6OH53SC6WJ/VAuag/yo4Nxv0d+W574M4Z6mQHa2y7k+zCkjdzGevS+zbqiljhorJ
	 aG0QnqZ8awBIg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:51 +0100
Subject: [PATCH RFC 31/42] ovl: port ovl_xattr_set() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-31-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GXgBkaOSkxYVKbrSoNSMhW7w2EvqQOFZHi7PWxp3shs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXntSoVa2IXiSx7zv5pVhPZN25M62y58xnbG+LzBlt
 cdcJebNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZnMzwV/grK8OBy3Xsjaqf
 P3Sef3lt3Y452msia9USK4KiPNol0hkZvsWfMVI9k/hzh3ehrmpF3grB7/U/XFJkd2eeST/HnR3
 GBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/xattrs.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 88055deca936..787df86acb26 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -41,13 +41,11 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	struct dentry *upperdentry = ovl_i_dentry_upper(inode);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
 	struct path realpath;
-	const struct cred *old_cred;
 
 	if (!value && !upperdentry) {
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
-		err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
-		ovl_revert_creds(old_cred);
+		with_ovl_creds(dentry->d_sb)
+			err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
 		if (err < 0)
 			goto out;
 	}
@@ -64,15 +62,14 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (value) {
-		err = ovl_do_setxattr(ofs, realdentry, name, value, size,
-				      flags);
-	} else {
-		WARN_ON(flags != XATTR_REPLACE);
-		err = ovl_do_removexattr(ofs, realdentry, name);
+	with_ovl_creds(dentry->d_sb) {
+		if (value) {
+			err = ovl_do_setxattr(ofs, realdentry, name, value, size, flags);
+		} else {
+			WARN_ON(flags != XATTR_REPLACE);
+			err = ovl_do_removexattr(ofs, realdentry, name);
+		}
 	}
-	ovl_revert_creds(old_cred);
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */

-- 
2.47.3



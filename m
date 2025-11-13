Return-Path: <linux-fsdevel+bounces-68323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B94C58ED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46262427A52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803A236827D;
	Thu, 13 Nov 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Het+yhIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA62ED151;
	Thu, 13 Nov 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051905; cv=none; b=iDP/DAkf0usTDi0lX8oQQ+r+zTAAbJae3VXZdqqz45ZY8JmZk4WQCD03gSG37ct5eLuuNlG+2OV7CK94oY+S7370qBV36RiA/06LHA0EgIpzXQjIAKogKuin5u+0I9WhTbWzTf9hkTH32AymncXXV7mMW/ofR9jTdLiLnk2lOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051905; c=relaxed/simple;
	bh=Usv04rSjGXaTfVHWJwnurt5eB6fhv87g8IEfs86a1MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTSbtjytuhkuLypcsqDblc3Q6NZL/wCYvypvghj5e2EYbgDvGLqob8+w1WKfn7cE2VgYjgSORtmv708FMe17Eizg7jiNVGeN/d3uQ9EARMhncrs56sReYcMYGYeherPCTsCX4sYAXSehTMVN4oCgyXq0PGijnmNNo5kE6KyjYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Het+yhIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DE7C4CEF8;
	Thu, 13 Nov 2025 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051905;
	bh=Usv04rSjGXaTfVHWJwnurt5eB6fhv87g8IEfs86a1MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Het+yhIWGCu9MBdshfbdDWt5dkbkIZaoCGaGtghOg1i3KM3sbZuInMO0xfA1D+qNE
	 bIVJ+Gg+eHNewVGX+1eKOGAApWy+0LY+gWczYpRPSGoLo+IsHOp4m7RlpX+eI7MucA
	 hUJHdBrILhPhEOgxkV5ULKa3p9spNqrLckf6dpf2q5GLl9RhsvOXH0nHVyH1SRCuuw
	 pC5viV0ueVjVs/81FzKDpPH//i00X4/ASp3LhhjjhauzCQ8tnGhd6fAzJgrwHMcfKG
	 gzPRyHXosBifsJU5uhGG1z4vSMBHPbcsIeQ7yC5BDkIrocNybPQTJgpJaoA4O3XuHy
	 D/LF6RiYccMGQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:35 +0100
Subject: [PATCH v2 30/42] ovl: port ovl_xattr_set() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-30-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Usv04rSjGXaTfVHWJwnurt5eB6fhv87g8IEfs86a1MM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbq7nVLcOf2I7MwDL2tn8t/OmOZg1CXPMeE723bOC
 98e/lAT7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIRC7Df++X9RM1PYy95/yP
 OWSWHv+i0T4r9uB7/RdiFTuuTQ0rqWBkmCr8MFjjf+quwKVqrDuuCToXlxdMaak0vMW9QCRavWE
 DCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/xattrs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

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
+		with_ovl_creds(dentry->d_sb)
 			err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
-		ovl_revert_creds(old_cred);
 		if (err < 0)
 			goto out;
 	}
@@ -64,15 +62,14 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb) {
 		if (value) {
-		err = ovl_do_setxattr(ofs, realdentry, name, value, size,
-				      flags);
+			err = ovl_do_setxattr(ofs, realdentry, name, value, size, flags);
 		} else {
 			WARN_ON(flags != XATTR_REPLACE);
 			err = ovl_do_removexattr(ofs, realdentry, name);
 		}
-	ovl_revert_creds(old_cred);
+	}
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */

-- 
2.47.3



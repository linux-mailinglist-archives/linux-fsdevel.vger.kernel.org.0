Return-Path: <linux-fsdevel+bounces-68299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 390ECC5900A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BE494FCD1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B0635E559;
	Thu, 13 Nov 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX73qvJ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A030AAD7;
	Thu, 13 Nov 2025 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051861; cv=none; b=WLBvhmXpaXNNBLa0wjQN9IfA/rHT1cuomJb6Kr3jmeGn8A+qEioAAykNi+pV1fS+o0gulMtZRKTL8bQzCBVFzwTvovDZOxS7kqkN8Vx33VKFcCn0V73pTpbse8WVMlM5XaHZ/0/eU8ClvisiQtq9A+L+vCyIw/5Ei44w3swsPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051861; c=relaxed/simple;
	bh=ZMRMXXZxdEGMdM/evp6v8/8GuSTukjI3zgbS2oA0ZN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtIkpTCaTOlroHmH7BdF1V2/91rMhQc6Or/E1/5Wy5lqPjHmkWQn1UQHbY7le2etWQSOO4V3pkgPJgeaguTqxUGW0uAAfl72pmX29THMmOX0NrnOevjHe01wYMBGvGBjsMug4VFZTB7ea/7mcWsq2zmV9peYYsiR+lgI2e3SWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DX73qvJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A673C4CEF7;
	Thu, 13 Nov 2025 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051860;
	bh=ZMRMXXZxdEGMdM/evp6v8/8GuSTukjI3zgbS2oA0ZN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DX73qvJ3tdAE9nGKTrWeiPy8LHSodxmC0VdQwkneP71fTAoN1XpQs2bATrs3asT9x
	 kNw1cim3fMzj6xg0hRBu6G86SnjL7ITyf2XrKfsy1uSOyQ3C9fAZ6kNWel6oMn6wd6
	 AlQZ+FZyhkxp0JiWcPl6k+KxtHo3rh6zIaF1Lvhm74R2vSJQYiVsr3OLZ5roLDoxnm
	 3W/xWMRCqSoZ/0OwIUUHx1EUEfHdxFcbf+IOzCv6Ya+av/KUAQ6J2BJS6EgG/ZJUl8
	 mIWeYXvKJNnuMvl6MC+gID0nwLwlmOfsMO79zpqJ9Lx7e0Kotq82iNAP4CrvrPgx4g
	 jemuHF5NHo/xA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:11 +0100
Subject: [PATCH v2 06/42] ovl: port ovl_create_tmpfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-6-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZMRMXXZxdEGMdM/evp6v8/8GuSTukjI3zgbS2oA0ZN8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbr2WbMezaqoP3szIrt0WnSmQ0faYqmuKQtOVHKUR
 +z5afG4o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCInwhn+cHcfOXZwmoaL5e5N
 3cvnsmz+GBP0+Moz50ta3IoH9v8SNWFkOKsyc0Kpz2aFwMWGOduMXOpubJsY6dvY0BS2v/BCy1F
 FTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 1a801fa40dd1..86b72bf87833 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1323,7 +1323,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 			      struct inode *inode, umode_t mode)
 {
-	const struct cred *old_cred, *new_cred = NULL;
+	const struct cred *new_cred __free(put_cred) = NULL;
 	struct path realparentpath;
 	struct file *realfile;
 	struct ovl_file *of;
@@ -1332,27 +1332,25 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
 		new_cred = ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
-	err = PTR_ERR(new_cred);
-	if (IS_ERR(new_cred)) {
-		new_cred = NULL;
-		goto out_revert_creds;
-	}
+		if (IS_ERR(new_cred))
+			return PTR_ERR(new_cred);
 
 		ovl_path_upper(dentry->d_parent, &realparentpath);
-	realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
-					mode, current_cred());
+		realfile = backing_tmpfile_open(&file->f_path, flags,
+						&realparentpath, mode,
+						current_cred());
 		err = PTR_ERR_OR_ZERO(realfile);
-	pr_debug("tmpfile/open(%pd2, 0%o) = %i\n", realparentpath.dentry, mode, err);
+		pr_debug("tmpfile/open(%pd2, 0%o) = %i\n",
+			 realparentpath.dentry, mode, err);
 		if (err)
-		goto out_revert_creds;
+			return err;
 
 		of = ovl_file_alloc(realfile);
 		if (!of) {
 			fput(realfile);
-		err = -ENOMEM;
-		goto out_revert_creds;
+			return -ENOMEM;
 		}
 
 		/* ovl_instantiate() consumes the newdentry reference on success */
@@ -1364,9 +1362,7 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 			dput(newdentry);
 			ovl_file_free(of);
 		}
-out_revert_creds:
-	ovl_revert_creds(old_cred);
-	put_cred(new_cred);
+	}
 	return err;
 }
 

-- 
2.47.3



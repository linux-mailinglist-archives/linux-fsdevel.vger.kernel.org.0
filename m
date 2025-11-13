Return-Path: <linux-fsdevel+bounces-68223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36185C57890
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98EE8351C78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5927435CBC6;
	Thu, 13 Nov 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUkjDsrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A199352F92;
	Thu, 13 Nov 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038962; cv=none; b=FyZ9fUHZeqR7CiMjkVolkkfu6+gS0AcjKmbf3BC0DdGVhYLYkXWrCatRUc9Nee0eAqH5F7eHfhIrEBX5D9rMpDQeAlhBBesTEBYZNH65eqZ+V6FQBxFuS1IMTDMWR2suGAhbYTawlCtCzi8y6EaErjqPqmthfuvGRWw94hE+H4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038962; c=relaxed/simple;
	bh=0oKnw9lwO9GY6gH1YF9cxdlSkWYpMoW4LuuMIy425ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EfHCdGFVpwSmREuXCjcAwipbGOFTk2RePWOjuMLBAB7YnPuw9ygi119GbLr5xcRmgjmZYDKW5oe9hcIwIMw5WHupGETu1nQ99r6jI0oQQzi2oFdtFCNvf1u5fgiz9u4BT+jWW40myYECcnizpNAUucY+hhScI4WuZU+5xTYQUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUkjDsrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7612CC113D0;
	Thu, 13 Nov 2025 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038962;
	bh=0oKnw9lwO9GY6gH1YF9cxdlSkWYpMoW4LuuMIy425ms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TUkjDsrvtEDGn2o5HIp/Alkn/TFCBFT872Fgnu+Jh2R6PgQwZ88ztwbDWkXx5tEjv
	 +HK1mxLayq2R8AprCOUKsT2KT9crkUlMwd2FXyKyW4glmfGQaL7mvu4f3MieuglKd4
	 jFCQZdlpbTPSwIe4Tj3OF4i335aFFg3jisF2qK1aQGSKsR4sk43uvwwFnsTNhoqtEZ
	 ULgWAM0J4JPzNQmw6kCDHw2Wj2HohE7bsAaIEG24zd+oWXaISgFNkd08hOXJL6HNX/
	 UehJTlaoKec2/5l5oIvqAZsIa65U4o3dy7iLYeXYO1f4zd9kjuUi/bpXqpKVON5jhc
	 S1yWiz5yJ4Ikg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:26 +0100
Subject: [PATCH RFC 06/42] ovl: port ovl_create_tmpfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-6-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0oKnw9lwO9GY6gH1YF9cxdlSkWYpMoW4LuuMIy425ms=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXntULLnwueDrrO+XizNM/uV0CluyNexey/nv8jKjL
 6VT8h5d7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIxUeMDHs2GFU4LVnx5k5U
 eNJGkw/3/Tfus1n7Z76WIKvjiUYJxqcM/5OjFrd5yekYGswRnq566s7utI75wee8Fv7M955pc+3
 MPDYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 62 +++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

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
@@ -1332,41 +1332,37 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	new_cred = ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
-	err = PTR_ERR(new_cred);
-	if (IS_ERR(new_cred)) {
-		new_cred = NULL;
-		goto out_revert_creds;
-	}
-
-	ovl_path_upper(dentry->d_parent, &realparentpath);
-	realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
-					mode, current_cred());
-	err = PTR_ERR_OR_ZERO(realfile);
-	pr_debug("tmpfile/open(%pd2, 0%o) = %i\n", realparentpath.dentry, mode, err);
-	if (err)
-		goto out_revert_creds;
+	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
+		new_cred = ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
+		if (IS_ERR(new_cred))
+			return PTR_ERR(new_cred);
+
+		ovl_path_upper(dentry->d_parent, &realparentpath);
+		realfile = backing_tmpfile_open(&file->f_path, flags,
+						&realparentpath, mode,
+						current_cred());
+		err = PTR_ERR_OR_ZERO(realfile);
+		pr_debug("tmpfile/open(%pd2, 0%o) = %i\n",
+			 realparentpath.dentry, mode, err);
+		if (err)
+			return err;
 
-	of = ovl_file_alloc(realfile);
-	if (!of) {
-		fput(realfile);
-		err = -ENOMEM;
-		goto out_revert_creds;
-	}
+		of = ovl_file_alloc(realfile);
+		if (!of) {
+			fput(realfile);
+			return -ENOMEM;
+		}
 
-	/* ovl_instantiate() consumes the newdentry reference on success */
-	newdentry = dget(realfile->f_path.dentry);
-	err = ovl_instantiate(dentry, inode, newdentry, false, file);
-	if (!err) {
-		file->private_data = of;
-	} else {
-		dput(newdentry);
-		ovl_file_free(of);
+		/* ovl_instantiate() consumes the newdentry reference on success */
+		newdentry = dget(realfile->f_path.dentry);
+		err = ovl_instantiate(dentry, inode, newdentry, false, file);
+		if (!err) {
+			file->private_data = of;
+		} else {
+			dput(newdentry);
+			ovl_file_free(of);
+		}
 	}
-out_revert_creds:
-	ovl_revert_creds(old_cred);
-	put_cred(new_cred);
 	return err;
 }
 

-- 
2.47.3



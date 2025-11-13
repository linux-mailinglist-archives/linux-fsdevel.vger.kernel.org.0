Return-Path: <linux-fsdevel+bounces-68362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06441C5A236
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C563B425A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40710325727;
	Thu, 13 Nov 2025 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgTy4UfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98970324B3C;
	Thu, 13 Nov 2025 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069542; cv=none; b=NoZmBhDmBeKEbrgJqg6einw3FneKbuoO1Axn+NTMUa/kZXMKhrlCAKcJAqQavPpekALnDXxI0I0kYCtiiVMocINKTCpjNA1oZNTulbZDxR2XBNLfFXoimyciZjfcy6cf1ruwWrAiHjBtSwYs8CELvHezDPXh3vYFVTr8RmN5Ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069542; c=relaxed/simple;
	bh=eY8o4rUyR8/eLdx2DSwb8zrR3k+Qygufr/YLqMaLh04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nopvLnaGx2a0pz8bLYNiHPftyuQmCYMi6uIgivgNFEKAsyz8r77lKBbnZBT2MIiHL+V4jU09kzX1fE/+53a7+moMAuqD/u2iRp1K/GSLxK3j2XXr/Zz8UlIs/1c0Ls9+IBgO2tVMiJffvGNUG6Ljo1YI2sgMBhWUX5akTG+3N1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgTy4UfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B18C4CEF7;
	Thu, 13 Nov 2025 21:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069541;
	bh=eY8o4rUyR8/eLdx2DSwb8zrR3k+Qygufr/YLqMaLh04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VgTy4UfEnxXi2g7QUjq16LGzaKzksW0TIlH3QjXWeR+jp07e82DRUlrr88ked2sCK
	 P6RtOUFlSP8fHeTpmC26ofSUJGTcQxaTThcAodmsv6VezTEa71JHhE11mh8OdF3sPY
	 I6WO++FkoDW5iuU3Kv92H9UPXnUSBW5p/0TDARtwzZrHrYOyDXDJf275wBzsTm49YB
	 S6WkikGxyYvgoFxfXp/xQvCmxhKkBSzRXQczvwC1LmyEFlaQ3Ylu4nZ+U8T6Jh0FOb
	 Ag0e5ZYiZZvYBmTsaQb3SBFYbjd2Y5AlVO/cy2IMhgX3uBskLxzruQPfxAJmQOWk2x
	 3U5O12bvqk7ig==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:49 +0100
Subject: [PATCH v3 06/42] ovl: port ovl_create_tmpfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-6-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eY8o4rUyR8/eLdx2DSwb8zrR3k+Qygufr/YLqMaLh04=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YVpb1/qPbPSS1wq/soy0Ve9c5aINXddFZ4xuXzXu
 ZdJWyNnd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykKoGR4QaLJOd595UVl7ar
 f2EVvKt6Qqr0ZdKvPUozrLatnmWX/YHhn7X8ed9TC60eLt2mHiu76sw1M/MYI/sPie1Cq770Fbf
 bsgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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



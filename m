Return-Path: <linux-fsdevel+bounces-68649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C49C6344E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A799360C59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A96328B45;
	Mon, 17 Nov 2025 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOvrAOJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C0324B26;
	Mon, 17 Nov 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372036; cv=none; b=ZZLGW86wyoQ7iDyAExzfeo2HV/Y0XLANN2u9Zwly3jNk+SMg2egWFU8e0/SY/JNOKdS2DiuFYbos6A4pJsHzFt+L2Ew2nSP0MnYGVcjvFxofp0wGdhmTRf/pEePqXrjLNtes6Z4VOel6OLd7p+j8SbUMqG0KU88qG7PfxJkTjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372036; c=relaxed/simple;
	bh=sRVLE58AbieJIj8E8Q6qk0xvga6kmgo+tkdtEOpYAUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxhydpD9akfJ5jM1N6TwaPNsokG/Vbu8AlWw/DaWDCqi9J4/l0wwMzVLU63gjRdc1LBjEMrzUwoSayBnL2QALNja3PDoR9FanDgBTZZbiNAvXkJAQ3WKYdXxbypGH81HETtU0G5j76u2VS3WN+o2C3Tnui/OOgftNBAua2lkKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOvrAOJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6A1C2BC9E;
	Mon, 17 Nov 2025 09:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372035;
	bh=sRVLE58AbieJIj8E8Q6qk0xvga6kmgo+tkdtEOpYAUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WOvrAOJIvuPtfCFtdqbenhQDdcBxXLhrnvlPn2hQpqG2rNC+Th68q7SfJrKxc8nHu
	 SEAvZI+dYPRvq1Cyw941OMrPwVObkmFD5r29CBTSlwsUOON/YUn8IObNU4k8k24en8
	 AdT5Aujxh7IGVAqbP+9igHoAW/ZCxcCw1XH4E7xh0AEokxfYFVOhomSc6YXqYriDaP
	 4a0jhbJ6WXe+Sw+y34GhEUhPy9kDAwhw/thYkl4styXez5rwVdts29ZtLqF0rmPpzY
	 4ryNCP1AgJdAGDrioN/fWxCYGoWdVWPX6efKeAiB16Wy/KAeF+0pIefN9XDc529TNW
	 DOp7xCuOkjiGg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:37 +0100
Subject: [PATCH v4 06/42] ovl: port ovl_create_tmpfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-6-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2192; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sRVLE58AbieJIj8E8Q6qk0xvga6kmgo+tkdtEOpYAUc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf5ytm3uBqmHO70UL847x3xbU4vx8sx9x0q751rox
 rtfXrDIrqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiXC8Z/vtpPO9ftVdXdKbY
 zGPtbknXHIRvtK76k3tdykph4bGrU9MY/rvwmzV37HyXN7Pue/3UvBC9Pws2TY1mq69d2XQrei5
 DNDcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 1a801fa40dd1..3dbca78aa1bb 100644
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
@@ -1332,13 +1332,10 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
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
 		realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
@@ -1346,13 +1343,12 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 		err = PTR_ERR_OR_ZERO(realfile);
 		pr_debug("tmpfile/open(%pd2, 0%o) = %i\n", realparentpath.dentry, mode, err);
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
@@ -1364,9 +1360,7 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
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



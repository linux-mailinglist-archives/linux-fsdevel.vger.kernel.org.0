Return-Path: <linux-fsdevel+bounces-54567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F11B00F87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0964E0898
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A172D3220;
	Thu, 10 Jul 2025 23:21:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2222C15A8;
	Thu, 10 Jul 2025 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189692; cv=none; b=ngEpypomDJEQTc+VMBKs+Rhku8NmX/VacrTTwFUQgOvcw8nQCpbZddM3AShqIbrivMVgOSP6UmIWOpymgoeyfPu7zcu2CvDxsU5c8eSmke+fNLGieXCY3e1oMZMPBaCIed0XxAwhLnFbe/AYuIwmNVW9C7vH0uPFGTg1tHNV4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189692; c=relaxed/simple;
	bh=stK/BYLl/AmXwECYUY6H9drGGoFvmQJrk60S7S1A5IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/TE55aNJ3uH65L9B/i7mwCPfNv0QF8yD8vZEvvQ/PSj4pzLxcwilmTQCy5r31GeQkvF5IVX5/d/PuHL42aLypEAho7pDBdsgNQtks6rf+RT65NZwLex0SnxxfqeS1eQsHA73dZlTxCEP2RdvYOtK4iVW2E5EH6McJ9jF7Kx/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zs-001XGM-TW;
	Thu, 10 Jul 2025 23:21:22 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/20] ovl: narrow locking in ovl_rename()
Date: Fri, 11 Jul 2025 09:03:38 +1000
Message-ID: <20250710232109.3014537-9-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710232109.3014537-1-neil@brown.name>
References: <20250710232109.3014537-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the rename lock immediately after the rename, and use
ovl_cleanup_unlocked() for cleanup.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 687d5e12289c..d01e83f9d800 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1262,9 +1262,10 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 			    new_upperdir, newdentry, flags);
 	if (err)
 		goto out_dput;
+	unlock_rename(new_upperdir, old_upperdir);
 
 	if (cleanup_whiteout)
-		ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
+		ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
 
 	if (overwrite && d_inode(new)) {
 		if (new_is_dir)
@@ -1283,12 +1284,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	if (d_inode(new) && ovl_dentry_upper(new))
 		ovl_copyattr(d_inode(new));
 
-out_dput:
 	dput(newdentry);
-out_dput_old:
 	dput(olddentry);
-out_unlock:
-	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
 	ovl_revert_creds(old_cred);
 	if (update_nlink)
@@ -1299,6 +1296,14 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	dput(opaquedir);
 	ovl_cache_free(&list);
 	return err;
+
+out_dput:
+	dput(newdentry);
+out_dput_old:
+	dput(olddentry);
+out_unlock:
+	unlock_rename(new_upperdir, old_upperdir);
+	goto out_revert_creds;
 }
 
 static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
-- 
2.49.0



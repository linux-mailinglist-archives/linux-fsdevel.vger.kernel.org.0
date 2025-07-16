Return-Path: <linux-fsdevel+bounces-55055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77535B06ACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA037B3B8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B681A2C06;
	Wed, 16 Jul 2025 00:47:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC6199FB0;
	Wed, 16 Jul 2025 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626857; cv=none; b=qR646+sxtnlORUXu3TUKRhqTZxms29WazygBb5vDOL0QvT06V+uuGv4rrJA7abbUAXwawVzN8n30yF0zE7oqMz/Ok39RsxQMFwEai8U2tNRL8JIRpnaErM7aQV2vb/1W69GI+As3RcPRmPTf7a/5qPrdi7Y/eI6LowRV1Aajl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626857; c=relaxed/simple;
	bh=B+1E78wkkfnegZKvTHfkhA8lnjgM6KC2FpcQO+KdQLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9KGBlbNloAPyNKjun+5aRbARI47VwTL3wYY9U9SwWBV0Y8LrVUZnV8IaOL9U6ixAnzhlZ6ZM0r2cCkjCKFhChEGK8ODcsaWJvPplFGwD1xUdbVezw1bQZqkUHwQ9el3xttmFOVpGmBRj9Aall7U5ALozm0szf3rfsL7D+T98/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ2-002AAs-Hx;
	Wed, 16 Jul 2025 00:47:34 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 08/21] ovl: simplify gotos in ovl_rename()
Date: Wed, 16 Jul 2025 10:44:19 +1000
Message-ID: <20250716004725.1206467-9-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716004725.1206467-1-neil@brown.name>
References: <20250716004725.1206467-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than having three separate goto label: out_unlock, out_dput_old,
and out_dput, make use of that fact that dput() happily accepts a NULL
pointer to reduce this to just one goto label: out_unlock.

olddentry and newdentry are initialised to NULL and only set once a
value dentry is found.  They are then dput() late in the function.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 7c92ffb6e312..138dd85d2242 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1082,9 +1082,9 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	int err;
 	struct dentry *old_upperdir;
 	struct dentry *new_upperdir;
-	struct dentry *olddentry;
-	struct dentry *newdentry;
-	struct dentry *trap;
+	struct dentry *olddentry = NULL;
+	struct dentry *newdentry = NULL;
+	struct dentry *trap, *de;
 	bool old_opaque;
 	bool new_opaque;
 	bool cleanup_whiteout = false;
@@ -1197,21 +1197,23 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		goto out_revert_creds;
 	}
 
-	olddentry = ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
-				     old->d_name.len);
-	err = PTR_ERR(olddentry);
-	if (IS_ERR(olddentry))
+	de = ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
+			      old->d_name.len);
+	err = PTR_ERR(de);
+	if (IS_ERR(de))
 		goto out_unlock;
+	olddentry = de;
 
 	err = -ESTALE;
 	if (!ovl_matches_upper(old, olddentry))
-		goto out_dput_old;
+		goto out_unlock;
 
-	newdentry = ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
-				     new->d_name.len);
-	err = PTR_ERR(newdentry);
-	if (IS_ERR(newdentry))
-		goto out_dput_old;
+	de = ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
+			      new->d_name.len);
+	err = PTR_ERR(de);
+	if (IS_ERR(de))
+		goto out_unlock;
+	newdentry = de;
 
 	old_opaque = ovl_dentry_is_opaque(old);
 	new_opaque = ovl_dentry_is_opaque(new);
@@ -1220,28 +1222,28 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	if (d_inode(new) && ovl_dentry_upper(new)) {
 		if (opaquedir) {
 			if (newdentry != opaquedir)
-				goto out_dput;
+				goto out_unlock;
 		} else {
 			if (!ovl_matches_upper(new, newdentry))
-				goto out_dput;
+				goto out_unlock;
 		}
 	} else {
 		if (!d_is_negative(newdentry)) {
 			if (!new_opaque || !ovl_upper_is_whiteout(ofs, newdentry))
-				goto out_dput;
+				goto out_unlock;
 		} else {
 			if (flags & RENAME_EXCHANGE)
-				goto out_dput;
+				goto out_unlock;
 		}
 	}
 
 	if (olddentry == trap)
-		goto out_dput;
+		goto out_unlock;
 	if (newdentry == trap)
-		goto out_dput;
+		goto out_unlock;
 
 	if (olddentry->d_inode == newdentry->d_inode)
-		goto out_dput;
+		goto out_unlock;
 
 	err = 0;
 	if (ovl_type_merge_or_lower(old))
@@ -1249,7 +1251,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
 		err = ovl_set_opaque_xerr(old, olddentry, -EXDEV);
 	if (err)
-		goto out_dput;
+		goto out_unlock;
 
 	if (!overwrite && ovl_type_merge_or_lower(new))
 		err = ovl_set_redirect(new, samedir);
@@ -1257,12 +1259,12 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		 ovl_type_merge(old->d_parent))
 		err = ovl_set_opaque_xerr(new, newdentry, -EXDEV);
 	if (err)
-		goto out_dput;
+		goto out_unlock;
 
 	err = ovl_do_rename(ofs, old_upperdir, olddentry,
 			    new_upperdir, newdentry, flags);
 	if (err)
-		goto out_dput;
+		goto out_unlock;
 
 	if (cleanup_whiteout)
 		ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
@@ -1284,10 +1286,6 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	if (d_inode(new) && ovl_dentry_upper(new))
 		ovl_copyattr(d_inode(new));
 
-out_dput:
-	dput(newdentry);
-out_dput_old:
-	dput(olddentry);
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
@@ -1297,6 +1295,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	else
 		ovl_drop_write(old);
 out:
+	dput(newdentry);
+	dput(olddentry);
 	dput(opaquedir);
 	ovl_cache_free(&list);
 	return err;
-- 
2.49.0



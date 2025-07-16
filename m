Return-Path: <linux-fsdevel+bounces-55049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9CCB06AC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C0316EF62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D919258E;
	Wed, 16 Jul 2025 00:47:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C256433AC;
	Wed, 16 Jul 2025 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626854; cv=none; b=tZ7I3Dl1/Kd+Wmzd7hEaLAwNLSpcaLYJDIYFd0EuiQLL5/rxoKmLa+IPCCamjqk21D/eO2dPGzZQNMlzqs0f9dSuBEr/MXpA9+vW6S+wvIGOzj2Cnm/8d16PlPEgRHVw7KZu8mpOx8CokzhTR9IiqEJZrpdA7TBaYLIQf7fHXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626854; c=relaxed/simple;
	bh=J62N3+B0RaIkSohgwPybKCNylYiIgs3bEDDAnuYL3LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkqCiKKi6+676EVpsQPPyKxDVDDJZZFKiq98HZ1NQ32hhb/HxR5zBUfvyGOpdvpbzZhCGt3hWUDUE+Whl0S/UcDgNUvNh94VRCtfGVeh6RXdGBQIUOIMRGnO8NW65M88suHU3m69e1enyqIBFRte1XDJN3QnZYiuY5ZUH0BR4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqIz-002AAN-Ok;
	Wed, 16 Jul 2025 00:47:31 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 02/21] ovl: change ovl_create_index() to take dir locks
Date: Wed, 16 Jul 2025 10:44:13 +1000
Message-ID: <20250716004725.1206467-3-neil@brown.name>
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

ovl_copy_up_workdir() currently take a rename lock on two directories,
then use the lock to both create a file in one directory, perform a
rename, and possibly unlink the file for cleanup.  This is incompatible
with proposed changes which will lock just the dentry of objects being
acted on.

This patch moves the call to ovl_create_index() earlier in
ovl_copy_up_workdir() to before the lock is taken.

ovl_create_index() then takes the required lock only when needed.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 79f41ef6ffa7..d485bd7edd8f 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -517,8 +517,6 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
 
 /*
  * Create and install index entry.
- *
- * Caller must hold i_mutex on indexdir.
  */
 static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 			    struct dentry *upper)
@@ -550,7 +548,9 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (err)
 		return err;
 
+	inode_lock(dir);
 	temp = ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
+	inode_unlock(dir);
 	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
 		goto free_name;
@@ -559,6 +559,9 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (err)
 		goto out;
 
+	err = ovl_parent_lock(indexdir, temp);
+	if (err)
+		goto out;
 	index = ovl_lookup_upper(ofs, name.name, indexdir, name.len);
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
@@ -566,9 +569,10 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 		err = ovl_do_rename(ofs, indexdir, temp, indexdir, index, 0);
 		dput(index);
 	}
+	ovl_parent_unlock(indexdir);
 out:
 	if (err)
-		ovl_cleanup(ofs, dir, temp);
+		ovl_cleanup_unlocked(ofs, indexdir, temp);
 	dput(temp);
 free_name:
 	kfree(name.name);
@@ -798,6 +802,12 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (err)
 		goto cleanup_unlocked;
 
+	if (S_ISDIR(c->stat.mode) && c->indexed) {
+		err = ovl_create_index(c->dentry, c->origin_fh, temp);
+		if (err)
+			goto cleanup_unlocked;
+	}
+
 	/*
 	 * We cannot hold lock_rename() throughout this helper, because of
 	 * lock ordering with sb_writers, which shouldn't be held when calling
@@ -818,12 +828,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (err)
 		goto cleanup;
 
-	if (S_ISDIR(c->stat.mode) && c->indexed) {
-		err = ovl_create_index(c->dentry, c->origin_fh, temp);
-		if (err)
-			goto cleanup;
-	}
-
 	upper = ovl_lookup_upper(ofs, c->destname.name, c->destdir,
 				 c->destname.len);
 	err = PTR_ERR(upper);
-- 
2.49.0



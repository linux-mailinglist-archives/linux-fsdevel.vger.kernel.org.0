Return-Path: <linux-fsdevel+bounces-55059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C94B06AD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D67189F5F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9122114A09C;
	Wed, 16 Jul 2025 00:47:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07E1A704B;
	Wed, 16 Jul 2025 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626860; cv=none; b=o+PJ2Wo/dXTxjYKwL86kXI68/Lvx8/WBneLXHj9brY43U8tRScvO2duOFSTvaEZIoOpoPviOFyVRifWPyX26OcDNX3vutYQpARcUJ6XtDKPcD5zVtLUmTj8O2sXTMOfO2sghB/acLt6tM0E6pMegRAHrsqKPzYwphsMce30pV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626860; c=relaxed/simple;
	bh=A7BXoxhpGLRrqGuDvhijandWTKFSaR5IOkHAsIhGqL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+ForO22ux8yDMsr5mRs70Xu25WogBJOx9xuWTjhKKE6emAvutskj/xmPhnZ74AFU4RtsyY/znT3ime0Cpp+273uVQ1DdEcb8B4LoJW4MOmf3ph++aaDJkCk3aemg3p/kfsskzj/y1H/bnfpZ4ZPlg5N5hd1k1TLnO7uYgovWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ5-002ABM-BL;
	Wed, 16 Jul 2025 00:47:37 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 12/21] ovl: narrow locking in ovl_workdir_create()
Date: Wed, 16 Jul 2025 10:44:23 +1000
Message-ID: <20250716004725.1206467-13-neil@brown.name>
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

In ovl_workdir_create() don't hold the dir lock for the whole time, but
only take it when needed.

It now gets taken separately for ovl_workdir_cleanup().  A subsequent
patch will move the locking into that function.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/super.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 2e6b25bde83f..cb2551a155d8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -299,8 +299,8 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 	int err;
 	bool retried = false;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
 retry:
+	inode_lock_nested(dir, I_MUTEX_PARENT);
 	work = ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(name));
 
 	if (!IS_ERR(work)) {
@@ -311,23 +311,28 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 
 		if (work->d_inode) {
 			err = -EEXIST;
+			inode_unlock(dir);
 			if (retried)
 				goto out_dput;
 
 			if (persist)
-				goto out_unlock;
+				return work;
 
 			retried = true;
-			err = ovl_workdir_cleanup(ofs, dir, mnt, work, 0);
-			dput(work);
-			if (err == -EINVAL) {
-				work = ERR_PTR(err);
-				goto out_unlock;
+			err = ovl_parent_lock(ofs->workbasedir, work);
+			if (!err) {
+				err = ovl_workdir_cleanup(ofs, dir, mnt, work, 0);
+				ovl_parent_unlock(ofs->workbasedir);
 			}
+			dput(work);
+			if (err == -EINVAL)
+				return ERR_PTR(err);
+
 			goto retry;
 		}
 
 		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
+		inode_unlock(dir);
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
@@ -365,11 +370,10 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		if (err)
 			goto out_dput;
 	} else {
+		inode_unlock(dir);
 		err = PTR_ERR(work);
 		goto out_err;
 	}
-out_unlock:
-	inode_unlock(dir);
 	return work;
 
 out_dput:
@@ -377,8 +381,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 out_err:
 	pr_warn("failed to create directory %s/%s (errno: %i); mounting read-only\n",
 		ofs->config.workdir, name, -err);
-	work = NULL;
-	goto out_unlock;
+	return NULL;
 }
 
 static int ovl_check_namelen(const struct path *path, struct ovl_fs *ofs,
-- 
2.49.0



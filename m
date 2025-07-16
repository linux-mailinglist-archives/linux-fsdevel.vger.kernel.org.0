Return-Path: <linux-fsdevel+bounces-55065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902E3B06AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D4517694C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9AE1C6FE9;
	Wed, 16 Jul 2025 00:47:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D401C1ADB;
	Wed, 16 Jul 2025 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626865; cv=none; b=h8+au5yS2V2t0JFzHb7+tt7IAmCXYTguUep/VH/xdyrFeUd6EgiArPTeln/aWndBq+f5JkQ68oLHvk2TTVZdN4rNLchoTSsGeVryRAeqrWtfVOyX+vRZ1KTBlF6AW2DKFLoC5Whazi6/NZec6QqhWhYhl4fZboD+w9XOLCd0luY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626865; c=relaxed/simple;
	bh=8Y1cvMz/Q8sGNaSE5H3VssF2fmuv0ekfttJHcuknU2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caVEdAZWvGOOJ4OFJ4EPHsNw2gGuvqstz9F6LfKmAKWuirwNFUjaqJ2+r6dcssbAa0+VL1MsHpGeBUA4NA2j4XzutvZ/BfbqPrKVW7TFAcz6DhT8gJ2csqGcyugcknu5zNJebWS/JWM4fd26wV71fafILLl62xvf+8JNxWe35vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJA-002ABw-Nl;
	Wed, 16 Jul 2025 00:47:42 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 18/21] ovl: narrow locking in ovl_whiteout()
Date: Wed, 16 Jul 2025 10:44:29 +1000
Message-ID: <20250716004725.1206467-19-neil@brown.name>
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

ovl_whiteout() relies on the workdir i_rwsem to provide exclusive access
to ofs->whiteout which it manipulates.  Rather than depending on this,
add a new mutex, "whiteout_lock" to explicitly provide the required
locking.  Use guard(mutex) for this so that we can return without
needing to explicitly unlock.

Then take the lock on workdir only when needed - to lookup the temp name
and to do the whiteout or link.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c       | 44 ++++++++++++++++++++++------------------
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/params.c    |  2 ++
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6a70faeee6fa..7eb806a4e5f8 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -84,41 +84,45 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	struct dentry *workdir = ofs->workdir;
 	struct inode *wdir = workdir->d_inode;
 
-	inode_lock_nested(wdir, I_MUTEX_PARENT);
+	guard(mutex)(&ofs->whiteout_lock);
+
 	if (!ofs->whiteout) {
+		inode_lock_nested(wdir, I_MUTEX_PARENT);
 		whiteout = ovl_lookup_temp(ofs, workdir);
-		if (IS_ERR(whiteout))
-			goto out;
-
-		err = ovl_do_whiteout(ofs, wdir, whiteout);
-		if (err) {
-			dput(whiteout);
-			whiteout = ERR_PTR(err);
-			goto out;
+		if (!IS_ERR(whiteout)) {
+			err = ovl_do_whiteout(ofs, wdir, whiteout);
+			if (err) {
+				dput(whiteout);
+				whiteout = ERR_PTR(err);
+			}
 		}
+		inode_unlock(wdir);
+		if (IS_ERR(whiteout))
+			return whiteout;
 		ofs->whiteout = whiteout;
 	}
 
 	if (!ofs->no_shared_whiteout) {
+		inode_lock_nested(wdir, I_MUTEX_PARENT);
 		whiteout = ovl_lookup_temp(ofs, workdir);
-		if (IS_ERR(whiteout))
-			goto out;
-
-		err = ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
-		if (!err)
-			goto out;
-
-		if (err != -EMLINK) {
+		if (!IS_ERR(whiteout)) {
+			err = ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
+			if (err) {
+				dput(whiteout);
+				whiteout = ERR_PTR(err);
+			}
+		}
+		inode_unlock(wdir);
+		if (!IS_ERR(whiteout))
+			return whiteout;
+		if (PTR_ERR(whiteout) != -EMLINK) {
 			pr_warn("Failed to link whiteout - disabling whiteout inode sharing(nlink=%u, err=%i)\n",
 				ofs->whiteout->d_inode->i_nlink, err);
 			ofs->no_shared_whiteout = true;
 		}
-		dput(whiteout);
 	}
 	whiteout = ofs->whiteout;
 	ofs->whiteout = NULL;
-out:
-	inode_unlock(wdir);
 	return whiteout;
 }
 
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index afb7762f873f..4c1bae935ced 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -88,6 +88,7 @@ struct ovl_fs {
 	/* Shared whiteout cache */
 	struct dentry *whiteout;
 	bool no_shared_whiteout;
+	struct mutex whiteout_lock;
 	/* r/o snapshot of upperdir sb's only taken on volatile mounts */
 	errseq_t errseq;
 };
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index f42488c01957..cb1a17c066cd 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -797,6 +797,8 @@ int ovl_init_fs_context(struct fs_context *fc)
 	fc->s_fs_info		= ofs;
 	fc->fs_private		= ctx;
 	fc->ops			= &ovl_context_ops;
+
+	mutex_init(&ofs->whiteout_lock);
 	return 0;
 
 out_err:
-- 
2.49.0



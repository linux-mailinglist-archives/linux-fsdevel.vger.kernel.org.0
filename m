Return-Path: <linux-fsdevel+bounces-55054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C8AB06ACB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B5F189F772
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0619A1A238F;
	Wed, 16 Jul 2025 00:47:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E70199EAD;
	Wed, 16 Jul 2025 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626857; cv=none; b=hMXHPGG5FTJ+G9NNIvqkpbZm0yHzPXdheRhJAmKlyS9T/dJ0hbuF5X5mXxqze3U8eY+2c2a3GmrnjMnwPqPrdAVIe7K/lME27RX/p5WFfApeD+gUVybqOTFLUDNgJammfBQ0/FV3wa6KW3uL8YDvpdZ6eJfhqrUVnnvDIZDkzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626857; c=relaxed/simple;
	bh=6+j3ArTQHEKl5rLEY3BiEE8WG80F/u3AdP2iWhgNgFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HweXrkfJ5Fqpb0Ri7AZJ/UEFGNz8110apkf/IwjxwvXok8TrUrsJKE6lbLN1kUsYI63/zIWs4NiDK3icw0ulTKyc2IbEMUxMI6BU/2NVwWTWh3TYd4vQlMhEw0Yq9myMe99wbeihs9Wvo34+w5LNaagb+/j13TdYNUOSpPUgINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ2-002AAo-3Y;
	Wed, 16 Jul 2025 00:47:33 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 07/21] ovl: narrow locking in ovl_create_over_whiteout()
Date: Wed, 16 Jul 2025 10:44:18 +1000
Message-ID: <20250716004725.1206467-8-neil@brown.name>
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

Unlock the parents immediately after the rename, and use
ovl_cleanup_unlocked() for cleanup, which takes a separate lock.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 540b67f5cdf5..7c92ffb6e312 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -433,9 +433,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
-	struct inode *wdir = workdir->d_inode;
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
-	struct inode *udir = upperdir->d_inode;
 	struct dentry *upper;
 	struct dentry *newdentry;
 	int err;
@@ -506,22 +504,23 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 
 		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper,
 				    RENAME_EXCHANGE);
+		unlock_rename(workdir, upperdir);
 		if (err)
-			goto out_cleanup;
+			goto out_cleanup_unlocked;
 
-		ovl_cleanup(ofs, wdir, upper);
+		ovl_cleanup_unlocked(ofs, workdir, upper);
 	} else {
 		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
+		unlock_rename(workdir, upperdir);
 		if (err)
-			goto out_cleanup;
+			goto out_cleanup_unlocked;
 	}
 	ovl_dir_modified(dentry->d_parent, false);
 	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
 	if (err) {
-		ovl_cleanup(ofs, udir, newdentry);
+		ovl_cleanup_unlocked(ofs, upperdir, newdentry);
 		dput(newdentry);
 	}
-	unlock_rename(workdir, upperdir);
 out_dput:
 	dput(upper);
 out:
-- 
2.49.0



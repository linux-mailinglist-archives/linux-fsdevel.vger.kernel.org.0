Return-Path: <linux-fsdevel+bounces-54566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01088B00F85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1013E7A3BC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD952D29B1;
	Thu, 10 Jul 2025 23:21:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0921A2BE057;
	Thu, 10 Jul 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189692; cv=none; b=rN6E2/YE4HfJdugFcy5HO642sdTqTdaTd34ccMKFo4ArAGynL8kc97WR272opzHUUGQ/yayKJSj9F1TMVDPrlEOzILCnWX5Qidp32nYXCMNyfD2FjWVVhBg7FYYpEsb78MJNcZJCvaDP1UBZFZsTrZKihr1fIwaOz5KuYvnBX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189692; c=relaxed/simple;
	bh=7YJBNMI+7ogHACruQ93+DCY8QTg9eMk4NXVHQDOxlec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMmyDM1cv8PmUcTiwk3+kNqclsw7ARNqrFvGVqBp3BrwYhMI59rgfsl1tt40EjZmmCCSb7wo9sf3HBrEZW5vei3BC/bNmMJh3STBhp6IwLykAVZEM/SD8KnEJdDTO7q3+tG0cpJY4wzbpD0kZjwtL4mZklEV/G6BNoZPrIxtY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zx-001XHM-I0;
	Thu, 10 Jul 2025 23:21:27 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/20] ovl: narrow locking in ovl_check_rename_whiteout()
Date: Fri, 11 Jul 2025 09:03:48 +1000
Message-ID: <20250710232109.3014537-19-neil@brown.name>
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

ovl_check_rename_whiteout() now only holds the directory lock when
needed, and takes it again if necessary.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/super.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 23f43f8131dd..78f4fcfb9ff6 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -559,7 +559,6 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 {
 	struct dentry *workdir = ofs->workdir;
-	struct inode *dir = d_inode(workdir);
 	struct dentry *temp;
 	struct dentry *dest;
 	struct dentry *whiteout;
@@ -580,19 +579,22 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	err = PTR_ERR(dest);
 	if (IS_ERR(dest)) {
 		dput(temp);
-		goto out_unlock;
+		parent_unlock(workdir);
+		return err;
 	}
 
 	/* Name is inline and stable - using snapshot as a copy helper */
 	take_dentry_name_snapshot(&name, temp);
 	err = ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_WHITEOUT);
+	parent_unlock(workdir);
 	if (err) {
 		if (err == -EINVAL)
 			err = 0;
 		goto cleanup_temp;
 	}
 
-	whiteout = ovl_lookup_upper(ofs, name.name.name, workdir, name.name.len);
+	whiteout = ovl_lookup_upper_unlocked(ofs, name.name.name,
+					     workdir, name.name.len);
 	err = PTR_ERR(whiteout);
 	if (IS_ERR(whiteout))
 		goto cleanup_temp;
@@ -601,18 +603,15 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
 	/* Best effort cleanup of whiteout and temp file */
 	if (err)
-		ovl_cleanup(ofs, dir, whiteout);
+		ovl_cleanup_unlocked(ofs, workdir, whiteout);
 	dput(whiteout);
 
 cleanup_temp:
-	ovl_cleanup(ofs, dir, temp);
+	ovl_cleanup_unlocked(ofs, workdir, temp);
 	release_dentry_name_snapshot(&name);
 	dput(temp);
 	dput(dest);
 
-out_unlock:
-	parent_unlock(workdir);
-
 	return err;
 }
 
-- 
2.49.0



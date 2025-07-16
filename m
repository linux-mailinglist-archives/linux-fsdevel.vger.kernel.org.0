Return-Path: <linux-fsdevel+bounces-55056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1CB06AD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9457B3B39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9B1A7253;
	Wed, 16 Jul 2025 00:47:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99319D092;
	Wed, 16 Jul 2025 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626858; cv=none; b=SHUHeg/4nLuBCV3IqZkHDlLayYGU9Q3zZfl7Qjs9Ss+eWV/0hq7anzg6DQ8cn+j9oA3+SIpT/VYYCC0r1IAQ7wLubC4leVL7gvrlhzjyNRRXa4fLsUlYV7XPcc/EFXwUNMR1jRiX/n9SCVAuP+Pgkmh/Nlmlxtt+uZ17/XAvItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626858; c=relaxed/simple;
	bh=rRCIbOzLBCyIleJ3p7cmwrHTwMavSTq3NcEt2l0SGX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7BiIw7IlQYkKpA+yGHi4nuUfHGFvi+Vcsjra36OqgqUimwKIZZTHzgjEl3N6tVWDS67YMm3OoghJD6IsIcy8Rw3b38L+g8xGXjrRabHeS146gxpNeRbPGQmkfc1Y28jN+NSWbADb9wrO7KBIUfe2VuhyQSw3FqaQhRm6mqXzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ3-002AB0-5W;
	Wed, 16 Jul 2025 00:47:34 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/21] ovl: narrow locking in ovl_rename()
Date: Wed, 16 Jul 2025 10:44:20 +1000
Message-ID: <20250716004725.1206467-10-neil@brown.name>
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

Drop the rename lock immediately after the rename, and use
ovl_cleanup_unlocked() for cleanup.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 138dd85d2242..e81be60f1125 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1263,11 +1263,12 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 
 	err = ovl_do_rename(ofs, old_upperdir, olddentry,
 			    new_upperdir, newdentry, flags);
+	unlock_rename(new_upperdir, old_upperdir);
 	if (err)
-		goto out_unlock;
+		goto out_revert_creds;
 
 	if (cleanup_whiteout)
-		ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
+		ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
 
 	if (overwrite && d_inode(new)) {
 		if (new_is_dir)
@@ -1286,8 +1287,6 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	if (d_inode(new) && ovl_dentry_upper(new))
 		ovl_copyattr(d_inode(new));
 
-out_unlock:
-	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
 	ovl_revert_creds(old_cred);
 	if (update_nlink)
@@ -1300,6 +1299,10 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	dput(opaquedir);
 	ovl_cache_free(&list);
 	return err;
+
+out_unlock:
+	unlock_rename(new_upperdir, old_upperdir);
+	goto out_revert_creds;
 }
 
 static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
-- 
2.49.0



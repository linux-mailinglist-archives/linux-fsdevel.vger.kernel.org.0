Return-Path: <linux-fsdevel+bounces-55066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BA1B06ADD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A04A02BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A4D1C84CB;
	Wed, 16 Jul 2025 00:47:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2071C5D44;
	Wed, 16 Jul 2025 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626866; cv=none; b=ePUibth5tIDZpTfjKmrixZtwLI5z7Onl6lKbceXoAhYSFjuefHFChiwlBAcp97ZnHTqshR5u7lSNmrMm6c6ERKf0OQBN7FAVabZshhOjS8bGaPWWEFN0z1ti+1n00JQtYHpdbS9/wxcRnyN+F9ZX84JOhp2qhSV68ZeQ9EBdV68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626866; c=relaxed/simple;
	bh=F/NgJCo42HLBJpwOGacFcVuSYGcXam+3SvxjGxMFpg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2Iruj9ErAAKEyGjd4t3FOCl0Q4gHo5cYBGN6Uye1HSzyzHEQfEoY02HXJjgUnr9hCZSdb3fkWizlIFAmiFROmXlXydH9fwrJCcXIRi37AxxX0n4o3Ou5d8mDbf3V/jEwXsC7PIFPsmwVeWZiwHfge9MAMUIB26s/OhBvLuoHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJB-002AC2-Lp;
	Wed, 16 Jul 2025 00:47:43 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 19/21] ovl: narrow locking in ovl_check_rename_whiteout()
Date: Wed, 16 Jul 2025 10:44:30 +1000
Message-ID: <20250716004725.1206467-20-neil@brown.name>
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

ovl_check_rename_whiteout() now only holds the directory lock when
needed, and takes it again if necessary.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/super.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 4c3736bf2db4..0d765aa66bd2 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -556,7 +556,6 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 {
 	struct dentry *workdir = ofs->workdir;
-	struct inode *dir = d_inode(workdir);
 	struct dentry *temp;
 	struct dentry *dest;
 	struct dentry *whiteout;
@@ -577,19 +576,22 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	err = PTR_ERR(dest);
 	if (IS_ERR(dest)) {
 		dput(temp);
-		goto out_unlock;
+		ovl_parent_unlock(workdir);
+		return err;
 	}
 
 	/* Name is inline and stable - using snapshot as a copy helper */
 	take_dentry_name_snapshot(&name, temp);
 	err = ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_WHITEOUT);
+	ovl_parent_unlock(workdir);
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
@@ -598,18 +600,15 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
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
-	ovl_parent_unlock(workdir);
-
 	return err;
 }
 
-- 
2.49.0



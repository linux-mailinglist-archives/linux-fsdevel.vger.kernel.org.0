Return-Path: <linux-fsdevel+bounces-52825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01091AE72DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56831170380
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6580B25CC46;
	Tue, 24 Jun 2025 23:07:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452825BEED;
	Tue, 24 Jun 2025 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806439; cv=none; b=XWoCvShYSqJKd5yDkCCL3OwNookPNjW7aAqSntKulFRE8vlhucMcKj+PhNgNuwUK7puMXmr8Agw09iIS/P4fHxaTMbYXSUzXnRKSVFTNkujB4Kq2WNp0bt48gMY588BFKXB8X+XHmskv8niOxbDLiAABXidxfHcBXCmkXwJOJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806439; c=relaxed/simple;
	bh=24CgdTKe4XZX0sjOG2vSk+p0D5HWbw29TA3XAl3mcV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukqIVLET6LCrG8hJrp7scaXxIWshlRZ+j3L+7llFXDoQHIcGOxrRxN23UHnopbA7WKGYcp8xvu5J82bNpbk3+tDfe67q4HLEDTMDeOpkyGNBTBJMOn72PycGsYQj+8e8eLhjy7a4Iyt+bXZF55+L2a7dyudbraA3ASYl9OpaOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjT-0045cW-SN;
	Tue, 24 Jun 2025 23:07:15 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/12] ovl: narrow locking in ovl_rename()
Date: Wed, 25 Jun 2025 08:55:03 +1000
Message-ID: <20250624230636.3233059-8-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624230636.3233059-1-neil@brown.name>
References: <20250624230636.3233059-1-neil@brown.name>
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
index 2b879d7c386e..5afe17cee305 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1270,9 +1270,10 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 			    new_upperdir, newdentry, flags);
 	if (err)
 		goto out_dput;
+	unlock_rename(new_upperdir, old_upperdir);
 
 	if (cleanup_whiteout)
-		ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
+		ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
 
 	if (overwrite && d_inode(new)) {
 		if (new_is_dir)
@@ -1291,12 +1292,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
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
@@ -1307,6 +1304,14 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
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



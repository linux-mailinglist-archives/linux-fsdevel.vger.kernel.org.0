Return-Path: <linux-fsdevel+bounces-52827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CAEAE72E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444DA3BBDE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89725D1E0;
	Tue, 24 Jun 2025 23:07:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076D25C833;
	Tue, 24 Jun 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806441; cv=none; b=BLxQtOnTp6ylciDoL+SJYDr788EbYuvgQNy6bo9raiwkeYEPYxBoYlrwMqbri5JD0D8e52BYuhdaULyLL4RmQX6rCYD85h7x7JnUMo56QKFBy2aEy7dSMESOmMcRdNndZM2yfhdPWmuh1uDPM84/acOrJBZ9ciuxSRvDt7P2J1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806441; c=relaxed/simple;
	bh=WngsQQZ4qT1GiSmehyheV/EU9u4n76zixnfEX6f5/0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qddWGie760vw2hQVflGkRiMWUJJcaNgGUIpLXDEpTpdFll7ww2qROAm6d5o5YlIxgrq7B5jWco0qVw0bN7IavIuMhSUDA2ACd43xjF7Wkaw6PylGp+HF8Cr/Ljqx8IwC5v+aqdwZUAJvTt5807gcUSGPZFgPkrYSoMtvjsd/Y9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjV-0045co-MU;
	Tue, 24 Jun 2025 23:07:17 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/12] ovl: narrow locking in ovl_check_rename_whiteout()
Date: Wed, 25 Jun 2025 08:55:06 +1000
Message-ID: <20250624230636.3233059-11-neil@brown.name>
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

ovl_check_rename_whiteout() now only holds the directory lock when
needed, and takes it again if necessary.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/super.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 3583e359655f..8331667b8101 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -554,7 +554,6 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 {
 	struct dentry *workdir = ofs->workdir;
-	struct inode *dir = d_inode(workdir);
 	struct dentry *temp;
 	struct dentry *dest;
 	struct dentry *whiteout;
@@ -571,19 +570,22 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	err = PTR_ERR(dest);
 	if (IS_ERR(dest)) {
 		dput(temp);
-		goto out_unlock;
+		unlock_rename(workdir, workdir);
+		goto out;
 	}
 
 	/* Name is inline and stable - using snapshot as a copy helper */
 	take_dentry_name_snapshot(&name, temp);
 	err = ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_WHITEOUT);
+	unlock_rename(workdir, workdir);
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
@@ -592,18 +594,16 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
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
-	unlock_rename(workdir, workdir);
-
+out:
 	return err;
 }
 
-- 
2.49.0



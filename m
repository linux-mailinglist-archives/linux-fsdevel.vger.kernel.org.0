Return-Path: <linux-fsdevel+bounces-52822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C432FAE72D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DA917043D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47C25A354;
	Tue, 24 Jun 2025 23:07:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A482254AF0;
	Tue, 24 Jun 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806438; cv=none; b=g8krWGLYZCyxELgFucCVfi6S+DJjkEq7zZImCVl69M/Ru7Zu50XEvwLEbtQK8cqFC2iGUSUbB1LsRMn3zXsR+9Gme9AuZTkOMcq3iFs6tmPmMcdsW6bwMWcGRgZdh8+sSLdbPpaPvwXR29sF13BfSJdaf3viiiwqc4a4vTtz7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806438; c=relaxed/simple;
	bh=6VZE875RLoymK9EW+oV6ZxAzqgvtTbBaqIU4+Kpzrt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI8WB3Flf65+yZvnSfsPTqt0kKfRUhvPgqSL+kGFI62hN9Dp8/IRSD1ICB/MLcXbF7RddtXxezEBZ0Sib7Q9lOd51g0YrnQKwQYi5Jw1wJUvQ/RhJdkvVSsx7K9MGcacGTUCm9bPNQUG5BJ5f0DB5a/KPnhKD488xOXLNvwyGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjR-0045cC-RI;
	Tue, 24 Jun 2025 23:07:13 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/12] ovl: narrow the locked region in ovl_copy_up_workdir()
Date: Wed, 25 Jun 2025 08:54:59 +1000
Message-ID: <20250624230636.3233059-4-neil@brown.name>
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

In ovl_copy_up_workdir() unlock immediately after the rename, and then
use ovl_cleanup_unlocked() with separate locking rather than using the
same lock to protect both.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7a21ad1f2b6e..884c738b67ff 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -763,7 +763,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *inode;
-	struct inode *wdir = d_inode(c->workdir);
 	struct path path = { .mnt = ovl_upper_mnt(ofs) };
 	struct dentry *temp, *upper, *trap;
 	struct ovl_cu_creds cc;
@@ -793,8 +792,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 */
 	path.dentry = temp;
 	err = ovl_copy_up_data(c, &path);
-	if (err)
-		goto cleanup_write_unlocked;
+	if (err) {
+		ovl_start_write(c->dentry);
+		goto cleanup_unlocked;
+	}
 	/*
 	 * We cannot hold lock_rename() throughout this helper, because of
 	 * lock ordering with sb_writers, which shouldn't be held when calling
@@ -814,9 +815,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		/* temp or workdir moved underneath us? abort without cleanup */
 		dput(temp);
 		err = -EIO;
-		if (IS_ERR(trap))
-			goto out;
-		goto unlock;
+		if (!IS_ERR(trap))
+			unlock_rename(c->workdir, c->destdir);
+		goto out;
 	}
 
 	err = ovl_copy_up_metadata(c, temp);
@@ -830,9 +831,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		goto cleanup;
 
 	err = ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
+	unlock_rename(c->workdir, c->destdir);
 	dput(upper);
 	if (err)
-		goto cleanup;
+		goto cleanup_unlocked;
 
 	inode = d_inode(c->dentry);
 	if (c->metacopy_digest)
@@ -846,20 +848,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
-unlock:
-	unlock_rename(c->workdir, c->destdir);
 out:
 	ovl_end_write(c->dentry);
 
 	return err;
 
 cleanup:
-	ovl_cleanup(ofs, wdir, temp);
-	dput(temp);
-	goto unlock;
-
-cleanup_write_unlocked:
-	ovl_start_write(c->dentry);
+	unlock_rename(c->workdir, c->destdir);
 cleanup_unlocked:
 	ovl_cleanup_unlocked(ofs, c->workdir, temp);
 	dput(temp);
-- 
2.49.0



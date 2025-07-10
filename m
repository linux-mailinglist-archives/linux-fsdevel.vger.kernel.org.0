Return-Path: <linux-fsdevel+bounces-54560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57448B00F79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B333BE084
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF673208;
	Thu, 10 Jul 2025 23:21:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7529E0EB;
	Thu, 10 Jul 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189690; cv=none; b=sEdVEsMwI9jriZUcbD9zJghuBLDRnWtIki80Y4awLvhGmYhygOZBsVhFqqqZEVXcSsB/lHVq1rBfbPk2A2zAEuG3+QvvL3fQ0jvkziwkeYWt+L5hBrt284p9a8Bdmw456qKSzbB8QmzS/NJc2emAkjsZTPgQgec8mBZCyOMRxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189690; c=relaxed/simple;
	bh=f6F0lIH9loXNY0UKfQbitCCTDd7y45h55SZLSAR6caI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i63zju+OEi5LiuzUcWVC1qHX2ew/KzcG8ah/SuzInsf3hq0opTVYjtiyoFjVjwt+a4u2t+IvBW7BMSzMvFqTYH24/sXJGZEY5D8+ZM4iaIKYrHK1jI104xZ3ymBmywDbPGkCzpjBZUa2NYvkP1sEJ+p/SzfWtONUf23O/969GLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zr-001XG0-5g;
	Thu, 10 Jul 2025 23:21:20 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/20] ovl: narrow the locked region in ovl_copy_up_workdir()
Date: Fri, 11 Jul 2025 09:03:34 +1000
Message-ID: <20250710232109.3014537-5-neil@brown.name>
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

In ovl_copy_up_workdir() unlock immediately after the rename, and then
use ovl_cleanup_unlocked() with separate locking rather than using the
same lock to protect both.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index eafb46686854..7b84a39c081f 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -765,7 +765,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *inode;
-	struct inode *wdir = d_inode(c->workdir);
 	struct path path = { .mnt = ovl_upper_mnt(ofs) };
 	struct dentry *temp, *upper, *trap;
 	struct ovl_cu_creds cc;
@@ -816,9 +815,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
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
@@ -832,9 +831,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		goto cleanup;
 
 	err = ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
+	unlock_rename(c->workdir, c->destdir);
 	dput(upper);
 	if (err)
-		goto cleanup;
+		goto cleanup_unlocked;
 
 	inode = d_inode(c->dentry);
 	if (c->metacopy_digest)
@@ -848,17 +848,17 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
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
+	unlock_rename(c->workdir, c->destdir);
+cleanup_unlocked:
+	ovl_cleanup_unlocked(ofs, c->workdir, temp);
 	dput(temp);
-	goto unlock;
+	goto out;
 
 cleanup_need_write:
 	ovl_start_write(c->dentry);
-- 
2.49.0



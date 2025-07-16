Return-Path: <linux-fsdevel+bounces-55053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B6AB06AC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37C8189F70B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E519E819;
	Wed, 16 Jul 2025 00:47:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDCD1E86E;
	Wed, 16 Jul 2025 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626856; cv=none; b=Zn+hJEjtwFmnJQj+FejrR06Z9TY1kl1JInreG01bDI6h8AOJtcX5xggLtKdjqNCGucMXtxh97l/Wd3Zitsc7lya3Knhh9vTinl+aq/cOLH5i7j5q9/LzMvunnQIhj4A5kevry3VcDAMN4TEKx3NfxuN7E139/UEwD71Ed8HwuwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626856; c=relaxed/simple;
	bh=j85Li3h6qqsa3aZqDTb7O4xJQ7+oWW62CkVwVmsURZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgwMjLhhu5gfvVMLMkS/G3D/fHv1h9fxoN/1wuUYcodKvqfm/e7C4wb3a7zK2oTB2WnHPwNvRqzCC1gjCgj45Dp0ci0RMPBc8pw+Pi7M7PhN8hNZuxbrfvN1pCTLcUPzCt1PJ/Y5wOuJ7E7dhe6AkFSgzYRexxv1Ud0jIG99zho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ1-002AAh-L4;
	Wed, 16 Jul 2025 00:47:33 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 06/21] ovl: narrow locking in ovl_clear_empty()
Date: Wed, 16 Jul 2025 10:44:17 +1000
Message-ID: <20250716004725.1206467-7-neil@brown.name>
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

Drop the locks immediately after rename, and use a separate lock for
cleanup.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Note that ovl_cleanup_whiteouts() operates on "upper", a child of
"upperdir" and does not require upperdir or workdir to be locked.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 1a146a71993a..540b67f5cdf5 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -353,7 +353,6 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
-	struct inode *wdir = workdir->d_inode;
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
 	struct path upperpath;
 	struct dentry *upper;
@@ -399,12 +398,12 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 		goto out_cleanup;
 
 	err = ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, RENAME_EXCHANGE);
+	unlock_rename(workdir, upperdir);
 	if (err)
-		goto out_cleanup;
+		goto out_cleanup_unlocked;
 
 	ovl_cleanup_whiteouts(ofs, upper, list);
-	ovl_cleanup(ofs, wdir, upper);
-	unlock_rename(workdir, upperdir);
+	ovl_cleanup_unlocked(ofs, workdir, upper);
 
 	/* dentry's upper doesn't match now, get rid of it */
 	d_drop(dentry);
-- 
2.49.0



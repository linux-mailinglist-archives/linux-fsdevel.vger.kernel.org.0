Return-Path: <linux-fsdevel+bounces-52821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155B4AE72D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3AF3A5D6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AC425C70F;
	Tue, 24 Jun 2025 23:07:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915025A354;
	Tue, 24 Jun 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806438; cv=none; b=XjLcsuCnMJ2mWws9Nn6+2fkRL+j8vdjueQ3t339Y5SgAhpVLA4gxbRcoblwEnTqqXB1slM92tqHvZnZ+mNVyviuTbc7lvIiC4te0vc4YQv9PzUS98Cr/ZTXR8g89XGC7zH9/4x6gsrwKT6QDZnegnT+ToJcy84FZpYtZ8XK4OqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806438; c=relaxed/simple;
	bh=zha/qW/hwDFKnYoahgAzvFF0joclr/Q7VjEk/MGvtro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxPbcaDcf0Ya2rmbUvzlebN+vnNJaXKHagW4o6Y8nTDJG2CGI2jnCoETnQ42czo2W3qgPtm95BRLiHMeP7eN46nUMt21skIA6Giri8Bc1UPAnniWCeBbkj7K0K46MBjT03rnA2V/Augpf76ynszu/ei17Yitpf8J34SpePPbxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjS-0045cQ-Qk;
	Tue, 24 Jun 2025 23:07:14 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/12] ovl: narrow locking in ovl_clear_empty()
Date: Wed, 25 Jun 2025 08:55:01 +1000
Message-ID: <20250624230636.3233059-6-neil@brown.name>
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

Drop the locks immediately after rename, and use a separate lock for
cleanup.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Note that ovl_cleanup_whiteouts() operates on "upper", a child of
"upperdir" and does not require upperdir or workdir to be locked.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 2d67704d641e..e3ea7d02219f 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -355,7 +355,6 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
-	struct inode *wdir = workdir->d_inode;
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
 	struct inode *udir = upperdir->d_inode;
 	struct path upperpath;
@@ -408,10 +407,10 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	err = ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, RENAME_EXCHANGE);
 	if (err)
 		goto out_cleanup;
+	unlock_rename(workdir, upperdir);
 
 	ovl_cleanup_whiteouts(ofs, upper, list);
-	ovl_cleanup(ofs, wdir, upper);
-	unlock_rename(workdir, upperdir);
+	ovl_cleanup_unlocked(ofs, workdir, upper);
 
 	/* dentry's upper doesn't match now, get rid of it */
 	d_drop(dentry);
-- 
2.49.0



Return-Path: <linux-fsdevel+bounces-52829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15387AE72E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5353BD60E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5E25D1FB;
	Tue, 24 Jun 2025 23:07:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380C25C83D;
	Tue, 24 Jun 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806441; cv=none; b=QQzI9QljVuJtgd4mA0iKRFiQEaWx0NpKowrdjLeeZdFdWXcsbmabEia1i+5i3mfTl6eFW4rgpvxpywwr/O0lyCBTJxeagRelZg1HsKGpaYvzzZsZiqN48X6PI0nfT/qETBRWKoO3aELbDyG7w0rjrzv+vwDLLNp8LzRcgIcWR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806441; c=relaxed/simple;
	bh=L6DYbDMWtt3HCZGJnmpbP+5RMzjTs6HJOPFK3lzdQDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obCdbfrRBSIiWBgmrEJpO0wAtbKp2byH4FuYNHYxZqIFZYiI1VqrEVoxpvwN9xNTXjHyN2G5xBiE7xe+dOq18qv8vYKuLpZRGbpFpOt8EHG0QDlc2HCGp66vw3MKXQ1giEeCk710+/h3yPRnXchexZLdyrV+6VZUiLkQIj7qhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjW-0045cw-6e;
	Tue, 24 Jun 2025 23:07:18 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/12] ovl: change ovl_create_real() to receive dentry parent
Date: Wed, 25 Jun 2025 08:55:07 +1000
Message-ID: <20250624230636.3233059-12-neil@brown.name>
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

Instead of passing an inode *dir, pass a dentry *parent.  This makes the
calling slightly cleaner.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c       | 7 ++++---
 fs/overlayfs/overlayfs.h | 2 +-
 fs/overlayfs/super.c     | 3 +--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 78b0d956b0ac..9a43ab23cf01 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -164,9 +164,10 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	goto out;
 }
 
-struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
+struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 			       struct dentry *newdentry, struct ovl_cattr *attr)
 {
+	struct inode *dir = parent->d_inode;
 	int err;
 
 	if (IS_ERR(newdentry))
@@ -227,7 +228,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 {
 	struct dentry *ret;
 	inode_lock(workdir->d_inode);
-	ret = ovl_create_real(ofs, d_inode(workdir),
+	ret = ovl_create_real(ofs, workdir,
 			      ovl_lookup_temp(ofs, workdir), attr);
 	inode_unlock(workdir->d_inode);
 	return ret;
@@ -333,7 +334,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	int err;
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
-	newdentry = ovl_create_real(ofs, udir,
+	newdentry = ovl_create_real(ofs, upperdir,
 				    ovl_lookup_upper(ofs, dentry->d_name.name,
 						     upperdir, dentry->d_name.len),
 				    attr);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 25378b81251e..3d89e1c8d565 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -849,7 +849,7 @@ struct ovl_cattr {
 #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
 
 struct dentry *ovl_create_real(struct ovl_fs *ofs,
-			       struct inode *dir, struct dentry *newdentry,
+			       struct dentry *parent, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
 int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *dentry);
 int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, struct dentry *dentry);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 8331667b8101..1ba1bffc4547 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -617,8 +617,7 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
 	child = ovl_lookup_upper(ofs, name, parent, len);
 	if (!IS_ERR(child) && !child->d_inode)
-		child = ovl_create_real(ofs, parent->d_inode, child,
-					OVL_CATTR(mode));
+		child = ovl_create_real(ofs, parent, child, OVL_CATTR(mode));
 	inode_unlock(parent->d_inode);
 	dput(parent);
 
-- 
2.49.0



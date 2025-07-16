Return-Path: <linux-fsdevel+bounces-55067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C4B06AE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51155178CA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45EF1CAA92;
	Wed, 16 Jul 2025 00:47:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9636189919;
	Wed, 16 Jul 2025 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626867; cv=none; b=bPEHZad/P4IH3Q8gBwBVnpfARM3pv4UigS7gIp662FgRBwcMw0nD0FGZ/7WpUOVQvZjkNfO/UYyVwzNCY8W3u6Cp4XHXi7HTr1ljJoT4xa6d9jlwc7AoZBTmfuPVa1BGK0YaV9sI3fhDng4Sl233NAJuasxjGh/b8czEpM4tLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626867; c=relaxed/simple;
	bh=CBaJASkDX1FXFk5ilior80qOVvQEaZA2MePep8XH0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npYHYjSRnUofSEpnOQO6i4RDo/M4FzshQZORQFOUjTujaKc+gce/e7lcMWSUOeXH8WZKGuuCblcTc/P8ZEugX8sVDGou6W0Lgu8fb6a1OR+deCatuqdNfUQfk6KH5yUrEwV1/j0WWCMpjZ6X3YbqhZWKh5SHfPY5dJuEoE4bV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJC-002AC8-K3;
	Wed, 16 Jul 2025 00:47:44 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 20/21] ovl: change ovl_create_real() to receive dentry parent
Date: Wed, 16 Jul 2025 10:44:31 +1000
Message-ID: <20250716004725.1206467-21-neil@brown.name>
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

Instead of passing an inode *dir, pass a dentry *parent.  This makes the
calling slightly cleaner.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c       | 7 ++++---
 fs/overlayfs/overlayfs.h | 2 +-
 fs/overlayfs/super.c     | 3 +--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 7eb806a4e5f8..dedf89546e5f 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -160,9 +160,10 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	goto out;
 }
 
-struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
+struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 			       struct dentry *newdentry, struct ovl_cattr *attr)
 {
+	struct inode *dir = parent->d_inode;
 	int err;
 
 	if (IS_ERR(newdentry))
@@ -223,7 +224,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 {
 	struct dentry *ret;
 	inode_lock(workdir->d_inode);
-	ret = ovl_create_real(ofs, d_inode(workdir),
+	ret = ovl_create_real(ofs, workdir,
 			      ovl_lookup_temp(ofs, workdir), attr);
 	inode_unlock(workdir->d_inode);
 	return ret;
@@ -329,7 +330,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	int err;
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
-	newdentry = ovl_create_real(ofs, udir,
+	newdentry = ovl_create_real(ofs, upperdir,
 				    ovl_lookup_upper(ofs, dentry->d_name.name,
 						     upperdir, dentry->d_name.len),
 				    attr);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f6023442a45c..b1e31e060157 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -855,7 +855,7 @@ struct ovl_cattr {
 #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
 
 struct dentry *ovl_create_real(struct ovl_fs *ofs,
-			       struct inode *dir, struct dentry *newdentry,
+			       struct dentry *parent, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
 int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *dentry);
 int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, struct dentry *dentry);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 0d765aa66bd2..9fd0b3acd1a4 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -622,8 +622,7 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
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



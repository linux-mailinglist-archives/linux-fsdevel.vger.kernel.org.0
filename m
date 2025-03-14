Return-Path: <linux-fsdevel+bounces-43989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28511A60822
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFA119C2BFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 04:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D57E14BF8F;
	Fri, 14 Mar 2025 04:57:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526C24B29;
	Fri, 14 Mar 2025 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741928232; cv=none; b=cy94x1UTNnZhEDbWp8oEIqNTiiPPqSNXslxCJ/qIFwUtxqXEmAYefJKIfocciiyw+OIWYbVbRgoqnZT2dzGY6UTYut9ITXRqqNxh9xHGEm+V0hWDOkiSHkkkerN6GMLQLglRL0hKZWwHqIqlWhLBeNgUI1DdK2032KkJcfdgb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741928232; c=relaxed/simple;
	bh=f3+gpEKJAqYzbzqvVJPsD4a2ui2KwmtT1yKX34lie0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHxh5Tn+kvShOv2SdCpqgyPS3LFeuU4JMozO6IyxKfMsO6sxaEGJE/m9Gcjuj0p+BarQCTCiJdavq4p03LIOBoM7+yJgFhWqHHw3ELZgkVCO4QqDl6ATFjdrrBlFiVXUKGz9I378opAP3o4bXqZjMO0FA20i7Fu/ol+tgjZqwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tsx6Z-00E3vr-7M;
	Fri, 14 Mar 2025 04:57:07 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/8] cachefiles: use correct mnt_idmap
Date: Fri, 14 Mar 2025 11:34:11 +1100
Message-ID: <20250314045655.603377-6-neil@brown.name>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314045655.603377-1-neil@brown.name>
References: <20250314045655.603377-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If cachesfiles is configured on a mount that is idmapped, it needs to
use the idmap from the mount point.  This patch changes all occurrences
of nop_mnt_idmap in cachefiles to file the correct mnt_idmap.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/interface.c |  6 ++++--
 fs/cachefiles/namei.c     | 14 ++++++++------
 fs/cachefiles/xattr.c     | 12 +++++++-----
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 3e63cfe15874..b2b9867d8428 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -143,7 +143,8 @@ static int cachefiles_adjust_size(struct cachefiles_object *object)
 		newattrs.ia_size = oi_size & PAGE_MASK;
 		ret = cachefiles_inject_remove_error();
 		if (ret == 0)
-			ret = notify_change(&nop_mnt_idmap, file->f_path.dentry,
+			ret = notify_change(mnt_idmap(file->f_path.mnt),
+					    file->f_path.dentry,
 					    &newattrs, NULL);
 		if (ret < 0)
 			goto truncate_failed;
@@ -153,7 +154,8 @@ static int cachefiles_adjust_size(struct cachefiles_object *object)
 	newattrs.ia_size = ni_size;
 	ret = cachefiles_inject_write_error();
 	if (ret == 0)
-		ret = notify_change(&nop_mnt_idmap, file->f_path.dentry,
+		ret = notify_change(file_mnt_idmap(file),
+				    file->f_path.dentry,
 				    &newattrs, NULL);
 
 truncate_failed:
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index a440a2ff5d41..b156a0671a3d 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -130,7 +130,8 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 			goto mkdir_error;
 		subdir = ERR_PTR(cachefiles_inject_write_error());
 		if (!IS_ERR(subdir))
-			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
+			subdir = vfs_mkdir(mnt_idmap(cache->mnt), d_inode(dir),
+					   subdir, 0700);
 		ret = PTR_ERR(subdir);
 		if (IS_ERR(subdir)) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
@@ -247,7 +248,8 @@ static int cachefiles_unlink(struct cachefiles_cache *cache,
 
 	ret = cachefiles_inject_remove_error();
 	if (ret == 0) {
-		ret = vfs_unlink(&nop_mnt_idmap, d_backing_inode(dir), dentry, NULL);
+		ret = vfs_unlink(mnt_idmap(cache->mnt),
+				 d_backing_inode(dir), dentry, NULL);
 		if (ret == -EIO)
 			cachefiles_io_error(cache, "Unlink failed");
 	}
@@ -386,10 +388,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		cachefiles_io_error(cache, "Rename security error %d", ret);
 	} else {
 		struct renamedata rd = {
-			.old_mnt_idmap	= &nop_mnt_idmap,
+			.old_mnt_idmap	= mnt_idmap(cache->mnt),
 			.old_dir	= d_inode(dir),
 			.old_dentry	= rep,
-			.new_mnt_idmap	= &nop_mnt_idmap,
+			.new_mnt_idmap	= mnt_idmap(cache->mnt),
 			.new_dir	= d_inode(cache->graveyard),
 			.new_dentry	= grave,
 		};
@@ -455,7 +457,7 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 
 	ret = cachefiles_inject_write_error();
 	if (ret == 0) {
-		file = kernel_tmpfile_open(&nop_mnt_idmap, &parentpath,
+		file = kernel_tmpfile_open(mnt_idmap(cache->mnt), &parentpath,
 					   S_IFREG | 0600,
 					   O_RDWR | O_LARGEFILE | O_DIRECT,
 					   cache->cache_cred);
@@ -714,7 +716,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		ret = vfs_link(object->file->f_path.dentry, &nop_mnt_idmap,
+		ret = vfs_link(object->file->f_path.dentry, file_mnt_idmap(object->file),
 			       d_inode(fan), dentry, NULL);
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, d_inode(fan), ret,
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 52383b1d0ba6..a2ab9100ba74 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -67,7 +67,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 	if (ret == 0) {
 		ret = mnt_want_write_file(file);
 		if (ret == 0) {
-			ret = vfs_setxattr(&nop_mnt_idmap, dentry,
+			ret = vfs_setxattr(file_mnt_idmap(file), dentry,
 					   cachefiles_xattr_cache, buf,
 					   sizeof(struct cachefiles_xattr) + len, 0);
 			mnt_drop_write_file(file);
@@ -116,7 +116,8 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 
 	xlen = cachefiles_inject_read_error();
 	if (xlen == 0)
-		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, tlen);
+		xlen = vfs_getxattr(file_mnt_idmap(file), dentry,
+				    cachefiles_xattr_cache, buf, tlen);
 	if (xlen != tlen) {
 		if (xlen < 0) {
 			ret = xlen;
@@ -167,7 +168,7 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 	if (ret == 0) {
 		ret = mnt_want_write(cache->mnt);
 		if (ret == 0) {
-			ret = vfs_removexattr(&nop_mnt_idmap, dentry,
+			ret = vfs_removexattr(mnt_idmap(cache->mnt), dentry,
 					      cachefiles_xattr_cache);
 			mnt_drop_write(cache->mnt);
 		}
@@ -230,7 +231,7 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
 	if (ret == 0) {
 		ret = mnt_want_write(volume->cache->mnt);
 		if (ret == 0) {
-			ret = vfs_setxattr(&nop_mnt_idmap, dentry,
+			ret = vfs_setxattr(mnt_idmap(volume->cache->mnt), dentry,
 					   cachefiles_xattr_cache,
 					   buf, len, 0);
 			mnt_drop_write(volume->cache->mnt);
@@ -276,7 +277,8 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 
 	xlen = cachefiles_inject_read_error();
 	if (xlen == 0)
-		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, len);
+		xlen = vfs_getxattr(mnt_idmap(volume->cache->mnt),
+				    dentry, cachefiles_xattr_cache, buf, len);
 	if (xlen != len) {
 		if (xlen < 0) {
 			ret = xlen;
-- 
2.48.1



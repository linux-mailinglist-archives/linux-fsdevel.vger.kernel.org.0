Return-Path: <linux-fsdevel+bounces-60439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7975B46A99
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F401891C41
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5C22D23B9;
	Sat,  6 Sep 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NNWylpNZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380F52C0272
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149904; cv=none; b=NNMjkw/uXODfu4CnoXEEJH0XYTxncK9Iu5OLcLu7+EYfXZYr+zK/j8d5U5se4lpbREN33iKrl0WuaqAP5TU2F/wuzcSk4Jfa/mYnOpfAOu6dghc5kU7+mgaHfgGr8C42smuByrzdigW4Lye9OrePUE4dPV4wJjT3DLpHMmeOsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149904; c=relaxed/simple;
	bh=wwvD6CK1GabQIQtxjoxQT0BaJuUSmTFf04xJZJWfCUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8cjmI34WQB3vqMnGY2tZDkZtB1iBtG7LO63IGV8mit59R/z5QMDlHz3v69tAuiGxzl3KFxVdkFCSyQTFSVfWsK+Z3H/N6mTpFeh84WB2vq7xS4fN/hGe6YGtFiTB4CwHTzqOJHDU4om0wdCLbAB4vpO9YrNMWC/uY3uDpn2o3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NNWylpNZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kywNsXyddi471s6cGtt+xT1OZmlWRqq9YeFfbz+35ts=; b=NNWylpNZLVaSKxhJClefj8Q0+x
	TbL0SzffI8GnYRcUKi1iqSMB4PPSKJzcky7ljNT8a5UglRDN+zzRO/H+xGzs5lfWlCKRew43e/0hA
	/1nUdE8wzxLXh/5K7RkQx7FFOCkZjco4PRKDknho6TqTOZhDDpU0BPI66cG3qgsatMFtsfxeNNoni
	17y1KlwKjdqNwGAwmezmEsbKcg7yQMmTBmvqHXahAgmxyDy1aVky0I67EFKr98RexdWBUcl6LfdJa
	Xh9dSP4kulU07jrHg48N5+KzBgP7ZyxQAyKm677uXVWqn6BKskk3GhykrQZgvCc2EmYboabtaxwz6
	pC+wRXZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxR-00000000OvS-1vq1;
	Sat, 06 Sep 2025 09:11:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 21/21] configfs:get_target() - release path as soon as we grab configfs_item reference
Date: Sat,  6 Sep 2025 10:11:37 +0100
Message-ID: <20250906091137.95554-21-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and get rid of path argument - it turns into a local variable in get_target()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/symlink.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 69133ec1fac2..f3f79c67add5 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -114,26 +114,21 @@ static int create_link(struct config_item *parent_item,
 }
 
 
-static int get_target(const char *symname, struct path *path,
-		      struct config_item **target, struct super_block *sb)
+static int get_target(const char *symname, struct config_item **target,
+		      struct super_block *sb)
 {
+	struct path path __free(path_put) = {};
 	int ret;
 
-	ret = kern_path(symname, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, path);
-	if (!ret) {
-		if (path->dentry->d_sb == sb) {
-			*target = configfs_get_config_item(path->dentry);
-			if (!*target) {
-				ret = -ENOENT;
-				path_put(path);
-			}
-		} else {
-			ret = -EPERM;
-			path_put(path);
-		}
-	}
-
-	return ret;
+	ret = kern_path(symname, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &path);
+	if (ret)
+		return ret;
+	if (path.dentry->d_sb != sb)
+		return -EPERM;
+	*target = configfs_get_config_item(path.dentry);
+	if (!*target)
+		return -ENOENT;
+	return 0;
 }
 
 
@@ -141,7 +136,6 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, const char *symname)
 {
 	int ret;
-	struct path path;
 	struct configfs_dirent *sd;
 	struct config_item *parent_item;
 	struct config_item *target_item = NULL;
@@ -188,7 +182,7 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	 *  AV, a thoroughly annoyed bastard.
 	 */
 	inode_unlock(dir);
-	ret = get_target(symname, &path, &target_item, dentry->d_sb);
+	ret = get_target(symname, &target_item, dentry->d_sb);
 	inode_lock(dir);
 	if (ret)
 		goto out_put;
@@ -210,7 +204,6 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	config_item_put(target_item);
-	path_put(&path);
 
 out_put:
 	config_item_put(parent_item);
-- 
2.47.2



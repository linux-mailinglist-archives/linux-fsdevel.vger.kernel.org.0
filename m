Return-Path: <linux-fsdevel+bounces-62044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B157B82498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDE01B2827E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39094313280;
	Wed, 17 Sep 2025 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CV1RaaIm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E8312814;
	Wed, 17 Sep 2025 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151663; cv=none; b=iZuiF6+iZyrZM6e5Eejl3wklzT0JvkpLidFbg1D8/eYwkOhzA52BtuJ62EkFRYxLYKza75+1gjhai7MGs48pyT+DfuXCfNEzsPB2Y5CumejiOj8psOOgu40qiyZn+8iztb67C9n6jKdvxhPs+emaTYPoQwlYCGHesb3aLRoJ45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151663; c=relaxed/simple;
	bh=JlL5S9+Lg4aqvr66E3OJKay6lnBDSJMKAki4ugqoiGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArWMEfIcM+QufU+74D2gSWLeTQK3Gell5tcr3YWqSkRkl4PcL4b77fCzDUlzSumK2sBpt7+MzSJmoNWZHzvrvgcDjPreZImdp+WKLgLbAheDnuL5+HjEjEvcM1SPKTOCueFMVMScr/YlSTlK1UPYGc20+gALh8JGzTJMWE6y7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CV1RaaIm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+xhYV6cpYPuPdCCjGJXgiQNJTGtl0Ta+GIm/pXpIMp4=; b=CV1RaaIm24nBTZwNR4qC0YyWrK
	9QqVialrOtBlVi8OormtrzD19sLxZ6HX1sGbOIJi+fwWcV2jhkt2G/gDi3FB7AKzbonlH1owVUwIN
	p6Zkq/XnTF/ymu8axpPvtP8aU40wDAIQVcMjLdOZD9IccXUGbDnMlic4/+nWsOFYBlLMU0equgQUQ
	a13tz3YC9jmsWYNGaxDsUM30HcBkmOaZagsfmWR3p2HDhm7f9WlFiayc7DWaCcxnyVDZdJfDwU1m6
	Ie2QcIUlSuWdwN/ufe9DH29CScezDctFvY98qW8NY1wZppt09wBKciWst9H7Q2AaFOV6FjO+01OWf
	3LrFOtFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz1Yn-0000000Aj5V-0E3L;
	Wed, 17 Sep 2025 23:27:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev,
	miklos@szeredi.hu,
	agruenba@redhat.com,
	linux-nfs@vger.kernel.org,
	hansg@kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 2/9] 9p: simplify v9fs_vfs_atomic_open()
Date: Thu, 18 Sep 2025 00:27:29 +0100
Message-ID: <20250917232736.2556586-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
References: <20250917232416.GG39973@ZenIV>
 <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

if v9fs_vfs_lookup() returns a preexisting alias, it is guaranteed to be
positive.  IOW, in that case we will immediately return finish_no_open(),
leaving only the case res == NULL past that point.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/9p/vfs_inode.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 399d455d50d6..d0c77ec31b1d 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -768,22 +768,18 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct v9fs_inode __maybe_unused *v9inode;
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
-	struct dentry *res = NULL;
 	struct inode *inode;
 	int p9_omode;
 
 	if (d_in_lookup(dentry)) {
-		res = v9fs_vfs_lookup(dir, dentry, 0);
-		if (IS_ERR(res))
-			return PTR_ERR(res);
-
-		if (res)
-			dentry = res;
+		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
+		if (res || d_really_is_positive(dentry))
+			return finish_no_open(file, res);
 	}
 
 	/* Only creates */
-	if (!(flags & O_CREAT) || d_really_is_positive(dentry))
-		return finish_no_open(file, res);
+	if (!(flags & O_CREAT))
+		return finish_no_open(file, NULL);
 
 	v9ses = v9fs_inode2v9ses(dir);
 	perm = unixmode2p9mode(v9ses, mode);
@@ -795,17 +791,17 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
 	}
 	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, p9_omode);
-	if (IS_ERR(fid)) {
-		err = PTR_ERR(fid);
-		goto error;
-	}
+	if (IS_ERR(fid))
+		return PTR_ERR(fid);
 
 	v9fs_invalidate_inode_attr(dir);
 	inode = d_inode(dentry);
 	v9inode = V9FS_I(inode);
 	err = finish_open(file, dentry, generic_file_open);
-	if (err)
-		goto error;
+	if (unlikely(err)) {
+		p9_fid_put(fid);
+		return err;
+	}
 
 	file->private_data = fid;
 #ifdef CONFIG_9P_FSCACHE
@@ -818,13 +814,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	v9fs_open_fid_add(inode, &fid);
 
 	file->f_mode |= FMODE_CREATED;
-out:
-	dput(res);
-	return err;
-
-error:
-	p9_fid_put(fid);
-	goto out;
+	return 0;
 }
 
 /**
-- 
2.47.3



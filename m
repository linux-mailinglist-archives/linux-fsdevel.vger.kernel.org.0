Return-Path: <linux-fsdevel+bounces-16254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1689A8EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 07:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDE71C213FA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 05:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5F1BC46;
	Sat,  6 Apr 2024 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cCOX/PQJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E3139F
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379677; cv=none; b=brYnevNilytlfilQ3HHrudUfNbisSCUnR3sD5SuPoYnf21l+3eV6YvF+XZ8N0PeXOLShtbjp72b0IN/bfpSEBsSmmDfWo2iW28KFe8NXq4r7bBqGlq5ufZZIiFh4gSrjAm73Gikipk4Ux8JWr6IJ/DnoB9Gwtw/KJxxMzJb7nAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379677; c=relaxed/simple;
	bh=sR3FMMgeHqwRof0Y7TCHibbygr3AoezAIT7SG19ZUX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGgG/yer+3+v7T76hzUqjap8AwqAUmsyexXEtv8friOELveyNCAdEdx7Uhiw2zNblsCGhWNB+219zDo1Ya6Vfu5leJUgkhtNQLL1PAGDmRYEBGSfbPzHG69xr/yvj8BSmpPfTJTSnwnY1LiY2lbM8w2YakpP2nQBlARbClwJ6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cCOX/PQJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FDkf2n0aRhxltmMyBYVa5Vbhi+a/sJrmrvpc/3Ivn90=; b=cCOX/PQJYaSq7PPyWUVhRN7aRw
	FzF3Q1pNgqhIi0/XTQEzbRN0M8P2ZH+Qwrlzw7FyetLnAkBR+ac+QEDSRjCTYY0sIubDraKBebqWz
	3g2VGNkL/nkKpKarBaNVhB0NhA4X5MZW9uTYQg+Ae8h268OF7ctAqqdpGUBCeWj/0/RFIOa0Uy+PE
	f0Arq+jvjFuTe8rpE/PCuRHJnjXASsxYoPYqmA+BqxbIEpVRpx25M1BUgPHA1nWZe6dNIetg17e2l
	8A/Rz/AbSj9RUr08aqhWf6c71uOL/9Pu0tzIc+dIb79dk1FPKjeY0IJoh0VUsT9hsCILcXYuBtNNd
	qU5rlG2A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsyAz-006quK-2n;
	Sat, 06 Apr 2024 05:01:14 +0000
Date: Sat, 6 Apr 2024 06:01:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian@brauner.io>
Subject: [PATCH 4/6] kernel_file_open(): get rid of inode argument
Message-ID: <20240406050113.GD1632446@ZenIV>
References: <20240406045622.GY538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406045622.GY538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

always equal to ->dentry->d_inode of the path argument these
days.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cachefiles/namei.c | 3 +--
 fs/open.c             | 5 ++---
 fs/overlayfs/util.c   | 2 +-
 include/linux/fs.h    | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7ade836beb58..f53977169db4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -563,8 +563,7 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	 */
 	path.mnt = cache->mnt;
 	path.dentry = dentry;
-	file = kernel_file_open(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				d_backing_inode(dentry), cache->cache_cred);
+	file = kernel_file_open(&path, O_RDWR | O_LARGEFILE | O_DIRECT, cache->cache_cred);
 	if (IS_ERR(file)) {
 		trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
 					   PTR_ERR(file),
diff --git a/fs/open.c b/fs/open.c
index ee8460c83c77..ec287ac67e7f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1155,7 +1155,6 @@ EXPORT_SYMBOL(dentry_create);
  * kernel_file_open - open a file for kernel internal use
  * @path:	path of the file to open
  * @flags:	open flags
- * @inode:	the inode
  * @cred:	credentials for open
  *
  * Open a file for use by in-kernel consumers. The file is not accounted
@@ -1165,7 +1164,7 @@ EXPORT_SYMBOL(dentry_create);
  * Return: Opened file on success, an error pointer on failure.
  */
 struct file *kernel_file_open(const struct path *path, int flags,
-				struct inode *inode, const struct cred *cred)
+				const struct cred *cred)
 {
 	struct file *f;
 	int error;
@@ -1175,7 +1174,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 		return f;
 
 	f->f_path = *path;
-	error = do_dentry_open(f, inode, NULL);
+	error = do_dentry_open(f, d_inode(path->dentry), NULL);
 	if (error) {
 		fput(f);
 		f = ERR_PTR(error);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index d285d1d7baad..edc9216f6e27 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1376,7 +1376,7 @@ int ovl_ensure_verity_loaded(struct path *datapath)
 		 * If this inode was not yet opened, the verity info hasn't been
 		 * loaded yet, so we need to do that here to force it into memory.
 		 */
-		filp = kernel_file_open(datapath, O_RDONLY, inode, current_cred());
+		filp = kernel_file_open(datapath, O_RDONLY, current_cred());
 		if (IS_ERR(filp))
 			return PTR_ERR(filp);
 		fput(filp);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00fc429b0af0..143e967a3af2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1906,7 +1906,7 @@ struct file *kernel_tmpfile_open(struct mnt_idmap *idmap,
 				 umode_t mode, int open_flag,
 				 const struct cred *cred);
 struct file *kernel_file_open(const struct path *path, int flags,
-			      struct inode *inode, const struct cred *cred);
+			      const struct cred *cred);
 
 int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
-- 
2.39.2



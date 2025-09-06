Return-Path: <linux-fsdevel+bounces-60442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2FAB46AA2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1023A7195
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DB2D7380;
	Sat,  6 Sep 2025 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mDGqI8cS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE082046BA
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757150102; cv=none; b=G7Ao0wPa4UDzswhTe7hWexGa5cOG0l7wHO2WJ+z6L6ufMi1HtkKCbu4vn8FNN02mkEKZFeiQRi93MBquMa2oQbnmOs/sN9vEfJKOMsgTgQV6ABqcwt0CwHJj7K2IYiUM72QVLR4qMfisnvasMzKfHuNh2/J2ViOM6303SN5T0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757150102; c=relaxed/simple;
	bh=AycPsZYENKTnEI7yRM9fi3/JUK84ELbtKnyEZNSudlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZb4rIQ+WpUEkwlEDNh2R1alX987N38tEF7FfNGRfkR0d4u4LSP7LKh0mWf1VPUIVJI7ZQTpxRaWYhhkh8GQuNUeO/sX4KyPXu7qMBLq/VqJi6VwxIeN4Oyscarwx4nNzbd3Gjy11CGOVrw2bRiIzwXArgfRMsMiMHvS8Ii/COQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mDGqI8cS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vt2E03bwlMp/4VtLa/M+Dc4pdQcJKaMCbI8prniHq7U=; b=mDGqI8cS/rLHQNFlekbUrJhnBB
	7/CoCMcUm7v1waE8k6mComKw94bwoJFuKPJdNrXQ9Px4bkuMoUvk+XYn/SfV9VQ/pv2/uFjfg/StN
	ZSzhDRZeIZoEoBL7Kvp6keat4SekPfCOZdesPIm5j1naHeBYBOIfiXCd+F2mWnV11QSG2GYmI+91I
	9dfcOrAJ1IC0LVR8ICMmtU2XaX3+COkiDzeNZzfdK8k7tQ6P9lKlzjvchUFwOI42+dAlfvztFVmxa
	MqinNZ/jxU0WkIimjDNceHdxInvJIfQBnOeIL5qdL0zzibbnrjILVUbDhTKFpJwEyPWqazqYRGLGq
	ZAycBhmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uup0c-00000000RWD-3TFe;
	Sat, 06 Sep 2025 09:14:58 +0000
Date: Sat, 6 Sep 2025 10:14:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	John Johansen <john@apparmor.net>
Subject: [PATCH 2/2] Have cc(1) catch attempts to modify ->f_path
Message-ID: <20250906091458.GC31600@ZenIV>
References: <20250906090738.GA31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906090738.GA31600@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[last one in #work.f_path, following the merge with #work.mount and #work.path]

There are very few places that have cause to do that - all in core
VFS now, and all done to files that are not yet opened (or visible
to anybody else, for that matter).

Let's turn f_path into a union of struct path __f_path and const
struct path f_path.  It's C, not C++ - 6.5.2.3[4] in C99 and
later explicitly allows that kind of type-punning.

That way any attempts to bypass these checks will be either very
easy to catch, or (if the bastards get sufficiently creative to
make it hard to spot with grep alone) very clearly malicious -
and still catchable with a bit of instrumentation for sparse.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/file_table.c b/fs/file_table.c
index 85b53e39138d..b223d873e48b 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -171,7 +171,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	 * the respective member when opening the file.
 	 */
 	mutex_init(&f->f_pos_lock);
-	memset(&f->f_path, 0, sizeof(f->f_path));
+	memset(&f->__f_path, 0, sizeof(f->f_path));
 	memset(&f->f_ra, 0, sizeof(f->f_ra));
 
 	f->f_flags	= flags;
@@ -319,7 +319,7 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 static void file_init_path(struct file *file, const struct path *path,
 			   const struct file_operations *fop)
 {
-	file->f_path = *path;
+	file->__f_path = *path;
 	file->f_inode = path->dentry->d_inode;
 	file->f_mapping = path->dentry->d_inode->i_mapping;
 	file->f_wb_err = filemap_sample_wb_err(file->f_mapping);
diff --git a/fs/namei.c b/fs/namei.c
index 3eb0408e3400..ba8bf73d2f9c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3563,8 +3563,8 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 	if (nd->flags & LOOKUP_DIRECTORY)
 		open_flag |= O_DIRECTORY;
 
-	file->f_path.dentry = DENTRY_NOT_SET;
-	file->f_path.mnt = nd->path.mnt;
+	file->__f_path.dentry = DENTRY_NOT_SET;
+	file->__f_path.mnt = nd->path.mnt;
 	error = dir->i_op->atomic_open(dir, dentry, file,
 				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
@@ -3932,8 +3932,8 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 	child = d_alloc(parentpath->dentry, &slash_name);
 	if (unlikely(!child))
 		return -ENOMEM;
-	file->f_path.mnt = parentpath->mnt;
-	file->f_path.dentry = child;
+	file->__f_path.mnt = parentpath->mnt;
+	file->__f_path.dentry = child;
 	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
 	error = dir->i_op->tmpfile(idmap, dir, file, mode);
 	dput(child);
diff --git a/fs/open.c b/fs/open.c
index 9655158c3885..f4bdf7693530 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1022,8 +1022,8 @@ static int do_dentry_open(struct file *f,
 	put_file_access(f);
 cleanup_file:
 	path_put(&f->f_path);
-	f->f_path.mnt = NULL;
-	f->f_path.dentry = NULL;
+	f->__f_path.mnt = NULL;
+	f->__f_path.dentry = NULL;
 	f->f_inode = NULL;
 	return error;
 }
@@ -1050,7 +1050,7 @@ int finish_open(struct file *file, struct dentry *dentry,
 {
 	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 
-	file->f_path.dentry = dentry;
+	file->__f_path.dentry = dentry;
 	return do_dentry_open(file, open);
 }
 EXPORT_SYMBOL(finish_open);
@@ -1071,7 +1071,7 @@ EXPORT_SYMBOL(finish_open);
  */
 int finish_no_open(struct file *file, struct dentry *dentry)
 {
-	file->f_path.dentry = dentry;
+	file->__f_path.dentry = dentry;
 	return 0;
 }
 EXPORT_SYMBOL(finish_no_open);
@@ -1091,7 +1091,7 @@ int vfs_open(const struct path *path, struct file *file)
 {
 	int ret;
 
-	file->f_path = *path;
+	file->__f_path = *path;
 	ret = do_dentry_open(file, NULL);
 	if (!ret) {
 		/*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index af514fae4e2d..7fe4831b7663 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1107,7 +1107,10 @@ struct file {
 	const struct cred		*f_cred;
 	struct fown_struct		*f_owner;
 	/* --- cacheline 1 boundary (64 bytes) --- */
-	struct path			f_path;
+	union {
+		const struct path	f_path;
+		struct path		__f_path;
+	};
 	union {
 		/* regular files (with FMODE_ATOMIC_POS) and directories */
 		struct mutex		f_pos_lock;


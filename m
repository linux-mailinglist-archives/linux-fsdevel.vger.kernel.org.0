Return-Path: <linux-fsdevel+bounces-26597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C685F95A908
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B6E1C22A48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB946FCC;
	Thu, 22 Aug 2024 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Nmz14YyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBAE6FB6;
	Thu, 22 Aug 2024 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287312; cv=none; b=JjZfrRbzjGBFGiEOQNxUWqzgxgtwz+NK7tLIafYv6GmFMa3Qqc4hvdIWFXzz81uBOJpEkxwEhqH8RFKpURWP0u0WtUxemeOiAiGgBCzeOthQDhBKrnC7iDHcfWkDY15zxmXCKT+zHgWDadVBxLdo0D2XMKfQQIhAVi7oBMT9AjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287312; c=relaxed/simple;
	bh=OWIaCLCw+YDjM1iGQfQB/ATG874p/QQ0AQi/DMMrKyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/E79+KTmoXxZGTRMCIKXOCeK11WkQOnYf1zERig7rZ1dEgAX+4AbGKYdS5ky/T2vKXX1eTuPtfd7x1VbpDk/Hu7kwnmuXIJ1hJ1Pk9FZ+1tRpCyAMz/nW8OkF1GDSiESqxirhjoDpqkxROOP+ry38Ax1qOTfwIA8WzkYt3dW/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Nmz14YyN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jOvJz6QgpnGbqa1CWybFI8tgiz0e3Wr6osoyeSb2piY=; b=Nmz14YyN0Xy8a1TY/HjLTuxBZg
	sFTvX+++4Kxacq1fenTkyDHpSl+WAghhBp8b9PjyzXNwC4+HSTBFdYPKZPnBayfUCYEtGYjMuNSgI
	p1nqDxNlHZXDA42nQBKuWkAjePcIWKsPusp8G1mhqOzVxFCvCEvhy/Zo4A/9zOCtnymXJAh6Csww1
	HCy9c1XtXK0g3otUdcxyNYEXZwh4N6diAnM4T15gXeqP09C42UPLwe6B3gpo3dlfKinPQsOFhaRi6
	H72VUVXIHPWdNbuor9/ErFEMObBPPOVx1RYG90zEiDtmjZrOmPyxJKcCJT2fOO8ATClHL01SjC5e+
	pXvCWnPA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvtd-00000003wRQ-3JY9;
	Thu, 22 Aug 2024 00:41:49 +0000
Date: Thu, 22 Aug 2024 01:41:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] avoid extra path_get/path_put cycle in path_openat()
Message-ID: <20240822004149.GR504335@ZenIV>
References: <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
 <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV>
 <20240807203814.GA5334@ZenIV>
 <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com>
 <20240822003359.GO504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822003359.GO504335@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Once we'd opened the file, nd->path and file->f_path have the
same contents.  Rather than having both pinned and nd->path
dropped by terminate_walk(), let's have them share the
references from the moment when FMODE_OPENED is set and
clear nd->path just before the terminate_walk() in such case.

To do that, we
	* add a variant of vfs_open() that does *not* do conditional
path_get() (vfs_open_borrow()); use it in do_open().
	* don't grab f->f_path.mnt in finish_open() - only
f->f_path.dentry.  Have atomic_open() drop the child dentry
in FMODE_OPENED case and return f->path.dentry without grabbing it.
	* adjust vfs_tmpfile() for finish_open() change (it
is called from ->tmpfile() instances).
	* make do_o_path() use vfs_open_borrow(), collapse path_put()
there with the conditional path_get() we would've get in vfs_open().
	* in FMODE_OPENED case clear nd->path before calling
terminate_walk().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h |  1 +
 fs/namei.c    | 22 ++++++++++++++--------
 fs/open.c     | 19 ++++++++++++++++++-
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index cdd73209eecb..11834829cc3f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -194,6 +194,7 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
 int chown_common(const struct path *path, uid_t user, gid_t group);
 extern int vfs_open(const struct path *, struct file *);
+extern int vfs_open_borrow(const struct path *, struct file *);
 
 /*
  * inode.c
diff --git a/fs/namei.c b/fs/namei.c
index 5512cb10fa89..e02160460422 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3443,10 +3443,8 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 	d_lookup_done(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
-			if (unlikely(dentry != file->f_path.dentry)) {
-				dput(dentry);
-				dentry = dget(file->f_path.dentry);
-			}
+			dput(dentry);
+			dentry = file->f_path.dentry;
 		} else if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
 			error = -EIO;
 		} else {
@@ -3724,7 +3722,7 @@ static int do_open(struct nameidata *nd,
 	}
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
-		error = vfs_open(&nd->path, file);
+		error = vfs_open_borrow(&nd->path, file);
 	if (!error)
 		error = security_file_post_open(file, op->acc_mode);
 	if (!error && do_truncate)
@@ -3777,8 +3775,10 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
 	error = dir->i_op->tmpfile(idmap, dir, file, mode);
 	dput(child);
-	if (file->f_mode & FMODE_OPENED)
+	if (file->f_mode & FMODE_OPENED) {
+		mntget(file->f_path.mnt);
 		fsnotify_open(file);
+	}
 	if (error)
 		return error;
 	/* Don't check for other permissions, the inode was just created */
@@ -3857,8 +3857,9 @@ static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 	int error = path_lookupat(nd, flags, &path);
 	if (!error) {
 		audit_inode(nd->name, path.dentry, 0);
-		error = vfs_open(&path, file);
-		path_put(&path);
+		error = vfs_open_borrow(&path, file);
+		if (!(file->f_mode & FMODE_OPENED))
+			path_put(&path);
 	}
 	return error;
 }
@@ -3884,6 +3885,11 @@ static struct file *path_openat(struct nameidata *nd,
 			;
 		if (!error)
 			error = do_open(nd, file, op);
+		if (file->f_mode & FMODE_OPENED) {
+			// borrowed into file->f_path, transfer it there
+			nd->path.mnt = NULL;
+			nd->path.dentry = NULL;
+		}
 		terminate_walk(nd);
 	}
 	if (likely(!error)) {
diff --git a/fs/open.c b/fs/open.c
index 0ec2e9a33856..f9988427fb97 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1046,7 +1046,7 @@ int finish_open(struct file *file, struct dentry *dentry,
 	file->f_path.dentry = dentry;
 	err = do_dentry_open(file, open);
 	if (file->f_mode & FMODE_OPENED)
-		path_get(&file->f_path);
+		dget(&file->f_path.dentry);
 	return err;
 }
 EXPORT_SYMBOL(finish_open);
@@ -1102,6 +1102,23 @@ int vfs_open(const struct path *path, struct file *file)
 	return ret;
 }
 
+int vfs_open_borrow(const struct path *path, struct file *file)
+{
+	int ret;
+
+	file->f_path = *path;
+	ret = do_dentry_open(file, NULL);
+	if (!ret) {
+		/*
+		 * Once we return a file with FMODE_OPENED, __fput() will call
+		 * fsnotify_close(), so we need fsnotify_open() here for
+		 * symmetry.
+		 */
+		fsnotify_open(file);
+	}
+	return ret;
+}
+
 struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *cred)
 {
-- 
2.39.2



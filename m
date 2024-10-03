Return-Path: <linux-fsdevel+bounces-30920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E2A98FB03
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 01:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B421F23647
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 23:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374E41BFE01;
	Thu,  3 Oct 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UY9N6rrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2E142E9F
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999291; cv=none; b=XI9UwqJObcS9xiN65Irw3D8wmNh50CvU6yGu/EPxggQOiNmrEzXFgyYFXqqj0Lt1i2KMY7MV8QCNnQopDiyXL/meuisnde2C8LRB8L7oWH79GHfcur1XsPk6bE1/aQ5qnoOLers2log4x+TX3A9sR0XmHXoTi0YGfuNy/Y9zHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999291; c=relaxed/simple;
	bh=NRJYD9uswGeHIVdjrDI+aH5lLMTvQU2eX9DqTFod7nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYhXCoE6hdr7aUKyXBKqlsFTWQME93mMFw5mcfkqJZmZQmaWO8SNzZKiL4V+sWIAurb/cBTbx9PaJl6O1dJyeLj4wDWfiFb5W4e5xRCG6qrzBQrs1tbhUgcWNADKPJnVfXzYwc+g9MKamzCsnmNzJZhU68EDnzgwp2Kl+P8I3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UY9N6rrD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W3/WN7z4pERvn++L5j78x9US9E1bLG3DUk4YDqylDPw=; b=UY9N6rrDUXYJ02cDgqh2XjznZW
	Se1QB/eLy520oPLRjiIZxPcC3WKbplohPsiGMvsxn9N039XlsUBb9YLnr4f5bwQ9NKnFQlNJmjSOk
	1DhrxugMPdxmSVqDq3pmtyBEzQH7ypIubUihH/vDpIkLFxofg6Pq6sjCUUtxJgywlcdHGVtym6O+n
	2gQ6I239pXzYwNJjTm6PUBoHYkxbXT6HcMlOSbrTB4hjvsZplNWUnxsxJS61AtlLpEjgO6ae2Cx7W
	OWnPLz/bIlriunwF7XJCVFWCyNFEpWqcM1TraTMsw/VDOF6/COohYr4vVU3cKTJteg0lgoyoomi6g
	KwGnrEGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swVYG-00000000cUf-0w8O;
	Thu, 03 Oct 2024 23:48:08 +0000
Date: Fri, 4 Oct 2024 00:48:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 2/3] experimental: convert fs/overlayfs/file.c to CLASS(...)
Message-ID: <20241003234808.GC147780@ZenIV>
References: <20241003234534.GM4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003234534.GM4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

There are four places where we end up adding an extra scope
covering just the range from constructor to destructor;
not sure if that's the best way to handle that.

The functions in question are ovl_write_iter(), ovl_splice_write(),
ovl_fadvise() and ovl_copyfile().

I still don't like the way we have to deal with the scopes, but...
use of guard() for inode_lock()/inode_unlock() is a gutter too deep,
as far as I'm concerned.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/file.c | 72 ++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 43 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c711fa5d802f..a0ab981b13d9 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -131,6 +131,8 @@ static struct fderr ovl_real_fdget(const struct file *file)
 	return ovl_real_fdget_meta(file, false);
 }
 
+DEFINE_CLASS(fd_real, struct fderr, fdput(_T), ovl_real_fdget(file), struct file *file)
+
 static int ovl_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
@@ -173,7 +175,6 @@ static int ovl_release(struct inode *inode, struct file *file)
 static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
-	struct fderr real;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -189,7 +190,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 			return vfs_setpos(file, 0, 0);
 	}
 
-	real = ovl_real_fdget(file);
+	CLASS(fd_real, real)(file);
 	if (fd_empty(real))
 		return fd_err(real);
 
@@ -210,8 +211,6 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	file->f_pos = fd_file(real)->f_pos;
 	ovl_inode_unlock(inode);
 
-	fdput(real);
-
 	return ret;
 }
 
@@ -252,8 +251,6 @@ static void ovl_file_accessed(struct file *file)
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
-	struct fderr real;
-	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(file)->i_sb),
 		.user_file = file,
@@ -263,22 +260,18 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	real = ovl_real_fdget(file);
+	CLASS(fd_real, real)(file);
 	if (fd_empty(real))
 		return fd_err(real);
 
-	ret = backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
-				     &ctx);
-	fdput(real);
-
-	return ret;
+	return backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
+				      &ctx);
 }
 
 static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct fderr real;
 	ssize_t ret;
 	int ifl = iocb->ki_flags;
 	struct backing_file_ctx ctx = {
@@ -294,7 +287,9 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	real = ovl_real_fdget(file);
+	{
+
+	CLASS(fd_real, real)(file);
 	if (fd_empty(real)) {
 		ret = fd_err(real);
 		goto out_unlock;
@@ -309,7 +304,8 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 */
 	ifl &= ~IOCB_DIO_CALLER_COMP;
 	ret = backing_file_write_iter(fd_file(real), iter, iocb, ifl, &ctx);
-	fdput(real);
+
+	}
 
 out_unlock:
 	inode_unlock(inode);
@@ -321,22 +317,18 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 			       struct pipe_inode_info *pipe, size_t len,
 			       unsigned int flags)
 {
-	struct fderr real;
-	ssize_t ret;
+	CLASS(fd_real, real)(in);
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(in)->i_sb),
 		.user_file = in,
 		.accessed = ovl_file_accessed,
 	};
 
-	real = ovl_real_fdget(in);
 	if (fd_empty(real))
 		return fd_err(real);
 
-	ret = backing_file_splice_read(fd_file(real), ppos, pipe, len, flags, &ctx);
-	fdput(real);
-
-	return ret;
+	return backing_file_splice_read(fd_file(real), ppos, pipe, len, flags,
+					&ctx);
 }
 
 /*
@@ -350,7 +342,6 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
-	struct fderr real;
 	struct inode *inode = file_inode(out);
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
@@ -363,15 +354,17 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	real = ovl_real_fdget(out);
+	{
+
+	CLASS(fd_real, real)(out);
 	if (fd_empty(real)) {
 		ret = fd_err(real);
 		goto out_unlock;
 	}
 
 	ret = backing_file_splice_write(pipe, fd_file(real), ppos, len, flags, &ctx);
-	fdput(real);
 
+	}
 out_unlock:
 	inode_unlock(inode);
 
@@ -419,7 +412,6 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	struct fderr real;
 	const struct cred *old_cred;
 	int ret;
 
@@ -429,7 +421,9 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	ret = file_remove_privs(file);
 	if (ret)
 		goto out_unlock;
-	real = ovl_real_fdget(file);
+	{
+
+	CLASS(fd_real, real)(file);
 	if (fd_empty(real)) {
 		ret = fd_err(real);
 		goto out_unlock;
@@ -442,8 +436,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	/* Update size */
 	ovl_file_modified(file);
 
-	fdput(real);
-
+	}
 out_unlock:
 	inode_unlock(inode);
 
@@ -452,11 +445,10 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
-	struct fderr real;
+	CLASS(fd_real, real)(file);
 	const struct cred *old_cred;
 	int ret;
 
-	real = ovl_real_fdget(file);
 	if (fd_empty(real))
 		return fd_err(real);
 
@@ -464,8 +456,6 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 	ret = vfs_fadvise(fd_file(real), offset, len, advice);
 	revert_creds(old_cred);
 
-	fdput(real);
-
 	return ret;
 }
 
@@ -480,7 +470,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			    loff_t len, unsigned int flags, enum ovl_copyop op)
 {
 	struct inode *inode_out = file_inode(file_out);
-	struct fderr real_in, real_out;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -493,15 +482,16 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			goto out_unlock;
 	}
 
-	real_out = ovl_real_fdget(file_out);
+	{
+
+	CLASS(fd_real, real_out)(file_out);
 	if (fd_empty(real_out)) {
 		ret = fd_err(real_out);
 		goto out_unlock;
 	}
 
-	real_in = ovl_real_fdget(file_in);
+	CLASS(fd_real, real_in)(file_in);
 	if (fd_empty(real_in)) {
-		fdput(real_out);
 		ret = fd_err(real_in);
 		goto out_unlock;
 	}
@@ -529,8 +519,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	/* Update size */
 	ovl_file_modified(file_out);
 
-	fdput(real_in);
-	fdput(real_out);
+	}
 
 out_unlock:
 	inode_unlock(inode_out);
@@ -575,11 +564,10 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
-	struct fderr real;
+	CLASS(fd_real, real)(file);
 	const struct cred *old_cred;
 	int err = 0;
 
-	real = ovl_real_fdget(file);
 	if (fd_empty(real))
 		return fd_err(real);
 
@@ -588,8 +576,6 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 		err = fd_file(real)->f_op->flush(fd_file(real), id);
 		revert_creds(old_cred);
 	}
-	fdput(real);
-
 	return err;
 }
 
-- 
2.39.5



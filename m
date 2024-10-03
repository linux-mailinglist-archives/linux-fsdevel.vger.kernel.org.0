Return-Path: <linux-fsdevel+bounces-30921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1729E98FB04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 01:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30EE280F5B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 23:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67856161302;
	Thu,  3 Oct 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XyZzrsXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3595A12C473
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999338; cv=none; b=Rydisppr2+qvUqbXid4uM6JL2FouWWXtAWYJ3efo8AP1aG1oNNY2sX+jlvimWVMzKpEXjcIw8N1PDR2eLK52ypo4/M3DDOzonXJ0ia4h0+r6iQQX+Z9t9v+/NhurZ98YaFoo941LUsNL/ti86dIwn19oT+955xZw7ThxUCLKsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999338; c=relaxed/simple;
	bh=mnCnLepiABnI5/hCJJFpsILxm6zIYpYWy8KTiloXhUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn549vhiRygcUiLVP/iwEdkvIngynbJ9TfQVXWRzr4IJ79icoTbus0bDZ4eOUJUwQuLyHi/GzekWPROskLcJF0pgv/5XaFmwGtOyYyRJHt/EorGRZ6BdNcLNPC7WdVUyPVRaX2KA/9gDouPgiX/qshSaG921u8VEHkbxFBThHLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XyZzrsXG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FMbhm313/DB8mlBbUjriBTse9joqRo5uvOHvq4d3P/8=; b=XyZzrsXGLcAVwMj+Q0ReaGpAPe
	NPydWTRCxQ5W+Q3TkxT+kwk9FQmDfy8xwTr0qN8ul6HUV3V3iHmRgeOmOjxUO6v5U+sm2aJOm2gNg
	MaH41uwiv32/KNM299GlcXXQgcAPl6zvQ2KX7WhVQkkDj3KUdLrY4LhqmEfgcHqJ7ec7TnqZfVRHd
	42wlnP67d+/6MnHoq8NxTU8/0BFmuqKaIYVX3y3uzx1fp2NDq1lMxXVrCnVNUxaIQc+DPDaCUsFLz
	VtP8G3no23ylkmhmkO/jNeaw7UBEOjrEHvcy5DGvlCkvYqTyd7DyurXdqYxWSN802/k5gzc5lMWEM
	G4luxfZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swVZ1-00000000cW1-1fol;
	Thu, 03 Oct 2024 23:48:55 +0000
Date: Fri, 4 Oct 2024 00:48:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 3/3] [experimental] another way to deal with scopes for
 overlayfs real_fd-under-inode_lock
Message-ID: <20241003234855.GD147780@ZenIV>
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

[incremental to the previous]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/file.c | 113 +++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 58 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index a0ab981b13d9..e10a009d32e7 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -268,6 +268,15 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 				      &ctx);
 }
 
+static ssize_t ovl_write_locked(struct kiocb *iocb, struct iov_iter *iter, int ifl,
+				 struct backing_file_ctx *ctx)
+{
+	CLASS(fd_real, real)(ctx->user_file);
+	if (fd_empty(real))
+		return fd_err(real);
+	return backing_file_write_iter(fd_file(real), iter, iocb, ifl, ctx);
+}
+
 static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -287,14 +296,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	{
-
-	CLASS(fd_real, real)(file);
-	if (fd_empty(real)) {
-		ret = fd_err(real);
-		goto out_unlock;
-	}
-
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
 		ifl &= ~(IOCB_DSYNC | IOCB_SYNC);
 
@@ -303,11 +304,8 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * this property in case it is set by the issuer.
 	 */
 	ifl &= ~IOCB_DIO_CALLER_COMP;
-	ret = backing_file_write_iter(fd_file(real), iter, iocb, ifl, &ctx);
-
-	}
+	ret = ovl_write_locked(iocb, iter, ifl, &ctx);
 
-out_unlock:
 	inode_unlock(inode);
 
 	return ret;
@@ -331,6 +329,16 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 					&ctx);
 }
 
+static ssize_t ovl_splice_locked(struct pipe_inode_info *pipe, 
+				 loff_t *ppos, size_t len, unsigned int flags,
+				 struct backing_file_ctx *ctx)
+{
+	CLASS(fd_real, real)(ctx->user_file);
+	if (fd_empty(real))
+		return fd_err(real);
+	return backing_file_splice_write(pipe, fd_file(real), ppos, len, flags, ctx);
+}
+
 /*
  * Calling iter_file_splice_write() directly from overlay's f_op may deadlock
  * due to lock order inversion between pipe->mutex in iter_file_splice_write()
@@ -353,19 +361,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	inode_lock(inode);
 	/* Update mode */
 	ovl_copyattr(inode);
-
-	{
-
-	CLASS(fd_real, real)(out);
-	if (fd_empty(real)) {
-		ret = fd_err(real);
-		goto out_unlock;
-	}
-
-	ret = backing_file_splice_write(pipe, fd_file(real), ppos, len, flags, &ctx);
-
-	}
-out_unlock:
+	ret = ovl_splice_locked(pipe, ppos, len, flags, &ctx);
 	inode_unlock(inode);
 
 	return ret;
@@ -409,25 +405,14 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 	return backing_file_mmap(realfile, vma, &ctx);
 }
 
-static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+static long ovl_fallocate_locked(struct file *file, int mode, loff_t offset, loff_t len)
 {
-	struct inode *inode = file_inode(file);
 	const struct cred *old_cred;
 	int ret;
 
-	inode_lock(inode);
-	/* Update mode */
-	ovl_copyattr(inode);
-	ret = file_remove_privs(file);
-	if (ret)
-		goto out_unlock;
-	{
-
 	CLASS(fd_real, real)(file);
-	if (fd_empty(real)) {
-		ret = fd_err(real);
-		goto out_unlock;
-	}
+	if (fd_empty(real))
+		return fd_err(real);
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(fd_file(real), mode, offset, len);
@@ -435,9 +420,20 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 	/* Update size */
 	ovl_file_modified(file);
+	return ret;
+}
 
-	}
-out_unlock:
+static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+{
+	struct inode *inode = file_inode(file);
+	int ret;
+
+	inode_lock(inode);
+	/* Update mode */
+	ovl_copyattr(inode);
+	ret = file_remove_privs(file);
+	if (!ret)
+		ret = ovl_fallocate_locked(file, mode, offset, len);
 	inode_unlock(inode);
 
 	return ret;
@@ -465,36 +461,28 @@ enum ovl_copyop {
 	OVL_DEDUPE,
 };
 
-static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
+static loff_t ovl_copyfile_locked(struct file *file_in, loff_t pos_in,
 			    struct file *file_out, loff_t pos_out,
 			    loff_t len, unsigned int flags, enum ovl_copyop op)
 {
-	struct inode *inode_out = file_inode(file_out);
 	const struct cred *old_cred;
 	loff_t ret;
 
-	inode_lock(inode_out);
 	if (op != OVL_DEDUPE) {
 		/* Update mode */
-		ovl_copyattr(inode_out);
+		ovl_copyattr(file_inode(file_out));
 		ret = file_remove_privs(file_out);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}
 
-	{
-
 	CLASS(fd_real, real_out)(file_out);
-	if (fd_empty(real_out)) {
-		ret = fd_err(real_out);
-		goto out_unlock;
-	}
+	if (fd_empty(real_out))
+		return fd_err(real_out);
 
 	CLASS(fd_real, real_in)(file_in);
-	if (fd_empty(real_in)) {
-		ret = fd_err(real_in);
-		goto out_unlock;
-	}
+	if (fd_empty(real_in))
+		return fd_err(real_in);
 
 	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
 	switch (op) {
@@ -518,10 +506,19 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 
 	/* Update size */
 	ovl_file_modified(file_out);
+	return ret;
+}
 
-	}
+static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
+			    struct file *file_out, loff_t pos_out,
+			    loff_t len, unsigned int flags, enum ovl_copyop op)
+{
+	struct inode *inode_out = file_inode(file_out);
+	loff_t ret;
 
-out_unlock:
+	inode_lock(inode_out);
+	ret = ovl_copyfile_locked(file_in, pos_in, file_out, pos_out,
+				  len, flags, op);
 	inode_unlock(inode_out);
 
 	return ret;
-- 
2.39.5



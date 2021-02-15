Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0149831BD57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 16:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhBOPoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 10:44:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:49476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231584AbhBOPng (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:43:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 616CCADE0;
        Mon, 15 Feb 2021 15:42:17 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 69cb18b7;
        Mon, 15 Feb 2021 15:43:19 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Date:   Mon, 15 Feb 2021 15:43:17 +0000
Message-Id: <20210215154317.8590-1-lhenriques@suse.de>
In-Reply-To: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nicolas Boichat reported an issue when trying to use the copy_file_range
syscall on a tracefs file.  It failed silently because the file content is
generated on-the-fly (reporting a size of zero) and copy_file_range needs
to know in advance how much data is present.

This commit restores the cross-fs restrictions that existed prior to
5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") and
removes generic_copy_file_range() calls from ceph, cifs, fuse, and nfs.

Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
Cc: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
Changes since v1 (after Amir review)
- restored do_copy_file_range() helper
- return -EOPNOTSUPP if fs doesn't implement CFR
- updated commit description

 fs/ceph/file.c     | 21 +++-----------------
 fs/cifs/cifsfs.c   |  3 ---
 fs/fuse/file.c     | 21 +++-----------------
 fs/nfs/nfs4file.c  | 20 +++----------------
 fs/read_write.c    | 49 ++++++++++------------------------------------
 include/linux/fs.h |  3 ---
 6 files changed, 19 insertions(+), 98 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 209535d5b8d3..639bd7bfaea9 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2261,9 +2261,9 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
 	return bytes;
 }
 
-static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
-				      struct file *dst_file, loff_t dst_off,
-				      size_t len, unsigned int flags)
+static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
+				    struct file *dst_file, loff_t dst_off,
+				    size_t len, unsigned int flags)
 {
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *dst_inode = file_inode(dst_file);
@@ -2456,21 +2456,6 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	return ret;
 }
 
-static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
-				    struct file *dst_file, loff_t dst_off,
-				    size_t len, unsigned int flags)
-{
-	ssize_t ret;
-
-	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
-				     len, flags);
-
-	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(src_file, src_off, dst_file,
-					      dst_off, len, flags);
-	return ret;
-}
-
 const struct file_operations ceph_file_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index ab883e84e116..7aa3d20f21c0 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1229,9 +1229,6 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 					len, flags);
 	free_xid(xid);
 
-	if (rc == -EOPNOTSUPP || rc == -EXDEV)
-		rc = generic_copy_file_range(src_file, off, dst_file,
-					     destoff, len, flags);
 	return rc;
 }
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb55fb8..0dd703278e49 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3330,9 +3330,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	return err;
 }
 
-static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
-				      struct file *file_out, loff_t pos_out,
-				      size_t len, unsigned int flags)
+static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    size_t len, unsigned int flags)
 {
 	struct fuse_file *ff_in = file_in->private_data;
 	struct fuse_file *ff_out = file_out->private_data;
@@ -3439,21 +3439,6 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	return err;
 }
 
-static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
-				    struct file *dst_file, loff_t dst_off,
-				    size_t len, unsigned int flags)
-{
-	ssize_t ret;
-
-	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
-				     len, flags);
-
-	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(src_file, src_off, dst_file,
-					      dst_off, len, flags);
-	return ret;
-}
-
 static const struct file_operations fuse_file_operations = {
 	.llseek		= fuse_file_llseek,
 	.read_iter	= fuse_file_read_iter,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 57b3821d975a..60998209e310 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -133,9 +133,9 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 }
 
 #ifdef CONFIG_NFS_V4_2
-static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
-				      struct file *file_out, loff_t pos_out,
-				      size_t count, unsigned int flags)
+static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    size_t count, unsigned int flags)
 {
 	struct nfs42_copy_notify_res *cn_resp = NULL;
 	struct nl4_server *nss = NULL;
@@ -189,20 +189,6 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	return ret;
 }
 
-static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
-				    struct file *file_out, loff_t pos_out,
-				    size_t count, unsigned int flags)
-{
-	ssize_t ret;
-
-	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
-				     flags);
-	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(file_in, pos_in, file_out,
-					      pos_out, count, flags);
-	return ret;
-}
-
 static loff_t nfs4_file_llseek(struct file *filep, loff_t offset, int whence)
 {
 	loff_t ret;
diff --git a/fs/read_write.c b/fs/read_write.c
index 75f764b43418..b217cd62ae0d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1358,40 +1358,12 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 }
 #endif
 
-/**
- * generic_copy_file_range - copy data between two files
- * @file_in:	file structure to read from
- * @pos_in:	file offset to read from
- * @file_out:	file structure to write data to
- * @pos_out:	file offset to write data to
- * @len:	amount of data to copy
- * @flags:	copy flags
- *
- * This is a generic filesystem helper to copy data from one file to another.
- * It has no constraints on the source or destination file owners - the files
- * can belong to different superblocks and different filesystem types. Short
- * copies are allowed.
- *
- * This should be called from the @file_out filesystem, as per the
- * ->copy_file_range() method.
- *
- * Returns the number of bytes copied or a negative error indicating the
- * failure.
- */
-
-ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
-				struct file *file_out, loff_t pos_out,
-				size_t len, unsigned int flags)
-{
-	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
-				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
-}
-EXPORT_SYMBOL(generic_copy_file_range);
-
 static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  size_t len, unsigned int flags)
 {
+	ssize_t ret = -EXDEV;
+
 	/*
 	 * Although we now allow filesystems to handle cross sb copy, passing
 	 * a file of the wrong filesystem type to filesystem driver can result
@@ -1400,14 +1372,14 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * several different file_system_type structures, but they all end up
 	 * using the same ->copy_file_range() function pointer.
 	 */
-	if (file_out->f_op->copy_file_range &&
-	    file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
-		return file_out->f_op->copy_file_range(file_in, pos_in,
-						       file_out, pos_out,
-						       len, flags);
+	if (!file_out->f_op->copy_file_range)
+		ret = -EOPNOTSUPP;
+	else if (file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
+		ret = file_out->f_op->copy_file_range(file_in, pos_in,
+						      file_out, pos_out,
+						      len, flags);
 
-	return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				       flags);
+	return ret;
 }
 
 /*
@@ -1514,8 +1486,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	}
 
 	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				flags);
-	WARN_ON_ONCE(ret == -EOPNOTSUPP);
+				 flags);
 done:
 	if (ret > 0) {
 		fsnotify_access(file_in);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..3aaf627be409 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1910,9 +1910,6 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
-extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
-				       struct file *file_out, loff_t pos_out,
-				       size_t len, unsigned int flags);
 extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 					 struct file *file_out, loff_t pos_out,
 					 loff_t *count,

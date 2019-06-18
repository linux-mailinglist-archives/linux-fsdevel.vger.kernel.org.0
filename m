Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98AF4A992
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 20:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfFRSNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 14:13:04 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:35610 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727616AbfFRSNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:13:04 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hdIbN-0001pZ-EO; Tue, 18 Jun 2019 14:13:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pedro Cuadra <pjcuadra@gmail.com>, linux-fsdevel@vger.kernel.org,
        Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH] coda: Add hinting support for partial file caching
Date:   Tue, 18 Jun 2019 14:13:01 -0400
Message-Id: <20190618181301.6960-1-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pedro Cuadra <pjcuadra@gmail.com>

This adds support for partial file caching in Coda. Every read, write
and mmap informs the userspace cache manager about what part of a file
is about to be accessed so that the cache manager can ensure the
relevant parts are available before the operation is allowed to proceed.

When a read or write operation completes, this is also reported to allow
the cache manager to track when partially cached content can be released.

If the cache manager does not support partial file caching, or when the
entire file has been fetched into the local cache, the cache manager may
return an EOPNOTSUPP error to indicate that intent upcalls are no longer
necessary until the file is closed.

Signed-off-by: Pedro Cuadra <pjcuadra@gmail.com>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/coda_fs_i.h       |  1 +
 fs/coda/coda_psdev.h      |  3 ++
 fs/coda/file.c            | 61 +++++++++++++++++++++++++++-------
 fs/coda/psdev.c           |  2 +-
 fs/coda/upcall.c          | 70 ++++++++++++++++++++++++++++++++-------
 include/uapi/linux/coda.h | 29 ++++++++++++++--
 6 files changed, 139 insertions(+), 27 deletions(-)

diff --git a/fs/coda/coda_fs_i.h b/fs/coda/coda_fs_i.h
index c99d574d1c43..1763ff95d865 100644
--- a/fs/coda/coda_fs_i.h
+++ b/fs/coda/coda_fs_i.h
@@ -40,6 +40,7 @@ struct coda_file_info {
 	int		   cfi_magic;	  /* magic number */
 	struct file	  *cfi_container; /* container file for this cnode */
 	unsigned int	   cfi_mapcount;  /* nr of times this file is mapped */
+	bool		   cfi_access_intent; /* is access intent supported */
 };
 
 /* flags */
diff --git a/fs/coda/coda_psdev.h b/fs/coda/coda_psdev.h
index 801423cbbdfc..52da08c770b0 100644
--- a/fs/coda/coda_psdev.h
+++ b/fs/coda/coda_psdev.h
@@ -83,6 +83,9 @@ int coda_downcall(struct venus_comm *vcp, int opcode, union outputArgs *out,
 		  size_t nbytes);
 int venus_fsync(struct super_block *sb, struct CodaFid *fid);
 int venus_statfs(struct dentry *dentry, struct kstatfs *sfs);
+int venus_access_intent(struct super_block *sb, struct CodaFid *fid,
+			bool *access_intent_supported,
+			size_t count, loff_t ppos, int type);
 
 /*
  * Statistics
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 0dbd13ab72e3..128d63df5bfb 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -20,6 +20,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 
 #include <linux/coda.h>
 #include "coda_psdev.h"
@@ -37,9 +38,25 @@ static ssize_t
 coda_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *coda_file = iocb->ki_filp;
+	struct inode *coda_inode = file_inode(coda_file);
 	struct coda_file_info *cfi = coda_ftoc(coda_file);
+	loff_t ki_pos = iocb->ki_pos;
+	size_t count = iov_iter_count(to);
+	ssize_t ret;
+
+	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
+				  &cfi->cfi_access_intent,
+				  count, ki_pos, CODA_ACCESS_TYPE_READ);
+	if (ret)
+		goto finish_read;
 
-	return vfs_iter_read(cfi->cfi_container, to, &iocb->ki_pos, 0);
+	ret = vfs_iter_read(cfi->cfi_container, to, &iocb->ki_pos, 0);
+
+finish_read:
+	venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
+			    &cfi->cfi_access_intent,
+			    count, ki_pos, CODA_ACCESS_TYPE_READ_FINISH);
+	return ret;
 }
 
 static ssize_t
@@ -48,10 +65,17 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *coda_file = iocb->ki_filp;
 	struct inode *coda_inode = file_inode(coda_file);
 	struct coda_file_info *cfi = coda_ftoc(coda_file);
-	struct file *host_file;
+	struct file *host_file = cfi->cfi_container;
+	loff_t ki_pos = iocb->ki_pos;
+	size_t count = iov_iter_count(to);
 	ssize_t ret;
 
-	host_file = cfi->cfi_container;
+	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
+				  &cfi->cfi_access_intent,
+				  count, ki_pos, CODA_ACCESS_TYPE_WRITE);
+	if (ret)
+		goto finish_write;
+
 	file_start_write(host_file);
 	inode_lock(coda_inode);
 	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
@@ -60,6 +84,11 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	coda_inode->i_mtime = coda_inode->i_ctime = current_time(coda_inode);
 	inode_unlock(coda_inode);
 	file_end_write(host_file);
+
+finish_write:
+	venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
+			    &cfi->cfi_access_intent,
+			    count, ki_pos, CODA_ACCESS_TYPE_WRITE_FINISH);
 	return ret;
 }
 
@@ -94,29 +123,35 @@ coda_vm_close(struct vm_area_struct *vma)
 static int
 coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
 {
-	struct coda_file_info *cfi;
+	struct inode *coda_inode = file_inode(coda_file);
+	struct coda_file_info *cfi = coda_ftoc(coda_file);
+	struct file *host_file = cfi->cfi_container;
+	struct inode *host_inode = file_inode(host_file);
 	struct coda_inode_info *cii;
-	struct file *host_file;
-	struct inode *coda_inode, *host_inode;
 	struct coda_vm_ops *cvm_ops;
+	loff_t ppos;
+	size_t count;
 	int ret;
 
-	cfi = coda_ftoc(coda_file);
-	host_file = cfi->cfi_container;
-
 	if (!host_file->f_op->mmap)
 		return -ENODEV;
 
 	if (WARN_ON(coda_file != vma->vm_file))
 		return -EIO;
 
+	count = vma->vm_end - vma->vm_start;
+	ppos = vma->vm_pgoff * PAGE_SIZE;
+
+	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
+				  &cfi->cfi_access_intent,
+				  count, ppos, CODA_ACCESS_TYPE_MMAP);
+	if (ret)
+		return ret;
+
 	cvm_ops = kmalloc(sizeof(struct coda_vm_ops), GFP_KERNEL);
 	if (!cvm_ops)
 		return -ENOMEM;
 
-	coda_inode = file_inode(coda_file);
-	host_inode = file_inode(host_file);
-
 	cii = ITOC(coda_inode);
 	spin_lock(&cii->c_lock);
 	coda_file->f_mapping = host_file->f_mapping;
@@ -188,6 +223,8 @@ int coda_open(struct inode *coda_inode, struct file *coda_file)
 	cfi->cfi_magic = CODA_MAGIC;
 	cfi->cfi_mapcount = 0;
 	cfi->cfi_container = host_file;
+	/* assume access intents are supported unless we hear otherwise */
+	cfi->cfi_access_intent = true;
 
 	BUG_ON(coda_file->private_data != NULL);
 	coda_file->private_data = cfi;
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 482b7ba0339c..c2eb1a73f7d0 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -392,7 +392,7 @@ MODULE_AUTHOR("Jan Harkes, Peter J. Braam");
 MODULE_DESCRIPTION("Coda Distributed File System VFS interface");
 MODULE_ALIAS_CHARDEV_MAJOR(CODA_PSDEV_MAJOR);
 MODULE_LICENSE("GPL");
-MODULE_VERSION("6.11");
+MODULE_VERSION("7.0");
 
 static int __init init_coda(void)
 {
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 15c0e4fdb0e3..eb3b1898da46 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -569,6 +569,47 @@ int venus_statfs(struct dentry *dentry, struct kstatfs *sfs)
         return error;
 }
 
+int venus_access_intent(struct super_block *sb, struct CodaFid *fid,
+			bool *access_intent_supported,
+			size_t count, loff_t ppos, int type)
+{
+	union inputArgs *inp;
+	union outputArgs *outp;
+	int insize, outsize, error;
+	bool finalizer =
+		type == CODA_ACCESS_TYPE_READ_FINISH ||
+		type == CODA_ACCESS_TYPE_WRITE_FINISH;
+
+	if (!*access_intent_supported && !finalizer)
+		return 0;
+
+	insize = SIZE(access_intent);
+	UPARG(CODA_ACCESS_INTENT);
+
+	inp->coda_access_intent.VFid = *fid;
+	inp->coda_access_intent.count = count;
+	inp->coda_access_intent.pos = ppos;
+	inp->coda_access_intent.type = type;
+
+	error = coda_upcall(coda_vcp(sb), insize,
+			    finalizer ? NULL : &outsize, inp);
+
+	/*
+	 * we have to free the request buffer for synchronous upcalls
+	 * or when asynchronous upcalls fail, but not when asynchronous
+	 * upcalls succeed
+	 */
+	if (!finalizer || error)
+		kvfree(inp);
+
+	/* Chunked access is not supported or an old Coda client */
+	if (error == -EOPNOTSUPP) {
+		*access_intent_supported = false;
+		error = 0;
+	}
+	return error;
+}
+
 /*
  * coda_upcall and coda_downcall routines.
  */
@@ -598,10 +639,12 @@ static void coda_unblock_signals(sigset_t *old)
  * has seen them,
  * - CODA_CLOSE or CODA_RELEASE upcall  (to avoid reference count problems)
  * - CODA_STORE				(to avoid data loss)
+ * - CODA_ACCESS_INTENT                 (to avoid reference count problems)
  */
 #define CODA_INTERRUPTIBLE(r) (!coda_hard && \
 			       (((r)->uc_opcode != CODA_CLOSE && \
 				 (r)->uc_opcode != CODA_STORE && \
+				 (r)->uc_opcode != CODA_ACCESS_INTENT && \
 				 (r)->uc_opcode != CODA_RELEASE) || \
 				(r)->uc_flags & CODA_REQ_READ))
 
@@ -687,21 +730,25 @@ static int coda_upcall(struct venus_comm *vcp,
 		goto exit;
 	}
 
+	buffer->ih.unique = ++vcp->vc_seq;
+
 	req->uc_data = (void *)buffer;
-	req->uc_flags = 0;
+	req->uc_flags = outSize ? 0 : CODA_REQ_ASYNC;
 	req->uc_inSize = inSize;
-	req->uc_outSize = *outSize ? *outSize : inSize;
-	req->uc_opcode = ((union inputArgs *)buffer)->ih.opcode;
-	req->uc_unique = ++vcp->vc_seq;
+	req->uc_outSize = (outSize && *outSize) ? *outSize : inSize;
+	req->uc_opcode = buffer->ih.opcode;
+	req->uc_unique = buffer->ih.unique;
 	init_waitqueue_head(&req->uc_sleep);
 
-	/* Fill in the common input args. */
-	((union inputArgs *)buffer)->ih.unique = req->uc_unique;
-
 	/* Append msg to pending queue and poke Venus. */
 	list_add_tail(&req->uc_chain, &vcp->vc_pending);
-
 	wake_up_interruptible(&vcp->vc_waitq);
+
+	if (req->uc_flags & CODA_REQ_ASYNC) {
+		mutex_unlock(&vcp->vc_mutex);
+		return 0;
+	}
+
 	/* We can be interrupted while we wait for Venus to process
 	 * our request.  If the interrupt occurs before Venus has read
 	 * the request, we dequeue and return. If it occurs after the
@@ -743,20 +790,20 @@ static int coda_upcall(struct venus_comm *vcp,
 	sig_req = kmalloc(sizeof(struct upc_req), GFP_KERNEL);
 	if (!sig_req) goto exit;
 
-	sig_req->uc_data = kvzalloc(sizeof(struct coda_in_hdr), GFP_KERNEL);
-	if (!sig_req->uc_data) {
+	sig_inputArgs = kvzalloc(sizeof(struct coda_in_hdr), GFP_KERNEL);
+	if (!sig_inputArgs) {
 		kfree(sig_req);
 		goto exit;
 	}
 
 	error = -EINTR;
-	sig_inputArgs = (union inputArgs *)sig_req->uc_data;
 	sig_inputArgs->ih.opcode = CODA_SIGNAL;
 	sig_inputArgs->ih.unique = req->uc_unique;
 
 	sig_req->uc_flags = CODA_REQ_ASYNC;
 	sig_req->uc_opcode = sig_inputArgs->ih.opcode;
 	sig_req->uc_unique = sig_inputArgs->ih.unique;
+	sig_req->uc_data = (void *)sig_inputArgs;
 	sig_req->uc_inSize = sizeof(struct coda_in_hdr);
 	sig_req->uc_outSize = sizeof(struct coda_in_hdr);
 
@@ -911,4 +958,3 @@ int coda_downcall(struct venus_comm *vcp, int opcode, union outputArgs *out,
 	iput(inode);
 	return 0;
 }
-
diff --git a/include/uapi/linux/coda.h b/include/uapi/linux/coda.h
index 5dba636b6e11..79ba2daea395 100644
--- a/include/uapi/linux/coda.h
+++ b/include/uapi/linux/coda.h
@@ -271,7 +271,8 @@ struct coda_statfs {
 #define CODA_STATFS	 34
 #define CODA_STORE	 35
 #define CODA_RELEASE	 36
-#define CODA_NCALLS 37
+#define CODA_ACCESS_INTENT 37
+#define CODA_NCALLS 38
 
 #define DOWNCALL(opcode) (opcode >= CODA_REPLACE && opcode <= CODA_PURGEFID)
 
@@ -281,8 +282,12 @@ struct coda_statfs {
 
 #define CIOC_KERNEL_VERSION _IOWR('c', 10, size_t)
 
+//      CODA_KERNEL_VERSION 0 /* don't care about kernel version number */
+//      CODA_KERNEL_VERSION 1 /* The old venus 4.6 compatible interface */
+//      CODA_KERNEL_VERSION 2 /* venus_lookup gets an extra parameter */
 //      CODA_KERNEL_VERSION 3 /* 128-bit file identifiers */
-#define CODA_KERNEL_VERSION 4 /* 64-bit timespec */
+//      CODA_KERNEL_VERSION 4 /* 64-bit timespec */
+#define CODA_KERNEL_VERSION 5 /* access intent support */
 
 /*
  *        Venus <-> Coda  RPC arguments
@@ -637,6 +642,25 @@ struct coda_statfs_out {
     struct coda_statfs stat;
 };
 
+#define CODA_ACCESS_TYPE_READ		1
+#define CODA_ACCESS_TYPE_WRITE		2
+#define CODA_ACCESS_TYPE_MMAP		3
+#define CODA_ACCESS_TYPE_READ_FINISH	4
+#define CODA_ACCESS_TYPE_WRITE_FINISH	5
+
+/* coda_access_intent: NO_OUT */
+struct coda_access_intent_in {
+	struct coda_in_hdr ih;
+	struct CodaFid VFid;
+	int count;
+	int pos;
+	int type;
+};
+
+struct coda_access_intent_out {
+	struct coda_out_hdr out;
+};
+
 /* 
  * Occasionally, we don't cache the fid returned by CODA_LOOKUP. 
  * For instance, if the fid is inconsistent. 
@@ -668,6 +692,7 @@ union inputArgs {
     struct coda_open_by_fd_in coda_open_by_fd;
     struct coda_open_by_path_in coda_open_by_path;
     struct coda_statfs_in coda_statfs;
+	struct coda_access_intent_in coda_access_intent;
 };
 
 union outputArgs {
-- 
2.20.1


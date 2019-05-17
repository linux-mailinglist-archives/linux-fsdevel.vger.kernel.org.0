Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF521D73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfEQShK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:10 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57650 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729378AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000qK-Mi; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 22/22] coda: ftoc validity check integration
Date:   Fri, 17 May 2019 14:37:00 -0400
Message-Id: <a2c27663ec4547018c92d71c63b1dff4650b6546.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>

This patch moves cfi check in coda_ftoc() instead of repeating
it in the wild.

Module size
   text	   data	    bss	    dec	    hex	filename
  28297	   1040	    700	  30037	   7555	fs/coda/coda.ko.before
  28263	    980	    700	  29943	   74f7	fs/coda/coda.ko.after

Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/cnode.c     | 10 ++++++++++
 fs/coda/coda_fs_i.h |  3 +--
 fs/coda/dir.c       |  6 ++----
 fs/coda/file.c      | 17 +++++------------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index e2dcf2addf3f..06855f6c7902 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -148,6 +148,16 @@ struct inode *coda_fid_to_inode(struct CodaFid *fid, struct super_block *sb)
 	return inode;
 }
 
+struct coda_file_info *coda_ftoc(struct file *file)
+{
+	struct coda_file_info *cfi = file->private_data;
+
+	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+
+	return cfi;
+
+}
+
 /* the CONTROL inode is made without asking attributes from Venus */
 struct inode *coda_cnode_makectl(struct super_block *sb)
 {
diff --git a/fs/coda/coda_fs_i.h b/fs/coda/coda_fs_i.h
index d702ba1a2bf9..c99d574d1c43 100644
--- a/fs/coda/coda_fs_i.h
+++ b/fs/coda/coda_fs_i.h
@@ -42,8 +42,6 @@ struct coda_file_info {
 	unsigned int	   cfi_mapcount;  /* nr of times this file is mapped */
 };
 
-#define CODA_FTOC(file) ((struct coda_file_info *)((file)->private_data))
-
 /* flags */
 #define C_VATTR       0x1   /* Validity of vattr in inode */
 #define C_FLUSH       0x2   /* used after a flush */
@@ -54,6 +52,7 @@ struct inode *coda_cnode_make(struct CodaFid *, struct super_block *);
 struct inode *coda_iget(struct super_block *sb, struct CodaFid *fid, struct coda_vattr *attr);
 struct inode *coda_cnode_makectl(struct super_block *sb);
 struct inode *coda_fid_to_inode(struct CodaFid *fid, struct super_block *sb);
+struct coda_file_info *coda_ftoc(struct file *file);
 void coda_replace_fid(struct inode *, struct CodaFid *, struct CodaFid *);
 
 #endif
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 716a0b932ec0..ca40c2556ba6 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -356,8 +356,7 @@ static int coda_venus_readdir(struct file *coda_file, struct dir_context *ctx)
 	ino_t ino;
 	int ret;
 
-	cfi = CODA_FTOC(coda_file);
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	cfi = coda_ftoc(coda_file);
 	host_file = cfi->cfi_container;
 
 	cii = ITOC(file_inode(coda_file));
@@ -426,8 +425,7 @@ static int coda_readdir(struct file *coda_file, struct dir_context *ctx)
 	struct file *host_file;
 	int ret;
 
-	cfi = CODA_FTOC(coda_file);
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	cfi = coda_ftoc(coda_file);
 	host_file = cfi->cfi_container;
 
 	if (host_file->f_op->iterate || host_file->f_op->iterate_shared) {
diff --git a/fs/coda/file.c b/fs/coda/file.c
index a6b32c883a50..0dbd13ab72e3 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -37,9 +37,7 @@ static ssize_t
 coda_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *coda_file = iocb->ki_filp;
-	struct coda_file_info *cfi = CODA_FTOC(coda_file);
-
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	struct coda_file_info *cfi = coda_ftoc(coda_file);
 
 	return vfs_iter_read(cfi->cfi_container, to, &iocb->ki_pos, 0);
 }
@@ -49,12 +47,10 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *coda_file = iocb->ki_filp;
 	struct inode *coda_inode = file_inode(coda_file);
-	struct coda_file_info *cfi = CODA_FTOC(coda_file);
+	struct coda_file_info *cfi = coda_ftoc(coda_file);
 	struct file *host_file;
 	ssize_t ret;
 
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
-
 	host_file = cfi->cfi_container;
 	file_start_write(host_file);
 	inode_lock(coda_inode);
@@ -105,8 +101,7 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
 	struct coda_vm_ops *cvm_ops;
 	int ret;
 
-	cfi = CODA_FTOC(coda_file);
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	cfi = coda_ftoc(coda_file);
 	host_file = cfi->cfi_container;
 
 	if (!host_file->f_op->mmap)
@@ -208,8 +203,7 @@ int coda_release(struct inode *coda_inode, struct file *coda_file)
 	struct inode *host_inode;
 	int err;
 
-	cfi = CODA_FTOC(coda_file);
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	cfi = coda_ftoc(coda_file);
 
 	err = venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
 			  coda_flags, coda_file->f_cred->fsuid);
@@ -251,8 +245,7 @@ int coda_fsync(struct file *coda_file, loff_t start, loff_t end, int datasync)
 		return err;
 	inode_lock(coda_inode);
 
-	cfi = CODA_FTOC(coda_file);
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	cfi = coda_ftoc(coda_file);
 	host_file = cfi->cfi_container;
 
 	err = vfs_fsync(host_file, datasync);
-- 
2.20.1


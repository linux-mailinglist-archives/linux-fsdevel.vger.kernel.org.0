Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575272A8B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 08:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfEZGLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 02:11:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44028 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfEZGLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 02:11:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id l17so5254301wrm.10;
        Sat, 25 May 2019 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dh6NYvHDfeCra0hMJwF294oAaC7qsyBcur4kIgbRNEk=;
        b=SQmnIrJAyfm/WM8SeFVW6AythYAmq4t0pJiTL6QlOXStTTS5TOLrJVjl4U3LsaLZik
         ldsV0K3ZhgKPid3ZWhhT1TmXQEKOlfvQNfEifYLGLcr2y1eFcVl4+TaCh273xyRKr8T2
         bQFUWZOkzsiQUB1ey2ENVev3UjlBODJEQkcoRPaKIKIJ+2ac4La11Uit01ngeqxHBOkL
         nfn4t37Mhm2oLTZ+QjUb4SmAgcWJ8YHx8rNbonX+3yjVDUBKiQEwdJItTh9q9CyJ1BhN
         JJi4rIFJAzKJPUBiR/wKrOJqI4nM8PXbPa0XyCjgs3pgidKMYxmZYfP031WwcehdZ96r
         yCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dh6NYvHDfeCra0hMJwF294oAaC7qsyBcur4kIgbRNEk=;
        b=g1wcCZEdY22JfHIpLB7dGprCTur3cRJ0oe9yM5/nz+gulnK7J2nv7RSt0F0Hy50S66
         RGTgZGwVwiSGkFiqRlnFdXYjqWiVMImh6Vg4JBdPgjx+uSGBgDA5t2Y2yc1lLixW/K8W
         POA8ZieW4kG2Q/Rubkupk5wYjWZHujLFnOGrhc3XWH+BUm4NrVLNcYusNskTfur2DYQY
         zGuaWf17i/VkcFdrA5rVa7NILp5c//Jdz+UBGqdBjXU7yHZk3Tf+2hSBgYqN3tfDWlS5
         zCzv+YrQU/WGoCsrF8OGOj6YsP/ZmtstroGMBRCyZSXY5soPoL2XBj3NcoCxE+LX9QRR
         a4oA==
X-Gm-Message-State: APjAAAW9pD7YIcZHi0GRdWiZvRVY2Q1K2P9dwuv9gDnpOOU+GCy7rqt4
        P4+o0R2B6LT0gpQkuPzmi1c=
X-Google-Smtp-Source: APXvYqz+luHf4urr3DGcHaQp4SwKfS/0Q8U0BnzJGTZtBr1n9gYknnidfMnuqeWr5nBjV1crTjqdfw==
X-Received: by 2002:adf:c188:: with SMTP id x8mr6450128wre.256.1558851077351;
        Sat, 25 May 2019 23:11:17 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id a124sm5302943wmh.3.2019.05.25.23.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 23:11:16 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 3/8] vfs: introduce generic_file_rw_checks()
Date:   Sun, 26 May 2019 09:10:54 +0300
Message-Id: <20190526061100.21761-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526061100.21761-1-amir73il@gmail.com>
References: <20190526061100.21761-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out helper with some checks on in/out file that are
common to clone_file_range and copy_file_range.

Suggested-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c    | 38 +++++++++++---------------------------
 include/linux/fs.h |  1 +
 mm/filemap.c       | 24 ++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b63dcb4e4fe9..f1900bdb3127 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1617,17 +1617,18 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 			    struct file *file_out, loff_t pos_out,
 			    size_t len, unsigned int flags)
 {
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
 	ssize_t ret;
 
 	if (flags != 0)
 		return -EINVAL;
 
-	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
-		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
-		return -EINVAL;
+	/* this could be relaxed once a method supports cross-fs copies */
+	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+		return -EXDEV;
+
+	ret = generic_file_rw_checks(file_in, file_out);
+	if (unlikely(ret))
+		return ret;
 
 	ret = rw_verify_area(READ, file_in, &pos_in, len);
 	if (unlikely(ret))
@@ -1637,15 +1638,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (unlikely(ret))
 		return ret;
 
-	if (!(file_in->f_mode & FMODE_READ) ||
-	    !(file_out->f_mode & FMODE_WRITE) ||
-	    (file_out->f_flags & O_APPEND))
-		return -EBADF;
-
-	/* this could be relaxed once a method supports cross-fs copies */
-	if (inode_in->i_sb != inode_out->i_sb)
-		return -EXDEV;
-
 	if (len == 0)
 		return 0;
 
@@ -2013,29 +2005,21 @@ loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 			   struct file *file_out, loff_t pos_out,
 			   loff_t len, unsigned int remap_flags)
 {
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
 	loff_t ret;
 
 	WARN_ON_ONCE(remap_flags & REMAP_FILE_DEDUP);
 
-	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
-		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
-		return -EINVAL;
-
 	/*
 	 * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
 	 * the same mount. Practically, they only need to be on the same file
 	 * system.
 	 */
-	if (inode_in->i_sb != inode_out->i_sb)
+	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
 		return -EXDEV;
 
-	if (!(file_in->f_mode & FMODE_READ) ||
-	    !(file_out->f_mode & FMODE_WRITE) ||
-	    (file_out->f_flags & O_APPEND))
-		return -EBADF;
+	ret = generic_file_rw_checks(file_in, file_out);
+	if (ret < 0)
+		return ret;
 
 	if (!file_in->f_op->remap_file_range)
 		return -EOPNOTSUPP;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ea17858310ff..89b9b73eb581 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3049,6 +3049,7 @@ extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
 extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				loff_t *count, unsigned int remap_flags);
+extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
diff --git a/mm/filemap.c b/mm/filemap.c
index c5af80c43d36..798aac92cd76 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3040,6 +3040,30 @@ int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	return 0;
 }
 
+
+/*
+ * Performs common checks before doing a file copy/clone
+ * from @file_in to @file_out.
+ */
+int generic_file_rw_checks(struct file *file_in, struct file *file_out)
+{
+	struct inode *inode_in = file_inode(file_in);
+	struct inode *inode_out = file_inode(file_out);
+
+	/* Don't copy dirs, pipes, sockets... */
+	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
+		return -EISDIR;
+	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+		return -EINVAL;
+
+	if (!(file_in->f_mode & FMODE_READ) ||
+	    !(file_out->f_mode & FMODE_WRITE) ||
+	    (file_out->f_flags & O_APPEND))
+		return -EBADF;
+
+	return 0;
+}
+
 int pagecache_write_begin(struct file *file, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
 				struct page **pagep, void **fsdata)
-- 
2.17.1


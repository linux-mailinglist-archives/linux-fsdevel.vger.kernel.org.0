Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A5A312D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfEaQrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:47:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54356 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfEaQrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so3260669wme.4;
        Fri, 31 May 2019 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zD+G66icCrS83U+p0kj1jVa8Ed5aOLuiZE56AA1YrhI=;
        b=sWNCZqzhaJm/4HJauaa9QW9+p0kio32kz/pibNec/NwcF9x/RJ+iU6qoSJV6D/Ebqb
         2FmHHDFY7nZBdh4GOkQ4zu3rb9YhT7P5gh9SE21RqNNsFqyq1Uj+2Gw0wpBqTtoU2Xpt
         N0JjE+xNZ2BMjjfk1HBrFfv39id1kMivh6VnLLR+QlPzMstZRlcihQZpjeQ6VS/4MGvp
         ua4/Ug/pPLL5RaGR4qnRpkYq09vHvo+A1tpsrZ354Mg4B1wFy0JnoQ2unzUUHM/MO4NN
         PBAUZoym1D92/fJDtMl0laheZ4rOzMFtMquVzjmvPrUa0wEeGrRboqMRLA3Ch2CA8QKw
         PrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zD+G66icCrS83U+p0kj1jVa8Ed5aOLuiZE56AA1YrhI=;
        b=GOCEF75zEKg1MsnYGwlcrbG0iShYapiIYFdyvRYqup7XGzZetk5ab4SiCre05h1/29
         4A2Oz/lMLw0mjRYAvycm8Kv09Lw5Pg7bBQSm8Vy3ScqAqziwkXc6DCQM4fSmyFV6wqkc
         LotYHbGoBPLAq+CQ/5acaW4kXr7uPMU/8NqXGVMZzvb2z8NmrCGuoiCb7QxZJWpBCHi4
         ZU2I5lomImoZegbjelP5RJDjuuxqwn4bLoNwPSDV8c46Ue3yau0aJFx18UJF2GTGt+xV
         ZRwV0SypDmNJr9CW3BZWTeb37QSI0uDl5n0Oo00Rmei+HrQYfDTO6n+G6SdLO+P2cTPz
         gnRQ==
X-Gm-Message-State: APjAAAWvtFkjHZ3S4nKkHDqEwgeLRHb4/19Ab0WMv3yFa6rSSnM2nXq3
        nMqqobTFX5FqFlYxUf3z+VM=
X-Google-Smtp-Source: APXvYqzgtgOxhQAEKCd6LXP6m3DrP2CcaEho6Vi6DDXxj5zFoCxQu0yF0irMj6KB+Uhd6FqZRklExg==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr6355720wmc.106.1559321234671;
        Fri, 31 May 2019 09:47:14 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n5sm7669593wrj.27.2019.05.31.09.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:14 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 3/9] vfs: introduce generic_file_rw_checks()
Date:   Fri, 31 May 2019 19:46:55 +0300
Message-Id: <20190531164701.15112-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531164701.15112-1-amir73il@gmail.com>
References: <20190531164701.15112-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out helper with some checks on in/out file that are
common to clone_file_range and copy_file_range.

Suggested-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
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
index df2006ba0cfa..a38619a4a6af 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3041,6 +3041,30 @@ int generic_remap_checks(struct file *file_in, loff_t pos_in,
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


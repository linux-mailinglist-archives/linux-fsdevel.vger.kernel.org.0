Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA57263DA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 08:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgIJGwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 02:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgIJGwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:52:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6CFC061756
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KxrkpxX4CHcXkhE7jRr1SghDc9sOD/Vra1dlxg39O8I=; b=elVfkz/EWJGcF6mYRMUQt+Dovd
        Cm048vrbGsUJcb/p9Hk2fxwmehhPgiBHN+BNPenk4JfUR+63nl7eMObR1ozLj3NNFyg+SnzM6bSHD
        /f+g3m3DzH84S9vCkm8a/bi4Qo05G3BGIFk5BrsdAuz/+QVAPRpow0OO9ufMCsdLp7Pa8aCI5ELhD
        dajeXI6x8qpGCSss23bjqWjwBUw3NFOeZhPm6/qsR5TPtudyExdDWcHvI5ZdjQQyHlk0Vtl/iwGcr
        B5C3Bu/e0niypkcL/YFfkz9h3McCcDwQNYPkDxYiH2PCpwCooRSHzB9dCw/hYlS7txIu+kPE4XTU3
        sPa5RwoQ==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGGIB-0000Bn-1s; Thu, 10 Sep 2020 06:42:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] fs: remove vfs_statx_fd
Date:   Thu, 10 Sep 2020 08:42:39 +0200
Message-Id: <20200910064244.346913-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910064244.346913-1-hch@lst.de>
References: <20200910064244.346913-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vfs_statx_fd is only used to implement vfs_fstat.  Remove vfs_statx_fd
and just implement vfs_fstat directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/stat.c          | 22 +++++++---------------
 include/linux/fs.h |  7 +------
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 44f8ad346db4ca..2683a051ce07fa 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -126,35 +126,27 @@ int vfs_getattr(const struct path *path, struct kstat *stat,
 EXPORT_SYMBOL(vfs_getattr);
 
 /**
- * vfs_statx_fd - Get the enhanced basic attributes by file descriptor
+ * vfs_fstat - Get the basic attributes by file descriptor
  * @fd: The file descriptor referring to the file of interest
  * @stat: The result structure to fill in.
- * @request_mask: STATX_xxx flags indicating what the caller wants
- * @query_flags: Query mode (KSTAT_QUERY_FLAGS)
  *
  * This function is a wrapper around vfs_getattr().  The main difference is
  * that it uses a file descriptor to determine the file location.
  *
  * 0 will be returned on success, and a -ve error code if unsuccessful.
  */
-int vfs_statx_fd(unsigned int fd, struct kstat *stat,
-		 u32 request_mask, unsigned int query_flags)
+int vfs_fstat(int fd, struct kstat *stat)
 {
 	struct fd f;
-	int error = -EBADF;
-
-	if (query_flags & ~KSTAT_QUERY_FLAGS)
-		return -EINVAL;
+	int error;
 
 	f = fdget_raw(fd);
-	if (f.file) {
-		error = vfs_getattr(&f.file->f_path, stat,
-				    request_mask, query_flags);
-		fdput(f);
-	}
+	if (!f.file)
+		return -EBADF;
+	error = vfs_getattr(&f.file->f_path, stat, STATX_BASIC_STATS, 0);
+	fdput(f);
 	return error;
 }
-EXPORT_SYMBOL(vfs_statx_fd);
 
 static inline unsigned vfs_stat_set_lookup_flags(unsigned *lookup_flags,
 						 int flags)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a082c..bde55e637d5a12 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3166,7 +3166,7 @@ extern const struct inode_operations simple_symlink_inode_operations;
 extern int iterate_dir(struct file *, struct dir_context *);
 
 extern int vfs_statx(int, const char __user *, int, struct kstat *, u32);
-extern int vfs_statx_fd(unsigned int, struct kstat *, u32, unsigned int);
+int vfs_fstat(int fd, struct kstat *stat);
 
 static inline int vfs_stat(const char __user *filename, struct kstat *stat)
 {
@@ -3184,11 +3184,6 @@ static inline int vfs_fstatat(int dfd, const char __user *filename,
 	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
 			 stat, STATX_BASIC_STATS);
 }
-static inline int vfs_fstat(int fd, struct kstat *stat)
-{
-	return vfs_statx_fd(fd, stat, STATX_BASIC_STATS, 0);
-}
-
 
 extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
 extern int vfs_readlink(struct dentry *, char __user *, int);
-- 
2.28.0


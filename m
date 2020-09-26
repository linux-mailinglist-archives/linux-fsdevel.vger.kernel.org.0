Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6AB27976F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgIZHEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 03:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZHEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:04:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C9C0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KxrkpxX4CHcXkhE7jRr1SghDc9sOD/Vra1dlxg39O8I=; b=BMDVGagk6M89vtBF7dEk4FRyKc
        XpLSgw2TkgHzcgHUIa9lq5tyA8jX20FNJx7JBCvIUrubgYXL/atE4KhcmvitvHZnzwKb6RsGmD4hG
        2quuDHpZkkzlNitoV3m1jcTbyqmM+dwCeyUc1TQeXPZ27JYkYKLD9zq33ZOS7vVY7p0rvfmW0PFMa
        kjgq1ghtYyDB22IaOJ8p2TnUqssPVr8sfjTql4WiIVu1k0HLG7PD3EO0wO0WflF1Yd+728ZgTYZUO
        9RQQFCpZflhcrGUGpLGMf81YIy3LWaXcb2firDrMyFhY3dx2XYKTCREQdBLb1KtHrotGIQxhX8V1y
        E9kWRN4g==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM4FW-0003vd-FM; Sat, 26 Sep 2020 07:04:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] fs: remove vfs_statx_fd
Date:   Sat, 26 Sep 2020 09:03:57 +0200
Message-Id: <20200926070401.11816-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926070401.11816-1-hch@lst.de>
References: <20200926070401.11816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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


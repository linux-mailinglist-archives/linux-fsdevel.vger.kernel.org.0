Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725771CA70A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 11:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgEHJXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 05:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgEHJWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 05:22:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE43C05BD43;
        Fri,  8 May 2020 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ny/dUp3EeGrcoMfUS16dK3e2zcCNlcPi/UI1wWuauls=; b=KUF8uiBMZClAsuWmDnrErAMQbC
        EKAF+mkVMdsLTctvZJU45i1SIYJ89Qc54JXieAHoSbTXuzM7Yk2NZeFBG67kO7VKeuqCAFoFt5vFa
        AvvZ4zo1QxIcc9uOZM9BpE+JBNEqxcPt5v76f7GWFsb+w36vfaoIv3whFv4YNTT0G7sVAdD/uy9+Y
        kKeSSCxNdKEuhODE8gc6GmOFpwIH6YLI6Rsq/UU9v1Xp+t6JW7h3TDYomR3nh6a5nUfj4j370wzWS
        Ts5AN1FifFjGLPBq0u15w/ZAdmrOpphgm/S+lhWkRP5cmushbj6cJxTy6PFLwrRJgCu42TAQZ40vf
        +LS1OufA==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzDW-00009a-18; Fri, 08 May 2020 09:22:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 10/11] fs: remove __vfs_read
Date:   Fri,  8 May 2020 11:22:21 +0200
Message-Id: <20200508092222.2097-11-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508092222.2097-1-hch@lst.de>
References: <20200508092222.2097-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fold it into the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c    | 43 +++++++++++++++++++++----------------------
 include/linux/fs.h |  1 -
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0ffbed5fd8136..f0009b506014c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -419,17 +419,6 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	return ret;
 }
 
-ssize_t __vfs_read(struct file *file, char __user *buf, size_t count,
-		   loff_t *pos)
-{
-	if (file->f_op->read)
-		return file->f_op->read(file, buf, count, pos);
-	else if (file->f_op->read_iter)
-		return new_sync_read(file, buf, count, pos);
-	else
-		return -EINVAL;
-}
-
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
 	mm_segment_t old_fs = get_fs();
@@ -441,7 +430,12 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
 	set_fs(KERNEL_DS);
-	ret = __vfs_read(file, (void __user *)buf, count, pos);
+	if (file->f_op->read)
+		ret = file->f_op->read(file, (void __user *)buf, count, pos);
+	else if (file->f_op->read_iter)
+		ret = new_sync_read(file, (void __user *)buf, count, pos);
+	else
+		ret = -EINVAL;
 	set_fs(old_fs);
 	if (ret > 0) {
 		fsnotify_access(file);
@@ -474,17 +468,22 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 		return -EFAULT;
 
 	ret = rw_verify_area(READ, file, pos, count);
-	if (!ret) {
-		if (count > MAX_RW_COUNT)
-			count =  MAX_RW_COUNT;
-		ret = __vfs_read(file, buf, count, pos);
-		if (ret > 0) {
-			fsnotify_access(file);
-			add_rchar(current, ret);
-		}
-		inc_syscr(current);
-	}
+	if (ret)
+		return ret;
+	if (count > MAX_RW_COUNT)
+		count =  MAX_RW_COUNT;
 
+	if (file->f_op->read)
+		ret = file->f_op->read(file, buf, count, pos);
+	else if (file->f_op->read_iter)
+		ret = new_sync_read(file, buf, count, pos);
+	else
+		ret = -EINVAL;
+	if (ret > 0) {
+		fsnotify_access(file);
+		add_rchar(current, ret);
+	}
+	inc_syscr(current);
 	return ret;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6441aaa25f8f2..4c10a07a36178 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1905,7 +1905,6 @@ ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
 			      struct iovec *fast_pointer,
 			      struct iovec **ret_pointer);
 
-extern ssize_t __vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
-- 
2.26.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF931CA710
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgEHJWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgEHJWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 05:22:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060A2C05BD43;
        Fri,  8 May 2020 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=V/EdMUvxufPYsTf8+BVqK5Uvn4IVRJmx9LBhx14QLjI=; b=PrGhWrIlreWoD+QPgc7MN98VLi
        jZsvdj+NuPyAUvmNMQOzBl5CuowJnr/4G3hDaf+jQ7AaBXIauqNtel/e5bfGLrhPLAVe/qFgIUGAI
        CVAjwM5GVTZVfr/twjqvFVtm2KPz96Qv3KyzxH9bDRXnfAW+d8khqkW9vHfdWT16oZ+a1MQKqxDQZ
        hjLpxSFtL1VnmlNo5SWIl1yCghd831FgjviXBpxAr+bxJ4r1LX8ssLQ+nCUXhdrHdWPmRKHC+4/iM
        kY3pEDQpZyiOKOnJtEYZCVN83ByaCl6Rqwczy3RTkR9+AqbfW0gLvQ1u7EqJ2MtXrIQjiwRpONNW/
        qD/uubrw==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzDJ-0008Ke-Ey; Fri, 08 May 2020 09:22:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 05/11] fs: remove __vfs_write
Date:   Fri,  8 May 2020 11:22:16 +0200
Message-Id: <20200508092222.2097-6-hch@lst.de>
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
 fs/read_write.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 6b456a257b31c..67a035782874b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -488,17 +488,6 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	return ret;
 }
 
-static ssize_t __vfs_write(struct file *file, const char __user *p,
-			   size_t count, loff_t *pos)
-{
-	if (file->f_op->write)
-		return file->f_op->write(file, p, count, pos);
-	else if (file->f_op->write_iter)
-		return new_sync_write(file, p, count, pos);
-	else
-		return -EINVAL;
-}
-
 ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
 {
 	mm_segment_t old_fs;
@@ -516,7 +505,12 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	p = (__force const char __user *)buf;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	ret = __vfs_write(file, p, count, pos);
+	if (file->f_op->write)
+		ret = file->f_op->write(file, p, count, pos);
+	else if (file->f_op->write_iter)
+		ret = new_sync_write(file, p, count, pos);
+	else
+		ret = -EINVAL;
 	set_fs(old_fs);
 	if (ret > 0) {
 		fsnotify_modify(file);
@@ -553,19 +547,23 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 		return -EFAULT;
 
 	ret = rw_verify_area(WRITE, file, pos, count);
-	if (!ret) {
-		if (count > MAX_RW_COUNT)
-			count =  MAX_RW_COUNT;
-		file_start_write(file);
-		ret = __vfs_write(file, buf, count, pos);
-		if (ret > 0) {
-			fsnotify_modify(file);
-			add_wchar(current, ret);
-		}
-		inc_syscw(current);
-		file_end_write(file);
+	if (ret)
+		return ret;
+	if (count > MAX_RW_COUNT)
+		count =  MAX_RW_COUNT;
+	file_start_write(file);
+	if (file->f_op->write)
+		ret = file->f_op->write(file, buf, count, pos);
+	else if (file->f_op->write_iter)
+		ret = new_sync_write(file, buf, count, pos);
+	else
+		ret = -EINVAL;
+	if (ret > 0) {
+		fsnotify_modify(file);
+		add_wchar(current, ret);
 	}
-
+	inc_syscw(current);
+	file_end_write(file);
 	return ret;
 }
 
-- 
2.26.2


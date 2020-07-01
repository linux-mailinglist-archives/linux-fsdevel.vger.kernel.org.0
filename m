Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865B4211446
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGAUXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgGAUXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E0C08C5DC;
        Wed,  1 Jul 2020 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dVcUaNs/nJl21S9DI4MlGzuWbjmDqO4Jqbdos/3DXPs=; b=mIEsWQJBNLqTxQk86AOLQrYFrU
        NC/8e2hKgEV+pD6QhC0KTesIVy8luHQP+bVoUy8wDSF6JzNAEAAUsbWI/2WmrNKdPRQBj3hqef14w
        GoxbJFPw5V6WyH9yOj9hdvmqb6+2Ix1cQKDDSjTCjVnJ/ZdEhsrTIGOFQGFeYEmhf7QDkRcXmPJdK
        AAoYM9y/qt/9BdrdJRDob4clcSdSpgnt5hWv/7bFETr+M8hcUYc1UFbeuh6IjRQyJfSNaWp4ahG9y
        5Jk1R5AgBQmm0O6YmjxGLuxYFMKNSg9N2FKwOiAE6LbmJ9TnFB3fkTH1rACuci/s1Cj/ru8TseR0e
        5/tWUdAA==;
Received: from [2001:4bb8:18c:3b3b:379a:a079:66b5:89c3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjG6-0002Pi-8w; Wed, 01 Jul 2020 20:23:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/23] fs: remove __vfs_write
Date:   Wed,  1 Jul 2020 22:09:35 +0200
Message-Id: <20200701200951.3603160-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701200951.3603160-1-hch@lst.de>
References: <20200701200951.3603160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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
index 5110cd1e6e2771..96e8e354f99b45 100644
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
 /* caller is responsible for file_start_write/file_end_write */
 ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
 {
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
@@ -554,19 +548,23 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
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


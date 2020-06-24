Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E0207928
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404883AbgFXQaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405011AbgFXQ3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:34 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBED2C061795;
        Wed, 24 Jun 2020 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oEIeGipGiq5zsPlrQwSey3OskkAUJ0grTVV3VZoK4No=; b=OLCJ24nc1l859RJjra1fthfHGt
        yY7smJc+rzD0a17nd/xH1ZwVbZI0Gdn8nCYP9sZ/pFUiaLqCpdVh2iwQQnEELV9XrCC+mNfL9yqIU
        /I9LIREnuOQRg0XbAdE61h1JoIf5++5nTCviE37+dbgI8y+5ZvUYibfLp14vOxOLWAb3LFmDLRUkf
        l/G+Bio6YHI4n8enbltsl1Nwg3lGSKcyuYr7zOzlTDovPkq25Fs4zhZHUILxLTDJfYeTZoQfNZAJH
        PpinyiOLTsSz1HdR0Av6kxsR9xjbx6B8vSb7kFpp6XPwiNaDUO/gYyNogHYGg3w34Ye1hgYpI3mia
        gzDeWYjA==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo8Gy-0006pi-D9; Wed, 24 Jun 2020 16:29:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/11] fs: don't allow kernel reads and writes using ->read and ->write
Date:   Wed, 24 Jun 2020 18:29:00 +0200
Message-Id: <20200624162901.1814136-11-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624162901.1814136-1-hch@lst.de>
References: <20200624162901.1814136-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't allow calling ->read or ->write with set_fs as a preparation for
killing off set_fs.  While I've not triggered any of these cases in my
setups as all the usual suspect (file systems, pipes, sockets, block
devices, system character devices) use the iter ops this is almost
going to be guaranteed to eventuall break something, so print a detailed
error message helping to debug such cases.  The fix will be to switch the
affected driver to use ->read_uptr / ->write_uptr or ->read_iter /
->write_iter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b92c222ca886ca..1b813d9bcf08b7 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -420,6 +420,18 @@ ssize_t iter_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos,
 	return ret;
 }
 
+static void warn_unsupported(struct file *file, const char *op)
+{
+	char pathname[128], *path;
+
+	path = file_path(file, pathname, sizeof(pathname));
+	if (IS_ERR(path))
+		path = "(unknown)";
+	pr_warn_ratelimited(
+		"kernel space %s not supported for file %s (pid: %d comm: %.20s)\n",
+		op, path, current->pid, current->comm);
+}
+
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
 	ssize_t ret;
@@ -433,12 +445,6 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 		count =  MAX_RW_COUNT;
 	if (file->f_op->read_uptr) {
 		ret = file->f_op->read_uptr(file, KERNEL_UPTR(buf), count, pos);
-	} else if (file->f_op->read) {
-		mm_segment_t old_fs = get_fs();
-
-		set_fs(KERNEL_DS);
-		ret = file->f_op->read(file, (void __user *)buf, count, pos);
-		set_fs(old_fs);
 	} else if (file->f_op->read_iter) {
 		struct kvec iov = { .iov_base = buf, .iov_len = count };
 		struct kiocb kiocb;
@@ -450,6 +456,8 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 		ret = file->f_op->read_iter(&kiocb, &iter);
 		*pos = kiocb.ki_pos;
 	} else {
+		if (file->f_op->read)
+			warn_unsupported(file, "read");
 		ret = -EINVAL;
 	}
 	if (ret > 0) {
@@ -539,13 +547,6 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
 	if (file->f_op->write_uptr) {
 		ret = file->f_op->write_uptr(file, KERNEL_UPTR((void *)buf),
 				count, pos);
-	} else if (file->f_op->write) {
-		mm_segment_t old_fs = get_fs();
-
-		set_fs(KERNEL_DS);
-		ret = file->f_op->write(file, (__force const char __user *)buf,
-				count, pos);
-		set_fs(old_fs);
 	} else if (file->f_op->write_iter) {
 		struct kvec iov = { .iov_base = (void *)buf, .iov_len = count };
 		struct kiocb kiocb;
@@ -558,6 +559,8 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
 		if (ret > 0)
 			*pos = kiocb.ki_pos;
 	} else {
+		if (file->f_op->write)
+			warn_unsupported(file, "write");
 		ret = -EINVAL;
 	}
 	if (ret > 0) {
-- 
2.26.2


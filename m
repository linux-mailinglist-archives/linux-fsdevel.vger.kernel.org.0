Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE90620ADA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 09:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgFZH7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 03:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgFZH7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:59:09 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4E6C08C5C1;
        Fri, 26 Jun 2020 00:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MFh6zAftA8I60tTbMs8bqx+fHkWDGkKJuddiCkGy7lg=; b=H6+5aQ1c5Y52su43a5GMBeR06I
        voEnTUpMhmBe6aVtpwddKW6svcL4Enilh2uAo015t8jHc3SJ+RaLg1HWEdQ1tNEcL1qtz2sZ+CaWK
        7jTyUwHyuE42tKygQOU7lkisHGEQmuWgce+u6M6AGv/Cm51OH/jBNnS6pS9eujvNNfodY2iIH42IM
        ceX3KS4JFuQW+eF4M0hOaIRdyGQ/mliRAsrIV1s4V9lRat1QSmQN79g45WgswhvNZN/MYsknt/9fc
        qfQugwSGuGyNgRIZ4S7l8mRRb4FtzITAQ6RlBt5DNX1IAPCLviH/G+Ok0Im86bbva7SiojWDhG7EG
        oBfaThxg==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojG4-00071c-Jg; Fri, 26 Jun 2020 07:58:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/9] fs: don't allow kernel reads and writes without iter ops
Date:   Fri, 26 Jun 2020 09:58:35 +0200
Message-Id: <20200626075836.1998185-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626075836.1998185-1-hch@lst.de>
References: <20200626075836.1998185-1-hch@lst.de>
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
affected driver to use the iter ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index e765c95ff3440d..ae463bcadb6906 100644
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
+		"kernel %s not supported for file %s (pid: %d comm: %.20s)\n",
+		op, path, current->pid, current->comm);
+}
+
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
 	ssize_t ret;
@@ -431,13 +443,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	if (file->f_op->read) {
-		mm_segment_t old_fs = get_fs();
-
-		set_fs(KERNEL_DS);
-		ret = file->f_op->read(file, (void __user *)buf, count, pos);
-		set_fs(old_fs);
-	} else if (file->f_op->read_iter) {
+	if (file->f_op->read_iter) {
 		struct kvec iov = { .iov_base = buf, .iov_len = count };
 		struct kiocb kiocb;
 		struct iov_iter iter;
@@ -448,6 +454,8 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 		ret = file->f_op->read_iter(&kiocb, &iter);
 		*pos = kiocb.ki_pos;
 	} else {
+		if (file->f_op->read)
+			warn_unsupported(file, "read");
 		ret = -EINVAL;
 	}
 	if (ret > 0) {
@@ -532,14 +540,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
 
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	if (file->f_op->write) {
-		mm_segment_t old_fs = get_fs();
-
-		set_fs(KERNEL_DS);
-		ret = file->f_op->write(file, (__force const char __user *)buf,
-				count, pos);
-		set_fs(old_fs);
-	} else if (file->f_op->write_iter) {
+	if (file->f_op->write_iter) {
 		struct kvec iov = { .iov_base = (void *)buf, .iov_len = count };
 		struct kiocb kiocb;
 		struct iov_iter iter;
@@ -551,6 +552,8 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
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


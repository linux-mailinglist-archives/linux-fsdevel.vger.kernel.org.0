Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103A7211454
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgGAUXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgGAUXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC252C08C5C1;
        Wed,  1 Jul 2020 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AMUoLivWZuA3+wprwQgqPl1GkuW85pQru1KNBzjWe6M=; b=C+qtwkVpeY0lP+I/13hzMzGHuc
        qVSTIbwKd4JzlQOxa3W6gL4WrmsyeFvNRbh5Rh2xBo6Xzv3TrUeAFo2CSFCjdhvhL37BNz0d0My3/
        h97YrhjvUEqAbZ/JWT4CIFLERiQH2r+uMooKBUHwyc4yNlp2610+q3XgBHIW5e+uH+oIw6ldFyI25
        1GocQCbxlcMnYzVPtBUrfq5ar+/uNWTgQhBONxL8viqUeNRhHWHKptBNkE9eA3zJl7cAC69r0FsVL
        rpH3Bu7BsilztHNjBPn1Xo2tOiXhr23cz/Vs/8jXmyBleVEifK3YfOpt7A7Dm7vdOEokG7NaoPy5W
        NrSguVKA==;
Received: from [2001:4bb8:18c:3b3b:379a:a079:66b5:89c3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjGO-0002Tm-Ot; Wed, 01 Jul 2020 20:23:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 21/23] fs: don't allow kernel reads and writes without iter ops
Date:   Wed,  1 Jul 2020 22:09:49 +0200
Message-Id: <20200701200951.3603160-22-hch@lst.de>
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

Don't allow calling ->read or ->write with set_fs as a preparation for
killing off set_fs.  While I've not triggered any of these cases in my
setups as all the usual suspect (file systems, pipes, sockets, block
devices, system character devices) use the iter ops this is almost
going to be guaranteed to eventuall break something, so print a detailed
error message helping to debug such cases.  The fix will be to switch the
affected driver to use the iter ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 7550c195a6a10e..2a2e4efed47395 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -420,6 +420,13 @@ ssize_t iter_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos,
 	return ret;
 }
 
+static void warn_unsupported(struct file *file, const char *op)
+{
+	pr_warn_ratelimited(
+		"kernel %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
+		op, file, current->pid, current->comm);
+}
+
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
 	ssize_t ret;
@@ -431,13 +438,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
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
@@ -448,6 +449,8 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 		ret = file->f_op->read_iter(&kiocb, &iter);
 		*pos = kiocb.ki_pos;
 	} else {
+		if (file->f_op->read)
+			warn_unsupported(file, "read");
 		ret = -EINVAL;
 	}
 	if (ret > 0) {
@@ -532,14 +535,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
 
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
@@ -551,6 +547,8 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
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


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1136B2175A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgGGRxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgGGRxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:53:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2DC061755;
        Tue,  7 Jul 2020 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ikLDu9Sqnofb7uotDosNOhH64p/v3I5ZekNTOjjncWE=; b=f3wQLBn5jEdVdwA61niHFtDcYq
        HurwCJPCNykfmI4pqa6SJPG4Y4l9kfx3UO1Qq3gGPsYxFiGZp+RrLUkJt+jr4f2cSiAIhlmneDKHu
        JVvWx+XVrdW1hg+FqBX4Ak1SbFyq6EtYIfbMUaoI5z3K+0Ys0aqt3YwXcyMVdlimSAvUVCZS3mbKh
        G6mVv5H1r+aCwp31mA3uf1VrvNE9UucIZBQIF+a7wkof/Fd2NhJQGCEDe9bXgygNz5wVBp+6XwgSP
        myrSeWKwwtNAe9RazV3T34Lv2GgED2tQnBY+3efFSpAi08gdmS1bU0UbFCJfJtKN2oDBJubIWePzZ
        +2l+3h/A==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrm5-0003kX-Pj; Tue, 07 Jul 2020 17:52:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 21/23] fs: don't allow kernel reads and writes without iter ops
Date:   Tue,  7 Jul 2020 19:47:59 +0200
Message-Id: <20200707174801.4162712-22-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
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
index 8bec4418543994..11c55547cfc9d6 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -419,6 +419,13 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
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
@@ -430,13 +437,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
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
@@ -447,6 +448,8 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 		ret = file->f_op->read_iter(&kiocb, &iter);
 		*pos = kiocb.ki_pos;
 	} else {
+		if (file->f_op->read)
+			warn_unsupported(file, "read");
 		ret = -EINVAL;
 	}
 	if (ret > 0) {
@@ -530,14 +533,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
 
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
@@ -549,6 +545,8 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
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


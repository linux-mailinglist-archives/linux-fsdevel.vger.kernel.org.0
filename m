Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA4720ADB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 10:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgFZH7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 03:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgFZH7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:59:00 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC8C08C5C1;
        Fri, 26 Jun 2020 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sTsOMUcnMDqLSD97+IRNpD3MR/vvaG/xJH7og4zU1hM=; b=tgisD/XYQQc8TIeX5GjRVV5EBg
        oxK0u7npEgEPc0UtjdZMbSm2M+G17NrPZSoSdZVGx2z4Zeu8x3Z794InO1EK8Syr0dqlNPB53R8TE
        XJbLfxjICiCWl02epcH258gcvZzJOXkXxtadiftIjkoKV+/jbMVl2WBnkAWOMA03BWYCKDIG8vD73
        E1ePzdpkDPpV8EUBTuTQikVKPweac1DEmJv9TbEbwLLLqlHPoY4ZCO2H+i78FqQpjg24rb3Gys+Mp
        iAgx4fURFqnGEr5LQSv/EMycoKy/J82AdT2uM0aWdnP/x12vmcpBk+bCFbV657wbov6JMFXaWHcVM
        9WioEHRA==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojFy-0006zL-8M; Fri, 26 Jun 2020 07:58:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] seq_file: add seq_read_iter
Date:   Fri, 26 Jun 2020 09:58:30 +0200
Message-Id: <20200626075836.1998185-4-hch@lst.de>
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

iov_iter based variant for reading a seq_file.  seq_read is
reimplemented on top of the iter variant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/seq_file.c            | 34 +++++++++++++++++++++-------------
 include/linux/seq_file.h |  1 +
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 4e6239f33c066a..159a3e12cadd30 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/printk.h>
 #include <linux/string_helpers.h>
+#include <linux/uio.h>
 
 #include <linux/uaccess.h>
 #include <asm/page.h>
@@ -146,7 +147,17 @@ static int traverse(struct seq_file *m, loff_t offset)
  */
 ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 {
-	struct seq_file *m = file->private_data;
+	return iter_read(file, buf, size, ppos, seq_read_iter);
+}
+EXPORT_SYMBOL(seq_read);
+
+/*
+ * Ready-made ->f_op->read_iter()
+ */
+ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct seq_file *m = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(iter);
 	size_t copied = 0;
 	size_t n;
 	void *p;
@@ -158,14 +169,14 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	 * if request is to read from zero offset, reset iterator to first
 	 * record as it might have been already advanced by previous requests
 	 */
-	if (*ppos == 0) {
+	if (iocb->ki_pos == 0) {
 		m->index = 0;
 		m->count = 0;
 	}
 
-	/* Don't assume *ppos is where we left it */
-	if (unlikely(*ppos != m->read_pos)) {
-		while ((err = traverse(m, *ppos)) == -EAGAIN)
+	/* Don't assume ki_pos is where we left it */
+	if (unlikely(iocb->ki_pos != m->read_pos)) {
+		while ((err = traverse(m, iocb->ki_pos)) == -EAGAIN)
 			;
 		if (err) {
 			/* With prejudice... */
@@ -174,7 +185,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 			m->count = 0;
 			goto Done;
 		} else {
-			m->read_pos = *ppos;
+			m->read_pos = iocb->ki_pos;
 		}
 	}
 
@@ -187,13 +198,11 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	/* if not empty - flush it first */
 	if (m->count) {
 		n = min(m->count, size);
-		err = copy_to_user(buf, m->buf + m->from, n);
-		if (err)
+		if (copy_to_iter(m->buf + m->from, n, iter) != n)
 			goto Efault;
 		m->count -= n;
 		m->from += n;
 		size -= n;
-		buf += n;
 		copied += n;
 		if (!size)
 			goto Done;
@@ -254,8 +263,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	}
 	m->op->stop(m, p);
 	n = min(m->count, size);
-	err = copy_to_user(buf, m->buf, n);
-	if (err)
+	if (copy_to_iter(m->buf, n, iter) != n)
 		goto Efault;
 	copied += n;
 	m->count -= n;
@@ -264,7 +272,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	if (!copied)
 		copied = err;
 	else {
-		*ppos += copied;
+		iocb->ki_pos += copied;
 		m->read_pos += copied;
 	}
 	mutex_unlock(&m->lock);
@@ -276,7 +284,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	err = -EFAULT;
 	goto Done;
 }
-EXPORT_SYMBOL(seq_read);
+EXPORT_SYMBOL(seq_read_iter);
 
 /**
  *	seq_lseek -	->llseek() method for sequential files.
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 813614d4b71fbc..b83b3ae3c877f3 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -107,6 +107,7 @@ void seq_pad(struct seq_file *m, char c);
 char *mangle_path(char *s, const char *p, const char *esc);
 int seq_open(struct file *, const struct seq_operations *);
 ssize_t seq_read(struct file *, char __user *, size_t, loff_t *);
+ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 loff_t seq_lseek(struct file *, loff_t, int);
 int seq_release(struct inode *, struct file *);
 int seq_write(struct seq_file *seq, const void *data, size_t len);
-- 
2.26.2


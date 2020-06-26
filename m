Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308C220ADAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgFZH7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 03:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgFZH7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:59:04 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39920C08C5DD;
        Fri, 26 Jun 2020 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TyROtKbkl/S72kKI7NWbc07Mk35NEfDXXPiptw56KLM=; b=Dzj8ZOUaqaAXhqkLKGWlY0NjCF
        kQq+ASDC8tmPb+CZSAMDq0cTXACs2X88pQCHnJ9SMGKj/1ZVMv/3Kpeyb9dBKYcAZPJVOpbDgClgp
        OtxGz6+CL/sVv9wFlrmTsqRpzeOd3cW+BNlqA1AifUpTy+qlXrqj7Y/+zPCQrJELTXAe+4Mj07aFO
        hIABMonISYKdX6afWVB7qL0DkBf1DlEWSuYJZNcrTGqB3iy0/RCvk0+H9Tr6uyS1iOm25Chh+8seq
        AYOm+mur/djO3gawBbPmugm57dmK4yTYsjoj26asr4AvE97GGbZeAVaGbO5qcannlKaUugUHKR9CS
        ZkGS7BEg==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojG5-00071o-Op; Fri, 26 Jun 2020 07:58:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 9/9] fs: don't allow splice read/write without explicit ops
Date:   Fri, 26 Jun 2020 09:58:36 +0200
Message-Id: <20200626075836.1998185-10-hch@lst.de>
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
 fs/splice.c | 117 +++++++++++-----------------------------------------
 1 file changed, 24 insertions(+), 93 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index d1efc53875bd93..f93bbfc131d5ec 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -342,66 +342,6 @@ const struct pipe_buf_operations nosteal_pipe_buf_ops = {
 };
 EXPORT_SYMBOL(nosteal_pipe_buf_ops);
 
-static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
-				 struct pipe_inode_info *pipe, size_t len,
-				 unsigned int flags)
-{
-	struct iov_iter to;
-	struct page **pages;
-	unsigned int nr_pages;
-	unsigned int mask;
-	size_t offset, base, copied = 0;
-	loff_t pos;
-	ssize_t res;
-	int i;
-
-	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
-		return -EAGAIN;
-
-	res = rw_verify_area(READ, in, ppos, len);
-	if (res < 0)
-		return res;
-
-	/*
-	 * Try to keep page boundaries matching to source pagecache ones -
-	 * it probably won't be much help, but...
-	 */
-	offset = *ppos & ~PAGE_MASK;
-
-	iov_iter_pipe(&to, READ, pipe, len + offset);
-
-	res = iov_iter_get_pages_alloc(&to, &pages, len + offset, &base);
-	if (res <= 0)
-		return -ENOMEM;
-
-	mask = pipe->ring_size - 1;
-	pipe->bufs[to.head & mask].offset = offset;
-	pipe->bufs[to.head & mask].len -= offset;
-
-	nr_pages = DIV_ROUND_UP(res + base, PAGE_SIZE);
-
-	pos = *ppos;
-	for (i = 0; i < nr_pages; i++) {
-		size_t this_len = min_t(size_t, len, PAGE_SIZE - offset);
-
-		res = __kernel_read(in, page_address(pages[i]) + offset,
-				this_len, &pos);
-		if (res < 0)
-			goto out;
-		len -= this_len;
-		offset = 0;
-	}
-	copied = pos - *ppos;
-	*ppos = pos;
-
-out:
-	for (i = 0; i < nr_pages; i++)
-		put_page(pages[i]);
-	kvfree(pages);
-	iov_iter_advance(&to, copied);	/* truncates and discards */
-	return res;
-}
-
 /*
  * Send 'sd->len' bytes to socket from 'sd->file' at position 'sd->pos'
  * using sendpage(). Return the number of bytes sent.
@@ -765,33 +705,6 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 EXPORT_SYMBOL(iter_file_splice_write);
 
-static int write_pipe_buf(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
-			  struct splice_desc *sd)
-{
-	int ret;
-	void *data;
-	loff_t tmp = sd->pos;
-
-	data = kmap(buf->page);
-	ret = __kernel_write(sd->u.file, data + buf->offset, sd->len, &tmp);
-	kunmap(buf->page);
-
-	return ret;
-}
-
-static ssize_t default_file_splice_write(struct pipe_inode_info *pipe,
-					 struct file *out, loff_t *ppos,
-					 size_t len, unsigned int flags)
-{
-	ssize_t ret;
-
-	ret = splice_from_pipe(pipe, out, ppos, len, flags, write_pipe_buf);
-	if (ret > 0)
-		*ppos += ret;
-
-	return ret;
-}
-
 /**
  * generic_splice_sendpage - splice data from a pipe to a socket
  * @pipe:	pipe to splice from
@@ -813,15 +726,30 @@ ssize_t generic_splice_sendpage(struct pipe_inode_info *pipe, struct file *out,
 
 EXPORT_SYMBOL(generic_splice_sendpage);
 
+static void warn_unsupported(struct file *file, const char *op)
+{
+	char pathname[128], *path;
+
+	path = file_path(file, pathname, sizeof(pathname));
+	if (IS_ERR(path))
+		path = "(unknown)";
+	pr_warn_ratelimited(
+		"splice %s not supported for file %s (pid: %d comm: %.20s)\n",
+		op, path, current->pid, current->comm);
+}
+
 /*
  * Attempt to initiate a splice from pipe to file.
  */
 static long do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 			   loff_t *ppos, size_t len, unsigned int flags)
 {
-	if (out->f_op->splice_write)
-		return out->f_op->splice_write(pipe, out, ppos, len, flags);
-	return default_file_splice_write(pipe, out, ppos, len, flags);
+	if (!out->f_op->splice_write) {
+		warn_unsupported(out, "write");
+		return -EINVAL;
+	}
+
+	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
 /*
@@ -843,9 +771,12 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 	if (unlikely(len > MAX_RW_COUNT))
 		len = MAX_RW_COUNT;
 
-	if (in->f_op->splice_read)
-		return in->f_op->splice_read(in, ppos, pipe, len, flags);
-	return default_file_splice_read(in, ppos, pipe, len, flags);
+	if (!in->f_op->splice_read) {
+		warn_unsupported(in, "read");
+		return -EINVAL;
+	}
+
+	return in->f_op->splice_read(in, ppos, pipe, len, flags);
 }
 
 /**
-- 
2.26.2


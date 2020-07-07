Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6552175B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgGGR51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgGGR51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:57:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F92C061755;
        Tue,  7 Jul 2020 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Weuro944qoHsBvfyYbAkCMwQQQFAVhE01qJV6uQvAx8=; b=qEUvpwxLV9Ae+jesGCTc8ddeVN
        jGipuy3RunNhHETYZHOmVHp5QJdHPMfa4ANtLhcKnGmjgJCvdZ66O6kxxuuxgtTEaAFIxgb7F2PHT
        sbugZOIJv06LBO6lUw6NEwFsTuejwARoWEo2q+u6t+q+nmJ+pig5LXrTBj0Vr2KjeqViACGMZbUpj
        9iIgKq64i99ET+EkzHUOcChRV77Uw0JHFVhLNuJnsyn1aAeBT5Tudzb55y0K5hbY0rspbagi7BAGb
        2zk/jttD7JQxE6OhHw4IBKglDFZ1g0QpQZWkYtav2MIUxjqixFt9+l70ZAxGtz1gA7l6jyHH1nF2z
        mXiUX7RQ==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrqJ-0003xp-LF; Tue, 07 Jul 2020 17:57:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/23] fs: don't allow splice read/write without explicit ops
Date:   Tue,  7 Jul 2020 19:48:01 +0200
Message-Id: <20200707174801.4162712-24-hch@lst.de>
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
 fs/read_write.c    |   2 +-
 fs/splice.c        | 121 ++++-----------------------------------------
 include/linux/fs.h |   2 -
 3 files changed, 10 insertions(+), 115 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 8d8113ae8561e6..c33182f97d1ef0 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1077,7 +1077,7 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 }
 EXPORT_SYMBOL(vfs_iter_write);
 
-ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
+static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 		  unsigned long vlen, loff_t *pos, rwf_t flags)
 {
 	struct iovec iovstack[UIO_FASTIOV];
diff --git a/fs/splice.c b/fs/splice.c
index 52485158023778..3ceaaf3b8c122c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -342,89 +342,6 @@ const struct pipe_buf_operations nosteal_pipe_buf_ops = {
 };
 EXPORT_SYMBOL(nosteal_pipe_buf_ops);
 
-static ssize_t kernel_readv(struct file *file, const struct kvec *vec,
-			    unsigned long vlen, loff_t offset)
-{
-	mm_segment_t old_fs;
-	loff_t pos = offset;
-	ssize_t res;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	/* The cast to a user pointer is valid due to the set_fs() */
-	res = vfs_readv(file, (const struct iovec __user *)vec, vlen, &pos, 0);
-	set_fs(old_fs);
-
-	return res;
-}
-
-static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
-				 struct pipe_inode_info *pipe, size_t len,
-				 unsigned int flags)
-{
-	struct kvec *vec, __vec[PIPE_DEF_BUFFERS];
-	struct iov_iter to;
-	struct page **pages;
-	unsigned int nr_pages;
-	unsigned int mask;
-	size_t offset, base, copied = 0;
-	ssize_t res;
-	int i;
-
-	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
-		return -EAGAIN;
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
-	nr_pages = DIV_ROUND_UP(res + base, PAGE_SIZE);
-
-	vec = __vec;
-	if (nr_pages > PIPE_DEF_BUFFERS) {
-		vec = kmalloc_array(nr_pages, sizeof(struct kvec), GFP_KERNEL);
-		if (unlikely(!vec)) {
-			res = -ENOMEM;
-			goto out;
-		}
-	}
-
-	mask = pipe->ring_size - 1;
-	pipe->bufs[to.head & mask].offset = offset;
-	pipe->bufs[to.head & mask].len -= offset;
-
-	for (i = 0; i < nr_pages; i++) {
-		size_t this_len = min_t(size_t, len, PAGE_SIZE - offset);
-		vec[i].iov_base = page_address(pages[i]) + offset;
-		vec[i].iov_len = this_len;
-		len -= this_len;
-		offset = 0;
-	}
-
-	res = kernel_readv(in, vec, nr_pages, *ppos);
-	if (res > 0) {
-		copied = res;
-		*ppos += res;
-	}
-
-	if (vec != __vec)
-		kfree(vec);
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
@@ -788,33 +705,6 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
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
@@ -844,7 +734,10 @@ static long do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 {
 	if (out->f_op->splice_write)
 		return out->f_op->splice_write(pipe, out, ppos, len, flags);
-	return default_file_splice_write(pipe, out, ppos, len, flags);
+	pr_warn_ratelimited(
+		"splice write not supported for file %pD4 (pid: %d comm: %.20s)\n",
+		out, current->pid, current->comm);
+	return -EINVAL;
 }
 
 /*
@@ -870,7 +763,11 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 		return in->f_op->splice_read(in, ppos, pipe, len, flags);
 	if (in->f_op->read_iter)
 		return generic_file_splice_read(in, ppos, pipe, len, flags);
-	return default_file_splice_read(in, ppos, pipe, len, flags);
+
+	pr_warn_ratelimited(
+		"splice read not supported for file %pD4 (pid: %d comm: %.20s)\n",
+		in, current->pid, current->comm);
+	return -EINVAL;
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0c0ec76b600b50..fac6aead402a98 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1919,8 +1919,6 @@ ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
 
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
-extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
-		unsigned long, loff_t *, rwf_t);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
 extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
-- 
2.26.2


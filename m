Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0779A254896
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgH0PJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgH0PAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:00:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B489AC061232;
        Thu, 27 Aug 2020 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qdxrwOFViywP/5XuzkfTTZlvXDJmaru1paUb7ZwS2hs=; b=HOnxeUy17i24/revnqoDslYl3g
        RyseqUhtzK3Wt4ScXjBi9wxyZvRY21MDDTqIsCWpBW/wp7J9m+yeJ06gCbEJCygv1dzjXlgeSxaa/
        XSTGEfCb0wfE6cw1431A/DnhLyjw/YUo9fHUX1BEzweg3m7VpzihX4Lw9S32zBTAPBnjhDQ2vCPRZ
        QPV39sDGsS2u1uVhlQmC9+Tbh+2K2KisNetDIN/NCdgmprR5Bgfkn/yPLIGOBXUasNoAoZZHCNY76
        o5Bvig8Xe47I5VvYDjf97aTbioX1ywX84meC8pqhE/uSpvEP1uM13OmRX5GxLkSEn6Z2ZieAChs8B
        /Q/9kDWA==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJOE-00044X-Ki; Thu, 27 Aug 2020 15:00:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/10] fs: don't allow splice read/write without explicit ops
Date:   Thu, 27 Aug 2020 17:00:22 +0200
Message-Id: <20200827150030.282762-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827150030.282762-1-hch@lst.de>
References: <20200827150030.282762-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

default_file_splice_write is the last piece of generic code that uses
set_fs to make the uaccess routines operate on kernel pointers.  It
implements a "fallback loop" for splicing from files that do not actually
provide a proper splice_read method.  The usual file systems and other
high bandwith instances all provide a ->splice_read, so this just removes
support for various device drivers and procfs/debugfs files.  If splice
support for any of those turns out to be important it can be added back
by switching them to the iter ops and using generic_file_splice_read.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/read_write.c    |   2 +-
 fs/splice.c        | 130 +++++----------------------------------------
 include/linux/fs.h |   2 -
 3 files changed, 15 insertions(+), 119 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 702c4301d9eb6b..8c61f67453e3d3 100644
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
index d7c8a7c4db07ff..412df7b48f9eb7 100644
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
@@ -836,15 +726,23 @@ ssize_t generic_splice_sendpage(struct pipe_inode_info *pipe, struct file *out,
 
 EXPORT_SYMBOL(generic_splice_sendpage);
 
+static int warn_unsupported(struct file *file, const char *op)
+{
+	pr_debug_ratelimited(
+		"splice %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
+		op, file, current->pid, current->comm);
+	return -EINVAL;
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
+	if (unlikely(!out->f_op->splice_write))
+		return warn_unsupported(out, "write");
+	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
 /*
@@ -866,9 +764,9 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 	if (unlikely(len > MAX_RW_COUNT))
 		len = MAX_RW_COUNT;
 
-	if (in->f_op->splice_read)
-		return in->f_op->splice_read(in, ppos, pipe, len, flags);
-	return default_file_splice_read(in, ppos, pipe, len, flags);
+	if (unlikely(!in->f_op->splice_read))
+		return warn_unsupported(in, "read");
+	return in->f_op->splice_read(in, ppos, pipe, len, flags);
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e019ea2f1347e6..d33cc3e8ed410b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1894,8 +1894,6 @@ ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
 
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
-extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
-		unsigned long, loff_t *, rwf_t);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
 extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
-- 
2.28.0


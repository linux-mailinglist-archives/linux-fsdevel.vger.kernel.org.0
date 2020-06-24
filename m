Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A70920789A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404891AbgFXQOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404546AbgFXQOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:17 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB53C061573;
        Wed, 24 Jun 2020 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ohADaDX1EpLOvE9FiJrzT1hC9HlZKskrAoteovdnv8Q=; b=JRsce6Lcb5oIozkhzRENHz5Ekk
        lDJ/bQ6cpPOcTd/B1ynXK7B05dowJcgKg17O9GCyjMdUfrK54Tt9NAYSUioBYAzy44EG5lIfW2eVu
        XrsnW2eBSoJrNcgfsXfKD37ascFXJ0Wws+cb2bmMR8NxKowiNwSt406tbB5SVZaajaPqTYebXBx/E
        B4LaeLrw8obJRgWyAQL2yQrtf+SWKKBhxuSDdM96wCO0WBECiR61PeJI12G8qo6Q5AAIi3QRu8bLV
        Z4zrTH3xbxkQE67XTLws/d4zW5URKfX+90uf/BFTz6nMJ0idA5kcG0e1rXU5xXN73/8LQ5tUX2XCF
        KA6hmm7g==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo825-0005zP-1s; Wed, 24 Jun 2020 16:13:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 13/14] fs: implement default_file_splice_read using __kernel_read
Date:   Wed, 24 Jun 2020 18:13:34 +0200
Message-Id: <20200624161335.1810359-14-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624161335.1810359-1-hch@lst.de>
References: <20200624161335.1810359-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

default_file_splice_read goes through great lenght to create an
iovec array and iov_iter for all the reads, but is a helper only
useful for files not implementing ->read_iter as we have the much
better generic_file_splice_read version available for those.  Remove
the iters and just call __kernel_read in a loop instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c    |  2 +-
 fs/splice.c        | 53 +++++++++++++---------------------------------
 include/linux/fs.h |  2 --
 3 files changed, 16 insertions(+), 41 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 6a2170eaee64f9..1c41c25e548d8c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1070,7 +1070,7 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 }
 EXPORT_SYMBOL(vfs_iter_write);
 
-ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
+static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 		  unsigned long vlen, loff_t *pos, rwf_t flags)
 {
 	struct iovec iovstack[UIO_FASTIOV];
diff --git a/fs/splice.c b/fs/splice.c
index d7c8a7c4db07ff..d1efc53875bd93 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -342,38 +342,26 @@ const struct pipe_buf_operations nosteal_pipe_buf_ops = {
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
 static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 				 struct pipe_inode_info *pipe, size_t len,
 				 unsigned int flags)
 {
-	struct kvec *vec, __vec[PIPE_DEF_BUFFERS];
 	struct iov_iter to;
 	struct page **pages;
 	unsigned int nr_pages;
 	unsigned int mask;
 	size_t offset, base, copied = 0;
+	loff_t pos;
 	ssize_t res;
 	int i;
 
 	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 		return -EAGAIN;
 
+	res = rw_verify_area(READ, in, ppos, len);
+	if (res < 0)
+		return res;
+
 	/*
 	 * Try to keep page boundaries matching to source pagecache ones -
 	 * it probably won't be much help, but...
@@ -386,37 +374,26 @@ static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 	if (res <= 0)
 		return -ENOMEM;
 
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
 	mask = pipe->ring_size - 1;
 	pipe->bufs[to.head & mask].offset = offset;
 	pipe->bufs[to.head & mask].len -= offset;
 
+	nr_pages = DIV_ROUND_UP(res + base, PAGE_SIZE);
+
+	pos = *ppos;
 	for (i = 0; i < nr_pages; i++) {
 		size_t this_len = min_t(size_t, len, PAGE_SIZE - offset);
-		vec[i].iov_base = page_address(pages[i]) + offset;
-		vec[i].iov_len = this_len;
+
+		res = __kernel_read(in, page_address(pages[i]) + offset,
+				this_len, &pos);
+		if (res < 0)
+			goto out;
 		len -= this_len;
 		offset = 0;
 	}
+	copied = pos - *ppos;
+	*ppos = pos;
 
-	res = kernel_readv(in, vec, nr_pages, *ppos);
-	if (res > 0) {
-		copied = res;
-		*ppos += res;
-	}
-
-	if (vec != __vec)
-		kfree(vec);
 out:
 	for (i = 0; i < nr_pages; i++)
 		put_page(pages[i]);
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


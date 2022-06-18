Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1355502F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiFRFfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiFRFfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB367D1A
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WQWdiv52D11k7TzPEVaCeGkXYqbZAFkluK82fRXa4uU=; b=C62sXVCeWnCSNNQ+ou7mf8Wv1k
        HjKKkQQ5cq42iyL1abT945z7qjDNcl90zxzlYhSUk4GhGEWNfXcyxgRYT1STh/ywojTls0eXDmB3Y
        EiikUMvixrtIQYstTrUv0wiq+gOEOai7MnN/lP4wUYWXCsOn31naTZQNmQoPAq5687doQ6GVv9PBx
        mQ3ze1JRm8cAYSU0QsdyVN8NmkfYKB+ek3VBfduymMJdHwDjR/HCX/Yo8wnZp4sUrUN8em+ogf2Nm
        QDKiZ35WMIgc6ZSv3+pz4OC6fmMjKgyrRKGIq/hTeJpTzFLIvjUNjjGLKxHxdJXXrXQcoic5KFqhB
        VLCF5weg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7U-001VQA-F8;
        Sat, 18 Jun 2022 05:35:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 10/31] ITER_PIPE: fold data_start() and pipe_space_for_user() together
Date:   Sat, 18 Jun 2022 06:35:17 +0100
Message-Id: <20220618053538.359065-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618053538.359065-1-viro@zeniv.linux.org.uk>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All their callers are next to each other; all of them
want the total amount of pages and, possibly, the
offset in the partial final buffer.

Combine into a new helper (pipe_npages()), fix the
bogosity in pipe_space_for_user(), while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/pipe_fs_i.h | 20 ------------------
 lib/iov_iter.c            | 44 +++++++++++++++++----------------------
 2 files changed, 19 insertions(+), 45 deletions(-)

diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 4ea496924106..6cb65df3e3ba 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -156,26 +156,6 @@ static inline bool pipe_full(unsigned int head, unsigned int tail,
 	return pipe_occupancy(head, tail) >= limit;
 }
 
-/**
- * pipe_space_for_user - Return number of slots available to userspace
- * @head: The pipe ring head pointer
- * @tail: The pipe ring tail pointer
- * @pipe: The pipe info structure
- */
-static inline unsigned int pipe_space_for_user(unsigned int head, unsigned int tail,
-					       struct pipe_inode_info *pipe)
-{
-	unsigned int p_occupancy, p_space;
-
-	p_occupancy = pipe_occupancy(head, tail);
-	if (p_occupancy >= pipe->max_usage)
-		return 0;
-	p_space = pipe->ring_size - p_occupancy;
-	if (p_space > pipe->max_usage)
-		p_space = pipe->max_usage;
-	return p_space;
-}
-
 /**
  * pipe_buf_get - get a reference to a pipe_buffer
  * @pipe:	the pipe that the buffer belongs to
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f6e5c20ed1c8..3abd1c596520 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -435,18 +435,20 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_init);
 
-static inline void data_start(const struct iov_iter *i,
-			      unsigned int *iter_headp, size_t *offp)
+// returns the offset in partial buffer (if any)
+static inline unsigned int pipe_npages(const struct iov_iter *i, int *npages)
 {
+	struct pipe_inode_info *pipe = i->pipe;
+	int used = pipe->head - pipe->tail;
 	int off = i->last_offset;
 
+	*npages = max(used - (int)pipe->max_usage, 0);
+
 	if (off > 0 && off < PAGE_SIZE) { // anon and not full
-		*iter_headp = i->pipe->head - 1;
-		*offp = off;
-	} else {
-		*iter_headp = i->pipe->head;
-		*offp = 0;
+		(*npages)++;
+		return off;
 	}
+	return 0;
 }
 
 static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
@@ -1221,18 +1223,16 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
-	unsigned int iter_head, npages;
+	unsigned int npages, off;
 	size_t capacity;
 
 	if (!sanity(i))
 		return -EFAULT;
 
-	data_start(i, &iter_head, start);
-	/* Amount of free space: some of this one + all after this one */
-	npages = pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
-	capacity = min(npages, maxpages) * PAGE_SIZE - *start;
+	*start = off = pipe_npages(i, &npages);
+	capacity = min(npages, maxpages) * PAGE_SIZE - off;
 
-	return __pipe_get_pages(i, min(maxsize, capacity), pages, *start);
+	return __pipe_get_pages(i, min(maxsize, capacity), pages, off);
 }
 
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
@@ -1411,24 +1411,22 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 		   size_t *start)
 {
 	struct page **p;
-	unsigned int iter_head, npages;
+	unsigned int npages, off;
 	ssize_t n;
 
 	if (!sanity(i))
 		return -EFAULT;
 
-	data_start(i, &iter_head, start);
-	/* Amount of free space: some of this one + all after this one */
-	npages = pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
-	n = npages * PAGE_SIZE - *start;
+	*start = off = pipe_npages(i, &npages);
+	n = npages * PAGE_SIZE - off;
 	if (maxsize > n)
 		maxsize = n;
 	else
-		npages = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
+		npages = DIV_ROUND_UP(maxsize + off, PAGE_SIZE);
 	p = get_pages_array(npages);
 	if (!p)
 		return -ENOMEM;
-	n = __pipe_get_pages(i, maxsize, p, *start);
+	n = __pipe_get_pages(i, maxsize, p, off);
 	if (n > 0)
 		*pages = p;
 	else
@@ -1653,16 +1651,12 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 	if (iov_iter_is_bvec(i))
 		return bvec_npages(i, maxpages);
 	if (iov_iter_is_pipe(i)) {
-		unsigned int iter_head;
 		int npages;
-		size_t off;
 
 		if (!sanity(i))
 			return 0;
 
-		data_start(i, &iter_head, &off);
-		/* some of this one + all after this one */
-		npages = pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
+		pipe_npages(i, &npages);
 		return min(npages, maxpages);
 	}
 	if (iov_iter_is_xarray(i)) {
-- 
2.30.2


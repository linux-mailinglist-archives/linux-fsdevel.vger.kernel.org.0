Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D505554171
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356900AbiFVEQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356719AbiFVEP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9E97649
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SioEB4rnR/C8LeMY2GFKseUarMvAD/W/8gnG3v9/ARk=; b=jPC9SlWs1uIF8BN4sMfooMAlUL
        18jpJiKI4bhxnvCX2H8IAZsY0IBwPIYRmG2CBstoV4Ipdg2YkjRT2OMZmkvroD66H/9WIrprBmiLZ
        hxqP/1NhAP0BUiEyQ2If5G/4+145vWiRJRSec1lDZVhcBg+DzFVGDQjpSZ3OGdzxzyBoeM8CptuTA
        WxNWy00PsBgKVAa2lxhcg4SFEnIkUnl66GiRv85z4exn10zOhoWx0RnHhmEC6+NMqdmm+MIZamDPq
        2tejWUMH+pMgFTsPtvHNJtz48DEGm0YzqmabZirwpTSkCR7amVnU641IhjNDx7/+hlkAIXv1Qt2u5
        xP8qMdJA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmV-0035wu-8e;
        Wed, 22 Jun 2022 04:15:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 17/44] ITER_PIPE: fold push_pipe() into __pipe_get_pages()
Date:   Wed, 22 Jun 2022 05:15:25 +0100
Message-Id: <20220622041552.737754-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
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

	Expand the only remaining call of push_pipe() (in
__pipe_get_pages()), combine it with the page-collecting loop there.

Note that the only reason it's not a loop doing append_pipe() is
that append_pipe() is advancing, while iov_iter_get_pages() is not.
As soon as it switches to saner semantics, this thing will switch
to using append_pipe().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 80 ++++++++++++++++----------------------------------
 1 file changed, 25 insertions(+), 55 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2a445261096e..a507eed67839 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -449,46 +449,6 @@ static inline void data_start(const struct iov_iter *i,
 	*offp = off;
 }
 
-static size_t push_pipe(struct iov_iter *i, size_t size,
-			int *iter_headp, size_t *offp)
-{
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int iter_head;
-	size_t off;
-	ssize_t left;
-
-	if (unlikely(size > i->count))
-		size = i->count;
-	if (unlikely(!size))
-		return 0;
-
-	left = size;
-	data_start(i, &iter_head, &off);
-	*iter_headp = iter_head;
-	*offp = off;
-	if (off) {
-		struct pipe_buffer *buf = pipe_buf(pipe, iter_head);
-
-		left -= PAGE_SIZE - off;
-		if (left <= 0) {
-			buf->len += size;
-			return size;
-		}
-		buf->len = PAGE_SIZE;
-	}
-	while (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
-		struct page *page = push_anon(pipe,
-					      min_t(ssize_t, left, PAGE_SIZE));
-		if (!page)
-			break;
-
-		left -= PAGE_SIZE;
-		if (left <= 0)
-			return size;
-	}
-	return size - left;
-}
-
 static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
 				struct iov_iter *i)
 {
@@ -1261,23 +1221,33 @@ static inline ssize_t __pipe_get_pages(struct iov_iter *i,
 				size_t maxsize,
 				struct page **pages,
 				int iter_head,
-				size_t *start)
+				size_t off)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int p_mask = pipe->ring_size - 1;
-	ssize_t n = push_pipe(i, maxsize, &iter_head, start);
-	if (!n)
-		return -EFAULT;
+	ssize_t left = maxsize;
 
-	maxsize = n;
-	n += *start;
-	while (n > 0) {
-		get_page(*pages++ = pipe->bufs[iter_head & p_mask].page);
-		iter_head++;
-		n -= PAGE_SIZE;
-	}
+	if (off) {
+		struct pipe_buffer *buf = pipe_buf(pipe, iter_head);
 
-	return maxsize;
+		get_page(*pages++ = buf->page);
+		left -= PAGE_SIZE - off;
+		if (left <= 0) {
+			buf->len += maxsize;
+			return maxsize;
+		}
+		buf->len = PAGE_SIZE;
+	}
+	while (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
+		struct page *page = push_anon(pipe,
+					      min_t(ssize_t, left, PAGE_SIZE));
+		if (!page)
+			break;
+		get_page(*pages++ = page);
+		left -= PAGE_SIZE;
+		if (left <= 0)
+			return maxsize;
+	}
+	return maxsize - left ? : -EFAULT;
 }
 
 static ssize_t pipe_get_pages(struct iov_iter *i,
@@ -1295,7 +1265,7 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	npages = pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
 	capacity = min(npages, maxpages) * PAGE_SIZE - *start;
 
-	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, start);
+	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, *start);
 }
 
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
@@ -1491,7 +1461,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	p = get_pages_array(npages);
 	if (!p)
 		return -ENOMEM;
-	n = __pipe_get_pages(i, maxsize, p, iter_head, start);
+	n = __pipe_get_pages(i, maxsize, p, iter_head, *start);
 	if (n > 0)
 		*pages = p;
 	else
-- 
2.30.2


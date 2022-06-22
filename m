Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68D1554170
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356966AbiFVEQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356782AbiFVEQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356DFB71
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QgK3buMcOnvqaTWUvnUNevAI1qrMq591PQ5BFWzu1no=; b=Fg6lglL3qpk3dSowdIyD4F21jL
        5F9llCksQduzejAHqZKwT7xO8GTyHkJhp6H4uJQwgGZDjj1A/6rx/AcoX1xxTJg5Zr/tGgtC3Qgs5
        r6EbeKfy25iGYyx53R/YSIGSI9RyTY0Y8do8CSzkPfQpshBVvdyozNmrklXrYKJGgc5zk1YkoQrtJ
        mCph1DYEhrf/eh+PxfhaTthdX8oiEc29O6c6oEz8ym5zlcyIXJJO+H8t9Oh3Fo/uBN7lgNgjuklFz
        gjuFC5gyZ0vDwlS48WPiUIXh9Nv2DVg7FMRLOvbMf7262QCGesxZo3P/MNJji4kMkJxbFhKJVMEEd
        fDJpk2XA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmV-0035xG-Mx;
        Wed, 22 Jun 2022 04:15:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 20/44] ITER_PIPE: clean iov_iter_revert()
Date:   Wed, 22 Jun 2022 05:15:28 +0100
Message-Id: <20220622041552.737754-20-viro@zeniv.linux.org.uk>
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

Fold pipe_truncate() into it, clean up.  We can release buffers
in the same loop where we walk backwards to the iterator beginning
looking for the place where the new position will be.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 60 ++++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 46 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6d693c1d189d..4e2b000b0466 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -818,32 +818,6 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 }
 EXPORT_SYMBOL(copy_page_from_iter_atomic);
 
-static inline void pipe_truncate(struct iov_iter *i)
-{
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int p_tail = pipe->tail;
-	unsigned int p_head = pipe->head;
-	unsigned int p_mask = pipe->ring_size - 1;
-
-	if (!pipe_empty(p_head, p_tail)) {
-		struct pipe_buffer *buf;
-		unsigned int i_head = i->head;
-		size_t off = i->iov_offset;
-
-		if (off) {
-			buf = &pipe->bufs[i_head & p_mask];
-			buf->len = off - buf->offset;
-			i_head++;
-		}
-		while (p_head != i_head) {
-			p_head--;
-			pipe_buf_release(pipe, &pipe->bufs[p_head & p_mask]);
-		}
-
-		pipe->head = p_head;
-	}
-}
-
 static void pipe_advance(struct iov_iter *i, size_t size)
 {
 	struct pipe_inode_info *pipe = i->pipe;
@@ -938,28 +912,22 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 	i->count += unroll;
 	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
-		unsigned int p_mask = pipe->ring_size - 1;
-		unsigned int i_head = i->head;
-		size_t off = i->iov_offset;
-		while (1) {
-			struct pipe_buffer *b = &pipe->bufs[i_head & p_mask];
-			size_t n = off - b->offset;
-			if (unroll < n) {
-				off -= unroll;
-				break;
-			}
-			unroll -= n;
-			if (!unroll && i_head == i->start_head) {
-				off = 0;
-				break;
+		unsigned int head = pipe->head;
+
+		while (head > i->start_head) {
+			struct pipe_buffer *b = pipe_buf(pipe, --head);
+			if (unroll < b->len) {
+				b->len -= unroll;
+				i->iov_offset = b->offset + b->len;
+				i->head = head;
+				return;
 			}
-			i_head--;
-			b = &pipe->bufs[i_head & p_mask];
-			off = b->offset + b->len;
+			unroll -= b->len;
+			pipe_buf_release(pipe, b);
+			pipe->head--;
 		}
-		i->iov_offset = off;
-		i->head = i_head;
-		pipe_truncate(i);
+		i->iov_offset = 0;
+		i->head = head;
 		return;
 	}
 	if (unlikely(iov_iter_is_discard(i)))
-- 
2.30.2


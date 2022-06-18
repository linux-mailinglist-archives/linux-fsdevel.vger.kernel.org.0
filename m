Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73CC5502F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiFRFft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiFRFfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF766CB8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8P1BbOdwQLHt5aHUNKtwwEUXBGJZwp7d9Fwtt2+Aw2U=; b=dV1qvVKKwkBTy15vvwFOCJ5jkN
        LWoMqlrsq3sqORQ/EQcoFyvFuDoGBhYlKMW2M4pyw3XYETRd0B4Mzs7BFs+aV3j563kTw6S2HGSan
        llyXU89C6I74UCenPEAdKUK4w/K3z6W+/xrd6z8qd47VLBC87m/eJHFvgk2JRxM1jYMcorcZFXgo+
        XWti5Hq7Hu/swgOs5EXoqeMxmCwXPJWBR12SJ+cZpXuh+ywK0sE+NDJKs21eSzR0dWosllQ1eKxlv
        yVY8aIvLZ9gdG1vKl0hlgXHOzmpXWg/Yl66c6wE7JwaFJHUNhUDxfv9TH+nYIpiCNvQzQUjV8+EPV
        QYeW7sWQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7T-001VPw-Uj;
        Sat, 18 Jun 2022 05:35:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 08/31] ITER_PIPE: clean iov_iter_revert()
Date:   Sat, 18 Jun 2022 06:35:14 +0100
Message-Id: <20220618053538.359065-8-viro@zeniv.linux.org.uk>
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

Fold pipe_truncate() into it, clean up.  We can release buffers
in the same loop where we walk backwards to the iterator beginning
looking for the place where the new position will be.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 60 ++++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 46 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index ce2ce5b0c600..62afba79e600 100644
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


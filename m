Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478D2554166
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356878AbiFVEQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356708AbiFVEP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781776582
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oWGScIUb1EoaRdhEi06bRMjVnArb0zdP4434VU2a+/c=; b=U6obfarIWWlpDiesiNPkHEn5D5
        mcVHnqBeIGccu5voNOeE3FugM7g+E7yBgpkNCpsuDDJPjOhKjyUg7j0sUgjNTSJf3pXDlZtBAIkeW
        jLjQ76BtdpJGQVA0lZrmfbvZvWfcFG6A164oKOJzAv5sfh+U5qhSx54YgeKRr9XbNg7LIlmrt/qFw
        IFa+pRxUWr+9IXOe1Udy5Co8UIAyBAoerZYi06nby+8QqCXlUIOqkfItSNTWoMyO9PfQcK0cJ9OtO
        BPPgBXQiXB1xSh4QbCCGPfEQIstx8H4EezZh8jsxGC16IgaTb7oZE3cIep7By/aQ37m0H0SoAmTMU
        278ePCrQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmU-0035wa-RD;
        Wed, 22 Jun 2022 04:15:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 14/44] ITER_PIPE: helper for getting pipe buffer by index
Date:   Wed, 22 Jun 2022 05:15:22 +0100
Message-Id: <20220622041552.737754-14-viro@zeniv.linux.org.uk>
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

pipe_buffer instances of a pipe are organized as a ring buffer,
with power-of-2 size.  Indices are kept *not* reduced modulo ring
size, so the buffer refered to by index N is
	pipe->bufs[N & (pipe->ring_size - 1)].

Ring size can change over the lifetime of a pipe, but not while
the pipe is locked.  So for any iov_iter primitives it's a constant.
Original conversion of pipes to this layout went overboard trying
to microoptimize that - calculating pipe->ring_size - 1, storing
it in a local variable and using through the function.  In some
cases it might be warranted, but most of the times it only
obfuscates what's going on in there.

Introduce a helper (pipe_buf(pipe, N)) that would encapsulate
that and use it in the obvious cases.  More will follow...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d00cc8971b5b..08bb393da677 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -183,13 +183,18 @@ static int copyin(void *to, const void __user *from, size_t n)
 	return n;
 }
 
+static inline struct pipe_buffer *pipe_buf(const struct pipe_inode_info *pipe,
+					   unsigned int slot)
+{
+	return &pipe->bufs[slot & (pipe->ring_size - 1)];
+}
+
 #ifdef PIPE_PARANOIA
 static bool sanity(const struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
 	unsigned int p_head = pipe->head;
 	unsigned int p_tail = pipe->tail;
-	unsigned int p_mask = pipe->ring_size - 1;
 	unsigned int p_occupancy = pipe_occupancy(p_head, p_tail);
 	unsigned int i_head = i->head;
 	unsigned int idx;
@@ -201,7 +206,7 @@ static bool sanity(const struct iov_iter *i)
 		if (unlikely(i_head != p_head - 1))
 			goto Bad;	// must be at the last buffer...
 
-		p = &pipe->bufs[i_head & p_mask];
+		p = pipe_buf(pipe, i_head);
 		if (unlikely(p->offset + p->len != i->iov_offset))
 			goto Bad;	// ... at the end of segment
 	} else {
@@ -386,11 +391,10 @@ static inline bool allocated(struct pipe_buffer *buf)
 static inline void data_start(const struct iov_iter *i,
 			      unsigned int *iter_headp, size_t *offp)
 {
-	unsigned int p_mask = i->pipe->ring_size - 1;
 	unsigned int iter_head = i->head;
 	size_t off = i->iov_offset;
 
-	if (off && (!allocated(&i->pipe->bufs[iter_head & p_mask]) ||
+	if (off && (!allocated(pipe_buf(i->pipe, iter_head)) ||
 		    off == PAGE_SIZE)) {
 		iter_head++;
 		off = 0;
@@ -1180,10 +1184,9 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 		return iov_iter_alignment_bvec(i);
 
 	if (iov_iter_is_pipe(i)) {
-		unsigned int p_mask = i->pipe->ring_size - 1;
 		size_t size = i->count;
 
-		if (size && i->iov_offset && allocated(&i->pipe->bufs[i->head & p_mask]))
+		if (size && i->iov_offset && allocated(pipe_buf(i->pipe, i->head)))
 			return size | i->iov_offset;
 		return size;
 	}
-- 
2.30.2


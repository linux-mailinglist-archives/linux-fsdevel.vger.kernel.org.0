Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944A35502EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiFRFfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiFRFfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880BE66AFA
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Sdy7m/8cN86mmhVZ/K17PmzEuvZExFroEM4agxoc0mA=; b=hj/K26ZFdhN/eZssGfII5IkqqG
        6yk5J0z9o4gEJbRJCpKP5dU5VDLctkbB1nfKG3+wW4IHQ40G3ECd9PTZhIGJnni41hcVOCJcNku7b
        V3Kyk2Kc5uvD9Q40ggwCxmlDuVswJLPdvG34n6dt/IkI1ZFU35ffPK1Md0fa5DTj31M6ym/YcBz7I
        f/WlDOEWGvLGs1+Tw05sfxyzJjWs+PJz2NXVB0mB8DjKSNBgHDIOy6A7AaFvQPo89HnQbsP2K6MBS
        gcVg6yyht4GMbphZBpxuazwfrGN5MqGia4+JHxNvzndKBbrRNB3hNjVWzPeH25L8jmH5CJ6DXNLDI
        k03//54g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7T-001VPs-QC;
        Sat, 18 Jun 2022 05:35:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 07/31] ITER_PIPE: clean pipe_advance() up
Date:   Sat, 18 Jun 2022 06:35:13 +0100
Message-Id: <20220618053538.359065-7-viro@zeniv.linux.org.uk>
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

instead of setting ->iov_offset for new position and calling
pipe_truncate() to adjust ->len of the last buffer and discard
everything after it, adjust ->len at the same time we set ->iov_offset
and use pipe_discard_from() to deal with buffers past that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 892810c6ec61..ce2ce5b0c600 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -847,27 +847,27 @@ static inline void pipe_truncate(struct iov_iter *i)
 static void pipe_advance(struct iov_iter *i, size_t size)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	if (size) {
-		struct pipe_buffer *buf;
-		unsigned int p_mask = pipe->ring_size - 1;
-		unsigned int i_head = i->head;
-		size_t off = i->iov_offset, left = size;
+	unsigned int off = i->iov_offset;
 
+	if (!off && !size) {
+		pipe_discard_from(pipe, i->start_head); // discard everything
+		return;
+	}
+	i->count -= size;
+	while (1) {
+		struct pipe_buffer *buf = pipe_buf(pipe, i->head);
 		if (off) /* make it relative to the beginning of buffer */
-			left += off - pipe->bufs[i_head & p_mask].offset;
-		while (1) {
-			buf = &pipe->bufs[i_head & p_mask];
-			if (left <= buf->len)
-				break;
-			left -= buf->len;
-			i_head++;
+			size += off - buf->offset;
+		if (size <= buf->len) {
+			buf->len = size;
+			i->iov_offset = buf->offset + size;
+			break;
 		}
-		i->head = i_head;
-		i->iov_offset = buf->offset + left;
+		size -= buf->len;
+		i->head++;
+		off = 0;
 	}
-	i->count -= size;
-	/* ... and discard everything past that point */
-	pipe_truncate(i);
+	pipe_discard_from(pipe, i->head + 1); // discard everything past this one
 }
 
 static void iov_iter_bvec_advance(struct iov_iter *i, size_t size)
-- 
2.30.2


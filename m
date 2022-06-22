Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36C554169
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356901AbiFVEQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356716AbiFVEP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9283209
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=14wT+3jiMDFp/cm+PVp6c75ud4yITpvG6FiAkIAHu30=; b=sIrp/moA0sej9fVyITkNinoJ2D
        8ZJzRR1LARuMLkLGvDfWAnRGKMFTMvUZA9tLC+WAHDhj+uEQ7gEPQV5QEQFPnEqK4y4bMi/HSlqLU
        pCCOKUGON3I3W3oh80oNcMC4MDNiK9xr/cQBHgwwYdJtvLKybA9tPWDUBpsP5yxQE/21VzR4jK+o/
        +/66AtebAy52DhYitiE4E96dz08G73d+0GBE0dYgdab+kHStK9KJxVP349K8yfPlYFlSjRnl+v/jo
        +3qpmYBFi46bJid/C/S/6ftBILLaFW2XQ//F9Ym+8cUe7f0LIjbXZNdBsHObllfwo1HaPKoehoOdT
        md0/hFZw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmV-0035x1-DT;
        Wed, 22 Jun 2022 04:15:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 18/44] ITER_PIPE: lose iter_head argument of __pipe_get_pages()
Date:   Wed, 22 Jun 2022 05:15:26 +0100
Message-Id: <20220622041552.737754-18-viro@zeniv.linux.org.uk>
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

it's only used to get to the partial buffer we can add to,
and that's always the last one, i.e. pipe->head - 1.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a507eed67839..4b5a98105547 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1220,14 +1220,13 @@ EXPORT_SYMBOL(iov_iter_gap_alignment);
 static inline ssize_t __pipe_get_pages(struct iov_iter *i,
 				size_t maxsize,
 				struct page **pages,
-				int iter_head,
 				size_t off)
 {
 	struct pipe_inode_info *pipe = i->pipe;
 	ssize_t left = maxsize;
 
 	if (off) {
-		struct pipe_buffer *buf = pipe_buf(pipe, iter_head);
+		struct pipe_buffer *buf = pipe_buf(pipe, pipe->head - 1);
 
 		get_page(*pages++ = buf->page);
 		left -= PAGE_SIZE - off;
@@ -1265,7 +1264,7 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	npages = pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
 	capacity = min(npages, maxpages) * PAGE_SIZE - *start;
 
-	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, *start);
+	return __pipe_get_pages(i, min(maxsize, capacity), pages, *start);
 }
 
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
@@ -1461,7 +1460,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	p = get_pages_array(npages);
 	if (!p)
 		return -ENOMEM;
-	n = __pipe_get_pages(i, maxsize, p, iter_head, *start);
+	n = __pipe_get_pages(i, maxsize, p, *start);
 	if (n > 0)
 		*pages = p;
 	else
-- 
2.30.2


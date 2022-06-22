Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964A355417C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356915AbiFVERE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356847AbiFVEQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE9513EB8
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TvO9AxhuUqm3giUpUDkx42XZvSxm/hz1ZoCEeXDw8Tc=; b=v4gH8oftfVeyxzNlzbN6Til65f
        qg28Qi1O6esKO+eFE/HAXleLj4fO+MlWlEYk/OFraRsr7KGOE+s1eBd57Zthuf5IW6CGcLNN4Juz6
        uNHxf+LmrXDEGut9VQf8veBjp/kEcKEu+pm+tJe2icDth6uItihMgR3SUclevO2Pqrw7VIV4w/2UP
        8BthXSZgTW93km5A2CL0hXY4uf740KjJRz7KK7vMoHlkzSX3uliIBs/jSfdA31Q2sehwviCRc3AR7
        HB7WqRCvVUOXo5ZSy+nUi6sjMv+0AI7TM3+tMOkL0tlbQL/yL5PMRp2oon1vQ3fM4ZnWxPFcGcVzo
        AXnQCvfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rma-00360L-HZ;
        Wed, 22 Jun 2022 04:16:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 43/44] pipe_get_pages(): switch to append_pipe()
Date:   Wed, 22 Jun 2022 05:15:51 +0100
Message-Id: <20220622041552.737754-43-viro@zeniv.linux.org.uk>
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

now that we are advancing the iterator, there's no need to
treat the first page separately - just call append_pipe()
in a loop.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 70736b3e07c5..a8045c97b975 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1207,10 +1207,10 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int npages, off, count;
+	unsigned int npages, count;
 	struct page **p;
 	ssize_t left;
+	size_t off;
 
 	if (!sanity(i))
 		return -EFAULT;
@@ -1222,38 +1222,18 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	if (!count)
 		return -ENOMEM;
 	p = *pages;
-	left = maxsize;
-	npages = 0;
-	if (off) {
-		struct pipe_buffer *buf = pipe_buf(pipe, pipe->head - 1);
-
-		get_page(*p++ = buf->page);
-		left -= PAGE_SIZE - off;
-		if (left <= 0) {
-			buf->len += maxsize;
-			iov_iter_advance(i, maxsize);
-			return maxsize;
-		}
-		buf->len = PAGE_SIZE;
-		npages = 1;
-	}
-	for ( ; npages < count; npages++) {
-		struct page *page;
-		unsigned int size = min_t(ssize_t, left, PAGE_SIZE);
-
-		if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
-			break;
-		page = push_anon(pipe, size);
+	for (npages = 0, left = maxsize ; npages < count; npages++) {
+		struct page *page = append_pipe(i, left, &off);
 		if (!page)
 			break;
 		get_page(*p++ = page);
-		left -= size;
+		if (left <= PAGE_SIZE - off)
+			return maxsize;
+		left -= PAGE_SIZE - off;
 	}
 	if (!npages)
 		return -EFAULT;
-	maxsize -= left;
-	iov_iter_advance(i, maxsize);
-	return maxsize;
+	return maxsize - left;
 }
 
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
-- 
2.30.2


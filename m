Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36179550306
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiFRFgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiFRFgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:36:03 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D91368982
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6oan6BuE/K9rVhAt/5mdJaZOz/ZQhb+VBYliaEMnYJc=; b=eGK/PIa2e5hZq7yp6qvlYwbKwZ
        TH0oH3PaKdQPpaKw7wwvZ/FD8BI/DNmIZrEsTS+RZbX4n8+6Lc3SKHcIufPm2kgqJdeHDCe34G6ko
        IS7V8hQcce3PsFzr/jV52yjtLE2zFpr+4fypu3wLYJMucL5JA4IErPGIHDQw2Ma1MlO6TxDt/1n/H
        tBAQ8D2apiqHwdRFhse71iDPDNfecAunZvzvPZkyCKfyO74mEOEttvUvimmzx9ISgMDQJuJcevuzZ
        pswDM1geSqHlTnUK0v6Z0CtPVUrKJL7x2+pBNO2bzYM2TOYIWLPuIn9OKZ1wI8T63p4mvyxapCXBE
        D2C84brA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7X-001VSA-Ua;
        Sat, 18 Jun 2022 05:35:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 30/31] pipe_get_pages(): switch to append_pipe()
Date:   Sat, 18 Jun 2022 06:35:37 +0100
Message-Id: <20220618053538.359065-31-viro@zeniv.linux.org.uk>
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

now that we are advancing the iterator, there's no need to
treat the first page separately - just call append_pipe()
in a loop.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c1e5de842fe3..3306072c7b73 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1206,10 +1206,9 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
-	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int npages, off;
+	unsigned int npages;
+	size_t left, off;
 	struct page **p;
-	ssize_t left;
 	int count;
 
 	if (!sanity(i))
@@ -1220,38 +1219,16 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	if (count < 0)
 		return count;
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


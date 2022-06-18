Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9805502FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiFRFgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiFRFfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C80066CB8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8FvK3cUJaZJSIvZkbRYktRV65hcbLrvnDWPVVmeCO/4=; b=J6JQHC8t2zhI4/gxRbd46aH7xw
        cx4ZJmptOYM69K97hXLWdMP75H3U75Z5vEGt4CQyidEB7vSCk8IWUAXacjAd/2rgcBgMYk+2ljiEw
        zv5JRT/O2GGGPxZ1AbFkuz0a5mXSxEOtEKCEfhDgS0Hj0MrjLAYOmrGqRPzIX8RfOfZEywk/t+clu
        VFVTyQ1is+8HLZXdLeOl/gDq0UZ1dFdU8kuLCxj9Rq4ib45szLmGU+llC609rQB6KfnmIqQ0OamGM
        hvFACZIKJhd40wiOuDABvBCRe+O1Qv/5eRUSQVDSurOd/z2Ip9Nvpxa8u/zbMF3HElPl0+CyJonHi
        faUBYisQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7V-001VQr-RY;
        Sat, 18 Jun 2022 05:35:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 18/31] iov_iter: lift dealing with maxpages out of first_{iovec,bvec}_segment()
Date:   Sat, 18 Jun 2022 06:35:25 +0100
Message-Id: <20220618053538.359065-19-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 04c3a62679f8..8f1d63295f37 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1308,12 +1308,9 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 
 static unsigned long found_ubuf_segment(unsigned long addr,
 					size_t len,
-					size_t *size, size_t *start,
-					unsigned maxpages)
+					size_t *size, size_t *start)
 {
 	len += (*start = addr % PAGE_SIZE);
-	if (len > maxpages * PAGE_SIZE)
-		len = maxpages * PAGE_SIZE;
 	*size = len;
 	return addr & PAGE_MASK;
 }
@@ -1321,14 +1318,14 @@ static unsigned long found_ubuf_segment(unsigned long addr,
 /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
 static unsigned long first_iovec_segment(const struct iov_iter *i,
 					 size_t *size, size_t *start,
-					 size_t maxsize, unsigned maxpages)
+					 size_t maxsize)
 {
 	size_t skip;
 	long k;
 
 	if (iter_is_ubuf(i)) {
 		unsigned long addr = (unsigned long)i->ubuf + i->iov_offset;
-		return found_ubuf_segment(addr, maxsize, size, start, maxpages);
+		return found_ubuf_segment(addr, maxsize, size, start);
 	}
 
 	for (k = 0, skip = i->iov_offset; k < i->nr_segs; k++, skip = 0) {
@@ -1339,7 +1336,7 @@ static unsigned long first_iovec_segment(const struct iov_iter *i,
 			continue;
 		if (len > maxsize)
 			len = maxsize;
-		return found_ubuf_segment(addr, len, size, start, maxpages);
+		return found_ubuf_segment(addr, len, size, start);
 	}
 	BUG(); // if it had been empty, we wouldn't get called
 }
@@ -1347,7 +1344,7 @@ static unsigned long first_iovec_segment(const struct iov_iter *i,
 /* must be done on non-empty ITER_BVEC one */
 static struct page *first_bvec_segment(const struct iov_iter *i,
 				       size_t *size, size_t *start,
-				       size_t maxsize, unsigned maxpages)
+				       size_t maxsize)
 {
 	struct page *page;
 	size_t skip = i->iov_offset, len;
@@ -1358,8 +1355,6 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 	skip += i->bvec->bv_offset;
 	page = i->bvec->bv_page + skip / PAGE_SIZE;
 	len += (*start = skip % PAGE_SIZE);
-	if (len > maxpages * PAGE_SIZE)
-		len = maxpages * PAGE_SIZE;
 	*size = len;
 	return page;
 }
@@ -1387,7 +1382,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		if (i->nofault)
 			gup_flags |= FOLL_NOFAULT;
 
-		addr = first_iovec_segment(i, &len, start, maxsize, maxpages);
+		addr = first_iovec_segment(i, &len, start, maxsize);
+		if (len > maxpages * PAGE_SIZE)
+			len = maxpages * PAGE_SIZE;
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
 		if (*pages) {
 			*pages = get_pages_array(n);
@@ -1405,7 +1402,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		struct page **p;
 		struct page *page;
 
-		page = first_bvec_segment(i, &len, start, maxsize, maxpages);
+		page = first_bvec_segment(i, &len, start, maxsize);
+		if (len > maxpages * PAGE_SIZE)
+			len = maxpages * PAGE_SIZE;
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
 		p = *pages;
 		if (!p) {
-- 
2.30.2


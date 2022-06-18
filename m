Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28C2550302
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiFRFgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiFRFfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4DC68311
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XTJFCbur03L1/e/yfiXOTmit+w8FXjLu+L5gKCPgOhw=; b=gKfiz5lZugxyZzeeeF2Vlsk2NH
        TQDPIE2punfAuasKC19f2fBmrGwh3czRYKLTJlD9tkd9TpApVEragaQimdLsDvEHtQSpzr3SD4gSI
        D0lDlaZ3VaGe1oOswF/0FBVgilWRYHewZV9Qeu72JtnVMoEal+AK3Y47fVF0F2DnRmpFi7rdYIIeH
        tgFNp7ePGUCgOeBv/nhQ4767jIsamXx+Yy0YQewsdTTJBCeDKiX79kwz0jRMf6R3mH3UFpRLyMR+a
        3mszSYowaQQvd5vkE98rXWh5ttVUBZujVLLPglVO/+4vt4JluIbRoSz5UCv8ga1fveU3P6LOz/AEF
        4ExwTbew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7W-001VRC-JH;
        Sat, 18 Jun 2022 05:35:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 22/31] iov_iter: saner helper for page array allocation
Date:   Sat, 18 Jun 2022 06:35:29 +0100
Message-Id: <20220618053538.359065-23-viro@zeniv.linux.org.uk>
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

All call sites of get_pages_array() are essenitally identical now.
Replace with common helper...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 64 +++++++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f20ba33f48da..a137bfaaaa77 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1187,9 +1187,19 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_gap_alignment);
 
-static struct page **get_pages_array(size_t n)
+static int want_pages_array(struct page ***res, size_t size,
+			    size_t start, unsigned int maxpages)
 {
-	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
+	unsigned count = DIV_ROUND_UP(size + start, PAGE_SIZE);
+
+	if (count > maxpages)
+		count = maxpages;
+	if (!*res) {
+		*res = kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
+		if (!*res)
+			return -ENOMEM;
+	}
+	return count;
 }
 
 static ssize_t pipe_get_pages(struct iov_iter *i,
@@ -1206,18 +1216,10 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 		return -EFAULT;
 
 	*start = off = pipe_npages(i, &npages);
-	count = DIV_ROUND_UP(maxsize + off, PAGE_SIZE);
-	if (count > npages)
-		count = npages;
-	if (count > maxpages)
-		count = maxpages;
+	count = want_pages_array(pages, maxsize, off, min(npages, maxpages));
+	if (count < 0)
+		return count;
 	p = *pages;
-	if (!p) {
-		*pages = p = get_pages_array(count);
-		if (!p)
-			return -ENOMEM;
-	}
-
 	left = maxsize;
 	npages = 0;
 	if (off) {
@@ -1282,7 +1284,6 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 {
 	unsigned nr, offset;
 	pgoff_t index, count;
-	size_t size = maxsize;
 	loff_t pos;
 
 	pos = i->xarray_start + i->iov_offset;
@@ -1290,16 +1291,9 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	offset = pos & ~PAGE_MASK;
 	*_start_offset = offset;
 
-	count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
-	if (count > maxpages)
-		count = maxpages;
-
-	if (!*pages) {
-		*pages = get_pages_array(count);
-		if (!*pages)
-			return -ENOMEM;
-	}
-
+	count = want_pages_array(pages, maxsize, offset, maxpages);
+	if (count < 0)
+		return count;
 	nr = iter_xarray_populate_pages(*pages, i->xarray, index, count);
 	if (nr == 0)
 		return 0;
@@ -1370,14 +1364,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		addr = first_iovec_segment(i, &maxsize);
 		*start = addr % PAGE_SIZE;
 		addr &= PAGE_MASK;
-		n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
-		if (n > maxpages)
-			n = maxpages;
-		if (*pages) {
-			*pages = get_pages_array(n);
-			if (!*pages)
-				return -ENOMEM;
-		}
+		n = want_pages_array(pages, len, *start, maxpages);
+		if (n < 0)
+			return n;
 		res = get_user_pages_fast(addr, n, gup_flags, *pages);
 		if (unlikely(res <= 0))
 			return res;
@@ -1388,15 +1377,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		struct page *page;
 
 		page = first_bvec_segment(i, &maxsize, start);
-		n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
-		if (n > maxpages)
-			n = maxpages;
+		n = want_pages_array(pages, len, *start, maxpages);
+		if (n < 0)
+			return n;
 		p = *pages;
-		if (!p) {
-			*pages = p = get_pages_array(n);
-			if (!p)
-				return -ENOMEM;
-		}
 		for (int k = 0; k < n; k++)
 			get_page(*p++ = page++);
 		return min_t(size_t, maxsize, n * PAGE_SIZE - *start);
-- 
2.30.2


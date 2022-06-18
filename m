Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799EF5502FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiFRFgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiFRFfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD7666BC
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sDvEBULQivSZmS4FDqwNcqMqq7Oj+7BcPpD0nNZLPao=; b=svK8ayImDJ0Y4MUH2LBfxkgq2F
        4mNDx4ZhAduTkKC6JDC9IOBy9RMP2NifZpDqxRgCUK3U7rcPs+6HjYXVOx3N9dkSKW1xwswMUvWbF
        KcH+vp14V7Avau8tYfin2K/qhTzfMXTsMqcAyeBiD/fj0fNotlgMWmLWm43DcnuG/p6yhhEn8zxRN
        TIAIYZRo2FT81H/1CcYHHK44EI71f6RLTPGFt+owVq7P8WHZfpdJsajW8dwmyi2CrvMB2IYsNZeig
        HIKJlcAt845EKoxYFoZdm+eyUItENHmPsaiBHMCJGaC5BhUrZFWawxaGKCL7Pp3gBjMpQJBNq9ClC
        W0kJ0fdQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7U-001VQK-R9;
        Sat, 18 Jun 2022 05:35:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 12/31] iov_iter_get_pages_alloc(): lift freeing pages array on failure exits into wrapper
Date:   Sat, 18 Jun 2022 06:35:19 +0100
Message-Id: <20220618053538.359065-13-viro@zeniv.linux.org.uk>
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

Incidentally, ITER_XARRAY did *not* free the sucker in case when
iter_xarray_populate_pages() returned NULL...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 51 +++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2d4176a2a1b5..f5e14535f6bb 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1425,15 +1425,10 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 		maxsize = n;
 	else
 		npages = DIV_ROUND_UP(maxsize + off, PAGE_SIZE);
-	p = get_pages_array(npages);
+	*pages = p = get_pages_array(npages);
 	if (!p)
 		return -ENOMEM;
-	n = __pipe_get_pages(i, maxsize, p, off);
-	if (n > 0)
-		*pages = p;
-	else
-		kvfree(p);
-	return n;
+	return __pipe_get_pages(i, maxsize, p, off);
 }
 
 static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
@@ -1463,10 +1458,9 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 			count++;
 	}
 
-	p = get_pages_array(count);
+	*pages = p = get_pages_array(count);
 	if (!p)
 		return -ENOMEM;
-	*pages = p;
 
 	nr = iter_xarray_populate_pages(p, i->xarray, index, count);
 	if (nr == 0)
@@ -1475,7 +1469,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
 }
 
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
 {
@@ -1483,10 +1477,6 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	size_t len;
 	int n, res;
 
-	if (maxsize > i->count)
-		maxsize = i->count;
-	if (!maxsize)
-		return 0;
 	if (maxsize > LONG_MAX)
 		maxsize = LONG_MAX;
 
@@ -1501,17 +1491,15 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 
 		addr = first_iovec_segment(i, &len, start, maxsize, ~0U);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		p = get_pages_array(n);
+		*pages = p = get_pages_array(n);
 		if (!p)
 			return -ENOMEM;
 		res = get_user_pages_fast(addr, n, gup_flags, p);
-		if (unlikely(res <= 0)) {
-			kvfree(p);
-			*pages = NULL;
+		if (unlikely(res <= 0))
 			return res;
-		}
-		*pages = p;
-		return (res == n ? len : res * PAGE_SIZE) - *start;
+		if (res < n)
+			len = res * PAGE_SIZE;
+		return len - *start;
 	}
 	if (iov_iter_is_bvec(i)) {
 		struct page *page;
@@ -1531,6 +1519,27 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
 	return -EFAULT;
 }
+
+ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+		   struct page ***pages, size_t maxsize,
+		   size_t *start)
+{
+	size_t len;
+
+	*pages = NULL;
+
+	if (maxsize > i->count)
+		maxsize = i->count;
+	if (!maxsize)
+		return 0;
+
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, start);
+	if (len <= 0) {
+		kvfree(*pages);
+		*pages = NULL;
+	}
+	return len;
+}
 EXPORT_SYMBOL(iov_iter_get_pages_alloc);
 
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
-- 
2.30.2


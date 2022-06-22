Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B8B554173
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356866AbiFVEQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356773AbiFVEQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3575AB7F
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dzXKtRiyP3JgvScP2PDu57QL9iKNSgv5vG2wxukWCBw=; b=fI6yVun9khy0KkwMMLvGBF3yUy
        rKiYzrQgOBKRNROhSh0QtOKCC+QAkOyuyWstLlPsMo9thUuelccdFYCOc97jmfc3JRzONuMm1xUia
        Q8WVVC1ek7fW3IwEioTzD009x5KPShQOUIVNoAj6Poq5oxDuf2NC0osn3NALW0/18CGBBA7Nr5Bw9
        vleWx/baP8HgeOGun1SLKSM/ZfAXSv7YW5RsgN5XvNxhNnKpQxqsFwUNpjx7yLBmYNQk0jFupNXKr
        5/+csgbA5qDmsg8d1J7u8FEX/1nmHwnyoE5TN01p+TOD30P/Jhwu31HpIjTjqBH+ZWTQBBfAfmMzr
        pH+dxhsA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmW-0035xm-HI;
        Wed, 22 Jun 2022 04:15:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 24/44] iov_iter_get_pages_alloc(): lift freeing pages array on failure exits into wrapper
Date:   Wed, 22 Jun 2022 05:15:32 +0100
Message-Id: <20220622041552.737754-24-viro@zeniv.linux.org.uk>
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

Incidentally, ITER_XARRAY did *not* free the sucker in case when
iter_xarray_populate_pages() returned 0...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c3fb7853dbe8..9c25661684c6 100644
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
@@ -1501,16 +1495,12 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 
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
 		return (res == n ? len : res * PAGE_SIZE) - *start;
 	}
 	if (iov_iter_is_bvec(i)) {
@@ -1531,6 +1521,22 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
 	return -EFAULT;
 }
+
+ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+		   struct page ***pages, size_t maxsize,
+		   size_t *start)
+{
+	ssize_t len;
+
+	*pages = NULL;
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


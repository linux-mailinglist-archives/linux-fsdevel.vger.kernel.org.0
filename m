Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E101A55417D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356913AbiFVEQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356687AbiFVEQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1B86582
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VH22792t7ZdKST0qLwcvc1oYMXr0Krbc1eewtKWvlyw=; b=wuSVrjO6ntzs5hFs7Xwz+2zObK
        xRSp/1KIMP7/AA2SMRXlRCcO36MlKIlNls9L9Q34cAPLzwM88sFT8jp7/UrHvSr220OMEBoosfDeh
        jyissQN7EmUxeB5PA7gA3Wpvo0mXDDy61xKVwhSzUDsYDbq3e/l/IiGnVn4XE124cD66ex9zpRRCe
        b+pkt4diSWYWFDdgRZI+H8jSoPlx2Zg+BFxy1+2C8qcIop/L8O4LdO5FIXcaW5Znov7GenZcUb23p
        SRiiUB2oTN/SYa8CBAvfOgYBJTdkLRHiFchVyct+7I8KNTgZNFxSoqFMqn4mNNPSwf03TWd4AtBWW
        S2k2vEmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmX-0035yI-9B;
        Wed, 22 Jun 2022 04:15:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 28/44] unify the rest of iov_iter_get_pages()/iov_iter_get_pages_alloc() guts
Date:   Wed, 22 Jun 2022 05:15:36 +0100
Message-Id: <20220622041552.737754-28-viro@zeniv.linux.org.uk>
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

same as for pipes and xarrays; after that iov_iter_get_pages() becomes
a wrapper for __iov_iter_get_pages_alloc().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 86 ++++++++++++++++----------------------------------
 1 file changed, 28 insertions(+), 58 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 07dacb274ba5..811fa09515d8 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1372,20 +1372,19 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 	return page;
 }
 
-ssize_t iov_iter_get_pages(struct iov_iter *i,
-		   struct page **pages, size_t maxsize, unsigned maxpages,
-		   size_t *start)
+static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
+		   struct page ***pages, size_t maxsize,
+		   unsigned int maxpages, size_t *start)
 {
 	size_t len;
 	int n, res;
 
 	if (maxsize > i->count)
 		maxsize = i->count;
-	if (!maxsize || !maxpages)
+	if (!maxsize)
 		return 0;
 	if (maxsize > MAX_RW_COUNT)
 		maxsize = MAX_RW_COUNT;
-	BUG_ON(!pages);
 
 	if (likely(user_backed_iter(i))) {
 		unsigned int gup_flags = 0;
@@ -1398,80 +1397,51 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 
 		addr = first_iovec_segment(i, &len, start, maxsize, maxpages);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		res = get_user_pages_fast(addr, n, gup_flags, pages);
+		if (!*pages) {
+			*pages = get_pages_array(n);
+			if (!*pages)
+				return -ENOMEM;
+		}
+		res = get_user_pages_fast(addr, n, gup_flags, *pages);
 		if (unlikely(res <= 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
 	}
 	if (iov_iter_is_bvec(i)) {
+		struct page **p;
 		struct page *page;
 
 		page = first_bvec_segment(i, &len, start, maxsize, maxpages);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
+		p = *pages;
+		if (!p) {
+			*pages = p = get_pages_array(n);
+			if (!p)
+				return -ENOMEM;
+		}
 		while (n--)
-			get_page(*pages++ = page++);
+			get_page(*p++ = page++);
 		return len - *start;
 	}
 	if (iov_iter_is_pipe(i))
-		return pipe_get_pages(i, &pages, maxsize, maxpages, start);
+		return pipe_get_pages(i, pages, maxsize, maxpages, start);
 	if (iov_iter_is_xarray(i))
-		return iter_xarray_get_pages(i, &pages, maxsize, maxpages, start);
+		return iter_xarray_get_pages(i, pages, maxsize, maxpages,
+					     start);
 	return -EFAULT;
 }
-EXPORT_SYMBOL(iov_iter_get_pages);
 
-static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
-		   struct page ***pages, size_t maxsize,
+ssize_t iov_iter_get_pages(struct iov_iter *i,
+		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
-	struct page **p;
-	size_t len;
-	int n, res;
-
-	if (maxsize > i->count)
-		maxsize = i->count;
-	if (!maxsize)
+	if (!maxpages)
 		return 0;
-	if (maxsize > MAX_RW_COUNT)
-		maxsize = MAX_RW_COUNT;
-
-	if (likely(user_backed_iter(i))) {
-		unsigned int gup_flags = 0;
-		unsigned long addr;
-
-		if (iov_iter_rw(i) != WRITE)
-			gup_flags |= FOLL_WRITE;
-		if (i->nofault)
-			gup_flags |= FOLL_NOFAULT;
-
-		addr = first_iovec_segment(i, &len, start, maxsize, ~0U);
-		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		*pages = p = get_pages_array(n);
-		if (!p)
-			return -ENOMEM;
-		res = get_user_pages_fast(addr, n, gup_flags, p);
-		if (unlikely(res <= 0))
-			return res;
-		return (res == n ? len : res * PAGE_SIZE) - *start;
-	}
-	if (iov_iter_is_bvec(i)) {
-		struct page *page;
+	BUG_ON(!pages);
 
-		page = first_bvec_segment(i, &len, start, maxsize, ~0U);
-		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		*pages = p = get_pages_array(n);
-		if (!p)
-			return -ENOMEM;
-		while (n--)
-			get_page(*p++ = page++);
-		return len - *start;
-	}
-	if (iov_iter_is_pipe(i))
-		return pipe_get_pages(i, pages, maxsize, ~0U, start);
-	if (iov_iter_is_xarray(i))
-		return iter_xarray_get_pages(i, pages, maxsize, ~0U, start);
-	return -EFAULT;
+	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
 }
+EXPORT_SYMBOL(iov_iter_get_pages);
 
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
@@ -1481,7 +1451,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 
 	*pages = NULL;
 
-	len = __iov_iter_get_pages_alloc(i, pages, maxsize, start);
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
 	if (len <= 0) {
 		kvfree(*pages);
 		*pages = NULL;
-- 
2.30.2


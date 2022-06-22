Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58248554172
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356981AbiFVEQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356836AbiFVEQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C1B1E5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gJcrpECXmawhpmZvu+Z8NVIT9Mj7s3PfGZqh6o7f49U=; b=h3ONxjxIJYt0nchSvzr+BU8xpD
        sencD4znlpBqB2ZhbYB5PuYHxu5oiv+DtPlTBSpLNtCq4Cmu+Ss+OBKhdzj5igeeOjAtLFpyfnRSN
        17PvPvQiX7+h68EW7e+RLsEIhMIl3ZzCTZg3KAe5paIOxrV2k9nBiWj6ddG4RDfTyu+U1Tg9rYm28
        bIbViG70TK7lvPVW55NVPR7dGuuSt6dM9zpFLyJP60yL8+LdntkoRNcjema4hhjnBak5/TVyXKpH3
        8rqOWYwrgUS6uYB9XBuh2i1z+c2yKXgtOAvtQFwFjzFyImEAS8IsWEuM2c/2CrIkJNLpfCee6iTZH
        V5jPFDnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmY-0035zF-Mb;
        Wed, 22 Jun 2022 04:15:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 35/44] iov_iter: saner helper for page array allocation
Date:   Wed, 22 Jun 2022 05:15:43 +0100
Message-Id: <20220622041552.737754-35-viro@zeniv.linux.org.uk>
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

All call sites of get_pages_array() are essenitally identical now.
Replace with common helper...

Returns number of slots available in resulting array or 0 on OOM;
it's up to the caller to make sure it doesn't ask to zero-entry
array (i.e. neither maxpages nor size are allowed to be zero).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 77 +++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 45 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9280f865fd6a..1c744f0c0b2c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1187,9 +1187,20 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_gap_alignment);
 
-static struct page **get_pages_array(size_t n)
+static int want_pages_array(struct page ***res, size_t size,
+			    size_t start, unsigned int maxpages)
 {
-	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
+	unsigned int count = DIV_ROUND_UP(size + start, PAGE_SIZE);
+
+	if (count > maxpages)
+		count = maxpages;
+	WARN_ON(!count);	// caller should've prevented that
+	if (!*res) {
+		*res = kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
+		if (!*res)
+			return 0;
+	}
+	return count;
 }
 
 static ssize_t pipe_get_pages(struct iov_iter *i,
@@ -1197,27 +1208,20 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 		   size_t *start)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	unsigned int npages, off;
+	unsigned int npages, off, count;
 	struct page **p;
 	ssize_t left;
-	int count;
 
 	if (!sanity(i))
 		return -EFAULT;
 
 	*start = off = pipe_npages(i, &npages);
-	count = DIV_ROUND_UP(maxsize + off, PAGE_SIZE);
-	if (count > npages)
-		count = npages;
-	if (count > maxpages)
-		count = maxpages;
+	if (!npages)
+		return -EFAULT;
+	count = want_pages_array(pages, maxsize, off, min(npages, maxpages));
+	if (!count)
+		return -ENOMEM;
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
@@ -1280,9 +1284,8 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 				     struct page ***pages, size_t maxsize,
 				     unsigned maxpages, size_t *_start_offset)
 {
-	unsigned nr, offset;
-	pgoff_t index, count;
-	size_t size = maxsize;
+	unsigned nr, offset, count;
+	pgoff_t index;
 	loff_t pos;
 
 	pos = i->xarray_start + i->iov_offset;
@@ -1290,16 +1293,9 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
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
+	if (!count)
+		return -ENOMEM;
 	nr = iter_xarray_populate_pages(*pages, i->xarray, index, count);
 	if (nr == 0)
 		return 0;
@@ -1348,7 +1344,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   unsigned int maxpages, size_t *start)
 {
-	int n, res;
+	unsigned int n;
 
 	if (maxsize > i->count)
 		maxsize = i->count;
@@ -1360,6 +1356,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 	if (likely(user_backed_iter(i))) {
 		unsigned int gup_flags = 0;
 		unsigned long addr;
+		int res;
 
 		if (iov_iter_rw(i) != WRITE)
 			gup_flags |= FOLL_WRITE;
@@ -1369,14 +1366,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		addr = first_iovec_segment(i, &maxsize);
 		*start = addr % PAGE_SIZE;
 		addr &= PAGE_MASK;
-		n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
-		if (n > maxpages)
-			n = maxpages;
-		if (!*pages) {
-			*pages = get_pages_array(n);
-			if (!*pages)
-				return -ENOMEM;
-		}
+		n = want_pages_array(pages, maxsize, *start, maxpages);
+		if (!n)
+			return -ENOMEM;
 		res = get_user_pages_fast(addr, n, gup_flags, *pages);
 		if (unlikely(res <= 0))
 			return res;
@@ -1387,15 +1379,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		struct page *page;
 
 		page = first_bvec_segment(i, &maxsize, start);
-		n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
-		if (n > maxpages)
-			n = maxpages;
+		n = want_pages_array(pages, maxsize, *start, maxpages);
+		if (!n)
+			return -ENOMEM;
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


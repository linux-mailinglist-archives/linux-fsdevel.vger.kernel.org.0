Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA4D39D0BB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFFTNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhFFTMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21F8C061280;
        Sun,  6 Jun 2021 12:10:59 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAe-0056Zx-LD; Sun, 06 Jun 2021 19:10:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 17/37] get rid of iterate_all_kinds() in iov_iter_get_pages()/iov_iter_get_pages_alloc()
Date:   Sun,  6 Jun 2021 19:10:31 +0000
Message-Id: <20210606191051.1216821-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here iterate_all_kinds() is used just to find the first (non-empty, in
case of iovec) segment.  Which can be easily done explicitly.
Note that in bvec case we now can get more than PAGE_SIZE worth of them,
in case when we have a compound page in bvec and a range that crosses
a subpage boundary.  Older behaviour had been to stop on that boundary;
we used to get the right first page (for_each_bvec() took care of that),
but that was all we'd got.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 147 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 91 insertions(+), 56 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a6947301b9a0..5e8d5e4ee92d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1463,9 +1463,6 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	unsigned int iter_head, npages;
 	size_t capacity;
 
-	if (!maxsize)
-		return 0;
-
 	if (!sanity(i))
 		return -EFAULT;
 
@@ -1546,29 +1543,67 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	return actual;
 }
 
+/* must be done on non-empty ITER_IOVEC one */
+static unsigned long first_iovec_segment(const struct iov_iter *i,
+					 size_t *size, size_t *start,
+					 size_t maxsize, unsigned maxpages)
+{
+	size_t skip;
+	long k;
+
+	for (k = 0, skip = i->iov_offset; k < i->nr_segs; k++, skip = 0) {
+		unsigned long addr = (unsigned long)i->iov[k].iov_base + skip;
+		size_t len = i->iov[k].iov_len - skip;
+
+		if (unlikely(!len))
+			continue;
+		if (len > maxsize)
+			len = maxsize;
+		len += (*start = addr % PAGE_SIZE);
+		if (len > maxpages * PAGE_SIZE)
+			len = maxpages * PAGE_SIZE;
+		*size = len;
+		return addr & PAGE_MASK;
+	}
+	BUG(); // if it had been empty, we wouldn't get called
+}
+
+/* must be done on non-empty ITER_BVEC one */
+static struct page *first_bvec_segment(const struct iov_iter *i,
+				       size_t *size, size_t *start,
+				       size_t maxsize, unsigned maxpages)
+{
+	struct page *page;
+	size_t skip = i->iov_offset, len;
+
+	len = i->bvec->bv_len - skip;
+	if (len > maxsize)
+		len = maxsize;
+	skip += i->bvec->bv_offset;
+	page = i->bvec->bv_page + skip / PAGE_SIZE;
+	len += (*start = skip % PAGE_SIZE);
+	if (len > maxpages * PAGE_SIZE)
+		len = maxpages * PAGE_SIZE;
+	*size = len;
+	return page;
+}
+
 ssize_t iov_iter_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
+	size_t len;
+	int n, res;
+
 	if (maxsize > i->count)
 		maxsize = i->count;
+	if (!maxsize)
+		return 0;
 
-	if (unlikely(iov_iter_is_pipe(i)))
-		return pipe_get_pages(i, pages, maxsize, maxpages, start);
-	if (unlikely(iov_iter_is_xarray(i)))
-		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
-	if (unlikely(iov_iter_is_discard(i)))
-		return -EFAULT;
-
-	iterate_all_kinds(i, maxsize, v, ({
-		unsigned long addr = (unsigned long)v.iov_base;
-		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
-		int n;
-		int res;
+	if (likely(iter_is_iovec(i))) {
+		unsigned long addr;
 
-		if (len > maxpages * PAGE_SIZE)
-			len = maxpages * PAGE_SIZE;
-		addr &= ~(PAGE_SIZE - 1);
+		addr = first_iovec_segment(i, &len, start, maxsize, maxpages);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
 		res = get_user_pages_fast(addr, n,
 				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0,
@@ -1576,17 +1611,21 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		if (unlikely(res < 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
-	0;}),({
-		/* can't be more than PAGE_SIZE */
-		*start = v.bv_offset;
-		get_page(*pages = v.bv_page);
-		return v.bv_len;
-	}),({
-		return -EFAULT;
-	}),
-	0
-	)
-	return 0;
+	}
+	if (iov_iter_is_bvec(i)) {
+		struct page *page;
+
+		page = first_bvec_segment(i, &len, start, maxsize, maxpages);
+		n = DIV_ROUND_UP(len, PAGE_SIZE);
+		while (n--)
+			get_page(*pages++ = page++);
+		return len - *start;
+	}
+	if (iov_iter_is_pipe(i))
+		return pipe_get_pages(i, pages, maxsize, maxpages, start);
+	if (iov_iter_is_xarray(i))
+		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
+	return -EFAULT;
 }
 EXPORT_SYMBOL(iov_iter_get_pages);
 
@@ -1603,9 +1642,6 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	unsigned int iter_head, npages;
 	ssize_t n;
 
-	if (!maxsize)
-		return 0;
-
 	if (!sanity(i))
 		return -EFAULT;
 
@@ -1678,24 +1714,18 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   size_t *start)
 {
 	struct page **p;
+	size_t len;
+	int n, res;
 
 	if (maxsize > i->count)
 		maxsize = i->count;
+	if (!maxsize)
+		return 0;
 
-	if (unlikely(iov_iter_is_pipe(i)))
-		return pipe_get_pages_alloc(i, pages, maxsize, start);
-	if (unlikely(iov_iter_is_xarray(i)))
-		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
-	if (unlikely(iov_iter_is_discard(i)))
-		return -EFAULT;
-
-	iterate_all_kinds(i, maxsize, v, ({
-		unsigned long addr = (unsigned long)v.iov_base;
-		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
-		int n;
-		int res;
+	if (likely(iter_is_iovec(i))) {
+		unsigned long addr;
 
-		addr &= ~(PAGE_SIZE - 1);
+		addr = first_iovec_segment(i, &len, start, maxsize, ~0U);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
 		p = get_pages_array(n);
 		if (!p)
@@ -1708,19 +1738,24 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		}
 		*pages = p;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
-	0;}),({
-		/* can't be more than PAGE_SIZE */
-		*start = v.bv_offset;
-		*pages = p = get_pages_array(1);
+	}
+	if (iov_iter_is_bvec(i)) {
+		struct page *page;
+
+		page = first_bvec_segment(i, &len, start, maxsize, ~0U);
+		n = DIV_ROUND_UP(len, PAGE_SIZE);
+		*pages = p = get_pages_array(n);
 		if (!p)
 			return -ENOMEM;
-		get_page(*p = v.bv_page);
-		return v.bv_len;
-	}),({
-		return -EFAULT;
-	}), 0
-	)
-	return 0;
+		while (n--)
+			get_page(*p++ = page++);
+		return len - *start;
+	}
+	if (iov_iter_is_pipe(i))
+		return pipe_get_pages_alloc(i, pages, maxsize, start);
+	if (iov_iter_is_xarray(i))
+		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
+	return -EFAULT;
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc);
 
-- 
2.11.0


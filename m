Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEFA39D0A9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFFTM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhFFTMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:45 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D80C061787;
        Sun,  6 Jun 2021 12:10:54 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAf-0056ae-RB; Sun, 06 Jun 2021 19:10:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 18/37] iov_iter_npages(): don't bother with iterate_all_kinds()
Date:   Sun,  6 Jun 2021 19:10:32 +0000
Message-Id: <20210606191051.1216821-18-viro@zeniv.linux.org.uk>
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

note that in bvec case pages can be compound ones - we can't just assume
that each segment is covered by one (sub)page

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 88 +++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 34 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5e8d5e4ee92d..04c81481d309 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1877,19 +1877,56 @@ size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 }
 EXPORT_SYMBOL(hash_and_copy_to_iter);
 
-int iov_iter_npages(const struct iov_iter *i, int maxpages)
+static int iov_npages(const struct iov_iter *i, int maxpages)
 {
-	size_t size = i->count;
+	size_t skip = i->iov_offset, size = i->count;
+	const struct iovec *p;
 	int npages = 0;
 
-	if (!size)
-		return 0;
-	if (unlikely(iov_iter_is_discard(i)))
-		return 0;
+	for (p = i->iov; size; skip = 0, p++) {
+		unsigned offs = offset_in_page(p->iov_base + skip);
+		size_t len = min(p->iov_len - skip, size);
 
-	if (unlikely(iov_iter_is_pipe(i))) {
-		struct pipe_inode_info *pipe = i->pipe;
+		if (len) {
+			size -= len;
+			npages += DIV_ROUND_UP(offs + len, PAGE_SIZE);
+			if (unlikely(npages > maxpages))
+				return maxpages;
+		}
+	}
+	return npages;
+}
+
+static int bvec_npages(const struct iov_iter *i, int maxpages)
+{
+	size_t skip = i->iov_offset, size = i->count;
+	const struct bio_vec *p;
+	int npages = 0;
+
+	for (p = i->bvec; size; skip = 0, p++) {
+		unsigned offs = (p->bv_offset + skip) % PAGE_SIZE;
+		size_t len = min(p->bv_len - skip, size);
+
+		size -= len;
+		npages += DIV_ROUND_UP(offs + len, PAGE_SIZE);
+		if (unlikely(npages > maxpages))
+			return maxpages;
+	}
+	return npages;
+}
+
+int iov_iter_npages(const struct iov_iter *i, int maxpages)
+{
+	if (unlikely(!i->count))
+		return 0;
+	/* iovec and kvec have identical layouts */
+	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
+		return iov_npages(i, maxpages);
+	if (iov_iter_is_bvec(i))
+		return bvec_npages(i, maxpages);
+	if (iov_iter_is_pipe(i)) {
 		unsigned int iter_head;
+		int npages;
 		size_t off;
 
 		if (!sanity(i))
@@ -1897,11 +1934,13 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 
 		data_start(i, &iter_head, &off);
 		/* some of this one + all after this one */
-		npages = pipe_space_for_user(iter_head, pipe->tail, pipe);
-		if (npages >= maxpages)
-			return maxpages;
-	} else if (unlikely(iov_iter_is_xarray(i))) {
+		npages = pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
+		return min(npages, maxpages);
+	}
+	if (iov_iter_is_xarray(i)) {
+		size_t size = i->count;
 		unsigned offset;
+		int npages;
 
 		offset = (i->xarray_start + i->iov_offset) & ~PAGE_MASK;
 
@@ -1913,28 +1952,9 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 			if (size)
 				npages++;
 		}
-		if (npages >= maxpages)
-			return maxpages;
-	} else iterate_all_kinds(i, size, v, ({
-		unsigned long p = (unsigned long)v.iov_base;
-		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
-			- p / PAGE_SIZE;
-		if (npages >= maxpages)
-			return maxpages;
-	0;}),({
-		npages++;
-		if (npages >= maxpages)
-			return maxpages;
-	}),({
-		unsigned long p = (unsigned long)v.iov_base;
-		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
-			- p / PAGE_SIZE;
-		if (npages >= maxpages)
-			return maxpages;
-	}),
-	0
-	)
-	return npages;
+		return min(npages, maxpages);
+	}
+	return 0;
 }
 EXPORT_SYMBOL(iov_iter_npages);
 
-- 
2.11.0


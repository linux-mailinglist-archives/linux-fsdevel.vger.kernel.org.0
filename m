Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81C554178
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356911AbiFVEQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356790AbiFVEQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364BB64F2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JV0OnyBdMZZfXf+wleA06sFMCnIGJlM1+pK3Xfzmzao=; b=m3c8SzUOemipZk9cmrmGAqn9Br
        LrXmxxEnQBk7843okcy28/n9gLYhMqmbaGTVei/o6VHo4qdR+dDBmGad0YwNowgMclNVFqGXzlZP4
        BUOn99ejpEi60Gu/LAfc/2YVXpVXwBzP9uelNFV6ZZaaoDh0YS48pCdn9qwZkTqvDl/R5eFV0XVUG
        qAn8TFTIyHOE3tPSXI0qwjTSMe2spiHH00tXic428JLw4qvz/cszzR1LDKhx9pEdOR8fDtjy9OWyh
        Pt9BcbOcp7NpV9BG3DQdibwTFRzcWZCQw1OgozC1bhRXcm89N7lFrZB6yi6JAz/vYHj8zmOqRFfat
        YitQWodw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmW-0035y3-UQ;
        Wed, 22 Jun 2022 04:15:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 26/44] unify pipe_get_pages() and pipe_get_pages_alloc()
Date:   Wed, 22 Jun 2022 05:15:34 +0100
Message-Id: <20220622041552.737754-26-viro@zeniv.linux.org.uk>
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

	The differences between those two are
* pipe_get_pages() gets a non-NULL struct page ** value pointing to
preallocated array + array size.
* pipe_get_pages_alloc() gets an address of struct page ** variable that
contains NULL, allocates the array and (on success) stores its address in
that variable.

	Not hard to combine - always pass struct page ***, have
the previous pipe_get_pages_alloc() caller pass ~0U as cap for
array size.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 49 +++++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5c985cf2858e..1c98f2f3a581 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1187,6 +1187,11 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_gap_alignment);
 
+static struct page **get_pages_array(size_t n)
+{
+	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
+}
+
 static inline ssize_t __pipe_get_pages(struct iov_iter *i,
 				size_t maxsize,
 				struct page **pages,
@@ -1220,10 +1225,11 @@ static inline ssize_t __pipe_get_pages(struct iov_iter *i,
 }
 
 static ssize_t pipe_get_pages(struct iov_iter *i,
-		   struct page **pages, size_t maxsize, unsigned maxpages,
+		   struct page ***pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
 	unsigned int npages, off;
+	struct page **p;
 	size_t capacity;
 
 	if (!sanity(i))
@@ -1231,8 +1237,15 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 
 	*start = off = pipe_npages(i, &npages);
 	capacity = min(npages, maxpages) * PAGE_SIZE - off;
+	maxsize = min(maxsize, capacity);
+	p = *pages;
+	if (!p) {
+		*pages = p = get_pages_array(DIV_ROUND_UP(maxsize + off, PAGE_SIZE));
+		if (!p)
+			return -ENOMEM;
+	}
 
-	return __pipe_get_pages(i, min(maxsize, capacity), pages, off);
+	return __pipe_get_pages(i, maxsize, p, off);
 }
 
 static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
@@ -1394,41 +1407,13 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		return len - *start;
 	}
 	if (iov_iter_is_pipe(i))
-		return pipe_get_pages(i, pages, maxsize, maxpages, start);
+		return pipe_get_pages(i, &pages, maxsize, maxpages, start);
 	if (iov_iter_is_xarray(i))
 		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
 	return -EFAULT;
 }
 EXPORT_SYMBOL(iov_iter_get_pages);
 
-static struct page **get_pages_array(size_t n)
-{
-	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
-}
-
-static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
-		   struct page ***pages, size_t maxsize,
-		   size_t *start)
-{
-	struct page **p;
-	unsigned int npages, off;
-	ssize_t n;
-
-	if (!sanity(i))
-		return -EFAULT;
-
-	*start = off = pipe_npages(i, &npages);
-	n = npages * PAGE_SIZE - off;
-	if (maxsize > n)
-		maxsize = n;
-	else
-		npages = DIV_ROUND_UP(maxsize + off, PAGE_SIZE);
-	*pages = p = get_pages_array(npages);
-	if (!p)
-		return -ENOMEM;
-	return __pipe_get_pages(i, maxsize, p, off);
-}
-
 static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 					   struct page ***pages, size_t maxsize,
 					   size_t *_start_offset)
@@ -1511,7 +1496,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		return len - *start;
 	}
 	if (iov_iter_is_pipe(i))
-		return pipe_get_pages_alloc(i, pages, maxsize, start);
+		return pipe_get_pages(i, pages, maxsize, ~0U, start);
 	if (iov_iter_is_xarray(i))
 		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
 	return -EFAULT;
-- 
2.30.2


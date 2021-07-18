Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740833CCB67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhGRWnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 18:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233930AbhGRWnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 18:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626648007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mRLVDqIiWSn9u2BNYEgGMNs6NaZK7DsbCGe8tMtuVI=;
        b=Th6DUltAsWt0ZRjgy2dF4qROuxOAha7U3jVSOma50VM30vR6sqz6JM2OV2yM/RKR8FwwiD
        v8HP/yBOmI1fWgF7zE4pxaUUYdY2iKjNktFJotrDrr4tTVEsQVouRnIa8NBwU/6OV2e+B7
        QuV5ghpyr+pGpW1C9N9WEh9x0FNa7Ns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-XHO2893sNPeaRVaucOuwnQ-1; Sun, 18 Jul 2021 18:40:03 -0400
X-MC-Unique: XHO2893sNPeaRVaucOuwnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BB991084F57;
        Sun, 18 Jul 2021 22:40:02 +0000 (UTC)
Received: from max.com (unknown [10.40.195.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51AC860C0F;
        Sun, 18 Jul 2021 22:39:56 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 5/6] iov_iter: Introduce ITER_FLAG_FAST_ONLY flag
Date:   Mon, 19 Jul 2021 00:39:31 +0200
Message-Id: <20210718223932.2703330-6-agruenba@redhat.com>
In-Reply-To: <20210718223932.2703330-1-agruenba@redhat.com>
References: <20210718223932.2703330-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new ITER_FLAG_FAST_ONLY flag to indicate to get_user_pages to use
the FOLL_FAST_ONLY flag.  This will cause get_user_pages to fail when it would
otherwise fault in a page.

Currently, the ITER_FLAG_FAST_ONLY flag is only checked in iov_iter_get_pages
and iov_iter_get_pages_alloc.  This is enough for iomaop_dio_rw(), but it may
make sense to check for this flag in other contexts as well.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/uio.h | 15 ++++++++++++---
 lib/iov_iter.c      | 20 +++++++++++++++-----
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 74f819c41735..d3d629c2153a 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -18,6 +18,9 @@ struct kvec {
 };
 
 enum iter_type {
+	/* set if get_user_pages should use FOLL_FAST_ONLY */
+	ITER_FLAG_FAST_ONLY = 2,
+
 	/* iter types */
 	ITER_IOVEC = 4,
 	ITER_KVEC = 8,
@@ -30,8 +33,9 @@ enum iter_type {
 struct iov_iter {
 	/*
 	 * Bit 0 is the read/write bit, set if we're writing.
-	 * Bit 1 is the BVEC_FLAG_NO_REF bit, set if type is a bvec and
-	 * the caller isn't expecting to drop a page reference when done.
+	 * Bit 1 is the ITER_FLAG_FAST_ONLY bit, set if get_user_pages
+	 * should use the FOLL_FAST_ONLY flag when trying to fault in pages
+	 * (only useful for type ITER_IOVEC).
 	 */
 	unsigned int type;
 	size_t iov_offset;
@@ -55,7 +59,7 @@ struct iov_iter {
 
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 {
-	return i->type & ~(READ | WRITE);
+	return i->type & ~(READ | WRITE | ITER_FLAG_FAST_ONLY);
 }
 
 static inline bool iter_is_iovec(const struct iov_iter *i)
@@ -93,6 +97,11 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 	return i->type & (READ | WRITE);
 }
 
+static inline bool iov_iter_is_fast_only(const struct iov_iter *i)
+{
+	return i->type & ITER_FLAG_FAST_ONLY;
+}
+
 /*
  * Total number of bytes covered by an iovec.
  *
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 3beecf8f77de..182ff2afed19 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1538,6 +1538,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
+	unsigned int gup_flags = 0;
+
 	if (maxsize > i->count)
 		maxsize = i->count;
 
@@ -1548,6 +1550,11 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
 
+	if (iov_iter_rw(i) != WRITE)
+		gup_flags |= FOLL_WRITE;
+	if (iov_iter_is_fast_only(i))
+		gup_flags |= FOLL_FAST_ONLY;
+
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
 		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
@@ -1558,9 +1565,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 			len = maxpages * PAGE_SIZE;
 		addr &= ~(PAGE_SIZE - 1);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		res = get_user_pages_fast(addr, n,
-				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0,
-				pages);
+		res = get_user_pages_fast(addr, n, gup_flags, pages);
 		if (unlikely(res < 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
@@ -1665,6 +1670,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
 {
+	unsigned int gup_flags = 0;
 	struct page **p;
 
 	if (maxsize > i->count)
@@ -1677,6 +1683,11 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
 
+	if (iov_iter_rw(i) != WRITE)
+		gup_flags |= FOLL_WRITE;
+	if (iov_iter_is_fast_only(i))
+		gup_flags |= FOLL_FAST_ONLY;
+
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
 		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
@@ -1688,8 +1699,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		p = get_pages_array(n);
 		if (!p)
 			return -ENOMEM;
-		res = get_user_pages_fast(addr, n,
-				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0, p);
+		res = get_user_pages_fast(addr, n, gup_flags, p);
 		if (unlikely(res < 0)) {
 			kvfree(p);
 			return res;
-- 
2.26.3


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2153E2BBFC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgKUOQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:16:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728299AbgKUOQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bw9ipJWjx8AimfhLoz84wN1/imOFmg/xGA0Qomc1kTU=;
        b=XE3kgxLo7vLZ769FdDzmVGibdQRXsPLf1/wWWj2bGULBbrvZK3HyBWQgmqwqzN2JLljChU
        3XteXmPwaIrDL3++hIzKc8ApdD0saUvR2B4k+R/Z1uG6vns3BFtfkurdlrjeqoeeLa2Itl
        QScSm/yz5gqjvd3Asnhl7WIeIKXKzvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-bkI6hkIANsCc6_3NDXBAfg-1; Sat, 21 Nov 2020 09:16:09 -0500
X-MC-Unique: bkI6hkIANsCc6_3NDXBAfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 718DF814409;
        Sat, 21 Nov 2020 14:16:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7B305C22B;
        Sat, 21 Nov 2020 14:16:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/29] iov_iter: Split iov_iter_get_pages()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:16:05 +0000
Message-ID: <160596816579.154728.8100196610696982437.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split iov_iter_get_pages() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5744ddec854f..a2de201b947f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1611,6 +1611,8 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	unsigned int iter_head, npages;
 	size_t capacity;
 
+	if (maxsize > i->count)
+		maxsize = i->count;
 	if (!maxsize)
 		return 0;
 
@@ -1625,19 +1627,14 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, start);
 }
 
-static ssize_t xxx_get_pages(struct iov_iter *i,
+static ssize_t iovec_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
 	if (maxsize > i->count)
 		maxsize = i->count;
 
-	if (unlikely(iov_iter_is_pipe(i)))
-		return pipe_get_pages(i, pages, maxsize, maxpages, start);
-	if (unlikely(iov_iter_is_discard(i)))
-		return -EFAULT;
-
-	iterate_all_kinds(i, maxsize, v, ({
+	iterate_over_iovec(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
 		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
 		int n;
@@ -1653,18 +1650,33 @@ static ssize_t xxx_get_pages(struct iov_iter *i,
 		if (unlikely(res < 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
-	0;}),({
+	0;}));
+	return 0;
+}
+
+static ssize_t bvec_get_pages(struct iov_iter *i,
+		   struct page **pages, size_t maxsize, unsigned maxpages,
+		   size_t *start)
+{
+	if (maxsize > i->count)
+		maxsize = i->count;
+
+	iterate_over_bvec(i, maxsize, v, ({
 		/* can't be more than PAGE_SIZE */
 		*start = v.bv_offset;
 		get_page(*pages = v.bv_page);
 		return v.bv_len;
-	}),({
-		return -EFAULT;
-	})
-	)
+	}));
 	return 0;
 }
 
+static ssize_t no_get_pages(struct iov_iter *i,
+		   struct page **pages, size_t maxsize, unsigned maxpages,
+		   size_t *start)
+{
+	return -EFAULT;
+}
+
 static struct page **get_pages_array(size_t n)
 {
 	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
@@ -2179,7 +2191,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.zero				= iovec_zero,
 	.alignment			= iovec_alignment,
 	.gap_alignment			= iovec_gap_alignment,
-	.get_pages			= xxx_get_pages,
+	.get_pages			= iovec_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
 	.npages				= xxx_npages,
 	.dup_iter			= xxx_dup_iter,
@@ -2213,7 +2225,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.zero				= kvec_zero,
 	.alignment			= kvec_alignment,
 	.gap_alignment			= kvec_gap_alignment,
-	.get_pages			= xxx_get_pages,
+	.get_pages			= no_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
 	.npages				= xxx_npages,
 	.dup_iter			= xxx_dup_iter,
@@ -2247,7 +2259,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.zero				= bvec_zero,
 	.alignment			= bvec_alignment,
 	.gap_alignment			= bvec_gap_alignment,
-	.get_pages			= xxx_get_pages,
+	.get_pages			= bvec_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
 	.npages				= xxx_npages,
 	.dup_iter			= xxx_dup_iter,
@@ -2281,7 +2293,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.zero				= pipe_zero,
 	.alignment			= pipe_alignment,
 	.gap_alignment			= no_gap_alignment,
-	.get_pages			= xxx_get_pages,
+	.get_pages			= pipe_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
 	.npages				= xxx_npages,
 	.dup_iter			= xxx_dup_iter,
@@ -2315,7 +2327,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.zero				= discard_zero,
 	.alignment			= no_alignment,
 	.gap_alignment			= no_gap_alignment,
-	.get_pages			= xxx_get_pages,
+	.get_pages			= no_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
 	.npages				= xxx_npages,
 	.dup_iter			= xxx_dup_iter,



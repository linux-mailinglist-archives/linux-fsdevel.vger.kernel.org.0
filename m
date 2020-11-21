Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5B52BBFD2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgKUOQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:16:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728400AbgKUOQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFapy1GTMY1jnDDBsU1AjiSd9A2Mok+7FVSYnlNcoE0=;
        b=DQAcCDpdU/E7kr+XZIflEI7IWBdQ3D5+8z6YUPYB9jSYpHaiU5WwD1auD5XTMxSMg3zxzJ
        uekSV1XCVUh/C35WaRL3Vc0I57aA9J5K+A3VhtSm2wcrsHerlgYfMYZKBDoijFzDYkKuWZ
        0A8bswZm4MxX6LI2g6ccY6i8DDTdFxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-Jce-_24YOKG1wx3Hb_Vh7g-1; Sat, 21 Nov 2020 09:16:49 -0500
X-MC-Unique: Jce-_24YOKG1wx3Hb_Vh7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DEA51005D6D;
        Sat, 21 Nov 2020 14:16:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 903985C22B;
        Sat, 21 Nov 2020 14:16:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 26/29] iov_iter: Split iov_iter_npages()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:16:44 +0000
Message-ID: <160596820474.154728.13702168133845850499.stgit@warthog.procyon.org.uk>
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

Split iov_iter_npages() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   84 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2f8019e3b09a..d8ef6c81c55f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -2004,50 +2004,80 @@ size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 }
 EXPORT_SYMBOL(hash_and_copy_to_iter);
 
-static int xxx_npages(const struct iov_iter *i, int maxpages)
+static int iovec_npages(const struct iov_iter *i, int maxpages)
 {
 	size_t size = i->count;
 	int npages = 0;
 
 	if (!size)
 		return 0;
-	if (unlikely(iov_iter_is_discard(i)))
-		return 0;
-
-	if (unlikely(iov_iter_is_pipe(i))) {
-		struct pipe_inode_info *pipe = i->pipe;
-		unsigned int iter_head;
-		size_t off;
-
-		if (!sanity(i))
-			return 0;
-
-		data_start(i, &iter_head, &off);
-		/* some of this one + all after this one */
-		npages = pipe_space_for_user(iter_head, pipe->tail, pipe);
-		if (npages >= maxpages)
-			return maxpages;
-	} else iterate_all_kinds(i, size, v, ({
+	iterate_over_iovec(i, size, v, ({
 		unsigned long p = (unsigned long)v.iov_base;
 		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
 			- p / PAGE_SIZE;
 		if (npages >= maxpages)
 			return maxpages;
-	0;}),({
+	0;}));
+	return npages;
+}
+
+static int bvec_npages(const struct iov_iter *i, int maxpages)
+{
+	size_t size = i->count;
+	int npages = 0;
+
+	if (!size)
+		return 0;
+	iterate_over_bvec(i, size, v, ({
 		npages++;
 		if (npages >= maxpages)
 			return maxpages;
-	}),({
+	}));
+	return npages;
+}
+
+static int kvec_npages(const struct iov_iter *i, int maxpages)
+{
+	size_t size = i->count;
+	int npages = 0;
+
+	if (!size)
+		return 0;
+	iterate_over_kvec(i, size, v, ({
 		unsigned long p = (unsigned long)v.iov_base;
 		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
 			- p / PAGE_SIZE;
 		if (npages >= maxpages)
 			return maxpages;
-	})
-	)
+	}));
 	return npages;
 }
 
+static int pipe_npages(const struct iov_iter *i, int maxpages)
+{
+	struct pipe_inode_info *pipe = i->pipe;
+	size_t size = i->count, off;
+	unsigned int iter_head;
+	int npages = 0;
+
+	if (!size)
+		return 0;
+	if (!sanity(i))
+		return 0;
+
+	data_start(i, &iter_head, &off);
+	/* some of this one + all after this one */
+	npages = pipe_space_for_user(iter_head, pipe->tail, pipe);
+	if (npages >= maxpages)
+		return maxpages;
+	return npages;
+}
+
+static int discard_npages(const struct iov_iter *i, int maxpages)
+{
+	return 0;
+}
+
 static const void *xxx_dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 {
 	*new = *old;
@@ -2293,7 +2323,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.gap_alignment			= iovec_gap_alignment,
 	.get_pages			= iovec_get_pages,
 	.get_pages_alloc		= iovec_get_pages_alloc,
-	.npages				= xxx_npages,
+	.npages				= iovec_npages,
 	.dup_iter			= xxx_dup_iter,
 	.for_each_range			= xxx_for_each_range,
 };
@@ -2327,7 +2357,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.gap_alignment			= kvec_gap_alignment,
 	.get_pages			= no_get_pages,
 	.get_pages_alloc		= no_get_pages_alloc,
-	.npages				= xxx_npages,
+	.npages				= kvec_npages,
 	.dup_iter			= xxx_dup_iter,
 	.for_each_range			= xxx_for_each_range,
 };
@@ -2361,7 +2391,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.gap_alignment			= bvec_gap_alignment,
 	.get_pages			= bvec_get_pages,
 	.get_pages_alloc		= bvec_get_pages_alloc,
-	.npages				= xxx_npages,
+	.npages				= bvec_npages,
 	.dup_iter			= xxx_dup_iter,
 	.for_each_range			= xxx_for_each_range,
 };
@@ -2395,7 +2425,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.gap_alignment			= no_gap_alignment,
 	.get_pages			= pipe_get_pages,
 	.get_pages_alloc		= pipe_get_pages_alloc,
-	.npages				= xxx_npages,
+	.npages				= pipe_npages,
 	.dup_iter			= xxx_dup_iter,
 	.for_each_range			= xxx_for_each_range,
 };
@@ -2429,7 +2459,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.gap_alignment			= no_gap_alignment,
 	.get_pages			= no_get_pages,
 	.get_pages_alloc		= no_get_pages_alloc,
-	.npages				= xxx_npages,
+	.npages				= discard_npages,
 	.dup_iter			= xxx_dup_iter,
 	.for_each_range			= xxx_for_each_range,
 };



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A144A2BBFCC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgKUOQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728346AbgKUOQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lc3ApZ/hH2TB+Llf7riKZKHlOr661a/omnTxq1itTBI=;
        b=SPdpu5eX7/brlzdaDogNgWpvdbje45RsQNydzRvz700ne/56AjFXZ8SSNHv2x7pEmQ/8kX
        0Z0GO9ZP5Xh15R2AS4V9bL563/tS9nXrNScPrgDyx3chSzzdKc4LxoZLL3nluMM6qeO4pp
        7RXry6agjafHFv0nxLGzrtJ9w6NxghE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-oHw2WpuYMEmsy3PV_OL-lA-1; Sat, 21 Nov 2020 09:16:33 -0500
X-MC-Unique: oHw2WpuYMEmsy3PV_OL-lA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4F801842165;
        Sat, 21 Nov 2020 14:16:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 175781975F;
        Sat, 21 Nov 2020 14:16:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 24/29] iov_iter: Split csum_and_copy_from_iter_full()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:16:29 +0000
Message-ID: <160596818929.154728.728490523100444099.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split csum_and_copy_from_iter_full() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   62 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1f596cffddf9..8820a9e72815 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1841,20 +1841,16 @@ static size_t no_csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 	return 0;
 }
 
-static bool xxx_csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
+static bool iovec_csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
 	char *to = addr;
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
-		WARN_ON(1);
-		return false;
-	}
 	if (unlikely(i->count < bytes))
 		return false;
-	iterate_all_kinds(i, bytes, v, ({
+	iterate_over_iovec(i, bytes, v, ({
 		next = csum_and_copy_from_user(v.iov_base,
 					       (to += v.iov_len) - v.iov_len,
 					       v.iov_len);
@@ -1863,25 +1859,61 @@ static bool xxx_csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *c
 		sum = csum_block_add(sum, next, off);
 		off += v.iov_len;
 		0;
-	}), ({
+	}));
+	*csum = sum;
+	iov_iter_advance(i, bytes);
+	return true;
+}
+
+static bool bvec_csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
+			       struct iov_iter *i)
+{
+	char *to = addr;
+	__wsum sum;
+	size_t off = 0;
+	sum = *csum;
+	if (unlikely(i->count < bytes))
+		return false;
+	iterate_over_bvec(i, bytes, v, ({
 		char *p = kmap_atomic(v.bv_page);
 		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
 				      p + v.bv_offset, v.bv_len,
 				      sum, off);
 		kunmap_atomic(p);
 		off += v.bv_len;
-	}),({
+	}));
+	*csum = sum;
+	iov_iter_advance(i, bytes);
+	return true;
+}
+
+static bool kvec_csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
+			       struct iov_iter *i)
+{
+	char *to = addr;
+	__wsum sum;
+	size_t off = 0;
+	sum = *csum;
+	if (unlikely(i->count < bytes))
+		return false;
+	iterate_over_kvec(i, bytes, v, ({
 		sum = csum_and_memcpy((to += v.iov_len) - v.iov_len,
 				      v.iov_base, v.iov_len,
 				      sum, off);
 		off += v.iov_len;
-	})
-	)
+	}));
 	*csum = sum;
 	iov_iter_advance(i, bytes);
 	return true;
 }
 
+static bool no_csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
+			       struct iov_iter *i)
+{
+	WARN_ON(1);
+	return false;
+}
+
 static size_t xxx_csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 			     struct iov_iter *i)
 {
@@ -2226,7 +2258,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= iovec_csum_and_copy_from_iter,
-	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
+	.csum_and_copy_from_iter_full	= iovec_csum_and_copy_from_iter_full,
 
 	.zero				= iovec_zero,
 	.alignment			= iovec_alignment,
@@ -2260,7 +2292,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= kvec_csum_and_copy_from_iter,
-	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
+	.csum_and_copy_from_iter_full	= kvec_csum_and_copy_from_iter_full,
 
 	.zero				= kvec_zero,
 	.alignment			= kvec_alignment,
@@ -2294,7 +2326,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= bvec_csum_and_copy_from_iter,
-	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
+	.csum_and_copy_from_iter_full	= bvec_csum_and_copy_from_iter_full,
 
 	.zero				= bvec_zero,
 	.alignment			= bvec_alignment,
@@ -2328,7 +2360,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= no_csum_and_copy_from_iter,
-	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
+	.csum_and_copy_from_iter_full	= no_csum_and_copy_from_iter_full,
 
 	.zero				= pipe_zero,
 	.alignment			= pipe_alignment,
@@ -2362,7 +2394,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= no_csum_and_copy_from_iter,
-	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
+	.csum_and_copy_from_iter_full	= no_csum_and_copy_from_iter_full,
 
 	.zero				= discard_zero,
 	.alignment			= no_alignment,



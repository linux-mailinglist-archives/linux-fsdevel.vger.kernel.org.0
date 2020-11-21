Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418FE2BBFC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgKUOQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728346AbgKUOQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvV2XUFZAv7awKYqds0unEsSCOnFk/jwB0nBnZEA1To=;
        b=J3JmIKqo2Ug/OEEdhBR9Z/zC8iZjUGydK2glhqK1DHGbDeBL/n96KK/ydw3MkE7BD9gTKw
        PsNdIccKCpINnJ6jRUMxzfAAs0JWFhkXxpJ8xJJF7/Qlrl/augfQHy98Q6tkVbAqMLZ2fH
        QRLr44xiJqWi/bfBbjkAI3Yj6W908ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-v2QWFXBSP2q7L4tE7stg2w-1; Sat, 21 Nov 2020 09:16:25 -0500
X-MC-Unique: v2QWFXBSP2q7L4tE7stg2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10F6C1005D65;
        Sat, 21 Nov 2020 14:16:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B6A15D9D7;
        Sat, 21 Nov 2020 14:16:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/29] iov_iter: Split csum_and_copy_from_iter()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:16:21 +0000
Message-ID: <160596818140.154728.302284980617377681.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split csum_and_copy_from_iter() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   56 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a038bfbbbd53..1f596cffddf9 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1777,18 +1777,14 @@ static ssize_t no_get_pages_alloc(struct iov_iter *i,
 	return -EFAULT;
 }
 
-static size_t xxx_csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
+static size_t iovec_csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
 	char *to = addr;
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
-		WARN_ON(1);
-		return 0;
-	}
-	iterate_and_advance(i, bytes, v, ({
+	iterate_and_advance_iovec(i, bytes, v, ({
 		next = csum_and_copy_from_user(v.iov_base,
 					       (to += v.iov_len) - v.iov_len,
 					       v.iov_len);
@@ -1797,24 +1793,54 @@ static size_t xxx_csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum
 			off += v.iov_len;
 		}
 		next ? 0 : v.iov_len;
-	}), ({
+	}));
+	*csum = sum;
+	return bytes;
+}
+
+static size_t bvec_csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
+			       struct iov_iter *i)
+{
+	char *to = addr;
+	__wsum sum;
+	size_t off = 0;
+	sum = *csum;
+	iterate_and_advance_bvec(i, bytes, v, ({
 		char *p = kmap_atomic(v.bv_page);
 		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
 				      p + v.bv_offset, v.bv_len,
 				      sum, off);
 		kunmap_atomic(p);
 		off += v.bv_len;
-	}),({
+	}));
+	*csum = sum;
+	return bytes;
+}
+
+static size_t kvec_csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
+			       struct iov_iter *i)
+{
+	char *to = addr;
+	__wsum sum;
+	size_t off = 0;
+	sum = *csum;
+	iterate_and_advance_kvec(i, bytes, v, ({
 		sum = csum_and_memcpy((to += v.iov_len) - v.iov_len,
 				      v.iov_base, v.iov_len,
 				      sum, off);
 		off += v.iov_len;
-	})
-	)
+	}));
 	*csum = sum;
 	return bytes;
 }
 
+static size_t no_csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
+			       struct iov_iter *i)
+{
+	WARN_ON(1);
+	return 0;
+}
+
 static bool xxx_csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
@@ -2199,7 +2225,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.copy_mc_to_iter		= iovec_copy_mc_to_iter,
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
-	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
+	.csum_and_copy_from_iter	= iovec_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
 	.zero				= iovec_zero,
@@ -2233,7 +2259,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.copy_mc_to_iter		= kvec_copy_mc_to_iter,
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
-	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
+	.csum_and_copy_from_iter	= kvec_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
 	.zero				= kvec_zero,
@@ -2267,7 +2293,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.copy_mc_to_iter		= bvec_copy_mc_to_iter,
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
-	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
+	.csum_and_copy_from_iter	= bvec_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
 	.zero				= bvec_zero,
@@ -2301,7 +2327,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.copy_mc_to_iter		= pipe_copy_mc_to_iter,
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
-	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
+	.csum_and_copy_from_iter	= no_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
 	.zero				= pipe_zero,
@@ -2335,7 +2361,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.copy_mc_to_iter		= discard_copy_to_iter,
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
-	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
+	.csum_and_copy_from_iter	= no_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
 	.zero				= discard_zero,


